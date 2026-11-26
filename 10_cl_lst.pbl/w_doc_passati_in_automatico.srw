forward
global type w_doc_passati_in_automatico from w_stampa
end type
end forward

global type w_doc_passati_in_automatico from w_stampa
end type
global w_doc_passati_in_automatico w_doc_passati_in_automatico

event open;call super::open;

s_date_estr_cc s_date

dw_1.settransobject(sqlca)

s_date=message.powerobjectparm
dw_1.retrieve(s_date.da_data, s_date.a_data)
end event

on w_doc_passati_in_automatico.create
call super::create
end on

on w_doc_passati_in_automatico.destroy
call super::destroy
end on

type pb_1 from w_stampa`pb_1 within w_doc_passati_in_automatico
end type

type cb_preview from w_stampa`cb_preview within w_doc_passati_in_automatico
end type

type dw_1 from w_stampa`dw_1 within w_doc_passati_in_automatico
string dataobject = "d_doc_passati_in_automatico"
end type

event dw_1::doubleclicked;//

long ll_id_doc
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

type pb_salva_su_file from w_stampa`pb_salva_su_file within w_doc_passati_in_automatico
end type

type pb_stampa from w_stampa`pb_stampa within w_doc_passati_in_automatico
end type

type sle_pg from w_stampa`sle_pg within w_doc_passati_in_automatico
end type

type st_1 from w_stampa`st_1 within w_doc_passati_in_automatico
end type

type st_2 from w_stampa`st_2 within w_doc_passati_in_automatico
end type

type sle_copie from w_stampa`sle_copie within w_doc_passati_in_automatico
end type

type sle_zoom from w_stampa`sle_zoom within w_doc_passati_in_automatico
end type

type cb_7 from w_stampa`cb_7 within w_doc_passati_in_automatico
end type

type cb_6 from w_stampa`cb_6 within w_doc_passati_in_automatico
end type

type cb_pg_dopo from w_stampa`cb_pg_dopo within w_doc_passati_in_automatico
end type

type cb_pg_prima from w_stampa`cb_pg_prima within w_doc_passati_in_automatico
end type

type cb_esci from w_stampa`cb_esci within w_doc_passati_in_automatico
end type

