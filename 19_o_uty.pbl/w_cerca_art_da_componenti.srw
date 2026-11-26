forward
global type w_cerca_art_da_componenti from w_001
end type
type dw_2 from udw_figlia within w_cerca_art_da_componenti
end type
type cb_seleziona_tutti from commandbutton within w_cerca_art_da_componenti
end type
type cb_1 from commandbutton within w_cerca_art_da_componenti
end type
type dw_1 from udw_base within w_cerca_art_da_componenti
end type
type cb_stampa from commandbutton within w_cerca_art_da_componenti
end type
type st_2 from statictext within w_cerca_art_da_componenti
end type
type cb_trova from commandbutton within w_cerca_art_da_componenti
end type
type dw_3 from udw_base within w_cerca_art_da_componenti
end type
type dw_4 from udw_base within w_cerca_art_da_componenti
end type
type dw_5 from udw_000 within w_cerca_art_da_componenti
end type
type cb_2 from commandbutton within w_cerca_art_da_componenti
end type
end forward

global type w_cerca_art_da_componenti from w_001
integer x = 1057
integer y = 483
integer width = 4613
integer height = 1932
dw_2 dw_2
cb_seleziona_tutti cb_seleziona_tutti
cb_1 cb_1
dw_1 dw_1
cb_stampa cb_stampa
st_2 st_2
cb_trova cb_trova
dw_3 dw_3
dw_4 dw_4
dw_5 dw_5
cb_2 cb_2
end type
global w_cerca_art_da_componenti w_cerca_art_da_componenti

type variables
integer ii_ricerca_art_fornitore
string is_search_window, is_sql_originale
long il_id_art[]
end variables

forward prototypes
public function string wf_selezione (long row, datawindow adw_origine, string as_col_origine, datawindow adw_dest, string as_col_dest, string as_filtro_agg)
public subroutine wf_confronta (long al_righe_confronto)
end prototypes

public function string wf_selezione (long row, datawindow adw_origine, string as_col_origine, datawindow adw_dest, string as_col_dest, string as_filtro_agg);long i, ll_righe, ll_row
string ls_filter
boolean lb_filter

if as_filtro_agg<>"" then
	ls_filter=as_filtro_agg+" and ("
else
	ls_filter="("
end if
lb_filter=(as_col_origine<>"")and(as_col_dest<>"")
if NOT(KeyDown(KeyShift!))And NOT(KeyDown(KeyControl!)) then
	ll_righe=adw_origine.RowCount()
	ll_row=row
	
	for i = 1 to ll_righe
		if i=ll_row then continue
		if adw_origine.IsSelected(i) then adw_origine.SelectRow(i,false)
	next
	
	adw_origine.SelectRow(ll_row, not (adw_origine.isselected(ll_row)))
	if lb_filter then ls_filter = ls_filter + as_col_dest+' ='+string(adw_origine.GetItemNumber(ll_row,as_col_origine))+' or '
elseif KeyDown(KeyShift!) then
		ll_row=row
		adw_origine.SelectRow(ll_row,true)
		ll_righe=adw_origine.RowCount()
		ll_row=ll_righe
		
		for i= 1 to ll_row
			if adw_origine.IsSelected(i) then ll_row=i
		next
		
		for i=ll_row+1 to ll_righe
			if adw_origine.IsSelected(i) then ll_righe=i
		next
		
		for i = ll_row to ll_righe
			adw_origine.SelectRow(i,true)
			if lb_filter then ls_filter = ls_filter + as_col_dest+'='+string(adw_origine.GetItemNumber(i,as_col_origine))+' or '					
		next
	elseif KeyDown(KeyControl!) then
		
		ll_row=row
		adw_origine.SelectRow(ll_row,Not adw_origine.IsSelected(ll_row))
		
		ll_righe=adw_origine.RowCount()
		for i = 1 to ll_righe
			if adw_origine.IsSelected(i) then
				if lb_filter then ls_filter = ls_filter + as_col_dest+'='+string(adw_origine.GetItemNumber(i,as_col_origine))+' or '	
			end if
		next
end if
	return ""

	

end function

public subroutine wf_confronta (long al_righe_confronto);long ll_id_art, ll_righe
integer i, li_ret

ll_righe=dw_2.rowcount()
for i= ll_righe to 1 step -1
	ll_id_art=dw_2.getitemnumber(i, "id_articolo")
	li_ret=dw_3.find("id_articolo="+string(ll_id_art), 1, al_righe_confronto)
	if li_ret<=0 then dw_2.deleterow(i)
