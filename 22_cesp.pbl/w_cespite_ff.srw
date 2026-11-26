forward
global type w_cespite_ff from w_p_data
end type
type dw_cespite_ff from u_dw_master_main within tabpage_1
end type
type tabpage_2 from userobject within tab_1
end type
type dw_cespite_2_ff from u_dw_master_main within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_cespite_2_ff dw_cespite_2_ff
end type
type tabpage_3 from userobject within tab_1
end type
type dw_movimenti_cespite_lt from u_dw_master_main within tabpage_3
end type
type tabpage_3 from userobject within tab_1
dw_movimenti_cespite_lt dw_movimenti_cespite_lt
end type
type cb_crea_movimento from commandbutton within w_cespite_ff
end type
end forward

global type w_cespite_ff from w_p_data
integer x = 123
integer y = 36
integer width = 3090
integer height = 1708
string title = "Cespiti"
cb_crea_movimento cb_crea_movimento
end type
global w_cespite_ff w_cespite_ff

type variables

long il_euro
end variables

forward prototypes
public subroutine uf_ricerca ()
public subroutine wf_inserisci_acquisto ()
public subroutine wf_crea_movimento (long al_id_cespite, decimal ad_tot_normale, decimal ad_tot_anticipato, integer ad_anni_ammortizzati)
public subroutine wf_salva ()
end prototypes

public subroutine uf_ricerca ();

w_search_main lw_sm
long ll_id_cespite
s_ric_param ls_ricpar

idw_master.is_ricpar.s_filter_name = "codice"
idw_master.is_ricpar.b_imm_retrieve = TRUE

OpenWithParm(lw_sm, idw_master.is_ricpar, "w_cespite_sw")
idw_master.is_ricpar = Message.PowerObjectParm

IF UpperBound(idw_master.is_ricpar.s_id_seg_value) > 0 THEN
	ll_id_cespite = long(idw_master.is_ricpar.s_id_seg_value[1])
	idw_master.is_list.s_modo = modo_modifica
	idw_master.is_list.s_identifica[1] = "id_cespite"
	idw_master.is_list.l_identifica[1] = ll_id_cespite
	tab_1.tabpage_1.dw_cespite_ff.event post ue_setta_padre()
	idw_master.Event ue_retrieve(0, 0)
	idw_master.SetItemStatus(idw_master.GetRow(), 0, Primary!, NotModified!)
END IF

idw_master.SetFocus()
end subroutine

public subroutine wf_inserisci_acquisto ();integer li_riga
long ll_cespite, ll_id_prof_cespite, ll_id_valuta, ll_id_esercizio
date ld_data_acq
decimal ld_importo
	li_riga=tab_1.tabpage_3.dw_movimenti_cespite_lt.insertrow(1)
	select id_prof_cespite
	into :ll_id_prof_cespite
	from prof_cespite
	where prof_base='V' and acquisto='S';
	if ll_id_prof_cespite>0 then
		ll_cespite=tab_1.tabpage_1.dw_cespite_ff.getitemnumber(1, "id_cespite")
		ld_data_acq=tab_1.tabpage_1.dw_cespite_ff.getitemdate(1, "data_inizio_utilizzo")
		select id_val_euro
		into :ll_id_valuta
		from par_sistema;
		select id_esercizio
		into :ll_id_esercizio
		from esercizio
		where data_inizio<=:ld_data_acq and data_fine>=:ld_data_acq;
		ld_importo=tab_1.tabpage_1.dw_cespite_ff.getitemdecimal(1, "valore_acq")
		ld_data_acq=tab_1.tabpage_1.dw_cespite_ff.getitemdate(1, "data_inizio_utilizzo")
		
		tab_1.tabpage_3.dw_movimenti_cespite_lt.setitem(li_riga, "id_cespite", ll_cespite)
		tab_1.tabpage_3.dw_movimenti_cespite_lt.setitem(li_riga, "id_prof_cespite_cod", ll_id_prof_cespite)
		tab_1.tabpage_3.dw_movimenti_cespite_lt.setitem(li_riga, "data_mov_cespite", ld_data_acq)	
		tab_1.tabpage_3.dw_movimenti_cespite_lt.setitem(li_riga, "id_esercizio", ll_id_esercizio)
		tab_1.tabpage_3.dw_movimenti_cespite_lt.setitem(li_riga, "id_valuta", ll_id_valuta)
		tab_1.tabpage_3.dw_movimenti_cespite_lt.setitem(li_riga, "importo", ld_importo)
		tab_1.tabpage_3.dw_movimenti_cespite_lt.setitem(li_riga, "acquisto", "S")
	else
		messagebox("Attenzione!", "Causale d'acquisto cespite non trovata (o ne esiste più di una!)")
	end if
end subroutine

public subroutine wf_crea_movimento (long al_id_cespite, decimal ad_tot_normale, decimal ad_tot_anticipato, integer ad_anni_ammortizzati);
DECIMAL ld_importo
LONG ll_num,ll_valuta,ll_cat_int,ll_reg_pd, ll_num_p, ll_registro
LONG ll_cfondo_ant, ll_cfondo_ord, ll_cquota_ord, ll_cquota_ant, ll_anni , ll_id_esercizio
LONG ll_id_prof_cespite, ll_id_valuta
INTEGER  li_riga, i
STRING ls_filter
date ld_data_acq,ld_data_inizio




ld_data_acq=tab_1.tabpage_1.dw_cespite_ff.getitemdate(1, "data_inizio_utilizzo")
ld_data_inizio=ld_data_acq

