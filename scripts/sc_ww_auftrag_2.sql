/*****************************************************************************

Job:              sc_ww_auftrag_2
Beschreibung:     Ladung der der Smaragd-Auftragspositionen ins Source-Core
                  Start der Ladung ab 05.01.2015 01:00
                  Altdaten werden manuell ins SC eingespielt
                  
          
Erstellt am:        17.11.2016
Erstellt von:       Andrea Gagulic       
Ansprechpartner:    Andrea Gagulic    
Ansprechpartner-IT: Thomas Hösl

verwendete Tabellen:  st_ww_auftragpos_b 
                      st_ww_auftragsperre_b
                      sc_ww_zahlwunschkz
                      sc_ww_artkatkz
                      sc_ww_artmgeinhkz   
                      sc_ww_ersarttypkz
                      sc_ww_ersartkdwukz                   
                      sc_ww_aktliefstat
                      sc_ww_komliefstat
                      sc_ww_posfehlerkz
                      sc_ww_auftrstornokz
                      sc_ww_valkz
                      sc_ww_zugestartartkz
                      sc_ww_ratenaufschlag
                      sc_ww_auftragkopf
                      sc_ww_valutaaktion
                      sc_ww_hvermerkkz
                      sc_ww_lokz
                      sc_ww_posstatkz
                      sc_ww_faktstatkz
                      sc_ww_nalistatkz
                      sc_ww_vertrgebiet
                      sc_ww_lvfehlkz
                      sc_ww_naligauftgrukz
                      sc_ww_naliaktionkz
                      sc_ww_nalispesenfreikz
                      sc_ww_zahlmethode
                      sc_ww_zahlwunsch
                      sc_ww_naligauftfehlkz
                      sc_ww_alfa_ersart
                      sc_ww_mwst
                      sc_ww_prozessletztaend
                      sc_ww_auftrsperrverw
                      sc_ww_benutzer
                      sc_ww_prozessanl
                      sc_ww_benutzergeklaert
                      sc_ww_prozessgeklaert
                      
                                             
Endtabellen:          sc_ww_auftragpos
                      sc_ww_auftragpos_ver
                      sc_ww_auftragsperre
                      sc_ww_auftragsperre_ver

Fehler-Doku:      
Ladestrecke:          https://confluence.witt-gruppe.eu/display/IM/Auftrag

Startbedingungen: KDWH.SC_WW_AUFTRAG_TEST_1
                  UDWH1.SC_WW_AUFTRAG_TEST_1

********************************************************************************
geändert am:          22.03.2018
geändert von:         joeabd
Änderungen:           ##.1: Auftragsperre hinzugefügt
********************************************************************************
geändert am:          19.04.2018
geändert von:         elifal
Änderungen:           ##.2:Umzug Alfa-Datenmodell auf UDWH, deshalb DB-Link @udwht2 bei sc_ww_alfa_ersatzart entfernt.
********************************************************************************
geändert am:          24.08.2018
geändert von:         andgag
Änderungen:           ##.2: auftragpos: neue Spalten komwarenwert, 
                            auftragposidref eingebaut
********************************************************************************
geändert am:          12.10.2018
geändert von:         maxlin   
Aenderungen:          ##.4: Anpassungen an Clearingstelle
********************************************************************************
geändert am:          06.12.2019
geändert von:         andgag   
Aenderungen:          ##.4: Fehlerkorrektur: Auftrposidentnr fehlte in Auftragpos
********************************************************************************
geändert am:          03.11.2020
geändert von:         tetfra   
Aenderungen:          ##.5: Spalte dwh_id_sc_ww_naliaktionkz umbenannt in 
                            dwh_id_sc_ww_naliaktionkz_host. 
                            Tabelle sc_ww_auftragpos_ver
********************************************************************************
geändert am:          23.09.2021
geändert von:         tetfra   
Aenderungen:          ##.6: Benutzer wird bei NULL auf -3 gemappt 
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
PROMPT Endtabelle: sc_ww_auftragpos / sc_ww_auftragpos_ver
PROMPT
PROMPT =========================================================================
 
 
 
PROMPT ===========================================
PROMPT  1.1 Cleansing Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clsc_ww_auftragpos;
TRUNCATE TABLE clsc_ww_auftragpos_1;
TRUNCATE TABLE clsc_ww_auftragpos_d;
 
 
 
PROMPT ===========================================
PROMPT  1.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_auftragpos_1
(
   dwh_cr_load_id,
   id_key,
   id,
   katart,
   bestartgr,
   bestartnr,
   bestartprom,
   bestartsaison,
   bestartvk,
   bestmg,
   bestliefdat,
   ersartgr,
   ersartnr,
   ersartprom,
   ersartvk,
   letztaenddat,
   lfdartposnr,
   liefdat,
   komlieftermin,
   mwstbetr,
   mwstproz,
   zahlwunschkz,
   erfpreis,
   erfseite,
   artkatkz,
   artmgeinhkz,
   ersarttypkz,
   ersartkdwunschkz,
   aktliefstatkz,
   komliefstatkz,
   posfehlerkz,
   auftrstornokz,
   valkz,
   zugestartartkz,
   ratenaufschlagid,
   rataufschlag,
   auftragkopfid_key,
   usernrletztaend,
   lagerortid,
   versandortid,
   valutaaktionid,
   bestartgrbestand,
   ersartgrbestand,
   letztexportdat,
   hvermerkkz,
   userletztaend,
   anwgrpkzletztaend,
   benutzeridletztaend,
   auftrposidentnr,
   auftrnr_key,
   auftrpos,
   artbez,
   artfarbe,
   ersartbez,
   ersartfarb,
   lokz,
   posstatkz,
   faktstatkz,
   letztfaktabgldat,
   nalistatkz,
   faktartnr,
   faktartgr,
   faktprom,
   faktvk,
   faktmg,
   umszaehlkz,
   anldat,
   fgidentnr_key,
   fgidentnr,   
   vorfreilaufdat,
   vertrgebietid,
   bestgrpsortkz,
   bestgrplfdnr,
   lvfehlkz,
   artnrvt,
   artgrvt,
   promnrvt,
   bestgrppriokz,
   dattermwunsch,
   aktdattermwunsch,
   aktdatliefwunschsk,
   aktlieftermin,
   nalicrswarteschlzaehl,
   naligauftgrundkz,
   naliaktionkz,
   nalispesenfreikz,
   zahlmethodeid,
   zahlwunschid,
   eostxid,
   naligauftfehlerkz,
   nalilogistikwartefzaehl,
   gutscheindatenid_key,
   gutscheindatenid,
   bestartnrbestand,
   liefauskunftergebnisid,
   alfa_ersatzartid,
   ezvtransaktionid_key,
   ezvtransaktionid,
   mwstid,
   prozessidletztaend,
   beilagenr,
   komwarenwert,
   auftragposidref_key
)
VALUES
(
   &gbvid,
   id_key,
   id,
   katart,
   bestartgr,
   bestartnr,
   bestartprom,
   bestartsaison,
   bestartvk,
   bestmg,
   bestliefdat,
   ersartgr,
   ersartnr,
   ersartprom,
   ersartvk,
   letztaenddat,
   lfdartposnr,
   liefdat,
   komlieftermin,
   mwstbetr,
   mwstproz,
   zahlwunschkz,
   erfpreis,
   erfseite,
   artkatkz,
   artmgeinhkz,
   ersarttypkz,
   ersartkdwunschkz,
   aktliefstatkz,
   komliefstatkz,
   posfehlerkz,
   auftrstornokz,
   valkz,
   zugestartartkz,
   ratenaufschlagid,
   rataufschlag,
   auftragkopfid_key,
   usernrletztaend,
   lagerortid,
   versandortid,
   valutaaktionid,
   bestartgrbestand,
   ersartgrbestand,
   letztexportdat,
   hvermerkkz,
   userletztaend,
   anwgrpkzletztaend,
   benutzeridletztaend,
   auftrposidentnr,
   auftrnr_key,
   auftrpos,
   artbez,
   artfarbe,
   ersartbez,
   ersartfarb,
   lokz,
   posstatkz,
   faktstatkz,
   letztfaktabgldat,
   nalistatkz,
   faktartnr,
   faktartgr,
   faktprom,
   faktvk,
   faktmg,
   umszaehlkz,
   anldat,
   fgidentnr_key,
   fgidentnr,   
   vorfreilaufdat,
   vertrgebietid,
   bestgrpsortkz,
   bestgrplfdnr,
   lvfehlkz,
   artnrvt,
   artgrvt,
   promnrvt,
   bestgrppriokz,
   dattermwunsch,
   aktdattermwunsch,
   aktdatliefwunschsk,
   aktlieftermin,
   nalicrswarteschlzaehl,
   naligauftgrundkz,
   naliaktionkz,
   nalispesenfreikz,
   zahlmethodeid,
   zahlwunschid,
   eostxid,
   naligauftfehlerkz,
   nalilogistikwartefzaehl,
   gutscheindatenid_key,
   gutscheindatenid,
   bestartnrbestand,
   liefauskunftergebnisid,
   alfa_ersatzartid,
   ezvtransaktionid_key,
   ezvtransaktionid,
   mwstid,
   prozessidletztaend,
   beilagenr,
   komwarenwert,
   auftragposidref_key   
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_auftragpos_d
(
   dwh_cr_load_id,
   id_key,
   id
)
VALUES
(
   &gbvid,
   id_key,
   id
)
SELECT DISTINCT
   dwh_stbflag,
   id_key,
   id,
   katart,
   bestartgr,
   bestartnr,
   bestartprom,
   bestartsaison,
   bestartvk,
   bestmg,
   bestliefdat,
   ersartgr,
   ersartnr,
   ersartprom,
   ersartvk,
   letztaenddat,
   lfdartposnr,
   liefdat,
   komlieftermin,
   mwstbetr,
   mwstproz,
   zahlwunschkz,
   erfpreis,
   erfseite,
   artkatkz,
   artmgeinhkz,
   ersarttypkz,
   ersartkdwunschkz,
   aktliefstatkz,
   komliefstatkz,
   posfehlerkz,
   auftrstornokz,
   valkz,
   zugestartartkz,
   ratenaufschlagid,
   rataufschlag,
   auftragkopfid_key,
   usernrletztaend,
   lagerortid,
   versandortid,
   valutaaktionid,
   bestartgrbestand,
   ersartgrbestand,
   letztexportdat,
   hvermerkkz,
   userletztaend,
   anwgrpkzletztaend,
   benutzeridletztaend,
   auftrposidentnr,
   auftrnr_key,
   auftrpos,
   artbez,
   artfarbe,
   ersartbez,
   ersartfarb,
   lokz,
   posstatkz,
   faktstatkz,
   letztfaktabgldat,
   nalistatkz,
   faktartnr,
   faktartgr,
   faktprom,
   faktvk,
   faktmg,
   umszaehlkz,
   anldat,
   fgidentnr_key,
   fgidentnr,   
   vorfreilaufdat,
   vertrgebietid,
   bestgrpsortkz,
   bestgrplfdnr,
   lvfehlkz,
   artnrvt,
   artgrvt,
   promnrvt,
   bestgrppriokz,
   dattermwunsch,
   aktdattermwunsch,
   aktdatliefwunschsk,
   aktlieftermin,
   nalicrswarteschlzaehl,
   naligauftgrundkz,
   naliaktionkz,
   nalispesenfreikz,
   zahlmethodeid,
   zahlwunschid,
   eostxid,
   naligauftfehlerkz,
   nalilogistikwartefzaehl,
   gutscheindatenid_key,
   gutscheindatenid,
   bestartnrbestand,
   liefauskunftergebnisid,
   alfa_ersatzartid,
   ezvtransaktionid_key,
   ezvtransaktionid,
   mwstid,
   prozessidletztaend,
   beilagenr,
   komwarenwert,
   auftragposidref_key   
FROM st_ww_auftragpos_b
WHERE dwh_processdate = &termin;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  1.3 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_auftragpos_1');
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_auftragpos_d');
 
 
 
PROMPT ===========================================
PROMPT  1.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING ('clsc_ww_auftragpos', 'id_key,id', &gbvid);
 
 
 
PROMPT ===========================================
PROMPT  1.5 Einspielen in die letzte SC-Tabelle mit Referenzauflösung
PROMPT ===========================================
 
INSERT /*+ APPEND */ FIRST
WHEN (dwh_id_sc_ww_zahlwunschkz IS NULL
   OR dwh_id_sc_ww_artkatkz IS NULL
   OR dwh_id_sc_ww_artmgeinhkz IS NULL
   OR dwh_id_sc_ww_ersarttypkz IS NULL
   OR dwh_id_sc_ww_ersartkdwukz IS NULL
   OR dwh_id_sc_ww_aktliefstat IS NULL
   OR dwh_id_sc_ww_komliefstat IS NULL
   OR dwh_id_sc_ww_posfehlerkz IS NULL
   OR dwh_id_sc_ww_auftrstornokz IS NULL
   OR dwh_id_sc_ww_valkz IS NULL
   OR dwh_id_sc_ww_zugestartartkz IS NULL   
   OR dwh_id_sc_ww_ratenaufschlag IS NULL
   OR dwh_id_sc_ww_auftragkopf IS NULL
   OR dwh_id_sc_ww_valutaaktion IS NULL
   OR dwh_id_sc_ww_hvermerkkz IS NULL
   OR dwh_id_sc_ww_lokz IS NULL
   OR dwh_id_sc_ww_posstatkz IS NULL
   OR dwh_id_sc_ww_faktstatkz IS NULL   
   OR dwh_id_sc_ww_nalistatkz IS NULL
   OR dwh_id_sc_ww_vertrgebiet IS NULL
   OR dwh_id_sc_ww_lvfehlkz IS NULL   
   OR dwh_id_sc_ww_naligauftgrukz IS NULL
   --OR dwh_id_sc_ww_naliaktionkz IS NULL
   OR dwh_id_sc_ww_naliaktionkz_host IS NULL
   OR dwh_id_sc_ww_nalispesenfreikz IS NULL
   OR dwh_id_sc_ww_zahlmethode IS NULL
   OR dwh_id_sc_ww_zahlwunsch IS NULL
   OR dwh_id_sc_ww_naligauftfehlkz IS NULL   
   OR dwh_id_sc_ww_alfa_ersatzart IS NULL
   OR dwh_id_sc_ww_mwst IS NULL
   OR dwh_id_sc_ww_prozessletztaend IS NULL
) THEN
INTO clsc_ww_auftragpos_e
(
   dwh_cr_load_id,
   dwh_up_load_id,
   dwh_id_sc_ww_zahlwunschkz,
   dwh_id_sc_ww_artkatkz,
   dwh_id_sc_ww_artmgeinhkz,
   dwh_id_sc_ww_ersarttypkz,
   dwh_id_sc_ww_ersartkdwukz,
   dwh_id_sc_ww_aktliefstat,
   dwh_id_sc_ww_komliefstat,
   dwh_id_sc_ww_posfehlerkz,
   dwh_id_sc_ww_auftrstornokz,
   dwh_id_sc_ww_valkz,
   dwh_id_sc_ww_zugestartartkz,
   dwh_id_sc_ww_ratenaufschlag,
   dwh_id_sc_ww_auftragkopf,
   dwh_id_sc_ww_valutaaktion,
   dwh_id_sc_ww_hvermerkkz,
   dwh_id_sc_ww_lokz,
   dwh_id_sc_ww_posstatkz,
   dwh_id_sc_ww_faktstatkz,   
   dwh_id_sc_ww_nalistatkz,
   dwh_id_sc_ww_vertrgebiet,
   dwh_id_sc_ww_lvfehlkz,   
   dwh_id_sc_ww_naligauftgrukz,
  -- dwh_id_sc_ww_naliaktionkz,   
   dwh_id_sc_ww_naliaktionkz_host, 
   dwh_id_sc_ww_nalispesenfreikz,
   dwh_id_sc_ww_zahlmethode,
   dwh_id_sc_ww_zahlwunsch,
   dwh_id_sc_ww_naligauftfehlkz,   
   dwh_id_sc_ww_alfa_ersatzart,
   dwh_id_sc_ww_mwst,
   dwh_id_sc_ww_prozessletztaend,
   id_key,
   id,
   katart,
   bestartgr,
   bestartnr,
   bestartprom,
   bestartsaison,
   bestartvk,
   bestmg,
   bestliefdat,
   ersartgr,
   ersartnr,
   ersartprom,
   ersartvk,
   letztaenddat,
   lfdartposnr,
   liefdat,
   komlieftermin,
   mwstbetr,
   mwstproz,
   zahlwunschkz,
   erfpreis,
   erfseite,
   artkatkz,
   artmgeinhkz,
   ersarttypkz,
   ersartkdwunschkz,
   aktliefstatkz,
   komliefstatkz,
   posfehlerkz,
   auftrstornokz,
   valkz,
   zugestartartkz,
   ratenaufschlagid,
   rataufschlag,
   auftragkopfid_key,
   usernrletztaend,
   lagerortid,
   versandortid,
   valutaaktionid,
   bestartgrbestand,
   ersartgrbestand,
   letztexportdat,
   hvermerkkz,
   userletztaend,
   anwgrpkzletztaend,
   benutzeridletztaend,
   auftrposidentnr,
   auftrnr_key,
   auftrpos,
   artbez,
   artfarbe,
   ersartbez,
   ersartfarb,
   lokz,
   posstatkz,
   faktstatkz,
   letztfaktabgldat,
   nalistatkz,
   faktartnr,
   faktartgr,
   faktprom,
   faktvk,
   faktmg,
   umszaehlkz,
   anldat,
   fgidentnr_key,
   fgidentnr,   
   vorfreilaufdat,
   vertrgebietid,
   bestgrpsortkz,
   bestgrplfdnr,
   lvfehlkz,
   artnrvt,
   artgrvt,
   promnrvt,
   bestgrppriokz,
   dattermwunsch,
   aktdattermwunsch,
   aktdatliefwunschsk,
   aktlieftermin,
   nalicrswarteschlzaehl,
   naligauftgrundkz,
   naliaktionkz,
   nalispesenfreikz,
   zahlmethodeid,
   zahlwunschid,
   eostxid,
   naligauftfehlerkz,
   nalilogistikwartefzaehl,
   gutscheindatenid_key,
   gutscheindatenid,
   bestartnrbestand,
   liefauskunftergebnisid,
   alfa_ersatzartid,
   ezvtransaktionid_key,
   ezvtransaktionid,
   mwstid,
   prozessidletztaend,
   beilagenr,
   komwarenwert,
   auftragposidref_key  
)
VALUES
(
   dwh_cr_load_id,
   &gbvid,
   dwh_id_sc_ww_zahlwunschkz,
   dwh_id_sc_ww_artkatkz,
   dwh_id_sc_ww_artmgeinhkz,
   dwh_id_sc_ww_ersarttypkz,   
   dwh_id_sc_ww_ersartkdwukz,
   dwh_id_sc_ww_aktliefstat,   
   dwh_id_sc_ww_komliefstat,   
   dwh_id_sc_ww_posfehlerkz,
   dwh_id_sc_ww_auftrstornokz,
   dwh_id_sc_ww_valkz,
   dwh_id_sc_ww_zugestartartkz,
   dwh_id_sc_ww_ratenaufschlag,   
   dwh_id_sc_ww_auftragkopf,
   dwh_id_sc_ww_valutaaktion,
   dwh_id_sc_ww_hvermerkkz,
   dwh_id_sc_ww_lokz,
   dwh_id_sc_ww_posstatkz,      
   dwh_id_sc_ww_faktstatkz,   
   dwh_id_sc_ww_nalistatkz,
   dwh_id_sc_ww_vertrgebiet,   
   dwh_id_sc_ww_lvfehlkz,   
   dwh_id_sc_ww_naligauftgrukz,
   --dwh_id_sc_ww_naliaktionkz, 
   dwh_id_sc_ww_naliaktionkz_host,
   dwh_id_sc_ww_nalispesenfreikz,
   dwh_id_sc_ww_zahlmethode,
   dwh_id_sc_ww_zahlwunsch,   
   dwh_id_sc_ww_naligauftfehlkz,   
   dwh_id_sc_ww_alfa_ersatzart,   
   dwh_id_sc_ww_mwst,
   dwh_id_sc_ww_prozessletztaend,
   id_key,
   id,
   katart,
   bestartgr,
   bestartnr,
   bestartprom,
   bestartsaison,
   bestartvk,
   bestmg,
   bestliefdat,
   ersartgr,
   ersartnr,
   ersartprom,
   ersartvk,
   letztaenddat,
   lfdartposnr,
   liefdat,
   komlieftermin,
   mwstbetr,
   mwstproz,
   zahlwunschkz,
   erfpreis,
   erfseite,
   artkatkz,
   artmgeinhkz,
   ersarttypkz,
   ersartkdwunschkz,
   aktliefstatkz,
   komliefstatkz,
   posfehlerkz,
   auftrstornokz,
   valkz,
   zugestartartkz,
   ratenaufschlagid,
   rataufschlag,
   auftragkopfid_key,
   usernrletztaend,
   lagerortid,
   versandortid,
   valutaaktionid,
   bestartgrbestand,
   ersartgrbestand,
   letztexportdat,
   hvermerkkz,
   userletztaend,
   anwgrpkzletztaend,
   benutzeridletztaend,
   auftrposidentnr,
   auftrnr_key,
   auftrpos,
   artbez,
   artfarbe,
   ersartbez,
   ersartfarb,
   lokz,
   posstatkz,
   faktstatkz,
   letztfaktabgldat,
   nalistatkz,
   faktartnr,
   faktartgr,
   faktprom,
   faktvk,
   faktmg,
   umszaehlkz,
   anldat,
   fgidentnr_key,
   fgidentnr,   
   vorfreilaufdat,
   vertrgebietid,
   bestgrpsortkz,
   bestgrplfdnr,
   lvfehlkz,
   artnrvt,
   artgrvt,
   promnrvt,
   bestgrppriokz,
   dattermwunsch,
   aktdattermwunsch,
   aktdatliefwunschsk,
   aktlieftermin,
   nalicrswarteschlzaehl,
   naligauftgrundkz,
   naliaktionkz,
   nalispesenfreikz,
   zahlmethodeid,
   zahlwunschid,
   eostxid,
   naligauftfehlerkz,
   nalilogistikwartefzaehl,
   gutscheindatenid_key,
   gutscheindatenid,
   bestartnrbestand,
   liefauskunftergebnisid,
   alfa_ersatzartid,
   ezvtransaktionid_key,
   ezvtransaktionid,
   mwstid,
   prozessidletztaend,
   beilagenr,
   komwarenwert,
   auftragposidref_key  
)
ELSE
INTO clsc_ww_auftragpos
(
   dwh_cr_load_id,
   dwh_id_sc_ww_zahlwunschkz,
   dwh_id_sc_ww_artkatkz,
   dwh_id_sc_ww_artmgeinhkz,
   dwh_id_sc_ww_ersarttypkz,
   dwh_id_sc_ww_ersartkdwukz,      
   dwh_id_sc_ww_aktliefstat,   
   dwh_id_sc_ww_komliefstat,
   dwh_id_sc_ww_posfehlerkz,
   dwh_id_sc_ww_auftrstornokz,
   dwh_id_sc_ww_valkz,
   dwh_id_sc_ww_zugestartartkz,
   dwh_id_sc_ww_ratenaufschlag,      
   dwh_id_sc_ww_auftragkopf,
   dwh_id_sc_ww_valutaaktion,
   dwh_id_sc_ww_hvermerkkz,
   dwh_id_sc_ww_lokz,
   dwh_id_sc_ww_posstatkz,      
   dwh_id_sc_ww_faktstatkz,   
   dwh_id_sc_ww_nalistatkz,
   dwh_id_sc_ww_vertrgebiet,   
   dwh_id_sc_ww_lvfehlkz,   
   dwh_id_sc_ww_naligauftgrukz,
 --  dwh_id_sc_ww_naliaktionkz, 
   dwh_id_sc_ww_naliaktionkz_host,
   dwh_id_sc_ww_nalispesenfreikz,
   dwh_id_sc_ww_zahlmethode,
   dwh_id_sc_ww_zahlwunsch,
   dwh_id_sc_ww_naligauftfehlkz,   
   dwh_id_sc_ww_alfa_ersatzart,   
   dwh_id_sc_ww_mwst,
   dwh_id_sc_ww_prozessletztaend,   
   id_key,
   id,
   katart,
   bestartgr,
   bestartnr,
   bestartprom,
   bestartsaison,
   bestartvk,
   bestmg,
   bestliefdat,
   ersartgr,
   ersartnr,
   ersartprom,
   ersartvk,
   letztaenddat,
   lfdartposnr,
   liefdat,
   komlieftermin,
   mwstbetr,
   mwstproz,
   zahlwunschkz,
   erfpreis,
   erfseite,
   artkatkz,
   artmgeinhkz,
   ersarttypkz,
   ersartkdwunschkz,
   aktliefstatkz,
   komliefstatkz,
   posfehlerkz,
   auftrstornokz,
   valkz,
   zugestartartkz,
   ratenaufschlagid,
   rataufschlag,
   auftragkopfid_key,
   usernrletztaend,
   lagerortid,
   versandortid,
   valutaaktionid,
   bestartgrbestand,
   ersartgrbestand,
   letztexportdat,
   hvermerkkz,
   userletztaend,
   anwgrpkzletztaend,
   benutzeridletztaend,
   auftrposidentnr,
   auftrnr_key,
   auftrpos,
   artbez,
   artfarbe,
   ersartbez,
   ersartfarb,
   lokz,
   posstatkz,
   faktstatkz,
   letztfaktabgldat,
   nalistatkz,
   faktartnr,
   faktartgr,
   faktprom,
   faktvk,
   faktmg,
   umszaehlkz,
   anldat,
   fgidentnr_key,
   fgidentnr,   
   vorfreilaufdat,
   vertrgebietid,
   bestgrpsortkz,
   bestgrplfdnr,
   lvfehlkz,
   artnrvt,
   artgrvt,
   promnrvt,
   bestgrppriokz,
   dattermwunsch,
   aktdattermwunsch,
   aktdatliefwunschsk,
   aktlieftermin,
   nalicrswarteschlzaehl,
   naligauftgrundkz,
   naliaktionkz,
   nalispesenfreikz,
   zahlmethodeid,
   zahlwunschid,
   eostxid,
   naligauftfehlerkz,
   nalilogistikwartefzaehl,
   gutscheindatenid_key,
   gutscheindatenid,
   bestartnrbestand,
   liefauskunftergebnisid,
   alfa_ersatzartid,
   ezvtransaktionid_key,
   ezvtransaktionid,
   mwstid,
   prozessidletztaend,
   beilagenr,
   komwarenwert,
   auftragposidref_key 
)
SELECT
   a.dwh_cr_load_id,
   sc_ww_zahlwunschkz.dwh_id AS dwh_id_sc_ww_zahlwunschkz,
   sc_ww_artkatkz.dwh_id AS dwh_id_sc_ww_artkatkz,
   sc_ww_artmgeinhkz.dwh_id AS dwh_id_sc_ww_artmgeinhkz,   
   sc_ww_ersarttypkz.dwh_id AS dwh_id_sc_ww_ersarttypkz,        
   sc_ww_ersartkdwukz.dwh_id AS dwh_id_sc_ww_ersartkdwukz,         
   sc_ww_aktliefstat.dwh_id AS dwh_id_sc_ww_aktliefstat,   
   sc_ww_komliefstat.dwh_id AS dwh_id_sc_ww_komliefstat,   
   sc_ww_posfehlerkz.dwh_id AS dwh_id_sc_ww_posfehlerkz,     
   sc_ww_auftrstornokz.dwh_id AS dwh_id_sc_ww_auftrstornokz,     
   sc_ww_valkz.dwh_id AS dwh_id_sc_ww_valkz,   
   sc_ww_zugestartartkz.dwh_id AS dwh_id_sc_ww_zugestartartkz,   
   sc_ww_ratenaufschlag.dwh_id AS dwh_id_sc_ww_ratenaufschlag,   
   sc_ww_auftragkopf.dwh_id AS dwh_id_sc_ww_auftragkopf,      
   sc_ww_valutaaktion.dwh_id AS dwh_id_sc_ww_valutaaktion,
   sc_ww_hvermerkkz.dwh_id AS dwh_id_sc_ww_hvermerkkz,   
   sc_ww_lokz.dwh_id AS dwh_id_sc_ww_lokz,         
   sc_ww_posstatkz.dwh_id AS dwh_id_sc_ww_posstatkz,            
   sc_ww_faktstatkz.dwh_id AS dwh_id_sc_ww_faktstatkz,   
   sc_ww_nalistatkz.dwh_id AS dwh_id_sc_ww_nalistatkz,      
   sc_ww_vertrgebiet.dwh_id AS dwh_id_sc_ww_vertrgebiet,   
   sc_ww_lvfehlkz.dwh_id AS dwh_id_sc_ww_lvfehlkz,   
   sc_ww_naligauftgrukz.dwh_id AS dwh_id_sc_ww_naligauftgrukz,
  -- sc_ww_naliaktionkz.dwh_id AS dwh_id_sc_ww_naliaktionkz,  
   sc_ww_naliaktionkz_host.dwh_id AS dwh_id_sc_ww_naliaktionkz_host, 
   sc_ww_nalispesenfreikz.dwh_id AS dwh_id_sc_ww_nalispesenfreikz,   
   sc_ww_zahlmethode.dwh_id AS dwh_id_sc_ww_zahlmethode,
   sc_ww_zahlwunsch.dwh_id AS dwh_id_sc_ww_zahlwunsch,   
   sc_ww_naligauftfehlkz.dwh_id AS dwh_id_sc_ww_naligauftfehlkz,   
   sc_ww_alfa_ersatzart.dwh_id AS dwh_id_sc_ww_alfa_ersatzart,            
   sc_ww_mwst.dwh_id AS dwh_id_sc_ww_mwst,
   sc_ww_prozessletztaend.dwh_id AS dwh_id_sc_ww_prozessletztaend,   
   a.id_key AS id_key,
   a.id AS id,
   a.katart AS katart,
   a.bestartgr AS bestartgr,
   a.bestartnr AS bestartnr,
   a.bestartprom AS bestartprom,
   a.bestartsaison AS bestartsaison,
   a.bestartvk AS bestartvk,
   a.bestmg AS bestmg,
   a.bestliefdat AS bestliefdat,
   a.ersartgr AS ersartgr,
   a.ersartnr AS ersartnr,
   a.ersartprom AS ersartprom,
   a.ersartvk AS ersartvk,
   a.letztaenddat AS letztaenddat,
   a.lfdartposnr AS lfdartposnr,
   a.liefdat AS liefdat,
   a.komlieftermin AS komlieftermin,
   a.mwstbetr AS mwstbetr,
   a.mwstproz AS mwstproz,
   a.zahlwunschkz AS zahlwunschkz,
   a.erfpreis AS erfpreis,
   a.erfseite AS erfseite,
   a.artkatkz AS artkatkz,
   a.artmgeinhkz AS artmgeinhkz,
   a.ersarttypkz AS ersarttypkz,
   a.ersartkdwunschkz AS ersartkdwunschkz,
   a.aktliefstatkz AS aktliefstatkz,
   a.komliefstatkz AS komliefstatkz,
   a.posfehlerkz AS posfehlerkz,
   a.auftrstornokz AS auftrstornokz,
   a.valkz AS valkz,
   a.zugestartartkz AS zugestartartkz,
   a.ratenaufschlagid AS ratenaufschlagid,
   a.rataufschlag AS rataufschlag,
   a.auftragkopfid_key AS auftragkopfid_key,
   a.usernrletztaend AS usernrletztaend,
   a.lagerortid AS lagerortid,
   a.versandortid AS versandortid,
   a.valutaaktionid AS valutaaktionid,
   a.bestartgrbestand AS bestartgrbestand,
   a.ersartgrbestand AS ersartgrbestand,
   a.letztexportdat AS letztexportdat,
   a.hvermerkkz AS hvermerkkz,
   a.userletztaend AS userletztaend,
   a.anwgrpkzletztaend AS anwgrpkzletztaend,
   a.benutzeridletztaend AS benutzeridletztaend,
   a.auftrposidentnr AS auftrposidentnr,
   a.auftrnr_key AS auftrnr_key,
   a.auftrpos AS auftrpos,
   a.artbez AS artbez,
   a.artfarbe AS artfarbe,
   a.ersartbez AS ersartbez,
   a.ersartfarb AS ersartfarb,
   a.lokz AS lokz,
   a.posstatkz AS posstatkz,
   a.faktstatkz AS faktstatkz,
   a.letztfaktabgldat AS letztfaktabgldat,
   a.nalistatkz AS nalistatkz,
   a.faktartnr AS faktartnr,
   a.faktartgr AS faktartgr,
   a.faktprom AS faktprom,
   a.faktvk AS faktvk,
   a.faktmg AS faktmg,
   a.umszaehlkz AS umszaehlkz,
   a.anldat AS anldat,
   a.fgidentnr_key AS fgidentnr_key,
   a.fgidentnr AS fgidentnr,
   a.vorfreilaufdat AS vorfreilaufdat,
   a.vertrgebietid AS vertrgebietid,
   a.bestgrpsortkz AS bestgrpsortkz,
   a.bestgrplfdnr AS bestgrplfdnr,
   a.lvfehlkz AS lvfehlkz,
   a.artnrvt AS artnrvt,
   a.artgrvt AS artgrvt,
   a.promnrvt AS promnrvt,
   a.bestgrppriokz AS bestgrppriokz,
   a.dattermwunsch AS dattermwunsch,
   a.aktdattermwunsch AS aktdattermwunsch,
   a.aktdatliefwunschsk AS aktdatliefwunschsk,
   a.aktlieftermin AS aktlieftermin,
   a.nalicrswarteschlzaehl AS nalicrswarteschlzaehl,
   a.naligauftgrundkz AS naligauftgrundkz,
   a.naliaktionkz AS naliaktionkz,
   a.nalispesenfreikz AS nalispesenfreikz,
   a.zahlmethodeid AS zahlmethodeid,
   a.zahlwunschid AS zahlwunschid,
   a.eostxid AS eostxid,
   a.naligauftfehlerkz AS naligauftfehlerkz,
   a.nalilogistikwartefzaehl AS nalilogistikwartefzaehl,
   a.gutscheindatenid_key AS gutscheindatenid_key,
   a.gutscheindatenid AS gutscheindatenid,
   a.bestartnrbestand AS bestartnrbestand,
   a.liefauskunftergebnisid AS liefauskunftergebnisid,
   a.alfa_ersatzartid AS alfa_ersatzartid,
   a.ezvtransaktionid_key AS ezvtransaktionid_key,
   a.ezvtransaktionid AS ezvtransaktionid,
   a.mwstid AS mwstid,
   a.prozessidletztaend AS prozessidletztaend,
   a.beilagenr AS beilagenr,
   a.komwarenwert AS komwarenwert,
   a.auftragposidref_key AS auftragposidref_key   
