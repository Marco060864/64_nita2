forward
global type w_stampa_bilancio_cee_ff from Window
end type
type cbx_2 from checkbox within w_stampa_bilancio_cee_ff
end type
type cb_7 from commandbutton within w_stampa_bilancio_cee_ff
end type
type cb_6 from commandbutton within w_stampa_bilancio_cee_ff
end type
type cb_5 from commandbutton within w_stampa_bilancio_cee_ff
end type
type cb_4 from commandbutton within w_stampa_bilancio_cee_ff
end type
type cb_3 from commandbutton within w_stampa_bilancio_cee_ff
end type
type st_3 from statictext within w_stampa_bilancio_cee_ff
end type
type cbx_1 from checkbox within w_stampa_bilancio_cee_ff
end type
type cb_1 from commandbutton within w_stampa_bilancio_cee_ff
end type
type cb_2 from commandbutton within w_stampa_bilancio_cee_ff
end type
type dw_1 from u_dw_ext_main within w_stampa_bilancio_cee_ff
end type
type gb_1 from groupbox within w_stampa_bilancio_cee_ff
end type
end forward

global type w_stampa_bilancio_cee_ff from Window
int X=1097
int Y=60
int Width=1454
int Height=976
boolean TitleBar=true
string Title="Preparazione Bilancio Cee"
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
cbx_2 cbx_2
cb_7 cb_7
cb_6 cb_6
cb_5 cb_5
cb_4 cb_4
cb_3 cb_3
st_3 st_3
cbx_1 cbx_1
cb_1 cb_1
cb_2 cb_2
dw_1 dw_1
gb_1 gb_1
end type
global w_stampa_bilancio_cee_ff w_stampa_bilancio_cee_ff

type variables
integer li_anno1,li_anno2
end variables

on w_stampa_bilancio_cee_ff.create
this.cbx_2=create cbx_2
this.cb_7=create cb_7
this.cb_6=create cb_6
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_3=create cb_3
this.st_3=create st_3
this.cbx_1=create cbx_1
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_1=create dw_1
this.gb_1=create gb_1
this.Control[]={this.cbx_2,&
this.cb_7,&
this.cb_6,&
this.cb_5,&
this.cb_4,&
this.cb_3,&
this.st_3,&
this.cbx_1,&
this.cb_1,&
this.cb_2,&
this.dw_1,&
this.gb_1}
end on

on w_stampa_bilancio_cee_ff.destroy
destroy(this.cbx_2)
destroy(this.cb_7)
destroy(this.cb_6)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.st_3)
destroy(this.cbx_1)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_1)
destroy(this.gb_1)
end on

event open;dw_1.insertrow(0)
datawindowchild ldc_es1,ldc_es2
dw_1.getchild('id_es1',ldc_es1)
dw_1.getchild('id_es2',ldc_es2)
ldc_es1.settransobject(sqlca)
ldc_es1.retrieve()
ldc_es2.settransobject(sqlca)
ldc_es2.retrieve()

setfocus(dw_1)
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

type cbx_2 from checkbox within w_stampa_bilancio_cee_ff
int X=571
int Y=1560
int Width=352
int Height=76
string Text="Stampa aghi"
boolean LeftText=true
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_7 from commandbutton within w_stampa_bilancio_cee_ff
int X=46
int Y=1552
int Width=512
int Height=84
int TabOrder=50
string Text="Completo"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;open(w_attesa)

if cbx_2.checked=true then
	openwithparm(w_stampa_bil_cee_aghi_rpt,li_anno1)
else
	openwithparm(w_stampa_bil_cee_rpt,li_anno1)
end if

end event

type cb_6 from commandbutton within w_stampa_bilancio_cee_ff
int X=46
int Y=1452
int Width=512
int Height=84
int TabOrder=60
string Text="Abbreviato"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;open(w_attesa)
openwithparm(w_stampa_bil_cee_abb_rpt,li_anno1)
end event

type cb_5 from commandbutton within w_stampa_bilancio_cee_ff
int X=46
int Y=1352
int Width=512
int Height=84
int TabOrder=70
boolean Visible=false
string Text="Ridotto"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;open(w_attesa)
open(w_stampa_bil_cee_ridotto)
end event

type cb_4 from commandbutton within w_stampa_bilancio_cee_ff
int X=46
int Y=1152
int Width=512
int Height=84
int TabOrder=40
string Text="Tabulato di Raccordo"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if cbx_1.checked=true then
	open(w_attesa)
	openwithparm(w_stampa2_tab_raccordo_cx, li_anno1)
else
	open(w_attesa)
	open(w_stampa1_tab_raccordo_cx)
end if
end event

type cb_3 from commandbutton within w_stampa_bilancio_cee_ff
int X=46
int Y=1012
int Width=512
int Height=84
int TabOrder=20
string Text="Modifica Bilancio"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;openwithparm(w_bil_cee_tot_lt,li_anno1)
end event

type st_3 from statictext within w_stampa_bilancio_cee_ff
int X=46
int Y=1272
int Width=658
int Height=76
boolean Enabled=false
string Text="Stampe Bilancio Cee"
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cbx_1 from checkbox within w_stampa_bilancio_cee_ff
int X=571
int Y=1152
int Width=352
int Height=76
string Text="Mostra Saldi "
boolean LeftText=true
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_1 from commandbutton within w_stampa_bilancio_cee_ff
event clicked pbm_bnclicked
int X=1166
int Y=20
int Width=251
int Height=84
int TabOrder=10
string Text="Ok"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;



