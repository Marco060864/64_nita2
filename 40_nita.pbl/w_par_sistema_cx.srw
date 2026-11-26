forward
global type w_par_sistema_cx from w_p_data
end type
type dw_par_sistema_cont_ff from u_dw_master_main within tabpage_1
end type
type dw_par_sistema_cont_ff from u_dw_master_main within tabpage_1
end type
type tabpage_3 from userobject within tab_1
end type
type cb_5 from commandbutton within tabpage_3
end type
type dw_par_sistema_cont2_ff from u_dw_master_main within tabpage_3
end type
type tabpage_commerciale from userobject within tab_1
end type
type dw_par_sistema_comm_ff from u_dw_master_main within tabpage_commerciale
end type
type tabpage_altro from userobject within tab_1
end type
type dw_par_sistema_altro_ff from u_dw_master_main within tabpage_altro
end type
type dw_par_lettore_gd from u_dw_master_main within tabpage_altro
end type
type tabpage_2 from userobject within tab_1
end type
type dw_par_sistema_magazzino_ff from u_dw_master_main within tabpage_2
end type
type tabpage_intracom from userobject within tab_1
end type
type dw_intra_contatore from u_dw_master_main within tabpage_intracom
end type
type tabpage_agenti from userobject within tab_1
end type
type cb_1 from commandbutton within tabpage_agenti
end type
type cb_2 from commandbutton within tabpage_agenti
end type
type cb_3 from commandbutton within tabpage_agenti
end type
type cb_4 from commandbutton within tabpage_agenti
end type
type dw_par_sistema_agenti from u_dw_master_main within tabpage_agenti
end type
type tabpage_3 from userobject within tab_1
cb_5 cb_5
dw_par_sistema_cont2_ff dw_par_sistema_cont2_ff
end type
type tabpage_commerciale from userobject within tab_1
dw_par_sistema_comm_ff dw_par_sistema_comm_ff
end type
type tabpage_altro from userobject within tab_1
dw_par_sistema_altro_ff dw_par_sistema_altro_ff
dw_par_lettore_gd dw_par_lettore_gd
end type
type tabpage_2 from userobject within tab_1
dw_par_sistema_magazzino_ff dw_par_sistema_magazzino_ff
end type
type tabpage_intracom from userobject within tab_1
dw_intra_contatore dw_intra_contatore
end type
type tabpage_agenti from userobject within tab_1
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
cb_4 cb_4
dw_par_sistema_agenti dw_par_sistema_agenti
end type
end forward

global type w_par_sistema_cx from w_p_data
int Width=2491
int Height=2128
boolean TitleBar=true
string Title="Parametri di Sistema"
end type
global w_par_sistema_cx w_par_sistema_cx

on w_par_sistema_cx.create
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
end on

on w_par_sistema_cx.destroy
call super::destroy
end on

event open;call super::open;
il_HelpTopic = 599

datawindowchild ldw_ordini,ldw_fatture,ldw_ddt,ldw_preventivi,ldw_par_euro, ldw_mod_reg

long	ll_id_par_sistema




idw_master = tab_1.tabpage_1.dw_par_sistema_cont_ff
idw_master.is_list = Message.PowerObjectParm

idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_sql_ident[1] = "par_sistema.id_par_sistema"

IF UpperBound(idw_master.is_list.s_identifica) = 0 THEN
	idw_master.ias_key_name[1] = "id_par_sistema"
	idw_master.is_list.s_identifica[1] = "id_par_sistema"
	
	SELECT "dba"."par_sistema"."id_par_sistema"  
    INTO :ll_id_par_sistema  
    FROM "dba"."par_sistema"
	 WHERE "dba"."par_sistema"."id_azienda" = 1;
	idw_master.is_list.l_identifica[1] = ll_id_par_sistema
	idw_master.is_list.s_modo = modo_modifica
END IF
tab_1.tabpage_2.dw_par_sistema_magazzino_ff.getchild("id_prof_pref_ordini",ldw_ordini)
tab_1.tabpage_2.dw_par_sistema_magazzino_ff.getchild("id_prof_pref_fatture",ldw_fatture)
tab_1.tabpage_2.dw_par_sistema_magazzino_ff.getchild("id_prof_pref_preventivi",ldw_preventivi)
tab_1.tabpage_2.dw_par_sistema_magazzino_ff.getchild("id_prof_pref_ddt",ldw_ddt)
tab_1.tabpage_commerciale.dw_par_sistema_comm_ff.getchild("id_val_lire",ldw_par_euro)

ldw_fatture.settransobject(sqlca)
ldw_fatture.retrieve()
ldw_fatture.setfilter("codice_i='I'")
ldw_fatture.filter()


ldw_par_euro.settransobject(sqlca)
ldw_par_euro.retrieve()


ldw_ordini.settransobject(sqlca)
ldw_ordini.retrieve()
ldw_ordini.setfilter("codice_i='O'")
ldw_ordini.filter()


ldw_ddt.settransobject(sqlca)
ldw_ddt.retrieve()
ldw_ddt.setfilter("codice_i='D'")
ldw_ddt.filter()




ldw_preventivi.settransobject(sqlca)
ldw_preventivi.retrieve()
ldw_preventivi.setfilter("codice_i='P'")
ldw_preventivi.filter()

datawindowchild ldw_nmn
tab_1.tabpage_2.dw_par_sistema_magazzino_ff.getchild("id_caus_mag_nmn",ldw_nmn)
ldw_nmn.settransobject(sqlca)
ldw_nmn.retrieve()
end event

event ue_post_open;call super::ue_post_open;tab_1.tabpage_1.dw_par_sistema_cont_ff.setitemstatus(1,0,primary!,notmodified!)
tab_1.tabpage_intracom.dw_intra_contatore.setitemstatus(1,0,primary!,notmodified!)
end event

type p_crescente from w_p_data`p_crescente within w_par_sistema_cx
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_par_sistema_cx
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_par_sistema_cx
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_par_sistema_cx
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_par_sistema_cx
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_par_sistema_cx
int X=1600
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_par_sistema_cx
int X=1893
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_par_sistema_cx
int X=2190
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_par_sistema_cx
int X=23
int Y=204
int Width=2432
int Height=1828
boolean BringToTop=true
long BackColor=79741120
tabpage_3 tabpage_3
tabpage_commerciale tabpage_commerciale
tabpage_altro tabpage_altro
tabpage_2 tabpage_2
tabpage_intracom tabpage_intracom
tabpage_agenti tabpage_agenti
end type

on tab_1.create
this.tabpage_3=create tabpage_3
this.tabpage_commerciale=create tabpage_commerciale
this.tabpage_altro=create tabpage_altro
this.tabpage_2=create tabpage_2
this.tabpage_intracom=create tabpage_intracom
this.tabpage_agenti=create tabpage_agenti
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_3
this.Control[iCurrent+2]=this.tabpage_commerciale
this.Control[iCurrent+3]=this.tabpage_altro
this.Control[iCurrent+4]=this.tabpage_2
this.Control[iCurrent+5]=this.tabpage_intracom
this.Control[iCurrent+6]=this.tabpage_agenti
end on

on tab_1.destroy
call super::destroy
destroy(this.tabpage_3)
destroy(this.tabpage_commerciale)
destroy(this.tabpage_altro)
destroy(this.tabpage_2)
destroy(this.tabpage_intracom)
destroy(this.tabpage_agenti)
end on

event tab_1::selectionchanged;call super::selectionchanged;CHOOSE CASE newindex
	CASE 7
		tab_1.tabpage_agenti.dw_par_sistema_agenti.SetFocus()
END CHOOSE
end event

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=18
int Y=104
int Width=2395
int Height=1708
long BackColor=79741120
string Text="Contabilità"
long TabBackColor=79741120
dw_par_sistema_cont_ff dw_par_sistema_cont_ff
end type

on tabpage_1.create
this.dw_par_sistema_cont_ff=create dw_par_sistema_cont_ff
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_par_sistema_cont_ff
end on

on tabpage_1.destroy
call super::destroy
destroy(this.dw_par_sistema_cont_ff)
end on

type cb_ricerca from w_p_data`cb_ricerca within w_par_sistema_cx
boolean BringToTop=true
end type

type dw_par_sistema_cont_ff from u_dw_master_main within tabpage_1
event type string ue_crea_titolo_finestra ( )
int X=23
int Y=16
int Width=2359
int Height=1472
int TabOrder=1
string DataObject="d_par_sistema_cont_ff"
end type

event ue_crea_titolo_finestra;call super::ue_crea_titolo_finestra;

long		ll_row, ll_id_azienda, ll_code
string	ls_title, ls_azienda
window 	lw_parent
tab    	lw_tab

ll_row = GetRow()
if ll_row > 0 then
	ll_id_azienda = GetItemNumber(ll_row, "id_azienda")
	SELECT "dba"."azienda"."rag_soc_1"  
	 INTO :ls_azienda  
	 FROM "dba"."azienda"
	 WHERE "dba"."azienda"."id_azienda" = :ll_id_azienda ;
	ls_title = "Parametri di sistema per: " + ls_azienda
	if len(trim(ls_azienda)) = 0 Or IsNull(ls_azienda) then
		MessageBox("Attenzione!", "E' INDISPENSABILE creare ALMENO un'azienda PRIMA di impostare i parametri di sistema.")
		ls_title = "Parametri di sistema"
	end if
