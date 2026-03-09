/*******************************************************************************

Job:                  sc_ww_referenzladung_1
Beschreibung:         Job lädt Referenzen. Verwendete Referenzen im nDWH werden 
                      über die Job's sc_ww_referenzladung_1, sc_ww_referenzladung_2, 
                      sc_ww_referenzladung_3, sc_ww_referenzladung_4,
                      sc_ww_referenzladung_5 und sc_ww_referenzladung_6 geladen.
                      Alle sonstigen Referenzen werden über den Job sc_ww_referenzladung_sonst 
                      geladen, solange, bis sie in einer neuen Ladestrecke verwendet werden.
          
Erstellt am:          07.06.2016
Erstellt von:         stegrs       
Ansprechpartner:      stegrs, joeabd
Ansprechpartner-IT: -

verwendete Tabellen:  st_ww_sprache_b  
                      st_ww_bestweg_b
                      st_ww_werbmit_b
                      st_ww_zahlwunsch_b
                      st_ww_nltyp_b
                      st_ww_telemkeinw_b
                      st_ww_zahlmethode_b
                      st_ww_wunschkz_b
                      st_ww_beschaeftigung_b
                      st_ww_verswunsch_b
                      st_ww_bonisperr_b
                      st_ww_nlabonnentstatus_b
                      st_ww_nladressherkunft_b
                      st_ww_bonikl_b
                      st_ww_anwkz_b
                      st_ww_mahnstrang_b
                      st_ww_kdsperr_b
                      st_ww_adrhdl_b
                      st_ww_mahneb_b
                      st_ww_kdartgrp_b
                      st_ww_personal_b
                      st_ww_waehrung_b
                      st_ww_saison_b
                      st_ww_bestandsfirma_b
                      st_ww_crssperrkz_b
                      st_ww_prozess_b
                      st_ww_fgtyp_b
                      st_ww_sinnbestmenge_b
                      st_ww_verw_kz_b
                      st_ww_merkmalklasse_b
                      st_ww_lieferwunsch_b
                      st_ww_marktkzgeschlecht_b
                      st_ww_marktkzalter_b
                      st_ww_artnr_verwzweck_b
                      st_ww_artnr_verwzwecknum_b
                      st_ww_marktkz_verd_b
                      st_ww_anrede_b
                      st_ww_verskostfreigrund_b
                      st_ww_versart_b
                      st_ww_verw_bereich_b
                      st_ww_kontosperre_b
                      st_ww_liinftele_b
                      st_ww_ret_grund_b
                      st_ww_faktura_kalender_b
                      st_ww_verpackungstyp_verw_b
                      st_ww_kdinformationart_b
                      st_ww_ststeuerungskz_b
                      st_ww_einkleit_b
                      st_ww_retruecklversfirma_b
            
Endtabellen:          sc_ww_sprache / sc_ww_sprache_ver
                      sc_ww_bestweg / sc_ww_bestweg_ver
                      sc_ww_werbmit / sc_ww_werbmit_ver
                      sc_ww_zahlwunsch / sc_ww_zahlwunsch_ver
                      sc_ww_nltyp / sc_ww_nltyp_ver
                      sc_ww_telemkeinw / sc_ww_telemkeinw_ver
                      sc_ww_zahlmethode / sc_ww_zahlmethode_ver
                      sc_ww_wunschkz / sc_ww_wunschkz_ver
                      sc_ww_beschaeftigung / sc_ww_beschaeftigung_ver
                      sc_ww_verswunsch / sc_ww_verswunsch_ver
                      sc_ww_bonisperr / sc_ww_bonisperr_ver
                      sc_ww_nlabonnentstatus / sc_ww_nlabonnentstatus_ver
                      sc_ww_nladressherkunft / sc_ww_nladressherkunft_ver
                      sc_ww_bonikl / sc_ww_bonikl_ver
                      sc_ww_anwkz / sc_ww_anwkz_ver
                      sc_ww_mahnstrang / sc_ww_mahnstrang_ver
                      sc_ww_kdsperr / sc_ww_kdsperr_ver
                      sc_ww_adrhdl / sc_ww_adrhdl_ver
                      sc_ww_mahneb / sc_ww_mahneb_ver
                      sc_ww_kdartgrp / sc_ww_kdartgrp_ver
                      sc_ww_personal / sc_ww_personal_ver
                      sc_ww_waehrung / sc_ww_waehrung_ver
                      sc_ww_saison / sc_ww_saison_ver
                      sc_ww_bestandsfirma / sc_ww_bestandsfirma_ver
                      sc_ww_crssperrkz / sc_ww_crssperrkz_ver
                      sc_ww_prozess / sc_ww_prozess_ver
                      sc_ww_fgtyp / sc_ww_fgtyp_ver
                      sc_ww_sinnbestmenge / sc_ww_sinnbestmenge_ver
                      sc_ww_verw_kz / sc_ww_verw_kz_ver
                      sc_ww_merkmalklasse / sc_ww_merkmalklasse_ver
                      sc_ww_lieferwunsch / sc_ww_lieferwunsch_ver
                      sc_ww_marktkzgeschlecht / sc_ww_marktkzgeschlecht_ver
                      sc_ww_marktkzalter / sc_ww_marktkzalter_ver
                      sc_ww_artnr_verwzweck / sc_ww_artnr_verwzweck_ver
                      sc_ww_artnr_verwzwecknum / sc_ww_artnr_verwzwecknum_ver
                      sc_ww_marktkz_verd / sc_ww_marktkz_verd_ver
                      sc_ww_anrede / sc_ww_anrede_ver
                      sc_ww_verskostfreigrund / sc_ww_verskostfreigrund_ver
                      sc_ww_versart / sc_ww_versart_ver
                      sc_ww_verw_bereich / sc_ww_verw_bereich_ver
                      sc_ww_kontosperre / sc_ww_kontosperre_ver
                      sc_ww_liinftele / sc_ww_liinftele_ver
                      sc_ww_ret_grund / sc_ww_ret_grund_ver
                      sc_ww_faktura_kalender / sc_ww_faktura_kalender_ver
                      sc_ww_verpackungstyp_verw / sc_ww_verpackungstyp_verw_ver
                      sc_ww_kdinformationart / sc_ww_kdinformationart_ver
                      sc_ww_ststeuerungskz / sc_ww_ststeuerungskz_ver
                      sc_ww_einkleit / sc_ww_einkleit_ver
                      sc_ww_retruecklversfirma / sc_ww_retruecklversfirma_ver

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

geändert am:          2016-06-23
geändert von:         stegrs
Änderungen:           ##.5 Umzug auf Produktivsystem UDWH

geändert am:          2016-08-25
geändert von:         stegrs
Änderungen:           ##.6 Tabelle WAEHRUNG hinzugefügt; Umzug von LAND in sc_ww_referenzladung_2

geändert am:          2016-09-20
geändert von:         stegrs
Änderungen:           ##.7 Tabelle ZAHLMETHODE um Spalte KDBUCH_KDJKDKTOSEITEID erweitert

geändert am:          2016-09-22
geändert von:         stegrs
Änderungen:           ##.8 Tabelle SPRACHE hinzugefügt; Umzug von PERSANREDE in sc_ww_referenzladung_2

geändert am:          2016-09-23
geändert von:         stegrs
Änderungen:           ##.9 Tabelle SAISON hinzugefügt

geändert am:          2016-10-10
geändert von:         stegrs
Änderungen:           ##.10 Tabelle BESTANDSFIRMA hinzugefügt

geändert am:          2016-10-11
geändert von:         stegrs+ marsil
Änderungen:           ##.11 Tabelle CRSSPERRKZ hinzugefügt

geändert am:          2016-10-13
geändert von:         stegrs
Änderungen:           ##.12 Tabelle PROZESS hinzugefügt (im Stage seit 22.09. und im SC separat nachgeladen)

geändert am:          2016-10-24
geändert von:         stegrs, jockoe
Änderungen:           ##.13 Uhrzeit von 22:05 auf 00:00 verlegt

geändert am:          2016-11-07
geändert von:         stegrs
Änderungen:           ##.14 Tabelle FG hinzugefügt

geändert am:          2016-11-24
geändert von:         stegrs
Änderungen:           ##.15 Tabelle SINNBESTMENGE hinzugefügt

geändert am:          2016-11-29
geändert von:         stegrs
Änderungen:           ##.16 Tabelle VERW_KZ hinzugefügt

geändert am:          2016-12-06
geändert von:         jockoe
Änderungen:           ##.17 Tabelle LIEFERWUNSCH hinzugefügt

geändert am:          2016-12-12
geändert von:         stegrs
Änderungen:           ##.18 Tabelle ARTGRP hinzugefügt ab 01.10.2016 Daten vorhanden und in separatem Job nachgeladen

geändert am:          2016-12-13
geändert von:         joeabd
Änderungen:           ##.19 Tabellen MARKTKZGESCHLECHT und MARKTKZALTER hinzugefügt

geändert am:          2016-12-13
geändert von:         stegrs
Änderungen:           ##.20 Tabelle MERKMALKLASSE hinzugefügt ab 01.10.2016 Daten vorhanden und in separatem Job nachgeladen

geändert am:          2017-01-18
geändert von:         stegrs
Änderungen:           ##.21 Tabellen ARTNR_VERWZWECK, ARTNR_VERWZWECKNUM hinzugefügt 
                      und Tabelle VERTRGEBIET in sc_ww_referenzladung_3 umgezogen
                      
geändert am:          2017-01-18
geändert von:         stegrs
Änderungen:           ##.22 Tabelle ARTGRP in sc_ww_referenzladung_4 umgezogen (falsch in _1)

geändert am:          2017-01-20
geändert von:         joeabd
Änderungen:           ##.23 Abfrage im Abschluss-Skript auf clsc_ww_vertrgebiet entfernt

geändert am:          2017-01-24
geändert von:         stegrs
Änderungen:           ##.24 Tabelle MARKTKZ_VERD hinzugefügt

geändert am:          2017-02-07
geändert von:         stegrs
Änderungen:           ##.25 Tabelle ZAHLWUNSCH um Spalten ergänzt

geändert am:          2017-02-08
geändert von:         stegrs
Änderungen:           ##.26 Tabelle VERSWUNSCH, BENUTZER, WAEHRUNG um Spalten ergänzt

geändert am:          2017-02-09
geändert von:         stegrs
Änderungen:           ##.27 Tabelle PROZESS um Spalten ergänzt

geändert am:          2017-02-13
geändert von:         stegrs
Änderungen:           ##.28 Tabelle VERSKOSTFREIGRUND hinzugefügt

geändert am:          2017-05-04
geändert von:         stegrs
Änderungen:           ##.29 Tabelle VERSART hinzugefügt

geändert am:          2017-05-10
geändert von:         stegrs
Änderungen:           ##.30 Tabelle VERW_BEREICH hinzugefügt

geändert am:          2017-09-11
geändert von:         stegrs
Änderungen:           ##.31 Tabelle VERSKOSTFREIGRUND um Spalten erweitert

geändert am:          2017-09-18
geändert von:         stegrs
Änderungen:           ##.32 Tabelle KONTOSPERRE hinzugefügt

geändert am:          2017-10-24
geändert von:         stegrs
Änderungen:           ##.33 Tabelle BENUTZER in sc_ww_referenzladung_2 umgezogen
                            Tabelle PERSONAL hinzugefügt

geändert am:          2017-10-26
geändert von:         stegrs
Änderungen:           ##.34 Tabelle LIINFTELE hinzugefügt

geändert am:          2017-12-21
geändert von:         stegrs
Änderungen:           ##.35 Tabelle RET_GRUND hinzugefügt

geändert am:          2018-01-15
geändert von:         stegrs
Änderungen:           ##.36 Tabelle FAKTURA_KALENDER hinzugefügt

geändert am:          2018-01-18
geändert von:         stegrs
Änderungen:           ##.37 Tabelle VERPACKUNGSTYP hinzugefügt

geändert am:          2018-02-13
geändert von:         stegrs
Änderungen:           ##.38 Tabelle VERPACKUNGSTYP in sc_ww_referenzladung_2 umgezogen
                            Tabelle VERPACKUNGSTYP_VERW hinzugefügt

geändert am:          2018-05-30
geändert von:         stegrs
Änderungen:           ##.39 Tabelle KDINFORMATIONART hinzugefügt

geändert am:          2018-06-21
geändert von:         stegrs
Änderungen:           ##.40 Tabelle STSTEUERUNGSKZ hinzugefügt

geändert am:          2018-07-11
geändert von:         stegrs
Änderungen:           ##.41 Tabelle EINKLEIT hinzugefügt

geändert am:          2018-10-24
geändert von:         stegrs
Änderungen:           ##.42 Tabelle FG in sc_ww_referenzladung_2 umgezogen
                            Tabelle FGTYP hinzugefügt

geändert am:          2018-11-14
geändert von:         stegrs
Änderungen:           ##.43 Tabelle ZAHLMETHODE um Spalten erweitert

geändert am:          2019-03-04
geändert von:         stegrs
Änderungen:           ##.44 Tabelle RETRUECKLVERSFIRMA hinzugefügt

geändert am:          17.12.2019
geändert von:         svehoc
Änderungen:           ##. 45 Umzug auf UDWH1

geändert am:          2021-07-12
geändert von:         Franklin Villasana
Änderungen:           ##.46 Added reference to CC_ZAHLMETHODE

geändert am:          2021-07-14
geändert von:         Jörg
Änderungen:           ##.47 Reverting changes made in ##.46

geändert am:          2025-04-03
geändert von:         Jörg
Änderungen:           ##.48 Add reference to cc_saison for sc_ww_saison
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
PROMPT Endtabelle: sc_ww_sprache / sc_ww_sprache_ver
PROMPT
PROMPT =========================================================================
 
 
 
PROMPT ===========================================
PROMPT  1.1 Cleansing Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clsc_ww_sprache;
TRUNCATE TABLE clsc_ww_sprache_1;
TRUNCATE TABLE clsc_ww_sprache_d;
 
 
 
PROMPT ===========================================
PROMPT  1.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_sprache_1
(
   dwh_cr_load_id,
   sprachenr,
   sprachekurzbez,
   sprachebez,
   id,
   isolanguagecode,
   isovariantcode,
   paulkz,
   fsvkz
)
VALUES
(
   &gbvid,
   sprachenr,
   sprachekurzbez,
   sprachebez,
   id,
   isolanguagecode,
   isovariantcode,
   paulkz,
   fsvkz
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_sprache_d
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
   sprachenr,
   sprachekurzbez,
   sprachebez,
   id,
   isolanguagecode,
   isovariantcode,
   paulkz,
   fsvkz
FROM st_ww_sprache_b
WHERE dwh_processdate = &termin;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  1.3 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_sprache_1');
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_sprache_d');
 
 
 
PROMPT ===========================================
PROMPT  1.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING ('clsc_ww_sprache', 'id', &gbvid);
 
 
 
PROMPT ===========================================
PROMPT  1.5 Einspielen in die letzte SC-Tabelle ohne Referenzauflösung
PROMPT ===========================================
 
INSERT /*+ APPEND */
INTO clsc_ww_sprache
(
   dwh_cr_load_id,
   sprachenr,
   sprachekurzbez,
   sprachebez,
   id,
   isolanguagecode,
   isovariantcode,
   paulkz,
   fsvkz
)
SELECT
   dwh_cr_load_id,
   sprachenr,
   sprachekurzbez,
   sprachebez,
   id,
   isolanguagecode,
   isovariantcode,
   paulkz,
   fsvkz
