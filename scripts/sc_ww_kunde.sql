/*******************************************************************************

Job:                    sc_ww_kunde
Beschreibung:           Job laedt Kundentabellen in das Source Core 
                    
Erstellt am:            xx.04.2016
Erstellt von:           Stefan Ernstberger
Ansprechpartner:        Stefan Ernstberger, Jochen Koenig
Ansprechpartner-IT:     Anton Roithmeier, Thomas Hoesl

verwendete Tabellen:    st_ww_kunde_b
Endtabellen:            sc_ww_kunde
                        sc_ww_kunde_ver
Fehler-Doku:            -
Ladestrecke:            -

********************************************************************************
geaendert am:            05.05.2017
geaendert von:           steern  
Aenderungen:             dbfakturakz nachtraeglich eingebaut
********************************************************************************
geaendert am:            07.11.2017
geaendert von:           steern  
Aenderungen:             vskflateratekz raus, 
                         Referenzaufloesung auf nladrassherkunft, servicemailaktiv,
                         kdloginaktiv, katerstversand
********************************************************************************
geaendert am:            12.11.2017
geaendert von:           steern  
Aenderungen:             kontosperre eingebaut
********************************************************************************
geaendert am:            07.06.2018
geaendert von:           steern  
Aenderungen:             ADRESSEAUSVORTEILSNUMMER eingebaut
********************************************************************************
geaendert am:            11.06.2018
geaendert von:           steern  
Aenderungen:             KUNDE erweitert um folgende Spalten:
                          -KDLOGINREMINDERDDAT
                          -LOGINAKTIVIERUNGSLINK
                          -PERSONSTAMMPRUEFID
                          -SC_ERGID
                          -PROZESSIDANL  
                          -PROZESSIDLETZTAEND
                          -BENUTZERIDANL
                          -BENUTZERIDLETZTAEND  
                          -SCHECKAUSZAHLKZ      
                          -NEUKUNDEKZ
                          -ANZAHLHAUPTKATALOG  
                          -EOSCREDCARD
                          -FGIDSTAMM  
                          -WUNSCHKZIDFILIALWERB
********************************************************************************
geändert am:          19.07.2018
geändert von:         maxlin   
Aenderungen:          Anpassungen an Clearingstelle:
                      -KundeID wird id_key,
                      -PersonID wird personid_key,
                      -kdnr durch Key(pseudinymisierte Konto-ID) ersetzt
                      -nur noch Verhaltenskundendaten
********************************************************************************
geändert am:          10.12.2018
geändert von:         maxlin   
Aenderungen:          Umzug auf UDWH1
********************************************************************************
geändert am:          01.09.2021
geändert von:         steern   
Aenderungen:          kontonrletzteziffern hinzugefuegt
********************************************************************************
geändert am:          29.10.2021
geändert von:         steern   
Aenderungen:          kdnr, id, konto_id, verwkdnr ausgebaut
********************************************************************************
geändert am:          22.02.2024
geändert von:         steern   
Aenderungen:          newsletterid und nlwunschid aus Referenzaufloesung rausgenommen, da nicht mehr relevant. 
********************************************************************************
geändert am:          11.07.2024
geändert von:         steern   
Aenderungen:          Einbau eigenfremdkaufkz
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
PROMPT Endtabelle: sc_ww_kunde / sc_ww_kunde_ver
PROMPT
PROMPT =========================================================================



PROMPT ===========================================
PROMPT  1.1 Cleansing Tabellen leeren
PROMPT ===========================================

TRUNCATE TABLE clsc_ww_kunde;
TRUNCATE TABLE clsc_ww_kunde_1;
TRUNCATE TABLE clsc_ww_kunde_d;



PROMPT ===========================================
PROMPT  1.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================

INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_kunde_1
(
  dwh_cr_load_id,
  id_key,
  konto_id_key,
  kontonrletzteziffern,
  personid_key,
  kdartid,
  boniklid,
  mahnebid,
  mahnstrangid,
  beschaeftigungid,
  verswunschid,
  werbmitid,
  ersatzartid,
  wkz,
  iwl,
  katnachvers,
  katlimit,
  katerstverskz,
  valkz,
  vtinfokdgrp,
  rgkfumstdat,
  verwkonto_id_key,
  anlaufdat,
  anlaufsaison,
  letztaenddat,
  firma,
  kundenfirmaid,
  bonisperrid,
  kdsperrid,
  telemkid,
  newsletterid,
  nachbarschabgid,
  tddsgid,
  newslettertypid,
  nlabonnentstatusid,
  adressherkunftid,
  testgrp,
  telemkeinwid,
  bekuansprkz,
  bekuansprgew,
  kdloginaktivstatkz,
  kdloginaktivierungsdat,
  kdloginlinksenddat,
  servicemailaktivkz,
  dbfakturakz,
  kontosperreid,
  adresseausvorteilsnummer,
  kdloginreminderddat,
  loginaktivierungslink,
  sc_ergid,
  prozessidanl,  
  prozessidletztaend,
  benutzeridanl,
  benutzeridletztaend,  
  scheckauszahlkz,      
  neukundekz,
  anzahlhauptkatalog,  
  eoscredcard,
  fgidstamm,  
  wunschkzidfilialwerb,
  eigenfremdkaufkz
  )
VALUES
(
  &gbvid,
  id_key,
  konto_id_key,
  kontonrletzteziffern,
  personid_key,
  kdartid,
  boniklid,
  mahnebid,
  mahnstrangid,
  beschaeftigungid,
  verswunschid,
  werbmitid,
  ersatzartid,
  wkz,
  iwl,
  katnachvers,
  katlimit,
  katerstverskz,
  valkz,
  vtinfokdgrp,
  rgkfumstdat,
  verwkonto_id_key,
  anlaufdat,
  anlaufsaison,
  letztaenddat,
  firma,
  kundenfirmaid,
  bonisperrid,
  kdsperrid,
  telemkid,
  newsletterid,
  nachbarschabgid,
  tddsgid,
  newslettertypid,
  nlabonnentstatusid,
  adressherkunftid,
  testgrp,
  telemkeinwid,
  bekuansprkz,
  bekuansprgew,
  kdloginaktivstatkz,
  kdloginaktivierungsdat,
  kdloginlinksenddat,
  servicemailaktivkz,
  dbfakturakz,
  kontosperreid,
  adresseausvorteilsnummer,
  kdloginreminderddat,
  loginaktivierungslink,
  sc_ergid,
  prozessidanl,  
  prozessidletztaend,
  benutzeridanl,
  benutzeridletztaend,  
  scheckauszahlkz,      
  neukundekz,
  anzahlhauptkatalog,  
  eoscredcard,
  fgidstamm,  
  wunschkzidfilialwerb,
  eigenfremdkaufkz
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_kunde_d
(
  dwh_cr_load_id,
  id_key
--  id
)
VALUES
(
  &gbvid,
  id_key
 -- id
)
SELECT DISTINCT 
  dwh_stbflag,
  id_key,
  konto_id_key,
  kontonrletzteziffern,
  personid_key,
  kdartid,
  boniklid,
  mahnebid,
  mahnstrangid,
  beschaeftigungid,
  verswunschid,
  werbmitid,
  ersatzartid,
  wkz,
  iwl,
  katnachvers,
  katlimit,
  katerstverskz,
  valkz,
  vtinfokdgrp,
  rgkfumstdat,
  verwkonto_id_key,
  anlaufdat,
  anlaufsaison,
  letztaenddat,
  firma,
  kundenfirmaid,
  bonisperrid,
  kdsperrid,
  telemkid,
  newsletterid,
  nachbarschabgid,
  tddsgid,
  newslettertypid,
  nlabonnentstatusid,
  adressherkunftid,
  testgrp,
  telemkeinwid,
  bekuansprkz,
  bekuansprgew,
  kdloginaktivstatkz,
  kdloginaktivierungsdat,
  kdloginlinksenddat,
  servicemailaktivkz,
  dbfakturakz,
  kontosperreid,
  adresseausvorteilsnummer,
  kdloginreminderddat,
  loginaktivierungslink,
  sc_ergid,
  prozessidanl,  
  prozessidletztaend,
  benutzeridanl,
  benutzeridletztaend,  
  scheckauszahlkz,      
  neukundekz,
  anzahlhauptkatalog,  
  eoscredcard,
  fgidstamm,  
  wunschkzidfilialwerb,
  eigenfremdkaufkz
FROM
st_ww_kunde_b
WHERE dwh_processdate = &termin;

COMMIT;



PROMPT ===========================================
PROMPT  1.3 Aktuelle Statistiken erstellen
PROMPT ===========================================

EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_kunde_1');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_kunde_d');
 


PROMPT ===========================================
PROMPT  1.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING('clsc_ww_kunde', 'id_key', &gbvid);



PROMPT ===========================================
PROMPT  1.5 Einspielen in die letzte SC-Tabelle mit Referenzauflösung
PROMPT ===========================================

INSERT /*+ APPEND */ FIRST
WHEN ( dwh_id_sc_ww_person IS NULL OR dwh_id_sc_ww_kdart IS NULL OR dwh_id_sc_ww_bonikl IS NULL OR dwh_id_sc_ww_mahneb IS NULL OR dwh_id_sc_ww_mahnstrang IS NULL OR dwh_id_sc_ww_beschaeftigung IS NULL OR
       dwh_id_sc_ww_verswunsch IS NULL OR dwh_id_sc_ww_werbmit IS NULL OR dwh_id_sc_ww_ersatzart IS NULL OR dwh_id_sc_ww_kundenfirma IS NULL OR dwh_id_sc_ww_bonisperr IS NULL OR
       dwh_id_sc_ww_kdsperr IS NULL OR dwh_id_sc_ww_telemk IS NULL 
       --OR dwh_id_sc_ww_newsletter IS NULL 
       OR dwh_id_sc_ww_nachbarschabg IS NULL OR dwh_id_sc_ww_nladressherkunft IS NULL OR
       dwh_id_sc_ww_servicemailaktiv IS NULL OR dwh_id_sc_ww_katerstvers IS NULL OR dwh_id_sc_ww_kdloginaktivkz IS NULL OR dwh_id_sc_ww_kontosperre IS NULL 
       OR dwh_id_sc_ww_adrausvorteilsnr IS NULL
       OR   dwh_id_sc_ww_prozessanl     IS NULL OR dwh_id_sc_ww_prozessletztaend IS NULL OR dwh_id_sc_ww_benutzeranl IS NULL OR dwh_id_sc_ww_benutzerletztaend IS NULL OR  dwh_id_sc_ww_scheckauszahlkz IS NULL
       OR dwh_id_sc_ww_neukundekz IS NULL OR dwh_id_sc_ww_wunschkzidfilialwerb IS NULL or dwh_id_sc_ww_fg IS NULL
       OR dwh_id_sc_ww_eigenfremdkaufkz IS NULL
 ) THEN
