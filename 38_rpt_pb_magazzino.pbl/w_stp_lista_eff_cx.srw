forward
global type w_stp_lista_eff_cx from w_wiz_main
end type
type cb_ok from commandbutton within w_stp_lista_eff_cx
end type
type cb_annulla from commandbutton within w_stp_lista_eff_cx
end type
type dw_1 from u_dw_ext_main within w_stp_lista_eff_cx
end type
end forward

global type w_stp_lista_eff_cx from w_wiz_main
int Width=2592
int Height=1316
WindowType WindowType=response!
boolean TitleBar=true
string Title="Stampa lista effetti per banca e scadenza "
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
cb_ok cb_ok
cb_annulla cb_annulla
dw_1 dw_1
end type
global w_stp_lista_eff_cx w_stp_lista_eff_cx

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

on w_stp_lista_eff_cx.create
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

on w_stp_lista_eff_cx.destroy
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

type cb_ok from commandbutton within w_stp_lista_eff_cx
event clicked pbm_bnclicked
int X=1833
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
string ls_da_pag,ls_a_pag,ls_da_cod_abi,ls_da_cod_cab,ls_a_cod_abi,ls_a_cod_cab
string ls_totali,ls_filtro,ls_parametri
date ld_da_data,ld_a_data
long ls_da_banca,ls_a_banca
str_fil_flag str_param

dw_1.accepttext()
ld_da_data=dw_1.getitemdate(1,"da_data")
ld_a_data=dw_1.getitemdate(1,"a_data")
ls_da_banca=dw_1.getitemnumber(1,"da_banca_id")
ls_a_banca=dw_1.getitemnumber(1,"a_banca_id")
ls_da_pag=dw_1.getitemstring(1,"da_pag")
ls_a_pag=dw_1.getitemstring(1,"a_pag")

ls_totali=dw_1.getitemstring(1,"solo_tot")
ls_sel_b=dw_1.getitemstring(1,"sel_b")

if ls_sel_b='A' then
	select banca_appoggio.cod_abi,banca_appoggio.cod_cab
	into :ls_da_cod_abi,:ls_da_cod_cab
	from banca_appoggio,
		  banca_azienda
	where banca_azienda.id_banca_azienda=:ls_da_banca and
	banca_appoggio.id_banca_appoggio=banca_azienda.id_banca_appoggio;	
	
	select banca_appoggio.cod_abi,banca_appoggio.cod_cab
	into :ls_a_cod_abi,:ls_a_cod_cab
	from banca_appoggio,
		  banca_azienda
	where banca_azienda.id_banca_azienda=:ls_a_banca and
	banca_appoggio.id_banca_appoggio=banca_azienda.id_banca_appoggio;	
	
end if

if ls_sel_b='S' then
	select banca_appoggio.cod_abi,banca_appoggio.cod_cab
	into :ls_da_cod_abi,:ls_da_cod_cab
	from banca_appoggio,
		  banca_sog_commerciale_gen
	where banca_sog_commerciale_gen.id_banca_sog_commerciale=:ls_da_banca and
	banca_appoggio.id_banca_appoggio=banca_sog_commerciale_gen.id_banca_appoggio;	
	
	select banca_appoggio.cod_abi,banca_appoggio.cod_cab
	into :ls_a_cod_abi,:ls_a_cod_cab
	from banca_appoggio,
		  banca_sog_commerciale_gen
	where banca_sog_commerciale_gen.id_banca_sog_commerciale=:ls_a_banca and
	banca_appoggio.id_banca_appoggio=banca_sog_commerciale_gen.id_banca_appoggio;	
	
end if



if ld_da_data>ld_a_data then
	messagebox("stampa lista effetti per banca e scadenza","La data iniziale è maggiore di quella finale!",exclamation!)
else
if ls_da_cod_abi>ls_a_cod_abi then
	messagebox("stampa lista effetti per banca e scadenza","Il codice ABI iniziale è maggiore di quello finale!",exclamation!)
else
if ls_da_cod_cab>ls_a_cod_cab then
	messagebox("stampa lista effetti per banca e scadenza","Il codice CAB iniziale è maggiore di quello finale!",exclamation!)
else
if ls_da_pag>ls_a_pag then
	messagebox("stampa lista effetti per banca e scadenza","Il pagamento iniziale è maggiore di quello finale!",exclamation!)
else

if ls_da_cod_abi<>''and ls_filtro='' then
	ls_filtro='banca_appoggio_cod_abi>='+'"'+string(ls_da_cod_abi)+'"'
	ls_filtro=ls_filtro+' and (banca_appoggio_cod_cab>='+'"'+string(ls_da_cod_cab)+'"'+')'
	ls_parametri='Da codici(ABI/CAB):'+ls_da_cod_abi+' / '+ls_da_cod_cab
