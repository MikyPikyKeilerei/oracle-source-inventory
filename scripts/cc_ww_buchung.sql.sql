/*******************************************************************************

Job:              cc_ww_buchung
Beschreibung:     Laedt Stammgeschäfts-Buchungsdaten ins Common Core
          
Erstellt am:        10.10.2013
Erstellt von:      Jörg Abdinghoff, Thomas Weiß 
Ansprechpartner:   (Andrea Gagulic, Stefan Ernstberger (ab 01.04.2016))  
                   DAA-DRP: Stefan Ernstberger, Benjamin Lingl, Maria Lura Silveanu (ab Oktober 2025)
Ansprechpartner-IT: -

verwendete Tabellen:  cc_auftrstorno
                      cc_artstat
                      cc_ausstattung_dir
                      cc_buchung
                      cc_ersart                      
                      cc_firma
                      cc_lvsteuerung                      
                      cc_meterware  
                      cc_ratenwunsch
                      cc_sperrgrund                      
                      cc_valuta                      
                      cc_zahlwunsch
                      cc_stationaerkz                      
                      sc_bestellzaehler                          
                      sc_ww_alfa_ersatzart
                      sc_ww_alfa_ersatzart_ver
                      sc_ww_auftrstornokz
                      sc_ww_auftrstornokz_ver
                      sc_ww_buchung
                      sc_ww_ersatzwunschkz
                      sc_ww_ersatzwunsch_ver                      
                      sc_ww_interessent
                      sc_ww_interessent_ver    
                      sc_ww_kundenfirma
                      sc_ww_kundenfirma_ver
                      sc_ww_lieferwunsch                   
                      sc_ww_lieferwunsch_ver                      
                      sc_ww_likz
                      sc_ww_likz_ver  
                      sc_ww_mgeinh
                      sc_ww_mgeinh_ver                      
                      sc_ww_steuerungskz
                      sc_ww_steuerungskz_ver
                      sc_ww_sperrgrundkz
                      sc_ww_sperrgrundkz_ver                      
                      sc_ww_valutakz
                      sc_ww_valutakz_ver 
                      sc_ww_vertrgebiet_ver
                      sc_ww_zahlungskz
                      sc_ww_zahlungskz_ver
                      sc_ww_zahlmethode_ver
                      sc_ww_zahlwunsch_ver                      
                      sc_ww_zugestartartkz
                      sc_ww_zugestartartkz_Ver
                      sc_ww_retbeweg
                      sc_ww_retbeweg_ver
                      sc_ww_intabwicklkto
                      sc_ww_intabwicklkto_ver                     
                      sc_ww_auftragkopf_ver
                      sc_ww_auftragpos_ver                     
                      sc_im_tgv_wkz_umcod_ver                   
                      cc_art

Endtabellen:          cc_buchung


Fehler-Doku:      
Ladestrecke:         https://confluence.witt-gruppe.eu/display/IM/Buchung

*/

/********************************************************************************
geändert am:          17.06.2015
geändert von:         joeabd
Änderungen:           ##.1: VFKZ angepasst. VFKZ 3 vorgezogen, ART mit einbezogen 

geändert am:          22.06.2015
geändert von:         joeabd
Änderungen:           ##.2: Umstellung auf andere Vertriebsgebiets-Tabelle,
                            Vertriebsgebiet-Spalte
                            
geändert am:          25.06.2015
geändert von:         joeabd
Änderungen:           ##.3: VFKZ-Ermittlung vorgezogen, Join nicht über Artikel-ID, sondern über Artikelnr, etc.
                      (Grund: Artikel-Id ist teilweise abhängig von Ausstattungs-ID, 
                       die aber von der Firma abhängig ist -> wäpu!)
                       Sonderbehandlung WäPu eingefügt.

geändert am:          09.07.2015
geändert von:         joeabd
Änderungen:           ##.4: Interessenten werden nicht mehr auf aktuell gültige Datensätze eingeschränkt. 
                       Grund sind Buchungen (NAB-Stornos)
                       von bereits gelöschten Interessenten. Nummernkreis Interessenten <-> Kunden sind überschneidungsfrei! 
                       Es wird zukünftig auch 300 Tage in die Vergangenheit geschaut

geändert am:          16.11.2015
geändert von:         joeabd
Änderungen:           ##.5: Wp-Trennung neues Package verwenden    


geändert am:          16.12.2015
geändert von:         joeabd
Änderungen:           ##.6: Statement 2.1.2 noparallel, da remote-Zugriff durchgeführt wird

geändert am:          09.02.2016
geändert von:         joeabd
Änderungen:           ##.7: Bei Zugriff auf Auftragspos (2.12.1) MIN(anldat) verwenden und danach gruppieren - analog kdums!

geändert am:          04.04.2016
geändert von:         andgag
Änderungen:           ##.8: Parallel Hints rausnehmen, Schlüsselwörter in Großschreibung, Tabellen und Spalten klein, Funktionen groß
                      CL-Tabellen (1..n) an Konventionen angepasst
                      
geändert am:          22.04.2016
geändert von:         andgag
Änderungen:           ##.9: Jobkommentar an Konventionen angepasst. Vordefinierte Parameter verwenden.                  

geändert am:          19.05.2016
geändert von:         andgag
Änderungen:           ##.10: letzte CL-Tabelle umbenannt, Liste verwendeter Tabellen aufgebaut

geändert am:          28.09.2016
geändert von:         steern
Änderungen:           ##.11: SC_WW_INTERESSENT war noch nicht auf Produktivdatenbank verlinkt ! 


geändert am:          10.11.2016
geändert von:         andgag
Änderungen:           ##.12: sc_ww_auftragkopf/auftragpos sc_ww_auftragkopf_ver/auftragpos_ver wurde auf UDWH verschoben. 
                      Datenbanklink eingebaut.
                      
geändert am:          21.11.2016
geändert von:         andgag
Änderungen:           ##.13: Umbau der CC-Referenzen: 0=Unbekannt wurde eingebaut. Werte anpassen bei direkter Codierung.

geändert am:          24.11.2016
geändert von:         joeabd
Änderungen:           ##.14: Anpassung Zugriff auf Ausstattung

geändert am:          06.12.2016
geändert von:         joeabd
Änderungen:           ##.15: Erweiterung div. CL-Tabellen um dwh_cr_load_id; Umbennenung von 3 CL-Tabellen

geändert am:          06.12.2016
geändert von:         andgag
Änderungen:           ##.16: Kontart 3 bei Firmen (29,30,33) eingebaut

geändert am:          07.12.2016
geändert von:         joeabd + stegrs
Änderungen:           ##.17: 300-Tage-Eingrenzung bei Auftragpos entfernt.
                      COALESCE auf -3 bei Zahlwunsch- und -methodekz entfernt.
                      
geändert am:          31.01.2017
geändert von:         andgag
Änderungen:           ##.18: Formatierung an Konventionen angepasst
                      Spalten stehen untereinander, alle Spalten explizit angeben
                      
geändert am:          23.02.2017
geändert von:         joeabd
Änderungen:           ##.19: loader .art durch cc_art ersetzt

geändert am:          03.03.2017
geändert von:         andgag
Änderungen:           ##.20: Mailingnummer als Bedingung für Lieferkzermittlung nicht relevant. 
                      Deshalb aus Bedingung entfernt für Lieferkz 2 = NILI. 
                      (Spalte Mailingnr wird nach Hostmig nicht mehr geliefert.)
                      Bei Wäschepur-Trennung der Gutscheinartikel Mailnr aus Auftragkopf verwenden (Cleanse-Tabelle 27 wurde eingebaut)
                      Auffuellen der Mailingnr aus anderen Buchungen rausgegenommen...wird nicht mehr benötigt.
                      Mailingnr aus Schnittstelle wird nicht mehr verwendet.
                      
geändert am:          30.03.2017
geändert von:         andgag
Änderungen:           ##.21: Referenzauflösung geändert: sc_ww_liefwunschkz ersetzt durch sc_ww_lieferwunsch 

geändert am:          06.04.2017
geändert von:         andgag
Änderungen:           ##.22: Mailnummern bei schriftlichen Bestellungen (Bestwegkz = 1) ausnullen                       

geändert am:          05.05.2017
geändert von:         andgag
Änderungen:           ##.23: Neue Spalten eingebaut: retbewegid, prozessid, fakturaid, auftrag_auftragpoolid
                            imhostmig
                            
geändert am:          08.05.2017
geändert von:         andgag
Änderungen:           ##.24: Neue Spalte eingebaut: auftragposid                            

geändert am:          07.06.2017
geändert von:         andgag
Änderungen:           ##.25: Zahlart eingebaut (tatsächliche Zahlart aus Auftragpool)                           

geändert am:          09.06.2017
geändert von:         andgag
Änderungen:           ##.26: Zahlwunsch_1 Quelle ab Hostmig aus Auftragkopf (vorher KKH)                          

geändert am:          09.06.2017
geändert von:         andgag
Änderungen:           ##.27: Auftragkopf und Auftragpos werden ab sofort aus neuer Ladung von Udwht2 verwendet.
                            Startbedingungen wurden angepasst.
                            Hintergrund: Neuere Spalten z.B. auftragkopf.zahlmethodeid wurden in alte Ladung nicht eingebaut.                            
                            
geändert am:          09.06.2017
geändert von:         andgag
Änderungen:           ##.28: Ratenwunsch Quelle ab Hostmig aus Auftragkopf (vorher KKH)                                                      

geändert am:          12.06.2017
geändert von:         andgag
Änderungen:           ##.29: Verskostfreigrund aus Auftragpool eingebaut             

geändert am:          12.06.2017
geändert von:         andgag
Änderungen:           ##.30: positionsstatus, liefauskunftakt, liefauskunftkom aus Auftragpool eingebaut             

geändert am:          10.08.2017
geändert von:         andgag
Änderungen:           ##.31: Mailnr für 1,2,3 auf 0 setzen, nur noch Internet durchlassen (vorher nur 1 auf 0 gesetzt.)     

geändert am:          11.08.2017
geändert von:         joeabd
Änderungen:           ##.32: Anpassung wg. Ausstattungsänderung (Struktur)  

geändert am:          11.10.2017
geändert von:         andgag
Änderungen:           ##.33: Folgebuchungen muessen die gleiche Firma wie die Ansprachebuchung haben 

geändert am:          07.11.2017
geändert von:         joeabd
Änderungen:           ##.34: cc_art bei VF-Kennzeichen-Ermittlung entfernt, da Sortimentsspalte entfällt (4.2).
                              3.2.1 auf "neue" TGV-Tabelle umgebaut


geändert am:          06.12.2017
geändert von:         joeabd
Änderungen:           ##.35: Lieferkennzeichen 21 angepasst. 
                            Lieferwunschkz zukünftig aus auftragkopf
                            
geändert am:          18.01.2018
geändert von:         joeabd
Änderungen:           ##.36: Einbau RetErfdat aus sc_ww_retbeweg 

geändert am:          02.03.2018
geändert von:         joeabd
Änderungen:           ##.37: Umcodierung Interessenten-Abwicklungskonten 

geändert am:          13.03.2018
geändert von:         joeabd
Änderungen:           ##.38: Setzen INR-ID für Interessenten-Abwicklungskonten.
                            VF in VFART umbenannt.
                            Sammelset zukünftig -2

geändert am:          16.03.2018
geändert von:         joeabd
Änderungen:           ##.39: Auftrstornokz für Nach-Host-Mig-Zeiten über
                            Positionsstatus ermitteln

geändert am:          04.05.2018
geändert von:         joeabd
Änderungen:           ##.40: Umbau VF-Kennzeichen-Ermittlung auf Marktkz
                      IMHostmig-Kennzeichen fix auf 1 (bis zum endgültigen Ausbau)

geändert am:          09.05.2018
geändert von:         joeabd
Änderungen:           ##.41: Ref-Auflösungen für Positionsstatus, Lieferauskunft.
                      Integration Lagerdifferenzwert und Impantwert
                      Zahlungsmethoden aus Vor-Host-Mig-Zeiten (2.15, 2.16) entfernt


geändert am:          10.05.2018
geändert von:         joeabd
Änderungen:           ##.42: ARTGRVT_ID eingebaut. Korrektur NALIGrund (Integration
                      NALIGrund 8 und 9)
                      
geändert am:          22.05.2018
geändert von:         joeabd
Änderungen:           ##.43: Daten, die basierend auf auftragpoolid gesetzt werden, werden 
                      ggf. aus cc_buchung übernommen (auftragpoolid z.B. bei Retouren nicht gesetzt).
                      Einbau beilagenr.


geändert am:          23.05.2018
geändert von:         joeabd
Änderungen:           ##.44: Sperrgrundkz und Steuerungskz (LVSteuerung) auf Basis von Posstatus berechnet. 
                      Wird über Schnittstelle nicht mehr befüllt => dort entfernt.
                      Liefterminkz = Liefinfo fix -2 (gibts nicht mehr). UK_Steuerkz entfernt.
                      Valuta basierend auf Ratenwunsch/zahlwunschkz_cc ermitteln.
                      Korrektur Ersatzwunschkennzeichen und Entfernen aus Punkt 1. und 2.
                          
-- geändert am:          24.05.2018
-- geändert von:         maxlin                      
--                      ##.45: Umbau aufgrund der Clearingstelle                 

geändert am:          04.07.2018
geändert von:         joeabd
Änderungen:           ##.45: Korrektur Berechnung Lagerdifferenzwert

geändert am:          08.07.2018
geändert von:         joeabd
Änderungen:           ##.46: Bugfix Lagerdifferenzwert

geändert am:          10.07.2018
geändert von:         joeabd
Änderungen:           ##.47: Bugfix Erslief (es werden immer CC-Kennzeichen verwendet). Integration Lagerdiffmenge.
                      Verkpreis (letzte Cleanse-Tabelle) heißt jetzt VKP (sonst ändert sich nix :) )
                      Bugfix Ausstattung_dir_id: Echtversand wurde in Ausstattung auf "2" umgestellt, im Skript wurde
                      das aber nicht berücksichtigt
                      
geändert am:          11.07.2018
geändert von:         joeabd
Änderungen:           ##.48: Ausstattung_id: Bei nicht eindeutigen IDs einheitlich Min-Funktion

geändert am:          14.07.2018
geändert von:         joeabd
Änderungen:           ##.49: Bugfix Ausstattung_id: Folgebuchungen werden auch bei taggleichen Bestellbuchungen berücksichtigt


geändert am:          25.07.2018
geändert von:         joeabd
Änderungen:           ##.50: Anpassung Packages wg. Umzug UDWHT2 -> UDWH
                      Umzug UDWHT2 -> UDWH
                      
geändert am:          27.07.2018
geändert von:         joeabd
Änderungen:           ##.51: Anpassungen Default-Datensätze im letzten Insert

geändert am:          31.07.2018
geändert von:         joeabd
Änderungen:           ##.52: Umbau 2.4.1 Ausstattung: Auflösung über cc_vtsaison geht nicht mehr durch => DWH-Werte hartcodiert
                              Bugfix Zahlmethode/Zahlwunsch (aus -2 mach 0, für CS-Firmen Ratenwunsch auf -3)
                              
geändert am:          01.08.2018
geändert von:         joeabd
Änderungen:           ##.52: SG-Wert in Ratenwusch nicht immer numerisch => angepasst
                            Integration ECC und Bestellkanal
                            
geändert am:          14.08.2018
geändert von:         joeabd
Änderungen:           ##.53: Valuta umbenannt zu Valutawunsch.
                             Integration Ratenfakt und Valutafakt.
                             
geändert am:          27.08.2018
geändert von:         andgag
Änderungen:           ##.54: Korrektur bei Auflösung mit cc_auftrposstatus                        

geändert am:          10.10.2018
geändert von:         joeabd
Änderungen:           ##.55: Integration [anspr/brabs/nums/ret]ohnerabatt
                      Einbau Referenzauflösung zu cc_katart 
                      
geändert am:          18.10.2018
geändert von:         joeabd
Änderungen:           ##.56: Änderung Berechnung "Ohne Rabatt"-Spalten

geändert am:          24.10.2018
geändert von:         joeabd
Änderungen:           ##.57: Anpassung für Berechnungsumstellung diverse Werte

geändert am:          05.11.2018
geändert von:         joeabd
Änderungen:           ##.58: Korrektur ECC-Zuweisung

geändert am:          07.11.2018
geändert von:         joeabd
Änderungen:           ##.59: Einbau Gutscheindaten_ID

geändert am:          20.11.2018
geändert von:         steplo
Änderungen:           ##.60: Merge unter 2.19 lief nicht mehr und hat Temp-TS
                             geflutet. Joins angepasst und weitere
                             Cleansetabelle für Verarbeitung angelegt.

geändert am:          28.11.2018
geändert von:         joeabd
Änderungen:           ##.61: Fix Konto-ID bei CRS-Firmen (und Kontonr > 0) 
                      - hier nicht umgesetzt, da Konto_ID setzen entfällt

geändert am:          30.11.2018
geändert von:         andgag
Änderungen:           ##.62: Zugriff auf Versionstabelle über dwh_valid_to

geändert am:          12.12.2018
geändert von:         joeabd
Änderungen:           ##.63: KdNali durch Positionsstatus ersetzen 

geändert am:          13.03.2019
geändert von:         joeabd
Änderungen:           ##.64: Ersatzlieferung für Folgebuchungen vorgezogen, da diese für Art_id-Ermittlung benötigt wird.
                      Anpassung Ermittlung art_id.
                      Anpassungen Ermittlung VFArt 4: Nicht mehr über Artnr 999%, sondern über KT-Warengruppe 73.6
                      
geändert am:          19.03.2019
geändert von:         joeabd
Änderungen:           ##.65: TGVTSAISON mit Referenzauflösung (im SG immer -3)

geändert am:          10.04.2019
geändert von:         joeabd
Änderungen:           ##.66: Diverse Anpassungen, v.a. aufgrund wp-Trennung. Änderungen mit ##.66 gekennzeichnet

geändert am:          11.04.2019
geändert von:         maxlin
Änderungen:           ##.67: Verschiedene Anpassungen. Änderungen mit ##.67 gekennzeichnet
                      zu Punkt:Bei 2.13.3 (Merge) und 2.13.4 (Update) werden mehr Kunden im
                      Bestellzaehler gefunden. 
                      
geändert am:          07.08.2019
geändert von:         joeabd
Änderungen:           ##.68: Bei 2.4.2 Einschränkung auf "Auftrnr_key is not null" 

geändert am:          09.10.2019
geändert von:         maxlin
Änderungen:           ##.69: Umbiegeausstattung (cc_ausstattung_dir_udwh) durch cc_ausstattung_dir_v ersetzt
                             --> ausstattung_id wird VARCHAR2
geändert am:          02.12.2019
geändert von:         elifal
Änderungen:           ##.70:neue Spalte crossborderversand eingebaut
********************************************************************
geändert am:          13.05.2020
geändert von:         andgag
Änderungen:           ##.71: Vf-KZ Identifizierung jetzt aus cc_obermarktkt statt aus cc_marktkz
********************************************************************
geändert am:          29.05.2020
geändert von:         andgag
Änderungen:           ##.72: Firma_cc 33 ausschließen (Ersatz durch cc_uk_Buchung)
********************************************************************
geändert am:          04.06.2020
geändert von:         andgag
Änderungen:           ##.73: Wäschepur wird eigene Firma ab 05.06.
********************************************************************
geändert am:          29.07.2020
geändert von:         andgag
Änderungen:           ##.74: Bestellzaehler, wenn am gleichen Tag mehrfach bestellt wird, soll über Bestelldatum sortiert werden, statt über Buchungsdatum 
********************************************************************
geändert am:          18.08.2020
geändert von:         joeabd
Änderungen:           ##.75: Integration aycorderid_key, appinfo, bestellmedium (für Online-Bestellungen) 
********************************************************************
geändert am:          07.10.2020
geändert von:         joeabd
Änderungen:           ##.76: aycorderid_key, appinfo, bestellmedium (für Online-Bestellungen) auch rückwirkend in cc_buchung setzen,
                      da Daten von AYC / AWS auch mal später als die eigentliche Buchungsdatensätze eingeladen werden.
********************************************************************
geändert am:          02.03.2021
geändert von:         steern
Änderungen:           ##.77: In den Auftragsnmmern kommen jetzt "H-"-Auftragsnummern an. Cross-Selling für heine? Wird ausgenullt
********************************************************************
geändert am:          29.03.2021
geändert von:         steern
Änderungen:           ##.78: heine Buchungen von CRS-Schiene bzw. Rückläufer von der V_BUCHNGEN werden ausgeschlossen (nur bis heine Migration abgeschlossen ist)
********************************************************************
geändert am:          30.06.2021
geändert von:         joeabd
Änderungen:           ##.79: Diverse "ohne Rabatt"-Spalten ergänzt
********************************************************************
geändert am:          05.08.2021
geändert von:         joeabd
Änderungen:           ##.80: Auftretende Mailnummern 800 mit Anlauf-/Bestelldatum zwischen 23.7. und 4.8. (auftragkopf) werden auf 0 umcodiert
********************************************************************
geändert am:          19.08.2021
geändert von:         luksle
Änderungen:           ##.81: DSGVO - Ausbau der Spalten KONTO_ID und AUFTRAGSNUMMER ab 2.13.3 bis 2.13.6
********************************************************************
geändert am:          07.09.2021
geändert von:         joeabd
Änderungen:           ##.82: ECCPaid eingebaut
********************************************************************
geändert am:          21.09.2021
geändert von:         steern
Änderungen:           ##.83: helline (heine FR) explizit ausgeschlossen
********************************************************************
geändert am:          04.10.2021
geändert von:         steern
Änderungen:           ##.84: Wenn Bestelldatum leer bleibt, wird versucht Bestelldatum aus einer älteren Buchung zu holen (betrifft vor allem migrierte heine Aufträge)
********************************************************************
geändert am:          15.10.2021
geändert von:         joeabd
Änderungen:           ##.85: Beim Setzen der Daten aus der AYC wird zum Joinen zusätzlich die Firma hinzugezogen, da Auftragsnummer alleine nicht eindeutig ist (2.30, 2.31)
********************************************************************
geändert am:          28.12.2021
geändert von:         andgag
Änderungen:           ##.86: OhneRabattWerte wenn leer auf Standardwerte setzen (bei Sammelkonten ist vkp_fakt immer leer)
********************************************************************
geändert am:          13.01.2022
geändert von:         joeabd
Änderungen:           ##.87: Integration Bestellkanalpaid und Bestellkanalusa (-3)
********************************************************************
geändert am:          15.02.2022
geändert von:         joeabd
Änderungen:           ##.88: Rückwirkende Änderung in Buchung (2.31, ##.76) umgeschrieben und WGD integriert
********************************************************************
geändert am:          16.02.2022
geändert von:         joeabd
Änderungen:           ##.89: Merge in cc_buchung (2.31) sowie WGD-Part wird ins Abschluss-Skript verschoben
********************************************************************
geändert am:          18.02.2022
geändert von:         steern
Änderungen:           ##.90: Uebergangsloesung heine MIG - fuer retournierte Altauftraege soll die Auftragsart der Ansprachebuchung gesetzt werden (2.11.)
********************************************************************
geändert am:          30.03.2022
geändert von:         andgag
Änderungen:           ##.91: Default Wert @ aus sc_ww_katsta ausgeschlossen
********************************************************************
geändert am:          06.04.2022
geändert von:         joeabd
Änderungen:           ##.92: Gutscheindaten_id_key wird aus Guliver gepflegt
********************************************************************
geändert am:          29.08.2022
geändert von:         joeabd
Änderungen:           ##.93: Abschluss-Skript: Pflege auch von bestellkanalpaid
********************************************************************
geändert am:          13.10.2022
geändert von:         andgag
Änderungen:           ##.94: artgrv_id verwenden statt artgrvt_id_cc
                             wegen Kompabilität zu cc_artgrvt.
                      Datensätze für Firma 40 korrigiert.
********************************************************************
geändert am:          02.11.2022
geändert von:         andgag
Änderungen:           ##.95: Bestartprom kommt nicht mehr aus Schnittstelle
                             wegen Umbau auf Datapump.
                             Hier aus Auftragspos ermitteln
********************************************************************
geändert am:          08.02.2023
geändert von:         joeabd
Änderungen:           ##.96: Bestellkanalusa, eccusa, Gutscheindaten_id entfernt
********************************************************************
geändert am:          12.05.2023
geändert von:         andgag
Änderungen:           ##.97: Otto-Marktplatz: Bestelldatum aus Auftrpool,
                             Auftrart auf extern setzen
********************************************************************
geändert am:          21.06.2023
geändert von:         carkah
Änderungen:           ##.98: DATASERV-510: Änderung Ermittlung ECC. VT-Saison wird aus dem Bestelldatum gezogen, somit hat der Auftrag auch über den Saisonwechsel immer den gleichen nDWH-Wert
********************************************************************
geändert am:          13.07.2023
geändert von:         andgag
Änderungen:           ##.99: INCIDENT-164686: Otto Marktplat Kennzahlen Ohne Rabatt korrigieren, Verwendung von VKP_FAKT, falls leer dann VKP verwenden.
********************************************************************
geändert am:          26.07.2023
geändert von:         steern
Änderungen:           ##.100: Retouren, die von Stationaer-Buchungen kommen, aber auf Witt Inland gebucht werden, sollen wieder auf Stationaer gebucht werden.
********************************************************************
geändert am:          29.08.2023
geändert von:         joeabd
Änderungen:           ##.101: Otto Marktplatz: ECC und ECCPAID fix -3, Bestellkanal(paid) fix 16, Katalogart fix 992
********************************************************************
geändert am:          14.09.2023
geändert von:         joeabd
Änderungen:           ##.102: Otto Marktplatz: Wenn Auftrdat leer ist, wird dieses auf LV-Dat (Buchungsdatum) - 1 Tag gesetzt 
********************************************************************
geändert am:          07.10.2023
geändert von:         steern
Änderungen:           ##.103: Auftragsnummer kam mit Punkten an bei Otto Marketplace Buchungen. Im Skript mit Replace entfernt.
********************************************************************
geändert am:          09.10.2023
geändert von:         benlin
Änderungen:           ##.104 Heine-Auftragsnr-Mapping-Tabellen wurden aus dem Skript entfernt, da sie nur eine Uebergangsloesung waehrend der Heine-Mig waren.
                             Aufgrund der DSGVO-kritischen Spalten in diesen Tabellen, wurden sie ins KDWH geschoben.
                             Zusaetzlich wurde der APPL-Error ausgebaut, falls Buchungen mit Firma-68 kommen sollten. 
********************************************************************
geändert am:          26.10.2023
geändert von:         benlin
Änderungen:           ##.105: DSGVO-kritische Spalten: KONTONR, KONTO_ID, AUFTRPOSIDENTNR, AUFTRNRIT, FAKTURAID
                             aus den Clenase-Tabellen und dem Skript entfernt
********************************************************************
geändert am:          27.10.2023
geändert von:         steern
Änderungen:           ##.106: Uebergansloesung eingebaut fuer zwei Auftragsdatums bei gleichen Auftraegen. Ursache Fakturierfehler vom 06.10.2023
********************************************************************
geändert am:          10.11.2023
geändert von:         andgag
Änderungen:           ##.107: Ausstattung_dir_id auch bei Lagerdifferenzen Pos 400 uebernehmen
********************************************************************
geändert am:          29.02.2023
geändert von:         andgag
Änderungen:           ##.108: Neue Artikel-Ids eingebaut beim Insert in letzte Cleanse-Tabelle
                              Check auf Datenverluste bei Referenzaufloesung
********************************************************************
geändert am:          18.02.2024
geändert von:         joeabd
Änderungen:           ##.109: VF-Kennzeichen (kostenfrei/kostenpfl.) für Nicht-Sammelfirmen auf
                              Basis von VKP_FAKT setzen
********************************************************************
geändert am:          20.06.2024
geändert von:         joeabd
Änderungen:           ##.110: PayBack-Kennzeichen (ja/nein) eingebaut    
********************************************************************
geändert am:          30.08.2024
geändert von:         joeabd
Änderungen:           ##.111: Uebergangsloesung wegen Fakturierfehler am 06.10.2023 ausgebaut
********************************************************************
geändert am:          05.09.2024
geändert von:         andgag
Änderungen:           ##.112: artgrvt_id auf unused umbenannt. artgrvt_id_cc ausgebaut
********************************************************************
geändert am:          18.09.2024
geändert von:         andgag
Änderungen:           ##.113: artgrvt_id komplett ausgebaut   
********************************************************************
geändert am:          12.03.2025
geändert von:         annfis
Änderungen:           ##.114:  
                      zeile 869 WHERE buchungsdatum = TRUNC(&termin) ersetzt durch WHERE dwh_processdate = TRUNC(&termin)
                      zeile 1213 WHERE buchungsdatum = TRUNC(&termin) ersetzt durch WHERE dwh_processdate = TRUNC(&termin)
                      wegen Ladung der CRS Daten -> buchungsdatum liegt einen LV-Tag zurück 
                      und wurde vorher falsch durch Termindatum ersetzt
********************************************************************
geändert am:          23.07.2025
geändert von:         andgag
Änderungen:           ##.115:  
                      Otto-Marktplatz: Limango wird als eigene Firma ausgewiesen
********************************************************************
geändert am:          19.08.2025
geändert von:         andgag
Änderungen:           ##.116:  
                      Otto-Marktplatz+Limango: Retwertberechnung korrigiert
                      (bei allen Sammelkonto-Firmen)
                      RETDIFFWERT wird nicht mehr addiert 
********************************************************************
geändert am:          25.02.2026
geändert von:         steern
Änderungen:           ##.117:  
                      Anpassung Happy Size und Galeria: Auftragsdatum wird gesetzt, andere Felder wie ECC ebenfalls.                 
*******************************************************************************/

