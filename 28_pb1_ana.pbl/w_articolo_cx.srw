forward
global type w_articolo_cx from w_p_data
end type
type cb_codice from commandbutton within tabpage_1
end type
type st_information from statictext within tabpage_1
end type
type dw_unita_confezione2_lt from u_dw_master_main within tabpage_1
end type
type cb_ingrandisci_immagine from commandbutton within tabpage_1
end type
type cb_2 from commandbutton within tabpage_1
end type
type ole_imm from olecustomcontrol within tabpage_1
end type
type dw_articolo_gen_ff from u_dw_master_main within tabpage_1
end type
type tabpage_2 from userobject within tab_1
end type
type dw_articolo_gen2_ff from u_dw_master_main within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_articolo_gen2_ff dw_articolo_gen2_ff
end type
type tabpage_3 from userobject within tab_1
end type
type dw_articoli_sostituiti_gd from u_dw_master_main within tabpage_3
end type
type st_1 from statictext within tabpage_3
end type
type dw_sostituzione_gd from u_dw_master_main within tabpage_3
end type
type st_2 from statictext within tabpage_3
end type
type tabpage_3 from userobject within tab_1
dw_articoli_sostituiti_gd dw_articoli_sostituiti_gd
st_1 st_1
dw_sostituzione_gd dw_sostituzione_gd
st_2 st_2
end type
type tabpage_4 from userobject within tab_1
end type
type dw_articolo_altro_ff from u_dw_master_main within tabpage_4
end type
type tabpage_4 from userobject within tab_1
dw_articolo_altro_ff dw_articolo_altro_ff
end type
type tabpage_5 from userobject within tab_1
end type
type tabpage_5 from userobject within tab_1
end type
type tabpage_6 from userobject within tab_1
end type
type dw_des_articolo_lt from u_dw_master_main within tabpage_6
end type
type st_5 from statictext within tabpage_6
end type
type st_6 from statictext within tabpage_6
end type
type dw_approvvigionamento_gd from u_dw_master_main within tabpage_6
end type
type tabpage_6 from userobject within tab_1
dw_des_articolo_lt dw_des_articolo_lt
st_5 st_5
st_6 st_6
dw_approvvigionamento_gd dw_approvvigionamento_gd
end type
type tabpage_list_generici from userobject within tab_1
end type
type dw_listino_var_base_articolo_lt from u_dw_master_main within tabpage_list_generici
end type
type tabpage_list_generici from userobject within tab_1
dw_listino_var_base_articolo_lt dw_listino_var_base_articolo_lt
end type
type cb_locazione from commandbutton within w_articolo_cx
end type
type cb_1 from commandbutton within w_articolo_cx
end type
type cb_varianti from commandbutton within w_articolo_cx
end type
type cb_duplica from commandbutton within w_articolo_cx
end type
end forward

global type w_articolo_cx from w_p_data
integer width = 2907
integer height = 1808
string title = "Articolo"
cb_locazione cb_locazione
cb_1 cb_1
cb_varianti cb_varianti
cb_duplica cb_duplica
end type
global w_articolo_cx w_articolo_cx

type variables
string 		is_title_modifica
string		is_col_current
char		ich_old[]
boolean		ib_fix_id
boolean		ib_esiste_progr

s_cod_parte 	istr_cod_tot[]
decimal		idc_w_color
boolean		ib_codice_modificato=FALSE
boolean		ib_reset

string is_vecchio_campo
long il_id_articolo
long		il_old_variante
long		il_old_cat_codifica
 
long		il_index_articolo_base
boolean		ib_control_save

long 		il_id_cat_cod, il_id_cat_com_art, il_id_gruppo_art
string		is_descrizione, is_prod_interna
decimal		id_prezzo
decimal                    id_prezzo_for
string                        is_c_sog_commerciale
string                        is_c_anagrafica
long                          il_id_sog_commerciale

long il_id_val_ven, il_id_val_acq, il_id_val_def 
end variables

forward prototypes
public subroutine uf_titolo_finestra (string as_codice, string as_descrizione)
public function integer uf_ricerca ()
public subroutine uf_prezzi ()
public subroutine uf_mostra_immagine (string immagine)
public subroutine wf_propone_unita_confezione ()
public function string wf_calc_progr (string as_parte[], s_cod_parte astr_cod_parte[], ref integer ai_num_parte, long al_id_cat_codifica)
public subroutine wf_recupera_date_var ()
public subroutine wf_aggiungi_prezzo_a_listino (long al_row, datawindow adw_art)
public subroutine wf_nuovo (integer ai_flag, window aw_articolo)
public subroutine uf_agg_cod_barre (integer al_row, datawindow adw_art)
public subroutine wf_controlla_check (datawindow adw_articolo)
public function integer wf_controlla_esistente (integer ai_codice)
public subroutine wf_setta_campi_nuovo_record ()
public subroutine wf_ultimo_costo ()
public subroutine uf_setta_format (long il_valuta)
public subroutine uf_setta_format_lisven (long il_valuta)
public subroutine uf_setta_format_lisacq (long il_valuta)
public subroutine uf_setta_format_lisgen (long il_valuta)
end prototypes

public subroutine uf_titolo_finestra (string as_codice, string as_descrizione);
string ls_retval, ls_codice, ls_descrizione

ls_retval = is_title_modifica + " "

ls_codice = Trim(as_codice)
ls_descrizione = Trim(as_descrizione)

IF ls_codice = "" THEN SetNull(ls_codice)
IF ls_descrizione = "" THEN SetNull(ls_descrizione)

IF NOT(IsNull(ls_codice)) THEN
	ls_retval = ls_retval + ls_codice

	IF NOT(IsNull(ls_descrizione)) THEN
		ls_retval = ls_retval + " - "
	END IF
END IF

IF NOT(IsNull(ls_descrizione)) THEN ls_retval = ls_retval + ls_descrizione

This.Title = ls_retval
idw_master.is_title = ls_retval
end subroutine

public function integer uf_ricerca ();
w_search_main 		lw_sm
string 				ls_filtro, ls_codice,  ls_parte_codice, ls_descrizione, ls_cod_cat_codifica
s_ric_param			ls_ric_param	
date					ld_data
integer				li_risposta, li_retvalue, li_size, li_count
long					ll_id_cat_codifica, ll_row, ll_id_articolo
boolean				lb_1
u_dw_master_main	ldw_gen

ldw_gen= tab_1.tabpage_1.dw_articolo_gen_ff
If ldw_gen.AcceptText() > 0 then
	ll_row= ldw_gen.GetRow()
	idw_master.is_ricpar.s_filter_value = 	""
	idw_master.is_ricpar.s_filter_name = "articolo_codice"
	
	if ib_codice_modificato then
		li_size= UpperBound(istr_cod_tot)
		For li_count = 1 to li_size
			ls_parte_codice= ldw_gen.GetItemString(ll_row, "c_codice_"+ String(li_count))
			If IsNull(ls_parte_codice) OR ls_parte_codice ="" then ls_parte_codice= Fill("_",istr_cod_tot[li_count].l_lunghezza)
			ls_codice= ls_codice + ls_parte_codice
		next
			idw_master.is_ricpar.s_filter_value = 	ls_codice
			idw_master.is_ricpar.s_filter_name = "articolo_codice"
	else
		ll_id_cat_codifica= ldw_gen.GetItemNumber(ll_row,"id_cat_codifica_des")
		If not(IsNull(ll_id_cat_codifica) OR ll_id_cat_codifica=0) then
			SELECT "cat_codifica"."codice"  
			INTO :ls_cod_cat_codifica
			FROM "dba"."cat_codifica"  
			WHERE "cat_codifica"."id_cat_codifica" = :ll_id_cat_codifica   ;
			idw_master.is_ricpar.s_filter_value = 	ls_cod_cat_codifica
			idw_master.is_ricpar.s_filter_name = "cat_codifica_codice"
		else
			ls_descrizione= ldw_gen.GetItemString(ll_row,"descrizione")
			if not (IsNull(ls_descrizione) OR ls_descrizione="") then
				idw_master.is_ricpar.s_filter_value = 	ls_descrizione
				idw_master.is_ricpar.s_filter_name = "articolo_descrizione"
			end if
		end if
	end if		

	
	If ls_filtro<>"" then ls_filtro= Mid(ls_filtro, 6)
	idw_master.is_ricpar.s_SQL_cond = ls_filtro
	idw_master.is_ricpar.b_asneeded= TRUE
	
	OpenWithParm(lw_sm, idw_master.is_ricpar, "w_articolo_coddes_sw")

	ls_ric_param= Message.PowerObjectParm
	if not IsNull(ls_ric_param) then 
		idw_master.is_ricpar=ls_ric_param
		IF UpperBound(idw_master.is_ricpar.s_id_seg_value) > 0 THEN
			
			if idw_master.uf_to_update() > 0 then
				
				
				if ib_control_save = true then 
					li_risposta = MessageBox(idw_master.is_title, "Ci sono modifiche non salvate nella " + &
						"finestra.~n~rVuoi salvarle?", Question!, YesNo!,1)
					CHOOSE CASE li_risposta
						CASE 1
							
							li_retvalue=idw_master.event ue_update (0,0)
						CASE 2
							
							li_retvalue=0
					END CHOOSE
					ib_control_save = false 
				end if 
			end if
			If li_retvalue=0 then
				ll_id_articolo = long(idw_master.is_ricpar.s_id_seg_value[1])
				idw_master.is_list.s_modo = modo_modifica
				idw_master.is_list.s_identifica[1] = "id_articolo"
				idw_master.is_list.l_identifica[1] = ll_id_articolo
				SetPointer(HourGlass!)
				
				this.enabled= FALSE
				idw_master.Event ue_retrieve(0, 0)
				tab_1.tabpage_1.dw_articolo_gen_ff.TriggerEvent("ue_prepare_codice")
				ll_row = ldw_gen.getRow()
				
				this.enabled= TRUE
		
				SetPointer(Arrow!)
			end if
		END IF
	END IF
END IF
RETURN 0

end function

public subroutine uf_prezzi ();
end subroutine

public subroutine uf_mostra_immagine (string immagine);	
//	
//	string ls_immagine
//	if Pos(immagine, "\")>0 then
//		ls_immagine=immagine
//	else
//		select dir_immagini
//		into :ls_immagine
//		from par_sistema;
//		if right(ls_immagine,1) <> "\" then ls_immagine = ls_immagine+"\"
//		if ls_immagine<>"" and not isnull(ls_immagine) then
//			ls_immagine+=immagine
//		end if
//	end if
//	if FileExists(ls_immagine) then
//		tab_1.tabpage_1.ole_imm.object.aspectratio=1
//		tab_1.tabpage_1.ole_imm.object.loadimage=ls_immagine
//	else
//		tab_1.tabpage_1.ole_imm.object.delimage=true
//	end if










end subroutine

public subroutine wf_propone_unita_confezione ();
Long	ll_unita_conf_base , ll_row

SELECT "par_sistema"."id_unita_conf_base"
INTO	:ll_unita_conf_base
FROM	par_sistema;

ll_row = Tab_1.TabPage_1.dw_articolo_gen_ff.GetRow()
Tab_1.TabPage_1.dw_articolo_gen_ff.SetItem(ll_row,'id_unita_conf_base',ll_unita_conf_base)

end subroutine

public function string wf_calc_progr (string as_parte[], s_cod_parte astr_cod_parte[], ref integer ai_num_parte, long al_id_cat_codifica);
long		ll_ret_value, ll_max,ll_id_cat_codifica
integer	li_sqlerr, li_counter, li_size, li_pos_progr, li_lungh_progr, li_posizione
integer	li_pos_match[], li_lungh_match[],li_count_match
string	ls_sql_statement, ls_parte[], ls_parte_progressiva, ls_riempimento, ls_max

li_size= UpperBound(astr_cod_parte)
li_count_match=0
li_posizione=1
FOR li_counter = 1 TO li_size
	li_count_match++
	if astr_cod_parte[li_counter].s_progressivo = "S" then
		li_pos_progr= li_posizione
		li_lungh_progr= astr_cod_parte[li_counter].l_lunghezza
		ai_num_parte=li_counter
		exit
	else
		li_pos_match[li_count_match]= li_posizione
		li_lungh_match[li_count_match]= astr_cod_parte[li_counter].l_lunghezza
		ls_riempimento=astr_cod_parte[li_counter].s_car_riempimento
		If IsNull(ls_riempimento) OR ls_riempimento="" then ls_riempimento="_"
		ls_parte[li_count_match]= f_rpad(as_parte[li_counter], ls_riempimento,astr_cod_parte[li_counter].l_lunghezza)
	end if
	li_posizione= li_posizione + astr_cod_parte[li_counter].l_lunghezza
next
ls_sql_statement = "SELECT Max(Substr(~"articolo~".~"codice~"," + String(li_pos_progr) + "," +  String(li_lungh_progr) + ")) FROM ~"dba~".~"articolo~"  WHERE "
ls_sql_statement = ls_sql_statement + "Substr(~"articolo~".~"codice~"," + String(li_pos_progr) + "," + String(li_lungh_progr) + ") < '" + Fill("9",li_lungh_progr) + "' "
li_size= UpperBound(li_pos_match)
FOR li_counter = 1 TO li_size
	ls_sql_statement = ls_sql_statement + "AND Substr(~"articolo~".~"codice~"," + String(li_pos_match[li_counter]) + "," + String(li_lungh_match[li_counter]) + ") = '" + ls_parte[li_counter] + "' "
NEXT
ls_sql_statement = ls_sql_statement + "AND (~"articolo~".~"Id_cat_codifica~"='" + String(al_id_cat_codifica)+"');"
li_sqlerr = sqlca.sqlcode
IF li_sqlerr <> 0 THEN
	if li_sqlerr <> 100 then
		MessageBox("Errore nel calcolo del progressivo", "Errore Sql NR. "+String(li_sqlerr))
	else
		MessageBox("Informazione!", " Nessun Articolo Progressivo esistente ~r~n Verra inizializzato il contatore del progressivo" )
	end if
	RETURN ""
END IF
DECLARE lcursor DYNAMIC CURSOR FOR SQLSA;
li_sqlerr = sqlca.sqlcode
IF li_sqlerr <> 0 THEN
	MessageBox("Errore nel calcolo del progressivo", "Errore Sql NR. "+String(li_sqlerr))
	RETURN ""
END IF

PREPARE sqlsa FROM :ls_sql_statement;

OPEN DYNAMIC lcursor USING DESCRIPTOR SQLDA;
li_sqlerr = sqlca.sqlcode
IF li_sqlerr <> 0 THEN
	
	RETURN ""
END IF
FETCH lcursor INTO :ll_max;
li_sqlerr = sqlca.sqlcode
IF li_sqlerr <> 0 THEN
	MessageBox("Errore nel calcolo del progressivo", String(li_sqlerr))
	ls_max= ""
else
	If IsNull(ll_max) then ll_max=0
	ll_max++
	ls_max= f_lpad(String(ll_max), "0",li_lungh_progr)
END IF
CLOSE lcursor;


RETURN ls_max
end function

public subroutine wf_recupera_date_var ();long ll_id_var
date ld_data_inizio, ld_data_fine
integer i

