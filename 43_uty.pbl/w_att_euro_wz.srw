forward
global type w_att_euro_wz from w_wiz_main
end type
type tab_1 from tab within w_att_euro_wz
end type
type tabpage_1 from userobject within tab_1
end type
type dw_att_euro_gen_ext from u_dw_ext_main within tabpage_1
end type
type tabpage_2 from userobject within tab_1
end type
type dw_att_euro_lis_gd from u_dw_ext_main within tabpage_2
end type
type dw_att_euro_lis_ext from u_dw_ext_main within tabpage_2
end type
type tabpage_3 from userobject within tab_1
end type
type dw_att_euro_conlis_ext from u_dw_ext_main within tabpage_3
end type
type dw_att_euro_conlis_gd from u_dw_ext_main within tabpage_3
end type
type dw_att_euro_conlis_ape_gd from u_dw_ext_main within tabpage_3
end type
type tabpage_4 from userobject within tab_1
end type
type dw_att_euro_scag_ext from u_dw_ext_main within tabpage_4
end type
type dw_att_euro_scag_gd from u_dw_ext_main within tabpage_4
end type
type dw_att_euro_scag_ape_gd from u_dw_ext_main within tabpage_4
end type
type dw_att_euro_ext from u_dw_ext_main within w_att_euro_wz
end type
type cb_esci from commandbutton within w_att_euro_wz
end type
type st_1 from statictext within w_att_euro_wz
end type
type tabpage_1 from userobject within tab_1
dw_att_euro_gen_ext dw_att_euro_gen_ext
end type
type tabpage_2 from userobject within tab_1
dw_att_euro_lis_gd dw_att_euro_lis_gd
dw_att_euro_lis_ext dw_att_euro_lis_ext
end type
type tabpage_3 from userobject within tab_1
dw_att_euro_conlis_ext dw_att_euro_conlis_ext
dw_att_euro_conlis_gd dw_att_euro_conlis_gd
dw_att_euro_conlis_ape_gd dw_att_euro_conlis_ape_gd
end type
type tabpage_4 from userobject within tab_1
dw_att_euro_scag_ext dw_att_euro_scag_ext
dw_att_euro_scag_gd dw_att_euro_scag_gd
dw_att_euro_scag_ape_gd dw_att_euro_scag_ape_gd
end type
type tab_1 from tab within w_att_euro_wz
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
end type
end forward

global type w_att_euro_wz from w_wiz_main
int Width=3511
int Height=1896
boolean TitleBar=true
string Title="Utility per impostazione nuova valuta"
tab_1 tab_1
dw_att_euro_ext dw_att_euro_ext
cb_esci cb_esci
st_1 st_1
end type
global w_att_euro_wz w_att_euro_wz

on w_att_euro_wz.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.dw_att_euro_ext=create dw_att_euro_ext
this.cb_esci=create cb_esci
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.dw_att_euro_ext
this.Control[iCurrent+3]=this.cb_esci
this.Control[iCurrent+4]=this.st_1
end on

on w_att_euro_wz.destroy
call super::destroy
destroy(this.tab_1)
destroy(this.dw_att_euro_ext)
destroy(this.cb_esci)
destroy(this.st_1)
end on

event open;call super::open;long	ll_id_val_euro, ll_id_val_lire

dw_att_euro_ext.insertrow(0)

SELECT id_val_euro, id_val_lire
INTO	 :ll_id_val_euro, :ll_id_val_lire
FROM	 par_sistema;

dw_att_euro_ext.setitem(1, "a_id_valuta", ll_id_val_euro)
dw_att_euro_ext.setitem(1, "da_id_valuta", ll_id_val_lire)

DataWindowChild ldw_da_valuta, ldw_a_valuta

dw_att_euro_ext.getchild("da_id_valuta", ldw_da_valuta)
ldw_da_valuta.settransobject(sqlca)
ldw_da_valuta.retrieve()

dw_att_euro_ext.getchild("a_id_valuta", ldw_a_valuta)
ldw_a_valuta.settransobject(sqlca)
ldw_a_valuta.retrieve()

tab_1.tabpage_1.dw_att_euro_gen_ext.insertrow(0)

tab_1.tabpage_2.dw_att_euro_lis_ext.insertrow(0)
tab_1.tabpage_2.dw_att_euro_lis_gd.settransobject(sqlca)

tab_1.tabpage_3.dw_att_euro_conlis_ext.insertrow(0)
tab_1.tabpage_3.dw_att_euro_conlis_gd.settransobject(sqlca)

tab_1.tabpage_4.dw_att_euro_scag_ext.insertrow(0)
tab_1.tabpage_4.dw_att_euro_scag_gd.settransobject(sqlca)

end event

type tab_1 from tab within w_att_euro_wz
int X=32
int Y=216
int Width=3410
int Height=1548
int TabOrder=10
boolean BringToTop=true
boolean RaggedRight=true
int SelectedTab=1
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3,&
this.tabpage_4}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
end on

event selectionchanged;if (newindex= 3) then
	tab_1.tabpage_3.dw_att_euro_conlis_ext.object.data_validita_t.text = "Visualizza le cond. di list. valide alla data:"
	tab_1.tabpage_3.dw_att_euro_conlis_ext.SetValue("storico", 1, "Crea nuove cond. di list. chiudendo quelle selezionate	S")
	tab_1.tabpage_3.dw_att_euro_conlis_ext.SetValue("storico", 2, "Modifica la valuta nelle cond. di list. selezionate	N")
end if

if (newindex= 4) then
	tab_1.tabpage_4.dw_att_euro_scag_ext.object.data_validita_t.text = "Visualizza le cond. di provv. valide alla data:"
	tab_1.tabpage_4.dw_att_euro_scag_ext.SetValue("storico", 1, "Crea nuove cond. di provv. chiudendo quelle selezionate	S")
	tab_1.tabpage_4.dw_att_euro_scag_ext.SetValue("storico", 2, "Modifica la valuta nelle cond. di provv. selezionate	N")
end if
end event

type tabpage_1 from userobject within tab_1
int X=18
int Y=104
int Width=3374
int Height=1428
long BackColor=79741120
string Text="Generale"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_att_euro_gen_ext dw_att_euro_gen_ext
end type

on tabpage_1.create
this.dw_att_euro_gen_ext=create dw_att_euro_gen_ext
this.Control[]={this.dw_att_euro_gen_ext}
end on

on tabpage_1.destroy
destroy(this.dw_att_euro_gen_ext)
end on

type dw_att_euro_gen_ext from u_dw_ext_main within tabpage_1
event ue_aggiorna ( )
int X=37
int Y=48
int Width=2505
int Height=1084
int TabOrder=40
boolean BringToTop=true
string DataObject="d_att_euro_gen_ext"
end type

