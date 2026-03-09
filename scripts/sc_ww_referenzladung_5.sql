/*******************************************************************************

Job:                  sc_ww_referenzladung_5
Beschreibung:         Job lädt Referenzen. Verwendete Referenzen im nDWH werden 
                      über die Job's sc_ww_referenzladung_1, sc_ww_referenzladung_2, 
                      sc_ww_referenzladung_3, sc_ww_referenzladung_4,
                      sc_ww_referenzladung_5 und sc_ww_referenzladung_6 geladen.
                      Alle sonstigen Referenzen werden über den Job sc_ww_referenzladung_sonst 
                      geladen, solange, bis sie in einer neuen Ladestrecke verwendet werden.
          
Erstellt am:          07.06.2016
Erstellt von:         stegrs       
Ansprechpartner:      Jochen König, Stephanie Graßler, Stefan Ernstberger    
Ansprechpartner-IT: -

verwendete Tabellen:  st_ww_kundenfirma_b 
                      st_ww_crsfg_b
                      st_ww_verwkzextern_b
                      st_ww_wagrp_ek_b
                       
Endtabellen:          sc_ww_kundenfirma / sc_ww_kundenfirma_ver
                      sc_ww_crsfg / sc_ww_crsfg_ver
                      sc_ww_verwkzextern / sc_ww_verwkzextern_ver
                      sc_ww_wagrp_ek / sc_ww_wagrp_ek_ver

Fehler-Doku:      -
Ladestrecke:      -

********************************************************************************
geändert am:          2016-03-02
geändert von:         stegrs
Änderungen:           ##.1: DSV-Job auf UDWH stg_ww_referenz_22uhr (nach alten Konventionen) wurde deaktiviert und neuer Job st_ww_referenz_22uhr_dp auf UDWH_T aktiviert

geändert am:          2016-03-14
geändert von:         stegrs
Änderungen:           ##.2: Entfernen der Referenzen FIRMA und NEUKUNDENANLAUFWEG; beide seit 2014 nicht befüllt

geändert am:          2016-03-15
geändert von:         stegrs
Änderungen:           ##.3: Schreibfehler für Spaltenbezeichnung iso3166num in Tabelle Land korrigiert

geändert am:          2016-06-07
geändert von:         stegrs
Änderungen:           ##.4: Aufteilung Job st_ww_referenz22uhr_dp in 2 Jobs; st_ww_referenzladung_dp und st_ww_referenzladung_sonst_dp

geändert am:          2016-06-22
geändert von:         stegrs
Änderungen:           ##.5: Korrektur Ladung in Error-Tabellen, Spalte DWH_UP_LOAD_ID berücksichtigen

geändert am:          2016-06-23
geändert von:         stegrs
Änderungen:           ##.6 Umzug auf Produktivsystem UDWH

geändert am:          2016-08-25
geändert von:         stegrs
Änderungen:           ##.7 Umzug von KUNDENFIRMA und CRSFG in sc_ww_referenzladung_4

geändert am:          2016-10-24
geändert von:         stegrs, jockoe
Änderungen:           ##.8 Uhrzeit von 22:05 auf 00:00 verlegt

geändert am:          2017-01-18
geändert von:         stegrs
Änderungen:           ##.9 Umzug von ARTGRP in sc_ww_referenzladung_4 (falsch in _1 gewesen!)

geändert am:          2017-01-18
geändert von:         stegrs
Änderungen:           ##.10 Tabelle VERWKZEXTERN hinzugefügt

geändert am:          2017-10-09
geändert von:         stegrs
Änderungen:           ##.11 Tabelle KUNDENFIRMA um Spalten erweitert

geändert am:          2017-10-24
geändert von:         stegrs
Änderungen:           ##.12: Referenzjob _4 in _5 umbenannt

geändert am:          2018-03-19
geändert von:         stegrs
Änderungen:           ##.13: Tabelle KUNDENFIRMA um Spalte erweitert

geändert am:          2018-07-10
geändert von:         stegrs
Änderungen:           ##.4: Tabelle ARTGRP von _5 in _6 umgezogen

geändert am:          2018-07-10
geändert von:         stegrs
Änderungen:           ##.5: Tabelle WAGRP_EK von _4 in _5 umgezogen

geändert am:          2018-07-11
geändert von:         stegrs
Änderungen:           ##.8: Tabelle WAGRP_EK Referenzauflösung von sc_ww_saison in
                            sc_ww_eksaison geändert
                            
geändert am:          2019-01-16
geändert von:         stegrs
Änderungen:           ##.9: Tabelle CRSFG um Referenzspalte erweitert

geändert am:          2019-12-18
geändert von:         svehoc
Änderungen:           ##.10: Umzug auf UDWH1

geändert am:          17.05.2021
geändert von:         isrrod
Änderungen:           ##.11: Added column KONTO_ID_KEY AND KUNDE_ID_KEY to SC_WW_CRSFG Process.
*******************************************************************************/

