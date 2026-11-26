forward
global type w_st_sog_com_barre_rpt from Window
end type
type dw_2 from datawindow within w_st_sog_com_barre_rpt
end type
type cb_7 from commandbutton within w_st_sog_com_barre_rpt
end type
type cb_6 from commandbutton within w_st_sog_com_barre_rpt
end type
type cb_5 from commandbutton within w_st_sog_com_barre_rpt
end type
type cb_4 from commandbutton within w_st_sog_com_barre_rpt
end type
type dw_1 from datawindow within w_st_sog_com_barre_rpt
end type
type cb_3 from commandbutton within w_st_sog_com_barre_rpt
end type
type cb_1 from commandbutton within w_st_sog_com_barre_rpt
end type
end forward

global type w_st_sog_com_barre_rpt from Window
int X=5
int Y=364
int Width=3086
int Height=1520
boolean TitleBar=true
string Title="Stampa articoli invenduti"
long BackColor=79741120
boolean ControlMenu=true
WindowState WindowState=maximized!
WindowType WindowType=response!
event ue_post_open ( )
dw_2 dw_2
cb_7 cb_7
cb_6 cb_6
cb_5 cb_5
cb_4 cb_4
dw_1 dw_1
cb_3 cb_3
cb_1 cb_1
end type
global w_st_sog_com_barre_rpt w_st_sog_com_barre_rpt

type variables
long il_zoom
long il_forn
end variables

forward prototypes
public function integer wf_calc_prezzo_netto (integer al_row)
public subroutine wf_set_mask_riga ()
end prototypes

event ue_post_open;dw_1.Height=(this.Height) - 272
end event

public function integer wf_calc_prezzo_netto (integer al_row);

decimal		ld_Prezzo_Netto
decimal		ld_Cambio, ld_Sconto_Riga
decimal		ld_Prezzo
string		ls_Sconto, ls_tipo_arrotondamento
decimal		ld_cambio_riga
long			ll_id_valuta_riga, ll_nr_cifre_arrot
decimal 		ld_importo_sconto_riga		

if al_row>0 then
	ld_Prezzo = dw_1.GetItemnumber(al_row, "prezzo")
	ll_id_valuta_riga = dw_1.GetItemnumber(al_row, "riga_documento_id_valuta")
	ls_sconto = dw_1.getitemstring(al_row, "sconto")
	
	SELECT cifra_arrotondamento, tipo_arrotondamento
	INTO 	 :ll_nr_cifre_arrot, :ls_tipo_arrotondamento
	FROM 	 valuta
	WHERE	 id_valuta = :ll_id_valuta_riga
	;
	
	
	if IsNull(ll_nr_cifre_arrot) then ll_nr_cifre_arrot=0
	if IsNull(ld_cambio_riga) then ld_cambio_riga=1
	
	ld_Prezzo_Netto= f_calc_sconto_prezzo(ld_Prezzo, ls_Sconto, 1)
	

	ld_importo_sconto_riga=dw_1.getitemdecimal(al_row, "riga_documento_sconto_riga")
	if not isnull(ld_importo_sconto_riga) then
		ld_Prezzo_Netto=ld_Prezzo_Netto - ld_importo_sconto_riga
	end if
	
	ld_Prezzo_Netto=f_Round(ld_Prezzo_Netto ,ll_nr_cifre_arrot, ls_tipo_arrotondamento)
	
	if IsNull(ld_Prezzo_Netto) then ld_Prezzo_Netto=0

	dw_1.SetItem(al_row, "prezzo_netto",ld_Prezzo_Netto)
end if
return 0
end function

public subroutine wf_set_mask_riga ();

string 		ls_mask
long 			ll_row, ll_id_valuta

ll_row= dw_1.GetRow()
if ll_row > 0 then
	ll_id_valuta= dw_1.GetItemNumber(ll_row, "riga_documento_id_valuta")
	
	ls_mask=f_valu_mask_prezzi(ll_id_valuta)

	dw_1.Modify("prezzo.format = '" + ls_mask + "'")
	dw_1.Modify("prezzo_netto.format = '" + ls_mask + "'")
	dw_1.Modify("riga_documento_sconto_riga.format = '" + ls_mask + "'")
end if 


end subroutine

event open;string ls_da_sog, ls_a_sog
str_sog_com_barre str

str=message.PowerObjectParm

ls_da_sog =str.da_sog_com
ls_a_sog  =str.a_sog_com

dw_1.SetTransObject(SQLCA)
dw_1.Retrieve(ls_da_sog, ls_da_sog)
		
il_zoom=100
this.event post ue_post_open()

end event

on w_st_sog_com_barre_rpt.create
this.dw_2=create dw_2
this.cb_7=create cb_7
this.cb_6=create cb_6
this.cb_5=create cb_5
this.cb_4=create cb_4
this.dw_1=create dw_1
this.cb_3=create cb_3
this.cb_1=create cb_1
this.Control[]={this.dw_2,&
this.cb_7,&
this.cb_6,&
this.cb_5,&
this.cb_4,&
this.dw_1,&
this.cb_3,&
this.cb_1}
end on

on w_st_sog_com_barre_rpt.destroy
destroy(this.dw_2)
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

type dw_2 from datawindow within w_st_sog_com_barre_rpt
int X=178
int Y=1440
int Width=3058
int Height=648
int TabOrder=70
boolean Visible=false
string DataObject="d_st_prezzi_art_testa_rpt"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

type cb_7 from commandbutton within w_st_sog_com_barre_rpt
event clicked pbm_bnclicked
int X=2299
int Y=44
int Width=261
int Height=88
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

type cb_6 from commandbutton within w_st_sog_com_barre_rpt
event clicked pbm_bnclicked
int X=2025
int Y=44
int Width=261
int Height=88
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

type cb_5 from commandbutton within w_st_sog_com_barre_rpt
int X=485
int Y=44
int Width=466
int Height=88
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

type cb_4 from commandbutton within w_st_sog_com_barre_rpt
int X=965
int Y=44
int Width=466
int Height=88
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

type dw_1 from datawindow within w_st_sog_com_barre_rpt
int X=27
int Y=152
int Width=3013
int Height=1260
int TabOrder=60
string DataObject="d_st_sog_com_barre_rpt"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean HSplitScroll=true
boolean LiveScroll=true
end type

type cb_3 from commandbutton within w_st_sog_com_barre_rpt
int X=2784
int Y=44
int Width=247
int Height=88
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
end event

type cb_1 from commandbutton within w_st_sog_com_barre_rpt
int X=23
int Y=44
int Width=247
int Height=88
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

