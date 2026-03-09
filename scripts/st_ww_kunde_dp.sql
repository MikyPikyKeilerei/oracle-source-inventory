/*******************************************************************************

Job:                    st_ww_kunde_dp
Beschreibung:           Befüllung der STG-Tabellen erfolgt über Datapump-Job 
                        DP_KUNDE von der IT
          
Erstellt am:            02.04.2016
Erstellt von:           Stefan Ernstberger  
Ansprechpartner:        Stefan Ernstberger, Jochen König  
  
Ansprechpartner-IT:     Anton Roithmeier, Thomas Hösl

verwendete Tabellen:    kdwh_dh.kunde                                                                                                                                                                                       
                        kdwh_dh.adr_de                                                                                                                                                                                      
                        kdwh_dh.adr_at                                                                                                                                                                                      
                        kdwh_dh.adr_ch                                                                                                                                                                                      
                        kdwh_dh.adr_it                                                                                                                                                                                    
                        kdwh_dh.adr_ua                                                                                                                                                                                      
                        kdwh_dh.adresse                                                                                                                                                                                     
                        kdwh_dh.person                                                                                                                                                                                      
                        kdwh_dh.mcerg                                                                                                                                                                                       
                        kdwh_dh.interessent                                                                                                                                                                                 
                        kdwh_dh.kundeanlauf                                                                                                                                                                                 
                        kdwh_dh.liefanschr                                                                                                                                                                                                            
                        kdwh_dh.kdkto                                                                                                                                                                                       
                        kdwh_dh.mahnsta                                                                                                                                                                                                                                                                                                                                                                          
                        kdwh_dh.nlempfaenger
                        kdwh_dh.kundeverskostflatrate

                       
Endtabellen:            kdwh.st_ww_kunde_kk_b  
                        udwh1.st_ww_kunde_b
                        kdwh.st_ww_adr_de_kk_b  
                        udwh1.st_ww_adr_de_b              
                        udwh1.st_ww_adr_at_b
                        kdwh.st_ww_adr_ch_kk_b              
                        udwh1.st_ww_adr_ch_b              
                        udwh1.st_ww_adr_it_b
                        kdwh.st_ww_adr_ua_kk_b              
                        udwh1.st_ww_adr_ua_b
                        kdwh.st_ww_adresse_kk_b              
                        udwh1.st_ww_adresse_b
                        kdwh.st_ww_person_kk_b             
                        udwh1.st_ww_person_b              
                        udwh1.st_ww_mcerg_b               
                        udwh1.st_ww_interessent_b
                        kdwh.st_ww_interessent_kk_b         
                        udwh1.st_ww_kundeanlauf_b         
                        udwh1.st_ww_liefanschr_b                      
                        udwh1.st_ww_kdkto_b               
                        udwh1.st_ww_mahnsta_b   
                        udwh1.st_ww_nlempfaenger_b
                        udwh1.st_ww_kundeverskostflat_b

Fehler-Doku:      -
Ladestrecke:      -

********************************************************************************
geändert am:          22.02.2017
geändert von:         STEERN
Änderungen:           ##.1: in der KUNDE nun dbfaturakz als Spalte hinzu
********************************************************************************
geändert am:          24.10.2017
geändert von:         STEERN
Änderungen:           ##.2: in der ADRESSE nun erzwungenkz als Spalte hinzu
********************************************************************************
geändert am:          11.12.2017
geändert von:         STEERN
Änderungen:           ##.3: kontosperreid bei KUNDE hinzugefuegt
********************************************************************************
geändert am:          26.03.2017
geändert von:         STEERN
Änderungen:           ##.4:  adrchkdat, adrchkstat eingefuegt in ADR_CH bzw. ADR_DE
********************************************************************************
geändert am:          26.03.2018
geändert von:         ELIFAL
Änderungen:           ##.5: Neue Tabelle nlempfaenger eingefügt. (17.)
********************************************************************************
geändert am:          17.05.2018
geändert von:         STEERN
Änderungen:           ##.6: letztretouredate in KDKTO hinzugefuegt        
********************************************************************************
geändert am:          30.05.2018
geändert von:         STEERN
Änderungen:           ##.7 : Person erweitert um folgende Spalten:
                          - ANLDAT    
                          - PROZESSIDANL
                          - BENUTZERIDANL,
                          - LETZTAENDDAT,
                          - PROZESSIDLETZTAEND,  
                          - BENUTZERIDLETZTAEND,  
                          - NLANMELDIP,    
                          - NLANMELDEINWTXT  
********************************************************************************
geändert am:          07.06.2018
geändert von:         STEERN
Änderungen:           ##.8 : KUNDE erweitert um ADRESSEAUSVORTEILSNUMMER
********************************************************************************
geändert am:          11.06.2018
geändert von:         STEERN
Änderungen:           ##.9 : 
                      KUNDE erweitert um folgende Spalten:
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

                      PERSON erweitert um folgende Spalten:
                          -SERVICEINFOBESTELLUNGKZ
                          -SERVICEINFOVERSANDKZ
                          -SERVICEINFOZAHLUNGEINGANGKZ
                          -SERVICEINFORETOUREEINGANGKZ
                          -SERVICEINFONALIINFOVERSANDKZ
********************************************************************************
geändert am:          09.07.2018
geändert von:         MAXLIN
Änderungen:           ##.10 :
                      Umbau des Jobs für die Clearingstelle:
                      -Trennung zwischen Verhaltens- (VH) und Kernkundendaten (KK)
                      -Verhaltenskundendaten werden durch die Clearingstelle geladen, pseudonymisiert
                      -Kernkundendaten bleiben links der Clearingstelle     
********************************************************************************
geändert am:          18.09.2018
geändert von:         STEERN
Änderungen:           ##.11 : PERSON jetzt mit neuen Spalten:
                         -TELEFONPRIVAT
                         -TELEFONFIRMA
                         -FAXPRIVAT
                         -FAXFIRMA                      
********************************************************************************
geändert am:          19.11.2018
geändert von:         STEERN
Änderungen:           ##.12: KDKTO mit neuer Spalte LETZTAKTIVFGDAT    
********************************************************************************
geändert am:          30.11.2018
geändert von:         MAXLIN
Änderungen:           ##.13: Umzug auf Schemas KDWH&UDWH1  
********************************************************************************
geändert am:          13.12.2018
geändert von:         STEERN
Änderungen:           ##.14: Tabelle KUNDEVERSKOSTFLAT wird mitgeladen 
********************************************************************************
geändert am:          13.03.2019
geändert von:         STEERN
Änderungen:           ##.15: PERSON um SERVICEINFOHVSPAKETANKUENDKZ erweitert
********************************************************************************
geändert am:          03.04.2019
geändert von:         MAXLIN
Änderungen:           ##.16: Tabelle KUNDEVERSKOSTFLAT erweitert:  
                        -wapitransferoffenkz
                        -naechstsyncdat
                        -bem
********************************************************************************
geändert am:          24.04.2019
geändert von:         MAXLIN
Änderungen:           ##.16: LIEFANSCHR jetzt mit neuer Spalte PAKETAUTOMATKZ  
********************************************************************************
geändert am:          10.06.2020
geändert von:         STEERN
Änderungen:           ##.17: Erweiterung der Stage-Ladung Person um 3 Spalten
********************************************************************************
geändert am:          15.03.2021
geändert von:         BENLIN
Änderungen:           ##.18: Lower(emailprivat) eingebaut für STANDARD_HASH()
********************************************************************************
geändert am:          20.04.2021
geändert von:         STEERN
Änderungen:           ##.19: TELEFONPRIVAT_VORHANDEN eingebaut in PERSON
********************************************************************************
geändert am:          15.07.2021
geändert von:         SALMAR
Änderungen:           ##.20: Konto ID calculation added to kundeanlauf
********************************************************************************
geändert am:          01.09.2021
geändert von:         STEERN
Änderungen:           ##.21:
                       - POSTFACH zu ADRESSE
                       - DATENSCHUTZ und NACHNAMEERSTERLETTER zu PERSON
                       - KONTONRLETZTEZIFFERN zu KUNDE
********************************************************************************
geändert am:          14.09.2021
geändert von:         STEERN
Änderungen:           ##.22: KONTONRLETZTEZIFFERN nun auch bei INTERESSENT/NLEMPFAENGER
********************************************************************************
geändert am:          19.09.2023
geändert von:         ANDGAG
Änderungen:           ##.23: CHECK bei Interessentennr eingebaut
********************************************************************************
geändert am:          04.03.2024
geändert von:         STEERN
Änderungen:           ##.24: serviceinforechnungversandkz eingebaut
********************************************************************************
geändert am:          29.04.2024
geändert von:         carkah
Änderungen:           ##.25: DATASERV-1237: Erweiterung Person auf UDWH1 um emailprivat_key
********************************************************************************
geändert am:          11.07.2024
geändert von:         steern
Änderungen:           ##.26: DATASERV-1258: Erweiterung Kunde um Spalte EIGENFREMDKAUFKZ
********************************************************************************
geändert am:          07.08.2024
geändert von:         stegrs, joeabd
Änderungen:           ##.27: DATASERV-1253: Leerzeichen um emailprivat ergaenzt
********************************************************************************
geändert am:          23.07.2025
geändert von:         steern, andgag
Änderungen:           Limango von Otto Market DE trennen
*******************************************************************************/

ALTER SESSION ENABLE PARALLEL DML;

PROMPT =========================================================================                                                                                                                      
PROMPT Parameter                                                                                                                                                                                                                                                                           
PROMPT Datenbanklink: &dbludwh                                                                                                                             
PROMPT GBV-Job ID:  &gbvid                                                                                                                               
PROMPT Prozessdatum: &termin
PROMPT =========================================================================         



PROMPT =========================================================================
PROMPT
PROMPT 1. Stage-Ladung
PROMPT Tabelle: st_ww_kunde_kk
PROMPT          st_ww_kunde
PROMPT
PROMPT =========================================================================
 
EXEC PKG_IM_LADUNG.P_LADUNG_STAGE ('kdwh_dh.kunde&dbludwh', 'st_ww_kunde_kk', &gbvid);

EXEC PKG_IM_LADUNG.P_LADUNG_STAGE ('kdwh_dh.kunde&dbludwh', 'st_ww_kunde', &gbvid);
 


PROMPT ===========================================
PROMPT 1.1 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'st_ww_kunde_kk');

EXEC PKG_STATS.GATHERTABLE (USER, 'st_ww_kunde');
 
 

PROMPT ===========================================
PROMPT 1.2 Cleanse-Tabellen leeren (VH- und KK-Tabellen)
PROMPT ===========================================
 
TRUNCATE TABLE clst_ww_kunde_kk;
TRUNCATE TABLE clst_ww_kunde_kk_u;
TRUNCATE TABLE clst_ww_kunde_kk_n;
TRUNCATE TABLE clst_ww_kunde_kk_d;

TRUNCATE TABLE clst_ww_kunde;
TRUNCATE TABLE clst_ww_kunde_u;
TRUNCATE TABLE clst_ww_kunde_n;
TRUNCATE TABLE clst_ww_kunde_d;
TRUNCATE TABLE udwh1.clst_ww_kunde;
 


PROMPT ===========================================
PROMPT 1.3 Deltaermittlung
PROMPT ===========================================



PROMPT ===========================================
PROMPT 1.3.1 Deltaermittlung Kernkundendaten
PROMPT ===========================================

INSERT  ALL 
WHEN cnt1 > 0 AND cnt2 = 0 AND src IS NOT NULL THEN  --update und new
INTO clst_ww_kunde_kk_u
(
  dwh_cr_load_id,            
  dwh_processdate,           
  dwh_stbflag,               
  id,                        
  kdnr,                      
  personid,                  
  verwkdnr,                  
  kundenfirmaid,             
  sozialversicherungsnr,     
  personstammpruefid        
)
VALUES
(
   &gbvid,
   &termin,
   'U',
   id,                        
   kdnr,                      
   personid,                  
   verwkdnr,                  
   kundenfirmaid,             
   sozialversicherungsnr,     
   personstammpruefid
)
WHEN cnt1 > 0 AND cnt2 = 0 AND src IS NULL THEN -- new
INTO clst_ww_kunde_kk_n
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id
)
VALUES
(
   &gbvid,
   &termin,
   'N',
   id
)
WHEN cnt1 = 0 AND cnt2 > 0 AND src IS NULL THEN -- delete
INTO clst_ww_kunde_kk_d
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id
)
VALUES
(
   &gbvid,
   &termin,
   'D',
   id
)
SELECT 
   id,                        
   kdnr,                      
   personid,                  
   verwkdnr,                  
   kundenfirmaid,             
   sozialversicherungsnr,     
   personstammpruefid,
   COUNT(src1) AS cnt1,
   COUNT(src2) AS cnt2,
   src
FROM
   (  SELECT 
      TRIM(a.id) as id,                                                                                                                                                                                  
      a.kdnr as kdnr,                                                                                                                                                                                            
      TRIM(a.personid) as personid,                                                                                                                                                                              
      a.verwkdnr as verwkdnr,                                                                                                                                                                                                                                                                                                                                                                
      TRIM(a.kundenfirmaid) as kundenfirmaid,                                                                                                                                                                    
      TRIM(a.sozialversicherungsnr) as sozialversicherungsnr,
      TRIM(a.personstammpruefid) as personstammpruefid,
      1 src1,
      TO_NUMBER(NULL) src2,
      1 src
    FROM st_ww_kunde_kk a
  UNION ALL
    SELECT 
     TRIM(b.id) as id,                                                          
     b.kdnr as kdnr,                                                            
     TRIM(b.personid) as personid,                                                                                                                                                                                       
     b.verwkdnr as verwkdnr,                                                                                              
     TRIM(b.kundenfirmaid) as kundenfirmaid,                                    
     TRIM(b.sozialversicherungsnr) as sozialversicherungsnr,           
     TRIM(b.personstammpruefid) as personstammpruefid,
     TO_NUMBER(NULL) src1,
     2 src2,
     1 src
    FROM st_ww_kunde_kk_1 b
 ) c
GROUP BY GROUPING SETS ((
   id,                        
   kdnr,                      
   personid,                  
   verwkdnr,                  
   kundenfirmaid,             
   sozialversicherungsnr,     
   personstammpruefid,
   src) , (id))
HAVING COUNT(src1) <> COUNT(src2);
 
COMMIT;



PROMPT ===========================================
PROMPT 1.3.2 Deltaermittlung Verhaltenskundendaten
PROMPT ===========================================

INSERT ALL 
WHEN cnt1 > 0 AND cnt2 = 0 AND src IS NOT NULL THEN  --update und new
INTO clst_ww_kunde_u
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id,   
   kdnr,
   personid,
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
   verwkdnr,
   anlaufdat,
   anlaufsaison,
   letztaenddat,
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
   bekuansprkz,             -- gebraucht für Stationaer
   bekuansprgew,            -- gebraucht für Stationaer
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
   &termin,
   'U',
   id,   
   kdnr,
   personid,
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
   verwkdnr,
   anlaufdat,
   anlaufsaison,
   letztaenddat,
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
   bekuansprkz,            -- gebraucht für Stationaer
   bekuansprgew,           -- gebraucht für Stationaer
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
WHEN cnt1 > 0 AND cnt2 = 0 AND src IS NULL THEN -- new
INTO clst_ww_kunde_n
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id
)
VALUES
(
   &gbvid,
   &termin,
   'N',
   id
)
WHEN cnt1 = 0 AND cnt2 > 0 AND src IS NULL THEN -- delete
INTO clst_ww_kunde_d
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id
)
VALUES
(
   &gbvid,
   &termin,
   'D',
   id
)
SELECT 
   id,   
   kdnr,
   personid,
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
   verwkdnr,
   anlaufdat,
   anlaufsaison,
   letztaenddat,
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
   bekuansprkz,            -- gebraucht für Stationaer
   bekuansprgew,           -- gebraucht für Stationaer
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
   eigenfremdkaufkz,
   COUNT(src1) AS cnt1,
   COUNT(src2) AS cnt2,
   src
FROM
   (  SELECT 
      TRIM(a.id) as id,                                                                                                                                                                                  
      a.kdnr as kdnr,                                                                                                                                                                                            
      TRIM(a.personid) as personid,                                                                                                                                                                              
      TRIM(a.kdartid) as kdartid,                                                                                                                                                                                
      TRIM(a.boniklid) as boniklid,                                                                                                                                                                              
      TRIM(a.mahnebid) as mahnebid,                                                                                                                                                                              
      TRIM(a.mahnstrangid) as mahnstrangid,                                           
      TRIM(a.beschaeftigungid) as beschaeftigungid,                                   
      TRIM(a.verswunschid) as verswunschid,                                                                                                                                                                      
      TRIM(a.werbmitid) as werbmitid,                                                                                                                                                                            
      TRIM(a.ersatzartid) as ersatzartid,                                                                                                                                                                        
      a.wkz as wkz,                                                                                                                                                                                              
      a.iwl as iwl,                                                                                                                                                                                              
      COALESCE(a.katnachvers,0) as katnachvers,                                                                                                                                                                              
      a.katlimit as katlimit,                                                                                                                                                                                    
      TRIM(a.katerstverskz) as katerstverskz,                                                                                                                                                                    
      a.valkz as valkz,                                                                                                                                                                                          
      a.vtinfokdgrp as vtinfokdgrp,                                                                                                                                                                              
      a.rgkfumstdat as rgkfumstdat,                                                                                                                                                                              
      a.verwkdnr as verwkdnr,                                                                                                                                                                                    
      a.anlaufdat as anlaufdat,                                                                                                                                                                                  
      a.anlaufsaison as anlaufsaison,                                                                                                                                                                            
      a.letztaenddat as letztaenddat,                                                                                                                                                                            
      TRIM(a.kundenfirmaid) as kundenfirmaid,                                                                                                                                                                    
      TRIM(a.bonisperrid) as bonisperrid,                                                                                                                                                                        
      TRIM(a.kdsperrid) as kdsperrid,                                                                                                                                                                            
      TRIM(a.telemkid) as telemkid,                                                                                                                                                                              
      TRIM(a.newsletterid) as newsletterid,                                                                                                                                                                      
      TRIM(a.nachbarschabgid) as nachbarschabgid,                                                                                                                                                                
      TRIM(a.tddsgid) as tddsgid,                                                                                                                                                                                
      TRIM(a.newslettertypid) as newslettertypid,                                                                                                                                                                
      TRIM(a.nlabonnentstatusid) as nlabonnentstatusid,                                                                                                                                                          
      TRIM(a.adressherkunftid) as adressherkunftid,                                                        
      TRIM(a.testgrp) as testgrp,                                                     
      TRIM(a.telemkeinwid) as telemkeinwid,                                           
      a.bekuansprkz as bekuansprkz,           -- gebraucht für Stationaer                                                                                                                                                                                                 
      a.bekuansprgew as bekuansprgew,         -- gebraucht für Stationaer             
      COALESCE(a.kdloginaktivstatkz,0) as kdloginaktivstatkz,  -- 0/null haben gleiche Bedeutung                                                                                                                                                     
      a.kdloginaktivierungsdat as kdloginaktivierungsdat,                                                                                                                                                        
      a.kdloginlinksenddat as kdloginlinksenddat,                                                                                                                                                                
      COALESCE(a.servicemailaktivkz,0) as servicemailaktivkz, --0/null kein Empfang erwuenscht
      COALESCE(a.dbfakturakz,0) as dbfakturakz,               -- 0/null HOST
      TRIM(a.kontosperreid) as kontosperreid,
      COALESCE(a.adresseausvorteilsnummer,0) as adresseausvorteilsnummer, --0/null = Adresse nicht über Vorteilsnummer erfasst
      a.kdloginreminderddat as kdloginreminderddat,
      TRIM(a.loginaktivierungslink) as loginaktivierungslink,
      TRIM(a.sc_ergid) as sc_ergid,
      TRIM(a.prozessidanl) as prozessidanl,  
      TRIM(a.prozessidletztaend) as prozessidletztaend,
      TRIM(a.benutzeridanl) as benutzeridanl,
      TRIM(a.benutzeridletztaend) as benutzeridletztaend,  
      a.scheckauszahlkz as scheckauszahlkz,      
      a.neukundekz as neukundekz,
      COALESCE(a.anzahlhauptkatalog,0) as anzahlhauptkatalog,  
      TRIM(a.eoscredcard) as eoscredcard,
      TRIM(a.fgidstamm) as fgidstamm,  
      TRIM(a.wunschkzidfilialwerb) as wunschkzidfilialwerb,
      a.eigenfremdkaufkz as eigenfremdkaufkz,
      1 src1,
      TO_NUMBER(NULL) src2,
      1 src
    FROM st_ww_kunde a
  UNION ALL
    SELECT 
      TRIM(b.id) as id,                                                                                                                                                                                  
      b.kdnr as kdnr,                                                                                                                                                                                            
      TRIM(b.personid) as personid,                                                                                                                                                                              
      TRIM(b.kdartid) as kdartid,                                                                                                                                                                                
      TRIM(b.boniklid) as boniklid,                                                                                                                                                                              
      TRIM(b.mahnebid) as mahnebid,                                                                                                                                                                              
      TRIM(b.mahnstrangid) as mahnstrangid,                                           
      TRIM(b.beschaeftigungid) as beschaeftigungid,                                   
      TRIM(b.verswunschid) as verswunschid,                                                                                                                                                                      
      TRIM(b.werbmitid) as werbmitid,                                                                                                                                                                            
      TRIM(b.ersatzartid) as ersatzartid,                                                                                                                                                                        
      b.wkz as wkz,                                                                                                                                                                                              
      b.iwl as iwl,                                                                                                                                                                                              
      COALESCE(b.katnachvers,0) as katnachvers,                                                                                                                                                                              
      b.katlimit as katlimit,                                                                                                                                                                                    
      TRIM(b.katerstverskz) as katerstverskz,                                                                                                                                                                    
      b.valkz as valkz,                                                                                                                                                                                          
      b.vtinfokdgrp as vtinfokdgrp,                                                                                                                                                                              
      b.rgkfumstdat as rgkfumstdat,                                                                                                                                                                              
      b.verwkdnr as verwkdnr,                                                                                                                                                                                    
      b.anlaufdat as anlaufdat,                                                                                                                                                                                  
      b.anlaufsaison as anlaufsaison,                                                                                                                                                                            
      b.letztaenddat as letztaenddat,                                                                                                                                                                            
      TRIM(b.kundenfirmaid) as kundenfirmaid,                                                                                                                                                                    
      TRIM(b.bonisperrid) as bonisperrid,                                                                                                                                                                        
      TRIM(b.kdsperrid) as kdsperrid,                                                                                                                                                                            
      TRIM(b.telemkid) as telemkid,                                                                                                                                                                              
      TRIM(b.newsletterid) as newsletterid,                                                                                                                                                                      
      TRIM(b.nachbarschabgid) as nachbarschabgid,                                                                                                                                                                
      TRIM(b.tddsgid) as tddsgid,                                                                                                                                                                                
      TRIM(b.newslettertypid) as newslettertypid,                                                                                                                                                                
      TRIM(b.nlabonnentstatusid) as nlabonnentstatusid,                                                                                                                                                          
      TRIM(b.adressherkunftid) as adressherkunftid,                                                        
      TRIM(b.testgrp) as testgrp,                                                     
      TRIM(b.telemkeinwid) as telemkeinwid,                                           
      b.bekuansprkz as bekuansprkz,           -- gebraucht für Stationaer                                                                                                                                                                                                 
      b.bekuansprgew as bekuansprgew,         -- gebraucht für Stationaer             
      COALESCE(b.kdloginaktivstatkz,0) as kdloginaktivstatkz,  -- 0/null haben gleiche Bedeutung                                                                                                                                                     
      b.kdloginaktivierungsdat as kdloginaktivierungsdat,                                                                                                                                                        
      b.kdloginlinksenddat as kdloginlinksenddat,                                                                                                                                                                
      COALESCE(b.servicemailaktivkz,0) as servicemailaktivkz, --0/null kein Empfang erwuenscht
      COALESCE(b.dbfakturakz,0) as dbfakturakz,               -- 0/null HOST
      TRIM(b.kontosperreid) as kontosperreid,
      COALESCE(b.adresseausvorteilsnummer,0) as adresseausvorteilsnummer, --0/null = Adresse nicht über Vorteilsnummer erfasst
      b.kdloginreminderddat as kdloginreminderddat,
      TRIM(b.loginaktivierungslink) as loginaktivierungslink,
      TRIM(b.sc_ergid) as sc_ergid,
      TRIM(b.prozessidanl) as prozessidanl,  
      TRIM(b.prozessidletztaend) as prozessidletztaend,
      TRIM(b.benutzeridanl) as benutzeridanl,
      TRIM(b.benutzeridletztaend) as benutzeridletztaend,  
      b.scheckauszahlkz as scheckauszahlkz,      
      b.neukundekz as neukundekz,
      COALESCE(b.anzahlhauptkatalog,0) as anzahlhauptkatalog,  
      TRIM(b.eoscredcard) as eoscredcard,
      TRIM(b.fgidstamm) as fgidstamm,  
      TRIM(b.wunschkzidfilialwerb) as wunschkzidfilialwerb,     
      b.eigenfremdkaufkz as eigenfremdkaufkz,
      TO_NUMBER(NULL) src1,
      2 src2,
      1 src
    FROM st_ww_kunde_1 b
 ) c
