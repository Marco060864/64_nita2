forward
global type w_statistiche_varie_st from w_wiz_main
end type
type cb_ok from commandbutton within w_statistiche_varie_st
end type
type cb_annulla from commandbutton within w_statistiche_varie_st
end type
type dw_1 from u_dw_ext_main within w_statistiche_varie_st
end type
type cb_seleziona from commandbutton within w_statistiche_varie_st
end type
type dw_2 from udw_figlia within w_statistiche_varie_st
end type
type cb_cancella from commandbutton within w_statistiche_varie_st
end type
type cb_inserisci from commandbutton within w_statistiche_varie_st
end type
type dw_zona from udw_figlia within w_statistiche_varie_st
end type
type st_1 from statictext within w_statistiche_varie_st
end type
type st_2 from statictext within w_statistiche_varie_st
end type
type dw_causali from udw_figlia within w_statistiche_varie_st
end type
end forward

global type w_statistiche_varie_st from w_wiz_main
integer x = 5
integer y = 388
integer width = 3035
integer height = 1480
string title = "Stampa Statistiche"
long backcolor = 80269524
string icon = "S:\pb\cometa.ico"
cb_ok cb_ok
cb_annulla cb_annulla
dw_1 dw_1
cb_seleziona cb_seleziona
dw_2 dw_2
cb_cancella cb_cancella
cb_inserisci cb_inserisci
dw_zona dw_zona
st_1 st_1
st_2 st_2
dw_causali dw_causali
end type
global w_statistiche_varie_st w_statistiche_varie_st

type variables
udw_figlia idw_corrente
end variables

forward prototypes
public function string uf_controlla_dati ()
public function date uf_prossimo_mese (readonly date data_attuale)
public subroutine wf_setta_a_titolo (integer ai_flag)
public subroutine wf_ricerca (long al_riga_corrente, string as_data)
public subroutine wf_def_lista ()
end prototypes

public function string uf_controlla_dati ();


string ls_tipo_registro,ls_flag_registri,ls_filtro,ls_flag_definitiva,ls_ret,ls_st_reg_iva,ls_st_reg2_iva
long ll_row,ll_n_registro
date ld_dalla_data,ld_alla_data

ll_row=dw_1.getrow()
ls_tipo_registro=dw_1.getitemstring(ll_row,"tipo_registro")
ld_dalla_data=dw_1.getitemdate(ll_row,"dalla_data")
ld_alla_data=dw_1.getitemdate(ll_row,"alla_data")
ls_flag_registri=dw_1.getitemstring(ll_row,"tutti_reg")
ll_n_registro=dw_1.getitemnumber(ll_row,"numero_registro")
ls_flag_definitiva=dw_1.getitemstring(ll_row,"elab_prova")




ls_ret='OK'
if ls_flag_registri='N' then
	
DECLARE ws_registri_iva_cur CURSOR FOR
  SELECT "ws_registri_iva"."st_reg_iva"  
    FROM "ws_registri_iva",   
           
   WHERE ( "ws_registri_iva"."tipo_registro" = :ls_tipo_registro ) and  
         ( "ws_registri_iva"."numero" = :ll_n_registro  ) and  
         ( "ws_registri_iva"."data_registrazione" >= :ld_dalla_data  ) and  
         ( "ws_registri_iva"."data_registrazione" <= :ld_alla_data ); 
         

OPEN ws_registri_iva_cur;

FETCH ws_registri_iva_cur INTO :ls_st_reg_iva;

DO WHILE sqlca.sqlcode=0
	IF ls_st_reg_iva<>'N' THEN
	   ls_ret='KO'
   END IF
	FETCH ws_registri_iva_cur INTO :ls_st_reg_iva;
LOOP

CLOSE ws_registri_iva_cur;


