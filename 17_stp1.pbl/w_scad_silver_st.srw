forward
global type w_scad_silver_st from w_wiz_main
end type
type cb_ok from commandbutton within w_scad_silver_st
end type
type cb_annulla from commandbutton within w_scad_silver_st
end type
type dw_1 from u_dw_ext_main within w_scad_silver_st
end type
end forward

global type w_scad_silver_st from w_wiz_main
integer y = 437
integer width = 1883
integer height = 627
string title = "Stampa Lista Scadenze"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
cb_ok cb_ok
cb_annulla cb_annulla
dw_1 dw_1
end type
global w_scad_silver_st w_scad_silver_st

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

on w_scad_silver_st.create
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

on w_scad_silver_st.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.cb_annulla)
destroy(this.dw_1)
end on

event closequery;call super::closequery;

end event

event open;integer li_anno, li_mese
string ls_giorno, ls_data
datawindowchild ldwc_tipo_pag

dw_1.getchild("id_tipo_pagamento",ldwc_tipo_pag)
ldwc_tipo_pag.settransobject(sqlca)
ldwc_tipo_pag.retrieve()



dw_1.insertrow(1)
dw_1.setitem(1, "da_data", today())

li_anno=year(today())
li_mese=month(today())
choose case li_mese
	case 1, 3, 5, 7, 8, 10, 12
		ls_giorno='31'
	case 4, 6, 9, 11
		ls_giorno='31'
	case 2
		if mod(li_anno, 4)=0 then
			ls_giorno='29'
		else
			ls_giorno='28'
		end if
end choose
ls_data=ls_giorno+"/"+string(li_mese)+"/"+string(li_anno)
dw_1.setitem(1, "a_data", date(ls_data)) 


end event

type cb_ok from commandbutton within w_scad_silver_st
event clicked pbm_bnclicked
integer x = 1551
integer y = 26
integer width = 241
integer height = 83
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

event clicked;//string ls_da_pag,ls_a_pag,ls_da_cod_abi,ls_da_cod_cab,ls_a_cod_abi,ls_a_cod_cab
string ls_tipo_pag
//ls_totali,ls_filtro,ls_parametri,
date ld_da_data,ld_a_data
//long ls_da_banca,ls_a_banca
str_fil_flag str_param

dw_1.accepttext()
str_param.id_banca=dw_1.getitemnumber(1,"id_tipo_pagamento")
str_param.da_data=dw_1.getitemdate(1,"da_data")
str_param.a_data=dw_1.getitemdate(1,"a_data")
str_param.flag=dw_1.getitemstring(1,"tipo_scadenza")


if ld_da_data>ld_a_data then
	messagebox("stampa lista effetti per banca e scadenza","La data iniziale è maggiore di quella finale!",exclamation!)
end if

	
	
str_param.parametri='Dal '+string(str_param.da_data) +' al '+string(str_param.a_data)
if str_param.id_banca>0 then
	select codice
	into :ls_tipo_pag
	from dba.tipo_pagamento
	where id_tipo_pagamento=:str_param.id_banca
	;
	str_param.parametri+=" - Tipo pagamento: "+ls_tipo_pag
end if


openwithparm(w_SCAD_silver_RPT, str_param)

end event

type cb_annulla from commandbutton within w_scad_silver_st
integer x = 1258
integer y = 26
integer width = 241
integer height = 83
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

type dw_1 from u_dw_ext_main within w_scad_silver_st
event type integer ue_tipo_reg ( )
integer x = 29
integer y = 128
integer width = 1814
integer height = 333
integer taborder = 10
string dataobject = "d_scad_silver_st"
end type

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

