forward
global type w_scadenza_cx from w_p_data
end type
type dw_scadenza_gen_ff from u_dw_master_main within tabpage_1
end type
type tabpage_2 from userobject within tab_1
end type
type dw_scadenza_cess_ff from u_dw_master_main within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_scadenza_cess_ff dw_scadenza_cess_ff
end type
type tabpage_3 from userobject within tab_1
end type
type cb_origine from commandbutton within tabpage_3
end type
type dw_scadenza_rif_ff from u_dw_master_main within tabpage_3
end type
type cb_documento from commandbutton within tabpage_3
end type
type cb_partita from commandbutton within tabpage_3
end type
type tabpage_3 from userobject within tab_1
cb_origine cb_origine
dw_scadenza_rif_ff dw_scadenza_rif_ff
cb_documento cb_documento
cb_partita cb_partita
end type
type tabpage_4 from userobject within tab_1
end type
type dw_scadenza_mov_scadenza_gd from u_dw_master_main within tabpage_4
end type
type tabpage_4 from userobject within tab_1
dw_scadenza_mov_scadenza_gd dw_scadenza_mov_scadenza_gd
end type
type cb_dividi from commandbutton within w_scadenza_cx
end type
end forward

global type w_scadenza_cx from w_p_data
integer width = 2994
integer height = 1736
string title = "Scadenze"
cb_dividi cb_dividi
end type
global w_scadenza_cx w_scadenza_cx

type variables
long il_id_tipo_pagamento_new 
long il_id_tipo_pagamento
end variables

forward prototypes
public subroutine uf_set_title ()
public subroutine uf_ricerca ()
public subroutine uf_ricerca_par_documento ()
public subroutine uf_visualizza_par_documento (long al_id_documento, long al_id_par_aperta)
public subroutine uf_recurse_scadenza (long al_id_scadenza_padre, ref long al_id_documento, ref long al_id_par_aperta)
public subroutine uf_ricerca_partita ()
public subroutine uf_ricerca_documento ()
end prototypes

public subroutine uf_set_title ();

long ll_Row, ll_id_sog_commerciale
string ls_codice, ls_rag_soc_1

ll_Row = tab_1.tabpage_1.dw_scadenza_gen_ff.GetRow()

IF ll_Row > 0 THEN
	ll_id_sog_commerciale = tab_1.tabpage_1.dw_scadenza_gen_ff.GetItemNumber(ll_Row, "id_sog_commerciale")
	IF ll_id_sog_commerciale > 0 THEN
		SELECT sog_commerciale.codice,
				 anagrafica.rag_soc_1
			INTO :ls_codice, 
			     :ls_rag_soc_1
			FROM dba.sog_commerciale,
				  dba.anagrafica
			WHERE (sog_commerciale.id_anagrafica = anagrafica.id_anagrafica) AND
					(sog_commerciale.id_sog_commerciale = :ll_id_sog_commerciale)
			USING SQLCA;
		
		CHOOSE CASE SQLCA.SQLCode
			CASE 0
				THIS.Title = THIS.Title + " - " + ls_codice + " " + ls_rag_soc_1
			CASE -1
				MessageBox("Errore sul DataBase", "w_scadenze_cx / uf_set_title / 1")
		END CHOOSE
		
	END IF

END IF
end subroutine

public subroutine uf_ricerca ();

w_search_main lw_sm
long ll_id_scadenza, ll_row

ll_id_scadenza = long(tab_1.tabpage_3.dw_scadenza_rif_ff.uf_get_colval("id_scadenza"))

idw_master.is_ricpar.s_filter_value = tab_1.tabpage_3.dw_scadenza_rif_ff.uf_get_colval("id_sog_commerciale")
idw_master.is_ricpar.s_filter_name = "id_sog_commerciale"
idw_master.is_ricpar.s_SQL_cond = "scadenza.id_scadenza <> " + string(ll_id_scadenza) + " AND scadenza.id_scadenza_padre is Null"
OpenWithParm(lw_sm, idw_master.is_ricpar, "w_scad_origine_sw")
idw_master.is_ricpar = Message.PowerObjectParm

IF UpperBound(idw_master.is_ricpar.s_id_seg_value) > 0 THEN
	tab_1.tabpage_3.dw_scadenza_rif_ff.uf_set_colval("id_scadenza_padre", idw_master.is_ricpar.s_id_seg_value[1])
	tab_1.tabpage_3.dw_scadenza_rif_ff.uf_set_colval("scadenza_data_scadenza", idw_master.is_ricpar.s_ausil_value[1])
	tab_1.tabpage_3.dw_scadenza_rif_ff.uf_set_colval("scadenza_stato_scadenza", idw_master.is_ricpar.s_ausil_value[2])
	tab_1.tabpage_3.dw_scadenza_rif_ff.uf_set_colval("scadenza_scadenza_da_raggruppare", idw_master.is_ricpar.s_ausil_value[3])
	tab_1.tabpage_3.dw_scadenza_rif_ff.uf_set_colval("scadenza_id_tipo_pagamento_des", idw_master.is_ricpar.s_ausil_value[4])
	tab_1.tabpage_3.dw_scadenza_rif_ff.uf_set_colval("scadenza_id_valuta_des", idw_master.is_ricpar.s_ausil_value[5])
	tab_1.tabpage_3.dw_scadenza_rif_ff.uf_set_colval("scadenza_imp_valuta", idw_master.is_ricpar.s_ausil_value[6])
	tab_1.tabpage_3.dw_scadenza_rif_ff.uf_set_colval("scadenza_cambio", idw_master.is_ricpar.s_ausil_value[7])
	tab_1.tabpage_3.dw_scadenza_rif_ff.uf_set_colval("scadenza_importo", idw_master.is_ricpar.s_ausil_value[8])