DECLARE ws_registri2_iva_cur CURSOR FOR
  SELECT "ws_registri_iva"."st_reg_iva_a"  
    FROM "ws_registri_iva",   
           
   WHERE ( "ws_registri_iva"."tipo_registro" = :ls_tipo_registro ) and  
         ( "ws_registri_iva"."numero" = :ll_n_registro  ) and 
         ( "ws_registri_iva"."data_registrazione" >= :ld_dalla_data  ) and  
         ( "ws_registri_iva"."data_registrazione" <= :ld_alla_data ); 
         

OPEN ws_registri2_iva_cur ;

FETCH ws_registri2_iva_cur  INTO :ls_st_reg2_iva;

DO WHILE sqlca.sqlcode=0
	IF ls_st_reg2_iva<>'N' THEN
	   ls_ret='KO'
   END IF
	FETCH ws_registri2_iva_cur INTO :ls_st_reg2_iva;
LOOP

CLOSE ws_registri2_iva_cur;
return ls_ret
else
	
	
	
	
	
DECLARE ws_registri3_iva_cur CURSOR FOR
  SELECT "ws_registri_iva"."st_reg_iva"  
    FROM "ws_registri_iva",   
           
   WHERE ( "ws_registri_iva"."tipo_registro" = :ls_tipo_registro ) and  
         
         ( "ws_registri_iva"."data_registrazione" >= :ld_dalla_data  ) and  
         ( "ws_registri_iva"."data_registrazione" <= :ld_alla_data ); 
         

OPEN ws_registri3_iva_cur;

FETCH ws_registri3_iva_cur INTO :ls_st_reg_iva;

DO WHILE sqlca.sqlcode=0
	IF ls_st_reg_iva<>'N' THEN
	   ls_ret='KO'
   END IF
	FETCH ws_registri3_iva_cur INTO :ls_st_reg_iva;
LOOP

CLOSE ws_registri3_iva_cur;


DECLARE ws_registri4_iva_cur CURSOR FOR
  SELECT "ws_registri_iva"."st_reg_iva_a"  
    FROM "ws_registri_iva",   
           
   WHERE ( "ws_registri_iva"."tipo_registro" = :ls_tipo_registro ) and  
         
         ( "ws_registri_iva"."data_registrazione" >= :ld_dalla_data  ) and  
         ( "ws_registri_iva"."data_registrazione" <= :ld_alla_data ); 
         

OPEN ws_registri4_iva_cur ;

FETCH ws_registri4_iva_cur  INTO :ls_st_reg2_iva;

DO WHILE sqlca.sqlcode=0
	IF ls_st_reg2_iva<>'N' THEN
	   ls_ret='KO'
   END IF
	FETCH ws_registri2_iva_cur INTO :ls_st_reg2_iva;
LOOP

CLOSE ws_registri4_iva_cur;
return ls_ret
end if

end function

public function date uf_prossimo_mese (readonly date data_attuale);integer mese,anno,day,giorni_mese
date nuova_data
anno=year(data_attuale)
mese=month(data_attuale)
if mese=12 then
	mese=1
	anno=anno+1
else
mese=mese+1
end if
day=day(data_attuale)


giorni_mese=f_gmese(mese,anno)
if day>giorni_mese then
	day=giorni_mese
end if

nuova_data=date(string(day)+"/"+string(mese)+"/"+string(anno))
return nuova_data
end function

public subroutine wf_setta_a_titolo (integer ai_flag);string ls_da, ls_a
long ll_id_tit
ll_id_tit=dw_1.getitemnumber(1, "a_titolo")
if isnull(ll_id_tit) then
	ll_id_tit=dw_1.getitemnumber(1, "da_titolo")
	dw_1.setitem(1, "a_titolo", ll_id_tit)
end if

ls_a=dw_1.Describe("Evaluate('LookUpDisplay(a_titolo) ', " + "1" + ")")
ls_da=dw_1.Describe("Evaluate('LookUpDisplay(da_titolo) ', " + "1" + ")")

