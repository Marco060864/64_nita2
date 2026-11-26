forward
global type w_segui_produzione_st from w_wiz_main
end type
type cb_ok from commandbutton within w_segui_produzione_st
end type
type cb_annulla from commandbutton within w_segui_produzione_st
end type
type dw_1 from u_dw_ext_main within w_segui_produzione_st
end type
end forward

global type w_segui_produzione_st from w_wiz_main
integer width = 2999
integer height = 888
string title = "Step Produzione"
cb_ok cb_ok
cb_annulla cb_annulla
dw_1 dw_1
end type
global w_segui_produzione_st w_segui_produzione_st

type variables

end variables

forward prototypes
public function string uf_controlla_dati ()
public function date uf_prossimo_mese (readonly date data_attuale)
public subroutine wf_setta_a_titolo (integer ai_flag)
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

on w_segui_produzione_st.create
int iCurrent
call super::create
this.cb_ok=create cb_ok
this.cb_annulla=create cb_annulla
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ok
this.Control[iCurrent+2]=this.cb_annulla
this.Control[iCurrent+3]=this.dw_1
end on

on w_segui_produzione_st.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.cb_annulla)
destroy(this.dw_1)
end on

event closequery;

end event

event open;call super::open;datawindowchild ldw_da_cat_merceologica, ldw_a_cat_merceologica, ldw_data_inizio_es, ldw_locazione
datawindowchild ldw_da_titolo, ldw_a_titolo, ldw_valuta, ldw_cliente
date ldt_data_inzio
LONG LL_ID_VAL
String ls_par 



dw_1.getchild("da_cod_sog_comm", ldw_cliente)
ldw_cliente.settransobject(sqlca)
ldw_cliente.retrieve()

dw_1.getchild("valuta",ldw_valuta)
ldw_valuta.settransobject(sqlca)
ldw_valuta.retrieve()


dw_1.getchild("ll_magazzino",ldw_locazione)
ldw_locazione.settransobject(sqlca)
ldw_locazione.retrieve()

dw_1.getchild("da_titolo",ldw_da_titolo)
ldw_da_titolo.settransobject(sqlca)
ldw_da_titolo.retrieve()
dw_1.getchild("a_titolo",ldw_a_titolo)
ldw_a_titolo.settransobject(sqlca)
ldw_a_titolo.retrieve()

dw_1.getchild("da_cod_cat",ldw_da_cat_merceologica)
ldw_da_cat_merceologica.settransobject(sqlca)
ldw_da_cat_merceologica.retrieve()
dw_1.getchild("a_cod_cat",ldw_a_cat_merceologica)
ldw_a_cat_merceologica.settransobject(sqlca)
ldw_a_cat_merceologica.retrieve()

dw_1.getchild("da_des_cat",ldw_da_cat_merceologica)
ldw_da_cat_merceologica.settransobject(sqlca)
ldw_da_cat_merceologica.retrieve()

dw_1.getchild("a_des_cat",ldw_a_cat_merceologica)
ldw_a_cat_merceologica.settransobject(sqlca)
ldw_a_cat_merceologica.retrieve()

dw_1.getchild("data_inizio_esercizio",ldw_data_inizio_es)
ldw_data_inizio_es.settransobject(sqlca)
ldw_data_inizio_es.retrieve()

dw_1.insertrow(1)

long ll_riga
date ld_data
ld_data=today()
ll_riga=dw_1.getrow()
dw_1.setitem(ll_riga, "a_data", ld_data)
select data_inizio, ID_VALUTA
into :ldt_data_inzio, :LL_ID_VAL
from esercizio e, azienda a
where e.id_esercizio=a.id_esercizio_proposto
and a.id_azienda=1;
if sqlca.sqlcode=0 then
	dw_1.setitem(1, "data_inizio_esercizio", ldt_data_inzio)	
	dw_1.setitem(1, "da_data", ldt_data_inzio)
	DW_1.SETITEM(1, "VALUTA", LL_ID_VAL)
	DW_1.SETITEM(1, "CAMBIO", 1)
else
	messagebox("Errore!", "Esercizio non recuperato: confronta esercizio proposto in dati azienda")
end if








end event

event ue_post_open;call super::ue_post_open;//dw_1.setitem(1, "ll_magazzino", 28)
end event

type cb_ok from commandbutton within w_segui_produzione_st
event clicked pbm_bnclicked
integer x = 2354
integer y = 28
integer width = 338
integer height = 108
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Stampa"
boolean cancel = true
end type

event clicked;
date ldt_inizio_es

string ls_da_cod_sog_comm, ls_a_cod_sog_comm, ls_parametri, ls_cod_magazzino
string ls_a_articolo, ls_da_articolo, ls_a_categoria, ls_da_categoria, ls_totali_doc
date ld_da_data,ld_a_data
long ll_id_ordine[], i, ll_id_ord_ok[], a
string ls_ordine,ls_tipo_reg
s_param_articoli str_param
dw_1.accepttext()

ls_da_cod_sog_comm=dw_1.getitemstring(1,"da_cod_sog_comm")
//ls_a_cod_sog_comm=dw_1.getitemstring(1,"a_cod_sog_comm")
//if ls_da_cod_sog_comm>ls_a_cod_sog_comm or (isnull(ls_da_cod_sog_comm) and ls_a_cod_sog_comm>'') then
//	messagebox("Attenzione!", "Sog. Com. iniziale maggiore di quello finale!")
//	return
//end if
ls_parametri=dw_1.getitemstring(1, "st_art_sog")

