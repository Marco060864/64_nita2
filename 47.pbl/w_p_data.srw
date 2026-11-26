forward
global type w_p_data from w_data_main
end type
type cb_ok from commandbutton within w_p_data
end type
type cb_annulla from commandbutton within w_p_data
end type
type cb_nuovo from commandbutton within w_p_data
end type
type cb_inserisci from commandbutton within w_p_data
end type
type cb_cancella from commandbutton within w_p_data
end type
type cb_salva from commandbutton within w_p_data
end type
type tab_1 from tab within w_p_data
end type
type tabpage_1 from userobject within tab_1
end type
type tabpage_1 from userobject within tab_1
end type
type tab_1 from tab within w_p_data
tabpage_1 tabpage_1
end type
type cb_ricerca from commandbutton within w_p_data
end type
end forward

global type w_p_data from w_data_main
integer x = 603
integer y = 4
integer width = 2446
integer height = 1604
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
event ue_insert_mode ( )
event type integer ue_dwsetfocus ( u_dw_main audw_udw )
event ue_master_search ( )
event ue_master_delete ( )
event ue_pre_nuovo ( )
event ue_post_nuovo ( )
cb_ok cb_ok
cb_annulla cb_annulla
cb_nuovo cb_nuovo
cb_inserisci cb_inserisci
cb_cancella cb_cancella
cb_salva cb_salva
tab_1 tab_1
cb_ricerca cb_ricerca
end type
global w_p_data w_p_data

type variables
end variables

forward prototypes
public subroutine uf_only_shared ()
public function integer uf_buildtree (u_dw_main audw_dw)
public function integer uf_dwsetfocus (ref u_dw_main audw_dw)
public function integer uf_retrieve_dddw (integer ai_index)
end prototypes

event ue_insert_mode;call super::ue_insert_mode;idw_master.TriggerEvent("ue_insert")


end event

event ue_dwsetfocus;call super::ue_dwsetfocus;
this.uf_dwsetfocus(audw_udw)
return 0
end event

public subroutine uf_only_shared ();long ll_size, ll_counter
u_dw_main ldwo_item

ll_size = UpperBound(istr_dw)
for ll_counter = 1 to ll_size 
	ldwo_item = istr_dw[ll_counter].dw_control
	if not ldwo_item.ib_dw_shared then
		ldwo_item.Enabled = FALSE
	end if
next



end subroutine

public function integer uf_buildtree (u_dw_main audw_dw);integer	li_cnt, li_size, li_i

li_cnt = ii_dwcount
li_cnt++
idw_tree[li_cnt] = audw_dw
ii_dwcount = li_cnt
li_size = upperbound(audw_dw.iudw_children)
for li_i = 1 to li_size
	uf_buildtree(audw_dw.iudw_children[li_i])
next
return 0
end function

public function integer uf_dwsetfocus (ref u_dw_main audw_dw);datawindow  ldw_uno
PowerObject lpo_uno, lpo_due
Userobject  luo_uno
tab			ltb_uno
integer		ll_retval

ldw_uno = audw_dw
ll_retval = 0

lpo_uno = ldw_uno.GetParent()
if typeof(lpo_uno) = UserObject! then
	lpo_due = lpo_uno.GetParent()
	if typeof(lpo_due) = Tab! then
		ltb_uno = lpo_due
		luo_uno = lpo_uno
		
		
		
		if (ltb_uno.visible) and (ltb_uno.enabled) and (luo_uno.visible) and (luo_uno.enabled) then

			ltb_uno.SelectTab(lpo_uno)
			
			lpo_uno = ltb_uno.GetParent()
			
			if typeof(lpo_uno) = UserObject! then
				lpo_due = lpo_uno.GetParent()
				if typeof(lpo_due) = Tab! then
					ltb_uno = lpo_due
					luo_uno = lpo_uno
					
					
					
					if (ltb_uno.visible) and (ltb_uno.enabled) and (luo_uno.visible) and (luo_uno.enabled) then
						
						ltb_uno.SelectTab(lpo_uno)
					else
						ll_retval = -2
					end if
				else
					
					ll_retval = 2
				end if
			else
				
			end if

		else
			ll_retval = -1
		end if
		
	else
		
		ll_retval = 1
	end if
