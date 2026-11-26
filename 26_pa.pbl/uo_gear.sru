forward
global type uo_gear from olecustomcontrol
end type
end forward

global type uo_gear from olecustomcontrol
int Width=1153
int Height=565
int TabOrder=1
long TextColor=33554432
BorderStyle BorderStyle=StyleLowered!
string BinaryKey="uo_gear.udo"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
event paintevent ( )
event selectevent ( ref long lplLeft,  ref long lplTop,  ref long lplRight,  ref long lplBottom )
event statusevent ( ref long lpPercent )
event click ( )
event dblclick ( )
event keydown ( ref integer KeyCode,  integer Shift )
event keypress ( ref integer KeyAscii )
event keyup ( ref integer KeyCode,  integer Shift )
event mousedown ( integer Button,  integer Shift,  long OCX_x,  long OCX_y )
event mousemove ( integer Button,  integer Shift,  long OCX_x,  long OCX_y )
event mouseup ( integer Button,  integer Shift,  long OCX_x,  long OCX_y )
event scroll ( long Scrolltype )
event errorevent ( integer nErrCount )
event thumbnail ( string FileName,  long Page )
event tag ( integer TagID,  integer TagType,  long TagSize,  integer WordVal,  long LongVal,  string StrVal )
event thumbtitle ( ref string Title,  integer Page )
end type
global uo_gear uo_gear

