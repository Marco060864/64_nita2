forward
global type w_esplosione_riepilogativa from Window
end type
type tv_1 from u_tv_distinta within w_esplosione_riepilogativa
end type
type cb_7 from commandbutton within w_esplosione_riepilogativa
end type
type cb_6 from commandbutton within w_esplosione_riepilogativa
end type
type cb_5 from commandbutton within w_esplosione_riepilogativa
end type
type cb_4 from commandbutton within w_esplosione_riepilogativa
end type
type dw_1 from datawindow within w_esplosione_riepilogativa
end type
type cb_3 from commandbutton within w_esplosione_riepilogativa
end type
type cb_1 from commandbutton within w_esplosione_riepilogativa
end type
end forward

global type w_esplosione_riepilogativa from Window
int X=4
int Y=6
int Width=3657
int Height=1581
boolean TitleBar=true
string Title="Esplosione Riepilogativa"
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
global w_esplosione_riepilogativa w_esplosione_riepilogativa

type variables
long il_zoom
end variables

forward prototypes
public subroutine wf_riepilogativa (integer disponibilita)
end prototypes

event ue_post_open;dw_1.Height=(this.Height) - 272
dw_1.Object.DataWindow.Print.Preview='yes'

end event

public subroutine wf_riepilogativa (integer disponibilita);
string ls_conto_visione,unita_misura
decimal ld_esistenza,ld_carico,ld_scarico,ld_ordinato_fo,ld_impegnato_cl,ld_disponibilita
long ll_righe,i,ll_art
string ls_car_fiscali,ls_sca_fiscali,ls_ord_clienti,ls_ord_fornitori,ls_vis_clienti
string ls_vis_fornitori,ls_cl_clienti,ls_cl_fornitori,ls_imp_produzione,ls_ord_produzione
string ls_gr_lib_1,ls_gr_lib_2,ls_gr_lib_3,ls_gr_lib_4
decimal ls_car_fiscali_a,ls_sca_fiscali_a,ls_ord_clienti_a,ls_ord_fornitori_a,ls_vis_clienti_a
decimal ls_vis_fornitori_a,ls_cl_clienti_a,ls_cl_fornitori_a,ls_imp_produzione_a
decimal ls_ord_produzione_a,ls_gr_lib_1_a,ls_gr_lib_2_a,ls_gr_lib_3_a,ls_gr_lib_4_a
ll_righe=dw_1.rowcount()
for i=1 to ll_righe
	ll_art=dw_1.getitemnumber(i,"id_articolo")
	
		select sum(qta_caricata)-sum(qta_scaricata)
		into :ld_esistenza
		from riepilogo
		where id_articolo=:ll_art;
	if isnull(ld_esistenza) then ld_esistenza=0
	dw_1.setitem(i,"esistenza",ld_esistenza)

	select car_fiscali,sca_fiscali,ord_clienti,ord_fornitori,vis_clienti,vis_fornitori,&
			 cl_clienti,cl_fornitori,imp_produzione,ord_produzione,gr_lib_1,gr_lib_2,gr_lib_3,&
			 gr_lib_4 
	into :ls_car_fiscali,:ls_sca_fiscali,:ls_ord_clienti,:ls_ord_fornitori,:ls_vis_clienti&
	 ,:ls_vis_fornitori,:ls_cl_clienti,:ls_cl_fornitori,:ls_imp_produzione,:ls_ord_produzione
	 ,:ls_gr_lib_1,:ls_gr_lib_2,:ls_gr_lib_3,:ls_gr_lib_4
	from par_disponibilita
	where id_par_disponibilita=:disponibilita;
	if sqlca.sqlcode=0 then
		if isnull(ls_car_fiscali) then ls_car_fiscali=""
		if isnull(ls_sca_fiscali) then ls_sca_fiscali=""
		if isnull(ls_vis_fornitori) then ls_vis_fornitori=""
		if isnull(ls_vis_clienti) then ls_vis_clienti=""
		if isnull(ls_ord_clienti) then ls_ord_clienti=""
		if isnull(ls_ord_fornitori) then ls_ord_fornitori=""
		if isnull(ls_cl_clienti) then ls_cl_clienti=""
		if isnull(ls_cl_fornitori) then ls_cl_fornitori=""
		if isnull(ls_imp_produzione) then ls_imp_produzione=""
		if isnull(ls_ord_produzione) then ls_ord_produzione=""
		if isnull(ls_gr_lib_1) then ls_gr_lib_1=""
		if isnull(ls_gr_lib_2) then ls_gr_lib_2=""
		if isnull(ls_gr_lib_3) then ls_gr_lib_3=""
		if isnull(ls_gr_lib_4) then ls_gr_lib_4=""
		select sum(qta_caricata),sum(qta_scaricata),sum(qta_ord_clienti),sum(qta_ord_fornitori),&
		sum(qta_vis_clienti),sum(qta_vis_fornitori),sum(qta_imp_produzione),&
		sum(qta_cl_clienti),sum(qta_cl_fornitori),sum(qta_ord_produzione),&
		sum(qta_gruppo_lib_1),sum(qta_gruppo_lib_2),sum(qta_gruppo_lib_3),sum(qta_gruppo_lib_4)
		into :ls_car_fiscali_a,:ls_sca_fiscali_a,:ls_ord_clienti_a,:ls_ord_fornitori_a,&
		:ls_vis_clienti_a,:ls_vis_fornitori_a,:ls_cl_clienti_a,:ls_cl_fornitori_a,&
		:ls_imp_produzione_a,:ls_ord_produzione_a,:ls_gr_lib_1_a,:ls_gr_lib_2_a,&
		:ls_gr_lib_3_a,:ls_gr_lib_4_a
		from riepilogo
		where id_articolo=:ll_art;
		if isnull(ls_car_fiscali_a) then ls_car_fiscali_a=0
		if isnull(ls_sca_fiscali_a) then ls_sca_fiscali_a=0
		if isnull(ls_vis_fornitori_a) then ls_vis_fornitori_a=0
		if isnull(ls_vis_clienti_a) then ls_vis_clienti_a=0
		if isnull(ls_ord_clienti_a) then ls_ord_clienti_a=0
		if isnull(ls_ord_fornitori_a) then ls_ord_fornitori_a=0
		if isnull(ls_cl_clienti_a) then ls_cl_clienti_a=0
		if isnull(ls_cl_fornitori_a) then ls_cl_fornitori_a=0
		if isnull(ls_imp_produzione_a) then ls_imp_produzione_a=0
		if isnull(ls_ord_produzione_a) then ls_ord_produzione_a=0
		if isnull(ls_gr_lib_1_a) then ls_gr_lib_1_a=0
		if isnull(ls_gr_lib_2_a) then ls_gr_lib_2_a=0
		if isnull(ls_gr_lib_3_a) then ls_gr_lib_3_a=0
		if isnull(ls_gr_lib_4_a) then ls_gr_lib_4_a=0

	  ls_car_fiscali    += string(ls_car_fiscali_a)
	  ls_sca_fiscali    += string(ls_sca_fiscali_a) 	
	  ls_vis_fornitori  += string(ls_vis_fornitori_a)
	  ls_vis_clienti    += string(ls_vis_clienti_a) 
	  ls_ord_clienti    += string(ls_ord_clienti_a)  
	  ls_ord_fornitori  += string(ls_ord_fornitori_a)
	  ls_cl_clienti     += string(ls_cl_clienti_a)
	  ls_cl_fornitori   += string(ls_cl_fornitori_a)
	  ls_imp_produzione += string(ls_imp_produzione_a)
	  ls_ord_produzione += string(ls_ord_produzione_a)
	  ls_gr_lib_1 		  += string(ls_gr_lib_1_a)
	  ls_gr_lib_2 		  += string(ls_gr_lib_2_a) 	
	  ls_gr_lib_3 		  += string(ls_gr_lib_3_a)
	  ls_gr_lib_4 		  += string(ls_gr_lib_4_a)
	
		  ld_disponibilita= dec(ls_car_fiscali)+dec(ls_sca_fiscali)+dec(ls_vis_fornitori)+&
				dec(ls_vis_clienti)+dec(ls_ord_clienti)+dec(ls_ord_fornitori)+&
				dec(ls_cl_clienti)+dec(ls_cl_fornitori)+dec(ls_imp_produzione)+&
				dec(ls_ord_produzione)+dec(ls_gr_lib_1)+dec(ls_gr_lib_2)+&
				dec(ls_gr_lib_3)+dec(ls_gr_lib_4)
		if isnull(ld_disponibilita) then ld_disponibilita=0
		dw_1.setitem(i,"disponibilita",ld_disponibilita)	
	end if
	
	
	select u.descrizione
	into :unita_misura
	from unita_confezione , unita_misura u
	where u.id_unita_misura=unita_confezione.id_unita_misura
	and unita_confezione.id_articolo=:ll_art;
	dw_1.setitem(i,"unita_misura",unita_misura)
