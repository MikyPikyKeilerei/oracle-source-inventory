/*******************************************************************************

Job:                  sc_ww_buchung
Beschreibung:         Job lädt Kundenumsatzdaten in das Source Core
          
Erstellt am:          13.09.2013
Erstellt von:         joeabd
Ansprechpartner:      joeabd, thowei
Ansprechpartner-IT:   -

verwendete Tabellen:  st_ww_buchung_b
                      sc_ww_kundenfirma
                      sc_ww_kundenfirma_ver
                      sc_ww_vertrgebiet
                      sc_ww_vertrgebiet_ver
                      sc_ww_likz
                      sc_ww_zahlungsart
                      sc_ww_lieferwukz
                      sc_ww_ersatzwunschkz
                      sc_ww_valutakz
                      sc_ww_zugesteurtkz
                      sc_ww_steuerungskz
                      sc_ww_sperrgrundkz                                                                 
                      
                       
Endtabellen:          kdwh.sc_ww_buchung

Fehler-Doku:      -
Ladestrecke:         https://confluence.witt-gruppe.eu/display/IM/Buchung

********************************************************************************
geändert am:          22.04.2016
geändert von:         andgag
Änderungen:           1.1: Vordefinierte Parameter verwenden
                            Doku verwendete Tabellen/Endtabelle ergänzt
********************************************************************************                            
geändert am:          18.05.2016
geändert von:         andgag
Änderungen:           1.2: Name der Error-Tabelle angepasst
                           Name der Cleanse-Tabelle angepasst
********************************************************************************                            
geändert am:          20.06.2016
geändert von:         andgag
Änderungen:           1.3: Prozessdatum von 06:00 Uhr auf 00:30 ändern.
                           Muss Datum von ST entsprechen. TRUNC bei Datumsvergleich
                           entfernt.
********************************************************************************                            
geändert am:          11.07.2016
geändert von:         andgag
Änderungen:           1.3: Anpassungen aus TODO-Liste
                           Anpassungen an Scriptkonventionen                           
********************************************************************************                            
geändert am:          13.04.2017
geändert von:         andgag
                      Referenzauflösung mit sc_ww_portokostenkz ausgebaut.
                      Wird nicht verwendet.
********************************************************************************                            
geändert am:          04.05.2017
geändert von:         andgag
                      Neue Spalten eingebaut: retbewegid, prozessid, fakturaid, auftrag_auftragpoolid                      
********************************************************************************                            
geändert am:          05.05.2017
geändert von:         andgag
                      Referenzauflösung mit Auftragsartkz entfernt, wird nicht mehr verwendet (Spaltenname TELEKZ)                                                                  
********************************************************************************                            
geändert am:          05.05.2017
geändert von:         andgag                      
                      Auftragposid eigebaut
********************************************************************************                            
geändert am:          12.04.2018
geändert von:         maxlin                      
                      Neue Spalten für Clearingstelle eingebaut: konto_id_key, konto_id_orig_key
                      Spalten aufgrund Clearingstelle entfernt: Kontonr, kundennr_orig
********************************************************************************                            
geändert am:          03.05.2018
geändert von:         maxlin                      
                      Neue Spalte stationaer_janein eingefügt 1:nicht stationär, 2:stationär
********************************************************************************                            
geändert am:          05.10.2018
geändert von:         joeabd                      
                      vkp_ohnerabatt eigebaut  
********************************************************************************                      
geändert am:          18.10.2018
geändert von:         joeabd                      
                      vkp_ohnerabatt => komwarenwert
********************************************************************************                      
geändert am:          18.10.2018
geändert von:         maxlin                        
                      stationaer_janein => stationaerkz    
********************************************************************************                      
geändert am:          21.11.2018
geändert von:         maxlin                        
                      Umzug auf KDWH 
********************************************************************************                      
geändert am:          25.03.2019
geändert von:         maxlin                        
                      Spalte komwarenwertgesamt eingebaut
********************************************************************************                      
geändert am:          06.09.2022
geändert von:         andgag                        
                      Neue Spalten eingebaut
                      AUFTRAG_BESTANDSTATUSID
                      AUFTRAG_POSITIONSTATUSID
                      BDFIRMKZ
                      BESTARTVKP
                      DIREKTKZ
                      KATABB
                      KATSEITE
                      NABRES_ZUGANG
                      VEK_ORIGSAISON
                      VKP_DSPR
                      VKP_STATUSID
                      VKPORIG
********************************************************************************                      
geändert am:          08.11.2023
geändert von:         benlin                        
                      DSGVO-kritische Spalten ausgebaut:
                        KONTONR
                        KONTO_ID
                        KUNDENNR_ORIG
                        KONTO_ID_ORIG
                        AUFTRPOSIDENTNR
                        FAKTURAID
********************************************************************************                      
geändert am:          12.03.2025
geändert von:         annfis                        
                      Spalte dwh_processdate ergänzt in Cleanse- und Endtabellen                      
*******************************************************************************/

