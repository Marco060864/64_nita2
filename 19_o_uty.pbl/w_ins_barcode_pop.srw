forward
global type w_ins_barcode_pop from w_001
end type
type dw_1 from udw_base within w_ins_barcode_pop
end type
type cb_ok from commandbutton within w_ins_barcode_pop
end type
type cb_annulla from commandbutton within w_ins_barcode_pop
end type
type cb_stampa from commandbutton within w_ins_barcode_pop
end type
type cb_riallinea_bol from commandbutton within w_ins_barcode_pop
end type
end forward

global type w_ins_barcode_pop from w_001
integer x = 1057
integer y = 483
integer width = 1385
integer height = 856
windowtype windowtype = response!
dw_1 dw_1
cb_ok cb_ok
cb_annulla cb_annulla
cb_stampa cb_stampa
cb_riallinea_bol cb_riallinea_bol
end type
global w_ins_barcode_pop w_ins_barcode_pop

type variables
date idt_data_documento
end variables

on w_ins_barcode_pop.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_ok=create cb_ok
this.cb_annulla=create cb_annulla
this.cb_stampa=create cb_stampa
this.cb_riallinea_bol=create cb_riallinea_bol
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.cb_annulla
this.Control[iCurrent+4]=this.cb_stampa
this.Control[iCurrent+5]=this.cb_riallinea_bol
end on

on w_ins_barcode_pop.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_ok)
destroy(this.cb_annulla)
destroy(this.cb_stampa)
destroy(this.cb_riallinea_bol)
end on

event open;call super::open;string ls_data_doc
dw_1.settransobject(sqlca)
dw_1.insertrow(1)

ls_data_doc=message.stringparm
idt_data_documento=date(ls_data_doc)
end event

type st_1 from w_001`st_1 within w_ins_barcode_pop
end type

type dw_1 from udw_base within w_ins_barcode_pop
integer x = 41
integer y = 52
integer width = 1015
integer height = 408
boolean bringtotop = true
string dataobject = "d_ins_barcode_ext"
boolean vscrollbar = false
end type

event itemchanged;call super::itemchanged;//
end event

type cb_ok from commandbutton within w_ins_barcode_pop
integer x = 704
integer y = 488
integer width = 343
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "OK"
boolean default = true
end type

event clicked;string ls_manu, ls_barcode, ls_num, ls_num_prog="", LS_DATA_SCADENZA
long ll_num_prog
DW_1.ACCEPTTEXT()
ls_barcode=dw_1.getitemstring(1, "cod_barre")
ls_manu=dw_1.getitemstring(1, "manuale")
LS_DATA_SCADENZA="#"+string(dw_1.getitemDAte(1, "data_scadenza"), "yyyy-mm-dd")
if isnull(LS_DATA_SCADENZA) then LS_DATA_SCADENZA=""
ll_num_prog=dw_1.getitemnumber(1, "num_progressivo")
if ll_num_prog>0 then ls_num_prog="___"+string(ll_num_prog)
if idt_data_documento<date("2022/01/10") then
	ls_num=ls_manu+mid(ls_barcode, 3,5)+ls_num_prog+LS_DATA_SCADENZA
else //20220110 si cambia si prende tutto il cod_barre
		ls_num=ls_manu+ls_barcode+ls_num_prog+LS_DATA_SCADENZA
end if
closewithreturn(parent, ls_num)


end event

type cb_annulla from commandbutton within w_ins_barcode_pop
integer x = 59
integer y = 488
integer width = 343
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Annulla"
boolean cancel = true
end type

event clicked;close(parent)
end event

type cb_stampa from commandbutton within w_ins_barcode_pop
integer x = 1065
integer y = 52
integer width = 265
integer height = 172
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stampa "
end type

event clicked;string ls_numero
dw_1.accepttext()
ls_numero=dw_1.getitemstring(1, "cod_barre")
openwithparm(w_st_barcode_bol, ls_numero)


end event

type cb_riallinea_bol from commandbutton within w_ins_barcode_pop
integer x = 1061
integer y = 240
integer width = 265
integer height = 172
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "BOL"
end type

event clicked;long ll_id_reg, ll_prog_max, ll_righe
integer i
datastore ds_allinea

select id_registro
into :ll_id_reg
from dba.registro r, dba.azienda a
where r.id_esercizio= a.id_esercizio_proposto
and  r.tipo_registro='GV'
and r.numero=2 and a.id_azienda=1
;
//trovo l'ultimo doc con numero corretto
select max(num_progressivo)
into :ll_prog_max
from dba.documento
where id_registro=:ll_id_reg
and num_progressivo<10000;

ds_allinea=create datastore
ds_allinea.dataobject="d_allinea_prog_bollettine"
ds_allinea.settransobject(sqlca)
ll_righe=ds_allinea.retrieve(ll_id_reg)
for i=1 to ll_righe
	ds_allinea.setitem(i, "num_progressivo", ll_prog_max+i)
next
if ds_allinea.update()=1 then
	commit;
else
	rollback;
	messagebox("Attenzione!", "Salvataggio NON effettuato!")
end if
destroy ds_allinea
end event

