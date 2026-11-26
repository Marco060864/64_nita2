forward
global type w_sog_com_articolo_rpt from w_wiz_main
end type
type cb_ok from commandbutton within w_sog_com_articolo_rpt
end type
type cb_annulla from commandbutton within w_sog_com_articolo_rpt
end type
type dw_1 from u_dw_ext_main within w_sog_com_articolo_rpt
end type
type cb_1 from commandbutton within w_sog_com_articolo_rpt
end type
type cb_2 from commandbutton within w_sog_com_articolo_rpt
end type
type cb_3 from commandbutton within w_sog_com_articolo_rpt
end type
type cb_4 from commandbutton within w_sog_com_articolo_rpt
end type
end forward

global type w_sog_com_articolo_rpt from w_wiz_main
int Width=2999
int Height=1292
WindowType WindowType=response!
boolean TitleBar=true
string Title="Scheda movimenti articoli/clienti"
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
cb_ok cb_ok
cb_annulla cb_annulla
dw_1 dw_1
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
cb_4 cb_4
end type
global w_sog_com_articolo_rpt w_sog_com_articolo_rpt

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

on w_sog_com_articolo_rpt.create
int iCurrent
call super::create
this.cb_ok=create cb_ok
this.cb_annulla=create cb_annulla
this.dw_1=create dw_1
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.cb_4=create cb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ok
this.Control[iCurrent+2]=this.cb_annulla
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.cb_2
this.Control[iCurrent+6]=this.cb_3
this.Control[iCurrent+7]=this.cb_4
end on

on w_sog_com_articolo_rpt.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.cb_annulla)
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.cb_4)
end on

event closequery;

end event

event open;call super::open;datawindowchild ldw_da_cat_merceologica, ldw_a_cat_merceologica

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


dw_1.insertrow(1)

long ll_riga
date ld_data
ld_data=today()
ll_riga=dw_1.getrow()
dw_1.setitem(ll_riga, "a_data", ld_data)
ld_data=relativedate(ld_data, -90)
dw_1.setitem(ll_riga, "da_data", ld_data)








end event

event ue_post_open;call super::ue_post_open;
end event

type cb_ok from commandbutton within w_sog_com_articolo_rpt
event clicked pbm_bnclicked
int X=50
int Y=28
int Width=421
int Height=108
int TabOrder=30
boolean BringToTop=true
string Text="Stampa per Clienti"
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
string ls_da_cod_sog_comm, ls_a_cod_sog_comm, ls_parametri, ls_filtro
date ld_da_data,ld_a_data
s_param_articoli str_param
dw_1.accepttext()
ls_da_cod_sog_comm=dw_1.getitemstring(1,"da_cod_sog_comm")
ls_a_cod_sog_comm=dw_1.getitemstring(1,"a_cod_sog_comm")
ld_da_data=dw_1.getitemdate(1,"da_data")
ld_a_data=dw_1.getitemdate(1,"a_data")
If (IsNull(ls_da_cod_sog_comm) or IsNull(ls_a_cod_sog_comm)) Then
	MessageBox("Stampa statistica ","I Soggetti commerciali di inizio e fine sono obbligatori",exclamation!)
	Return
End If

if ls_da_cod_sog_comm > ls_a_cod_sog_comm then
	MessageBox("Stampa statistica ","Il codice del sogg. commerciale iniziale è maggiore di quello finale",exclamation!)
	Return
End If	

If (IsNull(ld_da_data) or IsNull(ld_a_data)) then
	MessageBox("Stampa movimenti articoli","Le date di inizio e fine sono obbligatorie",exclamation!)
	Return
End If
If ld_da_data > ld_a_data then
	MessageBox("Stampa movimenti articoli","La data iniziale è maggiore di quella finale",exclamation!)
	Return
End If

ls_parametri='Da Codice Sog_Comm:' + ls_da_cod_sog_comm + ' A Codice Sog_Comm:' + ls_a_cod_sog_comm
if ls_da_cod_sog_comm <> '' and ls_filtro='' then
	ls_filtro="sog_commerciale_gen.codice>="+"'"+string(ls_da_cod_sog_comm)+"'"
	ls_parametri = ' Da Sog Comm:' + ls_da_cod_sog_comm