for i = 1 to tab_1.tabpage_list_generici.dw_listino_var_base_articolo_lt.rowcount()
	ll_id_var=tab_1.tabpage_list_generici.dw_listino_var_base_articolo_lt.getitemnumber(i, "id_variazione")
	select data_inizio, data_fine
	into :ld_data_inizio, :ld_data_fine
	from variazione
	where id_variazione= :ll_id_var;
	tab_1.tabpage_list_generici.dw_listino_var_base_articolo_lt.setitem(i,"data_inizio", ld_data_inizio) 
	tab_1.tabpage_list_generici.dw_listino_var_base_articolo_lt.setitem(i,"data_fine", ld_data_fine) 
next
end subroutine

public subroutine wf_aggiungi_prezzo_a_listino (long al_row, datawindow adw_art);
uo_aggiungi_prezzo_a_listino luo_listino
	
luo_listino = CREATE uo_aggiungi_prezzo_a_listino

luo_listino.uf_aggiungi_prezzo_a_listino(tab_1.tabpage_1.dw_articolo_gen_ff)
destroy luo_listino



end subroutine

public subroutine wf_nuovo (integer ai_flag, window aw_articolo);long ll_riga

if ai_flag=1 then

	tab_1.tabpage_1.dw_articolo_gen_ff.sharedataoff()
	tab_1.tabpage_1.dw_articolo_gen_ff.event ue_reset()
	idw_master.is_list.s_modo= modo_inserisci
	aw_articolo.TriggerEvent("ue_insert_mode")
	

	
	tab_1.tabpage_1.dw_articolo_gen_ff.POSTEVENT("ue_prepare_codice")
	 
end if


	tab_1.tabpage_1.dw_articolo_gen_ff.setfocus()
	tab_1.tabpage_1.dw_articolo_gen_ff.setcolumn("id_cat_codifica")


wf_propone_unita_confezione()


uf_mostra_immagine("")


DataWindowChild dw_drop_codifica
long ll_id_cat_codifica
integer rtncode

rtncode = tab_1.tabpage_1.dw_articolo_gen_ff.GetChild('id_cat_codifica', dw_drop_codifica)
IF rtncode = -1 THEN MessageBox("Error", "Not a DataWindowChild")

CONNECT USING SQLCA;	

dw_drop_codifica.SetTransObject(SQLCA)

dw_drop_codifica.Retrieve()
if dw_drop_codifica.rowcount()=1 then
	ll_id_cat_codifica=dw_drop_codifica.getitemnumber(1, "id_cat_codifica")
 	tab_1.tabpage_1.dw_articolo_gen_ff.setitem(1,"id_cat_codifica", ll_id_cat_codifica)
	 ib_codice_modificato=FALSE
	tab_1.tabpage_1.dw_articolo_gen_ff.TriggerEvent("ue_prepare_codice")
end if


long ll_id

select id_cat_com_articolo
into :ll_id
from cat_com_articolo;
if ll_id>0 and not isnull(ll_id)and sqlca.sqlcode=0 then
	tab_1.tabpage_1.dw_articolo_gen_ff.setitem(1, "id_cat_com_articolo_cod", ll_id)
end if

select id_cat_codifica
into :ll_id
from cat_codifica;
if ll_id>0 and not isnull(ll_id)and sqlca.sqlcode=0 then
	tab_1.tabpage_1.dw_articolo_gen_ff.SetItem(1,"id_cat_codifica",ll_id)
	tab_1.tabpage_1.dw_articolo_gen_ff.SetItem(1,"id_cat_codifica_des",ll_id)	
end if


ll_riga=tab_1.tabpage_1.dw_articolo_gen_ff.Getrow()
tab_1.tabpage_1.dw_articolo_gen_ff.SetItem(ll_riga,"id_cat_codifica",il_id_cat_cod)
tab_1.tabpage_1.dw_articolo_gen_ff.SetItem(ll_riga,"prezzo",id_prezzo)
tab_1.tabpage_1.dw_articolo_gen_ff.SetItem(ll_riga,"id_cat_com_articolo",il_id_cat_com_art)
tab_1.tabpage_1.dw_articolo_gen_ff.SetItem(ll_riga,"id_gruppo_articoli_des",il_id_gruppo_art)
tab_1.tabpage_1.dw_articolo_gen_ff.SetItem(ll_riga,"descrizione",is_descrizione)
tab_1.tabpage_1.dw_articolo_gen_ff.SetItem(ll_riga,"prod_interna",is_prod_interna)
tab_1.tabpage_1.dw_articolo_gen_ff.SetItem(ll_riga,"prezzo_for",id_prezzo_for)
tab_1.tabpage_1.dw_articolo_gen_ff.SetItem(ll_riga,"c_sog_commerciale_codice",is_c_sog_commerciale)
tab_1.tabpage_1.dw_articolo_gen_ff.SetItem(ll_riga,"c_anagrafica_b_rag_soc_1",is_c_anagrafica)
tab_1.tabpage_1.dw_articolo_gen_ff.SetItem(ll_riga,"id_sog_commerciale",il_id_sog_commerciale)






end subroutine

public subroutine uf_agg_cod_barre (integer al_row, datawindow adw_art);long ll_id_articolo, ll_id_tipo_cod_barre, ll_id_unita_confezione, ll_app
string ls_cod_barre, ls_gen_automatica

ll_id_articolo = adw_art.Object.id_articolo[al_row]
ll_id_tipo_cod_barre = adw_art.object.id_tipo_cod_barre[al_row]

ls_cod_barre = trim(adw_art.object.cod_barre[al_row])

ls_gen_automatica = adw_art.object.gen_automatica[al_row]


if not isnull(ls_cod_barre) and ls_cod_barre>'' then
	
	SELECT id_unita_confezione
	INTO	 :ll_id_unita_confezione
	FROM	 unita_confezione
	WHERE	 id_articolo = :ll_id_articolo
	AND	 unita_base = 'S'
	;
	
	choose case SQLCA.SQLCODE 
		case -1 
			messagebox("Anagrafica articolo", SQLCA.SQLERRTEXT)
		case 0
			select 1 
			into	 :ll_app
			from 	 cod_barre 
			where	 codice = :ls_cod_barre
			;
			
			if isnull(ls_gen_automatica) or ls_gen_automatica='' then ls_gen_automatica='N'
			if sqlca.sqlcode = 100 then
				INSERT INTO cod_barre (id_tipo_cod_barre, id_unita_confezione, codice, gen_automatica, id_azienda)
				VALUES (:ll_id_tipo_cod_barre, :ll_id_unita_confezione, :ls_cod_barre, :ls_gen_automatica, 1)
				;
					
				if SQLCA.SQLCODE = -1 then
					messagebox("Anagrafica articolo", SQLCA.SQLERRTEXT)
				end if
					
				COMMIT;
					
				if SQLCA.SQLCODE = -1 then
					messagebox("Anagrafica articolo", SQLCA.SQLERRTEXT)
				end if		
			end if
	end choose
end if
end subroutine

public subroutine wf_controlla_check (datawindow adw_articolo);//mm 6-4-09: disattivo perché dannoso: esiste la possibilità di dover stampare
//la scheda produzione anche per articoli fatti fuori
//long li_ret
//	li_ret=adw_articolo.AcceptText ( )
//	
//if (adw_articolo.getitemString(1,"prod_interna")="S") and &
//	(not(IsNull(adw_articolo.getitemString(1,"c_sog_commerciale_codice"))) or (adw_articolo.getitemString(1,"c_sog_commerciale_codice")<>"") or &
//	not(IsNull(adw_articolo.getitemString(1,"c_anagrafica_b_rag_soc_1"))) or (adw_articolo.getitemString(1,"c_anagrafica_b_rag_soc_1")<>"") or &
//	not(IsNull(adw_articolo.getitemNumber(1,"prezzo_for")))) then
//	integer net
//	Net = MessageBox("Attenzione", "E' specificato un fornitore. ~nSi vuole cancellare questo campo?", Exclamation!, OKCancel!, 2)
//	IF Net = 1 THEN
//	 
//	 string dummy
//	 long dommy
//	 setnull(dommy)
//	 setNull(dummy)
//	 net=adw_articolo.setItem(1,"id_sog_commerciale",dommy)
//	 
//	 adw_articolo.setItem(1,"c_sog_commerciale_codice",dummy)
//	 adw_articolo.setItem(1,"c_anagrafica_b_rag_soc_1",dummy)
//	 setNull(net)
//	 adw_articolo.setItem(1,"prezzo_for",net)
//	 	if POS(UPPER(U_FREDDIE.ISTR_DATABASE.NAME),'ORAFO') >0 then
//			
//			adw_articolo.setItem(1,"coeff_calo",net)
//		end if
//	ELSE
//	 
//	 adw_articolo.setItem(1,"prod_interna","N")
//	END IF
//		
//
//end if
end subroutine

public function integer wf_controlla_esistente (integer ai_codice);long ll_trovato
integer i
string ls_campo, ls_codice1,ls_codice
dwItemStatus st_riga
st_riga= tab_1.tabpage_1.dw_articolo_gen_ff.getitemstatus(1, 0, primary!)
if st_riga=newmodified! or st_riga=new! then

	for i=1 to ai_codice
		ls_campo="c_codice_"+string(i)
	
		ls_codice1=tab_1.tabpage_1.dw_articolo_gen_ff.getitemstring(1, ls_campo)
		if ls_codice1='' or isnull(ls_codice1) then
			exit
		else
			ls_codice=ls_codice+ls_codice1
		end if
	next
	//
	if ls_codice>"" then 
		//ls_codice=tab_1.tabpage_1.dw_articolo_gen_ff.getitemstring(1, "codice")
		//ls_codice=tab_1.tabpage_1.dw_articolo_gen_ff.object.data[1,3]
		select id_articolo 
		into :ll_trovato
		from articolo
		where codice=:ls_codice;
		
		if ll_trovato>0 then
			messagebox("Attenzione!", "Articolo già esistente: inserire un codice diverso!")
			//tab_1.tabpage_1.dw_articolo_gen_ff.setcolumn("c_codice_1")
			return 0
		end if
		return 1
	else
		return 0
	end if
else
	return 0
end if
end function

public subroutine wf_setta_campi_nuovo_record ();
integer li_retvalue, ll_riga


if idw_master.uf_to_update() > 0 then	
	
	li_retvalue=idw_master.Event ue_update(0,0)
else
	li_retvalue=0
end if

ll_riga=tab_1.tabpage_1.dw_articolo_gen_ff.Getrow()
il_id_cat_cod = tab_1.tabpage_1.dw_articolo_gen_ff.GetItemNumber(ll_riga,"id_cat_codifica")
id_prezzo = tab_1.tabpage_1.dw_articolo_gen_ff.GetItemDecimal(ll_riga,"prezzo")
il_id_cat_com_art = tab_1.tabpage_1.dw_articolo_gen_ff.GetItemNumber(ll_riga,"id_cat_com_articolo")
il_id_gruppo_art = tab_1.tabpage_1.dw_articolo_gen_ff.GetItemNumber(ll_riga,"id_gruppo_articoli_des")
is_descrizione = tab_1.tabpage_1.dw_articolo_gen_ff.GetItemString(ll_riga,"descrizione")
is_prod_interna= tab_1.tabpage_1.dw_articolo_gen_ff.GetItemString(ll_riga,"prod_interna")
id_prezzo_for= tab_1.tabpage_1.dw_articolo_gen_ff.GetItemDecimal(ll_riga,"prezzo_for")
is_c_sog_commerciale= tab_1.tabpage_1.dw_articolo_gen_ff.GetItemstring(ll_riga,"c_sog_commerciale_codice")
is_c_anagrafica= tab_1.tabpage_1.dw_articolo_gen_ff.GetItemstring(ll_riga,"c_anagrafica_b_rag_soc_1")
il_id_sog_commerciale= tab_1.tabpage_1.dw_articolo_gen_ff.GetItemnumber(ll_riga,"id_sog_commerciale") 

if li_retvalue<=0 then 
	post wf_nuovo(1, THIS)
else
	post wf_nuovo(0, THIS)
end if

tab_1.SelectTab(tab_1.tabpage_1)
end subroutine

public subroutine wf_ultimo_costo ();
long		ll_id_unita_confezione, ll_id_fornitore
string	ls_dati_fornitore
decimal	ld_ultimo_costo

ll_id_unita_confezione = tab_1.tabpage_6.dw_approvvigionamento_gd.getitemnumber(tab_1.tabpage_6.dw_approvvigionamento_gd.getrow(), "approvvigionamento_id_unita_confezione")
ll_id_fornitore  		  = tab_1.tabpage_6.dw_approvvigionamento_gd.getitemnumber(tab_1.tabpage_6.dw_approvvigionamento_gd.getrow(), "approvvigionamento_id_sog_commerciale")

if (ll_id_unita_confezione > 0 and ll_id_fornitore > 0) then
	SELECT CAST( fn_ultimo_costo_fornitore(1, :ll_id_unita_confezione, :ll_id_fornitore, id_valuta) AS CHAR(32) ) AS dati_ultimo_costo_fornitore,   
			 CAST ( SUBSTRING(dati_ultimo_costo_fornitore,1 , 22)  AS dm_imp_6_dec ) AS ultimo_costo_fornitore
	INTO	 :ls_dati_fornitore, :ld_ultimo_costo
	FROM   par_sistema
	;
	
	if (sqlca.sqlcode = 0) then
		tab_1.tabpage_6.dw_approvvigionamento_gd.setitem(tab_1.tabpage_6.dw_approvvigionamento_gd.getrow(), "ultimo_costo_fornitore", ld_ultimo_costo)
	end if
end if
end subroutine

public subroutine uf_setta_format (long il_valuta);string ls_format, LS_EDIT

LS_FORMAT = F_VALU_MASK(il_valuta)
LS_EDIT = F_VALU_EDIT(il_valuta)
tab_1.tabpage_4.dw_articolo_altro_ff.MODIFY("costo_aggiuntivo.EDIT.FORMAT ='"+ ls_edit+"'")
tab_1.tabpage_4.dw_articolo_altro_ff.MODIFY("costo_aggiuntivo.FORMAT ='"+ ls_format+"'")

end subroutine

public subroutine uf_setta_format_lisven (long il_valuta);string ls_format, LS_EDIT

LS_EDIT = F_VALU_EDIT(il_valuta)
tab_1.tabpage_1.dw_articolo_gen_ff.MODIFY("prezzo.EDIT.FORMAT ='"+ ls_edit+"'")
tab_1.tabpage_1.dw_articolo_gen_ff.MODIFY("prezzo.FORMAT ='"+ ls_edit+"'")

end subroutine

public subroutine uf_setta_format_lisacq (long il_valuta);string ls_format, LS_EDIT

LS_EDIT = F_VALU_EDIT(il_valuta)
tab_1.tabpage_1.dw_articolo_gen_ff.MODIFY("prezzo_for.EDIT.FORMAT ='"+ ls_edit+"'")
tab_1.tabpage_1.dw_articolo_gen_ff.MODIFY("prezzo_for.FORMAT ='"+ ls_edit+"'")

end subroutine

public subroutine uf_setta_format_lisgen (long il_valuta);
end subroutine

