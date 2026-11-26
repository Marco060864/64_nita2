forward
global type w_mag_excel_gd from w_semplice_gd
end type
type dw_2 from udw_001 within w_mag_excel_gd
end type
end forward

global type w_mag_excel_gd from w_semplice_gd
integer width = 2597
dw_2 dw_2
end type
global w_mag_excel_gd w_mag_excel_gd

on w_mag_excel_gd.create
int iCurrent
call super::create
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
end on

on w_mag_excel_gd.destroy
call super::destroy
destroy(this.dw_2)
end on

event open;dw_2.settransobject(sqlca)
dw_2.insertrow(1)


dw_1.settransobject(sqlca)

end event

type cb_stampa from w_semplice_gd`cb_stampa within w_mag_excel_gd
end type

type cb_ricerca from w_semplice_gd`cb_ricerca within w_mag_excel_gd
end type

type cb_primo from w_semplice_gd`cb_primo within w_mag_excel_gd
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_mag_excel_gd
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_mag_excel_gd
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_mag_excel_gd
end type

type dw_1 from w_semplice_gd`dw_1 within w_mag_excel_gd
integer y = 120
integer width = 2427
string dataobject = "d_magazzino_excel_gd"
end type

type cb_inserisci from w_semplice_gd`cb_inserisci within w_mag_excel_gd
end type

type cb_salva from w_semplice_gd`cb_salva within w_mag_excel_gd
string text = "EXCEL"
end type

event cb_salva::clicked;dw_1.saveas()
end event

type cb_cancella from w_semplice_gd`cb_cancella within w_mag_excel_gd
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_mag_excel_gd
end type

type cb_ok from w_semplice_gd`cb_ok within w_mag_excel_gd
end type

type dw_2 from udw_001 within w_mag_excel_gd
integer x = 206
integer y = 8
integer width = 777
integer height = 104
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_mag_excel_ricerca"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;
if isnumber(data) then dw_1.retrieve(long(data))
end event

