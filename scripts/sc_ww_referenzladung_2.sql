/*******************************************************************************

Job:                  sc_ww_referenzladung_2
Beschreibung:         Job lädt Referenzen. Verwendete Referenzen im nDWH werden 
                      über die Job's sc_ww_referenzladung_1, sc_ww_referenzladung_2, 
                      sc_ww_referenzladung_3, sc_ww_referenzladung_4,
                      sc_ww_referenzladung_5 und sc_ww_referenzladung_6 geladen.
                      Alle sonstigen Referenzen werden über den Job sc_ww_referenzladung_sonst 
                      geladen, solange, bis sie in einer neuen Ladestrecke verwendet werden.
          
Erstellt am:          24.10.2017
Erstellt von:         stegrs       
Ansprechpartner:      stegrs, joeabd    
Ansprechpartner-IT: -

verwendete Tabellen:  st_ww_benutzer_b 
                      st_ww_verpackungstyp_b
                      st_ww_et_vorstand_b
                      st_ww_fg_b

Endtabellen:          sc_ww_benutzer / sc_ww_benutzer_ver
                      sc_ww_verpackungstyp / sc_ww_verpackungstyp_ver
                      sc_ww_et_vorstand / sc_ww_et_vorstand_ver
                      sc_ww_fg / sc_ww_fg_ver

Fehler-Doku:      -
Ladestrecke:      -

********************************************************************************
geändert am:          2017-10-25
geändert von:         stegrs
Änderungen:           ##.1: COALESCE für Auflösung Benutzer zu Personal hinzugefügt

geändert am:          2018-02-13
geändert von:         stegrs
Änderungen:           ##.2: Tabelle VERPACKUNGSTYP hinzugefügt

geändert am:          2018-07-10
geändert von:         stegrs
Änderungen:           ##.3: Tabelle ET_VORSTAND hinzugefügt

geändert am:          2018-07-10
geändert von:         stegrs
Änderungen:           ##.4: Tabelle ET_VORSTAND: Verweis von Saison zu Eksaison

geändert am:          2018-10-24
geändert von:         stegrs
Änderungen:           ##.5: Tabelle FG hinzugefügt

geändert am:          2018-10-24
geändert von:         stegrs
Änderungen:           ##.6: Tabelle FG: Referenzauflösung zu FGTYP hinzugefügt

geändert am:          2018-12-20
geändert von:         stegrs
Änderungen:           ##.7: Tabelle FG um Spalten erweitert

geändert am:          2019-12-18
geändert von:         svehoc
Änderungen:           ##.8: Umzug auf UDWH1

geändert am:          12.04.2021
geändert von:         sanklo
Änderungen:           ##.9: Tabelle FG ins KDWH verschoben, da die KUNDEID
                      auch für das FG verschlüsselt werden muss.
                      --> Siehe Job st_ww_referenzladung_dp im KDWH 
                      --> Startbedingung angepasst
                      --> kundeid in kundeid_key geändert
                 
geändert am:          14.04.2021
geändert von:         sanklo
Änderungen:           ##.10: weitere Referenzen für Tabelle FG aufgebaut und 
                      Referenzaulösungen eingebaut
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
PROMPT Endtabelle: sc_ww_benutzer / sc_ww_benutzer_ver
PROMPT
PROMPT =========================================================================



PROMPT ===========================================
PROMPT  1.1 Cleansing Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clsc_ww_benutzer;
TRUNCATE TABLE clsc_ww_benutzer_1;
TRUNCATE TABLE clsc_ww_benutzer_d;
 
 
 
PROMPT ===========================================
PROMPT  1.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_benutzer_1
(
   dwh_cr_load_id,
   id,
   vname,
   nname,
   anr,
   telnr,
   faxnr,
   str,
   plz,
   ort,
   ou,
   email,
   bednr,
   verknr,
   sbvnrber,
   abt,
   ber,
   anrkz,
   aktivkz,
   kostenstelleid,
   dn,
   accountname,
   guid,
   lfdnr,
   personalid
)
VALUES
(
   &gbvid,
   id,
   vname,
   nname,
   anr,
   telnr,
   faxnr,
   str,
   plz,
   ort,
   ou,
   email,
   bednr,
   verknr,
   sbvnrber,
   abt,
   ber,
   anrkz,
   aktivkz,
   kostenstelleid,
   dn,
   accountname,
   guid,
   lfdnr,
   personalid
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_benutzer_d
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
   vname,
   nname,
   anr,
   telnr,
   faxnr,
   str,
   plz,
   ort,
   ou,
   email,
   bednr,
   verknr,
   sbvnrber,
   abt,
   ber,
   anrkz,
   aktivkz,
   kostenstelleid,
   dn,
   accountname,
   guid,
   lfdnr,
   personalid
FROM st_ww_benutzer_b
WHERE dwh_processdate = &termin;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  1.3 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_benutzer_1');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_benutzer_d');
 
 
 
PROMPT ===========================================
PROMPT  1.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING('clsc_ww_benutzer', 'id', &gbvid);
 
 
 
PROMPT ===========================================
PROMPT  1.5 Einspielen in die letzte SC-Tabelle mit Referenzauflösung
PROMPT ===========================================
 
INSERT /*+ APPEND */ FIRST
WHEN (dwh_id_sc_ww_personal IS NULL
) THEN
INTO clsc_ww_benutzer_e
(
   dwh_cr_load_id,
   dwh_up_load_id,
   dwh_id_sc_ww_personal,
   id,
   vname,
   nname,
   anr,
   telnr,
   faxnr,
   str,
   plz,
   ort,
   ou,
   email,
   bednr,
   verknr,
   sbvnrber,
   abt,
   ber,
   anrkz,
   aktivkz,
   kostenstelleid,
   dn,
   accountname,
   guid,
   lfdnr,
   personalid
)
VALUES
(
   dwh_cr_load_id,
   &gbvid,
   dwh_id_sc_ww_personal,
   id,
   vname,
   nname,
   anr,
   telnr,
   faxnr,
   str,
   plz,
   ort,
   ou,
   email,
   bednr,
   verknr,
   sbvnrber,
   abt,
   ber,
   anrkz,
   aktivkz,
   kostenstelleid,
   dn,
   accountname,
   guid,
   lfdnr,
   personalid
)
ELSE
INTO clsc_ww_benutzer
(
   dwh_cr_load_id,
   dwh_id_sc_ww_personal,
   id,
   vname,
   nname,
   anr,
   telnr,
   faxnr,
   str,
   plz,
   ort,
   ou,
   email,
   bednr,
   verknr,
   sbvnrber,
   abt,
   ber,
   anrkz,
   aktivkz,
   kostenstelleid,
   dn,
   accountname,
   guid,
   lfdnr,
   personalid
)
SELECT
   a.dwh_cr_load_id,
   sc_ww_personal.dwh_id AS dwh_id_sc_ww_personal,
   a.id,
   a.vname,
   a.nname,
   a.anr,
   a.telnr,
   a.faxnr,
   a.str,
   a.plz,
   a.ort,
   a.ou,
   a.email,
   a.bednr,
   a.verknr,
   a.sbvnrber,
   a.abt,
   a.ber,
   COALESCE(a.anrkz, '$') as anrkz,
   COALESCE(a.aktivkz, '$') as aktivkz,
   a.kostenstelleid,
   a.dn,
   a.accountname,
   a.guid,
   a.lfdnr,
   a.personalid
