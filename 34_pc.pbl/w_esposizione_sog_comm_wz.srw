forward
global type w_esposizione_sog_comm_wz from w_wiz_main
end type
type cb_ok from commandbutton within w_esposizione_sog_comm_wz
end type
type dw_scelta_sog_comm_ff from u_dw_ext_main within w_esposizione_sog_comm_wz
end type
type st_1 from statictext within w_esposizione_sog_comm_wz
end type
type dw_esposizione_cliente_wz from u_dw_ext_main within w_esposizione_sog_comm_wz
end type
end forward

global type w_esposizione_sog_comm_wz from w_wiz_main
int Width=2313
int Height=1748
WindowType WindowType=response!
boolean TitleBar=true
string Title="Esposizione Soggetto  Commerciale"
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
cb_ok cb_ok
dw_scelta_sog_comm_ff dw_scelta_sog_comm_ff
st_1 st_1
dw_esposizione_cliente_wz dw_esposizione_cliente_wz
end type
global w_esposizione_sog_comm_wz w_esposizione_sog_comm_wz

type variables
boolean		ib_parent = false
s_list_main	istr_list_main
string		is_return_message
end variables

forward prototypes
public function integer wf_calcola_esposizione ()
end prototypes

public function integer wf_calcola_esposizione ();

long  		ll_id_sog_commerciale,ll_row_scelta,ll_row_esp
decimal		ll_merce_sospesa_1,ll_merce_sospesa_2
decimal		ll_bolle_nonfatt_1,ll_bolle_nonfatt_2
decimal		ll_fatt_noncontab_1,ll_fatt_noncontab_2
decimal		ll_saldo_contabile,ll_esp_sosp_scad
decimal		ll_fido_extra,ll_fido,ll_fido_residuo, ll_campo_j
long  		ll_campo_i,ll_campo_k,ll_campo_l, ll_id_valuta_i, ll_id_valuta_f

ll_row_scelta				= this.dw_scelta_sog_comm_ff.GetRow()
if	ll_row_scelta > 0 then
	ll_id_sog_commerciale 	= this.dw_scelta_sog_comm_ff.GetItemNumber( ll_row_scelta,"id_sog_commerciale" )
end if	

ll_row_esp					= this.dw_esposizione_cliente_wz.GetRow()


ll_merce_sospesa_1		= 0
ll_merce_sospesa_2		= 0

ll_id_valuta_f = istr_list_main.l_id_varie 
this.dw_esposizione_cliente_wz.SetItem( ll_row_esp,"id_valuta",ll_id_valuta_f) 


select sum((((fn_conv_valuta(esercizio.id_valuta, riga_documento.tot_riga_val_az,:ll_id_valuta_f))/(riga_documento.quantita+riga_documento.qta_sconto_merce))*(riga_documento.quantita-riga_documento.qta_sconto_merce-riga_documento.qta_evasa)))
INTO :ll_merce_sospesa_1
    from "DBA".documento,"DBA".riga_documento,"DBA".registro,"DBA".esercizio
    where documento.ID_SOG_COMMERCIALE = :ll_id_sog_commerciale
	 AND esercizio.id_esercizio = registro.id_esercizio
	 AND riga_documento.id_documento = documento.id_documento
    and registro.id_registro=documento.id_registro
    AND registro.tipo_registro='OA'
    and riga_documento.forza_chius_evasione<>'S' 
	 and (riga_documento.quantita+riga_documento.qta_sconto_merce)<>0 
	 and (((riga_documento.tot_riga_val_az/(riga_documento.quantita+riga_documento.qta_sconto_merce))*(riga_documento.quantita-riga_documento.qta_sconto_merce-riga_documento.qta_evasa)))<>0 
    and documento.contabilizzato<>'S'
    group by registro.tipo_registro,documento.id_sog_commerciale;	 

	
	
	
	
	
	

if isNull(ll_merce_sospesa_1) then	
	ll_merce_sospesa_1	= 0