GROUP BY GROUPING SETS ((
   id,   
   kdnr,
   personid,
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
   verwkdnr,
   anlaufdat,
   anlaufsaison,
   letztaenddat,
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
   bekuansprkz,            -- gebraucht für Stationaer
   bekuansprgew,           -- gebraucht für Stationaer
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
   eigenfremdkaufkz,
   src) , (id))
HAVING COUNT(src1) <> COUNT(src2);
 
COMMIT;
 


PROMPT ===========================================
PROMPT 1.4 NEW und UPDATE-Datensätze einspielen
PROMPT ===========================================
 


PROMPT ===========================================
PROMPT 1.4.1 NEW und UPDATE-Datensätze einspielen (Kernkundendaten)
PROMPT ===========================================
 
INSERT 
INTO clst_ww_kunde_kk
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id,                        
   kdnr,
   personid,                  
   verwkdnr,                  
   kundenfirmaid,
   sozialversicherungsnr,     
   personstammpruefid
   )
SELECT
   a.dwh_cr_load_id,
   a.dwh_processdate,
   CASE WHEN b.id IS NOT NULL THEN 'N' ELSE a.dwh_stbflag END AS dwh_stbflag,
   a.id,                                                                                                                                                                                                  
   kdnr,                      
   personid,                  
   verwkdnr,                  
   kundenfirmaid,             
   sozialversicherungsnr,     
   personstammpruefid
FROM
clst_ww_kunde_kk_u a
LEFT JOIN
clst_ww_kunde_kk_n b
ON (a.id = b.id);
 
COMMIT;



PROMPT ===========================================
PROMPT 1.4.2 NEW und UPDATE-Datensätze einspielen (Verhaltenskundendaten)
PROMPT ===========================================
 
INSERT /*+APPEND*/
INTO clst_ww_kunde
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id,                                                                                                                                                                                                  
   kdnr,
   kontonrletzteziffern,
   konto_id,
   personid,
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
   verwkdnr,
   verwkonto_id,   
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
   bekuansprkz,            -- gebraucht für Stationaer
   bekuansprgew,           -- gebraucht für Stationaer
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
   a.dwh_processdate,
   CASE WHEN b.id IS NOT NULL THEN 'N' ELSE a.dwh_stbflag END AS dwh_stbflag,
   a.id,                                                                                                                                                                                                  
   a.kdnr,
   substr(kk.kdnr, -3) AS kontonrletzteziffern,
   NULL,   
   a.personid,
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
   a.verwkdnr,
   NULL,
   anlaufdat,
   anlaufsaison,
   letztaenddat,
   NULL,
   a.kundenfirmaid,
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
   bekuansprkz,            -- gebraucht für Stationaer
   bekuansprgew,           -- gebraucht für Stationaer
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
clst_ww_kunde_u a
INNER JOIN 
st_ww_kunde_kk kk ON a.id = kk.id
LEFT JOIN
clst_ww_kunde_n b
ON (a.id = b.id);
 
COMMIT;
 

  
PROMPT ===========================================
PROMPT 1.5 DEL-Datensätze einspielen
PROMPT ===========================================



PROMPT ===========================================
PROMPT 1.5.1 DEL-Datensätze einspielen (Kernkundendaten)
PROMPT ===========================================
 
INSERT 
INTO clst_ww_kunde_kk
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id
)
   SELECT 
   &gbvid,
   &termin,
   'D',
   id
FROM clst_ww_kunde_kk_d;
 
COMMIT;



PROMPT ===========================================
PROMPT 1.5.2 DEL-Datensätze einspielen (Verhaltenskundendaten)
PROMPT ===========================================

INSERT
INTO clst_ww_kunde
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id
)
   SELECT 
   &gbvid,
   &termin,
   'D',
   id
FROM clst_ww_kunde_d;
 
COMMIT;



PROMPT ===========================================
PROMPT 1.5.3 Otto Market Firmen umbiegen (Ab Juli 2025 limango DE)
PROMPT ======================================================
 
MERGE INTO kdwh.clst_ww_kunde cl
USING
(
  SELECT 
     firma_org, 
     kontonr, 
     firma_neu
  FROM dwh_sammelkonto_firma_mapping
) x
ON (x.kontonr = cl.kdnr AND cl.firma = x.firma_org)
WHEN MATCHED THEN
   UPDATE SET
       cl.kundenfirmaid = x.firma_neu;
 
COMMIT;



PROMPT ===========================================
PROMPT 1.6 Konto-ID für Kundenverhaltensdaten generieren und setzen
PROMPT ===========================================
        
EXEC PKG_IM_KONTO_ID.P_DWH_KONTO_ID_UP ('clst_ww_kunde', 'kdnr,verwkdnr','kundenfirmaid,kundenfirmaid', 'konto_id,verwkonto_id', &gbvid, 1, 1);
 
PROMPT Test auf leere Konto_IDs

DECLARE
    v_anz_kid PLS_INTEGER;
BEGIN

    SELECT COUNT(*) INTO v_anz_kid
    FROM clst_ww_kunde
    WHERE konto_id IS NULL AND kdnr IS NOT NULL;

    IF v_anz_kid > 0 THEN
        RAISE_APPLICATION_ERROR (-20079, 'Leere Konto-IDs!'); 
    END IF;
    
    SELECT COUNT(*) INTO v_anz_kid
    FROM clst_ww_kunde
    WHERE verwkonto_id IS NULL AND verwkdnr IS NOT NULL;

    IF v_anz_kid > 0 THEN
        RAISE_APPLICATION_ERROR (-20079, 'Leere Konto-IDs!'); 
    END IF;

END;
/


PROMPT ===========================================
PROMPT 1.7 ID,Konto-ID,Verwkonto_ID,PersonID in einen anonymen Key umwandeln und diesen in eine Zieltabelle im Zielschema schreiben (Verhaltenskundendaten)
PROMPT ===========================================

TRUNCATE TABLE udwh1.clst_ww_kunde;

EXEC IMPROG.PKG_CLEARING.P_CLEARING_ANONYMIZE (1, 'KDWH', -
  'CLST_WW_KUNDE', -
  'ID,KONTO_ID,VERWKONTO_ID,PERSONID', -
  'UDWH1', -
  'CLST_WW_KUNDE', -
  'ID_KEY,KONTO_ID_KEY,VERWKONTO_ID_KEY,PERSONID_KEY', -
  FALSE);



PROMPT ===========================================
PROMPT 1.8 Eindeutigkeit prüfen / neue Partition hinzufügen und laden
PROMPT ===========================================

EXEC PKG_IM_LADUNG.P_LADUNG_STB ('st_ww_kunde_kk_b', &gbvid, 1);

EXEC PKG_IM_LADUNG.P_LADUNG_STB ('st_ww_kunde_b', &gbvid, 1,'UDWH1');



PROMPT =========================================================================
PROMPT
PROMPT 2. Stage-Ladung
PROMPT Tabelle: st_ww_adr_de_kk
PROMPT          st_ww_adr_de
PROMPT
PROMPT =========================================================================

EXEC PKG_IM_LADUNG.P_LADUNG_STAGE ('kdwh_dh.adr_de&dbludwh', 'st_ww_adr_de_kk', &gbvid);

EXEC PKG_IM_LADUNG.P_LADUNG_STAGE ('kdwh_dh.adr_de&dbludwh', 'st_ww_adr_de', &gbvid);
 
 

PROMPT ===========================================
PROMPT 2.1 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'st_ww_adr_de_kk');

EXEC PKG_STATS.GATHERTABLE (USER, 'st_ww_adr_de');
 

 
PROMPT ===========================================
PROMPT 2.2 Cleanse-Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clst_ww_adr_de_kk;
TRUNCATE TABLE clst_ww_adr_de_kk_u;
TRUNCATE TABLE clst_ww_adr_de_kk_n;
TRUNCATE TABLE clst_ww_adr_de_kk_d;

TRUNCATE TABLE clst_ww_adr_de;
TRUNCATE TABLE clst_ww_adr_de_u;
TRUNCATE TABLE clst_ww_adr_de_n;
TRUNCATE TABLE clst_ww_adr_de_d;
TRUNCATE TABLE udwh1.clst_ww_adr_de; 
 

PROMPT ===========================================
PROMPT 2.3 Deltaermittlung
PROMPT ===========================================



PROMPT ===========================================
PROMPT 2.3.1 Deltaermittlung Kernkundendaten
PROMPT ===========================================


 
INSERT /*+ APPEND */ ALL 
WHEN cnt1 > 0 AND cnt2 = 0 AND src IS NOT NULL THEN  --update und new
INTO clst_ww_adr_de_kk_u
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id,
   adresseid,
   strkz
)
VALUES
(
   &gbvid,
   &termin,
   'U',
   id,
   adresseid,
   strkz
)
WHEN cnt1 > 0 AND cnt2 = 0 AND src IS NULL THEN -- new
INTO clst_ww_adr_de_kk_n
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id
)
VALUES
(
   &gbvid,
   &termin,
   'N',
   id
)
WHEN cnt1 = 0 AND cnt2 > 0 AND src IS NULL THEN -- delete
INTO clst_ww_adr_de_kk_d
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id
)
VALUES
(
   &gbvid,
   &termin,
   'D',
   id
)
SELECT 
   id,
   adresseid,
   strkz,
   COUNT(src1) AS cnt1,
   COUNT(src2) AS cnt2,
   src
FROM
   ( SELECT 
      TRIM(a.id) AS id,
      TRIM(a.adresseid) AS adresseid,
      TRIM(a.strkz) AS strkz,
      1 src1,
      TO_NUMBER(NULL) src2,
      1 src
    FROM st_ww_adr_de_kk a
  UNION ALL
    SELECT 
      TRIM(b.id) AS id,
      TRIM(b.adresseid) AS adresseid,
      TRIM(b.strkz) AS strkz,
      TO_NUMBER(NULL) src1,
      2 src2,
      1 src
    FROM st_ww_adr_de_kk_1 b
 ) c
GROUP BY GROUPING SETS ((
   id,
   adresseid,
   strkz,
   src) , (id))
HAVING COUNT(src1) <> COUNT(src2);
 
COMMIT;



PROMPT ===========================================
PROMPT 2.3.2 Deltaermittlung Verhaltenskundendaten
PROMPT ===========================================

INSERT /*+ APPEND */ ALL 
WHEN cnt1 > 0 AND cnt2 = 0 AND src IS NOT NULL THEN  --update und new
INTO clst_ww_adr_de_u
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id,
   adresseid,
   hvs_depot,
   adrchkdat, 
   adrchkstat
)
VALUES
(
   &gbvid,
   &termin,
   'U',
   id,
   adresseid,
   hvs_depot,
   adrchkdat, 
   adrchkstat
)
WHEN cnt1 > 0 AND cnt2 = 0 AND src IS NULL THEN -- new
INTO clst_ww_adr_de_n
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id
)
VALUES
(
   &gbvid,
   &termin,
   'N',
   id
)
WHEN cnt1 = 0 AND cnt2 > 0 AND src IS NULL THEN -- delete
INTO clst_ww_adr_de_d
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id
)
VALUES
(
   &gbvid,
   &termin,
   'D',
   id
)
SELECT 
   id,
   adresseid,
   hvs_depot,
   adrchkdat, 
   adrchkstat,
   COUNT(src1) AS cnt1,
   COUNT(src2) AS cnt2,
   src
FROM
   ( SELECT 
      TRIM(a.id) AS id,
      TRIM(a.adresseid) AS adresseid,
      a.hvs_depot AS hvs_depot,
      a.adrchkdat AS adrchkdat, 
      a.adrchkstat AS adrchkstat,
      1 src1,
      TO_NUMBER(NULL) src2,
      1 src
    FROM st_ww_adr_de a
  UNION ALL
    SELECT 
      TRIM(b.id) AS id,
      TRIM(b.adresseid) AS adresseid,
      b.hvs_depot AS hvs_depot,
      b.adrchkdat AS adrchkdat, 
      b.adrchkstat AS adrchkstat,
      TO_NUMBER(NULL) src1,
      2 src2,
      1 src
    FROM st_ww_adr_de_1 b
 ) c
GROUP BY GROUPING SETS ((
   id,
   adresseid,
   hvs_depot,
   adrchkdat, 
   adrchkstat,
   src) , (id))
HAVING COUNT(src1) <> COUNT(src2);
 
COMMIT;
 

 
PROMPT ===========================================
PROMPT 2.4 NEW und UPDATE-Datensätze einspielen
PROMPT ===========================================



PROMPT ===========================================
PROMPT 2.4.1 NEW und UPDATE-Datensätze einspielen (Kernkundendaten)
PROMPT ===========================================
 
INSERT /*+ APPEND */
INTO clst_ww_adr_de_kk
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id,
   adresseid,
   strkz
)
SELECT
   a.dwh_cr_load_id,
   a.dwh_processdate,
   CASE WHEN b.id IS NOT NULL THEN 'N' ELSE a.dwh_stbflag END AS dwh_stbflag,
   a.id,
   adresseid,
   strkz
FROM
clst_ww_adr_de_kk_u a
LEFT JOIN
clst_ww_adr_de_kk_n b
ON (a.id = b.id);
 
COMMIT;
 


PROMPT ===========================================
PROMPT 2.4.2 NEW und UPDATE-Datensätze einspielen (Verhaltenskundendaten)
PROMPT ===========================================
 
INSERT /*+ APPEND */
INTO clst_ww_adr_de
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id,
   adresseid,
   hvs_depot,
   adrchkdat, 
   adrchkstat
)
SELECT
   a.dwh_cr_load_id,
   a.dwh_processdate,
   CASE WHEN b.id IS NOT NULL THEN 'N' ELSE a.dwh_stbflag END AS dwh_stbflag,
   a.id,
   adresseid,
   hvs_depot,
   adrchkdat, 
   adrchkstat
FROM
clst_ww_adr_de_u a
LEFT JOIN
clst_ww_adr_de_n b
ON (a.id = b.id);
 
COMMIT;
 


PROMPT ===========================================
PROMPT 2.5 DEL-Datensätze einspielen
PROMPT ===========================================



PROMPT ===========================================
PROMPT 2.5.1 DEL-Datensätze einspielen (Kernkundendaten)
PROMPT ===========================================

INSERT /*+APPEND */
INTO clst_ww_adr_de_kk
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id
)
   SELECT 
   &gbvid,
   &termin,
   'D',
   id
FROM clst_ww_adr_de_kk_d;
 
COMMIT;



PROMPT ===========================================
PROMPT 2.5.2 DEL-Datensätze einspielen (Verhaltenskundendaten)
PROMPT ===========================================

INSERT /*+APPEND */
INTO clst_ww_adr_de
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id
)
   SELECT 
   &gbvid,
   &termin,
   'D',
   id
FROM clst_ww_adr_de_d;
 
COMMIT; 



PROMPT ===========================================
PROMPT 2.6 ID,AdresseID in einen anonymen Key umwandeln und diesen in eine Zieltabelle im Zielschema schreiben (Verhaltenskundendaten)
PROMPT ===========================================

TRUNCATE TABLE udwh1.clst_ww_adr_de;

EXEC IMPROG.PKG_CLEARING.P_CLEARING_ANONYMIZE (1, 'KDWH', 'CLST_WW_ADR_DE', 'ID,ADRESSEID','UDWH1', 'CLST_WW_ADR_DE', 'ID_KEY,ADRESSEID_KEY',FALSE);


 
PROMPT ===========================================
PROMPT 2.7 Eindeutigkeit prüfen / neue Partition hinzufügen und laden 
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_LADUNG_STB ('st_ww_adr_de_kk_b', &gbvid, 1);

EXEC PKG_IM_LADUNG.P_LADUNG_STB ('st_ww_adr_de_b', &gbvid, 1, 'UDWH1');



PROMPT =========================================================================
PROMPT
PROMPT 3. Stage-Ladung
PROMPT Tabelle: st_ww_adr_at
PROMPT
PROMPT =========================================================================
 
EXEC PKG_IM_LADUNG.P_LADUNG_STAGE ('kdwh_dh.adr_at&dbludwh', 'st_ww_adr_at', &gbvid); 
 

PROMPT ===========================================
PROMPT 3.1 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'st_ww_adr_at');
 

 
PROMPT ===========================================
PROMPT 3.2 Cleanse-Tabellen leeren
PROMPT ===========================================

TRUNCATE TABLE clst_ww_adr_at;
TRUNCATE TABLE clst_ww_adr_at_u;
TRUNCATE TABLE clst_ww_adr_at_n;
TRUNCATE TABLE clst_ww_adr_at_d;
TRUNCATE TABLE udwh1.clst_ww_adr_at;
 
 

PROMPT ===========================================
PROMPT 3.3 Deltaermittlung
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL 
WHEN cnt1 > 0 AND cnt2 = 0 AND src IS NOT NULL THEN  --update und new
INTO clst_ww_adr_at_u
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id,
   adresseid,
   briefbotenbez,
   hvs_depot
)
VALUES
(
   &gbvid,
   &termin,
   'U',
   id,
   adresseid,
   briefbotenbez,
   hvs_depot
)
WHEN cnt1 > 0 AND cnt2 = 0 AND src IS NULL THEN -- new
INTO clst_ww_adr_at_n
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id
)
VALUES
(
   &gbvid,
   &termin,
   'N',
   id
)
WHEN cnt1 = 0 AND cnt2 > 0 AND src IS NULL THEN -- delete
INTO clst_ww_adr_at_d
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id
)
VALUES
(
   &gbvid,
   &termin,
   'D',
   id
)
SELECT 
   id,
   adresseid,
   briefbotenbez,
   hvs_depot,
   COUNT(src1) AS cnt1,
   COUNT(src2) AS cnt2,
   src
FROM
   ( SELECT 
      TRIM(a.id) AS id,
      TRIM(a.adresseid) AS adresseid,
      TRIM(a.briefbotenbez) AS briefbotenbez,
      a.hvs_depot AS hvs_depot,
      1 src1,
      TO_NUMBER(NULL) src2,
      1 src
    FROM st_ww_adr_at a
  UNION ALL
    SELECT 
      TRIM(b.id) AS id,
      TRIM(b.adresseid) AS adresseid,
      TRIM(b.briefbotenbez) AS briefbotenbez,
      b.hvs_depot AS hvs_depot,
      TO_NUMBER(NULL) src1,
      2 src2,
      1 src
    FROM st_ww_adr_at_1 b
 ) c
GROUP BY GROUPING SETS ((
   id,
   adresseid,
   briefbotenbez,
   hvs_depot,
   src) , (id))
HAVING COUNT(src1) <> COUNT(src2);
 
COMMIT; 
 

 
PROMPT ===========================================
PROMPT 3.4 NEW und UPDATE-Datensätze einspielen
PROMPT ===========================================
 
INSERT /*+ APPEND */
INTO clst_ww_adr_at
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id,
   adresseid,
   briefbotenbez,
   hvs_depot
)
SELECT
   a.dwh_cr_load_id,
   a.dwh_processdate,
   CASE WHEN b.id IS NOT NULL THEN 'N' ELSE a.dwh_stbflag END AS dwh_stbflag,
   a.id,
   adresseid,
   briefbotenbez,
   hvs_depot
FROM
clst_ww_adr_at_u a
LEFT JOIN
clst_ww_adr_at_n b
ON (a.id = b.id);
 
COMMIT;
 

 
PROMPT ===========================================
PROMPT 3.5 DEL-Datensätze einspielen
PROMPT ===========================================
 
INSERT /*+APPEND */
INTO clst_ww_adr_at
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id
)
   SELECT 
   &gbvid,
   &termin,
   'D',
   id
FROM clst_ww_adr_at_d;
 
COMMIT;
 
 

PROMPT ===========================================
PROMPT 3.6 ID,AdresseID in einen anonymen Key umwandeln und diesen in eine Zieltabelle im Zielschema schreiben
PROMPT ===========================================

TRUNCATE TABLE udwh1.clst_ww_adr_at;

EXEC IMPROG.PKG_CLEARING.P_CLEARING_ANONYMIZE (1,'KDWH', 'CLST_WW_ADR_AT', 'ID,ADRESSEID','UDWH1', 'CLST_WW_ADR_AT', 'ID_KEY,ADRESSEID_KEY',FALSE);
     


PROMPT ===========================================
PROMPT 3.7 Eindeutigkeit prüfen / neue Partition hinzufügen und laden 
PROMPT ===========================================

EXEC PKG_IM_LADUNG.P_LADUNG_STB ('st_ww_adr_at_b', &gbvid, 1, 'UDWH1');



PROMPT =========================================================================
PROMPT
PROMPT 4. Stage-Ladung
PROMPT Tabelle: st_ww_adr_ch_kk
PROMPT          st_ww_adr_ch
PROMPT
PROMPT =========================================================================

EXEC PKG_IM_LADUNG.P_LADUNG_STAGE ('kdwh_dh.adr_ch&dbludwh', 'st_ww_adr_ch_kk', &gbvid);
 
EXEC PKG_IM_LADUNG.P_LADUNG_STAGE ('kdwh_dh.adr_ch&dbludwh', 'st_ww_adr_ch', &gbvid);
 


PROMPT ===========================================
PROMPT 4.1 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'st_ww_adr_ch_kk');

EXEC PKG_STATS.GATHERTABLE (USER, 'st_ww_adr_ch');
 


PROMPT ===========================================
PROMPT 4.2 Cleanse-Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clst_ww_adr_ch_kk;
TRUNCATE TABLE clst_ww_adr_ch_kk_u;
TRUNCATE TABLE clst_ww_adr_ch_kk_n;
TRUNCATE TABLE clst_ww_adr_ch_kk_d;

TRUNCATE TABLE clst_ww_adr_ch;
TRUNCATE TABLE clst_ww_adr_ch_u;
TRUNCATE TABLE clst_ww_adr_ch_n;
TRUNCATE TABLE clst_ww_adr_ch_d;
TRUNCATE TABLE udwh1.clst_ww_adr_ch;
 
 

PROMPT ===========================================
PROMPT 4.3 Deltaermittlung
PROMPT ===========================================



PROMPT ===========================================
PROMPT 4.3.1 Deltaermittlung Kernkundendaten
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL 
WHEN cnt1 > 0 AND cnt2 = 0 AND src IS NOT NULL THEN  --update und new
INTO clst_ww_adr_ch_kk_u
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id,
   adresseid,
   ptt_strnr
)
VALUES
(
   &gbvid,
   &termin,
   'U',
   id,
   adresseid,
   ptt_strnr
)
WHEN cnt1 > 0 AND cnt2 = 0 AND src IS NULL THEN -- new
INTO clst_ww_adr_ch_kk_n
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id
)
VALUES
(
   &gbvid,
   &termin,
   'N',
   id
)
WHEN cnt1 = 0 AND cnt2 > 0 AND src IS NULL THEN -- delete
INTO clst_ww_adr_ch_kk_d
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id
)
VALUES
(
   &gbvid,
   &termin,
   'D',
   id
)
SELECT 
   id,
   adresseid,
   ptt_strnr,
   COUNT(src1) AS cnt1,
   COUNT(src2) AS cnt2,
   src
