forward
global type w_trova_acc_doppi from w_semplice_cx
end type
type dw_2 from udw_001 within w_trova_acc_doppi
end type
type cb_trova_doppi from commandbutton within w_trova_acc_doppi
end type
end forward

global type w_trova_acc_doppi from w_semplice_cx
integer width = 4530
integer height = 1392
boolean maxbox = true
boolean resizable = true
dw_2 dw_2
cb_trova_doppi cb_trova_doppi
end type
global w_trova_acc_doppi w_trova_acc_doppi

on w_trova_acc_doppi.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.cb_trova_doppi=create cb_trova_doppi
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.cb_trova_doppi
end on

on w_trova_acc_doppi.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.cb_trova_doppi)
end on

event open;call super::open;dw_2.settransobject(sqlca)
dw_2.retrieve()
end event

type cb_stampa from w_semplice_cx`cb_stampa within w_trova_acc_doppi
end type

type cb_ricerca from w_semplice_cx`cb_ricerca within w_trova_acc_doppi
integer weight = 700
string text = "DOPPI"
end type

event cb_ricerca::clicked;long i
string ls_art, ls_acc, ls_art_old, ls_acc_old
for i=1 to dw_2.rowcount()
	if i>1 then
		ls_art_old=dw_2.getitemstring(i -1, "articolo")
		ls_acc_old=dw_2.getitemstring(i -1, "accessorio")
		ls_art=dw_2.getitemstring(i, "articolo")
		ls_acc=dw_2.getitemstring(i, "accessorio")
		if ls_art=ls_art_old and upper(ls_acc)<>upper(ls_acc_old) then
			dw_2.rowscopy(i -1, i, primary!, dw_1, 1, primary!)
		end if
	end if
	
next
//dw_1.setsort("codice, BOLLETTine_excel_data")
dw_1.sort()
end event

type cb_primo from w_semplice_cx`cb_primo within w_trova_acc_doppi
end type

type cb_ultimo from w_semplice_cx`cb_ultimo within w_trova_acc_doppi
end type

type cb_indietro from w_semplice_cx`cb_indietro within w_trova_acc_doppi
end type

type cb_avanti from w_semplice_cx`cb_avanti within w_trova_acc_doppi
end type

type dw_1 from w_semplice_cx`dw_1 within w_trova_acc_doppi
integer x = 23
integer width = 4398
string dataobject = "d_bol_xls_doppio_accessorio"
boolean vscrollbar = true
end type

type cb_inserisci from w_semplice_cx`cb_inserisci within w_trova_acc_doppi
end type

type cb_salva from w_semplice_cx`cb_salva within w_trova_acc_doppi
string text = "Salva xls"
end type

event cb_salva::clicked;dw_1.saveas()
end event

type cb_cancella from w_semplice_cx`cb_cancella within w_trova_acc_doppi
end type

type cb_annulla from w_semplice_cx`cb_annulla within w_trova_acc_doppi
end type

type cb_ok from w_semplice_cx`cb_ok within w_trova_acc_doppi
end type

type dw_2 from udw_001 within w_trova_acc_doppi
boolean visible = false
integer x = 3479
integer y = 972
integer width = 1056
integer height = 916
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_bol_xls_doppio_acc2"
boolean vscrollbar = true
end type

type cb_trova_doppi from commandbutton within w_trova_acc_doppi
boolean visible = false
integer x = 2894
integer y = 1060
integer width = 402
integer height = 112
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Trova Doppi"
end type

event clicked;long i
string ls_art, ls_acc, ls_art_old, ls_acc_old
for i=1 to dw_2.rowcount()
	if i>1 then
		ls_art_old=dw_2.getitemstring(i -1, "articolo")
		ls_acc_old=dw_2.getitemstring(i -1, "accessorio")
		ls_art=dw_2.getitemstring(i, "articolo")
		ls_acc=dw_2.getitemstring(i, "accessorio")
		if ls_art=ls_art_old and ls_acc<>ls_acc_old then
			dw_2.rowscopy(i -1, i, primary!, dw_1, 1, primary!)
		end if
	end if
	
	
	
next
end event

