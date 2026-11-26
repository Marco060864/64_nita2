forward
global type w_saldo_legato_o_fino from w_semplice_gd
end type
end forward

global type w_saldo_legato_o_fino from w_semplice_gd
integer width = 2880
end type
global w_saldo_legato_o_fino w_saldo_legato_o_fino

on w_saldo_legato_o_fino.create
call super::create
end on

on w_saldo_legato_o_fino.destroy
call super::destroy
end on

event open;call super::open;long ll_num_righe
datastore ds_lista_sog
long ll_id_sog
integer i
date ldt_data
//datawindowchild dwc_sog
//
//dw_1.getchild( "id_sog_commerciale", dwc_sog)
//CONNECT USING SQLCA;
//dwc_sog.settransobject(sqlca)
//dwc_sog.retrieve()
ll_num_righe=dw_1.rowcount()

if ll_num_righe<=0 then
	ds_lista_sog=create datastore
	ds_lista_sog.dataobject="ds_lista_cl_fo_movimentati"
	ds_lista_sog.settransobject(sqlca)
	ldt_data=date(string(year(today()))+"/01/01")
	ll_num_righe=ds_lista_sog.retrieve(ldt_data)
	for i= 1 to ll_num_righe
		ll_id_sog=ds_lista_sog.getitemnumber(i, "id_sog_commerciale")	
		dw_1.insertrow(i)
		dw_1.setitem(i, "id_sog_commerciale", ll_id_sog)
		dw_1.setitem(i, "fino_o_legato", "L")
	next
	dw_1.sort()
	destroy ds_lista_sog
end if
end event

type cb_stampa from w_semplice_gd`cb_stampa within w_saldo_legato_o_fino
end type

type cb_ricerca from w_semplice_gd`cb_ricerca within w_saldo_legato_o_fino
end type

type cb_primo from w_semplice_gd`cb_primo within w_saldo_legato_o_fino
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_saldo_legato_o_fino
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_saldo_legato_o_fino
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_saldo_legato_o_fino
end type

type dw_1 from w_semplice_gd`dw_1 within w_saldo_legato_o_fino
integer width = 2743
string dataobject = "d_saldo_legato_o_fino"
end type

type cb_inserisci from w_semplice_gd`cb_inserisci within w_saldo_legato_o_fino
end type

type cb_salva from w_semplice_gd`cb_salva within w_saldo_legato_o_fino
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_saldo_legato_o_fino
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_saldo_legato_o_fino
end type

type cb_ok from w_semplice_gd`cb_ok within w_saldo_legato_o_fino
end type