ALTER SESSION ENABLE PARALLEL DML;

PROMPT =========================================================================
PROMPT Parameter
PROMPT GBV-Job ID: &gbvid
PROMPT Prozessdatum: &termin
PROMPT =========================================================================



PROMPT =========================================================================
PROMPT
PROMPT 1. Source Core-Ladung
PROMPT Endtabelle: sc_ww_kundenfirma / sc_ww_kundenfirma_ver
PROMPT
PROMPT =========================================================================



PROMPT ===========================================
PROMPT  1.1 Cleansing Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clsc_ww_kundenfirma;
TRUNCATE TABLE clsc_ww_kundenfirma_1;
TRUNCATE TABLE clsc_ww_kundenfirma_d;
 
 
 
PROMPT ===========================================
PROMPT  1.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_kundenfirma_1
(
   dwh_cr_load_id,
   kdfirmkz,
   kdfirmbez,
   firmkz,
   vertrgebiet,
   firmkurz1,
   firmkurz2,
   email1,
   email2,
   id,
   landid,
   konzernfirmaid,
   firmkurz3,
   profitcenterid,
   aktivkz,
   extkz,
   adrklaerkz,
   sepakz,
   servmailverskz,
   auszahluntergrenzbetrag,
   auszahlanztage,
   adresseiddatenschutz,
   b2ccompanynr,
   noacompanynr,
   benutzeridcbtstandard,
   kssortkz
)
VALUES
(
   &gbvid,
   kdfirmkz,
   kdfirmbez,
   firmkz,
   vertrgebiet,
   firmkurz1,
   firmkurz2,
   email1,
   email2,
   id,
   landid,
   konzernfirmaid,
   firmkurz3,
   profitcenterid,
   aktivkz,
   extkz,
   adrklaerkz,
   sepakz,
   servmailverskz,
   auszahluntergrenzbetrag,
   auszahlanztage,
   adresseiddatenschutz,
   b2ccompanynr,
   noacompanynr,
   benutzeridcbtstandard,
   kssortkz
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_kundenfirma_d
(
   dwh_cr_load_id,
   id
)
VALUES
(
   &gbvid,
   id
)
SELECT DISTINCT
   dwh_stbflag,
   kdfirmkz,
   kdfirmbez,
   firmkz,
   vertrgebiet,
   firmkurz1,
   firmkurz2,
   email1,
   email2,
   id,
   landid,
   konzernfirmaid,
   firmkurz3,
   profitcenterid,
   aktivkz,
   extkz,
   adrklaerkz,
   sepakz,
   servmailverskz,
   auszahluntergrenzbetrag,
   auszahlanztage,
   adresseiddatenschutz,
   b2ccompanynr,
   noacompanynr,
   benutzeridcbtstandard,
   kssortkz
FROM st_ww_kundenfirma_b
WHERE dwh_processdate = &termin;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  1.3 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_kundenfirma_1');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_kundenfirma_d');
 
 
 
PROMPT ===========================================
PROMPT  1.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING('clsc_ww_kundenfirma', 'id', &gbvid);
 


/*
* Eine Referenzauflösung für die Spalte "profitcenterid"
* findet aktuell nicht statt, da diese Tabellen nicht verwendet werden
*/
PROMPT ===========================================
PROMPT  1.5 Einspielen in die letzte SC-Tabelle mit Referenzauflösung
PROMPT ===========================================
 
