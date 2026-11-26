forward
global type w_orafo_stampa_preview2 from Window
end type
type cb_7 from commandbutton within w_orafo_stampa_preview2
end type
type cb_6 from commandbutton within w_orafo_stampa_preview2
end type
type cb_5 from commandbutton within w_orafo_stampa_preview2
end type
type cb_4 from commandbutton within w_orafo_stampa_preview2
end type
type dw_1 from datawindow within w_orafo_stampa_preview2
end type
type cb_3 from commandbutton within w_orafo_stampa_preview2
end type
type cb_1 from commandbutton within w_orafo_stampa_preview2
end type
end forward

global type w_orafo_stampa_preview2 from Window
int X=5
int Y=4
int Width=4128
int Height=1508
boolean TitleBar=true
string Title="Stampa Parametrica"
long BackColor=79741120
boolean ControlMenu=true
WindowState WindowState=maximized!
WindowType WindowType=response!
event ue_post_open ( )
cb_7 cb_7
cb_6 cb_6
cb_5 cb_5
cb_4 cb_4
dw_1 dw_1
cb_3 cb_3
cb_1 cb_1
end type
global w_orafo_stampa_preview2 w_orafo_stampa_preview2

type variables
long il_zoom
end variables

event ue_post_open;integer i, li_ret, li_righe_per_allineamento
long ll_righe, ll_riga_gruppo, ll_riga, ll_riga_gruppo2
decimal{2} ld_somma1, ld_somma2, ld_titolo, ld_calo1, ld_calo2
decimal{2} ld_fino1, ld_fino2
decimal ld_p_met1, ld_p_met2, ld_p_man1, ld_p_man2

s_stampa s_dati_stampa
s_dati_stampa=message.powerobjectparm
dw_1.visible=False
setPointer(HourGlass!)
dw_1.retrieve()

DataWindowChild dw_stamp, dw_stamp_s, dw_caus_car, dw_caus_scar, DW_STAMPA_SALDI
dw_1.getchild("dw_stampa_scarico", dw_stamp_s)
dw_1.getchild("dw_stampa_carico", dw_stamp)
dw_1.getchild("dw_caus_carico", dw_caus_car)
dw_1.getchild("dw_caus_scarico", dw_caus_scar)
dw_1.getchild("dw_STAMPA_SALDI", DW_STAMPA_SALDI)

dw_stamp.reset()
dw_stamp_s.reset()
DW_STAMPA_SALDI.reset()

s_dati_stampa.dw_s_carico.rowscopy(1, s_dati_stampa.dw_s_carico.rowcount(), primary!, dw_stamp, 1, primary!)
s_dati_stampa.dw_s_scarico.rowscopy(1, s_dati_stampa.dw_s_scarico.rowcount(), primary!, dw_stamp_s, 1, primary!)
dw_caus_car.reset()
dw_caus_scar.reset()
li_ret=s_dati_stampa.dw_caus_car.rowscopy(1, s_dati_stampa.dw_caus_car.rowcount(), primary!, dw_caus_car, 1, primary!)
if li_ret<1 then
	dw_caus_car.insertrow(1)
end if
li_ret=s_dati_stampa.dw_caus_scar.rowscopy(1, s_dati_stampa.dw_caus_scar.rowcount(), primary!, dw_caus_scar, 1, primary!)
if li_ret<1 then
	dw_caus_scar.insertrow(1)
end if
li_righe_per_allineamento=dw_caus_car.rowcount() - dw_caus_scar.rowcount()
if li_righe_per_allineamento > 0  then
	for i=1 to li_righe_per_allineamento
		dw_caus_scar.insertrow(0)
	next
elseif li_righe_per_allineamento < 0 then
	for i=1 to (li_righe_per_allineamento * -1)
		dw_caus_car.insertrow(0)
	next
end if
datastore pippo
pippo=create datastore
pippo.dataobject="d_orafo_stampa_parametrica_saldo"


