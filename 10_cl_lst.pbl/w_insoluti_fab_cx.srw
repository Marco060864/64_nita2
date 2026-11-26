forward
global type w_insoluti_fab_cx from w_semplice_cx
end type
type cbx_insolute from checkbox within w_insoluti_fab_cx
end type
type cbx_distinta from checkbox within w_insoluti_fab_cx
end type
type st_1 from statictext within w_insoluti_fab_cx
end type
type dw_2 from udw_000 within w_insoluti_fab_cx
end type
type cb_mostra from commandbutton within w_insoluti_fab_cx
end type
type cbx_pagate from checkbox within w_insoluti_fab_cx
end type
type dw_riga_unica_gd from datawindow within w_insoluti_fab_cx
end type
end forward

global type w_insoluti_fab_cx from w_semplice_cx
integer width = 3173
integer height = 2260
boolean maxbox = true
boolean resizable = true
windowtype windowtype = main!
cbx_insolute cbx_insolute
cbx_distinta cbx_distinta
st_1 st_1
dw_2 dw_2
cb_mostra cb_mostra
cbx_pagate cbx_pagate
dw_riga_unica_gd dw_riga_unica_gd
end type
global w_insoluti_fab_cx w_insoluti_fab_cx

type variables
string is_sql_originale
datastore ids_scadenza
s_con_effetti  istr_con_effetti
end variables

forward prototypes
public subroutine wf_riempi_nulli ()
public function integer uf_contabilizza_uno_per_volta ()
public function integer uf_trova_conto (long al_id_sog_commerciale)
public subroutine uf_aggiorna_scadenza (long al_id_scadenza[])
end prototypes

public subroutine wf_riempi_nulli ();long i


update riga_documento
set provv_carea_2=0
from documento d, registro reg, riga_documento r
where reg.tipo_registro='OV'
and d.id_documento=r.id_documento
and d.id_registro=reg.id_registro
;
if sqlca.sqlNrows>0 then
	commit;
else
	rollback;
end if

//for i = 1 to dw_1.rowcount()
//	if isnull(dw_1.getitemnumber(i, "provv_carea_2")) then
//		dw_1.setitem(i, "provv_carea_2", 0)
//	end if
//next
//cb_salva.triggerevent(clicked!) 
end subroutine

public function integer uf_contabilizza_uno_per_volta ();

long ll_CurrRow_ff, ll_CurrRow_gd, ll_id_conto_mc[], ll_i, ll_id_sog_commerciale, ll_id_reg_pd, ll_id_scad
long ll_id_esercizio, ll_id_valuta_i, ll_id_valuta_f, ll_null
long ll_id_registro, ll_num_progressivo, ll_id_par_aperta[], ll_NULL_array[], ll_id_scadenza[], ll_importo
integer li_RetVal, li_tipo_registrazione
decimal ldc_tot_distinta, ldc_importo_mc[], ldc_NULL, ldc_NULL_array[], ldc_tmp_importo
char lc_segno_mc[]
date ld_data_registrazione, ld_data_scadenza[]
boolean lb_mc_iva[], ok_cont 
string ls_descr_registro, ls_desc_tipo_pagam[], ls_data
long  ll_tipo_cont, ll_id_riga_dis_banca

CONSTANT CHAR LCC_DARE = "D"
CONSTANT CHAR LCC_AVERE = "A"

ok_cont = true

u_reg_pd lu_reg_pd
lu_reg_pd = CREATE u_reg_pd

SetNull(ldc_NULL)
SetNull(ll_id_registro)
SetNull(ll_num_progressivo)

//ll_CurrRow_ff = dw_dis_banca_ff.GetRow()
ll_CurrRow_gd = dw_riga_unica_gd.GetRow()
ll_CurrRow_ff=ll_CurrRow_gd
ldc_tot_distinta = 0 