INTO clsc_ww_kunde_e
(
  dwh_cr_load_id,
  dwh_up_load_id,
  dwh_id_sc_ww_person,
  dwh_id_sc_ww_kdart,
  dwh_id_sc_ww_bonikl,
  dwh_id_sc_ww_mahneb,
  dwh_id_sc_ww_mahnstrang,
  dwh_id_sc_ww_beschaeftigung,
  dwh_id_sc_ww_verswunsch,
  dwh_id_sc_ww_werbmit,
  dwh_id_sc_ww_ersatzart,
  dwh_id_sc_ww_kundenfirma,
  dwh_id_sc_ww_bonisperr,
  dwh_id_sc_ww_kdsperr,
  dwh_id_sc_ww_telemk,
  dwh_id_sc_ww_nachbarschabg,
  dwh_id_sc_ww_tddsg,
  dwh_id_sc_ww_nltyp,
  dwh_id_sc_ww_adreinw,
  dwh_id_sc_ww_nladressherkunft,
  dwh_id_sc_ww_servicemailaktiv,
  dwh_id_sc_ww_katerstvers,
  dwh_id_sc_ww_kdloginaktivkz,
  dwh_id_sc_ww_kontosperre,
  dwh_id_sc_ww_adrausvorteilsnr,
  dwh_id_sc_ww_prozessanl       ,
  dwh_id_sc_ww_prozessletztaend ,
  dwh_id_sc_ww_benutzeranl      ,
  dwh_id_sc_ww_benutzerletztaend,
  dwh_id_sc_ww_scheckauszahlkz    ,
  dwh_id_sc_ww_neukundekz         ,
  dwh_id_sc_ww_wunschkzidfilialwerb ,
  dwh_id_sc_ww_fg,  
  dwh_id_sc_ww_eigenfremdkaufkz,
  id_key,
  konto_id_key,
  kontonrletzteziffern,
  personid_key,
  kdartid,
  boniklid,
  mahnebid,
  mahnstrangid,
  beschaeftigungid,
  verswunschid,
  werbmitid,
  ersatzartid,
  wkz,
  iwl,
  katnachvers,
  katlimit,
  katerstverskz,
  valkz,
  vtinfokdgrp,
  rgkfumstdat,
  verwkonto_id_key,
  anlaufdat,
  anlaufsaison,
  letztaenddat,
  firma,
  kundenfirmaid,
  bonisperrid,
  kdsperrid,
  telemkid,
  newsletterid,
  nachbarschabgid,
  tddsgid,
  newslettertypid,
  nlabonnentstatusid,
  adressherkunftid,
  testgrp,
  telemkeinwid,
  bekuansprkz,
  bekuansprgew,
  kdloginaktivstatkz,
  kdloginaktivierungsdat,
  kdloginlinksenddat,
  servicemailaktivkz,
  dbfakturakz,
  kontosperreid,
  adresseausvorteilsnummer,
  kdloginreminderddat,
  loginaktivierungslink,
  sc_ergid,
  prozessidanl,  
  prozessidletztaend,
  benutzeridanl,
  benutzeridletztaend,  
  scheckauszahlkz,      
  neukundekz,
  anzahlhauptkatalog,  
  eoscredcard,
  fgidstamm,  
  wunschkzidfilialwerb,
  eigenfremdkaufkz
)
VALUES
(
  dwh_cr_load_id,
  &gbvid,
  dwh_id_sc_ww_person,
  dwh_id_sc_ww_kdart,
  dwh_id_sc_ww_bonikl,
  dwh_id_sc_ww_mahneb,
  dwh_id_sc_ww_mahnstrang,
  dwh_id_sc_ww_beschaeftigung,
  dwh_id_sc_ww_verswunsch,
  dwh_id_sc_ww_werbmit,
  dwh_id_sc_ww_ersatzart,
  dwh_id_sc_ww_kundenfirma,
  dwh_id_sc_ww_bonisperr,
  dwh_id_sc_ww_kdsperr,
  dwh_id_sc_ww_telemk,
  dwh_id_sc_ww_nachbarschabg,
  dwh_id_sc_ww_tddsg,
  dwh_id_sc_ww_nltyp,
  dwh_id_sc_ww_adreinw,
  dwh_id_sc_ww_nladressherkunft,
  dwh_id_sc_ww_servicemailaktiv,
  dwh_id_sc_ww_katerstvers,
  dwh_id_sc_ww_kdloginaktivkz,
  dwh_id_sc_ww_kontosperre,
  dwh_id_sc_ww_adrausvorteilsnr,
  dwh_id_sc_ww_prozessanl       ,
  dwh_id_sc_ww_prozessletztaend ,
  dwh_id_sc_ww_benutzeranl      ,
  dwh_id_sc_ww_benutzerletztaend,
  dwh_id_sc_ww_scheckauszahlkz    ,
  dwh_id_sc_ww_neukundekz         ,
  dwh_id_sc_ww_wunschkzidfilialwerb ,
  dwh_id_sc_ww_fg,
  dwh_id_sc_ww_eigenfremdkaufkz,
  id_key,
  konto_id_key,
  kontonrletzteziffern,
  personid_key,
  kdartid,
  boniklid,
  mahnebid,
  mahnstrangid,
  beschaeftigungid,
  verswunschid,
  werbmitid,
  ersatzartid,
  wkz,
  iwl,
  katnachvers,
  katlimit,
  katerstverskz,
  valkz,
  vtinfokdgrp,
  rgkfumstdat,
  verwkonto_id_key,
  anlaufdat,
  anlaufsaison,
  letztaenddat,
  firma,
  kundenfirmaid,
  bonisperrid,
  kdsperrid,
  telemkid,
  newsletterid,
  nachbarschabgid,
  tddsgid,
  newslettertypid,
  nlabonnentstatusid,
  adressherkunftid,
  testgrp,
  telemkeinwid,
  bekuansprkz,
  bekuansprgew,
  kdloginaktivstatkz,
  kdloginaktivierungsdat,
  kdloginlinksenddat,
  servicemailaktivkz,
  dbfakturakz,
  kontosperreid,
  adresseausvorteilsnummer,
  kdloginreminderddat,
  loginaktivierungslink,
  sc_ergid,
  prozessidanl,  
  prozessidletztaend,
  benutzeridanl,
  benutzeridletztaend,  
  scheckauszahlkz,      
  neukundekz,
  anzahlhauptkatalog,  
  eoscredcard,
  fgidstamm,  
  wunschkzidfilialwerb,
  eigenfremdkaufkz
)
ELSE
INTO clsc_ww_kunde
(
  dwh_cr_load_id,
  dwh_id_sc_ww_person,
  dwh_id_sc_ww_kdart,
  dwh_id_sc_ww_bonikl,
  dwh_id_sc_ww_mahneb,
  dwh_id_sc_ww_mahnstrang,
  dwh_id_sc_ww_beschaeftigung,
  dwh_id_sc_ww_verswunsch,
  dwh_id_sc_ww_werbmit,
  dwh_id_sc_ww_ersatzart,
  dwh_id_sc_ww_kundenfirma,
  dwh_id_sc_ww_bonisperr,
  dwh_id_sc_ww_kdsperr,
  dwh_id_sc_ww_telemk,
  dwh_id_sc_ww_newsletter,
  dwh_id_sc_ww_nachbarschabg,
  dwh_id_sc_ww_tddsg,
  dwh_id_sc_ww_nltyp,
  dwh_id_sc_ww_nlabonnentstatus,
  dwh_id_sc_ww_adreinw,
  dwh_id_sc_ww_nladressherkunft,
  dwh_id_sc_ww_servicemailaktiv,
  dwh_id_sc_ww_katerstvers,
  dwh_id_sc_ww_kdloginaktivkz,
  dwh_id_sc_ww_kontosperre,
  dwh_id_sc_ww_adrausvorteilsnr,
  dwh_id_sc_ww_prozessanl       ,
  dwh_id_sc_ww_prozessletztaend ,
  dwh_id_sc_ww_benutzeranl      ,
  dwh_id_sc_ww_benutzerletztaend,
  dwh_id_sc_ww_scheckauszahlkz    ,
  dwh_id_sc_ww_neukundekz         ,
  dwh_id_sc_ww_wunschkzidfilialwerb ,
  dwh_id_sc_ww_fg,
  dwh_id_sc_ww_eigenfremdkaufkz,
  id_key,
  konto_id_key,
  kontonrletzteziffern,
  personid_key,
  kdartid,
  boniklid,
  mahnebid,
  mahnstrangid,
  beschaeftigungid,
  verswunschid,
  werbmitid,
  ersatzartid,
  wkz,
  iwl,
  katnachvers,
  katlimit,
  katerstverskz,
  valkz,
  vtinfokdgrp,
  rgkfumstdat,
  verwkonto_id_key,
  anlaufdat,
  anlaufsaison,
  letztaenddat,
  firma,
  kundenfirmaid,
  bonisperrid,
  kdsperrid,
  telemkid,
  newsletterid,
  nachbarschabgid,
  tddsgid,
  newslettertypid,
  nlabonnentstatusid,
  adressherkunftid,
  testgrp,
  telemkeinwid,
  bekuansprkz,
  bekuansprgew,
  kdloginaktivstatkz,
  kdloginaktivierungsdat,
  kdloginlinksenddat,
  servicemailaktivkz,
  dbfakturakz, 
  kontosperreid,
  adresseausvorteilsnummer,
  kdloginreminderddat,
  loginaktivierungslink,
  sc_ergid,
  prozessidanl,  
  prozessidletztaend,
  benutzeridanl,
  benutzeridletztaend,  
  scheckauszahlkz,      
  neukundekz,
  anzahlhauptkatalog,  
  eoscredcard,
  fgidstamm,  
  wunschkzidfilialwerb,
  eigenfremdkaufkz
)
SELECT 
  a.dwh_cr_load_id,
  sc_ww_person.dwh_id AS dwh_id_sc_ww_person,
  sc_ww_kdart.dwh_id AS dwh_id_sc_ww_kdart,
  sc_ww_bonikl.dwh_id AS dwh_id_sc_ww_bonikl,
  sc_ww_mahneb.dwh_id AS dwh_id_sc_ww_mahneb,
  sc_ww_mahnstrang.dwh_id AS dwh_id_sc_ww_mahnstrang,
  sc_ww_besch.dwh_id AS dwh_id_sc_ww_beschaeftigung,
  sc_ww_verswunsch.dwh_id AS dwh_id_sc_ww_verswunsch,
  sc_ww_werbmit.dwh_id AS dwh_id_sc_ww_werbmit,
  sc_ww_ersatzart.dwh_id AS dwh_id_sc_ww_ersatzart,
  sc_ww_kundenfirma.dwh_id AS dwh_id_sc_ww_kundenfirma,
  sc_ww_bonisperr.dwh_id AS dwh_id_sc_ww_bonisperr,
  sc_ww_kdsperr.dwh_id AS dwh_id_sc_ww_kdsperr,
  sc_ww_telemk.dwh_id AS dwh_id_sc_ww_telemk,
  25314038739 AS dwh_id_sc_ww_newsletter, -- Wert für $, da mittlerweile obsolet
  sc_ww_nachbarschabg.dwh_id AS dwh_id_sc_ww_nachbarschabg,
  sc_ww_tddsg.dwh_id AS dwh_id_sc_ww_tddsg,
  sc_ww_nltyp.dwh_id AS dwh_id_sc_ww_nltyp,
  25314038757 AS dwh_id_sc_ww_nlabonnentstatus, -- Wert für $, da mittlerweile obsolet
  sc_ww_adreinw.dwh_id AS dwh_id_sc_ww_adreinw,
  sc_ww_nladressherkunft.dwh_id AS dwh_id_sc_ww_nladressherkunft,
  sc_ww_servicemailaktiv.dwh_id AS dwh_id_sc_ww_servicemailaktiv,
  sc_ww_katerstvers.dwh_id AS dwh_id_sc_ww_katerstvers,
  sc_ww_kdloginaktivkz.dwh_id AS dwh_id_sc_ww_kdloginaktivkz,
  sc_ww_kontosperre.dwh_id AS dwh_id_sc_ww_kontosperre,
  sc_ww_adrausvorteilsnr.dwh_id AS dwh_id_sc_ww_adrausvorteilsnr,
  sc_ww_prozessanl.dwh_id AS dwh_id_sc_ww_prozessanl,
  sc_ww_prozessletztaend.dwh_id AS dwh_id_sc_ww_prozessletztaend,
  sc_ww_benutzeranl.dwh_id AS dwh_id_sc_ww_benutzeranl,
  sc_ww_benutzerletztaend.dwh_id AS dwh_id_sc_ww_benutzerletztaend,
  sc_ww_scheckauszahlkz.dwh_id AS dwh_id_sc_ww_scheckauszahlkz,
  sc_ww_neukundekz.dwh_id AS dwh_id_sc_ww_neukundekz,
  sc_ww_wunschfilialwerb.dwh_id AS dwh_id_sc_ww_wunschkzidfilialwerb,
  sc_ww_fg.dwh_id AS dwh_id_sc_ww_fg,
  sc_ww_eigenfremdkaufkz.dwh_id AS dwh_id_sc_ww_eigenfremdkaufkz,
  a.id_key,
  a.konto_id_key,
  a.kontonrletzteziffern,
  a.personid_key,
  a.kdartid,
  a.boniklid,
  a.mahnebid,
  a.mahnstrangid,
  a.beschaeftigungid,
  a.verswunschid,
  a.werbmitid,
  a.ersatzartid,
  a.wkz,
  a.iwl,
  a.katnachvers,
  a.katlimit,
  a.katerstverskz,
  a.valkz,
  a.vtinfokdgrp,
  a.rgkfumstdat,
  a.verwkonto_id_key,
  a.anlaufdat,
  a.anlaufsaison,
  a.letztaenddat,
  a.firma,
  a.kundenfirmaid,
  a.bonisperrid,
  a.kdsperrid,
  a.telemkid,
  a.newsletterid,
  a.nachbarschabgid,
  a.tddsgid,
  a.newslettertypid,
  a.nlabonnentstatusid,
  a.adressherkunftid,
  a.testgrp,
  a.telemkeinwid,
  a.bekuansprkz,
  a.bekuansprgew,
  a.kdloginaktivstatkz,
  a.kdloginaktivierungsdat,
  a.kdloginlinksenddat,
  a.servicemailaktivkz,
  a.dbfakturakz,
  a.kontosperreid,
  a.adresseausvorteilsnummer,
  a.kdloginreminderddat,
  a.loginaktivierungslink,
  a.sc_ergid,
  a.prozessidanl,  
  a.prozessidletztaend,
  a.benutzeridanl,
  a.benutzeridletztaend,  
  a.scheckauszahlkz,      
  a.neukundekz,
  a.anzahlhauptkatalog,  
  a.eoscredcard,
  a.fgidstamm,  
  a.wunschkzidfilialwerb,
  a.eigenfremdkaufkz
