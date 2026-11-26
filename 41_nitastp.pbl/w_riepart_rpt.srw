forward
global type w_riepart_rpt from w_print_main
end type
end forward

global type w_riepart_rpt from w_print_main
int Width=2702
int Height=1192
boolean TitleBar=true
string Title="Stampa Riepiloghi di Magazzino per Articolo"
end type
global w_riepart_rpt w_riepart_rpt

on w_riepart_rpt.create
call super::create
end on

on w_riepart_rpt.destroy
call super::destroy
end on

event ue_pre_print;call super::ue_pre_print;
String	ls_da_codice, ls_ad_codice
String 	ls_statement, ls_statform

ls_da_codice = tab_1.tabpage_select.dw_selection.GetItemString(1, 1, Primary!, TRUE)	
ls_ad_codice = tab_1.tabpage_select.dw_selection.GetItemString(1, 1, Primary!, TRUE)	

if ls_da_codice > ls_ad_codice then
	if MessageBox( "Attenzione","Articolo 'da' maggiore di Articolo 'a',continuare ?",Question!,YesNo!,2 ) = 2 then
		return -1
	end if
end if	

ls_statement  = "{Articolo.ID_Azienda} = 1"


if not IsNull(ls_da_codice) and ls_da_codice <> "" then
	ls_statement	= ls_statement + " AND {Articolo.Codice} >= '" + ls_da_codice + "'"
	ls_statform		= "'Da codice " + ls_da_codice + ", "
else
	ls_statform		= "'Da codice non definito, "
end if

if not IsNull(ls_ad_codice) and ls_ad_codice <> "" then
	ls_statement	= ls_statement + " AND {Articolo.Codice} <= '" + ls_ad_codice + "'"
	ls_statform		= ls_statform + "a codice " + ls_ad_codice + ".'"
else
	ls_statform		= ls_statform + "a codice non definito.'"
end if


is_selection = ls_statement

istr_formule[1].formula_name 		= "selezione"
istr_formule[1].formula_string 	= ls_statform
							
return 0
end event

type cb_esci from w_print_main`cb_esci within w_riepart_rpt
int X=2331
end type

type tab_1 from w_print_main`tab_1 within w_riepart_rpt
int X=27
int Y=188
int Width=2601
end type

type tabpage_select from w_print_main`tabpage_select within tab_1
int X=18
int Y=112
int Width=2565
int Height=756
end type

type dw_selection from w_print_main`dw_selection within tabpage_select
int X=27
int Y=28
int Width=2514
int Height=700
string DataObject="d_riepart_rpt"
end type

event dw_selection::ue_use_search;

CHOOSE CASE as_nomecol
		
	CASE "da_cod", "a_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_articolo", is_ricpar.s_id_seg_value[1])
		if as_nomecol = "da_cod" then
			uf_set_colval("da_descr", is_ricpar.s_ausil_value[1])
			if isnull(this.getitemstring(1,'a_cod')) or this.getitemstring(1,'a_cod')='' then
				 uf_set_colval('a_cod', is_ricpar.s_main_value)
			    uf_set_colval("a_descr", is_ricpar.s_ausil_value[1])
			end if
		else
			uf_set_colval("a_descr", is_ricpar.s_ausil_value[1])
		end if
	CASE "da_descr", "a_descr"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_articolo", is_ricpar.s_id_seg_value[1])
		if as_nomecol = "da_descr" then
			uf_set_colval("da_cod", is_ricpar.s_ausil_value[1])
			if isnull(this.getitemstring(1,'a_cod')) or this.getitemstring(1,'a_cod')='' then
				 uf_set_colval('a_descr', is_ricpar.s_main_value)
			    uf_set_colval("a_cod", is_ricpar.s_ausil_value[1])
			end if
		else
			uf_set_colval("a_cod", is_ricpar.s_ausil_value[1])
		end if
END CHOOSE

end event

event dw_selection::ue_set_search;

CHOOSE CASE as_nomecol
		
	CASE "da_cod", "a_cod"
		is_search_window = "w_articolo_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "articolo_codice" 
	CASE "da_descr", "a_descr"
		is_search_window = "w_articolo_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "articolo_descrizione" 
		
END CHOOSE

end event

event dw_selection::itemchanged;string		ls_dbc[], ls_dbv[], ls_dwc[]
integer li_ok
CHOOSE CASE dwo.name
	case "da_cod"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dwc[1] = "da_cod"
		ls_dwc[2] = "da_descr"
		li_ok = uf_autofind_col (string(dwo.name),"articolo","codice","A",data,"",2,ls_dbc,ls_dbv,ls_dwc)	
		if li_ok>0 then 
			if isnull(this.getitemstring(1,'a_cod')) or this.getitemstring(1,'a_cod')='' then
				 this.setitem(1,'a_cod',data)
				 this.setitem(1,'a_descr',this.getitemstring(1,'da_descr'))
			end if
			return 2
		end if	
		
	case "da_descr"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dwc[1] = "da_cod"
		ls_dwc[2] = "da_descr"
		li_ok = uf_autofind_col (string(dwo.name),"articolo","descrizione","A",data,"",2,ls_dbc,ls_dbv,ls_dwc)	
		
		if li_ok>0 then 
			if isnull(this.getitemstring(1,'a_cod')) or this.getitemstring(1,'a_cod')='' then
				 this.setitem(1,'a_descr',data)
				 this.setitem(1,'a_cod',this.getitemstring(1,'da_cod'))
			end if
			return 2
		end if	
	
	case "a_cod"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dwc[1] = "a_cod"
		ls_dwc[2] = "a_descr"
		li_ok = uf_autofind_col (string(dwo.name),"articolo","codice","A",data,"",2,ls_dbc,ls_dbv,ls_dwc)	
		if li_ok>0 then 
			return 2
		end if	
		
	case "a_descr"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dwc[1] = "a_cod"
		ls_dwc[2] = "a_descr"
		li_ok = uf_autofind_col (string(dwo.name),"articolo","descrizione","A",data,"",2,ls_dbc,ls_dbv,ls_dwc)	
		if li_ok>0 then 
			return 2
		end if	
		
end choose
end event

type tabpage_stampante from w_print_main`tabpage_stampante within tab_1
int X=18
int Y=112
int Width=2565
int Height=756
end type

type tabpage_export from w_print_main`tabpage_export within tab_1
int X=18
int Y=112
int Width=2565
int Height=756
end type

type cb_stampa from w_print_main`cb_stampa within w_riepart_rpt
int X=2066
end type

