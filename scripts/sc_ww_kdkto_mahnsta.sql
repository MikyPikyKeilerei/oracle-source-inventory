/*******************************************************************************

Job:                    sc_ww_kdkto_mahnsta(ehem. sc_ww_kdsaison)
Beschreibung:           Job laedt KDKTO, MAHNSTA, kundeverskostflat in das Source Core 
                    
Erstellt am:            xx.04.2016
Erstellt von:           Stefan Ernstberger
Ansprechpartner:        Stefan Ernstberger, Jochen Koenig
Ansprechpartner-IT:     Anton Roithmeier, Thomas Hoesl

verwendete Tabellen:    st_ww_kdkto_b                                                                                                                                                                                                                                                                                                                                                                                                          
                        st_ww_mahnsta_b
                        st_ww_kundeverskostflat_b
                                                                                                                                                                                                      
Endtabellen:            sc_ww_kdkto   
                        sc_ww_kdkto_ver
                        sc_ww_mahnsta 
                        sc_ww_mahnsta_ver
                        sc_ww_kundeverskostflat
                        sc_ww_kundeverskostflat_ver
Fehler-Doku:            -
Ladestrecke:            -

********************************************************************************
geändert am:          17.05.2018
geändert von:         steern    
Änderungen:           ##.1: KDKTO mit letzteretouredate versehen
********************************************************************************
geändert am:          06.08.2018
geändert von:         maxlin    
Änderungen:           ##.2: 
                      -Anpassungen an Clearingstelle:
                      -Kein kdsaison
                      -KundeID wird KundeID_Key
                      -Nur noch Verhaltensdaten
********************************************************************************
geändert am:          06.08.2018
geändert von:         maxlin    
Änderungen:           ##.3: Umzug UDWH1
********************************************************************************
geändert am:          17.12.2018
geändert von:         STEERN
Änderungen:           ##.3: Tabelle KUNDEVERSKOSTFLAT integriert 
********************************************************************************
geändert am:          03.04.2019
geändert von:         MAXLIN
Änderungen:           ##.4: Tabelle KUNDEVERSKOSTFLAT:  
                        -wapitransferoffenkz
                        -naechstsyncdat
                        -bem
********************************************************************************
geändert am:          03.12.2021
geändert von:         salmar
Änderungen:           ##.5: reference resolution added to auftragkopfid_key
********************************************************************************
geändert am:          09.04.2024
geändert von:         andgag
Änderungen:           ##.6: Clearingstellen Aufruf ausgebaut                        
*******************************************************************************/

ALTER SESSION ENABLE PARALLEL DML;

PROMPT =========================================================================
PROMPT Parameter
PROMPT Prozessdatum: &termin
PROMPT GBV-Job ID:    &gbvid
PROMPT =========================================================================



PROMPT =========================================================================
PROMPT
PROMPT 1. Source Core-Ladung
PROMPT Endtabelle: sc_ww_kdkto / sc_ww_kdkto_ver
PROMPT
PROMPT =========================================================================
 


PROMPT ===========================================
PROMPT  1.1 Cleansing Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clsc_ww_kdkto;
TRUNCATE TABLE clsc_ww_kdkto_1;
TRUNCATE TABLE clsc_ww_kdkto_d;



PROMPT ===========================================
PROMPT  1.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================

INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_kdkto_1
(
  dwh_cr_load_id,
  id_key,
  kundeid_key,
  saldonnkf,
  saldorgkf,
  stdgaktkostfrei,
  stdgaktkostpfli,
  kdausz,
  zahlungrgkf_kum,
  zahlungnnkf_kum,
  datletztzrgkf,
  kredlim,
  nkscorepkte,
  nkscorekz,
  letztretouredate,
  letztaktivfgdat   
)
VALUES
(
  &gbvid,
  id_key,
  kundeid_key,
  saldonnkf,
  saldorgkf,
  stdgaktkostfrei,
  stdgaktkostpfli,
  kdausz,
  zahlungrgkf_kum,
  zahlungnnkf_kum,
  datletztzrgkf,
  kredlim,
  nkscorepkte,
  nkscorekz,
  letztretouredate,
  letztaktivfgdat
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_kdkto_d
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
  kundeid_key,
  saldonnkf,
  saldorgkf,
  stdgaktkostfrei,
  stdgaktkostpfli,
  kdausz,
  zahlungrgkf_kum,
  zahlungnnkf_kum,
  datletztzrgkf,
  kredlim,
  nkscorepkte,
  nkscorekz,
  letztretouredate,
  letztaktivfgdat
FROM
st_ww_kdkto_b
WHERE dwh_processdate = &termin;

COMMIT;



PROMPT ===========================================
PROMPT  1.3 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_kdkto_1');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_kdkto_d');
 

 
PROMPT ===========================================
PROMPT  1.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING('clsc_ww_kdkto', 'ID_KEY', &gbvid);



PROMPT ===========================================
PROMPT  1.5 Einspielen in die letzte SC-Tabelle mit Referenzauflösung
PROMPT ===========================================

INSERT /*+ APPEND */ FIRST
WHEN ( dwh_id_sc_ww_kunde IS NULL ) THEN
INTO clsc_ww_kdkto_e
(
 dwh_cr_load_id,
 dwh_up_load_id,
 dwh_id_sc_ww_kunde,
 id_key,
 kundeid_key,
 saldonnkf,
 saldorgkf,
 stdgaktkostfrei,
 stdgaktkostpfli,
 kdausz,
 zahlungrgkf_kum,
 zahlungnnkf_kum,
 datletztzrgkf,
 kredlim,
 nkscorepkte,
 nkscorekz,
 letztretouredate,
 letztaktivfgdat
)
VALUES
(
 dwh_cr_load_id,
 &gbvid,
 dwh_id_sc_ww_kunde,
 id_key,
 kundeid_key,
 saldonnkf,
 saldorgkf,
 stdgaktkostfrei,
 stdgaktkostpfli,
 kdausz,
 zahlungrgkf_kum,
 zahlungnnkf_kum,
 datletztzrgkf,
 kredlim,
 nkscorepkte,
 nkscorekz,
 letztretouredate,
 letztaktivfgdat
)
ELSE
INTO clsc_ww_kdkto
(
  dwh_cr_load_id,
  dwh_id_sc_ww_kunde,
  id_key,
  kundeid_key,
  saldonnkf,
  saldorgkf,
  stdgaktkostfrei,
  stdgaktkostpfli,
  kdausz,
  zahlungrgkf_kum,
  zahlungnnkf_kum,
  datletztzrgkf,
  kredlim,
  nkscorepkte,
  nkscorekz,
  letztretouredate,
  letztaktivfgdat
)
SELECT
  a.dwh_cr_load_id,
  sc_ww_kunde.dwh_id AS dwh_id_sc_ww_kunde,
  a.id_key,
  a.kundeid_key,
  a.saldonnkf,
  a.saldorgkf,
  a.stdgaktkostfrei,
  a.stdgaktkostpfli,
  a.kdausz,
  a.zahlungrgkf_kum,
  a.zahlungnnkf_kum,
  a.datletztzrgkf,
  a.kredlim,
  a.nkscorepkte,
  a.nkscorekz,
  a.letztretouredate,
  a.letztaktivfgdat
FROM clsc_ww_kdkto_1 a
LEFT OUTER JOIN
    ( SELECT sc_ww_kunde.dwh_id, sc_ww_kunde.id_key FROM sc_ww_kunde) sc_ww_kunde
  ON (a.kundeid_key = sc_ww_kunde.id_key);

COMMIT;



PROMPT ===========================================
PROMPT  1.6 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_kdkto');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_kdkto_e');