ALTER SESSION ENABLE PARALLEL DML;

PROMPT ===========================================
PROMPT
PROMPT Parameterliste
PROMPT
PROMPT ===========================================

PROMPT GBV-Jobid : &gbvid
PROMPT Ptermin   :   &termin
PROMPT Vtaison   :   &vtsaison
PROMPT Vtsaison-1: &vtsaisonm1
PROMPT Vtsaison-2: &vtsaisonm2
PROMPT Vtsaison+1: &vtsaisonp1



PROMPT =====================================================================
PROMPT 1. Einspielen der Tagesdaten aus SC-Tabelle
PROMPT =====================================================================

PROMPT =====================================================================
PROMPT 1.1 Einspielen aus SC-Tabelle "normale" Konten (Ausschluss: Sammelkonten und Russland)
PROMPT =====================================================================

TRUNCATE TABLE clcc_ww_buchung_19;

INSERT /*+ APPEND */ INTO clcc_ww_buchung_19 
  (
      dwh_cr_load_id,
      anspr,
      anspr_tele,
      artikelnr,
      auftragsnr,
      auftrnrit_key,
      brabs,
      brabsers,
      brumsdiff_betrag,
      buchungsdatum,
      ersatzgroesse,
      ersatzartikelnr,
      ersverw,
      firma,
      firma_cc,
      groesse,
      katalogart,
      konto_id_key,
      kontoart,
      lieferwunschkz,
      meterwarekz,
      meterwarekz_cc,
      nabstorno,
      nali,
      nili,
      nina,
      nums,
      promotionnr,
      retdiff_betrag,
      ret,
      importanteil,
      telenili,
      umsatzsaison,
      umsstorno,
      ek_vtgebiet,
      zahlungsart,
      zahlungsart_cc,
      auftrnr_key,
      auftrpos,
      lieferkz,
      konto_id_orig_key,
      mappennr,
      anzraten,
      verkpreis,
      bestarprom,
      likz,
      likz_cc,
      mwst,
      anspr_wert,
      ansprohnerabattwert,
      anspr_tele_wert,
      nali_wert,
      naliohnerabattwert,
      nili_wert,
      niliohnerabattwert,
      telenili_wert,
      teleniliohnerabattwert,
      nums_wert,
      numsohnerabattwert,
      brabs_wert,
      brabsohnerabattwert,
      ret_wert,
      retohnerabattwert,
      nina_wert,
      ninaohnerabattwert,
      nabstorno_wert,
      nabstornoohnerabattwert,
      umsstorno_wert,
      umsstornoohnerabattwert,
      erslief,
      nums_wert_vek,
      saison,
      retbewegid_key,
      prozessid,
      fakturaid_key,
      auftrag_auftragpoolid_key,
      auftragposid_key,
      lagerdiffwert,
      lagerdiffohnerabattwert,
      impantwert,
      impantohnerabattwert,
      stationaerkz,
      stationaerkz_cc,
      lagerdiffmenge,
      vkp_fakt,
      paybackauftrag,
      imhostmig
   ) 
    SELECT       
      &gbvid,
      ansprachen/100,
      ansprachen_tele/100,
      artikelnr,
      CASE WHEN LOWER(auftragsnr) IN ('uk_sonderlauf') THEN NULL
           WHEN LOWER(auftragsnr) LIKE 'korrektur%' THEN NULL
           WHEN LOWER(auftragsnr) LIKE 'crs%' THEN NULL
           WHEN LOWER(auftragsnr) = 'urladung' THEN NULL
           WHEN LOWER(auftragsnr) LIKE 'h-%' THEN NULL
           ELSE REPLACE(auftragsnr, '.', '') END,
      auftrnrit_key,
      brabs/100,
      brabsers/100,
      brumsdiff_betrag/100,
      buchungsdatum,
      ersatzartikelgroesse,
      ersatzartikelnr,
      ersverw/100,
      firma,
      cc_firma.wert,
      groesse,
      CASE WHEN firma = 28 THEN 992 ELSE katalogart END AS katalogart, -- Otto Marktplatz immer Katart 992
      konto_id_key,
      CASE WHEN cc_firma.wert IN (22,23,24,25,26,27,28,29,30,31,33,34) THEN 3  
           ELSE kontoart END AS kontoart,                                              -- =/= von 2 auf 1 geaendert, da intv.interessentkey immer NULL
      lieferwunschkz,
      DECODE(mgeinh,100,1,NULL),
      cc_meterware.wert,
      nabstorno/100,
      nali/100,
      nili/100,
      nina/100,
      nums/100,
      CASE WHEN promotionnr = '?' THEN 0 ELSE TO_NUMBER(promotionnr) END,
      retdiff_Betrag/100,
      retoure/100,
      importanteil/100,
      telenili/100,
      umsatzsaison,
      umsstorno/100,
      vtgebiet,
      zahlungskz,
      cc_zahlwunsch.wert,
      auftrnr_key,
      auftrpos,
      CASE   WHEN nina = 0 AND nili = 0 AND ansprachen = 0 AND nums > 0 AND retoure < 0 THEN 13
             WHEN ersatzartikelnr IS NULL AND nina = 0 AND nili = 0 AND ansprachen = 0 AND nums > 0 THEN 5
             WHEN telenili > 0 THEN 22
             WHEN nili > 0 AND likz = 3 AND naboffen_zugang >= 0 AND ansprachen > 0 THEN 2 --AND mailingnr IS NOT NULL THEN 2 (andgag 03.03.2017 nicht relevant)
             WHEN nali > 0 THEN 1
             WHEN ansprachen > 0 AND brabs = 0 THEN 9
             WHEN ansprachen > 0 AND nums > 0 THEN 0
             WHEN retoure > 0 THEN 10
             WHEN nili > 0 AND ansprachen = 0 THEN 21 -- WHEN nili > 0 AND (naboffen_zugang < 0 OR (likz = 3 AND lieferwunschkz > 0))
             WHEN nina > 0 THEN 3
             WHEN nili = 0 AND ersatzartikelnr > 0 AND nums > 0 THEN 4
             WHEN retoure < 0 THEN 13
             WHEN nina = 0 AND nali = 0 AND nab = 0 AND naboffen_Zugang < 0 AND nums = 0 AND ersverw = 0 AND nili = 0 AND nabstorno = 0 THEN 99
             WHEN brabs < 0 AND nums < 0 AND ansprachen < 0 THEN 12
             WHEN nabstorno > 0 THEN 31    
             WHEN brabs < 0 AND nums < 0 THEN 14
             WHEN ersverw != 0 THEN 24
             WHEN ansprachen != 0 OR brabs != 0 OR nina != 0 OR nali != 0 OR umsstorno != 0 OR nabstorno != 0 OR retoure != 0 or nili != 0 THEN 98
      END,
      konto_id_orig_key, 
      mappen_nr,
      anzraten,
      ABS(CASE WHEN ersverw > 0 THEN PKG_IM_VERTRIEBSGEBIET.F_GET_LANDESWAEHRUNG(vkp/100,PKG_IM_VERTRIEBSGEBIET.F_EKVT_TO_FIRMA(PKG_IM_VERTRIEBSGEBIET.F_EKVT_TO_PREISVT(vtgebiet)), &termin)*
               CASE WHEN nums <> 0 THEN nums/100
                    WHEN nab  <> 0 THEN nab/100
                    WHEN nali <> 0 THEN nali/100
                    WHEN nili <> 0 THEN nili/100
                    WHEN naboffen_zugang <> 0 THEN naboffen_zugang/100
                    WHEN nabstorno <> 0 THEN nabstorno/100
                    WHEN ersverw <> 0 THEN ersverw/100
                    WHEN ansprachen <> 0 THEN ansprachen/100
                    WHEN nina <> 0 THEN nina/100
                ELSE 0 END
           ELSE vkp_fakt/100 END),
      bestarprom,
      likz,
      cc_artstat.wert,
      mwst/100,
      COALESCE(ROUND((ansprachen/100)*PKG_IM_VERTRIEBSGEBIET.F_GET_LANDESWAEHRUNG(komwarenwert/100, PKG_IM_VERTRIEBSGEBIET.F_EKVT_TO_PREISFIRMA(vtgebiet), &termin) ,6),0) AS anspr_wert,
      COALESCE(ROUND((ansprachen/100)*vkp_fakt/100 ,6),0) AS ansprohnerabattwert,
      COALESCE(ROUND((ansprachen_tele/100)*PKG_IM_VERTRIEBSGEBIET.F_GET_LANDESWAEHRUNG(komwarenwert/100, PKG_IM_VERTRIEBSGEBIET.F_EKVT_TO_PREISFIRMA(vtgebiet), &termin) ,6),0) AS anspr_tele_wert,
      COALESCE(ROUND((nali/100)*PKG_IM_VERTRIEBSGEBIET.F_GET_LANDESWAEHRUNG(komwarenwert/100, PKG_IM_VERTRIEBSGEBIET.F_EKVT_TO_PREISFIRMA(vtgebiet), &termin) ,6),0) AS nali_wert,
      COALESCE(ROUND((nali/100)*vkp_fakt/100 ,6),0) AS naliohnerabattwert,
      COALESCE(ROUND((nili/100)*PKG_IM_VERTRIEBSGEBIET.F_GET_LANDESWAEHRUNG(komwarenwert/100, PKG_IM_VERTRIEBSGEBIET.F_EKVT_TO_PREISFIRMA(vtgebiet), &termin) ,6),0) AS nili_wert,
      COALESCE(ROUND((nili/100)*vkp_fakt/100 ,6),0) AS niliohnerabattwert,      
      COALESCE(ROUND((telenili/100)*PKG_IM_VERTRIEBSGEBIET.F_GET_LANDESWAEHRUNG(komwarenwert/100, PKG_IM_VERTRIEBSGEBIET.F_EKVT_TO_PREISFIRMA(vtgebiet), &termin) ,6),0) AS telenili_wert,
      COALESCE(ROUND((telenili/100)*vkp_fakt/100 ,6),0) AS teleniliohnerabattwert,      
      (COALESCE(ROUND((brabs/100)*PKG_IM_VERTRIEBSGEBIET.F_GET_LANDESWAEHRUNG(komwarenwert/100, PKG_IM_VERTRIEBSGEBIET.F_EKVT_TO_PREISFIRMA(vtgebiet), &termin), 6),0)-      
         COALESCE(ROUND((retoure/100)*PKG_IM_VERTRIEBSGEBIET.F_GET_LANDESWAEHRUNG(komwarenwert/100, PKG_IM_VERTRIEBSGEBIET.F_EKVT_TO_PREISFIRMA(vtgebiet), &termin), 6),0)) AS nums_wert,   
      COALESCE(ROUND((brabs/100)*vkp_fakt/100, 6),0) - COALESCE(ROUND((retoure/100)*vkp_fakt/100, 6),0) AS numsohnerabattwert,
      COALESCE(ROUND((brabs/100)*PKG_IM_VERTRIEBSGEBIET.F_GET_LANDESWAEHRUNG(komwarenwert/100, PKG_IM_VERTRIEBSGEBIET.F_EKVT_TO_PREISFIRMA(vtgebiet), &termin),6),0) AS brabs_wert,     
      COALESCE(ROUND((brabs/100)*vkp_fakt/100, 6),0) AS brabsohnerabattwert,      
      COALESCE(ROUND((retoure/100)*PKG_IM_VERTRIEBSGEBIET.F_GET_LANDESWAEHRUNG(komwarenwert/100, PKG_IM_VERTRIEBSGEBIET.F_EKVT_TO_PREISFIRMA(vtgebiet), &termin),6),0) AS ret_wert,      
      COALESCE(ROUND((retoure/100)*vkp_fakt/100, 6), 0) AS retohnerabattwert,      
      COALESCE(ROUND((nina/100)*PKG_IM_VERTRIEBSGEBIET.F_GET_LANDESWAEHRUNG(komwarenwert/100, PKG_IM_VERTRIEBSGEBIET.F_EKVT_TO_PREISFIRMA(vtgebiet), &termin) ,6),0) AS ninawert,
      COALESCE(ROUND((nina/100)*vkp_fakt/100, 6), 0) AS ninaohnerabattwert,
      COALESCE(ROUND((nabstorno/100)*PKG_IM_VERTRIEBSGEBIET.F_GET_LANDESWAEHRUNG(komwarenwert/100, PKG_IM_VERTRIEBSGEBIET.F_EKVT_TO_PREISFIRMA(vtgebiet), &termin) ,6),0) AS nabstornowert,
      COALESCE(ROUND((nabstorno/100)*vkp_fakt/100, 6), 0) AS nabstornoohnerabattwert,      
      COALESCE(ROUND((umsstorno/100)*PKG_IM_VERTRIEBSGEBIET.F_GET_LANDESWAEHRUNG(komwarenwert/100, PKG_IM_VERTRIEBSGEBIET.F_EKVT_TO_PREISFIRMA(vtgebiet), &termin) ,6),0) AS umsstornowert, 
      COALESCE(ROUND((umsstorno/100)*vkp_fakt/100, 6), 0) AS umsstornoohnerabattwert,
      CASE WHEN brabsers != 0 AND auftrnr_key IS NOT NULL /*auftrposidentnr > 0*/ THEN 2 ELSE 1 END AS erslief,
      COALESCE(ROUND((nums/100)*PKG_IM_VERTRIEBSGEBIET.F_GET_LANDESWAEHRUNG(vek/100, PKG_IM_VERTRIEBSGEBIET.F_EKVT_TO_PREISFIRMA(vtgebiet), &termin) ,6),0) AS numswertvek,
      saison,
      retbewegid_key,
      prozessid,
      fakturaid_key,
      auftrag_auftragpoolid_key,
      auftragposid_key,
      CASE WHEN umsstorno > 0 AND etbereich != 99 THEN ABS(COALESCE(ROUND((umsstorno/100)*PKG_IM_VERTRIEBSGEBIET.F_GET_LANDESWAEHRUNG(vkp/100, PKG_IM_VERTRIEBSGEBIET.F_EKVT_TO_PREISFIRMA(vtgebiet), &termin) ,6),0)) ELSE 0 END AS Lagerdiffwert,
      CASE WHEN umsstorno > 0 AND etbereich != 99 THEN ABS(COALESCE(ROUND((umsstorno/100)*vkp_fakt/100, 6),0)) ELSE 0 END AS Lagerdiffohnerabattwert,
      COALESCE(ROUND((importanteil/100)*PKG_IM_VERTRIEBSGEBIET.F_GET_LANDESWAEHRUNG(komwarenwert/100, PKG_IM_VERTRIEBSGEBIET.F_EKVT_TO_PREISFIRMA(vtgebiet), &termin) ,6),0) AS impantwert,
      COALESCE(ROUND((importanteil/100)*vkp_fakt/100 ,6),0) AS impantohnerabattwert,      
      stationaerkz,
      cc_stationaerkz.wert,
      CASE WHEN etbereich != 99 THEN umsstorno/100 ELSE 0 END,
      vkp_fakt,
      CASE WHEN firma = 1 THEN 1 ELSE -3 END AS paybackauftrag,
      1
    FROM sc_ww_buchung                                                      
    JOIN sc_ww_kundenfirma
         ON (sc_ww_buchung.dwh_id_sc_ww_kundenfirma = sc_ww_kundenfirma.dwh_id)
    JOIN sc_ww_kundenfirma_ver
         ON (sc_ww_kundenfirma.dwh_id = sc_ww_kundenfirma_ver.dwh_id_head AND &termin BETWEEN sc_ww_kundenfirma_ver.dwh_valid_From AND sc_ww_kundenfirma_ver.dwh_valid_to)
    JOIN cc_firma
         ON (sc_ww_kundenfirma_ver.dwh_id_cc_firma = cc_firma.dwh_id)
    JOIN sc_ww_likz
         ON (sc_ww_buchung.dwh_id_sc_ww_likz = sc_ww_likz.dwh_id)
    JOIN sc_ww_likz_ver
         ON (sc_ww_likz.dwh_id = sc_ww_likz_ver.dwh_id_head AND &termin BETWEEN sc_ww_likz_ver.dwh_valid_FROM AND sc_ww_likz_ver.dwh_valid_to)
    JOIN cc_artstat
         ON (sc_ww_likz_ver.dwh_id_cc_artstat = cc_artstat.dwh_id)
    JOIN sc_ww_zahlungskz
         ON (sc_ww_buchung.dwh_id_sc_ww_zahlungskz = sc_ww_zahlungskz.dwh_id)
    JOIN sc_ww_zahlungskz_ver
         ON (sc_ww_zahlungskz.dwh_id = sc_ww_zahlungskz_ver.dwh_id_head AND &termin BETWEEN sc_ww_zahlungskz_ver.dwh_valid_FROM AND sc_ww_zahlungskz_ver.dwh_valid_to)
    JOIN cc_zahlwunsch
         ON (sc_ww_zahlungskz_ver.dwh_id_cc_zahlwunsch = cc_zahlwunsch.dwh_id)
    JOIN sc_ww_mgeinh
         ON (sc_ww_buchung.dwh_id_sc_ww_mgeinh = sc_ww_mgeinh.dwh_id)
    JOIN sc_ww_mgeinh_ver
         ON (sc_ww_mgeinh.dwh_id = sc_ww_mgeinh_ver.dwh_id_head AND &termin BETWEEN sc_ww_mgeinh_ver.dwh_valid_from AND sc_ww_mgeinh_ver.dwh_valid_to)
    JOIN cc_meterware
         ON (sc_ww_mgeinh_ver.dwh_id_cc_meterware = cc_meterware.dwh_id)
    JOIN sc_ww_stationaerkz
         ON (sc_ww_buchung.dwh_id_sc_ww_stationaerkz = sc_ww_stationaerkz.dwh_id)
    JOIN sc_ww_stationaerkz_ver
         ON (sc_ww_stationaerkz.dwh_id = sc_ww_stationaerkz_ver.dwh_id_head AND &termin BETWEEN sc_ww_stationaerkz_ver.dwh_valid_From AND sc_ww_stationaerkz_ver.dwh_valid_to)
    JOIN cc_stationaerkz
         ON (sc_ww_stationaerkz_ver.dwh_id_cc_stationaerkz = cc_stationaerkz.dwh_id)
    WHERE TRUNC(dwh_processdate) = TRUNC(&termin)
    AND (SELECT PKG_IM_VERTRIEBSGEBIET.F_EKVT_MIT_SAMMELKONTO(vtgebiet) FROM dual) = 0
    AND vtgebiet NOT IN ('c', 'r')
    AND sc_ww_buchung.firma NOT IN ( 24,27 )  -- Sammelkonto helline und Schweden raus  
    AND NOT (    
              vtgebiet IN ('>',']','<','(',')') AND umsatzsaison >= 144
             AND  (prozessid = 'EqYYv70' OR (prozessid IS NULL AND auftragsnr LIKE 'CRS%'))
            )    -- CSE heine aussortieren, da dies alles ueber Hamburg schon kommt (relevant nur bis Ende Heine Mig) 
    AND CASE  WHEN nina = 0 AND nili = 0 AND ansprachen = 0 AND nums > 0 AND retoure < 0 THEN 13
              WHEN ersatzartikelnr IS NULL AND nina = 0 AND nili = 0 AND ansprachen = 0 AND nums > 0 THEN 5
              WHEN telenili > 0 THEN 22
              WHEN nili > 0 AND likz = 3 AND naboffen_zugang >= 0 AND ansprachen > 0 THEN 2 --AND mailingnr IS NOT NULL THEN 2 (andgag 03.03.2017 nicht relevant)
              WHEN nali > 0 THEN 1
              WHEN ansprachen > 0 AND brabs = 0 THEN 9
              WHEN ansprachen > 0 AND nums > 0 THEN 0
              WHEN retoure > 0 THEN 10
              WHEN nili > 0 AND ansprachen = 0 THEN 21 -- WHEN nili > 0 AND (naboffen_zugang < 0 OR (likz = 3 AND lieferwunschkz > 0))
              WHEN nina > 0 THEN 3
              WHEN nili = 0 AND ersatzartikelnr > 0 AND nums > 0 THEN 4
              WHEN retoure < 0 THEN 13
              WHEN nina = 0 AND nali = 0 AND nab = 0 AND naboffen_Zugang < 0 AND nums = 0 AND ersverw = 0 AND nili = 0 AND nabstorno = 0 THEN 99
              WHEN brabs < 0 AND nums < 0 AND ansprachen < 0 THEN 12
              WHEN nabstorno > 0 THEN 31    
              WHEN brabs < 0 AND nums < 0 THEN 14
              WHEN ersverw != 0 THEN 24
              WHEN ansprachen != 0 OR brabs != 0 OR nina != 0 OR nali != 0 OR umsstorno != 0 or nabstorno != 0 or retoure != 0 or nili != 0 THEN 98    
         END IS NOT NULL;
                