dw_1.accepttext()
string ls_ric1, ls_ric2, ls_bloc1,ls_bloc2
long ll_es1,ll_es2, ll_es_bloc
date ld_d1, ld_d2, ld_a1, ld_a2, ld_d1_sp, ld_d2_sp, ld_bloc
	
ls_ric1=dw_1.getitemstring(1,"ric_1")
ls_ric2=dw_1.getitemstring(1,"ric_2")

if this.text='Ok' then
	
	if ls_ric1='S' then 
		update bilancio_cee set saldo1=null;
	end if	
	if ls_ric2='S' then 
		update bilancio_cee set saldo2=null;
	end if	
	
	delete from chiusura_apertura;
	
	ll_es1=dw_1.getitemnumber(1,"id_es1")
	ll_es2=dw_1.getitemnumber(1,"id_es2")
	
	select data_inizio, data_fine 
	into :ld_d1, :ld_a1 from esercizio 
	where id_esercizio=:ll_es1;
	
	select data_inizio, data_fine
	into :ld_d2, :ld_a2 from esercizio
	where id_esercizio=:ll_es2;
	
	li_anno1=year(ld_d1)
	li_anno2=year(ld_d2)
	
	uo_bilancio_cee lo_sp
	lo_sp= create uo_bilancio_cee 
	open(w_attesa)
	
	select bloccato into :ls_bloc1
	from esercizio where id_esercizio=:ll_es1;
	
	if ls_bloc1='N' then
		select max(id_esercizio) into :ll_es_bloc
		from esercizio where bloccato='S' and data_fine<:ld_d1;
		if sqlca.sqlcode=0 and not isnull(ll_es_bloc) then 
			select data_fine into :ld_bloc
			from esercizio where id_esercizio=:ll_es_bloc;
			ld_d1_sp=RelativeDate(ld_bloc, 1 )
		else 
			ld_d1_sp=date('1990-01-01')
		end if
	end if	
	
	select bloccato into :ls_bloc2
	from esercizio where id_esercizio=:ll_es2;
	
	if ls_bloc2='N' then
		select max(id_esercizio) into :ll_es_bloc
		from esercizio where bloccato='S' and data_fine<:ld_d2;
		if sqlca.sqlcode=0 and not isnull(ll_es_bloc) then 
			select data_fine into :ld_bloc
			from esercizio where id_esercizio=:ll_es_bloc;
			ld_d2_sp=RelativeDate(ld_bloc, 1 )
		else 
			ld_d2_sp=date('1990-01-01')
		end if
	end if
	
	if ls_ric1='S' then
		lo_sp.of_conti_sp_parz(ld_d1_sp,ld_a1,1,li_anno1)
		lo_sp.of_conti_ce_parz(ld_d1,ld_a1,1,li_anno1)
	end if

	if ls_ric2='S' then
			lo_sp.of_conti_sp_parz(ld_d2_sp,ld_a2,2,li_anno2)
			lo_sp.of_conti_ce_parz(ld_d2,ld_a2,2,li_anno2)
	end if
	
	
	lo_sp.of_calcola_saldi()
	close(w_attesa)
	destroy lo_sp
	parent.Height=1812
	
	this.text='Chiudi'
else
	close(parent)
end if



end event

type cb_2 from commandbutton within w_stampa_bilancio_cee_ff
event clicked pbm_bnclicked
int X=23
int Y=20
int Width=247
int Height=84
int TabOrder=80
string Text="Annulla"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(parent)
end event

type dw_1 from u_dw_ext_main within w_stampa_bilancio_cee_ff
int X=23
int Y=120
int Width=1394
int Height=752
int TabOrder=90
string DataObject="d_stampa_bilancio_cee_ff"
end type

event itemchanged;call super::itemchanged;date ld_d1,ld_d2
string ls_data
if dwo.name="id_es1" then
	select data_inizio,data_fine
	into :ld_d1,:ld_d2
	from esercizio
	where id_esercizio=:data;
	ls_data=string(ld_d1,'dd/mm/yyyy')+"-"+string(ld_d2,'dd/mm/yyyy')
	dw_1.setitem(1,"data_es1",ls_data)

	long ll_id_es2,ll_app
	ll_id_es2=dw_1.getitemnumber(1,"id_es2")
	if isnull(ll_id_es2) then
		ll_app=year(ld_d1)
		ll_app=ll_app - 1
		select id_esercizio 
		into :ll_id_es2
		from esercizio
		where year(data_fine)=:ll_app;
		if sqlca.sqlcode=0 then
			dw_1.setitem(1,"id_es2",ll_id_es2)
			select data_inizio,data_fine
			into :ld_d1,:ld_d2
			from esercizio
			where id_esercizio=:ll_id_es2;
			ls_data=string(ld_d1,'dd/mm/yyyy')+"-"+string(ld_d2,'dd/mm/yyyy')
			dw_1.setitem(1,"data_es2",ls_data)
		end if
	end if
end if

if (dwo.name="id_es2") then
	select data_inizio,data_fine
	into :ld_d1,:ld_d2
	from esercizio
	where id_esercizio=:data;
	ls_data=string(ld_d1,'dd/mm/yyyy')+"-"+string(ld_d2,'dd/mm/yyyy')
	dw_1.setitem(1,"data_es2",ls_data)
end if
end event

type gb_1 from groupbox within w_stampa_bilancio_cee_ff
int X=23
int Y=932
int Width=1394
int Height=740
int TabOrder=30
string Text="Gestione Bilancio Cee"
long BackColor=79741120
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