FROM clsc_ww_auftragpos_1 a
  LEFT OUTER JOIN (SELECT sc_ww_zahlwunschkz.dwh_id, sc_ww_zahlwunschkz.wert FROM sc_ww_zahlwunschkz)  sc_ww_zahlwunschkz
      ON (COALESCE(a.zahlwunschkz,-2) = sc_ww_zahlwunschkz.wert)   -- ab 18.04.2017 können NULL-Werte vorkommen (schrittweise Abschaltung der Spalte)
  LEFT OUTER JOIN (SELECT sc_ww_artkatkz.dwh_id, sc_ww_artkatkz.verwzweck FROM sc_ww_artkatkz)  sc_ww_artkatkz
      ON (a.artkatkz = sc_ww_artkatkz.verwzweck)      
  LEFT OUTER JOIN (SELECT sc_ww_artmgeinhkz.dwh_id, sc_ww_artmgeinhkz.wert FROM sc_ww_artmgeinhkz)  sc_ww_artmgeinhkz
      ON (a.artmgeinhkz = sc_ww_artmgeinhkz.wert)            
  LEFT OUTER JOIN (SELECT sc_ww_ersarttypkz.dwh_id, sc_ww_ersarttypkz.wert FROM sc_ww_ersarttypkz)  sc_ww_ersarttypkz
      ON (COALESCE(a.ersarttypkz,-2) = sc_ww_ersarttypkz.wert)           -- Spalte wurde durch ALFA ersetzt, nur in Altdaten vorhanden
  LEFT OUTER JOIN (SELECT sc_ww_ersartkdwukz.dwh_id, sc_ww_ersartkdwukz.wert FROM sc_ww_ersartkdwukz)  sc_ww_ersartkdwukz
      ON (a.ersartkdwunschkz = sc_ww_ersartkdwukz.wert)            
  LEFT OUTER JOIN (SELECT sc_ww_aktliefstat.dwh_id, sc_ww_aktliefstat.wert FROM sc_ww_aktliefstat)  sc_ww_aktliefstat
      ON (a.aktliefstatkz = sc_ww_aktliefstat.wert)                       
  LEFT OUTER JOIN (SELECT sc_ww_komliefstat.dwh_id, sc_ww_komliefstat.wert FROM sc_ww_komliefstat)  sc_ww_komliefstat
      ON (a.komliefstatkz = sc_ww_komliefstat.wert)              
  LEFT OUTER JOIN (SELECT sc_ww_posfehlerkz.dwh_id, sc_ww_posfehlerkz.wert FROM sc_ww_posfehlerkz)  sc_ww_posfehlerkz
      ON (COALESCE(a.posfehlerkz,-3) = sc_ww_posfehlerkz.wert)                  
  LEFT OUTER JOIN (SELECT sc_ww_auftrstornokz.dwh_id, sc_ww_auftrstornokz.wert FROM sc_ww_auftrstornokz)  sc_ww_auftrstornokz
      ON (a.auftrstornokz = sc_ww_auftrstornokz.wert)               
  LEFT OUTER JOIN (SELECT sc_ww_valkz.dwh_id, sc_ww_valkz.wert FROM sc_ww_valkz)  sc_ww_valkz
      ON (a.valkz = sc_ww_valkz.wert)                               
  LEFT OUTER JOIN (SELECT sc_ww_zugestartartkz.dwh_id, sc_ww_zugestartartkz.wert FROM sc_ww_zugestartartkz)  sc_ww_zugestartartkz
      ON (a.zugestartartkz = sc_ww_zugestartartkz.wert)                                   
  LEFT OUTER JOIN (SELECT sc_ww_ratenaufschlag.dwh_id, sc_ww_ratenaufschlag.id FROM sc_ww_ratenaufschlag)  sc_ww_ratenaufschlag
      ON (COALESCE(a.ratenaufschlagid,'$') = sc_ww_ratenaufschlag.id)                      
  LEFT OUTER JOIN (SELECT sc_ww_auftragkopf.dwh_id, sc_ww_auftragkopf.id_key FROM sc_ww_auftragkopf)  sc_ww_auftragkopf
      ON (a.auftragkopfid_key = sc_ww_auftragkopf.id_key)             
  LEFT OUTER JOIN (SELECT sc_ww_valutaaktion.dwh_id, sc_ww_valutaaktion.id FROM sc_ww_valutaaktion)  sc_ww_valutaaktion
      ON (COALESCE(a.valutaaktionid,'$') = sc_ww_valutaaktion.id)       -- Id ist nur bei Valutaaufträgen gesetzt, sonst NULL                  
  LEFT OUTER JOIN (SELECT sc_ww_hvermerkkz.dwh_id, sc_ww_hvermerkkz.wert FROM sc_ww_hvermerkkz)  sc_ww_hvermerkkz
      ON (COALESCE(a.hvermerkkz,0) = sc_ww_hvermerkkz.wert)            
  LEFT OUTER JOIN (SELECT sc_ww_lokz.dwh_id, sc_ww_lokz.wert FROM sc_ww_lokz)  sc_ww_lokz
      ON (COALESCE(a.lokz,0) = sc_ww_lokz.wert)                        
  LEFT OUTER JOIN (SELECT sc_ww_posstatkz.dwh_id, sc_ww_posstatkz.wert FROM sc_ww_posstatkz)  sc_ww_posstatkz
      ON (COALESCE(ABS(a.posstatkz),-3) = sc_ww_posstatkz.wert)    --Status wird bei Sperre zur Bearbeitung negativ, anschliessend wieder positiv, War bei 4 Datensätzen am 29.07.2015 13:30:00 NULL, sonst immer gefuellt, für Urladung mit COALESCE, danach evtl. wieder entfernen
  LEFT OUTER JOIN (SELECT sc_ww_faktstatkz.dwh_id, sc_ww_faktstatkz.wert FROM sc_ww_faktstatkz)  sc_ww_faktstatkz
      ON (COALESCE(ABS(a.faktstatkz),-3) = sc_ww_faktstatkz.wert)    -- NULL bedeutet Auftragsabgleich noch nicht gelaufen. 
  LEFT OUTER JOIN (SELECT sc_ww_nalistatkz.dwh_id, sc_ww_nalistatkz.wert FROM sc_ww_nalistatkz)  sc_ww_nalistatkz
      ON (COALESCE(a.nalistatkz,10) = sc_ww_nalistatkz.wert)                              
  LEFT OUTER JOIN (SELECT sc_ww_vertrgebiet.dwh_id, sc_ww_vertrgebiet.id FROM sc_ww_vertrgebiet)  sc_ww_vertrgebiet
      ON (COALESCE(a.vertrgebietid,'$') = sc_ww_vertrgebiet.id)            
  LEFT OUTER JOIN (SELECT sc_ww_lvfehlkz.dwh_id, sc_ww_lvfehlkz.wert FROM sc_ww_lvfehlkz)  sc_ww_lvfehlkz
      ON (COALESCE(a.lvfehlkz,0) = sc_ww_lvfehlkz.wert)         -- NULL bedeutet kein Fehler.            
  LEFT OUTER JOIN (SELECT sc_ww_naligauftgrukz.dwh_id, sc_ww_naligauftgrukz.wert FROM sc_ww_naligauftgrukz)  sc_ww_naligauftgrukz
      ON (COALESCE(a.naligauftgrundkz,0) = sc_ww_naligauftgrukz.wert)      
