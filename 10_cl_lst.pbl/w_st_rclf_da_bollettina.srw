forward
global type w_st_rclf_da_bollettina from w_stampa_001
end type
type cb_salva from commandbutton within w_st_rclf_da_bollettina
end type
type cb_aggiorna from commandbutton within w_st_rclf_da_bollettina
end type
end forward

global type w_st_rclf_da_bollettina from w_stampa_001
integer x = 23
integer y = 12
cb_salva cb_salva
cb_aggiorna cb_aggiorna
end type
global w_st_rclf_da_bollettina w_st_rclf_da_bollettina

on w_st_rclf_da_bollettina.create
int iCurrent
call super::create
this.cb_salva=create cb_salva
this.cb_aggiorna=create cb_aggiorna
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_salva
this.Control[iCurrent+2]=this.cb_aggiorna
end on

on w_st_rclf_da_bollettina.destroy
call super::destroy
destroy(this.cb_salva)
destroy(this.cb_aggiorna)
end on

event open;call super::open;dw_1.settransobject(sqlca)
dw_1.retrieve()
end event

type dw_1 from w_stampa_001`dw_1 within w_st_rclf_da_bollettina
string dataobject = "d_st_rclf_da_bollettina"
end type

event dw_1::doubleclicked;call super::doubleclicked;long ll_id_doc
w_orafo_documento_ordine_cx w_orafo
s_list_main s_list

if row<=0  then return
s_list.s_identifica[1]="id_documento"
s_list.s_modo=modo_modifica
ll_id_doc=getitemnumber(row, "id_documento")
if ll_id_doc>0 then
	s_list.l_identifica[1]=ll_id_doc
	openwithparm(w_orafo, s_list)
end if
end event

type sle_pg from w_stampa_001`sle_pg within w_st_rclf_da_bollettina
integer x = 1214
integer width = 267
end type

type st_1 from w_stampa_001`st_1 within w_st_rclf_da_bollettina
integer x = 947
end type

type st_2 from w_stampa_001`st_2 within w_st_rclf_da_bollettina
integer x = 2000
end type

type sle_copie from w_stampa_001`sle_copie within w_st_rclf_da_bollettina
integer x = 2147
integer width = 132
end type

type sle_zoom from w_stampa_001`sle_zoom within w_st_rclf_da_bollettina
integer x = 666
end type

type cb_salva_su_file from w_stampa_001`cb_salva_su_file within w_st_rclf_da_bollettina
end type

type cb_7 from w_stampa_001`cb_7 within w_st_rclf_da_bollettina
integer x = 816
end type

type cb_6 from w_stampa_001`cb_6 within w_st_rclf_da_bollettina
integer x = 549
end type

type cb_imp_st from w_stampa_001`cb_imp_st within w_st_rclf_da_bollettina
end type

type cb_stampa from w_stampa_001`cb_stampa within w_st_rclf_da_bollettina
end type

type cb_preview from w_stampa_001`cb_preview within w_st_rclf_da_bollettina
end type

type cb_pg_dopo from w_stampa_001`cb_pg_dopo within w_st_rclf_da_bollettina
integer x = 428
end type

type cb_pg_prima from w_stampa_001`cb_pg_prima within w_st_rclf_da_bollettina
integer x = 318
end type

type cb_1 from w_stampa_001`cb_1 within w_st_rclf_da_bollettina
end type

type cb_salva from commandbutton within w_st_rclf_da_bollettina
integer x = 1510
integer y = 38
integer width = 183
integer height = 77
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

event clicked;integer li_ret

li_ret=dw_1.update()
if li_ret=1 then
	commit;
else
	rollback;
	messagebox(  this.classname() +" - Salvataggio non riuscito!",sqlca.sqlerrtext)
end if
	
	
	
return li_ret
end event

type cb_aggiorna from commandbutton within w_st_rclf_da_bollettina
integer x = 1730
integer y = 38
integer width = 256
integer height = 77
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Aggiorna"
end type

event clicked;dw_1.retrieve()
end event

