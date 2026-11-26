forward
global type w_assegna_fascia_articolo_cx from w_001
end type
type dw_1 from udw_base within w_assegna_fascia_articolo_cx
end type
type dw_2 from udw_base within w_assegna_fascia_articolo_cx
end type
type dw_3 from udw_base within w_assegna_fascia_articolo_cx
end type
type st_2 from statictext within w_assegna_fascia_articolo_cx
end type
type cb_stampa from commandbutton within w_assegna_fascia_articolo_cx
end type
type st_3 from statictext within w_assegna_fascia_articolo_cx
end type
type dw_4 from udw_base within w_assegna_fascia_articolo_cx
end type
type cbx_1 from checkbox within w_assegna_fascia_articolo_cx
end type
type st_4 from statictext within w_assegna_fascia_articolo_cx
end type
type cb_salva from commandbutton within w_assegna_fascia_articolo_cx
end type
type cb_esci from commandbutton within w_assegna_fascia_articolo_cx
end type
end forward

global type w_assegna_fascia_articolo_cx from w_001
integer width = 4174
integer height = 2440
dw_1 dw_1
dw_2 dw_2
dw_3 dw_3
st_2 st_2
cb_stampa cb_stampa
st_3 st_3
dw_4 dw_4
cbx_1 cbx_1
st_4 st_4
cb_salva cb_salva
cb_esci cb_esci
end type
global w_assegna_fascia_articolo_cx w_assegna_fascia_articolo_cx

event open;call super::open;long ll_righe, i

DW_1.SETTRANSOBJECT(SQLCA)
DW_2.SETTRANSOBJECT(SQLCA)
DW_3.SETTRANSOBJECT(SQLCA)
DW_4.SETTRANSOBJECT(SQLCA)

ll_righe=DW_1.RETRIEVE()
DW_2.RETRIEVE()

DW_3.INSERTROW(1)
DW_4.INSERTROW(1)


for i= 1 to ll_righe
	dw_1.setitem(i, "id_azienda", 0)
	
NEXT
end event

on w_assegna_fascia_articolo_cx.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_2=create dw_2
this.dw_3=create dw_3
this.st_2=create st_2
this.cb_stampa=create cb_stampa
this.st_3=create st_3
this.dw_4=create dw_4
this.cbx_1=create cbx_1
this.st_4=create st_4
this.cb_salva=create cb_salva
this.cb_esci=create cb_esci
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.dw_3
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.cb_stampa
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.dw_4
this.Control[iCurrent+8]=this.cbx_1
this.Control[iCurrent+9]=this.st_4
this.Control[iCurrent+10]=this.cb_salva
this.Control[iCurrent+11]=this.cb_esci
end on

on w_assegna_fascia_articolo_cx.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.st_2)
destroy(this.cb_stampa)
destroy(this.st_3)
destroy(this.dw_4)
destroy(this.cbx_1)
destroy(this.st_4)
destroy(this.cb_salva)
destroy(this.cb_esci)
end on

