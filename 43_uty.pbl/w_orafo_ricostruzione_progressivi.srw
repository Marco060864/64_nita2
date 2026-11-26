forward
global type w_orafo_ricostruzione_progressivi from w_np_single_data
end type
type cb_1 from commandbutton within w_orafo_ricostruzione_progressivi
end type
end forward

global type w_orafo_ricostruzione_progressivi from w_np_single_data
int Width=2816
int Height=1572
cb_1 cb_1
end type
global w_orafo_ricostruzione_progressivi w_orafo_ricostruzione_progressivi

on w_orafo_ricostruzione_progressivi.create
int iCurrent
call super::create
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
end on

on w_orafo_ricostruzione_progressivi.destroy
call super::destroy
destroy(this.cb_1)
end on

type p_crescente from w_np_single_data`p_crescente within w_orafo_ricostruzione_progressivi
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_orafo_ricostruzione_progressivi
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_orafo_ricostruzione_progressivi
int X=37
int Y=112
int TabOrder=10
string DataObject="d_ricostruzione_progressivi"
end type

type cb_1 from commandbutton within w_orafo_ricostruzione_progressivi
int X=59
int Y=796
int Width=247
int Height=108
int TabOrder=20
boolean BringToTop=true
string Text="Aggiorna"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if dw_single.rowcount()>0 then
	
	Delete from riepilogo;
	If sqlca.sqlcode = 0 then 
		
		datastore ds_progressivi
		ds_progressivi = CREATE datastore
		
		ds_progressivi.dataobject = 'ds_salva_riepiloghi'
		ds_progressivi.settransobject(sqlca)
		
		integer ll_row_insert_mag_partenza,ll_row_insert_mag_destinazione,li_ret
		decimal saldo
		string saldo_2
		date saldo_3
		long ll_long
		boolean lb_controllo
			long ll_row, saldo_1 
			ll_row=0
			lb_controllo=true
			DO WHILE lb_controllo
				
				ll_row=dw_single.findgroupchange(ll_row+1,1)
				if ll_row > 0 then
					ll_row_insert_mag_partenza  = ds_progressivi.insertrow(0) 
					ll_row_insert_mag_destinazione=ds_progressivi.insertrow(0)
					lb_controllo=true
				else
					lb_controllo=false
					exit
				end if
				
				ds_progressivi.setitem(ll_row_insert_mag_partenza,'id_azienda',1)
				
				ll_long = dw_single.getitemnumber(ll_row,'azienda_id_attivita')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'id_attivita',ll_long)
				
				saldo = dw_single.getitemdecimal(ll_row,'azienda_id_esercizio')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'id_esercizio',saldo)
				
				saldo_3 = dw_single.getitemdate (ll_row,'documento_data_documento')
				if isnull(saldo_3) then
					    saldo_3=dw_single.getitemdate(ll_row,'documento_data_registrazione')
				 end if
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'anno',year(saldo_3))
				
				saldo_3 = dw_single.getitemdate (ll_row,'documento_data_documento')
				if isnull(saldo_3) then
					    saldo_3=dw_single.getitemdate(ll_row,'documento_data_registrazione')
				end if		 
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'mese',month(saldo_3))
				
				saldo= dw_single.getitemdecimal(ll_row,'riga_documento_id_articolo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'id_articolo',saldo)
				
				saldo = dw_single.getitemdecimal (ll_row,'riga_documento_id_locazione_1')
				if  not isnull(saldo) then
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'id_locazione',saldo)
					
					
					
					saldo = dw_single.getitemdecimal (ll_row,'cmp_car_fiscali_saldo')
					ds_progressivi.setitem(ll_row_insert_mag_partenza,'qta_caricata',saldo)	
					
					saldo= dw_single.getitemdecimal (ll_row,'cmp_peso_car_fiscali_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'peso_caricato',saldo)
					
					saldo = dw_single.getitemdecimal (ll_row,'cmp_fino_car_fiscali_saldo')
					ds_progressivi.setitem(ll_row_insert_mag_partenza,'fino_caricato',saldo)	
					
					saldo = dw_single.getitemdecimal (ll_row,'cmp_calo_car_fiscali_saldo')
					ds_progressivi.setitem(ll_row_insert_mag_partenza,'calo_caricato',saldo)	
					
					saldo = dw_single.getitemdecimal (ll_row,'cmp_val_caricato_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'val_caricato',saldo)
					
					saldo = dw_single.getitemdecimal (ll_row,'cmp_scar_fiscali_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'qta_scaricata',saldo)
					
					saldo = dw_single.getitemdecimal (ll_row,'cmp_peso_scar_fiscali_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'peso_scaricato',saldo)
					
					saldo = dw_single.getitemdecimal (ll_row,'cmp_fino_scar_fiscali_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'fino_scaricato',saldo)
					
					saldo = dw_single.getitemdecimal (ll_row,'cmp_calo_scar_fiscali_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'calo_scaricato',saldo)
					
					saldo = dw_single.getitemdecimal (ll_row,'cmp_val_scaricato_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'val_scaricato',saldo)
					
					saldo = dw_single.getitemdecimal (ll_row,'cmp_ord_clienti_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'qta_ord_clienti',saldo)
					
					saldo= dw_single.getitemdecimal(ll_row,'cmp_peso_ord_clienti_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'peso_ord_clienti',saldo)
					
					saldo= dw_single.getitemdecimal(ll_row,'cmp_fino_ord_clienti_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'fino_ord_clienti',saldo)
					
					saldo= dw_single.getitemdecimal(ll_row,'cmp_calo_ord_clienti_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'calo_ord_clienti',saldo)
					
					saldo = dw_single.getitemdecimal(ll_row,'cmp_ord_fornitori_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'qta_ord_fornitori',saldo)
					
					saldo = dw_single.getitemdecimal(ll_row,'cmp_peso_ord_fornitori_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'peso_ord_fornitori',saldo) 
					
					saldo = dw_single.getitemdecimal(ll_row,'cmp_fino_ord_fornitori_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'fino_ord_fornitori',saldo) 
					
					saldo = dw_single.getitemdecimal(ll_row,'cmp_calo_ord_fornitori_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'calo_ord_fornitori',saldo) 
					
					saldo = dw_single.getitemdecimal(ll_row,'cmp_vis_clienti_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'qta_vis_clienti',saldo)
					
					saldo = dw_single.getitemdecimal(ll_row,'cmp_peso_vis_clienti_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'peso_vis_clienti',saldo)
					
					saldo = dw_single.getitemdecimal(ll_row,'cmp_fino_vis_clienti_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'fino_vis_clienti',saldo)
					
					saldo = dw_single.getitemdecimal(ll_row,'cmp_calo_vis_clienti_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'calo_vis_clienti',saldo)
					
					saldo= dw_single.getitemdecimal(ll_row,'cmp_vis_fornitori_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'qta_vis_fornitori',saldo)
					
					saldo = dw_single.getitemdecimal(ll_row,'cmp_peso_vis_fornitori_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'peso_vis_fornitori',saldo)
					
					saldo = dw_single.getitemdecimal(ll_row,'cmp_fino_vis_fornitori_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'calo_vis_fornitori',saldo)
					
					saldo = dw_single.getitemdecimal (ll_row,'cmp_imp_produzione_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'qta_imp_produzione',saldo)
					
					saldo = dw_single.getitemdecimal (ll_row,'cmp_peso_imp_produzione_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'peso_imp_produzione',saldo)
					
					saldo = dw_single.getitemdecimal (ll_row,'cmp_fino_imp_produzione_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'fino_imp_produzione',saldo)
					
					saldo = dw_single.getitemdecimal (ll_row,'cmp_calo_imp_produzione_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'calo_imp_produzione',saldo)
					
					saldo= dw_single.getitemdecimal (ll_row,'cmp_ord_produzione_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'qta_ord_produzione',saldo)
					
					saldo= dw_single.getitemdecimal (ll_row,'cmp_peso_ord_produzione_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'peso_ord_produzione',saldo)
					
					saldo= dw_single.getitemdecimal (ll_row,'cmp_fino_ord_produzione_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'fino_ord_produzione',saldo)
					
					saldo= dw_single.getitemdecimal (ll_row,'cmp_calo_ord_produzione_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'calo_ord_produzione',saldo)
					
					saldo= dw_single.getitemdecimal (ll_row,'cmp_qta_cl_fornitori_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'qta_cl_fornitori',saldo)
					
					saldo= dw_single.getitemdecimal(ll_row,'cmp_peso_qta_cl_fornitori_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'peso_cl_fornitori',saldo)
					
					saldo= dw_single.getitemdecimal(ll_row,'cmp_fino_qta_cl_fornitori_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'fino_cl_fornitori',saldo)
						
					saldo= dw_single.getitemdecimal(ll_row,'cmp_calo_qta_cl_fornitori_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'calo_cl_fornitori',saldo)
					
					saldo = dw_single.getitemdecimal(ll_row,'cmp_qta_cl_clienti_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'qta_cl_clienti',saldo)
					
					saldo = dw_single.getitemdecimal (ll_row,'cmp_peso_qta_cl_clienti_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'peso_cl_clienti',saldo)
					
					saldo = dw_single.getitemdecimal (ll_row,'cmp_fino_qta_cl_clienti_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'fino_cl_clienti',saldo)
					
					saldo = dw_single.getitemdecimal (ll_row,'cmp_calo_qta_cl_clienti_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'calo_cl_clienti',saldo)
					
					
					
					
					
					
					
					
					
					
					
					
					
					saldo = dw_single.getitemdecimal(ll_row,'cmp_gruppo_lib_1_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'qta_gruppo_lib_1',saldo)
					
					saldo = dw_single.getitemdecimal(ll_row,'cmp_peso_gruppo_lib_1_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'peso_gruppo_lib_1',saldo)
					
					saldo = dw_single.getitemdecimal(ll_row,'cmp_fino_gruppo_lib_1_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'fino_gruppo_lib_1',saldo)
					
					saldo = dw_single.getitemdecimal(ll_row,'cmp_calo_gruppo_lib_1_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'calo_gruppo_lib_1',saldo)
					
					saldo = dw_single.getitemdecimal (ll_row,'cmp_gruppo_lib_2_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'qta_gruppo_lib_2',saldo)
					
					saldo = dw_single.getitemdecimal (ll_row,'cmp_peso_gruppo_lib_2_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'peso_gruppo_lib_2',saldo)
					
					saldo = dw_single.getitemdecimal (ll_row,'cmp_fino_gruppo_lib_2_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'fino_gruppo_lib_2',saldo)
					
					saldo = dw_single.getitemdecimal (ll_row,'cmp_calo_gruppo_lib_2_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'calo_gruppo_lib_2',saldo)
					
					saldo= dw_single.getitemdecimal (ll_row,'cmp_gruppo_lib_3_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'qta_gruppo_lib_3',saldo)
					
					saldo= dw_single.getitemdecimal (ll_row,'cmp_peso_gruppo_lib_3_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'peso_gruppo_lib_3',saldo)
					
					saldo= dw_single.getitemdecimal (ll_row,'cmp_fino_gruppo_lib_3_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'fino_gruppo_lib_3',saldo)
					
					saldo= dw_single.getitemdecimal (ll_row,'cmp_calo_gruppo_lib_3_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'calo_gruppo_lib_3',saldo)
					
					saldo= dw_single.getitemdecimal (ll_row,'cmp_gruppo_lib_4_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'qta_gruppo_lib_4',saldo)
					
					saldo = dw_single.getitemdecimal (ll_row,'cmp_peso_gruppo_lib_4_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'peso_gruppo_lib_4',saldo)
					
					saldo = dw_single.getitemdecimal (ll_row,'cmp_fino_gruppo_lib_4_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'fino_gruppo_lib_4',saldo)
					
					saldo = dw_single.getitemdecimal (ll_row,'cmp_calo_gruppo_lib_4_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'calo_gruppo_lib_4',saldo)
					
					
					
					
					
					
					
					
					
					
					
					
					
				else
			     	ds_progressivi.DeleteRow(ll_row_insert_mag_partenza)											
				end if		
				
				
				
				ll_row_insert_mag_partenza=ll_row_insert_mag_destinazione
				
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'id_azienda',1)
				
				saldo = dw_single.getitemdecimal(ll_row,'azienda_id_attivita')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'id_attivita',saldo)
				
				saldo= dw_single.getitemdecimal (ll_row,'azienda_id_esercizio')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'id_esercizio',saldo)
				
				saldo_3 = dw_single.getitemdate (ll_row,'documento_data_documento')
				if isnull (saldo_3) then
					saldo_3=dw_single.getitemdate(ll_row,'documento_data_registrazione')
				end if	
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'anno',year(saldo_3))
				
				saldo_3 = dw_single.getitemdate (ll_row,'documento_data_documento')
				if isnull(saldo_3) then
					   saldo_3=dw_single.getitemdate(ll_row,'documento_data_registrazione')
				end if
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'mese',month(saldo_3))
				
				saldo = dw_single.getitemdecimal (ll_row,'riga_documento_id_articolo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'id_articolo',saldo)
				
				saldo = dw_single.getitemdecimal (ll_row,'riga_documento_id_locazione_2')
				if  not isnull(saldo) then
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'id_locazione',saldo)
			     else			
					ds_progressivi.DeleteRow(ll_row_insert_mag_partenza)
					continue
				end if 
	                         			
				
				
				saldo= dw_single.getitemdecimal (ll_row,'cmd_qta_rim_iniziale_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'qta_rim_iniziale',saldo)
				
				
				
				
				
				
				
				
				
				
				saldo = dw_single.getitemdecimal(ll_row,'cmd_val_rim_iniziale_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'val_rim_iniziale',saldo)
				
				saldo= dw_single.getitemdecimal(ll_row,'cmd_car_fiscali_saldo')
				ds_progressivi.setitem(ll_row_insert_mag_partenza,'qta_caricata',saldo)
				
				saldo= dw_single.getitemdecimal (ll_row,'cmd_peso_car_fiscali_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'peso_caricato',saldo)
				
				saldo= dw_single.getitemdecimal (ll_row,'cmd_fino_car_fiscali_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'fino_caricato',saldo)
				
				saldo= dw_single.getitemdecimal (ll_row,'cmd_calo_car_fiscali_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'calo_caricato',saldo)
				
				saldo = dw_single.getitemdecimal (ll_row,'cmd_val_caricato_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'val_caricato',saldo)
				
				saldo = dw_single.getitemdecimal (ll_row,'cmd_scar_fiscali_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'qta_scaricata',saldo)
				
				saldo= dw_single.getitemdecimal(ll_row,'cmd_peso_scar_fiscali_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'peso_scaricato',saldo)
				
				saldo= dw_single.getitemdecimal(ll_row,'cmd_fino_scar_fiscali_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'fino_scaricato',saldo)
				
				saldo= dw_single.getitemdecimal(ll_row,'cmd_calo_scar_fiscali_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'calo_scaricato',saldo)
				
				saldo = dw_single.getitemdecimal (ll_row,'cmd_val_scaricato_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'val_scaricato',saldo)
				
				saldo = dw_single.getitemdecimal(ll_row,'cmd_ord_clienti_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'qta_ord_clienti',saldo)
				
				saldo= dw_single.getitemdecimal(ll_row,'cmd_peso_ord_clienti_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'peso_ord_clienti',saldo)
				
				saldo= dw_single.getitemdecimal(ll_row,'cmd_fino_ord_clienti_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'fino_ord_clienti',saldo)
				
				saldo= dw_single.getitemdecimal(ll_row,'cmd_calo_ord_clienti_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'calo_ord_clienti',saldo)
				
				saldo= dw_single.getitemdecimal(ll_row,'cmd_ord_fornitori_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'qta_ord_fornitori',saldo)
				
				saldo = dw_single.getitemdecimal (ll_row,'cmd_peso_ord_fornitori_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'peso_ord_fornitori',saldo) 
				
				saldo = dw_single.getitemdecimal (ll_row,'cmd_fino_ord_fornitori_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'fino_ord_fornitori',saldo) 
				
				saldo = dw_single.getitemdecimal (ll_row,'cmd_calo_ord_fornitori_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'calo_ord_fornitori',saldo) 
				
				saldo = dw_single.getitemdecimal(ll_row,'cmd_vis_clienti_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'qta_vis_clienti',saldo)
				
				saldo= dw_single.getitemdecimal (ll_row,'cmd_peso_vis_clienti_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'peso_vis_clienti',saldo)
				
				saldo= dw_single.getitemdecimal (ll_row,'cmd_fino_vis_clienti_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'fino_vis_clienti',saldo)
				
				saldo= dw_single.getitemdecimal (ll_row,'cmd_calo_vis_clienti_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'calo_vis_clienti',saldo)
				
				saldo = dw_single.getitemdecimal (ll_row,'cmd_vis_fornitori_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'qta_vis_fornitori',saldo)
				
				saldo = dw_single.getitemdecimal (ll_row,'cmd_peso_vis_fornitori_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'peso_vis_fornitori',saldo)
				
				saldo = dw_single.getitemdecimal (ll_row,'cmd_fino_vis_fornitori_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'fino_vis_fornitori',saldo)
				
				saldo = dw_single.getitemdecimal (ll_row,'cmd_calo_vis_fornitori_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'calo_vis_fornitori',saldo)
				
				saldo = dw_single.getitemdecimal(ll_row,'cmd_imp_produzione_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'qta_imp_produzione',saldo)
				
				saldo = dw_single.getitemdecimal(ll_row,'cmd_peso_imp_produzione_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'peso_imp_produzione',saldo)
				
				saldo = dw_single.getitemdecimal(ll_row,'cmd_fino_imp_produzione_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'fino_imp_produzione',saldo)
				
				saldo = dw_single.getitemdecimal(ll_row,'cmd_calo_imp_produzione_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'calo_imp_produzione',saldo)
				
				saldo = dw_single.getitemdecimal(ll_row,'cmd_ord_produzione_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'qta_ord_produzione',saldo)
				
				saldo= dw_single.getitemdecimal(ll_row,'cmd_peso_ord_produzione_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'peso_ord_produzione',saldo)
				
				saldo= dw_single.getitemdecimal(ll_row,'cmd_fino_ord_produzione_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'fino_ord_produzione',saldo)
				
				saldo= dw_single.getitemdecimal(ll_row,'cmd_calo_ord_produzione_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'calo_ord_produzione',saldo)
				
				saldo= dw_single.getitemdecimal (ll_row,'cmd_qta_cl_fornitori_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'qta_cl_fornitori',saldo)
				
				saldo = dw_single.getitemdecimal(ll_row,'cmd_peso_qta_cl_fornitori_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'peso_cl_fornitori',saldo)
				
				saldo = dw_single.getitemdecimal(ll_row,'cmd_fino_qta_cl_fornitori_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'fino_cl_fornitori',saldo)
				
				saldo = dw_single.getitemdecimal(ll_row,'cmd_calo_qta_cl_fornitori_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'calo_cl_fornitori',saldo)
				
				saldo = dw_single.getitemdecimal (ll_row,'cmd_qta_cl_clienti_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'qta_cl_clienti',saldo)
				
				saldo = dw_single.getitemdecimal(ll_row,'cmd_peso_qta_cl_clienti_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'peso_cl_clienti',saldo)
				
				saldo = dw_single.getitemdecimal(ll_row,'cmd_fino_qta_cl_clienti_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'fino_cl_clienti',saldo)
				
				saldo = dw_single.getitemdecimal(ll_row,'cmd_calo_qta_cl_clienti_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'calo_cl_clienti',saldo)
				
				
				
					
				
				
				
				
				
				
				
				
				
				saldo= dw_single.getitemdecimal (ll_row,'cmd_gruppo_lib_1_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'qta_gruppo_lib_1',saldo)
				
				saldo = dw_single.getitemdecimal(ll_row,'cmd_peso_gruppo_lib_1_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'peso_gruppo_lib_1',saldo)
				
				saldo = dw_single.getitemdecimal(ll_row,'cmd_fino_gruppo_lib_1_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'fino_gruppo_lib_1',saldo)
				
				saldo = dw_single.getitemdecimal(ll_row,'cmd_calo_gruppo_lib_1_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'calo_gruppo_lib_1',saldo)
				
				saldo = dw_single.getitemdecimal (ll_row,'cmd_gruppo_lib_2_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'qta_gruppo_lib_2',saldo)
				
				saldo = dw_single.getitemdecimal(ll_row,'cmd_peso_gruppo_lib_2_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'peso_gruppo_lib_2',saldo)
				
				saldo = dw_single.getitemdecimal(ll_row,'cmd_fino_gruppo_lib_2_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'fino_gruppo_lib_2',saldo)
				
				saldo = dw_single.getitemdecimal(ll_row,'cmd_calo_gruppo_lib_2_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'calo_gruppo_lib_2',saldo)
				
				saldo= dw_single.getitemdecimal (ll_row,'cmd_gruppo_lib_3_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'qta_gruppo_lib_3',saldo)
				
				saldo = dw_single.getitemdecimal (ll_row,'cmd_peso_gruppo_lib_3_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'peso_gruppo_lib_3',saldo)
				
				saldo = dw_single.getitemdecimal (ll_row,'cmd_fino_gruppo_lib_3_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'fino_gruppo_lib_3',saldo)
				
				saldo = dw_single.getitemdecimal (ll_row,'cmd_calo_gruppo_lib_3_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'calo_gruppo_lib_3',saldo)
				
				saldo = dw_single.getitemdecimal(ll_row,'cmd_gruppo_lib_4_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'qta_gruppo_lib_4',saldo)
				
				saldo = dw_single.getitemdecimal (ll_row,'cmd_peso_gruppo_lib_4_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'peso_gruppo_lib_4',saldo)
				
				saldo = dw_single.getitemdecimal (ll_row,'cmd_fino_gruppo_lib_4_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'fino_gruppo_lib_4',saldo)
				
				saldo = dw_single.getitemdecimal (ll_row,'cmd_calo_gruppo_lib_4_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'calo_gruppo_lib_4',saldo)
				
				
				
				
				
				
				
				
				
				
				
				
	  
		LOOP
		
		ds_progressivi.update()
		select count(id_azienda)
		into :saldo
		from riepilogo;
		if saldo=0 then
			messagebox("Errore","salvataggio non riuscito")
		end if
		destroy ds_progressivi	
	end if
end if
end event

