forward
global type w_imp_lotto_pf_ff from w_wiz_main
end type
type dw_imp_lotto_pf_ext from u_dw_ext_main within w_imp_lotto_pf_ff
end type
type cb_importa from commandbutton within w_imp_lotto_pf_ff
end type
type st_1 from statictext within w_imp_lotto_pf_ff
end type
type st_3 from statictext within w_imp_lotto_pf_ff
end type
type st_2 from statictext within w_imp_lotto_pf_ff
end type
type st_4 from statictext within w_imp_lotto_pf_ff
end type
type dw_lotti_da_imp_gd from u_dw_ext_main within w_imp_lotto_pf_ff
end type
end forward

global type w_imp_lotto_pf_ff from w_wiz_main
int Width=3218
int Height=1544
boolean TitleBar=true
string Title="Carico lotti di produzione"
dw_imp_lotto_pf_ext dw_imp_lotto_pf_ext
cb_importa cb_importa
st_1 st_1
st_3 st_3
st_2 st_2
st_4 st_4
dw_lotti_da_imp_gd dw_lotti_da_imp_gd
end type
global w_imp_lotto_pf_ff w_imp_lotto_pf_ff

type variables
w_wait_01	iw_wait
end variables

on w_imp_lotto_pf_ff.create
int iCurrent
call super::create
this.dw_imp_lotto_pf_ext=create dw_imp_lotto_pf_ext
this.cb_importa=create cb_importa
this.st_1=create st_1
this.st_3=create st_3
this.st_2=create st_2
this.st_4=create st_4
this.dw_lotti_da_imp_gd=create dw_lotti_da_imp_gd
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_imp_lotto_pf_ext
this.Control[iCurrent+2]=this.cb_importa
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_3
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.st_4
this.Control[iCurrent+7]=this.dw_lotti_da_imp_gd
end on

on w_imp_lotto_pf_ff.destroy
call super::destroy
destroy(this.dw_imp_lotto_pf_ext)
destroy(this.cb_importa)
destroy(this.st_1)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_4)
destroy(this.dw_lotti_da_imp_gd)
end on

event open;call super::open;long	 	ll_id_prof_documento
string 	ls_codice, ls_descrizione
integer  li_row

dw_imp_lotto_pf_ext.insertrow(0)

SELECT p.id_prof_documento, p.codice, p.descrizione
INTO	 :ll_id_prof_documento, :ls_codice, :ls_descrizione
FROM	 prof_documento p, caus_magazzino c
WHERE  c.id_caus_magazzino = p.id_caus_magazzino_prop
AND	 c.gestisce_lotti = 'C'
;

li_row = dw_imp_lotto_pf_ext.getrow()

if (SQLCA.SQLCODE = 0) then
	dw_imp_lotto_pf_ext.object.id_prof_documento[li_row] = ll_id_prof_documento
	dw_imp_lotto_pf_ext.object.prof_documento_codice[li_row] = ls_codice
	dw_imp_lotto_pf_ext.object.prof_documento_descrizione[li_row] = ls_descrizione
end if

end event

event ue_post_open;call super::ue_post_open;
open(iw_wait,"w_wait_01")
iw_wait.st_wait.text = "Visualizzazione dei lotti da importare ..."
iw_wait.st_wait_b.text = ""

SQLCA.sp_trasf_dati(4, 0)

dw_lotti_da_imp_gd.settransobject(sqlca)
dw_lotti_da_imp_gd.retrieve()
close(iw_wait)

end event

type dw_imp_lotto_pf_ext from u_dw_ext_main within w_imp_lotto_pf_ff
int X=37
int Y=160
int Width=3113
int Height=260
int TabOrder=10
boolean BringToTop=true
string DataObject="d_imp_lotto_pf_ext"
end type

event itemchanged;integer		li_ok
string		ls_dbc[], ls_dbv[], ls_dwc[], ls_null, ls_message, ls_num_doc, ls_old_num_doc
string		ls_sql_cond

