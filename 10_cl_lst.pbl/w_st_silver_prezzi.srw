forward
global type w_st_silver_prezzi from w_stampa
end type
type cbx_1 from checkbox within w_st_silver_prezzi
end type
end forward

global type w_st_silver_prezzi from w_stampa
integer width = 5152
integer height = 1848
cbx_1 cbx_1
end type
global w_st_silver_prezzi w_st_silver_prezzi

on w_st_silver_prezzi.create
int iCurrent
call super::create
this.cbx_1=create cbx_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_1
end on

on w_st_silver_prezzi.destroy
call super::destroy
destroy(this.cbx_1)
end on

event open;call super::open;udw_base udw_dw_2
dw_1.settransobject(sqlca)

udw_dw_2=message.powerobjectparm

udw_dw_2.rowscopy(1,   udw_dw_2.RowCount(), Primary!, dw_1, 1, Primary!)
end event

type pb_1 from w_stampa`pb_1 within w_st_silver_prezzi
end type

type cb_preview from w_stampa`cb_preview within w_st_silver_prezzi
end type

type dw_1 from w_stampa`dw_1 within w_st_silver_prezzi
integer width = 5006
integer height = 1484
string dataobject = "d_silver_prezzi_stampa"
end type

type pb_salva_su_file from w_stampa`pb_salva_su_file within w_st_silver_prezzi
end type

type pb_stampa from w_stampa`pb_stampa within w_st_silver_prezzi
end type

type sle_pg from w_stampa`sle_pg within w_st_silver_prezzi
end type

type st_1 from w_stampa`st_1 within w_st_silver_prezzi
end type

type st_2 from w_stampa`st_2 within w_st_silver_prezzi
end type

type sle_copie from w_stampa`sle_copie within w_st_silver_prezzi
end type

type sle_zoom from w_stampa`sle_zoom within w_st_silver_prezzi
end type

type cb_7 from w_stampa`cb_7 within w_st_silver_prezzi
end type

type cb_6 from w_stampa`cb_6 within w_st_silver_prezzi
end type

type cb_pg_dopo from w_stampa`cb_pg_dopo within w_st_silver_prezzi
end type

type cb_pg_prima from w_stampa`cb_pg_prima within w_st_silver_prezzi
end type

type cb_esci from w_stampa`cb_esci within w_st_silver_prezzi
integer x = 3447
end type

type cbx_1 from checkbox within w_st_silver_prezzi
integer x = 2761
integer y = 56
integer width = 489
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Rendi DES invisibili"
end type

event clicked;if checked then
	dw_1.modify("prezzo_des_1.visible=0")
	dw_1.modify("prezzo_des_2.visible=0")
	dw_1.modify("prezzo_des_3.visible=0")
else
	dw_1.modify("prezzo_des_1.visible=1")
	dw_1.modify("prezzo_des_2.visible=1")
	dw_1.modify("prezzo_des_3.visible=1")
	
end if
end event