event open;call super::open;il_HelpTopic = 45
idw_master = tab_1.tabpage_1.dw_articolo_gen_ff
idw_master.is_list = Message.PowerObjectParm
If Upperbound(idw_master.is_list.s_identifica) = 0 then
	idw_master.is_list.s_modo= modo_inserisci
end if
idc_w_color= Dec(tab_1.tabpage_1.dw_articolo_gen_ff.describe("c_codice_1.background.color"))
idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_sql_ident[1] = "articolo.id_articolo"

ib_nonmodale = TRUE

string ls_ges_locazione
select ges_locazioni
into :ls_ges_locazione
from par_sistema;
if ls_ges_locazione<>'S'OR ISNULL(ls_ges_locazione) then
	cb_locazione.visible=false
end if
il_old_variante = 1
il_old_cat_codifica = -1

string ls_rch

select rch
into :ls_rch
from pers_par_sistema;

if ls_rch = 'S' then tab_1.tabpage_1.cb_2.visible = true
end event

on w_articolo_cx.create
int iCurrent
call super::create
this.cb_locazione=create cb_locazione
this.cb_1=create cb_1
this.cb_varianti=create cb_varianti
this.cb_duplica=create cb_duplica
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_locazione
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_varianti
this.Control[iCurrent+4]=this.cb_duplica
end on

on w_articolo_cx.destroy
call super::destroy
destroy(this.cb_locazione)
destroy(this.cb_1)
destroy(this.cb_varianti)
destroy(this.cb_duplica)
end on

event ue_post_open;call super::ue_post_open;tab_1.tabpage_1.dw_articolo_gen_ff.TriggerEvent("ue_prepare_codice")

DataWindowChild dw_drop_codifica
long ll_id_cat_codifica
integer rtncode

rtncode = tab_1.tabpage_1.dw_articolo_gen_ff.GetChild('id_cat_codifica', dw_drop_codifica)
IF rtncode = -1 THEN MessageBox("Error", "Not a DataWindowChild")

CONNECT USING SQLCA;	

dw_drop_codifica.SetTransObject(SQLCA)

dw_drop_codifica.Retrieve()
if dw_drop_codifica.rowcount()=1 then
	ll_id_cat_codifica=dw_drop_codifica.getitemnumber(1, "id_cat_codifica")
 	tab_1.tabpage_1.dw_articolo_gen_ff.setitem(1,"id_cat_codifica", ll_id_cat_codifica)
	 ib_codice_modificato=FALSE
	tab_1.tabpage_1.dw_articolo_gen_ff.TriggerEvent("ue_prepare_codice")
end if


wf_propone_unita_confezione()




long ll_id

select id_cat_com_articolo
into :ll_id
from cat_com_articolo;
if ll_id>0 and not isnull(ll_id)and sqlca.sqlcode=0 then
	tab_1.tabpage_1.dw_articolo_gen_ff.setitem(1, "id_cat_com_articolo_cod", ll_id)
end if

select id_cat_codifica
into :ll_id
from cat_codifica;
if ll_id>0 and not isnull(ll_id)and sqlca.sqlcode=0 then
	tab_1.tabpage_1.dw_articolo_gen_ff.SetItem(1,"id_cat_codifica",ll_id)
	tab_1.tabpage_1.dw_articolo_gen_ff.SetItem(1,"id_cat_codifica_des",ll_id)	
end if


select id_valuta
into :il_id_val_ven
from listino
where tipo = 'V' 
and lis_base = 'S';

select id_valuta
into :il_id_val_acq
from listino
where tipo = 'A' 
and lis_base = 'S';

select id_valuta
into :il_id_val_def
from par_sistema;

tab_1.tabpage_4.dw_articolo_altro_ff.setitem(1,"id_valuta",il_id_val_def)

if not isnull(il_id_val_ven) then UF_SETTA_FORMAT_lisven(il_id_val_ven)
if not isnull(il_id_val_acq) then UF_SETTA_FORMAT_lisacq(il_id_val_acq)
if not isnull(il_id_val_def) then UF_SETTA_FORMAT(il_id_val_def)
if not isnull(il_id_val_def) then UF_SETTA_FORMAT_lisgen(il_id_val_def) 
end event

event ue_master_delete;call super::ue_master_delete;
if (idw_master.Event ue_delete(0, 0) = 0) then
	ib_AskForSave = false

	IF (idw_master.Event ue_update(0, 0) = 0) then
		ib_AskForSave = true
		idw_master.is_list.s_modo = modo_inserisci
		idw_master.Event ue_insert(0, 0)
	else		
		idw_master.Event ue_retrieve(0, 0)
	end if
	idw_master.SetItemStatus(idw_master.GetRow(), 0, Primary!, NotModified!)
end if
idw_master.SetFocus()

end event

type p_msg_log from w_p_data`p_msg_log within w_articolo_cx
boolean visible = true
integer x = 1431
integer y = 32
integer height = 80
end type

type p_crescente from w_p_data`p_crescente within w_articolo_cx
end type

type p_decrescente from w_p_data`p_decrescente within w_articolo_cx
end type

type cb_ok from w_p_data`cb_ok within w_articolo_cx
integer x = 27
integer y = 32
integer width = 229
end type

type cb_annulla from w_p_data`cb_annulla within w_articolo_cx
integer x = 274
integer y = 32
integer width = 229
end type

type cb_nuovo from w_p_data`cb_nuovo within w_articolo_cx
integer x = 526
integer y = 32
integer width = 229
end type

event cb_nuovo::clicked;

WF_SETTA_CAMPI_NUOVO_RECORD()




end event

type cb_inserisci from w_p_data`cb_inserisci within w_articolo_cx
integer x = 1810
integer y = 32
integer width = 229
end type

type cb_cancella from w_p_data`cb_cancella within w_articolo_cx
integer x = 2062
integer y = 32
integer width = 229
end type

type cb_salva from w_p_data`cb_salva within w_articolo_cx
integer x = 2560
integer y = 32
integer width = 229
end type

event cb_salva::clicked;call super::clicked;//long ll_id_articolo, ll_id_unita_conf, ll_ret
//string ls_codice1, ls_codice2
//
//datastore ds_cancella
//ds_cancella=create datastore
//
//
////ll_id_articolo=tab_1.tabpage_2.dw_articolo_gen2_ff.getitemnumber(1,'id_articolo')
////ls_codice2=tab_1.tabpage_2.dw_articolo_gen2_ff.getitemstring(1,'cod_barre')
//
//ll_id_articolo=tab_1.tabpage_1.dw_articolo_gen_ff.getitemnumber(1,'id_articolo')
//ls_codice2=tab_1.tabpage_1.dw_articolo_gen_ff.getitemstring(1,'cod_barre')
//
//select id_unita_confezione
//into :ll_id_unita_conf
//from unita_confezione
//where id_articolo=:ll_id_articolo;
//
//select codice
//into :ls_codice1
//from cod_barre
//where id_unita_confezione=:ll_id_unita_conf;
//
//
//if isnull(ls_codice1) or ls_codice1='' or ls_codice1=ls_codice2 or isnull(ls_codice2) then
//	
//		if isnull(ls_codice2) then tab_1.tabpage_2.dw_articolo_gen2_ff.SetItem(1, "gen_automatica", "N")
//	
//	parent.TriggerEvent("ue_update")
//else
//	ll_ret=messagebox('Attenzione', "Per l'articolo selezionato è già stato generato un codice a barre,"+& 
//	            "~r~nvuoi sostituislo con il nuovo inserito?", Question!, YesNo!, 2)
//   if ll_ret= 2 then 
//	   tab_1.tabpage_2.dw_articolo_gen2_ff.setitem(1,'cod_barre', ls_codice1)
//	   return 1
//	else	
//	   
//		
//		
//		
//      ds_cancella.dataobject='d_cancella_cod_barre_gd'
//      ds_cancella.reset()
//      ds_cancella.settransobject(sqlca)
//		ds_cancella.retrieve(ll_id_unita_conf)
//		ll_ret=ds_cancella.rowcount()
//		if ll_ret>0 then
//		 DO WHILE ll_ret>0
//	      ds_cancella.deleterow(ll_ret)
//	      ll_ret=ll_ret - 1
//       LOOP
//		   ds_cancella.update()
//	   end if
//		
//	   parent.TriggerEvent("ue_update")
//	end if
//end if	
end event

type tab_1 from w_p_data`tab_1 within w_articolo_cx
integer x = 18
integer y = 148
integer width = 2775
integer height = 1568
integer taborder = 40
long backcolor = 79741120
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
tabpage_6 tabpage_6
tabpage_list_generici tabpage_list_generici
end type

on tab_1.create
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.tabpage_5=create tabpage_5
this.tabpage_6=create tabpage_6
this.tabpage_list_generici=create tabpage_list_generici
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_2
this.Control[iCurrent+2]=this.tabpage_3
this.Control[iCurrent+3]=this.tabpage_4
this.Control[iCurrent+4]=this.tabpage_5
this.Control[iCurrent+5]=this.tabpage_6
this.Control[iCurrent+6]=this.tabpage_list_generici
end on

on tab_1.destroy
call super::destroy
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
destroy(this.tabpage_5)
destroy(this.tabpage_6)
destroy(this.tabpage_list_generici)
end on

event tab_1::selectionchanging;call super::selectionchanging;



end event

event tab_1::selectionchanged;call super::selectionchanged;

end event

type tabpage_1 from w_p_data`tabpage_1 within tab_1
integer width = 2738
integer height = 1448
long backcolor = 79741120
string text = "Generale"
long tabbackcolor = 79741120
cb_codice cb_codice
st_information st_information
dw_unita_confezione2_lt dw_unita_confezione2_lt
cb_ingrandisci_immagine cb_ingrandisci_immagine
cb_2 cb_2
ole_imm ole_imm
dw_articolo_gen_ff dw_articolo_gen_ff
end type

on tabpage_1.create
this.cb_codice=create cb_codice
this.st_information=create st_information
this.dw_unita_confezione2_lt=create dw_unita_confezione2_lt
this.cb_ingrandisci_immagine=create cb_ingrandisci_immagine
this.cb_2=create cb_2
this.ole_imm=create ole_imm
this.dw_articolo_gen_ff=create dw_articolo_gen_ff
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_codice
this.Control[iCurrent+2]=this.st_information
this.Control[iCurrent+3]=this.dw_unita_confezione2_lt
this.Control[iCurrent+4]=this.cb_ingrandisci_immagine
this.Control[iCurrent+5]=this.cb_2
this.Control[iCurrent+6]=this.ole_imm
this.Control[iCurrent+7]=this.dw_articolo_gen_ff
end on

on tabpage_1.destroy
call super::destroy
destroy(this.cb_codice)
destroy(this.st_information)
destroy(this.dw_unita_confezione2_lt)
destroy(this.cb_ingrandisci_immagine)
destroy(this.cb_2)
destroy(this.ole_imm)
destroy(this.dw_articolo_gen_ff)
end on

type cb_ricerca from w_p_data`cb_ricerca within w_articolo_cx
integer x = 1541
integer y = 32
integer width = 247
integer taborder = 10
end type

event cb_ricerca::clicked;call super::clicked;
uf_ricerca()

long ll_riga_corrente
string ls_immagine
ll_riga_corrente=tab_1.tabpage_1.dw_articolo_gen_ff.getrow()
ls_immagine=tab_1.tabpage_1.dw_articolo_gen_ff.getitemstring(ll_riga_corrente, "immagine")
if ls_immagine<>"" and not isnull(ls_immagine) then
	uf_mostra_immagine(ls_immagine)
end if

end event

type cb_codice from commandbutton within tabpage_1
integer x = 96
integer y = 148
integer width = 233
integer height = 84
integer taborder = 32
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Codice ..."
end type

event clicked;
s_any_array	lstr_array
long 		ll_counter, ll_size, ll_row
string 	ls_codice
u_dw_master_main	ldw_gen


ldw_gen= tab_1.tabpage_1.dw_articolo_gen_ff
ll_row= ldw_gen.GetRow()
if ll_row> 0 then
	ls_codice= ""
	
	lstr_array.s_array[1]=tab_1.tabpage_1.dw_articolo_gen_ff.GetItemNumber(ll_row,"id_cat_codifica")
	
	ll_size= UpperBound(istr_cod_tot)
	for ll_counter = 1 to ll_size
		lstr_array.s_array[ll_counter + 1]= ldw_gen.GetItemString(ll_row, "c_codice_" + String(ll_counter))
	next
	OpenWithParm(w_cod_articolo_wz, lstr_array)
	lstr_array= Message.PowerObjectParm
	tab_1.tabpage_1.dw_articolo_gen_ff.SetItem(ll_row,"id_cat_codifica", lstr_array.s_array[1])
	tab_1.tabpage_1.dw_articolo_gen_ff.TriggerEvent("ue_prepare_codice")
	
	ll_size= UpperBound(istr_cod_tot)
	for ll_counter = 1 to ll_size
		ldw_gen.SetItem(ll_row, "c_codice_" + String(ll_counter), lstr_array.s_array[ll_counter + 1])
	next
	tab_1.tabpage_1.dw_articolo_gen_ff.setfocus()
	tab_1.tabpage_1.dw_articolo_gen_ff.setcolumn("descrizione")
	il_old_variante = 1
end if

end event

type st_information from statictext within tabpage_1
boolean visible = false
integer x = 1509
integer y = 156
integer width = 229
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
boolean enabled = false
string text = "none"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type dw_unita_confezione2_lt from u_dw_master_main within tabpage_1
integer x = 14
integer y = 1004
integer width = 2665
integer height = 432
integer taborder = 3
string dataobject = "d_unita_confezione_lt"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event ue_init;call super::ue_init;is_title 					= "Unità Confezioni"
is_list.s_identifica[1] = "id_articolo"
is_resp_window = "w_unita_confezione_ff"
is_list.s_win_chiave[1] = "id_unita_confezione"
is_list.s_par_name[1] = "id_articolo"

end event

event ue_key;call super::ue_key;if (key= KeyF3!)  then
	cb_nuovo.triggerevent(clicked!)
end if
end event

type cb_ingrandisci_immagine from commandbutton within tabpage_1
boolean visible = false
integer x = 2098
integer y = 500
integer width = 544
integer height = 68
integer taborder = 33
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Ingrandisci Immagine"
end type

event clicked;ole_imm.object.GUIXpos = 100
ole_imm.object.GUIXpos = 100
ole_imm.object.GUIWidth = 1000
ole_imm.object.GUIHeight = 1000
ole_imm.object.MagnifyWindow = 2
end event

type cb_2 from commandbutton within tabpage_1
boolean visible = false
integer x = 2505
integer y = 884
integer width = 142
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "RCH"
end type

event clicked;long ll_id_articolo, ll_row

ll_row = tab_1.tabpage_1.dw_articolo_gen_ff.getrow()
ll_id_articolo = tab_1.tabpage_1.dw_articolo_gen_ff.getitemnumber(ll_row,"id_articolo")

//if not isnull(ll_id_articolo) then openwithparm(w_rch_scn_mag_art_cx,ll_id_articolo)
	
end event

