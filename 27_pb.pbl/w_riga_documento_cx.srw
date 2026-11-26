forward
global type w_riga_documento_cx from w_p_data
end type
type dw_riga_documento_gen_ff from u_dw_master_main within tabpage_1
end type
type dw_riga_documento_gen_ff from u_dw_master_main within tabpage_1
end type
type tabpage_2 from userobject within tab_1
end type
type dw_riga_documento_mag_ff from u_dw_master_main within tabpage_2
end type
type tabpage_3 from userobject within tab_1
end type
type dw_riga_documento_altro_ff from u_dw_master_main within tabpage_3
end type
type tabpage_2 from userobject within tab_1
dw_riga_documento_mag_ff dw_riga_documento_mag_ff
end type
type tabpage_3 from userobject within tab_1
dw_riga_documento_altro_ff dw_riga_documento_altro_ff
end type
end forward

global type w_riga_documento_cx from w_p_data
int Width=2981
int Height=1617
boolean TitleBar=true
string Title="Riga Documento"
end type
global w_riga_documento_cx w_riga_documento_cx

event open;call super::open;idw_master = tab_1.tabpage_1.dw_riga_documento_gen_ff
idw_master.is_list = Message.PowerObjectParm

idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_sql_ident[1] = "riga_documento.id_riga_documento"
end event

on w_riga_documento_cx.create
int iCurrent
call w_p_data::create
iCurrent=UpperBound(this.Control)
end on

on w_riga_documento_cx.destroy
call w_p_data::destroy
end on