next


end subroutine

event open;long ll_rows,i
string ls_cod,ls_des
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
open(w_par_disponibilita_fabbisogno_lt)
ll_disponibilita=message.doubleparm

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
f_fabbisogno(tv_1,ll_handle,true,ll_distinta,ld_1,ld_2,ll_distinta,tipo_calcolo,tipo_applicazione,false,dw_1,ld_quantita)
wf_riepilogativa(ll_disponibilita)
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
next

il_zoom=100
this.event post ue_post_open()
end event

on w_esplosione_riepilogativa.create
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

on w_esplosione_riepilogativa.destroy
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

type tv_1 from u_tv_distinta within w_esplosione_riepilogativa
int X=1733
int Y=35
int Width=333
int Height=93
int TabOrder=40
boolean Visible=false
end type

type cb_7 from commandbutton within w_esplosione_riepilogativa
event clicked pbm_bnclicked
int X=2505
int Y=42
int Width=260
int Height=86
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

type cb_6 from commandbutton within w_esplosione_riepilogativa
event clicked pbm_bnclicked
int X=2231
int Y=42
int Width=260
int Height=86
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

type cb_5 from commandbutton within w_esplosione_riepilogativa
int X=680
int Y=42
int Width=468
int Height=86
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

type cb_4 from commandbutton within w_esplosione_riepilogativa
int X=1163
int Y=42
int Width=468
int Height=86
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

type dw_1 from datawindow within w_esplosione_riepilogativa
int X=22
int Y=141
int Width=3613
int Height=1261
int TabOrder=60
string DataObject="d_esplosione_ripilogativa_lt"
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

type cb_3 from commandbutton within w_esplosione_riepilogativa
int X=3387
int Y=42
int Width=249
int Height=86
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

type cb_1 from commandbutton within w_esplosione_riepilogativa
int X=22
int Y=42
int Width=249
int Height=86
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