for i=1 to ad_anni_ammortizzati
	if i=1 then 
		ld_data_acq=date(year(ld_data_acq),12,31)
	else
		ld_data_acq=date(year(ld_data_acq)+1,12,31)
	end if
	
	select id_esercizio
	into :ll_id_esercizio
	from esercizio
	where data_inizio<=:ld_data_acq and data_fine>=:ld_data_acq;
	
	SELECT id_valuta INTO :ll_valuta
	FROM esercizio WHERE id_esercizio=:ll_id_esercizio;
		
	if ad_tot_normale>0 then
		select id_prof_cespite
		into :ll_id_prof_cespite
		from prof_cespite
		where prof_base='N';
		li_riga=tab_1.tabpage_3.dw_movimenti_cespite_lt.insertrow(0)
		
		tab_1.tabpage_3.dw_movimenti_cespite_lt.setitem(li_riga, "id_cespite", al_id_cespite)
		tab_1.tabpage_3.dw_movimenti_cespite_lt.setitem(li_riga, "id_prof_cespite_cod", ll_id_prof_cespite)
		tab_1.tabpage_3.dw_movimenti_cespite_lt.setitem(li_riga, "data_mov_cespite", ld_data_acq)	
		tab_1.tabpage_3.dw_movimenti_cespite_lt.setitem(li_riga, "id_esercizio", ll_id_esercizio)
		tab_1.tabpage_3.dw_movimenti_cespite_lt.setitem(li_riga, "id_valuta", ll_id_valuta)
		tab_1.tabpage_3.dw_movimenti_cespite_lt.setitem(li_riga, "importo", ad_tot_normale)
	end if
	if ad_tot_anticipato>0 then
		select id_prof_cespite
		into :ll_id_prof_cespite
		from prof_cespite
		where prof_base='A';
		li_riga=tab_1.tabpage_3.dw_movimenti_cespite_lt.insertrow(0)
	
		tab_1.tabpage_3.dw_movimenti_cespite_lt.setitem(li_riga, "id_cespite", al_id_cespite)
		tab_1.tabpage_3.dw_movimenti_cespite_lt.setitem(li_riga, "id_prof_cespite_cod", ll_id_prof_cespite)
		tab_1.tabpage_3.dw_movimenti_cespite_lt.setitem(li_riga, "data_mov_cespite", ld_data_acq)	
		tab_1.tabpage_3.dw_movimenti_cespite_lt.setitem(li_riga, "id_esercizio", ll_id_esercizio)
		tab_1.tabpage_3.dw_movimenti_cespite_lt.setitem(li_riga, "id_valuta", ll_id_valuta)
		tab_1.tabpage_3.dw_movimenti_cespite_lt.setitem(li_riga, "importo", ad_tot_anticipato)
	end if
next

ld_data_inizio=date(year(ld_data_inizio),12,31)
tab_1.tabpage_2.dw_cespite_2_ff.setitem(1,"data_inizio_amm",ld_data_inizio)
end subroutine

public subroutine wf_salva ();if tab_1.tabpage_3.dw_movimenti_cespite_lt.update()=1 then
		commit;
	else
		rollback;
	end if
end subroutine

on w_cespite_ff.create
int iCurrent
call super::create
this.cb_crea_movimento=create cb_crea_movimento
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_crea_movimento
end on

on w_cespite_ff.destroy
call super::destroy
destroy(this.cb_crea_movimento)
end on

event open;call super::open;


long ll_screenh
environment le_env

idw_master = tab_1.tabpage_1.dw_cespite_ff
idw_master.is_list = Message.PowerObjectParm

idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_sql_ident[1] = "cespite.id_cespite"

ib_NonModale = TRUE

IF UpperBound(idw_master.is_list.s_identifica) = 0 THEN
	idw_master.ias_key_name[1] = "id_cespite"
	idw_master.is_list.s_modo = modo_inserisci
	GetEnvironment(le_env)
	ll_screenh = PixelsToUnits(le_env.screenheight,YPixelsToUnits!)
	THIS.y = 0
END IF

SELECT id_val_euro INTO :il_euro FROM par_sistema;

end event

event ue_master_delete;call super::ue_master_delete;

IF (idw_master.Event ue_delete(0, 0) = 0) THEN
	
	ib_AskForSave = FALSE
	IF (idw_master.uf_To_Update() > 0) THEN
		IF (idw_master.Event ue_update(0, 0) = 0) THEN
			ib_AskForSave = TRUE
			idw_master.is_list.s_modo = modo_inserisci
			idw_master.Event ue_insert(0, 0)
		END IF
	END IF
END IF
idw_master.SetFocus()
end event

event close;call super::close;long ll_id_cespite
decimal ld_residuo_da_amm
string ls_param

ll_id_cespite=tab_1.tabpage_1.dw_cespite_ff.getitemnumber(1,"id_cespite")
ld_residuo_da_amm=tab_1.tabpage_2.dw_cespite_2_ff.getitemnumber(1,"residuo")
ls_param=string(ll_id_cespite)+" "+string(ld_residuo_da_amm)


CLOSEWITHRETURN(W_CESPITE_FF, ls_param)
end event

type p_msg_log from w_p_data`p_msg_log within w_cespite_ff
end type

type p_crescente from w_p_data`p_crescente within w_cespite_ff
end type

type p_decrescente from w_p_data`p_decrescente within w_cespite_ff
end type

type cb_ok from w_p_data`cb_ok within w_cespite_ff
integer x = 32
end type

type cb_annulla from w_p_data`cb_annulla within w_cespite_ff
integer x = 329
end type

type cb_nuovo from w_p_data`cb_nuovo within w_cespite_ff
integer x = 672
end type

event cb_nuovo::clicked;

IF idw_master.uf_to_update() > 0 THEN 
	idw_master.event ue_update (0,0)
END IF

tab_1.tabpage_1.dw_cespite_ff.sharedataoff()

idw_master.Reset()
idw_master.is_list.s_modo = modo_inserisci
idw_master.triggerevent("ue_insert")
idw_master.SetFocus()
TAB_1.POST SelectTab(1)

end event