FROM clsc_ww_sprache_1;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  1.6 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_sprache');
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_sprache_e');



PROMPT =========================================================================
PROMPT
PROMPT 2. Source Core-Ladung
PROMPT Endtabelle: sc_ww_bestweg / sc_ww_bestweg_ver
PROMPT
PROMPT =========================================================================



PROMPT ===========================================
PROMPT 2.1 Cleansing Tabellen leeren
PROMPT ===========================================

TRUNCATE TABLE clsc_ww_bestweg;
TRUNCATE TABLE clsc_ww_bestweg_1;
TRUNCATE TABLE clsc_ww_bestweg_d;



PROMPT ===========================================
PROMPT  2.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_bestweg_1
(
   dwh_cr_load_id,
   id,
   bez,
   beschr,
   bestwegkz
)
VALUES
(
   &gbvid,
   id,
   bez,
   beschr,
   bestwegkz
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_bestweg_d
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
   bez,
   beschr,
   bestwegkz
FROM st_ww_bestweg_b
WHERE dwh_processdate = &termin;
 
COMMIT;



PROMPT ===========================================
PROMPT 2.3 Aktuelle Statistiken erstellen
PROMPT ===========================================

EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_bestweg_1');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_bestweg_d');



PROMPT ===========================================
PROMPT  2.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING('clsc_ww_bestweg', 'id', &gbvid);



PROMPT ===========================================
PROMPT  2.5 Einspielen in die letzte SC-Tabelle ohne Referenzauflösung
PROMPT ===========================================
 
INSERT /*+ APPEND */
INTO clsc_ww_bestweg
(
   dwh_cr_load_id,
   id,
   bez,
   beschr,
   bestwegkz
)
SELECT
   dwh_cr_load_id,
   id,
   bez,
   beschr,
   bestwegkz
FROM clsc_ww_bestweg_1;
 
COMMIT;



PROMPT ===========================================
PROMPT  2.6 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_bestweg');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_bestweg_e');



PROMPT =========================================================================
PROMPT
PROMPT 3. Source Core-Ladung
PROMPT Endtabelle: sc_ww_werbmit / sc_ww_werbmit_ver
PROMPT
PROMPT =========================================================================



PROMPT ===========================================
PROMPT 3.1 Cleansing Tabellen leeren
PROMPT ===========================================

TRUNCATE TABLE clsc_ww_werbmit;
TRUNCATE TABLE clsc_ww_werbmit_1;
TRUNCATE TABLE clsc_ww_werbmit_d;



PROMPT ===========================================
PROMPT  3.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_werbmit_1
(
   dwh_cr_load_id,
   werbmitkz,
   werbmitbez,
   id,
   bez,
   werbmit,
   letztaenddat
)
VALUES
(
   &gbvid,
   werbmitkz,
   werbmitbez,
   id,
   bez,
   werbmit,
   letztaenddat
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_werbmit_d
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
   werbmitkz,
   werbmitbez,
   id,
   bez,
   werbmit,
   letztaenddat
FROM st_ww_werbmit_b
WHERE dwh_processdate = &termin;
 
COMMIT;



PROMPT ===========================================
PROMPT 3.3 Aktuelle Statistiken erstellen
PROMPT ===========================================

EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_werbmit_1');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_werbmit_d');



PROMPT ===========================================
PROMPT  3.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING('clsc_ww_werbmit', 'id', &gbvid);



PROMPT ===========================================
PROMPT  3.5 Einspielen in die letzte SC-Tabelle ohne Referenzauflösung
PROMPT ===========================================
 
INSERT /*+ APPEND */
INTO clsc_ww_werbmit
(
   dwh_cr_load_id,
   werbmitkz,
   werbmitbez,
   id,
   bez,
   werbmit,
   letztaenddat
)
SELECT
   dwh_cr_load_id,
   werbmitkz,
   werbmitbez,
   id,
   bez,
   werbmit,
   letztaenddat
FROM clsc_ww_werbmit_1;
 
COMMIT;



PROMPT ===========================================
PROMPT  3.6 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_werbmit');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_werbmit_e');



PROMPT =========================================================================
PROMPT
PROMPT 4. Source Core-Ladung
PROMPT Endtabelle: sc_ww_zahlwunsch / sc_ww_zahlwunsch_ver
PROMPT
PROMPT =========================================================================



PROMPT ===========================================
PROMPT 4.1 Cleansing Tabellen leeren
PROMPT ===========================================

TRUNCATE TABLE clsc_ww_zahlwunsch;
TRUNCATE TABLE clsc_ww_zahlwunsch_1;
TRUNCATE TABLE clsc_ww_zahlwunsch_d;



PROMPT ===========================================
PROMPT  4.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_zahlwunsch_1
(
   dwh_cr_load_id,
   id,
   kz,
   bez,
   anzraten,
   valutakz
)
VALUES
(
   &gbvid,
   id,
   kz,
   bez,
   anzraten,
   valutakz
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_zahlwunsch_d
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
   kz,
   bez,
   anzraten,
   valutakz
FROM st_ww_zahlwunsch_b
WHERE dwh_processdate = &termin;
 
COMMIT;



PROMPT ===========================================
PROMPT 4.3 Aktuelle Statistiken erstellen
PROMPT ===========================================

EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_zahlwunsch_1');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_zahlwunsch_d');



PROMPT ===========================================
PROMPT  4.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING('clsc_ww_zahlwunsch', 'id', &gbvid);



PROMPT ===========================================
PROMPT  4.5 Einspielen in die letzte SC-Tabelle ohne Referenzauflösung
PROMPT ===========================================
 
INSERT /*+ APPEND */
INTO clsc_ww_zahlwunsch
(
   dwh_cr_load_id,
   id,
   kz,
   bez,
   anzraten,
   valutakz
)
SELECT
   dwh_cr_load_id,
   id,
   kz,
   bez,
   anzraten,
   valutakz
FROM clsc_ww_zahlwunsch_1;

COMMIT;



PROMPT ===========================================
PROMPT  4.6 Aktuelle Statistiken erstellen
PROMPT ===========================================

EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_zahlwunsch');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_zahlwunsch_e');



PROMPT =========================================================================
PROMPT
PROMPT 5. Source Core-Ladung
PROMPT Endtabelle: sc_ww_nltyp / sc_ww_nltyp_ver
PROMPT
PROMPT =========================================================================



PROMPT ===========================================
PROMPT 5.1 Cleansing Tabellen leeren
PROMPT ===========================================

TRUNCATE TABLE clsc_ww_nltyp;
TRUNCATE TABLE clsc_ww_nltyp_1;
TRUNCATE TABLE clsc_ww_nltyp_d;



PROMPT ===========================================
PROMPT  5.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_nltyp_1
(
   dwh_cr_load_id,
   id,
   bez
)
VALUES
(
   &gbvid,
   id,
   bez
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_nltyp_d
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
   bez
FROM st_ww_nltyp_b
WHERE dwh_processdate = &termin;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  5.3 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_nltyp_1');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_nltyp_d');
 
 
 
PROMPT ===========================================
PROMPT  5.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING('clsc_ww_nltyp', 'id', &gbvid);
 
 
 
PROMPT ===========================================
PROMPT  5.5 Einspielen in die letzte SC-Tabelle ohne Referenzauflösung
PROMPT ===========================================
 
INSERT /*+ APPEND */
INTO clsc_ww_nltyp
(
   dwh_cr_load_id,
   id,
   bez
)
SELECT
   dwh_cr_load_id,
   id,
   bez
FROM clsc_ww_nltyp_1;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  5.6 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_nltyp');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_nltyp_e');



PROMPT =========================================================================
PROMPT
PROMPT 6. Source Core-Ladung
PROMPT Endtabelle: sc_ww_telemkeinw / sc_ww_telemkeinw_ver
PROMPT
PROMPT =========================================================================



PROMPT ===========================================
PROMPT  6.1 Cleansing Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clsc_ww_telemkeinw;
TRUNCATE TABLE clsc_ww_telemkeinw_1;
TRUNCATE TABLE clsc_ww_telemkeinw_d;
 
 
 
PROMPT ===========================================
PROMPT  6.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_telemkeinw_1
(
   dwh_cr_load_id,
   id,
   telemkeinwkz,
   bez,
   beschr
)
VALUES
(
   &gbvid,
   id,
   telemkeinwkz,
   bez,
   beschr
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_telemkeinw_d
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
   telemkeinwkz,
   bez,
   beschr
FROM st_ww_telemkeinw_b
WHERE dwh_processdate = &termin;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  6.3 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_telemkeinw_1');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_telemkeinw_d');
 
 
 
PROMPT ===========================================
PROMPT  6.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING('clsc_ww_telemkeinw', 'id', &gbvid);
 
 
 
PROMPT ===========================================
PROMPT  6.5 Einspielen in die letzte SC-Tabelle ohne Referenzauflösung
PROMPT ===========================================
 
INSERT /*+ APPEND */
INTO clsc_ww_telemkeinw
(
   dwh_cr_load_id,
   id,
   telemkeinwkz,
   bez,
   beschr
)
SELECT
   dwh_cr_load_id,
   id,
   telemkeinwkz,
   bez,
   beschr
FROM clsc_ww_telemkeinw_1;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  6.6 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_telemkeinw');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_telemkeinw_e');



PROMPT =========================================================================
PROMPT
PROMPT 7. Source Core-Ladung
PROMPT Endtabelle: sc_ww_zahlmethode / sc_ww_zahlmethode_ver
PROMPT
PROMPT =========================================================================



PROMPT ===========================================
PROMPT  7.1 Cleansing Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clsc_ww_zahlmethode;
TRUNCATE TABLE clsc_ww_zahlmethode_1;
TRUNCATE TABLE clsc_ww_zahlmethode_d;
 
 
 
PROMPT ===========================================
PROMPT  7.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_zahlmethode_1
(
   dwh_cr_load_id,
   id,
   zahlmethodekz,
   bezeichnung,
   sicherzahlkz,
   kdbuch_kdjkdktoseiteid,
   ezvkz,
   kurzbez
)
VALUES
(
   &gbvid,
   id,
   zahlmethodekz,
   bezeichnung,
   sicherzahlkz,
   kdbuch_kdjkdktoseiteid,
   ezvkz,
   kurzbez
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_zahlmethode_d
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
   zahlmethodekz,
   bezeichnung,
   sicherzahlkz,
   kdbuch_kdjkdktoseiteid,
   ezvkz,
   kurzbez
FROM st_ww_zahlmethode_b
WHERE dwh_processdate = &termin;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  7.3 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_zahlmethode_1');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_zahlmethode_d');
 
 
 
PROMPT ===========================================
PROMPT  7.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING('clsc_ww_zahlmethode', 'id', &gbvid);
 
 

/* Auflösung zum KDBUCH-Datenmodell wird nicht vorgenommen*/
PROMPT ===========================================
PROMPT  7.5 Einspielen in die letzte SC-Tabelle mit Referenzauflösung
PROMPT ===========================================
 
INSERT /*+ APPEND */ FIRST
WHEN (dwh_id_sc_ww_ezvkz IS NULL /* OR
      dwh_id_cc_zahlwunsch IS NULL OR
      dwh_id_cc_zahlmethode IS NULL */
) THEN
INTO clsc_ww_zahlmethode_e
(
   dwh_cr_load_id,
   dwh_up_load_id,
   dwh_id_sc_ww_ezvkz,
 --  dwh_id_cc_zahlwunsch,
 --  dwh_id_cc_zahlmethode,
   id,
   zahlmethodekz,
   bezeichnung,
   sicherzahlkz,
   kdbuch_kdjkdktoseiteid,
   ezvkz,
   kurzbez
)
VALUES
(
   dwh_cr_load_id,
   &gbvid,
   dwh_id_sc_ww_ezvkz,
 --  dwh_id_cc_zahlwunsch,
 --  dwh_id_cc_zahlmethode,
   id,
   zahlmethodekz,
   bezeichnung,
   sicherzahlkz,
   kdbuch_kdjkdktoseiteid,
   ezvkz,
   kurzbez
)
ELSE
INTO clsc_ww_zahlmethode
(
   dwh_cr_load_id,
   dwh_id_sc_ww_ezvkz,
--   dwh_id_cc_zahlwunsch,
 --  dwh_id_cc_zahlmethode,
   id,
   zahlmethodekz,
   bezeichnung,
   sicherzahlkz,
   kdbuch_kdjkdktoseiteid,
   ezvkz,
   kurzbez
)
SELECT
   a.dwh_cr_load_id,
   sc_ww_ezvkz.dwh_id AS dwh_id_sc_ww_ezvkz,
 --  cc_zahlwunsch.dwh_id AS dwh_id_cc_zahlwunsch,
 --  coalesce(cc_zahlmethode.dwh_id,100388505175329) AS dwh_id_cc_zahlmethode,
   a.id,
   a.zahlmethodekz,
   a.bezeichnung,
   a.sicherzahlkz,
   a.kdbuch_kdjkdktoseiteid,
   a.ezvkz,
   a.kurzbez
