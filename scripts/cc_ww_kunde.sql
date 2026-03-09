/*******************************************************************************
  
  Job:                    cc_ww_kunde
  Beschreibung:           Job laedt Kundedaten in die cc_kunde 
                      
  Erstellt am:            01.07.2019
  Erstellt von:           Stefan Ernstberger 
  Ansprechpartner:        Stefan Ernstberger, Andrea Gagulic
  Ansprechpartner-IT:     Anton Roithmeier, Thomas Hoesl
  
  verwendete Tabellen:  sc_ww_kunde/_ver 
                        sc_ww_person/_ver
                        sc_ww_adresse/_ver
                        sc_ww_adr/_ver
                        sc_ww_kdkto/_ver
                        sc_ww_kundenfirma/_ver
                        sc_ww_adrhdl/_ver
                        sc_ww_persanrede/_ver
                        sc_ww_land/_ver
                        sc_ww_kdart/_ver
                        sc_ww_verswunsch/_ver
                        sc_ww_telemk/_ver
                        sc_ww_werbmit/_ver
                        sc_ww_mahneb/_ver
                        sc_ww_mahnstrang/_ver
                        sc_ww_bonikl/_ver
                        sc_ww_ersatzart/_ver
                        sc_ww_nachbarschabg/_ver
                        sc_ww_nladressherkunft/_ver
                        sc_ww_nltyp/_ver
                        sc_ww_emailverweigert/_ver
                        sc_ww_rufnummerverweigert/_ver
                        sc_ww_servicemailaktiv/_ver
                        sc_ww_kdloginaktiv/_ver
                        sc_ww_kontosperre/_ver
                        sc_ww_fg/_ver
                        sc_ww_wunschfilialwerb/_ver
                        sc_ww_adrausvorteilsnr/_ver
                        sc_ww_telefonprivatvorhanden/_ver
                        sc_ww_gebdatstatus/_ver
                        sc_im_tgv_gewweg_ver
                        sc_ex_aws_nlabostatusdaten
                        cc_buchung
                        cc_kunde_xxx   
                        cc_adrhdl
                        cc_altjung 
                        cc_altwabherkunft 
                        cc_anlvtsaison 
                        cc_anlvtsaisonrea
                        cc_anlauftrart
                        cc_anlaktionscode
                        cc_anlaktionscoderea
                        cc_anrede
                        cc_auftrart
                        cc_art
                        cc_bonikl
                        cc_emailherkunft
                        cc_emailverweigert
                        cc_ersartwunsch 
                        cc_erslief
                        cc_fg
                        cc_filialwerbungwunsch
                        sc_ww_vertrgebiet_ver
                        cc_firma_waepumig_v  ( Hier ist der SG Wert 18 - Wird nach WP eigene Firma gebraucht - Uebergangsloesung !) 
                        cc_gebdatverweigert
                        cc_kantoneschweiz
                        cc_katart
                        cc_kdloginaktiv
                        cc_kontosperre 
                        cc_kontoart 
                        cc_kdart 
                        cc_land
                        cc_mahnebene
                        cc_mahnstrang 
                        cc_marktkz
                        cc_nachbarabg 
                        cc_nixi 
                        cc_nkcodierung
                        cc_nlabostatus
                        cc_nltyp
                        cc_nlwunsch
                        cc_onlinetest
                        cc_ostwest
                        cc_region
                        cc_rufnummerverweigert
                        cc_servicemailaktiv
                        cc_sheego_ausschlusse_modalwert
                        cc_sheego_dob_groessen_ref
                        cc_telemarkwunsch
                        cc_telefonvorhanden
                        cc_ueberschneider
                        cc_vfart
                        cc_vorteilsnrangabe
                        cc_vtinfogrp
                        cc_werbemittelsperre
                        cc_zustelldienst 
                        cc_plzref
                        sc_im_tgv_nk0_ver
                        sc_ww_auftragkopf/_ver
                        sc_ww_bestweg
                        dm_f_alinav1
                          
  Endtabellen:          cc_kunde_&vtsaison                                                                                                                                                                                                   
  Fehler-Doku:            -
  Ladestrecke:            -
  ********************************************************************************
  
  geaendert am / von:      28.07.2016 / steern  
  Aenderungen:             ##.1: Kundenart 29 soll raus aus der Definition der Kundengruppe 925.
  ********************************************************************************
  geaendert am / von:      22.08.2016 steern  
  Aenderungen:             ##.2: Valuta und Auszahlung aus CC_KUNDE-Ladung entfernt, da unzuverlässige Werte
  ********************************************************************************
  geaendert am / von:      23.08.2016 steern  
  Aenderungen:             ##3: Mahnlaufinformationen werden nicht mehr mit alten Werten überschrieben (Bugfix)  
  ********************************************************************************
  geaendert am / von:      24.10.2016 steern  
  Aenderungen:             ##4: Waeschepur-Trennung nicht auf Basis der Vortagesstamm --> Beim Nachladen ein Problem, da mittlerweile der Kunde ja schon 
                                vorhanden ist
  ********************************************************************************
  geaendert am / von:      27.10.2016 steern  
  Aenderungen:             ##5: Wäschepur-Umcodierung greift nun auf die Historientabelle zu : sam_wp_mb_hist
  ********************************************************************************
  geaendert am / von:      10.11.2016 steern  
  Aenderungen:             ##6: Auftragkopf-Tabellen nun auf dem UDWH, kein Datenbanklink mehr nötig
  ********************************************************************************
  geaendert am / von:      21.11.2016 steern  
  Aenderungen:             ##7: NETTOBRUTTO und VIERLINIEN als neue Spalten eingefuegt. Logik von VS
  ********************************************************************************
  geaendert am / von:      30.11.2016 steern  
  Aenderungen:             ##8: Join mit Auftragkopf bei Anlweg auf Aufträge - 30 Tage beschränkt (Temp-TS-Problem)
  ********************************************************************************
  geaendert am / von:      07.12.2016 steern  
  Aenderungen:             ##9: neue TGV-Tabellen (SC_IM_TGV_*) integriert
  ********************************************************************************
  geaendert am / von:      22.02.2017 steern  
  Aenderungen:             ##10: dbfakturakz eingebaut
  ********************************************************************************
  geaendert am / von:      02.06.2017 steern  
  Aenderungen:             CC_WW_KUNDE_IT-Job-Logik hier integriert, Projekt "Entfernung Unterbautabellen" 
                           --> CC_WW_KUNDE_IT und CC_WW_STAMM_IM fallen weg 
  ********************************************************************************
  geaendert am / von:      07.06.2017 steern  
  Aenderungen:             NIXI wenn null, dann auf 1 --> kein NIXI
  ********************************************************************************
  geaendert am / von:      03.07.2017 steern  
  Aenderungen:             CC_WW_STAMM_IM wird nicht mehr gefuellt --> unnötig
  ********************************************************************************
  geaendert am / von:      05.07.2017 steern  
  Aenderungen:             Bug bei Nettobrutto. 1 anstatt 2 und 0 anstatt 1 
                           berechnete Werte wie NUMS werden auf 0 gesetzt wenn "NULL
  ********************************************************************************
  geaendert am / von:      13.07.2017 steern  
  Aenderungen:             Zweitversand Umcodierung wieder aktiv geschalten. Startet
                           ab 16.07.2017
  ********************************************************************************
  geaendert am / von:      26.07.2017 andgag  
  Aenderungen:             Formlosen-Umkodierung Wäschepur. IWL wird auf 98 gesetzt
                           lt. Mail von Anna Lena-Rix.        
  ********************************************************************************
  geaendert am / von:      04.08.2017 steern  
  Aenderungen:             Nettobrutto soll nicht mehr mit Klartext der Kundenart gebildet werden,
                           sondern ueber die neue Kundenartreferenz
  
                           Kundenart (5,35) --> Matchcode abgelehnte
                           Kundenart (4,36) --> Scoring abgelehnte
  ********************************************************************************
  geaendert am / von:      21.08.2017 andgag
  Aenderungen:             sc_ww_hermesdepot: depotnr heisst jetzt notdepotnr                           
  ********************************************************************************
  geaendert am / von:      24.08.2017 andgag
  Aenderungen:             Tägliche Sonderumkodierung für CL B-KAT eingebaut.         
  ********************************************************************************
  geaendert am / von:      29.08.2017 steern
  Aenderungen:             Wenn rufnummerverweigertkz = 1, dann wird nicht mehr 
                           auf NULL gestzt, da dies mit der eigentlichen Verweigerung
                           nichts zu tun hat (nur fuer DIADEM gebraucht)
  ********************************************************************************
  geaendert am / von:      05.09.2017 steern
  Aenderungen:             - Mediaumcodierung waeschpur via Guliver implementiert
                           - Bugfix Mailingnummer Umcodierung fuer waeschepur (Join mit FIRMA anstatt FIRMA_IM)
  ********************************************************************************
  geaendert am / von:      14.09.2017 andgag
  Aenderungen:             Sonderumkodierung CL und Ambria (Hostmig-Mailband-Problem) wurde auskommentiert  
  ********************************************************************************
  geaendert am / von:      14.09.2017 andgag
  Aenderungen:             Umcodierung waeschepur Neukunden anhand Mediaflyer 
                           (WKZ/IWL-Vergabe mittels Guliver-Code): Katalogart-
                           Join wurde entfernt.
  ********************************************************************************
  geaendert am / von:      15.09.2017 steern
  Aenderungen:             - Mediaumcodierung hat nicht gegriffen, da seit Hostmig Gutscheindaten
                             in der KDUMS gefehlt haben --> Umbau auf Auftragpos
  ********************************************************************************
  geaendert am / von:      03.11.2017 andgag
  Aenderungen:             - Auskommentierten Mahnlauf-Update wieder aktiviert.
                             Schnittstelle angeblich repariert durch IT.                             
  ********************************************************************************
  geaendert am / von:      29.12.2017 steern
  Aenderungen:             - neue Kontosperre eingebaut (ersetzt die alte Kontosperre 1:1)
                             --> Uebergangsweise cc_kontosperre_neu
                           - neue altjung_akt-Definition. nun auch Default-Einteilung altjung_folge
                           - Anpassung Mehrlinien an neue Kontosperre
                           - Anpassung Nettobrutto
                           - CC-Joins erweitert mit Zeitbezug
  ******************************************************************************** 
  geaendert am / von:      17.01.2018 steern 
                           Bei der Anzahl der Bestellungen werden zuszätzliche Ansprachen eines Auftrages bei Lagerdifferenzpositionen rausgerechnet (Auftragsposidentnr, welche mit 400 endet)
                            --> wird nicht als neue Ansprache gezaehlt, Anazahl Bestellungen somit richtiger
  ******************************************************************************** 
  geaendert am / von:      20.01.2018 joeabd 
                           Fix 1.3 Ermittlung Anzahl Bestellungen              
  ******************************************************************************** 
  geaendert am / von:      31.01.2018 steern 
                           Neue Struktur ! Kunde vom 30.01. rebuilded und ab da neues Ladungsskript       
  ******************************************************************************** 
  geaendert am / von:      27.02.2018 steern 
                           it_katerstversand wird nicht mehr zur HKEKZ-Bildung hergenommen, da Feld laut IT nicht mehr korrekt gefuellt wird         
 ******************************************************************************** 
  geaendert am / von:      08.03.2018 steern 
                           Neukundenumcodierung fuer waeschepur: Bug behoben --> wpkz 1 und 3 wurde selektiert. 2 und 3 wäre aber korrekt 
 ******************************************************************************** 
  geaendert am / von:      09.03.2018 steern 
                           - Anlweg/Anlauftrart soll auf Basis vom Anlagedatum gebildet werden, nicht anldatum (sonst bekommt kontoart 5 nix) 
                           - Anlweg/Anlauftrart fuer waeschepur hat ein "trunc" bei Anldatum gefehlt --> wurde nichts gesetzt
 ******************************************************************************** 
  geaendert am / von:      23.03.2018 steern 
                           anlvtsaisonrea-Referenzaufloesung war fehlerhaft --> Join war auf SG und nicht auf WERT --> Bugfix
 ******************************************************************************** 
  geaendert am / von:      05.04.2018 steern 
                           - Vtinfogruppe, Anlsaison werden auf 0 kodiert, nicht mehr -3 bei Kunde ohne Buchung
                           - Bugfix bei der Kontart 2 "Ausnullung" der Werte --> nvl(vtinfogruppe, '0')                           
 ******************************************************************************** 
  geaendert am / von:      05.06.2018 steern 
                           letztauftrdat soll nur gefuellt werden bei Kontoart = 1   
                           
 ******************************************************************************** 
  geaendert am / von:      06.06.2018 steern 
                           NLANLDATERST wird nur gesetzt wenn NLABOSTATUS = 4 und nicht mehr wie vorher auch 0 und 13, Anforderung EC vom 29.05.2018
 ******************************************************************************** 
  geaendert am / von:      07.06.2018 steern 
                           CLCC_WW_KUNDE_20 eingefuehrt, weil Laufzeit unterirdisch wurde (zwischengeschaltene Temp-Tabelle)
 ******************************************************************************** 
  geaendert am / von:      26.06.2018 steern 
                           ALTJUNG_AKT und ONLINE_TEST-Ermittlung eingebaut
 ********************************************************************************                           
  geaendert am / von:      25.07.2018 joeabd 
                           DB-Link cc_buchung entfernt       
 ********************************************************************************                           
  geaendert am / von:      26.07.2018 joeabd 
                           DB-Link sc_konto_id entfernt             
 ********************************************************************************                           
  geaendert am / von:      30.07.2018 steern 
                           Zum Saisonwechsel muss Skriptlet einkommentiert werden, so dass bei der ersten Ladung auch die Neukunden vom Saisonwechsel
                           tag mit aufgenommen werden !
 ********************************************************************************                           
  geaendert am / von:      06.08.2018 steern 
                           Zweitversand Witt Deutschland Umcodierung aktiv
 ********************************************************************************                           
  geaendert am / von:      29.08.2018 steern 
                           Auch Vtinfogruppe 9999 sollte immer Kontoart = 5 sein und entsprechnd alle Felder leer                           
 ********************************************************************************                           
  geaendert am / von:      04.09.2018 steern 
                           Bugfix bei ONLINE_TEST fuer waeschepur    
 ********************************************************************************                           
  geaendert am / von:      05.09.2018 steern 
                           - Bugfix bei Mailingnummer. Mittlerweile CC_BUCHUNG Spalte ECC relevant, welche eine Referenz ist 
                           - Umbau der Joins über CC_FIRMA und nicht mehr das ganze SC-Gejoine (SC_VERTRGEBIET usw)
 ********************************************************************************                           
  geaendert am / von:      07.09.2018 steern 
                           Alle Kontoart 2 bekommen jetzt die Default-0-Werte. Jetzt also auch Sondervtinfos. 
 ********************************************************************************                           
  geaendert am / von:      10.09.2018 steern 
                           Mailnr bei Wäschepur wird auf 0 gesetzt, wenn nichts gefunden wird. Analog alter Stammevorgehensweise. 
                           Es gibt naemlich keine Mailnr = null (Test in der WW_KDUMS). CC_ECC sieht Fall nicht vor, dass Mailnr 0 sein kann. 
 ********************************************************************************                           
  geaendert am / von:      12.09.2018 steern 
                           NLANLDATUM-Bug. Es wurde auch ein Datum gestetzt wenn keine Email vorhanden war. Sinnlos --> Email wird jetzt mit geprueft
 ********************************************************************************                           
  geaendert am / von:      13.09.2018 steern 
                           Waeschepur-Bug bei ONLINE_TEST
 ********************************************************************************                           
  geaendert am / von:      19.09.2018 steern 
                           Kunden, welche durch WW_ALINA ein Update bekommen, werden nun auch bereucksichtigt. Relevant fuer ALTJUNG-Einteilung.                          
 ********************************************************************************                           
  geaendert am / von:      24.09.2018 steern 
                           Externe Schnittstelleh hat Updates der "alten" Sondervtinfos gemacht --> abgestellt, Sondervtinfos werden 
                           von neuem Skript selber eingeteilt ,da sie nicht mehr den alten Werten entsprechen. 
 ********************************************************************************                           
  geaendert am / von:      25.09.2018 steern 
                           Anrede-Fix --> Referenzaufloesung hat immer ins Leere gefuehrt, da Referenzspalte SG nicht gepflegt war. Join auch angepasst.
 ********************************************************************************                           
  geaendert am / von:      10.10.2018 andgag
                           Wegen Umbau der CC_BUCHUNG Verwendung der CC_KATART aktiviert.
 ********************************************************************************                           
  geaendert am / von:      13.11.2018 steern
                           Groessere Strukturelle Aenderungen:
                             - DBFAKTURA, AKR, GMR, KATERSTVERSAND, KATNACHVERSAND raus
                             - Neue Felder hinzu, u.A. Gebdmonat, Verweiskonto_ID, FG, Filialwerbwunsch
                             - Mahnlauf-Insert raus
 ********************************************************************************                           
  geaendert am / von:      04.12.2018 steern
                           ALTJUNG_FOLGE bekommt jetzt auch eine tägliche Ermittlung
 ********************************************************************************                                                    
  geaendert am / von:      17.12.2018 steern
                           ALTJUNG-Einteilung jetzt fuer alle VTGs (Witt D / CH / AU) 
 ********************************************************************************                                                    
  geaendert am / von:      28.12.2018 steern
                           waeschepur Mediaflyer jetzt über Artikelnr Promotionnr
 ********************************************************************************                                                    
  geaendert am / von:      14.01.2019 steern
                           Umstellung der Konto-ID-Vergabe auf die DWH_KONTO_ID_REF                                  
 ********************************************************************************                                                    
  geaendert am / von:      15.01.2019 steern
                           Mehrlinien-Defintion fuer Alpenlaender angepasst        
 ********************************************************************************
  geaendert am / von:      06.02.2019 steern
                           Wenn Kunden mit ONLINE_TEST 102 Altsenioren (1,2) werden, 
                           sollen sie sofort in 15 wandern             
 ********************************************************************************
  geaendert am / von:      17.05.2019 steern
                           Uebergangsweise werden auch Kunden aus der STAMMTAGABGL mit eingeladeden weil ie Umzieher sonst nicht im Pool vorhanden sind und
                           fuer diese sich z.b. der Wahlbezirk nicht aendert (auf der UDWH schon...)
                           UDWH-CC_KUNDE bekommt ja auch Aenderungsdatensaetze aus den Adresstabellen mit, die CC_KUNDE auf der UDWH1 ja nicht mehr.
 ********************************************************************************                                                    
  geaendert am / von:      13.06.2019 steern
                           Altjung-Einteilung jetzt auch fuer NK0er  
 ********************************************************************************                                                    
  geaendert am / von:      27.06.2019 steern
                           HKEKZ_FOLGE jetzt mit Ranking, da Kunde zwei Kataloge pro Bestellung erhalten kann... MIN gewinnt   
 ********************************************************************************
  geaendert am / von:      01.07.2019 steern
                           - Clearingstellen-Kunde Go Live  
                           - WKZ/IWL jetzt ueber CC_NKCODIERUNG
 ********************************************************************************
  geaendert am / von:      01.07.2019 steern
                           Kundenstammdaten werden jetzt anhand Termin und nicht DAtum geladen, da bei SW sonst 
                           eine große Lademasse auftauchen könnte
 ********************************************************************************
  geaendert am / von:      07.08.2019 andgag
                           cc_nkcodierung ist jetzt auf udwh1. Schema geändert.
 ********************************************************************************
  geaendert am / von:      12.08.2019 andgag
                           cc_nkcodierung: wkz/iwl heisst jetzt anlweg1/anlweg2                                                                                                                                                                
 ********************************************************************************
  geaendert am / von:      30.10.2019 steern
                           Gewinnungswegcodierung für WP wurde eingeschränkt auf WKZ 10-99.
                           --> weg rationalisiert, WP darf auch eine WKZ von 9 haben bspw
 ********************************************************************************
  geaendert am / von:      23.12.2019 steern
                           - Anpassung ONLINE_TEST und MEHRLINIEN fuer FS20
                           - CLCC_WW_KUNDE anstatt CLCC_WW_KUNDE_&vtsaison                           
 ********************************************************************************
  geaendert am / von:      02.01.2020 steern
                           - Ausschluss CRS-HEINE (60,61,62,63)   
  ********************************************************************************
  geaendert am / von:      13.02.2020 steern
                           Referenzen richtig benannt: CC_ANLAKTIONSCODE, CC_(IM)ALTWABHERKUNFT, CC_ADRESSHDL
 ********************************************************************************
  geaendert am / von:      07.04.2020 steern
                           STAMM_TAGABGLEICH entfernt
                           - INSERT in die CLEANSE-Tabelle
                           - Update zu NIXI (gibt einen wöchentlichen Abgleich)
                           - Update zu WAHLBEZIRK und GEMEINDEKZ (bekommen von OTTO keine Datei mehr)
 ********************************************************************************
  geaendert am / von:      04.05.2020 steern
                           Wäschepur ab LV 05.05. eigene Kundenfirma mit 18.
                           --> Alle Extralocken für Wäpu inklusive Duplizieren der DS rausa
                           --> Einbau extriger CC_FIRMA-Referenz um im Skript CASES zu vermeiden
                               CC_FIRMA_WAEPUMIG_V hat bei Wert 18 auch SG 18 und nicht 68 ! 
                               Übergangsloesung solange Vermischung alte Welt und neue Welt existiert, 
                               da in alter Welt die Firma 68 bleibt. 
                               Wenn alte Welt ausstirbt, kann CC_FIRMA angepasst werden. 
 ********************************************************************************
  geaendert am / von:      15.07.2020 steern
                           Updates aus ext. SST wandern jetzt an Punkt 11, weil es sich sonst mit LBBW-Berechnung
                           in die Quere gekommen ist
 ********************************************************************************
  geaendert am / von:      13.01.2021 steern
                           Saisonwechselstelle wurde ausgetauscht, geht jetzt dynamisch. 
 ********************************************************************************
  geaendert am / von:      03.02.2021 joeabd
                           Spalte "Sprache" hinzugefügt (Default-Wert)      
  ********************************************************************************
  geaendert am / von:      31.03.2021 steern
                           join mit konto_id_key (cc_nkcodierung)      
 ********************************************************************************
  geaendert am / von:      23.04.2021 steern
                           Neue Spalten: 
                           - Ueberschneider
                           - Telefonvorhanden
                           - Gebdatverweigert
                           Neue Referenz:
                           - Region
  ********************************************************************************
  geaendert am / von:      28.04.2021 steern
                           altjung_folge wird jetzt auch fuer NK1 neu durchgerechnet
  ********************************************************************************
  geaendert am / von:      29.04.2021 andgag
                           Bei Zugriff sc_ww_auftragkopf/-ver kdnr und id weglassen    
  ********************************************************************************
  geaendert am / von:      28.06.2021 steern
                           Witt NL jetzt mit Altjung-Einteilung   
  ********************************************************************************
  geaendert am / von:      30.06.2021 steern
                           Anpassungen ONLINE_TEST + MEHRLINIEN 
  ********************************************************************************
  geaendert am / von:      31.07.2021 joeabd
                           Ausschluss von heine D entfernt 
 ********************************************************************************
  geaendert am / von:      30.08.2021 steern
                           Ausschluss von heine ch und nl entfernt +
                           emailanldat jetzt vergeben anhand "email_vorhanden"
 ********************************************************************************
  geaendert am / von:      02.09.2021 steern
                           POSTFACH, DATENSCHUTZKONTO, KONTONRLETZTEZIFFERN, NACHNAMEINITALE
                           hinzugefuegt
 ********************************************************************************
  geaendert am / von:      21.09.2021 steern
                           helline ausgeschlossen
 ********************************************************************************
  geaendert am / von:      24.09.2021 steern
                           - Auftragzaehler jetzt nicht mehr in Verbindung mit buchdat. 
                           - Umbau auf auftrn_key
 ********************************************************************************
  geaendert am / von:      26.10.2021 carkah
                           aus cc_buchung wird keine kontonr / konto_id mehr verwendet
                           
 ********************************************************************************
  geaendert am / von:      29.10.2021 steern
                           Kritsche DSGVO-Spalten ausgebaut       
 ********************************************************************************
  geaendert am / von:      04.11.2021 benlin
                           Mehrlinien fuer Witt Niederlande eingebaut    
 ********************************************************************************
  geaendert am / von:      12.11.2021 steern
                           Mehrlinien-Sonderlogik eingebaut fuer Witt CH/Witt AU  
 ********************************************************************************
  geaendert am / von:      25.11.2021 steern
                           Shopanteiligkeit eingebaut
 ********************************************************************************
  geaendert am / von:      30.11.2021 steern
                           LOADER.F_IS_INETKAT ausgebaut und umgestellt auf CC_KATART
 ********************************************************************************
  geaendert am / von:      30.12.2021 steern
                           MEHRLINIEN und ONLINE_TEST angepasst
 ********************************************************************************
  geaendert am / von:      08.02.2022 steern
                           CC_PLZREF eingebaut anstatt loader. 
                           loader-Funktionen ausgebaut
 ********************************************************************************
  geaendert am / von:      17.02.2022 steern, benlin
                           anlaktionscoderea als Referenzspalte
 ********************************************************************************
  geaendert am / von:      13.04.2022 joeabd
                           Anpassung onlinetest Witt D (31, 41 für ungerade vorletzte
                           Stelle der Kontonr)
 ********************************************************************************
  geaendert am / von:      01.06.2022 joeabd
                           Anpassung onlinetest Witt D (31, 41 für ungerade vorletzte
                           Stelle der Kontonr) nur für Altjung_akt 0, 3, 4.                           
 ********************************************************************************
  geaendert am / von:      09.06.2022 steern
                           Anpassung onlinetest Witt D, Sonderregeln eingefuhert bei 31,41 Geschichte 
 ********************************************************************************
  geaendert am / von:      30.06.2022 steern
                           Anpassung Logik ONLINE_TEST und MEHRLINIEN (fuer HW22)
 ********************************************************************************
  geaendert am / von:      07.11.2022 steern
                           Anpassung onlinetest Witt D, Sonderregeln eingefuhert bei 31,41 --> Auch "Rückwanderung" bei altjungfolge = 1 oder 2
 ********************************************************************************
  geaendert am / von:      29.12.2022 steern
                           Saisonwechselanpassungen fuer:
                           - ONLINE_TEST
                           - NETTTOBRUTTO
                           - VIERLINIEN
                           - Sonderlogik-Hack angepasst (TRUNC) rausgenommen in der WHERE-Klausel
 ********************************************************************************
  geaendert am / von:      09.03.2023 steern
                           Ausschluss Otto Marketplace als Firma
 ********************************************************************************
  geaendert am / von:      13.03.2023 steern
                           Sprachen-Belegung implementiert fuer die Schweizer Firmen                   
 ********************************************************************************
  geaendert am / von:      10.05.2023 steern
                           Otto Marktplatz aktiviert.   
 ********************************************************************************
  geaendert am / von:      23.05.2023 steern
                           Otto Marktplatz als Nettoausschluss markiert.  
 ********************************************************************************
  geaendert am / von:      25.05.2023 benlin
                           Spalte FGAKTIV eingebaut  
 ********************************************************************************
  geaendert am / von:      06.06.2023 joeabd
                           Sprache greift zusätzlich auf FUP-Tabelle zu                             
 ********************************************************************************
  geaendert am / von:      28.06.2023 steern
                           HKEKZ MIN() eingebaut fuer Spezialkatalogarten, da Uneindeutigkeit 
 ********************************************************************************
  geaendert am / von:      29.12.2023 steern
                           Neue Vtinfogruppe-Logiken hinsichtlich Sondervitinfos + ONLINE_TEST-Anpassung Datum
 ********************************************************************************
  geaendert am / von:      06.02.2024/20.02.2024 steern
                           nlabostatus und wunsch aus OneTrust / GoLive
 ********************************************************************************
  geaendert am / von:      02.05.2024 carkah
                           DATASERV-1237: neue Spalte email_key in cc_kunde 
 ********************************************************************************
  geaendert am / von:      08.05.2024 steern
                           AWS-Nlabostatusdaten: "buchungsdatum >= (SELECT F_GET_LAST_LVDAT(sysdate) FROM  dual)", 
                           um Feiertage abdecken zu koennen
 ********************************************************************************
  geaendert am / von:      29.05.2024 joeabd
                           Insert in clcc_ww_kunde_2: TO_NUMBER um mv.testgrp entfernt (ist jetzt varchar2)
 ********************************************************************************
  geaendert am / von:      14.06.2024 benlin
                           Join zu aws_nlabostatusdaten um konto_id_key erweitert
 ********************************************************************************
  geaendert am / von:      20.06.2024 steern
                           3.6 Kunden aus Sprachen-FUP hinzufuegen und Merge angepasst (Firma entfernt)                    
 ********************************************************************************
  geaendert am / von:      29.06.2024 steern
                           ansprohnestationaerwert eingebaut + Anpassung online_test Referenz  
 ********************************************************************************
  geaendert am / von:      15.07.2024 steern
                           Spalten eigenfremdkauf und serviceinforechnungversand eingebaut 
 ********************************************************************************
  geaendert am / von:      17.07.2024 steern
                           SR-99486: bei online_test = 0 fuer kontoart = 1 bei heine-Firmen --> immer online_Test = 162 (only online)
 ********************************************************************************
  geaendert am / von:      27.07.2024 steern
                           SR-98266: creation L Premium Logik hinzugefuegt
 ********************************************************************************
  geaendert am / von:      25.03.2025 steern
                           Onetrust-Daten werden anhand konto_id_key nicht emailhash (da bei Loeschungen emailhash null wird) 
 ********************************************************************************
  geaendert am / von:      04.06.2025 steern
                           Neue Spalte VTINFOGRPSTATIONAER  
 ********************************************************************************
  geaendert am / von:      05.06.2025 steern
                           VTGEBIET/OSTWEST: Bei "Umzieher" wird jetzt neu gesetzt, vorher blieb immer der initiale Eintrag. 
 ********************************************************************************
  geaendert am / von:      09.06.2025 steern
                           appauftrdaterst eingebaut
  ********************************************************************************
  geaendert am / von:      27.08.2025 steern
                           appauftrdaterst eingebaut auch ueber ext. Schnittstelle
  ********************************************************************************
  geaendert am / von:      09.12.2025 steern
                           praefartgrdobaktiv/praefartgrdobinaktiv eingebaut
  ********************************************************************************
  geaendert am / von:      30.12.2025 steern
                           hkekz ausgebaut
  ********************************************************************************/
 
  ALTER SESSION ENABLE PARALLEL DML;

  SET SERVEROUTPUT ON

  PROMPT ==================================
  PROMPT parameter
  PROMPT prozessdatum 24h: &termin
  PROMPT ladedatum: &datum
  PROMPT saisonanfangsdatum: &hjanfang
  PROMPT saisonendedatum: &hjende
  PROMPT saisonanfangsdatum-6 Saisons: &hjanfangm6
  PROMPT saison: &vtsaison
  PROMPT saison - 1: &vtsaisonm1
  PROMPT saison + 1: &vtsaisonp1
  PROMPT gbv-id: &gbvid
  PROMPT prozessdastum-1 24h: &terminm1
  PROMPT ================================


  PROMPT =========================================================
  PROMPT
  PROMPT 1. Join aus Kundentabellen als Bais fuer Weiterverdichtung
  PROMPT --> alle aktuell Gueltigen DS selektieren
  PROMPT
  PROMPT =========================================================

  TRUNCATE TABLE clcc_ww_kunde_1;

  INSERT /*+APPEND*/ INTO clcc_ww_kunde_1
    (
      dwh_cr_load_id,
      dwh_id_sc_ww_person,
      dwh_id_sc_ww_adresse,
      dwh_id_sc_ww_adr,
      dwh_id_sc_ww_kdkto,
      dwh_id_sc_ww_kunde,
      dwh_id_sc_ww_kundenfirma,
      dwh_id_sc_ww_kdart,
      dwh_id_sc_ww_verswunsch,
      dwh_id_sc_ww_werbmit,
      dwh_id_sc_ww_telemk,
      dwh_id_sc_ww_mahneb,
      dwh_id_sc_ww_mahnstrang,
      dwh_id_sc_ww_nladressherkunft,
      dwh_id_sc_ww_nltyp,
      dwh_id_sc_ww_tddsg,
      dwh_id_sc_ww_bonikl,
      dwh_id_sc_ww_ersatzart,
      dwh_id_sc_ww_nachbarschabg,
      dwh_id_sc_ww_kdloginaktivkz,
      dwh_id_sc_ww_servicemailaktiv,
      dwh_id_sc_ww_kontosperre,
      dwh_id_sc_ww_wunschkzidfilialwerb,
      dwh_id_sc_ww_fg,
      dwh_id_sc_ww_adrausvorteilsnr,
      dwh_id_sc_ww_eigenfremdkaufkz,
      dwh_id_sc_ww_persanrede,
      dwh_id_sc_ww_adrhdl,
      dwh_id_sc_ww_emailverweigert,
      dwh_id_sc_ww_rufnummerverweigert,
      dwh_id_sc_ww_emailvorhanden, 
      dwh_id_sc_ww_handyvorhanden,
      dwh_id_sc_ww_gebdatstatus,
      dwh_id_sc_ww_telefonprivatvorhanden,
      dwh_id_sc_ww_datenschutz, 
      dwh_id_sc_ww_serviceinforechnungversandkz,
      dwh_id_sc_ww_land,
      dwh_id_sc_ww_postfach,
      kundeid_key,
      kontonrletzteziffern,
      konto_id_key,
      wkz,
      iwl,
      vtinfokdgrp,
      rgkfumstdat,
      anlaufdat,
      anlaufsaison,
      testgrp,
      verwkonto_id_key,
      kdloginaktivierungsdat,
      kdloginlinksenddat,
      eigenfremdkaufkz,
      ti,
      vname,
      gebdat,
      gebdatstatus,
      telefonprivat_vorhanden,
      telefonprivatvorwahl,
      telefonfirmavorwahl,
      faxprivatvorwahl,
      faxfirmavorwahl,
      email_hash, 
      email_vorhanden,
      handy_vorhanden,
      datenschutzkonto, 
      nachnameinitiale,
      emailprivat_key,
      serviceinforechnungversandkz,
      plz,
      plzzus,
      postfach,
      briefbotenbez,
      pit_provinzgrp,
      ursprungsland,
      kredlim,
      wunschkzfilialwerb,
      fgidstamm,
      adresseausvorteilsnummer,
      ladedatum
     )
   SELECT /*+ parallel (16)*/
      &gbvid,
      sc_ww_person.dwh_id dwh_id_sc_ww_person,
      sc_ww_adresse.dwh_id dwh_id_sc_ww_adresse,
      sc_ww_adr.dwh_id dwh_id_sc_ww_adr,
      sc_ww_kdkto.dwh_id dwh_id_sc_ww_kdkt,
      sc_ww_kunde.dwh_id dwh_id_sc_ww_kunde,
      sc_ww_kunde.dwh_id_sc_ww_kundenfirma,
      sc_ww_kunde.dwh_id_sc_ww_kdart,
      sc_ww_kunde.dwh_id_sc_ww_verswunsch,
      sc_ww_kunde.dwh_id_sc_ww_werbmit,
      sc_ww_kunde.dwh_id_sc_ww_telemk,
      sc_ww_kunde.dwh_id_sc_ww_mahneb,
      sc_ww_kunde.dwh_id_sc_ww_mahnstrang,
      sc_ww_kunde.dwh_id_sc_ww_nladressherkunft,
      sc_ww_kunde.dwh_id_sc_ww_nltyp,
      sc_ww_kunde.dwh_id_sc_ww_tddsg,
      sc_ww_kunde.dwh_id_sc_ww_bonikl,
      sc_ww_kunde.dwh_id_sc_ww_ersatzart,
      sc_ww_kunde.dwh_id_sc_ww_nachbarschabg,
      sc_ww_kunde.dwh_id_sc_ww_kdloginaktivkz,
      sc_ww_kunde.dwh_id_sc_ww_servicemailaktiv,
      sc_ww_kunde.dwh_id_sc_ww_kontosperre,
      sc_ww_kunde.dwh_id_sc_ww_wunschkzidfilialwerb,
      sc_ww_kunde.dwh_id_sc_ww_fg,
      sc_ww_kunde.dwh_id_sc_ww_adrausvorteilsnr,
      sc_ww_kunde.dwh_id_sc_ww_eigenfremdkaufkz,
      sc_ww_person.dwh_id_sc_ww_persanrede,
      sc_ww_person.dwh_id_sc_ww_adrhdl,
      sc_ww_person.dwh_id_sc_ww_emailverweigert,
      sc_ww_person.dwh_id_sc_ww_rufnummerverweigert,
      sc_ww_person.dwh_id_sc_ww_emailvorhanden, 
      sc_ww_person.dwh_id_sc_ww_handyvorhanden,
      sc_ww_person.dwh_id_sc_ww_gebdatstatus,
      sc_ww_person.dwh_id_sc_ww_telefonprivatvorhanden,
      sc_ww_person.dwh_id_sc_ww_datenschutz,
      sc_ww_person.dwh_id_sc_ww_serviceinforechnungversandkz,
      sc_ww_adresse.dwh_id_sc_ww_land,
      sc_ww_adresse.dwh_id_sc_ww_postfach,
      sc_ww_kunde.id_key AS kundeid_key,
      sc_ww_kunde.kontonrletzteziffern,
      sc_ww_kunde.konto_id_key,
      sc_ww_kunde.wkz,
      sc_ww_kunde.iwl,
      sc_ww_kunde.vtinfokdgrp,
      sc_ww_kunde.rgkfumstdat,
      sc_ww_kunde.anlaufdat,
      sc_ww_kunde.anlaufsaison,
      sc_ww_kunde.testgrp,
      sc_ww_kunde.verwkonto_id_key,
      sc_ww_kunde.kdloginaktivierungsdat,
      sc_ww_kunde.kdloginlinksenddat,
      sc_ww_kunde.eigenfremdkaufkz,
      sc_ww_person.ti,
      sc_ww_person.vname,
      sc_ww_person.gebdat,
      sc_ww_person.gebdatstatus,
      sc_ww_person.telefonprivat_vorhanden,
      sc_ww_person.telefonprivatvorwahl,
      sc_ww_person.telefonfirmavorwahl,
      sc_ww_person.faxprivatvorwahl,
      sc_ww_person.faxfirmavorwahl,
      sc_ww_person.email_hash, 
      sc_ww_person.email_vorhanden,
      sc_ww_person.handy_vorhanden,
      sc_ww_person.datenschutz,
      sc_ww_person.nachnameanfang, 
      sc_ww_person.emailprivat_key,
      sc_ww_person.serviceinforechnungversandkz,
      sc_ww_adresse.plz,
      sc_ww_adresse.plzzus,
      sc_ww_adresse.postfach,
      sc_ww_adr.briefbotenbez,
      sc_ww_adr.pit_provinzgrp,
      sc_ww_adr.ursprungsland,
      sc_ww_kdkto.kredlim,
      sc_ww_kunde.wunschkzidfilialwerb,
      sc_ww_kunde.fgidstamm,
      sc_ww_kunde.adresseausvorteilsnummer,
      GREATEST (
       COALESCE (sc_ww_person.dwh_valid_from, TO_DATE ('19000101', 'yyyymmdd hh24')),
       COALESCE (sc_ww_adresse.dwh_valid_from, TO_DATE ('19000101', 'yyyymmdd')),
       COALESCE (sc_ww_adr.dwh_valid_from, TO_DATE ('19000101', 'yyyymmdd')),
       COALESCE (sc_ww_kdkto.dwh_valid_from, TO_DATE ('19000101', 'yyyymmdd')),
       COALESCE (sc_ww_kunde.dwh_valid_from, TO_DATE ('19000101', 'yyyymmdd'))
            )
      AS ladedatum
  FROM
      (
        SELECT a.kontonrletzteziffern,
               a.konto_id_key,
               a.wkz,
               a.iwl,
               a.vtinfokdgrp,
               a.rgkfumstdat,
               a.anlaufdat,
               a.anlaufsaison,
               a.testgrp,
               a.verwkonto_id_key,
               a.kdloginaktivierungsdat,
               a.kdloginlinksenddat,
               a.eigenfremdkaufkz,
               a.dwh_valid_from,
               a.dwh_id_sc_ww_person,
               a.dwh_id dwh_id_sc_ww_kunde,
               a.dwh_id_sc_ww_kundenfirma,
               a.dwh_id_sc_ww_kdart,
               a.dwh_id_sc_ww_verswunsch,
               a.dwh_id_sc_ww_werbmit,
               a.dwh_id_sc_ww_telemk,
               a.dwh_id_sc_ww_mahneb,
               a.dwh_id_sc_ww_mahnstrang,
               a.dwh_id_sc_ww_nladressherkunft,
               a.dwh_id_sc_ww_nltyp,
               a.dwh_id_sc_ww_tddsg,
               a.dwh_id_sc_ww_bonikl,
               a.dwh_id_sc_ww_ersatzart,
               a.dwh_id_sc_ww_nachbarschabg,
               a.dwh_id_sc_ww_kdloginaktivkz,
               a.dwh_id_sc_ww_servicemailaktiv,
               a.dwh_id_sc_ww_kontosperre,
               a.dwh_id_sc_ww_wunschkzidfilialwerb,
               a.dwh_id_sc_ww_fg,
               a.dwh_id_sc_ww_adrausvorteilsnr,
               a.dwh_id_sc_ww_eigenfremdkaufkz,
               a.wunschkzidfilialwerb,
               a.fgidstamm,
               a.adresseausvorteilsnummer,
               b.id_key, 
               b.dwh_id
          FROM sc_ww_kunde_ver a
          INNER JOIN sc_ww_kunde b
          ON (a.dwh_id_head = b.dwh_id AND &termin BETWEEN a.dwh_valid_from AND a.dwh_valid_to
          AND firma <> 20 -- Ausschluss CROSS BORDER USA
          AND firma <> 27 -- Ausschluss Witt Schweden
          --AND firma <> 44 -- Ausschluss Sheego
          --AND firma <> 28 -- Ausschluss Otto Marketplace
          AND firma <> 26 -- Ausschluss Saudi Arabien Cross Border
          AND firma <> 16 -- Ausschluss Sieh An! Frankreich
          AND firma <> 7  -- Ausschluss Witt Frankreich         
          AND firma <> 24 -- Ausschluss heine Frankreich         
          AND firma <> 4  -- Ausschluss UK
          AND firma <> 45 -- Ausschluss Plattform AT    
          AND firma <> 46 -- Ausschluss Plattform CH    
          AND firma <> 47 -- Ausschluss Plattform NL    
         )
    )
    sc_ww_kunde
   INNER JOIN
    (
         SELECT    a.ti,
                   a.vname,
                   a.gebdat,
                   a.telefonprivatvorwahl,
                   a.telefonfirmavorwahl,
                   a.faxprivatvorwahl,
                   a.faxfirmavorwahl,
                   a.email_hash,
                   a.email_vorhanden, 
                   a.handy_vorhanden, 
                   a.gebdatstatus,
                   a.telefonprivat_vorhanden,
                   a.datenschutz,
                   a.nachnameanfang,
                   a.emailprivat_key,
                   a.serviceinforechnungversandkz,
                   a.dwh_valid_from,
                   a.dwh_id_sc_ww_adresse,
                   a.dwh_id_sc_ww_persanrede,
                   a.dwh_id_sc_ww_adrhdl,
                   a.dwh_id_sc_ww_emailverweigert,
                   a.dwh_id_sc_ww_rufnummerverweigert,
                   a.dwh_id_sc_ww_emailvorhanden, 
                   a.dwh_id_sc_ww_handyvorhanden,
                   a.dwh_id_sc_ww_gebdatstatus,
                   a.dwh_id_sc_ww_telefonprivatvorhanden,
                   a.dwh_id_sc_ww_datenschutz,
                   a.dwh_id_sc_ww_serviceinforechnungversandkz,
                   a.dwh_id_head AS dwh_id
            FROM sc_ww_person_ver a
       WHERE &termin BETWEEN a.dwh_valid_from AND a.dwh_valid_to
     ) 
     sc_ww_person ON (sc_ww_kunde.dwh_id_sc_ww_person = sc_ww_person.dwh_id)
   INNER JOIN
     (
       SELECT     a.plz,
                  a.plzzus,
                  a.postfach,
                  a.dwh_valid_from,
                  a.dwh_id_sc_ww_land,
                  a.dwh_id_sc_ww_postfach,
                  a.dwh_id_head AS dwh_id
           FROM sc_ww_adresse_ver a
           WHERE &termin BETWEEN a.dwh_valid_from AND a.dwh_valid_to
     )
     sc_ww_adresse ON (sc_ww_person.dwh_id_sc_ww_adresse = sc_ww_adresse.dwh_id)
   LEFT OUTER JOIN
   (
       SELECT     a.briefbotenbez,
                  a.pit_provinzgrp,
                  a.ursprungsland,
                  a.dwh_valid_from,
                  a.dwh_id_sc_ww_adresse,
                  a.dwh_id_head dwh_id
           FROM sc_ww_adr_ver a
           WHERE &termin BETWEEN a.dwh_valid_from AND a.dwh_valid_to
     )
     sc_ww_adr ON (sc_ww_adresse.dwh_id = sc_ww_adr.dwh_id_sc_ww_adresse)
   LEFT OUTER JOIN
   (
     SELECT   a.kredlim,
              a.dwh_id_sc_ww_kunde,
              a.dwh_valid_from,
              a.dwh_id_head dwh_id
       FROM sc_ww_kdkto_ver a
       WHERE &termin BETWEEN a.dwh_valid_from AND a.dwh_valid_to
   )
    sc_ww_kdkto  ON (sc_ww_kunde.dwh_id = sc_ww_kdkto.dwh_id_sc_ww_kunde);

 COMMIT;
 
 EXEC PKG_STATS.GATHERTABLE (user, 'clcc_ww_kunde_1');



 PROMPT =========================================================
 PROMPT 2. Tabelle mit Referenztabellen joinen um die richtigen Ausprägungen zu
 PROMPT erhalten, Spalten umbenennen und Umformatierung für letztendliche Stamm
 PROMPT =========================================================

 DROP INDEX clcc_ww_kunde_2_ix1;

 TRUNCATE TABLE clcc_ww_kunde_2;
 
 INSERT /*+APPEND*/ INTO clcc_ww_kunde_2
    (
    dwh_cr_load_id,
    dwh_id_sc_ww_person,
    dwh_id_sc_ww_adresse,
    dwh_id_sc_ww_adr,
    dwh_id_sc_ww_kdkto,
    dwh_id_sc_ww_kunde,
    dwh_id_sc_ww_kundenfirma,
    dwh_id_sc_ww_kdart,
    dwh_id_sc_ww_verswunsch,
    dwh_id_sc_ww_werbmit,
    dwh_id_sc_ww_telemk,
    dwh_id_sc_ww_mahneb,
    dwh_id_sc_ww_mahnstrang,
    dwh_id_sc_ww_nladressherkunft,
    dwh_id_sc_ww_nltyp,
    dwh_id_sc_ww_tddsg,
    dwh_id_sc_ww_bonikl,
    dwh_id_sc_ww_ersatzart,
    dwh_id_sc_ww_nachbarschabg,
    dwh_id_sc_ww_kdloginaktivkz,
    dwh_id_sc_ww_servicemailaktiv,
    dwh_id_sc_ww_kontosperre,
    dwh_id_sc_ww_wunschkzidfilialwerb,
    dwh_id_sc_ww_fg,
    dwh_id_sc_ww_persanrede,
    dwh_id_sc_ww_adrhdl,
    dwh_id_sc_ww_emailverweigert,
    dwh_id_sc_ww_rufnummerverweigert,
    dwh_id_sc_ww_land,
    dwh_id_sc_ww_adrausvorteilsnr,
    dwh_id_sc_ww_emailvorhanden,
    dwh_id_sc_ww_handyvorhanden,
    dwh_id_sc_ww_gebdatstatus,
    dwh_id_sc_ww_telefonprivatvorhanden,
    dwh_id_sc_ww_postfach,
    dwh_id_sc_ww_datenschutz,
    dwh_id_sc_ww_eigenfremdkaufkz,
    dwh_id_sc_ww_serviceinforechnungversandkz,
    dwh_id_cc_firma,
    dwh_id_cc_adrhdl,
    dwh_id_cc_anrede,
    dwh_id_cc_land,
    dwh_id_cc_kdart,
    dwh_id_cc_zustelldienst,
    dwh_id_cc_telemarkwunsch,
    dwh_id_cc_werbemittelsperre,
    dwh_id_cc_mahnebene,
    dwh_id_cc_mahnstrang,
    dwh_id_cc_bonikl,
    dwh_id_cc_ersartwunsch,
    dwh_id_cc_nachbarabg,
    dwh_id_cc_emailherkunft,
    dwh_id_cc_nltyp,
    dwh_id_cc_rufnrverweigert,
    dwh_id_cc_emailverweigert,
    dwh_id_cc_servicemailaktiv,
    dwh_id_cc_kdloginaktiv,
    dwh_id_cc_kontosperre,
    dwh_id_cc_fg,
    dwh_id_cc_filialwerbungwunsch,
    dwh_id_cc_vorteilsnrangabe,
    dwh_id_cc_emailvorhanden,
    dwh_id_cc_mobilnrvorhanden,
    dwh_id_cc_gebdatverweigert,
    dwh_id_cc_telefonvorhanden,
    dwh_id_cc_postfach,
    dwh_id_cc_datenschutzkonto,
    dwh_id_cc_eigenfremdkauf,
    dwh_id_cc_serviceinfoversand,
    kundeid_key,
    firma,
    kontonrletzteziffern,
    konto_id_key,
    kundenart,
    kontosperre,
    versandkz,
    werbemittelsperre,
    telemarkkz,
    wkz,
    iwl,
    vtinfo_edv,
    rkumstellung,
    mahnebene,
    mahnstrang,
    anldatum,
    anlsaison,
    nladressherkunft,
    nltyp,
    testgruppe,
    bkl,
    ersatzartkz,
    nachbarkz,
    verweiskonto_id_key,
    kdloginaktdat,
    kdloginlinkdat,
    kdloginaktivkz,
    servicemailaktivkz,
    anrede,
    titel,
    vorname,
    gebdatum,
    gebdatstatus,
    telefonprivat_vorhanden,
    adrhdlkz,
    plz,
    land,
    landnr,
    plzzusatz,
    briefbotenbezirk,
    provinzcode,
    ursprungsland,
    kreditlimit,
    emailverweigertkz,
    telefonprivatvorwahl,
    telefonfirmavorwahl,
    faxprivatvorwahl,
    faxfirmavorwahl,
    email_hash, 
    email_vorhanden,
    handy_vorhanden,
    rufnummerverweigertkz,
    fgnr,
    wunschfilialwerb,
    adresseausvorteilsnummer,
    postfach,
    datenschutzkonto,
    nachnameinitiale,
    emailprivat_key,
    eigenfremdkaufkz,
    serviceinforechnungversandkz,
    ladedatum
    )
   SELECT /*+parallel (8) */
    dwh_cr_load_id,
    dwh_id_sc_ww_person,
    dwh_id_sc_ww_adresse,
    dwh_id_sc_ww_adr,
    dwh_id_sc_ww_kdkto,
    dwh_id_sc_ww_kunde,
    dwh_id_sc_ww_kundenfirma,
    dwh_id_sc_ww_kdart,
    dwh_id_sc_ww_verswunsch,
    dwh_id_sc_ww_werbmit,
    dwh_id_sc_ww_telemk,
    dwh_id_sc_ww_mahneb,
    dwh_id_sc_ww_mahnstrang,
    dwh_id_sc_ww_nladressherkunft,
    dwh_id_sc_ww_nltyp,
    dwh_id_sc_ww_tddsg,
    dwh_id_sc_ww_bonikl,
    dwh_id_sc_ww_ersatzart,
    dwh_id_sc_ww_nachbarschabg,
    dwh_id_sc_ww_kdloginaktivkz,
    dwh_id_sc_ww_servicemailaktiv,
    dwh_id_sc_ww_kontosperre,
    dwh_id_sc_ww_wunschkzidfilialwerb,
    dwh_id_sc_ww_fg,
    dwh_id_sc_ww_persanrede,
    dwh_id_sc_ww_adrhdl,
    dwh_id_sc_ww_emailverweigert,
    dwh_id_sc_ww_rufnummerverweigert,
    dwh_id_sc_ww_land,
    dwh_id_sc_ww_adrausvorteilsnr,
    dwh_id_sc_ww_emailvorhanden,
    dwh_id_sc_ww_handyvorhanden,
    dwh_id_sc_ww_gebdatstatus,
    dwh_id_sc_ww_telefonprivatvorhanden,
    dwh_id_sc_ww_postfach,
    dwh_id_sc_ww_datenschutz,
    dwh_id_sc_ww_eigenfremdkaufkz,
    dwh_id_sc_ww_serviceinforechnungversandkz,
    dwh_id_cc_firma,
    dwh_id_cc_adrhdl,
    dwh_id_cc_anrede,
    dwh_id_cc_land,
    dwh_id_cc_kdart,
    dwh_id_cc_zustelldienst,
    dwh_id_cc_telemarkwunsch,
    dwh_id_cc_werbemittelsperre,
    dwh_id_cc_mahnebene,
    dwh_id_cc_mahnstrang,
    dwh_id_cc_bonikl,
    dwh_id_cc_ersartwunsch,
    dwh_id_cc_nachbarabg,
    dwh_id_cc_emailherkunft,
    dwh_id_cc_nltyp,
    dwh_id_cc_rufnrverweigert,
    dwh_id_cc_emailverweigert,
    dwh_id_cc_servicemailaktiv,
    dwh_id_cc_kdloginaktiv,
    dwh_id_cc_kontosperre,
    dwh_id_cc_fg,
    dwh_id_cc_filialwerbungwunsch,
    dwh_id_cc_vorteilsnrangabe,
    dwh_id_cc_emailvorhanden,
    dwh_id_cc_mobilnrvorhanden,
    dwh_id_cc_gebdatverweigert,
    dwh_id_cc_telefonvorhanden,
    dwh_id_cc_postfach,
    dwh_id_cc_datenschutzkonto,
    dwh_id_cc_eigenfremdkauf,
    dwh_id_cc_serviceinfoversand,
    mv.kundeid_key,
    kundenfirma.kdfirmkz AS firma,
    mv.kontonrletzteziffern AS kontonrletzteziffern,
    mv.konto_id_key AS konto_id_key,
    sc_ww_kdart.kdart AS kundenart,
    TO_NUMBER(sc_ww_kontosperre.kz) AS kontosperre,
    sc_ww_verswunsch.verswunschkz AS versandkz,
    TO_NUMBER(sc_ww_werbmit.werbmitkz) AS werbemittelsperre,
    sc_ww_telemk.wunschkz AS telemarkkz,
    mv.wkz,
    mv.iwl,
    mv.vtinfokdgrp AS vtinfo_edv,
    mv.rgkfumstdat AS rkumstellung,
    NVL(sc_ww_mahneb.mahneb,0) AS mahnebene,    -- Default ist 0
    NVL(sc_ww_mahnstrang.mahnstrang,0) AS mahnstrang, -- Default ist 0
    mv.anlaufdat AS anldatum,
    mv.anlaufsaison AS anlsaison,
    sc_ww_nladressherkunft.adressherkunftkz AS nladressherkunft,
    sc_ww_nltyp.bez AS nltyp,
    mv.testgrp AS testgruppe,
    sc_ww_bonikl.bonikl AS bkl,
    sc_ww_ersatzart.wunschkz AS ersatzartkz,
    sc_ww_nachbarschabg.wunschkz AS nachbarkz,
    mv.verwkonto_id_key AS verwkonto_id_key,
    mv.kdloginaktivierungsdat AS kdloginaktdat,
    mv.kdloginlinksenddat AS kdloginlinkdat,
    sc_ww_kdloginaktivkz.wert AS kdloginaktivkz,
    sc_ww_servicemailaktiv.wert,
    sc_ww_persanrede.anrkz AS anrede,
    mv.ti AS titel,
    mv.vname AS vorname,
    mv.gebdat AS gebdatum,
    mv.gebdatstatus AS gebdatstatus,
    mv.telefonprivat_vorhanden AS telefonprivat_vorhanden,
    sc_ww_adrhdl.adrhdlkz,
    mv.plz,
    sc_ww_land.landkurzbez AS land,
    sc_ww_land.landnr,
    mv.plzzus AS plzzusatz,
    mv.briefbotenbez AS briefbotenbezirk,
    mv.pit_provinzgrp AS provinzcode,
    mv.ursprungsland AS ursprungsland,
    mv.kredlim AS kreditlimit ,
    sc_ww_emailverweigert.wert,
    mv.telefonprivatvorwahl,
    mv.telefonfirmavorwahl,
    mv.faxprivatvorwahl,
    mv.faxfirmavorwahl,
    mv.email_hash, 
    mv.email_vorhanden,
    mv.handy_vorhanden,
    sc_ww_rufnummerverweigert.wert,
    sc_ww_fg.fgnr,
    sc_ww_wunschfilialwerb.wunschkz AS wunschfilialwerb,
    mv.adresseausvorteilsnummer,
    mv.postfach,
    mv.datenschutzkonto,
    mv.nachnameinitiale,
    mv.emailprivat_key,
    mv.eigenfremdkaufkz,
    mv.serviceinforechnungversandkz,
    mv.ladedatum
    FROM clcc_ww_kunde_1 mv
    LEFT OUTER JOIN
             (SELECT a.dwh_id,
                     kdfirmkz,
                     dwh_id_cc_firma
                FROM sc_ww_kundenfirma a
                     INNER JOIN sc_ww_kundenfirma_ver b
                         ON (    a.dwh_id = b.dwh_id_head
                             AND &termin BETWEEN b.dwh_valid_from
                                             AND b.dwh_valid_to)
             ) kundenfirma
                  ON (mv.dwh_id_sc_ww_kundenfirma = kundenfirma.dwh_id)
    LEFT OUTER JOIN
             (SELECT a.dwh_id,
                     adrhdlkz,
                     dwh_id_cc_adrhdl
                FROM sc_ww_adrhdl a
                     INNER JOIN sc_ww_adrhdl_ver b
                         ON (    a.dwh_id = b.dwh_id_head
                             AND &termin BETWEEN b.dwh_valid_from
                                             AND b.dwh_valid_to)
             ) sc_ww_adrhdl
                  ON (mv.dwh_id_sc_ww_adrhdl = sc_ww_adrhdl.dwh_id)
    LEFT OUTER JOIN
             (SELECT a.dwh_id,
                     anrkz,
                     dwh_id_cc_anrede
                FROM sc_ww_persanrede a
                     INNER JOIN sc_ww_persanrede_ver  b
                         ON (    a.dwh_id = b.dwh_id_head
                             AND &termin BETWEEN b.dwh_valid_from
                                             AND b.dwh_valid_to)
             ) sc_ww_persanrede
                  ON (mv.dwh_id_sc_ww_persanrede = sc_ww_persanrede.dwh_id)
    LEFT OUTER JOIN
             (SELECT a.dwh_id,
                     landnr,
                     landkurzbez,
                     dwh_id_cc_land
                FROM sc_ww_land a
                     INNER JOIN sc_ww_land_ver b
                         ON (    a.dwh_id = b.dwh_id_head
                             AND &termin BETWEEN b.dwh_valid_from
                                             AND b.dwh_valid_to)
             ) sc_ww_land
                  ON (mv.dwh_id_sc_ww_land = sc_ww_land.dwh_id)
    LEFT OUTER JOIN
             (SELECT a.dwh_id,
                     kdart,
                     dwh_id_cc_kdart
                FROM sc_ww_kdart a
                     INNER JOIN sc_ww_kdart_ver b
                         ON (    a.dwh_id = b.dwh_id_head
                             AND &termin BETWEEN b.dwh_valid_from
                                             AND b.dwh_valid_to)
             ) sc_ww_kdart
                  ON (mv.dwh_id_sc_ww_kdart = sc_ww_kdart.dwh_id)
    LEFT OUTER JOIN
             (SELECT a.dwh_id,
                     verswunschkz,
                     dwh_id_cc_zustelldienst
                FROM sc_ww_verswunsch a
                     INNER JOIN sc_ww_verswunsch_ver b
                         ON (    a.dwh_id = b.dwh_id_head
                             AND &termin BETWEEN b.dwh_valid_from
                                             AND b.dwh_valid_to)
             ) sc_ww_verswunsch
                  ON (mv.dwh_id_sc_ww_verswunsch = sc_ww_verswunsch.dwh_id)
    LEFT OUTER JOIN
             (SELECT a.dwh_id,
                     wunschkz,
                     dwh_id_cc_telemarkwunsch
                FROM sc_ww_telemk a
                     INNER JOIN sc_ww_telemk_ver b
                         ON (    a.dwh_id = b.dwh_id_head
                             AND &termin BETWEEN b.dwh_valid_from
                                             AND b.dwh_valid_to)
             ) sc_ww_telemk
                  ON (mv.dwh_id_sc_ww_telemk = sc_ww_telemk.dwh_id)
    LEFT OUTER JOIN
             (SELECT a.dwh_id,
                     werbmitkz,
                     dwh_id_cc_werbemittelsperre
                FROM sc_ww_werbmit a
                     INNER JOIN sc_ww_werbmit_ver b
                         ON (    a.dwh_id = b.dwh_id_head
                             AND &termin BETWEEN b.dwh_valid_from
                                             AND b.dwh_valid_to)
             ) sc_ww_werbmit
                  ON (mv.dwh_id_sc_ww_werbmit = sc_ww_werbmit.dwh_id)
    LEFT OUTER JOIN
             (SELECT a.dwh_id,
                     mahneb,
                     dwh_id_cc_mahnebene
                FROM sc_ww_mahneb a
                     INNER JOIN sc_ww_mahneb_ver b
                         ON (    a.dwh_id = b.dwh_id_head
                             AND &termin BETWEEN b.dwh_valid_from
                                             AND b.dwh_valid_to)
             ) sc_ww_mahneb
                  ON (mv.dwh_id_sc_ww_mahneb = sc_ww_mahneb.dwh_id)
    LEFT OUTER JOIN
             (SELECT a.dwh_id,
                     mahnstrang,
                     dwh_id_cc_mahnstrang
                FROM sc_ww_mahnstrang a
                     INNER JOIN sc_ww_mahnstrang_ver b
                         ON (    a.dwh_id = b.dwh_id_head
                             AND &termin BETWEEN b.dwh_valid_from
                                             AND b.dwh_valid_to)
             ) sc_ww_mahnstrang
                  ON (mv.dwh_id_sc_ww_mahnstrang = sc_ww_mahnstrang.dwh_id)
    LEFT OUTER JOIN
             (SELECT a.dwh_id,
                     bonikl,
                     dwh_id_cc_bonikl
                FROM sc_ww_bonikl a
                     INNER JOIN sc_ww_bonikl_ver b
                         ON (    a.dwh_id = b.dwh_id_head
                             AND &termin BETWEEN b.dwh_valid_from
                                             AND b.dwh_valid_to)
             ) sc_ww_bonikl
                  ON (mv.dwh_id_sc_ww_bonikl = sc_ww_bonikl.dwh_id)
    LEFT OUTER JOIN
             (SELECT a.dwh_id,
                     wunschkz,
                     dwh_id_cc_ersartwunsch
                FROM sc_ww_ersatzart a
                     INNER JOIN sc_ww_ersatzart_ver b
                         ON (    a.dwh_id = b.dwh_id_head
                             AND &termin BETWEEN b.dwh_valid_from
                                             AND b.dwh_valid_to)
             ) sc_ww_ersatzart
                  ON (mv.dwh_id_sc_ww_ersatzart = sc_ww_ersatzart.dwh_id)
    LEFT OUTER JOIN
             (SELECT a.dwh_id,
                     wunschkz,
                     dwh_id_cc_nachbarabg
                FROM sc_ww_nachbarschabg a
                     INNER JOIN sc_ww_nachbarschabg_ver b
                         ON (    a.dwh_id = b.dwh_id_head
                             AND &termin BETWEEN b.dwh_valid_from
                                             AND b.dwh_valid_to)
             ) sc_ww_nachbarschabg
                  ON (mv.dwh_id_sc_ww_nachbarschabg = sc_ww_nachbarschabg.dwh_id)
    LEFT OUTER JOIN
             (SELECT a.dwh_id,
                     adressherkunftkz,
                     dwh_id_cc_emailherkunft
                FROM sc_ww_nladressherkunft a
                     INNER JOIN sc_ww_nladressherkunft_ver b
                         ON (    a.dwh_id = b.dwh_id_head
                             AND &termin BETWEEN b.dwh_valid_from
                                             AND b.dwh_valid_to)
             ) sc_ww_nladressherkunft
                  ON (mv.dwh_id_sc_ww_nladressherkunft = sc_ww_nladressherkunft.dwh_id)
    LEFT OUTER JOIN
             (SELECT a.dwh_id,
                     bez,
                     dwh_id_cc_nltyp
                FROM sc_ww_nltyp a
                     INNER JOIN sc_ww_nltyp_ver b
                         ON (    a.dwh_id = b.dwh_id_head
                             AND &termin BETWEEN b.dwh_valid_from
                                             AND b.dwh_valid_to)
             ) sc_ww_nltyp
                  ON (mv.dwh_id_sc_ww_nltyp = sc_ww_nltyp.dwh_id)
    LEFT OUTER JOIN
             (SELECT a.dwh_id,
                     wert,
                     dwh_id_cc_janein AS dwh_id_cc_rufnrverweigert
                FROM sc_ww_rufnummerverweigert a
                     INNER JOIN sc_ww_rufnummerverweigert_ver b
                         ON (    a.dwh_id = b.dwh_id_head
                             AND &termin BETWEEN b.dwh_valid_from
                                             AND b.dwh_valid_to)
             ) sc_ww_rufnummerverweigert
                  ON (mv.dwh_id_sc_ww_rufnummerverweigert = sc_ww_rufnummerverweigert.dwh_id)
    LEFT OUTER JOIN
             (SELECT a.dwh_id,
                     wert,
                     dwh_id_cc_janein AS dwh_id_cc_emailverweigert
                FROM sc_ww_emailverweigert a
                     INNER JOIN sc_ww_emailverweigert_ver b
                         ON (    a.dwh_id = b.dwh_id_head
                             AND &termin BETWEEN b.dwh_valid_from
                                             AND b.dwh_valid_to)
             ) sc_ww_emailverweigert
                  ON (mv.dwh_id_sc_ww_emailverweigert = sc_ww_emailverweigert.dwh_id)
    LEFT OUTER JOIN
             (SELECT a.dwh_id,
                     wert,
                     dwh_id_cc_servicemailaktiv
                FROM sc_ww_servicemailaktiv a
                     INNER JOIN sc_ww_servicemailaktiv_ver b
                         ON (    a.dwh_id = b.dwh_id_head
                             AND &termin BETWEEN b.dwh_valid_from
                                             AND b.dwh_valid_to)
             ) sc_ww_servicemailaktiv
                  ON (mv.dwh_id_sc_ww_servicemailaktiv = sc_ww_servicemailaktiv.dwh_id)
    LEFT OUTER JOIN
             (SELECT a.dwh_id,
                     wert,
                     dwh_id_cc_kdloginaktiv
                FROM sc_ww_kdloginaktivkz a
                     INNER JOIN sc_ww_kdloginaktivkz_ver b
                         ON (    a.dwh_id = b.dwh_id_head
                             AND &termin BETWEEN b.dwh_valid_from
                                             AND b.dwh_valid_to)
             ) sc_ww_kdloginaktivkz
                  ON (mv.dwh_id_sc_ww_kdloginaktivkz = sc_ww_kdloginaktivkz.dwh_id)
    LEFT OUTER JOIN
             (SELECT a.dwh_id,
                     kz,
                     dwh_id_cc_kontosperre
                FROM sc_ww_kontosperre a
                     INNER JOIN sc_ww_kontosperre_ver b
                         ON (    a.dwh_id = b.dwh_id_head
                             AND &termin BETWEEN b.dwh_valid_from
                                             AND b.dwh_valid_to)
             ) sc_ww_kontosperre
                  ON (mv.dwh_id_sc_ww_kontosperre = sc_ww_kontosperre.dwh_id)
    LEFT OUTER JOIN
             (SELECT a.dwh_id,
                     id,
                     fgnr,
                     dwh_id_cc_fg
                FROM sc_ww_fg a
                     INNER JOIN sc_ww_fg_ver b
                         ON (    a.dwh_id = b.dwh_id_head
                             AND &termin BETWEEN b.dwh_valid_from
                                             AND b.dwh_valid_to)
             ) sc_ww_fg
                  ON (mv.dwh_id_sc_ww_fg = sc_ww_fg.dwh_id)
    LEFT OUTER JOIN
             (SELECT a.dwh_id,
                     wunschkz,
                     dwh_id_cc_filialwerbungwunsch
                FROM sc_ww_wunschkzidfilialwerb a
                     INNER JOIN sc_ww_wunschkzidfilialwerb_ver b
                         ON (    a.dwh_id = b.dwh_id_head
                             AND &termin BETWEEN b.dwh_valid_from
                                             AND b.dwh_valid_to)
             ) sc_ww_wunschfilialwerb
                  ON (mv.dwh_id_sc_ww_wunschkzidfilialwerb = sc_ww_wunschfilialwerb.dwh_id)
    LEFT OUTER JOIN
             (SELECT a.dwh_id,
                     dwh_id_cc_janein AS dwh_id_cc_vorteilsnrangabe
                FROM sc_ww_adrausvorteilsnr a
                     INNER JOIN sc_ww_adrausvorteilsnr_ver b
                         ON (    a.dwh_id = b.dwh_id_head
                             AND &termin BETWEEN b.dwh_valid_from
                                             AND b.dwh_valid_to)
             ) sc_ww_adrausvorteilsnr
                  ON (mv.dwh_id_sc_ww_adrausvorteilsnr = sc_ww_adrausvorteilsnr.dwh_id)
    LEFT OUTER JOIN
             (SELECT a.dwh_id,
                     dwh_id_cc_janein AS dwh_id_cc_emailvorhanden
                FROM sc_ww_emailvorhanden a
                     INNER JOIN sc_ww_emailvorhanden_ver b
                         ON (    a.dwh_id = b.dwh_id_head
                             AND &termin BETWEEN b.dwh_valid_from
                                             AND b.dwh_valid_to)
             ) sc_ww_emailvorhanden
                  ON (mv.dwh_id_sc_ww_emailvorhanden = sc_ww_emailvorhanden.dwh_id)
    LEFT OUTER JOIN
             (SELECT a.dwh_id,
                     dwh_id_cc_janein AS dwh_id_cc_mobilnrvorhanden
                FROM sc_ww_handyvorhanden a
                     INNER JOIN sc_ww_handyvorhanden_ver b
                         ON (    a.dwh_id = b.dwh_id_head
                             AND &termin BETWEEN b.dwh_valid_from
                                             AND b.dwh_valid_to)
             ) sc_ww_handyvorhanden
                  ON (mv.dwh_id_sc_ww_handyvorhanden = sc_ww_handyvorhanden.dwh_id)
    LEFT OUTER JOIN
             (SELECT a.dwh_id,
                     dwh_id_cc_janein AS dwh_id_cc_gebdatverweigert
                FROM sc_ww_gebdatstatus a
                     INNER JOIN sc_ww_gebdatstatus_ver b
                         ON (    a.dwh_id = b.dwh_id_head
                             AND &termin BETWEEN b.dwh_valid_from
                                             AND b.dwh_valid_to)
             ) sc_ww_gebdatstatus
                  ON (mv.dwh_id_sc_ww_gebdatstatus = sc_ww_gebdatstatus.dwh_id)
    LEFT OUTER JOIN
             (SELECT a.dwh_id,
                     dwh_id_cc_janein AS dwh_id_cc_telefonvorhanden
                FROM sc_ww_telefonprivatvorhanden a
                     INNER JOIN sc_ww_telefonprivatvorhanden_ver b
                         ON (    a.dwh_id = b.dwh_id_head
                             AND &termin BETWEEN b.dwh_valid_from
                                             AND b.dwh_valid_to)
             ) sc_ww_telefonprivatvorhanden
                  ON (mv.dwh_id_sc_ww_telefonprivatvorhanden = sc_ww_telefonprivatvorhanden.dwh_id)        
    LEFT OUTER JOIN
             (SELECT a.dwh_id,
                     dwh_id_cc_janein AS dwh_id_cc_postfach
                FROM sc_ww_postfach a
                     INNER JOIN sc_ww_postfach_ver b
                         ON (    a.dwh_id = b.dwh_id_head
                             AND &termin BETWEEN b.dwh_valid_from
                                             AND b.dwh_valid_to)
             ) sc_ww_postfach
                  ON (mv.dwh_id_sc_ww_postfach = sc_ww_postfach.dwh_id)   
    LEFT OUTER JOIN
             (SELECT a.dwh_id,
                     dwh_id_cc_janein AS dwh_id_cc_datenschutzkonto
                FROM sc_ww_datenschutz a
                     INNER JOIN sc_ww_datenschutz_ver b
                         ON (    a.dwh_id = b.dwh_id_head
                             AND &termin BETWEEN b.dwh_valid_from
                                             AND b.dwh_valid_to)
             ) sc_ww_datenschutz
                  ON (mv.dwh_id_sc_ww_datenschutz = sc_ww_datenschutz.dwh_id)                    
    LEFT OUTER JOIN
             (SELECT a.dwh_id,
                     dwh_id_cc_eigenfremdkauf AS dwh_id_cc_eigenfremdkauf
                FROM sc_ww_eigenfremdkaufkz a
                     INNER JOIN sc_ww_eigenfremdkaufkz_ver b
                         ON (    a.dwh_id = b.dwh_id_head
                             AND &termin BETWEEN b.dwh_valid_from
                                             AND b.dwh_valid_to)
             ) sc_ww_eigenfremdkaufkz
                  ON (mv.dwh_id_sc_ww_eigenfremdkaufkz = sc_ww_eigenfremdkaufkz.dwh_id)
    LEFT OUTER JOIN
             (SELECT a.dwh_id,
                     dwh_id_cc_serviceinfoversand AS dwh_id_cc_serviceinfoversand
                FROM sc_ww_serviceinforechnungversandkz a
                     INNER JOIN sc_ww_serviceinforechnungversandkz_ver b
                         ON (    a.dwh_id = b.dwh_id_head
                             AND &termin BETWEEN b.dwh_valid_from
                                             AND b.dwh_valid_to)
             ) sc_ww_serviceinforechnungversandkz
                  ON (mv.dwh_id_sc_ww_serviceinforechnungversandkz = sc_ww_serviceinforechnungversandkz.dwh_id)
   WHERE mv.kundeid_key NOT IN ('$','§') 
     AND mv.konto_id_key != '$'
     AND kundenfirma.kdfirmkz NOT IN (200)
