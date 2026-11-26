forward
global type w_ord_clfo_st from w_wiz_main
end type
type cb_ok from commandbutton within w_ord_clfo_st
end type
type cb_annulla from commandbutton within w_ord_clfo_st
end type
type dw_1 from u_dw_ext_main within w_ord_clfo_st
end type
end forward

global type w_ord_clfo_st from w_wiz_main
int Width=2999
int Height=1140
boolean TitleBar=true
string Title="Stampa Ordini in Scadenza"
long BackColor=80269524
cb_ok cb_ok
cb_annulla cb_annulla
dw_1 dw_1
end type
global w_ord_clfo_st w_ord_clfo_st

type variables

end variables

forward prototypes
public function string uf_controlla_dati ()
public function date uf_prossimo_mese (readonly date data_attuale)
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

on w_ord_clfo_st.create
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

on w_ord_clfo_st.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.cb_annulla)
destroy(this.dw_1)
end on

event closequery;

end event

event open;call super::open;datawindowchild ldw_da_cat_merceologica, ldw_a_cat_merceologica, ldw_data_inizio_es
date ldt_data_inzio

String ls_par 

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
select data_inizio
into :ldt_data_inzio
from esercizio e, azienda a
where e.id_esercizio=a.id_esercizio
and a.id_azienda=1;
if sqlca.sqlcode=0 then
	dw_1.setitem(1, "da_data", ldt_data_inzio)
else
	messagebox("Errore!", "Esercizio non recuperato: confronta esercizio corrente in dati azienda")
end if








end event

event ue_post_open;call super::ue_post_open;
end event

type cb_ok from commandbutton within w_ord_clfo_st
event clicked pbm_bnclicked
int X=2354
int Y=28
int Width=338
int Height=108
int TabOrder=20
boolean BringToTop=true
string Text="Stampa"
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
date ldt_inizio_es

string ls_da_cod_sog_comm, ls_a_cod_sog_comm
date ld_da_data,ld_a_data
s_param_articoli str_param
dw_1.accepttext()

ls_da_cod_sog_comm=dw_1.getitemstring(1,"da_sog_comm_des")
ls_a_cod_sog_comm=dw_1.getitemstring(1,"a_sog_comm_des")
if ls_da_cod_sog_comm>ls_a_cod_sog_comm or (isnull(ls_da_cod_sog_comm) and ls_a_cod_sog_comm>'') then
	messagebox("Attenzione!", "Sog. Com. iniziale maggiore di quello finale!")
	return
end if
if ls_da_cod_sog_comm > ls_a_cod_sog_comm then
	MessageBox("Stampa Ordini in Scadenza","Il codice del sogg. commerciale iniziale è maggiore di quello finale",exclamation!)
	Return
End If	

ld_da_data=dw_1.getitemdate(1,"da_data")
ld_a_data=dw_1.getitemdate(1,"a_data")

If (IsNull(ld_da_data) or IsNull(ld_a_data)) then
	MessageBox("Stampa Ordini in Scadenza","Le date di inizio e fine sono obbligatorie",exclamation!)
	Return
End If
If ld_da_data > ld_a_data then
	MessageBox("Stampa Ordini in Scadenza","La data iniziale è maggiore di quella finale",exclamation!)
	Return
End If

str_param.tipo_stampa=dw_1.getitemstring(1,"stampa_aghi")
if isnull(str_param.tipo_stampa) then str_param.tipo_stampa='OV'
str_param.da_data=ld_da_data
str_param.a_data=ld_a_data
str_param.da_sog_comm=ls_da_cod_sog_comm
str_param.a_sog_comm=ls_a_cod_sog_comm
str_param.da_cod_art=dw_1.getitemstring(1,"da_cod_articolo")
str_param.a_cod_art=dw_1.getitemstring(1,"a_cod_articolo")
str_param.legato_fino=dw_1.getitemstring(1,"tipo_stampa")
str_param.solo_preziosi=dw_1.getitemstring(1,"dettagliata")
str_param.da_categoria=dw_1.getitemstring(1,"nota")

OpenWithParm(w_ord_clfo_rpt, str_param)
end event

type cb_annulla from commandbutton within w_ord_clfo_st
int X=2725
int Y=28
int Width=210
int Height=108
int TabOrder=30
boolean BringToTop=true
string Text="&Chiudi"
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

Close(Parent)
end event

