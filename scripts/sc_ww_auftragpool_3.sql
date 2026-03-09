/*******************************************************************************

Job:              sc_ww_auftragpool_3
Beschreibung:     Lädt Auftragpool-Daten ins Source-Core
          
Erstellt am:       22.12.2016
Erstellt von:      Andrea Gagulic  
Ansprechpartner:   Andrea Gagulic
Ansprechpartner-IT: -

verwendete Tabellen:  st_ww_auftrag_auftpool_b
                      sc_ww_kundenfirma
                      sc_ww_vertrgebiet
                      sc_ww_zahlmethode
                      sc_ww_zahlwunsch
                      sc_ww_auftrag_posstat
                      sc_ww_auftrag_anlweg
                      sc_ww_auftrag_postyp
                      sc_ww_auftrag_bestandstat
                      sc_ww_benutzeranl
                      sc_ww_benutzerletztaend
                      sc_ww_prozessanl
--                      sc_ww_prozesssperre
                      sc_ww_mwst
                      sc_ww_verswunsch
                      sc_ww_alfa_ersatz
                      sc_ww_auftrag_posstat
                      sc_ww_auftrag_fehlertyp
                      sc_ww_auftrag_freigabestat
                      sc_ww_neukundekz
                      sc_ww_lieferwunsch
                      sc_ww_auftrag_erskdwunsch
                      sc_ww_alfa_grvt 
                      sc_ww_verskostfreigrund
                      
                       
Endtabellen:          sc_ww_auftrag_auftpool 
                      sc_ww_auftrag_auftpool_ver
                      sc_ww_auftrag_auftpool_liefauskunft_ergebnisid
                      sc_ww_auftrag_auftpool_liefauskunft_ergebnisid_ver


Fehler-Doku:      -
Ladestrecke:      https://confluence.witt-gruppe.eu/display/IM/Auftragpool

********************************************************************************
geändert am:          28.04.2017
geändert von:         andgag
Änderungen:           Referenzauflösung mit kunde, auftragkopf und auftragpos entfernt
*******************************************************************************
geändert am:          04.05.2017
geändert von:         andgag
Änderungen:           Referenzauflösung liefanschr entfernt
*******************************************************************************
geändert am:          11.05.2017
geändert von:         andgag
Änderungen:           COALESCE bei Prozessidsperre eingebaut
*******************************************************************************
geändert am:          06.06.2017
geändert von:         andgag
Änderungen:           Prozessidletztaend eingebaut
*******************************************************************************
geändert am:          08.11.2017
geändert von:         andgag
Änderungen:           Referenzaufloesung mit ALFA-Datenmodell entfernt
*******************************************************************************
geändert am:          14.11.2017
geändert von:         andgag
Änderungen:           Spaltenerweiterung erstfakturaidumsatz
*******************************************************************************
geändert am:          27.08.2018
geändert von:         andgag
Änderungen:           Spaltenerweiterung marketingpartnernr, alfa_artliefid,
                               komwarenwert
*******************************************************************************                               
geändert am:          20.11.2018
geändert von:         maxlin
Änderungen:           Anpassung an Clearingstelle, schützenswerte Daten verschlüsselt
                      "_key" - Spalten
*******************************************************************************
geändert am:          29.05.2019
geändert von:         maxlin
Änderungen:           Ausbau Referenzauflösung zur Spalte benutzerletztaend
*******************************************************************************
geändert am:          01.07.2021
geändert von:         andgag
Änderungen:           Ausbau verschiedener Spalten
                        liefauskunft_ergebnisid
                        sperrendedat
                        dwh_id_prozesssperre
                        prozessidsperre
                        letztaenddat
*******************************************************************************
geändert am:          13.12.2022
geändert von:         andgag
Änderungen:           sc_ww_auftrag_auftpool_liefauskunft_ergebnisid eingebaut
*******************************************************************************
geändert am:          20.12.2023
geändert von:         andgag
Änderungen:           auftrposidentnr und id ausgebaut (DSGVO)  
*******************************************************************************
geändert am:          04.01.2024
geändert von:         andgag
Änderungen:           auftridentnr und ezvtransaktionid ausgebaut (DSGVO)  
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
PROMPT Endtabelle: sc_ww_auftrag_auftpool / sc_ww_auftrag_auftpool_ver
PROMPT
PROMPT =========================================================================
 
 
 
PROMPT ===========================================
PROMPT  1.1 Cleansing Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clsc_ww_auftrag_auftpool;
TRUNCATE TABLE clsc_ww_auftrag_auftpool_1;
TRUNCATE TABLE clsc_ww_auftrag_auftpool_d;
 
 
 
PROMPT ===========================================
PROMPT  1.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_auftrag_auftpool_1
(
   dwh_cr_load_id,
   id_key,
   kundeid_key,
   kundenfirmaid,
   vertrgebietid,
   auftridentnr_key,
--   auftridentnr,
   lfdartposnr,
   terminwunschdat,
   sendkompldat,
   zahlmethodeid,
   zahlwunschid,
   ezvtransaktionid_key,
--   ezvtransaktionid,
   bestartnrbestand,
   bestartgrbestand,
   faktartnr,
   faktartgr,
   auftrag_positionstatusid,
   auftragposid_key,
   auftrag_anlaufwegid,
   faktura_abwicklunggrpid,
   faktura_sendungid_key,   
   faktura_sendungid,
   auftrag_postypid,
   auftrag_bestandstatusid,
   nalieinspdat,
   anldat,
   benutzeridanl,
   benutzeridletztaend,
   prozessidanl,
   bestkomartnr,
   bestkomartgr,
   bestkomprom,
   faktkomartnr,
   faktkomartgr,
   faktkomprom,
   faktprom,
   laengemeterware,
   faktmwstid,
   erstfakturierlaufstartdat,
   verswunschid,
   alfa_ersatzartid,
   nalifreilaufdat,
   nalikdinfodat,
   faktbetrag,
   kolliid,
   auftrag_auftragpoolid_key,
   gutscheindatenid_key,
   gutscheindatenid,   
   liefanschrid_key,
   auftrag_positionstatusidersthg,
   auftrag_fehlertypid,
   auftrag_freigabestatusid,
   bestdat,
   neukundekz,
   lieferwunschid,
   auftrag_erskdwunschid,
   faktura_abschreibungstatusid,
   liefauskunftidakt,
   liefauskunftidkom,
   auftragkopfid_key,
   alfa_grvtid,
   letztexportdatbaur,
   auftrag_loartikeltypid,
   erstfakturaid_key,
   erstfakturaid,
   verskostfreigrundid,
   auftrnr_key,
   auftrpos,
   fakturaidumsatz_key,
   fakturaidumsatz,
   prozessidletztaend,
   erstfakturaidumsatz_key,
   erstfakturaidumsatz,
   marketingpartnernr,
   alfa_artliefid,  
   komwarenwert  
)
VALUES
(
   &gbvid,
   id_key,
   kundeid_key,
   kundenfirmaid,
   vertrgebietid,
   auftridentnr_key,
--   auftridentnr,
   lfdartposnr,
   terminwunschdat,
   sendkompldat,
   zahlmethodeid,
   zahlwunschid,
   ezvtransaktionid_key,
--   ezvtransaktionid,
   bestartnrbestand,
   bestartgrbestand,
   faktartnr,
   faktartgr,
   auftrag_positionstatusid,
   auftragposid_key,
   auftrag_anlaufwegid,
   faktura_abwicklunggrpid,
   faktura_sendungid_key,   
   faktura_sendungid,
   auftrag_postypid,
   auftrag_bestandstatusid,
   nalieinspdat,
   anldat,
   benutzeridanl,
   benutzeridletztaend,
   prozessidanl,
   bestkomartnr,
   bestkomartgr,
   bestkomprom,
   faktkomartnr,
   faktkomartgr,
   faktkomprom,
   faktprom,
   laengemeterware,
   faktmwstid,
   erstfakturierlaufstartdat,
   verswunschid,
   alfa_ersatzartid,
   nalifreilaufdat,
   nalikdinfodat,
   faktbetrag,
   kolliid,
   auftrag_auftragpoolid_key,
   gutscheindatenid_key,
   gutscheindatenid,   
   liefanschrid_key,
   auftrag_positionstatusidersthg,
   auftrag_fehlertypid,
   auftrag_freigabestatusid,
   bestdat,
   neukundekz,
   lieferwunschid,
   auftrag_erskdwunschid,
   faktura_abschreibungstatusid,
   liefauskunftidakt,
   liefauskunftidkom,
   auftragkopfid_key,
   alfa_grvtid,
   letztexportdatbaur,
   auftrag_loartikeltypid,
   erstfakturaid_key,
   erstfakturaid,
   verskostfreigrundid,
   auftrnr_key,
   auftrpos,
   fakturaidumsatz_key,
   fakturaidumsatz,
   prozessidletztaend,
   erstfakturaidumsatz_key,
   erstfakturaidumsatz,
   marketingpartnernr,
   alfa_artliefid,  
   komwarenwert     
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_auftrag_auftpool_d
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
   kundenfirmaid,
   vertrgebietid,
   auftridentnr_key,
--   auftridentnr,
   lfdartposnr,
   terminwunschdat,
   sendkompldat,
   zahlmethodeid,
   zahlwunschid,
   ezvtransaktionid_key,
--   ezvtransaktionid,
   bestartnrbestand,
   bestartgrbestand,
   faktartnr,
   faktartgr,
   auftrag_positionstatusid,
   auftragposid_key,
   auftrag_anlaufwegid,
   faktura_abwicklunggrpid,
   faktura_sendungid_key,   
   faktura_sendungid,
   auftrag_postypid,
   auftrag_bestandstatusid,
   nalieinspdat,
   anldat,
   benutzeridanl,
   benutzeridletztaend,
   prozessidanl,
   bestkomartnr,
   bestkomartgr,
   bestkomprom,
   faktkomartnr,
   faktkomartgr,
   faktkomprom,
   faktprom,
   laengemeterware,
   faktmwstid,
   erstfakturierlaufstartdat,
   verswunschid,
   alfa_ersatzartid,
   nalifreilaufdat,
   nalikdinfodat,
   faktbetrag,
   kolliid,
   auftrag_auftragpoolid_key,
   gutscheindatenid_key,
   gutscheindatenid,   
   liefanschrid_key,
   auftrag_positionstatusidersthg,
   auftrag_fehlertypid,
   auftrag_freigabestatusid,
   bestdat,
   neukundekz,
   lieferwunschid,
   auftrag_erskdwunschid,
   faktura_abschreibungstatusid,
   liefauskunftidakt,
   liefauskunftidkom,
   auftragkopfid_key,
   alfa_grvtid,
   letztexportdatbaur,
   auftrag_loartikeltypid,
   erstfakturaid_key,
   erstfakturaid,
   verskostfreigrundid,
   auftrnr_key,
   auftrpos,
   fakturaidumsatz_key,
   fakturaidumsatz,
   prozessidletztaend,
   erstfakturaidumsatz_key,
   erstfakturaidumsatz,
   marketingpartnernr,
   alfa_artliefid,  
   komwarenwert     
FROM st_ww_auftrag_auftpool_b
WHERE dwh_processdate = &termin;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  1.3 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_auftrag_auftpool_1');
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_auftrag_auftpool_d');
 
 
 
PROMPT ===========================================
PROMPT  1.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING ('clsc_ww_auftrag_auftpool', 'id_key', &gbvid);
 
 
 
PROMPT ===========================================
PROMPT  1.5 Einspielen in die letzte SC-Tabelle mit Referenzauflösung
PROMPT ===========================================
 
INSERT /*+ APPEND */ FIRST
WHEN (dwh_id_sc_ww_kundenfirma IS NULL 
   OR dwh_id_sc_ww_vertrgebiet IS NULL 
   OR dwh_id_sc_ww_zahlmethode IS NULL 
   OR dwh_id_sc_ww_zahlwunsch IS NULL  
   OR dwh_id_sc_ww_auftrag_posstat IS NULL  
   OR dwh_id_sc_ww_auftrag_anlweg IS NULL 
   OR dwh_id_sc_ww_auftrag_postyp IS NULL 
   OR dwh_id_sc_ww_auftrag_bestandstat IS NULL    
   OR dwh_id_sc_ww_benutzeranl IS NULL 
   OR dwh_id_sc_ww_prozessanl IS NULL  
   OR dwh_id_sc_ww_mwst IS NULL 
   OR dwh_id_sc_ww_verswunsch IS NULL     
   OR dwh_id_sc_ww_auftrag_posstat1 IS NULL 
   OR dwh_id_sc_ww_auftrag_fehlertyp IS NULL    
   OR DWH_ID_SC_WW_AUFTRAG_FREIGABSTAT IS NULL 
   OR dwh_id_sc_ww_neukundekz IS NULL 
   OR dwh_id_sc_ww_lieferwunsch IS NULL 
   OR dwh_id_sc_ww_auftrag_erskdwunsch IS NULL    
   OR dwh_id_sc_ww_liefauskunftakt IS NULL
   OR dwh_id_sc_ww_liefauskunftkom IS NULL            
   OR dwh_id_sc_ww_auftrag_loarttyp IS NULL      
   OR dwh_id_sc_ww_verskostfreigrund IS NULL   
   OR dwh_id_sc_ww_prozessletztaend IS NULL   
) THEN
INTO clsc_ww_auftrag_auftpool_e
(
   dwh_cr_load_id,
   dwh_up_load_id,   
   dwh_id_sc_ww_kundenfirma,
   dwh_id_sc_ww_vertrgebiet,
   dwh_id_sc_ww_zahlmethode,
   dwh_id_sc_ww_zahlwunsch,
   dwh_id_sc_ww_auftrag_posstat,
   dwh_id_sc_ww_auftrag_anlweg,
   dwh_id_sc_ww_auftrag_postyp,
   dwh_id_sc_ww_auftrag_bestandstat,   
   dwh_id_sc_ww_benutzeranl,
   dwh_id_sc_ww_prozessanl,      
   dwh_id_sc_ww_mwst,
   dwh_id_sc_ww_verswunsch,
   dwh_id_sc_ww_auftrag_posstat1,   
   dwh_id_sc_ww_auftrag_fehlertyp,   
   DWH_ID_SC_WW_AUFTRAG_FREIGABSTAT,
   dwh_id_sc_ww_neukundekz,
   dwh_id_sc_ww_lieferwunsch,
   dwh_id_sc_ww_auftrag_erskdwunsch,
   dwh_id_sc_ww_liefauskunftakt,
   dwh_id_sc_ww_liefauskunftkom,         
   dwh_id_sc_ww_auftrag_loarttyp,         
   dwh_id_sc_ww_verskostfreigrund, 
   dwh_id_sc_ww_prozessletztaend,
   id_key,
   kundeid_key,
   kundenfirmaid,
   vertrgebietid,
   auftridentnr_key,
--   auftridentnr,
   lfdartposnr,
   terminwunschdat,
   sendkompldat,
   zahlmethodeid,
   zahlwunschid,
   ezvtransaktionid_key,
--   ezvtransaktionid,
   bestartnrbestand,
   bestartgrbestand,
   faktartnr,
   faktartgr,
   auftrag_positionstatusid,
   auftragposid_key,
   auftrag_anlaufwegid,
   faktura_abwicklunggrpid,
   faktura_sendungid_key,   
   faktura_sendungid,
   auftrag_postypid,
   auftrag_bestandstatusid,
   nalieinspdat,
   anldat,
   benutzeridanl,
   benutzeridletztaend,
   prozessidanl,
   bestkomartnr,
   bestkomartgr,
   bestkomprom,
   faktkomartnr,
   faktkomartgr,
   faktkomprom,
   faktprom,
   laengemeterware,
   faktmwstid,
   erstfakturierlaufstartdat,
   verswunschid,
   alfa_ersatzartid,
   nalifreilaufdat,
   nalikdinfodat,
   faktbetrag,
   kolliid,
   auftrag_auftragpoolid_key,
   gutscheindatenid_key,
   gutscheindatenid,   
   liefanschrid_key,
   auftrag_positionstatusidersthg,
   auftrag_fehlertypid,
   auftrag_freigabestatusid,
   bestdat,
   neukundekz,
   lieferwunschid,
   auftrag_erskdwunschid,
   faktura_abschreibungstatusid,
   liefauskunftidakt,
   liefauskunftidkom,
   auftragkopfid_key,
   alfa_grvtid,
   letztexportdatbaur,
   auftrag_loartikeltypid,
   erstfakturaid_key,
   erstfakturaid,
   verskostfreigrundid,
   auftrnr_key,
   auftrpos,
   fakturaidumsatz_key,
   fakturaidumsatz,
   prozessidletztaend,
   erstfakturaidumsatz_key,
   erstfakturaidumsatz,
   marketingpartnernr,
   alfa_artliefid,  
   komwarenwert    
)
VALUES
(
   dwh_cr_load_id,
   &gbvid,
   dwh_id_sc_ww_kundenfirma,
   dwh_id_sc_ww_vertrgebiet,
   dwh_id_sc_ww_zahlmethode,
   dwh_id_sc_ww_zahlwunsch,
   dwh_id_sc_ww_auftrag_posstat,
   dwh_id_sc_ww_auftrag_anlweg,
   dwh_id_sc_ww_auftrag_postyp,
   dwh_id_sc_ww_auftrag_bestandstat,   
   dwh_id_sc_ww_benutzeranl,
   dwh_id_sc_ww_prozessanl,      
   dwh_id_sc_ww_mwst,
   dwh_id_sc_ww_verswunsch,
   dwh_id_sc_ww_auftrag_posstat1,
   dwh_id_sc_ww_auftrag_fehlertyp,   
   DWH_ID_SC_WW_AUFTRAG_FREIGABSTAT,
   dwh_id_sc_ww_neukundekz,
   dwh_id_sc_ww_lieferwunsch,
   dwh_id_sc_ww_auftrag_erskdwunsch,   
   dwh_id_sc_ww_liefauskunftakt,
   dwh_id_sc_ww_liefauskunftkom,            
   dwh_id_sc_ww_auftrag_loarttyp,      
   dwh_id_sc_ww_verskostfreigrund, 
   dwh_id_sc_ww_prozessletztaend,
   id_key,
   kundeid_key,
   kundenfirmaid,
   vertrgebietid,
   auftridentnr_key,
--   auftridentnr,
   lfdartposnr,
   terminwunschdat,
   sendkompldat,
   zahlmethodeid,
   zahlwunschid,
   ezvtransaktionid_key,
--   ezvtransaktionid,
   bestartnrbestand,
   bestartgrbestand,
   faktartnr,
   faktartgr,
   auftrag_positionstatusid,
   auftragposid_key,
   auftrag_anlaufwegid,
   faktura_abwicklunggrpid,
   faktura_sendungid_key,   
   faktura_sendungid,
   auftrag_postypid,
   auftrag_bestandstatusid,
   nalieinspdat,
   anldat,
   benutzeridanl,
   benutzeridletztaend,
   prozessidanl,
   bestkomartnr,
   bestkomartgr,
   bestkomprom,
   faktkomartnr,
   faktkomartgr,
   faktkomprom,
   faktprom,
   laengemeterware,
   faktmwstid,
   erstfakturierlaufstartdat,
   verswunschid,
   alfa_ersatzartid,
   nalifreilaufdat,
   nalikdinfodat,
   faktbetrag,
   kolliid,
   auftrag_auftragpoolid_key,
   gutscheindatenid_key,
   gutscheindatenid,   
   liefanschrid_key,
   auftrag_positionstatusidersthg,
   auftrag_fehlertypid,
   auftrag_freigabestatusid,
   bestdat,
   neukundekz,
   lieferwunschid,
   auftrag_erskdwunschid,
   faktura_abschreibungstatusid,
   liefauskunftidakt,
   liefauskunftidkom,
   auftragkopfid_key,
   alfa_grvtid,
   letztexportdatbaur,
   auftrag_loartikeltypid,
   erstfakturaid_key,
   erstfakturaid,
   verskostfreigrundid,
   auftrnr_key,
   auftrpos,
   fakturaidumsatz_key,
   fakturaidumsatz,
   prozessidletztaend,
   erstfakturaidumsatz_key,
   erstfakturaidumsatz,
   marketingpartnernr,
   alfa_artliefid,  
   komwarenwert     
)
ELSE
INTO clsc_ww_auftrag_auftpool
(
   dwh_cr_load_id,
   dwh_id_sc_ww_kundenfirma,
   dwh_id_sc_ww_vertrgebiet,
   dwh_id_sc_ww_zahlmethode,
   dwh_id_sc_ww_zahlwunsch,
   dwh_id_sc_ww_auftrag_posstat,
   dwh_id_sc_ww_auftrag_anlweg,
   dwh_id_sc_ww_auftrag_postyp,
   dwh_id_sc_ww_auftrag_bestandstat,   
   dwh_id_sc_ww_benutzeranl,
   dwh_id_sc_ww_prozessanl,      
   dwh_id_sc_ww_mwst,
   dwh_id_sc_ww_verswunsch,
   dwh_id_sc_ww_auftrag_posstat1,
   dwh_id_sc_ww_auftrag_fehlertyp,   
   DWH_ID_SC_WW_AUFTRAG_FREIGABSTAT,
   dwh_id_sc_ww_neukundekz,
   dwh_id_sc_ww_lieferwunsch,
   dwh_id_sc_ww_auftrag_erskdwunsch,
   dwh_id_sc_ww_liefauskunftakt,
   dwh_id_sc_ww_liefauskunftkom,        
   dwh_id_sc_ww_auftrag_loarttyp,      
   dwh_id_sc_ww_verskostfreigrund,   
   dwh_id_sc_ww_prozessletztaend,
   id_key,
   kundeid_key,
   kundenfirmaid,
   vertrgebietid,
   auftridentnr_key,
--   auftridentnr,
   lfdartposnr,
   terminwunschdat,
   sendkompldat,
   zahlmethodeid,
   zahlwunschid,
   ezvtransaktionid_key,
--   ezvtransaktionid,
   bestartnrbestand,
   bestartgrbestand,
   faktartnr,
   faktartgr,
   auftrag_positionstatusid,
   auftragposid_key,
   auftrag_anlaufwegid,
   faktura_abwicklunggrpid,
   faktura_sendungid_key,   
   faktura_sendungid,
   auftrag_postypid,
   auftrag_bestandstatusid,
   nalieinspdat,
   anldat,
   benutzeridanl,
   benutzeridletztaend,
   prozessidanl,
   bestkomartnr,
   bestkomartgr,
   bestkomprom,
   faktkomartnr,
   faktkomartgr,
   faktkomprom,
   faktprom,
   laengemeterware,
   faktmwstid,
   erstfakturierlaufstartdat,
   verswunschid,
   alfa_ersatzartid,
   nalifreilaufdat,
   nalikdinfodat,
   faktbetrag,
   kolliid,
   auftrag_auftragpoolid_key,
   gutscheindatenid_key,
   gutscheindatenid,   
   liefanschrid_key,
   auftrag_positionstatusidersthg,
   auftrag_fehlertypid,
   auftrag_freigabestatusid,
   bestdat,
   neukundekz,
   lieferwunschid,
   auftrag_erskdwunschid,
   faktura_abschreibungstatusid,
   liefauskunftidakt,
   liefauskunftidkom,
   auftragkopfid_key,
   alfa_grvtid,
   letztexportdatbaur,
   auftrag_loartikeltypid,
   erstfakturaid_key,
   erstfakturaid,
   verskostfreigrundid,
   auftrnr_key,
   auftrpos,
   fakturaidumsatz_key,
   fakturaidumsatz,
   prozessidletztaend,
   erstfakturaidumsatz_key,
   erstfakturaidumsatz,   
   marketingpartnernr,
   alfa_artliefid,  
   komwarenwert    
)
SELECT
   a.dwh_cr_load_id,
   sc_ww_kundenfirma.dwh_id AS dwh_id_sc_ww_kundenfirma,
   sc_ww_vertrgebiet.dwh_id AS dwh_id_sc_ww_vertrgebiet,
   sc_ww_zahlmethode.dwh_id AS dwh_id_sc_ww_zahlmethode,
   sc_ww_zahlwunsch.dwh_id AS dwh_id_sc_ww_zahlwunsch,
   sc_ww_auftrag_posstat.dwh_id AS dwh_id_sc_ww_auftrag_posstat,
   sc_ww_auftrag_anlweg.dwh_id AS dwh_id_sc_ww_auftrag_anlweg,
   sc_ww_auftrag_postyp.dwh_id AS dwh_id_sc_ww_auftrag_postyp,
   sc_ww_auftrag_bestandstat.dwh_id AS dwh_id_sc_ww_auftrag_bestandstat,
   sc_ww_benutzeranl.dwh_id AS dwh_id_sc_ww_benutzeranl,
   sc_ww_prozessanl.dwh_id AS dwh_id_sc_ww_prozessanl,   
   sc_ww_mwst.dwh_id AS dwh_id_sc_ww_mwst,
   sc_ww_verswunsch.dwh_id AS dwh_id_sc_ww_verswunsch,
   sc_ww_auftrag_posstat1.dwh_id AS dwh_id_sc_ww_auftrag_posstat1,
   sc_ww_auftrag_fehlertyp.dwh_id AS dwh_id_sc_ww_auftrag_fehlertyp,
   sc_ww_auftrag_freigabstat.dwh_id AS DWH_ID_SC_WW_AUFTRAG_FREIGABSTAT,
   sc_ww_neukundekz.dwh_id AS dwh_id_sc_ww_neukundekz,
   sc_ww_lieferwunsch.dwh_id AS dwh_id_sc_ww_lieferwunsch,
   sc_ww_auftrag_erskdwunsch.dwh_id AS dwh_id_sc_ww_auftrag_erskdwunsch,   
   sc_ww_liefauskunftakt.dwh_id AS dwh_id_sc_ww_liefauskunftakt,
   sc_ww_liefauskunftkom.dwh_id AS dwh_id_sc_ww_liefauskunftkom,         
   sc_ww_auftrag_loarttyp.dwh_id AS dwh_id_sc_ww_auftrag_loarttyp,      
   sc_ww_verskostfreigrund.dwh_id AS dwh_id_sc_ww_verskostfreigrund,   
   sc_ww_prozessletztaend.dwh_id AS dwh_id_sc_ww_prozessletztaend,
   a.id_key AS id_key,   
   a.kundeid_key AS kundeid_key,
   a.kundenfirmaid AS kundenfirmaid,
   a.vertrgebietid AS vertrgebietid,
   a.auftridentnr_key AS auftridentnr_key,
