forward
global type w_wiz_main from Window
end type
end forward

global type w_wiz_main from Window
int X=567
int Y=437
int Width=2597
int Height=1005
boolean TitleBar=true
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
event ue_help ( helpcommand ae_hcom,  long al_helpid,  string as_helpkey )
event type integer ue_initvar ( )
event ue_post_open ( )
event ue_comment ( )
end type
global w_wiz_main w_wiz_main

type variables
uo_msg_log	iuo_msg_log

boolean		ib_openok	= True
long		il_Helptopic	= 1
string		is_HelpKey
string		is_Password
string		is_Serialize
string		is_wintype
end variables

event ue_help;if ae_Hcom = Keyword! then
	ShowHelp(u_freddie.is_helpfile, Keyword!, as_HelpKey)
else
	if ae_Hcom = Topic! then
		ShowHelp(u_freddie.is_helpfile, Topic!, al_HelpId)
	end if
end if

end event

event ue_post_open;
PowerObject		lpo_object
datawindow		ldw_data
string			ls_describe
integer 			li_size, li_i
integer			li_size_k, li_k
integer			li_size_z, li_z
tab				ltb_panel
UserObject		luo_tab_page
li_size = UpperBound( this.Control )

for li_i = 1 to li_size 
	if not isNull(this.Control[li_i]) then


		if this.Control[li_i].TypeOf() = DataWindow! then
			ldw_data = this.Control[li_i]
			if not isNull( ldw_data.DataObject ) and ldw_data.DataObject <> "" then
				ldw_data.Object.DataWindow.Help.Command = 1 
				ldw_data.Object.DataWindow.Help.TypeID.Retrieve.Argument = string(this.il_HelpTopic)
			end if	
		end if	

		
		if this.Control[li_i].TypeOf() = Tab! then
			ltb_panel = this.Control[li_i]
			li_size_k = UpperBound( ltb_panel.Control )
			for li_k = 1 to li_size_k 
				if not isNull(ltb_panel.Control[li_k]) then

					object tipo
					tipo = ltb_panel.Control[li_k].TypeOf()
					if ltb_panel.Control[li_k].TypeOf() = UserObject! then
						luo_tab_page = ltb_panel.Control[li_k]
						li_size_z = UpperBound( luo_tab_page.Control )
						for li_z = 1 to li_size_z 
							if luo_tab_page.Control[li_z].TypeOf() = DataWindow! then
								lpo_object = luo_tab_page.Control[li_z]
								ldw_data   = lpo_object
								if not isNull( ldw_data.DataObject ) and ldw_data.DataObject <> "" then
									ldw_data.Object.DataWindow.Help.Command = 1 
									ldw_data.Object.DataWindow.Help.TypeID.Retrieve.Argument = string(this.il_HelpTopic)
								end if	
							end if
						next
					end if
				end if	

			
				if ltb_panel.Control[li_k].TypeOf() = DataWindow! then
					lpo_object = ltb_panel.Control[li_k]
					ldw_data   = lpo_object
					if not isNull( ldw_data.DataObject ) and ldw_data.DataObject <> "" then
						ldw_data.Object.DataWindow.Help.Command = 1 
						ldw_data.Object.DataWindow.Help.TypeID.Retrieve.Argument = string(this.il_HelpTopic)
					end if	
				end if
			next	
		end if	
	end if	
next	

end event

on w_wiz_main.create
end on

on w_wiz_main.destroy
end on

event activate;

If IsValid(iuo_msg_log) then
	iuo_msg_log.uf_catch_msg()
end if

end event

event close;
If IsValid(iuo_msg_log) then
	
	iuo_msg_log.uf_new_text("",1)
	
	destroy iuo_msg_log
end if

end event

event deactivate;

If IsValid(iuo_msg_log) then
	iuo_msg_log.uf_leave_msg()
end if

end event

event key;

keycode			lk_code
string			ls_nome
windowobject	lw_me

lk_code = key

choose case lk_code
	case KeyF12!
		if keyflags=3 then
			ls_nome = this.ClassName()
			MessageBox ("ClassName",ls_nome)
		end if
	case KeyF1!
		if (keyflags = 0 Or keyflags = 1 Or keyflags = 2) then
			This.Event ue_help(Topic!, il_HelpTopic, "")
		end if
end choose
end event

event open;is_wintype = "w_wiz_main"					
u_freddie.center_window(this)
This.TriggerEvent("ue_initvar")
ib_openok = f_check_serial(is_serialize)
if ib_openok then
	ib_openok = f_check_win_password(is_password)
end if
if ib_openok then
	iuo_msg_log = create uo_msg_log
	iuo_msg_log.uf_new_text("Sessione del " + String(Today()) + " - " + String(Now()),2)
	PostEvent("ue_post_open")
else
	Close(This)
end if


end event