SetNull(ll_NULL)
select id_esercizio
into :ll_id_esercizio
from dba.esercizio
where data_inizio<=:istr_con_effetti.d_data_registrazione
and data_fine>=:istr_con_effetti.d_data_registrazione
;
if isnull(ll_id_esercizio) or ll_id_esercizio<=0 then return -1
//ll_id_esercizio = dw_dis_banca_ff.getitemnumber(1,"id_esercizio")
ll_id_valuta_f  = f_proponi_valuta(ll_NULL, ll_id_esercizio)

FOR ll_i = 1 to dw_riga_unica_gd.RowCount()
	
	
	ldc_tmp_importo = 0
	ll_id_scad = dw_riga_unica_gd.GetItemnumber(ll_i, "id_scadenza") 
	select importo
	into :ldc_tmp_importo
	from scadenza 
	where id_scadenza = :ll_id_scad;
	if isnull(ldc_tmp_importo) then ldc_tmp_importo = 0
	ll_id_valuta_i = dw_riga_unica_gd.GetItemnumber(ll_i, "id_valuta_i") 
	
	select fn_conv_valuta(:ll_id_valuta_i, :ldc_tmp_importo, :ll_id_valuta_f)
	into :ldc_tmp_importo
	from sys.dummy;				
	
	ldc_tot_distinta = ldc_tot_distinta + ldc_tmp_importo
	
	
	ll_importo = 	 dw_riga_unica_gd.GetItemDecimal(ll_i, "scadenza_importo")  	
	if isnull(ll_importo) then
		ok_cont = false
		exit
	end if
next

IF ok_cont = true then
	
