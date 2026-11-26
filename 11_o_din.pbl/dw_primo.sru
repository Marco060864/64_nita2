forward
global type dw_primo from datawindow
end type
end forward

global type dw_primo from datawindow
int Width=1810
int Height=836
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
event key pbm_dwnkey
end type
global dw_primo dw_primo

event getfocus;object.datawindow.color=12500604
end event

event losefocus;object.datawindow.color=12632256
end event