type cb_inserisci from w_p_data`cb_inserisci within w_cespite_ff
boolean visible = false
integer x = 1029
end type

type cb_cancella from w_p_data`cb_cancella within w_cespite_ff
integer x = 2482
end type

type cb_salva from w_p_data`cb_salva within w_cespite_ff
integer x = 2779
end type

type tab_1 from w_p_data`tab_1 within w_cespite_ff
integer x = 37
integer y = 148
integer width = 3008
integer height = 1456
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

event tab_1::selectionchanged;call super::selectionchanged;date ldt_data_inizio_amm, ldt_data_test

if newindex=3 then 
	cb_inserisci.visible=true
else	
	cb_inserisci.visible=false
end if	

//if newindex=2 then
//	
//	ldt_data_test=tab_1.tabpage_2.dw_cespite_2_ff.getitemdate(1,"data_inizio_amm")
//	if isnull(ldt_data_test) or ldt_data_test=today() then
//		ldt_data_inizio_amm=tab_1.tabpage_1.dw_cespite_ff.getitemdate(1, "data_inizio_utilizzo")
//		tab_1.tabpage_2.dw_cespite_2_ff.setitem(1,"data_inizio_amm",ldt_data_inizio_amm )
//	end if
//end if
end event

event tab_1::selectionchanging;call super::selectionchanging;long ll_cesp
if tab_1.tabpage_1.dw_cespite_ff.rowcount() > 0 then 
	ll_cesp = tab_1.tabpage_1.dw_cespite_ff.getitemnumber(1,"id_cespite")
else
	ll_cesp = 0
end if

IF newindex=3 THEN 
	IF TAB_1.TABPAGE_3.dw_movimenti_cespite_lt.ROWCOUNT()=0 and (ll_cesp = 0 or isnull(ll_cesp)) THEN
		messagebox('Attenzione','Prima di procedere salvare i dati inseriti')
		TAB_1.POST SelectTab(2)
	END IF
END IF	

end event

type tabpage_1 from w_p_data`tabpage_1 within tab_1
event create ( )
event destroy ( )
integer width = 2971
integer height = 1336
long backcolor = 79741120
string text = "Scheda"
long tabbackcolor = 79741120
dw_cespite_ff dw_cespite_ff
end type

on tabpage_1.create
this.dw_cespite_ff=create dw_cespite_ff
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_cespite_ff
end on

on tabpage_1.destroy
call super::destroy
destroy(this.dw_cespite_ff)
end on

type cb_ricerca from w_p_data`cb_ricerca within w_cespite_ff
integer x = 2098
integer width = 306
end type

event cb_ricerca::clicked;

uf_ricerca()
end event

type dw_cespite_ff from u_dw_master_main within tabpage_1
event ue_setta_padre ( )
integer x = 23
integer y = 20
integer width = 2912
integer height = 1300
integer taborder = 21
string dataobject = "d_cespite_ff"
end type

event itemchanged;integer li_ok, ll_anni
long ll_id_cat
string ls_dbc[], ls_dbv[], ls_dwc[], ls_old

