forward
global type w_copia_righe from w_001
end type
type dw_1 from udw_base within w_copia_righe
end type
type dw_2 from udw_base within w_copia_righe
end type
type dw_3 from udw_base within w_copia_righe
end type
type cb_1 from commandbutton within w_copia_righe
end type
type cb_ordina from commandbutton within w_copia_righe
end type
type dw_4 from udw_base within w_copia_righe
end type
type cb_stampa from commandbutton within w_copia_righe
end type
end forward

global type w_copia_righe from w_001
integer width = 3741
integer height = 2451
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = main!
dw_1 dw_1
dw_2 dw_2
dw_3 dw_3
cb_1 cb_1
cb_ordina cb_ordina
dw_4 dw_4
cb_stampa cb_stampa
end type
global w_copia_righe w_copia_righe

on w_copia_righe.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_2=create dw_2
this.dw_3=create dw_3
this.cb_1=create cb_1
this.cb_ordina=create cb_ordina
this.dw_4=create dw_4
this.cb_stampa=create cb_stampa
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.dw_3
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.cb_ordina
this.Control[iCurrent+6]=this.dw_4
this.Control[iCurrent+7]=this.cb_stampa
end on

on w_copia_righe.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.cb_1)
destroy(this.cb_ordina)
destroy(this.dw_4)
destroy(this.cb_stampa)
end on

event open;call super::open;dw_1.settransobject(sqlca)

dw_2.settransobject(sqlca)
dw_3.settransobject(sqlca)
dw_4.settransobject(sqlca)
dw_1.retrieve()

dw_1.setsort("num_documento")
dw_1.sort()
end event

type st_1 from w_001`st_1 within w_copia_righe
end type

type dw_1 from udw_base within w_copia_righe
integer x = 176
integer y = 128
integer width = 3306
integer height = 845
boolean bringtotop = true
string dataobject = "d_doc"
boolean hscrollbar = true
end type

event doubleclicked;call super::doubleclicked;long ll_id_doc, ll_num_prog, ll_row
date ldt_data
string ls_num_doc

dw_2.reset()
if row>0 then
	ll_id_doc=getitemnumber(row, "id_documento")
	ls_num_doc=getitemstring(row, "num_documento")
	ldt_data=getitemdate(row, "data_documento")
	ll_num_prog=getitemnumber(row, "num_progressivo")
	ll_row=dw_2.insertrow(0)
	dw_2.setitem(ll_row, "num_doc", ls_num_doc)
	dw_2.setitem(ll_row, "data_doc", ldt_data)
	dw_2.setitem(ll_row, "id_doc", ll_id_doc)
	dw_2.setitem(ll_row, "num_prog", ll_num_prog)
end if
end event

event rbuttondown;call super::rbuttondown;long ll_id_doc, ll_num_prog, ll_row
date ldt_data
string ls_num_doc

 
dw_3.reset()
if row>0 then
	ll_id_doc=getitemnumber(row, "id_documento")
	ls_num_doc=getitemstring(row, "num_documento")
	ldt_data=getitemdate(row, "data_documento")
	ll_num_prog=getitemnumber(row, "num_progressivo")
	ll_row=dw_3.insertrow(0)
	dw_3.setitem(ll_row, "num_doc", ls_num_doc)
	dw_3.setitem(ll_row, "data_doc", ldt_data)
	dw_3.setitem(ll_row, "id_doc", ll_id_doc)
	dw_3.setitem(ll_row, "num_prog", ll_num_prog)
	dw_4.retrieve(ll_id_doc)
end if
end event

type dw_2 from udw_base within w_copia_righe
integer x = 176
integer y = 998
integer width = 1580
integer height = 538
boolean bringtotop = true
string dataobject = "d_doc_partenza"
end type

type dw_3 from udw_base within w_copia_righe
integer x = 1872
integer y = 998
integer width = 1580
integer height = 179
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_doc_partenza"
end type

type cb_1 from commandbutton within w_copia_righe
integer x = 1814
integer y = 1254
integer width = 322
integer height = 90
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Copia"
end type

event clicked;long ll_id_doc_partenza, ll_id_doc_arrivo, ll_max_riga


ll_id_doc_partenza=dw_2.getitemnumber(1, "id_doc")
ll_id_doc_arrivo=dw_3.getitemnumber(1, "id_doc")




update riga_documento
set num_riga=num_riga *100
where id_documento=:ll_id_doc_partenza
;
if sqlca.sqlcode=0 then
	commit;
	messagebox("OK", "Rinumerate righe!")
else
	rollback;
	messagebox("AHI", "Errore rinumera righe!")
end if

update riga_documento
set id_documento=:ll_id_doc_arrivo
where id_documento=:ll_id_doc_partenza
;
if sqlca.sqlcode=0 then
	commit;
	select max(num_riga)
	into :ll_max_riga
	from riga_documento
	where id_documento=:ll_id_doc_arrivo
	and num_riga<100
	;
	update riga_documento
	set num_riga=num_riga/100+ :ll_max_riga
	where id_documento=:ll_id_doc_arrivo
	and num_riga>=100;
	commit;
	messagebox("OK", "Spostate righe!")
else
	rollback;
	messagebox("AHI", "Errore sposta!")
end if
end event

type cb_ordina from commandbutton within w_copia_righe
integer x = 1434
integer y = 26
integer width = 322
integer height = 90
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ordina"
end type

event clicked;string ll_null
setnull(ll_null)
dw_1.setsort(ll_null)
dw_1.sort()
end event

type dw_4 from udw_base within w_copia_righe
integer x = 88
integer y = 1587
integer width = 3540
integer height = 691
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_trova_scarichi_automatici"
boolean hscrollbar = true
end type

event doubleclicked;call super::doubleclicked;long ll_id_doc, ll_num_prog, ll_row
date ldt_data
string ls_num_doc

dw_2.reset()
if row>0 then
	ll_id_doc=getitemnumber(row, "id_documento")
	ls_num_doc=getitemstring(row, "num_documento")
	ldt_data=getitemdate(row, "data_documento")
	ll_num_prog=getitemnumber(row, "num_progressivo")
	ll_row=dw_2.insertrow(0)
	dw_2.setitem(ll_row, "num_doc", ls_num_doc)
	dw_2.setitem(ll_row, "data_doc", ldt_data)
	dw_2.setitem(ll_row, "id_doc", ll_id_doc)
	dw_2.setitem(ll_row, "num_prog", ll_num_prog)
end if
end event

event rbuttondown;call super::rbuttondown;long ll_id_doc, ll_num_prog, ll_row
date ldt_data
string ls_num_doc

dw_3.reset()
if row>0 then
	ll_id_doc=getitemnumber(row, "id_documento")
	ls_num_doc=getitemstring(row, "num_documento")
	ldt_data=getitemdate(row, "data_documento")
	ll_num_prog=getitemnumber(row, "num_progressivo")
	ll_row=dw_3.insertrow(0)
	dw_3.setitem(ll_row, "num_doc", ls_num_doc)
	dw_3.setitem(ll_row, "data_doc", ldt_data)
	dw_3.setitem(ll_row, "id_doc", ll_id_doc)
	dw_3.setitem(ll_row, "num_prog", ll_num_prog)
end if
end event

type cb_stampa from commandbutton within w_copia_righe
integer x = 1872
integer y = 1434
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
string text = "Stampa"
end type

event clicked;printsetup()
dw_4.print()
end event