CHOOSE CASE dwo.name
	CASE 'prof_documento_codice'
		ls_sql_cond = "caus_magazzino.gestisce_lotti = 'C'"		
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_prof_documento"
		
		ls_dwc[1] = "prof_documento_codice"
		ls_dwc[2] = "prof_documento_descrizione"
		ls_dwc[3] = "id_prof_documento"

		li_ok = uf_autofind_col (string(dwo.name),"prof_documento",&
										"codice","A",data,ls_sql_cond,3,ls_dbc,ls_dbv,ls_dwc)
		if li_ok > 0 then
			return 2 
		end if
		
	CASE 'prof_documento_descrizione'
		ls_sql_cond = "caus_magazzino.gestisce_lotti = 'C'"		
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_prof_documento"
		
		ls_dwc[1] = "prof_documento_codice"
		ls_dwc[2] = "prof_documento_descrizione"
		ls_dwc[3] = "id_prof_documento"

		li_ok = uf_autofind_col (string(dwo.name),"prof_documento",&
										"descrizione","A",data,ls_sql_cond,4,ls_dbc,ls_dbv,ls_dwc)
		if li_ok > 0 then
			return 2 
		end if	
END CHOOSE
end event

event ue_set_search;CHOOSE CASE as_nomecol
	CASE "prof_documento_codice", "prof_documento_descrizione"
		is_search_window = "w_prof_documento_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		
		if as_nomecol="prof_documento_codice" then
			is_ricpar.s_filter_name = "prof_documento_codice" 
		else
			is_ricpar.s_filter_name = "prof_documento_descrizione" 
		end if	
		is_ricpar.s_sql_cond  = "caus_magazzino.gestisce_lotti = 'C'"
END CHOOSE


end event

event ue_use_search;CHOOSE CASE as_nomecol
	CASE "prof_documento_codice"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_prof_documento", is_ricpar.s_id_seg_value[1])
		uf_set_colval("prof_documento_descrizione", is_ricpar.s_ausil_value[1])

	CASE "prof_documento_descrizione"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_prof_documento", is_ricpar.s_id_seg_value[1])
		uf_set_colval("prof_documento_codice", is_ricpar.s_ausil_value[1])
END CHOOSE
end event

type cb_importa from commandbutton within w_imp_lotto_pf_ff
int X=1207
int Y=32
int Width=261
int Height=84
int TabOrder=30
boolean BringToTop=true
string Text="&Importa"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
long 		ll_rows, ll_row, ll_I
long 		ll_id_prof_documento, ll_id_locazione_1_prop, ll_id_reg_car
long 		ll_id_caus_magazzino_prop, ll_id_sog_comm_prop, ll_id_valuta_prop
long 		ll_id_anag_modello, ll_id_articolo
decimal 	ld_qta_iniziale, ld_qta_scaricata
string	ls_attivo, ls_tipo_lotto, ls_cod_esterno, ls_modulo, ls_lotto_ster_1
string	ls_lotto_ster_2
date	   ldt_data_scadenza 
integer  li_numero
decimal	ld_peso_netto_iniziale, ld_peso_netto_scaricato, ld_peso_netto_da_lav
date		ldt_data_doc
long  	ll_num_prog, ll_id_doc, ll_id_r_lotto, ll_id_u_conf, ll_id_lotto
string	ls_note

decimal 	ld_r_quantita, ld_r_fat_con_unita_base,ld_r_fat_con_globale,ld_r_qta_un_base 
decimal	ld_r_cambio, ld_r_prezzo, ld_r_prezzo_netto, ld_r_peso_netto
decimal	ld_r_val_attribuito, ld_r_tot_riga_val_riga, ld_r_tot_riga_val_doc
decimal	ld_r_tot_riga_val_az
long	   ll_id_tab_iva
string	ls_v_codice, ls_t_codice, ls_a_codice
long	   ll_id_val_lire
decimal	ld_cambio_l, ld_tot_riga_val_doc_l
decimal	ld_per_aliquota
date		ldt_data_registrazione	

string	ls_importa					
decimal	ld_progressivo

time lt_i, lt_f

lt_i = Now()
st_3.text = string(lt_i)

