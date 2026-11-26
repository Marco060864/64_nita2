forward
global type w_genera_doc_lotti from Window
end type
type cb_2 from commandbutton within w_genera_doc_lotti
end type
type cb_1 from commandbutton within w_genera_doc_lotti
end type
type dw_1 from u_dw_ext_main within w_genera_doc_lotti
end type
end forward

global type w_genera_doc_lotti from Window
int X=1051
int Y=480
int Width=2830
int Height=960
boolean TitleBar=true
string Title="Lotti - Genera documenti "
long BackColor=80133307
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_genera_doc_lotti w_genera_doc_lotti

type variables
datastore ds_lotto , ds_mov_lotto

boolean generato=false, commerciale=false, salvato=false
long il_id_doc_car, il_id_doc_scar
char ic_tipo_ges_lotti
long il_id_distinta  

end variables

forward prototypes
public subroutine wf_errore (string as_msg)
end prototypes

public subroutine wf_errore (string as_msg);messagebox('Errore!', 'Impossibile trovare '+as_msg)
end subroutine

on w_genera_doc_lotti.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_genera_doc_lotti.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;SELECT tipo_ges_lotti
INTO	 :ic_tipo_ges_lotti
FROM	 pers_par_sistema
;

dw_1.settransobject(sqlca)
dw_1.insertrow(0)


dw_1.setitem(1,'qta',1)
dw_1.setitem(1,'data_doc',today())
dw_1.setitem(1,'qta_prima',1)
end event

type cb_2 from commandbutton within w_genera_doc_lotti
int X=1170
int Y=560
int Width=352
int Height=108
int TabOrder=30
string Text="Genera Doc 2"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_id_reg_car, ll_id_reg_scar, ll_id_prof_car, ll_id_prof_scar, ll_num_prog, ll_id_sog_com, ll_id_valuta, ll_id_lotto2
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
ll_row = dw_1.getrow()
if ll_row > 0 then ld_data_reg =dw_1.getitemdate(ll_row, "data_doc")
if isnull(ld_data_reg) then ld_data_reg = today()
ld_data_reg = date(string(ld_data_reg, 'yyyy-mm-dd'))


decimal {4} ld_qta, ld_qta_scarico

ld_qta = dw_1.getitemnumber(1, "qta")
ld_qta_scarico = dw_1.getitemnumber(1, "qta_prima")

if (isnull(ld_qta) or ld_qta = 0) and (isnull(ld_qta_scarico) or ld_qta_scarico = 0) then
	messagebox("Attenzione", "specificare la qta/peso di carico o quella di scarico")
end if

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
		return
end choose

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
	
	select id_locazione
	into   :ll_id_locazione
	from   par_sistema;

