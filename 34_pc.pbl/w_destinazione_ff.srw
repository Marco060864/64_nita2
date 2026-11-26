forward
global type w_destinazione_ff from w_p_data
end type
type dw_destinazione_ff from u_dw_master_main within tabpage_1
end type
type tabpage_2 from userobject within tab_1
end type
type dw_destinazione_age_ff from u_dw_master_main within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_destinazione_age_ff dw_destinazione_age_ff
end type
type tabpage_3 from userobject within tab_1
end type
type dw_destinazione_ann_gd from u_dw_master_main within tabpage_3
end type
type tabpage_3 from userobject within tab_1
dw_destinazione_ann_gd dw_destinazione_ann_gd
end type
end forward

global type w_destinazione_ff from w_p_data
integer width = 2638
integer height = 1720
string title = "Dettaglio della destinazione"
end type
global w_destinazione_ff w_destinazione_ff

forward prototypes
public function string wf_select_sogg (long id_sogg_commerciale, integer scelta)
end prototypes

public function string wf_select_sogg (long id_sogg_commerciale, integer scelta);string ls_ritorno


choose case scelta
	case 1
		SELECT "sog_commerciale_gen"."codice"
		INTO :ls_ritorno
		FROM	"sog_commerciale_gen"
		WHERE "sog_commerciale_gen"."id_sog_commerciale" = :id_sogg_commerciale;
	case 2
		SELECT "sog_commerciale_gen"."rag_soc_1"
		INTO :ls_ritorno
		FROM	"sog_commerciale_gen"
		WHERE "sog_commerciale_gen"."id_sog_commerciale" = :id_sogg_commerciale;
end choose

return ls_ritorno
end function

on w_destinazione_ff.create
int iCurrent
call super::create
end on

on w_destinazione_ff.destroy
call super::destroy
end on

event open;call super::open;idw_master = tab_1.tabpage_1.dw_destinazione_ff
idw_master.is_list = Message.PowerObjectParm

idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_sql_ident[1] = "destinazione.id_destinazione"

end event

type p_msg_log from w_p_data`p_msg_log within w_destinazione_ff
end type

type p_crescente from w_p_data`p_crescente within w_destinazione_ff
end type

type p_decrescente from w_p_data`p_decrescente within w_destinazione_ff
end type

type cb_ok from w_p_data`cb_ok within w_destinazione_ff
integer x = 37
integer y = 32
end type

type cb_annulla from w_p_data`cb_annulla within w_destinazione_ff
integer x = 329
integer y = 32
end type

type cb_nuovo from w_p_data`cb_nuovo within w_destinazione_ff
integer x = 617
integer y = 32
end type

type cb_inserisci from w_p_data`cb_inserisci within w_destinazione_ff
integer y = 32
integer taborder = 30
end type

type cb_cancella from w_p_data`cb_cancella within w_destinazione_ff
integer y = 32
integer taborder = 20
end type

type cb_salva from w_p_data`cb_salva within w_destinazione_ff
integer x = 2304
integer y = 32
end type

event cb_salva::clicked;
idw_master.setitem(idw_master.getrow(),"codice",idw_master.getitemnumber(idw_master.getrow(),"codice"))
parent.TriggerEvent("ue_update")

end event

type tab_1 from w_p_data`tab_1 within w_destinazione_ff
integer x = 37
integer y = 160
integer width = 2565
integer height = 1368
integer taborder = 10
long backcolor = 79741120
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type

on tab_1.create
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_2
this.Control[iCurrent+2]=this.tabpage_3
end on

on tab_1.destroy
call super::destroy
destroy(this.tabpage_2)
destroy(this.tabpage_3)
end on

type tabpage_1 from w_p_data`tabpage_1 within tab_1
integer width = 2528
integer height = 1248
long backcolor = 79741120
string text = "Generale"
long tabbackcolor = 79741120
dw_destinazione_ff dw_destinazione_ff
end type

on tabpage_1.create
this.dw_destinazione_ff=create dw_destinazione_ff
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_destinazione_ff
end on

on tabpage_1.destroy
call super::destroy
destroy(this.dw_destinazione_ff)
end on

type cb_ricerca from w_p_data`cb_ricerca within w_destinazione_ff
integer y = 32
end type