elseif ls_da_cod_sog_comm <> ''and ls_filtro<>'' then
	ls_filtro=ls_filtro+" AND (sog_commerciale_gen.codice>="+"'"+string(ls_da_cod_sog_comm)+"'"+")"
	ls_parametri = ' Da Sog Comm:' + ls_da_cod_sog_comm
end if
if ls_a_cod_sog_comm <> ''and ls_filtro='' then
	ls_filtro="sog_commerciale_gen.codice<="+"'"+string(ls_a_cod_sog_comm)+"'"
	ls_parametri = ' A Sog Comm:' + ls_a_cod_sog_comm 
elseif ls_a_cod_sog_comm <> ''and ls_filtro<>'' then
	ls_filtro=ls_filtro+" AND (sog_commerciale_gen.codice<="+"'"+string(ls_a_cod_sog_comm)+"'"+")"
	ls_parametri = ' A Sog Comm:' + ls_a_cod_sog_comm
end if




str_param.filtro=ls_filtro
str_param.da_data=ld_da_data
str_param.a_data=ld_a_data
str_param.da_sog_comm=ls_da_cod_sog_comm
str_param.a_sog_comm=ls_a_cod_sog_comm
OpenWithParm(w_stampa_mov_art, str_param)
end event

type cb_annulla from commandbutton within w_sog_com_articolo_rpt
int X=2747
int Y=28
int Width=192
int Height=108
int TabOrder=50
boolean BringToTop=true
string Text="&Esci"
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

type dw_1 from u_dw_ext_main within w_sog_com_articolo_rpt
event type integer ue_tipo_reg ( )
int X=27
int Y=160
int Width=2912
int Height=1012
int TabOrder=10
string DataObject="d_sog_comm_articolo"
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


	CASE "da_cod_cat", "da_des_cat"
		is_search_window = "w_articolo_coddes_sw"

		IF as_nomecol = "da_cod_cat" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "cat_merceologica_codice"
		ELSEIF as_nomecol = "da_des_cat" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "cat_merceologica_descrizione"
		END IF

		is_ricpar.b_imm_retrieve = TRUE
	CASE "a_cod_cat", "a_des_cat"
		is_search_window = "w_articolo_coddes_sw"

		IF as_nomecol = "a_cod_cat" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "cat_merceologica_codice"
		ELSEIF as_nomecol = "a_des_cat" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "cat_merceologica_descrizione"
		END IF





END CHOOSE	
end event

event itemchanged;
integer li_ok