ALTER SESSION ENABLE PARALLEL DML;

PROMPT =========================================================================
PROMPT Parameter
PROMPT GBV-Job ID   : &gbvid
PROMPT Prozesstermin: &termin
PROMPT =========================================================================



PROMPT =========================================================================
PROMPT
PROMPT 1. Source Core-Ladung
PROMPT Endtabelle: sc_ww_buchung
PROMPT
PROMPT =========================================================================



PROMPT ===========================================
PROMPT 1.1 Cleansing Tabellen leeren
PROMPT ===========================================

TRUNCATE TABLE clsc_ww_buchung;
TRUNCATE TABLE clsc_ww_buchung_1;



PROMPT ===========================================
PROMPT 1.2 Daten aus Stage Backup Tabelle laden
PROMPT ===========================================

-- Keine Unterscheidung new/update/delete notwendig, da immer Differenzdaten geladen werden!
INSERT /*+ APPEND */ 
INTO clsc_ww_buchung_1
(
  dwh_cr_load_id,
  buchungsdatum,
  firma,
--  kontonr,
--  konto_id,
  konto_id_key,
  kontoart,
  artikelnr,
  groesse,
  promotionnr,
  vtgebiet,
  katalogart,
  umsatzsaison,
--  kundennr_orig,
--  konto_id_orig,
  konto_id_orig_key,
  auftragsnr,
  auftrnrit_key,
  mailingnr,
  mwst,
  bek,
  vek,
  vkp,
  ansprachen,
  ansprachen_tele,
  brabs,
  brabsers,
  nali,
  nili,
  telenili,
  nina,
  retoure,
  nali_alter,
  ersverw,
  importanteil,
  nab,
  naboffen,
  nabres,
  naboffen_zugang,
  nabstorno,
  nums,
  umsstorno,
  labunito,
  labrus,
  brumsdiff_betrag,
  retdiff_betrag,
  likz,
  telekz,
  zahlungskz,
  lieferwunschkz,
  dattermwunsch,
  mgeinh,
  sammelsetkz,
--  auftrposidentnr,
  auftrnr_key,
  auftrpos,
  saison,
  etbereich,
  artikelgruppe,
  warengruppe,
  ersatzartikelnr,
  ersatzartikelgroesse,
  vkp_fakt,
  mappen_nr,
  ersatzwunschkz,
  anzraten,
  valutakz,
  portokostenkz,
  zugesteuertkz,
  steuerungskz,
  sperrgrundkz,
  uk_steuerkz,
  liefterminkz,
  bestarprom,
  vekneusai,
  etbereich_st,
  warengruppe_st,
  artikelgruppe_st,
  etbereich_bt,
  warengruppe_bt,
  artikelgruppe_bt,
  retbewegid_key,
  prozessid,
--  fakturaid,
  fakturaid_key,
  auftrag_auftragpoolid_key,
  auftragposid_key,
  stationaerkz,
  komwarenwert,
  komwarenwertgesamt,
  verarbkz,
  auftrag_bestandstatusid,
  auftrag_positionstatusid,
  bdfirmkz,
  bestartvkp,
  direktkz,
  katabb,
  katseite,
  nabres_zugang,
  vek_origsaison,
  vkp_dspr,
  vkp_statusid,
  vkporig,
  dwh_processdate
)
SELECT
  &gbvid,
  buchungsdatum,
  firma,
--  kontonr,
--  konto_id,
  konto_id_key,
  kontoart,
  artikelnr,
  groesse,
  promotionnr,
  vtgebiet,
  katalogart,
  umsatzsaison,