FROM
   ( SELECT 
      TRIM(a.id) AS id,
      TRIM(a.adresseid) AS adresseid,
      a.ptt_strnr AS ptt_strnr,
      1 src1,
      TO_NUMBER(NULL) src2,
      1 src
    FROM st_ww_adr_ch_kk a
  UNION ALL
    SELECT 
      TRIM(b.id) AS id,
      TRIM(b.adresseid) AS adresseid,
      b.ptt_strnr AS ptt_strnr,
      TO_NUMBER(NULL) src1,
      2 src2,
      1 src
    FROM st_ww_adr_ch_kk_1 b
 ) c
GROUP BY GROUPING SETS ((
   id,
   adresseid,
   ptt_strnr,
   src) , (id))
HAVING COUNT(src1) <> COUNT(src2);
 
COMMIT;



PROMPT ===========================================
PROMPT 4.3.2 Deltaermittlung Verhaltenskundendaten
PROMPT ===========================================

INSERT /*+ APPEND */ ALL 
WHEN cnt1 > 0 AND cnt2 = 0 AND src IS NOT NULL THEN  --update und new
INTO clst_ww_adr_ch_u
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id,
   adresseid,
   adrchkdat, 
   adrchkstat
)
VALUES
(
   &gbvid,
   &termin,
   'U',
   id,
   adresseid,
   adrchkdat, 
   adrchkstat
)
WHEN cnt1 > 0 AND cnt2 = 0 AND src IS NULL THEN -- new
INTO clst_ww_adr_ch_n
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id
)
VALUES
(
   &gbvid,
   &termin,
   'N',
   id
)
WHEN cnt1 = 0 AND cnt2 > 0 AND src IS NULL THEN -- delete
INTO clst_ww_adr_ch_d
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id
)
VALUES
(
   &gbvid,
   &termin,
   'D',
   id
)
SELECT 
   id,
   adresseid,
   adrchkdat, 
   adrchkstat,
   COUNT(src1) AS cnt1,
   COUNT(src2) AS cnt2,
   src
FROM
   ( SELECT 
      TRIM(a.id) AS id,
      TRIM(a.adresseid) AS adresseid,
      a.adrchkdat AS adrchkdat, 
      a.adrchkstat AS adrchkstat,
      1 src1,
      TO_NUMBER(NULL) src2,
      1 src
    FROM st_ww_adr_ch a
  UNION ALL
    SELECT 
      TRIM(b.id) AS id,
      TRIM(b.adresseid) AS adresseid,
      b.adrchkdat AS adrchkdat, 
      b.adrchkstat AS adrchkstat,
      TO_NUMBER(NULL) src1,
      2 src2,
      1 src
    FROM st_ww_adr_ch_1 b
 ) c
GROUP BY GROUPING SETS ((
   id,
   adresseid,
   adrchkdat, 
   adrchkstat,
   src) , (id))
HAVING COUNT(src1) <> COUNT(src2);
 
COMMIT;

 

PROMPT ===========================================
PROMPT 4.4 NEW und UPDATE-Datensätze einspielen
PROMPT ===========================================



PROMPT ===========================================
PROMPT 4.4.1 NEW und UPDATE-Datensätze einspielen (Kernkundendaten)
PROMPT ===========================================

INSERT /*+ APPEND */
INTO clst_ww_adr_ch_kk
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id,
   adresseid,
   ptt_strnr
)
SELECT
   a.dwh_cr_load_id,
   a.dwh_processdate,
   CASE WHEN b.id IS NOT NULL THEN 'N' ELSE a.dwh_stbflag END AS dwh_stbflag,
   a.id,
   adresseid,
   ptt_strnr
FROM
clst_ww_adr_ch_kk_u a
LEFT JOIN
clst_ww_adr_ch_kk_n b
ON (a.id = b.id);
 
COMMIT;
 


PROMPT ===========================================
PROMPT 4.4.2 NEW und UPDATE-Datensätze einspielen (Verhaltenskundendaten)
PROMPT ===========================================

INSERT /*+ APPEND */
INTO clst_ww_adr_ch
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id,
   adresseid,
   adrchkdat, 
   adrchkstat
)
SELECT
   a.dwh_cr_load_id,
   a.dwh_processdate,
   CASE WHEN b.id IS NOT NULL THEN 'N' ELSE a.dwh_stbflag END AS dwh_stbflag,
   a.id,
   adresseid,
   adrchkdat, 
   adrchkstat
FROM
clst_ww_adr_ch_u a
LEFT JOIN
clst_ww_adr_ch_n b
ON (a.id = b.id);
 
COMMIT;
 


PROMPT ===========================================
PROMPT 4.5 DEL-Datensätze einspielen
PROMPT ===========================================



PROMPT ===========================================
PROMPT 4.5.1 DEL-Datensätze einspielen (Kernkundendaten)
PROMPT ===========================================

INSERT /*+APPEND */
INTO clst_ww_adr_ch_kk
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id
)
   SELECT 
   &gbvid,
   &termin,
   'D',
   id
FROM clst_ww_adr_ch_kk_d;
 
COMMIT;



PROMPT ===========================================
PROMPT 4.5.2 DEL-Datensätze einspielen (Verhaltenskundendaten)
PROMPT ===========================================

INSERT /*+APPEND */
INTO clst_ww_adr_ch
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id
)
   SELECT 
   &gbvid,
   &termin,
   'D',
   id
FROM clst_ww_adr_ch_d;
 
COMMIT;



PROMPT ===========================================
PROMPT 4.6 ID,AdresseID in einen anonymen Key umwandeln und diesen in eine Zieltabelle im Zielschema schreiben (Verhaltenskundendaten)
PROMPT ===========================================

TRUNCATE TABLE udwh1.clst_ww_adr_ch;

EXEC IMPROG.PKG_CLEARING.P_CLEARING_ANONYMIZE (1, 'KDWH', 'CLST_WW_ADR_CH', 'ID,ADRESSEID','UDWH1', 'CLST_WW_ADR_CH', 'ID_KEY,ADRESSEID_KEY',FALSE); 



PROMPT ===========================================
PROMPT 4.7 Eindeutigkeit prüfen / neue Partition hinzufügen und laden
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_LADUNG_STB ('st_ww_adr_ch_kk_b', &gbvid, 1);        

EXEC PKG_IM_LADUNG.P_LADUNG_STB ('st_ww_adr_ch_b', &gbvid, 1, 'UDWH1');  



PROMPT =========================================================================
PROMPT
PROMPT 5. Stage-Ladung
PROMPT Tabelle: st_ww_adr_it
PROMPT
PROMPT =========================================================================

EXEC PKG_IM_LADUNG.P_LADUNG_STAGE ('kdwh_dh.adr_it&dbludwh', 'st_ww_adr_it', &gbvid);



PROMPT ===========================================
PROMPT 5.1 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'st_ww_adr_it');



PROMPT ===========================================
PROMPT 5.2 Cleanse-Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clst_ww_adr_it;
TRUNCATE TABLE clst_ww_adr_it_u;
TRUNCATE TABLE clst_ww_adr_it_n;
TRUNCATE TABLE clst_ww_adr_it_d;
TRUNCATE TABLE udwh1.clst_ww_adr_it;



PROMPT ===========================================
PROMPT 5.3 Deltaermittlung
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL 
WHEN cnt1 > 0 AND cnt2 = 0 AND src IS NOT NULL THEN  --update und new
INTO clst_ww_adr_it_u
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id,
   adresseid,
   hvs_depot,
   pit_provinzgrp
)
VALUES
(
   &gbvid,
   &termin,
   'U',
   id,
   adresseid,
   hvs_depot,
   pit_provinzgrp
)
WHEN cnt1 > 0 AND cnt2 = 0 AND src IS NULL THEN -- new
INTO clst_ww_adr_it_n
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id
)
VALUES
(
   &gbvid,
   &termin,
   'N',
   id
)
WHEN cnt1 = 0 AND cnt2 > 0 AND src IS NULL THEN -- delete
INTO clst_ww_adr_it_d
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id
)
VALUES
(
   &gbvid,
   &termin,
   'D',
   id
)
SELECT 
   id,
   adresseid,
   hvs_depot,
   pit_provinzgrp,
   COUNT(src1) AS cnt1,
   COUNT(src2) AS cnt2,
   src
FROM
   ( SELECT 
      TRIM(a.id) AS id,
      TRIM(a.adresseid) AS adresseid,
      a.hvs_depot AS hvs_depot,
      a.pit_provinzgrp AS pit_provinzgrp,
      1 src1,
      TO_NUMBER(NULL) src2,
      1 src
    FROM st_ww_adr_it a
  UNION ALL
    SELECT 
      TRIM(b.id) AS id,
      TRIM(b.adresseid) AS adresseid,
      b.hvs_depot AS hvs_depot,
      b.pit_provinzgrp AS pit_provinzgrp,
      TO_NUMBER(NULL) src1,
      2 src2,
      1 src
    FROM st_ww_adr_it_1 b
 ) c
GROUP BY GROUPING SETS ((
   id,
   adresseid,
   hvs_depot,
   pit_provinzgrp,
   src) , (id))
HAVING COUNT(src1) <> COUNT(src2);
 
COMMIT;
 


PROMPT ===========================================
PROMPT 5.4 NEW und UPDATE-Datensätze einspielen
PROMPT ===========================================
 
INSERT /*+ APPEND */
INTO clst_ww_adr_it
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id,
   adresseid,
   hvs_depot,
   pit_provinzgrp
)
SELECT
   a.dwh_cr_load_id,
   a.dwh_processdate,
   CASE WHEN b.id IS NOT NULL THEN 'N' ELSE a.dwh_stbflag END AS dwh_stbflag,
   a.id,
   adresseid,
   hvs_depot,
   pit_provinzgrp
FROM
clst_ww_adr_it_u a
LEFT JOIN
clst_ww_adr_it_n b
ON (a.id = b.id);
 
COMMIT;
 


PROMPT ===========================================
PROMPT 5.5 DEL-Datensätze einspielen
PROMPT ===========================================
 
INSERT /*+APPEND */
INTO clst_ww_adr_it
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id
)
   SELECT 
   &gbvid,
   &termin,
   'D',
   id
FROM clst_ww_adr_it_d;
 
COMMIT;



PROMPT ===========================================
PROMPT 5.6 ID,AdresseID in einen anonymen Key umwandeln und diesen in eine Zieltabelle im Zielschema schreiben
PROMPT ===========================================

TRUNCATE TABLE udwh1.clst_ww_adr_it;

EXEC IMPROG.PKG_CLEARING.P_CLEARING_ANONYMIZE (1, 'KDWH', 'CLST_WW_ADR_IT', 'ID,ADRESSEID','UDWH1', 'CLST_WW_ADR_IT', 'ID_KEY,ADRESSEID_KEY',FALSE); 



PROMPT ===========================================
PROMPT 5.7 Eindeutigkeit prüfen / neue Partition hinzufügen und laden 
PROMPT ===========================================

EXEC PKG_IM_LADUNG.P_LADUNG_STB ('st_ww_adr_it_b', &gbvid, 1, 'UDWH1');



PROMPT =========================================================================
PROMPT
PROMPT 6. Stage-Ladung
PROMPT Tabelle: st_ww_adr_ua_kk
PROMPT          st_ww_adr_ua        
PROMPT
PROMPT =========================================================================
 
EXEC PKG_IM_LADUNG.P_LADUNG_STAGE ('kdwh_dh.adr_ua&dbludwh', 'st_ww_adr_ua_kk', &gbvid);

EXEC PKG_IM_LADUNG.P_LADUNG_STAGE ('kdwh_dh.adr_ua&dbludwh', 'st_ww_adr_ua', &gbvid);


 
PROMPT ===========================================
PROMPT 6.1 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'st_ww_adr_ua_kk');

EXEC PKG_STATS.GATHERTABLE (USER, 'st_ww_adr_ua');

 

PROMPT ===========================================
PROMPT 6.2 Cleanse-Tabellen leeren
PROMPT ===========================================

TRUNCATE TABLE clst_ww_adr_ua_kk;
TRUNCATE TABLE clst_ww_adr_ua_kk_u;
TRUNCATE TABLE clst_ww_adr_ua_kk_n;
TRUNCATE TABLE clst_ww_adr_ua_kk_d;

TRUNCATE TABLE clst_ww_adr_ua;
TRUNCATE TABLE clst_ww_adr_ua_u;
TRUNCATE TABLE clst_ww_adr_ua_n;
TRUNCATE TABLE clst_ww_adr_ua_d;
TRUNCATE TABLE udwh1.clst_ww_adr_ua;



PROMPT ===========================================
PROMPT 6.3 Deltaermittlung
PROMPT ===========================================



PROMPT ===========================================
PROMPT 6.3.1 Deltaermittlung Kernkundendaten
PROMPT ===========================================

INSERT /*+ APPEND */ ALL 
WHEN cnt1 > 0 AND cnt2 = 0 AND src IS NOT NULL THEN  --update und new
INTO clst_ww_adr_ua_kk_u
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id,
   adresseid,
   strru,
   ortru
)
VALUES
(
   &gbvid,
   &termin,
   'U',
   id,
   adresseid,
   strru,
   ortru
)
WHEN cnt1 > 0 AND cnt2 = 0 AND src IS NULL THEN -- new
INTO clst_ww_adr_ua_kk_n
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id
)
VALUES
(
   &gbvid,
   &termin,
   'N',
   id
)
WHEN cnt1 = 0 AND cnt2 > 0 AND src IS NULL THEN -- delete
INTO clst_ww_adr_ua_kk_d
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id
)
VALUES
(
   &gbvid,
   &termin,
   'D',
   id
)
SELECT 
   id,
   adresseid,
   strru,
   ortru,
   COUNT(src1) AS cnt1,
   COUNT(src2) AS cnt2,
   src
FROM
   ( SELECT 
      TRIM(a.id) AS id,
      TRIM(a.adresseid) AS adresseid,
      TRIM(a.strru) AS strru,
      TRIM(a.ortru) AS ortru,
      1 src1,
      TO_NUMBER(NULL) src2,
      1 src
    FROM st_ww_adr_ua_kk a
  UNION ALL
    SELECT 
      TRIM(b.id) AS id,
      TRIM(b.adresseid) AS adresseid,
      TRIM(b.strru) AS strru,
      TRIM(b.ortru) AS ortru,
      TO_NUMBER(NULL) src1,
      2 src2,
      1 src
    FROM st_ww_adr_ua_kk_1 b
 ) c
GROUP BY GROUPING SETS ((
   id,
   adresseid,
   strru,
   ortru,
   src) , (id))
HAVING COUNT(src1) <> COUNT(src2);
 
COMMIT;
 


PROMPT ===========================================
PROMPT 6.3.2 Deltaermittlung Verhaltenskundendaten
PROMPT ===========================================

INSERT /*+ APPEND */ ALL 
WHEN cnt1 > 0 AND cnt2 = 0 AND src IS NOT NULL THEN  --update und new
INTO clst_ww_adr_ua_u
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id,
   adresseid,
   region,
   bezirk
)
VALUES
(
   &gbvid,
   &termin,
   'U',
   id,
   adresseid,
   region,
   bezirk
)
WHEN cnt1 > 0 AND cnt2 = 0 AND src IS NULL THEN -- new
INTO clst_ww_adr_ua_n
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id
)
VALUES
(
   &gbvid,
   &termin,
   'N',
   id
)
WHEN cnt1 = 0 AND cnt2 > 0 AND src IS NULL THEN -- delete
INTO clst_ww_adr_ua_d
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id
)
VALUES
(
   &gbvid,
   &termin,
   'D',
   id
)
SELECT 
   id,
   adresseid,
   region,
   bezirk,
   COUNT(src1) AS cnt1,
   COUNT(src2) AS cnt2,
   src
FROM
   ( SELECT 
      TRIM(a.id) AS id,
      TRIM(a.adresseid) AS adresseid,
      TRIM(a.region) AS region,
      TRIM(a.bezirk) AS bezirk,
      1 src1,
      TO_NUMBER(NULL) src2,
      1 src
    FROM st_ww_adr_ua a
  UNION ALL
    SELECT 
      TRIM(b.id) AS id,
      TRIM(b.adresseid) AS adresseid,
      TRIM(b.region) AS region,
      TRIM(b.bezirk) AS bezirk,
      TO_NUMBER(NULL) src1,
      2 src2,
      1 src
    FROM st_ww_adr_ua_1 b
 ) c
GROUP BY GROUPING SETS ((
   id,
   adresseid,
   region,
   bezirk,
   src) , (id))
HAVING COUNT(src1) <> COUNT(src2);
 
COMMIT;
 

 
PROMPT ===========================================
PROMPT 6.4 NEW und UPDATE-Datensätze einspielen
PROMPT ===========================================



PROMPT ===========================================
PROMPT 6.4.1 NEW und UPDATE-Datensätze einspielen (Kernkundendaten)
PROMPT ===========================================


INSERT /*+ APPEND */
INTO clst_ww_adr_ua_kk
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id,
   adresseid,
   strru,
   ortru
)
SELECT
   a.dwh_cr_load_id,
   a.dwh_processdate,
   CASE WHEN b.id IS NOT NULL THEN 'N' ELSE a.dwh_stbflag END AS dwh_stbflag,
   a.id,
   adresseid,
   strru,
   ortru
FROM
clst_ww_adr_ua_kk_u a
LEFT JOIN
clst_ww_adr_ua_kk_n b
ON (a.id = b.id);
 
COMMIT;
 

 
PROMPT ===========================================
PROMPT 6.4.2 NEW und UPDATE-Datensätze einspielen (Verhaltenskundendaten)
PROMPT ===========================================


INSERT /*+ APPEND */
INTO clst_ww_adr_ua
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id,
   adresseid,
   region,
   bezirk
)
SELECT
   a.dwh_cr_load_id,
   a.dwh_processdate,
   CASE WHEN b.id IS NOT NULL THEN 'N' ELSE a.dwh_stbflag END AS dwh_stbflag,
   a.id,
   adresseid,
   region,
   bezirk
FROM
clst_ww_adr_ua_u a
LEFT JOIN
clst_ww_adr_ua_n b
ON (a.id = b.id);
 
COMMIT;



PROMPT ===========================================
PROMPT 6.5 DEL-Datensätze einspielen
PROMPT ===========================================



PROMPT ===========================================
PROMPT 6.5.1 DEL-Datensätze einspielen (Kernkundendaten)
PROMPT ===========================================

INSERT /*+APPEND */
INTO clst_ww_adr_ua_kk
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id
)
   SELECT 
   &gbvid,
   &termin,
   'D',
   id
FROM clst_ww_adr_ua_kk_d;
 
COMMIT;



PROMPT ===========================================
PROMPT 6.5.2 DEL-Datensätze einspielen (Verhaltenskundendaten)
PROMPT ===========================================

INSERT /*+APPEND */
INTO clst_ww_adr_ua
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id
)
   SELECT 
   &gbvid,
   &termin,
   'D',
   id
FROM clst_ww_adr_ua_d;
 
COMMIT;



PROMPT ===========================================
PROMPT 6.6 ID,AdresseID in einen anonymen Key umwandeln und diesen in eine Zieltabelle im Zielschema schreiben (Verhaltenskundendaten)
PROMPT ===========================================

TRUNCATE TABLE udwh1.clst_ww_adr_ua;

EXEC IMPROG.PKG_CLEARING.P_CLEARING_ANONYMIZE (1, 'KDWH', 'CLST_WW_ADR_UA', 'ID,ADRESSEID','UDWH1', 'CLST_WW_ADR_UA', 'ID_KEY,ADRESSEID_KEY',FALSE); 

 

PROMPT ===========================================
PROMPT 6.7 Eindeutigkeit prüfen / neue Partition hinzufügen und laden 
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_LADUNG_STB ('st_ww_adr_ua_kk_b', &gbvid, 1);

EXEC PKG_IM_LADUNG.P_LADUNG_STB ('st_ww_adr_ua_b', &gbvid, 1, 'UDWH1');



PROMPT =========================================================================
PROMPT
PROMPT 7. Stage-Ladung
PROMPT Tabelle: st_ww_adresse_kk
PROMPT          st_ww_adresse
PROMPT
PROMPT =========================================================================
 
EXEC PKG_IM_LADUNG.P_LADUNG_STAGE ('kdwh_dh.adresse&dbludwh', 'st_ww_adresse_kk', &gbvid);

EXEC PKG_IM_LADUNG.P_LADUNG_STAGE ('kdwh_dh.adresse&dbludwh', 'st_ww_adresse', &gbvid);



PROMPT ===========================================
PROMPT 7.1 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'st_ww_adresse_kk');

EXEC PKG_STATS.GATHERTABLE (USER, 'st_ww_adresse');
 


PROMPT ===========================================
PROMPT 7.2 Cleanse-Tabellen leeren
PROMPT ===========================================

TRUNCATE TABLE clst_ww_adresse_kk;
TRUNCATE TABLE clst_ww_adresse_kk_u;
TRUNCATE TABLE clst_ww_adresse_kk_n;
TRUNCATE TABLE clst_ww_adresse_kk_d;

TRUNCATE TABLE clst_ww_adresse;
TRUNCATE TABLE clst_ww_adresse_u;
TRUNCATE TABLE clst_ww_adresse_n;
TRUNCATE TABLE clst_ww_adresse_d;
TRUNCATE TABLE udwh1.clst_ww_adresse;



PROMPT ===========================================
PROMPT 7.3 Deltaermittlung
PROMPT ===========================================



PROMPT ===========================================
PROMPT 7.3.1 Deltaermittlung Kernkundendaten
PROMPT ===========================================

INSERT /*+ APPEND */ ALL 
WHEN cnt1 > 0 AND cnt2 = 0 AND src IS NOT NULL THEN  --update und new
INTO clst_ww_adresse_kk_u
(
   dwh_cr_load_id,
   dwh_processdate,
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
)
VALUES
(
   &gbvid,
   &termin,
   'U',
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
WHEN cnt1 > 0 AND cnt2 = 0 AND src IS NULL THEN -- new
INTO clst_ww_adresse_kk_n
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id
)
VALUES
(
   &gbvid,
   &termin,
   'N',
   id
)
WHEN cnt1 = 0 AND cnt2 > 0 AND src IS NULL THEN -- delete
INTO clst_ww_adresse_kk_d
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id
)
VALUES
(
   &gbvid,
   &termin,
   'D',
   id
)
SELECT 
   id,
   landid,
   hsnr,
   hsnrzus1,
   hsnrzus2,
   str,
   plz,
   ort,
   plzzus,
   COUNT(src1) AS cnt1,
   COUNT(src2) AS cnt2,
   src
FROM
   ( SELECT 
      TRIM(a.id) AS id,
      TRIM(a.landid) AS landid,
      a.hsnr AS hsnr,
      TRIM(a.hsnrzus1) AS hsnrzus1,
      TRIM(a.hsnrzus2) AS hsnrzus2,
      TRIM(a.str) AS str,
      TRIM(a.plz) AS plz,
      TRIM(a.ort) AS ort,
      TRIM(a.plzzus) AS plzzus,
      1 src1,
      TO_NUMBER(NULL) src2,
      1 src
    FROM st_ww_adresse_kk a
  UNION ALL
    SELECT 
      TRIM(b.id) AS id,
      TRIM(b.landid) AS landid,
      b.hsnr AS hsnr,
      TRIM(b.hsnrzus1) AS hsnrzus1,
      TRIM(b.hsnrzus2) AS hsnrzus2,
      TRIM(b.str) AS str,
      TRIM(b.plz) AS plz,
      TRIM(b.ort) AS ort,
      TRIM(b.plzzus) AS plzzus,
      TO_NUMBER(NULL) src1,
      2 src2,
      1 src
    FROM st_ww_adresse_kk_1 b
 ) c