end if	


select sum((((fn_conv_valuta(esercizio.id_valuta, riga_documento.tot_riga_val_az,:ll_id_valuta_f))/(riga_documento.quantita+riga_documento.qta_sconto_merce))*(riga_documento.quantita-riga_documento.qta_sconto_merce-riga_documento.qta_evasa)))
INTO :ll_merce_sospesa_2
    from "DBA".documento,"DBA".riga_documento,"DBA".registro,"DBA".esercizio
    where documento.ID_SOG_COMMERCIALE = :ll_id_sog_commerciale
	 AND esercizio.id_esercizio = registro.id_esercizio	 
	 AND riga_documento.id_documento = documento.id_documento
    and registro.id_registro=documento.id_registro
    AND registro.tipo_registro='OV'
    and riga_documento.forza_chius_evasione<>'S' 
	 and (riga_documento.quantita+riga_documento.qta_sconto_merce)<>0 
	 and (((riga_documento.tot_riga_val_az/(riga_documento.quantita+riga_documento.qta_sconto_merce))*(riga_documento.quantita-riga_documento.qta_sconto_merce-riga_documento.qta_evasa)))<>0 
    and documento.contabilizzato<>'S'
    group by registro.tipo_registro,documento.id_sog_commerciale;	 

	
	
	
	
	
	

if isNull(ll_merce_sospesa_2) then	
	ll_merce_sospesa_2	= 0
end if	

this.dw_esposizione_cliente_wz.SetItem( ll_row_esp,"ordini_non_evasi",ll_merce_sospesa_1 + ll_merce_sospesa_2 )

ll_bolle_nonfatt_1		= 0
ll_bolle_nonfatt_2		= 0


select sum((((fn_conv_valuta(esercizio.id_valuta, riga_documento.tot_riga_val_az,:ll_id_valuta_f))/(riga_documento.quantita+riga_documento.qta_sconto_merce))*(riga_documento.quantita-riga_documento.qta_sconto_merce-riga_documento.qta_evasa)))
	INTO :ll_bolle_nonfatt_1
    from "DBA".documento,"DBA".riga_documento,"DBA".registro,"DBA".esercizio
    where documento.ID_SOG_COMMERCIALE = :ll_id_sog_commerciale
	 AND esercizio.id_esercizio = registro.id_esercizio	 	 
	 AND riga_documento.id_documento = documento.id_documento
    and registro.id_registro=documento.id_registro
    AND registro.tipo_registro='DA'
    and riga_documento.forza_chius_evasione<>'S' 
	 and (riga_documento.quantita+riga_documento.qta_sconto_merce)<>0 
	 and (((riga_documento.tot_riga_val_az/(riga_documento.quantita+riga_documento.qta_sconto_merce))*(riga_documento.quantita-riga_documento.qta_sconto_merce-riga_documento.qta_evasa)))<>0 
    and documento.contabilizzato<>'S'
    group by registro.tipo_registro,documento.id_sog_commerciale;	 	 

	
	
	
	
	
	

if isNull(ll_bolle_nonfatt_1) then	
	ll_bolle_nonfatt_1	= 0
end if	


select sum((((fn_conv_valuta(esercizio.id_valuta, riga_documento.tot_riga_val_az,:ll_id_valuta_f))/(riga_documento.quantita+riga_documento.qta_sconto_merce))*(riga_documento.quantita-riga_documento.qta_sconto_merce-riga_documento.qta_evasa)))
	INTO :ll_bolle_nonfatt_2
    from "DBA".documento,"DBA".riga_documento,"DBA".registro,"DBA".esercizio
    where documento.ID_SOG_COMMERCIALE = :ll_id_sog_commerciale
	 AND esercizio.id_esercizio = registro.id_esercizio	 	 	 
	 AND riga_documento.id_documento = documento.id_documento
    and registro.id_registro=documento.id_registro
    AND registro.tipo_registro='DV'
    and riga_documento.forza_chius_evasione<>'S' 
	 and (riga_documento.quantita+riga_documento.qta_sconto_merce)<>0 
	 and (((riga_documento.tot_riga_val_az/(riga_documento.quantita+riga_documento.qta_sconto_merce))*(riga_documento.quantita-riga_documento.qta_sconto_merce-riga_documento.qta_evasa)))<>0 
    and documento.contabilizzato<>'S'
    group by registro.tipo_registro,documento.id_sog_commerciale;

	
	
	
	
	
	