--  LEFT OUTER JOIN (SELECT sc_ww_naliaktionkz_host.dwh_id, sc_ww_naliaktionkz_host.wert FROM sc_ww_naliaktionkz_host)  sc_ww_naliaktionkz
--      ON (COALESCE(a.naliaktionkz,0) = sc_ww_naliaktionkz.wert)   
  LEFT OUTER JOIN (SELECT sc_ww_naliaktionkz_host.dwh_id, sc_ww_naliaktionkz_host.wert FROM sc_ww_naliaktionkz_host)  sc_ww_naliaktionkz_host
      ON (COALESCE(a.naliaktionkz,0) = sc_ww_naliaktionkz_host.wert)  
  LEFT OUTER JOIN (SELECT sc_ww_nalispesenfreikz.dwh_id, sc_ww_nalispesenfreikz.wert FROM sc_ww_nalispesenfreikz)  sc_ww_nalispesenfreikz
      ON (COALESCE(a.nalispesenfreikz,-3) = sc_ww_nalispesenfreikz.wert)                              
  LEFT OUTER JOIN (SELECT sc_ww_zahlmethode.dwh_id, sc_ww_zahlmethode.id FROM sc_ww_zahlmethode)  sc_ww_zahlmethode
      ON (COALESCE(a.zahlmethodeid,'$') = sc_ww_zahlmethode.id)
  LEFT OUTER JOIN (SELECT sc_ww_zahlwunsch.dwh_id, sc_ww_zahlwunsch.id FROM sc_ww_zahlwunsch)  sc_ww_zahlwunsch
      ON (COALESCE(a.zahlwunschid,'$') = sc_ww_zahlwunsch.id)                        
  LEFT OUTER JOIN (SELECT sc_ww_naligauftfehlkz.dwh_id, sc_ww_naligauftfehlkz.wert FROM sc_ww_naligauftfehlkz)  sc_ww_naligauftfehlkz
      ON (COALESCE(a.naligauftfehlerkz,0) = sc_ww_naligauftfehlkz.wert)                            
  LEFT OUTER JOIN (SELECT sc_ww_alfa_ersatzart.dwh_id, sc_ww_alfa_ersatzart.id FROM sc_ww_alfa_ersatzart)  sc_ww_alfa_ersatzart
      ON (COALESCE(a.alfa_ersatzartid,'$') = sc_ww_alfa_ersatzart.id)    -- Id ist nur bei Ersatzartikelabwicklung gesetzt, sonst NULL   
  LEFT OUTER JOIN (SELECT sc_ww_mwst.dwh_id, sc_ww_mwst.id FROM sc_ww_mwst)  sc_ww_mwst
      ON (COALESCE(a.mwstid,'§') = sc_ww_mwst.id)                        -- Neue Spalte wird erst nach Hostmig gefuellt                  
  LEFT OUTER JOIN (SELECT sc_ww_prozessletztaend.dwh_id, sc_ww_prozessletztaend.id FROM sc_ww_prozessletztaend)  sc_ww_prozessletztaend
      ON (COALESCE(a.prozessidletztaend,'$') = sc_ww_prozessletztaend.id);  
      
      -- prozessidletztaend wird nur bei geänderten Datensätzen gefuellt, sonst null
     
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  1.6 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_auftragpos');
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_auftragpos_e');


