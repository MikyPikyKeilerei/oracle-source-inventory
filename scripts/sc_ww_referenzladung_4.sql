/*******************************************************************************

Job:                  sc_ww_referenzladung_4
Beschreibung:         Job lädt Referenzen. Verwendete Referenzen im nDWH werden 
                      über die Job's sc_ww_referenzladung_1, sc_ww_referenzladung_2, 
                      sc_ww_referenzladung_3, sc_ww_referenzladung_4,
                      sc_ww_referenzladung_5 und sc_ww_referenzladung_6 geladen.
                      Alle sonstigen Referenzen werden über den Job sc_ww_referenzladung_sonst 
                      geladen, solange, bis sie in einer neuen Ladestrecke verwendet werden.
          
Erstellt am:          25.08.2016
Erstellt von:         stegrs       
Ansprechpartner:      stegrs, joeabd
Ansprechpartner-IT: -

verwendete Tabellen:  st_ww_konzernfirma_b
                      st_ww_mwst_b
                      st_ww_vertrgebiet_b
                      st_ww_marktkz_zuord_b
                      st_ww_hermes_notdepotsta_b
                      st_ww_etber_b
                       
Endtabellen:          sc_ww_konzernfirma / sc_ww_konzernfirma_ver
                      sc_ww_mwst / sc_ww_mwst_ver
                      sc_ww_vertrgebiet / sc_ww_vertrgebiet_ver
                      sc_ww_marktkz_zuord / sc_ww_marktkz_zuord_ver
                      sc_ww_hermes_notdepotsta / sc_ww_hermes_notdepotsta_ver
                      sc_ww_etber / sc_ww_etber_ver

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
Änderungen:           ##.7 Umzug von KUNDENFIRMA und CRSFG in sc_ww_referenzladung_4; Umzug von KONZERNFIRMA aus sc_ww_referenzladung_2; Neu MWST

geändert am:          2016-09-01
geändert von:         stegrs
Änderungen:           ##.8 Referenzauflösung für MWSTTYP in Tabelle MWST ergänzt

geändert am:          2016-09-23
geändert von:         stegrs
Änderungen:           ##.9 Tabelle WAGRP_EK hinzugefügt

geändert am:          2016-10-24
geändert von:         stegrs, jockoe
Änderungen:           ##.10 Uhrzeit von 22:05 auf 00:00 verlegt

geändert am:          2017-01-18
geändert von:         stegrs
Änderungen:           ##.11 Tabelle VERTRGEBIET aus sc_ww_referenzladung_1 übernommen

geändert am:          2017-01-20
geändert von:         joeabd
Änderungen:           ##.12 Abfrage im Abschluss-Skript auf clsc_ww_vertrgebiet eingefügt

geändert am:          2017-01-24
geändert von:         stegrs
Änderungen:           ##.13 Tabelle MARKTKZ_ZUORD hinzugefügt

geändert am:          2017-04-12
geändert von:         stegrs
Änderungen:           ##.14 Tabelle KONZERNFIRMA um Referenzspalten benutzer und bestandsfirma erweitert

geändert am:          2017-05-22
geändert von:         stegrs
Änderungen:           ##.15 Tabelle HERMES_NOTDEPOTSTA hinzugefügt

geändert am:          2017-05-24
geändert von:         stegrs
Änderungen:           ##.16 Referenzauflösung für HERMES_NOTDEPOTSTA zur LAND hinzugefügt

geändert am:          2017-08-08
geändert von:         stegrs
Änderungen:           ##.17 Tabelle VERTRGEBIET um Spalte erweitert

geändert am:          2017-09-04
geändert von:         joeabd
Änderungen:           ##.18 Übernahme diverser Spalten aus SC in CLSC-VERTRGEBIET

geändert am:          2017-10-24
geändert von:         stegrs
Änderungen:           ##.3: Referenzjob _3 in _4 umbenannt

geändert am:          2018-07-10
geändert von:         stegrs
Änderungen:           ##.5: Tabelle WAGRP_EK von _4 in _5 umgezogen

geändert am:          2018-07-10
geändert von:         stegrs
Änderungen:           ##.6: Tabelle ETBER von _3 in _4 umgezogen

geändert am:          2018-07-10
geändert von:         stegrs
Änderungen:           ##.7: Tabelle ETBER um Referenz ET_DIREKTOR erweitert

geändert am:          2018-07-11
geändert von:         stegrs
Änderungen:           ##.8: Tabelle ETBER Referenzauflösung von sc_ww_saison in
                            sc_ww_eksaison geändert

geändert am:          2018-07-11
geändert von:         stegrs
Änderungen:           ##.9: Tabelle ETBER Referenzauflösung zu sc_ww_einkleit hinzugefügt

geändert am:          2018-08-23
geändert von:         joeabd
Änderungen:           ##.10: Bugfix 3.6: vtgebiet_tm1 -> vtgebiet_bez_im

geändert am:          2018-10-05
geändert von:         stegrs
Änderungen:           ##.11: ETBER Referenzauflösung zu einkleit und etdirektor geändert

geändert am:          2019-09-11
geändert von:         joeabd
Änderungen:           ##.12: Tabelle VERTRGEBIET: "§" für Spalten VERTRGEBIET und VERTRGEBIETKZ umcodieren zu §§

geändert am:          2019-11-26
geändert von:         joeabd
Änderungen:           ##.13: ETBER Referenzauflösung zu einkleit angepasst: Einkleitnr 0 auf -3 umbiegen 

geändert am:          2019-12-18
geändert von:         svehoc
Änderungen:           ##.14: Umzug auf UDWH1

geändert am:          2022-10-05
geändert von:         isrrod
Änderungen:           ##.15: Added columns dwh_id_cc_bestandsfirma, dwh_id_cc_land and dwh_id_cc_konzernfirma.

geändert am:          2024-01-09
geändert von:         steern
Änderungen:           ##.16: Added column vtgebiet_bez_onetrust to sc_ww_vertrgebiet_ver

geändert am:          2024-01-09
geändert von:         marsil
Änderungen:           ##.17: Added column emarsys_customer_id to sc_ww_vertrgebiet_ver
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
PROMPT Endtabelle: sc_ww_konzernfirma / sc_ww_konzernfirma_ver
PROMPT
PROMPT =========================================================================



PROMPT ===========================================
PROMPT  1.1 Cleansing Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clsc_ww_konzernfirma;
TRUNCATE TABLE clsc_ww_konzernfirma_1;
TRUNCATE TABLE clsc_ww_konzernfirma_d;
 
 
 
PROMPT ===========================================
PROMPT  1.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_konzernfirma_1
(
   dwh_cr_load_id,
   id,
   firmkzkonz,
   bez,
   str,
   plz,
   ort,
   benutzeridletztaend,
   letztaenddat,
   bestandsfirmaid,
   telnrkb,
   faxnrkb,
   landid,
   firmbezwb,
   stranschrstr,
   stranschrplz,
   stranschrort,
   plzgk,
   postfbez,
   postfnr,
   postfplz,
   postfort,
   hrfirmbez,
   hrstr,
   hrplz,
   hrort,
   firmkzov,
   retplz,
   retort,
   retid,
   wittgruppekz,
   profitcenteridholding
)
VALUES
(
   &gbvid,
   id,
   firmkzkonz,
   bez,
   str,
   plz,
   ort,
   benutzeridletztaend,
   letztaenddat,
   bestandsfirmaid,
   telnrkb,
   faxnrkb,
   landid,
   firmbezwb,
   stranschrstr,
   stranschrplz,
   stranschrort,
   plzgk,
   postfbez,
   postfnr,
   postfplz,
   postfort,
   hrfirmbez,
   hrstr,
   hrplz,
   hrort,
   firmkzov,
   retplz,
   retort,
   retid,
   wittgruppekz,
   profitcenteridholding
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_konzernfirma_d
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
   firmkzkonz,
   bez,
   str,
   plz,
   ort,
   benutzeridletztaend,
   letztaenddat,
   bestandsfirmaid,
   telnrkb,
   faxnrkb,
   landid,
   firmbezwb,
   stranschrstr,
   stranschrplz,
   stranschrort,
   plzgk,
   postfbez,
   postfnr,
   postfplz,
   postfort,
   hrfirmbez,
   hrstr,
   hrplz,
   hrort,
   firmkzov,
   retplz,
   retort,
   retid,
   wittgruppekz,
   profitcenteridholding
FROM st_ww_konzernfirma_b
WHERE dwh_processdate = &termin;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  1.3 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_konzernfirma_1');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_konzernfirma_d');



PROMPT ===========================================
PROMPT  1.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING('clsc_ww_konzernfirma', 'id', &gbvid);
 

 
/*
* Eine Referenzauflösung für die Spalten "bestandsfirmaid" und "profitcenteridholding"
* findet aktuell nicht statt, da diese Tabellen nicht verwendet werden
*/
PROMPT ===========================================
PROMPT  1.5 Einspielen in die letzte SC-Tabelle mit Referenzauflösung
PROMPT ===========================================
 