IF NOT IsNull(istr_con_effetti.l_id_prof_registrazione) AND &
	NOT IsNull(istr_con_effetti.i_tipo_registrazione) AND &
	(ll_CurrRow_ff > 0) THEN
				
	
	CHOOSE CASE istr_con_effetti.c_tipo_distinta
		CASE "A"

			CHOOSE CASE istr_con_effetti.i_tipo_registrazione
				CASE 1, 3, 6
					
					ll_id_conto_mc[1] = istr_con_effetti.l_id_conto_1
					lc_segno_mc[1]    = LCC_DARE
					ldc_importo_mc[1] = ldc_tot_distinta
					SetNull(ll_id_par_aperta[1])
					SetNull(ll_id_scadenza[1])
					lb_mc_iva[1] = FALSE
					
					FOR ll_i = 1 TO dw_riga_unica_gd.RowCount()
						ll_id_sog_commerciale = dw_riga_unica_gd.GetItemNumber(ll_i, "id_sog_commerciale")
						ll_id_conto_mc[ll_i + 1] = uf_trova_conto(ll_id_sog_commerciale)
						lc_segno_mc[ll_i + 1]    = LCC_AVERE
						
						
						ldc_tmp_importo = 0
						ll_id_scad = dw_riga_unica_gd.GetItemnumber(ll_i, "id_scadenza") 
						select importo
						into :ldc_tmp_importo
						from scadenza 
						where id_scadenza = :ll_id_scad;
						if isnull(ldc_tmp_importo) then ldc_tmp_importo = 0
						ll_id_valuta_i = dw_riga_unica_gd.GetItemnumber(ll_i, "id_valuta_i") 
						
						select fn_conv_valuta(:ll_id_valuta_i, :ldc_tmp_importo, :ll_id_valuta_f)
						into :ldc_tmp_importo
						from sys.dummy;				
						
						
						ldc_importo_mc[ll_i + 1] = ldc_tmp_importo
						
						
						ll_id_par_aperta[ll_i + 1] = dw_riga_unica_gd.GetItemNumber(ll_i, "scadenza_id_par_aperta")
						ll_id_scadenza[ll_i + 1] = dw_riga_unica_gd.GetItemNumber(ll_i, "id_scadenza")
						lb_mc_iva[ll_i + 1] = FALSE
					NEXT
		END CHOOSE
	END CHOOSE
	
	ld_data_registrazione = istr_con_effetti.d_data_registrazione// dw_riga_unica_gd.GetItemDate(1, "scadenza_data_scadenza")
	
	
   FOR ll_i = 1 TO dw_riga_unica_gd.RowCount()
		ld_data_scadenza[ll_i+1]   = dw_riga_unica_gd.GetItemDate(ll_i, "scadenza_data_scadenza")
		ls_desc_tipo_pagam[ll_i+1] = trim(dw_riga_unica_gd.GetItemString(ll_i, "descrizione"))
   NEXT
	
	lu_reg_pd.uf_data_scadenza(ld_data_scadenza)
	//mm 07-11-14 se la data scadenza è oltre l'esercizio corrente
	//devo scegliere l'esercizio corretto o avvertire che NON esiste
	
	setnull(ll_id_esercizio)
	select id_esercizio
	into :ll_id_esercizio
	from dba.esercizio
	where data_inizio <= :ld_data_registrazione
	and data_fine>= :ld_data_registrazione;
	if isnull(ll_id_esercizio) or ll_id_esercizio=0 then
		messagebox("Attenzione!", "La data scadenza: "+string(ld_data_registrazione)+&
		" va oltre l'esercizio corrente e NON è stato trovato	l'esercizio corretto!")
		return -1
	end if
	
	
   lu_reg_pd.uf_desc_tipo_pagam(ls_desc_tipo_pagam)
	
	
	lu_reg_pd.uf_id_prof_registrazione(istr_con_effetti.l_id_prof_registrazione)
	lu_reg_pd.uf_id_registro(ll_id_registro)
	lu_reg_pd.uf_num_progressivo(ll_num_progressivo)
	
	lu_reg_pd.uf_data_registrazione(ld_data_registrazione)
	
	lu_reg_pd.uf_descrizione(istr_con_effetti.s_des_contabile)
	lu_reg_pd.uf_id_conto_mc(ll_id_conto_mc)
	lu_reg_pd.uf_segno_mc(lc_segno_mc)
	lu_reg_pd.uf_importo_mc(ldc_importo_mc)
	lu_reg_pd.uf_id_par_aperta(ll_id_par_aperta)
	lu_reg_pd.uf_invert_mov_partita(FALSE)
	lu_reg_pd.uf_crea_mov_partita(TRUE)
	lu_reg_pd.uf_crea_mov_scadenza(TRUE)
	lu_reg_pd.uf_id_scadenza(ll_id_scadenza)
	lu_reg_pd.uf_mc_iva(lb_mc_iva)
	lu_reg_pd.uf_id_esercizio(ll_id_esercizio) 
	lu_reg_pd.uf_id_valuta(ll_id_valuta_f) 
	
	//per non visualizzare le registrazioni 011111
	lu_reg_pd.ii_DisplayMode=0
	
	ll_id_reg_pd = lu_reg_pd.uf_crea()
	
	IF ll_id_reg_pd > 0 THEN
		uf_aggiorna_scadenza(ll_id_scadenza)
		
		
		
		ll_tipo_cont = istr_con_effetti.i_tipo_registrazione
		//ATTENZIONEEEEEEE!!!!
		//qui metti mano: aggiorna il tipo contabilizzazione sulla distinta: occorre farlo!!!!!
		ll_id_riga_dis_banca=dw_1.getitemnumber(dw_1.getrow(), "id_riga_distinta_banca")
		update dis_banca
		set tipo_contabilizzazione=:ll_tipo_cont  //portafoglio a clienti
		from dis_banca d, riga_dis_banca r
		where r.id_riga_distinta_banca= :ll_id_riga_dis_banca
		and r.id_distinta_banca=d.id_distinta_banca
		;
		if sqlca.sqlNrows>0 then
			commit;
		else
			messagebox("Attenzione!", "Tipo Contabilizazione non aggiornato in distinta!")
			rollback;
		end if
	
		messagebox("OK!","La distinta è stata correttamente contabilizzata")	
	else 
		messagebox ('ATTENZIONE', 'Impossibile creare la registrazione',stopsign!) 
	END IF