;

--     AND COALESCE(mv.testgrp,'NULL') NOT IN ('TG','$')                                                                    
--     AND mv.konto_id_key NOT IN ('EBB7BDD1CB47451FA115EE23E031753F','3ECFAAF39D9DFCFF5B014AFB503E604C')
    ;
  
     --AND kundenfirma.kdfirmkz not in (23);

   COMMIT;


  EXEC PKG_STATS.GATHERTABLE (user, 'clcc_ww_kunde_2');
  
  /*
  Achtung ! Es kann sein, dass ein Kunde mehr Adressen hat, z.b. aus Oesterreich und aus Deutschland.
  Dann nur die Adresse nehmen, welche er laut Heimatland auch wirklich hat.
  */
   
  TRUNCATE TABLE clcc_ww_kunde_2_d;
  
  INSERT /*+APPEND*/ INTO clcc_ww_kunde_2_d
  (
   dwh_cr_load_id,    
   konto_id_key,
   firma   
  )
  SELECT 
   &gbvid,   
   konto_id_key,
   firma 
  FROM clcc_ww_kunde_2 
  GROUP BY konto_id_key, firma 
  HAVING COUNT(*) > 1;

  COMMIT;

  PROMPT doppelte...

  SELECT COUNT(*) FROM clcc_ww_kunde_2_d;