END IF
end subroutine

public subroutine uf_ricerca_par_documento ();

long ll_row, ll_id_scadenza_padre, ll_id_documento, ll_id_par_aperta

ll_row = tab_1.tabpage_3.dw_scadenza_rif_ff.GetRow()

IF ll_row > 0 THEN
	ll_id_scadenza_padre = tab_1.tabpage_3.dw_scadenza_rif_ff.GetItemNumber(ll_row, "id_scadenza_padre")

	IF IsNull(ll_id_scadenza_padre) THEN
		ll_id_documento      = tab_1.tabpage_3.dw_scadenza_rif_ff.GetItemNumber(ll_row, "id_documento")
		ll_id_par_aperta     = tab_1.tabpage_3.dw_scadenza_rif_ff.GetItemNumber(ll_row, "id_par_aperta")
		uf_visualizza_par_documento(ll_id_documento, ll_id_par_aperta)
	ELSE
		
		uf_recurse_scadenza(ll_id_scadenza_padre, ll_id_documento, ll_id_par_aperta)
		
		uf_visualizza_par_documento(ll_id_documento, ll_id_par_aperta)
	END IF
END IF
end subroutine

public subroutine uf_visualizza_par_documento (long al_id_documento, long al_id_par_aperta);

long ll_numero, ll_num_progressivo, ll_num_documento, ll_num_partita
string ls_descrizione, ls_tipo_registro
date ld_data_registrazione, ld_data_documento, ld_data_competenza, ld_data_partita

IF NOT IsNull(al_id_documento) THEN
	
	SetNull(ll_numero)
	SetNull(ls_descrizione)
	SetNull(ls_tipo_registro)
	SetNull(ll_num_progressivo)
	SetNull(ld_data_registrazione)
	SetNull(ll_num_documento)
	SetNull(ld_data_documento)
	SetNull(ld_data_competenza)
	
	SELECT registro.numero,   
			 registro.descrizione,   
			 registro.tipo_registro,   
			 documento.num_progressivo,   
			 documento.data_registrazione,   
			 documento.num_documento,   
			 documento.data_documento,   
			 documento.data_competenza  
		INTO :ll_numero,
			  :ls_descrizione,
			  :ls_tipo_registro,
			  :ll_num_progressivo,
			  :ld_data_registrazione,
			  :ll_num_documento,
			  :ld_data_documento,
			  :ld_data_competenza
		FROM dba.documento,   
			  dba.registro  
		WHERE (registro.id_registro = documento.id_registro) and  
		      (documento.id_documento = :al_id_documento);

	CHOOSE CASE SQLCA.SQLCode
		CASE 0
			tab_1.tabpage_3.dw_scadenza_rif_ff.uf_set_colval("c_registro_numero", string(ll_numero))
			tab_1.tabpage_3.dw_scadenza_rif_ff.uf_set_colval("c_registro_descrizione", ls_descrizione)
			tab_1.tabpage_3.dw_scadenza_rif_ff.uf_set_colval("c_tipo_registro", ls_tipo_registro)
			tab_1.tabpage_3.dw_scadenza_rif_ff.uf_set_colval("c_documento_num_progressivo", string(ll_num_progressivo))
			tab_1.tabpage_3.dw_scadenza_rif_ff.uf_set_colval("c_documento_data_registrazion", string(ld_data_registrazione))
			tab_1.tabpage_3.dw_scadenza_rif_ff.uf_set_colval("c_documento_num_documento", string(ll_num_documento))
			tab_1.tabpage_3.dw_scadenza_rif_ff.uf_set_colval("c_documento_data_documento", string(ld_data_documento))
			tab_1.tabpage_3.dw_scadenza_rif_ff.uf_set_colval("c_documento_data_competenza", string(ld_data_competenza))
	END CHOOSE
ELSE
	tab_1.tabpage_3.dw_scadenza_rif_ff.uf_set_colval("c_registro_numero", "")
	tab_1.tabpage_3.dw_scadenza_rif_ff.uf_set_colval("c_registro_descrizione", "")
	tab_1.tabpage_3.dw_scadenza_rif_ff.uf_set_colval("c_tipo_registro", "")
	tab_1.tabpage_3.dw_scadenza_rif_ff.uf_set_colval("c_documento_num_progressivo", "")
	tab_1.tabpage_3.dw_scadenza_rif_ff.uf_set_colval("c_documento_data_registrazion", "")
	tab_1.tabpage_3.dw_scadenza_rif_ff.uf_set_colval("c_documento_num_documento", "")
	tab_1.tabpage_3.dw_scadenza_rif_ff.uf_set_colval("c_documento_data_documento", "")
	tab_1.tabpage_3.dw_scadenza_rif_ff.uf_set_colval("c_documento_data_competenza", "")