--TODO: dwh_id_sc_ww_zugestartartkz für Altdaten vor 28.03 13:30 setzen und Spaltenreihenfolge in Versionstabelle korrigieren (rebuild)
--TODO: dwh_id_sc_ww_lvfehlkz für Altdaten vor 28.03 13:30 setzen  und Spaltenreihenfolge in Versionstabelle korrigieren(rebuild)
--TODO: dwh_id_sc_ww_faktstatkz für Altdaten vor 28.03 13:30 setzen  und Spaltenreihenfolge in Versionstabelle korrigieren(rebuild)



PROMPT =========================================================================
PROMPT
PROMPT 2. Source Core-Ladung
PROMPT Endtabelle: sc_ww_auftragsperre / sc_ww_auftragsperre_ver
PROMPT
PROMPT =========================================================================
 
 
 
PROMPT ===========================================
PROMPT  2.1 Cleansing Tabellen leeren
PROMPT ===========================================
 
TRUNCATE TABLE clsc_ww_auftragsperre;
TRUNCATE TABLE clsc_ww_auftragsperre_1;
TRUNCATE TABLE clsc_ww_auftragsperre_d;
 
 
 
PROMPT ===========================================
PROMPT  2.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================
 
INSERT /*+ APPEND */ ALL
WHEN dwh_stbflag IN ('N','U') THEN
INTO clsc_ww_auftragsperre_1
(
   dwh_cr_load_id,
   id_key,
   auftragkopfid_key,
   aktivkz,
   datgeklaert,
   anwgrpkz,
   auftrsperrverwid,
   benutzer,
   anldat,
   prozessidanl,
   benutzeridgeklaert,
   prozessidgeklaert
)
VALUES
(
   &gbvid,
   id_key,
   auftragkopfid_key,
   aktivkz,
   datgeklaert,
   anwgrpkz,
   auftrsperrverwid,
   benutzer,
   anldat,
   prozessidanl,
   benutzeridgeklaert,
   prozessidgeklaert
)
WHEN dwh_stbflag IN ('D') THEN
INTO clsc_ww_auftragsperre_d
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
   auftragkopfid_key,
   aktivkz,
   datgeklaert,
   anwgrpkz,
   auftrsperrverwid,
   benutzer,
   anldat,
   prozessidanl,
   benutzeridgeklaert,
   prozessidgeklaert