string ls_sql_cond
string ls_dbc[], ls_dwc[], ls_dbv[]

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
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "da_cod_cat"
		ls_dwc[2] = "da_des_cat"
		
		li_ok = uf_autofind_col(dwo.Name, "cat_merceologica", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			if isnull(This.GetItemString(1, "a_cod_cat")) or This.GetItemString(1, "a_cod_cat")='' then
          This.SetItem(1, "a_cod_cat", Data)			
          This.SetItem(1, "a_des_cat", This.GetItemString(1, "da_des_cat"))
	      end if
			RETURN 2
		END IF
		
		
	case "da_des_cat"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "da_cod_cat"
		ls_dwc[2] = "da_des_cat"
		
		li_ok = uf_autofind_col(dwo.Name, "cat_merceologica", "descrizione", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
		
		IF (li_ok > 0) THEN
			if isnull(This.GetItemString(1, "a_cod_cat")) or This.GetItemString(1, "a_cod_cat")='' then
		    This.SetItem(1, "a_des_cat", Data)			
          This.SetItem(1, "a_cod_cat", This.GetItemString(1, "da_cod_cat"))
	      end if
			RETURN 2
		END IF

	case "a_cod_cat"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "a_cod_cat"
		ls_dwc[2] = "a_des_cat"
		
		li_ok = uf_autofind_col(dwo.Name, "cat_merceologica", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

	
		IF (li_ok > 0) THEN
			RETURN 2
		END IF
	case "a_des_cat"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "a_cod_cat"
		ls_dwc[2] = "a_des_cat"
		
		li_ok = uf_autofind_col(dwo.Name, "cat_merceologica", "descrizione", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF

		
end choose

end event

event itemfocuschanged;call super::itemfocuschanged;string ls_da_cod, ls_da_des

CHOOSE CASE dwo.name
	CASE "da_cod_sog_comm"
		ls_da_cod = THIS.GetItemString(1, "da_cod_sog_comm")
		ls_da_des = THIS.GetItemString(1, "da_sog_comm_des")
		
		THIS.SetItem(1, "a_cod_sog_comm", ls_da_cod)
		THIS.SetItem(1, "a_sog_comm_des", ls_da_des)
		
END CHOOSE




end event

type cb_1 from commandbutton within w_sog_com_articolo_rpt
int X=1477
int Y=28
int Width=594
int Height=108
int TabOrder=60
boolean BringToTop=true
string Text="Stampa per Clienti/Articoli"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
string ls_da_cod_sog_comm, ls_a_cod_sog_comm, ls_parametri, ls_filtro
string ls_da_articolo, ls_a_articolo
date ld_da_data,ld_a_data
s_param_articoli  lst_passa_dati
dw_1.accepttext()
ls_da_cod_sog_comm=dw_1.getitemstring(1,"da_cod_sog_comm")
ls_a_cod_sog_comm=dw_1.getitemstring(1,"a_cod_sog_comm")
ls_a_articolo=dw_1.getitemstring(1,"a_cod_articolo")
ls_da_articolo=dw_1.getitemstring(1,"da_cod_articolo")
ld_da_data=dw_1.getitemdate(1,"da_data")
ld_a_data=dw_1.getitemdate(1,"a_data")
If (IsNull(ls_da_cod_sog_comm) or IsNull(ls_a_cod_sog_comm)) Then
	MessageBox("Stampa statistica ","I Soggetti commerciali di inizio e fine sono obbligatori",exclamation!)
	Return
End If

if ls_da_cod_sog_comm > ls_a_cod_sog_comm then
	MessageBox("Stampa statistica ","Il codice del sogg. commerciale iniziale è maggiore di quello finale",exclamation!)
	Return
End If	

if ls_da_articolo > ls_a_articolo then
	MessageBox("Stampa movimenti articoli ","L'articolo iniziale è maggiore di quello finale",exclamation!)
	Return
End If	
If (IsNull(ld_da_data) or IsNull(ld_a_data)) then
	MessageBox("Stampa movimenti articoli","Le date di inizio e fine sono obbligatorie",exclamation!)
	Return
End If
If ld_da_data > ld_a_data then
	MessageBox("Stampa movimenti articoli","La data iniziale è maggiore di quella finale",exclamation!)
	Return
End If

ls_parametri='Da Codice Sog_Comm:' + ls_da_cod_sog_comm + ' A Codice Sog_Comm:' + ls_a_cod_sog_comm
if ls_da_cod_sog_comm <> '' and ls_filtro='' then
	ls_filtro="sog_commerciale_gen.codice>="+"'"+string(ls_da_cod_sog_comm)+"'"
	ls_parametri = ' Da Sog Comm:' + ls_da_cod_sog_comm
elseif ls_da_cod_sog_comm <> ''and ls_filtro<>'' then
	ls_filtro=ls_filtro+" AND (sog_commerciale_gen.codice>="+"'"+string(ls_da_cod_sog_comm)+"'"+")"
	ls_parametri = ' Da Sog Comm:' + ls_da_cod_sog_comm
end if
if ls_a_cod_sog_comm <> ''and ls_filtro='' then
	ls_filtro="sog_commerciale_gen.codice<="+"'"+string(ls_a_cod_sog_comm)+"'"
	ls_parametri = ' A Sog Comm:' + ls_a_cod_sog_comm 
elseif ls_a_cod_sog_comm <> ''and ls_filtro<>'' then
	ls_filtro=ls_filtro+" AND (sog_commerciale_gen.codice<="+"'"+string(ls_a_cod_sog_comm)+"'"+")"
	ls_parametri = ' A Sog Comm:' + ls_a_cod_sog_comm
end if





lst_passa_dati.filtro=ls_filtro
lst_passa_dati.da_data=ld_da_data
lst_passa_dati.a_data=ld_a_data
lst_passa_dati.da_cod_art=ls_da_articolo
lst_passa_dati.a_cod_art=ls_a_articolo
lst_passa_dati.da_sog_comm=ls_da_cod_sog_comm
lst_passa_dati.a_sog_comm=ls_a_cod_sog_comm
OpenWithParm(w_sog_art_mov, lst_passa_dati)
end event

type cb_2 from commandbutton within w_sog_com_articolo_rpt
int X=489
int Y=28
int Width=443
int Height=108
int TabOrder=20
boolean BringToTop=true
string Text="Stampa per Articoli"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
string ls_da_cod_sog_comm, ls_a_cod_sog_comm, ls_parametri, ls_filtro
string ls_da_articolo, ls_a_articolo
date ld_da_data,ld_a_data
s_param_articoli str_param
dw_1.accepttext()

ls_da_articolo=dw_1.getitemstring(1,"da_cod_articolo")
ls_a_articolo=dw_1.getitemstring(1,"a_cod_articolo")
ld_da_data=dw_1.getitemdate(1,"da_data")
ld_a_data=dw_1.getitemdate(1,"a_data")
If (IsNull(ls_da_articolo) or IsNull(ls_a_articolo)) Then
	MessageBox("Stampa movimenti articoli ","Gli Articoli di inizio e fine sono obbligatori",exclamation!)
Return
End If	
if ls_da_articolo > ls_a_articolo then
	MessageBox("Stampa movimenti articoli ","L'articolo iniziale è maggiore di quello finale",exclamation!)
	Return
End If	
If (IsNull(ld_da_data) or IsNull(ld_a_data)) then
	MessageBox("Stampa movimenti articoli","Le date di inizio e fine sono obbligatorie",exclamation!)
	Return
End If
If ld_da_data > ld_a_data then
	MessageBox("Stampa movimenti articoli","La data iniziale è maggiore di quella finale",exclamation!)
	Return
End If
ls_parametri='Da Articolo:' + ls_da_articolo + ' A Articolo:' + ls_a_articolo



if ls_da_articolo <> '' and ls_filtro='' then
	ls_filtro="articolo.codice>="+"'"+string(ls_da_articolo)+"'"
	ls_parametri = ' Da Articolo:' + ls_da_articolo
elseif ls_da_articolo <> ''and ls_filtro<>'' then
	ls_filtro=ls_filtro+" AND (articolo.codice>="+"'"+string(ls_da_articolo)+"'"+")"
	ls_parametri = ' Da Articolo :' + ls_da_articolo
end if
if ls_a_articolo <> ''and ls_filtro='' then
	ls_filtro="articolo.codice<="+"'"+string(ls_a_articolo)+"'"
	ls_parametri = ' A Articolo :' + ls_a_articolo 
elseif ls_a_articolo <> ''and ls_filtro<>'' then
	ls_filtro=ls_filtro+" AND (articolo.codice<="+"'"+string(ls_a_articolo)+"'"+")"
	ls_parametri = ' A Articolo:' + ls_a_articolo
end if

str_param.filtro=ls_filtro
str_param.da_data=ld_da_data
str_param.a_data=ld_a_data
str_param.da_cod_art=ls_da_articolo
str_param.a_cod_art=ls_a_articolo
OpenWithParm(w_stampa_fatturato_articoli, str_param)







end event

type cb_3 from commandbutton within w_sog_com_articolo_rpt
int X=951
int Y=28
int Width=507
int Height=108
int TabOrder=40
boolean BringToTop=true
string Text="Stampa per Categoria"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
string ls_da_cod_sog_comm, ls_a_cod_sog_comm, ls_parametri, ls_filtro
string ls_da_categoria, ls_a_categoria

date ld_da_data,ld_a_data
s_param_articoli str_param

dw_1.accepttext()
ls_da_cod_sog_comm=dw_1.getitemstring(1,"da_cod_sog_comm")
ls_a_cod_sog_comm=dw_1.getitemstring(1,"a_cod_sog_comm")

ls_da_categoria=dw_1.getitemstring(1,"da_cod_cat")
ls_a_categoria=dw_1.getitemstring(1,"a_cod_cat")
ld_da_data=dw_1.getitemdate(1,"da_data")
ld_a_data=dw_1.getitemdate(1,"a_data")




If (IsNull(ld_da_data) or IsNull(ld_a_data)) then
	MessageBox("Stampa movimenti categorie merceologiche","Le date di inizio e fine sono obbligatorie",exclamation!)
	Return
End If

If ld_da_data > ld_a_data then
	MessageBox("Stampa movimenti articoli","La data iniziale è maggiore di quella finale",exclamation!)
	Return
End If

ls_parametri='Da Categoria merceologica:' + ls_da_categoria + ' A Categoria Merceologica:' + ls_a_categoria

ls_parametri='Da Codice Sog_Comm:' + ls_da_cod_sog_comm + ' A Codice Sog_Comm:' + ls_a_cod_sog_comm
if ls_da_cod_sog_comm <> '' and ls_filtro='' then
	ls_filtro="sog_commerciale_gen.codice>="+"'"+string(ls_da_cod_sog_comm)+"'"
	ls_parametri = ' Da Sog Comm:' + ls_da_cod_sog_comm
elseif ls_da_cod_sog_comm <> ''and ls_filtro<>'' then
	ls_filtro=ls_filtro+" AND (sog_commerciale_gen.codice>="+"'"+string(ls_da_cod_sog_comm)+"'"+")"
	ls_parametri = ' Da Sog Comm:' + ls_da_cod_sog_comm
end if
if ls_a_cod_sog_comm <> ''and ls_filtro='' then
	ls_filtro="sog_commerciale_gen.codice<="+"'"+string(ls_a_cod_sog_comm)+"'"
	ls_parametri = ' A Sog Comm:' + ls_a_cod_sog_comm 
elseif ls_a_cod_sog_comm <> ''and ls_filtro<>'' then
	ls_filtro=ls_filtro+" AND (sog_commerciale_gen.codice<="+"'"+string(ls_a_cod_sog_comm)+"'"+")"
	ls_parametri = ' A Sog Comm:' + ls_a_cod_sog_comm
end if


if ls_da_categoria <> '' and ls_filtro='' then
	ls_filtro="cat_merceologica.codice>="+"'"+string(ls_da_categoria)+"'"
	ls_parametri = ' Da Categoria Merceologica:' + ls_da_categoria
elseif ls_da_categoria <> ''and ls_filtro<>'' then
	ls_filtro=ls_filtro+" AND (cat_merceologica.codice>="+"'"+string(ls_da_categoria)+"'"+")"
	ls_parametri = ' Da Categoria Merceologica :' + ls_da_categoria
end if
if ls_a_categoria <> ''and ls_filtro='' then
	ls_filtro="cat_merceologica.codice<="+"'"+string(ls_a_categoria)+"'"
	ls_parametri = ' A Categoria Merceologica :' + ls_a_categoria
elseif ls_a_categoria <> ''and ls_filtro<>'' then
	ls_filtro=ls_filtro+" AND (cat_merceologica.codice<="+"'"+string(ls_a_categoria)+"'"+")"
	ls_parametri = ' A categoria Merceologica:' + ls_a_categoria
end if


str_param.filtro=ls_filtro
str_param.da_data=ld_da_data
str_param.a_data=ld_a_data
str_param.da_categoria=ls_da_categoria
str_param.a_categoria=ls_a_categoria

str_param.da_sog_comm=ls_da_cod_sog_comm
str_param.a_sog_comm=ls_a_cod_sog_comm

OpenWithParm(w_stampa_cat_merceologica, str_param)








end event

type cb_4 from commandbutton within w_sog_com_articolo_rpt
int X=2089
int Y=28
int Width=640
int Height=108
int TabOrder=40
boolean BringToTop=true
string Text="Stampa per Clienti/Categoria"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
string ls_da_cod_sog_comm, ls_a_cod_sog_comm, ls_parametri, ls_filtro
string ls_da_categoria, ls_a_categoria
date ld_da_data,ld_a_data
s_param_articoli  lst_passa_dati
dw_1.accepttext()
ls_da_cod_sog_comm=dw_1.getitemstring(1,"da_cod_sog_comm")
ls_a_cod_sog_comm=dw_1.getitemstring(1,"a_cod_sog_comm")
ls_a_categoria=dw_1.getitemstring(1,"a_cod_cat")
ls_da_categoria=dw_1.getitemstring(1,"da_cod_cat")
ld_da_data=dw_1.getitemdate(1,"da_data")
ld_a_data=dw_1.getitemdate(1,"a_data")
If (IsNull(ls_da_cod_sog_comm) or IsNull(ls_a_cod_sog_comm)) Then
	MessageBox("Stampa statistica ","I Soggetti commerciali di inizio e fine sono obbligatori",exclamation!)
	Return
End If

if ls_da_cod_sog_comm > ls_a_cod_sog_comm then
	MessageBox("Stampa statistica ","Il codice del sogg. commerciale iniziale è maggiore di quello finale",exclamation!)
	Return
End If	

if ls_da_categoria > ls_a_categoria then
	MessageBox("Stampa Categoria merceologica ","La categoria iniziale è maggiore di quello finale",exclamation!)
	Return
End If	
If (IsNull(ld_da_data) or IsNull(ld_a_data)) then
	MessageBox("Stampa Categoria merceologica","Le date di inizio e fine sono obbligatorie",exclamation!)
	Return
End If
If ld_da_data > ld_a_data then
	MessageBox("Stampa Categoria merceologica","La data iniziale è maggiore di quella finale",exclamation!)
	Return
End If


ls_parametri='Da Codice Sog_Comm:' + ls_da_cod_sog_comm + ' A Codice Sog_Comm:' + ls_a_cod_sog_comm
ls_parametri='Da Categoria merceologica:' + ls_da_categoria + ' A Categoria Merceologica:' + ls_a_categoria
if ls_da_cod_sog_comm <> '' and ls_filtro='' then
	ls_filtro="sog_commerciale_gen.codice>="+"'"+string(ls_da_cod_sog_comm)+"'"
	ls_parametri = ' Da Sog Comm:' + ls_da_cod_sog_comm
elseif ls_da_cod_sog_comm <> ''and ls_filtro<>'' then
	ls_filtro=ls_filtro+" AND (sog_commerciale_gen.codice>="+"'"+string(ls_da_cod_sog_comm)+"'"+")"
	ls_parametri = ' Da Sog Comm:' + ls_da_cod_sog_comm
end if
if ls_a_cod_sog_comm <> ''and ls_filtro='' then
	ls_filtro="sog_commerciale_gen.codice<="+"'"+string(ls_a_cod_sog_comm)+"'"
	ls_parametri = ' A Sog Comm:' + ls_a_cod_sog_comm 
elseif ls_a_cod_sog_comm <> ''and ls_filtro<>'' then
	ls_filtro=ls_filtro+" AND (sog_commerciale_gen.codice<="+"'"+string(ls_a_cod_sog_comm)+"'"+")"
	ls_parametri = ' A Sog Comm:' + ls_a_cod_sog_comm
end if

if ls_da_categoria <> '' and ls_filtro='' then
	ls_filtro="cat_merceologica.codice>="+"'"+string(ls_da_categoria)+"'"
	ls_parametri = ' Da Categoria Merceologica:' + ls_da_categoria
elseif ls_da_categoria <> ''and ls_filtro<>'' then
	ls_filtro=ls_filtro+" AND (cat_merceologica.codice>="+"'"+string(ls_da_categoria)+"'"+")"
	ls_parametri = ' Da Categoria Merceologica :' + ls_da_categoria
end if
if ls_a_categoria <> ''and ls_filtro='' then
	ls_filtro="cat_merceologica.codice<="+"'"+string(ls_a_categoria)+"'"
	ls_parametri = ' A Categoria Merceologica :' + ls_a_categoria
elseif ls_a_categoria <> ''and ls_filtro<>'' then
	ls_filtro=ls_filtro+" AND (cat_merceologica.codice<="+"'"+string(ls_a_categoria)+"'"+")"
	ls_parametri = ' A categoria Merceologica:' + ls_a_categoria
end if


lst_passa_dati.filtro=ls_filtro
lst_passa_dati.da_data=ld_da_data
lst_passa_dati.a_data=ld_a_data
lst_passa_dati.da_categoria=ls_da_categoria
lst_passa_dati.a_categoria=ls_a_categoria
lst_passa_dati.da_sog_comm=ls_da_cod_sog_comm
lst_passa_dati.a_sog_comm=ls_a_cod_sog_comm
OpenWithParm(w_stampa_cli_categoria, lst_passa_dati)
end event

