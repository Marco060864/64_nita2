forward
global type w_stat_vend_acq_rpt from w_print_main
end type
end forward

global type w_stat_vend_acq_rpt from w_print_main
int Width=2592
int Height=1428
boolean TitleBar=true
string Title="Statistiche vendite e acquisti"
end type
global w_stat_vend_acq_rpt w_stat_vend_acq_rpt

on w_stat_vend_acq_rpt.create
call super::create
end on

on w_stat_vend_acq_rpt.destroy
call super::destroy
end on

event ue_pre_print;call super::ue_pre_print;
string	ls_movimenti,ls_ragg_1, ls_ragg_2,ls_grafico
string	ls_da_ragg_1, ls_a_ragg_1, ls_da_ragg_2, ls_a_ragg_2
string	ls_id_da_ragg_1, ls_id_a_ragg_1, ls_id_da_ragg_2, ls_id_a_ragg_2
date		ld_da_data, ld_a_data

String 	statement, ls_selezione


ls_movimenti			= tab_1.tabpage_select.dw_selection.GetItemString(1,"movimenti")

ls_ragg_1				= tab_1.tabpage_select.dw_selection.GetItemString(1,"ragg_1")
if isNull(ls_ragg_1) or ls_ragg_1 = "NA" then
	ls_ragg_1 = ""
end if	

ls_ragg_2				= tab_1.tabpage_select.dw_selection.GetItemString(1,"ragg_2")
if isNull(ls_ragg_2) or ls_ragg_2 = "NA" then
	ls_ragg_2 = ""
end if	

ld_da_data				= tab_1.tabpage_select.dw_selection.GetItemDate(1,"dalla_data")
ld_a_data				= tab_1.tabpage_select.dw_selection.GetItemDate(1,"alla_data")
ls_grafico				= tab_1.tabpage_select.dw_selection.GetItemString(1,"stampa_confronto")

ls_da_ragg_1			= tab_1.tabpage_select.dw_selection.GetItemString(1,"da_ragg_1_cod")
ls_a_ragg_1				= tab_1.tabpage_select.dw_selection.GetItemString(1,"a_ragg_1_cod")
ls_da_ragg_2			= tab_1.tabpage_select.dw_selection.GetItemString(1,"da_ragg_2_cod")
ls_a_ragg_2				= tab_1.tabpage_select.dw_selection.GetItemString(1,"a_ragg_2_cod")

if not isNull(ls_da_ragg_1) and not isNull(ls_a_ragg_1) then
	if ls_da_ragg_1 > ls_a_ragg_1 then
		if MessageBox( "Attenzione","Selez. 'da' maggiore di Selez. 'a',continuare ?",Question!,YesNo!,2 ) = 2 then
			return -1
		end if		
	end if
end if

if not isNull(ls_da_ragg_2) and not isNull(ls_a_ragg_2) then
	if ls_da_ragg_2 > ls_a_ragg_2 then
		if MessageBox( "Attenzione","Selez. 'da' maggiore di Selez. 'a',continuare ?",Question!,YesNo!,2 ) = 2 then
			return -1
		end if		
	end if
end if


ls_id_da_ragg_1		= tab_1.tabpage_select.dw_selection.GetItemString(1,"id_da_ragg_1_cod")
ls_id_a_ragg_1			= tab_1.tabpage_select.dw_selection.GetItemString(1,"id_a_ragg_1_cod")
ls_id_da_ragg_2		= tab_1.tabpage_select.dw_selection.GetItemString(1,"id_da_ragg_2_cod")
ls_id_a_ragg_2			= tab_1.tabpage_select.dw_selection.GetItemString(1,"id_a_ragg_2_cod")

if not isNull(ls_id_da_ragg_1) and not isNull(ls_id_a_ragg_1) then
	if ls_id_da_ragg_1 > ls_id_a_ragg_1 then
		if MessageBox( "Attenzione","Selez. 'da' maggiore di Selez. 'a',continuare ?",Question!,YesNo!,2 ) = 2 then
			return -1
		end if		
	end if
end if

if not isNull(ls_id_da_ragg_2) and not isNull(ls_id_a_ragg_2) then
	if ls_id_da_ragg_2 > ls_id_a_ragg_2 then
		if MessageBox( "Attenzione","Selez. 'da' maggiore di Selez. 'a',continuare ?",Question!,YesNo!,2 ) = 2 then
			return -1
		end if		
	end if
end if

statement  = " {Documento.ID_Azienda} = 1"

if Not IsNull(ld_da_data) then
	statement 		= statement + " AND {Documento.Data_Registrazione} >= Date (" + string(ld_da_data, "yyyy, mm, dd") + ")"
	ls_selezione 	= " Dalla data registrazione " + string(ld_da_data, "dd/mm/yyyy") + ", "
else
	
	ls_selezione 	= " Dalla data registrazione - non definita, "	
