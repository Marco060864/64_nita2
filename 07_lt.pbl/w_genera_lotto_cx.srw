forward
global type w_genera_lotto_cx from w_p_data
end type
type dw_genera_lotto_ff from u_dw_master_main within tabpage_1
end type
type tv_1 from treeview within tabpage_1
end type
type cb_1 from commandbutton within tabpage_1
end type
type dw_genera_lotto_ff from u_dw_master_main within tabpage_1
end type
type tv_1 from treeview within tabpage_1
end type
type cb_1 from commandbutton within tabpage_1
end type
type tabpage_2 from userobject within tab_1
end type
type dw_art_lotto_ext from u_dw_master_main within tabpage_2
end type
type cb_5 from commandbutton within w_genera_lotto_cx
end type
type cb_4 from commandbutton within w_genera_lotto_cx
end type
type cb_3 from commandbutton within w_genera_lotto_cx
end type
type cb_preview from commandbutton within w_genera_lotto_cx
end type
type cb_2 from commandbutton within w_genera_lotto_cx
end type
type tabpage_2 from userobject within tab_1
dw_art_lotto_ext dw_art_lotto_ext
end type
end forward

global type w_genera_lotto_cx from w_p_data
int X=512
int Width=3264
int Height=1488
boolean TitleBar=true
string Title="Generazione Lotti di Produzione"
cb_5 cb_5
cb_4 cb_4
cb_3 cb_3
cb_preview cb_preview
cb_2 cb_2
end type
global w_genera_lotto_cx w_genera_lotto_cx

type variables
datastore ds_lotto , ds_mov_lotto

boolean generato=false, commerciale=false, salvato=false
long il_id_doc_car, il_id_doc_scar
char ic_tipo_ges_lotti
long il_id_distinta  

end variables

forward prototypes
public subroutine wf_genera_doc ()
public subroutine wf_cancella_doc ()
public subroutine wf_errore (string as_msg)
public subroutine wf_mp_necessarie ()
public subroutine wf_lotti_mp_necessari ()
end prototypes

public subroutine wf_genera_doc ();long ll_id_reg_car, ll_id_reg_scar, ll_id_prof_car, ll_id_prof_scar, ll_num_prog, ll_id_sog_com, ll_id_valuta
long ll_id_art, ll_id_doc, ll_id_r_lotto, ll_id_u_conf, ll_riga, i, ll_id_caus_car, ll_id_caus_scar, ll_id_lotto, ll_id_locazione
decimal{2} ld_quantita
date ld_data_reg
long ll_row
string ls_cod_lotto, ls_des_art
boolean errore=false
long 		ll_id_lotto_mp 
long 		ll_found 
string 	ls_find
long	 	ll_id_riga_documento
long		ll_id_val_lire 
decimal	ld_cambio, ld_cambio_l
decimal	ld_prezzo_lotto
decimal	ld_tot_riga_val_doc
string	ls_tipo_mov
decimal	ld_tot_riga_val_doc_l
decimal	ld_per_aliquota
long		ll_id_esercizio	
string	ls_data_reg			

decimal {4} ld_peso_netto
long ll_id_tab_iva, ll_id_tab_iva_2	
ll_row = tab_1.tabpage_1.dw_genera_lotto_ff.getrow()
if ll_row > 0 then ld_data_reg = tab_1.tabpage_1.dw_genera_lotto_ff.getitemdate(ll_row, "data_doc")
if isnull(ld_data_reg) then ld_data_reg = today()
ld_data_reg = date(string(ld_data_reg, 'yyyy-mm-dd'))
SELECT id_esercizio
INTO	 :ll_id_esercizio
FROM	 esercizio
WHERE  data_inizio <= :ld_data_reg
AND	 data_fine >= :ld_data_reg
;

choose case sqlca.sqlcode 
	case -1
		messagebox("DbError", sqlca.sqlerrtext)
	case 100
		messagebox("Attenzione", "Non esiste un registro per la data indicata.~nVerificare i documenti creati")