if (ld_qta > 0) then
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

	select id_prof_documento
	into :ll_id_prof_car
	from prof_documento
	where prof_documento.codice='CL';

	
	if IsNull(ll_id_prof_car)or(ll_id_prof_car=0) then
		wf_errore('Profilo di Carico')
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
	values (:ll_id_prof_car, :ll_id_reg_car, :ll_num_prog, :ld_data_reg, :ll_id_sog_com, :ll_id_valuta, :ll_id_caus_car, 
				:ll_id_locazione
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

	ll_id_art=dw_1.GetItemNumber(1,"id_art")
	ld_quantita=ld_qta
	ls_cod_lotto=dw_1.GetItemString(1,"cod_lotto2")
	ls_des_art=dw_1.GetItemString(1,"desart")
	
	
	if (ic_tipo_ges_lotti = 'G') then	
		ld_peso_netto=dw_1.GetItemDecimal(1,"qta")
	end if
	
	
	
	
	ll_id_lotto = dw_1.GetItemnumber(1,"id_lotto2")
		
	
	
	
	
	
	
	
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
		
		
		ld_prezzo_lotto = 0 
		
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
		values (:ll_id_r_lotto, :ll_id_lotto, 0, :ll_id_doc)
		;
		
		if sqlca.sqlcode <> 0 then
			messagebox("Errore", sqlca.sqlerrtext)
			rollback;
		else
			commit;
			messagebox("INFORMATION", "La generazione è stata ~r~neseguita correttamente!")
		end if
	end if

elseif (ld_qta_scarico > 0) then
	
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
	into :ll_id_prof_scar
	from prof_documento
	where prof_documento.codice='SL';
	if IsNull(ll_id_prof_scar)or(ll_id_prof_scar=0) then
		wf_errore('Profilo di Scarico')
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
			messagebox("Errore", "Documento di scarico non creato~n"+sqlca.sqlerrtext)
			errore=true
			rollback;
		else
			commit;
		end if
		
		select Max(id_documento)
		into :ll_id_doc
		from documento;
		
		
		il_id_doc_scar=ll_id_doc
		
		ll_riga=dw_1.RowCount()
		for i=1 to ll_riga
			ll_id_lotto2=dw_1.GetItemNumber(i,"id_lotto2")
			select id_articolo into :ll_id_art from lotto where id_lotto=:ll_id_lotto2;
			ld_quantita=dw_1.GetItemDecimal(i,"qta_prima")
			ls_cod_lotto=dw_1.getItemString(i,"cod_lotto")
			ls_des_art=dw_1.getItemString(i,"desart")
			
			
			if (ic_tipo_ges_lotti = 'G') then
				ld_peso_netto = dw_1.GetItemDecimal(i,"qta_prima")
			end if
			
		
	
			select prog_materie_prime
			into :ll_id_r_lotto
			from prog_lotti;
			ll_id_r_lotto++
			update prog_lotti
			set prog_materie_prime = :ll_id_r_lotto;
	
			
			ll_id_lotto_mp = dw_1.GetItemDecimal(i,"id_lotto2")
			
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
					messagebox("INFORMATION", "La generazione è stata ~r~neseguita correttamente!")
				end if
			end if
			
		next
	end if
end event

type cb_1 from commandbutton within w_genera_doc_lotti
int X=411
int Y=560
int Width=325
int Height=108
int TabOrder=20
string Text="Genera Doc."
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_id_reg_car, ll_id_reg_scar, ll_id_prof_car, ll_id_prof_scar, ll_num_prog, ll_id_sog_com, ll_id_valuta, ll_id_lotto2
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
ll_row = dw_1.getrow()
if ll_row > 0 then ld_data_reg =dw_1.getitemdate(ll_row, "data_doc")
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
	
	ll_riga=dw_1.RowCount()
	for i=1 to ll_riga
		ll_id_lotto2=dw_1.GetItemNumber(i,"id_lotto2")
		select id_articolo into :ll_id_art from lotto where id_lotto=:ll_id_lotto2;
		ld_quantita=dw_1.GetItemDecimal(i,"qta_prima")
		ls_cod_lotto=dw_1.getItemString(i,"cod_lotto")
		ls_des_art=dw_1.getItemString(i,"desart")
		
		
		if (ic_tipo_ges_lotti = 'G') then
			ld_peso_netto = dw_1.GetItemDecimal(i,"qta_prima")
		end if
		
	

		select prog_materie_prime
		into :ll_id_r_lotto
		from prog_lotti;
		ll_id_r_lotto++
		update prog_lotti
		set prog_materie_prime = :ll_id_r_lotto;



		
		ll_id_lotto_mp = dw_1.GetItemDecimal(i,"id_lotto2")
		
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

	ll_id_art=dw_1.GetItemNumber(1,"id_art")
	ld_quantita=dw_1.GetItemDecimal(1,"qta")
	ls_cod_lotto=dw_1.GetItemString(1,"cod_lotto")
	ls_des_art=dw_1.GetItemString(1,"desart")
	
	
	if (ic_tipo_ges_lotti = 'G') then	
		ld_peso_netto=dw_1.GetItemDecimal(1,"qta")
	end if
	
	
	
	
	ll_id_lotto = dw_1.GetItemnumber(1,"id_lotto")
		
	
	
	
	
	
	
	
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
		
		
		ld_prezzo_lotto = 0 
		
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
			messagebox("INFORMATION", "La generazione è stata ~r~neseguita correttamente!")			
		end if
	end if
	
	salvato=not(errore)
end event

type dw_1 from u_dw_ext_main within w_genera_doc_lotti
int X=37
int Y=64
int Width=2441
int Height=420
int TabOrder=10
string DataObject="d_genera_doc_lotti"
end type

event ue_set_search;STRING LS_COD
CHOOSE CASE as_nomecol
	CASE "codart"
		is_search_window="w_articolo_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="articolo_codice"
	CASE "desart"
		is_search_window="w_articolo_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="articolo_descrizione"
		
	CASE "cod_lotto", "cod_lotto2"
		LS_COD=DW_1.GETITEMSTRING(1,'CODART')
		IF AS_NOMECOL="cod_lotto" THEN 
			is_ricpar.s_filter_name = "articolo_codice"  
			is_ricpar.s_filter_value = LS_COD 			
		ELSE
			is_ricpar.s_filter_name = "lotto_cod_esterno"  
			is_ricpar.s_filter_value = as_valcol 			
		END IF	
		is_search_window = "w_lotto_codice_sw"   
END CHOOSE

end event

event ue_use_search;CHOOSE CASE as_nomecol
	CASE "codart"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_art",is_ricpar.s_id_seg_value[1])
			uf_set_colval("desart",is_ricpar.s_ausil_value[1])	
	CASE "desart"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_art",is_ricpar.s_id_seg_value[1])
			uf_set_colval("desart",is_ricpar.s_ausil_value[1])
			
	CASE "cod_lotto"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_lotto",is_ricpar.s_id_seg_value[1])		
			
	CASE "cod_lotto2"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_lotto2",is_ricpar.s_id_seg_value[1])					

END CHOOSE 
end event

event itemchanged;integer li_ok

string ls_sql_cond
string ls_dbc[], ls_dwc[], ls_dbv[]
Long		ll_id_listino
String 	ls_listino
Date 	 ld_data_fine
			

CHOOSE CASE dwo.name

	CASE "codart"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_articolo"		
		
		ls_dwc[1] = "codart"
		ls_dwc[2] = "desart"
		ls_dwc[3] = "id_art"		
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "codice", "A", data, ls_sql_cond, 3, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
		
	CASE "desart"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_articolo"				
		
		ls_dwc[1] = "codart"
		ls_dwc[2] = "desart"
		ls_dwc[3] = "id_art"				
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "descrizione", "A", data, ls_sql_cond, 3, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
		
		
END CHOOSE

end event

