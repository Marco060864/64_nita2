forward
global type w_stp_agenti_anag_cx from w_wiz_main
end type
type cb_ok from commandbutton within w_stp_agenti_anag_cx
end type
type cb_annulla from commandbutton within w_stp_agenti_anag_cx
end type
type dw_1 from u_dw_ext_main within w_stp_agenti_anag_cx
end type
end forward

global type w_stp_agenti_anag_cx from w_wiz_main
int Width=1335
int Height=769
WindowType WindowType=response!
boolean TitleBar=true
string Title="Stampa Gruppi Agenti"
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
cb_ok cb_ok
cb_annulla cb_annulla
dw_1 dw_1
end type
global w_stp_agenti_anag_cx w_stp_agenti_anag_cx

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

on w_stp_agenti_anag_cx.create
int iCurrent
call w_wiz_main::create
this.cb_ok=create cb_ok
this.cb_annulla=create cb_annulla
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=cb_ok
this.Control[iCurrent+2]=cb_annulla
this.Control[iCurrent+3]=dw_1
end on

on w_stp_agenti_anag_cx.destroy
call w_wiz_main::destroy
destroy(this.cb_ok)
destroy(this.cb_annulla)
destroy(this.dw_1)
end on

event closequery;call super::closequery;

end event

event open;call super::open;dw_1.insertrow(1)
datawindowchild ldw_da_cod,ldw_a_cod
 
 
dw_1.getchild("da_cod",ldw_da_cod)
dw_1.getchild("a_cod",ldw_a_cod)

ldw_da_cod.settransobject(sqlca)
ldw_da_cod.retrieve()

ldw_a_cod.settransobject(sqlca)
ldw_a_cod.retrieve()





end event

type cb_ok from commandbutton within w_stp_agenti_anag_cx
event clicked pbm_bnclicked
int X=778
int Y=33
int Width=243
int Height=85
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
string ls_da_cod,ls_a_cod
string ls_filtro,ls_parametri
str_fil_flag str_param


dw_1.accepttext()
ls_da_cod=dw_1.getitemstring(1,"da_cod")
ls_a_cod=dw_1.getitemstring(1,"a_cod")
if ls_da_cod>ls_a_cod then
	messagebox("Stampa anagrafica agenti","Il codice della zona iniziale è maggiore di quello finale",exclamation!)
else 



if ls_da_cod<>''and ls_filtro='' then
	ls_filtro='gruppo_agenti_codice>='+'"'+string(ls_da_cod)+'"'
	ls_parametri='Da gruppo agenti: '+ls_da_cod
else
if ls_da_cod<>''and ls_filtro<>'' then
	ls_filtro=ls_filtro+' and (gruppo_agenti_codice>='+'"'+string(ls_da_cod)+'"'+')'
	ls_parametri='Da gruppo agenti: '+ls_da_cod
end if
end if

if ls_a_cod<>''and ls_filtro='' then
	ls_filtro='gruppo_agenti_codice<='+'"'+string(ls_a_cod)+'"'
	ls_parametri=ls_parametri+' A gruppo agenti: '+ls_a_cod
else
if ls_a_cod<>''and ls_filtro<>'' then
	ls_filtro=ls_filtro+' and (gruppo_agenti_codice<='+'"'+string(ls_a_cod)+'"'+')'
	ls_parametri=ls_parametri+' A gruppo agenti: '+ls_a_cod
end if
end if
str_param.filtro=ls_filtro
str_param.parametri=ls_parametri
openwithparm(w_stp_anag_ag_gd,str_param)	
	
end if



end event

type cb_annulla from commandbutton within w_stp_agenti_anag_cx
int X=1066
int Y=33
int Width=243
int Height=85
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

type dw_1 from u_dw_ext_main within w_stp_agenti_anag_cx
event type integer ue_tipo_reg ( )
int X=46
int Y=157
int Width=1244
int Height=497
int TabOrder=10
string DataObject="d_gruppo_ag_anag_cx"
end type

event itemchanged;call super::itemchanged;
choose case dwo.name
	case "ragg"
		dw_1.setitem(1,"da_cod",'')
		dw_1.setitem(1,"da_des",'')
		dw_1.setitem(1,"a_cod",'')
		dw_1.setitem(1,"a_des",'')
		
		
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
		is_ricpar.s_filter_name="descrizione"
	else
		is_search_window="w_sog_commerciale_gen_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="rag_soc_1"
	end if
end choose
end event

event ue_use_search;call super::ue_use_search;string ls_ragg
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