end choose

	select id_locazione
	into   :ll_id_locazione
	from   par_sistema;

	select id_registro
	into   :ll_id_reg_car
	from   registro
	where  registro.tipo_registro='CL'
	and	 id_esercizio = :ll_id_esercizio		
	;
	if IsNull(ll_id_reg_car)or(ll_id_reg_car=0) then 
		wf_errore('Registro di Carico')
		return
	end if
	select id_registro
	into   :ll_id_reg_scar
	from   registro
	where  registro.tipo_registro='SL'
	and	 id_esercizio = :ll_id_esercizio		
	;
	if IsNull(ll_id_reg_scar)or(ll_id_reg_scar=0) then
		wf_errore('Registro di Scarico')
		return
	end if
	select id_prof_documento
	into :ll_id_prof_car
	from prof_documento
	where prof_documento.codice='CL';
	if IsNull(ll_id_prof_car)or(ll_id_prof_car=0) then
		wf_errore('Profilo di Carico')
		return
	end if
	select id_prof_documento
	into :ll_id_prof_scar
	from prof_documento
	where prof_documento.codice='SL';
	if IsNull(ll_id_prof_scar)or(ll_id_prof_scar=0) then
		wf_errore('Profilo di Scarico')
		return
	end if
	select id_caus_magazzino
	into :ll_id_caus_car
	from caus_magazzino
	where caus_magazzino.codice='CL';
	if IsNull(ll_id_caus_car)or(ll_id_caus_car=0) then
		wf_errore('Causale di Carico')
		return
	end if
	select id_caus_magazzino
	into :ll_id_caus_scar
	from caus_magazzino
	where caus_magazzino.codice='SL';
	if IsNull(ll_id_caus_scar)or(ll_id_caus_scar=0) then
		wf_errore('Causale di Scarico')
		return
	end if
	select id_sog_commerciale
	into :ll_id_sog_com
	from sog_commerciale_gen
	where sog_commerciale_gen.rag_soc_1='me stesso';
	if IsNull(ll_id_sog_com)or(ll_id_sog_com=0) then
		wf_errore('Sogg. Comm. "me stesso"')
		return
	end if
	select id_valuta, id_val_lire
	into 	 :ll_id_valuta, :ll_id_val_lire
	from	 par_sistema		
	;
	if IsNull(ll_id_valuta)or(ll_id_valuta=0) then
		wf_errore('Valuta in Lire')
		return
	end if
	
	select max(num_progressivo)
	into :ll_num_prog
	from documento
	where (documento.id_prof_documento=:ll_id_prof_scar)and(documento.id_registro=:ll_id_reg_scar);
	if IsNull(ll_num_prog) then 
		ll_num_prog=1
	else
		ll_num_prog++
	end if
	insert into documento (documento.id_prof_documento, documento.id_registro, documento.num_progressivo, documento.data_registrazione,
								documento.id_sog_commerciale, documento.id_valuta, documento.id_caus_magazzino,
								documento.id_locazione_1
								,documento.data_documento, documento.num_documento)			
	values (:ll_id_prof_scar, :ll_id_reg_scar, :ll_num_prog, :ld_data_reg, :ll_id_sog_com, :ll_id_valuta, :ll_id_caus_scar, :ll_id_locazione
			, :ld_data_reg, :ll_num_prog); 
	if sqlca.sqlcode<>0 then
		messagebox("Errore", "Documento di scarico non creato")
		errore=true
		rollback;
	else
		commit;
	end if
	
	select Max(id_documento)
	into :ll_id_doc
	from documento;
	
	
	il_id_doc_scar=ll_id_doc
	
	ll_riga=tab_1.tabpage_2.dw_art_lotto_ext.RowCount()
	for i=1 to ll_riga
		ll_id_art=tab_1.tabpage_2.dw_art_lotto_ext.GetItemNumber(i,"id_articolo")
		ld_quantita=tab_1.tabpage_2.dw_art_lotto_ext.GetItemDecimal(i,"quantita")
		ls_cod_lotto=tab_1.tabpage_2.dw_art_lotto_ext.getItemString(i,"cod_lotto")
		ls_des_art=tab_1.tabpage_2.dw_art_lotto_ext.getItemString(i,"descrizione_art")
		
		
		if (ic_tipo_ges_lotti = 'G') then
			ld_peso_netto = tab_1.tabpage_2.dw_art_lotto_ext.GetItemDecimal(i,"peso_netto")
		end if
		
		
		select prog_materie_prime
		into :ll_id_r_lotto
		from prog_lotti;
		ll_id_r_lotto++
		update prog_lotti
		set prog_materie_prime = :ll_id_r_lotto;


		
		ll_id_lotto_mp = tab_1.tabpage_2.dw_art_lotto_ext.GetItemDecimal(i,"id_lotto_mp")
		
		select id_lotto
		into   :ll_id_lotto
		from   lotto
		where  id_lotto = :ll_id_lotto_mp
		
		;
		
		
		select id_unita_confezione
		into :ll_id_u_conf
		from unita_confezione
		where (unita_confezione.id_articolo=:ll_id_art)and(unita_confezione.unita_base='S');
		
		
		if (ic_tipo_ges_lotti = 'G') then
			
			ll_id_tab_iva = 0;
			ll_id_tab_iva_2 = 0;
			SELECT a.id_tab_iva, c.id_tab_iva
			INTO	 :ll_id_tab_iva, :ll_id_tab_iva_2
			FROM	 articolo a, cat_com_articolo c
			WHERE  a.id_articolo = :ll_id_art
			AND	 c.id_cat_com_articolo = a.id_cat_com_articolo
			;
			if (SQLCA.SQLCODE = -1) then messagebox("DbError", SQLCA.SQLERRTEXT)

			if (isnull(ll_id_tab_iva) or ll_id_tab_iva >= 0) then
				if (ll_id_tab_iva_2 >= 0) then ll_id_tab_iva = ll_id_tab_iva_2
			end if
			
			
			INSERT INTO riga_documento (id_documento, num_riga, id_valuta, 
				id_articolo, quantita, id_riga_lotto, 
				descrizione, id_unita_confezione, id_locazione_1,
				id_caus_magazzino, fat_con_unita_base,
				fat_con_globale, qta_un_base, peso_netto
				,id_tab_iva)		
			VALUES (:ll_id_doc, :i, :ll_id_valuta, :ll_id_art, :ld_quantita, 
				:ll_id_r_lotto, :ls_des_art, :ll_id_u_conf, :ll_id_locazione, 
				:ll_id_caus_scar, 1, 1, :ld_quantita, :ld_peso_netto,
				:ll_id_tab_iva)	
			;
			
			
			SELECT @@identity 
			INTO	 :ll_id_riga_documento 
			FROM 	 SYS.DUMMY
			;
			
			ls_find = "id_lotto = " + string(ll_id_lotto_mp) 
			ll_found = ds_mov_lotto.Find(ls_find, &
						  1, ds_mov_lotto.RowCount())
					
			if ll_found > 0 and ll_id_riga_documento > 0 then 
				ds_mov_lotto.setitem(ll_found, "id_riga_documento", ll_id_riga_documento)
				ds_mov_lotto.update()
			end if
			
		else
	
			insert into riga_documento (riga_documento.id_documento, riga_documento.num_riga, riga_documento.id_valuta, 
											riga_documento.id_articolo, riga_documento.quantita, riga_documento.id_riga_lotto, 
											riga_documento.descrizione, riga_documento.id_unita_confezione, riga_documento.id_locazione_1,
											riga_documento.id_caus_magazzino, riga_documento.fat_con_unita_base,
											riga_documento.fat_con_globale, riga_documento.qta_un_base)
			values (:ll_id_doc, :i, :ll_id_valuta, :ll_id_art, :ld_quantita, :ll_id_r_lotto, :ls_des_art, 
						:ll_id_u_conf, :ll_id_locazione, :ll_id_caus_scar, 1, 1, :ld_quantita);

		end if
		
		
	
		if sqlca.sqlcode<>0 then
			messagebox("Errore", "Riga_Documento di scarico non creata")
			messagebox("", SQLCA.SQLERRTEXT) 
			errore=true			
			rollback;
		else
			commit;

			
			insert into riga_doc_lotto (riga_doc_lotto.id_riga_lotto, riga_doc_lotto.id_lotto, riga_doc_lotto.valore_scarico, riga_doc_lotto.id_doc)
			values (:ll_id_r_lotto, :ll_id_lotto, 0, :ll_id_doc);
			if sqlca.sqlcode<>0 then
				messagebox("Errore", sqlca.sqlerrtext)
				rollback;
			else
				commit;
			end if
		end if
		
	next
	
	select max(num_progressivo)
	into :ll_num_prog
	from documento
	where (documento.id_prof_documento=:ll_id_prof_car)and(documento.id_registro=:ll_id_reg_car);
	if IsNull(ll_num_prog) then 
		ll_num_prog=1
	else
		ll_num_prog++
	end if
	insert into documento (documento.id_prof_documento, documento.id_registro, documento.num_progressivo, documento.data_registrazione,
								documento.id_sog_commerciale, documento.id_valuta, documento.id_caus_magazzino, 
								documento.id_locazione_1
								,documento.data_documento, documento.num_documento,	
								documento.tipo_fattura	
								) 
	values (:ll_id_prof_car, :ll_id_reg_car, :ll_num_prog, :ld_data_reg, :ll_id_sog_com, :ll_id_valuta, :ll_id_caus_car, :ll_id_locazione
			, :ld_data_reg, :ll_num_prog,		
			'N'	
			); 

	if sqlca.sqlcode<>0 then
		messagebox("Errore", "Documento di carico non creato")
		errore=true		
		rollback;
	else
		commit;
	end if
	select Max(id_documento)
	into :ll_id_doc
	from documento;

	
	il_id_doc_car=ll_id_doc

	ll_id_art=tab_1.tabpage_1.dw_genera_lotto_ff.GetItemNumber(1,"id_articolo")
	ld_quantita=tab_1.tabpage_1.dw_genera_lotto_ff.GetItemDecimal(1,"lotto_qta_iniziale")
	ls_cod_lotto=tab_1.tabpage_1.dw_genera_lotto_ff.GetItemString(1,"cod_esterno")
	ls_des_art=tab_1.tabpage_1.dw_genera_lotto_ff.GetItemString(1,"descrizione")
	
	
	if (ic_tipo_ges_lotti = 'G') then	
		ld_peso_netto=tab_1.tabpage_1.dw_genera_lotto_ff.GetItemDecimal(1,"lotto_peso_netto_iniziale")
	end if
	
	
	
	
	ll_id_lotto = tab_1.tabpage_1.dw_genera_lotto_ff.GetItemnumber(1,"id_lotto")
		
	
	
	
	
	
	
	
	select prog_materie_prime
	into :ll_id_r_lotto
	from prog_lotti;
	ll_id_r_lotto++
	update prog_lotti
	set prog_materie_prime = :ll_id_r_lotto;
	
	
	select id_unita_confezione
	into :ll_id_u_conf
	from unita_confezione
	where (unita_confezione.id_articolo=:ll_id_art)and(unita_confezione.unita_base='S');
	
	
	if (ic_tipo_ges_lotti = 'G') then
		
		ll_id_tab_iva = 0;
		ll_id_tab_iva_2 = 0;
		SELECT a.id_tab_iva, c.id_tab_iva
		INTO	 :ll_id_tab_iva, :ll_id_tab_iva_2
		FROM	 articolo a, cat_com_articolo c
		WHERE  a.id_articolo = :ll_id_art
		AND	 c.id_cat_com_articolo = a.id_cat_com_articolo
		;
		if (SQLCA.SQLCODE = -1) then messagebox("DbError", SQLCA.SQLERRTEXT)

		if (isnull(ll_id_tab_iva) or ll_id_tab_iva >= 0) then
			if (ll_id_tab_iva_2 >= 0) then ll_id_tab_iva = ll_id_tab_iva_2
		end if
		

		

		SELECT m.tipo
		INTO	 :ls_tipo_mov
		FROM	 unita_confezione u, unita_misura m
		WHERE  m.id_unita_misura = u.id_unita_misura
		AND	 u.id_articolo = :ll_id_art
		AND	 u.unita_base = 'S'
		;
		
		ld_prezzo_lotto = tab_1.tabpage_2.dw_art_lotto_ext.GetItemNumber(1,"tot_prezzo_netto")
		
		if (ls_tipo_mov = 'P') then
			ld_prezzo_lotto = ld_prezzo_lotto / ld_peso_netto
		else
			ld_prezzo_lotto = ld_prezzo_lotto / ld_quantita			
		end if
		
		
		
		
		if (ls_tipo_mov = 'P') then
			ld_tot_riga_val_doc = ld_prezzo_lotto * ld_peso_netto
		else
			ld_tot_riga_val_doc = ld_prezzo_lotto * ld_quantita
		end if
		
		SELECT per_aliquota
		INTO	 :ld_per_aliquota
		FROM	 tab_iva
		WHERE  id_tab_iva = :ll_id_tab_iva
		;
		
		SELECT cambio
		INTO	 :ld_cambio 
		FROM	 valuta
		WHERE	 id_valuta = :ll_id_valuta
		;
		SELECT cambio
		INTO	 :ld_cambio_l
		FROM	 valuta
		WHERE	 id_valuta = :ll_id_val_lire
		;
		
		
		INSERT INTO riga_documento (id_documento, num_riga, id_valuta, 
			id_articolo, quantita, id_riga_lotto,
			descrizione, id_unita_confezione, id_locazione_1, 
			id_caus_magazzino, fat_con_unita_base,
			fat_con_globale, qta_un_base, peso_netto,
			id_tab_iva,		
			cambio, prezzo, prezzo_netto, val_attribuito,	
			tot_riga_val_riga, tot_riga_val_doc, tot_riga_val_az)		
		VALUES (:ll_id_doc, 1, :ll_id_valuta, :ll_id_art, :ld_quantita, :ll_id_r_lotto, 
			:ls_des_art, :ll_id_u_conf, :ll_id_locazione, :ll_id_caus_car, 1, 1, 
			:ld_quantita, :ld_peso_netto,
			:ll_id_tab_iva,	
			:ld_cambio, :ld_prezzo_lotto, :ld_prezzo_lotto, :ld_prezzo_lotto,	
			:ld_tot_riga_val_doc, :ld_tot_riga_val_doc, :ld_tot_riga_val_doc)						
			;
			
			if (SQLCA.SQLCODE = -1) then messagebox("DBError", SQLCA.SQLERRTEXT)
	else
		insert into riga_documento (riga_documento.id_documento, riga_documento.num_riga, riga_documento.id_valuta, 
										riga_documento.id_articolo, riga_documento.quantita, riga_documento.id_riga_lotto,
										riga_documento.descrizione, riga_documento.id_unita_confezione, riga_documento.id_locazione_1, 
										riga_documento.id_caus_magazzino, riga_documento.fat_con_unita_base,
										riga_documento.fat_con_globale, riga_documento.qta_un_base)
		values (:ll_id_doc, 1, :ll_id_valuta, :ll_id_art, :ld_quantita, :ll_id_r_lotto, :ls_des_art, 
					:ll_id_u_conf, :ll_id_locazione, :ll_id_caus_car, 1, 1, :ld_quantita);
	end if
	if sqlca.sqlcode<>0 then
		messagebox("Errore", "Riga_documento di carico non creato")
		errore=true		
		rollback;
	else
		commit;
		
		
		if (ll_id_valuta = ll_id_val_lire) then
			ld_tot_riga_val_doc_l = ld_tot_riga_val_doc
		else
			ld_tot_riga_val_doc_l = ld_tot_riga_val_doc * ld_cambio / ld_cambio_l
		end if
		
		if (ll_id_tab_iva > 0 and SQLCA.SQLCODE = 0) and (ic_tipo_ges_lotti = 'G') then
			INSERT INTO cast_iva_documento (id_documento, id_tab_iva, val_imponibile,
							val_imp_scontato, val_tot_imp_v, val_tot_imp_l, val_tot_iva_v,
							val_tot_iva_l)
			VALUES (:ll_id_doc, :ll_id_tab_iva, :ld_tot_riga_val_doc, 
							:ld_tot_riga_val_doc, :ld_tot_riga_val_doc,
							:ld_tot_riga_val_doc_l, (:ld_tot_riga_val_doc * :ld_per_aliquota / 100),
							(:ld_tot_riga_val_doc_l * :ld_per_aliquota / 100)										
			)
			;
			if (SQLCA.SQLCODE <> 0) then
				messagebox("DBError", SQLCA.SQLERRTEXT)
				rollback;
			else
				commit;
			end if
		end if
		
		
		insert into riga_doc_lotto (riga_doc_lotto.id_riga_lotto, riga_doc_lotto.id_lotto, riga_doc_lotto.valore_scarico, riga_doc_lotto.id_doc)
		values (:ll_id_r_lotto, :ll_id_lotto, 0, :ll_id_doc);
		if sqlca.sqlcode<>0 then
			messagebox("Errore", sqlca.sqlerrtext)
			rollback;
		else
			commit;
		end if
	end if
	
	salvato=not(errore)
