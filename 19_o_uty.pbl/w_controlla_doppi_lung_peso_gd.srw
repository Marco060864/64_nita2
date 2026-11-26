forward
global type w_controlla_doppi_lung_peso_gd from w_np_single_data
end type
type cb_cerca from commandbutton within w_controlla_doppi_lung_peso_gd
end type
end forward

global type w_controlla_doppi_lung_peso_gd from w_np_single_data
int Width=2994
int Height=1000
cb_cerca cb_cerca
end type
global w_controlla_doppi_lung_peso_gd w_controlla_doppi_lung_peso_gd

on w_controlla_doppi_lung_peso_gd.create
int iCurrent
call super::create
this.cb_cerca=create cb_cerca
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_cerca
end on

on w_controlla_doppi_lung_peso_gd.destroy
call super::destroy
destroy(this.cb_cerca)
end on

type dw_single from w_np_single_data`dw_single within w_controlla_doppi_lung_peso_gd
int Y=84
int Width=2875
string DataObject="d_controlla_doppi_lung_peso"
end type

type cb_cerca from commandbutton within w_controlla_doppi_lung_peso_gd
int X=2656
int Y=8
int Width=247
int Height=72
int TabOrder=10
boolean BringToTop=true
string Text="Cerca"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_riga_corrente, ll_righe, ll_riga_trovata

ll_righe=dw_single.rowcount()
ll_riga_corrente=dw_single.getrow()

ll_riga_trovata=dw_single.find("c_test=1", ll_riga_corrente+1, ll_righe) 

dw_single.scrolltorow(ll_riga_trovata)
end event