event ue_aggiorna;char  lc_prof_documento, lc_prof_registrazione, lc_anagrafica, lc_par_sistema
char	lc_articolo, lc_spese
long	ll_a_id_valuta, ll_da_id_valuta, ll_id_valuta, ll_id_spesa
integer	li_rows, li_i, li_ret
decimal	ld_costo_aggiuntivo

ll_a_id_valuta = dw_att_euro_ext.getitemnumber(1, "a_id_valuta")
ll_da_id_valuta= dw_att_euro_ext.getitemnumber(1, "da_id_valuta")
if (isnull(ll_a_id_valuta)) then return

integer	li_dec_significativi, li_cifra_arrotondamento

SELECT dec_significativi, cifra_arrotondamento
INTO	 :li_dec_significativi, :li_cifra_arrotondamento
FROM	 valuta
WHERE  id_valuta = :ll_a_id_valuta
;

if (sqlca.sqlcode = -1) then
	messagebox("dberror", sqlca.sqlerrtext)
	return
end if

if (isnull(li_dec_significativi) or isnull(li_cifra_arrotondamento)) then 
	messagebox("Attenzione", "Nella valuta di destinazione non sono stati specificati i dec. e la cifra di arrotondamento")
	return
end if

if (li_dec_significativi < 0) then li_dec_significativi = li_dec_significativi * -1
if (li_cifra_arrotondamento < 0) then li_cifra_arrotondamento = li_cifra_arrotondamento * -1

lc_prof_documento = this.getitemstring(1, "prof_documento")
if (lc_prof_documento = 'S') then
	if (ll_da_id_valuta > 0) then
		UPDATE prof_documento
		SET    id_valuta_prop = :ll_a_id_valuta
		WHERE  id_valuta_prop = :ll_da_id_valuta;
	else
		UPDATE prof_documento
		SET    id_valuta_prop = :ll_a_id_valuta;		
	end if
	
	if (sqlca.sqlcode = -1) then
		messagebox("Prof. Documenti/DbError", sqlca.sqlerrtext)
	else
		messagebox("Prof.Documenti", "Sono stati modificati " + string(sqlca.sqlnrows) + " profili documento")
	end if
end if

lc_prof_registrazione = getitemstring(1, "prof_registrazione")

if (lc_prof_registrazione = 'S') then
	if (ll_da_id_valuta > 0) then
		UPDATE prof_registrazione
		SET    id_valuta = :ll_a_id_valuta
		WHERE  id_valuta = :ll_da_id_valuta;
	else
		UPDATE prof_registrazione
		SET    id_valuta = :ll_a_id_valuta;
	end if
	
	if (sqlca.sqlcode = -1) then
		messagebox("Prof. registrazione/DbError", sqlca.sqlerrtext)
	else
		messagebox("Prof. registrazione", "Sono stati modificati " + string(sqlca.sqlnrows) + " Prof. registrazione")
	end if
		
end if

lc_anagrafica = this.getitemstring(1, "anagrafica")

if (lc_anagrafica = 'S') then
	if (ll_da_id_valuta > 0) then
		UPDATE spesa_sog_commerciale
		SET	 importo = ROUND(fn_conv_valuta(:ll_da_id_valuta, importo, :ll_a_id_valuta), :li_dec_significativi)
		WHERE  importo IS NOT NULL
		;

		UPDATE anagrafica
		SET    id_valuta = :ll_a_id_valuta
		WHERE  id_valuta = :ll_da_id_valuta
		;
	end if

	if (sqlca.sqlcode = -1) then
		messagebox("Anagrafiche Condivise/DbError", sqlca.sqlerrtext)
	else
		messagebox("Anagrafiche Condivise", "Sono state modificate " + string(sqlca.sqlnrows) + " Anagrafiche Condivise")
	end if
		
end if

lc_par_sistema = this.getitemstring(1, "par_sistema")

if (lc_par_sistema = 'S') then
	SELECT id_valuta
	INTO	 :ll_id_valuta
	FROM	 par_sistema
	;
	
	UPDATE par_sistema
	SET    id_valuta = :ll_a_id_valuta,
			 imp_fisso = ROUND(fn_conv_valuta(:ll_id_valuta, imp_fisso, :ll_a_id_valuta), :li_dec_significativi)
	;
	
	if (sqlca.sqlcode = -1) then &
		messagebox("Prof. registrazione/DbError", sqlca.sqlerrtext)
end if

lc_articolo = this.getitemstring(1, "articolo")

if (lc_articolo = 'S') then
	uo_articolo ds_art
	ds_art = CREATE uo_articolo
	ds_art.settransobject(sqlca)
	
	li_rows = ds_art.event ue_retrieve(ll_da_id_valuta, ll_a_id_valuta)
	if (li_rows <= 0) then 
		messagebox("Articoli", "Non ci sono articoli da aggiornare")
		return
	end if
	
	for li_i = 1 to li_rows
		ds_art.setitem(li_i, "id_valuta", ll_a_id_valuta)
		ld_costo_aggiuntivo = ds_art.getitemnumber(li_i, "c_costo_aggiuntivo")
		ld_costo_aggiuntivo = round(ld_costo_aggiuntivo, li_cifra_arrotondamento)
		if (ld_costo_aggiuntivo > 0) then &
			ds_art.setitem(li_i, "costo_aggiuntivo", ld_costo_aggiuntivo)
	next
	
	ds_art.update()
	if li_ret = -1 then
		messagebox("Articoli", "Verificare l'errore e ripeter l'operazione")
	end if	
	
	DESTROY ds_art
end if

lc_spese = this.getitemstring(1, "spese")
if (lc_spese = 'S') then
	uo_att_euro_spese ds_spese
	ds_spese = CREATE uo_att_euro_spese
	ds_spese.settransobject(sqlca)
	
	li_rows = ds_spese.event ue_retrieve(ll_da_id_valuta, ll_a_id_valuta)
	if (li_rows <= 0) then return
	
	for li_i = 1 to li_rows
		ll_id_spesa = ds_spese.getitemnumber(li_i, "id_spesa")
		UPDATE spesa
		SET	 id_valuta = :ll_a_id_valuta
		WHERE  id_spesa = :ll_id_spesa
		;
		
		if (sqlca.sqlcode = -1) then
			messagebox("Spesa/DbError", sqlca.sqlerrtext)
			continue
		end if
		
		ds_spese.setitem(li_i, "riga_spesa_da_imponibile", ds_spese.getitemnumber(li_i, "c_da_imponibile"))
		ds_spese.setitem(li_i, "riga_spesa_a_imponibile", ds_spese.getitemnumber(li_i, "c_a_imponibile"))		
		ds_spese.setitem(li_i, "riga_spesa_importo", round(ds_spese.getitemnumber(li_i, "c_importo"), li_dec_significativi))
		ds_spese.update()
		if li_ret = -1 then
			messagebox("Spesa " + ds_spese.getitemstring(li_i, "spesa_codice"), "Verificare l'errore e ripetere l'operazione")
			continue
		end if
	next
	
	ds_spese.update()
	if li_ret = -1 then
		messagebox("Spese", "Verificare l'errore e ripeter l'operazione")
	else
		messagebox("Spese", "Terminato aggiornamento spese")
	end if
		
