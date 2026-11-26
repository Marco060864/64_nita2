forward
global type w_ges_des_libera2 from w_semplice_gd
end type
type cbx_solo_tripli from checkbox within w_ges_des_libera2
end type
type st_1 from statictext within w_ges_des_libera2
end type
type sle_ric_articolo from singlelineedit within w_ges_des_libera2
end type
type sle_ric_cliente from singlelineedit within w_ges_des_libera2
end type
type st_2 from statictext within w_ges_des_libera2
end type
type st_articolo from statictext within w_ges_des_libera2
end type
type st_cliente from statictext within w_ges_des_libera2
end type
type cbx_solo_con_nota from checkbox within w_ges_des_libera2
end type
type cbx_ult_settimana from checkbox within w_ges_des_libera2
end type
end forward

global type w_ges_des_libera2 from w_semplice_gd
integer width = 5426
cbx_solo_tripli cbx_solo_tripli
st_1 st_1
sle_ric_articolo sle_ric_articolo
sle_ric_cliente sle_ric_cliente
st_2 st_2
st_articolo st_articolo
st_cliente st_cliente
cbx_solo_con_nota cbx_solo_con_nota
cbx_ult_settimana cbx_ult_settimana
end type
global w_ges_des_libera2 w_ges_des_libera2

on w_ges_des_libera2.create
int iCurrent
call super::create
this.cbx_solo_tripli=create cbx_solo_tripli
this.st_1=create st_1
this.sle_ric_articolo=create sle_ric_articolo
this.sle_ric_cliente=create sle_ric_cliente
this.st_2=create st_2
this.st_articolo=create st_articolo
this.st_cliente=create st_cliente
this.cbx_solo_con_nota=create cbx_solo_con_nota
this.cbx_ult_settimana=create cbx_ult_settimana
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_solo_tripli
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.sle_ric_articolo
this.Control[iCurrent+4]=this.sle_ric_cliente
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.st_articolo
this.Control[iCurrent+7]=this.st_cliente
this.Control[iCurrent+8]=this.cbx_solo_con_nota
this.Control[iCurrent+9]=this.cbx_ult_settimana
end on

on w_ges_des_libera2.destroy
call super::destroy
destroy(this.cbx_solo_tripli)
destroy(this.st_1)
destroy(this.sle_ric_articolo)
destroy(this.sle_ric_cliente)
destroy(this.st_2)
destroy(this.st_articolo)
destroy(this.st_cliente)
destroy(this.cbx_solo_con_nota)
destroy(this.cbx_ult_settimana)
end on

event resize;call super::resize;cbx_solo_tripli.y=cb_ricerca.y
cbx_solo_tripli.x=cb_ricerca.x - 485

cbx_solo_con_nota.y=cbx_solo_tripli.y
cbx_solo_con_nota.x=cbx_solo_tripli.x - cbx_solo_tripli.width - 100

cbx_ult_settimana.y=cbx_solo_tripli.y
cbx_ult_settimana.x=cbx_solo_con_nota.x - cbx_solo_con_nota.width - 150
st_1.x=sle_ric_cliente.x + sle_ric_cliente.width+250
st_1.y=cbx_solo_tripli.y + 100
sle_ric_articolo.y=cb_ricerca.y
sle_ric_articolo.x=cb_stampa.x + cb_stampa.width+100
st_2.y=st_1.y 
st_2.x=st_1.x + st_1.width+ 250
sle_ric_cliente.y=sle_ric_articolo.y
sle_ric_cliente.x=sle_ric_articolo.x + sle_ric_articolo.width +200

st_cliente.x=sle_ric_cliente.x
st_articolo.x=sle_ric_articolo.x 
st_cliente.y=sle_ric_cliente.y+ sle_ric_cliente.height+10
st_articolo.y=sle_ric_articolo.y+ sle_ric_articolo.height+10



end event

type cb_stampa from w_semplice_gd`cb_stampa within w_ges_des_libera2
end type

event cb_stampa::clicked;string ls_data, ls_num_doc, ls_filtro, ls_filtro2

ls_num_doc=parent.classname()
		
ls_data=string(today(), "dd-mm-yy")
ls_num_doc+="_"+ls_data
	
dw_1.Modify("DataWindow.Print.DocumentName='"+ls_num_doc+"'")
//20240226 inserisco filtro per stampare solo selezionati
//ls_filtro=dw_1.describe ("datawindow.table.filter")
//ls_filtro2=ls_filtro+" and (isnull(controllato) or controllato='N')"
//dw_1.setfilter(ls_filtro2)
//dw_1.filter()
dw_1.print(true, true)
//dw_1.setfilter(ls_filtro)
//dw_1.filter()
end event

type cb_ricerca from w_semplice_gd`cb_ricerca within w_ges_des_libera2
end type