--  DELETE FROM clcc_ww_kunde_2,21
  DELETE FROM clcc_ww_kunde_2
  WHERE (konto_id_key, firma) IN (SELECT konto_id_key, firma FROM clcc_ww_kunde_2_d) AND CASE WHEN firma IN (1,3,6,8,18,21) THEN 'DE'
         WHEN firma IN (2,9) THEN 'CH'
         WHEN firma IN (5,12) THEN 'AT'
         WHEN firma IN (13) THEN 'IT'
         WHEN firma IN (14) THEN 'UA' ELSE 'Sonstige' END != COALESCE(ursprungsland,'Sonstige');

  COMMIT;


  -- Saisonwechsel-Hack --> noetig, da ueber den Saisonwechsel Kunden anlaufen koennen, muessen auch mit rein
  -- LADEDATUM wird dem aktuellen Termindatum angepasst, damit diese mit eingeladen werden. Beim Saisonwechsel wandern nämlich nur die aktiven Kunden aus der letzten Saison mit. Alle
  -- die "dazwischen" auflaufen, würden somit verloren gehen. 
  MERGE INTO clcc_ww_kunde_2 a
  USING 
      (
       SELECT DISTINCT TO_CHAR(konto_id_key) konto_id_key, 
                       firma
       FROM clcc_ww_kunde_2 
       WHERE firma NOT IN (4, 7, 16, 24, 26) --AND vtinfo_edv IS NOT NULL
       MINUS
       SELECT DISTINCT TO_CHAR(konto_id_key) konto_id_key, 
                       b.sg AS firma
       FROM cc_kunde_&vtsaison a INNER JOIN cc_firma_waepumig_v b ON (a.firma = b.wert AND &termin BETWEEN b.dwh_valid_from AND b.dwh_valid_to)
       WHERE a.dwh_status in (1,2) AND a.kontoart IN (1,5)
      ) b
  ON (a.konto_id_key = b.konto_id_key and a.firma = b.firma)
  WHEN MATCHED THEN 
    UPDATE 
      SET a.ladedatum = &termin
  WHERE TO_CHAR(a.ladedatum, 'hh24:mi:ss') = '12:00:00'  -- Die Urladung wird immer um 12 Uhr ausgefuehrt.   
   --AND TRUNC(a.ladedatum) = TRUNC(&termin)
   ;

  COMMIT;


  PROMPT =========================================================
  PROMPT 2.1 Statistiken und Index
  PROMPT =========================================================

  CREATE UNIQUE INDEX clcc_ww_kunde_2_ix1 ON clcc_ww_kunde_2 (firma, konto_id_key) TABLESPACE udwh_cl_01_ts;

  EXEC PKG_STATS.GATHERTABLE (user, 'clcc_ww_kunde_2');


  PROMPT ===========================================
  PROMPT
  PROMPT 2.2 Kopie der ext. sst auf udwh erstellen
  PROMPT  Abhaengigkeit vom Praxissytem
  PROMPT
  PROMPT ===========================================

  DROP INDEX clcc_ww_kunde_24_ix1;

  TRUNCATE TABLE clcc_ww_kunde_24;

  INSERT /*+APPEND*/ INTO clcc_ww_kunde_24 (
   dwh_cr_load_id,
   konto_id_key,
   dwh_valid_from,
   dwh_valid_to,
   firma,
   bklneu,
   altjung_aktneu,
   altjung_folgeneu,
   anlsaison_reaneu,
   anlcode_reaneu,
   online_testneu,
   nixikzneu,
   wkzneu,
   iwlneu,
   anlcodeneu,
   vtinfogruppeneu,
   anlsaisonneu,
   nlabostatusneu,
   nlanldatumneu,
   anlwegneu,
   anzbestellungenneu,
   bbwneu,
   datletztebestneu,
   lanzbestellungenneu,
   lbbwneu,
   lnumsneu,
   numsneu,
   retourenneu,
   ueberschneidungskzneu,
   anldatumneu,
   altwabkzneu,
   appauftrdaterstneu
  )
  SELECT
   &gbvid,
   konto_id_key,
   dwh_valid_from,
   dwh_valid_to,
   CASE WHEN firma = 68 THEN 18 ELSE firma END AS firma, --- falls jemand in externe SST noch die alte 68 einspielt
   bklneu,
   altjung_aktneu,
   altjung_folgeneu,
   anlsaison_reaneu,
   anlcode_reaneu,
   online_testneu,
   nixikzneu,
   wkzneu,
   iwlneu,
   anlcodeneu,
   vtinfogruppeneu,
   anlsaisonneu,
   nlabostatusneu,
   nlanldatumneu,
   anlwegneu,
   anzbestellungenneu,
   bbwneu,
   datletztebestneu,
   lanzbestellungenneu,
   lbbwneu,
   lnumsneu,
   numsneu,
   retourenneu,
   ueberschneidungskzneu,
   anldatumneu,
   altwabkzneu,
   appauftrdaterstneu
  FROM
    sc_stammattr a INNER JOIN sc_stammattr_ver b          
          ON (a.dwh_id = b.dwh_id_head AND TRUNC(dwh_valid_from) = TRUNC(&termin))
  WHERE b.firma NOT IN (7,16,24,66,69);
  
  COMMIT;

  CREATE UNIQUE INDEX clcc_ww_kunde_24_ix1 ON clcc_ww_kunde_24 (konto_id_key) TABLESPACE udwh_cl_01_ts;

  EXEC PKG_STATS.GATHERTABLE (user, 'clcc_ww_kunde_24');


  PROMPT ===========================================
  PROMPT
  PROMPT 2.3 Hilfstabelle mit allen Kunden die einen tagesaktuellen Bewegungsdatensatz aufweisen
  PROMPT
  PROMPT ===========================================

  TRUNCATE TABLE clcc_ww_kunde_3;

  DROP INDEX clcc_ww_kunde_3_ix1;

  INSERT /*+APPEND */
  INTO
   clcc_ww_kunde_3
   (
   dwh_cr_load_id,
   firma,
   konto_id_key
   )
  SELECT
   DISTINCT
    &gbvid,
    b.sg AS firma,
    konto_id_key
  FROM
   cc_buchung a INNER JOIN cc_firma_waepumig_v b ON (a.firma = b.wert AND &termin BETWEEN b.dwh_valid_from AND b.dwh_valid_to)
  WHERE a.buchdat = &datum AND b.sg NOT IN (7,16,24,69,66,65) AND b.sg < 100 -- Alles außer Frankreich, Russland und USA
    AND b.sg NOT IN (60,61,62,63) -- Cross Selling Heine raus
  ;

  COMMIT;

  CREATE UNIQUE INDEX clcc_ww_kunde_3_ix1 ON clcc_ww_kunde_3 (konto_id_key) TABLESPACE udwh_cl_01_ts;

  EXEC PKG_STATS.GATHERTABLE (user, 'clcc_ww_kunde_3');

  PROMPT ===========================================
  PROMPT
  PROMPT 3. Aenderungsdatensaetze aus allen Quellen sammeln
  PROMPT
  PROMPT ===========================================

  DROP INDEX clcc_ww_kunde_4_ix1;
  DROP INDEX clcc_ww_kunde_4_ix2;

  TRUNCATE TABLE clcc_ww_kunde_4;

  PROMPT ===========================================
  PROMPT
  PROMPT 3.1 Kunden mit geaenderten Stammdaten
  PROMPT
  PROMPT ===========================================

  INSERT /*+ APPEND */
  INTO
   clcc_ww_kunde_4
   (
    dwh_cr_load_id,
    firma,
    konto_id_key,
    wkz,
    iwl,
    anlagedatum,
    anlsaison,
    bkl,
    emailverweigertkz,
    plz,
    email_vorhanden,
    email_hash,
    gebdatum,
    kundenart,
    landnr,
    kontosperre,
    anrede,
    flag
   )
  SELECT
    dwh_cr_load_id,
    firma,
    konto_id_key,
    wkz,
    iwl,
    anldatum,
    anlsaison,
    bkl,
    emailverweigertkz,
    plz,
    email_vorhanden,
    email_hash,
    gebdatum,
    kundenart,
    landnr,
    kontosperre,
    anrede,
    110000 AS flag
  FROM
   clcc_ww_kunde_2
  WHERE
   --(   
   (
   firma NOT IN (4, 7, 16, 24) -- England und Frankreich
   )  
   AND TRUNC(ladedatum) = TRUNC(&termin)
     AND TO_CHAR(ladedatum, 'hh24:mi:ss') != '00:00:00'  -- damit wird verhindert, dass beim Saisonwechsel die Urladung mit reinkommt
     --AND kundeid_key IN (SELECT id_key FROM sc_ww_kunde_delta)
   -- )
  --  OR firma = 44
   ;
  
   COMMIT;
   

  PROMPT ===========================================
  PROMPT
  PROMPT 3.2 Kunden mit aktuellen Bewegungsdaten (cc_buchung) z.b. ansprwert
  PROMPT
  PROMPT ===========================================

  MERGE INTO
   clcc_ww_kunde_4 a
  USING
   (
   SELECT
    dwh_cr_load_id,
    firma,
    konto_id_key,
    wkz,
    iwl,
    anldatum,
    anlsaison,
    bkl,
    emailverweigertkz,
    plz,
    email_vorhanden,
    email_hash,
    gebdatum,
    kundenart,
    landnr,
    kontosperre,
    anrede,
   101000 AS flag
   FROM
   clcc_ww_kunde_2 k
   WHERE
   (
   k.firma NOT IN (4, 7, 16, 24, 26) -- England und Frankreich
   --AND k.vtinfo_edv IS NOT NULL -- Internetbesteller die Bestellung abbrechen
   )
   AND
   -- Kunden mit aktuellen Bewegungsdaten (KDUMS) z.B. BBW
   (
   (k.konto_id_key, k.firma) IN (
                                 SELECT DISTINCT c.konto_id_key,
                                                 c.firma
                                 FROM clcc_ww_kunde_3 c
                                 )
   )
   ) b
  ON ( a.konto_id_key = b.konto_id_key AND a.firma = b.firma )
  WHEN MATCHED THEN UPDATE
  SET
   a.flag = a.flag + 1000
  WHEN NOT MATCHED THEN
  INSERT
  (
    dwh_cr_load_id,
    firma,
    konto_id_key,
    wkz,
    iwl,
    anlagedatum,
    anlsaison,
    bkl,
    emailverweigertkz,
    plz,
    email_vorhanden,
    email_hash,
    gebdatum,
    kundenart,
    landnr,
    kontosperre,
    anrede,
    flag
   )
   VALUES
  (
    b.dwh_cr_load_id,
    b.firma,
    b.konto_id_key,
    b.wkz,
    b.iwl,
    b.anldatum,
    b.anlsaison,
    b.bkl,
    b.emailverweigertkz,
    b.plz,
    b.email_vorhanden,
    b.email_hash,
    b.gebdatum,
    b.kundenart,
    b.landnr,
    b.kontosperre,
    b.anrede,
    b.flag
  );

  COMMIT;


  PROMPT ===========================================
  PROMPT
  PROMPT 3.3 Kunden einfuegen mit geaenderten Attributen durch "ext. prozesse"
  PROMPT (welche Kunden werden durch die ext. Schnittstelle upgedated?)
  PROMPT
  PROMPT ===========================================

  TRUNCATE TABLE clcc_ww_kunde_5;

  -- Insert aller aktuell gueltigen Aenderungen
  INSERT /*+APPEND*/ INTO clcc_ww_kunde_5
  (
   dwh_cr_load_id,
   altjung_aktneu,
   altjung_folgeneu,
   altwabkzneu,
   anlcode_reaneu,
   anlcodeneu,
   anldatumneu,
   anlsaison_reaneu,
   anlsaisonneu,
   anlwegneu,
   anzbestellungenneu,
   appauftrdaterstneu,
   bbwneu,
   bklneu,
   datletztebestneu,
   firma,
   iwlneu,
   konto_id_key,
   lanzbestellungenneu,
   lbbwneu,
   lnumsneu,
   nixikzneu,
   nlabostatusneu,
   nlanldatumneu,
   numsneu,
   online_testneu,
   ueberschneidungskzneu,
   retourenneu,
   vtinfogruppeneu,
   wkzneu
  )
  SELECT
   &gbvid,
   altjung_aktneu,
   altjung_folgeneu,
   altwabkzneu,
   anlcode_reaneu,
   anlcodeneu,
   anldatumneu,
   anlsaison_reaneu,
   anlsaisonneu,
   anlwegneu,
   anzbestellungenneu,
   appauftrdaterstneu,
   bbwneu, 
   bklneu,
   datletztebestneu,
   firma,
   iwlneu,
   konto_id_key,
   lanzbestellungenneu,
   lbbwneu,
   lnumsneu,
   nixikzneu,
   nlabostatusneu,
   nlanldatumneu,
   numsneu,
   online_testneu,
   ueberschneidungskzneu,
   retourenneu,
   vtinfogruppeneu,
   wkzneu
  FROM clcc_ww_kunde_24
  WHERE &termin BETWEEN dwh_valid_from AND dwh_valid_to AND firma NOT IN (7,16,24,66,69)
  AND (
  ( bklneu <> -1 )
  OR
  ( altjung_aktneu <> -1 )
  OR
  ( altjung_folgeneu <> -1 )
  OR
  ( anlsaison_reaneu <> -1 )
  OR
  ( anlcode_reaneu <> '-1' )
  OR
  ( online_testneu <> -1 )
  OR
  ( nixikzneu <> -1 )
  OR
  ( wkzneu <> -1 )
  OR
  ( iwlneu <> -1 )
  OR
  ( NVL(anlcodeneu,9999) <> -1 ) -- es kann vorkommen, dass anlcode = null upgedated werden soll, daher NVL
  OR
  ( vtinfogruppeneu <> -1 )
  OR
  ( anlsaisonneu <> -1 )
  OR
  ( nlabostatusneu <> -1 )
  OR
  ( nlanldatumneu  <>  TO_DATE('01.02.1900 00:00:00', 'dd.mm.rrrr hh24:mi:ss'))
  OR
  ( anlwegneu <> -1 )
  OR
  ( anzbestellungenneu <> -1 )
  OR
  ( bbwneu <> -1 )
  OR
  ( datletztebestneu <>  TO_DATE('01.02.1900 00:00:00', 'dd.mm.rrrr hh24:mi:ss'))
  OR
  ( lanzbestellungenneu <> -1 )
  OR
  ( lbbwneu <> -1 )
  OR
  ( lnumsneu <> -1 )
  OR
  ( numsneu <> -1 )
  OR
  ( retourenneu <> -1 )  
  OR
  ( ueberschneidungskzneu <> -1 )
  OR
  ( anldatumneu <>  TO_DATE('01.02.1900 00:00:00', 'dd.mm.rrrr hh24:mi:ss'))
  OR
  ( altwabkzneu <> '-1' )
  OR
  ( appauftrdaterstneu <> TO_DATE('01.02.1900 00:00:00', 'dd.mm.rrrr hh24:mi:ss'))
  );

  COMMIT;

  -- Identifizieren aller tatsaechlichen Aenderungen. Vergleich mit der Vortages-Stamm
  -- -1/24/60/60 relevant bei nachtraeglichen Selektionen, da ja mittlerweile schon nachgelagerte Datensaetze kommen.
  TRUNCATE TABLE clcc_ww_kunde_6;

  INSERT /*+APPEND*/ INTO clcc_ww_kunde_6
  (
    konto_id_key,
    firma
  )
  SELECT DISTINCT
    a.konto_id_key,
    a.firma
  FROM
    clcc_ww_kunde_5 a,
  (
  SELECT
    adresshdl,
    konto_id_key,
    TO_CHAR(cc_anlaktionscoderea.sg) AS anlcode_rea,
    CASE WHEN cc_anlvtsaisonrea.sg != '-3' THEN TO_NUMBER('20' || substr(cc_anlvtsaisonrea.sg,2,2) || substr(cc_anlvtsaisonrea.sg,1,1)) ELSE 0 END AS anlsaison_rea,
    TO_NUMBER(SUBSTR(cc_onlinetest.sg,5,3)) AS online_test,
    TO_CHAR(anlweg1) AS wkz,
    anlweg2 AS iwl,
    TO_NUMBER(COALESCE(cc_vtinfogrp.sg,0)) AS vtinfogrp,
    TO_NUMBER(COALESCE(cc_imvtinfogrp.sg,0)) AS imvtinfogrp,
    TO_NUMBER(cc_vtsaison.sg) AS anlvtsaison,
    emailanldat AS nlanldatum,
    anzauftr AS anzbestellungen,
    ansprwert AS bbw,
    letztauftrdat AS datletztebest,
    lansprwert AS lbbw,
    lretwert AS lretouren,
    lnumswert AS lnums,
    lanzauftr AS lanzbestellungen,
    numswert AS nums,
    retwert AS retouren,
    anldat AS anldatum,
    CASE WHEN cc_imaltwabherk.sg = 'NULL' THEN NULL ELSE cc_imaltwabherk.sg END AS imaltwabherkunft,
    TO_NUMBER(cc_firma.sg) AS firma,
    TO_NUMBER(cc_kdart.sg) AS kundenart,
    TO_NUMBER(cc_kontosperre.sg) AS kontosperre,
    TO_NUMBER(cc_zustelldienst.sg) AS versandkz,
    TO_NUMBER(cc_ersartwunsch.sg) AS ersatzartkz,
    TO_NUMBER(cc_nachbarabg.sg) AS nachbarkz,
    TO_NUMBER(cc_adresshdl.sg) AS adrhdlkz,
    TO_NUMBER(CASE WHEN cc_werbemittelsperre.sg LIKE '4%' THEN '4' ELSE cc_werbemittelsperre.sg END) AS werbemittelsperre,
    TO_NUMBER(cc_telemarkwunsch.sg) AS telemarkkz,
    CASE WHEN cc_altwabherkunft.sg = 'NULL' THEN NULL ELSE cc_altwabherkunft.sg END AS altwabkz,
    TO_NUMBER(CASE WHEN cc_ostwest.sg = 'NULL' THEN NULL ELSE cc_ostwest.sg END)  AS vtgebiet,
    TO_NUMBER(cc_nlwunsch.sg) AS nlkz,
    TO_NUMBER(CASE WHEN cc_emailherkunft.sg LIKE 'NULL%' THEN '0' ELSE cc_emailherkunft.sg END) AS nladressherkunft,
    TO_NUMBER(cc_nlabostatus.sg) AS nlabostatus,
    TO_NUMBER(cc_nltyp.sg) AS nltyp,
    TO_NUMBER(CASE WHEN cc_kdloginaktiv.sg = 'NULL' THEN NULL ELSE cc_kdloginaktiv.sg END) AS kdloginaktivkz,
    cc_bonikl.sg AS bkl,
    TO_NUMBER(cc_anlauftrart.sg) AS anlweg,
    TO_NUMBER(cc_altjung_akt.sg) AS altjung_akt,
    TO_NUMBER(cc_altjung_folge.sg) AS altjung_folge,
    TO_NUMBER(cc_mehrlinien.sg) AS mehrlinien,
    TO_NUMBER(CASE WHEN cc_anlaktionscode.sg LIKE 'NULL%' THEN NULL ELSE cc_anlaktionscode.sg END) AS anlaktionscode,
    TO_NUMBER(cc_nixi.sg) AS nixikz,
    TO_NUMBER(cc_ueberschneider.sg) AS ueberschneider,
    TO_NUMBER(CASE WHEN cc_servicemailaktiv.sg LIKE 'NULL%' THEN '0' ELSE cc_servicemailaktiv.sg END) AS servicemailaktiv,
    appauftrdaterst AS appauftrdaterst
   FROM cc_kunde_&vtsaison cc_kunde
    LEFT JOIN cc_adresshdl       ON  cc_kunde.adresshdl = cc_adresshdl.wert AND &termin BETWEEN cc_adresshdl.dwh_valid_from AND cc_adresshdl.dwh_valid_to
    LEFT JOIN cc_altjung cc_altjung_akt  ON cc_kunde.altjungakt = cc_altjung_akt.wert  AND &termin BETWEEN cc_altjung_akt.dwh_valid_from AND cc_altjung_akt.dwh_valid_to
    LEFT JOIN cc_altjung cc_altjung_folge ON cc_kunde.altjungfolge = cc_altjung_folge.wert  AND &termin BETWEEN cc_altjung_folge.dwh_valid_from AND cc_altjung_folge.dwh_valid_to
    LEFT JOIN cc_altwabherkunft      ON cc_kunde.altwabherkunft = cc_altwabherkunft.wert  AND &termin BETWEEN cc_altwabherkunft.dwh_valid_from AND cc_altwabherkunft.dwh_valid_to
    LEFT JOIN cc_anlauftrart      ON cc_kunde.anlauftrart = cc_anlauftrart.wert  AND &termin BETWEEN cc_anlauftrart.dwh_valid_from AND cc_anlauftrart.dwh_valid_to
    LEFT JOIN cc_anlvtsaisonrea  cc_anlvtsaisonrea ON cc_kunde.anlvtsaisonrea = cc_anlvtsaisonrea.wert AND &termin BETWEEN cc_anlvtsaisonrea.dwh_valid_from AND cc_anlvtsaisonrea.dwh_valid_to
    LEFT JOIN cc_anlaktionscode       ON cc_kunde.anlaktionscode = cc_anlaktionscode.wert  AND &termin BETWEEN cc_anlaktionscode.dwh_valid_from AND cc_anlaktionscode.dwh_valid_to
    LEFT JOIN cc_anlaktionscoderea    ON cc_kunde.anlaktionscoderea = cc_anlaktionscoderea.wert  AND &termin BETWEEN cc_anlaktionscoderea.dwh_valid_from AND cc_anlaktionscoderea.dwh_valid_to
    LEFT JOIN cc_bonikl       ON cc_kunde.bonikl = cc_bonikl.wert  AND &termin BETWEEN cc_bonikl.dwh_valid_from AND cc_bonikl.dwh_valid_to
    LEFT JOIN cc_emailherkunft      ON cc_kunde.emailherkunft = cc_emailherkunft.wert  AND &termin BETWEEN cc_emailherkunft.dwh_valid_from AND cc_emailherkunft.dwh_valid_to
    LEFT JOIN cc_ersartwunsch       ON cc_kunde.ersartwunsch = cc_ersartwunsch.wert  AND &termin BETWEEN cc_ersartwunsch.dwh_valid_from AND cc_ersartwunsch.dwh_valid_to
    LEFT JOIN cc_firma_waepumig_v cc_firma          ON cc_kunde.firma = cc_firma.wert AND &termin BETWEEN cc_firma.dwh_valid_from AND cc_firma.dwh_valid_to
    LEFT JOIN cc_imaltwabherkunft cc_imaltwabherk     ON cc_kunde.imaltwabherkunft = cc_imaltwabherk.wert AND &termin BETWEEN cc_imaltwabherk.dwh_valid_from AND cc_imaltwabherk.dwh_valid_to
    LEFT JOIN cc_vtinfogrp cc_imvtinfogrp ON cc_kunde.imvtinfogrp = cc_imvtinfogrp.wert AND &termin BETWEEN cc_imvtinfogrp.dwh_valid_from AND cc_imvtinfogrp.dwh_valid_to
    LEFT JOIN cc_kdloginaktiv      ON cc_kunde.kdloginaktiv = cc_kdloginaktiv.wert AND &termin BETWEEN cc_kdloginaktiv.dwh_valid_from AND cc_kdloginaktiv.dwh_valid_to
    LEFT JOIN cc_kontosperre         ON cc_kunde.kontosperre = cc_kontosperre.wert AND &termin BETWEEN cc_kontosperre.dwh_valid_from AND cc_kontosperre.dwh_valid_to
    LEFT JOIN cc_kdart       ON cc_kunde.kdart = cc_kdart.wert AND &termin BETWEEN cc_kdart.dwh_valid_from AND  cc_kdart.dwh_valid_to
    LEFT JOIN cc_mahnebene       ON cc_kunde.mahnebene = cc_mahnebene.wert AND &termin BETWEEN cc_mahnebene.dwh_valid_from AND cc_mahnebene.dwh_valid_to
    LEFT JOIN cc_mahnstrang     ON cc_kunde.mahnstrang = cc_mahnstrang.wert AND &termin BETWEEN cc_mahnstrang.dwh_valid_from AND cc_mahnstrang.dwh_valid_to
    LEFT JOIN cc_mehrlinien      ON cc_kunde.mehrlinien = cc_mehrlinien.wert AND &termin BETWEEN cc_mehrlinien.dwh_valid_from AND cc_mehrlinien.dwh_valid_to
    LEFT JOIN cc_nachbarabg     ON cc_kunde.nachbarabg = cc_nachbarabg.wert AND &termin BETWEEN cc_nachbarabg.dwh_valid_from AND cc_nachbarabg.dwh_valid_to
    LEFT JOIN cc_nixi       ON cc_kunde.nixi = cc_nixi.wert AND &termin BETWEEN cc_nixi.dwh_valid_from AND cc_nixi.dwh_valid_to
    LEFT JOIN cc_nlabostatus      ON cc_kunde.nlabostatus = cc_nlabostatus.wert AND &termin BETWEEN cc_nlabostatus.dwh_valid_from AND cc_nlabostatus.dwh_valid_to
    LEFT JOIN cc_nltyp      ON cc_kunde.nltyp = cc_nltyp.wert AND &termin BETWEEN cc_nltyp.dwh_valid_from AND cc_nltyp.dwh_valid_to
    LEFT JOIN cc_nlwunsch      ON cc_kunde.nlwunsch = cc_nlwunsch.wert AND &termin BETWEEN cc_nlwunsch.dwh_valid_from AND cc_nlwunsch.dwh_valid_to
    LEFT JOIN cc_onlinetest   ON cc_kunde.onlinetest = cc_onlinetest.wert AND &termin BETWEEN cc_onlinetest.dwh_valid_from AND cc_onlinetest.dwh_valid_to
    LEFT JOIN cc_ostwest      ON cc_kunde.ostwest = cc_ostwest.wert AND &termin BETWEEN cc_ostwest.dwh_valid_from AND cc_ostwest.dwh_valid_to
    LEFT JOIN cc_servicemailaktiv    ON cc_kunde.servicemailaktiv = cc_servicemailaktiv.wert AND &termin BETWEEN cc_servicemailaktiv.dwh_valid_from AND cc_servicemailaktiv.dwh_valid_to
    LEFT JOIN cc_telemarkwunsch     ON cc_kunde.telemarkwunsch = cc_telemarkwunsch.wert AND &termin BETWEEN cc_telemarkwunsch.dwh_valid_from AND cc_telemarkwunsch.dwh_valid_to
    LEFT JOIN cc_ueberschneider on cc_kunde.ueberschneider = cc_ueberschneider.wert  AND &termin BETWEEN cc_ueberschneider.dwh_valid_from AND cc_ueberschneider.dwh_valid_to
    LEFT JOIN cc_werbemittelsperre  ON cc_kunde.werbmitsperre = cc_werbemittelsperre.wert AND &termin BETWEEN cc_werbemittelsperre.dwh_valid_from AND cc_werbemittelsperre.dwh_valid_to
    LEFT JOIN cc_vtinfogrp ON cc_kunde.vtinfogrp = cc_vtinfogrp.wert AND &termin BETWEEN cc_vtinfogrp.dwh_valid_from AND cc_vtinfogrp.dwh_valid_to
    LEFT JOIN cc_vtsaison ON cc_kunde.anlvtsaison = cc_vtsaison.wert AND &termin BETWEEN cc_vtsaison.dwh_valid_from AND cc_vtsaison.dwh_valid_to
    LEFT JOIN cc_zustelldienst   ON cc_kunde.zustelldienst = cc_zustelldienst.wert AND &termin BETWEEN cc_zustelldienst.dwh_valid_from AND cc_zustelldienst.dwh_valid_to
   WHERE &termin - 1/24/60 BETWEEN cc_kunde.dwh_valid_from AND cc_kunde.dwh_valid_to
     AND kontoart IN (1,5)
   ) b
  WHERE a.konto_id_key = b.konto_id_key AND a.firma = b.firma
   AND (
   ( CASE WHEN a.bklneu = -1 THEN b.bkl ELSE a.bklneu END <> COALESCE(b.bkl,0) )
   OR
   ( CASE WHEN a.altjung_aktneu = -1 THEN b.altjung_akt ELSE a.altjung_aktneu  END <> COALESCE(b.altjung_akt,0) )
   OR
   ( CASE WHEN a.altjung_folgeneu = -1 THEN b.altjung_folge ELSE a.altjung_folgeneu END <> COALESCE(b.altjung_folge,0))
   OR
   ( CASE WHEN a.anlsaison_reaneu = -1 THEN b.anlsaison_rea ELSE a.anlsaison_reaneu END <> COALESCE(b.anlsaison_rea,0))
   OR
   ( CASE WHEN a.anlcode_reaneu = '-1' THEN TO_CHAR(b.anlcode_rea) ELSE TO_CHAR(a.anlcode_reaneu) END <> COALESCE(TO_CHAR(b.anlcode_rea),'0') )
   OR
   ( CASE WHEN a.online_testneu = -1 THEN b.online_test ELSE a.online_testneu END <> COALESCE(b.online_test,0) )
   OR
   ( CASE WHEN a.nixikzneu = -1 THEN b.nixikz ELSE a.nixikzneu END <> COALESCE(b.nixikz,0) )
   OR
   ( CASE WHEN TO_CHAR(a.wkzneu) = '-1' THEN TO_CHAR(b.wkz) ELSE TO_CHAR(a.wkzneu) END <> COALESCE(b.wkz,'0') )
   OR
   ( CASE WHEN a.iwlneu = -1 THEN b.iwl ELSE a.iwlneu END <> COALESCE(b.iwl,0) )
   OR
   ( CASE WHEN NVL(a.anlcodeneu,9999) = -1 THEN b.anlaktionscode ELSE NVL(a.anlcodeneu,9999)  END <> COALESCE(b.anlaktionscode,9999) ) -- es kann vorkommen, dass anlcode = null upgedated werden soll, daher NVL
   OR
   ( CASE WHEN a.vtinfogruppeneu = -1 THEN b.vtinfogrp ELSE a.vtinfogruppeneu END  <> COALESCE(b.vtinfogrp,0) )
   OR
   ( CASE WHEN a.anlsaisonneu = -1 THEN b.anlvtsaison ELSE a.anlsaisonneu END <> COALESCE(b.anlvtsaison,0) )
   OR
   ( CASE WHEN a.nlabostatusneu = -1 THEN b.nlabostatus ELSE a.nlabostatusneu END  <> COALESCE(b.nlabostatus,0) )
   OR
   ( CASE WHEN a.nlanldatumneu = TO_DATE('01.02.1900 00:00:00', 'dd.mm.rrrr hh24:mi:ss') THEN b.nlanldatum ELSE a.nlanldatumneu END  <>  COALESCE(b.nlanldatum, TO_DATE('01.02.1900 00:00:00', 'dd.mm.rrrr hh24:mi:ss')))
   OR
   ( CASE WHEN a.anlwegneu = -1 THEN b.anlweg ELSE a.anlwegneu END  <> COALESCE(b.anlweg,0 ))
   OR
   ( CASE WHEN a.anzbestellungenneu = -1 THEN b.anzbestellungen ELSE a.anzbestellungenneu END  <> COALESCE(b.anzbestellungen,0)  )
   OR
   ( CASE WHEN a.bbwneu = -1 THEN b.bbw ELSE a.bbwneu END  <> COALESCE(b.bbw,0 ) )
   OR
   ( CASE WHEN a.datletztebestneu = TO_DATE('01.02.1900 00:00:00', 'dd.mm.rrrr hh24:mi:ss') THEN b.datletztebest ELSE a.datletztebestneu END  <>  COALESCE(b.datletztebest,TO_DATE('01.02.1900 00:00:00', 'dd.mm.rrrr hh24:mi:ss')))
   OR
   ( CASE WHEN a.lanzbestellungenneu = -1 THEN b.lanzbestellungen ELSE a.lanzbestellungenneu END  <> COALESCE(b.lanzbestellungen,0) )
   OR
   ( CASE WHEN a.lbbwneu = -1 THEN b.lbbw ELSE a.lbbwneu END <> COALESCE(b.lbbw,0) )
   OR
   ( CASE WHEN a.lnumsneu = -1 THEN b.lnums ELSE a.lnumsneu END <> COALESCE(b.lnums,0) )
   OR
   ( CASE WHEN a.numsneu = -1 THEN  b.nums ELSE a.numsneu END <> COALESCE(b.nums ,0))
   OR
   ( CASE WHEN a.retourenneu = -1 THEN b.retouren ELSE a.retourenneu END <> COALESCE(b.retouren ,0))
   OR
   ( CASE WHEN a.ueberschneidungskzneu = -1 THEN b.ueberschneider ELSE a.ueberschneidungskzneu END <> COALESCE(b.ueberschneider ,0))
   OR
   ( CASE WHEN a.anldatumneu = TO_DATE('01.02.1900 00:00:00', 'dd.mm.rrrr hh24:mi:ss') THEN b.anldatum ELSE  a.anldatumneu END <>  COALESCE(b.anldatum,TO_DATE('01.02.1900 00:00:00', 'dd.mm.rrrr hh24:mi:ss')) )
   OR
   ( CASE WHEN a.appauftrdaterstneu = TO_DATE('01.02.1900 00:00:00', 'dd.mm.rrrr hh24:mi:ss') THEN b.appauftrdaterst ELSE  a.appauftrdaterstneu END <>  COALESCE(b.appauftrdaterst,TO_DATE('01.02.1900 00:00:00', 'dd.mm.rrrr hh24:mi:ss')) )
   OR
  ( CASE WHEN a.altwabkzneu = '-1' THEN TO_CHAR(b.imaltwabherkunft) ELSE TO_CHAR(a.altwabkzneu) END <> COALESCE(TO_CHAR(b.imaltwabherkunft),'0') )
   );

   COMMIT;

  -- Zu allen geaenderten Kunden aus der externen Schnittstelle werden die Kundenstammdaten geholt inklusive Flag
  TRUNCATE TABLE clcc_ww_kunde_7;

  INSERT /*+APPEND optimizer_features_enable ('10.2.0.1') */ INTO clcc_ww_kunde_7
   (
    dwh_cr_load_id,
    firma,
    konto_id_key,
    wkz,
    iwl,
    anldatum,
    anlsaison,
    bkl,
    emailverweigertkz,
    plz,
    email_vorhanden,
    email_hash,
    gebdatum,
    kundenart,
    landnr,
    kontosperre,
    anrede,
    flag
   )
  SELECT
   dwh_cr_load_id,
   firma,
   konto_id_key,
   wkz,
   iwl,
   anldatum,
   anlsaison,
   bkl,
   emailverweigertkz,
   plz,
   email_vorhanden,
   email_hash,
   gebdatum,
   kundenart,
   landnr,
   kontosperre,
   anrede,
   100010 AS flag
  FROM
   clcc_ww_kunde_2 k
  WHERE
     firma NOT IN (4, 7, 16, 24) -- England und Frankreich
      -- AND vtinfo_edv IS NOT NULL
   AND
   -- Kunden mit geaenderten Attributen durch "ext. Prozesse"
   (
   (konto_id_key, firma) IN (
                              SELECT DISTINCT
                                    konto_id_key,
                                    firma
                              FROM clcc_ww_kunde_6 x
                            )
   );
  
  COMMIT;
  
  EXEC PKG_STATS.GATHERTABLE(user,'clcc_ww_kunde_7');


  --  Jetzt nur diejenigen Aenderungen einspielen, fuer welche es tatsaechlich
  --  eine Neuerung gibt (siehe Sub-Select...)
  MERGE INTO
   clcc_ww_kunde_4 a
  USING
   clcc_ww_kunde_7 b
  ON ( a.konto_id_key = b.konto_id_key AND a.firma = b.firma )
  WHEN MATCHED THEN UPDATE
  SET
   a.flag = a.flag + 10
  WHEN NOT MATCHED THEN
  INSERT
   (
    dwh_cr_load_id,
    firma,
    konto_id_key,
    wkz,
    iwl,
    anlagedatum,
    anlsaison,
    bkl,
    emailverweigertkz,
    plz,
    email_vorhanden,
    email_hash,
    gebdatum,
    kundenart,
    landnr,
    kontosperre,
    anrede,
    flag
   )
  VALUES
   (
    b.dwh_cr_load_id,
    b.firma,
    b.konto_id_key,
    b.wkz,
    b.iwl,
    b.anldatum,
    b.anlsaison,
    b.bkl,
    b.emailverweigertkz,
    b.plz,
    b.email_vorhanden,
    b.email_hash,
    b.gebdatum,
    b.kundenart,
    b.landnr,
    b.kontosperre,
    b.anrede,
    b.flag
   );

  COMMIT;


  PROMPT ===========================================
  PROMPT
  PROMPT 3.4 Kunden aus Alina hinzufuegen
  PROMPT
  PROMPT ===========================================

  MERGE INTO
   clcc_ww_kunde_4 a
  USING
   (
   SELECT
    b.dwh_cr_load_id,
    b.firma,
    b.konto_id_key,
    b.wkz,
    b.iwl,
    b.anldatum,
    b.anlsaison,
    b.bkl,
    b.emailverweigertkz,
    b.plz,
    b.email_vorhanden,
    b.email_hash,
    b.gebdatum,
    b.kundenart,
    b.landnr,
    b.kontosperre,
    b.anrede,
   100001 AS flag
  FROM
   clcc_ww_kunde_2 b
  WHERE
  (
   b.firma NOT IN (4, 7, 16, 24) -- England und Frankreich
   --AND b.vtinfo_edv IS NOT NULL -- Internetbesteller die Bestellung abbrechen
  )
  AND
  -- Kunden aus Alina
  (
  (konto_id_key, firma) IN   
           (
               SELECT DISTINCT konto_id_key, 
                               firma
               FROM dm_f_alinav1
               WHERE vtsaison = &vtsaison
               AND ladedatum = &datum
           )
  )
  ) b
  ON ( a.konto_id_key = b.konto_id_key AND a.firma = b.firma )
  WHEN MATCHED THEN UPDATE
  SET
   a.flag = a.flag + 1
  WHEN NOT MATCHED THEN
  INSERT
   (
    dwh_cr_load_id,
    firma,
    konto_id_key,
    wkz,
    iwl,
    anlagedatum,
    anlsaison,
    bkl,
    emailverweigertkz,
    plz,
    email_vorhanden,
    email_hash,
    gebdatum,
    kundenart,
    landnr,
    kontosperre,
    anrede,
    flag
   )
  VALUES
   (
    b.dwh_cr_load_id,
    b.firma,
    b.konto_id_key,
    b.wkz,
    b.iwl,
    b.anldatum,
    b.anlsaison,
    b.bkl,
    b.emailverweigertkz,
    b.plz,
    b.email_vorhanden,
    b.email_hash,
    b.gebdatum,
    b.kundenart,
    b.landnr,
    b.kontosperre,
    b.anrede,
    b.flag
   );

  COMMIT;

  PROMPT ===========================================
  PROMPT
  PROMPT 3.5 Kunden aus OneTrust hinzufuegen
  PROMPT
  PROMPT ===========================================

  TRUNCATE TABLE clcc_ww_kunde_25;

  INSERT /*+APPEND*/ INTO clcc_ww_kunde_25
   (
    dwh_cr_load_id,
    konto_id_key,
    firma,
    email_hash
   )
  SELECT DISTINCT &gbvid, 
                  c.konto_id_key,
                  a.firma,
                  a.emailhash
  FROM sc_ex_aws_nlabostatusdaten a JOIN cc_firma_akt_v b ON a.firma = b.sg 
                                    JOIN cc_kunde_&vtsaison c ON b.wert = c.firma AND a.emailhash = c.emailhash AND &termin - 1/24/60 BETWEEN c.dwh_valid_from AND c.dwh_valid_to
  WHERE buchungsdatum >= (SELECT F_GET_LAST_LVDAT(&datum) FROM  dual)
  AND emailbounce IS NULL AND kontoart IN (1,5)
  ;

  COMMIT;

  MERGE INTO
   clcc_ww_kunde_4 a
  USING
   (
   SELECT
    b.dwh_cr_load_id,
    b.firma,
    b.konto_id_key,
    b.wkz,
    b.iwl,
    b.anldatum,
    b.anlsaison,
    b.bkl,
    b.emailverweigertkz,
    b.plz,
    b.email_vorhanden,
    b.email_hash,
    b.gebdatum,
    b.kundenart,
    b.landnr,
    b.kontosperre,
    b.anrede,
    100009 AS flag
  FROM
   clcc_ww_kunde_2 b
  WHERE
  (
   b.firma NOT IN (4, 7, 16, 24) -- England und Frankreich
   --AND b.vtinfo_edv IS NOT NULL -- Internetbesteller die Bestellung abbrechen
  )
  AND
  -- Kunden aus OneTrust
  (
  --(email_hash, firma) IN
  (konto_id_key, firma) IN
           (
               SELECT --DISTINCT email_hash, 
                      DISTINCT konto_id_key,
                               firma
               FROM clcc_ww_kunde_25
               --FROM sc_ex_aws_nlabostatusdaten
               --WHERE buchungsdatum >= (SELECT F_GET_LAST_LVDAT(&datum) FROM  dual)
               --AND emailbounce IS NULL
           )
  )
  ) b
  ON ( 
   --a.email_hash = b.email_hash AND 
   a.firma = b.firma AND a.konto_id_key = b.konto_id_key)
  WHEN NOT MATCHED THEN
  INSERT
   (
    dwh_cr_load_id,
    firma,
    konto_id_key,
    wkz,
    iwl,
    anlagedatum,
    anlsaison,
    bkl,
    emailverweigertkz,
    plz,
    email_vorhanden,
    email_hash,
    gebdatum,
    kundenart,
    landnr,
    kontosperre,
    anrede,
    flag
   )
  VALUES
   (
    b.dwh_cr_load_id,
    b.firma,
    b.konto_id_key,
    b.wkz,
    b.iwl,
    b.anldatum,
    b.anlsaison,
    b.bkl,
    b.emailverweigertkz,
    b.plz,
    b.email_vorhanden,
    b.email_hash,
    b.gebdatum,
    b.kundenart,
    b.landnr,
    b.kontosperre,
    b.anrede,
    b.flag
   );

  COMMIT;

 
  PROMPT ===========================================
  PROMPT
  PROMPT 3.6 Kunden aus Sprachen-FUP hinzufuegen
  PROMPT
  PROMPT ===========================================

  MERGE INTO
   clcc_ww_kunde_4 a
  USING
   (
   SELECT
    b.dwh_cr_load_id,
    b.firma,
    b.konto_id_key,
    b.wkz,
    b.iwl,
    b.anldatum,
    b.anlsaison,
    b.bkl,
    b.emailverweigertkz,
    b.plz,
    b.email_vorhanden,
    b.email_hash,
    b.gebdatum,
    b.kundenart,
    b.landnr,
    b.kontosperre,
    b.anrede,
    100010 AS flag
  FROM
   clcc_ww_kunde_2 b
  WHERE
  (
   b.firma NOT IN (4, 7, 16, 24) -- England und Frankreich
   --AND b.vtinfo_edv IS NOT NULL -- Internetbesteller die Bestellung abbrechen
  )
  AND
  -- Kunden aus OneTrust
  (
  (email_hash, firma) IN   
           (
             SELECT h.email_hash, 
                    h.firma
             FROM sc_fu_sprachkennzeichen h JOIN sc_fu_sprachkennzeichen_ver v ON (h.dwh_id = v.dwh_id_head AND v.dwh_valid_to = DATE '9999-12-31')
                                            JOIN sc_ww_sprache_ver sv ON (v.dwh_id_sc_ww_sprache = sv.dwh_id_head AND sv.dwh_valid_to = DATE '9999-12-31')
                                            JOIN cc_sprache cv ON (sv.dwh_id_cc_sprache = cv.dwh_id)        
             WHERE h.email_hash IS NOT NULL
               AND TRUNC(v.dwh_valid_from) = &datum
           )
  )
  ) b
  ON ( a.email_hash = b.email_hash AND a.firma = b.firma AND a.konto_id_key = b.konto_id_key)
  WHEN NOT MATCHED THEN
  INSERT
   (
    dwh_cr_load_id,
    firma,
    konto_id_key,
    wkz,
    iwl,
    anlagedatum,
    anlsaison,
    bkl,
    emailverweigertkz,
    plz,
    email_vorhanden,
    email_hash,
    gebdatum,
    kundenart,
    landnr,
    kontosperre,
    anrede,
    flag
   )
  VALUES
   (
    b.dwh_cr_load_id,
    b.firma,
    b.konto_id_key,
    b.wkz,
    b.iwl,
    b.anldatum,
    b.anlsaison,
    b.bkl,
    b.emailverweigertkz,
    b.plz,
    b.email_vorhanden,
    b.email_hash,
    b.gebdatum,
    b.kundenart,
    b.landnr,
    b.kontosperre,
    b.anrede,
    b.flag
   );

  COMMIT;



  PROMPT ================================================================================
  PROMPT 3.7 anldatum (bbw > 0) und anldatum-lv setzen
  PROMPT ================================================================================

   -- Alle schon existierenden Anldats, Anldatlvs und Kontoarten fuer Bestandskunden selektieren
  MERGE INTO clcc_ww_kunde_4 a
  USING (
         SELECT DISTINCT f.sg AS firma,
                         k.sg AS kontoart,
                         anldat,
                         anldatlv,
                         konto_id_key,
                         appauftrdaterst
         FROM cc_kunde_&vtsaison cc INNER JOIN cc_firma_waepumig_v f ON (cc.firma = f.wert AND &termin BETWEEN f.dwh_valid_from AND f.dwh_valid_to)
                                    INNER JOIN cc_kontoart k ON (cc.kontoart = k.wert AND &termin BETWEEN k.dwh_valid_from AND k.dwh_valid_to)
         WHERE &termin - 1/24/60 BETWEEN cc.dwh_valid_from AND cc.dwh_valid_to AND kontoart IN (1,5)
        ) b
  ON (a.konto_id_key = b.konto_id_key AND a.firma = b.firma)
  WHEN MATCHED THEN UPDATE
  SET
     a.anldatum = b.anldat,
     a.anldatumlv = b.anldatlv,
     a.appauftrdaterst = b.appauftrdaterst,
     a.kontoart = b.kontoart;

  COMMIT;

   -- Wenn anldatlv null ist, dann muss es ein Neukunde sein --> Prozessdatum setzen
  UPDATE clcc_ww_kunde_4
  SET anldatumlv = &datum
  WHERE anldatumlv IS NULL; 

  COMMIT;

   -- Wenn BBW gefunden wird zum heutigen Tag und der Kunde noch kein Anldat hat --> Anldat setzen und Kontoart
  MERGE INTO clcc_ww_kunde_4 a
  USING (SELECT DISTINCT cc.sg AS firma,
                         konto_id_key
         FROM cc_buchung b INNER JOIN cc_firma_waepumig_v cc 
         ON (b.firma = cc.wert AND &termin BETWEEN cc.dwh_valid_from AND cc.dwh_valid_to)
         WHERE buchdat = &datum AND ansprmenge > 0) b
  ON (a.konto_id_key = b.konto_id_key AND a.firma = b.firma)
  WHEN MATCHED THEN UPDATE
  SET
    a.anldatum = &datum,
    a.datletztebest = &datum,
    a.kontoart = 1
  WHERE a.anldatum IS NULL;

  COMMIT;

  -- Erster Auftrag per App
  MERGE INTO clcc_ww_kunde_4 a
  USING (SELECT DISTINCT cc.sg AS firma,
                         konto_id_key,
                         MAX(auftrdat) AS auftrdat
         FROM cc_buchung b INNER JOIN cc_firma_waepumig_v cc 
         ON (b.firma = cc.wert AND &termin BETWEEN cc.dwh_valid_from AND cc.dwh_valid_to)
         WHERE buchdat = &datum AND ansprmenge > 0 AND b.appinfo = 1
         GROUP BY cc.sg, konto_id_key
         ) b
  ON (a.konto_id_key = b.konto_id_key AND a.firma = b.firma)
  WHEN MATCHED THEN UPDATE
  SET
    a.appauftrdaterst = auftrdat
  WHERE a.appauftrdaterst IS NULL;

  COMMIT;

   -- Alle die aktuell noch keine Kontoart haben bekommen Kontoart 2, da diese keine Bestandskunden sind und keine Buchung haben
  UPDATE clcc_ww_kunde_4 a
  SET kontoart = 2
  WHERE kontoart IS NULL;
   
  COMMIT;


  PROMPT ===========================================
  PROMPT
  PROMPT 3.8 Statistiken erstellen und Indizes aufbauen
  PROMPT
  PROMPT ===========================================

  EXEC pkg_stats.gathertable (user, 'clcc_ww_kunde_4');

  CREATE INDEX clcc_ww_kunde_4_ix1 ON clcc_ww_kunde_4(konto_id_key) TABLESPACE udwh_cl_01_ts;

  CREATE INDEX clcc_ww_kunde_4_ix2 ON clcc_ww_kunde_4 (anldatum) TABLESPACE udwh_cl_01_ts;

  PROMPT ===========================================
  PROMPT
  PROMPT 3.9 temp. Buchungsview erstellen
  PROMPT
  PROMPT ===========================================

  TRUNCATE TABLE clcc_ww_kunde_8;

  DROP INDEX clcc_ww_kunde_8_ix1;

  -- Cleanse-Tabelle mit Buchungsdaten aus der aktuellen Saison
  INSERT /*+APPEND*/ INTO clcc_ww_kunde_8
  (
   dwh_cr_load_id,
   konto_id_key,
   firma,
   nums,
   retouren,
   datletztebest_ori,
   bbw_im,
   bbw_im_ohne_stationaer,
   anzbest_im
  )
  SELECT
   &gbvid,
   c.konto_id_key,
   b.sg,
   SUM(numswert) AS nums,
   SUM(retwert) AS retouren,
   MAX(CASE WHEN SIGN(ansprmenge) = 1 AND NVL(auftrpos,0) NOT IN ('400','300') THEN buchdat ELSE NULL END) AS datletztebest_ori, -- Ersatzartikel nicht mitzaehlern
   SUM(ansprwert) AS bbw_im,
   SUM(CASE WHEN auftrart != 7 THEN ansprwert ELSE 0 END) AS bbw_im_ohne_stationaer,
   COUNT( DISTINCT CASE WHEN ansprmenge > 0 AND NVL(auftrpos,0) NOT IN ('400','300') THEN COALESCE(auftrnr_key,'0')  ELSE NULL END )  AS anzbest_im  -- Ersatzartikel nicht mitzaehlern
  FROM cc_buchung c INNER JOIN cc_firma_waepumig_v b ON (c.firma = b.wert AND &termin BETWEEN b.dwh_valid_from AND b.dwh_valid_to)
  WHERE c.buchdat BETWEEN &hjanfang AND &termin AND b.sg NOT IN (7,16,24,69,66,65) AND b.sg < 100
  GROUP BY
   &gbvid,
   konto_id_key,
   b.sg;

  COMMIT;

  -- Kein Unique Index mehr möglich
  CREATE INDEX clcc_ww_kunde_8_ix1 ON clcc_ww_kunde_8 (konto_id_key,firma) TABLESPACE udwh_cl_01_ts;

  EXEC PKG_STATS.GATHERTABLE(user,'clcc_ww_kunde_8');

  PROMPT ===========================================
  PROMPT
  PROMPT 4. Updates durchfuehren auf Basis der Vortageskunde
  PROMPT
  PROMPT ===========================================

  -- Fuer einige Personalkonten liefert EDV BKL = 0. Hier durch bisherige BKL ersetzen!
  -- Zudem bleibt vtgebiet innerhalb der Saison fix (Wunsch von VS-SC)
  -- datletztebest wird ebenfalls uebernommen, ggf. mit neuerem Wert aus kdums ueberschrieben
  -- Anlaufsaison wird fuer Bestandskunden aus bisheriger Stamm uebernommen,
  -- da fuer NK0-Kunden von der DV die falsche Anlaufsaison uebertragen wird!
  -- hkekz_akt wird uebertragen, um in Punkt 6 Referenz auf bisherigen Wert zu haben
  -- Anldatum wird fuer Firma 1 aus Stamm uebernommen, sofern Anldatum != Ladedatum
  -- Anldatum, Anlsaison und Datletztebest wird fuer alle Bestandskunden aus Stamm uebernommen,
  -- die nicht Personalkonten sind. Außnahme sind außerdem Waeschepur-Personalkunden
  -- und Witt-Personalkunden, die ein Waeschepurkonto haben. Bei diesen bleibt Anldatum, etc. fest
  -- Erstwkz/Erstiwl fuer Bestandskunden ueberschreiben

  MERGE INTO
   clcc_ww_kunde_4 a
  USING
   (
  SELECT
   konto_id_key,
   TO_NUMBER(cc_kontoart.sg) AS kontoart,
   TO_NUMBER(cc_firma.sg) AS firma,
   TO_NUMBER(cc_anlauftrart.sg) AS anlweg,
   TO_NUMBER(cc_bonikl.sg) AS bkl,
   TO_NUMBER(CASE WHEN cc_ostwest.sg = 'NULL' THEN NULL ELSE cc_ostwest.sg END)  AS vtgebiet,
   region AS bundesland,
   letztauftrdat AS datletztebest,
   TO_NUMBER(COALESCE(cc_imvtinfogrp.sg,0)) AS vtinfo_ori,
   anlweg1 AS wkz,
   anlweg2 AS iwl,
   TO_NUMBER(cc_vtsaison.sg) AS anlvtsaison,
   TO_NUMBER(CASE WHEN cc_anlaktionscode.sg LIKE 'NULL%' THEN NULL ELSE cc_anlaktionscode.sg END) AS anlcode,
   anldat AS anldatum,
   TO_NUMBER(cc_altjung_akt.sg) AS altjung_akt,
   TO_NUMBER(cc_altjung_folge.sg) AS altjung_folge,
   cc_anlaktionscoderea.sg AS anlcode_rea,
   TO_NUMBER(CASE WHEN cc_kunde.anlvtsaisonrea = '0' THEN '0' WHEN cc_kunde.anlvtsaisonrea = '-3' THEN '-3' ELSE  '20' || SUBSTR(cc_anlvtsaisonrea.sg,2,2) || SUBSTR(cc_anlvtsaisonrea.sg,1,1) END) AS anlsaison_rea,
   TO_NUMBER(SUBSTR(cc_onlinetest.sg,5,3)) AS online_test,
   TO_NUMBER(cc_shopanteiligkeit.sg) AS shopanteiligkeit,
   TO_NUMBER(cc_nixi.sg) AS nixikz,
   TO_NUMBER(cc_nlabostatus.sg) AS nlabostatus,
   TO_NUMBER(cc_nlwunsch.sg) AS nlkz,
   CASE WHEN cc_altwabherkunft.sg = 'NULL' THEN NULL ELSE cc_altwabherkunft.sg END AS altwabkz_ori,
   TO_NUMBER(cc_ueberschneider.sg) AS ueberschneidungskz,
   TO_NUMBER(cc_fgaktiv.sg) AS fgaktiv,
   TO_NUMBER(cc_creationlpremium.sg) AS creationlpremium,
   TO_NUMBER(COALESCE(cc_vtinfogrpstationaer.sg,0)) AS vtinfogruppestationaer,
   appauftrdaterst AS appauftrdaterst,
   praefartgrdobaktiv AS praefartgrdobaktiv,
   praefartgrdobinaktiv AS praefartgrdobinaktiv
  FROM cc_kunde_&vtsaison cc_kunde
  LEFT JOIN cc_vtsaison       ON cc_kunde.anlvtsaison = cc_vtsaison.wert AND &termin BETWEEN cc_vtsaison.dwh_valid_from AND cc_vtsaison.dwh_valid_to
  LEFT JOIN cc_anlvtsaisonrea cc_anlvtsaisonrea ON cc_kunde.anlvtsaisonrea = cc_anlvtsaisonrea.wert AND &termin BETWEEN cc_anlvtsaisonrea.dwh_valid_from AND cc_anlvtsaisonrea.dwh_valid_to
  LEFT JOIN cc_anlaktionscoderea cc_anlaktionscoderea ON cc_kunde.anlaktionscoderea = cc_anlaktionscoderea.wert AND &termin BETWEEN cc_anlaktionscoderea.dwh_valid_from AND cc_anlaktionscoderea.dwh_valid_to
  LEFT JOIN cc_firma_waepumig_v cc_firma        ON cc_kunde.firma = cc_firma.wert AND &termin BETWEEN cc_firma.dwh_valid_from AND cc_firma.dwh_valid_to
  LEFT JOIN cc_altjung cc_altjung_akt  ON cc_kunde.altjungakt = cc_altjung_akt.wert AND &termin BETWEEN cc_altjung_akt.dwh_valid_from AND cc_altjung_akt.dwh_valid_to
  LEFT JOIN cc_altjung cc_altjung_folge ON cc_kunde.altjungfolge = cc_altjung_folge.wert AND &termin BETWEEN cc_altjung_folge.dwh_valid_from AND cc_altjung_folge.dwh_valid_to
  LEFT JOIN cc_altwabherkunft     ON cc_kunde.imaltwabherkunft = cc_altwabherkunft.wert AND &termin BETWEEN cc_altwabherkunft.dwh_valid_from AND cc_altwabherkunft.dwh_valid_to
  LEFT JOIN cc_anlauftrart    ON cc_kunde.anlauftrart = cc_anlauftrart.wert AND &termin BETWEEN cc_anlauftrart.dwh_valid_from AND cc_anlauftrart.dwh_valid_to
  LEFT JOIN cc_anlaktionscode      ON cc_kunde.anlaktionscode = cc_anlaktionscode.wert AND &termin BETWEEN cc_anlaktionscode.dwh_valid_from AND cc_anlaktionscode.dwh_valid_to
  LEFT JOIN cc_bonikl      ON cc_kunde.bonikl = cc_bonikl.wert AND &termin BETWEEN cc_bonikl.dwh_valid_from AND cc_bonikl.dwh_valid_to
  LEFT JOIN cc_kontoart    ON cc_kunde.kontoart = cc_kontoart.wert AND &termin BETWEEN cc_kontoart.dwh_valid_from AND cc_kontoart.dwh_valid_to
  LEFT JOIN cc_nixi        ON cc_kunde.nixi = cc_nixi.wert AND &termin BETWEEN cc_nixi.dwh_valid_from AND cc_nixi.dwh_valid_to
  LEFT JOIN cc_nlabostatus ON cc_kunde.nlabostatus = cc_nlabostatus.wert AND &termin BETWEEN cc_nlabostatus.dwh_valid_from AND cc_nlabostatus.dwh_valid_to
  LEFT JOIN cc_nlwunsch ON cc_kunde.nlwunsch = cc_nlwunsch.wert AND &termin BETWEEN cc_nlwunsch.dwh_valid_from AND cc_nlwunsch.dwh_valid_to  
  LEFT JOIN cc_onlinetest  ON cc_kunde.onlinetest = cc_onlinetest.wert AND &termin BETWEEN cc_onlinetest.dwh_valid_from AND cc_onlinetest.dwh_valid_to
  LEFT JOIN cc_ostwest      ON cc_kunde.ostwest = cc_ostwest.wert AND &termin BETWEEN cc_ostwest.dwh_valid_from AND cc_ostwest.dwh_valid_to
  LEFT JOIN cc_shopanteiligkeit ON cc_kunde.shopanteiligkeit = cc_shopanteiligkeit.wert AND &termin BETWEEN cc_shopanteiligkeit.dwh_valid_from AND cc_shopanteiligkeit.dwh_valid_to
  LEFT JOIN cc_ueberschneider ON cc_kunde.ueberschneider = cc_ueberschneider.wert AND &termin BETWEEN cc_ueberschneider.dwh_valid_from AND cc_ueberschneider.dwh_valid_to
  LEFT JOIN cc_vtinfogrp cc_imvtinfogrp    ON cc_kunde.imvtinfogrp = cc_imvtinfogrp.wert AND &termin BETWEEN cc_imvtinfogrp.dwh_valid_from AND cc_imvtinfogrp.dwh_valid_to
  LEFT JOIN cc_fgaktiv ON cc_kunde.fgaktiv = cc_fgaktiv.wert AND &termin BETWEEN cc_fgaktiv.dwh_valid_from AND cc_fgaktiv.dwh_valid_to
  LEFT JOIN cc_creationlpremium ON cc_kunde.creationlpremium = cc_creationlpremium.wert AND &termin BETWEEN cc_creationlpremium.dwh_valid_from AND cc_creationlpremium.dwh_valid_to
  LEFT JOIN cc_vtinfogrp cc_vtinfogrpstationaer    ON cc_kunde.vtinfogrpstationaer = cc_vtinfogrpstationaer.wert AND &termin BETWEEN cc_vtinfogrpstationaer.dwh_valid_from AND cc_vtinfogrpstationaer.dwh_valid_to
 WHERE &termin - 1/24/60 BETWEEN cc_kunde.dwh_valid_from AND cc_kunde.dwh_valid_to
   AND kontoart IN (1,5)
  ) b
  ON (a.konto_id_key = b.konto_id_key AND a.firma = b.firma)
  WHEN MATCHED THEN UPDATE
  SET
   a.anlweg = b.anlweg,
   a.bkl = CASE WHEN COALESCE(a.bkl,0) = 0 THEN b.bkl ELSE a.bkl END,
   a.vtgebiet = b.vtgebiet,
   a.bundesland = b.bundesland,
   a.datletztebest = b.datletztebest ,
   a.vtinfo_ori = CASE WHEN a.kontoart = 1 AND NVL(b.kontoart,2) = 2 THEN a.vtinfo_ori ELSE b.vtinfo_ori END,
   a.wkz = b.wkz,
   a.iwl = b.iwl,
   a.altwabkz_ori = b.altwabkz_ori,
   a.anlsaison = CASE WHEN a.kontoart = 1 AND NVL(b.kontoart,2) = 2 THEN a.anlsaison ELSE b.anlvtsaison END,
   a.anlcode = b.anlcode,
   a.anldatum = CASE WHEN b.anldatum IS NULL AND a.kontoart = 1 AND NVL(b.kontoart,2) = 2 THEN a.anldatum ELSE b.anldatum END, 
   a.altjung_akt = b.altjung_akt,
   a.altjung_folge = b.altjung_folge,
   a.anlsaison_rea = b.anlsaison_rea,
   a.anlcode_rea = b.anlcode_rea,
   a.online_test = b.online_test,
   a.nixikz = b.nixikz,
   a.nlabostatus = b.nlabostatus,
   a.nlkz = b.nlkz,
   a.ueberschneidungskz = b.ueberschneidungskz,
   a.shopanteiligkeit = b.shopanteiligkeit,
   a.fgaktiv = b.fgaktiv,
   a.creationlpremium = b.creationlpremium,
   a.vtinfogruppestationaer = b.vtinfogruppestationaer,
   a.praefartgrdobaktiv = b.praefartgrdobaktiv, 
   a.praefartgrdobinaktiv = b.praefartgrdobinaktiv
   ;
  
  COMMIT;


  PROMPT ===========================================
  PROMPT
  PROMPT 5. Anlweg updaten (fuer alle Neukunden mit Buchung aus der cc_buchung,
  PROMPT der rest aus der Auftragkopf
  PROMPT
  PROMPT ===========================================

  TRUNCATE TABLE clcc_ww_kunde_11;

  -- Fuer alle Buchungen wird der ANLWEG gesetzt, nur telefonisch, schriftlich, Fax und Internet
  INSERT /*+APPEND*/ INTO clcc_ww_kunde_11
  (
    dwh_cr_load_id,
    konto_id_key,
    firma,
    bestwegkz,
    auftrdat,
    auftrzaehler
  )
  SELECT DISTINCT &gbvid,
                  a.konto_id_key,
                  c.sg AS firma,
                  d.sg AS bestweg,
                  a.auftrdat, 
                  a.auftrzaehler
  FROM cc_buchung a INNER JOIN cc_firma_waepumig_v c ON (a.firma = c.wert AND &termin BETWEEN c.dwh_valid_from AND c.dwh_valid_to)
                    INNER JOIN clcc_ww_kunde_4 b ON (a.konto_id_key = b.konto_id_key AND a.firma = c.wert AND a.buchdat = TRUNC(b.anldatum))
                    INNER JOIN cc_auftrart d ON (a.auftrart = d.wert AND &termin BETWEEN d.dwh_valid_from AND d.dwh_valid_to)
  WHERE a.buchdat = &datum AND a.ansprmenge > 0
    --AND auftrzaehler = 1     TODO: Korrektur von AUFTRZAEHLER waeschepur in der CC_BUCHUNG noetig. Hier wohl Fehler bei der Zaehlung wegen Joins KONTO_ID_KEY
    AND d.sg IN (0,1,2,3);

  COMMIT;

 -- In die Temp-Tabelle einbauen fuer alle Neukunden
 MERGE INTO
   clcc_ww_kunde_4 a
  USING
   (
     SELECT DISTINCT 
            konto_id_key,
            firma, 
            bestwegkz
     FROM clcc_ww_kunde_11
     WHERE (
            auftrdat || COALESCE(auftrzaehler,0),
            konto_id_key, 
            firma
           )
       IN
           (
             SELECT MIN(auftrdat || COALESCE(auftrzaehler,0)) auftrdat, -- Aufragszaehler als Fall-Back mit rein, wenn an einem Tag zur gleichen Zeit zwei Bestellwege auftauchen. Dann nimm Zaehler = 1. 
                    konto_id_key,
                    firma
             FROM clcc_ww_kunde_11
             GROUP BY konto_id_key, 
                      firma
           )
   ) b
  ON
   (a.konto_id_key = b.konto_id_key AND a.firma = b.firma)
  WHEN MATCHED THEN UPDATE
  SET
   a.anlweg = bestwegkz
  WHERE
   TRUNC(a.anldatum) = &datum;

  COMMIT;

  -- Fuer Kontoart 5 kann kein ANLWEG gesetzt werden, weil keine Buchung da. Hier fuer alle Neukunden auf die Auftragkopf gehen
  
  MERGE INTO clcc_ww_kunde_4 a
  USING
  (
   SELECT RANK () OVER (PARTITION BY c.konto_id_key||c.firma ORDER BY c.anldat ASC) AS minanldat, 
          bestwegkz, 
          konto_id_key, 
          firma, 
          anldat
   FROM
   (
     SELECT  ak.konto_id_key, 
             ak.firma, 
             bestweg.bestwegkz, 
             ak.anldat
     FROM
          (
          SELECT  sc_ww_a.konto_id_key, 
                  sc_ww_a.kdfirmkz AS firma, 
                  sc_ww_a.anldat, 
                  sc_ww_a.bestwegid
          FROM
              (
                SELECT b.dwh_valid_to, 
                       b.dwh_valid_from, 
                       b.konto_id_key, 
                       b.kdfirmkz, 
                       b.anldat, 
                       b.bestwegid, 
                       b.auftrgewkz
                FROM sc_ww_auftragkopf a INNER JOIN sc_ww_auftragkopf_ver b ON a.dwh_id = b.dwh_id_head) sc_ww_a
                WHERE &termin BETWEEN sc_ww_a.dwh_valid_from AND sc_ww_a.dwh_valid_to
                  AND sc_ww_a.auftrgewkz IN (1,2,3) AND TO_DATE(TRUNC(sc_ww_a.anldat)+10) >= &hjanfang
              ) ak
               INNER JOIN 
              (
               SELECT  a.bestwegkz,
                       b.id
               FROM sc_ww_bestweg_ver a INNER JOIN sc_ww_bestweg b ON a.dwh_id_head = b.dwh_id
               WHERE &termin BETWEEN a.dwh_valid_from AND a.dwh_valid_to
              ) bestweg
               ON ( ak.bestwegid = bestweg.id) 
              ) c
         ) d
  ON (a.konto_id_key = d.konto_id_key AND a.firma = d.firma AND d.minanldat = 1)
  WHEN MATCHED THEN UPDATE
    SET
      a.anlweg = d.bestwegkz-1  -- aus der Auftragkopf gibts andere SG-Werte, nämlich -1
  WHERE anldatumlv = &datum AND a.anlweg IS NULL;

  COMMIT;



  PROMPT ===========================================
  PROMPT
  PROMPT 6. Vtgebiet/Bundesland aus plz updaten
  PROMPT Werte aus plz updaten
  PROMPT
  PROMPT ===========================================


  -- Setzen der Werte mit Join ueber PLZ und Land
  MERGE INTO
   clcc_ww_kunde_4 a
  USING
   (
    SELECT c.*, TO_NUMBER(d.sg) AS landnr, TO_NUMBER(e.sg) AS vtgebiet 
    FROM cc_plzref c INNER JOIN cc_land_akt_v d ON c.land = d.wert
                     INNER JOIN cc_ostwest_akt_v e ON c.ostwest = e.wert
   ) b
  ON
   ( a.plz = b.plz AND a.landnr = b.landnr )
  WHEN MATCHED THEN UPDATE
  SET
   a.bundesland = b.region,
   a.vtgebiet =   b.vtgebiet
  ;

-- old (05.06.2025) : Umzieher wurden nicht betrachtet...
/*
   a.vtgebiet = CASE
                  WHEN
                    b.landnr = 4 AND a.landnr = 4 AND a.vtgebiet IS NULL
                     THEN b.vtgebiet
                  ELSE
                    a.vtgebiet
                END;
*/

  COMMIT;

  -- Setzen der Werte mit Join nur ueber Land
  --Fuer alle anderen Laender ausser Land 4 wird das VT-Gebiet ohne PLZ gesetzt
  MERGE INTO
   clcc_ww_kunde_4 a
  USING
   (
    SELECT DISTINCT TO_NUMBER(d.sg) AS landnr, TO_NUMBER(e.sg) AS vtgebiet 
    FROM cc_plzref c INNER JOIN cc_land_akt_v d ON c.land = d.wert
                     INNER JOIN cc_ostwest_akt_v e ON c.ostwest = e.wert
    WHERE d.sg <> 4
   ) p
  ON
   (a.landnr = p.landnr)
  WHEN MATCHED THEN UPDATE
  SET
   a.vtgebiet = p.vtgebiet
  WHERE
   a.vtgebiet IS NULL -- warum vtgebiet null? -- Vtgebiet muss bleiben auch wenn Kunde umzieht; Wunsch Fachbereich VS
   AND a.landnr <> 4;

  COMMIT;

  PROMPT ===========================================
  PROMPT
  PROMPT 7. Newsletter-Abostatus setzen von ONETRUST und Anlaufdatum setzen
  PROMPT
  PROMPT ===========================================

  -- Setzen des Nlabostatus auf Basis Onetrust. Taegliches Delta. 
  MERGE INTO clcc_ww_kunde_4 a 
  USING
  (
   SELECT * FROM  (
                    SELECT DISTINCT a.emailhash AS email_hash, 
                                    a.firma, 
                                    a.companycode, 
                                    a.status, 
                                    a.consenttext,
                                    a.ipaddress, 
                                    a.withdrawalreason, 
                                    a.emailbounce, 
                                    a.emailorigin, 
                                    a.timestampaws,
                                    RANK() OVER ( PARTITION BY emailhash,firma
                                                  ORDER BY timestampaws DESC
                                                 ) AS rang
                  FROM sc_ex_aws_nlabostatusdaten a
                  WHERE (emailhash,firma) IN (SELECT email_hash,firma FROM clcc_ww_kunde_4)
                )
   WHERE rang  = 1 AND emailbounce IS NULL -- keine Bounces einladen 
  ) b
  ON (a.email_hash = b.email_hash AND a.firma = b.firma) 
  WHEN MATCHED THEN UPDATE
    SET a.nlabostatus = CASE WHEN b.status = 'PENDING' THEN 14
                             WHEN b.status = 'ACTIVE'  THEN 4
                             WHEN b.status = 'WITHDRAWN' AND withdrawalreason = 'WITHDRAWN_BY_ADMIN' THEN 1
                             WHEN b.status = 'WITHDRAWN' AND withdrawalreason IS NULL THEN 1
                             WHEN b.status = 'WITHDRAWN' AND withdrawalreason = 'WITHDRAWN_BY_USER' THEN 2
                             WHEN b.status = 'NO_CONSENT' THEN 16
                         ELSE
                          0 
                         END;

  COMMIT;
  
  -- Fuer alle restlichen Kunden, fuer welche noch nichts gefunden wurde (meist Neukunden ohne Email) => unbekannt. 
  UPDATE clcc_ww_kunde_4
  SET nlabostatus = 0
  WHERE nlabostatus IS NULL;

  COMMIT;
  
  -- Soft Bounce darf auf "Aktiv"
  UPDATE clcc_ww_kunde_4
  SET nlabostatus = 4
  WHERE nlabostatus = 13;

  COMMIT;

  -- NLWUNSCH muss noch gesetzt werden - wird nicht mehr geliefert - nur positiv wenn Email vorhanden
  UPDATE clcc_ww_kunde_4
  SET nlkz = CASE WHEN nlabostatus = 4 AND email_vorhanden = 1 THEN 2
                  WHEN nlabostatus IN (1,2,3) THEN 1
                  ELSE
                  0
             END;

  COMMIT;

  --Nl-Anldatum wird gesetzt wenn folgende Kriterien zutreffen:
  --Email muss vorhanden sein 
  --NL muss erwuenscht oder keine Angabe haben
  DECLARE

      CURSOR curs1
        IS
         SELECT b.nlanldatum AS stamm_nldat, 
                a.ROWID
         FROM
           clcc_ww_kunde_4 a 
         LEFT OUTER JOIN (
                                      SELECT  konto_id_key,
                                              emailanldat AS nlanldatum
                                      FROM cc_kunde_&vtsaison
                                      WHERE &termin - 1/24/60 BETWEEN dwh_valid_from AND dwh_valid_to
                                        AND kontoart IN (1,5)
                                     )b
         ON (a.konto_id_key = b.konto_id_key)
         WHERE a.email_vorhanden = 1 AND a.nlkz IN (0,2);


  BEGIN
     FOR c1 IN curs1 LOOP

       UPDATE clcc_ww_kunde_4
       SET
           nlanldatum = CASE WHEN c1.stamm_nldat IS NULL
                        --and email_vorhanden is not null
                        THEN &datum
                        ELSE c1.stamm_nldat
                       END
       WHERE ROWID = c1.ROWID;
     END LOOP;
   END;
   /

   COMMIT;


  -- NLAnldatum auf NULL setzen, falls Witt-Konto noch nicht aktiv!
  -- VTINFO_ORI = 9999
  UPDATE
   clcc_ww_kunde_4
  SET
   nlanldatum = NULL
  WHERE firma = 1 and vtinfo_ori = 9999;

  COMMIT;
 

  PROMPT ===========================================================
  PROMPT 7.1 Initiales/Erstes Newsletter-Anlaufdatum setzen
  PROMPT ===========================================================

  /*
  Logik:
  Alle aktiven Nlabostatus selektieren und schauen, ob in der Vorstamm schon ein Eintrag
  im intialien Datum war --> Falls leer (left outer join), dann setze Nlanldatum
  Falls es keine EintrÃ¤ge gibt
  */

  MERGE INTO clcc_ww_kunde_4 a
  USING (
         SELECT konto_id_key,
                nlanldaterst,
                nlanldatletzt
         FROM cc_kunde_&vtsaison cc
         WHERE &termin - 1/24/60 BETWEEN cc.dwh_valid_from AND dwh_valid_to
           AND kontoart IN (1,5)
        ) b
   ON (a.konto_id_key = b.konto_id_key)
  WHEN MATCHED THEN UPDATE
  SET
    a.nlanldatumerst = b.nlanldaterst,
    a.nlanldatumletzt = b.nlanldatletzt;

  COMMIT;

  -- Alle Neukunden jetzt,  welche aktiven Status haben
  UPDATE clcc_ww_kunde_4 a
  SET
    a.nlanldatumerst = &datum,
    a.nlanldatumletzt = &datum
  WHERE a.nlanldatumerst IS NULL AND a.nlabostatus IN (4);

  COMMIT;

  MERGE INTO clcc_ww_kunde_4 r
  USING
  (
  SELECT b.konto_id_key,
         b.firma,
         b.nlanldaterst,
         b.nlanldatletzt,
         a.nlabostatus AS temp_nlabostatus,
         NVL(b.nlabostatus,-1) bkp_nlabostatus
  FROM
  (SELECT * FROM clcc_ww_kunde_4  WHERE nlabostatus IN (4) ) a LEFT OUTER JOIN (SELECT cc.konto_id_key,
                                                                                       cc.firma,
                                                                                       nlabo.sg AS nlabostatus,
                                                                                       cc.nlanldatletzt,
                                                                                       cc.nlanldaterst
                                                                                FROM cc_kunde_&vtsaison cc
                                                                                LEFT OUTER JOIN cc_nlabostatus@udwh nlabo ON (cc.nlabostatus = nlabo.wert AND &termin BETWEEN nlabo.dwh_valid_from AND nlabo.dwh_valid_to)
                                                                                WHERE &termin - 1/24/60 BETWEEN cc.dwh_valid_from AND cc.dwh_valid_to AND nlabo.sg NOT IN (4)
                                                                                  AND kontoart IN (1,5)
                                                                                ) b
                ON   a.konto_id_key = b.konto_id_key AND a.nlabostatus != b.nlabostatus
  ) q
  ON (r.konto_id_key = q.konto_id_key)
  WHEN MATCHED THEN UPDATE SET
   r.nlanldatumletzt = &datum
  WHERE r.nlanldatumerst IS NOT NULL
    AND q.temp_nlabostatus IN (4)
    AND q.bkp_nlabostatus NOT IN (4)
    AND q.bkp_nlabostatus > 0;

  COMMIT;


  PROMPT ===========================================
  PROMPT
  PROMPT 8. Statistiken erstellen
  PROMPT
  PROMPT ===========================================

  EXEC PKG_STATS.GATHERTABLE(user,'clcc_ww_kunde_4');

  PROMPT ===========================================
  PROMPT
  PROMPT 9. Kennzahlen aus Buchung errechnen
  PROMPT
  PROMPT ===========================================

  PROMPT ===========================================
  PROMPT
  PROMPT 9.1 bbw, nums, ret, anzbest, datletztebest setzen
  PROMPT
  PROMPT ===========================================

  MERGE INTO
   clcc_ww_kunde_4 a
  USING
   clcc_ww_kunde_8 b
  ON (
       a.konto_id_key = b.konto_id_key AND a.firma = b.firma
     )
  WHEN MATCHED THEN UPDATE
  SET
   a.bbw = COALESCE(b.bbw_im,0),
   a.bbwohnestationaer = COALESCE(b.bbw_im_ohne_stationaer,0),
   a.nums = COALESCE(b.nums,0),
   a.retouren = COALESCE(b.retouren,0),
   a.anzbestellungen = COALESCE(b.anzbest_im,0),
   a.datletztebest = COALESCE(b.datletztebest_ori,a.datletztebest);
   
  COMMIT;
  

  PROMPT ===========================================
  PROMPT
  PROMPT 9.2 Wenn Datum noch immer leer, dann auf anldatum setzen
  PROMPT
  PROMPT ===========================================

  UPDATE
   clcc_ww_kunde_4
  SET
   datletztebest = anldatum
  WHERE
   datletztebest IS NULL AND kontoart = 1;

  COMMIT;


  PROMPT ===========================================
  PROMPT
  PROMPT 9.3 Liegt Datum vor dem anlaufdatum? auf Anlaufdatum setzen
  PROMPT
  PROMPT ===========================================

  UPDATE
   clcc_ww_kunde_4
  SET
   datletztebest = anldatum
  WHERE
   datletztebest < anldatum AND datletztebest IS NOT NULL;

  COMMIT;


  PROMPT ===========================================
  PROMPT
  PROMPT 9.4 lebensanzahl bestellungen im, lbbw und lnums setzen
  PROMPT
  PROMPT ===========================================

  -- Werte des Vorjahres setzen
 
  MERGE INTO
   clcc_ww_kunde_4 a
  USING
   (
    SELECT lanzauftr, 
           lansprwert, 
           lansprohnestationaerwert,
           lretwert,
           lnumswert, 
           konto_id_key, 
           d.sg AS firma
    FROM cc_kunde_&vtsaisonm1 c
    LEFT JOIN cc_firma_waepumig_v d ON (c.firma = d.wert and &termin between d.dwh_valid_from and d.dwh_valid_to)
    WHERE c.dwh_status = 1 
   ) b
  ON
   (a.firma = b.firma AND a.konto_id_key = b.konto_id_key )
  WHEN MATCHED THEN UPDATE
  SET
   a.lbbw = COALESCE(b.lansprwert,0),
   a.lbbwohnestationaer = COALESCE(b.lansprohnestationaerwert,0),
   a.lanzbestellungen = COALESCE(b.lanzauftr,0),
   a.lnums = COALESCE(b.lnumswert,0),
   a.lretouren = COALESCE(b.lretwert,0)
  ;

  COMMIT;

  -- Aktuelle Werte dazuspielen
  UPDATE
   clcc_ww_kunde_4
  SET
   lbbw = COALESCE(lbbw,0) + COALESCE(bbw,0),
   lbbwohnestationaer = COALESCE(lbbwohnestationaer,0) + COALESCE(bbwohnestationaer,0),
   lanzbestellungen = COALESCE(lanzbestellungen,0) + COALESCE(anzbestellungen,0),
   lnums = COALESCE(lnums,0) + COALESCE(nums,0),
   lretouren = COALESCE(lretouren,0) + COALESCE(retouren,0)
  ;

  COMMIT;


  PROMPT ===========================================
  PROMPT
  PROMPT 10. WKZ/IWL setzten aus CC_NKCODIERUNG
  PROMPT
  PROMPT ===========================================
 
  MERGE INTO clcc_ww_kunde_4 a
  USING 
    (
     SELECT  konto_id_key,
             anlweg1 AS wkz, 
             anlweg2 AS iwl, 
             anlcode
     FROM cc_nkcodierung c 
     WHERE trunc(c.dwh_Valid_from)  = &datum 
      AND nkcodierungsart NOT IN (17,18)
    ) b
  ON ( a.konto_id_key = b.konto_id_key )
  WHEN MATCHED THEN UPDATE 
    SET
      a.wkz = b.wkz,
      a.iwl = b.iwl, 
      a.anlcode = b.anlcode
  WHERE a.anldatum = &datum;
  
  COMMIT;


  PROMPT ===========================================
  PROMPT
  PROMPT 11. externe Schnittstelle Updates durchfuehren
  PROMPT
  PROMPT ===========================================

  /*
  ACHTUNG !!!!!
  
  Alte Welt Vtinfogruppen duerfen bei Sondervtinfos nicht angenommen werden, da in der neuen Welt andere Defintion vor herrscht.
  Wenn nur noch neue Welt läuft, muss 
                                        "AND b.vtinfogruppe NOT LIKE '9%'"
  wieder ausgenommen werden !!!!
  
  Die Einteilung der 9er uebernimmt hier also ausnahmslos die neue Kundenladung.
  */

  MERGE INTO
   clcc_ww_kunde_4 a
  USING
   clcc_ww_kunde_24  b
  ON (a.konto_id_key = b.konto_id_key)
  WHEN MATCHED THEN UPDATE
  SET
   a.bkl = CASE WHEN b.bklneu <> -1 THEN b.bklneu ELSE a.bkl END,
   a.altjung_akt = CASE WHEN b.altjung_aktneu <> -1 THEN b.altjung_aktneu ELSE a.altjung_akt END,
   a.altjung_folge = CASE WHEN b.altjung_folgeneu <> -1 THEN b.altjung_folgeneu ELSE a.altjung_folge END,
   a.anlsaison_rea = CASE WHEN b.anlsaison_reaneu <> -1 THEN b.anlsaison_reaneu ELSE a.anlsaison_rea END,
   a.anlcode_rea = CASE WHEN b.anlcode_reaneu <> '-1' THEN b.anlcode_reaneu ELSE a.anlcode_rea END,
   a.online_test = CASE WHEN b.online_testneu <> -1 THEN b.online_testneu ELSE a.online_test END,
   a.nixikz = CASE WHEN b.nixikzneu <> -1 THEN b.nixikzneu ELSE a.nixikz END,
   a.wkz  = CASE WHEN b.wkzneu <> -1 THEN b.wkzneu ELSE a.wkz END,
   a.iwl = CASE WHEN b.iwlneu <> -1 THEN b.iwlneu ELSE a.iwl END,
   a.anlcode = CASE WHEN NVL(b.anlcodeneu,9999) <> -1 THEN b.anlcodeneu ELSE a.anlcode END, -- es kann vorkommen, dass anlcode = null upgedated werden soll, daher NVL
   a.vtinfogruppe = CASE WHEN b.vtinfogruppeneu <> -1 AND b.vtinfogruppeneu NOT LIKE '9%' THEN b.vtinfogruppeneu ELSE a.vtinfogruppe END,
   a.vtinfo_ori =  CASE WHEN b.vtinfogruppeneu <> -1 AND b.vtinfogruppeneu NOT LIKE '9%' THEN b.vtinfogruppeneu ELSE a.vtinfo_ori END,
   a.anlsaison = CASE WHEN b.anlsaisonneu <> -1 THEN b.anlsaisonneu ELSE a.anlsaison END,
   a.nlabostatus = CASE WHEN b.nlabostatusneu <> -1 THEN b.nlabostatusneu ELSE a.nlabostatus END,
   a.nlanldatum = CASE WHEN b.nlanldatumneu <> TO_DATE('01.02.1900 00:00:00', 'dd.mm.rrrr hh24:mi:ss') THEN b.nlanldatumneu ELSE a.nlanldatum END,
   a.anlweg = CASE WHEN b.anlwegneu <> -1 THEN b.anlwegneu ELSE a.anlweg END,
   a.anzbestellungen = CASE WHEN b.anzbestellungenneu <> -1 THEN b.anzbestellungenneu ELSE a.anzbestellungen END,
   a.bbw = CASE WHEN b.bbwneu <> -1 THEN b.bbwneu ELSE a.bbw END,
   a.datletztebest = CASE WHEN b.datletztebestneu <> TO_DATE('01.02.1900 00:00:00', 'dd.mm.rrrr hh24:mi:ss') THEN b.datletztebestneu ELSE a.datletztebest END,
   a.lanzbestellungen = CASE WHEN b.lanzbestellungenneu <> -1 THEN b.lanzbestellungenneu ELSE a.lanzbestellungen END,
   a.lbbw = CASE WHEN b.lbbwneu <> -1 THEN b.lbbwneu ELSE a.lbbw END,
   a.lnums = CASE WHEN b.lnumsneu <> -1 THEN b.lnumsneu ELSE a.lnums END,
   a.nums = CASE WHEN b.numsneu <> -1 THEN b.numsneu ELSE a.nums END,
   a.retouren = CASE WHEN b.retourenneu <> -1 THEN b.retourenneu ELSE a.retouren END,
   a.anldatum = CASE WHEN b.anldatumneu <> TO_DATE('01.02.1900 00:00:00', 'dd.mm.rrrr hh24:mi:ss') THEN b.anldatumneu ELSE a.anldatum END,
   a.altwabkz_ori = CASE WHEN NVL(b.altwabkzneu,9999) <> '-1' AND b.vtinfogruppeneu NOT LIKE '9%' THEN b.altwabkzneu ELSE a.altwabkz_ori END,
   a.ueberschneidungskz = CASE WHEN NVL(b.ueberschneidungskzneu,9999) <> '-1' AND b.ueberschneidungskzneu NOT LIKE '9%' THEN b.ueberschneidungskzneu ELSE a.ueberschneidungskz END,
   a.appauftrdaterst = CASE WHEN b.appauftrdaterstneu <> TO_DATE('01.02.1900 00:00:00', 'dd.mm.rrrr hh24:mi:ss') THEN b.appauftrdaterstneu ELSE a.appauftrdaterst END;

  COMMIT;



  PROMPT ===========================================
  PROMPT
  PROMPT 12. Vtinfogruppe
  PROMPT
  PROMPT ===========================================

  PROMPT ===========================================
  PROMPT
  PROMPT 12.1 Sonderumcodierungen
  PROMPT
  PROMPT ===========================================

  PROMPT ===========================================
  PROMPT 12.2 Vti nach Kundentyp setzen
  PROMPT ===========================================
  PROMPT 12.2.1 neue NK-0 Kunden
  PROMPT ===========================================

  UPDATE
   clcc_ww_kunde_4 s
  SET
   vtinfo_ori = 7200,
   anlsaison = &vtsaisonp1
  WHERE
   EXISTS (SELECT 'x'
           FROM sc_im_tgv_nk0_ver n
           WHERE &termin BETWEEN n.dwh_valid_from AND n.dwh_valid_to
             AND s.wkz BETWEEN n.ww_startwkz AND n.ww_endewkz
             AND s.iwl BETWEEN n.ww_startiwl AND n.ww_endeiwl
             AND s.firma = n.firma_im
             AND s.anldatum BETWEEN n.ww_startdatum AND n.ww_endedatum
             AND n.vtsaison=&vtsaison
           )
             AND s.vtinfo_ori IS NULL;

  COMMIT;



  PROMPT ===========================================
  PROMPT
  PROMPT 12.2.2 neue NK-1b Kunden
  PROMPT
  PROMPT ===========================================

  UPDATE
   clcc_ww_kunde_4 s
  SET
   vtinfo_ori = 7100,
   anlsaison = &vtsaison
  WHERE anldatum >= &hjanfang AND vtinfo_ori IS NULL;

  COMMIT;


  PROMPT ===========================================
  PROMPT
  PROMPT 12.2.3 Sonderfall: Personaler laufen neu an, obwohl anlaufdatum
  PROMPT   in der Vergangenheit steckt
  PROMPT
  PROMPT ===========================================

  /*
    Das sind Kunden (meist Personaler), welche in der Vergangenheit angelaufen
    sind, allerdings nie in der KUNDE gelandet sind, da sie keine gueltige 
    VTINFOGRUPPE-EDV hatten (von der IT). Nach der Hostmigration (07-17 bis 12-17)
    bekommen diese Kunden eine VTINFOGRUPPE-EDV und landen in der KUNDE, allerdings 
    mit dem alten Anlaufdatum. Diese "Kunden" bekommen wegen dem alten Anlaufdatum
    keine Vtinfogruppe, von dem her gibt es eine DUMMY-VTINFOGRUPPE -3 nicht verwendet
  */

  UPDATE
   clcc_ww_kunde_4 s
  SET
   vtinfo_ori = 0
  WHERE anldatum < &datum AND vtinfo_ori IS NULL;

  COMMIT;

  PROMPT ===========================================
  PROMPT
  PROMPT 12.3 Kunden ohne Vtinfogruppe
  PROMPT
  PROMPT ===========================================

  DECLARE
   
   v_anz PLS_INTEGER;
   
  BEGIN

   SELECT
   COUNT(*)
   INTO v_anz
   FROM
   clcc_ww_kunde_4
   WHERE
   vtinfo_ori IS NULL AND kontoart = 1;

   IF v_anz != 0 THEN
     raise_application_error (-20232, 'VTInfogruppe_ORI ist NULL!!!! ' || v_anz || ' DS sind betroffen!');
   END IF;
  END;
/

  PROMPT ===========================================
  PROMPT
  PROMPT 12.4 Vtinfogruppe fuer Stationaerkunden (nur Stationaerumsaetze!)
  PROMPT
  PROMPT ===========================================

  UPDATE clcc_ww_kunde_4
  SET vtinfogruppestationaer = 7100
  WHERE firma = 1 AND COALESCE(vtinfogruppestationaer,-3) = -3 AND (bbw - bbwohnestationaer) > 0  -- sobald Stationaerbuchung kommt und es noch keine Vtinfo gibt...
    AND kundenart <> 29 -- Abrechnungskonten duerfen nicht beruecksichtigt werden
    ;
   
  COMMIT;

  PROMPT ===========================================
  PROMPT
  PROMPT 13. WKZ-Umcodierung
  PROMPT
  PROMPT ===========================================
 

  PROMPT ===========================================
  PROMPT
  PROMPT 13.1 Neuermittlung von NK0-Kunden, die umcodiert wurden
  PROMPT
  PROMPT ===========================================

  -- Kunden, die mit einer Nicht-NK0-Codierung anlaufen, gemaeß Umcodierung  dann aber in eine NK0-Codierung
  -- umgeschluesselt werden, werden hier jetzt ebenfalls auf NK0 umcodiert.

  TRUNCATE TABLE clcc_ww_kunde_16;

  INSERT /*+APPEND */ INTO clcc_ww_kunde_16
  (
   dwh_cr_load_id,
   konto_id_key,
   vtinfogruppe,
   vtinfo_ori
  )
  SELECT
   dwh_cr_load_id,
   konto_id_key,
   vtinfogruppe,
   vtinfo_ori
  FROM
   clcc_ww_kunde_4 s
  WHERE
   EXISTS (
           SELECT 'x'
           FROM sc_im_tgv_nk0_ver n
           WHERE &termin BETWEEN dwh_valid_from AND dwh_valid_to
             AND s.wkz BETWEEN n.ww_startwkz AND n.ww_endewkz
             AND s.iwl BETWEEN n.ww_startiwl AND n.ww_endeiwl
             AND s.firma = n.firma_im
             AND s.anldatum BETWEEN n.ww_startdatum AND n.ww_endedatum
             AND n.vtsaison=&vtsaison
           )
  AND s.anldatum=&datum
  AND ((SUBSTR(vtinfo_ori, 1, 1) != 9 AND SUBSTR(vtinfo_ori, 1, 2) != 72 OR anlsaison != &vtsaisonp1));

  COMMIT;


  UPDATE
   clcc_ww_kunde_4 s
  SET
   anlsaison = &vtsaisonp1,
   vtinfo_ori = CASE WHEN vtinfo_ori = 7100 THEN 7200
                     WHEN vtinfo_ori = 9999 THEN 9999
                 ELSE -1
                END
  WHERE
   konto_id_key IN (SELECT konto_id_key FROM clcc_ww_kunde_16);

  COMMIT;
  
  PROMPT 14. Gewinnungswegcodierung fuer Stammgeschaeft
  PROMPT =======================================================================

  UPDATE
   clcc_ww_kunde_4 s
  SET
   vtinfo_ori = (
                 SELECT s.vtinfo_ori + COALESCE(MAX((t.gewinnungsweg*10) + t.zusatz),0)
                 FROM sc_im_tgv_gewweg_ver t
                 WHERE &termin BETWEEN t.dwh_valid_from AND t.dwh_valid_to
                     AND s.wkz BETWEEN t.ww_wkz_von AND t.ww_wkz_bis
                     AND s.iwl BETWEEN t.ww_iwl_von AND t.ww_iwl_bis
                     AND t.vt_saison=s.anlsaison
                     AND s.firma= t.firma_im
                 )
  WHERE vtinfo_ori IN (7000,7100,7200)
   AND PKG_IM_ZEIT.F_VTSAISON_IN_EKSAISON (anlsaison) >= 125
   AND anlsaison > 0;

  COMMIT;

 
  PROMPT ===========================================
  PROMPT
  PROMPT 15. Anlcode-Default setzen, wenn aus CC_NKCODIERUNG nix gefunden wurde
  PROMPT
  PROMPT ===========================================
 
  UPDATE
   clcc_ww_kunde_4
  SET
   anlcode = 99
  WHERE
   anlcode IS NULL AND anlsaison = &vtsaison;

  COMMIT;


  PROMPT ===========================================
  PROMPT
  PROMPT 16. Test und Einladen der Daten in Haupttabelle
  PROMPT
  PROMPT ===========================================

  PROMPT ===========================================
  PROMPT
  PROMPT 16.1 test auf leeres altwabkz
  PROMPT
  PROMPT ===========================================


  DECLARE
   v_anz PLS_INTEGER;
  BEGIN
   SELECT COUNT(*)
   INTO v_anz
   FROM clcc_ww_kunde_4 a
   WHERE SUBSTR(vtinfo_ori, 1, 2) = 62 AND altwabkz_ori IS NULL;

   IF v_anz != 0 THEN
     RAISE_APPLICATION_ERROR (-20232, 'ALT-WA-B-Kunden ohne ALT-WA-B-KZ!');
   END IF;
  END;
/

  PROMPT ===========================================
  PROMPT
  PROMPT 16.2 Abildung der aktuellen Vtinfo-Systematik
  PROMPT Manipulation der Spalte Vtinfogruppe
  PROMPT
  PROMPT ===========================================

  -- Hier wird fuer Bestandskunden die VTINFO_ORI gesetzt. In den spaeteren
  -- Statements kann diese sich aber noch aendern, falls es sich um eine gesperrte handelt
  -- (vtinfo_ori enthaelt bis auf 9999 KEINE Sperr-Vtinfos --> '9%')

  UPDATE
   clcc_ww_kunde_4 s
  SET
   vtinfogruppe = vtinfo_ori;

  COMMIT;
  
  PROMPT ===========================================
  PROMPT 16.2.1
  PROMPT Personal
  PROMPT Sammelbesteller
  PROMPT Grosskunden
  PROMPT =========================

  UPDATE
   clcc_ww_kunde_4 s
  SET
   vtinfogruppe = CASE WHEN kundenart BETWEEN 50 AND 59 THEN 9110 -- Personal
                       WHEN kundenart BETWEEN 30 AND 39 THEN 9210 --  Sammelbesteller
                       WHEN kundenart BETWEEN 80 AND 89 THEN 9210 -- Großkunden
                  ELSE -1
                  END
  WHERE kundenart BETWEEN 50 AND 59 OR kundenart BETWEEN 30 AND 39 OR kundenart BETWEEN 80 AND 89;

  COMMIT;
  
  PROMPT ===========================================
  PROMPT 16.2.2
  PROMPT Geschaefte
  PROMPT Fachgeschaefte und versandkunden
  PROMPT Fachgeschaefte sonstige
  PROMPT =========================

  -- ##.1 9250 wird nicht mehr aus Kundenart 29 gespeist
  UPDATE
   clcc_ww_kunde_4 s
  SET
   vtinfogruppe = CASE WHEN kundenart IN (20,22) THEN 9230 -- Geschaefte
                       WHEN kundenart IN (21,23) THEN 9240 -- Fachgeschaefte und Versandkunden
                       WHEN kundenart IN (26,29) THEN 9250 -- Fachgeschaefte Sonstiges
                  ELSE -1
                  END
  WHERE kundenart IN (20,22) OR kundenart IN (21,23) OR kundenart IN (26,29);

  COMMIT;
  
  PROMPT ===========================================
  PROMPT 16.2.3
  PROMPT Heimservice
  PROMPT =========================

  UPDATE
   clcc_ww_kunde_4 s
  SET
   vtinfogruppe = CASE WHEN kundenart IN (24,25) THEN 9260 -- Heimservice
                   ELSE -1
                  END
  WHERE kundenart IN (24,25);

  COMMIT;
  
  PROMPT ===========================================
  PROMPT 16.2.4
  PROMPT Diensleister Witt-Gruppe
  PROMPT =========================

  UPDATE
   clcc_ww_kunde_4 s
  SET
   vtinfogruppe = CASE WHEN kundenart BETWEEN 90 AND 96 THEN 9270 -- Heimservice
                   ELSE -1
                  END
  WHERE kundenart BETWEEN 90 AND 96;

  COMMIT;
  
  PROMPT ===========================================
  PROMPT 16.2.5
  PROMPT Sonstiges
  PROMPT =========================

  UPDATE
   clcc_ww_kunde_4 s
  SET
   vtinfogruppe = CASE WHEN kundenart IN (49,98,99) THEN 9280 -- Sonstiges
                    ELSE -1
                  END
  WHERE kundenart IN (49,98,99);

  COMMIT;
  
  PROMPT ===========================================
  PROMPT 16.2.6
  PROMPT Doppelkonto
  PROMPT =========================

  -- Doppelkonten
  UPDATE
   clcc_ww_kunde_4 s
  SET
   vtinfogruppe=9220
  WHERE
   kontosperre = 6;

  COMMIT;


  PROMPT ===========================================
  PROMPT 16.2.7 
  PROMPT Vtinfogruppe fuer Witt-D-Konto die nur bei wp aktiv sind auf 9999 setzen
  PROMPT ===========================================

  UPDATE
   clcc_ww_kunde_4
  SET
   vtinfogruppe = 9999
  WHERE
   vtinfo_ori = 9999;

  COMMIT;

  
  PROMPT ===========================================
  PROMPT
  PROMPT  17. creation-l-premium-Kennzeichen setzen 
  PROMPT
  PROMPT ===========================================

  PROMPT 0. Default-Einteilung - erstmal auf 4 "keine Einteilung"
  
  UPDATE clcc_ww_kunde_4
  SET creationlpremium = 4
  WHERE firma = 6;

  COMMIT;

  PROMPT 1. cLP-Neukunden
  PROMPT alle Kunden, welche seit FS21 über einen cL Premium-Akqui-Katalog (K380, K381, K382; K383) angelaufen sind, sollen dieses Kennzeichen erhalten
  
  MERGE INTO clcc_ww_kunde_4 a
  USING
  (
  SELECT DISTINCT konto_id_key 
  FROM  cc_buchung a JOIN cc_katart_akt_V b ON a.katart = b.wert
  WHERE firma = 6 AND ansprmenge > 0 AND b.sg_katart IN (380,381,382,383)
      AND buchdat >= TO_DATE('01.01.2021','dd.mm.rrrr') AND auftrzaehler = 1
  ) b
  ON (a.konto_id_key = b.konto_id_key)
  WHEN MATCHED THEN UPDATE
  SET
      a.creationlpremium = 1;
  
  COMMIT; 
  
  
  PROMPT 2. cLP-Kauefer
  PROMPT - Kunden, welche seit FS21 Ware vom KT-97 gekauft haben mit dieser Kennziffer versehen werden
  PROMPT - Kunden, welche aus den cLP-Aktivierungskatalogen (K323; K380; K383; K384) seit FS21 bestellt haben
  PROMPT - 6 Saisons zurück

  MERGE INTO clcc_ww_kunde_4 a
  USING
  (
  SELECT DISTINCT konto_id_key 
  FROM  cc_buchung a JOIN cc_katart_akt_V b ON a.katart = b.wert
  WHERE firma = 6 AND ansprmenge > 0 AND b.sg_katart IN (323,380,383,384,390)
      AND buchdat >= &hjanfangm6
  UNION
  SELECT DISTINCT konto_id_key 
  FROM  cc_buchung a JOIN cc_katart_akt_V b ON a.katart = b.wert
                     JOIN cc_art_akt_v c ON a.art_id = c.art_id
                     JOIN cc_etberkt_akt_v d ON c.etberkt =d.wert
  WHERE firma = 6 AND ansprmenge > 0
      AND buchdat >= &hjanfangm6 AND SUBSTR(d.sg,-2) = 97
  ) b
  ON (a.konto_id_key = b.konto_id_key)
  WHEN MATCHED THEN UPDATE
  SET
   creationlpremium = 2
  WHERE creationlpremium NOT IN (1);

  COMMIT;
  

  PROMPT 3. cLP-affin
  PROMPT Kunden, welche mit Hilfe der cLP-20-Variable, seit 6 Saisons, als cLP-affine Kunden ermittelt wurden, gekennzeichnet werden

  MERGE INTO clcc_ww_kunde_4 a
  USING
  (
  SELECT konto_id_key, 
         SUM(NVL(clpaffin,0))/SUM(ansprmenge) AS clpaffin 
  FROM
  (
      SELECT /*+parallel (32) */ a.firma, 
                                 a.konto_id_key, 
                                 a.buchdat, 
                                 a.ansprmenge, 
                                 d.verd1bez2,
                                 a.ansprwert, 
                                 a.numswert, 
                                 a.vkp,
                                 CASE WHEN d.verd1bez2 LIKE '%Ober%' AND vkp>=60 THEN ansprmenge
                                      WHEN d.verd1bez2 LIKE '%Unter%' AND vkp>=80 THEN ansprmenge
                                      WHEN d.verd1bez2 LIKE '%Ganz%' AND vkp>=100 THEN ansprmenge
                                      ELSE 0
                                     END AS clpaffin
      FROM cc_buchung a INNER JOIN clcc_ww_kunde_4 x ON a.konto_id_key = x.konto_id_key
                        LEFT JOIN  cc_art_akt_v b ON (a.art_id=b.art_id)
                        INNER JOIN cc_marktkz_akt_v c ON b.marktkz = c.wert
                        INNER JOIN cc_obermarktkz_akt_v d ON c.obermarktkz = d.wert
      WHERE a.firma IN (6) AND buchdat >= &hjanfangm6 AND d.verd1bez2 LIKE '%DOB%'
      AND ansprwert>0)
      GROUP BY konto_id_key
  ) b
  ON (a.konto_id_key = b.konto_id_key)
  WHEN MATCHED THEN UPDATE SET
      a.creationlpremium = 3
  WHERE a.creationlpremium NOT IN (1,2) AND b.clpaffin > 0.2;
  
  COMMIT;

  PROMPT ===========================================
  PROMPT
  PROMPT  18. IT-Stammdaten mit IM-Daten anreichern
  PROMPT
  PROMPT ===========================================


  TRUNCATE TABLE clcc_ww_kunde_18;

  INSERT /*+APPEND */ INTO clcc_ww_kunde_18
  (
   dwh_cr_load_id,
   firma,
   kontonrletzteziffern,
   konto_id_key,
   kontoart,
   kundeid_key,
   anldatum,
   anldatumlv,
   anlagedatum,
   anlsaison,
   wkz,
   iwl,
   gebdatum,
   gebdatstatus,
   telefonprivat_vorhanden,
   kundenart,
   kontosperre,
   versandkz,
   ersartkz,
   nachbarkz,
   adrhdlkz,
   werbemittelsperre,
   telemarkkz,
   vtinfogruppe,
   vtinfo_ori,
   altwabkz_ori,
   anrede,
   titel,
   vorname,
   plz,
   plzid,
   plzzusatz,
   land,
   vtgebiet,
   bundesland,
   briefbotenbezirk,
   provinzcode,
   emailverweigertkz,
   faxfirmavorwahl,
   faxprivatvorwahl,
   rufnummerverweigertkz,
   telefonfirmavorwahl,
   telefonprivatvorwahl,
   email_hash, 
   email_vorhanden,
   handy_vorhanden,
   nlkz,
   nladressherkunft,
   nlabostatus,
   nltyp,
   emailanldatum ,
   nlanldatumerst,
   nlanldatumletzt,
   kdloginaktdat,
   kdloginlinkdat,
   kdloginaktivkz,
   bbw,
   bbwohnestationaer,
   lbbw,
   lbbwohnestationaer,
   lretouren,
   anzbestellungen,
   lanzbestellungen,
   datletztebest,
   nums,
   lnums,
   retouren,
   kreditlimit,
   rkumstellung,
   mahnebene,
   mahnstrang,
   bkl,
   testgruppe,
   anlweg,
   verweiskonto_id_key,
   servicemailaktivkz,
   altjung_akt,
   altjung_folge,
   anlcode ,
   anlsaison_rea,
   anlcode_rea ,
   online_test,
   shopanteiligkeit,
   nixikz,
   fgnr,
   wunschfilialwerb,
   adresseausvorteilsnummer,
   ueberschneidungskz,
   postfach, 
   datenschutzkonto,
   nachnameinitiale,
   emailprivat_key,
   fgaktiv,
   eigenfremdkaufkz,
   serviceinforechnungversandkz,
   creationlpremium,
   vtinfogrpstationaer,
   appauftrdaterst,
   praefartgrdobaktiv,
   praefartgrdobinaktiv,
   ladedatum,
   dwh_id_cc_firma,
   dwh_id_cc_adrhdl,
   dwh_id_cc_anrede,
   dwh_id_cc_land,
   dwh_id_cc_kdart,
   dwh_id_cc_zustelldienst,
   dwh_id_cc_telemarkwunsch,
   dwh_id_cc_werbemittelsperre,
   dwh_id_cc_mahnebene,
   dwh_id_cc_mahnstrang,
   dwh_id_cc_bonikl,
   dwh_id_cc_ersartwunsch,
   dwh_id_cc_nachbarabg,
   dwh_id_cc_emailherkunft,
   dwh_id_cc_nltyp,
   dwh_id_cc_rufnrverweigert,
   dwh_id_cc_emailverweigert,
   dwh_id_cc_servicemailaktiv,
   dwh_id_cc_kdloginaktiv,
   dwh_id_cc_kontosperre,
   dwh_id_cc_fg,
   dwh_id_cc_filialwerbungwunsch,
   dwh_id_cc_vorteilsnrangabe,
   dwh_id_cc_emailvorhanden,
   dwh_id_cc_mobilnrvorhanden,
   dwh_id_cc_gebdatverweigert,
   dwh_id_cc_telefonvorhanden,
   dwh_id_cc_postfach,
   dwh_id_cc_datenschutzkonto,
   dwh_id_cc_eigenfremdkauf,
   dwh_id_cc_serviceinfoversand
  )
  SELECT
   a.dwh_cr_load_id,
   a.firma,
   b.kontonrletzteziffern,
   a.konto_id_key,
   a.kontoart,
   b.kundeid_key,
   a.anldatum,
   a.anldatumlv,
   a.anlagedatum,
   a.anlsaison,
   a.wkz,
   a.iwl,
   a.gebdatum,
   b.gebdatstatus,
   b.telefonprivat_vorhanden,
   a.kundenart,
   b.kontosperre,
   b.versandkz,
   b.ersatzartkz,
   b.nachbarkz,
   b.adrhdlkz,
   b.werbemittelsperre,
   b.telemarkkz,
   a.vtinfogruppe,
   a.vtinfo_ori,
   a.altwabkz_ori,
   b.anrede,
   b.titel,
   b.vorname,
   a.plz,
   b.plzid,
   b.plzzusatz,
   b.land,
   a.vtgebiet,
   a.bundesland,
   b.briefbotenbezirk,
   b.provinzcode,
   b.emailverweigertkz,
   b.faxfirmavorwahl,
   b.faxprivatvorwahl,
   b.rufnummerverweigertkz,
   b.telefonfirmavorwahl,
   b.telefonprivatvorwahl,
   b.email_hash, 
   b.email_vorhanden,
   b.handy_vorhanden,
   a.nlkz,
   b.nladressherkunft,
   a.nlabostatus,
   b.nltyp,
   a.nlanldatum,
   a.nlanldatumerst,
   a.nlanldatumletzt,
   b.kdloginaktdat,
   b.kdloginlinkdat,
   b.kdloginaktivkz ,
   COALESCE(a.bbw,0),
   COALESCE(a.bbwohnestationaer,0),
   COALESCE(a.lbbw,0),
   COALESCE(a.lbbwohnestationaer,0),
   COALESCE(a.lretouren,0),
   COALESCE(a.anzbestellungen,0),
   COALESCE(a.lanzbestellungen,0),
   a.datletztebest,
   COALESCE(a.nums,0),
   COALESCE(a.lnums,0),
   COALESCE(a.retouren,0) ,
   b.kreditlimit, --wird zu Anfang aus KUNDE_IT dann Stamm dann Mahnlauf geholt
   b.rkumstellung,
   b.mahnebene,  --wird zu Anfang aus KUNDE_IT dann Stamm dann Mahnlauf geholt, laut Referenz einstellig! in KUNDE_IT noch zweistellig
   b.mahnstrang,    --wird zu Anfang aus KUNDE_IT dann Stamm dann Mahnlauf geholt
   a.bkl, --> wird manuell in WW_STAMM_214 geschrieben (Vorgaben Lochner Claus) zweimal pro Saison -- Sofie schreibt in Stamm
   b.testgruppe,
   a.anlweg,
   b.verweiskonto_id_key,
   b.servicemailaktivkz,
   a.altjung_akt, --> fuer Neukunden von IM -- wird manuell in WW_STAMM_214 geschrieben (Vorgaben Lochner Claus)
   a.altjung_folge, --> wird manuell in KUNDE geschrieben (Vorgaben Lochner Claus) zweimal pro Saison
   a.anlcode,
   a.anlsaison_rea, --> wird manuell in KUNDE geschrieben, immer zum Saisonende
   COALESCE(a.anlcode_rea, '#'), --> wird manuell in KUNDE geschrieben, immer zum Saisonende
   a.online_test,
   a.shopanteiligkeit,
   COALESCE(a.nixikz,0), --> wird manuell in KUNDE geschrieben
   b.fgnr,
   b.wunschfilialwerb,
   b.adresseausvorteilsnummer,
   a.ueberschneidungskz,
   b.postfach, 
   b.datenschutzkonto,
   b.nachnameinitiale,
   b.emailprivat_key,
   a.fgaktiv,
   b.eigenfremdkaufkz,
   b.serviceinforechnungversandkz,
   a.creationlpremium,
   a.vtinfogruppestationaer,
   a.appauftrdaterst,
   a.praefartgrdobaktiv,
   a.praefartgrdobinaktiv,
   b.ladedatum,
   b.dwh_id_cc_firma,
   b.dwh_id_cc_adrhdl,
   b.dwh_id_cc_anrede,
   b.dwh_id_cc_land,
   b.dwh_id_cc_kdart,
   b.dwh_id_cc_zustelldienst,
   b.dwh_id_cc_telemarkwunsch,
   b.dwh_id_cc_werbemittelsperre,
   b.dwh_id_cc_mahnebene,
   b.dwh_id_cc_mahnstrang,
   b.dwh_id_cc_bonikl,
   b.dwh_id_cc_ersartwunsch,
   b.dwh_id_cc_nachbarabg,
   b.dwh_id_cc_emailherkunft,
   b.dwh_id_cc_nltyp,
   b.dwh_id_cc_rufnrverweigert,
   b.dwh_id_cc_emailverweigert,
   b.dwh_id_cc_servicemailaktiv,
   b.dwh_id_cc_kdloginaktiv,
   b.dwh_id_cc_kontosperre,
   b.dwh_id_cc_fg,
   b.dwh_id_cc_filialwerbungwunsch,
   b.dwh_id_cc_vorteilsnrangabe,
   b.dwh_id_cc_emailvorhanden,
   b.dwh_id_cc_mobilnrvorhanden,
   b.dwh_id_cc_gebdatverweigert,
   b.dwh_id_cc_telefonvorhanden,
   b.dwh_id_cc_postfach,
   b.dwh_id_cc_datenschutzkonto,
   b.dwh_id_cc_eigenfremdkauf,
   b.dwh_id_cc_serviceinfoversand
  FROM clcc_ww_kunde_4 a
  INNER JOIN
   (
   SELECT
   dwh_id_cc_firma,
   dwh_id_cc_adrhdl,
   dwh_id_cc_anrede,
   dwh_id_cc_land,
   dwh_id_cc_kdart,
   dwh_id_cc_zustelldienst,
   dwh_id_cc_telemarkwunsch,
   dwh_id_cc_werbemittelsperre,
   dwh_id_cc_mahnebene,
   dwh_id_cc_mahnstrang,
   dwh_id_cc_bonikl,
   dwh_id_cc_ersartwunsch,
   dwh_id_cc_nachbarabg,
   dwh_id_cc_emailherkunft,
   dwh_id_cc_nltyp,
   dwh_id_cc_rufnrverweigert,
   dwh_id_cc_emailverweigert,
   dwh_id_cc_servicemailaktiv,
   dwh_id_cc_kdloginaktiv,
   dwh_id_cc_kontosperre,
   dwh_id_cc_fg,
   dwh_id_cc_filialwerbungwunsch,
   dwh_id_cc_vorteilsnrangabe,   
   dwh_id_cc_emailvorhanden,
   dwh_id_cc_mobilnrvorhanden,
   dwh_id_cc_gebdatverweigert,
   dwh_id_cc_telefonvorhanden,
   dwh_id_cc_postfach, 
   dwh_id_cc_datenschutzkonto,
   dwh_id_cc_eigenfremdkauf,
   dwh_id_cc_serviceinfoversand,
   kundeid_key,
   firma,
   kontonrletzteziffern,
   konto_id_key,
   kontosperre,
   versandkz,
   ersatzartkz,
   nachbarkz,
   adrhdlkz,
   werbemittelsperre,
   telemarkkz,
   anrede,
   titel,
   vorname,
   gebdatstatus,
   telefonprivat_vorhanden,
   plzid,
   plzzusatz,
   land,
   briefbotenbezirk,
   provinzcode,
   nladressherkunft,
   CASE
     WHEN UPPER (nltyp) = 'TEXT NEWSLETTER' THEN 1
     WHEN UPPER (nltyp) = 'HTML NEWSLETTER' THEN 2
     WHEN UPPER (nltyp) = 'MULTIPART NEWSLETTER' THEN 3
   ELSE 0
   END AS nltyp,
   kdloginaktivkz,
   rkumstellung,
   testgruppe,
   verweiskonto_id_key,
   emailverweigertkz,
   faxfirmavorwahl,
   faxprivatvorwahl,
   email_hash, 
   email_vorhanden,
   handy_vorhanden,
   rufnummerverweigertkz,
   telefonfirmavorwahl,
   telefonprivatvorwahl,
   servicemailaktivkz,
   fgnr,
   wunschfilialwerb,
   adresseausvorteilsnummer,
   mahnstrang,
   mahnebene,
   kreditlimit,
   kdloginaktdat,
   kdloginlinkdat,
   postfach, 
   datenschutzkonto,
   nachnameinitiale,
   emailprivat_key,
   eigenfremdkaufkz,
   serviceinforechnungversandkz,
   ladedatum
   FROM
     clcc_ww_kunde_2
   ) b
    ON ( a.firma = b.firma AND a.konto_id_key= b.konto_id_key);

  COMMIT;
  

  PROMPT ===========================================
  PROMPT
  PROMPT 19. altjung_akt ermitteln
  PROMPT
  PROMPT ===========================================

  TRUNCATE TABLE clcc_ww_kunde_19;

  INSERT /*+APPEND*/ INTO clcc_ww_kunde_19
  (
   dwh_cr_load_id,
   konto_id_key,
   vtgebiet,
   firma,
   anldatum,
   jahrgang,
   d_jung,
   d_alt,
   w_jung,
   w_alt,
   h_jung,
   h_alt,
   d_sehralt,
   ss_jungums_d,
   ss_altums_d,
   ss_jungums_w,
   ss_altums_w,
   ss_jungums_h,
   ss_altums_h,
   ss_sehraltums_d,
   ss_jungums_wh,
   ss_altums_wh,
   ss_jungums_wd,
   ss_altums_wd,
   ss_jungums_hd,
   ss_altums_hd,
   ss_jungums_wdh,
   ss_altums_wdh,
   altzujung_d_50,
   altzujung_w_50,
   altzujung_h_50,
   altzujung_wdh_50,
   sehraltzugesamt_50,
   altzujung_d_90,
   altzujung_w_90,
   altzujung_h_90,
   altzujung_wdh_90,
   sehraltzugesamt_90,
   einteilung,
   einteilung1_im_sco_swt
  )
  SELECT
      &gbvid AS dwh_cr_load_id,
      s.konto_id_key AS konto_id_key,
      s.vtgebiet      AS  vtgebiet,
      s.firma            AS    firma,
      s.anldatum      AS  anldatum,
      NVL(  EXTRACT( YEAR FROM s.gebdatum ) , 0 ) AS jahrgang,
      0               AS  d_jung,
      0               AS  d_alt,
      0               AS  w_jung,
      0               AS  w_alt,
      0               AS  h_jung,
      0               AS  h_alt,
      0               AS  d_sehralt,
      0               AS  ss_jungums_d,
      0               AS  ss_altums_d,
      0               AS  ss_jungums_w,
      0               AS  ss_altums_w,
      0               AS  ss_jungums_h,
      0               AS  ss_altums_h,
      0               AS  ss_sehraltums_d,
      0               AS  ss_jungums_wh,
      0               AS  ss_altums_wh,
      0               AS  ss_jungums_wd,
      0               AS  ss_altums_wd,
      0               AS  ss_jungums_hd,
      0               AS  ss_altums_hd,
      0               AS  ss_jungums_wdh,
      0               AS  ss_altums_wdh,
     -1               AS altzujung_d_50,
     -1               AS altzujung_w_50,
     -1               AS altzujung_h_50,
     -1               AS altzujung_wdh_50,
     -1               AS sehraltzugesamt_50,
     -1               AS altzujung_d_90,
     -1               AS altzujung_w_90,
     -1               AS altzujung_h_90,
     -1               AS altzujung_wdh_90,
     -1               AS sehraltzugesamt_90,
      0               AS einteilung,
      0               AS einteilung1_im_sco_swt
  FROM clcc_ww_kunde_18 s
  WHERE kontoart = 1 AND firma IN (1,2,5,15) AND SUBSTR(vtinfogruppe,1,2) IN (71,72,76);

  COMMIT;

  PROMPT *** d_jung ***

  MERGE INTO clcc_ww_kunde_19 a
  USING (
  /*
            SELECT t.konto_id_key, t.firma,
                 NVL(  SUM( t.umsatzwert), 0 ) mg0
            FROM ww_alina_&vtsaison t
            WHERE ( LOWER   (t.modellalter)    = 'jung'  OR LOWER   (t.modellalter)    = 'sehr jung' ) AND t.sortiment = 5
            GROUP BY t.konto_id_key, t.firma
*/            
            SELECT t.konto_id_key, t.firma,
                 NVL(SUM(t.umsatzwert), 0) mg0
            FROM dm_f_alinav1 t
            WHERE vtsaison = &vtsaison
            AND (LOWER(t.modellalter) = 'jung'  OR LOWER   (t.modellalter)    = 'sehr jung' ) AND t.sortiment = 5
            GROUP BY t.konto_id_key, t.firma            
         ) b
  ON (a.konto_id_key = b.konto_id_key AND a.firma = b.firma)
  WHEN MATCHED THEN UPDATE
    SET
      a.d_jung = b.mg0,
      a.ss_jungums_d =  NVL(b.mg0,0);

  COMMIT;
  


  PROMPT *** d_alt ***

  MERGE INTO clcc_ww_kunde_19 a
  USING ( 
  /*
         SELECT t.konto_id_key,
                 t.firma,
                 NVL(  SUM( t.umsatzwert), 0 ) mg0
          FROM ww_alina_&vtsaison t
          WHERE ( LOWER   (t.modellalter)    = 'alt'  OR LOWER   (t.modellalter)    = 'sehr alt' ) AND t.sortiment = 5
          GROUP BY t.konto_id_key, t.firma
*/          
          SELECT t.konto_id_key, t.firma,
                 NVL(  SUM( t.umsatzwert), 0 ) mg0
          FROM dm_f_alinav1 t
          WHERE vtsaison = &vtsaison
          AND (LOWER   (t.modellalter) = 'alt'  OR LOWER (t.modellalter) = 'sehr alt' ) AND t.sortiment = 5
          GROUP BY t.konto_id_key, t.firma          
        ) b
  ON (a.konto_id_key = b.konto_id_key AND a.firma = b.firma)
  WHEN MATCHED THEN UPDATE
    SET
      a.d_alt = b.mg0,
      a.ss_altums_d = NVL(b.mg0,0);

  COMMIT;
  


  PROMPT *** w_jung ****

  MERGE INTO clcc_ww_kunde_19 a
  USING ( 
  /*
          SELECT t.konto_id_key,
                 t.firma,
                 NVL(  SUM( t.umsatzwert), 0 ) mg0
          FROM ww_alina_&vtsaison t
          WHERE ( LOWER   (t.modellalter)    = 'jung'  OR LOWER   (t.modellalter)    = 'sehr jung' ) AND t.sortiment IN (1,2,3,4)
          GROUP BY t.konto_id_key, t.firma
*/          
       SELECT t.konto_id_key,
                 t.firma,
                 NVL(  SUM( t.umsatzwert), 0 ) mg0
          FROM dm_f_alinav1 t
          WHERE vtsaison = &vtsaison
          AND ( LOWER   (t.modellalter)    = 'jung'  OR LOWER   (t.modellalter)    = 'sehr jung' ) AND t.sortiment IN (1,2,3,4)
          GROUP BY t.konto_id_key, t.firma          
        ) b
  ON (a.konto_id_key = b.konto_id_key AND a.firma = b.firma)
  WHEN MATCHED THEN UPDATE
    SET
      a.w_jung = b.mg0,
      a.ss_jungums_w = NVL(b.mg0,0);

  COMMIT;



  PROMPT *** w_alt ****

  MERGE INTO clcc_ww_kunde_19 a
  USING ( 
  /*
          SELECT t.konto_id_key,
                 t.firma,
                 NVL(  SUM( t.umsatzwert), 0 ) mg0
          FROM ww_alina_&vtsaison t
          WHERE ( LOWER   (t.modellalter)    = 'alt'  OR LOWER   (t.modellalter)    = 'sehr alt' ) AND t.sortiment IN (1,2,3,4)
          GROUP BY t.konto_id_key, t.firma
*/          
          SELECT t.konto_id_key,
                 t.firma,
                 NVL(  SUM( t.umsatzwert), 0 ) mg0
          FROM dm_f_alinav1 t
          WHERE vtsaison = &vtsaison 
          AND ( LOWER   (t.modellalter)    = 'alt'  OR LOWER   (t.modellalter)    = 'sehr alt' ) AND t.sortiment IN (1,2,3,4)
          GROUP BY t.konto_id_key, t.firma          
        ) b
  ON (a.konto_id_key = b.konto_id_key AND a.firma = b.firma)
  WHEN MATCHED THEN UPDATE
    SET
      a.w_alt = b.mg0,
      a.ss_altums_w = NVL(b.mg0,0);

  COMMIT;



  PROMPT *** h_jung ***

  MERGE INTO clcc_ww_kunde_19 a
  USING ( 
  /*
          SELECT t.konto_id_key,
                 t.firma,
                 NVL(  SUM( t.umsatzwert), 0 ) mg0
          FROM ww_alina_&vtsaison t
          WHERE ( LOWER   (t.modellalter)    = 'jung'  OR LOWER   (t.modellalter)    = 'sehr jung' ) AND t.sortiment = 6
          GROUP BY t.konto_id_key, t.firma
*/                    
          SELECT t.konto_id_key,
                 t.firma,
                 NVL(  SUM( t.umsatzwert), 0 ) mg0
          FROM dm_f_alinav1 t
          WHERE vtsaison = &vtsaison
          AND ( LOWER   (t.modellalter)    = 'jung'  OR LOWER   (t.modellalter)    = 'sehr jung' ) AND t.sortiment = 6
          GROUP BY t.konto_id_key, t.firma
        ) b
  ON (a.konto_id_key = b.konto_id_key AND a.firma = b.firma)
  WHEN MATCHED THEN UPDATE
    SET
      a.h_jung = b.mg0,
      a.ss_jungums_h = NVL(b.mg0,0);

  COMMIT;



  PROMPT *** h_alt ***

  MERGE INTO clcc_ww_kunde_19 a
  USING ( 
  /*
         SELECT t.konto_id_key,
                 t.firma,
                 NVL(  SUM( t.umsatzwert), 0 ) mg0
          FROM ww_alina_&vtsaison t
          WHERE ( LOWER   (t.modellalter)    = 'alt'  OR LOWER   (t.modellalter)    = 'sehr alt' ) AND t.sortiment = 6
          GROUP BY t.konto_id_key, t.firma
*/          
          SELECT t.konto_id_key,
                 t.firma,
                 NVL(  SUM( t.umsatzwert), 0 ) mg0
          FROM dm_f_alinav1 t
          WHERE vtsaison = &vtsaison
          AND ( LOWER   (t.modellalter)    = 'alt'  OR LOWER   (t.modellalter)    = 'sehr alt' ) AND t.sortiment = 6
          GROUP BY t.konto_id_key, t.firma                       
        ) b
  ON (a.konto_id_key = b.konto_id_key AND a.firma = b.firma)
  WHEN MATCHED THEN UPDATE
    SET
      a.h_alt = b.mg0,
      a.ss_altums_h = NVL(b.mg0,0);

  COMMIT;



  PROMPT *** d_sehralt ***

  MERGE INTO clcc_ww_kunde_19 a
  USING ( 
  /*
          SELECT t.konto_id_key,
                 t.firma,
                 NVL(  SUM( t.umsatzwert), 0 ) mg0
          FROM ww_alina_&vtsaison t
          WHERE  ( LOWER   (t.modellalter)    = 'sehr alt' ) AND t.sortiment = 5
          GROUP BY t.konto_id_key, t.firma
*/          
          SELECT t.konto_id_key,
                 t.firma,
                 NVL(  SUM( t.umsatzwert), 0 ) mg0
          FROM dm_f_alinav1 t
          WHERE vtsaison = &vtsaison
          AND  ( LOWER   (t.modellalter)    = 'sehr alt' ) AND t.sortiment = 5
          GROUP BY t.konto_id_key, t.firma
        ) b
  ON (a.konto_id_key = b.konto_id_key AND a.firma = b.firma)
  WHEN MATCHED THEN UPDATE
    SET
      a.d_sehralt = b.mg0,
      a.ss_sehraltums_d  = NVL(b.mg0,0);

  COMMIT;



  PROMPT *** ss_umsaetze setzen ***

  UPDATE clcc_ww_kunde_19
  SET ss_altums_wh = NVL(ss_altums_w,0) + NVL(ss_altums_h,0),
      ss_jungums_wh = NVL(ss_jungums_w,0) + NVL(ss_jungums_h,0),
      ss_altums_wd = NVL(ss_altums_w,0) + NVL(ss_altums_d,0),
      ss_jungums_wd = NVL(ss_jungums_w,0) + NVL(ss_jungums_d,0),
      ss_altums_hd = NVL(ss_altums_h,0) + NVL(ss_altums_d,0),
      ss_jungums_hd = NVL(ss_jungums_h,0) + NVL(ss_jungums_d,0),
      ss_altums_wdh = NVL(ss_altums_w,0) + NVL(ss_altums_d,0) + NVL(ss_altums_h,0),
      ss_jungums_wdh = NVL(ss_jungums_w,0) + NVL(ss_jungums_d,0) + NVL(ss_jungums_h,0);

  COMMIT;


  PROMPT *** altzujung_wdh_50 ***

  UPDATE clcc_ww_kunde_19 a
  SET altzujung_wdh_50  =  ROUND(NVL(CASE WHEN
                                            ss_altums_wdh=0 AND ss_jungums_wdh=0
                                            THEN -9999
                                          WHEN ss_altums_wdh<50 AND ss_jungums_wdh<50
                                            THEN -9999
                                          WHEN
                                              (ss_altums_wdh+ss_jungums_wdh)=0
                                            THEN -9999
                                        ELSE
                                          (CASE
                                              WHEN ss_altums_wdh/(ss_altums_wdh+ss_jungums_wdh)>1
                                                THEN 1
                                              WHEN ss_altums_wdh/(ss_altums_wdh+ss_jungums_wdh)<0
                                                THEN 0
                                           ELSE
                                              ss_altums_wdh/(ss_altums_wdh+ss_jungums_wdh)
                                           END
                                          )
                                    END, -9999 ),5);

  COMMIT;

  UPDATE clcc_ww_kunde_19 a
  SET
  altzujung_wdh_50 = -9999
  WHERE altzujung_wdh_50 = -1;

  COMMIT;

  PROMPT *** altzujung_wdh_90 ***

  UPDATE clcc_ww_kunde_19 a
  SET altzujung_wdh_90  =  ROUND(NVL(CASE WHEN
                                          ss_altums_wdh=0 AND ss_jungums_wdh=0
                                          THEN -9999
                                        WHEN ss_altums_wdh<50 AND ss_jungums_wdh<90
                                          THEN -9999
                                        WHEN
                                            (ss_altums_wdh+ss_jungums_wdh)=0
                                          THEN -9999
                                      ELSE
                                        (CASE
                                            WHEN ss_altums_wdh/(ss_altums_wdh+ss_jungums_wdh)>1
                                              THEN 1
                                            WHEN ss_altums_wdh/(ss_altums_wdh+ss_jungums_wdh)<0
                                              THEN 0
                                         ELSE
                                            ss_altums_wdh/(ss_altums_wdh+ss_jungums_wdh)
                                         END
                                        )
                                  END, -9999 ),5);

  COMMIT;

  UPDATE clcc_ww_kunde_19 a
  SET altzujung_wdh_90 = -9999
  WHERE altzujung_wdh_90 = -1;

  COMMIT;

  PROMPT *** altzujung_d_50 ***


  UPDATE clcc_ww_kunde_19 a
  SET  altzujung_d_50 = ROUND(NVL(CASE WHEN
                                          ss_altums_d=0 AND ss_jungums_d=0
                                            THEN -9999
                                       WHEN ss_altums_d<50 AND ss_jungums_d<50
                                            THEN -9999
                                       WHEN (ss_altums_d+ss_jungums_d)=0
                                            THEN -9999
                                   ELSE ( CASE WHEN
                                                ss_altums_d/(ss_altums_d+ss_jungums_d)>1
                                                  THEN 1
                                               WHEN ss_altums_d/(ss_altums_d+ss_jungums_d)<0
                                                  THEN 0
                                          ELSE  ss_altums_d/(ss_altums_d+ss_jungums_d)
                                          END)
                                 END , -9999 ),5);

  COMMIT;

  UPDATE clcc_ww_kunde_19 a
  SET altzujung_d_50 = -9999
  WHERE altzujung_d_50 = -1;

  COMMIT;

  PROMPT *** altzujung_d_90 ***

  UPDATE clcc_ww_kunde_19 a
  SET  altzujung_d_90 = ROUND(NVL(CASE WHEN
                                        ss_altums_d=0 AND ss_jungums_d=0
                                          THEN -9999
                                     WHEN ss_altums_d<50 AND ss_jungums_d<90
                                          THEN -9999
                                     WHEN (ss_altums_d+ss_jungums_d)=0
                                          THEN -9999
                                 ELSE ( CASE WHEN
                                              ss_altums_d/(ss_altums_d+ss_jungums_d)>1
                                                THEN 1
                                             WHEN ss_altums_d/(ss_altums_d+ss_jungums_d)<0
                                                THEN 0
                                        ELSE  ss_altums_d/(ss_altums_d+ss_jungums_d)
                                        END)
                               END , -9999 ),5);

   COMMIT;

   UPDATE clcc_ww_kunde_19 a
   SET altzujung_d_90 = -9999
   WHERE altzujung_d_90 = -1;

   COMMIT;


  PROMPT *** altzujung_w_50 ****

  UPDATE clcc_ww_kunde_19 a
  SET altzujung_w_50  = ROUND(NVL( CASE WHEN
                                          ss_altums_w=0 AND ss_jungums_w=0
                                            THEN -9999
                                        WHEN ss_altums_w<50 AND ss_jungums_w<50
                                            THEN -9999
                                        WHEN  (ss_altums_w+ss_jungums_w)=0
                                            THEN -9999
                                   ELSE ( CASE WHEN
                                                ss_altums_w/(ss_altums_w+ss_jungums_w)>1
                                                  THEN 1
                                               WHEN ss_altums_w/(ss_altums_w+ss_jungums_w)<0
                                                  THEN 0
                                          ELSE  ss_altums_w/(ss_altums_w+ss_jungums_w)
                                          END
                                         )
                                   END , -9999 ),5);

  UPDATE clcc_ww_kunde_19 a
  SET  altzujung_w_50 = -9999
  WHERE altzujung_w_50 = -1;

  COMMIT;


  PROMPT *** altzujung_w_90 ****

  UPDATE clcc_ww_kunde_19 a
  SET altzujung_w_90  = ROUND(NVL( CASE WHEN
                                        ss_altums_w=0 AND ss_jungums_w=0
                                          THEN -9999
                                      WHEN ss_altums_w<50 AND ss_jungums_w<90
                                          THEN -9999
                                      WHEN  (ss_altums_w+ss_jungums_w)=0
                                          THEN -9999
                                 ELSE ( CASE WHEN
                                              ss_altums_w/(ss_altums_w+ss_jungums_w)>1
                                                THEN 1
                                             WHEN ss_altums_w/(ss_altums_w+ss_jungums_w)<0
                                                THEN 0
                                        ELSE  ss_altums_w/(ss_altums_w+ss_jungums_w)
                                        END
                                       )
                                 END , -9999 ),5);

   UPDATE clcc_ww_kunde_19 a
   SET  altzujung_w_90 = -9999
   WHERE altzujung_w_90 = -1;

   COMMIT;


  PROMPT *** sehraltzugesamt_50 ***

  UPDATE clcc_ww_kunde_19 a
  SET sehraltzugesamt_50  =  ROUND( NVL(CASE
                                          WHEN ss_sehraltums_d=0 AND (ss_jungums_d+ss_altums_d)=0
                                              THEN -9999
                                          WHEN ss_sehraltums_d<50 AND (ss_jungums_d+ss_altums_d)<50
                                              THEN -9999
                                          WHEN (ss_sehraltums_d+(ss_jungums_d+ss_altums_d))=0
                                              THEN -9999
                                        ELSE (CASE
                                                WHEN ss_sehraltums_d/(ss_sehraltums_d+(ss_jungums_d+ss_altums_d))>1
                                                  THEN 1
                                                WHEN ss_sehraltums_d/(ss_sehraltums_d+(ss_jungums_d+ss_altums_d))<0
                                                  THEN 0
                                              ELSE  ss_sehraltums_d/(ss_sehraltums_d+(ss_jungums_d+ss_altums_d))
                                              END
                                             )
                                        END , -9999 ),5);

  COMMIT;

  UPDATE clcc_ww_kunde_19 a
  SET sehraltzugesamt_50 = -9999
  WHERE sehraltzugesamt_50 = -1;

  COMMIT;

  PROMPT *** sehraltzugesamt_90 ***

  UPDATE clcc_ww_kunde_19 a
  SET sehraltzugesamt_90  =  ROUND( NVL(CASE
                                        WHEN ss_sehraltums_d=0 AND (ss_jungums_d+ss_altums_d)=0
                                            THEN -9999
                                        WHEN ss_sehraltums_d<50 AND (ss_jungums_d+ss_altums_d)<90
                                            THEN -9999
                                        WHEN (ss_sehraltums_d+(ss_jungums_d+ss_altums_d))=0
                                            THEN -9999
                                      ELSE (CASE
                                              WHEN ss_sehraltums_d/(ss_sehraltums_d+(ss_jungums_d+ss_altums_d))>1
                                                THEN 1
                                              WHEN ss_sehraltums_d/(ss_sehraltums_d+(ss_jungums_d+ss_altums_d))<0
                                                THEN 0
                                            ELSE  ss_sehraltums_d/(ss_sehraltums_d+(ss_jungums_d+ss_altums_d))
                                            END
                                           )
                                      END , -9999 ),5);

  COMMIT;

  UPDATE clcc_ww_kunde_19 a
  SET sehraltzugesamt_90 = -9999
  WHERE sehraltzugesamt_90 = -1;

  COMMIT;


  PROMPT *** altzujung_h_50 ***

  UPDATE clcc_ww_kunde_19 a
  SET altzujung_h_50 = ROUND(NVL(CASE
                                  WHEN ss_altums_h=0 AND ss_jungums_h=0
                                     THEN -9999
                                  WHEN ss_altums_h<50 AND ss_jungums_h<50
                                     THEN -9999
                                  WHEN (ss_altums_h+ss_jungums_h)=0
                                     THEN -9999
                                 ELSE (CASE
                                        WHEN ss_altums_h/(ss_altums_h+ss_jungums_h)>1
                                          THEN 1
                                        WHEN ss_altums_h/(ss_altums_h+ss_jungums_h)<0
                                          THEN 0
                                      ELSE  ss_altums_h/(ss_altums_h+ss_jungums_h)
                                      END
                                     )
                                  END , -9999 ),5);

  COMMIT;

  UPDATE clcc_ww_kunde_19 dsg SET
  altzujung_h_50 = -9999
  WHERE altzujung_h_50 = -1;

  COMMIT;

  UPDATE clcc_ww_kunde_19 a
  SET altzujung_h_90 = ROUND(NVL(CASE
                                WHEN ss_altums_h=0 AND ss_jungums_h=0
                                   THEN -9999
                                WHEN ss_altums_h<50 AND ss_jungums_h<90
                                   THEN -9999
                                WHEN (ss_altums_h+ss_jungums_h)=0
                                   THEN -9999
                               ELSE (CASE
                                      WHEN ss_altums_h/(ss_altums_h+ss_jungums_h)>1
                                        THEN 1
                                      WHEN ss_altums_h/(ss_altums_h+ss_jungums_h)<0
                                        THEN 0
                                    ELSE  ss_altums_h/(ss_altums_h+ss_jungums_h)
                                    END
                                   )
                                END , -9999 ),5);

  COMMIT;

  UPDATE clcc_ww_kunde_19 dsg
  SET altzujung_h_90 = -9999
  WHERE altzujung_h_90 = -1;

  COMMIT;

  PROMPT *** kundenstamm einteilung ***

  PROMPT *** schritt 1,2,3 ***

  UPDATE clcc_ww_kunde_19
  SET einteilung = CASE WHEN firma = 1 AND vtgebiet = 0
                        THEN CASE WHEN (NVL(altzujung_wdh_50,0) >= 0.80 OR (NVL(altzujung_w_50,0) >= 0.90 AND NVL(altzujung_d_50,0) >= 0.70)) THEN 1
       WHEN ( (NVL(altzujung_wdh_50,0) >= 0.0 AND NVL(altzujung_wdh_50,0) <= 0.25)
             OR ( (NVL(altzujung_w_50,0) >= 0.0 AND NVL(altzujung_w_50,0) <= 0.20) AND (NVL(altzujung_d_50,0) >= 0.0 AND NVL(altzujung_d_50,0) <= 0.35) ) ) THEN 11
       WHEN    NVL(altzujung_d_50,0) >= 0.70 THEN 2
       WHEN    NVL(altzujung_d_50,0) >= 0.0 AND NVL(altzujung_d_50,0) <= 0.40 THEN 12
       WHEN    NVL(altzujung_d_50,0) > 0.50 THEN 3
       WHEN    (NVL(altzujung_d_50,0) >= 0.0 AND NVL(altzujung_d_50,0) <= 0.50) THEN 13
       ELSE 0
       END
         WHEN firma = 1 AND vtgebiet = 1
              THEN CASE WHEN (NVL(altzujung_wdh_50,0) >= 0.80 OR (NVL(altzujung_w_50,0) >= 0.60 AND NVL(altzujung_d_50,0) >= 0.80)) THEN 1
       WHEN ( (NVL(altzujung_wdh_50,0) >= 0.0 AND NVL(altzujung_wdh_50,0) <= 0.30)
             OR ( (NVL(altzujung_w_50,0) >= 0.0 AND NVL(altzujung_w_50,0) <= 0.50) AND (NVL(altzujung_d_50,0) >= 0.0 AND NVL(altzujung_d_50,0) <= 0.30) ) ) THEN 11
       WHEN    NVL(altzujung_d_50,0) >= 0.70 THEN 2
       WHEN    NVL(altzujung_d_50,0) >= 0.0 AND NVL(altzujung_d_50,0) <= 0.40 THEN 12
       WHEN    NVL(altzujung_d_50,0) > 0.50 THEN 3
       WHEN    (NVL(altzujung_d_50,0) >= 0.0 AND NVL(altzujung_d_50,0) <= 0.50) THEN 13
       ELSE 0
       END
          WHEN firma = 1 AND vtgebiet IS NULL
          THEN CASE
       WHEN    NVL(altzujung_d_50,0) >= 0.70 THEN 2
       WHEN    NVL(altzujung_d_50,0) >= 0.0 AND NVL(altzujung_d_50,0) <= 0.40 THEN 12
       WHEN    NVL(altzujung_d_50,0) > 0.50 THEN 3
       WHEN    (NVL(altzujung_d_50,0) >= 0.0 AND NVL(altzujung_d_50,0) <= 0.50) THEN 13
       ELSE 0
       END
       WHEN firma = 5
       THEN CASE
       WHEN (NVL(altzujung_wdh_50,0) > 0.80 OR (NVL(altzujung_w_50,0) >= 0.90 AND NVL(altzujung_d_50,0) >= 0.70)) THEN 1
       WHEN ( (NVL(altzujung_wdh_50,0) >= 0.0 AND NVL(altzujung_wdh_50,0) <= 0.25)
       OR ( (NVL(altzujung_w_50,0) >= 0.0 AND NVL(altzujung_w_50,0) <= 0.20) AND (NVL(altzujung_d_50,0) >= 0.0 AND NVL(altzujung_d_50,0) <= 0.35) ) ) THEN 11
       WHEN NVL(altzujung_d_50,0) >= 0.70 THEN 2
       WHEN NVL(altzujung_d_50,0) >= 0.0 AND NVL(altzujung_d_50,0) <= 0.40 THEN 12
       WHEN NVL(altzujung_d_50,0) > 0.50 THEN 3
       WHEN (NVL(altzujung_d_50,0) >= 0.0 AND NVL(altzujung_d_50,0) <= 0.50) THEN 13
       ELSE 0
       END
           WHEN firma = 2
               THEN CASE
       WHEN (NVL(altzujung_wdh_90,0) > 0.80 OR (NVL(altzujung_w_90,0) >= 0.90 AND NVL(altzujung_d_90,0) >= 0.70)) THEN 1
       WHEN ( (NVL(altzujung_wdh_90,0) >= 0.0 AND NVL(altzujung_wdh_90,0) <= 0.25) OR ( (NVL(altzujung_w_90,0) >= 0.0 AND NVL(altzujung_w_90,0) <= 0.20) AND (NVL(altzujung_d_90,0) >= 0.0 AND NVL(altzujung_d_90,0) <= 0.35) ) ) THEN 11
       WHEN NVL(altzujung_d_90,0) >= 0.70 THEN 2
       WHEN NVL(altzujung_d_90,0) >= 0.0 AND NVL(altzujung_d_90,0) <= 0.40 THEN 12
       WHEN NVL(altzujung_d_90,0) > 0.50 THEN 3
       WHEN (NVL(altzujung_d_90,0) >= 0.0 AND NVL(altzujung_d_90,0) <= 0.50) THEN 13
       ELSE 0
      END
            ELSE -9999
       END;

  COMMIT;

  PROMPT *** einteilung neu ***

  UPDATE clcc_ww_kunde_19
  SET einteilung1_im_sco_swt = COALESCE(CASE WHEN (jahrgang BETWEEN 1 AND 1939 AND einteilung NOT IN (11,12,13)) OR einteilung IN (1,2,3) AND firma IN (1,5)  THEN  2
                                                                                                     WHEN (jahrgang BETWEEN 1 AND 1936 AND einteilung NOT IN (11,12,13)) OR einteilung IN (1,2,3) AND firma = 2 THEN  2
                                           WHEN (jahrgang >= 1940 AND einteilung NOT IN (1,2,3)) OR einteilung IN (11,12,13) AND firma IN (1,5)  THEN 3
                                           WHEN (jahrgang >= 1937 AND einteilung NOT IN (1,2,3)) OR einteilung IN (11,12,13) AND firma = 2 THEN 3
                             END,0);

  COMMIT;


  UPDATE clcc_ww_kunde_19 a
  SET einteilung1_im_sco_swt = (CASE WHEN a.anldatum > TO_DATE('01.01.2009','DD.MM.YYYY') AND a.jahrgang >0 AND a.jahrgang <= 1939 THEN 2
                                     WHEN a.anldatum > TO_DATE('01.01.2009','DD.MM.YYYY') AND a.jahrgang >= 1940 THEN 3
                                     WHEN a.jahrgang >0 AND a.jahrgang <= 1941 THEN 2
                                     WHEN a.jahrgang >= 1942 THEN 3
                                ELSE 0
                                END
                                )
  WHERE einteilung1_im_sco_swt = 0 AND firma IN (1,5);

  COMMIT;

  UPDATE clcc_ww_kunde_19
  SET einteilung1_im_sco_swt = 3
  WHERE anldatum >= TO_DATE('01.01.2009','DD.MM.YYYY')
  AND einteilung1_im_sco_swt = 0 AND firma IN (1,5);

  COMMIT;

  UPDATE clcc_ww_kunde_19
  SET einteilung1_im_sco_swt = 2
  WHERE anldatum < TO_DATE('01.01.2009','DD.MM.YYYY')
  AND einteilung1_im_sco_swt = 0 AND firma IN (1,5);

  COMMIT;

  UPDATE clcc_ww_kunde_19
  SET einteilung1_im_sco_swt = 3
  WHERE einteilung1_im_sco_swt = 0
  AND firma IN (2);

  UPDATE clcc_ww_kunde_19
  SET einteilung1_im_sco_swt = 4
  WHERE jahrgang >= 1955
  AND einteilung1_im_sco_swt = 3;

  COMMIT;

  UPDATE clcc_ww_kunde_19
  SET einteilung1_im_sco_swt = (CASE
                                 WHEN NVL(altzujung_d_90,0) >= 0.90 AND NVL(altzujung_d_90,0) <= 1.00 AND NVL(sehraltzugesamt_90,0) > 0.35 AND einteilung NOT IN (11,12,13) AND firma = 2 THEN 1
                                 WHEN NVL(altzujung_d_50,0) >= 0.90 AND NVL(altzujung_d_50,0) <= 1.00 AND NVL(sehraltzugesamt_50,0) > 0.35 AND einteilung NOT IN (11,12,13) AND firma = 5 THEN 1
  ELSE einteilung1_im_sco_swt
  END );

  COMMIT;

  UPDATE clcc_ww_kunde_19
  SET einteilung1_im_sco_swt = 3
  WHERE einteilung1_im_sco_swt = 0 AND firma = 2;

  COMMIT;

  UPDATE clcc_ww_kunde_19
  SET einteilung1_im_sco_swt = 4
  WHERE jahrgang >= 1955 AND einteilung1_im_sco_swt = 3 AND firma IN (1,5);

  COMMIT;

  UPDATE clcc_ww_kunde_19
  SET einteilung1_im_sco_swt = 4
  WHERE einteilung1_im_sco_swt  IN (3) AND jahrgang >= 1950 AND firma = 2;

  COMMIT;


  -- Witt Niederlande Einteilung
  UPDATE clcc_ww_kunde_19
  SET einteilung1_im_sco_swt = case when jahrgang <= 1932 then 1
                                    when jahrgang between 1933 and 1939 then 2
                                    when jahrgang between 1940 and 1954 then 3
                                    when jahrgang >= 1955 then 4
                                else 
                                  3
                                end
  WHERE firma = 15;
  
  COMMIT;

  -- Achtung ! ALTJUNG_FOLGE darf untersaisonal fuer Neukunden nicht ueberschrieben werden, wenn schon einmal gesetzt.
  -- ALTJUNG_AKT jedoch darf schon
  MERGE INTO clcc_ww_kunde_18 a
  USING clcc_ww_kunde_19 b
  ON (a.konto_id_key = b.konto_id_key AND a.firma = b.firma)
  WHEN MATCHED THEN UPDATE
  SET
    a.altjung_akt = einteilung1_im_sco_swt,
    a.altjung_folge = einteilung1_im_sco_swt; 
    
    --CASE WHEN COALESCE(a.altjung_folge,0) != 0 THEN a.altjung_folge ELSE einteilung1_im_sco_swt END;

  COMMIT;


  PROMPT ===========================================
  PROMPT
  PROMPT 20. online_test + shopanteiligkeit ermitteln
  PROMPT
  PROMPT ===========================================

  TRUNCATE TABLE clcc_ww_kunde_20;

  INSERT /*+APPEND*/ INTO clcc_ww_kunde_20
  (
    dwh_cr_load_id,
    konto_id_key,
    firma,
    shop_bbw,
    offline_bbw,
    bbw_ges,
    shopanteiligkeit
  )
   SELECT
    &gbvid,
    konto_id_key,
    f.sg AS firma,
    SUM(CASE WHEN e.verd1bez2 = 'Shopangebot'  then ansprwert ELSE 0 END) shop_bbw,
    SUM(CASE WHEN e.verd1bez2 = 'Printangebot' then ansprwert ELSE 0 END) offline_bbw,
    SUM(ansprwert) bbw_ges,
    ROUND(((SUM(CASE WHEN e.verd1bez2 = 'Shopangebot'  then ansprwert ELSE 0 END) / SUM(ansprwert)) * 100), 2) shopanteiligkeit
  FROM cc_buchung a INNER JOIN cc_erslief b ON (a.erslief = b.wert AND &termin BETWEEN b.dwh_valid_from AND b.dwh_valid_to)
                    INNER JOIN cc_vfart c ON (a.vfart = c.wert AND &termin BETWEEN c.dwh_valid_from AND c.dwh_valid_to)
                    INNER JOIN cc_auftrart d ON (a.auftrart = d.wert AND &termin BETWEEN d.dwh_valid_from AND d.dwh_valid_to)
                    INNER JOIN cc_firma_waepumig_v f ON (a.firma = f.wert AND &termin BETWEEN f.dwh_valid_from AND f.dwh_valid_to)
                    INNER JOIN cc_katart e ON (a.katart = e.wert AND &termin BETWEEN e.dwh_valid_from AND e.dwh_valid_to)
  WHERE c.sg = 0
  AND TRUNC(artnr/10000) <> 99
  AND b.sg = 0
  AND d.sg IN (0,1,2,3)
  AND buchdat = &datum
  AND ansprwert > 0
  AND (a.konto_id_key, f.sg) IN (SELECT DISTINCT konto_id_key,
                                                 firma 
                                 FROM clcc_ww_kunde_18
                                 WHERE kontoart = 1 AND TRUNC(anldatum) = &datum
                                 )  -- Nur Neukunden einteilen
  GROUP BY konto_id_key, f.sg;

  COMMIT;

  EXEC PKG_STATS.GATHERTABLE(user,'clcc_ww_kunde_20')

  MERGE INTO clcc_ww_kunde_18 a
    USING (SELECT konto_id_key, 
                  firma,
                  CASE WHEN ABS(SIGN(shop_bbw)) = 1 AND ABS(SIGN(offline_bbw)) = 0 THEN 1
                       WHEN ABS(SIGN(shop_bbw)) = 1 AND ABS(SIGN(offline_bbw)) = 1 THEN 3
                       WHEN ABS(SIGN(shop_bbw)) = 0 AND ABS(SIGN(offline_bbw)) = 1 THEN 4 ELSE NULL END einteilung,
                  CASE
                       WHEN shopanteiligkeit = 0 THEN 1
                       WHEN shopanteiligkeit > 0 AND shopanteiligkeit <= 10 THEN 2
                       WHEN shopanteiligkeit > 10 AND shopanteiligkeit <= 20 THEN 3
                       WHEN shopanteiligkeit > 20 AND shopanteiligkeit <= 30 THEN 4
                       WHEN shopanteiligkeit > 30 AND shopanteiligkeit <= 40 THEN 5
                       WHEN shopanteiligkeit > 40 AND shopanteiligkeit <= 50 THEN 6
                       WHEN shopanteiligkeit > 50 AND shopanteiligkeit <= 60 THEN 7
                       WHEN shopanteiligkeit > 60 AND shopanteiligkeit <= 70 THEN 8
                       WHEN shopanteiligkeit > 70 AND shopanteiligkeit <= 80 THEN 9
                       WHEN shopanteiligkeit > 80 AND shopanteiligkeit <= 90 THEN 10
                       WHEN shopanteiligkeit > 90 AND shopanteiligkeit < 100 THEN 11
                       WHEN shopanteiligkeit = 100 THEN 12 ELSE NULL END shopanteiligkeit
                  FROM clcc_ww_kunde_20
           ) b
  ON (b.konto_id_key = a.konto_id_key AND b.firma = a.firma)
  WHEN MATCHED THEN
  UPDATE SET
     a.einteilung = b.einteilung,
     a.shopanteiligkeit = b.shopanteiligkeit
  WHERE SUBSTR(a.vtinfogruppe,1,2) IN (71,72,76,92,91);

  COMMIT;

  UPDATE clcc_ww_kunde_18
  SET einteilung = 4
  WHERE COALESCE(einteilung,0) = 0 AND TRUNC(anldatum) = &datum;

  COMMIT;

  UPDATE clcc_ww_kunde_18
  SET online_test = CASE
     WHEN einteilung = 1 AND firma = 1 AND altjung_akt IN (1,2)                                                          THEN 15
     WHEN einteilung = 1 AND firma = 1 AND altjung_akt IN (3,4) 
       AND (
             anldatum BETWEEN TO_DATE('01.01.2026','dd.mm.rrrr') AND TO_DATE('22.03.2026','dd.mm.rrrr')           
           )                                                                                                             THEN 100
     WHEN einteilung = 1 AND firma = 1 AND altjung_akt IN (3,4)              
       AND (   
             anldatum BETWEEN TO_DATE('23.03.2026','dd.mm.rrrr') AND TO_DATE('30.06.2026','dd.mm.rrrr') 
           )                                                                                                             THEN 101
     WHEN einteilung = 1 AND firma != 1                                                                                  THEN 10
     /*
     -- wird HW23 nicht mehr gebraucht (31)
     WHEN einteilung = 3 AND firma = 1 AND anldatum >= TO_DATE ('23.05.2022','dd.mm.rrrr')
           AND SUBSTR(kontonrletzteziffern, 2, 1) IN (1, 3, 5, 7, 9) AND altjung_akt IN (0,3,4)                          THEN 31
     */     
     WHEN einteilung = 3   THEN 30
     /*
     -- wird HW23 nicht mehr gebraucht (41)      
     WHEN einteilung = 4 AND firma = 1 AND anldatum >= TO_DATE ('23.05.2022','dd.mm.rrrr')
           AND SUBSTR(kontonrletzteziffern, 2, 1) IN (1, 3, 5, 7, 9)  AND altjung_akt IN (0,3,4)                         THEN 41     
     */     
     WHEN einteilung = 4                                                                                  THEN 40 ELSE NULL END
  WHERE TRUNC(anldatum) = &datum;

  COMMIT;

  PROMPT Sonderfall kundin: 08539634, die will unbedingt kataloge

  UPDATE clcc_ww_kunde_18
  SET online_test = 10
  WHERE konto_id_key = '08539634'
  AND einteilung = 1;

  COMMIT;

  PROMPT Wenn Kunden aus 100, 101, 102 Altsenioren (1,2) werden, sollen sie sofort in 15 wandern

  UPDATE clcc_ww_kunde_18
  SET online_test = 15
  WHERE online_test IN (100,101,102) AND altjung_akt IN (1,2) 
  --AND SUBSTR(vtinfogruppe,1,2) IN (71,72,76,92,91)
  ;

  COMMIT;

  PROMPT Wenn CH/AT-Kunden aus 10 Altsenioren (1,2) werden, sollen sie sofort in 15 wandern

  UPDATE clcc_ww_kunde_18
  SET online_test = 15
  WHERE online_test IN (10) AND altjung_akt IN (1,2) 
    AND firma in (2,5)
  ;

  COMMIT;
  
  PROMPT Wenn fuer heine-Firmen online_test = 0 oder null (bei kontoart = 1), dann 162 (only online)

  UPDATE clcc_ww_kunde_18
  SET online_test = 162
  WHERE COALESCE(online_test,0) IN (0) 
    AND firma in (21,22,23,25) AND kontoart = 1
  ;

  COMMIT;


  PROMPT ===========================================
  PROMPT
  PROMPT 21. nettobrutto und vierlinien updaten
  PROMPT
  PROMPT ===========================================

  MERGE INTO
   clcc_ww_kunde_18 a
  USING
   (
   SELECT konto_id_key,
          CASE WHEN a.kundenart IN (8,68) THEN 2 --mc
               WHEN a.kundenart IN (7,67) THEN 2 --sc
               WHEN a.kundenart IN (5) THEN 2 -- Auslandskunde (ungeprueft)
               WHEN a.kontosperre = 8 THEN 2 --uv bei SG
               WHEN a.kontosperre = 13 THEN 2 --ew bei SG
               WHEN a.kontosperre = 7 THEN 2 --to bei sg
               WHEN a.kontosperre = 2 THEN 2 --fa bei sg
               WHEN a.kontosperre = 9 THEN 2 --bs bei sg
               WHEN a.kontosperre = 14 THEN 2 --kf bei sg
               WHEN a.kontosperre = 5  THEN 2 --ra
               --WHEN a.kontosperre = 3 THEN 2 --rs     -- SEIT FS23 kommen Retourensuender nicht mehr in dne Ausschluss
               WHEN a.kontosperre = 4 THEN 2 --bt
               WHEN a.kontosperre = 10 THEN 2 --ab
               WHEN a.kontosperre = 15 THEN 2 --ds
               WHEN a.firma = 28 THEN 2 -- Otto Marktplatz
           ELSE 1 END AS nettoausschlusskz,
          CASE
          WHEN firma = 1 THEN
         CASE
           WHEN altjung_akt IN (1,2) AND (a.online_test IN (14,15) OR a.online_test IN (30,40
                                                                                       --,31,41
                                                                                       )) THEN
             1
           WHEN altjung_akt = 3 AND (a.online_test IN (14,15) OR a.online_test IN (30,40
                                                                                       --,31,41
                                                                                       )) THEN
             2
           WHEN altjung_akt = 4 AND (a.online_test IN (14,15) OR a.online_test IN (30,40
                                                                                       --,31,41
                                                                                       )) THEN
             3
           WHEN  
               --altjung_akt IN (3,4) AND (a.online_test BETWEEN 100 AND 118 ) THEN  -- ab HW22
               --altjung_akt IN (3,4) AND (a.online_test BETWEEN 100 AND 138 ) THEN  -- ab FS23
               --altjung_akt IN (3,4) AND (a.online_test BETWEEN 100 AND 116 ) THEN  -- ab HW25
               altjung_akt IN (3,4) AND (a.online_test BETWEEN 100 AND 122 ) THEN  -- ab FS26
             4
           ELSE
             0
         END
          WHEN firma = 2 THEN
          CASE
            WHEN altjung_akt IN (1,2) AND a.online_test IN (15,30,40) THEN
              1
            WHEN altjung_akt IN (3,4) AND a.online_test IN (30,40) AND TO_NUMBER(NVL(TO_CHAR(gebdatum, 'YYYY'),'0')) >= 1950 THEN
              3
            WHEN altjung_akt IN (3,4) AND a.online_test IN (30,40) AND TO_NUMBER(NVL(TO_CHAR(gebdatum, 'YYYY'),'0')) < 1950 THEN
              2
            WHEN a.online_test IN (10) THEN
              4
            ELSE
              0
          END
          WHEN firma = 5 THEN
          CASE
            WHEN altjung_akt IN (1,2) AND a.online_test IN (15,30,40) THEN
              1
            WHEN altjung_akt IN (3,4) AND a.online_test IN (30,40) AND TO_NUMBER(NVL(TO_CHAR(gebdatum, 'YYYY'),'0')) >= 1955 THEN
              3
            WHEN altjung_akt IN (3,4) AND a.online_test IN (30,40) AND TO_NUMBER(NVL(TO_CHAR(gebdatum, 'YYYY'),'0')) < 1955 THEN
              2
            WHEN a.online_test IN (10) THEN
              4
            ELSE
              0
          END
          WHEN firma = 15 THEN
            CASE
                WHEN altjung_akt IN (1,2) AND a.online_test IN (15,30,40) THEN
                1
                WHEN altjung_akt IN (3) AND a.online_test IN (30,40) THEN
                2
                WHEN altjung_akt IN (4) AND a.online_test IN (30,40) THEN
                3
                WHEN altjung_akt IN (3,4) AND a.online_test IN (10) THEN
                4
            ELSE
                0
            END
          ELSE
           -3
          END
            AS vierlinien
   FROM clcc_ww_kunde_18 a
   ) b
  ON ( a.konto_id_key = b.konto_id_key )
  WHEN MATCHED THEN UPDATE
  SET
   a.nettobrutto = b.nettoausschlusskz,
   a.vierlinien  = b.vierlinien;

  COMMIT;


  PROMPT ===========================================
  PROMPT
  PROMPT 22. Kontoart 5 soll keine vtinfogruppe, anlsaison und anldat ausweisen
  PROMPT -  außer die sondervtinfo
  PROMPT
  PROMPT ===========================================

  UPDATE clcc_ww_kunde_18 a
  SET
    a.vtinfogruppe = 0,
    a.vtinfo_ori = 0,
    a.anlsaison = 0,
    a.anldatum = NULL
  WHERE kontoart = 2 AND NVL(vtinfogruppe,'0') NOT LIKE '9%';

  COMMIT;

  UPDATE clcc_ww_kunde_18 a
  SET
   a.vtinfo_ori = 0
  WHERE kontoart = 2 AND NVL(vtinfogruppe,'0') LIKE '9%' AND vtinfogruppe != 9999;

  COMMIT;



 PROMPT ===========================================
 PROMPT
 PROMPT 23. Update der Sprache fuer die Schweizer Firmen (deutscher, franzoesischer oder italienischer Katalog?)
 PROMPT
 PROMPT ===========================================

 MERGE /*+parallel (32) */ INTO clcc_ww_kunde_18 a
  USING 
    (
     SELECT DISTINCT
       plz,
       sprache
     FROM cc_kantoneschweiz_akt_v
     WHERE plz IN (
                   SELECT plz
                   FROM cc_kantoneschweiz_akt_v 
                   GROUP BY plz 
                   HAVING COUNT(DISTINCT sprache) = 1
                  )
        AND sprache > 0
    ) b
  ON (a.plz = TO_CHAR(b.plz))
 WHEN MATCHED THEN UPDATE 
  SET
    a.sprache = b.sprache
  WHERE a.firma IN (2,9,22);

 COMMIT;

 MERGE /*+parallel (32) */ INTO clcc_ww_kunde_18 a
  USING 
    (
     SELECT plz, 
            SUM(DISTINCT sprache) sprache
     FROM cc_kantoneschweiz_akt_v
     WHERE plz IN (
                   SELECT plz
                   FROM cc_kantoneschweiz_akt_v 
                   GROUP BY plz 
                   HAVING COUNT(DISTINCT sprache) > 1
                  )
        AND sprache > 0
     GROUP BY plz
    ) b
  ON (a.plz = TO_CHAR(b.plz))
 WHEN MATCHED THEN UPDATE 
  SET
    a.sprache = CASE WHEN b.sprache = 21 THEN 17 ELSE 0 END
  WHERE a.firma IN (2,9,22);
  
  COMMIT;

  -- Sprachkennzeichen ggf. aus FUP überschreiben
  MERGE INTO clcc_ww_kunde_18 a
  USING (
         SELECT h.email_hash, 
                cv.wert AS sprache
         FROM sc_fu_sprachkennzeichen h JOIN sc_fu_sprachkennzeichen_ver v ON (h.dwh_id = v.dwh_id_head AND v.dwh_valid_to = DATE '9999-12-31')
                                        JOIN sc_ww_sprache_ver sv ON (v.dwh_id_sc_ww_sprache = sv.dwh_id_head AND sv.dwh_valid_to = DATE '9999-12-31')
                                        JOIN cc_sprache cv ON (sv.dwh_id_cc_sprache = cv.dwh_id)        
         WHERE h.email_hash IS NOT NULL
        ) b
  ON (a.email_hash = b.email_hash AND a.firma IN (2,9,22))
  WHEN MATCHED THEN UPDATE
    SET a.sprache = b.sprache
  WHERE a.sprache != b.sprache;     
    
  COMMIT;


  UPDATE clcc_ww_kunde_18
  SET sprache = 0
  WHERE firma IN (2,9,22) AND sprache IS NULL;
  
  COMMIT;
  

  PROMPT ===========================================
  PROMPT
  PROMPT 24. FG-Kennzeichen setzen 
  PROMPT 
  PROMPT ===========================================
  
  MERGE INTO clcc_ww_kunde_18 a 
  USING
  ( 
      SELECT 
            konto_id_key,
            firma,
            MAX(CASE WHEN auftrart = 7 THEN 1 ELSE 0 END)  AS AuftrArt_ST,
            MAX(CASE WHEN auftrart <> 7 THEN 1 ELSE 0 END) AS AuftrArt_DH
     FROM cc_buchung a
      WHERE a.firma = 1 -- nur WW
      AND a.buchdat = &datum
      AND ansprwert > 0
      GROUP BY konto_id_key, firma
  ) b
  ON (a.konto_id_key = b.konto_id_key AND a.firma = b.firma)
  WHEN MATCHED THEN UPDATE 
  SET a.fgaktiv =
  CASE
      WHEN b.auftrart_st = 1 AND COALESCE(a.fgaktiv, 0) = 2 THEN 3 -- Misch-Käufer (Bestandskunden): von Distanz zu Stationär
      WHEN b.auftrart_dh = 1 AND COALESCE(a.fgaktiv, 0) = 1 THEN 3 -- Misch-Käufer (Bestandskunden): von Stationär zu Distanz
      WHEN b.auftrart_st = 1 AND b.auftrart_dh = 0 AND COALESCE(a.fgaktiv, 0) = 0 THEN 1 -- Neukunden, 'reiner FG-Käufer' -- 1
      WHEN b.auftrart_st = 0 AND b.auftrart_dh = 1 AND COALESCE(a.fgaktiv, 0) = 0 THEN 2 -- Neukunden, 'reiner Distanz-Käufer' -- 2
      WHEN b.auftrart_st = 1 AND b.auftrart_dh = 1 AND COALESCE(a.fgaktiv, 0) = 0 THEN 3 -- Neukunden, 'Misch-Käufer' -- 3
      ELSE COALESCE(a.fgaktiv, 0) --Neukunden 'unbekannt' -- 0
  END
  WHERE a.firma = 1
  AND   a.kontoart IN (1,5);
  
  COMMIT;
  
 
  UPDATE clcc_ww_kunde_18 kd
  SET fgaktiv = 
  CASE
      WHEN kd.kundenart = 20           THEN 1 -- Neukunden ohne Buchung, reiner FG-Käufer
      WHEN kd.wkz = 960 AND kd.iwl = 0 THEN 1 -- Neukunden ohne Buchung, reiner FG-Käufer
      ELSE 0
  END
  WHERE fgaktiv IS NULL
  AND firma = 1;
  
  COMMIT;

  PROMPT ===========================================
  PROMPT
  PROMPT 25. Modalwert/Imodalwert (praefartgrdobaktiv/praefartgrdobinaktiv) für sheego
  PROMPT
  PROMPT ===========================================
  
  MERGE INTO clcc_ww_kunde_18 a
   USING
   (
     SELECT konto_id_key, 
            artgr_gruppe 
     FROM
         (
         SELECT y.*, RANK() OVER (PARTITION BY konto_id_key ORDER BY anzahl DESC, artgr_gruppe DESC) AS rang  
         FROM
         (
          SELECT konto_id_key,
                 artgr_gruppe,
                 COUNT(*) AS anzahl
          FROM
           (
              SELECT a.konto_id_key, 
                     c.artnr, 
                     f.artgr_gruppe, 
                     f.artgr
              FROM clcc_ww_kunde_18 a JOIN cc_vtinfogrp_akt_v b ON a.vtinfogruppe = b.sg
                                      JOIN cc_buchung c ON a.konto_id_key = c.konto_id_key
                                      JOIN cc_art_Akt_v d ON c.art_id = d.art_id
                                      JOIN cc_marktkz_akt_v e ON d.marktkz = e.wert
                                      JOIN (SELECT * FROM  cc_sheego_dob_groessen_ref WHERE sg_marktkz NOT IN (SELECT sg_marktkz FROM cc_sheego_ausschlusse_modalwert)) f ON f.sg_marktkz = e.sg AND f.artgr = c.artgr
              WHERE a.firma = 44
                AND b.verd1bez3 = 'NK 1'
                AND c.vfart NOT IN (2,3,4)
                AND c.buchdat >= &hjanfang
                AND c.ansprmenge > 0
            )
           GROUP BY konto_id_key, artgr_gruppe
         ) 
     y )
     WHERE rang = 1
    ) b
    ON (a.konto_id_key = b.konto_id_key)
   WHEN MATCHED THEN UPDATE SET 
    a.praefartgrdobaktiv = b.artgr_gruppe
   WHERE a.firma = 44
    AND COALESCE(a.praefartgrdobaktiv,0) != COALESCE(b.artgr_gruppe,0);

   COMMIT; 
   
  PROMPT ===========================================
  PROMPT
  PROMPT 26. Referenzaufloesung
  PROMPT
  PROMPT ===========================================

  TRUNCATE TABLE clcc_ww_kunde_22;

  INSERT /*+APPEND*/ INTO
    clcc_ww_kunde_22
  (
    dwh_cr_load_id,
    adresshdl,
    altjungakt,
    altjungfolge,
    altwabherkunft,
    anlagedat,
    anlaktionscode,
    anlaktionscoderea,
    anlauftrart,
    anldat,
    anldatlv,
    anlvtsaison,
    anlvtsaisonrea,
    anlweg1,
    anlweg2,
    anlweg3,
    anrede,
    ansprwert,
    ansprohnestationaerwert,
    anzauftr,
    anzkatletztauftr,
    anzpostret,
    appauftrdaterst,
    bonikl,
    briefbotenbezirk,
    creationlpremium,
    datenschutzkonto,
    eigenfremdkauf, 
    emailanldat,
    emailhash,
    emailhdl,
    emailherkunft,
    email_key,
    emailverweigert,
    emailvorhanden, 
    ersartwunsch,
    fax,
    fg,
    fgaktiv,
    filialwerbungwunsch,
    firma,
    gebdat,
    gebdatverweigert,
    gebmonat,
    gebjahr,
    imaltwabherkunft,
    imvtinfogrp,
    kdart,
    kdloginaktiv,
    kdloginaktivdat,
    kdloginlinksenddat,
    kontoart,
    kontonrletzteziffern,
    konto_id_key,
    kontosperre,
    kontrolladrkat,
    kreditlimit,
    kundeid_key,
    land,
    lansprwert,
    lansprohnestationaerwert,
    lanzauftr,
    letztauftrdat,
    lnumswert,
    lretwert,
    mahnebene,
    mahnstrang,
    mehrlinien,
    mobilnrvorhanden,
    nachbarabg,
    nachnameinitiale,
    nettoausschluss,
    nixi,
    nlabostatus,
    nlanldaterst,
    nlanldatletzt,
    nltyp,
    nlwunsch,
    numswert,
    onlinetest,
    ostwest,
    plz,
    plzzusatz,
    postfach,
    praefartgrdobaktiv,
    praefartgrdobinaktiv,
    provinzgrp,
    region,
    retwert,
    rkumstelldat,
    rufnrverweigert,
    serviceinforechnungversand,
    servicemailaktiv,
    shopanteiligkeit,
    sprache,
    sst,
    telefon,
    telefonalternativ,
    telefonfirma,
    telefonvorhanden,
    telemarkwunsch,
    titel,
    ueberschneider,
    verweiskonto_id_key,
    vorname,
    vorteilsnrangabe,
    vtinfogrp,
    vtinfogrpstationaer,
    werbmitsperre,
    zustelldienst
  )
SELECT
  a.dwh_cr_load_id,
  adrhdlkz.wert AS adrhdl,                                                 --Referenz
  CASE WHEN a.firma IN (1,2,5,15) THEN COALESCE(altjung_akt.wert,0)
   ELSE -3
  END AS altjung_akt,                                                      --Referenz: Default ist 0 = unbekannt (IM), nur gueltig fuer Firma 1,2,5
  CASE WHEN a.firma IN (1,2,5,15) THEN COALESCE(altjung_folge.wert,0)
  ELSE -3
  END AS altjung_folge,                                                    --Referenz: Default ist 0 = unbekannt (IM), nur gueltig fuer Firma 1,2,5
  CASE TRUNC(a.vtinfogruppe/100) WHEN 62 THEN COALESCE(altwabkz.wert,0)
   ELSE 0
  END AS altwabkz,                                                         --Referenz: Default ist 0 = unbekannt (IM)
  a.anlagedatum AS anlagedat,
  COALESCE(anlcode.wert,0) AS anlaktionscode,                              --Referenz: (null/0 = unbekannt)
  COALESCE(anlcoderea.wert,0) AS anlaktionscoderea,                        --Referenz
  COALESCE(anlweg.wert,0) AS anlauftrart,                                  --Referenz, Left outer Join da NULL hier einen Wert hat, naemlich "unbekannt"
  a.anldatum AS anldat,
  a.anldatumlv AS anldatlv,
  COALESCE(cc_anlvtsaison.wert,0) AS anlvtsaison,                          --Referenz
  cc_anlvtsaisonrea.wert AS anlvtsaisonrea,
  TO_CHAR(a.wkz) AS anlweg1,                                               --wegen USA VARCHAR2
  a.iwl AS anlweg2,
  NULL AS anlweg3,                                                         --nur fuer Frankreich, fuer Stammgeschaeft nicht verwendet, keine Referenz --> "NULL"
  anrede.wert AS anrede,                                                   --Referenz
  a.bbw AS ansprwert,
  a.bbwohnestationaer AS ansprohnestationaerwert,
  a.anzbestellungen AS anzauftr,
  NULL AS anzkatletztau1ftr,                                               --nur fuer Frankreich, fuer Stammgeschaeft nicht verwendet, keine Referenz --> "NULL"
  -3 AS anzpostret,                                                        --nur fuer Frankreich, fuer Stammgeschaeft nicht verwendet, Referenz --> -3
  appauftrdaterst,  
  bkl.wert AS bonikl,                                                      --Referenz
  a.briefbotenbezirk,
  CASE WHEN a.firma = 6 THEN clpremium.wert ELSE -3 END AS creationlpremium,--Referenz 
  datenschutz.wert AS datenschutz,                                         --Referenz
  eigenfremdkauf.wert AS eigenfremdkauf,                                   --Referenz
  a.emailanldatum AS emailanldat,
  a.email_hash AS emailhash,
  -3 AS emailhdl,                                                          --nur fuer Frankreich, fuer Stammgeschaeft nicht verwendet, Referenz --> -3
  nladrherkunft.wert AS emailherkunft,                                     --Referenz
  a.emailprivat_key AS email_key,  
  emailverw.wert AS emailverweigert,                                       --Referenz
  emailvorh.wert AS emailvorhanden,                                        --Referenz
  ersatzart.wert AS ersartwunsch,                                          --Referenz
  a.faxprivatvorwahl AS fax,
  CASE WHEN a.firma = 1 THEN fg.wert
    ELSE
      -3
    END AS fg,                                                             --Referenz, nur fuer Witt-Deutschland setzen
  COALESCE(ccfgaktiv.wert,-3)
   AS fgaktiv,                                                        --Referenz, nur fuer Witt-Deutschland setzen
  fwerbwunsch.wert AS filialwerbungwunsch,                                 --Referenz
  firma.wert AS firma,                                                     --Referenz
  a.gebdatum AS gebdat,
  gebdatverw.wert AS gebdatverweigert,                                     --Referenz
  TO_NUMBER(TO_CHAR(a.gebdatum,'MM')) AS gebmonat,
  TO_CHAR(a.gebdatum,'YYYY') AS gebjahr,
  COALESCE(imaltwabherk.wert,0) AS imaltwabherkunft,                       --Referenz: Default ist 0 = unbekannt (IM)
  CASE WHEN a.vtinfo_ori = 0
    THEN 0
    ELSE
        COALESCE(imvtinfogrp.wert,0) END AS imvtinfogrp,                   --Referenz
  kdart.wert AS kdart,                                                     --Referenz
  kdloginaktivkz.wert AS kdloginaktiv,                                     --Referenz
  a.kdloginaktdat AS kdloginaktivdat,
  a.kdloginlinkdat AS kdloginlinksenddat,
  kontoart.wert AS kontoart,
  a.kontonrletzteziffern AS kontonrletzteziffern,
  a.konto_id_key,
  kontosperre.wert AS kontosperre,                                         --Referenz
  a.testgruppe AS kontrolladrkat,
  a.kreditlimit AS kreditlimit,
  a.kundeid_key AS kundeid_key,
  land.wert  AS land,
  COALESCE(a.lbbw,0) AS lansprwert,
  COALESCE(a.lbbwohnestationaer,0) AS lansprohnestationaerwert,
  COALESCE(a.lanzbestellungen,0) AS lanzauftr,
  a.datletztebest AS letztauftrdat,
  COALESCE(a.lnums,0) AS lnumswert,
  COALESCE(a.lretouren,0) AS lretwert,
  mahneb.wert AS mahnebene,                                                --Referenz
  mahnstrang.wert AS mahnstrang,                                           --Referenz
  a.vierlinien AS mehrlinien,
  mobilnrvorh.wert AS mobilnrvorhanden,                                    --Referenz
  nachbarabg.wert AS nachbarabg,                                           --Referenz
  a.nachnameinitiale AS nachnameinitiale,
  a.nettobrutto AS nettoausschluss,
  COALESCE(nixikz.wert,1) AS nixi,                                         --Referenz (1, da NIXI = 1 --> kein NIXI bedeutet)
  nlabostatus.wert AS nlabostatus,                                         --Referenz
  a.nlanldatumerst AS nlanldaterst,
  a.nlanldatumletzt AS nlanldatletzt,
  CASE WHEN nltyp.wert <= 0 THEN 1 ELSE nltyp.wert END AS nltyp,           --Referenz (IM-Modifikation: Wenn unbekannt oder nichts gefunden wurde --> auf 1 schluesseln, kein Newsletter)
  nlkz.wert AS nlwunsch,                                                   --Referenz
  COALESCE(a.nums,0) AS numswert,
  COALESCE(onlinetest.wert,0) AS onlinetest,                               --Referenz (IM)
  CASE WHEN a.firma IN (1,3,6,8,18,21,44) THEN ostwest.wert
  ELSE -3 END AS ostwest,                                                  --Referenz (ostwest): Ostwest macht nur Sinn bei Firma 1. 0 steht fuer unbekannt. Fuer Auslaender --> -3
  a.plz,
  a.plzzusatz,
  postfach.wert AS postfach,                                               --Referenz
  COALESCE(praefartgrdobaktiv,0) AS praefartgrdobaktiv,  
  COALESCE(praefartgrdobinaktiv,0) AS praefartgrdobinaktiv,
  a.provinzcode AS provinzgrp,
  COALESCE(region.wert,0) AS region,                                       --Referenz, wernn es sich nicht mappen laesst --> unbekannt
  --a.bundesland AS region,
  a.retouren AS retwert,
  a.rkumstellung AS rkumstelldat,
  rufnrverw.wert AS rufnrverweigert,                                       --Referenz
  serviceinforechnungversand.wert AS serviceinforechnungversand,           --Referenz
  servmail.wert AS servicemailaktiv,                                       --Referenz
  shopanteil.wert AS shopanteiligkeit,                                     --Referenz 
  CASE WHEN a.firma IN (2,9,22) THEN a.sprache ELSE -3 END AS sprache,     --Referenz 
  1 AS sst, -- 1 steht fuer Stammgeschaeft
  a.telefonprivatvorwahl AS telefon,
  NULL AS telefonalternativ,                                               -- nur fuer USA
  a.telefonfirmavorwahl AS telefonfirma,
  televorh.wert AS telefonvorhanden,                                       --Referenz
  telemarkkz.wert AS telemarkwunsch,                                       --Referenz
  a.titel,
  ueberschneider.wert AS ueberschneider,                                   -- Referenz
  CASE WHEN a.firma = 18 THEN NULL ELSE a.verweiskonto_id_key END AS verweiskonto_id_key,
  a.vorname,
  vorteilsnrangabe.wert AS vorteilsnrangabe,                               --Referenz
  CASE WHEN a.vtinfogruppe = 0
    THEN 0
      ELSE
     COALESCE(vtinfogrp.wert,0) END AS vtinfogrp,                         --Referenz
  COALESCE(vtinfogrpstationaer.wert, -3) AS vtinfogrpstationaer,          --Referenz
  werbmit.wert AS werbmitsperre,                                          --Referenz
  versandkz.wert AS zustelldienst                                         --Referenz
  FROM
    clcc_ww_kunde_18 a
  INNER JOIN cc_adresshdl adrhdlkz                               --vermietungsschutzadr
                        ON a.dwh_id_cc_adrhdl  = adrhdlkz.dwh_id AND &termin BETWEEN adrhdlkz.dwh_valid_from AND adrhdlkz.dwh_valid_to
  INNER JOIN cc_altjung altjung_akt                                    --altjung_akt (IM-Spalte)
                        ON CASE WHEN firma IN (1,2,5,15) THEN NVL(a.altjung_akt,0) ELSE -3 END = altjung_akt.sg AND &termin BETWEEN altjung_akt.dwh_valid_from AND altjung_akt.dwh_valid_to
  INNER JOIN cc_altjung altjung_folge                                  --altjung_folge (IM-Spalte)
                        ON CASE WHEN firma IN (1,2,5,15) THEN NVL(a.altjung_folge,0) ELSE -3 END = altjung_folge.sg AND &termin BETWEEN altjung_folge.dwh_valid_from AND altjung_folge.dwh_valid_to
  INNER JOIN cc_altwabherkunft altwabkz                                    --altwabkz (IM-Spalte)
                        ON NVL(a.altwabkz_ori,0) = altwabkz.sg AND &termin BETWEEN altwabkz.dwh_valid_from AND altwabkz.dwh_valid_to
  INNER JOIN cc_imaltwabherkunft imaltwabherk                              --imaltwabherk (IM-Spalte)
                        ON NVL(a.altwabkz_ori,0) = imaltwabherk.sg AND &termin BETWEEN imaltwabherk.dwh_valid_from AND imaltwabherk.dwh_valid_to
  INNER JOIN cc_anlvtsaison cc_anlvtsaison                     -- anlsaison (IM-Spalte)
                        ON (a.anlsaison = cc_anlvtsaison.sg AND &termin BETWEEN cc_anlvtsaison.dwh_valid_from AND cc_anlvtsaison.dwh_valid_to)
  INNER JOIN cc_anlvtsaisonrea cc_anlvtsaisonrea               --anlvtsaisonrea (IM-Spalte)
                        ON COALESCE(substr(anlsaison_rea,5,1) || substr(anlsaison_rea,3,2),'0') = TO_CHAR(cc_anlvtsaisonrea.sg)
                                                AND &termin BETWEEN cc_anlvtsaisonrea.dwh_valid_from AND cc_anlvtsaisonrea.dwh_valid_to
  LEFT OUTER JOIN cc_anlauftrart anlweg                           --anlauftrart
                        ON a.anlweg = anlweg.sg AND &termin BETWEEN anlweg.dwh_valid_from AND anlweg.dwh_valid_to
  INNER JOIN cc_anlaktionscode anlcode                                         --anlcode (IM-Spalte)
                        ON CASE WHEN a.anlcode IS NULL THEN 'NULL' ELSE TO_CHAR(a.anlcode) END = TO_CHAR(anlcode.sg)
                            AND &termin BETWEEN anlcode.dwh_valid_from AND anlcode.dwh_valid_to
  INNER JOIN cc_anlaktionscoderea anlcoderea                             --anlcoderea
                        ON a.anlcode_rea = anlcoderea.sg 
                            AND &termin BETWEEN anlcoderea.dwh_valid_from AND anlcoderea.dwh_valid_to
  INNER JOIN cc_anrede anrede                                           --anrede
                        ON a.dwh_id_cc_anrede = anrede.dwh_id  AND &termin BETWEEN anrede.dwh_valid_from AND anrede.dwh_valid_to
  INNER JOIN cc_bonikl bkl                                              --bonikl
                        ON a.dwh_id_cc_bonikl = bkl.dwh_id  AND &termin BETWEEN bkl.dwh_valid_from AND bkl.dwh_valid_to
  INNER JOIN cc_creationlpremium clpremium                          --kontoart (IM-Spalte)
                        ON COALESCE(a.creationlpremium,-3) = clpremium.sg AND &termin BETWEEN clpremium.dwh_valid_from AND clpremium.dwh_valid_to 
  INNER JOIN cc_datenschutzkonto datenschutz    -- Datenschutzkonto
                        ON a.dwh_id_cc_datenschutzkonto = datenschutz.dwh_id AND &termin BETWEEN datenschutz.dwh_valid_from AND datenschutz.dwh_valid_to  
  INNER JOIN cc_eigenfremdkauf eigenfremdkauf
                        ON a.dwh_id_cc_eigenfremdkauf = eigenfremdkauf.dwh_id AND &termin BETWEEN eigenfremdkauf.dwh_valid_from AND eigenfremdkauf.dwh_valid_to
  INNER JOIN cc_emailherkunft nladrherkunft                             --emailherkunft
                        ON a.dwh_id_cc_emailherkunft = nladrherkunft.dwh_id  AND &termin BETWEEN nladrherkunft.dwh_valid_from AND nladrherkunft.dwh_valid_to
  INNER JOIN cc_emailverweigert emailverw                               --emailverweigert
                        ON a.dwh_id_cc_emailverweigert = emailverw.dwh_id  AND &termin BETWEEN emailverw.dwh_valid_from AND emailverw.dwh_valid_to
  INNER JOIN cc_emailvorhanden emailvorh
                        ON a.dwh_id_cc_emailvorhanden = emailvorh.dwh_id AND &termin BETWEEN emailvorh.dwh_valid_from AND emailvorh.dwh_valid_to
  INNER JOIN cc_ersartwunsch ersatzart                                  --ersartwunsch
                        ON a.dwh_id_cc_ersartwunsch = ersatzart.dwh_id AND &termin BETWEEN ersatzart.dwh_valid_from AND ersatzart.dwh_valid_to
  INNER JOIN cc_fg fg                                                    -- fg
                        ON a.dwh_id_cc_fg = fg.dwh_id AND &termin BETWEEN fg.dwh_valid_from AND fg.dwh_valid_to
  INNER JOIN cc_fgaktiv ccfgaktiv                                        -- fgaktiv
                        ON COALESCE(a.fgaktiv,-3) = ccfgaktiv.sg AND &termin BETWEEN ccfgaktiv.dwh_valid_from AND ccfgaktiv.dwh_valid_to
  INNER JOIN cc_filialwerbungwunsch fwerbwunsch                          -- filialwerbungwunsch
                        ON a.dwh_id_cc_filialwerbungwunsch = fwerbwunsch.dwh_id AND &termin BETWEEN fwerbwunsch.dwh_valid_from AND fwerbwunsch.dwh_valid_to
  INNER JOIN sc_ww_vertrgebiet_ver sc ON (a.firma = sc.firma_im         --firma (Join ueber SC notwendig, da SG = 1 sowohl 1 als auch 37 sein kann in CC-Referenz)
                                                     AND &termin BETWEEN sc.dwh_valid_from AND sc.dwh_valid_to)
  INNER JOIN cc_firma_waepumig_v firma
                        ON (a.dwh_id_cc_firma = firma.dwh_id)
  INNER JOIN cc_mobilnrvorhanden mobilnrvorh
                        ON a.dwh_id_cc_mobilnrvorhanden = mobilnrvorh.dwh_id AND &termin BETWEEN mobilnrvorh.dwh_valid_from AND emailvorh.dwh_valid_to
  INNER JOIN cc_gebdatverweigert gebdatverw
                        ON (a.dwh_id_cc_gebdatverweigert = gebdatverw.dwh_id AND &termin BETWEEN gebdatverw.dwh_valid_from AND gebdatverw.dwh_valid_to)
  INNER JOIN cc_vtinfogrp imvtinfogrp                 -- imvtinfogruppe (IM-Spalte)
                        ON CASE WHEN kontoart = 2 THEN COALESCE(a.vtinfo_ori, 0) ELSE a.vtinfo_ori END = imvtinfogrp.sg  AND &termin BETWEEN imvtinfogrp.dwh_valid_from  AND  imvtinfogrp.dwh_valid_to
  INNER JOIN cc_kdloginaktiv kdloginaktivkz                             --kdloginaktiv
                        ON a.dwh_id_cc_kdloginaktiv = kdloginaktivkz.dwh_id AND &termin BETWEEN kdloginaktivkz.dwh_valid_from AND kdloginaktivkz.dwh_valid_to
  INNER JOIN cc_kontosperre kontosperre                          --kontosperre
                        ON a.dwh_id_cc_kontosperre = kontosperre.dwh_id AND &termin BETWEEN kontosperre.dwh_valid_from AND kontosperre.dwh_valid_to
  INNER JOIN cc_kontoart kontoart                          --kontoart (IM-Spalte)
                        ON a.kontoart = kontoart.sg AND &termin BETWEEN kontoart.dwh_valid_from AND kontoart.dwh_valid_to
  INNER JOIN cc_kdart kdart                                         --kundenart
                        ON a.dwh_id_cc_kdart = kdart.dwh_id AND &termin BETWEEN kdart.dwh_valid_from AND kdart.dwh_valid_to
  INNER JOIN cc_land land                    --land
                        ON a.dwh_id_cc_land = land.dwh_id AND &termin BETWEEN land.dwh_valid_from AND land.dwh_valid_to
  INNER JOIN cc_mahnebene mahneb                                        --mahnebene
                        ON a.dwh_id_cc_mahnebene = mahneb.dwh_id AND &termin BETWEEN mahneb.dwh_valid_from AND mahneb.dwh_valid_to
  INNER JOIN cc_mahnstrang mahnstrang                                   --mahnstrang
                        ON a.dwh_id_cc_mahnstrang = mahnstrang.dwh_id AND &termin BETWEEN mahnstrang.dwh_valid_from AND mahnstrang.dwh_valid_to
  INNER JOIN cc_nachbarabg nachbarabg                                   --nachbarabg
                        ON a.dwh_id_cc_nachbarabg = nachbarabg.dwh_id AND &termin BETWEEN nachbarabg.dwh_valid_from AND nachbarabg.dwh_valid_to
  INNER JOIN cc_nixi nixikz                                --nixi
                        ON a.nixikz = nixikz.sg AND &termin BETWEEN nixikz.dwh_valid_from AND nixikz.dwh_valid_to
  INNER JOIN cc_nlabostatus nlabostatus                                 --nlabostatus
                        ON a.nlabostatus = nlabostatus.sg AND &termin BETWEEN nlabostatus.dwh_valid_from AND nlabostatus.dwh_valid_to
  INNER JOIN cc_nltyp nltyp                                             --nltyp
                        ON a.dwh_id_cc_nltyp = nltyp.dwh_id AND &termin BETWEEN nltyp.dwh_valid_from AND nltyp.dwh_valid_to
  INNER JOIN cc_nlwunsch nlkz                               --nlwunsch
                        ON a.nlkz = nlkz.sg AND &termin BETWEEN nlkz.dwh_valid_from AND nlkz.dwh_valid_to
  INNER JOIN cc_onlinetest onlinetest                 --onlinetest (IM-Spalte)
                        ON (CASE
                             WHEN online_test IS NULL
                              THEN
                                  '0'
                            ELSE
                                   &vtsaison || '-' || CASE WHEN LENGTH(a.online_test) = 2 THEN TO_CHAR('0') END || a.online_test
                            END = onlinetest.sg
                                               AND &termin BETWEEN onlinetest.dwh_valid_from AND onlinetest.dwh_valid_to
                           )
  INNER JOIN cc_ostwest ostwest                                 -- ostwest (IM-Spalte)
                        ON CASE
                             WHEN firma.sg IN (1,3,6,8,18,21,44) AND COALESCE(land.sg,0) = 4
                              THEN
                                CASE WHEN a.vtgebiet IS NULL THEN 'NULL' ELSE TO_CHAR(a.vtgebiet) END
                             WHEN firma.sg IN (1,3,6,8,18,21,44) AND COALESCE(land.sg,0) != 4
                              THEN
                                '0' -- unbekannt, da keine deutsche PLZ
                            ELSE
                            '-3' -- nicht Deutschland...
                           END
                             = TO_CHAR(ostwest.sg)
                          AND &termin BETWEEN ostwest.dwh_valid_from AND ostwest.dwh_valid_to
  INNER JOIN cc_postfach postfach    -- Postfach
                        ON a.dwh_id_cc_postfach = postfach.dwh_id AND &termin BETWEEN postfach.dwh_valid_from AND postfach.dwh_valid_to
  LEFT OUTER JOIN cc_region region    -- region
                        ON UPPER(COALESCE(a.bundesland,'unbekannt')) = UPPER(region.bez) AND &termin BETWEEN region.dwh_valid_from AND region.dwh_valid_to
  INNER JOIN cc_rufnummerverweigert rufnrverw                           --rufnummerverweigert
                        ON a.dwh_id_cc_rufnrverweigert = rufnrverw.dwh_id AND &termin BETWEEN rufnrverw.dwh_valid_from AND rufnrverw.dwh_valid_to
  INNER JOIN cc_shopanteiligkeit shopanteil                               --servicemailaktiv
                        ON COALESCE(a.shopanteiligkeit,0) = shopanteil.sg AND &termin BETWEEN shopanteil.dwh_valid_from AND shopanteil.dwh_valid_to  
  INNER JOIN cc_serviceinforechnungversand serviceinforechnungversand
                        ON a.dwh_id_cc_serviceinfoversand = serviceinforechnungversand.dwh_id AND &termin BETWEEN serviceinforechnungversand.dwh_valid_from AND serviceinforechnungversand.dwh_valid_to
  INNER JOIN cc_servicemailaktiv servmail                               --servicemailaktiv
                        ON a.dwh_id_cc_servicemailaktiv = servmail.dwh_id AND &termin BETWEEN servmail.dwh_valid_from AND servmail.dwh_valid_to
  INNER JOIN cc_telefonvorhanden televorh                               --telefonvorhanden
                        ON a.dwh_id_cc_telefonvorhanden = televorh.dwh_id AND &termin BETWEEN televorh.dwh_valid_from AND televorh.dwh_valid_to
  INNER JOIN cc_telemarkwunsch telemarkkz                               --telemarkwunsch
                        ON a.dwh_id_cc_telemarkwunsch = telemarkkz.dwh_id AND &termin BETWEEN telemarkkz.dwh_valid_from AND telemarkkz.dwh_valid_to
  INNER JOIN cc_ueberschneider ueberschneider                  --
                        ON COALESCE(a.ueberschneidungskz,0) = ueberschneider.sg AND &termin BETWEEN ueberschneider.dwh_valid_from AND ueberschneider.dwh_valid_to  
  INNER JOIN cc_vorteilsnrangabe vorteilsnrangabe                  --vorteilsnrangabe
                        ON a.dwh_id_cc_vorteilsnrangabe = vorteilsnrangabe.dwh_id AND &termin BETWEEN vorteilsnrangabe.dwh_valid_from AND vorteilsnrangabe.dwh_valid_to
  INNER JOIN cc_vtinfogrp vtinfogrp                   --vtinfogruppe
                        ON a.vtinfogruppe = vtinfogrp.sg AND &termin BETWEEN vtinfogrp.dwh_valid_from AND  vtinfogrp.dwh_valid_to
  LEFT  JOIN cc_vtinfogrp vtinfogrpstationaer
                        ON a.vtinfogrpstationaer = vtinfogrpstationaer.sg
  INNER JOIN cc_werbemittelsperre werbmit                          --werbemittelsperre
                        ON a.dwh_id_cc_werbemittelsperre = werbmit.dwh_id  AND &termin BETWEEN werbmit.dwh_valid_from AND werbmit.dwh_valid_to
  INNER JOIN cc_zustelldienst versandkz                                 --zustelldienst
                        ON a.dwh_id_cc_zustelldienst = versandkz.dwh_id AND &termin BETWEEN versandkz.dwh_valid_from AND versandkz.dwh_valid_to
  ;
  
  COMMIT;

  EXEC PKG_STATS.GATHERTABLE (user, 'clcc_ww_kunde_22');
  


  PROMPT =========================================================================
  PROMPT 27. Pruefung, ob Referenzaufloesung daten verliert.
  PROMPT Wenn dies der Fall ist, dann wird ein Fehler geworfen, ansonsten laeuft
  PROMPT alles normal weiter
  PROMPT =========================================================================

  SET SERVEROUTPUT ON

  DECLARE
    v_anz_vorref PLS_INTEGER;
    v_anz_nachref PLS_INTEGER;
  BEGIN
    SELECT COUNT(*)
    INTO    v_anz_vorref
    FROM    clcc_ww_kunde_18;

    SELECT COUNT(*)
    INTO    v_anz_nachref
    FROM    clcc_ww_kunde_22;

    IF v_anz_nachref != v_anz_vorref THEN
        RAISE_APPLICATION_ERROR(-20029,'Referenzaufloesung generiert zu wenig oder zu viel Datensaetze!');
    ELSE
      DBMS_OUTPUT.PUT_LINE('Alles gut, weiter machen!');
    END IF;
  END;
  /


  PROMPT ===========================================
  PROMPT
  PROMPT 28. letzte Cleanse-Tabelle fuellen 
  PROMPT    - doppelte raus
  PROMPT
  PROMPT ===========================================

  TRUNCATE TABLE clcc_ww_kunde;

  INSERT /*+APPEND*/ INTO clcc_ww_kunde
  (
   adresshdl,
   altjungakt,
   altjungfolge,
   altwabherkunft,
   anlagedat,
   anlaktionscode,
   anlaktionscoderea,
   anlauftrart,
   anldat,
   anldatlv,
   anlvtsaison,
   anlvtsaisonrea,
   anlweg1,
   anlweg2,
   anlweg3,
   anrede,
   ansprwert,
   ansprohnestationaerwert,
   anzauftr,
   anzkatletztauftr,
   anzpostret,
   appauftrdaterst,
   bonikl,
   briefbotenbezirk,
   creationlpremium,
   datenschutzkonto,
   dwh_cr_load_id,
   eigenfremdkauf,
   emailanldat,
   emailhash,
   emailhdl,
   emailherkunft,
   emailverweigert,
   emailvorhanden,
   ersartwunsch,
   fax,
   fg,
   fgaktiv,
   filialwerbungwunsch,
   firma,
   gebdat,
   gebdatverweigert,
   gebmonat,
   gebjahr,
   imaltwabherkunft,
   imvtinfogrp,
   kdart,
   kdloginaktiv,
   kdloginaktivdat,
   kdloginlinksenddat,
   kontoart,
   kontonrletzteziffern,
   konto_id_key,
   kontosperre,
   kontrolladrkat,
   kreditlimit,
   kundeid_key,
   land,
   lansprwert,
   lansprohnestationaerwert,
   lanzauftr,
   letztauftrdat,
   lnumswert,
   lretwert,
   mahnebene,
   mahnstrang,
   mehrlinien,
   mobilnrvorhanden,
   nachbarabg,
   nachnameinitiale,
   nettoausschluss,
   nixi,
   nlabostatus,
   nlanldaterst,
   nlanldatletzt,
   nltyp,
   nlwunsch,
   numswert,
   onlinetest,
   ostwest,
   plz,
   plzzusatz,
   postfach,
   praefartgrdobaktiv,      
   praefartgrdobinaktiv,
   provinzgrp,
   region,
   retwert,
   rkumstelldat,
   rufnrverweigert,
   serviceinforechnungversand,
   servicemailaktiv,
   shopanteiligkeit,
   sst,
   telefon,
   telefonalternativ,
   telefonfirma,
   telefonvorhanden,
   telemarkwunsch,
   titel,
   ueberschneider,
   verweiskonto_id_key,
   vorname,
   vorteilsnrangabe,
   vtinfogrp,
   vtinfogrpstationaer,
   werbmitsperre,
   zustelldienst,
   sprache,
   email_key
   )
SELECT
   adresshdl,
   altjungakt,
   altjungfolge,
   altwabherkunft,
   anlagedat,
   anlaktionscode,
   anlaktionscoderea,
   anlauftrart,
   anldat,
   anldatlv,
   anlvtsaison,
   anlvtsaisonrea,
   anlweg1,
   anlweg2,
   anlweg3,
   anrede,
   ansprwert,
   ansprohnestationaerwert,
   anzauftr,
   anzkatletztauftr,
   anzpostret,
   appauftrdaterst,
   bonikl,
   briefbotenbezirk,
   creationlpremium,
   datenschutzkonto,
   dwh_cr_load_id,
   eigenfremdkauf,
   emailanldat,
   emailhash,
   emailhdl,
   emailherkunft,
   emailverweigert,
   emailvorhanden,
   ersartwunsch,
   fax,
   fg,
   fgaktiv,
   filialwerbungwunsch,
   firma,
   gebdat,
   gebdatverweigert,
   gebmonat,
   gebjahr,
   imaltwabherkunft,
   imvtinfogrp,
   kdart,
   kdloginaktiv,
   kdloginaktivdat,
   kdloginlinksenddat,
   kontoart,
   kontonrletzteziffern,
   konto_id_key,
   kontosperre,
   kontrolladrkat,
   kreditlimit,
   kundeid_key,
   land,
   lansprwert,
   lansprohnestationaerwert,
   lanzauftr,
   letztauftrdat,
   lnumswert,
   lretwert,
   mahnebene,
   mahnstrang,
   mehrlinien,
   mobilnrvorhanden,
   nachbarabg,
   nachnameinitiale,
   nettoausschluss,
   nixi, 
   nlabostatus,
   nlanldaterst,
   nlanldatletzt,
   nltyp,
   nlwunsch,
   numswert,
   onlinetest,
   ostwest,
   plz,
   plzzusatz, 
   postfach,
   praefartgrdobaktiv,      
   praefartgrdobinaktiv,   
   provinzgrp,
   region,
   retwert,
   rkumstelldat,
   rufnrverweigert,
   serviceinforechnungversand,
   servicemailaktiv,
   shopanteiligkeit,
   sst,
   telefon,
   telefonalternativ,
   telefonfirma,
   telefonvorhanden,
   telemarkwunsch,
   titel,
   ueberschneider,
   verweiskonto_id_key,
   vorname,
   vorteilsnrangabe,
   vtinfogrp,
   vtinfogrpstationaer,
   werbmitsperre,
   zustelldienst,
   sprache,
   email_key
FROM clcc_ww_kunde_22
WHERE konto_id_key
  IN (
SELECT konto_id_key
FROM (
SELECT
   adresshdl,
   altjungakt,
   altjungfolge,
   altwabherkunft,
   anlagedat,
   anlaktionscode,
   anlaktionscoderea,
   anlauftrart,
   anldat,
   anldatlv,
   anlvtsaison,
   anlvtsaisonrea,
   anlweg1,
   anlweg2,
   anlweg3,
   anrede,
   ansprwert,
   ansprohnestationaerwert,
   anzauftr,
   anzkatletztauftr,
   anzpostret,
   appauftrdaterst,
   bonikl,
   briefbotenbezirk,
   creationlpremium,   
   datenschutzkonto,
   eigenfremdkauf,
   emailanldat,
   emailhash,
   emailhdl,
   emailherkunft,
   emailverweigert,
   emailvorhanden,
   ersartwunsch,
   fax,
   fg,
   fgaktiv,
   filialwerbungwunsch,
   firma,
   gebdat,
   gebdatverweigert,
   gebmonat,
   gebjahr,
   imaltwabherkunft,
   imvtinfogrp,
   kdart,
   kdloginaktiv,
   kdloginaktivdat,
   kdloginlinksenddat,
   konto_id_key,
   kontoart,
   kontonrletzteziffern,
   kontosperre,
   kontrolladrkat,
   kreditlimit,
   kundeid_key,
   land,
   lansprwert,
   lansprohnestationaerwert,
   lanzauftr,
   letztauftrdat,
   lnumswert,
   lretwert,
   mahnebene,
   mahnstrang,
   mehrlinien,
   mobilnrvorhanden,
   nachbarabg,
   nachnameinitiale,
   nettoausschluss,
   nixi,
   nlabostatus,
   nlanldaterst,
   nlanldatletzt,
   nltyp,
   nlwunsch,
   numswert,
   onlinetest,
   ostwest,
   plz,
   plzzusatz,
   postfach,
   praefartgrdobaktiv,      
   praefartgrdobinaktiv,   
   provinzgrp,
   region,
   retwert,
   rkumstelldat,
   rufnrverweigert,
   serviceinforechnungversand,
   servicemailaktiv,
   shopanteiligkeit,
   sst,
   telefon,
   telefonalternativ,
   telefonfirma,
   telefonvorhanden,
   telemarkwunsch,
   titel,
   ueberschneider,
   verweiskonto_id_key,
   vorname,
   vorteilsnrangabe,
   vtinfogrp,
   vtinfogrpstationaer,
   werbmitsperre,
   zustelldienst,
   sprache,
   email_key
FROM clcc_ww_kunde_22
MINUS
SELECT
   adresshdl,
   altjungakt,
   altjungfolge,
   altwabherkunft,
   anlagedat,
   anlaktionscode,
   anlaktionscoderea,
   anlauftrart,
   anldat,
   anldatlv,
   anlvtsaison,
   anlvtsaisonrea,
   anlweg1,
   anlweg2,
   anlweg3,
   anrede,
   ansprwert,
   ansprohnestationaerwert,
   anzauftr,
   anzkatletztauftr,
   anzpostret,
   appauftrdaterst,
   bonikl,
   briefbotenbezirk,
   creationlpremium,
   datenschutzkonto,
   eigenfremdkauf,
   emailanldat,
   emailhash,
   emailhdl,
   emailherkunft,
   emailverweigert,
   emailvorhanden,
   ersartwunsch,
   fax,
   fg,
   fgaktiv,
   filialwerbungwunsch,
   firma,
   gebdat,
   gebdatverweigert,
   gebmonat,
   gebjahr,
   imaltwabherkunft,
   imvtinfogrp,
   kdart,
   kdloginaktiv,
   kdloginaktivdat,
   kdloginlinksenddat,
   konto_id_key,
   kontoart,
   kontonrletzteziffern,
   kontosperre,
   kontrolladrkat,
   kreditlimit,
   kundeid_key,
   land,
   lansprwert,
   lansprohnestationaerwert,
   lanzauftr,
   letztauftrdat,
   lnumswert,
   lretwert,
   mahnebene,
   mahnstrang,
   mehrlinien,
   mobilnrvorhanden,
   nachbarabg,
   nachnameinitiale,
   nettoausschluss,
   nixi,
   nlabostatus,
   nlanldaterst,
   nlanldatletzt,
   nltyp,
   nlwunsch,
   numswert,
   onlinetest,
   ostwest,
   plz,
   plzzusatz,
   postfach,
   praefartgrdobaktiv,      
   praefartgrdobinaktiv,   
   provinzgrp,
   region,
   retwert,
   rkumstelldat,
   rufnrverweigert,
   serviceinforechnungversand,
   servicemailaktiv,
   shopanteiligkeit,
   sst,
   telefon,
   telefonalternativ,
   telefonfirma,
   telefonvorhanden,
   telemarkwunsch,
   titel,
   ueberschneider,
   verweiskonto_id_key,
   vorname,
   vorteilsnrangabe,
   vtinfogrp,
   vtinfogrpstationaer,
   werbmitsperre,
   zustelldienst,
   sprache,
   email_key
FROM cc_kunde_&vtsaison
WHERE &termin - 1/24/60 BETWEEN dwh_valid_from AND dwh_valid_to
  AND kontoart IN (1,5) AND firma NOT IN (7,16,19,20,51)
  )
);

COMMIT;

--mache fehler d