--  kundennr_orig,
--  konto_id_orig,
  konto_id_orig_key,
  auftragsnr,
  auftrnrit_key,
  mailingnr,
  mwst,
  bek,
  vek,
  vkp,
  ansprachen,
  ansprachen_tele,
  brabs,
  brabsers,
  nali,
  nili,
  telenili,
  nina,
  retoure,
  nali_alter,
  ersverw,
  importanteil,
  nab,
  naboffen,
  nabres,
  naboffen_zugang,
  nabstorno,
  nums,
  umsstorno,
  labunito,
  labrus,
  brumsdiff_betrag,
  retdiff_betrag,
  likz,
  telekz,
  zahlungskz,
  lieferwunschkz,
  dattermwunsch,
  mgeinh,
  sammelsetkz,
--  auftrposidentnr,
  auftrnr_key,
  auftrpos,
  saison,
  etbereich,
  artikelgruppe,
  warengruppe,
  ersatzartikelnr,
  ersatzartikelgroesse,
  vkp_fakt,
  mappen_nr,
  ersatzwunschkz,
  anzraten,
  valutakz,
  portokostenkz,
  zugesteuertkz,
  steuerungskz,
  sperrgrundkz,
  uk_steuerkz,
  liefterminkz,
  bestarprom,
  vekneusai,
  etbereich_st,
  warengruppe_st,
  artikelgruppe_st,
  etbereich_bt,
  warengruppe_bt,
  artikelgruppe_bt,
  retbewegid_key,
  prozessid,
--  fakturaid,
  fakturaid_key,
  auftrag_auftragpoolid_key,
  auftragposid_key,
  stationaerkz,
  komwarenwert,
  komwarenwertgesamt,
  verarbkz,
  auftrag_bestandstatusid,
  auftrag_positionstatusid,
  bdfirmkz,
  bestartvkp,
  direktkz,
  katabb,
  katseite,
  nabres_zugang,
  vek_origsaison,
  vkp_dspr,
  vkp_statusid,
  vkporig,
  dwh_processdate
FROM st_ww_buchung_b
WHERE dwh_processdate = &termin;

COMMIT;



PROMPT ===========================================
PROMPT 1.3 Aktuelle Statistiken erstellen
PROMPT ===========================================

EXEC pkg_stats.gathertable  (USER, 'clsc_ww_buchung_1');



PROMPT ===========================================
PROMPT 1.4 Error-Handling
PROMPT ===========================================

-- Hier erst mal nicht, Vorgehensweise noch nicht geklärt



PROMPT ===========================================
PROMPT 1.5 Einspielen in die letzte SC-Tabelle mit Referenzauflösung
PROMPT ===========================================

-- Bei Fehler in Referenzauflösung momentan INSERT in ERROR-Tabelle und SC-Tabelle, Warnmail im Abschluss-Script