if ls_da> ls_a or left(ls_da, 2)<> left(ls_a, 2) then
	messagebox("Attenzione!", "Il titolo di inizio è maggiore di quello di fine~r~no si sono scelti due metalli diversi")
	setnull(ll_id_tit)
	if ai_flag=1 then
		dw_1.setitem(1, "da_titolo", ll_id_tit)
	else
		dw_1.setitem(1, "a_titolo", ll_id_tit)
	end if
end if
end subroutine

public subroutine wf_ricerca (long al_riga_corrente, string as_data);
s_ric_param ls_ric_param
w_search_main lw_sm
ls_ric_param.s_filter_value=as_data
ls_ric_param.s_filter_name="articolo_codice"
openwithparm(lw_sm,ls_ric_param,"w_articolo_coddes_sw")
ls_ric_param=message.powerobjectparm
if upperbound(ls_ric_param.s_id_seg_value)>0 then
	dw_2.post setitem(al_riga_corrente, "lista_art_key_id_articolo",long(ls_ric_param.s_id_seg_value[1]))
	dw_2.post setitem(al_riga_corrente,"articolo_codice", ls_ric_param.s_main_value)
	dw_2.post setitem(al_riga_corrente, "articolo_descrizione",ls_ric_param.s_ausil_value[1])
end if
end subroutine

public subroutine wf_def_lista ();long LL_ID_LISTA,ll_righe, i, ll_id_art

setpointer(hourglass!)

dw_2.accepttext()
SELECT ID_LISTA_articoli
INTO :LL_ID_LISTA
FROM LISTA_ART_DEF
where cod_lista_articoli='XXXX';
if sqlca.sqlcode<>0 then
	insert into LISTA_ART_DEF (cod_lista_articoli)
	values('XXXX');
	if sqlca.sqlcode=0 then
		commit;
		SELECT ID_LISTA_articoli
		INTO :LL_ID_LISTA
		FROM LISTA_ART_DEF
		where cod_lista_articoli='XXXX';
	else
		rollback;
		messagebox("Errore!", "Lista XXXX non inserita!")
		return
	end if
else
	delete lista_art_key
	where id_lista_articoli=:LL_ID_LISTA;
	if sqlca.sqlcode=0 then
		commit;
	else
		rollback;
		messagebox("Errore!", "Azzeramento Lista 0 non riuscito!")
		return
	end if
end if
ll_righe=dw_2.rowcount()
for i=1 to ll_righe
	ll_id_art=dw_2.getitemnumber(i, "lista_art_key_id_articolo")
	if ll_id_art>0 then
		insert into lista_art_key (id_lista_articoli, id_articolo)
		values(:LL_ID_LISTA, :ll_id_art);
	end if
next
if sqlca.sqlcode=0 then
	commit;
else
	rollback;
	messagebox("Errore!", "Inserimento lista non riuscito!")
	return
end if	
setpointer(arrow!)

end subroutine

on w_statistiche_varie_st.create
int iCurrent
call super::create
this.cb_ok=create cb_ok
this.cb_annulla=create cb_annulla
this.dw_1=create dw_1
this.cb_seleziona=create cb_seleziona
this.dw_2=create dw_2
this.cb_cancella=create cb_cancella
this.cb_inserisci=create cb_inserisci
this.dw_zona=create dw_zona
this.st_1=create st_1
this.st_2=create st_2
this.dw_causali=create dw_causali
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ok
this.Control[iCurrent+2]=this.cb_annulla
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.cb_seleziona
this.Control[iCurrent+5]=this.dw_2
this.Control[iCurrent+6]=this.cb_cancella
this.Control[iCurrent+7]=this.cb_inserisci
this.Control[iCurrent+8]=this.dw_zona
this.Control[iCurrent+9]=this.st_1
this.Control[iCurrent+10]=this.st_2
this.Control[iCurrent+11]=this.dw_causali
end on