else
	
end if
ldw_uno.setfocus()

return ll_retval

end function

public function integer uf_retrieve_dddw (integer ai_index);
PowerObject		lpo_object
datawindow		ldw_data
u_dw_main		ldw_u_dw_main
integer 			li_size, li_i
integer			li_size_k, li_k
integer			li_size_z, li_z
integer			li_count
tab				ltb_panel
UserObject		luo_tab_page
li_size = UpperBound( this.Control )

li_count	= 0

for li_i = 1 to li_size 
	if not isNull(this.Control[li_i]) then

		if this.Control[li_i].TypeOf() = Tab! then
			ltb_panel = this.Control[li_i]
			li_size_k = UpperBound( ltb_panel.Control )
			for li_k = 1 to li_size_k 
				if not isNull(ltb_panel.Control[li_k]) then

					if ltb_panel.Control[li_k].TypeOf() = UserObject! then
						li_count++
						if li_count = ai_index then
							luo_tab_page = ltb_panel.Control[li_k]
							li_size_z = UpperBound( luo_tab_page.Control )
							for li_z = 1 to li_size_z 
																
								if luo_tab_page.Control[li_z].TypeOf() = DataWindow! then
									lpo_object = luo_tab_page.Control[li_z]
									ldw_data   = lpo_object
									
									if not isNull( ldw_data.DataObject ) and ldw_data.DataObject <> "" then
										ldw_data.triggerevent("ue_retrieve_dddw")
									end if	
								end if
								
							next
						end if	
					end if
				end if	

			next	
		end if	
	end if	
next	

return 0
end function

on w_p_data.create
int iCurrent
call super::create
this.cb_ok=create cb_ok
this.cb_annulla=create cb_annulla
this.cb_nuovo=create cb_nuovo
this.cb_inserisci=create cb_inserisci
this.cb_cancella=create cb_cancella
this.cb_salva=create cb_salva
this.tab_1=create tab_1
this.cb_ricerca=create cb_ricerca
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ok
this.Control[iCurrent+2]=this.cb_annulla
this.Control[iCurrent+3]=this.cb_nuovo
this.Control[iCurrent+4]=this.cb_inserisci
this.Control[iCurrent+5]=this.cb_cancella
this.Control[iCurrent+6]=this.cb_salva
this.Control[iCurrent+7]=this.tab_1
this.Control[iCurrent+8]=this.cb_ricerca
end on

on w_p_data.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.cb_annulla)
destroy(this.cb_nuovo)
destroy(this.cb_inserisci)
destroy(this.cb_cancella)
destroy(this.cb_salva)
destroy(this.tab_1)
destroy(this.cb_ricerca)
end on

event open;call super::open;

integer			li_size, li_i
s_list_main		lstr_list, lstr_2

is_wintype = "W_P_DATA"
lstr_list = Message.PowerObjectParm

if isValid(lstr_list) then
	li_size = upperBound(lstr_list.l_identifica)
	if li_size <1 then
		li_size = upperbound(lstr_list.s_identifica)
		for li_i = 1 to li_size
			lstr_list.l_identifica[li_i] = -1
		next
		Message.PowerObjectParm = lstr_list
	end if
else
		Message.PowerObjectParm = lstr_2
end if
end event

event ue_retrieve;

idw_master.TriggerEvent("ue_retrieve")
end event

event ue_post_open;call super::ue_post_open;

CHOOSE CASE idw_master.is_list.s_modo
	CASE modo_inserisci
		cb_nuovo.Visible = TRUE
		TriggerEvent("ue_insert_mode")
	CASE modo_modifica
		cb_nuovo.Visible = FALSE
		TriggerEvent("ue_retrieve")
		TriggerEvent("ue_modify")
	CASE modo_visualizza
		cb_nuovo.Visible = FALSE
		idw_master.Enabled = FALSE
		TriggerEvent("ue_retrieve")
		idw_master.TriggerEvent("ue_show")
END CHOOSE
if  ib_nonmodale = true then
   cb_nuovo.visible = true
   cb_ricerca.visible = true
else
   cb_ricerca.visible = FALSE
end if
uf_buildtree(idw_master)
ii_dwcurr = 1
idw_master.SetFocus()

end event

event ue_modify;idw_master.TriggerEvent("ue_modify")