type p_crescente from w_p_data`p_crescente within w_riga_documento_cx
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_riga_documento_cx
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_riga_documento_cx
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_riga_documento_cx
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_riga_documento_cx
int X=641
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_riga_documento_cx
int X=2058
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_riga_documento_cx
int X=2355
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_riga_documento_cx
int X=2652
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_riga_documento_cx
int X=46
int Width=2881
boolean BringToTop=true
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type

on tab_1.create
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=tabpage_2
this.Control[iCurrent+2]=tabpage_3
end on

on tab_1.destroy
call super::destroy
destroy(this.tabpage_2)
destroy(this.tabpage_3)
end on

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=19
int Y=105
int Width=2844
int Height=1201
long BackColor=79741120
string Text="Generale"
long TabBackColor=79741120
dw_riga_documento_gen_ff dw_riga_documento_gen_ff
end type

on tabpage_1.create
this.dw_riga_documento_gen_ff=create dw_riga_documento_gen_ff
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=dw_riga_documento_gen_ff
end on

on tabpage_1.destroy
call super::destroy
destroy(this.dw_riga_documento_gen_ff)
end on

type dw_riga_documento_gen_ff from u_dw_master_main within tabpage_1
int X=28
int Y=37
int Width=2789
int Height=1141
int TabOrder=3
string DataObject="d_riga_documento_gen_ff"
end type

event ue_init;call super::ue_init;
iudw_children[1] = tab_1.tabpage_2.dw_riga_documento_mag_ff
iudw_children[2] = tab_1.tabpage_3.dw_riga_documento_altro_ff
end event

event ue_set_search;call super::ue_set_search;
CHOOSE CASE as_nomecol

	CASE "c_articolo_cod"
		is_search_window = "w_articolo_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "articolo_codice" 
	CASE "c_articolo_des"
		is_search_window = "w_articolo_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "articolo_descrizione" 
	
	CASE "c_unita_confezione_cod"
		is_search_window = "w_unita_confezione_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "unita_confezione_codice" 
		is_ricpar.s_sql_cond = "unita_confezione.id_articolo = " + string(uf_get_colval("id_articolo"))
	CASE "c_unita_confezione_des"
		is_search_window = "w_unita_confezione_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "unita_confezione_descrizione" 
		is_ricpar.s_sql_cond = "unita_confezione.id_articolo = " + string(uf_get_colval("id_articolo"))

	CASE "cc_lis_articolo"
		is_search_window = "w_con_lis_articolo_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "con_lis_articolo_tipo_applicazione"
		
END CHOOSE

CHOOSE CASE as_nomecol
		
	CASE "id_valuta_cod"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_valuta_gd"
		is_ricpar.s_titolo_finestra = "Valute"
		is_ricpar.s_ausil_value[1] = "id_valuta_des"
		is_ricpar.i_width  = 2798
		is_ricpar.i_height = 861
	CASE "id_valuta_des"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_valuta_gd"
		is_ricpar.s_titolo_finestra = "Valute"
		is_ricpar.s_ausil_value[1] = "id_valuta_cod"
		is_ricpar.i_width  = 2798
		is_ricpar.i_height = 861

END CHOOSE


end event

event ue_use_search;call super::ue_use_search;

string ls_reg_tipo, ls_descrizione

CHOOSE CASE as_nomecol
	
	CASE "c_articolo_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_articolo", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_articolo_des", is_ricpar.s_ausil_value[1])
	CASE "c_articolo_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_articolo", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_articolo_cod", is_ricpar.s_ausil_value[1])
		
	CASE "c_unita_confezione_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_unita_confezione", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_unita_confezione_des", is_ricpar.s_ausil_value[1])
	CASE "c_unita_confezione_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_unita_confezione", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_unita_confezione_cod", is_ricpar.s_ausil_value[1])
		
	CASE "cc_lis_articolo"
		ls_reg_tipo = is_ricpar.s_main_value

		CHOOSE CASE ls_reg_tipo
			CASE "N"
				ls_descrizione = "Normale"
			CASE "I"
				ls_descrizione = "Sconto Importo"
			CASE "R"
				ls_descrizione = "Sconto Riga"
		CASE ELSE
				ls_descrizione = ""
		END CHOOSE
		uf_set_colval(as_nomecol, ls_descrizione + " - " + is_ricpar.s_ausil_value[1] + " - " +  &
			is_ricpar.s_ausil_value[2])
		uf_set_colval("id_con_lis_articolo", is_ricpar.s_id_seg_value[1])

END CHOOSE

end event

event itemchanged;call super::itemchanged;

string    ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
long      ll_ok

ls_sql_cond = ""

CHOOSE CASE dwo.name
		
	CASE 'c_articolo_cod'
		ls_dbc[1] = "id_articolo"
		ls_dwc[1] = "id_articolo"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_articolo_cod"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "c_articolo_des"
		ll_ok = uf_autofind_col(dwo.Name, "articolo", &
										"codice", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF	
	
	CASE 'c_articolo_des'
		ls_dbc[1] = "id_articolo"
		ls_dwc[1] = "id_articolo"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_articolo_cod"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "c_articolo_des"
		ll_ok = uf_autofind_col(dwo.Name, "articolo", &
										"descrizione", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
	
	CASE 'c_unita_confezione_cod'
		ls_dbc[1] = "id_unita_confezione"
		ls_dwc[1] = "id_unita_confezione"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_unita_confezione_cod"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "c_unita_confezione_des"
		ll_ok = uf_autofind_col(dwo.Name, "unita_confezione", &
										"codice", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF		
		
	CASE 'c_unita_confezione_des'
		ls_dbc[1] = "id_unita_confezione"
		ls_dwc[1] = "id_unita_confezione"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_unita_confezione_cod"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "c_unita_confezione_des"
		ll_ok = uf_autofind_col(dwo.Name, "unita_confezione", &
										"descrizione", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF

	CASE "cc_lis_articolo"
		uf_SW_SetNull(data, "id_con_lis_articolo")
		

END CHOOSE

end event

event rowfocuschanged;call super::rowfocuschanged;

string ls_inizio, ls_fine, ls_tipo , ls_value, ls_reg_tipo, ls_codice, ls_descrizione
long ll_id_articolo, ll_id_unita_confezione, ll_id_con_lis_articolo,&
	  ll_row

ll_row = GetRow()

if RowCount() > 0 then

ll_id_articolo = long(uf_get_colval("id_articolo"))

	
	SELECT "articolo"."codice" , "articolo"."descrizione" 
	  	INTO : ls_codice, :ls_descrizione
     	FROM "articolo"
	 	WHERE ( "articolo"."id_articolo" = :ll_id_articolo )   ;
	
	uf_set_colval("c_articolo_cod",ls_codice)
	uf_set_colval("c_articolo_des",ls_descrizione)
	
	
	setitemstatus(ll_row, "c_articolo_cod", PRIMARY!, NotModified!)
	setitemstatus(ll_row, "c_articolo_des", PRIMARY!, NotModified!)
ls_codice = ""
ls_descrizione = ""

ll_id_unita_confezione = long(uf_get_colval("id_unita_confezione"))

	
	SELECT "unita_confezione"."codice" , "unita_confezione"."descrizione" 
	  	INTO : ls_codice, :ls_descrizione
     	FROM "unita_confezione"
	 	WHERE ( "unita_confezione"."id_unita_confezione" = :ll_id_unita_confezione )   ;
	
	uf_set_colval("c_unita_confezione_cod",ls_codice)
	uf_set_colval("c_unita_confezione_des",ls_descrizione)
	
	
	setitemstatus(ll_row, "c_unita_confezione_cod", PRIMARY!, NotModified!)
	setitemstatus(ll_row, "c_unita_confezione_des", PRIMARY!, NotModified!)
ls_codice = ""
ls_descrizione = ""

	
	ll_id_con_lis_articolo = long(uf_get_colval("id_con_lis_articolo"))

	
  SELECT "con_lis_articolo"."data_inizio",   
         "con_lis_articolo"."data_fine",   
         "con_lis_articolo"."tipo_applicazione"  
    INTO :ls_inizio,   
         :ls_fine,   
         :ls_tipo  
    FROM "con_lis_articolo"  
   WHERE "con_lis_articolo"."id_con_lis_articolo" = :ll_id_con_lis_articolo   ;
	ls_reg_tipo = ls_tipo

		CHOOSE CASE ls_reg_tipo
			CASE "N"
				ls_descrizione = "Normale"
			CASE "I"
				ls_descrizione = "Sconto Importo"
			CASE "R"
				ls_descrizione = "Sconto Riga"
		CASE ELSE
				ls_descrizione = ""
		END CHOOSE

	ls_value = ls_descrizione + " - " + ls_inizio + " - " + ls_fine
	
	uf_set_colval("cc_lis_articolo",ls_value)
	
	
	setitemstatus(ll_row, "cc_lis_articolo", PRIMARY!, NotModified!)
ls_descrizione = ""
	
end if
end event

type tabpage_2 from userobject within tab_1
int X=19
int Y=105
int Width=2844
int Height=1201
long BackColor=79741120
string Text="Magazzino"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_riga_documento_mag_ff dw_riga_documento_mag_ff
end type

on tabpage_2.create
this.dw_riga_documento_mag_ff=create dw_riga_documento_mag_ff
this.Control[]={ this.dw_riga_documento_mag_ff}
end on

on tabpage_2.destroy
destroy(this.dw_riga_documento_mag_ff)
end on

type dw_riga_documento_mag_ff from u_dw_master_main within tabpage_2
int X=28
int Y=37
int Width=2789
int Height=1141
int TabOrder=1
string DataObject="d_riga_documento_mag_ff"
end type

event ue_init;call super::ue_init;ib_dw_shared = TRUE
is_list.s_colonne_drop[1] = "id_caus_magazzino_cod"
is_list.s_colonne_drop[2] = "id_caus_magazzino_des"
is_list.s_colonne_drop[3] = "id_locazione_1"
is_list.s_colonne_drop[4] = "id_locazione_2"
is_list.s_colonne_drop[5] = "id_tab_iva_cod"
is_list.s_colonne_drop[6] = "id_tab_iva_des"
end event

type tabpage_3 from userobject within tab_1
int X=19
int Y=105
int Width=2844
int Height=1201
long BackColor=79741120
string Text="Altro"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_riga_documento_altro_ff dw_riga_documento_altro_ff
end type

on tabpage_3.create
this.dw_riga_documento_altro_ff=create dw_riga_documento_altro_ff
this.Control[]={ this.dw_riga_documento_altro_ff}
end on

on tabpage_3.destroy
destroy(this.dw_riga_documento_altro_ff)
end on

type dw_riga_documento_altro_ff from u_dw_master_main within tabpage_3
int X=28
int Y=37
int Width=2789
int Height=1141
int TabOrder=4
string DataObject="d_riga_documento_altro_ff"
end type

event ue_init;call super::ue_init;ib_dw_shared = TRUE
is_list.s_colonne_drop[1] = "id_caus_trasporto_cod"
is_list.s_colonne_drop[2] = "id_caus_trasporto"

end event

event ue_set_search;call super::ue_set_search;
CHOOSE CASE as_nomecol
	
	CASE "c_des_articolo_cod"
		is_search_window = "w_des_articolo_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice" 
		is_ricpar.s_sql_cond = "des_articolo.id_articolo = " + string(uf_get_colval("id_articolo"))
	CASE "c_des_articolo_des"
		is_search_window = "w_des_articolo_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "descrizione" 
		is_ricpar.s_sql_cond = "des_articolo.id_articolo = " + string(uf_get_colval("id_articolo"))

	CASE "c_sog_commerciale_agente_cod"
		is_search_window = "w_sog_commerciale_gen_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "codice"
		is_ricpar.s_sql_cond = f_tilde_quote("sog_commerciale_gen.tipo") + " = 'A' "
	CASE "c_sog_commerciale_agente_des"
		is_search_window = "w_sog_commerciale_gen_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "rag_soc_1"
		is_ricpar.s_sql_cond = f_tilde_quote("sog_commerciale_gen.tipo") + " = 'A' "

	CASE "c_conto_cod"
		is_search_window = "w_conto_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "conto_codice" 

END CHOOSE

CHOOSE CASE as_nomecol
		
	CASE "id_caus_trasporto_cod"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_caus_trasporto_gd"
		is_ricpar.s_titolo_finestra = "Causali Trasporto"
		is_ricpar.s_ausil_value[1] = "id_caus_trasporto"
	CASE "id_caus_trasporto"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_caus_trasporto_gd"
		is_ricpar.s_titolo_finestra = "Causali Trasporto"
		is_ricpar.s_ausil_value[1] = "id_caus_trasporto_cod"

END CHOOSE


end event

event ue_use_search;call super::ue_use_search;

CHOOSE CASE as_nomecol

	CASE "c_des_articolo_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_des_articolo", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_des_articolo_des", is_ricpar.s_ausil_value[1])
	CASE "c_des_articolo_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_des_articolo", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_des_articolo_cod", is_ricpar.s_ausil_value[1])
		
	CASE "c_sog_commerciale_agente_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_sog_commerciale_agente", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_sog_commerciale_agente_des", is_ricpar.s_ausil_value[1])
	CASE "c_sog_commerciale_agente_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_sog_commerciale_agente", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_sog_commerciale_agente_cod", is_ricpar.s_ausil_value[1])

	CASE "c_conto_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_conto", is_ricpar.s_id_seg_value[1])	

END CHOOSE

end event

event itemchanged;call super::itemchanged;

string    ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
long      ll_ok

ls_sql_cond = ""

CHOOSE CASE dwo.name
		
	CASE 'c_des_articolo_cod'
		ls_dbc[1] = "id_des_articolo"
		ls_dwc[1] = "id_des_articolo"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_des_articolo_cod"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "c_des_articolo_des"
		ll_ok = uf_autofind_col(dwo.Name, "des_articolo", &
										"codice", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
			
	CASE 'c_des_articolo_des'
		ls_dbc[1] = "id_des_articolo"
		ls_dwc[1] = "id_des_articolo"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_des_articolo_cod"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "c_des_articolo_des"
		ll_ok = uf_autofind_col(dwo.Name, "des_articolo", &
										"descrizione", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF

	CASE 'c_sog_commerciale_agente_cod'
		ls_sql_cond = "sog_commerciale_gen.tipo = 'A'"		
		ls_dbc[1] = "id_sog_commerciale"
		ls_dwc[1] = "id_sog_commerciale_agente"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_sog_commerciale_agente_cod"
		ls_dbc[3] = "rag_soc_1"
		ls_dwc[3] = "c_sog_commerciale_agente_des"
		ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &  
										"codice", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF

	CASE 'c_sog_commerciale_agente_des'
		ls_sql_cond = "sog_commerciale_gen.tipo = 'A'"		
		ls_dbc[1] = "id_sog_commerciale"
		ls_dwc[1] = "id_sog_commerciale_agente"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_sog_commerciale_agente_cod"
		ls_dbc[3] = "rag_soc_1"
		ls_dwc[3] = "c_sog_commerciale_agente_des"
		ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &  
										"rag_soc_1", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF		
	
	CASE 'c_conto_cod'
		ls_dbc[1] = "id_conto"
		ls_dwc[1] = "id_conto"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_conto_cod"
		ll_ok = uf_autofind_col(dwo.Name, "conto", &
										"codice", "A", data, & 
										ls_sql_cond, 2, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF	
	
END CHOOSE

end event

event rowfocuschanged;call super::rowfocuschanged;

string ls_codice, ls_descrizione
long   ll_id_des_articolo, ll_id_sog_commerciale_agente, ll_id_conto, ll_row

ll_row = GetRow()

if RowCount() > 0 then
	

ll_id_des_articolo = long(uf_get_colval("id_des_articolo"))

	
	SELECT "des_articolo"."codice" , "des_articolo"."descrizione" 
	  	INTO : ls_codice, :ls_descrizione
     	FROM "des_articolo"
	 	WHERE ( "des_articolo"."id_des_articolo" = :ll_id_des_articolo )   ;
	
	uf_set_colval("c_des_articolo_cod",ls_codice)
	uf_set_colval("c_des_articolo_des",ls_descrizione)
	
	
	setitemstatus(ll_row, "c_des_articolo_cod", PRIMARY!, NotModified!)
	setitemstatus(ll_row, "c_des_articolo_des", PRIMARY!, NotModified!)
ls_codice = ""
ls_descrizione = ""

ll_id_sog_commerciale_agente = long(uf_get_colval("id_sog_commerciale_agente"))

	
	SELECT "sog_commerciale_gen"."codice" , "sog_commerciale_gen"."rag_soc_1" 
	  	INTO : ls_codice, :ls_descrizione
     	FROM "sog_commerciale_gen"
	 	WHERE ( "sog_commerciale_gen"."id_sog_commerciale" = :ll_id_sog_commerciale_agente )   ;
	
	uf_set_colval("c_sog_commerciale_agente_cod",ls_codice)
	uf_set_colval("c_sog_commerciale_agente_des",ls_descrizione)
	
	
	setitemstatus(ll_row, "c_sog_commerciale_agente_cod", PRIMARY!, NotModified!)
	setitemstatus(ll_row, "c_sog_commerciale_agente_des", PRIMARY!, NotModified!)   
ls_codice = ""
ls_descrizione = ""

	ll_id_conto = long(uf_get_colval("id_conto"))

	
	SELECT "conto"."codice" 
	  	INTO :ls_codice
     	FROM "conto"
	 	WHERE ( "conto"."id_conto" = :ll_id_conto )   ;
	
	uf_set_colval("c_conto_cod",ls_codice)
	
	
	setitemstatus(ll_row, "c_conto_cod", PRIMARY!, NotModified!)
ls_codice = ""
	
end if
end event

