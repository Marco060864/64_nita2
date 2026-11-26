forward
global type u_riepilogo_ricalcolo from nonvisualobject
end type
end forward

global type u_riepilogo_ricalcolo from nonvisualobject
end type
global u_riepilogo_ricalcolo u_riepilogo_ricalcolo

type variables
DataStore	ids_saldo_mensile
DataStore	ids_delete

end variables

forward prototypes
public subroutine uf_esegui (long al_id_esercizio, string as_da_art, string as_a_art, string as_esercizio_tutti, u_meter au_prbar, statictext ast_cod)
end prototypes

public subroutine uf_esegui (long al_id_esercizio, string as_da_art, string as_a_art, string as_esercizio_tutti, u_meter au_prbar, statictext ast_cod);

string		ls_sql, ls_where, ls_select
long			ll_scode, ll_nrows, ll_row ,ll_id_unita_confezione

integer		li_anno, li_mese
long			ll_idloc1, ll_idloc2, ll_ideser, ll_idart, ll_idcaumag, ll_idatti
date			ld_datareg
decimal		ldc_totriga, ldc_prezzo, ldc_myqta, ldc_myqteva
decimal		ldc_qtacf, ldc_qtadaus
string		ls_chfor, ls_codart

integer		ll_i, ll_j
string		ls_msg

ast_cod.text = "Azzeramento voci di riepilogo..."
ast_cod.visible = true

ls_sql = "UPDATE riepilogo SET ult_costo=null, primo_costo=null, "
ls_sql += "data_ult_costo=null, data_primo_costo=null, "
ls_sql += "qta_rim_iniziale=0, val_rim_iniziale=0, qta_caricata=0, qta_scaricata=0, "
ls_sql += "val_caricato=0, val_scaricato=0, qta_ord_clienti=0, qta_ord_fornitori=0, "
ls_sql += "qta_vis_clienti=0, qta_vis_clienti=0, qta_imp_produzione=0, qta_ord_produzione=0, "
ls_sql += "qta_cl_clienti=0, qta_cl_clienti=0, qta_cl_terzi=0, "
ls_sql += "qta_gruppo_lib_1=0, qta_gruppo_lib_2=0, qta_gruppo_lib_3=0, qta_gruppo_lib_4=0 "
ls_sql += "FROM riepilogo, articolo WHERE (riepilogo.id_articolo = articolo.id_articolo) "

if as_da_art>"" then
	ls_sql += " AND (articolo.codice >= '"+as_da_art+"')"
end if
if as_a_art>"" then
	ls_sql += " AND (articolo.codice >= '"+as_a_art+"')"
end if
if as_esercizio_tutti<>"S" then
	if (not isNull(al_id_esercizio)) and (al_id_esercizio>0) then
		ls_sql += " AND (riepilogo.id_esercizio = "+string(al_id_esercizio)+")"
	end if
end if

EXECUTE IMMEDIATE :ls_sql using SQLCA;

if sqlca.sqlcode<0 then
	MessageBox("Errore grave!","Operazione di Azzeramento non riuscita!")
	ast_cod.visible = false
	rollback using sqlca;
	if sqlca.sqlcode<0 then
		MessageBox("Errore grave!","ROLLBACK su AZZERA non riuscito!")
	end if
	return
end if

commit using sqlca;
if sqlca.sqlcode<0 then
	MessageBox("Errore grave!","COMMIT su AZZERA non riuscito!")
	ast_cod.visible = false
	rollback using sqlca;
	if sqlca.sqlcode<0 then
		MessageBox("Errore grave!","ROLLBACK su AZZERA non riuscito!")
	end if
	return
end if




ls_where += "where (riga_documento.id_documento = documento.id_documento) "
ls_where +=	"and (riga_documento.id_articolo = articolo.id_articolo) "
ls_where +=	"and (documento.id_registro = registro.id_registro) "

if as_da_art>"" then
	ls_where += " and (articolo.codice >= '"+as_da_art+"')"
end if
if as_a_art>"" then
	ls_where += " and (articolo.codice <= '"+as_a_art+"')"
end if
if as_esercizio_tutti<>"S" then
	if (not isNull(al_id_esercizio)) and (al_id_esercizio>0) then
		ls_where += " and (registro.id_esercizio = "+string(al_id_esercizio)+")"
	end if
end if

ls_select = "select count(*) "
ls_select += "from dba.riga_documento, dba.documento, dba.registro, dba.articolo "