CHOOSE CASE string(dwo.name)
	CASE "cat_int_cespite_codice"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_cat_int_cespite"
		ls_dbc[4] = "perc_ammortamento" 
		ls_dwc[1] = "cat_int_cespite_codice"
		ls_dwc[2] = "cat_int_cespite_descrizione"
		ls_dwc[3] = "id_cat_int_cespite"
		ls_dwc[4] = "amm_normale"
			
		li_ok = uf_autofind_col(string(dwo.name), "cat_int_cespite", "codice", "A", data, "", 4, ls_dbc, ls_dbv, ls_dwc)
		IF li_ok > 0 THEN
			RETURN 2
		END IF
		
		ll_id_cat=long(ls_dwc[3])
		SELECT anni_durata INTO :ll_anni 
		FROM cat_int_cespite WHERE id_cat_int_cespite=:ll_id_cat;
		tab_1.tabpage_2.dw_cespite_2_ff.setitem(1,'anni_ammortizzabili',ll_anni)
		if this.getitemstring(1,'bene_usato')='S' and isnull(this.getitemnumber(1,"amm_particolare")) then
			this.setitem(1,"amm_particolare",long(ls_dbv[4])/2)
		end if	

		
	CASE "cat_int_cespite_descrizione"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_cat_int_cespite"
		ls_dbc[4] = "perc_ammortamento" 
		ls_dwc[1] = "cat_int_cespite_codice"
		ls_dwc[2] = "cat_int_cespite_descrizione"
		ls_dwc[3] = "id_cat_int_cespite"
		ls_dwc[4] = "amm_normale"

		li_ok = uf_autofind_col(string(dwo.name), "cat_int_cespite", "descrizione", "A", data, "", 4, ls_dbc, ls_dbv, ls_dwc)
		IF li_ok > 0 THEN
			RETURN 2
		END IF

		ll_id_cat=long(ls_dwc[3])
		SELECT anni_durata INTO :ll_anni 
		FROM cat_int_cespite WHERE id_cat_int_cespite=:ll_id_cat;
		tab_1.tabpage_2.dw_cespite_2_ff.setitem(1,'anni_ammortizzabili',ll_anni)
      if this.getitemstring(1,'bene_usato')='S' and isnull(this.getitemnumber(1,"amm_particolare")) then
			this.setitem(1,"amm_particolare",long(ls_dbv[4])/2)
		end if

		
	CASE "ubic_cespite_codice"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_ubic_cespite"
		ls_dwc[1] = "ubic_cespite_codice"
		ls_dwc[2] = "ubic_cespite_descrizione"
		ls_dwc[3] = "id_ubic_cespite"

		li_ok = uf_autofind_col(string(dwo.name), "ubic_cespite", "codice", "A", data, "", 3, ls_dbc, ls_dbv, ls_dwc)
		IF li_ok > 0 THEN
			RETURN 2
		END IF
		
	CASE "ubic_cespite_descrizione"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_ubic_cespite"
		ls_dwc[1] = "ubic_cespite_codice"
		ls_dwc[2] = "ubic_cespite_descrizione"
		ls_dwc[3] = "id_ubic_cespite"

		li_ok = uf_autofind_col(string(dwo.name), "ubic_cespite", "descrizione", "A", data, "", 3, ls_dbc, ls_dbv, ls_dwc)
		IF li_ok > 0 THEN
			RETURN 2
		END IF
		
	CASE "centro_costo_codice"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_centro_costo"
		ls_dwc[1] = "centro_costo_codice"
		ls_dwc[2] = "centro_costo_descrizione"
		ls_dwc[3] = "id_centro_costo"

		li_ok = uf_autofind_col(string(dwo.name), "centro_costo", "codice", "A", data, "", 3, ls_dbc, ls_dbv, ls_dwc)
		IF li_ok > 0 THEN
			RETURN 2
		END IF
		
	CASE "centro_costo_descrizione"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_centro_costo"
		ls_dwc[1] = "centro_costo_codice"
		ls_dwc[2] = "centro_costo_descrizione"
		ls_dwc[3] = "id_centro_costo"

		li_ok = uf_autofind_col(string(dwo.name), "centro_costo", "descrizione", "A", data, "", 3, ls_dbc, ls_dbv, ls_dwc)
		IF li_ok > 0 THEN
			RETURN 2
		END IF
		
	CASE "ccod"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_cespite"
		ls_dwc[1] = "ccod"
		ls_dwc[2] = "cdes"
		ls_dwc[3] = "id_cespite"

		li_ok = uf_autofind_col(string(dwo.name), "cespite", "codice", "A", data, "", 3, ls_dbc, ls_dbv, ls_dwc)
		IF li_ok > 0 THEN
			RETURN 2
		END IF
		
	CASE "cdes"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_cespite"
		ls_dwc[1] = "ccod"
		ls_dwc[2] = "cdes"
		ls_dwc[3] = "id_cespite"

		li_ok = uf_autofind_col(string(dwo.name), "cespite", "descrizione", "A", data, "", 3, ls_dbc, ls_dbv, ls_dwc)
		IF li_ok > 0 THEN
			RETURN 2
		END IF
		
	CASE "stato"
		if data='S' then
			decimal ld_valore
			ld_valore=this.getitemnumber(1,"valore_acq")
			ld_valore=ld_valore / 2
			tab_1.tabpage_2.dw_cespite_2_ff.setitem(1,"perd_uso_promiscuo",ld_valore)
		else
			tab_1.tabpage_2.dw_cespite_2_ff.setitem(1,"perd_uso_promiscuo",0)
		end if

	CASE "bene_usato"
		if data='S' then
			decimal ld_amm1,ld_amm2
			ld_amm1=this.getitemnumber(1,"amm_normale")
			ld_amm2=this.getitemnumber(1,"amm_particolare")
			if ld_amm1>0 and isnull(ld_amm2) then 
				ld_amm1=ld_amm1 / 2
				this.setitem(1,"amm_particolare",ld_amm1)
		   end if
		end if

	CASE "tipo_ammortamento"
		if data='R' then
			ll_anni=tab_1.tabpage_2.dw_cespite_2_ff.getitemnumber(1,'anni_ammortizzati')
         if ll_anni>0 then
				ls_old=this.getitemstring(1,"tipo_ammortamento")
				messagebox('Attenzione',"L'ammortamento ridotto è possibile solo per il primo anno di utilizzo!")
				this.post setitem(1,"tipo_ammortamento",ls_old)
			end if	
		end if	
		
END CHOOSE
end event

event ue_init;call super::ue_init;is_title = "Cespiti"
is_list.s_identifica[1]="id_cespite"
iudw_children[1]=tab_1.tabpage_2.dw_cespite_2_ff
iudw_children[2]=tab_1.tabpage_3.dw_movimenti_cespite_lt
end event

event ue_set_search;call super::ue_set_search;

long ll_CurrRow, ll_id_cespite

CHOOSE CASE as_nomecol
	CASE "cat_int_cespite_codice", "cat_int_cespite_descrizione"
		is_search_window = "w_cat_int_cespite_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = as_nomecol
		is_ricpar.b_imm_retrieve  = TRUE
		
	CASE "ubic_cespite_codice"
		is_search_window = "w_ubic_cespite_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "codice"
		is_ricpar.b_imm_retrieve  = TRUE
	CASE "ubic_cespite_descrizione"
		is_search_window = "w_ubic_cespite_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "descrizione"
		is_ricpar.b_imm_retrieve  = TRUE
		
	CASE "centro_costo_codice"
		is_search_window = "w_centro_costo_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "codice"
		is_ricpar.b_imm_retrieve  = TRUE
	CASE "centro_costo_descrizione"
		is_search_window = "w_centro_costo_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "descrizione"
		is_ricpar.b_imm_retrieve  = TRUE

	CASE "ccod"
		ll_CurrRow = THIS.GetRow()
		ll_id_cespite = THIS.GetItemNumber(ll_CurrRow, "id_cespite")
		
		is_search_window = "w_cespite_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "codice"
		is_ricpar.s_SQL_cond = "cespite.id_cespite <> " + string(ll_id_cespite)
		is_ricpar.b_imm_retrieve  = TRUE
	CASE "cdes"
		ll_CurrRow = THIS.GetRow()
		ll_id_cespite = THIS.GetItemNumber(ll_CurrRow, "id_cespite")
		
		is_search_window = "w_cespite_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "descrizione"
		is_ricpar.s_SQL_cond = "cespite.id_cespite <> " + string(ll_id_cespite)
		is_ricpar.b_imm_retrieve  = TRUE