type dw_1 from u_dw_ext_main within w_ord_clfo_st
event type integer ue_tipo_reg ( )
int X=27
int Y=160
int Width=2912
int Height=820
int TabOrder=10
string DataObject="d_sel_ord_clfo"
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
		if is_ricpar.s_filter_name = "codice" then
			uf_set_colval(as_nomecol, is_ricpar.s_ausil_value[1])
   		uf_set_colval("da_cod_sog_comm", is_ricpar.s_main_value)
			if isnull(This.GetItemString(1, "a_cod_sog_comm")) or This.GetItemString(1, "a_cod_sog_comm")='' then
			  uf_set_colval("a_sog_comm_des", is_ricpar.s_ausil_value[1])
			  uf_set_colval("a_cod_sog_comm", is_ricpar.s_main_value)
			end if  
		else
			uf_set_colval(as_nomecol, is_ricpar.s_main_value)
   		uf_set_colval("da_cod_sog_comm", is_ricpar.s_ausil_value[1])
			if isnull(This.GetItemString(1, "a_cod_sog_comm")) or This.GetItemString(1, "a_cod_sog_comm")='' then
			  uf_set_colval("a_sog_comm_des", is_ricpar.s_main_value)
			  uf_set_colval("a_cod_sog_comm", is_ricpar.s_ausil_value[1])
			end if  
		end if
		
		
	CASE "a_cod_sog_comm"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		
		uf_set_colval("a_sog_comm_des", is_ricpar.s_ausil_value[1])

	CASE "a_sog_comm_des"
		if is_ricpar.s_filter_name = "codice" then
			uf_set_colval(as_nomecol,is_ricpar.s_ausil_value[1] )
			uf_set_colval("a_cod_sog_comm", is_ricpar.s_main_value)
		else
			uf_set_colval(as_nomecol, is_ricpar.s_main_value)
			uf_set_colval("a_cod_sog_comm", is_ricpar.s_ausil_value[1])
		end if
			
	CASE "da_cod_articolo"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		
		uf_set_colval("da_des_articolo", is_ricpar.s_ausil_value[1])
		if isnull(This.GetItemString(1, "a_cod_articolo")) or This.GetItemString(1, "a_cod_articolo")='' then
		  uf_set_colval("a_cod_articolo", is_ricpar.s_main_value)
		  uf_set_colval("a_des_articolo", is_ricpar.s_ausil_value[1])
	   end if
		
		
	CASE "a_cod_articolo"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		
		uf_set_colval("a_des_articolo", is_ricpar.s_ausil_value[1])


END CHOOSE

end event

event ue_set_search;string ls_clfo

CHOOSE CASE as_nomecol
		
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
		
			
	CASE  "da_cod_sog_comm", "da_sog_comm_des"
		is_search_window = "w_sog_commerciale_gen_coddes_sw"

		IF as_nomecol = "da_cod_sog_comm" THEN
			is_ricpar.s_filter_value = as_valcol
			
			is_ricpar.s_filter_name = "codice"
		ELSEIF as_nomecol = "da_sog_comm_des" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "rag_soc_1"
		END IF
		if isnull(is_ricpar.s_filter_value) or is_ricpar.s_filter_value="" then
			
			ls_clfo=getitemstring(1, "stampa_aghi")
			if ls_clfo='OV' then
				select pref_cod_cliente
				into :ls_clfo
				from par_sistema;
			else
				select pref_cod_fornitore
				into :ls_clfo
				from par_sistema;
				
			end if
			is_ricpar.s_filter_name = "codice"
			is_ricpar.s_filter_value=ls_clfo
		end if
		
	CASE "a_cod_sog_comm", "a_sog_comm_des"
		is_search_window = "w_sog_commerciale_gen_coddes_sw"

		IF as_nomecol = "a_cod_sog_comm" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "codice"
		ELSEIF as_nomecol = "a_sog_comm_des" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "rag_soc_1"
		END IF
		if isnull(is_ricpar.s_filter_value) or is_ricpar.s_filter_value="" then
			
			ls_clfo=getitemstring(1, "stampa_aghi")
			if ls_clfo='OV' then
				select pref_cod_cliente
				into :ls_clfo
				from par_sistema;
			else
				select pref_cod_fornitore
				into :ls_clfo
				from par_sistema;
				
			end if
			is_ricpar.s_filter_name = "codice"
			is_ricpar.s_filter_value=ls_clfo
		end if





END CHOOSE	
end event

event itemchanged;
integer li_ok

string ls_sql_cond, ls_nota
string ls_dbc[], ls_dwc[], ls_dbv[]

CHOOSE CASE dwo.name
	CASE "da_cod_articolo"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		
		ls_dwc[1] = "da_cod_articolo"
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "codice", "A", data, ls_sql_cond, 1, &
			ls_dbc, ls_dbv, ls_dwc)
			
		
	
	  
		IF (li_ok > 0) THEN
			if isnull(This.GetItemString(1, "a_cod_articolo")) or This.GetItemString(1, "a_cod_articolo")='' then
           This.SetItem(1, "a_cod_articolo", upper(Data))			
           
	      end if
			RETURN 2
		END IF


	case "a_cod_articolo"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
	
		
		ls_dwc[1] = "a_cod_articolo"
	
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "codice", "A", data, ls_sql_cond, 1, &
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
		if isnull(This.GetItemString(1, "a_cod_cat")) or This.GetItemString(1, "a_cod_cat")='' then
	         This.SetItem(1, "a_cod_cat", Data)			
	         
      end if
	case "da_des_cat"
		if isnull(This.GetItemString(1, "a_cod_cat")) or This.GetItemString(1, "a_cod_cat")='' then
		    This.SetItem(1, "a_des_cat", Data)			
	    
	      end if

CASE "dettagliata"
	if data='F' then
		LS_NOTA=dw_1.getitemstring(1, "stampa_aghi")
		if LS_NOTA='OV' then 
			LS_NOTA="OA"
			dw_1.setitem(1, "stampa_aghi", LS_NOTA)
		end if
		LS_NOTA="Vi preghiamo consegnare i seguenti ordini in scadenza entro e non oltre questa settimana:"
		dw_1.setitem(1, "nota", ls_nota)
	end if
end choose

end event

event itemfocuschanged;call super::itemfocuschanged;



end event