type ole_imm from olecustomcontrol within tabpage_1
event paintevent ( )
event selectevent ( long lplleft,  long lpltop,  long lplright,  long lplbottom )
event statusevent ( long lppercent )
event click ( )
event dblclick ( )
event keydown ( integer keycode,  integer shift )
event keypress ( integer keyascii )
event keyup ( integer keycode,  integer shift )
event mousedown ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mousemove ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mouseup ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event scroll ( long scrolltype )
event errorevent ( integer nerrcount )
event thumbnail ( string filename,  long page )
event tag ( integer tagid,  integer tagtype,  long tagsize,  integer wordval,  long longval,  string strval )
event thumbtitle ( string title,  integer page )
boolean visible = false
integer x = 2139
integer y = 12
integer width = 562
integer height = 448
integer taborder = 20
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_articolo_cx.win"
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
end type

type dw_articolo_gen_ff from u_dw_master_main within tabpage_1
event ue_load_codice ( )
event ue_prepare_codice ( )
event type string ue_prepare_parte ( s_cod_parte astr_cod_parte,  integer ai_nr_parte,  string as_cod_rimanente,  boolean ab_ultimo )
event type integer ue_set_codice ( )
event type string ue_val_cod_parte ( integer al_nr_codice,  ref string as_err_message,  ref long al_err_code )
event ue_set_parte_progr ( )
event ue_reset ( )
event ue_setta_fuoco ( )
event ue_cod_cambiato ( )
integer x = 14
integer y = 0
integer width = 2720
integer height = 992
integer taborder = 1
string dataobject = "d_articolo_gen_ff"
end type

event ue_load_codice;call super::ue_load_codice;

end event

event ue_prepare_codice;call super::ue_prepare_codice;
long 				ll_id_cat_codifica, ll_row, ll_counter,ll_count, ll_parte_row, ll_size, ll_id_cod_parte
s_cod_parte 	lstr_cod_parte, lstr_cod_parte_dummy, lstr_cod_tot_dummy[]
string			ls_cod_rimanente, ls_scelta
boolean 			lb_ultimo

ll_row= GetRow()
ll_id_cat_codifica=GetItemNumber(ll_row, "id_cat_codifica")
 DECLARE lcur_cod_parte CURSOR FOR  
  SELECT "cod_parte"."id_cod_parte",   
         "parte_regola"."descrizione",   
         "parte_regola"."lunghezza",   
         "parte_regola"."progressivo",   
         "parte_regola"."variante",   
         "parte_regola"."num_sezione",   
         "cod_parte"."mas_input",   
         "cod_parte"."tipo_richiesta",   
         "cod_parte"."val_proposto",   
         "cod_parte"."car_riempimento",   
         "cod_parte"."solo_in_elenco"  
    FROM "dba"."cod_parte",   
         "dba"."parte_regola"  
   WHERE ( "parte_regola"."id_parte_regola" = "cod_parte"."id_parte_regola" ) and  
         ( ( "cod_parte"."id_cat_codifica" = :ll_id_cat_codifica ) )   
ORDER BY "parte_regola"."num_sezione" ASC  ;
OPEN lcur_cod_parte;
ls_cod_rimanente= GetItemString(ll_row,"codice")
istr_cod_tot=lstr_cod_tot_dummy
ll_counter=0
ib_esiste_progr=FALSE
do while (sqlca.sqlcode = 0) AND (ll_counter < 10)
	FETCH lcur_cod_parte into 	:lstr_cod_parte.l_id_cod_parte,&
										:lstr_cod_parte.s_descrizione,&
										:lstr_cod_parte.l_lunghezza,&
										:lstr_cod_parte.s_progressivo,&
										:lstr_cod_parte.s_variante,&
										:lstr_cod_parte.l_num_sezione,&
										:lstr_cod_parte.s_mas_input,&
										:lstr_cod_parte.s_tipo_richiesta,&
										:lstr_cod_parte.s_val_proposto,&
										:lstr_cod_parte.s_car_riempimento,&
										:lstr_cod_parte.s_solo_in_elenco;
	If (sqlca.sqlcode = 0) AND (ll_counter < 10) then 
		ll_counter++
		istr_cod_tot[ll_counter]=lstr_cod_parte
		if lstr_cod_parte.s_variante = 'S' then
			ll_id_cod_parte = lstr_cod_parte.l_id_cod_parte
		end if
	end if
loop 
if sqlca.sqlcode < 0 then
	MessageBox ("DataBase Error", sqlca.sqlerrtext, exclamation!)
end if
CLOSE lcur_cod_parte;

ls_scelta = "PRIMO"

if il_old_variante > 0 then
	DECLARE lcur_scelta_parte CURSOR FOR
	SELECT "scelta_parte"."scelta"
	FROM	"scelta_parte"
	WHERE "scelta_parte"."id_cod_parte" = :ll_id_cod_parte;
	OPEN lcur_scelta_parte;
	ll_counter = 0
	do while (sqlca.sqlcode = 0) and (ll_counter <= il_old_variante)
		FETCH lcur_scelta_parte into :ls_scelta;
		ll_counter++
	loop
	if sqlca.sqlcode = 0 then
		for ll_counter = 1 to UpperBound(istr_cod_tot)
			if istr_cod_tot[ll_counter].s_variante = 'S' then 
				istr_cod_tot[ll_counter].s_val_proposto = ls_scelta
				il_old_variante++
			end if
		next
	else
		 if il_old_cat_codifica = ll_id_cat_codifica then il_old_variante = 1
	end if
	CLOSE lcur_scelta_parte;
else
	il_old_variante = 1
end if

ll_size= UpperBound(istr_cod_tot)
For ll_counter= 1 to ll_size
	If ll_counter= ll_size then 
		lb_ultimo= TRUE
	ELSE
		lb_ultimo= FALSE
	END IF
	ls_cod_rimanente=event ue_prepare_parte(istr_cod_tot[ll_counter],ll_counter,ls_cod_rimanente, lb_ultimo)
next

SetRedraw(FALSE)
FOR ll_count = ll_size +1 to 9
	ls_cod_rimanente=event ue_prepare_parte(lstr_cod_parte_dummy,ll_count,"",FALSE)
next
SetRedraw(TRUE)
If ib_esiste_progr AND (GetItemStatus(ll_row, 0, Primary!)=New! OR GetItemStatus(ll_row, 0, Primary!)=NewModified! ) then
	TriggerEvent("ue_set_parte_progr")
end if

end event

event type string ue_prepare_parte(s_cod_parte astr_cod_parte, integer ai_nr_parte, string as_cod_rimanente, boolean ab_ultimo);
long 		ll_row, ll_lunghezza, ll_x, ll_width
integer	li_size, li_posizione
char		lch_mask[], lch_mas_input[]
string	ls_codice, ls_campo, ls_ret_codice
long		ll_progressivo,ll_variante

ll_progressivo = 11327420 
ll_variante    = 15196873
ll_row= GetRow()
if NOT(IsNull(astr_cod_parte.l_lunghezza) OR astr_cod_parte.l_lunghezza =0) AND &
	 NOT(IsNull(ll_row) OR ll_row =0)then
	ll_lunghezza= astr_cod_parte.l_lunghezza
	Modify("c_codice_" + String(ai_nr_parte) + ".background.color=" + String(idc_w_color))
	if istr_cod_tot[ai_nr_parte].S_progressivo = "S" then
		
		Modify("c_codice_" + String(ai_nr_parte) + ".background.color=" + String(ll_progressivo))
		
	end if
	if istr_cod_tot[ai_nr_parte].S_variante = "S" then
		Modify("c_codice_" + String(ai_nr_parte) + ".background.color=" + String(ll_variante))
	end if
	Modify("c_codice_" + String(ai_nr_parte) + ".visible=1")
	Modify("c_codice_" + String(ai_nr_parte) + ".protect=0")
	Modify("c_codice_" + String(ai_nr_parte) + ".width=" + String(ll_lunghezza * 41/2) ) //20210604 corretto per codice articolo=64char
	if ai_nr_parte > 1 then
		ll_x= Long(Describe("c_codice_" + String(ai_nr_parte - 1) + ".x"))
		ll_width=Long(Describe("c_codice_" + String(ai_nr_parte - 1) + ".width"))
		Modify("c_codice_" + String(ai_nr_parte) + ".x=" + String(ll_x + ll_width + 20) )
	end if
	
	lch_mas_input= astr_cod_parte.s_mas_input
	li_size = UpperBound(lch_mas_input)
	for  li_posizione= 1 to li_size
		CHOOSE CASE lch_mas_input[li_posizione]
			CASE "A"
				lch_mask[li_posizione] = "!"
			CASE "N"

				lch_mask[li_posizione] = "#"
			CASE "M"
				lch_mask[li_posizione] = "a"
			CASE "X"
				lch_mask[li_posizione] = "X"
			CASE ELSE
				
		END CHOOSE
	next
	
	If astr_cod_parte.s_progressivo="S" then 
		If ib_esiste_progr then
			MessageBox("Calcolo del Codice","Esiste più di una parte progressiva:~n sarà "+ &
				 "calcolata automaticamente solo la prima.")
		else
			ib_esiste_progr=TRUE
		end if
	end if
	
	if lch_mask <> "" then 
		Modify("c_codice_" + String(ai_nr_parte) + ".editmask.mask='" + lch_mask + "'") 
	end if
	
	if not(astr_cod_parte.s_val_proposto ="" OR IsNull(astr_cod_parte.s_val_proposto)) then
		ls_codice=astr_cod_parte.s_val_proposto
	end if
	
	If not(IsNull(as_cod_rimanente) OR as_cod_rimanente="") then
		ls_codice= Mid(as_cod_rimanente, 1,ll_lunghezza)
		ls_ret_codice= Mid(as_cod_rimanente, ll_lunghezza+1)
	end if
	
	if Len(ls_codice) < ll_lunghezza  AND not ab_ultimo then
		if not(astr_cod_parte.s_car_riempimento ="" OR IsNull(astr_cod_parte.s_car_riempimento)) then
			ls_codice=f_rpad(ls_codice,astr_cod_parte.s_car_riempimento, ll_lunghezza)
		else
			ls_codice=f_rpad(ls_codice,"0", ll_lunghezza)
		end if
	end if
	SetItem(ll_row, "c_codice_" + String(ai_nr_parte), ls_codice)
else
	
	Modify("c_codice_" + String(ai_nr_parte) + ".visible=0") 
	Modify("c_codice_" + String(ai_nr_parte) + ".protect=1") 
end if
long ll_id_cat_codifica
ll_id_cat_codifica=tab_1.tabpage_1.dw_articolo_gen_ff.getitemnumber(1,"id_cat_codifica")
if ll_id_cat_codifica>0 and not isnull(ll_id_cat_codifica) then
	tab_1.tabpage_1.dw_articolo_gen_ff.event post ue_setta_fuoco()
end if
 
return ls_ret_codice
end event

event ue_set_codice;call super::ue_set_codice;
return 0
end event

event ue_val_cod_parte;call super::ue_val_cod_parte;
long		ll_row, ll_lunghezza, ll_id_cat_codifica, ll_parti_trovate, ll_id_cod_parte, ll_nr_parte
string	ls_tipo_richiesta, ls_codice, as_parte, ls_descrizione
integer 	li_error

as_err_message=""
al_err_code=0
ll_row= GetRow()
If not(IsNull(al_nr_codice) OR al_nr_codice=0) AND not(IsNull(ll_row) OR ll_row=0)then
	ls_codice= GetItemString(ll_row ,"c_codice_" + String(al_nr_codice))
	ll_nr_parte= istr_cod_tot[al_nr_codice].l_num_sezione
	ll_lunghezza= istr_cod_tot[al_nr_codice].l_lunghezza
	ls_descrizione= istr_cod_tot[al_nr_codice].s_descrizione
	If IsNull(ls_descrizione) then ls_descrizione=""
	if ls_descrizione <> "" then ls_descrizione= " - " + ls_descrizione
	ls_tipo_richiesta= istr_cod_tot[al_nr_codice].s_tipo_richiesta
	if ll_lunghezza > 0 then
		CHOOSE CASE ls_tipo_richiesta
			CASE "F"
				
				if ll_lunghezza < Len(ls_codice) then
					as_err_message=as_err_message + "~n~t E' lunga più di " + String(ll_lunghezza) + " caratteri."
					li_error=1
				end if
			CASE "A"
				
			CASE "R"
				
				
				if istr_cod_tot[al_nr_codice].s_solo_in_elenco = "S" then
					ll_id_cod_parte= istr_cod_tot[al_nr_codice].l_id_cod_parte
					SELECT Count(*)  
						INTO :ll_parti_trovate  
						FROM "dba"."scelta_parte"  
						WHERE ( "scelta_parte"."id_cod_parte" = :ll_id_cod_parte ) AND  
						( "scelta_parte"."scelta" = :ls_codice )   ;
					
					
					if ll_parti_trovate = 0 then
						as_err_message=as_err_message + "~n~t Non corrisponde ad alcuna Scelta." 
						li_error=2
					end if
				else
					
					if not(ll_lunghezza = Len(ls_codice)) then
						as_err_message=as_err_message + "~n~t Non è lunga " + String(ll_lunghezza) + " caratteri."
						li_error=3
					end if
				end if
		END CHOOSE
	end if
end if
if li_error > 0 then
	as_err_message=  "La parte Nr." + String(ll_nr_parte) + " (" + ls_codice + &
		ls_descrizione + ") è ERRATA, in quanto:" + as_err_message 
	al_err_code=li_error
	
	Modify("c_codice_" + String(al_nr_codice) + ".background.color=" + String(RGB(255, 127, 127)))
else
	Modify("c_codice_" + String(al_nr_codice) + ".background.color=" + String(idc_w_color))
end if
return ls_codice

end event

event ue_set_parte_progr;call super::ue_set_parte_progr;
integer		li_num_parte, li_parte,li_size, li_count
string		ls_max_progr, ls_parte[], Somma, appoggio
decimal		ldc_max_progr
long			ll_row, ll_id_cat_codifica
s_cod_parte locale[]


somma = ""
If ib_esiste_progr then
	ll_row= GetRow()
	li_size= UpperBound(istr_cod_tot)
	for li_count = 1 to li_size
		ls_parte[li_count]=tab_1.tabpage_1.dw_articolo_gen_ff.GetItemString(ll_row, "c_codice_" + String(li_count))
		
		
		somma = somma+ls_parte[li_count]+"* ~r~n"
	next
	locale = istr_cod_tot
	li_parte=0
			
	ll_id_cat_codifica=tab_1.tabpage_1.dw_articolo_gen_ff.GetItemnumber(ll_row,"id_cat_codifica")
	ls_max_progr= wf_calc_progr(ls_parte,istr_cod_tot, li_parte,ll_id_cat_codifica)
	If ls_max_progr <> "" AND li_parte > 0 then
		SetItem(GetRow(), "c_codice_" + String(li_parte), ls_max_progr)
	end if
end if

end event

event ue_reset();
integer 			li_size, li_counter
long 				ll_row
datawindow		ldw_item

li_size = UpperBound(iudw_children)
for li_counter = 1 to li_size
	ldw_item = iudw_children[li_counter]
	ldw_item.Reset()
next
idw_master.reset()
end event