COMMIT;      



PROMPT =====================================================================
PROMPT 1.2 Einspielen aus SC-Tabelle Sammelkonten
PROMPT =====================================================================

INSERT /*+ APPEND */ INTO clcc_ww_buchung_19 (
                              dwh_cr_load_id,
                              anspr,
                              anspr_tele,
                              artikelnr,
                              auftragsnr,
                              auftrnrit_key,
                              brabs,
                              brabsers,
                              brumsdiff_betrag,
                              buchungsdatum,
                              ersatzgroesse,
                              ersatzartikelnr,
                              ersverw,
                              firma,
                              firma_cc,
                              groesse,
                              katalogart,
                              konto_id_key,
                              kontoart,
                              lieferwunschkz,
                              meterwarekz,
                              meterwarekz_cc,
                              nabstorno,
                              nali,
                              nili,
                              nina,
                              nums,
                              promotionnr,
                              retdiff_betrag,
                              ret,
                              importanteil,
                              telenili,
                              umsatzsaison,
                              umsstorno,
                              ek_vtgebiet,
                              zahlungsart,
                              zahlungsart_cc,
                              auftrnr_key,
                              auftrpos,
                              LieferKZ,
                              konto_id_orig_key,
                              mappennr,
                              anzraten,
                              verkpreis,
                              bestarprom,
                              likz,
                              likz_cc,
                              mwst,
                              anspr_wert,
                              ansprohnerabattwert,
                              anspr_tele_wert,
                              nali_wert,
                              naliohnerabattwert,
                              nili_wert,
                              niliohnerabattwert,
                              telenili_wert,
                              teleniliohnerabattwert,
                              nums_wert,
                              numsohnerabattwert,
                              brabs_wert,
                              brabsohnerabattwert,
                              ret_wert,
                              retohnerabattwert,
                              nina_wert,
                              ninaohnerabattwert,
                              nabstorno_wert,
                              nabstornoohnerabattwert,
                              umsstorno_wert,
                              umsstornoohnerabattwert,
                              erslief,
                              nums_wert_vek,  
                              saison,
                              retbewegid_key,
                              prozessid,
                              fakturaid_key,
                              auftrag_auftragpoolid_key,
                              auftragposid_key,
                              lagerdiffwert,
                              lagerdiffohnerabattwert,
                              impantwert,
                              impantohnerabattwert,
                              stationaerkz,
                              stationaerkz_cc,
                              lagerdiffmenge,
                              vkp_fakt,
                              paybackauftrag,
                              imhostmig
                              ) 
SELECT                  &gbvid,
                        ansprachen/100,
                        ansprachen_tele/100,
                        artikelnr,
                        CASE WHEN LOWER(auftragsnr) IN ('uk_sonderlauf') THEN NULL
                             WHEN LOWER(auftragsnr) LIKE 'korrektur%' THEN NULL
                             WHEN LOWER(auftragsnr) LIKE 'crs%' THEN NULL
                             WHEN LOWER(auftragsnr) = 'urladung' THEN NULL
                        ELSE REPLACE(auftragsnr, '.', '') END,
                        auftrnrit_key,
                        brabs/100,
                        brabsers/100,
                        brumsdiff_betrag/100,
                        buchungsdatum,
                        ersatzartikelgroesse,
                        ersatzartikelnr,
                        ersverw/100,
                        firma,
                        cc_firma.wert,
                        groesse,
                        CASE WHEN firma = 28 THEN 992 ELSE katalogart END AS katalogart, -- Otto Marktplatz immer Katart 992
                        konto_id_key,
                        CASE  WHEN cc_firma.wert IN (29,30,33) THEN 3        
                        ELSE kontoart END AS kontoart,                                 
                        lieferwunschkz,
                       -- mailingnr,
                        DECODE(mgeinh,100,1,NULL),
                        cc_meterware.wert,
                        nabstorno/100,
                        nali/100,
                        nili/100,
                        nina/100,
                        nums/100,
                        CASE WHEN promotionnr = '?' THEN 0 ELSE TO_NUMBER(promotionnr) END,
                        retdiff_Betrag/100,
                        retoure/100,
                        importanteil/100,
                        telenili/100,
                        umsatzsaison,
                        umsstorno/100,
                        vtgebiet,
                        zahlungskz,
                        cc_zahlwunsch.wert,
                        auftrnr_key,
                        auftrpos,
                        NULL AS lieferkz,
                        konto_id_orig_key, 
                        mappen_nr,
                        anzraten,
                        NULL AS verkpreis,
                        bestarprom,
                        likz,
                        cc_artstat.wert,
                        mwst/100,                         
                        COALESCE(ROUND((ansprachen/100)*PKG_IM_VERTRIEBSGEBIET.F_GET_LANDESWAEHRUNG(komwarenwert/100, PKG_IM_VERTRIEBSGEBIET.F_EKVT_TO_PREISFIRMA(vtgebiet), &termin) ,6),0) AS anspr_wert,                        
                        COALESCE(ROUND((ansprachen/100)*
                             CASE WHEN vkp_fakt != 0 THEN vkp_fakt/100 
                                 ELSE PKG_IM_VERTRIEBSGEBIET.F_GET_LANDESWAEHRUNG(vkp/100, PKG_IM_VERTRIEBSGEBIET.F_EKVT_TO_PREISFIRMA(vtgebiet), &termin) END,6),0) AS ansprohnerabattwert,                             
                         COALESCE(ROUND((ansprachen_tele/100)*PKG_IM_VERTRIEBSGEBIET.F_GET_LANDESWAEHRUNG(komwarenwert/100, PKG_IM_VERTRIEBSGEBIET.F_EKVT_TO_PREISFIRMA(vtgebiet), &termin) ,6),0) AS ansprtelewert,
                        COALESCE(ROUND((nali/100)*PKG_IM_VERTRIEBSGEBIET.F_GET_LANDESWAEHRUNG(komwarenwert/100, PKG_IM_VERTRIEBSGEBIET.F_EKVT_TO_PREISFIRMA(vtgebiet), &termin) ,6),0) AS naliwert,
                        COALESCE(ROUND((nali/100)*
                             CASE WHEN vkp_fakt != 0 THEN vkp_fakt/100 
                                 ELSE PKG_IM_VERTRIEBSGEBIET.F_GET_LANDESWAEHRUNG(vkp/100, PKG_IM_VERTRIEBSGEBIET.F_EKVT_TO_PREISFIRMA(vtgebiet), &termin) END,6),0) AS naliohnerabattwert,                                                     
                        COALESCE(ROUND((nili/100)*PKG_IM_VERTRIEBSGEBIET.F_GET_LANDESWAEHRUNG(komwarenwert/100, PKG_IM_VERTRIEBSGEBIET.F_EKVT_TO_PREISFIRMA(vtgebiet), &termin) ,6),0) AS niliwert, 
                        COALESCE(ROUND((nili/100)*
                             CASE WHEN vkp_fakt != 0 THEN vkp_fakt/100 
                                 ELSE PKG_IM_VERTRIEBSGEBIET.F_GET_LANDESWAEHRUNG(vkp/100, PKG_IM_VERTRIEBSGEBIET.F_EKVT_TO_PREISFIRMA(vtgebiet), &termin) END,6),0) AS niliohnerabattwert,                                                                             
                        COALESCE(ROUND((telenili/100)*PKG_IM_VERTRIEBSGEBIET.F_GET_LANDESWAEHRUNG(komwarenwert/100, PKG_IM_VERTRIEBSGEBIET.F_EKVT_TO_PREISFIRMA(vtgebiet), &termin) ,6),0) AS teleniliwert,
                        COALESCE(ROUND((telenili/100)*
                             CASE WHEN vkp_fakt != 0 THEN vkp_fakt/100 
                                 ELSE PKG_IM_VERTRIEBSGEBIET.F_GET_LANDESWAEHRUNG(vkp/100, PKG_IM_VERTRIEBSGEBIET.F_EKVT_TO_PREISFIRMA(vtgebiet), &termin) END,6),0) AS teleniliohnerabattwert,                                                                                                     
                        (COALESCE(ROUND((brabs/100)*PKG_IM_VERTRIEBSGEBIET.F_GET_LANDESWAEHRUNG(komwarenwert/100, PKG_IM_VERTRIEBSGEBIET.F_EKVT_TO_PREISFIRMA(vtgebiet), &termin), 6),0) -
                           COALESCE(ROUND((retoure/100)*PKG_IM_VERTRIEBSGEBIET.F_GET_LANDESWAEHRUNG(komwarenwert/100, PKG_IM_VERTRIEBSGEBIET.F_EKVT_TO_PREISFIRMA(vtgebiet), &termin), 6),0)) AS numswert,
                            COALESCE(ROUND((brabs/100)*
                               CASE WHEN vkp_fakt != 0 THEN vkp_fakt/100 
                                 ELSE PKG_IM_VERTRIEBSGEBIET.F_GET_LANDESWAEHRUNG(vkp/100, PKG_IM_VERTRIEBSGEBIET.F_EKVT_TO_PREISFIRMA(vtgebiet), &termin) END,6),0) -
                                 COALESCE(ROUND((retoure/100)*
                               CASE WHEN vkp_fakt != 0 THEN vkp_fakt/100 
                                 ELSE PKG_IM_VERTRIEBSGEBIET.F_GET_LANDESWAEHRUNG(vkp/100, PKG_IM_VERTRIEBSGEBIET.F_EKVT_TO_PREISFIRMA(vtgebiet), &termin) END,6),0)                                 
                                            as numsohnerabattwert,                             
                        COALESCE(ROUND((brabs/100)*PKG_IM_VERTRIEBSGEBIET.F_GET_LANDESWAEHRUNG(komwarenwert/100, PKG_IM_VERTRIEBSGEBIET.F_EKVT_TO_PREISFIRMA(vtgebiet), &termin), 6),0) AS brabswert, 
                        COALESCE(ROUND((brabs/100)*
                             CASE WHEN vkp_fakt != 0 THEN vkp_fakt/100 
                                 ELSE PKG_IM_VERTRIEBSGEBIET.F_GET_LANDESWAEHRUNG(vkp/100, PKG_IM_VERTRIEBSGEBIET.F_EKVT_TO_PREISFIRMA(vtgebiet), &termin) END,6),0) AS brabsohnerabattwert,                                                                                                                                                    
                        COALESCE(ROUND((retoure/100)*PKG_IM_VERTRIEBSGEBIET.F_GET_LANDESWAEHRUNG(komwarenwert/100, PKG_IM_VERTRIEBSGEBIET.F_EKVT_TO_PREISFIRMA(vtgebiet), &termin), 6),0) AS retwert,
                        COALESCE(ROUND((retoure/100)*
                             CASE WHEN vkp_fakt != 0 THEN vkp_fakt/100
                                 ELSE PKG_IM_VERTRIEBSGEBIET.F_GET_LANDESWAEHRUNG(vkp/100, PKG_IM_VERTRIEBSGEBIET.F_EKVT_TO_PREISFIRMA(vtgebiet), &termin) END,6),0) AS retohnerabattwert,                                                                                                                                                     
                        COALESCE(ROUND((nina/100)*PKG_IM_VERTRIEBSGEBIET.F_GET_LANDESWAEHRUNG(komwarenwert/100, PKG_IM_VERTRIEBSGEBIET.F_EKVT_TO_PREISFIRMA(vtgebiet), &termin) ,6),0) AS ninawert,
                        COALESCE(ROUND((nina/100)*
                             CASE WHEN vkp_fakt != 0 THEN vkp_fakt/100 
                                 ELSE PKG_IM_VERTRIEBSGEBIET.F_GET_LANDESWAEHRUNG(vkp/100, PKG_IM_VERTRIEBSGEBIET.F_EKVT_TO_PREISFIRMA(vtgebiet), &termin) END,6),0) AS ninaohnerabattwert,                                                                                                                                                                             
                        COALESCE(ROUND((nabstorno/100)*PKG_IM_VERTRIEBSGEBIET.F_GET_LANDESWAEHRUNG(komwarenwert/100, PKG_IM_VERTRIEBSGEBIET.F_EKVT_TO_PREISFIRMA(vtgebiet), &termin) ,6),0) AS nabstornowert, 
                        COALESCE(ROUND((nabstorno/100)*
                             CASE WHEN vkp_fakt != 0 THEN vkp_fakt/100 
                                 ELSE PKG_IM_VERTRIEBSGEBIET.F_GET_LANDESWAEHRUNG(vkp/100, PKG_IM_VERTRIEBSGEBIET.F_EKVT_TO_PREISFIRMA(vtgebiet), &termin) END,6),0) AS nabstornoohnerabattwert,                                                                                                                                                                                                     
                        COALESCE(ROUND((umsstorno/100)*PKG_IM_VERTRIEBSGEBIET.F_GET_LANDESWAEHRUNG(komwarenwert/100, PKG_IM_VERTRIEBSGEBIET.F_EKVT_TO_PREISFIRMA(vtgebiet), &termin) ,6),0) AS umsstornowert,     
                        COALESCE(ROUND((umsstorno/100)*
                             CASE WHEN vkp_fakt != 0 THEN vkp_fakt/100 
                                 ELSE PKG_IM_VERTRIEBSGEBIET.F_GET_LANDESWAEHRUNG(vkp/100, PKG_IM_VERTRIEBSGEBIET.F_EKVT_TO_PREISFIRMA(vtgebiet), &termin) END,6),0) AS umsstornoohnerabattwert,                                                                                                                                                                                                                             
                        1 AS erslief,
                        COALESCE(ROUND((nums/100)*PKG_IM_VERTRIEBSGEBIET.F_GET_LANDESWAEHRUNG(vek/100, PKG_IM_VERTRIEBSGEBIET.F_EKVT_TO_PREISFIRMA(vtgebiet), &termin) ,6),0) AS numswertvek,
                        saison,
                        retbewegid_key,
                        prozessid,
                        fakturaid_key,
                        auftrag_auftragpoolid_key,
                        auftragposid_key,
                        CASE WHEN umsstorno > 0 AND etbereich != 99 THEN ABS(COALESCE(ROUND((umsstorno/100)*PKG_IM_VERTRIEBSGEBIET.F_GET_LANDESWAEHRUNG(vkp/100, PKG_IM_VERTRIEBSGEBIET.F_EKVT_TO_PREISFIRMA(vtgebiet), &termin) ,6),0)) ELSE 0 END AS Lagerdiffwert,                          
                        CASE WHEN umsstorno > 0 AND etbereich != 99 THEN ABS(COALESCE(ROUND((umsstorno/100)*
                            CASE WHEN vkp_fakt != 0 THEN vkp_fakt/100 
                                 ELSE PKG_IM_VERTRIEBSGEBIET.F_GET_LANDESWAEHRUNG(vkp/100, PKG_IM_VERTRIEBSGEBIET.F_EKVT_TO_PREISFIRMA(vtgebiet), &termin) END,6),0)) ELSE 0 END AS Lagerdiffohnerabattwert, 
                        COALESCE(ROUND((importanteil/100)*PKG_IM_VERTRIEBSGEBIET.F_GET_LANDESWAEHRUNG(komwarenwert/100, PKG_IM_VERTRIEBSGEBIET.F_EKVT_TO_PREISFIRMA(vtgebiet), &termin) ,6),0) AS impantwert, 
                        COALESCE(ROUND((importanteil/100)*
                             CASE WHEN vkp_fakt != 0 THEN vkp_fakt/100 
                                 ELSE PKG_IM_VERTRIEBSGEBIET.F_GET_LANDESWAEHRUNG(vkp/100, PKG_IM_VERTRIEBSGEBIET.F_EKVT_TO_PREISFIRMA(vtgebiet), &termin) END,6),0) AS impantohnerabattwert,                                                                                                                                                                                                                             
                        stationaerkz,
                        cc_stationaerkz.wert,
                        CASE WHEN etbereich != 99 THEN umsstorno/100 ELSE 0 END,
                        vkp_fakt,
                        CASE WHEN firma = 1 THEN 1 ELSE -3 END AS paybackauftrag,
                        1 AS imhostmig
            FROM sc_ww_buchung JOIN sc_ww_kundenfirma
              ON (sc_ww_buchung.dwh_id_sc_ww_kundenfirma = sc_ww_kundenfirma.dwh_id)
            JOIN sc_ww_kundenfirma_ver
              ON (sc_ww_kundenfirma.dwh_id = sc_ww_kundenfirma_ver.dwh_id_head AND &termin BETWEEN sc_ww_kundenfirma_ver.dwh_valid_from AND sc_ww_kundenfirma_ver.dwh_valid_to)
            JOIN cc_firma
              ON (sc_ww_kundenfirma_ver.dwh_id_cc_firma = cc_firma.dwh_id)
            JOIN sc_ww_likz
              ON (sc_ww_buchung.dwh_id_sc_ww_likz = sc_ww_likz.dwh_id)
            JOIN sc_ww_likz_ver
              ON (sc_ww_likz.dwh_id = sc_ww_likz_ver.dwh_id_head AND &termin BETWEEN sc_ww_likz_ver.dwh_valid_from AND sc_ww_likz_ver.dwh_valid_to)
            JOIN cc_artstat
              ON (sc_ww_likz_ver.dwh_id_cc_artstat = cc_artstat.dwh_id)
            JOIN sc_ww_zahlungskz
              ON (sc_ww_buchung.dwh_id_sc_ww_zahlungskz = sc_ww_zahlungskz.dwh_id)
            JOIN sc_ww_zahlungskz_ver
              ON (sc_ww_zahlungskz.dwh_id = sc_ww_zahlungskz_ver.dwh_id_head AND &termin BETWEEN sc_ww_zahlungskz_ver.dwh_valid_from AND sc_ww_zahlungskz_ver.dwh_valid_to)
            JOIN cc_zahlwunsch
              ON (sc_ww_zahlungskz_ver.dwh_id_cc_zahlwunsch = cc_zahlwunsch.dwh_id)
            JOIN sc_ww_mgeinh
              ON (sc_ww_buchung.dwh_id_sc_ww_mgeinh = sc_ww_mgeinh.dwh_id)
            JOIN sc_ww_mgeinh_ver
              ON (sc_ww_mgeinh.dwh_id = sc_ww_mgeinh_ver.dwh_id_head AND &termin BETWEEN sc_ww_mgeinh_ver.dwh_valid_from AND sc_ww_mgeinh_ver.dwh_valid_to)
            JOIN cc_meterware
              ON (sc_ww_mgeinh_ver.dwh_id_cc_meterware = cc_meterware.dwh_id)
    JOIN sc_ww_stationaerkz
         ON (sc_ww_buchung.dwh_id_sc_ww_stationaerkz = sc_ww_stationaerkz.dwh_id)
    JOIN sc_ww_stationaerkz_ver
         ON (sc_ww_stationaerkz.dwh_id = sc_ww_stationaerkz_ver.dwh_id_head AND &termin BETWEEN sc_ww_stationaerkz_ver.dwh_valid_From AND sc_ww_stationaerkz_ver.dwh_valid_to)
    JOIN cc_stationaerkz
         ON (sc_ww_stationaerkz_ver.dwh_id_cc_stationaerkz = cc_stationaerkz.dwh_id)
    WHERE TRUNC(dwh_processdate) = TRUNC(&termin)
                AND PKG_IM_VERTRIEBSGEBIET.F_EKVT_MIT_SAMMELKONTO(vtgebiet) = 1
                AND vtgebiet NOT IN ('c', 'f', 'F', '4', 'r')
                AND sc_ww_buchung.firma NOT IN ( 24,27 ) -- Sammelkonto helline und Schweden raus
                AND NOT ( ansprachen = 0
                     AND ansprachen_tele = 0
                     AND brabs = 0
                     AND brabsers = 0
                     AND ersverw = 0
                     AND importanteil = 0
                     AND nali = 0
                     AND nili = 0
                     AND telenili = 0
                     AND nina = 0
                     AND nabstorno = 0
                     AND nums = 0
                     AND retoure = 0
                     AND umsstorno = 0
                     AND brumsdiff_betrag = 0
                     AND retdiff_betrag = 0);
  
