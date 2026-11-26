forward
global type w_ricostruzione_progressivi from w_np_single_data
end type
type cb_1 from commandbutton within w_ricostruzione_progressivi
end type
type dw_1 from datawindow within w_ricostruzione_progressivi
end type
type cb_2 from commandbutton within w_ricostruzione_progressivi
end type
end forward

global type w_ricostruzione_progressivi from w_np_single_data
int Width=2761
int Height=2356
cb_1 cb_1
dw_1 dw_1
cb_2 cb_2
end type
global w_ricostruzione_progressivi w_ricostruzione_progressivi

on w_ricostruzione_progressivi.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.dw_1=create dw_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.cb_2
end on

on w_ricostruzione_progressivi.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.cb_2)
end on

event open;call super::open;

dw_single.SetTransObject(SQLCA)
dw_single.Retrieve()   
dw_single.setsort("azienda_id_attivita, azienda_id_esercizio, riga_documento_id_locazione_1, anno, mese, riga_documento_id_articolo")
dw_single.sort()
dw_single.groupcalc()
end event

type p_crescente from w_np_single_data`p_crescente within w_ricostruzione_progressivi
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_ricostruzione_progressivi
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_ricostruzione_progressivi
int X=50
int Y=1024
int Width=2560
int Height=508
int TabOrder=10
string DataObject="d_ricostruzione_progressivi"
BorderStyle BorderStyle=StyleLowered!
end type

type cb_1 from commandbutton within w_ricostruzione_progressivi
int X=119
int Y=896
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

event clicked;
if dw_single.rowcount()>0 then
	
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
					
					saldo = dw_single.getitemdecimal (ll_row,'cmp_val_caricato_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'val_caricato',saldo)
					
					saldo = dw_single.getitemdecimal (ll_row,'cmp_scar_fiscali_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'qta_scaricata',saldo)
					
					saldo = dw_single.getitemdecimal (ll_row,'cmp_peso_scar_fiscali_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'peso_scaricato',saldo)
					
					saldo = dw_single.getitemdecimal (ll_row,'cmp_val_scaricato_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'val_scaricato',saldo)
					
					saldo = dw_single.getitemdecimal (ll_row,'cmp_ord_clienti_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'qta_ord_clienti',saldo)
					
					saldo= dw_single.getitemdecimal(ll_row,'cmp_peso_ord_clienti_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'peso_ord_clienti',saldo)
					
					saldo = dw_single.getitemdecimal(ll_row,'cmp_ord_fornitori_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'qta_ord_fornitori',saldo)
					
					saldo = dw_single.getitemdecimal(ll_row,'cmp_peso_ord_fornitori_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'peso_ord_fornitori',saldo) 
					
					saldo = dw_single.getitemdecimal(ll_row,'cmp_vis_clienti_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'qta_vis_clienti',saldo)
					
					saldo = dw_single.getitemdecimal(ll_row,'cmp_peso_vis_clienti_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'peso_vis_clienti',saldo)
					
					saldo= dw_single.getitemdecimal(ll_row,'cmp_vis_fornitori_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'qta_vis_fornitori',saldo)
					
					saldo = dw_single.getitemdecimal(ll_row,'cmp_peso_vis_fornitori_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'peso_vis_fornitori',saldo)
					
					saldo = dw_single.getitemdecimal (ll_row,'cmp_imp_produzione_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'qta_imp_produzione',saldo)
					
					saldo = dw_single.getitemdecimal (ll_row,'cmp_peso_imp_produzione_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'peso_imp_produzione',saldo)
					
					saldo= dw_single.getitemdecimal (ll_row,'cmp_ord_produzione_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'qta_ord_produzione',saldo)
					
					saldo= dw_single.getitemdecimal (ll_row,'cmp_peso_ord_produzione_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'peso_ord_produzione',saldo)
					
					saldo= dw_single.getitemdecimal (ll_row,'cmp_qta_cl_fornitori_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'qta_cl_fornitori',saldo)
					
					saldo= dw_single.getitemdecimal(ll_row,'cmp_peso_qta_cl_fornitori_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'peso_cl_fornitori',saldo)
					
					saldo = dw_single.getitemdecimal(ll_row,'cmp_qta_cl_clienti_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'qta_cl_clienti',saldo)
					
					saldo = dw_single.getitemdecimal (ll_row,'cmp_peso_qta_cl_clienti_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'peso_cl_clienti',saldo)
					
					
					
					
					
					
					
					saldo = dw_single.getitemdecimal(ll_row,'cmp_gruppo_lib_1_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'qta_gruppo_lib_1',saldo)
					
					saldo = dw_single.getitemdecimal(ll_row,'cmp_peso_gruppo_lib_1_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'peso_gruppo_lib_1',saldo)
					
					saldo = dw_single.getitemdecimal (ll_row,'cmp_gruppo_lib_2_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'qta_gruppo_lib_2',saldo)
					
					saldo = dw_single.getitemdecimal (ll_row,'cmp_peso_gruppo_lib_2_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'peso_gruppo_lib_2',saldo)
					
					saldo= dw_single.getitemdecimal (ll_row,'cmp_gruppo_lib_3_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'qta_gruppo_lib_3',saldo)
					
					saldo= dw_single.getitemdecimal (ll_row,'cmp_peso_gruppo_lib_3_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'peso_gruppo_lib_3',saldo)
					
					saldo= dw_single.getitemdecimal (ll_row,'cmp_gruppo_lib_4_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'qta_gruppo_lib_4',saldo)
					
					saldo = dw_single.getitemdecimal (ll_row,'cmp_peso_gruppo_lib_4_saldo')
					ds_progressivi.setItem(ll_row_insert_mag_partenza,'peso_gruppo_lib_4',saldo)
					
					
					
					
					
					
					
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
				
				saldo = dw_single.getitemdecimal (ll_row,'cmd_val_caricato_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'val_caricato',saldo)
				
				saldo = dw_single.getitemdecimal (ll_row,'cmd_scar_fiscali_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'qta_scaricata',saldo)
				
				saldo= dw_single.getitemdecimal(ll_row,'cmd_peso_scar_fiscali_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'peso_scaricato',saldo)
				
				saldo = dw_single.getitemdecimal (ll_row,'cmd_val_scaricato_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'val_scaricato',saldo)
				
				saldo = dw_single.getitemdecimal(ll_row,'cmd_ord_clienti_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'qta_ord_clienti',saldo)
				
				saldo= dw_single.getitemdecimal(ll_row,'cmd_peso_ord_clienti_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'peso_ord_clienti',saldo)
				
				saldo= dw_single.getitemdecimal(ll_row,'cmd_ord_fornitori_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'qta_ord_fornitori',saldo)
				
				saldo = dw_single.getitemdecimal (ll_row,'cmd_peso_ord_fornitori_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'peso_ord_fornitori',saldo) 
				
				saldo = dw_single.getitemdecimal(ll_row,'cmd_vis_clienti_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'qta_vis_clienti',saldo)
				
				saldo= dw_single.getitemdecimal (ll_row,'cmd_peso_vis_clienti_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'peso_vis_clienti',saldo)
				
				saldo = dw_single.getitemdecimal (ll_row,'cmd_vis_fornitori_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'qta_vis_fornitori',saldo)
				
				saldo = dw_single.getitemdecimal (ll_row,'cmd_peso_vis_fornitori_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'peso_vis_fornitori',saldo)
				
				saldo = dw_single.getitemdecimal(ll_row,'cmd_imp_produzione_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'qta_imp_produzione',saldo)
				
				saldo = dw_single.getitemdecimal(ll_row,'cmd_peso_imp_produzione_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'peso_imp_produzione',saldo)
				
				saldo = dw_single.getitemdecimal(ll_row,'cmd_ord_produzione_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'qta_ord_produzione',saldo)
				
				saldo= dw_single.getitemdecimal(ll_row,'cmd_peso_ord_produzione_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'peso_ord_produzione',saldo)
				
				saldo= dw_single.getitemdecimal (ll_row,'cmd_qta_cl_fornitori_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'qta_cl_fornitori',saldo)
				
				saldo = dw_single.getitemdecimal(ll_row,'cmd_peso_qta_cl_fornitori_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'peso_cl_fornitori',saldo)
				
				saldo = dw_single.getitemdecimal (ll_row,'cmd_qta_cl_clienti_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'qta_cl_clienti',saldo)
				
				saldo = dw_single.getitemdecimal(ll_row,'cmd_peso_qta_cl_clienti_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'peso_cl_clienti',saldo)
				
				
				
				
				
				
				
				saldo= dw_single.getitemdecimal (ll_row,'cmd_gruppo_lib_1_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'qta_gruppo_lib_1',saldo)
				
				saldo = dw_single.getitemdecimal(ll_row,'cmd_peso_gruppo_lib_1_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'peso_gruppo_lib_1',saldo)
				
				saldo = dw_single.getitemdecimal (ll_row,'cmd_gruppo_lib_2_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'qta_gruppo_lib_2',saldo)
				
				saldo = dw_single.getitemdecimal(ll_row,'cmd_peso_gruppo_lib_2_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'peso_gruppo_lib_2',saldo)
				
				saldo= dw_single.getitemdecimal (ll_row,'cmd_gruppo_lib_3_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'qta_gruppo_lib_3',saldo)
				
				saldo = dw_single.getitemdecimal (ll_row,'cmd_peso_gruppo_lib_3_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'peso_gruppo_lib_3',saldo)
				
				saldo = dw_single.getitemdecimal(ll_row,'cmd_gruppo_lib_4_saldo')
				ds_progressivi.setItem(ll_row_insert_mag_partenza,'qta_gruppo_lib_4',saldo)
				
				saldo = dw_single.getitemdecimal (ll_row,'cmd_peso_gruppo_lib_4_saldo')

				ds_progressivi.setItem(ll_row_insert_mag_partenza,'peso_gruppo_lib_4',saldo)
				
				
				
				
				
				
	  
		LOOP
		
		
		for ll_row=1 to ds_progressivi.rowcount()
	        ll_long = ds_progressivi.getitemnumber(ll_row,'id_attivita')
			  saldo = ds_progressivi.getitemdecimal(ll_row,'id_esercizio')
			  if isnull(ll_long) and isnull(saldo)  then 
				ds_progressivi.deleterow(ll_row)
	         ll_row=ll_row -1
			  end if 
	   NEXT
      ll_row=ds_progressivi.rowcount()
		
		
	
		
		li_ret=ds_progressivi.update()
		if li_ret<>1 then
			messagebox("Errore","salvataggio non riuscito")
		end if
		ds_progressivi.RowsCopy(1, ds_progressivi.RowCount(), Primary!, dw_1, 1, Primary!)
		destroy ds_progressivi	
	end if
end if
end event

type dw_1 from datawindow within w_ricostruzione_progressivi
int Y=36
int Width=2414
int Height=812
int TabOrder=30
boolean BringToTop=true
string DataObject="ds_salva_riepiloghi"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

type cb_2 from commandbutton within w_ricostruzione_progressivi
int X=1605
int Y=884
int Width=247
int Height=108
int TabOrder=40
boolean BringToTop=true
string Text="none"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.settransobject(sqlca)
end event

