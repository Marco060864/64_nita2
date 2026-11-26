forward
global type w_provvigioni_rpt from w_stampa_001
end type
type cbx_1 from checkbox within w_provvigioni_rpt
end type
type cb_2 from commandbutton within w_provvigioni_rpt
end type
end forward

global type w_provvigioni_rpt from w_stampa_001
string title = "Stampa Provvigioni"
cbx_1 cbx_1
cb_2 cb_2
end type
global w_provvigioni_rpt w_provvigioni_rpt

type variables
s_param_articoli is_parametri
end variables

on w_provvigioni_rpt.create
int iCurrent
call super::create
this.cbx_1=create cbx_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_1
this.Control[iCurrent+2]=this.cb_2
end on

on w_provvigioni_rpt.destroy
call super::destroy
destroy(this.cbx_1)
destroy(this.cb_2)
end on

event open;string ls_test
long ll_id_sog_com_agente

setredraw(false)
is_parametri=message.powerobjectparm


if isnull(is_parametri.da_sog_comm) then is_parametri.da_sog_comm='0000000000000000000000000'
if isnull(is_parametri.a_sog_comm) then is_parametri.a_sog_comm='ZZZZZZZZZZZZZZZZZZZZZZZZZ'


dw_1.dataobject=is_parametri.tipo_stampa
dw_1.settransobject(sqlca)

if is_parametri.tipo_stampa="d_provv_originale_rpt" then
	//katy
	select id_sog_com_capo_area
	into :ll_id_sog_com_agente
	from dba.gruppo_agenti
	where id_gruppo_agenti=:is_parametri.ll_magazzino;
	dw_1.retrieve(is_parametri.ll_magazzino, is_parametri.da_data, is_parametri.a_data)
else
	//fabbrini
	dw_1.retrieve(is_parametri.ll_magazzino, is_parametri.da_data, is_parametri.a_data, is_parametri.da_scadenza,is_parametri.a_scadenza)
end if

end event

event resize;dw_1.height=newheight - 300
dw_1.width=newwidth - 75
end event

event ue_post_open;call super::ue_post_open;
dw_1.groupcalc()
setredraw(true)
end event

type dw_1 from w_stampa_001`dw_1 within w_provvigioni_rpt
integer y = 264
integer height = 1412
end type

event dw_1::doubleclicked;long ll_id_doc
w_orafo_documento_ordine_cx w_orafo
s_list_main s_list
if row<=0  then return
s_list.s_identifica[1]="id_documento"
s_list.s_modo=modo_modifica
ll_id_doc=getitemnumber(row, "riga_documento_id_documento")
if ll_id_doc>0 then
	s_list.l_identifica[1]=ll_id_doc
	openwithparm(w_orafo, s_list)
end if
end event

type sle_pg from w_stampa_001`sle_pg within w_provvigioni_rpt
end type

type st_1 from w_stampa_001`st_1 within w_provvigioni_rpt
end type

type st_2 from w_stampa_001`st_2 within w_provvigioni_rpt
end type

type sle_copie from w_stampa_001`sle_copie within w_provvigioni_rpt
end type

type sle_zoom from w_stampa_001`sle_zoom within w_provvigioni_rpt
end type

type cb_salva_su_file from w_stampa_001`cb_salva_su_file within w_provvigioni_rpt
end type

type cb_7 from w_stampa_001`cb_7 within w_provvigioni_rpt
end type

type cb_6 from w_stampa_001`cb_6 within w_provvigioni_rpt
end type

type cb_imp_st from w_stampa_001`cb_imp_st within w_provvigioni_rpt
end type

type cb_stampa from w_stampa_001`cb_stampa within w_provvigioni_rpt
end type

type cb_preview from w_stampa_001`cb_preview within w_provvigioni_rpt
end type

type cb_pg_dopo from w_stampa_001`cb_pg_dopo within w_provvigioni_rpt
end type

type cb_pg_prima from w_stampa_001`cb_pg_prima within w_provvigioni_rpt
end type

type cb_1 from w_stampa_001`cb_1 within w_provvigioni_rpt
end type

type cbx_1 from checkbox within w_provvigioni_rpt
integer x = 91
integer y = 164
integer width = 462
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Vedi dettaglio"
end type

event clicked;integer i

if checked then
	dw_1.modify("datawindow.detail.height = 76")
	dw_1.modify("datawindow.header.1.height = 72")
else
	dw_1.modify("datawindow.detail.height = 0")
	dw_1.modify("datawindow.header.1.height = 0")
end if
end event

type cb_2 from commandbutton within w_provvigioni_rpt
integer x = 3264
integer y = 152
integer width = 261
integer height = 88
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Anticipi"
end type

event clicked;//is_parametri.ll_magazzino è id_gruppo_agenti


is_parametri.prov_incassato=dw_1.getitemdecimal(1, "c_tot_prov_inc")
is_parametri.provvigione=dw_1.getitemdecimal(1,"c_tot_prov")

openwithparm(w_acconto_agente_gd, is_parametri)
end event

