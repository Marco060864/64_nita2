forward
global type w_prod_fornitori2_cx from w_testa_righe_cx
end type
type cb_stampa from commandbutton within w_prod_fornitori2_cx
end type
type cbx_fo from checkbox within w_prod_fornitori2_cx
end type
type dw_3 from udw_base within w_prod_fornitori2_cx
end type
type cb_retrieve from commandbutton within w_prod_fornitori2_cx
end type
type rb_1 from radiobutton within w_prod_fornitori2_cx
end type
type rb_2 from radiobutton within w_prod_fornitori2_cx
end type
type rb_3 from radiobutton within w_prod_fornitori2_cx
end type
type rb_4 from radiobutton within w_prod_fornitori2_cx
end type
type dw_4 from udw_base within w_prod_fornitori2_cx
end type
type pb_1 from picturebutton within w_prod_fornitori2_cx
end type
end forward

global type w_prod_fornitori2_cx from w_testa_righe_cx
integer width = 3611
integer height = 2516
string title = "Segui Produzione Fornitori"
cb_stampa cb_stampa
cbx_fo cbx_fo
dw_3 dw_3
cb_retrieve cb_retrieve
rb_1 rb_1
rb_2 rb_2
rb_3 rb_3
rb_4 rb_4
dw_4 dw_4
pb_1 pb_1
end type
global w_prod_fornitori2_cx w_prod_fornitori2_cx

on w_prod_fornitori2_cx.create
int iCurrent
call super::create
this.cb_stampa=create cb_stampa
this.cbx_fo=create cbx_fo
this.dw_3=create dw_3
this.cb_retrieve=create cb_retrieve
this.rb_1=create rb_1
this.rb_2=create rb_2
this.rb_3=create rb_3
this.rb_4=create rb_4
this.dw_4=create dw_4
this.pb_1=create pb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_stampa
this.Control[iCurrent+2]=this.cbx_fo
this.Control[iCurrent+3]=this.dw_3
this.Control[iCurrent+4]=this.cb_retrieve
this.Control[iCurrent+5]=this.rb_1
this.Control[iCurrent+6]=this.rb_2
this.Control[iCurrent+7]=this.rb_3
this.Control[iCurrent+8]=this.rb_4
this.Control[iCurrent+9]=this.dw_4
this.Control[iCurrent+10]=this.pb_1
end on

on w_prod_fornitori2_cx.destroy
call super::destroy
destroy(this.cb_stampa)
destroy(this.cbx_fo)
destroy(this.dw_3)
destroy(this.cb_retrieve)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.rb_3)
destroy(this.rb_4)
destroy(this.dw_4)
destroy(this.pb_1)
end on

event ue_postopen;call super::ue_postopen;long ll_id_prof
	

dw_1.setfilter("mostra='S'")
dw_1.filter()

dw_3.insertrow(1)
dw_3.setitem(1, "da_data", relativedate(today(), -60))

 dw_1.retrieve()
 
 dw_4.insertrow(1)
 
 select id_prof_documento
 into :ll_id_prof
 from dba.prof_documento
 where codice='SALD'
 ;
 
 if ll_id_prof>0 then
	dw_4.setitem(1, "id_profilo", ll_id_prof)
end if
 
 


end event

event open;long ll_id
dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
dw_4.settransobject(sqlca)


trigger event ue_postopen()

//if dw_1.retrieve()>0 then
//	ll_id=dw_1.getitemnumber(1,1)
//	dw_2.retrieve(ll_id)
//end if
end event

type st_1 from w_testa_righe_cx`st_1 within w_prod_fornitori2_cx
end type

type dw_1 from w_testa_righe_cx`dw_1 within w_prod_fornitori2_cx
integer x = 27
integer width = 2459
integer height = 640
string dataobject = "d_prod_sog_fo_lt"
end type

event dw_1::rowfocuschanged;long ll_id
integer li_test  
date ldt_da_data, ldt_a_data

if currentrow>0 then
	if dw_3.rowcount()=1 then
		ll_id=getitemnumber(currentrow, 1)
		
		if ll_id>0 then
			
			//if dw_2.trigger event ue_update()=1 then
				ldt_da_data=dw_3.getitemdate(1, "da_data")
				ldt_a_data=dw_3.getitemdate(1, "a_data")
				dw_2.retrieve(ll_id, ldt_da_data, ldt_a_data)
	//		else
	//			messagebox("Attenzione!", "Salvataggio non riuscito!")
	//		end if
			
		else
			dw_2.reset()
		end if
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

type dw_2 from w_testa_righe_cx`dw_2 within w_prod_fornitori2_cx
integer x = 27
integer y = 692
integer width = 3497
integer height = 1484
string dataobject = "d_2017_fo_produzione"
end type

event dw_2::doubleclicked;call super::doubleclicked;long ll_id_doc
w_orafo_documento_ordine_cx w_orafo
s_list_main s_list

if row<=0 then return
s_list.s_identifica[1]="id_documento"
s_list.s_modo=modo_modifica
ll_id_doc=getitemnumber(row, "riga_documento_id_documento_1")
if ll_id_doc>0 then
	s_list.l_identifica[1]=ll_id_doc
	openwithparm(w_orafo, s_list)
end if
end event

type cb_inserisci from w_testa_righe_cx`cb_inserisci within w_prod_fornitori2_cx
boolean visible = false
integer x = 55
integer y = 284
end type

