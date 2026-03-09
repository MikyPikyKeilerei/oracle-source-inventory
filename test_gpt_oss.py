#!/usr/bin/env python3
"""GPT-OSS 120B Sovereign Testscript fuer WSL.

Usage:
    python test_gpt_oss.py
    python test_gpt_oss.py "Erklaere Oracle Sequences"
    python test_gpt_oss.py --model llama-3-3-70b-sovereign
    python test_gpt_oss.py --compare  # beide Modelle vergleichen
"""
import argparse
import json
import os
import sys
import time

try:
    import requests
except ImportError:
    print("pip install requests")
    sys.exit(1)

API_URL = "https://adesso-ai-hub.3asabc.de/v1/chat/completions"
MODELS = {
    "gpt-oss": "gpt-oss-120b-sovereign",
    "llama": "llama-3-3-70b-sovereign",
}


def get_api_key():
    key = os.environ.get("ADESSO_HUB_KEY")
    if not key:
        env_file = os.path.join(os.getcwd(), ".env")
        if os.path.exists(env_file):
            for line in open(env_file):
                if line.startswith("ADESSO_HUB_KEY="):
                    key = line.strip().split("=", 1)[1].strip('"').strip("'")
    if not key:
        print("ERROR: ADESSO_HUB_KEY nicht gesetzt.")
        sys.exit(1)
    return key


def call_model(model, prompt, api_key, max_tokens=500, temperature=0.7):
    start = time.time()
    resp = requests.post(
        API_URL,
        headers={"Authorization": f"Bearer {api_key}", "Content-Type": "application/json"},
        json={"model": model, "messages": [{"role": "user", "content": prompt}],
              "max_tokens": max_tokens, "temperature": temperature},
        timeout=120,
    )
    duration = time.time() - start

    if resp.status_code != 200:
        return {"error": f"HTTP {resp.status_code}: {resp.text}", "duration": duration}

    data = resp.json()
    usage = data.get("usage", {})
    return {
        "content": data["choices"][0]["message"]["content"],
        "input_tokens": usage.get("prompt_tokens", "?"),
        "output_tokens": usage.get("completion_tokens", "?"),
        "total_tokens": usage.get("total_tokens", "?"),
        "duration": duration,
    }


def print_result(model, result):
    print(f"\n{'='*50}")
    print(f"  {model}")
    print(f"{'='*50}")
    if "error" in result:
        print(f"ERROR: {result['error']}")
        return
    print(result["content"])
    print(f"\n{'─'*50}")
    print(f"  Dauer:   {result['duration']:.2f}s")
    print(f"  Tokens:  {result['input_tokens']} in / {result['output_tokens']} out / {result['total_tokens']} total")
    print(f"  Kosten:  0 USD (gratis)")


def main():
    parser = argparse.ArgumentParser(description="GPT-OSS / Llama Testscript")
    parser.add_argument("prompt", nargs="?",
                        default="Erklaere kurz den Unterschied zwischen Oracle MERGE und INSERT. Max 5 Saetze.")
    parser.add_argument("--model", "-m", default="gpt-oss", choices=list(MODELS.keys()),
                        help="Modell (default: gpt-oss)")
    parser.add_argument("--compare", "-c", action="store_true",
                        help="Beide Modelle mit dem gleichen Prompt vergleichen")
    parser.add_argument("--max-tokens", type=int, default=500)
    parser.add_argument("--temperature", type=float, default=0.7)
    args = parser.parse_args()

    api_key = get_api_key()

    print(f"Prompt: {args.prompt}")

    if args.compare:
        for name, model_id in MODELS.items():
            result = call_model(model_id, args.prompt, api_key, args.max_tokens, args.temperature)
            print_result(f"{name} ({model_id})", result)
    else:
        model_id = MODELS[args.model]
        result = call_model(model_id, args.prompt, api_key, args.max_tokens, args.temperature)
        print_result(f"{args.model} ({model_id})", result)


if __name__ == "__main__":
    main()
