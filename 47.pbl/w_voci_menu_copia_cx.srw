forward
global type w_voci_menu_copia_cx from window
end type
type tvb_target from u_tv_menu_button within w_voci_menu_copia_cx
end type
type tvb_menu from u_tv_menu_button within w_voci_menu_copia_cx
end type
type tv_target from u_tv_menu within w_voci_menu_copia_cx
end type
type tv_menu from u_tv_menu within w_voci_menu_copia_cx
end type
type ddlb_tv_target from dropdownlistbox within w_voci_menu_copia_cx
end type
type ddlb_tv_menu from dropdownlistbox within w_voci_menu_copia_cx
end type
type st_tv_target_t from statictext within w_voci_menu_copia_cx
end type
type st_tv_menu_t from statictext within w_voci_menu_copia_cx
end type
end forward

global type w_voci_menu_copia_cx from window
integer x = 900
integer y = 6
integer width = 2388
integer height = 1936
boolean titlebar = true
string title = "Riorganizzazione Menu"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
long backcolor = 79741120
event ue_setlevel ( )
tvb_target tvb_target
tvb_menu tvb_menu
tv_target tv_target
tv_menu tv_menu
ddlb_tv_target ddlb_tv_target
ddlb_tv_menu ddlb_tv_menu
st_tv_target_t st_tv_target_t
st_tv_menu_t st_tv_menu_t
end type
global w_voci_menu_copia_cx w_voci_menu_copia_cx

type variables
long	il_id_menu[], il_DragSource
string	is_DragSource
end variables

event close;
if isvalid(u_freddie.iudw_current) then
	if u_freddie.iudw_current.ib_query_mode then
		m_app_frame.uf_enable_modifica(true)
	end if	
end if
end event

event resize;
end event

on w_voci_menu_copia_cx.create
this.tvb_target=create tvb_target
this.tvb_menu=create tvb_menu
this.tv_target=create tv_target
this.tv_menu=create tv_menu
this.ddlb_tv_target=create ddlb_tv_target
this.ddlb_tv_menu=create ddlb_tv_menu
this.st_tv_target_t=create st_tv_target_t
this.st_tv_menu_t=create st_tv_menu_t
this.Control[]={this.tvb_target,&
this.tvb_menu,&
this.tv_target,&
this.tv_menu,&
this.ddlb_tv_target,&
this.ddlb_tv_menu,&
this.st_tv_target_t,&
this.st_tv_menu_t}
end on

on w_voci_menu_copia_cx.destroy
destroy(this.tvb_target)
destroy(this.tvb_menu)
destroy(this.tv_target)
destroy(this.tv_menu)
destroy(this.ddlb_tv_target)
destroy(this.ddlb_tv_menu)
destroy(this.st_tv_target_t)
destroy(this.st_tv_menu_t)
end on

event open;

string	ls_name		
long		ll_index 	
long		ll_id_menu
window	lw_pw

declare lcur_menu cursor for
  SELECT id_menu, menu_descrizione
    FROM menu ;
open lcur_menu;

if sqlca.sqlcode < 0 then
	MessageBox ("DataBase Error!", sqlca.sqlerrtext, exclamation!)
	return
end if 

ddlb_tv_menu.SetRedraw(false)
ddlb_tv_target.setRedraw(false)

do while sqlca.sqlcode = 0
	fetch lcur_menu into :ll_id_menu, :ls_name ;
	if sqlca.sqlcode = 0 then
		ll_index = ddlb_tv_menu.AddItem (ls_name)
		ddlb_tv_target.AddItem (ls_name)
		
		il_id_menu[ll_index] = ll_id_menu
	elseif sqlca.sqlcode < 0 then
		MessageBox ("DataBase Error", sqlca.sqlerrtext, exclamation!)
		return
	else
		exit
	end if
loop

ddlb_tv_menu.SetRedraw(true)
ddlb_tv_target.SetRedraw(true)

close lcur_menu;

lw_pw = parentwindow()
this.x = lw_pw.workspacex() + 250
this.y = lw_pw.workspacey() - 150	


end event

type tvb_target from u_tv_menu_button within w_voci_menu_copia_cx
integer x = 1211
integer y = 221
integer width = 1097
integer height = 186
integer taborder = 50
end type

event constructor;call super::constructor;itv_tv = tv_target
end event