next

end subroutine

on w_cerca_art_da_componenti.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.cb_seleziona_tutti=create cb_seleziona_tutti
this.cb_1=create cb_1
this.dw_1=create dw_1
this.cb_stampa=create cb_stampa
this.st_2=create st_2
this.cb_trova=create cb_trova
this.dw_3=create dw_3
this.dw_4=create dw_4
this.dw_5=create dw_5
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.cb_seleziona_tutti
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.dw_1
this.Control[iCurrent+5]=this.cb_stampa
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.cb_trova
this.Control[iCurrent+8]=this.dw_3
this.Control[iCurrent+9]=this.dw_4
this.Control[iCurrent+10]=this.dw_5
this.Control[iCurrent+11]=this.cb_2
end on

on w_cerca_art_da_componenti.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.cb_seleziona_tutti)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.cb_stampa)
destroy(this.st_2)
destroy(this.cb_trova)
destroy(this.dw_3)
destroy(this.dw_4)
destroy(this.dw_5)
destroy(this.cb_2)
end on

event open;call super::open;
dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
dw_3.settransobject(sqlca)
dw_4.settransobject(sqlca)
dw_5.settransobject(sqlca)
dw_1.insertrow(0)





end event

event ue_postopen;call super::ue_postopen; 
 

 
 is_sql_originale= dw_2.getsqlselect()
end event