end event

event ue_update;
idw_master.TriggerEvent("ue_update")
end event

event closequery;
long			ll_mods
integer		li_ync, li_retval
u_dw_main	ludw_1
boolean		lb_ok

ludw_1 = u_freddie.iudw_current
lb_ok = true
if IsValid(ludw_1) then 
	if ludw_1.acceptText()>0 then lb_ok = true else lb_ok = false
end if
if not lb_ok then return 1
if idw_master.acceptText() >0 then lb_ok = true else lb_ok = false
if not lb_ok then return 1

if idw_master.uf_to_update() > 0 then
	li_ync = MessageBox(idw_master.is_title, "Ci sono modifiche non salvate nella " + &
		"finestra.~n~rVuoi salvarle?", Question!, YesNoCancel!)
	CHOOSE CASE li_ync
		CASE 1
			
			THIS.triggerevent("ue_update")
			ll_mods = idw_master.uf_to_update()
			if ll_mods = 0 then 
				li_retval = 0
			else
				li_retval = 1
			end if
			
		CASE 2
			
			li_retval = 0
			
		CASE 3
			
			li_retval = 1
			
	END CHOOSE
else
	
	li_retval = 0
	
end if

return li_retval

end event

event key;call super::key;

integer		li_cdw, li_ret

choose case key
	case KeyN!
		if (keyflags=2) then
			if (idw_master.is_list.s_modo=modo_inserisci) or (ib_nonmodale=true) then
				cb_nuovo.triggerevent(clicked!)
			end if
		end if
	case KeyS!
		if (keyflags=2) then
			cb_salva.triggerevent(clicked!)
		end if
	case KeyF12!
		if (keyflags=0) then
			cb_salva.triggerevent(clicked!)
		end if
	case KeyF6!
		
		
		if not ib_F6_in_dw then
			if (keyflags=0) then		
				li_ret = -1
				do while li_ret<0
					li_cdw = ii_dwcurr
					li_cdw++
					if li_cdw > ii_dwcount then li_cdw = 1
					ii_dwcurr = li_cdw
					li_ret = uf_dwsetfocus(idw_tree[li_cdw])
				loop
			end if
			if (keyFlags=1) then		
				li_ret = -1
				do while li_ret<0
					li_cdw = ii_dwcurr
					li_cdw --
					if li_cdw < 1 then li_cdw = ii_dwcount
					ii_dwcurr = li_cdw
					li_ret = uf_dwsetfocus(idw_tree[li_cdw])
				loop
			end if
		end if
		ib_F6_in_dw = false
		
end choose

end event

event ue_close;call super::ue_close;
close (this)
end event

event close;call super::close;
long				ll_row
integer			li_size, li_i
string			ls_colname
u_dw_main		ludw_1
s_rit_wp			istr_rit


ludw_1 = idw_master
ll_row = ludw_1.getRow()
istr_rit = ludw_1.is_ritorni
istr_rit.s_modo_rit = "X"
if ll_row>0 then
	li_size = UpperBound(ludw_1.is_list.s_identifica)
	for li_i = 1 to li_size
		ls_colname = ludw_1.is_list.s_identifica[li_i]
		istr_rit.l_identifica[li_i] = ludw_1.GetItemNumber(ll_row, ls_colname)
	next
end if
Message.PowerObjectParm = istr_rit


end event

type p_msg_log from w_data_main`p_msg_log within w_p_data
end type

type p_crescente from w_data_main`p_crescente within w_p_data
end type

