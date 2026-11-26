forward
global type w_art_par_cx from w_p_data
end type
type dw_articolo_gen_ff from u_dw_master_main within tabpage_1
end type
type cb_codice from commandbutton within tabpage_1
end type
type dw_articolo_gen_ff from u_dw_master_main within tabpage_1
end type
type cb_codice from commandbutton within tabpage_1
end type
end forward

global type w_art_par_cx from w_p_data
int Width=2843
end type
global w_art_par_cx w_art_par_cx

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

end variables

forward prototypes
public function string wf_calc_progr (string as_parte[], s_cod_parte astr_cod_parte[], ref integer ai_num_parte, long al_id_cat_codifica)
public function integer uf_ricerca ()
public subroutine wf_propone_unita_confezione ()
end prototypes

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

public subroutine wf_propone_unita_confezione ();
Long	ll_unita_conf_base , ll_row

SELECT "par_sistema"."id_unita_conf_base"
INTO	:ll_unita_conf_base
FROM	par_sistema;

ll_row = Tab_1.TabPage_1.dw_articolo_gen_ff.GetRow()
Tab_1.TabPage_1.dw_articolo_gen_ff.SetItem(ll_row,'id_unita_conf_base',ll_unita_conf_base)

end subroutine

on w_art_par_cx.create
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
end on

on w_art_par_cx.destroy
call super::destroy
end on

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

il_old_variante = 1
il_old_cat_codifica = -1

string ls_rch

select rch
into :ls_rch
from pers_par_sistema;


end event

event ue_master_delete;
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

if (tab_1.tabpage_1.dw_articolo_gen_ff.getitemnumber(1, "id_articolo") > 0 ) then &
	tab_1.tabpage_1.cb_codice.enabled = true

end event

event closequery;
end event

type p_crescente from w_p_data`p_crescente within w_art_par_cx
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_art_par_cx
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_art_par_cx
boolean BringToTop=true
end type

event cb_ok::clicked;
end event

type cb_annulla from w_p_data`cb_annulla within w_art_par_cx
boolean BringToTop=true
end type

event cb_annulla::clicked;close(parent)
end event

type cb_nuovo from w_p_data`cb_nuovo within w_art_par_cx
boolean Visible=false
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_art_par_cx
int X=1915
boolean Visible=false
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_art_par_cx
int X=2213
boolean Visible=false
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_art_par_cx
int X=2510
boolean Visible=false
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_art_par_cx
int X=37
int Width=2725
boolean BringToTop=true
end type

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=18
int Y=104
int Width=2688
int Height=1200
long BackColor=80133307
string Text="Articolo"
long TabBackColor=80133307
dw_articolo_gen_ff dw_articolo_gen_ff
cb_codice cb_codice
end type

on tabpage_1.create
this.dw_articolo_gen_ff=create dw_articolo_gen_ff
this.cb_codice=create cb_codice
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_articolo_gen_ff
this.Control[iCurrent+2]=this.cb_codice
end on

on tabpage_1.destroy
call super::destroy
destroy(this.dw_articolo_gen_ff)
destroy(this.cb_codice)
end on

type cb_ricerca from w_p_data`cb_ricerca within w_art_par_cx
int X=2496
int Y=36
boolean BringToTop=true
end type

event cb_ricerca::clicked;
uf_ricerca()

long ll_riga_corrente
ll_riga_corrente=tab_1.tabpage_1.dw_articolo_gen_ff.getrow()

tab_1.tabpage_1.cb_codice.enabled = true
end event

type dw_articolo_gen_ff from u_dw_master_main within tabpage_1
event ue_load_codice ( )
event ue_prepare_codice ( )
event type string ue_prepare_parte ( s_cod_parte astr_cod_parte,  integer ai_nr_parte,  string as_cod_rimanente,  boolean ab_ultimo )
event ue_set_codice ( )
event type string ue_val_cod_parte ( integer al_nr_codice,  ref string as_err_message,  ref long al_err_code )
event ue_set_parte_progr ( )
event ue_reset ( )
event ue_setta_fuoco ( )
event ue_cod_cambiato ( )
int X=18
int Y=24
int Width=2638
int Height=876
int TabOrder=30
boolean BringToTop=true
string DataObject="d_art_par_gen_ff"
end type

event ue_prepare_codice;
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

event ue_prepare_parte;
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
	Modify("c_codice_" + String(ai_nr_parte) + ".width=" + String(ll_lunghezza * 41) )
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

event ue_val_cod_parte;
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

event ue_set_parte_progr;
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

event ue_reset;
integer 			li_size, li_counter
long 				ll_row
datawindow		ldw_item

li_size = UpperBound(iudw_children)
for li_counter = 1 to li_size
	ldw_item = iudw_children[li_counter]
	ldw_item.Reset()
next
end event

event ue_setta_fuoco;setcolumn("c_codice_1")
end event

event ue_cod_cambiato;ib_codice_modificato=true
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

event ue_init;call super::ue_init;window 	lw_parent
tab    	lw_tab


is_list.s_identifica[1] = "id_articolo"

lw_tab = Parent.GetParent()
lw_parent = lw_tab.GetParent()
is_title_modifica = lw_parent.Title

ib_control_save = false
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

event ue_validate_row;call super::ue_validate_row;
long 		ll_counter, ll_size, ll_row
string 	ls_codice
long 				ll_nr_row, ll_err_parte, ll_err_totali
string			ls_parte_codice, ls_err_message, ls_err_totale

ll_row= GetRow()
if ll_row> 0 then
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

event ue_update;
end event

type cb_codice from commandbutton within tabpage_1
int X=78
int Y=140
int Width=261
int Height=84
int TabOrder=30
boolean Enabled=false
boolean BringToTop=true
string Text="Codice..."
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
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
	OpenWithParm(w_cod_art_par_wz, lstr_array)
end if

end event

