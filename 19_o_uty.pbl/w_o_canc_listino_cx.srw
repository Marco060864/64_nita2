forward
global type w_o_canc_listino_cx from w_data_main
end type
type dw_1 from u_dw_main within w_o_canc_listino_cx
end type
type dw_2 from u_dw_main within w_o_canc_listino_cx
end type
type dw_3 from u_dw_main within w_o_canc_listino_cx
end type
type cb_esci from commandbutton within w_o_canc_listino_cx
end type
type cb_cancella from commandbutton within w_o_canc_listino_cx
end type
type cb_salva from commandbutton within w_o_canc_listino_cx
end type
type dw_4 from u_dw_main within w_o_canc_listino_cx
end type
type st_1 from statictext within w_o_canc_listino_cx
end type
type st_2 from statictext within w_o_canc_listino_cx
end type
end forward

global type w_o_canc_listino_cx from w_data_main
integer width = 2414
integer height = 1960
string title = "Utilità cancellazione listini (variazioni e prezzi)"
dw_1 dw_1
dw_2 dw_2
dw_3 dw_3
cb_esci cb_esci
cb_cancella cb_cancella
cb_salva cb_salva
dw_4 dw_4
st_1 st_1
st_2 st_2
end type
global w_o_canc_listino_cx w_o_canc_listino_cx

type variables
u_dw_main idw_current
end variables

event open;call super::open;dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
dw_3.settransobject(sqlca)

dw_1.retrieve()
end event

on w_o_canc_listino_cx.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_2=create dw_2
this.dw_3=create dw_3
this.cb_esci=create cb_esci
this.cb_cancella=create cb_cancella
this.cb_salva=create cb_salva
this.dw_4=create dw_4
this.st_1=create st_1
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.dw_3
this.Control[iCurrent+4]=this.cb_esci
this.Control[iCurrent+5]=this.cb_cancella
this.Control[iCurrent+6]=this.cb_salva
this.Control[iCurrent+7]=this.dw_4
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.st_2
end on

on w_o_canc_listino_cx.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.cb_esci)
destroy(this.cb_cancella)
destroy(this.cb_salva)
destroy(this.dw_4)
destroy(this.st_1)
destroy(this.st_2)
end on

type p_msg_log from w_data_main`p_msg_log within w_o_canc_listino_cx
end type

type p_crescente from w_data_main`p_crescente within w_o_canc_listino_cx
end type