END IF
else
	messagebox ('ATTENZIONE', 'Non sono stati impostati correttamente ~r~ntutti i valori della RIBA n. ' + string(ll_i) + ', verificare')
end if	
return 1
end function

public function integer uf_trova_conto (long al_id_sog_commerciale);

long ll_RetVal, ll_id_conto
string ls_codice

IF NOT IsNull(al_id_sog_commerciale) THEN
	SELECT dba.sog_commerciale.id_conto,
			 dba.sog_commerciale.codice
		INTO :ll_id_conto,
			  :ls_codice
		FROM sog_commerciale
		WHERE sog_commerciale.id_sog_commerciale = :al_id_sog_commerciale ;
		
	CHOOSE CASE SQLCA.SQLCode
		CASE 0
			CHOOSE CASE ll_id_conto
				CASE IS > 0
					ll_RetVal = ll_id_conto
				CASE ELSE
					MessageBox("Contabilizzazione Distinte", "Attenzione: Il Soggetto Commerciale con codice " + ls_codice + "~rnon ha un conto collegato.")
					ll_RetVal = 0
			END CHOOSE

		CASE -1
			MessageBox("Errore sul DataBase", "w_riga_dis_banca_cx / uf_trova_conto / 1")
			ll_RetVal = 0
	END CHOOSE
	
END IF

RETURN ll_RetVal
end function

public subroutine uf_aggiorna_scadenza (long al_id_scadenza[]);

long ll_i, ll_id_banca_azienda, ll_gg_min_cal_esposizione
char lc_esito_pagamento
date ld_data_scadenza, ld_data_cond, ld_data_pagamento

IF UpperBound(al_id_scadenza) > 0 THEN
	FOR ll_i = 1 TO UpperBound(al_id_scadenza)
		IF al_id_scadenza[ll_i] > 0 THEN
			SELECT
				scadenza.esito_pagamento,
				scadenza.data_scadenza,
				scadenza.id_banca_azienda
			INTO
				:lc_esito_pagamento,
				:ld_data_scadenza,
				:ll_id_banca_azienda
			FROM
				dba.scadenza
			WHERE
				scadenza.id_scadenza = :al_id_scadenza[ll_i]
			USING
				SQLCA;
		
			CHOOSE CASE SQLCA.SQLCode
				CASE 0
					IF (lc_esito_pagamento = 'P') AND (NOT IsNull(ll_id_banca_azienda)) THEN
						SetNull(ll_gg_min_cal_esposizione)
						SELECT
							gg_min_cal_esposizione
						INTO
							:ll_gg_min_cal_esposizione
						FROM
							con_banca_azienda
						WHERE
							id_banca_azienda = :ll_id_banca_azienda AND
							data_condizione = (
							SELECT
								max(data_condizione)
							FROM
								con_banca_azienda
							WHERE
								id_banca_azienda = :ll_id_banca_azienda)
						USING
							SQLCA;
						IF NOT IsNull(ll_gg_min_cal_esposizione) THEN
							ld_data_pagamento = RelativeDate(ld_data_scadenza, ll_gg_min_cal_esposizione)
							UPDATE
								scadenza
							SET
								data_pagamento = :ld_data_pagamento
							WHERE
								scadenza.id_scadenza = :al_id_scadenza[ll_i]
							USING
								SQLCA;
							
							IF (SQLCA.SQLCode = 0) AND (SQLCA.SQLNRows = 1) THEN
								COMMIT USING SQLCA;
							END IF
						END IF
					END IF
			END CHOOSE
		END IF

	NEXT
END IF
end subroutine

on w_insoluti_fab_cx.create
int iCurrent
call super::create
this.cbx_insolute=create cbx_insolute
this.cbx_distinta=create cbx_distinta
this.st_1=create st_1
this.dw_2=create dw_2
this.cb_mostra=create cb_mostra
this.cbx_pagate=create cbx_pagate
this.dw_riga_unica_gd=create dw_riga_unica_gd
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_insolute
this.Control[iCurrent+2]=this.cbx_distinta
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.dw_2
this.Control[iCurrent+5]=this.cb_mostra
this.Control[iCurrent+6]=this.cbx_pagate
this.Control[iCurrent+7]=this.dw_riga_unica_gd
end on

