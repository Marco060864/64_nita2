forward
global type w_sog_commerciale_gen_coddes_sw from w_search_main
end type
end forward

global type w_sog_commerciale_gen_coddes_sw from w_search_main
boolean TitleBar=true
string Title="Selezione Soggetto Commerciale"
end type
global w_sog_commerciale_gen_coddes_sw w_sog_commerciale_gen_coddes_sw

on w_sog_commerciale_gen_coddes_sw.create
call super::create
end on

on w_sog_commerciale_gen_coddes_sw.destroy
call super::destroy
end on

event open;
string		ls_tmp1

ii_min_x = 1578
ii_min_y = 1257
dw_lista.ii_tipo_sel = 1
istr_ric = Message.PowerObjectParm
ib_may_close = false
u_freddie.center_window(this)


dw_lista.is_ricpar = istr_ric
If istr_ric.b_asneeded then
	dw_lista.Object.DataWindow.Retrieve.AsNeeded = "Yes"
else
	dw_lista.Object.DataWindow.Retrieve.AsNeeded = "No"
end if
dw_lista.is_last_column = istr_ric.s_filter_name
ls_tmp1 = istr_ric.s_filter_name+"_t"							

dw_lista.is_last_coldesc = string(dw_lista.describe(ls_tmp1+".text"))		
dw_lista.is_last_sort = "A"
dw_lista.is_last_dbname = string(dw_lista.Describe(istr_ric.s_filter_name+".dbName"))
dw_lista.is_last_coltype = string(dw_lista.Describe(istr_ric.s_filter_name+".coltype"))

if Left(dw_lista.is_last_coltype ,4) <> "char" then
	ddlb_tiposel.DeleteItem(1)
	ddlb_tiposel.InsertItem("Maggiore o uguale a ",1)
	ddlb_tiposel.DeleteItem(2)
	ddlb_tiposel.InsertItem("Uguale a ",2)
	ddlb_tiposel.DeleteItem(3)
	ddlb_tiposel.InsertItem("Minore o uguale a ",3)
end if
ddlb_tiposel.SelectItem(1)
dw_lista.setcolumn(istr_ric.s_filter_name)
if istr_ric.s_filter_value>"" then
	sle_filtro.text = istr_ric.s_filter_value
	dw_lista.is_val_sel = istr_ric.s_filter_value
	dw_lista.trigger event ue_change_col (false)
end if

if ((istr_ric.b_imm_insert) and (dw_lista.is_resp_window <> ""))  then
	sle_filtro.text = ""
	cb_nuovo.postevent(clicked!)
else
	if ((istr_ric.b_imm_maint) and (dw_lista.is_resp_window <> ""))then
		cb_cerca.postevent(clicked!)
		cb_modi.postevent(clicked!)
	else
		if ((istr_ric.b_imm_retrieve) or (istr_ric.s_sql_cond>" ") or (istr_ric.s_filter_value>" ") )then
			cb_cerca.postevent(clicked!)
		end if
	end if
end if
	
if dw_lista.is_resp_window = "" then
	cb_modi.enabled = false
	cb_modi.visible = false
	cb_nuovo.enabled = false
	cb_nuovo.visible = false
end if

sle_filtro.setfocus()

end event

type dw_lista from w_search_main`dw_lista within w_sog_commerciale_gen_coddes_sw
string DataObject="d_sog_commerciale_gen_lt"
end type

event dw_lista::ue_init;call super::ue_init;is_resp_window = "w_anag_2_cx"
is_list.s_win_chiave[1] = "id_anagrafica"
end event

event dw_lista::ue_return_values;call super::ue_return_values;CHOOSE CASE is_ricpar.s_filter_name
	CASE "tipo"
		is_ricpar.s_id_seg_value[1] = THIS.uf_get_colval("id_sog_commerciale")
		is_ricpar.s_main_value = THIS.uf_get_colval("tipo")
		is_ricpar.s_ausil_value[1] = THIS.uf_get_colval("codice")
		is_ricpar.s_ausil_value[2] = THIS.uf_get_colval("rag_soc_1")
		is_ricpar.s_ausil_value[3] = THIS.uf_get_colval("tipo")
		is_ricpar.s_ausil_value[4] = THIS.uf_get_colval("id_anagrafica")
	CASE "codice"
		is_ricpar.s_id_seg_value[1] = THIS.uf_get_colval("id_sog_commerciale")
		is_ricpar.s_main_value = THIS.uf_get_colval("codice")
		is_ricpar.s_ausil_value[1] = THIS.uf_get_colval("rag_soc_1")
		is_ricpar.s_ausil_value[2] = THIS.uf_get_colval("codice")
		is_ricpar.s_ausil_value[3] = THIS.uf_get_colval("tipo")
		is_ricpar.s_ausil_value[4] = THIS.uf_get_colval("id_anagrafica")
		is_ricpar.s_ausil_value[5] = THIS.uf_get_colval("id_banca_sog_commerciale")
		is_ricpar.s_ausil_value[6] = THIS.uf_get_colval("banca_appoggio_den_abi")
		is_ricpar.s_ausil_value[7] = THIS.uf_get_colval("indirizzo")		
		is_ricpar.s_ausil_value[8] = THIS.uf_get_colval("localita")		
		is_ricpar.s_ausil_value[9] = THIS.uf_get_colval("provincia")		
		
	CASE "rag_soc_1"
		is_ricpar.s_id_seg_value[1] = THIS.uf_get_colval("id_sog_commerciale")
		is_ricpar.s_main_value = THIS.uf_get_colval("rag_soc_1")
		is_ricpar.s_ausil_value[1] = THIS.uf_get_colval("codice")
		is_ricpar.s_ausil_value[2] = THIS.uf_get_colval("rag_soc_1")
		is_ricpar.s_ausil_value[3] = THIS.uf_get_colval("tipo")
		is_ricpar.s_ausil_value[4] = THIS.uf_get_colval("id_anagrafica")
		is_ricpar.s_ausil_value[5] = THIS.uf_get_colval("id_banca_sog_commerciale")
		is_ricpar.s_ausil_value[6] = THIS.uf_get_colval("banca_appoggio_den_abi")
		is_ricpar.s_ausil_value[7] = THIS.uf_get_colval("indirizzo")		
		is_ricpar.s_ausil_value[8] = THIS.uf_get_colval("localita")		
		is_ricpar.s_ausil_value[9] = THIS.uf_get_colval("provincia")		
END CHOOSE

end event

