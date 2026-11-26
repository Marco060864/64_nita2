forward
global type w_confronto_doc from w_base
end type
type st_1 from statictext within w_confronto_doc
end type
type dw_5 from udw_000 within w_confronto_doc
end type
type cb_stampa from commandbutton within w_confronto_doc
end type
type cb_1 from commandbutton within w_confronto_doc
end type
type dw_4 from udw_000 within w_confronto_doc
end type
type dw_3 from udw_000 within w_confronto_doc
end type
type dw_2 from udw_001 within w_confronto_doc
end type
type dw_1 from udw_001 within w_confronto_doc
end type
end forward

global type w_confronto_doc from w_base
integer width = 4338
integer height = 2636
st_1 st_1
dw_5 dw_5
cb_stampa cb_stampa
cb_1 cb_1
dw_4 dw_4
dw_3 dw_3
dw_2 dw_2
dw_1 dw_1
end type
global w_confronto_doc w_confronto_doc

on w_confronto_doc.create
int iCurrent
call super::create
this.st_1=create st_1
this.dw_5=create dw_5
this.cb_stampa=create cb_stampa
this.cb_1=create cb_1
this.dw_4=create dw_4
this.dw_3=create dw_3
this.dw_2=create dw_2
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.dw_5
this.Control[iCurrent+3]=this.cb_stampa
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.dw_4
this.Control[iCurrent+6]=this.dw_3
this.Control[iCurrent+7]=this.dw_2
this.Control[iCurrent+8]=this.dw_1
end on

on w_confronto_doc.destroy
call super::destroy
destroy(this.st_1)
destroy(this.dw_5)
destroy(this.cb_stampa)
destroy(this.cb_1)
destroy(this.dw_4)
destroy(this.dw_3)
destroy(this.dw_2)
destroy(this.dw_1)
end on

event open;call super::open;dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
dw_3.settransobject(sqlca)
dw_4.settransobject(sqlca)

dw_3.insertrow(1)
dw_4.insertrow(1)


dw_3.setitem(1, "id_profilo", 184)
//dw_3.setitem(1, "numero", 443)
dw_4.setitem(1, "id_profilo", 171)
//dw_4.setitem(1, "numero", 1102)
end event

type st_1 from statictext within w_confronto_doc
integer x = 82
integer width = 2126
integer height = 200
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Inserire il numero del buratto e premere il bottone grigio accanto; fare lo stesso con l~'XRCLF. Poi premere il bottone ~"CONFRONTA~" quindi ~"STAMPA~", scegliere la stampante  e stampare."
boolean focusrectangle = false
end type

type dw_5 from udw_000 within w_confronto_doc
boolean visible = false
integer x = 91
integer y = 1864
integer width = 3909
integer height = 1352
integer taborder = 20
boolean titlebar = true
string dataobject = "d_confronto_doc_rpt"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
end type

type cb_stampa from commandbutton within w_confronto_doc
integer x = 3785
integer y = 276
integer width = 347
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Stampa"
end type

event clicked;integer li_ret
string ls_ret
datawindowchild dwc_1, dwc_2

li_ret=dw_5.getchild("dw_1", dwc_1)
if li_ret= -1 then
	
else
	dwc_1.reset()
	CONNECT USING SQLCA;
	dwc_1.settransobject(sqlca)
	//dw_5.settransobject(sqlca)
	li_ret=dw_1.rowscopy(1, dw_1.rowcount(), primary!, dwc_1, 1, primary!)
end if
li_ret=dw_5.getchild("dw_2", dwc_2)
if li_ret= -1 then
	
else
	dwc_2.reset()
	CONNECT USING SQLCA;
	dwc_2.settransobject(sqlca)
	//dw_5.settransobject(sqlca)
	li_ret=dw_2.rowscopy(1, dw_2.rowcount(), primary!, dwc_2, 1, primary!)
end if
ls_ret=dwc_1.modify("c_differenza.visible=0")
ls_ret=dwc_1.modify("c_evidenzia.visible=0")
ls_ret=dwc_1.modify("t_evidenzia.visible=0")
//ls_ret=dwc_1.modify(".visible=0")
//messagebox("W", ls_ret)
dwc_2.setredraw(true)
dwc_1.setredraw(true)
dw_5.print(true,true)

end event

type cb_1 from commandbutton within w_confronto_doc
integer x = 3374
integer y = 276
integer width = 389
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "CONFRONTA"
end type

event clicked;integer i
string ls_boL_5
long ll_riga_trovata,ll_ordina, li_qta1, li_qta2
decimal ldc_peso1, ldc_peso2

for i= 1 to dw_2.rowcount()
	ls_bol_5=dw_2.getitemstring(i, "c_bol_2")
	if pos(ls_bol_5, ".")>0 then
		ls_bol_5=left(ls_bol_5, 2)+right(ls_bol_5, 3)
	end if
	if len(ls_bol_5)=5 then
		dw_2.setitem(i, "c_ordina", i)
		ll_riga_trovata=dw_1.find("right(c_bol_2, 5)='"+ls_bol_5+"'", 1, 9999999)
		dw_1.setitem(ll_riga_trovata, "c_ordina", i)
		
		li_qta1=dw_1.getitemdecimal(ll_riga_trovata,"quantita")
		li_qta2=dw_2.getitemdecimal(i,"quantita")
		if (li_qta1<>li_qta2) then 
			dw_1.setitem(ll_riga_trovata, "c_colora",1)
			dw_2.setitem(i, "c_colora",1)
		end if
		ldc_peso1=dw_1.getitemdecimal(ll_riga_trovata,"peso_netto")
		ldc_peso2=dw_2.getitemdecimal(i,"peso_netto")
		if (ldc_peso1<>ldc_peso2) then 
			dw_1.setitem(ll_riga_trovata, "c_colora",2)
			dw_2.setitem(i, "c_colora",2)
			//dw_1.setitem(ll_riga_trovata,"c_differenza", ldc_peso2 - ldc_peso1)
			dw_2.setitem(i,"c_differenza", ldc_peso2 - ldc_peso1)
		end if
		if (ldc_peso1<>ldc_peso2 and li_qta1<>li_qta2) then 
			dw_1.setitem(ll_riga_trovata, "c_colora",3)
			dw_2.setitem(i, "c_colora",3)
		end if
	else
		dw_2.setitem(i, "c_ordina", i+10000)
		//dw_1.setitem(ll_riga_trovata, "c_ordina", i+10000)
	end if
	
