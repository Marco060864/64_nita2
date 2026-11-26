forward
global type w_con_pagamento_simula_wz from w_wiz_main
end type
type dw_2 from u_dw_ext_main within w_con_pagamento_simula_wz
end type
type cb_esci from commandbutton within w_con_pagamento_simula_wz
end type
type dw_1 from u_dw_ext_main within w_con_pagamento_simula_wz
end type
type cb_simula from commandbutton within w_con_pagamento_simula_wz
end type
end forward

global type w_con_pagamento_simula_wz from w_wiz_main
int X=832
int Y=360
int Width=2341
int Height=1444
WindowType WindowType=response!
boolean TitleBar=true
string Title="Simulazione sviluppo rate"
dw_2 dw_2
cb_esci cb_esci
dw_1 dw_1
cb_simula cb_simula
end type
global w_con_pagamento_simula_wz w_con_pagamento_simula_wz

type variables
long		il_id_cp

uo_esp_pag	iuo_pag

long il_id_valuta 
end variables

forward prototypes
public function decimal uf_round (integer precisione, decimal valore, character tipo)
public subroutine uf_setta_format (long il_valuta)
end prototypes

public function decimal uf_round (integer precisione, decimal valore, character tipo);

decimal 	ldc_ret_number, ldc_precisione



If precisione >= 0 then
	ldc_precisione = 10^precisione
else
	precisione= - precisione
	ldc_precisione = 1 / (10^precisione)
end if

CHOOSE CASE tipo
	CASE "I"
		
		ldc_ret_number = valore / ldc_precisione
		ldc_ret_number = Truncate(ldc_ret_number, 0) * ldc_precisione
	CASE "M"
	
		ldc_ret_number = valore / ldc_precisione
		ldc_ret_number = Round(ldc_ret_number, 0) * ldc_precisione
	CASE "S"
		
		ldc_ret_number = valore / ldc_precisione
		ldc_ret_number = Ceiling(ldc_ret_number) * ldc_precisione
		
	CASE "F"
		ldc_ret_number = round(valore,0)
	CASE ELSE
END CHOOSE

RETURN ldc_ret_number
end function

public subroutine uf_setta_format (long il_valuta);string ls_format, LS_EDIT

LS_FORMAT = F_VALU_MASK(il_valuta)
LS_EDIT = F_VALU_EDIT(il_valuta)

dw_1.modify("imponibile.EDIT.FORMAT ='"+ ls_edit+"'")
dw_1.modify("imponibile.FORMAT ='"+ ls_format+"'")
dw_1.modify("imposta.EDIT.FORMAT ='"+ ls_edit+"'")
dw_1.modify("imposta.FORMAT ='"+ ls_format+"'")
dw_1.modify("totale.FORMAT ='"+ ls_format+"'")

dw_2.modify("imponibile.FORMAT ='"+ ls_format+"'")
dw_2.modify("imposta.FORMAT ='"+ ls_format+"'")
dw_2.modify("bollo.FORMAT ='"+ ls_format+"'")
dw_2.modify("tot_riga.FORMAT ='"+ ls_format+"'")
dw_2.modify("tot_impo.FORMAT ='"+ ls_format+"'")
dw_2.modify("tot_iva.FORMAT ='"+ ls_format+"'")
dw_2.modify("tot_bollo.FORMAT ='"+ ls_format+"'")
dw_2.modify("tot_righe_non_arrotondate.FORMAT ='"+ ls_format+"'")

end subroutine

on w_con_pagamento_simula_wz.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.cb_esci=create cb_esci
this.dw_1=create dw_1
this.cb_simula=create cb_simula
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.cb_esci
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.cb_simula
end on

on w_con_pagamento_simula_wz.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.cb_esci)
destroy(this.dw_1)
destroy(this.cb_simula)
end on

event open;call super::open;long		ll_row

iuo_pag = create uo_esp_pag

il_id_cp = Message.DoubleParm
ll_row = dw_1.insertrow(0)
if ll_row>0 then
	dw_1.SetItem(ll_row,"imponibile",15000000)
	dw_1.SetItem(ll_row,"imposta",6000000)
	dw_1.SetItem(ll_row,"data_decorrenza",today())