END IF

IF NOT IsNull(al_id_par_aperta) THEN
	SELECT registro.numero,   
			 registro.descrizione,   
			 registro.tipo_registro,   
			 par_aperta.num_partita,   
			 par_aperta.data_partita  
		INTO :ll_numero,
			  :ls_descrizione,
			  :ls_tipo_registro,
			  :ll_num_partita,
			  :ld_data_partita
		FROM dba.par_aperta,   
			  dba.reg_pd,   
			  dba.registro  
		WHERE (reg_pd.id_reg_pd = par_aperta.id_reg_pd) and  
				(registro.id_registro = reg_pd.id_registro) and  
				(par_aperta.id_par_aperta = :al_id_par_aperta);

	CHOOSE CASE SQLCA.SQLCode
		CASE 0
			tab_1.tabpage_3.dw_scadenza_rif_ff.uf_set_colval("c_par_registro_numero", string(ll_numero))
			tab_1.tabpage_3.dw_scadenza_rif_ff.uf_set_colval("c_par_registro_descrizione", ls_descrizione)
			tab_1.tabpage_3.dw_scadenza_rif_ff.uf_set_colval("c_par_registro_tipo_registro", ls_tipo_registro)
			tab_1.tabpage_3.dw_scadenza_rif_ff.uf_set_colval("c_par_aperta_num_partita", string(ll_num_partita))
			tab_1.tabpage_3.dw_scadenza_rif_ff.uf_set_colval("c_par_aperta_data_partita", string(ld_data_partita))
	END CHOOSE
ELSE
	tab_1.tabpage_3.dw_scadenza_rif_ff.uf_set_colval("c_par_registro_numero", "")
	tab_1.tabpage_3.dw_scadenza_rif_ff.uf_set_colval("c_par_registro_descrizione", "")
	tab_1.tabpage_3.dw_scadenza_rif_ff.uf_set_colval("c_par_registro_tipo_registro", "")
	tab_1.tabpage_3.dw_scadenza_rif_ff.uf_set_colval("c_par_aperta_num_partita", "")
	tab_1.tabpage_3.dw_scadenza_rif_ff.uf_set_colval("c_par_aperta_data_partita", "")
END IF
end subroutine

public subroutine uf_recurse_scadenza (long al_id_scadenza_padre, ref long al_id_documento, ref long al_id_par_aperta);

long ll_id_scadenza_padre

IF NOT IsNull(al_id_scadenza_padre) THEN
	SELECT scadenza.id_scadenza_padre,
			 scadenza.id_documento,
			 scadenza.id_par_aperta
		INTO :ll_id_scadenza_padre, 
			  :al_id_documento, 
			  :al_id_par_aperta
		FROM dba.scadenza
		WHERE scadenza.id_scadenza = :al_id_scadenza_padre;
	
	CHOOSE CASE SQLCA.SQLCode
		CASE 0
			IF NOT IsNull(al_id_scadenza_padre) THEN
				uf_recurse_scadenza(ll_id_scadenza_padre, al_id_documento, al_id_par_aperta)
			ELSE
				RETURN
			END IF
	END CHOOSE

END IF
end subroutine

public subroutine uf_ricerca_partita ();

w_search_main lw_sm
long ll_id_par_aperta, ll_row, ll_id_sog_commerciale, ll_id_conto


idw_master.is_ricpar.s_filter_value = tab_1.tabpage_3.dw_scadenza_rif_ff.uf_get_colval("c_par_aperta_num_partita")
idw_master.is_ricpar.s_filter_name = "cnumero"

ll_row = tab_1.tabpage_3.dw_scadenza_rif_ff.GetRow()
ll_id_sog_commerciale = tab_1.tabpage_3.dw_scadenza_rif_ff.GetItemNumber(ll_row, "id_sog_commerciale")

SetNull(ll_id_conto)
SELECT sog_commerciale.id_conto
	INTO :ll_id_conto
	FROM dba.sog_commerciale
	WHERE sog_commerciale.id_sog_commerciale = :ll_id_sog_commerciale
	USING SQLCA;
IF NOT IsNull(ll_id_conto) THEN
	idw_master.is_ricpar.s_SQL_cond = "par_aperta.id_conto = " + string(ll_id_conto)
END IF

OpenWithParm(lw_sm, idw_master.is_ricpar, "w_par_aperta_sw")
idw_master.is_ricpar = Message.PowerObjectParm

IF UpperBound(idw_master.is_ricpar.s_id_seg_value) > 0 THEN
	tab_1.tabpage_3.dw_scadenza_rif_ff.uf_set_colval("id_par_aperta", idw_master.is_ricpar.s_id_seg_value[1])
	tab_1.tabpage_3.dw_scadenza_rif_ff.uf_set_colval("c_par_registro_numero", idw_master.is_ricpar.s_ausil_value[1])
	tab_1.tabpage_3.dw_scadenza_rif_ff.uf_set_colval("c_par_registro_descrizione", idw_master.is_ricpar.s_ausil_value[2])
	tab_1.tabpage_3.dw_scadenza_rif_ff.uf_set_colval("c_par_registro_tipo_registro", idw_master.is_ricpar.s_ausil_value[3])
	tab_1.tabpage_3.dw_scadenza_rif_ff.uf_set_colval("c_par_aperta_num_partita", idw_master.is_ricpar.s_ausil_value[4])
	tab_1.tabpage_3.dw_scadenza_rif_ff.uf_set_colval("c_par_aperta_data_partita", idw_master.is_ricpar.s_ausil_value[5])