FROM clsc_ww_kunde_1 a
LEFT OUTER JOIN
  ( SELECT sc_ww_person.dwh_id, sc_ww_person.id_key FROM sc_ww_person) sc_ww_person
  ON (a.personid_key = sc_ww_person.id_key)
LEFT OUTER JOIN
  ( SELECT sc_ww_kdart.dwh_id, sc_ww_kdart.id FROM sc_ww_kdart) sc_ww_kdart
  ON (a.kdartid = sc_ww_kdart.id)
LEFT OUTER JOIN
  ( SELECT sc_ww_bonikl.dwh_id, sc_ww_bonikl.id FROM sc_ww_bonikl) sc_ww_bonikl
  ON (a.boniklid = sc_ww_bonikl.id)
LEFT OUTER JOIN
  ( SELECT sc_ww_mahneb.dwh_id, sc_ww_mahneb.id FROM sc_ww_mahneb) sc_ww_mahneb
  ON (a.mahnebid = sc_ww_mahneb.id)
LEFT OUTER JOIN
  ( SELECT sc_ww_mahnstrang.dwh_id, sc_ww_mahnstrang.id FROM sc_ww_mahnstrang) sc_ww_mahnstrang
  ON (a.mahnstrangid = sc_ww_mahnstrang.id)
LEFT OUTER JOIN
  ( SELECT sc_ww_beschaeftigung.dwh_id, sc_ww_beschaeftigung.id FROM sc_ww_beschaeftigung) sc_ww_besch
  ON (a.beschaeftigungid = sc_ww_besch.id)
