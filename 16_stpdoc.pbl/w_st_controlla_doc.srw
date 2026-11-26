forward
global type w_st_controlla_doc from w_stampa_001
end type
type dw_2 from udw_base within w_st_controlla_doc
end type
type cb_carica from commandbutton within w_st_controlla_doc
end type
type cb_correggi from commandbutton within w_st_controlla_doc
end type
type cb_salva from commandbutton within w_st_controlla_doc
end type
type cb_2 from commandbutton within w_st_controlla_doc
end type
end forward

global type w_st_controlla_doc from w_stampa_001
dw_2 dw_2
cb_carica cb_carica
cb_correggi cb_correggi
cb_salva cb_salva
cb_2 cb_2
end type
global w_st_controlla_doc w_st_controlla_doc

type variables

end variables

on w_st_controlla_doc.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.cb_carica=create cb_carica
this.cb_correggi=create cb_correggi
this.cb_salva=create cb_salva
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.cb_carica
this.Control[iCurrent+3]=this.cb_correggi
this.Control[iCurrent+4]=this.cb_salva
this.Control[iCurrent+5]=this.cb_2
end on

on w_st_controlla_doc.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.cb_carica)
destroy(this.cb_correggi)
destroy(this.cb_salva)
destroy(this.cb_2)
end on

event open;call super::open;dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
dw_2.insertrow(1)
end event

type dw_1 from w_stampa_001`dw_1 within w_st_controlla_doc
integer y = 352
integer width = 3474
integer height = 1312
string dataobject = "d_controlla_doc"
end type

type sle_pg from w_stampa_001`sle_pg within w_st_controlla_doc
integer x = 1232
integer width = 176
end type

type st_1 from w_stampa_001`st_1 within w_st_controlla_doc
integer x = 969
end type

type st_2 from w_stampa_001`st_2 within w_st_controlla_doc
end type

type sle_copie from w_stampa_001`sle_copie within w_st_controlla_doc
end type

type sle_zoom from w_stampa_001`sle_zoom within w_st_controlla_doc
integer x = 673
end type

type cb_salva_su_file from w_stampa_001`cb_salva_su_file within w_st_controlla_doc
end type

type cb_7 from w_stampa_001`cb_7 within w_st_controlla_doc
integer x = 823
end type

type cb_6 from w_stampa_001`cb_6 within w_st_controlla_doc
integer x = 560
end type

type cb_imp_st from w_stampa_001`cb_imp_st within w_st_controlla_doc
end type

type cb_stampa from w_stampa_001`cb_stampa within w_st_controlla_doc
end type

type cb_preview from w_stampa_001`cb_preview within w_st_controlla_doc
end type

type cb_pg_dopo from w_stampa_001`cb_pg_dopo within w_st_controlla_doc
end type

type cb_pg_prima from w_stampa_001`cb_pg_prima within w_st_controlla_doc
end type

type cb_1 from w_stampa_001`cb_1 within w_st_controlla_doc
end type

type dw_2 from udw_base within w_st_controlla_doc
integer x = 37
integer y = 128
integer width = 1390
integer height = 224
integer taborder = 70
boolean bringtotop = true
string dataobject = "d_scegli_registro"
end type

type cb_carica from commandbutton within w_st_controlla_doc
integer x = 1499
integer y = 192
integer width = 344
integer height = 99
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Carica"
end type

event clicked;long ll_id_registro

ll_id_registro=dw_2.getitemnumber(1, "id_registro")
	
if ll_id_registro>0 then
	dw_1.retrieve(ll_id_registro)
end if
end event

type cb_correggi from commandbutton within w_st_controlla_doc
integer x = 1975
integer y = 192
integer width = 344
integer height = 99
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Correggi"
end type

event clicked;long i
time lt_ora, lt_ora_2
date ldt_data, ldt_data_2

for I= 1 to dw_1.rowcount()
	lt_ora=dw_1.getitemtime(i, "ora_trasporto")
	ldt_data=dw_1.getitemdate(i, "data_documento")
	if ldt_data=ldt_data_2 and lt_ora <= lt_ora_2  then
		lt_ora=relativetime(lt_ora_2, 300)
		dw_1.setitem(i,"ora_trasporto",lt_ora)
	end if
	lt_ora_2=lt_ora
	ldt_data_2=ldt_data
next
end event

type cb_salva from commandbutton within w_st_controlla_doc
integer x = 2487
integer y = 192
integer width = 344
integer height = 99
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salva"
end type

event clicked;if dw_1.update() =1 then
	commit;
else
	rollback;
	messagebox("Errore!", "Correzione non Salvata!")
end if
end event

type cb_2 from commandbutton within w_st_controlla_doc
integer x = 2973
integer y = 189
integer width = 369
integer height = 90
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Armetti a posto"
end type

event clicked;long i
time lt_ora, lt_ora_2=time("20:00:00")
date ldt_data, ldt_data_2
datetime lt_data_ora

for I= 1 to dw_1.rowcount()
	lt_data_ora=dw_1.getitemdatetime(i, "data_ora_creazione")
	lt_ora=time(lt_data_ora)
	dw_1.setitem(i,"ora_trasporto",lt_ora)
next
end event

