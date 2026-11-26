forward
global type w_trova_art_per_prezzo_man_st from w_wiz_main
end type
type cb_ok from commandbutton within w_trova_art_per_prezzo_man_st
end type
type cb_annulla from commandbutton within w_trova_art_per_prezzo_man_st
end type
type dw_1 from u_dw_ext_main within w_trova_art_per_prezzo_man_st
end type
end forward

global type w_trova_art_per_prezzo_man_st from w_wiz_main
integer y = 437
integer width = 2999
integer height = 1060
string title = "Stampa Controllo Pezzi Peso e Prezzi Fornitore"
cb_ok cb_ok
cb_annulla cb_annulla
dw_1 dw_1
end type
global w_trova_art_per_prezzo_man_st w_trova_art_per_prezzo_man_st

type variables
datawindowchild ldw_da_cat_merceologica
string is_sql_cond
end variables

forward prototypes
public function string uf_controlla_dati ()
public function date uf_prossimo_mese (readonly date data_attuale)
public subroutine wf_setta_a_titolo (integer ai_flag)
public subroutine wf_post_set (date ad_data, integer colonna)
public subroutine wf_carica_destinazione (string as_codice)
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

public subroutine wf_post_set (date ad_data, integer colonna);if colonna=1 then
	dw_1.setitem(1, "da_data", ad_data)
else
	dw_1.setitem(1, "a_data", ad_data)
end if
end subroutine

public subroutine wf_carica_destinazione (string as_codice);datawindowchild ldw_dest
long ll_id_sog

select id_sog_commerciale
into :ll_id_sog
from sog_commerciale
where codice=:as_codice
;

dw_1.getchild("ll_destinazione", ldw_dest)

ldw_dest.settransobject(sqlca)
ldw_dest.retrieve(ll_id_sog)

end subroutine

on w_trova_art_per_prezzo_man_st.create
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

on w_trova_art_per_prezzo_man_st.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.cb_annulla)
destroy(this.dw_1)
end on

event closequery;

end event

event open;call super::open;datawindowchild ldw_prof, ldw_tipo_reg, ldw_data_inizio_es
long ll_id_esercizio
date ld_da_data, ld_a_data
string ls_sql_cond

dw_1.getchild("prof_doc",ldw_prof)
ldw_prof.settransobject(sqlca)
ldw_prof.retrieve()

dw_1.getchild("data_inizio_esercizio",ldw_data_inizio_es)
ldw_data_inizio_es.settransobject(sqlca)
ldw_data_inizio_es.retrieve()

dw_1.getchild("tipo_reg",ldw_tipo_reg)
ldw_tipo_reg.settransobject(sqlca)
ldw_tipo_reg.retrieve()


dw_1.insertrow(1)



select data_inizio,data_fine, e.id_esercizio
into :ld_da_data,:ld_a_data, :ll_id_esercizio
from esercizio e, azienda a
where e.id_esercizio=a.id_esercizio
and a.id_azienda=1;
if sqlca.sqlcode=0 then
	dw_1.setitem(1, "data_inizio_esercizio", ll_id_esercizio)	
	dw_1.setitem(1, "da_data", ld_da_data)
	dw_1.setitem(1, "a_data", ld_a_data)
	is_sql_cond=ldw_da_cat_merceologica.getsqlselect()
	ls_sql_cond =is_sql_cond+ " and registro.id_esercizio = "+string(ll_id_esercizio)
	ldw_da_cat_merceologica.SetSqlSelect(ls_sql_cond)
	ldw_da_cat_merceologica.retrieve()	
else
	messagebox("Errore!", "Esercizio non recuperato: confronta esercizio corrente in dati azienda")
end if

//dw_2.settransobject(sqlca)



end event

event ue_post_open;call super::ue_post_open;
end event

type cb_ok from commandbutton within w_trova_art_per_prezzo_man_st
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
string ls_da_cod_sog_comm, ls_a_cod_sog_comm, ls_parametri, ls_a_categoria
string ls_a_art, ls_da_art, ls_tipo_stampa, ls_tipo_reg, ls_cod_ese
integer li_righe, i
date ld_da_data,ld_a_data, ldt_data_in,ldt_data_fine
s_param_articoli str_param
long ll_id_registro, ll_id_esercizio, ll_id_prof
dw_1.accepttext()
//dw_2.accepttext()

//ll_id_esercizio=dw_1.getitemnumber(1, "data_inizio_esercizio")
//select data_inizio,data_fine, codice 
//into :ldt_data_in, :ldt_data_fine, :ls_cod_ese 
//from esercizio 
//where id_esercizio=:ll_id_esercizio;