INSERT /*+ APPEND */ ALL
WHEN 
(
  dwh_id_sc_ww_kundenfirma    IS NULL OR 
  dwh_id_sc_ww_vertrgebiet    IS NULL OR
  dwh_id_sc_ww_likz           IS NULL OR 
  dwh_id_sc_ww_auftragsartkz  IS NULL OR
  dwh_id_sc_ww_zahlungskz     IS NULL OR 
  dwh_id_sc_ww_lieferwukz     IS NULL OR
  dwh_id_sc_ww_mgeinh         IS NULL OR  
  dwh_id_sc_ww_ersatzwunschkz IS NULL OR 
  dwh_id_sc_ww_valutakz       IS NULL OR 
  dwh_id_sc_ww_zugesteuertkz  IS NULL OR
  dwh_id_sc_ww_steuerungskz   IS NULL OR 
  dwh_id_sc_ww_sperrgrundkz   IS NULL OR
  dwh_id_sc_ww_stationaerkz   IS NULL OR
  dwh_id_sc_ww_kontoart       IS NULL OR 
  dwh_id_sc_ww_kdumsverarbkz  IS NULL 
) THEN
INTO clsc_ww_buchung_e
(
  dwh_cr_load_id,
  dwh_up_load_id,
  dwh_id_sc_ww_kundenfirma,
  dwh_id_sc_ww_vertrgebiet,
  dwh_id_sc_ww_likz,
  dwh_id_sc_ww_auftragsartkz,
  dwh_id_sc_ww_zahlungskz,
  dwh_id_sc_ww_lieferwukz,
  dwh_id_sc_ww_mgeinh,
  dwh_id_sc_ww_ersatzwunschkz,
  dwh_id_sc_ww_valutakz,
  dwh_id_sc_ww_zugesteuertkz,
  dwh_id_sc_ww_steuerungskz,
  dwh_id_sc_ww_sperrgrundkz,
  dwh_id_sc_ww_stationaerkz,
  dwh_id_sc_ww_kontoart,
  dwh_id_sc_ww_kdumsverarbkz,
  buchungsdatum,
  firma,
--  kontonr,
--  konto_id,
  konto_id_key,
  kontoart,
  artikelnr,
  groesse,
  promotionnr,
  vtgebiet,
  katalogart,
  umsatzsaison,
--  kundennr_orig,
--  konto_id_orig,
  konto_id_orig_key,
  auftragsnr,
  auftrnrit_key,
  mailingnr,
  mwst,
  bek,
  vek,
  vkp,
  ansprachen,
  ansprachen_tele,
  brabs,
  brabsers,
  nali,
  nili,
  telenili,
  nina,
  retoure,
  nali_alter,
  ersverw,
  importanteil,
  nab,
  naboffen,
  nabres,
  naboffen_zugang,
  nabstorno,
  nums,
  umsstorno,
  labunito,
  labrus,
  brumsdiff_betrag,
  retdiff_betrag,
  likz,
  telekz,
  zahlungskz,
  lieferwunschkz,
  dattermwunsch,
  mgeinh,
  sammelsetkz,
--  auftrposidentnr,
  auftrnr_key,
  auftrpos,
  saison,
  etbereich,
  artikelgruppe,
  warengruppe,
  ersatzartikelnr,
  ersatzartikelgroesse,
  vkp_fakt,
  mappen_nr,
  ersatzwunschkz,
  anzraten,
  valutakz,
  portokostenkz,
  zugesteuertkz,
  steuerungskz,
  sperrgrundkz,
  uk_steuerkz,
  liefterminkz,
  bestarprom,
  vekneusai,
  etbereich_st,
  warengruppe_st,
  artikelgruppe_st,
  etbereich_bt,
  warengruppe_bt,
  artikelgruppe_bt,
  retbewegid_key,
  prozessid,
--  fakturaid,
  fakturaid_key,
  auftrag_auftragpoolid_key,
  auftragposid_key,
  stationaerkz,
  komwarenwert,
  komwarenwertgesamt,
  verarbkz,
  auftrag_bestandstatusid,
  auftrag_positionstatusid,
  bdfirmkz,
  bestartvkp,
  direktkz,
  katabb,
  katseite,
  nabres_zugang,
  vek_origsaison,
  vkp_dspr,
  vkp_statusid,
  vkporig,
  dwh_processdate
)
VALUES
(
  dwh_cr_load_id,
  &gbvid,
  dwh_id_sc_ww_kundenfirma,
  dwh_id_sc_ww_vertrgebiet,
  dwh_id_sc_ww_likz,
  dwh_id_sc_ww_auftragsartkz,
  dwh_id_sc_ww_zahlungskz,
  dwh_id_sc_ww_lieferwukz,
  dwh_id_sc_ww_mgeinh,
  dwh_id_sc_ww_ersatzwunschkz,
  dwh_id_sc_ww_valutakz,
  dwh_id_sc_ww_zugesteuertkz,
  dwh_id_sc_ww_steuerungskz,
  dwh_id_sc_ww_sperrgrundkz,
  dwh_id_sc_ww_stationaerkz,
  dwh_id_sc_ww_kontoart,
  dwh_id_sc_ww_kdumsverarbkz,
  buchungsdatum,
  firma,
--  kontonr,
--  konto_id,
  konto_id_key,
  kontoart,
  artikelnr,
  groesse,
  promotionnr,
  vtgebiet,
  katalogart,
  umsatzsaison,
--  kundennr_orig,
--  konto_id_orig,
  konto_id_orig_key,
  auftragsnr,
  auftrnrit_key,
  mailingnr,
  mwst,
  bek,
  vek,
  vkp,
  ansprachen,
  ansprachen_tele,
  brabs,
  brabsers,
  nali,
  nili,
  telenili,
  nina,
  retoure,
  nali_alter,
  ersverw,
  importanteil,
  nab,
  naboffen,
  nabres,
  naboffen_zugang,
  nabstorno,
  nums,
  umsstorno,
  labunito,
  labrus,
  brumsdiff_betrag,
  retdiff_betrag,
  likz,
  telekz,
  zahlungskz,
  lieferwunschkz,
  dattermwunsch,
  mgeinh,
  sammelsetkz,
--  auftrposidentnr,
  auftrnr_key,
  auftrpos,
  saison,
  etbereich,
  artikelgruppe,
  warengruppe,
  ersatzartikelnr,
  ersatzartikelgroesse,
  vkp_fakt,
  mappen_nr,
  ersatzwunschkz,
  anzraten,
  valutakz,
  portokostenkz,
  zugesteuertkz,
  steuerungskz,
  sperrgrundkz,
  uk_steuerkz,
  liefterminkz,
  bestarprom,
  vekneusai,
  etbereich_st,
  warengruppe_st,
  artikelgruppe_st,
  etbereich_bt,
  warengruppe_bt,
  artikelgruppe_bt,
  retbewegid_key,
  prozessid,
--  fakturaid,
  fakturaid_key,
  auftrag_auftragpoolid_key,
  auftragposid_key,
  stationaerkz,
  komwarenwert,
  komwarenwertgesamt,
  verarbkz,
  auftrag_bestandstatusid,
  auftrag_positionstatusid,
  bdfirmkz,
  bestartvkp,
  direktkz,
  katabb,
  katseite,
  nabres_zugang,
  vek_origsaison,
  vkp_dspr,
  vkp_statusid,
  vkporig,
  dwh_processdate
)
ELSE
INTO clsc_ww_buchung
(
  dwh_cr_load_id,
  dwh_id_sc_ww_kundenfirma,
  dwh_id_sc_ww_vertrgebiet,
  dwh_id_sc_ww_likz,
  dwh_id_sc_ww_auftragsartkz,  -- spalte kann entfernt werden (telekz wird nicht in cc-Buchung verwendet)
  dwh_id_sc_ww_zahlungskz,
  dwh_id_sc_ww_lieferwukz,
  dwh_id_sc_ww_mgeinh,
  dwh_id_sc_ww_ersatzwunschkz,
  dwh_id_sc_ww_valutakz,
  dwh_id_sc_ww_zugesteuertkz,
  dwh_id_sc_ww_steuerungskz,
  dwh_id_sc_ww_sperrgrundkz,
  dwh_id_sc_ww_stationaerkz,
  dwh_id_sc_ww_kontoart,
  dwh_id_sc_ww_kdumsverarbkz,
  buchungsdatum,
  firma,
--  kontonr,
--  konto_id,
  konto_id_key,
  kontoart,
  artikelnr,
  groesse,
  promotionnr,
  vtgebiet,
  katalogart,
  umsatzsaison,
--  kundennr_orig,
--  konto_id_orig,
  konto_id_orig_key,
  auftragsnr,
  auftrnrit_key,
  mailingnr,
  mwst,
  bek,
  vek,
  vkp,
  ansprachen,
  ansprachen_tele,
  brabs,
  brabsers,
  nali,
  nili,
  telenili,
  nina,
  retoure,
  nali_alter,
  ersverw,
  importanteil,
  nab,
  naboffen,
  nabres,
  naboffen_zugang,
  nabstorno,
  nums,
  umsstorno,
  labunito,
  labrus,
  brumsdiff_betrag,
  retdiff_betrag,
  likz,
  telekz,
  zahlungskz,
  lieferwunschkz,
  dattermwunsch,
  mgeinh,
  sammelsetkz,
--  auftrposidentnr,
  auftrnr_key,
  auftrpos,
  saison,
  etbereich,
  artikelgruppe,
  warengruppe,
  ersatzartikelnr,
  ersatzartikelgroesse,
  vkp_fakt,
  mappen_nr,
  ersatzwunschkz,
  anzraten,
  valutakz,
  portokostenkz,
  zugesteuertkz,
  steuerungskz,
  sperrgrundkz,
  uk_steuerkz,
  liefterminkz,
  bestarprom,
  vekneusai,
  etbereich_st,
  warengruppe_st,
  artikelgruppe_st,
  etbereich_bt,
  warengruppe_bt,
  artikelgruppe_bt,
  retbewegid_key,
  prozessid,
--  fakturaid,
  fakturaid_key,
  auftrag_auftragpoolid_key,
  auftragposid_key,
  stationaerkz,
  komwarenwert,
  komwarenwertgesamt,
  verarbkz,
  auftrag_bestandstatusid,
  auftrag_positionstatusid,
  bdfirmkz,
  bestartvkp,
  direktkz,
  katabb,
  katseite,
  nabres_zugang,
  vek_origsaison,
  vkp_dspr,
  vkp_statusid,
  vkporig,
  dwh_processdate
)
SELECT 
  a.dwh_cr_load_id,
  kdfirm.dwh_id AS dwh_id_sc_ww_kundenfirma,
  vertg.dwh_id AS dwh_id_sc_ww_vertrgebiet,
  sc_ww_likz.dwh_id AS dwh_id_sc_ww_likz,
  -3  AS dwh_id_sc_ww_auftragsartkz,  -- spalte kann entfernt werden, wird nicht in cc_buchung verwendet.
  sc_ww_zahlungskz.dwh_id AS dwh_id_sc_ww_zahlungskz,
  sc_ww_lieferwukz.dwh_id AS dwh_id_sc_ww_lieferwukz,
  sc_ww_mgeinh.dwh_id AS dwh_id_sc_ww_mgeinh,
  sc_ww_ersatzwunschkz.dwh_id AS dwh_id_sc_ww_ersatzwunschkz,
  sc_ww_valutakz.dwh_id AS dwh_id_sc_ww_valutakz,
  sc_ww_zugesteuertkz.dwh_id AS dwh_id_sc_ww_zugesteuertkz,
  sc_ww_steuerungskz.dwh_id AS dwh_id_sc_ww_steuerungskz,
  sc_ww_sperrgrundkz.dwh_id AS dwh_id_sc_ww_sperrgrundkz,
  sc_ww_stationaerkz.dwh_id AS dwh_id_sc_ww_stationaerkz,
  sc_ww_kontoart.dwh_id AS dwh_id_sc_ww_kontoart,
  sc_ww_kdumsverarbkz.dwh_id AS dwh_id_sc_ww_kdumsverarbkz,
  a.buchungsdatum,
  a.firma,