if isNull(ll_bolle_nonfatt_2) then	
	ll_bolle_nonfatt_2	= 0
end if	

this.dw_esposizione_cliente_wz.SetItem( ll_row_esp,"bolle_non_fatturate",ll_bolle_nonfatt_1 + ll_bolle_nonfatt_2 )	

ll_fatt_noncontab_1		= 0
ll_fatt_noncontab_2		= 0

	 
select sum((((fn_conv_valuta(esercizio.id_valuta, riga_documento.tot_riga_val_az,:ll_id_valuta_f))/(riga_documento.quantita+riga_documento.qta_sconto_merce))*(riga_documento.quantita-riga_documento.qta_sconto_merce-riga_documento.qta_evasa)))
	INTO :ll_fatt_noncontab_1
    from "DBA".documento,"DBA".riga_documento,"DBA".registro,"DBA".esercizio
    where documento.ID_SOG_COMMERCIALE = :ll_id_sog_commerciale
	 AND esercizio.id_esercizio = registro.id_esercizio		 
	 AND riga_documento.id_documento = documento.id_documento
    and registro.id_registro=documento.id_registro
    AND registro.tipo_registro='IA'
    and riga_documento.forza_chius_evasione<>'S' 
	 and (riga_documento.quantita+riga_documento.qta_sconto_merce)<>0 
	 and (((riga_documento.tot_riga_val_az/(riga_documento.quantita+riga_documento.qta_sconto_merce))*(riga_documento.quantita-riga_documento.qta_sconto_merce-riga_documento.qta_evasa)))<>0 
    and documento.contabilizzato<>'S'
    group by registro.tipo_registro,documento.id_sog_commerciale;

	
	
	
	
	
	
	
if isNull(ll_fatt_noncontab_1) then	
	ll_fatt_noncontab_1	= 0
end if	


select sum((((fn_conv_valuta(esercizio.id_valuta, riga_documento.tot_riga_val_az,:ll_id_valuta_f))/(riga_documento.quantita+riga_documento.qta_sconto_merce))*(riga_documento.quantita-riga_documento.qta_sconto_merce-riga_documento.qta_evasa)))
	INTO :ll_fatt_noncontab_2
    from "DBA".documento,"DBA".riga_documento,"DBA".registro,"DBA".esercizio
    where documento.ID_SOG_COMMERCIALE = :ll_id_sog_commerciale
	 AND esercizio.id_esercizio = registro.id_esercizio		 	 
	 AND riga_documento.id_documento = documento.id_documento
    and registro.id_registro=documento.id_registro
    AND registro.tipo_registro='IV'
    and riga_documento.forza_chius_evasione<>'S' 
	 and (riga_documento.quantita+riga_documento.qta_sconto_merce)<>0 
	 and (((riga_documento.tot_riga_val_az/(riga_documento.quantita+riga_documento.qta_sconto_merce))*(riga_documento.quantita-riga_documento.qta_sconto_merce-riga_documento.qta_evasa)))<>0 
    and documento.contabilizzato<>'S'
    group by registro.tipo_registro,documento.id_sog_commerciale;

	
	
	
	
	
	
	
if isNull(ll_fatt_noncontab_2) then	
	ll_fatt_noncontab_2	= 0
end if	

this.dw_esposizione_cliente_wz.SetItem( ll_row_esp,"fatture_non_contab",ll_fatt_noncontab_1 + ll_fatt_noncontab_2 )	

