forward
global type w_stp_documenti_rpt from w_print_main
end type
end forward

global type w_stp_documenti_rpt from w_print_main
int Width=2606
int Height=1488
boolean TitleBar=true
string Title="Stampa documenti"
end type
global w_stp_documenti_rpt w_stp_documenti_rpt

type variables
long			il_id_esercizio
end variables

on w_stp_documenti_rpt.create
call super::create
end on

on w_stp_documenti_rpt.destroy
call super::destroy
end on

event ue_pre_print;call super::ue_pre_print;
long		ll_retval, ll_mod_reg, ll_eser
string	ls_da_sogg, ls_a_sogg, ls_da_articolo, ls_a_articolo, ls_a_ag, ls_da_ag, ls_da_reg, ls_a_reg
date		ld_da_data, ld_a_data
String 	statement, ls_selezione

ls_da_sogg				= tab_1.tabpage_select.dw_selection.GetItemString(1,"da_cod_sog")
ls_a_sogg				= tab_1.tabpage_select.dw_selection.GetItemString(1,"a_cod_sog")
ld_da_data				= tab_1.tabpage_select.dw_selection.GetItemDate(1,"da_data")
ld_a_data				= tab_1.tabpage_select.dw_selection.GetItemDate(1,"a_data")
ls_da_articolo			= tab_1.tabpage_select.dw_selection.GetItemString(1,"da_cod_art")
ls_a_articolo			= tab_1.tabpage_select.dw_selection.GetItemString(1,"a_cod_art")
ll_mod_reg           = tab_1.tabpage_select.dw_selection.GetItemNumber(1,"mod_reg")
ls_da_reg            = tab_1.tabpage_select.dw_selection.GetItemString(1,"da_reg")
ls_a_reg             = tab_1.tabpage_select.dw_selection.GetItemString(1,"a_reg")

if ls_da_sogg > ls_a_sogg then
	if MessageBox( "Attenzione","Soggetto 'da' maggiore di Soggetto 'a',continuare ?",Question!,YesNo!,2 ) = 2 then
		return -1
	end if
end if	

if ls_da_reg > ls_a_reg then
	if MessageBox( "Attenzione","Registro 'da' maggiore di Registro 'a',continuare ?",Question!,YesNo!,2 ) = 2 then
		return -1
	end if
end if	


if ld_da_data > ld_a_data then
	if MessageBox( "Attenzione","Data 'da' maggiore di Data 'a',continuare ?",Question!,YesNo!,2 ) = 2 then
		return -1
	end if
end if	

if ls_da_articolo > ls_a_articolo then
	if MessageBox( "Attenzione","Articolo 'da' maggiore di Articolo 'a',continuare ?",Question!,YesNo!,2 ) = 2 then
		return -1
	end if
end if	

statement  = " {Articolo.ID_Azienda} = 1"


if Not IsNull(ld_da_data) then
	statement 		= statement + " AND {Documento.Data_Registrazione} >= Date (" + string(ld_da_data, "yyyy, mm, dd") + ")"
	ls_selezione 	= " Dal data reg. " + string(ld_da_data, "dd/mm/yyyy") + ", "
end if

if Not IsNull(ld_a_data) then
	statement 		= statement + " AND {Documento.Data_Registrazione} <= Date (" + string(ld_a_data, "yyyy, mm, dd") + ")"
	ls_selezione 	= ls_selezione + "a data reg. " + string(ld_a_data, "dd/mm/yyyy") + "."
end if

if Not IsNull(ls_da_articolo) and ls_da_articolo <> "" then
	statement 		= statement + " AND {Articolo.Codice} >= '" + ls_da_articolo + "'"
	ls_selezione 	= ls_selezione + " Da art. " + ls_da_articolo + ", "
end if

if Not IsNull(ls_a_articolo) and ls_a_articolo <> "" then
	statement 		= statement + " AND {Articolo.Codice} <= '" + ls_a_articolo + "'"
	ls_selezione 	= ls_selezione + "ad art. " + ls_a_articolo + "."
end if

if Not IsNull(ls_da_sogg) and ls_da_sogg <> "" then
	statement 		= statement + " AND {Sog_Commerciale.Codice} >= '" + ls_da_sogg + "'"
	ls_selezione 	= ls_selezione + " Da sogg. comm. " + ls_da_sogg + ", "
end if

if Not IsNull(ls_a_sogg) and ls_a_sogg <> "" then
	statement 		= statement + " AND {Sog_Commerciale.Codice} <= '" + ls_a_sogg + "'"
	ls_selezione 	= ls_selezione + "a sogg. comm. " + ls_a_sogg + "."
