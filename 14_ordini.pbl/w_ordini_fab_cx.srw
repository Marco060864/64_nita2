forward
global type w_ordini_fab_cx from w_semplice_cx
end type
type cbx_ordinato from checkbox within w_ordini_fab_cx
end type
type cbx_produzione from checkbox within w_ordini_fab_cx
end type
type cbx_evaso from checkbox within w_ordini_fab_cx
end type
type st_1 from statictext within w_ordini_fab_cx
end type
type dw_2 from udw_000 within w_ordini_fab_cx
end type
type cb_mostra from commandbutton within w_ordini_fab_cx
end type
end forward

global type w_ordini_fab_cx from w_semplice_cx
integer width = 3145
integer height = 2236
cbx_ordinato cbx_ordinato
cbx_produzione cbx_produzione
cbx_evaso cbx_evaso
st_1 st_1
dw_2 dw_2
cb_mostra cb_mostra
end type
global w_ordini_fab_cx w_ordini_fab_cx

type variables
string is_sql_originale
end variables

forward prototypes
public subroutine wf_riempi_nulli ()
end prototypes

public subroutine wf_riempi_nulli ();long i


update riga_documento
set provv_carea_2=0
from documento d, registro reg, riga_documento r
where reg.tipo_registro='OV'
and d.id_documento=r.id_documento
and d.id_registro=reg.id_registro
;
if sqlca.sqlNrows>0 then
	commit;
else
	rollback;
end if

//for i = 1 to dw_1.rowcount()
//	if isnull(dw_1.getitemnumber(i, "provv_carea_2")) then
//		dw_1.setitem(i, "provv_carea_2", 0)
//	end if
//next
//cb_salva.triggerevent(clicked!) 
end subroutine

on w_ordini_fab_cx.create
int iCurrent
call super::create
this.cbx_ordinato=create cbx_ordinato
this.cbx_produzione=create cbx_produzione
this.cbx_evaso=create cbx_evaso
this.st_1=create st_1
this.dw_2=create dw_2
this.cb_mostra=create cb_mostra
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_ordinato
this.Control[iCurrent+2]=this.cbx_produzione
this.Control[iCurrent+3]=this.cbx_evaso
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.dw_2
this.Control[iCurrent+6]=this.cb_mostra
end on

on w_ordini_fab_cx.destroy
call super::destroy
destroy(this.cbx_ordinato)
destroy(this.cbx_produzione)
destroy(this.cbx_evaso)
destroy(this.st_1)
destroy(this.dw_2)
destroy(this.cb_mostra)
end on

event resize;call super::resize;dw_1.height=newheight - 292 - 220
end event

event open;call super::open;

dw_2.SetTransObject(SQLCA)

dw_1.settransobject(sqlca)
dw_2.insertrow(1)


dw_2.setitem(1, "da_data", relativedate(today(), -90))
dw_2.setitem(1, "a_data",today())


is_sql_originale=dw_1.getsqlselect()




end event

type cb_stampa from w_semplice_cx`cb_stampa within w_ordini_fab_cx
integer x = 905
integer y = 2024
end type

type cb_ricerca from w_semplice_cx`cb_ricerca within w_ordini_fab_cx
integer x = 1481
integer y = 1952
end type

type cb_primo from w_semplice_cx`cb_primo within w_ordini_fab_cx
integer x = 919
integer y = 1960
end type

type cb_ultimo from w_semplice_cx`cb_ultimo within w_ordini_fab_cx
integer x = 1335
integer y = 1960
end type

type cb_indietro from w_semplice_cx`cb_indietro within w_ordini_fab_cx
integer x = 1248
integer y = 1960
end type

type cb_avanti from w_semplice_cx`cb_avanti within w_ordini_fab_cx
integer x = 1376
integer y = 1960
end type

