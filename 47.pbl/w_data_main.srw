forward
global type w_data_main from window
end type
type p_msg_log from picture within w_data_main
end type
type p_crescente from picture within w_data_main
end type
type p_decrescente from picture within w_data_main
end type
type ws_dw from structure within w_data_main
end type
end forward

type ws_dw from structure
	transaction		transaction
	u_dw_main		parent_dw
	string		parent_link[1]
	boolean		is_shared
	boolean		allow_insert
	boolean		allow_append
	boolean		allow_delete
	boolean		allow_update
end type

global type w_data_main from window
integer x = 567
integer width = 2597
integer height = 1004
boolean titlebar = true
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "Form!"
event ue_insert pbm_custom01
event ue_append pbm_custom02
event ue_update pbm_custom03
event ue_delete pbm_custom04
event ue_togglequery pbm_custom05
event ue_retrieve pbm_custom06
event ue_firstrecord pbm_custom07
event ue_prevrecord pbm_custom08
event ue_nextrecord pbm_custom09
event ue_lastrecord pbm_custom10
event ue_clearquery pbm_custom11
event ue_show ( )
event ue_post_open ( )
event ue_modify ( )
event ue_print ( )
event ue_close ( )
event ue_html ( )
event ue_saveas ( )
event ue_save_html ( )
event ue_help ( helpcommand ae_hcom,  long al_helpid,  string as_helpkey )
event ue_initvar ( )
event ue_comment ( )
p_msg_log p_msg_log
p_crescente p_crescente
p_decrescente p_decrescente
end type
global w_data_main w_data_main

type variables
boolean		ib_close_query
string		is_filter		
s_dw_related	istr_dw[]		
				
				
u_dw_main	idw_master	
boolean		ib_commit		
				
integer		ii_dwcount = 0	
integer		ii_dwcurr = 0	
u_dw_main	idw_tree[20]	
uo_msg_log	iuo_msg_log
boolean		ib_askforsave	
				
string		is_wintype	
boolean		ib_f6_in_dw	

string		is_HelpKey
long		il_HelpTopic = 1
string		is_Password
string		is_Serialize
boolean		ib_openok = True
boolean		ib_NonModale = False
end variables

forward prototypes
public subroutine uf_route_event (string as_event)
end prototypes

event ue_insert;

THIS.uf_route_event("ue_insert")
end event

event ue_append;

THIS.uf_route_event("ue_append")
end event

event ue_update;

long				ll_size, ll_counter, ll_row
boolean			ll_update_ok
any				status
u_dw_main		ldwo_item

ll_update_ok = TRUE
ll_size = UpperBound(istr_dw)
ldwo_item = u_freddie.iudw_current
if (ldwo_item.accepttext()) >0 then
	
	ll_counter = 1
	do while ll_counter <= ll_size 
		ldwo_item = istr_dw[ll_counter].dw_control
		
		if (ldwo_item.trigger event ue_validate_rows()) > 0 then
			
			ll_update_ok = ll_update_ok AND TRUE
		else
			ll_update_ok = false
			ll_counter = ll_size+1
		end if
	loop
else
end if
if ll_update_ok then
	COMMIT USING SQLCA;
	if SQLCA.SQLCode < 0 then 
		ROLLBACK USING SQLCA;
	else
	   for ll_counter = 1 to ll_size 
	       ldwo_item = istr_dw[ll_counter].dw_control
	       ldwo_item.ResetUpdate()
	   next	
	end if
end if


end event

event ue_delete;

THIS.uf_route_event("ue_delete")
end event

event ue_togglequery;

THIS.uf_route_event("ue_togglequery")
end event

event ue_retrieve;

THIS.uf_route_event("ue_retrieve")
end event

event ue_firstrecord;

uf_route_event("ue_firstrecord")
end event

event ue_prevrecord;

uf_route_event("ue_prevrecord")
end event

event ue_nextrecord;

uf_route_event("ue_nextrecord")
end event

event ue_lastrecord;

uf_route_event("ue_lastrecord")
end event

event ue_clearquery;

uf_route_event("ue_clearquery")
end event

event ue_show;uf_route_event("ue_show")
end event

event ue_post_open();
PowerObject		lpo_object
datawindow		ldw_data
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

SETREDRAW(true)
end event

event ue_modify;uf_route_event("ue_modify")
end event

event ue_print;uf_route_event("ue_print")
end event

event ue_html;

THIS.uf_route_event("ue_html")
end event

event ue_saveas;

THIS.uf_route_event("ue_saveas")
end event

event ue_save_html;

THIS.uf_route_event("ue_save_html")
end event

event ue_help;if ae_Hcom = Keyword! then
	ShowHelp(u_freddie.is_helpfile, Keyword!, as_HelpKey)
else
	if ae_Hcom = Topic! then
		ShowHelp(u_freddie.is_helpfile, Topic!, al_HelpId)
	end if
end if

end event

public subroutine uf_route_event (string as_event);

u_dw_main ludw_current

ludw_current = u_freddie.iudw_current
if not IsNull(ludw_current) then
	ludw_current.triggerevent(as_event)
end if

end subroutine

on w_data_main.create
this.p_msg_log=create p_msg_log
this.p_crescente=create p_crescente
this.p_decrescente=create p_decrescente
this.Control[]={this.p_msg_log,&
this.p_crescente,&
this.p_decrescente}
end on

on w_data_main.destroy
destroy(this.p_msg_log)
destroy(this.p_crescente)
destroy(this.p_decrescente)
end on

event open;
//MM 171106 dovrebbe velocizzare la presentazione della finestra
//lo riaccendo nel ue_postopen
SETREDRAW(false)

ib_close_query = TRUE
ib_askforsave = TRUE
is_wintype = "_"					
u_freddie.iw_current = THIS
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
	
	postevent("ue_close")
end if


end event

event close;
if isvalid(u_freddie.iudw_current) then
	if u_freddie.iudw_current.ib_query_mode then
		m_app_frame.uf_enable_modifica(true)
	end if	
end if
SetNull(u_freddie.iudw_current)
If IsValid(iuo_msg_log) then
	
	iuo_msg_log.uf_new_text("",1)
	
	destroy iuo_msg_log
end if

end event

event deactivate;
SetNull(u_freddie.iw_current)

If IsValid(iuo_msg_log) then
	iuo_msg_log.uf_leave_msg()
end if
end event

event activate;
u_freddie.iw_current = this

If IsValid(iuo_msg_log) then
	iuo_msg_log.uf_catch_msg()
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

type p_msg_log from picture within w_data_main
boolean visible = false
integer x = 23
integer y = 20
integer width = 96
integer height = 84
string picturename = "s:\pb\commonframework\info_in.bmp"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;
integer li_in

li_in=iuo_msg_log.uf_manage_msg()
parent.SetFocus()

end event

type p_crescente from picture within w_data_main
boolean visible = false
integer width = 37
integer height = 48
boolean bringtotop = true
string picturename = "s:\pb\commonframework\cresc.bmp"
boolean focusrectangle = false
end type

type p_decrescente from picture within w_data_main
boolean visible = false
integer x = 46
integer width = 37
integer height = 48
boolean bringtotop = true
string picturename = "s:\pb\commonframework\decres.bmp"
boolean focusrectangle = false
end type