end subroutine

public subroutine wf_cancella_doc ();integer li_ret
s_par_record lstr_par_documento

lstr_par_documento.nome_tabella="documento" 
lstr_par_documento.nome_id_tabella="id_documento"
lstr_par_documento.id_tabella=il_id_doc_car
lstr_par_documento.visible=false
openwithparm(w_utl_cancella_documento_wz,lstr_par_documento)
li_ret=message.doubleparm

if li_ret<>1 then
	messagebox('Attenzione!','Impossibile cancellare il documento di carico del lotto produzione!')
end if

lstr_par_documento.nome_tabella="documento" 
lstr_par_documento.nome_id_tabella="id_documento"
lstr_par_documento.id_tabella=il_id_doc_scar
lstr_par_documento.visible=false
openwithparm(w_utl_cancella_documento_wz,lstr_par_documento)
li_ret=message.doubleparm

if li_ret<>1 then
	messagebox('Attenzione!','Impossibile cancellare il documento di scarico del lotto produzione!')
end if
end subroutine

public subroutine wf_errore (string as_msg);messagebox('Errore!', 'Impossibile trovare '+as_msg)
end subroutine

public subroutine wf_mp_necessarie ();
integer li_rows, li_i
decimal ld_qta_nec, ld_peso_nec, ld_peso_dis, ld_peso_prod, ld_peso_mp
string ls_cod_padre

if generato=true then return

li_rows = tab_1.tabpage_2.dw_art_lotto_ext.rowcount()

if (li_rows <= 0) then  return

ls_cod_padre = tab_1.tabpage_1.dw_genera_lotto_ff.getitemstring(1, "codice")

SELECT peso_netto
INTO	 :ld_peso_dis
FROM   distinta
WHERE  codice = :ls_cod_padre
;

for li_i = 1 to li_rows
	ld_qta_nec = tab_1.tabpage_2.dw_art_lotto_ext.getitemdecimal(1,"n_art")*tab_1.tabpage_2.dw_art_lotto_ext.getitemdecimal(li_i,"quantita")
	
	if (ic_tipo_ges_lotti = 'G') then
		
		ld_peso_prod = tab_1.tabpage_1.dw_genera_lotto_ff.getitemnumber(1,"lotto_peso_netto_da_lav")
		if (ld_peso_prod = 0 or isnull(ld_peso_prod)) then	ld_peso_prod = tab_1.tabpage_1.dw_genera_lotto_ff.getitemnumber(1,"lotto_peso_netto_iniziale")
		
		ld_peso_mp = tab_1.tabpage_2.dw_art_lotto_ext.getitemnumber(li_i,"peso_netto")	
		if (ld_peso_dis > 0) then
			ld_peso_nec = ld_peso_mp * ld_peso_prod / ld_peso_dis
		else
			ld_peso_nec = ld_peso_prod * ld_peso_mp
		end if
		
		tab_1.tabpage_2.dw_art_lotto_ext.object.peso_netto[li_i] = ld_peso_nec	
	end if
	tab_1.tabpage_2.dw_art_lotto_ext.object.quantita[li_i] = ld_qta_nec
next

end subroutine

public subroutine wf_lotti_mp_necessari ();string cod_art, ls_find, ls_num_lotto_produzione, LS_DATA_SCADENZA
long ll_riga, nr=1,nrig,i,id_lotto, id_art, qta_iniz,  ls_num_lotto,ll_num_lotto_prod,ll_riga_1
decimal{4} qta_scaricata, qta_iniziale,numnec, qta_disponibile
date dat

string n_lotto, ls_cod_esterno, ls_des 
date data_scad
string cod

decimal peso_mp, peso_nec, peso_iniziale, peso_scaricato
decimal peso_disponibile, peso_iniz
string ls_tipo
char   lc_confronto_data_scadenza 


if generato=false then
nrig=tab_1.tabpage_2.dw_art_lotto_ext.rowcount()
ls_num_lotto_produzione=tab_1.tabpage_2.dw_art_lotto_ext.getitemstring(1,"num_lotto_prod")
LS_DATA_SCADENZA=STRING(tab_1.tabpage_1.dw_genera_lotto_ff.getitemdate(1, "LOTTO_data_scadenza"), "dd/mm/yy")

for i=1 to nrig 
	id_art=tab_1.tabpage_2.dw_art_lotto_ext.getitemnumber(nr,"id_articolo")
	
	
	numnec=tab_1.tabpage_2.dw_art_lotto_ext.getitemdecimal(nr,"quantita")
	
	
	
	
	if (ic_tipo_ges_lotti = 'G') then 
		peso_mp = tab_1.tabpage_2.dw_art_lotto_ext.getitemnumber(nr,"peso_netto")
		
		
		peso_nec = tab_1.tabpage_2.dw_art_lotto_ext.getitemdecimal(nr,"peso_netto")
	end if
	
	
   SELECT tipo
   INTO	 :ls_tipo
	FROM	 unita_confezione u, unita_misura m
	WHERE  u.id_articolo = :id_art
	AND	 u.unita_base = 'S'
	AND    m.id_unita_misura =* u.id_unita_misura
	;
	
	
	
	if (ic_tipo_ges_lotti = 'G') then
		SELECT confronto_data_scadenza
		INTO	 :lc_confronto_data_scadenza
		FROM	 prog_lotti
		;

		
		if (lc_confronto_data_scadenza = 'P') then ls_data_scadenza = string(tab_1.tabpage_1.dw_genera_lotto_ff.getitemdate(1, "data_doc"), "dd/mm/yy")
	end if
	

	if (ic_tipo_ges_lotti = 'G') and (ls_tipo = 'P') then
		
		
		do while peso_nec > 0
			
			
			
			
			
			
			ls_find="id_articolo ="+ string(id_art) +" and peso_netto_iniziale > if(isnull(peso_netto_scaricato),0, peso_netto_scaricato)"&
				+" and data_scadenza >= DATE('"+LS_DATA_SCADENZA+"')"&
				+ "and (tipo_lotto='M' or tipo_lotto='S' or tipo_lotto='Z' or tipo_lotto='K')" 

			ll_riga=ds_lotto.RowCount( )
			
			ll_riga = ds_lotto.Find(ls_find , 1, ll_riga)
			
			if ll_riga>0 then
			  ls_cod_esterno=ds_lotto.getitemstring(ll_riga, "cod_esterno")
			  ls_num_lotto=ds_lotto.getitemnumber(ll_riga, "numero")			  
			  qta_iniziale=ds_lotto.getitemdecimal(ll_riga, "qta_iniziale")
			  qta_scaricata=ds_lotto.getitemdecimal(ll_riga, "qta_scaricata")

			  peso_iniziale=ds_lotto.getitemdecimal(ll_riga, "peso_netto_iniziale")
			  peso_scaricato=ds_lotto.getitemdecimal(ll_riga, "peso_netto_scaricato")
			  
			  dat=ds_lotto.getitemdate(ll_riga, "data_scadenza")
			  id_lotto=ds_lotto.getitemnumber(ll_riga, "Id_lotto")
				
			
			  if isnull(peso_scaricato) then peso_scaricato=0
			  peso_disponibile = peso_iniziale - peso_scaricato
			
			
			
			
			
			
			  tab_1.tabpage_2.dw_art_lotto_ext.setitem(nr,"cod_lotto",ls_cod_esterno)
			  tab_1.tabpage_2.dw_art_lotto_ext.setitem(nr,"data_scadenza",dat)
			
			
		   tab_1.tabpage_2.dw_art_lotto_ext.setitem(nr,"id_lotto_mp",id_lotto)
			
			
			
			  IF peso_disponibile > peso_nec then  peso_disponibile = peso_nec
	
				  tab_1.tabpage_2.dw_art_lotto_ext.setitem(nr,"peso_netto",peso_disponibile)
				
	
			
				  ds_lotto.setitem(ll_riga, "peso_netto_scaricato", peso_scaricato+peso_disponibile)
				
				if peso_iniziale<= peso_scaricato+peso_disponibile then
					ds_lotto.setitem(ll_riga, "attivo", 'N')
				end if
			
				
					
				ll_riga=ds_mov_lotto.insertrow(0)
				ds_mov_lotto.setitem(ll_riga, "id_lotto", id_lotto)
				ds_mov_lotto.setitem(ll_riga, "peso_netto", peso_disponibile)
				
				ll_riga_1=tab_1.tabpage_1.dw_genera_lotto_ff.getrow()
				ll_num_lotto_prod=tab_1.tabpage_1.dw_genera_lotto_ff.getitemnumber(ll_riga_1, "lotto_numero")
				
				ds_mov_lotto.setitem(ll_riga, "num_lotto_prod", ll_num_lotto_prod)
			else
			  peso_disponibile=peso_nec
			  tab_1.tabpage_2.dw_art_lotto_ext.setitem(nr,"cod_lotto","Peso Articolo non disponibile!")
			  tab_1.tabpage_2.dw_art_lotto_ext.setitem(nr,"peso_netto", peso_disponibile)
			  tab_1.tabpage_2.dw_art_lotto_ext.setitem(nr,"id_articolo",0)
			end if	
			
			
			peso_nec = peso_nec - peso_disponibile
			
			if peso_nec > 0 then 
				nr = nr + 1
				tab_1.tabpage_2.dw_art_lotto_ext.insertrow(nr)
			
				
				n_lotto=tab_1.tabpage_2.dw_art_lotto_ext.getitemstring(nr - 1,"num_lotto_prod")
				peso_iniz=tab_1.tabpage_2.dw_art_lotto_ext.getitemdecimal(nr - 1,"peso_art")
				data_scad=tab_1.tabpage_2.dw_art_lotto_ext.getitemdate(nr - 1,"d_scad_2")
				cod=tab_1.tabpage_2.dw_art_lotto_ext.getitemstring(nr - 1,"c_testa")
				id_art=tab_1.tabpage_2.dw_art_lotto_ext.getitemNumber(nr - 1,"id_articolo")
				ls_des=tab_1.tabpage_2.dw_art_lotto_ext.getitemstring(nr - 1,"descrizione_art")
				
				tab_1.tabpage_2.dw_art_lotto_ext.setitem(nr,"num_lotto_prod",n_lotto)
				tab_1.tabpage_2.dw_art_lotto_ext.setitem(nr,"peso_art",peso_iniz)
				tab_1.tabpage_2.dw_art_lotto_ext.setitem(nr,"d_scad_2",data_scad)
				tab_1.tabpage_2.dw_art_lotto_ext.setitem(nr,"c_testa",cod)
				tab_1.tabpage_2.dw_art_lotto_ext.setitem(nr,"id_articolo",id_art)
				tab_1.tabpage_2.dw_art_lotto_ext.setitem(nr,"descrizione_art",ls_des)
	
			end if
		loop
		
	else
		
		
		do while numnec > 0
			
			
			
			
			
			ls_find="id_articolo ="+ string(id_art) +" and qta_iniziale > if(isnull(qta_scaricata),0, qta_scaricata)"&
				+" and data_scadenza >= DATE('"+LS_DATA_SCADENZA+"')"&
				+ "and (tipo_lotto='M' or tipo_lotto='S'"
			
			if (ic_tipo_ges_lotti = 'G') then
				ls_find = ls_find + " or tipo_lotto='Z' or tipo_lotto='K')"
			else
				ls_find = ls_find + ")"				
			end if
			
			
			
				
			ll_riga=ds_lotto.RowCount( )
			
			ll_riga = ds_lotto.Find(ls_find , 1, ll_riga)
			
			
			
			if ll_riga>0 then
			  ls_cod_esterno=ds_lotto.getitemstring(ll_riga, "cod_esterno")
			  ls_num_lotto=ds_lotto.getitemnumber(ll_riga, "numero")
			  qta_iniziale=ds_lotto.getitemdecimal(ll_riga, "qta_iniziale")
			  qta_scaricata=ds_lotto.getitemdecimal(ll_riga, "qta_scaricata")
			  dat=ds_lotto.getitemdate(ll_riga, "data_scadenza")
			  id_lotto=ds_lotto.getitemnumber(ll_riga, "Id_lotto")
				
			
			  if isnull(qta_scaricata) then qta_scaricata=0
			  qta_disponibile = qta_iniziale - qta_scaricata
			
			
			
			
			
			
			  tab_1.tabpage_2.dw_art_lotto_ext.setitem(nr,"cod_lotto",ls_cod_esterno)
			  tab_1.tabpage_2.dw_art_lotto_ext.setitem(nr,"data_scadenza",dat)
			
			
		   tab_1.tabpage_2.dw_art_lotto_ext.setitem(nr,"id_lotto_mp",id_lotto)
			
			
			
			  IF qta_disponibile > numnec then  qta_disponibile = numnec
	
				  tab_1.tabpage_2.dw_art_lotto_ext.setitem(nr,"quantita",qta_disponibile)
				
	
			
				  ds_lotto.setitem(ll_riga, "qta_scaricata", qta_scaricata+qta_disponibile)
				
				if qta_iniziale<= qta_scaricata+qta_disponibile then
					ds_lotto.setitem(ll_riga, "attivo", 'N')
				end if
			
				
	
					
				ll_riga=ds_mov_lotto.insertrow(0)
				ds_mov_lotto.setitem(ll_riga, "id_lotto", id_lotto)
				ds_mov_lotto.setitem(ll_riga, "quantita", qta_disponibile)
				
				ll_riga_1=tab_1.tabpage_1.dw_genera_lotto_ff.getrow()
				ll_num_lotto_prod=tab_1.tabpage_1.dw_genera_lotto_ff.getitemnumber(ll_riga_1, "lotto_numero")
				
				ds_mov_lotto.setitem(ll_riga, "num_lotto_prod", ll_num_lotto_prod)
			else
			  qta_disponibile=numnec
			  tab_1.tabpage_2.dw_art_lotto_ext.setitem(nr,"cod_lotto","Articolo non disponibile!")
			  tab_1.tabpage_2.dw_art_lotto_ext.setitem(nr,"quantita",qta_disponibile)
			  tab_1.tabpage_2.dw_art_lotto_ext.setitem(nr,"id_articolo",0)
			end if	
			
			
			numnec = numnec - qta_disponibile
			
			if numnec > 0 then 
				nr = nr + 1
				tab_1.tabpage_2.dw_art_lotto_ext.insertrow(nr)
			
				
				n_lotto=tab_1.tabpage_2.dw_art_lotto_ext.getitemstring(nr - 1,"num_lotto_prod")
				qta_iniz=tab_1.tabpage_2.dw_art_lotto_ext.getitemdecimal(nr - 1,"n_art")
				data_scad=tab_1.tabpage_2.dw_art_lotto_ext.getitemdate(nr - 1,"d_scad_2")
				cod=tab_1.tabpage_2.dw_art_lotto_ext.getitemstring(nr - 1,"c_testa")
				id_art=tab_1.tabpage_2.dw_art_lotto_ext.getitemNumber(nr - 1,"id_articolo")
				ls_des=tab_1.tabpage_2.dw_art_lotto_ext.getitemstring(nr - 1,"descrizione_art")
				
				tab_1.tabpage_2.dw_art_lotto_ext.setitem(nr,"num_lotto_prod",n_lotto)
				tab_1.tabpage_2.dw_art_lotto_ext.setitem(nr,"n_art",qta_iniz)
				tab_1.tabpage_2.dw_art_lotto_ext.setitem(nr,"d_scad_2",data_scad)
				tab_1.tabpage_2.dw_art_lotto_ext.setitem(nr,"c_testa",cod)
				tab_1.tabpage_2.dw_art_lotto_ext.setitem(nr,"id_articolo",id_art)
				tab_1.tabpage_2.dw_art_lotto_ext.setitem(nr,"descrizione_art",ls_des)
	
			end if
		loop
		
	end if
	
	nr = nr + 1
