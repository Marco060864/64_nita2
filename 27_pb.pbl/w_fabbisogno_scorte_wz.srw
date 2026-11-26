forward
global type w_fabbisogno_scorte_wz from w_wiz_main
end type
type tab_1 from tab within w_fabbisogno_scorte_wz
end type
type tabpage_1 from userobject within tab_1
end type
type dw_fabbisogno_scorte_wz from u_dw_ext_main within tabpage_1
end type
type cb_procedi from commandbutton within tabpage_1
end type
type cb_vista from commandbutton within tabpage_1
end type
type tabpage_2 from userobject within tab_1
end type
type dw_tabella from u_dw_ext_main within tabpage_2
end type
type st_magazzino from statictext within tabpage_2
end type
type st_mag_codice from statictext within tabpage_2
end type
type st_mag_des from statictext within tabpage_2
end type
type cb_stampa from commandbutton within tabpage_2
end type
type cb_esci from commandbutton within w_fabbisogno_scorte_wz
end type
type cb_salva from commandbutton within w_fabbisogno_scorte_wz
end type
type cb_inserisci from commandbutton within w_fabbisogno_scorte_wz
end type
type cb_cancella from commandbutton within w_fabbisogno_scorte_wz
end type
type tabpage_1 from userobject within tab_1
dw_fabbisogno_scorte_wz dw_fabbisogno_scorte_wz
cb_procedi cb_procedi
cb_vista cb_vista
end type
type tabpage_2 from userobject within tab_1
dw_tabella dw_tabella
st_magazzino st_magazzino
st_mag_codice st_mag_codice
st_mag_des st_mag_des
cb_stampa cb_stampa
end type
type tab_1 from tab within w_fabbisogno_scorte_wz
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
end forward

global type w_fabbisogno_scorte_wz from w_wiz_main
int Width=2743
int Height=1729
boolean TitleBar=true
string Title="Fabbisogno scorte"
tab_1 tab_1
cb_esci cb_esci
cb_salva cb_salva
cb_inserisci cb_inserisci
cb_cancella cb_cancella
end type
global w_fabbisogno_scorte_wz w_fabbisogno_scorte_wz

type variables
w_wait_01	iw_wait
integer		ii_dwi
u_ds_main	ids_fab

end variables

forward prototypes
public subroutine wf_dwsetfocus ()
public function integer wf_calcola_scorte ()
public function long wf_get_fornitore_articolo (long al_id_articolo)
public function boolean wf_is_valid_per_scorta (integer ai_giorno_inizio, integer ai_mese_inizio, integer ai_giorno_fine, integer ai_mese_fine)
public function integer wf_insert_fabbisogno (long al_id_articolo, long al_id_unita_confezione, long al_id_magazzino_scorta, decimal aldc_scorta_minima)
public function integer wf_delete_fabbisogno ()
public function string wf_crea_select_sql ()
public function integer wf_check_magazzino ()
public function integer wf_retrieve_tabella ()
public function integer wf_stampa ()
end prototypes

public subroutine wf_dwsetfocus ();

choose case ii_dwi
	case 1
		tab_1.SelectTab(1)
		tab_1.tabpage_1.dw_fabbisogno_scorte_wz.setfocus()
	case 2
		tab_1.SelectTab(2)
		tab_1.tabpage_2.dw_tabella.setfocus()
end choose

end subroutine

public function integer wf_calcola_scorte ();
long		ll_row,ll_id_articolo,ll_id_unita_confezione,ll_id_per_scorta
long		ll_id_magazzino,ll_id_magazzino_scorta
long		ll_row_scorta,ll_i,ll_priorita_temp,ll_priorita_res
long		ll_id_azienda
decimal	ldc_scorta_minima,ldc_priorita
string	ls_da_codice,ls_a_codice,ls_SQL
integer	li_giorno_inizio,li_mese_inizio,li_giorno_fine,li_mese_fine
boolean	lb_found_articolo

ll_id_azienda		= 1

lb_found_articolo	= true

ll_row				= this.tab_1.tabpage_1.dw_fabbisogno_scorte_wz.GetRow()
ls_da_codice		= this.tab_1.tabpage_1.dw_fabbisogno_scorte_wz.GetItemString( ll_row,"cod_art1" )
ls_a_codice			= this.tab_1.tabpage_1.dw_fabbisogno_scorte_wz.GetItemString( ll_row,"cod_art2" )
ll_id_magazzino	= this.tab_1.tabpage_1.dw_fabbisogno_scorte_wz.GetItemNumber( ll_row,"id_magazzino" )

ls_SQL				= wf_crea_select_sql()
prepare  SQLSA from :ls_SQL;
describe SQLSA into SQLDA;

declare  art_cursor dynamic cursor for SQLSA;

open dynamic art_cursor using descriptor SQLDA;

if SQLCA.SQLCode = -1 then
	MessageBox( "Errore","Error opening cursor ",StopSign! )
	return -1
end if

do while lb_found_articolo	= true 
	
	fetch art_cursor using descriptor SQLDA;
	
	if SQLCA.SQLCode = 0 then
		
		choose case SQLDA.OutParmType[1]
			case TypeInteger!,TypeLong!
				ll_id_articolo = getDynamicNumber(SQLDA,1)
		end choose		
		
		select "unita_confezione"."id_unita_confezione"
			into :ll_id_unita_confezione
			from "dba"."unita_confezione"
			where "unita_confezione"."id_articolo" = :ll_id_articolo and 
					"unita_confezione"."unita_base" = 'S' and
					"unita_confezione"."id_azienda" = 1
			using SQLCA;
		
		if SQLCA.SQLCode = 0 then
		
			ids_fab.Reset()
			
			ids_fab.SetTransObject(SQLCA)
			ll_row_scorta	= ids_fab.Retrieve(ll_id_unita_confezione)
			if ll_row_scorta > 0 then

				for ll_i = ll_row_scorta to 1 step -1 
					ll_id_magazzino_scorta	= ids_fab.GetItemNumber( ll_i,"scorta_id_magazzino" )
					if ll_id_magazzino_scorta <> ll_id_magazzino and not isNull(ll_id_magazzino_scorta) then
						ids_fab.DeleteRow(ll_i)
					end if
				next

				ll_row_scorta	= ids_fab.RowCount()
				for ll_i = ll_row_scorta to 1 step -1 
					ll_id_per_scorta	= ids_fab.GetItemNumber( ll_i,"scorta_id_per_scorta" )
					if not isNull( ll_id_per_scorta ) then
						
						li_giorno_inizio	= ids_fab.GetItemNumber( ll_i,"per_scorta_giorno_inizio" )
						li_mese_inizio		= ids_fab.GetItemNumber( ll_i,"per_scorta_mese_inizio" )
						li_giorno_fine		= ids_fab.GetItemNumber( ll_i,"per_scorta_giorno_fine" )
						li_mese_fine		= ids_fab.GetItemNumber( ll_i,"per_scorta_mese_fine" )
					
						if	wf_is_valid_per_scorta(li_giorno_inizio,li_mese_inizio,li_giorno_fine,li_mese_fine)	= false then
							ids_fab.DeleteRow(ll_i)
						end if	
					end if
				next

				ll_row_scorta	= ids_fab.RowCount()
				for ll_i = 1 to ll_row_scorta
					
					ll_id_per_scorta			= ids_fab.GetItemNumber( ll_i,"scorta_id_per_scorta" )
					ll_id_magazzino_scorta	= ids_fab.GetItemNumber( ll_i,"scorta_id_magazzino" )
					ldc_priorita				= ids_fab.uf_GetItemDecimal( ll_i,"per_scorta_priorita" )					
					
					if not isNull(ll_id_per_scorta) and not isNull(ll_id_magazzino_scorta) then
						ids_fab.SetItem( ll_i,"cc_ordine",1 )
					end if
					if not isNull(ll_id_per_scorta) and isNull(ll_id_magazzino_scorta) then
						ids_fab.SetItem( ll_i,"cc_ordine",2 )
					end if
					if isNull(ll_id_per_scorta) and not isNull(ll_id_magazzino_scorta) then
						ids_fab.SetItem( ll_i,"cc_ordine",3 )
					end if
					if isNull(ll_id_per_scorta) and isNull(ll_id_magazzino_scorta) then
						ids_fab.SetItem( ll_i,"cc_ordine",4 )
					end if
					
					ll_priorita_temp	= ids_fab.GetItemNumber( ll_i,"cc_ordine" )
					ll_priorita_res	= ll_priorita_temp - (ldc_priorita * 2 )
					ids_fab.SetItem( ll_i,"cc_ordine",ll_priorita_res )
				next		
			
				ids_fab.Sort()
			
				ll_row_scorta	= ids_fab.RowCount()
				if ll_row_scorta > 0 then
					
					ldc_scorta_minima			= ids_fab.GetItemDecimal( 1,"scorta_scorta_minima" )
					
					ll_id_magazzino_scorta	= ids_fab.GetItemNumber( 1,"scorta_id_magazzino" )
					
					wf_insert_fabbisogno( ll_id_articolo,ll_id_unita_confezione,ll_id_magazzino_scorta,ldc_scorta_minima )
					
				end if
				
			end if
			
		else
			if SQLCA.SQLCode = -1 then
				MessageBox( "Database Error","Errore : " + SQLCA.SQLErrText,StopSign! )			
			end if							
		end if		
	else
		if SQLCA.SQLCode = -1 then
			MessageBox( "Database Error","Errore : " + SQLCA.SQLErrText,StopSign! )			
		end if	
		
		lb_found_articolo	= false
		
	end if	

