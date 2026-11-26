forward
global type w_stp_mag_val_cx from Window
end type
type dw_1 from u_dw_ext_main within w_stp_mag_val_cx
end type
type cb_2 from commandbutton within w_stp_mag_val_cx
end type
type cb_1 from commandbutton within w_stp_mag_val_cx
end type
end forward

global type w_stp_mag_val_cx from Window
int X=832
int Y=364
int Width=2779
int Height=928
boolean TitleBar=true
string Title="Stampa Movimenti Articoli Causale"
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
dw_1 dw_1
cb_2 cb_2
cb_1 cb_1
end type
global w_stp_mag_val_cx w_stp_mag_val_cx

on w_stp_mag_val_cx.create
this.dw_1=create dw_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.dw_1,&
this.cb_2,&
this.cb_1}
end on

on w_stp_mag_val_cx.destroy
destroy(this.dw_1)
destroy(this.cb_2)
destroy(this.cb_1)
end on

event open;dw_1.insertrow(0)
dw_1.setfocus()
datawindowchild ldw_da_mag_cod,ldw_da_mag_des,ldw_a_mag_cod,ldw_a_mag_des




 
 dw_1.setitem(1,"costo",'U')
 dw_1.setitem(1,"ragg",'N')

 dw_1.Getchild('da_mag',ldw_da_mag_cod)
 ldw_da_mag_cod.settransobject(sqlca)
 ldw_da_mag_cod.retrieve()
 dw_1.Getchild('da_mag_des',ldw_da_mag_des)
 ldw_da_mag_des.settransobject(sqlca)
 ldw_da_mag_des.retrieve()

 dw_1.Getchild('a_mag',ldw_a_mag_cod)
 ldw_a_mag_cod.settransobject(sqlca)
 ldw_a_mag_cod.retrieve()
 dw_1.Getchild('a_mag_des',ldw_a_mag_des)
 ldw_a_mag_des.settransobject(sqlca)
 ldw_a_mag_des.retrieve()
 
 

end event

event key;
keycode			lk_code
string			ls_nome
windowobject	lw_me

lk_code = key

choose case lk_code
	case KeyF12!
		if keyflags=3 then
			ls_nome = this.ClassName()
			MessageBox ("ClassName",ls_nome)
		end if
	case KeyF1!
		if (keyflags = 0 Or keyflags = 1 Or keyflags = 2) then
		end if
end choose
end event

type dw_1 from u_dw_ext_main within w_stp_mag_val_cx
int X=37
int Y=144
int Width=2670
int Height=648
int TabOrder=30
string DataObject="d_mag_val_cx"
end type

event ue_set_search;call super::ue_set_search;CHOOSE CASE as_nomecol
	CASE "da_articolo_cod"
		is_search_window="w_articolo_coddes_sw"
		is_ricpar.s_filter_value=as_valcol
		is_ricpar.s_filter_name="articolo_codice"
		CASE "a_articolo_cod"
		is_search_window="w_articolo_coddes_sw"
		is_ricpar.s_filter_value=as_valcol
		is_ricpar.s_filter_name="articolo_codice"
	case "da_articolo_des"
		is_search_window="w_articolo_coddes_sw"
		is_ricpar.s_filter_value=as_valcol
		is_ricpar.s_filter_name="articolo_descrizione"
		case "a_articolo_des"
		is_search_window="w_articolo_coddes_sw"
		is_ricpar.s_filter_value=as_valcol
		is_ricpar.s_filter_name="articolo_descrizione"
END CHOOSE

end event

event ue_use_search;CHOOSE CASE as_nomecol
		
	CASE "da_articolo_cod", "a_articolo_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		if as_nomecol = "da_articolo_cod" then
			uf_set_colval("da_articolo_des", is_ricpar.s_ausil_value[1])
			if isnull(this.getitemstring(1,"a_articolo_cod")) or this.getitemstring(1,"a_articolo_cod")='' then
			      uf_set_colval("a_articolo_cod", is_ricpar.s_main_value)	
					uf_set_colval("a_articolo_des", is_ricpar.s_ausil_value[1])
		   end if		
		else
			uf_set_colval("a_articolo_des", is_ricpar.s_ausil_value[1])
		end if
		
	CASE "da_articolo_des", "a_articolo_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		if as_nomecol = "da_articolo_des" then
			uf_set_colval("da_articolo_cod", is_ricpar.s_ausil_value[1])
			if isnull(this.getitemstring(1,"a_articolo_cod")) or this.getitemstring(1,"a_articolo_cod")='' then
				uf_set_colval("a_articolo_des", is_ricpar.s_main_value)	
				uf_set_colval("a_articolo_cod", is_ricpar.s_ausil_value[1])
			end if					
		else
			uf_set_colval("a_articolo_cod", is_ricpar.s_ausil_value[1])
		end if
end choose	

