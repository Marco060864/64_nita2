forward
global type w_st_articoli_per_cat_codifica from w_stampa_001
end type
type dw_2 from udw_base within w_st_articoli_per_cat_codifica
end type
type cbx_prod_interna from checkbox within w_st_articoli_per_cat_codifica
end type
type cb_metti_a_no from commandbutton within w_st_articoli_per_cat_codifica
end type
type cb_salva from commandbutton within w_st_articoli_per_cat_codifica
end type
end forward

global type w_st_articoli_per_cat_codifica from w_stampa_001
integer x = 23
integer y = 12
dw_2 dw_2
cbx_prod_interna cbx_prod_interna
cb_metti_a_no cb_metti_a_no
cb_salva cb_salva
end type
global w_st_articoli_per_cat_codifica w_st_articoli_per_cat_codifica

type variables
long il_id_cat_codifica
end variables

on w_st_articoli_per_cat_codifica.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.cbx_prod_interna=create cbx_prod_interna
this.cb_metti_a_no=create cb_metti_a_no
this.cb_salva=create cb_salva
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.cbx_prod_interna
this.Control[iCurrent+3]=this.cb_metti_a_no
this.Control[iCurrent+4]=this.cb_salva
end on

on w_st_articoli_per_cat_codifica.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.cbx_prod_interna)
destroy(this.cb_metti_a_no)
destroy(this.cb_salva)
end on

event open;call super::open;dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
dw_2.insertrow(1)
end event

type dw_1 from w_stampa_001`dw_1 within w_st_articoli_per_cat_codifica
string dataobject = "d_st_articoli_per_cat_codifica"
end type

event dw_1::sqlpreview;call super::sqlpreview;//string ls_sql
//
//ls_sql=sqlsyntax
//
//if il_id_cat_codifica>0 then
//	ls_sql+=" where articolo.id_cat_codifica="+string(il_id_cat_codifica)
//	if cbx_prod_interna.checked then
//		ls_sql+=" and articolo.prod_interna='S' "
//	end if
//	setsqlpreview(ls_sql)
//end if
end event

type sle_pg from w_stampa_001`sle_pg within w_st_articoli_per_cat_codifica
integer x = 2099
integer width = 154
end type

type st_1 from w_stampa_001`st_1 within w_st_articoli_per_cat_codifica
integer x = 1832
string text = "St. Pg.:"
alignment alignment = right!
end type

type st_2 from w_stampa_001`st_2 within w_st_articoli_per_cat_codifica
integer x = 2264
end type

type sle_copie from w_stampa_001`sle_copie within w_st_articoli_per_cat_codifica
integer x = 2410
integer width = 135
end type

type sle_zoom from w_stampa_001`sle_zoom within w_st_articoli_per_cat_codifica
integer x = 636
end type

type cb_salva_su_file from w_stampa_001`cb_salva_su_file within w_st_articoli_per_cat_codifica
boolean visible = false
integer x = 2458
integer y = 26
integer width = 234
string text = "Salva &File"
end type

type cb_7 from w_stampa_001`cb_7 within w_st_articoli_per_cat_codifica
integer x = 786
end type

type cb_6 from w_stampa_001`cb_6 within w_st_articoli_per_cat_codifica
integer x = 519
end type

type cb_imp_st from w_stampa_001`cb_imp_st within w_st_articoli_per_cat_codifica
integer x = 2790
integer width = 267
end type

type cb_stampa from w_stampa_001`cb_stampa within w_st_articoli_per_cat_codifica
integer x = 3328
integer width = 201
end type

type cb_preview from w_stampa_001`cb_preview within w_st_articoli_per_cat_codifica
integer x = 2560
integer width = 201
end type

type cb_pg_dopo from w_stampa_001`cb_pg_dopo within w_st_articoli_per_cat_codifica
integer x = 377
end type

type cb_pg_prima from w_stampa_001`cb_pg_prima within w_st_articoli_per_cat_codifica
integer x = 267
end type

type cb_1 from w_stampa_001`cb_1 within w_st_articoli_per_cat_codifica
integer width = 201
end type

type dw_2 from udw_base within w_st_articoli_per_cat_codifica
integer x = 936
integer y = 26
integer width = 497
integer height = 102
boolean bringtotop = true
string dataobject = "d_scegli_cat_codifica"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

event itemchanged;call super::itemchanged;

if row>0 then
	il_id_cat_codifica=long(data)
	if il_id_cat_codifica>0 then
		dw_1.retrieve(il_id_cat_codifica)
	end if
end if
end event

type cbx_prod_interna from checkbox within w_st_articoli_per_cat_codifica
integer x = 1492
integer y = 77
integer width = 366
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
string text = "Prod. Interna"
end type

type cb_metti_a_no from commandbutton within w_st_articoli_per_cat_codifica
integer x = 1492
integer width = 410
integer height = 64
integer taborder = 10
boolean bringtotop = true
integer textsize = -6
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Metti a NO Prod Int."
end type

event clicked;integer i

for i = 1 to dw_1.rowcount()
	dw_1.setitem(i,"prod_interna", 'N')
next


end event

type cb_salva from commandbutton within w_st_articoli_per_cat_codifica
integer x = 3101
integer y = 35
integer width = 205
integer height = 90
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salva"
end type

event clicked;dw_1.accepttext()
if dw_1.update()=1 then
	commit;
else
	rollback;
end if
end event