loop

close art_cursor;

wf_retrieve_tabella()

return 0
end function

public function long wf_get_fornitore_articolo (long al_id_articolo);
long		ll_id_fornitore

select "articolo"."id_sog_commerciale"
	into :ll_id_fornitore
	from "dba"."articolo"
	where "articolo"."id_articolo" = :al_id_articolo
	using SQLCA;
	
if SQLCA.SQLCode = -1 then
	MessageBox( "Database Error","Errore : " + SQLCA.SQLErrText,StopSign! )
end if
	
return ll_id_fornitore
end function

public function boolean wf_is_valid_per_scorta (integer ai_giorno_inizio, integer ai_mese_inizio, integer ai_giorno_fine, integer ai_mese_fine);
string		ls_oggi,ls_giorno,ls_mese
integer		li_giorno,li_mese
boolean		lb_ok

lb_ok			= false

ls_oggi		= string( Today(),"dd/mm/yy" )

ls_giorno	= Mid( ls_oggi,1,2 )
ls_mese		= Mid( ls_oggi,4,2 )

li_giorno	= integer( ls_giorno )
li_mese		= integer( ls_mese )

if ai_mese_fine < ai_mese_inizio then
	if li_mese >= ai_mese_fine and li_mese <= ai_mese_inizio then
		if ai_giorno_fine < ai_giorno_inizio then
			if li_giorno >= ai_giorno_fine and li_giorno <= ai_giorno_inizio then
				lb_ok	= true
			end if	
		else	
			if li_giorno <= ai_giorno_fine and li_giorno >= ai_giorno_inizio then
				lb_ok	= true
			end if	
		end if
	end if	
else
	if li_mese >= ai_mese_inizio and li_mese <= ai_mese_fine then
		if ai_giorno_fine < ai_giorno_inizio then
			if li_giorno >= ai_giorno_fine and li_giorno <= ai_giorno_inizio then
				lb_ok	= true
			end if	
		else	
			if li_giorno <= ai_giorno_fine and li_giorno >= ai_giorno_inizio then
				lb_ok	= true
			end if	
		end if
	end if	
end if

return lb_ok
end function

public function integer wf_insert_fabbisogno (long al_id_articolo, long al_id_unita_confezione, long al_id_magazzino_scorta, decimal aldc_scorta_minima);
long			ll_row
long			ll_id_magazzino,ll_id_fornitore,ll_id_azienda
long			ll_id_par_disponibilita,ll_id_esercizio,ll_id_fabbisogno
decimal		ldc_qta_ord_forn,ldc_qta_ord_cli,ldc_disp_globale,ldc_esist_globale
decimal		ldc_riordino,ldc_disponibilita_ad_oggi,ldc_esistenza_ad_oggi
decimal		ldc_disponibilita_globale,ldc_esistenza_globale

ll_row				= this.tab_1.tabpage_1.dw_fabbisogno_scorte_wz.GetRow()
ll_id_fornitore	= wf_get_fornitore_articolo( al_id_articolo )
ll_id_magazzino	= this.tab_1.tabpage_1.dw_fabbisogno_scorte_wz.GetItemNumber(ll_row,"id_magazzino")

select "azienda"."id_esercizio"
	into :ll_id_esercizio
	from "dba"."azienda"
	where "azienda"."id_azienda" = 1
	using SQLCA;
	
if SQLCA.SQLCode = -1 then
	MessageBox( "Database Error","Errore : " + SQLCA.SQLErrText,StopSign! )
	return -1
end if

select "par_disponibilita"."id_par_disponibilita"
	into :ll_id_par_disponibilita
	from "dba"."par_disponibilita"
	where "par_disponibilita"."id_prof_documento" is null and "par_disponibilita"."id_azienda" = 1
	using SQLCA;

if SQLCA.SQLCode = -1 then
	MessageBox( "Database Error","Errore : " + SQLCA.SQLErrText,StopSign! )
	return -1
end if

if not isNull(al_id_magazzino_scorta) then
	SQLCA.sp_esi_disp_magazzino(al_id_articolo,ll_id_magazzino,ll_id_esercizio,ll_id_azienda,ll_id_par_disponibilita,ldc_esistenza_ad_oggi,ldc_disponibilita_ad_oggi)
	SQLCA.sp_esi_disp_totali(al_id_articolo,ll_id_esercizio,ll_id_azienda,ll_id_par_disponibilita,ldc_esist_globale,ldc_disp_globale)
else
	SQLCA.sp_esi_disp_totali(al_id_articolo,ll_id_esercizio,ll_id_azienda,ll_id_par_disponibilita,ldc_esistenza_ad_oggi,ldc_disponibilita_ad_oggi)
	SQLCA.sp_esi_disp_totali(al_id_articolo,ll_id_esercizio,ll_id_azienda,ll_id_par_disponibilita,ldc_esist_globale,ldc_disp_globale)
end if

ldc_riordino =  aldc_scorta_minima - ldc_disponibilita_ad_oggi
if ldc_riordino < 0 then
	ldc_riordino = 0
end if	

select "vs_riepilogo"."qta_ord_clienti","vs_riepilogo"."qta_ord_fornitori"
	into :ldc_qta_ord_cli,:ldc_qta_ord_forn
	from "dba"."vs_riepilogo"
	where "vs_riepilogo"."id_articolo" = :al_id_articolo
	using SQLCA;
	
if SQLCA.SQLCode = -1 then
	MessageBox( "Database Error","Errore : " + SQLCA.SQLErrText,StopSign! )
	return -1
end if

insert into fabbisogno ( fabbisogno.id_sog_commerciale,fabbisogno.id_magazzino,fabbisogno.id_unita_confezione, &
					 fabbisogno.id_articolo,fabbisogno.qta_riordino,fabbisogno.disponibilita,fabbisogno.esistenza, &
					 fabbisogno.qta_ord_fornitore,fabbisogno.qta_ord_cliente,fabbisogno.disp_globale,fabbisogno.esist_globale )
values ( :ll_id_fornitore,:ll_id_magazzino,:al_id_unita_confezione, &
		 :al_id_articolo,:ldc_riordino,:ldc_disponibilita_ad_oggi,:ldc_esistenza_ad_oggi, &
		 :ldc_qta_ord_forn,:ldc_qta_ord_cli,:ldc_disp_globale,:ldc_esist_globale )
using SQLCA;

