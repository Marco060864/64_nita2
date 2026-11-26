forward
global type w_riep_provvigione_ff from w_p_data
end type
type dw_riep_provvigione_ff from u_dw_master_main within w_riep_provvigione_ff
end type
end forward

global type w_riep_provvigione_ff from w_p_data
int Height=997
boolean TitleBar=true
string Title="Riepilogo Provvigioni - dettaglio"
dw_riep_provvigione_ff dw_riep_provvigione_ff
end type
global w_riep_provvigione_ff w_riep_provvigione_ff

on w_riep_provvigione_ff.create
int iCurrent
call w_p_data::create
this.dw_riep_provvigione_ff=create dw_riep_provvigione_ff
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=dw_riep_provvigione_ff
end on

on w_riep_provvigione_ff.destroy
call w_p_data::destroy
destroy(this.dw_riep_provvigione_ff)
end on

event open;call super::open;
il_HelpTopic = 1

idw_master = dw_riep_provvigione_ff
idw_master.is_list = Message.PowerObjectParm

idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_sql_ident[1] = "riep_provvigione.id_riep_provvigioni"
end event

type p_crescente from w_p_data`p_crescente within w_riep_provvigione_ff
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_riep_provvigione_ff
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_riep_provvigione_ff
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_riep_provvigione_ff
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_riep_provvigione_ff
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_riep_provvigione_ff
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_riep_provvigione_ff
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_riep_provvigione_ff
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_riep_provvigione_ff
int X=2218
int Y=1301
int Width=161
int Height=181
boolean BringToTop=true
end type

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=19
int Y=105
int Width=124
int Height=61
end type

type cb_ricerca from w_p_data`cb_ricerca within w_riep_provvigione_ff
boolean BringToTop=true
end type

type dw_riep_provvigione_ff from u_dw_master_main within w_riep_provvigione_ff
int X=46
int Y=181
int Width=2318
int Height=693
int TabOrder=1
string DataObject="d_riep_provvigione_ff"
end type

event ue_init;call super::ue_init;is_title = "Riepilogo di Provvigioni"

end event

event itemchanged;call super::itemchanged;

string    ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
long      ll_ok

ls_sql_cond = ""

CHOOSE CASE dwo.name

	CASE 'c_codice_cliente_doc'
		ls_dbc[1] = "id_sog_commerciale"
		ls_dwc[1] = "id_cliente"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_codice_cliente_doc"
		ls_dbc[3] = "rag_soc_1"
		ls_dwc[3] = "c_rag_soc_cliente_doc"
	   ls_sql_cond = "sog_commerciale_gen.tipo = 'C'"
		ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &  
										"codice", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF			
		
	CASE 'c_rag_soc_cliente_doc'
		ls_dbc[1] = "id_sog_commerciale"
		ls_dwc[1] = "id_cliente"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_codice_cliente_doc"
		ls_dbc[3] = "rag_soc_1"
		ls_dwc[3] = "c_rag_soc_cliente_doc"
	   ls_sql_cond = "sog_commerciale_gen.tipo = 'C'"
		ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &  
										"rag_soc_1", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF			
		
END CHOOSE

end event

event ue_set_search;call super::ue_set_search;CHOOSE CASE as_nomecol
	CASE "c_codice_cliente_doc"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice" 
		is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo = 'C'"
	CASE "c_rag_soc_cliente_doc"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "rag_soc_1" 
		is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo = 'C'"
END CHOOSE


end event

event ue_use_search;call super::ue_use_search;CHOOSE CASE as_nomecol
	CASE "c_codice_cliente_doc"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("c_rag_soc_cliente_doc", is_ricpar.s_ausil_value[1])
		uf_set_colval("id_cliente", is_ricpar.s_id_seg_value[1])
	CASE "c_rag_soc_cliente_doc"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("c_codice_cliente_doc", is_ricpar.s_ausil_value[1])
		uf_set_colval("id_cliente", is_ricpar.s_id_seg_value[1])
END CHOOSE

end event

event ue_retrieve;call super::ue_retrieve;

string    ls_codice, ls_ragsoc
long      ll_idsc, ll_row, ll_nrows

ll_nrows = this.RowCount()
if ll_nrows>0 then
	for ll_row = 1 to ll_nrows
		ll_idsc = this.GetItemNumber(ll_row,"id_cliente")
		select	"sog_commerciale_gen"."codice", "sog_commerciale_gen"."rag_soc_1"
			into	:ls_codice, :ls_ragsoc
			from	"dba"."sog_commerciale_gen"
			where	"sog_commerciale_gen"."id_sog_commerciale" = :ll_idsc;
		if sqlca.sqlcode = 0 then
			setItem(ll_row,"c_codice_cliente_doc",ls_codice)
			setItem(ll_row,"c_rag_soc_cliente_doc",ls_ragsoc)
			setItemStatus(ll_row,"c_codice_cliente_doc",Primary!,NotModified!)
			setItemStatus(ll_row,"c_rag_soc_cliente_doc",Primary!,NotModified!)
		end if
	next
end if


end event