LL_RIGHE=dw_stamp.rowcount()
for i = 1 to ll_righe
	ll_riga=pippo.insertrow(0)
	if i= 1 then
		ll_riga_gruppo=1
		ll_riga_gruppo2=1
		ld_titolo=s_dati_stampa.dw_s_carico.getitemdecimal(i, "orafo_titolo_titolo")
		ld_somma1=dw_stamp.getitemdecimal(i, "somma_peso")
		ld_somma2=dw_stamp_s.getitemdecimal(i, "somma_peso")
		if isnull(ld_somma1) then ld_somma1=0
		if isnull(ld_somma2) then ld_somma2=0
		ld_somma1 -= ld_somma2
		ld_calo1=dw_stamp.getitemdecimal(i, "somma_calo")
		ld_calo2=dw_stamp_s.getitemdecimal(i, "somma_calo")
		if isnull(ld_calo1) then ld_calo1=0
		if isnull(ld_calo2) then ld_calo2=0
		ld_calo1 -= ld_calo2
		ld_fino1=dw_stamp.getitemdecimal(i, "somma_fino")
		ld_fino2=dw_stamp_s.getitemdecimal(i, "somma_fino")
		if isnull(ld_fino1) then ld_fino1=0
		if isnull(ld_fino2) then ld_fino2=0
		ld_fino1 -= ld_fino2
		ld_p_met1=dw_stamp.getitemdecimal(i, "somma_prezzo_metallo")
		ld_p_met2=dw_stamp_s.getitemdecimal(i, "somma_prezzo_metallo")
		if isnull(ld_p_met1) then ld_p_met1=0
		if isnull(ld_p_met2) then ld_p_met2=0
		ld_p_met1 -= ld_p_met2
		ld_p_man1=dw_stamp.getitemdecimal(i, "somma_prezzo_manifattura") 
		ld_p_man2=dw_stamp_s.getitemdecimal(i, "somma_prezzo_manifattura")
		if isnull(ld_p_man1) then ld_p_man1=0
		if isnull(ld_p_man2) then ld_p_man2=0
		ld_p_man1 -= ld_p_man2
	else
		ll_riga_gruppo=s_dati_stampa.dw_s_carico.findgroupchange(ll_riga_gruppo + 1, 1)
		if ll_riga_gruppo<1 then 
			
			pippo.deleterow(ll_riga)
			exit
		end if
		ll_riga_gruppo2=s_dati_stampa.dw_s_scarico.findgroupchange(ll_riga_gruppo2 + 1, 1)
		if ll_riga_gruppo2>0 then
			ld_somma2=dw_stamp_s.getitemdecimal(ll_riga_gruppo2, "somma_peso")
			ld_calo2=dw_stamp_s.getitemdecimal(ll_riga_gruppo2, "somma_calo")
			ld_fino2=dw_stamp_s.getitemdecimal(ll_riga_gruppo2, "somma_fino")
			ld_p_met2=dw_stamp_s.getitemdecimal(ll_riga_gruppo2, "somma_prezzo_metallo")
			ld_p_man2=dw_stamp_s.getitemdecimal(ll_riga_gruppo2, "somma_prezzo_manifattura")
		end if
			ld_titolo=dw_stamp.getitemdecimal(ll_riga_gruppo, "orafo_titolo_titolo")
			ld_somma1=dw_stamp.getitemdecimal(ll_riga_gruppo, "somma_peso")
			if isnull(ld_somma1) then ld_somma1=0
			if isnull(ld_somma2) then ld_somma2=0
			ld_somma1 -= ld_somma2
			
			ld_calo1=dw_stamp.getitemdecimal(ll_riga_gruppo, "somma_calo")
			if isnull(ld_calo1) then ld_calo1=0
			if isnull(ld_calo2) then ld_calo2=0
			ld_calo1 -= ld_calo2
			
			ld_fino1=dw_stamp.getitemdecimal(ll_riga_gruppo, "somma_fino")
			if isnull(ld_fino1) then ld_fino1=0
			if isnull(ld_fino2) then ld_fino2=0
			ld_fino1 -= ld_fino2
			
			ld_p_met1=dw_stamp.getitemdecimal(ll_riga_gruppo, "somma_prezzo_metallo")
			if isnull(ld_p_met1) then ld_p_met1=0
			if isnull(ld_p_met2) then ld_p_met2=0
			ld_p_met1 -= ld_p_met2
			
			ld_p_man1=dw_stamp.getitemdecimal(ll_riga_gruppo, "somma_prezzo_manifattura") 
			if isnull(ld_p_man1) then ld_p_man1=0
			if isnull(ld_p_man2) then ld_p_man2=0
			ld_p_man1 -= ld_p_man2
	end if
	pippo.setitem(ll_riga, "orafo_titolo_titolo", ld_titolo)
	li_ret=pippo.setitem(ll_riga, "riga_documento_peso_netto", ld_somma1)
	if li_ret<>1 then messagebox("W", "no setitem1")
	li_ret=pippo.setitem(ll_riga, "riga_documento_calo", ld_calo1)
	if li_ret<>1 then messagebox("W", "no setitem2")
	li_ret=pippo.setitem(ll_riga, "riga_documento_fino", ld_fino1)
	if li_ret<>1 then messagebox("W", "no setitem3")
	li_ret=pippo.setitem(ll_riga, "somma_metallo", ld_p_met1)
	if li_ret<>1 then messagebox("W", "no setitem4")
	li_ret=pippo.setitem(ll_riga, "somma_manifattura", ld_p_man1)
	if li_ret<>1 then messagebox("W", "no setitem5")
next
pippo.rowscopy(1, pippo.rowcount(), primary!, DW_STAMPA_SALDI, 1, primary!)
DW_STAMPA_SALDI.sort()
destroy pippo
dw_1.object.dw_stampa_scarico.object.st_1.text="Scarico"
dw_1.Height=(this.Height) - 272
setPointer(Arrow!)
dw_1.visible=True
end event

event open;
dw_1.settransobject(sqlca)
il_zoom=100
this.event post ue_post_open()
end event

on w_orafo_stampa_preview2.create
this.cb_7=create cb_7
this.cb_6=create cb_6
this.cb_5=create cb_5
this.cb_4=create cb_4
this.dw_1=create dw_1
this.cb_3=create cb_3
this.cb_1=create cb_1
this.Control[]={this.cb_7,&
this.cb_6,&
this.cb_5,&
this.cb_4,&
this.dw_1,&
this.cb_3,&
this.cb_1}
end on

on w_orafo_stampa_preview2.destroy
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

type cb_7 from commandbutton within w_orafo_stampa_preview2
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

type cb_6 from commandbutton within w_orafo_stampa_preview2
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

type cb_5 from commandbutton within w_orafo_stampa_preview2
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

type cb_4 from commandbutton within w_orafo_stampa_preview2
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

type dw_1 from datawindow within w_orafo_stampa_preview2
int X=32
int Y=164
int Width=3634
int Height=1220
int TabOrder=60
string DataObject="d_orafo_comp_stampa3"
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

type cb_3 from commandbutton within w_orafo_stampa_preview2
int X=3369
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

type cb_1 from commandbutton within w_orafo_stampa_preview2
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