on w_statistiche_varie_st.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.cb_annulla)
destroy(this.dw_1)
destroy(this.cb_seleziona)
destroy(this.dw_2)
destroy(this.cb_cancella)
destroy(this.cb_inserisci)
destroy(this.dw_zona)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.dw_causali)
end on

event closequery;

end event

event open;call super::open;DATE LDT_DATA_INIZIO

dw_1.settransobject(sqlca)
dw_zona.settransobject(sqlca)
dw_1.insertrow(1)
dw_causali.settransobject(sqlca)
IDW_CORRENTE=dw_2

SELECT DATA_INIZIO
into :LDT_DATA_INIZIO
from esercizio e, azienda a
where a.id_esercizio_proposto=e.id_esercizio
;
dw_1.setitem(1, "da_data", LDT_DATA_INIZIO)


end event

event ue_post_open;call super::ue_post_open;
end event

type cb_ok from commandbutton within w_statistiche_varie_st
event clicked pbm_bnclicked
integer x = 914
integer y = 828
integer width = 338
integer height = 108
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Stampa"
boolean cancel = true
end type

event clicked;Integer li_conta, i
string ls_da_cod_sog_comm, ls_a_cod_sog_comm, ls_parametri
date ld_da_data,ld_a_data
s_param_articoli str_param
dw_1.accepttext()
wf_def_lista()

ls_da_cod_sog_comm=dw_1.getitemstring(1,"da_cod_sog_comm")
ls_a_cod_sog_comm=dw_1.getitemstring(1,"a_cod_sog_comm")
if ls_da_cod_sog_comm>ls_a_cod_sog_comm or (isnull(ls_da_cod_sog_comm) and ls_a_cod_sog_comm>'') then
	messagebox("Attenzione!", "Sog. Com. iniziale maggiore di quello finale!")
	return
end if

if ls_da_cod_sog_comm>'' then ls_parametri=ls_parametri+'Da Codice Sog. Com: ' + ls_da_cod_sog_comm + " "
if ls_a_cod_sog_comm>'' then ls_parametri=ls_parametri+' A Codice Sog. Com: ' + ls_a_cod_sog_comm+ " "

ld_da_data=dw_1.getitemdate(1,"da_data")
ld_a_data=dw_1.getitemdate(1,"a_data")
if string(ld_da_data)>'' then ls_parametri=ls_parametri+'Da Data: ' + string(ld_da_data) + " "
if string(ld_a_data)>'' then ls_parametri=ls_parametri+'A Data: ' + string(ld_a_data) + " "

if ls_da_cod_sog_comm > ls_a_cod_sog_comm then
	MessageBox("Stampa statistica ","Il codice del sogg. commerciale iniziale è maggiore di quello finale",exclamation!)
	Return
End If	

If (IsNull(ld_da_data) or IsNull(ld_a_data)) then
	MessageBox("Stampa statistica","Le date di inizio e fine sono obbligatorie",exclamation!)
	Return
End If
If ld_da_data > ld_a_data then
	MessageBox("Stampa Statistiche","La data iniziale è maggiore di quella finale",exclamation!)
	Return
End If
str_param.da_data=ld_da_data
str_param.a_data=ld_a_data
//magazzino è in realtà il profilo doc!!!
str_param.ll_magazzino=dw_1.getitemnumber(1, "id_profilo")
str_param.da_sog_comm=ls_da_cod_sog_comm
str_param.a_sog_comm=ls_a_cod_sog_comm
str_param.tipo_stampa=dw_1.getitemstring(1, "dw")

str_param.ordinamento=dw_1.getitemstring(1, "or")

li_conta=dw_zona.rowcount()
for i=1 to li_conta
	str_param.li_titolo[i]=dw_zona.getitemnumber(i, "id_cat_zona")
next
//qui "solo preziosi" sta per "tipo_registro"!!!!
str_param.solo_preziosi=dw_1.getitemstring(1, "tipo_registro")


str_param.filtro=ls_parametri