on tvb_target.destroy
call u_tv_menu_button::destroy
end on

type tvb_menu from u_tv_menu_button within w_voci_menu_copia_cx
integer x = 48
integer y = 221
integer width = 1097
integer height = 186
integer taborder = 30
end type

on tvb_menu.destroy
call u_tv_menu_button::destroy
end on

event constructor;call super::constructor;itv_tv = tv_menu

end event

type tv_target from u_tv_menu within w_voci_menu_copia_cx
integer x = 1211
integer y = 442
integer width = 1097
integer height = 1360
integer taborder = 10
string dragicon = "Question!"
boolean dragauto = true
boolean disabledragdrop = false
long statepicturemaskcolor = 553648127
end type

event dragdrop;call super::dragdrop;Integer				li_index
long					ll_id_padre, ll_id_oggetto, ll_id_voci_menu_start, ll_id_voci_menu, &
						ll_id_menu_orig, ll_id_menu_target, ll_i
TreeViewItem		ltvi_Padre
s_voice				lstr_voce
long					ll_id_vm[]
string 				ls_header_menu

if GetItem(handle, ltvi_Padre) = -1 then
	handle = FindItem(RootTreeItem! , 0)
	GetItem(handle, ltvi_Padre)
end if
if handle = -1 then
	MessageBox("Attenzione", "Scegliere il menu in quale copiare.")
	Return
end if
SetDropHighlight(handle)

lstr_voce = ltvi_Padre.Data
ll_id_padre = lstr_voce.l_id_voice
ll_id_oggetto = lstr_voce.l_id_object

if Not IsNull(ll_id_oggetto) AND ll_id_oggetto > 0 then
	MessageBox("Attenzione", "Impossibile copiare sotto la voce con oggetto.")
	Return
end if

ll_id_menu_target = This.il_id_menu

if il_dragsource = 0 then
	
	ll_id_menu_orig = tv_menu.il_id_menu
	
	if ll_id_menu_orig = ll_id_menu_target then
		MessageBox("Attenzione", "Impossibile copiare un menu sotto se stesso.")
		Return
	end if
end if
If MessageBox("Copia voci menu", + &
				"Si è sicuri di voler copiare tutte le voci partendo dalla voce ~r<" + &
				is_dragsource + "> sotto la voce <" + ltvi_Padre.label + &
				">?", Question!, YesNo!) = 2 Then Return
				
SetPointer(HourGlass!)

if il_dragsource > 0 then
	
	if handle = 1 then
		
		f_recurse_voci_menu(il_dragsource, ll_id_menu_target, "M")
	else
		
		f_recurse_voci_menu(il_dragsource, ll_id_padre, "V")
	end if
	COMMIT using SQLCA;
else
	if handle = 1 then
		
		select header_menu
		into :ls_header_menu
		from dba.voci_menu
		where id_voci_menu=:ll_id_menu_orig;
		
		INSERT INTO dba.voci_menu(id_menu, vmenu_voce, header_menu) 
			VALUES (:ll_id_menu_target, :is_dragsource, :ls_header_menu) ;
		sqlca.identity(ll_id_voci_menu_start);
	else
		
		INSERT INTO dba.voci_menu(id_voci_menu_padre, vmenu_voce) 
			VALUES (:ll_id_padre, :is_dragsource) ;
		sqlca.identity(ll_id_voci_menu_start);
	end if
	COMMIT using SQLCA;
	
	
	
	declare lcur_menu cursor for
	  SELECT distinct id_voci_menu
		 FROM voci_menu
		 WHERE ( voci_menu.id_menu = :ll_id_menu_orig )   ;
	open lcur_menu;
	if sqlca.sqlcode < 0 then
		MessageBox ("DataBase Error-1!", sqlca.sqlerrtext, exclamation!)
		return -1
	end if 
	
	do while sqlca.sqlcode = 0
		fetch lcur_menu into :ll_id_voci_menu ;
		if sqlca.sqlcode = 0 then
			
			ll_id_vm[UpperBound(ll_id_vm)+1] = ll_id_voci_menu
		elseif sqlca.sqlcode < 0 then
			MessageBox ("DataBase Error-2!", sqlca.sqlerrtext, exclamation!)
			return -1
		end if
	loop
	close lcur_menu;
	
	for ll_i = 1 to UpperBound(ll_id_vm)
		f_recurse_voci_menu(ll_id_vm[ll_i], ll_id_voci_menu_start, "V")
	next
	COMMIT using SQLCA;