FROM clsc_ww_benutzer_1 a
  LEFT OUTER JOIN (SELECT sc_ww_personal.dwh_id, sc_ww_personal.id FROM sc_ww_personal)  sc_ww_personal
      ON (COALESCE(a.personalid, '$') = sc_ww_personal.id)
;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  1.6 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_benutzer');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_benutzer_e');



PROMPT =========================================================================
PROMPT
PROMPT 2. Source Core-Ladung
PROMPT Endtabelle: sc_ww_verpackungstyp / sc_ww_verpackungstyp_ver
PROMPT
PROMPT =========================================================================



PROMPT ===========================================
PROMPT  2.1 Cleansing Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clsc_ww_verpackungstyp;
TRUNCATE TABLE clsc_ww_verpackungstyp_1;
TRUNCATE TABLE clsc_ww_verpackungstyp_d;
 
 
 
PROMPT ===========================================
PROMPT  2.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_verpackungstyp_1
(
   dwh_cr_load_id,
   id,
   art,
   typ,
   laenge,
   breite,
   hoehe,
   gew,
   volos,
   vollo,
   bez,
   kurzbez,
   verwkz,
   volfgsoko,
   aktivkz,
   maxbruttogewicht,
   verpackungstyp_verwendungid
)
VALUES
(
   &gbvid,
   id,
   art,
   typ,
   laenge,
   breite,
   hoehe,
   gew,
   volos,
   vollo,
   bez,
   kurzbez,
   verwkz,
   volfgsoko,
   aktivkz,
   maxbruttogewicht,
   verpackungstyp_verwendungid
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_verpackungstyp_d
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
   art,
   typ,
   laenge,
   breite,
   hoehe,
   gew,
   volos,
   vollo,
   bez,
   kurzbez,
   verwkz,
   volfgsoko,
   aktivkz,
   maxbruttogewicht,
   verpackungstyp_verwendungid
FROM st_ww_verpackungstyp_b
WHERE dwh_processdate = &termin;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  2.3 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_verpackungstyp_1');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_verpackungstyp_d');
 
 
 
