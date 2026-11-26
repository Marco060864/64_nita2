forward
global type w_stp_fatt_zona_cx from w_wiz_main
end type
type cb_ok from commandbutton within w_stp_fatt_zona_cx
end type
type cb_annulla from commandbutton within w_stp_fatt_zona_cx
end type
type dw_1 from u_dw_ext_main within w_stp_fatt_zona_cx
end type
end forward

global type w_stp_fatt_zona_cx from w_wiz_main
int Width=2432
int Height=944
WindowType WindowType=response!
boolean TitleBar=true
string Title="Stampa fatture per zona"
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
cb_ok cb_ok
cb_annulla cb_annulla
dw_1 dw_1
end type
global w_stp_fatt_zona_cx w_stp_fatt_zona_cx

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

on w_stp_fatt_zona_cx.create
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

on w_stp_fatt_zona_cx.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.cb_annulla)
destroy(this.dw_1)
end on

event closequery;call super::closequery;

end event

event open;call super::open;dw_1.insertrow(1)
datawindowchild ldw_da_zona_cod,ldw_da_zona_des,ldw_a_zona_cod,ldw_a_zona_des
 
 
dw_1.getchild("da_zona",ldw_da_zona_cod)
dw_1.getchild("da_zona_des",ldw_da_zona_des)
dw_1.getchild("a_zona",ldw_a_zona_cod)
dw_1.getchild("a_zona_des",ldw_a_zona_des)

ldw_da_zona_cod.settransobject(sqlca)
ldw_da_zona_cod.retrieve()

ldw_da_zona_des.settransobject(sqlca)
ldw_da_zona_des.retrieve()
ldw_a_zona_cod.settransobject(sqlca)
ldw_a_zona_cod.retrieve()
ldw_a_zona_des.settransobject(sqlca)
ldw_a_zona_des.retrieve()

dw_1.setitem(1,"ragg",'C')



end event

type cb_ok from commandbutton within w_stp_fatt_zona_cx
event clicked pbm_bnclicked
int X=1865
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
string ls_da_zona,ls_a_zona,ls_da_cod,ls_a_cod
string ls_ragg,ls_filtro,ls_parametri
str_fil_flag str_param


dw_1.accepttext()
ls_da_zona=dw_1.getitemstring(1,"da_zona")
ls_a_zona=dw_1.getitemstring(1,"a_zona")
ls_da_cod=dw_1.getitemstring(1,"da_cod")
ls_a_cod=dw_1.getitemstring(1,"a_cod")
ls_ragg=dw_1.getitemstring(1,"ragg")
if ls_da_zona>ls_a_zona then
	messagebox("Stampa fatturato suddiviso per zona","Il codice della zona iniziale è maggiore di quello finale",exclamation!)
else 
if ls_da_cod>ls_a_cod then
	messagebox("Stampa fatturato suddiviso per zona","Il codice dell cliente/articolo iniziale è maggiore di quello finale",exclamation!)
else 


if ls_da_zona<>''and ls_filtro='' then
	ls_filtro='c_zona>='+'"'+string(ls_da_zona)+'"'
	ls_parametri='Da zona: '+ls_da_zona
else
if ls_da_zona<>''and ls_filtro<>'' then
	ls_filtro=ls_filtro+' and (c_zona>='+'"'+string(ls_da_zona)+'"'+')'
	ls_parametri=ls_parametri+'Da zona: '+ls_da_zona
end if
end if
if ls_a_zona<>''and ls_filtro='' then
	ls_filtro='c_zona<='+'"'+string(ls_a_zona)+'"'
	ls_parametri=ls_parametri+' A zona: '+ls_a_zona
else
if ls_a_zona<>''and ls_filtro<>'' then
	ls_filtro=ls_filtro+' and (c_zona<='+'"'+string(ls_a_zona)+'"'+')'
	ls_parametri=ls_parametri+' A zona: '+ls_a_zona
end if
end if
if ls_ragg='A'then
if ls_da_cod<>''and ls_filtro='' then
	ls_filtro='articolo_codice>='+'"'+string(ls_da_cod)+'"'
ls_parametri=ls_parametri+'- Da articolo: '+ls_da_cod
else
if ls_da_cod<>''and ls_filtro<>'' then
	ls_filtro=ls_filtro+' and (articolo_codice>='+'"'+string(ls_da_cod)+'"'+')'

	ls_parametri=ls_parametri+'- Da articolo: '+ls_da_cod
end if
end if