END CHOOSE

end event

event ue_use_search;CHOOSE CASE as_nomecol
	CASE "cat_int_cespite_codice", "cat_int_cespite_descrizione"
		uf_set_colval("id_cat_int_cespite", is_ricpar.s_id_seg_value[1])
		uf_set_colval("cat_int_cespite_codice", is_ricpar.s_main_value)
		uf_set_colval("cat_int_cespite_descrizione", is_ricpar.s_ausil_value[1])
		uf_set_colval("amm_normale", is_ricpar.s_ausil_value[2])

		string ls_data
		decimal ld_perc,ld_app
		integer li_anni2,li_mod,li_res,li_giorni,li_mesi
		long ll_id, ll_anni
		ll_id=long( is_ricpar.s_id_seg_value[1])
		select perc_ammortamento
		into :ld_perc
		from cat_int_cespite
		where id_cat_int_cespite=:ll_id;
		date ld_inizio,ld_fine	
		ld_inizio=tab_1.tabpage_1.dw_cespite_ff.getitemdate(1,"data_inizio_utilizzo")
				
		SELECT anni_durata INTO :ll_anni 
		FROM cat_int_cespite WHERE id_cat_int_cespite=:ll_id;
		tab_1.tabpage_2.dw_cespite_2_ff.setitem(1,'anni_ammortizzabili',ll_anni)

		if this.getitemstring(1,'bene_usato')='S' and isnull(this.getitemnumber(1,"amm_particolare")) then
			this.setitem(1,"amm_particolare",long(is_ricpar.s_ausil_value[2])/2)
		end if

		li_giorni=day(ld_inizio)
		li_mesi=month(ld_inizio)
		ls_data=string(li_giorni)+"/"+string(li_mesi)+"/"+string(ll_anni)
		ld_fine=date(ls_data)
		tab_1.tabpage_2.dw_cespite_2_ff.setitem(1,"data_fine_amm",ld_fine)
		
		
	CASE "ubic_cespite_codice", "ubic_cespite_descrizione"
		uf_set_colval("id_ubic_cespite", is_ricpar.s_id_seg_value[1])
		uf_set_colval("ubic_cespite_codice", is_ricpar.s_main_value)
		uf_set_colval("ubic_cespite_descrizione", is_ricpar.s_ausil_value[1])
	CASE "centro_costo_codice", "centro_costo_descrizione"
		uf_set_colval("id_centro_costo", is_ricpar.s_id_seg_value[1])
		uf_set_colval("centro_costo_codice", is_ricpar.s_main_value)
		uf_set_colval("centro_costo_descrizione", is_ricpar.s_ausil_value[1])
	CASE "ccod", "cdes"
		uf_set_colval("id_cespite_padre", is_ricpar.s_id_seg_value[1])
		uf_set_colval("ccod", is_ricpar.s_main_value)
		uf_set_colval("cdes", is_ricpar.s_ausil_value[1])
END CHOOSE

end event

event updatestart;long ll_ces
string ls_ces

if this.rowcount() > 0 then
	

ls_ces=this.getitemstring(1,'codice')
ll_ces=this.getitemnumber(1,'id_cespite')

if isnull(ll_ces) then
	select id_cespite into:ll_ces
	from cespite where codice=:ls_ces;

	if ll_ces>0 then
		messagebox('Attenzione','Il CODICE inserito è già stato utilizzato per unaltro Cespite!')
		RETURN 1
	end if	
end if	

end if

end event

event ue_initial;call super::ue_initial;long ll_cod
string ls_cod

SELECT prog_cespite INTO :ls_cod FROM par_sistema;

if ls_cod='S' then 
	SELECT max(cast(CODICE as integer)) INTO :ll_cod FROM cespite;
	if ll_cod<0 then 
		messagebox('Attenzione','Uno dei cespiti inseriti ha un codice errato o non numerico!')
	else
		ll_cod=ll_cod+1
		this.setitem(1,'codice',string(ll_cod))
	end if	
end if	

this.setitem(1,'id_valuta',il_euro)
this.setitem(1,'anni_ammortizzati',0)

IF UpperBound(idw_master.is_list.s_aux) = 0 THEN
	//THIs.setitem(1,'data_inizio_utilizzo',today())
	//this.setitem(1,'data_inizio_amm',today())
ELSE
	this.setitem(1,'data_inizio_utilizzo',date(idw_master.is_list.s_aux[1]))
	this.setitem(1,'data_inizio_amm',date(idw_master.is_list.s_aux[1]))	
	this.setitem(1,'valore_acq',dec(idw_master.is_list.s_aux[5]))	
END IF	
	
	
end event

event updateend;


if rowsinserted>0  and tab_1.tabpage_3.dw_movimenti_cespite_lt.rowcount()=0 then
	post wf_inserisci_acquisto()
	cb_crea_movimento.postevent(clicked!)
	
	post wf_salva()
	
	
end if
end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 2971
integer height = 1336
long backcolor = 79741120
string text = "Dettaglio"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_cespite_2_ff dw_cespite_2_ff
end type

on tabpage_2.create
this.dw_cespite_2_ff=create dw_cespite_2_ff
this.Control[]={this.dw_cespite_2_ff}
end on

on tabpage_2.destroy
destroy(this.dw_cespite_2_ff)
end on

type dw_cespite_2_ff from u_dw_master_main within tabpage_2
integer x = 14
integer y = 16
integer width = 2944
integer height = 1292
integer taborder = 3
string dataobject = "d_cespite_2_ff"
end type

event ue_init;call super::ue_init;ib_dw_shared=true



end event

event itemchanged;DECIMAL ld_tot, ld_residuo, ld_old
string ls_old