end if

if Not IsNull(ld_a_data) then
	statement 		= statement + " AND {Documento.Data_Registrazione} <= Date (" + string(ld_a_data, "yyyy, mm, dd") + ")"
	ls_selezione 	= ls_selezione + "alla data registrazione " + string(ld_a_data, "dd/mm/yyyy") + "."
else
	
	ls_selezione 	= ls_selezione + "alla data registrazione - non definita."
end if

if Not IsNull(ls_movimenti) then
	choose case ls_movimenti
		case "G"
			statement = statement + " AND {Registro.Tipo_Registro} in ['GA','GV']"

		case "GA"
			statement = statement + " AND {Registro.Tipo_Registro} = 'GA'"
		case "GV"
			statement = statement + " AND {Registro.Tipo_Registro} = 'GV'"	
		case "D"
			statement = statement + " AND {Registro.Tipo_Registro} in ['DA','DV']"
		case "DA"
			statement = statement + " AND {Registro.Tipo_Registro} = 'DA'"
		case "DV"
			statement = statement + " AND {Registro.Tipo_Registro} = 'DV'"
		case "P"
			statement = statement + " AND {Registro.Tipo_Registro} in ['PA','PV']"
		case "PA"
			statement = statement + " AND {Registro.Tipo_Registro} = 'PA'"
		case "PV"
			statement = statement + " AND {Registro.Tipo_Registro} = 'PV'"
		case "F"
			statement = statement + " AND {Registro.Tipo_Registro} in ['IA','IV']"
		case "FA"
			statement = statement + " AND {Registro.Tipo_Registro} = 'IA'"
		case "FV"
			statement = statement + " AND {Registro.Tipo_Registro} = 'IV'"	
		case "O"
			statement = statement + " AND {Registro.Tipo_Registro} in ['OA','OV']"
		case "OA"
			statement = statement + " AND {Registro.Tipo_Registro} = 'OA'"
		case "OV"
			statement = statement + " AND {Registro.Tipo_Registro} = 'OV'"
	end choose	
end if


if Not IsNull(ls_da_ragg_1) and ls_da_ragg_1 <> "" then
	
	choose case ls_ragg_1
		case "SC"
			statement = statement + " AND {Sog_Commerciale_Gen.Codice} >= '" + ls_da_ragg_1 + "'"
		case "AR"
			statement = statement + " AND {Articolo.Codice} >= '" + ls_da_ragg_1 + "'"
		case "CP" 
			statement = statement + " AND {Conto.Codice} >= '" + ls_da_ragg_1 + "'"
	end choose
end if

if Not IsNull( ls_a_ragg_1 ) and ls_a_ragg_1 <> "" then
	choose case ls_ragg_1
		case "SC"
			statement = statement + " AND {Sog_Commerciale_Gen.Codice} <= '" + ls_a_ragg_1 + "'"
		case "AR"
			statement = statement + " AND {Articolo.Codice} <= '" + ls_a_ragg_1 + "'"
		case "CP" 
			statement = statement + " AND {Conto.Codice} <= '" + ls_a_ragg_1 + "'"
	end choose
end if

if Not IsNull(ls_id_da_ragg_1)  and ls_id_da_ragg_1 <> "" then
		
	choose case ls_ragg_1
		case "CC"
			statement = statement + " AND {Cat_Com_Articolo.Codice} >= '" + ls_id_da_ragg_1 + "'"
		case "CM"
			statement = statement + " AND {Cat_Merceologica.Codice} >= '" + ls_id_da_ragg_1 + "'"
		case "CZ" 
			statement = statement + " AND {Caus_Magazzino.Codice} >= '" + ls_id_da_ragg_1 + "'"	
		case "CT" 
			statement = statement + " AND {Caus_trasporto.Codice} >= '" + ls_id_da_ragg_1 + "'"
	end choose
end if

if Not IsNull( ls_id_a_ragg_1 )  and ls_id_da_ragg_1 <> "" then
		
	choose case ls_ragg_1
		case "CC"
			statement = statement + " AND {Cat_Com_Articolo.Codice} <= '" + ls_id_a_ragg_1 + "'"
		case "CM"
			statement = statement + " AND {Cat_Merceologica.Codice} <= '" + ls_id_a_ragg_1 + "'"
		case "CZ" 
			statement = statement + " AND {Caus_Magazzino.Codice} <= '" + ls_id_a_ragg_1 + "'"	
		case "CT" 
			statement = statement + " AND {Caus_trasporto.Codice} <= '" + ls_id_a_ragg_1 + "'"
	end choose
end if