else
if ls_da_cod<>''and ls_filtro='' then
	ls_filtro='sog_commerciale_codice>='+'"'+string(ls_da_cod)+'"'
	ls_parametri=ls_parametri+'- Da Sogg.Commerciale: '+ls_da_cod
else
if ls_da_cod<>''and ls_filtro<>'' then
	ls_filtro=ls_filtro+' and (sog_commerciale_codice>='+'"'+string(ls_da_cod)+'"'+')'
	ls_parametri=ls_parametri+'- Da Sogg.Commerciale: '+ls_da_cod
end if
end if


end if
if ls_ragg='A' then
if ls_a_cod<>''and ls_filtro='' then
	ls_filtro='articolo_codice<='+'"'+string(ls_a_cod)+'"'
	ls_parametri=ls_parametri+'- A articolo: '+ls_a_cod
else
if ls_a_cod<>''and ls_filtro<>'' then
	ls_filtro=ls_filtro+' and (articolo_codice<='+'"'+string(ls_a_cod)+'"'+')'
	ls_parametri=ls_parametri+'- A articolo: '+ls_a_cod
end if
end if

else
	if ls_a_cod<>''and ls_filtro='' then
	ls_filtro='sog_commerciale_codice<='+'"'+string(ls_a_cod)+'"'
	ls_parametri=ls_parametri+'- A Sogg.Commerciale: '+ls_a_cod
else
if ls_a_cod<>''and ls_filtro<>'' then
	ls_filtro=ls_filtro+' and (sog_commerciale_codice<='+'"'+string(ls_a_cod)+'"'+')'
	ls_parametri=ls_parametri+'- A Sogg.Commerciale: '+ls_a_cod
end if
end if
	
end if
str_param.filtro=ls_filtro
str_param.parametri=ls_parametri

if ls_ragg='A' then
openwithparm(w_stp_fatt_zona_art_gd,str_param)
else
openwithparm(w_stp_fatt_zona_cl_gd,str_param)	
	
end if

end if
end if 

end event

type cb_annulla from commandbutton within w_stp_fatt_zona_cx
int X=2153
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

type dw_1 from u_dw_ext_main within w_stp_fatt_zona_cx
event type integer ue_tipo_reg ( )
int X=32
int Y=152
int Width=2354
int Height=680
int TabOrder=10
string DataObject="d_fatt_zona_ff"
end type

event itemchanged;
integer li_ok

string ls_sql_cond
string ls_dbc[], ls_dwc[], ls_dbv[],ls_ragg


choose case dwo.name
	case "ragg"
		dw_1.setitem(1,"da_cod",'')
		dw_1.setitem(1,"da_des",'')
		dw_1.setitem(1,"a_cod",'')
		dw_1.setitem(1,"a_des",'')
	
	


	case "da_cod"
		ls_ragg=this.getitemstring(1,'ragg')
		if ls_ragg='A'then
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "da_cod"
		ls_dwc[2] = "da_des"
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
		
		IF (li_ok > 0) THEN
			if isnull(this.getitemstring(1,"a_cod")) or this.getitemstring(1,"a_cod")='' then
			  this.setitem(1,"a_cod",data)
			  this.setitem(1,"a_des",getitemstring(1,"da_des"))
		   end if	
			RETURN 2
		END IF
		
	else
		
	ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		
		ls_dwc[1] = "da_cod"
		ls_dwc[2] = "da_des"
		
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
		
		IF (li_ok > 0) THEN
			if isnull(this.getitemstring(1,"a_cod")) or this.getitemstring(1,"a_cod")='' then
			this.setitem(1,"a_cod",data)
			this.setitem(1,"a_des",getitemstring(1,"da_des"))
		   end if		
			RETURN 2
		END IF
	end if	
		
		
		
		
		
		
	case "da_des"
		ls_ragg=this.getitemstring(1,'ragg')
		
		if ls_ragg='A'then
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "da_cod"
		ls_dwc[2] = "da_des"
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "descrizione", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)	

		IF (li_ok > 0) THEN
			if isnull(this.getitemstring(1,"a_cod")) or this.getitemstring(1,"a_cod")='' then
			  this.setitem(1,"a_des",data)
			  this.setitem(1,"a_cod",getitemstring(1,"da_cod"))
		   end if	
			RETURN 2
		END IF
		
	else
	ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		
		ls_dwc[1] = "da_cod"
		ls_dwc[2] = "da_des"
		
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", "rag_soc_1", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)		
		

		IF (li_ok > 0) THEN
			if isnull(this.getitemstring(1,"a_cod")) or this.getitemstring(1,"a_cod")='' then
			  this.setitem(1,"a_des",data)
			  this.setitem(1,"a_cod",getitemstring(1,"da_cod"))
		   end if
			RETURN 2
		END IF
				
			end if	
		
		
		
		
		
		case "a_cod"
		ls_ragg=this.getitemstring(1,'ragg')
		if ls_ragg='A'then
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "a_cod"
		ls_dwc[2] = "a_des"
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
			
		

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
		
	else
		
	ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		
		ls_dwc[1] = "a_cod"
		ls_dwc[2] = "a_des"
		
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
			
		

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
	end if	
		
		
		
		
		
		
	case "a_des"
		ls_ragg=this.getitemstring(1,'ragg')
		
		if ls_ragg='A'then
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "a_cod"
		ls_dwc[2] = "a_des"
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "descrizione", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
		
	else
	ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		
		ls_dwc[1] = "a_cod"
		ls_dwc[2] = "a_des"
		
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", "rag_soc_1", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
			
		
		IF (li_ok > 0) THEN
			RETURN 2
		END IF
				
			end if	
		
		
		
	
		