GROUP BY GROUPING SETS ((
   id,
   landid,
   hsnr,
   hsnrzus1,
   hsnrzus2,
   str,
   plz,
   ort,
   plzzus,
   src) , (id))
HAVING COUNT(src1) <> COUNT(src2);
 
COMMIT;
 


PROMPT ===========================================
PROMPT 7.3.2 Deltaermittlung Verhaltenskundendaten
PROMPT ===========================================

INSERT /*+ APPEND */ ALL 
WHEN cnt1 > 0 AND cnt2 = 0 AND src IS NOT NULL THEN  --update und new
INTO clst_ww_adresse_u
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id,
   landid,
   plz,
   plzzus, 
   erzwungenkz
)
VALUES
(
   &gbvid,
   &termin,
   'U',
   id,
   landid,
   plz,
   plzzus,
   erzwungenkz
)
WHEN cnt1 > 0 AND cnt2 = 0 AND src IS NULL THEN -- new
INTO clst_ww_adresse_n
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id
)
VALUES
(
   &gbvid,
   &termin,
   'N',
   id
)
WHEN cnt1 = 0 AND cnt2 > 0 AND src IS NULL THEN -- delete
INTO clst_ww_adresse_d
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id
)
VALUES
(
   &gbvid,
   &termin,
   'D',
   id
)
SELECT 
   id,
   landid,
   plz,
   plzzus,
   erzwungenkz,
   COUNT(src1) AS cnt1,
   COUNT(src2) AS cnt2,
   src
FROM
   ( SELECT 
      TRIM(a.id) AS id,
      TRIM(a.landid) AS landid,
      TRIM(a.plz) AS plz,
      TRIM(a.plzzus) AS plzzus,
      a.erzwungenkz AS erzwungenkz,
      1 src1,
      TO_NUMBER(NULL) src2,
      1 src
    FROM st_ww_adresse a
  UNION ALL
    SELECT 
      TRIM(b.id) AS id,
      TRIM(b.landid) AS landid,
      TRIM(b.plz) AS plz,
      TRIM(b.plzzus) AS plzzus,
      b.erzwungenkz AS erzwungenkz,
      TO_NUMBER(NULL) src1,
      2 src2,
      1 src
    FROM st_ww_adresse_1 b
 ) c
GROUP BY GROUPING SETS ((
   id,
   landid,
   plz,
   plzzus,
   erzwungenkz,
   src) , (id))
HAVING COUNT(src1) <> COUNT(src2);
 
COMMIT;



PROMPT ===========================================
PROMPT 7.4 NEW und UPDATE-Datensätze einspielen
PROMPT ===========================================



PROMPT ===========================================
PROMPT 7.4.1 NEW und UPDATE-Datensätze einspielen (Kernkundendaten)
PROMPT ===========================================

INSERT /*+ APPEND */
INTO clst_ww_adresse_kk
(
   dwh_cr_load_id,
   dwh_processdate,
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
)
SELECT
   a.dwh_cr_load_id,
   a.dwh_processdate,
   CASE WHEN b.id IS NOT NULL THEN 'N' ELSE a.dwh_stbflag END AS dwh_stbflag,
   a.id,
   landid,
   hsnr,
   hsnrzus1,
   hsnrzus2,
   str,
   plz,
   ort,
   plzzus
FROM
clst_ww_adresse_kk_u a
LEFT JOIN
clst_ww_adresse_kk_n b
ON (a.id = b.id);
 
COMMIT;



PROMPT ===========================================
PROMPT 7.4.2 NEW und UPDATE-Datensätze einspielen (Verhaltenskundendaten)
PROMPT ===========================================

INSERT /*+ APPEND */
INTO clst_ww_adresse
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id,
   landid,
   plz,
   plzzus,
   erzwungenkz,
   postfach
)
SELECT
   a.dwh_cr_load_id,
   a.dwh_processdate,
   CASE WHEN b.id IS NOT NULL THEN 'N' ELSE a.dwh_stbflag END AS dwh_stbflag,
   a.id,
   a.landid,
   a.plz,
   a.plzzus,
   a.erzwungenkz,
   CASE WHEN UPPER(kk.str) LIKE '%POSTFACH%' THEN 1 ELSE 0 END AS postfach
FROM
clst_ww_adresse_u a
INNER JOIN 
st_ww_adresse_kk kk    -- JOIN mit U reicht aus, weil unten ja nochmal die "N"s der KK dazugemerged werden
ON (a.id = kk.id)
LEFT JOIN
clst_ww_adresse_n b
ON (a.id = b.id);
 
COMMIT;


PROMPT ===========================================
PROMPT 7.5 DEL-Datensätze einspielen
PROMPT ===========================================



PROMPT ===========================================
PROMPT 7.5.1 DEL-Datensätze einspielen (Kernkundendaten)
PROMPT ===========================================

INSERT /*+APPEND */
INTO clst_ww_adresse_kk
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id
)
   SELECT 
   &gbvid,
   &termin,
   'D',
   id
FROM clst_ww_adresse_kk_d;
 
COMMIT;



PROMPT ===========================================
PROMPT 7.5.2 DEL-Datensätze einspielen (Verhaltenskundendaten)
PROMPT ===========================================

INSERT /*+APPEND */
INTO clst_ww_adresse
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id
)
   SELECT 
   &gbvid,
   &termin,
   'D',
   id
FROM clst_ww_adresse_d;
 
COMMIT;


PROMPT ===========================================
PROMPT 7.5.3 POSTFACH dazu, wenn sich aus KK was veraendert
PROMPT ===========================================

MERGE INTO kdwh.clst_ww_adresse a 
USING (
        SELECT url.*,
               CASE WHEN UPPER(kk.str) LIKE '%POSTFACH%' THEN 1 ELSE 0 END AS postfach     
        FROM clst_ww_adresse_kk kk INNER JOIN st_ww_adresse url ON (kk.id = url.id)
        WHERE dwh_stbflag in ('N','U')       
      ) b
ON (a.id = b.id)
WHEN MATCHED THEN UPDATE 
SET
   a.postfach = b.postfach
WHEN NOT MATCHED THEN INSERT  
 ( 
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id,
   landid,
   plz,
   plzzus,
   erzwungenkz,
   postfach
  )
VALUES
( 
   &gbvid, 
   &termin, 
   'U', 
   b.id,
   b.landid,
   b.plz,
   b.plzzus,
   b.erzwungenkz,
   b.postfach
  );

COMMIT;  



PROMPT ===========================================
PROMPT 7.6 ID in einen anonymen Key umwandeln und diesen in eine Zieltabelle im Zielschema schreiben (Verhaltenskundendaten)
PROMPT ===========================================

TRUNCATE TABLE udwh1.clst_ww_adresse;

EXEC IMPROG.PKG_CLEARING.P_CLEARING_ANONYMIZE (1, 'KDWH', 'CLST_WW_ADRESSE', 'ID','UDWH1', 'CLST_WW_ADRESSE', 'ID_KEY',FALSE); 

 

PROMPT ===========================================
PROMPT 7.7 Eindeutigkeit prüfen / neue Partition hinzufügen und laden 
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_LADUNG_STB ('st_ww_adresse_kk_b', &gbvid, 1);

EXEC PKG_IM_LADUNG.P_LADUNG_STB ('st_ww_adresse_b', &gbvid, 1, 'UDWH1');



PROMPT =========================================================================
PROMPT
PROMPT 8. Stage-Ladung
PROMPT Tabelle: st_ww_person_kk
PROMPT          st_ww_person
PROMPT
PROMPT =========================================================================

EXEC PKG_IM_LADUNG.P_LADUNG_STAGE ('kdwh_dh.person&dbludwh', 'st_ww_person_kk', &gbvid);

EXEC PKG_IM_LADUNG.P_LADUNG_STAGE ('kdwh_dh.person&dbludwh', 'st_ww_person', &gbvid);



PROMPT ===========================================
PROMPT 8.1 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'st_ww_person_kk');

EXEC PKG_STATS.GATHERTABLE (USER, 'st_ww_person');
 


PROMPT ===========================================
PROMPT 8.2 Cleanse-Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clst_ww_person_kk;
TRUNCATE TABLE clst_ww_person_kk_u;
TRUNCATE TABLE clst_ww_person_kk_n;
TRUNCATE TABLE clst_ww_person_kk_d;

TRUNCATE TABLE clst_ww_person;
TRUNCATE TABLE clst_ww_person_u;
TRUNCATE TABLE clst_ww_person_n;
TRUNCATE TABLE clst_ww_person_d;
TRUNCATE TABLE udwh1.clst_ww_person;



PROMPT ===========================================
PROMPT 8.3 Deltaermittlung
PROMPT ===========================================



PROMPT ===========================================
PROMPT 8.3.1 Deltaermittlung Kernkundendaten
PROMPT ===========================================

INSERT /*+ APPEND */ ALL 
WHEN cnt1 > 0 AND cnt2 = 0 AND src IS NOT NULL THEN  --update und new
INTO clst_ww_person_kk_u
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id,
   adresseid,
   vname,
   nname,
   gebdat,
   adrzus,
   gebname,
   emailfirma,               
   emailprivat,                      
   faxfirmarufnummer,       
   faxfirmavorwahl,          
   faxprivatrufnummer,       
   faxprivatvorwahl,         
   handyfirma,               
   handyprivat,                  
   telefonfirmarufnummer,    
   telefonfirmavorwahl,      
   telefonprivatrufnummer,   
   telefonprivatvorwahl,
   nlanmeldip,
   telefonprivat, 
   telefonfirma, 
   faxprivat, 
   faxfirma
)
VALUES
(
   &gbvid,
   &termin,
   'U',
   id,
   adresseid,
   vname,
   nname,
   gebdat,
   adrzus,
   gebname,
   emailfirma,               
   emailprivat,                      
   faxfirmarufnummer,       
   faxfirmavorwahl,          
   faxprivatrufnummer,       
   faxprivatvorwahl,         
   handyfirma,               
   handyprivat,                  
   telefonfirmarufnummer,    
   telefonfirmavorwahl,      
   telefonprivatrufnummer,   
   telefonprivatvorwahl,
   nlanmeldip,
   telefonprivat, 
   telefonfirma, 
   faxprivat, 
   faxfirma
)
WHEN cnt1 > 0 AND cnt2 = 0 AND src IS NULL THEN -- new
INTO clst_ww_person_kk_n
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id
)
VALUES
(
   &gbvid,
   &termin,
   'N',
   id
)
WHEN cnt1 = 0 AND cnt2 > 0 AND src IS NULL THEN -- delete
INTO clst_ww_person_kk_d
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id
)
VALUES
(
   &gbvid,
   &termin,
   'D',
   id
)
SELECT 
   id,
   adresseid,
   vname,
   nname,
   gebdat,
   adrzus,
   gebname,
   emailfirma,               
   emailprivat,                      
   faxfirmarufnummer,       
   faxfirmavorwahl,          
   faxprivatrufnummer,       
   faxprivatvorwahl,         
   handyfirma,               
   handyprivat,                  
   telefonfirmarufnummer,    
   telefonfirmavorwahl,      
   telefonprivatrufnummer,   
   telefonprivatvorwahl,
   nlanmeldip,
   telefonprivat, 
   telefonfirma, 
   faxprivat, 
   faxfirma,
   COUNT(src1) AS cnt1,
   COUNT(src2) AS cnt2,
   src
FROM
   (  SELECT 
      TRIM(a.id) AS id,
      TRIM(a.adresseid) AS adresseid,
      TRIM(a.vname) AS vname,
      TRIM(a.nname) AS nname,
      a.gebdat AS gebdat,
      TRIM(a.adrzus) AS adrzus,
      TRIM(a.gebname) AS gebname,
      TRIM(LOWER(a.emailfirma)) AS emailfirma,               
      TRIM(LOWER(a.emailprivat)) AS emailprivat,                     
      TRIM(a.faxfirmarufnummer) AS faxfirmarufnummer,       
      TRIM(a.faxfirmavorwahl) AS faxfirmavorwahl,          
      TRIM(a.faxprivatrufnummer) AS faxprivatrufnummer,       
      TRIM(a.faxprivatvorwahl) AS faxprivatvorwahl,         
      TRIM(a.handyfirma) AS handyfirma,               
      TRIM(a.handyprivat) AS handyprivat,                 
      TRIM(a.telefonfirmarufnummer) AS telefonfirmarufnummer,    
      TRIM(a.telefonfirmavorwahl) AS telefonfirmavorwahl,      
      TRIM(a.telefonprivatrufnummer) AS telefonprivatrufnummer,   
      TRIM(a.telefonprivatvorwahl) AS  telefonprivatvorwahl,  
      TRIM(a.nlanmeldip) AS nlanmeldip, 
      TRIM(a.telefonprivat) AS telefonprivat, 
      TRIM(a.telefonfirma) AS telefonfirma, 
      TRIM(a.faxprivat) AS faxprivat, 
      TRIM(a.faxfirma) AS faxfirma,
      1 src1,
      TO_NUMBER(NULL) src2,
      1 src
    FROM st_ww_person_kk a
  UNION ALL
    SELECT 
      TRIM(b.id) AS id,
      TRIM(b.adresseid) AS adresseid,
      TRIM(b.vname) AS vname,
      TRIM(b.nname) AS nname,
      b.gebdat AS gebdat,
      TRIM(b.adrzus) AS adrzus,
      TRIM(b.gebname) AS gebname,
      TRIM(LOWER(b.emailfirma)) AS emailfirma,               
      TRIM(LOWER(b.emailprivat)) AS emailprivat,                     
      TRIM(b.faxfirmarufnummer) AS faxfirmarufnummer,       
      TRIM(b.faxfirmavorwahl) AS faxfirmavorwahl,          
      TRIM(b.faxprivatrufnummer) AS faxprivatrufnummer,       
      TRIM(b.faxprivatvorwahl) AS faxprivatvorwahl,         
      TRIM(b.handyfirma) AS handyfirma,               
      TRIM(b.handyprivat) AS handyprivat,                 
      TRIM(b.telefonfirmarufnummer) AS telefonfirmarufnummer,    
      TRIM(b.telefonfirmavorwahl) AS telefonfirmavorwahl,      
      TRIM(b.telefonprivatrufnummer) AS telefonprivatrufnummer,   
      TRIM(b.telefonprivatvorwahl) AS  telefonprivatvorwahl,  
      TRIM(b.nlanmeldip) AS nlanmeldip,
      TRIM(b.telefonprivat) AS telefonprivat, 
      TRIM(b.telefonfirma) AS telefonfirma, 
      TRIM(b.faxprivat) AS faxprivat, 
      TRIM(b.faxfirma) AS faxfirma,
      TO_NUMBER(NULL) src1,
      2 src2,
      1 src
    FROM st_ww_person_kk_1 b
 ) c
GROUP BY GROUPING SETS ((
   id,
   adresseid,
   vname,
   nname,
   gebdat,
   adrzus,
   gebname,
   emailfirma,               
   emailprivat,                      
   faxfirmarufnummer,       
   faxfirmavorwahl,          
   faxprivatrufnummer,       
   faxprivatvorwahl,         
   handyfirma,               
   handyprivat,                  
   telefonfirmarufnummer,    
   telefonfirmavorwahl,      
   telefonprivatrufnummer,   
   telefonprivatvorwahl,
   nlanmeldip,
   telefonprivat, 
   telefonfirma, 
   faxprivat, 
   faxfirma,
   src) , (id))
HAVING COUNT(src1) <> COUNT(src2);
 
COMMIT;
  
 

PROMPT ===========================================
PROMPT 8.3.2 Deltaermittlung Verhaltenskundendaten
PROMPT ===========================================

INSERT /*+ APPEND */ ALL 
WHEN cnt1 > 0 AND cnt2 = 0 AND src IS NOT NULL THEN  --update und new
INTO clst_ww_person_u
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id,
   persanredeid,
   adresseid,
   firmaid,
   ti,
   vname,          
   gebdat,
   adrhdlid,
   gebdatstatus,             
   emailverweigertkz,               
   faxfirmavorwahl,               
   faxprivatvorwahl,                      
   rufnummerverweigertkz,      
   telefonfirmavorwahl,      
   telefonprivatvorwahl,
   anldat,    
   prozessidanl,
   benutzeridanl,
   letztaenddat,
   prozessidletztaend,  
   benutzeridletztaend,    
   nlanmeldeinwtxt,
   serviceinfobestellungkz,
   serviceinfoversandkz,
   serviceinfozahlungeingangkz,
   serviceinforetoureeingangkz,
   serviceinfonaliinfoversandkz,
   serviceinfohvspaketankuendkz,
   serviceinforechnungversandkz
)
VALUES
(
   &gbvid,
   &termin,
   'U',
   id,
   persanredeid,
   adresseid,
   firmaid,
   ti,
   vname,
   gebdat,
   adrhdlid,
   gebdatstatus,             
   emailverweigertkz,               
   faxfirmavorwahl,               
   faxprivatvorwahl,                      
   rufnummerverweigertkz,      
   telefonfirmavorwahl,      
   telefonprivatvorwahl,
   anldat,    
   prozessidanl,
   benutzeridanl,
   letztaenddat,
   prozessidletztaend,  
   benutzeridletztaend,    
   nlanmeldeinwtxt,
   serviceinfobestellungkz,
   serviceinfoversandkz,
   serviceinfozahlungeingangkz,
   serviceinforetoureeingangkz,
   serviceinfonaliinfoversandkz,
   serviceinfohvspaketankuendkz,
   serviceinforechnungversandkz
)
WHEN cnt1 > 0 AND cnt2 = 0 AND src IS NULL THEN -- new
INTO clst_ww_person_n
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id
)
VALUES
(
   &gbvid,
   &termin,
   'N',
   id
)
WHEN cnt1 = 0 AND cnt2 > 0 AND src IS NULL THEN -- delete
INTO clst_ww_person_d
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id
)
VALUES
(
   &gbvid,
   &termin,
   'D',
   id
)
SELECT 
   id,
   persanredeid,
   adresseid,
   firmaid,
   ti,
   vname,
   gebdat,
   adrhdlid,
   gebdatstatus,             
   emailverweigertkz,               
   faxfirmavorwahl,               
   faxprivatvorwahl,                      
   rufnummerverweigertkz,      
   telefonfirmavorwahl,      
   telefonprivatvorwahl,
   anldat,    
   prozessidanl,
   benutzeridanl,
   letztaenddat,
   prozessidletztaend,  
   benutzeridletztaend,    
   nlanmeldeinwtxt,
   serviceinfobestellungkz,
   serviceinfoversandkz,
   serviceinfozahlungeingangkz,
   serviceinforetoureeingangkz,
   serviceinfonaliinfoversandkz,
   serviceinfohvspaketankuendkz,
   serviceinforechnungversandkz,
   COUNT(src1) AS cnt1,
   COUNT(src2) AS cnt2,
   src
FROM
   (  SELECT 
      TRIM(a.id) AS id,
      TRIM(a.persanredeid) AS persanredeid,
      TRIM(a.adresseid) AS adresseid,
      TRIM(a.firmaid) AS firmaid,
      TRIM(a.ti) AS ti,
      TRIM(a.vname) AS vname,
      a.gebdat AS gebdat,
      TRIM(a.adrhdlid) AS adrhdlid,
      a.gebdatstatus AS gebdatstatus,             
      COALESCE(a.emailverweigertkz,0) AS emailverweigertkz,              
      TRIM(a.faxfirmavorwahl) AS faxfirmavorwahl,              
      TRIM(a.faxprivatvorwahl) AS faxprivatvorwahl,                      
      COALESCE(a.rufnummerverweigertkz,0) AS rufnummerverweigertkz,     
      TRIM(a.telefonfirmavorwahl) AS telefonfirmavorwahl,      
      TRIM(a.telefonprivatvorwahl) AS  telefonprivatvorwahl,
      TRIM(a.anldat) AS anldat,    
      TRIM(a.prozessidanl) AS prozessidanl,
      TRIM(a.benutzeridanl) AS benutzeridanl,
      TRIM(a.letztaenddat) AS letztaenddat,
      TRIM(a.prozessidletztaend) AS prozessidletztaend,  
      TRIM(a.benutzeridletztaend) AS benutzeridletztaend,  
      TRIM(a.nlanmeldeinwtxt) AS nlanmeldeinwtxt, 
      a.serviceinfobestellungkz AS serviceinfobestellungkz,
      a.serviceinfoversandkz AS serviceinfoversandkz,
      a.serviceinfozahlungeingangkz AS serviceinfozahlungeingangkz,
      a.serviceinforetoureeingangkz AS serviceinforetoureeingangkz,
      a.serviceinfonaliinfoversandkz AS serviceinfonaliinfoversandkz,
      a.serviceinfohvspaketankuendkz AS serviceinfohvspaketankuendkz,
      a.serviceinforechnungversandkz AS serviceinforechnungversandkz,
      1 src1,
      TO_NUMBER(NULL) src2,
      1 src
    FROM st_ww_person a
  UNION ALL
    SELECT 
      TRIM(b.id) AS id,
      TRIM(b.persanredeid) AS persanredeid,
      TRIM(b.adresseid) AS adresseid,
      TRIM(b.firmaid) AS firmaid,
      TRIM(b.ti) AS ti,
      TRIM(b.vname) AS vname,
      b.gebdat AS gebdat,
      TRIM(b.adrhdlid) AS adrhdlid,
      b.gebdatstatus AS gebdatstatus,             
      COALESCE(b.emailverweigertkz,0) AS emailverweigertkz,              
      TRIM(b.faxfirmavorwahl) AS faxfirmavorwahl,              
      TRIM(b.faxprivatvorwahl) AS faxprivatvorwahl,                      
      COALESCE(b.rufnummerverweigertkz,0) AS rufnummerverweigertkz,     
      TRIM(b.telefonfirmavorwahl) AS telefonfirmavorwahl,      
      TRIM(b.telefonprivatvorwahl) AS  telefonprivatvorwahl,
      TRIM(b.anldat) AS anldat,    
      TRIM(b.prozessidanl) AS prozessidanl,
      TRIM(b.benutzeridanl) AS benutzeridanl,
      TRIM(b.letztaenddat) AS letztaenddat,
      TRIM(b.prozessidletztaend) AS prozessidletztaend,  
      TRIM(b.benutzeridletztaend) AS benutzeridletztaend,  
      TRIM(b.nlanmeldeinwtxt) AS nlanmeldeinwtxt, 
      b.serviceinfobestellungkz AS serviceinfobestellungkz,
      b.serviceinfoversandkz AS serviceinfoversandkz,
      b.serviceinfozahlungeingangkz AS serviceinfozahlungeingangkz,
      b.serviceinforetoureeingangkz AS serviceinforetoureeingangkz,
      b.serviceinfonaliinfoversandkz AS serviceinfonaliinfoversandkz,
      b.serviceinfohvspaketankuendkz AS serviceinfohvspaketankuendkz,
      b.serviceinforechnungversandkz AS serviceinforechnungversandkz,
      TO_NUMBER(NULL) src1,
      2 src2,
      1 src
    FROM st_ww_person_1 b
 ) c
GROUP BY GROUPING SETS ((
   id,
   persanredeid,
   adresseid,
   firmaid,
   ti,
   vname,          
   gebdat,
   adrhdlid,
   gebdatstatus,             
   emailverweigertkz,               
   faxfirmavorwahl,               
   faxprivatvorwahl,                      
   rufnummerverweigertkz,      
   telefonfirmavorwahl,      
   telefonprivatvorwahl,
   anldat,    
   prozessidanl,
   benutzeridanl,
   letztaenddat,
   prozessidletztaend,  
   benutzeridletztaend,    
   nlanmeldeinwtxt,
   serviceinfobestellungkz,
   serviceinfoversandkz,
   serviceinfozahlungeingangkz,
   serviceinforetoureeingangkz,
   serviceinfonaliinfoversandkz,
   serviceinfohvspaketankuendkz,
   serviceinforechnungversandkz,
   src) , (id))
