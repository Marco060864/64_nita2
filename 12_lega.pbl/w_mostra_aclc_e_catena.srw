forward
global type w_mostra_aclc_e_catena from w_stampa
end type
type cb_1 from commandbutton within w_mostra_aclc_e_catena
end type
type cb_2 from commandbutton within w_mostra_aclc_e_catena
end type
end forward

global type w_mostra_aclc_e_catena from w_stampa
integer width = 5047
cb_1 cb_1
cb_2 cb_2
end type
global w_mostra_aclc_e_catena w_mostra_aclc_e_catena

on w_mostra_aclc_e_catena.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_2
end on

on w_mostra_aclc_e_catena.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_2)
end on

event open;call super::open;
dw_1.settransobject(sqlca)
dw_1.retrieve()
end event

type pb_1 from w_stampa`pb_1 within w_mostra_aclc_e_catena
end type

type cb_preview from w_stampa`cb_preview within w_mostra_aclc_e_catena
end type

type dw_1 from w_stampa`dw_1 within w_mostra_aclc_e_catena
integer width = 4873
string dataobject = "d_mostra_aclc_e_catena"
end type

type pb_salva_su_file from w_stampa`pb_salva_su_file within w_mostra_aclc_e_catena
end type

type pb_stampa from w_stampa`pb_stampa within w_mostra_aclc_e_catena
end type

type sle_pg from w_stampa`sle_pg within w_mostra_aclc_e_catena
end type

type st_1 from w_stampa`st_1 within w_mostra_aclc_e_catena
end type

type st_2 from w_stampa`st_2 within w_mostra_aclc_e_catena
end type

type sle_copie from w_stampa`sle_copie within w_mostra_aclc_e_catena
end type

type sle_zoom from w_stampa`sle_zoom within w_mostra_aclc_e_catena
end type

type cb_7 from w_stampa`cb_7 within w_mostra_aclc_e_catena
end type

type cb_6 from w_stampa`cb_6 within w_mostra_aclc_e_catena
end type

type cb_pg_dopo from w_stampa`cb_pg_dopo within w_mostra_aclc_e_catena
end type

type cb_pg_prima from w_stampa`cb_pg_prima within w_mostra_aclc_e_catena
end type

type cb_esci from w_stampa`cb_esci within w_mostra_aclc_e_catena
end type

type cb_1 from commandbutton within w_mostra_aclc_e_catena
integer x = 3529
integer y = 32
integer width = 256
integer height = 92
integer taborder = 18
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "SALVA"
end type

event clicked;
dw_1.accepttext()
if dw_1.update()=1 then
	commit;
else
	rollback;
	messagebox("Attenzione!", "Salvataggio NON riuscito!")
end if
end event

type cb_2 from commandbutton within w_mostra_aclc_e_catena
integer x = 3867
integer y = 32
integer width = 256
integer height = 92
integer taborder = 18
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Cancella"
end type

event clicked;long ll_riga

ll_riga=dw_1.getrow()

dw_1.deleterow(ll_riga)
end event