--  a.kontonr,
--  a.konto_id,
  a.konto_id_key,
  a.kontoart,
  a.artikelnr,
  a.groesse,
  a.promotionnr,
  a.vtgebiet,
  a.katalogart,
  a.umsatzsaison,
--  a.kundennr_orig,
--  a.konto_id_orig,
  a.konto_id_orig_key,
  a.auftragsnr,
  a.auftrnrit_key,
  a.mailingnr,
  a.mwst,
  a.bek,
  a.vek,
  a.vkp,
  a.ansprachen,
  a.ansprachen_tele,
  a.brabs,
  a.brabsers,
  a.nali,
  a.nili,
  a.telenili,
  a.nina,
  a.retoure,
  a.nali_alter,
  a.ersverw,
  a.importanteil,
  a.nab,
  a.naboffen,
  a.nabres,
  a.naboffen_zugang,
  a.nabstorno,
  a.nums,
  a.umsstorno,
  a.labunito,
  a.labrus,
  a.brumsdiff_betrag,
  a.retdiff_betrag,
  a.likz,
  a.telekz,
  a.zahlungskz,
  a.lieferwunschkz,
  a.dattermwunsch,
  a.mgeinh,
  a.sammelsetkz,
--  a.auftrposidentnr,
  a.auftrnr_key,
  a.auftrpos,
  a.saison,
  a.etbereich,
  a.artikelgruppe,
  a.warengruppe,
  a.ersatzartikelnr,
  a.ersatzartikelgroesse,
  a.vkp_fakt,
  a.mappen_nr,
  a.ersatzwunschkz,
  a.anzraten,
  a.valutakz,
  a.portokostenkz,
  a.zugesteuertkz,
  a.steuerungskz,
  a.sperrgrundkz,
  a.uk_steuerkz,
  a.liefterminkz,
  a.bestarprom,
  a.vekneusai,
  a.etbereich_st,
  a.warengruppe_st,
  a.artikelgruppe_st,
  a.etbereich_bt,
  a.warengruppe_bt,
  a.artikelgruppe_bt,
  a.retbewegid_key,
  a.prozessid,