PROMPT =========================================================================
PROMPT
PROMPT 2. Source Core-Ladung
PROMPT Endtabelle: sc_ww_mahnsta / sc_ww_mahnsta_ver
PROMPT
PROMPT =========================================================================


 
PROMPT ===========================================
PROMPT  2.1 Cleansing Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clsc_ww_mahnsta;
TRUNCATE TABLE clsc_ww_mahnsta_1;
TRUNCATE TABLE clsc_ww_mahnsta_d;



PROMPT ===========================================
PROMPT  2.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================

INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_mahnsta_1
(
  dwh_cr_load_id,
  id_key,
  kundeid_key,
  zahlungrueckst,
  gemahntzahlungsrueckst
)
VALUES
(
  &gbvid,
  id_key,
  kundeid_key,
  zahlungrueckst,
  gemahntzahlungsrueckst
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_mahnsta_d
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
  kundeid_key,
  zahlungrueckst,
  gemahntzahlungsrueckst
FROM
st_ww_mahnsta_b
WHERE dwh_processdate = &termin;

COMMIT;



PROMPT ===========================================
PROMPT  2.3 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_mahnsta_1');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_mahnsta_d');
 
 

PROMPT ===========================================
PROMPT  2.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING('clsc_ww_mahnsta', 'ID_KEY', &gbvid);



PROMPT ===========================================
PROMPT  2.5 Einspielen in die letzte SC-Tabelle mit Referenzauflösung
PROMPT ===========================================

INSERT /*+ APPEND */ FIRST
WHEN ( dwh_id_sc_ww_kunde IS NULL ) THEN
INTO clsc_ww_mahnsta_e
(
 dwh_cr_load_id,
 dwh_up_load_id,
 dwh_id_sc_ww_kunde,
 id_key,
 kundeid_key,
 zahlungrueckst,
 gemahntzahlungsrueckst
)
VALUES
(
 dwh_cr_load_id,
 &gbvid,
 dwh_id_sc_ww_kunde,
 id_key,
 kundeid_key,
 zahlungrueckst,
 gemahntzahlungsrueckst
)
ELSE
INTO clsc_ww_mahnsta
(
  dwh_cr_load_id,
  dwh_id_sc_ww_kunde,
  id_key,
  kundeid_key,
  zahlungrueckst,
  gemahntzahlungsrueckst
)
SELECT
  a.dwh_cr_load_id,
  sc_ww_kunde.dwh_id AS dwh_id_sc_ww_kunde,
  a.id_key,
  a.kundeid_key,
  a.zahlungrueckst,
  a.gemahntzahlungsrueckst
FROM clsc_ww_mahnsta_1 a
LEFT OUTER JOIN
  ( SELECT sc_ww_kunde.dwh_id, sc_ww_kunde.id_key FROM sc_ww_kunde) sc_ww_kunde
  ON (a.kundeid_key = sc_ww_kunde.id_key);

COMMIT;



PROMPT ===========================================
PROMPT  2.6 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_mahnsta');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_mahnsta_e');



PROMPT =========================================================================
PROMPT
PROMPT 3. Source Core-Ladung
PROMPT Endtabelle: sc_ww_kundeverskostflat / sc_ww_kundeverskostflat_ver
PROMPT
PROMPT =========================================================================



PROMPT ===========================================
PROMPT  3.1 Cleansing Tabellen leeren
PROMPT ===========================================

TRUNCATE TABLE clsc_ww_kundeverskostflat;
TRUNCATE TABLE clsc_ww_kundeverskostflat_1;
TRUNCATE TABLE clsc_ww_kundeverskostflat_d;



PROMPT ===========================================
PROMPT  3.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================

INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_kundeverskostflat_1
(
   dwh_cr_load_id,
   id_key,
   anldat,
   benutzeridanl,
   kundeid_key,
   erwerbstatkz,
   gueltigvondat,
   gueltigbisdat,
   stornodat,
   benutzeridstorno,
   auftragkopfid_key,
   wapitransferoffenkz,
   naechstsyncdat,
   bem
)
VALUES
(
   &gbvid,
   id_key,
   anldat,
   benutzeridanl,
   kundeid_key,
   erwerbstatkz,
   gueltigvondat,
   gueltigbisdat,
   stornodat,
   benutzeridstorno,
   auftragkopfid_key,
   wapitransferoffenkz,
   naechstsyncdat,
   bem
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_kundeverskostflat_d
(
   dwh_cr_load_id,
   id_key
)
VALUES
(
   &gbvid,
   id_key
)
SELECT
   dwh_stbflag,
   id_key,
   anldat,
   benutzeridanl,
   kundeid_key,
   erwerbstatkz,
   gueltigvondat,
   gueltigbisdat,
   stornodat,
   benutzeridstorno,
   auftragkopfid_key,
   wapitransferoffenkz,
   naechstsyncdat,
   bem
FROM st_ww_kundeverskostflat_b
WHERE dwh_processdate = &termin;

COMMIT;


PROMPT ===========================================
PROMPT  3.3 Aktuelle Statistiken erstellen
PROMPT ===========================================

EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_kundeverskostflat_1');
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_kundeverskostflat_d');

PROMPT ===========================================
PROMPT 3.4 Error Handling
PROMPT ===========================================

EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING ('clsc_ww_kundeverskostflat', 'id_key', &gbvid);

PROMPT ===========================================
PROMPT  3.5 Einspielen in die letzte SC-Tabelle mit Referenzauflösung
PROMPT ===========================================

INSERT /*+ APPEND */ FIRST
WHEN (dwh_id_sc_ww_benutzerstorno IS NULL
      OR dwh_id_sc_ww_benutzeranl IS NULL
      OR dwh_id_sc_ww_kunde IS NULL
      OR dwh_id_sc_ww_erwerbstatkz IS NULL
      OR dwh_id_sc_ww_wapitransferoffenkz IS NULL
      OR dwh_id_sc_ww_auftragkopf IS NULL
) THEN
INTO clsc_ww_kundeverskostflat_e
(
   dwh_cr_load_id,
   dwh_up_load_id,
   dwh_id_sc_ww_benutzeranl,
   dwh_id_sc_ww_benutzerstorno,
   dwh_id_sc_ww_kunde,
   dwh_id_sc_ww_erwerbstatkz,
   dwh_id_sc_ww_wapitransferoffenkz,
   dwh_id_sc_ww_auftragkopf,
   id_key,
   anldat,
   benutzeridanl,
   kundeid_key,
   erwerbstatkz,
   gueltigvondat,
   gueltigbisdat,
   stornodat,
   benutzeridstorno,
   auftragkopfid_key,
   wapitransferoffenkz,
   naechstsyncdat,
   bem
)
VALUES
(
   dwh_cr_load_id,
   &gbvid,
   dwh_id_sc_ww_benutzeranl,
   dwh_id_sc_ww_benutzerstorno,
   dwh_id_sc_ww_kunde,
   dwh_id_sc_ww_erwerbstatkz,
   dwh_id_sc_ww_wapitransferoffenkz,
   dwh_id_sc_ww_auftragkopf,
   id_key,
   anldat,
   benutzeridanl,
   kundeid_key,
   erwerbstatkz,
   gueltigvondat,
   gueltigbisdat,
   stornodat,
   benutzeridstorno,
   auftragkopfid_key,
   wapitransferoffenkz,
   naechstsyncdat,
   bem
)
ELSE
INTO clsc_ww_kundeverskostflat
(
   dwh_cr_load_id,
   dwh_id_sc_ww_benutzeranl,
   dwh_id_sc_ww_benutzerstorno,
   dwh_id_sc_ww_kunde,
   dwh_id_sc_ww_erwerbstatkz,
   dwh_id_sc_ww_wapitransferoffenkz,
   dwh_id_sc_ww_auftragkopf,
   id_key,
   anldat,
   benutzeridanl,
   kundeid_key,
   erwerbstatkz,
   gueltigvondat,
   gueltigbisdat,
   stornodat,
   benutzeridstorno,
   auftragkopfid_key,
   wapitransferoffenkz,
   naechstsyncdat,
   bem
)
SELECT
   a.dwh_cr_load_id,
   sc_ww_benutzeranl.dwh_id AS dwh_id_sc_ww_benutzeranl,
   sc_ww_benutzerstorno.dwh_id AS dwh_id_sc_ww_benutzerstorno,
   sc_ww_kunde.dwh_id AS dwh_id_sc_ww_kunde,
   sc_ww_erwerbstatkz.dwh_id AS dwh_id_sc_ww_erwerbstatkz,
   sc_ww_wapitransferoffenkz.dwh_id AS dwh_id_sc_ww_wapitransferoffenkz,
   sc_ww_auftragkopf.dwh_id AS dwh_id_sc_ww_auftragkopf,   
   a.id_key AS id_key,
   a.anldat AS anldat,
   a.benutzeridanl AS benutzeridanl,
   a.kundeid_key AS kundeid_key,
   a.erwerbstatkz AS erwerbstatkz,
   a.gueltigvondat AS gueltigvondat,
   a.gueltigbisdat AS gueltigbisdat,
   a.stornodat AS stornodat,
   a.benutzeridstorno AS benutzeridstorno,
   a.auftragkopfid_key AS auftragkopfid_key,
   a.wapitransferoffenkz,
   a.naechstsyncdat,
   a.bem
FROM clsc_ww_kundeverskostflat_1 a
LEFT OUTER JOIN (SELECT sc_ww_benutzer.dwh_id, sc_ww_benutzer.id FROM sc_ww_benutzer)  sc_ww_benutzeranl
ON (a.benutzeridanl = sc_ww_benutzeranl.id)
LEFT OUTER JOIN (SELECT sc_ww_benutzer.dwh_id, sc_ww_benutzer.id FROM sc_ww_benutzer)  sc_ww_benutzerstorno
ON (CASE WHEN a.benutzeridstorno IS NULL THEN '$' ELSE a.benutzeridstorno END = sc_ww_benutzerstorno.id)
LEFT OUTER JOIN (SELECT sc_ww_kunde.dwh_id, sc_ww_kunde.id_key FROM sc_ww_kunde)  sc_ww_kunde
ON (a.kundeid_key = sc_ww_kunde.id_key)
LEFT OUTER JOIN (SELECT sc_ww_erwerbstatkz.dwh_id, sc_ww_erwerbstatkz.wert FROM sc_ww_erwerbstatkz)  sc_ww_erwerbstatkz
ON (a.erwerbstatkz= sc_ww_erwerbstatkz.wert)
LEFT OUTER JOIN (SELECT sc_ww_wapitransferoffenkz.dwh_id, sc_ww_wapitransferoffenkz.wert FROM sc_ww_wapitransferoffenkz)  sc_ww_wapitransferoffenkz
ON (a.wapitransferoffenkz= sc_ww_wapitransferoffenkz.wert)
LEFT OUTER JOIN (SELECT dwh_id, id_key FROM sc_ww_auftragkopf) sc_ww_auftragkopf
ON (CASE WHEN a.auftragkopfid_key IS NULL OR a.auftragkopfid_key = '49379753EAEA3D9466E47FBFE8975668' 
--improg.pkg_clearing.f_clearing_anonymize(1, 'X')
THEN '$' ELSE a.auftragkopfid_key END = sc_ww_auftragkopf.id_key);

COMMIT;


PROMPT ===========================================
PROMPT  3.6 Aktuelle Statistiken erstellen
PROMPT ===========================================

EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_kundeverskostflat');
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_kundeverskostflat_e');