end if


if Not IsNull(ll_mod_reg) and ll_mod_reg<>0 then
	statement 		= statement + " AND {Registro.Id_Mod_Registro} = " + string(ll_mod_reg)
	ls_selezione 	= ls_selezione + " Da Mod. reg. " + string(ll_mod_reg) + ". "
else

	if Not IsNull(ls_da_reg) and ls_da_reg <> "" then
		statement 		= statement + " AND {Registro.Tipo_Registro} >= '" + ls_da_reg + "'"
		ls_selezione 	= ls_selezione + " Da Reg. " + ls_da_reg + ", "
	end if

	if Not IsNull(ls_a_reg) and ls_a_reg <> "" then
		statement 		= statement + " AND {Registro.Tipo_Registro} <= '" + ls_a_reg + "'"
		ls_selezione 	= ls_selezione + " Da Reg. " + ls_a_reg + ", "
	end if

   if Not IsNull(ll_eser) and ll_eser <> 0 then
		statement 		= statement + " AND {Registro.Id_Esercizio} = " + string(ll_eser)
	end if

end if



is_selection 	= statement

istr_formule[1].formula_name 	= "selezione"
istr_formule[1].formula_string 	= "'" + ls_selezione + "'"

istr_formule[2].formula_name 		= "id_valuta"
istr_formule[2].formula_string 	= string(tab_1.tabpage_select.dw_selection.getitemnumber(1, "id_valuta"))

return 0

end event

type cb_esci from w_print_main`cb_esci within w_stp_documenti_rpt
int X=2226
int Y=48
end type

type tab_1 from w_print_main`tab_1 within w_stp_documenti_rpt
int X=27
int Width=2546
int Height=1200
end type

type tabpage_select from w_print_main`tabpage_select within tab_1
int X=18
int Y=112
int Width=2510
int Height=1072
end type

type dw_selection from w_print_main`dw_selection within tabpage_select
int X=37
int Y=48
int Width=2432
int Height=984
string DataObject="d_stp_documenti_rpt"
end type

event dw_selection::ue_init;call super::ue_init;is_drop_column[1]	= "mod_reg"
is_drop_column[2]	= "da_reg"
is_drop_column[3]	= "a_reg"
is_drop_column[4]	= "esercizio"

is_drop_column[4]	= "id_valuta"
is_drop_column[5]	= "id_valuta_des"

end event

event dw_selection::ue_set_search;
CHOOSE CASE as_nomecol
				
	CASE "da_cod_art", "a__cod_art"
		is_search_window = "w_articolo_coddes_sw" 			
		is_ricpar.s_filter_value = as_valcol 					
		is_ricpar.s_filter_name = "articolo_codice" 			
	CASE "da_des_art", "a_des_art"
		is_search_window = "w_articolo_coddes_sw" 			
		is_ricpar.s_filter_value = as_valcol 					
		is_ricpar.s_filter_name = "articolo_descrizione" 	
		
	CASE "da_cod_sog", "a_cod_sog"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 	
		is_ricpar.s_filter_value = as_valcol 						
		is_ricpar.s_filter_name = "codice" 							
	CASE "da_des_sog", "a_des_sog"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 	
		is_ricpar.s_filter_value = as_valcol 						
		is_ricpar.s_filter_name = "rag_soc_1" 						
		
END CHOOSE

end event

