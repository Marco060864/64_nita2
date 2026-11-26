forward
global type w_esi_disp_locazione_wz from w_wiz_main
end type
type cb_ok from commandbutton within w_esi_disp_locazione_wz
end type
type dw_esi_disp_locazione_ext_gd from u_dw_ext_main within w_esi_disp_locazione_wz
end type
type dw_esi_disp_locazione_sp_ff from u_dw_ext_main within w_esi_disp_locazione_wz
end type
end forward

global type w_esi_disp_locazione_wz from w_wiz_main
int X=833
int Y=373
int Width=1916
int Height=1593
WindowType WindowType=response!
boolean TitleBar=true
string Title="Esistenza e Disponibilità "
event ue_load_righe_qta ( )
event ue_load_esistenza ( )
event ue_load_disponibilita ( )
cb_ok cb_ok
dw_esi_disp_locazione_ext_gd dw_esi_disp_locazione_ext_gd
dw_esi_disp_locazione_sp_ff dw_esi_disp_locazione_sp_ff
end type
global w_esi_disp_locazione_wz w_esi_disp_locazione_wz

type variables
s_any_array	istr_any_array
end variables

event ue_load_righe_qta;
long		ll_size, ll_nr_row, ll_row

ll_size= UpperBound(istr_any_array.s_array)
If istr_any_array.s_array[ll_size] = "esistenza" then
	event ue_load_esistenza()
else
	event ue_load_disponibilita()
end if

end event

event ue_load_esistenza;
long 		ll_row, ll_new_row
decimal	ldc_valore

ll_row=dw_esi_disp_locazione_sp_ff.GetRow()
if not(IsNull(ll_row) OR ll_row=0) then
	ll_new_row= dw_esi_disp_locazione_ext_gd.InsertRow(0)
	dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"nome", "Qta Rimanenza Iniziale")
	dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"segno", "+")
	ldc_valore=dw_esi_disp_locazione_sp_ff.GetItemNumber(ll_row,"qta_rim_iniziale")
	dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"quantita",ldc_valore)
	dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"moltiplicando",1)

	ll_new_row= dw_esi_disp_locazione_ext_gd.InsertRow(0)
	dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"nome", "Carichi Fiscali")
	dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"segno", "+")
	ldc_valore=dw_esi_disp_locazione_sp_ff.GetItemNumber(ll_row,"qta_caricata")
	dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"quantita",ldc_valore)
	ll_new_row= dw_esi_disp_locazione_ext_gd.InsertRow(0)
	dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"moltiplicando",1)

	dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"nome", "Scarichi Fiscali")
	dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"segno", "-")
	ldc_valore=dw_esi_disp_locazione_sp_ff.GetItemNumber(ll_row,"qta_scaricata")
	dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"quantita",ldc_valore)
	dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"moltiplicando",-1)
end if
	
end event

event ue_load_disponibilita;
long 		ll_row, ll_new_row
string	ls_segno
decimal	ldc_valore