COMMIT;  



EXEC PKG_STATS.GATHERTABLE (USER, 'clcc_ww_buchung_19');



PROMPT =======================================================================================================
PROMPT 1.3 OhneRabattWerte wenn leer auf Standardwerte setzen (bei Sammelkonten ist vkp_fakt immer leer)
PROMPT =======================================================================================================

-- Otto Markplatz ausschliessen, Berechnung oben korrigiert auf VKP, falls VKP_FAKT leer ist

UPDATE clcc_ww_buchung_19 SET
  ansprohnerabattwert = anspr_wert,
  naliohnerabattwert = nali_wert,
  niliohnerabattwert = nili_wert,      
  teleniliohnerabattwert = telenili_wert,  
  numsohnerabattwert = nums_wert,  
  brabsohnerabattwert = brabs_wert,  
  retohnerabattwert = ret_wert,
  ninaohnerabattwert = nina_wert, 
  nabstornoohnerabattwert = nabstorno_wert,
  umsstornoohnerabattwert = umsstorno_wert,
  Lagerdiffohnerabattwert = Lagerdiffwert,
  impantohnerabattwert = impantwert 
WHERE buchungsdatum = TRUNC(&termin)
AND PKG_IM_VERTRIEBSGEBIET.F_EKVT_MIT_SAMMELKONTO(ek_vtgebiet) = 1
AND firma NOT IN (28,200,201,202);

COMMIT;


PROMPT =========================================================================
PROMPT 2. Firmenkennzeichen aktualisieren Cross-Selling (Otto Marktplatz Firmen nicht ueberschreiben!)
PROMPT =========================================================================

MERGE INTO clcc_ww_buchung_19 a
USING sc_ww_vertrgebiet_ver b
  ON (a.ek_vtgebiet = b.vertrgebiet AND b.dwh_valid_to = DATE '9999-12-31')
WHEN MATCHED THEN 
  UPDATE SET a.firma = 
      CASE WHEN a.ek_vtgebiet IN ('S') THEN 1
      ELSE b.firma_im END
   WHERE (PKG_IM_VERTRIEBSGEBIET.F_EKVT_MIT_SAMMELKONTO(ek_vtgebiet) = 1 OR ek_vtgebiet = 'S')
   AND a.ek_vtgebiet != '!';

COMMIT;



PROMPT ======================================================
PROMPT 3. VFKZ setzen
PROMPT ======================================================

PROMPT -------------------------------------------------------------------------
PROMPT 3.1 Nicht Sammelkonten (Referenz Tabelle CC_ART und CC_MARKTKZ) über VKP_FAKT
PROMPT -------------------------------------------------------------------------

MERGE INTO clcc_ww_buchung_19 a
   USING (SELECT DISTINCT 
               artnr AS artikelnr,
               eksaison AS umsatzsaison
          FROM cc_art ca
          JOIN cc_marktkz cm 
          ON (ca.marktkz = cm.wert AND ca.dwh_valid_to = TO_DATE ('31.12.9999','dd.mm.rrrr') AND cm.dwh_valid_to = TO_DATE ('31.12.9999','dd.mm.rrrr'))
          JOIN cc_obermarktkz_akt_v omkz ON (omkz.wert = cm.obermarktkz)
          WHERE omkz.bez = 'VF-Artikel')  b
    ON (a.umsatzsaison = b.umsatzsaison AND a.artikelnr = b.artikelnr)
    WHEN MATCHED THEN UPDATE
  SET
    a.vfkz = CASE WHEN a.vkp_fakt = 0 AND a.firma != 14 THEN 2 --1
                  WHEN a.vkp_fakt = 0 AND a.firma = 14 AND a.buchungsdatum < to_Date('01.07.2014', 'dd.mm.rrrr') THEN 2 --1
                  WHEN a.vkp_fakt <= 1 AND a.firma = 14 AND a.buchungsdatum >= to_Date('01.07.2014', 'dd.mm.rrrr') THEN 2 --1              
                  WHEN a.vkp_fakt > 0 AND a.firma != 14 THEN 3 --2
                  WHEN a.vkp_fakt > 0 AND a.firma = 14 AND a.buchungsdatum < to_Date('01.07.2014', 'dd.mm.rrrr') THEN 3 --2
                  WHEN a.vkp_fakt > 1 AND a.firma = 14 AND a.buchungsdatum >= to_Date('01.07.2014', 'dd.mm.rrrr') THEN 3 --2              
              ELSE 1 --0 
              END
 WHERE PKG_IM_VERTRIEBSGEBIET.F_EKVT_MIT_SAMMELKONTO(ek_vtgebiet) = 0;  

COMMIT;

PROMPT -------------------------------------------------------------------------
PROMPT 3.2 Sammelkonten (Referenz Tabelle CC_ART und CC_MARKTKZ) über VKP/VERKPREIS
PROMPT -------------------------------------------------------------------------

MERGE INTO clcc_ww_buchung_19 a
   USING (SELECT DISTINCT 
               artnr AS artikelnr,
               eksaison AS umsatzsaison
          FROM cc_art ca
          JOIN cc_marktkz cm 
          ON (ca.marktkz = cm.wert AND ca.dwh_valid_to = TO_DATE ('31.12.9999','dd.mm.rrrr') AND cm.dwh_valid_to = TO_DATE ('31.12.9999','dd.mm.rrrr'))
          JOIN cc_obermarktkz_akt_v omkz ON (omkz.wert = cm.obermarktkz)
          WHERE omkz.bez = 'VF-Artikel')  b
    ON (a.umsatzsaison = b.umsatzsaison AND a.artikelnr = b.artikelnr)
    WHEN MATCHED THEN UPDATE
  SET
    a.vfkz = CASE WHEN a.verkpreis = 0 AND a.firma != 14 THEN 2 --1
                  WHEN a.verkpreis = 0 AND a.firma = 14 AND a.buchungsdatum < to_Date('01.07.2014', 'dd.mm.rrrr') THEN 2 --1
                  WHEN a.verkpreis <= 1 AND a.firma = 14 AND a.buchungsdatum >= to_Date('01.07.2014', 'dd.mm.rrrr') THEN 2 --1              
                  WHEN a.verkpreis > 0 AND a.firma != 14 THEN 3 --2
                  WHEN a.verkpreis > 0 AND a.firma = 14 AND a.buchungsdatum < to_Date('01.07.2014', 'dd.mm.rrrr') THEN 3 --2
                  WHEN a.verkpreis > 1 AND a.firma = 14 AND a.buchungsdatum >= to_Date('01.07.2014', 'dd.mm.rrrr') THEN 3 --2              
              ELSE 1 --0 
              END
 WHERE PKG_IM_VERTRIEBSGEBIET.F_EKVT_MIT_SAMMELKONTO(ek_vtgebiet) = 1;              
              
COMMIT;



PROMPT -------------------------------------------------------------------------
PROMPT 3.3 Rest sind "normale" Artikel (keine VF-Artikel)
PROMPT -------------------------------------------------------------------------

UPDATE clcc_ww_buchung_19 a
SET vfkz = 1
WHERE a.vfkz IS NULL;        

COMMIT;


PROMPT -------------------------------------------------------------------------
PROMPT 3.4 VFKZ 4 = Katalog setzen über die Warengruppe
PROMPT -------------------------------------------------------------------------

-- Sowohl über Umsatzsaison als auch Saison joinen wg. Ersatzartikel (hier ist Umsatzsaison falsch)

-- Umsatzsaison als Join Bedingung

UPDATE clcc_ww_buchung_19 a
SET vfkz = 4
WHERE umsatzsaison||artikelnr IN
    (SELECT art_id FROM cc_art
    WHERE dwh_valid_to = DATE '9999-12-31'
    AND wagrpkt IN
        (SELECT wert FROM cc_wagrpkt
            WHERE SUBSTR(sg, -4) = '73-6'));
            
COMMIT;

-- Saison als Join Bedingung

UPDATE clcc_ww_buchung_19 a
SET vfkz = 4
WHERE saison||artikelnr IN
    (SELECT art_id FROM cc_art
    WHERE dwh_valid_to = DATE '9999-12-31'
    AND wagrpkt IN
        (SELECT wert FROM cc_wagrpkt
            WHERE SUBSTR(sg, -4) = '73-6'));
            
COMMIT;


PROMPT =============================================================
PROMPT 4. Umcodierung Firma auf CC-Referenz
PROMPT =============================================================

MERGE INTO clcc_ww_buchung_19 a
  USING cc_firma_waepumig_v f
   ON (a.firma = f.sg AND &termin between dwh_valid_from and dwh_valid_to)
   WHEN MATCHED THEN 
    UPDATE
    SET a.firma_cc = f.wert;

COMMIT;


-- Für Firma 149 basierend auf VT-Gebiet, da 149 nicht eindeutig ist

MERGE INTO clcc_ww_buchung_19 a
USING
(SELECT DISTINCT swv.vertrgebiet, cf.wert FROM sc_ww_vertrgebiet_ver swv JOIN cc_firma cf 
ON (swv.dwh_id_cc_firma = cf.dwh_id AND &termin BETWEEN swv.dwh_valid_from AND swv.dwh_valid_to AND swv.firma_im = 149)) f
ON (a.ek_vtgebiet = f.vertrgebiet)
WHEN MATCHED THEN UPDATE
SET a.firma_cc = f.wert;

COMMIT; 
  

PROMPT =========================================================================
PROMPT 5. Ersatzartikelnr bei allen Buchungen einer Auftragsposition übernehmen
PROMPT =========================================================================

CREATE INDEX clcc_ww_buchung_19_idx1 
ON clcc_ww_buchung_19 (ersatzartikelnr, COALESCE(auftrnr_key, '0'), COALESCE(auftrpos,0), konto_id_key);

UPDATE  clcc_ww_buchung_19 a
SET 
  ersatzartikelnr=
   (SELECT COALESCE(artikelnr,1) FROM clcc_ww_buchung_19 b
    WHERE b.ersatzartikelnr=a.artikelnr
    AND COALESCE(b.auftrnr_key, '0')=COALESCE(a.auftrnr_key,'0')
    AND COALESCE(b.auftrpos,0)=COALESCE(a.auftrpos,0)
    AND b.konto_id_key=a.konto_id_key
    AND ROWNUM<2),
  ersatzgroesse=
   (SELECT COALESCE(groesse,1) FROM clcc_ww_buchung_19 b
    WHERE b.ersatzartikelnr=a.artikelnr
    AND COALESCE(b.auftrnr_key, '0')=COALESCE(a.auftrnr_key,'0')
    AND COALESCE(b.auftrpos,0)=COALESCE(a.auftrpos,0)
    AND b.konto_id_key=a.konto_id_key
    AND ROWNUM<2)
WHERE ersverw>0
AND PKG_IM_VERTRIEBSGEBIET.F_EKVT_MIT_SAMMELKONTO(ek_vtgebiet) = 0;

COMMIT;

DROP INDEX clcc_ww_buchung_19_idx1;



PROMPT =========================================================================
PROMPT 6. Ausstattung-ID setzen
PROMPT =========================================================================

PROMPT =========================================================================
PROMPT 6.1 ID für Ansprachebuchungen setzen
PROMPT =========================================================================

TRUNCATE TABLE clcc_ww_buchung_01;

INSERT --+ APPEND 
INTO clcc_ww_buchung_01
(
   dwh_cr_load_id,
   konto_id_key,
   katalogart
)
   SELECT DISTINCT 
      &gbvid, 
      konto_id_key, 
      katalogart
   FROM clcc_ww_buchung_19
   WHERE anspr > 0
   AND PKG_IM_VERTRIEBSGEBIET.F_EKVT_MIT_SAMMELKONTO(ek_vtgebiet) = 0;


EXEC PKG_STATS.GATHERTABLE(user,'clcc_ww_buchung_01');


PROMPT =========================================================================
PROMPT 6.2 Hilfstabellen erstellen als Auszug aus Ausstattung und Buchung
PROMPT =========================================================================

TRUNCATE TABLE clcc_ww_buchung_04;

INSERT --+ APPEND ENABLE_PARALLEL_DML
INTO clcc_ww_buchung_04
(
   dwh_cr_load_id,
   konto_id_key,
   versanddat,
   katart,
   eksaison,
   vtsaison,
   echtversand,
   ausstattung_dir_id
)
SELECT /*+ PARALLEL */
   &gbvid, 
   konto_id_key,
   versanddat,
   katart,
   eksaison,
   vtsaison,
   echtversand,
   ausstattung_dir_id
FROM  cc_ausstattung_dir_v
WHERE vtsaison IN (&eksaison, &eksaisonm1, &eksaisonm2, &eksaisonp1)
AND konto_id_key IN
  (SELECT DISTINCT
         konto_id_key         
     FROM clcc_ww_buchung_01);
     
COMMIT; 

TRUNCATE TABLE clcc_ww_buchung_02;

INSERT --+ APPEND 
INTO clcc_ww_buchung_02
(
   dwh_cr_load_id,
   konto_id_key,
   katalogart,
   eksaison,
   versanddatum,
   ausstattung_id
)
SELECT /*+ parallel */ 
   &gbvid, 
   konto_id_key, 
   TO_NUMBER(SUBSTR(c.sg, -4)) AS katart, 
   eksaison,
   versanddat, 
   ausstattung_dir_id