FROM st_ww_auftragsperre_b
WHERE dwh_processdate = &termin;
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  2.3 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_auftragsperre_1');
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_auftragsperre_d');
 
 
 
PROMPT ===========================================
PROMPT  2.4 Error Handling
PROMPT ===========================================
 
EXEC PKG_IM_LADUNG.P_SC_ERROR_HANDLING ('clsc_ww_auftragsperre', 'id_key', &gbvid);
 
 
 
PROMPT ===========================================
PROMPT  2.5 Einspielen in die letzte SC-Tabelle mit Referenzauflösung
PROMPT ===========================================
 
INSERT /*+ APPEND */ FIRST
WHEN (dwh_id_sc_ww_auftragkopf IS NULL 
   OR dwh_id_sc_ww_auftrsperrverw IS NULL 
   OR dwh_id_sc_ww_benutzer IS NULL 
   OR dwh_id_sc_ww_prozessanl IS NULL 
   OR dwh_id_sc_ww_benutzergeklaert IS NULL 
   OR dwh_id_sc_ww_prozessgeklaert IS NULL 
) THEN
INTO clsc_ww_auftragsperre_e
(
   dwh_cr_load_id,
   dwh_up_load_id,
   dwh_id_sc_ww_auftragkopf,
   dwh_id_sc_ww_auftrsperrverw,
   dwh_id_sc_ww_benutzer,
   dwh_id_sc_ww_prozessanl,
   dwh_id_sc_ww_benutzergeklaert,
   dwh_id_sc_ww_prozessgeklaert,
   id_key,
   auftragkopfid_key,
   aktivkz,
   datgeklaert,
   anwgrpkz,
   auftrsperrverwid,
   benutzer,
   anldat,
   prozessidanl,
   benutzeridgeklaert,
   prozessidgeklaert
)
VALUES
(
   dwh_cr_load_id,
   &gbvid,
   dwh_id_sc_ww_auftragkopf,
   dwh_id_sc_ww_auftrsperrverw,
   dwh_id_sc_ww_benutzer,
   dwh_id_sc_ww_prozessanl,
   dwh_id_sc_ww_benutzergeklaert,
   dwh_id_sc_ww_prozessgeklaert,
   id_key,
   auftragkopfid_key,
   aktivkz,
   datgeklaert,
   anwgrpkz,
   auftrsperrverwid,
   benutzer,
   anldat,
   prozessidanl,
   benutzeridgeklaert,
   prozessidgeklaert
)
ELSE
INTO clsc_ww_auftragsperre
(
   dwh_cr_load_id,
   dwh_id_sc_ww_auftragkopf,
   dwh_id_sc_ww_auftrsperrverw,
   dwh_id_sc_ww_benutzer,
   dwh_id_sc_ww_prozessanl,
   dwh_id_sc_ww_benutzergeklaert,
   dwh_id_sc_ww_prozessgeklaert,
   id_key,
   auftragkopfid_key,
   aktivkz,
   datgeklaert,
   anwgrpkz,
   auftrsperrverwid,
   benutzer,
   anldat,
   prozessidanl,
   benutzeridgeklaert,
   prozessidgeklaert
)
SELECT
   a.dwh_cr_load_id,
   sc_ww_auftragkopf.dwh_id AS dwh_id_sc_ww_auftragkopf,
   sc_ww_auftrsperrverw.dwh_id AS dwh_id_sc_ww_auftrsperrverw,
   sc_ww_benutzer.dwh_id AS dwh_id_sc_ww_benutzer,
   sc_ww_prozessanl.dwh_id AS dwh_id_sc_ww_prozessanl,
   sc_ww_benutzergeklaert.dwh_id AS dwh_id_sc_ww_benutzergeklaert,
   sc_ww_prozessgeklaert.dwh_id AS dwh_id_sc_ww_prozessgeklaert,
   a.id_key AS id_key,
   a.auftragkopfid_key AS auftragkopfid_key,
   a.aktivkz AS aktivkz,
   a.datgeklaert AS datgeklaert,
   a.anwgrpkz AS anwgrpkz,
   a.auftrsperrverwid AS auftrsperrverwid,
   a.benutzer AS benutzer,
   a.anldat AS anldat,
   a.prozessidanl AS prozessidanl,
   a.benutzeridgeklaert AS benutzeridgeklaert,
   a.prozessidgeklaert AS prozessidgeklaert
