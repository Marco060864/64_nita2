forward
global type w_gruppo_agenti_cx from w_p_data
end type
type dw_gruppo_agenti_cx from u_dw_master_main within w_gruppo_agenti_cx
end type
type cb_1 from commandbutton within w_gruppo_agenti_cx
end type
end forward

global type w_gruppo_agenti_cx from w_p_data
int X=283
int Y=100
int Width=3095
int Height=1492
boolean TitleBar=true
string Title="Gruppo Agenti"
dw_gruppo_agenti_cx dw_gruppo_agenti_cx
cb_1 cb_1
end type
global w_gruppo_agenti_cx w_gruppo_agenti_cx

type variables
long il_con_provvigioni
end variables

forward prototypes
public subroutine wf_campi_ricerca ()
public function integer wf_campi_proposti ()
end prototypes

public subroutine wf_campi_ricerca ();
string	ls_codice, ls_descrizione, ls_cc
long 		ll_id_agente, ll_row, ll_id_anagrafica, ll_id_gruppo_agenti

ll_row = dw_gruppo_agenti_cx.GetRow()
IF dw_gruppo_agenti_cx.RowCount() < 1 THEN
	RETURN
END IF
SetNull(ls_codice)
SetNull(ll_id_anagrafica)
	ll_id_agente = Long(dw_gruppo_agenti_cx.uf_get_colval("id_sog_com_capo_area"))
	SELECT "sog_commerciale"."codice" , "sog_commerciale"."id_anagrafica" 
	  	INTO : ls_codice, :ll_id_anagrafica
     	FROM "sog_commerciale" 
	 	WHERE ( "sog_commerciale"."id_sog_commerciale" = :ll_id_agente )   ;
	SELECT "anagrafica"."rag_soc_1"
		INTO :ls_descrizione
     	FROM "anagrafica" 
	 	WHERE ( "anagrafica"."id_anagrafica" = :ll_id_anagrafica)   ;	 

	
	dw_gruppo_agenti_cx.uf_set_colval("c_capo_area_cod",ls_codice)
	dw_gruppo_agenti_cx.uf_set_colval("c_capo_area_rag_soc",ls_descrizione)
		
	dw_gruppo_agenti_cx.setitemstatus(ll_row, "c_capo_area_cod", PRIMARY!, NotModified!)
	dw_gruppo_agenti_cx.setitemstatus(ll_row, "c_capo_area_rag_soc", PRIMARY!, NotModified!)
	SetNull(ls_codice)
	SetNull(ll_id_anagrafica)
	SetNull(ls_descrizione)
	ll_id_agente = Long(dw_gruppo_agenti_cx.uf_get_colval("id_sog_com_agente"))
	SELECT "sog_commerciale"."codice" , "sog_commerciale"."id_anagrafica" 
	  	INTO : ls_codice, :ll_id_anagrafica
     	FROM "sog_commerciale" 
	 	WHERE ( "sog_commerciale"."id_sog_commerciale" = :ll_id_agente )   ;
	SELECT "anagrafica"."rag_soc_1"
		INTO :ls_descrizione
     	FROM "anagrafica" 
	 	WHERE ( "anagrafica"."id_anagrafica" = :ll_id_anagrafica)   ;	 

	
	dw_gruppo_agenti_cx.uf_set_colval("c_agente_cod",ls_codice)
	dw_gruppo_agenti_cx.uf_set_colval("c_agente_rag_soc",ls_descrizione)
		
	dw_gruppo_agenti_cx.setitemstatus(ll_row, "c_agente_cod", PRIMARY!, NotModified!)
	dw_gruppo_agenti_cx.setitemstatus(ll_row, "c_agente_rag_soc", PRIMARY!, NotModified!)
	SetNull(ls_codice)
	SetNull(ll_id_anagrafica)
	SetNull(ls_descrizione)
	ll_id_agente = Long(dw_gruppo_agenti_cx.uf_get_colval("id_sog_com_sub_agente"))
	SELECT "sog_commerciale"."codice" , "sog_commerciale"."id_anagrafica" 
	  	INTO : ls_codice, :ll_id_anagrafica
     	FROM "sog_commerciale" 
	 	WHERE ( "sog_commerciale"."id_sog_commerciale" = :ll_id_agente )   ;
	SELECT "anagrafica"."rag_soc_1"
		INTO :ls_descrizione
     	FROM "anagrafica" 
	 	WHERE ( "anagrafica"."id_anagrafica" = :ll_id_anagrafica)   ;	 

	
	dw_gruppo_agenti_cx.uf_set_colval("c_subagente_cod",ls_codice)
	dw_gruppo_agenti_cx.uf_set_colval("c_subagente_rag_soc",ls_descrizione)
		
	dw_gruppo_agenti_cx.setitemstatus(ll_row, "c_subagente_cod", PRIMARY!, NotModified!)
	dw_gruppo_agenti_cx.setitemstatus(ll_row, "c_subagente_rag_soc", PRIMARY!, NotModified!)
	ll_id_gruppo_agenti = Long(dw_gruppo_agenti_cx.uf_get_colval("id_gruppo_agenti"))
	SELECT "con_provvigione"."id_con_provvigione"
		INTO :il_con_provvigioni
     	FROM "con_provvigione" 
	 	WHERE ( "con_provvigione"."id_gruppo_agenti" = :ll_id_gruppo_agenti)   ;
	

		
	

	