LEFT OUTER JOIN
  ( SELECT sc_ww_verswunsch.dwh_id, sc_ww_verswunsch.id FROM sc_ww_verswunsch) sc_ww_verswunsch
  ON (a.verswunschid = sc_ww_verswunsch.id)
LEFT OUTER JOIN
  ( SELECT sc_ww_werbmit.dwh_id, sc_ww_werbmit.id FROM sc_ww_werbmit) sc_ww_werbmit
  ON (a.werbmitid = sc_ww_werbmit.id)
LEFT OUTER JOIN
  ( SELECT sc_ww_ersatzart.dwh_id, sc_ww_ersatzart.id FROM sc_ww_ersatzart) sc_ww_ersatzart    -- synonym auf SC_WW_wunschkz
  ON (a.ersatzartid = sc_ww_ersatzart.id)
LEFT OUTER JOIN
  ( SELECT sc_ww_kundenfirma.dwh_id, sc_ww_kundenfirma.id FROM sc_ww_kundenfirma) sc_ww_kundenfirma
  ON (a.kundenfirmaid = sc_ww_kundenfirma.id)
LEFT OUTER JOIN
  ( SELECT sc_ww_bonisperr.dwh_id, sc_ww_bonisperr.id FROM sc_ww_bonisperr) sc_ww_bonisperr
  ON (a.bonisperrid = sc_ww_bonisperr.id)
