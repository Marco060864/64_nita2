forward
global type w_annotazione_gd from w_np_single_data
end type
type rb_1 from radiobutton within w_annotazione_gd
end type
type rb_2 from radiobutton within w_annotazione_gd
end type
type st_info from statictext within w_annotazione_gd
end type
end forward

global type w_annotazione_gd from w_np_single_data
int Width=2610
int Height=956
WindowType WindowType=response!
boolean TitleBar=true
string Title="Annotazioni"
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
rb_1 rb_1
rb_2 rb_2
st_info st_info
end type
global w_annotazione_gd w_annotazione_gd

type variables
string is_nota, is_id_sog_com

end variables

on w_annotazione_gd.create
int iCurrent
call super::create
this.rb_1=create rb_1
this.rb_2=create rb_2
this.st_info=create st_info
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_1
this.Control[iCurrent+2]=this.rb_2
this.Control[iCurrent+3]=this.st_info
end on

on w_annotazione_gd.destroy
call super::destroy
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.st_info)
end on

event closequery;call super::closequery;message.stringparm=is_nota
end event

event open;string ls_id_sog_com
idw_master = dw_single
is_wintype = "W_NP_SINGLE_DATA"
s_any_array 	s_array

if isvalid(message.powerobjectparm) then
	if message.powerobjectparm.classname()='s_list_main' then
		
		st_info.visible=false
		dw_single.setfilter("isnull(id_sog_commerciale)" )
		rb_1.checked=true
		
	else
		s_array=message.powerobjectparm
		if isvalid(s_array) then
			is_id_sog_com=s_array.s_array[10] 
		else
			is_id_sog_com=message.stringparm
		end if
	end if
else
	is_id_sog_com=message.stringparm
end if
if  is_id_sog_com>'' then 
	dw_single.setfilter("id_sog_commerciale=" + is_id_sog_com)
	rb_2.checked=true
else
	
	dw_single.setfilter("isnull(id_sog_commerciale)" )
	rb_1.checked=true
	
end if
dw_single.filter()
dw_single.Retrieve()
this.y = 100
end event

type p_crescente from w_np_single_data`p_crescente within w_annotazione_gd
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_annotazione_gd
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_annotazione_gd
int Y=32
int Width=2501
string DataObject="d_ac_ann_scom_gd"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=false
end type

event dw_single::doubleclicked;integer li_ret
if row>0 then
	li_ret=messagebox("Attenzione!", "Sei certo di voler copiare l'annotazione ~r~nsulla nota documento?",stopsign!, yesno!)
	if li_ret=1 then
		accepttext()
		is_nota=dw_single.getitemstring(row, "note")
		close(parent)
	end if
end if
end event

event dw_single::updatestart;
long ll_row
if is_id_sog_com>" " and rb_2.checked then
	ll_row=getrow()
	if ll_row>0 then
		setitem(ll_row, "id_sog_commerciale", long(is_id_sog_com))
	end if
end if
end event

type rb_1 from radiobutton within w_annotazione_gd
int X=91
int Y=744
int Width=411
int Height=76
boolean BringToTop=true
string Text="Note Generiche"
BorderStyle BorderStyle=StyleLowered!
boolean LeftText=true
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_single.setfilter("isnull(id_sog_commerciale)" )
dw_single.filter()
dw_single.modify("id_sog_commerciale.visible=0")

end event

type rb_2 from radiobutton within w_annotazione_gd
int X=594
int Y=748
int Width=494
int Height=76
boolean BringToTop=true
string Text="Note del Sog. Com."
BorderStyle BorderStyle=StyleLowered!
boolean LeftText=true
long TextColor=33554432
long BackColor=80269524
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if is_id_sog_com>" " then
	dw_single.setfilter("id_sog_commerciale=" + is_id_sog_com)
	dw_single.filter()
	dw_single.modify("id_sog_commerciale.visible=1")
	dw_single.modify("id_sog_commerciale.protect=1")
else
	dw_single.modify("id_sog_commerciale.visible=1")
	dw_single.modify("id_sog_commerciale.protect=0")
	
end if
end event

type st_info from statictext within w_annotazione_gd
int X=1161
int Y=728
int Width=841
int Height=132
boolean Enabled=false
boolean BringToTop=true
string Text="Doppio click sulla nota scelta per riportarla sul documento"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