ll_saldo_contabile		= 0


long ll_id_conto, li_ret 
long ll_apertura
date ld_data_competenza

select id_prof_reg_apertura
into :ll_apertura
from par_sistema;

select max(data_competenza)
into :ld_data_competenza
from reg_pd
where id_prof_registrazione=:ll_apertura;
	
if sqlca.sqlcode=100 or isnull(ld_data_competenza) then 
	  select min(data_COMPETENZA)
     into :ld_data_competenza
     from reg_pd;
end if

select id_conto
into :ll_id_conto
from sog_commerciale
where id_sog_commerciale = :ll_id_sog_commerciale;

datastore ds_stampa
ds_stampa=create datastore
ds_stampa.dataobject='ds_calc_saldo_attuale_2'
ds_stampa.reset()
ds_stampa.settransobject(sqlca)
li_ret=ds_stampa.retrieve(ll_id_conto,ld_data_competenza,1,0,ll_id_valuta_f)
if li_ret>0 then ll_saldo_contabile=ds_stampa.getitemdecimal(ds_stampa.rowcount(),'saldo_attuale')
destroy ds_stampa 

	
	
	
	
	
	
	
if isNull(ll_saldo_contabile) then	
	ll_saldo_contabile	= 0
end if	
	
this.dw_esposizione_cliente_wz.SetItem( ll_row_esp,"saldo_contabile",ll_saldo_contabile )	

ll_esp_sosp_scad			= 0

	 
select sum(fn_conv_valuta((fn_valuta_scadenza(scadenza.id_documento, scadenza.id_par_aperta,scadenza.data_scadenza)),scadenza.importo,:ll_id_valuta_f))
	into :ll_esp_sosp_scad
    from "dba".gruppo_esp_sospeso,"dba".tipo_pagamento,"dba".scadenza
    where scadenza.id_sog_commerciale = :ll_id_sog_commerciale
	 and scadenza.id_tipo_pagamento=tipo_pagamento.id_tipo_pagamento 
	 and gruppo_esp_sospeso.id_gruppo_esp_sospeso=tipo_pagamento.id_gruppo_esp_sospeso 
	 and scadenza.stato_scadenza='D'
    group by scadenza.id_sog_commerciale,gruppo_esp_sospeso.id_gruppo_esp_sospeso,gruppo_esp_sospeso.codice,gruppo_esp_sospeso.descrizione;

	
	
	
	
	

if isNull(ll_esp_sosp_scad) then	
	ll_esp_sosp_scad	= 0
end if	
	
this.dw_esposizione_cliente_wz.SetItem( ll_row_esp,"esp_sospeso_scad",ll_esp_sosp_scad )	

ll_fido_extra			= 0
ll_fido					= 0

select "sog_commerciale"."fido"
	into :ll_fido
	from "dba"."sog_commerciale"
	where "sog_commerciale"."id_sog_commerciale" = :ll_id_sog_commerciale
	using SQLCA;		

if isNull(ll_fido) then	
	ll_fido	= 0
end if	

select "sog_commerciale"."extrafido"
	into :ll_fido_extra
	from "dba"."sog_commerciale"
	where "sog_commerciale"."id_sog_commerciale" = :ll_id_sog_commerciale
	using SQLCA;		
	
if isNull(ll_fido_extra) then	
	ll_fido_extra	= 0
end if	
	
this.dw_esposizione_cliente_wz.SetItem( ll_row_esp,"fido_extra",ll_fido_extra + ll_fido )	

ll_campo_i				= 0

select count(*)
	into :ll_campo_i
	from "dba"."scadenza"
	where "scadenza"."esito_pagamento" = 'I' and
			"scadenza"."id_sog_commerciale" = :ll_id_sog_commerciale
	using SQLCA;		

if isNull(ll_campo_i) then	
	ll_campo_i	= 0
end if	

this.dw_esposizione_cliente_wz.SetItem( ll_row_esp,"insoluti_sospesi_i",ll_campo_i )	