OpenWithParm(w_statistiche_varie_rpt, str_param)
end event

type cb_annulla from commandbutton within w_statistiche_varie_st
integer x = 914
integer y = 956
integer width = 338
integer height = 108
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Chiudi"
boolean cancel = true
end type

event clicked;

Close(Parent)
end event

type dw_1 from u_dw_ext_main within w_statistiche_varie_st
event type integer ue_tipo_reg ( )
integer x = 23
integer y = 24
integer width = 2912
integer height = 400
integer taborder = 10
string dataobject = "d_statistiche_varie"
end type

event ue_use_search;CHOOSE CASE as_nomecol


			
	CASE "da_cod_sog_comm"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		
		uf_set_colval("da_sog_comm_des", is_ricpar.s_ausil_value[1])
		if isnull(This.GetItemString(1, "a_cod_sog_comm")) or This.GetItemString(1, "a_cod_sog_comm")='' then
		  uf_set_colval("a_cod_sog_comm", is_ricpar.s_main_value)
		  uf_set_colval("a_sog_comm_des", is_ricpar.s_ausil_value[1])
	   end if  
		
	CASE "da_sog_comm_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
   	
		uf_set_colval("da_cod_sog_comm", is_ricpar.s_ausil_value[1])
		if isnull(This.GetItemString(1, "a_cod_sog_comm")) or This.GetItemString(1, "a_cod_sog_comm")='' then
		  uf_set_colval("a_sog_comm_des", is_ricpar.s_main_value)
		  uf_set_colval("a_cod_sog_comm", is_ricpar.s_ausil_value[1])
		end if  
		
	CASE "a_cod_sog_comm"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		
		uf_set_colval("a_sog_comm_des", is_ricpar.s_ausil_value[1])

	CASE "a_sog_comm_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		
		uf_set_colval("a_cod_sog_comm", is_ricpar.s_ausil_value[1])
	CASE "da_cod_articolo"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		
		uf_set_colval("da_des_articolo", is_ricpar.s_ausil_value[1])
		if isnull(This.GetItemString(1, "a_cod_articolo")) or This.GetItemString(1, "a_cod_articolo")='' then
		  uf_set_colval("a_cod_articolo", is_ricpar.s_main_value)
		  uf_set_colval("a_des_articolo", is_ricpar.s_ausil_value[1])
	   end if
		
	CASE "da_des_articolo"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
   	
		uf_set_colval("da_cod_articolo", is_ricpar.s_ausil_value[1])
		if isnull(This.GetItemString(1, "a_cod_articolo")) or This.GetItemString(1, "a_cod_articolo")='' then
		  uf_set_colval("a_des_articolo", is_ricpar.s_main_value)
		  uf_set_colval("a_cod_articolo", is_ricpar.s_ausil_value[1])
	   end if
		
	CASE "a_cod_articolo"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		
		uf_set_colval("a_des_articolo", is_ricpar.s_ausil_value[1])

	CASE "a_des_articolo"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		
		uf_set_colval("a_cod_articolo", is_ricpar.s_ausil_value[1])

	CASE "da_cod_cat"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		
		uf_set_colval("da_des_cat", is_ricpar.s_ausil_value[1])
		if isnull(This.GetItemString(1, "a_cod_cat")) or This.GetItemString(1, "a_cod_cat")='' then
		  uf_set_colval("a_cod_cat", is_ricpar.s_main_value)
		  uf_set_colval("a_des_cat", is_ricpar.s_ausil_value[1])
	   end if
		
	CASE "da_des_cat"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
   	
		uf_set_colval("da_cod_cat", is_ricpar.s_ausil_value[1])
		if isnull(This.GetItemString(1, "a_cod_cat")) or This.GetItemString(1, "a_cod_cat")='' then
		  uf_set_colval("a_des_cat", is_ricpar.s_main_value)
		  uf_set_colval("a_cod_cat", is_ricpar.s_ausil_value[1])
	   end if
		
	CASE "a_cod_cat"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		
		uf_set_colval("a_des_cat", is_ricpar.s_ausil_value[1])

	CASE "a_des_cat"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		
		uf_set_colval("a_cod_cat", is_ricpar.s_ausil_value[1])


