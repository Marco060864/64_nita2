forward
global type w_fab_acc_k_rpt from w_stampa
end type
end forward

global type w_fab_acc_k_rpt from w_stampa
integer width = 3707
end type
global w_fab_acc_k_rpt w_fab_acc_k_rpt

on w_fab_acc_k_rpt.create
call super::create
end on

on w_fab_acc_k_rpt.destroy
call super::destroy
end on

event open;call super::open;udw_base dw
long ll_id_doc_sald, ll_qta_distinta, ll_qta,ll_id_riga_bol, ll_riga_inserita, ll_breakrow
integer i
string ls_acc, ls_num_sald, ls_num_bol
date ldt_data_bol, ldt_data_sald,ldt_data_lista
boolean lb_found

dw_1.settransobject(sqlca)

if isvalid(message) then
	dw=message.powerobjectparm
	dw.setsort("accessorio")
	dw.sort()
	dw.groupcalc()
	
	
	
	lb_found = false
	ll_breakrow = -1
	DO    
		ll_breakrow = ll_breakrow + 1
		ll_breakrow = dw.FindGroupChange(ll_breakrow, 1)    
		if ll_breakrow<=0 then exit  // If no breaks are found, exit.    
		//ls_accessorio=dw.getitemstring(ll_breakrow, "accessorio")
		//ldc_tot_pezzi=dw.getitemdecimal(ll_breakrow, "c_tot_gruppo")
		ls_acc=dw.getitemstring(ll_breakrow, "accessorio")
			ll_qta=dw.getitemnumber(ll_breakrow, "c_tot_gruppo")
			ll_qta_distinta= dw.getitemnumber(ll_breakrow, "qta_distinta")
			ll_id_doc_sald= dw.getitemnumber(ll_breakrow, "id_doc_sald")
			ll_id_riga_bol= dw.getitemnumber(ll_breakrow, "id_riga_bol_provenienza")
			ldt_data_lista= dw.getitemdate(ll_breakrow, "data_lista")
			select num_documento, data_documento
			into :ls_num_sald, :ldt_data_sald
			from dba.documento
			where id_documento=:ll_id_doc_sald
			;
			select num_documento, data_documento
			into :ls_num_bol, :ldt_data_bol
			from dba.documento d, dba.riga_documento r where d.id_documento=r.id_documento and id_riga_documento=:ll_id_riga_bol
			;
		ll_riga_inserita=dw_1.insertrow(0)
		dw_1.setitem(ll_riga_inserita, "accessorio", ls_acc)
		dw_1.setitem(ll_riga_inserita, "qta_distinta", ll_qta_distinta)
		dw_1.setitem(ll_riga_inserita, "qta", ll_qta/ll_qta_distinta)
		dw_1.setitem(ll_riga_inserita, "num_bol", ls_num_bol)
		dw_1.setitem(ll_riga_inserita, "data_bol", ldt_data_bol)
		dw_1.setitem(ll_riga_inserita, "num_sald", ls_num_sald)
		dw_1.setitem(ll_riga_inserita, "data_sald", ldt_data_sald)
		dw_1.setitem(ll_riga_inserita, "data_lista", ldt_data_lista)
	
	LOOP WHILE ll_breakrow > 0
	
//	
//	
//	for i=1 to dw.rowcount()
//		ls_acc=dw.getitemstring(i, "accessorio")
//		ll_qta=dw.getitemnumber(i, "qta")
//		ll_qta_distinta= dw.getitemnumber(i, "qta_distinta")
//		ll_id_doc_sald= dw.getitemnumber(i, "id_doc_sald")
//		ll_id_riga_bol= dw.getitemnumber(i, "id_riga_bol_provenienza")
//		select num_documento, data_documento
//		into :ls_num_sald, :ldt_data_sald
//		from dba.documento
//		where id_documento=:ll_id_doc_sald
//		;
//		select num_documento, data_documento
//		into :ls_num_bol, :ldt_data_bol
//		from dba.documento d, dba.riga_documento r where d.id_documento=r.id_documento and id_riga_documento=:ll_id_riga_bol
//		;
//		ll_riga_inserita=dw_1.insertrow(0)
//		dw_1.setitem(ll_riga_inserita, "accessorio", ls_acc)
//		dw_1.setitem(ll_riga_inserita, "qta_distinta", ll_qta_distinta)
//		dw_1.setitem(ll_riga_inserita, "qta", ll_qta)
//		dw_1.setitem(ll_riga_inserita, "num_bol", ls_num_bol)
//		dw_1.setitem(ll_riga_inserita, "data_bol", ldt_data_bol)
//		dw_1.setitem(ll_riga_inserita, "num_sald", ls_num_sald)
//		dw_1.setitem(ll_riga_inserita, "data_sald", ldt_data_sald)
//	next 	
	
end if


end event

type pb_1 from w_stampa`pb_1 within w_fab_acc_k_rpt
end type

type cb_preview from w_stampa`cb_preview within w_fab_acc_k_rpt
end type

type dw_1 from w_stampa`dw_1 within w_fab_acc_k_rpt
integer width = 3575
string dataobject = "d_fab_acc_k_rpt"
end type

type pb_salva_su_file from w_stampa`pb_salva_su_file within w_fab_acc_k_rpt
end type

type pb_stampa from w_stampa`pb_stampa within w_fab_acc_k_rpt
end type

type sle_pg from w_stampa`sle_pg within w_fab_acc_k_rpt
end type

type st_1 from w_stampa`st_1 within w_fab_acc_k_rpt
end type

type st_2 from w_stampa`st_2 within w_fab_acc_k_rpt
end type

type sle_copie from w_stampa`sle_copie within w_fab_acc_k_rpt
end type

type sle_zoom from w_stampa`sle_zoom within w_fab_acc_k_rpt
end type

type cb_7 from w_stampa`cb_7 within w_fab_acc_k_rpt
end type

type cb_6 from w_stampa`cb_6 within w_fab_acc_k_rpt
end type

type cb_pg_dopo from w_stampa`cb_pg_dopo within w_fab_acc_k_rpt
end type

type cb_pg_prima from w_stampa`cb_pg_prima within w_fab_acc_k_rpt
end type

type cb_esci from w_stampa`cb_esci within w_fab_acc_k_rpt
end type

