forward
global type w_stampa_dis_banca_rpt from w_stampa_001
end type
end forward

global type w_stampa_dis_banca_rpt from w_stampa_001
end type
global w_stampa_dis_banca_rpt w_stampa_dis_banca_rpt

on w_stampa_dis_banca_rpt.create
call super::create
end on

on w_stampa_dis_banca_rpt.destroy
call super::destroy
end on

event open;long ll_id_dis_banca
dw_1.settransobject(sqlca)
ll_id_dis_banca=message.doubleparm

if ll_id_dis_banca>0 then
	dw_1.retrieve(ll_id_dis_banca)
end if
	
end event

type dw_1 from w_stampa_001`dw_1 within w_stampa_dis_banca_rpt
string DataObject="d_distinta_banca_rpt"
end type