str_param.solo_preziosi=dw_1.getitemstring(1,"solo_preziosi")
ls_da_cod_sog_comm=dw_1.getitemstring(1,"da_cod_sog_comm")
//ls_a_cod_sog_comm=dw_1.getitemstring(1,"a_cod_sog_comm")
//if ls_da_cod_sog_comm>ls_a_cod_sog_comm or (isnull(ls_da_cod_sog_comm) and ls_a_cod_sog_comm>'') then
//	messagebox("Attenzione!", "Sog. Com. iniziale maggiore di quello finale!")
//	return
//end if
//
if ls_da_cod_sog_comm>'' then 
	ls_a_cod_sog_comm= dw_1.getitemstring(1, "da_sog_comm_des")
	ls_parametri=ls_parametri+'Fornitore: ' + ls_a_cod_sog_comm + " - "
end if
//if ls_a_cod_sog_comm>'' then ls_parametri=ls_parametri+' A Codice Sog. Com: ' + ls_a_cod_sog_comm+ " "

ls_da_art=dw_1.getitemstring(1,"da_cod_articolo")
ls_a_art=dw_1.getitemstring(1,"a_cod_articolo")

if ls_da_art>'' then ls_parametri=ls_parametri+'Da Articolo: ' + ls_da_art + " "
if ls_a_art>'' then ls_parametri=ls_parametri+'Ad articolo: ' + ls_a_art + " "

if ls_da_art>ls_a_art or (isnull(ls_da_art) and ls_a_art>'') then
	MessageBox("Stampa movimenti articoli","L'articolo iniziale è maggiore di quello finale",exclamation!)
	return
end if

ll_id_prof=dw_1.getitemnumber(1,"prof_doc")
if ll_id_prof>0 then
	select codice
	into :ls_a_categoria
	from dba.prof_documento
	where id_prof_documento=:ll_id_prof;
	
	ls_parametri=ls_parametri+'Profilo: ' +ls_a_categoria + " "
end if


ld_da_data=dw_1.getitemdate(1,"da_data")
ld_a_data=dw_1.getitemdate(1,"a_data")


if ld_a_data>ld_a_data then
	messagebox("Attenzione!", "La data inizio deve essere <= "+string(ld_a_data))
	ld_da_data=ld_a_data
end if
	
if string(ld_da_data)>'' then ls_parametri=ls_parametri+'Da Data: ' + string(ld_da_data) + " "
if string(ld_a_data)>'' then ls_parametri=ls_parametri+'A Data: ' + string(ld_a_data) + " "


//
str_param.da_categoria=dw_1.getitemstring(1,"num_documento")
if str_param.da_categoria> " " then
	ls_parametri=ls_parametri+" - Doc. Numero: "+str_param.da_categoria
end if
str_param.da_data=ld_da_data
str_param.a_data=ld_a_data
str_param.da_cod_art=ls_da_art
str_param.a_cod_art=ls_a_art
str_param.li_titolo[1]=ll_id_prof
str_param.da_sog_comm  =ls_da_cod_sog_comm
//str_param.li_titolo[3] = ll_id_registro
//str_param.solo_preziosi=ls_tipo_stampa
str_param.filtro=ls_parametri


OpenWithParm(w_trova_art_per_prezzo_man_rpt, str_param)
end event

type cb_annulla from commandbutton within w_trova_art_per_prezzo_man_st
integer x = 2725
integer y = 28
integer width = 210
integer height = 108
integer taborder = 50
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

type dw_1 from u_dw_ext_main within w_trova_art_per_prezzo_man_st
event type integer ue_tipo_reg ( )
integer y = 156
integer width = 2926
integer height = 640
integer taborder = 10
string dataobject = "d_trova_art_per_prezzo_st"
end type

event ue_use_search;CHOOSE CASE as_nomecol


			
	CASE "da_cod_sog_comm"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		
		uf_set_colval("da_sog_comm_des", is_ricpar.s_ausil_value[1])
		wf_carica_destinazione(is_ricpar.s_main_value)
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
long ll_id_titolo, ll_riga_inserita, ll_id_prof, ll_id_sog
string ls_sql_cond, ls_null
string ls_dbc[], ls_dwc[], ls_dbv[], ls_codice
date ldt_data_in, ldt_data_fine

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
			post wf_carica_destinazione(data)
			if isnull(This.GetItemString(1, "a_cod_sog_comm")) or This.GetItemString(1, "a_cod_sog_comm")='' then
           This.SetItem(1, "a_cod_sog_comm", Data)			
           This.SetItem(1, "a_sog_comm_des", This.GetItemString(1, "da_sog_comm_des"))
	      end if
			RETURN 2
		END IF