else
if ls_da_cod_abi<>''and ls_filtro<>'' then
	ls_filtro=ls_filtro+' and (banca_appoggio_cod_abi>='+'"'+string(ls_da_cod_abi)+'"'+')'
	ls_filtro=ls_filtro+' and (banca_appoggio_cod_cab>='+'"'+string(ls_da_cod_cab)+'"'+')'
	ls_parametri='Da codici(ABI/CAB):'+ls_da_cod_abi+' / '+ls_da_cod_cab
end if
end if
if ls_a_cod_abi<>''and ls_filtro='' then
	ls_filtro='banca_appoggio_cod_abi<='+'"'+string(ls_a_cod_abi)+'"'
	ls_filtro=ls_filtro+' and (banca_appoggio_cod_cab<='+'"'+string(ls_a_cod_cab)+'"'+')'
	ls_parametri=ls_parametri+'A codici(ABI / CAB):'+ls_a_cod_abi+' / '+ls_a_cod_cab
else
if ls_a_cod_abi<>''and ls_filtro<>'' then
	ls_filtro=ls_filtro+' and (banca_appoggio_cod_abi<='+'"'+string(ls_a_cod_abi)+'"'+')'
	ls_filtro=ls_filtro+' and (banca_appoggio_cod_cab<='+'"'+string(ls_a_cod_cab)+'"'+')'
	ls_parametri=ls_parametri+'A codici(ABI / CAB):'+ls_a_cod_abi+' / '+ls_a_cod_cab
end if
end if

if ls_da_pag<>''and ls_filtro='' then
	ls_filtro='tipo_pagamento_codice>='+'"'+string(ls_da_pag)+'"'
	ls_parametri=ls_parametri+'- Da tipo pagamento:'+ls_da_pag
	
else
if ls_da_pag<>''and ls_filtro<>'' then
	ls_filtro=ls_filtro+' and (tipo_pagamento_codice>='+'"'+string(ls_da_pag)+'"'+')'
	ls_parametri=ls_parametri+'- Da tipo pagamento:'+ls_da_pag
end if
end if
if ls_a_pag<>''and ls_filtro='' then
	ls_filtro='tipo_pagamento_codice<='+'"'+string(ls_a_pag)+'"'
	ls_parametri=ls_parametri+'- A tipo pagamento:'+ls_a_pag
else
if ls_a_pag<>''and ls_filtro<>'' then
	ls_filtro=ls_filtro+' and (tipo_pagamento_codice<='+'"'+string(ls_a_pag)+'"'+')'
	ls_parametri=ls_parametri+'- A tipo pagamento:'+ls_a_pag
end if
end if
if not isnull(ld_da_data) and ls_filtro='' then
	ls_filtro='scadenza_data_scadenza>=date("'+string(ld_da_data)+'")'
	ls_parametri=ls_parametri+'Da data scadenza:'+string(ld_da_data)
else

if not isnull(ld_da_data) and ls_filtro<>'' then
	ls_filtro=ls_filtro+' and (scadenza_data_scadenza>=date("'+string(ld_da_data)+'"))'
	ls_parametri=ls_parametri+'Da data scadenza:'+string(ld_da_data)
end if
end if
if not isnull(ld_da_data) and ls_filtro='' then
	ls_filtro='scadenza_data_scadenza<=date("'+string(ld_a_data)+'")'
	ls_parametri=ls_parametri+'A data scadenza:'+string(ld_a_data)
else

if not isnull(ld_da_data) and ls_filtro<>'' then
	ls_filtro=ls_filtro+' and (scadenza_data_scadenza<=date("'+string(ld_a_data)+'"))'
	ls_parametri=ls_parametri+'A data scadenza:'+string(ld_a_data)
end if
end if

str_param.filtro=ls_filtro
str_param.parametri=ls_parametri


if ls_sel_B='A'and ls_totali='N' then
openwithparm(w_stp_list_eff_az_gd,str_param)
end if
if ls_sel_B='A'and ls_totali='S' then
openwithparm(w_stp_list_eff_az_tot_gd,str_param)
end if 
if ls_sel_B='S'and ls_totali='N' then
openwithparm(w_stp_list_eff_sogg_gd,str_param)
end if 
if ls_sel_B='S'and ls_totali='S' then
openwithparm(w_stp_list_eff_sogg_tot_gd,str_param)
end if 
end if
end if
end if
end if
end event

type cb_annulla from commandbutton within w_stp_lista_eff_cx
int X=2171
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

type dw_1 from u_dw_ext_main within w_stp_lista_eff_cx
event type integer ue_tipo_reg ( )
int X=27
int Y=172
int Width=2519
int Height=1040
int TabOrder=10
string DataObject="d_lista_eff_cx"
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