type st_1 from w_001`st_1 within w_cerca_art_da_componenti
end type

type dw_2 from udw_figlia within w_cerca_art_da_componenti
integer x = 37
integer y = 432
integer width = 2711
integer height = 1348
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_art_da_comp_ra"
end type

event clicked;call super::clicked;wf_selezione(row,this,"",this,"","")
end event

event sqlpreview;call super::sqlpreview;//integer i, li_righe
//string ls_sql
//
//li_righe=upperbound(il_id_art)
//if li_righe>0 then
//	ls_sql = is_sql_originale
//	
//	for i= 1 to li_righe
//		
//			ls_sql+= " AND (riga_distinta.id_articolo="+string(il_id_art[i])+" )"
//		
//	next
//	
//	
//	if ls_sql<> sqlsyntax then
//		i=setsqlselect(ls_sql)
//	end if
//end if
end event

event rowfocuschanged;call super::rowfocuschanged;long ll_id_art, ll_id_dis
string ls_testo

if currentrow>0 then
	ll_id_art=getitemnumber(currentrow, "id_articolo")
	//dw_4.retrieve(ll_id_art)
	select id_distinta into :ll_id_dis from dba.distinta
	where id_articolo=:ll_id_art
	;
	dw_5.retrieve(ll_id_dis)
	ls_testo=getitemstring(currentrow, "articolo_codice")+" - "+string(getitemnumber(currentrow, "id_articolo"))
	ls_testo+=" - "+string(getitemdecimal(currentrow, "peso_netto"), "#,0.00")
	dw_5.modify("t_1.text='"+ls_testo+"'")
	
	
end if
	
end event

type cb_seleziona_tutti from commandbutton within w_cerca_art_da_componenti
boolean visible = false
integer x = 2281
integer y = 1800
integer width = 434
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Seleziona Tutti"
end type

event clicked;integer i

for i= 1 to dw_2.rowcount()
	dw_2.SelectRow(I,true)
next
end event

type cb_1 from commandbutton within w_cerca_art_da_componenti
boolean visible = false
integer x = 2299
integer y = 1948
integer width = 434
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Deseleziona Tutti"
end type

event clicked;//integer i
//
//for i= 1 to dw_2.rowcount()
//	dw_2.SelectRow(I,false)
//next
end event

type dw_1 from udw_base within w_cerca_art_da_componenti
integer x = 965
integer y = 24
integer width = 1783
integer height = 396
boolean bringtotop = true
string dataobject = "d_cerca_articolo"
boolean hscrollbar = true
end type

event clicked;call super::clicked;string ls_filtro, ls_colonna
s_ric_param is_ricpar
w_search_main	lw_sm

accepttext()

if dwo.name="c_articolo_cod_sw" or dwo.name="descrizione_sw" then
	is_search_window = "w_articolo_coddes_documento_sw" 
	ls_colonna=left(dwo.name, len(string(dwo.name)) -3)
	ls_filtro=getitemstring(row, ls_colonna)
	is_ricpar.s_filter_value = ls_filtro
	if ls_colonna="c_articolo_cod" then
		is_ricpar.s_filter_name = "articolo_codice" 
		OpenWithParm (lw_sm,is_ricpar,is_search_window)
		is_ricpar=message.powerobjectparm
		post setitem(row, ls_colonna, is_ricpar.s_main_value)
		setitem(row, "id_articolo", long(is_ricpar.s_id_seg_value[1]))
		setitem(row, "descrizione", is_ricpar.s_ausil_value[1])
	else
		is_ricpar.s_filter_name = "articolo_descrizione"
		OpenWithParm (lw_sm,is_ricpar,is_search_window)
		is_ricpar=message.powerobjectparm
		post setitem(row, ls_colonna, is_ricpar.s_main_value)
		setitem(row, "id_articolo", long(is_ricpar.s_id_seg_value[1]))
		setitem(row, "c_articolo_cod", is_ricpar.s_ausil_value[1])
	end if
	
end if
end event

event ue_key;call super::ue_key;choose case key
	
	case Keyadd!
		if (keyFlags=2) then
			trigger event ue_insert(0)
		end if

	case KeySubtract!
		if (keyFlags=2) then
			if getrow()>0 then
				trigger event ue_delete(getrow())
			end if
		end if			
   case KeyS!
		if (keyFlags=2) then
			trigger event ue_update()		
		end if
	case KeyF12!
		trigger event ue_update()			
	
end choose
end event

event itemchanged;call super::itemchanged;trigger event clicked(10,10,row, object.c_articolo_cod_sw)
end event

type cb_stampa from commandbutton within w_cerca_art_da_componenti
integer x = 23
integer y = 316
integer width = 343
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stampa"
end type

event clicked;
printsetup()
dw_2.print()
end event

type st_2 from statictext within w_cerca_art_da_componenti
integer x = 32
integer y = 12
integer width = 923
integer height = 188
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Inserisci qui i componenti che deve avere in distinta l~'articolo/gli articoli ricercato/i."
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_trova from commandbutton within w_cerca_art_da_componenti
integer x = 613
integer y = 316
integer width = 343
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Trova"
end type

event clicked;long  ll_azzera[], ll_righe,ll_righe_confronto
integer i
dw_1.accepttext()

il_id_art=ll_azzera

for i= 1 to dw_1.rowcount()
	il_id_art[i]=dw_1.getitemnumber(i, "id_articolo")
	if i=1 then
		ll_righe=dw_2.retrieve(il_id_art[1])
	else
		ll_righe_confronto=dw_3.retrieve(il_id_art[i])
		wf_confronta(ll_righe_confronto)
	end if
	
next





//dw_2.retrieve()

end event

type dw_3 from udw_base within w_cerca_art_da_componenti
boolean visible = false
integer x = 1125
integer y = 1788
integer width = 1083
integer height = 388
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_art_da_comp_ra"
end type

type dw_4 from udw_base within w_cerca_art_da_componenti
boolean visible = false
integer x = 27
integer y = 1792
integer width = 1065
integer height = 1236
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_trova_ordini_da_articolo"
boolean hscrollbar = true
end type

event doubleclicked;call super::doubleclicked;long ll_id_doc
w_orafo_documento_ordine_cx w_orafo
s_list_main s_list

if row<=0 then return
s_list.s_identifica[1]="id_documento"
s_list.s_modo=modo_modifica
ll_id_doc=getitemnumber(row, "id_documento")
if ll_id_doc>0 then
	s_list.l_identifica[1]=ll_id_doc
	openwithparm(w_orafo, s_list)
end if

//string ls_sort
//ls_sort=string(dwo.name)
//if right(ls_sort, 2)="_t" then
//	ls_sort=left(ls_sort, len(ls_sort) - 2)
//	setsort(ls_sort)
//	sort()
//end if
end event

type dw_5 from udw_000 within w_cerca_art_da_componenti
integer x = 2761
integer y = 424
integer width = 1787
integer height = 1360
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_riga_dis_verifica_componenti"
end type

type cb_2 from commandbutton within w_cerca_art_da_componenti
integer x = 4155
integer y = 304
integer width = 389
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stampa Righe"
end type

event clicked;dw_5.print(true, true)
end event

