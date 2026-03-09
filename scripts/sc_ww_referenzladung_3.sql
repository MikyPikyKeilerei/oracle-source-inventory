/*******************************************************************************

Job:                  sc_ww_referenzladung_3
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

verwendete Tabellen:  st_ww_kdart_b
                      st_ww_land_b
                      st_ww_persanrede_b
                      st_ww_liefauskunft_b
                      st_ww_vertrgebietgruppe_b
                      st_ww_marktkz_b
                      st_ww_et_direktor_b
                       
Endtabellen:          sc_ww_kdart / sc_ww_kdart_ver
                      sc_ww_land / sc_ww_land_ver
                      sc_ww_persanrede / sc_ww_persanrede_ver
                      sc_ww_liefauskunft / sc_ww_liefauskunft_ver
                      sc_ww_vertrgebietgruppe / sc_ww_vertrgebietgruppe_ver
                      sc_ww_marktkz / sc_ww_marktkz_ver
                      sc_ww_et_direktor / sc_ww_et_direktor_ver

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
Änderungen:           ##.7 Umzug von LAND aus sc_ww_referenzladung_1; Umzug von KUNDENFIRMA in sc_ww_referenzladung_3

geändert am:          2016-09-22
geändert von:         stegrs
Änderungen:           ##.8 Umzug von PERSANREDE aus sc_ww_referenzladung_1;

geändert am:          2016-09-23
geändert von:         stegrs
Änderungen:           ##.9 Tabelle ETBER hinzugefügt -> Referenzauflösung zu Benutzer kann aktuell noch nicht vorgenommen werden, da Spalte nicht befüllt

geändert am:          2016-10-24
geändert von:         stegrs, jockoe
Änderungen:           ##.10 Uhrzeit von 22:05 auf 00:00 verlegt

geändert am:          2016-11-30
geändert von:         stegrs
Änderungen:           ##.11 Tabelle LIEFAUSKUNFT hinzugefügt

geändert am:          2017-01-18
geändert von:         stegrs
Änderungen:           ##.12 Tabelle VERTRGEBIETGRUPPE hinzugefügt

geändert am:          2017-01-24
geändert von:         stegrs
Änderungen:           ##.13 Tabelle MARKTKZ hinzugefügt

geändert am:          2017-01-30
geändert von:         stegrs
Änderungen:           ##.14 Tabelle KDART um Spalten erweitert

geändert am:          2017-03-20
geändert von:         stegrs
Änderungen:           ##.15 Tabelle KDART um Spalten erweitert

geändert am:          2017-05-03
geändert von:         stegrs
Änderungen:           ##.16 Tabelle MARKTKZ um Spalten erweitert

geändert am:          2017-05-17
geändert von:         stegrs
Änderungen:           ##.17 Tabelle KDART um Spalten erweitert

geändert am:          2017-09-04
geändert von:         joeabd
Änderungen:           ##.18 Bugfix KDART: Übernahme Spalte MAHNSTRANGIDDEFAULT in letzte Cleanse hinzugefügt

geändert am:          2017-09-26
geändert am:          stegrs
Änderungen:           ##.19 Tabelle MARKTKZ mit MERKMALKLASSE verknüpft

geändert am:          2017-10-10
geändert am:          stegrs, joeabd
Änderungen:           ##.20 Tabelle MARKTKZ: Rückgriff auf SC (Marktkz) bzw. ST (Marktkz_Zuord) hinzugefügt.
                      Grund: Für geänderte Zuordnungen (Marktkz -> Obermarktkz) muss auch ein Änderungsdatensatz in sc_ww_marktkz_ver erzeugt
                      werden, damit Verknüpfung mit korrektem CC_Marktkz-Datensatz (der aufgrund der neuen Zuordnung erzeugt wird) erstellt werden kann.

geändert am:          2017-10-24
geändert von:         stegrs
Änderungen:           ##.21: Referenzjob _2 in _3 umbenannt

geändert am:          2018-02-28
geändert von:         stegrs
Änderungen:           ##.22 Tabelle LAND um Spalte erweitert

geändert am:          2018-05-14
geändert von:         stegrs
Änderungen:           ##.23 Tabelle MARKTKZ um Spalten erweitert

geändert am:          2018-07-10
geändert von:         stegrs
Änderungen:           ##.24 Tabelle ET_DIREKTOR hinzugefügt

geändert am:          2018-07-10
geändert von:         stegrs
Änderungen:           ##.6: Tabelle ETBER von _3 in _4 umgezogen

geändert am:          2018-07-10
geändert von:         stegrs
Änderungen:           ##.7: Tabelle ET_DIREKTOR: saison zu eksaison geändert und
                            Referenzauflösung zu bestandsfirma

geändert am:          2019-12-18
geändert von:         svehoc
Änderungen:           ##.8: Umzug auf UDWH1

geändert am:          2021-05-06
geändert von:         olifos
Änderungen:           ##.9: Tabelle MARKTKZ um Referenzspalte GPPFLEGEMKZ erweitert
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
PROMPT Endtabelle: sc_ww_kdart / sc_ww_kdart_ver
PROMPT
PROMPT =========================================================================



PROMPT ===========================================
PROMPT  1.1 Cleansing Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clsc_ww_kdart;
TRUNCATE TABLE clsc_ww_kdart_1;
TRUNCATE TABLE clsc_ww_kdart_d;
 
 
 
PROMPT ===========================================
PROMPT  1.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_kdart_1
(
   dwh_cr_load_id,
   id,
   kdartgrp,
   kdartbez,
   letztaenddat,
   kdart,
   kdartgrpid,
   rabattproz,
   basislimitkz,
   mwstausweiskz,
   ratenaufschlagkz,
   zahlpauseaufschlagkz,
   versandkostenkz,
   erhversandkostenkz,
   lieferwunschgebuehrkz,
   personalkz,
   gratisartikelpruefungkz,
   sicherzahlkz,
   speditionkostenkz,
   lieferwunschkostenkz,
   mahnstrangiddefault
)
VALUES
(
   &gbvid,
   id,
   kdartgrp,
   kdartbez,
   letztaenddat,
   kdart,
   kdartgrpid,
   rabattproz,
   basislimitkz,
   mwstausweiskz,
   ratenaufschlagkz,
   zahlpauseaufschlagkz,
   versandkostenkz,
   erhversandkostenkz,
   lieferwunschgebuehrkz,
   personalkz,
   gratisartikelpruefungkz,
   sicherzahlkz,
   speditionkostenkz,
   lieferwunschkostenkz,
   mahnstrangiddefault
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_kdart_d
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
   kdartgrp,
   kdartbez,
   letztaenddat,
   kdart,
   kdartgrpid,
   rabattproz,
   basislimitkz,
   mwstausweiskz,
   ratenaufschlagkz,
   zahlpauseaufschlagkz,
   versandkostenkz,
   erhversandkostenkz,
   lieferwunschgebuehrkz,
   personalkz,
   gratisartikelpruefungkz,
   sicherzahlkz,
   speditionkostenkz,
   lieferwunschkostenkz,
   mahnstrangiddefault
FROM st_ww_kdart_b
WHERE dwh_processdate = &termin;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  1.3 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_kdart_1');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_kdart_d');



PROMPT ===========================================
PROMPT  1.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING('clsc_ww_kdart', 'id', &gbvid);



PROMPT ===========================================
PROMPT  1.5 Einspielen in die letzte SC-Tabelle mit Referenzauflösung
PROMPT ===========================================
 
INSERT /*+ APPEND */ FIRST
WHEN (dwh_id_sc_ww_kdartgrp IS NULL 
) THEN
INTO clsc_ww_kdart_e
(
   dwh_cr_load_id,
   dwh_up_load_id,
   dwh_id_sc_ww_kdartgrp,
   id,
   kdartgrp,
   kdartbez,
   letztaenddat,
   kdart,
   kdartgrpid,
   rabattproz,
   basislimitkz,
   mwstausweiskz,
   ratenaufschlagkz,
   zahlpauseaufschlagkz,
   versandkostenkz,
   erhversandkostenkz,
   lieferwunschgebuehrkz,
   personalkz,
   gratisartikelpruefungkz,
   sicherzahlkz,
   speditionkostenkz,
   lieferwunschkostenkz,
   mahnstrangiddefault
)
VALUES
(
   dwh_cr_load_id,
   &gbvid,
   dwh_id_sc_ww_kdartgrp,
   id,
   kdartgrp,
   kdartbez,
   letztaenddat,
   kdart,
   kdartgrpid,
   rabattproz,
   basislimitkz,
   mwstausweiskz,
   ratenaufschlagkz,
   zahlpauseaufschlagkz,
   versandkostenkz,
   erhversandkostenkz,
   lieferwunschgebuehrkz,
   personalkz,
   gratisartikelpruefungkz,
   sicherzahlkz,
   speditionkostenkz,
   lieferwunschkostenkz,
   mahnstrangiddefault
)
ELSE
INTO clsc_ww_kdart
(
   dwh_cr_load_id,
   dwh_id_sc_ww_kdartgrp,
   id,
   kdartgrp,
   kdartbez,
   letztaenddat,
   kdart,
   kdartgrpid,
   rabattproz,
   basislimitkz,
   mwstausweiskz,
   ratenaufschlagkz,
   zahlpauseaufschlagkz,
   versandkostenkz,
   erhversandkostenkz,
   lieferwunschgebuehrkz,
   personalkz,
   gratisartikelpruefungkz,
   sicherzahlkz,
   speditionkostenkz,
   lieferwunschkostenkz,
   mahnstrangiddefault
)
SELECT
   a.dwh_cr_load_id,
   sc_ww_kdartgrp.dwh_id AS dwh_id_sc_ww_kdartgrp,
   a.id AS id,
   a.kdartgrp AS kdartgrp,
   a.kdartbez AS kdartbez,
   a.letztaenddat AS letztaenddat,
   a.kdart AS kdart,
   a.kdartgrpid AS kdartgrpid,
   a.rabattproz AS rabattproz,
   a.basislimitkz AS basislimitkz,
   a.mwstausweiskz AS mwstausweiskz,
   a.ratenaufschlagkz AS ratenaufschlagkz,
   a.zahlpauseaufschlagkz AS zahlpauseaufschlagkz,
   a.versandkostenkz AS versandkostenkz,
   a.erhversandkostenkz AS erhversandkostenkz,
   a.lieferwunschgebuehrkz AS lieferwunschgebuehrkz,
   a.personalkz AS personalkz,
   a.gratisartikelpruefungkz AS gratisartikelpruefungkz,
   a.sicherzahlkz AS sicherzahlkz,
   a.speditionkostenkz AS speditionkostenkz,
   a.lieferwunschkostenkz AS lieferwunschkostenkz,
   a.mahnstrangiddefault AS mahnstrangiddefault
