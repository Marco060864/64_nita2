forward
global type w_gest_insoluti_fab_cx from w_semplice_cx
end type
type cbx_ordinato from checkbox within w_gest_insoluti_fab_cx
end type
type cbx_produzione from checkbox within w_gest_insoluti_fab_cx
end type
type cbx_evaso from checkbox within w_gest_insoluti_fab_cx
end type
type st_1 from statictext within w_gest_insoluti_fab_cx
end type
type dw_2 from udw_000 within w_gest_insoluti_fab_cx
end type
type cb_mostra from commandbutton within w_gest_insoluti_fab_cx
end type
type cbx_chiusi from checkbox within w_gest_insoluti_fab_cx
end type
end forward

global type w_gest_insoluti_fab_cx from w_semplice_cx
integer width = 5056
integer height = 2236
cbx_ordinato cbx_ordinato
cbx_produzione cbx_produzione
cbx_evaso cbx_evaso
st_1 st_1
dw_2 dw_2
cb_mostra cb_mostra
cbx_chiusi cbx_chiusi
end type
global w_gest_insoluti_fab_cx w_gest_insoluti_fab_cx

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

on w_gest_insoluti_fab_cx.create
int iCurrent
call super::create
this.cbx_ordinato=create cbx_ordinato
this.cbx_produzione=create cbx_produzione
this.cbx_evaso=create cbx_evaso
this.st_1=create st_1
this.dw_2=create dw_2
this.cb_mostra=create cb_mostra
this.cbx_chiusi=create cbx_chiusi
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_ordinato
this.Control[iCurrent+2]=this.cbx_produzione
this.Control[iCurrent+3]=this.cbx_evaso
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.dw_2
this.Control[iCurrent+6]=this.cb_mostra
this.Control[iCurrent+7]=this.cbx_chiusi
end on

on w_gest_insoluti_fab_cx.destroy
call super::destroy
destroy(this.cbx_ordinato)
destroy(this.cbx_produzione)
destroy(this.cbx_evaso)
destroy(this.st_1)
destroy(this.dw_2)
destroy(this.cb_mostra)
destroy(this.cbx_chiusi)
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

type cb_stampa from w_semplice_cx`cb_stampa within w_gest_insoluti_fab_cx
integer x = 905
integer y = 2024
end type

type cb_ricerca from w_semplice_cx`cb_ricerca within w_gest_insoluti_fab_cx
integer x = 1481
integer y = 1952
end type

type cb_primo from w_semplice_cx`cb_primo within w_gest_insoluti_fab_cx
integer x = 919
integer y = 1960
end type

type cb_ultimo from w_semplice_cx`cb_ultimo within w_gest_insoluti_fab_cx
integer x = 1335
integer y = 1960
end type

type cb_indietro from w_semplice_cx`cb_indietro within w_gest_insoluti_fab_cx
integer x = 1248
integer y = 1960
end type

type cb_avanti from w_semplice_cx`cb_avanti within w_gest_insoluti_fab_cx
integer x = 1376
integer y = 1960
end type

type dw_1 from w_semplice_cx`dw_1 within w_gest_insoluti_fab_cx
integer x = 55
integer y = 268
integer width = 4855
integer height = 1652
string dataobject = "d_gest_scad_insoluti"
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
long ll_id_riga
string ls_chiudi
accepttext()
for i = 1 to rowcount()
	status=getitemstatus(i, "provv_carea_2", primary!)
	if status=DataModified! then
		ll_id_riga=getitemnumber(i, "id_riga_documento")
		li_stato_riga=getitemnumber(i, "provv_carea_2")
		update riga_documento
		set provv_carea_2=:li_stato_riga
		where id_riga_documento=:ll_id_riga
		;
		if sqlca.sqlNrows>0 then
			commit;
			return 1
		else
			rollback;
			messagebox("Attenzione!", "Riga "+string (ll_id_riga)+ " NON salvato CAMBIO STATO!")
			return -1
		end if
		
	end if
	status=getitemstatus(i, "forza_chius_evasione", primary!)
	if status=DataModified! then
		ll_id_riga=getitemnumber(i, "id_riga_documento")
		ls_chiudi=getitemstring(i, "forza_chius_evasione")
		update riga_documento
		set forza_chius_evasione=:ls_chiudi
		where id_riga_documento=:ll_id_riga
		;
		if sqlca.sqlNrows>0 then
			commit;
			return 1
		else
			rollback;
			messagebox("Attenzione!", "Riga "+string (ll_id_riga)+ " NON salvata CHIUSURA!")
			return -1
		end if
	end if
	
next
end event

type cb_inserisci from w_semplice_cx`cb_inserisci within w_gest_insoluti_fab_cx
boolean visible = false
integer x = 50
integer y = 1944
end type

type cb_salva from w_semplice_cx`cb_salva within w_gest_insoluti_fab_cx
integer x = 334
integer y = 1944
end type

type cb_cancella from w_semplice_cx`cb_cancella within w_gest_insoluti_fab_cx
boolean visible = false
integer x = 622
integer y = 1944
end type

type cb_annulla from w_semplice_cx`cb_annulla within w_gest_insoluti_fab_cx
integer x = 1755
integer y = 1948
end type

type cb_ok from w_semplice_cx`cb_ok within w_gest_insoluti_fab_cx
integer x = 2043
integer y = 1948
end type

type cbx_ordinato from checkbox within w_gest_insoluti_fab_cx
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

type cbx_produzione from checkbox within w_gest_insoluti_fab_cx
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

type cbx_evaso from checkbox within w_gest_insoluti_fab_cx
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

type st_1 from statictext within w_gest_insoluti_fab_cx
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

type dw_2 from udw_000 within w_gest_insoluti_fab_cx
integer x = 87
integer y = 12
integer width = 2002
integer height = 140
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_da_data_a_data_sog_com"
end type

type cb_mostra from commandbutton within w_gest_insoluti_fab_cx
integer x = 2139
integer y = 20
integer width = 786
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

if cbx_ordinato.checked then ls_ordinato="0"  else ls_ordinato="-1"
if cbx_evaso.checked then 	ls_evaso="2"  else ls_evaso="-1"
if cbx_produzione.checked then ls_produzione="1" else ls_produzione="-1"
if cbx_chiusi.checked  then 
	ls_chiusi=" and (riga_documento.forza_chius_evasione= 'N' or riga_documento.forza_chius_evasione= 'S') "
else
	ls_chiusi=" and riga_documento.forza_chius_evasione= 'N' "
end if


dw_1.is_sql=ls_chiusi+ ls_filtro_sog+" and (provv_carea_2 is null or provv_carea_2 = "+ls_ordinato +" or  provv_carea_2 = "+ls_evaso + " or provv_carea_2 = "+ls_produzione+")"
//wf_riempi_nulli()
dw_1.retrieve(ldt_da_data, ldt_a_data)


end event

type cbx_chiusi from checkbox within w_gest_insoluti_fab_cx
integer x = 1390
integer y = 180
integer width = 631
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
string text = "Chiusi Forzatamente"
end type

