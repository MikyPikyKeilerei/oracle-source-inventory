/*******************************************************************************

Job:              cc_ww_nkcodierung
Beschreibung:     Die Ergebnisse des Mailbandabgleiches und der Bestellanalyse
                  im NK-Codierungsprozess werden hier gespeichert.
          
Erstellt am:        23.11.2018
Erstellt von:       Andrea Gagulic       
Ansprechpartner:    Andrea Gagulic, Stefan Ernstberger    
Ansprechpartner-IT: -

verwendete Tabellen:  sc_ww_nk_kunde 
                      sc_ww_buchung
                      sc_ww_kunde/sc_ww_kunde_ver
                      sc_ww_auftragkopf/sc_ww_auftragkopf_ver
                      sc_ww_bestweg/sc_ww_bestweg_ver
                      sc_ww_auftrag_auftpool/sc_ww_auftrag_auftpool_ver
                      
                      cc_katart
                      cc_art_akt_v
                      cc_marktkz_akt_v
                      cc_ausstattung_dir
                      cc_vtsaison
                      cc_kunde_<vtsaison>
                      cc_vtinfogrp
                      cc_interessentenabwicklungskonto
                      
                      sc_im_tgv_katart_inet/sc_im_tgv_katart_inet_ver
                      sc_im_tgv_aktion/sc_im_tgv_aktion_ver
                      sc_im_tgv_katalogart/sc_im_tgv_katalogart_ver
                      sc_im_tgv_testgruppe/sc_im_tgv_testgruppe_ver
                      sc_im_tgv_ka_tgr_ver
                      improg.tgv_akqui_aktion  !! TODO 
                      improg.tgv_akqui_katalogart  !! TODO
                      improg.tgv_akqui_wkz  !! TODO
                      improg.tgv_akqui_ka_wkz  !! TODO
                      sc_im_adb_abgleich_codeplan_pos/sc_im_adb_abgleich_codeplan_pos_ver
                      if_interessenten_verweiskonto_id    
                      sc_im_tgv_nk0_ver
                                            
                      sc_fu_nkcod_analyse/sc_fu_nkcod_analyse_ver
                      sc_fu_nkcod_fw/sc_fu_nkcod_fw_ver
                      sc_fu_nkcod_default/sc_fu_nkcod_default_ver
                      sc_fu_nkcod_anadetail/sc_fu_nkcod_anadetail_ver
                      sc_fu_nkcod_syn/sc_fu_nkcod_syn_ver                      
                      sc_fu_ecc/sc_fu_ecc_ver
                      sc_fu_ecc_zuordnung/sc_fu_ecc_zuordnung_ver
                      cc_plzref
                      cc_nielsengebiet

                       
Endtabellen:          cc_nkcodierung
                      

Fehler-Doku:      
Ladestrecke:          https://confluence.witt-gruppe.eu/display/IM/Neukundencodierung

********************************************************************************
geändert am:          09.04.2019
geändert von:         Andgag
Änderungen:           ##.1: SA Slowakei eingebaut aus ECC_FUP

geändert am:          13.05.2019
geändert von:         Andgag
Änderungen:           ##.1: Korrektur bei NK0 Ermittlung (SG-Firma verwenden in Cleanse Tabelle)
                      Fehlerkorrektur: In Anlagedat wurde Anldat geschrieben bei Erstbuchungen
                      
geändert am:          24.06.2019
geändert von:         Andgag
Änderungen:           ##.1: Korrektur bei Ermittlung des VFKZ: Kataloge als VF erkennen

geändert am:          26.06.2019
geändert von:         Andgag
Änderungen:           ##.1: Korrektur bei ermittlung des gueltigen, aktiven Mailbandes
                       Performance-Verbesserung bei Zugriff auf sc_ww_buchung durch
                       Temptabelle
                       
geändert am:          19.07.2019
geändert von:         Andgag
Änderungen:           ##.1: MBWKZ/MBIWL bei Codierungsart != 3 setzen

geändert am:          07.08.2019
geändert von:         Andgag
Änderungen:           ##.1: Migriert auf udwh1

geändert am:          12.08.2019
geändert von:         Andgag
Änderungen:           ##.1: WKZ/IWL wird anlweg1 und anlweg2

geändert am:          12.08.2019
geändert von:         Andgag
Änderungen:           ##.1: Konto_id_key eingebaut

geändert am:          13.08.2019
geändert von:         Andgag
Änderungen:           ##.1: Vtinfogruppe ausgebaut

geändert am:          13.08.2019
geändert von:         Andgag
Änderungen:           ##.1: Interessenten-Abwicklungskonto loeschen

geändert am:          13.08.2019
geändert von:         Andgag
Änderungen:           ##.1: Bei shop, nk0 und brand das -KZ entfernt

geändert am:          14.08.2019
geändert von:         Andgag
Änderungen:           ##.1: MBWKZ bei Italien auf -3 gesetzt
                            Prüfung der Referenzauflösung eingebaut.
                            
geändert am:          14.08.2019
geändert von:         Andgag
Änderungen:           ##.1: Anlsaison wird Anlvtsaison
                            Referenzaufloesung eingebaut.
                            Gulivercode1-5 aus letzter Cleanse und Endtabelle entfernt
                            
geändert am:          16.08.2019
geändert von:         Andgag
Änderungen:           ##.1: Referenzaufloesung Brand und NK0 eingebaut.
                      Ermittlung vfherkunft und gulivercode (aus 5 Merges einen gemacht)
                      Referenzaufloesungen mit cc_firma eingebaut bei SYN
                      
geändert am:          22.08.2019
geändert von:         Andgag
Änderungen:           ##.1: Join ueber EKSAISON eingebaut bei allen Anlauftoepfen, 
                            ausser Internet

geändert am:          10.09.2019
geändert von:         steern
Änderungen:           Bei Mediaumcodierung hat für die Ausländer das Setzen des
                      Nielsengebiets nicht gegriffen und somit hat die Umcodierung
                      auch nicht funktioniert
                      --> COALESCE bzw. NVL umgebaut
                      
geändert am:          16.09.2019
geändert von:         andgag
                      konto_id eingebaut.
                      Endtabelle parametrisiert für evtl. Nachladungen 
                      (cc_nkcodierung/cc_nkcodkorr)
                      
geändert am:          19.09.2019
geändert von:         andgag
                      Identifizierung von VF-Artikeln auch ueber mkz.verd1bez2
                      
geändert am:          19.09.2019
geändert von:         andgag
                      Default-FUP wurde auf udwh1 umgezogen
                      
geändert am:          23.09.2019
geändert von:         andgag
                      Analyse-FUP wurde auf udwh1 umgezogen
                      Syn-FUP wurde umgezogen
                      
geändert am:          26.09.2019
geändert von:         andgag
                      Analyse-FUP wurde auf udwh1 umgezogen
                      Anlcode-FUP wurde umgezogen
                      AnalyseDetail-FUP wurde umgezogen
                      
geändert am:          02.10.2019
geändert von:         andgag
                      Bestellananlyse DK
                      Bei Katalog-Formlosen nochmal schauen, 
                      ob sie eine gueltig ERSTWKZ/ERSTIWL haben, 
                      dann diese verwenden.
                      
geändert am:          07.10.2019
geändert von:         andgag
                      Bestellanalyse Anzeigen eingebaut inkl. Detailbestellanalyse
                      
geändert am:          09.10.2019
geändert von:         andgag
                      Ausstattungsview von udwh1 verwenden.
                      
geändert am:          11.10.2019
geändert von:         andgag
                      Bestellanalyse aus Detail FUP auch bei Direktkatalogen 
                      zulassen (Nkcodierungsart = 24)
                      
geändert am:          23.10.2019
geändert von:         andgag
                      Bei Join Buchungsdaten mit FUP-Daten für Direktkataloge 
                      zusätzlich Join der Einkaufssaison eingebaut.
                      
geändert am:          24.10.2019
geändert von:         andgag
                      Bei ermitteln der Katalogarten zum Mailband auch 
                      die Beilagen aus TGV ermitteln.
                      
geändert am:          30.10.2019
geändert von:         andgag
                      ANLECC eingebaut für Basisreporting
                      
geändert am:          31.10.2019
geändert von:         andgag
                      Falsche WKZ verwendet beim Abgleich ADB mit TGV
                      Korrektur.
                      
geändert am:          18.11.2019
geändert von:         andgag
                      Nkcodierungsart 23 wurde versehentlich für 2 Fälle verwendet
                       (DK ohne Mailbandtreffer aber gueltige Erstwkz/Erstiwl)
                        und 
                       (schriftl. Anzeigen mit ungueltiger Erstwkz/Erstiwl)
                      Dadurch hat Anzeigen Bestellanalyse die DK ueberschrieben.
                       (nur Italien betroffen)
                      --> Lösung: Für Anzeigen wurde NKcodierungsart 25 eingefuehrt.
                      
geändert am:          02.12.2019
geändert von:         andgag
                      Join bei Aussteuerung überarbeitet. Zu viele Treffer gefunden
                      
geändert am:          09.12.2019
geändert von:         andgag
                      MBWKZ bei Nkcodierungsart != 3, Coalesce eingebaut, 
                      letztes gültiges Mailband verwenden mit GREATEST
                      
geändert am:          11.12.2019
geändert von:         andgag
                      USA Cross Border ausgeschlossen
                      
geändert am:          17.12.2019
geändert von:         andgag
                      MBWKZ/MBIWL Default Wert überschreibt auch 999/999
                      
                      Daten aus sc_ww_stammattr (manuelle Umcodierung) in CC_NKCODIERUNG einspielen
                      
geändert am:          30.12.2019
geändert von:         andgag
                      ANLCODEPRIO-Verschiebung durch Einbau des Anlaufweges Teleshopping.
                      Ab FS20: TV        NEU: ist Anlcodeprio = 5
                               Internet  Bis 219: Anlcodeprio = 5, Ab 120 Anlcodprio = 6
                               Folo      Bis 219: Anlcodeprio = 6, Ab 120 Anlcodprio = 7
                               
geändert am:          02.01.2020
geändert von:         andgag
                      Anlweg Teleshopping eingebaut
                      
geändert am:          08.01.2020
geändert von:         andgag
                      Automatischer Insert in nkcodierung nur bei Aenderungen durchfuehren
                      (Evtl. wurde durch eine Umcodierung schon Aenderungen in der cc_nkcodierung vorgenommen,
                       dann nicht mehr mit NKCOdierungsart = 26 ueberschreiben)
                       
geändert am:          17.01.2020
geändert von:         andgag
                      Bei Einschraenkung auf Firmen in Parameter 7 (z.B. bei nachtraeglichen Umcodierungen)
                      restliche Firmen aus Cleanse1 rauswerfen
                      
geändert am:          27.05.2020
geändert von:         andgag
                      Direktversand: Beim Join hat Umssaison gefehlt,
                      hat Probleme bei Zweitversand verursacht falls 2 Treffer
                      (cleanse8)

geändert am:          03.06.2020
geändert von:         andgag
                      Wäschepur-Weichen eingebaut
                      
geändert am:          16.06.2020
geändert von:         andgag
                      Wäschepur-Sonderbehandlung muss teilweise noch beibehalten werden
                       Zugriff auf Altdaten aus sc_ww_buchung
                       
geändert am:          17.06.2020
geändert von:         andgag
                      Bei Zugriff auf sc_ww_buchung immer auf anspr > 0 einschraenken
                      
geändert am:          14.05.2021
geändert von:         andgag
                      heinewkz und heineiwl eingebaut
                      
geändert am:          17.05.2021
geändert von:         andgag
                      Heine Firmen nicht mehr ausschliessen
                      
geändert am:          28.06.2021
geändert von:         andgag
                      GrundrauschenTest Ausschluss
                      
geändert am:          20.07.2021
geändert von:         andgag
                      Anlcode Ermittlung stabiler gebaut.                       

geändert am:          30.08.2021
geändert von:         steern
                      heine CH und NL wird beruecksichtigt
                      
geändert am:          09.09.2021
geändert von:         andgag
                      Cleanse Tabellen wieder korrekt benamst
                      
geändert am:          14.09.2021
geändert von:         andgag
                      Heine CH war noch ausgeschlossen. Korrigiert.
                      
geändert am:          21.09.2021
geändert von:         andgag
                      Heine Frankreich ausschliessen
                      
geändert am:          14.12.2021
geändert von:         andgag
                      Priorisierung bei Mailbaendern erweitert.
                      gueltig_von wird berücksichtigt (PAL)
                      (Problem bei Erst-/Zweitversand)
                      
                      Bei verspäteter Erstbestellung MB-Treffer aus sc_ww_nk_kunde
                      dazuspielen, statt aus Endtabelle, da es da Lücken gab.
                      
geändert am:          15.12.2021
geändert von:         andgag
                      Fehlerkorrektur bei MBWKZ umd WKZ ermittlung

                      
geändert am:          19.02.2022
geändert von:         steern
                      DISTINCT eingebaut bei 16.2 - Kunde ist doppelt in der SC_WW_NEUKUNDE drin
                      
geändert am:          24.05.2022
geändert von:         steern
                      Bug beim Setzen der MBWKZ, wenn NKCODIERUNGSART != 3 ("_" hat gefehlt im String)

geändert am:          13.06.2022
geändert von:         andgag
                      sc_im_adb_abgleich_codeplan_pos statt sc_im_adb_abgl_cd verwenden.
                      
geändert am:          13.07.2022
geändert von:         andgag
                      sc-Objekte statt ADB-Objekte von WGD verwenden

geändert am:          19.01.2023
geändert von:         carkah
                      loader.nk0_ref_tgv durch sc_im_tgv_nk0_ver ersetzt

geändert am:          20.03.2023
geändert von:         steern
                      GUTSCHNR aus GUTSCHDATEN wird jetzt herangezogen, da genauere Werte


geändert am:          30.05.2023
geändert von:         steern
                      DISTINCT eingebaut bei Guliver-Formlosen-Merge, da doppelte Eintraege                       

geändert am:          13.06.2023
geändert von:         benlin
                      Tabelle sc_im_tgv_katart_inet ersetzt durch cc_katart 

geändert am:          05.08.2023
geändert von:         joeabd
                      18.6, 19.: Firma in Subselect entfernt, da sonst nicht eindeutig
                      (wäschepur-Problematik)
                      
geändert am:          07.08.2023
geändert von:         andgag
                      Zuordnung der MBWKZ/IWL bei Nkcodierungsart != 3:
                      COALESCE eingebaut
                      
geändert am:          29.08.2023
geändert von:         andgag
                      Katalzusteuerungen werden bei Ermittlung des Shopkz 
                      als Neutral gewertet (weder Print noch Shop)

geändert am:          10.10.2023
geändert von:         steern
                      Anlcode-Fix eingebaut, falls Umcodierungen laufen sollten.
                      
geändert am:          08.11.2023
geändert von:         benlin
                      Spalte AUFTRPOSIDENTNR ausgebaut
                      
geändert am:          06.12.2023
geändert von:         andgag
                      Bei Gueltigkeitsermittlung der Mailbaender PLSQL Block
                      eingebaut und Sonderfall für alte Wäschepur NK
                      
geändert am:          11.12.2023
geändert von:         andgag
                      Deaktivierte Witt-Konten werden bei Anlauf nicht ausgesteuert
                      
geändert am:          29.11.2023
geändert von:         andgag
                      Nkcodierungsart 28 eingebaut: Gutschein ohne Ware
                      
geändert am:          16.01.2024
geändert von:         andgag
                      plz_ref und nielsengebiet ersetzt durch udwh1-Objekt     
                      
geändert am:          30.01.2024
geändert von:         andgag
                      Package pkg_im_zeit verwenden

geändert am:          20.06.2024
geändert von:         steern
                      Bugfix Firma beim STAMMATTR-INSERT -> CC vs SG Problem.
                      
geändert am:          07.08.2024
geändert von:         andgag
                      Laufzeitprobleme. Ueber Temporaertabelle 7a geloest 
                      An mehreren Stellen Subselect durch zusätliche Cleanse-
                      Tabellen gelöst 4a, 4b. Package-Aufrufe entfernt
                      bzw nur noch an einzelne unkritischen Stellen verwendet.

geändert am:          09.09.2024
geändert von:         steern
                      PROMPT 24.3 Bei VF-ohne-Ware-FP (NK1 und NK0) eingebaut
                      
geändert am:          08.09.2025
geändert von:         andgag
                      Sheegowkz aus ECC_FUP holen                      
*******************************************************************************/

-- HINWEIS ZUR Wäschepur Integration:
-- Innerhalb der Saison 1/20 muss das Script mit der Weiche laufen
-- Script wird für tägliche Ladung und Nachladungsumcodierungen verwendet. Muss
-- in beiden Faellen in Abhängigkeit vom Prozessdatum funktinieren.

ALTER SESSION ENABLE PARALLEL DML;

PROMPT =========================================================================
PROMPT Parameter
PROMPT  GBV-Job ID:                           &gbvid
PROMPT  Prozessdatum                          &datum
PROMPT  Prozessdatum hh24:mm:ss               &termin
PROMPT  Vertriebssaison:                      &vtsaison
PROMPT  Vertriebssaison + 1:                  &vtsaisonp1
PROMPT  Endtabelle:                           &6
PROMPT  Optional Einschraenkung auf Firma     &7
PROMPT  (0, wenn keine Einschraenkung greifen soll)
PROMPT  HJAnfang                              &hjanfang
PROMPT =========================================================================

DEFINE endtabelle = &6


PROMPT 1. Tages-Neukunden einfuegen
PROMPT ******************************

TRUNCATE TABLE clcc_ww_nkcodierung_1;



PROMPT 1.1 Alle Kunden, die zum MB-Abgleich gegeben wurden (Anlagedatum=SYSDATE)
PROMPT =========================================================================

INSERT /*+ APPEND */INTO clcc_ww_nkcodierung_1 
(
    dwh_cr_load_id,
    konto_id_key,
    firma, 
    anlagedat,
    erstwkz, 
    erstiwl,
    mbwkz_1, 
    mbiwl_1,
    mbwkz_2, 
    mbiwl_2,
    mbwkz_3, 
    mbiwl_3,
    mbwkz_4, 
    mbiwl_4,
    mbwkz_5, 
    mbiwl_5,
    mbwkz_6, 
    mbiwl_6,
    mbwkz_7, 
    mbiwl_7,
    mbwkz_8, 
    mbiwl_8,
    mbwkz_9, 
    mbiwl_9,
    mbwkz_10, 
    mbiwl_10,
    mbwkz_11, 
    mbiwl_11,
    mbwkz_12, 
    mbiwl_12,
    shop,
    analysekz
)
(
 SELECT
  &gbvid,
  ve.konto_id_key,
  ve.firma, 
  ve.anlaufdat AS anlagedat,
  ve.wkz AS erstwkz,
  ve.iwl AS erstiwl,
  mb.wkz_1,
  mb.iwl_1,
  mb.wkz_2,
  mb.iwl_2,
  mb.wkz_3,
  mb.iwl_3,
  mb.wkz_4,
  mb.iwl_4,
  mb.wkz_5,
  mb.iwl_5,
  mb.wkz_6,
  mb.iwl_6,
  mb.wkz_7,
  mb.iwl_7,
  mb.wkz_8,
  mb.iwl_8,
  mb.wkz_9,
  mb.iwl_9,
  mb.wkz_10,
  mb.iwl_10,
  mb.wkz_11,
  mb.iwl_11,
  mb.wkz_12,
  mb.iwl_12,
  0,
  1
FROM sc_ww_kunde_ver ve
JOIN sc_ww_kunde ko ON (ko.dwh_id = ve.dwh_id_head AND ko.dwh_cr_load_id = ve.dwh_cr_load_id)  -- beim ersten Einbuchen des Datensatzes
JOIN sc_ww_kundenfirma fak ON (fak.id = ve.kundenfirmaid)
JOIN sc_ww_kundenfirma_ver fav ON (fav.dwh_id_head = fak.dwh_id AND &termin BETWEEN fav.dwh_valid_from and fav.dwh_valid_to)
LEFT OUTER JOIN sc_ww_nk_kunde mb ON (mb.konto_id_key = ve.konto_id_key AND mb.loaddat = &datum)
WHERE fav.kdfirmkz NOT IN (
                         16,   --sieh an Frankreich
                         7,    --witt Frankreich
                         24,   --heine Frankreich                         
                         69)   --Russland                          
AND TRUNC(ve.dwh_valid_from) = &datum
AND fav.kdfirmkz != 44);

COMMIT;




PROMPT 1.2 Heute Erstbuchungen fuer alle Firmen ausser Witt-Waepu 
PROMPT (Sind evtl. schon in cc_nkcodierung vorhanden, bekommen aber nun die Bestellananlyse und damit WKZ/IWL)
PROMPT =========================================================================================================

-- WPEXTRA: Hier darf Witt und Wäpu wieder rein, keine Sonderbehandlung mehr


PROMPT 1.2.1 In clcc_ww_nkcodierung_7 Kunden sammeln, die heute Erstbuchung haben, aber noch nicht in der CC_KUNDE angekommen sind.
PROMPT ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


TRUNCATE TABLE clcc_ww_nkcodierung_7a;

INSERT /*+ APPEND */ INTO clcc_ww_nkcodierung_7a
  (
     dwh_cr_load_id,
     firma,
     konto_id_key
   )
SELECT 
     &gbvid AS dwh_cr_load_id,
     firma, konto_id_key
FROM 
(
SELECT
       firma,
       konto_id_key
    FROM sc_ww_buchung 
    WHERE buchungsdatum = &datum
    AND ansprachen > 0
       MINUS
    SELECT
       CASE WHEN fa.sg = 68 THEN 18 ELSE fa.sg END, 
       ku.konto_id_key
    FROM cc_kunde_&vtsaison ku
    JOIN cc_firma_akt_v fa ON (fa.wert = ku.firma)
    WHERE &termin BETWEEN ku.dwh_valid_from AND ku.dwh_valid_to
    AND ku.anldat IS NOT NULL
);
    
COMMIT;


TRUNCATE TABLE clcc_ww_nkcodierung_7;

