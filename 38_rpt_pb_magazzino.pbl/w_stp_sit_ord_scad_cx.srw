forward
global type w_stp_sit_ord_scad_cx from w_wiz_main
end type
type cb_ok from commandbutton within w_stp_sit_ord_scad_cx
end type
type cb_annulla from commandbutton within w_stp_sit_ord_scad_cx
end type
type dw_1 from u_dw_ext_main within w_stp_sit_ord_scad_cx
end type
end forward

global type w_stp_sit_ord_scad_cx from w_wiz_main
int Width=2642
int Height=1168
WindowType WindowType=response!
boolean TitleBar=true
string Title="Stampa situazione scadenze ordini"
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
cb_ok cb_ok
cb_annulla cb_annulla
dw_1 dw_1
end type
global w_stp_sit_ord_scad_cx w_stp_sit_ord_scad_cx

type variables
date		id_data_registrazione
s_con_effetti	istr_struct
boolean		ib_feed_struct = FALSE

long il_id_esercizio
date il_data_da
date il_data_a
integer ii_tab_seq
integer ii_tab_seq_num
date il_data_da_esr
date il_data_a_esr
string is_tipo_reg

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

on w_stp_sit_ord_scad_cx.create
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

on w_stp_sit_ord_scad_cx.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.cb_annulla)
destroy(this.dw_1)
end on

event closequery;call super::closequery;

end event

event open;call super::open;String ls_cod_prof_ordine, ls_des_prof_ordine

dw_1.insertrow(1)

dw_1.setitem(1,"tipo_stampa",'S')

dw_1.object.da_articolo.visible=0
		dw_1.object.a_articolo.visible=0
		dw_1.object.da_articolo_des.visible=0
		dw_1.object.a_articolo_des.visible=0
		dw_1.object.da_articolo_sw.visible=0
		dw_1.object.a_articolo_sw.visible=0
		dw_1.object.da_articolo_des_sw.visible=0
		dw_1.object.a_articolo_des_sw.visible=0
		dw_1.object.da_articolo_t.visible=0
		dw_1.object.a_articolo_t.visible=0
		

SELECT codice, descrizione
INTO	 :ls_cod_prof_ordine, :ls_des_prof_ordine
FROM	 prof_documento
WHERE	 id_prof_documento = (SELECT id_prof_pref_ordini FROM par_sistema)
;

If Sqlca.Sqlcode = 0 Then
	dw_1.SetItem(1, "da_prof_doc", ls_cod_prof_ordine)
	dw_1.SetItem(1, "a_prof_doc", ls_cod_prof_ordine)
	dw_1.SetItem(1, "da_prof_doc_des", ls_des_prof_ordine)
	dw_1.SetItem(1, "a_prof_doc_des", ls_des_prof_ordine)
End If
	
end event

type cb_ok from commandbutton within w_stp_sit_ord_scad_cx
event clicked pbm_bnclicked
int X=2057
int Y=32
int Width=242
int Height=84
int TabOrder=20
boolean BringToTop=true
string Text="Stam&pa"
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
string 	ls_da_prof,ls_a_prof,ls_da_art,ls_a_art,ls_parametri
string 	ls_tipo,ls_filtro
date 		ld_da_data,ld_a_data

str_fil_flag str_param

dw_1.accepttext()
ls_da_prof=dw_1.getitemstring(1,"da_prof_doc")
ls_a_prof=dw_1.getitemstring(1,"a_prof_doc")
ls_da_art=dw_1.getitemstring(1,"da_articolo")
ls_a_art=dw_1.getitemstring(1,"a_articolo")
ld_da_data=dw_1.getitemdate(1,"da_data")
ld_a_data=dw_1.getitemdate(1,"a_data")
ls_tipo=dw_1.getitemstring(1,"tipo_stampa")
if ls_da_prof>ls_a_prof then
	messagebox("Stampa situazione ordini per scadenza","Il codice del profilo iniziale è maggiore di quello finale",exclamation!)
elseif ls_da_art>ls_a_art then
	messagebox("Stampa situazione ordini per scadenza","Il codice dell articolo iniziale è maggiore di quello finale",exclamation!)
