/*******************************************************************************

Job:                  sc_ww_referenzladung_6
Beschreibung:         Job lädt Referenzen. Verwendete Referenzen im nDWH werden 
                      über die Job's sc_ww_referenzladung_1, sc_ww_referenzladung_2,
                      sc_ww_referenzladung_3, sc_ww_referenzladung_4,
                      sc_ww_referenzladung_5 und sc_ww_referenzladung_6 geladen.
                      Alle sonstigen Referenzen werden über den Job sc_ww_referenzladung_sonst 
                      geladen, solange, bis sie in einer neuen Ladestrecke 
                      verwendet werden.
          
Erstellt am:          08.11.2016
Erstellt von:         stegrs
Ansprechpartner:      stegrs, joeabd    
Ansprechpartner-IT: -

verwendete Tabellen:  st_ww_valutaaktion_b
                      st_ww_ratenaufschlag_b
                      st_ww_crsbranding_b
                      st_ww_artgrp_b
                      st_ww_retruecklauf_b
                      st_ww_lieferwunschservice_b
                      st_ww_kdfservicekondition_b
                      st_ww_kundenfirmaservice_b

                       
Endtabellen:          sc_ww_valutaaktion / sc_ww_valutaaktion_ver 
                      sc_ww_ratenaufschlag / sc_ww_ratenaufschlag_ver
                      sc_ww_crsbranding / sc_ww_crsbranding_ver
                      sc_ww_artgrp / sc_ww_artgrp_ver
                      sc_ww_retruecklauf / sc_ww_retruecklauf_ver
                      sc_ww_lieferwunschservice /ver
                      sc_ww_kdfservicekondition / ver
                      sc_ww_kundenfirmaservice / ver

Fehler-Doku:      -
Ladestrecke:      -

********************************************************************************
geändert am:          2016-12-14
geändert von:         joeabd
Änderungen:           ##.1: Tabelle RATENAUFSCHLAG hinzugefügt

geändert am:          2017-02-21
geändert von:         stegrs
Änderungen:           ##.2: Tabelle CRSBRANDING hinzugefügt

geändert am:          2017-10-24
geändert von:         stegrs
Änderungen:           ##.3: Referenzjob _5 in _6 umbenannt

geändert am:          2018-07-10
geändert von:         stegrs
Änderungen:           ##.4: Tabelle ARTGRP von _5 in _6 umgezogen

geändert am:          2018-07-11
geändert von:         stegrs
Änderungen:           ##.5: Tabelle ARTGRP Referenzauflösung zu sc_ww_eksaison eingebaut

geändert am:          2019-03-04
geändert von:         stegrs
Änderungen:           ##.6: Tabelle RETRUECKLAUF hinzugefügt

geändert am:          2019-12-19
geändert von:         svehoc
Änderungen:           ##.7: Umzug auf UDWH1

geändert am:          2022-05-23
geändert von:         isrrod
Änderungen:           ##.8: Load of new tables sc_ww_lieferwunschservice, sc_ww_kdfservicekondition
                            and sc_ww_kundenfirmaservice

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
PROMPT Endtabelle: sc_ww_valutaaktion / sc_ww_valutaaktion_ver
PROMPT
PROMPT =========================================================================
 
 
 
PROMPT ===========================================
PROMPT  1.1 Cleansing Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clsc_ww_valutaaktion;
TRUNCATE TABLE clsc_ww_valutaaktion_1;
TRUNCATE TABLE clsc_ww_valutaaktion_d;
 
 
 
PROMPT ===========================================
PROMPT  1.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_valutaaktion_1
(
   dwh_cr_load_id,
   id,
   kz,
   bez,
   prozent,
   valutierung,
   kundenfirmaid,
   vondatum,
   bisdat,
   valzieldat
)
VALUES
(
   &gbvid,
   id,
   kz,
   bez,
   prozent,
   valutierung,
   kundenfirmaid,
   vondatum,
   bisdat,
   valzieldat
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_valutaaktion_d
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
   prozent,
   valutierung,
   kundenfirmaid,
   vondatum,
   bisdat,
   valzieldat
FROM st_ww_valutaaktion_b
WHERE dwh_processdate = &termin;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  1.3 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_valutaaktion_1');
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_valutaaktion_d');
 
 
 
PROMPT ===========================================
PROMPT  1.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING ('clsc_ww_valutaaktion', 'id', &gbvid);
 
 
 
PROMPT ===========================================
PROMPT  1.5 Einspielen in die letzte SC-Tabelle mit Referenzauflösung
PROMPT ===========================================
 
INSERT /*+ APPEND */ FIRST
WHEN (dwh_id_sc_ww_kundenfirma IS NULL 
) THEN
INTO clsc_ww_valutaaktion_e
(
   dwh_cr_load_id,
   dwh_up_load_id,
   dwh_id_sc_ww_kundenfirma,
   id,
   kz,
   bez,
   prozent,
   valutierung,
   kundenfirmaid,
   vondatum,
   bisdat,
   valzieldat
)
VALUES
(
   dwh_cr_load_id,
   &gbvid,
   dwh_id_sc_ww_kundenfirma,
   id,
   kz,
   bez,
   prozent,
   valutierung,
   kundenfirmaid,
   vondatum,
   bisdat,
   valzieldat
)
ELSE
INTO clsc_ww_valutaaktion
(
   dwh_cr_load_id,
   dwh_id_sc_ww_kundenfirma,
   id,
   kz,
   bez,
   prozent,
   valutierung,
   kundenfirmaid,
   vondatum,
   bisdat,
   valzieldat
)
SELECT
   a.dwh_cr_load_id,
   sc_ww_kundenfirma.dwh_id AS dwh_id_sc_ww_kundenfirma,
   a.id AS id,
   a.kz AS kz,
   a.bez AS bez,
   a.prozent AS prozent,
   a.valutierung AS valutierung,
   a.kundenfirmaid AS kundenfirmaid,
   a.vondatum AS vondatum,
   a.bisdat AS bisdat,
   a.valzieldat AS valzieldat