FROM clsc_ww_zahlmethode_1 a
  LEFT OUTER JOIN (SELECT sc_ww_ezvkz.dwh_id, sc_ww_ezvkz.wert FROM sc_ww_ezvkz) sc_ww_ezvkz
      ON (a.ezvkz = sc_ww_ezvkz.wert) 
  --  LEFT OUTER JOIN (SELECT cc_zahlmethode.dwh_id, cc_zahlmethode.wert FROM cc_zahlmethode) cc_zahlmethode
  --    ON (a.zahlmethodekz = cc_zahlmethode.wert)
;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  7.6 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_zahlmethode');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_zahlmethode_e');



PROMPT =========================================================================
PROMPT
PROMPT 8. Source Core-Ladung
PROMPT Endtabelle: sc_ww_wunschkz / sc_ww_wunschkz_ver
PROMPT
PROMPT =========================================================================



PROMPT ===========================================
PROMPT  8.1 Cleansing Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clsc_ww_wunschkz;
TRUNCATE TABLE clsc_ww_wunschkz_1;
TRUNCATE TABLE clsc_ww_wunschkz_d;
 
 
 
PROMPT ===========================================
PROMPT  8.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_wunschkz_1
(
   dwh_cr_load_id,
   id,
   bez,
   wunschkz
)
VALUES
(
   &gbvid,
   id,
   bez,
   wunschkz
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_wunschkz_d
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
   bez,
   wunschkz
FROM st_ww_wunschkz_b
WHERE dwh_processdate = &termin;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  8.3 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_wunschkz_1');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_wunschkz_d');
 
 
 
PROMPT ===========================================
PROMPT  8.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING('clsc_ww_wunschkz', 'id', &gbvid);
 
 
 
PROMPT ===========================================
PROMPT  8.5 Einspielen in die letzte SC-Tabelle ohne Referenzauflösung
PROMPT ===========================================
 
INSERT /*+ APPEND */
INTO clsc_ww_wunschkz
(
   dwh_cr_load_id,
   id,
   bez,
   wunschkz
)
SELECT
   dwh_cr_load_id,
   id,
   bez,
   wunschkz
FROM clsc_ww_wunschkz_1;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  8.6 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_wunschkz');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_wunschkz_e');



PROMPT =========================================================================
PROMPT
PROMPT 9. Source Core-Ladung
PROMPT Endtabelle: sc_ww_beschaeftigung / sc_ww_beschaeftigung_ver
PROMPT
PROMPT =========================================================================



PROMPT ===========================================
PROMPT  9.1 Cleansing Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clsc_ww_beschaeftigung;
TRUNCATE TABLE clsc_ww_beschaeftigung_1;
TRUNCATE TABLE clsc_ww_beschaeftigung_d;
 
 
 
PROMPT ===========================================
PROMPT  9.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_beschaeftigung_1
(
   dwh_cr_load_id,
   id,
   kurzbez,
   bez,
   letztaenddat,
   beschkz
)
VALUES
(
   &gbvid,
   id,
   kurzbez,
   bez,
   letztaenddat,
   beschkz
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_beschaeftigung_d
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
   kurzbez,
   bez,
   letztaenddat,
   beschkz
FROM st_ww_beschaeftigung_b
WHERE dwh_processdate = &termin;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  9.3 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_beschaeftigung_1');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_beschaeftigung_d');
 
 
 
PROMPT ===========================================
PROMPT  9.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING('clsc_ww_beschaeftigung', 'id', &gbvid);
 
 
 
PROMPT ===========================================
PROMPT  9.5 Einspielen in die letzte SC-Tabelle ohne Referenzauflösung
PROMPT ===========================================
 
INSERT /*+ APPEND */
INTO clsc_ww_beschaeftigung
(
   dwh_cr_load_id,
   id,
   kurzbez,
   bez,
   letztaenddat,
   beschkz
)
SELECT
   dwh_cr_load_id,
   id,
   kurzbez,
   bez,
   letztaenddat,
   beschkz
FROM clsc_ww_beschaeftigung_1;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  9.6 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_beschaeftigung');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_beschaeftigung_e');



PROMPT =========================================================================
PROMPT
PROMPT 10. Source Core-Ladung
PROMPT Endtabelle: sc_ww_verswunsch / sc_ww_verswunsch_ver
PROMPT
PROMPT =========================================================================



PROMPT ===========================================
PROMPT  10.1 Cleansing Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clsc_ww_verswunsch;
TRUNCATE TABLE clsc_ww_verswunsch_1;
TRUNCATE TABLE clsc_ww_verswunsch_d;
 
 
 
PROMPT ===========================================
PROMPT  10.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_verswunsch_1
(
   dwh_cr_load_id,
   id,
   bez,
   letztaenddat,
   verswunschkz,
   verstypkz
)
VALUES
(
   &gbvid,
   id,
   bez,
   letztaenddat,
   verswunschkz,
   verstypkz
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_verswunsch_d
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
   bez,
   letztaenddat,
   verswunschkz,
   verstypkz
FROM st_ww_verswunsch_b
WHERE dwh_processdate = &termin;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  10.3 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_verswunsch_1');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_verswunsch_d');
 
 
 
PROMPT ===========================================
PROMPT  10.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING('clsc_ww_verswunsch', 'id', &gbvid);
 
 
 
PROMPT ===========================================
PROMPT  10.5 Einspielen in die letzte SC-Tabelle ohne Referenzauflösung
PROMPT ===========================================
 
INSERT /*+ APPEND */
INTO clsc_ww_verswunsch
(
   dwh_cr_load_id,
   id,
   bez,
   letztaenddat,
   verswunschkz,
   verstypkz
)
SELECT
   dwh_cr_load_id,
   id,
   bez,
   letztaenddat,
   verswunschkz,
   verstypkz
FROM clsc_ww_verswunsch_1;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  10.6 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_verswunsch');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_verswunsch_e');



PROMPT =========================================================================
PROMPT
PROMPT 11. Source Core-Ladung
PROMPT Endtabelle: sc_ww_bonisperr / sc_ww_bonisperr_ver
PROMPT
PROMPT =========================================================================



PROMPT ===========================================
PROMPT  11.1 Cleansing Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clsc_ww_bonisperr;
TRUNCATE TABLE clsc_ww_bonisperr_1;
TRUNCATE TABLE clsc_ww_bonisperr_d;
 
 
 
PROMPT ===========================================
PROMPT  11.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_bonisperr_1
(
   dwh_cr_load_id,
   bonisperrkz,
   bonisperrbez,
   id,
   letztaenddat,
   kurzbez
)
VALUES
(
   &gbvid,
   bonisperrkz,
   bonisperrbez,
   id,
   letztaenddat,
   kurzbez
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_bonisperr_d
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
   bonisperrkz,
   bonisperrbez,
   id,
   letztaenddat,
   kurzbez
FROM st_ww_bonisperr_b
WHERE dwh_processdate = &termin;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  11.3 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_bonisperr_1');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_bonisperr_d');
 
 
 
PROMPT ===========================================
PROMPT  11.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING('clsc_ww_bonisperr', 'id', &gbvid);
 
 
 
PROMPT ===========================================
PROMPT  11.5 Einspielen in die letzte SC-Tabelle ohne Referenzauflösung
PROMPT ===========================================
 
INSERT /*+ APPEND */
INTO clsc_ww_bonisperr
(
   dwh_cr_load_id,
   bonisperrkz,
   bonisperrbez,
   id,
   letztaenddat,
   kurzbez
)
SELECT
   dwh_cr_load_id,
   bonisperrkz,
   bonisperrbez,
   id,
   letztaenddat,
   kurzbez
FROM clsc_ww_bonisperr_1;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  11.6 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_bonisperr');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_bonisperr_e');



PROMPT =========================================================================
PROMPT
PROMPT 12. Source Core-Ladung
PROMPT Endtabelle: sc_ww_nlabonnentstatus / sc_ww_nlabonnentstatus_ver
PROMPT
PROMPT =========================================================================



PROMPT ===========================================
PROMPT  12.1 Cleansing Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clsc_ww_nlabonnentstatus;
TRUNCATE TABLE clsc_ww_nlabonnentstatus_1;
TRUNCATE TABLE clsc_ww_nlabonnentstatus_d;
 
 
 
PROMPT ===========================================
PROMPT  12.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_nlabonnentstatus_1
(
   dwh_cr_load_id,
   id,
   bez,
   abonnentstatuskz
)
VALUES
(
   &gbvid,
   id,
   bez,
   abonnentstatuskz
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_nlabonnentstatus_d
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
   bez,
   abonnentstatuskz
FROM st_ww_nlabonnentstatus_b
WHERE dwh_processdate = &termin;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  12.3 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_nlabonnentstatus_1');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_nlabonnentstatus_d');
 
 
 
PROMPT ===========================================
PROMPT  12.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING('clsc_ww_nlabonnentstatus', 'id', &gbvid);
 
 
 
PROMPT ===========================================
PROMPT  12.5 Einspielen in die letzte SC-Tabelle ohne Referenzauflösung
PROMPT ===========================================
 
INSERT /*+ APPEND */
INTO clsc_ww_nlabonnentstatus
(
   dwh_cr_load_id,
   id,
   bez,
   abonnentstatuskz
)
SELECT
   dwh_cr_load_id,
   id,
   bez,
   abonnentstatuskz
FROM clsc_ww_nlabonnentstatus_1;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  12.6 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_nlabonnentstatus');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_nlabonnentstatus_e');



PROMPT =========================================================================
PROMPT
PROMPT 13. Source Core-Ladung
PROMPT Endtabelle: sc_ww_nladressherkunft / sc_ww_nladressherkunft_ver
PROMPT
PROMPT =========================================================================



PROMPT ===========================================
PROMPT  13.1 Cleansing Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clsc_ww_nladressherkunft;
TRUNCATE TABLE clsc_ww_nladressherkunft_1;
TRUNCATE TABLE clsc_ww_nladressherkunft_d;
 
 
 
PROMPT ===========================================
PROMPT  13.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_nladressherkunft_1
(
   dwh_cr_load_id,
   id,
   bez,
   adressherkunftkz
)
VALUES
(
   &gbvid,
   id,
   bez,
   adressherkunftkz
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_nladressherkunft_d
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
   bez,
   adressherkunftkz
FROM st_ww_nladressherkunft_b
WHERE dwh_processdate = &termin;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  13.3 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_nladressherkunft_1');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_nladressherkunft_d');
 
 
 
PROMPT ===========================================
PROMPT  13.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING('clsc_ww_nladressherkunft', 'id', &gbvid);
 
 
 
PROMPT ===========================================
PROMPT  13.5 Einspielen in die letzte SC-Tabelle ohne Referenzauflösung
PROMPT ===========================================
 
INSERT /*+ APPEND */
INTO clsc_ww_nladressherkunft
(
   dwh_cr_load_id,
   id,
   bez,
   adressherkunftkz
)
SELECT
   dwh_cr_load_id,
   id,
   bez,
   adressherkunftkz
FROM clsc_ww_nladressherkunft_1;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  13.6 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_nladressherkunft');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_nladressherkunft_e');



PROMPT =========================================================================
PROMPT
PROMPT 14. Source Core-Ladung
PROMPT Endtabelle: sc_ww_bonikl / sc_ww_bonikl_ver
PROMPT
PROMPT =========================================================================



PROMPT ===========================================
PROMPT  14.1 Cleansing Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clsc_ww_bonikl;
TRUNCATE TABLE clsc_ww_bonikl_1;
TRUNCATE TABLE clsc_ww_bonikl_d;
 
 
 
PROMPT ===========================================
PROMPT  14.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_bonikl_1
(
   dwh_cr_load_id,
   id,
   bez,
   letztaenddat,
   bonikl
)
VALUES
(
   &gbvid,
   id,
   bez,
   letztaenddat,
   bonikl
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_bonikl_d
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
   bez,
   letztaenddat,
   bonikl
FROM st_ww_bonikl_b
WHERE dwh_processdate = &termin;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  14.3 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_bonikl_1');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_bonikl_d');
 
 
 
PROMPT ===========================================
PROMPT  14.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING('clsc_ww_bonikl', 'id', &gbvid);
 
 
 
PROMPT ===========================================
PROMPT  14.5 Einspielen in die letzte SC-Tabelle ohne Referenzauflösung
PROMPT ===========================================
 
INSERT /*+ APPEND */
INTO clsc_ww_bonikl
(
   dwh_cr_load_id,
   id,
   bez,
   letztaenddat,
   bonikl
)
SELECT
   dwh_cr_load_id,
   id,
   bez,
   letztaenddat,
   bonikl
FROM clsc_ww_bonikl_1;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  14.6 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_bonikl');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_bonikl_e');



PROMPT =========================================================================
PROMPT
PROMPT 15. Source Core-Ladung
PROMPT Endtabelle: sc_ww_anwkz / sc_ww_anwkz_ver
PROMPT
PROMPT =========================================================================



PROMPT ===========================================
PROMPT  15.1 Cleansing Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clsc_ww_anwkz;
TRUNCATE TABLE clsc_ww_anwkz_1;
TRUNCATE TABLE clsc_ww_anwkz_d;
 
 
 