type cb_salva from w_testa_righe_cx`cb_salva within w_prod_fornitori2_cx
boolean visible = false
integer x = 361
integer y = 296
end type

type cb_cancella from w_testa_righe_cx`cb_cancella within w_prod_fornitori2_cx
boolean visible = false
integer x = 64
integer y = 388
end type

type cb_annulla from w_testa_righe_cx`cb_annulla within w_prod_fornitori2_cx
boolean visible = false
integer x = 69
integer y = 500
end type

type cb_ok from w_testa_righe_cx`cb_ok within w_prod_fornitori2_cx
integer x = 3264
integer y = 28
end type

type cb_stampa from commandbutton within w_prod_fornitori2_cx
integer x = 3264
integer y = 584
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

type cbx_fo from checkbox within w_prod_fornitori2_cx
integer x = 2519
integer y = 32
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

type dw_3 from udw_base within w_prod_fornitori2_cx
integer x = 2565
integer y = 144
integer width = 960
integer height = 184
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_da_data_a_data_bol2"
boolean vscrollbar = false
end type

type cb_retrieve from commandbutton within w_prod_fornitori2_cx
integer x = 3282
integer y = 348
integer width = 247
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Ricarica"
end type

event clicked;long ll_id

date ldt_da_data, ldt_a_data
dw_3.accepttext()

ll_id=dw_1.getitemnumber(dw_1.getrow(), 1)
		
if ll_id>0 then
	ldt_da_data=dw_3.getitemdate(1, "da_data")
	ldt_a_data=dw_3.getitemdate(1, "a_data")
	dw_2.retrieve(ll_id, ldt_da_data, ldt_a_data)
end if
end event

type rb_1 from radiobutton within w_prod_fornitori2_cx
integer x = 2519
integer y = 392
integer width = 741
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
string text = "Solo non rientrati (NO RCLF)"
end type

event clicked;if checked then
	dw_2.setfilter("c_test_rclf = 0")

end if
dw_2.filter()
end event

type rb_2 from radiobutton within w_prod_fornitori2_cx
integer x = 2519
integer y = 460
integer width = 631
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
string text = "Solo Aperti (NO RBOL)"
end type

event clicked;if checked then
	dw_2.setfilter("c_test_rbol = 0")

end if
dw_2.filter()
end event

type rb_3 from radiobutton within w_prod_fornitori2_cx
integer x = 2519
integer y = 528
integer width = 622
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
string text = "NO RCLF e NO RBOL"
boolean checked = true
end type

event clicked;if checked then
	dw_2.setfilter("c_test_rclf = 0 and c_test_rbol = 0")

end if
dw_2.filter()
end event

type rb_4 from radiobutton within w_prod_fornitori2_cx
integer x = 2519
integer y = 596
integer width = 622
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
string text = "Tutti"
end type

event clicked;if checked then
	dw_2.setfilter("")
end if
dw_2.filter()
end event

type dw_4 from udw_base within w_prod_fornitori2_cx
integer x = 73
integer y = 2212
integer width = 960
integer height = 184
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_a_data_e_profilo"
boolean vscrollbar = false
end type

type pb_1 from picturebutton within w_prod_fornitori2_cx
integer x = 1042
integer y = 2208
integer width = 215
integer height = 196
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string picturename = "C:\nita\icone\Ok.png"
alignment htextalign = left!
end type

event clicked;date ldt_a_data, ldt_da_data
long ll_id_prof, ll_id_sog, ll_riga, ll_righe, i
integer li_ret
datastore ds_chiudi

if messagebox("Attenzione!", "Sicuri di voler chiudere alcuni documenti?")=1 then
	dw_4.accepttext()
	
	
	ll_id_prof=dw_4.getitemnumber(1, "id_profilo")
	ldt_a_data=dw_4.getitemdate(1, "a_data")
	
	ldt_da_data=date("01/01/"+string(year(ldt_a_data)))
	
	ll_riga=dw_1.getrow()

	ll_id_sog=dw_1.getitemnumber(ll_riga, "id_sog_commerciale")
	ds_chiudi=create datastore
	ds_chiudi.dataobject="d_chiudi_doc"
	ds_chiudi.settransobject(sqlca)
	ll_righe=ds_chiudi.retrieve(ll_id_prof, ll_id_sog, ldt_da_data, ldt_a_data)
	if ll_righe>0 then
		for i=1 to ll_righe
			ds_chiudi.setitem(i, "chius_forzata", "S")
		next
		li_ret=ds_chiudi.update()
		if li_ret=1 then
			commit;
			messagebox("OK!", "Chiusura Documenti al "+string(ldt_a_data, "dd/mm/yyyy")+ " effettuata!")
		else
			rollback;
			messagebox("Attenzione!", "Chiusura Documenti al "+string(ldt_a_data, "dd/mm/yyyy")+ " non riuscita!")
		end if
	end if
//	update dba.documento
//	set chius_forzata='S'
//	where id_prof_documento=:ll_id_prof
//	and id_sog_commerciale=:ll_id_sog
//	and data_documento<=:ldt_a_data
//	and data_documento>=:ldt_da_data
//	;
//	if sqlca.sqlcode=0 then
//		commit;
//		messagebox("OK!", "Chiusura Documenti al "+string(ldt_a_data, "dd/mm/yyyy")+ " effettuata!")
//	else
//		rollback;
//		messagebox("Attenzione!", "Chiusura Documenti al "+string(ldt_a_data, "dd/mm/yyyy")+ " non riuscita!")
//	end if
end if
end event