event dw_selection::ue_use_search;CHOOSE CASE as_nomecol
		
	CASE "da_cod_sog", "a_cod_sog"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		if as_nomecol = "da_cod_sog" then
			uf_set_colval("da_des_sog", is_ricpar.s_ausil_value[1])
			if isnull(this.getitemstring(1,'a_cod_sog')) or this.getitemstring(1,'a_cod_sog')='' then
				 uf_set_colval('a_cod_sog', is_ricpar.s_main_value)
			    uf_set_colval("a_des_sog", is_ricpar.s_ausil_value[1])
			end if
		else
			uf_set_colval("a_des_sog", is_ricpar.s_ausil_value[1])
		end if
	CASE "da_des_sog", "a_des_sog"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		if as_nomecol = "da_des_sog" then
			uf_set_colval("da_cod_sog", is_ricpar.s_ausil_value[1])
			if isnull(this.getitemstring(1,'a_cod_sog')) or this.getitemstring(1,'a_cod_sog')='' then
				 uf_set_colval('a_des_sog', is_ricpar.s_main_value)
			    uf_set_colval("a_cod_sog", is_ricpar.s_ausil_value[1])
			end if
		else
			uf_set_colval("a_cod_sog", is_ricpar.s_ausil_value[1])
		end if
		
  CASE "da_cod_art", "a_cod_art"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		
		if as_nomecol = "da_cod_art" then
			uf_set_colval("da_des_art", is_ricpar.s_ausil_value[1])
			if isnull(this.getitemstring(1,'a_cod_art')) or this.getitemstring(1,'a_cod_art')='' then
				 uf_set_colval('a_cod_art', is_ricpar.s_main_value)
			    uf_set_colval("a_des_art", is_ricpar.s_ausil_value[1])
			end if
		else
			uf_set_colval("a_des_art", is_ricpar.s_ausil_value[1])
		end if
	CASE "da_des_art", "a_des_art"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		
		if as_nomecol = "da_des_art" then
			uf_set_colval("da_cod_art", is_ricpar.s_ausil_value[1])
			if isnull(this.getitemstring(1,'a_cod_art')) or this.getitemstring(1,'a_cod_art')='' then
				 uf_set_colval('a_des_art', is_ricpar.s_main_value)
			    uf_set_colval("a_cod_art", is_ricpar.s_ausil_value[1])
			end if
		else
			uf_set_colval("a_cod_art", is_ricpar.s_ausil_value[1])
		end if
	
END CHOOSE

end event

event dw_selection::ue_initial;
long					ll_row
string 				ls_filtro
datawindowchild	ldwc_drop1, ldwc_drop2

select  "azienda"."id_esercizio_proposto"
	into :il_id_esercizio
	from "dba"."azienda"
	where "azienda"."id_azienda" = 1
	using SQLCA;

if SQLCA.SQLCode = 0 then
	if not isNull( il_id_esercizio ) then
		
		ll_row	= this.GetRow()
		this.SetItem( ll_row,"esercizio",il_id_esercizio )
	
		if this.GetChild( "da_reg",ldwc_drop1 ) = 1 and this.GetChild( "a_reg",ldwc_drop2 ) = 1 then
			if not isNull( ldwc_drop1 ) and not isnull( ldwc_drop2 ) then
				ls_filtro = "registro_id_esercizio = " + string(il_id_esercizio)
				if ldwc_drop1.SetFilter(ls_filtro) = -1 or ldwc_drop2.SetFilter(ls_filtro) = -1 then
					MessageBox( "Set Filter error","Errore nell'applicazione del filtro",Information! )
				end if
				if ldwc_drop1.Filter() = -1 or ldwc_drop2.Filter() = -1 then
					MessageBox( "Filter error","Errore nell'applicazione del filtro",Information! )
				end if
			end if
		end if	
	end if
		
end if

long	ll_id_valuta 

SELECT id_valuta
INTO	 :ll_id_valuta
FROM	 par_sistema
;

if (ll_id_valuta > 0) then 
	this.setitem(1, "id_valuta", ll_id_valuta)
end if

end event

event dw_selection::itemchanged;date		ld_dalla_data
string	ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
integer li_ok
long ll_esercizio
string 				ls_filtro
datawindowchild	ldwc_drop1, ldwc_drop2

CHOOSE CASE dwo.name
		
	case 'esercizio'
		
		ll_esercizio=long(data)
		
		if not isNull( ll_esercizio ) then
			this.SetItem( row,"esercizio",ll_esercizio )
		
			if this.GetChild( "da_reg",ldwc_drop1 ) = 1 and this.GetChild( "a_reg",ldwc_drop2 ) = 1 then
				if not isNull( ldwc_drop1 ) and not isnull( ldwc_drop2 ) then
					ls_filtro = "registro_id_esercizio = " + string(il_id_esercizio)
					ldwc_drop1.SetFilter(ls_filtro)
					ldwc_drop2.SetFilter(ls_filtro)
					ldwc_drop1.Filter()
					ldwc_drop2.Filter()
				end if
		   end if	
		else	
			if this.GetChild( "da_reg",ldwc_drop1 ) = 1 and this.GetChild( "a_reg",ldwc_drop2 ) = 1 then
				if not isNull( ldwc_drop1 ) and not isnull( ldwc_drop2 ) then
					ldwc_drop1.SetFilter("")
			      ldwc_drop1.Filter()
					ldwc_drop2.SetFilter("")
			      ldwc_drop2.Filter()
				end if
			end if	
			this.SetItem(row,"a_reg",u_freddie.gs_null )
			this.SetItem(row,"da_reg",u_freddie.gs_null )
		end if	
		
		
		
		
		
	CASE 'alla_data'
		ld_dalla_data = This.GetItemDate(1, "dalla_data")
		if Date(data) < ld_dalla_data then
			MessageBox("Attenzione", "Data fine non può essere inferiore alla data di inizio.")
			Post SetColumn("alla_data")
		end if
	case "da_cod_art"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dwc[1] = "da_cod_art"
		ls_dwc[2] = "da_des_art"
		li_ok = uf_autofind_col (string(dwo.name),"articolo","codice","A",data,"",2,ls_dbc,ls_dbv,ls_dwc)	
		if li_ok>0 then 
			if isnull(this.getitemstring(1,'a_cod_art')) or this.getitemstring(1,'a_cod_art')='' then
				 this.setitem(1,'a_cod_art',data)
				 this.setitem(1,'a_des_art',this.getitemstring(1,'da_des_art'))
			end if
			return 2
		end if	
		
	case "da_des_art"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dwc[1] = "da_cod_art"
		ls_dwc[2] = "da_des_art"
		li_ok = uf_autofind_col (string(dwo.name),"articolo","descrizione","A",data,"",2,ls_dbc,ls_dbv,ls_dwc)	
		
		if li_ok>0 then 
			if isnull(this.getitemstring(1,'a_cod_art')) or this.getitemstring(1,'a_cod_art')='' then
				 this.setitem(1,'a_des_art',data)
				 this.setitem(1,'a_cod_art',this.getitemstring(1,'da_cod_art'))
			end if
			return 2
		end if	
	