CHOOSE CASE dwo.name
		
	 CASE	"quota_amm_prev_norm", "quota_amm_prev_antic"
			ls_old=dwo.name
			ld_old=THIS.getitemdecimal(1,ls_old)
			ld_residuo=THIS.getitemdecimal(1,'residuo')		
			IF dwo.name="quota_amm_prev_norm" THEN
				ld_tot=THIS.getitemdecimal(1,'quota_amm_prev_antic')
			ELSE		
				ld_tot=THIS.getitemdecimal(1,'quota_amm_prev_norm')			
			END IF	
			IF isnull(ld_tot) THEN ld_tot=0
			ld_tot=ld_tot + DEC(data)
			IF ld_tot>ld_residuo THEN 
				messagebox('Attenzione','La somma delle QUOTE da ammortizzare~r~nnon può superare la cifra di RESIDUO!')
				this.post setitem(1,ls_old,ld_old)
			END IF
				
END CHOOSE
end event

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 2971
integer height = 1336
long backcolor = 79741120
string text = "Movimenti"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_movimenti_cespite_lt dw_movimenti_cespite_lt
end type

on tabpage_3.create
this.dw_movimenti_cespite_lt=create dw_movimenti_cespite_lt
this.Control[]={this.dw_movimenti_cespite_lt}
end on

on tabpage_3.destroy
destroy(this.dw_movimenti_cespite_lt)
end on

type dw_movimenti_cespite_lt from u_dw_master_main within tabpage_3
integer x = 5
integer y = 28
integer width = 2967
integer height = 1276
integer taborder = 3
string dataobject = "d_movimenti_cespite_lt"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event ue_init;call super::ue_init;is_list.s_identifica[1]="id_cespite"
end event

event doubleclicked;call super::doubleclicked;long ll_reg_pd
s_list_main ldw_master
if row>0 then
	ll_reg_pd=getitemnumber(row,'id_reg_pd')
   if ll_reg_pd>0 then
		ldw_master.l_identifica[1]=ll_reg_pd
		ldw_master.s_identifica[1]='id_reg_pd'
		ldw_master.s_modo=modo_modifica
		ldw_master.s_win_chiave[1]='id_reg_pd'
		ldw_master.s_provenienza='richiamo'
		openwithparm(w_reg_pd_cx,ldw_master)
	end if
end if	
	
end event

event itemchanged;integer li_ok
string ls_dbc[], ls_dbv[], ls_dwc[], ls_mastro, ls_base
long ll_data, ll_old

CHOOSE CASE string(dwo.name)
	CASE "conto_cod"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_conto"
		ls_dwc[1] = "conto_cod"
		ls_dwc[2] = "conto_des"
		ls_dwc[3] = "id_conto"

		li_ok = uf_autofind_col(string(dwo.name), "conto", "codice", "A", data, "", 3, ls_dbc, ls_dbv, ls_dwc)
		IF li_ok > 0 THEN
			RETURN 2
		END IF
		
	CASE "conto_des"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_conto"
		ls_dwc[1] = "conto_cod"
		ls_dwc[2] = "conto_des"
		ls_dwc[3] = "id_conto"

		li_ok = uf_autofind_col(string(dwo.name), "conto", "descrizione", "A", data, "", 3, ls_dbc, ls_dbv, ls_dwc)
		IF li_ok > 0 THEN
			RETURN 2
		END IF
		
	CASE "id_prof_cespite_cod" , "id_prof_cespite_des"
		ll_data=long(data)
		ll_old=this.getitemnumber(row,'id_prof_cespite_cod')
		select id_mastro, prof_base into :ls_mastro, :ls_base
		from prof_cespite where id_prof_cespite=:ll_data;
		if ls_base='N' or ls_base='A' then 
			messagebox('Attenzione','Questo profilo è utilizzabile solo nel calcolo delle quote!')
			this.post setitem(row,'id_prof_cespite_cod',ll_old)
			return 2 
		else	
			if ls_base='I' then	this.setitem(row,'test','I')	
			if isnull(this.getitemnumber(row,'id_conto')) then 
				this.setitem(row,'conto_cod',ls_mastro)
			end if	
		end if	
	
END CHOOSE
end event

event ue_set_search;call super::ue_set_search;CHOOSE CASE as_nomecol
		
	CASE "conto_cod"
		is_search_window = "w_conti_pdc_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "conto_codice"

	CASE "conto_des"
		is_search_window = "w_conti_pdc_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "conto_descrizione"

END CHOOSE

end event

event ue_use_search;CHOOSE CASE as_nomecol
	CASE "conto_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_conto", is_ricpar.s_id_seg_value[1])
		uf_set_colval("conto_des", is_ricpar.s_ausil_value[1])
	CASE "conto_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_conto", is_ricpar.s_id_seg_value[1])
		uf_set_colval("conto_cod", is_ricpar.s_ausil_value[1])
END CHOOSE

end event

event ue_initial;call super::ue_initial;LONG LL_ROW, LL_ES, LL_PROF
STRING LS_COD, LS_DES

IF UpperBound(idw_master.is_list.s_aux) > 0 AND THIS.ROWCOUNT()=1 THEN
	this.setitem(1,'data_mov_cespite',date(idw_master.is_list.s_aux[1]))
	this.setitem(1,'id_valuta',long(idw_master.is_list.s_aux[2]))
   this.setitem(1,'id_esercizio',long(idw_master.is_list.s_aux[3]))
	
	ll_row=long(idw_master.is_list.s_aux[4])
	SELECT codice, descrizione 
	INTO :ls_cod, :ls_des
	FROM conto WHERE id_conto=:ll_row;
	
   this.setitem(1,'id_conto',ll_row)
   this.setitem(1,'conto_cod',ls_cod)
	this.setitem(1,'conto_des',ls_des)
	
	this.setitem(1,'importo',dec(idw_master.is_list.s_aux[5]))
   this.setitem(1,'id_reg_pd',long(idw_master.is_list.s_aux[7]))
	this.setitem(1,'num_progressivo',long(idw_master.is_list.s_aux[8]))
	this.setitem(1,'data_registrazione',date(idw_master.is_list.s_aux[9]))
	
	ll_row=long(idw_master.is_list.s_aux[6])
	SELECT id_prof_cespite INTO :ll_prof
	FROM prof_cespite WHERE id_prof_registrazione=:ll_row;
   this.setitem(1,'id_prof_cespite_cod',ll_prof)	
   this.setitem(1,'id_prof_cespite_des',ll_prof)		
	
	this.post setitemstatus( 1, 'id_prof_cespite_des', primary!, DataModified! )
	this.post update()