next
generato = true
end if

for i = 1 to tab_1.tabpage_2.dw_art_lotto_ext.rowcount()
	id_art=tab_1.tabpage_2.dw_art_lotto_ext.getitemnumber(i, "id_articolo")
	if id_art<1 then 
		tab_1.tabpage_2.dw_art_lotto_ext.modify("num_lotto_prod.color=16777215")
		exit
	end if
next
end subroutine

on w_genera_lotto_cx.create
int iCurrent
call super::create
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_preview=create cb_preview
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_5
this.Control[iCurrent+2]=this.cb_4
this.Control[iCurrent+3]=this.cb_3
this.Control[iCurrent+4]=this.cb_preview
this.Control[iCurrent+5]=this.cb_2
end on

on w_genera_lotto_cx.destroy
call super::destroy
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_preview)
destroy(this.cb_2)
end on

event open;call super::open;idw_master = tab_1.tabpage_1.dw_genera_lotto_ff
idw_master.is_list = Message.PowerObjectParm
if Upperbound(idw_master.is_list.s_identifica)=0 then
	idw_master.ias_key_name[1] = "id_lotto"
	idw_master.is_list.s_modo=modo_inserisci
end if
idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_sql_ident[1] = "lotto_id_lotto"




ds_lotto= create datastore
ds_mov_lotto= create datastore

ds_lotto.dataobject="ds_lotto"
ds_mov_lotto.dataobject="d_mov_lotto_ds"
ds_lotto.settransobject(SQLCA)
ds_mov_lotto.settransobject(SQLCA)

	
	
end event

event close;
destroy ds_lotto
destroy ds_mov_lotto



end event

event closequery;integer li_ync,ret, i

string ls_find, pippo
long ll_riga, ll_esercizio
ls_find="id_articolo =0"
ll_riga=tab_1.tabpage_2.dw_art_lotto_ext.RowCount( )
date ld_data



if commerciale then return 0

for i= 1 to tab_1.tabpage_2.dw_art_lotto_ext.rowcount()
	if tab_1.tabpage_2.dw_art_lotto_ext.getitemnumber(i, "id_articolo") =0 then
		generato=false
		exit
	end if
next

if generato=false then 
	li_ync=messagebox("Generazione Lotti","Il lotto non è stato generato. Esci senza salvare?", information!, yesno!)
   if li_ync=1 then
		return 0
	else	
      return 1
   end if
end if
		


ll_riga = tab_1.tabpage_2.dw_art_lotto_ext.Find(ls_find , 1, ll_riga)

if ll_riga>0 then	
  li_ync=messagebox("Errore","Il lotto non può essere creato ~r~n"+&
  "non ci sono sufficienti articoli in magazzino.~r~n Esci senza salvare?",stopsign!,yesno!)
  if li_ync=1 then 
    return 0
  else
	 return 1 
  end if
end if

li_ync = MessageBox(idw_master.is_title, "Ci sono modifiche non salvate nella " + &
  "finestra.~n~rVuoi salvarle?", Question!, YesNoCancel!)
IF (li_ync=1) THEN
   if ((ds_lotto.ModifiedCount() + ds_lotto.DeletedCount()) > 0) then 
	
		ret=ds_lotto.update()
		if ret=-1 then messagebox("Errore","ds_lotto non salvata",stopsign!,ok!)
	
	end if
   if ((ds_mov_lotto.ModifiedCount() + ds_mov_lotto.DeletedCount()) > 0) then 
		
		ret=ds_mov_lotto.update()
		if ret=-1 then messagebox("Errore","ds_mov_lotto non salvata",stopsign!,ok!)
		
   end if
   if ((tab_1.tabpage_1.dw_genera_lotto_ff.ModifiedCount() + tab_1.tabpage_1.dw_genera_lotto_ff.DeletedCount()) > 0) then 
		
		ret=tab_1.tabpage_1.dw_genera_lotto_ff.update()
		if ret=-1 then messagebox("Errore","dw_genera_lotto_ff non salvata",stopsign!,ok!)
		
   end if



	
	string ls_data
	decimal{4}  ld_qta_car, qta_usata
	long id_articolo,id_Articolo_base, id_art_temp
	integer li_num_righe
	i=0
	decimal{0} ls_anno, ls_mese
	ll_riga=tab_1.tabpage_1.dw_genera_lotto_ff.getrow()
	ls_data=string(tab_1.tabpage_1.dw_genera_lotto_ff.getitemdate(ll_riga, "data_doc"), "dd/mm/yyyy")
	ls_anno=dec(right(ls_data, 4))
	ls_mese= dec(mid(ls_data, 4, 2))

	li_num_righe=tab_1.tabpage_2.dw_art_lotto_ext.rowcount()
	id_articolo_base=0
	
	for i = 1 to li_num_righe
		
		id_art_temp=tab_1.tabpage_2.dw_art_lotto_ext.getitemnumber(i, "id_articolo")
		if id_art_temp<1  or isnull(id_art_temp) then
			id_art_temp=tab_1.tabpage_2.dw_art_lotto_ext.getitemnumber(i -1, "id_articolo")
		end if
		ld_data=date(ls_data)
		
		select id_esercizio
			into :ll_esercizio
		from esercizio
		where data_inizio <= :ld_data 
		and data_fine >= :ld_data;
		if sqlca.sqlcode <> 0 then 
			messagebox("Attenzione!", "Non è stato rilevato nessun esercizio"&
			+"per questo documento.~r~n O è errata la data del documento o non è stato"&
			+"definito un esercizio apposito.~r~n Provvedere e ripetere l'operazione.",&
			stopsign!)
			return
		end if
		
		
		qta_usata=tab_1.tabpage_2.dw_art_lotto_ext.getitemdecimal(i, "quantita")
		if isnull(qta_usata) then qta_usata=0
		
		update riepilogo
		set qta_scaricata= qta_scaricata + :qta_usata
		where (id_articolo= :id_art_temp) 
		and (anno=:ls_anno) 
		and (id_locazione=1)
		and (mese=:ls_mese);
				
		if sqlca.sqlcode=-1 then 
			messagebox("Errore!", sqlca.sqlerrtext)
			return
		else
			commit;
		end if
	next
	id_articolo= tab_1.tabpage_1.dw_genera_lotto_ff.getitemnumber(ll_riga, "id_articolo")
	ld_qta_car=tab_1.tabpage_1.dw_genera_lotto_ff.getitemdecimal(ll_riga, "lotto_qta_iniziale")
	
	
	insert into riepilogo
	(id_esercizio, id_attivita, id_articolo, id_locazione, anno, mese, qta_caricata, id_azienda)
	values
	(:ll_esercizio, 1,  :id_articolo, 2, :ls_anno, :ls_mese, :ld_qta_car, 1);
	
	if sqlca.sqlcode<>0 then
		
		update riepilogo
		set qta_caricata =qta_caricata + :ld_qta_car,
		id_esercizio=:ll_esercizio
		where (id_articolo=:id_articolo) and
		(id_locazione=2) and (mese=:ls_mese)and (anno=:ls_anno);
		IF sqlca.sqlcode= -1 THEN 
			MESSAGEBOX("Errore!", sqlca.sqlerrtext)
		end if
	end if	
	
	return 0