type p_decrescente from w_data_main`p_decrescente within w_p_data
end type

type cb_ok from commandbutton within w_p_data
integer x = 46
integer y = 40
integer width = 261
integer height = 84
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ok"
end type

event clicked;long ll_row, ll_id
string s_col_name
integer li_counter
long ll_size

if isValid(u_freddie.iudw_current) then
	u_freddie.iudw_current.AcceptText()
end if
if parent.idw_master.uf_To_Update() > 0 then
	parent.TriggerEvent("ue_update")
end if
ll_row = idw_master.GetRow()

is_filter = ""
ll_size = UpperBound(idw_master.is_list.s_identifica)
if ll_row>0 then
	for  li_counter = 1 to ll_size
		s_col_name = idw_master.is_list.s_identifica[li_counter]
		is_filter = is_filter + " AND " + s_col_name + " = " + string(idw_master.GetItemNumber(ll_row, s_col_name))
	next
	is_filter = Mid(is_filter,5)
end if
ib_close_query = FALSE

parent.TriggerEvent("ue_close")

end event

type cb_annulla from commandbutton within w_p_data
integer x = 343
integer y = 40
integer width = 261
integer height = 84
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Annulla"
end type

event clicked;parent.TriggerEvent("ue_close")

end event

type cb_nuovo from commandbutton within w_p_data
integer x = 686
integer y = 40
integer width = 261
integer height = 84
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Nuovo"
end type

event clicked;
integer		li_ync

if idw_master.uf_to_update() > 0 then
	li_ync = MessageBox(idw_master.is_title, "Ci sono modifiche non salvate nella " + &
		"finestra.~n~rVuoi salvarle?", Question!, YesNoCancel!)
	CHOOSE CASE li_ync
		CASE 1
			u_freddie.iw_current.ib_askforsave	= false
			if (idw_master.event ue_update (0,0) = 0) then 
				idw_master.sharedataoff()
				
				idw_master.reset()
				
				triggerevent("ue_pre_nuovo")
				idw_master.is_list.s_modo	= modo_inserisci
				idw_master.triggerevent("ue_insert")
				triggerevent("ue_post_nuovo")
			end if
			u_freddie.iw_current.ib_askforsave	= true
		CASE 2
			
			idw_master.sharedataoff()
			idw_master.reset()
			
			triggerevent("ue_pre_nuovo")
			idw_master.is_list.s_modo	= modo_inserisci
			idw_master.triggerevent("ue_insert")
			triggerevent("ue_post_nuovo")
			
		CASE 3
			
	END CHOOSE
else
	
	idw_master.sharedataoff()
	
	idw_master.reset()
	
	triggerevent("ue_pre_nuovo")
	idw_master.is_list.s_modo	= modo_inserisci
	idw_master.triggerevent("ue_insert")
	triggerevent("ue_post_nuovo")
end if

idw_master.SetFocus()

end event

type cb_inserisci from commandbutton within w_p_data
integer x = 1509
integer y = 40
integer width = 261
integer height = 84
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Inserisci"
end type

event clicked;

w_p_data  lw_win
u_dw_main lu_dw

lw_win = u_freddie.iw_current
lu_dw = u_freddie.iudw_current
if IsValid(lu_dw) then
	if isValid(lu_dw.iudw_parent) then
		if not lu_dw.ib_dw_shared then
			parent.triggerevent("ue_insert")
		end if
	end if
end if

end event

type cb_cancella from commandbutton within w_p_data
integer x = 1806
integer y = 40
integer width = 261
integer height = 84
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancella"
end type

event clicked;

w_p_data  lw_win
u_dw_main lu_dw

lw_win = u_freddie.iw_current
lu_dw = u_freddie.iudw_current
if isValid(lu_dw) then
	if isValid(lu_dw.iudw_parent) then
		if not lu_dw.ib_dw_shared then
			if lu_dw.RowCount() >0 then
				parent.triggerevent("ue_delete")
			end if
		end if
   else
      parent.triggerevent("ue_master_delete")
	end if
end if

end event

type cb_salva from commandbutton within w_p_data
integer x = 2103
integer y = 40
integer width = 261
integer height = 84
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salva"
end type

event clicked;parent.TriggerEvent("ue_update")
end event

type tab_1 from tab within w_p_data
integer x = 41
integer y = 164
integer width = 2359
integer height = 1320
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
boolean raggedright = true
integer selectedtab = 1
tabpage_1 tabpage_1
end type

event selectionchanging;
end event

on tab_1.create
this.tabpage_1=create tabpage_1
this.Control[]={this.tabpage_1}
end on

on tab_1.destroy
destroy(this.tabpage_1)
end on

event selectionchanged;uf_retrieve_dddw(newindex)
end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 2322
integer height = 1200
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
end type

type cb_ricerca from commandbutton within w_p_data
integer x = 1211
integer y = 40
integer width = 261
integer height = 84
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Ricerca..."
end type

event constructor;This.Visible = FALSE
end event

