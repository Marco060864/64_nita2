forward
global type w_stp_art_invend_cx from w_wiz_main
end type
type cb_ok from commandbutton within w_stp_art_invend_cx
end type
type cb_annulla from commandbutton within w_stp_art_invend_cx
end type
type dw_1 from u_dw_ext_main within w_stp_art_invend_cx
end type
end forward

global type w_stp_art_invend_cx from w_wiz_main
int Width=1870
int Height=808
WindowType WindowType=response!
boolean TitleBar=true
string Title="Stampa Articoli invenduti"
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
cb_ok cb_ok
cb_annulla cb_annulla
dw_1 dw_1
end type
global w_stp_art_invend_cx w_stp_art_invend_cx

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

on w_stp_art_invend_cx.create
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

on w_stp_art_invend_cx.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.cb_annulla)
destroy(this.dw_1)
end on

event closequery;call super::closequery;

end event

event open;call super::open;datawindowchild ldw_cat_comm_cod,ldw_cat_comm_des,ldw_cat_fisc_cod,ldw_cat_fisc_des,ldw_cat_mer_cod
datawindowchild ldw_cat_mer_des

datawindowchild ldw_cat_comm_cod2,ldw_cat_comm_des2,ldw_cat_fisc_cod2,ldw_cat_fisc_des2,ldw_cat_mer_cod2
datawindowchild ldw_cat_mer_des2


dw_1.getchild("da_cat_comm",ldw_cat_comm_cod)
ldw_cat_comm_cod.settransobject(sqlca)
ldw_cat_comm_cod.retrieve()

dw_1.getchild("da_cat_comm2",ldw_cat_comm_des)
ldw_cat_comm_des.settransobject(sqlca)
ldw_cat_comm_des.retrieve()

dw_1.getchild("a_cat_comm",ldw_cat_comm_cod2)
ldw_cat_comm_cod2.settransobject(sqlca)
ldw_cat_comm_cod2.retrieve()

dw_1.getchild("a_cat_comm2",ldw_cat_comm_des2)
ldw_cat_comm_des2.settransobject(sqlca)
ldw_cat_comm_des2.retrieve()

dw_1.getchild("da_cat_fisc",ldw_cat_fisc_cod)
ldw_cat_fisc_cod.settransobject(sqlca)
ldw_cat_fisc_cod.retrieve()

dw_1.getchild("da_cat_fisc2",ldw_cat_fisc_des)
ldw_cat_fisc_des.settransobject(sqlca)
ldw_cat_fisc_des.retrieve()

dw_1.getchild("a_cat_fisc",ldw_cat_fisc_cod2)
ldw_cat_fisc_cod2.settransobject(sqlca)
ldw_cat_fisc_cod2.retrieve()

dw_1.getchild("a_cat_fisc2",ldw_cat_fisc_des2)
ldw_cat_fisc_des2.settransobject(sqlca)
ldw_cat_fisc_des2.retrieve()

dw_1.getchild("da_cat_merc",ldw_cat_mer_cod)
ldw_cat_mer_cod.settransobject(sqlca)
ldw_cat_mer_cod.retrieve()

dw_1.getchild("da_cat_merc2",ldw_cat_mer_des)
ldw_cat_mer_des.settransobject(sqlca)
ldw_cat_mer_des.retrieve()

dw_1.getchild("a_cat_merc",ldw_cat_mer_cod2)
ldw_cat_mer_cod2.settransobject(sqlca)
ldw_cat_mer_cod2.retrieve()

dw_1.getchild("a_cat_merc2",ldw_cat_mer_des2)
ldw_cat_mer_des2.settransobject(sqlca)
ldw_cat_mer_des2.retrieve()



dw_1.insertrow(1)

end event

event ue_post_open;call super::ue_post_open;String ls_da_articolo, ls_a_articolo, ls_da_articolo_des, ls_a_articolo_des

SELECT MIN(codice)
INTO	 :ls_da_articolo
FROM	 articolo
;