FROM clsc_ww_kdart_1 a
  LEFT OUTER JOIN (SELECT sc_ww_kdartgrp.dwh_id, sc_ww_kdartgrp.id FROM sc_ww_kdartgrp)  sc_ww_kdartgrp
      ON (a.kdartgrpid = sc_ww_kdartgrp.id)
;
 
COMMIT;



PROMPT ===========================================
PROMPT  1.6 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_kdart');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_kdart_e');



PROMPT =========================================================================
PROMPT
PROMPT 2. Source Core-Ladung
PROMPT Endtabelle: sc_ww_land / sc_ww_land_ver
PROMPT
PROMPT =========================================================================



PROMPT ===========================================
PROMPT  2.1 Cleansing Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clsc_ww_land;
TRUNCATE TABLE clsc_ww_land_1;
TRUNCATE TABLE clsc_ww_land_d;
 
 
 
PROMPT ===========================================
PROMPT  2.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_land_1
(
   dwh_cr_load_id,
   landnr,
   landbez,
   landkurzbez,
   praefnr_1,
   praefnr_2,
   transferkz,
   usernr,
   aenddat,
   waehrungkurzbez,
   id,
   isocountrycode,
   vorwahl,
   natkz,
   egkz,
   waehrungid,
   inlandkz,
   fernostkz,
   benutzerid,
   zollaussenhdlsgebietid,
   steuernrbez,
   kreditbriefkz,
   iso3166num,
   geschfaehigalter,
   isocountrycode3
)
VALUES
(
   &gbvid,
   landnr,
   landbez,
   landkurzbez,
   praefnr_1,
   praefnr_2,
   transferkz,
   usernr,
   aenddat,
   waehrungkurzbez,
   id,
   isocountrycode,
   vorwahl,
   natkz,
   egkz,
   waehrungid,
   inlandkz,
   fernostkz,
   benutzerid,
   zollaussenhdlsgebietid,
   steuernrbez,
   kreditbriefkz,
   iso3166num,
   geschfaehigalter,
   isocountrycode3
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_land_d
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
   landnr,
   landbez,
   landkurzbez,
   praefnr_1,
   praefnr_2,
   transferkz,
   usernr,
   aenddat,
   waehrungkurzbez,
   id,
   isocountrycode,
   vorwahl,
   natkz,
   egkz,
   waehrungid,
   inlandkz,
   fernostkz,
   benutzerid,
   zollaussenhdlsgebietid,
   steuernrbez,
   kreditbriefkz,
   iso3166num,
   geschfaehigalter,
   isocountrycode3
FROM st_ww_land_b
WHERE dwh_processdate = &termin;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  2.3 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_land_1');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_land_d');
 
 
 
