forward
global type w_implosione_riepilogativa_lt from Window
end type
type tv_1 from u_tv_distinta within w_implosione_riepilogativa_lt
end type
type cb_7 from commandbutton within w_implosione_riepilogativa_lt
end type
type cb_6 from commandbutton within w_implosione_riepilogativa_lt
end type
type cb_5 from commandbutton within w_implosione_riepilogativa_lt
end type
type cb_4 from commandbutton within w_implosione_riepilogativa_lt
end type
type dw_1 from datawindow within w_implosione_riepilogativa_lt
end type
type cb_3 from commandbutton within w_implosione_riepilogativa_lt
end type
type cb_1 from commandbutton within w_implosione_riepilogativa_lt
end type
end forward

global type w_implosione_riepilogativa_lt from Window
int X=5
int Y=4
int Width=3657
int Height=1580
boolean TitleBar=true
string Title="Implosione Riepilogativa"
long BackColor=79741120
boolean ControlMenu=true
WindowState WindowState=maximized!
WindowType WindowType=response!
event ue_post_open ( )
tv_1 tv_1
cb_7 cb_7
cb_6 cb_6
cb_5 cb_5
cb_4 cb_4
dw_1 dw_1
cb_3 cb_3
cb_1 cb_1
end type
global w_implosione_riepilogativa_lt w_implosione_riepilogativa_lt

type variables
long il_zoom
end variables

event ue_post_open;dw_1.Height=(this.Height) - 272
dw_1.Object.DataWindow.Print.Preview='yes'

end event

event open;long ll_rows,i
string ls_cod,ls_des,ls_cod_art,ls_des_art

s_fabbisogno dat
dat=message.powerobjectparm

dw_1.settransobject(sqlca)
dw_1.retrieve(dat.id_distinta)
ll_rows=dw_1.rowcount()
for i=1 to ll_rows
	dw_1.setitem(i,"data_in",dat.data_inizio)
	dw_1.setitem(i,"data_fin",dat.data_fine)
	dw_1.setitem(i,"qta",dat.quantita)
next

long ll_distinta,ll_handle,ll_disponibilita
date ld_1,ld_2
decimal ld_quantita
string tipo_calcolo,tipo_applicazione
s_fabbisogno s_app
s_app=message.powerobjectparm
ld_1=s_app.data_inizio
ld_2=s_app.data_fine
ld_quantita=s_app.quantita
tipo_calcolo=s_app.tipo_cal_valore
tipo_applicazione=s_app.tipo_applicazione
ll_distinta=s_app.id_distinta
tv_1.deleteitem(0)
ll_handle=tv_1.FindItem(RootTreeItem! , 0)

string ls_codice
long  ll_id_articolo
s_ric_param ls_ric_param
w_search_main lw_sm
ls_codice=""
ls_ric_param.s_filter_value=""
ls_ric_param.s_filter_name="codice"
openwithparm(lw_sm,ls_ric_param,"w_ric_articolo_sw")
ls_ric_param=message.powerobjectparm
if upperbound(ls_ric_param.s_id_seg_value)>0 then
 ll_id_articolo=long(ls_ric_param.s_id_seg_value[1])
 ls_cod_art=ls_ric_param.s_main_value
 ls_des_art=ls_ric_param.s_ausil_value[1]
end if
u_tv_distinta luo_distinta
f_rec_righe_comp(tv_1,0,true,ll_distinta,ld_1,ld_2,ll_distinta,false)
if upperbound(tv_1.is_comp) >0 then 
	luo_distinta=create u_tv_distinta
	luo_distinta.is_comp=tv_1.is_comp
	openwithparm(w_variante_comp_ff,luo_distinta)
	luo_distinta=message.powerobjectparm
	if isvalid(luo_distinta) then 
		tv_1.is_comp=luo_distinta.is_comp
	else
		messagebox("Errore","Si e verificato un errore nel passaggio di parametri")
	end if
	destroy luo_distinta
	tv_1.deleteitem(0)	
end if

f_implosione_scalare(tv_1,ll_handle,true,ll_distinta,ld_1,ld_2,ll_distinta,tipo_calcolo,tipo_applicazione,false,dw_1,ld_quantita,0,ll_id_articolo,true)

ls_cod=dw_1.getitemstring(1,"codice_dis")
ls_des=dw_1.getitemstring(1,"descrizione_dis")
dw_1.deleterow(1)
ll_rows=dw_1.rowcount()
for i=1 to ll_rows
	dw_1.setitem(i,"data_in",dat.data_inizio)
	dw_1.setitem(i,"data_fin",dat.data_fine)
	dw_1.setitem(i,"qta",dat.quantita)
	dw_1.setitem(i,"codice_dis",ls_cod)
	dw_1.setitem(i,"descrizione_dis",ls_des)
	dw_1.setitem(i,"cod_art",ls_cod_art)
	dw_1.setitem(i,"des_art",ls_des_art)
next

il_zoom=100
this.event post ue_post_open()
end event

on w_implosione_riepilogativa_lt.create
this.tv_1=create tv_1
this.cb_7=create cb_7
this.cb_6=create cb_6
this.cb_5=create cb_5
this.cb_4=create cb_4
this.dw_1=create dw_1
this.cb_3=create cb_3
this.cb_1=create cb_1
this.Control[]={this.tv_1,&
this.cb_7,&
this.cb_6,&
this.cb_5,&
this.cb_4,&
this.dw_1,&
this.cb_3,&
this.cb_1}
end on

on w_implosione_riepilogativa_lt.destroy
destroy(this.tv_1)
destroy(this.cb_7)
destroy(this.cb_6)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.dw_1)
destroy(this.cb_3)
destroy(this.cb_1)
end on

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

type tv_1 from u_tv_distinta within w_implosione_riepilogativa_lt
int X=1627
int Y=0
int Width=448
int Height=108
int TabOrder=10
boolean Visible=false
end type

type cb_7 from commandbutton within w_implosione_riepilogativa_lt
event clicked pbm_bnclicked
int X=2505
int Y=40
int Width=261
int Height=84
int TabOrder=30
string Text="Zoom Out"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;il_zoom=il_zoom - 10
dw_1.object.datawindow.zoom=il_zoom
end event

type cb_6 from commandbutton within w_implosione_riepilogativa_lt
event clicked pbm_bnclicked
int X=2231
int Y=40
int Width=261
int Height=84
int TabOrder=40
string Text="Zoom In"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;il_zoom=il_zoom+10
dw_1.object.datawindow.zoom=il_zoom
end event

type cb_5 from commandbutton within w_implosione_riepilogativa_lt
int X=681
int Y=40
int Width=466
int Height=84
int TabOrder=50
string Text="Pagina Precedente"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.ScrollPriorPage ( ) 
end event

type cb_4 from commandbutton within w_implosione_riepilogativa_lt
int X=1161
int Y=40
int Width=466
int Height=84
int TabOrder=20
string Text="Pagina Successiva"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.ScrollNextPage ( ) 
end event

type dw_1 from datawindow within w_implosione_riepilogativa_lt
int X=23
int Y=140
int Width=3611
int Height=1260
int TabOrder=60
string DataObject="d_implosione_riepilogativa_lt"
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

type cb_3 from commandbutton within w_implosione_riepilogativa_lt
int X=3387
int Y=40
int Width=247
int Height=84
int TabOrder=10
string Text="Stampa"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
printsetup()
dw_1.print()
end event

type cb_1 from commandbutton within w_implosione_riepilogativa_lt
int X=23
int Y=40
int Width=247
int Height=84
int TabOrder=70
string Text="Annulla"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(parent)
end event