--  a.fakturaid,
  a.fakturaid_key,
  a.auftrag_auftragpoolid_key,
  a.auftragposid_key,
  a.stationaerkz,
  a.komwarenwert,
  a.komwarenwertgesamt,
  a.verarbkz,
  a.auftrag_bestandstatusid,
  a.auftrag_positionstatusid,
  a.bdfirmkz,
  a.bestartvkp,
  a.direktkz,
  a.katabb,
  a.katseite,
  a.nabres_zugang,
  a.vek_origsaison,
  a.vkp_dspr,
  a.vkp_statusid,
  a.vkporig,
  a.dwh_processdate
FROM clsc_ww_buchung_1 a
LEFT OUTER JOIN (SELECT kfh.dwh_id, kfv.kdfirmkz
        FROM sc_ww_kundenfirma kfh JOIN sc_ww_kundenfirma_ver kfv
        ON (kfh.dwh_id = kfv.dwh_id_head AND &termin BETWEEN kfv.dwh_valid_from AND kfv.dwh_valid_to)) kdfirm
  ON (a.firma = kdfirm.kdfirmkz)
LEFT OUTER JOIN (SELECT vgh.dwh_id, vgv.vertrgebiet
        FROM sc_ww_vertrgebiet vgh JOIN sc_ww_vertrgebiet_ver vgv
        ON (vgh.dwh_id = vgv.dwh_id_head AND &termin BETWEEN vgv.dwh_valid_from AND vgv.dwh_valid_to)) vertg
  ON (a.vtgebiet = vertg.vertrgebiet)
