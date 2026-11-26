forward
global type w_sel_data_ff from w_wiz_main
end type
type dw_1 from datawindow within w_sel_data_ff
end type
type cb_1 from commandbutton within w_sel_data_ff
end type
type st_1 from statictext within w_sel_data_ff
end type
type st_2 from statictext within w_sel_data_ff
end type
end forward

global type w_sel_data_ff from w_wiz_main
int X=640
int Y=928
int Width=1929
int Height=676
boolean TitleBar=true
string Title="Uscita Riba"
long BackColor=78682240
dw_1 dw_1
cb_1 cb_1
st_1 st_1
st_2 st_2
end type
global w_sel_data_ff w_sel_data_ff

on w_sel_data_ff.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_1=create cb_1
this.st_1=create st_1
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_2
end on

on w_sel_data_ff.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.st_2)
end on

event open;call super::open;dw_1.InsertRow(0)


end event

type dw_1 from datawindow within w_sel_data_ff
int X=64
int Y=168
int Width=1783
int Height=372
int TabOrder=10
boolean BringToTop=true
string DataObject="d_sel_data_ff"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

type cb_1 from commandbutton within w_sel_data_ff
int X=69
int Y=28
int Width=443
int Height=108
int TabOrder=10
boolean BringToTop=true
string Text="Prepara disco"
int TextSize=-8
int Weight=400
string FaceName="Arial"
boolean Italic=true
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_row, ll_id, ll_prog_dis, ll_retv
date d_dat
string ls_path

s_distinta par_dis 
par_dis=message.powerobjectparm
ll_id= par_dis.l_id_dis_banca   

dw_1.accepttext()

ll_row= dw_1.getrow()
if ll_row > 0 then   

	d_dat =dw_1.getitemdate(ll_row, "d_dat")
	ls_path= dw_1.getitemstring(ll_row, "path_riba")

par_dis.l_id_dis_banca = ll_id
par_dis.d_dat_rib      = d_dat
par_dis.ls_path_riba   = ls_path
open(w_attesa)
OpenWithParm(w_uscita_riba_lt, par_dis )
end if            


end event

type st_1 from statictext within w_sel_data_ff
int X=594
int Y=20
int Width=1001
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Inserire il path per l'uscita Ascii indicando "
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
boolean Italic=true
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_sel_data_ff
int X=590
int Y=84
int Width=1001
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="una directory corretta"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
boolean Italic=true
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

