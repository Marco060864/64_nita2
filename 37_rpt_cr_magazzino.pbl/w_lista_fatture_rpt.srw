forward
global type w_lista_fatture_rpt from w_print_main
end type
type st_7 from statictext within tabpage_select
end type
type st_7 from statictext within tabpage_select
end type
end forward

global type w_lista_fatture_rpt from w_print_main
int Width=1833
int Height=1040
boolean TitleBar=true
string Title="Lista fatture emesse non contabilizzate"
end type
global w_lista_fatture_rpt w_lista_fatture_rpt

on w_lista_fatture_rpt.create
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
end on

on w_lista_fatture_rpt.destroy
call super::destroy
end on

event ue_pre_print;call super::ue_pre_print;
istr_formule[1].formula_name 		= "id_valuta"
istr_formule[1].formula_string 	= string(tab_1.tabpage_select.dw_selection.getitemnumber(1, "id_valuta"))

return 0
end event

type cb_esci from w_print_main`cb_esci within w_lista_fatture_rpt
int X=1573
end type

type tab_1 from w_print_main`tab_1 within w_lista_fatture_rpt
int X=37
int Y=192
int Width=1765
int Height=748
end type

type tabpage_select from w_print_main`tabpage_select within tab_1
int X=18
int Y=112
int Width=1728
int Height=620
st_7 st_7
end type

on tabpage_select.create
this.st_7=create st_7
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_7
end on

on tabpage_select.destroy
call super::destroy
destroy(this.st_7)
end on

type dw_selection from w_print_main`dw_selection within tabpage_select
int X=133
int Y=184
int Width=1440
int Height=172
string DataObject="d_lista_fatture_rpt"
end type

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
int Width=1728
int Height=620
end type

type tabpage_export from w_print_main`tabpage_export within tab_1
int X=18
int Y=112
int Width=1728
int Height=620
end type

type rb_export from w_print_main`rb_export within w_lista_fatture_rpt
int Y=76
end type

type cb_stampa from w_print_main`cb_stampa within w_lista_fatture_rpt
int X=1243
end type

type st_7 from statictext within tabpage_select
int X=27
int Y=80
int Width=1650
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="STAMPA LISTA FATTURE EMESSE NON CONTABILIZZATE"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