INSERT /*+ APPEND */ FIRST
WHEN (dwh_id_sc_ww_land IS NULL 
   OR dwh_id_sc_ww_konzernfirma IS NULL 
) THEN
INTO clsc_ww_kundenfirma_e
(
   dwh_cr_load_id,
   dwh_up_load_id,
   dwh_id_sc_ww_land,
   dwh_id_sc_ww_konzernfirma,
   kdfirmkz,
   kdfirmbez,
   firmkz,
   vertrgebiet,
   firmkurz1,
   firmkurz2,
   email1,
   email2,
   id,
   landid,
   konzernfirmaid,
   firmkurz3,
   profitcenterid,
   aktivkz,
   extkz,
   adrklaerkz,
   sepakz,
   servmailverskz,
   auszahluntergrenzbetrag,
   auszahlanztage,
   adresseiddatenschutz,
   b2ccompanynr,
   noacompanynr,
   benutzeridcbtstandard,
   kssortkz
)
VALUES
(
   dwh_cr_load_id,
   &gbvid,
   dwh_id_sc_ww_land,
   dwh_id_sc_ww_konzernfirma,
   kdfirmkz,
   kdfirmbez,
   firmkz,
   vertrgebiet,
   firmkurz1,
   firmkurz2,
   email1,
   email2,
   id,
   landid,
   konzernfirmaid,
   firmkurz3,
   profitcenterid,
   aktivkz,
   extkz,
   adrklaerkz,
   sepakz,
   servmailverskz,
   auszahluntergrenzbetrag,
   auszahlanztage,
   adresseiddatenschutz,
   b2ccompanynr,
   noacompanynr,
   benutzeridcbtstandard,
   kssortkz
)
ELSE
INTO clsc_ww_kundenfirma
(
   dwh_cr_load_id,
   dwh_id_sc_ww_land,
   dwh_id_sc_ww_konzernfirma,
   kdfirmkz,
   kdfirmbez,
   firmkz,
   vertrgebiet,
   firmkurz1,
   firmkurz2,
   email1,
   email2,
   id,
   landid,
   konzernfirmaid,
   firmkurz3,
   profitcenterid,
   aktivkz,
   extkz,
   adrklaerkz,
   sepakz,
   servmailverskz,
   auszahluntergrenzbetrag,
   auszahlanztage,
   adresseiddatenschutz,
   b2ccompanynr,
   noacompanynr,
   benutzeridcbtstandard,
   kssortkz
)
SELECT
   a.dwh_cr_load_id,
   sc_ww_land.dwh_id AS dwh_id_sc_ww_land,
   sc_ww_konzernfirma.dwh_id AS dwh_id_sc_ww_konzernfirma,
   a.kdfirmkz AS kdfirmkz,
   a.kdfirmbez AS kdfirmbez,
   a.firmkz AS firmkz,
   a.vertrgebiet AS vertrgebiet,
   a.firmkurz1 AS firmkurz1,
   a.firmkurz2 AS firmkurz2,
   a.email1 AS email1,
   a.email2 AS email2,
   a.id AS id,
   a.landid AS landid,
   a.konzernfirmaid AS konzernfirmaid,
   a.firmkurz3 AS firmkurz3,
   a.profitcenterid AS profitcenterid,
   a.aktivkz AS aktivkz,
   a.extkz AS extkz,
   a.adrklaerkz AS adrklaerkz,
   a.sepakz AS sepakz,
   a.servmailverskz AS servmailverskz,
   a.auszahluntergrenzbetrag AS auszahluntergrenzbetrag,
   a.auszahlanztage AS auszahlanztage,
   a.adresseiddatenschutz AS adresseiddatenschutz,
   a.b2ccompanynr AS b2ccompanynr,
   a.noacompanynr AS noacompanynr,
   a.benutzeridcbtstandard AS benutzeridcbtstandard,
   a.kssortkz AS kssortkz
FROM clsc_ww_kundenfirma_1 a
  LEFT OUTER JOIN (SELECT sc_ww_land.dwh_id, sc_ww_land.id FROM sc_ww_land)  sc_ww_land
      ON (a.landid = sc_ww_land.id)
  LEFT OUTER JOIN (SELECT sc_ww_konzernfirma.dwh_id, sc_ww_konzernfirma.id FROM sc_ww_konzernfirma)  sc_ww_konzernfirma
      ON (COALESCE(a.konzernfirmaid, '$') = sc_ww_konzernfirma.id)