end subroutine

public function integer wf_campi_proposti ();

String ls_sconto_riga, ls_sconto_finanziario, ls_sconto_fin_incondizionato
String ls_sconto_fin_cassa, ls_mod_liq_provvigione, ls_codice
Long ll_row , ll_gr_agenti,ll_ret
Decimal ld_rip_per_fatturato,ld_rip_per_incassato

  SELECT "par_sistema"."sconto_riga",
         "par_sistema"."sconto_finanziario",
         "par_sistema"."sconto_fin_incondizionato",
         "par_sistema"."sconto_fin_cassa",
         "par_sistema"."rip_per_fatturato",
         "par_sistema"."rip_per_incassato",
         "par_sistema"."mod_liq_provvigione"
    INTO :ls_sconto_riga,
         :ls_sconto_finanziario,
         :ls_sconto_fin_incondizionato,
         :ls_sconto_fin_cassa,
         :ld_rip_per_fatturato,
         :ld_rip_per_incassato,
         :ls_mod_liq_provvigione
    FROM "par_sistema";

ll_row = dw_gruppo_agenti_cx.GetRow()

ls_codice = dw_gruppo_agenti_cx.GetItemString(ll_row,"codice")



  SELECT "gruppo_agenti"."id_gruppo_agenti"
    INTO :ll_gr_agenti 
    FROM "gruppo_agenti"
   WHERE "gruppo_agenti"."codice" = :ls_codice;
	
if sqlca.sqlcode=0 then
	ll_ret=0
	dw_gruppo_agenti_cx.Retrieve(ll_gr_agenti)
else
	ll_ret=1
	dw_gruppo_agenti_cx.SetItem(ll_row,'sconto_riga',ls_sconto_riga)
	dw_gruppo_agenti_cx.SetItem(ll_row,'sconto_finanziario',ls_sconto_finanziario)
	dw_gruppo_agenti_cx.SetItem(ll_row,'sconto_fin_incondizionato',ls_sconto_fin_incondizionato)
	dw_gruppo_agenti_cx.SetItem(ll_row,'sconto_fin_cassa',ls_sconto_fin_cassa)
	dw_gruppo_agenti_cx.SetItem(ll_row,'rip_per_fatturato',ld_rip_per_fatturato)
	dw_gruppo_agenti_cx.SetItem(ll_row,'rip_per_incassato',ld_rip_per_incassato)
	dw_gruppo_agenti_cx.SetItem(ll_row,'mod_liq_provvigione',ls_mod_liq_provvigione)
end if

RETURN ll_ret

end function

on w_gruppo_agenti_cx.create
int iCurrent
call super::create
this.dw_gruppo_agenti_cx=create dw_gruppo_agenti_cx
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_gruppo_agenti_cx
this.Control[iCurrent+2]=this.cb_1
end on

on w_gruppo_agenti_cx.destroy
call super::destroy
destroy(this.dw_gruppo_agenti_cx)
destroy(this.cb_1)
end on

event open;call super::open;idw_master = dw_gruppo_agenti_cx
idw_master.is_list = Message.PowerObjectParm
IF UpperBound(idw_master.is_list.s_identifica) = 0 THEN
	idw_master.ias_key_name[1] = "id_gruppo_agenti"
	idw_master.is_list.s_modo = modo_inserisci
END IF
idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_SQL_ident[1] = "gruppo_agenti.id_gruppo_agenti"
ib_nonmodale=true




end event

event ue_post_open;call super::ue_post_open;

