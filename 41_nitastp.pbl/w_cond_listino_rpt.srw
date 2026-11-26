forward
global type w_cond_listino_rpt from w_print_main
end type
end forward

global type w_cond_listino_rpt from w_print_main
int Width=2363
int Height=1132
boolean TitleBar=true
string Title="Stampa condizioni di listino"
end type
global w_cond_listino_rpt w_cond_listino_rpt

on w_cond_listino_rpt.create
call super::create
end on

on w_cond_listino_rpt.destroy
call super::destroy
end on

event ue_pre_print;call super::ue_pre_print;

string	ls_da_art, ls_a_art, ls_da_sogg, ls_a_sogg, ls_app
date		ld_da_data, ld_a_data
String 	statement, ls_selezione

ls_da_art				= tab_1.tabpage_select.dw_selection.GetItemString(1,"da_art_cod")
ls_a_art					= tab_1.tabpage_select.dw_selection.GetItemString(1,"a_art_cod")
ls_da_sogg				= tab_1.tabpage_select.dw_selection.GetItemString(1,"da_sog_commerciale_gen_cod")
ls_a_sogg				= tab_1.tabpage_select.dw_selection.GetItemString(1,"a_sog_commerciale_gen_cod")
ld_da_data				= tab_1.tabpage_select.dw_selection.GetItemDate(1,"da_data")
ls_app         		= tab_1.tabpage_select.dw_selection.GetItemString(1,"tipo_registro")

if not isNull(ls_da_art) and not isNull(ls_a_art) then
	if ls_da_art > ls_a_art then
		if MessageBox( "Attenzione","Articolo 'da' maggiore Articolo 'a',continuare ?",Question!,YesNo!,2 ) = 2 then
			return -1
		end if
	end if	
end if

if not isNull(ls_da_sogg) and not isNull(ls_a_sogg) then
	if ls_da_sogg > ls_a_sogg then
		if MessageBox( "Attenzione","Soggetto 'da' maggiore di Soggetto 'a',continuare ?",Question!,YesNo!,2 ) = 2 then
			return -1
		end if
	end if	
end if



statement  = " {con_lis_articolo.ID_Azienda} = 1"

if Not IsNull(ld_da_data) then
	statement 		= statement + " AND {con_lis_articolo.data_inizio} >= Date (" + string(ld_da_data, "yyyy, mm, dd") + ")"
   statement 		= statement + " AND ({con_lis_articolo.data_fine} <= Date (" + string(ld_da_data, "yyyy, mm, dd") + ") OR {con_lis_articolo.data_fine} IS NULL )"
	ls_selezione 	= "Data validità listini " + string(ld_da_data, "dd/mm/yyyy") + ", "
else
	ls_selezione 	= " Dalla data - non definita, "	
end if


if Not IsNull(ls_da_art) and ls_da_art <> "" then
	statement 		= statement + " AND {articolo.codice} >= '" + ls_da_art + "'"
	ls_selezione 	= ls_selezione + " Da articolo " + ls_da_art + ", "
else
	ls_selezione 	= " Da articolo non definito, "
end if

if Not IsNull(ls_a_art) and ls_a_art <> "" then
	statement 		= statement + " AND {articolo.codice} <= '" + ls_a_art + "'"
	ls_selezione 	= ls_selezione + "a articolo " + ls_a_art + "."
else
	ls_selezione 	= ls_selezione + "a articolo non definito."
end if

if Not IsNull(ls_da_sogg) and ls_da_sogg <> "" then
	statement 		= statement + " AND {sog_commerciale.codice} >= '" + ls_da_sogg + "'"
	ls_selezione 	= ls_selezione + " Dal soggetto commerciale " + ls_da_sogg + ", "
else
	ls_selezione 	= " Dal soggetto commerciale non definito, "
end if

if Not IsNull(ls_a_sogg) and ls_a_sogg <> "" then
	statement 		= statement + " AND {sog_commerciale.codice} <= '" + ls_a_sogg + "'"
	ls_selezione 	= ls_selezione + "al soggetto commerciale " + ls_a_sogg + "."
else
	ls_selezione 	= ls_selezione + "al soggetto commerciale non definito."
end if

if Not IsNull(ls_app) then
	statement 		= statement + " AND {con_lis_articolo.applicazione} = '" + ls_app + "'"
	ls_selezione 	= ls_selezione + " Applicazione: " +ls_app + "."
else
	ls_selezione 	= ls_selezione + " Applicazione non definita."
end if



is_selection 	= statement


istr_formule[1].formula_name 		= "id_valuta"
istr_formule[1].formula_string 	= string(tab_1.tabpage_select.dw_selection.getitemnumber(1, "id_valuta"))

return 0
end event