--   a.auftridentnr AS auftridentnr,   
   a.lfdartposnr AS lfdartposnr,
   a.terminwunschdat AS terminwunschdat,
   a.sendkompldat AS sendkompldat,
   a.zahlmethodeid AS zahlmethodeid,
   a.zahlwunschid AS zahlwunschid,
   a.ezvtransaktionid_key AS ezvtransaktionid_key,
--   a.ezvtransaktionid AS ezvtransaktionid,   
   a.bestartnrbestand AS bestartnrbestand,
   a.bestartgrbestand AS bestartgrbestand,
   a.faktartnr AS faktartnr,
   a.faktartgr AS faktartgr,
   a.auftrag_positionstatusid AS auftrag_positionstatusid,
   a.auftragposid_key AS auftragposid_key,
   a.auftrag_anlaufwegid AS auftrag_anlaufwegid,
   a.faktura_abwicklunggrpid AS faktura_abwicklunggrpid,
   a.faktura_sendungid_key AS faktura_sendungid_key,
   a.faktura_sendungid AS faktura_sendungid,
   a.auftrag_postypid AS auftrag_postypid,
   a.auftrag_bestandstatusid AS auftrag_bestandstatusid,
   a.nalieinspdat AS nalieinspdat,
   a.anldat AS anldat,
   a.benutzeridanl AS benutzeridanl,
   a.benutzeridletztaend AS benutzeridletztaend,
   a.prozessidanl AS prozessidanl,
   a.bestkomartnr AS bestkomartnr,
   a.bestkomartgr AS bestkomartgr,
   a.bestkomprom AS bestkomprom,
   a.faktkomartnr AS faktkomartnr,
   a.faktkomartgr AS faktkomartgr,
   a.faktkomprom AS faktkomprom,
   a.faktprom AS faktprom,
   a.laengemeterware AS laengemeterware,
   a.faktmwstid AS faktmwstid,
   a.erstfakturierlaufstartdat AS erstfakturierlaufstartdat,
   a.verswunschid AS verswunschid,
   a.alfa_ersatzartid AS alfa_ersatzartid,
   a.nalifreilaufdat AS nalifreilaufdat,
   a.nalikdinfodat AS nalikdinfodat,
   a.faktbetrag AS faktbetrag,
   a.kolliid AS kolliid,
   a.auftrag_auftragpoolid_key AS auftrag_auftragpoolid_key,
   a.gutscheindatenid_key AS gutscheindatenid_key,
   a.gutscheindatenid AS gutscheindatenid,
   a.liefanschrid_key AS liefanschrid_key,
   a.auftrag_positionstatusidersthg AS auftrag_positionstatusidersthg,
   a.auftrag_fehlertypid AS auftrag_fehlertypid,
   a.auftrag_freigabestatusid AS auftrag_freigabestatusid,
   a.bestdat AS bestdat,
   a.neukundekz AS neukundekz,
   a.lieferwunschid AS lieferwunschid,
   a.auftrag_erskdwunschid AS auftrag_erskdwunschid,
   a.faktura_abschreibungstatusid AS faktura_abschreibungstatusid,   
   a.liefauskunftidakt AS liefauskunftidakt,   
   a.liefauskunftidkom AS liefauskunftidkom,   
   a.auftragkopfid_key AS auftragkopfid_key,      
   a.alfa_grvtid AS alfa_grvtid,      
   a.letztexportdatbaur AS letztexportdatbaur,      
   a.auftrag_loartikeltypid AS auftrag_loartikeltypid,      
   a.erstfakturaid_key AS erstfakturaid_key,
   a.erstfakturaid AS erstfakturaid,
   a.verskostfreigrundid AS verskostfreigrundid,
   a.auftrnr_key AS auftrnr_key,
   a.auftrpos AS auftrpos,      
   a.fakturaidumsatz_key AS fakturaidumsatz_key,
   a.fakturaidumsatz AS fakturaidumsatz,
   a.prozessidletztaend AS prozessidletztaend,
   a.erstfakturaidumsatz_key AS erstfakturaidumsatz_key,
   a.erstfakturaidumsatz AS erstfakturaidumsatz,
   a.marketingpartnernr AS marketingpartnernr,
   a.alfa_artliefid AS alfa_artliefid,
   a.komwarenwert AS komwarenwert   