PROMPT ===========================================
PROMPT  2.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING('clsc_ww_verpackungstyp', 'id', &gbvid);
 
 
 
PROMPT ===========================================
PROMPT  2.5 Einspielen in die letzte SC-Tabelle mit Referenzauflösung
PROMPT ===========================================
 
INSERT /*+ APPEND */ FIRST
WHEN (dwh_id_sc_ww_verpackungstyp_verw IS NULL
) THEN
INTO clsc_ww_verpackungstyp_e
(
   dwh_cr_load_id,
   dwh_up_load_id,
   dwh_id_sc_ww_verpackungstyp_verw,
   id,
   art,
   typ,
   laenge,
   breite,
   hoehe,
   gew,
   volos,
   vollo,
   bez,
   kurzbez,
   verwkz,
   volfgsoko,
   aktivkz,
   maxbruttogewicht,
   verpackungstyp_verwendungid
)
VALUES
(
   dwh_cr_load_id,
   &gbvid,
   dwh_id_sc_ww_verpackungstyp_verw,
   id,
   art,
   typ,
   laenge,
   breite,
   hoehe,
   gew,
   volos,
   vollo,
   bez,
   kurzbez,
   verwkz,
   volfgsoko,
   aktivkz,
   maxbruttogewicht,
   verpackungstyp_verwendungid
)
ELSE
INTO clsc_ww_verpackungstyp
(
   dwh_cr_load_id,
   dwh_id_sc_ww_verpackungstyp_verw,
   id,
   art,
   typ,
   laenge,
   breite,
   hoehe,
   gew,
   volos,
   vollo,
   bez,
   kurzbez,
   verwkz,
   volfgsoko,
   aktivkz,
   maxbruttogewicht,
   verpackungstyp_verwendungid
)
SELECT
   a.dwh_cr_load_id,
   sc_ww_verpackungstyp_verw.dwh_id AS dwh_id_sc_ww_verpackungstyp_verw,
   a.id,
   a.art,
   a.typ,
   a.laenge,
   a.breite,
   a.hoehe,
   a.gew,
   a.volos,
   a.vollo,
   a.bez,
   a.kurzbez,
   a.verwkz,
   a.volfgsoko,
   a.aktivkz,
   a.maxbruttogewicht,
   a.verpackungstyp_verwendungid
FROM clsc_ww_verpackungstyp_1 a
  LEFT OUTER JOIN (SELECT sc_ww_verpackungstyp_verw.dwh_id, sc_ww_verpackungstyp_verw.id FROM sc_ww_verpackungstyp_verw) sc_ww_verpackungstyp_verw
      ON (COALESCE(a.verpackungstyp_verwendungid, '$') = sc_ww_verpackungstyp_verw.id)
;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  2.6 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_verpackungstyp');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_verpackungstyp_e');



PROMPT =========================================================================
PROMPT
PROMPT 3. Source Core-Ladung
PROMPT Endtabelle: sc_ww_et_vorstand / sc_ww_et_vorstand_ver
PROMPT
PROMPT =========================================================================
 
 
 
PROMPT ===========================================
PROMPT  3.1 Cleansing Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clsc_ww_et_vorstand;
TRUNCATE TABLE clsc_ww_et_vorstand_1;
TRUNCATE TABLE clsc_ww_et_vorstand_d;
 
 
 