END CHOOSE

end event

event ue_set_search;CHOOSE CASE as_nomecol
		
	CASE "da_cod_articolo", "da_des_articolo"
		is_search_window = "w_articolo_coddes_sw"

		IF as_nomecol = "da_cod_articolo" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "articolo_codice"
		ELSEIF as_nomecol = "da_des_articolo" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "articolo_descrizione"
		END IF

		is_ricpar.b_imm_retrieve = TRUE
	CASE "a_cod_articolo", "a_des_articolo"
		is_search_window = "w_articolo_coddes_sw"

		IF as_nomecol = "a_cod_articolo" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "articolo_codice"
		ELSEIF as_nomecol = "a_des_articolo" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "articolo_descrizione"
		END IF
		
			
	CASE "da_cod_sog_comm", "da_sog_comm_des"
		is_search_window = "w_sog_commerciale_gen_coddes_sw"

		IF as_nomecol = "da_cod_sog_comm" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "codice"
		ELSEIF as_nomecol = "da_sog_comm_des" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "rag_soc_1"
		END IF

	CASE "a_cod_sog_comm", "a_sog_comm_des"
		is_search_window = "w_sog_commerciale_gen_coddes_sw"

		IF as_nomecol = "a_cod_sog_comm" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "codice"
		ELSEIF as_nomecol = "a_sog_comm_des" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "rag_soc_1"
		END IF






END CHOOSE	
end event

event itemchanged;integer li_ok, li_null
long ll_id_titolo
string ls_sql_cond, ls_null
string ls_dbc[], ls_dwc[], ls_dbv[]
decimal ldc_cambio

CHOOSE CASE dwo.name
	CASE "da_cod_articolo"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "da_cod_articolo"
		ls_dwc[2] = "da_des_articolo"
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
			
		
	
	  
		IF (li_ok > 0) THEN
			if isnull(This.GetItemString(1, "a_cod_articolo")) or This.GetItemString(1, "a_cod_articolo")='' then
           This.SetItem(1, "a_cod_articolo", Data)			
           This.SetItem(1, "a_des_articolo", This.GetItemString(1, "da_des_articolo"))
	      end if
			RETURN 2
		END IF
		
		
	case "da_des_articolo"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "da_cod_articolo"
		ls_dwc[2] = "da_des_articolo"
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "descrizione", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc) 
		
		IF (li_ok > 0) THEN
			if isnull(This.GetItemString(1, "a_cod_articolo")) or This.GetItemString(1, "a_cod_articolo")='' then
		    This.SetItem(1, "a_des_articolo", Data)			
          This.SetItem(1, "a_cod_articolo", This.GetItemString(1, "da_cod_articolo"))
	      end if 
			RETURN 2
		END IF

	case "a_cod_articolo"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "a_cod_articolo"
		ls_dwc[2] = "a_des_articolo"
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

	
		IF (li_ok > 0) THEN
			RETURN 2
		END IF
	case "a_des_articolo"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "a_cod_articolo"
		ls_dwc[2] = "a_des_articolo"
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "descrizione", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF



		CASE "da_cod_sog_comm"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		
		ls_dwc[1] = "da_cod_sog_comm"
		ls_dwc[2] = "da_sog_comm_des"
		
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
			
		
	

		IF (li_ok > 0) THEN
			if isnull(This.GetItemString(1, "a_cod_sog_comm")) or This.GetItemString(1, "a_cod_sog_comm")='' then
           This.SetItem(1, "a_cod_sog_comm", Data)			
           This.SetItem(1, "a_sog_comm_des", This.GetItemString(1, "da_sog_comm_des"))
	      end if
			RETURN 2
		END IF
		
		
	case "da_sog_comm_des"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		
		ls_dwc[1] = "da_cod_sog_comm"
		ls_dwc[2] = "da_sog_comm_des"
		
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", "rag_soc_1", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
			
		IF (li_ok > 0) THEN
			if isnull(This.GetItemString(1, "a_cod_sog_comm")) or This.GetItemString(1, "a_cod_sog_comm")='' then
		    This.SetItem(1, "a_sog_comm_des", Data)			
          This.SetItem(1, "a_cod_sog_comm", This.GetItemString(1, "da_cod_sog_comm"))
	      end if
			RETURN 2
		END IF

	case "a_cod_sog_comm"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		
		ls_dwc[1] = "a_cod_sog_comm"
		ls_dwc[2] = "a_sog_comm_des"
		
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
	case "a_sog_comm_des"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		
		ls_dwc[1] = "a_cod_sog_comm"
		ls_dwc[2] = "a_sog_comm_des"
		
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", "rag_soc_1", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
			
		
		IF (li_ok > 0) THEN
			RETURN 2
		END IF
		
		
	CASE "da_cod_cat"
