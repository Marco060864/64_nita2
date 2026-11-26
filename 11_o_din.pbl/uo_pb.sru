forward
global type uo_pb from picturebutton
end type
end forward

global type uo_pb from picturebutton
int Width=247
int Height=144
int TabOrder=10
string Text="none"
Alignment HTextAlign=Left!
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
event ue_mousemove pbm_mousemove
end type
global uo_pb uo_pb

type variables




end variables

event ue_mousemove;w_001 w_parent
w_parent=this.getparent()
if this.tag>"" then
	if isvalid(w_parent)  then
		w_parent.st_1.text=this.tag
		w_parent.st_1.x=this.x + xpos+35
		w_parent.st_1.y=this.y + ypos
		w_parent.st_1.visible=true	
		timer(0.7, w_parent)
	end if
END IF
end event