END IF
end subroutine

public subroutine uf_ricerca_documento ();

w_search_main lw_sm
long ll_id_documento, ll_row


idw_master.is_ricpar.s_filter_value = tab_1.tabpage_3.dw_scadenza_rif_ff.uf_get_colval("c_documento_num_progressivo")
idw_master.is_ricpar.s_filter_name = "documento_num_progressivo"

OpenWithParm(lw_sm, idw_master.is_ricpar, "w_documento_sw")
idw_master.is_ricpar = Message.PowerObjectParm

IF UpperBound(idw_master.is_ricpar.s_id_seg_value) > 0 THEN
	tab_1.tabpage_3.dw_scadenza_rif_ff.uf_set_colval("id_documento", idw_master.is_ricpar.s_id_seg_value[1])
	tab_1.tabpage_3.dw_scadenza_rif_ff.uf_set_colval("c_registro_numero", idw_master.is_ricpar.s_ausil_value[2])
	tab_1.tabpage_3.dw_scadenza_rif_ff.uf_set_colval("c_registro_descrizione", idw_master.is_ricpar.s_ausil_value[3])
	tab_1.tabpage_3.dw_scadenza_rif_ff.uf_set_colval("c_registro_tipo_registro", idw_master.is_ricpar.s_ausil_value[1])
	tab_1.tabpage_3.dw_scadenza_rif_ff.uf_set_colval("c_documento_num_progressivo", idw_master.is_ricpar.s_ausil_value[4])
	tab_1.tabpage_3.dw_scadenza_rif_ff.uf_set_colval("c_documento_data_registrazion", idw_master.is_ricpar.s_ausil_value[5])
	tab_1.tabpage_3.dw_scadenza_rif_ff.uf_set_colval("c_documento_num_documento", idw_master.is_ricpar.s_ausil_value[6])
	tab_1.tabpage_3.dw_scadenza_rif_ff.uf_set_colval("c_documento_data_documento", idw_master.is_ricpar.s_ausil_value[7])
	tab_1.tabpage_3.dw_scadenza_rif_ff.uf_set_colval("c_documento_data_competenza", idw_master.is_ricpar.s_ausil_value[8])
END IF
end subroutine

event open;call super::open;long ll_id_doc
datastore ds_insoluto

idw_master = tab_1.tabpage_1.dw_scadenza_gen_ff

//ds_insoluto=Message.PowerObjectParm

idw_master.is_list = Message.PowerObjectParm

idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_sql_ident[1] = "scadenza.id_scadenza"

Post Function uf_set_title()

//if message.doubleparm=1 then
//	//ll_id_doc=message.doubleparm
////	ll_id_doc=w_insoluti_fab_cx.dw_3.getitemnumber(1, "id_documento")
//	messagebox("W", ll_id_doc)
//	tab_1.tabpage_1.dw_scadenza_gen_ff.insertrow(1)
//end if
end event

on w_scadenza_cx.create
int iCurrent
call super::create
this.cb_dividi=create cb_dividi
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_dividi
end on

on w_scadenza_cx.destroy
call super::destroy
destroy(this.cb_dividi)
end on

event ue_master_delete;
long ll_scaduto, ll_ret
ll_scaduto=tab_1.tabpage_1.dw_scadenza_gen_ff.getitemnumber(tab_1.tabpage_1.dw_scadenza_gen_ff.getrow(),'id_scadenza')

if messagebox('Attenzione',"Sei sicuro di voler eliminare la scadenza selezionata?",Information!,yesno!)=1 then
	delete from scadenza where id_scadenza=:ll_scaduto;
	if sqlca.sqlcode<0 then 
		messagebox('Attenzione',"L'eliminazione della scadenza è fallita")
	else
		tab_1.tabpage_1.dw_scadenza_gen_ff.reset()
		tab_1.tabpage_2.dw_scadenza_cess_ff.reset()
		tab_1.tabpage_4.dw_scadenza_mov_scadenza_gd.reset()
		tab_1.tabpage_3.dw_scadenza_rif_ff.reset()
	end if	
end if
end event

type p_msg_log from w_p_data`p_msg_log within w_scadenza_cx
end type

type p_crescente from w_p_data`p_crescente within w_scadenza_cx
end type

type p_decrescente from w_p_data`p_decrescente within w_scadenza_cx
end type

type cb_ok from w_p_data`cb_ok within w_scadenza_cx
end type

type cb_annulla from w_p_data`cb_annulla within w_scadenza_cx
end type

type cb_nuovo from w_p_data`cb_nuovo within w_scadenza_cx
end type

type cb_inserisci from w_p_data`cb_inserisci within w_scadenza_cx
integer x = 2080
end type

type cb_cancella from w_p_data`cb_cancella within w_scadenza_cx
integer x = 2377
end type