FROM clcc_ww_buchung_04 a JOIN cc_katart c 
ON (a.katart = c.wert AND c.dwh_valid_to = TO_DATE ('31.12.9999','dd.mm.rrrr') AND a.vtsaison IN (&eksaison, &eksaisonm1, &eksaisonm2, &eksaisonp1))
WHERE (konto_id_key, TO_NUMBER(SUBSTR(c.sg, -4))) IN
    (SELECT DISTINCT 
         konto_id_key, 
         katalogart 
     FROM clcc_ww_buchung_01)
AND echtversand = 2
AND versanddat <=&termin;

COMMIT;

EXEC PKG_STATS.GATHERTABLE(user,'clcc_ww_buchung_02');


PROMPT =========================================================================
PROMPT 6.3 Ausstattungs-ID für die Ansprachebuchungen in der Tagestabelle setzen, falls nicht eindeutig MIN verwenden
PROMPT =========================================================================

MERGE INTO clcc_ww_buchung_19 a                                                
USING (
   SELECT konto_id_key, katalogart, eksaison, rangx AS rang, MIN(ausstattung_id) AS ausstattung_id FROM
       (
        SELECT DISTINCT ausstattung_id, konto_id_key, katalogart, eksaison, RANK() OVER (PARTITION BY konto_id_key, katalogart, eksaison ORDER BY Versanddatum DESC) AS rangx
        FROM clcc_ww_buchung_02
        )
    WHERE rangx = 1
    GROUP BY konto_id_key, katalogart, eksaison, rangx
    ) b
ON (a.konto_id_key = b.konto_id_key AND a.katalogart = b.katalogart AND a.umsatzsaison = b.eksaison AND a.anspr > 0 AND b.rang = 1)
WHEN MATCHED THEN UPDATE
SET a.ausstattung_id = b.ausstattung_id;

COMMIT;



PROMPT =========================================================================
PROMPT 6.4 Relevante Datensätze aus Gesamt cc_buchung in Temporärtabelle einspielen (Auftrnr/Pos)
PROMPT ========================================================================= 

TRUNCATE TABLE clcc_ww_buchung_14;
 
INSERT --+ APPEND
INTO clcc_ww_buchung_14 
(
    dwh_cr_load_id, 
    konto_id_key, 
    auftrnr_key,
    auftrpos, 
    ausstattung_id, 
    buchungsdatum,  
    erslief
)
    SELECT 
    &gbvid, 
    konto_id_key, 
    auftrnr_key,
    auftrpos,
    ausstattung_dir_id, 
    buchdat, 
    erslief
FROM cc_buchung                                                          
WHERE (COALESCE(auftrnr_key,'0'), COALESCE(auftrpos,0)) IN
   (SELECT DISTINCT COALESCE(auftrnr_key,'0'), COALESCE(auftrpos,0) FROM clcc_ww_buchung_19)
AND buchdat <= &termin
AND auftrnr_key IS NOT NULL;

COMMIT;


PROMPT =========================================================================
PROMPT 6.5 Auch die Buchungen der 400 er Posititionen einfuegen für spätere Suche
PROMPT ========================================================================= 

INSERT --+ APPEND
INTO clcc_ww_buchung_14 
(
    dwh_cr_load_id, 
    konto_id_key, 
    auftrnr_key,
    auftrpos, 
    ausstattung_id, 
    buchungsdatum,  
    erslief
)
    SELECT 
    &gbvid, 
    konto_id_key, 
    auftrnr_key,
    auftrpos,
    ausstattung_dir_id, 
    buchdat, 
    erslief
FROM cc_buchung                                                          
WHERE (COALESCE(auftrnr_key,'0'), COALESCE(auftrpos,0)) IN
   (SELECT cl19.auftrnr_key, auf2.lfdartposnr
      FROM clcc_ww_buchung_19 cl19       
      JOIN sc_ww_auftrag_auftpool_ver p2 on (p2.auftrnr_key = cl19.auftrnr_key AND &termin BETWEEN p2.dwh_valid_from AND p2.dwh_valid_to)      
      JOIN sc_ww_auftrag_auftpool p1 ON (p1.dwh_id = p2.dwh_id_head)
      JOIN sc_ww_auftragpos auf1 ON (p2.auftragposid_key = auf1.id_key)
      JOIN  sc_ww_auftragpos_ver auf2 on (auf2.dwh_id_head = auf1.dwh_id AND &termin BETWEEN auf2.dwh_valid_from AND auf2.dwh_valid_to)
      WHERE auf2.lfdartposnr != p2.auftrpos 
      and cl19.auftrpos = 400
)
AND buchdat <= &termin
AND auftrnr_key IS NOT NULL;

COMMIT;


PROMPT =========================================================================
PROMPT 6.6 Auftrpos_org setzen fuer spaeteren Join
PROMPT ========================================================================= 

MERGE INTO clcc_ww_buchung_14 cl14
USING
(
SELECT cl19.auftrnr_key, cl19.auftrpos, MIN(auf2.lfdartposnr) AS lfdartposnr
      FROM clcc_ww_buchung_19 cl19       
      JOIN sc_ww_auftrag_auftpool_ver p2 on (p2.auftrnr_key = cl19.auftrnr_key AND &termin BETWEEN p2.dwh_valid_from AND p2.dwh_valid_to)      
      JOIN sc_ww_auftrag_auftpool p1 ON (p1.dwh_id = p2.dwh_id_head)
      JOIN sc_ww_auftragpos auf1 ON (p2.auftragposid_key = auf1.id_key)
      JOIN  sc_ww_auftragpos_ver auf2 on (auf2.dwh_id_head = auf1.dwh_id AND &termin BETWEEN auf2.dwh_valid_from AND auf2.dwh_valid_to)
      WHERE auf2.lfdartposnr != p2.auftrpos 
      AND cl19.auftrpos = 400
      GROUP BY cl19.auftrnr_key, cl19.auftrpos   
) x
ON (x.auftrnr_key = cl14.auftrnr_key AND x.auftrpos = cl14.auftrpos) 
WHEN MATCHED THEN 
UPDATE SET cl14.auftrpos_org = x.lfdartposnr;

COMMIT;



PROMPT =========================================================================
PROMPT 6.7 Gefundene Ausstattung_id aus OriginalPosititon übernehmen
PROMPT ========================================================================= 

MERGE INTO clcc_ww_buchung_14 ckl4
USING
(
SELECT DISTINCT auftrnr_key, auftrpos, ausstattung_id
FROM clcc_ww_buchung_14
WHERE auftrpos != 400
AND ausstattung_id IS NOT NULL
) x
ON (x.auftrnr_key = ckl4.auftrnr_key AND x.auftrpos = ckl4.auftrpos_org)
WHEN MATCHED THEN
UPDATE SET ckl4.ausstattung_id = x.ausstattung_id
WHERE ckl4.ausstattung_id IS NULL;

COMMIT;


EXEC PKG_STATS.GATHERTABLE (user, 'clcc_ww_buchung_14');



PROMPT =========================================================================
PROMPT 6.8 ID für Folgebuchungen (Brabs/Ret usw.) setzen (für taggleiche Buchungen)
PROMPT =========================================================================

MERGE INTO clcc_ww_buchung_19 a
USING (SELECT konto_id_key, auftrnr_key, auftrpos, MIN(ausstattung_id) AS ausstattung_id FROM clcc_ww_buchung_19 WHERE anspr > 0 AND ausstattung_id IS NOT NULL AND auftrnr_key IS NOT NULL
        GROUP BY konto_id_key, auftrnr_key, auftrpos) b
ON (a.konto_id_key = b.konto_id_key AND a.auftrnr_key = b.auftrnr_key AND a.auftrpos = b.auftrpos AND a.auftrnr_key IS NOT NULL AND a.anspr <= 0)
WHEN MATCHED THEN UPDATE
SET a.ausstattung_id = b.ausstattung_id;

COMMIT;

-- 21.4.2015: Für 1(!) Kunden gab es 2 Ausstattungs-IDs => min-Funktion.

TRUNCATE TABLE clcc_ww_buchung_03;

INSERT /*+ APPEND */
INTO clcc_ww_buchung_03
(
   dwh_cr_load_id,
   konto_id_key,
   auftrnr_key,
   auftrpos,
   ausstattung_id
)   
SELECT /*+ FULL (b) */                                                          
DISTINCT 
   &gbvid, 
   konto_id_key, 
   auftrnr_key,
   auftrpos, 
   MIN(ausstattung_id) AS ausstattung_id 
FROM clcc_ww_buchung_14 b
WHERE ausstattung_id IS NOT NULL
GROUP BY konto_id_key, auftrnr_key, auftrpos;

COMMIT;

EXEC PKG_STATS.GATHERTABLE(user,'clcc_ww_buchung_03');

MERGE INTO clcc_ww_buchung_19 a                                             
USING clcc_ww_buchung_03 b
ON (a.konto_id_key = b.konto_id_key AND a.auftrnr_key = b.auftrnr_key AND a.auftrpos = b.auftrpos AND a.auftrnr_key IS NOT NULL AND a.anspr <= 0)
WHEN MATCHED THEN UPDATE
SET a.ausstattung_id = b.ausstattung_id;

COMMIT;



PROMPT =========================================================================
PROMPT 7 Ersatzlieferung (Spalte erslief) in Folgebuchungen setzen (Quelle Teilauszug aus Gesamtobjekt CC_BUCHUNG)
PROMPT =========================================================================

TRUNCATE TABLE clcc_ww_buchung_05;

INSERT /*+ APPEND */ INTO clcc_ww_buchung_05 
(
    dwh_cr_load_id, 
    auftrnr_key,
    auftrpos
)
    SELECT DISTINCT 
       &gbvid, 
       b.auftrnr_key,
       b.auftrpos
    FROM clcc_ww_buchung_14 a, clcc_ww_buchung_19 b
    WHERE b.auftrnr_key = a.auftrnr_key
    AND b.auftrpos = a.auftrpos
    AND b.erslief = 1 -- keine Erslief in CL-Tabelle
    AND a.erslief = 2  -- Erslief in CC-Tabelle
    AND b.anspr = 0
    AND b.auftrnr_key IS NOT NULL;

COMMIT;

EXEC PKG_STATS.GATHERTABLE(user,'clcc_ww_buchung_05');


MERGE INTO clcc_ww_buchung_19 a
 USING clcc_ww_buchung_05 b
 ON (a.auftrnr_key = b.auftrnr_key  AND a.auftrpos = b.auftrpos)
 WHEN MATCHED THEN
  UPDATE SET a.erslief = 2
WHERE a.erslief = 1
AND a.anspr = 0;

COMMIT;

UPDATE clcc_ww_buchung_19
SET erslief = 1
WHERE erslief IS NULL;

COMMIT;


PROMPT =========================================================================
PROMPT 8. Artikel-Referenzen setzen
PROMPT =========================================================================

PROMPT =========================================================================
PROMPT 8.1 ART-ID mit Unterscheidung normalen und Ersatzlieferungen
PROMPT =========================================================================

-- Bei normalen Lieferungen wird Umsatzsaison verwendet - nur bei Ersatzlieferung wird Artikelsaison verwendet!

UPDATE clcc_ww_buchung_19
SET art_id = CASE WHEN erslief != 2 THEN umsatzsaison||artikelnr ELSE saison||artikelnr END;
COMMIT;


PROMPT =========================================================================
PROMPT 8.2 Abgleich mit Artikeltabellen CC_ART (nur vorhandene werden gesetzt)
PROMPT =========================================================================

UPDATE clcc_ww_buchung_19
SET art_id = 0
WHERE art_id NOT IN
(SELECT art_id FROM cc_art
  WHERE dwh_valid_to = TO_DATE ('31.12.9999', 'dd.mm.rrrr'));

COMMIT;


PROMPT =========================================================================
PROMPT 9. Auftragsdaten übernehmen
PROMPT =========================================================================

PROMPT =========================================================================
PROMPT 9.1 Quelle Auftragkopf Daten übernehmen und Referenzauflösung
PROMPT =========================================================================

PROMPT =========================================================================
PROMPT 9.1.1 Daten uebernehmen und Referenzauflösung
PROMPT =========================================================================

TRUNCATE TABLE clcc_ww_buchung_09;  

-- ##.66 Join-Bedingung Coalesce um den Key eingefügt. Ist aber normalerweise immer gefüllt

INSERT /*+ APPEND */ INTO clcc_ww_buchung_09                                
(
   dwh_cr_load_id,
   org_rowid,
   liefwunschkz,
   bestwegkz,
   mailnr,
   zahlwunsch,
   ratenwunsch,
   beilagenr
)   
SELECT DISTINCT 
   &gbvid, 
   cc.rowid, 
   sc_ww_lieferwunsch.wert,
   --clw.wert,   
   k.wert,
   CASE WHEN b.bestwegkz IN (1,2,3) THEN 0 ELSE 
     CASE WHEN TRUNC(a.anldat) BETWEEN DATE '2021-07-23' AND DATE '2021-08-04' AND a.mailnr = 800 THEN 0 ELSE a.mailnr END 
       END AS mailnr,  -- Mailnummer bei schriftlichen Bestellungen ausnullen; ##.80
   sc_ww_zahlmethode.wert,
   sc_ww_zahlwunsch.wert,
   a.beilagenr
FROM clcc_ww_buchung_19 cc
 JOIN sc_ww_auftragkopf_ver a
  ON (COALESCE(a.auftridentnr_key, '0') = COALESCE(cc.auftrnr_key, '0') AND &termin BETWEEN a.dwh_valid_from AND a.dwh_valid_to) 
 LEFT OUTER JOIN (sc_ww_bestweg c JOIN sc_ww_bestweg_ver b ON (b.dwh_id_head = c.dwh_id AND &termin BETWEEN b.dwh_valid_from AND b.dwh_valid_to) JOIN cc_anlauftrart k ON (b.dwh_id_cc_anlauftrart = k.dwh_id))
  ON (c.id = a.bestwegid)          
 LEFT OUTER JOIN (SELECT k1.dwh_id, v1.kz, cc.wert
                   FROM sc_ww_lieferwunsch k1 
                   JOIN sc_ww_lieferwunsch_ver v1
                      ON (k1.dwh_id = v1.dwh_id_head AND &termin BETWEEN v1.dwh_valid_from AND v1.dwh_valid_to)
                   JOIN cc_liefwunsch cc
                      ON (cc.dwh_id = v1.dwh_id_cc_liefwunsch)) sc_ww_lieferwunsch
  ON (a.liefwunschkz = sc_ww_lieferwunsch.kz)                      
 LEFT OUTER JOIN (SELECT k2.dwh_id, k2.id, cc.wert
                   FROM sc_ww_zahlmethode k2
                   JOIN sc_ww_zahlmethode_ver v2
                      ON (k2.dwh_id = v2.dwh_id_head AND &termin BETWEEN v2.dwh_valid_from AND v2.dwh_valid_to)
                   JOIN cc_zahlwunsch cc
                      ON (cc.dwh_id = v2.dwh_id_cc_zahlwunsch)) sc_ww_zahlmethode                     
  ON (a.zahlmethodeid = sc_ww_zahlmethode.id) 
 LEFT OUTER JOIN (SELECT k3.dwh_id, k3.id, cc.wert
                   FROM sc_ww_zahlwunsch k3
                   JOIN sc_ww_zahlwunsch_ver v3
                      ON (k3.dwh_id = v3.dwh_id_head AND &termin BETWEEN v3.dwh_valid_from AND v3.dwh_valid_to)
                   JOIN cc_ratenwunsch cc
                      ON (cc.dwh_id = v3.dwh_id_cc_ratenwunsch)) sc_ww_zahlwunsch                    
  ON (a.zahlwunschid = sc_ww_zahlwunsch.id);
      
COMMIT;

 
EXEC PKG_STATS.GATHERTABLE(user,'clcc_ww_buchung_09');


MERGE INTO clcc_ww_buchung_19 k                                             
 USING clcc_ww_buchung_09 ak
 ON (ak.org_rowid = k.rowid)
WHEN MATCHED THEN
 UPDATE SET k.liefwunschkz_auftrag_cc  = ak.liefwunschkz,
            k.auftragsart_cc = ak.bestwegkz,
            k.mailingnr = ak.mailnr,
            k.zahlmethodekz_cc = COALESCE(ak.zahlwunsch,0),
            k.zahlwunschkz_cc = COALESCE(ak.ratenwunsch,0),
            k.beilagenr = ak.beilagenr;
                        
COMMIT;


PROMPT =========================================================================
PROMPT 9.1.2 Stationär hat immer auftragsart 7
PROMPT =========================================================================

UPDATE clcc_ww_buchung_19                                                   
    SET auftragsart_cc = 7
    WHERE ek_vtgebiet = 'S';
    
COMMIT;

PROMPT =========================================================================
PROMPT 9.1.3 Für Otto Marktplatz/Limango (SG-Firma 28,200,201,202) wird auf 4 (Internet) gebucht
PROMPT =========================================================================

UPDATE clcc_ww_buchung_19
SET auftragsart_cc = 4
WHERE firma IN (28,200,201,202);

COMMIT;


PROMPT =========================================================================
PROMPT 9.1.4 Übergangslösung für Heine Firmen (Übernahme aus migrierten Altdaten)
PROMPT =========================================================================
 
MERGE INTO clcc_ww_buchung_19 k                                             
 USING
  (
 SELECT DISTINCT firma, buchdat, auftrnr_key, auftrart, liefwunsch, ratenwunsch, stationaerkz, zahlwunsch1, bestellkanal, ecc  
 FROM  cc_buchung
 WHERE (buchdat, auftrnr_key) IN (
   SELECT MIN(buchdat), auftrnr_key 
   FROM  cc_Buchung
   WHERE firma BETWEEN 48 AND 52 AND retwert=0
       AND buchdat BETWEEN DATE '2018-07-01' AND DATE '2021-12-31'
       AND auftrnr_key IN (
                            SELECT DISTINCT auftrnr_key
                            FROM clcc_ww_buchung_19
                            WHERE ret_wert > 0 AND firma BETWEEN 21 AND 25
                              AND COALESCE(auftragsart_cc,0) = 0
                          )
                          GROUP BY auftrnr_key
                          )
  )
 ak
 ON (ak.auftrnr_key = k.auftrnr_key)
WHEN MATCHED THEN
 UPDATE SET k.auftragsart_cc = ak.auftrart
WHERE firma BETWEEN 21 AND 25 AND ret_wert > 0;
                        
COMMIT;      



PROMPT =========================================================================
PROMPT 9.2 Daten aus Quelle Auftragpos
PROMPT =========================================================================

PROMPT =========================================================================
PROMPT 9.2.1 Übernehmen
PROMPT =========================================================================

-- Hinweis: 300 Tage zurück erwischen 99,9994% der Daten, Stichprobe März 2015

TRUNCATE TABLE clcc_ww_buchung_10;

INSERT /*+ APPEND */ INTO clcc_ww_buchung_10                                 
(
   dwh_cr_load_id,
   auftrnr_key,
   auftrpos,
   anlaufdatum,
   auftrstornokz,
   zugesteuertkz,
   alfa_ersatzartid,
   ersatzwunschkz,
   ersatzwunschkz_cc,
   bestarprom
)
SELECT DISTINCT 
   &gbvid, 
   ga.auftrnr_key,
   ga.auftrpos, 
   MIN(auf.anldat) AS anldat,
   MIN(auf.auftrstornokz) AS auftrstornokz, 
   auf.zugestartartkz, 
   auf.alfa_ersatzartid, 
   NULL, 
   NULL,
   MIN(auf.bestartprom) AS bestarprom
FROM sc_ww_auftragpos_ver auf
   JOIN  clcc_ww_buchung_19 ga
 ON (COALESCE(ga.auftrnr_key,'0') = COALESCE(auf.auftrnr_key, '0') AND COALESCE(ga.auftrpos,0) = COALESCE(auf.auftrpos,'0') AND &termin BETWEEN auf.dwh_valid_from AND auf.dwh_valid_to
 AND ga.auftrnr_key IS NOT NULL AND ga.auftrpos IS NOT NULL) --##.67
-- WHERE anldat >= &termin - 300
GROUP BY ga.auftrnr_key, ga.auftrpos, auf.zugestartartkz, auf.alfa_ersatzartid;

COMMIT;

EXEC PKG_STATS.GATHERTABLE(user,'clcc_ww_buchung_10');


PROMPT =========================================================================
PROMPT 9.2.2 Auflösung Alfaersatzartid
PROMPT =========================================================================

MERGE INTO clcc_ww_buchung_10 a
USING (SELECT h.id, v.kz, c.wert
       FROM  sc_ww_alfa_ersatzart h JOIN sc_ww_alfa_ersatzart_ver v
            ON (h.dwh_id = v.dwh_id_head AND &termin BETWEEN v.dwh_valid_from AND v.dwh_valid_to)
        JOIN cc_ersart c
            ON (c.dwh_id = v.dwh_id_cc_ersart AND &termin BETWEEN c.dwh_valid_from AND c.dwh_valid_to)) b
ON (a.alfa_ersatzartid = b.id)
WHEN MATCHED THEN UPDATE
SET a.ersatzwunschkz = b.kz,
a.ersatzwunschkz_cc = b.wert;

COMMIT;



PROMPT =========================================================================
PROMPT 9.2.3 Zurückspielen in Cleanse
PROMPT =========================================================================