INSERT /*+ APPEND */ INTO clcc_ww_nkcodierung_7 cl7
(
  dwh_cr_load_id,
  konto_id_key,
  firma,
  anlagedat,
  anldat,
  erstwkz,
  erstiwl
)
   SELECT 
    &gbvid,
    ve.konto_id_key,
    fav.kdfirmkz AS firma,
    ve.anlaufdat AS anlagedat,    
    &datum,
    ve.wkz,
    ve.iwl
   FROM sc_ww_kunde_ver ve
   JOIN sc_ww_kunde ko ON (ko.dwh_id = ve.dwh_id_head)
   JOIN sc_ww_kundenfirma fak ON (fak.id = ve.kundenfirmaid)
   JOIN sc_ww_kundenfirma_ver fav ON (fav.dwh_id_head = fak.dwh_id AND &termin between fav.dwh_valid_from and fav.dwh_valid_to)
   --WHERE fav.kdfirmkz = 21
   WHERE fav.kdfirmkz NOT IN (
                         16,   --Frankreich
                         7,    --Frankreich
                         24,   --Heine Frankreich
                         69)   --Russland
   AND &termin BETWEEN ve.dwh_valid_from AND ve.dwh_valid_to
   AND (fav.kdfirmkz, ve.konto_id_key) IN
  (
    SELECT
       firma,
       konto_id_key
    FROM clcc_ww_nkcodierung_7a  
   );

COMMIT;


PROMPT 1.2.2 Interessentenbuchungen ausschliessen
PROMPT +++++++++++++++++++++++++++++++++++++++++++++++++

DELETE FROM clcc_ww_nkcodierung_7 
WHERE (konto_id_key, firma) IN 
   (SELECT 
      konto_id_key, 
      fir.sg AS firma
    FROM cc_interessentenabwicklungskonto kto 
    JOIN cc_firma_akt_v fir ON (fir.wert = kto.firma)
    WHERE kto.dwh_status = 1);
      
COMMIT;


PROMPT 1.2.3 Uebrige Buchungen einfuegen 
PROMPT ++++++++++++++++++++++++++++++++++

MERGE INTO clcc_ww_nkcodierung_1 cl1
USING clcc_ww_nkcodierung_7 cl7
ON (cl7.konto_id_key = cl1.konto_id_key)
WHEN NOT MATCHED THEN
  INSERT   
(
    cl1.dwh_cr_load_id,
    cl1.konto_id_key,    
    cl1.firma,
    cl1.loaddat,
    cl1.anlagedat,
    cl1.analysekz,
    cl1.erstwkz,
    cl1.erstiwl
)
VALUES
(
    cl7.dwh_cr_load_id,
    cl7.konto_id_key,    
    cl7.firma,
    &datum,
    cl7.anlagedat,
    2,
    cl7.erstwkz,
    cl7.erstiwl
);

COMMIT;


PROMPT 1.2.4 Hier bei Einschraenkung auf Firmen alle anderen rauswerfen
PROMPT +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

DELETE FROM clcc_ww_nkcodierung_1
WHERE firma NOT IN (&7)
AND '&7' != '0';

COMMIT;



PROMPT 1.2.5 Statistiken erstellen
PROMPT ++++++++++++++++++++++++++++

EXEC PKG_STATS.GATHERTABLE(user,'clcc_ww_nkcodierung_1');


PROMPT 2. Mailband-Treffer dazuspielen (fand schon in der Vergangenheit statt und wurde gespeichert)
PROMPT ***************************************************************************************************************

MERGE INTO clcc_ww_nkcodierung_1 cl1
USING
  (      
     SELECT 
         konto_id_key,         
         wkz_1, iwl_1, 
         wkz_2, iwl_2,
         wkz_3, iwl_3,
         wkz_4, iwl_4,
         wkz_5, iwl_5,
         wkz_6, iwl_6,
         wkz_7, iwl_7,
         wkz_8, iwl_8,
         wkz_9, iwl_9,
         wkz_10, iwl_10,
         wkz_11, iwl_11,
         wkz_12, iwl_12,
         loaddat
     FROM
     (
     SELECT
         konto_id_key,         
         wkz_1, iwl_1, 
         wkz_2, iwl_2,
         wkz_3, iwl_3,
         wkz_4, iwl_4,
         wkz_5, iwl_5,
         wkz_6, iwl_6,
         wkz_7, iwl_7,
         wkz_8, iwl_8,
         wkz_9, iwl_9,
         wkz_10, iwl_10,
         wkz_11, iwl_11,
         wkz_12, iwl_12,
         loaddat,
         row_number() over
         (partition by konto_id_key order by loaddat) counter
      FROM sc_ww_nk_kunde   
      WHERE konto_id_key != '0'   
       )
    WHERE counter = 1
   ) nkkunde   
  ON (nkkunde.konto_id_key = cl1.konto_id_key)
WHEN MATCHED THEN
  UPDATE SET
    cl1.mbwkz_1 = nkkunde.wkz_1,
    cl1.mbiwl_1 = nkkunde.iwl_1,
    cl1.mbwkz_2 = nkkunde.wkz_2,
    cl1.mbiwl_2 = nkkunde.iwl_2,
    cl1.mbwkz_3 = nkkunde.wkz_3,
    cl1.mbiwl_3 = nkkunde.iwl_3,
    cl1.mbwkz_4 = nkkunde.wkz_4,
    cl1.mbiwl_4 = nkkunde.iwl_4,
    cl1.mbwkz_5 = nkkunde.wkz_5,
    cl1.mbiwl_5 = nkkunde.iwl_5,
    cl1.mbwkz_6 = nkkunde.wkz_6,
    cl1.mbiwl_6 = nkkunde.iwl_6,
    cl1.mbwkz_7 = nkkunde.wkz_7,
    cl1.mbiwl_7 = nkkunde.iwl_7,
    cl1.mbwkz_8 = nkkunde.wkz_8,
    cl1.mbiwl_8 = nkkunde.iwl_8,
    cl1.mbwkz_9 = nkkunde.wkz_9,
    cl1.mbiwl_9 = nkkunde.iwl_9,
    cl1.mbwkz_10 = nkkunde.wkz_10,
    cl1.mbiwl_10 = nkkunde.iwl_10,
    cl1.mbwkz_11 = nkkunde.wkz_11,
    cl1.mbiwl_11 = nkkunde.iwl_11,
    cl1.mbwkz_12 = nkkunde.wkz_12,
    cl1.mbiwl_12 = nkkunde.iwl_12,
    cl1.shop = 0
WHERE analysekz = 2;
  
COMMIT;



PROMPT 3. Freundschaftswerbungskunden kennzeichnen (Vorgabe aus Aussteuerungs-FUP)
PROMPT *****************************************************************************

-- Weiche bis Saisonenede drin lassen wegen Umcodierungen
-- Im FUP steht ab 03.06 Firma 18 drin.
--       Umstellung am 05.06
--       04.06.: Firma 68 kommt --> 18 join mit 18, 18er sollen eigentlich noch nicht kommen
--       05.06.: Firma 18 kommt --> 18 join mit 18, 68er kommen nicht mehr

MERGE INTO clcc_ww_nkcodierung_1 cl
USING
  (
   SELECT DISTINCT
     konto_id_key, 
     clcc.firma
   FROM clcc_ww_nkcodierung_1 clcc
   JOIN sc_fu_nkcod_fw k ON (clcc.firma = k.firma AND vtsaison = &vtsaison)
   JOIN sc_fu_nkcod_fw_ver ver ON (
                                   ver.dwh_id_head = k.dwh_id
                                   AND ver.dwh_valid_to = TO_DATE('31.12.9999','dd.mm.yyyy')
                                   AND clcc.erstwkz BETWEEN ver.wkzvon AND ver.wkzbis
                                   AND clcc.erstiwl BETWEEN ver.iwlvon AND ver.iwlbis
                                   )
    WHERE k.anlcode = 10
  MINUS    -- Deaktivierte Witt-Konten werden nicht ausgesteuert, falls sie jetzt anlaufen
    SELECT konto_id_key, firma
    FROM cc_kunde_&vtsaison
    WHERE &termin -0.5 BETWEEN dwh_valid_from AND dwh_valid_to
    AND firma = 1
    AND vtinfogrp = 801
   ) x
   ON (x.konto_id_key = cl.konto_id_key)
   WHEN MATCHED THEN
     UPDATE SET
    cl.codierungsart = 1,
    cl.anlcode = 10,
    cl.wkz = cl.erstwkz,
    cl.iwl = cl.erstiwl;

COMMIT;



PROMPT 4. Stationaerkunden, Personal und sonstiges kennzeichnen (Vorgabe aus Aussteuerungs-FUP)
PROMPT ****************************************************************************************

MERGE INTO clcc_ww_nkcodierung_1 cl
USING
  (
   SELECT DISTINCT
     konto_id_key, 
     clcc.firma 
   FROM clcc_ww_nkcodierung_1 clcc
   JOIN sc_fu_nkcod_fw k ON (clcc.firma = k.firma AND vtsaison = &vtsaison)
   JOIN sc_fu_nkcod_fw_ver ver ON (
                                   ver.dwh_id_head = k.dwh_id
                                   AND ver.dwh_valid_to = TO_DATE('31.12.9999','dd.mm.yyyy')
                                   AND clcc.erstwkz BETWEEN ver.wkzvon AND ver.wkzbis
                                   AND clcc.erstiwl BETWEEN ver.iwlvon AND ver.iwlbis
                                   )
   WHERE k.anlcode = 70
     MINUS   -- Deaktivierte Witt-Konten werden nicht ausgesteuert, falls sie jetzt anlaufen
  SELECT konto_id_key, firma
  FROM cc_kunde_&vtsaison
  WHERE &termin -0.5 BETWEEN dwh_valid_from AND dwh_valid_to
  AND firma = 1
  AND vtinfogrp = 801   
   ) x
   ON (x.konto_id_key = cl.konto_id_key)
   WHEN MATCHED THEN
     UPDATE SET
    cl.codierungsart = 1,
    cl.anlcode = 70,
    cl.wkz = cl.erstwkz,
    cl.iwl = cl.erstiwl;
    
COMMIT;



PROMPT 5. Bestellanalyse vorbereiten
PROMPT *******************************

PROMPT 5.1 Relevantes Erstbuchungsdatum ermitteln
PROMPT ==============================================

PROMPT 5.1.1 Bei allen Firmen ausser Witt und Waeschepur zaehlt auch ein Auftrag, der nur VF-Artikel enthaelt
PROMPT +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

PROMPT 5.1.1.1 In clcc_ww_nkcodierung_11 nur relevante Datensaetze aus der sc_ww_buchung abspeichern (bessere Laufzeit wegen kleinerer Datenmenge bei Folgestatement)
PROMPT --------------------------------------------------------------------------------------------------------------------------------------------------------------

TRUNCATE TABLE clcc_ww_nkcodierung_11;

INSERT /*+ APPEND */ INTO clcc_ww_nkcodierung_11
  (dwh_cr_load_id,
   konto_id_key,
   firma, 
   katalogart,
   artikelnr,
   umsatzsaison,
   buchungsdatum
   )
  SELECT 
   &gbvid,
   konto_id_key,
   firma,
   katalogart,
   artikelnr,
   umsatzsaison,
   buchungsdatum
  FROM sc_ww_buchung
  WHERE (konto_id_key) IN
   (
     SELECT DISTINCT
       konto_id_key
       FROM clcc_ww_nkcodierung_1
  )
  AND ansprachen > 0;

COMMIT;



PROMPT 5.1.1.2 In clcc_ww_nkcodierung_4 alle Kunden aus Cleanse 1 mit dem Datum ihrer ersten Bestellung einfuegen (hier noch kein Bestellzaehler verfuegbar) OHNE WITT/WAEPU
PROMPT -----------------------------------------------------------------------------------------------------------------------------------------------------

TRUNCATE TABLE clcc_ww_nkcodierung_4;

-- WPEXTRA: Witt und Wäschepur wieder rein, keine Sonderbehandlung mehr

INSERT /*+ APPEND */ INTO clcc_ww_nkcodierung_4
(
   dwh_cr_load_id,
   konto_id_key,
   firma, 
   erstbuchdat)
SELECT
   &gbvid, 
   cl.konto_id_key,
   sc.firma,
   MIN(sc.buchungsdatum) AS buchdat 
FROM clcc_ww_nkcodierung_1 cl
JOIN clcc_ww_nkcodierung_11 sc ON (sc.firma = cl.firma 
                           AND sc.konto_id_key = cl.konto_id_key 
                           AND sc.buchungsdatum >= TRUNC(cl.anlagedat)
                           AND sc.buchungsdatum <= &datum)
WHERE cl.firma NOT IN (1,18)
GROUP BY 
   cl.konto_id_key,
   sc.firma;
   
COMMIT;


PROMPT 5.1.2 Bei Witt und Waeschepur werden VF Artikel ausgeschlossen (Sonderthema Witt-Waepu VF-Sonderbehandlung) -- muss bleiben wegen Altdaten-Trennung in sc_ww_buchung
PROMPT +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- WPEXTRA: Witt und Wäschepur keine Sonderbehandlung mehr

PROMPT 5.1.2.1 In clcc_ww_nkcodierung_10 nur relevante Datensaetze aus der sc_ww_buchung abspeichern (bessere Laufzeit wegen kleinerer Datenmenge bei Folgestatement)
PROMPT --------------------------------------------------------------------------------------------------------------------------------------------------------------

-- WPEXTRA: Witt und Wäschepur keine Sonderbehandlung mehr

TRUNCATE TABLE clcc_ww_nkcodierung_10;

INSERT /*+ APPEND */ INTO clcc_ww_nkcodierung_10
  (dwh_cr_load_id,
   konto_id_key,
   firma, 
   katalogart,
   artikelnr,
   umsatzsaison,
   buchungsdatum
   )
  SELECT 
   &gbvid,
   konto_id_key,
   firma,
   katalogart,
   artikelnr,
   umsatzsaison,
   buchungsdatum
  FROM sc_ww_buchung
  WHERE (konto_id_key) IN
   (SELECT DISTINCT konto_id_key 
    FROM clcc_ww_nkcodierung_1 
    WHERE firma IN (1,18)
   )
  AND firma IN (1,18)
  AND ansprachen > 0;
  

COMMIT;



PROMPT 5.1.2.2 Statistiken erstellen
PROMPT -----------------------------

EXEC PKG_STATS.GATHERTABLE('udwh1','clcc_ww_nkcodierung_10');


PROMPT 5.1.2.2 In clcc_ww_nkcodierung_4 alle Kunden aus Cleanse 1 mit dem Datum ihrer ersten Bestellung einfuegen (hier noch kein Bestellzaehler verfuegbar) WITT und WAEPU
PROMPT --------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- WPEXTRA: Witt und Wäschepur fist immer noch Sonderfall: Bei Zugriff auf sc_ww_buchung muss vor Umstellungszeitpunkt noch getrennt werden und danach nicht mehr.


-- hier laufzeitoptimierung 07.08.2024 (Package Aufrufe ausgebaut) und Verwendung der neuen Cleansetabelle 4a und 4b

TRUNCATE TABLE clcc_ww_nkcodierung_4a;

INSERT /*+ APPEND */ INTO clcc_ww_nkcodierung_4a
(
  dwh_cr_load_id,
  artnr,
  eksaison,
  vfkz
)  
SELECT   distinct &gbvid,
          artnr, 
          eksaison,  
          CASE WHEN mkz.verd1bez1 = 'VF-Artikel'  THEN 1 
           WHEN mkz.verd1bez2 = 'VF-Artikel / Sonstiges' THEN 1          
           WHEN SUBSTR(wgrpkt.sg, -4) = '73-6' THEN 1
          ELSE 0 END AS vfkz
       FROM cc_art_akt_v art
       JOIN cc_marktkz_akt_v mkz ON (mkz.wert = art.marktkz)
       JOIN cc_wagrpkt_akt_v wgrpkt ON (wgrpkt.wert = art.wagrpkt);
       
COMMIT;


TRUNCATE TABLE clcc_ww_nkcodierung_4b;

INSERT /*+ APPEND */ INTO clcc_ww_nkcodierung_4b
(
  dwh_cr_load_id,
  katalogart,
  umsatzsaison
)  
SELECT  DISTINCT 
    &gbvid, 
    katalogart, 
    umsatzsaison
FROM clcc_ww_nkcodierung_10;
       
COMMIT;

-- Packageaufruf hier nur noch einmal. Unten wird die Cleanstabelle verwendet.

UPDATE clcc_ww_nkcodierung_4b SET wpkat = PKG_IM_REFERENZEN.F_IS_WPKAT(katalogart,umsatzsaison);

COMMIT;



INSERT /*+ APPEND */ INTO clcc_ww_nkcodierung_4
(
   dwh_cr_load_id, 
   konto_id_key,
   firma, 
   erstbuchdat
)
SELECT
   &gbvid, 
   cl.konto_id_key,   
   CASE WHEN sc.buchungsdatum < TO_DATE('05.06.2020','dd.mm.yyyy') AND sc.firma = 1 AND sc.wpkat = 1 THEN 18 ELSE sc.firma END,
   MIN(sc.buchungsdatum) AS buchdat 
FROM clcc_ww_nkcodierung_1 cl
JOIN 
(
SELECT scx.*, wpkat.wpkat
FROM 
clcc_ww_nkcodierung_10 scx 
JOIN clcc_ww_nkcodierung_4b wpkat ON (wpkat.katalogart = scx.katalogart AND wpkat.umsatzsaison = scx.umsatzsaison)
) sc
ON (CASE WHEN sc.firma = 1 AND sc.wpkat = 1 
                                  THEN 18 ELSE sc.firma END = cl.firma
                           AND sc.konto_id_key = cl.konto_id_key 
                           AND sc.buchungsdatum >= TRUNC(cl.anlagedat)
                           AND sc.buchungsdatum <= &datum)
JOIN clcc_ww_nkcodierung_4a vf ON (vf.artnr = sc.artikelnr AND vf.eksaison = sc.umsatzsaison)               
WHERE (
        (sc.buchungsdatum < TO_DATE('05.06.2020','dd.mm.yyyy') AND vf.vfkz = 0) OR  -- vor Umstellung VF ausschliessen
        (sc.buchungsdatum >= TO_DATE('05.06.2020','dd.mm.yyyy'))
      )
AND cl.firma IN (1,18)
GROUP BY 
   cl.konto_id_key,   
   CASE WHEN sc.buchungsdatum < TO_DATE('05.06.2020','dd.mm.yyyy') AND sc.firma = 1 AND sc.wpkat = 1 
                  THEN 18 ELSE sc.firma                  
     END;
         
COMMIT;



PROMPT 5.2 Tabelle clcc_ww_nkcodierung_2 mit Buchungsdaten und relevanten Informationen aufbauen
PROMPT ===========================================================================================

PROMPT 5.2.1 Daten einfuegen
PROMPT +++++++++++++++++++++++

TRUNCATE TABLE clcc_ww_nkcodierung_2;

INSERT /*+ APPEND */ INTO clcc_ww_nkcodierung_2
(
   dwh_cr_load_id,
   konto_id_key,
   firma,
   buchdat,
   umssaison,
   auftrnr_key,
   auftrpos,
   artnr,
   promnr,
   bestweg,
   ecc,
   brand,
   katalogart,
   shop,
   anspr,
   wpkz,
   wkz,
   wkz_wp,
   vfkz,
   heineiwl
)
  SELECT DISTINCT
    &gbvid,
     b.konto_id_key,
     CASE WHEN F_WP_EIGENEFIRMA(b.buchungsdatum) = 0 AND b.firma = 1 AND PKG_IM_REFERENZEN.F_IS_WPKAT(b.katalogart,b.umsatzsaison) = 1 THEN 18 ELSE b.firma END,   
     b.buchungsdatum, 
     b.umsatzsaison, 
     b.auftrnr_key,
     b.auftrpos,
     b.artikelnr,
     CASE WHEN b.promotionnr = '?' THEN '0' ELSE b.promotionnr END,
     auf.bestwegkz,
     auf.mailnr AS ecc,
     CASE WHEN ecc.kanalgrob IN ('Brand') THEN 2 ELSE 1 END AS brand,
     b.katalogart,
     CASE WHEN vf.katalogzusteuerung = 1 THEN NULL 
          WHEN inetkat.shop = 1 THEN 1
          ELSE 0 END AS shop,          
     b.ansprachen,
     PKG_IM_REFERENZEN.F_IS_WPKAT(b.katalogart,b.umsatzsaison) AS wpkz, -- Ueberlegen, Funktion doppelt zu halten fuer sc und cc
   CASE WHEN b.firma = 1  THEN ecc.wwdewkz
        WHEN b.firma = 2  THEN ecc.wwchwkz
        WHEN b.firma = 5  THEN ecc.wwatwkz
        WHEN b.firma = 15 THEN ecc.wwnlwkz
        WHEN b.firma = 69 THEN ecc.wiruwkz
        WHEN b.firma = 3  THEN ecc.sadewkz
        WHEN b.firma = 9  THEN ecc.sachwkz
        WHEN b.firma = 12 THEN ecc.saatwkz
        WHEN b.firma = 10 THEN ecc.sanlwkz
        WHEN b.firma = 11 THEN ecc.saczwkz
        WHEN b.firma = 13 THEN ecc.saitwkz
        WHEN b.firma = 14 THEN ecc.sauawkz
        WHEN b.firma = 17 THEN ecc.sasewkz
        WHEN b.firma = 6  THEN ecc.cldewkz
        WHEN b.firma = 8  THEN ecc.amdewkz
        WHEN b.firma = 65 THEN ecc.cluswkz
        WHEN b.firma = 19 THEN ecc.saskwkz        
        WHEN b.firma = 21 THEN ecc.heinewkz
        WHEN b.firma = 22 THEN ecc.heinewkz
        WHEN b.firma = 23 THEN ecc.heinewkz
        WHEN b.firma = 24 THEN ecc.heinewkz
        WHEN b.firma = 25 THEN ecc.heinewkz
        WHEN b.firma = 44 THEN ecc.sheegowkz                
        WHEN F_WP_EIGENEFIRMA(b.buchungsdatum) = 1 AND b.firma = 18 THEN ecc.wpdewkz
  ELSE NULL END AS wkz,
   CASE WHEN F_WP_EIGENEFIRMA(b.buchungsdatum) = 0 AND b.firma = 1 THEN ecc.wpdewkz
  ELSE NULL end AS wkz_wp,   
  CASE WHEN vf.vfkz = 1 AND komwarenwert = 0 THEN 1
       WHEN vf.vfkz = 1 AND komwarenwert > 0 THEN 2
   ELSE 0 END AS vfkz,
   CASE 
        WHEN b.firma = 21 THEN ecc.heineiwl
        WHEN b.firma = 22 THEN ecc.heineiwl
        WHEN b.firma = 23 THEN ecc.heineiwl
        WHEN b.firma = 24 THEN ecc.heineiwl
        WHEN b.firma = 25 THEN ecc.heineiwl                
  ELSE NULL END AS heineiwl   
  FROM sc_ww_buchung b
  JOIN clcc_ww_nkcodierung_4 nk4 ON (nk4.konto_id_key = b.konto_id_key AND nk4.erstbuchdat = b.buchungsdatum)
  LEFT OUTER JOIN -- wegen Stationaerbuchungen
     ( 
       SELECT 
           auftridentnr_key, 
           bestwegkz, 
           CASE WHEN bestwegkz = 4 THEN mailnr ELSE 0 END AS mailnr  --ECC nur bei Online-Bestellungen gueltig
       FROM  sc_ww_auftragkopf_ver aver
       JOIN sc_ww_bestweg bweg on (bweg.dwh_id = aver.dwh_id_sc_ww_bestweg)
       JOIN sc_ww_bestweg_ver bwegv ON (bwegv.dwh_id_head = bweg.dwh_id AND bwegv.dwh_valid_to = DATE '9999-12-31')
     WHERE aver.dwh_valid_to = DATE '9999-12-31'
  ) auf
    ON (b.auftrnr_key = auf.auftridentnr_key)
   LEFT OUTER JOIN 
      (
      SELECT 
            ecck.ecc, 
            ecck.vtsaison,
            eccv.wwdewkz,
            eccv.wwchwkz,
            eccv.wwatwkz,
            eccv.wwnlwkz,
            eccv.wiruwkz,
            eccv.sadewkz,
            eccv.sachwkz,
            eccv.saatwkz,
            eccv.sanlwkz,
            eccv.saczwkz,
            eccv.saitwkz,
            eccv.sauawkz,
            eccv.sasewkz,
            eccv.cldewkz,
            eccv.amdewkz,
            eccv.wpdewkz,
            eccv.cluswkz,
            eccv.saskwkz, 
            eccv.heinewkz,
            eccv.sheegowkz,            
            eccv.heineiwl,
            ecczv.kanalgrob
     FROM sc_fu_ecc ecck 
     JOIN sc_fu_ecc_ver eccv ON (eccv.dwh_id_head = ecck.dwh_id AND eccv.dwh_valid_to = DATE '9999-12-31')
     JOIN sc_fu_ecc_zuordnung ecczk ON (ecczk.vtsaison = ecck.vtsaison AND ecczk.kanalfein = eccv.kanalfein)
     JOIN sc_fu_ecc_zuordnung_ver ecczv ON (ecczv.dwh_id_head = ecczk.dwh_id AND ecczv.dwh_valid_to = DATE '9999-12-31')     
     WHERE ecck.vtsaison = &vtsaison
    ) ecc
  ON (ecc.ecc = auf.mailnr) 
  LEFT OUTER JOIN 
  (
    SELECT  TO_NUMBER(SUBSTR(sg,1,3)) AS saison, 
            TO_NUMBER(SUBSTR(sg, 5)) AS katalogart, 
            1 AS shop
    FROM    cc_katart cckatart
    WHERE   &termin BETWEEN cckatart.dwh_valid_from and cckatart.dwh_valid_to
    AND     verd1sort2 = 2 -- Shopangebot 
  ) inetkat 
  ON (inetkat.saison = b.umsatzsaison AND inetkat.katalogart = b.katalogart)
  JOIN 
     (
       SELECT 
          artnr, 
          eksaison,  
          CASE WHEN mkz.verd1bez1 = 'VF-Artikel'  THEN 1
               WHEN mkz.verd1bez2 = 'VF-Artikel / Sonstiges' THEN 1          
               WHEN SUBSTR(wgrpkt.sg, -4) = '73-6' THEN 1
          ELSE 0 END AS vfkz,               
          CASE  WHEN SUBSTR(wgrpkt.sg, -4) = '73-6' THEN 1
          ELSE 0 END AS katalogzusteuerung                      
       FROM cc_art_akt_v art
       JOIN cc_marktkz_akt_v mkz ON (mkz.wert = art.marktkz)
       JOIN cc_wagrpkt_akt_v wgrpkt ON (wgrpkt.wert = art.wagrpkt)      
   ) vf
  ON (vf.artnr = b.artikelnr AND vf.eksaison = b.umsatzsaison)  
  WHERE b.ansprachen > 0;

