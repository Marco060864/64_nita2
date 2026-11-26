forward
global type w_mostra_righe_k_calo_no_1000 from w_stampa_001
end type
type dw_2 from udw_base within w_mostra_righe_k_calo_no_1000
end type
end forward

global type w_mostra_righe_k_calo_no_1000 from w_stampa_001
integer height = 2044
dw_2 dw_2
end type
global w_mostra_righe_k_calo_no_1000 w_mostra_righe_k_calo_no_1000

on w_mostra_righe_k_calo_no_1000.create
int iCurrent
call super::create
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
end on

on w_mostra_righe_k_calo_no_1000.destroy
call super::destroy
destroy(this.dw_2)
end on

event open;call super::open;long ll_riga
date ldt_data_inizio



dw_2.settransobject(sqlca)
ll_riga=dw_2.insertrow(1)

ldt_data_inizio=date("01-01-"+string(year(today())))

dw_2.setitem(ll_riga, "da_data", ldt_data_inizio)

dw_1.settransobject(sqlca)
dw_1.post retrieve()
end event

event resize;call super::resize;dw_1.height=newheight - 425
end event

type dw_1 from w_stampa_001`dw_1 within w_mostra_righe_k_calo_no_1000
integer y = 352
string dataobject = "d_mostra_ccalo_no_1000_k"
end type

event dw_1::sqlpreview;call super::sqlpreview;date ldt_data
string ls_sql
integer li_ret

ldt_data=dw_2.getitemdate(1, "da_data")

if ldt_data> date("1900-01-01") then
	ls_sql=sqlsyntax
	ls_sql+=" and documento.data_documento>= '"+string(ldt_data, "yyyy/mm/dd") +"' "
	li_ret=setsqlpreview(ls_sql)
end if
end event

type sle_pg from w_stampa_001`sle_pg within w_mostra_righe_k_calo_no_1000
end type

type st_1 from w_stampa_001`st_1 within w_mostra_righe_k_calo_no_1000
end type

type st_2 from w_stampa_001`st_2 within w_mostra_righe_k_calo_no_1000
end type

type sle_copie from w_stampa_001`sle_copie within w_mostra_righe_k_calo_no_1000
end type

type sle_zoom from w_stampa_001`sle_zoom within w_mostra_righe_k_calo_no_1000
end type

type cb_salva_su_file from w_stampa_001`cb_salva_su_file within w_mostra_righe_k_calo_no_1000
end type

type cb_7 from w_stampa_001`cb_7 within w_mostra_righe_k_calo_no_1000
end type

type cb_6 from w_stampa_001`cb_6 within w_mostra_righe_k_calo_no_1000
end type

type cb_imp_st from w_stampa_001`cb_imp_st within w_mostra_righe_k_calo_no_1000
end type

type cb_stampa from w_stampa_001`cb_stampa within w_mostra_righe_k_calo_no_1000
end type

type cb_preview from w_stampa_001`cb_preview within w_mostra_righe_k_calo_no_1000
end type

type cb_pg_dopo from w_stampa_001`cb_pg_dopo within w_mostra_righe_k_calo_no_1000
end type

type cb_pg_prima from w_stampa_001`cb_pg_prima within w_mostra_righe_k_calo_no_1000
end type

type cb_1 from w_stampa_001`cb_1 within w_mostra_righe_k_calo_no_1000
end type

type dw_2 from udw_base within w_mostra_righe_k_calo_no_1000
integer x = 64
integer y = 160
integer width = 763
integer height = 124
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_da_data_per_righe"
boolean vscrollbar = false
end type

event itemchanged;call super::itemchanged;dw_1.post retrieve()
end event