ls_sql = ls_select + " " + ls_where
declare mycur dynamic cursor for SQLSA;
prepare SQLSA from :ls_sql;
open dynamic mycur;
ll_scode=0
fetch mycur into :ll_nrows;
ll_scode = SQLCA.SQLCode
if ll_scode<>0 then
	ll_nrows = -1
end if
close mycur;


if ll_nrows>0 then
	au_prbar.uf_setmin(0)
	au_prbar.uf_setmax(ll_nrows)
	au_prbar.visible = true
	ll_row = 0
end if



ls_select = "select "
ls_select +=	"articolo.codice, "
ls_select +=	"documento.data_registrazione, "
ls_select +=	"registro.id_esercizio, "
ls_select +=	"registro.id_attivita, "
ls_select +=	"riga_documento.id_articolo, "
ls_select +=	"riga_documento.id_unita_confezione, "
ls_select +=	"riga_documento.id_locazione_1, "
ls_select +=	"riga_documento.id_locazione_2, "
ls_select +=	"riga_documento.qta_un_base, "
ls_select +=	"riga_documento.qta_evasa_un_base, "
ls_select +=	"riga_documento.tot_riga_val_az, "
ls_select +=	"riga_documento.prezzo, "
ls_select +=	"riga_documento.id_caus_magazzino, "
ls_select +=	"riga_documento.forza_chius_evasione "
ls_select +=	"from dba.riga_documento, dba.documento, dba.registro, dba.articolo "




ls_sql = ls_select + " " + ls_where

prepare SQLSA from :ls_sql;
open dynamic mycur;
ll_scode=0
do while ll_scode=0
	
	fetch mycur into	:ls_codart, :ld_datareg, :ll_ideser, :ll_idatti, :ll_idart, :ll_id_unita_confezione, :ll_idloc1,
							:ll_idloc2, :ldc_myqta, :ldc_myqteva, :ldc_totriga, :ldc_prezzo, 
							:ll_idcaumag, :ls_chfor;
							
	ll_scode = SQLCA.SQLCode
	if ll_scode=0 then
		li_anno = year(ld_datareg)
		li_mese = month(ld_datareg)
		if ls_chfor = "S" then
			if isNull(ldc_myqteva) then ldc_myqteva=0
			ldc_qtacf = ldc_myqta + ldc_myqteva
			ldc_qtadaus = ldc_myqta - ldc_qtacf
		else
			ldc_qtadaus = ldc_myqta
		end if
		
		
		
		
		long ll_id_doc_provenienza
		decimal ld_peso_netto
		
		ll_id_doc_provenienza = 0
		ld_peso_netto = 0
		
		
		if (not isNull(ll_idloc1)) and (ll_idloc1>0) then
			SQLCA. sp_gest_causale ('+P', ld_datareg, ll_ideser, ll_idatti, ll_idart, &
											ll_idloc1, li_anno, li_mese, ldc_qtadaus, &
											ldc_totriga, ldc_prezzo, ll_idcaumag, ll_id_unita_confezione, ll_id_doc_provenienza, ld_peso_netto)
		end if
		if (not isNull(ll_idloc2)) and (ll_idloc2>0) then
			SQLCA. sp_gest_causale ('+S', ld_datareg,ll_ideser, ll_idatti, ll_idart, &
											ll_idloc2, li_anno, li_mese, ldc_qtadaus, &
											ldc_totriga, ldc_prezzo, ll_idcaumag, ll_id_unita_confezione, ll_id_doc_provenienza, ld_peso_netto)
		end if
		
		if (ll_nrows>0) then
			ll_row++
			au_prbar.uf_setvalue(ll_row)
			ast_cod.text = ls_codart
		end if
		
	end if
loop

close mycur;

commit using sqlca;
if sqlca.sqlcode<0 then
	MessageBox("Errore grave!","COMMIT su RICREA non riuscito!")
	ast_cod.visible = false
	rollback using sqlca;
	if sqlca.sqlcode<0 then
		MessageBox("Errore grave!","ROLLBACK su RICREA non riuscito!")
	end if
	return
end if


au_prbar.visible = false
ast_cod.visible = false


end subroutine

on u_riepilogo_ricalcolo.create
TriggerEvent( this, "constructor" )
end on

on u_riepilogo_ricalcolo.destroy
TriggerEvent( this, "destructor" )
end on