else
	messageBox ("Hey!","Riga negativa: "+string(ll_row))
end if

dw_2.object.tot_impo.alignment = 1
dw_2.object.tot_iva.alignment = 1
dw_2.object.tot_riga.alignment = 1

end event

event close;call super::close;destroy iuo_pag
end event

event ue_post_open;call super::ue_post_open;
select id_valuta
into :il_id_valuta
from par_sistema;

if not isnull(il_id_valuta) then uf_setta_format(il_id_valuta)
end event

type dw_2 from u_dw_ext_main within w_con_pagamento_simula_wz
int X=64
int Y=660
int Width=2171
int Height=656
int TabOrder=3
string DataObject="d_con_pag_simula_3_ex"
boolean HScrollBar=true
boolean VScrollBar=true
end type

type cb_esci from commandbutton within w_con_pagamento_simula_wz
event clicked pbm_bnclicked
int X=1906
int Y=520
int Width=329
int Height=84
int TabOrder=10
boolean BringToTop=true
string Text="Esci"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(parent)
end event

type dw_1 from u_dw_ext_main within w_con_pagamento_simula_wz
int X=64
int Y=40
int Width=2171
int Height=440
int TabOrder=20
string DataObject="d_con_pag_simula_1_ex"
end type

event itemchanged;call super::itemchanged;
string		ls_tb, ls_cp, ls_vr, ls_tr
string		ls_dbc[], ls_dbv[], ls_dwc[]
string		ls_ebc[], ls_ebv[], ls_ewc[]
integer		li_ret

choose case dwo.name
	case "c_sog_commerciale"
		ls_dbc[1] = "id_sog_commerciale"
		ls_dbc[2] = "codice"
		ls_dbc[3] = "id_anagrafica"
		ls_dwc[1] = "id_sog_commerciale"
		ls_dwc[2] = "c_sog_commerciale"
		ls_dwc[3] = "id_anagrafica"
		li_ret = uf_autofind_col(dwo.Name, "sog_commerciale", "codice", "A", data, "", &
					3, ls_dbc, ls_dbv, ls_dwc)
		if li_ret>0 then
			ls_ebc[1] = "rag_soc_1"
			ls_ewc[1] = "d_sog_commerciale"
			li_ret = uf_autofind_col("","anagrafica","id_anagrafica","N",ls_dbv[3],"", &
					1, ls_ebc, ls_ebv, ls_ewc) 
			return 2
		else
			uf_set_colval("d_sog_commerciale",u_freddie.gs_null)
		end if

	case "d_sog_commerciale"
		ls_dbc[1] = "id_sog_commerciale"
		ls_dwc[1] = "c_sog_commerciale"
		ls_dbc[2] = "id_sog_commerciale"
		ls_dwc[2] = "id_sog_commerciale"
		li_ret = uf_autofind_col(dwo.Name, "sog_commerciale", "id_sog_commerciale", "N", "0", "", &
										1, ls_dbc, ls_dbv, ls_dwc)
end choose

end event

event ue_set_search;call super::ue_set_search;
choose case as_nomecol
		
	case "c_sog_commerciale"
		is_search_window = "w_sog_commerciale_gen_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "codice"

	case "d_sog_commerciale"
		is_search_window = "w_sog_commerciale_gen_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "rag_soc_1"
		
end choose

end event

event ue_use_search;call super::ue_use_search;long ll_id_anag, ll_id_sc

choose case as_nomecol
	case "c_sog_commerciale"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_sog_commerciale", is_ricpar.s_id_seg_value[1])
		uf_set_colval("d_sog_commerciale", is_ricpar.s_ausil_value[1])
		ll_id_sc = long(uf_get_colval("id_sog_commerciale"))

		select dba.sog_commerciale.id_anagrafica
		into :ll_id_anag
		from dba.sog_commerciale
		where dba.sog_commerciale.id_sog_commerciale = :ll_id_sc
		using sqlca;

		uf_set_colval("id_anagrafica", string(ll_id_anag))
		
	case "d_sog_commerciale"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_sog_commerciale", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_sog_commerciale", is_ricpar.s_ausil_value[1])
		ll_id_sc = long(uf_get_colval("id_sog_commerciale"))

		select dba.sog_commerciale.id_anagrafica
		into :ll_id_anag
		from dba.sog_commerciale
		where dba.sog_commerciale.id_sog_commerciale = :ll_id_sc
		using sqlca;

		uf_set_colval("id_anagrafica", string(ll_id_anag))