end if

if li_rows > 0 then &
	messagebox("Generale", "Aggiornamento terminato")


end event

event clicked;call super::clicked;CHOOSE CASE dwo.name
	CASE "cb_aggiorna"
		event ue_aggiorna()
END CHOOSE
end event

type tabpage_2 from userobject within tab_1
int X=18
int Y=104
int Width=3374
int Height=1428
long BackColor=79741120
string Text="Listini"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_att_euro_lis_gd dw_att_euro_lis_gd
dw_att_euro_lis_ext dw_att_euro_lis_ext
end type

on tabpage_2.create
this.dw_att_euro_lis_gd=create dw_att_euro_lis_gd
this.dw_att_euro_lis_ext=create dw_att_euro_lis_ext
this.Control[]={this.dw_att_euro_lis_gd,&
this.dw_att_euro_lis_ext}
end on

on tabpage_2.destroy
destroy(this.dw_att_euro_lis_gd)
destroy(this.dw_att_euro_lis_ext)
end on

type dw_att_euro_lis_gd from u_dw_ext_main within tabpage_2
int X=46
int Y=508
int Width=3278
int Height=884
int TabOrder=11
boolean BringToTop=true
string DataObject="d_att_euro_lis_gd"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event sqlpreview;long		ll_da_id_valuta
string	ls_sql

ll_da_id_valuta = dw_att_euro_ext.getitemnumber(1, "da_id_valuta")

ls_sql = sqlsyntax
if (ll_da_id_valuta > 0 and sqltype = PreviewSelect!) then
	ls_sql = ls_sql + " AND listino.id_valuta = " + string(ll_da_id_valuta)
	ls_sql = ls_sql + " ORDER BY listino.tipo, listino.codice, variazione.data_inizio"
end if
this.setsqlpreview(ls_sql)	
end event

type dw_att_euro_lis_ext from u_dw_ext_main within tabpage_2
event ue_aggiorna ( )
int X=46
int Y=48
int Width=3278
int Height=396
int TabOrder=11
boolean BringToTop=true
string DataObject="d_att_euro_lis_ext"
end type

event ue_aggiorna;char 		lc_storico, lc_lis_base, lc_seleziona
integer	li_rows, li_i, li_ret 
date		ldt_data_chiusura, ldt_data_apertura
string	ls_codice
long		ll_id_valuta, ll_id_listino, ll_id_listino_new, ll_id_valuta_old 
long		ll_id_variazione_old, ll_id_variazione_new
long		ll_id_variazione

lc_storico = this.getitemstring(1, "storico")
li_rows = tab_1.tabpage_2.dw_att_euro_lis_gd.rowcount()
if (li_rows <= 0) then return

ll_id_valuta = dw_att_euro_ext.getitemnumber(1, "a_id_valuta")
if (isnull(ll_id_valuta)) then return

integer	li_dec_significativi, li_cifra_arrotondamento

SELECT dec_significativi, cifra_arrotondamento
INTO	 :li_dec_significativi, :li_cifra_arrotondamento
FROM	 valuta
WHERE  id_valuta = :ll_id_valuta
;

if (sqlca.sqlcode = -1) then
	messagebox("dberror", sqlca.sqlerrtext)
	return
end if

if (isnull(li_dec_significativi) or isnull(li_cifra_arrotondamento)) then 
	messagebox("Attenzione", "Nella valuta di destinazione non sono stati specificati i dec. e la cifra di arrotondamento")
	return
end if

if (li_dec_significativi < 0) then li_dec_significativi = li_dec_significativi * -1
if (li_cifra_arrotondamento < 0) then li_cifra_arrotondamento = li_cifra_arrotondamento * -1

