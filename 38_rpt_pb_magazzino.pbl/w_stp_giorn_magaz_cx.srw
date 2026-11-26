forward
global type w_stp_giorn_magaz_cx from w_wiz_main
end type
type cb_ok from commandbutton within w_stp_giorn_magaz_cx
end type
type cb_annulla from commandbutton within w_stp_giorn_magaz_cx
end type
type dw_1 from u_dw_ext_main within w_stp_giorn_magaz_cx
end type
end forward

global type w_stp_giorn_magaz_cx from w_wiz_main
int Width=3122
int Height=1260
WindowType WindowType=response!
boolean TitleBar=true
string Title="Stampa libro giornale di magazzino"
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
cb_ok cb_ok
cb_annulla cb_annulla
dw_1 dw_1
end type
global w_stp_giorn_magaz_cx w_stp_giorn_magaz_cx

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

on w_stp_giorn_magaz_cx.create
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

on w_stp_giorn_magaz_cx.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.cb_annulla)
destroy(this.dw_1)
end on

event closequery;call super::closequery;

end event

event open;datawindowchild ldw_da_magaz_cod,ldw_da_magaz_des,ldw_a_magaz_cod,ldw_a_magaz_des


dw_1.getchild("da_magazzino_cod",ldw_da_magaz_cod)
ldw_da_magaz_cod.settransobject(sqlca)
ldw_da_magaz_cod.retrieve()

dw_1.getchild("da_magazzino_des",ldw_da_magaz_des)
ldw_da_magaz_des.settransobject(sqlca)
ldw_da_magaz_des.retrieve()

dw_1.getchild("a_magazzino_cod",ldw_a_magaz_cod)
ldw_a_magaz_cod.settransobject(sqlca)
ldw_a_magaz_cod.retrieve()

dw_1.getchild("a_magazzino_des",ldw_a_magaz_des)
ldw_a_magaz_des.settransobject(sqlca)
ldw_a_magaz_des.retrieve()



dw_1.insertrow(1)


long	ll_id_valuta
Datawindowchild ldw_id_valuta, ldw_id_valuta_des

dw_1.GetChild("id_valuta", ldw_id_valuta)
dw_1.GetChild("id_valuta_des", ldw_id_valuta_des)

ldw_id_valuta.SetTransObject(SQLCA)
ldw_id_valuta.Retrieve()

ldw_id_valuta_des.SetTransObject(SQLCA)
ldw_id_valuta_des.Retrieve()

SELECT id_valuta
INTO	 :ll_id_valuta
FROM	 par_sistema
;

dw_1.Post setitem(1, "id_valuta", ll_id_valuta)
end event

type cb_ok from commandbutton within w_stp_giorn_magaz_cx
event clicked pbm_bnclicked
int X=2510
int Y=32
int Width=242
int Height=88
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
string ls_da_articolo,ls_a_articolo,ls_da_magaz,ls_a_magaz
string ls_totali,ls_filtro
date ld_da_data,ld_a_data
Long		ll_id_valuta	

str_giorn_mag str_param

dw_1.accepttext()
ld_da_data=dw_1.getitemdate(1,"da_data_reg")
ld_a_data=dw_1.getitemdate(1,"a_data_reg")
ls_da_articolo=dw_1.getitemstring(1,"da_articolo_cod")
ls_a_articolo=dw_1.getitemstring(1,"a_articolo_cod")
ls_da_magaz=dw_1.getitemstring(1,"da_magazzino_cod")
ls_a_magaz=dw_1.getitemstring(1,"a_magazzino_cod")
ll_id_valuta	= dw_1.getitemnumber(1,"id_valuta")

ls_totali=dw_1.getitemstring(1,"totali")
if isnull(ls_totali) then
	ls_totali='N'
end if
if isnull(ld_da_data)or isnull(ld_a_data)then
	messagebox("stampa giornale di magazzino","Le date di riferimento sono obbligatorie!",exclamation!)
else
	if ld_da_data>ld_a_data then
	messagebox("stampa giornale di magazzino","La data iniziale è magiore di quella finale!",exclamation!)
else
if ls_da_articolo>ls_a_articolo then
	messagebox("Stampa scheda anagrafica articolo","Il codice dell'articolo iniziale è maggiore di quello finale",exclamation!)
else 
if ls_da_magaz>ls_a_magaz then
	messagebox("Stampa scheda anagrafica articolo","Il codice della categoria commerciale iniziale è maggiore di quello finale",exclamation!)
else
	



if ls_da_articolo<>''and ls_filtro='' then
	ls_filtro='articolo_codice>='+'"'+string(ls_da_articolo)+'"'
else
if ls_da_articolo<>''and ls_filtro<>'' then
	ls_filtro=ls_filtro+' and (articolo_codice>='+'"'+string(ls_da_articolo)+'"'+')'