if Not IsNull(ls_da_ragg_2) and ls_da_ragg_2 <> "" then
	choose case ls_ragg_2
		case "SC"
			statement = statement + " AND {Sog_Commerciale_Gen.Codice} >= '" + ls_da_ragg_2 + "'"
		case "AR"
			statement = statement + " AND {Articolo.Codice} >= '" + ls_da_ragg_2 + "'"
		case "CP" 
			statement = statement + " AND {Conto.Codice} >= '" + ls_da_ragg_2 + "'"
	end choose
end if

if Not IsNull( ls_a_ragg_2 ) and ls_a_ragg_2 <> "" then
	choose case ls_ragg_2
		case "SC"
			statement = statement + " AND {Sog_Commerciale_Gen.Codice} <= '" + ls_a_ragg_2 + "'"
		case "AR"
			statement = statement + " AND {Articolo.Codice} <= '" + ls_a_ragg_2 + "'"
		case "CP" 
			statement = statement + " AND {Conto.Codice} <= '" + ls_a_ragg_2 + "'"
	end choose
end if

if Not IsNull(ls_id_da_ragg_2)  and ls_id_da_ragg_2 <> "" then
	choose case ls_ragg_2
		case "CC"
			statement = statement + " AND {Cat_Com_Articolo.Codice} >= '" + ls_id_da_ragg_2 + "'"
		case "CM"
			statement = statement + " AND {Cat_Merceologica.Codice} >= '" + ls_id_da_ragg_2 + "'"
		case "CZ" 
			statement = statement + " AND {Caus_Magazzino.Codice} >= '" + ls_id_da_ragg_2 + "'"
		case "CT" 
			statement = statement + " AND {Caus_trasporto.Codice} >= '" + ls_id_da_ragg_2 + "'"
	end choose
end if

if Not IsNull( ls_id_a_ragg_2 )  and ls_id_a_ragg_2 <> "" then
	choose case ls_ragg_2
		case "CC"
			statement = statement + " AND {Cat_Com_Articolo.Codice} <= '" + ls_id_a_ragg_2 + "'"
		case "CM"
			statement = statement + " AND {Cat_Merceologica.Codice} <= '" + ls_id_a_ragg_2 + "'"
		case "CZ" 
			statement = statement + " AND {Caus_Magazzino.Codice} <= '" + ls_id_a_ragg_2 + "'"	
		case "CT" 
			statement = statement + " AND {Caus_trasporto.Codice} <= '" + ls_id_a_ragg_2 + "'"
	end choose
end if


is_selection 	= statement


istr_formule[1].formula_name 	= "stampa_grafico"
istr_formule[1].formula_string 	= "'" + ls_grafico + "'"
istr_formule[2].formula_name 	= "Raggruppamento_1"
istr_formule[2].formula_string 	= "'" + ls_ragg_1 + "'"
istr_formule[3].formula_name 	= "Raggruppamento_2"
istr_formule[3].formula_string 	= "'" + ls_ragg_2 + "'"

istr_formule[4].formula_name 		= "id_valuta"
istr_formule[4].formula_string 	= string(tab_1.tabpage_select.dw_selection.getitemnumber(1, "id_valuta"))

return 0

end event

type cb_esci from w_print_main`cb_esci within w_stat_vend_acq_rpt
int X=2286
int Y=80
end type

type tab_1 from w_print_main`tab_1 within w_stat_vend_acq_rpt
int Width=2514
int Height=1140
end type

type tabpage_select from w_print_main`tabpage_select within tab_1
int X=18
int Y=112
int Width=2478
int Height=1012
end type

type dw_selection from w_print_main`dw_selection within tabpage_select
int Y=28
int Width=2377
int Height=940
string DataObject="d_stat_vend_acq_rpt"
end type

event dw_selection::itemchanged;call super::itemchanged;date		ld_dalla_data
string	ls_ragg_1, ls_ragg_2, ls_null
string	ls_column
setNull(ls_null)

