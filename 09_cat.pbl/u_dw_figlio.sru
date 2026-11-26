forward
global type u_dw_figlio from datawindow
end type
end forward

global type u_dw_figlio from datawindow
int Width=494
int Height=360
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
event ue_key pbm_dwnkey
end type
global u_dw_figlio u_dw_figlio

event losefocus;modify("datawindow.color=12632256")
end event

event getfocus;object.datawindow.color=10987431
end event

event rowfocuschanged;

	
	



end event

event constructor;SetRowFocusIndicator(Hand!)
end event

