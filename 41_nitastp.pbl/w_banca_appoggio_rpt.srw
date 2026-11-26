forward
global type w_banca_appoggio_rpt from w_print_main
end type
end forward

global type w_banca_appoggio_rpt from w_print_main
int Width=2478
int Height=1196
boolean TitleBar=true
string Title="Stampa Banche Appoggio"
end type
global w_banca_appoggio_rpt w_banca_appoggio_rpt

on w_banca_appoggio_rpt.create
call super::create
end on

on w_banca_appoggio_rpt.destroy
call super::destroy
end on

event ue_pre_print;call super::ue_pre_print;
String	ls_da_codice, ls_ad_codice
String 	ls_statement, ls_statform
long		ll_da, ll_ad

ls_da_codice = tab_1.tabpage_select.dw_selection.GetItemString(1, 1, Primary!, TRUE)	
ls_ad_codice = tab_1.tabpage_select.dw_selection.GetItemString(1, 2, Primary!, TRUE)
ls_statement = ""


if ls_da_codice > ls_ad_codice then
	if MessageBox( "Attenzione","Banca 'da' maggiore di Banca 'a',continuare ?",Question!,YesNo!,2 ) = 2 then
		return -1
	end if
end if	

if not IsNull(ls_da_codice) and ls_da_codice <> "" then
	ls_statement	= ls_statement + "{Banca_appoggio.Cod_ABI} >= '" + ls_da_codice + "'"
	ls_statform		= "'Da codice ABI " + ls_da_codice + ", "
else
	ls_statform		= "'Da codice ABI non definito, "
end if

if not IsNull(ls_ad_codice) and ls_ad_codice <> "" then
	if not isNull( ls_da_codice ) and ls_da_codice <> "" then
		ls_statement	= ls_statement + " AND {Banca_appoggio.Cod_ABI} <= '" + ls_ad_codice + "'"
		ls_statform		= ls_statform + "a Codice ABI " + ls_ad_codice + ".'"
	end if	
	if isNull( ls_da_codice ) or ls_da_codice = "" then
		ls_statement	= ls_statement + "{Banca_appoggio.Cod_ABI} <= '" + ls_ad_codice + "'"
		ls_statform		= "'Fino a Codice ABI " + ls_ad_codice + ".'"
	end if	
else
	ls_statform  	= ls_statform + "a Codice ABI non definito.'"
end if

is_selection = ls_statement

istr_formule[1].formula_name 		= "selezione"
istr_formule[1].formula_string 	= ls_statform
							
return 0


end event

type cb_esci from w_print_main`cb_esci within w_banca_appoggio_rpt
int X=2176
end type

type tab_1 from w_print_main`tab_1 within w_banca_appoggio_rpt
int Width=2377
int Height=880
end type

type tabpage_select from w_print_main`tabpage_select within tab_1
int X=18
int Y=112
int Width=2341
int Height=752
end type

type dw_selection from w_print_main`dw_selection within tabpage_select
int X=27
int Y=28
int Width=2286
int Height=700
string DataObject="d_banca_appoggio_rpt"
end type

event dw_selection::ue_set_search;call super::ue_set_search;

CHOOSE CASE as_nomecol
		
	CASE "da_abi", "ad_abi"
		is_search_window = "w_banca_appoggio_sw" 

		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "cod_abi" 

	CASE "da_descr", "a_descr"
		is_search_window = "w_banca_appoggio_sw" 

		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "den_abi" 
		
END CHOOSE

end event

event dw_selection::ue_use_search;

CHOOSE CASE as_nomecol

	CASE "da_abi", "ad_abi"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		
		if as_nomecol = "da_abi" then
			uf_set_colval("da_descr",is_ricpar.s_ausil_value[2])
			if isnull(this.getitemstring(1,'ad_abi')) or this.getitemstring(1,'ad_abi')='' then
				 uf_set_colval("ad_abi", is_ricpar.s_main_value)
				 uf_set_colval("a_descr",is_ricpar.s_ausil_value[2])
			end if
		else
			uf_set_colval("a_descr",is_ricpar.s_ausil_value[2])
		end if

	CASE "da_descr", "a_descr"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		
		if as_nomecol = "da_descr" then
			uf_set_colval("da_abi",is_ricpar.s_ausil_value[1])
			if isnull(this.getitemstring(1,'ad_abi')) or this.getitemstring(1,'ad_abi')='' then
				 uf_set_colval("a_descr", is_ricpar.s_main_value)
				 uf_set_colval("ad_abi",is_ricpar.s_ausil_value[2])
			end if
		else
			uf_set_colval("ad_abi",is_ricpar.s_ausil_value[1])
		end if
	
END CHOOSE

end event

event dw_selection::itemchanged;string		ls_dbc[], ls_dbv[], ls_dwc[], ls_codice, ls_cod_art
integer li_ok
CHOOSE CASE dwo.name
	case "da_abi"
		ls_dbc[1] = "cod_abi"
		ls_dbc[2] = "den_abi"
		ls_dwc[1] = "da_abi"
		ls_dwc[2] = "da_descr"
		li_ok = uf_autofind_col (string(dwo.name),"banca_appoggio","cod_abi","A",data,"",2,ls_dbc,ls_dbv,ls_dwc)	
		if li_ok>0 then 
			if isnull(this.getitemstring(1,'ad_abi')) or this.getitemstring(1,'ad_abi')='' then
				 this.setitem(1,'ad_abi',data)
				 this.setitem(1,'a_descr',this.getitemstring(1,'da_descr'))
			end if
			return 2
		end if	
		
	case "da_descr"
		ls_dbc[1] = "cod_abi"
		ls_dbc[2] = "den_abi"
		ls_dwc[1] = "da_abi"
		ls_dwc[2] = "da_descr"
		li_ok = uf_autofind_col (string(dwo.name),"banca_appoggio","den_abi","A",data,"",2,ls_dbc,ls_dbv,ls_dwc)	
		
		if li_ok>0 then 
			if isnull(this.getitemstring(1,'ad_abi')) or this.getitemstring(1,'ad_abi')='' then
				 this.setitem(1,'a_descr',data)
				 this.setitem(1,'ad_abi',this.getitemstring(1,'da_abi'))
			end if
			return 2
		end if	
	
	case "ad_abi"
		ls_dbc[1] = "cod_abi"
		ls_dbc[2] = "den_abi"
		ls_dwc[1] = "ad_abi"
		ls_dwc[2] = "a_descr"
		li_ok = uf_autofind_col (string(dwo.name),"banca_appoggio","cod_abi","A",data,"",2,ls_dbc,ls_dbv,ls_dwc)	
		if li_ok>0 then 
			return 2
		end if	
		
	case "a_descr"
		ls_dbc[1] = "cod_abi"
		ls_dbc[2] = "den_abi"
		ls_dwc[1] = "ad_abi"
		ls_dwc[2] = "a_descr"
		li_ok = uf_autofind_col (string(dwo.name),"banca_appoggio","den_abi","A",data,"",2,ls_dbc,ls_dbv,ls_dwc)	
		if li_ok>0 then 
			return 2
		end if	
		
end choose
end event

type tabpage_stampante from w_print_main`tabpage_stampante within tab_1
int X=18
int Y=112
int Width=2341
int Height=752
end type

type tabpage_export from w_print_main`tabpage_export within tab_1
int X=18
int Y=112
int Width=2341
int Height=752
end type

type cb_stampa from w_print_main`cb_stampa within w_banca_appoggio_rpt
int X=1925
end type

