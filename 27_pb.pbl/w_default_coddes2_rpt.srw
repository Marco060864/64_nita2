forward
global type w_default_coddes2_rpt from w_print_main
end type
end forward

global type w_default_coddes2_rpt from w_print_main
int Width=1911
int Height=940
boolean TitleBar=true
string Title="Stampa ~"Cost Including Freight~" "
end type
global w_default_coddes2_rpt w_default_coddes2_rpt

type variables

end variables

on w_default_coddes2_rpt.create
call super::create
end on

on w_default_coddes2_rpt.destroy
call super::destroy
end on

event ue_pre_print;call super::ue_pre_print;
String	ls_da, ls_ad, ls_adda, ls_azienda, ls_group,ls_sort,ls_tipo,ls_completa
String	ls_da_rpt, ls_ad_rpt
String	ls_tipo_col1, ls_tipo_col2 
String 	ls_col1_name, ls_col2_name, ls_col1_type, ls_col2_type, ls_col_count
string	ls_type
String 	ls_statement, ls_statform
date		ld_da, ld_ad
long		ll_idx, ll_da, ll_ad
integer  li_msg

DataWindow ldw_dw
ldw_dw = Tab_1.Tabpage_select.dw_selection

if not ( IsNull( istr_coddes_rpt.nome_group ) or ( istr_coddes_rpt.nome_group = "" ) ) then
	ls_group = istr_coddes_rpt.nome_group
else
	ls_group = "R"
end if

if not ( IsNull( istr_coddes_rpt.nome_id_azienda ) or ( istr_coddes_rpt.nome_id_azienda = "" ) ) then
	ls_azienda = "{" + istr_coddes_rpt.nome_id_azienda + "}" + " = 1"
else
	ls_azienda = ""
end if

ls_statement  = ls_azienda

if ( IsNull( istr_coddes_rpt.nome_campo_db_cod ) or ( istr_coddes_rpt.nome_campo_db_cod = "" ) ) and &
   ( istr_coddes_rpt.use_completa_semplificata	= False ) then
	return 0
end if

ls_col1_name  = tab_1.tabpage_select.dw_selection.Describe("#1.Name")
ls_col2_name  = tab_1.tabpage_select.dw_selection.Describe("#2.Name")
ls_col1_type  = tab_1.tabpage_select.dw_selection.Describe(ls_col1_name  + ".ColType")
ls_col2_type  = tab_1.tabpage_select.dw_selection.Describe(ls_col2_name  + ".ColType")
ls_col_count  = tab_1.tabpage_select.dw_selection.Describe("DataWindow.Column.Count")

ls_tipo_col1 = Left(ls_col1_type, 3)
ls_tipo_col2 = Left(ls_col2_type, 3)


if not (ls_tipo_col1 = ls_tipo_col2) then
	MessageBox("Errore", "Tipo Colonna 1 :" + ls_col1_type + "~n" + &
 							   "Tipo Colonna 2 :" + ls_col2_type + "~n",StopSign! )
	return -1
end if

choose case ls_tipo_col1		
	case "Dat", "dat"
		ld_da = tab_1.tabpage_select.dw_selection.GetItemDate(1, 1, Primary!, TRUE)
		ls_da = String(ld_da, "dd/mm/yyyy")
	case "Num", "num"
		ll_da = tab_1.tabpage_select.dw_selection.GetItemNumber(1, 1, Primary!, TRUE)
		ls_da = String(ll_da)
	case "Cha", "cha"
		ls_da = tab_1.tabpage_select.dw_selection.GetItemString(1, 1, Primary!, TRUE)	
	case else
		MessageBox("Errore", "Tipo Dati Colonna Non Previsto:" + ls_col1_type)
		return -1
		
end choose

