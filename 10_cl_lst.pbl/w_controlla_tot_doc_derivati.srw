forward
global type w_controlla_tot_doc_derivati from w_stampa
end type
end forward

global type w_controlla_tot_doc_derivati from w_stampa
end type
global w_controlla_tot_doc_derivati w_controlla_tot_doc_derivati

event open;call super::open;long ll_id_doc


dw_1.settransobject(sqlca)
ll_id_doc=message.doubleparm
if ll_id_doc>0 then 
	dw_1.retrieve(ll_id_doc)
end if

end event

on w_controlla_tot_doc_derivati.create
call super::create
end on

on w_controlla_tot_doc_derivati.destroy
call super::destroy
end on

event ue_postopen;call super::ue_postopen;long ll_id_doc_ddt
integer i
decimal ldc_tot_imponibile

for i=1 to dw_1.rowcount()
	ll_id_doc_ddt=dw_1.getitemnumber(i, "id_doc_ddt")
	if ll_id_doc_ddt> 0 then
		select sum(val_tot_imp_l)
		into :ldc_tot_imponibile
		from dba.cast_iva_documento
		where id_documento=:ll_id_doc_ddt;
		dw_1.setitem(i, "c_tot_ddt", ldc_tot_imponibile)
	end if
next
end event

type pb_1 from w_stampa`pb_1 within w_controlla_tot_doc_derivati
end type

type cb_preview from w_stampa`cb_preview within w_controlla_tot_doc_derivati
end type

type dw_1 from w_stampa`dw_1 within w_controlla_tot_doc_derivati
string dataobject = "d_controlla_tot_doc_derivati"
end type

event dw_1::doubleclicked;long ll_id_doc
w_orafo_documento_ordine_cx w_orafo
s_list_main s_list

if row>0 then
	s_list.s_identifica[1]="id_documento"
	s_list.s_modo=modo_modifica
	ll_id_doc=getitemnumber(row, "id_doc_ddt")
	if ll_id_doc>0 then
		s_list.l_identifica[1]=ll_id_doc
		openwithparm(w_orafo, s_list)
	end if
END IF
end event

event dw_1::rbuttondown;call super::rbuttondown;long ll_id_fattura

if row> 0 then

	ll_id_fattura=getitemnumber(row, "id_doc_fattura")
	openwithparm(w_dett_controlla_ddt_derivati, ll_id_fattura)
	
end if
end event

type pb_salva_su_file from w_stampa`pb_salva_su_file within w_controlla_tot_doc_derivati
end type

type pb_stampa from w_stampa`pb_stampa within w_controlla_tot_doc_derivati
end type

type sle_pg from w_stampa`sle_pg within w_controlla_tot_doc_derivati
end type

type st_1 from w_stampa`st_1 within w_controlla_tot_doc_derivati
end type

type st_2 from w_stampa`st_2 within w_controlla_tot_doc_derivati
end type

type sle_copie from w_stampa`sle_copie within w_controlla_tot_doc_derivati
end type

type sle_zoom from w_stampa`sle_zoom within w_controlla_tot_doc_derivati
end type

type cb_7 from w_stampa`cb_7 within w_controlla_tot_doc_derivati
end type

type cb_6 from w_stampa`cb_6 within w_controlla_tot_doc_derivati
end type

type cb_pg_dopo from w_stampa`cb_pg_dopo within w_controlla_tot_doc_derivati
end type

type cb_pg_prima from w_stampa`cb_pg_prima within w_controlla_tot_doc_derivati
end type

type cb_esci from w_stampa`cb_esci within w_controlla_tot_doc_derivati
end type