ll_campo_j				= 0

decimal ld_campo_j


select sum(fn_conv_valuta((fn_valuta_scadenza(scadenza.id_documento, scadenza.id_par_aperta,scadenza.data_scadenza)),scadenza.importo,:ll_id_valuta_f))
into :ld_campo_j
from "dba"."scadenza"
where "scadenza"."esito_pagamento" = 'I' and
		"scadenza"."id_sog_commerciale" = :ll_id_sog_commerciale
using SQLCA;		

if isNull(ll_campo_j) then	
	ll_campo_j	= 0
end if	

this.dw_esposizione_cliente_wz.SetItem( ll_row_esp,"insoluti_sospesi_j",ld_campo_j )	

ll_campo_k				= 0

select count(*)

   
	
	into :ll_campo_k	
   
	
	from "dba"."scadenza"
	where "scadenza"."esito_pagamento" = 'I' and
			"scadenza"."id_sog_commerciale" = :ll_id_sog_commerciale
	using SQLCA;		

if isNull(ll_campo_k) then	
	ll_campo_k	= 0
end if	


ll_campo_l				= 0

select count(*)
	into :ll_campo_l
	from "dba"."scadenza"
	where "scadenza"."esito_pagamento" = 'I' and
			"scadenza"."id_sog_commerciale" = :ll_id_sog_commerciale
	using SQLCA;		

if isNull(ll_campo_l) then	
	ll_campo_l	= 0
end if	



ll_fido_residuo	= ( ll_fido_extra + ll_fido ) - ( ( ll_bolle_nonfatt_1 + ll_bolle_nonfatt_2 ) + ( ll_fatt_noncontab_1 + ll_fatt_noncontab_2 ) + &
							ll_saldo_contabile + ll_esp_sosp_scad )  						 	

if ll_fido_residuo >= 0 then 
	is_return_message = "OK"
else	
	is_return_message = "BLOCCA"
end if

return 0
end function

on w_esposizione_sog_comm_wz.create
int iCurrent
call super::create
this.cb_ok=create cb_ok
this.dw_scelta_sog_comm_ff=create dw_scelta_sog_comm_ff
this.st_1=create st_1
this.dw_esposizione_cliente_wz=create dw_esposizione_cliente_wz
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ok
this.Control[iCurrent+2]=this.dw_scelta_sog_comm_ff
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.dw_esposizione_cliente_wz
end on

on w_esposizione_sog_comm_wz.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.dw_scelta_sog_comm_ff)
destroy(this.st_1)
destroy(this.dw_esposizione_cliente_wz)
end on

event ue_post_open;call super::ue_post_open;
long				ll_id_sog_commerciale,ll_row
string			ls_codice,ls_rag_soc

ll_row	= this.dw_scelta_sog_comm_ff.insertRow(0)
this.dw_scelta_sog_comm_ff.ScrollToRow(ll_row)

if UpperBound(istr_list_main.l_identifica) > 0 then
	ib_parent	= true
	if not isNull(istr_list_main.l_identifica[1]) then
		ll_id_sog_commerciale	= istr_list_main.l_identifica[1]
		select "sog_commerciale_gen"."codice","sog_commerciale_gen"."rag_soc_1"
			into :ls_codice,:ls_rag_soc
			from "dba"."sog_commerciale_gen"
			where "sog_commerciale_gen"."id_sog_commerciale" = :ll_id_sog_commerciale
			using SQLCA;
			
		if SQLCA.SQLCode = 0 then
			ll_row	= this.dw_scelta_sog_comm_ff.GetRow()
			this.dw_scelta_sog_comm_ff.SetItem( ll_row,"id_sog_commerciale",ll_id_sog_commerciale )
			this.dw_scelta_sog_comm_ff.SetItem( ll_row,"codice",ls_codice )
			this.dw_scelta_sog_comm_ff.SetItem( ll_row,"rag_soc_1",ls_rag_soc )
			wf_calcola_esposizione()
		end if
	end if