else
	
	
end if
lw_tab = Parent.GetParent()
lw_parent = lw_tab.GetParent()
lw_parent.Title = ls_title

Return ls_title
end event

event itemchanged;string		ls_nomecol, ls_pref, ls_tipo, ls_tit, ls_pref_c, ls_pref_f
long			ll_id_par_sistema, ll_valida

ll_id_par_sistema = GetItemNumber(row, "id_par_sistema")
SELECT "par_sistema"."pref_cod_cliente",   
		"par_sistema"."pref_cod_fornitore"  
 INTO :ls_pref_c,   
		:ls_pref_f  
 FROM "par_sistema"  
 WHERE "par_sistema"."id_par_sistema" = :ll_id_par_sistema  ;

ls_nomecol = dwo.name
CHOOSE CASE ls_nomecol
	CASE "pref_cod_cliente", "pref_cod_fornitore"
		if ls_nomecol = "pref_cod_cliente" then
			ls_tipo = "C"
			ls_tit = "Cliente"
			ls_pref = ls_pref_c
		else
			ls_tipo = "F"
			ls_tit = "Fornitore"
			ls_pref = ls_pref_f
		end if
		if len(data) <> 0 And len(data) <> 4 then
			MessageBox("Attenzione - prefisso " + ls_tit, &
					"Lunghezza del prefisso può essere o di 0 o di 4 caratteri.", Exclamation!)
			Post SetItem(row, ls_nomecol, ls_pref)
		else
			if len(data) = 4 then
				
				ll_valida =	f_valida_pre_codice(data, ls_tipo)
				CHOOSE CASE ll_valida
					CASE -2, -3  
						Beep(20)
						MessageBox("Avviso", "Ricordarsi di creare codici:~r     <" + &
							Mid(data, 1, 2) + "> per mastro, e~r     <" + &
							Mid(data, 3, 2) + "> per sottomastro.")
					CASE -4
						
						Post SetItem(row, ls_nomecol, ls_pref)
				END CHOOSE
			end if
		end if
END CHOOSE

string    ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
long      ll_ok