ELSEIF(li_ync=2) then
  	return 0
ELSE
   return 1
END IF





end event

event ue_post_open;call super::ue_post_open;long ll_riga
string testo
select testo_modulo
into :testo
from prog_lotti;
ll_riga= tab_1.tabpage_1.dw_genera_lotto_ff.getrow()
tab_1.tabpage_1.dw_genera_lotto_ff.setitem(ll_riga, "modulo", testo)

char lc_commerciale

select commerciale
into :lc_commerciale
from par_sistema;
if lc_commerciale='S' then 
	commerciale=true
	Close(this)
end if

SELECT tipo_ges_lotti
INTO	 :ic_tipo_ges_lotti
FROM	 pers_par_sistema
;

if (ic_tipo_ges_lotti = 'G') then 
	tab_1.tabpage_1.dw_genera_lotto_ff.setitem(ll_riga, "sterilizza", "N")
	tab_1.tabpage_1.dw_genera_lotto_ff.object.sterilizza.visible=0
	tab_1.tabpage_2.dw_art_lotto_ext.dataobject='d_lotto_peso_ext_ff'
end if
end event

type p_crescente from w_p_data`p_crescente within w_genera_lotto_cx
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_genera_lotto_cx
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_genera_lotto_cx
int X=37
int Y=32
boolean BringToTop=true
end type

event cb_ok::clicked;long ll_row, ll_id
string s_col_name
integer li_counter
if (ic_tipo_ges_lotti = 'G') then
	integer li_numero, li_row
	long	  ll_id_lotto = 0
	
	li_row = tab_1.tabpage_1.dw_genera_lotto_ff.getrow()
	li_numero = tab_1.tabpage_1.dw_genera_lotto_ff.getitemnumber(li_row, "lotto_numero")
	
	SELECT id_lotto
	INTO	 :ll_id_lotto
	FROM	 lotto
	WHERE  numero = :li_numero
	;
	
	if ll_id_lotto <= 0 and generato = TRUE then cb_salva.trigger event clicked()
end if
parent.TriggerEvent("ue_close")

end event

type cb_annulla from w_p_data`cb_annulla within w_genera_lotto_cx
int X=329
int Y=32
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_genera_lotto_cx
int X=622
int Y=32
boolean BringToTop=true
end type

event cb_nuovo::clicked;integer li_ync,ret

string ls_find, testo
long ll_riga, ll_riga_1, ll_riga2
long ll_tv1
		

ll_tv1=tab_1.tabpage_1.tv_1.finditem(roottreeitem!, 0)
tab_1.tabpage_1.tv_1.deleteitem(ll_tv1)

if generato=false then 
	li_ync=messagebox("Errore","Il lotto non è stato generato.~r~n"+&
	"Continuare senza salvare le ultime modifiche? ",stopsign!,yesno!)
   if li_ync=1 then
	   tab_1.tabpage_2.dw_art_lotto_ext.reset()
		
		
		
      parent.TriggerEvent("ue_insert_mode")
      idw_master.SetFocus()
		tab_1.selecttab(1)
		return
   else	
      return 
   end if
end if
		

ls_find="id_articolo =0"
ll_riga=tab_1.tabpage_2.dw_art_lotto_ext.RowCount( )
ll_riga = tab_1.tabpage_2.dw_art_lotto_ext.Find(ls_find , 1, ll_riga)

if ll_riga>0 then	
  li_ync=messagebox("Errore","Il lotto non può essere creato ~r~n"+&
  "non ci sono sufficienti articoli in magazzino.~r~n"+&
  "Continuare senza salvare le ultime modifiche?",stopsign!,yesno!)
  if li_ync=1 then 
    tab_1.tabpage_2.dw_art_lotto_ext.reset()
	 
		
		
    parent.TriggerEvent("ue_insert_mode")
    idw_master.SetFocus()
    tab_1.selecttab(1)
    return
  else
	 return 
  end if
end if

li_ync=messagebox("Attenzione","Salvare le ultime modifiche?",exclamation!,yesnocancel!)
if li_ync=1 then
  if ((ds_lotto.ModifiedCount() + ds_lotto.DeletedCount()) > 0) then 
	 ret=ds_lotto.update()
	 if ret=-1 then messagebox("Errore","ds_lotto non salvata",stopsign!,ok!)
  end if
  if ((ds_mov_lotto.ModifiedCount() + ds_mov_lotto.DeletedCount()) > 0) then 
	  ret=ds_mov_lotto.update()
     if ret=-1 then messagebox("Errore","ds_mov_lotto non salvata",stopsign!,ok!)
  end if
  if ((tab_1.tabpage_1.dw_genera_lotto_ff.ModifiedCount() + tab_1.tabpage_1.dw_genera_lotto_ff.DeletedCount()) > 0) then 
  	  ret=tab_1.tabpage_1.dw_genera_lotto_ff.update()
	  if ret=-1 then messagebox("Errore","dw_genera_lotto_ff non salvata",stopsign!,ok!)
  end if
					
string ls_data
decimal{4}  ld_qta_car, qta_usata
long id_articolo,id_Articolo_base, id_art_temp
integer li_num_righe, i,ls_anno, ls_mese


li_num_righe=tab_1.tabpage_2.dw_art_lotto_ext.rowcount()
id_articolo_base=0
for i = 1 to li_num_righe
	id_art_temp=tab_1.tabpage_2.dw_art_lotto_ext.getitemnumber(i, "id_articolo")
	if id_art_temp<1  or isnull(id_art_temp) then
		id_art_temp=tab_1.tabpage_2.dw_art_lotto_ext.getitemnumber(i -1, "id_articolo")
	end if
		qta_usata=tab_1.tabpage_2.dw_art_lotto_ext.getitemdecimal(i, "quantita")
		if isnull(qta_usata) then qta_usata=0
		update riepilogo
		set qta_scaricata= qta_scaricata + :qta_usata
		where id_articolo= :id_art_temp;
	if sqlca.sqlcode<> 0 then 
		messagebox("Errore!", "Non si è aggiornata la quantità"+&
	"~r~nscaricata in uno o più elementi di base")
		return
	end if

next
	
commit;




ll_riga=tab_1.tabpage_1.dw_genera_lotto_ff.getrow()
id_articolo= tab_1.tabpage_1.dw_genera_lotto_ff.getitemnumber(ll_riga, "id_articolo")
ld_qta_car=tab_1.tabpage_1.dw_genera_lotto_ff.getitemdecimal(ll_riga, "lotto_qta_iniziale")
ls_data=string(today(), "dd/mm/yyyy")
ls_anno=dec(right(ls_data, 4))
ls_mese= dec(mid(ls_data, 4, 2))



insert into riepilogo
(id_esercizio, id_attivita, id_articolo, id_locazione, anno, mese, qta_caricata, id_azienda)
values
(2, 1,  :id_articolo, 2, :ls_anno, :ls_mese, :ld_qta_car, 1);
if sqlca.sqlcode<>0 then
	update riepilogo
	set qta_caricata =qta_caricata + :ld_qta_car
	where id_articolo=:id_articolo;
end if
	





	
elseif li_ync=3 then
	return
else
end if

tab_1.tabpage_2.dw_art_lotto_ext.reset()

		
      
      
		
parent.TriggerEvent("ue_insert_mode")
idw_master.SetFocus()
tab_1.selecttab(1)

			select testo_modulo
			into :testo
			from prog_lotti;
			ll_riga2= tab_1.tabpage_1.dw_genera_lotto_ff.getrow()
			tab_1.tabpage_1.dw_genera_lotto_ff.setitem(ll_riga2, "modulo", testo)
			




end event

type cb_inserisci from w_p_data`cb_inserisci within w_genera_lotto_cx
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_genera_lotto_cx
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_genera_lotto_cx
int X=2962
int Y=32
boolean BringToTop=true
end type

event cb_salva::clicked;string ls_find
long ll_riga, i

if generato=false then 
	messagebox("Errore","Il lotto non è stato generato",stopsign!,ok!)
	return
end if
ls_find="id_articolo =0"
ll_riga=tab_1.tabpage_2.dw_art_lotto_ext.RowCount( )
		
ll_riga = tab_1.tabpage_2.dw_art_lotto_ext.Find(ls_find , 1, ll_riga)

if ll_riga>0 then
	messagebox("Errore","Il lotto non può essere creato ~r~n non ci sono sufficienti articoli in magazzino",stopsign!,ok!)
else
	integer ll_ret 
	ll_ret = ds_lotto.update()
	ll_ret = ds_mov_lotto.update()

	parent.TriggerEvent("ue_update")

	if not salvato then 
		wf_genera_doc()
	elseif messagebox('Attenzione!','Il lotto è già stato salvato. Salvare nuovamente?',Information!,YesNo!)=1 then
		wf_cancella_doc()
		wf_genera_doc()
	end if
end if

end event

type tab_1 from w_p_data`tab_1 within w_genera_lotto_cx
event create ( )
event destroy ( )
int X=37
int Y=188
int Width=3186
int Height=1192
int TabOrder=10
boolean BringToTop=true
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_2=create tabpage_2
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_2
end on