ll_row=dw_esi_disp_locazione_sp_ff.GetRow()
if not(IsNull(ll_row) OR ll_row=0) then
	CHOOSE CASE dw_esi_disp_locazione_sp_ff.GetItemNumber(ll_row,"qta_rim_iniziale_sg")		
		CASE 1				
			ll_new_row= dw_esi_disp_locazione_ext_gd.InsertRow(0)
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"nome", "Qta Rimanenza Iniziale")
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"segno", "+")
			ldc_valore=dw_esi_disp_locazione_sp_ff.GetItemNumber(ll_row,"qta_rim_iniziale")
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"moltiplicando",1)
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"quantita",ldc_valore)
		CASE -1
			ll_new_row= dw_esi_disp_locazione_ext_gd.InsertRow(0)
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"nome", "Qta Rimanenza Iniziale")
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"segno", "-")
			ldc_valore=dw_esi_disp_locazione_sp_ff.GetItemNumber(ll_row,"qta_rim_iniziale")
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"moltiplicando",-1)
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"quantita",ldc_valore)
	END CHOOSE
	
	CHOOSE CASE dw_esi_disp_locazione_sp_ff.GetItemNumber(ll_row,"qta_caricata_sg")		
		CASE 1
			ll_new_row= dw_esi_disp_locazione_ext_gd.InsertRow(0)
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"nome", "Carichi Fiscali")
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"segno", "+")
			ldc_valore=dw_esi_disp_locazione_sp_ff.GetItemNumber(ll_row,"qta_caricata")
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"moltiplicando",1)
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"quantita",ldc_valore)
		CASE -1
			ll_new_row= dw_esi_disp_locazione_ext_gd.InsertRow(0)
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"nome", "Carichi Fiscali")
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"segno", "-")
			ldc_valore=dw_esi_disp_locazione_sp_ff.GetItemNumber(ll_row,"qta_caricata")
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"moltiplicando",-1)
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"quantita",ldc_valore)
	END CHOOSE

	CHOOSE CASE dw_esi_disp_locazione_sp_ff.GetItemNumber(ll_row,"qta_scaricata_sg")		
		CASE 1
			ll_new_row= dw_esi_disp_locazione_ext_gd.InsertRow(0)
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"nome", "Scarichi Fiscali")
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"segno", "+")
			ldc_valore=dw_esi_disp_locazione_sp_ff.GetItemNumber(ll_row,"qta_scaricata")
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"moltiplicando",1)
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"quantita",ldc_valore)
		CASE -1
			ll_new_row= dw_esi_disp_locazione_ext_gd.InsertRow(0)
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"nome", "Scarichi Fiscali")
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"segno", "-")
			ldc_valore=dw_esi_disp_locazione_sp_ff.GetItemNumber(ll_row,"qta_scaricata")
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"moltiplicando",-1)
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"quantita",ldc_valore)
	END CHOOSE

	CHOOSE CASE dw_esi_disp_locazione_sp_ff.GetItemNumber(ll_row,"qta_ord_clienti_sg")		
		CASE 1
			ll_new_row= dw_esi_disp_locazione_ext_gd.InsertRow(0)
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"nome", "Ordinato Clienti")
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"segno", "+")
			ldc_valore=dw_esi_disp_locazione_sp_ff.GetItemNumber(ll_row,"qta_ord_clienti")
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"moltiplicando",1)
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"quantita",ldc_valore)
		CASE -1
			ll_new_row= dw_esi_disp_locazione_ext_gd.InsertRow(0)
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"nome", "Ordinato Clienti")
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"segno", "-")
			ldc_valore=dw_esi_disp_locazione_sp_ff.GetItemNumber(ll_row,"qta_ord_clienti")
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"moltiplicando",-1)
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"quantita",ldc_valore)
	END CHOOSE

	CHOOSE CASE dw_esi_disp_locazione_sp_ff.GetItemNumber(ll_row,"qta_ord_fornitori_sg")		
		CASE 1
			ll_new_row= dw_esi_disp_locazione_ext_gd.InsertRow(0)
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"nome", "Ordinato Fornitori")
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"segno", "+")
			ldc_valore=dw_esi_disp_locazione_sp_ff.GetItemNumber(ll_row,"qta_ord_fornitori")
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"moltiplicando",1)
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"quantita",ldc_valore)
		CASE -1
			ll_new_row= dw_esi_disp_locazione_ext_gd.InsertRow(0)
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"nome", "Ordinato Fornitori")
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"segno", "-")
			ldc_valore=dw_esi_disp_locazione_sp_ff.GetItemNumber(ll_row,"qta_ord_fornitori")
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"moltiplicando",-1)
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"quantita",ldc_valore)
	END CHOOSE

	CHOOSE CASE dw_esi_disp_locazione_sp_ff.GetItemNumber(ll_row,"qta_vis_clienti_sg")		
		CASE 1
			ll_new_row= dw_esi_disp_locazione_ext_gd.InsertRow(0)
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"nome", "Visione Clienti")
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"segno", "+")
			ldc_valore=dw_esi_disp_locazione_sp_ff.GetItemNumber(ll_row,"qta_vis_clienti")
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"moltiplicando",1)
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"quantita",ldc_valore)
		CASE -1
			ll_new_row= dw_esi_disp_locazione_ext_gd.InsertRow(0)
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"nome", "Visione Clienti")
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"segno", "-")
			ldc_valore=dw_esi_disp_locazione_sp_ff.GetItemNumber(ll_row,"qta_vis_clienti")
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"moltiplicando",-1)
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"quantita",ldc_valore)
	END CHOOSE

	CHOOSE CASE dw_esi_disp_locazione_sp_ff.GetItemNumber(ll_row,"qta_vis_fornitori_sg")		
		CASE 1
			ll_new_row= dw_esi_disp_locazione_ext_gd.InsertRow(0)
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"nome", "Visione Fornitori")
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"segno", "+")
			ldc_valore=dw_esi_disp_locazione_sp_ff.GetItemNumber(ll_row,"qta_vis_fornitori")
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"moltiplicando",1)
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"quantita",ldc_valore)
		CASE -1
			ll_new_row= dw_esi_disp_locazione_ext_gd.InsertRow(0)
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"nome", "Visione Fornitori")
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"segno", "-")
			ldc_valore=dw_esi_disp_locazione_sp_ff.GetItemNumber(ll_row,"qta_vis_fornitori")
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"moltiplicando",-1)
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"quantita",ldc_valore)
	END CHOOSE

	CHOOSE CASE dw_esi_disp_locazione_sp_ff.GetItemNumber(ll_row,"qta_imp_produzione_sg")		
		CASE 1
			ll_new_row= dw_esi_disp_locazione_ext_gd.InsertRow(0)
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"nome", "Impegno Produzione")
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"segno", "+")
			ldc_valore=dw_esi_disp_locazione_sp_ff.GetItemNumber(ll_row,"qta_imp_produzione")
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"moltiplicando",1)
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"quantita",ldc_valore)
		CASE -1
			ll_new_row= dw_esi_disp_locazione_ext_gd.InsertRow(0)
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"nome", "Impegno Produzione")
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"segno", "-")
			ldc_valore=dw_esi_disp_locazione_sp_ff.GetItemNumber(ll_row,"qta_imp_produzione")
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"moltiplicando",-1)
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"quantita",ldc_valore)
	END CHOOSE

	CHOOSE CASE dw_esi_disp_locazione_sp_ff.GetItemNumber(ll_row,"qta_ord_produzione_sg")		
		CASE 1
			ll_new_row= dw_esi_disp_locazione_ext_gd.InsertRow(0)
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"nome", "Ordine Produzione")
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"segno", "+")
			ldc_valore=dw_esi_disp_locazione_sp_ff.GetItemNumber(ll_row,"qta_ord_produzione")
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"moltiplicando",1)
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"quantita",ldc_valore)
		CASE -1
			ll_new_row= dw_esi_disp_locazione_ext_gd.InsertRow(0)
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"nome", "Ordine Produzione")
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"segno", "-")
			ldc_valore=dw_esi_disp_locazione_sp_ff.GetItemNumber(ll_row,"qta_ord_produzione")
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"moltiplicando",-1)
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"quantita",ldc_valore)
	END CHOOSE

	CHOOSE CASE dw_esi_disp_locazione_sp_ff.GetItemNumber(ll_row,"qta_cl_clienti_sg")		
		CASE 1
			ll_new_row= dw_esi_disp_locazione_ext_gd.InsertRow(0)
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"nome", "Conto Lavoro Clienti")
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"segno", "+")
			ldc_valore=dw_esi_disp_locazione_sp_ff.GetItemNumber(ll_row,"qta_cl_clienti")
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"moltiplicando",1)
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"quantita",ldc_valore)
		CASE -1
			ll_new_row= dw_esi_disp_locazione_ext_gd.InsertRow(0)
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"nome", "Conto Lavoro Clienti")
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"segno", "-")
			ldc_valore=dw_esi_disp_locazione_sp_ff.GetItemNumber(ll_row,"qta_cl_clienti")
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"moltiplicando",-1)
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"quantita",ldc_valore)
	END CHOOSE

	CHOOSE CASE dw_esi_disp_locazione_sp_ff.GetItemNumber(ll_row,"qta_cl_fornitori_sg")		
		CASE 1
			ll_new_row= dw_esi_disp_locazione_ext_gd.InsertRow(0)
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"nome", "Conto Lavoro Fornitori")
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"segno", "+")
			ldc_valore=dw_esi_disp_locazione_sp_ff.GetItemNumber(ll_row,"qta_cl_fornitori")
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"moltiplicando",1)
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"quantita",ldc_valore)
		CASE -1
			ll_new_row= dw_esi_disp_locazione_ext_gd.InsertRow(0)
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"nome", "Conto Lavoro Fornitori")
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"segno", "-")
			ldc_valore=dw_esi_disp_locazione_sp_ff.GetItemNumber(ll_row,"qta_cl_fornitori")
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"moltiplicando",-1)
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"quantita",ldc_valore)
	END CHOOSE

	CHOOSE CASE dw_esi_disp_locazione_sp_ff.GetItemNumber(ll_row,"qta_gruppo_lib_1_sg")		
		CASE 1
			ll_new_row= dw_esi_disp_locazione_ext_gd.InsertRow(0)
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"nome", "Gruppo libero 1")
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"segno", "+")
			ldc_valore=dw_esi_disp_locazione_sp_ff.GetItemNumber(ll_row,"qta_gruppo_lib_1")
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"moltiplicando",1)
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"quantita",ldc_valore)
		CASE -1
			ll_new_row= dw_esi_disp_locazione_ext_gd.InsertRow(0)
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"nome", "Gruppo libero 1")
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"segno", "-")
			ldc_valore=dw_esi_disp_locazione_sp_ff.GetItemNumber(ll_row,"qta_gruppo_lib_1")
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"moltiplicando",-1)
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"quantita",ldc_valore)
	END CHOOSE
	CHOOSE CASE dw_esi_disp_locazione_sp_ff.GetItemNumber(ll_row,"qta_gruppo_lib_2_sg")		
		CASE 1
			ll_new_row= dw_esi_disp_locazione_ext_gd.InsertRow(0)
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"nome", "Gruppo libero 2")
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"segno", "+")
			ldc_valore=dw_esi_disp_locazione_sp_ff.GetItemNumber(ll_row,"qta_gruppo_lib_2")
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"moltiplicando",1)
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"quantita",ldc_valore)
		CASE -1
			ll_new_row= dw_esi_disp_locazione_ext_gd.InsertRow(0)
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"nome", "Gruppo libero 2")
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"segno", "-")
			ldc_valore=dw_esi_disp_locazione_sp_ff.GetItemNumber(ll_row,"qta_gruppo_lib_2")
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"moltiplicando",-1)
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"quantita",ldc_valore)
	END CHOOSE
	CHOOSE CASE dw_esi_disp_locazione_sp_ff.GetItemNumber(ll_row,"qta_gruppo_lib_3_sg")		
		CASE 1
			ll_new_row= dw_esi_disp_locazione_ext_gd.InsertRow(0)
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"nome", "Gruppo libero 3")
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"segno", "+")
			ldc_valore=dw_esi_disp_locazione_sp_ff.GetItemNumber(ll_row,"qta_gruppo_lib_3")
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"moltiplicando",1)
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"quantita",ldc_valore)
		CASE -1
			ll_new_row= dw_esi_disp_locazione_ext_gd.InsertRow(0)
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"nome", "Gruppo libero 3")
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"segno", "-")
			ldc_valore=dw_esi_disp_locazione_sp_ff.GetItemNumber(ll_row,"qta_gruppo_lib_3")
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"moltiplicando",-1)
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"quantita",ldc_valore)
	END CHOOSE
	CHOOSE CASE dw_esi_disp_locazione_sp_ff.GetItemNumber(ll_row,"qta_gruppo_lib_4_sg")		
		CASE 1
			ll_new_row= dw_esi_disp_locazione_ext_gd.InsertRow(0)
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"nome", "Gruppo libero 4")
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"segno", "+")
			ldc_valore=dw_esi_disp_locazione_sp_ff.GetItemNumber(ll_row,"qta_gruppo_lib_4")
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"moltiplicando",1)
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"quantita",ldc_valore)
		CASE -1
			ll_new_row= dw_esi_disp_locazione_ext_gd.InsertRow(0)
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"nome", "Gruppo libero 4")
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"segno", "-")
			ldc_valore=dw_esi_disp_locazione_sp_ff.GetItemNumber(ll_row,"qta_gruppo_lib_4")
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"moltiplicando",-1)
			dw_esi_disp_locazione_ext_gd.SetItem(ll_new_row,"quantita",ldc_valore)
	END CHOOSE

