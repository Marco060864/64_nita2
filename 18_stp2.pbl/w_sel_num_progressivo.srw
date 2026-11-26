forward
global type w_sel_num_progressivo from w_001
end type
type dw_1 from udw_base within w_sel_num_progressivo
end type
type cb_stampa from commandbutton within w_sel_num_progressivo
end type
type cb_chiudi from commandbutton within w_sel_num_progressivo
end type
end forward

global type w_sel_num_progressivo from w_001
integer x = 2801
integer y = 602
integer width = 1031
integer height = 566
string title = "Registrazioni in Entrata del Giorno"
boolean controlmenu = false
boolean resizable = true
windowtype windowtype = main!
dw_1 dw_1
cb_stampa cb_stampa
cb_chiudi cb_chiudi
end type
global w_sel_num_progressivo w_sel_num_progressivo

type variables
date idt_data_in, idt_data_fine
long il_id_esercizio, il_id_registro
end variables

event open;call super::open;date ld_da_data, ld_a_data
long ll_num_prog

dw_1.settransobject(sqlca)

dw_1.insertrow(1)
dw_1.post setfocus()
dw_1.setcolumn(1)

ld_da_data=date("01/01/"+string(year(today())))
ld_a_data=today()

select data_inizio,data_fine,  id_esercizio 
into :idt_data_in, :idt_data_fine,  :il_id_esercizio
from esercizio 
where data_inizio<=:ld_da_data
and data_fine>=:ld_da_data;

select id_registro
into :il_id_registro
from registro
where tipo_registro='DA'
and numero=1
and id_esercizio=:il_id_esercizio
;

select min(num_progressivo)
into :ll_num_prog
from dba.documento
where id_registro=:il_id_registro
and data_registrazione=:ld_a_data
;

dw_1.setitem(1, 1, ll_num_prog)
end event

on w_sel_num_progressivo.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_stampa=create cb_stampa
this.cb_chiudi=create cb_chiudi
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_stampa
this.Control[iCurrent+3]=this.cb_chiudi
end on

on w_sel_num_progressivo.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_stampa)
destroy(this.cb_chiudi)
end on

type st_1 from w_001`st_1 within w_sel_num_progressivo
end type

type dw_1 from udw_base within w_sel_num_progressivo
integer x = 176
integer y = 51
integer width = 614
integer height = 179
boolean bringtotop = true
string dataobject = "d_sel_num_progressivo"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

type cb_stampa from commandbutton within w_sel_num_progressivo
integer x = 585
integer y = 282
integer width = 263
integer height = 90
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stampa"
end type

event clicked;string ls_da_cod_sog_comm, ls_a_cod_sog_comm, ls_parametri, ls_a_categoria
string ls_a_prof, ls_da_prof, ls_tipo_stampa, ls_tipo_reg, ls_cod_ese
integer li_righe, i
date ld_da_data,ld_a_data, ldt_data_in,ldt_data_fine
s_param_articoli str_param
long ll_id_registro, ll_id_esercizio

dw_1.accepttext()


	

ls_tipo_stampa="M"

str_param.id_cat_codifica=dw_1.getitemnumber(1, "Num_Progressivo")
str_param.da_data=idt_data_in
str_param.a_data=today()
setnull(str_param.da_cod_art)
setnull(str_param.da_sog_comm)
setnull(str_param.a_cod_art)
setnull(str_param.a_sog_comm)

str_param.li_titolo[4]=il_id_registro
str_param.li_titolo[3] = il_id_registro
str_param.li_titolo[1] = il_id_esercizio
str_param.li_titolo[2] = il_id_esercizio

str_param.solo_preziosi=ls_tipo_stampa
setnull(str_param.tipo_stampa)

str_param.inizio_es=idt_data_in



OpenWithParm(w_or_doc_fo_peso_metalli_rpt, str_param)
end event

event rbuttondown;string ls_da_cod_sog_comm, ls_a_cod_sog_comm, ls_parametri, ls_a_categoria
string ls_a_prof, ls_da_prof, ls_tipo_stampa, ls_tipo_reg, ls_cod_ese
integer li_righe, i
date ld_da_data,ld_a_data, ldt_data_in,ldt_data_fine
s_param_articoli str_param
long ll_id_registro, ll_id_esercizio

dw_1.accepttext()


	

ls_tipo_stampa="T"

str_param.id_cat_codifica=dw_1.getitemnumber(1, "Num_Progressivo")
str_param.da_data=idt_data_in
str_param.a_data=today()
setnull(str_param.da_cod_art)
setnull(str_param.da_sog_comm)
setnull(str_param.a_cod_art)
setnull(str_param.a_sog_comm)

str_param.li_titolo[4]=il_id_registro
str_param.li_titolo[3] = il_id_registro
str_param.li_titolo[1] = il_id_esercizio
str_param.li_titolo[2] = il_id_esercizio

str_param.solo_preziosi=ls_tipo_stampa
setnull(str_param.tipo_stampa)

str_param.inizio_es=idt_data_in



OpenWithParm(w_or_doc_da_fatturare_rpt, str_param)
end event

type cb_chiudi from commandbutton within w_sel_num_progressivo
integer x = 88
integer y = 282
integer width = 322
integer height = 90
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Chiudi"
end type

event clicked;close(parent)
end event