LEFT OUTER JOIN
  ( SELECT sc_ww_kdsperr.dwh_id, sc_ww_kdsperr.id FROM sc_ww_kdsperr) sc_ww_kdsperr
  ON (a.kdsperrid = sc_ww_kdsperr.id)
LEFT OUTER JOIN
  ( SELECT sc_ww_telemk.dwh_id, sc_ww_telemk.id FROM sc_ww_telemk) sc_ww_telemk -- synonym auf SC_WW_wunschkz
  ON (a.telemkid = sc_ww_telemk.id)
LEFT OUTER JOIN
  ( SELECT sc_ww_nachbarschabg.dwh_id, sc_ww_nachbarschabg.id FROM sc_ww_nachbarschabg) sc_ww_nachbarschabg   -- synonym auf SC_WW_wunschkz
  ON (a.nachbarschabgid = sc_ww_nachbarschabg.id)
LEFT OUTER JOIN
  ( SELECT sc_ww_tddsg.dwh_id, sc_ww_tddsg.id FROM sc_ww_tddsg) sc_ww_tddsg   -- synonym auf SC_WW_wunschkz
  ON (COALESCE(a.tddsgid, '$') = sc_ww_tddsg.id)
LEFT OUTER JOIN
  ( SELECT sc_ww_nltyp.dwh_id, sc_ww_nltyp.id FROM sc_ww_nltyp) sc_ww_nltyp
  ON (COALESCE(a.newslettertypid, '$') = sc_ww_nltyp.id)