;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  1.6 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_kundenfirma');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_kundenfirma_e');



PROMPT =========================================================================
PROMPT
PROMPT 2. Source Core-Ladung
PROMPT Endtabelle: sc_ww_crsfg / sc_ww_crsfg_ver
PROMPT
PROMPT =========================================================================



PROMPT ===========================================
PROMPT  2.1 Cleansing Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clsc_ww_crsfg;
TRUNCATE TABLE clsc_ww_crsfg_1;
TRUNCATE TABLE clsc_ww_crsfg_d;
 
 
 
PROMPT ===========================================
PROMPT  2.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_crsfg_1
(
   dwh_cr_load_id,
   id,
   konto_id_key,
   crskz,
   bez,
   fgnrcrs,
   vertrgebietkz,
   kdnr,
   kdfirmkz,
   bez1,
   bez2,
   bez4,
   bez3,
   wazkz,
   kundeid_key,
   konzernfirmaid,
   profitcenterid,
   wamostransferkz,
   crstypkz,
   crsschnittstellekz,
   sappartnereinhid,
   vertrgebietidartnrfremd
)
VALUES
(
   &gbvid,
   id,
   konto_id_key,
   crskz,
   bez,
   fgnrcrs,
   vertrgebietkz,
   kdnr,
   kdfirmkz,
   bez1,
   bez2,
   bez4,
   bez3,
   wazkz,
   kundeid_key,
   konzernfirmaid,
   profitcenterid,
   wamostransferkz,
   crstypkz,
   crsschnittstellekz,
   sappartnereinhid,
   vertrgebietidartnrfremd
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_crsfg_d
(
   dwh_cr_load_id,
   id
)
VALUES
(
   &gbvid,
   id
)
SELECT DISTINCT
   dwh_stbflag,
   id,
   konto_id_key,
   crskz,
   bez,
   fgnrcrs,
   vertrgebietkz,
   kdnr,
   kdfirmkz,
   bez1,
   bez2,
   bez4,
   bez3,
   wazkz,
   kundeid_key,
   konzernfirmaid,
   profitcenterid,
   wamostransferkz,
   crstypkz,
   crsschnittstellekz,
   sappartnereinhid,
   vertrgebietidartnrfremd
FROM st_ww_crsfg_b
WHERE dwh_processdate = &termin;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  2.3 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_crsfg_1');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_crsfg_d');
 
 
 
PROMPT ===========================================
PROMPT  2.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING('clsc_ww_crsfg', 'id', &gbvid);
 


/*
* Eine Referenzauflösung für die Spalten "kundeid" und "profitcenterid"
* findet aktuell nicht statt, da diese Tabellen nicht verwendet werden
* AUSNAHME: kunde siehe Kundendaten-Ladung
*/
PROMPT ===========================================
PROMPT  2.5 Einspielen in die letzte SC-Tabelle mit Referenzauflösung
PROMPT ===========================================
 