if SQLCA.SQLCode = -1 then
	MessageBox( "Database Error","Errore : " + SQLCA.SQLErrText,StopSign! )
end if

return 0
end function

public function integer wf_delete_fabbisogno ();
long		ll_row,ll_id_articolo,ll_id_magazzino,ll_id_cat_cod
long		ll_id_azienda
long		ll_id_cat_com,ll_id_cat_merc,ll_id_cat_fisc,ll_id_gruppo
long		ll_id_produttore,ll_id_fornitore
string	ls_da_codice,ls_a_codice,ls_SQL

ll_row				= this.tab_1.tabpage_1.dw_fabbisogno_scorte_wz.GetRow()
ls_da_codice		= this.tab_1.tabpage_1.dw_fabbisogno_scorte_wz.GetItemString( ll_row,"cod_art1" )
ls_a_codice			= this.tab_1.tabpage_1.dw_fabbisogno_scorte_wz.GetItemString( ll_row,"cod_art2" )
ll_id_cat_cod		= this.tab_1.tabpage_1.dw_fabbisogno_scorte_wz.GetItemNumber( ll_row,"id_cat_codifica" )
ll_id_magazzino	= this.tab_1.tabpage_1.dw_fabbisogno_scorte_wz.GetItemNumber( ll_row,"id_magazzino" )
ll_id_cat_com		= this.tab_1.tabpage_1.dw_fabbisogno_scorte_wz.GetItemNumber( ll_row,"id_cat_com_articolo" )
ll_id_cat_merc		= this.tab_1.tabpage_1.dw_fabbisogno_scorte_wz.GetItemNumber( ll_row,"id_cat_merceologica" )
ll_id_cat_fisc		= this.tab_1.tabpage_1.dw_fabbisogno_scorte_wz.GetItemNumber( ll_row,"id_cat_fiscale" )
ll_id_gruppo		= this.tab_1.tabpage_1.dw_fabbisogno_scorte_wz.GetItemNumber( ll_row,"id_gruppo" )
ll_id_fornitore	= this.tab_1.tabpage_1.dw_fabbisogno_scorte_wz.GetItemNumber( ll_row,"id_fornitore" )
ll_id_produttore	= this.tab_1.tabpage_1.dw_fabbisogno_scorte_wz.GetItemNumber( ll_row,"id_produttore" )

ls_SQL	= "delete from fabbisogno " + &
				"from fabbisogno,articolo " + &
			  	"where fabbisogno.id_articolo = articolo.id_articolo " + &
 					 "and articolo.id_azienda = 1 "
			  
if	not isNull( ls_da_codice ) then
	ls_SQL	= ls_SQL + " and articolo.codice >= '" + ls_da_codice + "'"
end if

if	not isNull( ls_a_codice ) then
	ls_SQL	= ls_SQL + " and articolo.codice <= '" + ls_a_codice + "'"
end if

if	not isNull( ll_id_cat_cod ) then
	ls_SQL	= ls_SQL + " and articolo.id_cat_codifica = " + string(ll_id_cat_cod)
end if

if	not isNull( ll_id_cat_com ) then
	ls_SQL	= ls_SQL + " and articolo.id_cat_com_articolo = " + string(ll_id_cat_com)
end if

if	not isNull( ll_id_cat_merc ) then
	ls_SQL	= ls_SQL + " and articolo.id_cat_merceologica = " + string(ll_id_cat_merc)
end if

if	not isNull( ll_id_cat_fisc ) then
	ls_SQL	= ls_SQL + " and articolo.id_cat_fiscale = " + string(ll_id_cat_fisc)
end if

if	not isNull( ll_id_gruppo ) then
	ls_SQL	= ls_SQL + " and articolo.id_gruppo_articoli = " + string(ll_id_gruppo)
end if

if	not isNull( ll_id_fornitore ) then
	ls_SQL	= ls_SQL + " and articolo.id_sog_commerciale = " + string(ll_id_fornitore)
end if

if	not isNull( ll_id_produttore ) then
	ls_SQL	= ls_SQL + " and articolo.id_anagrafica = " + string(ll_id_produttore)
end if

if	not isNull( ll_id_magazzino ) then
	ls_SQL	= ls_SQL + " and fabbisogno.id_magazzino = " + string(ll_id_magazzino)
end if

EXECUTE IMMEDIATE :ls_SQL;

if SQLCA.SQLCode = -1 then
	MessageBox( "Database Error","Errore : " + SQLCA.SQLErrText,StopSign! )
	return -1
end if	

return 0
end function

public function string wf_crea_select_sql ();
string		ls_SQL
long		ll_row
long		ll_id_azienda
long		ll_id_cat_cod,ll_id_cat_com,ll_id_cat_merc,ll_id_cat_fisc,ll_id_gruppo
long		ll_id_produttore,ll_id_fornitore
decimal	ldc_scorta_minima
string	ls_da_codice,ls_a_codice
integer	li_giorno_inizio,li_mese_inizio,li_giorno_fine,li_mese_fine
boolean	lb_found_articolo

ll_id_azienda		= 1

lb_found_articolo	= true

ll_row				= this.tab_1.tabpage_1.dw_fabbisogno_scorte_wz.GetRow()
ls_da_codice		= this.tab_1.tabpage_1.dw_fabbisogno_scorte_wz.GetItemString( ll_row,"cod_art1" )
ls_a_codice			= this.tab_1.tabpage_1.dw_fabbisogno_scorte_wz.GetItemString( ll_row,"cod_art2" )
ll_id_cat_cod		= this.tab_1.tabpage_1.dw_fabbisogno_scorte_wz.GetItemNumber( ll_row,"id_cat_com_articolo" )
ll_id_cat_com		= this.tab_1.tabpage_1.dw_fabbisogno_scorte_wz.GetItemNumber( ll_row,"id_cat_com_articolo" )
ll_id_cat_merc		= this.tab_1.tabpage_1.dw_fabbisogno_scorte_wz.GetItemNumber( ll_row,"id_cat_merceologica" )
ll_id_cat_fisc		= this.tab_1.tabpage_1.dw_fabbisogno_scorte_wz.GetItemNumber( ll_row,"id_cat_fiscale" )
ll_id_gruppo		= this.tab_1.tabpage_1.dw_fabbisogno_scorte_wz.GetItemNumber( ll_row,"id_gruppo" )
ll_id_fornitore	= this.tab_1.tabpage_1.dw_fabbisogno_scorte_wz.GetItemNumber( ll_row,"id_fornitore" )
ll_id_produttore	= this.tab_1.tabpage_1.dw_fabbisogno_scorte_wz.GetItemNumber( ll_row,"id_produttore" )


ls_SQL	= "select articolo.id_articolo " + &
			  "from dba.articolo " + &
			  "where articolo.id_azienda = 1 "
			  
if	not isNull( ls_da_codice ) then
	ls_SQL	= ls_SQL + " and articolo.codice >= '" + ls_da_codice + "'"
end if

if	not isNull( ls_a_codice ) then
	ls_SQL	= ls_SQL + " and articolo.codice <= '" + ls_a_codice + "'"
end if

if	not isNull( ll_id_cat_cod ) then
	ls_SQL	= ls_SQL + " and articolo.id_cat_codifica = " + string(ll_id_cat_cod)
end if

if	not isNull( ll_id_cat_com ) then
	ls_SQL	= ls_SQL + " and articolo.id_cat_com_articolo = " + string(ll_id_cat_com)
end if

if	not isNull( ll_id_cat_merc ) then
	ls_SQL	= ls_SQL + " and articolo.id_cat_merceologica = " + string(ll_id_cat_merc)
end if

if	not isNull( ll_id_cat_fisc ) then
	ls_SQL	= ls_SQL + " and articolo.id_cat_fiscale = " + string(ll_id_cat_fisc)
end if

if	not isNull( ll_id_gruppo ) then
	ls_SQL	= ls_SQL + " and articolo.id_gruppo_articoli = " + string(ll_id_gruppo)