-- Hinweis: Kein zusätzlicher Join über Kontonr, weil dann einige Fälle nicht zugeordnet werden können, z.B.
--          nachträgliche Retourenbuchungen auf CPD-Konten. Neue Ersatzwunschkennzeichen ab 1.2.2015 setzen.

-- ##.66 Coalesce in Join

MERGE INTO clcc_ww_buchung_19 kd                                            
USING clcc_ww_buchung_10 a
ON (COALESCE(a.auftrnr_key, '0') = COALESCE(kd.auftrnr_key, '0') AND COALESCE(a.auftrpos, 0) = COALESCE(kd.auftrpos, 0))
WHEN MATCHED
THEN UPDATE SET kd.bestelldatum  = a.anlaufdatum,
                kd.auftrstornokz = CASE WHEN kd.lieferkz = 31 THEN a.auftrstornokz ELSE kd.auftrstornokz END,
                kd.zugesteuertkz = a.zugesteuertkz,
                kd.ersatzwunschkz = a.ersatzwunschkz,
                kd.ersatzwunschkz_cc = a.ersatzwunschkz_cc,
                kd.bestarprom = a.bestarprom; 
                
COMMIT;


PROMPT =========================================================================
PROMPT 9.2.4 Bestartprom wie im Original nachbauen. Abgleich mit SC und einige zuruecksetzen
PROMPT ========================================================================= 

MERGE INTO clcc_ww_buchung_19 cl
USING
(
    SELECT DISTINCT cl19.auftrnr_key, cl19.auftrpos, cl19.artikelnr
    FROM clcc_ww_buchung_19 cl19 
    JOIN sc_ww_buchung sc ON (sc.auftrnr_key = cl19.auftrnr_key AND sc.auftrpos = cl19.auftrpos AND sc.artikelnr = cl19.artikelnr AND sc.buchungsdatum = trunc(sysdate))
    WHERE cl19.bestarprom IS NOT NULL
    AND sc.ersatzartikelnr IS NULL
    AND sc.ersatzartikelgroesse IS NULL    
 ) x
 ON (x.auftrnr_key = cl.auftrnr_key AND x.auftrpos = cl.auftrpos AND x.artikelnr = cl.artikelnr)
 WHEN MATCHED THEN
 UPDATE SET
 cl.bestarprom = NULL;
 
COMMIT;


PROMPT =========================================================================
PROMPT 9.2.5 Umcodierung auf DWH Referenz fuer Auftrstorno und Zugesteuertkz
PROMPT ========================================================================= 
 
MERGE INTO clcc_ww_buchung_19 a                                             
USING 
  (SELECT  
     lw.wert AS stornokz, 
     clw.wert AS storno 
   FROM sc_ww_auftrstornokz lw 
   JOIN sc_ww_auftrstornokz_ver lwv
ON (lwv.dwh_id_head = lw.dwh_id AND &termin BETWEEN lwv.dwh_valid_from AND lwv.dwh_valid_to) JOIN cc_auftrstorno clw ON (clw.dwh_id = lwv.dwh_id_cc_auftrstorno)) k
ON (a.auftrstornokz = k.stornokz)
WHEN MATCHED THEN UPDATE
SET a.auftrstornokz_cc = k.storno;

COMMIT;

MERGE INTO clcc_ww_buchung_19 a                                             
USING 
(SELECT 
    lw.wert AS zugestartart, 
    clw.wert AS zugestarttyp 
 FROM sc_ww_zugestartartkz lw 
 JOIN sc_ww_zugestartartkz_ver lwv
ON (lwv.dwh_id_head = lw.dwh_id AND &termin BETWEEN lwv.dwh_valid_from AND lwv.dwh_valid_to) JOIN cc_zugestarttyp clw ON (clw.dwh_id = lwv.dwh_id_cc_zugestarttyp)) k
ON (a.zugesteuertkz = k.zugestartart)
WHEN MATCHED THEN UPDATE
SET a.zugesteuertkz_cc = k.zugestarttyp;


PROMPT =========================================================================
PROMPT 9.2.6 Über Auftragsposidentnr (11 Stellen) Auftragsdaten setzen
PROMPT ========================================================================= 

-- Teilweise existieren in der Auftragpos keine Datensätze für die Auftragsposidentnr, daher
-- Übernahme aus anderen Buchungen des gleichen Auftrags

TRUNCATE TABLE clcc_ww_buchung_11;

INSERT /*+ APPEND */ INTO clcc_ww_buchung_11                                
(
   dwh_cr_load_id,
   auftrnr_key,
   auftrpos,
   bestelldatum
)   
SELECT DISTINCT 
   &gbvid, 
   ga.auftrnr_key,
   ga.auftrpos,
   MIN(auf.anldat) AS bestelldatum
FROM sc_ww_auftragpos_ver auf
   JOIN  clcc_ww_buchung_19 ga
 ON (ga.auftrnr_key = auf.auftrnr_key AND &termin BETWEEN auf.dwh_valid_from AND auf.dwh_valid_to)
-- WHERE anldat >= &termin - 300
WHERE auf.auftrnr_key IS NOT NULL
AND buchungsdatum >= TO_DATE ('01.01.2012', 'dd.mm.rrrr')
GROUP BY ga.auftrnr_key,ga.auftrpos;


COMMIT;

EXEC PKG_STATS.GATHERTABLE(user,'clcc_ww_buchung_11');

-- Hinweis: Kein zusätzlicher Join über Kontonr, weil dann einige Fälle nicht zugeordnet werden können, z.B.
--          nachträgliche Retourenbuchungen auf CPD-Konten
MERGE INTO clcc_ww_buchung_19 kd                                            
USING clcc_ww_buchung_11 a
ON (a.auftrnr_key = kd.auftrnr_key AND a.auftrpos = kd.auftrpos)
WHEN MATCHED
THEN UPDATE SET kd.bestelldatum = a.bestelldatum;

COMMIT;


MERGE INTO clcc_ww_buchung_19 a
USING (
        SELECT MIN(auftrdat) bestelldatum, 
               konto_id_key, 
               auftrnr_key, 
               firma 
        FROM cc_buchung 
        WHERE konto_id_key IN (SELECT konto_id_key FROM clcc_ww_buchung_19) 
        GROUP BY konto_id_key, auftrnr_key, firma) b
ON (a.konto_id_key = b.konto_id_key AND a.auftrnr_key = b.auftrnr_key )
WHEN MATCHED THEN UPDATE
SET
   a.bestelldatum = b.bestelldatum
WHERE a.bestelldatum IS NULL;

COMMIT;


PROMPT Bestelldatum und Auftrart bei Otto Marketplace aus Auftrpool setzen 
PROMPT (externe Auftraege sind nicht in auftragkopf/auftragpos enthalten)

MERGE INTO clcc_ww_buchung_19 a
USING (
        SELECT                
           p1.id_key, p2.anldat
        FROM sc_ww_auftrag_auftpool p1
        JOIN sc_ww_auftrag_auftpool_ver p2 ON (p2.dwh_id_head = p1.dwh_id AND &termin BETWEEN dwh_valid_from AND dwh_valid_to)                 
        ) b
ON (a.auftrag_auftragpoolid_key = b.id_key)
WHEN MATCHED THEN UPDATE
SET
   a.bestelldatum = b.anldat
WHERE a.bestelldatum IS NULL
AND a.firma IN (28,200,201,202);

COMMIT;



---------

PROMPT =========================================================================
PROMPT 10. Bestellzaehler
PROMPT ========================================================================= 

PROMPT =========================================================================
PROMPT 10.1 Temporärtabelle mit minimalen Auftragsdatumswerten erstellen
PROMPT ========================================================================= 

TRUNCATE TABLE clcc_ww_buchung_12;

INSERT /*+ APPEND */ INTO clcc_ww_buchung_12                                
(
   dwh_cr_load_id,
   konto_id_key,
--   konto_id,
   auftragsnummer_key,
   bestelldatum,
   firma
)
SELECT  
   &gbvid, 
   konto_id_key,
--   konto_id,
   auftrnr_key AS auftragsnummer_key,  
   MIN(NVL(bestelldatum, buchungsdatum)) AS bestelldatum,   -- hier geändert andgag: 29.07.2020 Sortierung soll über Bestelldatum erfolgen! 
   firma
FROM clcc_ww_buchung_19 
WHERE (PKG_IM_VERTRIEBSGEBIET.F_IS_STAMMGESCHAEFT(firma) = 1)
AND auftrnr_key IS NOT NULL
AND anspr > 0
GROUP BY 
        konto_id_key, 
--        konto_id, 
        firma, 
        auftrnr_key 
        ;

EXEC PKG_STATS.GATHERTABLE(user,'clcc_ww_buchung_12');
 


PROMPT =========================================================================
PROMPT 10.2 Kundenaufträge sortieren
PROMPT ========================================================================= 

TRUNCATE TABLE clcc_ww_buchung_13;

INSERT /*+ APPEND */ INTO clcc_ww_buchung_13
(
   dwh_cr_load_id,
   konto_id_key,
--   konto_id, 
   auftragsnummer_key,
--   auftragsnummer, 
   bestelldatum, 
   firma, 
   rank)
SELECT 
   &gbvid, 
   konto_id_key, 
--   konto_id,
   auftragsnummer_key,
--   auftragsnummer, 
   bestelldatum, 
   firma,
   DENSE_RANK() OVER (PARTITION BY konto_id_key  ORDER BY bestelldatum, auftragsnummer_key) AS rank
FROM  clcc_ww_buchung_12 w;


EXEC PKG_STATS.GATHERTABLE(user,'clcc_ww_buchung_13');


PROMPT =========================================================================
PROMPT 10.2 Alten Bestellzähler ergänzen
PROMPT ========================================================================= 
 
-- Vorher Bestellzähler-Tabelle kopieren, es wird bis zum Abschluss-Skript nur auf einer Kopie gearbeitet!

TRUNCATE TABLE clcc_ww_buchung_23; 


INSERT /*+ APPEND */  INTO clcc_ww_buchung_23
(
   dwh_cr_load_id,
   ladedatum,
   konto_id_key,
   firma,
   bestelldatum,
   bestellung,
   auftragsnummer_key
)   
SELECT 
   dwh_cr_load_id,
   ladedatum,
   konto_id_key,
   firma,
   bestelldatum,
   bestellung,
   auftragsnummer_key
FROM sc_bestellzaehler;

COMMIT;


MERGE INTO clcc_ww_buchung_13 ga                                            
 USING (SELECT  
          konto_id_key,
          MAX(bestellung) AS bestellung
        FROM clcc_ww_buchung_23
        GROUP BY konto_id_key) ww
ON (ga.konto_id_key = ww.konto_id_key)
WHEN MATCHED THEN
 UPDATE SET ga.bestellanzahl_alt = ww.bestellung;
 
COMMIT;


PROMPT =========================================================================
PROMPT 10.3 Bestellzaehler addieren
PROMPT ========================================================================= 

UPDATE clcc_ww_buchung_13 SET rank = COALESCE(rank,0) + COALESCE(bestellanzahl_alt,0) 
WHERE bestellanzahl_alt IS NOT NULL;

COMMIT;

PROMPT =========================================================================
PROMPT 10.4 Referenztabelle um neue Aufträge ergänzen (Diese wird im Abschluss Script verwendet für den Insert in die Tabelle SC_BESTELLZAEHLER)
PROMPT ========================================================================= 
 
MERGE INTO clcc_ww_buchung_23 b                                             
 USING (SELECT 
          konto_id_key,
          bestelldatum, 
          firma, 
          rank AS bestellung, 
          auftragsnummer_key
        FROM clcc_ww_buchung_13) x
ON (x.auftragsnummer_key = b.auftragsnummer_key AND COALESCE(x.konto_id_key,'0') = COALESCE(b.konto_id_key,'0') AND x.firma = b.firma)
WHEN NOT MATCHED THEN
    INSERT 
(
    b.dwh_cr_load_id, 
    b.ladedatum, 
    b.konto_id_key, 
    b.firma, 
    b.bestelldatum, 
    b.bestellung, 
    b.auftragsnummer_key
 ) VALUES
 (
   &gbvid, 
   TRUNC(&termin), 
   x.konto_id_key,
   x.firma, 
   x.bestelldatum, 
   x.bestellung, 
   x.auftragsnummer_key
 );
        
COMMIT;



PROMPT =========================================================================
PROMPT 10.5 Aktualisierung Temporärtabelle, Bestellzaehler setzen
PROMPT ========================================================================= 
 
MERGE INTO clcc_ww_buchung_19 k                                             
USING (SELECT DISTINCT 
           auftragsnummer_key, 
           konto_id_key, 
           firma, 
           max(bestellung ) as bestellung
       FROM clcc_ww_buchung_23
       group by 
       auftragsnummer_key, 
           konto_id_key, 
           firma) ga
ON (ga.auftragsnummer_key = auftrnr_key AND ga.konto_id_key = k.konto_id_key AND ga.firma = k.firma)
WHEN MATCHED THEN
  UPDATE SET k.bestellzaehler = ga.bestellung
  WHERE bestellzaehler IS NULL;
  
COMMIT;


PROMPT =========================================================================
PROMPT 11. Bestelldatum_LV  setzen
PROMPT ========================================================================= 

TRUNCATE TABLE clcc_ww_buchung_15;                                          

INSERT /*+ APPEND */ INTO clcc_ww_buchung_15
(
   dwh_cr_load_id,
   org_rowid,
   bestelldatum
)
SELECT 
   &gbvid, 
   k.rowid AS kdums_rowid, 
   ww.bestelldatum
FROM  clcc_ww_buchung_23 ww, clcc_ww_buchung_19 k
  WHERE k.konto_id_key = ww.konto_id_key
  AND k.auftrnr_key = ww.auftragsnummer_key
  AND k.firma = ww.firma
  AND ww.bestellung = k.bestellzaehler
  AND k.auftrnr_key IS NOT NULL 
  AND (PKG_IM_VERTRIEBSGEBIET.F_IS_STAMMGESCHAEFT(k.firma) = 1)
  AND bestelldatum_lv IS NULL;
  
COMMIT;


EXEC PKG_STATS.GATHERTABLE (user, 'clcc_ww_buchung_15');

MERGE INTO clcc_ww_buchung_19 k                                             
    USING (SELECT DISTINCT * FROM clcc_ww_buchung_15) a
ON (a.org_rowid = k.rowid) 
   WHEN MATCHED THEN
 UPDATE SET k.bestelldatum_lv = a.bestelldatum;

COMMIT;


PROMPT =========================================================================
PROMPT 12. Ursprungskatalogart ermitteln
PROMPT ========================================================================= 

PROMPT =========================================================================
PROMPT 12.1 Bei "normalen" Buchungen Katalogart übernehmen
PROMPT ========================================================================= 

UPDATE clcc_ww_buchung_19                                                  
SET ursprungskatalogart = katalogart 
WHERE erslief = 1;

COMMIT;


