forward
global type w_valuta_rpt from w_print_main
end type
end forward

global type w_valuta_rpt from w_print_main
boolean TitleBar=true
string Title="Stampa Valuta con Cambio"
end type
global w_valuta_rpt w_valuta_rpt

on w_valuta_rpt.create
call w_print_main::create
end on

on w_valuta_rpt.destroy
call w_print_main::destroy
end on

event ue_pre_print;call super::ue_pre_print;
long 				ll_Row
string			ls_cambio,ls_report,ls_ord
datawindow		dw_current

dw_current		= tab_1.tabpage_select.dw_selection
ll_row			= dw_current.GetRow()
ls_cambio		= dw_current.GetItemString(ll_Row, "cambio")
ls_report		= dw_current.GetItemString(ll_Row, "da_area")
ls_ord			= dw_current.GetItemString(ll_Row, "ad_area")

choose case  ls_report
	case "sim", "Sim"
		is_nome_report = "valuta_sim.rpt"
	case "des", "Des"
		is_nome_report = "valuta_des.rpt"
	case "cod", "Cod"
		is_nome_report = "valuta.rpt"
	case else
		is_nome_report = "valuta.rpt"
end choose

choose case  ls_ord
	case "asc", "Asc"
//		ii_sort_field_direction = u_freddie.iuo_stampa.pe_sf_ascending
	case "dis", "Dis"
//		ii_sort_field_direction = u_freddie.iuo_stampa.pe_sf_descending
end choose

is_sort_field_name = "{Storico_Cambio.Data}"
ii_sort_field_n = 0

istr_formule[1].formula_name		= "cambiosino"
istr_formule[1].formula_string	= "'" + ls_cambio  + "'"
return 0


end event

type cb_esci from w_print_main`cb_esci within w_valuta_rpt
int X=1441
int Y=61
end type

type tabpage_select from w_print_main`tabpage_select within tab_1
int X=19
int Y=113
int Width=1765
int Height=757
end type

type dw_selection from w_print_main`dw_selection within tabpage_select
int X=28
int Y=29
int Width=1715
int Height=701
string DataObject="d_valuta_rpt"
end type

event dw_selection::itemchanged;call super::itemchanged;CHOOSE CASE dwo.Name
	CASE "cambio"
		IF data = "S" THEN
			THIS.Object.ad_area.TabSequence = 100
			THIS.Object.ad_area.Background.Mode = 0
		ELSE
			THIS.Object.ad_area.TabSequence = 0
			THIS.Object.ad_area.Background.Mode = 1
		END IF
END CHOOSE

			
		
end event

event dw_selection::rowfocuschanged;call super::rowfocuschanged;this.Object.ad_area.TabSequence = 0
this.Object.ad_area.Background.Mode = 1
end event

type tabpage_stampante from w_print_main`tabpage_stampante within tab_1
int X=19
int Y=113
int Width=1765
int Height=757
end type

type tabpage_export from w_print_main`tabpage_export within tab_1
int X=19
int Y=113
int Width=1765
int Height=757
end type

type cb_stampa from w_print_main`cb_stampa within w_valuta_rpt
int X=1189
int Y=61
end type