case "st_art_sog"
		setnull(ls_null)
		setnull(li_null)
		if data='A' or data='P' then
			setitem(row, "da_cod_sog_comm", ls_null)
			setitem(row, "a_cod_sog_comm", ls_null)
			setitem(row, "da_sog_comm_des", ls_null)
			setitem(row, "a_sog_comm_des", ls_null)
		elseif data='S' then
			setitem(row, "da_cod_articolo", ls_null)
			setitem(row, "a_cod_articolo", ls_null)
			setitem(row, "da_des_articolo", ls_null)
			setitem(row, "a_des_articolo", ls_null)
		end if
		
	case "valuta"
		ll_id_titolo=long(data)
		select cambio into :ldc_cambio
		from valuta
		where id_valuta=:ll_id_titolo
		;
		setitem(row, "cambio", ldc_cambio)
end choose

end event

event itemfocuschanged;call super::itemfocuschanged;



end event

type cb_seleziona from commandbutton within w_statistiche_varie_st
integer x = 914
integer y = 444
integer width = 338
integer height = 108
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Seleziona"
end type

event clicked;s_dw_ritorna st_p
long ll_righe
 
openwithparm(w_auto_aggiunta_cx, 0)
	
st_p=message.powerobjectparm
	
if isvalid(st_p) then
	ll_righe=dw_2.rowcount()+1
	if ll_righe<=0 then ll_righe=1
	st_p.ds.rowscopy(1, st_p.ds.rowcount(), primary!, dw_2, ll_righe, primary!)
end if
dw_2.sort()
	
end event

type dw_2 from udw_figlia within w_statistiche_varie_st
event ue_rbutton_dblclick pbm_rbuttondblclk
integer x = 1275
integer y = 444
integer width = 1655
integer height = 620
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_lista_art_key_gd"
end type

event clicked;string ls_data
if dwo.name="articolo_codice_sw" then
	ls_data=getitemstring(row, "articolo_codice")
	post wf_ricerca(row, ls_data)
end if


end event

event dw_2::itemchanged;st_ass_art_sottoclasse st_associa
IF DWO.NAME='articolo_codice' then
	select id_articolo, codice, descrizione
	into :st_associa.id_articolo, :st_associa.cod_articolo, :st_associa.des_articolo
	from articolo
	where codice=:data;
	if sqlca.sqlcode=0 then
		setitem(row, "lista_art_key_id_articolo", st_associa.id_articolo)
		setitem(row, "articolo_codice", st_associa.cod_articolo)
		setitem(row, "articolo_descrizione", st_associa.des_articolo)
	else
		wf_ricerca(row, data)
	end if
end if
		
end event

event rowfocuschanged;setrowfocusindicator(hand!)
end event

