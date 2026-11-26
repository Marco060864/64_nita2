forward
global type w_list_main from w_data_main
end type
type dw_list from u_dw_list_main within w_list_main
end type
end forward

global type w_list_main from w_data_main
integer width = 2615
integer height = 1060
dw_list dw_list
end type
global w_list_main w_list_main

type variables
string ias_key_name[]
end variables

on w_list_main.create
int iCurrent
call super::create
this.dw_list=create dw_list
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_list
end on

on w_list_main.destroy
call super::destroy
destroy(this.dw_list)
end on

event ue_post_open;call super::ue_post_open;dw_list.ias_key_name = ias_key_name
dw_list.TriggerEvent("ue_retrieve")

end event

event open;call super::open;dw_list.is_list = Message.PowerObjectParm
Message.Processed = true
dw_list.object.datawindow.retrieve.AsNeeded = "Yes"
is_wintype = "W_LIST_MAIN"

this.y = 100

end event

event ue_append;uf_route_event("ue_append")
end event

event ue_togglequery;call super::ue_togglequery;

end event

event resize;dw_list.Width = newwidth - 80
dw_list.Height = newheight - 200
end event

type p_msg_log from w_data_main`p_msg_log within w_list_main
end type

type p_crescente from w_data_main`p_crescente within w_list_main
end type

type p_decrescente from w_data_main`p_decrescente within w_list_main
end type

type dw_list from u_dw_list_main within w_list_main
integer x = 46
integer y = 40
integer width = 2469
integer height = 880
integer taborder = 20
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylebox!
end type

event doubleclicked;call super::doubleclicked;
string ls_column

if row = 0 then 
	if not (dwo.Name = "datawindow") then
	 	ls_column = Mid( dwo.name, 1, Len(string(dwo.name)) - 2)
		if ls_column = is_last_column then 
			if is_last_sort = "D" then
				this.SetSort(ls_column + " A")
				is_last_sort = "A"
				parent.p_crescente.x = Long(dwo.X) + 45
				parent.p_crescente.Y = Long(dwo.Y) + 45
				parent.p_crescente.Visible = TRUE
				parent.p_decrescente.Visible = FALSE
			else
				this.SetSort(ls_column + " D")
				is_last_sort = "D"
				parent.p_decrescente.x = Long(dwo.X) + 45
				parent.p_decrescente.Y = Long(dwo.Y) + 45
				parent.p_crescente.Visible = FALSE
				parent.p_decrescente.Visible = TRUE
				
			end if
		else 
			this.SetSort(ls_column + " A")
			is_last_column = ls_column
			is_last_sort = "A"
			parent.p_crescente.x = Long(dwo.X) + 45
			parent.p_crescente.Y = Long(dwo.Y) + 45
			parent.p_crescente.Visible = TRUE
			parent.p_decrescente.Visible = FALSE
		end if
		this.Sort()
	end if
else
	if ib_query_mode then 
		postevent ("ue_togglequery")
	else
		TriggerEvent("ue_modify")
	end if
end if 

end event

event ue_togglequery;call super::ue_togglequery;
integer li_colonne, li_i, li_retval
string  ls_nome, ls_colonne, ls_style

ib_query_mode = not ib_query_mode
ls_colonne = this.Object.DataWindow.Column.Count
li_colonne = integer(ls_colonne)
IF ib_query_mode THEN
	this.reset()
	for li_i = 1 to li_colonne
		this.SetTabOrder ( li_i, 10*li_i )
		ls_style = this.describe("#"+string(li_i)+".edit.style")
		if (ls_style <> "ddlb") and (ls_style <> "dddw") then
			this.modify("#"+string(li_i)+".Criteria.override_edit=yes")
		end if
		
	next
	THIS.Object.DataWindow.querymode = "Yes"
	THIS.Selectrow(0,FALSE)
	m_app_frame.uf_enable_modifica(false)
ELSE
	THIS.Object.DataWindow.querymode = "No"
	this.reset()
	m_app_frame.uf_enable_modifica(true)
	for li_i = 1 to li_colonne
		li_retval = this.SetTabOrder ( li_i, 0 )
		this.setcolumn(li_i)
		ls_nome = this.getcolumnname()
		this.modify(ls_nome+".Criteria.override_edit=no")
	next
	THIS.triggerevent("ue_retrieve")
END IF


end event

event itemfocuschanged;
end event

event ue_keystop;long		ll_row

ll_row = getrow()
if KeyDown(KeyEnter!) then
	if not ib_query_mode then
		if ll_row>0 then
			PostEvent("doubleclicked")
			return 1
		end if
	end if
end if

end event

event ue_clearquery;call super::ue_clearquery;
THIS.Object.DataWindow.QueryClear = "Yes"
if ib_query_mode=false then
	THIS.triggerevent("ue_retrieve")
end if
end event

event ue_modify;parent.enabled = false
this.enabled = false
super::event ue_modify ()
this.enabled = true
parent.enabled = true

end event

event ue_update;
end event

event ue_key;
w_data_main		lw_win
u_dw_main		lu_dw
string ls_style, ls_column

choose case key
	case KeyF1!
		if (keyflags = 0 Or keyflags = 1 Or keyflags = 2) then
			u_freddie.iw_current.Event ue_help(Topic!, long(this.object.DataWindow.Help.TypeID.Retrieve.Argument), "")
		end if

	case Keyadd!
		if (keyFlags=2) then
			lw_win = u_freddie.iw_current
			lu_dw = lw_win.idw_master
			if this = lu_dw then
				if is_list.s_modo = modo_inserisci then 			
					if (event ue_update (0,0) = 0) then
						triggerevent("ue_insert")
					end if
					lu_dw.setFocus()
				end if
			else
				triggerevent("ue_insert")
			end if
		end if
	case KeySubtract!
		if (keyFlags=2) then
			lw_win = u_freddie.iw_current
			lu_dw = lw_win.idw_master
			if this <> lu_dw then
				triggerevent("ue_delete")
			end if
		end if
	case KeyS!
		if (keyFlags=2) then
			lw_win = u_freddie.iw_current
			lu_dw = lw_win.idw_master
			lu_dw.triggerevent("ue_update")
		end if
	case KeyN!
		if (keyFlags=2) then
			lw_win = u_freddie.iw_current
			lu_dw = lw_win.idw_master
			if lu_dw.is_list.s_modo = modo_inserisci then 			
				if (lu_dw.event ue_update (0,0) = 0) then
					lu_dw.triggerevent("ue_insert")
				end if
				lu_dw.setFocus()
			end if
		end if
	case keydelete!		
		ls_column = getColumnName()
		ls_style = this.describe(ls_column+".edit.style")
		if ls_style = "ddlb" then
			uf_set_colval(ls_column,u_freddie.gs_null)
		end if
end choose


end event