LEFT OUTER JOIN
  ( SELECT sc_ww_adreinw.dwh_id, sc_ww_adreinw.id FROM sc_ww_adreinw) sc_ww_adreinw  -- synonym auf SC_WW_telemkeinw
  ON (COALESCE(a.telemkeinwid, '$') = sc_ww_adreinw.id)
LEFT OUTER JOIN 
  ( SELECT sc_ww_nladressherkunft.dwh_id, sc_ww_nladressherkunft.id FROM sc_ww_nladressherkunft) sc_ww_nladressherkunft
  ON (COALESCE(a.adressherkunftid, '$') = sc_ww_nladressherkunft.id)
LEFT OUTER JOIN 
  ( SELECT sc_ww_servicemailaktiv.dwh_id, sc_ww_servicemailaktiv.wert FROM sc_ww_servicemailaktiv ) sc_ww_servicemailaktiv
  ON (a.servicemailaktivkz = sc_ww_servicemailaktiv.wert)
LEFT OUTER JOIN 
  ( SELECT sc_ww_katerstvers.dwh_id, sc_ww_katerstvers.wert  FROM sc_ww_katerstvers) sc_ww_katerstvers
  ON (COALESCE(TO_NUMBER(a.katerstverskz), -3) = sc_ww_katerstvers.wert)
