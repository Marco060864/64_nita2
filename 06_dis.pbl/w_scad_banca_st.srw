forward
global type w_scad_banca_st from w_wiz_main
end type
type cb_ok from commandbutton within w_scad_banca_st
end type
type cb_annulla from commandbutton within w_scad_banca_st
end type
type dw_1 from u_dw_ext_main within w_scad_banca_st
end type
end forward

global type w_scad_banca_st from w_wiz_main
integer y = 437
integer width = 2592
integer height = 724
string title = "Stampa lista effetti per banca e scadenza "
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
cb_ok cb_ok
cb_annulla cb_annulla
dw_1 dw_1
end type
global w_scad_banca_st w_scad_banca_st

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
string ls_sel_b

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

on w_scad_banca_st.create
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

on w_scad_banca_st.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.cb_annulla)
destroy(this.dw_1)
end on

event closequery;call super::closequery;

end event

event open;datawindowchild ldw_da_pag,ldw_da_pag_des,ldw_a_pag,ldw_a_pag_des


dw_1.getchild("da_pag",ldw_da_pag)
ldw_da_pag.settransobject(sqlca)
ldw_da_pag.retrieve()

dw_1.getchild("da_pag_des",ldw_da_pag_des)
ldw_da_pag_des.settransobject(sqlca)
ldw_da_pag_des.retrieve()

dw_1.getchild("a_pag",ldw_a_pag)
ldw_a_pag.settransobject(sqlca)
ldw_a_pag.retrieve()

dw_1.getchild("a_pag_des",ldw_a_pag_des)
ldw_a_pag_des.settransobject(sqlca)
ldw_a_pag_des.retrieve()



dw_1.insertrow(1)
dw_1.setitem(1,"sel_b",'A')
ls_sel_b=dw_1.getitemstring(1,"sel_b")

dw_1.setitem(1,"solo_tot",'N')
end event

type cb_ok from commandbutton within w_scad_banca_st
event clicked pbm_bnclicked
integer x = 1833
integer y = 32
integer width = 242
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stam&pa"
boolean cancel = true
end type

event clicked;string ls_da_pag,ls_a_pag,ls_da_cod_abi,ls_da_cod_cab,ls_a_cod_abi,ls_a_cod_cab
string ls_totali,ls_filtro,ls_parametri
date ld_da_data,ld_a_data
long ls_da_banca,ls_a_banca
str_fil_flag str_param

dw_1.accepttext()
str_param.id_banca=dw_1.getitemnumber(1,"da_banca_id")
str_param.da_data=dw_1.getitemdate(1,"da_data")
str_param.a_data=dw_1.getitemdate(1,"a_data")

select banca_appoggio.cod_abi,banca_appoggio.cod_cab
into :ls_da_cod_abi,:ls_da_cod_cab
from banca_appoggio,
	  banca_azienda
where banca_azienda.id_banca_azienda=:ls_da_banca and
banca_appoggio.id_banca_appoggio=banca_azienda.id_banca_appoggio;	
	
if ld_da_data>ld_a_data then
	messagebox("stampa lista effetti per banca e scadenza","La data iniziale è maggiore di quella finale!",exclamation!)
end if
if ls_da_cod_abi>ls_a_cod_abi then
	messagebox("stampa lista effetti per banca e scadenza","Il codice ABI iniziale è maggiore di quello finale!",exclamation!)
else
	if ls_da_cod_cab>ls_a_cod_cab then
		messagebox("stampa lista effetti per banca e scadenza","Il codice CAB iniziale è maggiore di quello finale!",exclamation!)
	end if
end if

if ls_da_cod_abi<>''and ls_filtro='' then
	
	ls_parametri='Da codici(ABI/CAB):'+ls_da_cod_abi+' / '+ls_da_cod_cab
	str_param.parametri='Da codici(ABI/CAB):'+ls_da_cod_abi+' / '+ls_da_cod_cab
end if

str_param.parametri=ls_parametri

openwithparm(w_SCAD_BANCA_RPT, str_param)

end event

type cb_annulla from commandbutton within w_scad_banca_st
integer x = 2171
integer y = 32
integer width = 242
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Annulla"
boolean cancel = true
end type

event clicked;

Close(Parent)
end event

type dw_1 from u_dw_ext_main within w_scad_banca_st
event type integer ue_tipo_reg ( )
integer x = 27
integer y = 172
integer width = 2519
integer height = 396
integer taborder = 10
string dataobject = "d_scad_banca_st"
end type