end if
if	not isNull( ll_id_fornitore ) then
	ls_SQL	= ls_SQL + " and articolo.id_sog_commerciale = " + string(ll_id_fornitore)
end if

if	not isNull( ll_id_produttore ) then
	ls_SQL	= ls_SQL + " and articolo.id_anagrafica = " + string(ll_id_produttore)
end if

return ls_SQL
end function

public function integer wf_check_magazzino ();
string		ls_errmsg, ls_da_codice, ls_a_codice
long			ll_row, ll_id_magazzino
decimal		ldc_1, ldc_2
integer		li_ret

ls_errmsg = ""
li_ret = 0

if tab_1.tabpage_1.dw_fabbisogno_scorte_wz.accepttext() < 0 then
	return -1
end if

ll_row 	= tab_1.tabpage_1.dw_fabbisogno_scorte_wz.getrow()
if ll_row	>	0 then
	
	ll_id_magazzino = tab_1.tabpage_1.dw_fabbisogno_scorte_wz.GetItemNumber(ll_row,"id_magazzino")
	
	if isNull(ll_id_magazzino) then
		ls_errmsg += "E' indispensabile un magazzino su cui operare!~r~n"
	end if
	
else
	ls_errmsg += "Errore critico nell'accesso ai dati di dw_fabbisogno_scorte_gd!"
end if

ll_row = tab_1.tabpage_1.dw_fabbisogno_scorte_wz.getrow()
if ll_row>0 then
	
	
	ls_da_codice = tab_1.tabpage_1.dw_fabbisogno_scorte_wz.getitemstring(ll_row,"cod_art1")
	ls_a_codice	 = tab_1.tabpage_1.dw_fabbisogno_scorte_wz.getitemstring(ll_row,"cod_art2")
	
	if (not isNull(ls_da_codice)) and (not isNull(ls_a_codice)) and (ls_da_codice>"") and (ls_a_codice>"") then
		if ls_da_codice > ls_a_codice then
			ls_errmsg += "Gli estremi per il codice articolo non sono validi!~r~n"
		end if
	end if
	
else
	ls_errmsg += "Errore critico nell'accesso ai dati di dw_fabbisogno_scorte_gd!"
end if

if ls_errmsg > "" then
	messageBox("Attenzione, errori!",ls_errmsg)
	li_ret = -1
end if

return li_ret

end function

public function integer wf_retrieve_tabella ();
long		ll_row,ll_id_articolo,ll_id_magazzino,ll_id_cat_cod
long		ll_id_azienda
long		ll_id_cat_com,ll_id_cat_merc,ll_id_cat_fisc,ll_id_gruppo
long		ll_id_produttore,ll_id_fornitore
string	ls_da_codice,ls_a_codice,ls_SQL,ls_SQL_dw

ll_row				= this.tab_1.tabpage_1.dw_fabbisogno_scorte_wz.GetRow()
ls_da_codice		= this.tab_1.tabpage_1.dw_fabbisogno_scorte_wz.GetItemString( ll_row,"cod_art1" )
ls_a_codice			= this.tab_1.tabpage_1.dw_fabbisogno_scorte_wz.GetItemString( ll_row,"cod_art2" )
ll_id_cat_cod		= this.tab_1.tabpage_1.dw_fabbisogno_scorte_wz.GetItemNumber( ll_row,"id_cat_codifica" )
ll_id_magazzino	= this.tab_1.tabpage_1.dw_fabbisogno_scorte_wz.GetItemNumber( ll_row,"id_magazzino" )
ll_id_cat_com		= this.tab_1.tabpage_1.dw_fabbisogno_scorte_wz.GetItemNumber( ll_row,"id_cat_com_articolo" )
ll_id_cat_merc		= this.tab_1.tabpage_1.dw_fabbisogno_scorte_wz.GetItemNumber( ll_row,"id_cat_merceologica" )
ll_id_cat_fisc		= this.tab_1.tabpage_1.dw_fabbisogno_scorte_wz.GetItemNumber( ll_row,"id_cat_fiscale" )
ll_id_gruppo		= this.tab_1.tabpage_1.dw_fabbisogno_scorte_wz.GetItemNumber( ll_row,"id_gruppo" )
ll_id_fornitore	= this.tab_1.tabpage_1.dw_fabbisogno_scorte_wz.GetItemNumber( ll_row,"id_fornitore" )
ll_id_produttore	= this.tab_1.tabpage_1.dw_fabbisogno_scorte_wz.GetItemNumber( ll_row,"id_produttore" )


ls_SQL	= "select articolo.codice," + &   
         		"articolo.descrizione," + &   
		         "unita_confezione.codice," + &   
      		   "fabbisogno.disponibilita," + &   
		         "fabbisogno.esistenza," + &   
      		   "fabbisogno.qta_riordino," + &   
		         "fabbisogno.id_fabbisogno," + &   
		         "fabbisogno.id_magazzino," + &   
      		   "fabbisogno.id_sog_commerciale," + &   
		         "fabbisogno.id_unita_confezione," + &   
      		   "fabbisogno.id_articolo," + &   
		         "fabbisogno.qta_ord_fornitore," + &   
      		   "fabbisogno.qta_ord_cliente," + &   
		         "fabbisogno.disp_globale," + &   
      		   "fabbisogno.esist_globale," + &   
		         "fabbisogno.data_generazione " + &  
		    "from fabbisogno," + &  
         		"articolo," + &  
		         "unita_confezione " + & 
		    "where articolo.id_articolo = fabbisogno.id_articolo and " + &  
         		"unita_confezione.id_articolo = articolo.id_articolo and " + &  
         		"unita_confezione.id_unita_confezione = fabbisogno.id_unita_confezione "
			  
			  
if	not isNull( ls_da_codice ) then
	ls_SQL	= ls_SQL + " and articolo.codice >= '" + ls_da_codice + "'"
end if

if	not isNull( ls_a_codice ) then
	ls_SQL	= ls_SQL + " and articolo.codice <= '" + ls_a_codice + "'"
end if

if	not isNull( ll_id_cat_cod ) then
	ls_SQL	= ls_SQL + " and articolo.id_cat_codifica = " + string(ll_id_cat_cod)
end if

if	not isNull( ll_id_cat_com ) then
	ls_SQL	= ls_SQL + " and articolo.id_cat_com_articolo = " + string(ll_id_cat_com)
end if

if	not isNull( ll_id_cat_merc ) then
	ls_SQL	= ls_SQL + " and articolo.id_cat_merceologica = " + string(ll_id_cat_merc)
end if

if	not isNull( ll_id_cat_fisc ) then
	ls_SQL	= ls_SQL + " and articolo.id_cat_fiscale = " + string(ll_id_cat_fisc)
end if

if	not isNull( ll_id_gruppo ) then
	ls_SQL	= ls_SQL + " and articolo.id_gruppo_articoli = " + string(ll_id_gruppo)
end if
if	not isNull( ll_id_produttore ) then
	ls_SQL	= ls_SQL + " and articolo.id_anagrafica = " + string(ll_id_produttore)
end if

if	not isNull( ll_id_magazzino ) then
	ls_SQL	= ls_SQL + " and fabbisogno.id_magazzino = " + string(ll_id_magazzino)
end if

tab_1.tabpage_2.dw_tabella.object.datawindow.table.select	= ls_SQL

tab_1.tabpage_2.dw_tabella.SetTransObject(SQLCA)
tab_1.tabpage_2.dw_tabella.retrieve() 

if SQLCA.SQLCode = 0 then
	COMMIT using SQLCA;
end if

if SQLCA.SQLCode = -1 then
	MessageBox( "Errore","Error delete sql",StopSign! )
	return -1
end if	

return 0
end function

