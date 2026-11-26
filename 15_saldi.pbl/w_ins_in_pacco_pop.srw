forward
global type w_ins_in_pacco_pop from w_001
end type
type dw_1 from udw_base within w_ins_in_pacco_pop
end type
type cb_ok from commandbutton within w_ins_in_pacco_pop
end type
type cb_annulla from commandbutton within w_ins_in_pacco_pop
end type
end forward

global type w_ins_in_pacco_pop from w_001
integer width = 1309
integer height = 522
windowtype windowtype = response!
dw_1 dw_1
cb_ok cb_ok
cb_annulla cb_annulla
end type
global w_ins_in_pacco_pop w_ins_in_pacco_pop

type variables
long il_id_riga
end variables

on w_ins_in_pacco_pop.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_ok=create cb_ok
this.cb_annulla=create cb_annulla
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.cb_annulla
end on

on w_ins_in_pacco_pop.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_ok)
destroy(this.cb_annulla)
end on

event open;call super::open;
dw_1.settransobject(sqlca)
dw_1.insertrow(1)

il_id_riga=message.doubleparm


end event

type st_1 from w_001`st_1 within w_ins_in_pacco_pop
end type

type dw_1 from udw_base within w_ins_in_pacco_pop
integer x = 29
integer y = 26
integer width = 1229
integer height = 230
boolean bringtotop = true
string dataobject = "d_ins_in_pacco_ext"
boolean vscrollbar = false
end type

event itemchanged;call super::itemchanged;//
end event

event editchanged;call super::editchanged;long ll_id_pacco

if len(data)=13 then
	select id_pacco
	into :ll_id_pacco
	from dba.pacco
	where codice=:data
	;
	if ll_id_pacco>0 then
		insert into dba.pacco_bollettina (id_pacco, id_bollettina)
		values(:ll_id_pacco, :il_id_riga)
		;
		if sqlca.sqlcode=0 then
			commit;
			cb_ok.trigger event clicked()
		else
			rollback;
			messagebox("Attenzione!", "La riga NON è stata inserita nel pacco "+data)
		end if
	end if
end if
end event

type cb_ok from commandbutton within w_ins_in_pacco_pop
integer x = 907
integer y = 282
integer width = 344
integer height = 99
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Chiudi"
boolean default = true
end type

event clicked;string ls_manu, ls_barcode, ls_num
DW_1.ACCEPTTEXT()
ls_barcode=dw_1.getitemstring(1, "cod_barre")
ls_manu=dw_1.getitemstring(1, "manuale")
ls_num=ls_manu+mid(ls_barcode, 3,5)
closewithreturn(parent, ls_num)


end event

type cb_annulla from commandbutton within w_ins_in_pacco_pop
integer x = 59
integer y = 291
integer width = 344
integer height = 99
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

