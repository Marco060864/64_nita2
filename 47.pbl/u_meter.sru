forward
global type u_meter from UserObject
end type
type r_bar from rectangle within u_meter
end type
end forward

global type u_meter from UserObject
int Width=709
int Height=97
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
long PictureMaskColor=536870912
long TabTextColor=33554432
long TabBackColor=16777215
r_bar r_bar
end type
global u_meter u_meter

type variables
long il_max = 100
long il_min = 0
long il_value = 0

long il_vmax
end variables

forward prototypes
public subroutine uf_setmax (long al_max)
public subroutine uf_setmin (long al_min)
public function long uf_setvalue (long al_value)
public function long uf_incrvalue (long al_incrvalue)
end prototypes

public subroutine uf_setmax (long al_max);IF al_max > il_min THEN il_max = al_max
end subroutine

public subroutine uf_setmin (long al_min);IF al_min < il_max THEN il_min = al_min
end subroutine

public function long uf_setvalue (long al_value);long ll_length, ll_RetVal = 0

IF al_value >= il_min AND al_value <= il_max THEN
	ll_length = il_max - il_min
	il_value = (al_value * il_vmax) / ll_length
	r_bar.width = il_value
	ll_RetVal = (al_value * 100) / ll_length
END IF

RETURN ll_RetVal
end function

public function long uf_incrvalue (long al_incrvalue);long ll_length, ll_RetVal = 0
ll_length = il_max - il_min

IF (il_value + al_incrvalue) <= ll_length THEN
	il_value = il_value + al_incrvalue
	r_bar.width = ((il_value * il_vmax) / ll_length)
	ll_RetVal = (il_value *100) / ll_length
END IF

RETURN ll_RetVal
end function

on u_meter.create
this.r_bar=create r_bar
this.Control[]={ this.r_bar}
end on

on u_meter.destroy
destroy(this.r_bar)
end on

event constructor;r_bar.X = 1
r_bar.Y = 1
r_bar.width = 0
r_bar.height = (THIS.height - 15)

il_vmax = THIS.width
end event

type r_bar from rectangle within u_meter
int Width=298
int Height=93
boolean Enabled=false
int LineThickness=5
long LineColor=16711680
long FillColor=16711680
end type