If SQLCA.SQLCODE = 0 Then
	dw_1.SetItem(1, "da_articolo", ls_da_articolo)
	
	SELECT descrizione 
	INTO	 :ls_da_articolo_des
	FROM	 articolo
	WHERE	 codice = :ls_da_articolo
	;
	dw_1.SetItem(1, "da_articolo_des", ls_da_articolo_des)	
End If

SELECT MAX(codice)
INTO	 :ls_a_articolo
FROM	 articolo;

If SQLCA.SQLCODE = 0 Then
	dw_1.SetItem(1, "a_articolo", ls_a_articolo)
	
	SELECT descrizione 
	INTO	 :ls_a_articolo_des
	FROM	 articolo
	WHERE	 codice = :ls_a_articolo
	;
	dw_1.SetItem(1, "a_articolo_des", ls_a_articolo_des)		
End If
end event

type cb_ok from commandbutton within w_stp_art_invend_cx

event clicked pbm_bnclicked
int X=1275
int Y=32
int Width=229
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
string ls_da_articolo,ls_a_articolo,ls_da_cat_comm,ls_a_cat_comm,ls_da_cat_fisc,ls_a_cat_fisc
string ls_da_cat_merc,ls_a_cat_merc,ls_uconf_base,ls_filtro,ls_parametri
str_anag_art str_param

dw_1.accepttext()
ls_da_articolo=dw_1.getitemstring(1,"da_articolo")
ls_a_articolo=dw_1.getitemstring(1,"a_articolo")

if IsNull(ls_da_articolo) Or IsNull(ls_a_articolo) Then
	messagebox("Stampa Articoli invenduti","Gli articoli di inizio e fine sono obbligatori",exclamation!)	
End If

if ls_da_articolo > ls_a_articolo then
	messagebox("Stampa Articoli invenduti","Il codice dell'articolo iniziale è maggiore di quello finale",exclamation!)
else 

ls_filtro='c_giorni_invend > articolo_giorni_invenduto'
ls_parametri = 'Da Articolo ' + ls_da_articolo + ' A Articolo ' + ls_a_articolo

str_param.filtro=ls_filtro
str_param.parametri=ls_parametri
str_param.da_art=ls_da_articolo
str_param.a_art=ls_a_articolo

openwithparm(w_stp_art_invend_gd,str_param)
end if
end event

type cb_annulla from commandbutton within w_stp_art_invend_cx
int X=1568
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

type dw_1 from u_dw_ext_main within w_stp_art_invend_cx
event type integer ue_tipo_reg ( )
int X=32
int Y=148
int Width=1774
int Height=544
int TabOrder=10
string DataObject="d_stp_art_invend_ff"
end type

event itemchanged;integer li_ok

string ls_sql_cond
string ls_dbc[], ls_dwc[], ls_dbv[]

CHOOSE CASE dwo.name
	CASE "da_articolo"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "da_articolo"
		ls_dwc[2] = "da_articolo_des"
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
			
		

		IF (li_ok > 0) THEN
			if isnull(This.GetItemString(1, "a_articolo")) or This.GetItemString(1, "a_articolo")='' then
            This.SetItem(1, "a_articolo", Data)			
            This.SetItem(1, "a_articolo_des", This.GetItemString(1, "da_articolo_des"))
	      end if
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
           This.SetItem(1, "a_articolo_des", Data)			
           This.SetItem(1, "a_articolo", This.GetItemString(1, "da_articolo"))
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

event ue_set_search;CHOOSE CASE as_nomecol
	CASE "da_articolo"
		is_search_window="w_articolo_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="articolo_codice"
	CASE "da_articolo_des"
		is_search_window="w_articolo_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="articolo_descrizione"
	CASE "a_articolo"
		is_search_window="w_articolo_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="articolo_codice"
	CASE "a_articolo_des"
		is_search_window="w_articolo_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="articolo_descrizione"	
END CHOOSE
end event

event ue_use_search;choose case as_nomecol
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