COMMIT;



PROMPT 5.2.2 Gutscheindaten-ID ermitteln (GUTSCHVORGNR!!!)
PROMPT ++++++++++++++++++++++++++++++++++++++++++++++++++++

MERGE INTO clcc_ww_nkcodierung_2 cc2
USING 
    (SELECT DISTINCT  
        auftridentnr_key, 
        MIN(gudat.gutschnr) AS gutschnrvorgabe  -- Die GUTSCHNR aus der GUTSCHDATEN wird verwendet, da hier auch die Gutscheine über die PATTERN abgegriffen werden können (z.b. 13736)
     FROM sc_ww_auftrag_auftpool h 
     JOIN sc_ww_auftrag_auftpool_ver v  ON (h.dwh_id = v.dwh_id_head AND v.dwh_valid_to = DATE '9999-12-31')
     JOIN cc_gutschdaten gudat ON (gudat.gutschdaten_id_key = v.gutscheindatenid_key AND &termin BETWEEN gudat.dwh_valid_from AND gudat.dwh_valid_to)
     JOIN cc_gutschaktion guakt ON (guakt.gutschaktion_id = gudat.gutschaktion_id AND &termin BETWEEN guakt.dwh_valid_from AND guakt.dwh_valid_to)
      WHERE v.gutscheindatenid_key IS NOT NULL
    GROUP BY auftridentnr_key
    ) quell
ON (quell.auftridentnr_key = cc2.auftrnr_key)
WHEN MATCHED THEN UPDATE
  SET cc2.gulivercode = quell.gutschnrvorgabe;

COMMIT;


PROMPT 5.3 Daten aus Bestellanalyse-FUP in Tabelle clcc_ww_nkcodierung_3 aufbereiten (Katalogarten koennen nebeneinander mit Semikolon getrennt eingegeben werden)
PROMPT ============================================================================================================================================================

TRUNCATE TABLE clcc_ww_nkcodierung_3;

INSERT /*+ APPEND */ INTO clcc_ww_nkcodierung_3
(
   dwh_cr_load_id,
   vtsaison,
   firma,
   eksaison,
   anlcode,
   katartprio,
   katalogart,
   folowkz,
   foloiwl
)
    SELECT DISTINCT 
        &gbvid,
        vtsaison,
        firma, 
        eksaison,
        anlcode,
        katartprio, 
        TRIM(REGEXP_SUBSTR (katart,
                                           '[^;]+',
                                           1,
                                           LEVEL))
                                   as      katart,
        folowkz,
        foloiwl
    FROM  sc_fu_nkcod_analyse sck  
    JOIN sc_fu_nkcod_analyse_ver scv ON (scv.dwh_id_head = sck.dwh_id AND scv.dwh_valid_to = DATE '9999-12-31' AND &datum BETWEEN scv.anlaufvon AND scv.anlaufbis)
    WHERE katart IS NOT NULL 
    CONNECT BY LEVEL <= LENGTH (REGEXP_REPLACE (katart, '[^;]+')) + 1;
   
COMMIT;

 
PROMPT 6. VF-Herkunft setzen (Kombination aus Artnr/Prom und Guliver-Code)
PROMPT ********************************************************************

PROMPT 6.1 Artnr/Prom in VFHERKUNFT 1 bis 5 setzen
PROMPT ============================================ 

MERGE INTO clcc_ww_nkcodierung_1 cc
USING
(
  SELECT 
    konto_id_key,
    MIN(CASE WHEN zaehler = 1 THEN artnr || '.' || promnr ELSE NULL END) AS herkunft1,
    MIN(CASE WHEN zaehler = 2 THEN artnr || '.' || promnr ELSE NULL END) AS herkunft2,
    MIN(CASE WHEN zaehler = 3 THEN artnr || '.' || promnr ELSE NULL END) AS herkunft3,
    MIN(CASE WHEN zaehler = 4 THEN artnr || '.' || promnr ELSE NULL END) AS herkunft4,
    MIN(CASE WHEN zaehler = 5 THEN artnr || '.' || promnr ELSE NULL END) AS herkunft5      
  FROM 
  (
    SELECT 
      konto_id_key, 
      artnr,
      promnr,
      ROW_NUMBER() OVER (PARTITION BY konto_id_key ORDER BY artnr, promnr) as zaehler  
     FROM 
       (
        SELECT DISTINCT 
          konto_id_key,  
          artnr, 
          promnr 
         FROM clcc_ww_nkcodierung_2
         WHERE vfkz IN (1,2)
     ORDER BY konto_id_key
        )
    )
    GROUP BY konto_id_key
) x
ON (x.konto_id_key = cc.konto_id_key)
WHEN MATCHED THEN
   UPDATE SET 
      vfherkunft_1 = x.herkunft1,
      vfherkunft_2 = x.herkunft2,
      vfherkunft_3 = x.herkunft3,
      vfherkunft_4 = x.herkunft4,
      vfherkunft_5 = x.herkunft5;
    
COMMIT;
    


PROMPT 6.2 Gulivercode in Gulivercode 1 bis 5 setzen
PROMPT =============================================== 

MERGE INTO clcc_ww_nkcodierung_1 cc
USING
(
  SELECT konto_id_key,
     MIN(CASE WHEN zaehler = 1 THEN gulivercode ELSE NULL END) AS gulivercode1,
     MIN(CASE WHEN zaehler = 2 THEN gulivercode ELSE NULL END) AS gulivercode2,
     MIN(CASE WHEN zaehler = 3 THEN gulivercode ELSE NULL END) AS gulivercode3,
     MIN(CASE WHEN zaehler = 4 THEN gulivercode ELSE NULL END) AS gulivercode4,
     MIN(CASE WHEN zaehler = 5 THEN gulivercode ELSE NULL END) AS gulivercode5
     FROM     
     (
       SELECT 
         konto_id_key,
         gulivercode,
         ROW_NUMBER() OVER (PARTITION BY konto_id_key ORDER BY gulivercode) AS zaehler     
         FROM 
          (
             SELECT DISTINCT 
               konto_id_key,
               gulivercode  
             FROM clcc_ww_nkcodierung_2
             ORDER BY konto_id_key
           )
    )
    GROUP BY konto_id_key
) x
ON (x.konto_id_key = cc.konto_id_key)
WHEN MATCHED THEN
   UPDATE SET 
      gulivercode_1 = x.gulivercode1,
      gulivercode_2 = x.gulivercode2,
      gulivercode_3 = x.gulivercode3,
      gulivercode_4 = x.gulivercode4,
      gulivercode_5 = x.gulivercode5;
      
COMMIT;



PROMPT 6.3 Leere VFHERKUNFT-Spalten (belegt mit Artnr/Promnr) mit Gulivercodes auffuellen
PROMPT ===================================================================================

UPDATE clcc_ww_nkcodierung_1 SET 
   vfherkunft_1 = NVL(gulivercode_1,'-'),
   vfherkunft_2 = NVL(gulivercode_2,'-'),
   vfherkunft_3 = NVL(gulivercode_3,'-'),
   vfherkunft_4 = NVL(gulivercode_4,'-'),
   vfherkunft_5 = NVL(gulivercode_5,'-')
WHERE vfherkunft_1 IS NULL;

COMMIT;


UPDATE clcc_ww_nkcodierung_1 SET 
   vfherkunft_2 = NVL(gulivercode_1,'-'),
   vfherkunft_3 = NVL(gulivercode_2,'-'),
   vfherkunft_4 = NVL(gulivercode_3,'-'),
   vfherkunft_5 = NVL(gulivercode_4,'-')
WHERE vfherkunft_2 IS NULL;

COMMIT;


UPDATE clcc_ww_nkcodierung_1 SET 
   vfherkunft_3 = NVL(gulivercode_1,'-'),
   vfherkunft_4 = NVL(gulivercode_2,'-'),
   vfherkunft_5 = NVL(gulivercode_3,'-')
WHERE vfherkunft_3 IS NULL;

COMMIT;


UPDATE clcc_ww_nkcodierung_1 SET 
   vfherkunft_4 = NVL(gulivercode_1,'-'),
   vfherkunft_5 = NVL(gulivercode_2,'-')
WHERE vfherkunft_4 IS NULL;

COMMIT;


UPDATE clcc_ww_nkcodierung_1 SET 
   vfherkunft_5 = NVL(gulivercode_1,'-')
WHERE vfherkunft_5 IS NULL;

COMMIT;



PROMPT 7. Bestellanalyse Direktkataloge 
PROMPT ********************************

PROMPT 7.1 Erstbestellung aus Direktkatalog identifizieren (codierungsart 2)
PROMPT ======================================================================

MERGE INTO clcc_ww_nkcodierung_1 cc
USING
(
  SELECT DISTINCT 
     b.firma,   
     b.konto_id_key
  FROM clcc_ww_nkcodierung_2 b  
  JOIN clcc_ww_nkcodierung_3 cl3 ON (cl3.katalogart = b.katalogart and cl3.firma = b.firma AND cl3.eksaison = b.umssaison)
  JOIN sc_fu_nkcod_anlcode ack ON (ack.vtsaison = cl3.vtsaison AND ack.anlcode = cl3.anlcode) 
  JOIN sc_fu_nkcod_anlcode_ver acv ON (acv.dwh_id_head = ack.dwh_id AND acv.dwh_valid_to = DATE '9999-12-31') 
  WHERE acv.anlcodeprio = 1
  AND b.vfkz = 0
) x
ON (x.konto_id_key = cc.konto_id_key)
WHEN MATCHED THEN
   UPDATE SET cc.codierungsart = 2
WHERE codierungsart IS NULL;

COMMIT;



PROMPT 7.2 Treffer auf Mailband beruecksichtigen (aus codierungsart 2 wird codierungsart 3)
PROMPT ======================================================================================

-- Bestellung aus Direktversandkatalog und Treffer auf einem Direktversand-Mailband mit entsprechender Katalogart

PROMPT Treffer 1-12: incl. hoechste Prio bei Bestellung aus mehreren KA des Mailbandes ermitteln
PROMPT +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- In clcc_ww_nkcodierung_8 wird fuer jeden der 12 moeglichen Treffer die Katalogart aus der ADB-Tabelle eingespielt
-- Die Beilagen Katalogarten sind nur im TGV erfasst, deshalb auch Zugriff auf die TGV-Tabellen