on w_insoluti_fab_cx.destroy
call super::destroy
destroy(this.cbx_insolute)
destroy(this.cbx_distinta)
destroy(this.st_1)
destroy(this.dw_2)
destroy(this.cb_mostra)
destroy(this.cbx_pagate)
destroy(this.dw_riga_unica_gd)
end on

event resize;call super::resize;dw_1.height=newheight - 292 - 220
end event

event open;call super::open;
dw_2.SetTransObject(SQLCA)
dw_riga_unica_gd.settransobject(sqlca)
dw_1.settransobject(sqlca)
dw_2.insertrow(1)


dw_2.setitem(1, "da_data", relativedate(today(), -90))
dw_2.setitem(1, "a_data",today())


//is_sql_originale=dw_1.getsqlselect()




end event

type cb_stampa from w_semplice_cx`cb_stampa within w_insoluti_fab_cx
integer x = 905
integer y = 2024
end type

type cb_ricerca from w_semplice_cx`cb_ricerca within w_insoluti_fab_cx
integer x = 1481
integer y = 1952
end type

type cb_primo from w_semplice_cx`cb_primo within w_insoluti_fab_cx
integer x = 919
integer y = 1960
end type

type cb_ultimo from w_semplice_cx`cb_ultimo within w_insoluti_fab_cx
integer x = 1335
integer y = 1960
end type

type cb_indietro from w_semplice_cx`cb_indietro within w_insoluti_fab_cx
integer x = 1248
integer y = 1960
end type

type cb_avanti from w_semplice_cx`cb_avanti within w_insoluti_fab_cx
integer x = 1376
integer y = 1960
end type