on tab_1.destroy
call super::destroy
destroy(this.tabpage_2)
end on

event tab_1::selectionchanging;call super::selectionchanging;
long ll_riga
string n_lotto,cod, descr_art_lotto_prod, ls_modulo
decimal{4} qta_iniz
date data_scad, ldt_data_doc

long ll_id_articolo, ll_row
string ls_tipo, ls_simbolo
decimal {4} ld_peso_netto

tab_1.tabpage_1.dw_genera_lotto_ff.accepttext()
if ((oldindex=1)and(newindex=2)) and (generato=false) then
	
	
	
	
	
	string ls_select, ls_cod_distinta
	ls_cod_distinta = tab_1.tabpage_1.dw_genera_lotto_ff.getitemstring(1, "codice")
	ls_select = ds_lotto.Object.DataWindow.Table.select

	
	ls_select = ls_select + &
					" WHERE lotto.id_articolo IN (SELECT id_articolo " + &
														"  FROM	 riga_distinta r " + &
														"  WHERE  id_distinta = '" + string(il_id_distinta) + "') " + &
					" ORDER BY lotto.id_articolo ASC, lotto.data_scadenza "
								 
	ds_lotto.Object.DataWindow.Table.select = ls_select

	ds_lotto.retrieve()
	

  ll_riga=tab_1.tabpage_1.dw_genera_lotto_ff.getrow()	
  ls_modulo=tab_1.tabpage_1.dw_genera_lotto_ff.getitemstring(ll_riga,"modulo")
  ldt_data_doc=tab_1.tabpage_1.dw_genera_lotto_ff.getitemdate(ll_riga,"data_doc")
  n_lotto=tab_1.tabpage_1.dw_genera_lotto_ff.getitemstring(ll_riga,"cod_esterno")
  qta_iniz=tab_1.tabpage_1.dw_genera_lotto_ff.getitemdecimal(ll_riga,"lotto_qta_iniziale")
  
  ld_peso_netto = tab_1.tabpage_1.dw_genera_lotto_ff.getitemnumber(ll_riga,"lotto_peso_netto_iniziale")
  
  data_scad=tab_1.tabpage_1.dw_genera_lotto_ff.getitemdate(ll_riga,"lotto_data_scadenza")
  cod=tab_1.tabpage_1.dw_genera_lotto_ff.getitemstring(ll_riga,"codice")
  descr_art_lotto_prod=tab_1.tabpage_1.dw_genera_lotto_ff.getitemstring(ll_riga,"descrizione")
  
  
  if((isnull(n_lotto))or(n_lotto="")) then 
    messagebox("Errore","Numero lotto non specificato",stopsign!,ok!)
    return 1
  end if
  if isnull(qta_iniz) then 
    messagebox("Errore","Quantità iniziale non specificata",stopsign!,ok!)
    return 1
  end if
  if isnull(data_scad) then 
    messagebox("Errore","Data scadenza non specificata",stopsign!,ok!)
    return 1
  end if
  if isnull(ldt_data_doc) then 
    messagebox("Errore","Data documento non specificata",stopsign!,ok!)
    return 1
  end if
  if isnull(ls_modulo) then 
    messagebox("Errore","Modulo non specificato",stopsign!,ok!)
    return 1
  end if

	
	
	
	
	
	
	long ll_root,n_rig,i,cont
	decimal c,c1
	DECIMAL{4} q, pn
	dati dat
	treeviewitem tvi
	string ts,rg
	
	n_rig=tab_1.tabpage_2.dw_art_lotto_ext.rowcount()
	if n_rig>0 then
		do while (n_rig<>-1) and (isnull(n_rig)=false)  
			n_rig=tab_1.tabpage_2.dw_art_lotto_ext.deleterow(1)
		loop
	end if
	ll_root=tab_1.tabpage_1.tv_1.finditem(RootTreeItem!,0)
	ll_root=tab_1.tabpage_1.tv_1.finditem(ChildTreeItem!,ll_root)
	do while ll_root<> -1 
		tab_1.tabpage_1.tv_1.getitem(ll_root,tvi)
		rg=tvi.label
		dat=tvi.data
		n_rig=tab_1.tabpage_2.dw_art_lotto_ext.rowcount()
		if n_rig>0 then
			cont=tab_1.tabpage_2.dw_art_lotto_ext.find("cod_art='"+rg+"'",1,n_rig)
			if isnull(cont) then
				cont=0
			end if
		END IF
		if cont<>0 then
			tab_1.tabpage_2.dw_art_lotto_ext.setitem(cont,"cod_art",rg)
	
			q=tab_1.tabpage_2.dw_art_lotto_ext.getitemdecimal(cont,"quantita")
			q=q+dat.quantita
			tab_1.tabpage_2.dw_art_lotto_ext.setitem(cont,"quantita",q)
			
			
			if (ic_tipo_ges_lotti = 'G') then
				pn=tab_1.tabpage_2.dw_art_lotto_ext.getitemdecimal(cont,"peso_netto")
				pn=pn+dat.peso_netto
				tab_1.tabpage_2.dw_art_lotto_ext.setitem(cont,"peso_netto",pn)			
			end if
			
		
		tab_1.tabpage_2.dw_art_lotto_ext.setitem(cont,"descrizione_art",dat.descrizione)
			
	
	
	
	
		else
			tab_1.tabpage_2.dw_art_lotto_ext.insertrow(1)
	
			cont=1
			tab_1.tabpage_2.dw_art_lotto_ext.setitem(cont,"cod_art",rg)
			
			q=dat.quantita
			tab_1.tabpage_2.dw_art_lotto_ext.setitem(cont,"quantita",q)
			
			
			if (ic_tipo_ges_lotti = 'G') then
				pn=dat.peso_netto
				tab_1.tabpage_2.dw_art_lotto_ext.setitem(cont,"peso_netto",pn)
			end if
			
			
			tab_1.tabpage_2.dw_art_lotto_ext.setitem(cont,"id_articolo",dat.id_articolo)
			
			tab_1.tabpage_2.dw_art_lotto_ext.setitem(cont,"descrizione_art",dat.descrizione)
			
	
	
		end if
		ll_root=tab_1.tabpage_1.tv_1.finditem(nextTreeItem!,ll_root)
	
	loop
	tab_1.tabpage_2.dw_art_lotto_ext.insertrow(1)
	cont=1
	ll_root=tab_1.tabpage_1.tv_1.finditem(RootTreeItem!,0)
	tab_1.tabpage_1.tv_1.getitem(ll_root,tvi)
	ts=tvi.label
	tab_1.tabpage_2.dw_art_lotto_ext.setitem(cont,"cod_art",ts)
	n_rig=tab_1.tabpage_2.dw_art_lotto_ext.rowcount()
	if n_rig>0 then
		c=0
		for i=2 to n_rig
	
	
		next
	END IF
	
	tab_1.tabpage_2.dw_art_lotto_ext.setitem(1,"quantita",1)
	
	
	if (ic_tipo_ges_lotti = 'G') then tab_1.tabpage_2.dw_art_lotto_ext.setitem(1,"peso_netto",0)
	
		
	
	
	
	tab_1.tabpage_2.dw_art_lotto_ext.deleterow(1)
   
	long nrg
	nrg=tab_1.tabpage_2.dw_art_lotto_ext.rowcount()
   for ll_riga=1 to nrg 	
		tab_1.tabpage_2.dw_art_lotto_ext.setitem(ll_riga,"num_lotto_prod",n_lotto)
		tab_1.tabpage_2.dw_art_lotto_ext.setitem(ll_riga,"n_art",qta_iniz)
		tab_1.tabpage_2.dw_art_lotto_ext.setitem(ll_riga,"d_scad_2",data_scad)
		tab_1.tabpage_2.dw_art_lotto_ext.setitem(ll_riga,"c_testa",cod)
		tab_1.tabpage_2.dw_art_lotto_ext.setitem(ll_riga,"desc_art_lotto_prod", descr_art_lotto_prod)
		tab_1.tabpage_2.dw_art_lotto_ext.setitem(ll_riga,"data_doc", ldt_data_doc)
		tab_1.tabpage_2.dw_art_lotto_ext.setitem(ll_riga,"modulo", ls_modulo)
		
		
		if (ic_tipo_ges_lotti = 'G') then		
			ll_row = tab_1.tabpage_1.dw_genera_lotto_ff.getrow()
			ll_id_articolo = tab_1.tabpage_1.dw_genera_lotto_ff.getitemnumber(ll_row, "id_articolo")
			
			SELECT m.simbolo, m.tipo
			INTO	 :ls_simbolo, :ls_tipo
			FROM	 unita_confezione u, unita_misura m
			WHERE  u.id_articolo = :ll_id_articolo
			AND	 u.unita_base = 'S'
			AND	 m.id_unita_misura =* u.id_unita_misura
			;
			
			if (SQLCA.SQLCODE = 0) then
				tab_1.tabpage_2.dw_art_lotto_ext.setitem(ll_riga, "peso_art", ld_peso_netto)
				tab_1.tabpage_2.dw_art_lotto_ext.object.peso_art_t.text='Peso Netto ('+ls_simbolo+')'
			end if
		end if
		
	end for
end if

end event

event tab_1::selectionchanged;call super::selectionchanged;if newindex=2 then cb_4.enabled=true
if newindex=1 then cb_4.enabled=false
if newindex=2 then cb_5.enabled=true
if newindex=1 then cb_5.enabled=false
end event

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=18
int Y=104
int Width=3150
int Height=1072
long BackColor=79741120
string Text="Gestione Lotti"
long TabBackColor=79741120
dw_genera_lotto_ff dw_genera_lotto_ff
tv_1 tv_1
cb_1 cb_1
end type

on tabpage_1.create
this.dw_genera_lotto_ff=create dw_genera_lotto_ff
this.tv_1=create tv_1
this.cb_1=create cb_1
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_genera_lotto_ff
this.Control[iCurrent+2]=this.tv_1
this.Control[iCurrent+3]=this.cb_1
end on

