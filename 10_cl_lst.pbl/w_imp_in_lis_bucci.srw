forward
global type w_imp_in_lis_bucci from w_semplice_cx
end type
type dw_2 from u_dw_ext_main within w_imp_in_lis_bucci
end type
type cb_1 from commandbutton within w_imp_in_lis_bucci
end type
type cbx_scegli from checkbox within w_imp_in_lis_bucci
end type
type cbx_cambia from checkbox within w_imp_in_lis_bucci
end type
type cbx_1 from checkbox within w_imp_in_lis_bucci
end type
end forward

global type w_imp_in_lis_bucci from w_semplice_cx
integer width = 2912
integer height = 2136
dw_2 dw_2
cb_1 cb_1
cbx_scegli cbx_scegli
cbx_cambia cbx_cambia
cbx_1 cbx_1
end type
global w_imp_in_lis_bucci w_imp_in_lis_bucci

on w_imp_in_lis_bucci.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.cb_1=create cb_1
this.cbx_scegli=create cbx_scegli
this.cbx_cambia=create cbx_cambia
this.cbx_1=create cbx_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cbx_scegli
this.Control[iCurrent+4]=this.cbx_cambia
this.Control[iCurrent+5]=this.cbx_1
end on

on w_imp_in_lis_bucci.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.cb_1)
destroy(this.cbx_scegli)
destroy(this.cbx_cambia)
destroy(this.cbx_1)
end on

event resize;dw_1.width=newwidth - 105
dw_1.height=newheight - 550

cb_inserisci.y=newheight - 224
cb_inserisci.x=dw_1.x
cb_cancella.y=newheight - 224
cb_salva.y=newheight - 224
cb_salva.x=cb_inserisci.x + 285
cb_cancella.x=cb_salva.x + 285



cb_ultimo.x=cb_avanti.x + 128

cb_ok.y=newheight - 224
cb_ok.x=dw_1.x + dw_1.width - cb_ok.width
cb_ricerca.y=newheight - 224
cb_ricerca.x=cb_ok.x - 285
cb_annulla.y=newheight - 224
cb_annulla.x=cb_ricerca.x - 285
cb_ricerca.y=newheight - 224
cb_ricerca.x=cb_annulla.x - 285
cb_stampa.x=cb_cancella.x + 285
cb_stampa.y=cb_salva.y

cb_primo.y=newheight - 208
cb_primo.x=cb_stampa.x + 261
cb_indietro.y=newheight - 208
cb_indietro.x=cb_primo.x + 160
cb_avanti.y=newheight - 208
cb_avanti.x=cb_indietro.x + 160
cb_ultimo.y=newheight - 208
end event

event open;call super::open;dw_2.settransobject(sqlca)

dw_2.insertrow(1)

dw_1.retrieve()
end event

type cb_stampa from w_semplice_cx`cb_stampa within w_imp_in_lis_bucci
integer x = 1179
integer y = 1776
end type

type cb_ricerca from w_semplice_cx`cb_ricerca within w_imp_in_lis_bucci
integer x = 1755
integer y = 1704
end type

type cb_primo from w_semplice_cx`cb_primo within w_imp_in_lis_bucci
integer x = 1193
integer y = 1712
end type

type cb_ultimo from w_semplice_cx`cb_ultimo within w_imp_in_lis_bucci
integer x = 1609
integer y = 1712
end type

type cb_indietro from w_semplice_cx`cb_indietro within w_imp_in_lis_bucci
integer x = 1522
integer y = 1712
end type

type cb_avanti from w_semplice_cx`cb_avanti within w_imp_in_lis_bucci
integer x = 1650
integer y = 1712
end type

type dw_1 from w_semplice_cx`dw_1 within w_imp_in_lis_bucci
integer x = 9
integer y = 288
integer width = 2839
integer height = 1336
string dataobject = "d_imp_prezzi_in_lis_bucci"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type cb_inserisci from w_semplice_cx`cb_inserisci within w_imp_in_lis_bucci
integer x = 325
integer y = 1696
end type