PROMPT ===========================================
PROMPT  15.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_anwkz_1
(
   dwh_cr_load_id,
   id,
   kz,
   anwendung
)
VALUES
(
   &gbvid,
   id,
   kz,
   anwendung
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_anwkz_d
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
   kz,
   anwendung
FROM st_ww_anwkz_b
WHERE dwh_processdate = &termin;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  15.3 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_anwkz_1');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_anwkz_d');
 
 
 
PROMPT ===========================================
PROMPT  15.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING('clsc_ww_anwkz', 'id', &gbvid);
 
 
 
PROMPT ===========================================
PROMPT  15.5 Einspielen in die letzte SC-Tabelle ohne Referenzauflösung
PROMPT ===========================================
 
INSERT /*+ APPEND */
INTO clsc_ww_anwkz
(
   dwh_cr_load_id,
   id,
   kz,
   anwendung
)
SELECT
   dwh_cr_load_id,
   id,
   kz,
   anwendung
FROM clsc_ww_anwkz_1;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  15.6 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_anwkz');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_anwkz_e');



PROMPT =========================================================================
PROMPT
PROMPT 16. Source Core-Ladung
PROMPT Endtabelle: sc_ww_mahnstrang / sc_ww_mahnstrang_ver
PROMPT
PROMPT =========================================================================



PROMPT ===========================================
PROMPT  16.1 Cleansing Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clsc_ww_mahnstrang;
TRUNCATE TABLE clsc_ww_mahnstrang_1;
TRUNCATE TABLE clsc_ww_mahnstrang_d;
 
 
 
PROMPT ===========================================
PROMPT  16.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_mahnstrang_1
(
   dwh_cr_load_id,
   id,
   bez,
   letztaenddat,
   mahnstrang
)
VALUES
(
   &gbvid,
   id,
   bez,
   letztaenddat,
   mahnstrang
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_mahnstrang_d
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
   bez,
   letztaenddat,
   mahnstrang
FROM st_ww_mahnstrang_b
WHERE dwh_processdate = &termin;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  16.3 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_mahnstrang_1');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_mahnstrang_d');
 
 
 
PROMPT ===========================================
PROMPT  16.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING('clsc_ww_mahnstrang', 'id', &gbvid);
 
 
 
PROMPT ===========================================
PROMPT  16.5 Einspielen in die letzte SC-Tabelle ohne Referenzauflösung
PROMPT ===========================================
 
INSERT /*+ APPEND */
INTO clsc_ww_mahnstrang
(
   dwh_cr_load_id,
   id,
   bez,
   letztaenddat,
   mahnstrang
)
SELECT
   dwh_cr_load_id,
   id,
   bez,
   letztaenddat,
   mahnstrang
FROM clsc_ww_mahnstrang_1;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  16.6 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_mahnstrang');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_mahnstrang_e');



PROMPT =========================================================================
PROMPT
PROMPT 17. Source Core-Ladung
PROMPT Endtabelle: sc_ww_kdsperr / sc_ww_kdsperr_ver
PROMPT
PROMPT =========================================================================



PROMPT ===========================================
PROMPT  17.1 Cleansing Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clsc_ww_kdsperr;
TRUNCATE TABLE clsc_ww_kdsperr_1;
TRUNCATE TABLE clsc_ww_kdsperr_d;
 
 
 
PROMPT ===========================================
PROMPT  17.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_kdsperr_1
(
   dwh_cr_load_id,
   kdsperrkz,
   kdsperrbez,
   id,
   kurzbez,
   letztaenddat
)
VALUES
(
   &gbvid,
   kdsperrkz,
   kdsperrbez,
   id,
   kurzbez,
   letztaenddat
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_kdsperr_d
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
   kdsperrkz,
   kdsperrbez,
   id,
   kurzbez,
   letztaenddat
FROM st_ww_kdsperr_b
WHERE dwh_processdate = &termin;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  17.3 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_kdsperr_1');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_kdsperr_d');
 
 
 
PROMPT ===========================================
PROMPT  17.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING('clsc_ww_kdsperr', 'id', &gbvid);
 
 
 
PROMPT ===========================================
PROMPT  17.5 Einspielen in die letzte SC-Tabelle ohne Referenzauflösung
PROMPT ===========================================
 
INSERT /*+ APPEND */
INTO clsc_ww_kdsperr
(
   dwh_cr_load_id,
   kdsperrkz,
   kdsperrbez,
   id,
   kurzbez,
   letztaenddat
)
SELECT
   dwh_cr_load_id,
   kdsperrkz,
   kdsperrbez,
   id,
   kurzbez,
   letztaenddat
FROM clsc_ww_kdsperr_1;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  17.6 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_kdsperr');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_kdsperr_e');



PROMPT =========================================================================
PROMPT
PROMPT 18. Source Core-Ladung
PROMPT Endtabelle: sc_ww_adrhdl / sc_ww_adrhdl_ver
PROMPT
PROMPT =========================================================================



PROMPT ===========================================
PROMPT  18.1 Cleansing Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clsc_ww_adrhdl;
TRUNCATE TABLE clsc_ww_adrhdl_1;
TRUNCATE TABLE clsc_ww_adrhdl_d;
 
 
 
PROMPT ===========================================
PROMPT  18.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_adrhdl_1
(
   dwh_cr_load_id,
   id,
   adrhdlkz,
   bez
)
VALUES
(
   &gbvid,
   id,
   adrhdlkz,
   bez
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_adrhdl_d
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
   adrhdlkz,
   bez
FROM st_ww_adrhdl_b
WHERE dwh_processdate = &termin;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  18.3 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_adrhdl_1');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_adrhdl_d');
 
 
 
PROMPT ===========================================
PROMPT  18.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING('clsc_ww_adrhdl', 'id', &gbvid);
 
 
 
PROMPT ===========================================
PROMPT  18.5 Einspielen in die letzte SC-Tabelle ohne Referenzauflösung
PROMPT ===========================================
 
INSERT /*+ APPEND */
INTO clsc_ww_adrhdl
(
   dwh_cr_load_id,
   id,
   adrhdlkz,
   bez
)
SELECT
   dwh_cr_load_id,
   id,
   adrhdlkz,
   bez
FROM clsc_ww_adrhdl_1;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  18.6 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_adrhdl');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_adrhdl_e');



PROMPT =========================================================================
PROMPT
PROMPT 19. Source Core-Ladung
PROMPT Endtabelle: sc_ww_mahneb / sc_ww_mahneb_ver
PROMPT
PROMPT =========================================================================



PROMPT ===========================================
PROMPT  19.1 Cleansing Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clsc_ww_mahneb;
TRUNCATE TABLE clsc_ww_mahneb_1;
TRUNCATE TABLE clsc_ww_mahneb_d;
 
 
 
PROMPT ===========================================
PROMPT  19.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_mahneb_1
(
   dwh_cr_load_id,
   id,
   bez,
   letztaenddat,
   mahneb
)
VALUES
(
   &gbvid,
   id,
   bez,
   letztaenddat,
   mahneb
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_mahneb_d
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
   bez,
   letztaenddat,
   mahneb
FROM st_ww_mahneb_b
WHERE dwh_processdate = &termin;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  19.3 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_mahneb_1');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_mahneb_d');
 
 
 
PROMPT ===========================================
PROMPT  19.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING('clsc_ww_mahneb', 'id', &gbvid);
 
 
 
PROMPT ===========================================
PROMPT  19.5 Einspielen in die letzte SC-Tabelle ohne Referenzauflösung
PROMPT ===========================================
 
INSERT /*+ APPEND */
INTO clsc_ww_mahneb
(
   dwh_cr_load_id,
   id,
   bez,
   letztaenddat,
   mahneb
)
SELECT
   dwh_cr_load_id,
   id,
   bez,
   letztaenddat,
   mahneb
FROM clsc_ww_mahneb_1;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  19.6 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_mahneb');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_mahneb_e');



PROMPT =========================================================================
PROMPT
PROMPT 20. Source Core-Ladung
PROMPT Endtabelle: sc_ww_kdartgrp / sc_ww_kdartgrp_ver
PROMPT
PROMPT =========================================================================



PROMPT ===========================================
PROMPT  20.1 Cleansing Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clsc_ww_kdartgrp;
TRUNCATE TABLE clsc_ww_kdartgrp_1;
TRUNCATE TABLE clsc_ww_kdartgrp_d;
 
 
 
PROMPT ===========================================
PROMPT  20.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_kdartgrp_1
(
   dwh_cr_load_id,
   id,
   intbez,
   kurzbez
)
VALUES
(
   &gbvid,
   id,
   intbez,
   kurzbez
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_kdartgrp_d
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
   intbez,
   kurzbez
FROM st_ww_kdartgrp_b
WHERE dwh_processdate = &termin;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  20.3 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_kdartgrp_1');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_kdartgrp_d');
 
 
 
PROMPT ===========================================
PROMPT  20.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING('clsc_ww_kdartgrp', 'id', &gbvid);
 
 
 
PROMPT ===========================================
PROMPT  20.5 Einspielen in die letzte SC-Tabelle ohne Referenzauflösung
PROMPT ===========================================
 
INSERT /*+ APPEND */
INTO clsc_ww_kdartgrp
(
   dwh_cr_load_id,
   id,
   intbez,
   kurzbez
)
SELECT
   dwh_cr_load_id,
   id,
   intbez,
   kurzbez
FROM clsc_ww_kdartgrp_1;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  20.6 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_kdartgrp');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_kdartgrp_e');



PROMPT =========================================================================
PROMPT
PROMPT 21. Source Core-Ladung
PROMPT Endtabelle: sc_ww_personal / sc_ww_personal_ver
PROMPT
PROMPT =========================================================================
 
 
 
PROMPT ===========================================
PROMPT  21.1 Cleansing Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clsc_ww_personal;
TRUNCATE TABLE clsc_ww_personal_1;
TRUNCATE TABLE clsc_ww_personal_d;
 
 
 
PROMPT ===========================================
PROMPT  21.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_personal_1
(
   dwh_cr_load_id,
   id,
   persnr,
   nname,
   vname,
   geschlechtid,
   abt,
   vertrtxt,
   gebdat,
   eintrdat,
   ausweisnr,
   vondat,
   bisdat,
   vorsatzwortid,
   titelid,
   fgnr,
   persnrzentral
)
VALUES
(
   &gbvid,
   id,
   persnr,
   nname,
   vname,
   geschlechtid,
   abt,
   vertrtxt,
   gebdat,
   eintrdat,
   ausweisnr,
   vondat,
   bisdat,
   vorsatzwortid,
   titelid,
   fgnr,
   persnrzentral
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_personal_d
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
   persnr,
   nname,
   vname,
   geschlechtid,
   abt,
   vertrtxt,
   gebdat,
   eintrdat,
   ausweisnr,
   vondat,
   bisdat,
   vorsatzwortid,
   titelid,
   fgnr,
   persnrzentral
FROM st_ww_personal_b
WHERE dwh_processdate = &termin;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  21.3 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_personal_1');
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_personal_d');
 
 
 
PROMPT ===========================================
PROMPT  21.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING ('clsc_ww_personal', 'id', &gbvid);
 
 
 
PROMPT ===========================================
PROMPT  21.5 Einspielen in die letzte SC-Tabelle ohne Referenzauflösung
PROMPT ===========================================
 
INSERT /*+ APPEND */
INTO clsc_ww_personal
(
   dwh_cr_load_id,
   id,
   persnr,
   nname,
   vname,
   geschlechtid,
   abt,
   vertrtxt,
   gebdat,
   eintrdat,
   ausweisnr,
   vondat,
   bisdat,
   vorsatzwortid,
   titelid,
   fgnr,
   persnrzentral
)
SELECT
   dwh_cr_load_id,
   id,
   persnr,
   nname,
   vname,
   geschlechtid,
   abt,
   vertrtxt,
   gebdat,
   eintrdat,
   ausweisnr,
   vondat,
   bisdat,
   vorsatzwortid,
   titelid,
   fgnr,
   persnrzentral
FROM clsc_ww_personal_1;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  21.6 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_personal');
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_personal_e');



PROMPT =========================================================================
PROMPT
PROMPT 22. Source Core-Ladung
PROMPT Endtabelle: sc_ww_waehrung / sc_ww_waehrung_ver
PROMPT
PROMPT =========================================================================
 
 
 
PROMPT ===========================================
PROMPT  22.1 Cleansing Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clsc_ww_waehrung;
TRUNCATE TABLE clsc_ww_waehrung_1;
TRUNCATE TABLE clsc_ww_waehrung_d;
 
 
 
PROMPT ===========================================
PROMPT  22.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_waehrung_1
(
   dwh_cr_load_id,
   waehrungkz,
   waehrungbez,
   waehrungkurzbez,
   waehrungumrkurs,
   vondat,
   bisdat,
   isocode,
   waehrungkz_sav,
   id,
   liefwaehrkz,
   kleinsteeinheit,
   rundenkz
)
VALUES
(
   &gbvid,
   waehrungkz,
   waehrungbez,
   waehrungkurzbez,
   waehrungumrkurs,
   vondat,
   bisdat,
   isocode,
   waehrungkz_sav,
   id,
   liefwaehrkz,
   kleinsteeinheit,
   rundenkz
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_waehrung_d
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
   waehrungkz,
   waehrungbez,
   waehrungkurzbez,
   waehrungumrkurs,
   vondat,
   bisdat,
   isocode,
   waehrungkz_sav,
   id,
   liefwaehrkz,
   kleinsteeinheit,
   rundenkz
FROM st_ww_waehrung_b
WHERE dwh_processdate = &termin;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  22.3 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_waehrung_1');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_waehrung_d');
 
 
 
PROMPT ===========================================
PROMPT  22.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING('clsc_ww_waehrung', 'id', &gbvid);
 
 

PROMPT ===========================================
PROMPT  22.5 Einspielen in die letzte SC-Tabelle ohne Referenzauflösung
PROMPT ===========================================
 
INSERT /*+ APPEND */
INTO clsc_ww_waehrung
(
   dwh_cr_load_id,
   waehrungkz,
   waehrungbez,
   waehrungkurzbez,
   waehrungumrkurs,
   vondat,
   bisdat,
   isocode,
   waehrungkz_sav,
   id,
   liefwaehrkz,
   kleinsteeinheit,
   rundenkz
)
SELECT
   dwh_cr_load_id,
   waehrungkz,
   waehrungbez,
   waehrungkurzbez,
   waehrungumrkurs,
   vondat,
   bisdat,
   isocode,
   waehrungkz_sav,
   id,
   liefwaehrkz,
   kleinsteeinheit,
   rundenkz
FROM clsc_ww_waehrung_1;
 
COMMIT;
  
 
 
PROMPT ===========================================
PROMPT  22.6 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_waehrung');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_waehrung_e');



