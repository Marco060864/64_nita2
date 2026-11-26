forward
global type w_st_sog_com_barre_cx from w_wiz_main
end type
type dw_1 from u_dw_ext_main within w_st_sog_com_barre_cx
end type
type cb_1 from commandbutton within w_st_sog_com_barre_cx
end type
end forward

global type w_st_sog_com_barre_cx from w_wiz_main
int Height=684
boolean TitleBar=true
string Title="Stampa cod. barre sog. commerciali"
dw_1 dw_1
cb_1 cb_1
end type
global w_st_sog_com_barre_cx w_st_sog_com_barre_cx

on w_st_sog_com_barre_cx.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_1
end on

on w_st_sog_com_barre_cx.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_1)
end on

event open;call super::open;dw_1.settransobject(sqlca)
dw_1.insertrow(0)
end event

type dw_1 from u_dw_ext_main within w_st_sog_com_barre_cx
int X=27
int Y=28
int Width=2491
int Height=372
int TabOrder=10
boolean BringToTop=true
string DataObject="d_st_sog_com_barre"
end type

event ue_set_search;choose case as_nomecol		
	CASE "sog_com_cod"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice" 
	CASE "sog_com_des"
		is_search_window="w_sog_commerciale_gen_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="rag_soc_1"				
	CASE "sog_com_cod2"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice" 
	CASE "sog_com_des2"
		is_search_window="w_sog_commerciale_gen_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="rag_soc_1"				
		
end choose
end event

event ue_use_search;choose case as_nomecol
	CASE "sog_com_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("sog_com_des", is_ricpar.s_ausil_value[1])
		
	case "sog_com_des"
   	uf_set_colval(as_nomecol,is_ricpar.s_main_value)
		uf_set_colval("sog_com_cod", is_ricpar.s_ausil_value[1])			
		
	CASE "sog_com_cod2"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("sog_com_des2", is_ricpar.s_ausil_value[1])
		
	case "sog_com_des2"
   	uf_set_colval(as_nomecol,is_ricpar.s_main_value)
		uf_set_colval("sog_com_cod2", is_ricpar.s_ausil_value[1])			
		
end choose

end event

event itemchanged;integer li_ok
string ls_sql_cond
string ls_dbc[], ls_dwc[], ls_dbv[], ls_tipo_documento, ls_sql, ls_sog_cod, ls_sog_rag
long ll_null
long ll_id_prof_prop

setnull(ll_null)

choose case dwo.name
		
	CASE "sog_com_cod"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"	
		
		ls_dwc[1] = "sog_com_cod"
		ls_dwc[2] = "sog_com_des"
		
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
						
	case "sog_com_des"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"			
		
		ls_dwc[1] = "sog_com_cod"
		ls_dwc[2] = "sog_com_des"		
		
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", "rag_soc_1", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

	CASE "sog_com_cod2"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"	
		
		ls_dwc[1] = "sog_com_cod2"
		ls_dwc[2] = "sog_com_des2"
		
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
						
	case "sog_com_des2"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"			
		
		ls_dwc[1] = "sog_com_cod2"
		ls_dwc[2] = "sog_com_des2"		
		
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", "rag_soc_1", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
		
end choose

end event

type cb_1 from commandbutton within w_st_sog_com_barre_cx
int X=2272
int Y=440
int Width=247
int Height=108
int TabOrder=20
boolean BringToTop=true
string Text="&Stampa"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string ls_da_sog, ls_a_sog
str_sog_com_barre str

ls_da_sog = dw_1.getitemstring(1,"sog_com_cod")
ls_a_sog  = dw_1.getitemstring(1,"sog_com_cod2")

str.da_sog_com= ls_da_sog
str.a_sog_com = ls_a_sog

openwithparm(w_st_sog_com_barre_rpt,str)
end event