type cb_salva from w_semplice_cx`cb_salva within w_imp_in_lis_bucci
integer x = 608
integer y = 1696
end type

type cb_cancella from w_semplice_cx`cb_cancella within w_imp_in_lis_bucci
integer x = 896
integer y = 1696
end type

type cb_annulla from w_semplice_cx`cb_annulla within w_imp_in_lis_bucci
integer x = 2030
integer y = 1700
end type

type cb_ok from w_semplice_cx`cb_ok within w_imp_in_lis_bucci
integer x = 2318
integer y = 1700
end type

type dw_2 from u_dw_ext_main within w_imp_in_lis_bucci
integer x = 37
integer y = 76
integer width = 873
integer height = 180
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_id_var_ext"
boolean border = false
end type

event getfocus;//
end event

event itemchanged;call super::itemchanged;//long ll_id_variazione
//integer li_ret
//
//ll_id_variazione=long(data)
//if ll_id_variazione> 0 then
//	if dw_2.rowcount()>0 then
//		li_ret=messagebox("Attenzione!", "Vuoi salvare i dati prima di caricare quelli del listino richiesto?", stopsign!, YesNoCancel!)
//		if  li_ret=1 then
//			cb_salva.triggerevent(clicked!)
//		elseif li_ret=3 then
//			return 1
//		end if
//	end if
//	dw_2.retrieve(ll_id_variazione)
//end if
end event

event losefocus;//
end event

type cb_1 from commandbutton within w_imp_in_lis_bucci
integer x = 951
integer y = 64
integer width = 599
integer height = 180
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Importa prezzi"
end type

event clicked;integer i, a=0
long ll_id_var, ll_id_uc
decimal ldc_prezzo

ll_id_var=dw_2.getitemnumber(1, "id_variazione")
if ll_id_var>0 then
	for i= 1 to dw_1.rowcount()
		ldc_prezzo=dw_1.getitemdecimal(i, "prezzo")
		ll_id_uc=dw_1.getitemnumber(i, "id_unita_confezione")
		insert into dba.prezzo (id_variazione, id_unita_confezione, prezzo)
		values (:ll_id_var, :ll_id_uc, :ldc_prezzo);
		if sqlca.sqlNrows>0 then
			commit;
		else
			update dba.prezzo set prezzo=:ldc_prezzo
			where id_variazione= :ll_id_var and id_unita_confezione=:ll_id_uc;
			if sqlca.sqlNrows>0 then
				commit;
			else
				rollback;
				a++
			end if
			rollback;
		end if
			
		
	next
	messagebox("Attenzione!", "Inserite "+string(i -a)+" su "+string(i))
else
	messagebox("Attenzione!", "Inserire un listino!")
end if
end event

type cbx_scegli from checkbox within w_imp_in_lis_bucci
integer x = 2437
integer y = 176
integer width = 402
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Scegli tutti"
boolean lefttext = true
end type

event clicked;integer i

if cbx_scegli.checked then
	for i= 1 to dw_1.rowcount()
		dw_1.setitem(i, "scegli", 1)
	next
else
	for i= 1 to dw_1.rowcount()
		dw_1.setitem(i, "scegli", 0)
	next
end if
end event

type cbx_cambia from checkbox within w_imp_in_lis_bucci
integer x = 2437
integer y = 28
integer width = 402
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "LIKE"
boolean lefttext = true
end type

event clicked;if checked then
	dw_1.dataobject="d_imp_prezzi_in_lis_bucci2"
else
	dw_1.dataobject="d_imp_prezzi_in_lis_bucci"
end if

dw_1.settransobject(sqlca)
dw_1.retrieve()
end event

type cbx_1 from checkbox within w_imp_in_lis_bucci
integer x = 1774
integer y = 28
integer width = 434
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Vedi Invisibili"
boolean lefttext = true
end type

event clicked;if checked then
	dw_1.setfilter("")
else
	dw_1.setfilter("visible='S'")
end if
dw_1.filter()
end event

