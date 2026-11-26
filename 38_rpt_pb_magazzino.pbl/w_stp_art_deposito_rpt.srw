forward
global type w_stp_art_deposito_rpt from Window
end type
type cb_2 from commandbutton within w_stp_art_deposito_rpt
end type
type cb_7 from commandbutton within w_stp_art_deposito_rpt
end type
type cb_6 from commandbutton within w_stp_art_deposito_rpt
end type
type cb_5 from commandbutton within w_stp_art_deposito_rpt
end type
type cb_4 from commandbutton within w_stp_art_deposito_rpt
end type
type dw_1 from datawindow within w_stp_art_deposito_rpt
end type
type cb_3 from commandbutton within w_stp_art_deposito_rpt
end type
type cb_1 from commandbutton within w_stp_art_deposito_rpt
end type
end forward

global type w_stp_art_deposito_rpt from Window
int X=5
int Y=16
int Width=3685
int Height=1816
boolean TitleBar=true
string Title="Stampa Merci in conto deposito"
long BackColor=80263581
boolean ControlMenu=true
WindowType WindowType=response!
event ue_post_open ( )
cb_2 cb_2
cb_7 cb_7
cb_6 cb_6
cb_5 cb_5
cb_4 cb_4
dw_1 dw_1
cb_3 cb_3
cb_1 cb_1
end type
global w_stp_art_deposito_rpt w_stp_art_deposito_rpt

type variables
long il_zoom
date id_ddata
string is_stampa
date id_ultima
end variables

event ue_post_open;dw_1.Height=(this.Height) - 272
end event

event open;s_riep_art str_passa


string ls_da_sog, ls_a_sog, ls_da_art, ls_a_art, ls_da_maga, ls_a_maga
long ll_tipo_registro

str_passa=message.powerobjectparm

ls_da_art=str_passa.da_articolo
ls_a_art=str_passa.a_articolo
ls_da_sog=str_passa.da_soggetto
ls_a_sog=str_passa.a_soggetto
ls_da_maga=str_passa.da_magazzino
ls_a_maga=str_passa.a_magazzino
ll_tipo_registro=str_passa.tipo_registro
id_ddata=str_passa.dalla_data
id_ultima=str_passa.alla_data
is_stampa=str_passa.filtro



CHOOSE CASE is_stampa
	CASE ''
		dw_1.DataObject = 'd_stp_movimenti_ff'
		dw_1.SetTransObject(SQLCA)
		dw_1.Retrieve(id_ddata, id_ultima, ls_da_art, ls_a_art, ls_da_sog, ls_a_sog, ls_da_maga, ls_a_maga, ll_tipo_registro)		
	CASE 'A'
		dw_1.DataObject = 'd_stp_movimenti_1_ff'
		dw_1.SetTransObject(SQLCA)
      dw_1.Retrieve(id_ddata, id_ultima, ls_da_sog, ls_a_sog, ls_da_maga, ls_a_maga, ll_tipo_registro)		
	CASE 'AS'	
      dw_1.DataObject = 'd_stp_movimenti_6_ff'
		dw_1.SetTransObject(SQLCA)
		dw_1.Retrieve(id_ddata, id_ultima, ls_da_maga, ls_a_maga, ll_tipo_registro)
	CASE 'AM'
		dw_1.DataObject = 'd_stp_movimenti_2_ff'
		dw_1.SetTransObject(SQLCA)
		dw_1.Retrieve(id_ddata, id_ultima, ls_da_sog, ls_a_sog, ll_tipo_registro)
   CASE	'S'
      dw_1.DataObject = 'd_stp_movimenti_3_ff'
		dw_1.SetTransObject(SQLCA)
		dw_1.Retrieve(id_ddata, id_ultima, ls_da_art, ls_a_art, ls_da_maga, ls_a_maga, ll_tipo_registro)
	CASE 'MS'
		dw_1.DataObject = 'd_stp_movimenti_5_ff'
		dw_1.SetTransObject(SQLCA)
		dw_1.Retrieve(id_ddata, id_ultima, ls_da_art, ls_a_art, ll_tipo_registro)
	CASE 'M'	
		dw_1.DataObject = 'd_stp_movimenti_4_ff'
		dw_1.SetTransObject(SQLCA)
		dw_1.Retrieve(id_ddata, id_ultima, ls_da_art, ls_a_art, ls_da_sog, ls_a_sog, ll_tipo_registro)
	CASE 'AMS'	
		dw_1.DataObject = 'd_stp_movimenti_def_ff'
		dw_1.SetTransObject(SQLCA)
		dw_1.Retrieve(id_ddata, id_ultima, ll_tipo_registro)
	CASE 'DEF'
		dw_1.DataObject = 'd_stp_movimenti_def_aghi_ff'
		dw_1.SetTransObject(SQLCA)
		dw_1.Retrieve(id_ddata, id_ultima, ll_tipo_registro)
		