event cb_cancella::clicked;call super::clicked
end event

type cb_salva from w_p_data`cb_salva within w_scadenza_cx
integer x = 2674
end type

type tab_1 from w_p_data`tab_1 within w_scadenza_cx
integer x = 50
integer y = 156
integer width = 2880
integer height = 1460
long backcolor = 79741120
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
end type

on tab_1.create
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_2
this.Control[iCurrent+2]=this.tabpage_3
this.Control[iCurrent+3]=this.tabpage_4
end on

on tab_1.destroy
call super::destroy
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
end on

type tabpage_1 from w_p_data`tabpage_1 within tab_1
integer width = 2843
integer height = 1340
long backcolor = 79741120
string text = "Generale"
long tabbackcolor = 79741120
dw_scadenza_gen_ff dw_scadenza_gen_ff
end type

on tabpage_1.create
this.dw_scadenza_gen_ff=create dw_scadenza_gen_ff
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_scadenza_gen_ff
end on

on tabpage_1.destroy
call super::destroy
destroy(this.dw_scadenza_gen_ff)
end on

type cb_ricerca from w_p_data`cb_ricerca within w_scadenza_cx
integer x = 1691
integer width = 306
end type

type dw_scadenza_gen_ff from u_dw_master_main within tabpage_1
event ue_calcola_imp ( )
event ue_assegna_camb ( )
event ue_data_scadenza ( )
event ue_tipo_scadenza ( )
event ue_tipo_pagamento ( )
event ue_banche ( )
event ue_cambio_stato ( )
event ue_valuta ( )
integer x = 27
integer y = 36
integer width = 2798
integer height = 1252
integer taborder = 1
string dataobject = "d_scadenza_gen_ff"
end type

event ue_calcola_imp;call super::ue_calcola_imp;

long 		ll_CurrRow
decimal 	ldc_cambio, ldc_imp_valuta

ll_CurrRow = THIS.GetRow()

ldc_cambio = THIS.uf_GetItemDecimal(ll_CurrRow, "cambio")
ldc_imp_valuta = THIS.uf_GetItemDecimal(ll_CurrRow, "imp_valuta")
THIS.SetItem(ll_CurrRow, "importo", ldc_imp_valuta * ldc_cambio)
end event

event ue_assegna_camb;call super::ue_assegna_camb;

long 		ll_CurrRow, ll_id_valuta
decimal 	ldc_cambio

ll_CurrRow = THIS.GetRow()

ll_id_valuta = long(This.GetItemNumber(ll_CurrRow,"id_valuta"))
IF ll_id_valuta > 0 THEN
	SELECT "valuta"."cambio"  
		INTO :ldc_cambio  
		FROM "valuta"  
		WHERE "valuta"."id_valuta" = :ll_id_valuta   ;

	THIS.SetItem(ll_CurrRow, "cambio", ldc_cambio)
END IF

end event

event ue_data_scadenza;call super::ue_data_scadenza;

long 		ll_CurrRow, ll_id_sog_commerciale, ll_id_anagrafica
date		ldate_target, ldate_iniz, ldate_fine, ldate_sost
long		ll_gg_iniz, ll_mm_iniz, ll_gg_fine, ll_mm_fine, ll_gg_sost, ll_mm_sost
long		ll_year
string	ls_slash

ll_CurrRow = THIS.GetRow()

ls_slash = "/"
ll_id_sog_commerciale = long(This.GetItemNumber(ll_CurrRow,"id_sog_commerciale"))
ldate_target = This.GetItemDate(ll_CurrRow, "data_scadenza")
ll_year = Year(ldate_target)
IF IsNull(ldate_target) THEN
	RETURN
END IF
DECLARE Cur_con_spec_scadenza CURSOR FOR
SELECT "con_spec_scadenza"."giorno_inizio_periodo",
		 "con_spec_scadenza"."mese_inizio_periodo",
		 "con_spec_scadenza"."giorno_fine_periodo",
		 "con_spec_scadenza"."mese_fine_periodo",
		 "con_spec_scadenza"."giorno_applicazione",
		 "con_spec_scadenza"."mese_applicazione"
FROM	 "dba"."con_spec_scadenza", "dba"."sog_commerciale"
WHERE	 "con_spec_scadenza"."id_anagrafica" = &
		 (SELECT "anagrafica"."id_anagrafica" FROM "anagrafica" 
		  WHERE  "anagrafica"."id_anagrafica" = & 
		 (SELECT "sog_commerciale"."id_anagrafica" FROM "sog_commerciale" 
		  WHERE  "sog_commerciale"."id_sog_commerciale" = :ll_id_sog_commerciale));
		  
OPEN Cur_con_spec_scadenza;
IF SQLCA.SQLCode <> 0 THEN	
	MessageBox("CON_SPEC_SCADENZA", String(SQLCA.SQLCode) + SQLCA.SQLErrText)
	RETURN
END IF
FETCH NEXT Cur_con_spec_scadenza
	INTO	 :ll_gg_iniz, :ll_mm_iniz, :ll_gg_fine, :ll_mm_fine, :ll_gg_sost, :ll_mm_sost;