CHOOSE CASE dwo.name
		
	CASE 'alla_data'
		ld_dalla_data = This.GetItemDate(1, "dalla_data")
		if Date(data) < ld_dalla_data then
			MessageBox("Attenzione", "Data fine non può essere inferiore alla data di inizio.")
			Post SetColumn("alla_data")
		end if
		
	CASE 'ragg_1'		
		ls_ragg_1 = data
		this.SetItem( row,"ragg_2",ls_null )
		CHOOSE CASE ls_ragg_1
				
			CASE	'SC'
				this.object.ragg_2.values = &
				"Mese-Anno~tMA/Articolo~tAR/Categoria commerciale~tCC/Categoria merceologica~tCM/Contropartita~tCP/Causale trasporto~tCT/Causale magazzino~tCZ/Non abilitato~tNA"
				this.object.da_ragg_1.text = "Da soggetto commerciale:"			
				this.object.a_ragg_1.text = "A soggetto commerciale:"			
				
			CASE	'MA'
				this.object.ragg_2.values = &
				"Articolo~tAR/Categoria commerciale~tCC/Categoria merceologica~tCM/Contropartita~tCP/Causale trasporto~tCT/Causale magazzino~tCZ/Soggetto commerciale~tSC/Non abilitato~tNA"	
				this.object.da_ragg_1.text = "Da:"			
				this.object.a_ragg_1.text = "A:"							
				
				
			CASE	'AR'
				this.object.ragg_2.values = &
				"Mese-Anno~tMA/Contropartita~tCP/Causale trasporto~tCT/Causale magazzino~tCZ/Soggetto commerciale~tSC/Non abilitato~tNA"	
				this.object.da_ragg_1.text = "Da articolo:"			
				this.object.a_ragg_1.text = "A articolo:"						

			CASE	'CC'
				SetItem( row,"id_da_ragg_1_cod","")
				SetItem( row,"id_da_ragg_1_des","")
				SetItem( row,"id_a_ragg_1_cod","")
				SetItem( row,"id_a_ragg_1_des","")
				
				this.object.ragg_2.values = &
				"Articolo~tAR/Mese-Anno~tMA/Categoria merceologica~tCM/Contropartita~tCP/Causale trasporto~tCT/Causale magazzino~tCZ/Soggetto commerciale~tSC/Non abilitato~tNA"					
				this.object.da_ragg_1.text = "Da categoria commerciale:"			
				this.object.a_ragg_1.text = "A categoria commerciale:"			
				
				this.object.id_da_ragg_1_cod.dddw.Name				=  "d_cat_com_articolo_cod_sl"
				this.object.id_a_ragg_1_cod.dddw.Name 				=  "d_cat_com_articolo_cod_sl"
				this.object.id_da_ragg_1_des.dddw.Name				=  "d_cat_com_articolo_des_sl"
				this.object.id_a_ragg_1_des.dddw.Name 				=  "d_cat_com_articolo_des_sl"
				
				this.object.id_da_ragg_1_cod.dddw.DisplayColumn =  "codice"
				this.object.id_a_ragg_1_cod.dddw.DisplayColumn  =  "codice"
				this.object.id_da_ragg_1_des.dddw.DisplayColumn =  "descrizione"
				this.object.id_a_ragg_1_des.dddw.DisplayColumn  =  "descrizione"
				
				this.object.id_da_ragg_1_cod.dddw.DataColumn    =  "codice"
				this.object.id_a_ragg_1_cod.dddw.DataColumn     =  "codice"
				this.object.id_da_ragg_1_des.dddw.DataColumn    =  "codice"
				this.object.id_a_ragg_1_des.dddw.DataColumn     =  "codice"
				
				is_drop_column[1] = "id_da_ragg_1_cod"
				is_drop_column[2] = "id_a_ragg_1_cod"
				is_drop_column[3] = "id_da_ragg_1_des"
				is_drop_column[4] = "id_a_ragg_1_des"
				
				triggerEvent("ue_set_drop")

			CASE	'CM'
				SetItem( row,"id_da_ragg_1_cod","")
				SetItem( row,"id_da_ragg_1_des","")
				SetItem( row,"id_a_ragg_1_cod","")
				SetItem( row,"id_a_ragg_1_des","")
				
				this.object.ragg_2.values = &
				"Articolo~tAR/Mese-Anno~tMA/Categoria commerciale~tCC/Contropartita~tCP/Causale trasporto~tCT/Causale magazzino~tCZ/Soggetto commerciale~tSC/Non abilitato~tNA"					
				
				this.object.da_ragg_1.text = "Da categoria merceologica:"			
				this.object.a_ragg_1.text = "A categoria merceologica:"			
				
				this.object.id_da_ragg_1_cod.dddw.Name				=  "d_cat_merceologica_cod_sl"
				this.object.id_a_ragg_1_cod.dddw.Name 				=  "d_cat_merceologica_cod_sl"
				this.object.id_da_ragg_1_des.dddw.Name				=  "d_cat_merceologica_des_sl"
				this.object.id_a_ragg_1_des.dddw.Name 				=  "d_cat_merceologica_des_sl"
				
				this.object.id_da_ragg_1_cod.dddw.DisplayColumn =  "codice"
				this.object.id_a_ragg_1_cod.dddw.DisplayColumn  =  "codice"
				this.object.id_da_ragg_1_des.dddw.DisplayColumn =  "descrizione"
				this.object.id_a_ragg_1_des.dddw.DisplayColumn  =  "descrizione"
				
				this.object.id_da_ragg_1_cod.dddw.DataColumn    =  "codice"
				this.object.id_a_ragg_1_cod.dddw.DataColumn     =  "codice"
				this.object.id_da_ragg_1_des.dddw.DataColumn    =  "codice"
				this.object.id_a_ragg_1_des.dddw.DataColumn     =  "codice"
								
				is_drop_column[1] = "id_da_ragg_1_cod"
				is_drop_column[2] = "id_a_ragg_1_cod"
				is_drop_column[3] = "id_da_ragg_1_des"
				is_drop_column[4] = "id_a_ragg_1_des"
				
				triggerEvent("ue_set_drop")

			CASE	'CP'
				this.object.ragg_2.values = &
				"Articolo~tAR/Mese-Anno~tMA/Categoria commerciale~tCC/Categoria merceologica~tCM/Causale trasporto~tCT/Causale magazzino~tCZ/Soggetto commerciale~tSC/Non abilitato~tNA"					
				this.object.da_ragg_1.text = "Da cotropartita:"			
				this.object.a_ragg_1.text = "A cotropartita:"			
				
				
			CASE	'CZ'
				SetItem( row,"id_da_ragg_1_cod","")
				SetItem( row,"id_da_ragg_1_des","")
				SetItem( row,"id_a_ragg_1_cod","")
				SetItem( row,"id_a_ragg_1_des","")
				
				this.object.ragg_2.values = &
				"Articolo~tAR/Mese-Anno~tMA/Categoria commerciale~tCC/Categoria merceologica~tCM/Contropartita~tCP/Causale trasporto~tCT/Soggetto commerciale~tSC/Non abilitato~tNA"					
				
				this.object.da_ragg_1.text = "Da causale magazzino:"			
				this.object.a_ragg_1.text = "A causale magazzino:"			
				
				this.object.id_da_ragg_1_cod.dddw.Name				=  "d_caus_magazzino_cod_sl"
				this.object.id_a_ragg_1_cod.dddw.Name 				=  "d_caus_magazzino_cod_sl"
				this.object.id_da_ragg_1_des.dddw.Name				=  "d_caus_magazzino_des_sl"
				this.object.id_a_ragg_1_des.dddw.Name 				=  "d_caus_magazzino_des_sl"
				
				this.object.id_da_ragg_1_cod.dddw.DisplayColumn =  "codice"
				this.object.id_a_ragg_1_cod.dddw.DisplayColumn  =  "codice"
				this.object.id_da_ragg_1_des.dddw.DisplayColumn =  "descrizione"
				this.object.id_a_ragg_1_des.dddw.DisplayColumn  =  "descrizione"
				
				this.object.id_da_ragg_1_cod.dddw.DataColumn    =  "codice"
				this.object.id_a_ragg_1_cod.dddw.DataColumn     =  "codice"
				this.object.id_da_ragg_1_des.dddw.DataColumn    =  "codice"
				this.object.id_a_ragg_1_des.dddw.DataColumn     =  "codice"
								
				is_drop_column[1] = "id_da_ragg_1_cod"
				is_drop_column[2] = "id_a_ragg_1_cod"
				is_drop_column[3] = "id_da_ragg_1_des"
				is_drop_column[4] = "id_a_ragg_1_des"
				
				triggerEvent("ue_set_drop")

			CASE	'CT'
				SetItem( row,"id_da_ragg_1_cod","")
				SetItem( row,"id_da_ragg_1_des","")
				SetItem( row,"id_a_ragg_1_cod","")
				SetItem( row,"id_a_ragg_1_des","")
				
				this.object.ragg_2.values = &
				"Articolo~tAR/Mese-Anno~tMA/Categoria commerciale~tCC/Categoria merceologica~tCM/Contropartita~tCP/Causale magazzino~tCZ/Soggetto commerciale~tSC/Non abilitato~tNA"					
				this.object.da_ragg_1.text = "Da causale trasporto:"			
				this.object.a_ragg_1.text = "A causale trasporto:"			
				
				this.object.id_da_ragg_1_cod.dddw.Name				=  "d_caus_trasporto_cod_sl"
				this.object.id_a_ragg_1_cod.dddw.Name 				=  "d_caus_trasporto_cod_sl"
				this.object.id_da_ragg_1_des.dddw.Name				=  "d_caus_trasporto_des_sl"
				this.object.id_a_ragg_1_des.dddw.Name 				=  "d_caus_trasporto_des_sl"
				
				this.object.id_da_ragg_1_cod.dddw.DisplayColumn =  "codice"
				this.object.id_a_ragg_1_cod.dddw.DisplayColumn  =  "codice"
				this.object.id_da_ragg_1_des.dddw.DisplayColumn =  "descrizione"
				this.object.id_a_ragg_1_des.dddw.DisplayColumn  =  "descrizione"
				
				this.object.id_da_ragg_1_cod.dddw.DataColumn    =  "codice"
				this.object.id_a_ragg_1_cod.dddw.DataColumn     =  "codice"
				this.object.id_da_ragg_1_des.dddw.DataColumn    =  "codice"
				this.object.id_a_ragg_1_des.dddw.DataColumn     =  "codice"
								
				is_drop_column[1] = "id_da_ragg_1_cod"
				is_drop_column[2] = "id_a_ragg_1_cod"
				is_drop_column[3] = "id_da_ragg_1_des"
				is_drop_column[4] = "id_a_ragg_1_des"
				
				triggerEvent("ue_set_drop")
				
		END CHOOSE				
		
	CASE 'ragg_2'		
		ls_ragg_2 = data
		CHOOSE CASE ls_ragg_2
			CASE	'SC'
				this.object.da_ragg_2.text = "Da soggetto commerciale:"			
				this.object.a_ragg_2.text = "A soggetto commerciale:"			
				
			CASE	'MA'
				
				
			CASE	'AR'
				this.object.da_ragg_2.text = "Da articolo:"			
				this.object.a_ragg_2.text = "A articolo:"						
				
			CASE	'CC'
				SetItem( row,"id_da_ragg_2_cod","")
				SetItem( row,"id_da_ragg_2_des","")
				SetItem( row,"id_a_ragg_2_cod","")
				SetItem( row,"id_a_ragg_2_des","")
				
				this.object.da_ragg_2.text = "Da categoria commerciale:"			
				this.object.a_ragg_2.text = "A categoria commerciale:"			
				
				this.object.id_da_ragg_2_cod.dddw.Name				=  "d_cat_com_articolo_cod_sl"
				this.object.id_a_ragg_2_cod.dddw.Name 				=  "d_cat_com_articolo_cod_sl"
				this.object.id_da_ragg_2_des.dddw.Name				=  "d_cat_com_articolo_des_sl"
				this.object.id_a_ragg_2_des.dddw.Name 				=  "d_cat_com_articolo_des_sl"
				
				this.object.id_da_ragg_2_cod.dddw.DisplayColumn =  "codice"
				this.object.id_a_ragg_2_cod.dddw.DisplayColumn  =  "codice"
				this.object.id_da_ragg_2_des.dddw.DisplayColumn =  "descrizione"
				this.object.id_a_ragg_2_des.dddw.DisplayColumn  =  "descrizione"
				
				this.object.id_da_ragg_2_cod.dddw.DataColumn    =  "codice"
				this.object.id_a_ragg_2_cod.dddw.DataColumn     =  "codice"
				this.object.id_da_ragg_2_des.dddw.DataColumn    =  "codice"
				this.object.id_a_ragg_2_des.dddw.DataColumn     =  "codice"
				
				is_drop_column[1] = "id_da_ragg_2_cod"
				is_drop_column[2] = "id_a_ragg_2_cod"
				is_drop_column[3] = "id_da_ragg_2_des"
				is_drop_column[4] = "id_a_ragg_2_des"
				
				triggerEvent("ue_set_drop")

			CASE	'CM'
				SetItem( row,"id_da_ragg_2_cod","")
				SetItem( row,"id_da_ragg_2_des","")
				SetItem( row,"id_a_ragg_2_cod","")
				SetItem( row,"id_a_ragg_2_des","")
				
				this.object.da_ragg_2.text = "Da categoria merceologica:"			
				this.object.a_ragg_2.text = "A categoria merceologica:"			
				
				this.object.id_da_ragg_2_cod.dddw.Name				=  "d_cat_merceologica_cod_sl"
				this.object.id_a_ragg_2_cod.dddw.Name 				=  "d_cat_merceologica_cod_sl"
				this.object.id_da_ragg_2_des.dddw.Name				=  "d_cat_merceologica_des_sl"
				this.object.id_a_ragg_2_des.dddw.Name 				=  "d_cat_merceologica_des_sl"
				
				this.object.id_da_ragg_2_cod.dddw.DisplayColumn =  "codice"
				this.object.id_a_ragg_2_cod.dddw.DisplayColumn  =  "codice"
				this.object.id_da_ragg_2_des.dddw.DisplayColumn =  "descrizione"
				this.object.id_a_ragg_2_des.dddw.DisplayColumn  =  "descrizione"
				
				this.object.id_da_ragg_2_cod.dddw.DataColumn    =  "codice"
				this.object.id_a_ragg_2_cod.dddw.DataColumn     =  "codice"
				this.object.id_da_ragg_2_des.dddw.DataColumn    =  "codice"
				this.object.id_a_ragg_2_des.dddw.DataColumn     =  "codice"
								
				is_drop_column[1] = "id_da_ragg_2_cod"
				is_drop_column[2] = "id_a_ragg_2_cod"
				is_drop_column[3] = "id_da_ragg_2_des"
				is_drop_column[4] = "id_a_ragg_2_des"
				
				triggerEvent("ue_set_drop")
				
			CASE	'CP'
				this.object.da_ragg_2.text = "Da cotropartita:"			
				this.object.a_ragg_2.text = "A cotropartita:"			
				
			CASE	'CZ'
				SetItem( row,"id_da_ragg_2_cod","")
				SetItem( row,"id_da_ragg_2_des","")
				SetItem( row,"id_a_ragg_2_cod","")
				SetItem( row,"id_a_ragg_2_des","")
				
				this.object.da_ragg_2.text = "Da causale magazzino:"			
				this.object.a_ragg_2.text = "A causale magazzino:"			
				
				this.object.id_da_ragg_2_cod.dddw.Name				=  "d_caus_magazzino_cod_sl"
				this.object.id_a_ragg_2_cod.dddw.Name 				=  "d_caus_magazzino_cod_sl"
				this.object.id_da_ragg_2_des.dddw.Name				=  "d_caus_magazzino_des_sl"
				this.object.id_a_ragg_2_des.dddw.Name 				=  "d_caus_magazzino_des_sl"
				
				this.object.id_da_ragg_2_cod.dddw.DisplayColumn =  "codice"
				this.object.id_a_ragg_2_cod.dddw.DisplayColumn  =  "codice"
				this.object.id_da_ragg_2_des.dddw.DisplayColumn =  "descrizione"
				this.object.id_a_ragg_2_des.dddw.DisplayColumn  =  "descrizione"
				
				this.object.id_da_ragg_2_cod.dddw.DataColumn    =  "codice"
				this.object.id_a_ragg_2_cod.dddw.DataColumn     =  "codice"
				this.object.id_da_ragg_2_des.dddw.DataColumn    =  "codice"
				this.object.id_a_ragg_2_des.dddw.DataColumn     =  "codice"
								
				is_drop_column[1] = "id_da_ragg_2_cod"
				is_drop_column[2] = "id_a_ragg_2_cod"
				is_drop_column[3] = "id_da_ragg_2_des"
				is_drop_column[4] = "id_a_ragg_2_des"
				
				triggerEvent("ue_set_drop")
				
			CASE	'CT'
				SetItem( row,"id_da_ragg_2_cod","")
				SetItem( row,"id_da_ragg_2_des","")
				SetItem( row,"id_a_ragg_2_cod","")
				SetItem( row,"id_a_ragg_2_des","")
				
				this.object.da_ragg_2.text = "Da causale trasporto:"			
				this.object.a_ragg_2.text = "A causale trasporto:"			
				
				this.object.id_da_ragg_2_cod.dddw.Name				=  "d_caus_trasporto_cod_sl"
				this.object.id_a_ragg_2_cod.dddw.Name 				=  "d_caus_trasporto_cod_sl"
				this.object.id_da_ragg_2_des.dddw.Name				=  "d_caus_trasporto_des_sl"
				this.object.id_a_ragg_2_des.dddw.Name 				=  "d_caus_trasporto_des_sl"
				
				this.object.id_da_ragg_2_cod.dddw.DisplayColumn =  "codice"
				this.object.id_a_ragg_2_cod.dddw.DisplayColumn  =  "codice"
				this.object.id_da_ragg_2_des.dddw.DisplayColumn =  "descrizione"
				this.object.id_a_ragg_2_des.dddw.DisplayColumn  =  "descrizione"
				
				this.object.id_da_ragg_2_cod.dddw.DataColumn    =  "codice"
				this.object.id_a_ragg_2_cod.dddw.DataColumn     =  "codice"
				this.object.id_da_ragg_2_des.dddw.DataColumn    =  "codice"
				this.object.id_a_ragg_2_des.dddw.DataColumn     =  "codice"
								
				is_drop_column[1] = "id_da_ragg_2_cod"
				is_drop_column[2] = "id_a_ragg_2_cod"
				is_drop_column[3] = "id_da_ragg_2_des"
				is_drop_column[4] = "id_a_ragg_2_des"
				
				triggerEvent("ue_set_drop")
				
		END CHOOSE				
		