LEFT OUTER JOIN 
  ( SELECT sc_ww_kdloginaktivkz.dwh_id, sc_ww_kdloginaktivkz.wert FROM sc_ww_kdloginaktivkz ) sc_ww_kdloginaktivkz
  ON (COALESCE(TO_NUMBER(a.kdloginaktivstatkz), -3) = sc_ww_kdloginaktivkz.wert)
LEFT OUTER JOIN 
  ( SELECT sc_ww_kontosperre.dwh_id, sc_ww_kontosperre.id FROM sc_ww_kontosperre) sc_ww_kontosperre
  ON (COALESCE(a.kontosperreid, '$') = sc_ww_kontosperre.id)
LEFT OUTER JOIN 
  ( SELECT sc_ww_adrausvorteilsnr.dwh_id, sc_ww_adrausvorteilsnr.wert FROM sc_ww_adrausvorteilsnr ) sc_ww_adrausvorteilsnr
  ON (a.adresseausvorteilsnummer = sc_ww_adrausvorteilsnr.wert)
LEFT OUTER JOIN
  ( SELECT sc_ww_prozess.dwh_id, sc_ww_prozess.id FROM sc_ww_prozess) sc_ww_prozessanl
  ON (COALESCE(a.prozessidanl, '$') = sc_ww_prozessanl.id)