INSERT /*+ APPEND */ FIRST
WHEN (dwh_id_sc_ww_benutzer IS NULL
    OR dwh_id_sc_ww_bestandsfirma IS NULL
    OR dwh_id_sc_ww_land IS NULL
) THEN
INTO clsc_ww_konzernfirma_e
(
   dwh_cr_load_id,
   dwh_up_load_id,
   dwh_id_sc_ww_benutzer,
   dwh_id_sc_ww_bestandsfirma,
   dwh_id_sc_ww_land,
   id,
   firmkzkonz,
   bez,
   str,
   plz,
   ort,
   benutzeridletztaend,
   letztaenddat,
   bestandsfirmaid,
   telnrkb,
   faxnrkb,
   landid,
   firmbezwb,
   stranschrstr,
   stranschrplz,
   stranschrort,
   plzgk,
   postfbez,
   postfnr,
   postfplz,
   postfort,
   hrfirmbez,
   hrstr,
   hrplz,
   hrort,
   firmkzov,
   retplz,
   retort,
   retid,
   wittgruppekz,
   profitcenteridholding
)
VALUES
(
   dwh_cr_load_id,
   &gbvid,
   dwh_id_sc_ww_benutzer,
   dwh_id_sc_ww_bestandsfirma,
   dwh_id_sc_ww_land,
   id,
   firmkzkonz,
   bez,
   str,
   plz,
   ort,
   benutzeridletztaend,
   letztaenddat,
   bestandsfirmaid,
   telnrkb,
   faxnrkb,
   landid,
   firmbezwb,
   stranschrstr,
   stranschrplz,
   stranschrort,
   plzgk,
   postfbez,
   postfnr,
   postfplz,
   postfort,
   hrfirmbez,
   hrstr,
   hrplz,
   hrort,
   firmkzov,
   retplz,
   retort,
   retid,
   wittgruppekz,
   profitcenteridholding
)
ELSE
INTO clsc_ww_konzernfirma
(
   dwh_cr_load_id,
   dwh_id_sc_ww_benutzer,
   dwh_id_sc_ww_bestandsfirma,
   dwh_id_sc_ww_land,
   id,
   firmkzkonz,
   bez,
   str,
   plz,
   ort,
   benutzeridletztaend,
   letztaenddat,
   bestandsfirmaid,
   telnrkb,
   faxnrkb,
   landid,
   firmbezwb,
   stranschrstr,
   stranschrplz,
   stranschrort,
   plzgk,
   postfbez,
   postfnr,
   postfplz,
   postfort,
   hrfirmbez,
   hrstr,
   hrplz,
   hrort,
   firmkzov,
   retplz,
   retort,
   retid,
   wittgruppekz,
   profitcenteridholding
)
SELECT
   a.dwh_cr_load_id,
   sc_ww_benutzer.dwh_id AS dwh_id_sc_ww_benutzer,
   sc_ww_bestandsfirma.dwh_id AS dwh_id_sc_ww_bestandsfirma,
   sc_ww_land.dwh_id AS dwh_id_sc_ww_land,
   a.id AS id,
   a.firmkzkonz AS firmkzkonz,
   a.bez AS bez,
   a.str AS str,
   a.plz AS plz,
   a.ort AS ort,
   a.benutzeridletztaend AS benutzeridletztaend,
   a.letztaenddat AS letztaenddat,
   a.bestandsfirmaid AS bestandsfirmaid,
   a.telnrkb AS telnrkb,
   a.faxnrkb AS faxnrkb,
   a.landid AS landid,
   a.firmbezwb AS firmbezwb,
   a.stranschrstr AS stranschrstr,
   a.stranschrplz AS stranschrplz,
   a.stranschrort AS stranschrort,
   a.plzgk AS plzgk,
   a.postfbez AS postfbez,
   a.postfnr AS postfnr,
   a.postfplz AS postfplz,
   a.postfort AS postfort,
   a.hrfirmbez AS hrfirmbez,
   a.hrstr AS hrstr,
   a.hrplz AS hrplz,
   a.hrort AS hrort,
   a.firmkzov AS firmkzov,
   a.retplz AS retplz,
   a.retort AS retort,
   a.retid AS retid,
   a.wittgruppekz AS wittgruppekz,
   a.profitcenteridholding AS profitcenteridholding
