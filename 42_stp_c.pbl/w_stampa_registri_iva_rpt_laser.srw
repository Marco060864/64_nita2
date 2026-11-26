forward
global type w_stampa_registri_iva_rpt_laser from w_stampa_reg_iva_rpt
end type
type st_1 from statictext within w_stampa_registri_iva_rpt_laser
end type
end forward

global type w_stampa_registri_iva_rpt_laser from w_stampa_reg_iva_rpt
boolean TitleBar=true
string Title="Stampa Registri IVA "
st_1 st_1
end type
global w_stampa_registri_iva_rpt_laser w_stampa_registri_iva_rpt_laser

on w_stampa_registri_iva_rpt_laser.create
int iCurrent
call super::create
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
end on

on w_stampa_registri_iva_rpt_laser.destroy
call super::destroy
destroy(this.st_1)
end on

event open;call super::open;dw_1.object.elab_prova.protect = 1

dw_1.object.elab_prova_t.visible = false
dw_1.object.non_def.visible = true

end event

type cb_ok from w_stampa_reg_iva_rpt`cb_ok within w_stampa_registri_iva_rpt_laser
int X=55
int Y=28
boolean BringToTop=true
end type

event cb_ok::clicked;
end event

type cb_annulla from w_stampa_reg_iva_rpt`cb_annulla within w_stampa_registri_iva_rpt_laser
int Y=28
boolean BringToTop=true
end type

type dw_1 from w_stampa_reg_iva_rpt`dw_1 within w_stampa_registri_iva_rpt_laser
int Y=228
int Height=828
end type

type st_1 from statictext within w_stampa_registri_iva_rpt_laser
int X=32
int Y=136
int Width=1417
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Per le stampe definitive, usare stampa su aghi"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