if (lc_storico = 'S') then
	ldt_data_chiusura = this.getitemdate(1, "data_fine")
	ldt_data_apertura = this.getitemdate(1, "data_inizio")
			
	if (isnull(ldt_data_chiusura) or isnull(ldt_data_apertura)) then
		messagebox("Attenzione", "Per mantenere i listini, devono essere specificate entrambe le date ...")
		return
	end if
	
	for li_i = 1 to li_rows
		ls_codice = tab_1.tabpage_2.dw_att_euro_lis_gd.getitemstring(li_i, "c_nuovo_codice")
		
		if (not (isnull(ls_codice) or ls_codice = '')) then
			
			tab_1.tabpage_2.dw_att_euro_lis_gd.setitem(li_i, "variazione_data_fine", ldt_data_chiusura)
			li_ret = tab_1.tabpage_2.dw_att_euro_lis_gd.update()
			
			if li_ret = -1 then
				messagebox("Attenzione", "Verificare l'errore e ripeter l'operazione")
				return
			end if

			
			ll_id_listino = tab_1.tabpage_2.dw_att_euro_lis_gd.getitemnumber(li_i, "listino_id_listino")
			
			
			INSERT INTO listino (codice, descrizione, tipo, id_valuta, id_azienda, lis_base)
			SELECT :ls_codice, descrizione, tipo, :ll_id_valuta, id_azienda, NULL
			FROM	 listino
			WHERE  id_listino = :ll_id_listino
			AND	 NOT EXISTS( SELECT 1
								    FROM	  listino
									 WHERE  codice = :ls_codice)
			;
			
			if (sqlca.sqlcode = -1) then 
				messagebox("Listini/DbError", sqlca.sqlerrtext)
				ROLLBACK;
				return
			end if
			
			if (sqlca.sqlnrows = 0) then
				tab_1.tabpage_2.dw_att_euro_lis_gd.setitem(li_i, "c_note", "Esiste già un listino con codice " + ls_codice + ". Ripetere l'aggiornamento con un codice diverso.")
				tab_1.tabpage_2.dw_att_euro_lis_gd.object.c_note.Color='395007'
				continue
			end if				
			
			
			
			SELECT @@identity
			INTO	 :ll_id_variazione_new
			FROM	 SYS.DUMMY;
			
			if (sqlca.sqlcode = -1) then 
				messagebox("Listini/DbError", sqlca.sqlerrtext)
				return
			end if
			
			COMMIT;

			SELECT id_listino
			INTO	 :ll_id_listino_new
			FROM	 variazione
			WHERE  id_variazione = :ll_id_variazione_new
			;
			
			if (sqlca.sqlcode = -1) then 
				messagebox("Listini/DbError", sqlca.sqlerrtext)
				return
			end if
			
			lc_lis_base = tab_1.tabpage_2.dw_att_euro_lis_gd.getitemstring(li_i, "listino_lis_base")
			
			if (lc_lis_base = 'S') then
				UPDATE listino
				SET    lis_base = NULL
				WHERE  id_listino = :ll_id_listino
				;
				
				if (sqlca.sqlcode = -1) then 
					messagebox("Listini/DbError", sqlca.sqlerrtext)
					ROLLBACK;
					return
				end if
				
				COMMIT;
			
				UPDATE listino
				SET    lis_base = 'S'
				WHERE  id_listino = :ll_id_listino_new
				;		
				
				if (sqlca.sqlcode = -1) then 
					messagebox("Listini/DbError", sqlca.sqlerrtext)
					ROLLBACK;
					return
				end if
				
				COMMIT;
				
			end if
			
			
			UPDATE variazione
			SET data_inizio = :ldt_data_apertura
			WHERE id_variazione = :ll_id_variazione_new;
			
			if (sqlca.sqlcode = -1) then 
				messagebox("Listini/DbError", sqlca.sqlerrtext)
				ROLLBACK;
				return
			end if
			
			COMMIT;
			
			
			ll_id_valuta_old 		= tab_1.tabpage_2.dw_att_euro_lis_gd.getitemnumber(li_i, "listino_id_valuta")
			ll_id_variazione_old = tab_1.tabpage_2.dw_att_euro_lis_gd.getitemnumber(li_i, "variazione_id_variazione")

			INSERT INTO prezzo (id_unita_confezione, id_variazione, prezzo)
			SELECT id_unita_confezione, :ll_id_variazione_new, ROUND(FN_CONV_VALUTA(:ll_id_valuta_old, prezzo, :ll_id_valuta), :li_cifra_arrotondamento)
			FROM	 prezzo
			WHERE  id_variazione = :ll_id_variazione_old;

			if (sqlca.sqlcode = -1) then
				messagebox("Listini/DbError", sqlca.sqlerrtext)
				ROLLBACK;
				return
			end if
			
			COMMIT;
			
			
			UPDATE sog_commerciale 
			SET	 id_listino = :ll_id_listino_new
			WHERE  id_listino = :ll_id_listino
			;
			
			if (sqlca.sqlcode = -1) then
				messagebox("Listini/DbError", sqlca.sqlerrtext)
				ROLLBACK;
				return
			end if
			
			COMMIT;			
			
			
			
			UPDATE con_lis_articolo 
			SET	 id_listino = :ll_id_listino_new
			WHERE  id_listino = :ll_id_listino
			AND	 data_inizio = :ldt_data_apertura
			AND	 data_fine IS NULL
			;
			
			if (sqlca.sqlcode = -1) then
				messagebox("Listini/DbError", sqlca.sqlerrtext)
				ROLLBACK;
				return
			end if
			
			COMMIT;		
			
			UPDATE prof_documento 
			SET	 id_listino_prop = :ll_id_listino_new
			WHERE  id_listino_prop = :ll_id_listino
			;
			
			if (sqlca.sqlcode = -1) then
				messagebox("Listini/DbError", sqlca.sqlerrtext)
				ROLLBACK;
				return
			end if
			
			COMMIT;			
			
			UPDATE rch_par_sistema
			SET	 id_listino = :ll_id_listino_new
			WHERE  id_listino = :ll_id_listino
			;
			
			if (sqlca.sqlcode = -1) then
				messagebox("Listini/DbError", sqlca.sqlerrtext)
				ROLLBACK;
				return
			end if
			
			COMMIT;			
			
			UPDATE rch_par_sistema
			SET	 id_listino2 = :ll_id_listino_new
			WHERE  id_listino2 = :ll_id_listino
			;
			
			if (sqlca.sqlcode = -1) then
				messagebox("Listini/DbError", sqlca.sqlerrtext)
				ROLLBACK;
				return
			end if
			
			COMMIT;			
			
			tab_1.tabpage_2.dw_att_euro_lis_gd.setitem(li_i, "c_note", "Il listino è stato creato")
			tab_1.tabpage_2.dw_att_euro_lis_gd.object.c_note.Color='16711680'
		end if
	next
	if li_rows > 0 then &
		messagebox("Listini", "Aggiornamento terminato")	
	
else
	for li_i = 1 to li_rows
		lc_seleziona = tab_1.tabpage_2.dw_att_euro_lis_gd.getitemstring(li_i, "c_seleziona")
		if (lc_seleziona = 'S') then
			ll_id_listino 			= tab_1.tabpage_2.dw_att_euro_lis_gd.getitemnumber(li_i, "listino_id_listino")
			ll_id_valuta_old 		= tab_1.tabpage_2.dw_att_euro_lis_gd.getitemnumber(li_i, "listino_id_valuta")
			ll_id_variazione 		= tab_1.tabpage_2.dw_att_euro_lis_gd.getitemnumber(li_i, "variazione_id_variazione")
			
			UPDATE listino
			SET	 id_valuta = :ll_id_valuta
			WHERE  id_listino = :ll_id_listino
			;
			
			if (sqlca.sqlcode = -1) then
				messagebox("Listini/DbError", sqlca.sqlerrtext)
				ROLLBACK;
				return
			end if
			
			COMMIT;
			
			UPDATE prezzo
			SET	 prezzo = ROUND(FN_CONV_VALUTA(:ll_id_valuta_old, prezzo, :ll_id_valuta), :li_cifra_arrotondamento)
			WHERE  id_variazione = :ll_id_variazione;

			if (sqlca.sqlcode = -1) then
				messagebox("Listini/DbError", sqlca.sqlerrtext)
				ROLLBACK;
				return
			end if
			
			COMMIT;
			tab_1.tabpage_2.dw_att_euro_lis_gd.setitem(li_i, "c_note", "Il listino è stato modificato")
			tab_1.tabpage_2.dw_att_euro_lis_gd.object.c_note.Color='16711680'			
		end if
	next
	if li_rows > 0 then &
		messagebox("Listini", "Aggiornamento terminato")
end if
end event

event clicked;call super::clicked;CHOOSE CASE dwo.name
	CASE "cb_visualizza"
		date 	ldt_data_validita
		char 	lc_storico
		long	ll_a_id_valuta, ll_da_id_valuta
		
		ldt_data_validita = this.getitemdate(1, "data_validita")
		lc_storico = this.getitemstring(1, "storico")
		ll_a_id_valuta = dw_att_euro_ext.getitemnumber(1, "a_id_valuta")
		ll_da_id_valuta = dw_att_euro_ext.getitemnumber(1, "da_id_valuta")
		
		if (isnull(ldt_data_validita)) then ldt_data_validita = today()
		if (isnull(ll_a_id_valuta)) then return
		tab_1.tabpage_2.dw_att_euro_lis_gd.retrieve(ldt_data_validita, lc_storico, ll_a_id_valuta, ll_da_id_valuta)
		
	CASE "cb_aggiorna"
		event ue_aggiorna()
		