FROM clsc_ww_konzernfirma_1 a
  LEFT OUTER JOIN (SELECT sc_ww_benutzer.dwh_id, sc_ww_benutzer.id FROM sc_ww_benutzer)  sc_ww_benutzer
      ON (a.benutzeridletztaend = sc_ww_benutzer.id)
  LEFT OUTER JOIN (SELECT sc_ww_bestandsfirma.dwh_id, sc_ww_bestandsfirma.id FROM sc_ww_bestandsfirma)  sc_ww_bestandsfirma
      ON (COALESCE(a.bestandsfirmaid, '$') = sc_ww_bestandsfirma.id)
  LEFT OUTER JOIN (SELECT sc_ww_land.dwh_id, sc_ww_land.id FROM sc_ww_land)  sc_ww_land
      ON (COALESCE(a.landid, '$') = sc_ww_land.id)
;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  1.6 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_konzernfirma');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_konzernfirma_e');



PROMPT =========================================================================
PROMPT
PROMPT 2. Source Core-Ladung
PROMPT Endtabelle: sc_ww_mwst / sc_ww_mwst_ver
PROMPT
PROMPT =========================================================================
 
 
 
PROMPT ===========================================
PROMPT  2.1 Cleansing Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clsc_ww_mwst;
TRUNCATE TABLE clsc_ww_mwst_1;
TRUNCATE TABLE clsc_ww_mwst_d;
 
 
 
PROMPT ===========================================
PROMPT  2.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_mwst_1
(
   dwh_cr_load_id,
   mwstkz,
   mwst_proz,
   mwstbem,
   vondat,
   bisdat,
   id,
   landid,
   mwsttyp
)
VALUES
(
   &gbvid,
   mwstkz,
   mwst_proz,
   mwstbem,
   vondat,
   bisdat,
   id,
   landid,
   mwsttyp
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_mwst_d
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
   mwstkz,
   mwst_proz,
   mwstbem,
   vondat,
   bisdat,
   id,
   landid,
   mwsttyp
FROM st_ww_mwst_b
WHERE dwh_processdate = &termin;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  2.3 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_mwst_1');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_mwst_d');
 
 
 
PROMPT ===========================================
PROMPT  2.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING('clsc_ww_mwst', 'id', &gbvid);
 
 
 
PROMPT ===========================================
PROMPT  2.5 Einspielen in die letzte SC-Tabelle mit Referenzauflösung
PROMPT ===========================================
 
