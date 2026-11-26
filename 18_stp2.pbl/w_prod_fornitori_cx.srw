forward
global type w_prod_fornitori_cx from w_testa_righe_cx
end type
type cb_stampa from commandbutton within w_prod_fornitori_cx
end type
type cbx_solo_aperti from checkbox within w_prod_fornitori_cx
end type
type cbx_fo from checkbox within w_prod_fornitori_cx
end type
end forward

global type w_prod_fornitori_cx from w_testa_righe_cx
integer width = 3863
integer height = 2300
string title = "Segui Produzione Fornitori"
cb_stampa cb_stampa
cbx_solo_aperti cbx_solo_aperti
cbx_fo cbx_fo
end type
global w_prod_fornitori_cx w_prod_fornitori_cx

on w_prod_fornitori_cx.create
int iCurrent
call super::create
this.cb_stampa=create cb_stampa
this.cbx_solo_aperti=create cbx_solo_aperti
this.cbx_fo=create cbx_fo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_stampa
this.Control[iCurrent+2]=this.cbx_solo_aperti
this.Control[iCurrent+3]=this.cbx_fo
end on

on w_prod_fornitori_cx.destroy
call super::destroy
destroy(this.cb_stampa)
destroy(this.cbx_solo_aperti)
destroy(this.cbx_fo)
end on

event ue_postopen;call super::ue_postopen;	dw_2.setfilter("c_venduto = 0")
	dw_2.filter()
	
	dw_1.setfilter("mostra='S'")
	dw_1.filter()
end event

type st_1 from w_testa_righe_cx`st_1 within w_prod_fornitori_cx
end type

type dw_1 from w_testa_righe_cx`dw_1 within w_prod_fornitori_cx
integer x = 27
integer width = 2459
integer height = 640
string dataobject = "d_prod_sog_fo_lt"
end type

event dw_1::rowfocuschanged;long ll_id
integer li_test  

if currentrow>0 then
	
	ll_id=getitemnumber(currentrow, 1)
	
	if ll_id>0 then
		
		//if dw_2.trigger event ue_update()=1 then
			dw_2.retrieve(ll_id)
//		else
//			messagebox("Attenzione!", "Salvataggio non riuscito!")
//		end if
		
	else
		dw_2.reset()
	end if
end if
setrowfocusindicator(hand!)
end event

event dw_1::itemchanged;call super::itemchanged;long ll_riga
string ls_ragione

if dwo.name="rag_soc_1" then
	ls_ragione=dw_1.getitemstring(row, "rag_soc_1")
	ll_riga=dw_1.find("rag_soc_1 <> '"+ls_ragione+"' and rag_soc_1 like '" +data+ "%'" , 1, dw_1.rowcount())
	if ll_riga>0 then
		post scrolltorow(ll_riga)
	end if
	return 2
end if
end event

type dw_2 from w_testa_righe_cx`dw_2 within w_prod_fornitori_cx
integer x = 27
integer y = 692
integer width = 3744
integer height = 1484
string dataobject = "d_doc_produzione2016"
end type

type cb_inserisci from w_testa_righe_cx`cb_inserisci within w_prod_fornitori_cx
boolean visible = false
integer x = 3305
integer y = 28
end type

type cb_salva from w_testa_righe_cx`cb_salva within w_prod_fornitori_cx
integer x = 2546
integer y = 28
end type

type cb_cancella from w_testa_righe_cx`cb_cancella within w_prod_fornitori_cx
boolean visible = false
integer x = 3305
integer y = 156
end type

type cb_annulla from w_testa_righe_cx`cb_annulla within w_prod_fornitori_cx
boolean visible = false
integer x = 3305
integer y = 284
end type

type cb_ok from w_testa_righe_cx`cb_ok within w_prod_fornitori_cx
integer x = 2546
integer y = 156
end type

type cb_stampa from commandbutton within w_prod_fornitori_cx
integer x = 2546
integer y = 564
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
string text = "Stampa"
end type

event clicked;printsetup()
dw_2.print()
end event

type cbx_solo_aperti from checkbox within w_prod_fornitori_cx
integer x = 3424
integer y = 616
integer width = 320
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Solo Aperti"
boolean checked = true
end type

event clicked;if checked then
	dw_2.setfilter("c_venduto = 0")
else
	dw_2.setfilter("")
end if
dw_2.filter()
end event

type cbx_fo from checkbox within w_prod_fornitori_cx
integer x = 2546
integer y = 436
integer width = 457
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Tutti i Fornitori"
end type

event clicked;if checked then
	dw_1.setfilter("")
else
	dw_1.setfilter("mostra='S'")
end if
dw_1.filter()
end event

