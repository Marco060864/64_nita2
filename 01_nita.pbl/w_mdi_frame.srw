forward
global type w_mdi_frame from window
end type
type mdi_1 from mdiclient within w_mdi_frame
end type
type mditbb_1 from tabbedbar within w_mdi_frame
end type
type mdirbb_1 from ribbonbar within w_mdi_frame
end type
end forward

global type w_mdi_frame from window
integer x = 1074
integer y = 484
integer width = 2533
integer height = 1516
boolean titlebar = true
string title = "Inserisci il titolo!!!"
string menuname = "m_mdi_frame"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = mdihelp!
windowstate windowstate = maximized!
long backcolor = 79741120
string icon = "Window!"
mdi_1 mdi_1
mditbb_1 mditbb_1
mdirbb_1 mdirbb_1
end type
global w_mdi_frame w_mdi_frame

on w_mdi_frame.create
if this.MenuName = "m_mdi_frame" then this.MenuID = create m_mdi_frame
this.mdi_1=create mdi_1
this.mditbb_1=create mditbb_1
this.mdirbb_1=create mdirbb_1
this.Control[]={this.mdi_1,&
this.mditbb_1,&
this.mdirbb_1}
end on

on w_mdi_frame.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
destroy(this.mditbb_1)
destroy(this.mdirbb_1)
end on

event closequery;integer		li_ync, li_retval


li_ync = MessageBox("Applicazione","Confermi l'uscita dall'applicazione ?", Question!, YesNo!)
	CHOOSE CASE li_ync
		CASE 1
			
				li_retval = 0
		CASE 2
			li_retval = 1
	END CHOOSE

return li_retval

end event

event open;Open(w_msg_log)



end event

type mdi_1 from mdiclient within w_mdi_frame
long BackColor=134217744
end type

type mditbb_1 from tabbedbar within w_mdi_frame
int X=0
int Y=0
int Width=0
int Height=104
end type

type mdirbb_1 from ribbonbar within w_mdi_frame
int X=0
int Y=0
int Width=0
int Height=596
end type

