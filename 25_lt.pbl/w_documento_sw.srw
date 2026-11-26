forward
global type w_documento_sw from w_search_main
end type
end forward

global type w_documento_sw from w_search_main
boolean TitleBar=true
string Title="Ricerca Documento"
end type
global w_documento_sw w_documento_sw

on w_documento_sw.create
call super::create
end on

on w_documento_sw.destroy
call super::destroy
end on

event open;
string		ls_tmp1

ii_min_x = 1578
ii_min_y = 1257
dw_lista.ii_tipo_sel = 2

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
	ddlb_tiposel.InsertItem("Uguale a",2)
	ddlb_tiposel.DeleteItem(3)
	ddlb_tiposel.InsertItem("Minore o uguale a ",3)
end if
ddlb_tiposel.SelectItem(2)
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





cb_modi.visible = FALSE
cb_nuovo.visible = FALSE
dw_lista.Object.cc_descrizione.width= 0
dw_lista.Object.c_tipo_registro.width= 0
end event

type dw_lista from w_search_main`dw_lista within w_documento_sw
string DataObject="d_documento_descr_lt"
end type

event dw_lista::ue_init;call super::ue_init;
end event

event dw_lista::ue_return_values;call super::ue_return_values;is_ricpar.s_main_value = THIS.uf_get_colval("cc_descrizione")
is_ricpar.s_id_seg_value[1] = THIS.uf_get_colval("documento_id_documento")

is_ricpar.s_ausil_value[1] = THIS.GetItemString(GetRow(),"c_tipo_registro")

is_ricpar.s_ausil_value[2] = string(GetItemNumber(GetRow(),"registro_numero"))
is_ricpar.s_ausil_value[3] = GetItemString(GetRow(),"registro_descrizione")
is_ricpar.s_ausil_value[4] = string(GetItemNumber(GetRow(),"documento_num_progressivo"))
is_ricpar.s_ausil_value[5] = string(GetItemDate(GetRow(),"documento_data_registrazione"))
is_ricpar.s_ausil_value[6] = GetItemString(GetRow(),"documento_num_documento")
is_ricpar.s_ausil_value[7] = string(GetItemDate(GetRow(),"documento_data_documento"))
is_ricpar.s_ausil_value[8] = string(GetItemDate(GetRow(),"documento_data_competenza"))

end event

event dw_lista::ue_retrieve;call super::ue_retrieve;SetSort("registro_numero A,documento_data_registrazione D,documento_num_progressivo D")
Sort()

RETURN 0
end event

type ddlb_tiposel from w_search_main`ddlb_tiposel within w_documento_sw
boolean BringToTop=true
end type

