/*******************************************************************************

Job:                    sc_ww_adr_test
Beschreibung:           Job lädt Adresstabellen in das Source Core  
                    
Erstellt am:            XX.04.2016
Erstellt von:           Stefan Ernstberger
Ansprechpartner:        Stefan Ernstberger, Jochen König
Ansprechpartner-IT:     Anton Roithmeier, Thomas Hösl

verwendete Tabellen:    st_ww_adr_de_b                                                                                                           
                        st_ww_adr_ch_b (Die Spalte ptt_strnr wird auf Kernkundenseite geladen,
                                        es bleiben noch die Spalten id und adresseid, die auch auf KK-Seite geladen werden,
                                        darum wird hier die Tabelle im SC auf VH-Seite nicht mitgeladen)
                        st_ww_adr_at_b                                                                                                         
                        st_ww_adr_it_b                                                                                                  
                        st_ww_adr_ua_b
Endtabellen:            sc_ww_adr
                        sc_ww_adr_ver

Fehler-Doku:            -
Ladestrecke:            -

********************************************************************************

geändert am:           16.08.2017
geändert von:           andgag
Änderungen:             ##.1: COALESCE bei Ausschluss einzelner Adressid`s eingebaut
********************************************************************************
geändert am:          01.08.2018
geändert von:         maxlin   
Aenderungen:          Anpassungen an Clearingstelle:
                      -ID wird zu ID_Key
                      -AdresseID wird AdresseID_Key
                      -Nur noch Verhaltensdaten
********************************************************************************
geändert am:          10.12.2018
geändert von:         maxlin   
Aenderungen:          Umzug auf UDWH1
********************************************************************************
geändert am:          22.02.2019
geändert von:         steern
Aenderungen:          Ursprungsland eingebaut, damit man spaeter Kunden mit doppelten
                      Adressen (z.b. aus DE und AT) mit dem herkömmlichen Land identifizieren
                      und somit joinen kann (sonst wird Kundendatensatz "verdoppelt"
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
PROMPT Endtabelle: sc_ww_adr / sc_ww_adr_ver
PROMPT
PROMPT =========================================================================
 


PROMPT ===========================================
PROMPT  1.1 Cleansing Tabellen leeren
PROMPT ===========================================

TRUNCATE TABLE clsc_ww_adr;
TRUNCATE TABLE clsc_ww_adr_1;
TRUNCATE TABLE clsc_ww_adr_d;



PROMPT ===========================================
PROMPT  1.2 Daten aus Stage Backup Tabelle (DE) laden
PROMPT ===========================================

INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_adr_1
(
  dwh_cr_load_id,
  id_key,
  adresseid_key,
  hvs_depot,
  ursprungsland
)
VALUES
(
  &gbvid,
  id_key,
  adresseid_key,
  hvs_depot,
  ursprungsland
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_adr_d
(
  dwh_cr_load_id,
  id_key
)
VALUES
(
  &gbvid,
  id_key
)
SELECT DISTINCT 
  dwh_stbflag,
  id_key,
  adresseid_key,
  hvs_depot,
  'DE' AS ursprungsland
FROM
st_ww_adr_de_b
WHERE dwh_processdate = &termin
AND COALESCE(adresseid_key,'xxx') NOT IN ('405DF092CCB5AFE08ABC5A2A49FA550C','5DB5AAF7AB7D741EAA6D22FCD88362E0');
-- AND COALESCE(adresseid,'xxx') NOT IN ('3IUYrB','3Snkkn0'); muss auf Originalkey erneut verschlüsselt werden

COMMIT;



PROMPT ===========================================
PROMPT  1.3 Daten aus Stage Backup Tabelle (AT) laden
PROMPT ===========================================

INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_adr_1
(
  dwh_cr_load_id,
  id_key,
  adresseid_key,
  briefbotenbez,
  hvs_depot,
  ursprungsland
)
VALUES
(
  &gbvid,
  id_key,
  adresseid_key,
  briefbotenbez,
  hvs_depot,
  ursprungsland
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_adr_d
(
  dwh_cr_load_id,
  id_key
)
VALUES
(
  &gbvid,
  id_key
)
SELECT DISTINCT
  dwh_stbflag,
  id_key,
  adresseid_key,
  briefbotenbez,
  hvs_depot,
  'AT' AS ursprungsland
FROM
st_ww_adr_at_b
WHERE dwh_processdate = &termin
AND COALESCE(adresseid_key,'xxx') NOT IN
(
'C711EFD394ACD87D4A980C7B59F89192'
,'EB9617F806A89B97E488637B11B5BF81'
);

--AND COALESCE(adresseid,'xxx') NOT IN
--(
--'184dyp0'
--,'3VRdPt0'
--);

COMMIT;



PROMPT ===========================================
PROMPT  1.4 Daten aus Stage Backup Tabelle (IT) laden
PROMPT ===========================================

INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_adr_1
(
  dwh_cr_load_id,
  id_key,
  adresseid_key,
  hvs_depot,
  pit_provinzgrp,
  ursprungsland
)
VALUES
(
  &gbvid,
  id_key,
  adresseid_key,
  hvs_depot,
  pit_provinzgrp,
  ursprungsland
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_adr_d
(
  dwh_cr_load_id,
  id_key
)
VALUES
(
  &gbvid,
  id_key
)
SELECT DISTINCT
  dwh_stbflag,
  id_key,
  adresseid_key,
  hvs_depot,
  pit_provinzgrp,
  'IT' AS ursprungsland
FROM
st_ww_adr_it_b
WHERE dwh_processdate = &termin;

COMMIT;



PROMPT ===========================================
PROMPT  1.5 Daten aus Stage Backup Tabelle (UA) laden
PROMPT ===========================================

INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_adr_1
(
  dwh_cr_load_id,
  id_key,
  adresseid_key,
  region,
  bezirk,
  ursprungsland
)
VALUES
(
  &gbvid,
  id_key,
  adresseid_key,
  region,
  bezirk,
  ursprungsland
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_adr_d
(
  dwh_cr_load_id,
  id_key
)
VALUES
(
  &gbvid,
  id_key
)
SELECT DISTINCT 
  dwh_stbflag,
  id_key,
  adresseid_key,
  region,
  bezirk,
  'UA' AS ursprungsland
FROM
st_ww_adr_ua_b
WHERE dwh_processdate = &termin;

COMMIT;



PROMPT ===========================================
PROMPT  1.6 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_adr_1');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_adr_d');



PROMPT ===========================================
PROMPT  1.7 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING('clsc_ww_adr','id_key', &gbvid);
 
 

PROMPT ===========================================
PROMPT  1.8 Einspielen in die letzte SC-Tabelle mit Referenzauflösung
PROMPT ===========================================

INSERT /*+APPEND*/ FIRST
WHEN (dwh_id_sc_ww_adresse IS NULL) THEN
INTO clsc_ww_adr_e
(
  dwh_cr_load_id,
  dwh_up_load_id,
  dwh_id_sc_ww_adresse,
  id_key,
  adresseid_key,
  region,
  bezirk,
  hvs_depot,
  briefbotenbez,
  pit_provinzgrp,
  ursprungsland
)
VALUES
(
  dwh_cr_load_id,
  &gbvid,
  dwh_id_sc_ww_adresse,
  id_key,
  adresseid_key,
  region,
  bezirk,
  hvs_depot,
  briefbotenbez,
  pit_provinzgrp,
  ursprungsland
)
ELSE
INTO clsc_ww_adr
(
  dwh_cr_load_id,
  dwh_id_sc_ww_adresse,
  id_key,
  adresseid_key,
  region,
  bezirk,
  hvs_depot,
  briefbotenbez,
  pit_provinzgrp,
  ursprungsland
)
VALUES
(
  dwh_cr_load_id,
  dwh_id_sc_ww_adresse,
  id_key,
  adresseid_key,
  region,
  bezirk,
  hvs_depot,
  briefbotenbez,
  pit_provinzgrp,
  ursprungsland
)
SELECT
  a.dwh_cr_load_id,
  sc_ww_adresse.dwh_id AS dwh_id_sc_ww_adresse,
  a.id_key,
  a.adresseid_key,
  a.region,
  a.bezirk,
  a.hvs_depot,
  a.briefbotenbez,
  a.pit_provinzgrp,
  a.ursprungsland
FROM clsc_ww_adr_1 a
LEFT OUTER JOIN
  ( SELECT sc_ww_adresse.dwh_id, sc_ww_adresse.id_key FROM sc_ww_adresse) sc_ww_adresse
  ON (a.adresseid_key = sc_ww_adresse.id_key);

COMMIT;



PROMPT ===========================================
PROMPT  2.0 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_adr');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_adr_e');