LEFT OUTER JOIN sc_ww_likz
  ON (sc_ww_likz.wert = a.likz)
LEFT OUTER JOIN sc_ww_zahlungskz
  ON (sc_ww_zahlungskz.wert = COALESCE (a.zahlungskz, '$'))
LEFT OUTER JOIN sc_ww_lieferwukz
  ON (sc_ww_lieferwukz.wert = COALESCE(a.lieferwunschkz, -3))
LEFT OUTER JOIN sc_ww_mgeinh
  ON (sc_ww_mgeinh.wert = a.mgeinh)
LEFT OUTER JOIN sc_ww_ersatzwunschkz
  ON (sc_ww_ersatzwunschkz.wert = COALESCE(a.ersatzwunschkz, -3))
LEFT OUTER JOIN sc_ww_valutakz
  ON (sc_ww_valutakz.wert = COALESCE(a.valutakz, 0))
LEFT OUTER JOIN sc_ww_zugesteuertkz
  ON (sc_ww_zugesteuertkz.wert = COALESCE(a.zugesteuertkz, -3))
LEFT OUTER JOIN sc_ww_steuerungskz
  ON (sc_ww_steuerungskz.wert = COALESCE(a.steuerungskz, -3))
LEFT OUTER JOIN sc_ww_sperrgrundkz
  ON (sc_ww_sperrgrundkz.wert = COALESCE(a.sperrgrundkz, -3))
LEFT OUTER JOIN sc_ww_stationaerkz
  ON (sc_ww_stationaerkz.wert = COALESCE(a.stationaerkz, -3))
LEFT OUTER JOIN sc_ww_kontoart
  ON (sc_ww_kontoart.wert = COALESCE(a.kontoart, -3))
LEFT OUTER JOIN sc_ww_kdumsverarbkz
  ON (sc_ww_kdumsverarbkz.wert = COALESCE(a.verarbkz,'-3'));

COMMIT;



DECLARE

 v_error NUMBER;
 v_buchung NUMBER;

BEGIN

 SELECT COUNT(*) 
 INTO v_error
 FROM clsc_ww_buchung_e
 WHERE dwh_cr_load_id = dwh_up_load_id;
 
 SELECT COUNT(*)
 INTO v_buchung
 FROM clsc_ww_buchung_1;

 IF v_error/v_buchung*100 > 3 THEN
   RAISE_APPLICATION_ERROR(-20029,'Data loss when loading SC!');
 END IF;

END;
/