PROMPT =========================================================================
PROMPT
PROMPT 23. Source Core-Ladung
PROMPT Endtabelle: sc_ww_saison / sc_ww_saison_ver
PROMPT
PROMPT =========================================================================
 
 
 
PROMPT ===========================================
PROMPT  23.1 Cleansing Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clsc_ww_saison;
TRUNCATE TABLE clsc_ww_saison_1;
TRUNCATE TABLE clsc_ww_saison_d;
 
 
 
PROMPT ===========================================
PROMPT  23.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_saison_1
(
   dwh_cr_load_id,
   saison,
   saisonbez,
   saisonkurzbez,
   aktkz,
   graphik_farbe,
   graphik_zeichen,
   id
)
VALUES
(
   &gbvid,
   saison,
   saisonbez,
   saisonkurzbez,
   aktkz,
   graphik_farbe,
   graphik_zeichen,
   id
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_saison_d
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
   saisonbez,
   saisonkurzbez,
   aktkz,
   graphik_farbe,
   graphik_zeichen,
   id
FROM st_ww_saison_b
WHERE dwh_processdate = &termin;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  23.3 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_saison_1');
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_saison_d');
 
 
 
PROMPT ===========================================
PROMPT  23.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING ('clsc_ww_saison', 'id', &gbvid);
 
 
 
PROMPT ===========================================
PROMPT  23.5 Einspielen in die letzte SC-Tabelle ohne Referenzauflösung
PROMPT ===========================================
 
INSERT /*+ APPEND */
INTO clsc_ww_saison
(
   dwh_cr_load_id,
   saison,
   saisonbez,
   saisonkurzbez,
   aktkz,
   graphik_farbe,
   graphik_zeichen,
   id
)
SELECT
   dwh_cr_load_id,
   saison,
   saisonbez,
   saisonkurzbez,
   aktkz,
   graphik_farbe,
   graphik_zeichen,
   id
FROM clsc_ww_saison_1;
 
COMMIT;
 

-- Reference to cc_saison
MERGE INTO clsc_ww_saison a
USING cc_saison b
ON (a.saison = b.wert)
WHEN MATCHED THEN UPDATE
SET a.dwh_id_cc_saison = b.dwh_id
WHERE a.dwh_id_cc_saison = 100001658247177;

COMMIT;

 
 
PROMPT ===========================================
PROMPT  23.6 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_saison');
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_saison_e');



PROMPT =========================================================================
PROMPT
PROMPT 24. Source Core-Ladung
PROMPT Endtabelle: sc_ww_bestandsfirma / sc_ww_bestandsfirma_ver
PROMPT
PROMPT =========================================================================
 
 
 
PROMPT ===========================================
PROMPT  24.1 Cleansing Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clsc_ww_bestandsfirma;
TRUNCATE TABLE clsc_ww_bestandsfirma_1;
TRUNCATE TABLE clsc_ww_bestandsfirma_d;
 
 
 
PROMPT ===========================================
PROMPT  24.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_bestandsfirma_1
(
   dwh_cr_load_id,
   firmkz,
   firmbez,
   firmstr,
   firmplz,
   firmort,
   geschfuehrer_1,
   geschfuehrer_2,
   geschfuehrer_3,
   geschfuehrer_4,
   beiratsvorsitzender,
   handelsregister,
   ustidnr,
   geschfuerer_5,
   firmkurzbez,
   id,
   ilnnr,
   firmkurzbez2,
   konzernfirmaid,
   konzerncompanyid,
   iccsnr,
   aktivkz
)
VALUES
(
   &gbvid,
   firmkz,
   firmbez,
   firmstr,
   firmplz,
   firmort,
   geschfuehrer_1,
   geschfuehrer_2,
   geschfuehrer_3,
   geschfuehrer_4,
   beiratsvorsitzender,
   handelsregister,
   ustidnr,
   geschfuerer_5,
   firmkurzbez,
   id,
   ilnnr,
   firmkurzbez2,
   konzernfirmaid,
   konzerncompanyid,
   iccsnr,
   aktivkz
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_bestandsfirma_d
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
   firmkz,
   firmbez,
   firmstr,
   firmplz,
   firmort,
   geschfuehrer_1,
   geschfuehrer_2,
   geschfuehrer_3,
   geschfuehrer_4,
   beiratsvorsitzender,
   handelsregister,
   ustidnr,
   geschfuerer_5,
   firmkurzbez,
   id,
   ilnnr,
   firmkurzbez2,
   konzernfirmaid,
   konzerncompanyid,
   iccsnr,
   aktivkz
FROM st_ww_bestandsfirma_b
WHERE dwh_processdate = &termin;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  24.3 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_bestandsfirma_1');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_bestandsfirma_d');
 
 
 
PROMPT ===========================================
PROMPT  24.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING('clsc_ww_bestandsfirma', 'id', &gbvid);
 
 
 
PROMPT ===========================================
PROMPT  24.5 Einspielen in die letzte SC-Tabelle ohne Referenzauflösung
PROMPT ===========================================
 
INSERT /*+ APPEND */
INTO clsc_ww_bestandsfirma
(
   dwh_cr_load_id,
   firmkz,
   firmbez,
   firmstr,
   firmplz,
   firmort,
   geschfuehrer_1,
   geschfuehrer_2,
   geschfuehrer_3,
   geschfuehrer_4,
   beiratsvorsitzender,
   handelsregister,
   ustidnr,
   geschfuerer_5,
   firmkurzbez,
   id,
   ilnnr,
   firmkurzbez2,
   konzernfirmaid,
   konzerncompanyid,
   iccsnr,
   aktivkz
)
SELECT
   dwh_cr_load_id,
   firmkz,
   firmbez,
   firmstr,
   firmplz,
   firmort,
   geschfuehrer_1,
   geschfuehrer_2,
   geschfuehrer_3,
   geschfuehrer_4,
   beiratsvorsitzender,
   handelsregister,
   ustidnr,
   geschfuerer_5,
   firmkurzbez,
   id,
   ilnnr,
   firmkurzbez2,
   konzernfirmaid,
   konzerncompanyid,
   iccsnr,
   aktivkz
FROM clsc_ww_bestandsfirma_1;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  24.6 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_bestandsfirma');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_bestandsfirma_e');



PROMPT =========================================================================
PROMPT
PROMPT 25. Source Core-Ladung
PROMPT Endtabelle: sc_ww_crssperrkz / sc_ww_crssperrkz_ver
PROMPT
PROMPT =========================================================================
 
 
 
PROMPT ===========================================
PROMPT  25.1 Cleansing Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clsc_ww_crssperrkz;
TRUNCATE TABLE clsc_ww_crssperrkz_1;
TRUNCATE TABLE clsc_ww_crssperrkz_d;
 
 
 