END CHOOSE
end event

event itemchanged;CHOOSE CASE dwo.name
	CASE "storico"
		date 	ldt_data_validita
		long	ll_a_id_valuta
		
		ldt_data_validita = this.getitemdate(1, "data_validita")
		ll_a_id_valuta = dw_att_euro_ext.getitemnumber(1, "a_id_valuta")
		
		if (isnull(ldt_data_validita)) then ldt_data_validita = today()
		if (isnull(ll_a_id_valuta)) then return
		tab_1.tabpage_2.dw_att_euro_lis_gd.retrieve(ldt_data_validita, data, ll_a_id_valuta)
END CHOOSE
		
end event

type tabpage_3 from userobject within tab_1
int X=18
int Y=104
int Width=3374
int Height=1428
long BackColor=79741120
string Text="Cond. di Listino"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_att_euro_conlis_ext dw_att_euro_conlis_ext
dw_att_euro_conlis_gd dw_att_euro_conlis_gd
dw_att_euro_conlis_ape_gd dw_att_euro_conlis_ape_gd
end type

on tabpage_3.create
this.dw_att_euro_conlis_ext=create dw_att_euro_conlis_ext
this.dw_att_euro_conlis_gd=create dw_att_euro_conlis_gd
this.dw_att_euro_conlis_ape_gd=create dw_att_euro_conlis_ape_gd
this.Control[]={this.dw_att_euro_conlis_ext,&
this.dw_att_euro_conlis_gd,&
this.dw_att_euro_conlis_ape_gd}
end on

on tabpage_3.destroy
destroy(this.dw_att_euro_conlis_ext)
destroy(this.dw_att_euro_conlis_gd)
destroy(this.dw_att_euro_conlis_ape_gd)
end on

type dw_att_euro_conlis_ext from u_dw_ext_main within tabpage_3
event ue_aggiorna ( )
int X=41
int Y=48
int Width=3296
int Height=376
int TabOrder=11
boolean BringToTop=true
string DataObject="d_att_euro_lis_ext"
end type

event ue_aggiorna;char 		lc_storico, lc_lis_base, lc_seleziona
integer	li_rows, li_i, li_ret 
date		ldt_data_chiusura, ldt_data_apertura
string	ls_codice
long		ll_a_id_valuta, ll_id_listino, ll_id_listino_new, ll_id_valuta_old
long		ll_id_variazione_old, ll_id_variazione_new
long		ll_id_variazione

long		ll_id_con_lis_articolo, ll_null
decimal	ld_importo, ld_spesa_fissa
date		ldt_null

setnull(ll_null)
setnull(ldt_null)

lc_storico = this.getitemstring(1, "storico")
li_rows = tab_1.tabpage_3.dw_att_euro_conlis_gd.rowcount()
if (li_rows <= 0) then return

ll_a_id_valuta = dw_att_euro_ext.getitemnumber(1, "a_id_valuta")
if (isnull(ll_a_id_valuta)) then return

ll_id_valuta_old = dw_att_euro_ext.getitemnumber(1, "da_id_valuta")

tab_1.tabpage_3.dw_att_euro_conlis_gd.setfilter("c_selezione = 'S'")
tab_1.tabpage_3.dw_att_euro_conlis_gd.filter()

li_rows = tab_1.tabpage_3.dw_att_euro_conlis_gd.rowcount()
if (li_rows <= 0) then return

integer	li_dec_significativi, li_cifra_arrotondamento

SELECT dec_significativi, cifra_arrotondamento
INTO	 :li_dec_significativi, :li_cifra_arrotondamento
FROM	 valuta
WHERE  id_valuta = :ll_a_id_valuta
;

if (sqlca.sqlcode = -1) then
	messagebox("dberror", sqlca.sqlerrtext)
	return
end if

if (isnull(li_dec_significativi) or isnull(li_cifra_arrotondamento)) then 
	messagebox("Attenzione", "Nella valuta di destinazione non sono stati specificati i dec. e la cifra di arrotondamento")
	return
end if

if (li_dec_significativi < 0) then li_dec_significativi = li_dec_significativi * -1
if (li_cifra_arrotondamento < 0) then li_cifra_arrotondamento = li_cifra_arrotondamento * -1

if (lc_storico = 'S') then
	ldt_data_chiusura = this.getitemdate(1, "data_fine")
	ldt_data_apertura = this.getitemdate(1, "data_inizio")

	if (isnull(ldt_data_chiusura) or isnull(ldt_data_apertura)) then
		messagebox("Attenzione", "Per mantenere le cond. di listino, devono essere specificate entrambe le date ...")
		return
	end if
	
end if

tab_1.tabpage_3.dw_att_euro_conlis_ape_gd.reset()