case "a_cod_art"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dwc[1] = "a_cod_art"
		ls_dwc[2] = "a_des_art"
		li_ok = uf_autofind_col (string(dwo.name),"articolo","codice","A",data,"",2,ls_dbc,ls_dbv,ls_dwc)	
		if li_ok>0 then 
			return 2
		end if	
		
	case "a_des_art"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dwc[1] = "a_cod_art"
		ls_dwc[2] = "a_des_art"
		li_ok = uf_autofind_col (string(dwo.name),"articolo","descrizione","A",data,"",2,ls_dbc,ls_dbv,ls_dwc)	
		
		if li_ok>0 then 
			return 2
		end if			
		
		
	case "da_cod_sog"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		ls_dwc[1] = "da_cod_sog"
		ls_dwc[2] = "da_des_sog"
		li_ok = uf_autofind_col (string(dwo.name),"sog_commerciale_gen","codice","A",data,"",2,ls_dbc,ls_dbv,ls_dwc)	
		if li_ok>0 then 
			if isnull(this.getitemstring(1,'a_cod_sog')) or this.getitemstring(1,'a_cod_sog')='' then
				 this.setitem(1,'a_cod_sog',data)
				 this.setitem(1,'a_des_sog',this.getitemstring(1,'da_des_sog'))
			end if
			return 2
		end if	
		
	case "da_des_sog"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		ls_dwc[1] = "da_cod_sog"
		ls_dwc[2] = "da_des_sog"
		li_ok = uf_autofind_col (string(dwo.name),"sog_commerciale_gen","rag_soc_1","A",data,"",2,ls_dbc,ls_dbv,ls_dwc)	
		
		if li_ok>0 then 
			if isnull(this.getitemstring(1,'a_cod_sog')) or this.getitemstring(1,'a_cod_sog')='' then
				 this.setitem(1,'a_des_sog',data)
				 this.setitem(1,'a_cod_sog',this.getitemstring(1,'da_cod_sog'))
			end if
			return 2
		end if	
	
	case "a_cod_sog"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		ls_dwc[1] = "a_cod_sog"
		ls_dwc[2] = "a_des_sog"
		li_ok = uf_autofind_col (string(dwo.name),"sog_commerciale_gen","codice","A",data,"",2,ls_dbc,ls_dbv,ls_dwc)	
		if li_ok>0 then 
			return 2
		end if	
		
	case "a_des_sog"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		ls_dwc[1] = "a_cod_sog"
		ls_dwc[2] = "a_des_sog"
		li_ok = uf_autofind_col (string(dwo.name),"sog_commerciale_gen","rag_soc_1","A",data,"",2,ls_dbc,ls_dbv,ls_dwc)	
		if li_ok>0 then 
			return 2
		end if	
			
END CHOOSE

end event

type tabpage_stampante from w_print_main`tabpage_stampante within tab_1
int X=18
int Y=112
int Width=2510
int Height=1072
end type

type tabpage_export from w_print_main`tabpage_export within tab_1
int X=18
int Y=112
int Width=2510
int Height=1072
end type

type cb_stampa from w_print_main`cb_stampa within w_stp_documenti_rpt
int X=1952
int Y=48
end type