END CHOOSE



il_zoom=100
this.event post ue_post_open()
dw_1.groupcalc()
end event

on w_stp_art_deposito_rpt.create
this.cb_2=create cb_2
this.cb_7=create cb_7
this.cb_6=create cb_6
this.cb_5=create cb_5
this.cb_4=create cb_4
this.dw_1=create dw_1
this.cb_3=create cb_3
this.cb_1=create cb_1
this.Control[]={this.cb_2,&
this.cb_7,&
this.cb_6,&
this.cb_5,&
this.cb_4,&
this.dw_1,&
this.cb_3,&
this.cb_1}
end on

on w_stp_art_deposito_rpt.destroy
destroy(this.cb_2)
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

type cb_2 from commandbutton within w_stp_art_deposito_rpt
int X=2985
int Y=40
int Width=389
int Height=84
int TabOrder=31
string Text="Salva su &File"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.SaveAs()
end event

type cb_7 from commandbutton within w_stp_art_deposito_rpt
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

type cb_6 from commandbutton within w_stp_art_deposito_rpt
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

type cb_5 from commandbutton within w_stp_art_deposito_rpt
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

type cb_4 from commandbutton within w_stp_art_deposito_rpt
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

type dw_1 from datawindow within w_stp_art_deposito_rpt
int X=18
int Y=152
int Width=3621
int Height=1548
int TabOrder=60
string DataObject="d_stp_movimenti_ff"
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

type cb_3 from commandbutton within w_stp_art_deposito_rpt
int X=3387
int Y=40
int Width=247
int Height=84
int TabOrder=10
string Text="Stam&pa"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;printsetup()
dw_1.print()

long ll_test, ll_art, li_ret
decimal ld_finale
long ll_breakrow, i, ll_breakrow2, j


li_ret=messagebox('Attenzione','La stampa è andata a buon fine?',information!, yesno!)
if li_ret=1 then

	if is_stampa='DEF' and dw_1.rowcount()>0 then
	
		ll_breakrow = 0

		DO WHILE NOT (ll_breakrow<0)
		   ll_breakrow = dw_1.FindGroupChange(ll_breakrow, 1)
			ll_breakrow2 = dw_1.FindGroupChange(ll_breakrow+1, 1)
			IF ll_breakrow2 <= 0 THEN ll_breakrow2=dw_1.rowcount() +1
			
			IF ll_breakrow <= 0 THEN 
				EXIT
			else	
				ld_finale=dw_1.getitemdecimal(ll_breakrow,'tot_finale')
				ll_art=dw_1.getitemdecimal(ll_breakrow,'id_articolo')
				select id_contatore_deposito_articoli into :ll_test
				from contatore_deposito_articoli where id_articolo=:ll_art;
				if sqlca.sqlcode=0 then
					update contatore_deposito_articoli set ultima_data=:id_ultima , quantita=:ld_finale 
					where id_articolo=:ll_art;
				else
					INSERT INTO contatore_deposito_articoli (ultima_data, quantita, id_articolo)
	  	 			VALUES (:id_ultima, :ld_finale, :ll_art) ;
				end if
			END IF
			
			ll_breakrow = ll_breakrow + 1
		LOOP
			
	end if
end if	
end event

type cb_1 from commandbutton within w_stp_art_deposito_rpt
int X=23
int Y=40
int Width=247
int Height=84
int TabOrder=70
string Text="&Annulla"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(parent)
end event