for li_i = 1 to li_rows
	tab_1.tabpage_3.dw_att_euro_conlis_gd.scrolltorow(li_i)
	if (lc_storico = 'S') then
		
		tab_1.tabpage_3.dw_att_euro_conlis_gd.setitem(li_i, "data_fine", ldt_data_chiusura)
		li_ret = tab_1.tabpage_3.dw_att_euro_conlis_gd.update()

		if li_ret = -1 then
			messagebox("Condizioni di listino - chiusura/ Attenzione", "Verificare l'errore e ripetere l'operazione")
			return
		end if		
	end if

	tab_1.tabpage_3.dw_att_euro_conlis_ape_gd.settransobject(sqlca)
	
	tab_1.tabpage_3.dw_att_euro_conlis_gd.RowsCopy(li_i, li_i, Primary!, tab_1.tabpage_3.dw_att_euro_conlis_ape_gd, li_i, Primary!)
	tab_1.tabpage_3.dw_att_euro_conlis_ape_gd.scrolltorow(li_i)

	if (lc_storico = 'S') then
		tab_1.tabpage_3.dw_att_euro_conlis_ape_gd.setitem(li_i, "id_con_lis_articolo", ll_null)
	else
		tab_1.tabpage_3.dw_att_euro_conlis_ape_gd.setitemstatus(li_i, 0, Primary!, DataModified!)
	end if
	
	tab_1.tabpage_3.dw_att_euro_conlis_ape_gd.setitem(li_i, "id_valuta", ll_a_id_valuta)
	if (lc_storico = 'S') then
		tab_1.tabpage_3.dw_att_euro_conlis_ape_gd.setitem(li_i, "data_inizio", ldt_data_apertura)		
		tab_1.tabpage_3.dw_att_euro_conlis_ape_gd.setitem(li_i, "data_fine", ldt_null)				
	end if
		
	ll_id_valuta_old = tab_1.tabpage_3.dw_att_euro_conlis_gd.getitemnumber(li_i, "id_valuta")
	ld_importo = tab_1.tabpage_3.dw_att_euro_conlis_gd.getitemnumber(li_i, "importo")

	If (ll_a_id_valuta > 0) then
		SELECT ROUND(FN_CONV_VALUTA(:ll_id_valuta_old, :ld_importo, :ll_a_id_valuta), :li_cifra_arrotondamento)
		INTO	 :ld_importo
		FROM	 SYS.DUMMY;
		
		if (sqlca.sqlcode = -1) then &
			messagebox("Condizioni di Listino/DbError", sqlca.sqlerrtext)
			
		if (sqlca.sqlcode = 0) then &
				tab_1.tabpage_3.dw_att_euro_conlis_ape_gd.setitem(li_i, "importo", ld_importo)
	end if

	ld_spesa_fissa = tab_1.tabpage_3.dw_att_euro_conlis_gd.getitemnumber(li_i, "spesa_fissa")

	If (ll_a_id_valuta > 0) then
		SELECT ROUND(FN_CONV_VALUTA(:ll_id_valuta_old, :ld_spesa_fissa, :ll_a_id_valuta), :li_dec_significativi)
		INTO	 :ld_spesa_fissa
		FROM	 SYS.DUMMY;
			
		if (sqlca.sqlcode = -1) then &
			messagebox("Condizioni di Listino/DbError", sqlca.sqlerrtext)
		
		if (sqlca.sqlcode = 0) then &
			tab_1.tabpage_3.dw_att_euro_conlis_ape_gd.setitem(li_i, "spesa_fissa", ld_spesa_fissa)
	end if
	
	li_ret = tab_1.tabpage_3.dw_att_euro_conlis_ape_gd.update()
	
	if li_ret = -1 then
		messagebox("Condizioni di listino - nuove/Attenzione", "Verificare l'errore e ripeter l'operazione")
		return
	end if
		
	tab_1.tabpage_3.dw_att_euro_conlis_gd.setitem(li_i, "c_note", "OK")
	tab_1.tabpage_3.dw_att_euro_conlis_gd.object.c_note.color = '16711680'
next

li_ret = tab_1.tabpage_3.dw_att_euro_conlis_ape_gd.update()

if li_ret = -1 then
	messagebox("Condizioni di listino - nuove/Attenzione", "Verificare l'errore e ripeter l'operazione")
	return
end if

if li_rows > 0 then &
	messagebox("Condizioni di Listino", "Aggiornamento terminato")
end event

event clicked;call super::clicked;CHOOSE CASE dwo.name
	CASE "cb_visualizza"
		date 	ldt_data_validita
		char 	lc_storico
		long	ll_a_id_valuta
		
		ldt_data_validita = this.getitemdate(1, "data_validita")
		lc_storico = this.getitemstring(1, "storico")
		ll_a_id_valuta = dw_att_euro_ext.getitemnumber(1, "a_id_valuta")
		
		if (isnull(ldt_data_validita)) then ldt_data_validita = today()
		if (isnull(ll_a_id_valuta)) then return
		
		tab_1.tabpage_3.dw_att_euro_conlis_gd.setfilter("")
		tab_1.tabpage_3.dw_att_euro_conlis_gd.filter()
		tab_1.tabpage_3.dw_att_euro_conlis_gd.retrieve(ldt_data_validita, ll_a_id_valuta)
		tab_1.tabpage_3.dw_att_euro_conlis_ape_gd.reset()		
		
	CASE "cb_aggiorna"
		event ue_aggiorna()
		
END CHOOSE
end event

type dw_att_euro_conlis_gd from u_dw_ext_main within tabpage_3
int X=41
int Y=444
int Width=1609
int Height=952
int TabOrder=11
boolean BringToTop=true
string DataObject="d_att_euro_conlis_gd"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event sqlpreview;long		ll_da_id_valuta
string	ls_sql

ll_da_id_valuta = dw_att_euro_ext.getitemnumber(1, "da_id_valuta")

ls_sql = sqlsyntax
if (ll_da_id_valuta > 0 and sqltype = PreviewSelect!) then
	ls_sql = ls_sql + " AND con_lis_articolo.id_valuta = " + string(ll_da_id_valuta)
	ls_sql = ls_sql + " ORDER BY id_con_lis_articolo"
	this.setsqlpreview(ls_sql)	
end if
end event

event doubleclicked;integer li_i, li_rows

if dwo.name = 'c_selezione_t' then
	li_rows = this.rowcount()
	if li_rows > 0 then
		if (this.getitemstring(1, "c_selezione") = "S") then
			for li_i = 1 to li_rows
				this.setitem(li_i, "c_selezione", "N")
			next
		else
			for li_i = 1 to li_rows
				this.setitem(li_i, "c_selezione", "S")
			next
		end if
	end if
end if
end event

type dw_att_euro_conlis_ape_gd from u_dw_ext_main within tabpage_3
int X=1664
int Y=444
int Width=1673
int Height=952
int TabOrder=11
boolean BringToTop=true
string DataObject="d_att_euro_conlis_gd"
boolean HScrollBar=true
boolean VScrollBar=true
end type

type tabpage_4 from userobject within tab_1
int X=18
int Y=104
int Width=3374
int Height=1428
long BackColor=79741120
string Text="Cond. di Provv.."
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_att_euro_scag_ext dw_att_euro_scag_ext
dw_att_euro_scag_gd dw_att_euro_scag_gd
dw_att_euro_scag_ape_gd dw_att_euro_scag_ape_gd
end type

on tabpage_4.create
this.dw_att_euro_scag_ext=create dw_att_euro_scag_ext
this.dw_att_euro_scag_gd=create dw_att_euro_scag_gd
this.dw_att_euro_scag_ape_gd=create dw_att_euro_scag_ape_gd
this.Control[]={this.dw_att_euro_scag_ext,&
this.dw_att_euro_scag_gd,&
this.dw_att_euro_scag_ape_gd}
end on

on tabpage_4.destroy
destroy(this.dw_att_euro_scag_ext)
destroy(this.dw_att_euro_scag_gd)
destroy(this.dw_att_euro_scag_ape_gd)
end on

type dw_att_euro_scag_ext from u_dw_ext_main within tabpage_4
event ue_aggiorna ( )
int X=41
int Y=44
int Width=3287
int Height=396
int TabOrder=11
boolean BringToTop=true
string DataObject="d_att_euro_lis_ext"
end type

event ue_aggiorna;char 		lc_storico, lc_lis_base, lc_seleziona
integer	li_rows, li_i, li_ret 
date		ldt_data_chiusura, ldt_data_apertura
string	ls_codice
long		ll_a_id_valuta, ll_id_listino, ll_id_listino_new, ll_id_valuta_old
long		ll_id_variazione_old, ll_id_variazione_new
long		ll_id_variazione
long		ll_id_con_provvigione_old, ll_id_con_provvigione_new