end choose

end event

type cb_simula from commandbutton within w_con_pagamento_simula_wz
int X=64
int Y=520
int Width=329
int Height=84
int TabOrder=30
boolean BringToTop=true
string Text="Simula"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
s_scadenze lstr_scadenze
boolean	lb_ok
long		ll_id_cp, ll_id_anag, ll_row
decimal	ld_impon, ld_impos, ld_bollo, ld_parziale, ld_imponibile
date		ld_iniz
decimal	ld_impr[], ld_ivar[]
date		ld_datr[],ldc_nuova_data
integer	li_size, li_i, li_precisione,li_anno,li_mese,li_giorno,li_giorno_con,li_mese_con
string ls_giorno,ls_mese,ls_anno

datastore ds_scade
ds_scade=create datastore
ds_scade.dataobject='ds_spec_scadenza'
ds_scade.reset()
ds_scade.settransobject(sqlca)


if dw_1.acceptText() >0 then
	ld_impon = dw_1.GetItemDecimal(1,"imponibile")
	ld_impos = dw_1.GetItemDecimal(1,"imposta")
	ld_iniz = dw_1.GetItemDate(1,"data_decorrenza")
	ll_id_cp = il_id_cp
	ll_id_anag = dw_1.GetItemNumber(1,"id_anagrafica")
	
	
	
	lb_ok = iuo_pag.uf_calcola_pagamenti_e(il_id_valuta,ld_impon,ld_impos,ld_iniz,ll_id_anag,ll_id_cp,lstr_scadenze)
	
	
	
	dw_2.reset()
	li_size = upperbound(lstr_scadenze.dc_imp_out)
	ld_parziale = 0
	for li_i = 1 to li_size
		ll_row = dw_2.insertrow(0)
		if ll_row>0 then
		   
			dw_2.setItem(ll_row,"numero",li_i)
			dw_2.setItem(ll_row,"imponibile",lstr_scadenze.dc_imp_out[li_i])
			dw_2.setItem(ll_row,"imposta",lstr_scadenze.dc_iva_out[li_i])
			dw_2.setItem(ll_row,"bollo",lstr_scadenze.dc_bollo[li_i])
			
			
			
			
			li_giorno_con=day(lstr_scadenze.d_date[li_i])
			li_mese_con=month(lstr_scadenze.d_date[li_i])
			
					long ll_id_sog
					ll_id_sog=dw_1.getitemnumber(1,'id_sog_commerciale')
					ds_scade.reset()
					if not isnull(ll_id_sog) then ds_scade.retrieve(ll_id_sog,li_giorno_con,li_mese_con)
					if ds_scade.rowcount()>0 and not isnull(ll_id_sog) then
						li_giorno=ds_scade.getitemnumber(1,'gg_app')
						li_mese=ds_scade.getitemnumber(1,'ms_app')
						if li_mese_con>li_mese then
							li_anno=year(lstr_scadenze.d_date[li_i]) + 1
					  	else
							if li_mese_con=li_mese and li_giorno_con>li_giorno then
								li_anno=year(lstr_scadenze.d_date[li_i]) + 1
					   	else
								li_anno=year(lstr_scadenze.d_date[li_i])
							end if
						end if
						
						ls_anno=string(li_anno)
						ls_giorno=string(li_giorno)
						if len(ls_giorno)=1 then ls_giorno='0'+ls_giorno
						ls_mese=string(li_mese)
						if len(ls_mese)=1 then ls_mese='0'+ls_mese
						ldc_nuova_data=date(ls_giorno+'/'+ls_mese+'/'+ls_anno)
						lstr_scadenze.d_date[li_i]=ldc_nuova_data
					end if
					
			
			dw_2.setItem(ll_row,"data_pag",lstr_scadenze.d_date[li_i])
			
		end if
	next
end if

destroy ds_scade


end event