HAVING COUNT(src1) <> COUNT(src2);
 
COMMIT;
  


PROMPT ===========================================
PROMPT 8.4 NEW und UPDATE-Datensätze einspielen
PROMPT ===========================================



PROMPT ===========================================
PROMPT 8.4.1 NEW und UPDATE-Datensätze einspielen (Kernkundendaten)
PROMPT ===========================================

INSERT /*+ APPEND */
INTO clst_ww_person_kk
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id,
   adresseid,
   vname,
   nname,
   gebdat,
   adrzus,
   gebname,
   emailfirma,               
   emailprivat,                      
   faxfirmarufnummer,       
   faxfirmavorwahl,          
   faxprivatrufnummer,       
   faxprivatvorwahl,         
   handyfirma,               
   handyprivat,                  
   telefonfirmarufnummer,    
   telefonfirmavorwahl,      
   telefonprivatrufnummer,   
   telefonprivatvorwahl,
   nlanmeldip,
   telefonprivat, 
   telefonfirma, 
   faxprivat, 
   faxfirma
)
SELECT
   a.dwh_cr_load_id,
   a.dwh_processdate,
   CASE WHEN b.id IS NOT NULL THEN 'N' ELSE a.dwh_stbflag END AS dwh_stbflag,
   a.id,
   adresseid,
   vname,
   nname,
   gebdat,
   adrzus,
   gebname,
   emailfirma,               
   emailprivat,                      
   faxfirmarufnummer,       
   faxfirmavorwahl,          
   faxprivatrufnummer,       
   faxprivatvorwahl,         
   handyfirma,               
   handyprivat,                  
   telefonfirmarufnummer,    
   telefonfirmavorwahl,      
   telefonprivatrufnummer,   
   telefonprivatvorwahl,
   nlanmeldip,
   telefonprivat, 
   telefonfirma, 
   faxprivat, 
   faxfirma
FROM
clst_ww_person_kk_u a
LEFT JOIN
clst_ww_person_kk_n b
ON (a.id = b.id);
 
COMMIT;
 


PROMPT ===========================================
PROMPT 8.4.2 NEW und UPDATE-Datensätze einspielen (Verhaltenskundendaten)
PROMPT ===========================================

INSERT /*+ APPEND */
INTO clst_ww_person
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id,
   persanredeid,
   adresseid,
   firmaid,
   ti,
   vname,
   gebdat,
   adrhdlid,
   gebdatstatus,             
   emailverweigertkz,               
   faxfirmavorwahl,               
   faxprivatvorwahl,                      
   rufnummerverweigertkz,      
   telefonfirmavorwahl,      
   telefonprivatvorwahl,
   anldat,    
   prozessidanl,
   benutzeridanl,
   letztaenddat,
   prozessidletztaend,  
   benutzeridletztaend,    
   nlanmeldeinwtxt,
   serviceinfobestellungkz,
   serviceinfoversandkz,
   serviceinfozahlungeingangkz,
   serviceinforetoureeingangkz,
   serviceinfonaliinfoversandkz,
   serviceinfohvspaketankuendkz,
   email_vorhanden, 
   handy_vorhanden, 
   email_hash,
   telefonprivat_vorhanden,
   datenschutz,
   nachnameersterletter,
   serviceinforechnungversandkz,
   emailprivat
)
SELECT
   a.dwh_cr_load_id,
   a.dwh_processdate,
   CASE WHEN b.id IS NOT NULL THEN 'N' ELSE a.dwh_stbflag END AS dwh_stbflag,
   a.id,
   persanredeid,
   a.adresseid,
   firmaid,
   ti,
   a.vname,
   a.gebdat,
   adrhdlid,
   gebdatstatus,             
   emailverweigertkz,               
   a.faxfirmavorwahl,               
   a.faxprivatvorwahl,                      
   rufnummerverweigertkz,      
   a.telefonfirmavorwahl,      
   a.telefonprivatvorwahl,
   anldat,    
   prozessidanl,
   benutzeridanl,
   letztaenddat,
   prozessidletztaend,  
   benutzeridletztaend,    
   nlanmeldeinwtxt,
   serviceinfobestellungkz,
   serviceinfoversandkz,
   serviceinfozahlungeingangkz,
   serviceinforetoureeingangkz,
   serviceinfonaliinfoversandkz,
   serviceinfohvspaketankuendkz,
   CASE WHEN TRIM(kk.emailprivat) IS NOT NULL THEN 1 ELSE 0 END AS email_vorhanden,   -- 1 ja, 0 nein
   CASE WHEN kk.handyprivat IS NOT NULL THEN 1 ELSE 0 END AS handy_vorhanden,   -- 1 ja, 0 nein
   CASE WHEN TRIM(kk.emailprivat) IS NOT NULL THEN STANDARD_HASH(TRIM(LOWER(kk.emailprivat)),'MD5') ELSE NULL END AS email_hash,
   CASE WHEN kk.telefonprivatvorwahl IS NOT NULL OR kk.telefonprivatrufnummer IS NOT NULL THEN 1 ELSE 0 END AS telefonprivat_vorhanden,  -- 1 ja, 0 nein
   CASE WHEN UPPER(kk.nname) LIKE '%DATENSCHUTZ%' THEN 1 ELSE 0 END AS datenschutz,
   SUBSTR(kk.nname,1,1) AS nachnameersterletter,
   serviceinforechnungversandkz,
   CASE WHEN TRIM(kk.emailprivat) IS NOT NULL THEN TRIM(LOWER(kk.emailprivat)) ELSE NULL END AS emailprivat
FROM
clst_ww_person_u a
INNER JOIN 
st_ww_person_kk kk    -- JOIN mit U reicht aus, weil unten ja nochmal die "N"s der KK dazugemerged werden
ON (a.id = kk.id)
LEFT JOIN
clst_ww_person_n b
ON (a.id = b.id);

COMMIT;


PROMPT ===========================================
PROMPT 8.5 DEL-Datensätze einspielen
PROMPT ===========================================



PROMPT ===========================================
PROMPT 8.5.1 DEL-Datensätze einspielen (Kernkundendaten)
PROMPT ===========================================

INSERT /*+APPEND */
INTO clst_ww_person_kk
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id
)
   SELECT 
   &gbvid,
   &termin,
   'D',
   id
FROM clst_ww_person_kk_d;


COMMIT;



PROMPT ===========================================
PROMPT 8.5.2 DEL-Datensätze einspielen (Verhaltenskundendaten)
PROMPT ===========================================

INSERT /*+APPEND */
INTO clst_ww_person
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id
)
   SELECT 
   &gbvid,
   &termin,
   'D',
   id
FROM clst_ww_person_d;


COMMIT;


PROMPT ===========================================
PROMPT 8.5.3 Verhashte Email + Email_vorhanden + Handy_vorhanden hinzugefuegt aus KK-Update-New-DS
PROMPT Grund: Es koennte Update-DS im KK geben und nicht bei den Verhaltensdaten
PROMPT        --> Abgleich mit KK notwendig und ggfalls INSERT der "fehlenden" in Verhaltenstabelle
PROMPT ===========================================


MERGE INTO kdwh.clst_ww_person a 
USING (
        SELECT url.*,
               CASE WHEN TRIM(kk.emailprivat) IS NOT NULL then 1 ELSE 0 END AS email_vorhanden, 
               CASE WHEN kk.handyprivat IS NOT NULL then 1 ELSE 0 END AS handy_vorhanden, 
               CASE WHEN TRIM(kk.emailprivat) IS NOT NULL THEN STANDARD_HASH(TRIM(LOWER(kk.emailprivat)),'MD5') ELSE NULL END AS email_hash,
               CASE WHEN kk.telefonprivatvorwahl IS NOT NULL OR kk.telefonprivatrufnummer IS NOT NULL THEN 1 ELSE 0 END AS telefonprivat_vorhanden,
               CASE WHEN UPPER(kk.nname) LIKE '%DATENSCHUTZ%' THEN 1 ELSE 0 END AS datenschutz,
               SUBSTR(kk.nname,1,1) AS nachnameersterletter,
               CASE WHEN TRIM(kk.emailprivat) IS NOT NULL THEN TRIM(LOWER(kk.emailprivat)) ELSE NULL END AS emailprivat
        FROM clst_ww_person_kk kk INNER JOIN  st_ww_person url ON (kk.id = url.id)
        WHERE dwh_stbflag in ('N','U')
            --AND (kk.emailprivat IS NOT NULL OR kk.handyprivat IS NOT NULL)   
      ) b
ON (a.id = b.id)
WHEN MATCHED THEN UPDATE 
SET
   a.email_vorhanden = b.email_vorhanden,
   a.handy_vorhanden = b.handy_vorhanden,
   a.email_hash = b.email_hash,
   a.telefonprivat_vorhanden = b.telefonprivat_vorhanden,
   a.datenschutz = b.datenschutz,
   a.nachnameersterletter = b.nachnameersterletter,
   a.emailprivat = b.emailprivat
WHEN NOT MATCHED THEN INSERT  
 ( 
   adresseid, 
   adrhdlid, 
   anldat, 
   benutzeridanl, 
   benutzeridletztaend, 
   dwh_cr_load_id, 
   dwh_processdate, 
   dwh_stbflag, 
   emailverweigertkz, 
   faxfirmavorwahl, 
   faxprivatvorwahl, 
   firmaid, 
   gebdat, 
   gebdatstatus, 
   id, 
   letztaenddat, 
   nlanmeldeinwtxt, 
   persanredeid, 
   prozessidanl, 
   prozessidletztaend, 
   rufnummerverweigertkz, 
   serviceinfobestellungkz, 
   serviceinfohvspaketankuendkz, 
   serviceinfonaliinfoversandkz, 
   serviceinforetoureeingangkz, 
   serviceinfoversandkz, 
   serviceinfozahlungeingangkz, 
   telefonfirmavorwahl, 
   telefonprivatvorwahl, 
   ti, 
   vname,
   email_vorhanden,
   handy_vorhanden,
   email_hash,
   telefonprivat_vorhanden,
   datenschutz,
   nachnameersterletter,
   serviceinforechnungversandkz,
   emailprivat
  )
VALUES
( 
   b.adresseid, 
   b.adrhdlid, 
   b.anldat, 
   b.benutzeridanl, 
   b.benutzeridletztaend, 
   &gbvid, 
   &termin, 
   'U', 
   b.emailverweigertkz, 
   b.faxfirmavorwahl, 
   b.faxprivatvorwahl, 
   b.firmaid, 
   b.gebdat, 
   b.gebdatstatus, 
   b.id, 
   b.letztaenddat, 
   b.nlanmeldeinwtxt, 
   b.persanredeid, 
   b.prozessidanl, 
   b.prozessidletztaend, 
   b.rufnummerverweigertkz, 
   b.serviceinfobestellungkz, 
   b.serviceinfohvspaketankuendkz, 
   b.serviceinfonaliinfoversandkz, 
   b.serviceinforetoureeingangkz, 
   b.serviceinfoversandkz, 
   b.serviceinfozahlungeingangkz, 
   b.telefonfirmavorwahl, 
   b.telefonprivatvorwahl, 
   b.ti, 
   b.vname,
   b.email_vorhanden,
   b.handy_vorhanden,
   b.email_hash,
   b.telefonprivat_vorhanden,
   b.datenschutz,
   b.nachnameersterletter,
   b.serviceinforechnungversandkz,
   b.emailprivat
  );

COMMIT;  



PROMPT ===========================================
PROMPT 8.6 ID,AdresseID in einen anonymen Key umwandeln und diesen in eine Zieltabelle im Zielschema schreiben (Verhaltenskundendaten)
PROMPT ===========================================

TRUNCATE TABLE udwh1.clst_ww_person;

EXEC IMPROG.PKG_CLEARING.P_CLEARING_ANONYMIZE (1, 'KDWH', 'CLST_WW_PERSON', 'ID,ADRESSEID,EMAILPRIVAT','UDWH1', 'CLST_WW_PERSON', 'ID_KEY,ADRESSEID_KEY,EMAILPRIVAT_KEY',FALSE); 

 

PROMPT ===========================================
PROMPT 8.7 Eindeutigkeit prüfen / neue Partition hinzufügen und laden 
PROMPT ===========================================

EXEC PKG_IM_LADUNG.P_LADUNG_STB ('st_ww_person_kk_b', &gbvid, 1);

EXEC PKG_IM_LADUNG.P_LADUNG_STB ('st_ww_person_b', &gbvid, 1,'UDWH1');



PROMPT =========================================================================
PROMPT
PROMPT 9. Stage-Ladung
PROMPT Tabelle: st_ww_mcerg_kk 
PROMPT          st_ww_mcerg
PROMPT
PROMPT =========================================================================
 
EXEC PKG_IM_LADUNG.P_LADUNG_STAGE ('kdwh_dh.mc_erg&dbludwh', 'st_ww_mcerg_kk', &gbvid);

EXEC PKG_IM_LADUNG.P_LADUNG_STAGE ('kdwh_dh.mc_erg&dbludwh', 'st_ww_mcerg', &gbvid);
 
 
PROMPT ===========================================
PROMPT 9.1 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'st_ww_mcerg_kk');

EXEC PKG_STATS.GATHERTABLE (USER, 'st_ww_mcerg');

 
 
PROMPT ===========================================
PROMPT 9.2 Cleanse-Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clst_ww_mcerg_kk;
TRUNCATE TABLE clst_ww_mcerg_kk_u;
TRUNCATE TABLE clst_ww_mcerg_kk_n;
TRUNCATE TABLE clst_ww_mcerg_kk_d;
 
TRUNCATE TABLE clst_ww_mcerg;
TRUNCATE TABLE clst_ww_mcerg_u;
TRUNCATE TABLE clst_ww_mcerg_n;
TRUNCATE TABLE clst_ww_mcerg_d;
TRUNCATE TABLE udwh1.clst_ww_mcerg;


 
PROMPT ===========================================
PROMPT 9.3 Deltaermittlung
PROMPT ===========================================



PROMPT ===========================================
PROMPT 9.3.1 Deltaermittlung Kernkundendaten
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL 
WHEN cnt1 > 0 AND cnt2 = 0 AND src IS NOT NULL THEN  --update und new
INTO clst_ww_mcerg_kk_u
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id,
   mcergrefid,
   warn_persid,
   vnameerf,
   nnameerf,
   strerf,
   plzerf,
   orterf,
   hsnrerf,
   hsnrzus1erf,
   personidstprio,
   plzzuserf
)
VALUES
(
   &gbvid,
   &termin,
   'U',
   id,
   mcergrefid,
   warn_persid,
   vnameerf,
   nnameerf,
   strerf,
   plzerf,
   orterf,
   hsnrerf,
   hsnrzus1erf,
   personidstprio,
   plzzuserf
)
WHEN cnt1 > 0 AND cnt2 = 0 AND src IS NULL THEN -- new
INTO clst_ww_mcerg_kk_n
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id
)
VALUES
(
   &gbvid,
   &termin,
   'N',
   id
)
WHEN cnt1 = 0 AND cnt2 > 0 AND src IS NULL THEN -- delete
INTO clst_ww_mcerg_kk_d
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id
)
VALUES
(
   &gbvid,
   &termin,
   'D',
   id
)
SELECT 
   id,
   mcergrefid,
   warn_persid,
   vnameerf,
   nnameerf,
   strerf,
   plzerf,
   orterf,
   hsnrerf,
   hsnrzus1erf,
   personidstprio,
   plzzuserf,
   COUNT(src1) AS cnt1,
   COUNT(src2) AS cnt2,
   src
FROM
   ( SELECT 
      TRIM(a.id) AS id,
      TRIM(a.mcergrefid) AS mcergrefid,
      TRIM(a.warn_persid) AS warn_persid,
      TRIM(a.vnameerf) AS vnameerf,
      TRIM(a.nnameerf) AS nnameerf,
      TRIM(a.strerf) AS strerf,
      TRIM(a.plzerf) AS plzerf,
      TRIM(a.orterf) AS orterf,
      a.hsnrerf AS hsnrerf,
      TRIM(a.hsnrzus1erf) AS hsnrzus1erf,
      TRIM(a.personidstprio) AS personidstprio,
      TRIM(a.plzzuserf) AS plzzuserf,
      1 src1,
      TO_NUMBER(NULL) src2,
      1 src
    FROM st_ww_mcerg_kk a
  UNION ALL
    SELECT 
      TRIM(b.id) AS id,
      TRIM(b.mcergrefid) AS mcergrefid,
      TRIM(b.warn_persid) AS warn_persid,
      TRIM(b.vnameerf) AS vnameerf,
      TRIM(b.nnameerf) AS nnameerf,
      TRIM(b.strerf) AS strerf,
      TRIM(b.plzerf) AS plzerf,
      TRIM(b.orterf) AS orterf,
      b.hsnrerf AS hsnrerf,
      TRIM(b.hsnrzus1erf) AS hsnrzus1erf,
      TRIM(b.personidstprio) AS personidstprio,
      TRIM(b.plzzuserf) AS plzzuserf,
      TO_NUMBER(NULL) src1,
      2 src2,
      1 src
    FROM st_ww_mcerg_kk_1 b
 ) c
GROUP BY GROUPING SETS ((
   id,
   mcergrefid,
   warn_persid,
   vnameerf,
   nnameerf,
   strerf,
   plzerf,
   orterf,
   hsnrerf,
   hsnrzus1erf,
   personidstprio,
   plzzuserf,
   src) , (id))
HAVING COUNT(src1) <> COUNT(src2);
 
COMMIT;
 
  

PROMPT ===========================================
PROMPT 9.3.2 Deltaermittlung Verhaltenskundendaten
PROMPT ===========================================

INSERT /*+ APPEND */ ALL 
WHEN cnt1 > 0 AND cnt2 = 0 AND src IS NOT NULL THEN  --update und new
INTO clst_ww_mcerg_u
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id,
   mcergrefid,
   warn_persid,
   dat,
   mckenn,
   mcsperr,
   mcerg,
   kundenfirmaid,
   plzerf,
   personidstprio,
   plzzuserf,
   mcprio,
   mctyp,
   mcaussteuerung,
   letztaenddat,
   userletztaend,
   dauer,
   anwkz
)
VALUES
(
   &gbvid,
   &termin,
   'U',
   id,
   mcergrefid,
   warn_persid,
   dat,
   mckenn,
   mcsperr,
   mcerg,
   kundenfirmaid,
   plzerf,
   personidstprio,
   plzzuserf,
   mcprio,
   mctyp,
   mcaussteuerung,
   letztaenddat,
   userletztaend,
   dauer,
   anwkz
)
WHEN cnt1 > 0 AND cnt2 = 0 AND src IS NULL THEN -- new
INTO clst_ww_mcerg_n
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id
)
VALUES
(
   &gbvid,
   &termin,
   'N',
   id
)
WHEN cnt1 = 0 AND cnt2 > 0 AND src IS NULL THEN -- delete
INTO clst_ww_mcerg_d
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id
)
VALUES
(
   &gbvid,
   &termin,
   'D',
   id
)
SELECT 
   id,
   mcergrefid,
   warn_persid,
   dat,
   mckenn,
   mcsperr,
   mcerg,
   kundenfirmaid,
   plzerf,
   personidstprio,
   plzzuserf,
   mcprio,
   mctyp,
   mcaussteuerung,
   letztaenddat,
   userletztaend,
   dauer,
   anwkz,
   COUNT(src1) AS cnt1,
   COUNT(src2) AS cnt2,
   src
FROM
   ( SELECT 
      TRIM(a.id) AS id,
      TRIM(a.mcergrefid) AS mcergrefid,
      TRIM(a.warn_persid) AS warn_persid,
      a.dat AS dat,
      a.mckenn AS mckenn,
      a.mcsperr AS mcsperr,
      a.mcerg AS mcerg,
      TRIM(a.kundenfirmaid) AS kundenfirmaid,
      TRIM(a.plzerf) AS plzerf,
      TRIM(a.personidstprio) AS personidstprio,
      TRIM(a.plzzuserf) AS plzzuserf,
      a.mcprio AS mcprio,
      a.mctyp AS mctyp,
      a.mcaussteuerung AS mcaussteuerung,
      a.letztaenddat AS letztaenddat,
      TRIM(a.userletztaend) AS userletztaend,
      a.dauer AS dauer,
      a.anwkz AS anwkz,
      1 src1,
      TO_NUMBER(NULL) src2,
      1 src
    FROM st_ww_mcerg a
  UNION ALL
    SELECT 
      TRIM(b.id) AS id,
      TRIM(b.mcergrefid) AS mcergrefid,
      TRIM(b.warn_persid) AS warn_persid,
      b.dat AS dat,
      b.mckenn AS mckenn,
      b.mcsperr AS mcsperr,
      b.mcerg AS mcerg,
      TRIM(b.kundenfirmaid) AS kundenfirmaid,
      TRIM(b.plzerf) AS plzerf,
      TRIM(b.personidstprio) AS personidstprio,
      TRIM(b.plzzuserf) AS plzzuserf,
      b.mcprio AS mcprio,
      b.mctyp AS mctyp,
      b.mcaussteuerung AS mcaussteuerung,
      b.letztaenddat AS letztaenddat,
      TRIM(b.userletztaend) AS userletztaend,
      b.dauer AS dauer,
      b.anwkz AS anwkz,
      TO_NUMBER(NULL) src1,
      2 src2,
      1 src
    FROM st_ww_mcerg_1 b
 ) c
GROUP BY GROUPING SETS ((
   id,
   mcergrefid,
   warn_persid,
   dat,
   mckenn,
   mcsperr,
   mcerg,
   kundenfirmaid,
   plzerf,
   personidstprio,
   plzzuserf,
   mcprio,
   mctyp,
   mcaussteuerung,
   letztaenddat,
   userletztaend,
   dauer,
   anwkz,
   src) , (id))
HAVING COUNT(src1) <> COUNT(src2);
 
COMMIT;
 


PROMPT ===========================================
PROMPT 9.4 NEW und UPDATE-Datensätze einspielen
PROMPT ===========================================
 


PROMPT ===========================================
PROMPT 9.4.1 NEW und UPDATE-Datensätze einspielen (Kernkundendaten)
PROMPT ===========================================

INSERT /*+ APPEND */
INTO clst_ww_mcerg_kk
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id,
   mcergrefid,
   warn_persid,
   vnameerf,
   nnameerf,
   strerf,
   plzerf,
   orterf,
   hsnrerf,
   hsnrzus1erf,
   personidstprio,
   plzzuserf
)
SELECT
   a.dwh_cr_load_id,
   a.dwh_processdate,
   CASE WHEN b.id IS NOT NULL THEN 'N' ELSE a.dwh_stbflag END AS dwh_stbflag,
   a.id,
   mcergrefid,
   warn_persid,
   vnameerf,
   nnameerf,
   strerf,
   plzerf,
   orterf,
   hsnrerf,
   hsnrzus1erf,
   personidstprio,
   plzzuserf
FROM
clst_ww_mcerg_kk_u a
LEFT JOIN
clst_ww_mcerg_kk_n b
ON (a.id = b.id);
 
COMMIT;
 


PROMPT ===========================================
PROMPT 9.4.2 NEW und UPDATE-Datensätze einspielen (Verhaltenskundendaten)
PROMPT ===========================================
 
INSERT /*+ APPEND */
INTO clst_ww_mcerg
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id,
   mcergrefid,
   warn_persid,
   dat,
   mckenn,
   mcsperr,
   mcerg,
   kundenfirmaid,
   plzerf,
   personidstprio,
   plzzuserf,
   mcprio,
   mctyp,
   mcaussteuerung,
   letztaenddat,
   userletztaend,
   dauer,
   anwkz
)
SELECT
   a.dwh_cr_load_id,
   a.dwh_processdate,
   CASE WHEN b.id IS NOT NULL THEN 'N' ELSE a.dwh_stbflag END AS dwh_stbflag,
   a.id,
   mcergrefid,
   warn_persid,
   dat,
   mckenn,
   mcsperr,
   mcerg,
   kundenfirmaid,
   plzerf,
   personidstprio,
   plzzuserf,
   mcprio,
   mctyp,
   mcaussteuerung,
   letztaenddat,
   userletztaend,
   dauer,
   anwkz