END CHOOSE


end event

event dw_selection::ue_set_search;call super::ue_set_search;
string ls_ragg_1, ls_ragg_2

CHOOSE CASE as_nomecol
		
	CASE "da_ragg_1_cod", "a_ragg_1_cod"
		ls_ragg_1 = This.GetItemString(1, "ragg_1")
		CHOOSE CASE ls_ragg_1
			CASE	'SC'
				is_search_window = "w_sog_commerciale_gen_coddes_sw" 	
				is_ricpar.s_filter_value = as_valcol 					
				is_ricpar.s_filter_name = "codice" 				
			CASE	'AR'
				is_search_window = "w_articolo_coddes_sw" 	
				is_ricpar.s_filter_value = as_valcol 			
				is_ricpar.s_filter_name = "articolo_codice" 	
			CASE	'CP'
				is_search_window = "w_conto_azienda_coddes_sw"
				is_ricpar.s_filter_value = as_valcol 				
				is_ricpar.s_filter_name = "conto_codice" 			
		END CHOOSE		
		
	CASE "da_ragg_1_des", "a_ragg_1_des"
		ls_ragg_1 = This.GetItemString(1, "ragg_1")
		CHOOSE CASE ls_ragg_1
			CASE	'SC'
				is_search_window = "w_sog_commerciale_gen_coddes_sw" 	
				is_ricpar.s_filter_value = as_valcol 					
				is_ricpar.s_filter_name = "rag_soc_1" 				
			CASE	'AR'
				is_search_window = "w_articolo_coddes_sw" 	
				is_ricpar.s_filter_value = as_valcol 			
				is_ricpar.s_filter_name = "articolo_descrizione" 	
			CASE	'CP'
				is_search_window = "w_conto_azienda_coddes_sw"
				is_ricpar.s_filter_value = as_valcol 				
				is_ricpar.s_filter_name = "conto_descrizione" 			
		END CHOOSE		
		
	CASE "da_ragg_2_cod", "a_ragg_2_cod"
		ls_ragg_2 = This.GetItemString(1, "ragg_2")
		CHOOSE CASE ls_ragg_2
			CASE	'SC'
				is_search_window = "w_sog_commerciale_gen_coddes_sw" 	
				is_ricpar.s_filter_value = as_valcol 					
				is_ricpar.s_filter_name = "codice" 				
			CASE	'AR'
				is_search_window = "w_articolo_coddes_sw" 	
				is_ricpar.s_filter_value = as_valcol 			
				is_ricpar.s_filter_name = "articolo_codice" 	
			CASE	'CP'
				is_search_window = "w_conto_azienda_coddes_sw"
				is_ricpar.s_filter_value = as_valcol 				
				is_ricpar.s_filter_name = "conto_codice" 			
		END CHOOSE		
		
	CASE "da_ragg_2_des", "a_ragg_2_des"
		ls_ragg_2 = This.GetItemString(1, "ragg_2")
		CHOOSE CASE ls_ragg_2
			CASE	'SC'
				is_search_window = "w_sog_commerciale_gen_coddes_sw" 	
				is_ricpar.s_filter_value = as_valcol 					
				is_ricpar.s_filter_name = "rag_soc_1" 				
			CASE	'AR'
				is_search_window = "w_articolo_coddes_sw" 	
				is_ricpar.s_filter_value = as_valcol 			
				is_ricpar.s_filter_name = "articolo_descrizione" 	
			CASE	'CP'
				is_search_window = "w_conto_azienda_coddes_sw"
				is_ricpar.s_filter_value = as_valcol 				
				is_ricpar.s_filter_name = "conto_descrizione" 			
		END CHOOSE		
	