public function integer wf_stampa ();
long				ll_retv, ll_sqlcode, ll_sqlrows
long				ll_id_cat_cod,ll_id_cat_comm,ll_id_cat_merc,ll_id_cat_fisc,ll_id_gruppo
long				ll_id_produttore,ll_id_fornitore,ll_id_magazzino
string			ls_msg_a, ls_msg_b,ls_title
string			ls_nome_report, ls_dir_report
string			ls_selection_formula
string			ls_da_art, ls_a_art, ls_salto_pagina,ls_produttore,ls_fornitore
string 			statement, ls_selezione
boolean			lb_can_go
integer			li_outdev, li_stampa_ok
integer 			li_retvalue
window			lw_win
s_formula		lstr_formule[]

ls_da_art				= tab_1.tabpage_1.dw_fabbisogno_scorte_wz.GetItemString(1,"cod_art1")
ls_a_art					= tab_1.tabpage_1.dw_fabbisogno_scorte_wz.GetItemString(1,"cod_art1")
ll_id_cat_cod			= tab_1.tabpage_1.dw_fabbisogno_scorte_wz.GetItemNumber(1,"id_cat_codifica")
ll_id_cat_comm			= tab_1.tabpage_1.dw_fabbisogno_scorte_wz.GetItemNumber(1,"id_cat_com_articolo")
ll_id_cat_merc			= tab_1.tabpage_1.dw_fabbisogno_scorte_wz.GetItemNumber(1,"id_cat_merceologica")
ll_id_cat_fisc			= tab_1.tabpage_1.dw_fabbisogno_scorte_wz.GetItemNumber(1,"id_cat_fiscale")
ll_id_gruppo			= tab_1.tabpage_1.dw_fabbisogno_scorte_wz.GetItemNumber(1,"id_gruppo")
ll_id_fornitore		= tab_1.tabpage_1.dw_fabbisogno_scorte_wz.GetItemNumber(1,"id_fornitore" )
ls_fornitore			= tab_1.tabpage_1.dw_fabbisogno_scorte_wz.GetItemString(1,"des_forn" )
ll_id_produttore		= tab_1.tabpage_1.dw_fabbisogno_scorte_wz.GetItemNumber(1,"id_produttore" )
ls_produttore			= tab_1.tabpage_1.dw_fabbisogno_scorte_wz.GetItemString(1,"des_prod" )
ll_id_magazzino		= tab_1.tabpage_1.dw_fabbisogno_scorte_wz.GetItemNumber(1,"id_magazzino" )
ls_salto_pagina		= "S"

statement  = " {Articolo.ID_Azienda} = 1"

if Not IsNull(ll_id_cat_cod) then
	statement 		= statement + " AND {Articolo.id_cat_codifica} = " + string(ll_id_cat_cod)  
	ls_selezione 	= " Categoria di codifica " + string(ll_id_cat_cod) + ", "
else
	ls_selezione 	= " Categoria di codifica - non definita, "	
end if

if Not IsNull(ls_da_art) and ls_da_art <> "" then
	statement 		= statement + " AND {Articolo.codice} >= '" + ls_da_art + "'"
	ls_selezione 	= ls_selezione + " Da articolo " + ls_da_art + ", "
else
	ls_selezione 	= " Da articolo non definito, "
end if

if Not IsNull(ls_a_art) and ls_a_art <> "" then
	statement 		= statement + " AND {Articolo.codice} <= '" + ls_a_art + "'"
	ls_selezione 	= ls_selezione + "a articolo " + ls_a_art + "."
else
	ls_selezione 	= ls_selezione + "a articolo non definito."
end if

if Not IsNull(ll_id_cat_comm) then
	statement 		= statement + " AND {Articolo.id_cat_com_articolo} = " + string(ll_id_cat_comm)  
	ls_selezione 	= " Categoria commerciale " + string(ll_id_cat_comm) + ", "
else
	ls_selezione 	= " Categoria commerciale - non definita, "	
end if

if Not IsNull(ll_id_cat_merc) then
	statement 		= statement + " AND {Articolo.id_cat_merceologica} = " + string(ll_id_cat_merc)  
	ls_selezione 	= " Categoria merceologica " + string(ll_id_cat_merc) + ", "
else
	ls_selezione 	= " Categoria merceologica - non definita, "	
end if

if Not IsNull(ll_id_cat_fisc) then
	statement 		= statement + " AND {Articolo.id_cat_fiscale} = " + string(ll_id_cat_fisc)  
	ls_selezione 	= " Categoria fiscale " + string(ll_id_cat_fisc) + ", "
else
	ls_selezione 	= " Categoria fiscale - non definita, "	
end if

if Not IsNull(ll_id_gruppo) then
	statement 		= statement + " AND {Articolo.id_gruppo_articoli} = " + string(ll_id_gruppo)  
	ls_selezione 	= " Gruppo articoli " + string(ll_id_gruppo) + ", "
else
	ls_selezione 	= " Gruppo articoli - non definita, "	
end if

if Not IsNull(ll_id_produttore) then
	statement 		= statement + " AND {Articolo.id_anagrafica} = " + string(ll_id_produttore)  
	ls_selezione 	= " Produttore " + ls_produttore + ", "
else
	ls_selezione 	= " Produttore - non definito, "	
end if

if Not IsNull(ll_id_fornitore) then
	statement 		= statement + " AND {Fabbisogno.id_sog_commerciale} = " + string(ll_id_fornitore)  
	ls_selezione 	= " Fornitore " + ls_fornitore + ", "
else
	ls_selezione 	= " Fornitore - non definito, "	
end if

if Not IsNull(ll_id_magazzino) then
	statement 		= statement + " AND {Fabbisogno.id_magazzino} = " + string(ll_id_magazzino)  
	ls_selezione 	= " Magazzino " + string(ll_id_magazzino) + ", "
else
	ls_selezione 	= " Magazzino - non definito, "	
end if

if isNull(ls_salto_pagina) then ls_salto_pagina = "N"

ls_selection_formula		= statement

lstr_formule[1].formula_name 		= "selezione"
lstr_formule[1].formula_string 	= "'" + ls_selezione + "'"
lstr_formule[2].formula_name 		= "salto_pagina"
lstr_formule[2].formula_string 	= "'" + ls_salto_pagina + "'"



ls_title = ""

ls_msg_a 			= "Stampa Documento; Warning!"


lb_can_go = true


ls_title = "Stampa Fabbisogno"  

ls_nome_report			= "grr_fabbisogno.rpt"

if lb_can_go then
	OpenWithParm(lw_win,ls_nome_report,"w_st_prov_def_wz")
	ll_retv = Message.DoubleParm
	CHOOSE CASE ll_retv
		CASE 0							
			li_outdev = 1
		CASE 1							
			li_outdev = 1						
		CASE 2							
			li_outdev = 2
		CASE 3							
			li_outdev = 2			
		CASE -1							
			lb_can_go = false
		CASE ELSE						
			lb_can_go = false
	END CHOOSE
end if

if lb_can_go then
	
	select "par_sistema"."dir_report" into :ls_dir_report
		from "dba"."par_sistema"
		where "par_sistema"."id_azienda" = 1
		using SQLCA;
		
	ll_sqlcode = sqlca.sqlcode
	ll_sqlrows = sqlca.sqlnrows
	if (isNull(ls_dir_report)) or (ll_sqlcode<>0) or (ll_sqlrows>1) then
		messageBox(ls_msg_a, ls_msg_b)
		lb_can_go = false
	end if	
	
end if

if lb_can_go then
//	u_freddie.iuo_stampa.of_set_selection_formula(ls_selection_formula) 
//	u_freddie.iuo_stampa.of_set_Formula( lstr_formule )	
//	u_freddie.iuo_stampa.of_set_Title(ls_title) 
//	u_freddie.iuo_stampa.of_set_view(u_freddie.iuo_stampa.MAXIMIZE_VIEW)
//	li_stampa_ok = u_freddie.iuo_stampa.of_stampa(0, li_outdev, 0, 0, 1,ls_dir_report, ls_nome_report)
end if	

if li_stampa_OK <> 0 then
	ls_msg_b = "Errore in fase di stampa"
	MessageBox(ls_msg_a, ls_msg_b)
end if

return 0
end function