FROM
clst_ww_mcerg_u a
LEFT JOIN
clst_ww_mcerg_n b
ON (a.id = b.id);
 
COMMIT;



PROMPT ===========================================
PROMPT 9.5 DEL-Datensätze einspielen
PROMPT ===========================================



PROMPT ===========================================
PROMPT 9.5.1 DEL-Datensätze einspielen (Kernkundendaten)
PROMPT =========================================== 

INSERT /*+APPEND */
INTO clst_ww_mcerg_kk
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id
)
   SELECT 
   &gbvid,
   &termin,
   'D',
   id
FROM clst_ww_mcerg_kk_d;
 
COMMIT;



PROMPT =================================================
PROMPT 9.5.2 DEL-Datensätze einspielen (Verhaltenskundendaten)
PROMPT =================================================

INSERT /*+APPEND */
INTO clst_ww_mcerg
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id
)
   SELECT 
   &gbvid,
   &termin,
   'D',
   id
FROM clst_ww_mcerg_d;
 
COMMIT;



PROMPT ===========================================
PROMPT 9.6 ID,MCERGREFID,WARN_PERSID,PERSONIDSTPRIO in einen anonymen Key umwandeln und diesen in eine Zieltabelle im Zielschema schreiben (Verhaltenskundendaten)
PROMPT ===========================================

TRUNCATE TABLE udwh1.clst_ww_mcerg;

EXEC IMPROG.PKG_CLEARING.P_CLEARING_ANONYMIZE (1, 'KDWH', -
  'CLST_WW_MCERG', -
  'ID,MCERGREFID,WARN_PERSID,PERSONIDSTPRIO', -
  'UDWH1', -
  'CLST_WW_MCERG', -
  'ID_KEY,MCERGREFID_KEY,WARN_PERSID_KEY,PERSONIDSTPRIO_KEY', -
  FALSE);
  

PROMPT ===========================================
PROMPT 9.7 Eindeutigkeit prüfen / neue Partition hinzufügen und laden
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_LADUNG_STB ('st_ww_mcerg_kk_b', &gbvid, 1);  

EXEC PKG_IM_LADUNG.P_LADUNG_STB ('st_ww_mcerg_b', &gbvid, 1,'UDWH1');  



PROMPT =========================================================================
PROMPT
PROMPT 10. Stage-Ladung
PROMPT Tabelle: st_ww_interessent_kk
PROMPT          st_ww_interessent
PROMPT
PROMPT =========================================================================
 
EXEC PKG_IM_LADUNG.P_LADUNG_STAGE ('kdwh_dh.interessent&dbludwh', 'st_ww_interessent_kk', &gbvid);

EXEC PKG_IM_LADUNG.P_LADUNG_STAGE ('kdwh_dh.interessent&dbludwh', 'st_ww_interessent', &gbvid);
 

 
PROMPT ===========================================
PROMPT 10.1 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'st_ww_interessent_kk');

EXEC PKG_STATS.GATHERTABLE (USER, 'st_ww_interessent');
  


PROMPT ===========================================
PROMPT 10.2 Cleanse-Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clst_ww_interessent_kk;
TRUNCATE TABLE clst_ww_interessent_kk_u;
TRUNCATE TABLE clst_ww_interessent_kk_n;
TRUNCATE TABLE clst_ww_interessent_kk_d;

TRUNCATE TABLE clst_ww_interessent;
TRUNCATE TABLE clst_ww_interessent_u;
TRUNCATE TABLE clst_ww_interessent_n;
TRUNCATE TABLE clst_ww_interessent_d;
TRUNCATE TABLE udwh1.clst_ww_interessent;



PROMPT ===========================================
PROMPT 10.3 Deltaermittlung
PROMPT ===========================================



PROMPT ===========================================
PROMPT 10.3.1 Deltaermittlung Kernkundendaten
PROMPT ===========================================

INSERT /*+ APPEND */ ALL 
WHEN cnt1 > 0 AND cnt2 = 0 AND src IS NOT NULL THEN  --update und new
INTO clst_ww_interessent_kk_u
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id,
   kundenfirmaid,
   personid,
   interessentnr,
   anlaufkdnr,
   verwinteressentnr,
   personstammpruefid
)
VALUES
(
   &gbvid,
   &termin,
   'U',
   id,
   kundenfirmaid,
   personid,
   interessentnr,
   anlaufkdnr,
   verwinteressentnr,
   personstammpruefid
)
WHEN cnt1 > 0 AND cnt2 = 0 AND src IS NULL THEN -- new
INTO clst_ww_interessent_kk_n
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id
)
VALUES
(
   &gbvid,
   &termin,
   'N',
   id
)
WHEN cnt1 = 0 AND cnt2 > 0 AND src IS NULL THEN -- delete
INTO clst_ww_interessent_kk_d
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id
)
VALUES
(
   &gbvid,
   &termin,
   'D',
   id
)
SELECT 
   id,
   kundenfirmaid,
   personid,
   interessentnr,
   anlaufkdnr,
   verwinteressentnr,
   personstammpruefid,
   COUNT(src1) AS cnt1,
   COUNT(src2) AS cnt2,
   src
FROM
   ( SELECT 
      TRIM(a.id) AS id,
      TRIM(a.kundenfirmaid) AS kundenfirmaid,
      TRIM(a.personid) AS personid,
      a.interessentnr AS interessentnr,
      a.anlaufkdnr AS anlaufkdnr,
      a.verwinteressentnr AS verwinteressentnr,
      TRIM(a.personstammpruefid) AS personstammpruefid,
      1 src1,
      TO_NUMBER(NULL) src2,
      1 src
    FROM st_ww_interessent_kk a
  UNION ALL
    SELECT 
      TRIM(b.id) AS id,
      TRIM(b.kundenfirmaid) AS kundenfirmaid,
      TRIM(b.personid) AS personid,
      b.interessentnr AS interessentnr,
      b.anlaufkdnr AS anlaufkdnr,
      b.verwinteressentnr AS verwinteressentnr,
      TRIM(b.personstammpruefid) AS personstammpruefid,
      TO_NUMBER(NULL) src1,
      2 src2,
      1 src
    FROM st_ww_interessent_kk_1 b
 ) c
GROUP BY GROUPING SETS ((
   id,
   kundenfirmaid,
   personid,
   interessentnr,
   anlaufkdnr,
   verwinteressentnr,
   personstammpruefid,
   src) , (id))
HAVING COUNT(src1) <> COUNT(src2);
 
COMMIT;
 

 
PROMPT ===========================================
PROMPT 10.3.2 Deltaermittlung Verhaltenskundendaten
PROMPT ===========================================

INSERT /*+ APPEND */ ALL 
WHEN cnt1 > 0 AND cnt2 = 0 AND src IS NOT NULL THEN  --update und new
INTO clst_ww_interessent_u
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id,
   kundenfirmaid,
   personid,
   bestwegid,
   interessentnr,
   anlaufkdnr,
   katerstverskz,
   anldat,
   wkz,
   iwl,
   katversdat,
   zaehlernachfasswb,
   datnachfasswb,
   verwinteressentnr,
   letztaenddat,
   newsletterid,
   tddsgid,
   newslettertypid,
   nlabonnentstatusid,
   adressherkunftid,
   letztaktdathost,
   letzttransferdat,
   transferkz,
   kundeanlaufid,
   dbfakturakz
)
VALUES
(
   &gbvid,
   &termin,
   'U',
   id,
   kundenfirmaid,
   personid,
   bestwegid,
   interessentnr,
   anlaufkdnr,
   katerstverskz,
   anldat,
   wkz,
   iwl,
   katversdat,
   zaehlernachfasswb,
   datnachfasswb,
   verwinteressentnr,
   letztaenddat,
   newsletterid,
   tddsgid,
   newslettertypid,
   nlabonnentstatusid,
   adressherkunftid,
   letztaktdathost,
   letzttransferdat,
   transferkz,
   kundeanlaufid,
   dbfakturakz
)
WHEN cnt1 > 0 AND cnt2 = 0 AND src IS NULL THEN -- new
INTO clst_ww_interessent_n
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id
)
VALUES
(
   &gbvid,
   &termin,
   'N',
   id
)
WHEN cnt1 = 0 AND cnt2 > 0 AND src IS NULL THEN -- delete
INTO clst_ww_interessent_d
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id
)
VALUES
(
   &gbvid,
   &termin,
   'D',
   id
)
SELECT 
   id,
   kundenfirmaid,
   personid,
   bestwegid,
   interessentnr,
   anlaufkdnr,
   katerstverskz,
   anldat,
   wkz,
   iwl,
   katversdat,
   zaehlernachfasswb,
   datnachfasswb,
   verwinteressentnr,
   letztaenddat,
   newsletterid,
   tddsgid,
   newslettertypid,
   nlabonnentstatusid,
   adressherkunftid,
   letztaktdathost,
   letzttransferdat,
   transferkz,
   kundeanlaufid,
   dbfakturakz,
   COUNT(src1) AS cnt1,
   COUNT(src2) AS cnt2,
   src
FROM
   ( SELECT 
      TRIM(a.id) AS id,
      TRIM(a.kundenfirmaid) AS kundenfirmaid,
      TRIM(a.personid) AS personid,
      TRIM(a.bestwegid) AS bestwegid,
      a.interessentnr AS interessentnr,
      a.anlaufkdnr AS anlaufkdnr,
      TRIM(a.katerstverskz) AS katerstverskz,
      a.anldat AS anldat,
      a.wkz AS wkz,
      a.iwl AS iwl,
      a.katversdat AS katversdat,
      a.zaehlernachfasswb AS zaehlernachfasswb,
      a.datnachfasswb AS datnachfasswb,
      a.verwinteressentnr AS verwinteressentnr,
      a.letztaenddat AS letztaenddat,
      TRIM(a.newsletterid) AS newsletterid,
      TRIM(a.tddsgid) AS tddsgid,
      TRIM(a.newslettertypid) AS newslettertypid,
      TRIM(a.nlabonnentstatusid) AS nlabonnentstatusid,
      TRIM(a.adressherkunftid) AS adressherkunftid,
      a.letztaktdathost AS letztaktdathost,
      a.letzttransferdat AS letzttransferdat,
      a.transferkz AS transferkz,
      TRIM(a.kundeanlaufid) AS kundeanlaufid,
      a.dbfakturakz AS dbfakturakz,
      1 src1,
      TO_NUMBER(NULL) src2,
      1 src
    FROM st_ww_interessent a
  UNION ALL
    SELECT 
      TRIM(b.id) AS id,
      TRIM(b.kundenfirmaid) AS kundenfirmaid,
      TRIM(b.personid) AS personid,
      TRIM(b.bestwegid) AS bestwegid,
      b.interessentnr AS interessentnr,
      b.anlaufkdnr AS anlaufkdnr,
      TRIM(b.katerstverskz) AS katerstverskz,
      b.anldat AS anldat,
      b.wkz AS wkz,
      b.iwl AS iwl,
      b.katversdat AS katversdat,
      b.zaehlernachfasswb AS zaehlernachfasswb,
      b.datnachfasswb AS datnachfasswb,
      b.verwinteressentnr AS verwinteressentnr,
      b.letztaenddat AS letztaenddat,
      TRIM(b.newsletterid) AS newsletterid,
      TRIM(b.tddsgid) AS tddsgid,
      TRIM(b.newslettertypid) AS newslettertypid,
      TRIM(b.nlabonnentstatusid) AS nlabonnentstatusid,
      TRIM(b.adressherkunftid) AS adressherkunftid,
      b.letztaktdathost AS letztaktdathost,
      b.letzttransferdat AS letzttransferdat,
      b.transferkz AS transferkz,
      TRIM(b.kundeanlaufid) AS kundeanlaufid,
      b.dbfakturakz AS dbfakturakz,
      TO_NUMBER(NULL) src1,
      2 src2,
      1 src
    FROM st_ww_interessent_1 b
 ) c
GROUP BY GROUPING SETS ((
   id,
   kundenfirmaid,
   personid,
   bestwegid,
   interessentnr,
   anlaufkdnr,
   katerstverskz,
   anldat,
   wkz,
   iwl,
   katversdat,
   zaehlernachfasswb,
   datnachfasswb,
   verwinteressentnr,
   letztaenddat,
   newsletterid,
   tddsgid,
   newslettertypid,
   nlabonnentstatusid,
   adressherkunftid,
   letztaktdathost,
   letzttransferdat,
   transferkz,
   kundeanlaufid,
   dbfakturakz,
   src) , (id))
HAVING COUNT(src1) <> COUNT(src2);
 
COMMIT;
 

 
PROMPT ===========================================
PROMPT 10.4 NEW und UPDATE-Datensätze einspielen
PROMPT ===========================================



PROMPT ===========================================
PROMPT 10.4.1 NEW und UPDATE-Datensätze einspielen (Kernkundendaten)
PROMPT ===========================================

INSERT /*+ APPEND */
INTO clst_ww_interessent_kk
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id,
   kundenfirmaid,
   personid,
   interessentnr,
   verwinteressentnr,
   personstammpruefid
)
SELECT
   a.dwh_cr_load_id,
   a.dwh_processdate,
   CASE WHEN b.id IS NOT NULL THEN 'N' ELSE a.dwh_stbflag END AS dwh_stbflag,
   a.id,
   kundenfirmaid,
   personid,
   interessentnr,
   verwinteressentnr,
   personstammpruefid
FROM
clst_ww_interessent_kk_u a
LEFT JOIN
clst_ww_interessent_kk_n b
ON (a.id = b.id);
 
COMMIT;
 


PROMPT ===========================================
PROMPT 10.4.2 NEW und UPDATE-Datensätze einspielen (Verhaltenskundendaten)
PROMPT ===========================================

INSERT /*+ APPEND */
INTO clst_ww_interessent
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id,
   kontonrletzteziffern,
   firma,
   kundenfirmaid,
   personid,
   bestwegid,
   interessentnr,
   inr_id,
   anlaufkdnr,
   anlaufkonto_id,
   katerstverskz,
   anldat,
   wkz,
   iwl,
   katversdat,
   zaehlernachfasswb,
   datnachfasswb,
   verwinteressentnr,
   verwkonto_id,
   letztaenddat,
   newsletterid,
   tddsgid,
   newslettertypid,
   nlabonnentstatusid,
   adressherkunftid,
   letztaktdathost,
   letzttransferdat,
   transferkz,
   kundeanlaufid,
   dbfakturakz
)
SELECT
   a.dwh_cr_load_id,
   a.dwh_processdate,
   CASE WHEN b.id IS NOT NULL THEN 'N' ELSE a.dwh_stbflag END AS dwh_stbflag,
   a.id,
   substr(kk.interessentnr, -3) AS kontonrletzteziffern,
   NULL,
   a.kundenfirmaid,
   a.personid,
   bestwegid,
   a.interessentnr,
   NULL,
   a.anlaufkdnr,
   NULL,
   katerstverskz,
   anldat,
   wkz,
   iwl,
   katversdat,
   zaehlernachfasswb,
   datnachfasswb,
   a.verwinteressentnr,
   NULL,
   letztaenddat,
   newsletterid,
   tddsgid,
   newslettertypid,
   nlabonnentstatusid,
   adressherkunftid,
   letztaktdathost,
   letzttransferdat,
   transferkz,
   kundeanlaufid,
   dbfakturakz
FROM
clst_ww_interessent_u a
INNER JOIN st_ww_interessent_kk kk
ON kk.id = a.id
LEFT JOIN
clst_ww_interessent_n b
ON (a.id = b.id);
 
COMMIT;



PROMPT ===========================================
PROMPT 10.5 DEL-Datensätze einspielen
PROMPT ===========================================



PROMPT ===========================================
PROMPT 10.5.1 DEL-Datensätze einspielen (Kernkundendaten)
PROMPT =========================================== 

INSERT /*+APPEND */
INTO clst_ww_interessent_kk
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id
)
   SELECT 
   &gbvid,
   &termin,
   'D',
   id
FROM clst_ww_interessent_kk_d;
 
COMMIT;



PROMPT =================================================
PROMPT 10.5.2 DEL-Datensätze einspielen (Verhaltenskundendaten)
PROMPT =================================================

INSERT /*+APPEND */
INTO clst_ww_interessent
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id
)
   SELECT 
   &gbvid,
   &termin,
   'D',
   id
FROM clst_ww_interessent_d;
 
COMMIT;



PROMPT ===========================================
PROMPT 10.6 IDs für Kundenverhaltensdaten generieren und setzen
PROMPT ===========================================



PROMPT ===========================================
PROMPT 10.6.1 InteressentenIDs (Inr_ID) generieren und setzen
PROMPT ===========================================

EXEC PKG_IM_KONTO_ID.P_DWH_KONTO_ID_UP ('clst_ww_interessent', 'interessentnr','kundenfirmaid', 'inr_id', &gbvid, 2, 1);
 
PROMPT Test auf leere Inr_IDs

DECLARE
    v_anz_inr_id PLS_INTEGER;
    v_anz_inr_falsch PLS_INTEGER;    
BEGIN

    SELECT COUNT(*) INTO v_anz_inr_id
    FROM clst_ww_interessent
    WHERE inr_id IS NULL AND interessentnr IS NOT NULL;
    
    -- Ausschluss Sheego, weil da koennen 9er Nummer als Kunde kommen...
    SELECT COUNT(*) INTO v_anz_inr_falsch
    FROM clst_ww_interessent
    WHERE firma != 44 AND (LENGTH(interessentnr) != 9
    OR SUBSTR(interessentnr,1,3) != '300');  
    
    IF v_anz_inr_id > 0 THEN
        RAISE_APPLICATION_ERROR (-20052, 'Leere Inr-IDs!'); 
    END IF;
    
    IF v_anz_inr_falsch > 0 THEN
          UTL_MAIL_VERSAND2 ('andrea.gagulic@witt-gruppe.eu', 'WARNUNG: st_ww_kunde_dp: Falsche Interessennr!!');
          UTL_MAIL_VERSAND2 ('stefan.ernstberger@witt-gruppe.eu', 'WARNUNG: st_ww_kunde_dp: Falsche Interessennr!!');   
          UTL_MAIL_VERSAND2 ('benjamin.lingl@witt-gruppe.eu', 'WARNUNG: st_ww_kunde_dp: Falsche Interessennr!!');    
          UTL_MAIL_VERSAND2 ('MariaLaura.Silveanu@witt-gruppe.eu', 'WARNUNG: st_ww_kunde_dp: Falsche Interessennr!!');    
    END IF;    

END;
/



PROMPT ===========================================
PROMPT 10.6.2 Anlaufkonto_IDs generieren und setzen
PROMPT ===========================================

-- Hinter der Spalte verwinteressentnr verbergen sich Kontonummern!
EXEC PKG_IM_KONTO_ID.P_DWH_KONTO_ID_UP ('clst_ww_interessent', 'anlaufkdnr,verwinteressentnr','kundenfirmaid,kundenfirmaid', 'anlaufkonto_id,verwkonto_id', &gbvid, 1, 1);

PROMPT Test auf leere Konto_IDs

DECLARE
    v_anz_kid PLS_INTEGER;
    v_anz_int_id PLS_INTEGER; 
BEGIN

    SELECT COUNT(*) INTO v_anz_kid
    FROM clst_ww_interessent
    WHERE anlaufkonto_id IS NULL AND anlaufkdnr IS NOT NULL;

    IF v_anz_kid > 0 THEN
        RAISE_APPLICATION_ERROR (-20079, 'Leere Konto-IDs!'); 
    END IF;   

    SELECT COUNT(*) INTO v_anz_int_id
    FROM clst_ww_interessent
    WHERE verwkonto_id IS NULL AND verwinteressentnr IS NOT NULL;

    IF v_anz_kid > 0 THEN
        RAISE_APPLICATION_ERROR (-20079, 'Leere Konto-IDs!'); 
    END IF;   

END;
/



PROMPT ===========================================
PROMPT 10.7 ID, Inr_ID, PersonID, Anlaufkonto_ID, Verwkonto_ID, KUNDEANLAUFID in 
PROMPT einen anonymen Key umwandeln und diesen in eine Zieltabelle im Zielschema schreiben (Verhaltenskundendaten)
PROMPT ===========================================

TRUNCATE TABLE udwh1.clst_ww_interessent;

EXEC IMPROG.PKG_CLEARING.P_CLEARING_ANONYMIZE (1, 'KDWH', - 
  'CLST_WW_INTERESSENT', - 
  'ID,INR_ID,PERSONID,ANLAUFKONTO_ID,VERWKONTO_ID,KUNDEANLAUFID', - 
  'UDWH1', - 
  'CLST_WW_INTERESSENT', - 
  'ID_KEY,INR_ID_KEY,PERSONID_KEY, ANLAUFKONTO_ID_KEY,VERWKONTO_ID_KEY,KUNDEANLAUFID_KEY',FALSE);


 
PROMPT ===========================================
PROMPT 10.8 Eindeutigkeit prüfen / neue Partition hinzufügen und laden 
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_LADUNG_STB ('st_ww_interessent_kk_b', &gbvid, 1);

EXEC PKG_IM_LADUNG.P_LADUNG_STB ('st_ww_interessent_b', &gbvid, 1, 'UDWH1');



PROMPT =========================================================================
PROMPT
PROMPT 11. Stage-Ladung 
PROMPT Tabelle: st_ww_kundeanlauf
PROMPT
PROMPT =========================================================================
 
EXEC PKG_IM_LADUNG.P_LADUNG_STAGE ('kdwh_dh.kundeanlauf&dbludwh', 'st_ww_kundeanlauf', &gbvid);


 
PROMPT ===========================================
PROMPT 11.1 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'st_ww_kundeanlauf');
 
 

PROMPT ===========================================
PROMPT 11.2 Cleanse-Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clst_ww_kundeanlauf;
TRUNCATE TABLE clst_ww_kundeanlauf_u;
TRUNCATE TABLE clst_ww_kundeanlauf_n;
TRUNCATE TABLE clst_ww_kundeanlauf_d;
TRUNCATE TABLE udwh1.clst_ww_kundeanlauf;
 

 
PROMPT ===========================================
PROMPT 11.3 Deltaermittlung
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL 
WHEN cnt1 > 0 AND cnt2 = 0 AND src IS NOT NULL THEN  --update und new
INTO clst_ww_kundeanlauf_u
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id,
   mcanlakt,
   ablehninfo,
   bestwegidanlauf,
   anwkz,
   benutzeridletztaend,
   letztaenddat,
   anldat,
   mcaussteuerung,
   cbbausteinnr,
   mcintkenn,
   mcintsperr,
   mcinterg,
   mc_ergid,
   mcintakt,
   mcextregelwerk,
   mcextanfragedat,
   mcextablehngrund,
   mcextprio,
   mcextakt,
   wslog_validierungid,
   kundeid,
   interessentid,
   mcseakt,
   wslog_validierungidse,
   bemerkung
)
VALUES
(
   &gbvid,
   &termin,
   'U',
   id,
   mcanlakt,
   ablehninfo,
   bestwegidanlauf,
   anwkz,
   benutzeridletztaend,
   letztaenddat,
   anldat,
   mcaussteuerung,
   cbbausteinnr,
   mcintkenn,
   mcintsperr,
   mcinterg,
   mc_ergid,
   mcintakt,
   mcextregelwerk,
   mcextanfragedat,
   mcextablehngrund,
   mcextprio,
   mcextakt,
   wslog_validierungid,
   kundeid,
   interessentid,
   mcseakt,
   wslog_validierungidse,
   bemerkung
)
WHEN cnt1 > 0 AND cnt2 = 0 AND src IS NULL THEN -- new
INTO clst_ww_kundeanlauf_n
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id
)
VALUES
(
   &gbvid,
   &termin,
   'N',
   id
)
WHEN cnt1 = 0 AND cnt2 > 0 AND src IS NULL THEN -- delete
INTO clst_ww_kundeanlauf_d
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id
)
VALUES
(
   &gbvid,
   &termin,
   'D',
   id
)
SELECT 
   id,
   mcanlakt,
   ablehninfo,
   bestwegidanlauf,
   anwkz,
   benutzeridletztaend,
   letztaenddat,
   anldat,
   mcaussteuerung,
   cbbausteinnr,
   mcintkenn,
   mcintsperr,
   mcinterg,
   mc_ergid,
   mcintakt,
   mcextregelwerk,
   mcextanfragedat,
   mcextablehngrund,
   mcextprio,
   mcextakt,
   wslog_validierungid,
   kundeid,
   interessentid,
   mcseakt,
   wslog_validierungidse,
   bemerkung,
   COUNT(src1) AS cnt1,
   COUNT(src2) AS cnt2,
   src