type dw_1 from w_semplice_cx`dw_1 within w_insoluti_fab_cx
integer x = 55
integer y = 268
integer width = 2999
integer height = 1652
string dataobject = "d_scad_insoluto_fab"
end type

event dw_1::sqlpreview;string ls_sql

if dw_1.is_sql> " " then
	ls_sql=is_sql_originale
	ls_sql+=dw_1.is_sql
	setsqlpreview(ls_sql)
end if
end event

event dw_1::doubleclicked;//
long ll_id_doc
w_orafo_documento_ordine_cx w_orafo
s_list_main s_list

if row<=0 then return
s_list.s_identifica[1]="id_documento"
s_list.s_modo=modo_modifica
ll_id_doc=getitemnumber(row, "documento_id_documento")
if ll_id_doc>0 then
	s_list.l_identifica[1]=ll_id_doc
	openwithparm(w_orafo, s_list)
end if


end event

event dw_1::updateend;call super::updateend;long ll_id_doc, ll_riga_inserita, ll_id_tipo_pag, ll_id_sog, ll_id_scad
u_dw_main	idw_master	
decimal ldc_importo
string ls_nota
date ldt_nuova_data_scadenza

if rowsupdated>0 then
	if messagebox("Attenzione!", "Vuoi creare una nuova scadenza a sostituire l'insoluto?",  stopsign!,yesno!)=1 then
		ll_id_scad=dw_1.getitemnumber(dw_1.getrow(), "scadenza_id_scadenza")
//		ids_scadenza=create datastore
//		ids_scadenza.dataobject="d_scadenza_gen_ff"
//		ids_scadenza.settransobject(sqlca)
//		ll_riga_inserita=ids_scadenza.insertrow(1)
//		ls_nota="Scadenza inserita in sostituzione della ID= "+string(ll_id_scad)
//		//da finire
//		ls_nota+=" che aveva data scadenza "
//		//da finire fine
//		ids_scadenza.setitem(ll_riga_inserita, "id_tipo_pagamento_des", ll_id_tipo_pag)
//		ids_scadenza.setitem(ll_riga_inserita, "tipo_scadenza", "A")
//		ids_scadenza.setitem(ll_riga_inserita, "id_sog_commerciale", ll_id_sog)
//		ids_scadenza.setitem(ll_riga_inserita, "id_valuta_des", 3)
//		ids_scadenza.setitem(ll_riga_inserita, "cambio", 1)
//		ids_scadenza.setitem(ll_riga_inserita, "imp_valuta",ldc_importo)
//		ids_scadenza.setitem(ll_riga_inserita, "importo", ldc_importo)
//		
//		ids_scadenza.setitem(ll_riga_inserita, "stato_scadenza", "D")
//		ids_scadenza.setitem(ll_riga_inserita, "esito_pagamento", "E")
//		ids_scadenza.setitem(ll_riga_inserita, "id_documento", ll_id_doc)
//		ids_scadenza.setitem(ll_riga_inserita, "Note", ls_nota)
		
		idw_master=create u_dw_main
		idw_master.is_list.l_identifica[1]=ll_id_scad
		idw_master.is_list.s_identifica[1]="scadenza_id_scadenza"
		idw_master.is_list.s_modo=modo_modifica
		openwithparm(w_scadenza_cx, idw_master.is_list)
		destroy idw_master
	end if
	if messagebox("Attenzione!", "Vuoi creare una scrittura contabile a copertura dell'insoluto?",  stopsign!,yesno!)=1 then
		long ll_id_riga_distinta, ll_id_distinta, ll_riga
		
		ll_riga=dw_1.getrow()
		ll_id_riga_distinta=dw_1.getitemnumber(ll_riga, "id_riga_distinta_banca")
		dw_riga_unica_gd.retrieve(ll_id_riga_distinta, 3)
		istr_con_effetti.c_tipo_distinta ="A" // dw_dis_banca_ff.GetItemString(ll_CurrRow_ff, "tipo")
		OpenWithParm(w_con_effetti_ff, istr_con_effetti)
	
		istr_con_effetti = Message.PowerObjectParm
//		open(w_data_nuova_scadenza)
//		ls_nota=message.stringparm
		uf_contabilizza_uno_per_volta()
//		select id_distinta_banca
//		into :ll_id_distinta
//		from dba.riga_dis_banca
//		where id_riga_distinta_banca=:ll_id_riga_distinta
//		;
//		//la data scadenza va richiesta all'utente!!!!!
//		if ll_id_distinta>0 then
//			ll_riga_inserita=dw_riga_unica_gd.insertrow(0)
//			dw_riga_unica_gd.setitem(ll_riga_inserita, "id_riga_distinta_banca", ll_id_riga_distinta)
//			dw_riga_unica_gd.setitem(ll_riga_inserita, "id_riga_distinta_banca", ll_id_riga_distinta)
//			
//		end if
			
		
		
		
		//integer i
//long ll_CurrRow_ff, ll_tipo_cont, ll_riga, ll_contabilizza


//ll_contabilizza=7
//
//if ll_contabilizza=7 then
//
//	Message.Processed = TRUE
//	l
//
//	istr_con_effetti.c_tipo_distinta = "A"
//	OpenWithParm(w_con_effetti_ff, istr_con_effetti)
//	
//	istr_con_effetti = Message.PowerObjectParm
//	IF NOT IsNull(istr_con_effetti.l_id_prof_registrazione) AND &
//		NOT IsNull(istr_con_effetti.i_tipo_registrazione) THEN 
//		dw_riga_dis_banca_gd.setsort("scadenza_data_scadenza")
//		dw_riga_dis_banca_gd.sort()
//		for i=1 to dw_riga_dis_banca_gd.rowcount()
//			dw_riga_unica_gd.reset()
//			dw_riga_dis_banca_gd.rowscopy(i,i,primary!, dw_riga_unica_gd, 1, primary!)
//			uf_contabilizza_uno_per_volta()
//		next
//		messagebox("OK!","La distinta è stata correttamente contabilizzata")	
//	END IF
	end if	
else
	messagebox("Attenzione!!!","La distinta è già stata contabilizzata")
end if

//end if
end event

type cb_inserisci from w_semplice_cx`cb_inserisci within w_insoluti_fab_cx
boolean visible = false
integer x = 50
integer y = 1944
end type