PROMPT ===========================================
PROMPT  2.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING('clsc_ww_land', 'id', &gbvid);
 
 
 
PROMPT ===========================================
PROMPT  2.5 Einspielen in die letzte SC-Tabelle mit Referenzauflösung
PROMPT ===========================================
 
INSERT /*+ APPEND */ FIRST
WHEN (dwh_id_sc_ww_waehrung IS NULL
) THEN
INTO clsc_ww_land_e
(
   dwh_cr_load_id,
   dwh_up_load_id,
   dwh_id_sc_ww_waehrung,
   landnr,
   landbez,
   landkurzbez,
   praefnr_1,
   praefnr_2,
   transferkz,
   usernr,
   aenddat,
   waehrungkurzbez,
   id,
   isocountrycode,
   vorwahl,
   natkz,
   egkz,
   waehrungid,
   inlandkz,
   fernostkz,
   benutzerid,
   zollaussenhdlsgebietid,
   steuernrbez,
   kreditbriefkz,
   iso3166num,
   geschfaehigalter,
   isocountrycode3
)
VALUES
(
   dwh_cr_load_id,
   &gbvid,
   dwh_id_sc_ww_waehrung,
   landnr,
   landbez,
   landkurzbez,
   praefnr_1,
   praefnr_2,
   transferkz,
   usernr,
   aenddat,
   waehrungkurzbez,
   id,
   isocountrycode,
   vorwahl,
   natkz,
   egkz,
   waehrungid,
   inlandkz,
   fernostkz,
   benutzerid,
   zollaussenhdlsgebietid,
   steuernrbez,
   kreditbriefkz,
   iso3166num,
   geschfaehigalter,
   isocountrycode3
)
ELSE
INTO clsc_ww_land
(
   dwh_cr_load_id,
   dwh_id_sc_ww_waehrung,
   landnr,
   landbez,
   landkurzbez,
   praefnr_1,
   praefnr_2,
   transferkz,
   usernr,
   aenddat,
   waehrungkurzbez,
   id,
   isocountrycode,
   vorwahl,
   natkz,
   egkz,
   waehrungid,
   inlandkz,
   fernostkz,
   benutzerid,
   zollaussenhdlsgebietid,
   steuernrbez,
   kreditbriefkz,
   iso3166num,
   geschfaehigalter,
   isocountrycode3
)
SELECT
   a.dwh_cr_load_id,
   sc_ww_waehrung.dwh_id AS dwh_id_sc_ww_waehrung,
   a.landnr AS landnr,
   a.landbez AS landbez,
   a.landkurzbez AS landkurzbez,
   a.praefnr_1 AS praefnr_1,
   a.praefnr_2 AS praefnr_2,
   a.transferkz AS transferkz,
   a.usernr AS usernr,
   a.aenddat AS aenddat,
   a.waehrungkurzbez AS waehrungkurzbez,
   a.id AS id,
   a.isocountrycode AS isocountrycode,
   a.vorwahl AS vorwahl,
   a.natkz AS natkz,
   a.egkz AS egkz,
   a.waehrungid AS waehrungid,
   a.inlandkz AS inlandkz,
   a.fernostkz AS fernostkz,
   a.benutzerid AS benutzerid,
   a.zollaussenhdlsgebietid AS zollaussenhdlsgebietid,
   a.steuernrbez AS steuernrbez,
   a.kreditbriefkz AS kreditbriefkz,
   a.iso3166num AS iso3166num,
   a.geschfaehigalter AS geschfaehigalter,
   a.isocountrycode3 AS isocountrycode3