ELSE
	ll_row=this.getrow()
	this.setitem(ll_row,'id_valuta',il_euro)
	this.setitem(ll_row,'data_mov_cespite',today())
	select id_esercizio into :ll_es from esercizio 
	where data_inizio<=today() and data_fine>=today();
	this.setitem(ll_row,'id_esercizio',ll_es)	
	
END IF	


	



end event

event updateend;INTEGER i
LONG    ll_row, ll_causale, ll_anni_amm, ll_cat_cespite, ll_anni, ll_anni_storico
STRING  lc_ces, lc_acq, lc_inc_anni, lc_inc_val, lc_dec_val
STRING  lc_acc_ord, lc_acc_ant, ls_base
DECIMAL ld_acq=0, ld_plus=0, ld_minus=0, ld_ces=0, ld_imp=0, ld_residuo=0
DECIMAL ld_inc_val=0, ld_dec_val=0, ld_acc_ord=0, ld_acc_ant=0
DATE    ld_data, ld_data_acq, ld_data_ces, ld_data_inc_val, ld_data_dec_val
dwItemStatus l_status
SETNULL(ld_data_acq)
SETNULL(ld_data_ces)
SETNULL(ld_data_inc_val)
SETNULL(ld_data_dec_val)

ld_ces=0
ld_acc_ord=0
ld_acc_ant=0
ld_acq=0
ld_inc_val=0
ld_dec_val=0

if rowsinserted+rowsupdated+rowsdeleted>0 then
	ll_cat_cespite=tab_1.tabpage_1.dw_cespite_ff.getitemnumber(1,'id_cat_int_cespite')
	ll_anni_amm=0
	ld_residuo=tab_1.tabpage_2.dw_cespite_2_ff.getitemdecimal(1,'residuo')
	ll_row=THIS.rowcount()
	
	FOR i=1 TO ll_row
		l_status= GetItemStatus(i, 0, primary!)
		//if l_status<>NotModified! then
			 ll_causale=THIS.getitemnumber(i,'id_prof_cespite_cod')
			 SELECT cessione, acquisto, incrementa_anni_utilizzo,
					  incrementi_valore, decrementi_valore,
					  accantonamento_ordinario, accantonamento_anticipato, prof_base
				INTO :lc_ces, :lc_acq, :lc_inc_anni, :lc_inc_val, :lc_dec_val,
					  :lc_acc_ord, :lc_acc_ant, :ls_base
				FROM prof_cespite
			  WHERE id_prof_cespite=:ll_causale;
			  
			 ld_imp=THIS.getitemdecimal(i,'importo') 
			 ld_data=THIS.getitemdate(i,'data_mov_cespite')	 
			 IF lc_acq ='S' THEN 
				 ld_acq = ld_acq + ld_imp
				 ld_data_acq=ld_data
			 END IF	 	 
			 IF lc_ces ='S' THEN 
				 ld_ces = ld_ces + ld_imp	 
				 ld_data_ces=ld_data
				 tab_1.tabpage_1.dw_cespite_ff.setitem(1,'stato','V')
				 tab_1.tabpage_1.dw_cespite_ff.setitem(1,'data_fine_amm',ld_data)
			 END IF	 
			 IF lc_inc_val	='S' THEN 
				 ld_inc_val = ld_inc_val + ld_imp	  
				 ld_data_inc_val=ld_data
			 END IF	 
			 IF lc_dec_val	='S' THEN 
				 ld_dec_val = ld_dec_val + ld_imp	 
				 ld_data_dec_val=ld_data
			 END IF	 
			 IF lc_acc_ord	='S' THEN ld_acc_ord  = ld_acc_ord + ld_imp	  
			 IF lc_acc_ant	='S' THEN ld_acc_ant  = ld_acc_ant + ld_imp	
			 IF lc_inc_anni='S' THEN 
				 IF ls_base='I' THEN 
					 ll_anni_storico=this.getitemnumber(i,'anni_amm')
					 if isnull(ll_anni_storico) then ll_anni_storico=0
					 ll_anni_amm = ll_anni_amm + ll_anni_storico
				 ELSE	
					 ll_anni_amm = ll_anni_amm + 1
				 END IF	 
			 END IF
		//end if
	NEXT
	
	tab_1.tabpage_2.dw_cespite_2_ff.setitem(1,'anni_ammortizzati',ll_anni_amm)
	tab_1.tabpage_2.dw_cespite_2_ff.setitem(1,'valore_acq',ld_acq)
	tab_1.tabpage_2.dw_cespite_2_ff.setitem(1,'rival_valore',ld_inc_val)
	tab_1.tabpage_2.dw_cespite_2_ff.setitem(1,'sval_valore',ld_dec_val)
	tab_1.tabpage_2.dw_cespite_2_ff.setitem(1,'alien_valore',ld_ces)
	tab_1.tabpage_2.dw_cespite_2_ff.setitem(1,'fondo_amm_norm',ld_acc_ord)
	tab_1.tabpage_2.dw_cespite_2_ff.setitem(1,'fondo_amm_ant',ld_acc_ant)
	tab_1.tabpage_2.dw_cespite_2_ff.setitem(1,'data_inizio_utilizzo',ld_data_acq)
	tab_1.tabpage_2.dw_cespite_2_ff.setitem(1,'alien_data',ld_data_ces)
	tab_1.tabpage_2.dw_cespite_2_ff.setitem(1,'rival_data',ld_data_inc_val)
	tab_1.tabpage_2.dw_cespite_2_ff.setitem(1,'sval_data',ld_data_dec_val)
	
	ld_residuo=tab_1.tabpage_2.dw_cespite_2_ff.getitemdecimal(1,'residuo')
	if ld_residuo<=0 and ld_ces=0 then 
		tab_1.tabpage_1.dw_cespite_ff.setitem(1,'stato','E')
		tab_1.tabpage_1.dw_cespite_ff.setitem(1,'data_fine_amm',ld_data)  
	end if 
	
	if ld_ces>0 then
		if ld_residuo<ld_ces then
			tab_1.tabpage_2.dw_cespite_2_ff.setitem(1,'plus', ld_ces - ld_residuo)
		else	
			tab_1.tabpage_2.dw_cespite_2_ff.setitem(1,'minus', ld_residuo - ld_ces)
		end if	
	end if
	
	i=tab_1.tabpage_1.dw_cespite_ff.update()
	if i=1 then 
		commit;
	else
		rollback;
		messagebox("Errore!", "Cespite non salvato")
	end if