on w_fabbisogno_scorte_wz.create
int iCurrent
call w_wiz_main::create
this.tab_1=create tab_1
this.cb_esci=create cb_esci
this.cb_salva=create cb_salva
this.cb_inserisci=create cb_inserisci
this.cb_cancella=create cb_cancella
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=tab_1
this.Control[iCurrent+2]=cb_esci
this.Control[iCurrent+3]=cb_salva
this.Control[iCurrent+4]=cb_inserisci
this.Control[iCurrent+5]=cb_cancella
end on

on w_fabbisogno_scorte_wz.destroy
call w_wiz_main::destroy
destroy(this.tab_1)
destroy(this.cb_esci)
destroy(this.cb_salva)
destroy(this.cb_inserisci)
destroy(this.cb_cancella)
end on

event open;call super::open;long					ll_row
string				ls_sql

ll_row	= this.tab_1.tabpage_1.dw_fabbisogno_scorte_wz.InsertRow(0)
this.tab_1.tabpage_1.dw_fabbisogno_scorte_wz.ScrollToRow(ll_row)

ll_row	= this.tab_1.tabpage_2.dw_tabella.InsertRow(0)
this.tab_1.tabpage_2.dw_tabella.ScrollToRow(ll_row)

ids_fab	= create u_ds_main
if not isValid( ids_fab ) then
	MessageBox( "Errore","Error creating datastore",StopSign! )
	return -1
end if

ids_fab.dataobject	= "d_scorte_fabbisogno_ds"

end event

event closequery;call super::closequery;
return 0

end event

event key;call super::key;
if key = KeyF6! then
	choose case keyflags
		case 0
			
			ii_dwi ++
			if ii_dwi>3 then ii_dwi=1
		case 1
			
			ii_dwi --
			if ii_dwi<1 then ii_dwi=3
	end choose
	wf_dwsetfocus()
end if



end event

event ue_post_open;call super::ue_post_open;ii_dwi=1
wf_dwsetfocus()
end event

event close;call super::close;if isValid( ids_fab ) then
	destroy ids_fab
end if

end event

type tab_1 from tab within w_fabbisogno_scorte_wz
int X=46
int Y=141
int Width=2606
int Height=1461
int TabOrder=50
boolean BringToTop=true
boolean RaggedRight=true
int SelectedTab=1
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={ this.tabpage_1,&
this.tabpage_2}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

event selectionchanged;long		ll_row,ll_id_magazzino
string	ls_codice,ls_descrizione

choose case newindex
	case 2
		ll_row				= this.tabpage_1.dw_fabbisogno_scorte_wz.GetRow()
		ll_id_magazzino	= this.tabpage_1.dw_fabbisogno_scorte_wz.GetItemNumber( ll_row,"id_magazzino" )
		select "magazzino"."codice","magazzino"."descrizione"
			into :ls_codice, :ls_descrizione
			from "dba"."magazzino"
			where "magazzino"."id_magazzino" = :ll_id_magazzino
			using SQLCA;
		if SQLCA.SQLCode = 0 then
			tabpage_2.st_mag_codice.Text	= ls_codice
			tabpage_2.st_mag_des.text		= ls_descrizione
		end if

end choose
end event

type tabpage_1 from userobject within tab_1
int X=19
int Y=105
int Width=2570
int Height=1341
long BackColor=79741120
string Text="Selezioni"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_fabbisogno_scorte_wz dw_fabbisogno_scorte_wz
cb_procedi cb_procedi
cb_vista cb_vista
end type

on tabpage_1.create
this.dw_fabbisogno_scorte_wz=create dw_fabbisogno_scorte_wz
this.cb_procedi=create cb_procedi
this.cb_vista=create cb_vista
this.Control[]={ this.dw_fabbisogno_scorte_wz,&
this.cb_procedi,&
this.cb_vista}
end on

on tabpage_1.destroy
destroy(this.dw_fabbisogno_scorte_wz)
destroy(this.cb_procedi)
destroy(this.cb_vista)
end on

type dw_fabbisogno_scorte_wz from u_dw_ext_main within tabpage_1
int X=28
int Y=157
int Width=2515
int Height=1081
int TabOrder=10
string DataObject="d_sel_fabbisogno_wz"
end type

event ue_init;call super::ue_init;long					ll_row
integer				li_i
datawindowchild	ldwc_drop	

is_colonne_drop[1] = "id_cat_codifica"
is_colonne_drop[2] = "id_cat_com_articolo"
is_colonne_drop[3] = "id_cat_merceologica"
is_colonne_drop[4] = "id_cat_fiscale"
is_colonne_drop[5] = "id_gruppo"
is_colonne_drop[6] = "id_old_lis"
is_colonne_drop[7] = "id_old_var"
is_colonne_drop[8] = "id_cat_com_articolo_des"
is_colonne_drop[9] = "id_cat_merceologica_des"


for li_i = 1 to UpperBound( is_colonne_drop )
	this.GetChild( is_colonne_drop[li_i],ldwc_drop )
	ldwc_drop.SetTransObject( SQLCA )
	ldwc_drop.Retrieve()
next
end event

event ue_set_search;call super::ue_set_search;

choose case as_nomecol
		
	case "cod_art1", "cod_art2"
		is_search_window 				= "w_articolo_coddes_sw"
		is_ricpar.s_filter_value	= as_valcol
		is_ricpar.s_filter_name 	= "articolo_codice"
	case "des_art1", "des_art2"
		is_search_window = "w_articolo_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "articolo_descrizione"
		
	case "des_prod"
		is_search_window = "w_anagrafica_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "rag_soc_1"
		
	case "cod_forn"
		is_search_window = "w_sog_commerciale_gen_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "codice"
		is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo = 'F'"
	case "des_forn"
		is_search_window = "w_sog_commerciale_gen_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "rag_soc_1"
		is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo = 'F'"

	case "cod_mag"
		is_search_window = "w_magazzino_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "codice"
	case "des_mag"
		is_search_window = "w_magazzino_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "descrizione"

end choose

end event

event ue_use_search;call super::ue_use_search;

choose case as_nomecol
	case "cod_art1"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("des_art1", is_ricpar.s_ausil_value[1])
		uf_set_colval("cod_art2", is_ricpar.s_main_value)
		uf_set_colval("des_art2", is_ricpar.s_ausil_value[1])
	case "des_art1"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("cod_art1", is_ricpar.s_ausil_value[1])
		uf_set_colval("des_art2", is_ricpar.s_main_value)
		uf_set_colval("cod_art2", is_ricpar.s_ausil_value[1])
	case "cod_art2"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("des_art2", is_ricpar.s_ausil_value[1])
	case "des_art2"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("cod_art2", is_ricpar.s_ausil_value[1])

	case "des_prod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_produttore", is_ricpar.s_id_seg_value[1])
		
	case "cod_forn"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_fornitore", is_ricpar.s_id_seg_value[1])
		uf_set_colval("des_forn", is_ricpar.s_ausil_value[1])
	case "des_forn"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_fornitore", is_ricpar.s_id_seg_value[1])
		uf_set_colval("cod_forn", is_ricpar.s_ausil_value[1])
		
	case "cod_mag"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_magazzino", is_ricpar.s_id_seg_value[1])
		uf_set_colval("des_mag", is_ricpar.s_ausil_value[1])
	case "des_mag"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_magazzino", is_ricpar.s_id_seg_value[1])
		uf_set_colval("cod_mag", is_ricpar.s_ausil_value[1])	
		
end choose

end event

event itemchanged;call super::itemchanged;
string		ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
string		ls_a, ls_b, ls_c, ls_pc
date			ld_data_inizio
long			ll_a, ll_ok, ll_row, ll_scode

DataWindowChild	dwc_drop
string				ls_sql, ls_add