end if	


end event

event open;call super::open;
istr_list_main	= Message.PowerObjectParm


cb_ok.setfocus() 
end event

type cb_ok from commandbutton within w_esposizione_sog_comm_wz
int X=46
int Y=40
int Width=247
int Height=88
int TabOrder=30
boolean BringToTop=true
string Text="Ok"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if	ib_parent = false then
	Close(parent)
else
	CloseWithReturn( parent,is_return_message )
end if	
end event

type dw_scelta_sog_comm_ff from u_dw_ext_main within w_esposizione_sog_comm_wz
int X=46
int Y=140
int Width=2194
int Height=180
int TabOrder=10
string DataObject="d_scelta_sog_commerciale_ff"
end type

event ue_set_search;call super::ue_set_search;

CHOOSE CASE as_nomecol
		
	CASE "codice"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 	
		is_ricpar.s_filter_value = as_valcol 					
		is_ricpar.s_filter_name = "codice" 				
	CASE "rag_soc_1"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 	
		is_ricpar.s_filter_value = as_valcol 					
		is_ricpar.s_filter_name = "rag_soc_1" 		
	
END CHOOSE

end event

event ue_use_search;call super::ue_use_search;integer 	li_id_anagrafica
long 		ll_row,ll_ret

CHOOSE CASE as_nomecol
		
	CASE "codice"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("rag_soc_1", is_ricpar.s_ausil_value[1])
		uf_set_colval("id_sog_commerciale", is_ricpar.s_id_seg_value[1])
		wf_calcola_esposizione()

	CASE "rag_soc_1"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("codice", is_ricpar.s_ausil_value[1])
		uf_set_colval("id_sog_commerciale", is_ricpar.s_id_seg_value[1])
		wf_calcola_esposizione()
	
END CHOOSE

end event

event itemchanged;call super::itemchanged;string    ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
long      ll_ok, ll_id_anagrafica, ll_id_banca_appoggio
long		 ll_row,ll_ret

ls_sql_cond = ""  

choose case dwo.name
		
	case 'codice'
		ls_sql_cond = ""  
		
		ls_dbc[1]  	= "id_anagrafica"
		ls_dwc[1]  	= "id_anagrafica"
		
		ls_dbc[2]  	= "codice"
		ls_dwc[2]  	= "codice"
		
		ls_dbc[3]  	= "rag_soc_1"
		ls_dwc[3]  	= "rag_soc_1"
		
		ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &
										"codice", "A", data, &
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		
		if (ll_ok > 0) then
			wf_calcola_esposizione()
			return 2
		end if

	case 'rag_soc_1'
		ls_sql_cond = ""  

		ls_dbc[1]  	= "id_anagrafica"
		ls_dwc[1]  	= "id_anagrafica"
				
		ls_dbc[2]  	= "codice"
		ls_dwc[2]  	= "codice"
		
		ls_dbc[3]  	= "rag_soc_1"
		ls_dwc[3]  	= "rag_soc_1"
		
		ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &
										"rag_soc_1", "A", data, &
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
										
		if (ll_ok > 0) then
			wf_calcola_esposizione()
			return 2
		end if
		
end choose
end event

type st_1 from statictext within w_esposizione_sog_comm_wz
int X=46
int Y=340
int Width=2194
int Height=80
boolean Enabled=false
boolean BringToTop=true
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
string Text="Esposizione Cliente"
boolean FocusRectangle=false
long TextColor=16777215
long BackColor=276856960
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_esposizione_cliente_wz from u_dw_ext_main within w_esposizione_sog_comm_wz
int X=46
int Y=420
int Width=2194
int Height=1200
int TabOrder=20
string DataObject="d_esposizione_sog_commerciale_wz"
end type

event ue_init;call super::ue_init;long		ll_row
ll_row	= this.InsertRow(0)
this.ScrollToRow(ll_row)
end event