else 
	
	if not isnull(ld_da_data) and ls_filtro='' then
		ls_filtro='scadenza_data_scadenza>=date("'+string(ld_da_data)+'")'
		ls_parametri='dal '+string(ld_da_data)
	elseif not isnull(ld_da_data) and ls_filtro<>'' then
		ls_filtro=ls_filtro+' and (scadenza_data_scadenza>=date("'+string(ld_da_data)+'"))'
		ls_parametri='dal '+string(ld_da_data)
	end if
	
	if not isnull(ld_a_data) and ls_filtro='' then
		ls_filtro='scadenza_data_scadenza<=date("'+string(ld_a_data)+'")'
		ls_parametri=ls_parametri+' al '+string(ld_da_data)
	elseif not isnull(ld_a_data) and ls_filtro<>'' then
		ls_filtro=ls_filtro+' and (scadenza_data_scadenza<=date("'+string(ld_a_data)+'"))'
		ls_parametri=ls_parametri+' al '+string(ld_da_data)
	end if

	
	if ls_da_prof<>''and ls_filtro='' then
		ls_filtro='prof_documento_codice>='+'"'+string(ls_da_prof)+'"'
		ls_parametri=ls_parametri+' - da profilo: '+ls_da_prof
	elseif ls_da_prof<>''and ls_filtro<>'' then
		ls_filtro=ls_filtro+' and (prof_documento_codice>='+'"'+string(ls_da_prof)+'"'+')'
		ls_parametri=ls_parametri+' - da profilo: '+ls_da_prof
	end if
	
	
	if ls_a_prof<>''and ls_filtro='' then
		ls_filtro='prof_documento_codice<='+'"'+string(ls_a_prof)+'"'
		ls_parametri=ls_parametri+' - a profilo: '+ls_a_prof
	elseif ls_a_prof<>''and ls_filtro<>'' then
		ls_filtro=ls_filtro+' and (prof_documento_codice<='+'"'+string(ls_a_prof)+'"'+')'
		ls_parametri=ls_parametri+' - a profilo: '+ls_a_prof
	end if

	
	if ls_da_art<>''and ls_filtro='' then
		ls_filtro='articolo_codice>='+'"'+string(ls_da_art)+'"'
		ls_parametri=ls_parametri+' - da articolo: '+ls_da_art
	elseif ls_da_art<>''and ls_filtro<>'' then
		ls_filtro=ls_filtro+' and (articolo_codice>='+'"'+string(ls_da_art)+'"'+')'
		ls_parametri=ls_parametri+' - da articolo: '+ls_da_art
	end if

	
	if ls_a_art<>''and ls_filtro='' then
		ls_filtro='articolo_codice<='+'"'+string(ls_a_art)+'"'
		ls_parametri=ls_parametri+' - a articolo: '+ls_a_art
	elseif ls_a_art<>''and ls_filtro<>'' then
		ls_filtro=ls_filtro+' and (articolo_codice<='+'"'+string(ls_a_art)+'"'+')'
	ls_parametri=ls_parametri+' - a articolo: '+ls_a_art
	end if

	str_param.filtro=ls_filtro
	str_param.parametri=ls_parametri
	
	choose case ls_tipo
		case 'S'
			openwithparm(w_stp_sit_ord_scad_sint_gd,str_param)
		case 'D'
			openwithparm(w_stp_sit_ord_scad_dett_gd,str_param)	
	end choose

end if


end event

type cb_annulla from commandbutton within w_stp_sit_ord_scad_cx
int X=2368
int Y=32
int Width=242
int Height=84
int TabOrder=30
boolean BringToTop=true
string Text="&Annulla"
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

type dw_1 from u_dw_ext_main within w_stp_sit_ord_scad_cx
event type integer ue_tipo_reg ( )
int X=27
int Y=152
int Width=2565
int Height=904
int TabOrder=10
string DataObject="d_sit_ord_scad_cx"
end type

event itemchanged;
string ls_tipo, ls_app
LONG LL_NULL
dw_1.accepttext()
integer li_ok

string ls_sql_cond
string ls_dbc[], ls_dwc[], ls_dbv[]
SETNULL(LL_NULL)

