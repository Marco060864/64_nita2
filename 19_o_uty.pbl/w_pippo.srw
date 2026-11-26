forward
global type w_pippo from w_001
end type
type dw_1 from u_dw_master_main within w_pippo
end type
type dw_2 from u_dw_master_main within w_pippo
end type
type cb_ricerca from commandbutton within w_pippo
end type
type cb_inserisci from commandbutton within w_pippo
end type
type cb_salva from commandbutton within w_pippo
end type
type cb_cancella from commandbutton within w_pippo
end type
type cb_ok from commandbutton within w_pippo
end type
type cb_annulla from commandbutton within w_pippo
end type
end forward

global type w_pippo from w_001
integer width = 3383
integer height = 2576
dw_1 dw_1
dw_2 dw_2
cb_ricerca cb_ricerca
cb_inserisci cb_inserisci
cb_salva cb_salva
cb_cancella cb_cancella
cb_ok cb_ok
cb_annulla cb_annulla
end type
global w_pippo w_pippo

type variables
integer i_dw_corrente
end variables

forward prototypes
public function integer wf_salva_dw (datawindow adw_1, datawindow adw_2, integer as_flag)
end prototypes

public function integer wf_salva_dw (datawindow adw_1, datawindow adw_2, integer as_flag);integer li_ret

li_ret=adw_1.triggerevent("ue_update")

if as_flag=2 and li_ret=1 then	
	li_ret=adw_2.triggerevent("ue_update")
end if
return li_ret
	
end function

on w_pippo.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_2=create dw_2
this.cb_ricerca=create cb_ricerca
this.cb_inserisci=create cb_inserisci
this.cb_salva=create cb_salva
this.cb_cancella=create cb_cancella
this.cb_ok=create cb_ok
this.cb_annulla=create cb_annulla
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.cb_ricerca
this.Control[iCurrent+4]=this.cb_inserisci
this.Control[iCurrent+5]=this.cb_salva
this.Control[iCurrent+6]=this.cb_cancella
this.Control[iCurrent+7]=this.cb_ok
this.Control[iCurrent+8]=this.cb_annulla
end on

on w_pippo.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.cb_ricerca)
destroy(this.cb_inserisci)
destroy(this.cb_salva)
destroy(this.cb_cancella)
destroy(this.cb_ok)
destroy(this.cb_annulla)
end on

type st_1 from w_001`st_1 within w_pippo
end type

type dw_1 from u_dw_master_main within w_pippo
integer x = 27
integer y = 12
integer width = 3296
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_doc_veloce_tb"
end type

event rowfocuschanged;call super::rowfocuschanged;long ll_id
integer li_test  

if currentrow>0 then
	
	ll_id=getitemnumber(currentrow, 1)
	
	if ll_id>0 then
		
		
			dw_2.retrieve(ll_id)
		
	else
		dw_2.reset()
	end if
end if
setrowfocusindicator(hand!)
end event

type dw_2 from u_dw_master_main within w_pippo
integer x = 27
integer y = 916
integer width = 3296
integer height = 1516
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_orafo_riga_documento_ordine_gd"
end type

type cb_ricerca from commandbutton within w_pippo
integer x = 1957
integer y = 796
integer width = 343
integer height = 100
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ricerca"
end type

event clicked;s_ric_param		ls_ric_param
string 	lw_sm, ls_column, ls_colval
long ll_id_documento



lw_sm = "w_documento_sw"
//trigger event ue_set_search (ls_column, ls_colval)
OpenWithParm(w_documento_sw, ls_ric_param)

ls_ric_param= Message.PowerObjectParm
ll_id_documento = long(ls_ric_param.s_id_seg_value[1])
			
		
end event

type cb_inserisci from commandbutton within w_pippo
integer x = 32
integer y = 796
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
string text = "Inserisci"
end type

event clicked;long ll_riga, ll_id
if i_dw_corrente=1 then
	ll_riga=dw_1.insertrow(0)
elseif i_dw_corrente=2 then
	ll_riga=dw_1.getrow()
	if ll_riga>0 then
		ll_id=dw_1.getitemnumber(ll_riga, 1)
		if isnull(ll_id)  then
			if wf_salva_dw(dw_1,dw_2, 1)=1 then
				this.triggerevent(clicked!)
			end if
		else
			ll_riga=dw_2.insertrow(0)
			dw_2.setitem(ll_riga, 1, ll_id)
		end if
	end if
end if
end event

type cb_salva from commandbutton within w_pippo
integer x = 457
integer y = 796
integer width = 343
integer height = 100
integer taborder = 90
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

type cb_cancella from commandbutton within w_pippo
integer x = 882
integer y = 796
integer width = 343
integer height = 100
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancella"
end type

event clicked;//long ll_riga_da_cancellare
//if i_dw_corrente=1 then
//	ll_riga_da_cancellare=dw_1.getrow()
//	if ll_riga_da_cancellare>0 then
////	 	dw_1.trigger event ue_delete(ll_riga_da_cancellare)
//		
//		
//		dw_2.reset()
//	end if
//elseif  i_dw_corrente=2 then
//	ll_riga_da_cancellare=dw_2.getrow()
//	if ll_riga_da_cancellare>0 then
//		dw_2.trigger event ue_delete(ll_riga_da_cancellare)
//	end if
//end if
end event

type cb_ok from commandbutton within w_pippo
integer x = 2976
integer y = 796
integer width = 343
integer height = 100
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "OK"
boolean default = true
end type

type cb_annulla from commandbutton within w_pippo
integer x = 2569
integer y = 796
integer width = 343
integer height = 100
integer taborder = 100
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