end event

event ue_init;call super::ue_init;
end event

event itemchanged;string	ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
string	ls_cod,ls_des,v_null
long		ll_ok
setnull(v_null)
choose case dwo.name		
		
	case 'da_articolo_cod'
		
		ls_sql_cond=""  
		ls_dbc[1]=	"codice"
		ls_dwc[1]=	"da_articolo_cod"
		ls_dbc[2]=	"descrizione"
		ls_dwc[2]=	"da_articolo_des"
		ll_ok = uf_autofind_col(dwo.name,"articolo","codice","A",data,&
		                                ls_sql_cond,2,ls_dbc, ls_dbv, ls_dwc)
												 
		if ll_ok	= 0 then
			if isnull(this.getitemstring(1,'a_articolo_cod')) or this.getitemstring(1,'a_articolo_cod')='' then
			  this.setitem(1,"a_articolo_cod",data)
			  this.setitem(1,"a_articolo_des",this.getitemstring(1,"da_articolo_des"))
		   end if	
			return 2
		end if	
	
	case 'da_articolo_des'
		
		ls_sql_cond=""  
		ls_dbc[1]=	"codice"
		ls_dwc[1]=	"da_articolo_cod"
		ls_dbc[2]=	"descrizione"
		ls_dwc[2]=	"da_articolo_des"
		ll_ok = uf_autofind_col(dwo.name,"articolo","descrizione","A",data,&
		                                ls_sql_cond,2,ls_dbc, ls_dbv, ls_dwc)										  
												 
		if ll_ok	= 0 then
			if isnull(this.getitemstring(1,"a_articolo_cod")) or this.getitemstring(1,"a_articolo_cod")='' then
			   this.setitem(1,"a_articolo_des",data)
			   this.setitem(1,"a_articolo_cod",this.getitemstring(1,"da_articolo_cod"))
		   end if	
			return 2
		end if	
		
	case 'a_articolo_cod'
		
		ls_sql_cond=""  
		ls_dbc[1]=	"codice"
		ls_dwc[1]=	"a_articolo_cod"
		ls_dbc[2]=	"descrizione"
		ls_dwc[2]=	"a_articolo_des"
		ll_ok = uf_autofind_col(dwo.name,"articolo","codice","A",data,&
		                                ls_sql_cond,2,ls_dbc, ls_dbv, ls_dwc)
												  
		if ll_ok	= 0 then
			return 2
		end if											  
	
	case 'a_articolo_des'
		
		ls_sql_cond=""  
		ls_dbc[1]=	"codice"
		ls_dwc[1]=	"a_articolo_cod"
		ls_dbc[2]=	"descrizione"
		ls_dwc[2]=	"a_articolo_des"
		ll_ok = uf_autofind_col(dwo.name,"articolo","descrizione","A",data,&
		                                ls_sql_cond,2,ls_dbc, ls_dbv, ls_dwc)
												  										  
		if ll_ok	= 0 then
			return 2
		end if	
	case 'ragg'
		
		dw_1.setitem(1,'da_articolo_cod',v_null)
		dw_1.setitem(1,'da_articolo_des',v_null)
		dw_1.setitem(1,'a_articolo_cod',v_null)
		dw_1.setitem(1,'a_articolo_des',v_null)
		dw_1.setitem(1,'da_articolo_cod',v_null)
		dw_1.setitem(1,'da_articolo_des',v_null)
		dw_1.setitem(1,'a_articolo_cod',v_null)
		dw_1.setitem(1,'a_articolo_des',v_null)
		dw_1.setitem(1,'da_mag',v_null)
		dw_1.setitem(1,'da_mag_des',v_null)
		dw_1.setitem(1,'a_mag',v_null)
		dw_1.setitem(1,'a_mag_des',v_null)
		
		
		if data='S' then
			dw_1.object.da_articolo_cod.visible=0
			dw_1.object.da_articolo_des.visible=0
			dw_1.object.da_articolo_cod_sw.visible=0
			dw_1.object.da_articolo_des_sw.visible=0
			dw_1.object.da_articolo_cod_t.visible=0
			dw_1.object.a_articolo_cod.visible=0
			dw_1.object.a_articolo_des.visible=0
			dw_1.object.a_articolo_cod_sw.visible=0
			dw_1.object.a_articolo_des_sw.visible=0
			
			dw_1.object.a_articolo_cod_t.visible=0
			dw_1.object.da_mag_t.y=296
			dw_1.object.da_mag_des.y=296
			dw_1.object.da_mag.y=296
			
			dw_1.object.a_mag.y=436
			dw_1.object.a_mag_des.y=436
			
			dw_1.object.a_mag_t.y=436
			
		else
			dw_1.object.da_articolo_cod.visible=1
			dw_1.object.da_articolo_des.visible=1
			dw_1.object.da_articolo_cod_sw.visible=1
			dw_1.object.da_articolo_cod_t.visible=1
			dw_1.object.a_articolo_cod.visible=1
			dw_1.object.a_articolo_des.visible=1
			dw_1.object.da_articolo_des_sw.visible=1
			dw_1.object.a_articolo_des_sw.visible=1
			dw_1.object.a_articolo_cod_sw.visible=1
			dw_1.object.a_articolo_cod_t.visible=1
			dw_1.object.da_mag_t.y=652
			dw_1.object.da_mag_des.y=652
			dw_1.object.da_mag.y=652
			
			dw_1.object.a_mag.y=760
			dw_1.object.a_mag_des.y=760
			
			dw_1.object.a_mag_t.y=760
						
		end if