event ue_setta_fuoco;call super::ue_setta_fuoco;setcolumn("c_codice_1")
end event

event ue_cod_cambiato;call super::ue_cod_cambiato;ib_codice_modificato=true
end event

event ue_init;call super::ue_init;window 	lw_parent
tab    	lw_tab

iudw_children[1] = tab_1.tabpage_1.dw_unita_confezione2_lt

iudw_children[2] = tab_1.tabpage_2.dw_articolo_gen2_ff

iudw_children[3] = tab_1.tabpage_3.dw_sostituzione_gd
iudw_children[4] = tab_1.tabpage_3.dw_articoli_sostituiti_gd
iudw_children[5] = tab_1.tabpage_4.dw_articolo_altro_ff
iudw_children[6] = tab_1.tabpage_6.dw_des_articolo_lt
iudw_children[7] = tab_1.tabpage_6.dw_approvvigionamento_gd
iudw_children[8] = tab_1.tabpage_list_generici.dw_listino_var_base_articolo_lt


is_list.s_identifica[1] = "id_articolo"

lw_tab = Parent.GetParent()
lw_parent = lw_tab.GetParent()
is_title_modifica = lw_parent.Title

ib_control_save = false
end event

event itemchanged;
decimal		ldc_max_progr
string   	ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond, ls_parte[], ls_err_message
long     	ll_ok, ll_size, ll_counter, ll_err_parte
integer		li_num_parte, li_parte
long 		 	ll_row, ll_value, ll_test, ll_lunghezza, ls_max_progr, ll_cat_com, ll_tab_iva
s_code_mask lstr_code_mask
boolean		lb_test
string		ls_ref_value
string 		ls_codice, ls_descrizione

constant integer codice_ok = 0
constant integer lunghezza_errata = 1
constant integer parte_errata = 2
ls_sql_cond = ""
ll_row = GetRow()
CHOOSE CASE string(dwo.name)
		
	CASE "id_cat_codifica", "id_cat_codifica_des"
		ib_codice_modificato=FALSE
		POST TriggerEvent("ue_prepare_codice")
		post event ue_cod_cambiato()
		if (long(data) <> il_old_cat_codifica) and not isnull(data) then
			il_old_variante = 0
			il_old_cat_codifica = long(data)
		end if
	CASE 'c_anagrafica_rag_soc_1'
		ls_dbc[1] = "id_anagrafica"
		ls_dwc[1] = "id_anagrafica"
		ls_dbc[2] = "rag_soc_1"
		ls_dwc[2] = "c_anagrafica_rag_soc_1"
		ll_ok = uf_autofind_col(dwo.Name, "anagrafica", &  
										"rag_soc_1", "A", data, & 
										ls_sql_cond, 2, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF		
		
	CASE 'c_sog_commerciale_codice'
ls_sql_cond = "sog_commerciale_gen.tipo = 'F'"		
		ls_dbc[1] = "id_sog_commerciale"
		ls_dwc[1] = "id_sog_commerciale"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_sog_commerciale_codice"
		ls_dbc[3] = "rag_soc_1"
		ls_dwc[3] = "c_anagrafica_b_rag_soc_1"
		ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &  
										"codice", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF	
		
	CASE 'c_anagrafica_b_rag_soc_1'
		ls_sql_cond = "sog_commerciale_gen.tipo = 'F'"				
		ls_dbc[1] = "id_sog_commerciale"
		ls_dwc[1] = "id_sog_commerciale"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_sog_commerciale_codice"
		ls_dbc[3] = "rag_soc_1"
		ls_dwc[3] = "c_anagrafica_b_rag_soc_1"
		ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &  
										"rag_soc_1", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
	CASE "codice"
		ls_codice = This.GetText()
		ls_descrizione = This.GetItemString(ll_Row, "descrizione")
		uf_titolo_finestra(ls_codice, ls_descrizione)
		
		
	CASE "descrizione"
		ls_descrizione = This.GetText()
		ls_codice = This.GetItemString(ll_Row, "codice")
		
		
		uf_titolo_finestra(ls_codice, ls_descrizione)
	
	CASE "c_codice_1","c_codice_2","c_codice_3","c_codice_4","c_codice_5","c_codice_6","c_codice_7","c_codice_8","c_codice_9"
	
		ib_codice_modificato=TRUE
		li_num_parte= Long(Mid(dwo.name,10,1))
		If UpperBound(istr_cod_tot)>0 then
			
			if not(istr_cod_tot[li_num_parte].s_progressivo = "S") then
				post TriggerEvent("ue_set_parte_progr")
			end if
		end if
		
	
	CASE "id_cat_com_articolo_cod", "id_cat_com_articolo"
	ll_row =	this.getrow()
	ll_cat_com = long(data)
		if not isnull(ll_cat_com) then
			
			
			  SELECT "cat_com_articolo"."id_tab_iva"  
				 INTO :ll_tab_iva
				 FROM "dba"."cat_com_articolo"  
				WHERE "cat_com_articolo"."id_cat_com_articolo" =:ll_cat_com;
				if SQLCA.SQLCode	 =	0 then
					this.setitem(ll_row,"id_tab_iva_cod",ll_tab_iva)
				end if
		end if
		
END CHOOSE
string ls_vis
if dwo.name="id_cat_codifica" or dwo.name="id_cat_codifica_des" then
	SELECT VIS_COM_COD_ART
	into :ls_vis
	from par_sistema;
	if ls_vis='S' then
		tab_1.tabpage_1.cb_codice.postevent(clicked!)
		post event ue_setta_fuoco()
	end if
end if


ib_control_save = True
end event

event itemerror;call super::itemerror;long ll_value, ll_test, ll_row
string ls_ref_value
constant integer codice_ok = 0
constant integer lunghezza_errata = 1
constant integer parte_errata = 2

ll_row = GetRow()
if GetColumnName() = "codice" then
	ll_value = GetItemNumber(ll_row, "id_cat_codifica")
		ll_test = f_controlla_articolo( data, ll_value, ls_ref_value) 
		CHOOSE CASE ll_test
			CASE codice_ok
				RETURN 2
			CASE lunghezza_errata
				MessageBox("Validazione del Codice", "Immettere un codice di " + ls_ref_value + " caratteri.",Exclamation!)
				tab_1.tabpage_1.cb_codice.PostEvent("clicked")
				RETURN 1	
			CASE parte_errata
				MessageBox("Validazione del Codice", "La parte di codice " + ls_ref_value + " è errata.",Exclamation!)
				tab_1.tabpage_1.cb_codice.PostEvent("clicked")
				RETURN 1	
			CASE else
		END CHOOSE
	
end if
end event

event itemfocuschanged;call super::itemfocuschanged;long ll_row, ll_value, ll_test, ll_lunghezza, ll_id_cat_cod
s_code_mask lstr_code_mask
string ls_null

ll_row = GetRow()
CHOOSE CASE string(dwo.name)
	CASE "codice"
		ich_old= GetText()
		ll_value = GetItemNumber(ll_row, "id_cat_codifica")
		lstr_code_mask = f_set_code(ll_value)
		if lstr_code_mask.s_mask <> "" then 
			this.object.codice.editmask.mask = lstr_code_mask.s_mask
		end if
END CHOOSE


long ll_cat_cod, ll_id_scomp, ll_id_articolo
string ls_variante, ls_nome_col, ls_cod_articolo, ls_cod_art[]
integer i, li_num_sezioni, li_variante
boolean lb_variante
lb_variante = false
if left(is_vecchio_campo,9) = "c_codice_" and left(string(dwo.name),9) <> "c_codice_" &
	and ib_codice_modificato = true then
	ib_codice_modificato=false

		row = getrow()
		for i = 1 to upperbound(istr_cod_tot) 
			ls_nome_col="c_codice_"+string(i)
			ls_cod_art[i] = getitemstring(row, ls_nome_col)
		next
		i = 0
		li_variante = 1
		do
			i = i+1
			ls_nome_col="c_codice_"+string(i)
			ls_cod_articolo += getitemstring(row, ls_nome_col)
			if i = upperbound(istr_cod_tot) then li_variante = 0
		loop while (i < upperbound(istr_cod_tot)) and istr_cod_tot[i+li_variante].s_variante <> "S" 
		
		if istr_cod_tot[i+li_variante].s_variante = "S" then lb_variante = true
		



	if lb_variante = true then
		
				select id_articolo
				into :ll_id_articolo
				from articolo
				where codice=:ls_cod_articolo;
			
			
		il_index_articolo_base = ll_id_articolo

		if ll_id_articolo>0 then
			
			ll_id_cat_cod = GetItemNumber(row,"id_cat_codifica")
			idw_master.is_list.s_modo=modo_modifica
			idw_master.is_list.s_identifica[1]="id_articolo"
			idw_master.is_list.l_identifica[1]=ll_id_articolo
			idw_master.event ue_retrieve(0,0)
			idw_master.setfocus()
			
			
			integer ll_null
			setnull(ll_null)
			setitem(1,"id_articolo", ll_null)
				
				
			tab_1.tabpage_3.dw_articoli_sostituiti_gd.reset()
			tab_1.tabpage_3.dw_sostituzione_gd.reset()
			tab_1.tabpage_6.dw_approvvigionamento_gd.reset()
			tab_1.tabpage_6.dw_des_articolo_lt.reset()
			
			dw_unita_confezione2_lt.setitem(1,"id_unita_confezione", ll_null)
			
			
			
			setitem(row, "id_cat_codifica", ll_id_cat_cod )
			
			
			
			
			setnull(ls_null)
			
			setitem(1, "immagine", ls_null)
			
			SetItemStatus(1, 0, Primary!, new!)
			
			string ls_appoggio
			ls_appoggio = ""
			for i = 1 to upperbound(ls_cod_art[])
				setitem(1, "c_codice_"+string(i), ls_cod_art[i])
				Ls_appoggio = ls_appoggio + ls_cod_art[i]
			next
			uf_titolo_finestra ( ls_appoggio, getitemstring(1,"descrizione") )
			
			setcolumn("descrizione")
			return
		end if
	end if
END IF	
is_vecchio_campo=dwo.name
//mm inserito per vedere se non scatta sempre ma solo quando serve
if right(string(dwo.name), 1)=string(UpperBound(istr_cod_tot)) then
	post wf_controlla_esistente(UpperBound(istr_cod_tot))
end if



st_information.visible = false

if left(string(dwo.name),9) = "c_codice_" then
	row = getrow()
		for i = 1 to upperbound(istr_cod_tot) 
			ls_nome_col="c_codice_"+string(i)
			ls_cod_art[i] = getitemstring(row, ls_nome_col)
			if ls_nome_col = string(dwo.name) then
				st_information.text = " "+istr_cod_tot[i].s_descrizione+" "

				st_information.width = (len(st_information.text))*23
				st_information.x = integer(this.describe("c_codice_"+string(i)+".x"))-(integer(st_information.width / 2))+(istr_cod_tot[i].l_lunghezza*14)
				st_information.y = integer(this.describe("c_codice_"+string(i)+".y"))+60+integer(this.describe("c_codice_"+string(i)+".height"))

				st_information.visible = true
			end if
		next	
		
		
		
	
end if
end event

event ue_use_search;call super::ue_use_search;

CHOOSE CASE as_nomecol
	CASE "c_anagrafica_rag_soc_1"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_anagrafica", is_ricpar.s_id_seg_value[1])
		
	CASE "c_sog_commerciale_codice"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_sog_commerciale", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_anagrafica_b_rag_soc_1", is_ricpar.s_ausil_value[1])
	CASE "c_anagrafica_b_rag_soc_1"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_sog_commerciale", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_sog_commerciale_codice", is_ricpar.s_ausil_value[1])
END CHOOSE


end event

event ue_set_search;

CHOOSE CASE as_nomecol
		
	CASE "c_anagrafica_rag_soc_1"
		is_search_window = "w_anagrafica_sw" 

		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "rag_soc_1" 
		
		
	CASE "c_sog_commerciale_codice"
		
		
		
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice" 
		
		is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo = 'F'"
		
	CASE "c_anagrafica_b_rag_soc_1"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "rag_soc_1" 
		
		is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo = 'F'"
		
END CHOOSE

CHOOSE CASE as_nomecol
		
	CASE "id_cat_com_articolo_cod"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_cat_com_articolo_gd"
		is_ricpar.s_titolo_finestra = "Categorie Commerciali degli Articoli"
		is_ricpar.s_ausil_value[1] = "id_cat_com_articolo"
		is_ricpar.i_width = 2949
		is_ricpar.i_height = 877
	CASE "id_cat_com_articolo"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_cat_com_articolo_gd"
		is_ricpar.s_titolo_finestra = "Categorie Commerciali degli Articoli"
		is_ricpar.s_ausil_value[1] = "id_cat_com_articolo_cod"
		is_ricpar.i_width = 2949
		is_ricpar.i_height = 877
		
	CASE "id_cat_merceologica_cod"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_cat_merceologica_gd"
		is_ricpar.s_titolo_finestra = "Categorie Merceologiche"
		is_ricpar.s_ausil_value[1] = "id_cat_merceologica"
		is_ricpar.i_width = 2931
		is_ricpar.i_height = 861
	CASE "id_cat_merceologica"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_cat_merceologica_gd"
		is_ricpar.s_titolo_finestra = "Categorie Merceologiche"
		is_ricpar.s_ausil_value[1] = "id_cat_merceologica_cod"
		is_ricpar.i_width = 2931
		is_ricpar.i_height = 861

	CASE "id_cat_fiscale_cod"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_cat_fiscale_gd"
		is_ricpar.s_titolo_finestra = "Categorie Fiscali"
		is_ricpar.s_ausil_value[1] = "id_cat_fiscale"
	CASE "id_cat_fiscale"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_cat_fiscale_gd"
		is_ricpar.s_titolo_finestra = "Categorie Fiscali"
		is_ricpar.s_ausil_value[1] = "id_cat_fiscale_cod"
		
	CASE "id_reparto"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_reparto_gd"
		is_ricpar.s_titolo_finestra = "Reparti"
		is_ricpar.s_ausil_value[1] = "id_reparto_des"
	CASE "id_reparto_des"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_reparto_gd"
		is_ricpar.s_titolo_finestra = "Reparti"
		is_ricpar.s_ausil_value[1] = "id_reparto"
		
END CHOOSE


end event

event rowfocuschanged;call super::rowfocuschanged;
boolean 		lb_1
long 			ll_id_sog_commerciale, ll_id_anagrafica, ll_Row
string 		ls_cod, ls_des, ls_codice, ls_descrizione

ll_Row = GetRow()
If IsNull(ll_Row) OR ll_Row=0 then ll_Row= RowCount()
If IsNull(ll_Row) OR ll_Row=0 then ll_Row=currentrow


if RowCount() > 0 then
	

	
ll_id_sog_commerciale = long(uf_get_colval("id_sog_commerciale"))

	
	SELECT "sog_commerciale_gen"."codice" , "sog_commerciale_gen"."rag_soc_1" 
	  	INTO : ls_codice, :ls_descrizione
     	FROM "sog_commerciale_gen"
	 	WHERE ( "sog_commerciale_gen"."id_sog_commerciale" = :ll_id_sog_commerciale )   ;
	
	uf_set_colval("c_sog_commerciale_codice",ls_codice)
	uf_set_colval("c_anagrafica_b_rag_soc_1",ls_descrizione)
	
	
	setitemstatus(ll_row, "c_sog_commerciale_codice", PRIMARY!, NotModified!)
	setitemstatus(ll_row, "c_anagrafica_b_rag_soc_1", PRIMARY!, NotModified!)