//		
//		
//		
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

//	case "a_cod_sog_comm"
//		ls_sql_cond = ""
//		
//		ls_dbc[1] = "codice"
//		ls_dbc[2] = "rag_soc_1"
//		
//		ls_dwc[1] = "a_cod_sog_comm"
//		ls_dwc[2] = "a_sog_comm_des"
//		
//		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", "codice", "A", data, ls_sql_cond, 2, &
//			ls_dbc, ls_dbv, ls_dwc)
//
//		IF (li_ok > 0) THEN
//			RETURN 2
//		END IF
//	case  "a_cod_sog_comm"
//		ls_sql_cond = ""
//		
//		ls_dbc[1] = "codice"
//		ls_dbc[2] = "rag_soc_1"
//		
//		ls_dwc[1] = "a_cod_sog_comm"
//		ls_dwc[2] = "a_sog_comm_des"
//		
//		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", "rag_soc_1", "A", data, ls_sql_cond, 2, &
//			ls_dbc, ls_dbv, ls_dwc)
//			
//		
//		IF (li_ok > 0) THEN
//			RETURN 2
//		END IF
//
//	
//		
//
//	case "da_cod_cat"
//		setnull(ls_null)
//		if data>'' then
//			setitem(row, "tipo_reg", ls_null)
//		end if
//	case "tipo_reg"
//			setnull(li_null)
//			if data>'' then
//				setitem(row, "da_cod_cat", li_null)
//			end if
//	case "data_inizio_esercizio"
//		ll_id_titolo=long(data)
//		select data_inizio, data_fine
//		into :ldt_data_in, :ldt_data_fine
//		from esercizio
//		where id_esercizio=:ll_id_titolo;
//		if sqlca.sqlcode=0 then
//			setitem(1, "da_data", ldt_data_in)
//			setitem(1, "a_data", ldt_data_fine)
//		else
//			messagebox("Errore!", "Esercizio scelto non recuperato")
//		end if
//		ls_sql_cond = is_sql_cond+" and registro.id_esercizio = "+string(ll_id_titolo)
//		ldw_da_cat_merceologica.SetSqlSelect(ls_sql_cond)
//		ldw_da_cat_merceologica.retrieve()			
//	case "solo_preziosi"
//		if data='C' or data='D' then
//			setnull(ls_null)
//			setnull(li_null)
//			setitem(row, "da_cod_cat", li_null)
//			setitem(row, "tipo_reg", ls_null)
//			object.da_cod_cat.protect=1
//			object.tipo_reg.protect=1
//		else
//			object.da_cod_cat.protect=0
//			object.tipo_reg.protect=0
//		end if
//		if data="B" or data="F" then
//			dw_2.visible=true
//			DECLARE trova_prof_fattura CURSOR FOR 
//			select distinct(p.id_PROF_DOCUMENTO)
//			FROM PROF_DOCUMENTO p, der_profilo d 
//			WHERE TIPO_REGISTRO='IV'
//			and d.id_prof_documento_derivato=p.id_prof_documento
//			;
//			OPEN trova_prof_fattura;
//			FETCH trova_prof_fattura INTO :ll_id_prof;
//			do while SQLCA.sqlcode = 0
//				ll_riga_inserita=dw_2.insertrow(0)
//				dw_2.setitem(ll_riga_inserita, "id_prof_derivato", ll_id_prof)
//				FETCH trova_prof_fattura INTO :ll_id_prof;
//			loop
//			CLOSE trova_prof_fattura;
//		else
//			dw_2.visible=false
//		end if
//	
end choose
end event

event itemfocuschanged;call super::itemfocuschanged;//date ldt_data_in, ldt_data_fine, ld_data
//long ll_id_esercizio
//
//choose case dwo.name
//case "da_data", "a_data"
//		ll_id_esercizio=getitemnumber(1, "data_inizio_esercizio")
//		select data_inizio,data_fine 
//		into :ldt_data_in, :ldt_data_fine 
//		from esercizio 
//		where id_esercizio=:ll_id_esercizio
//		;
//		if dwo.name="a_data" then
//			ld_data=getitemdate(1, "da_data")
//			if ld_data<ldt_data_in then
//				messagebox("Attenzione!", "La data di inizio deve essere >= a "+string(ldt_data_in))
//				setitem(1, "da_data", ldt_data_in)
//				
//				
//				return
//			end if
//		else
//			if ld_data>ldt_data_fine then
//				messagebox("Attenzione!", "La data di fine deve essere <= a "+string(ldt_data_fine))
//				post setitem(1, "a_data", ld_data)
//				return 
//			end if
//		end if
//
//end choose
//
end event