DO WHILE (SQLCA.SQLCode = 0)
	ldate_iniz = Date(String(ll_gg_iniz) + ls_slash + String(ll_mm_iniz) + ls_slash + String(ll_year))
	ldate_fine = Date(String(ll_gg_fine) + ls_slash + String(ll_mm_fine) + ls_slash + String(ll_year))
	ldate_sost = Date(String(ll_gg_sost) + ls_slash + String(ll_mm_sost) + ls_slash + String(ll_year))
	
	IF (DaysAfter(ldate_iniz, ldate_fine) < 0)  THEN
		ldate_fine = Date(String(ll_gg_fine) + ls_slash + String(ll_mm_fine) + ls_slash + String(ll_year + 1))
		ldate_sost = Date(String(ll_gg_sost) + ls_slash + String(ll_mm_sost) + ls_slash + String(ll_year + 1))
	END IF
	
	IF (((DaysAfter(ldate_iniz, ldate_target) > 0) AND (DaysAfter(ldate_fine, ldate_target) < 0))) THEN
		This.SetItem(ll_CurrRow, "data_scadenza", ldate_sost)
	END IF	
	FETCH NEXT Cur_con_spec_scadenza
	INTO	 :ll_gg_iniz, :ll_mm_iniz, :ll_gg_fine, :ll_mm_fine, :ll_gg_sost, :ll_mm_sost;
LOOP	
CLOSE Cur_con_spec_scadenza;	


end event

event ue_tipo_scadenza;



end event

event ue_tipo_pagamento;call super::ue_tipo_pagamento;

long 		ll_CurrRow, ll_id_tipo_pagamento, ll_id_tipo_pagamento_new
string	ls_ges_cessioni, ls_ges_cessioni_new, ls_ws
string	ls_MB1, ls_MB2, ls_MB2A, ls_MB2B, ls_MB2C, ls_MB2D, ls_MB2E, ls_NewLine
date		ldate_ws
integer	li_MB

ll_CurrRow = THIS.GetRow()
SetNull(ls_ws)
SetNull(ldate_ws)
ls_NewLine = "~n"
ls_MB1 = "GESTIONE TIPO PAGAMENTO"
ls_MB2A = "A T T E N Z I O N E !" + ls_NewLine
ls_MB2B = "Il Nuovo Tipo Pagamento" + ls_NewLine
ls_MB2C = "Non Gestisce le Cessioni" + ls_NewLine
ls_MB2D = "Dunque la Pagina Cessioni verra'azzerata" + ls_NewLine
ls_MB2E = "Confermi la Modifica del Pagamento?" + ls_NewLine
ls_MB2 = ls_MB2A + ls_MB2B + ls_MB2C + ls_MB2D + ls_MB2E
ll_id_tipo_pagamento = il_id_tipo_pagamento
ll_id_tipo_pagamento_new = il_id_tipo_pagamento_new
SELECT "tipo_pagamento"."ges_cessioni" INTO :ls_ges_cessioni
FROM	 "tipo_pagamento"
WHERE  "tipo_pagamento"."id_tipo_pagamento" = :ll_id_tipo_pagamento;
IF SQLCA.SQLCode < 0 THEN	
	MessageBox("Ue_Tipo_Pagamento DB Error", String(SQLCA.SQLCode) + SQLCA.SQLErrText)
	RETURN
END IF
SELECT "tipo_pagamento"."ges_cessioni" INTO :ls_ges_cessioni_new
FROM	 "tipo_pagamento"
WHERE  "tipo_pagamento"."id_tipo_pagamento" = :ll_id_tipo_pagamento_new;
IF SQLCA.SQLCode < 0 THEN	
	MessageBox("Ue_Tipo_Pagamento DB Error", String(SQLCA.SQLCode) + SQLCA.SQLErrText)
	RETURN
END IF
CHOOSE CASE ls_ges_cessioni
	CASE "N"
		CHOOSE CASE ls_ges_cessioni_new
			CASE "N"
				THIS.SetItem(ll_CurrRow, "id_tipo_pagamento", ll_id_tipo_pagamento_new)
				tab_1.tabpage_2.Visible = FALSE
				RETURN
			CASE "S"
				THIS.SetItem(ll_CurrRow, "id_tipo_pagamento", ll_id_tipo_pagamento_new)
				tab_1.tabpage_2.Visible = TRUE
				RETURN
		END CHOOSE		
	CASE "S"
		CHOOSE CASE ls_ges_cessioni_new
			CASE "N"
				li_MB = MessageBox ( ls_MB1, ls_MB2 , Question! , YesNoCancel! , 3)
				IF (li_MB = 1) THEN
					THIS.SetItem(ll_CurrRow, "id_tipo_pagamento", ll_id_tipo_pagamento_new)
					This.SetItem(ll_CurrRow, "ces_denominazione", ls_ws)
					This.SetItem(ll_CurrRow, "ces_indirizzo", ls_ws)
					This.SetItem(ll_CurrRow, "ces_cap", ls_ws)
					This.SetItem(ll_CurrRow, "ces_localita", ls_ws)
					This.SetItem(ll_CurrRow, "ces_provincia", ls_ws)
					This.SetItem(ll_CurrRow, "ces_doc_originale", ls_ws)
					This.SetItem(ll_CurrRow, "ces_data_documento", ldate_ws)
					tab_1.tabpage_2.Visible = FALSE
				ELSE
					THIS.SetItem(ll_CurrRow, "id_tipo_pagamento", ll_id_tipo_pagamento)	
				END IF	
		END CHOOSE