ls_codice = ""
ls_descrizione = ""
	
	
ll_id_anagrafica = long(uf_get_colval("id_anagrafica"))

	
	SELECT "anagrafica"."rag_soc_1" 
	  	INTO :ls_descrizione
     	FROM "anagrafica"
	 	WHERE ( "anagrafica"."id_anagrafica" = :ll_id_anagrafica )   ;
	
	uf_set_colval("c_anagrafica_rag_soc_1",ls_descrizione)
	
	
	setitemstatus(ll_row, "c_anagrafica_rag_soc_1", PRIMARY!, NotModified!)
ls_descrizione = ""
	
end if
end event

event retrieveend;
long ll_id_art_w_error, ll_id_articolo, ll_counter
string ls_codice
long		ll_row
string	ls_descrizione
accepttext()
ll_row=GetRow()
IF (ll_Row > 0) THEN
	ll_id_articolo=GetItemnumber(ll_row, "id_articolo")
	if isnull(ll_id_articolo) then
	
		ls_codice= GetItemString(ll_row, "codice")
		SELECT Max("articolo"."id_articolo")  
			INTO :ll_id_articolo  
			FROM "dba"."articolo"  
			WHERE "articolo"."codice" = :ls_codice ;
		If SQLCA.SQLCode = 0 then
			uf_SetItem(ll_row, "id_articolo", ll_id_articolo, TRUE)
		end if
	end if
end if


IF (ll_Row > 0) THEN
	ls_codice = GetItemString(ll_Row, "codice")
	ls_descrizione = GetItemString(ll_Row, "descrizione")

	uf_titolo_finestra(ls_codice, ls_descrizione)
END IF


decimal prezzo, coeff_calo, prezzo_man



string ls_tipo_um
long ll_id_u_conf

select "unita_confezione"."id_unita_confezione","unita_misura"."tipo"
into :ll_id_u_conf, :ls_tipo_um
from "unita_confezione","unita_misura"
where ("unita_confezione"."id_articolo" = :ll_id_articolo
and "unita_confezione"."unita_base"='S')
and "unita_misura"."id_unita_misura" = "unita_confezione"."id_unita_misura";

if sqlca.SQLCode	<> 0 then
	messagebox("DBError","Impossibile caricare id articolo da unità confezione")
	return 0
end if
//if POS(UPPER(U_FREDDIE.ISTR_DATABASE.NAME),'ORAFO') >0 then
	
	   SELECT "prezzo"."prezzo_manifattura","prezzo"."prezzo"
		
		INTO :prezzo_man, :prezzo		
		FROM "listino", "prezzo", "variazione"
		where
		
		("variazione"."id_variazione"="prezzo"."id_variazione") and
		("listino"."id_listino"="variazione"."id_listino") and 
		("prezzo"."id_unita_confezione" = :ll_id_u_conf) and
		("listino"."lis_base"='S') and ("listino"."tipo"='V') and
		(("variazione"."data_fine">=today()) or("variazione"."data_fine" is null)) and
		("variazione"."data_inizio"<= today()) ;
		
		
		if sqlca.SQLCode	<> 0 then
			messagebox("DBError","Impossibile caricare prezzo")
			return 0
		end if

		
		
		if ls_tipo_um = 'P' then 
			dw_articolo_gen_ff.SetItem(1, "prezzo", prezzo_man)
   	else 
			dw_articolo_gen_ff.SetItem(1, "prezzo", prezzo)
		end if

		SELECT "prezzo"."prezzo_manifattura","prezzo"."coef_calo","prezzo"."prezzo"
		INTO :prezzo_man, :coeff_calo, :prezzo
		FROM "listino", "prezzo", "variazione"
		where
		
		("variazione"."id_variazione"="prezzo"."id_variazione") and
		("listino"."id_listino"="variazione"."id_listino") and 
		("prezzo"."id_unita_confezione" = :ll_id_u_conf) and
		("listino"."lis_base"='S') and ("listino"."tipo"='A') and
		(("variazione"."data_fine">=today()) or("variazione"."data_fine" is null)) and
		("variazione"."data_inizio"<= today()) ;
		
		if sqlca.SQLCode	<> 0 then
			
			return 0
		end if
		
		if ls_tipo_um = 'P' then 
			dw_articolo_gen_ff.SetItem(1, "prezzo_for", prezzo_man)
		else
			dw_articolo_gen_ff.SetItem(1, "prezzo_for", prezzo)
		end if
		dw_articolo_gen_ff.SetItem(1, "coeff_calo", coeff_calo)
	
//else
	
//		SELECT "prezzo"."prezzo"   //20231129 troppo vecchio obsoleto, commento e lascio la parte sopra
//		INTO :prezzo
//		FROM "listino", "prezzo", "variazione"
//		where
//		
//		("variazione"."id_variazione"="prezzo"."id_variazione") and
//		("listino"."id_listino"="variazione"."id_listino") and 
//		("prezzo"."id_unita_confezione" = :ll_id_u_conf) and
//		("listino"."lis_base"='S') and ("listino"."tipo"='V') and
//		(("variazione"."data_fine">=today()) or("variazione"."data_fine" is null)) and
//		("variazione"."data_inizio"<= today()) ;
//		
//		
//		if sqlca.SQLCode	<> 0 then
//			
//			return 0
//		end if
//		dw_articolo_gen_ff.SetItem(1, "prezzo", prezzo)
//		
//		
//
//		SELECT "prezzo"."prezzo"
//		INTO :prezzo
//		FROM "listino", "prezzo", "variazione"
//		where
//		
//		("variazione"."id_variazione"="prezzo"."id_variazione") and
//		("listino"."id_listino"="variazione"."id_listino") and 
//		("prezzo"."id_unita_confezione" = :ll_id_u_conf) and
//		("listino"."lis_base"='S') and ("listino"."tipo"='A') and
//		(("variazione"."data_fine">=today()) or("variazione"."data_fine" is null)) and
//		("variazione"."data_inizio"<= today()) ;
//		
//		if sqlca.SQLCode	<> 0 then
//			
//			return 0
//		end if
//		dw_articolo_gen_ff.SetItem(1, "prezzo_for", prezzo)

	
//end if







end event

event ue_key;call super::ue_key;
string ls_column

ls_column=GetColumnName()
if (key= KeyF4!) AND Left(ls_column,9) = "c_codice_" then
	
	If istr_cod_tot[Long(Right(ls_column,1))].s_progressivo= "S" then TriggerEvent("ue_set_parte_progr")
end if


if (key= KeyF3!)  then
	cb_nuovo.triggerevent(clicked!)
end if
end event

event updatestart;
if GetItemStatus(GetRow(), 0, Primary!) = New! OR GetItemStatus(GetRow(), 0, Primary!) = NewModified! then
	ib_fix_id = TRUE
else
	ib_fix_id = FALSE
end if
long ll_row
ll_row=getrow()
if ll_row=1 then
	
	
	
	
	
	
	string ls_des_est, ls_des_breve
	ls_des_breve=getitemstring(ll_row, "des_breve")
	ls_des_est=getitemstring(ll_row, "descrizione")
	if len(ls_des_est) > 40 then ls_des_est=left(ls_des_est, 40)
	if isnull(ls_des_est) or ls_des_est="" then
		ls_des_est=getitemstring(ll_row, "codice")
		
		setitem(ll_row, "descrizione", ls_des_est)
		if isnull(ls_des_breve) or ls_des_breve="" then
			
			setitem(ll_row, "des_breve", ls_des_est)
		end if
	else
		if isnull(ls_des_breve) or ls_des_breve="" then
			setitem(ll_row, "des_breve", ls_des_est)
		end if
	end if
	
	
	
	String	ls_codice
	
	ls_codice = getitemstring(ll_row, "codice")
	ls_codice = RightTrim(ls_codice)
	
	setitem(ll_row, "codice", ls_codice)
	
		
	
	string ls_cod_art, ls_suf_imm
	ls_cod_art=getitemstring(ll_row, "immagine")
	if ls_cod_art="" or isnull(ls_cod_art) then
		ls_cod_art=getitemstring(ll_row, "codice")
		select suf_immagine
		into :ls_suf_imm
		from par_sistema;
		if ls_suf_imm='' or isnull(ls_suf_imm) then ls_suf_imm='JPG'
		ls_cod_art=ls_cod_art+"."+ ls_suf_imm
		setitem(ll_row, "immagine", ls_cod_art)
	end if
end if
end event

event updateend;
long 					ll_id_lis_w_error, ll_row, ll_id_articolo, ll_counter
string 				ls_codice 

u_dw_master_main 	ldw_un_confezione 
ldw_un_confezione = Tab_1.TabPage_1.dw_unita_confezione2_lt

if ib_fix_id then
	ll_row=GetRow()
	ls_codice= GetItemString(ll_row, "codice")
	SELECT Max("articolo"."id_articolo")  
		INTO :ll_id_articolo 
		FROM "dba"."articolo"  
		WHERE "articolo"."codice" = :ls_codice ;
	If SQLCA.SQLCode = 0 then
		uf_SetItem(ll_row, "id_articolo", ll_id_articolo, TRUE)
	end if
	
	for ll_counter = 1 to Upperbound(ldw_un_confezione.is_list.s_identifica)
		ldw_un_confezione.is_list.l_identifica[ll_counter] = GetItemNumber(ll_row, ldw_un_confezione.is_list.s_identifica[ll_counter])
	next
	iuo_msg_log.uf_new_text("E' stata generata una Unità Confezione di default.",3)
	ldw_un_confezione.post TriggerEvent("ue_retrieve")
	

end if


IF rowsinserted + rowsupdated > 0 THEN
	Post uf_prezzi()
	
END IF




decimal ld_prezzo
long ll_id_variazione, ll_id_u_conf

ll_row=GetRow()
if rowsinserted + rowsupdated > 0 then
	
post wf_aggiungi_prezzo_a_listino(ll_row, this)
	
	
	Post uf_agg_cod_barre(ll_row, this)
	
	
end if


end event

event ue_validate_row;call super::ue_validate_row;
long 		ll_counter, ll_size, ll_row
string 	ls_codice
long 				ll_nr_row, ll_err_parte, ll_err_totali
string			ls_parte_codice, ls_err_message, ls_err_totale

ll_row= GetRow()

if ll_row> 0 then
	ll_row=1
	ls_codice= ""
	ll_size= UpperBound(istr_cod_tot)
	for ll_counter = 1 to ll_size
		ls_codice= ls_codice + event ue_val_cod_parte(ll_counter, ls_err_message, ll_err_parte)
ll_err_totali=ll_err_totali + ll_err_parte
	ls_err_totale= ls_err_totale + "~n" + ls_err_message
	next
end if

if ll_err_totali= 0 then
	SetItem(ll_row, "codice", ls_codice)
else
	if IsNull(ls_err_totale) OR ls_err_totale = "" then ls_err_totale ="Codice ERRATO per cause non precisate."
	as_error_text= ls_err_totale
end if
return ll_err_totali
end event

event ue_retrieve;call super::ue_retrieve;boolean 		lb_1
long 			ll_id_sog_commerciale, ll_id_anagrafica, ll_Row
string 		ls_cod, ls_des, ls_codice, ls_descrizione

ll_Row = this.GetRow()
if IsNull(ll_Row) or ll_Row = 0 then
	ll_Row = this.RowCount()
end if	

if ll_row<1 or isnull(ll_row) then return

ll_id_sog_commerciale = this.GetItemNumber(ll_row,"id_sog_commerciale")
if ll_id_sog_commerciale>0 then	
	
	select "sog_commerciale_gen"."codice" , "sog_commerciale_gen"."rag_soc_1" 
		into : ls_codice, :ls_descrizione
		from "dba"."sog_commerciale_gen"
		where ( "sog_commerciale_gen"."id_sog_commerciale" = :ll_id_sog_commerciale );
		
	this.SetItem( ll_row,"c_sog_commerciale_codice",ls_codice )
	this.SetItem( ll_row,"c_anagrafica_b_rag_soc_1",ls_descrizione )
		
	
	this.SetItemStatus(ll_row, "c_sog_commerciale_codice", PRIMARY!, NotModified!)
	this.SetItemStatus(ll_row, "c_anagrafica_b_rag_soc_1", PRIMARY!, NotModified!)
end if
ls_codice 		= ""
ls_descrizione = ""
	
ll_id_anagrafica = this.GetItemNumber(ll_row,"id_anagrafica")

select "anagrafica"."rag_soc_1" 
	 into :ls_descrizione
    from "dba"."anagrafica"
	 where ( "anagrafica"."id_anagrafica" = :ll_id_anagrafica )   ;
	
this.SetItem(ll_row,"c_anagrafica_rag_soc_1",ls_descrizione)
	
	
this.SetItemStatus(ll_row, "c_anagrafica_rag_soc_1", PRIMARY!, NotModified!)





ll_id_sog_commerciale = this.GetItemNumber(ll_row,"id_sog_comm_variante")
select "sog_commerciale_gen"."codice" , "sog_commerciale_gen"."rag_soc_1" 
  	into : ls_codice, :ls_descrizione
   from "dba"."sog_commerciale_gen"
	where ( "sog_commerciale_gen"."id_sog_commerciale" = :ll_id_sog_commerciale );
	
this.SetItem( ll_row,"c_cod_sog_comm_variante",ls_codice )
this.SetItem( ll_row,"c_rag_soc_1_variante",ls_descrizione )
	
this.SetItemStatus(ll_row, "c_cod_sog_comm_variante", PRIMARY!, NotModified!)
this.SetItemStatus(ll_row, "c_rag_soc_1_variante", PRIMARY!, NotModified!)

end event

event ue_insert;call super::ue_insert;
long ll_row , ll_id_cat_fis

ll_row = THIS.GetRow()

SELECT "cat_fiscale"."id_cat_fiscale"
INTO :ll_id_cat_fis
FROM "cat_fiscale","par_sistema"
WHERE "cat_fiscale"."id_cat_fiscale" = "par_sistema"."id_cat_fis_prop";

If SQLCA.SQLCODE = 0 Then
	This.SetItem(ll_row,"id_cat_fiscale",ll_id_cat_fis)
End If



end event

event ue_core_update;call super::ue_core_update;
end event

event clicked;call super::clicked;if dwo.name="prod_interna" then
	post wf_controlla_check(this)
end if



s_list_main		lstr_list
long ll_id_art, ll_idloc, ll_idmag,ll_row
string ls_id_loc, variabile_stringa
		
		
if dwo.name= "info_articolo" then		
		ll_id_art = this.GetItemNumber (1, "id_articolo")

		lstr_list.s_win_parametri='A'
		lstr_list.l_identifica[1]	= ll_id_art
      
		
		select table_name 
		into :variabile_stringa
		from systable
		where table_name='orafo_par_sistema';
		
		
      if sqlca.sqlcode=0 then
			
		else
			OpenWithParm(w_sit_articolo_wz,lstr_list)
		end if	