end choose

	
	
	
		

end event

event itemfocuschanged;call super::itemfocuschanged;

end event

event ue_set_search;call super::ue_set_search;string ls_ragg
ls_ragg=dw_1.getitemstring(1,"ragg")

choose case as_nomecol
	case "da_cod"
		if ls_ragg='A'then
		is_search_window="w_articolo_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="articolo_codice"
	else
		is_search_window="w_sog_commerciale_gen_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="codice"
	end if
	case "da_des"
		if ls_ragg='A'then
		is_search_window="w_articolo_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="articolo_descrizione"
	else
		is_search_window="w_sog_commerciale_gen_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="rag_soc_1"
	end if
	case "a_cod"
		if ls_ragg='A'then
		is_search_window="w_articolo_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="articolo_codice"
	else
		is_search_window="w_sog_commerciale_gen_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="codice"
	end if
case "a_des"
		if ls_ragg='A'then
		is_search_window="w_articolo_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="articolo_descrizione"
	else
		is_search_window="w_sog_commerciale_gen_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="rag_soc_1"
	end if
end choose
end event

event ue_use_search;string ls_ragg
ls_ragg=dw_1.getitemstring(1,"ragg")
choose case as_nomecol
	case "da_cod"
		if ls_ragg='a'then
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_articolo",is_ricpar.s_id_seg_value[1])
			uf_set_colval("da_des",is_ricpar.s_ausil_value[1])
		else
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_sogg_commerciale",is_ricpar.s_id_seg_value[1])
			uf_set_colval("da_des",is_ricpar.s_ausil_value[1])
		end if
		if isnull(this.getitemstring(1,"a_cod")) or this.getitemstring(1,"a_cod")='' then
		   uf_set_colval("a_cod",is_ricpar.s_main_value)
			uf_set_colval("a_des",is_ricpar.s_ausil_value[1])
		end if	
		
	case "da_des"
		
			if ls_ragg='a'then
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_articolo",is_ricpar.s_id_seg_value[1])
			uf_set_colval("da_cod",is_ricpar.s_ausil_value[1])
		else
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_sogg_commerciale",is_ricpar.s_id_seg_value[1])
			uf_set_colval("da_cod",is_ricpar.s_ausil_value[1])
		end if
		if isnull(this.getitemstring(1,"a_cod")) or this.getitemstring(1,"a_cod")='' then
		   uf_set_colval("a_des",is_ricpar.s_main_value)
			uf_set_colval("a_cod",is_ricpar.s_ausil_value[1])
		end if
		
	case "a_cod"
			if ls_ragg='a'then
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_articolo",is_ricpar.s_id_seg_value[1])
			uf_set_colval("a_des",is_ricpar.s_ausil_value[1])
		else
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_sogg_commerciale",is_ricpar.s_id_seg_value[1])
			uf_set_colval("a_des",is_ricpar.s_ausil_value[1])
		end if
	case "a_des"
			if ls_ragg='a'then
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_articolo",is_ricpar.s_id_seg_value[1])
			uf_set_colval("a_cod",is_ricpar.s_ausil_value[1])
		else
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_sogg_commerciale",is_ricpar.s_id_seg_value[1])
			uf_set_colval("a_cod",is_ricpar.s_ausil_value[1])
		end if
	end choose
end event