Long 		ll_row , ll_null , ll_capo_area ,	ll_id_gruppo_agenti 
Long 		ll_id_sog_com_capo_area, ll_id_sog_com_agente, ll_id_sog_com_sub_agente
String 	ls_codice , ls_descrizione , ls_null
long 		ll_ret

SetNull(ls_null)

ll_ret=wf_campi_proposti()
if ll_ret=0 then 
	
	ll_row = dw_gruppo_agenti_cx.GetRow()
	ll_id_gruppo_agenti = dw_gruppo_agenti_cx.GetItemNumber(ll_row,'id_gruppo_agenti')

	SetNull(ls_codice)
	SetNull(ls_descrizione)
	
	

SELECT id_sog_com_capo_area, id_sog_com_agente, id_sog_com_sub_agente
INTO	 :ll_id_sog_com_capo_area, :ll_id_sog_com_agente, :ll_id_sog_com_sub_agente
FROM	 gruppo_agenti
WHERE	 id_gruppo_agenti = :ll_id_gruppo_agenti
;

	SELECT "sog_commerciale_gen"."rag_soc_1",   
			"sog_commerciale_gen"."codice"  
   INTO 	:ls_descrizione , :ls_codice
   FROM  "sog_commerciale_gen"  
   WHERE "sog_commerciale_gen"."id_sog_commerciale" = :ll_id_sog_com_capo_area
	;
	dw_gruppo_agenti_cx.SetItem(ll_row,"c_capo_area_cod",ls_codice)
	dw_gruppo_agenti_cx.SetItem(ll_row,"c_capo_area_rag_soc",ls_descrizione)	

	SetNull(ls_codice)
	SetNull(ls_descrizione)

	SELECT "sog_commerciale_gen"."rag_soc_1",   
			"sog_commerciale_gen"."codice"  
   INTO 	:ls_descrizione , :ls_codice
   FROM  "sog_commerciale_gen"  
   WHERE "sog_commerciale_gen"."id_sog_commerciale" = :ll_id_sog_com_agente
	;
	
	dw_gruppo_agenti_cx.SetItem(ll_row,"c_agente_cod",ls_codice)
	dw_gruppo_agenti_cx.SetItem(ll_row,"c_agente_rag_soc",ls_descrizione)	

	SetNull(ls_codice)
	SetNull(ls_descrizione)

	SELECT "sog_commerciale_gen"."rag_soc_1",   
			"sog_commerciale_gen"."codice"  
   INTO 	:ls_descrizione , :ls_codice
   FROM  "sog_commerciale_gen"  
   WHERE "sog_commerciale_gen"."id_sog_commerciale" = :ll_id_sog_com_sub_agente
	;
	
	dw_gruppo_agenti_cx.SetItem(ll_row,"c_subagente_cod",ls_codice)
	dw_gruppo_agenti_cx.SetItem(ll_row,"c_subagente_rag_soc",ls_descrizione)	

END IF
	dw_gruppo_agenti_cx.SetItemStatus(1,0,Primary!,Notmodified!)
end event

event ue_master_delete;call super::ue_master_delete;
if (idw_master.Event ue_delete(0, 0) = 0) then
	ib_AskForSave = false
	IF (idw_master.Event ue_update(0, 0) = 0) then
		ib_AskForSave = true
		idw_master.is_list.s_modo = modo_inserisci
		idw_master.Event ue_insert(0, 0)
	else
		idw_master.Event ue_retrieve(0, 0)
	end if
	idw_master.SetItemStatus(idw_master.GetRow(), 0, Primary!, NotModified!)
end if
idw_master.SetFocus()

end event

type p_crescente from w_p_data`p_crescente within w_gruppo_agenti_cx
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_gruppo_agenti_cx
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_gruppo_agenti_cx
int Y=28
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_gruppo_agenti_cx
int Y=28
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_gruppo_agenti_cx
int Y=28
boolean BringToTop=true
end type

event cb_nuovo::clicked;call super::clicked;

wf_campi_proposti()

end event

type cb_inserisci from w_p_data`cb_inserisci within w_gruppo_agenti_cx
int X=2194
int Y=28
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_gruppo_agenti_cx
int X=2491
int Y=28
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_gruppo_agenti_cx
int X=2789
int Y=28
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_gruppo_agenti_cx
int X=960
int Y=0
int Width=160
int Height=220
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
long BackColor=79741120
end type

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=18
int Y=104
int Width=123
int Height=100
end type