INSERT /*+ APPEND */ FIRST
WHEN (dwh_id_sc_ww_land IS NULL
OR dwh_id_sc_ww_mwsttyp IS NULL
) THEN
INTO clsc_ww_mwst_e
(
   dwh_cr_load_id,
   dwh_up_load_id,
   dwh_id_sc_ww_land,
   dwh_id_sc_ww_mwsttyp,
   mwstkz,
   mwst_proz,
   mwstbem,
   vondat,
   bisdat,
   id,
   landid,
   mwsttyp
)
VALUES
(
   dwh_cr_load_id,
   &gbvid,
   dwh_id_sc_ww_land,
   dwh_id_sc_ww_mwsttyp,
   mwstkz,
   mwst_proz,
   mwstbem,
   vondat,
   bisdat,
   id,
   landid,
   mwsttyp
)
ELSE
INTO clsc_ww_mwst
(
   dwh_cr_load_id,
   dwh_id_sc_ww_land,
   dwh_id_sc_ww_mwsttyp,
   mwstkz,
   mwst_proz,
   mwstbem,
   vondat,
   bisdat,
   id,
   landid,
   mwsttyp
)
SELECT
   a.dwh_cr_load_id,
   sc_ww_land.dwh_id AS dwh_id_sc_ww_land,
   sc_ww_mwsttyp.dwh_id AS dwh_id_sc_ww_mwsttyp,
   a.mwstkz AS mwstkz,
   a.mwst_proz AS mwst_proz,
   a.mwstbem AS mwstbem,
   a.vondat AS vondat,
   a.bisdat AS bisdat,
   a.id AS id,
   a.landid AS landid,
   a.mwsttyp AS mwsttyp
FROM clsc_ww_mwst_1 a
  LEFT OUTER JOIN (SELECT sc_ww_land.dwh_id, sc_ww_land.id FROM sc_ww_land)  sc_ww_land
      ON (COALESCE(a.landid, '$') = sc_ww_land.id)
  LEFT OUTER JOIN (SELECT sc_ww_mwsttyp.dwh_id, sc_ww_mwsttyp.wert FROM sc_ww_mwsttyp) sc_ww_mwsttyp
      ON (COALESCE (a.mwsttyp, '$') = sc_ww_mwsttyp.wert)
;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  2.6 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_mwst');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_mwst_e');



PROMPT =========================================================================
PROMPT
PROMPT 3. Source Core-Ladung
PROMPT Endtabelle: sc_ww_vertrgebiet / sc_ww_vertrgebiet_ver
PROMPT
PROMPT =========================================================================
 
 
 
PROMPT ===========================================
PROMPT  3.1 Cleansing Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clsc_ww_vertrgebiet;
TRUNCATE TABLE clsc_ww_vertrgebiet_1;
TRUNCATE TABLE clsc_ww_vertrgebiet_d;
 
 
 