choose case ls_tipo_col2
		
	case "Dat", "dat"
		ld_ad = tab_1.tabpage_select.dw_selection.GetItemDate(1, 2, Primary!, TRUE)
		ls_ad = String(ld_ad, "dd/mm/yyyy")
		if ( not ( IsNull(ls_ad) or IsNull(ls_da) ) and ( DaysAfter(ld_da,ld_ad) > 0 ) ) then
			li_msg = MessageBox("Errore", "Date DA/A INVERTITE",  &
				Exclamation!, OKCancel!, 2)
			if li_msg = 1 then
	 			ls_adda = ls_da
				ls_da = ls_ad
				ls_ad = ls_adda
			else
				return -1
			end if
		end if
	case "Num", "num"
		ll_ad = tab_1.tabpage_select.dw_selection.GetItemNumber(1, 2, Primary!, TRUE)
		ls_ad = String(ll_ad)
		if ( not ( IsNull(ls_ad) or IsNull(ls_da) ) and ( ll_da > ll_ad ) ) then
			li_msg = MessageBox("Errore", "Valori Numerici DA/A INVERTITI",  &
				Exclamation!, OKCancel!, 2)
			if li_msg = 1 then
	 			ls_adda = ls_da
				ls_da = ls_ad
				ls_ad = ls_adda
			else
				return -1
			end if
		end if
		
	case "Cha", "cha"
		ls_ad = tab_1.tabpage_select.dw_selection.GetItemString(1, 2, Primary!, TRUE)
		if ( not( IsNull(ls_ad) or IsNull(ls_ad) ) and ( ls_da > ls_ad ) ) then
			li_msg = MessageBox("Errore", "Stringhe DA/A INVERTITE",  &
				Exclamation!, OKCancel!, 2)
			if li_msg = 1 then
	 			ls_adda = ls_da
				ls_da = ls_ad
				ls_ad = ls_adda
			else
				return -1
			end if
		end if
	case else
		return -1
		
end choose

ls_da_rpt = " " + "{" + istr_coddes_rpt.nome_campo_db_cod + "}" + " "
ls_ad_rpt = " " + "{" + istr_coddes_rpt.nome_campo_db_cod + "}" + " "

if not (IsNull(ls_statement) or (ls_statement = "")) then
	ls_statement = ls_statement + " AND "
end if

if not IsNull(ls_da) then
	ls_statement	= ls_statement + ls_da_rpt + " >= '" + ls_da + "' AND "
	ls_statform		= "'Da " + istr_coddes_rpt.nome_campo_instampa + " " + ls_da + ", "
else
	ls_statement = ls_statement + ls_da_rpt + " <> '' AND "
	ls_statform = "'Da " + istr_coddes_rpt.nome_campo_instampa + " - non definito, "
end if

if not IsNull(ls_ad) then
	ls_statement = ls_statement + ls_ad_rpt + " <= '" + ls_ad + "'"
	ls_statform  = ls_statform + "a " + istr_coddes_rpt.nome_campo_instampa + " " + ls_ad + "."
else
   ls_statement = ls_statement + ls_ad_rpt + " <> '' "
	ls_statform  = ls_statform + "a " + istr_coddes_rpt.nome_campo_instampa + " - non definito."
end if

if istr_coddes_rpt.use_completa_semplificata	= False then
	ls_completa = "C"
else	
	ls_completa = ldw_dw.GetItemString(1,"cbx_completa_semplificata")
	
	
	
end if	

ii_sort_field_direction = ldw_dw.GetItemNumber(1,"tipo")

if IsNull(ii_sort_field_direction) then
	ii_sort_field_direction = 1
end if

ii_sort_field_n = 0

ls_sort = ldw_dw.GetItemString(1,"sort")
if ls_sort = "C" Or IsNull(ls_sort) then
	is_sort_field_name = "{" + istr_coddes_rpt.nome_campo_db_cod + "}"
	ls_statform = ls_statform + "Ordinamento per codice.'"
else
	is_sort_field_name = "{" + istr_coddes_rpt.nome_campo_db_des + "}"
	ls_statform = ls_statform + "Ordinamento per descrizione. '"
end if


if istr_coddes_rpt.use_completa_semplificata	= False then

	if (ls_group = "R") then
		is_selection 	= ls_statement
	else
		is_group 		= ls_statement
	end if	

	ll_idx = UpperBound( istr_formule )
	istr_formule[ll_idx+1].formula_name 	= "selezione"
	istr_formule[ll_idx+1].formula_string 	= ls_statform
	