PROMPT ===========================================
PROMPT  25.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_crssperrkz_1
(
   dwh_cr_load_id,
   crssperrkz,
   crssperrkzbez,
   crssperrkzkurzbez
)
VALUES
(
   &gbvid,
   crssperrkz,
   crssperrkzbez,
   crssperrkzkurzbez
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_crssperrkz_d
(
   dwh_cr_load_id,
   crssperrkz
)
VALUES
(
   &gbvid,
   crssperrkz
)
SELECT DISTINCT
   dwh_stbflag,
   crssperrkz,
   crssperrkzbez,
   crssperrkzkurzbez
FROM st_ww_crssperrkz_b
WHERE dwh_processdate = &termin;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  25.3 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_crssperrkz_1');
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_crssperrkz_d');
 
 
 
PROMPT ===========================================
PROMPT  25.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING ('clsc_ww_crssperrkz', 'crssperrkz', &gbvid);
 
 
 
PROMPT ===========================================
PROMPT  25.5 Einspielen in die letzte SC-Tabelle ohne Referenzauflösung
PROMPT ===========================================
 
INSERT /*+ APPEND */
INTO clsc_ww_crssperrkz
(
   dwh_cr_load_id,
   crssperrkz,
   crssperrkzbez,
   crssperrkzkurzbez
)
SELECT
   dwh_cr_load_id,
   crssperrkz,
   crssperrkzbez,
   crssperrkzkurzbez
FROM clsc_ww_crssperrkz_1;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  25.6 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_crssperrkz');
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_crssperrkz_e');



PROMPT =========================================================================
PROMPT
PROMPT 26. Source Core-Ladung
PROMPT Endtabelle: sc_ww_prozess / sc_ww_prozess_ver
PROMPT
PROMPT =========================================================================
 
 
 
PROMPT ===========================================
PROMPT  26.1 Cleansing Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clsc_ww_prozess;
TRUNCATE TABLE clsc_ww_prozess_1;
TRUNCATE TABLE clsc_ww_prozess_d;
 
 
 
PROMPT ===========================================
PROMPT  26.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_prozess_1
(
   dwh_cr_load_id,
   id,
   prozessnr,
   bezeichnung,
   prozessid,
   faktura_meilensteinid
)
VALUES
(
   &gbvid,
   id,
   prozessnr,
   bezeichnung,
   prozessid,
   faktura_meilensteinid
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_prozess_d
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
   prozessnr,
   bezeichnung,
   prozessid,
   faktura_meilensteinid
FROM st_ww_prozess_b
WHERE dwh_processdate = &termin;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  26.3 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_prozess_1');
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_prozess_d');
 
 
 
PROMPT ===========================================
PROMPT  26.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING ('clsc_ww_prozess', 'id', &gbvid);
 
 
 
PROMPT ===========================================
PROMPT  26.5 Einspielen in die letzte SC-Tabelle ohne Referenzauflösung
PROMPT ===========================================
 
INSERT /*+ APPEND */
INTO clsc_ww_prozess
(
   dwh_cr_load_id,
   id,
   prozessnr,
   bezeichnung,
   prozessid,
   faktura_meilensteinid
)
SELECT
   dwh_cr_load_id,
   id,
   prozessnr,
   bezeichnung,
   prozessid,
   faktura_meilensteinid
FROM clsc_ww_prozess_1;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  26.6 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_prozess');
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_prozess_e');



PROMPT =========================================================================
PROMPT
PROMPT 27. Source Core-Ladung
PROMPT Endtabelle: sc_ww_fgtyp / sc_ww_fgtyp_ver
PROMPT
PROMPT =========================================================================
 
 
 
PROMPT ===========================================
PROMPT  27.1 Cleansing Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clsc_ww_fgtyp;
TRUNCATE TABLE clsc_ww_fgtyp_1;
TRUNCATE TABLE clsc_ww_fgtyp_d;
 
 
 
PROMPT ===========================================
PROMPT  27.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_fgtyp_1
(
   dwh_cr_load_id,
   fgtyp,
   fgtypbez,
   id,
   fgtypkz
)
VALUES
(
   &gbvid,
   fgtyp,
   fgtypbez,
   id,
   fgtypkz
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_fgtyp_d
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
   fgtyp,
   fgtypbez,
   id,
   fgtypkz
FROM st_ww_fgtyp_b
WHERE dwh_processdate = &termin;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  27.3 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_fgtyp_1');
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_fgtyp_d');
 
 
 
PROMPT ===========================================
PROMPT  27.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING ('clsc_ww_fgtyp', 'id', &gbvid);
 
 
 
PROMPT ===========================================
PROMPT  27.5 Einspielen in die letzte SC-Tabelle ohne Referenzauflösung
PROMPT ===========================================
 
INSERT /*+ APPEND */
INTO clsc_ww_fgtyp
(
   dwh_cr_load_id,
   fgtyp,
   fgtypbez,
   id,
   fgtypkz
)
SELECT
   dwh_cr_load_id,
   fgtyp,
   fgtypbez,
   id,
   fgtypkz
FROM clsc_ww_fgtyp_1;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  27.6 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_fgtyp');
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_fgtyp_e');



PROMPT =========================================================================
PROMPT
PROMPT 28. Source Core-Ladung
PROMPT Endtabelle: sc_ww_sinnbestmenge / sc_ww_sinnbestmenge_ver
PROMPT
PROMPT =========================================================================
 
 
 
PROMPT ===========================================
PROMPT  28.1 Cleansing Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clsc_ww_sinnbestmenge;
TRUNCATE TABLE clsc_ww_sinnbestmenge_1;
TRUNCATE TABLE clsc_ww_sinnbestmenge_d;
 
 
 
PROMPT ===========================================
PROMPT  28.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_sinnbestmenge_1
(
   dwh_cr_load_id,
   sinnbestmgkz,
   minmg,
   maxmg,
   sinnbestmgbem
)
VALUES
(
   &gbvid,
   sinnbestmgkz,
   minmg,
   maxmg,
   sinnbestmgbem
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_sinnbestmenge_d
(
   dwh_cr_load_id,
   sinnbestmgkz
)
VALUES
(
   &gbvid,
   sinnbestmgkz
)
SELECT DISTINCT
   dwh_stbflag,
   sinnbestmgkz,
   minmg,
   maxmg,
   sinnbestmgbem
FROM st_ww_sinnbestmenge_b
WHERE dwh_processdate = &termin;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  28.3 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_sinnbestmenge_1');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_sinnbestmenge_d');
 
 
 
PROMPT ===========================================
PROMPT  28.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING('clsc_ww_sinnbestmenge', 'sinnbestmgkz', &gbvid);
 
 
 
PROMPT ===========================================
PROMPT  28.5 Einspielen in die letzte SC-Tabelle ohne Referenzauflösung
PROMPT ===========================================
 
INSERT /*+ APPEND */
INTO clsc_ww_sinnbestmenge
(
   dwh_cr_load_id,
   sinnbestmgkz,
   minmg,
   maxmg,
   sinnbestmgbem
)
SELECT
   dwh_cr_load_id,
   sinnbestmgkz,
   minmg,
   maxmg,
   sinnbestmgbem
FROM clsc_ww_sinnbestmenge_1;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  28.6 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_sinnbestmenge');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_sinnbestmenge_e');



PROMPT =========================================================================
PROMPT
PROMPT 29. Source Core-Ladung
PROMPT Endtabelle: sc_ww_verw_kz / sc_ww_verw_kz_ver
PROMPT
PROMPT =========================================================================
 
 
 
PROMPT ===========================================
PROMPT  29.1 Cleansing Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clsc_ww_verw_kz;
TRUNCATE TABLE clsc_ww_verw_kz_1;
TRUNCATE TABLE clsc_ww_verw_kz_d;
 
 
 
PROMPT ===========================================
PROMPT  29.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_verw_kz_1
(
   dwh_cr_load_id,
   verwkz,
   verwbez
)
VALUES
(
   &gbvid,
   verwkz,
   verwbez
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_verw_kz_d
(
   dwh_cr_load_id,
   verwkz
)
VALUES
(
   &gbvid,
   verwkz
)
SELECT DISTINCT
   dwh_stbflag,
   verwkz,
   verwbez
FROM st_ww_verw_kz_b
WHERE dwh_processdate = &termin;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  29.3 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_verw_kz_1');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_verw_kz_d');
 
 
 
PROMPT ===========================================
PROMPT  29.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING('clsc_ww_verw_kz', 'verwkz', &gbvid);
 
 
 
PROMPT ===========================================
PROMPT  29.5 Einspielen in die letzte SC-Tabelle ohne Referenzauflösung
PROMPT ===========================================
 
INSERT /*+ APPEND */
INTO clsc_ww_verw_kz
(
   dwh_cr_load_id,
   verwkz,
   verwbez
)
SELECT
   dwh_cr_load_id,
   verwkz,
   verwbez
FROM clsc_ww_verw_kz_1;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  29.6 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_verw_kz');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_verw_kz_e');



PROMPT =========================================================================
PROMPT
PROMPT 30. Source Core-Ladung
PROMPT Endtabelle: sc_ww_merkmalklasse / sc_ww_merkmalklasse_ver
PROMPT
PROMPT =========================================================================
 
 
 
PROMPT ===========================================
PROMPT  30.1 Cleansing Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clsc_ww_merkmalklasse;
TRUNCATE TABLE clsc_ww_merkmalklasse_1;
TRUNCATE TABLE clsc_ww_merkmalklasse_d;
 
 
 
PROMPT ===========================================
PROMPT  30.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_merkmalklasse_1
(
   dwh_cr_load_id,
   merkmalklnr,
   merkmalklbez,
   merkmalbezlang,
   mrk_merkmalklnr,
   erridat,
   aenddat,
   id
)
VALUES
(
   &gbvid,
   merkmalklnr,
   merkmalklbez,
   merkmalbezlang,
   mrk_merkmalklnr,
   erridat,
   aenddat,
   id
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_merkmalklasse_d
(
   dwh_cr_load_id,
   merkmalklnr
)
VALUES
(
   &gbvid,
   merkmalklnr
)
SELECT DISTINCT
   dwh_stbflag,
   merkmalklnr,
   merkmalklbez,
   merkmalbezlang,
   mrk_merkmalklnr,
   erridat,
   aenddat,
   id
FROM st_ww_merkmalklasse_b
WHERE dwh_processdate = &termin;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  30.3 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_merkmalklasse_1');
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_merkmalklasse_d');
 
 
 
PROMPT ===========================================
PROMPT  30.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING ('clsc_ww_merkmalklasse', 'merkmalklnr', &gbvid);
 
 
 
PROMPT ===========================================
PROMPT  30.5 Einspielen in die letzte SC-Tabelle ohne Referenzauflösung
PROMPT ===========================================
 
INSERT /*+ APPEND */
INTO clsc_ww_merkmalklasse
(
   dwh_cr_load_id,
   merkmalklnr,
   merkmalklbez,
   merkmalbezlang,
   mrk_merkmalklnr,
   erridat,
   aenddat,
   id
)
SELECT
   dwh_cr_load_id,
   merkmalklnr,
   merkmalklbez,
   merkmalbezlang,
   mrk_merkmalklnr,
   erridat,
   aenddat,
   id
FROM clsc_ww_merkmalklasse_1;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  30.6 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_merkmalklasse');
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_merkmalklasse_e');



PROMPT =========================================================================
PROMPT
PROMPT 31. Source Core-Ladung
PROMPT Endtabelle: sc_ww_lieferwunsch / sc_ww_lieferwunsch_ver
PROMPT
PROMPT =========================================================================
 
 
 
PROMPT ===========================================
PROMPT  31.1 Cleansing Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clsc_ww_lieferwunsch;
TRUNCATE TABLE clsc_ww_lieferwunsch_1;
TRUNCATE TABLE clsc_ww_lieferwunsch_d;
 
 
 
PROMPT ===========================================
PROMPT  31.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_lieferwunsch_1
(
   dwh_cr_load_id,
   id,
   kz,
   bez
)
VALUES
(
   &gbvid,
   id,
   kz,
   bez
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_lieferwunsch_d
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
   kz,
   bez
FROM st_ww_lieferwunsch_b
WHERE dwh_processdate = &termin;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  31.3 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_lieferwunsch_1');
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_lieferwunsch_d');
 
 
 
PROMPT ===========================================
PROMPT  31.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING ('clsc_ww_lieferwunsch', 'id', &gbvid);
 
 
 
PROMPT ===========================================
PROMPT  31.5 Einspielen in die letzte SC-Tabelle ohne Referenzauflösung
PROMPT ===========================================
 
INSERT /*+ APPEND */
INTO clsc_ww_lieferwunsch
(
   dwh_cr_load_id,
   id,
   kz,
   bez
)
SELECT
   dwh_cr_load_id,
   id,
   kz,
   bez
FROM clsc_ww_lieferwunsch_1;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  31.6 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_lieferwunsch');
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_lieferwunsch_e');
 
 
 
PROMPT =========================================================================
PROMPT
PROMPT 32. Source Core-Ladung
PROMPT Endtabelle: sc_ww_marktkzgeschlecht / sc_ww_marktkzgeschlecht_ver
PROMPT
PROMPT =========================================================================
 
 
 
PROMPT ===========================================
PROMPT  32.1 Cleansing Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clsc_ww_marktkzgeschlecht;
TRUNCATE TABLE clsc_ww_marktkzgeschlecht_1;
TRUNCATE TABLE clsc_ww_marktkzgeschlecht_d;
 
 
 
PROMPT ===========================================
PROMPT  32.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_marktkzgeschlecht_1
(
   dwh_cr_load_id,
   id,
   marktkzgeschlecht,
   marktkzgeschlechtkz
)
VALUES
(
   &gbvid,
   id,
   marktkzgeschlecht,
   marktkzgeschlechtkz
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_marktkzgeschlecht_d
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
   marktkzgeschlecht,
   marktkzgeschlechtkz
FROM st_ww_marktkzgeschlecht_b
WHERE dwh_processdate = &termin;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  32.3 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_marktkzgeschlecht_1');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_marktkzgeschlecht_d');
 
 
 
PROMPT ===========================================
PROMPT  32.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING('clsc_ww_marktkzgeschlecht', 'id', &gbvid);
 
 
 
PROMPT ===========================================
PROMPT  32.5 Einspielen in die letzte SC-Tabelle ohne Referenzauflösung
PROMPT ===========================================
 
INSERT /*+ APPEND */
INTO clsc_ww_marktkzgeschlecht
(
   dwh_cr_load_id,
   id,
   marktkzgeschlecht,
   marktkzgeschlechtkz
)
SELECT
   dwh_cr_load_id,
   id,
   marktkzgeschlecht,
   marktkzgeschlechtkz
FROM clsc_ww_marktkzgeschlecht_1;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  32.6 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_marktkzgeschlecht');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_marktkzgeschlecht_e');



PROMPT =========================================================================
PROMPT
PROMPT 33. Source Core-Ladung
PROMPT Endtabelle: sc_ww_marktkzalter / sc_ww_marktkzalter_ver
PROMPT
PROMPT =========================================================================
 
 
 
PROMPT ===========================================
PROMPT  33.1 Cleansing Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clsc_ww_marktkzalter;
TRUNCATE TABLE clsc_ww_marktkzalter_1;
TRUNCATE TABLE clsc_ww_marktkzalter_d;
 
 
 
PROMPT ===========================================
PROMPT  33.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_marktkzalter_1
(
   dwh_cr_load_id,
   id,
   marktkzalter,
   marktkzalterkz
)
VALUES
(
   &gbvid,
   id,
   marktkzalter,
   marktkzalterkz
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_marktkzalter_d
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
   marktkzalter,
   marktkzalterkz
FROM st_ww_marktkzalter_b
WHERE dwh_processdate = &termin;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  33.3 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_marktkzalter_1');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_marktkzalter_d');
 
 
 
PROMPT ===========================================
PROMPT  33.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING('clsc_ww_marktkzalter', 'id', &gbvid);
 
 
 
PROMPT ===========================================
PROMPT  33.5 Einspielen in die letzte SC-Tabelle ohne Referenzauflösung
PROMPT ===========================================
 
INSERT /*+ APPEND */
INTO clsc_ww_marktkzalter
(
   dwh_cr_load_id,
   id,
   marktkzalter,
   marktkzalterkz
)
SELECT
   dwh_cr_load_id,
   id,
   marktkzalter,
   marktkzalterkz
FROM clsc_ww_marktkzalter_1;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  33.6 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_marktkzalter');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_marktkzalter_e');



PROMPT =========================================================================
PROMPT
PROMPT 34. Source Core-Ladung
PROMPT Endtabelle: sc_ww_artnr_verwzweck / sc_ww_artnr_verwzweck_ver
PROMPT
PROMPT =========================================================================
 
 
 
PROMPT ===========================================
PROMPT  34.1 Cleansing Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clsc_ww_artnr_verwzweck;
TRUNCATE TABLE clsc_ww_artnr_verwzweck_1;
TRUNCATE TABLE clsc_ww_artnr_verwzweck_d;
 
 
 
PROMPT ===========================================
PROMPT  34.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_artnr_verwzweck_1
(
   dwh_cr_load_id,
   verwzweck,
   verwzweckbez,
   sortkz
)
VALUES
(
   &gbvid,
   verwzweck,
   verwzweckbez,
   sortkz
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_artnr_verwzweck_d
(
   dwh_cr_load_id,
   verwzweck
)
VALUES
(
   &gbvid,
   verwzweck
)
SELECT DISTINCT
   dwh_stbflag,
   verwzweck,
   verwzweckbez,
   sortkz
FROM st_ww_artnr_verwzweck_b
WHERE dwh_processdate = &termin;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  34.3 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_artnr_verwzweck_1');
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_artnr_verwzweck_d');
 
 
 
PROMPT ===========================================
PROMPT  34.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING ('clsc_ww_artnr_verwzweck', 'verwzweck', &gbvid);
 
 
 
PROMPT ===========================================
PROMPT  34.5 Einspielen in die letzte SC-Tabelle ohne Referenzauflösung
PROMPT ===========================================
 
INSERT /*+ APPEND */
INTO clsc_ww_artnr_verwzweck
(
   dwh_cr_load_id,
   verwzweck,
   verwzweckbez,
   sortkz
)
SELECT
   dwh_cr_load_id,
   verwzweck,
   verwzweckbez,
   sortkz
FROM clsc_ww_artnr_verwzweck_1;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  34.6 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_artnr_verwzweck');
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_artnr_verwzweck_e');



PROMPT =========================================================================
PROMPT
PROMPT 35. Source Core-Ladung
PROMPT Endtabelle: sc_ww_artnr_verwzwecknum / sc_ww_artnr_verwzwecknum_ver
PROMPT
PROMPT =========================================================================
 
 
 
PROMPT ===========================================
PROMPT  35.1 Cleansing Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clsc_ww_artnr_verwzwecknum;
TRUNCATE TABLE clsc_ww_artnr_verwzwecknum_1;
TRUNCATE TABLE clsc_ww_artnr_verwzwecknum_d;
 
 
 
PROMPT ===========================================
PROMPT  35.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_artnr_verwzwecknum_1
(
   dwh_cr_load_id,
   verwzweck,
   artnr6von,
   artnr6bis,
   id
)
VALUES
(
   &gbvid,
   verwzweck,
   artnr6von,
   artnr6bis,
   id
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_artnr_verwzwecknum_d
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
   verwzweck,
   artnr6von,
   artnr6bis,
   id
FROM st_ww_artnr_verwzwecknum_b
WHERE dwh_processdate = &termin;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  35.3 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_artnr_verwzwecknum_1');
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_artnr_verwzwecknum_d');
 
 
 
PROMPT ===========================================
PROMPT  35.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING ('clsc_ww_artnr_verwzwecknum', 'id', &gbvid);
 
 
 
PROMPT ===========================================
PROMPT  35.5 Einspielen in die letzte SC-Tabelle ohne Referenzauflösung
PROMPT ===========================================
 
INSERT /*+ APPEND */
INTO clsc_ww_artnr_verwzwecknum
(
   dwh_cr_load_id,
   verwzweck,
   artnr6von,
   artnr6bis,
   id
)
SELECT
   dwh_cr_load_id,
   verwzweck,
   artnr6von,
   artnr6bis,
   id
FROM clsc_ww_artnr_verwzwecknum_1;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  35.6 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_artnr_verwzwecknum');
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_artnr_verwzwecknum_e');



PROMPT =========================================================================
PROMPT
PROMPT 36. Source Core-Ladung
PROMPT Endtabelle: sc_ww_marktkz_verd / sc_ww_marktkz_verd_ver
PROMPT
PROMPT =========================================================================
 
 
 
PROMPT ===========================================
PROMPT  36.1 Cleansing Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clsc_ww_marktkz_verd;
TRUNCATE TABLE clsc_ww_marktkz_verd_1;
TRUNCATE TABLE clsc_ww_marktkz_verd_d;
 
 
 
PROMPT ===========================================
PROMPT  36.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_marktkz_verd_1
(
   dwh_cr_load_id,
   id,
   marktkzverd,
   bez
)
VALUES
(
   &gbvid,
   id,
   marktkzverd,
   bez
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_marktkz_verd_d
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
   marktkzverd,
   bez
FROM st_ww_marktkz_verd_b
WHERE dwh_processdate = &termin;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  36.3 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_marktkz_verd_1');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_marktkz_verd_d');
 
 
 
PROMPT ===========================================
PROMPT  36.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING('clsc_ww_marktkz_verd', 'id', &gbvid);
 
 
 
PROMPT ===========================================
PROMPT  36.5 Einspielen in die letzte SC-Tabelle ohne Referenzauflösung
PROMPT ===========================================
 
INSERT /*+ APPEND */
INTO clsc_ww_marktkz_verd
(
   dwh_cr_load_id,
   id,
   marktkzverd,
   bez
)
SELECT
   dwh_cr_load_id,
   id,
   marktkzverd,
   bez
FROM clsc_ww_marktkz_verd_1;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  36.6 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_marktkz_verd');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_marktkz_verd_e');



PROMPT =========================================================================
PROMPT
PROMPT 37. Source Core-Ladung
PROMPT Endtabelle: sc_ww_anrede / sc_ww_anrede_ver
PROMPT
PROMPT =========================================================================
 
 
 
PROMPT ===========================================
PROMPT  37.1 Cleansing Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clsc_ww_anrede;
TRUNCATE TABLE clsc_ww_anrede_1;
TRUNCATE TABLE clsc_ww_anrede_d;
 
 
 
PROMPT ===========================================
PROMPT  37.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_anrede_1
(
   dwh_cr_load_id,
   anrkz,
   anrbez
)
VALUES
(
   &gbvid,
   anrkz,
   anrbez
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_anrede_d
(
   dwh_cr_load_id,
   anrkz
)
VALUES
(
   &gbvid,
   anrkz
)
SELECT DISTINCT
   dwh_stbflag,
   anrkz,
   anrbez
FROM st_ww_anrede_b
WHERE dwh_processdate = &termin;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  37.3 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_anrede_1');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_anrede_d');
 
 
 
PROMPT ===========================================
PROMPT  37.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING('clsc_ww_anrede', 'anrkz', &gbvid);
 
 
 
PROMPT ===========================================
PROMPT  37.5 Einspielen in die letzte SC-Tabelle ohne Referenzauflösung
PROMPT ===========================================
 
INSERT /*+ APPEND */
INTO clsc_ww_anrede
(
   dwh_cr_load_id,
   anrkz,
   anrbez
)
SELECT
   dwh_cr_load_id,
   anrkz,
   anrbez
FROM clsc_ww_anrede_1;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  37.6 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_anrede');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_anrede_e');



PROMPT =========================================================================
PROMPT
PROMPT 38. Source Core-Ladung
PROMPT Endtabelle: sc_ww_verskostfreigrund / sc_ww_verskostfreigrund_ver
PROMPT
PROMPT =========================================================================
 
 
 
PROMPT ===========================================
PROMPT  38.1 Cleansing Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clsc_ww_verskostfreigrund;
TRUNCATE TABLE clsc_ww_verskostfreigrund_1;
TRUNCATE TABLE clsc_ww_verskostfreigrund_d;
 
 
 
PROMPT ===========================================
PROMPT  38.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_verskostfreigrund_1
(
   dwh_cr_load_id,
   id,
   bez,
   kz,
   prio,
   zahlmkostenrechirrelberechkz,
   zahlmkostenrechrelberechkz
)
VALUES
(
   &gbvid,
   id,
   bez,
   kz,
   prio,
   zahlmkostenrechirrelberechkz,
   zahlmkostenrechrelberechkz
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_verskostfreigrund_d
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
   bez,
   kz,
   prio,
   zahlmkostenrechirrelberechkz,
   zahlmkostenrechrelberechkz
FROM st_ww_verskostfreigrund_b
WHERE dwh_processdate = &termin;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  38.3 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_verskostfreigrund_1');
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_verskostfreigrund_d');
 
 
 
PROMPT ===========================================
PROMPT  38.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING ('clsc_ww_verskostfreigrund', 'id', &gbvid);
 
 
 
PROMPT ===========================================
PROMPT  38.5 Einspielen in die letzte SC-Tabelle ohne Referenzauflösung
PROMPT ===========================================
 
INSERT /*+ APPEND */
INTO clsc_ww_verskostfreigrund
(
   dwh_cr_load_id,
   id,
   bez,
   kz,
   prio,
   zahlmkostenrechirrelberechkz,
   zahlmkostenrechrelberechkz
)
SELECT
   dwh_cr_load_id,
   id,
   bez,
   kz,
   prio,
   zahlmkostenrechirrelberechkz,
   zahlmkostenrechrelberechkz
FROM clsc_ww_verskostfreigrund_1;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  38.6 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_verskostfreigrund');
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_verskostfreigrund_e');



PROMPT =========================================================================
PROMPT
PROMPT 39. Source Core-Ladung
PROMPT Endtabelle: sc_ww_versart / sc_ww_versart_ver
PROMPT
PROMPT =========================================================================
 
 
 
PROMPT ===========================================
PROMPT  39.1 Cleansing Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clsc_ww_versart;
TRUNCATE TABLE clsc_ww_versart_1;
TRUNCATE TABLE clsc_ww_versart_d;
 
 
 
PROMPT ===========================================
PROMPT  39.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_versart_1
(
   dwh_cr_load_id,
   id,
   versarttxt
)
VALUES
(
   &gbvid,
   id,
   versarttxt
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_versart_d
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
   versarttxt
FROM st_ww_versart_b
WHERE dwh_processdate = &termin;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  39.3 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_versart_1');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_versart_d');
 
 
 
PROMPT ===========================================
PROMPT  39.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING('clsc_ww_versart', 'id', &gbvid);
 
 
 
PROMPT ===========================================
PROMPT  39.5 Einspielen in die letzte SC-Tabelle ohne Referenzauflösung
PROMPT ===========================================
 
INSERT /*+ APPEND */
INTO clsc_ww_versart
(
   dwh_cr_load_id,
   id,
   versarttxt
)
SELECT
   dwh_cr_load_id,
   id,
   versarttxt
FROM clsc_ww_versart_1;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  39.6 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_versart');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_versart_e');



PROMPT =========================================================================
PROMPT
PROMPT 40. Source Core-Ladung
PROMPT Endtabelle: sc_ww_verw_bereich / sc_ww_verw_bereich_ver
PROMPT
PROMPT =========================================================================
 
 
 
PROMPT ===========================================
PROMPT  40.1 Cleansing Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clsc_ww_verw_bereich;
TRUNCATE TABLE clsc_ww_verw_bereich_1;
TRUNCATE TABLE clsc_ww_verw_bereich_d;
 
 
 
PROMPT ===========================================
PROMPT  40.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_verw_bereich_1
(
   dwh_cr_load_id,
   where_kz,
   where_kzbez
)
VALUES
(
   &gbvid,
   where_kz,
   where_kzbez
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_verw_bereich_d
(
   dwh_cr_load_id,
   where_kz
)
VALUES
(
   &gbvid,
   where_kz
)
SELECT DISTINCT
   dwh_stbflag,
   where_kz,
   where_kzbez
FROM st_ww_verw_bereich_b
WHERE dwh_processdate = &termin;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  40.3 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_verw_bereich_1');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_verw_bereich_d');
 
 
 
PROMPT ===========================================
PROMPT  40.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING('clsc_ww_verw_bereich', 'where_kz', &gbvid);
 
 
 
PROMPT ===========================================
PROMPT  40.5 Einspielen in die letzte SC-Tabelle ohne Referenzauflösung
PROMPT ===========================================
 
INSERT /*+ APPEND */
INTO clsc_ww_verw_bereich
(
   dwh_cr_load_id,
   where_kz,
   where_kzbez
)
SELECT
   dwh_cr_load_id,
   where_kz,
   where_kzbez
FROM clsc_ww_verw_bereich_1;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  40.6 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_verw_bereich');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_verw_bereich_e');



