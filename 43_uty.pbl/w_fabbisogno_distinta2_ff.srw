forward
global type w_fabbisogno_distinta2_ff from Window
end type
type tv_1 from u_tv_distinta within w_fabbisogno_distinta2_ff
end type
type cb_2 from commandbutton within w_fabbisogno_distinta2_ff
end type
type cb_1 from commandbutton within w_fabbisogno_distinta2_ff
end type
type dw_1 from datawindow within w_fabbisogno_distinta2_ff
end type
end forward

global type w_fabbisogno_distinta2_ff from Window
int X=256
int Y=60
int Width=3104
int Height=1496
boolean TitleBar=true
string Title="Fabbisogno"
long BackColor=81514954
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
event ue_post_open ( )
tv_1 tv_1
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_fabbisogno_distinta2_ff w_fabbisogno_distinta2_ff

forward prototypes
public subroutine wf_fabbisogno (long disponibilita)
end prototypes

event ue_post_open;dw_1.Height=this.Height - 250
dw_1.Width =this.Width  - 100
cb_2.x=dw_1.x+dw_1.Width - cb_2.Width
dw_1.Object.DataWindow.Print.Preview='yes'
end event

public subroutine wf_fabbisogno (long disponibilita);
string ls_conto_visione
decimal ld_esistenza,ld_carico,ld_scarico,ld_ordinato_fo,ld_impegnato_cl,ld_disponibilita
long ll_righe,i,ll_art
string ls_car_fiscali,ls_sca_fiscali,ls_ord_clienti,ls_ord_fornitori,ls_vis_clienti
string ls_vis_fornitori,ls_cl_clienti,ls_cl_fornitori,ls_imp_produzione,ls_ord_produzione
string ls_gr_lib_1,ls_gr_lib_2,ls_gr_lib_3,ls_gr_lib_4
decimal ls_car_fiscali_a,ls_sca_fiscali_a,ls_ord_clienti_a,ls_ord_fornitori_a,ls_vis_clienti_a
decimal ls_vis_fornitori_a,ls_cl_clienti_a,ls_cl_fornitori_a,ls_imp_produzione_a
decimal ls_ord_produzione_a,ls_gr_lib_1_a,ls_gr_lib_2_a,ls_gr_lib_3_a,ls_gr_lib_4_a
ll_righe=dw_1.rowcount()
select conto_vis_scarico
into :ls_conto_visione
from par_sistema;
for i=1 to ll_righe
	ll_art=dw_1.getitemnumber(i,"id_articolo")
	
	if ls_conto_visione='S' then
		select sum(qta_caricata)-sum(qta_scaricata),sum(qta_caricata),sum(qta_scaricata),&
				 sum(qta_ord_produzione),sum(qta_imp_produzione)
		into :ld_esistenza,:ld_carico,:ld_carico,:ld_ordinato_fo,:ld_impegnato_cl
		from riepilogo
		where id_articolo=:ll_art;
	else
		select sum(qta_caricata)-sum(qta_scaricata)+sum(qta_vis_fornitori)-sum(qta_vis_clienti),&
				 sum(qta_caricata),sum(qta_scaricata),sum(qta_ord_produzione),sum(qta_imp_produzione)
		into :ld_esistenza,:ld_carico,:ld_scarico,:ld_ordinato_fo,:ld_impegnato_cl
		from riepilogo
		where id_articolo=:ll_art;
	end if
	if isnull(ld_esistenza) then ld_esistenza=0
	dw_1.setitem(i,"esistenza",ld_esistenza)

	
	
	if isnull(ld_carico) then ld_carico=0
	dw_1.setitem(i,"carico",ld_carico)
	
	
	
	if isnull(ld_scarico) then ld_scarico=0
	dw_1.setitem(i,"scarico",ld_scarico)
	
	
	
	if isnull(ld_ordinato_fo) then ld_ordinato_fo=0
	dw_1.setitem(i,"ordinato_fo",ld_ordinato_fo)
	
	
	
	if isnull(ld_impegnato_cl) then ld_impegnato_cl=0
	dw_1.setitem(i,"impegnato_cl",ld_impegnato_cl)	
	
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
	
next


end subroutine

on w_fabbisogno_distinta2_ff.create
this.tv_1=create tv_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.tv_1,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_fabbisogno_distinta2_ff.destroy
destroy(this.tv_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;dw_1.settransobject(sqlca)
dw_1.reset()
datawindow dw

dw = message.powerobjectparm
dw.RowsCopy(1, dw.RowCount(), Primary!, dw_1, 1, Primary!)

dw_1.setsort("codice A")
dw_1.sort()
end event

type tv_1 from u_tv_distinta within w_fabbisogno_distinta2_ff
int X=1143
int Y=0
int Width=320
int Height=108
int TabOrder=20
boolean Visible=false
end type

type cb_2 from commandbutton within w_fabbisogno_distinta2_ff
int X=2789
int Y=24
int Width=247
int Height=92
int TabOrder=10
string Text="Stampa"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;printsetup()
dw_1.print()
end event

type cb_1 from commandbutton within w_fabbisogno_distinta2_ff
int X=23
int Y=24
int Width=247
int Height=92
int TabOrder=20
string Text="OK"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(parent)
end event

type dw_1 from datawindow within w_fabbisogno_distinta2_ff
int X=23
int Y=140
int Width=3008
int Height=1224
int TabOrder=30
string DataObject="d_fabbisogno_gd"
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