else
	ll_idx = UpperBound( istr_formule )
	istr_formule[ll_idx+1].formula_name		= "lorc"
	istr_formule[ll_idx+1].formula_string	= "'" + ls_completa + "'"
end if
							
return 0

end event

event ue_pre_open;call super::ue_pre_open;
datawindow			ldw_dw

ldw_dw = 			Tab_1.Tabpage_select.dw_selection

if istr_coddes_rpt.tipo_serve 	= True then	
	ldw_dw.Object.tipo.Visible 	= True
	ldw_dw.Object.tipo_t.Visible  = True	
else	
	ldw_dw.Object.tipo.Visible 	= False
	ldw_dw.Object.tipo_t.Visible  = False	
end if

if istr_coddes_rpt.use_completa_semplificata	= True then	
	ldw_dw.Object.cbx_completa_semplificata.Visible = True
	
	ldw_dw.Object.sort.tabsequence		= 0
	ldw_dw.Object.da_cod.tabsequence		= 0
	ldw_dw.Object.a_cod.tabsequence		= 0
else	
	ldw_dw.Object.cbx_completa_semplificata.Visible = False
end if

if istr_coddes_rpt.no_param 		 		= True then	
	ldw_dw.Object.codici_t.Visible 		= False
	ldw_dw.Object.ordinamento_t.Visible = False
	ldw_dw.Object.da_cod_t.Visible 		= False
	ldw_dw.Object.da_cod.Visible 			= False
	ldw_dw.Object.a_cod_t.Visible 		= False
	ldw_dw.Object.a_cod.Visible 			= False
	ldw_dw.Object.sort_t.Visible 			= False
	ldw_dw.Object.sort.Visible 			= False
	ldw_dw.Object.noparam_t.Visible 		= True	
end if

this.Title = istr_coddes_rpt.titolo_finestra


if not isNull(istr_coddes_rpt.nome_dddw_sl) then
	ldw_dw.Object.da_cod.dddw.Name 		    =  istr_coddes_rpt.nome_dddw_sl
	ldw_dw.Object.a_cod.dddw.Name  		    =  istr_coddes_rpt.nome_dddw_sl
end if	

if not isNull(istr_coddes_rpt.nome_dddw_codice) then
	ldw_dw.Object.da_cod.dddw.DataColumn    =  istr_coddes_rpt.nome_dddw_codice
	ldw_dw.Object.a_cod.dddw.DataColumn     =  istr_coddes_rpt.nome_dddw_codice
end if

if not isNull(istr_coddes_rpt.nome_dddw_codice) then
	ldw_dw.Object.da_cod.dddw.DisplayColumn =  istr_coddes_rpt.nome_dddw_codice
	ldw_dw.Object.a_cod.dddw.DisplayColumn  =  istr_coddes_rpt.nome_dddw_codice
end if	


if not isNull(istr_coddes_rpt.nome_campo_db_cod) then
	if istr_coddes_rpt.nome_campo_db_cod <> "" and istr_coddes_rpt.use_completa_semplificata	= False then
		is_drop_column[1] = "da_cod"
		is_drop_column[2] = "a_cod"
	end if	
end if	

end event

event ue_post_open;call super::ue_post_open;if istr_coddes_rpt.use_completa_semplificata	= True then	
	Tab_1.Tabpage_select.dw_selection.SetItem(1,"sort","D")
	Tab_1.Tabpage_select.dw_selection.SetItem(1,"tf","S")
end if	
return 0
end event

type tab_1 from w_print_main`tab_1 within w_default_coddes2_rpt
int Y=184
int Width=1856
int Height=668
end type

type tabpage_select from w_print_main`tabpage_select within tab_1
int X=18
int Y=112
int Width=1819
int Height=540
end type

type dw_selection from w_print_main`dw_selection within tabpage_select
int Width=1746
int Height=444
string DataObject="d_default_coddes2_rpt"
end type

type tabpage_stampante from w_print_main`tabpage_stampante within tab_1
int X=18
int Y=112
int Width=1819
int Height=540
end type

type ddlb_stampanti from w_print_main`ddlb_stampanti within tabpage_stampante
int Height=440
end type

type tabpage_export from w_print_main`tabpage_export within tab_1
int X=18
int Y=112
int Width=1819
int Height=540
end type