if ls_da_cod_sog_comm>'' then ls_parametri=ls_parametri+'Da Codice Sog. Com: ' + ls_da_cod_sog_comm + " "
if ls_a_cod_sog_comm>'' then ls_parametri=ls_parametri+' A Codice Sog. Com: ' + ls_a_cod_sog_comm+ " "

ls_da_articolo=dw_1.getitemstring(1,"da_cod_articolo")
ls_a_articolo=dw_1.getitemstring(1,"a_cod_articolo")

if ls_da_articolo>'' then ls_parametri=ls_parametri+'Da Articolo: ' + ls_da_articolo + " "
if ls_a_articolo>'' then ls_parametri=ls_parametri+'Ad Articolo: ' + ls_a_articolo + " "

if ls_da_articolo>ls_a_articolo or (isnull(ls_da_articolo) and ls_a_articolo>'') then
	messagebox("Attenzione!", "Articolo iniziale maggiore di quello finale!")
	return
end if

ld_da_data=dw_1.getitemdate(1,"da_data")
ld_a_data=dw_1.getitemdate(1,"a_data")
if string(ld_da_data)>'' then ls_parametri=ls_parametri+'Da Data: ' + string(ld_da_data) + " "
if string(ld_a_data)>'' then ls_parametri=ls_parametri+'A Data: ' + string(ld_a_data) + " "



If (IsNull(ld_da_data) or IsNull(ld_a_data)) then
	MessageBox("Stampa movimenti partitari","Le date di inizio e fine sono obbligatorie",exclamation!)
	Return
End If
If ld_da_data > ld_a_data then
	MessageBox("Stampa movimenti partitari","La data iniziale è maggiore di quella finale",exclamation!)
	Return
End If


str_param.tipo_stampa=dw_1.getitemstring(1, "tipo_stampa")
if isnull(str_param.tipo_stampa) then str_param.tipo_stampa='d_segui_produzione_rpt'
if str_param.tipo_stampa='d_segui_produzione_rpt' then
	ls_tipo_reg='OV'
else
	ls_tipo_reg='GV'
end if
ls_ordine=dw_1.getitemstring(1, "num_ordine")

if ls_ordine>" " then
		ls_ordine=ls_ordine+"%"

		declare c_trova_ordini cursor for  
		select id_documento
				from dba.documento d, registro r
		where num_documento like :ls_ordine
		//and data_documento>=:ld_da_data
		//and data_documento<=:ld_a_data
		and r.tipo_registro=:ls_tipo_reg
		and d.id_registro=r.id_registro
		;
		open c_trova_ordini;
		
		do 
			i++
		 	fetch c_trova_ordini into :ll_id_ordine[i];
			if ll_id_ordine[i]>0 then
				a++
				ll_id_ord_ok[a]=ll_id_ordine[i]
			end if
		loop while sqlca.sqlcode=0 
		close c_trova_ordini;
	end if
str_param.li_titolo=ll_id_ord_ok

str_param.solo_preziosi=dw_1.getitemstring(1, "solo_preziosi")
str_param.da_data=ld_da_data
str_param.a_data=ld_a_data
str_param.da_cod_art=ls_da_articolo
str_param.a_cod_art=ls_a_articolo
str_param.da_CATEGORIA=ls_da_categoria
str_param.a_categoria = ls_a_categoria //è il num ordine lo passo per fare filtro
str_param.inizio_es=ldt_inizio_es
str_param.totali_doc=ls_totali_doc
str_param.da_sog_comm=ls_da_cod_sog_comm
str_param.a_sog_comm=ls_a_cod_sog_comm
str_param.li_fiscale=dw_1.getitemnumber(1, "fiscale")
if isnull(str_param.li_fiscale) then
	str_param.li_fiscale=0
end if
str_param.ll_magazzino=dw_1.getitemnumber(1, "ll_magazzino")
if isnull(str_param.ll_magazzino) then 
	str_param.ll_magazzino=0
else
	ls_cod_magazzino=dw_1.Describe("Evaluate('LookUpDisplay(ll_magazzino) ', " + "1" + ")")
	ls_parametri=ls_parametri+' Magazzino: ' + ls_cod_magazzino 
end if


str_param.cambio=dw_1.getitemdecimal(1, "cambio")
str_param.filtro=ls_parametri

OpenWithParm(w_segui_produzione_rpt, str_param)
end event

type cb_annulla from commandbutton within w_segui_produzione_st
integer x = 2725
integer y = 28
integer width = 210
integer height = 108
integer taborder = 30
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

type dw_1 from u_dw_ext_main within w_segui_produzione_st
event type integer ue_tipo_reg ( )
integer x = 23
integer y = 152
integer width = 2912
integer height = 568
integer taborder = 10
string dataobject = "d_SEGUI_PRODUZIONE"
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

event ue_set_search;string ls_sql_cond 
CHOOSE CASE as_nomecol
		
	CASE "da_cod_articolo", "da_des_articolo"
		is_search_window = "w_articolo_coddes_per_silver_sw"
		IF as_nomecol = "da_cod_articolo" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "articolo_codice"
			
		ELSEIF as_nomecol = "da_des_articolo" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "articolo_descrizione"
		END IF
		is_ricpar.l_id_doc=dw_1.getitemnumber(1, "ll_magazzino")
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