next
for i=1 to dw_1.rowcount()
	ll_ordina=dw_1.getitemnumber(i, "c_ordina")
	if ll_ordina<=0 then
		dw_1.setitem(i, "c_ordina", i+10000)
	end if
next
//for i=1 to dw_2.rowcount()
//	ll_ordina=dw_2.getitemnumber(i, "c_ordina")
//	if ll_ordina<=0 then
//		dw_2.setitem(i, "c_ordina", i+10000)
//	end if
//next
dw_1.setsort("c_ordina")
dw_2.setsort("c_ordina")
dw_1.sort()
dw_2.sort()
dw_1.modify("c_differenza.visible=0")
end event

type dw_4 from udw_000 within w_confronto_doc
integer x = 1870
integer y = 216
integer width = 2341
integer height = 212
integer taborder = 10
string dataobject = "d_confronto_ext"
end type

event itemchanged;call super::itemchanged;long ll_id_esercizio, ll_id_registro,ll_id_mod_registro
long ll_id_prof,ll_id_doc, ll_numero


if dwo.name='numero' then
	accepttext()
	ll_numero=getitemnumber(1, "numero")
	ll_id_prof=getitemnumber(1, "id_profilo")
	select id_esercizio into :ll_id_esercizio from dba.esercizio where data_inizio<= today() and data_fine>= today();
	select id_mod_registro_prop into :ll_id_mod_registro from dba.prof_documento where id_prof_documento=:ll_id_prof;
SELECT Max("registro"."id_registro")
	INTO :ll_id_registro  	FROM "dba"."registro"  	
	WHERE ( "registro"."id_esercizio" = :ll_id_esercizio ) AND  ( "registro"."id_mod_registro" = :ll_id_mod_registro )   ;
	select id_documento into :ll_id_doc from dba.documento where num_progressivo=:ll_numero and id_registro=:ll_id_registro;
	dw_2.retrieve(ll_id_doc)
end if
end event

type dw_3 from udw_000 within w_confronto_doc
integer x = 64
integer y = 216
integer width = 1801
integer height = 204
integer taborder = 10
string dataobject = "d_confronto_ext"
end type

event itemchanged;call super::itemchanged;long ll_id_esercizio, ll_id_registro,ll_id_mod_registro
long ll_id_prof,ll_id_doc, ll_numero
string ls_ret


if dwo.name='numero' then  //b_retrieve
	accepttext()
	ll_numero=getitemnumber(1, "numero")
	ll_id_prof=getitemnumber(1, "id_profilo")
	select id_esercizio into :ll_id_esercizio from dba.esercizio where data_inizio<= today() and data_fine>= today();
	select id_mod_registro_prop into :ll_id_mod_registro from dba.prof_documento where id_prof_documento=:ll_id_prof;
SELECT Max("registro"."id_registro")
	INTO :ll_id_registro  	FROM "dba"."registro"  	
	WHERE ( "registro"."id_esercizio" = :ll_id_esercizio ) AND  ( "registro"."id_mod_registro" = :ll_id_mod_registro )   ;
	select id_documento into :ll_id_doc from dba.documento where num_progressivo=:ll_numero and id_registro=:ll_id_registro;
	dw_1.retrieve(ll_id_doc)
	dw_1.modify("c_differenza.visible=0")
	ls_ret=dw_1.modify("c_evidenzia.visible=0")
	dw_1.modify("t_evidenzia.visible=0")
	dw_1.modify("t_vedi_differenza.visible=0")
	dw_1.modify("c_ordina.visible=0")
	
	//messagebox("W", ls_ret)
end if
end event

type dw_2 from udw_001 within w_confronto_doc
integer x = 1769
integer y = 436
integer width = 2432
integer height = 2132
integer taborder = 10
string dataobject = "d_confronto_doc"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;string ls_bol_5
long ll_riga_trovata

if dwo.name='c_evidenzia' then
	
	ls_bol_5=getitemstring(row, "c_bol_2")
	if pos(ls_bol_5, ".")>0 then
		ls_bol_5=left(ls_bol_5, 2)+right(ls_bol_5, 3)
	end if
	ll_riga_trovata=dw_1.find("right(c_bol_2, 5)='"+ls_bol_5+"'", 1, 9999999)
	if ll_riga_trovata>0 then
		dw_1.setitem(ll_riga_trovata, "c_evidenzia", integer(data))
	end if
	dw_1.setredraw(true)
end if
end event

type dw_1 from udw_001 within w_confronto_doc
integer x = 64
integer y = 436
integer width = 1893
integer height = 2132
integer taborder = 10
string dataobject = "d_confronto_doc"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