type cb_primo from w_semplice_gd`cb_primo within w_ges_des_libera2
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_ges_des_libera2
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_ges_des_libera2
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_ges_des_libera2
end type

type dw_1 from w_semplice_gd`dw_1 within w_ges_des_libera2
integer width = 5275
string dataobject = "d_ges_des_libera"
end type

event dw_1::clicked;call super::clicked;//integer li_len    ////20240913 spostato su rbuttondown
//
//li_len=len(string(dwo.name))
//li_len= li_len -2
//if dwo.type='text' then
//	if messagebox("A", "Vuoi far sparire la colonna "+left(string(dwo.name), li_len)+"?", stopsign!, yesno!)=1 then
//		dw_1.modify(left(string(dwo.name), li_len)+".visible=0")
//	end if
//end if
//
if dwo.name='controllato' then  //20240520 segno la dataora della mofica controllato
	setitem(row, "dt_giallo", today())
end if
	
end event

event dw_1::doubleclicked;call super::doubleclicked;//long ll_id_art
//SPOSTATO IN 
//ll_id_art=getitemnumber(row, "id_articolo")
//
//if dwo.name='id_articolo' then  //20240520 apro una finestra e mostro pezzi a misura spediti nell'anno
//	openwithparm(w_vedi_art_per_misura, ll_id_art)
//end if
end event

event dw_1::rbuttondown;call super::rbuttondown;long ll_id_art
integer li_len

if row>0 then
	ll_id_art=getitemnumber(row, "id_articolo")
	
	if dwo.name='id_articolo' then  //20240520 apro una finestra e mostro pezzi a misura spediti nell'anno
		openwithparm(w_vedi_art_per_misura, ll_id_art)
	end if
end if
//20240913 spostato da clicked
li_len=len(string(dwo.name))
li_len= li_len -2
if dwo.type='text' then
	if messagebox("A", "Vuoi far sparire la colonna "+left(string(dwo.name), li_len)+"?", stopsign!, yesno!)=1 then
		dw_1.modify(left(string(dwo.name), li_len)+".visible=0")
	end if
end if

end event

type cb_inserisci from w_semplice_gd`cb_inserisci within w_ges_des_libera2
end type

type cb_salva from w_semplice_gd`cb_salva within w_ges_des_libera2
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_ges_des_libera2
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_ges_des_libera2
end type