PROMPT =========================================================================
PROMPT
PROMPT 41. Source Core-Ladung
PROMPT Endtabelle: sc_ww_kontosperre / sc_ww_kontosperre_ver
PROMPT
PROMPT =========================================================================
 
 
 
PROMPT ===========================================
PROMPT  41.1 Cleansing Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clsc_ww_kontosperre;
TRUNCATE TABLE clsc_ww_kontosperre_1;
TRUNCATE TABLE clsc_ww_kontosperre_d;
 
 
 
PROMPT ===========================================
PROMPT  41.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_kontosperre_1
(
   dwh_cr_load_id,
   id,
   kz,
   kurzbez,
   intbez,
   manuellkz,
   aktivkz,
   sperrtextkz
)
VALUES
(
   &gbvid,
   id,
   kz,
   kurzbez,
   intbez,
   manuellkz,
   aktivkz,
   sperrtextkz
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_kontosperre_d
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
   kz,
   kurzbez,
   intbez,
   manuellkz,
   aktivkz,
   sperrtextkz
FROM st_ww_kontosperre_b
WHERE dwh_processdate = &termin;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  41.3 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_kontosperre_1');
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_kontosperre_d');
 
 
 
PROMPT ===========================================
PROMPT  41.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING ('clsc_ww_kontosperre', 'id', &gbvid);
 
 
 
PROMPT ===========================================
PROMPT  41.5 Einspielen in die letzte SC-Tabelle ohne Referenzauflösung
PROMPT ===========================================
 
INSERT /*+ APPEND */
INTO clsc_ww_kontosperre
(
   dwh_cr_load_id,
   id,
   kz,
   kurzbez,
   intbez,
   manuellkz,
   aktivkz,
   sperrtextkz
)
SELECT
   dwh_cr_load_id,
   id,
   kz,
   kurzbez,
   intbez,
   manuellkz,
   aktivkz,
   sperrtextkz
FROM clsc_ww_kontosperre_1;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  41.6 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_kontosperre');
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_kontosperre_e');



PROMPT =========================================================================
PROMPT
PROMPT 42. Source Core-Ladung
PROMPT Endtabelle: sc_ww_liinftele / sc_ww_liinftele_ver
PROMPT
PROMPT =========================================================================
 
 
 
PROMPT ===========================================
PROMPT  42.1 Cleansing Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clsc_ww_liinftele;
TRUNCATE TABLE clsc_ww_liinftele_1;
TRUNCATE TABLE clsc_ww_liinftele_d;
 
 
 
PROMPT ===========================================
PROMPT  42.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_liinftele_1
(
   dwh_cr_load_id,
   liinftele,
   liinftelebez,
   liinftelekurzbez,
   liinftelekwvon,
   liinftelekwbis,
   liinftelegueltigvon,
   liinftelegueltigbis,
   erstdat,
   aenddat,
   id,
   liinfteleovzeitvon,
   liinfteleovzeitbis
)
VALUES
(
   &gbvid,
   liinftele,
   liinftelebez,
   liinftelekurzbez,
   liinftelekwvon,
   liinftelekwbis,
   liinftelegueltigvon,
   liinftelegueltigbis,
   erstdat,
   aenddat,
   id,
   liinfteleovzeitvon,
   liinfteleovzeitbis
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_liinftele_d
(
   dwh_cr_load_id,
   liinftele
)
VALUES
(
   &gbvid,
   liinftele
)
SELECT DISTINCT
   dwh_stbflag,
   liinftele,
   liinftelebez,
   liinftelekurzbez,
   liinftelekwvon,
   liinftelekwbis,
   liinftelegueltigvon,
   liinftelegueltigbis,
   erstdat,
   aenddat,
   id,
   liinfteleovzeitvon,
   liinfteleovzeitbis
FROM st_ww_liinftele_b
WHERE dwh_processdate = &termin;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  42.3 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_liinftele_1');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_liinftele_d');
 
 
 
PROMPT ===========================================
PROMPT  42.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING('clsc_ww_liinftele', 'liinftele', &gbvid);
 
 
 
PROMPT ===========================================
PROMPT  42.5 Einspielen in die letzte SC-Tabelle ohne Referenzauflösung
PROMPT ===========================================
 
INSERT /*+ APPEND */
INTO clsc_ww_liinftele
(
   dwh_cr_load_id,
   liinftele,
   liinftelebez,
   liinftelekurzbez,
   liinftelekwvon,
   liinftelekwbis,
   liinftelegueltigvon,
   liinftelegueltigbis,
   erstdat,
   aenddat,
   id,
   liinfteleovzeitvon,
   liinfteleovzeitbis
)
SELECT
   dwh_cr_load_id,
   liinftele,
   liinftelebez,
   liinftelekurzbez,
   liinftelekwvon,
   liinftelekwbis,
   liinftelegueltigvon,
   liinftelegueltigbis,
   erstdat,
   aenddat,
   id,
   liinfteleovzeitvon,
   liinfteleovzeitbis
FROM clsc_ww_liinftele_1;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  42.6 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_liinftele');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_liinftele_e');