INSERT /*+ APPEND */ FIRST
WHEN (dwh_id_sc_ww_konzernfirma IS NULL 
     OR dwh_id_sc_ww_vertrgebiet IS NULL
) THEN
INTO clsc_ww_crsfg_e
(
   dwh_cr_load_id,
   dwh_up_load_id,
   dwh_id_sc_ww_konzernfirma,
   dwh_id_sc_ww_vertrgebiet,
   id,
   konto_id_key,
   crskz,
   bez,
   fgnrcrs,
   vertrgebietkz,
   kdnr,
   kdfirmkz,
   bez1,
   bez2,
   bez4,
   bez3,
   wazkz,
   kundeid_key,
   konzernfirmaid,
   profitcenterid,
   wamostransferkz,
   crstypkz,
   crsschnittstellekz,
   sappartnereinhid,
   vertrgebietidartnrfremd
)
VALUES
(
   dwh_cr_load_id,
   &gbvid,
   dwh_id_sc_ww_konzernfirma,
   dwh_id_sc_ww_vertrgebiet,
   id,
   konto_id_key,
   crskz,
   bez,
   fgnrcrs,
   vertrgebietkz,
   kdnr,
   kdfirmkz,
   bez1,
   bez2,
   bez4,
   bez3,
   wazkz,
   kundeid_key,
   konzernfirmaid,
   profitcenterid,
   wamostransferkz,
   crstypkz,
   crsschnittstellekz,
   sappartnereinhid,
   vertrgebietidartnrfremd
)
ELSE
INTO clsc_ww_crsfg
(
   dwh_cr_load_id,
   dwh_id_sc_ww_konzernfirma,
   dwh_id_sc_ww_vertrgebiet,
   id,
   konto_id_key,
   crskz,
   bez,
   fgnrcrs,
   vertrgebietkz,
   kdnr,
   kdfirmkz,
   bez1,
   bez2,
   bez4,
   bez3,
   wazkz,
   kundeid_key,
   konzernfirmaid,
   profitcenterid,
   wamostransferkz,
   crstypkz,
   crsschnittstellekz,
   sappartnereinhid,
   vertrgebietidartnrfremd
)
SELECT
   a.dwh_cr_load_id,
   sc_ww_konzernfirma.dwh_id AS dwh_id_sc_ww_konzernfirma,
   sc_ww_vertrgebiet.dwh_id AS dwh_id_sc_ww_vertrgebiet,
   a.id AS id,
   a.konto_id_key AS konto_id_key,
   a.crskz AS crskz,
   a.bez AS bez,
   a.fgnrcrs AS fgnrcrs,
   a.vertrgebietkz AS vertrgebietkz,
   a.kdnr AS kdnr,
   a.kdfirmkz AS kdfirmkz,
   a.bez1 AS bez1,
   a.bez2 AS bez2,
   a.bez4 AS bez4,
   a.bez3 AS bez3,
   a.wazkz AS wazkz,
   a.kundeid_key AS kundeid_key,
   a.konzernfirmaid AS konzernfirmaid,
   a.profitcenterid AS profitcenterid,
   a.wamostransferkz AS wamostransferkz,
   a.crstypkz AS crstypkz,
   a.crsschnittstellekz AS crsschnittstellekz,
   a.sappartnereinhid AS sappartnereinhid,
   a.vertrgebietidartnrfremd AS vertrgebietidartnrfremd
FROM clsc_ww_crsfg_1 a
  LEFT OUTER JOIN (SELECT sc_ww_konzernfirma.dwh_id, sc_ww_konzernfirma.id FROM sc_ww_konzernfirma)  sc_ww_konzernfirma
      ON (COALESCE(a.konzernfirmaid, '$') = sc_ww_konzernfirma.id)
  LEFT OUTER JOIN (SELECT sc_ww_vertrgebiet.dwh_id, sc_ww_vertrgebiet.id FROM sc_ww_vertrgebiet) sc_ww_vertrgebiet
      ON (COALESCE(a.vertrgebietidartnrfremd, '$') = sc_ww_vertrgebiet.id)
;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  2.6 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_crsfg');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_crsfg_e');


PROMPT =========================================================================
PROMPT
PROMPT 3. Source Core-Ladung
PROMPT Endtabelle: sc_ww_verwkzextern / sc_ww_verwkzextern_ver
PROMPT
PROMPT =========================================================================
 
 
 
PROMPT ===========================================
PROMPT  3.1 Cleansing Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clsc_ww_verwkzextern;
TRUNCATE TABLE clsc_ww_verwkzextern_1;
TRUNCATE TABLE clsc_ww_verwkzextern_d;
 
 
 
