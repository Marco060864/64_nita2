forward
global type w_stampa_listini_cx from w_wiz_main
end type
type cb_ok from commandbutton within w_stampa_listini_cx
end type
type cb_annulla from commandbutton within w_stampa_listini_cx
end type
type dw_1 from u_dw_ext_main within w_stampa_listini_cx
end type
end forward

global type w_stampa_listini_cx from w_wiz_main
int Width=1975
int Height=900
WindowType WindowType=response!
boolean TitleBar=true
string Title="Stampa Listini e Variazioni"
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
cb_ok cb_ok
cb_annulla cb_annulla
dw_1 dw_1
end type
global w_stampa_listini_cx w_stampa_listini_cx

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

on w_stampa_listini_cx.create
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

on w_stampa_listini_cx.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.cb_annulla)
destroy(this.dw_1)
end on

event closequery;call super::closequery;

end event

event open;call super::open;dw_1.insertrow(1)

datawindowchild ldw_da_listino,ldw_a_listino,ldw_da_listino_des,ldw_a_listino_des
dw_1.getchild("da_listino",ldw_da_listino)
dw_1.getchild("da_listino_des",ldw_da_listino_des)
dw_1.getchild("a_listino_des",ldw_a_listino_des)

dw_1.getchild("a_listino",ldw_a_listino)

dw_1.accepttext()


ldw_da_listino.settransobject(sqlca)
ldw_da_listino.retrieve()
	
ldw_da_listino_des.settransobject(sqlca)
ldw_da_listino_des.retrieve()
	
ldw_a_listino.settransobject(sqlca)
ldw_a_listino.retrieve()
		
ldw_a_listino_des.settransobject(sqlca)
ldw_a_listino_des.retrieve()


end event

type cb_ok from commandbutton within w_stampa_listini_cx
event clicked pbm_bnclicked
int X=1390
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
string ls_filtro,ls_da_list,ls_a_list, ls_tipo_list,ls_parametri
date ld_da_data,ld_a_data
str_fil_flag str_param
dw_1.accepttext()

ls_da_list=dw_1.getitemstring(1,"da_listino")
ls_a_list=dw_1.getitemstring(1,"a_listino")
ld_da_data=dw_1.getitemdate(1,"data_var")
ld_a_data=dw_1.getitemdate(1,"data_var2")
if ld_da_data>ld_a_data then
	messagebox("Stampa Listini","la data iniziale è maggiore di quella finale",exclamation!)
else

if ls_da_list>ls_a_list then
	messagebox("Stampa Listini","Il codice del listino iniziale è maggiore di quello finale",exclamation!)
else
	
	



if not isnull(ld_da_data) and ls_filtro='' then
	ls_filtro='variazione_data_inizio>=date("'+string(ld_da_data)+'")'
	ls_parametri='Da data:'+string(ld_da_data)
else

if not isnull(ld_da_data) and ls_filtro<>'' then
	ls_filtro=ls_filtro+' and (variazione_data_inizio>=date("'+string(ld_da_data)+'"))'
	ls_parametri='Da data:'+string(ld_da_data)
end if
end if


if not isnull(ld_a_data) and ls_filtro='' then
	ls_filtro='variazione_data_fine<=date("'+string(ld_a_data)+'")'
	ls_parametri=ls_parametri+'- A data:'+string(ld_a_data)
else

if not isnull(ld_a_data) and ls_filtro<>'' then
	ls_filtro=ls_filtro+' and ((variazione_data_fine<=date("'+string(ld_a_data)+'"))or isnull(variazione_data_fine))'
	ls_parametri=ls_parametri+'- A data:'+string(ld_a_data)
end if
end if
	
str_param.da_listino=ls_da_list
str_param.a_listino=ls_a_list
str_param.filtro=ls_filtro
str_param.parametri=ls_parametri
	
openwithparm(w_stampa_listini_gd,str_param)
end if 
end if
end event

type cb_annulla from commandbutton within w_stampa_listini_cx
int X=1687
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

type dw_1 from u_dw_ext_main within w_stampa_listini_cx
event type integer ue_tipo_reg ( )
int X=32
int Y=152
int Width=1897
int Height=632
int TabOrder=10
string DataObject="d_sel_listino2"
end type

event ue_tipo_reg;call super::ue_tipo_reg;long						ll_ret,ll_num,ll_id_attivita
datawindowchild		ldw_child,ldw_des

SetNull(ll_num)

this.AcceptText()
ll_id_attivita=this.getitemnumber(1,"id_attivita")
this.GetChild("Numero_registro", ldw_child)
this.GetChild("descrizione", ldw_des)
this.SetItem( this.GetRow(),"Numero_registro",ll_num )
ldw_child.SetTransObject(SQLCA)
ldw_child.Retrieve(is_tipo_reg, il_id_esercizio,ll_id_attivita)
ldw_des.SetTransObject(SQLCA)
ldw_des.Retrieve(is_tipo_reg, il_id_esercizio,ll_id_attivita)
return 0
end event

event itemchanged;
string 	ls_tipo,ls_codice,ls_codice2, ls_filtro
long 		ll_id_listino,ret

datawindowchild ldw_da_listino,ldw_a_listino,ldw_da_listino_des,ldw_a_listino_des
ret=this.getchild("da_listino",ldw_da_listino)
this.getchild("da_listino_des",ldw_da_listino_des)
this.getchild("a_listino_des",ldw_a_listino_des)

ret=this.getchild("a_listino",ldw_a_listino)

this.accepttext()

CHOOSE CASE dwo.name
	CASE "tipo_listino"
		ls_tipo=this.getitemstring(1,"tipo_listino")
		
		SetNull(ls_filtro)

		if ls_tipo <>'' then
			ls_filtro='tipo='+'"'+string(ls_tipo)+'"'
	
			ldw_da_listino.setfilter(ls_filtro)
			ldw_da_listino.filter()
		
			ldw_da_listino_des.setfilter(ls_filtro)
			ldw_da_listino_des.filter()	
				
			ldw_a_listino.setfilter(ls_filtro)
			ldw_a_listino.filter()
			
			ldw_a_listino_des.setfilter(ls_filtro)
			ldw_a_listino_des.filter()	
		end if
		
	CASE "da_listino"
		if isnull(dw_1.GetItemString(1, "a_listino")) or dw_1.GetItemString(1, "da_listino")='' then
		dw_1.SetItem(1, "a_listino", dw_1.GetItemString(1, "da_listino"))
	   end if
END CHOOSE

end event

event itemfocuschanged;call super::itemfocuschanged;

end event