PROMPT ===========================================
PROMPT  3.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_et_vorstand_1
(
   dwh_cr_load_id,
   saison,
   etvorstandnr,
   etvorstandbez
)
VALUES
(
   &gbvid,
   saison,
   etvorstandnr,
   etvorstandbez
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_et_vorstand_d
(
   dwh_cr_load_id,
   saison,
   etvorstandnr
)
VALUES
(
   &gbvid,
   saison,
   etvorstandnr
)
SELECT
   dwh_stbflag,
   saison,
   etvorstandnr,
   etvorstandbez
FROM st_ww_et_vorstand_b
WHERE dwh_processdate = &termin;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  3.3 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_et_vorstand_1');
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_et_vorstand_d');
 
 
 
PROMPT ===========================================
PROMPT  3.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING ('clsc_ww_et_vorstand', 'saison, etvorstandnr', &gbvid);
 
 
 
PROMPT ===========================================
PROMPT  3.5 Einspielen in die letzte SC-Tabelle mit Referenzauflösung
PROMPT ===========================================
 
INSERT /*+ APPEND */ FIRST
WHEN (dwh_id_sc_ww_eksaison IS NULL 
) THEN
INTO clsc_ww_et_vorstand_e
(
   dwh_cr_load_id,
   dwh_up_load_id,
   dwh_id_sc_ww_eksaison,
   saison,
   etvorstandnr,
   etvorstandbez
)
VALUES
(
   dwh_cr_load_id,
   &gbvid,
   dwh_id_sc_ww_eksaison,
   saison,
   etvorstandnr,
   etvorstandbez
)
ELSE
INTO clsc_ww_et_vorstand
(
   dwh_cr_load_id,
   dwh_id_sc_ww_eksaison,
   saison,
   etvorstandnr,
   etvorstandbez
)
SELECT
   a.dwh_cr_load_id,
   sc_ww_eksaison.dwh_id AS dwh_id_sc_ww_eksaison,
   a.saison AS saison,
   a.etvorstandnr AS etvorstandnr,
   a.etvorstandbez AS etvorstandbez
FROM clsc_ww_et_vorstand_1 a
  LEFT OUTER JOIN (SELECT sc_ww_eksaison.dwh_id, sc_ww_eksaison.wert FROM sc_ww_eksaison) sc_ww_eksaison
      ON (a.saison = sc_ww_eksaison.wert)
;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  3.6 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_et_vorstand');
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_et_vorstand_e');



PROMPT =========================================================================
PROMPT
PROMPT 4. Source Core-Ladung
PROMPT Endtabelle: sc_ww_fg / sc_ww_fg_ver
PROMPT
PROMPT =========================================================================
 
 
 
PROMPT ===========================================
PROMPT  4.1 Cleansing Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clsc_ww_fg;
TRUNCATE TABLE clsc_ww_fg_1;
TRUNCATE TABLE clsc_ww_fg_d;
 
 
 
PROMPT ===========================================
PROMPT  4.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_fg_1
(
   dwh_cr_load_id,
   fgnr,
   fgbez,
   kfznr,
   fgtyp,
   werbetextnr,
   firmkz,
   id,
   gueltig_ab,
   gueltig_bis,
   bundesland,
   offenzeit,
   sonderoffenzeit,
   sonderoffenzeitkz,
   aktivkz,
   kundeid_key,
   konto_id_key,
   testfgkz,
   invkz,
   invzeitraumstart,
   invzeitraumende,
   invsollbd,
   invstichtag,
   busgruppekz,
   profitcenternr,
   profitcenterid,
   ware1b,
   ware1babgrenzvon,
   ware1babgrenzbis,
   laengengrad,
   breitengrad,
   bundeslandid,
   kostenstelle,
   kostenstelleid,
   fgstatusid,
   landid,
   filialleiterid,
   vertriebsleiterid,
   bauleiterid,
   pinkz,
   anzkassen,
   kurzwahl,
   hermesdepot,
   bemerkung,
   mdebuchungvon,
   mdebuchungbis,
   kreditkartenkz,
   internetvon,
   internetbis,
   inveinspielung,
   zentrwarenauszvon,
   zentrwarenauszbis,
   fgliefanschridzentrwarenausz,
   mobilverkaufkz,
   psvzeitraumvon, 
   psvzeitraumbis, 
   psvrabattsatz, 
   psvbemerkung,
   autoumlagerungkz,
   firma
)
VALUES
(
   &gbvid,
   fgnr,
   fgbez,
   kfznr,
   fgtyp,
   werbetextnr,
   firmkz,
   id,
   gueltig_ab,
   gueltig_bis,
   bundesland,
   offenzeit,
   sonderoffenzeit,
   sonderoffenzeitkz,
   aktivkz,
   kundeid_key,
   konto_id_key,
   testfgkz,
   invkz,
   invzeitraumstart,
   invzeitraumende,
   invsollbd,
   invstichtag,
   busgruppekz,
   profitcenternr,
   profitcenterid,
   ware1b,
   ware1babgrenzvon,
   ware1babgrenzbis,
   laengengrad,
   breitengrad,
   bundeslandid,
   kostenstelle,
   kostenstelleid,
   fgstatusid,
   landid,
   filialleiterid,
   vertriebsleiterid,
   bauleiterid,
   pinkz,
   anzkassen,
   kurzwahl,
   hermesdepot,
   bemerkung,
   mdebuchungvon,
   mdebuchungbis,
   kreditkartenkz,
   internetvon,
   internetbis,
   inveinspielung,
   zentrwarenauszvon,
   zentrwarenauszbis,
   fgliefanschridzentrwarenausz,
   mobilverkaufkz,
   psvzeitraumvon, 
   psvzeitraumbis, 
   psvrabattsatz, 
   psvbemerkung,
   autoumlagerungkz,
   firma
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_fg_d
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
   fgnr,
   fgbez,
   kfznr,
   fgtyp,
   werbetextnr,
   firmkz,
   id,
   gueltig_ab,
   gueltig_bis,
   bundesland,
   offenzeit,
   sonderoffenzeit,
   sonderoffenzeitkz,
   aktivkz,
   kundeid_key,
   konto_id_key,
   testfgkz,
   invkz,
   invzeitraumstart,
   invzeitraumende,
   invsollbd,
   invstichtag,
   busgruppekz,
   profitcenternr,
   profitcenterid,
   ware1b,
   ware1babgrenzvon,
   ware1babgrenzbis,
   laengengrad,
   breitengrad,
   bundeslandid,
   kostenstelle,
   kostenstelleid,
   fgstatusid,
   landid,
   filialleiterid,
   vertriebsleiterid,
   bauleiterid,
   pinkz,
   anzkassen,
   kurzwahl,
   hermesdepot,
   bemerkung,
   mdebuchungvon,
   mdebuchungbis,
   kreditkartenkz,
   internetvon,
   internetbis,
   inveinspielung,
   zentrwarenauszvon,
   zentrwarenauszbis,
   fgliefanschridzentrwarenausz,
   mobilverkaufkz,
   psvzeitraumvon, 
   psvzeitraumbis, 
   psvrabattsatz, 
   psvbemerkung,
   autoumlagerungkz,
   firma
FROM st_ww_fg_b
WHERE dwh_processdate = &termin;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  4.3 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_fg_1');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_fg_d');
 
 
 
PROMPT ===========================================
PROMPT  4.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING('clsc_ww_fg', 'id', &gbvid);
 
 
 
PROMPT ===========================================
PROMPT  4.5 Einspielen in die letzte SC-Tabelle mit Referenzauflösung
PROMPT ===========================================
 
INSERT /*+ APPEND */ FIRST
WHEN (dwh_id_sc_ww_fgtyp IS NULL
   OR dwh_id_sc_ww_bestandsfirma IS NULL
   OR dwh_id_sc_ww_sonderoffenzeitkz IS NULL
   OR dwh_id_sc_ww_st_aktivkz IS NULL
   OR dwh_id_sc_ww_testfgkz IS NULL
   OR dwh_id_sc_ww_invkz IS NULL
   OR dwh_id_sc_ww_busgruppekz IS NULL
   OR dwh_id_sc_ww_land IS NULL
   OR dwh_id_sc_ww_filialleiter IS NULL
   OR dwh_id_sc_ww_vertriebsleiter IS NULL
   OR dwh_id_sc_ww_bauleiter IS NULL
   OR dwh_id_sc_ww_pinkz IS NULL
   OR dwh_id_sc_ww_kreditkartenkz IS NULL
   OR dwh_id_sc_ww_mobilverkaufkz IS NULL
) THEN
INTO clsc_ww_fg_e
(
   dwh_cr_load_id,
   dwh_up_load_id,
   dwh_id_sc_ww_fgtyp,
   dwh_id_sc_ww_bestandsfirma,
   dwh_id_sc_ww_sonderoffenzeitkz,
   dwh_id_sc_ww_st_aktivkz,
   dwh_id_sc_ww_testfgkz,
   dwh_id_sc_ww_invkz,
   dwh_id_sc_ww_busgruppekz,
   dwh_id_sc_ww_land,
   dwh_id_sc_ww_filialleiter,
   dwh_id_sc_ww_vertriebsleiter,
   dwh_id_sc_ww_bauleiter,
   dwh_id_sc_ww_pinkz,
   dwh_id_sc_ww_kreditkartenkz,
   dwh_id_sc_ww_mobilverkaufkz,
   fgnr,
   fgbez,
   kfznr,
   fgtyp,
   werbetextnr,
   firmkz,
   id,
   gueltig_ab,
   gueltig_bis,
   bundesland,
   offenzeit,
   sonderoffenzeit,
   sonderoffenzeitkz,
   aktivkz,
   kundeid_key,
   konto_id_key,
   testfgkz,
   invkz,
   invzeitraumstart,
   invzeitraumende,
   invsollbd,
   invstichtag,
   busgruppekz,
   profitcenternr,
   profitcenterid,
   ware1b,
   ware1babgrenzvon,
   ware1babgrenzbis,
   laengengrad,
   breitengrad,
   bundeslandid,
   kostenstelle,
   kostenstelleid,
   fgstatusid,
   landid,
   filialleiterid,
   vertriebsleiterid,
   bauleiterid,
   pinkz,
   anzkassen,
   kurzwahl,
   hermesdepot,
   bemerkung,
   mdebuchungvon,
   mdebuchungbis,
   kreditkartenkz,
   internetvon,
   internetbis,
   inveinspielung,
   zentrwarenauszvon,
   zentrwarenauszbis,
   fgliefanschridzentrwarenausz,
   mobilverkaufkz,
   psvzeitraumvon, 
   psvzeitraumbis, 
   psvrabattsatz, 
   psvbemerkung,
   autoumlagerungkz,
   firma
)
VALUES
(
   dwh_cr_load_id,
   &gbvid,
   dwh_id_sc_ww_fgtyp,
   dwh_id_sc_ww_bestandsfirma,
   dwh_id_sc_ww_sonderoffenzeitkz,
   dwh_id_sc_ww_st_aktivkz,
   dwh_id_sc_ww_testfgkz,
   dwh_id_sc_ww_invkz,
   dwh_id_sc_ww_busgruppekz,
   dwh_id_sc_ww_land,
   dwh_id_sc_ww_filialleiter,
   dwh_id_sc_ww_vertriebsleiter,
   dwh_id_sc_ww_bauleiter,
   dwh_id_sc_ww_pinkz,
   dwh_id_sc_ww_kreditkartenkz,
   dwh_id_sc_ww_mobilverkaufkz,
   fgnr,
   fgbez,
   kfznr,
   fgtyp,
   werbetextnr,
   firmkz,
   id,
   gueltig_ab,
   gueltig_bis,
   bundesland,
   offenzeit,
   sonderoffenzeit,
   sonderoffenzeitkz,
   aktivkz,
   kundeid_key,
   konto_id_key,
   testfgkz,
   invkz,
   invzeitraumstart,
   invzeitraumende,
   invsollbd,
   invstichtag,
   busgruppekz,
   profitcenternr,
   profitcenterid,
   ware1b,
   ware1babgrenzvon,
   ware1babgrenzbis,
   laengengrad,
   breitengrad,
   bundeslandid,
   kostenstelle,
   kostenstelleid,
   fgstatusid,
   landid,
   filialleiterid,
   vertriebsleiterid,
   bauleiterid,
   pinkz,
   anzkassen,
   kurzwahl,
   hermesdepot,
   bemerkung,
   mdebuchungvon,
   mdebuchungbis,
   kreditkartenkz,
   internetvon,
   internetbis,
   inveinspielung,
   zentrwarenauszvon,
   zentrwarenauszbis,
   fgliefanschridzentrwarenausz,
   mobilverkaufkz,
   psvzeitraumvon, 
   psvzeitraumbis, 
   psvrabattsatz, 
   psvbemerkung,
   autoumlagerungkz,
   firma
)
ELSE
INTO clsc_ww_fg
(
   dwh_cr_load_id,
   dwh_id_sc_ww_fgtyp,
   dwh_id_sc_ww_bestandsfirma,
   dwh_id_sc_ww_sonderoffenzeitkz,
   dwh_id_sc_ww_st_aktivkz,
   dwh_id_sc_ww_testfgkz,
   dwh_id_sc_ww_invkz,
   dwh_id_sc_ww_busgruppekz,
   dwh_id_sc_ww_land,
   dwh_id_sc_ww_filialleiter,
   dwh_id_sc_ww_vertriebsleiter,
   dwh_id_sc_ww_bauleiter,
   dwh_id_sc_ww_pinkz,
   dwh_id_sc_ww_kreditkartenkz,
   dwh_id_sc_ww_mobilverkaufkz,
   fgnr,
   fgbez,
   kfznr,
   fgtyp,
   werbetextnr,
   firmkz,
   id,
   gueltig_ab,
   gueltig_bis,
   bundesland,
   offenzeit,
   sonderoffenzeit,
   sonderoffenzeitkz,
   aktivkz,
   kundeid_key,
   konto_id_key,
   testfgkz,
   invkz,
   invzeitraumstart,
   invzeitraumende,
   invsollbd,
   invstichtag,
   busgruppekz,
   profitcenternr,
   profitcenterid,
   ware1b,
   ware1babgrenzvon,
   ware1babgrenzbis,
   laengengrad,
   breitengrad,
   bundeslandid,
   kostenstelle,
   kostenstelleid,
   fgstatusid,
   landid,
   filialleiterid,
   vertriebsleiterid,
   bauleiterid,
   pinkz,
   anzkassen,
   kurzwahl,
   hermesdepot,
   bemerkung,
   mdebuchungvon,
   mdebuchungbis,
   kreditkartenkz,
   internetvon,
   internetbis,
   inveinspielung,
   zentrwarenauszvon,
   zentrwarenauszbis,
   fgliefanschridzentrwarenausz,
   mobilverkaufkz,
   psvzeitraumvon, 
   psvzeitraumbis, 
   psvrabattsatz, 
   psvbemerkung,
   autoumlagerungkz,
   firma
)
SELECT
   a.dwh_cr_load_id,
   sc_ww_fgtyp.dwh_id AS dwh_id_sc_ww_fgtyp,
   sc_ww_bestandsfirma.dwh_id     AS dwh_id_sc_ww_bestandsfirma,
   sc_ww_sonderoffenzeitkz.dwh_id AS dwh_id_sc_ww_sonderoffenzeitkz,
   sc_ww_st_aktivkz.dwh_id        AS dwh_id_sc_ww_st_aktivkz,
   sc_ww_testfgkz.dwh_id          AS dwh_id_sc_ww_testfgkz,
   sc_ww_invkz.dwh_id             AS dwh_id_sc_ww_invkz,
   sc_ww_busgruppekz.dwh_id       AS dwh_id_sc_ww_busgruppekz,
   sc_ww_land.dwh_id              AS dwh_id_sc_ww_land,
   sc_ww_filialleiter.dwh_id      AS dwh_id_sc_ww_filialleiter,
   sc_ww_vertriebsleiter.dwh_id   AS dwh_id_sc_ww_vertriebsleiter,
   sc_ww_bauleiter.dwh_id         AS dwh_id_sc_ww_bauleiter,
   sc_ww_pinkz.dwh_id             AS dwh_id_sc_ww_pinkz,
   sc_ww_kreditkartenkz.dwh_id    AS dwh_id_sc_ww_kreditkartenkz,
   sc_ww_mobilverkaufkz.dwh_id    AS dwh_id_sc_ww_mobilverkaufkz,
   a.fgnr,
   a.fgbez,
   a.kfznr,
   a.fgtyp,
   a.werbetextnr,
   a.firmkz,
   a.id,
   a.gueltig_ab,
   a.gueltig_bis,
   a.bundesland,
   a.offenzeit,
   a.sonderoffenzeit,
   a.sonderoffenzeitkz,
   a.aktivkz,
   a.kundeid_key,
   a.konto_id_key,
   a.testfgkz,
   a.invkz,
   a.invzeitraumstart,
   a.invzeitraumende,
   a.invsollbd,
   a.invstichtag,
   a.busgruppekz,
   a.profitcenternr,
   a.profitcenterid,
   a.ware1b,
   a.ware1babgrenzvon,
   a.ware1babgrenzbis,
   a.laengengrad,
   a.breitengrad,
   a.bundeslandid,
   a.kostenstelle,
   a.kostenstelleid,
   a.fgstatusid,
   a.landid,
   a.filialleiterid,
   a.vertriebsleiterid,
   a.bauleiterid,
   a.pinkz,
   a.anzkassen,
   a.kurzwahl,
   a.hermesdepot,
   a.bemerkung,
   a.mdebuchungvon,
   a.mdebuchungbis,
   a.kreditkartenkz,
   a.internetvon,
   a.internetbis,
   a.inveinspielung,
   a.zentrwarenauszvon,
   a.zentrwarenauszbis,
   a.fgliefanschridzentrwarenausz,
   a.mobilverkaufkz,
   a.psvzeitraumvon, 
   a.psvzeitraumbis, 
   a.psvrabattsatz, 
   a.psvbemerkung,
   a.autoumlagerungkz,
   a.firma
FROM clsc_ww_fg_1 a
  LEFT OUTER JOIN (SELECT K1.dwh_id, V1.fgtyp 
                   FROM sc_ww_fgtyp K1 JOIN sc_ww_fgtyp_ver V1
                   ON (K1.dwh_id = V1.dwh_id_head AND &termin BETWEEN V1.dwh_valid_from AND V1.dwh_valid_to)) sc_ww_fgtyp
      ON (COALESCE(a.fgtyp, '$') = sc_ww_fgtyp.fgtyp)
    LEFT OUTER JOIN (SELECT K1.dwh_id, V1.firmkz 
               FROM sc_ww_bestandsfirma K1 JOIN sc_ww_bestandsfirma_ver V1
               ON (K1.dwh_id = V1.dwh_id_head AND &termin BETWEEN V1.dwh_valid_from AND V1.dwh_valid_to)) sc_ww_bestandsfirma
    ON (COALESCE(a.firmkz, -2) = sc_ww_bestandsfirma.firmkz)
    LEFT OUTER JOIN (SELECT K1.dwh_id, K1.wert 
               FROM sc_ww_sonderoffenzeitkz K1 JOIN sc_ww_sonderoffenzeitkz_ver V1
               ON (K1.dwh_id = V1.dwh_id_head AND &termin BETWEEN V1.dwh_valid_from AND V1.dwh_valid_to)) sc_ww_sonderoffenzeitkz
    ON (COALESCE(a.sonderoffenzeitkz, -2) = sc_ww_sonderoffenzeitkz.wert)
    LEFT OUTER JOIN (SELECT K1.dwh_id, K1.wert 
               FROM sc_ww_st_aktivkz K1 JOIN sc_ww_st_aktivkz_ver V1
               ON (K1.dwh_id = V1.dwh_id_head AND &termin BETWEEN V1.dwh_valid_from AND V1.dwh_valid_to)) sc_ww_st_aktivkz
    ON (COALESCE(a.aktivkz, -2) = sc_ww_st_aktivkz.wert)
    LEFT OUTER JOIN (SELECT K1.dwh_id, K1.wert 
               FROM sc_ww_testfgkz K1 JOIN sc_ww_testfgkz_ver V1
               ON (K1.dwh_id = V1.dwh_id_head AND &termin BETWEEN V1.dwh_valid_from AND V1.dwh_valid_to)) sc_ww_testfgkz
    ON (COALESCE(a.testfgkz, -2) = sc_ww_testfgkz.wert)
    LEFT OUTER JOIN (SELECT K1.dwh_id, K1.wert 
               FROM sc_ww_invkz K1 JOIN sc_ww_invkz_ver V1
               ON (K1.dwh_id = V1.dwh_id_head AND &termin BETWEEN V1.dwh_valid_from AND V1.dwh_valid_to)) sc_ww_invkz
    ON (COALESCE(a.invkz, -2) = sc_ww_invkz.wert)
    LEFT OUTER JOIN (SELECT K1.dwh_id, K1.wert 
               FROM sc_ww_busgruppekz K1 JOIN sc_ww_busgruppekz_ver V1
               ON (K1.dwh_id = V1.dwh_id_head AND &termin BETWEEN V1.dwh_valid_from AND V1.dwh_valid_to)) sc_ww_busgruppekz
    ON (COALESCE(a.busgruppekz, -2) = sc_ww_busgruppekz.wert)
    LEFT OUTER JOIN (SELECT K1.dwh_id, K1.id 
               FROM sc_ww_land K1 JOIN sc_ww_land_ver V1
               ON (K1.dwh_id = V1.dwh_id_head AND &termin BETWEEN V1.dwh_valid_from AND V1.dwh_valid_to)) sc_ww_land
    ON (COALESCE(a.landid, '$') = sc_ww_land.id)
    LEFT OUTER JOIN (SELECT K1.dwh_id, K1.id 
               FROM sc_ww_filialleiter K1 JOIN sc_ww_filialleiter_ver V1
               ON (K1.dwh_id = V1.dwh_id_head AND &termin BETWEEN V1.dwh_valid_from AND V1.dwh_valid_to)) sc_ww_filialleiter
    ON (COALESCE(a.filialleiterid, '$') = sc_ww_filialleiter.id)
    LEFT OUTER JOIN (SELECT K1.dwh_id, K1.id 
               FROM sc_ww_vertriebsleiter K1 JOIN sc_ww_vertriebsleiter_ver V1
               ON (K1.dwh_id = V1.dwh_id_head AND &termin BETWEEN V1.dwh_valid_from AND V1.dwh_valid_to)) sc_ww_vertriebsleiter
    ON (COALESCE(a.vertriebsleiterid, '$') = sc_ww_vertriebsleiter.id)
    LEFT OUTER JOIN (SELECT K1.dwh_id, K1.id 
               FROM sc_ww_bauleiter K1 JOIN sc_ww_bauleiter_ver V1
               ON (K1.dwh_id = V1.dwh_id_head AND &termin BETWEEN V1.dwh_valid_from AND V1.dwh_valid_to)) sc_ww_bauleiter
    ON (COALESCE(a.bauleiterid, '$') = sc_ww_bauleiter.id)
    LEFT OUTER JOIN (SELECT K1.dwh_id, K1.wert 
               FROM sc_ww_pinkz K1 JOIN sc_ww_pinkz_ver V1
               ON (K1.dwh_id = V1.dwh_id_head AND &termin BETWEEN V1.dwh_valid_from AND V1.dwh_valid_to)) sc_ww_pinkz
    ON (COALESCE(a.pinkz, -2) = sc_ww_pinkz.wert)
    LEFT OUTER JOIN (SELECT K1.dwh_id, K1.wert 
               FROM sc_ww_kreditkartenkz K1 JOIN sc_ww_pinkz_ver V1
               ON (K1.dwh_id = V1.dwh_id_head AND &termin BETWEEN V1.dwh_valid_from AND V1.dwh_valid_to)) sc_ww_kreditkartenkz
    ON (COALESCE(a.kreditkartenkz, -2) = sc_ww_kreditkartenkz.wert)
    LEFT OUTER JOIN (SELECT K1.dwh_id, K1.wert 
               FROM sc_ww_mobilverkaufkz K1 JOIN sc_ww_mobilverkaufkz_ver V1
               ON (K1.dwh_id = V1.dwh_id_head AND &termin BETWEEN V1.dwh_valid_from AND V1.dwh_valid_to)) sc_ww_mobilverkaufkz
    ON (COALESCE(a.mobilverkaufkz, -2) = sc_ww_mobilverkaufkz.wert)
;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  4.6 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_fg');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_fg_e');