end if

if dwo.name= "info_riep" then		
	
	   string tipo_um
		ll_id_art = this.GetItemNumber (1, "id_articolo")
		lstr_list.l_identifica[1]	= ll_id_art

		select tipo 
		into :tipo_um
		from unita_misura m, unita_confezione u
		where u.id_unita_misura=m.id_unita_misura and unita_base='S' and u.id_articolo=:ll_id_art;
		
		lstr_list.s_provenienza=tipo_um
		if not isnull(ll_id_art) and ll_id_art<>0 then OpenWithParm(w_stampa_riep_art_ff, lstr_list)
end if
end event

event ue_update;call super::ue_update;integer 		li_size, li_counter
long 			ll_NotGood
u_dw_main 	ldw_item

ll_NotGood = 0

if not ib_dw_shared then
	
	li_size = UpperBound(iudw_children)
	for li_counter = 1 to li_size
		ldw_item = iudw_children[li_counter]
		ll_NotGood = ll_NotGood + ldw_item.Event ue_update(0,0)
	next
	
	if ll_NotGood = 0 then 
		ll_NotGood = Super::EVENT ue_update (0,0)
	end if
	
	if ll_NotGood = 0  AND not IsValid(iudw_parent) then 
		
		ll_NotGood = Trigger Event ue_core_update (0,0)
		
		ll_NotGood = Trigger Event ue_commit(ll_NotGood)
		
		if ll_NotGood = 0 then
			
			Trigger Event ue_reset_flags()
		end if
		li_size = upperbound(is_list.l_identifica)
		for li_counter = 1 to li_size
			is_ritorni.s_identifica[li_counter] = is_list.s_identifica[li_counter]
			is_ritorni.l_identifica[li_counter] = is_list.l_identifica[li_counter]
		next
	end if
end if

return ll_NotGood
end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 2738
integer height = 1448
long backcolor = 79741120
string text = "Articolo"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_articolo_gen2_ff dw_articolo_gen2_ff
end type

on tabpage_2.create
this.dw_articolo_gen2_ff=create dw_articolo_gen2_ff
this.Control[]={this.dw_articolo_gen2_ff}
end on

on tabpage_2.destroy
destroy(this.dw_articolo_gen2_ff)
end on

type dw_articolo_gen2_ff from u_dw_master_main within tabpage_2
integer x = 5
integer y = 32
integer width = 2688
integer height = 1356
string dataobject = "d_articolo_gen2_ff"
boolean hscrollbar = true
end type

event ue_init;call super::ue_init;ib_dw_shared=true
is_title 					= "Articolo"
is_list.s_colonne_drop[1]="id_cat_merceologica"
is_list.s_colonne_drop[2]="id_cat_merceologica_des"
is_list.s_colonne_drop[3]="id_cat_fiscale"
is_list.s_colonne_drop[4]="id_cat_fiscale_des"
is_list.s_colonne_drop[5]="id_reparto"
is_list.s_colonne_drop[6]="id_reparto_des"
is_list.s_colonne_drop[7]="id_tab_iva"
is_list.s_colonne_drop[8]="id_tab_iva_cod"
is_list.s_colonne_drop[9]="id_tipo_cod_barre"



end event

event ue_set_search;

CHOOSE CASE as_nomecol
		
	CASE "c_anagrafica_rag_soc_1"
		is_search_window = "w_anagrafica_sw" 

		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "rag_soc_1" 
		
		
	
	CASE "c_cod_sog_comm_variante"
		
		
		
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice" 
		
		
	CASE "c_rag_soc_1_variante"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "rag_soc_1" 
		
   
	
	

		
END CHOOSE


end event

event ue_use_search;



CHOOSE CASE as_nomecol
	CASE "c_anagrafica_rag_soc_1"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_anagrafica", is_ricpar.s_id_seg_value[1])
	CASE "c_cod_sog_comm_variante"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_sog_comm_variante", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_rag_soc_1_variante", is_ricpar.s_ausil_value[1])
	CASE "c_rag_soc_1_variante"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_sog_comm_variante", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_cod_sog_comm_variante", is_ricpar.s_ausil_value[1])		
	
	
	

	
	
END CHOOSE



end event

event itemchanged;String	ls_cod_barre, ls_check_digit, ls_tipo, ls_alfanumerico, ls_codice, ls_gen_automatica
Long	  	ll_id_tipo_cod_barre
Integer	li_ret, li_lunghezza, li_check_digit
long ll_ok
string ls_sql_cond
string ls_dbc[], ls_dwc[], ls_dbv[]

choose case dwo.name
		
		CASE "c_cod_sog_comm_variante"
		   ls_sql_cond = ""
		
		   ls_dbc[1] = "id_sog_commerciale"
		   ls_dwc[1] = "id_sog_comm_variante"
		   ls_dbc[2] = "codice"
		   ls_dwc[2] = "c_cod_sog_comm_variante"
		   ls_dbc[3] = "rag_soc_1"
		   ls_dwc[3] = "c_rag_soc_1_variante"
		   ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &
										"codice", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		   
			IF (ll_ok > 0) THEN
			  RETURN 2
		   END IF
		
		CASE "c_rag_soc_1_variante"
		   ls_sql_cond = ""
		
		   ls_dbc[1] = "id_sog_commerciale"
		   ls_dwc[1] = "id_sog_comm_variante"
		   ls_dbc[2] = "codice"
		   ls_dwc[2] = "c_cod_sog_comm_variante"
		   ls_dbc[3] = "rag_soc_1"
		   ls_dwc[3] = "c_rag_soc_1_variante"
		   ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &
										"rag_soc_1", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		
		   IF (ll_ok > 0) THEN
			  RETURN 2
		   END IF
		
		
	   
		
	case "cod_barre"
		
		  if isnull(data) then this.Post SetItem(Row, "gen_automatica", "N")
		
		ls_gen_automatica = this.Object.gen_automatica[row]
		if not isnull(data) and Data <> '' and &
			(isnull(ls_gen_automatica) or ls_gen_automatica = 'N') then
			
			u_cod_barre l_u_cod_barre
			
			
	
			l_u_cod_barre = create u_cod_barre
			
			ll_id_tipo_cod_barre = this.Object.id_tipo_cod_barre[row]
			ls_cod_barre = data
			
			SELECT codice, tipo, check_digit, lunghezza, alfanumerico
			INTO	 :ls_codice, :ls_tipo, :ls_check_digit, :li_lunghezza, :ls_alfanumerico
			FROM	 tipo_cod_barre
			WHERE	 id_tipo_cod_barre = :ll_id_tipo_cod_barre
			;
			if SQLCA.SQLCODE = -1 then
				messagebox("Verifica del codice a barre", SQLCA.SQLERRTEXT)
			end if
			
			li_ret = l_u_cod_barre.uf_ver_cod_barre(ls_codice, li_lunghezza, ls_alfanumerico, ls_cod_barre, ls_tipo)
					
			if li_ret = -1 then 
				destroy l_u_cod_barre		
				return 2
			else
				if ls_check_digit = 'S' then
					li_check_digit = l_u_cod_barre.uf_Check_Digit(ls_tipo, li_lunghezza, ls_cod_barre)
	
					if not isnull(li_check_digit) then
						ls_cod_barre = mid (ls_cod_barre, 1, li_lunghezza - 1) + string(li_check_digit)
						this.Post SetItem(Row, "cod_barre", ls_cod_barre)
						this.Post SetItem(Row, "gen_automatica", "N")
					end if
				end if
			end if		
		end if
		
	case "gen_automatica"
		
		if Data = 'S' then
		
			l_u_cod_barre = create u_cod_barre	
			
			ll_id_tipo_cod_barre = This.Object.id_tipo_cod_barre[row]
			ls_cod_barre = l_u_cod_barre.uf_gen_automatica(ll_id_tipo_cod_barre)
		
			if ls_cod_barre = '-1' then 
				messagebox("Generazione automatica del codice a barre", "Non è stato possibile generare il codice a barre")
				return 2
			else
				this.Post SetItem(Row, "cod_barre", ls_cod_barre)							
			end if
			destroy l_u_cod_barre		
		end if
end choose
end event

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 2738
integer height = 1448
long backcolor = 79741120
string text = "Sostituzioni"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_articoli_sostituiti_gd dw_articoli_sostituiti_gd
st_1 st_1
dw_sostituzione_gd dw_sostituzione_gd
st_2 st_2
end type

on tabpage_3.create
this.dw_articoli_sostituiti_gd=create dw_articoli_sostituiti_gd
this.st_1=create st_1
this.dw_sostituzione_gd=create dw_sostituzione_gd
this.st_2=create st_2
this.Control[]={this.dw_articoli_sostituiti_gd,&
this.st_1,&
this.dw_sostituzione_gd,&
this.st_2}
end on

on tabpage_3.destroy
destroy(this.dw_articoli_sostituiti_gd)
destroy(this.st_1)
destroy(this.dw_sostituzione_gd)
destroy(this.st_2)
end on

type dw_articoli_sostituiti_gd from u_dw_master_main within tabpage_3
integer x = 9
integer y = 796
integer width = 2665
integer height = 572
integer taborder = 3
string dataobject = "d_articoli_sostituiti_gd"
end type

event ue_init;call super::ue_init;is_title 					= "Articoli Sostitutivi dall'Articolo Corrente"
is_list.s_identifica[1] = "id_articolo"
end event

event itemchanged;call super::itemchanged;

string    ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
long      ll_ok

ls_sql_cond = ""

CHOOSE CASE dwo.name

	CASE 'c_articolo_codice'
		ls_dbc[1] = "id_articolo"
		ls_dwc[1] = "id_articolo"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_articolo_codice"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "c_articolo_descrizione"
		ll_ok = uf_autofind_col(dwo.Name, "articolo", &  
										"codice", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF			
		
	CASE 'c_articolo_descrizione'
		ls_dbc[1] = "id_articolo"
		ls_dwc[1] = "id_articolo"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_articolo_codice"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "c_articolo_descrizione"
		ll_ok = uf_autofind_col(dwo.Name, "articolo", &  
										"descrizione", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF			
		
END CHOOSE

end event

event ue_set_search;call super::ue_set_search;

CHOOSE CASE as_nomecol
	CASE "c_articolo_codice"
		is_search_window = "w_articolo_coddes_sw" 

		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "articolo_codice" 
		
		
	CASE "c_articolo_descrizione"
		is_search_window = "w_articolo_coddes_sw" 

		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "articolo_descrizione" 
		
			
END CHOOSE

end event

event ue_use_search;call super::ue_use_search;

CHOOSE CASE as_nomecol
	CASE "c_articolo_codice"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_articolo", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_articolo_descrizione", is_ricpar.s_ausil_value[1])
	
	CASE "c_articolo_descrizione"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_articolo", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_articolo_codice", is_ricpar.s_ausil_value[1])
END CHOOSE
end event

event ue_insert;call super::ue_insert;long ll_Row, ll_null

SetNull(ll_null)
ll_Row = GetRow()
IF ll_Row > 0 THEN
	This.SetItem(ll_Row, "sostituzione_id_art_sostitutivo", GetItemNumber(ll_Row, "id_articolo"))
	This.SetItem(ll_Row, "id_articolo", ll_null)	
END IF	
end event

type st_1 from statictext within tabpage_3
integer x = 9
integer y = 36
integer width = 2665
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 1090519039
long backcolor = 276856960
boolean enabled = false
string text = " Articoli Sostitutivi dell~'Articolo Corrente"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_sostituzione_gd from u_dw_master_main within tabpage_3
event ue_init pbm_custom01
integer x = 14
integer y = 116
integer width = 2665
integer height = 572
integer taborder = 4
string dataobject = "d_sostituzione_gd"
boolean vscrollbar = true
end type

event ue_init;call super::ue_init;is_title 					= "Articoli Sostitutivi dell'Articolo Corrente"
is_list.s_identifica[1] = "id_articolo"

end event

event ue_use_search;call super::ue_use_search;