long		ll_id_con_lis_articolo, ll_null
decimal	ld_importo, ld_spesa_fissa
date		ldt_null
decimal  ld_da_imp_sconto, ld_a_imp_sconto
decimal	ld_imp_prov_capo_area, ld_imp_prov_agente, ld_imp_prov_sub_agente

setnull(ll_null)
setnull(ldt_null)

lc_storico = this.getitemstring(1, "storico")

ll_a_id_valuta = dw_att_euro_ext.getitemnumber(1, "a_id_valuta")
if (isnull(ll_a_id_valuta)) then return

tab_1.tabpage_4.dw_att_euro_scag_gd.setfilter("c_selezione = 'S'")
tab_1.tabpage_4.dw_att_euro_scag_gd.filter()

li_rows = tab_1.tabpage_4.dw_att_euro_scag_gd.rowcount()
if (li_rows <= 0) then return

tab_1.tabpage_4.dw_att_euro_scag_ape_gd.reset()

if (lc_storico = 'S') then
	ldt_data_chiusura = this.getitemdate(1, "data_fine")
	ldt_data_apertura = this.getitemdate(1, "data_inizio")

	if (isnull(ldt_data_chiusura) or isnull(ldt_data_apertura)) then
		messagebox("Attenzione", "Per mantenere le cond. di provv., devono essere specificate entrambe le date ...")
		return
	end if
end if

integer	li_dec_significativi, li_cifra_arrotondamento

SELECT dec_significativi, cifra_arrotondamento
INTO	 :li_dec_significativi, :li_cifra_arrotondamento
FROM	 valuta
WHERE  id_valuta = :ll_a_id_valuta
;

if (sqlca.sqlcode = -1) then
	messagebox("dberror", sqlca.sqlerrtext)
	return
end if

if (isnull(li_dec_significativi) or isnull(li_cifra_arrotondamento)) then 
	messagebox("Attenzione", "Nella valuta di destinazione non sono stati specificati i dec. e la cifra di arrotondamento")
	return
end if

if (li_dec_significativi < 0) then li_dec_significativi = li_dec_significativi * -1
if (li_cifra_arrotondamento < 0) then li_cifra_arrotondamento = li_cifra_arrotondamento * -1

for li_i = 1 to li_rows
	ll_id_con_provvigione_old = tab_1.tabpage_4.dw_att_euro_scag_gd.getitemnumber(li_i, "id_con_provvigione")
	if (lc_storico = 'S') then
		
		tab_1.tabpage_4.dw_att_euro_scag_gd.setitem(li_i, "data_fine", ldt_data_chiusura)
		UPDATE con_provvigione 
		SET	 data_fine = :ldt_data_chiusura
		WHERE  id_con_provvigione = :ll_id_con_provvigione_old
		;
		
		if sqlca.sqlcode = -1 then
			messagebox("Condizioni di provv. - chiusura/ Attenzione", sqlca.sqlerrtext)
			return
		end if		
		
		COMMIT;		
	end if
	
	tab_1.tabpage_4.dw_att_euro_scag_ape_gd.settransobject(sqlca)
	tab_1.tabpage_4.dw_att_euro_scag_gd.RowsCopy(li_i, li_i, Primary!, tab_1.tabpage_4.dw_att_euro_scag_ape_gd, 99999, Primary!)

	tab_1.tabpage_4.dw_att_euro_scag_ape_gd.setitem(li_i, "id_valuta", ll_a_id_valuta)
		
	if (lc_storico = 'S') then
		
		INSERT INTO con_provvigione (id_gruppo_agenti, id_sog_commerciale, id_cat_com_sc,
			id_unita_confezione, id_articolo, id_cat_com_articolo, priorita,
			id_azienda, data_inizio, data_fine, id_articolo_a, id_cat_merceologica,
			id_anagrafica)
		SELECT id_gruppo_agenti, id_sog_commerciale, id_cat_com_sc,
			id_unita_confezione, id_articolo, id_cat_com_articolo, priorita,
			id_azienda, :ldt_data_apertura, NULL, id_articolo_a, id_cat_merceologica,
			id_anagrafica
		FROM	 con_provvigione 
		WHERE  id_con_provvigione = :ll_id_con_provvigione_old
		;
		
		if sqlca.sqlcode = -1 then
			messagebox("Condizioni di provv. - chiusura/ Attenzione", sqlca.sqlerrtext)
			return
		end if		
		
		COMMIT;		
		
		SELECT @@identity
		INTO	 :ll_id_con_provvigione_new 
		FROM	 SYS.DUMMY;
		
		if sqlca.sqlcode = -1 then
			messagebox("Condizioni di provv. - chiusura/ Attenzione", sqlca.sqlerrtext)
			return
		end if				
		
		tab_1.tabpage_4.dw_att_euro_scag_ape_gd.setitem(li_i, "id_con_provvigione", ll_id_con_provvigione_new )
		tab_1.tabpage_4.dw_att_euro_scag_ape_gd.setitem(li_i, "data_inizio", ldt_data_apertura)
		tab_1.tabpage_4.dw_att_euro_scag_ape_gd.setitem(li_i, "data_fine", ldt_null)
	else
		tab_1.tabpage_4.dw_att_euro_scag_ape_gd.setitemstatus(li_i, 0, Primary!, DataModified!)
	end if
		
	ll_id_valuta_old = tab_1.tabpage_4.dw_att_euro_scag_gd.getitemnumber(li_i, "id_valuta")
	
	
	ld_da_imp_sconto = tab_1.tabpage_4.dw_att_euro_scag_gd.getitemnumber(li_i, "da_imp_sconto")
	If (ll_a_id_valuta > 0) then
		SELECT ROUND(FN_CONV_VALUTA(:ll_id_valuta_old, :ld_da_imp_sconto, :ll_a_id_valuta), :li_dec_significativi)
		INTO	 :ld_da_imp_sconto
		FROM	 SYS.DUMMY;

		if (sqlca.sqlcode = -1) then &
			messagebox("Condizioni di provv./DbError", sqlca.sqlerrtext)

		if (sqlca.sqlcode = 0) then &
			tab_1.tabpage_4.dw_att_euro_scag_ape_gd.setitem(li_i, "da_imp_sconto", ld_da_imp_sconto)
	end if
	
	
	ld_a_imp_sconto = tab_1.tabpage_4.dw_att_euro_scag_gd.getitemnumber(li_i, "a_imp_sconto")
	If (ll_a_id_valuta > 0) then
		SELECT ROUND(FN_CONV_VALUTA(:ll_id_valuta_old, :ld_a_imp_sconto, :ll_a_id_valuta), :li_dec_significativi)
		INTO	 :ld_a_imp_sconto
		FROM	 SYS.DUMMY;

		if (sqlca.sqlcode = -1) then &
			messagebox("Condizioni di provv./DbError", sqlca.sqlerrtext)

		if (sqlca.sqlcode = 0) then &
			tab_1.tabpage_4.dw_att_euro_scag_ape_gd.setitem(li_i, "a_imp_sconto", ld_a_imp_sconto)
	end if

	
	ld_imp_prov_capo_area = tab_1.tabpage_4.dw_att_euro_scag_gd.getitemnumber(li_i, "imp_prov_capo_area")
	If (ll_a_id_valuta > 0) then
		SELECT ROUND(FN_CONV_VALUTA(:ll_id_valuta_old, :ld_imp_prov_capo_area, :ll_a_id_valuta), :li_dec_significativi)
		INTO	 :ld_imp_prov_capo_area
		FROM	 SYS.DUMMY;

		if (sqlca.sqlcode = -1) then &
			messagebox("Condizioni di provv./DbError", sqlca.sqlerrtext)

		if (sqlca.sqlcode = 0) then &
			tab_1.tabpage_4.dw_att_euro_scag_ape_gd.setitem(li_i, "imp_prov_capo_area", ld_imp_prov_capo_area)
	end if
	
	
	ld_imp_prov_agente = tab_1.tabpage_4.dw_att_euro_scag_gd.getitemnumber(li_i, "imp_prov_agente")
	If (ll_a_id_valuta > 0) then
		SELECT ROUND(FN_CONV_VALUTA(:ll_id_valuta_old, :ld_imp_prov_agente, :ll_a_id_valuta), :li_dec_significativi)
		INTO	 :ld_imp_prov_agente
		FROM	 SYS.DUMMY;

		if (sqlca.sqlcode = -1) then &
			messagebox("Condizioni di provv./DbError", sqlca.sqlerrtext)

		if (sqlca.sqlcode = 0) then &
			tab_1.tabpage_4.dw_att_euro_scag_ape_gd.setitem(li_i, "imp_prov_agente", ld_imp_prov_agente)
	end if	
	
	
	ld_imp_prov_sub_agente = tab_1.tabpage_4.dw_att_euro_scag_gd.getitemnumber(li_i, "imp_prov_sub_agente")
	If (ll_a_id_valuta > 0) then
		SELECT ROUND(FN_CONV_VALUTA(:ll_id_valuta_old, :ld_imp_prov_sub_agente, :ll_a_id_valuta), :li_dec_significativi)
		INTO	 :ld_imp_prov_sub_agente
		FROM	 SYS.DUMMY;

		if (sqlca.sqlcode = -1) then &
			messagebox("Condizioni di provv./DbError", sqlca.sqlerrtext)

		if (sqlca.sqlcode = 0) then &
			tab_1.tabpage_4.dw_att_euro_scag_ape_gd.setitem(li_i, "imp_prov_sub_agente", ld_imp_prov_sub_agente)
	end if		

	li_ret = tab_1.tabpage_4.dw_att_euro_scag_ape_gd.update()
				
	if li_ret = -1 then
		messagebox("Condizioni di provv. - nuove/Attenzione", "Verificare l'errore e ripetere l'operazione")
		return
	end if

		
	tab_1.tabpage_4.dw_att_euro_scag_gd.setitem(li_i, "c_note", "OK")
	tab_1.tabpage_4.dw_att_euro_scag_gd.object.c_note.color = '16711680'					