ll_rows = dw_lotti_da_imp_gd.rowcount()
if (ll_rows > 0) then
	
	ll_row = dw_imp_lotto_pf_ext.getrow()
	
   
	ll_id_prof_documento = dw_imp_lotto_pf_ext.object.id_prof_documento[1]
	if (isnull(ll_id_prof_documento)) then
		messagebox("Attenzione", "Specificare il profilo di carico lotti")
		return 2
	end if
	
	SELECT p.id_locazione_1_prop, r.id_registro, p.id_caus_magazzino_prop, 
			 p.id_sog_comm_prop, p.id_valuta_prop
	INTO	 :ll_id_locazione_1_prop, :ll_id_reg_car, :ll_id_caus_magazzino_prop, 
			 :ll_id_sog_comm_prop, :ll_id_valuta_prop
	FROM	 prof_documento p, registro r, azienda a
	WHERE  p.id_prof_documento = :ll_id_prof_documento 
	AND	 a.id_azienda = p.id_azienda
	AND	 r.id_mod_registro = p.id_mod_registro_prop
	AND	 r.id_esercizio = a.id_esercizio_proposto
	;
	
	if (isnull(ll_id_locazione_1_prop)) then
		messagebox("Attenzione", "Nel profilo indicato, deve essere specificata la Locazione")
		return
	end if	
	if (isnull(ll_id_sog_comm_prop)) then
		messagebox("Attenzione", "Nel profilo indicato, deve essere specificato l'intestatario")
		return
	end if	

	open(iw_wait,"w_wait_01")
	
	for ll_i = 1 to ll_rows
		
		ls_importa = dw_lotti_da_imp_gd.object.importa[ll_i]
		if (ls_importa = 'N') then	continue
		
		
		ll_id_anag_modello = dw_lotti_da_imp_gd.object.id_anag_modello[ll_i]
		ls_a_codice = dw_lotti_da_imp_gd.object.a_codice[ll_i]
		ld_qta_iniziale = dw_lotti_da_imp_gd.object.qta_iniziale[ll_i]
		ld_qta_scaricata = dw_lotti_da_imp_gd.object.qta_scaricata[ll_i]
		ls_attivo = dw_lotti_da_imp_gd.object.attivo[ll_i]
		ls_note = string(dw_lotti_da_imp_gd.object.note[ll_i])
		ldt_data_scadenza = dw_lotti_da_imp_gd.object.data_scadenza[ll_i]
		ls_tipo_lotto = dw_lotti_da_imp_gd.object.tipo_lotto[ll_i]
		ls_cod_esterno = dw_lotti_da_imp_gd.object.cod_esterno[ll_i]
		li_numero = dw_lotti_da_imp_gd.object.numero[ll_i]
		ldt_data_doc = dw_lotti_da_imp_gd.object.data_doc[ll_i]
		ls_modulo = dw_lotti_da_imp_gd.object.modulo[ll_i]
		ls_lotto_ster_1 = dw_lotti_da_imp_gd.object.lotto_ster_1[ll_i]
		ls_lotto_ster_2 = dw_lotti_da_imp_gd.object.lotto_ster_2[ll_i]
		ld_peso_netto_iniziale = dw_lotti_da_imp_gd.object.peso_netto_iniziale[ll_i]
		ld_peso_netto_scaricato = dw_lotti_da_imp_gd.object.peso_netto_scaricato[ll_i]
		ld_peso_netto_da_lav = dw_lotti_da_imp_gd.object.peso_netto_da_lav[ll_i]
		
		ld_r_quantita = dw_lotti_da_imp_gd.object.r_quantita[ll_i]
		ld_r_fat_con_unita_base = dw_lotti_da_imp_gd.object.r_fat_con_unita_base[ll_i]
		ld_r_fat_con_globale = dw_lotti_da_imp_gd.object.r_fat_con_globale[ll_i]
	 	ld_r_qta_un_base = dw_lotti_da_imp_gd.object.r_qta_un_base[ll_i]
		ls_v_codice = dw_lotti_da_imp_gd.object.v_codice[ll_i]
		ld_r_cambio = dw_lotti_da_imp_gd.object.r_cambio[ll_i]
		ld_r_prezzo = dw_lotti_da_imp_gd.object.r_prezzo[ll_i]
		ld_r_prezzo_netto = dw_lotti_da_imp_gd.object.r_prezzo_netto[ll_i]
		ld_r_peso_netto = dw_lotti_da_imp_gd.object.r_peso_netto[ll_i]
	   ls_t_codice = dw_lotti_da_imp_gd.object.t_codice[ll_i]
		ld_r_val_attribuito = dw_lotti_da_imp_gd.object.r_val_attribuito[ll_i]
		ld_r_tot_riga_val_riga = dw_lotti_da_imp_gd.object.r_tot_riga_val_riga[ll_i]
		ld_r_tot_riga_val_doc = dw_lotti_da_imp_gd.object.r_tot_riga_val_doc[ll_i]
	   ld_r_tot_riga_val_az = dw_lotti_da_imp_gd.object.r_tot_riga_val_az[ll_i]
	   ldt_data_registrazione = dw_lotti_da_imp_gd.object.d_data_registrazione[ll_i]			
		
		iw_wait.st_wait_b.text = "Importazione Lotto N° " + ls_cod_esterno + " Articolo " + ls_a_codice
			
		SELECT id_articolo
		INTO	 :ll_id_articolo
		FROM	 articolo
		WHERE	 codice = :ls_a_codice
		;
		if (ll_id_articolo = 0) then setnull(ll_id_articolo)
			
		SELECT id_valuta
		INTO	 :ll_id_valuta_prop
		FROM	 valuta
		WHERE  codice = :ls_v_codice
		;
		if (ll_id_valuta_prop = 0) then setnull(ll_id_valuta_prop)

		SELECT id_tab_iva
		INTO	 :ll_id_tab_iva
		FROM	 tab_iva
		WHERE  codice = :ls_t_codice
		;
		if (ll_id_tab_iva = 0) then setnull(ll_id_tab_iva)

		SELECT per_aliquota
		INTO	 :ld_per_aliquota
		FROM	 tab_iva
		WHERE  id_tab_iva = :ll_id_tab_iva
		;
	
		if (not isnull(ls_a_codice) and isnull(ll_id_articolo)) then 
			messagebox("Lotto di Produzione N° " + ls_cod_esterno , "Per importare questo Lotto, ~nInserire l'Articolo " + ls_a_codice + " e ripetere l'operazione ")
			continue
		end if
		if (not isnull(ls_v_codice) and isnull(ll_id_valuta_prop)) then 
			messagebox("Lotto di Produzione N° " + ls_cod_esterno , "Per importare questo Lotto, ~nInserire la Valuta " + ls_v_codice + " e ripetere l'operazione ")
			continue
		end if
		if (not isnull(ls_t_codice) and isnull(ll_id_tab_iva)) then 
			messagebox("Lotto di Produzione N° " + ls_cod_esterno , "Per importare questo Lotto, ~nInserire l'Aliquita IVA " + ls_v_codice + " e ripetere l'operazione ")
			continue
		end if
		
			
		
		update prog_lotti
      set prog_materie_prime = prog_materie_prime + 1
		; 
		
		select prog_materie_prime
		into :ld_progressivo
		from prog_lotti
		;
		
		if sqlca.sqlnrows>0 then
		   commit;
	   else 
		    rollback;
			 continue
		end if	 
		
		insert into lotto(id_anag_modello,id_articolo,qta_iniziale,qta_scaricata,attivo,
		  note,data_scadenza,tipo_lotto,cod_esterno,numero,data_doc,modulo,
		  lotto_ster_1,lotto_ster_2,
		  peso_netto_iniziale,peso_netto_scaricato,peso_netto_da_lav) 
		values(:ll_id_anag_modello, :ll_id_articolo, :ld_qta_iniziale, :ld_qta_scaricata,
		  :ls_attivo, :ls_note, :ldt_data_scadenza, :ls_tipo_lotto, :ls_cod_esterno, 
		  :ld_progressivo, :ldt_data_doc, :ls_modulo, :ls_lotto_ster_1, :ls_lotto_ster_2,
		  :ld_peso_netto_iniziale, :ld_peso_netto_scaricato, :ld_peso_netto_da_lav)
		  ;
	   if (SQLCA.SQLCODE = -1) then
			messagebox("DBError", SQLCA.SQLERRTEXT)
		elseif (SQLCA.SQLCODE=0) then
			
			select max(id_lotto)
			into	 :ll_id_lotto
			from	 lotto
			;
			
			select max(num_progressivo)
			into   :ll_num_prog
			from   documento
			where  documento.id_registro = :ll_id_reg_car
			;
			
			if IsNull(ll_num_prog) then 
				ll_num_prog=1
			else
				ll_num_prog++
			end if
			
			
			INSERT INTO documento (id_prof_documento, id_registro, num_progressivo, data_registrazione,
				id_sog_commerciale, id_valuta, id_caus_magazzino, id_locazione_1,
				documento.data_documento, documento.num_documento,	
				documento.tipo_fattura )	
		   VALUES (:ll_id_prof_documento, :ll_id_reg_car, :ll_num_prog, :ldt_data_registrazione,
				:ll_id_sog_comm_prop, :ll_id_valuta_prop, :ll_id_caus_magazzino_prop, 
				:ll_id_locazione_1_prop,
				:ldt_data_registrazione, :ll_num_prog, 'N'	
				);
					
			if (SQLCA.SQLCODE = -1) then
				messagebox("Inserimento Documento di carico - DbError", SQLCA.SQLERRTEXT)
				rollback;
			else
				commit;
			end if
				
			select @@identity 
			into   :ll_id_doc
			from 	 SYS.DUMMY
			;
				
			select prog_materie_prime
			into 	 :ll_id_r_lotto
			from   prog_lotti
			;
				
			ll_id_r_lotto++
				
			update prog_lotti
			set prog_materie_prime = :ll_id_r_lotto
			;
	
			select id_unita_confezione
			into   :ll_id_u_conf
			from   unita_confezione
			where  unita_confezione.id_articolo = :ll_id_articolo
			and    unita_confezione.unita_base='S'
			;
				
			INSERT INTO riga_documento (id_documento, num_riga, id_valuta, 
				id_articolo, quantita, id_riga_lotto,
				descrizione, id_unita_confezione, id_locazione_1, 
				id_caus_magazzino, fat_con_unita_base,
				fat_con_globale, qta_un_base, peso_netto,
				id_tab_iva,		
				cambio, prezzo, prezzo_netto, val_attribuito,	
				tot_riga_val_riga, tot_riga_val_doc, tot_riga_val_az)		
				
			VALUES (:ll_id_doc, 1, :ll_id_valuta_prop, :ll_id_articolo, :ld_qta_iniziale, 
				:ll_id_r_lotto, 
				(select descrizione 
				 from   articolo 
				 where  id_articolo = :ll_id_articolo),
				(select id_unita_confezione
				 from   unita_confezione
				 where  unita_confezione.id_articolo = :ll_id_articolo
				 and    unita_confezione.unita_base='S'),
				 :ll_id_locazione_1_prop, :ll_id_caus_magazzino_prop, 1, 1, 
				 :ld_qta_iniziale, :ld_peso_netto_iniziale,
				 :ll_id_tab_iva, 
				 :ld_r_cambio, :ld_r_prezzo, :ld_r_prezzo_netto, :ld_r_val_attribuito,
				 :ld_r_tot_riga_val_riga, :ld_r_tot_riga_val_doc, :ld_r_tot_riga_val_az
				 )
				;
					
			if (SQLCA.SQLCODE = -1) then
				messagebox("Inserimento Riga Documento di carico - DbError", SQLCA.SQLERRTEXT)
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
					
				select id_val_lire
				into 	 :ll_id_val_lire
				from	 par_sistema		
				;
					
				SELECT cambio
				INTO	 :ld_cambio_l
				FROM	 valuta
				WHERE	 id_valuta = :ll_id_val_lire
				;
				
				
				if (ll_id_valuta_prop = ll_id_val_lire) then
					ld_tot_riga_val_doc_l = ld_r_tot_riga_val_doc
				else
					ld_tot_riga_val_doc_l = ld_r_tot_riga_val_doc * ld_r_cambio / ld_cambio_l
				end if
					
				if (ll_id_tab_iva > 0 and SQLCA.SQLCODE = 0) then
					INSERT INTO cast_iva_documento (id_documento, id_tab_iva, val_imponibile,
									val_imp_scontato, val_tot_imp_v, val_tot_imp_l, val_tot_iva_v,
									val_tot_iva_l)
					VALUES (:ll_id_doc, :ll_id_tab_iva, :ld_r_tot_riga_val_doc, 
									:ld_r_tot_riga_val_doc, :ld_r_tot_riga_val_doc,
									:ld_tot_riga_val_doc_l, (:ld_r_tot_riga_val_doc * :ld_per_aliquota / 100),
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
			end if
		end if
	next
	close(iw_wait)
end if

lt_f = Now()
st_4.text = string(lt_f)
end event

type st_1 from statictext within w_imp_lotto_pf_ff
int X=1989
int Y=32
int Width=165
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Inizio:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_imp_lotto_pf_ff
int X=2162
int Y=32
int Width=334
int Height=76
boolean Enabled=false
boolean BringToTop=true
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_imp_lotto_pf_ff
int X=2638
int Y=32
int Width=133
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Fine:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_4 from statictext within w_imp_lotto_pf_ff
int X=2779
int Y=32
int Width=334
int Height=76
boolean Enabled=false
boolean BringToTop=true
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_lotti_da_imp_gd from u_dw_ext_main within w_imp_lotto_pf_ff
int X=37
int Y=448
int Width=3113
int Height=964
int TabOrder=20
boolean BringToTop=true
string DataObject="ds_lotti_da_imp_gd"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event clicked;call super::clicked;integer li_i, li_rows

if (dwo.name = 'b_deseleziona') then
	li_rows = dw_lotti_da_imp_gd.rowcount()
	if li_rows > 0 then
		for li_i = 1 to li_rows
			dw_lotti_da_imp_gd.object.importa[li_i] = 'N'
		next
	end if
end if
end event