end if
end event

type cb_crea_movimento from commandbutton within w_cespite_ff
integer x = 1371
integer y = 44
integer width = 622
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Crea Movimenti Anni Prec."
end type

event clicked;DECIMAL ld_tot,ld_val_acq,ld_perc_amm,ld_perc_rid,ld_perc_ant, ld_residuo
DECIMAL ld_rival, ld_sval, ld_tot_ant, ld_perc_cat, ld_non_amm, ld_promi
LONG ll_id_cespite, ll_righe, ll_mese, ll_es
datastore ds_calcola_cespiti
INTEGER i, li_anni_amm, ll_anni_amm
STRING ls_tipo_amm
DATE ld_data

ds_calcola_cespiti=create datastore
ds_calcola_cespiti.dataobject="d_calcolo_ammortamento_iniziale"
ds_calcola_cespiti.settransobject(sqlca)
ll_id_cespite=tab_1.tabpage_1.dw_cespite_ff.getitemnumber(1, "id_cespite")
i=ds_calcola_cespiti.retrieve(ll_id_cespite)
if i<=0 then 
	messagebox("Attenzione!", "Cespite non trovato!")
	return
end if


ld_val_acq  =ds_calcola_cespiti.getitemdecimal(i, "valore_acq")
ld_rival    =ds_calcola_cespiti.getitemdecimal(i, "rival_valore")
if isnull(ld_rival) then ld_rival = 0			
ld_sval     =ds_calcola_cespiti.getitemdecimal(i, "sval_valore")	
if isnull(ld_sval) then ld_sval = 0				
ld_non_amm  =ds_calcola_cespiti.getitemdecimal(i, "imp_non_amm")
if isnull(ld_non_amm) then ld_non_amm = 0			
ld_promi    =ds_calcola_cespiti.getitemdecimal(i, "perd_uso_promiscuo")	
if isnull(ld_promi) then ld_promi = 0		
ld_perc_amm =ds_calcola_cespiti.getitemdecimal(i, "amm_particolare")	
ld_perc_cat =ds_calcola_cespiti.getitemdecimal(i, "perc_amm_cat_int")
if isnull(ld_perc_amm) or ld_perc_amm=0 then ld_perc_amm = ld_perc_cat	
ld_perc_rid =ds_calcola_cespiti.getitemdecimal(i, "perc_primo_amm")
ld_perc_ant =ds_calcola_cespiti.getitemdecimal(i, "amm_anticipato")
ll_anni_amm =ds_calcola_cespiti.getitemdecimal(i, "anni_ammortizzati")
ld_val_acq  = ld_val_acq + ld_rival - ld_sval - ld_promi - ld_non_amm
ls_tipo_amm=ds_calcola_cespiti.getitemstring(i, "tipo_ammortamento")

IF ld_val_acq<=516 THEN 
	ld_tot=ld_val_acq
	ld_tot_ant=0
	ld_residuo=ds_calcola_cespiti.getitemdecimal(i, "residuo")			
	IF ld_tot>=ld_residuo THEN ld_tot=ld_residuo
ELSE
	IF ll_anni_amm=0 THEN
		ld_tot_ant=0
		ld_tot=(((ld_val_acq*ld_perc_cat)/100)*ld_perc_rid)/100
		
		IF ls_tipo_amm='R' THEN	ld_tot=(ld_tot*ld_perc_rid)/100
		IF ls_tipo_amm='A' THEN ld_tot_ant=(ld_tot*ld_perc_ant)/100		
		
		
	ELSE	
		ld_tot_ant=0
		ld_tot=(ld_val_acq*ld_perc_amm)/100
		IF ls_tipo_amm='R' THEN	ld_tot=(ld_tot*ld_perc_rid)/100
		IF ls_tipo_amm='A' THEN ld_tot_ant=(ld_tot*ld_perc_ant)/100		

		ld_residuo=ds_calcola_cespiti.getitemdecimal(i, "residuo")	

		IF ld_tot>=ld_residuo THEN
			ld_tot=ld_residuo
			ld_tot_ant=0
		ELSEIF (ld_tot + ld_tot_ant)>ld_residuo THEN
			ld_tot_ant=ld_residuo - ld_tot
		END IF
	END IF	
END IF
	
li_anni_amm=tab_1.tabpage_1.dw_cespite_ff.getitemnumber(1, "anni_ammortizzati")
wf_crea_movimento(ll_id_cespite, ld_tot, ld_tot_ant, li_anni_amm)

DESTROY ds_calcola_cespiti

end event