next

if li_rows > 0 then &
	messagebox("Condizioni di provv.", "Aggiornamento terminato")
end event

event clicked;call super::clicked;CHOOSE CASE dwo.name
	CASE "cb_visualizza"
		date 	ldt_data_validita
		char 	lc_storico
		long	ll_a_id_valuta
		
		ldt_data_validita = this.getitemdate(1, "data_validita")
		lc_storico = this.getitemstring(1, "storico")
		ll_a_id_valuta = dw_att_euro_ext.getitemnumber(1, "a_id_valuta")
		
		if (isnull(ldt_data_validita)) then ldt_data_validita = today()
		if (isnull(ll_a_id_valuta)) then return
		tab_1.tabpage_4.dw_att_euro_scag_gd.setfilter("")
		tab_1.tabpage_4.dw_att_euro_scag_gd.filter()
		tab_1.tabpage_4.dw_att_euro_scag_gd.retrieve(ldt_data_validita, ll_a_id_valuta)
		tab_1.tabpage_4.dw_att_euro_scag_ape_gd.reset()				
		
	CASE "cb_aggiorna"
		event ue_aggiorna()
		
	CASE "cb_salva"
		tab_1.tabpage_4.dw_att_euro_scag_ape_gd.update()
END CHOOSE
end event

type dw_att_euro_scag_gd from u_dw_ext_main within tabpage_4
int X=41
int Y=448
int Width=3287
int Height=488
int TabOrder=11
boolean BringToTop=true
string DataObject="d_att_euro_scag_gd"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event sqlpreview;long		ll_da_id_valuta
string	ls_sql

ll_da_id_valuta = dw_att_euro_ext.getitemnumber(1, "da_id_valuta")

ls_sql = sqlsyntax
if (ll_da_id_valuta > 0 and sqltype = PreviewSelect!) then
	ls_sql = ls_sql + " AND scag_provvigione.id_valuta = " + string(ll_da_id_valuta)
	this.setsqlpreview(ls_sql)	
end if
end event

event doubleclicked;integer li_i, li_rows

if dwo.name = 'c_selezione_t' then
	li_rows = this.rowcount()
	if li_rows > 0 then
		if (this.getitemstring(1, "c_selezione") = "S") then
			for li_i = 1 to li_rows
				this.setitem(li_i, "c_selezione", "N")
			next
		else
			for li_i = 1 to li_rows
				this.setitem(li_i, "c_selezione", "S")
			next
		end if
	end if
end if
end event

type dw_att_euro_scag_ape_gd from u_dw_ext_main within tabpage_4
int X=41
int Y=944
int Width=3287
int Height=456
int TabOrder=11
boolean BringToTop=true
string DataObject="d_att_euro_scag_gd"
boolean HScrollBar=true
boolean VScrollBar=true
end type

type dw_att_euro_ext from u_dw_ext_main within w_att_euro_wz
int X=37
int Y=28
int Width=2199
int Height=168
int TabOrder=20
boolean BringToTop=true
string DataObject="d_att_euro_ext"
end type

type cb_esci from commandbutton within w_att_euro_wz
int X=2267
int Y=60
int Width=261
int Height=84
int TabOrder=30
string Text="&Esci"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Close(Parent)
end event

type st_1 from statictext within w_att_euro_wz
int X=2578
int Y=36
int Width=841
int Height=136
boolean Enabled=false
boolean BringToTop=true
string Text="N.B.: Convertire le condizioni di listino prima dei listini"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

