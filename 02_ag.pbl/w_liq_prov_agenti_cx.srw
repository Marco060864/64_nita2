forward
global type w_liq_prov_agenti_cx from Window
end type
type cb_2 from commandbutton within w_liq_prov_agenti_cx
end type
type cb_1 from commandbutton within w_liq_prov_agenti_cx
end type
type dw_liq_prov_agenti_ext from u_dw_ext_main within w_liq_prov_agenti_cx
end type
end forward

global type w_liq_prov_agenti_cx from Window
int X=481
int Y=85
int Width=2451
int Height=777
boolean TitleBar=true
string Title="Liquidazione Provvigioni Agenti"
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
cb_2 cb_2
cb_1 cb_1
dw_liq_prov_agenti_ext dw_liq_prov_agenti_ext
end type
global w_liq_prov_agenti_cx w_liq_prov_agenti_cx

on w_liq_prov_agenti_cx.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_liq_prov_agenti_ext=create dw_liq_prov_agenti_ext
this.Control[]={ this.cb_2,&
this.cb_1,&
this.dw_liq_prov_agenti_ext}
end on

on w_liq_prov_agenti_cx.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_liq_prov_agenti_ext)
end on

event open;dw_liq_prov_agenti_ext.insertrow(1)
dw_liq_prov_agenti_ext.setfocus()

end event

type cb_2 from commandbutton within w_liq_prov_agenti_cx
int X=1793
int Y=29
int Width=261
int Height=89
int TabOrder=10
string Text="Stam&pa"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;String 	ls_da_agente, ls_a_agente
Date 		ld_data_registrazione

dw_liq_prov_agenti_ext.Accepttext()
ls_da_agente=dw_liq_prov_agenti_ext.GetItemString(1,"da_agente")
ls_a_agente=dw_liq_prov_agenti_ext.GetItemString(1,"a_agente")

String ls_filtro, ls_parametri, ls_tipo_stampa
Date	 ld_fino_al
	
str_liq_prov str_param

If ls_da_agente <> '' then
	ls_filtro="sog_commerciale.codice >= " + "'" + String(ls_da_agente) + "'"
	ls_parametri= ls_parametri + ' Da Agente:' + ls_da_agente
End If

If ls_a_agente <> '' and ls_filtro='' then
	ls_filtro="sog_commerciale.codice <= " + "'" + String(ls_a_agente) + "'"
	ls_parametri=ls_parametri + 'A Agente:' + ls_a_agente
Elseif ls_a_agente <> '' and ls_filtro <> '' then
	ls_filtro=ls_filtro + " AND sog_commerciale.codice <= " + "'" + String(ls_a_agente) + "'"
	ls_parametri=ls_parametri + ' A Agente:' + ls_a_agente
End If

str_param.filtro=ls_filtro
str_param.parametri=ls_parametri
str_param.flag='D'

OpenWithParm(w_liq_prov_agenti_rpt, str_param)
end event

type cb_1 from commandbutton within w_liq_prov_agenti_cx
int X=2117
int Y=29
int Width=266
int Height=89
int TabOrder=20
string Text="&Esci"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(parent)
end event

type dw_liq_prov_agenti_ext from u_dw_ext_main within w_liq_prov_agenti_cx
int X=23
int Y=161
int Width=2359
int Height=493
int TabOrder=30
string DataObject="d_liq_prov_agenti_ext"
end type

event ue_set_search;call super::ue_set_search;CHOOSE CASE as_nomecol
	CASE "da_agente",  "a_agente"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice" 
		is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo = 'A'"
	CASE "da_rag_soc_1", "a_rag_soc_1"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "rag_soc_1" 
		is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo = 'A'"		
END CHOOSE
end event

event ue_use_search;call super::ue_use_search;CHOOSE CASE as_nomecol
	CASE "da_agente"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("da_rag_soc_1", is_ricpar.s_ausil_value[1])		
	CASE "da_rag_soc_1"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("da_agente", is_ricpar.s_ausil_value[1])		
	CASE "a_agente"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("a_rag_soc_1", is_ricpar.s_ausil_value[1])		
	CASE "a_rag_soc_1"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("a_agente", is_ricpar.s_ausil_value[1])		
END CHOOSE

end event

event itemchanged;call super::itemchanged;String	ls_null
Long		ll_null
String	ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
Long     ll_ok

SetNull(ll_null) 
ls_null = ""

CHOOSE CASE dwo.name
	CASE 'da_agente'
		IF IsNull(data) OR (data = ls_null) THEN
 		   This.SetItem(row, "da_agente", ls_null)
			This.SetItem(row, "da_rag_soc_1", ls_null)
		ELSE
		ls_dbc[1] = "codice"
		ls_dwc[1] = "da_agente"
		ls_dbc[2] = "rag_soc_1"
		ls_dwc[2] = "da_rag_soc_1"
	   ls_sql_cond = "sog_commerciale_gen.tipo = 'A'"
		ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &  
										"codice", "A", data, & 
										ls_sql_cond, 2, &
										ls_dbc, ls_dbv, ls_dwc)
										
		This.SetItem(1, "a_agente", Data)
		This.SetItem(1, "a_rag_soc_1", This.Object.da_rag_soc_1[1])
										
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
	 END IF
	 
	 CASE 'da_rag_soc_1'
		IF IsNull(data) OR (data = ls_null) THEN
			This.SetItem(row, "da_agente", ls_null)
			This.SetItem(row, "da_rag_soc_1", ls_null)
		ELSE
			
		ls_dbc[1] = "codice"
		ls_dwc[1] = "da_agente"
		ls_dbc[2] = "rag_soc_1"
		ls_dwc[2] = "da_rag_soc_1"
	   ls_sql_cond = "sog_commerciale_gen.tipo = 'A'"
		ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &  
										"rag_soc_1", "A", data, & 
										ls_sql_cond, 2, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
	END IF
	
	CASE 'a_agente'
		IF IsNull(data) OR (data = ls_null) THEN
 		   This.SetItem(row, "a_agente", ls_null)
			This.SetItem(row, "a_rag_soc_1", ls_null)
		ELSE
		ls_dbc[1] = "codice"
		ls_dwc[1] = "a_agente"
		ls_dbc[2] = "rag_soc_1"
		ls_dwc[2] = "a_rag_soc_1"
	   ls_sql_cond = "sog_commerciale_gen.tipo = 'A'"
		ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &  
										"codice", "A", data, & 
										ls_sql_cond, 2, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
	 END IF
	 
	 CASE 'a_rag_soc_1'
		IF IsNull(data) OR (data = ls_null) THEN
			This.SetItem(row, "a_agente", ls_null)
			This.SetItem(row, "a_rag_soc_1", ls_null)
		ELSE
			
		ls_dbc[1] = "codice"
		ls_dwc[1] = "a_agente"
		ls_dbc[2] = "rag_soc_1"
		ls_dwc[2] = "a_rag_soc_1"
	   ls_sql_cond = "sog_commerciale_gen.tipo = 'A'"
		ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &  
										"rag_soc_1", "A", data, & 
										ls_sql_cond, 2, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
	END IF	
END CHOOSE
end event