CHOOSE CASE dwo.name

	CASE 'c_conto_is_cod'
		ls_sql_cond = ""  
		ls_dbc[1]  = "id_conto"
		ls_dwc[1]  = "id_conto_iva_sospesa"
		ls_dbc[2]  = "codice"
		ls_dwc[2]  = "c_conto_is_cod"
		ls_dbc[3]  = "descrizione"
		ls_dwc[3]  = "c_conto_is_des"
		ll_ok = uf_autofind_col(dwo.Name, "conto", &
										"codice", "A", data, &
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF

	CASE 'c_conto_is_des'
		ls_sql_cond = ""  
		ls_dbc[1]  = "id_conto"
		ls_dwc[1]  = "id_conto_iva_sospesa"
		ls_dbc[2]  = "codice"
		ls_dwc[2]  = "c_conto_is_cod"
		ls_dbc[3]  = "descrizione"
		ls_dwc[3]  = "c_conto_is_des"
		ll_ok = uf_autofind_col(dwo.Name, "conto", &
										"descrizione", "A", data, &
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF

	CASE 'c_conto_ia_cod'
		ls_sql_cond = ""  
		ls_dbc[1]  = "id_conto"
		ls_dwc[1]  = "id_conto_iva_ia"
		ls_dbc[2]  = "codice"
		ls_dwc[2]  = "c_conto_ia_cod"
		ls_dbc[3]  = "descrizione"
		ls_dwc[3]  = "c_conto_ia_des"
		ll_ok = uf_autofind_col(dwo.Name, "conto", &
										"codice", "A", data, &
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF

	CASE 'c_conto_ia_des'
		ls_sql_cond = ""  
		ls_dbc[1]  = "id_conto"
		ls_dwc[1]  = "id_conto_iva_ia"
		ls_dbc[2]  = "codice"
		ls_dwc[2]  = "c_conto_ia_cod"
		ls_dbc[3]  = "descrizione"
		ls_dwc[3]  = "c_conto_ia_des"
		ll_ok = uf_autofind_col(dwo.Name, "conto", &
										"descrizione", "A", data, &
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF

	CASE 'c_conto_iv_cod'
		ls_sql_cond = ""  
		ls_dbc[1]  = "id_conto"
		ls_dwc[1]  = "id_conto_iva_iv"

		ls_dbc[2]  = "codice"
		ls_dwc[2]  = "c_conto_iv_cod"
		ls_dbc[3]  = "descrizione"
		ls_dwc[3]  = "c_conto_iv_des"
		ll_ok = uf_autofind_col(dwo.Name, "conto", &
										"codice", "A", data, &
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF

	CASE 'c_conto_iv_des'
		ls_sql_cond = ""  
		ls_dbc[1]  = "id_conto"
		ls_dwc[1]  = "id_conto_iva_iv"
		ls_dbc[2]  = "codice"
		ls_dwc[2]  = "c_conto_iv_cod"
		ls_dbc[3]  = "descrizione"
		ls_dwc[3]  = "c_conto_iv_des"
		ll_ok = uf_autofind_col(dwo.Name, "conto", &
										"descrizione", "A", data, &
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF

	CASE 'c_conto_nd_cod'
		ls_sql_cond = ""  
		ls_dbc[1]  = "id_conto"
		ls_dwc[1]  = "id_conto_iva_nd"
		ls_dbc[2]  = "codice"
		ls_dwc[2]  = "c_conto_nd_cod"
		ls_dbc[3]  = "descrizione"
		ls_dwc[3]  = "c_conto_nd_des"
		ll_ok = uf_autofind_col(dwo.Name, "conto", &
										"codice", "A", data, &
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF

	CASE 'c_conto_nd_des'
		ls_sql_cond = ""  
		ls_dbc[1]  = "id_conto"
		ls_dwc[1]  = "id_conto_iva_nd"
		ls_dbc[2]  = "codice"
		ls_dwc[2]  = "c_conto_nd_cod"
		ls_dbc[3]  = "descrizione"
		ls_dwc[3]  = "c_conto_nd_des"
		ll_ok = uf_autofind_col(dwo.Name, "conto", &
										"descrizione", "A", data, &
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF

	CASE 'c_conto_pr_cod'
		ls_sql_cond = ""  
		ls_dbc[1]  = "id_conto"
		ls_dwc[1]  = "id_conto_predefinito"
		ls_dbc[2]  = "codice"
		ls_dwc[2]  = "c_conto_pr_cod"
		ls_dbc[3]  = "descrizione"
		ls_dwc[3]  = "c_conto_pr_des"
		ll_ok = uf_autofind_col(dwo.Name, "conto", &
										"codice", "A", data, &
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF

	CASE 'c_conto_pr_des'
		ls_sql_cond = ""  
		ls_dbc[1]  = "id_conto"
		ls_dwc[1]  = "id_conto_predefinito"
		ls_dbc[2]  = "codice"
		ls_dwc[2]  = "c_conto_pr_cod"
		ls_dbc[3]  = "descrizione"
		ls_dwc[3]  = "c_conto_pr_des"
		ll_ok = uf_autofind_col(dwo.Name, "conto", &
										"descrizione", "A", data, &
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
CASE 'c_conto_generico_acconto_cod'
		ls_sql_cond = ""  
		ls_dbc[1]  = "id_conto"
		ls_dwc[1]  = "id_cont_gen_acconto"
		ls_dbc[2]  = "codice"
		ls_dwc[2]  = "c_conto_generico_acconto_cod"
		ls_dbc[3]  = "descrizione"
		ls_dwc[3]  = "c_conto_generico_acconto_des"
		ll_ok = uf_autofind_col(dwo.Name, "conto", &
										"codice", "A", data, &
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
	CASE 'c_conto_generico_acconto_des'
		ls_sql_cond = ""  
		ls_dbc[1]  = "id_conto"
		ls_dwc[1]  = "id_cont_gen_acconto"
		ls_dbc[2]  = "codice"
		ls_dwc[2]  = "c_conto_generico_acconto_cod"
		ls_dbc[3]  = "descrizione"
		ls_dwc[3]  = "c_conto_generico_acconto_des"
		ll_ok = uf_autofind_col(dwo.Name, "conto", &
										"descrizione", "A", data, &
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
		
CASE 'c_conto_utile_sp_cod'
		ls_sql_cond = ""  
		ls_dbc[1]  = "id_conto"
		ls_dwc[1]  = "id_conto_utile_sp"
		ls_dbc[2]  = "codice"
		ls_dwc[2]  = "c_conto_utile_sp_cod"
		ls_dbc[3]  = "descrizione"
		ls_dwc[3]  = "c_conto_utile_sp_des"
		ll_ok = uf_autofind_col(dwo.Name, "conto", &
										"codice", "A", data, &
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
	CASE 'c_conto_utile_sp_des'
		ls_sql_cond = ""  
		ls_dbc[1]  = "id_conto"
		ls_dwc[1]  = "id_conto_utile_sp"
		ls_dbc[2]  = "codice"
		ls_dwc[2]  = "c_conto_utile_sp_cod"
		ls_dbc[3]  = "descrizione"
		ls_dwc[3]  = "c_conto_utile_sp_des"
		ll_ok = uf_autofind_col(dwo.Name, "conto", &
										"descrizione", "A", data, &
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
		
		CASE 'c_conto_perdite_sp_cod'
		ls_sql_cond = ""  
		ls_dbc[1]  = "id_conto"
		ls_dwc[1]  = "id_conto_perdite_sp"
		ls_dbc[2]  = "codice"
		ls_dwc[2]  = "c_conto_perdite_sp_cod"
		ls_dbc[3]  = "descrizione"
		ls_dwc[3]  = "c_conto_perdite_sp_des"
		ll_ok = uf_autofind_col(dwo.Name, "conto", &
										"codice", "A", data, &
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
	CASE 'c_conto_perdite_sp_des'
		ls_sql_cond = ""  
		ls_dbc[1]  = "id_conto"
		ls_dwc[1]  = "id_conto_perdite_sp"
		ls_dbc[2]  = "codice"
		ls_dwc[2]  = "c_conto_perdite_sp_cod"
		ls_dbc[3]  = "descrizione"
		ls_dwc[3]  = "c_conto_perdite_sp_des"
		ll_ok = uf_autofind_col(dwo.Name, "conto", &
										"descrizione", "A", data, &
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
		
	CASE 'c_conto_utile_ce_cod'
		ls_sql_cond = ""  
		ls_dbc[1]  = "id_conto"
		ls_dwc[1]  = "id_conto_utile_ce"
		ls_dbc[2]  = "codice"
		ls_dwc[2]  = "c_conto_utile_ce_cod"
		ls_dbc[3]  = "descrizione"
		ls_dwc[3]  = "c_conto_utile_ce_des"
		ll_ok = uf_autofind_col(dwo.Name, "conto", &
										"codice", "A", data, &
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
	CASE 'c_conto_utile_ce_des'
		ls_sql_cond = ""  
		ls_dbc[1]  = "id_conto"
		ls_dwc[1]  = "id_conto_utile_ce"
		ls_dbc[2]  = "codice"
		ls_dwc[2]  = "c_conto_utile_ce_cod"
		ls_dbc[3]  = "descrizione"
		ls_dwc[3]  = "c_conto_utile_ce_des"
		ll_ok = uf_autofind_col(dwo.Name, "conto", &
										"descrizione", "A", data, &
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF

		CASE 'c_conto_perdite_ce_cod'
		ls_sql_cond = ""  
		ls_dbc[1]  = "id_conto"
		ls_dwc[1]  = "id_conto_perdite_ce"
		ls_dbc[2]  = "codice"
		ls_dwc[2]  = "c_conto_perdite_ce_cod"
		ls_dbc[3]  = "descrizione"
		ls_dwc[3]  = "c_conto_perdite_ce_des"
		ll_ok = uf_autofind_col(dwo.Name, "conto", &
										"codice", "A", data, &
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
	CASE 'c_conto_perdite_ce_des'
		ls_sql_cond = ""  
		ls_dbc[1]  = "id_conto"
		ls_dwc[1]  = "id_conto_perdite_ce"
		ls_dbc[2]  = "codice"
		ls_dwc[2]  = "c_conto_perdite_ce_cod"
		ls_dbc[3]  = "descrizione"
		ls_dwc[3]  = "c_conto_perdite_ce_des"
		ll_ok = uf_autofind_col(dwo.Name, "conto", &
										"descrizione", "A", data, &
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
		
		CASE 'c_prof_apertura_cod'
		ls_sql_cond = ""  
		ls_dbc[1]  = "id_conto"
		ls_dwc[1]  = "id_prof_reg_apertura"
		ls_dbc[2]  = "codice"
		ls_dwc[2]  = "c_prof_apertura_cod"
		ls_dbc[3]  = "descrizione"
		ls_dwc[3]  = "c_prof_apertura_des"
		ll_ok = uf_autofind_col(dwo.Name, "prof_registrazione", &
										"codice", "A", data, &
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
	CASE 'c_prof_apertura_des'
		ls_sql_cond = ""  
		ls_dbc[1]  = "id_conto"
		ls_dwc[1]  = "id_prof_reg_apertura"
		ls_dbc[2]  = "codice"
		ls_dwc[2]  = "c_prof_apertura_cod"
		ls_dbc[3]  = "descrizione"
		ls_dwc[3]  = "c_prof_apertura_des"
		ll_ok = uf_autofind_col(dwo.Name, "prof_registrazione", &
										"descrizione", "A", data, &
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF

	CASE 'c_prof_chiusura_cod'
		ls_sql_cond = ""  
		ls_dbc[1]  = "id_conto"
		ls_dwc[1]  = "id_prof_reg_chiusura"
		ls_dbc[2]  = "codice"
		ls_dwc[2]  = "c_prof_chiusura_cod"
		ls_dbc[3]  = "descrizione"
		ls_dwc[3]  = "c_prof_chiusura_des"
		ll_ok = uf_autofind_col(dwo.Name, "prof_registrazione", &
										"codice", "A", data, &
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
	CASE 'c_prof_chiusura_des'
		ls_sql_cond = ""  
		ls_dbc[1]  = "id_conto"
		ls_dwc[1]  = "id_prof_reg_chiusura"
		ls_dbc[2]  = "codice"
		ls_dwc[2]  = "c_prof_chiusura_cod"
		ls_dbc[3]  = "descrizione"
		ls_dwc[3]  = "c_prof_chiusura_des"
		ll_ok = uf_autofind_col(dwo.Name, "prof_registrazione", &
										"descrizione", "A", data, &
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF

END CHOOSE

end event

event ue_init;call super::ue_init;is_list.s_identifica[1] = "id_par_sistema"

is_title = "Parametri di Sistema"

iudw_children[1] = tab_1.tabpage_commerciale.dw_par_sistema_comm_ff
iudw_children[2] = tab_1.tabpage_altro.dw_par_sistema_altro_ff
iudw_children[3] = tab_1.tabpage_2.dw_par_sistema_magazzino_ff
iudw_children[4] = tab_1.tabpage_intracom.dw_intra_contatore
iudw_children[5] = tab_1.tabpage_agenti.dw_par_sistema_agenti
iudw_children[6] = tab_1.tabpage_3.dw_par_sistema_cont2_ff

iudw_children[7] = tab_1.tabpage_altro.dw_par_lettore_gd

end event

event rowfocuschanged;call super::rowfocuschanged;
string 	ls_codice, ls_descrizione, ls_cc
long 		ll_row, ll_id_conto_iva_sospesa, ll_id_conto_iva_ia, ll_id_conto_iva_iv, &
			ll_id_conto_iva_nd, ll_id_conto_predefinito,ll_id_conto_utile_sp, &
			ll_id_conto_utile_ce,ll_id_conto_perdite_sp,ll_id_conto_perdite_ce, &
			ll_id_prof_reg_chiusura,ll_id_prof_reg_apertura,ll_mod_reg_iva_sos,ll_locazione

ll_row = GetRow()

if RowCount() > 0 then
	

	
	Event ue_crea_titolo_finestra()

	
	
	ll_id_conto_iva_sospesa = long(uf_get_colval("id_conto_iva_sospesa"))

	
	SELECT "conto"."codice" , "conto"."descrizione" 
	  	INTO : ls_codice, :ls_descrizione
     	FROM "conto" 
	 	WHERE ( "conto"."id_conto" = :ll_id_conto_iva_sospesa )   ;
	if sqlca.sqlcode=0 then
		
		uf_set_colval("c_conto_is_cod",ls_codice)
		uf_set_colval("c_conto_is_des",ls_descrizione)
		
		
		setitemstatus(ll_row, "c_conto_is_cod", PRIMARY!, NotModified!)
		setitemstatus(ll_row, "c_conto_is_des", PRIMARY!, NotModified!)
		
		ls_codice = ""
		ls_descrizione = ""
	end if

	
	
	ll_id_conto_iva_ia = long(uf_get_colval("id_conto_iva_ia"))

	
	SELECT "conto"."codice" , "conto"."descrizione" 
	  	INTO : ls_codice, :ls_descrizione
     	FROM "conto" 
	 	WHERE ( "conto"."id_conto" = :ll_id_conto_iva_ia )   ;
	if sqlca.sqlcode=0 then
		
		uf_set_colval("c_conto_ia_cod",ls_codice)
		uf_set_colval("c_conto_ia_des",ls_descrizione)
		
		
		setitemstatus(ll_row, "c_conto_ia_cod", PRIMARY!, NotModified!)
		setitemstatus(ll_row, "c_conto_ia_des", PRIMARY!, NotModified!)
		
		ls_codice = ""
		ls_descrizione = ""
	end if
	
	
	ll_id_conto_iva_iv = long(uf_get_colval("id_conto_iva_iv"))

	
	SELECT "conto"."codice" , "conto"."descrizione" 
	  	INTO : ls_codice, :ls_descrizione
     	FROM "conto" 
	 	WHERE ( "conto"."id_conto" = :ll_id_conto_iva_iv )   ;
	if sqlca.sqlcode=0 then
		
		uf_set_colval("c_conto_iv_cod",ls_codice)
		uf_set_colval("c_conto_iv_des",ls_descrizione)
		
		
		setitemstatus(ll_row, "c_conto_iv_cod", PRIMARY!, NotModified!)
		setitemstatus(ll_row, "c_conto_iv_des", PRIMARY!, NotModified!)
		
		ls_codice = ""
		ls_descrizione = ""
	end if
	
	
	ll_id_conto_iva_nd = long(uf_get_colval("id_conto_iva_nd"))

	
	SELECT "conto"."codice" , "conto"."descrizione" 
	  	INTO : ls_codice, :ls_descrizione
     	FROM "conto" 
	 	WHERE ( "conto"."id_conto" = :ll_id_conto_iva_nd )   ;
	if sqlca.sqlcode=0 then
		
		uf_set_colval("c_conto_nd_cod",ls_codice)
		uf_set_colval("c_conto_nd_des",ls_descrizione)
		
		
		setitemstatus(ll_row, "c_conto_nd_cod", PRIMARY!, NotModified!)
		setitemstatus(ll_row, "c_conto_nd_des", PRIMARY!, NotModified!)
		
		ls_codice = ""
		ls_descrizione = ""
	end if

	
	
	ll_id_conto_predefinito = long(uf_get_colval("id_conto_predefinito"))

	
	SELECT "conto"."codice" , "conto"."descrizione" 
	  	INTO : ls_codice, :ls_descrizione
     	FROM "conto" 
	 	WHERE ( "conto"."id_conto" = :ll_id_conto_predefinito )   ;
	if sqlca.sqlcode=0 then
		
		uf_set_colval("c_conto_pr_cod",ls_codice)
		uf_set_colval("c_conto_pr_des",ls_descrizione)
		
		
		setitemstatus(ll_row, "c_conto_pr_cod", PRIMARY!, NotModified!)
		setitemstatus(ll_row, "c_conto_pr_des", PRIMARY!, NotModified!)
		
		ls_codice = ""
		ls_descrizione = ""
	end if
	
	
	ll_id_conto_utile_sp= long(uf_get_colval("id_conto_utile_sp"))

	
	SELECT "conto"."codice" , "conto"."descrizione" 
	  	INTO : ls_codice, :ls_descrizione
     	FROM "conto" 
	 	WHERE ( "conto"."id_conto" = :ll_id_conto_utile_sp )   ;
	if sqlca.sqlcode=0 then
		
		uf_set_colval("c_conto_utile_sp_cod",ls_codice)
		uf_set_colval("c_conto_utile_sp_des",ls_descrizione)
		
		
		setitemstatus(ll_row, "c_conto_utile_sp_cod", PRIMARY!, NotModified!)
		setitemstatus(ll_row, "c_conto_utile_sp_des", PRIMARY!, NotModified!)
		
		ls_codice = ""
		ls_descrizione = ""
	end if
	
	
	ll_id_conto_perdite_sp= long(uf_get_colval("id_conto_perdite_sp"))

	
	SELECT "conto"."codice" , "conto"."descrizione" 
	  	INTO : ls_codice, :ls_descrizione
     	FROM "conto" 
	 	WHERE ( "conto"."id_conto" = :ll_id_conto_perdite_sp )   ;
	if sqlca.sqlcode=0 then
		
		uf_set_colval("c_conto_perdite_sp_cod",ls_codice)
		uf_set_colval("c_conto_perdite_sp_des",ls_descrizione)
		
		
		setitemstatus(ll_row, "c_conto_perdite_sp_cod", PRIMARY!, NotModified!)
		setitemstatus(ll_row, "c_conto_perdite_sp_des", PRIMARY!, NotModified!)
		
		ls_codice = ""
		ls_descrizione = ""
	end if
	
	
	ll_id_conto_utile_ce= long(uf_get_colval("id_conto_utile_ce"))

	
	SELECT "conto"."codice" , "conto"."descrizione" 
	  	INTO : ls_codice, :ls_descrizione
     	FROM "conto" 
	 	WHERE ( "conto"."id_conto" = :ll_id_conto_utile_ce )   ;
	if sqlca.sqlcode=0 then	
		
		uf_set_colval("c_conto_utile_ce_cod",ls_codice)
		uf_set_colval("c_conto_utile_ce_des",ls_descrizione)
		
		
		setitemstatus(ll_row, "c_conto_utile_ce_cod", PRIMARY!, NotModified!)
		setitemstatus(ll_row, "c_conto_utile_ce_des", PRIMARY!, NotModified!)
		
		ls_codice = ""
		ls_descrizione = ""
	end if
	
	
	ll_id_conto_perdite_ce= long(uf_get_colval("id_conto_perdite_ce"))

	
	SELECT "conto"."codice" , "conto"."descrizione" 
	  	INTO : ls_codice, :ls_descrizione
     	FROM "conto" 
	 	WHERE ( "conto"."id_conto" = :ll_id_conto_perdite_ce )   ;
	if sqlca.sqlcode=0 then
		
		uf_set_colval("c_conto_perdite_ce_cod",ls_codice)
		uf_set_colval("c_conto_perdite_ce_des",ls_descrizione)
		
		
		setitemstatus(ll_row, "c_conto_perdite_ce_cod", PRIMARY!, NotModified!)
		setitemstatus(ll_row, "c_conto_perdite_ce_des", PRIMARY!, NotModified!)
		
		ls_codice = ""
		ls_descrizione = ""	
	end if
	
	
	ll_id_prof_reg_apertura= long(uf_get_colval("id_prof_reg_apertura"))

	
	SELECT "prof_registrazione"."codice" , "prof_registrazione"."descrizione" 
	  	INTO : ls_codice, :ls_descrizione
     	FROM "prof_registrazione" 
	 	WHERE ( "prof_registrazione"."id_prof_registrazione" = :ll_id_prof_reg_apertura )   ;
	if sqlca.sqlcode=0 then
		
		uf_set_colval("c_prof_apertura_cod",ls_codice)
		uf_set_colval("c_prof_apertura_des",ls_descrizione)
		
		
		setitemstatus(ll_row, "c_prof_apertura_cod", PRIMARY!, NotModified!)
		setitemstatus(ll_row, "c_prof_apertura_des", PRIMARY!, NotModified!)
		
		ls_codice = ""
		ls_descrizione = ""	
	end if
	
	
	
	ll_id_prof_reg_chiusura= long(uf_get_colval("id_prof_reg_chiusura"))

	
	SELECT "prof_registrazione"."codice" , "prof_registrazione"."descrizione" 
	  	INTO : ls_codice, :ls_descrizione
     	FROM "prof_registrazione" 
	 	WHERE ( "prof_registrazione"."id_prof_registrazione" = :ll_id_prof_reg_chiusura )   ;
	if sqlca.sqlcode=0 then
		
		uf_set_colval("c_prof_chiusura_cod",ls_codice)
		uf_set_colval("c_prof_chiusura_des",ls_descrizione)
		
		
		setitemstatus(ll_row, "c_prof_chiusura_cod", PRIMARY!, NotModified!)
		setitemstatus(ll_row, "c_prof_chiusura_des", PRIMARY!, NotModified!)
		
		ls_codice = ""
		ls_descrizione = ""	
	end if		
	
	
	
	ll_id_prof_reg_chiusura= long(uf_get_colval("id_prof_reg_iva_sos"))

	
	SELECT "prof_registrazione"."codice" , "prof_registrazione"."descrizione" 
	  	INTO : ls_codice, :ls_descrizione
     	FROM "prof_registrazione" 
	 	WHERE ( "prof_registrazione"."id_prof_registrazione" = :ll_id_prof_reg_chiusura )   ;
	if sqlca.sqlcode=0 then
		
		uf_set_colval("c_prof_reg_iva_sos_cod",ls_codice)
		uf_set_colval("c_prof_reg_iva_sos_des",ls_descrizione)
		
		
		setitemstatus(ll_row, "c_prof_reg_iva_sos_cod", PRIMARY!, NotModified!)
		setitemstatus(ll_row, "c_prof_reg_iva_sos_des", PRIMARY!, NotModified!)
		
		ls_codice = ""
		ls_descrizione = ""
	end if
	
	
	
	ll_id_prof_reg_chiusura= long(uf_get_colval("id_prof_risc_fat_sos"))

	
	SELECT "prof_registrazione"."codice" , "prof_registrazione"."descrizione" 
	  	INTO : ls_codice, :ls_descrizione
     	FROM "prof_registrazione" 
	 	WHERE ( "prof_registrazione"."id_prof_registrazione" = :ll_id_prof_reg_chiusura )   ;
	if sqlca.sqlcode=0 then
		
		uf_set_colval("c_prof_risc_fat_sos_cod",ls_codice)
		uf_set_colval("c_prof_risc_fat_sos_des",ls_descrizione)
		
		
		setitemstatus(ll_row, "c_prof_risc_fat_sos_cod", PRIMARY!, NotModified!)
		setitemstatus(ll_row, "c_prof_risc_fat_sos_des", PRIMARY!, NotModified!)
		
		ls_codice = ""
		ls_descrizione = ""	
	end if
	
	
	
	ll_mod_reg_iva_sos= long(uf_get_colval("id_mod_reg_iva_sos"))

	
	SELECT "mod_registro"."tipo_registro" , "mod_registro"."descrizione" 
	  	INTO : ls_codice, :ls_descrizione
     	FROM "mod_registro" 
	 	WHERE ( "mod_registro"."id_mod_registro" = :ll_mod_reg_iva_sos )   ;
	if sqlca.sqlcode=0 then
		
		uf_set_colval("c_mod_reg_iva_sos_cod",ls_codice)
		uf_set_colval("c_mod_reg_iva_sos_des",ls_descrizione)
		
		
		setitemstatus(ll_row, "c_mod_reg_iva_sos_cod", PRIMARY!, NotModified!)
		setitemstatus(ll_row, "c_mod_reg_iva_sos_des", PRIMARY!, NotModified!)
		
		ls_codice = ""
		ls_descrizione = ""	
	end if

ll_locazione= long(uf_get_colval("id_locazione"))
SELECT (IfNull("magazzino"."descrizione", '',"magazzino"."descrizione") + ' (' + IfNull("magazzino"."codice",'',"magazzino"."codice") + ') - ' + IfNull("area"."codice", '',"area"."codice") + ' - ' + IfNull("locazione"."corsia", '', "locazione"."corsia") + ' - ' + IfNull("locazione"."scaffale", '', "locazione"."scaffale") + ' - ' + IfNull("locazione"."ripiano", '', "locazione"."ripiano") + ' - ' + IfNull("locazione"."posizione", '', "locazione"."posizione")) as c_descrizione
INTO :ls_codice
FROM "dba"."locazione"  LEFT OUTER JOIN "dba"."area"  ON "locazione"."id_area" = "area"."id_area",
		"dba"."magazzino"
WHERE ( "locazione"."id_magazzino" = "magazzino"."id_magazzino" ) and
		( ( "locazione"."id_locazione" = :ll_locazione ) );
if sqlca.sqlcode=0 then
	
	uf_set_colval("c_locazione_mag_des",ls_codice)
	
	
	setitemstatus(ll_row, "c_locazione_mag_des", PRIMARY!, NotModified!)
	
end if
ll_id_conto_iva_ia=getitemnumber(1, "id_cont_gen_acconto")
SELECT "conto"."codice" , "conto"."descrizione" 
	  	INTO : ls_codice, :ls_descrizione
     	FROM "conto" 
	 	WHERE ( "conto"."id_conto" = :ll_id_conto_iva_ia )   ;
	if sqlca.sqlcode=0 then
		
		uf_set_colval("c_conto_generico_acconto_cod",ls_codice)
		uf_set_colval("c_conto_generico_acconto_des",ls_descrizione)
		
		
		setitemstatus(ll_row, "c_conto_generico_acconto_cod", PRIMARY!, NotModified!)
		setitemstatus(ll_row, "c_conto_generico_acconto_des", PRIMARY!, NotModified!)
		
		ls_codice = ""
		ls_descrizione = ""
	end if

ls_codice=""
end if
end event

event ue_retrieve;call super::ue_retrieve;

	
long		ll_numr, ll_code, ll_idpar

ll_numr = this.rowcount()
if ll_numr = 0 then

	insert into par_sistema (id_azienda)
		values (1)
		using sqlca;
	ll_code = sqlca.sqlcode;
	if ll_code=0 then
		commit using sqlca;
		
		
		SELECT "dba"."par_sistema"."id_par_sistema"  
		 INTO :ll_idpar
		 FROM "dba"."par_sistema"
		 WHERE "dba"."par_sistema"."id_azienda" = 1;
		idw_master.is_list.l_identifica[1] = ll_idpar
		idw_master.is_list.s_modo = modo_modifica
		call super::ue_retrieve
		
	else
		
		MessageBox("Attenzione!", "Problemi nella creazione dell'azienda!")
		
		rollback using sqlca;
	end if
end if
This.Event ue_crea_titolo_finestra()
end event

event ue_set_search;call super::ue_set_search;
CHOOSE CASE as_nomecol
	CASE "c_conto_is_cod"
		is_search_window = "w_conto_azienda_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "conto_codice" 
	CASE "c_conto_is_des"
		is_search_window = "w_conto_azienda_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "conto_descrizione" 

	CASE "c_conto_ia_cod"
		is_search_window = "w_conto_azienda_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "conto_codice" 
	CASE "c_conto_ia_des"
		is_search_window = "w_conto_azienda_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "conto_descrizione" 

	CASE "c_conto_iv_cod"
		is_search_window = "w_conto_azienda_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "conto_codice" 
	CASE "c_conto_iv_des"
		is_search_window = "w_conto_azienda_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "conto_descrizione" 

	CASE "c_conto_nd_cod"
		is_search_window = "w_conto_azienda_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "conto_codice" 
	CASE "c_conto_nd_des"
		is_search_window = "w_conto_azienda_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "conto_descrizione" 

	CASE "c_conto_pr_cod"
		is_search_window = "w_conto_azienda_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "conto_codice" 
	CASE "c_conto_pr_des"
		is_search_window = "w_conto_azienda_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "conto_descrizione" 
	CASE "c_conto_utile_sp_cod"
		is_search_window = "w_conto_azienda_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "conto_codice" 
	CASE "c_conto_utile_sp_des"
		is_search_window = "w_conto_azienda_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "conto_descrizione" 
	CASE "c_conto_utile_ce_cod"
		is_search_window = "w_conto_azienda_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "conto_codice" 
	CASE "c_conto_utile_ce_des"
		is_search_window = "w_conto_azienda_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "conto_descrizione" 
	CASE "c_conto_perdite_sp_cod"
		is_search_window = "w_conto_azienda_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "conto_codice" 
	CASE "c_conto_perdite_sp_des"
		is_search_window = "w_conto_azienda_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "conto_descrizione" 
	CASE "c_conto_perdite_ce_cod"
		is_search_window = "w_conto_azienda_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "conto_codice" 
	CASE "c_conto_perdite_ce_des"
		is_search_window = "w_conto_azienda_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "conto_descrizione" 
	CASE "c_prof_apertura_cod"
		is_search_window = "w_prof_registrazione_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice" 
	CASE "c_prof_apertura_des"
		is_search_window = "w_prof_registrazione_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "descrizione" 
	CASE "c_prof_chiusura_cod"
		is_search_window = "w_prof_registrazione_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice" 
	CASE "c_prof_chiusura_des"
		is_search_window = "w_prof_registrazione_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "descrizione" 

	CASE "c_mod_reg_iva_sos_cod"
		is_search_window = "w_mod_registro_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "mod_registro_tipo_registro" 
	CASE "c_mod_reg_iva_sos_des"
		is_search_window = "w_mod_registro_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "mod_registro_descrizione" 
	CASE "c_prof_reg_iva_sos_cod"
		is_search_window = "w_prof_registrazione_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice" 
	CASE "c_prof_reg_iva_sos_des"
		is_search_window = "w_prof_registrazione_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "descrizione" 
	CASE "c_prof_risc_fat_sos_cod"
		is_search_window = "w_prof_registrazione_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice" 
	CASE "c_prof_risc_fat_sos_des"
		is_search_window = "w_prof_registrazione_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "descrizione" 
	
	CASE "c_conto_generico_acconto_cod"
		is_search_window = "w_conto_azienda_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "conto_codice" 
	CASE "c_conto_generico_acconto_des"
		is_search_window = "w_conto_azienda_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "conto_descrizione" 
		
				

END CHOOSE
end event

event ue_use_search;call super::ue_use_search;

CHOOSE CASE as_nomecol

	CASE "c_conto_is_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_conto_iva_sospesa", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_conto_is_des", is_ricpar.s_ausil_value[1])
	CASE "c_conto_is_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_conto_iva_sospesa", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_conto_is_cod", is_ricpar.s_ausil_value[1])

	CASE "c_conto_ia_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_conto_iva_ia", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_conto_ia_des", is_ricpar.s_ausil_value[1])
	CASE "c_conto_ia_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_conto_iva_ia", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_conto_ia_cod", is_ricpar.s_ausil_value[1])

	CASE "c_conto_iv_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_conto_iva_iv", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_conto_iv_des", is_ricpar.s_ausil_value[1])
	CASE "c_conto_iv_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_conto_iva_iv", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_conto_iv_cod", is_ricpar.s_ausil_value[1])

	CASE "c_conto_nd_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_conto_iva_nd", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_conto_nd_des", is_ricpar.s_ausil_value[1])
	CASE "c_conto_nd_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_conto_iva_nd", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_conto_nd_cod", is_ricpar.s_ausil_value[1])
		
	CASE "c_conto_pr_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_conto_predefinito", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_conto_pr_des", is_ricpar.s_ausil_value[1])
	CASE "c_conto_pr_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_conto_predefinito", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_conto_pr_cod", is_ricpar.s_ausil_value[1])
	CASE "c_conto_utile_sp_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_conto_utile_sp", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_conto_utile_sp_des", is_ricpar.s_ausil_value[1])
	CASE "c_conto_utile_sp_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_conto_utile_sp", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_conto_utile_sp_cod", is_ricpar.s_ausil_value[1])

	CASE "c_conto_utile_ce_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_conto_utile_ce", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_conto_utile_ce_des", is_ricpar.s_ausil_value[1])
	CASE "c_conto_utile_ce_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_conto_utile_ce", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_conto_utile_ce_cod", is_ricpar.s_ausil_value[1])
		
	CASE "c_conto_perdite_sp_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_conto_perdite_sp", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_conto_perdite_sp_des", is_ricpar.s_ausil_value[1])
	CASE "c_conto_perdite_sp_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_conto_perdite_sp", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_conto_perdite_sp_cod", is_ricpar.s_ausil_value[1])
		
	CASE "c_conto_perdite_ce_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_conto_perdite_ce", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_conto_perdite_ce_des", is_ricpar.s_ausil_value[1])
	CASE "c_conto_perdite_ce_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_conto_perdite_ce", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_conto_perdite_ce_cod", is_ricpar.s_ausil_value[1])

	CASE "c_prof_apertura_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_prof_reg_apertura", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_prof_apertura_des", is_ricpar.s_ausil_value[1])
	CASE "c_prof_apertura_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_prof_reg_apertura", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_prof_apertura_cod", is_ricpar.s_ausil_value[1])
		
	CASE "c_prof_chiusura_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_prof_reg_chiusura", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_prof_chiusura_des", is_ricpar.s_ausil_value[1])
	CASE "c_prof_chiusura_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_prof_reg_chiusura", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_prof_chiusura_cod", is_ricpar.s_ausil_value[1])		
	
	CASE "c_mod_reg_iva_sos_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_ausil_value[1])
		uf_set_colval("id_mod_reg_iva_sos", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_mod_reg_iva_sos_des",is_ricpar.s_main_value )
	CASE "c_mod_reg_iva_sos_des"
		uf_set_colval(as_nomecol,is_ricpar.s_ausil_value[1] )
		uf_set_colval("id_mod_reg_iva_sos", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_mod_reg_iva_sos_cod",is_ricpar.s_main_value )		
		
	CASE "c_prof_reg_iva_sos_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_prof_reg_iva_sos", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_prof_reg_iva_sos_des", is_ricpar.s_ausil_value[1])
	CASE "c_prof_reg_iva_sos_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_prof_reg_iva_sos", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_prof_reg_iva_sos_cod", is_ricpar.s_ausil_value[1])		
		
	CASE "c_prof_risc_fat_sos_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_prof_risc_fat_sos", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_prof_risc_fat_sos_des", is_ricpar.s_ausil_value[1])
	CASE "c_prof_risc_fat_sos_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_prof_risc_fat_sos", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_prof_risc_fat_sos_cod", is_ricpar.s_ausil_value[1])		
	
	CASE "c_conto_generico_acconto_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_cont_gen_acconto", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_conto_generico_acconto_des", is_ricpar.s_ausil_value[1])
	CASE "c_conto_generico_acconto_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_cont_gen_acconto", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_conto_generico_acconto_cod", is_ricpar.s_ausil_value[1])	
		
		
END CHOOSE

end event

event updatestart;call super::updatestart;long		ll_row, ll_id_valuta, ll_id_tab_iva_art_15

ll_row = GetRow()

if ll_row > 0 then
	ll_id_valuta = GetItemNumber(ll_row, "id_valuta")
	if IsNull(ll_id_valuta) then ll_id_valuta = 0
	ll_id_tab_iva_art_15 = GetItemNumber(ll_row, "id_tab_iva_art_15")
	if IsNull(ll_id_tab_iva_art_15) then ll_id_tab_iva_art_15 = 0
	if ll_id_valuta = 0 AND ll_id_tab_iva_art_15 <> 0 then
		MessageBox("Attenzione!", "Non è stato scelto nessun valore per VALUTA.")
		Beep(10)
		MessageBox("Attenzione!", "Ripeto: ~rNon è stato scelto nessun valore per VALUTA.")
		Return 0
	elseif ll_id_tab_iva_art_15 = 0 AND ll_id_valuta <> 0 then
		MessageBox("Attenzione!", "Non è stato scelto nessun valore per CODICE IVA ART. 15.")
		Beep(10)
		MessageBox("Attenzione!", "Ripeto: ~rNon è stato scelto nessun valore per CODICE IVA ART. 15.")
		Return 0
	elseif ll_id_tab_iva_art_15 = 0 AND ll_id_valuta = 0 then
		MessageBox("Attenzione!", "Non è stato scelto nessun valore per:~r     VALUTA," + &
					"~r     CODICE IVA ART. 15.")
		Beep(10)
		MessageBox("Attenzione!", "Ripeto: ~rNon è stato scelto nessun valore per:~r     VALUTA," + &
					"~r     CODICE IVA ART. 15.")
		Return 0
	else
		Return 0
	end if
end if

end event

type tabpage_3 from userobject within tab_1
int X=18
int Y=104
int Width=2395
int Height=1708
long BackColor=79741120
string Text="Contabilità/2"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
cb_5 cb_5
dw_par_sistema_cont2_ff dw_par_sistema_cont2_ff
end type

on tabpage_3.create
this.cb_5=create cb_5
this.dw_par_sistema_cont2_ff=create dw_par_sistema_cont2_ff
this.Control[]={this.cb_5,&
this.dw_par_sistema_cont2_ff}
end on

on tabpage_3.destroy
destroy(this.cb_5)
destroy(this.dw_par_sistema_cont2_ff)
end on

type cb_5 from commandbutton within tabpage_3
int X=64
int Y=1148
int Width=480
int Height=108
int TabOrder=24
boolean BringToTop=true
string Text="Riepilogo Liq.IVA"
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;open (w_riep_iva_att_lt)
end event

type dw_par_sistema_cont2_ff from u_dw_master_main within tabpage_3
int X=23
int Y=16
int Width=2359
int Height=1472
int TabOrder=3
string DataObject="d_par_sistema_cont2_ff"
end type

event ue_init;call super::ue_init;ib_dw_shared = TRUE
end event

event ue_set_search;CHOOSE CASE as_nomecol
CASE "c_mod_reg_iva_sos_cod"
		is_search_window = "w_mod_registro_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "mod_registro_tipo_registro" 
	CASE "c_mod_reg_iva_sos_des"
		is_search_window = "w_mod_registro_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "mod_registro_descrizione" 
	CASE "c_prof_reg_iva_sos_cod"
		is_search_window = "w_prof_registrazione_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice" 
	CASE "c_prof_reg_iva_sos_des"
		is_search_window = "w_prof_registrazione_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "descrizione" 
	CASE "c_prof_risc_fat_sos_cod"
		is_search_window = "w_prof_registrazione_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice" 
	CASE "c_prof_risc_fat_sos_des"
		is_search_window = "w_prof_registrazione_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "descrizione" 

END CHOOSE
end event

event ue_use_search;call super::ue_use_search;CHOOSE CASE as_nomecol
	CASE "c_mod_reg_iva_sos_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_ausil_value[1])
		uf_set_colval("id_mod_reg_iva_sos", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_mod_reg_iva_sos_des",is_ricpar.s_main_value )
	CASE "c_mod_reg_iva_sos_des"
		uf_set_colval(as_nomecol,is_ricpar.s_ausil_value[1] )
		uf_set_colval("id_mod_reg_iva_sos", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_mod_reg_iva_sos_cod",is_ricpar.s_main_value )		
		
	CASE "c_prof_reg_iva_sos_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_prof_reg_iva_sos", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_prof_reg_iva_sos_des", is_ricpar.s_ausil_value[1])
	CASE "c_prof_reg_iva_sos_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_prof_reg_iva_sos", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_prof_reg_iva_sos_cod", is_ricpar.s_ausil_value[1])		
		
	CASE "c_prof_risc_fat_sos_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_prof_risc_fat_sos", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_prof_risc_fat_sos_des", is_ricpar.s_ausil_value[1])
	CASE "c_prof_risc_fat_sos_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_prof_risc_fat_sos", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_prof_risc_fat_sos_cod", is_ricpar.s_ausil_value[1])	
END CHOOSE
end event

event itemchanged;
string    ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
long      ll_ok
CHOOSE CASE dwo.name
	
CASE "c_mod_reg_iva_sos_cod"
		ls_sql_cond = ""  
		ls_dbc[1]  = "id_mod_registro"
		ls_dwc[1]  = "id_mod_reg_iva_sos" 
		ls_dbc[2]  = "tipo_registro"
		ls_dwc[2]  = "c_mod_reg_iva_sos_cod"
		ls_dbc[3]  = "descrizione"
		ls_dwc[3]  = "c_mod_reg_iva_sos_des"
		ll_ok = uf_autofind_col(dwo.Name, "mod_registro", &
										"tipo_registro", "A", data, &
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
	IF (ll_ok > 0) THEN
			RETURN 2
		END IF
			
CASE "c_mod_reg_iva_sos_des"
		ls_sql_cond = ""  
		ls_dbc[1]  = "id_mod_registro"
		ls_dwc[1]  = "id_reg_iva_sos"
		ls_dbc[2]  = "tipo_registro"
		ls_dwc[2]  = "c_mod_reg_iva_sos_cod"
		ls_dbc[3]  = "descrizione"
		ls_dwc[3]  = "c_mod_reg_iva_sos_des"
		ll_ok = uf_autofind_col(dwo.Name, "mod_registro", &
										"descrizione", "A", data, &
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
	IF (ll_ok > 0) THEN
			RETURN 2
		END IF
CASE "c_prof_reg_iva_sos_cod"
		ls_sql_cond = ""  
		ls_dbc[1]  = "id_prof_registrazione"
		ls_dwc[1]  = "id_prof_reg_iva_sos"
		ls_dbc[2]  = "codice"
		ls_dwc[2]  = "c_prof_reg_iva_sos_cod"
		ls_dbc[3]  = "descrizione"
		ls_dwc[3]  = "c_prof_reg_iva_sos_des"
		ll_ok = uf_autofind_col(dwo.Name, "prof_registrazione", &
										"codice", "A", data, &
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
	IF (ll_ok > 0) THEN
			RETURN 2
		END IF
CASE "c_prof_reg_iva_sos_des"
		ls_sql_cond = ""  
		ls_dbc[1]  = "id_prof_registrazione"
		ls_dwc[1]  = "id_prof_reg_iva_sos"
		ls_dbc[2]  = "codice"
		ls_dwc[2]  = "c_prof_reg_iva_sos_cod"
		ls_dbc[3]  = "descrizione"
		ls_dwc[3]  = "c_prof_reg_iva_sos_des"
		ll_ok = uf_autofind_col(dwo.Name, "prof_registrazione", &
										"descrizione", "A", data, &
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
	IF (ll_ok > 0) THEN
			RETURN 2
		END IF		
CASE "c_prof_risc_fat_sos_cod"
		ls_sql_cond = ""  
		ls_dbc[1]  = "id_prof_registrazione"
		ls_dwc[1]  = "id_prof_risc_fat_sos"
		ls_dbc[2]  = "codice"
		ls_dwc[2]  = "c_prof_risc_fat_sos_cod"
		ls_dbc[3]  = "descrizione"
		ls_dwc[3]  = "c_prof_risc_fat_sos_des"
		ll_ok = uf_autofind_col(dwo.Name, "prof_registrazione", &
										"codice", "A", data, &
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
	IF (ll_ok > 0) THEN
			RETURN 2
		END IF
CASE "c_prof_risc_fat_sos_des"
		ls_sql_cond = ""  
		ls_dbc[1]  = "id_prof_registrazione"
		ls_dwc[1]  = "id_prof_risc_fat_sos"
		ls_dbc[2]  = "codice"
		ls_dwc[2]  = "c_prof_risc_fat_sos_cod"
		ls_dbc[3]  = "descrizione"
		ls_dwc[3]  = "c_prof_risc_fat_sos_des"
		ll_ok = uf_autofind_col(dwo.Name, "prof_registrazione", &
										"descrizione", "A", data, &
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
	IF (ll_ok > 0) THEN
			RETURN 2
		END IF		
END CHOOSE

end event

type tabpage_commerciale from userobject within tab_1
int X=18
int Y=104
int Width=2395
int Height=1708
long BackColor=79741120
string Text="Commerciale"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_par_sistema_comm_ff dw_par_sistema_comm_ff
end type

on tabpage_commerciale.create
this.dw_par_sistema_comm_ff=create dw_par_sistema_comm_ff
this.Control[]={this.dw_par_sistema_comm_ff}
end on

on tabpage_commerciale.destroy
destroy(this.dw_par_sistema_comm_ff)
end on

type dw_par_sistema_comm_ff from u_dw_master_main within tabpage_commerciale
int X=23
int Y=36
int Width=2359
int Height=1428
int TabOrder=1
string DataObject="d_par_sistema_comm_ff"
end type

event clicked;call super::clicked;

string 			ls_spesa, ls_int_cons
long	 			ll_count, ll_len
string 			ls_nomedwo, ls_tipodwo, la_array[]
s_list_main 	lstr_list
w_search_main	lw_sm

ls_nomedwo = dwo.name
ls_tipodwo = dwo.type
if ls_nomedwo="spese_gestite_msw" then
	AcceptText()
	lstr_list.s_win_parametri = GetItemString(row,"spese_gestite")
	OpenWithParm(w_spesa_scelta_lt,lstr_list)
	u_freddie.sp_pop(la_array)
	SetItem(row,"spese_gestite", la_array[1])
	ScrollToRow(row)
	u_freddie.sp_drop()
end if

end event

event ue_key;call super::ue_key;string 			ls_spesa, ls_int_cons
long 				ll_count, ll_len, ll_row
string 			ls_nomedwo, ls_tipodwo, la_array[]
s_list_main 	lstr_list


ll_row = GetRow()

if key=KeyF4! and ll_row > 0 AND GetColumnName( ) = "spese_gestite" then
	AcceptText()
	lstr_list.s_win_parametri = GetItemString(ll_row,"spese_gestite")
	OpenWithParm(w_spesa_scelta_lt,lstr_list)
	u_freddie.sp_pop(la_array)
	SetItem(ll_row,"spese_gestite", la_array[1])
	u_freddie.sp_drop()
end if

end event

event ue_set_search;call super::ue_set_search;
CHOOSE CASE as_nomecol
	
	CASE "id_valuta"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_valuta_gd"
		is_ricpar.s_titolo_finestra = "Valute"
		is_ricpar.s_ausil_value[1] = "id_valuta_des"
		is_ricpar.i_width = 2798
		is_ricpar.i_height = 861
	CASE "id_valuta_des"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_valuta_gd"
		is_ricpar.s_titolo_finestra = "Valute"
		is_ricpar.s_ausil_value[1] = "id_valuta"
		is_ricpar.i_width = 2798
		is_ricpar.i_height = 861

	CASE "id_linguaggio"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_linguaggio_gd"
		is_ricpar.s_titolo_finestra = "Linguaggi"
		is_ricpar.s_ausil_value[1] = "id_linguaggio_des"
	CASE "id_linguaggio_des"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_linguaggio_gd"
		is_ricpar.s_titolo_finestra = "Linguaggi"
		is_ricpar.s_ausil_value[1] = "id_linguaggio"
		
	CASE "id_lingua"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_lingua_gd"
		is_ricpar.s_titolo_finestra = "Lingue"
		is_ricpar.s_ausil_value[1] = "id_lingua_des"
	CASE "id_lingua_des"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_lingua_gd"
		is_ricpar.s_titolo_finestra = "Lingue"
		is_ricpar.s_ausil_value[1] = "id_lingua"
		
END CHOOSE

end event

event ue_init;call super::ue_init;ib_dw_shared = TRUE
is_list.s_colonne_drop[1] = "id_valuta"
is_list.s_colonne_drop[2] = "id_valuta_des"
is_list.s_colonne_drop[3] = "id_lingua"
is_list.s_colonne_drop[4] = "id_lingua_des"
is_list.s_colonne_drop[5] = "id_linguaggio"
is_list.s_colonne_drop[6] = "id_tipo_pagamento"
is_list.s_colonne_drop[7] = "id_tipo_pagamento_des"
is_list.s_colonne_drop[8] = "id_linguaggio_des"
is_list.s_colonne_drop[9] = "id_tipo_documento"
is_list.s_colonne_drop[10] = "id_tipo_documento_des"
is_list.s_colonne_drop[11] = "id_val_euro"

end event

type tabpage_altro from userobject within tab_1
int X=18
int Y=104
int Width=2395
int Height=1708
long BackColor=79741120
string Text="Altro"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_par_sistema_altro_ff dw_par_sistema_altro_ff
dw_par_lettore_gd dw_par_lettore_gd
end type

on tabpage_altro.create
this.dw_par_sistema_altro_ff=create dw_par_sistema_altro_ff
this.dw_par_lettore_gd=create dw_par_lettore_gd
this.Control[]={this.dw_par_sistema_altro_ff,&
this.dw_par_lettore_gd}
end on

on tabpage_altro.destroy
destroy(this.dw_par_sistema_altro_ff)
destroy(this.dw_par_lettore_gd)
end on

type dw_par_sistema_altro_ff from u_dw_master_main within tabpage_altro
int X=23
int Y=36
int Width=2359
int Height=588
int TabOrder=1
string DataObject="d_par_sistema_altro_ff"
end type

event ue_init;call super::ue_init;ib_dw_shared = TRUE
end event

event itemchanged;call super::itemchanged;string	ls_colname, ls_text

ls_colname = This.GetColumnName()
ls_text = data
ls_text = Trim(ls_text)
DO WHILE Right(ls_text, 1) = "\"
	ls_text = Mid (ls_text, 1, len(ls_text)-1)
	SetItem(row, ls_colname, ls_text)
LOOP
Post SetItem(row, ls_colname, ls_text)
Return 0
end event

type dw_par_lettore_gd from u_dw_master_main within tabpage_altro
int X=23
int Y=648
int Width=2359
int Height=1044
int TabOrder=12
boolean BringToTop=true
string DataObject="d_par_lettore_gd"
boolean TitleBar=true
string Title="Impostazioni terminale per l'acquisizione dei codici a barre"
boolean VScrollBar=true
end type

event ue_init;call super::ue_init;is_list.s_identifica[1] = "id_par_sistema"
end event

type tabpage_2 from userobject within tab_1
int X=18
int Y=104
int Width=2395
int Height=1708
long BackColor=79741120
string Text="Magazzino"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_par_sistema_magazzino_ff dw_par_sistema_magazzino_ff
end type

on tabpage_2.create
this.dw_par_sistema_magazzino_ff=create dw_par_sistema_magazzino_ff
this.Control[]={this.dw_par_sistema_magazzino_ff}
end on

on tabpage_2.destroy
destroy(this.dw_par_sistema_magazzino_ff)
end on

type dw_par_sistema_magazzino_ff from u_dw_master_main within tabpage_2
event itemchanged pbm_dwnitemchange
event ue_init pbm_custom01
int X=14
int Y=20
int Width=2359
int Height=1672
string DataObject="d_par_sistema_magazzino_ff"
end type

event itemchanged;string	ls_colname, ls_text

ls_colname = This.GetColumnName()
ls_text = data
ls_text = Trim(ls_text)
DO WHILE Right(ls_text, 1) = "\"
	ls_text = Mid (ls_text, 1, len(ls_text)-1)
	SetItem(row, ls_colname, ls_text)
LOOP
Post SetItem(row, ls_colname, ls_text)
if dwo.name='ges_locazioni' then
	long ll_mag,ll_locazioni
	string ls_prec
	boolean lb_cambia
	ls_prec=this.getitemstring(1,"ges_locazioni")
	if ls_prec='S' then
		lb_cambia=true
		declare mag cursor for
		select id_magazzino
		from magazzino;
		open mag;
		fetch mag into :ll_mag;
		do while sqlca.sqlcode=0
			select count(id_locazione)
			into :ll_locazioni
			from locazione
			where id_magazzino=:ll_mag;
			if ll_locazioni>1 then lb_cambia=false
		fetch mag into :ll_mag;
		loop
		close mag;
		if lb_cambia=false then 
			Messagebox("Informazione","E' impossibile effettuare la modifica sono già state effettuate delle operazioni")
			post setitem(1,"ges_locazioni",ls_prec)
		end if
	end if
end if

long ll_null
setnull(ll_null)

CHOOSE CASE dwo.name
	CASE "non_mov_senza_cf"
		if (isnull(data) or data = 'N') then this.setitem(row, "id_caus_mag_nmn", ll_null)
END CHOOSE
end event

event ue_init;call super::ue_init;ib_dw_shared = TRUE
is_list.s_colonne_drop[1] = "id_magazzino"
is_list.s_colonne_drop[2] = "id_magazzino_des"
is_list.s_colonne_drop[3] = "id_unita_misura"
is_list.s_colonne_drop[4] = "id_unita_mis_peso"
is_list.s_colonne_drop[5] = "id_unita_mis_volume"
is_list.s_colonne_drop[6] = "id_cat_fis_prop"
is_list.s_colonne_drop[7] = "id_unita_conf"
is_list.s_colonne_drop[8] = "id_unita_conf_des"
is_list.s_colonne_drop[8] = "id_mod_reg_merci_deposito"
end event

event ue_set_search;call super::ue_set_search;
CHOOSE CASE as_nomecol
	CASE "c_locazione_mag_des"
		is_search_window = "w_locazione_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "cc_locazione_mag" 
END CHOOSE


CHOOSE CASE as_nomecol
		
	CASE "id_caus_mag_nmn"
		is_search_window = "w_mod_single_data"
		is_ricpar.i_width = 1900
		is_ricpar.i_height = 1500
		is_ricpar.s_datawindow = "d_caus_magazzino_gd"
		is_ricpar.s_titolo_finestra = "Causali di magazzino"
END CHOOSE
end event

event ue_use_search;call super::ue_use_search;
String	ls_id_locazione , ls_locazione , ls_array
Long		ll_row,ll_id_magazzino


CHOOSE CASE as_nomecol
CASE "c_locazione_mag_des"
			uf_set_colval(as_nomecol, is_ricpar.s_main_value)
			ls_id_locazione = is_ricpar.s_id_seg_value[1]

			
			ll_row = THIS.GetRow()
			THIS.SetItem(ll_row,'id_locazione',Long(ls_id_locazione))
			select id_magazzino
			into :ll_id_magazzino
			from locazione
			where id_locazione=:ls_id_locazione;
			THIS.SetItem(ll_row,'id_magazzino',ll_id_magazzino)
			
END CHOOSE

end event

type tabpage_intracom from userobject within tab_1
int X=18
int Y=104
int Width=2395
int Height=1708
long BackColor=79741120
string Text="Intracomunitari"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_intra_contatore dw_intra_contatore
end type

on tabpage_intracom.create
this.dw_intra_contatore=create dw_intra_contatore
this.Control[]={this.dw_intra_contatore}
end on

on tabpage_intracom.destroy
destroy(this.dw_intra_contatore)
end on

type dw_intra_contatore from u_dw_master_main within tabpage_intracom
event ue_init pbm_custom01
int X=0
int Y=28
int Width=2382
int Height=1668
int TabOrder=3
string DataObject="d_intra_contatore"
end type

event ue_init;call super::ue_init;is_list.s_identifica[1] = "id_par_sistema"
end event

event ue_use_search;call super::ue_use_search;CHOOSE CASE as_nomecol
	CASE "mod_reg_acq_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("intra_mod_reg_acq", is_ricpar.s_id_seg_value[1])
		uf_set_colval("mod_reg_acq_cod", is_ricpar.s_ausil_value[1])
	CASE "mod_reg_vend_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("intra_mod_reg_vend", is_ricpar.s_id_seg_value[1])
		uf_set_colval("mod_reg_vend_cod", is_ricpar.s_ausil_value[1])	
		
END CHOOSE




end event

event ue_set_search;call super::ue_set_search;
CHOOSE CASE as_nomecol
	CASE "mod_reg_acq_cod"
		is_search_window = "w_mod_registro_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "mod_registro_tipo_registro" 
	CASE "mod_reg_acq_des"
		is_search_window = "w_mod_registro_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "mod_registro_descrizione" 
	CASE "mod_reg_vend_cod"
		is_search_window = "w_mod_registro_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "mod_registro_tipo_registro" 
	CASE "mod_reg_vend_des"
		is_search_window = "w_mod_registro_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "mod_registro_descrizione" 

END CHOOSE

end event

event rowfocuschanged;call super::rowfocuschanged;
long ll_id, ll_row
string ls_cod,ls_des
ll_row=getrow()



ll_id= long(uf_get_colval("intra_mod_reg_acq"))
select tipo_registro,descrizione
into :ls_cod,:ls_des
from mod_registro
where id_mod_registro=:ll_id;
if sqlca.sqlcode=0 then
		uf_set_colval("mod_reg_acq_cod",ls_cod)
		uf_set_colval("mod_reg_acq_des",ls_des)
		setitemstatus(ll_row, "mod_reg_acq_cod", PRIMARY!, NotModified!)
		setitemstatus(ll_row, "mod_reg_acq_des", PRIMARY!, NotModified!)
		
		ls_cod = ""
		ls_des = ""
	end if






ll_id= long(uf_get_colval("intra_mod_reg_vend"))
select tipo_registro,descrizione
into :ls_cod,:ls_des
from mod_registro
where id_mod_registro=:ll_id;
if sqlca.sqlcode=0 then
		uf_set_colval("mod_reg_vend_cod",ls_cod)
		uf_set_colval("mod_reg_vend_des",ls_des)
		setitemstatus(ll_row, "mod_reg_vend_cod", PRIMARY!, NotModified!)
		setitemstatus(ll_row, "mod_reg_vend_des", PRIMARY!, NotModified!)
		
		ls_cod = ""
		ls_des = ""
	end if






end event

type tabpage_agenti from userobject within tab_1
int X=18
int Y=104
int Width=2395
int Height=1708
long BackColor=79741120
string Text="Agenti"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
cb_4 cb_4
dw_par_sistema_agenti dw_par_sistema_agenti
end type

on tabpage_agenti.create
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.cb_4=create cb_4
this.dw_par_sistema_agenti=create dw_par_sistema_agenti
this.Control[]={this.cb_1,&
this.cb_2,&
this.cb_3,&
this.cb_4,&
this.dw_par_sistema_agenti}
end on

on tabpage_agenti.destroy
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.cb_4)
destroy(this.dw_par_sistema_agenti)
end on

type cb_1 from commandbutton within tabpage_agenti
int X=50
int Y=60
int Width=599
int Height=84
int TabOrder=10
boolean BringToTop=true
string Text="L.Provvigioni"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;open (w_liq_provvigione_lt)
end event

type cb_2 from commandbutton within tabpage_agenti
int X=50
int Y=152
int Width=599
int Height=84
int TabOrder=30
boolean BringToTop=true
string Text="Star del Credere"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;open ( w_star_credere_lt )
end event

type cb_3 from commandbutton within tabpage_agenti
int X=50
int Y=244
int Width=599
int Height=84
int TabOrder=40
boolean BringToTop=true
string Text="Premi / Penalità"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;open ( w_premi_penalita_lt )
end event

type cb_4 from commandbutton within tabpage_agenti
int X=50
int Y=336
int Width=599
int Height=84
int TabOrder=50
boolean BringToTop=true
string Text="Budget / Premio a Importo"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;open ( w_budget_lt )
end event

type dw_par_sistema_agenti from u_dw_master_main within tabpage_agenti
int X=18
int Y=32
int Width=2354
int Height=1664
int TabOrder=20
string DataObject="d_par_sistema_agenti_ff"
end type

event ue_init;call super::ue_init;is_list.s_colonne_drop[1] = "id_tipo_agente"
ib_dw_shared = true
end event

event itemchanged;call super::itemchanged;decimal ld_percentuale
choose case dwo.name
	case 'rip_per_fatturato'
		ld_percentuale=100 - dec(data)
		tab_1.tabpage_agenti.dw_par_sistema_agenti.setitem(1,"rip_per_incassato",ld_percentuale)
	case 'rip_per_incassato'
		ld_percentuale=100 - dec(data)
		tab_1.tabpage_agenti.dw_par_sistema_agenti.setitem(1,"rip_per_fatturato",ld_percentuale)
end choose
end event