type cb_ricerca from w_p_data`cb_ricerca within w_gruppo_agenti_cx
int X=1234
int Y=28
boolean BringToTop=true
end type

event cb_ricerca::clicked;call super::clicked;string ls_filtro,ls_codice
long ll_seg_value
s_ric_param ls_ric_param
w_search_main lw_sm
ls_codice=""
idw_master.is_ricpar.s_filter_value=ls_codice
idw_master.is_ricpar.s_filter_name="codice"
openwithparm(lw_sm,idw_master.is_ricpar,"w_gruppo_agenti_coddes_sw")
idw_master.is_ricpar=message.powerobjectparm
if upperbound(idw_master.is_ricpar.s_id_seg_value)>0 then
	ll_seg_value=long(idw_master.is_ricpar.s_id_seg_value[1])
	idw_master.is_list.s_modo=modo_modifica
	idw_master.is_list.s_identifica[1]="id_gruppo_agenti"
	idw_master.is_list.l_identifica[1]=ll_seg_value
	idw_master.event ue_retrieve(0,0)
	idw_master.setfocus()
	wf_campi_ricerca()
end if
end event

type dw_gruppo_agenti_cx from u_dw_master_main within w_gruppo_agenti_cx
int X=46
int Y=140
int Width=3003
int Height=1232
int TabOrder=10
string DataObject="d_gruppo_agenti_cx"
end type

event itemchanged;
string	ls_null
long		ll_null
string    ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
long      ll_ok
decimal ld_percentuale
SetNull(ll_null) 
ls_null = ""
CHOOSE CASE dwo.name
 CASE 'c_agente_cod'
		IF IsNull(data) OR (data = ls_null) THEN
			This.SetItem(row, "id_sog_com_agente", ll_null) 
 		   This.SetItem(row, "c_agente_cod", ls_null)
			This.SetItem(row, "c_agente_rag_soc", ls_null)
		ELSE
		ls_dbc[1] = "id_sog_commerciale"
		ls_dwc[1] = "id_sog_com_agente"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_agente_cod"
		ls_dbc[3] = "rag_soc_1"
		ls_dwc[3] = "c_agente_rag_soc"
	   ls_sql_cond = "sog_commerciale_gen.tipo = 'A'"
		ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &  
										"codice", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
	 END IF
	 CASE 'c_agente_rag_soc'
		IF IsNull(data) OR (data = ls_null) THEN
			This.SetItem(row, "id_sog_com_agente", ll_null) 
			This.SetItem(row, "c_agente_cod", ls_null)
			This.SetItem(row, "c_agente_rag_soc", ls_null)
		ELSE
		ls_dbc[1] = "id_sog_commerciale"
		ls_dwc[1] = "id_sog_com_agente"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_agente_cod"
		ls_dbc[3] = "rag_soc_1"
		ls_dwc[3] = "c_agente_rag_soc"
	   ls_sql_cond = "sog_commerciale_gen.tipo = 'A'"
		ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &  
										"rag_soc_1", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
	END IF
	 CASE 'c_subagente_cod'
		IF IsNull(data) OR (data = ls_null) THEN
			This.SetItem(row, "id_sog_com_sub_agente", ll_null) 
			This.SetItem(row, "c_subagente_cod", ls_null)
			This.SetItem(row, "c_subagente_rag_soc", ls_null)
		ELSE	
		ls_dbc[1] = "id_sog_commerciale"
		ls_dwc[1] = "id_sog_com_subagente"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_subagente_cod"
		ls_dbc[3] = "rag_soc_1"
		ls_dwc[3] = "c_subagente_rag_soc"
	   ls_sql_cond = "sog_commerciale_gen.tipo = 'A'"
		ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &  
										"codice", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF			
	 END IF	
	 CASE 'c_subagente_rag_soc'
		IF IsNull(data) OR (data = ls_null) THEN
			This.SetItem(row, "id_sog_com_sub_agente", ll_null) 
			This.SetItem(row, "c_subagente_cod", ls_null)
			This.SetItem(row, "c_subagente_rag_soc", ls_null)
		ELSE	
			ls_dbc[1] = "id_sog_commerciale"
			ls_dwc[1] = "id_sog_com_subagente"
			ls_dbc[2] = "codice"
			ls_dwc[2] = "c_subagente_cod"
			ls_dbc[3] = "rag_soc_1"
			ls_dwc[3] = "c_subagente_rag_soc"
			ls_sql_cond = "sog_commerciale_gen.tipo = 'A'"
			ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &  
											"rag_soc_1", "A", data, & 
											ls_sql_cond, 3, &
											ls_dbc, ls_dbv, ls_dwc)
			IF (ll_ok > 0) THEN
				RETURN 2
			END IF			
		END IF
	 CASE 'c_capo_area_cod'
		IF IsNull(data) OR (data = ls_null) THEN
			This.SetItem(row, "id_sog_com_capo_area", ll_null) 
 		   This.SetItem(row, "c_capo_area_cod", ls_null)
			This.SetItem(row, "c_capo_area_rag_soc", ls_null)
		ELSE
			ls_dbc[1] = "id_sog_commerciale"
			ls_dwc[1] = "id_sog_com_capo_area"
			ls_dbc[2] = "codice"
			ls_dwc[2] = "c_capo_area_cod"
			ls_dbc[3] = "rag_soc_1"
			ls_dwc[3] = "c_capo_area_rag_soc"
			ls_sql_cond = "sog_commerciale_gen.tipo = 'A'"
			ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &  
											"codice", "A", data, & 
											ls_sql_cond, 3, &
											ls_dbc, ls_dbv, ls_dwc)
			IF (ll_ok > 0) THEN
				RETURN 2
			END IF
	 	END IF
	 CASE 'c_capo_area_rag_soc'
		IF IsNull(data) OR (data = ls_null) THEN
			This.SetItem(row, "id_sog_com_capo_area", ll_null) 
 		   This.SetItem(row, "c_capo_area_cod", ls_null)
			This.SetItem(row, "c_capo_area_rag_soc", ls_null)
		ELSE
			ls_dbc[1] = "id_sog_commerciale"
			ls_dwc[1] = "id_sog_com_capo_area"
			ls_dbc[2] = "codice"
			ls_dwc[2] = "c_capo_area_cod"
			ls_dbc[3] = "rag_soc_1"
			ls_dwc[3] = "c_capo_area_rag_soc"
			ls_sql_cond = "sog_commerciale_gen.tipo = 'A'"
			ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &  
											"rag_soc_1", "A", data, & 
											ls_sql_cond, 3, &
											ls_dbc, ls_dbv, ls_dwc)
			IF (ll_ok > 0) THEN
				RETURN 2
			END IF
	 	END IF
	CASE "rip_per_fatturato"
		ld_percentuale=100 - dec(data)
		this.setitem(row,"rip_per_incassato",ld_percentuale)
	CASE "rip_per_incassato"
		ld_percentuale=100 - dec(data)
		this.setitem(row,"rip_per_fatturato",ld_percentuale)
END CHOOSE

end event

event ue_set_search;call super::ue_set_search;
CHOOSE CASE as_nomecol
	CASE "c_capo_area_cod",  "c_agente_cod", "c_subagente_cod"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice" 
		is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo = 'A'"
	CASE "c_capo_area_rag_soc",  "c_agente_rag_soc", "c_subagente_rag_soc"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "rag_soc_1" 
		is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo = 'A'"
END CHOOSE


end event

event ue_use_search;call super::ue_use_search;

CHOOSE CASE as_nomecol
	CASE "c_capo_area_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_sog_com_capo_area", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_capo_area_rag_soc", is_ricpar.s_ausil_value[1])
	CASE "c_capo_area_rag_soc"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_sog_com_capo_area", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_capo_area_cod", is_ricpar.s_ausil_value[1])
	CASE "c_agente_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_sog_com_agente", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_agente_rag_soc", is_ricpar.s_ausil_value[1])
	CASE "c_agente_rag_soc"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_sog_com_agente", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_agente_cod", is_ricpar.s_ausil_value[1])
	CASE "c_subagente_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_sog_com_sub_agente", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_subagente_rag_soc", is_ricpar.s_ausil_value[1])
	CASE "c_subagente_rag_soc"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_sog_com_sub_agente", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_subagente_cod", is_ricpar.s_ausil_value[1])	
END CHOOSE

end event

event ue_init;call super::ue_init;is_title = "Gruppo Agenti"
end event

type cb_1 from commandbutton within w_gruppo_agenti_cx
int X=1646
int Y=28
int Width=512
int Height=88
int TabOrder=30
boolean BringToTop=true
string Text="Scaglioni Provvigione"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_gruppo
s_list_main ls_list_app
ll_gruppo=dw_gruppo_agenti_cx.getitemnumber(1,"id_gruppo_agenti")
if ll_gruppo>0 then
	ls_list_app.s_identifica[1]="id_gruppo_agenti"
	ls_list_app.l_identifica[1]=ll_gruppo
end if
OpenSheetWithParm( w_scaglione_provvigione_cx, ls_list_app, w_app_frame, 0, Original!)	
end event

