forward
global type w_pdc_tb from w_np_single_data
end type
type cb_avanti from commandbutton within w_pdc_tb
end type
type cb_indietro from commandbutton within w_pdc_tb
end type
end forward

global type w_pdc_tb from w_np_single_data
int Width=2803
int Height=1197
boolean TitleBar=true
string Title="Stampa Piano dei Conti"
cb_avanti cb_avanti
cb_indietro cb_indietro
end type
global w_pdc_tb w_pdc_tb

on w_pdc_tb.create
int iCurrent
call w_np_single_data::create
this.cb_avanti=create cb_avanti
this.cb_indietro=create cb_indietro
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=cb_avanti
this.Control[iCurrent+2]=cb_indietro
end on

on w_pdc_tb.destroy
call w_np_single_data::destroy
destroy(this.cb_avanti)
destroy(this.cb_indietro)
end on

type p_crescente from w_np_single_data`p_crescente within w_pdc_tb
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_pdc_tb
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_pdc_tb
int Y=141
int Width=2675
int Height=921
int TabOrder=10
string DataObject="d_pdc_nr"
end type

type cb_avanti from commandbutton within w_pdc_tb
int X=46
int Y=21
int Width=110
int Height=109
int TabOrder=20
boolean BringToTop=true
string Text=">>"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

dw_single.ScrollNextPage()

end event

type cb_indietro from commandbutton within w_pdc_tb
int X=206
int Y=21
int Width=110
int Height=109
int TabOrder=3
boolean BringToTop=true
string Text="<<"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

dw_single.ScrollPriorPage()
end event