CHOOSE CASE dwo.name
	case "tipo_stampa"
		if data='S' then		
		dw_1.setITEM(1,"da_articolo",'')
		dw_1.setITEM(1,"da_articolo_des",'')
		dw_1.setITEM(1,"a_articolo",'')
		dw_1.setITEM(1,"a_articolo_des",'')
		dw_1.object.da_articolo.visible=0
		dw_1.object.a_articolo.visible=0
		dw_1.object.da_articolo_des.visible=0
		dw_1.object.a_articolo_des.visible=0
		dw_1.object.da_articolo_sw.visible=0
		dw_1.object.a_articolo_sw.visible=0
		dw_1.object.da_articolo_des_sw.visible=0
		dw_1.object.a_articolo_des_sw.visible=0
		dw_1.object.da_articolo_t.visible=0
		dw_1.object.a_articolo_t.visible=0
	else
		dw_1.object.da_articolo.visible=1
		dw_1.object.a_articolo.visible=1
		dw_1.object.da_articolo_des.visible=1
		dw_1.object.a_articolo_des.visible=1
		dw_1.object.da_articolo_sw.visible=1
		dw_1.object.a_articolo_sw.visible=1
		dw_1.object.da_articolo_des_sw.visible=1
		dw_1.object.a_articolo_des_sw.visible=1
		dw_1.object.da_articolo_t.visible=1
		dw_1.object.a_articolo_t.visible=1	
	end if
	
	case "da_prof_doc"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "da_prof_doc"
		ls_dwc[2] = "da_prof_doc_des"
		
		li_ok = uf_autofind_col(dwo.Name, "prof_documento", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
		
		

		IF (li_ok > 0) THEN
			if isnull(This.GetItemString(1, "a_prof_doc")) or This.GetItemString(1, "a_prof_doc")='' then 
		    this.setitem(1,"a_prof_doc",data)
          this.setitem(1,"a_prof_doc_des",This.GetItemString(1, "da_prof_doc_des"))
	      end if  
			RETURN 2
		END IF
		
	case "da_prof_doc_des"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "da_prof_doc"
		ls_dwc[2] = "da_prof_doc_des"
		
		li_ok = uf_autofind_col(dwo.Name, "prof_documento", "descrizione", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
		 
		IF (li_ok > 0) THEN
			if isnull(This.GetItemString(1, "a_prof_doc")) or This.GetItemString(1, "a_prof_doc")='' then 
		    this.setitem(1,"a_prof_doc",This.GetItemString(1, "da_prof_doc"))
          this.setitem(1,"a_prof_doc_des",data)
	      end if
			RETURN 2
		END IF
		
	case "a_prof_doc"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "a_prof_doc"
		ls_dwc[2] = "a_prof_doc_des"
		
		li_ok = uf_autofind_col(dwo.Name, "prof_documento", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
	case "a_prof_doc_des"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "a_prof_doc"
		ls_dwc[2] = "a_prof_cod_des"
		
		li_ok = uf_autofind_col(dwo.Name, "prof_documento", "descrizione", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
		
		case "da_articolo"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "da_articolo"
		ls_dwc[2] = "da_articolo_des"
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			if isnull(This.GetItemString(1, "a_articolo")) or This.GetItemString(1, "a_articolo")='' then 
		    this.setitem(1,"a_articolo_des",This.GetItemString(1, "da_articolo_des"))
          this.setitem(1,"a_articolo",data)
	      end if
			RETURN 2
		END IF
	case "a_articolo"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "a_articolo"
		ls_dwc[2] = "a_articolo_des"
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
		
		case "da_articolo_des"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "da_articolo"
		ls_dwc[2] = "da_articolo_des"
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "descrizione", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			if isnull(This.GetItemString(1, "a_articolo")) or This.GetItemString(1, "a_articolo")='' then 
		      this.setitem(1,"a_articolo_des",data)
            this.setitem(1,"a_articolo",This.GetItemString(1, "da_articolo"))
	      end if  
			RETURN 2
		END IF
		
		
	case "a_articolo_des"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "a_articolo"
		ls_dwc[2] = "a_articolo_des"
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "descrizione", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
		
		
		
end choose



end event

event itemfocuschanged;call super::itemfocuschanged;
end event

event ue_set_search;string ls_ragg


choose case as_nomecol
	case "da_prof_doc"
		is_search_window="W_prof_documento_coddes_sw"
		is_ricpar.s_filter_value=as_valcol
		is_ricpar.s_filter_name="prof_documento_codice"
	case "da_prof_doc_des" 
		is_search_window="W_prof_documento_coddes_sw"
		is_ricpar.s_filter_value=as_valcol
		is_ricpar.s_filter_name="prof_documento_descrizione"
	case "a_prof_doc"
		is_search_window="W_prof_documento_coddes_sw"
		is_ricpar.s_filter_value=as_valcol
		is_ricpar.s_filter_name="prof_documento_codice"	
	case "a_prof_doc_des" 
		is_search_window="W_prof_documento_coddes_sw"
		is_ricpar.s_filter_value=as_valcol
		is_ricpar.s_filter_name="prof_documento_descrizione"

	case "da_articolo","a_articolo"
		is_search_window="w_articolo_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="articolo_codice"		
	
   case "da_articolo_des","a_articolo_des"
		is_search_window="w_articolo_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="articolo_descrizione"
	     
	
end choose
end event

event ue_use_search;
choose case as_nomecol
		case "da_prof_doc"
		uf_set_colval(as_nomecol,is_ricpar.s_main_value)
		uf_set_colval("id_prof_documento",is_ricpar.s_id_seg_value[1])
		uf_set_colval("da_prof_doc_des",is_ricpar.s_ausil_value[1])
		if isnull(This.GetItemString(1, "a_prof_doc")) or This.GetItemString(1, "a_prof_doc")='' then 
		  uf_set_colval("a_prof_doc",is_ricpar.s_main_value)
		  uf_set_colval("a_prof_doc_des",is_ricpar.s_ausil_value[1])
	   end if  
	case "da_prof_doc_des"
		uf_set_colval(as_nomecol,is_ricpar.s_main_value)
		uf_set_colval("id_prof_documento",is_ricpar.s_id_seg_value[1])
		uf_set_colval("da_prof_doc",is_ricpar.s_ausil_value[1])
		if isnull(This.GetItemString(1, "a_prof_doc")) or This.GetItemString(1, "a_prof_doc")='' then 
		  uf_set_colval("a_prof_doc_des",is_ricpar.s_main_value)
		  uf_set_colval("a_prof_doc",is_ricpar.s_ausil_value[1])
	   end if  
	case "a_prof_doc"
		uf_set_colval(as_nomecol,is_ricpar.s_main_value)
		uf_set_colval("id_prof_documento",is_ricpar.s_id_seg_value[1])
		uf_set_colval("a_prof_doc_des",is_ricpar.s_ausil_value[1])
	case "a_prof_doc_des"
		uf_set_colval(as_nomecol,is_ricpar.s_main_value)
		uf_set_colval("id_prof_documento",is_ricpar.s_id_seg_value[1])
		uf_set_colval("a_prof_doc",is_ricpar.s_ausil_value[1])
		
		
	case "da_articolo"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_articolo",is_ricpar.s_id_seg_value[1])
			uf_set_colval("da_articolo_des",is_ricpar.s_ausil_value[1])
			if isnull(This.GetItemString(1, "a_articolo")) or This.GetItemString(1, "a_articolo")='' then 
			  uf_set_colval("a_articolo",is_ricpar.s_main_value)
			  uf_set_colval("a_articolo_des",is_ricpar.s_ausil_value[1])
		   end if  
			 
	case "da_articolo_des"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_articolo",is_ricpar.s_id_seg_value[1])
			uf_set_colval("da_articolo",is_ricpar.s_ausil_value[1])
			if isnull(This.GetItemString(1, "a_articolo")) or This.GetItemString(1, "a_articolo")='' then 
			   uf_set_colval("a_articolo_des",is_ricpar.s_main_value)
			   uf_set_colval("a_articolo",is_ricpar.s_ausil_value[1])
			end if	
	case "a_articolo"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_articolo",is_ricpar.s_id_seg_value[1])
			uf_set_colval("a_articolo_des",is_ricpar.s_ausil_value[1])		
	case "a_articolo_des"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_articolo",is_ricpar.s_id_seg_value[1])
			uf_set_colval("a_articolo",is_ricpar.s_ausil_value[1])
			
	end choose
end event