FROM clsc_ww_auftrag_auftpool_1 a
  LEFT OUTER JOIN (SELECT sc_ww_kundenfirma.dwh_id, sc_ww_kundenfirma.id FROM sc_ww_kundenfirma)  sc_ww_kundenfirma
      ON (a.kundenfirmaid = sc_ww_kundenfirma.id)
  LEFT OUTER JOIN (SELECT sc_ww_vertrgebiet.dwh_id, sc_ww_vertrgebiet.id FROM sc_ww_vertrgebiet)  sc_ww_vertrgebiet
      ON (a.vertrgebietid = sc_ww_vertrgebiet.id)
  LEFT OUTER JOIN (SELECT sc_ww_zahlmethode.dwh_id, sc_ww_zahlmethode.id FROM sc_ww_zahlmethode)  sc_ww_zahlmethode
      ON (COALESCE(a.zahlmethodeid,'$') = sc_ww_zahlmethode.id)
  LEFT OUTER JOIN (SELECT sc_ww_zahlwunsch.dwh_id, sc_ww_zahlwunsch.id FROM sc_ww_zahlwunsch)  sc_ww_zahlwunsch
      ON (COALESCE(a.zahlwunschid,'$') = sc_ww_zahlwunsch.id)
  LEFT OUTER JOIN (SELECT sc_ww_auftrag_posstat.dwh_id, sc_ww_auftrag_posstat.id FROM sc_ww_auftrag_posstat)  sc_ww_auftrag_posstat
      ON (a.auftrag_positionstatusid = sc_ww_auftrag_posstat.id)
  LEFT OUTER JOIN (SELECT sc_ww_auftrag_anlweg.dwh_id, sc_ww_auftrag_anlweg.id FROM sc_ww_auftrag_anlweg)  sc_ww_auftrag_anlweg
      ON (a.auftrag_anlaufwegid = sc_ww_auftrag_anlweg.id)
  LEFT OUTER JOIN (SELECT sc_ww_auftrag_postyp.dwh_id, sc_ww_auftrag_postyp.id FROM sc_ww_auftrag_postyp)  sc_ww_auftrag_postyp
      ON (a.auftrag_postypid = sc_ww_auftrag_postyp.id)
  LEFT OUTER JOIN (SELECT sc_ww_auftrag_bestandstat.dwh_id, sc_ww_auftrag_bestandstat.id FROM sc_ww_auftrag_bestandstat)  sc_ww_auftrag_bestandstat
      ON (a.auftrag_bestandstatusid = sc_ww_auftrag_bestandstat.id)
  LEFT OUTER JOIN (SELECT sc_ww_benutzeranl.dwh_id, sc_ww_benutzeranl.id FROM sc_ww_benutzeranl)  sc_ww_benutzeranl
      ON (a.benutzeridanl = sc_ww_benutzeranl.id)    
  LEFT OUTER JOIN (SELECT sc_ww_prozessanl.dwh_id, sc_ww_prozessanl.id FROM sc_ww_prozessanl)  sc_ww_prozessanl
      ON (a.prozessidanl = sc_ww_prozessanl.id)      
  LEFT OUTER JOIN (SELECT sc_ww_mwst.dwh_id, sc_ww_mwst.id FROM sc_ww_mwst)  sc_ww_mwst
      ON (COALESCE(a.faktmwstid,'$') = sc_ww_mwst.id)
  LEFT OUTER JOIN (SELECT sc_ww_verswunsch.dwh_id, sc_ww_verswunsch.id FROM sc_ww_verswunsch)  sc_ww_verswunsch
      ON (a.verswunschid = sc_ww_verswunsch.id)
  LEFT OUTER JOIN (SELECT sc_ww_auftrag_posstat.dwh_id, sc_ww_auftrag_posstat.id FROM sc_ww_auftrag_posstat)  sc_ww_auftrag_posstat1
      ON (COALESCE(a.auftrag_positionstatusidersthg,'$') = sc_ww_auftrag_posstat1.id)
  LEFT OUTER JOIN (SELECT sc_ww_auftrag_fehlertyp.dwh_id, sc_ww_auftrag_fehlertyp.id FROM sc_ww_auftrag_fehlertyp)  sc_ww_auftrag_fehlertyp
      ON (COALESCE(a.auftrag_fehlertypid,'$') = sc_ww_auftrag_fehlertyp.id)
  LEFT OUTER JOIN (SELECT sc_ww_auftrag_freigabstat.dwh_id, sc_ww_auftrag_freigabstat.id FROM sc_ww_auftrag_freigabstat)  sc_ww_auftrag_freigabstat
      ON (COALESCE(a.auftrag_freigabestatusid,'$') = sc_ww_auftrag_freigabstat.id)
  LEFT OUTER JOIN (SELECT sc_ww_neukundekz.dwh_id, sc_ww_neukundekz.wert FROM sc_ww_neukundekz)  sc_ww_neukundekz
      ON (COALESCE(a.neukundekz,-3) = sc_ww_neukundekz.wert)
  LEFT OUTER JOIN (SELECT sc_ww_lieferwunsch.dwh_id, sc_ww_lieferwunsch.id FROM sc_ww_lieferwunsch)  sc_ww_lieferwunsch
      ON (COALESCE(a.lieferwunschid,'$') = sc_ww_lieferwunsch.id)
  LEFT OUTER JOIN (SELECT sc_ww_auftrag_erskdwunsch.dwh_id, sc_ww_auftrag_erskdwunsch.id FROM sc_ww_auftrag_erskdwunsch)  sc_ww_auftrag_erskdwunsch
      ON (COALESCE(a.auftrag_erskdwunschid,'$') = sc_ww_auftrag_erskdwunsch.id)
  LEFT OUTER JOIN (SELECT sc_ww_liefauskunftakt.dwh_id, sc_ww_liefauskunftakt.id FROM sc_ww_liefauskunftakt)  sc_ww_liefauskunftakt
      ON (COALESCE(a.liefauskunftidakt,'$') = sc_ww_liefauskunftakt.id)          -- am 07.02 neu in Stage eingebaut und mit § gesetzt. Ab da auch NULL-Werte vorhanden.       
  LEFT OUTER JOIN (SELECT sc_ww_liefauskunftkom.dwh_id, sc_ww_liefauskunftkom.id FROM sc_ww_liefauskunftkom)  sc_ww_liefauskunftkom
      ON (COALESCE(a.liefauskunftidkom,'$') = sc_ww_liefauskunftkom.id)          -- am 07.02 neu in Stage eingebaut und mit § gesetzt. Ab da auch NULL-Werte vorhanden.      
  LEFT OUTER JOIN (SELECT sc_ww_auftrag_loarttyp.dwh_id, sc_ww_auftrag_loarttyp.id FROM sc_ww_auftrag_loarttyp)  sc_ww_auftrag_loarttyp
      ON (COALESCE(a.auftrag_loartikeltypid,'$') = sc_ww_auftrag_loarttyp.id)    -- am 07.02 neu in Stage eingebaut und mit § gesetzt. Ab da auch NULL-Werte vorhanden.                
  LEFT OUTER JOIN (SELECT sc_ww_verskostfreigrund.dwh_id, sc_ww_verskostfreigrund.id FROM sc_ww_verskostfreigrund)  sc_ww_verskostfreigrund
      ON (COALESCE(a.verskostfreigrundid,'§') = sc_ww_verskostfreigrund.id)
  LEFT OUTER JOIN (SELECT sc_ww_prozessletztaend.dwh_id, sc_ww_prozessletztaend.id FROM sc_ww_prozessletztaend)  sc_ww_prozessletztaend
      ON (COALESCE(a.prozessidletztaend,'$') = sc_ww_prozessletztaend.id);    
      
      
      -- zum Stand 17.02.2017 immer leer. Bei erster Befuellung, pruefen, ob NULL-Werte erlaubt sind, wenn ja mit $ ersetzen.
 