type cb_esci from w_print_main`cb_esci within w_cond_listino_rpt
int X=2062
int Y=60
end type

type tab_1 from w_print_main`tab_1 within w_cond_listino_rpt
int Width=2290
int Height=848
end type

type tabpage_select from w_print_main`tabpage_select within tab_1
int X=18
int Y=112
int Width=2254
int Height=720
end type

type dw_selection from w_print_main`dw_selection within tabpage_select
int X=14
int Y=28
int Width=2217
int Height=676
string DataObject="d_tipo_cond_rpt"
end type

event dw_selection::ue_set_search;call super::ue_set_search;

CHOOSE CASE as_nomecol
		
	CASE "da_art_cod", "a_art_cod"
		is_search_window = "w_articolo_coddes_sw"    
		is_ricpar.s_filter_value = as_valcol 			
		is_ricpar.s_filter_name = "articolo_codice"  
		
		
	CASE "da_art_des", "a_art_des"
		is_search_window = "w_articolo_coddes_sw"   
		is_ricpar.s_filter_value = as_valcol 				 
		is_ricpar.s_filter_name = "articolo_descrizione" 
		
		
	CASE "da_sog_commerciale_gen_cod","a_sog_commerciale_gen_cod"
		is_search_window = "w_sog_commerciale_gen_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "codice" 
		
		
	CASE "da_sog_commerciale_gen_rag_soc_1","a_sog_commerciale_gen_rag_soc_1"
		is_search_window = "w_sog_commerciale_gen_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "rag_soc_1" 
		
		
END CHOOSE

end event

event dw_selection::ue_use_search;call super::ue_use_search;

CHOOSE CASE as_nomecol
		
	CASE "da_art_cod", "a_art_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		
		if as_nomecol = "da_art_cod" then
			uf_set_colval("da_art_des", is_ricpar.s_ausil_value[1])
		else
			uf_set_colval("a_art_des", is_ricpar.s_ausil_value[1])
		end if
		
	CASE "da_art_des", "a_art_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		
		if as_nomecol = "da_art_des" then
			uf_set_colval("da_art_cod", is_ricpar.s_ausil_value[1])
		else
			uf_set_colval("a_art_cod", is_ricpar.s_ausil_value[1])
		end if
		
	CASE "da_sog_commerciale_gen_cod", "a_sog_commerciale_gen_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		
		if as_nomecol = "da_sog_commerciale_gen_cod" then
			uf_set_colval("da_sog_commerciale_gen_rag_soc_1", is_ricpar.s_ausil_value[1])
		else
			uf_set_colval("a_sog_commerciale_gen_rag_soc_1", is_ricpar.s_ausil_value[1])
		end if
		
	CASE "da_sog_commerciale_gen_rag_soc_1", "a_sog_commerciale_gen_rag_soc_1"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		
		if as_nomecol = "da_sog_commerciale_gen_rag_soc_1" then
			uf_set_colval("da_sog_commerciale_gen_cod", is_ricpar.s_ausil_value[1])
		else
			uf_set_colval("a_sog_commerciale_gen_cod", is_ricpar.s_ausil_value[1])
		end if
		
END CHOOSE


end event

event dw_selection::ue_initial;
Post SetItem(1,"a_data",Today())

long	ll_id_valuta 

SELECT id_valuta
INTO	 :ll_id_valuta
FROM	 par_sistema
;

if (ll_id_valuta > 0) then 
	this.setitem(1, "id_valuta", ll_id_valuta)
end if
end event

event dw_selection::itemchanged;
string	ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
long		ll_ok