type dw_destinazione_ff from u_dw_master_main within tabpage_1
integer x = 32
integer y = 40
integer width = 2459
integer height = 1164
integer taborder = 12
boolean bringtotop = true
string dataobject = "d_destinazione_ff"
end type

event itemchanged;

string    ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
long      ll_ok, ll_id_loc

ls_sql_cond = ""
CHOOSE CASE dwo.name

	CASE 'c_magazzino_codice'
		ls_dbc[1] = "id_magazzino"
		ls_dwc[1] = "id_magazzino"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_magazzino_codice"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "c_magazzino_descrizione"
		ll_ok = uf_autofind_col(dwo.Name, "magazzino", &
										"codice", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
										
									
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
		if upperbound(ls_dbv) >0 then
			ll_id_loc=	long(ls_dbv[1])
			
			
			select min(id_locazione) 
			into :ll_id_loc
			from locazione
			where locazione.id_magazzino=:ll_id_loc;
			setitem(getrow(), "id_magazzino", ll_id_loc)
		end if
		
	CASE 'c_magazzino_descrizione'
		ls_dbc[1] = "id_magazzino"
		ls_dwc[1] = "id_magazzino"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_magazzino_codice"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "c_magazzino_descrizione"
		ll_ok = uf_autofind_col(dwo.Name, "magazzino", &
										"descrizione", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
									
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
		if upperbound(ls_dbv) >0 then
			ll_id_loc=	long(ls_dbv[1])
			
			
			select min(id_locazione) 
			into :ll_id_loc
			from locazione
			where locazione.id_magazzino=:ll_id_loc;
			setitem(getrow(), "id_magazzino", ll_id_loc)
		end if
		
	CASE 'con_pagamento_codice'
      ls_sql_cond = ""  
		ls_dbc[1] = "id_con_pagamento"
		ls_dwc[1] = "id_con_pagamento"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "con_pagamento_codice"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "con_pagamento_descrizione"
		ll_ok = uf_autofind_col(dwo.Name, "con_pagamento", &  
										"codice", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF

	CASE 'con_pagamento_descrizione'

		ls_sql_cond = ""  
		ls_dbc[1] = "id_con_pagamento"
		ls_dwc[1] = "id_con_pagamento"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "con_pagamento_codice"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "con_pagamento_descrizione"
		ll_ok = uf_autofind_col(dwo.Name, "con_pagamento", &  
										"descrizione", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
	
END CHOOSE




end event

event ue_init;call super::ue_init;is_list.s_identifica[1] = "id_destinazione"
iudw_children[1] = tab_1.tabpage_2.dw_destinazione_age_ff
iudw_children[2] = tab_1.tabpage_3.dw_destinazione_ann_gd
end event

event ue_initial;call super::ue_initial;

long		ll_row, ll_id_sc, ll_des_cat_attivita, ll_des_cat_com_sc, ll_des_cat_zona, &
			ll_id_magazzino
string   ls_rag_soc_1, ls_rag_soc_2, ls_indirizzo, ls_cap, ls_localita, ls_provincia, &
         ls_nazione
integer	li_num_des			
 
ll_row = GetRow()
ll_id_sc = GetItemNumber(ll_row, "id_sog_commerciale")

if (ll_row > 0  AND ll_id_sc > 0) then
	  SELECT "sog_commerciale"."id_cat_attivita",   
         "anagrafica"."rag_soc_1",   
         "anagrafica"."rag_soc_2",   
         "sog_commerciale"."id_cat_com_sc",   
         "sog_commerciale"."id_cat_zona",   
         "anagrafica"."indirizzo",   
         "anagrafica"."cap",   
         "anagrafica"."localita",   
         "anagrafica"."provincia",   
         "anagrafica"."nazione",   
         "sog_commerciale"."id_magazzino"  
    INTO :ll_des_cat_attivita,   
         :ls_rag_soc_1,   
         :ls_rag_soc_2,   
         :ll_des_cat_com_sc,   
         :ll_des_cat_zona,   
         :ls_indirizzo,   
         :ls_cap,   
         :ls_localita,   
         :ls_provincia,   
         :ls_nazione,   
         :ll_id_magazzino  
    FROM "anagrafica",   
         "sog_commerciale"   
   WHERE ( "sog_commerciale"."id_anagrafica" = "anagrafica"."id_anagrafica" ) and  
         ( "sog_commerciale"."id_sog_commerciale" = :ll_id_sc )   ;
	CHOOSE CASE SQLCA.SQLCode
		CASE 0
			SetItem(ll_row, "des_cat_attivita", ll_des_cat_attivita)
			SetItem(ll_row, "rag_soc_1", ls_rag_soc_1)
			SetItem(ll_row, "rag_soc_2", ls_rag_soc_2)
			SetItem(ll_row, "des_cat_com_sc", ll_des_cat_com_sc)
			SetItem(ll_row, "des_cat_zona", ll_des_cat_zona)
			SetItem(ll_row, "indirizzo", ls_indirizzo)
			SetItem(ll_row, "cap", ls_cap)
			SetItem(ll_row, "localita", ls_localita)
			SetItem(ll_row, "provincia", ls_provincia)
			SetItem(ll_row, "nazione", ls_nazione)
			SetItem(ll_row, "id_magazzino", ll_id_magazzino)
			
			
			SELECT COUNT(*) + 1
			INTO	 :li_num_des
			FROM	 destinazione
			WHERE	 id_sog_commerciale = :ll_id_sc
			;
			SetItem(ll_row, "codice", li_num_des)			
			
		CASE -1, 100
			MessageBox("Errore sul DataBase", SQLCA.SQLErrText)
	END CHOOSE

end if
end event

event ue_set_search;call super::ue_set_search;

CHOOSE CASE as_nomecol
		
	CASE "c_magazzino_codice"
		is_search_window = "w_magazzino_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice" 
		
	CASE "c_magazzino_descrizione"
		is_search_window = "w_magazzino_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "descrizione" 

END CHOOSE

CHOOSE CASE as_nomecol
		
	CASE "id_cat_attivita"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_cat_attivita_gd"
		is_ricpar.s_titolo_finestra = "Categorie Attività"
		is_ricpar.s_ausil_value[1] = "des_cat_attivita"
	CASE "des_cat_attivita"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_cat_attivita_gd"
		is_ricpar.s_titolo_finestra = "Categorie Attività"
		is_ricpar.s_ausil_value[1] = "id_cat_attivita"
		
	CASE "id_cat_com_sc"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_cat_com_sc_gd"
		is_ricpar.s_titolo_finestra = "Categorie Commerciali"
		is_ricpar.s_ausil_value[1] = "des_cat_com_sc"
	CASE "des_cat_com_sc"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_cat_com_sc_gd"
		is_ricpar.s_titolo_finestra = "Categorie Commerciali"
		is_ricpar.s_ausil_value[1] = "id_cat_com_sc"

	CASE "id_cat_zona"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_cat_zona_gd"
		is_ricpar.s_titolo_finestra = "Categorie Zona"
		is_ricpar.s_ausil_value[1] = "des_cat_zona"
	CASE "des_cat_zona"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_cat_zona_gd"
		is_ricpar.s_titolo_finestra = "Categorie Zona"
		is_ricpar.s_ausil_value[1] = "id_cat_zona"
	
	CASE "con_pagamento_codice"
		is_search_window = "w_con_pagamento_sw"
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice" 
	CASE "con_pagamento_descrizione"
		is_search_window = "w_con_pagamento_sw"
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "descrizione" 
	
END CHOOSE

end event

event ue_use_search;
string ls_loc
integer i
long ll_row
CHOOSE CASE as_nomecol
		
	CASE "c_magazzino_codice"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_magazzino", is_ricpar.s_ausil_value[2])
		uf_set_colval("c_magazzino_descrizione", is_ricpar.s_ausil_value[1])
		ll_row=getrow()
		setitem(ll_row, "corsia", is_ricpar.s_ausil_value[3])
		setitem(ll_row, "scaffale", is_ricpar.s_ausil_value[4])
		setitem(ll_row, "ripiano", is_ricpar.s_ausil_value[5])		
		setitem(ll_row, "posizione", is_ricpar.s_ausil_value[6])
	
	CASE "c_magazzino_descrizione"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_magazzino", is_ricpar.s_ausil_value[2])
		uf_set_colval("c_magazzino_codice", is_ricpar.s_ausil_value[1])
		
		ll_row=getrow()
		setitem(ll_row, "corsia", is_ricpar.s_ausil_value[3])
		setitem(ll_row, "scaffale", is_ricpar.s_ausil_value[4])
		setitem(ll_row, "ripiano", is_ricpar.s_ausil_value[5])		
		setitem(ll_row, "posizione", is_ricpar.s_ausil_value[6])
		
	
	CASE "con_pagamento_codice"
	      	uf_set_colval( as_nomecol, is_ricpar.s_main_value)
				uf_set_colval( "con_pagamento_descrizione", is_ricpar.s_ausil_value[1])
				uf_set_colval( "id_con_pagamento", is_ricpar.s_id_seg_value[1])
	CASE  "con_pagamento_descrizione"
	      	uf_set_colval( as_nomecol, is_ricpar.s_main_value)
				uf_set_colval( "con_pagamento_codice", is_ricpar.s_ausil_value[1])
				uf_set_colval( "id_con_pagamento", is_ricpar.s_id_seg_value[1])
	
END CHOOSE
end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 2528
integer height = 1248
long backcolor = 79741120
string text = "Agenti"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_destinazione_age_ff dw_destinazione_age_ff
end type

on tabpage_2.create
this.dw_destinazione_age_ff=create dw_destinazione_age_ff
this.Control[]={this.dw_destinazione_age_ff}
end on

on tabpage_2.destroy
destroy(this.dw_destinazione_age_ff)
end on

type dw_destinazione_age_ff from u_dw_master_main within tabpage_2
integer x = 27
integer y = 40
integer width = 2464
integer height = 1092
integer taborder = 12
boolean bringtotop = true
string dataobject = "d_destinazione_age_ff"
end type

event itemchanged;

string    ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
long      ll_ok, ll_id_loc

ls_sql_cond = ""
CHOOSE CASE dwo.name

	CASE "gruppo_agenti_codice"
		ls_dbc[1] = "id_gruppo_agenti"
		ls_dwc[1] = "destinazione_id_gruppo_agenti"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "gruppo_agenti_codice"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "gruppo_agenti_descrizione"
		ls_dbc[4] = "id_sog_com_capo_area"
		ls_dwc[4] = "sog_commerciale_a_id_sog_commerciale"
		ls_dbc[5] = "id_sog_com_agente"
		ls_dwc[5] = "sog_commerciale_b_id_sog_commerciale"
		ls_dbc[6] = "id_sog_com_sub_agente"
		ls_dwc[6] = "sog_commerciale_c_id_sog_commerciale"
		
		ll_ok = uf_autofind_col(dwo.Name, "gruppo_agenti", &
										"codice", "A", data, & 
										ls_sql_cond, 6, &
										ls_dbc, ls_dbv, ls_dwc)
		if (ll_ok > 0) then
			
			uf_set_colval("sog_commerciale_gen_a_codice",wf_select_sogg( long(ls_dbv[4]), 1))
			uf_set_colval("sog_commerciale_gen_a_rag_soc_1",wf_select_sogg( long(ls_dbv[4]), 2))

			uf_set_colval("sog_commerciale_gen_b_codice",wf_select_sogg( long(ls_dbv[5]), 1))
			uf_set_colval("sog_commerciale_gen_b_rag_soc_1",wf_select_sogg( long(ls_dbv[5]), 2))

			uf_set_colval("sog_commerciale_gen_c_codice",wf_select_sogg( long(ls_dbv[6]), 1))
			uf_set_colval("sog_commerciale_gen_c_rag_soc_1",wf_select_sogg( long(ls_dbv[6]), 2))
			return 2
		end if
		
	CASE "gruppo_agenti_descrizione"
		
		ls_dbc[1] = "id_gruppo_agenti"
		ls_dwc[1] = "destinazione_id_gruppo_agenti"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "gruppo_agenti_codice"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "gruppo_agenti_descrizione"
		ls_dbc[4] = "id_sog_com_capo_area"
		ls_dwc[4] = "sog_commerciale_a_id_sog_commerciale"
		ls_dbc[5] = "id_sog_com_agente"
		ls_dwc[5] = "sog_commerciale_b_id_sog_commerciale"
		ls_dbc[6] = "id_sog_com_sub_agente"
		ls_dwc[6] = "sog_commerciale_c_id_sog_commerciale"
		ll_ok = uf_autofind_col(dwo.Name, "gruppo_agenti", &
										"descrizione", "A", data, & 
										ls_sql_cond, 6, &
										ls_dbc, ls_dbv, ls_dwc)
										
		if (ll_ok > 0) then
			
			uf_set_colval("sog_commerciale_gen_a_codice",wf_select_sogg( long(ls_dbv[4]), 1))
			uf_set_colval("sog_commerciale_gen_a_rag_soc_1",wf_select_sogg( long(ls_dbv[4]), 2))

			uf_set_colval("sog_commerciale_gen_b_codice",wf_select_sogg( long(ls_dbv[5]), 1))
			uf_set_colval("sog_commerciale_gen_b_rag_soc_1",wf_select_sogg( long(ls_dbv[5]), 2))

			uf_set_colval("sog_commerciale_gen_c_codice",wf_select_sogg( long(ls_dbv[6]), 1))
			uf_set_colval("sog_commerciale_gen_c_rag_soc_1",wf_select_sogg( long(ls_dbv[6]), 2))
			return 2
		end if
		
	CASE "gruppo_agenti_b_codice"
		ls_dbc[1] = "id_gruppo_agenti"
		ls_dwc[1] = "id_gruppo_agenti_2"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "gruppo_agenti_b_codice"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "gruppo_agenti_b_descrizione"
		ls_dbc[4] = "id_sog_com_capo_area"
		ls_dwc[4] = "sog_commerciale_d_id_sog_commerciale"
		ls_dbc[5] = "id_sog_com_agente"
		ls_dwc[5] = "sog_commerciale_e_id_sog_commerciale"
		ls_dbc[6] = "id_sog_com_sub_agente"
		ls_dwc[6] = "sog_commerciale_f_id_sog_commerciale"
		
		ll_ok = uf_autofind_col(dwo.Name, "gruppo_agenti", &
										"codice", "A", data, & 
										ls_sql_cond, 6, &
										ls_dbc, ls_dbv, ls_dwc)
		if (ll_ok > 0) then
			
			uf_set_colval("sog_commerciale_gen_d_codice",wf_select_sogg( long(ls_dbv[4]), 1))
			uf_set_colval("sog_commerciale_gen_d_rag_soc_1",wf_select_sogg( long(ls_dbv[4]), 2))

			uf_set_colval("sog_commerciale_gen_e_codice",wf_select_sogg( long(ls_dbv[5]), 1))
			uf_set_colval("sog_commerciale_gen_e_rag_soc_1",wf_select_sogg( long(ls_dbv[5]), 2))

			uf_set_colval("sog_commerciale_gen_f_codice",wf_select_sogg( long(ls_dbv[6]), 1))
			uf_set_colval("sog_commerciale_gen_f_rag_soc_1",wf_select_sogg( long(ls_dbv[6]), 2))
			return 2
		end if
		
	CASE "gruppo_agenti_b_descrizione"
		ls_dbc[1] = "id_gruppo_agenti"
		ls_dwc[1] = "id_gruppo_agenti_2"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "gruppo_agenti_b_codice"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "gruppo_agenti_b_descrizione"
		ls_dbc[4] = "id_sog_com_capo_area"
		ls_dwc[4] = "sog_commerciale_d_id_sog_commerciale"
		ls_dbc[5] = "id_sog_com_agente"
		ls_dwc[5] = "sog_commerciale_e_id_sog_commerciale"
		ls_dbc[6] = "id_sog_com_sub_agente"
		ls_dwc[6] = "sog_commerciale_f_id_sog_commerciale"
		
		ll_ok = uf_autofind_col(dwo.Name, "gruppo_agenti", &
										"descrizione", "A", data, & 
										ls_sql_cond, 6, &
										ls_dbc, ls_dbv, ls_dwc)
		if (ll_ok > 0) then
			
			uf_set_colval("sog_commerciale_gen_d_codice",wf_select_sogg( long(ls_dbv[4]), 1))
			uf_set_colval("sog_commerciale_gen_d_rag_soc_1",wf_select_sogg( long(ls_dbv[4]), 2))

			uf_set_colval("sog_commerciale_gen_e_codice",wf_select_sogg( long(ls_dbv[5]), 1))
			uf_set_colval("sog_commerciale_gen_e_rag_soc_1",wf_select_sogg( long(ls_dbv[5]), 2))

			uf_set_colval("sog_commerciale_gen_f_codice",wf_select_sogg( long(ls_dbv[6]), 1))
			uf_set_colval("sog_commerciale_gen_f_rag_soc_1",wf_select_sogg( long(ls_dbv[6]), 2))
			return 2
		end if	
END CHOOSE




end event

event ue_set_search;call super::ue_set_search;
CHOOSE CASE as_nomecol
	CASE "gruppo_agenti_codice"
		is_search_window = "w_gruppo_agenti_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "codice"
	CASE "gruppo_agenti_descrizione"
		is_search_window = "w_gruppo_agenti_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "descrizione"
	
	CASE "gruppo_agenti_b_codice"
		is_search_window = "w_gruppo_agenti_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "codice"
	CASE "gruppo_agenti_b_descrizione"
		is_search_window = "w_gruppo_agenti_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "descrizione"
END CHOOSE

CHOOSE CASE as_nomecol
		
	CASE "id_cat_attivita"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_cat_attivita_gd"
		is_ricpar.s_titolo_finestra = "Categorie Attività"
		is_ricpar.s_ausil_value[1] = "des_cat_attivita"
	CASE "des_cat_attivita"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_cat_attivita_gd"
		is_ricpar.s_titolo_finestra = "Categorie Attività"
		is_ricpar.s_ausil_value[1] = "id_cat_attivita"
		
	CASE "id_cat_com_sc"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_cat_com_sc_gd"
		is_ricpar.s_titolo_finestra = "Categorie Commerciali"
		is_ricpar.s_ausil_value[1] = "des_cat_com_sc"
	CASE "des_cat_com_sc"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_cat_com_sc_gd"
		is_ricpar.s_titolo_finestra = "Categorie Commerciali"
		is_ricpar.s_ausil_value[1] = "id_cat_com_sc"

	CASE "id_cat_zona"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_cat_zona_gd"
		is_ricpar.s_titolo_finestra = "Categorie Zona"
		is_ricpar.s_ausil_value[1] = "des_cat_zona"
	CASE "des_cat_zona"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_cat_zona_gd"
		is_ricpar.s_titolo_finestra = "Categorie Zona"
		is_ricpar.s_ausil_value[1] = "id_cat_zona"
END CHOOSE

end event

event ue_use_search;
string ls_loc
integer i
long ll_row
CHOOSE CASE as_nomecol
	CASE "gruppo_agenti_codice"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("destinazione_id_gruppo_agenti", is_ricpar.s_id_seg_value[1])
		uf_set_colval("gruppo_agenti_descrizione", is_ricpar.s_ausil_value[1])
		uf_set_colval("sog_commerciale_gen_a_codice",wf_select_sogg ( long(is_ricpar.s_id_seg_value[2]), 1 ) )
		uf_set_colval("sog_commerciale_gen_a_rag_soc_1",wf_select_sogg ( long(is_ricpar.s_id_seg_value[2]), 2 ) )
		uf_set_colval("sog_commerciale_gen_b_codice",wf_select_sogg ( long(is_ricpar.s_id_seg_value[3]), 1 ) )
		uf_set_colval("sog_commerciale_gen_b_rag_soc_1",wf_select_sogg ( long(is_ricpar.s_id_seg_value[3]), 2 ) )
		uf_set_colval("sog_commerciale_gen_c_codice",wf_select_sogg ( long(is_ricpar.s_id_seg_value[4]), 1 ) )
		uf_set_colval("sog_commerciale_gen_c_rag_soc_1",wf_select_sogg ( long(is_ricpar.s_id_seg_value[4]), 2 ) )

	CASE "gruppo_agenti_descrizione"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("destinazione_id_gruppo_agenti", is_ricpar.s_id_seg_value[1])
		uf_set_colval("gruppo_agenti_codice", is_ricpar.s_ausil_value[1])
		uf_set_colval("sog_commerciale_gen_a_codice",wf_select_sogg ( long(is_ricpar.s_id_seg_value[2]), 1 ) )
		uf_set_colval("sog_commerciale_gen_a_rag_soc_1",wf_select_sogg ( long(is_ricpar.s_id_seg_value[2]), 2 ) )
		uf_set_colval("sog_commerciale_gen_b_codice",wf_select_sogg ( long(is_ricpar.s_id_seg_value[3]), 1 ) )
		uf_set_colval("sog_commerciale_gen_b_rag_soc_1",wf_select_sogg ( long(is_ricpar.s_id_seg_value[3]), 2 ) )
		uf_set_colval("sog_commerciale_gen_c_codice",wf_select_sogg ( long(is_ricpar.s_id_seg_value[4]), 1 ) )
		uf_set_colval("sog_commerciale_gen_c_rag_soc_1",wf_select_sogg ( long(is_ricpar.s_id_seg_value[4]), 2 ) )

	CASE "gruppo_agenti_b_codice"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_gruppo_agenti_2", is_ricpar.s_id_seg_value[1])
		uf_set_colval("gruppo_agenti_b_descrizione", is_ricpar.s_ausil_value[1])
		
		uf_set_colval("sog_commerciale_gen_d_codice",wf_select_sogg ( long(is_ricpar.s_id_seg_value[2]), 1 ) )
		uf_set_colval("sog_commerciale_gen_d_rag_soc_1",wf_select_sogg ( long(is_ricpar.s_id_seg_value[2]), 2 ) )
		uf_set_colval("sog_commerciale_gen_e_codice",wf_select_sogg ( long(is_ricpar.s_id_seg_value[3]), 1 ) )
		uf_set_colval("sog_commerciale_gen_e_rag_soc_1",wf_select_sogg ( long(is_ricpar.s_id_seg_value[3]), 2 ) )
		uf_set_colval("sog_commerciale_gen_f_codice",wf_select_sogg ( long(is_ricpar.s_id_seg_value[4]), 1 ) )
		uf_set_colval("sog_commerciale_gen_f_rag_soc_1",wf_select_sogg ( long(is_ricpar.s_id_seg_value[4]), 2 ) )
		
	CASE "gruppo_agenti_b_descrizione"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_gruppo_agenti_2", is_ricpar.s_id_seg_value[1])
		uf_set_colval("gruppo_agenti_b_codice", is_ricpar.s_ausil_value[1])
		
		uf_set_colval("sog_commerciale_gen_d_codice",wf_select_sogg ( long(is_ricpar.s_id_seg_value[2]), 1 ) )
		uf_set_colval("sog_commerciale_gen_d_rag_soc_1",wf_select_sogg ( long(is_ricpar.s_id_seg_value[2]), 2 ) )
		uf_set_colval("sog_commerciale_gen_e_codice",wf_select_sogg ( long(is_ricpar.s_id_seg_value[3]), 1 ) )
		uf_set_colval("sog_commerciale_gen_e_rag_soc_1",wf_select_sogg ( long(is_ricpar.s_id_seg_value[3]), 2 ) )
		uf_set_colval("sog_commerciale_gen_f_codice",wf_select_sogg ( long(is_ricpar.s_id_seg_value[4]), 1 ) )
		uf_set_colval("sog_commerciale_gen_f_rag_soc_1",wf_select_sogg ( long(is_ricpar.s_id_seg_value[4]), 2 ) )
END CHOOSE
end event

event ue_init;call super::ue_init;ib_dw_shared=true
end event

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 2528
integer height = 1248
long backcolor = 79741120
string text = "Annotazioni"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_destinazione_ann_gd dw_destinazione_ann_gd
end type

on tabpage_3.create
this.dw_destinazione_ann_gd=create dw_destinazione_ann_gd
this.Control[]={this.dw_destinazione_ann_gd}
end on

on tabpage_3.destroy
destroy(this.dw_destinazione_ann_gd)
end on

type dw_destinazione_ann_gd from u_dw_master_main within tabpage_3
integer x = 27
integer y = 36
integer width = 2469
integer height = 1100
integer taborder = 12
boolean bringtotop = true
string dataobject = "d_destinazione_ann_gd"
end type

event ue_init;call super::ue_init;is_list.s_identifica[1] = "id_destinazione"
end event

