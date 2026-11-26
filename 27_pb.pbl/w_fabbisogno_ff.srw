forward
global type w_fabbisogno_ff from w_p_data
end type
type dw_fabbisogno_ff from u_dw_master_main within w_fabbisogno_ff
end type
end forward

global type w_fabbisogno_ff from w_p_data
int Width=2661
int Height=1305
boolean TitleBar=true
string Title="Dettaglio fabbisogno scorte "
dw_fabbisogno_ff dw_fabbisogno_ff
end type
global w_fabbisogno_ff w_fabbisogno_ff

on w_fabbisogno_ff.create
int iCurrent
call w_p_data::create
this.dw_fabbisogno_ff=create dw_fabbisogno_ff
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=dw_fabbisogno_ff
end on

on w_fabbisogno_ff.destroy
call w_p_data::destroy
destroy(this.dw_fabbisogno_ff)
end on

event open;call super::open;
cb_cancella.visible	= false
cb_inserisci.visible	= false

idw_master 									= dw_fabbisogno_ff
idw_master.is_list 						= Message.PowerObjectParm
idw_master.ib_use_scanner 				= TRUE
idw_master.is_list.s_sql_ident[1] 	= "fabbisogno.id_fabbisogno"





end event

type p_crescente from w_p_data`p_crescente within w_fabbisogno_ff
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_fabbisogno_ff
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_fabbisogno_ff
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_fabbisogno_ff
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_fabbisogno_ff
int X=641
boolean Visible=false
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_fabbisogno_ff
int X=1761
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_fabbisogno_ff
int X=2058
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_fabbisogno_ff
int X=2355
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_fabbisogno_ff
boolean Visible=false
boolean BringToTop=true
long BackColor=79741120
end type

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=19
int Y=17
int Width=2323
int Height=1289
boolean Visible=false
long BackColor=79741120
long TabBackColor=79741120
end type

type cb_ricerca from w_p_data`cb_ricerca within w_fabbisogno_ff
int X=1441
boolean BringToTop=true
end type

type dw_fabbisogno_ff from u_dw_master_main within w_fabbisogno_ff
int X=46
int Y=181
int Width=2561
int Height=1001
int TabOrder=3
string DataObject="d_fabbisogno_scorte_ff"
end type

event ue_set_search;call super::ue_set_search;
long ll_row,ll_id_unita

choose case as_nomecol
		
	case "sog_commerciale_gen_codice"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 	
		is_ricpar.s_filter_value = as_valcol 						
		is_ricpar.s_filter_name = "codice" 							
				
	case "sog_commerciale_gen_rag_soc_1"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 	
		is_ricpar.s_filter_value = as_valcol 						
		is_ricpar.s_filter_name = "rag_soc_1" 						

end choose


end event

event ue_use_search;call super::ue_use_search;

choose case as_nomecol	
	case "sog_commerciale_gen_codice"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("sog_commerciale_gen_rag_soc_1", is_ricpar.s_ausil_value[1])
		uf_set_colval("fabbisogno_id_sog_commerciale", is_ricpar.s_id_seg_value[1])
		
	case "sog_commerciale_gen_rag_soc_1"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("sog_commerciale_gen_codice", is_ricpar.s_ausil_value[1])
		uf_set_colval("fabbisogno_id_sog_commerciale", is_ricpar.s_id_seg_value[1])
		
end choose

end event

event ue_init;call super::ue_init;is_title	= "Fabbisogno scorte"
end event

event itemchanged;call super::itemchanged;
string    ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
long      ll_ok, ll_id_sog_commerciale, ll_id_banca_appoggio
long		 ll_row, ll_ret, ll_temp

ls_sql_cond = ""  

choose case dwo.name
		
	case 'sog_commerciale_gen_codice'
		ls_dbc[1]  	= "id_sog_commerciale"
		ls_dwc[1]  	= "fabbisogno_id_sog_commerciale"
		ls_dbc[2]  	= "codice"
		ls_dwc[2]  	= "sog_commerciale_gen_codice"
		ls_dbc[3]  	= "rag_soc_1"
		ls_dwc[3]  	= "sog_commerciale_gen_rag_soc_1"
		ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &
										"codice", "A", data, &
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)

		IF (ll_ok > 0) THEN
			RETURN 2
		END IF

	case 'sog_commerciale_gen_rag_soc_1'
		ls_dbc[1]  	= "id_sog_commerciale"
		ls_dwc[1]  	= "fabbisogno_id_sog_commerciale"
      ls_dbc[2]  	= "codice"
		ls_dwc[2]  	= "sog_commerciale_gen_codice"
		ls_dbc[3]  	= "rag_soc_1"
		ls_dwc[3]  	= "sog_commerciale_gen_rag_soc_1"
		ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &
										"rag_soc_1", "A", data, &
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
	
end choose



end event