end if

end event

on w_esi_disp_locazione_wz.create
int iCurrent
call w_wiz_main::create
this.cb_ok=create cb_ok
this.dw_esi_disp_locazione_ext_gd=create dw_esi_disp_locazione_ext_gd
this.dw_esi_disp_locazione_sp_ff=create dw_esi_disp_locazione_sp_ff
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=cb_ok
this.Control[iCurrent+2]=dw_esi_disp_locazione_ext_gd
this.Control[iCurrent+3]=dw_esi_disp_locazione_sp_ff
end on

on w_esi_disp_locazione_wz.destroy
call w_wiz_main::destroy
destroy(this.cb_ok)
destroy(this.dw_esi_disp_locazione_ext_gd)
destroy(this.dw_esi_disp_locazione_sp_ff)
end on

event open;call super::open;string		ls_title
long			ll_row

istr_any_array= Message.PowerObjectParm
dw_esi_disp_locazione_sp_ff.Retrieve(istr_any_array.s_array[1], istr_any_array.s_array[2], istr_any_array.s_array[3], istr_any_array.s_array[4], istr_any_array.s_array[5])
ll_row= dw_esi_disp_locazione_sp_ff.GetRow()
if not(IsNull(ll_row) OR ll_row=0) then
	ls_title= dw_esi_disp_locazione_sp_ff.GetItemString(ll_row, "codice") + " - " + dw_esi_disp_locazione_sp_ff.GetItemString(ll_row, "descrizione")
	if istr_any_array.s_array[6]= "esistenza" then
		ls_title= "Esistenza in: " + ls_title
		this.height= 750
	else
		ls_title= "Disponibilità in: " + ls_title
	end if 
	this.title =ls_title
end if 
event ue_load_righe_qta()

end event

event resize;dw_esi_disp_locazione_ext_gd.height= newheight - 200
end event

type cb_ok from commandbutton within w_esi_disp_locazione_wz
int X=46
int Y=41
int Width=238
int Height=85
int TabOrder=20
string Text="Ok"
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Close(parent)
end event

type dw_esi_disp_locazione_ext_gd from u_dw_ext_main within w_esi_disp_locazione_wz
int X=46
int Y=161
int Width=1806
int Height=1321
int TabOrder=10
boolean BringToTop=true
string DataObject="d_esi_disp_locazione_ext_gd"
end type

event rowfocuschanged;call super::rowfocuschanged;If GetRow() > 0 then
	SelectRow(0,FALSE)
	SelectRow(GetRow(), TRUE)
end if
end event

type dw_esi_disp_locazione_sp_ff from u_dw_ext_main within w_esi_disp_locazione_wz
int X=412
int Y=401
int Width=823
int Height=801
int TabOrder=30
boolean Visible=false
boolean BringToTop=true
string DataObject="d_esi_disp_locazione_sp_ff"
end type

event constructor;call super::constructor;SetTrans(SQLCA)
end event