END CHOOSE 		

end event

event ue_banche;call super::ue_banche;
DataWindowChild 	ldw_banca_azi
DataWindowChild 	ldw_banca_sog_comm
String				ls_col_child, ls_filter_azi, ls_filter_sogcomm
Long					ll_anagrafica, ll_id_sog_comm, ll_id_azienda
Long					ll_Row

ll_Row = THIS.GetRow()
ll_id_azienda = Long(This.GetItemNumber(ll_Row,"id_azienda"))
ll_id_sog_comm = Long(This.GetItemNumber(ll_Row,"id_sog_commerciale"))
SELECT "sog_commerciale"."id_anagrafica" INTO :ll_anagrafica
FROM	 "sog_commerciale"
WHERE  "sog_commerciale"."id_sog_commerciale" = :ll_id_sog_comm;
IF SQLCA.SQLCode <> 0 THEN	
	 ll_anagrafica = 0
END IF
ls_col_child = "id_banca_azienda"
THIS.GetChild ( ls_col_child, ldw_banca_azi)
ls_col_child = "id_banca_sog_commerciale"
THIS.GetChild ( ls_col_child, ldw_banca_sog_comm)
ls_filter_azi = "banca_azienda_id_azienda = " + String(ll_id_azienda)
ldw_banca_azi.SetFilter(ls_filter_azi)
ldw_banca_azi.Filter( )
ls_filter_sogcomm = "banca_sog_commerciale_id_azienda = " + String(ll_id_azienda) 
ls_filter_sogcomm = ls_filter_sogcomm + " AND banca_sog_commerciale_id_anagrafica = " + String(ll_anagrafica)
ls_filter_sogcomm = ls_filter_sogcomm + " AND banca_sog_commerciale_modo_uso = '" + "S'"
ldw_banca_sog_comm.SetFilter(ls_filter_sogcomm)
ldw_banca_sog_comm.Filter( )


end event

event ue_cambio_stato;call super::ue_cambio_stato;

f_displayonly(dw_scadenza_gen_ff, "data_cambiamento_stato", TRUE)



end event

event ue_valuta;

long 				ll_CurrRow, ll_id_sog_commerciale
long				ll_id_valuta
dwItemStatus 	l_status

l_status = 	THIS.GetItemStatus(ll_CurrRow, "id_valuta", Primary!)
IF ((l_status = New!) OR (l_status = NewModified!)) THEN
	ll_id_valuta = 0
	ll_CurrRow = THIS.GetRow()
	ll_id_sog_commerciale = long(This.GetItemNumber(ll_CurrRow,"id_sog_commerciale"))
	
	SELECT "anagrafica"."id_valuta" INTO :ll_id_valuta
	FROM	 "anagrafica"
	WHERE  "anagrafica"."id_anagrafica" = &
			 (SELECT "sog_commerciale"."id_anagrafica" 
			  FROM	 "sog_commerciale"
			  WHERE  "sog_commerciale"."id_sog_commerciale" = :ll_id_sog_commerciale);
	IF SQLCA.SQLCode <> 0 THEN	
		MessageBox("Ue_Valuta DB Error", String(SQLCA.SQLCode) + SQLCA.SQLErrText)
		RETURN
	END IF
	This.SetItem(ll_CurrRow, "id_valuta", ll_id_valuta)
	PostEvent("ue_assegna_camb")
	
END IF




end event

event ue_init;call super::ue_init;is_title = "Scadenze"
is_list.s_identifica[1] = "id_scadenza"

iudw_children[1] = tab_1.tabpage_2.dw_scadenza_cess_ff
iudw_children[2] = tab_1.tabpage_3.dw_scadenza_rif_ff
iudw_children[3] = tab_1.tabpage_4.dw_scadenza_mov_scadenza_gd


end event

event itemchanged;call super::itemchanged;

CHOOSE CASE dwo.name
		
	CASE "id_valuta", "id_valuta_des"
		PostEvent("ue_assegna_camb")
		PostEvent("ue_calcola_imp")
	Case "imp_valuta", "cambio"
		PostEvent("ue_calcola_imp")
	Case "importo"
	
		IF ((IsNull(Trim(data))) OR (Trim(data) = "")) THEN
			PostEvent("ue_calcola_imp")
		END IF	
	Case "data_scadenza"
		PostEvent("ue_data_scadenza")	
	Case "id_tipo_pagamento", "id_tipo_pagamento_des"
	
		il_id_tipo_pagamento = Long(This.GetItemNumber(row,"id_tipo_pagamento_des"))
		il_id_tipo_pagamento_new = Long(data)
		PostEvent("ue_tipo_pagamento")
	Case ELSE	
END CHOOSE


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
		
END CHOOSE

end event

event rowfocuschanged;call super::rowfocuschanged;long ll_id_azienda
long ll_id_sog_comm