type cb_salva from w_semplice_cx`cb_salva within w_insoluti_fab_cx
integer x = 334
integer y = 1944
end type

type cb_cancella from w_semplice_cx`cb_cancella within w_insoluti_fab_cx
boolean visible = false
integer x = 622
integer y = 1944
end type

type cb_annulla from w_semplice_cx`cb_annulla within w_insoluti_fab_cx
integer x = 1755
integer y = 1948
end type

type cb_ok from w_semplice_cx`cb_ok within w_insoluti_fab_cx
integer x = 2043
integer y = 1948
end type

type cbx_insolute from checkbox within w_insoluti_fab_cx
integer x = 690
integer y = 180
integer width = 398
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Insolute"
end type

type cbx_distinta from checkbox within w_insoluti_fab_cx
integer x = 325
integer y = 180
integer width = 343
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Distinta"
boolean checked = true
end type

type st_1 from statictext within w_insoluti_fab_cx
integer x = 64
integer y = 180
integer width = 256
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Mostra: "
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_2 from udw_000 within w_insoluti_fab_cx
integer x = 87
integer y = 12
integer width = 2002
integer height = 140
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_da_data_a_data_sog_com"
end type

type cb_mostra from commandbutton within w_insoluti_fab_cx
integer x = 2139
integer y = 20
integer width = 910
integer height = 232
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Mostra"
end type

event clicked;date ldt_da_data, ldt_a_data
string  ls_filtro_sog
integer li_colonna
long ll_id_sog


li_colonna=dw_1.getcolumn()
if li_colonna=5 then	dw_2.setcolumn("da_data")

dw_1.accepttext()
ldt_da_data=dw_2.getitemdate(1, "da_data")
ldt_a_data=dw_2.getitemdate(1, "a_data")
ll_id_sog=dw_2.getitemnumber(1, "id_sog_com")

if ll_id_sog>0 then
	ls_filtro_sog=" sog_commerciale_gen_id_sog_commerciale ="+string(ll_id_sog)+ " "
else
	ls_filtro_sog=""	
end if

if cbx_distinta.checked  then ls_filtro_sog+= " (stato_scadenza = 'D')"
if cbx_insolute.checked then 	
	if right(ls_filtro_sog, 1)=")" then 
		ls_filtro_sog=left(ls_filtro_sog, len(ls_filtro_sog) - 1)
		ls_filtro_sog+= " or stato_scadenza = 'I')"
	else
		ls_filtro_sog+= " and (stato_scadenza = 'I')"
	end if
end if
	
if cbx_pagate.checked  then 	
	if right(ls_filtro_sog, 1)=")" then 
		ls_filtro_sog=left(ls_filtro_sog, len(ls_filtro_sog) - 1)
		ls_filtro_sog+= " or stato_scadenza = 'P')"
	else
		ls_filtro_sog+= " and (stato_scadenza = 'P')"
	end if
end if
	

dw_1.setfilter(ls_filtro_sog)
dw_1.filter()
	
dw_1.retrieve(ldt_da_data, ldt_a_data)


end event

type cbx_pagate from checkbox within w_insoluti_fab_cx
integer x = 1051
integer y = 180
integer width = 343
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Pagate"
end type

type dw_riga_unica_gd from datawindow within w_insoluti_fab_cx
integer x = 82
integer y = 1400
integer width = 2939
integer height = 400
integer taborder = 70
boolean bringtotop = true
string title = "none"
string dataobject = "d_ra_riga_dis_banca_gd"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
borderstyle borderstyle = stylelowered!
end type