event itemchanged;call super::itemchanged;
dw_1.accepttext()
string ls_da_banca,ls_a_banca
dw_1.accepttext()
ls_da_banca=dw_1.getitemstring(1,"da_banca")
ls_a_banca=dw_1.getitemstring(1,"a_banca")


		

	
		

end event

event ue_set_search;call super::ue_set_search;
dw_1.accepttext()
ls_sel_b=dw_1.getitemstring(1,"sel_b")
		
choose case as_nomecol
		case "da_banca"
			if ls_sel_b='S'then
		is_search_window 				= "w_banca_sog_commerciale_gen_sw" 
		is_ricpar.s_filter_value 	= as_valcol 
		is_ricpar.s_filter_name 	= "cc_den_abi_cab"
	else
	is_search_window 				= "w_banca_azienda_sw" 
		is_ricpar.s_filter_value 	= as_valcol 
		is_ricpar.s_filter_name 	= "banca_appoggio_cod_abi"	
	end if
		case "a_banca"	
			if ls_sel_b='S' then
		is_search_window 				= "w_banca_sog_commerciale_gen_sw" 
		is_ricpar.s_filter_value 	= as_valcol 
		is_ricpar.s_filter_name 	= "cc_den_abi_cab" 
	else
	is_search_window 				= "w_banca_azienda_sw" 
		is_ricpar.s_filter_value 	= as_valcol 
		is_ricpar.s_filter_name 	= "banca_appoggio_cod_abi"	
end if
	
end choose
end event

event ue_use_search;string ls_string
choose case as_nomecol
	CASE "da_banca"
		if ls_sel_b='S' then
			ls_string=is_ricpar.s_ausil_value[3]+' - '+is_ricpar.s_ausil_value[5]+' - '+is_ricpar.s_main_value
		uf_set_colval(as_nomecol,ls_string)
		uf_set_colval("da_banca_id", is_ricpar.s_id_seg_value[1])
		if isnull(this.getitemstring(1,"a_banca")) or this.getitemstring(1,"a_banca")='' then
		  uf_set_colval("a_banca_id", is_ricpar.s_id_seg_value[1])
		  uf_set_colval("a_banca",ls_string)
	   end if  
		else
		ls_string=is_ricpar.s_ausil_value[2]+' - '+is_ricpar.s_ausil_value[3]+' - '+is_ricpar.s_main_value+' - '+is_ricpar.s_ausil_value[1]
		uf_set_colval(as_nomecol, ls_string)
		uf_set_colval("da_banca_id", is_ricpar.s_id_seg_value[1])
		if isnull(this.getitemstring(1,"a_banca")) or this.getitemstring(1,"a_banca")='' then
		  uf_set_colval("a_banca_id", is_ricpar.s_id_seg_value[1])
		  uf_set_colval("a_banca", ls_string)
	   end if
	end if
	dw_1.object.sel_b.protect=1
		CASE "a_banca"
		if ls_sel_b='S' then
			ls_string=is_ricpar.s_ausil_value[3]+' - '+is_ricpar.s_ausil_value[5]+' - '+is_ricpar.s_main_value
		uf_set_colval(as_nomecol,ls_string)
		uf_set_colval("a_banca_id", is_ricpar.s_id_seg_value[1])
	else
		ls_string=is_ricpar.s_ausil_value[2]+' - '+is_ricpar.s_ausil_value[3]+' - '+is_ricpar.s_main_value+' - '+is_ricpar.s_ausil_value[1]
		uf_set_colval(as_nomecol, ls_string)
		uf_set_colval("a_banca_id", is_ricpar.s_id_seg_value[1])
	end if 
	dw_1.object.sel_b.protect=1
end choose
end event

event itemfocuschanged;call super::itemfocuschanged;dw_1.accepttext()
string ls_da_banca,ls_a_banca
dw_1.accepttext()
ls_da_banca=dw_1.getitemstring(1,"da_banca")
ls_a_banca=dw_1.getitemstring(1,"a_banca")

if  isnull(ls_da_banca) and isnull(ls_a_banca) then
		dw_1.object.sel_b.protect=0
		dw_1.setitem(1,"da_banca_id",0)
	dw_1.setitem(1,"a_banca_id",0)
	end if
	
end event