FROM
   ( SELECT 
      TRIM(a.id) AS id,
      a.mcanlakt AS mcanlakt,
      a.ablehninfo AS ablehninfo,
      TRIM(a.bestwegidanlauf) AS bestwegidanlauf,
      a.anwkz AS anwkz,
      TRIM(a.benutzeridletztaend) AS benutzeridletztaend,
      a.letztaenddat AS letztaenddat,
      a.anldat AS anldat,
      a.mcaussteuerung AS mcaussteuerung,
      a.cbbausteinnr AS cbbausteinnr,
      a.mcintkenn AS mcintkenn,
      a.mcintsperr AS mcintsperr,
      a.mcinterg AS mcinterg,
      TRIM(a.mc_ergid) AS mc_ergid,
      a.mcintakt AS mcintakt,
      TRIM(a.mcextregelwerk) AS mcextregelwerk,
      a.mcextanfragedat AS mcextanfragedat,
      TRIM(a.mcextablehngrund) AS mcextablehngrund,
      a.mcextprio AS mcextprio,
      a.mcextakt AS mcextakt,
      TRIM(a.wslog_validierungid) AS wslog_validierungid,
      TRIM(a.kundeid) AS kundeid,
      TRIM(a.interessentid) AS interessentid,
      a.mcseakt AS mcseakt,
      TRIM(a.wslog_validierungidse) AS wslog_validierungidse,
      TRIM(a.bemerkung) AS bemerkung,
      1 src1,
      TO_NUMBER(NULL) src2,
      1 src
    FROM st_ww_kundeanlauf a
  UNION ALL
    SELECT 
      TRIM(b.id) AS id,
      b.mcanlakt AS mcanlakt,
      b.ablehninfo AS ablehninfo,
      TRIM(b.bestwegidanlauf) AS bestwegidanlauf,
      b.anwkz AS anwkz,
      TRIM(b.benutzeridletztaend) AS benutzeridletztaend,
      b.letztaenddat AS letztaenddat,
      b.anldat AS anldat,
      b.mcaussteuerung AS mcaussteuerung,
      b.cbbausteinnr AS cbbausteinnr,
      b.mcintkenn AS mcintkenn,
      b.mcintsperr AS mcintsperr,
      b.mcinterg AS mcinterg,
      TRIM(b.mc_ergid) AS mc_ergid,
      b.mcintakt AS mcintakt,
      TRIM(b.mcextregelwerk) AS mcextregelwerk,
      b.mcextanfragedat AS mcextanfragedat,
      TRIM(b.mcextablehngrund) AS mcextablehngrund,
      b.mcextprio AS mcextprio,
      b.mcextakt AS mcextakt,
      TRIM(b.wslog_validierungid) AS wslog_validierungid,
      TRIM(b.kundeid) AS kundeid,
      TRIM(b.interessentid) AS interessentid,
      b.mcseakt AS mcseakt,
      TRIM(b.wslog_validierungidse) AS wslog_validierungidse,
      TRIM(b.bemerkung) AS bemerkung,
      TO_NUMBER(NULL) src1,
      2 src2,
      1 src
    FROM st_ww_kundeanlauf_1 b
 ) c
GROUP BY GROUPING SETS ((
   id,
   mcanlakt,
   ablehninfo,
   bestwegidanlauf,
   anwkz,
   benutzeridletztaend,
   letztaenddat,
   anldat,
   mcaussteuerung,
   cbbausteinnr,
   mcintkenn,
   mcintsperr,
   mcinterg,
   mc_ergid,
   mcintakt,
   mcextregelwerk,
   mcextanfragedat,
   mcextablehngrund,
   mcextprio,
   mcextakt,
   wslog_validierungid,
   kundeid,
   interessentid,
   mcseakt,
   wslog_validierungidse,
   bemerkung,
   src) , (id))
HAVING COUNT(src1) <> COUNT(src2);
 
COMMIT;
 

 
PROMPT ===========================================
PROMPT 11.4 NEW und UPDATE-Datensätze einspielen
PROMPT ===========================================
 
INSERT /*+ APPEND */
INTO clst_ww_kundeanlauf
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id,
   mcanlakt,
   ablehninfo,
   bestwegidanlauf,
   anwkz,
   benutzeridletztaend,
   letztaenddat,
   anldat,
   mcaussteuerung,
   cbbausteinnr,
   mcintkenn,
   mcintsperr,
   mcinterg,
   mc_ergid,
   mcintakt,
   mcextregelwerk,
   mcextanfragedat,
   mcextablehngrund,
   mcextprio,
   mcextakt,
   wslog_validierungid,
   kundeid,
   interessentid,
   mcseakt,
   wslog_validierungidse,
   bemerkung
)
SELECT
   a.dwh_cr_load_id,
   a.dwh_processdate,
   CASE WHEN b.id IS NOT NULL THEN 'N' ELSE a.dwh_stbflag END AS dwh_stbflag,
   a.id,
   mcanlakt,
   ablehninfo,
   bestwegidanlauf,
   anwkz,
   benutzeridletztaend,
   letztaenddat,
   anldat,
   mcaussteuerung,
   cbbausteinnr,
   mcintkenn,
   mcintsperr,
   mcinterg,
   mc_ergid,
   mcintakt,
   mcextregelwerk,
   mcextanfragedat,
   mcextablehngrund,
   mcextprio,
   mcextakt,
   wslog_validierungid,
   kundeid,
   interessentid,
   mcseakt,
   wslog_validierungidse,
   bemerkung
FROM
clst_ww_kundeanlauf_u a
LEFT JOIN
clst_ww_kundeanlauf_n b
ON (a.id = b.id);
 
COMMIT;
 

 
PROMPT ===========================================
PROMPT 11.5 DEL-Datensätze einspielen
PROMPT ===========================================
 
INSERT /*+APPEND */
INTO clst_ww_kundeanlauf
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id
)
   SELECT 
   &gbvid,
   &termin,
   'D',
   id
FROM clst_ww_kundeanlauf_d;
 
COMMIT;
 

 
PROMPT ===========================================
PROMPT 11.6 kdnr und kundenfirmaid aus st_ww_kunde holen
PROMPT ===========================================

MERGE INTO clst_ww_kundeanlauf clst
USING st_ww_kunde kd
ON (clst.kundeid = kd.id)
WHEN MATCHED THEN UPDATE
SET clst.kdnr = kd.kdnr,
    clst.kundenfirmaid = kd.kundenfirmaid;
    
COMMIT;




PROMPT ===========================================
PROMPT 11.7 Konto-ID generieren und setzen
PROMPT ===========================================
        
EXEC PKG_IM_KONTO_ID.P_DWH_KONTO_ID_UP ('clst_ww_kundeanlauf', 'kdnr','kundenfirmaid', 'konto_id', &gbvid, 1, 1);

DECLARE
    v_anz_kid PLS_INTEGER;
BEGIN

    SELECT COUNT(*) INTO v_anz_kid
    FROM clst_ww_kundeanlauf
    WHERE konto_id IS NULL AND kdnr IS NOT NULL AND kundenfirmaid IS NOT NULL;

    IF v_anz_kid > 0 THEN
        RAISE_APPLICATION_ERROR (-20079, 'Leere Konto-IDs!'); 
    END IF; 

END;
/

PROMPT ===========================================
PROMPT 11.8 ID, KundeID, InteressentID, MC_ergID in einen anonymen Key umwandeln und diesen in eine Zieltabelle im Zielschema schreiben
PROMPT ===========================================

TRUNCATE TABLE udwh1.clst_ww_kundeanlauf;

EXEC IMPROG.PKG_CLEARING.P_CLEARING_ANONYMIZE (1, 'KDWH', - 
'CLST_WW_KUNDEANLAUF', - 
'ID,KUNDEID,INTERESSENTID,MC_ERGID, KONTO_ID', - 
'UDWH1', - 
'CLST_WW_KUNDEANLAUF', - 
'ID_KEY,KUNDEID_KEY, INTERESSENTID_KEY, MC_ERGID_KEY, KONTO_ID_KEY',FALSE);



PROMPT ===========================================
PROMPT 11.9 Eindeutigkeit prüfen / neue Partition hinzufügen und laden
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_LADUNG_STB ('st_ww_kundeanlauf_b', &gbvid, 1, 'UDWH1');    



PROMPT =========================================================================
PROMPT
PROMPT 12. Stage-Ladung
PROMPT Tabelle: st_ww_liefanschr
PROMPT
PROMPT =========================================================================
 
EXEC PKG_IM_LADUNG.P_LADUNG_STAGE ('kdwh_dh.liefanschr&dbludwh', 'st_ww_liefanschr', &gbvid); 
 


PROMPT ===========================================
PROMPT 12.1 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'st_ww_liefanschr');
 

 
PROMPT ===========================================
PROMPT 12.2 Cleanse-Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clst_ww_liefanschr;
TRUNCATE TABLE clst_ww_liefanschr_u;
TRUNCATE TABLE clst_ww_liefanschr_n;
TRUNCATE TABLE clst_ww_liefanschr_d;
TRUNCATE TABLE udwh1.clst_ww_liefanschr;



PROMPT ===========================================
PROMPT 12.3 Deltaermittlung
PROMPT =========================================== 

INSERT /*+ APPEND */ ALL 
WHEN cnt1 > 0 AND cnt2 = 0 AND src IS NOT NULL THEN  --update und new
INTO clst_ww_liefanschr_u
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id,
   anlaufdat,
   letztaenddat,
   personid,
   usernr,
   kundeid,
   dauliefanschr,
   benutzer,
   pakshopnr,
   pakshoploesch,
   typkz,
   paketautomatkz   
)
VALUES
(
   &gbvid,
   &termin,
   'U',
   id,
   anlaufdat,
   letztaenddat,
   personid,
   usernr,
   kundeid,
   dauliefanschr,
   benutzer,
   pakshopnr,
   pakshoploesch,
   typkz,
   paketautomatkz
)
WHEN cnt1 > 0 AND cnt2 = 0 AND src IS NULL THEN -- new
INTO clst_ww_liefanschr_n
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id
)
VALUES
(
   &gbvid,
   &termin,
   'N',
   id
)
WHEN cnt1 = 0 AND cnt2 > 0 AND src IS NULL THEN -- delete
INTO clst_ww_liefanschr_d
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id
)
VALUES
(
   &gbvid,
   &termin,
   'D',
   id
)
SELECT 
   id,
   anlaufdat,
   letztaenddat,
   personid,
   usernr,
   kundeid,
   dauliefanschr,
   benutzer,
   pakshopnr,
   pakshoploesch,
   typkz,
   paketautomatkz,
   COUNT(src1) AS cnt1,
   COUNT(src2) AS cnt2,
   src
FROM
   ( SELECT 
      TRIM(a.id) AS id,
      a.anlaufdat AS anlaufdat,
      a.letztaenddat AS letztaenddat,
      TRIM(a.personid) AS personid,
      a.usernr AS usernr,
      TRIM(a.kundeid) AS kundeid,
      TRIM(a.dauliefanschr) AS dauliefanschr,
      TRIM(a.benutzer) AS benutzer,
      a.pakshopnr AS pakshopnr,
      COALESCE(a.pakshoploesch,0) AS pakshoploesch,
      a.typkz AS typkz,
      COALESCE(a.paketautomatkz,0) AS paketautomatkz,      --Null entspricht 0
      1 src1,
      TO_NUMBER(NULL) src2,
      1 src
    FROM st_ww_liefanschr a
  UNION ALL
    SELECT 
      TRIM(b.id) AS id,
      b.anlaufdat AS anlaufdat,
      b.letztaenddat AS letztaenddat,
      TRIM(b.personid) AS personid,
      b.usernr AS usernr,
      TRIM(b.kundeid) AS kundeid,
      TRIM(b.dauliefanschr) AS dauliefanschr,
      TRIM(b.benutzer) AS benutzer,
      b.pakshopnr AS pakshopnr,
      COALESCE(b.pakshoploesch,0) AS pakshoploesch,
      b.typkz AS typkz,
      COALESCE(b.paketautomatkz,0) AS paketautomatkz,      --Null entspricht 0
      TO_NUMBER(NULL) src1,
      2 src2,
      1 src
    FROM st_ww_liefanschr_1 b
 ) c
GROUP BY GROUPING SETS ((
   id,
   anlaufdat,
   letztaenddat,
   personid,
   usernr,
   kundeid,
   dauliefanschr,
   benutzer,
   pakshopnr,
   pakshoploesch,
   typkz,
   paketautomatkz,
   src) , (id))
HAVING COUNT(src1) <> COUNT(src2);
 
COMMIT;



PROMPT ===========================================
PROMPT 12.4 NEW und UPDATE-Datensätze einspielen
PROMPT ===========================================

INSERT /*+ APPEND */
INTO clst_ww_liefanschr
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id,
   anlaufdat,
   letztaenddat,
   personid,
   usernr,
   kundeid,
   dauliefanschr,
   benutzer,
   pakshopnr,
   pakshoploesch,
   typkz,
   paketautomatkz
)
SELECT
   a.dwh_cr_load_id,
   a.dwh_processdate,
   CASE WHEN b.id IS NOT NULL THEN 'N' ELSE a.dwh_stbflag END AS dwh_stbflag,
   a.id,
   anlaufdat,
   letztaenddat,
   personid,
   usernr,
   kundeid,
   dauliefanschr,
   benutzer,
   pakshopnr,
   pakshoploesch,
   typkz,
   paketautomatkz
FROM
clst_ww_liefanschr_u a
LEFT JOIN
clst_ww_liefanschr_n b
ON (a.id = b.id);
 
COMMIT; 
 


PROMPT ===========================================
PROMPT 12.5 DEL-Datensätze einspielen
PROMPT ===========================================

INSERT /*+APPEND */
INTO clst_ww_liefanschr
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id
)
   SELECT 
   &gbvid,
   &termin,
   'D',
   id
FROM clst_ww_liefanschr_d;
 
COMMIT;



PROMPT ===========================================
PROMPT 12.6 ID, PersonID, KundeID in einen anonymen Key umwandeln und diesen in eine Zieltabelle im Zielschema schreiben
PROMPT ===========================================

TRUNCATE TABLE udwh1.clst_ww_liefanschr;

EXEC IMPROG.PKG_CLEARING.P_CLEARING_ANONYMIZE (1, 'KDWH', - 
'CLST_WW_LIEFANSCHR', - 
'ID,PERSONID,KUNDEID', - 
'UDWH1', - 
'CLST_WW_LIEFANSCHR', - 
'ID_KEY,PERSONID_KEY,KUNDEID_KEY',FALSE);



PROMPT ===========================================
PROMPT 12.7 Eindeutigkeit prüfen / neue Partition hinzufügen und laden 
PROMPT ===========================================

EXEC PKG_IM_LADUNG.P_LADUNG_STB ('st_ww_liefanschr_b', &gbvid, 1, 'UDWH1');



PROMPT =========================================================================
PROMPT
PROMPT 13. Stage-Ladung
PROMPT Tabelle: st_ww_kdkto
PROMPT
PROMPT =========================================================================

EXEC PKG_IM_LADUNG.P_LADUNG_STAGE ('kdwh_dh.kdkto&dbludwh', 'st_ww_kdkto', &gbvid);



PROMPT ===========================================
PROMPT 13.1 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'st_ww_kdkto');



PROMPT ===========================================
PROMPT 13.2 Cleanse-Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clst_ww_kdkto;
TRUNCATE TABLE clst_ww_kdkto_u;
TRUNCATE TABLE clst_ww_kdkto_n;
TRUNCATE TABLE clst_ww_kdkto_d;
TRUNCATE TABLE udwh1.clst_ww_kdkto;



PROMPT ===========================================
PROMPT 13.3 Deltaermittlung
PROMPT ===========================================

INSERT /*+ APPEND */ ALL 
WHEN cnt1 > 0 AND cnt2 = 0 AND src IS NOT NULL THEN  --update und new
INTO clst_ww_kdkto_u
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id,
   kundeid,
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
   &termin,
   'U',
   id,
   kundeid,
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
WHEN cnt1 > 0 AND cnt2 = 0 AND src IS NULL THEN -- new
INTO clst_ww_kdkto_n
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id
)
VALUES
(
   &gbvid,
   &termin,
   'N',
   id
)
WHEN cnt1 = 0 AND cnt2 > 0 AND src IS NULL THEN -- delete
INTO clst_ww_kdkto_d
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id
)
VALUES
(
   &gbvid,
   &termin,
   'D',
   id
)
SELECT 
   id,
   kundeid,
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
   letztaktivfgdat,
   COUNT(src1) AS cnt1,
   COUNT(src2) AS cnt2,
   src
FROM
   ( SELECT 
      TRIM(a.id) AS id,
      TRIM(a.kundeid) AS kundeid,
      COALESCE(a.saldonnkf,0) AS saldonnkf,
      COALESCE(a.saldorgkf,0) AS saldorgkf,
      a.stdgaktkostfrei AS stdgaktkostfrei,
      a.stdgaktkostpfli AS stdgaktkostpfli,
      a.kdausz AS kdausz,
      COALESCE(a.zahlungrgkf_kum,0) AS zahlungrgkf_kum,
      COALESCE(a.zahlungnnkf_kum,0) AS zahlungnnkf_kum,
      a.datletztzrgkf AS datletztzrgkf,
      COALESCE(a.kredlim,0) AS kredlim,
      a.nkscorepkte AS nkscorepkte,
      a.nkscorekz AS nkscorekz,
      a.letztretouredate AS letztretouredate,
      a.letztaktivfgdat AS letztaktivfgdat,
      1 src1,
      TO_NUMBER(NULL) src2,
      1 src
    FROM st_ww_kdkto a
  UNION ALL
    SELECT 
      TRIM(b.id) AS id,
      TRIM(b.kundeid) AS kundeid,
      COALESCE(b.saldonnkf,0) AS saldonnkf,
      COALESCE(b.saldorgkf,0) AS saldorgkf,
      b.stdgaktkostfrei AS stdgaktkostfrei,
      b.stdgaktkostpfli AS stdgaktkostpfli,
      b.kdausz AS kdausz,
      COALESCE(b.zahlungrgkf_kum,0) AS zahlungrgkf_kum,
      COALESCE(b.zahlungnnkf_kum,0) AS zahlungnnkf_kum,
      b.datletztzrgkf AS datletztzrgkf,
      COALESCE(b.kredlim,0) AS kredlim,
      b.nkscorepkte AS nkscorepkte,
      b.nkscorekz AS nkscorekz,
      b.letztretouredate AS letztretouredate,
      b.letztaktivfgdat AS letztaktivfgdat,
      TO_NUMBER(NULL) src1,
      2 src2,
      1 src
    FROM st_ww_kdkto_1 b
 ) c
GROUP BY GROUPING SETS ((
   id,
   kundeid,
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
   letztaktivfgdat,
   src) , (id))
HAVING COUNT(src1) <> COUNT(src2);
 
COMMIT;



PROMPT ===========================================
PROMPT 13.4 NEW und UPDATE-Datensätze einspielen
PROMPT ===========================================

INSERT /*+ APPEND */
INTO clst_ww_kdkto
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id,
   kundeid,
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
   a.dwh_processdate,
   CASE WHEN b.id IS NOT NULL THEN 'N' ELSE a.dwh_stbflag END AS dwh_stbflag,
   a.id,
   kundeid,
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
clst_ww_kdkto_u a
LEFT JOIN
clst_ww_kdkto_n b
ON (a.id = b.id);
 
COMMIT;
 

 
PROMPT ===========================================
PROMPT 13.5 DEL-Datensätze einspielen
PROMPT ===========================================
 
INSERT /*+APPEND */
INTO clst_ww_kdkto
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id
)
   SELECT 
   &gbvid,
   &termin,
   'D',
   id
FROM clst_ww_kdkto_d;
 
COMMIT;



PROMPT ===========================================
PROMPT 13.6 ID, KundeID in einen anonymen Key umwandeln und diesen in eine Zieltabelle im Zielschema schreiben
PROMPT ===========================================

TRUNCATE TABLE udwh1.clst_ww_kdkto;

EXEC IMPROG.PKG_CLEARING.P_CLEARING_ANONYMIZE (1, 'KDWH', 'CLST_WW_KDKTO', 'ID,KUNDEID','UDWH1', 'CLST_WW_KDKTO', 'ID_KEY,KUNDEID_KEY',FALSE); 



PROMPT ===========================================
PROMPT 13.7 Eindeutigkeit prüfen / neue Partition hinzufügen und laden 
PROMPT ===========================================

EXEC PKG_IM_LADUNG.P_LADUNG_STB ('st_ww_kdkto_b', &gbvid, 1, 'UDWH1');



PROMPT =========================================================================
PROMPT
PROMPT 14. Stage-Ladung
PROMPT Tabelle: st_ww_mahnsta
PROMPT
PROMPT =========================================================================

EXEC PKG_IM_LADUNG.P_LADUNG_STAGE ('kdwh_dh.mahnsta&dbludwh', 'st_ww_mahnsta', &gbvid);



PROMPT ===========================================
PROMPT 14.1 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'st_ww_mahnsta');



PROMPT ===========================================
PROMPT 14.2 Cleanse-Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clst_ww_mahnsta;
TRUNCATE TABLE clst_ww_mahnsta_u;
TRUNCATE TABLE clst_ww_mahnsta_n;
TRUNCATE TABLE clst_ww_mahnsta_d;
TRUNCATE TABLE udwh1.clst_ww_mahnsta;



PROMPT ===========================================
PROMPT 14.3 Deltaermittlung
PROMPT ===========================================

INSERT /*+ APPEND */ ALL 
WHEN cnt1 > 0 AND cnt2 = 0 AND src IS NOT NULL THEN  --update und new
INTO clst_ww_mahnsta_u
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id,
   kundeid,
   zahlungrueckst,
   gemahntzahlungsrueckst
)
VALUES
(
   &gbvid,
   &termin,
   'U',
   id,
   kundeid,
   zahlungrueckst,
   gemahntzahlungsrueckst
)
WHEN cnt1 > 0 AND cnt2 = 0 AND src IS NULL THEN -- new
INTO clst_ww_mahnsta_n
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id
)
VALUES
(
   &gbvid,
   &termin,
   'N',
   id
)
WHEN cnt1 = 0 AND cnt2 > 0 AND src IS NULL THEN -- delete
INTO clst_ww_mahnsta_d
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id
)
VALUES
(
   &gbvid,
   &termin,
   'D',
   id
)
SELECT 
   id,
   kundeid,
   zahlungrueckst,
   gemahntzahlungsrueckst,
   COUNT(src1) AS cnt1,
   COUNT(src2) AS cnt2,
   src
FROM
   ( SELECT 
      TRIM(a.id) AS id,
      TRIM(a.kundeid) AS kundeid,
      COALESCE(a.zahlungrueckst,0) AS zahlungrueckst,
      COALESCE(a.gemahntzahlungsrueckst,0) AS gemahntzahlungsrueckst,
      1 src1,
      TO_NUMBER(NULL) src2,
      1 src
    FROM st_ww_mahnsta a
  UNION ALL
    SELECT 
      TRIM(b.id) AS id,
      TRIM(b.kundeid) AS kundeid,
      COALESCE(b.zahlungrueckst,0) AS zahlungrueckst,
      COALESCE(b.gemahntzahlungsrueckst,0) AS gemahntzahlungsrueckst,
      TO_NUMBER(NULL) src1,
      2 src2,
      1 src
    FROM st_ww_mahnsta_1 b
 ) c