end if

li_index = ddlb_tv_target.FindItem (is_menu_name, 0)
ddlb_tv_target.Event selectionchanged(li_index)

SetPointer(Arrow!)

end event

event dragwithin;call super::dragwithin;TreeViewItem		ltvi_Over

If GetItem(handle, ltvi_Over) = -1 Then
	SetDropHighlight(0)
	Return
else
	SetDropHighlight(handle)
End If

end event

event begindrag;call super::begindrag;TreeViewItem	ltvi_DragSource

if GetItem(handle, ltvi_DragSource) > 0 then
	il_dragsource = 0
	is_dragsource = ""
	MessageBox("Attenzione", "Impossibile far partire la copia da questa finestra")
	This.Drag(Cancel!)
	Return
end if

end event

event ue_delete_item;call super::ue_delete_item;long li_index

li_index = ddlb_tv_target.FindItem (is_menu_name, 0)
ddlb_tv_target.Event selectionchanged(li_index)

end event

type tv_menu from u_tv_menu within w_voci_menu_copia_cx
integer x = 48
integer y = 442
integer width = 1097
integer height = 1360
integer taborder = 20
string dragicon = "Question!"
boolean dragauto = true
boolean deleteitems = true
boolean disabledragdrop = false
end type

event begindrag;call super::begindrag;TreeViewItem		ltvi_Source
s_voice 				lstr_voice

GetItem(handle, ltvi_Source)
is_DragSource = ltvi_Source.Label
if handle > 1 then
	lstr_voice= ltvi_Source.Data
	
	il_DragSource = lstr_voice.l_id_voice
else
	il_DragSource = 0
end if
end event

event dragdrop;call super::dragdrop;MessageBox("Avviso", "Impossibile spostare le voci dentro questa finestra")
end event

event ue_delete_item;call super::ue_delete_item;long li_index

li_index = ddlb_tv_menu.FindItem (is_menu_name, 0)
ddlb_tv_menu.Event selectionchanged(li_index)

end event

type ddlb_tv_target from dropdownlistbox within w_voci_menu_copia_cx
integer x = 1211
integer y = 102
integer width = 1097
integer height = 400
integer taborder = 40
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean sorted = false
boolean vscrollbar = true
end type

event selectionchanged;
long		ll_handle

SetPointer(HourGlass!)

ll_handle = tv_target.FindItem(RootTreeItem!, 0)
tv_target.DeleteItem(ll_handle)

st_tv_target_t.Text = "Menu di arrivo"

if (Not IsNull(index) And index > 0) then tv_target.il_id_menu = il_id_menu[index]
tv_target.is_menu_name = This.Text
st_tv_target_t.Text = st_tv_target_t.Text + ": " + This.Text
tv_target.Event ue_expand(2)
tv_target.SetFocus()

SetPointer(Arrow!)
end event

type ddlb_tv_menu from dropdownlistbox within w_voci_menu_copia_cx
integer x = 48
integer y = 102
integer width = 1097
integer height = 400
integer taborder = 60
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean sorted = false
boolean vscrollbar = true
end type

event selectionchanged;
long		ll_handle

SetPointer(HourGlass!)

ll_handle = tv_menu.FindItem(RootTreeItem!, 0)
tv_menu.DeleteItem(ll_handle)

st_tv_menu_t.Text = "Menu di partenza"

if (Not IsNull(index) And index > 0) then tv_menu.il_id_menu = il_id_menu[index]
tv_menu.is_menu_name = This.Text
st_tv_menu_t.Text = st_tv_menu_t.Text + ": " + This.Text
tv_menu.Event ue_expand(2)
tv_menu.SetFocus()

SetPointer(Arrow!)
end event

type st_tv_target_t from statictext within w_voci_menu_copia_cx
integer x = 1211
integer y = 22
integer width = 1097
integer height = 80
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
string text = "Menu di arrivo"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_tv_menu_t from statictext within w_voci_menu_copia_cx
integer x = 48
integer y = 22
integer width = 1097
integer height = 80
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
string text = "Menu di partenza"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

