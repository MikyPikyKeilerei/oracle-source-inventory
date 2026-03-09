/*******************************************************************************

Job:                  sc_ww_adresse_kk_test
Beschreibung:         Job lädt Adresstabellen in das Source Core 
          
Erstellt am:          XX.04.2015
Erstellt von:         Stefan Ernstberger
Ansprechpartner:      Stefan Ernstberger, Jochen König
Ansprechpartner-IT:   Anton Roithmaier, Thomas Hösl

verwendete Tabellen:  st_ww_adresse_kk_b
                       
Endtabellen:          sc_ww_adresse_kk
                      sc_ww_adresse_kk_ver
Fehler-Doku:      -
Ladestrecke:      -

********************************************************************************
geändert am:          24.10.2017
geändert von:         STEERN
Änderungen:           Einbau Spalte ERZWUNGENKZ mit Referenzaufloesung
********************************************************************************
geändert am:          21.08.2018
geändert von:         maxlin
Änderungen:           Anpassung an Clearingstelle,
                      enthält nur noch Kernkundendaten
********************************************************************************
geändert am:          30.11.2018
geändert von:         maxlin
Änderungen:           Umzug auf KDWH
********************************************************************************
geändert am:          11.08.2021
geändert von:         joeabd
Änderungen:           Integration DSGVO-Löschvorgaben
*******************************************************************************/

ALTER SESSION ENABLE PARALLEL DML;

PROMPT =========================================================================
PROMPT Parameter
PROMPT Prozessdatum: &termin
PROMPT GBV-Job ID:  &gbvid
PROMPT =========================================================================



PROMPT =========================================================================
PROMPT
PROMPT 1. Source Core-Ladung
PROMPT Endtabelle: sc_ww_adresse_kk / sc_ww_adresse_kk_ver
PROMPT
PROMPT =========================================================================
 
 
 
PROMPT ===========================================
PROMPT  1.1 Cleansing Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clsc_ww_adresse_kk;
TRUNCATE TABLE clsc_ww_adresse_kk_1;
TRUNCATE TABLE clsc_ww_adresse_kk_d;
 
 
 
PROMPT ===========================================
PROMPT  1.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_adresse_kk_1
(
   dwh_cr_load_id,
   id,
   landid,
   hsnr,
   hsnrzus1,
   hsnrzus2,
   str,
   plz,
   ort,
   plzzus
)
VALUES
(
   &gbvid,
   id,
   landid,
   hsnr,
   hsnrzus1,
   hsnrzus2,
   str,
   plz,
   ort,
   plzzus
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_adresse_kk_d
(
   dwh_cr_load_id,
   id
)
VALUES
(
   &gbvid,
   id
)
SELECT
   dwh_stbflag,
   id,
   landid,
   hsnr,
   hsnrzus1,
   hsnrzus2,
   str,
   plz,
   ort,
   plzzus
FROM st_ww_adresse_kk_b
WHERE dwh_processdate = &termin;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  1.3 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_adresse_kk_1');
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_adresse_kk_d');
 
 
 
PROMPT ===========================================
PROMPT  1.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING ('clsc_ww_adresse_kk', 'id', &gbvid);
 
 
 
PROMPT ===========================================
PROMPT  1.5 Einspielen in die letzte SC-Tabelle mit Referenzauflösung
PROMPT ===========================================
 
INSERT /*+ APPEND */ FIRST
WHEN (dwh_id_sc_ww_land IS NULL 
) THEN
INTO clsc_ww_adresse_kk_e
(
   dwh_cr_load_id,
   dwh_up_load_id,
   dwh_id_sc_ww_land,
   id,
   landid,
   hsnr,
   hsnrzus1,
   hsnrzus2,
   str,
   plz,
   ort,
   plzzus
)
VALUES
(
   dwh_cr_load_id,
   &gbvid,
   dwh_id_sc_ww_land,
   id,
   landid,
   hsnr,
   hsnrzus1,
   hsnrzus2,
   str,
   plz,
   ort,
   plzzus
)
ELSE
INTO clsc_ww_adresse_kk
(
   dwh_cr_load_id,
   dwh_id_sc_ww_land,
   id,
   landid,
   hsnr,
   hsnrzus1,
   hsnrzus2,
   str,
   plz,
   ort,
   plzzus
)
SELECT
   a.dwh_cr_load_id,
   sc_ww_land.dwh_id AS dwh_id_sc_ww_land,
   a.id AS id,
   a.landid AS landid,
   a.hsnr AS hsnr,
   a.hsnrzus1 AS hsnrzus1,
   a.hsnrzus2 AS hsnrzus2,
   a.str AS str,
   a.plz AS plz,
   a.ort AS ort,
   a.plzzus AS plzzus
FROM clsc_ww_adresse_kk_1 a
  LEFT OUTER JOIN (SELECT sc_ww_land.dwh_id, sc_ww_land.id FROM sc_ww_land)  sc_ww_land
      ON (a.landid = sc_ww_land.id);
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  1.6 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_adresse_kk');
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_adresse_kk_e');