forward
global type w_testa_righe_cx from w_001
end type
type dw_1 from udw_base within w_testa_righe_cx
end type
type dw_2 from udw_figlia within w_testa_righe_cx
end type
type cb_inserisci from commandbutton within w_testa_righe_cx
end type
type cb_salva from commandbutton within w_testa_righe_cx
end type
type cb_cancella from commandbutton within w_testa_righe_cx
end type
type cb_annulla from commandbutton within w_testa_righe_cx
end type
type cb_ok from commandbutton within w_testa_righe_cx
end type
end forward

global type w_testa_righe_cx from w_001
integer x = 786
integer y = 424
integer width = 1728
integer height = 1048
dw_1 dw_1
dw_2 dw_2
cb_inserisci cb_inserisci
cb_salva cb_salva
cb_cancella cb_cancella
cb_annulla cb_annulla
cb_ok cb_ok
end type
global w_testa_righe_cx w_testa_righe_cx

type variables
integer i_dw_corrente 
end variables

forward prototypes
public function integer wf_salva_dw (ref udw_base adw_1, ref udw_figlia adw_2, integer as_flag)
end prototypes

public function integer wf_salva_dw (ref udw_base adw_1, ref udw_figlia adw_2, integer as_flag);
integer li_ret

li_ret=adw_1.triggerevent("ue_update")

if as_flag=2 and li_ret=1 then	
	li_ret=adw_2.triggerevent("ue_update")
end if
return li_ret
	
	
end function

on w_testa_righe_cx.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_2=create dw_2
this.cb_inserisci=create cb_inserisci
this.cb_salva=create cb_salva
this.cb_cancella=create cb_cancella
this.cb_annulla=create cb_annulla
this.cb_ok=create cb_ok
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.cb_inserisci
this.Control[iCurrent+4]=this.cb_salva
this.Control[iCurrent+5]=this.cb_cancella
this.Control[iCurrent+6]=this.cb_annulla
this.Control[iCurrent+7]=this.cb_ok
end on

on w_testa_righe_cx.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.cb_inserisci)
destroy(this.cb_salva)
destroy(this.cb_cancella)
destroy(this.cb_annulla)
destroy(this.cb_ok)
end on

event open;call super::open;long ll_id
dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)

if dw_1.retrieve()>0 then
	ll_id=dw_1.getitemnumber(1,1)
	dw_2.retrieve(ll_id)
end if
	
end event

type st_1 from w_001`st_1 within w_testa_righe_cx
end type

type dw_1 from udw_base within w_testa_righe_cx
integer x = 46
integer y = 28
integer width = 1627
boolean bringtotop = true
end type

event rowfocuschanged;long ll_id
integer li_test  

if currentrow>0 then
	
	ll_id=getitemnumber(currentrow, 1)
	
	if ll_id>0 then
		
		if dw_2.trigger event ue_update()=1 then
			dw_2.retrieve(ll_id)
		else
			messagebox("Attenzione!", "Salvataggio non riuscito!")
		end if
		
	else
		dw_2.reset()
	end if
end if
setrowfocusindicator(hand!)
end event

event getfocus;call super::getfocus;i_dw_corrente=1
end event

event ue_key;choose case key
	
	case Keyadd!
		if (keyFlags=2) then
			cb_inserisci.triggerevent(clicked!)
		end if

	case KeySubtract!
		if (keyFlags=2) then
			cb_cancella.triggerevent(clicked!)
		end if			
     case KeyS!
		if (keyFlags=2) then
			cb_salva.triggerevent(clicked!)		
		end if
end choose
end event

type dw_2 from udw_figlia within w_testa_righe_cx
integer x = 46
integer y = 464
integer width = 1627
integer taborder = 20
boolean bringtotop = true
end type

event getfocus;call super::getfocus;i_dw_corrente=2
end event

event rowfocuschanged;setrowfocusindicator(hand!)
end event

event ue_key;choose case key
	
	case Keyadd!
		if (keyFlags=2) then
			cb_inserisci.triggerevent(clicked!)
		end if

	case KeySubtract!
		if (keyFlags=2) then
			cb_cancella.triggerevent(clicked!)
		end if			
     case KeyS!
		if (keyFlags=2) then
			cb_salva.triggerevent(clicked!)		
		end if
	case KeyF12!
		cb_salva.triggerevent(clicked!)		
	
end choose
end event

type cb_inserisci from commandbutton within w_testa_righe_cx
integer x = 64
integer y = 848
integer width = 261
integer height = 96
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Inserisci"
end type

event clicked;long ll_riga, ll_id
if i_dw_corrente=1 then
	ll_riga=dw_1.trigger event ue_insert(0)
elseif i_dw_corrente=2 then
	ll_riga=dw_1.getrow()
	if ll_riga>0 then
		ll_id=dw_1.getitemnumber(ll_riga, 1)
		if isnull(ll_id)  then
			if wf_salva_dw(dw_1,dw_2, 1)=1 then
				this.triggerevent(clicked!)
			end if
		else
			ll_riga=dw_2.trigger event ue_insert(0)
			dw_2.setitem(ll_riga, 1, ll_id)
		end if
	end if
end if
end event

type cb_salva from commandbutton within w_testa_righe_cx
integer x = 352
integer y = 848
integer width = 261
integer height = 96
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salva"
end type

event clicked;if i_dw_corrente=1 then
	wf_salva_dw(dw_1, dw_2, 1)
elseif  i_dw_corrente=2 then
	wf_salva_dw(dw_1, dw_2, 2)
end if
end event

type cb_cancella from commandbutton within w_testa_righe_cx
integer x = 640
integer y = 848
integer width = 261
integer height = 96
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancella"
end type

event clicked;long ll_riga_da_cancellare
if i_dw_corrente=1 then
	ll_riga_da_cancellare=dw_1.getrow()
	if ll_riga_da_cancellare>0 then
	 	dw_1.trigger event ue_delete(ll_riga_da_cancellare)
		
		
		dw_2.reset()
	end if
elseif  i_dw_corrente=2 then
	ll_riga_da_cancellare=dw_2.getrow()
	if ll_riga_da_cancellare>0 then
		dw_2.trigger event ue_delete(ll_riga_da_cancellare)
	end if
end if
end event

type cb_annulla from commandbutton within w_testa_righe_cx
integer x = 1125
integer y = 848
integer width = 261
integer height = 96
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Annulla"
boolean cancel = true
end type

event clicked;close(parent)
end event

type cb_ok from commandbutton within w_testa_righe_cx
integer x = 1417
integer y = 848
integer width = 261
integer height = 96
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ok"
boolean default = true
end type

event clicked;if messagebox("Salvare?", "Salvare i dati prima di chiudere?", stopsign!, yesno!)=1 then
	wf_salva_dw(dw_1, dw_2, 2)
end if
close(parent)
end event