FROM clsc_ww_valutaaktion_1 a
  LEFT OUTER JOIN (SELECT sc_ww_kundenfirma.dwh_id, sc_ww_kundenfirma.id FROM sc_ww_kundenfirma)  sc_ww_kundenfirma
      ON (a.kundenfirmaid = sc_ww_kundenfirma.id)
;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  1.6 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_valutaaktion');
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_valutaaktion_e');



PROMPT =========================================================================
PROMPT
PROMPT 2. Source Core-Ladung
PROMPT Endtabelle: sc_ww_ratenaufschlag / sc_ww_ratenaufschlag_ver
PROMPT
PROMPT =========================================================================
 
 
 
PROMPT ===========================================
PROMPT  2.1 Cleansing Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clsc_ww_ratenaufschlag;
TRUNCATE TABLE clsc_ww_ratenaufschlag_1;
TRUNCATE TABLE clsc_ww_ratenaufschlag_d;
 
 
 
PROMPT ===========================================
PROMPT  2.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_ratenaufschlag_1
(
   dwh_cr_load_id,
   id,
   zinsmtl,
   zinseff,
   zinseffzahlp,
   vondat,
   bisdat,
   anzraten,
   kundenfirmaid,
   aufschlzahlp,
   anzwochenzahlp
)
VALUES
(
   &gbvid,
   id,
   zinsmtl,
   zinseff,
   zinseffzahlp,
   vondat,
   bisdat,
   anzraten,
   kundenfirmaid,
   aufschlzahlp,
   anzwochenzahlp
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_ratenaufschlag_d
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
   zinsmtl,
   zinseff,
   zinseffzahlp,
   vondat,
   bisdat,
   anzraten,
   kundenfirmaid,
   aufschlzahlp,
   anzwochenzahlp
FROM st_ww_ratenaufschlag_b
WHERE dwh_processdate = &termin;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  2.3 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_ratenaufschlag_1');
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_ratenaufschlag_d');
 
 
 
PROMPT ===========================================
PROMPT  2.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING ('clsc_ww_ratenaufschlag', 'id', &gbvid);
 
 
 
PROMPT ===========================================
PROMPT  2.5 Einspielen in die letzte SC-Tabelle mit Referenzauflösung
PROMPT ===========================================
 
INSERT /*+ APPEND */ FIRST
WHEN (dwh_id_sc_ww_kundenfirma IS NULL 
) THEN
INTO clsc_ww_ratenaufschlag_e
(
   dwh_cr_load_id,
   dwh_up_load_id,
   dwh_id_sc_ww_kundenfirma,
   id,
   zinsmtl,
   zinseff,
   zinseffzahlp,
   vondat,
   bisdat,
   anzraten,
   kundenfirmaid,
   aufschlzahlp,
   anzwochenzahlp
)
VALUES
(
   dwh_cr_load_id,
   &gbvid,
   dwh_id_sc_ww_kundenfirma,
   id,
   zinsmtl,
   zinseff,
   zinseffzahlp,
   vondat,
   bisdat,
   anzraten,
   kundenfirmaid,
   aufschlzahlp,
   anzwochenzahlp
)
ELSE
INTO clsc_ww_ratenaufschlag
(
   dwh_cr_load_id,
   dwh_id_sc_ww_kundenfirma,
   id,
   zinsmtl,
   zinseff,
   zinseffzahlp,
   vondat,
   bisdat,
   anzraten,
   kundenfirmaid,
   aufschlzahlp,
   anzwochenzahlp
)
SELECT
   a.dwh_cr_load_id,
   sc_ww_kundenfirma.dwh_id AS dwh_id_sc_ww_kundenfirma,
   a.id AS id,
   a.zinsmtl AS zinsmtl,
   a.zinseff AS zinseff,
   a.zinseffzahlp AS zinseffzahlp,
   a.vondat AS vondat,
   a.bisdat AS bisdat,
   a.anzraten AS anzraten,
   a.kundenfirmaid AS kundenfirmaid,
   a.aufschlzahlp AS aufschlzahlp,
   a.anzwochenzahlp AS anzwochenzahlp
FROM clsc_ww_ratenaufschlag_1 a
  LEFT OUTER JOIN (SELECT sc_ww_kundenfirma.dwh_id, sc_ww_kundenfirma.id FROM sc_ww_kundenfirma)  sc_ww_kundenfirma
      ON (a.kundenfirmaid = sc_ww_kundenfirma.id);
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  2.6 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_ratenaufschlag');
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_ratenaufschlag_e');



PROMPT =========================================================================
PROMPT
PROMPT 3. Source Core-Ladung
PROMPT Endtabelle: sc_ww_crsbranding / sc_ww_crsbranding_ver
PROMPT
PROMPT =========================================================================
 
 
 
PROMPT ===========================================
PROMPT  3.1 Cleansing Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clsc_ww_crsbranding;
TRUNCATE TABLE clsc_ww_crsbranding_1;
TRUNCATE TABLE clsc_ww_crsbranding_d;
 
 
 
PROMPT ===========================================
PROMPT  3.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_crsbranding_1
(
   dwh_cr_load_id,
   id,
   brandingnr,
   bez,
   klientname,
   crsfgid,
   avmlayoutnrpclnet,
   avmlayoutnrlynx
)
VALUES
(
   &gbvid,
   id,
   brandingnr,
   bez,
   klientname,
   crsfgid,
   avmlayoutnrpclnet,
   avmlayoutnrlynx
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_crsbranding_d
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
   brandingnr,
   bez,
   klientname,
   crsfgid,
   avmlayoutnrpclnet,
   avmlayoutnrlynx
FROM st_ww_crsbranding_b
WHERE dwh_processdate = &termin;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  3.3 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_crsbranding_1');
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_crsbranding_d');
 
 
 
PROMPT ===========================================
PROMPT  3.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING ('clsc_ww_crsbranding', 'id', &gbvid);
 
 
 
PROMPT ===========================================
PROMPT  3.5 Einspielen in die letzte SC-Tabelle mit Referenzauflösung
PROMPT ===========================================
 
INSERT /*+ APPEND */ FIRST
WHEN (dwh_id_sc_ww_crsfg IS NULL 
) THEN
INTO clsc_ww_crsbranding_e
(
   dwh_cr_load_id,
   dwh_up_load_id,
   dwh_id_sc_ww_crsfg,
   id,
   brandingnr,
   bez,
   klientname,
   crsfgid,
   avmlayoutnrpclnet,
   avmlayoutnrlynx
)
VALUES
(
   dwh_cr_load_id,
   &gbvid,
   dwh_id_sc_ww_crsfg,
   id,
   brandingnr,
   bez,
   klientname,
   crsfgid,
   avmlayoutnrpclnet,
   avmlayoutnrlynx
)
ELSE
INTO clsc_ww_crsbranding
(
   dwh_cr_load_id,
   dwh_id_sc_ww_crsfg,
   id,
   brandingnr,
   bez,
   klientname,
   crsfgid,
   avmlayoutnrpclnet,
   avmlayoutnrlynx
)
SELECT
   a.dwh_cr_load_id,
   sc_ww_crsfg.dwh_id AS dwh_id_sc_ww_crsfg,
   a.id AS id,
   a.brandingnr AS brandingnr,
   a.bez AS bez,
   a.klientname AS klientname,
   a.crsfgid AS crsfgid,
   a.avmlayoutnrpclnet AS avmlayoutnrpclnet,
   a.avmlayoutnrlynx AS avmlayoutnrlynx
FROM clsc_ww_crsbranding_1 a
  LEFT OUTER JOIN (SELECT sc_ww_crsfg.dwh_id, sc_ww_crsfg.id FROM sc_ww_crsfg)  sc_ww_crsfg
      ON (a.crsfgid = sc_ww_crsfg.id)
;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  3.6 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_crsbranding');
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_crsbranding_e');



PROMPT =========================================================================
PROMPT
PROMPT 4. Source Core-Ladung
PROMPT Endtabelle: sc_ww_artgrp / sc_ww_artgrp_ver
PROMPT
PROMPT =========================================================================
 
 
 
PROMPT ===========================================
PROMPT  4.1 Cleansing Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clsc_ww_artgrp;
TRUNCATE TABLE clsc_ww_artgrp_1;
TRUNCATE TABLE clsc_ww_artgrp_d;
 
 
 
PROMPT ===========================================
PROMPT  4.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_artgrp_1
(
   dwh_cr_load_id,
   saison,
   etber,
   wagrp,
   artgrp,
   artgrpbez,
   mwstkz,
   mgeinh,
   id,
   vknullkz,
   artgrpidstdefault,
   artgrpidbtdefault,
   erridat,
   aenddat
)
VALUES
(
   &gbvid,
   saison,
   etber,
   wagrp,
   artgrp,
   artgrpbez,
   mwstkz,
   mgeinh,
   id,
   vknullkz,
   artgrpidstdefault,
   artgrpidbtdefault,
   erridat,
   aenddat
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_artgrp_d
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
   artgrp,
   artgrpbez,
   mwstkz,
   mgeinh,
   id,
   vknullkz,
   artgrpidstdefault,
   artgrpidbtdefault,
   erridat,
   aenddat
FROM st_ww_artgrp_b
WHERE dwh_processdate = &termin;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  4.3 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_artgrp_1');
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_artgrp_d');
 
 
 
PROMPT ===========================================
PROMPT  4.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING ('clsc_ww_artgrp', 'id', &gbvid);
 
 
 
PROMPT ===========================================
PROMPT  4.5 Einspielen in die letzte SC-Tabelle mit Referenzauflösung
PROMPT ===========================================
 
INSERT /*+ APPEND */ FIRST
WHEN (dwh_id_sc_ww_eksaison IS NULL
   OR dwh_id_sc_ww_wagrp_ek IS NULL
   OR dwh_id_sc_ww_mwst IS NULL 
) THEN
INTO clsc_ww_artgrp_e
(
   dwh_cr_load_id,
   dwh_up_load_id,
   dwh_id_sc_ww_eksaison,
   dwh_id_sc_ww_wagrp_ek,
   dwh_id_sc_ww_mwst,
   saison,
   etber,
   wagrp,
   artgrp,
   artgrpbez,
   mwstkz,
   mgeinh,
   id,
   vknullkz,
   artgrpidstdefault,
   artgrpidbtdefault,
   erridat,
   aenddat
)
VALUES
(
   dwh_cr_load_id,
   &gbvid,
   dwh_id_sc_ww_eksaison,
   dwh_id_sc_ww_wagrp_ek,
   dwh_id_sc_ww_mwst,
   saison,
   etber,
   wagrp,
   artgrp,
   artgrpbez,
   mwstkz,
   mgeinh,
   id,
   vknullkz,
   artgrpidstdefault,
   artgrpidbtdefault,
   erridat,
   aenddat
)
ELSE
INTO clsc_ww_artgrp
(
   dwh_cr_load_id,
   dwh_id_sc_ww_eksaison,
   dwh_id_sc_ww_wagrp_ek,
   dwh_id_sc_ww_mwst,
   saison,
   etber,
   wagrp,
   artgrp,
   artgrpbez,
   mwstkz,
   mgeinh,
   id,
   vknullkz,
   artgrpidstdefault,
   artgrpidbtdefault,
   erridat,
   aenddat
)
SELECT
   a.dwh_cr_load_id,
   sc_ww_eksaison.dwh_id AS dwh_id_sc_ww_eksaison,
   sc_ww_wagrp_ek.dwh_id AS dwh_id_sc_ww_wagrp_ek,
   sc_ww_mwst.dwh_id AS dwh_id_sc_ww_mwst,
   a.saison AS saison,
   a.etber AS etber,
   a.wagrp AS wagrp,
   a.artgrp AS artgrp,
   a.artgrpbez AS artgrpbez,
   a.mwstkz AS mwstkz,
   a.mgeinh AS mgeinh,
   a.id AS id,
   a.vknullkz AS vknullkz,
   a.artgrpidstdefault AS artgrpidstdefault,
   a.artgrpidbtdefault AS artgrpidbtdefault,
   a.erridat AS erridat,
   a.aenddat AS aenddat
FROM clsc_ww_artgrp_1 a
  LEFT OUTER JOIN (SELECT sc_ww_eksaison.dwh_id, sc_ww_eksaison.wert FROM sc_ww_eksaison) sc_ww_eksaison
      ON (a.saison = sc_ww_eksaison.wert)
  LEFT OUTER JOIN (SELECT K1.dwh_id, V1.saison, V1.etber, V1.wagrp
                   FROM sc_ww_wagrp_ek K1 JOIN sc_ww_wagrp_ek_ver V1
                   ON (K1.dwh_id = V1.dwh_id_head AND &termin BETWEEN V1.dwh_valid_from AND V1.dwh_valid_to)) sc_ww_wagrp_ek
      ON (a.saison = sc_ww_wagrp_ek.saison AND a.etber = sc_ww_wagrp_ek.etber AND a.wagrp = sc_ww_wagrp_ek.wagrp)
  LEFT OUTER JOIN (SELECT K1.dwh_id, V1.mwstkz
                   FROM sc_ww_mwst K1 JOIN sc_ww_mwst_ver V1
                   ON (K1.dwh_id = V1.dwh_id_head AND &termin BETWEEN V1.dwh_valid_from AND V1.dwh_valid_to)) sc_ww_mwst
      ON (COALESCE(a.mwstkz, -3) = sc_ww_mwst.mwstkz)  
;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  4.6 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_artgrp');
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_artgrp_e');


PROMPT =========================================================================
PROMPT
PROMPT 5. Source Core-Ladung
PROMPT Endtabelle: sc_ww_retruecklauf / sc_ww_retruecklauf_ver
PROMPT
PROMPT =========================================================================
 
 
 
PROMPT ===========================================
PROMPT  5.1 Cleansing Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clsc_ww_retruecklauf;
TRUNCATE TABLE clsc_ww_retruecklauf_1;
TRUNCATE TABLE clsc_ww_retruecklauf_d;
 
 
 
PROMPT ===========================================
PROMPT  5.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_retruecklauf_1
(
   dwh_cr_load_id,
   id,
   standarterfkz,
   kdfirmkz,
   retruecklversandfirmaid,
   retruecklkzid
)
VALUES
(
   &gbvid,
   id,
   standarterfkz,
   kdfirmkz,
   retruecklversandfirmaid,
   retruecklkzid
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_retruecklauf_d
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
   standarterfkz,
   kdfirmkz,
   retruecklversandfirmaid,
   retruecklkzid
FROM st_ww_retruecklauf_b
WHERE dwh_processdate = &termin;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  5.3 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_retruecklauf_1');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_retruecklauf_d');
 
 
 
PROMPT ===========================================
PROMPT  5.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING('clsc_ww_retruecklauf', 'id', &gbvid);
 
 
 
PROMPT ===========================================
PROMPT  5.5 Einspielen in die letzte SC-Tabelle mit Referenzauflösung
PROMPT ===========================================
 
INSERT /*+ APPEND */ FIRST
WHEN (dwh_id_sc_ww_kundenfirma IS NULL
   OR dwh_id_sc_ww_retruecklversfirma IS NULL
) THEN
INTO clsc_ww_retruecklauf_e
(
   dwh_cr_load_id,
   dwh_up_load_id,
   dwh_id_sc_ww_kundenfirma,
   dwh_id_sc_ww_retruecklversfirma,
   id,
   standarterfkz,
   kdfirmkz,
   retruecklversandfirmaid,
   retruecklkzid
)
VALUES
(
   dwh_cr_load_id,
   &gbvid,
   dwh_id_sc_ww_kundenfirma,
   dwh_id_sc_ww_retruecklversfirma,
   id,
   standarterfkz,
   kdfirmkz,
   retruecklversandfirmaid,
   retruecklkzid
)
ELSE
INTO clsc_ww_retruecklauf
(
   dwh_cr_load_id,
   dwh_id_sc_ww_kundenfirma,
   dwh_id_sc_ww_retruecklversfirma,
   id,
   standarterfkz,
   kdfirmkz,
   retruecklversandfirmaid,
   retruecklkzid
)
SELECT
   a.dwh_cr_load_id,
   sc_ww_kundenfirma.dwh_id AS dwh_id_sc_ww_kundenfirma,
   sc_ww_retruecklversfirma.dwh_id AS dwh_id_sc_ww_retruecklversfirma,
   a.id AS id,
   a.standarterfkz AS standarterfkz,
   a.kdfirmkz AS kdfirmkz,
   a.retruecklversandfirmaid AS retruecklversandfirmaid,
   a.retruecklkzid AS retruecklkzid
FROM clsc_ww_retruecklauf_1 a
  LEFT OUTER JOIN (SELECT K1.dwh_id, V1.kdfirmkz
                   FROM sc_ww_kundenfirma K1 JOIN sc_ww_kundenfirma_ver V1
                   ON (K1.dwh_id = V1.dwh_id_head AND &termin BETWEEN V1.dwh_valid_from AND V1.dwh_valid_to)) sc_ww_kundenfirma
    ON (a.kdfirmkz = sc_ww_kundenfirma.kdfirmkz)
  LEFT OUTER JOIN (SELECT sc_ww_retruecklversfirma.dwh_id, sc_ww_retruecklversfirma.id FROM sc_ww_retruecklversfirma) sc_ww_retruecklversfirma
    ON (a.retruecklversandfirmaid = sc_ww_retruecklversfirma.id)
;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  5.6 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_retruecklauf');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_retruecklauf_e');



PROMPT =========================================================================
PROMPT
PROMPT 6. Source Core-Ladung
PROMPT Endtabelle: sc_ww_lieferwunschservice / sc_ww_lieferwunschservice_ver
PROMPT
PROMPT =========================================================================



PROMPT ===========================================
PROMPT  6.1 Cleansing Tabellen leeren
PROMPT ===========================================

TRUNCATE TABLE clsc_ww_lieferwunschservice;
TRUNCATE TABLE clsc_ww_lieferwunschservice_1;
TRUNCATE TABLE clsc_ww_lieferwunschservice_d;



PROMPT ===========================================
PROMPT  6.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================

INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_lieferwunschservice_1
(
   dwh_cr_load_id,
   id,
   kundenfirmaid,
   bestwegid,
   gueltigvon,
   gueltigbis,
   sortkz,
   defaultkz,
   lieferwunschid,
   zwangkomplkz,
   lieferwunschkosten
)
VALUES
(
   &gbvid,
   id,
   kundenfirmaid,
   bestwegid,
   gueltigvon,
   gueltigbis,
   sortkz,
   defaultkz,
   lieferwunschid,
   zwangkomplkz,
   lieferwunschkosten
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_lieferwunschservice_d
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
   kundenfirmaid,
   bestwegid,
   gueltigvon,
   gueltigbis,
   sortkz,
   defaultkz,
   lieferwunschid,
   zwangkomplkz,
   lieferwunschkosten
FROM st_ww_lieferwunschservice_b
WHERE dwh_processdate = &termin;

COMMIT;



PROMPT ===========================================
PROMPT  6.3 Aktuelle Statistiken erstellen
PROMPT ===========================================

EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_lieferwunschservice_1');
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_lieferwunschservice_d');



PROMPT ===========================================
PROMPT  6.4 Error Handling
PROMPT ===========================================

EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING ('clsc_ww_lieferwunschservice', 'id', &gbvid);



PROMPT ===========================================
PROMPT  6.5 Einspielen in die letzte SC-Tabelle mit Referenzauflösung
PROMPT ===========================================

INSERT /*+ APPEND */ FIRST
WHEN (dwh_id_sc_ww_kundenfirma IS NULL
   OR dwh_id_sc_ww_bestweg IS NULL
   OR dwh_id_sc_ww_liefwunschservicedefaultkz IS NULL
   OR dwh_id_sc_ww_zwangskomplettierung IS NULL
) THEN
INTO clsc_ww_lieferwunschservice_e
(
   dwh_cr_load_id,
   dwh_up_load_id,
   dwh_id_sc_ww_kundenfirma,
   dwh_id_sc_ww_bestweg,
   dwh_id_sc_ww_liefwunschservicedefaultkz,
   dwh_id_sc_ww_zwangskomplettierung,
   id,
   kundenfirmaid,
   bestwegid,
   gueltigvon,
   gueltigbis,
   sortkz,
   defaultkz,
   lieferwunschid,
   zwangkomplkz,
   lieferwunschkosten
)
VALUES
(
   dwh_cr_load_id,
   &gbvid,
   dwh_id_sc_ww_kundenfirma,
   dwh_id_sc_ww_bestweg,
   dwh_id_sc_ww_liefwunschservicedefaultkz,
   dwh_id_sc_ww_zwangskomplettierung,
   id,
   kundenfirmaid,
   bestwegid,
   gueltigvon,
   gueltigbis,
   sortkz,
   defaultkz,
   lieferwunschid,
   zwangkomplkz,
   lieferwunschkosten
)
ELSE
INTO clsc_ww_lieferwunschservice
(
   dwh_cr_load_id,
   dwh_id_sc_ww_kundenfirma,
   dwh_id_sc_ww_bestweg,
   dwh_id_sc_ww_liefwunschservicedefaultkz,
   dwh_id_sc_ww_zwangskomplettierung,
   id,
   kundenfirmaid,
   bestwegid,
   gueltigvon,
   gueltigbis,
   sortkz,
   defaultkz,
   lieferwunschid,
   zwangkomplkz,
   lieferwunschkosten
)
SELECT a.dwh_cr_load_id,
       sc_ww_kundenfirma.dwh_id AS dwh_id_sc_ww_kundenfirma,
       sc_ww_bestweg.dwh_id AS dwh_id_sc_ww_bestweg,
       sc_ww_liefwunschservicedefaultkz.dwh_id AS dwh_id_sc_ww_liefwunschservicedefaultkz,
       sc_ww_zwangskomplettierung.dwh_id AS dwh_id_sc_ww_zwangskomplettierung,
       a.id AS id,
       a.kundenfirmaid AS kundenfirmaid,
       a.bestwegid AS bestwegid,
       a.gueltigvon AS gueltigvon,
       a.gueltigbis AS gueltigbis,
       a.sortkz AS sortkz,
       a.defaultkz AS defaultkz,
       a.lieferwunschid AS lieferwunschid,
       a.zwangkomplkz AS zwangkomplkz,
       a.lieferwunschkosten AS lieferwunschkosten
  FROM clsc_ww_lieferwunschservice_1 a
  LEFT JOIN sc_ww_kundenfirma sc_ww_kundenfirma ON (a.kundenfirmaid = sc_ww_kundenfirma.id)
  LEFT JOIN sc_ww_bestweg sc_ww_bestweg ON (a.bestwegid = sc_ww_bestweg.id)
  LEFT JOIN sc_ww_liefwunschservicedefaultkz sc_ww_liefwunschservicedefaultkz ON (a.defaultkz = sc_ww_liefwunschservicedefaultkz.wert)
  LEFT JOIN sc_ww_zwangskomplettierung sc_ww_zwangskomplettierung ON (a.zwangkomplkz = sc_ww_zwangskomplettierung.wert);

COMMIT;


PROMPT ===========================================
PROMPT  6.6 Aktuelle Statistiken erstellen
PROMPT ===========================================

EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_lieferwunschservice');
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_lieferwunschservice_e');



PROMPT =========================================================================
PROMPT
PROMPT 7. Source Core-Ladung
PROMPT Endtabelle: sc_ww_kdfservicekondition / sc_ww_kdfservicekondition_ver
PROMPT
PROMPT =========================================================================



PROMPT ===========================================
PROMPT  7.1 Cleansing Tabellen leeren
PROMPT ===========================================

TRUNCATE TABLE clsc_ww_kdfservicekondition;
TRUNCATE TABLE clsc_ww_kdfservicekondition_1;
TRUNCATE TABLE clsc_ww_kdfservicekondition_d;



PROMPT ===========================================
PROMPT  7.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================

INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_kdfservicekondition_1
(
   dwh_cr_load_id,
   id,
   bestwegid,
   kundenfirmaid,
   zahlmethodeid,
   zahlmethodegebuehr,
   versendergebuehr,
   lieferwunschid,
   lieferwunschgebuehr,
   gueltigvon,
   gueltigbis,
   sortkz,
   zahlwunschid,
   defaultkz,
   aktivkz,
   auftrag_anlaufwegid
)
VALUES
(
   &gbvid,
   id,
   bestwegid,
   kundenfirmaid,
   zahlmethodeid,
   zahlmethodegebuehr,
   versendergebuehr,
   lieferwunschid,
   lieferwunschgebuehr,
   gueltigvon,
   gueltigbis,
   sortkz,
   zahlwunschid,
   defaultkz,
   aktivkz,
   auftrag_anlaufwegid
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_kdfservicekondition_d
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
   bestwegid,
   kundenfirmaid,
   zahlmethodeid,
   zahlmethodegebuehr,
   versendergebuehr,
   lieferwunschid,
   lieferwunschgebuehr,
   gueltigvon,
   gueltigbis,
   sortkz,
   zahlwunschid,
   defaultkz,
   aktivkz,
   auftrag_anlaufwegid
FROM st_ww_kdfservicekondition_b
WHERE dwh_processdate = &termin;

COMMIT;



PROMPT ===========================================
PROMPT  7.3 Aktuelle Statistiken erstellen
PROMPT ===========================================

EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_kdfservicekondition_1');
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_kdfservicekondition_d');



PROMPT ===========================================
PROMPT  7.4 Error Handling
PROMPT ===========================================

EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING ('clsc_ww_kdfservicekondition', 'id', &gbvid);



PROMPT ===========================================
PROMPT  7.5 Einspielen in die letzte SC-Tabelle mit Referenzauflösung
PROMPT ===========================================

INSERT /*+ APPEND */ FIRST
WHEN (dwh_id_sc_ww_bestweg IS NULL
   OR dwh_id_sc_ww_kundenfirma IS NULL
   OR dwh_id_sc_ww_zahlmethode IS NULL
   OR dwh_id_sc_ww_zahlwunsch IS NULL
   OR dwh_id_sc_ww_kdfservicekonditiondefaultkz IS NULL
   OR dwh_id_sc_ww_kdfservicekonditionaktivkz IS NULL
   OR dwh_id_sc_ww_auftrag_anlweg IS NULL
) THEN
INTO clsc_ww_kdfservicekondition_e
(
   dwh_cr_load_id,
   dwh_up_load_id,
   dwh_id_sc_ww_bestweg,
   dwh_id_sc_ww_kundenfirma,
   dwh_id_sc_ww_zahlmethode,
   dwh_id_sc_ww_zahlwunsch,
   dwh_id_sc_ww_kdfservicekonditiondefaultkz,
   dwh_id_sc_ww_kdfservicekonditionaktivkz,
   dwh_id_sc_ww_auftrag_anlweg,
   id,
   bestwegid,
   kundenfirmaid,
   zahlmethodeid,
   zahlmethodegebuehr,
   versendergebuehr,
   lieferwunschid,
   lieferwunschgebuehr,
   gueltigvon,
   gueltigbis,
   sortkz,
   zahlwunschid,
   defaultkz,
   aktivkz,
   auftrag_anlaufwegid
)
VALUES
(
   dwh_cr_load_id,
   &gbvid,
   dwh_id_sc_ww_bestweg,
   dwh_id_sc_ww_kundenfirma,
   dwh_id_sc_ww_zahlmethode,
   dwh_id_sc_ww_zahlwunsch,
   dwh_id_sc_ww_kdfservicekonditiondefaultkz,
   dwh_id_sc_ww_kdfservicekonditionaktivkz,
   dwh_id_sc_ww_auftrag_anlweg,
   id,
   bestwegid,
   kundenfirmaid,
   zahlmethodeid,
   zahlmethodegebuehr,
   versendergebuehr,
   lieferwunschid,
   lieferwunschgebuehr,
   gueltigvon,
   gueltigbis,
   sortkz,
   zahlwunschid,
   defaultkz,
   aktivkz,
   auftrag_anlaufwegid
)
ELSE
INTO clsc_ww_kdfservicekondition
(
   dwh_cr_load_id,
   dwh_id_sc_ww_bestweg,
   dwh_id_sc_ww_kundenfirma,
   dwh_id_sc_ww_zahlmethode,
   dwh_id_sc_ww_zahlwunsch,
   dwh_id_sc_ww_kdfservicekonditiondefaultkz,
   dwh_id_sc_ww_kdfservicekonditionaktivkz,
   dwh_id_sc_ww_auftrag_anlweg,
   id,
   bestwegid,
   kundenfirmaid,
   zahlmethodeid,
   zahlmethodegebuehr,
   versendergebuehr,
   lieferwunschid,
   lieferwunschgebuehr,
   gueltigvon,
   gueltigbis,
   sortkz,
   zahlwunschid,
   defaultkz,
   aktivkz,
   auftrag_anlaufwegid
)
SELECT
   a.dwh_cr_load_id,
   sc_ww_bestweg.dwh_id AS dwh_id_sc_ww_bestweg,
   sc_ww_kundenfirma.dwh_id AS dwh_id_sc_ww_kundenfirma,
   sc_ww_zahlmethode.dwh_id AS dwh_id_sc_ww_zahlmethode,
   sc_ww_zahlwunsch.dwh_id AS dwh_id_sc_ww_zahlwunsch,
   sc_ww_kdfservicekonditiondefaultkz.dwh_id AS dwh_id_sc_ww_kdfservicekonditiondefaultkz,
   sc_ww_kdfservicekonditionaktivkz.dwh_id AS dwh_id_sc_ww_kdfservicekonditionaktivkz,
   sc_ww_auftrag_anlweg.dwh_id AS dwh_id_sc_ww_auftrag_anlweg,
   a.id AS id,
   a.bestwegid AS bestwegid,
   a.kundenfirmaid AS kundenfirmaid,
   a.zahlmethodeid AS zahlmethodeid,
   a.zahlmethodegebuehr AS zahlmethodegebuehr,
   a.versendergebuehr AS versendergebuehr,
   a.lieferwunschid AS lieferwunschid,
   a.lieferwunschgebuehr AS lieferwunschgebuehr,
   a.gueltigvon AS gueltigvon,
   a.gueltigbis AS gueltigbis,
   a.sortkz AS sortkz,
   a.zahlwunschid AS zahlwunschid,
   a.defaultkz AS defaultkz,
   a.aktivkz AS aktivkz,
   a.auftrag_anlaufwegid AS auftrag_anlaufwegid
FROM clsc_ww_kdfservicekondition_1 a
  LEFT JOIN sc_ww_bestweg sc_ww_bestweg ON (a.bestwegid = sc_ww_bestweg.id)
  LEFT JOIN sc_ww_kundenfirma sc_ww_kundenfirma ON (a.kundenfirmaid = sc_ww_kundenfirma.id)
  LEFT JOIN sc_ww_zahlmethode sc_ww_zahlmethode ON (a.zahlmethodeid = sc_ww_zahlmethode.id)
  LEFT JOIN sc_ww_zahlwunsch sc_ww_zahlwunsch ON (a.zahlwunschid = sc_ww_zahlwunsch.id)
  LEFT JOIN sc_ww_kdfservicekonditiondefaultkz sc_ww_kdfservicekonditiondefaultkz ON (a.defaultkz = sc_ww_kdfservicekonditiondefaultkz.wert)
  LEFT JOIN sc_ww_kdfservicekonditionaktivkz sc_ww_kdfservicekonditionaktivkz ON (a.aktivkz = sc_ww_kdfservicekonditionaktivkz.wert)
  LEFT JOIN sc_ww_auftrag_anlweg sc_ww_auftrag_anlweg ON (a.auftrag_anlaufwegid = sc_ww_auftrag_anlweg.id);

COMMIT;



PROMPT ===========================================
PROMPT  7.6 Aktuelle Statistiken erstellen
PROMPT ===========================================

EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_kdfservicekondition');
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_kdfservicekondition_e');



PROMPT =========================================================================
PROMPT
PROMPT 8. Source Core-Ladung
PROMPT Endtabelle: sc_ww_kundenfirmaservice / sc_ww_kundenfirmaservice_ver
PROMPT
PROMPT =========================================================================



PROMPT ===========================================
PROMPT  8.1 Cleansing Tabellen leeren
PROMPT ===========================================

TRUNCATE TABLE clsc_ww_kundenfirmaservice;
TRUNCATE TABLE clsc_ww_kundenfirmaservice_1;
TRUNCATE TABLE clsc_ww_kundenfirmaservice_d;



PROMPT ===========================================
PROMPT  8.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================

INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_kundenfirmaservice_1
(
   dwh_cr_load_id,
   id,
   kundenfirmaid,
   gueltigvon,
   gueltigbis,
   versandkosten,
   speditionkosten,
   einmaligeretourekosten,
   annahmeverweigertkosten,
   vorkasseproz
)
VALUES
(
   &gbvid,
   id,
   kundenfirmaid,
   gueltigvon,
   gueltigbis,
   versandkosten,
   speditionkosten,
   einmaligeretourekosten,
   annahmeverweigertkosten,
   vorkasseproz
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_kundenfirmaservice_d
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
   kundenfirmaid,
   gueltigvon,
   gueltigbis,
   versandkosten,
   speditionkosten,
   einmaligeretourekosten,
   annahmeverweigertkosten,
   vorkasseproz
FROM st_ww_kundenfirmaservice_b
WHERE dwh_processdate = &termin;

COMMIT;



PROMPT ===========================================
PROMPT  8.3 Aktuelle Statistiken erstellen
PROMPT ===========================================

EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_kundenfirmaservice_1');
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_kundenfirmaservice_d');



PROMPT ===========================================
PROMPT  8.4 Error Handling
PROMPT ===========================================

EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING ('clsc_ww_kundenfirmaservice', 'id', &gbvid);



PROMPT ===========================================
PROMPT  8.5 Einspielen in die letzte SC-Tabelle mit Referenzauflösung
PROMPT ===========================================

INSERT /*+ APPEND */ FIRST
WHEN (dwh_id_sc_ww_kundenfirma IS NULL
) THEN
INTO clsc_ww_kundenfirmaservice_e
(
   dwh_cr_load_id,
   dwh_up_load_id,
   dwh_id_sc_ww_kundenfirma,
   id,
   kundenfirmaid,
   gueltigvon,
   gueltigbis,
   versandkosten,
   speditionkosten,
   einmaligeretourekosten,
   annahmeverweigertkosten,
   vorkasseproz
)
VALUES
(
   dwh_cr_load_id,
   &gbvid,
   dwh_id_sc_ww_kundenfirma,
   id,
   kundenfirmaid,
   gueltigvon,
   gueltigbis,
   versandkosten,
   speditionkosten,
   einmaligeretourekosten,
   annahmeverweigertkosten,
   vorkasseproz
)
ELSE
INTO clsc_ww_kundenfirmaservice
(
   dwh_cr_load_id,
   dwh_id_sc_ww_kundenfirma,
   id,
   kundenfirmaid,
   gueltigvon,
   gueltigbis,
   versandkosten,
   speditionkosten,
   einmaligeretourekosten,
   annahmeverweigertkosten,
   vorkasseproz
)
SELECT a.dwh_cr_load_id,
       sc_ww_kundenfirma.dwh_id AS dwh_id_sc_ww_kundenfirma,
       a.id AS id,
       a.kundenfirmaid AS kundenfirmaid,
       a.gueltigvon AS gueltigvon,
       a.gueltigbis AS gueltigbis,
       a.versandkosten AS versandkosten,
       a.speditionkosten AS speditionkosten,
       a.einmaligeretourekosten AS einmaligeretourekosten,
       a.annahmeverweigertkosten AS annahmeverweigertkosten,
       a.vorkasseproz AS vorkasseproz
  FROM clsc_ww_kundenfirmaservice_1 a
  LEFT JOIN sc_ww_kundenfirma sc_ww_kundenfirma ON (a.kundenfirmaid = sc_ww_kundenfirma.id);

COMMIT;



PROMPT ===========================================
PROMPT  8.6 Aktuelle Statistiken erstellen
PROMPT ===========================================

EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_kundenfirmaservice');
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_kundenfirmaservice_e');