PROMPT ===========================================
PROMPT  3.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_verwkzextern_1
(
   dwh_cr_load_id,
   id,
   verwkz,
   bez,
   vertrgebietid
)
VALUES
(
   &gbvid,
   id,
   verwkz,
   bez,
   vertrgebietid
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_verwkzextern_d
(
   dwh_cr_load_id,
   id
)
VALUES
(
   &gbvid,
   id
)
SELECT DISTINCT
   dwh_stbflag,
   id,
   verwkz,
   bez,
   vertrgebietid
FROM st_ww_verwkzextern_b
WHERE dwh_processdate = &termin;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  3.3 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_verwkzextern_1');
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_verwkzextern_d');
 
 
 
PROMPT ===========================================
PROMPT  3.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING ('clsc_ww_verwkzextern', 'id', &gbvid);
 
 
 
PROMPT ===========================================
PROMPT  3.5 Einspielen in die letzte SC-Tabelle mit Referenzauflösung
PROMPT ===========================================
 
INSERT /*+ APPEND */ FIRST
WHEN (dwh_id_sc_ww_vertrgebiet IS NULL 
) THEN
INTO clsc_ww_verwkzextern_e
(
   dwh_cr_load_id,
   dwh_up_load_id,
   dwh_id_sc_ww_vertrgebiet,
   id,
   verwkz,
   bez,
   vertrgebietid
)
VALUES
(
   dwh_cr_load_id,
   &gbvid,
   dwh_id_sc_ww_vertrgebiet,
   id,
   verwkz,
   bez,
   vertrgebietid
)
ELSE
INTO clsc_ww_verwkzextern
(
   dwh_cr_load_id,
   dwh_id_sc_ww_vertrgebiet,
   id,
   verwkz,
   bez,
   vertrgebietid
)
SELECT
   a.dwh_cr_load_id,
   sc_ww_vertrgebiet.dwh_id AS dwh_id_sc_ww_vertrgebiet,
   a.id AS id,
   a.verwkz AS verwkz,
   a.bez AS bez,
   a.vertrgebietid AS vertrgebietid
FROM clsc_ww_verwkzextern_1 a
  LEFT OUTER JOIN (SELECT sc_ww_vertrgebiet.dwh_id, sc_ww_vertrgebiet.id FROM sc_ww_vertrgebiet)  sc_ww_vertrgebiet
      ON (a.vertrgebietid = sc_ww_vertrgebiet.id)
;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  3.6 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_verwkzextern');
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_verwkzextern_e');



PROMPT =========================================================================
PROMPT
PROMPT 4. Source Core-Ladung
PROMPT Endtabelle: sc_ww_wagrp_ek / sc_ww_wagrp_ek_ver
PROMPT
PROMPT =========================================================================
 
 
 
PROMPT ===========================================
PROMPT  4.1 Cleansing Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clsc_ww_wagrp_ek;
TRUNCATE TABLE clsc_ww_wagrp_ek_1;
TRUNCATE TABLE clsc_ww_wagrp_ek_d;
 
 
 
PROMPT ===========================================
PROMPT  4.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_wagrp_ek_1
(
   dwh_cr_load_id,
   saison,
   etber,
   wagrp,
   vfkz,
   wagrpbez,
   sortikz,
   nl_gew_proz,
   stabwgruppeid,
   nl_gew_proz_ea,
   nllibsperrkz,
   id,
   wagrpsortimentideins,
   wagrpsortimentidzwei,
   benutzeriderri,
   erridat,
   aenddat,
   benutzeridaend
)
VALUES
(
   &gbvid,
   saison,
   etber,
   wagrp,
   vfkz,
   wagrpbez,
   sortikz,
   nl_gew_proz,
   stabwgruppeid,
   nl_gew_proz_ea,
   nllibsperrkz,
   id,
   wagrpsortimentideins,
   wagrpsortimentidzwei,
   benutzeriderri,
   erridat,
   aenddat,
   benutzeridaend
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_wagrp_ek_d
(
   dwh_cr_load_id,
   id
)
VALUES
(
   &gbvid,
   id
)
SELECT DISTINCT
   dwh_stbflag,
   saison,
   etber,
   wagrp,
   vfkz,
   wagrpbez,
   sortikz,
   nl_gew_proz,
   stabwgruppeid,
   nl_gew_proz_ea,
   nllibsperrkz,
   id,
   wagrpsortimentideins,
   wagrpsortimentidzwei,
   benutzeriderri,
   erridat,
   aenddat,
   benutzeridaend
FROM st_ww_wagrp_ek_b
WHERE dwh_processdate = &termin;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  4.3 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_wagrp_ek_1');
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_wagrp_ek_d');
 
 
 
PROMPT ===========================================
PROMPT  4.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING ('clsc_ww_wagrp_ek', 'id', &gbvid);
 
 
 
/* Referenzauflösung zu Benutzer wird zu einem späteren Zeitpunkt nachgezogen
die Spalten für Benutzer sind aktuell noch nicht gepflegt
*/ 
PROMPT ===========================================
PROMPT  4.5 Einspielen in die letzte SC-Tabelle mit Referenzauflösung
PROMPT ===========================================
 
INSERT /*+ APPEND */ FIRST
WHEN (dwh_id_sc_ww_eksaison IS NULL 
   OR dwh_id_sc_ww_etber IS NULL 
) THEN
INTO clsc_ww_wagrp_ek_e
(
   dwh_cr_load_id,
   dwh_up_load_id,
   dwh_id_sc_ww_eksaison,
   dwh_id_sc_ww_etber,
   saison,
   etber,
   wagrp,
   vfkz,
   wagrpbez,
   sortikz,
   nl_gew_proz,
   stabwgruppeid,
   nl_gew_proz_ea,
   nllibsperrkz,
   id,
   wagrpsortimentideins,
   wagrpsortimentidzwei,
   benutzeriderri,
   erridat,
   aenddat,
   benutzeridaend
)
VALUES
(
   dwh_cr_load_id,
   &gbvid,
   dwh_id_sc_ww_eksaison,
   dwh_id_sc_ww_etber,
   saison,
   etber,
   wagrp,
   vfkz,
   wagrpbez,
   sortikz,
   nl_gew_proz,
   stabwgruppeid,
   nl_gew_proz_ea,
   nllibsperrkz,
   id,
   wagrpsortimentideins,
   wagrpsortimentidzwei,
   benutzeriderri,
   erridat,
   aenddat,
   benutzeridaend
)
ELSE
INTO clsc_ww_wagrp_ek
(
   dwh_cr_load_id,
   dwh_id_sc_ww_eksaison,
   dwh_id_sc_ww_etber,
   saison,
   etber,
   wagrp,
   vfkz,
   wagrpbez,
   sortikz,
   nl_gew_proz,
   stabwgruppeid,
   nl_gew_proz_ea,
   nllibsperrkz,
   id,
   wagrpsortimentideins,
   wagrpsortimentidzwei,
   benutzeriderri,
   erridat,
   aenddat,
   benutzeridaend
)
SELECT
   a.dwh_cr_load_id,
   sc_ww_eksaison.dwh_id AS dwh_id_sc_ww_eksaison,
   sc_ww_etber.dwh_id AS dwh_id_sc_ww_etber,
   a.saison AS saison,
   a.etber AS etber,
   a.wagrp AS wagrp,
   a.vfkz AS vfkz,
   a.wagrpbez AS wagrpbez,
   a.sortikz AS sortikz,
   a.nl_gew_proz AS nl_gew_proz,
   a.stabwgruppeid AS stabwgruppeid,
   a.nl_gew_proz_ea AS nl_gew_proz_ea,
   a.nllibsperrkz AS nllibsperrkz,
   a.id AS id,
   a.wagrpsortimentideins AS wagrpsortimentideins,
   a.wagrpsortimentidzwei AS wagrpsortimentidzwei,
   a.benutzeriderri AS benutzeriderri,
   a.erridat AS erridat,
   a.aenddat AS aenddat,
   a.benutzeridaend AS benutzeridaend
FROM clsc_ww_wagrp_ek_1 a
  LEFT OUTER JOIN (SELECT sc_ww_eksaison.dwh_id, sc_ww_eksaison.wert FROM sc_ww_eksaison) sc_ww_eksaison
      ON (a.saison = sc_ww_eksaison.wert)
  LEFT OUTER JOIN (SELECT K1.dwh_id, V1.etber, V1.saison
                   FROM sc_ww_etber K1 JOIN sc_ww_etber_ver V1
                   ON (K1.dwh_id = V1.dwh_id_head AND &termin BETWEEN V1.dwh_valid_from AND V1.dwh_valid_to))  sc_ww_etber
      ON (a.etber = sc_ww_etber.etber
          AND a.saison = sc_ww_etber.saison)
;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  4.6 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_wagrp_ek');
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_wagrp_ek_e');