type cb_ok from w_semplice_gd`cb_ok within w_ges_des_libera2
end type

type cbx_solo_tripli from checkbox within w_ges_des_libera2
integer x = 4082
integer y = 996
integer width = 343
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
string text = "Solo Tripli"
boolean checked = true
end type

event clicked;string ls_filtro
integer li_pos,li_len

ls_filtro=dw_1.describe ("datawindow.table.filter")
if ls_filtro="?" then ls_filtro=""
li_pos=pos(ls_filtro, "c_1>2 or ")
li_len=9
if checked then
	if li_pos<=0 then
		if POS(LS_FILTRO, "data_inserimento >= relativedate(today(), -7)")>0 then
			ls_filtro="c_1>2 or "+ ls_filtro
		else
			ls_filtro="c_1>2 "+ ls_filtro
		end if
	end if
else
	if li_pos>0 then
		ls_filtro=right(ls_filtro, len(ls_filtro) - li_len)
	end if
end if
dw_1.setfilter(ls_filtro)
dw_1.filter()
end event

type st_1 from statictext within w_ges_des_libera2
integer x = 2098
integer y = 1108
integer width = 1070
integer height = 172
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Tasto DX del Mouse sull~'ETICHETTA per far sparire la colonna!"
alignment alignment = center!
boolean focusrectangle = false
end type

type sle_ric_articolo from singlelineedit within w_ges_des_libera2
integer x = 1097
integer y = 984
integer width = 402
integer height = 112
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event modified;long ll_id_art, ll_riga_trovata

ll_id_art=long(sle_ric_articolo.text)
if ll_id_art>0 then
	ll_riga_trovata=dw_1.find("id_articolo="+string(ll_id_art), 1, dw_1.rowcount())
	if ll_riga_trovata>0 then
		dw_1.post scrolltorow(ll_riga_trovata)
	else
		messagebox("Attenzione!", "Articolo "+string(ll_id_art) +" Non trovato!")
	end if
else
	messagebox("Attenzione!", "Il testo inserito NON è un numero!")
end if

end event

type sle_ric_cliente from singlelineedit within w_ges_des_libera2
integer x = 1632
integer y = 984
integer width = 402
integer height = 112
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event modified;long  ll_riga_trovata
string ls_trova, ls_filtro
ls_trova=sle_ric_cliente.text
if ls_trova>" " then
	//20240913 cambio: faccio filtro invece che cercare la riga (Samy)
	ls_filtro="bollettine_excel_cliente='"+ls_trova+"'"
	dw_1.setfilter(ls_filtro)
	dw_1.filter()
	cbx_solo_tripli.checked=false
	cbx_ult_settimana.checked=false
	cbx_solo_con_nota.checked=false
//	ll_riga_trovata=dw_1.find("bollettine_excel_cliente='"+ls_trova+"'", 1, dw_1.rowcount())
//	if ll_riga_trovata>0 then
//		dw_1.post scrolltorow(ll_riga_trovata)
//	else
//		messagebox("Attenzione!", "Cliente "+ls_trova +" Non trovato!")
//	end if
else
	messagebox("Attenzione!", "Il testo inserito NON è un cliente!")
end if

end event

type st_2 from statictext within w_ges_des_libera2
integer x = 3150
integer y = 1108
integer width = 869
integer height = 172
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Tasto DX su ID_ARTICOLO mostra art. per misura!"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_articolo from statictext within w_ges_des_libera2
integer x = 1097
integer y = 1096
integer width = 402
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ric. ARTICOLO"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_cliente from statictext within w_ges_des_libera2
integer x = 1637
integer y = 1100
integer width = 402
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ric. CLIENTE"
alignment alignment = center!
boolean focusrectangle = false
end type

type cbx_solo_con_nota from checkbox within w_ges_des_libera2
integer x = 4082
integer y = 1132
integer width = 421
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
string text = "Solo con NOTA"
end type

event clicked;string ls_filtro
integer li_pos

ls_filtro=dw_1.describe ("datawindow.table.filter")
if ls_filtro="?" then ls_filtro=""
li_pos=POS(LS_FILTRO, "nota>' ' ")
if checked then
	if li_pos<=0 then
		ls_filtro=" nota>' ' " 
	end if
else
	if li_pos>0 then
		ls_filtro=""  //202400912 per ora va bene così....
		//20240912 azzero gli altri filtri a video
		cbx_solo_tripli.checked=false
		cbx_ult_settimana.checked=false
		//ls_filtro=left(ls_filtro, li_pos - 1)+ right(ls_filtro, len(ls_filtro) - (li_pos + 9)) //20240913 48 è la lunghezza di "or data_inserimento >= relativedate(today(), -7)"		
	end if		
end if
dw_1.setfilter(ls_filtro)
dw_1.filter()
end event

type cbx_ult_settimana from checkbox within w_ges_des_libera2
integer x = 4078
integer y = 1256
integer width = 535
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
string text = "Solo Ultima Settimana"
boolean checked = true
end type

event clicked;string ls_filtro
integer li_pos

ls_filtro=dw_1.describe ("datawindow.table.filter")
if ls_filtro="?" then ls_filtro=""
if checked then
	li_pos=POS(LS_FILTRO, "data_inserimento >= relativedate(today(), -7)")
	if li_pos<=0 then
		ls_filtro+=" or data_inserimento >= relativedate(today(), -7) " 
	end if
else
	li_pos=pos(ls_filtro, "data_inserimento >= relativedate(today(), -7)")
	if li_pos>0 then
		ls_filtro=left(ls_filtro, li_pos - 1)+ right(ls_filtro, len(ls_filtro) - (li_pos + 50)) //20240913 48 è la lunghezza di "or data_inserimento >= relativedate(today(), -7)"		
	end if		
end if
dw_1.setfilter(ls_filtro)
dw_1.filter()


end event