PROMPT ===========================================
PROMPT  3.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_vertrgebiet_1
(
   dwh_cr_load_id,
   vertrgebiet,
   vertrgebietbez,
   vertrgebietkurzbez,
   vertrgebietkz,
   sortkz,
   crskz,
   verdkz,
   egkz,
   landspracheid,
   kundenfirmaid,
   id,
   zolldatenkz,
   preisvt,
   hostkz,
   prodfirmkz,
   prodvtkz,
   paparelevantkz,
   libakz,
   prodflaggennr,
   hostvtkz,
   ecomshopid,
   artumschlkz,
   wazkz,
   grumschlkz,
   aktivkz,
   ersatzkz,
   vertrgebietgruppeid,
   sprachevt
)
VALUES
(
   &gbvid,
   vertrgebiet,
   vertrgebietbez,
   vertrgebietkurzbez,
   vertrgebietkz,
   sortkz,
   crskz,
   verdkz,
   egkz,
   landspracheid,
   kundenfirmaid,
   id,
   zolldatenkz,
   preisvt,
   hostkz,
   prodfirmkz,
   prodvtkz,
   paparelevantkz,
   libakz,
   prodflaggennr,
   hostvtkz,
   ecomshopid,
   artumschlkz,
   wazkz,
   grumschlkz,
   aktivkz,
   ersatzkz,
   vertrgebietgruppeid,
   sprachevt
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_vertrgebiet_d
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
   CASE WHEN vertrgebiet = '§' THEN '§§' ELSE vertrgebiet END AS vertrgebiet,
   vertrgebietbez,
   vertrgebietkurzbez,
   CASE WHEN vertrgebietkz = '§' THEN '§§' ELSE vertrgebietkz END AS vertrgebietkz,
   sortkz,
   crskz,
   verdkz,
   egkz,
   landspracheid,
   kundenfirmaid,
   id,
   zolldatenkz,
   preisvt,
   hostkz,
   prodfirmkz,
   prodvtkz,
   paparelevantkz,
   libakz,
   prodflaggennr,
   hostvtkz,
   ecomshopid,
   artumschlkz,
   wazkz,
   grumschlkz,
   aktivkz,
   ersatzkz,
   vertrgebietgruppeid,
   sprachevt
FROM st_ww_vertrgebiet_b
WHERE dwh_processdate = &termin;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  3.3 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_vertrgebiet_1');
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_vertrgebiet_d');
 
 
 
PROMPT ===========================================
PROMPT  3.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING ('clsc_ww_vertrgebiet', 'id', &gbvid);
 
 
 
PROMPT ===========================================
PROMPT  3.5 Einspielen in die letzte SC-Tabelle mit Referenzauflösung
PROMPT ===========================================
 
INSERT /*+ APPEND */ FIRST
WHEN (dwh_id_sc_ww_vertrgebietgruppe IS NULL 
) THEN
INTO clsc_ww_vertrgebiet_e
(
   dwh_cr_load_id,
   dwh_up_load_id,
   dwh_id_sc_ww_vertrgebietgruppe,
   vertrgebiet,
   vertrgebietbez,
   vertrgebietkurzbez,
   vertrgebietkz,
   sortkz,
   crskz,
   verdkz,
   egkz,
   landspracheid,
   kundenfirmaid,
   id,
   zolldatenkz,
   preisvt,
   hostkz,
   prodfirmkz,
   prodvtkz,
   paparelevantkz,
   libakz,
   prodflaggennr,
   hostvtkz,
   ecomshopid,
   artumschlkz,
   wazkz,
   grumschlkz,
   aktivkz,
   ersatzkz,
   vertrgebietgruppeid,
   sprachevt
)
VALUES
(
   dwh_cr_load_id,
   &gbvid,
   dwh_id_sc_ww_vertrgebietgruppe,
   vertrgebiet,
   vertrgebietbez,
   vertrgebietkurzbez,
   vertrgebietkz,
   sortkz,
   crskz,
   verdkz,
   egkz,
   landspracheid,
   kundenfirmaid,
   id,
   zolldatenkz,
   preisvt,
   hostkz,
   prodfirmkz,
   prodvtkz,
   paparelevantkz,
   libakz,
   prodflaggennr,
   hostvtkz,
   ecomshopid,
   artumschlkz,
   wazkz,
   grumschlkz,
   aktivkz,
   ersatzkz,
   vertrgebietgruppeid,
   sprachevt
)
ELSE
INTO clsc_ww_vertrgebiet
(
   dwh_cr_load_id,
   dwh_id_sc_ww_vertrgebietgruppe,
   vertrgebiet,
   vertrgebietbez,
   vertrgebietkurzbez,
   vertrgebietkz,
   sortkz,
   crskz,
   verdkz,
   egkz,
   landspracheid,
   kundenfirmaid,
   id,
   zolldatenkz,
   preisvt,
   hostkz,
   prodfirmkz,
   prodvtkz,
   paparelevantkz,
   libakz,
   prodflaggennr,
   hostvtkz,
   ecomshopid,
   artumschlkz,
   wazkz,
   grumschlkz,
   aktivkz,
   ersatzkz,
   vertrgebietgruppeid,
   sprachevt
)
SELECT
   a.dwh_cr_load_id,
   sc_ww_vertrgebietgruppe.dwh_id AS dwh_id_sc_ww_vertrgebietgruppe,
   a.vertrgebiet AS vertrgebiet,
   a.vertrgebietbez AS vertrgebietbez,
   a.vertrgebietkurzbez AS vertrgebietkurzbez,
   a.vertrgebietkz AS vertrgebietkz,
   a.sortkz AS sortkz,
   a.crskz AS crskz,
   a.verdkz AS verdkz,
   a.egkz AS egkz,
   a.landspracheid AS landspracheid,
   a.kundenfirmaid AS kundenfirmaid,
   a.id AS id,
   a.zolldatenkz AS zolldatenkz,
   a.preisvt AS preisvt,
   a.hostkz AS hostkz,
   a.prodfirmkz AS prodfirmkz,
   a.prodvtkz AS prodvtkz,
   a.paparelevantkz AS paparelevantkz,
   a.libakz AS libakz,
   a.prodflaggennr AS prodflaggennr,
   a.hostvtkz AS hostvtkz,
   a.ecomshopid AS ecomshopid,
   a.artumschlkz AS artumschlkz,
   a.wazkz AS wazkz,
   a.grumschlkz AS grumschlkz,
   a.aktivkz AS aktivkz,
   a.ersatzkz AS ersatzkz,
   a.vertrgebietgruppeid AS vertrgebietgruppeid,
   a.sprachevt AS sprachevt
FROM clsc_ww_vertrgebiet_1 a
  LEFT OUTER JOIN (SELECT sc_ww_vertrgebietgruppe.dwh_id, sc_ww_vertrgebietgruppe.id FROM sc_ww_vertrgebietgruppe)  sc_ww_vertrgebietgruppe
      ON (COALESCE(a.vertrgebietgruppeid, '$') = sc_ww_vertrgebietgruppe.id)
;
 
COMMIT;
 
 

PROMPT ===========================================
PROMPT  3.6 Übernahme manuell befüllter Spalten aus SC
PROMPT ===========================================
 
MERGE INTO clsc_ww_vertrgebiet a
USING
  (SELECT h.id, v.firma, v.firma_im, v.firma_konzern, v.preisfirma, v.vtgebiet_bez_im, v.vtgebiet_bez_onetrust, v.emarsys_customer_id
  FROM sc_ww_vertrgebiet h JOIN sc_ww_vertrgebiet_ver v
  ON (h.dwh_id = v.dwh_id_head AND v.dwh_valid_to = TO_DATE ('31.12.9999','dd.mm.rrrr'))) b
ON (a.id = b.id)
WHEN MATCHED THEN UPDATE
SET a.firma = b.firma,
  a.firma_im = b.firma_im,
  a.firma_konzern = b.firma_konzern,
  a.preisfirma = b.preisfirma,
  a.vtgebiet_bez_im = b.vtgebiet_bez_im,
  a.vtgebiet_bez_onetrust = b.vtgebiet_bez_onetrust,
  a.emarsys_customer_id = b.emarsys_customer_id; -- #17.

COMMIT;

 
 
PROMPT ===========================================
PROMPT  3.7 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_vertrgebiet');
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_vertrgebiet_e');



PROMPT =========================================================================
PROMPT
PROMPT 4. Source Core-Ladung
PROMPT Endtabelle: sc_ww_marktkz_zuord / sc_ww_marktkz_zuord_ver
PROMPT
PROMPT =========================================================================
 
 
 
PROMPT ===========================================
PROMPT  4.1 Cleansing Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clsc_ww_marktkz_zuord;
TRUNCATE TABLE clsc_ww_marktkz_zuord_1;
TRUNCATE TABLE clsc_ww_marktkz_zuord_d;
 
 
 
PROMPT ===========================================
PROMPT  4.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_marktkz_zuord_1
(
   dwh_cr_load_id,
   id,
   marktkzid,
   marktkz_verdid
)
VALUES
(
   &gbvid,
   id,
   marktkzid,
   marktkz_verdid
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_marktkz_zuord_d
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
   marktkzid,
   marktkz_verdid
FROM st_ww_marktkz_zuord_b
WHERE dwh_processdate = &termin;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  4.3 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_marktkz_zuord_1');
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_marktkz_zuord_d');
 
 
 
PROMPT ===========================================
PROMPT  4.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING ('clsc_ww_marktkz_zuord', 'id', &gbvid);
 
 
 
PROMPT ===========================================
PROMPT  4.5 Einspielen in die letzte SC-Tabelle mit Referenzauflösung
PROMPT ===========================================
 
INSERT /*+ APPEND */ FIRST
WHEN (dwh_id_sc_ww_marktkz IS NULL 
   OR dwh_id_sc_ww_marktkz_verd IS NULL 
) THEN
INTO clsc_ww_marktkz_zuord_e
(
   dwh_cr_load_id,
   dwh_up_load_id,
   dwh_id_sc_ww_marktkz,
   dwh_id_sc_ww_marktkz_verd,
   id,
   marktkzid,
   marktkz_verdid
)
VALUES
(
   dwh_cr_load_id,
   &gbvid,
   dwh_id_sc_ww_marktkz,
   dwh_id_sc_ww_marktkz_verd,
   id,
   marktkzid,
   marktkz_verdid
)
ELSE
INTO clsc_ww_marktkz_zuord
(
   dwh_cr_load_id,
   dwh_id_sc_ww_marktkz,
   dwh_id_sc_ww_marktkz_verd,
   id,
   marktkzid,
   marktkz_verdid
)
SELECT
   a.dwh_cr_load_id,
   sc_ww_marktkz.dwh_id AS dwh_id_sc_ww_marktkz,
   sc_ww_marktkz_verd.dwh_id AS dwh_id_sc_ww_marktkz_verd,
   a.id AS id,
   a.marktkzid AS marktkzid,
   a.marktkz_verdid AS marktkz_verdid
FROM clsc_ww_marktkz_zuord_1 a
  LEFT OUTER JOIN (SELECT sc_ww_marktkz.dwh_id, sc_ww_marktkz.id FROM sc_ww_marktkz)  sc_ww_marktkz
      ON (a.marktkzid = sc_ww_marktkz.id)
  LEFT OUTER JOIN (SELECT sc_ww_marktkz_verd.dwh_id, sc_ww_marktkz_verd.id FROM sc_ww_marktkz_verd)  sc_ww_marktkz_verd
      ON (a.marktkz_verdid = sc_ww_marktkz_verd.id)
;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  4.6 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_marktkz_zuord');
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_marktkz_zuord_e');



PROMPT =========================================================================
PROMPT
PROMPT 5. Source Core-Ladung
PROMPT Endtabelle: sc_ww_hermes_notdepotsta / sc_ww_hermes_notdepotsta_ver
PROMPT
PROMPT =========================================================================
 
 
 
PROMPT ===========================================
PROMPT  5.1 Cleansing Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clsc_ww_hermes_notdepotsta;
TRUNCATE TABLE clsc_ww_hermes_notdepotsta_1;
TRUNCATE TABLE clsc_ww_hermes_notdepotsta_d;
 
 
 
PROMPT ===========================================
PROMPT  5.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_hermes_notdepotsta_1
(
   dwh_cr_load_id,
   plzvon,
   plzbis,
   notdepotnr,
   notdepotname,
   landnr,
   notdepottour
)
VALUES
(
   &gbvid,
   plzvon,
   plzbis,
   notdepotnr,
   notdepotname,
   landnr,
   notdepottour
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_hermes_notdepotsta_d
(
   dwh_cr_load_id,
   plzvon,
   plzbis,
   landnr
)
VALUES
(
   &gbvid,
   plzvon,
   plzbis,
   landnr
)
SELECT DISTINCT
   dwh_stbflag,
   plzvon,
   plzbis,
   notdepotnr,
   notdepotname,
   landnr,
   notdepottour
FROM st_ww_hermes_notdepotsta_b
WHERE dwh_processdate = &termin;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  5.3 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_hermes_notdepotsta_1');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_hermes_notdepotsta_d');
 
 
 
PROMPT ===========================================
PROMPT  5.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING('clsc_ww_hermes_notdepotsta', 'plzvon, plzbis, landnr', &gbvid);
 
 
 
PROMPT ===========================================
PROMPT  5.5 Einspielen in die letzte SC-Tabelle mit Referenzauflösung
PROMPT ===========================================
 
INSERT /*+ APPEND */ FIRST
WHEN (dwh_id_sc_ww_land IS NULL
) THEN
INTO clsc_ww_hermes_notdepotsta_e
(
   dwh_cr_load_id,
   dwh_up_load_id,
   dwh_id_sc_ww_land,
   plzvon,
   plzbis,
   notdepotnr,
   notdepotname,
   landnr,
   notdepottour
)
VALUES
(
   dwh_cr_load_id,
   &gbvid,
   dwh_id_sc_ww_land,
   plzvon,
   plzbis,
   notdepotnr,
   notdepotname,
   landnr,
   notdepottour
)
ELSE
INTO clsc_ww_hermes_notdepotsta
(
   dwh_cr_load_id,
   dwh_id_sc_ww_land,
   plzvon,
   plzbis,
   notdepotnr,
   notdepotname,
   landnr,
   notdepottour
)
SELECT
   dwh_cr_load_id,
   sc_ww_land.dwh_id AS dwh_id_sc_ww_land,
   plzvon,
   plzbis,
   notdepotnr,
   notdepotname,
   a.landnr,
   notdepottour
FROM clsc_ww_hermes_notdepotsta_1 a
  LEFT OUTER JOIN (SELECT K1.dwh_id, V1.landnr 
                    FROM sc_ww_land K1 JOIN sc_ww_land_ver V1 
                    ON (K1.dwh_id = V1.dwh_id_head AND &termin BETWEEN V1.dwh_valid_from AND V1.dwh_valid_to)) sc_ww_land
      ON (a.landnr = sc_ww_land.landnr)
;
  
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  5.6 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_hermes_notdepotsta');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_hermes_notdepotsta_e');



PROMPT =========================================================================
PROMPT
PROMPT 6. Source Core-Ladung
PROMPT Endtabelle: sc_ww_etber / sc_ww_etber_ver
PROMPT
PROMPT =========================================================================
 
 
 
PROMPT ===========================================
PROMPT  6.1 Cleansing Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clsc_ww_etber;
TRUNCATE TABLE clsc_ww_etber_1;
TRUNCATE TABLE clsc_ww_etber_d;
 
 
 
PROMPT ===========================================
PROMPT  6.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_etber_1
(
   dwh_cr_load_id,
   saison,
   etber,
   etberbez,
   einkfr,
   einkfr_tel,
   substitut,
   substitut_tel,
   einkleitnr,
   beschleitnr,
   disponent_1,
   disponent_1_tel,
   disponent_2,
   disponent_2_tel,
   etdirnr,
   id,
   kst,
   wagrpsortimentideins,
   wagrpsortimentidzwei,
   typ,
   benutzeriderri,
   erridat,
   benutzeridaend,
   aenddat,
   vertrgebietdefault
)
VALUES
(
   &gbvid,
   saison,
   etber,
   etberbez,
   einkfr,
   einkfr_tel,
   substitut,
   substitut_tel,
   einkleitnr,
   beschleitnr,
   disponent_1,
   disponent_1_tel,
   disponent_2,
   disponent_2_tel,
   etdirnr,
   id,
   kst,
   wagrpsortimentideins,
   wagrpsortimentidzwei,
   typ,
   benutzeriderri,
   erridat,
   benutzeridaend,
   aenddat,
   vertrgebietdefault
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_etber_d
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
   etberbez,
   einkfr,
   einkfr_tel,
   substitut,
   substitut_tel,
   einkleitnr,
   beschleitnr,
   disponent_1,
   disponent_1_tel,
   disponent_2,
   disponent_2_tel,
   etdirnr,
   id,
   kst,
   wagrpsortimentideins,
   wagrpsortimentidzwei,
   typ,
   benutzeriderri,
   erridat,
   benutzeridaend,
   aenddat,
   vertrgebietdefault
FROM st_ww_etber_b
WHERE dwh_processdate = &termin;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  6.3 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_etber_1');
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_etber_d');
 
 
 
PROMPT ===========================================
PROMPT  6.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING ('clsc_ww_etber', 'id', &gbvid);
 
 
/* Referenzauflösung zu Benutzer wird zu einem späteren Zeitpunkt nachgezogen
die Spalten für Benutzer sind aktuell noch nicht gepflegt
*/
PROMPT ===========================================
PROMPT  6.5 Einspielen in die letzte SC-Tabelle mit Referenzauflösung
PROMPT ===========================================
 
INSERT /*+ APPEND */ FIRST
WHEN (dwh_id_sc_ww_eksaison IS NULL 
   OR dwh_id_sc_ww_einkleit IS NULL
   OR dwh_id_sc_ww_et_direktor IS NULL
) THEN
INTO clsc_ww_etber_e
(
   dwh_cr_load_id,
   dwh_up_load_id,
   dwh_id_sc_ww_eksaison,
   dwh_id_sc_ww_einkleit,
   dwh_id_sc_ww_et_direktor,
   saison,
   etber,
   etberbez,
   einkfr,
   einkfr_tel,
   substitut,
   substitut_tel,
   einkleitnr,
   beschleitnr,
   disponent_1,
   disponent_1_tel,
   disponent_2,
   disponent_2_tel,
   etdirnr,
   id,
   kst,
   wagrpsortimentideins,
   wagrpsortimentidzwei,
   typ,
   benutzeriderri,
   erridat,
   benutzeridaend,
   aenddat,
   vertrgebietdefault
)
VALUES
(
   dwh_cr_load_id,
   &gbvid,
   dwh_id_sc_ww_eksaison,
   dwh_id_sc_ww_einkleit,
   dwh_id_sc_ww_et_direktor,
   saison,
   etber,
   etberbez,
   einkfr,
   einkfr_tel,
   substitut,
   substitut_tel,
   einkleitnr,
   beschleitnr,
   disponent_1,
   disponent_1_tel,
   disponent_2,
   disponent_2_tel,
   etdirnr,
   id,
   kst,
   wagrpsortimentideins,
   wagrpsortimentidzwei,
   typ,
   benutzeriderri,
   erridat,
   benutzeridaend,
   aenddat,
   vertrgebietdefault
)
ELSE
INTO clsc_ww_etber
(
   dwh_cr_load_id,
   dwh_id_sc_ww_eksaison,
   dwh_id_sc_ww_einkleit,
   dwh_id_sc_ww_et_direktor,
   saison,
   etber,
   etberbez,
   einkfr,
   einkfr_tel,
   substitut,
   substitut_tel,
   einkleitnr,
   beschleitnr,
   disponent_1,
   disponent_1_tel,
   disponent_2,
   disponent_2_tel,
   etdirnr,
   id,
   kst,
   wagrpsortimentideins,
   wagrpsortimentidzwei,
   typ,
   benutzeriderri,
   erridat,
   benutzeridaend,
   aenddat,
   vertrgebietdefault
)
SELECT
   a.dwh_cr_load_id,
   sc_ww_eksaison.dwh_id AS dwh_id_sc_ww_eksaison,
   sc_ww_einkleit.dwh_id AS dwh_id_sc_ww_einkleit,
   sc_ww_et_direktor.dwh_id AS dwh_id_sc_ww_et_direktor,
   a.saison AS saison,
   a.etber AS etber,
   a.etberbez AS etberbez,
   a.einkfr AS einkfr,
   a.einkfr_tel AS einkfr_tel,
   a.substitut AS substitut,
   a.substitut_tel AS substitut_tel,
   a.einkleitnr AS einkleitnr,
   a.beschleitnr AS beschleitnr,
   a.disponent_1 AS disponent_1,
   a.disponent_1_tel AS disponent_1_tel,
   a.disponent_2 AS disponent_2,
   a.disponent_2_tel AS disponent_2_tel,
   a.etdirnr AS etdirnr,
   a.id AS id,
   a.kst AS kst,
   a.wagrpsortimentideins AS wagrpsortimentideins,
   a.wagrpsortimentidzwei AS wagrpsortimentidzwei,
   a.typ AS typ,
   a.benutzeriderri AS benutzeriderri,
   a.erridat AS erridat,
   a.benutzeridaend AS benutzeridaend,
   a.aenddat AS aenddat,
   a.vertrgebietdefault AS vertrgebietdefault
FROM clsc_ww_etber_1 a
  LEFT OUTER JOIN (SELECT sc_ww_eksaison.dwh_id, sc_ww_eksaison.wert FROM sc_ww_eksaison) sc_ww_eksaison
      ON (a.saison = sc_ww_eksaison.wert)
  LEFT OUTER JOIN (SELECT sc_ww_einkleit.dwh_id, sc_ww_einkleit.saison, sc_ww_einkleit.einkleitnr FROM sc_ww_einkleit) sc_ww_einkleit
      ON (CASE WHEN a.einkleitnr IS NULL OR a.einkleitnr = 0 THEN -3 ELSE a.saison END = sc_ww_einkleit.saison AND CASE WHEN a.einkleitnr IS NULL OR a.einkleitnr = 0 THEN -3 ELSE a.einkleitnr END = sc_ww_einkleit.einkleitnr)
  LEFT OUTER JOIN (SELECT sc_ww_et_direktor.dwh_id, sc_ww_et_direktor.saison, sc_ww_et_direktor.etdirnr FROM sc_ww_et_direktor) sc_ww_et_direktor
      ON (CASE WHEN a.etdirnr IS NULL THEN -3 ELSE a.saison END = sc_ww_et_direktor.saison AND COALESCE(a.etdirnr, '$') = sc_ww_et_direktor.etdirnr)
;
 
COMMIT;


 
PROMPT ===========================================
PROMPT  6.6 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_etber');
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_etber_e');