FROM clsc_ww_auftragsperre_1 a
  LEFT OUTER JOIN (SELECT sc_ww_auftragkopf.dwh_id, sc_ww_auftragkopf.id_key FROM sc_ww_auftragkopf)  sc_ww_auftragkopf
      ON (a.auftragkopfid_key = sc_ww_auftragkopf.id_key)
  LEFT OUTER JOIN (SELECT sc_ww_auftrsperrverw.dwh_id, sc_ww_auftrsperrverw.id FROM sc_ww_auftrsperrverw)  sc_ww_auftrsperrverw
      ON (a.auftrsperrverwid = sc_ww_auftrsperrverw.id)
  LEFT OUTER JOIN (SELECT sc_ww_benutzer.dwh_id, sc_ww_benutzer.id FROM sc_ww_benutzer)  sc_ww_benutzer
      ON (COALESCE(a.benutzer, '$') = sc_ww_benutzer.id)
  LEFT OUTER JOIN (SELECT sc_ww_prozessanl.dwh_id, sc_ww_prozessanl.id FROM sc_ww_prozessanl)  sc_ww_prozessanl
      ON (COALESCE(a.prozessidanl, '$') = sc_ww_prozessanl.id)
  LEFT OUTER JOIN (SELECT sc_ww_benutzergeklaert.dwh_id, sc_ww_benutzergeklaert.id FROM sc_ww_benutzergeklaert)  sc_ww_benutzergeklaert
      ON (COALESCE(a.benutzeridgeklaert, '$') = sc_ww_benutzergeklaert.id)
  LEFT OUTER JOIN (SELECT sc_ww_prozessgeklaert.dwh_id, sc_ww_prozessgeklaert.id FROM sc_ww_prozessgeklaert)  sc_ww_prozessgeklaert
      ON (COALESCE(a.prozessidgeklaert, '$') = sc_ww_prozessgeklaert.id);
 
COMMIT;
 
 
 
PROMPT ===========================================
PROMPT  2.6 Aktuelle Statistiken erstellen
PROMPT ===========================================
 
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_auftragsperre');
EXEC PKG_STATS.GATHERTABLE (USER, 'clsc_ww_auftragsperre_e');