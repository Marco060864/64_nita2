forward
global type w_completa_o_semplificata_rpt from w_default_coddes_rpt
end type
end forward

global type w_completa_o_semplificata_rpt from w_default_coddes_rpt
int Width=1884
end type
global w_completa_o_semplificata_rpt w_completa_o_semplificata_rpt

on w_completa_o_semplificata_rpt.create
call w_default_coddes_rpt::create
end on

on w_completa_o_semplificata_rpt.destroy
call w_default_coddes_rpt::destroy
end on

event ue_pre_print;call super::ue_pre_print;long 				ll_RetCode, ll_Row, ll_idx
string			ls_formula, ls_completa
datawindow		dw_current

ll_RetCode 		= 0
dw_current 		= tab_1.tabpage_select.dw_selection
ll_row 			= dw_current.GetRow()

dw_current.SetItem(ll_Row,"sort","D")

ls_completa = dw_current.GetItemString(ll_Row, "completa")

ls_formula = "'" + ls_completa  + "';"

ii_sort_field_n 			= 0
ii_sort_field_direction = dw_current.GetItemNumber(ll_Row, "tipo") 
is_sort_field_name 		= "{" + istr_coddes_rpt.nome_campo_db_des + "}"

is_nome_report = istr_coddes_rpt.nome_report
istr_formule[1].formula_name		= "lorc"
istr_formule[1].formula_string	= ls_formula
return 0


end event

type tab_1 from w_default_coddes_rpt`tab_1 within w_completa_o_semplificata_rpt
int Width=1783
int Height=881
end type

type tabpage_select from w_default_coddes_rpt`tabpage_select within tab_1
int X=19
int Y=113
int Width=1747
int Height=753
end type

type dw_selection from w_default_coddes_rpt`dw_selection within tabpage_select
string DataObject="d_completa_o_semplificata_rpt"
end type

type tabpage_stampante from w_default_coddes_rpt`tabpage_stampante within tab_1
int X=19
int Y=113
int Width=1747
int Height=753
end type

type tabpage_export from w_default_coddes_rpt`tabpage_export within tab_1
int X=19
int Y=113
int Width=1747
int Height=753
end type