choose case dwo.name
	
		
	case 'da_art_des'
		
		ls_sql_cond=""  
		
		ls_dbc[1]=	"codice"
		ls_dwc[1]=	"da_art_cod"
		
		ls_dbc[2]=	"descrizione"
		ls_dwc[2]=	"da_art_des"
		
		ll_ok = uf_autofind_col(dwo.name,"articolo","descrizione","A",data,&
		                                ls_sql_cond,2,ls_dbc, ls_dbv, ls_dwc)
		
		if ll_ok>0 then 
			if isnull(this.getitemstring(1,'a_art_cod')) or this.getitemstring(1,'a_art_cod')='' then
				 this.setitem(1,'a_art_des',data)
				 this.setitem(1,'a_art_cod',this.getitemstring(1,'da_art_cod'))
			end if
			return 2
		end if	
		
		
		case 'a_art_des'
		
		ls_sql_cond=""  
		
		ls_dbc[1]=	"codice"
		ls_dwc[1]=	"a_art_cod"
		
		ls_dbc[2]=	"descrizione"
		ls_dwc[2]=	"a_art_des"
		
		ll_ok = uf_autofind_col(dwo.name,"articolo","descrizione","A",data,&
		                                ls_sql_cond,2,ls_dbc, ls_dbv, ls_dwc)
		
	
	case 'da_art_cod'
		
		ls_sql_cond=""  
		
		ls_dbc[1]=	"codice"
		ls_dwc[1]=	"da_art_cod"
		
		ls_dbc[2]=	"descrizione"
		ls_dwc[2]=	"da_art_des"
		
		ll_ok = uf_autofind_col(dwo.name,"articolo","codice","A",data,&
		                                ls_sql_cond,2,ls_dbc, ls_dbv, ls_dwc)
		
		
		if ll_ok>0 then 
			if isnull(this.getitemstring(1,'a_art_cod')) or this.getitemstring(1,'a_art_cod')='' then
				 this.setitem(1,'a_art_cod',data)
				 this.setitem(1,'a_art_des',this.getitemstring(1,'da_art_des'))
			end if
			return 2
		end if
		
		
		
		case 'a_art_cod'
		
		ls_sql_cond=""  
		
		ls_dbc[1]=	"codice"
		ls_dwc[1]=	"a_art_cod"
		
		ls_dbc[2]=	"descrizione"
		ls_dwc[2]=	"a_art_des"
		
		ll_ok = uf_autofind_col(dwo.name,"articolo","codice","A",data,&
		                                ls_sql_cond,2,ls_dbc, ls_dbv, ls_dwc)
	
	
		
	case "da_sog_commerciale_gen_cod"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		ls_dwc[1] = "da_sog_commerciale_gen_cod"
		ls_dwc[2] = "da_sog_commerciale_gen_rag_soc_1"
		ll_ok = uf_autofind_col (string(dwo.name),"sog_commerciale_gen","codice","A",data,"",2,ls_dbc,ls_dbv,ls_dwc)	
		if ll_ok>0 then 
			if isnull(this.getitemstring(1,'a_sog_commerciale_gen_cod')) or this.getitemstring(1,'a_sog_commerciale_gen_rag_soc_1')='' then
				 this.setitem(1,'a_sog_commerciale_gen_cod',data)
				 this.setitem(1,'a_sog_commerciale_gen_rag_soc_1',this.getitemstring(1,'da_sog_commerciale_gen_rag_soc_1'))
			end if
			return 2
		end if	
		
	case "da_sog_commerciale_gen_rag_soc_1"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		ls_dwc[1] = "da_sog_commerciale_gen_cod"
		ls_dwc[2] = "da_sog_commerciale_gen_rag_soc_1"
		ll_ok = uf_autofind_col (string(dwo.name),"sog_commerciale_gen","rag_soc_1","A",data,"",2,ls_dbc,ls_dbv,ls_dwc)	
		
		if ll_ok>0 then 
			if isnull(this.getitemstring(1,'a_sog_commerciale_gen_cod')) or this.getitemstring(1,'a_sog_commerciale_gen_cod')='' then
				 this.setitem(1,'a_sog_commerciale_gen_rag_soc_1',data)
				 this.setitem(1,'a_sog_commerciale_gen_cod',this.getitemstring(1,'da_sog_commerciale_gen_cod'))
			end if
			return 2
		end if	
	
	case "a_sog_commerciale_gen_cod"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		ls_dwc[1] = "a_sog_commerciale_gen_cod"
		ls_dwc[2] = "a_sog_commerciale_gen_rag_soc_1"
		ll_ok = uf_autofind_col (string(dwo.name),"sog_commerciale_gen","codice","A",data,"",2,ls_dbc,ls_dbv,ls_dwc)	
		if ll_ok>0 then 
			return 2
		end if	
		
	case "a_sog_commerciale_gen_rag_soc_1"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		ls_dwc[1] = "a_sog_commerciale_gen_cod"
		ls_dwc[2] = "a_sog_commerciale_gen_rag_soc_1"
		ll_ok = uf_autofind_col (string(dwo.name),"sog_commerciale_gen","rag_soc_1","A",data,"",2,ls_dbc,ls_dbv,ls_dwc)	
		if ll_ok>0 then 
			return 2
		end if	
		



		
		
		
		
end choose




end event

event dw_selection::ue_init;call super::ue_init;
is_drop_column[1]	= "id_valuta"
is_drop_column[2]	= "id_valuta_des"
end event

type tabpage_stampante from w_print_main`tabpage_stampante within tab_1
int X=18
int Y=112
int Width=2254
int Height=720
end type

type tabpage_export from w_print_main`tabpage_export within tab_1
int X=18
int Y=112
int Width=2254
int Height=720
end type

type cb_stampa from w_print_main`cb_stampa within w_cond_listino_rpt
int X=1765
int Y=60
end type