ll_row = GetRow()
if ll_row > 0 then

	choose case dwo.name
		
		
		
		
		
		CASE "cod_art1"
			ls_pc = data
			SELECT	"articolo"."id_articolo",
						"articolo"."codice",
						"articolo"."descrizione"
				INTO	:ll_a, :ls_b, :ls_c  
				FROM	"dba"."articolo"  
				WHERE "articolo"."codice" = :ls_pc;
			
			if sqlca.sqlcode=0 then
				setItem (ll_row,"cod_art1",ls_b)
				setItem (ll_row,"des_art1",ls_c)
				setItem (ll_row,"cod_art2",ls_b)
				setItem (ll_row,"des_art2",ls_c)
				return 2
			else
				setItem (ll_row,"des_art1",u_freddie.gs_null)
				return 0
			end if

		CASE 'des_art1'
			ls_sql_cond = ""
			ls_dbc[1] = "codice"
			ls_dwc[1] = "cod_art1"
			ls_dbc[2] = "descrizione"
			ls_dwc[2] = "des_art1"
			ls_dbc[3] = "codice"
			ls_dwc[3] = "cod_art2"
			ls_dbc[4] = "descrizione"
			ls_dwc[4] = "des_art2"
			ll_ok = uf_autofind_col(dwo.Name, "articolo", &  
											"descrizione", "A", data, & 
											ls_sql_cond, 2, &
											ls_dbc, ls_dbv, ls_dwc)
			IF (ll_ok > 0) THEN
				RETURN 2
			END IF

		
		
		
		CASE "cod_art2"
			ls_pc = data
			SELECT	"articolo"."id_articolo",
						"articolo"."codice",
						"articolo"."descrizione"
				INTO	:ll_a, :ls_b, :ls_c  
				FROM	"dba"."articolo"  
				WHERE "articolo"."codice" = :ls_pc;
			
			if sqlca.sqlcode=0 then
				setItem (ll_row,"cod_art2",ls_b)
				setItem (ll_row,"des_art2",ls_c)
				return 2
			else
				setItem (ll_row,"des_art2",u_freddie.gs_null)
				return 0
			end if

		CASE 'des_art2'
			ls_sql_cond = ""
			ls_dbc[1] = "codice"
			ls_dwc[1] = "cod_art2"
			ls_dbc[2] = "descrizione"
			ls_dwc[2] = "des_art2"
			ll_ok = uf_autofind_col(dwo.Name, "articolo", &  
											"descrizione", "A", data, & 
											ls_sql_cond, 2, &
											ls_dbc, ls_dbv, ls_dwc)
			IF (ll_ok > 0) THEN
				RETURN 2
			END IF

		
		
		
		CASE 'des_prod'
			ls_sql_cond = ""
			ls_dbc[1] = "id_anagrafica"
			ls_dwc[1] = "id_produttore"
			ls_dbc[2] = "rag_soc_1"
			ls_dwc[2] = "des_prod"
			ll_ok = uf_autofind_col(dwo.Name, "anagrafica", &  
											"rag_soc_1", "A", data, & 
											ls_sql_cond, 2, &
											ls_dbc, ls_dbv, ls_dwc)
			IF (ll_ok > 0) THEN
				RETURN 2
			END IF		
	
		
		
		
		CASE 'cod_forn'
			ls_sql_cond = "sog_commerciale_gen.tipo = 'F'"		
			ls_dbc[1] = "id_sog_commerciale"
			ls_dwc[1] = "id_fornitore"
			ls_dbc[2] = "codice"
			ls_dwc[2] = "cod_forn"
			ls_dbc[3] = "rag_soc_1"
			ls_dwc[3] = "des_forn"

			ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &  
											"codice", "A", data, & 
											ls_sql_cond, 3, &
											ls_dbc, ls_dbv, ls_dwc)
			IF (ll_ok > 0) THEN
				RETURN 2
			END IF	
	
		CASE 'des_forn'
			ls_sql_cond = "sog_commerciale_gen.tipo = 'F'"				
			ls_dbc[1] = "id_sog_commerciale"
			ls_dwc[1] = "id_fornitore"
			ls_dbc[2] = "codice"
			ls_dwc[2] = "cod_forn"
			ls_dbc[3] = "rag_soc_1"
			ls_dwc[3] = "des_forn"
			ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &  
											"rag_soc_1", "A", data, & 
											ls_sql_cond, 3, &
											ls_dbc, ls_dbv, ls_dwc)
			IF (ll_ok > 0) THEN
				RETURN 2
			END IF

		
		
		
		CASE 'cod_mag'
			ls_sql_cond = ""		
			ls_dbc[1] = "id_magazzino"
			ls_dwc[1] = "id_magazzino"
			ls_dbc[2] = "codice"
			ls_dwc[2] = "cod_mag"
			ls_dbc[3] = "descrizione"
			ls_dwc[3] = "des_mag"
			ll_ok = uf_autofind_col(dwo.Name, "magazzino", &  
											"codice", "A", data, & 
											ls_sql_cond, 3, &
											ls_dbc, ls_dbv, ls_dwc)
			IF (ll_ok > 0) THEN
				RETURN 2
			END IF	
	
		CASE 'des_mag'
			ls_sql_cond = ""				
			ls_dbc[1] = "id_magazzino"
			ls_dwc[1] = "id_magazzino"
			ls_dbc[2] = "codice"
			ls_dwc[2] = "cod_mag"
			ls_dbc[3] = "descrizione"
			ls_dwc[3] = "des_mag"
			ll_ok = uf_autofind_col(dwo.Name, "magazzino", &  
											"descrizione", "A", data, & 
											ls_sql_cond, 3, &
											ls_dbc, ls_dbv, ls_dwc)
			IF (ll_ok > 0) THEN
				RETURN 2
			END IF
		
	end choose

end if





end event

event ue_key;call super::ue_key;
if key = KeyF6! then
	choose case keyflags
		case 0
			
			ii_dwi ++
			if ii_dwi>2 then ii_dwi=1
		case 1
			
			ii_dwi --
			if ii_dwi<1 then ii_dwi=2
	end choose
	wf_dwsetfocus()
end if



end event

type cb_procedi from commandbutton within tabpage_1
int X=2236
int Y=37
int Width=284
int Height=85
int TabOrder=30
boolean BringToTop=true
string Text="Procedi..."
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
long			ll_nmod
integer		li_ync, li_retval
integer		li_val1

if tab_1.tabpage_2.dw_tabella.accepttext() > 0 then
	
	ll_nmod = tab_1.tabpage_2.dw_tabella.deletedcount()+tab_1.tabpage_2.dw_tabella.modifiedcount()
	
	if ll_nmod>0 then
		
		li_ync = MessageBox("Fabbisogno scorte", "Vi sono aggiornamenti del fabbisogno non salvati." + &
			"~n~rVuoi salvarli prima di continuare?", Question!, YesNoCancel!)

		CHOOSE CASE li_ync
			CASE 1
				
				tab_1.tabpage_2.dw_tabella.triggerevent("ue_update")
				ll_nmod = tab_1.tabpage_2.dw_tabella.deletedcount()+tab_1.tabpage_2.dw_tabella.modifiedcount()
				if ll_nmod = 0 then 
					li_retval = 0
				else
					li_retval = 1
				end if
				
			CASE 2
				
				li_retval = 0
				
			CASE 3
				
				li_retval = 1
				
		END CHOOSE
	else
		
		li_retval = 0
	end if
else
	
	li_retval = 1
end if

if li_retval=0 then

	
	
	
	open (iw_wait,"w_wait_01")
	
	cb_cancella.enabled 	= false
	cb_inserisci.enabled = false
	cb_salva.enabled 		= false
	
	tab_1.tabpage_2.dw_tabella.reset()
	
	li_val1 = wf_check_magazzino()
	
	if li_val1 = 0 then
		if wf_delete_fabbisogno() = 0 then
			wf_calcola_scorte()
		end if	
		cb_cancella.enabled 	= true
		cb_inserisci.enabled = true
		cb_salva.enabled 		= true
		ii_dwi = 2
		wf_dwsetfocus()
	end if
	
	close (iw_wait)

end if


return 0
end event