GROUP BY GROUPING SETS ((
   id,
   kundeid,
   zahlungrueckst,
   gemahntzahlungsrueckst,
   src) , (id))
HAVING COUNT(src1) <> COUNT(src2);
 
COMMIT;



PROMPT ===========================================
PROMPT 14.4 NEW und UPDATE-Datensätze einspielen
PROMPT ===========================================

INSERT /*+ APPEND */
INTO clst_ww_mahnsta
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id,
   kundeid,
   zahlungrueckst,
   gemahntzahlungsrueckst
)
SELECT
   a.dwh_cr_load_id,
   a.dwh_processdate,
   CASE WHEN b.id IS NOT NULL THEN 'N' ELSE a.dwh_stbflag END AS dwh_stbflag,
   a.id,
   kundeid,
   zahlungrueckst,
   gemahntzahlungsrueckst
FROM
clst_ww_mahnsta_u a
LEFT JOIN
clst_ww_mahnsta_n b
ON (a.id = b.id);
 
COMMIT;



PROMPT ===========================================
PROMPT 14.5 DEL-Datensätze einspielen
PROMPT ===========================================
 
INSERT /*+APPEND */
INTO clst_ww_mahnsta
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id
)
   SELECT 
   &gbvid,
   &termin,
   'D',
   id
FROM clst_ww_mahnsta_d;
 
COMMIT;
 

 
PROMPT ===========================================
PROMPT 14.6 ID,KundeID in einen anonymen Key umwandeln und diesen in eine Zieltabelle im Zielschema schreiben
PROMPT ===========================================

TRUNCATE TABLE udwh1.clst_ww_mahnsta;

EXEC IMPROG.PKG_CLEARING.P_CLEARING_ANONYMIZE (1, 'KDWH', 'CLST_WW_MAHNSTA', 'ID,KUNDEID','UDWH1', 'CLST_WW_MAHNSTA', 'ID_KEY,KUNDEID_KEY',FALSE); 



PROMPT ===========================================
PROMPT 14.7 Eindeutigkeit prüfen / neue Partition hinzufügen und laden 
PROMPT ===========================================

EXEC PKG_IM_LADUNG.P_LADUNG_STB ('st_ww_mahnsta_b', &gbvid, 1, 'UDWH1');



PROMPT =========================================================================
PROMPT
PROMPT 15. Stage-Ladung
PROMPT Tabelle:  st_ww_nlempfaenger_kk 
PROMPT           st_ww_nlempfaenger
PROMPT
PROMPT =========================================================================

EXEC PKG_IM_LADUNG.P_LADUNG_STAGE ('kdwh_dh.nlempfaenger&dbludwh', 'st_ww_nlempfaenger_kk', &gbvid);

EXEC PKG_IM_LADUNG.P_LADUNG_STAGE ('kdwh_dh.nlempfaenger&dbludwh', 'st_ww_nlempfaenger', &gbvid);



PROMPT ===========================================
PROMPT 15.1 Aktuelle Statistiken erstellen
PROMPT ===========================================

EXEC PKG_STATS.GATHERTABLE (USER, 'st_ww_nlempfaenger_kk');

EXEC PKG_STATS.GATHERTABLE (USER, 'st_ww_nlempfaenger');



PROMPT ===========================================
PROMPT 15.2 Cleanse-Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clst_ww_nlempfaenger_kk;
TRUNCATE TABLE clst_ww_nlempfaenger_kk_u;
TRUNCATE TABLE clst_ww_nlempfaenger_kk_n;
TRUNCATE TABLE clst_ww_nlempfaenger_kk_d;

TRUNCATE TABLE clst_ww_nlempfaenger;
TRUNCATE TABLE clst_ww_nlempfaenger_u;
TRUNCATE TABLE clst_ww_nlempfaenger_n;
TRUNCATE TABLE clst_ww_nlempfaenger_d;
TRUNCATE TABLE udwh1.clst_ww_nlempfaenger;
 


PROMPT ===========================================
PROMPT 15.3 Deltaermittlung
PROMPT ===========================================



PROMPT ===========================================
PROMPT 15.3.1 Deltaermittlung Kernkundendaten
PROMPT ===========================================

INSERT /*+ APPEND */ ALL 
WHEN cnt1 > 0 AND cnt2 = 0 AND src IS NOT NULL THEN  --update und new
INTO clst_ww_nlempfaenger_kk_u
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id,
   kundenfirmaid,
   personid,
   empfaengernr
)
VALUES
(
   &gbvid,
   &termin,
   'U',
   id,
   kundenfirmaid,
   personid,
   empfaengernr
)
WHEN cnt1 > 0 AND cnt2 = 0 AND src IS NULL THEN -- new
INTO clst_ww_nlempfaenger_kk_n
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id
)
VALUES
(
   &gbvid,
   &termin,
   'N',
   id
)
WHEN cnt1 = 0 AND cnt2 > 0 AND src IS NULL THEN -- delete
INTO clst_ww_nlempfaenger_kk_d
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id
)
VALUES
(
   &gbvid,
   &termin,
   'D',
   id
)
SELECT 
   id,
   kundenfirmaid,
   personid,
   empfaengernr,
   COUNT(src1) AS cnt1,
   COUNT(src2) AS cnt2,
   src
FROM
   ( SELECT 
      TRIM(a.id) AS id,
      TRIM(a.kundenfirmaid) AS kundenfirmaid,
      TRIM(a.personid) AS personid,
      a.empfaengernr AS empfaengernr,
      1 src1,
      TO_NUMBER(NULL) src2,
      1 src
    FROM st_ww_nlempfaenger_kk a
  UNION ALL
    SELECT 
      TRIM(b.id) AS id,
      TRIM(b.kundenfirmaid) AS kundenfirmaid,
      TRIM(b.personid) AS personid,
      b.empfaengernr AS empfaengernr,
      TO_NUMBER(NULL) src1,
      2 src2,
      1 src
    FROM st_ww_nlempfaenger_kk_1 b
 ) c
GROUP BY GROUPING SETS ((
   id,
   kundenfirmaid,
   personid,
   empfaengernr,
   src) , (id))
HAVING COUNT(src1) <> COUNT(src2);
 
COMMIT;



PROMPT ===========================================
PROMPT 15.3.2 Deltaermittlung Verhaltenskundendaten
PROMPT ===========================================

INSERT /*+ APPEND */ ALL 
WHEN cnt1 > 0 AND cnt2 = 0 AND src IS NOT NULL THEN  --update und new
INTO clst_ww_nlempfaenger_u
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id,
   kundenfirmaid,
   personid,
   adressherkunftid,
   newslettertypid,
   empfaengernr,
   anlaufdat,
   newsletterid,
   nlabonnentstatusid,
   tddsgid,
   letztaenddat,
   prozessidanl,
   prozessidletztaend,
   benutzeridanl,
   benutzeridletztaend
)
VALUES
(
   &gbvid,
   &termin,
   'U',
   id,
   kundenfirmaid,
   personid,
   adressherkunftid,
   newslettertypid,
   empfaengernr,
   anlaufdat,
   newsletterid,
   nlabonnentstatusid,
   tddsgid,
   letztaenddat,
   prozessidanl,
   prozessidletztaend,
   benutzeridanl,
   benutzeridletztaend
)
WHEN cnt1 > 0 AND cnt2 = 0 AND src IS NULL THEN -- new
INTO clst_ww_nlempfaenger_n
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id
)
VALUES
(
   &gbvid,
   &termin,
   'N',
   id
)
WHEN cnt1 = 0 AND cnt2 > 0 AND src IS NULL THEN -- delete
INTO clst_ww_nlempfaenger_d
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id
)
VALUES
(
   &gbvid,
   &termin,
   'D',
   id
)
SELECT 
   id,
   kundenfirmaid,
   personid,
   adressherkunftid,
   newslettertypid,
   empfaengernr,
   anlaufdat,
   newsletterid,
   nlabonnentstatusid,
   tddsgid,
   letztaenddat,
   prozessidanl,
   prozessidletztaend,
   benutzeridanl,
   benutzeridletztaend,
   COUNT(src1) AS cnt1,
   COUNT(src2) AS cnt2,
   src
FROM
   ( SELECT 
      TRIM(a.id) AS id,
      TRIM(a.kundenfirmaid) AS kundenfirmaid,
      TRIM(a.personid) AS personid,
      TRIM(a.adressherkunftid) AS adressherkunftid,
      TRIM(a.newslettertypid) AS newslettertypid,
      a.empfaengernr AS empfaengernr,
      a.anlaufdat AS anlaufdat,
      TRIM(a.newsletterid) AS newsletterid,
      TRIM(a.nlabonnentstatusid) AS nlabonnentstatusid,
      TRIM(a.tddsgid) AS tddsgid,
      a.letztaenddat AS letztaenddat,
      TRIM(a.prozessidanl) AS prozessidanl,
      TRIM(a.prozessidletztaend) AS prozessidletztaend,
      TRIM(a.benutzeridanl) AS benutzeridanl,
      TRIM(a.benutzeridletztaend) AS benutzeridletztaend,
      1 src1,
      TO_NUMBER(NULL) src2,
      1 src
    FROM st_ww_nlempfaenger a
  UNION ALL
    SELECT 
      TRIM(b.id) AS id,
      TRIM(b.kundenfirmaid) AS kundenfirmaid,
      TRIM(b.personid) AS personid,
      TRIM(b.adressherkunftid) AS adressherkunftid,
      TRIM(b.newslettertypid) AS newslettertypid,
      b.empfaengernr AS empfaengernr,
      b.anlaufdat AS anlaufdat,
      TRIM(b.newsletterid) AS newsletterid,
      TRIM(b.nlabonnentstatusid) AS nlabonnentstatusid,
      TRIM(b.tddsgid) AS tddsgid,
      b.letztaenddat AS letztaenddat,
      TRIM(b.prozessidanl) AS prozessidanl,
      TRIM(b.prozessidletztaend) AS prozessidletztaend,
      TRIM(b.benutzeridanl) AS benutzeridanl,
      TRIM(b.benutzeridletztaend) AS benutzeridletztaend,
      TO_NUMBER(NULL) src1,
      2 src2,
      1 src
    FROM st_ww_nlempfaenger_1 b
 ) c
GROUP BY GROUPING SETS ((
   id,
   kundenfirmaid,
   personid,
   adressherkunftid,
   newslettertypid,
   empfaengernr,
   anlaufdat,
   newsletterid,
   nlabonnentstatusid,
   tddsgid,
   letztaenddat,
   prozessidanl,
   prozessidletztaend,
   benutzeridanl,
   benutzeridletztaend,
   src) , (id))
HAVING COUNT(src1) <> COUNT(src2);
 
COMMIT;
 


PROMPT ===========================================
PROMPT 15.4 NEW und UPDATE-Datensätze einspielen
PROMPT ===========================================



PROMPT ===========================================
PROMPT 15.4.1 NEW und UPDATE-Datensätze einspielen (Kernkundendaten)
PROMPT ===========================================

INSERT /*+ APPEND */
INTO clst_ww_nlempfaenger_kk
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id,
   kundenfirmaid,
   personid,
   empfaengernr
)
SELECT
   a.dwh_cr_load_id,
   a.dwh_processdate,
   CASE WHEN b.id IS NOT NULL THEN 'N' ELSE a.dwh_stbflag END AS dwh_stbflag,
   a.id,
   kundenfirmaid,
   personid,
   empfaengernr
FROM
clst_ww_nlempfaenger_kk_u a
LEFT JOIN
clst_ww_nlempfaenger_kk_n b
ON (a.id = b.id);
 
COMMIT;



PROMPT ===========================================
PROMPT 15.4.2 NEW und UPDATE-Datensätze einspielen (Verhaltenskundendaten)
PROMPT ===========================================


INSERT /*+ APPEND */
INTO clst_ww_nlempfaenger
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id,
   kontonrletzteziffern,
   firma,
   kundenfirmaid,
   personid,
   adressherkunftid,
   newslettertypid,
   empfaengernr,
   nlabo_id,   
   anlaufdat,
   newsletterid,
   nlabonnentstatusid,
   tddsgid,
   letztaenddat,
   prozessidanl,
   prozessidletztaend,
   benutzeridanl,
   benutzeridletztaend
)
SELECT
   a.dwh_cr_load_id,
   a.dwh_processdate,
   CASE WHEN b.id IS NOT NULL THEN 'N' ELSE a.dwh_stbflag END AS dwh_stbflag,
   a.id,
   SUBSTR(kk.empfaengernr, -3) AS kontonrletzteziffern,
   NULL,
   a.kundenfirmaid,
   a.personid,
   adressherkunftid,
   newslettertypid,
   a.empfaengernr,
   NULL,
   anlaufdat,
   newsletterid,
   nlabonnentstatusid,
   tddsgid,
   letztaenddat,
   prozessidanl,
   prozessidletztaend,
   benutzeridanl,
   benutzeridletztaend
FROM
clst_ww_nlempfaenger_u a
INNER JOIN st_ww_nlempfaenger_kk  kk
ON kk.id = a.id
LEFT JOIN
clst_ww_nlempfaenger_n b
ON (a.id = b.id);
 
COMMIT;



PROMPT ===========================================
PROMPT 15.5 DEL-Datensätze einspielen
PROMPT ===========================================



PROMPT ===========================================
PROMPT 15.5.1 DEL-Datensätze einspielen (Kernkundendaten)
PROMPT ===========================================

INSERT /*+APPEND */
INTO clst_ww_nlempfaenger_kk
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id
)
   SELECT 
   &gbvid,
   &termin,
   'D',
   id
FROM clst_ww_nlempfaenger_kk_d;
 
COMMIT;



PROMPT ===========================================
PROMPT 15.5.2 DEL-Datensätze einspielen (Verhaltenskundendaten)
PROMPT ===========================================
 
INSERT /*+APPEND */
INTO clst_ww_nlempfaenger
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id
)
   SELECT 
   &gbvid,
   &termin,
   'D',
   id
FROM clst_ww_nlempfaenger_d;
 
COMMIT;



PROMPT ===========================================
PROMPT 15.6 NL-Empfänger-ID (Nlabo_ID) für Kundenverhaltensdaten generieren und setzen
PROMPT ===========================================

EXEC PKG_IM_KONTO_ID.P_DWH_KONTO_ID_UP ('clst_ww_nlempfaenger', 'empfaengernr','kundenfirmaid', 'nlabo_id', &gbvid, 3, 1);

PROMPT Test auf leere NLabo-IDs

DECLARE
    v_anz_nlabo_id PLS_INTEGER;
BEGIN

    SELECT COUNT(*) INTO v_anz_nlabo_id
    FROM clst_ww_nlempfaenger
    WHERE nlabo_id IS NULL AND empfaengernr IS NOT NULL;

    IF v_anz_nlabo_id > 0 THEN
        RAISE_APPLICATION_ERROR (-20054, 'Leere NLabo-IDs!'); 
    END IF;    

END;
/



PROMPT ===========================================
PROMPT 15.7 ID,PersonID,Nlabo_ID in einen anonymen Key umwandeln und diesen in eine Zieltabelle im Zielschema schreiben
PROMPT ===========================================

TRUNCATE TABLE udwh1.clst_ww_nlempfaenger;

EXEC IMPROG.PKG_CLEARING.P_CLEARING_ANONYMIZE (1, 'KDWH', 'CLST_WW_NLEMPFAENGER', 'ID,PERSONID,NLABO_ID','UDWH1', 'CLST_WW_NLEMPFAENGER', 'ID_KEY,PERSONID_KEY,NLABO_ID_KEY',FALSE); 



PROMPT ===========================================
PROMPT 15.8 Eindeutigkeit prüfen / neue Partition hinzufügen und laden 
PROMPT ===========================================

EXEC PKG_IM_LADUNG.P_LADUNG_STB ('st_ww_nlempfaenger_kk_b', &gbvid, 1);

EXEC PKG_IM_LADUNG.P_LADUNG_STB ('st_ww_nlempfaenger_b', &gbvid, 1, 'UDWH1');



PROMPT =========================================================================
PROMPT
PROMPT 16. Stage-Ladung
PROMPT Tabelle: st_ww_kundeverskostflat
PROMPT
PROMPT =========================================================================

EXEC PKG_IM_LADUNG.P_LADUNG_STAGE ('kdwh_dh.kundeverskostflatrate&dbludwh', 'st_ww_kundeverskostflat', &gbvid);



PROMPT ===========================================
PROMPT 16.1 Aktuelle Statistiken erstellen
PROMPT ===========================================

EXEC PKG_STATS.GATHERTABLE (USER, 'st_ww_kundeverskostflat');



PROMPT ===========================================
PROMPT 16.2 Cleanse-Tabellen leeren
PROMPT ===========================================

TRUNCATE TABLE clst_ww_kundeverskostflat;
TRUNCATE TABLE clst_ww_kundeverskostflat_u;
TRUNCATE TABLE clst_ww_kundeverskostflat_n;
TRUNCATE TABLE clst_ww_kundeverskostflat_d;



PROMPT ===========================================
PROMPT 16.3 Deltaermittlung
PROMPT ===========================================

INSERT /*+APPEND*/ ALL
WHEN cnt1 > 0 AND cnt2 = 0 AND src IS NOT NULL THEN  --update und new
INTO clst_ww_kundeverskostflat_u
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id,
   anldat,
   benutzeridanl,
   kundeid,
   erwerbstatkz,
   gueltigvondat,
   gueltigbisdat,
   stornodat,
   benutzeridstorno,
   auftragkopfid,
   wapitransferoffenkz,
   naechstsyncdat,
   bem
)
VALUES
(
   &gbvid,  
   &termin,
   'U',
   id,
   anldat,
   benutzeridanl,
   kundeid,
   erwerbstatkz,
   gueltigvondat,
   gueltigbisdat,
   stornodat,
   benutzeridstorno,
   auftragkopfid,
   wapitransferoffenkz,
   naechstsyncdat,
   bem
)
WHEN cnt1 > 0 AND cnt2 = 0 AND src IS NULL THEN -- new
INTO clst_ww_kundeverskostflat_n
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id
)
VALUES
(
   &gbvid,
   &termin,
   'N',
   id
)
WHEN cnt1 = 0 AND cnt2 > 0 AND src IS NULL THEN -- delete
INTO clst_ww_kundeverskostflat_d
(
   dwh_cr_load_id,  
   dwh_processdate,
   dwh_stbflag,
   id
)
VALUES
(
   &gbvid,
   &termin,
   'D',
   id
)
SELECT
   id,
   anldat,
   benutzeridanl,
   kundeid,
   erwerbstatkz,
   gueltigvondat,
   gueltigbisdat,
   stornodat,
   benutzeridstorno,
   auftragkopfid,
   wapitransferoffenkz,
   naechstsyncdat,
   bem,
COUNT(src1) AS cnt1,
COUNT(src2) AS cnt2,
src
FROM
( SELECT
      TRIM(a.id) AS id,
      a.anldat AS anldat,
      TRIM(a.benutzeridanl) AS benutzeridanl,
      TRIM(a.kundeid) AS kundeid,
      a.erwerbstatkz AS erwerbstatkz,
      a.gueltigvondat AS gueltigvondat,
      a.gueltigbisdat AS gueltigbisdat,
      a.stornodat AS stornodat,
      TRIM(a.benutzeridstorno) AS benutzeridstorno,
      TRIM(a.auftragkopfid) AS auftragkopfid,
      COALESCE(a.wapitransferoffenkz,0) AS wapitransferoffenkz,  -- null entspricht 0
      a.naechstsyncdat AS naechstsyncdat,
      TRIM(a.bem) AS bem,
1 src1,
TO_NUMBER(NULL) src2,
1 src
FROM st_ww_kundeverskostflat a
UNION ALL
SELECT
      TRIM(b.id) AS id,
      b.anldat AS anldat,
      TRIM(b.benutzeridanl) AS benutzeridanl,
      TRIM(b.kundeid) AS kundeid,
      b.erwerbstatkz AS erwerbstatkz,
      b.gueltigvondat AS gueltigvondat,
      b.gueltigbisdat AS gueltigbisdat,
      b.stornodat AS stornodat,
      TRIM(b.benutzeridstorno) AS benutzeridstorno,
      TRIM(b.auftragkopfid) AS auftragkopfid,
      COALESCE(b.wapitransferoffenkz,0) AS wapitransferoffenkz,  -- null entspricht 0
      b.naechstsyncdat AS naechstsyncdat,
      TRIM(b.bem) AS bem,
TO_NUMBER(NULL) src1,
2 src2,
1 src
FROM st_ww_kundeverskostflat_1 b
) c
GROUP BY GROUPING SETS ((
id,
   anldat,
   benutzeridanl,
   kundeid,
   erwerbstatkz,
   gueltigvondat,
   gueltigbisdat,
   stornodat,
   benutzeridstorno,
   auftragkopfid,
   wapitransferoffenkz,
   naechstsyncdat,
   bem,
src) , (id))
HAVING COUNT(src1) <> COUNT(src2);

COMMIT;



PROMPT ===========================================
PROMPT 16.4 NEW und UPDATE-Datensätze einspielen
PROMPT ===========================================

INSERT /*+APPEND*/
INTO clst_ww_kundeverskostflat
(
   dwh_cr_load_id,
   dwh_processdate,
   dwh_stbflag,
   id,
   anldat,
   benutzeridanl,
   kundeid,
   erwerbstatkz,
   gueltigvondat,
   gueltigbisdat,
   stornodat,
   benutzeridstorno,
   auftragkopfid,
   wapitransferoffenkz,
   naechstsyncdat,
   bem
)
SELECT
   a.dwh_cr_load_id,
   a.dwh_processdate,
   CASE WHEN b.id IS NOT NULL THEN 'N' ELSE a.dwh_stbflag END AS dwh_stbflag,
   a.id,
   anldat,
   benutzeridanl,
   kundeid,
   erwerbstatkz,
   gueltigvondat,
   gueltigbisdat,
   stornodat,
   benutzeridstorno,
   auftragkopfid,
   wapitransferoffenkz,
   naechstsyncdat,
   bem
FROM
clst_ww_kundeverskostflat_u a
LEFT JOIN
clst_ww_kundeverskostflat_n b
ON (a.id = b.id);

COMMIT;



PROMPT ===========================================
PROMPT 16.5 DEL-Datensätze einspielen
PROMPT ===========================================

INSERT /*+APPEND*/
INTO clst_ww_kundeverskostflat
(
   dwh_cr_load_id,
   dwh_processdate, 
   dwh_stbflag,
   id
)
SELECT
   &gbvid,
   &termin,
   'D',
   id
FROM clst_ww_kundeverskostflat_d;

COMMIT;



PROMPT ===========================================
PROMPT 16.6 ID,KundeID,AuftragkopfID in einen anonymen Key umwandeln und diesen in eine Zieltabelle im Zielschema schreiben
PROMPT ===========================================

TRUNCATE TABLE udwh1.clst_ww_kundeverskostflat;

EXEC IMPROG.PKG_CLEARING.P_CLEARING_ANONYMIZE (1, 'KDWH', 'clst_ww_kundeverskostflat', 'ID,KUNDEID,AUFTRAGKOPFID','UDWH1', 'clst_ww_kundeverskostflat', 'ID_KEY,KUNDEID_KEY,AUFTRAGKOPFID_KEY',FALSE); 



PROMPT ===========================================
PROMPT 16.7 Eindeutigkeit prüfen / neue Partition hinzufügen und laden
PROMPT ===========================================

EXEC PKG_IM_LADUNG.P_LADUNG_STB ('st_ww_kundeverskostflat_b', &gbvid, 1, 'UDWH1');