on tabpage_1.destroy
call super::destroy
destroy(this.dw_genera_lotto_ff)
destroy(this.tv_1)
destroy(this.cb_1)
end on

type cb_ricerca from w_p_data`cb_ricerca within w_genera_lotto_cx
int X=1097
int Y=32
boolean BringToTop=true
end type

event cb_ricerca::clicked;call super::clicked;
end event

type dw_genera_lotto_ff from u_dw_master_main within tabpage_1
int X=0
int Y=24
int Width=1499
int Height=1044
int TabOrder=11
string DataObject="d_genera_lotto_ff"
end type

event ue_use_search;boolean controllo
decimal {4} qt, pn
decimal{0} cs
string cod,tg,pt,testa,path
treeviewitem tvi 
dati dat
long id_dis, LL_riga, ll_id_riga, ll_num_riga
treeview tv_lotti
treeviewitem tvi_lotto
long id_base,id_f,ll_child,id_art,id_var,ll_root
string art_descr, ls_cod_articolo, des
char lc_sterilizza
integer conta, ret, li_pos


CHOOSE CASE as_nomecol
		CASE "codice"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("descrizione", is_ricpar.s_ausil_value[1])
		uf_set_colval("id_articolo", is_ricpar.s_id_seg_value[1])
		ls_cod_articolo=is_ricpar.s_main_value
		il_id_distinta = long(is_ricpar.s_ausil_value[2])	
END CHOOSE

ll_riga=tab_1.tabpage_1.dw_genera_lotto_ff.getrow()

id_art=tab_1.tabpage_1.dw_genera_lotto_ff.getitemnumber(ll_riga,"id_articolo")


if (il_id_distinta > 0) then
	id_dis = il_id_distinta
else
	select id_distinta
	into :id_dis
	from distinta
	where id_articolo=:id_art
	;
end if

if sqlca.sqlcode<>0 then messagebox("Errore","Si è verificato un errore nel recupero dell'id_distinta",stopsign!)
testa=tab_1.tabpage_1.dw_genera_lotto_ff.getitemstring(ll_riga,"codice")
tab_1.tabpage_1.tv_1.DeleteItem (0 )
if testa<>"" and isnull(testa)=false then
	dat.quantita=1
	dat.id_dis_figlio=id_dis
	tvi_lotto.data=dat
	tvi_lotto.label=testa
	tvi_lotto.pictureindex=4
	tvi_lotto.selectedpictureindex=4
	tvi_lotto.Expanded=true
	ll_root=tab_1.tabpage_1.tv_1.insertitemfirst(0,tvi_lotto)
end if

tv_lotti=tab_1.tabpage_1.tv_1

DECLARE recupera CURSOR FOR
  SELECT "articolo"."codice", 
  			"articolo"."descrizione", 
  			"articolo"."id_articolo",	
			"articolo"."immagine",
			"riga_distinta"."tipo_riga",            
         "riga_distinta"."quantita",   
			"riga_distinta"."peso_netto",   
         "riga_distinta"."costo",    
			"riga_distinta"."id_dis_figlio",
			"riga_distinta"."id_riga_distinta",
			"riga_distinta"."num_riga"
    FROM "articolo",   
         "riga_distinta",   
       	"distinta",
			"unita_confezione",
			"unita_misura"
   WHERE ( "articolo"."id_articolo" = "riga_distinta"."id_articolo" ) and  
	      ( "unita_confezione"."id_articolo" = "articolo"."id_articolo" ) and
			( "unita_confezione"."unita_base" = 'S' ) and
			( "unita_misura"."id_unita_misura" =* "unita_confezione"."id_unita_misura" ) and
         ( "distinta"."id_distinta" = "riga_distinta"."id_distinta" )  and
			(("riga_distinta"."data_fine"  is null) and ("riga_distinta"."data_fine" is null )) and
			(("riga_distinta"."id_distinta" =  :id_base )  or
          ("riga_distinta"."id_distinta" = :id_var and  "riga_distinta"."id_dis_var"=null) or
			 ("riga_distinta"."id_dis_var"=:id_var) and ("riga_distinta"."id_distinta" =:id_dis))  and
			("riga_distinta"."id_riga_distinta" not in (select "var_riga_distinta"."id_riga_distinta"
			from "var_riga_distinta" where "var_riga_distinta"."id_dis_variante"=:id_dis))
	ORDER BY "riga_distinta"."num_riga" ;
if ll_root<> -1 then
	tv_lotti.getitem(ll_root,tvi)
	dat=tvi.data
	id_var=dat.id_dis_figlio
	select id_dis_base
	into :id_base
	from distinta
	where id_distinta=:id_var;
	if isnull(id_base) then id_base=id_var
end if

open recupera;
do 
	fetch recupera into :cod,:des,:id_art,:pt,:tg,:qt, :pn, :cs,:id_f,:ll_id_riga,:ll_num_riga;
	if sqlca.sqlcode=0 then
		dat.path=pt
		dat.id_articolo=id_art
		dat.id_dis_figlio=id_f
		dat.id_distinta=id_f
		dat.id_riga=ll_id_riga
		dat.quantita=qt
		dat.peso_netto=pn
		dat.costo=cs
		dat.codice=cod
		dat.descrizione=des
		dat.tipo_riga=tg
		dat.num_riga=ll_num_riga
		
		tvi.data=dat
		tvi.label=cod
		ll_child=tv_lotti.insertitemlast(ll_root,tvi)
		tvi.expanded=false

	end if
loop while sqlca.sqlcode=0
close recupera;



				 decimal{0} ld_cod_art
				string str, prefisso,mese, giorno, anno, ls_cod_art
				long ll_mia_riga, ld_progressivo, ll_Id_art, l_id_distinta
				
				update prog_lotti
	         set prog_materie_prime = prog_materie_prime + 1; 
				select prog_materie_prime
				into :ld_progressivo
				from prog_lotti;
				
					if sqlca.sqlnrows>0 then
					   commit;
				   else 
					    rollback;
					end if	 
				
							
				ll_mia_riga=tab_1.tabpage_1.dw_genera_lotto_ff.getrow()
				tab_1.tabpage_1.dw_genera_lotto_ff.setitem(ll_mia_riga, "lotto_numero", ld_progressivo)
				mese=string(month(tab_1.tabpage_1.dw_genera_lotto_ff.getitemdate(ll_mia_riga,"data_doc")))
				giorno=string(day(tab_1.tabpage_1.dw_genera_lotto_ff.getitemdate(ll_mia_riga,"data_doc")))
				if len(giorno) =1 then giorno="0"+giorno
				if len(mese)=1 then mese="0"+mese
				anno=string(tab_1.tabpage_1.dw_genera_lotto_ff.getitemdate(ll_mia_riga,"data_doc"), "dd/mm/yyyy")
				anno=right(anno, 2)
				
				
				


   

   ls_cod_art=tab_1.tabpage_1.dw_genera_lotto_ff.getitemstring(ll_mia_riga,"codice")
   lc_sterilizza=dw_genera_lotto_ff.getitemstring(1,"sterilizza")
  	if lc_sterilizza='S' then
	 li_pos=pos(ls_cod_art, "MX")
 		IF IsNumber(ls_cod_art) or li_pos>0 then
			prefisso="LS_"
	
	
			tab_1.tabpage_1.dw_genera_lotto_ff.setitem(ll_mia_riga, "tipo_lotto", "S")
		else 	
					
					
					prefisso="LP_"
					
					tab_1.tabpage_1.dw_genera_lotto_ff.setitem(ll_mia_riga, "tipo_lotto", "P")
				
					
				
		end if
				
				str=prefisso+anno+mese+giorno
				tab_1.tabpage_1.dw_genera_lotto_ff.setitem(ll_mia_riga, "cod_esterno", str)
	else
		if IsNumber(ls_cod_art) or li_pos>0 then
			prefisso="LS_"
			tab_1.tabpage_1.dw_genera_lotto_ff.setitem(ll_mia_riga, "tipo_lotto", "K")
		else 	
			prefisso="LP_"
			tab_1.tabpage_1.dw_genera_lotto_ff.setitem(ll_mia_riga, "tipo_lotto", "Z")
		end if
		str=prefisso+anno+mese+giorno
		
		if (ic_tipo_ges_lotti = 'G') then
			
			long ll_cod_esterno, ll_giorni_durata, ll_id_articolo
			date ldt_data_scadenza

			
			ll_id_articolo = tab_1.tabpage_1.dw_genera_lotto_ff.getitemnumber(ll_riga,"id_articolo")
			
			SELECT MAX(CAST(cod_esterno AS NUMERIC(12)) ) + 1	
			INTO	 :ll_cod_esterno
			FROM	 lotto
			WHERE  id_articolo = :ll_id_articolo
			;
			
			
 
			if (SQLCA.SQLCODE = -1) and (SQLCA.SQLDBCODE <> -157) then messagebox("DBError", SQLCA.SQLERRTEXT)
			
			
			
			if (ll_cod_esterno = 0 or isnull(ll_cod_esterno)) then
				ll_cod_esterno = 1
			end if
			
			str = string(ll_cod_esterno)
			
			
			SELECT giorni_durata
			INTO	 :ll_giorni_durata
			FROM	 articolo
			WHERE  id_articolo = :ll_id_articolo
			;
			
			if (ll_giorni_durata > 0) then
				ldt_data_scadenza = tab_1.tabpage_1.dw_genera_lotto_ff.getitemdate(ll_riga,"data_doc")
				if (isnull(ldt_data_scadenza)) then ldt_data_scadenza = Today()
					
				ldt_data_scadenza = relativedate(ldt_data_scadenza, ll_giorni_durata)
				tab_1.tabpage_1.dw_genera_lotto_ff.setitem(ll_riga,"lotto_data_scadenza", ldt_data_scadenza)				
			end if
		end if
		
		tab_1.tabpage_1.dw_genera_lotto_ff.setitem(ll_mia_riga, "cod_esterno", str)
	end if
		
end event

event ue_set_search;call super::ue_set_search;CHOOSE CASE as_nomecol
		CASE "codice"
		is_search_window = "w_articolo_lotgen_sw" 
		is_ricpar.s_filter_value = uf_get_colval("codice") 
		is_ricpar.s_filter_name = "codice" 
	
END CHOOSE

end event

event itemchanged;generato=false
string anno, mese, giorno, str, prefisso
long ll_mia_riga
date ld_data

string		ls_dbc[], ls_dbv[], ls_dwc[]
integer li_ok
CHOOSE CASE dwo.name
	case "codice"
		ls_dbc[1] = "id_articolo"
		ls_dbc[2] = "codice"
		ls_dbc[3] = "descrizione"
		ls_dwc[1] = "id_articolo"
		ls_dwc[2] = "codice"
		ls_dwc[3] = "descrizione"
		li_ok = uf_autofind_col (string(dwo.name),"articolo","codice","A",data,"",3,ls_dbc,ls_dbv,ls_dwc)
END CHOOSE

ll_mia_riga=tab_1.tabpage_1.dw_genera_lotto_ff.getrow()
prefisso=tab_1.tabpage_1.dw_genera_lotto_ff.getitemstring(ll_mia_riga, "cod_esterno")
if (prefisso="") or (isnull(prefisso)) then return
if dwo.name = "data_doc" and (ic_tipo_ges_lotti = 'S' or isnull(ic_tipo_ges_lotti)) then
	mese=string(month(date(data)))
	giorno=string(day(date(data)))
	if len(giorno) =1 then giorno="0"+giorno
	if len(mese)=1 then mese="0"+mese
	anno=right(data,2) 
	prefisso=left(prefisso, 3)
	str=prefisso+anno+mese+giorno
	tab_1.tabpage_1.dw_genera_lotto_ff.setitem(ll_mia_riga, "cod_esterno", str)
end if

CHOOSE CASE dwo.name
	CASE "lotto_qta_iniziale"
		if (ic_tipo_ges_lotti = 'G') then
			decimal {4}	ld_peso_netto, ld_calo
			string ls_simbolo, ls_cod_dis
			long ll_id_articolo
			
			ll_id_articolo = this.object.id_articolo[ll_mia_riga]
				
			SELECT m.simbolo
			INTO	 :ls_simbolo
			FROM	 unita_confezione u, unita_misura m
			WHERE  u.id_articolo = :ll_id_articolo
			AND	 u.unita_base = 'S'
			AND	 m.id_unita_misura =* u.id_unita_mis_peso
			;
			
			if (SQLCA.SQLCODE = 0) then
				ls_cod_dis = this.object.codice[ll_mia_riga]
				
				SELECT peso_netto, calo
				INTO	 :ld_peso_netto, :ld_calo
				FROM	 distinta
				WHERE  codice = :ls_cod_dis
				;
				
				if (ld_peso_netto > 0) then 
					if (dec(data) > 0) then ld_peso_netto = dec(data) * ld_peso_netto
					this.setitem(ll_mia_riga, "lotto_peso_netto_da_lav", ld_peso_netto)	
					if (ld_calo > 0) then ld_peso_netto = ld_peso_netto - (ld_peso_netto * ld_calo / 100)
					this.setitem(ll_mia_riga, "lotto_peso_netto_iniziale", ld_peso_netto)	
				end if
				if (not isnull(ls_simbolo)) then this.object.peso_netto_t.text='Peso Netto ('+ls_simbolo+')'
			end if
		end if
END CHOOSE
end event

type tv_1 from treeview within tabpage_1
int X=1536
int Y=24
int Width=1253
int Height=1044
int TabOrder=11
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
string PictureName[]={"Library5!",&
"SingletonReturn!",&
"Custom017!",&
"Custom023!",&
"BorderShadowBox!",&
"Border3DLowered!",&
"RunWindow!",&
"RunWindow!",&
"RunWindow!",&
"NotFound!",&
"NotFound!",&
"NotFound!",&
"NotFound!"}
long PictureMaskColor=553648127
long StatePictureMaskColor=553648127
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_1 from commandbutton within tabpage_1
int X=1024
int Y=616
int Width=256
int Height=108
int TabOrder=12
boolean Visible=false
boolean BringToTop=true
string Text="Apri Dis."
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
open(w_distinta_base_cx)
end event

type tabpage_2 from userobject within tab_1
event create ( )
event destroy ( )
int X=18
int Y=104
int Width=3150
int Height=1072
long BackColor=79217864
string Text="Genera Lotto"
long TabBackColor=79217864
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_art_lotto_ext dw_art_lotto_ext
end type

on tabpage_2.create
this.dw_art_lotto_ext=create dw_art_lotto_ext
this.Control[]={this.dw_art_lotto_ext}
end on

on tabpage_2.destroy
destroy(this.dw_art_lotto_ext)
end on

type dw_art_lotto_ext from u_dw_master_main within tabpage_2
int X=14
int Y=28
int Width=3104
int Height=1024
int TabOrder=3
string DataObject="d_lotto_ext_ff"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event itemchanged;
long		ll_id_lotto
integer	li_row
decimal  ld_valore, ld_val_scaricato
if ((dwo.name = "quantita" or dwo.name = "peso_netto") and ic_tipo_ges_lotti = 'G') then
	ll_id_lotto = this.getitemnumber(row, "id_lotto_mp")
	if (dwo.name = "quantita") then
		ld_valore = this.getitemnumber(row, "quantita")
	else
		ld_valore = this.getitemnumber(row, "peso_netto")
	end if
	
	if (ll_id_lotto > 0) then
		li_row = ds_mov_lotto.Find("id_lotto = " + string(ll_id_lotto) , 1, ds_mov_lotto.rowcount())
		if (li_row > 0) then
			if (dwo.name = "quantita") then			
				ds_mov_lotto.setitem(li_row, "quantita", dec(data))
			else
				ds_mov_lotto.setitem(li_row, "peso_netto", dec(data))
			end if
		end if
		
		li_row = ds_lotto.Find("id_lotto = " + string(ll_id_lotto) , 1, ds_lotto.rowcount())
		
		if (dwo.name = "quantita") and li_row > 0 then
			ld_val_scaricato = ds_lotto.getitemnumber(li_row, "qta_scaricata")
			ld_val_scaricato = ld_val_scaricato - ld_valore + dec(data)
			ds_lotto.setitem(li_row, "qta_scaricata", ld_val_scaricato)
			
		elseif (dwo.name = "peso_netto") and li_row > 0 then
			ld_val_scaricato = ds_lotto.getitemnumber(li_row, "peso_netto_scaricato")
			ld_val_scaricato = ld_val_scaricato - ld_valore + dec(data)
			ds_lotto.setitem(li_row, "peso_netto_scaricato", ld_val_scaricato)
			
		end if
	end if
end if
end event

type cb_5 from commandbutton within w_genera_lotto_cx
event clicked pbm_bnclicked
int X=1682
int Y=32
int Width=370
int Height=84
int TabOrder=60
boolean BringToTop=true
string Text="Annulla genera"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string  articolo,num_lotto_prod,descr_art_lotto_prod, ls_modulo
decimal{4} quantita
long ll_riga,nrg
date data_scad, ldt_data_doc

if generato=true then
	ds_lotto.retrieve()
	ds_mov_lotto.retrieve()
	articolo=tab_1.tabpage_2.dw_art_lotto_ext.getitemstring(1, "c_testa")
	num_lotto_prod=tab_1.tabpage_2.dw_art_lotto_ext.getitemstring(1, "num_lotto_prod")
	quantita=tab_1.tabpage_2.dw_art_lotto_ext.getitemdecimal(1, "n_art")
	data_scad=tab_1.tabpage_2.dw_art_lotto_ext.getitemdate(1,"d_scad_2")
	descr_art_lotto_prod= tab_1.tabpage_2.dw_art_lotto_ext.getitemstring(1,"desc_art_lotto_prod")
	ldt_data_doc=tab_1.tabpage_2.dw_art_lotto_ext.getitemdate(1,"data_doc")
	ls_modulo=tab_1.tabpage_2.dw_art_lotto_ext.getitemstring(1,"modulo")
	
	tab_1.tabpage_2.dw_art_lotto_ext.reset()
	
	
	
	
	f_valorizza_lotti(tab_1.tabpage_2.dw_art_lotto_ext, 1, tab_1.tabpage_1.tv_1)
	
	
	nrg=tab_1.tabpage_2.dw_art_lotto_ext.rowcount()
	for ll_riga=1 to nrg
	  tab_1.tabpage_2.dw_art_lotto_ext.setitem(1, "c_testa", articolo)
	  tab_1.tabpage_2.dw_art_lotto_ext.setitem(1, "num_lotto_prod", num_lotto_prod )
	  tab_1.tabpage_2.dw_art_lotto_ext.setitem(1, "n_art", quantita)
	  tab_1.tabpage_2.dw_art_lotto_ext.setitem(1,"d_scad_2",data_scad)
	  tab_1.tabpage_2.dw_art_lotto_ext.setitem(1,"desc_art_lotto_prod",descr_art_lotto_prod)
	  tab_1.tabpage_2.dw_art_lotto_ext.setitem(1,"data_doc", ldt_data_doc)	
	  tab_1.tabpage_2.dw_art_lotto_ext.setitem(1,"modulo", ls_modulo)	
	end for
	
	generato=false
	
end if
tab_1.tabpage_2.dw_art_lotto_ext.modify("num_lotto_prod.color=0")
end event

type cb_4 from commandbutton within w_genera_lotto_cx
event clicked pbm_bnclicked
int X=1390
int Y=32
int Width=261
int Height=84
int TabOrder=20
boolean BringToTop=true
string Text="Genera"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

wf_mp_necessarie()

wf_lotti_mp_necessari()
end event

type cb_3 from commandbutton within w_genera_lotto_cx
event clicked pbm_bnclicked
int X=2670
int Y=32
int Width=261
int Height=84
int TabOrder=30
boolean BringToTop=true
string Text="Stampa"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
printsetup()
tab_1.tabpage_2.dw_art_lotto_ext.print()
end event

type cb_preview from commandbutton within w_genera_lotto_cx
event clicked pbm_bnclicked
int X=2377
int Y=32
int Width=261
int Height=84
int TabOrder=50
boolean BringToTop=true
string Text="Preview"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if this.text="Preview" then
  tab_1.tabpage_2.dw_art_lotto_ext.object.datawindow.print.preview='yes'
  tab_1.tabpage_2.dw_art_lotto_ext.object.datawindow.print.preview.zoom='90'
  this.text="Exit"
else
 tab_1.tabpage_2.dw_art_lotto_ext.object.datawindow.print.preview='no'
  this.text="Preview"
end if	
end event

type cb_2 from commandbutton within w_genera_lotto_cx
int X=2935
int Y=152
int Width=256
int Height=84
int TabOrder=40
boolean BringToTop=true
string Text="EXCEL"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;TAB_1.TABPAGE_2.dw_art_lotto_ext.SAVEAS()
end event