type cb_vista from commandbutton within tabpage_1
int X=1925
int Y=37
int Width=284
int Height=85
int TabOrder=31
boolean BringToTop=true
string Text="Vista"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
integer	li_val1
open (iw_wait,"w_wait_01")
	
cb_cancella.enabled 	= false
cb_inserisci.enabled = false
cb_salva.enabled 		= false
	
tab_1.tabpage_2.dw_tabella.reset()
	
li_val1 = wf_check_magazzino()
	
if li_val1 = 0 then
	wf_retrieve_tabella()
	ii_dwi = 2
	wf_dwsetfocus()
end if	

cb_cancella.enabled 	= true
cb_inserisci.enabled = true
cb_salva.enabled 		= true

close (iw_wait)

return 0
end event

type tabpage_2 from userobject within tab_1
int X=19
int Y=105
int Width=2570
int Height=1341
long BackColor=79741120
string Text="Risultati"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_tabella dw_tabella
st_magazzino st_magazzino
st_mag_codice st_mag_codice
st_mag_des st_mag_des
cb_stampa cb_stampa
end type

on tabpage_2.create
this.dw_tabella=create dw_tabella
this.st_magazzino=create st_magazzino
this.st_mag_codice=create st_mag_codice
this.st_mag_des=create st_mag_des
this.cb_stampa=create cb_stampa
this.Control[]={ this.dw_tabella,&
this.st_magazzino,&
this.st_mag_codice,&
this.st_mag_des,&
this.cb_stampa}
end on

on tabpage_2.destroy
destroy(this.dw_tabella)
destroy(this.st_magazzino)
destroy(this.st_mag_codice)
destroy(this.st_mag_des)
destroy(this.cb_stampa)
end on

type dw_tabella from u_dw_ext_main within tabpage_2
event ue_delete ( )
event ue_update ( )
int X=28
int Y=157
int Width=2492
int Height=1121
int TabOrder=2
string DataObject="d_risultato_fabbisogno_gd"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event ue_delete;call super::ue_delete;

end event

event ue_update;call super::ue_update;

end event

event ue_key;call super::ue_key;
long			ll_id_fabbisogno,ll_row
s_list_main lstr_list

ll_row	= this.GetRow()

choose case key
	case Keyadd!
		
		if (keyFlags=2) then
			triggerevent ("ue_insert")
		end if
		
	case KeySubtract!
		if (keyFlags=2) then
			triggerevent("ue_delete")
		end if

	case KeyS!
		if (keyFlags=2) then
			triggerevent("ue_update")
		end if

	case KeyF6!
		choose case keyflags
			case 0
				
				ii_dwi ++
				if ii_dwi>2 then ii_dwi=1
			case 1
				
				ii_dwi --
				if ii_dwi<1 then ii_dwi=2
		end choose
		wf_dwsetfocus()
		
	case KeyEnter!
		if ll_row > 0 then
			ll_id_fabbisogno	= this.GetItemNumber( ll_row,"fabbisogno_id_fabbisogno")
			lstr_list.s_identifica[1] = "fabbisogno_id_fabbisogno"
			lstr_list.l_identifica[1] = ll_id_fabbisogno
			lstr_list.s_win_chiave[1] = "fabbisogno_id_fabbisogno"
			lstr_list.s_modo 			  = modo_modifica
			if not isNull(ll_id_fabbisogno) then
				OpenWithParm( w_fabbisogno_ff,lstr_list )
				wf_retrieve_tabella()
			end if
		end if

end choose
end event

event ue_insert;
end event

event ue_set_search;call super::ue_set_search;
long		ll_row, ll_idart

choose case as_nomecol
	case "articolo_codice"
		is_search_window = "w_articolo_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "articolo_codice"
		is_ricpar.s_sql_cond = ""
	case "articolo_descrizione"
		is_search_window = "w_articolo_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "articolo_descrizione"
		is_ricpar.s_sql_cond = ""
		
	case "unita_confezione_codice"
		is_search_window = "w_unita_confezione_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "unita_confezione_codice"
		ll_row 	= getRow()
		ll_idart	= getitemnumber(ll_row,"fabbisogno_id_articolo")
		is_ricpar.s_sql_cond = "unita_confezione.id_articolo = "+string(ll_idart)

end choose

end event

event ue_use_search;call super::ue_use_search;choose case as_nomecol
	case "articolo_codice"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("fabbisogno_id_articolo", is_ricpar.s_id_seg_value[1])
		uf_set_colval("articolo_descrizione", is_ricpar.s_ausil_value[1])
	case "articolo_descrizione"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("fabbisogno_id_articolo", is_ricpar.s_id_seg_value[1])
		uf_set_colval("articolo_codice", is_ricpar.s_ausil_value[1])
	case "unita_confezione_codice"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("fabbisogno_id_unita_confezione", is_ricpar.s_id_seg_value[1])
end choose
end event

event ue_init;call super::ue_init;is_title = "Fabbisogno scorte"
end event

event doubleclicked;call super::doubleclicked;
long			ll_id_fabbisogno
s_list_main lstr_list


if row > 0 then
	ll_id_fabbisogno	= this.GetItemNumber( row,"fabbisogno_id_fabbisogno")
	lstr_list.s_identifica[1] = "fabbisogno_id_fabbisogno"
	lstr_list.l_identifica[1] = ll_id_fabbisogno
	lstr_list.s_win_chiave[1] = "fabbisogno_id_fabbisogno"
	lstr_list.s_modo 			  = modo_modifica
	
	if not isNull(ll_id_fabbisogno) then
		OpenWithParm( w_fabbisogno_ff,lstr_list )
		wf_retrieve_tabella()
	end if
end if

end event

event rowfocuschanged;call super::rowfocuschanged;long ll_row, ll_nrows

ll_nrows = this.rowCount()
ll_row = currentrow

SelectRow(0,FALSE)
if (ll_row>0) and (ll_row<=ll_nrows) then
	SelectRow(currentrow, TRUE)
end if
end event

type st_magazzino from statictext within tabpage_2
int X=28
int Y=37
int Width=366
int Height=61
boolean Enabled=false
boolean BringToTop=true
string Text="Magazzino  :"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=79741120
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_mag_codice from statictext within tabpage_2
int X=417
int Y=37
int Width=389
int Height=61
boolean Enabled=false
boolean BringToTop=true
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_mag_des from statictext within tabpage_2
int X=851
int Y=37
int Width=1303
int Height=61
boolean Enabled=false
boolean BringToTop=true
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_stampa from commandbutton within tabpage_2
int X=2222
int Y=37
int Width=284
int Height=85
int TabOrder=32
boolean BringToTop=true
string Text="Stampa"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
wf_stampa()
return 0

end event

type cb_esci from commandbutton within w_fabbisogno_scorte_wz
event clicked pbm_bnclicked
int X=46
int Y=21
int Width=284
int Height=85
int TabOrder=10
boolean BringToTop=true
string Text="Esci"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close (parent)
end event

type cb_salva from commandbutton within w_fabbisogno_scorte_wz
event clicked pbm_bnclicked
int X=2355
int Y=21
int Width=284
int Height=85
int TabOrder=40
boolean Enabled=false
boolean BringToTop=true
string Text="Salva"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;tab_1.tabpage_2.dw_tabella.triggerevent("ue_update")

end event

type cb_inserisci from commandbutton within w_fabbisogno_scorte_wz
event clicked pbm_bnclicked
int X=1692
int Y=21
int Width=284
int Height=85
int TabOrder=30
boolean Enabled=false
boolean BringToTop=true
string Text="Inserisci"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;tab_1.tabpage_2.dw_tabella.triggerevent("ue_insert")

end event

type cb_cancella from commandbutton within w_fabbisogno_scorte_wz
event clicked pbm_bnclicked
int X=2012
int Y=21
int Width=284
int Height=85
int TabOrder=20
boolean Enabled=false
boolean BringToTop=true
string Text="Cancella"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;tab_1.tabpage_2.dw_tabella.triggerevent("ue_delete")

end event