event updatestart;integer li_righe
li_righe=dw_2.rowcount()
if li_righe>0 then
	li_righe=dw_2.getitemnumber(li_righe, "esiste_doppio")
	if li_righe>0 then 
		dw_2.setfilter("art_doppi=1")
		dw_2.filter()
		for li_righe=dw_2.rowcount() to 1 step -1
			dw_2.deleterow(li_righe)
		next
		dw_2.setfilter("")
		dw_2.filter()
	end if
end if
end event

event ue_insert;
long ll_riga
ll_riga=this.insertrow(al_riga_precedente+1)
scrolltorow(ll_riga)
setitem(ll_riga, "lista_art_key_id_lista_articoli", 0)
post setcolumn(3)
post setfocus(this)
return ll_riga
end event

event ue_key;choose case key
	case keydelete!
		cb_cancella.triggerevent(clicked!)
	case Keyadd!
		if (keyFlags=2) then
			cb_inserisci.triggerevent(clicked!)
		end if

	case KeySubtract!
		if (keyFlags=2) then
			cb_cancella.triggerevent(clicked!)
		end if	
	case keytab!
     if getrow()=rowcount() and getcolumn()=4 then
		cb_inserisci.triggerevent(clicked!)
	end if

	
end choose
end event

event getfocus;call super::getfocus;idw_corrente=this
end event

type cb_cancella from commandbutton within w_statistiche_varie_st
integer x = 914
integer y = 700
integer width = 338
integer height = 108
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancella"
end type

event clicked;idw_corrente.trigger event ue_delete(idw_corrente.getrow())

end event

type cb_inserisci from commandbutton within w_statistiche_varie_st
integer x = 914
integer y = 572
integer width = 338
integer height = 108
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Inserisci"
end type

event clicked;idw_corrente.trigger event ue_insert(idw_corrente.getrow())
end event

type dw_zona from udw_figlia within w_statistiche_varie_st
integer x = 32
integer y = 516
integer width = 759
integer height = 540
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_scegli_zone"
end type

event ue_key;choose case key
	case keydelete!
		cb_cancella.triggerevent(clicked!)
	case Keyadd!
		if (keyFlags=2) then
			cb_inserisci.triggerevent(clicked!)
		end if

	case KeySubtract!
		if (keyFlags=2) then
			cb_cancella.triggerevent(clicked!)
		end if	
	case keytab!
     if getrow()=rowcount() and getcolumn()=4 then
		cb_inserisci.triggerevent(clicked!)
	end if

	
end choose
end event

event getfocus;call super::getfocus;idw_corrente=this
end event

type st_1 from statictext within w_statistiche_varie_st
integer x = 2619
integer y = 996
integer width = 297
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Lista: XXXX"
boolean focusrectangle = false
end type

type st_2 from statictext within w_statistiche_varie_st
integer x = 41
integer y = 444
integer width = 745
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "FILTRO PER ZONA"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_causali from udw_figlia within w_statistiche_varie_st
event ue_rbutton_dblclick pbm_rbuttondblclk
boolean visible = false
integer x = 32
integer y = 1076
integer width = 759
integer height = 408
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_lista_causali_gd"
end type

event clicked;string ls_data
if dwo.name="articolo_codice_sw" then
	ls_data=getitemstring(row, "articolo_codice")
	wf_ricerca(row, ls_data)
end if


end event

event getfocus;call super::getfocus;idw_corrente=this
end event

event ue_key;choose case key
	case keydelete!
		cb_cancella.triggerevent(clicked!)
	case Keyadd!
		if (keyFlags=2) then
			cb_inserisci.triggerevent(clicked!)
		end if

	case KeySubtract!
		if (keyFlags=2) then
			cb_cancella.triggerevent(clicked!)
		end if	
	case keytab!
     if getrow()=rowcount() and getcolumn()=4 then
		cb_inserisci.triggerevent(clicked!)
	end if

	
end choose
end event