type p_decrescente from w_data_main`p_decrescente within w_o_canc_listino_cx
end type

type dw_1 from u_dw_main within w_o_canc_listino_cx
integer x = 59
integer y = 516
integer width = 1243
integer taborder = 10
boolean bringtotop = true
boolean titlebar = true
string title = "Listini"
string dataobject = "d_o_listino_gd"
boolean vscrollbar = true
end type

event rowfocuschanged;call super::rowfocuschanged;long ll_id_listino

if getrow()>0 then
	ll_id_listino=getitemnumber(currentrow, "id_listino")
	if ll_id_listino>0 then
	
		dw_2.retrieve(ll_id_listino)
		dw_2.trigger event rowfocuschanged(dw_2.getrow())
	end if
end if
end event

event getfocus;call super::getfocus;idw_current = THIS
end event

type dw_2 from u_dw_main within w_o_canc_listino_cx
integer x = 1330
integer y = 520
integer width = 997
integer taborder = 10
boolean bringtotop = true
boolean titlebar = true
string title = "Variazioni (Validità listino)"
string dataobject = "d_o_variazione_gd"
end type

event rowfocuschanged;call super::rowfocuschanged;long ll_id_variazione

if getrow()>0 then
	ll_id_variazione=getitemnumber(currentrow, "id_variazione")
	
	if ll_id_variazione>0 then
		dw_3.retrieve(ll_id_variazione)
		dw_4.retrieve(ll_id_variazione)
	end if
else
	dw_3.reset()
end if
end event

event getfocus;call super::getfocus;idw_current = THIS

end event

type dw_3 from u_dw_main within w_o_canc_listino_cx
integer x = 59
integer y = 1288
integer width = 2258
integer height = 516
integer taborder = 20
boolean bringtotop = true
boolean titlebar = true
string title = "Prezzi"
string dataobject = "d_o_prezzo_gd"
boolean vscrollbar = true
end type

event getfocus;call super::getfocus;idw_current = THIS
end event

type cb_esci from commandbutton within w_o_canc_listino_cx
integer x = 82
integer y = 36
integer width = 343
integer height = 100
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "ESCI"
end type

event clicked;close(parent)
end event

type cb_cancella from commandbutton within w_o_canc_listino_cx
integer x = 1545
integer y = 36
integer width = 343
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancella"
end type

event clicked;long ll_id_var, ll_null, i

 setnull(ll_null)
sqlca.triggers_on_off('off')
if idw_current = dw_1 then
	
	dw_3.RowsMove(1, dw_3.rowCount(),Primary!, dw_3, 1, Delete!)
	if dw_2.getrow()>0 then
		ll_id_var=	dw_2.getitemnumber(dw_2.getrow(), "id_variazione")
		for i= 1 to dw_4.rowcount()
			dw_4.setitem(i, "id_variazione", ll_null)
		next
		
		dw_2.deleterow(dw_2.getrow())
		
	end if
	dw_1.deleterow(dw_1.getrow())
elseif idw_current= dw_2 then
	if dw_2.getrow()>0 then
		dw_3.RowsMove(1, dw_3.rowCount(),Primary!, dw_3, 1, Delete!)
		ll_id_var=	dw_2.getitemnumber(dw_2.getrow(), "id_variazione")
		for i= 1 to dw_4.rowcount()
			dw_4.setitem(i, "id_variazione", ll_null)
		next
		dw_2.deleterow(dw_2.getrow())
	end if
else
	dw_3.deleterow(dw_3.getrow())
end if
sqlca.triggers_on_off('on')

end event

type cb_salva from commandbutton within w_o_canc_listino_cx
integer x = 1984
integer y = 36
integer width = 343
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salva"
end type

event clicked;long ll_id_listino

if dw_3.update()=1 then
	if dw_4.update()=1 then
		if dw_2.update()=1 then
			if dw_1.update()=1 then
				commit;
				messagebox("OK", "Tutto Bene!")
			else
				rollback;
				messagebox("Errore!", "Chiudi la finestra e prova ancora!")
			end if
		end if
	end if
end if
if dw_1.getrow()>0 then
	ll_id_listino=dw_1.getitemnumber(dw_1.getrow(), "id_listino")
	if ll_id_listino>0 then
		dw_2.retrieve(ll_id_listino)
	end if
end if
end event

type dw_4 from u_dw_main within w_o_canc_listino_cx
boolean visible = false
integer x = 1851
integer y = 1544
integer width = 229
integer height = 152
integer taborder = 12
boolean bringtotop = true
string dataobject = "d_o_doc_variazione_gd"
end type

type st_1 from statictext within w_o_canc_listino_cx
integer x = 73
integer y = 152
integer width = 2254
integer height = 172
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Selezionare il listino che si vuol cancellare, premere il pulsante cancella e poi il pulsante salva: se tutto è andato bene riceverete un messaggio di conferma; se tale messaggio non dovesse apparire chiudere la finestra e riprovare."
boolean focusrectangle = false
end type

type st_2 from statictext within w_o_canc_listino_cx
integer x = 69
integer y = 332
integer width = 2249
integer height = 164
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Se si vuol cancellare soltanto una variazione occorre selezionare la variazione nell~'apposita finestra e quindi premere ~'cancella~' e poi ~'salva~'. Il messaggio ~'Tutto bene~' conferma la bontà dell~'operazione.      Per cancellare solo un prezzo occorre selezionare il prezzo e quindi procedere come sopra."
boolean focusrectangle = false
end type

