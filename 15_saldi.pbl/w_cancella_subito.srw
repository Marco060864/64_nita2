forward
global type w_cancella_subito from w_001
end type
type dw_1 from udw_base within w_cancella_subito
end type
type cb_1 from commandbutton within w_cancella_subito
end type
end forward

global type w_cancella_subito from w_001
integer width = 3950
integer height = 1632
dw_1 dw_1
cb_1 cb_1
end type
global w_cancella_subito w_cancella_subito

on w_cancella_subito.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_1
end on

on w_cancella_subito.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_1)
end on

event open;call super::open;dw_1.settransobject(sqlca)

dw_1.retrieve()
end event

type st_1 from w_001`st_1 within w_cancella_subito
end type

type dw_1 from udw_base within w_cancella_subito
integer x = 29
integer y = 230
integer width = 3657
integer height = 1050
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_recupera_note_articolo"
end type

type cb_1 from commandbutton within w_cancella_subito
integer x = 263
integer y = 1382
integer width = 322
integer height = 90
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
end type

event clicked;long i, ll_righe, LL_ID_UC
string ls_des_2

ll_righe=dw_1.rowcount()



for i =1 to ll_righe
	LL_ID_UC=DW_1.GETITEMNUMBER(I, "id_unita_confezione")
	ls_des_2=DW_1.GETITEMstring(I, "note")
	update prezzo
	set des_2=:ls_des_2
	where id_unita_confezione=:LL_ID_UC
	and id_variazione=15
	;
	if sqlca.sqlnrows>0 then
		commit;
	else
		rollback;
		messagebox("A", string(LL_ID_UC)+" non aggiornata!")
	end if
next
end event