END CHOOSE

end event

event dw_selection::ue_use_search;call super::ue_use_search;

CHOOSE CASE as_nomecol
		
	CASE "da_ragg_1_cod", "a_ragg_1_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		if as_nomecol = "da_ragg_1_cod" then
			uf_set_colval("da_ragg_1_des", is_ricpar.s_ausil_value[1])
		else
			uf_set_colval("a_ragg_1_des", is_ricpar.s_ausil_value[1])
		end if
		
		
	CASE "da_ragg_1_des", "a_ragg_1_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		if as_nomecol = "da_ragg_1_des" then
			uf_set_colval("da_ragg_1_cod", is_ricpar.s_ausil_value[1])
		else
			uf_set_colval("a_ragg_1_cod", is_ricpar.s_ausil_value[1])
		end if

	CASE "da_ragg_2_cod", "a_ragg_2_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		if as_nomecol = "da_ragg_2_cod" then
			uf_set_colval("da_ragg_2_des", is_ricpar.s_ausil_value[1])
		else
			uf_set_colval("a_ragg_2_des", is_ricpar.s_ausil_value[1])
		end if
		
	CASE "da_ragg_2_des", "a_ragg_2_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		if as_nomecol = "da_ragg_2_des" then
			uf_set_colval("da_ragg_2_cod", is_ricpar.s_ausil_value[1])
		else
			uf_set_colval("a_ragg_2_cod", is_ricpar.s_ausil_value[1])
		end if		
		
END CHOOSE

end event

event dw_selection::ue_init;call super::ue_init;
is_drop_column[1]	= "id_valuta"
is_drop_column[2]	= "id_valuta_des"

end event

event dw_selection::ue_initial;
long	ll_id_valuta 

SELECT id_valuta
INTO	 :ll_id_valuta
FROM	 par_sistema
;

if (ll_id_valuta > 0) then 
	this.setitem(1, "id_valuta", ll_id_valuta)
end if

end event

type tabpage_stampante from w_print_main`tabpage_stampante within tab_1
int X=18
int Y=112
int Width=2478
int Height=1012
end type

type tabpage_export from w_print_main`tabpage_export within tab_1
int X=18
int Y=112
int Width=2478
int Height=1012
end type

type cb_stampa from w_print_main`cb_stampa within w_stat_vend_acq_rpt
int X=2011
int Y=80
end type