LEFT OUTER JOIN
  ( SELECT sc_ww_benutzer.dwh_id, sc_ww_benutzer.id FROM sc_ww_benutzer) sc_ww_benutzeranl
  ON (COALESCE(a.benutzeridanl, '$')  = sc_ww_benutzeranl.id)
LEFT OUTER JOIN
  ( SELECT sc_ww_prozess.dwh_id, sc_ww_prozess.id FROM sc_ww_prozess) sc_ww_prozessletztaend
  ON (COALESCE(a.prozessidletztaend, '$') = sc_ww_prozessletztaend.id)
LEFT OUTER JOIN
  ( SELECT sc_ww_benutzer.dwh_id, sc_ww_benutzer.id FROM sc_ww_benutzer) sc_ww_benutzerletztaend
  ON (COALESCE(a.benutzeridletztaend, '$') = sc_ww_benutzerletztaend.id)
LEFT OUTER JOIN 
  ( SELECT sc_ww_scheckauszahlkz.dwh_id, sc_ww_scheckauszahlkz.wert FROM sc_ww_scheckauszahlkz) sc_ww_scheckauszahlkz
  ON (COALESCE(a.scheckauszahlkz, -3) = sc_ww_scheckauszahlkz.wert)
LEFT OUTER JOIN 
  ( SELECT sc_ww_neukundekz.dwh_id, sc_ww_neukundekz.wert FROM sc_ww_neukundekz) sc_ww_neukundekz
  ON (COALESCE(a.neukundekz, -3) = sc_ww_neukundekz.wert)
LEFT OUTER JOIN 
  ( SELECT sc_ww_wunschkzidfilialwerb.dwh_id, sc_ww_wunschkzidfilialwerb.id FROM sc_ww_wunschkzidfilialwerb) sc_ww_wunschfilialwerb
  ON (COALESCE(a.wunschkzidfilialwerb, '$') = sc_ww_wunschfilialwerb.id)
LEFT OUTER JOIN 
  ( SELECT sc_ww_fg.dwh_id, sc_ww_fg.id FROM sc_ww_fg ) sc_ww_fg
  ON (CASE WHEN a.fgidstamm IS NULL THEN '$' ELSE a.fgidstamm END = sc_ww_fg.id)
LEFT OUTER JOIN 
  ( SELECT sc_ww_eigenfremdkaufkz.dwh_id, sc_ww_eigenfremdkaufkz.wert FROM sc_ww_eigenfremdkaufkz ) sc_ww_eigenfremdkaufkz
  ON (CASE WHEN a.eigenfremdkaufkz IS NULL THEN 0 ELSE a.eigenfremdkaufkz END = sc_ww_eigenfremdkaufkz.wert)  
  ;
  
COMMIT;



PROMPT ===========================================
PROMPT  1.6 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_kunde');
EXEC PKG_STATS.GATHERTABLE  (USER, 'clsc_ww_kunde_e');

PROMPT ===========================================
PROMPT  1.7 Check ob Fehler...
PROMPT ===========================================

DECLARE

 v_error NUMBER := 0;
 
BEGIN

 SELECT COUNT(*)
 INTO v_error
 FROM clsc_ww_kunde_e;

 IF v_error > 0 THEN
  RAISE_APPLICATION_ERROR(-20029,'Data loss when loading SC!');
 END IF;
 
END;
/