FROM clsc_ww_land_1 a
  LEFT OUTER JOIN (SELECT sc_ww_waehrung.dwh_id, sc_ww_waehrung.id FROM sc_ww_waehrung)  sc_ww_waehrung
      ON (COALESCE(a.waehrungid, '$') = sc_ww_waehrung.id)
;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  2.6 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_land');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_land_e');



PROMPT =========================================================================
PROMPT
PROMPT 3. Source Core-Ladung
PROMPT Endtabelle: sc_ww_persanrede / sc_ww_persanrede_ver
PROMPT
PROMPT =========================================================================
 
 
 
PROMPT ===========================================
PROMPT  3.1 Cleansing Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clsc_ww_persanrede;
TRUNCATE TABLE clsc_ww_persanrede_1;
TRUNCATE TABLE clsc_ww_persanrede_d;
 
 
 
PROMPT ===========================================
PROMPT  3.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_persanrede_1
(
   dwh_cr_load_id,
   id,
   spracheid,
   anr,
   anrkz,
   letztaenddat
)
VALUES
(
   &gbvid,
   id,
   spracheid,
   anr,
   anrkz,
   letztaenddat
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_persanrede_d
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
   spracheid,
   anr,
   anrkz,
   letztaenddat
FROM st_ww_persanrede_b
WHERE dwh_processdate = &termin;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  3.3 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_persanrede_1');
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_persanrede_d');
 
 
 
PROMPT ===========================================
PROMPT  3.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING ('clsc_ww_persanrede', 'id', &gbvid);
 
 
 
PROMPT ===========================================
PROMPT  3.5 Einspielen in die letzte SC-Tabelle mit Referenzauflösung
PROMPT ===========================================
 
INSERT /*+ APPEND */ FIRST
WHEN (dwh_id_sc_ww_sprache IS NULL 
) THEN
INTO clsc_ww_persanrede_e
(
   dwh_cr_load_id,
   dwh_up_load_id,
   dwh_id_sc_ww_sprache,
   id,
   spracheid,
   anr,
   anrkz,
   letztaenddat
)
VALUES
(
   dwh_cr_load_id,
   &gbvid,
   dwh_id_sc_ww_sprache,
   id,
   spracheid,
   anr,
   anrkz,
   letztaenddat
)
ELSE
INTO clsc_ww_persanrede
(
   dwh_cr_load_id,
   dwh_id_sc_ww_sprache,
   id,
   spracheid,
   anr,
   anrkz,
   letztaenddat
)
SELECT
   a.dwh_cr_load_id,
   sc_ww_sprache.dwh_id AS dwh_id_sc_ww_sprache,
   a.id AS id,
   a.spracheid AS spracheid,
   a.anr AS anr,
   a.anrkz AS anrkz,
   a.letztaenddat AS letztaenddat
FROM clsc_ww_persanrede_1 a
  LEFT OUTER JOIN (SELECT sc_ww_sprache.dwh_id, sc_ww_sprache.id FROM sc_ww_sprache)  sc_ww_sprache
      ON (a.spracheid = sc_ww_sprache.id)
;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  3.6 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_persanrede');
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_persanrede_e');



PROMPT =========================================================================
PROMPT
PROMPT 4. Source Core-Ladung
PROMPT Endtabelle: sc_ww_liefauskunft / sc_ww_liefauskunft_ver
PROMPT
PROMPT =========================================================================
 
 
 
PROMPT ===========================================
PROMPT  4.1 Cleansing Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clsc_ww_liefauskunft;
TRUNCATE TABLE clsc_ww_liefauskunft_1;
TRUNCATE TABLE clsc_ww_liefauskunft_d;
 
 
 
PROMPT ===========================================
PROMPT  4.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_liefauskunft_1
(
   dwh_cr_load_id,
   id,
   bez,
   kbez,
   gueltigvondat,
   gueltigbisdat,
   hostuebkw,
   textnr,
   textkz,
   spracheid
)
VALUES
(
   &gbvid,
   id,
   bez,
   kbez,
   gueltigvondat,
   gueltigbisdat,
   hostuebkw,
   textnr,
   textkz,
   spracheid
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_liefauskunft_d
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
   kbez,
   gueltigvondat,
   gueltigbisdat,
   hostuebkw,
   textnr,
   textkz,
   spracheid
FROM st_ww_liefauskunft_b
WHERE dwh_processdate = &termin;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  4.3 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_liefauskunft_1');
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_liefauskunft_d');
 
 
 
PROMPT ===========================================
PROMPT  4.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING ('clsc_ww_liefauskunft', 'id', &gbvid);
 
 
 
PROMPT ===========================================
PROMPT  4.5 Einspielen in die letzte SC-Tabelle mit Referenzauflösung
PROMPT ===========================================
 
INSERT /*+ APPEND */ FIRST
WHEN (dwh_id_sc_ww_sprache IS NULL 
) THEN
INTO clsc_ww_liefauskunft_e
(
   dwh_cr_load_id,
   dwh_up_load_id,
   dwh_id_sc_ww_sprache,
   id,
   bez,
   kbez,
   gueltigvondat,
   gueltigbisdat,
   hostuebkw,
   textnr,
   textkz,
   spracheid
)
VALUES
(
   dwh_cr_load_id,
   &gbvid,
   dwh_id_sc_ww_sprache,
   id,
   bez,
   kbez,
   gueltigvondat,
   gueltigbisdat,
   hostuebkw,
   textnr,
   textkz,
   spracheid
)
ELSE
INTO clsc_ww_liefauskunft
(
   dwh_cr_load_id,
   dwh_id_sc_ww_sprache,
   id,
   bez,
   kbez,
   gueltigvondat,
   gueltigbisdat,
   hostuebkw,
   textnr,
   textkz,
   spracheid
)
SELECT
   a.dwh_cr_load_id,
   sc_ww_sprache.dwh_id AS dwh_id_sc_ww_sprache,
   a.id AS id,
   a.bez AS bez,
   a.kbez AS kbez,
   a.gueltigvondat AS gueltigvondat,
   a.gueltigbisdat AS gueltigbisdat,
   a.hostuebkw AS hostuebkw,
   a.textnr AS textnr,
   a.textkz AS textkz,
   a.spracheid AS spracheid
FROM clsc_ww_liefauskunft_1 a
  LEFT OUTER JOIN (SELECT sc_ww_sprache.dwh_id, sc_ww_sprache.id FROM sc_ww_sprache)  sc_ww_sprache
      ON (a.spracheid = sc_ww_sprache.id)
;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  4.6 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_liefauskunft');
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_liefauskunft_e');



PROMPT =========================================================================
PROMPT
PROMPT 5. Source Core-Ladung
PROMPT Endtabelle: sc_ww_vertrgebietgruppe / sc_ww_vertrgebietgruppe_ver
PROMPT
PROMPT =========================================================================
 
 
 
PROMPT ===========================================
PROMPT  5.1 Cleansing Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clsc_ww_vertrgebietgruppe;
TRUNCATE TABLE clsc_ww_vertrgebietgruppe_1;
TRUNCATE TABLE clsc_ww_vertrgebietgruppe_d;
 
 
 
PROMPT ===========================================
PROMPT  5.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_vertrgebietgruppe_1
(
   dwh_cr_load_id,
   id,
   gruppenname,
   kurzbez,
   sortkz,
   anldat,
   letztaenddat,
   benutzeridanl,
   benutzeridletztaend
)
VALUES
(
   &gbvid,
   id,
   gruppenname,
   kurzbez,
   sortkz,
   anldat,
   letztaenddat,
   benutzeridanl,
   benutzeridletztaend
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_vertrgebietgruppe_d
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
   gruppenname,
   kurzbez,
   sortkz,
   anldat,
   letztaenddat,
   benutzeridanl,
   benutzeridletztaend
FROM st_ww_vertrgebietgruppe_b
WHERE dwh_processdate = &termin;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  5.3 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_vertrgebietgruppe_1');
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_vertrgebietgruppe_d');
 
 
 
PROMPT ===========================================
PROMPT  5.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING ('clsc_ww_vertrgebietgruppe', 'id', &gbvid);
 
 
 
PROMPT ===========================================
PROMPT  5.5 Einspielen in die letzte SC-Tabelle mit Referenzauflösung
PROMPT ===========================================
 
INSERT /*+ APPEND */ FIRST
WHEN (dwh_id_sc_ww_benutzererri IS NULL 
   OR dwh_id_sc_ww_benutzeraend IS NULL 
) THEN
INTO clsc_ww_vertrgebietgruppe_e
(
   dwh_cr_load_id,
   dwh_up_load_id,
   dwh_id_sc_ww_benutzererri,
   dwh_id_sc_ww_benutzeraend,
   id,
   gruppenname,
   kurzbez,
   sortkz,
   anldat,
   letztaenddat,
   benutzeridanl,
   benutzeridletztaend
)
VALUES
(
   dwh_cr_load_id,
   &gbvid,
   dwh_id_sc_ww_benutzererri,
   dwh_id_sc_ww_benutzeraend,
   id,
   gruppenname,
   kurzbez,
   sortkz,
   anldat,
   letztaenddat,
   benutzeridanl,
   benutzeridletztaend
)
ELSE
INTO clsc_ww_vertrgebietgruppe
(
   dwh_cr_load_id,
   dwh_id_sc_ww_benutzererri,
   dwh_id_sc_ww_benutzeraend,
   id,
   gruppenname,
   kurzbez,
   sortkz,
   anldat,
   letztaenddat,
   benutzeridanl,
   benutzeridletztaend
)
SELECT
   a.dwh_cr_load_id,
   sc_ww_benutzererri.dwh_id AS dwh_id_sc_ww_benutzererri,
   sc_ww_benutzeraend.dwh_id AS dwh_id_sc_ww_benutzeraend,
   a.id AS id,
   a.gruppenname AS gruppenname,
   a.kurzbez AS kurzbez,
   a.sortkz AS sortkz,
   a.anldat AS anldat,
   a.letztaenddat AS letztaenddat,
   a.benutzeridanl AS benutzeridanl,
   a.benutzeridletztaend AS benutzeridletztaend
FROM clsc_ww_vertrgebietgruppe_1 a
  LEFT OUTER JOIN (SELECT sc_ww_benutzererri.dwh_id, sc_ww_benutzererri.id FROM sc_ww_benutzererri)  sc_ww_benutzererri
      ON (a.benutzeridanl = sc_ww_benutzererri.id)
  LEFT OUTER JOIN (SELECT sc_ww_benutzeraend.dwh_id, sc_ww_benutzeraend.id FROM sc_ww_benutzeraend)  sc_ww_benutzeraend
      ON (COALESCE(a.benutzeridletztaend, '$') = sc_ww_benutzeraend.id)
;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  5.6 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_vertrgebietgruppe');
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_vertrgebietgruppe_e');



PROMPT =========================================================================
PROMPT
PROMPT 6. Source Core-Ladung
PROMPT Endtabelle: sc_ww_marktkz / sc_ww_marktkz_ver
PROMPT
PROMPT =========================================================================
 
 
 
PROMPT ===========================================
PROMPT  6.1 Cleansing Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clsc_ww_marktkz;
TRUNCATE TABLE clsc_ww_marktkz_1;
TRUNCATE TABLE clsc_ww_marktkz_d;
 
 
 
PROMPT ===========================================
PROMPT  6.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_marktkz_1
(
   dwh_cr_load_id,
   marktkz,
   marktkzbez,
   marktkzov,
   id,
   merkmalklnr,
   marktkzgeschlechtid,
   marktkzalterid,
   verpantkunst,
   verpantpappe,
   tabletemplateid,
   produktgrpov,
   benutzeriderri,
   erridat,
   benutzeridaend,
   aenddat,
   iproductskz,
   marketingcodeusa,
   labeldruckfaktorusa,
   marktkzbezeng,
   zollwert,
   gppflegemkz
)
VALUES
(
   &gbvid,
   marktkz,
   marktkzbez,
   marktkzov,
   id,
   merkmalklnr,
   marktkzgeschlechtid,
   marktkzalterid,
   verpantkunst,
   verpantpappe,
   tabletemplateid,
   produktgrpov,
   benutzeriderri,
   erridat,
   benutzeridaend,
   aenddat,
   iproductskz,
   marketingcodeusa,
   labeldruckfaktorusa,
   marktkzbezeng,
   zollwert,
   gppflegemkz
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_marktkz_d
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
   marktkz,
   marktkzbez,
   marktkzov,
   id,
   merkmalklnr,
   marktkzgeschlechtid,
   marktkzalterid,
   verpantkunst,
   verpantpappe,
   tabletemplateid,
   produktgrpov,
   benutzeriderri,
   erridat,
   benutzeridaend,
   aenddat,
   iproductskz,
   marketingcodeusa,
   labeldruckfaktorusa,
   marktkzbezeng,
   zollwert,
   gppflegemkz
FROM st_ww_marktkz_b
WHERE dwh_processdate = &termin;
 
COMMIT;



PROMPT ===========================================
PROMPT  6.3 Daten aus SC-Tabelle laden für geänderte Datensätze in Marktkz-Zuordnung
PROMPT ===========================================

MERGE INTO clsc_ww_marktkz_1 a
USING (SELECT &gbvid,
   v.marktkz,
   v.marktkzbez,
   v.marktkzov,
   h.id,
   v.merkmalklnr,
   v.marktkzgeschlechtid,
   v.marktkzalterid,
   v.verpantkunst,
   v.verpantpappe,
   v.tabletemplateid,
   v.produktgrpov,
   v.benutzeriderri,
   v.erridat,
   v.benutzeridaend,
   v.aenddat,
   v.iproductskz,
   v.marketingcodeusa,
   v.labeldruckfaktorusa,
   v.marktkzbezeng,
   v.zollwert,
   v.gppflegemkz
FROM sc_ww_marktkz h JOIN sc_ww_marktkz_ver v
ON (h.dwh_id = v.dwh_id_head AND v.dwh_valid_to = TO_DATE ('31.12.9999','dd.mm.rrrr'))
JOIN st_ww_marktkz_zuord_b sb
ON (sb.dwh_processdate = &termin AND sb.dwh_stbflag IN ('N','U') AND sb.marktkzid = h.id)
) b
ON (a.id = b.id)
WHEN NOT MATCHED THEN INSERT
(
   dwh_cr_load_id,
   marktkz,
   marktkzbez,
   marktkzov,
   id,
   merkmalklnr,
   marktkzgeschlechtid,
   marktkzalterid,
   verpantkunst,
   verpantpappe,
   tabletemplateid,
   produktgrpov,
   benutzeriderri,
   erridat,
   benutzeridaend,
   aenddat,
   iproductskz,
   marketingcodeusa,
   labeldruckfaktorusa,
   marktkzbezeng,
   zollwert,
   gppflegemkz
)
VALUES
  (&gbvid,
   b.marktkz,
   b.marktkzbez,
   b.marktkzov,
   b.id,
   b.merkmalklnr,
   b.marktkzgeschlechtid,
   b.marktkzalterid,
   b.verpantkunst,
   b.verpantpappe,
   b.tabletemplateid,
   b.produktgrpov,
   b.benutzeriderri,
   b.erridat,
   b.benutzeridaend,
   b.aenddat,
   b.iproductskz,
   b.marketingcodeusa,
   b.labeldruckfaktorusa,
   b.marktkzbezeng,
   b.zollwert,
   b.gppflegemkz
);
   
COMMIT;
 

 
PROMPT ===========================================
PROMPT  6.4 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_marktkz_1');
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_marktkz_d');
 
 
 
PROMPT ===========================================
PROMPT  6.5 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING ('clsc_ww_marktkz', 'id', &gbvid);
 
 
 
PROMPT ===========================================
PROMPT  6.6 Einspielen in die letzte SC-Tabelle mit Referenzauflösung
PROMPT ===========================================
 
INSERT /*+ APPEND */ FIRST
WHEN (dwh_id_sc_ww_merkmalklasse IS NULL
   OR dwh_id_sc_ww_marktkzgeschlecht IS NULL
   OR dwh_id_sc_ww_marktkzalter IS NULL 
   OR dwh_id_sc_ww_benutzererri IS NULL 
   OR dwh_id_sc_ww_benutzeraend IS NULL 
   OR dwh_id_sc_ww_gppflegemkz IS NULL   
) THEN
INTO clsc_ww_marktkz_e
(
   dwh_cr_load_id,
   dwh_up_load_id,
   dwh_id_sc_ww_merkmalklasse,
   dwh_id_sc_ww_marktkzgeschlecht,
   dwh_id_sc_ww_marktkzalter,
   dwh_id_sc_ww_benutzererri,
   dwh_id_sc_ww_benutzeraend,
   dwh_id_sc_ww_gppflegemkz,   
   marktkz,
   marktkzbez,
   marktkzov,
   id,
   merkmalklnr,
   marktkzgeschlechtid,
   marktkzalterid,
   verpantkunst,
   verpantpappe,
   tabletemplateid,
   produktgrpov,
   benutzeriderri,
   erridat,
   benutzeridaend,
   aenddat,
   iproductskz,
   marketingcodeusa,
   labeldruckfaktorusa,
   marktkzbezeng,
   zollwert,
   gppflegemkz
)
VALUES
(
   dwh_cr_load_id,
   &gbvid,
   dwh_id_sc_ww_merkmalklasse,
   dwh_id_sc_ww_marktkzgeschlecht,
   dwh_id_sc_ww_marktkzalter,
   dwh_id_sc_ww_benutzererri,
   dwh_id_sc_ww_benutzeraend,
   dwh_id_sc_ww_gppflegemkz,
   marktkz,
   marktkzbez,
   marktkzov,
   id,
   merkmalklnr,
   marktkzgeschlechtid,
   marktkzalterid,
   verpantkunst,
   verpantpappe,
   tabletemplateid,
   produktgrpov,
   benutzeriderri,
   erridat,
   benutzeridaend,
   aenddat,
   iproductskz,
   marketingcodeusa,
   labeldruckfaktorusa,
   marktkzbezeng,
   zollwert,
   gppflegemkz
)
ELSE
INTO clsc_ww_marktkz
(
   dwh_cr_load_id,
   dwh_id_sc_ww_merkmalklasse,
   dwh_id_sc_ww_marktkzgeschlecht,
   dwh_id_sc_ww_marktkzalter,
   dwh_id_sc_ww_benutzererri,
   dwh_id_sc_ww_benutzeraend,
   dwh_id_sc_ww_gppflegemkz,
   marktkz,
   marktkzbez,
   marktkzov,
   id,
   merkmalklnr,
   marktkzgeschlechtid,
   marktkzalterid,
   verpantkunst,
   verpantpappe,
   tabletemplateid,
   produktgrpov,
   benutzeriderri,
   erridat,
   benutzeridaend,
   aenddat,
   iproductskz,
   marketingcodeusa,
   labeldruckfaktorusa,
   marktkzbezeng,
   zollwert,
   gppflegemkz
)
SELECT
   a.dwh_cr_load_id,
   sc_ww_merkmalklasse.dwh_id AS dwh_id_sc_ww_merkmalklasse,
   sc_ww_marktkzgeschlecht.dwh_id AS dwh_id_sc_ww_marktkzgeschlecht,
   sc_ww_marktkzalter.dwh_id AS dwh_id_sc_ww_marktkzalter,
   sc_ww_benutzererri.dwh_id AS dwh_id_sc_ww_benutzererri,
   sc_ww_benutzeraend.dwh_id AS dwh_id_sc_ww_benutzeraend,
   sc_ww_gppflegemkz.dwh_id AS dwh_id_sc_ww_gppflegemkz,
   a.marktkz AS marktkz,
   a.marktkzbez AS marktkzbez,
   a.marktkzov AS marktkzov,
   a.id AS id,
   a.merkmalklnr AS merkmalklnr,
   a.marktkzgeschlechtid AS marktkzgeschlechtid,
   a.marktkzalterid AS marktkzalterid,
   a.verpantkunst AS verpantkunst,
   a.verpantpappe AS verpantpappe,
   a.tabletemplateid AS tabletemplateid,
   a.produktgrpov AS produktgrpov,
   a.benutzeriderri AS benutzeriderri,
   a.erridat AS erridat,
   a.benutzeridaend AS benutzeridaend,
   a.aenddat AS aenddat,
   a.iproductskz AS iproductskz,
   a.marketingcodeusa AS marketingcodeusa,
   a.labeldruckfaktorusa AS labeldruckfaktorusa,
   a.marktkzbezeng AS marktkzbezeng,
   a.zollwert AS zollwert,
   a.gppflegemkz AS gppflegemkz
FROM clsc_ww_marktkz_1 a
  LEFT OUTER JOIN (SELECT sc_ww_merkmalklasse.dwh_id, sc_ww_merkmalklasse.merkmalklnr FROM sc_ww_merkmalklasse) sc_ww_merkmalklasse
      ON (COALESCE(a.merkmalklnr, -3) = sc_ww_merkmalklasse.merkmalklnr)
  LEFT OUTER JOIN (SELECT sc_ww_marktkzgeschlecht.dwh_id, sc_ww_marktkzgeschlecht.id FROM sc_ww_marktkzgeschlecht)  sc_ww_marktkzgeschlecht
      ON (COALESCE(a.marktkzgeschlechtid, '$') = sc_ww_marktkzgeschlecht.id)
  LEFT OUTER JOIN (SELECT sc_ww_marktkzalter.dwh_id, sc_ww_marktkzalter.id FROM sc_ww_marktkzalter)  sc_ww_marktkzalter
      ON (COALESCE(a.marktkzalterid, '$') = sc_ww_marktkzalter.id)
  LEFT OUTER JOIN (SELECT sc_ww_benutzererri.dwh_id, sc_ww_benutzererri.id FROM sc_ww_benutzererri)  sc_ww_benutzererri
      ON (COALESCE(a.benutzeriderri, '$') = sc_ww_benutzererri.id)
  LEFT OUTER JOIN (SELECT sc_ww_benutzeraend.dwh_id, sc_ww_benutzeraend.id FROM sc_ww_benutzeraend)  sc_ww_benutzeraend
      ON (COALESCE(a.benutzeridaend, '$') = sc_ww_benutzeraend.id)
  LEFT OUTER JOIN (SELECT sc_ww_gppflegemkz.dwh_id, sc_ww_gppflegemkz.wert FROM sc_ww_gppflegemkz)  sc_ww_gppflegemkz
      ON (COALESCE(a.gppflegemkz, -3) = sc_ww_gppflegemkz.wert)      
;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  6.7 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_marktkz');
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_marktkz_e');



PROMPT =========================================================================
PROMPT
PROMPT 7. Source Core-Ladung
PROMPT Endtabelle: sc_ww_et_direktor / sc_ww_et_direktor_ver
PROMPT
PROMPT =========================================================================
 
 
 
PROMPT ===========================================
PROMPT  7.1 Cleansing Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clsc_ww_et_direktor;
TRUNCATE TABLE clsc_ww_et_direktor_1;
TRUNCATE TABLE clsc_ww_et_direktor_d;
 
 
 
PROMPT ===========================================
PROMPT  7.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_et_direktor_1
(
   dwh_cr_load_id,
   saison,
   etdirnr,
   etdirbez,
   etvorstandnr,
   firmkz
)
VALUES
(
   &gbvid,
   saison,
   etdirnr,
   etdirbez,
   etvorstandnr,
   firmkz
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_et_direktor_d
(
   dwh_cr_load_id,
   saison,
   etdirnr
)
VALUES
(
   &gbvid,
   saison,
   etdirnr
)
SELECT
   dwh_stbflag,
   saison,
   etdirnr,
   etdirbez,
   etvorstandnr,
   firmkz
FROM st_ww_et_direktor_b
WHERE dwh_processdate = &termin;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  7.3 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_et_direktor_1');
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_et_direktor_d');
 
 
 
PROMPT ===========================================
PROMPT  7.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING ('clsc_ww_et_direktor', 'saison, etdirnr', &gbvid);
 
 
 
PROMPT ===========================================
PROMPT  7.5 Einspielen in die letzte SC-Tabelle mit Referenzauflösung
PROMPT ===========================================
 
INSERT /*+ APPEND */ FIRST
WHEN (dwh_id_sc_ww_eksaison IS NULL 
   OR dwh_id_sc_ww_et_vorstand IS NULL
   OR dwh_id_sc_ww_bestandsfirma IS NULL
) THEN
INTO clsc_ww_et_direktor_e
(
   dwh_cr_load_id,
   dwh_up_load_id,
   dwh_id_sc_ww_eksaison,
   dwh_id_sc_ww_et_vorstand,
   dwh_id_sc_ww_bestandsfirma,
   saison,
   etdirnr,
   etdirbez,
   etvorstandnr,
   firmkz
)
VALUES
(
   dwh_cr_load_id,
   &gbvid,
   dwh_id_sc_ww_eksaison,
   dwh_id_sc_ww_et_vorstand,
   dwh_id_sc_ww_bestandsfirma,
   saison,
   etdirnr,
   etdirbez,
   etvorstandnr,
   firmkz
)
ELSE
INTO clsc_ww_et_direktor
(
   dwh_cr_load_id,
   dwh_id_sc_ww_eksaison,
   dwh_id_sc_ww_et_vorstand,
   dwh_id_sc_ww_bestandsfirma,
   saison,
   etdirnr,
   etdirbez,
   etvorstandnr,
   firmkz
)
SELECT
   a.dwh_cr_load_id,
   sc_ww_eksaison.dwh_id AS dwh_id_sc_ww_eksaison,
   sc_ww_et_vorstand.dwh_id AS dwh_id_sc_ww_et_vorstand,
   sc_ww_bestandsfirma.dwh_id AS dwh_id_sc_ww_bestandsfirma,
   a.saison AS saison,
   a.etdirnr AS etdirnr,
   a.etdirbez AS etdirbez,
   a.etvorstandnr AS etvorstandnr,
   a.firmkz AS firmkz
FROM clsc_ww_et_direktor_1 a
  LEFT OUTER JOIN (SELECT sc_ww_eksaison.dwh_id, sc_ww_eksaison.wert FROM sc_ww_eksaison) sc_ww_eksaison
      ON (a.saison = sc_ww_eksaison.wert)
  LEFT OUTER JOIN (SELECT sc_ww_et_vorstand.dwh_id, sc_ww_et_vorstand.saison, sc_ww_et_vorstand.etvorstandnr FROM sc_ww_et_vorstand) sc_ww_et_vorstand
      ON (a.saison = sc_ww_et_vorstand.saison AND a.etvorstandnr = sc_ww_et_vorstand.etvorstandnr)
  LEFT OUTER JOIN (SELECT K1.dwh_id, V1.firmkz
                   FROM sc_ww_bestandsfirma K1 JOIN sc_ww_bestandsfirma_ver V1
                   ON (K1.dwh_id = V1.dwh_id_head AND &termin BETWEEN V1.dwh_valid_from AND V1.dwh_valid_to)) sc_ww_bestandsfirma
      ON (COALESCE(a.firmkz, -3) = sc_ww_bestandsfirma.firmkz)
;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  7.6 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_et_direktor');
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_et_direktor_e');