end choose
end event

type cb_2 from commandbutton within w_stp_mag_val_cx
int X=2121
int Y=28
int Width=261
int Height=88
int TabOrder=20
string Text="Stam&pa"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
string ls_da_articolo,ls_a_articolo,ls_da_magaz,ls_a_magaz,ls_ragg,ls_costo
string ls_filtro,ls_parametri
long ll_da_prot,ll_a_prot
date ld_data
str_mag_val str_param

dw_1.accepttext()
ld_data=dw_1.getitemdate(1,"val_al")

ls_da_articolo=dw_1.getitemstring(1,"da_articolo_cod")
ls_a_articolo=dw_1.getitemstring(1,"a_articolo_cod")
ls_da_magaz=dw_1.getitemstring(1,"da_mag")
ls_a_magaz=dw_1.getitemstring(1,"a_mag")
ls_ragg=dw_1.getitemstring(1,"ragg")
ls_costo=dw_1.getitemstring(1,"costo")

if isnull(ld_data) then 
	messagebox("Attenzione","La data di valorizzazione deve essere specificata!",exclamation!)
else
	
if ls_da_articolo>ls_a_articolo then
	messagebox("stampa movimenti per causale","Il codice dell'articolo iniziale è maggiore di quello finale",exclamation!)
else 
if ls_da_magaz>ls_a_magaz then
	messagebox("stampa movimenti per causale","Il codice della categoria commerciale iniziale è maggiore di quello finale",exclamation!)
else
	



if ls_da_articolo<>''and ls_filtro='' then
	ls_filtro='articolo_codice>='+'"'+string(ls_da_articolo)+'"'
	ls_parametri='Da articolo: '+ls_da_articolo
else
if ls_da_articolo<>''and ls_filtro<>'' then
	ls_filtro=ls_filtro+' and (articolo_codice>='+'"'+string(ls_da_articolo)+'"'+')'
	ls_parametri='Da articolo: '+ls_da_articolo
end if
end if
if ls_a_articolo<>''and ls_filtro='' then
	ls_filtro='articolo_codice<='+'"'+string(ls_a_articolo)+'"'
	ls_parametri=ls_parametri+' - A articolo: '+ls_a_articolo
else
if ls_a_articolo<>''and ls_filtro<>'' then
	ls_filtro=ls_filtro+' and (articolo_codice<='+'"'+string(ls_a_articolo)+'"'+')'
	ls_parametri=ls_parametri+' - A articolo: '+ls_a_articolo
end if
end if





if ls_da_magaz<>''and ls_filtro='' then
	ls_filtro='ccodice>='+'"'+string(ls_da_magaz)+'"'
	ls_parametri=ls_parametri+' - Da magazzino: '+ls_da_magaz
else
if ls_da_magaz<>''and ls_filtro<>'' then
	ls_filtro=ls_filtro+' and (ccodice>='+'"'+string(ls_da_magaz)+'"'+')'
	ls_parametri=ls_parametri+' - Da magazzino: '+ls_da_magaz
end if
end if
if ls_a_magaz<>''and ls_filtro='' then
	ls_filtro='ccodice<='+'"'+string(ls_a_magaz)+'"'
	ls_parametri=ls_parametri+' - A magazzino: '+ls_a_magaz
else
if ls_a_magaz<>''and ls_filtro<>'' then
	ls_filtro=ls_filtro+' and (ccodice<='+'"'+string(ls_a_magaz)+'"'+')'
	ls_parametri=ls_parametri+' - A magazzino: '+ls_a_magaz
end if
end if




messagebox("a",ls_filtro)

str_param.filtro=ls_filtro
str_param.parametri=ls_parametri
str_param.data=ld_data
str_param.costo=ls_costo

if ls_ragg='S'then
openwithparm(w_stp_mag_val_mag_gd,str_param)
else
openwithparm(w_stp_mag_val_gd,str_param)
end if
end if 
end if
end if


end event

type cb_1 from commandbutton within w_stp_mag_val_cx
int X=2441
int Y=28
int Width=261
int Height=88
int TabOrder=10
string Text="&Annulla"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close (parent)
end event

