forward
global type w_orafo_stampa_preview from Window
end type
type cb_7 from commandbutton within w_orafo_stampa_preview
end type
type cb_6 from commandbutton within w_orafo_stampa_preview
end type
type cb_5 from commandbutton within w_orafo_stampa_preview
end type
type cb_4 from commandbutton within w_orafo_stampa_preview
end type
type dw_1 from datawindow within w_orafo_stampa_preview
end type
type cb_3 from commandbutton within w_orafo_stampa_preview
end type
type cb_1 from commandbutton within w_orafo_stampa_preview
end type
end forward

global type w_orafo_stampa_preview from Window
int X=5
int Y=4
int Width=3694
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
global w_orafo_stampa_preview w_orafo_stampa_preview

type variables
long il_zoom
end variables

event ue_post_open;integer i, li_ret, li_righe_per_allineamento
long ll_righe, ll_riga_gruppo, ll_riga, ll_riga_gruppo2,ll_id_valuta
decimal{2} ld_somma1, ld_somma2, ld_titolo, ld_calo1, ld_calo2
decimal{2} ld_fino1, ld_fino2, ld_qta1,ld_qta2
decimal{2} ld_p_met1, ld_p_met2, ld_p_man1, ld_p_man2
string ls_met_tit, ls_data_fine

s_stampa s_dati_stampa
s_dati_stampa=message.powerobjectparm
if s_dati_stampa.s_tit_caus='C' then
	dw_1.dataobject='d_orafo_comp_stampa_causali'
end if
dw_1.settransobject(sqlca)
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
if dw_stamp_s.rowcount()>0 then
	ll_id_valuta=dw_stamp_s.getitemnumber(1, "id_valuta")
	if isnull(ll_id_valuta) then
		if dw_stamp.rowcount()>0 then
			ll_id_valuta=dw_stamp.getitemnumber(1, "id_valuta")
		end if
	end if
end if
datastore pippo
pippo=create datastore
pippo.dataobject="d_orafo_stampa_parametrica_saldo"

LL_RIGHE=dw_stamp.rowcount()
for i = 1 to ll_righe
	ll_riga=pippo.insertrow(0)
	
	pippo.setitem(i, "id_valuta", ll_id_valuta)
	if i= 1 then
		ll_riga_gruppo=1
		ll_riga_gruppo2=1
	
		ls_met_tit=s_dati_stampa.dw_s_carico.getitemstring(i, "c_met_tit")
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
		
		ld_qta1=dw_stamp.getitemdecimal(i, "tot_qta_tit") 
		ld_qta2=dw_stamp_s.getitemdecimal(i, "tot_qta_tit")
		if isnull(ld_qta1) then ld_qta1=0
		if isnull(ld_qta2) then ld_qta2=0
		ld_qta1 -= ld_qta2
		
	else
		ll_riga_gruppo=s_dati_stampa.dw_s_carico.findgroupchange(ll_riga_gruppo + 1, 2)
		if ll_riga_gruppo<1 then 
			
			pippo.deleterow(ll_riga)
			exit
		end if
		ll_riga_gruppo2=s_dati_stampa.dw_s_scarico.findgroupchange(ll_riga_gruppo2 + 1, 2)
		if ll_riga_gruppo2>0 then
			ld_somma2=dw_stamp_s.getitemdecimal(ll_riga_gruppo2, "somma_peso")
			ld_calo2=dw_stamp_s.getitemdecimal(ll_riga_gruppo2, "somma_calo")
			ld_fino2=dw_stamp_s.getitemdecimal(ll_riga_gruppo2, "somma_fino")
			ld_p_met2=dw_stamp_s.getitemdecimal(ll_riga_gruppo2, "somma_prezzo_metallo")
			ld_p_man2=dw_stamp_s.getitemdecimal(ll_riga_gruppo2, "somma_prezzo_manifattura")
			
			ld_qta2=dw_stamp_s.getitemdecimal(ll_riga_gruppo2, "tot_qta_tit")
		end if
			
			ls_met_tit=dw_stamp.getitemstring(ll_riga_gruppo, "c_met_tit")
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
			
			ld_qta1=dw_stamp.getitemdecimal(ll_riga_gruppo, "tot_qta_tit") 
			if isnull(ld_qta1) then ld_qta1=0
			if isnull(ld_qta2) then ld_qta2=0
			ld_qta1 -= ld_qta2
			
	end if
	
	pippo.setitem(ll_riga, "c_met_tit", ls_met_tit)
	pippo.setitem(ll_riga, "orafo_metallo_codice", left(ls_met_tit, 2))
	
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
	li_ret=pippo.setitem(ll_riga, "somma_qta", ld_qta1)
	if li_ret<>1 then messagebox("W", "no setitem6")
	
next
pippo.rowscopy(1, pippo.rowcount(), primary!, DW_STAMPA_SALDI, 1, primary!)
DW_STAMPA_SALDI.sort()
destroy pippo
dw_1.object.dw_stampa_scarico.object.st_1.text="Scarico"
dw_1.Height=(this.Height) - 272
setPointer(Arrow!)
dw_1.visible=True
if isnull(s_dati_stampa.data_fine) then 
	ls_data_fine='--'
else
	ls_data_fine=string(s_dati_stampa.data_fine)
end if
dw_1.object.filtro.text="Periodo selezionato: da data "+string(s_dati_stampa.data_inizio)&
								+" a data "+ls_data_fine+&
								" - Stampato il "+string(today())

end event

event open;

il_zoom=100
this.event post ue_post_open()
end event

on w_orafo_stampa_preview.create
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

on w_orafo_stampa_preview.destroy
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

type cb_7 from commandbutton within w_orafo_stampa_preview
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

type cb_6 from commandbutton within w_orafo_stampa_preview
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

type cb_5 from commandbutton within w_orafo_stampa_preview
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

type cb_4 from commandbutton within w_orafo_stampa_preview
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

type dw_1 from datawindow within w_orafo_stampa_preview
int X=32
int Y=164
int Width=3607
int Height=1220
int TabOrder=60
string DataObject="d_orafo_comp_stampa2"
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

type cb_3 from commandbutton within w_orafo_stampa_preview
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

type cb_1 from commandbutton within w_orafo_stampa_preview
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