type dw_1 from w_semplice_cx`dw_1 within w_ordini_fab_cx
integer x = 55
integer y = 268
integer width = 2999
integer height = 1652
string dataobject = "d_ordini_fab_breve_tb"
end type

event dw_1::sqlpreview;string ls_sql

if dw_1.is_sql> " " then
	ls_sql=is_sql_originale
	ls_sql+=dw_1.is_sql
	setsqlpreview(ls_sql)
end if
end event

event dw_1::ue_update;dwitemstatus status
integer i, li_stato_riga
long ll_id_doc
string ls_chiudi, ls_fase_ordine
accepttext()
for i = 1 to rowcount()
	status=getitemstatus(i, "ordinato_fo", primary!)
	if status=DataModified! then
		ll_id_doc=getitemnumber(i, "documento_id_documento")
		ls_fase_ordine=getitemstring(i, "ordinato_fo")
		update dba.documento
		set ordinato_fo=:ls_fase_ordine
		where id_documento=:ll_id_doc
		;
		if sqlca.sqlNrows>0 then
			commit;
		
		else
			rollback;
			messagebox("Attenzione!", "DOC "+string (ll_id_doc)+ " NON salvato CAMBIO FASE LAVORAZIONE!")
			return -1
		end if
		
	end if
next
return 1
//	status=getitemstatus(i, "forza_chius_evasione", primary!)
//	if status=DataModified! then
//		ll_id_riga=getitemnumber(i, "id_riga_documento")
//		ls_chiudi=getitemstring(i, "forza_chius_evasione")
//		update riga_documento
//		set forza_chius_evasione=:ls_chiudi
//		where id_riga_documento=:ll_id_riga
//		;
//		if sqlca.sqlNrows>0 then
//			commit;
//			return 1
//		else
//			rollback;
//			messagebox("Attenzione!", "Riga "+string (ll_id_riga)+ " NON salvata CHIUSURA!")
//			return -1
//		end if
//	end if
	

end event

event dw_1::doubleclicked;//
long ll_id_doc
w_orafo_documento_ordine_cx w_orafo
s_list_main s_list

if row<=0 then return
s_list.s_identifica[1]="id_documento"
s_list.s_modo=modo_modifica
ll_id_doc=getitemnumber(row, "documento_id_documento")
if ll_id_doc>0 then
	s_list.l_identifica[1]=ll_id_doc
	openwithparm(w_orafo, s_list)
end if


end event

type cb_inserisci from w_semplice_cx`cb_inserisci within w_ordini_fab_cx
boolean visible = false
integer x = 50
integer y = 1944
end type

type cb_salva from w_semplice_cx`cb_salva within w_ordini_fab_cx
integer x = 334
integer y = 1944
end type

type cb_cancella from w_semplice_cx`cb_cancella within w_ordini_fab_cx
boolean visible = false
integer x = 622
integer y = 1944
end type

type cb_annulla from w_semplice_cx`cb_annulla within w_ordini_fab_cx
integer x = 1755
integer y = 1948
end type

type cb_ok from w_semplice_cx`cb_ok within w_ordini_fab_cx
integer x = 2043
integer y = 1948
end type

type cbx_ordinato from checkbox within w_ordini_fab_cx
integer x = 334
integer y = 180
integer width = 343
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ordinato"
boolean checked = true
end type

type cbx_produzione from checkbox within w_ordini_fab_cx
integer x = 690
integer y = 180
integer width = 398
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Produzione"
end type

type cbx_evaso from checkbox within w_ordini_fab_cx
integer x = 1102
integer y = 180
integer width = 343
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Evaso"
end type

type st_1 from statictext within w_ordini_fab_cx
integer x = 64
integer y = 180
integer width = 256
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Mostra: "
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_2 from udw_000 within w_ordini_fab_cx
integer x = 87
integer y = 12
integer width = 2002
integer height = 140
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_da_data_a_data_sog_com"
end type

type cb_mostra from commandbutton within w_ordini_fab_cx
integer x = 2139
integer y = 20
integer width = 910
integer height = 232
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Mostra"
end type

event clicked;date ldt_da_data, ldt_a_data
string ls_produzione, ls_evaso, ls_ordinato, ls_filtro_sog, ls_chiusi
long ll_id_sog


dw_1.is_sql=""
ldt_da_data=dw_2.getitemdate(1, "da_data")
ldt_a_data=dw_2.getitemdate(1, "a_data")
ll_id_sog=dw_2.getitemnumber(1, "id_sog_com")

if ll_id_sog>0 then
	ls_filtro_sog=" and documento.id_sog_commerciale ="+string(ll_id_sog)+ " "
else
	ls_filtro_sog=""
end if

if cbx_ordinato.checked then ls_ordinato="O"  else ls_ordinato="-1"
if cbx_evaso.checked then 	ls_evaso="E"  else ls_evaso="-1"
if cbx_produzione.checked then ls_produzione="P" else ls_produzione="-1"
//if cbx_chiusi.checked  then 
//	ls_chiusi=" and (riga_documento.forza_chius_evasione= 'N' or riga_documento.forza_chius_evasione= 'S') "
//else
//	ls_chiusi=" and riga_documento.forza_chius_evasione= 'N' "
//end if


//dw_1.is_sql=ls_chiusi+ ls_filtro_sog+" and (provv_carea_2 is null or provv_carea_2 = "+ls_ordinato +" or  provv_carea_2 = "+ls_evaso + " or provv_carea_2 = "+ls_produzione+")"
//wf_riempi_nulli()
dw_1.is_sql=ls_chiusi+ ls_filtro_sog+" and (documento.ordinato_fo is null or documento.ordinato_fo = '"+ls_ordinato +"' or  documento.ordinato_fo = '"+ls_evaso + "' or documento.ordinato_fo = '"+ls_produzione+"')"
dw_1.retrieve(ldt_da_data, ldt_a_data)


end event