PROMPT =========================================================================
PROMPT
PROMPT 43. Source Core-Ladung
PROMPT Endtabelle: sc_ww_ret_grund / sc_ww_ret_grund_ver
PROMPT
PROMPT =========================================================================
 
 
 
PROMPT ===========================================
PROMPT  43.1 Cleansing Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clsc_ww_ret_grund;
TRUNCATE TABLE clsc_ww_ret_grund_1;
TRUNCATE TABLE clsc_ww_ret_grund_d;
 
 
 
PROMPT ===========================================
PROMPT  43.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_ret_grund_1
(
   dwh_cr_load_id,
   retgrund,
   retgrundkz,
   retgrundbez,
   retartkz,
   sortkz
)
VALUES
(
   &gbvid,
   retgrund,
   retgrundkz,
   retgrundbez,
   retartkz,
   sortkz
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_ret_grund_d
(
   dwh_cr_load_id,
   retgrund
)
VALUES
(
   &gbvid,
   retgrund
)
SELECT DISTINCT
   dwh_stbflag,
   retgrund,
   retgrundkz,
   retgrundbez,
   retartkz,
   sortkz
FROM st_ww_ret_grund_b
WHERE dwh_processdate = &termin;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  43.3 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_ret_grund_1');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_ret_grund_d');
 
 
 
PROMPT ===========================================
PROMPT  43.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING('clsc_ww_ret_grund', 'retgrund', &gbvid);
 
 
 
PROMPT ===========================================
PROMPT  43.5 Einspielen in die letzte SC-Tabelle ohne Referenzauflösung
PROMPT ===========================================
 
INSERT /*+ APPEND */
INTO clsc_ww_ret_grund
(
   dwh_cr_load_id,
   retgrund,
   retgrundkz,
   retgrundbez,
   retartkz,
   sortkz
)
SELECT
   dwh_cr_load_id,
   retgrund,
   retgrundkz,
   retgrundbez,
   retartkz,
   sortkz
FROM clsc_ww_ret_grund_1;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  43.6 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_ret_grund');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_ret_grund_e');



PROMPT =========================================================================
PROMPT
PROMPT 44. Source Core-Ladung
PROMPT Endtabelle: sc_ww_faktura_kalender / sc_ww_faktura_kalender_ver
PROMPT
PROMPT =========================================================================
 
 
 
PROMPT ===========================================
PROMPT  44.1 Cleansing Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clsc_ww_faktura_kalender;
TRUNCATE TABLE clsc_ww_faktura_kalender_1;
TRUNCATE TABLE clsc_ww_faktura_kalender_d;
 
 
 
PROMPT ===========================================
PROMPT  44.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_faktura_kalender_1
(
   dwh_cr_load_id,
   id,
   faktdat,
   fakttyp,
   aktivkz,
   bem,
   geprueftkz
)
VALUES
(
   &gbvid,
   id,
   faktdat,
   fakttyp,
   aktivkz,
   bem,
   geprueftkz
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_faktura_kalender_d
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
   faktdat,
   fakttyp,
   aktivkz,
   bem,
   geprueftkz
FROM st_ww_faktura_kalender_b
WHERE dwh_processdate = &termin;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  44.3 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_faktura_kalender_1');
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_faktura_kalender_d');
 
 
 
PROMPT ===========================================
PROMPT  44.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING ('clsc_ww_faktura_kalender', 'id', &gbvid);
 
 
 
PROMPT ===========================================
PROMPT  44.5 Einspielen in die letzte SC-Tabelle ohne Referenzauflösung
PROMPT ===========================================
 
INSERT /*+ APPEND */
INTO clsc_ww_faktura_kalender
(
   dwh_cr_load_id,
   id,
   faktdat,
   fakttyp,
   aktivkz,
   bem,
   geprueftkz
)
SELECT
   dwh_cr_load_id,
   id,
   faktdat,
   fakttyp,
   aktivkz,
   bem,
   geprueftkz
FROM clsc_ww_faktura_kalender_1;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  44.6 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_faktura_kalender');
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_faktura_kalender_e');



PROMPT =========================================================================
PROMPT
PROMPT 45. Source Core-Ladung
PROMPT Endtabelle: sc_ww_verpackungstyp_verw / sc_ww_verpackungstyp_verw_ver
PROMPT
PROMPT =========================================================================
 
 
 
PROMPT ===========================================
PROMPT  45.1 Cleansing Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clsc_ww_verpackungstyp_verw;
TRUNCATE TABLE clsc_ww_verpackungstyp_verw_1;
TRUNCATE TABLE clsc_ww_verpackungstyp_verw_d;
 
 
 
PROMPT ===========================================
PROMPT  45.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_verpackungstyp_verw_1
(
   dwh_cr_load_id,
   id,
   bez,
   kz
)
VALUES
(
   &gbvid,
   id,
   bez,
   kz
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_verpackungstyp_verw_d
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
   bez,
   kz
FROM st_ww_verpackungstyp_verw_b
WHERE dwh_processdate = &termin;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  45.3 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_verpackungstyp_verw_1');
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_verpackungstyp_verw_d');
 
 
 
PROMPT ===========================================
PROMPT  45.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING ('clsc_ww_verpackungstyp_verw', 'id', &gbvid);
 
 
 
PROMPT ===========================================
PROMPT  45.5 Einspielen in die letzte SC-Tabelle ohne Referenzauflösung
PROMPT ===========================================
 
INSERT /*+ APPEND */
INTO clsc_ww_verpackungstyp_verw
(
   dwh_cr_load_id,
   id,
   bez,
   kz
)
SELECT
   dwh_cr_load_id,
   id,
   bez,
   kz
FROM clsc_ww_verpackungstyp_verw_1;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  45.6 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_verpackungstyp_verw');
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_verpackungstyp_verw_e');



PROMPT =========================================================================
PROMPT
PROMPT 46. Source Core-Ladung
PROMPT Endtabelle: sc_ww_kdinformationart / sc_ww_kdinformationart_ver
PROMPT
PROMPT =========================================================================
 
 
 
PROMPT ===========================================
PROMPT  46.1 Cleansing Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clsc_ww_kdinformationart;
TRUNCATE TABLE clsc_ww_kdinformationart_1;
TRUNCATE TABLE clsc_ww_kdinformationart_d;
 
 
 
PROMPT ===========================================
PROMPT  46.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_kdinformationart_1
(
   dwh_cr_load_id,
   id,
   intbez,
   intkz,
   kommunikationswegkz
)
VALUES
(
   &gbvid,
   id,
   intbez,
   intkz,
   kommunikationswegkz
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_kdinformationart_d
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
   intbez,
   intkz,
   kommunikationswegkz
FROM st_ww_kdinformationart_b
WHERE dwh_processdate = &termin;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  46.3 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_kdinformationart_1');
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_kdinformationart_d');
 
 
 
PROMPT ===========================================
PROMPT  46.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING ('clsc_ww_kdinformationart', 'id', &gbvid);
 
 
 
PROMPT ===========================================
PROMPT  46.5 Einspielen in die letzte SC-Tabelle ohne Referenzauflösung
PROMPT ===========================================
 
INSERT /*+ APPEND */
INTO clsc_ww_kdinformationart
(
   dwh_cr_load_id,
   id,
   intbez,
   intkz,
   kommunikationswegkz
)
SELECT
   dwh_cr_load_id,
   id,
   intbez,
   intkz,
   kommunikationswegkz
FROM clsc_ww_kdinformationart_1;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  46.6 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_kdinformationart');
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_kdinformationart_e');



PROMPT =========================================================================
PROMPT
PROMPT 47. Source Core-Ladung
PROMPT Endtabelle: sc_ww_ststeuerungskz / sc_ww_ststeuerungskz_ver
PROMPT
PROMPT =========================================================================
 
 
 
PROMPT ===========================================
PROMPT  47.1 Cleansing Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clsc_ww_ststeuerungskz;
TRUNCATE TABLE clsc_ww_ststeuerungskz_1;
TRUNCATE TABLE clsc_ww_ststeuerungskz_d;
 
 
 
PROMPT ===========================================
PROMPT  47.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_ststeuerungskz_1
(
   dwh_cr_load_id,
   id,
   kz,
   bez
)
VALUES
(
   &gbvid,
   id,
   kz,
   bez
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_ststeuerungskz_d
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
   kz,
   bez
FROM st_ww_ststeuerungskz_b
WHERE dwh_processdate = &termin;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  47.3 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_ststeuerungskz_1');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_ststeuerungskz_d');
 
 
 
PROMPT ===========================================
PROMPT  47.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING('clsc_ww_ststeuerungskz', 'id', &gbvid);
 
 
 
PROMPT ===========================================
PROMPT  47.5 Einspielen in die letzte SC-Tabelle ohne Referenzauflösung
PROMPT ===========================================
 
INSERT /*+ APPEND */
INTO clsc_ww_ststeuerungskz
(
   dwh_cr_load_id,
   id,
   kz,
   bez
)
SELECT
   dwh_cr_load_id,
   id,
   kz,
   bez
FROM clsc_ww_ststeuerungskz_1;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  47.6 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_ststeuerungskz');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_ststeuerungskz_e');



PROMPT =========================================================================
PROMPT
PROMPT 48. Source Core-Ladung
PROMPT Endtabelle: sc_ww_einkleit / sc_ww_einkleit_ver
PROMPT
PROMPT =========================================================================
 
 
 
PROMPT ===========================================
PROMPT  48.1 Cleansing Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clsc_ww_einkleit;
TRUNCATE TABLE clsc_ww_einkleit_1;
TRUNCATE TABLE clsc_ww_einkleit_d;
 
 
 
PROMPT ===========================================
PROMPT  48.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_einkleit_1
(
   dwh_cr_load_id,
   saison,
   einkleitnr,
   einkleitname,
   einkleitbem
)
VALUES
(
   &gbvid,
   saison,
   einkleitnr,
   einkleitname,
   einkleitbem
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_einkleit_d
(
   dwh_cr_load_id,
   saison,
   einkleitnr
)
VALUES
(
   &gbvid,
   saison,
   einkleitnr
)
SELECT
   dwh_stbflag,
   saison,
   einkleitnr,
   einkleitname,
   einkleitbem
FROM st_ww_einkleit_b
WHERE dwh_processdate = &termin;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  48.3 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_einkleit_1');
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_einkleit_d');
 
 
 
PROMPT ===========================================
PROMPT  48.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING ('clsc_ww_einkleit', 'saison, einkleitnr', &gbvid);
 
 
 
PROMPT ===========================================
PROMPT  48.5 Einspielen in die letzte SC-Tabelle mit Referenzauflösung
PROMPT ===========================================
 
INSERT /*+ APPEND */ FIRST
WHEN (dwh_id_sc_ww_eksaison IS NULL 
) THEN
INTO clsc_ww_einkleit_e
(
   dwh_cr_load_id,
   dwh_up_load_id,
   dwh_id_sc_ww_eksaison,
   saison,
   einkleitnr,
   einkleitname,
   einkleitbem
)
VALUES
(
   dwh_cr_load_id,
   &gbvid,
   dwh_id_sc_ww_eksaison,
   saison,
   einkleitnr,
   einkleitname,
   einkleitbem
)
ELSE
INTO clsc_ww_einkleit
(
   dwh_cr_load_id,
   dwh_id_sc_ww_eksaison,
   saison,
   einkleitnr,
   einkleitname,
   einkleitbem
)
SELECT
   a.dwh_cr_load_id,
   sc_ww_eksaison.dwh_id AS dwh_id_sc_ww_eksaison,
   a.saison AS saison,
   a.einkleitnr AS einkleitnr,
   a.einkleitname AS einkleitname,
   a.einkleitbem AS einkleitbem
FROM clsc_ww_einkleit_1 a
  LEFT OUTER JOIN (SELECT sc_ww_eksaison.dwh_id, sc_ww_eksaison.wert FROM sc_ww_eksaison)  sc_ww_eksaison
      ON (a.saison = sc_ww_eksaison.wert)
;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  48.6 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_einkleit');
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_einkleit_e');



PROMPT =========================================================================
PROMPT
PROMPT 49. Source Core-Ladung
PROMPT Endtabelle: sc_ww_retruecklversfirma / sc_ww_retruecklversfirma_ver
PROMPT
PROMPT =========================================================================
 
 
 
PROMPT ===========================================
PROMPT  49.1 Cleansing Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clsc_ww_retruecklversfirma;
TRUNCATE TABLE clsc_ww_retruecklversfirma_1;
TRUNCATE TABLE clsc_ww_retruecklversfirma_d;
 
 
 
PROMPT ===========================================
PROMPT  49.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_retruecklversfirma_1
(
   dwh_cr_load_id,
   id,
   verskz,
   bez,
   bildnr
)
VALUES
(
   &gbvid,
   id,
   verskz,
   bez,
   bildnr
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_retruecklversfirma_d
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
   verskz,
   bez,
   bildnr
FROM st_ww_retruecklversfirma_b
WHERE dwh_processdate = &termin;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  49.3 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_retruecklversfirma_1');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_retruecklversfirma_d');
 
 
 
PROMPT ===========================================
PROMPT  49.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING('clsc_ww_retruecklversfirma', 'id', &gbvid);
 
 
 
PROMPT ===========================================
PROMPT  49.5 Einspielen in die letzte SC-Tabelle ohne Referenzauflösung
PROMPT ===========================================
 
INSERT /*+ APPEND */
INTO clsc_ww_retruecklversfirma
(
   dwh_cr_load_id,
   id,
   verskz,
   bez,
   bildnr
)
SELECT
   dwh_cr_load_id,
   id,
   verskz,
   bez,
   bildnr
FROM clsc_ww_retruecklversfirma_1;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  49.6 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_retruecklversfirma');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_retruecklversfirma_e');