end if
end if
if ls_a_articolo<>''and ls_filtro='' then
	ls_filtro='articolo_codice<='+'"'+string(ls_a_articolo)+'"'
else
if ls_a_articolo<>''and ls_filtro<>'' then
	ls_filtro=ls_filtro+' and (articolo_codice<='+'"'+string(ls_a_articolo)+'"'+')'
end if
end if

if ls_da_magaz<>''and ls_filtro='' then
	ls_filtro='magazzino_codice>='+'"'+string(ls_da_magaz)+'"'
else
if ls_da_magaz<>''and ls_filtro<>'' then
	ls_filtro=ls_filtro+' and (magazzino_codice>='+'"'+string(ls_da_magaz)+'"'+')'
end if
end if
if ls_a_magaz<>''and ls_filtro='' then
	ls_filtro='magazzino_codice<='+'"'+string(ls_a_magaz)+'"'
else
if ls_a_magaz<>''and ls_filtro<>'' then
	ls_filtro=ls_filtro+' and (magazzino_codice<='+'"'+string(ls_a_magaz)+'"'+')'
end if
end if


str_param.filtro=ls_filtro
str_param.flag=ls_totali
str_param.da_data=ld_da_data
str_param.a_data=ld_a_data
str_param.id_valuta = ll_id_valuta 

openwithparm(w_stp_giorn_magaz_gd,str_param)
end if 
end if
end if
end if
end event

type cb_annulla from commandbutton within w_stp_giorn_magaz_cx
int X=2848
int Y=32
int Width=229
int Height=88
int TabOrder=30
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

type dw_1 from u_dw_ext_main within w_stp_giorn_magaz_cx
event type integer ue_tipo_reg ( )
int X=27
int Y=176
int Width=3045
int Height=968
int TabOrder=10
string DataObject="d_giorn_magaz_ff"
end type

event itemchanged;

integer li_ok

string ls_sql_cond
string ls_dbc[], ls_dwc[], ls_dbv[]

choose case dwo.name
	case "da_articolo_cod"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "da_articolo_cod"
		ls_dwc[2] = "da_articolo_des"
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
			
			
						
		if isnull(This.GetItemString(1, "a_articolo_cod")) or This.GetItemString(1, "a_articolo_cod")='' then	
 		  This.SetItem(1, "a_articolo_cod", Data)			
        This.SetItem(1, "a_articolo_des", This.GetItemString(1, "da_articolo_des"))
	   end if  

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
		
	case "da_articolo_des"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "da_articolo_cod"
		ls_dwc[2] = "da_articolo_des"
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "descrizione", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
			
		if isnull(This.GetItemString(1, "a_articolo_cod")) or This.GetItemString(1, "a_articolo_cod")='' then	
			 This.SetItem(1, "a_articolo_des", Data)			
          This.SetItem(1, "a_articolo_cod", This.GetItemString(1, "da_articolo_cod"))
	   end if  

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
		
	case "a_articolo_cod"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "a_articolo_cod"
		ls_dwc[2] = "a_articolo_des"
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
	case "a_articolo_des"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "a_articolo_cod"
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

event ue_set_search;call super::ue_set_search;
choose case as_nomecol
	case "da_articolo_cod"
		is_search_window="w_anag_art_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="codice"
	case "da_articolo_des"
		is_search_window="w_anag_art_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="descrizione"
	case "a_articolo_cod"
		is_search_window="w_anag_art_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="codice"
	case "a_articolo_des"
		is_search_window="w_anag_art_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="descrizione"	
end choose
end event

event ue_use_search;choose case as_nomecol
	case "da_articolo_cod"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_articolo",is_ricpar.s_id_seg_value[1])
			uf_set_colval("da_articolo_des",is_ricpar.s_ausil_value[1])
			if isnull(This.GetItemString(1, "a_articolo_cod")) or This.GetItemString(1, "a_articolo_cod")='' then
				uf_set_colval("a_articolo_cod",is_ricpar.s_main_value)
			   uf_set_colval("a_articolo_des",is_ricpar.s_ausil_value[1])
			end if	
				
	case "da_articolo_des"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_articolo",is_ricpar.s_id_seg_value[1])
			uf_set_colval("da_articolo_cod",is_ricpar.s_ausil_value[1])
			if isnull(This.GetItemString(1, "a_articolo_cod")) or This.GetItemString(1, "a_articolo_cod")='' then
				uf_set_colval("a_articolo_des",is_ricpar.s_main_value)
			   uf_set_colval("a_articolo_cod",is_ricpar.s_ausil_value[1])
			end if	
			
	case "a_articolo_cod"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_articolo",is_ricpar.s_id_seg_value[1])
			uf_set_colval("a_articolo_des",is_ricpar.s_ausil_value[1])	
	case "a_articolo_des"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_articolo",is_ricpar.s_id_seg_value[1])
			uf_set_colval("a_articolo_cod",is_ricpar.s_ausil_value[1])
	end choose
end event