If CurrentRow>0 then 
	
	This.PostEvent("ue_tipo_scadenza")
	This.PostEvent("ue_cambio_stato")	
   
	 il_id_tipo_pagamento = Long(This.GetItemNumber(currentrow,"id_tipo_pagamento_des"))
	 il_id_tipo_pagamento_new = Long(This.GetItemNumber(currentrow,"id_tipo_pagamento_des"))
 
	This.PostEvent("ue_tipo_pagamento")
	This.PostEvent("ue_banche", ll_id_azienda, ll_id_sog_comm)
	This.PostEvent("ue_valuta")	

end if	
end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 2843
integer height = 1340
long backcolor = 79741120
string text = "Cessioni"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_scadenza_cess_ff dw_scadenza_cess_ff
end type

on tabpage_2.create
this.dw_scadenza_cess_ff=create dw_scadenza_cess_ff
this.Control[]={this.dw_scadenza_cess_ff}
end on

on tabpage_2.destroy
destroy(this.dw_scadenza_cess_ff)
end on

type dw_scadenza_cess_ff from u_dw_master_main within tabpage_2
integer x = 27
integer y = 36
integer width = 2798
integer height = 1252
integer taborder = 1
string dataobject = "d_scadenza_cess_ff"
end type

event ue_init;call super::ue_init;ib_dw_shared = TRUE

end event

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 2843
integer height = 1340
long backcolor = 79741120
string text = "Riferimenti"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
cb_origine cb_origine
dw_scadenza_rif_ff dw_scadenza_rif_ff
cb_documento cb_documento
cb_partita cb_partita
end type

on tabpage_3.create
this.cb_origine=create cb_origine
this.dw_scadenza_rif_ff=create dw_scadenza_rif_ff
this.cb_documento=create cb_documento
this.cb_partita=create cb_partita
this.Control[]={this.cb_origine,&
this.dw_scadenza_rif_ff,&
this.cb_documento,&
this.cb_partita}
end on

on tabpage_3.destroy
destroy(this.cb_origine)
destroy(this.dw_scadenza_rif_ff)
destroy(this.cb_documento)
destroy(this.cb_partita)
end on

type cb_origine from commandbutton within tabpage_3
integer x = 1998
integer y = 780
integer width = 786
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "S&eleziona Scadenza Origine..."
end type

event clicked;

uf_ricerca()
end event

type dw_scadenza_rif_ff from u_dw_master_main within tabpage_3
integer x = 27
integer y = 36
integer width = 2789
integer height = 1280
integer taborder = 10
string dataobject = "d_scadenza_rif_ff"
end type

event ue_init;call super::ue_init;ib_dw_shared = TRUE

is_list.s_colonne_drop[1] = "scadenza_id_valuta_cod"
is_list.s_colonne_drop[2] = "scadenza_id_valuta_des"
is_list.s_colonne_drop[3] = "scadenza_id_tipo_pagamento_cod"
is_list.s_colonne_drop[4] = "scadenza_id_tipo_pagamento_des"

end event

event rowfocuschanged;call super::rowfocuschanged;
end event

event ue_retrieve;call super::ue_retrieve;

uf_ricerca_par_documento()
end event

type cb_documento from commandbutton within tabpage_3
integer x = 2254
integer y = 304
integer width = 530
integer height = 84
integer taborder = 21
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Seleziona &Documento"
end type

event clicked;

uf_ricerca_documento()
end event

type cb_partita from commandbutton within tabpage_3
integer x = 2254
integer y = 644
integer width = 530
integer height = 84
integer taborder = 22
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Seleziona &Partita"
end type

event clicked;

uf_ricerca_partita()
end event

type tabpage_4 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 2843
integer height = 1340
long backcolor = 79741120
string text = "Movimenti di Scadenza"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_scadenza_mov_scadenza_gd dw_scadenza_mov_scadenza_gd
end type

on tabpage_4.create
this.dw_scadenza_mov_scadenza_gd=create dw_scadenza_mov_scadenza_gd
this.Control[]={this.dw_scadenza_mov_scadenza_gd}
end on

on tabpage_4.destroy
destroy(this.dw_scadenza_mov_scadenza_gd)
end on

type dw_scadenza_mov_scadenza_gd from u_dw_master_main within tabpage_4
integer x = 27
integer y = 36
integer width = 2798
integer height = 1252
string dataobject = "d_scadenza_mov_scadenza_gd"
end type

event ue_init;call super::ue_init;is_list.s_identifica[1] = "id_scadenza"
end event

event ue_default;call super::ue_default;

CHOOSE CASE string(adwo_current.name)
	CASE "data"
		THIS.SetItem(al_row, "data", Today())
END CHOOSE

end event

type cb_dividi from commandbutton within w_scadenza_cx
integer x = 1083
integer y = 40
integer width = 261
integer height = 84
integer taborder = 11
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Dividi"
end type

event clicked;string ls_esito_pag

ls_esito_pag=tab_1.tabpage_1.dw_scadenza_gen_ff.getitemstring(1, "esito_pagamento")
if ls_esito_pag='E' then
	openwithparm(w_dividi_scadenza_gd, tab_1.tabpage_1.dw_scadenza_gen_ff)
	
	
end if


end event