PROMPT =========================================================================
PROMPT 12.2 Bei Ersatzlieferungsbuchungen Ursprungskatalogart ermitteln (aus Buchungsdaten bis einsch. Prozessdatum -1 aus cc_buchung
PROMPT ========================================================================= 

TRUNCATE TABLE clcc_ww_buchung_21;

-- ##.66 Bedingung auftrnr_key is not null geändert

-- Witt-Ausprägung
INSERT /*+ APPEND */ INTO clcc_ww_buchung_21
(
    dwh_cr_load_id, 
    buch_19_rowid, 
    konto_id_key, 
    auftrnr_key,
    auftrpos)
SELECT  
   &gbvid,
   rowid AS buch_19_rowid, 
   konto_id_key, 
   auftrnr_key,
   auftrpos
FROM clcc_ww_buchung_19 
WHERE erslief = 2    --ersatzlieferung = 1
AND auftrnr_key IS NOT NULL
AND ursprungskatalogart IS NULL;

COMMIT;

TRUNCATE TABLE clcc_ww_buchung_22;

INSERT /*+ APPEND */ INTO clcc_ww_buchung_22         
(
    dwh_cr_load_id, 
    auftrnr_key,
    auftrpos, 
    katalogart, 
    buch_19_rowid
)
SELECT DISTINCT 
    &gbvid, 
    b.auftrnr_key,
    b.auftrpos, 
   -- b.katart,
    substr(d.sg, -3) AS katart,
    c.buch_19_rowid
  FROM cc_buchung b, clcc_ww_buchung_21 c, cc_katart d
   WHERE c.konto_id_key = b.konto_id_key                                                         
   AND c.auftrnr_key = b.auftrnr_key
   AND c.auftrpos = b.auftrpos
    AND b.katart = d.wert
    AND d.dwh_valid_to = DATE '9999-12-31'  
    AND b.ansprmenge > 0
    AND b.buchdat >= TRUNC(&termin)-300;
  
COMMIT;


MERGE INTO clcc_ww_buchung_19 c
  USING (SELECT 
            buch_19_rowid, 
            MIN(katalogart) AS katalogart
         FROM clcc_ww_buchung_22 
          HAVING COUNT(DISTINCT katalogart) = 1
          GROUP BY buch_19_rowid) x    
 ON (x.buch_19_rowid = c.rowid)
WHEN MATCHED THEN
 UPDATE SET 
    c.ursprungskatalogart = x.katalogart
 WHERE erslief = 2;
    
COMMIT;


PROMPT =========================================================================
PROMPT 12.3 Bei Ersatzlieferungsbuchungen Ursprungskatalogart ermitteln (aus Buchungsdaten der Tagestabelle)
PROMPT ========================================================================= 

TRUNCATE TABLE clcc_ww_buchung_21;

INSERT /*+ APPEND */ INTO clcc_ww_buchung_21
(
    dwh_cr_load_id, 
    buch_19_rowid, 
    konto_id_key, 
    auftrnr_key,
    auftrpos
)
  SELECT 
   &gbvid,
   rowid AS buch_19_rowid, 
   konto_id_key, 
   auftrnr_key,
   auftrpos
  FROM clcc_ww_buchung_19 
  WHERE erslief = 2    --ersatzlieferung = 1
  AND auftrnr_key IS NOT NULL
  AND ursprungskatalogart IS NULL;
  
COMMIT;

TRUNCATE TABLE clcc_ww_buchung_22;
 
INSERT /*+ APPEND */ INTO clcc_ww_buchung_22
(
    dwh_cr_load_id, 
    auftrnr_key,
    auftrpos, 
    katalogart, 
    buch_19_rowid
)
SELECT DISTINCT 
   &gbvid, 
   b.auftrnr_key,
   b.auftrpos, 
   b.katalogart, 
   c.buch_19_rowid
    FROM clcc_ww_buchung_19 b, clcc_ww_buchung_21 c
    WHERE c.konto_id_key = b.konto_id_key
    AND c.auftrnr_key= b.auftrnr_key
    AND c.auftrpos = b.auftrpos
    AND b.anspr > 0;
    
COMMIT;


MERGE INTO clcc_ww_buchung_19 c
  USING (SELECT 
            buch_19_rowid, 
            MIN(katalogart) AS katalogart
         FROM clcc_ww_buchung_22 
         HAVING COUNT(DISTINCT katalogart) = 1
         GROUP BY buch_19_rowid) x    
 ON (x.buch_19_rowid = c.rowid)
WHEN MATCHED THEN
 UPDATE SET 
    c.ursprungskatalogart = x.katalogart
    WHERE erslief = 2    --ersatzlieferung = 1
    AND ursprungskatalogart IS NULL;

COMMIT;


PROMPT =========================================================================
PROMPT 13 Referenzauflösung der Vertriebsgebietsspalte (Otto-Marktplatz-VTG wird aus Firma uebernommen)
PROMPT ========================================================================= 

MERGE INTO clcc_ww_buchung_19 a                                             
USING 
 (SELECT s.vertrgebiet, c.wert
 FROM sc_ww_vertrgebiet_ver s, cc_vertrgebiet c
 WHERE s.dwh_valid_to = DATE '9999-12-31'
 AND s.dwh_id_cc_vertrgebiet = c.dwh_id) b
ON (a.ek_vtgebiet = b.vertrgebiet)
WHEN MATCHED THEN UPDATE
SET a.ek_vtgebiet_cc = CASE WHEN a.ek_vtgebiet = '!' THEN firma_cc ELSE b.wert END;

COMMIT;



PROMPT =========================================================================
PROMPT 14 Daten aus Auftragpool ermitteln (Fakturierte Zahlungsart)
PROMPT ========================================================================= 

--(ab Hostmig: Unterscheidung, sobald AuftragpoolID in Schnittstelle vorhanden ist, die Daten aus Auftragpool nutzen und Schnittstellendaten überschreiben.)
--TODO nach Hostmig, Ladung der Zahlungsart aus Zahlungskz (SST) abschalten

TRUNCATE TABLE clcc_ww_buchung_29;

INSERT /*+APPEND*/ INTO clcc_ww_buchung_29
( dwh_cr_load_id, 
  auftrag_auftragpoolid_key,
  dwh_id_sc_ww_zahlmethode,
  dwh_id_sc_ww_zahlwunsch,
  dwh_id_sc_ww_verskostfreigrund,
  dwh_id_sc_ww_liefauskunftakt,
  dwh_id_sc_ww_liefauskunftkom,
  dwh_id_sc_ww_auftrag_posstat
)
SELECT &gbvid, 
       ap.id_key AS auftrag_auftragpoolid_key,
       apv.dwh_id_sc_ww_zahlmethode,
       apv.dwh_id_sc_ww_zahlwunsch,
       apv.dwh_id_sc_ww_verskostfreigrund,
       apv.dwh_id_sc_ww_liefauskunftakt,
       apv.dwh_id_sc_ww_liefauskunftkom,
       apv.dwh_id_sc_ww_auftrag_posstat
FROM sc_ww_auftrag_auftpool ap 
JOIN sc_ww_auftrag_auftpool_ver apv ON (apv.dwh_id_head = ap.dwh_id AND &termin BETWEEN apv.dwh_valid_from AND apv.dwh_valid_to)
JOIN (SELECT DISTINCT auftrag_auftragpoolid_key FROM clcc_ww_buchung_19) b ON (ap.id_key = b.auftrag_auftragpoolid_key)
;

COMMIT;

EXEC PKG_STATS.GATHERTABLE(user,'clcc_ww_buchung_29');

MERGE INTO (SELECT auftrag_auftragpoolid_key,
                   zahlart,
                   zahlart_cc,
                   verskostfreigrund,
                   positionsstatus,
                   liefauskunftakt,
                   liefauskunftkom,
                   positionsstatus_cc,
                   liefauskunftakt_cc,
                   liefauskunftkom_cc,
                   valutafakt,
                   ratenfakt 
FROM clcc_ww_buchung_19) ga
 USING
     (
   SELECT a.auftrag_auftragpoolid_key,   
          a.dwh_id_sc_ww_zahlmethode,
          a.dwh_id_sc_ww_zahlwunsch,
          a.dwh_id_sc_ww_verskostfreigrund,
          a.dwh_id_sc_ww_liefauskunftakt,
          a.dwh_id_sc_ww_liefauskunftkom,
          a.dwh_id_sc_ww_auftrag_posstat,
          zv.zahlmethodekz,
          zv.wert AS zahlart_cc,
          v.wert AS verskostfreigrund,
          posstatv.kz AS positionsstatus,
          liefakt.liefauskunftakt,
          liefkom.liefauskunftkom,
          ccaufpos.wert AS positionsstatus_cc,
          liefakt.liefauskunftakt_cc AS liefauskunftakt_cc,
          liefkom.liefauskunftkom_cc AS liefauskunftkom_cc,
          sc_ww_zahlwunsch.ratenfakt AS ratenfakt_cc,
          sc_ww_zahlwunsch.valutafakt AS valutafakt_cc
    FROM   clcc_ww_buchung_29 a      
        JOIN (SELECT  zv.dwh_id_Head, zv.zahlmethodekz, cc.wert
              FROM    sc_ww_zahlmethode_ver zv
              JOIN cc_zahlart cc ON (zv.dwh_id_cc_zahlwunsch = cc.dwh_id  AND &termin BETWEEN cc.dwh_valid_from AND cc.dwh_valid_to)
              WHERE &termin BETWEEN zv.dwh_valid_from AND zv.dwh_valid_to
              )zv
        ON (zv.dwh_id_head = a.dwh_id_sc_ww_zahlmethode)
        JOIN sc_ww_auftrag_posstat_ver posstatv ON (posstatv.dwh_id_head = a.dwh_id_sc_ww_auftrag_posstat AND &termin BETWEEN posstatv.dwh_valid_from AND posstatv.dwh_valid_to)
        JOIN cc_auftrposstatus ccaufpos ON (posstatv.dwh_id_cc_auftrposstatus = ccaufpos.dwh_id AND &termin BETWEEN ccaufpos.dwh_valid_from AND ccaufpos.dwh_valid_to)
        LEFT OUTER JOIN (SELECT v3.dwh_id_head, cc.wert AS ratenfakt, cc1.wert AS valutafakt
                     FROM sc_ww_zahlwunsch_ver v3
                     JOIN cc_ratenfakt cc
                        ON (cc.dwh_id = v3.dwh_id_cc_ratenwunsch AND &termin BETWEEN cc.dwh_valid_from AND cc.dwh_valid_to)  
                     JOIN cc_valutafakt cc1
                        ON (cc1.dwh_id = v3.dwh_id_cc_valutafakt AND &termin BETWEEN cc1.dwh_valid_from AND cc1.dwh_valid_to)
                     WHERE &termin BETWEEN v3.dwh_valid_from AND v3.dwh_valid_to) sc_ww_zahlwunsch                   
    ON (a.dwh_id_sc_ww_zahlwunsch = sc_ww_zahlwunsch.dwh_id_head)      
      LEFT OUTER JOIN 
          (
           SELECT vv.dwh_id_head, vv.dwh_id_cc_verskostfreigrund, cv.wert
             FROM  sc_ww_verskostfreigrund_ver vv
           JOIN cc_verskostfreigrund cv ON (cv.dwh_id = vv.dwh_id_cc_verskostfreigrund AND &termin BETWEEN cv.dwh_valid_from AND cv.dwh_valid_to)
           WHERE &termin BETWEEN vv.dwh_valid_from AND vv.dwh_valid_to
        ) v
           ON (v.dwh_id_head = a.dwh_id_sc_ww_verskostfreigrund)     
   LEFT OUTER JOIN 
        (
         SELECT laav.dwh_id_head, laav.kbez AS liefauskunftakt, cla.wert AS liefauskunftakt_cc
           FROM sc_ww_liefauskunft_ver laav
           JOIN cc_liefauskunft cla ON (laav.dwh_id_cc_liefauskunft = cla.dwh_id AND &termin BETWEEN cla.dwh_valid_from AND cla.dwh_valid_to)
           WHERE &termin BETWEEN laav.dwh_valid_from AND laav.dwh_valid_to
         ) liefakt
   ON (liefakt.dwh_id_head = a.dwh_id_sc_ww_liefauskunftakt)
    LEFT OUTER JOIN 
        (
         SELECT lakv.dwh_id_head, lakv.kbez AS liefauskunftkom, clak.wert AS liefauskunftkom_cc
           FROM  sc_ww_liefauskunft_ver lakv
           JOIN cc_liefauskunft clak ON (lakv.dwh_id_cc_liefauskunft = clak.dwh_id AND &termin BETWEEN clak.dwh_valid_from AND clak.dwh_valid_to)
           WHERE &termin BETWEEN lakv.dwh_valid_from AND lakv.dwh_valid_to
         ) liefkom
   ON (liefkom.dwh_id_head = a.dwh_id_sc_ww_liefauskunftkom)
  ) x
  ON (x.auftrag_auftragpoolid_key = ga.auftrag_auftragpoolid_key)
  WHEN MATCHED THEN
   UPDATE SET ga.zahlart=x.zahlmethodekz,
              ga.zahlart_cc = x.zahlart_cc,
              ga.verskostfreigrund = x.verskostfreigrund,
              ga.positionsstatus = x.positionsstatus,
              ga.liefauskunftakt = x.liefauskunftakt,
              ga.liefauskunftkom = x.liefauskunftkom,
              ga.positionsstatus_cc = x.positionsstatus_cc,
              ga.liefauskunftakt_cc = x.liefauskunftakt_cc,
              ga.liefauskunftkom_cc = x.liefauskunftkom_cc,
              ga.valutafakt      = x.valutafakt_cc,
              ga.ratenfakt       = x.ratenfakt_cc;
              
COMMIT;


PROMPT Kennzahlen für Retourebuchungen aus Ansprachebuchung setzen
-- Einschränkung wg. Performance ab 1.5.2017, vorher ist Auftragpoolid nie gesetzt. Es wird jeweils auf den aktuellsten Datensatz zugegriffen, bei dem zumindest der Positionsstatus
-- gesetzt ist (wenn der gesetzt ist, ist der Rest auch gesetzt).
MERGE INTO clcc_ww_buchung_19 a                                             
USING 
    (SELECT k.auftrnr_key, k.auftrpos, 
    SUBSTR(MAX(TO_CHAR(k.buchdat,'yyyymmdd') || '_' || k.zahlart),10) AS zahlart,
    SUBSTR(MAX(TO_CHAR(k.buchdat,'yyyymmdd') || '_' || k.verskostfreigrund),10) AS verskostfreigrund,  
    SUBSTR(MAX(TO_CHAR(k.buchdat,'yyyymmdd') || '_' || k.auftrposstatus),10) AS auftrposstatus,  
    SUBSTR(MAX(TO_CHAR(k.buchdat,'yyyymmdd') || '_' || k.liefauskunftakt),10) AS liefauskunftakt,
    SUBSTR(MAX(TO_CHAR(k.buchdat,'yyyymmdd') || '_' || k.liefauskunftkom),10) AS liefauskunftkom,
    SUBSTR(MAX(TO_CHAR(k.buchdat,'yyyymmdd') || '_' || k.valutafakt),10) AS valutafakt,
    SUBSTR(MAX(TO_CHAR(k.buchdat,'yyyymmdd') || '_' || k.ratenfakt),10) AS ratenfakt
    FROM cc_buchung k
    WHERE auftrposstatus IS NOT NULL
    AND auftrag_auftragpoolid_key IS NOT NULL
    AND auftrnr_key IS NOT NULL
    AND k.buchdat >= TO_DATE ('01.05.2017','dd.mm.rrrr')
    GROUP BY k.auftrnr_key, k.auftrpos) b
ON (a.auftrnr_key = b.auftrnr_key AND a.auftrpos = b.auftrpos AND a.auftrag_auftragpoolid_key IS NULL)
WHEN MATCHED THEN UPDATE
SET a.zahlart_cc = b.zahlart,
a.verskostfreigrund = b.verskostfreigrund,
a.positionsstatus_cc = b.auftrposstatus,
a.liefauskunftakt_cc = b.liefauskunftakt,
a.liefauskunftkom_cc = b.liefauskunftkom,
a.valutafakt         = b.valutafakt,
a.ratenfakt          = b.ratenfakt;

COMMIT;



PROMPT =========================================================================
PROMPT 15 Setzen von Naligrund auf Basis von Positionsstatus
PROMPT ========================================================================= 

UPDATE clcc_ww_buchung_19
SET naligrundnr =
  CASE WHEN positionsstatus_cc IN (4,13,14) THEN 1
       WHEN positionsstatus_cc = 5 THEN 3
       WHEN positionsstatus_cc IN (11,7) THEN 4
       WHEN positionsstatus_cc IN (12,16,18) THEN 5
       WHEN positionsstatus_cc IN (1,2,3,25,26,27,28,29) THEN 6
       WHEN positionsstatus_cc =23 THEN 8
       WHEN positionsstatus_cc IN (15,20,33) THEN 9
   ELSE 0 END;
COMMIT;  


PROMPT =========================================================================
PROMPT 16 Einfuegen des Retourenerfassungsdatum aus RETBEWEG
PROMPT =========================================================================        

MERGE INTO clcc_ww_buchung_19 a                                             
USING (SELECT id_key, erfdatzeit 
            FROM sc_ww_retbeweg h JOIN sc_ww_retbeweg_ver v
            ON (h.dwh_id = v.dwh_id_head AND &termin BETWEEN v.dwh_valid_from AND v.dwh_valid_to)) retbeweg
ON (a.retbewegid_key = retbeweg.id_key)
WHEN MATCHED THEN UPDATE
SET a.reterfdat = retbeweg.erfdatzeit;

COMMIT;



PROMPT =========================================================================
PROMPT 17 Ermitteln des Aufragsstornokz (Auftragstornokz seit Hostmig auf Basis vom Positionsstatus setzen)
PROMPT ========================================================================= 

UPDATE clcc_ww_buchung_19 SET auftrstornokz_cc = CASE WHEN positionsstatus = 8 THEN 6 -- sg 5
                                   WHEN positionsstatus = 9 THEN 2 -- sg 1
                     ELSE auftrstornokz_cc END
WHERE lieferkz = 31;

COMMIT;


PROMPT =========================================================================
PROMPT 18 Steuerungskz und Sperrgrundkz seit Hostmig auf Basis vom Positionsstatus setzen
PROMPT ========================================================================= 

UPDATE clcc_ww_buchung_19 SET steuerungskz_cc = CASE WHEN positionsstatus IN (1,2,3,25,26,28,29) THEN (SELECT wert FROM cc_lvsteuerung WHERE sg = 62 AND dwh_valid_to = DATE '9999-12-31') ELSE 0 END, 
                              sperrgrundkz_cc = CASE WHEN positionsstatus IN (1,2,3,25,26,28,29) THEN (SELECT wert FROM cc_sperrgrund WHERE sg = 1 AND dwh_valid_to = DATE '9999-12-31') ELSE 0 END;

COMMIT; 


PROMPT =========================================================================
PROMPT 19 Valutakz basierend auf Zahlmethode_cc setzen
PROMPT ========================================================================= 

UPDATE clcc_ww_buchung_19 
   SET valutakz_cc = CASE WHEN zahlwunschkz_cc IN (SELECT wert FROM cc_ratenwunsch WHERE sg IN ('4', '5', '6')) THEN (SELECT wert FROM cc_valuta WHERE sg = 4 AND dwh_valid_to = DATE '9999-12-31') ELSE 0 END;
COMMIT;



PROMPT =========================================================================
PROMPT 20 ECC auf Basis der Mailnr ermitteln nur fuer Auftragsart Internet
PROMPT ========================================================================= 

MERGE INTO clcc_ww_buchung_19 a
USING (SELECT sg_ecc, 
              sg_vtsaison,
              wert 
       FROM cc_ecc_akt_v) b
ON (COALESCE(a.mailingnr,0) = b.sg_ecc AND f_date_to_vtsaison(a.bestelldatum) = b.sg_vtsaison AND a.auftragsart_cc = 4)
WHEN MATCHED THEN UPDATE
SET a.ecc = b.wert;

COMMIT;

-- Für ungültige ECCs (sollte ja nicht vorkommen) und Online-Bestellung: ECC setzen
MERGE INTO clcc_ww_buchung_19 a
USING (SELECT sg_vtsaison, 
              wert
       FROM cc_ecc_akt_v 
       WHERE sg_ecc = 0) b
ON (f_date_to_vtsaison(a.bestelldatum) = b.sg_vtsaison)
WHEN MATCHED THEN UPDATE
SET a.ecc = b.wert
WHERE a.ecc IS NULL
AND a.auftragsart_cc = 4;

COMMIT;

-- Für den Rest setzen
UPDATE clcc_ww_buchung_19
SET ecc = 0
WHERE ecc IS NULL;
COMMIT;


PROMPT =========================================================================
PROMPT 21 Bestellkanal ermitteln
PROMPT ========================================================================= 

-- Nicht-Internet-Bestellungen
MERGE INTO clcc_ww_buchung_19 a
USING (SELECT wert, auftrart FROM cc_bestellkanal 
      WHERE auftrart != 4
      AND dwh_valid_to = TO_DATE ('31.12.9999','dd.mm.rrrr')) b
ON (COALESCE(a.auftragsart_cc,0) = b.auftrart)
WHEN MATCHED THEN UPDATE
SET a.bestellkanal = b.wert;

COMMIT;


-- Internetbestellungen = Auftrart 4
MERGE INTO clcc_ww_buchung_19 a
USING (SELECT wert, ecc FROM cc_bestellkanal
      WHERE auftrart = 4
      AND dwh_valid_to = TO_DATE ('31.12.9999','dd.mm.rrrr')) b
ON (a.ecc = b.ecc AND a.auftragsart_cc = 4)
WHEN MATCHED THEN UPDATE
SET a.bestellkanal = b.wert;
COMMIT;

-- Otto Marktplatz: Fix 16

UPDATE clcc_ww_buchung_19
SET bestellkanal = 16,
ecc = -3
WHERE firma IN (28,200,201,202);

COMMIT;



PROMPT =========================================================================
PROMPT 22 Referenzauflösung Katalogart
PROMPT ========================================================================= 

MERGE INTO clcc_ww_buchung_19 a
USING (SELECT k.saison, k.kattyp, c.wert
            FROM sc_ww_katsta k JOIN sc_ww_katsta_ver v
            ON (k.dwh_id = v.dwh_id_head AND k.kattyp NOT IN ('§', '$','@') AND v.dwh_valid_to = TO_DATE ('31.12.9999','dd.mm.rrrr'))
            JOIN cc_katart c
            ON (v.dwh_id_cc_katart = c.dwh_id)) b
ON (a.umsatzsaison = b.saison AND a.katalogart = b.kattyp)
WHEN MATCHED THEN UPDATE
SET a.katart_cc = b.wert;  
COMMIT;



PROMPT =========================================================================
PROMPT 23 Daten aus AYC einmergen (About You Cloud)
PROMPT ========================================================================= 

MERGE INTO clcc_ww_buchung_19 z
USING 
    (SELECT a.papakey_key, b.aycorderid_key, e.wert AS appinfo, h.wert AS bestellmedium, ep.wert AS eccpaid, b.firma
    FROM sc_ex_aws_Bestelldaten a JOIN sc_ex_aws_Bestelldaten_ver b
    ON (a.dwh_id = b.dwh_id_head AND &termin BETWEEN b.dwh_valid_from AND b.dwh_valid_to)
    JOIN sc_ex_aws_isapp c 
    ON (b.dwh_id_sc_ex_aws_isapp = c.dwh_id)
    JOIN sc_ex_aws_isapp_ver d
    ON (c.dwh_id = d.dwh_id_head AND &termin BETWEEN d.dwh_valid_from AND d.dwh_valid_to)
    JOIN cc_appinfo e
    ON (d.dwh_id_cc_appinfo = e.dwh_id AND &termin BETWEEN e.dwh_valid_from AND e.dwh_valid_to)
    JOIN sc_ex_aws_viewport f
    ON (b.dwh_id_sc_ex_aws_viewport = f.dwh_id)
    JOIN sc_ex_aws_viewport_ver g
    ON (f.dwh_id = g.dwh_id_head AND &termin BETWEEN g.dwh_valid_from AND g.dwh_valid_to)
    JOIN cc_bestellmedium h
    ON (g.dwh_id_cc_bestellmedium = h.dwh_id AND &termin BETWEEN h.dwh_valid_from AND h.dwh_valid_to)
    JOIN sc_ex_aws_eccpaid ae
    ON (b.dwh_id_sc_ex_aws_eccpaid = ae.dwh_id)
    JOIN sc_ex_aws_eccpaid_ver av
    ON (av.dwh_id_head = ae.dwh_id AND &termin BETWEEN av.dwh_valid_from AND av.dwh_valid_to)
    JOIN cc_eccpaid ep
    ON (av.dwh_id_cc_ecc = ep.dwh_id AND &termin BETWEEN ep.dwh_valid_from AND ep.dwh_valid_to)) q
ON (z.auftrnr_key = q.papakey_key AND z.firma = q.firma)
WHEN MATCHED THEN UPDATE
SET z.aycorderid_key = q.aycorderid_key,
z.appinfo = q.appinfo,
z.bestellmedium = q.bestellmedium,
z.eccpaid = q.eccpaid;

COMMIT;


PROMPT 2.31 Daten aus AYC rückwirkend (letzte 14 Tage) in cc_buchung setzen
/*
MERGE --+ parallel enable_parallel_dml INTO cc_buchung z
USING 
    (SELECT a.papakey_key, b.aycorderid_key, e.wert AS appinfo, h.wert AS bestellmedium, ep.wert AS eccpaid, cf.wert AS firma, bp.wert AS bestellkanalpaid
    FROM sc_ex_aws_Bestelldaten a JOIN sc_ex_aws_Bestelldaten_ver b
    ON (a.dwh_id = b.dwh_id_head AND  b.dwh_valid_to = DATE '9999-12-31')
    JOIN sc_ex_aws_isapp c 
    ON (b.dwh_id_sc_ex_aws_isapp = c.dwh_id)
    JOIN sc_ex_aws_isapp_ver d
    ON (c.dwh_id = d.dwh_id_head AND d.dwh_valid_to = DATE '9999-12-31')
    JOIN cc_appinfo e
    ON (d.dwh_id_cc_appinfo = e.dwh_id AND e.dwh_valid_to = DATE '9999-12-31')
    JOIN sc_ex_aws_viewport f
    ON (b.dwh_id_sc_ex_aws_viewport = f.dwh_id)
    JOIN sc_ex_aws_viewport_ver g
    ON (f.dwh_id = g.dwh_id_head AND g.dwh_valid_to = DATE '9999-12-31')
    JOIN cc_bestellmedium h
    ON (g.dwh_id_cc_bestellmedium = h.dwh_id AND h.dwh_valid_to = DATE '9999-12-31')
    JOIN sc_ex_aws_eccpaid ae
    ON (b.dwh_id_sc_ex_aws_eccpaid = ae.dwh_id)
    JOIN sc_ex_aws_eccpaid_ver av
    ON (av.dwh_id_head = ae.dwh_id AND av.dwh_valid_to = DATE '9999-12-31')
    JOIN cc_eccpaid ep
    ON (av.dwh_id_cc_ecc = ep.dwh_id AND ep.dwh_valid_to = DATE '9999-12-31')
    JOIN sc_ww_kundenfirma_ver kf 
    ON (kf.dwh_id_head = b.dwh_id_sc_ww_kundenfirma AND kf.dwh_valid_to = DATE '9999-12-31')
    JOIN cc_firma cf
    ON (kf.dwh_id_cc_firma = cf.dwh_id)
    JOIN cc_bestellkanalpaid bp
    ON (ep.wert = bp.eccpaid AND bp.dwh_valid_to = DATE '9999-12-31' AND bp.auftrart = 4)) q
ON (z.auftrnr_key = q.papakey_key AND z.firma IN (SELECT wert FROM cc_firma WHERE sst = 1 AND sg < 100) AND z.buchdat >= &termin - 14 AND z.auftrart = 4 AND z.firma = q.firma)
WHEN MATCHED THEN UPDATE
SET z.aycorderid_key = q.aycorderid_key,
z.appinfo = q.appinfo,
z.bestellmedium = q.bestellmedium,
z.eccpaid = q.eccpaid,
z.bestellkanalpaid = q.bestellkanalpaid
WHERE (z.appinfo != q.appinfo
    OR z.bestellmedium != q.bestellmedium
    OR z.eccpaid != q.eccpaid);
    
COMMIT;
*/


TRUNCATE TABLE clcc_ww_buchung_06;

INSERT /*+ APPEND */ INTO clcc_ww_buchung_06
(dwh_cr_load_id,
auftrnr_key,
aycorderid_key,
appinfo,
bestellmedium,
eccpaid,
firma,
bestellkanalpaid
)
SELECT &gbvid AS dwh_cr_load_id,
    a.papakey_key AS auftrnr_key, 
    b.aycorderid_key, 
    e.wert AS appinfo, 
    h.wert AS bestellmedium, 
    ep.wert AS eccpaid, 
    cf.wert AS firma, 
    bp.wert AS bestellkanalpaid
    FROM sc_ex_aws_Bestelldaten a JOIN sc_ex_aws_Bestelldaten_ver b
    ON (a.dwh_id = b.dwh_id_head AND  b.dwh_valid_to = DATE '9999-12-31')
    JOIN sc_ex_aws_isapp c 
    ON (b.dwh_id_sc_ex_aws_isapp = c.dwh_id)
    JOIN sc_ex_aws_isapp_ver d
    ON (c.dwh_id = d.dwh_id_head AND d.dwh_valid_to = DATE '9999-12-31')
    JOIN cc_appinfo e
    ON (d.dwh_id_cc_appinfo = e.dwh_id AND e.dwh_valid_to = DATE '9999-12-31')
    JOIN sc_ex_aws_viewport f
    ON (b.dwh_id_sc_ex_aws_viewport = f.dwh_id)
    JOIN sc_ex_aws_viewport_ver g
    ON (f.dwh_id = g.dwh_id_head AND g.dwh_valid_to = DATE '9999-12-31')
    JOIN cc_bestellmedium h
    ON (g.dwh_id_cc_bestellmedium = h.dwh_id AND h.dwh_valid_to = DATE '9999-12-31')
    JOIN sc_ex_aws_eccpaid ae
    ON (b.dwh_id_sc_ex_aws_eccpaid = ae.dwh_id)
    JOIN sc_ex_aws_eccpaid_ver av
    ON (av.dwh_id_head = ae.dwh_id AND av.dwh_valid_to = DATE '9999-12-31')
    JOIN cc_eccpaid ep
    ON (av.dwh_id_cc_ecc = ep.dwh_id AND ep.dwh_valid_to = DATE '9999-12-31')
    JOIN sc_ww_kundenfirma_ver kf 
    ON (kf.dwh_id_head = b.dwh_id_sc_ww_kundenfirma AND kf.dwh_valid_to = DATE '9999-12-31')
    JOIN cc_firma_akt_v cf
    ON (kf.dwh_id_cc_firma = cf.dwh_id)
    JOIN cc_bestellkanalpaid bp
    ON (ep.wert = bp.eccpaid AND bp.dwh_valid_to = DATE '9999-12-31' AND bp.auftrart = 4)
    WHERE a.papakey_key IN
        (SELECT auftrnr_key FROM cc_buchung
         WHERE buchdat >= &termin - 14 AND auftrart = 4
         AND firma IN (SELECT wert FROM cc_firma_akt_v WHERE sst = 1 AND sg < 100));
    
COMMIT;
   


PROMPT =========================================================================
PROMPT 24 BestellkanalPaid ermitteln
PROMPT ========================================================================= 
 
-- ##.87
-- Nicht-Internet-Bestellungen
MERGE INTO clcc_ww_buchung_19 a
USING (SELECT wert, auftrart FROM cc_bestellkanalpaid 
      WHERE auftrart != 4
      AND dwh_valid_to = TO_DATE ('31.12.9999','dd.mm.rrrr')) b
ON (COALESCE(a.auftragsart_cc,0) = b.auftrart)
WHEN MATCHED THEN UPDATE
SET a.bestellkanalpaid = b.wert;

COMMIT;


-- Internetbestellungen = Auftrart 4
MERGE INTO clcc_ww_buchung_19 a
USING (SELECT wert, eccpaid FROM cc_bestellkanalpaid
      WHERE auftrart = 4
      AND dwh_valid_to = TO_DATE ('31.12.9999','dd.mm.rrrr')) b
ON (COALESCE(a.eccpaid,0) = b.eccpaid AND a.auftragsart_cc = 4)
WHEN MATCHED THEN UPDATE
SET a.bestellkanalpaid = b.wert;
COMMIT;

-- Otto Marktplatz...

UPDATE clcc_ww_buchung_19
SET eccpaid = -3,
bestellkanalpaid = 16
WHERE firma IN (28,200,201,202);

COMMIT;

PROMPT =========================================================================
PROMPT 25 Retouren, die von Stationaer-Buchungen kommen, aber auf Witt Inland gebucht werden, sollen wieder auf Stationaer gebucht werden.
PROMPT ========================================================================= 

MERGE INTO clcc_ww_buchung_19 a
USING 
(
 SELECT DISTINCT 
     a.art_id,
     b.artgr,     
     a.konto_id_key,     
     katart_cc, 
     umsatzsaison
 FROM
     ( 
       SELECT * FROM  clcc_ww_buchung_19 c WHERE firma = 1 AND ek_vtgebiet_cc = 1 AND ret > 0 AND auftrnr_key IS NULL
     ) a 
 JOIN
     ( 
       SELECT * FROM  cc_buchung WHERE firma = 1 AND vtg = 21 AND ansprmenge > 0
     ) b
         ON 
             a.art_id = b.art_id
             AND a.groesse = b.artgr
             AND a.konto_id_key = b.konto_id_key 
             AND b.buchdat < a.buchungsdatum 
             AND a.katart_cc = b.katart 
             AND a.umsatzsaison = b.umseksaison
) b
ON (
    a.art_id = b.art_id
   AND a.groesse = b.artgr     
   AND a.konto_id_key = b.konto_id_key 
   AND a.katart_cc = b.katart_cc 
   AND a.umsatzsaison = b.umsatzsaison)
WHEN MATCHED THEN UPDATE
 SET
    a.ek_vtgebiet_cc = 21,
    a.auftragsart_cc = 7
WHERE a.ek_vtgebiet_cc = 1;

COMMIT;


PROMPT =========================================================================
PROMPT 26 Auftrdat auf Buchdat-1 setzen, sofern dieses leer ist (nur Otto Marktplatz)
PROMPT ========================================================================= 

UPDATE clcc_ww_buchung_19
SET bestelldatum = buchungsdatum-1
WHERE bestelldatum IS NULL
AND firma_cc = 58;

COMMIT;


PROMPT =========================================================================
PROMPT 27 PayBackKennzeichen setzen
PROMPT ========================================================================= 

MERGE INTO  clcc_ww_buchung_19 a
USING   (   SELECT  auftridentnr_key,aboutyouorderid_key 
            FROM sc_ww_awsbestelldatenpayback_ver a
            WHERE &termin BETWEEN dwh_valid_from AND dwh_valid_to
            GROUP BY auftridentnr_key,aboutyouorderid_key
        ) u1 on (a.auftrnr_key = u1.auftridentnr_key)
WHEN MATCHED THEN UPDATE
SET     a.paybackauftrag = 2
WHERE   a.paybackauftrag = 1;

COMMIT;


PROMPT =========================================================================
PROMPT 27 Einladen in finale Cl-Tabelle
PROMPT ========================================================================= 

-- Nicht über Fremdschlüsselbeziehungen gesetzte Spalten (basierend auf SC- und CC-Referenzen)
-- werden auf -1 umgeschlüsselt, sollten sie NULL sein
-- Ausschluss Quelle Russland
TRUNCATE TABLE clcc_ww_buchung;

INSERT /*+ APPEND */ INTO clcc_ww_buchung
(
    dwh_cr_load_id,
    konto_id_key,
    firma,
    kontoart,
    vtg,
    buchdat,
    auftrnr_key,
    auftrpos,
    auftrdat,
    auftrdatlv,
    auftrart,
    auftrzaehler,
    art_id,
    artgr_id,
    artpreisvt_id,
    artgrpreisvt_id,
    promvthauptversion_id, 
    promgrvt_id,
    artnr,
    promnr,
    artgr,
    arteksaison,
    katart,
    umseksaison,
    ausstattung_dir_id,
    erslief,
    ersart,
    ersartnr,
    ersartgr,
    bestkatart,
    bestpromnr,
    meterware,
    sammelset,
    vfart,
    ansprmenge,
    ersverwmenge,
    nalimenge,
    nilimenge,
    telenilimenge,
    brabsmenge,
    ersbrabsmenge,
    numsmenge,
    retmenge,
    ansprstornomenge,
    nabstornomenge,
    umsstornomenge,
    ninamenge,
    impantmenge,
    ansprwert,
    ansprohnerabattwert,
    naliwert,
    niliwert,
    teleniliwert,
    brabswert,
    brabsohnerabattwert,
    brumsdiffwert,
    numswert,
    numsohnerabattwert,
    retwert,
    retohnerabattwert,
    retdiffwert,
    ansprstornowert,
    nabstornowert,
    umsstornowert,
    ninawert,
    rabattwert,
    numsvekwert,
    mwstsatz,
    mailnr,
    ecc,
    bestellkanal,
    aktionscodebuch,
    aktionsschlbuch,
    tgbuch,
    tgvtsaison,
    artstat,
    auftrstorno,
    liefinfo,
    liefwunsch,
    lvsteuerung,
    naligrund,
    ratenwunsch,
    sperrgrund,
    valutawunsch,
    zahlwunsch1,
    zahlwunsch1wert,
    zahlwunsch2,
    zahlwunsch2wert,
    zahlwunsch3,
    zahlwunsch3wert,
    zahlwunsch4,
    zahlwunsch4wert,
    zahlwunsch5,
    zahlwunsch5wert,
    zugestarttyp,
    auftrnrit_key,
    mappennr,
    liefstat,
    menge,
    vkp,
    retbewegid_key,
    prozessid,
    fakturaid_key,
    auftrag_auftragpoolid_key,
    imhostmig,
    auftragposid_key,
    zahlart,
    verskostfreigrund,
    auftrposstatus,
    liefauskunftakt,
    liefauskunftkom,
    reterfdat,
    lagerdiffwert,
    impantwert,
    beilagenr,
    lagerdiffmenge,
    valutafakt,
    ratenfakt,
    stationaerkz,
--##.70:neue Spalte crossborderversand eingebaut
    crossborderversand,
    aycorderid_key,
    appinfo,
    bestellmedium,
    ansprstornoohnerabattwert,
    impantohnerabattwert,
    lagerdiffohnerabattwert,
    nabstornoohnerabattwert,
    naliohnerabattwert,
    niliohnerabattwert,
    ninaohnerabattwert,
    teleniliohnerabattwert,
    umsstornoohnerabattwert,
    eccpaid,
    bestellkanalpaid,
    paybackauftrag
    )
SELECT 
bu.dwh_cr_load_id,
konto_id_key,
COALESCE (firma_cc, -1),
kontoart,
COALESCE (ek_vtgebiet_cc, -1),
buchungsdatum,
auftrnr_key,
auftrpos,
bestelldatum AS auftrdat,
bestelldatum_lv,
COALESCE(auftragsart_cc, 0) AS auftrart,  -- Datensätze die nicht in der Auftragpos gefunden werden (normalerweise nur Stationär, Auftrposidentnr = 0) liefern NULL-Werte --> wird zu unbekannt
bestellzaehler,
bu.art_id,
COALESCE(artgr.artgr_id,0) AS artgr_id, 
COALESCE(artpreisvt.artpreisvt_id,0) AS artpreisvt_id, 
COALESCE(artgrpreisvt.artgrpreisvt_id,0) AS artgrpreisvt_id,   
COALESCE(promhv.promvthauptversion_id,'#') AS promvthauptversion_id, 
COALESCE(promgrvt.promgrvt_id,'#') AS promgrvt_id, 
artikelnr,
promotionnr,
groesse,
saison,
COALESCE(katart_cc, 0) AS katart,
umsatzsaison,
ausstattung_id,
erslief,   --ersatzlieferung andgag: Referenzumstellung 21.11.2016 sollte eigentlich als CC_Auflösung gemacht werden
CASE WHEN bu.firma >= 100 THEN -3 ELSE COALESCE(ersatzwunschkz_cc,1) END AS ersart,  --COALESCE(ersatzwunschkz_cc,0), andgag: Referenzumstellung 21.11.2016
ersatzartikelnr,
ersatzgroesse,
ursprungskatalogart,
bestarprom,
meterwarekz_cc,
-2 AS sammelset, -- wird nicht mehr gepflegt!
COALESCE(vfkz, 1),  --vorher 0
anspr,
ersverw,
nali,
nili,
telenili,
brabs,
brabsers,
nums,
ret,
0 AS ansprstornomenge, -- gibts im SG nicht
nabstorno, 
umsstorno,
nina,
importanteil,
anspr_wert,
ansprohnerabattwert,
nali_wert,
nili_wert,
telenili_wert,
brabs_wert,
brabsohnerabattwert,
brumsdiff_betrag,
nums_wert,
numsohnerabattwert,
ret_wert,
retohnerabattwert,
retdiff_betrag,
0 AS ansprstornowert, -- gibts im SG nicht
nabstorno_wert,
umsstorno_wert,
nina_wert,
0 AS rabattwert, -- gibts im SG nicht
nums_wert_vek,
bu.mwst,
NULL AS mailingnr, -- ab FS 15 leer
ecc,
bestellkanal,
NULL AS aktcodebuch, -- gibts im SG nicht
NULL AS aktschlbuch, -- gibts im SG nicht
NULL AS tgbuch, -- gibts im SG nicht
-3 AS tgvtsaison, -- gibts im SG nicht
likz_cc AS artstat,
COALESCE(auftrstornokz_cc, 1),  --vorher 0
-2 AS liefinfo, -- gibts seit Hostmig nicht mehr
CASE WHEN bu.firma >= 100 THEN -3 ELSE COALESCE(liefwunschkz_auftrag_cc, 0) END AS liefwunsch,
CASE WHEN bu.firma >= 100 THEN -3 ELSE steuerungskz_cc END AS lvsteuerung, 
CASE WHEN bu.firma >= 100 THEN -3 ELSE COALESCE(naligrundnr, 0) END AS naligrund,
CASE WHEN bu.firma >= 100 THEN -3 ELSE COALESCE(zahlwunschkz_cc, 0) END AS ratenwunsch,
CASE WHEN bu.firma >= 100 THEN -3 ELSE sperrgrundkz_cc END AS sperrgrund,  
valutakz_cc,
CASE WHEN bu.firma >= 100 THEN -3 ELSE COALESCE(zahlmethodekz_cc, 0) END AS zahlwunsch1,
0 AS zahlwunsch1wert,
-3 AS zahlwunsch2,
0 AS zahlwunsch2wert,
-3 AS zahlwunsch3,
0 AS zahlwunsch3wert,
-3 AS zahlwunsch4,
0 AS zahlwunsch4wert,
-3 AS zahlwunsch5,
0 AS zahlwunsch5wert,
CASE WHEN bu.firma >= 100 THEN -3 ELSE COALESCE(zugesteuertkz_cc,0) END AS zugestarttyp,  -- Datensätze die nicht in der Auftragpos gefunden werden (normalerweise nur Stationär, Auftrposidentnr = 0) liefern NULL-Werte --> wird zu unbekannt
auftrnrit_key,
mappennr,
lieferkz,
0 AS menge, -- wird im SG nicht gefüllt
verkpreis,
retbewegid_key,
prozessid,
fakturaid_key,
auftrag_auftragpoolid_key,
imhostmig,
auftragposid_key,
CASE WHEN bu.firma >= 100 THEN -3 ELSE COALESCE(zahlart_cc, 0) END AS zahlart_cc,
CASE WHEN bu.firma >= 100 THEN -3 ELSE COALESCE(verskostfreigrund, 0) END AS verskostfreigrund,
CASE WHEN bu.firma >= 100 THEN -3 ELSE COALESCE(positionsstatus_cc, 0) END AS positionsstatus_cc,
CASE WHEN bu.firma >= 100 THEN -3 ELSE COALESCE(liefauskunftakt_cc, 0) END AS liefauskunftakt_cc,
CASE WHEN bu.firma >= 100 THEN -3 ELSE COALESCE(liefauskunftkom_cc, 0) END AS liefauskunftkom_cc,
reterfdat,
lagerdiffwert,
impantwert,
beilagenr,
lagerdiffmenge,
CASE WHEN bu.firma >= 100 THEN -3 ELSE COALESCE(valutafakt, 0) END AS valutafakt,
CASE WHEN bu.firma >= 100 THEN -3 ELSE COALESCE(ratenfakt, 0) END AS ratenfakt,
COALESCE(stationaerkz_cc, -1),
--##.70:neue Spalte crossborderversand eingebaut
-3 AS crossborderversand,
aycorderid_key,
CASE WHEN bu.firma >= 100 THEN -3 ELSE COALESCE (appinfo, 0) END AS appinfo,
CASE WHEN bu.firma >= 100 THEN -3 ELSE COALESCE (bestellmedium,0) END AS bestellmedium,
0 AS ansprstornoohnerabattwert,
impantohnerabattwert,
lagerdiffohnerabattwert,
nabstornoohnerabattwert,
naliohnerabattwert,
niliohnerabattwert,
ninaohnerabattwert,
teleniliohnerabattwert,
umsstornoohnerabattwert,
CASE WHEN bu.firma >= 100 THEN -3 ELSE COALESCE (eccpaid, 0) END AS eccpaid,
CASE WHEN bu.firma >= 100 THEN -3 ELSE bestellkanalpaid END AS bestellkanalpaid,
paybackauftrag
FROM clcc_ww_buchung_19 bu
JOIN cc_firma_akt_v firma ON (firma.wert = bu.firma_cc)
LEFT OUTER JOIN cc_artgr_akt_v artgr on (artgr.art_id = bu.art_id and to_char(bu.groesse) = to_char(artgr.artgr))
LEFT OUTER JOIN cc_artpreisvt_akt_v artpreisvt on (artpreisvt.art_id = bu.art_id and artpreisvt.preisvtg = firma.preisvtg)
LEFT OUTER JOIN cc_artgrpreisvt_akt_v artgrpreisvt on (artpreisvt.art_id = bu.art_id and artgrpreisvt.artgr_id = artgr.artgr_id and artpreisvt.artpreisvt_id = artgrpreisvt.artpreisvt_id)
LEFT OUTER JOIN cc_promvthauptversion_akt_v promhv on (promhv.art_id = bu.art_id and promhv.firma = bu.firma and lpad(bu.promotionnr,3,0) = to_char(promhv.promnr))
LEFT OUTER JOIN cc_promgrvt_akt_v promgrvt on (promgrvt.art_id = bu.art_id and promgrvt.firma = bu.firma and lpad(bu.promotionnr,3,0) = to_char(promgrvt.promnr) and to_char(promgrvt.artgr) = to_char(artgr.artgr))
WHERE bu.firma != 149
--##.72
AND firma_cc != 33;

COMMIT;


PROMPT ===========================================
PROMPT Data loss checking
PROMPT ===========================================

DECLARE
    nrows_cc_1 PLS_INTEGER;
    nrows_cc_2 PLS_INTEGER;
BEGIN
    SELECT COUNT(*)
    INTO    nrows_cc_1
    FROM    clcc_ww_buchung_19
    WHERE firma_cc != 33
    AND firma != 149;
    
    SELECT COUNT(*)
    INTO    nrows_cc_2
    FROM    clcc_ww_buchung;
    
    IF nrows_cc_2 != nrows_cc_1 THEN
        RAISE_APPLICATION_ERROR(-20029,'Data loss when loading CC!');
    END IF;
END;
/