type st_1 from w_001`st_1 within w_assegna_fascia_articolo_cx
end type

type dw_1 from udw_base within w_assegna_fascia_articolo_cx
integer x = 32
integer y = 24
integer width = 3301
integer height = 1756
boolean bringtotop = true
string title = "Assegna fascia di prezzo ad articoli"
string dataobject = "d_articolo_in_gruppo_gd"
end type

type dw_2 from udw_base within w_assegna_fascia_articolo_cx
integer x = 3360
integer y = 24
integer width = 763
integer height = 2240
boolean bringtotop = true
string dataobject = "d_fascia_elenco_gd"
end type

event doubleclicked;call super::doubleclicked;long ll_id_gruppo
integer i
string ls_cod_gruppo
date ldt_test
if row>0 then
	ls_cod_gruppo=dw_2.getitemstring(row, "codice")
	if ls_cod_gruppo>"" then
		select id_gruppo_articoli
		into :ll_id_gruppo
		from dba.gruppo_articoli
		where codice=:ls_cod_gruppo
		;
		
		dw_1.setfilter("id_azienda=1")
		dw_1.filter()
		for i= 1 to dw_1.rowcount()
			dw_1.setitem(i, "articolo_id_gruppo_articoli", ll_id_gruppo)
			dw_1.setitem(i, "gruppo_articoli_codice", ls_cod_gruppo)
		next
		ll_id_gruppo=dw_3.getitemnumber(1, "gruppo")
		if ll_id_gruppo>0 then
			dw_3.trigger event itemchanged(1, dw_3.object.gruppo, string(ll_id_gruppo))
		else
			//dw_4.trigger event itemchanged(1, dw_3.object.gruppo, string(ll_id_gruppo))
		end if
		
	end if
	
	
end if
end event

type dw_3 from udw_base within w_assegna_fascia_articolo_cx
integer x = 18
integer y = 1880
integer width = 558
integer height = 120
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_lista_gruppo_ext"
boolean vscrollbar = false
boolean livescroll = false
end type

event itemchanged;call super::itemchanged;STRING LS_FILTRO
if data>" " then
	LS_FILTRO="id_gruppo_articoli="+data
	dw_1.setfilter(LS_FILTRO)
	dw_1.filter()
else
	dw_1.setfilter("")
	dw_1.filter()
end if
end event

type st_2 from statictext within w_assegna_fascia_articolo_cx
integer x = 37
integer y = 1796
integer width = 466
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Vedi solo Gruppo"
boolean focusrectangle = false
end type

type cb_stampa from commandbutton within w_assegna_fascia_articolo_cx
integer x = 2583
integer y = 1796
integer width = 343
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stampa"
end type

event clicked;dw_1.modify("id_azienda.visible=0")
printsetup()
dw_1.print()
dw_1.modify("id_azienda.visible=1")
end event

type st_3 from statictext within w_assegna_fascia_articolo_cx
integer x = 635
integer y = 1800
integer width = 553
integer height = 68
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Vedi articoli creati dal"
boolean focusrectangle = false
end type

type dw_4 from udw_base within w_assegna_fascia_articolo_cx
integer x = 617
integer y = 1884
integer width = 567
integer height = 116
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_data_ora_gd"
boolean vscrollbar = false
boolean livescroll = false
end type

event itemchanged;call super::itemchanged;date ldt_data
STRING LS_FILTRO, ls_data
if data>"2001/01/02" then
	ls_data=left(data,10)
	ldt_data=date(ls_data)
	LS_FILTRO="data_ora_creazione>= date('"+string(ldt_data, "yyyy-mm-dd")+"')"
	dw_1.setfilter(LS_FILTRO)
	dw_1.filter()
else
	dw_1.setfilter("")
	dw_1.filter()
end if
end event

type cbx_1 from checkbox within w_assegna_fascia_articolo_cx
integer x = 1664
integer y = 1812
integer width = 471
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Seleziona tutto"
end type

event clicked;long i
integer li_valore
if checked then
	li_valore=1
else
	li_valore=0
end if
for i= 1 to dw_1.ROWCOUNT()
	dw_1.setitem(i, "id_azienda", li_valore)
	
NEXT

end event

type st_4 from statictext within w_assegna_fascia_articolo_cx
integer x = 18
integer y = 2280
integer width = 3776
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Scegli gli articoli a cui vuoi applicare un gruppo spuntando il check a destra della riga. Quindi fai doppio click sul gruppo che vuoi assegnare. Salva."
boolean focusrectangle = false
end type

type cb_salva from commandbutton within w_assegna_fascia_articolo_cx
integer x = 2199
integer y = 1800
integer width = 343
integer height = 100
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salva"
end type

event clicked;dw_1.trigger event ue_update()
end event

type cb_esci from commandbutton within w_assegna_fascia_articolo_cx
integer x = 2985
integer y = 1796
integer width = 343
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Esci"
end type

event clicked;close(parent)
end event