COMMIT;
 
PROMPT ===========================================
PROMPT  1.6 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_auftrag_auftpool');
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_auftrag_auftpool_e');




PROMPT =========================================================================
PROMPT
PROMPT 2. Source Core-Ladung
PROMPT Endtabelle: sc_ww_auftrag_auftpool_liefauskunft_ergebnisid / sc_ww_auftrag_auftpool_liefauskunft_ergebnisid_ver
PROMPT
PROMPT =========================================================================
 
 
 
PROMPT ===========================================
PROMPT  2.1 Cleansing Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clsc_ww_auftrag_auftpool_liefauskunft_ergebnisid;
TRUNCATE TABLE clsc_ww_auftrag_auftpool_liefauskunft_ergebnisid_1;
TRUNCATE TABLE clsc_ww_auftrag_auftpool_liefauskunft_ergebnisid_d;
 
 
 
PROMPT ===========================================
PROMPT  2.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_auftrag_auftpool_liefauskunft_ergebnisid_1
(
   dwh_cr_load_id,
   id_key,
   liefauskunft_ergebnisid
)
VALUES
(
   &gbvid,
   id_key,
   liefauskunft_ergebnisid
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_auftrag_auftpool_liefauskunft_ergebnisid_d
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
   liefauskunft_ergebnisid
FROM st_ww_auftrag_auftpool_liefauskunft_ergebnisid_b
WHERE dwh_processdate = &termin;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  2.3 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_auftrag_auftpool_liefauskunft_ergebnisid_1');
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_auftrag_auftpool_liefauskunft_ergebnisid_d');
 
 
  
PROMPT ===========================================
PROMPT  2.4 Einspielen in die letzte SC-Tabelle ohne Referenzauflösung
PROMPT ===========================================
 
INSERT /*+ APPEND */ 
INTO clsc_ww_auftrag_auftpool_liefauskunft_ergebnisid
(
   dwh_cr_load_id,
   id_key,
   liefauskunft_ergebnisid
)
SELECT
   a.dwh_cr_load_id,
   a.id_key AS id_key,   
   a.liefauskunft_ergebnisid AS liefauskunft_ergebnisid
FROM clsc_ww_auftrag_auftpool_liefauskunft_ergebnisid_1 a;
      
     
 
COMMIT;
 
PROMPT ===========================================
PROMPT  2.5 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_auftrag_auftpool_liefauskunft_ergebnisid');