BEGIN
   FOR z IN 1..12 LOOP
   
        EXECUTE IMMEDIATE ('TRUNCATE TABLE clcc_ww_nkcodierung_8');

        EXECUTE IMMEDIATE ('INSERT /*+ APPEND */ INTO clcc_ww_nkcodierung_8
                          (
                                dwh_cr_load_id,
                                konto_id_key,
                                firma, 
                                katart,
                                umssaison)
                       SELECT DISTINCT 
                          &gbvid,
                          cc.konto_id_key,
                          cc.firma,
                          tgv.katalogart,
                          tgv.umssaison
                       FROM clcc_ww_nkcodierung_1 cc
                       JOIN sc_ww_nk_kunde sc ON (sc.konto_id_key = cc.konto_id_key)
                       JOIN 
                          (
                          SELECT abg_id 
                           FROM sc_im_adb_abgleich adbabgl1
                           JOIN sc_im_adb_abgleich_ver adbabgl2 ON (adbabgl2.dwh_id_head = adbabgl1.dwh_id AND adbabgl2.dwh_status = 1)
                          ) ab
                          ON (ab.abg_id = sc.abglid_' || z || ')
                       JOIN 
                        (
                           SELECT abg_id, CASE WHEN abg_id = 565 AND wkz IN (261,262) THEN TO_DATE(''27.05.2024'',''dd.mm.rrrr'')
                                               WHEN abg_id = 601 AND wkz IN (451) THEN TO_DATE(''10.03.2025'',''dd.mm.rrrr'')
                                               ELSE versand_datum END 
                                             AS versand_datum,
                                          CASE WHEN abg_id = 635 AND versand_datum = TO_DATE (''23.09.2025'',''dd.mm.rrrr'') 
                                                  AND firma = 1 AND wkz = 326 
                                                THEN 336 
                                          ELSE 
                                             wkz 
                                          END 
                                            AS wkz
                           FROM sc_im_adb_abgleich_codeplan_pos adbcod1
                           JOIN sc_im_adb_abgleich_codeplan_pos_ver adbcod2 ON (adbcod2.dwh_id_head = adbcod1.dwh_id AND adbcod2.dwh_status = 1)
                          ) pos
                          ON (pos.abg_id = ab.abg_id)
             JOIN
                 (
                  SELECT 
                      firma, 
                      w.wkz, 
                      aktions_schluessel, 
                      versand_termin, 
                      CASE WHEN firma = 22 AND versand_termin = TO_DATE(''13.09.2024'',''dd.mm.rrrr'') AND ka.katalogart = 697 THEN 681
                          WHEN firma = 22 AND versand_termin = TO_DATE(''13.09.2024'',''dd.mm.rrrr'') AND ka.katalogart = 681 THEN 697
                      ELSE ka.katalogart END as katalogart,                      
                      ka.ek_sais AS umssaison
                  FROM improg.tgv_akqui_aktion ak 
                  JOIN improg.tgv_akqui_katalogart ka on (ka.aqa_id = ak.aqa_id)
                  JOIN improg.tgv_akqui_wkz w on (w.aqa_id = ak.aqa_id)
                  JOIN improg.tgv_akqui_ka_wkz kawkz on (kawkz.aqa_id = ak.aqa_id and kawkz.katalogart = ka.katalogart and kawkz.wkz = w.wkz)
              ) tgv 
               ON (CASE WHEN tgv.firma = 68 THEN 18 ELSE tgv.firma END = cc.firma and LPAD(tgv.wkz,6,''0'') = LPAD(to_char(mbwkz_' || z || '),6,''0'') and tgv.versand_termin = pos.versand_datum)               
            WHERE 
                 CASE WHEN tgv.firma = 22 AND ab.abg_id = 575 AND versand_datum = TO_DATE(''13.09.2024'',''dd.mm.rrrr'') AND pos.wkz = 502 THEN 505
                      WHEN tgv.firma = 22 AND ab.abg_id = 575 AND versand_datum = TO_DATE(''13.09.2024'',''dd.mm.rrrr'') AND pos.wkz = 505 THEN 502
                  ELSE pos.wkz END
                        = cc.mbwkz_' || z || '
                AND codierungsart IN (2,3)');
                       

           COMMIT;
           



-- nach der WHERE-Klausel anstatt "pos.wkz"
/*
                           CASE WHEN tgv.firma = 11 AND ab.abg_id = 446 AND versand_datum = TO_DATE(''16.05.2022'',''dd.mm.rrrr'') AND pos.wkz = 153 THEN 133
                                WHEN tgv.firma = 11 AND ab.abg_id = 446 AND versand_datum = TO_DATE(''09.05.2022'',''dd.mm.rrrr'') AND pos.wkz = 152 THEN 132
                                WHEN tgv.firma = 11 AND ab.abg_id = 446 AND versand_datum = TO_DATE(''02.05.2022'',''dd.mm.rrrr'') AND pos.wkz = 151 THEN 131
                             ELSE 
                             pos.wkz
                           END
*/

-- Das ist das Original!!!
--               pos.wkz = cc.mbwkz_' || z || '

-- In clcc_ww_nkcodierung_2 stehen die vorbereiteten Buchungsdaten
-- In clcc_ww_nkcodierung_3 stehen die vorbereiteten Vorgaben aus dem Bestellanalyse-FUP

-- Wenn aus dem getroffenen Mailband auch bestellt wurde, wird die Codierungsart 3 gesetzt, die Prio aus dem Bestellanalysefup fuer die 
--    entsprechende Katalogart wird fuer die spaetere Entscheidung abgespeichert.
--    --> nur WKZs, die auch eine entsprechende Bestellung haben koennen entsprechend ihrer Prio zu einer End-WKZ werden. 


      EXECUTE IMMEDIATE ('
           MERGE INTO clcc_ww_nkcodierung_1 cc
           USING
        (
          SELECT DISTINCT 
            b.firma,     
            b.konto_id_key,
            MIN(cl3.katartprio) AS katartprio
          FROM clcc_ww_nkcodierung_2 b  
          JOIN clcc_ww_nkcodierung_3 cl3 ON (cl3.katalogart = b.katalogart AND cl3.firma = b.firma AND cl3.eksaison = b.umssaison)
          JOIN clcc_ww_nkcodierung_8 cl8 ON (cl8.konto_id_key = b.konto_id_key AND cl8.katart = b.katalogart AND cl8.umssaison = b.umssaison)
          WHERE b.vfkz = 0
          GROUP BY b.firma, b.konto_id_key
         ) x
         ON (x.konto_id_key = cc.konto_id_key)
         WHEN MATCHED THEN
           UPDATE SET 
             cc.codierungsart = 3,
             cc.aktiv_prio' || z || '  = x.katartprio 
        WHERE codierungsart IN (2,3)');
       
     COMMIT;

   END LOOP;
   
END;
/



PROMPT 7.3 Im Bestellanalyse-FUP pruefen, ob gefundene WKZ im Gueltigkeitszeitraum liegt, gueltigvon-Datum wird zwischengespeichert fuer Priorisierung bei Vergabe der MBWKZ/MBIWL und WKZ/IWL
PROMPT ========================================================================================================================================================================================

-- NEU: Als PLSQL Block incl. Waeschepur Problem


DECLARE
    v_datum VARCHAR2(20);
    v_hjanfang VARCHAR2(20);
BEGIN

   v_datum := TO_CHAR(&datum,'dd.mm.yyyy');
   v_hjanfang := TO_CHAR(&hjanfang ,'dd.mm.yyyy');

   FOR z IN 1..12 LOOP

      EXECUTE IMMEDIATE ('
       MERGE INTO clcc_ww_nkcodierung_1 ga1 
       USING
      (
        SELECT DISTINCT 
          ga.konto_id_key, 
          ga.firma, 
          ga.anlagedat, 
          MIN(scv.anlaufvon) AS anlaufvon
        FROM clcc_ww_nkcodierung_1 ga
        LEFT OUTER JOIN cc_kunde_&vtsaison cc ON (cc.konto_id_key = ga.konto_id_key AND to_date('''||v_datum||''',''dd.mm.yyyy'') -0.5 BETWEEN cc.dwh_valid_from and cc.dwh_valid_to)      
        JOIN sc_fu_nkcod_analyse sck ON (sck.firma = ga.firma)
        JOIN sc_fu_nkcod_analyse_ver scv ON (scv.dwh_id_head = sck.dwh_id 
                                                AND scv.dwh_valid_to = DATE ''9999-12-31'' 
                                                AND ga.mbwkz_' || z || ' BETWEEN scv.vonwkz AND scv.biswkz 
                                                AND ga.mbiwl_' || z || ' BETWEEN scv.voniwl AND scv.bisiwl 
                                                AND 
                                                    CASE WHEN ga.firma = 1 
                                                         AND ga.anlagedat < to_date('''||v_hjanfang||''',''dd.mm.yyyy'')
                                                         AND cc.vtinfogrp = 801 --inaktiver Wäpu Kunde laeuft an
                                                THEN to_date('''||v_datum||''',''dd.mm.yyyy'') ELSE ga.anlagedat END BETWEEN scv.anlaufvon AND scv.anlaufbis) --neu
        GROUP BY ga.konto_id_key, ga.firma, ga.anlagedat
      ) x
      ON (x.konto_id_key = ga1.konto_id_key AND x.anlagedat = ga1.anlagedat)
     WHEN MATCHED THEN
     UPDATE SET ga1.gueltigvon_' || z || ' = x.anlaufvon,
                ga1.gueltigkz_' || z || ' = 2');
                
     COMMIT;

   END LOOP;
   
END;
/


PROMPT 7.4 Endgueltige Mbwkz und Mbiwl ueber Prio ermitteln fuer Codierungsart != 3 (Priorisierung: letztes gueltigvon (letzter PAL) gewinnt)
PROMPT =============================================================================

-- Voraussetzungen: 
--     Mailbandtreffer beim Abgleich vorhanden
--     gefundene WKZ ist gueltig lt. FUP-Vorgabe (gueltigkz_x)
--     Priorisierung der Kandidaten: Letzter PAL (gueltig_von) wird verwendet          


UPDATE clcc_ww_nkcodierung_1 SET 
    mbwkz = SUBSTR(GREATEST(
                      CASE WHEN gueltigkz_1 = 2  AND mbwkz_1 IS NOT NULL THEN NVL(TO_CHAR(gueltigvon_1,'yyyymmdd'),'19000101')||  '_12_' || mbwkz_1 ELSE '19000101_99_999' END,
                      CASE WHEN gueltigkz_2 = 2  AND mbwkz_2 IS NOT NULL THEN NVL(TO_CHAR(gueltigvon_2,'yyyymmdd'),'19000101')||  '_11_' || mbwkz_2 ELSE '19000101_99_999' END,
                      CASE WHEN gueltigkz_3 = 2  AND mbwkz_3 IS NOT NULL THEN NVL(TO_CHAR(gueltigvon_3,'yyyymmdd'),'19000101')||  '_10_' || mbwkz_3 ELSE '19000101_99_999' END,
                      CASE WHEN gueltigkz_4 = 2  AND mbwkz_4 IS NOT NULL THEN NVL(TO_CHAR(gueltigvon_4,'yyyymmdd'),'19000101')||  '_09_' || mbwkz_4 ELSE '19000101_99_999' END,
                      CASE WHEN gueltigkz_5 = 2  AND mbwkz_5 IS NOT NULL THEN NVL(TO_CHAR(gueltigvon_5,'yyyymmdd'),'19000101')||  '_08_' || mbwkz_5 ELSE '19000101_99_999' END,
                      CASE WHEN gueltigkz_6 = 2  AND mbwkz_6 IS NOT NULL THEN NVL(TO_CHAR(gueltigvon_6,'yyyymmdd'),'19000101')||  '_07_' || mbwkz_6 ELSE '19000101_99_999' END,
                      CASE WHEN gueltigkz_7 = 2  AND mbwkz_7 IS NOT NULL THEN NVL(TO_CHAR(gueltigvon_7,'yyyymmdd'),'19000101')||  '_06_' || mbwkz_7 ELSE '19000101_99_999' END,
                      CASE WHEN gueltigkz_8 = 2  AND mbwkz_8 IS NOT NULL THEN NVL(TO_CHAR(gueltigvon_8,'yyyymmdd'),'19000101')||  '_05_' || mbwkz_8 ELSE '19000101_99_999' END,
                      CASE WHEN gueltigkz_9 = 2  AND mbwkz_9 IS NOT NULL THEN NVL(TO_CHAR(gueltigvon_9,'yyyymmdd'),'19000101')||  '_04_' || mbwkz_9 ELSE '19000101_99_999' END,
                      CASE WHEN gueltigkz_10 = 2 AND mbwkz_10 IS NOT NULL THEN NVL(TO_CHAR(gueltigvon_10,'yyyymmdd'),'19000101')||  '_03_' || mbwkz_10 ELSE '19000101_99_999' END,
                      CASE WHEN gueltigkz_11 = 2 AND mbwkz_11 IS NOT NULL THEN NVL(TO_CHAR(gueltigvon_11,'yyyymmdd'),'19000101')||  '_02_' || mbwkz_11 ELSE '19000101_99_999' END,
                      CASE WHEN gueltigkz_12 = 2 AND mbwkz_12 IS NOT NULL THEN NVL(TO_CHAR(gueltigvon_12,'yyyymmdd'),'19000101')||  '_01_' || mbwkz_12 ELSE '19000101_99_999' END)
                      ,13),
    mbiwl = SUBSTR(GREATEST(
                      CASE WHEN gueltigkz_1 = 2  AND mbiwl_1 IS NOT NULL THEN NVL(TO_CHAR(gueltigvon_1,'yyyymmdd'),'19000101')||  '_12_' || mbiwl_1 ELSE '19000101_99_999' END,
                      CASE WHEN gueltigkz_2 = 2  AND mbiwl_2 IS NOT NULL THEN NVL(TO_CHAR(gueltigvon_2,'yyyymmdd'),'19000101')||  '_11_' || mbiwl_2 ELSE '19000101_99_999' END,
                      CASE WHEN gueltigkz_3 = 2  AND mbiwl_3 IS NOT NULL THEN NVL(TO_CHAR(gueltigvon_3,'yyyymmdd'),'19000101')||  '_10_' || mbiwl_3 ELSE '19000101_99_999' END,
                      CASE WHEN gueltigkz_4 = 2  AND mbiwl_4 IS NOT NULL THEN NVL(TO_CHAR(gueltigvon_4,'yyyymmdd'),'19000101')||  '_09_' || mbiwl_4 ELSE '19000101_99_999' END,
                      CASE WHEN gueltigkz_5 = 2  AND mbiwl_5 IS NOT NULL THEN NVL(TO_CHAR(gueltigvon_5,'yyyymmdd'),'19000101')||  '_08_' || mbiwl_5 ELSE '19000101_99_999' END,
                      CASE WHEN gueltigkz_6 = 2  AND mbiwl_6 IS NOT NULL THEN NVL(TO_CHAR(gueltigvon_6,'yyyymmdd'),'19000101')||  '_07_' || mbiwl_6 ELSE '19000101_99_999' END,
                      CASE WHEN gueltigkz_7 = 2  AND mbiwl_7 IS NOT NULL THEN NVL(TO_CHAR(gueltigvon_7,'yyyymmdd'),'19000101')||  '_06_' || mbiwl_7 ELSE '19000101_99_999' END,
                      CASE WHEN gueltigkz_8 = 2  AND mbiwl_8 IS NOT NULL THEN NVL(TO_CHAR(gueltigvon_8,'yyyymmdd'),'19000101')||  '_05_' || mbiwl_8 ELSE '19000101_99_999' END,
                      CASE WHEN gueltigkz_9 = 2  AND mbiwl_9 IS NOT NULL THEN NVL(TO_CHAR(gueltigvon_9,'yyyymmdd'),'19000101')||  '_04_' || mbiwl_9 ELSE '19000101_99_999' END,
                      CASE WHEN gueltigkz_10 = 2 AND mbiwl_10 IS NOT NULL THEN NVL(TO_CHAR(gueltigvon_10,'yyyymmdd'),'19000101')||  '_03_' || mbiwl_10 ELSE '19000101_99_999' END,
                      CASE WHEN gueltigkz_11 = 2 AND mbiwl_11 IS NOT NULL THEN NVL(TO_CHAR(gueltigvon_11,'yyyymmdd'),'19000101')||  '_02_' || mbiwl_11 ELSE '19000101_99_999' END,
                      CASE WHEN gueltigkz_12 = 2 AND mbiwl_12 IS NOT NULL THEN NVL(TO_CHAR(gueltigvon_12,'yyyymmdd'),'19000101')||  '_01_' || mbiwl_12 ELSE '19000101_99_999' END)
                      ,13)                 
     WHERE COALESCE(codierungsart,0) != 3;

COMMIT;



UPDATE clcc_ww_nkcodierung_1 SET mbwkz = NULL, mbiwl = NULL 
WHERE mbwkz = '999'
AND COALESCE(codierungsart,0) != 3;

COMMIT;



PROMPT 7.5 Beste Prio fuer gueltige Mailbaender ermitteln
PROMPT **************************************************

UPDATE clcc_ww_nkcodierung_1 SET 
    bestvalidprio =  LEAST(
                           CASE WHEN gueltigkz_1 = 2 THEN NVL(aktiv_prio1,999) ELSE 999 END,
                           CASE WHEN gueltigkz_2 = 2 THEN NVL(aktiv_prio2,999) ELSE 999 END,
                           CASE WHEN gueltigkz_3 = 2 THEN NVL(aktiv_prio3,999) ELSE 999 END,
                           CASE WHEN gueltigkz_4 = 2 THEN NVL(aktiv_prio4,999) ELSE 999 END,
                           CASE WHEN gueltigkz_5 = 2 THEN NVL(aktiv_prio5,999) ELSE 999 END,
                           CASE WHEN gueltigkz_6 = 2 THEN NVL(aktiv_prio6,999) ELSE 999 END,
                           CASE WHEN gueltigkz_7 = 2 THEN NVL(aktiv_prio7,999) ELSE 999 END,
                           CASE WHEN gueltigkz_8 = 2 THEN NVL(aktiv_prio8,999) ELSE 999 END,
                           CASE WHEN gueltigkz_9 = 2 THEN NVL(aktiv_prio9,999) ELSE 999 END,
                           CASE WHEN gueltigkz_10 = 2 THEN NVL(aktiv_prio10,999) ELSE 999 END,
                           CASE WHEN gueltigkz_11 = 2 THEN NVL(aktiv_prio11,999) ELSE 999 END,
                           CASE WHEN gueltigkz_12 = 2 THEN NVL(aktiv_prio12,999) ELSE 999 END)                                                                                 
    WHERE codierungsart = 3;

COMMIT;



PROMPT 7.6  Mbwkz/Mbiwl und WKZ/IWL fuer Codierungsart 3 ermitteln
PROMPT ===========================================================

-- Voraussetzung: 
--     Mailbandtreffer beim Abgleich vorhanden
--     gefundene WKZ ist gueltig lt. FUP-Vorgabe (gueltigkz_x)

-- Priorisierung:
--     Bestpriorisierte gueltige Katalogart gewinnt (min(katartprio))=bestvalidprio aus Bestellanalyse FUP pro Katalog
--     Bei gleicher Priorisierung: Letzter PAL (gueltig_von) wird verwendet (Erstversand-/Zweitversand-Problematik, Nach PAL gewinnt der Zweitversand)  
--     Bei gleichem guelig_von (z.B. alle ab Saisoanfang eingetragen) gewinnt der erste gefundene Mailbandtreffer (MBWKZ_1, MBWKZ_2...)


UPDATE clcc_ww_nkcodierung_1 SET 
    wkz = SUBSTR(GREATEST(
                      CASE WHEN aktiv_prio1   = bestvalidprio AND gueltigkz_1 = 2  AND mbwkz_1 IS NOT NULL THEN NVL(TO_CHAR(gueltigvon_1,'yyyymmdd'),'19000101')||  '_12_' || mbwkz_1 ELSE '19000101_99_999' END,
                      CASE WHEN aktiv_prio2   = bestvalidprio AND gueltigkz_2 = 2  AND mbwkz_2 IS NOT NULL THEN NVL(TO_CHAR(gueltigvon_2,'yyyymmdd'),'19000101')||  '_11_' || mbwkz_2 ELSE '19000101_99_999' END,
                      CASE WHEN aktiv_prio3   = bestvalidprio AND gueltigkz_3 = 2  AND mbwkz_3 IS NOT NULL THEN NVL(TO_CHAR(gueltigvon_3,'yyyymmdd'),'19000101')||  '_10_' || mbwkz_3 ELSE '19000101_99_999' END,
                      CASE WHEN aktiv_prio4   = bestvalidprio AND gueltigkz_4 = 2  AND mbwkz_4 IS NOT NULL THEN NVL(TO_CHAR(gueltigvon_4,'yyyymmdd'),'19000101')||  '_09_' || mbwkz_4 ELSE '19000101_99_999' END,
                      CASE WHEN aktiv_prio5   = bestvalidprio AND gueltigkz_5 = 2  AND mbwkz_5 IS NOT NULL THEN NVL(TO_CHAR(gueltigvon_5,'yyyymmdd'),'19000101')||  '_08_' || mbwkz_5 ELSE '19000101_99_999' END,
                      CASE WHEN aktiv_prio6   = bestvalidprio AND gueltigkz_6 = 2  AND mbwkz_6 IS NOT NULL THEN NVL(TO_CHAR(gueltigvon_6,'yyyymmdd'),'19000101')||  '_07_' || mbwkz_6 ELSE '19000101_99_999' END,
                      CASE WHEN aktiv_prio7   = bestvalidprio AND gueltigkz_7 = 2  AND mbwkz_7 IS NOT NULL THEN NVL(TO_CHAR(gueltigvon_7,'yyyymmdd'),'19000101')||  '_06_' || mbwkz_7 ELSE '19000101_99_999' END,
                      CASE WHEN aktiv_prio8   = bestvalidprio AND gueltigkz_8 = 2  AND mbwkz_8 IS NOT NULL THEN NVL(TO_CHAR(gueltigvon_8,'yyyymmdd'),'19000101')||  '_05_' || mbwkz_8 ELSE '19000101_99_999' END,
                      CASE WHEN aktiv_prio9   = bestvalidprio AND gueltigkz_9 = 2  AND mbwkz_9 IS NOT NULL THEN NVL(TO_CHAR(gueltigvon_9,'yyyymmdd'),'19000101')||  '_04_' || mbwkz_9 ELSE '19000101_99_999' END,
                      CASE WHEN aktiv_prio10  = bestvalidprio AND gueltigkz_10 = 2 AND mbwkz_10 IS NOT NULL THEN NVL(TO_CHAR(gueltigvon_10,'yyyymmdd'),'19000101')||  '_03_' || mbwkz_10 ELSE '19000101_99_999' END,
                      CASE WHEN aktiv_prio11  = bestvalidprio AND gueltigkz_11 = 2 AND mbwkz_11 IS NOT NULL THEN NVL(TO_CHAR(gueltigvon_11,'yyyymmdd'),'19000101')||  '_02_' || mbwkz_11 ELSE '19000101_99_999' END,
                      CASE WHEN aktiv_prio12  = bestvalidprio AND gueltigkz_12 = 2 AND mbwkz_12 IS NOT NULL THEN NVL(TO_CHAR(gueltigvon_12,'yyyymmdd'),'19000101')||  '_01_' || mbwkz_12 ELSE '19000101_99_999' END)
                      ,13),
    iwl = SUBSTR(GREATEST(
                      CASE WHEN aktiv_prio1   = bestvalidprio AND gueltigkz_1 = 2  AND mbiwl_1 IS NOT NULL THEN NVL(TO_CHAR(gueltigvon_1,'yyyymmdd'),'19000101')||  '_12_' || mbiwl_1 ELSE '19000101_99_999' END,
                      CASE WHEN aktiv_prio2   = bestvalidprio AND gueltigkz_2 = 2  AND mbiwl_2 IS NOT NULL THEN NVL(TO_CHAR(gueltigvon_2,'yyyymmdd'),'19000101')||  '_11_' || mbiwl_2 ELSE '19000101_99_999' END,
                      CASE WHEN aktiv_prio3   = bestvalidprio AND gueltigkz_3 = 2  AND mbiwl_3 IS NOT NULL THEN NVL(TO_CHAR(gueltigvon_3,'yyyymmdd'),'19000101')||  '_10_' || mbiwl_3 ELSE '19000101_99_999' END,
                      CASE WHEN aktiv_prio4   = bestvalidprio AND gueltigkz_4 = 2  AND mbiwl_4 IS NOT NULL THEN NVL(TO_CHAR(gueltigvon_4,'yyyymmdd'),'19000101')||  '_09_' || mbiwl_4 ELSE '19000101_99_999' END,
                      CASE WHEN aktiv_prio5   = bestvalidprio AND gueltigkz_5 = 2  AND mbiwl_5 IS NOT NULL THEN NVL(TO_CHAR(gueltigvon_5,'yyyymmdd'),'19000101')||  '_08_' || mbiwl_5 ELSE '19000101_99_999' END,
                      CASE WHEN aktiv_prio6   = bestvalidprio AND gueltigkz_6 = 2  AND mbiwl_6 IS NOT NULL THEN NVL(TO_CHAR(gueltigvon_6,'yyyymmdd'),'19000101')||  '_07_' || mbiwl_6 ELSE '19000101_99_999' END,
                      CASE WHEN aktiv_prio7   = bestvalidprio AND gueltigkz_7 = 2  AND mbiwl_7 IS NOT NULL THEN NVL(TO_CHAR(gueltigvon_7,'yyyymmdd'),'19000101')||  '_06_' || mbiwl_7 ELSE '19000101_99_999' END,
                      CASE WHEN aktiv_prio8   = bestvalidprio AND gueltigkz_8 = 2  AND mbiwl_8 IS NOT NULL THEN NVL(TO_CHAR(gueltigvon_8,'yyyymmdd'),'19000101')||  '_05_' || mbiwl_8 ELSE '19000101_99_999' END,
                      CASE WHEN aktiv_prio9   = bestvalidprio AND gueltigkz_9 = 2  AND mbiwl_9 IS NOT NULL THEN NVL(TO_CHAR(gueltigvon_9,'yyyymmdd'),'19000101')||  '_04_' || mbiwl_9 ELSE '19000101_99_999' END,
                      CASE WHEN aktiv_prio10  = bestvalidprio AND gueltigkz_10 = 2 AND mbiwl_10 IS NOT NULL THEN NVL(TO_CHAR(gueltigvon_10,'yyyymmdd'),'19000101')||  '_03_' || mbiwl_10 ELSE '19000101_99_999' END,
                      CASE WHEN aktiv_prio11  = bestvalidprio AND gueltigkz_11 = 2 AND mbiwl_11 IS NOT NULL THEN NVL(TO_CHAR(gueltigvon_11,'yyyymmdd'),'19000101')||  '_02_' || mbiwl_11 ELSE '19000101_99_999' END,
                      CASE WHEN aktiv_prio12  = bestvalidprio AND gueltigkz_12 = 2 AND mbiwl_12 IS NOT NULL THEN NVL(TO_CHAR(gueltigvon_12,'yyyymmdd'),'19000101')||  '_01_' || mbiwl_12 ELSE '19000101_99_999' END)
                      ,13)               
     WHERE codierungsart = 3;
     
COMMIT;

update clcc_ww_nkcodierung_1 set wkz = null, iwl = null 
where wkz = '999'
and erstwkz != '999';

commit;


PROMPT 7.7  MBWKZ/MBIWL aus WKZ/IWL uebernehmen
PROMPT ************************************************

UPDATE clcc_ww_nkcodierung_1 set mbwkz = wkz, mbiwl = iwl
WHERE codierungsart = 3
AND wkz IS NOT NULL;

COMMIT;


UPDATE clcc_ww_nkcodierung_1 SET 
    mbwkz = SUBSTR(GREATEST(
                      CASE WHEN gueltigkz_1 = 2  AND mbwkz_1 IS NOT NULL THEN NVL(TO_CHAR(gueltigvon_1,'yyyymmdd'),'19000101')||  '_12_' || mbwkz_1 ELSE '19000101_99_999' END,
                      CASE WHEN gueltigkz_2 = 2  AND mbwkz_2 IS NOT NULL THEN NVL(TO_CHAR(gueltigvon_2,'yyyymmdd'),'19000101')||  '_11_' || mbwkz_2 ELSE '19000101_99_999' END,
                      CASE WHEN gueltigkz_3 = 2  AND mbwkz_3 IS NOT NULL THEN NVL(TO_CHAR(gueltigvon_3,'yyyymmdd'),'19000101')||  '_10_' || mbwkz_3 ELSE '19000101_99_999' END,
                      CASE WHEN gueltigkz_4 = 2  AND mbwkz_4 IS NOT NULL THEN NVL(TO_CHAR(gueltigvon_4,'yyyymmdd'),'19000101')||  '_09_' || mbwkz_4 ELSE '19000101_99_999' END,
                      CASE WHEN gueltigkz_5 = 2  AND mbwkz_5 IS NOT NULL THEN NVL(TO_CHAR(gueltigvon_5,'yyyymmdd'),'19000101')||  '_08_' || mbwkz_5 ELSE '19000101_99_999' END,
                      CASE WHEN gueltigkz_6 = 2  AND mbwkz_6 IS NOT NULL THEN NVL(TO_CHAR(gueltigvon_6,'yyyymmdd'),'19000101')||  '_07_' || mbwkz_6 ELSE '19000101_99_999' END,
                      CASE WHEN gueltigkz_7 = 2  AND mbwkz_7 IS NOT NULL THEN NVL(TO_CHAR(gueltigvon_7,'yyyymmdd'),'19000101')||  '_06_' || mbwkz_7 ELSE '19000101_99_999' END,
                      CASE WHEN gueltigkz_8 = 2  AND mbwkz_8 IS NOT NULL THEN NVL(TO_CHAR(gueltigvon_8,'yyyymmdd'),'19000101')||  '_05_' || mbwkz_8 ELSE '19000101_99_999' END,
                      CASE WHEN gueltigkz_9 = 2  AND mbwkz_9 IS NOT NULL THEN NVL(TO_CHAR(gueltigvon_9,'yyyymmdd'),'19000101')||  '_04_' || mbwkz_9 ELSE '19000101_99_999' END,
                      CASE WHEN gueltigkz_10 = 2 AND mbwkz_10 IS NOT NULL THEN NVL(TO_CHAR(gueltigvon_10,'yyyymmdd'),'19000101')||  '_03_' || mbwkz_10 ELSE '19000101_99_999' END,
                      CASE WHEN gueltigkz_11 = 2 AND mbwkz_11 IS NOT NULL THEN NVL(TO_CHAR(gueltigvon_11,'yyyymmdd'),'19000101')||  '_02_' || mbwkz_11 ELSE '19000101_99_999' END,
                      CASE WHEN gueltigkz_12 = 2 AND mbwkz_12 IS NOT NULL THEN NVL(TO_CHAR(gueltigvon_12,'yyyymmdd'),'19000101')||  '_01_' || mbwkz_12 ELSE '19000101_99_999' END)
                      ,13),
    mbiwl = SUBSTR(GREATEST(
                      CASE WHEN gueltigkz_1 = 2  AND mbiwl_1 IS NOT NULL THEN NVL(TO_CHAR(gueltigvon_1,'yyyymmdd'),'19000101')||  '_12_' || mbiwl_1 ELSE '19000101_99_999' END,
                      CASE WHEN gueltigkz_2 = 2  AND mbiwl_2 IS NOT NULL THEN NVL(TO_CHAR(gueltigvon_2,'yyyymmdd'),'19000101')||  '_11_' || mbiwl_2 ELSE '19000101_99_999' END,
                      CASE WHEN gueltigkz_3 = 2  AND mbiwl_3 IS NOT NULL THEN NVL(TO_CHAR(gueltigvon_3,'yyyymmdd'),'19000101')||  '_10_' || mbiwl_3 ELSE '19000101_99_999' END,
                      CASE WHEN gueltigkz_4 = 2  AND mbiwl_4 IS NOT NULL THEN NVL(TO_CHAR(gueltigvon_4,'yyyymmdd'),'19000101')||  '_09_' || mbiwl_4 ELSE '19000101_99_999' END,
                      CASE WHEN gueltigkz_5 = 2  AND mbiwl_5 IS NOT NULL THEN NVL(TO_CHAR(gueltigvon_5,'yyyymmdd'),'19000101')||  '_08_' || mbiwl_5 ELSE '19000101_99_999' END,
                      CASE WHEN gueltigkz_6 = 2  AND mbiwl_6 IS NOT NULL THEN NVL(TO_CHAR(gueltigvon_6,'yyyymmdd'),'19000101')||  '_07_' || mbiwl_6 ELSE '19000101_99_999' END,
                      CASE WHEN gueltigkz_7 = 2  AND mbiwl_7 IS NOT NULL THEN NVL(TO_CHAR(gueltigvon_7,'yyyymmdd'),'19000101')||  '_06_' || mbiwl_7 ELSE '19000101_99_999' END,
                      CASE WHEN gueltigkz_8 = 2  AND mbiwl_8 IS NOT NULL THEN NVL(TO_CHAR(gueltigvon_8,'yyyymmdd'),'19000101')||  '_05_' || mbiwl_8 ELSE '19000101_99_999' END,
                      CASE WHEN gueltigkz_9 = 2  AND mbiwl_9 IS NOT NULL THEN NVL(TO_CHAR(gueltigvon_9,'yyyymmdd'),'19000101')||  '_04_' || mbiwl_9 ELSE '19000101_99_999' END,
                      CASE WHEN gueltigkz_10 = 2 AND mbiwl_10 IS NOT NULL THEN NVL(TO_CHAR(gueltigvon_10,'yyyymmdd'),'19000101')||  '_03_' || mbiwl_10 ELSE '19000101_99_999' END,
                      CASE WHEN gueltigkz_11 = 2 AND mbiwl_11 IS NOT NULL THEN NVL(TO_CHAR(gueltigvon_11,'yyyymmdd'),'19000101')||  '_02_' || mbiwl_11 ELSE '19000101_99_999' END,
                      CASE WHEN gueltigkz_12 = 2 AND mbiwl_12 IS NOT NULL THEN NVL(TO_CHAR(gueltigvon_12,'yyyymmdd'),'19000101')||  '_01_' || mbiwl_12 ELSE '19000101_99_999' END)
                      ,13)               
     WHERE codierungsart = 3
     AND mbwkz IS NULL;
     
COMMIT;


UPDATE clcc_ww_nkcodierung_1 set mbwkz = null, mbiwl = null 
WHERE mbwkz = '999'
AND codierungsart = 3;

COMMIT;



PROMPT 7.9 Default MBWKZ/MBIWL setzen
PROMPT ********************************

MERGE INTO clcc_ww_nkcodierung_1 cc
USING
(
  SELECT 
    firma,
    defaultwkz,
    defaultiwl 
  FROM sc_fu_nkcod_default dk
  JOIN sc_fu_nkcod_default_ver dv ON (dv.dwh_id_head = dk.dwh_id AND dv.dwh_valid_to = DATE '9999-12-31')
  WHERE wkzart = '2'
  AND vtsaison = &vtsaison
) x
ON (x.firma = cc.firma)
WHEN MATCHED THEN
UPDATE SET cc.mbwkz = x.defaultwkz,
           cc.mbiwl = x.defaultiwl
WHERE cc.mbwkz IS NULL
OR (cc.mbwkz = 999 and cc.mbiwl = 999);
   
COMMIT;


PROMPT 7.10 Ungueltige Mailbandtreffer kennzeichnen (Gueltigkeitszeitram oder keine Bestellung)
PROMPT *****************************************************************************************

UPDATE clcc_ww_nkcodierung_1 SET codierungsart = 21 
  WHERE codierungsart = 3
  AND (gueltigkz_1 IS NULL OR aktiv_prio1 IS NULL)
  AND (gueltigkz_2 IS NULL OR aktiv_prio2 IS NULL)
  AND (gueltigkz_3 IS NULL OR aktiv_prio3 IS NULL)
  AND (gueltigkz_4 IS NULL OR aktiv_prio4 IS NULL)
  AND (gueltigkz_5 IS NULL OR aktiv_prio5 IS NULL)
  AND (gueltigkz_6 IS NULL OR aktiv_prio6 IS NULL)
  AND (gueltigkz_7 IS NULL OR aktiv_prio7 IS NULL)
  AND (gueltigkz_8 IS NULL OR aktiv_prio8 IS NULL)
  AND (gueltigkz_9 IS NULL OR aktiv_prio9 IS NULL)
  AND (gueltigkz_10 IS NULL OR aktiv_prio10 IS NULL)
  AND (gueltigkz_11 IS NULL OR aktiv_prio11 IS NULL)
  AND (gueltigkz_12 IS NULL OR aktiv_prio12 IS NULL)
  AND wkz IS NULL
  AND iwl IS NULL;

COMMIT;



PROMPT 7.11 Besteller aus Direktkatalogen ohne gueltigen Mailbandtreffer bekommen FOLOWKZ/IWL des Kataloges nach Prio.
PROMPT ***************************************************************************************************************

MERGE INTO clcc_ww_nkcodierung_1 cc
USING
(
SELECT
   b.firma,   
   b.konto_id_key,
   MIN(LPAD(cl3.katartprio,3,0) || '_' || LPAD(folowkz,3,0) || '_' || LPAD(foloiwl,3,0)) AS priotext
FROM clcc_ww_nkcodierung_2 b  
JOIN clcc_ww_nkcodierung_3 cl3 ON (cl3.katalogart = b.katalogart and cl3.firma = b.firma AND cl3.eksaison = b.umssaison)
JOIN sc_fu_nkcod_anlcode ack ON (ack.vtsaison = cl3.vtsaison AND ack.anlcode = cl3.anlcode) 
JOIN sc_fu_nkcod_anlcode_ver acv ON (acv.dwh_id_head = ack.dwh_id AND acv.dwh_valid_to = DATE '9999-12-31') 
WHERE acv.anlcodeprio = 1
AND b.vfkz = 0
GROUP BY 
   b.firma,
   b.konto_id_key
) x
ON (x.konto_id_key = cc.konto_id_key)
WHEN MATCHED THEN
   UPDATE SET 
       cc.wkz = TO_NUMBER(SUBSTR(x.priotext,5,3)),
       cc.iwl = TO_NUMBER(SUBSTR(x.priotext,9,3))
   WHERE cc.codierungsart IN (2,21)
   AND cc.wkz IS NULL
   AND cc.iwl IS NULL;

COMMIT;



PROMPT 7.12 Bei Formlosen nochmal schauen, ob sie eine gueltige ERSTWKZ/ERSTIWL passend zur Katalogart (ueber KA-FOLOWKZ gejoint) bekommen haben, dann diese uebernehmen
PROMPT ******************************************************************************************************************************************************************

-- Hintergrund: Anlaeufer aus Reservebestellkarte haben keinen Mailbandtreffer weil sie vom Katalogempfaenger evtl. an andere Personen weitergegeben werden, 
--              haben aber evtl. die richtige WKZ/IWL bei der Bestellung angegeben. Diese Information wuerde sonst verloren gehen.

MERGE INTO clcc_ww_nkcodierung_1 ziel
 USING
(
    SELECT DISTINCT 
      cl1.konto_id_key, 
      cl1.firma, 
      erstwkz, 
      erstiwl, 
      wkz, 
      iwl
    FROM clcc_ww_nkcodierung_1 cl1
    JOIN sc_fu_nkcod_analyse sck ON (cl1.firma = sck.firma)  
    JOIN sc_fu_nkcod_analyse_ver scv ON (scv.dwh_id_head = sck.dwh_id 
                                     AND scv.dwh_valid_to = DATE '9999-12-31' 
                   AND &datum BETWEEN scv.anlaufvon AND scv.anlaufbis 
                   AND cl1.wkz = scv.folowkz 
                   AND cl1.iwl = scv.foloiwl
                   AND cl1.erstwkz BETWEEN scv.vonwkz AND scv.biswkz
                   AND cl1.erstiwl BeTWEEN scv.voniwl AND scv.bisiwl)
    WHERE codierungsart IN (2,21)
) x
 ON (x.konto_id_key = ziel.konto_id_key)
 WHEN MATCHED THEN UPDATE
    SET ziel.codierungsart = 23,
      ziel.wkz =  x.erstwkz,
      ziel.iwl =  x.erstiwl;
    
COMMIT;    


PROMPT 7.13 Bei Formlosen weiter untersuchen, ob eine Zuordnung ueber Gulivercode oder Artikelnr/Promnr (Fup Bestellanalyse Detail) möglich ist
PROMPT =======================================================================================================================================

-- Alle 5 VF-Herkunftsspalten untersuchen. Spalte 1 hat hoechste Prio
-- in andere 4 Spalten wird nur der Rest weiter untersucht.

DECLARE
    v_datum VARCHAR2(20);
BEGIN

     v_datum := TO_CHAR(&datum,'dd.mm.yyyy');

     FOR z IN 1..5 LOOP
    
         EXECUTE IMMEDIATE ('
         MERGE INTO clcc_ww_nkcodierung_1 cc
         USING
         (
            SELECT DISTINCT 
              firma, 
              gulivercode,
              wkz,
              iwl
            FROM sc_fu_nkcod_anadetail a 
            JOIN sc_fu_nkcod_anadetail_ver v ON (v.dwh_id_head = a.dwh_id AND v.dwh_valid_to = DATE ''9999-12-31'')            
            WHERE COALESCE(gulivercode,''0'') != ''0''     
            AND to_date('''||v_datum||''',''dd.mm.yyyy'') BETWEEN anlaufvon AND anlaufbis            
        ) x
        ON (x.gulivercode = cc.vfherkunft_' || z || ' AND x.firma = cc.firma)
        WHEN MATCHED THEN
           UPDATE SET cc.codierungsart = 24,
                cc.wkz = x.wkz,
                cc.iwl = x.iwl   
           WHERE cc.codierungsart IN (2,21)');
       
       COMMIT;
       
   END LOOP;       

END;
/



PROMPT 7.14 Zuordnung nur ueber Artikelnr und Promotionnr (Wenn Gulivercode in FUP nicht gefuellt)
PROMPT ===========================================================================================

-- Alle 5 VF-Herkunftsspalten untersuchen. Spalte 1 hat hoechste Prio
-- in andere 4 Spalten wird nur der Rest weiter untersucht.

DECLARE
    v_datum VARCHAR2(20);
BEGIN

     v_datum := to_char(&datum,'dd.mm.yyyy');

     FOR z IN 1..5 LOOP

         EXECUTE IMMEDIATE ('
         MERGE INTO clcc_ww_nkcodierung_1 cc
         USING
         (
         SELECT 
            firma, 
            artnr,
            promnr,
            wkz,
            iwl,
            anlaufvon,
            anlaufbis
         FROM sc_fu_nkcod_anadetail a  
         JOIN sc_fu_nkcod_anadetail_ver v ON (v.dwh_id_head = a.dwh_id AND v.dwh_valid_to = DATE ''9999-12-31'')         
         WHERE COALESCE(gulivercode,''0'') = ''0''
         AND artnr IS NOT NULL  
         AND to_date('''||v_datum||''',''dd.mm.yyyy'') BETWEEN anlaufvon AND anlaufbis         
         ) x
          ON (TO_CHAR(x.artnr) = SUBSTR(cc.vfherkunft_' || z || ',1,6) AND TO_CHAR(x.promnr) = SUBSTR(cc.vfherkunft_' || z || ',8,3) AND x.firma = cc.firma)
         WHEN MATCHED THEN
           UPDATE SET cc.codierungsart = (24),
               cc.wkz = x.wkz,
               cc.iwl = x.iwl
         WHERE cc.codierungsart IN (2,21)');
       
       COMMIT;
       
   END LOOP;       
 

END;
/



PROMPT 8. Bestellanalyse Postwurf schriftlich (WKZ und IWL von Bestellkarte uebernehmen)
PROMPT ********************************************************************************


PROMPT 8.1 Codierungsart setzen und Erstwkz/Erstiwl uebernehmen
PROMPT ========================================================

MERGE INTO clcc_ww_nkcodierung_1 cc
USING
(
SELECT DISTINCT 
   b.firma,  
   b.konto_id_key
FROM clcc_ww_nkcodierung_2 b
JOIN clcc_ww_nkcodierung_3 cl3 ON (cl3.katalogart = b.katalogart and cl3.firma = b.firma AND cl3.eksaison = b.umssaison)
JOIN sc_fu_nkcod_anlcode ack ON (ack.vtsaison = cl3.vtsaison AND ack.anlcode = cl3.anlcode) 
JOIN sc_fu_nkcod_anlcode_ver acv ON (acv.dwh_id_head = ack.dwh_id AND acv.dwh_valid_to = DATE '9999-12-31') 
WHERE acv.anlcodeprio = 2
AND b.vfkz = 0
AND b.bestweg IN (1,3)
) x
ON (x.konto_id_key = cc.konto_id_key)
WHEN MATCHED THEN
   UPDATE SET cc.codierungsart = 4,
              cc.wkz = cc.erstwkz,
              cc.iwl = cc.erstiwl
WHERE cc.codierungsart IS NULL; 
 
COMMIT;


PROMPT 8.2 Pruefen, ob ErstWKZ/ErstIWL gueltig sind und kennzeichnen (WKZIWLGUELTIG = 2)
PROMPT ====================================================================================

DECLARE 

    CURSOR curs1 IS
        SELECT DISTINCT 
             firma, 
             anlcode, 
             vonwkz, 
             biswkz, 
             voniwl, 
             bisiwl
         FROM  sc_fu_nkcod_analyse sck  
         JOIN sc_fu_nkcod_analyse_ver scv ON (scv.dwh_id_head = sck.dwh_id AND scv.dwh_valid_to = DATE '9999-12-31' AND &datum BETWEEN scv.anlaufvon AND scv.anlaufbis);

BEGIN

    FOR c1 IN curs1 loop

       UPDATE clcc_ww_nkcodierung_1 
           SET wkziwlgueltig = 2
       WHERE firma = c1.firma
       AND erstwkz BETWEEN c1.vonwkz AND c1.biswkz 
       AND erstiwl BETWEEN c1.voniwl AND c1.bisiwl
       AND codierungsart = 4;

    END LOOP;

    COMMIT;

END;
/


PROMPT 8.3 Bei ungueltige ErstWKZ/IWL bei schriftlichen Postwurf-Bestellungen WKZ und IWL wieder zuruecksetzen, bekommt unten FOLOWKZ des Kataloges
PROMPT =============================================================================================================================================

UPDATE clcc_ww_nkcodierung_1
SET
   wkz = NULL,
   iwl = NULL
WHERE codierungsart = 4
AND wkziwlgueltig IS NULL;

COMMIT;



PROMPT 9. Bestellanalyse Postwurf telefonisch/online (bekommen spaeter ihre endgueltige WKZ/IWL)
PROMPT ***************************************************************************************

PROMPT 9.1 In Topf einordnen (Codierungsart setzen)
PROMPT =============================================

MERGE INTO clcc_ww_nkcodierung_1 cc
USING
(
SELECT DISTINCT 
   b.firma, 
   b.konto_id_key
FROM clcc_ww_nkcodierung_2 b
JOIN clcc_ww_nkcodierung_3 cl3 ON (cl3.katalogart = b.katalogart AND cl3.firma = b.firma AND cl3.eksaison = b.umssaison)
JOIN sc_fu_nkcod_anlcode ack ON (ack.vtsaison = cl3.vtsaison AND ack.anlcode = cl3.anlcode) 
JOIN sc_fu_nkcod_anlcode_ver acv ON (acv.dwh_id_head = ack.dwh_id AND acv.dwh_valid_to = DATE '9999-12-31') 
WHERE acv.anlcodeprio = 2
AND b.vfkz = 0
AND b.bestweg IN (2,4)
) x
ON (x.konto_id_key = cc.konto_id_key)
WHEN MATCHED THEN
   UPDATE SET cc.codierungsart = 5
WHERE cc.codierungsart IS NULL;   
 
COMMIT;


PROMPT 9.2 Folowkz/Foloiwl setzen fuer alle unabhaengig vom Bestellweg
PROMPT ================================================================

MERGE INTO clcc_ww_nkcodierung_1 cc
USING
(
SELECT
   b.firma,  
   b.konto_id_key,
   MIN(LPAD(cl3.katartprio,3,0) || '_' || LPAD(folowkz,3,0) || '_' || LPAD(foloiwl,3,0)) AS priotext
FROM clcc_ww_nkcodierung_2 b  
JOIN clcc_ww_nkcodierung_3 cl3 ON (cl3.katalogart = b.katalogart AND cl3.firma = b.firma AND cl3.eksaison = b.umssaison)
JOIN sc_fu_nkcod_anlcode ack ON (ack.vtsaison = cl3.vtsaison AND ack.anlcode = cl3.anlcode) 
JOIN sc_fu_nkcod_anlcode_ver acv ON (acv.dwh_id_head = ack.dwh_id AND acv.dwh_valid_to = DATE '9999-12-31') 
WHERE acv.anlcodeprio = 2
AND b.vfkz = 0
GROUP BY 
   b.firma,
   b.konto_id_key
) x
ON (x.konto_id_key = cc.konto_id_key)
WHEN MATCHED THEN
   UPDATE SET 
       cc.wkz = TO_NUMBER(SUBSTR(x.priotext,5,3)),
       cc.iwl = TO_NUMBER(SUBSTR(x.priotext,9,3))
WHERE cc.codierungsart IN (4,5)
AND cc.wkz IS NULL
AND cc.iwl IS NULL;

COMMIT;



PROMPT 10. Bestellanalyse Flyer (schriftlich ueber Bestellkarte)
PROMPT ********************************************************

PROMPT 10.1 In Topf einordnen (Codierungsart setzen)
PROMPT =============================================

MERGE INTO clcc_ww_nkcodierung_1 cc
USING
(
SELECT DISTINCT 
   b.firma,  
   b.konto_id_key
FROM clcc_ww_nkcodierung_2 b
JOIN clcc_ww_nkcodierung_3 cl3 ON (cl3.katalogart = b.katalogart AND cl3.firma = b.firma AND cl3.eksaison = b.umssaison)
JOIN sc_fu_nkcod_anlcode ack ON (ack.vtsaison = cl3.vtsaison AND ack.anlcode = cl3.anlcode) 
JOIN sc_fu_nkcod_anlcode_ver acv ON (acv.dwh_id_head = ack.dwh_id AND acv.dwh_valid_to = DATE '9999-12-31') 
WHERE acv.anlcodeprio = 3
AND b.vfkz = 0
AND b.bestweg IN (1,3)
) x
ON (x.konto_id_key = cc.konto_id_key)
WHEN MATCHED THEN
   UPDATE SET cc.codierungsart = 7
WHERE cc.codierungsart IS NULL;   
 
COMMIT;



PROMPT 10.2 Pruefen, ob ErstWKZ/ErstIWL gueltig sind und kennzeichnen (WKZIWLGUELTIG = 2)
PROMPT ===================================================================================

DECLARE 

    CURSOR curs1 IS
        SELECT DISTINCT 
            firma, 
            anlcode, 
            vonwkz, 
            biswkz, 
            voniwl, 
            bisiwl
         FROM  sc_fu_nkcod_analyse sck  
         JOIN sc_fu_nkcod_analyse_ver scv ON (scv.dwh_id_head = sck.dwh_id AND scv.dwh_valid_to = DATE '9999-12-31' AND &datum BETWEEN scv.anlaufvon AND scv.anlaufbis);

BEGIN

    FOR c1 IN curs1 LOOP

       UPDATE clcc_ww_nkcodierung_1 
           SET wkziwlgueltig = 2
       WHERE firma = c1.firma
       AND erstwkz BETWEEN c1.vonwkz AND c1.biswkz 
       AND erstiwl BETWEEN c1.voniwl AND c1.bisiwl
       AND codierungsart = 7;

    END LOOP;

    COMMIT;

END;
/

PROMPT 10.3 Ungueltige ErstWKZ/IWL bei schriftlichen Flyer-Bestellungen auf Codierungsart 22 setzen, diese durchlaufen die Bestellanalyse
PROMPT ============================================================================================================================

UPDATE clcc_ww_nkcodierung_1
SET codierungsart = 22 
WHERE codierungsart = 7
AND wkziwlgueltig IS NULL;

COMMIT;



PROMPT 11. Bestellanalyse Flyer (telefonisch/online)  (in Topf einordnent = Codierungsart setzen)
PROMPT ******************************************************************************************

MERGE INTO clcc_ww_nkcodierung_1 cc
USING
(
  SELECT DISTINCT 
    b.firma,  
    b.konto_id_key
  FROM clcc_ww_nkcodierung_2 b
  JOIN clcc_ww_nkcodierung_3 cl3 ON (cl3.katalogart = b.katalogart AND cl3.firma = b.firma AND cl3.eksaison = b.umssaison)
  JOIN sc_fu_nkcod_anlcode ack ON (ack.vtsaison = cl3.vtsaison AND ack.anlcode = cl3.anlcode) 
  JOIN sc_fu_nkcod_anlcode_ver acv ON (acv.dwh_id_head = ack.dwh_id AND acv.dwh_valid_to = DATE '9999-12-31') 
  WHERE acv.anlcodeprio = 3
  AND b.vfkz = 0
  AND b.bestweg IN (2,4)
) x
ON (x.konto_id_key = cc.konto_id_key)
WHEN MATCHED THEN
   UPDATE SET cc.codierungsart = 8   
WHERE cc.codierungsart IS NULL;   
 
COMMIT;



PROMPT 12. Bestellanalyse Flyer Detail
PROMPT *******************************

PROMPT 12.1 Zuordnung ueber Gulivercode (Wenn Gulivercode in FUP gefuellt)
PROMPT ==================================================================

-- Alle 5 VF-Herkunftsspalten untersuchen. Spalte 1 hat hoechste Prio
-- in andere 4 Spalten wird nur der Rest weiter untersucht.

DECLARE
     v_datum VARCHAR2(20);
BEGIN

     v_datum := to_char(&datum,'dd.mm.yyyy');

     FOR z IN 1..5 LOOP
    
         EXECUTE IMMEDIATE ('
         MERGE INTO clcc_ww_nkcodierung_1 cc
         USING
         (
            SELECT DISTINCT
              firma, 
              gulivercode,
              wkz,
              iwl
            FROM sc_fu_nkcod_anadetail a 
            JOIN sc_fu_nkcod_anadetail_ver v ON (v.dwh_id_head = a.dwh_id AND v.dwh_valid_to = DATE ''9999-12-31'')            
            WHERE COALESCE(gulivercode,''0'') != ''0'' 
            AND to_date('''||v_datum||''',''dd.mm.yyyy'') BETWEEN anlaufvon AND anlaufbis            
        ) x
        ON (x.gulivercode = cc.vfherkunft_' || z || ' AND x.firma = cc.firma)
        WHEN MATCHED THEN
           UPDATE SET cc.codierungsart = (6),
                cc.wkz = x.wkz,
                cc.iwl = x.iwl   
           WHERE cc.codierungsart IN (8,22)');
       
       COMMIT;
       
   END LOOP;       

END;
/



PROMPT 12.2 Zuordnung nur ueber Artikelnr und Promotionnr (Wenn Gulivercode in FUP gefuellt)
PROMPT ===================================================================================

-- Alle 5 VF-Herkunftsspalten untersuchen. Spalte 1 hat hoechste Prio
-- in andere 4 Spalten wird nur der Rest weiter untersucht.

DECLARE
    v_datum VARCHAR2(20);
BEGIN

     v_datum := to_char(&datum,'dd.mm.yyyy');

     FOR z IN 1..5 LOOP

         EXECUTE IMMEDIATE ('
         MERGE INTO clcc_ww_nkcodierung_1 cc
         USING
         (
          SELECT
              firma,
              artnr,
              promnr,
              wkz,
              iwl,
              anlaufvon,
              anlaufbis
          FROM (
              SELECT DISTINCT
                  firma,
                  artnr,
                  promnr,
                  wkz,
                  iwl,
                  anlaufvon,
                  anlaufbis,
                  ROW_NUMBER() OVER (PARTITION BY artnr, promnr, firma ORDER BY wkz ASC) AS rn
              FROM sc_fu_nkcod_anadetail a
              JOIN sc_fu_nkcod_anadetail_ver v ON (v.dwh_id_head = a.dwh_id AND v.dwh_valid_to = DATE ''9999-12-31'')
              WHERE COALESCE(gulivercode,''0'') = ''0''
              AND artnr IS NOT NULL
              AND to_date('''||v_datum||''',''dd.mm.yyyy'') BETWEEN anlaufvon AND anlaufbis
          )
          WHERE rn = 1
         ) x
          ON (TO_CHAR(x.artnr) = SUBSTR(cc.vfherkunft_' || z || ',1,6) AND TO_CHAR(x.promnr) = SUBSTR(cc.vfherkunft_' || z || ',8,3) AND x.firma = cc.firma)
         WHEN MATCHED THEN
           UPDATE SET cc.codierungsart = (6),
               cc.wkz = x.wkz,
               cc.iwl = x.iwl
         WHERE cc.codierungsart IN (8,22)');
       
       COMMIT;
       
   END LOOP;       
 

END;
/


PROMPT 12.3 Fuer alle Flyer-Besteller aus codierungsart 7 (schriftlich) die Erstwkz/Erstiwl von der Bestellkarte verwenden. Zusaetzlich muss die Erstwkz/Erstiwl gueltig sein, sonst Codierungsart = 22
PROMPT =================================================================================================================================================================================================

UPDATE clcc_ww_nkcodierung_1 cc
SET wkz = erstwkz,
    iwl = erstiwl
    WHERE codierungsart = 7
    AND wkz IS NULL;
    
COMMIT;


PROMPT 12.4 telefonische/online Besteller aus Flyer ohne Treffer in Bestellanalyse Detail
PROMPT oder schriftlich ohne ERSTWKZ/ERSTIWL bekommen die FOLOWKZ/IWL
PROMPT =======================================================================================================

MERGE INTO clcc_ww_nkcodierung_1 cc
USING
(
  SELECT
     b.firma,   
     b.konto_id_key,
     MIN(LPAD(cl3.katartprio,3,0) || '_' || LPAD(folowkz,3,0) || '_' || LPAD(foloiwl,3,0)) AS priotext
  FROM clcc_ww_nkcodierung_2 b  
  JOIN clcc_ww_nkcodierung_3 cl3 ON (cl3.katalogart = b.katalogart AND cl3.firma = b.firma AND cl3.eksaison = b.umssaison)
  JOIN sc_fu_nkcod_anlcode ack ON (ack.vtsaison = cl3.vtsaison AND ack.anlcode = cl3.anlcode) 
  JOIN sc_fu_nkcod_anlcode_ver acv ON (acv.dwh_id_head = ack.dwh_id AND acv.dwh_valid_to = DATE '9999-12-31') 
  WHERE acv.anlcodeprio = 3
  AND b.vfkz = 0
  GROUP BY b.firma, 
           b.konto_id_key
) x
ON (x.konto_id_key = cc.konto_id_key)
WHEN MATCHED THEN
   UPDATE SET 
       cc.wkz = TO_NUMBER(SUBSTR(x.priotext,5,3)),
       cc.iwl = TO_NUMBER(SUBSTR(x.priotext,9,3))
WHERE cc.codierungsart IN (7, 8, 22)
AND cc.wkz IS NULL
AND cc.iwl IS NULL;

COMMIT;


PROMPT 13. Bestellanalyse Anzeigen (schriftlich ueber Bestellkarte)
PROMPT **************************************************************

PROMPT 13.1 In Topf einordnen (Codierungsart setzen)
PROMPT =============================================

MERGE INTO clcc_ww_nkcodierung_1 cc
USING
(
SELECT DISTINCT 
   b.firma,  
   b.konto_id_key
FROM clcc_ww_nkcodierung_2 b
JOIN clcc_ww_nkcodierung_3 cl3 ON (cl3.katalogart = b.katalogart AND cl3.firma = b.firma AND cl3.eksaison = b.umssaison)
JOIN sc_fu_nkcod_anlcode ack ON (ack.vtsaison = cl3.vtsaison AND ack.anlcode = cl3.anlcode) 
JOIN sc_fu_nkcod_anlcode_ver acv ON (acv.dwh_id_head = ack.dwh_id AND acv.dwh_valid_to = DATE '9999-12-31') 
WHERE acv.anlcodeprio = 4
AND b.vfkz = 0
AND b.bestweg IN (1,3)
) x
ON (x.konto_id_key = cc.konto_id_key)
WHEN MATCHED THEN
   UPDATE SET cc.codierungsart = 10
WHERE cc.codierungsart IS NULL;   
 
COMMIT;



PROMPT 13.2 Pruefen, ob ErstWKZ/ErstIWL gueltig sind und kennzeichnen (WKZIWLGUELTIG = 2)
PROMPT ===================================================================================

DECLARE 

    CURSOR curs1 IS
        SELECT DISTINCT 
            firma, 
            anlcode, 
            vonwkz, 
            biswkz, 
            voniwl, 
            bisiwl
         FROM  sc_fu_nkcod_analyse sck  
         JOIN sc_fu_nkcod_analyse_ver scv ON (scv.dwh_id_head = sck.dwh_id AND scv.dwh_valid_to = DATE '9999-12-31' AND &datum BETWEEN scv.anlaufvon AND scv.anlaufbis);

BEGIN

    FOR c1 IN curs1 LOOP

       UPDATE clcc_ww_nkcodierung_1 
           SET wkziwlgueltig = 2
       WHERE firma = c1.firma
       AND erstwkz BETWEEN c1.vonwkz AND c1.biswkz 
       AND erstiwl BETWEEN c1.voniwl AND c1.bisiwl
       AND codierungsart = 10;

    END LOOP;

    COMMIT;

END;
/

PROMPT 13.3 Ungueltige ErstWKZ/IWL bei schriftlichen Anzeigen-Bestellungen auf Codierungsart 25 setzen, diese durchlaufen die Bestellanalyse-Detail
PROMPT ==============================================================================================================================================

UPDATE clcc_ww_nkcodierung_1
SET codierungsart = 25 
WHERE codierungsart = 10
AND wkziwlgueltig IS NULL;

COMMIT;



PROMPT 14. Bestellanalyse Anzeigen (telefonisch/online)  (in Topf einordnen = Codierungsart setzen)
PROMPT ******************************************************************************************

MERGE INTO clcc_ww_nkcodierung_1 cc
USING
(
  SELECT DISTINCT 
    b.firma,  
    b.konto_id_key
  FROM clcc_ww_nkcodierung_2 b
  JOIN clcc_ww_nkcodierung_3 cl3 ON (cl3.katalogart = b.katalogart AND cl3.firma = b.firma AND cl3.eksaison = b.umssaison)
  JOIN sc_fu_nkcod_anlcode ack ON (ack.vtsaison = cl3.vtsaison AND ack.anlcode = cl3.anlcode) 
  JOIN sc_fu_nkcod_anlcode_ver acv ON (acv.dwh_id_head = ack.dwh_id AND acv.dwh_valid_to = DATE '9999-12-31') 
  WHERE acv.anlcodeprio = 4
  AND b.vfkz = 0
  AND b.bestweg IN (2,4)
) x
ON (x.konto_id_key = cc.konto_id_key)
WHEN MATCHED THEN
   UPDATE SET cc.codierungsart = 11 
WHERE cc.codierungsart IS NULL;   
 
COMMIT;



PROMPT 15. Bestellanalyse Anzeigen Detail (bei telefonischen/online Bestellungen (nkcodart=11) oder schriftlichen mit ungueltiger Erstwkz/Erstiwl (nkcodart = 25))
PROMPT ************************************************************************************************************************************************************

PROMPT 15.1 Zuordnung ueber Gulivercode (Wenn Gulivercode in FUP gefuellt)
PROMPT ==================================================================

-- Alle 5 VF-Herkunftsspalten untersuchen. Spalte 1 hat hoechste Prio
-- in andere 4 Spalten wird nur der Rest weiter untersucht.

DECLARE
    v_datum VARCHAR2(20);
BEGIN

     v_datum := to_char(&datum,'dd.mm.yyyy');

     FOR z IN 1..5 LOOP
    
         EXECUTE IMMEDIATE ('
         MERGE INTO clcc_ww_nkcodierung_1 cc
         USING
         (
            SELECT 
              firma, 
              gulivercode,
              wkz,
              iwl,
              anlaufvon,
              anlaufbis
            FROM sc_fu_nkcod_anadetail a 
            JOIN sc_fu_nkcod_anadetail_ver v ON (v.dwh_id_head = a.dwh_id AND v.dwh_valid_to = DATE ''9999-12-31'')            
            WHERE COALESCE(gulivercode,''0'') != ''0''     
            AND to_date('''||v_datum||''',''dd.mm.yyyy'') BETWEEN anlaufvon AND anlaufbis            
        ) x
        ON (x.gulivercode = cc.vfherkunft_' || z || ' AND x.firma = cc.firma)
        WHEN MATCHED THEN
           UPDATE SET cc.codierungsart = (9),
                cc.wkz = x.wkz,
                cc.iwl = x.iwl   
           WHERE cc.codierungsart IN (11,25)');
       
       COMMIT;
       
   END LOOP;       

END;
/



PROMPT 15.2 Zuordnung nur ueber Artikelnr und Promotionnr (Wenn Gulivercode in FUP gefuellt)
PROMPT ===================================================================================

-- Alle 5 VF-Herkunftsspalten untersuchen. Spalte 1 hat hoechste Prio
-- in andere 4 Spalten wird nur der Rest weiter untersucht.

DECLARE
    v_datum VARCHAR2(20);
BEGIN

     v_datum := to_char(&datum,'dd.mm.yyyy');

     FOR z IN 1..5 LOOP

         EXECUTE IMMEDIATE ('
         MERGE INTO clcc_ww_nkcodierung_1 cc
         USING
         (
         SELECT 
            firma, 
            artnr,
            promnr,
            wkz,
            iwl,
            anlaufvon,
            anlaufbis
         FROM sc_fu_nkcod_anadetail a  
         JOIN sc_fu_nkcod_anadetail_ver v ON (v.dwh_id_head = a.dwh_id AND v.dwh_valid_to = DATE ''9999-12-31'')         
         WHERE COALESCE(gulivercode,''0'') = ''0''
         AND artnr IS NOT NULL  
         AND to_date('''||v_datum||''',''dd.mm.yyyy'') BETWEEN anlaufvon AND anlaufbis         
         ) x
          ON (TO_CHAR(x.artnr) = SUBSTR(cc.vfherkunft_' || z || ',1,6) AND TO_CHAR(x.promnr) = SUBSTR(cc.vfherkunft_' || z || ',8,3) AND x.firma = cc.firma)
         WHEN MATCHED THEN
           UPDATE SET cc.codierungsart = (9),
               cc.wkz = x.wkz,
               cc.iwl = x.iwl
         WHERE cc.codierungsart IN (11,25)');
       
       COMMIT;
       
   END LOOP;       
 

END;
/


PROMPT 15.3 Fuer alle Anzeigen-Besteller aus codierungsart 10 (schriftlich) die Erstwkz/Erstiwl von der Bestellkarte verwenden. Zusaetzlich muss die Erstwkz/Erstiwl gueltig sein, sonst Codierungsart = 25
PROMPT =====================================================================================================================================================================================================

UPDATE clcc_ww_nkcodierung_1 cc
SET wkz = erstwkz,
    iwl = erstiwl
    WHERE codierungsart = 10
    AND wkz IS NULL;
    
COMMIT;


PROMPT 15.4 telefonische/online Besteller aus Anzeige ohne Treffer in Bestellanalyse Detail
PROMPT oder schriftlich ohne ERSTWKZ/ERSTIWL bekommen die FOLOWKZ/IWL
PROMPT =======================================================================================================

MERGE INTO clcc_ww_nkcodierung_1 cc
USING
(
  SELECT
     b.firma,   
     b.konto_id_key,
     MIN(LPAD(cl3.katartprio,3,0) || '_' || LPAD(folowkz,3,0) || '_' || LPAD(foloiwl,3,0)) AS priotext
  FROM clcc_ww_nkcodierung_2 b  
  JOIN clcc_ww_nkcodierung_3 cl3 ON (cl3.katalogart = b.katalogart AND cl3.firma = b.firma AND cl3.eksaison = b.umssaison)
  JOIN sc_fu_nkcod_anlcode ack ON (ack.vtsaison = cl3.vtsaison AND ack.anlcode = cl3.anlcode) 
  JOIN sc_fu_nkcod_anlcode_ver acv ON (acv.dwh_id_head = ack.dwh_id AND acv.dwh_valid_to = DATE '9999-12-31') 
  WHERE acv.anlcodeprio = 4
  AND b.vfkz = 0
  GROUP BY b.firma, b.konto_id_key
) x
ON (x.konto_id_key = cc.konto_id_key)
WHEN MATCHED THEN
   UPDATE SET 
       cc.wkz = TO_NUMBER(SUBSTR(x.priotext,5,3)),
       cc.iwl = TO_NUMBER(SUBSTR(x.priotext,9,3))
WHERE cc.codierungsart IN (10, 11, 25)
AND cc.wkz IS NULL
AND cc.iwl IS NULL;

COMMIT;



PROMPT xx. Bestellanalyse Teleshopping (ab FS 20)
PROMPT *******************************************

PROMPT xx.1 In Topf einordnen
PROMPT =======================

MERGE INTO clcc_ww_nkcodierung_1 cc
USING
(
  SELECT DISTINCT 
    b.firma,  
    b.konto_id_key
  FROM clcc_ww_nkcodierung_2 b
  JOIN clcc_ww_nkcodierung_3 cl3 ON (cl3.katalogart = b.katalogart AND cl3.firma = b.firma AND cl3.eksaison = b.umssaison)
  JOIN sc_fu_nkcod_anlcode ack ON (ack.vtsaison = cl3.vtsaison AND ack.anlcode = cl3.anlcode) 
  JOIN sc_fu_nkcod_anlcode_ver acv ON (acv.dwh_id_head = ack.dwh_id AND acv.dwh_valid_to = DATE '9999-12-31') 
  AND acv.anlcodeprio = CASE  WHEN PKG_IM_ZEIT.F_VTSAISON_ENDEDATUM(&vtsaison) >  TO_DATE('31.12.2019','DD.MM.YYYY') THEN 5 ELSE NULL END
  AND b.vfkz = 0
) x
ON (x.konto_id_key = cc.konto_id_key)
WHEN MATCHED THEN
   UPDATE SET cc.codierungsart = 27 
WHERE cc.codierungsart IS NULL;   
 
COMMIT;

PROMPT xx.2 Detailanalyse über Artikelnr/Promotionr
PROMPT =============================================

MERGE INTO clcc_ww_nkcodierung_1 cc
 USING
  (
    SELECT DISTINCT konto_id_key, 
                    firma, 
                    wkz, 
                    iwl
    FROM
        ( 
         SELECT DISTINCT 
            cl2.firma, 
            cl2.konto_id_key,
            cl2.artnr,
            cl2.promnr,
            x.wkz,
            x.iwl,
            anlaufvon,
            anlaufbis
         FROM clcc_ww_nkcodierung_2 cl2
         JOIN (
          SELECT firma, artnr, a.promnr, ver.wkz, iwl, anlaufvon, anlaufbis, eksaison 
          FROM sc_fu_nkcod_anadetail a  
          JOIN sc_fu_nkcod_anadetail_ver ver ON (ver.dwh_id_head = a.dwh_id AND ver.dwh_valid_to = DATE '9999-12-31')
          WHERE &datum BETWEEN anlaufvon AND anlaufbis
          AND anlcode = 78
        ) x  ON (x.firma = cl2.firma AND x.artnr = cl2.artnr AND x.promnr = cl2.promnr and x.eksaison = cl2.umssaison)
       )
 ) x2
 ON (x2.konto_id_key = cc.konto_id_key)
 WHEN MATCHED THEN
 UPDATE SET 
       cc.wkz = x2.wkz,
       cc.iwl = x2.iwl
 WHERE cc.codierungsart = 27;
       
COMMIT;
       

PROMPT xx.3 Besteller aus Katalogart aber ohne Treffer in Bestellanalyse bekommen FOLWKZ/IWL der Katalogart
PROMPT =======================================================================================================

MERGE INTO clcc_ww_nkcodierung_1 cc
USING
(
  SELECT
     b.firma,   
     b.konto_id_key,
     MIN(LPAD(cl3.katartprio,3,0) || '_' || LPAD(folowkz,3,0) || '_' || LPAD(foloiwl,3,0)) AS priotext
  FROM clcc_ww_nkcodierung_2 b  
  JOIN clcc_ww_nkcodierung_3 cl3 ON (cl3.katalogart = b.katalogart AND cl3.firma = b.firma AND cl3.eksaison = b.umssaison)
  JOIN sc_fu_nkcod_anlcode ack ON (ack.vtsaison = cl3.vtsaison AND ack.anlcode = cl3.anlcode) 
  JOIN sc_fu_nkcod_anlcode_ver acv ON (acv.dwh_id_head = ack.dwh_id AND acv.dwh_valid_to = DATE '9999-12-31') 
  WHERE acv.anlcodeprio = CASE WHEN PKG_IM_ZEIT.F_VTSAISON_ENDEDATUM(&vtsaison) >  TO_DATE('31.12.2019','DD.MM.YYYY') THEN 5 ELSE NULL END
  AND b.vfkz = 0
  GROUP BY b.firma, b.konto_id_key
) x
ON (x.konto_id_key = cc.konto_id_key)
WHEN MATCHED THEN
   UPDATE SET 
       cc.wkz = TO_NUMBER(SUBSTR(x.priotext,5,3)),
       cc.iwl = TO_NUMBER(SUBSTR(x.priotext,9,3))
WHERE cc.codierungsart = 27
AND cc.wkz IS NULL
AND cc.iwl IS NULL;

COMMIT;


PROMPT 16. Bestellanalyse Internet 
PROMPT **************************

-- Minimale WKZ verwendet !!!!

PROMPT 16.1 Bestellung mit Internet-Katalogart (Shopbestellung)
PROMPT ==========================================================

-- Besonderheit: Bei Internet NK muss EKSaison nicht im FUP gepflegt werden
--               und wird deshalb auch nicht im Join verwendet

MERGE INTO clcc_ww_nkcodierung_1 cc
USING
(
SELECT  
   b.firma,  
   b.konto_id_key,
   MIN(LPAD(b.ecc,5,'0') || LPAD(b.wkz,5,'0')) AS codierung,
   MIN(LPAD(b.ecc,5,'0') || LPAD(b.wkz_wp,5,'0')) AS codierung_wp,
   MAX(b.brand) AS brand
FROM clcc_ww_nkcodierung_2 b
JOIN clcc_ww_nkcodierung_3 cl3 ON (cl3.katalogart = b.katalogart and cl3.firma = b.firma)
JOIN sc_fu_nkcod_anlcode ack ON (ack.vtsaison = cl3.vtsaison AND ack.anlcode = cl3.anlcode) 
JOIN sc_fu_nkcod_anlcode_ver acv ON (acv.dwh_id_head = ack.dwh_id AND acv.dwh_valid_to = DATE '9999-12-31') 
--WHERE acv.anlcodeprio = 5
WHERE acv.anlcodeprio = CASE WHEN PKG_IM_ZEIT.F_VTSAISON_ENDEDATUM(&vtsaison) <= TO_DATE('31.12.2019','DD.MM.YYYY') THEN 5  --Verschiebung der ANLCODEPRIO von Saison HW19 auf FS20 durch Einbau von Teleshopping
                             WHEN PKG_IM_ZEIT.F_VTSAISON_ENDEDATUM(&vtsaison) >  TO_DATE('31.12.2019','DD.MM.YYYY') THEN 6
                             ELSE 6 END
AND b.vfkz = 0
GROUP BY 
  b.firma,
  b.konto_id_key
) x
ON (x.konto_id_key = cc.konto_id_key)  
WHEN MATCHED THEN
   UPDATE SET cc.codierungsart = 12,
         --     cc.wkz = CASE WHEN cc.firma = 68 THEN SUBSTR(x.codierung_wp,6,5) ELSE SUBSTR(x.codierung,6,5) END,
         --     cc.iwl = CASE WHEN cc.firma = 68 THEN SUBSTR(x.codierung_wp,1,5) ELSE SUBSTR(x.codierung,1,5) END,   
              cc.wkz = CASE WHEN cc.firma = 18 AND F_WP_EIGENEFIRMA(&datum) = 0 THEN SUBSTR(x.codierung_wp,6,5) ELSE SUBSTR(x.codierung,6,5) END,
              cc.iwl = CASE WHEN cc.firma = 18 AND F_WP_EIGENEFIRMA(&datum) = 0 THEN SUBSTR(x.codierung_wp,1,5) ELSE SUBSTR(x.codierung,1,5) END,              
              cc.brand = x.brand
WHERE cc.codierungsart IS NULL;   
  
COMMIT;



PROMPT 16.2 Mailband-Treffer vorhanden im angegebenen Zeitraum (PAL+30 Tage) - nur bei Brand-Neukunden
PROMPT ================================================================================================

-- Grundrauschentest-Ausschluss Saison 144 WKZ 422

PROMPT Treffer 1 bis 12 verarbeiten

DECLARE
    v_datum VARCHAR2(20);
    v_hjanfang VARCHAR2(20);

BEGIN

   v_datum := TO_CHAR(&datum,'dd.mm.yyyy');
   v_hjanfang := TO_CHAR(&hjanfang ,'dd.mm.yyyy');
   
   FOR z IN 1..12 LOOP

      EXECUTE IMMEDIATE ('
      MERGE INTO clcc_ww_nkcodierung_1 cc
      USING
      (
         SELECT DISTINCT
          cl.rowid AS rowi, 
          x.versand_datum, 
          cl.anlagedat, 
--          ROUND(cl.anlagedat - x.versand_datum) AS zeitdiff, 
          ROUND(CASE WHEN ku.vtinfogrp = 801 AND cl.firma = 1 AND cl.anlagedat < to_date(''' || v_hjanfang || ''',''dd.mm.yyyy'') THEN to_date('''||v_datum||''',''dd.mm.yyyy'') ELSE cl.anlagedat END - x.versand_datum) AS zeitdiff,           
          sc.wkz_' || z || ', 
          sc.iwl_' || z || '
         FROM clcc_ww_nkcodierung_1 cl 
         LEFT OUTER JOIN cc_kunde_&vtsaison ku ON (ku.konto_id_key = cl.konto_id_key AND to_date('''||v_datum||''',''dd.mm.yyyy'') - 0.5 BETWEEN ku.dwh_valid_from AND ku.dwh_valid_to)         
         JOIN sc_ww_nk_kunde sc ON (sc.konto_id_key = cl.konto_id_key AND sc.firma = cl.firma)
         JOIN 
           ( 
              SELECT DISTINCT abg_id, wkz, versand_datum
              FROM sc_im_adb_abgleich_codeplan_pos cp
              JOIN sc_im_adb_abgleich_codeplan_pos_ver cpv ON (cpv.dwh_id_head = cp.dwh_id AND cpv.dwh_status = 1)
           ) x
         ON (x.abg_id = sc.abglid_' || z || ' AND x.wkz = sc.wkz_' || z || ')
         WHERE codierungsart = 12
         AND brand = 2
         AND abglid_' || z || ' IS NOT NULL
      ) x2
      ON (x2.rowi = cc.rowid)
     WHEN MATCHED THEN
        UPDATE SET 
               cc.codierungsart = 13,
               cc.wkz = x2.wkz_' || z || ',
               cc.iwl = x2.iwl_' || z || '
     WHERE x2.zeitdiff <= 30
     AND (&vtsaison || cc.firma || x2.wkz_' || z || ' != ''1211422'')');     

     COMMIT;

   END LOOP;
   
END;
/



PROMPT 16.3 Besteller aus Shopkatalogen ohne ECC bzw. keinen Treffer im ECC-FUP bekommen FOLOWKZ/IWL des Kataloges nach Prio.
PROMPT ======================================================================================================================

MERGE INTO clcc_ww_nkcodierung_1 cc
USING
(
  SELECT
     b.firma,   
     b.konto_id_key,
     MIN(LPAD(cl3.katartprio,3,0) || '_' || LPAD(folowkz,3,0) || '_' || LPAD(foloiwl,3,0)) AS priotext
  FROM clcc_ww_nkcodierung_2 b  
  JOIN clcc_ww_nkcodierung_3 cl3 ON (cl3.katalogart = b.katalogart and cl3.firma = b.firma)
  JOIN sc_fu_nkcod_anlcode ack ON (ack.vtsaison = cl3.vtsaison AND ack.anlcode = cl3.anlcode) 
  JOIN sc_fu_nkcod_anlcode_ver acv ON (acv.dwh_id_head = ack.dwh_id AND acv.dwh_valid_to = DATE '9999-12-31') 
--  WHERE acv.anlcodeprio = 5
  WHERE acv.anlcodeprio = CASE WHEN PKG_IM_ZEIT.F_VTSAISON_ENDEDATUM(&vtsaison) <= TO_DATE('31.12.2019','DD.MM.YYYY') THEN 5  --Verschiebung der ANLCODEPRIO von Saison HW19 auf FS20 durch Einbau von Teleshopping
                             WHEN PKG_IM_ZEIT.F_VTSAISON_ENDEDATUM(&vtsaison) >  TO_DATE('31.12.2019','DD.MM.YYYY') THEN 6
                             ELSE 6 END  
  AND b.vfkz = 0
  GROUP BY b.firma, b.konto_id_key
) x
ON (x.konto_id_key = cc.konto_id_key)
WHEN MATCHED THEN
   UPDATE SET 
       cc.wkz = TO_NUMBER(SUBSTR(x.priotext,5,3)),
       cc.iwl = TO_NUMBER(SUBSTR(x.priotext,9,3))
WHERE cc.codierungsart = 12
 AND cc.wkz IS NULL;
 
-- AND cc.iwl IS NULL;

-- Daten für neue Saison im ECC FUP fehlen noch  --FS20

COMMIT;



PROMPT 17. Dummy-Witt und Waeschepur Konten
PROMPT ***********************************

PROMPT 17.1 Dummy-Witt Konto bei Waeschepur-Only Anlaeufer
PROMPT ===================================================


--entfernt

PROMPT 17.2 Dummy-Waepu Konto falls keine Waeschepur-Buchung vorhanden ist.
PROMPT =====================================================================

--entfernt



PROMPT 18. Formlose
PROMPT ************

PROMPT 18.1 Formlose ohne Bestellung
PROMPT =============================

MERGE INTO clcc_ww_nkcodierung_1 cc
USING
(
  SELECT DISTINCT 
     konto_id_key, 
     firma
  FROM clcc_ww_nkcodierung_1
  WHERE codierungsart IS NULL
    MINUS
  SELECT
     konto_id_key,
     firma
  FROM clcc_ww_nkcodierung_2 
) x
 ON (x.konto_id_key = cc.konto_id_key)
WHEN MATCHED THEN 
      UPDATE SET codierungsart = 15
WHERE cc.codierungsart IS NULL;
    
COMMIT;


PROMPT 18.2 Formlose GZG Only
PROMPT =============================

MERGE INTO clcc_ww_nkcodierung_1 cc
USING
(
  SELECT DISTINCT 
     konto_id_key, 
     firma
  FROM clcc_ww_nkcodierung_1
  WHERE codierungsart IS NULL
  INTERSECT
  SELECT
     konto_id_key,
     firma
  FROM clcc_ww_nkcodierung_2
  HAVING SIGN(SUM(CASE WHEN vfkz = 1 THEN 1 ELSE 0 END))*10+ 
     SIGN(SUM(CASE WHEN vfkz != 1 THEN 1 ELSE 0 END)) = 10
  GROUP BY konto_id_key, firma
) x
 ON (x.konto_id_key = cc.konto_id_key)
 WHEN MATCHED THEN 
      UPDATE SET codierungsart = 20,
       wkz = 0,
       iwl = 0
WHERE cc.codierungsart IS NULL;
    
COMMIT;



PROMPT 18.3 GZG-Only WKZ aus Default FUP holen
PROMPT ========================================

MERGE INTO clcc_ww_nkcodierung_1 cc
USING
(
  SELECT 
    firma,
    defaultwkz,
    defaultiwl 
  FROM sc_fu_nkcod_default dk
  JOIN sc_fu_nkcod_default_ver dv ON (dv.dwh_id_head = dk.dwh_id AND dv.dwh_valid_to = DATE '9999-12-31')
  WHERE wkzart = '3'
  AND vtsaison = &vtsaison
) x
ON (x.firma = cc.firma)
WHEN MATCHED THEN
   UPDATE SET cc.wkz = x.defaultwkz,
              cc.iwl = x.defaultiwl
WHERE cc.codierungsart = 20;
   
COMMIT;



PROMPT 18.4 Formlose Bestellung (Rest)
PROMPT =============================

UPDATE clcc_ww_nkcodierung_1 
   SET 
        codierungsart = 14
WHERE codierungsart IS NULL;

COMMIT;



PROMPT 18.5 Folowkz/Foloiwl setzen
PROMPT ============================

MERGE INTO clcc_ww_nkcodierung_1 cc
USING
(
  SELECT DISTINCT 
     cl3.firma,
     cl3.folowkz,
     cl3.foloiwl,
     cl3.anlcode
  FROM clcc_ww_nkcodierung_3 cl3 
  JOIN sc_fu_nkcod_anlcode ack ON (ack.vtsaison = cl3.vtsaison AND ack.anlcode = cl3.anlcode) 
  JOIN sc_fu_nkcod_anlcode_ver acv ON (acv.dwh_id_head = ack.dwh_id AND acv.dwh_valid_to = DATE '9999-12-31') 
  --AND acv.anlcodeprio = 6
  AND acv.anlcodeprio = CASE WHEN PKG_IM_ZEIT.F_VTSAISON_ENDEDATUM(&vtsaison) <= TO_DATE('31.12.2019','DD.MM.YYYY') THEN 6  --Verschiebung der ANLCODEPRIO von Saison HW19 auf FS20 durch Einbau von Teleshopping
                             WHEN PKG_IM_ZEIT.F_VTSAISON_ENDEDATUM(&vtsaison) >  TO_DATE('31.12.2019','DD.MM.YYYY') THEN 7
                             ELSE 7 END
) x
ON (x.firma = cc.firma)
WHEN MATCHED THEN
   UPDATE SET 
       cc.wkz = x.folowkz,
       cc.iwl = x.foloiwl,
       cc.anlcode = x.anlcode
WHERE cc.codierungsart IN (14,15)
AND cc.wkz IS NULL
AND cc.iwl IS NULL;

COMMIT;


PROMPT 18.6 FOLOIWL bestellte Katalogart setzen (nicht gefundene bleiben auf FOLOIWL aus Bestellanalyse-FUP
PROMPT ================================================================================================

MERGE INTO clcc_ww_nkcodierung_1 cc
USING
(
    SELECT 
       konto_id_key, 
       MIN(katalogart) AS foloiwl
    FROM clcc_ww_nkcodierung_2
    WHERE vfkz = 0
    GROUP BY konto_id_key
) x
ON (x.konto_id_key = cc.konto_id_key)
WHEN MATCHED THEN
   UPDATE SET 
       cc.iwl = x.foloiwl
WHERE cc.codierungsart IN (14,15);

COMMIT;



PROMPT 19. Shop-Kennzeichen fuer alle setzen 
PROMPT *************************************

MERGE INTO clcc_ww_nkcodierung_1 cc
USING
(
  SELECT 
     konto_id_key, 
     SUM(CASE WHEN shop = 1 THEN 1 ELSE 0 END) AS anzshop,
     SUM(CASE WHEN shop = 0 THEN 1 ELSE 0 END) AS anzprint,
     SUM(CASE WHEN shop IS NULL THEN 1 ELSE 0 END) AS anzneutral     
  FROM clcc_ww_nkcodierung_2
  GROUP BY konto_id_key
) x
ON (x.konto_id_key = cc.konto_id_key)
WHEN MATCHED THEN
   UPDATE SET cc.shop = CASE WHEN x.anzshop > 0 AND x.anzprint = 0 THEN 1   -- nur Shop
                               WHEN x.anzshop = 0 AND x.anzprint > 0 THEN 2   -- nur Print
                               WHEN x.anzshop > 0 AND x.anzprint > 0 THEN 3   -- Shop und Print
              ELSE 0 END;

COMMIT;



PROMPT 20. Default-Interessenten WKZ/IWL setzen fuer nicht gefundene im Interessentenpool 
PROMPT ***********************************************************************************

MERGE INTO clcc_ww_nkcodierung_1 cc
USING
(
  SELECT 
    firma,
    defaultwkz,
    defaultiwl 
  FROM sc_fu_nkcod_default dk
  JOIN sc_fu_nkcod_default_ver dv ON (dv.dwh_id_head = dk.dwh_id AND dv.dwh_valid_to = DATE '9999-12-31')
  WHERE wkzart = '1'
  AND vtsaison = &vtsaison
) x
ON (x.firma = cc.firma)
WHEN MATCHED THEN
   UPDATE SET cc.intwkz = x.defaultwkz,
              cc.intiwl = x.defaultiwl
WHERE cc.intwkz IS NULL;
   
COMMIT;



PROMPT 21. Mediaumcodierungen beruecksichtigen
PROMPT ****************************************

PROMPT 21.1 Nielsengebiet und Gebalter ueber Temporaertabelle ermitteln
PROMPT =================================================================

-- Waeschepur nicht betroffen

TRUNCATE TABLE clcc_ww_nkcodierung_9;

INSERT /*+ APPEND */ INTO clcc_ww_nkcodierung_9 cl9
(
  dwh_cr_load_id,
  konto_id_key,
  firma, 
  anlagedat,
  nielsengebiet,
  gebalter
 )
SELECT
    &gbvid,
    kv.konto_id_key,
    fv.kdfirmkz, 
    kv.anlaufdat,   
    niel.bez AS nielsengebiet,
    TO_CHAR(&datum,'YYYY') - TO_CHAR(gebdat,'yyyy') AS gebalter
FROM clcc_ww_nkcodierung_1 cl1
JOIN sc_ww_kunde_ver kv ON (kv.konto_id_key = cl1.konto_id_key AND cl1.anlagedat = kv.anlaufdat AND kv.dwh_valid_to = TO_DATE('31.12.9999','dd.mm.yyyy')) 
JOIN sc_ww_kundenfirma f ON (f.dwh_id = kv.dwh_id_sc_ww_kundenfirma)
JOIN sc_ww_kundenfirma_ver fv ON (fv.dwh_id_head = f.dwh_id AND fv.dwh_valid_to = TO_DATE('31.12.9999','dd.mm.yyyy') AND fv.kdfirmkz = cl1.firma)
JOIN sc_ww_person p ON (p.dwh_id = kv.dwh_id_sc_ww_person)
JOIN sc_ww_person_ver pv ON (pv.dwh_id_head = p.dwh_id AND pv.dwh_valid_to = TO_DATE('31.12.9999','dd.mm.yyyy'))
JOIN sc_ww_adresse a ON (a.dwh_id = pv.dwh_id_sc_ww_adresse)
JOIN sc_ww_adresse_ver av ON (av.dwh_id_head = a.dwh_id AND av.dwh_valid_to = TO_DATE('31.12.9999','dd.mm.yyyy'))
JOIN cc_plzref_akt_v plz ON (plz.plz = av.plz AND plz.land = 54)
JOIN cc_nielsengebiet_akt_v niel ON (niel.wert = plz.nielsengebiet);

COMMIT;


PROMPT 21.2 Nielsengebiet und Gebalter setzen
PROMPT =======================================

MERGE INTO clcc_ww_nkcodierung_1 cc
 USING clcc_ww_nkcodierung_9 cl9
on (cl9.konto_id_key = cc.konto_id_key AND cl9.anlagedat = cc.anlagedat)
WHEN MATCHED THEN 
UPDATE SET cc.nielsengebiet = cl9.nielsengebiet,
           cc.gebalter = cl9.gebalter;

COMMIT;



PROMPT 21.3 Mediaumcodierung ermitteln (Mediawkz/IWL, WKZ/IWL ueberschreiben)
PROMPT =======================================================================

MERGE INTO clcc_ww_nkcodierung_1 cc1
USING 
(
    SELECT 
      cc.konto_id_key, 
      cc.firma, 
      cc.anlagedat, 
      mk.vtsaison, 
      mk.wkzvon, 
      mk.wkzbis, 
      mk.iwlvon, 
      mk.iwlbis, 
      mk.plz, 
      mk.bundesland, 
      mk.nielsengebiet, 
      mk.anrede, 
      mk.altervon, 
      mk.alterbis,
      mv.zielwkz, 
      mv.zieliwl
    FROM clcc_ww_nkcodierung_1 cc   
    JOIN  sc_fu_nkcod_media mk ON (cc.firma = mk.firma 
              AND nvl(cc.nielsengebiet,0) = CASE WHEN mk.nielsengebiet = '<Alle>' THEN nvl(cc.nielsengebiet,0) ELSE mk.nielsengebiet END 
              AND NVL(cc.gebalter,0) BETWEEN CASE WHEN mk.altervon = '<Alle>' THEN NVL(cc.gebalter,0) ELSE TO_NUMBER(mk.altervon) END AND CASE WHEN mk.alterbis = '<Alle>' THEN NVL(cc.gebalter,0) ELSE TO_NUMBER(mk.alterbis) END
              AND cc.wkz BETWEEN mk.wkzvon AND mk.wkzbis 
              AND cc.iwl BETWEEN mk.iwlvon AND mk.iwlbis)
     JOIN sc_fu_nkcod_media_ver mv ON (mv.dwh_id_head = mk.dwh_id AND &datum BETWEEN anlaufvon AND anlaufbis AND mv.dwh_valid_to = TO_DATE('31.12.9999','dd.mm.rrrr'))
 ) x
      ON (x.konto_id_key = cc1.konto_id_key AND x.anlagedat = cc1.anlagedat)
WHEN MATCHED THEN
 UPDATE SET cc1.mediawkz = x.zielwkz,
            cc1.mediaiwl = x.zieliwl,
            cc1.wkz = x.zielwkz,
            cc1.iwl = x.zieliwl;
            
COMMIT;



PROMPT NEU ab 1/24: Gutscheincodes aus FUP VFOHNEWARE beruecksichtigen  
PROMPT ===============================================================

DECLARE
    v_datum VARCHAR2(20);
BEGIN

     v_datum := TO_CHAR(&datum,'dd.mm.yyyy');

     FOR z IN 1..5 LOOP
    
         EXECUTE IMMEDIATE ('
         MERGE INTO clcc_ww_nkcodierung_1 cc
         USING
         (
              SELECT vtsaison, firma, cimtcode, wkz, iwl
              FROM sc_fu_nkcod_vfohneware dk
              JOIN sc_fu_nkcod_vfohneware_ver dv ON (dv.dwh_id_head = dk.dwh_id AND dv.dwh_valid_to = DATE ''9999-12-31'')  
              AND vtsaison = &vtsaison
              AND to_date('''|| v_datum ||''',''dd.mm.yyyy'') BETWEEN anlaufvon AND anlaufbis  
          ) x
          ON (x.firma = cc.firma AND x.cimtcode = cc.vfherkunft_' || z || ')
          WHEN MATCHED THEN
          UPDATE SET 
             cc.codierungsart = 28,  
             cc.wkz = x.wkz,
             cc.iwl = x.iwl            
          WHERE (cc.codierungsart IS NULL  
             OR cc.codierungsart IN (14,15) 
             OR cc.brand = 2 AND cc.codierungsart IN (12,13))'); --Internet Brand mit und ohne Mailbandtreffer
       
       COMMIT;
       
   END LOOP;       

END;
/



PROMPT 22. Anldat setzen
PROMPT *****************

PROMPT 22.1 Fuer alle gefundenen setzen
PROMPT =================================

MERGE INTO clcc_ww_nkcodierung_1 cc
USING
(
SELECT DISTINCT 
   konto_id_key, 
   firma
FROM clcc_ww_nkcodierung_1
  INTERSECT
SELECT
   konto_id_key,
   firma
FROM clcc_ww_nkcodierung_2 
WHERE buchdat = &datum
) x
 ON (x.konto_id_key = cc.konto_id_key)
 WHEN MATCHED THEN 
      UPDATE SET anldat = &datum;
    
COMMIT;



PROMPT 22.2. Fuer Stationaer-Erstbuchungen ist kein Datensatz in Cleanse2 vorhanden, Rest setzen
PROMPT ==========================================================================================

MERGE INTO clcc_ww_nkcodierung_1 cc
USING
(
  SELECT DISTINCT 
     konto_id_key, 
     firma,
     erstbuchdat
  FROM clcc_ww_nkcodierung_4
) x
 ON (x.konto_id_key = cc.konto_id_key)
 WHEN MATCHED THEN 
      UPDATE SET cc.anldat = x.erstbuchdat
WHERE cc.anldat IS NULL;
    
COMMIT;


PROMPT 22.3 Bei erkannten Bestandskunden zuruecksetzen 
PROMPT =================================================

-- Problem: Ein Bestandskunde kann wie ein NK ausschauen, weil in der sc_ww_buchung die "alten" Buchungen fehlen und so die heutige Buchung scheinbar eine Erstbuchung ist
--Fuer Bestandskunden das anldat wieder zuruecksetzen

MERGE INTO clcc_ww_nkcodierung_1 cl
 USING
   (
     SELECT 
       konto_id_key, 
       CASE WHEN fa.sg = 68 THEN 18 ELSE fa.sg END AS firma, 
       anlagedat
     FROM cc_kunde_&vtsaison ku
     JOIN cc_firma_akt_v fa ON (fa.wert = ku.firma)  
     WHERE anldat < &datum
     AND ku.dwh_valid_to = TO_DATE('31.12.9999','dd.mm.yyyy')
   ) x
   ON (x.konto_id_key = cl.konto_id_key AND x.anlagedat = cl.anlagedat)
   WHEN MATCHED THEN
    UPDATE SET cl.anldat = NULL
WHERE cl.anldat IS NOT NULL;

COMMIT;



PROMPT 23. NK0-Kennzeichen und ANLVTSAISON setzen
PROMPT ********************************************

PROMPT 23.1 bei NK0-Kunden
PROMPT ===================

MERGE INTO clcc_ww_nkcodierung_1 cc
USING
(
   SELECT DISTINCT 
        cc.firma, 
        cc.konto_id_key 
   FROM clcc_ww_nkcodierung_1 cc
   JOIN  sc_im_tgv_nk0_ver nk0 ON (cc.wkz BETWEEN nk0.ww_startwkz AND nk0.ww_endewkz 
                                    AND cc.iwl BETWEEN nk0.ww_startiwl AND nk0.ww_endeiwl 
                                    AND nk0.firma = cc.firma 
                                    AND cc.anldat BETWEEN ww_startdatum AND ww_endedatum
                                    --AND &termin BETWEEN nk0.dwh_valid_from AND nk0.dwh_valid_to
                                    AND nk0.dwh_valid_to = TO_DATE('31.12.9999','dd.mm.yyyy')
                                    )
   WHERE cc.anldat = &datum
) x
ON (x.konto_id_key = cc.konto_id_key)
WHEN MATCHED THEN 
UPDATE SET 
   cc.anlvtsaison = &vtsaisonp1, 
   cc.nk0 = 2;
   
COMMIT;


-- hier andgag nur für umcodierung da Änderung noch nicht im SC angekommen....das muss dann wieder zurück geändert werden 05.06.2024
/*
MERGE INTO clcc_ww_nkcodierung_1 cc
USING
(
   SELECT DISTINCT 
        cc.firma, 
        cc.konto_id_key 
   FROM clcc_ww_nkcodierung_1 cc
   JOIN  improg.TGV_NK0 nk0 ON (cc.wkz  between nk0.ww_startwkz AND nk0.ww_endewkz 
                                    AND cc.iwl BETWEEN nk0.ww_startiwl AND nk0.ww_endeiwl 
                                    AND nk0.firma = cc.firma 
                                    AND cc.anldat BETWEEN ww_startdatum AND ww_endedatum
                                    )
   WHERE cc.anldat = &datum      
) x
ON (x.konto_id_key = cc.konto_id_key)
WHEN MATCHED THEN 
UPDATE SET 
   cc.anlvtsaison = &vtsaisonp1, 
   cc.nk0 = 2;

COMMIT;
*/

PROMPT 23.2 bei NK1-Kunden
PROMPT ===================

MERGE INTO clcc_ww_nkcodierung_1 cc
USING
(
   SELECT DISTINCT 
        cc.firma, 
        cc.konto_id_key
   FROM clcc_ww_nkcodierung_1 cc
   WHERE cc.anldat = &datum
) x
ON (x.konto_id_key = cc.konto_id_key)
WHEN MATCHED THEN 
UPDATE SET 
   cc.anlvtsaison = &vtsaison,
   cc.nk0 = 1
WHERE nk0 IS NULL;
   
COMMIT;



PROMPT 24. Anlcode setzen aus endgueltiger WKZ/IWL setzen 
PROMPT ***************************************************


PROMPT 24.1 Bei NK1-Kunden
PROMPT ====================

MERGE INTO clcc_ww_nkcodierung_1 c
USING
 (
    SELECT  
      c.konto_id_key, 
      MIN(x.anlcode) AS anlcode 
    From clcc_ww_nkcodierung_1 c
    JOIN 
    ( 
         SELECT firma, vonwkz, biswkz, voniwl, bisiwl, anlcode
         FROM sc_fu_nkcod_analyse sck  
         JOIN sc_fu_nkcod_analyse_ver scv ON (scv.dwh_id_head = sck.dwh_id AND scv.dwh_valid_to = DATE '9999-12-31' 
                                                AND &datum BETWEEN scv.anlaufvon 
                                                AND scv.anlaufbis 
                                                AND sck.vtsaison = &vtsaison)
         )  x
     on (x.firma = c.firma AND c.wkz BETWEEN x.vonwkz AND x.biswkz AND c.iwl BETWEEN x.voniwl AND x.bisiwl)
     GROUP BY c.konto_id_key
  ) x
  on (x.konto_id_key = c.konto_id_key)
WHEN MATCHED THEN
   UPDATE SET 
       c.anlcode = x.anlcode
WHERE nk0 = 1;

COMMIT;



PROMPT 24.2 Bei NK0-Kunden
PROMPT ====================


MERGE INTO clcc_ww_nkcodierung_1 c
USING
 (
    SELECT  
      c.konto_id_key, 
      MIN(x.anlcode) AS anlcode 
    From clcc_ww_nkcodierung_1 c
    JOIN 
    ( 
         SELECT firma, vonwkz, biswkz, voniwl, bisiwl, anlcode
         FROM sc_fu_nkcod_analyse sck  
         JOIN sc_fu_nkcod_analyse_ver scv ON (scv.dwh_id_head = sck.dwh_id AND scv.dwh_valid_to = DATE '9999-12-31' 
                                                AND &datum BETWEEN scv.anlaufvon 
                                                AND scv.anlaufbis 
                                                AND sck.vtsaison = &vtsaisonp1)
         )  x
     on (x.firma = c.firma AND c.wkz BETWEEN x.vonwkz AND x.biswkz AND c.iwl BETWEEN x.voniwl AND x.bisiwl)
     GROUP BY c.konto_id_key
  ) x
  on (x.konto_id_key = c.konto_id_key)
WHEN MATCHED THEN
   UPDATE SET 
       c.anlcode = x.anlcode
WHERE nk0 = 2;

COMMIT;

PROMPT 24.3 Bei VF-ohne-Ware-FP (NK1 und NK0)
PROMPT ======================================

MERGE INTO clcc_ww_nkcodierung_1 c
USING
 (
    SELECT  
      c.konto_id_key, 
      MIN(x.anlcode) AS anlcode 
    FROM clcc_ww_nkcodierung_1 c
    JOIN 
    ( 
         SELECT firma, wkz, iwl, anlcode
         FROM sc_fu_nkcod_vfohneware sck  
         JOIN sc_fu_nkcod_vfohneware_ver scv ON (scv.dwh_id_head = sck.dwh_id AND scv.dwh_valid_to = DATE '9999-12-31' 
                                                AND &datum BETWEEN scv.anlaufvon 
                                                AND scv.anlaufbis 
                                                AND sck.vtsaison = &vtsaison
                                             )
         )  x
     on (x.firma = c.firma AND c.wkz = x.wkz AND c.iwl = x.iwl)
     GROUP BY c.konto_id_key
  ) x
  on (x.konto_id_key = c.konto_id_key)
WHEN MATCHED THEN
   UPDATE SET 
       c.anlcode = x.anlcode
WHERE nk0 = 1;

COMMIT;

MERGE INTO clcc_ww_nkcodierung_1 c
USING
 (
    SELECT  
      c.konto_id_key, 
      MIN(x.anlcode) AS anlcode 
    FROM clcc_ww_nkcodierung_1 c
    JOIN 
    ( 
         SELECT firma, wkz, iwl, anlcode
         FROM sc_fu_nkcod_vfohneware sck  
         JOIN sc_fu_nkcod_vfohneware_ver scv ON (scv.dwh_id_head = sck.dwh_id AND scv.dwh_valid_to = DATE '9999-12-31' 
                                                AND &datum BETWEEN scv.anlaufvon 
                                                AND scv.anlaufbis 
                                                AND sck.vtsaison = &vtsaisonp1
                                             )
         )  x
     on (x.firma = c.firma AND c.wkz = x.wkz AND c.iwl = x.iwl)
     GROUP BY c.konto_id_key
  ) x
  on (x.konto_id_key = c.konto_id_key)
WHEN MATCHED THEN
   UPDATE SET 
       c.anlcode = x.anlcode
WHERE nk0 = 2;

COMMIT;

PROMPT 25. Leere Felder vorbelegen
PROMPT *****************************

PROMPT 25.1 Anlcode
PROMPT ============

UPDATE clcc_ww_nkcodierung_1 SET anlcode = 99 WHERE anlcode is null;

COMMIT;

PROMPT 25.2 Brand
PROMPT ============

UPDATE clcc_ww_nkcodierung_1 SET brand = 0 WHERE brand IS NULL;

COMMIT;

PROMPT 25.3 NK0
PROMPT ============

UPDATE clcc_ww_nkcodierung_1 SET nk0 = 0 WHERE nk0 is null;

COMMIT;


PROMPT 26. ANLECC wegspeichern. Analog zur Ermittlung des Brandkz wird bei mehreren ECCs BRAND bevorzugt.
PROMPT **************************************************************************************************

-- Hinweis: ANLECC wird immer gespeichert, Brand aktuell nur bei Internet-NK

MERGE INTO clcc_ww_nkcodierung_1 cl1
USING 
   ( 
    SELECT DISTINCT 
      konto_id_key, 
    SUBSTR(MAX(brand || '_' || ecc), 3)  AS ecc
    FROM clcc_ww_nkcodierung_2
  WHERE ecc != 0
  GROUP BY konto_id_key
  ) cl2
  ON (cl1.konto_id_key = cl2.konto_id_key)
  WHEN MATCHED THEN 
   UPDATE SET cl1.anlecc = cl2.ecc;
   
COMMIT;


PROMPT 27. Uebernehmen in letzte Cleanse Tabelle  mit Referenzaufloesung
PROMPT *********************************************************************

TRUNCATE TABLE clcc_ww_nkcodierung;

INSERT /*+ APPEND */ INTO clcc_ww_nkcodierung
(
  dwh_cr_load_id,
  loaddat,
  konto_id_key,
  firma,
  anlagedat,
  anldat,
  vfherkunft_1,
  vfherkunft_2,
  vfherkunft_3,
  vfherkunft_4,
  vfherkunft_5,
  shop,
  erstwkz,
  erstiwl,
  intwkz,
  intiwl,
  mbwkz,
  mbiwl,
  mbwkz_1,
  mbiwl_1,
  aktiv_prio1,
  mbwkz_2,
  mbiwl_2,
  aktiv_prio2,
  mbwkz_3,
  mbiwl_3,
  aktiv_prio3,
  mbwkz_4,
  mbiwl_4,
  aktiv_prio4,
  mbwkz_5,
  mbiwl_5,
  aktiv_prio5,
  mbwkz_6,
  mbiwl_6,
  aktiv_prio6,
  mbwkz_7,
  mbiwl_7,
  aktiv_prio7,
  mbwkz_8,
  mbiwl_8,
  aktiv_prio8,
  mbwkz_9,
  mbiwl_9,
  aktiv_prio9,
  mbwkz_10,
  mbiwl_10,
  aktiv_prio10,
  mbwkz_11,
  mbiwl_11,
  aktiv_prio11,
  mbwkz_12,
  mbiwl_12,
  aktiv_prio12,
  synwkz,
  syniwl,
  synaktiv_prio,
  anlcode,
  anlweg1,  --vorher wkz
  anlweg2,  --vorher iwl
  brand,
  nkcodierungsart,
  anlvtsaison,
  nk0,
  anlecc
)
SELECT 
  cc.dwh_cr_load_id,
  &datum,
  konto_id_key,
  fa.wert AS firma,
  anlagedat,
  anldat,
  vfherkunft_1,
  vfherkunft_2,
  vfherkunft_3,
  vfherkunft_4,
  vfherkunft_5,
  shop.wert AS shop,
  erstwkz,
  erstiwl,
  intwkz,
  intiwl, 
  CASE WHEN fa.wert = 13 THEN -3 ELSE mbwkz END AS mbwkz, --in Italien gibt es keinen Mailbandabgleich
  CASE WHEN fa.wert = 13 THEN -3 ELSE mbiwl END AS mbiwl, --in Italien gibt es keinen Mailbandabgleich  
  mbwkz_1,
  mbiwl_1,
  aktiv_prio1,
  mbwkz_2,
  mbiwl_2,
  aktiv_prio2,
  mbwkz_3,
  mbiwl_3,
  aktiv_prio3,
  mbwkz_4,
  mbiwl_4,
  aktiv_prio4,
  mbwkz_5,
  mbiwl_5,
  aktiv_prio5,
  mbwkz_6,
  mbiwl_6,
  aktiv_prio6,
  mbwkz_7,
  mbiwl_7,
  aktiv_prio7,
  mbwkz_8,
  mbiwl_8,
  aktiv_prio8,
  mbwkz_9,
  mbiwl_9,
  aktiv_prio9,
  mbwkz_10,
  mbiwl_10,
  aktiv_prio10,
  mbwkz_11,
  mbiwl_11,
  aktiv_prio11,
  mbwkz_12,
  mbiwl_12,
  aktiv_prio12,
  synwkz,
  syniwl,
  synaktiv_prio,
  anlcode,
  wkz,
  iwl,
  br.wert AS brand,
  codierungsart,
  anlvtsai.wert AS anlvtsaison,
  nk0,
  anlecc
FROM clcc_ww_nkcodierung_1 cc
JOIN cc_firma_akt_v fa ON (CASE WHEN fa.sg = 68 THEN 18 ELSE fa.sg END = cc.firma AND fa.wert != 37)
JOIN cc_anlvtsaison anlvtsai ON (anlvtsai.sg = COALESCE(cc.anlvtsaison,0) AND anlvtsai.dwh_valid_to = to_date('31.12.9999','dd.mm.yyyy'))
JOIN cc_shop shop ON (shop.sg = COALESCE(cc.shop,0) AND shop.dwh_valid_to = to_date('31.12.9999','dd.mm.yyyy'))
JOIN cc_brand_akt_v br ON (br.wert = cc.brand)
JOIN cc_nk0_akt_v nk0 ON (nk0.wert = cc.nk0)
;

COMMIT;



PROMPT 28. Pruefung, ob Referenzaufloesung Daten verliert.
PROMPT ****************************************************

  SET SERVEROUTPUT ON

  DECLARE
    v_anz_vorref PLS_INTEGER;
    v_anz_nachref PLS_INTEGER;
  BEGIN
    SELECT COUNT(*)
    INTO    v_anz_vorref
    FROM    clcc_ww_nkcodierung_1;

    SELECT COUNT(*)
    INTO    v_anz_nachref
    FROM    clcc_ww_nkcodierung;

    IF v_anz_nachref != v_anz_vorref THEN
        RAISE_APPLICATION_ERROR(-20029,'Referenzaufloesung generiert zu wenig oder zu viel Datensaetze!');
    ELSE
      DBMS_OUTPUT.PUT_LINE('Alles gut, weiter machen!');
    END IF;
  END;
  /


PROMPT 29. Sonderteil Slowakei (zu pruefen, nur temporaer)
PROMPT *******************************************************

PROMPT Slowakei gibt es noch keine FUP-Vorgagen, aktuell nur einige FOLOS

UPDATE clcc_ww_nkcodierung SET 
    anlweg1 = 900, 
    anlweg2 = 0, 
    anlcode = 60
WHERE anlweg1 IS NULL
AND firma = 40;

COMMIT;



PROMPT 30. INTWKZ / INTIWL setzen
PROMPT *****************************

PROMPT 30.1 In Tagestabelle 
PROMPT =======================

MERGE INTO clcc_ww_nkcodierung cc
USING
(
   SELECT konto_id_key, firma, wkz, iwl
   FROM 
   (
     SELECT DISTINCT 
       verweis.verweiskonto_id_key AS konto_id_key,
       verweis.firma,
       ku.anlweg1 as wkz,
       ku.anlweg2 as iwl,
       ROW_NUMBER() OVER (PARTITION BY verweis.verweiskonto_id_key, verweis.firma ORDER BY anldat DESC) counter
       FROM if_interessenten_verweiskonto_id verweis
       JOIN cc_kunde_&vtsaison._akt_v ku ON (ku.konto_id_key = verweis.inr_id_key AND ku.kontoart = 2)
    )
    WHERE counter = 1 
  ) x
  ON (x.konto_id_key = cc.konto_id_key)
  WHEN MATCHED THEN
   UPDATE SET cc.intwkz = x.wkz,
              cc.intiwl = x.iwl; 
              
COMMIT;

 

PROMPT 30.2 In Haupttabelle, weil Interessentenabgleich nur einmal pro Woche lauft 
PROMPT =============================================================================

MERGE INTO &endtabelle cc
USING
(       
   SELECT konto_id_key, firma, wkz, iwl
   FROM 
   (
     SELECT DISTINCT 
       verweis.verweiskonto_id_key AS konto_id_key,
       verweis.firma,
       ku.anlweg1 as wkz,
       ku.anlweg2 as iwl,
       ROW_NUMBER() OVER (PARTITION BY verweis.verweiskonto_id_key, verweis.firma ORDER BY anldat DESC) counter
       FROM if_interessenten_verweiskonto_id verweis
       JOIN cc_kunde_&vtsaison._akt_v ku ON (ku.konto_id_key = verweis.inr_id_key AND ku.kontoart = 2)
    )
    WHERE counter = 1 
  ) x
  ON (x.konto_id_key = cc.konto_id_key)  
  WHEN MATCHED THEN  
   UPDATE SET cc.intwkz = x.wkz,
              cc.intiwl = x.iwl; 
              
COMMIT;



PROMPT 31. Cross Border USA erst mal ausschliessen
PROMPT ************************************************************************

DELETE FROM clcc_ww_nkcodierung
WHERE firma IN (36,
                42, --us cross border
                43, --saudi arabien cross border
                57 --witt Schweden
                );  
               
COMMIT;


PROMPT 32. Umcodierungen vom Vortag in CC_NKCODIERUNG einspielen
PROMPT *********************************************************

INSERT /*+ append */ INTO clcc_ww_nkcodierung
(
   dwh_cr_load_id,  
   loaddat,  
   konto_id_key, 
   firma, 
   anlagedat, 
   anldat, 
   vfherkunft_1, 
   vfherkunft_2, 
   vfherkunft_3, 
   vfherkunft_4, 
   vfherkunft_5, 
   shop, 
   erstwkz, 
   erstiwl, 
   intwkz, 
   intiwl, 
   mbwkz, 
   mbiwl, 
   mbwkz_1, 
   mbiwl_1, 
   aktiv_prio1, 
   mbwkz_2, 
   mbiwl_2, 
   aktiv_prio2, 
   mbwkz_3, 
   mbiwl_3, 
   aktiv_prio3, 
   mbwkz_4, 
   mbiwl_4, 
   aktiv_prio4, 
   mbwkz_5, 
   mbiwl_5, 
   aktiv_prio5, 
   mbwkz_6, 
   mbiwl_6, 
   aktiv_prio6, 
   mbwkz_7, 
   mbiwl_7, 
   aktiv_prio7, 
   mbwkz_8, 
   mbiwl_8, 
   aktiv_prio8, 
   mbwkz_9, 
   mbiwl_9, 
   aktiv_prio9, 
   mbwkz_10, 
   mbiwl_10, 
   aktiv_prio10, 
   mbwkz_11, 
   mbiwl_11, 
   aktiv_prio11, 
   mbwkz_12, 
   mbiwl_12, 
   aktiv_prio12, 
   synwkz, 
   syniwl, 
   synaktiv_prio, 
   mediawkz, 
   mediaiwl, 
   anlcode, 
   anlweg1, 
   anlweg2, 
   brand, 
   nkcodierungsart, 
   nk0, 
   anlvtsaison, 
   anlecc
)
SELECT 
  &gbvid AS dwh_cr_load_id, 
  cc.loaddat,  
  cc.konto_id_key, 
  cc.firma, 
  anlagedat, 
  anldat, 
  vfherkunft_1, 
  vfherkunft_2, 
  vfherkunft_3, 
  vfherkunft_4, 
  vfherkunft_5, 
  shop, 
  erstwkz, 
  erstiwl, 
  intwkz, 
  intiwl, 
  mbwkz, 
  mbiwl, 
  mbwkz_1, 
  mbiwl_1, 
  aktiv_prio1, 
  mbwkz_2, 
  mbiwl_2, 
  aktiv_prio2, 
  mbwkz_3, 
  mbiwl_3, 
  aktiv_prio3, 
  mbwkz_4, 
  mbiwl_4, 
  aktiv_prio4, 
  mbwkz_5, 
  mbiwl_5, 
  aktiv_prio5, 
  mbwkz_6, 
  mbiwl_6,
  aktiv_prio6, 
  mbwkz_7, 
  mbiwl_7, 
  aktiv_prio7, 
  mbwkz_8, 
  mbiwl_8,
  aktiv_prio8, 
  mbwkz_9,
  mbiwl_9, 
  aktiv_prio9, 
  mbwkz_10, 
  mbiwl_10, 
  aktiv_prio10, 
  mbwkz_11, 
  mbiwl_11, 
  aktiv_prio11, 
  mbwkz_12, 
  mbiwl_12,
  aktiv_prio12, 
  synwkz, 
  syniwl, 
  synaktiv_prio, 
  mediawkz, 
  mediaiwl, 
  CASE WHEN v.anlcodeneu = -1 THEN cc.anlcode ELSE v.anlcodeneu END,
  CASE WHEN v.wkzneu = -1 THEN cc.anlweg1 ELSE v.wkzneu END,
  CASE WHEN v.iwlneu = -1 THEN cc.anlweg2 ELSE v.iwlneu END,
  brand,
  26 as nkcodierungsart,
  nk0, 
  cc.anlvtsaison,  
  anlecc
FROM cc_nkcodierung cc
JOIN cc_firma_akt_v f ON (cc.firma = f.wert)
JOIN sc_stammattr k ON (cc.konto_id_key = k.konto_id_key)
JOIN sc_stammattr_ver v ON (v.dwh_id_head = k.dwh_id AND TRUNC(v.dwh_valid_from) = trunc(sysdate) AND f.sg = v.firma)
WHERE cc.dwh_status = 1
AND cc.firma NOT IN (7,16)
AND '&6' != 'cc_nkcodkorr'
AND -- Es gibt einn Eintrag in die Stammattr 
(
  wkzneu != -1
  OR iwlneu != -1
  OR anlcodeneu != -1
)
AND  -- Es gibt Unterschiede zwischen Stammattr und cc_nkcodierung (Manuelle Umcodierung)
(
  wkzneu != cc.anlweg1
  OR iwlneu != cc.anlweg2
  OR anlcodeneu != cc.anlcode
);

COMMIT;


-- Temporaer Daten im FUP haben gefehlt

update CLCC_WW_NKCODIERUNG set anlweg2 = 0
where anlweg1 is null
and anlweg2 is null;

commit;


update CLCC_WW_NKCODIERUNG set anlweg1 = 900
where anlweg1 is null;

commit;


-- Fuer HW23 Korrektur hinsichtlich Anlocde mit einbauen, falls mal wiederholt wird. 
merge into clcc_ww_nkcodierung a
using if_anlcodeneu_hw23_corr b
on (a.konto_id_key = b.konto_id_key)
when matched then update
set
  a.anlcode = b.anlcodeneu
where a.anlcode != b.anlcodeneu;

COMMIT;