CHOOSE CASE as_nomecol
	CASE "c_articolo_codice"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("sostituzione_id_art_sostitutivo", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_articolo_descrizione", is_ricpar.s_ausil_value[1])
	
	CASE "c_articolo_descrizione"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("sostituzione_id_art_sostitutivo", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_articolo_codice", is_ricpar.s_ausil_value[1])
END CHOOSE
end event

event ue_set_search;call super::ue_set_search;

CHOOSE CASE as_nomecol
	CASE "c_articolo_codice"
		is_search_window = "w_articolo_coddes_sw" 

		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "articolo_codice" 
		
		
	CASE "c_articolo_descrizione"
		is_search_window = "w_articolo_coddes_sw" 

		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "articolo_descrizione" 
		
			
END CHOOSE

end event

event itemchanged;call super::itemchanged;

string    ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
long      ll_ok

ls_sql_cond = ""

CHOOSE CASE dwo.name

	CASE 'c_articolo_codice'
		ls_dbc[1] = "id_articolo"
		ls_dwc[1] = "sostituzione_id_art_sostitutivo"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_articolo_codice"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "c_articolo_descrizione"
		ll_ok = uf_autofind_col(dwo.Name, "articolo", &  
										"codice", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF			
		
	CASE 'c_articolo_descrizione'
		ls_dbc[1] = "id_articolo"
		ls_dwc[1] = "sostituzione_id_art_sostitutivo"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_articolo_codice"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "c_articolo_descrizione"
		ll_ok = uf_autofind_col(dwo.Name, "articolo", &  
										"descrizione", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF			
		
END CHOOSE

end event

type st_2 from statictext within tabpage_3
integer x = 9
integer y = 716
integer width = 2665
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 1090519039
long backcolor = 276856960
boolean enabled = false
string text = " Articoli Sostituiti dall~'Articolo Corrente"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type tabpage_4 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 2738
integer height = 1448
long backcolor = 79741120
string text = "Altro"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_articolo_altro_ff dw_articolo_altro_ff
end type

on tabpage_4.create
this.dw_articolo_altro_ff=create dw_articolo_altro_ff
this.Control[]={this.dw_articolo_altro_ff}
end on

on tabpage_4.destroy
destroy(this.dw_articolo_altro_ff)
end on

type dw_articolo_altro_ff from u_dw_master_main within tabpage_4
integer x = 5
integer y = 32
integer width = 2665
integer height = 1332
integer taborder = 5
string dataobject = "d_articolo_altro_ff"
end type

event ue_init;call super::ue_init;ib_dw_shared = TRUE
is_list.s_colonne_drop[1]="id_cif"
is_list.s_colonne_drop[2]="id_valuta"
is_list.s_colonne_drop[3]="id_valuta_des"

end event

event itemchanged;
if dwo.name="stato" then
	this.setitem(getrow(),"data_ora_ult_var_stato", today())
end if
string ls_immagine
if dwo.name="immagine" then
	uf_mostra_immagine(data)
end if

long ll_row
ll_row = GetRow()
CHOOSE CASE string(dwo.name)
	CASE "id_valuta"
		uf_setta_format(long(data))
end choose
end event

event itemfocuschanged;call super::itemfocuschanged;
Long ll_costo_agg , ll_valuta , ll_null
IF String(dwo.Name)='id_valuta' THEN
	SetNull(ll_null)
	ll_costo_agg = tab_1.tabpage_4.dw_articolo_altro_ff.GetItemNumber(row,'costo_aggiuntivo')
	
	IF (ll_costo_agg <> 0) OR (NOT isNull(ll_costo_agg) )THEN
		IF isNull(tab_1.tabpage_4.dw_articolo_altro_ff.GetItemNumber(row,'id_valuta')) THEN
			SELECT "par_sistema"."id_valuta"
			INTO :ll_valuta
			FROM "par_sistema";
			tab_1.tabpage_4.dw_articolo_altro_ff.SetItem(row,'id_valuta',ll_valuta)
		END IF
	ELSE
			tab_1.tabpage_4.dw_articolo_altro_ff.SetItem(row,'id_valuta',ll_null)
	END IF
END IF
end event

type tabpage_5 from userobject within tab_1
event create ( )
event destroy ( )
boolean visible = false
integer x = 18
integer y = 104
integer width = 2738
integer height = 1448
boolean enabled = false
long backcolor = 79741120
string text = "< Non Usata >"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
end type

type tabpage_6 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 104
integer width = 2738
integer height = 1448
long backcolor = 79741120
string text = "Descrizioni e Approvvigionamento"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_des_articolo_lt dw_des_articolo_lt
st_5 st_5
st_6 st_6
dw_approvvigionamento_gd dw_approvvigionamento_gd
end type

on tabpage_6.create
this.dw_des_articolo_lt=create dw_des_articolo_lt
this.st_5=create st_5
this.st_6=create st_6
this.dw_approvvigionamento_gd=create dw_approvvigionamento_gd
this.Control[]={this.dw_des_articolo_lt,&
this.st_5,&
this.st_6,&
this.dw_approvvigionamento_gd}
end on

on tabpage_6.destroy
destroy(this.dw_des_articolo_lt)
destroy(this.st_5)
destroy(this.st_6)
destroy(this.dw_approvvigionamento_gd)
end on

type dw_des_articolo_lt from u_dw_master_main within tabpage_6
event ue_init pbm_custom01
integer x = 9
integer y = 116
integer width = 2720
integer height = 596
integer taborder = 10
string dataobject = "d_des_articolo_lt"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event ue_init;call super::ue_init;is_title 					= "Descrizioni"
is_list.s_identifica[1] = "id_articolo"
is_resp_window 			= "w_des_articolo_ff"
is_list.s_win_chiave[1] = "id_des_articolo"
is_list.s_par_name[1] 	= "id_articolo"
end event

type st_5 from statictext within tabpage_6
integer x = 9
integer y = 36
integer width = 2720
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 276856960
boolean enabled = false
string text = "Descrizione"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_6 from statictext within tabpage_6
integer x = 9
integer y = 756
integer width = 2720
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 276856960
boolean enabled = false
string text = "Approvvigionamento"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_approvvigionamento_gd from u_dw_master_main within tabpage_6
integer x = 9
integer y = 836
integer width = 2720
integer height = 540
integer taborder = 20
string dataobject = "d_approvvigionamento_gd"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event ue_init;call super::ue_init;is_title 					= "Approvvigionamento"
is_list.s_identifica[1] = "id_articolo"
is_list.s_win_chiave[1] = "approvvigionamento_id_approvvigionamento"

is_list.s_win_zoom 		= "w_approvvigionamento_ff"


end event

event ue_set_search;call super::ue_set_search;
long		ll_id_articolo,ll_row

ll_row			= tab_1.tabpage_1.dw_articolo_gen_ff.GetRow()
ll_id_articolo	= tab_1.tabpage_1.dw_articolo_gen_ff.GetItemNumber( ll_row,"id_articolo" )

choose case as_nomecol
	case "cod_sog_commerciale"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 	
		is_ricpar.s_filter_value = as_valcol 						
		is_ricpar.s_filter_name = "codice" 							
		is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo = 'F'"
				
	case "rag_sog_commerciale"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 	
		is_ricpar.s_filter_value = as_valcol 						
		is_ricpar.s_filter_name = "rag_soc_1" 						
		is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo = 'F'"
		
	case "cod_unita_confezione"
		is_search_window = "w_unita_confezione_coddes_sw" 		
		is_ricpar.s_filter_value = as_valcol 						
		is_ricpar.s_filter_name = "unita_confezione_codice" 	
		is_ricpar.s_sql_cond = "unita_confezione.id_articolo = " + string(ll_id_articolo)
end choose


end event

event ue_use_search;
choose case as_nomecol	
	case "cod_sog_commerciale"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("rag_sog_commerciale", is_ricpar.s_ausil_value[1])
		uf_set_colval("approvvigionamento_id_sog_commerciale", is_ricpar.s_id_seg_value[1])
		
	case "rag_sog_commerciale"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("cod_sog_commerciale", is_ricpar.s_ausil_value[1])
		uf_set_colval("approvvigionamento_id_sog_commerciale", is_ricpar.s_id_seg_value[1])
		
	case "cod_unita_confezione"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("approvvigionamento_id_unita_confezione", is_ricpar.s_id_seg_value[1])
		
end choose

wf_ultimo_costo()
end event

event ue_retrieve;call super::ue_retrieve;
end event

type tabpage_list_generici from userobject within tab_1
integer x = 18
integer y = 104
integer width = 2738
integer height = 1448
long backcolor = 79741120
string text = "Listini Generici"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_listino_var_base_articolo_lt dw_listino_var_base_articolo_lt
end type

on tabpage_list_generici.create
this.dw_listino_var_base_articolo_lt=create dw_listino_var_base_articolo_lt
this.Control[]={this.dw_listino_var_base_articolo_lt}
end on

on tabpage_list_generici.destroy
destroy(this.dw_listino_var_base_articolo_lt)
end on

type dw_listino_var_base_articolo_lt from u_dw_master_main within tabpage_list_generici
integer y = 20
integer width = 2720
integer height = 1332
integer taborder = 32
string dataobject = "d_listino_var_base_art_gd"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event ue_init;call super::ue_init;is_title = "Listini"
is_list.s_identifica[1] = "id_articolo"
is_resp_window = "w_listino_var_articolo_cx"
is_list.s_win_chiave[1] = "id_articolo"
is_list.s_win_chiave[2] = "id_listino"
is_list.s_par_name[1] = "id_articolo"
end event

event ue_insert;

string 			old_s_win_chiave[], new_s_win_chiave[], ls_filter, ls_colname, ls_colval, ls_value
s_list_main 	lstr_for_win
long 				ll_id_articolo[], ll_row, ll_parrow, ll_nonfare
integer			li_size, li_counter, li_start_point
s_rit_wp			lstr_rit
w_p_data			lw_win
dwitemstatus   ldwis_1


if IsValid(iudw_parent) then
	
	
	ll_parRow = iudw_Parent.GetRow()
	if (ll_parRow>0) then
		if iudw_parent.AcceptText() >0 then
			ldwis_1 = iudw_Parent.GetItemStatus(ll_ParRow,0,Primary!)
			CHOOSE CASE ldwis_1
				CASE New!
					MessageBox(iudw_parent.is_title,"Non ci sono dati!")
					ll_nonfare = 99
					iudw_parent.SetFocus()
				CASE NewModified!
					lw_win = u_freddie.iw_current
					ll_nonfare = lw_win.idw_master.event ue_update (0,0)
				CASE DataModified!
					ll_nonfare = 0
				CASE NotModified!
					ll_nonfare = 0
				CASE ELSE
					ll_nonfare = 0
			END CHOOSE
		else
			ll_nonfare = 99
			iudw_parent.SetFocus()
		end if
	else
		ll_nonfare = 99
	end if

end if
if ll_nonfare = 0 then
		
	ll_row = iudw_parent.GetRow()
	ll_id_articolo[1] = iudw_parent.GetItemNumber(ll_row, "id_articolo")
	
	
	
	
	
	
	old_s_win_chiave = is_list.s_win_chiave
	new_s_win_chiave[1] = "id_articolo"
	is_list.s_win_chiave = new_s_win_chiave
	
	
	lstr_for_win.s_modo = modo_modifica
	lstr_for_win.s_identifica = is_list.s_win_chiave 
	lstr_for_win.l_identifica = ll_id_articolo
	lstr_for_win.s_par_name = is_list.s_par_name
	lstr_for_win.s_par_value = is_list.s_par_value
	
	
	OpenWithParm(iw_support, lstr_for_win, "w_articolo_prezzo_cx") 
	
	
	
	
	
	
	ls_filter = ""
	lstr_rit = Message.PowerObjectParm
	li_size = UpperBound(lstr_rit.s_identifica)
	for  li_counter = 1 to li_size
		ls_colname = lstr_rit.s_identifica[li_counter]
		ls_colval = string(lstr_rit.l_identifica[li_counter])
		ls_filter = ls_filter + " AND " + ls_colname + " = " + ls_colval
	next
	
	ls_filter = Mid(ls_filter,5)
	
		
	
	if ls_filter <> "" then
		TriggerEvent("ue_retrieve")
	
		if (RowCount()>0) then
			selectrow(1,true)
		end if
		ll_row = Find( ls_filter, 1, RowCount( ))
		ScrollToRow(ll_row)
	end if
	
	
	
	
	is_list.s_win_chiave = old_s_win_chiave
	
		
end if


if ll_nonfare = 0 then triggerevent("ue_initial")


end event

event ue_update;

RETURN 0
end event

event ue_delete;

RETURN 0
end event

event ue_key;call super::ue_key;
end event

event retrieveend;call super::retrieveend;
end event

type cb_locazione from commandbutton within w_articolo_cx
integer x = 777
integer y = 32
integer width = 302
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Locazioni P."
end type

event clicked;long ll_riga_corrente, ll_id_articolo
ll_riga_corrente=tab_1.tabpage_1.dw_articolo_gen_ff.getrow()
ll_id_articolo=tab_1.tabpage_1.dw_articolo_gen_ff.getitemnumber(ll_riga_corrente, "id_articolo")
if ll_id_articolo> 0 then
	openwithparm(w_locazioni_predefinite_tb, ll_id_articolo)
end if
end event

type cb_1 from commandbutton within w_articolo_cx
integer x = 1102
integer y = 32
integer width = 320
integer height = 84
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Distinta Base"
end type

event clicked;s_list_main ls_list_distinta
long ll_articolo,ll_id_dis
ll_articolo=tab_1.tabpage_1.dw_articolo_gen_ff.getitemnumber(1,"id_articolo")
select id_distinta
into :ll_id_dis
from distinta
where id_articolo=:ll_articolo;
if sqlca.sqlcode=0 then
	ls_list_distinta.s_modo = modo_modifica
	ls_list_distinta.s_SQL_ident[1] = "distinta.id_distinta"
	ls_list_distinta.s_identifica[1]="id_distinta"
	ls_list_distinta.l_identifica[1]=ll_id_dis
	OpenSheetWithParm( w_distinta_base_cx, ls_list_distinta,w_app_frame, 2, Original!)
	setfocus(w_distinta_base_cx)
elseif ll_articolo>0 then
		ls_list_distinta.s_identifica[1]="id_articolo"
		ls_list_distinta.l_identifica[1]=ll_articolo
		OpenSheetWithParm( w_distinta_base_cx, ls_list_distinta,w_app_frame, 2, Original!)
		setfocus(w_distinta_base_cx)
else
	messagebox("Informazione!","Non è stato selezionato nessun articolo o non è stato salvato!") 
end if

end event

type cb_varianti from commandbutton within w_articolo_cx
integer x = 2560
integer y = 132
integer width = 229
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Varianti"
end type

event clicked;
long ll_id_cat_codifica, ll_id_scomposizione,ll_rigcorrente, ll_num_sez, ll_id_art
string ls_codice
integer li_lunghezza
ll_rigcorrente=tab_1.tabpage_1.dw_articolo_gen_ff.getrow()
ll_id_cat_codifica=tab_1.tabpage_1.dw_articolo_gen_ff.getitemnumber(1, "id_cat_codifica")
ls_codice=tab_1.tabpage_1.dw_articolo_gen_ff.getitemstring(ll_rigcorrente, "codice")
ll_id_art=tab_1.tabpage_1.dw_articolo_gen_ff.getitemnumber(ll_rigcorrente, "id_articolo")
if isnull(ll_id_cat_codifica) or Isnull(ls_codice) or IsNull(ll_id_art) then return
ls_codice=f_trova_varianti(ll_id_cat_codifica, ls_codice)


ls_codice=ls_codice+'?0?'+string(ll_id_art)
openwithparm(w_variante_gd, ls_codice)
ll_id_cat_codifica=message.doubleparm
if ll_id_cat_codifica<=0 or isnull(ll_id_cat_codifica) then return
idw_master.is_list.s_modo = modo_modifica
	idw_master.is_list.s_identifica[1] = "id_articolo"
	idw_master.is_list.l_identifica[1] = ll_id_cat_codifica
	idw_master.Event ue_retrieve(0, 0)
	tab_1.tabpage_1.dw_articolo_gen_ff.TriggerEvent("ue_prepare_codice")
end event

type cb_duplica from commandbutton within w_articolo_cx
integer x = 2309
integer y = 32
integer width = 229
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Duplica"
end type

event clicked;uf_ricerca()

long ll_riga_corrente, ll_null, ll_id_articolo, ll_id_uconf, ll_row, ll_id_cod_barre
string ls_immagine, ls_null
ll_riga_corrente=tab_1.tabpage_1.dw_articolo_gen_ff.getrow()
ls_immagine=tab_1.tabpage_1.dw_articolo_gen_ff.getitemstring(ll_riga_corrente, "immagine")
if ls_immagine<>"" and not isnull(ls_immagine) then
	uf_mostra_immagine(ls_immagine)
end if



setnull(ll_null)
ls_null=""

tab_1.tabpage_1.dw_articolo_gen_ff.setitem(1,"id_articolo",ll_null)
tab_1.tabpage_1.dw_articolo_gen_ff.setitem(1,"codice",ls_null)
tab_1.tabpage_1.dw_articolo_gen_ff.setitem(1,"c_codice_1",ls_null)
tab_1.tabpage_1.dw_articolo_gen_ff.setitem(1,"c_codice_2",ls_null)
tab_1.tabpage_1.dw_articolo_gen_ff.setitem(1,"c_codice_3",ls_null)
tab_1.tabpage_1.dw_articolo_gen_ff.setitem(1,"c_codice_4",ls_null)
tab_1.tabpage_1.dw_articolo_gen_ff.setitem(1,"c_codice_5",ls_null)
tab_1.tabpage_1.dw_articolo_gen_ff.setitem(1,"c_codice_6",ls_null)
tab_1.tabpage_1.dw_articolo_gen_ff.setitem(1,"c_codice_7",ls_null)
tab_1.tabpage_1.dw_articolo_gen_ff.setitem(1,"c_codice_8",ls_null)
tab_1.tabpage_1.dw_articolo_gen_ff.setitem(1,"c_codice_9",ls_null)
tab_1.tabpage_1.dw_articolo_gen_ff.setitemstatus(1,0,primary!,newmodified!)


end event

