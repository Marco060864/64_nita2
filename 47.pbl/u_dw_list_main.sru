forward
global type u_dw_list_main from u_dw_main
end type
end forward

global type u_dw_list_main from u_dw_main
int Width=1939
int Height=617
end type
global u_dw_list_main u_dw_list_main

type variables


long il_righe, il_step

end variables

forward prototypes
public subroutine uf_get_key_col_values ()
end prototypes

public subroutine uf_get_key_col_values ();long ll_size, ll_counter, ll_row

ll_row = this.GetRow()
if ll_row > 0 then
	ll_size = UpperBound(ias_key_name)
	for ll_counter = 1 to ll_size 
		is_list.s_identifica[ll_counter] = ias_key_name[ll_counter]
		is_list.l_identifica[ll_counter] = this.GetItemNumber(ll_row, ias_key_name[ll_counter])
	next
end if

end subroutine

event ue_show;call super::ue_show;
is_list.s_modo = modo_visualizza
uf_get_key_col_values()
OpenWithParm(iw_support, is_list, is_resp_window)
end event

event ue_insert;call super::ue_insert;long 			ll_row, ll_nr
integer		li_size, li_counter
string 		ls_filter, ls_colname, ls_colval
s_rit_wp		lstr_rit

is_list.s_modo = modo_inserisci
uf_get_key_col_values()
OpenWithParm(iw_support, is_list, is_resp_window)
if UpperBound(is_list.l_identifica) > 0 then
	is_list.l_identifica[1] = 0
end if
ls_filter = ""
lstr_rit = Message.PowerObjectParm
li_size = UpperBound(lstr_rit.s_identifica)
for  li_counter = 1 to li_size
	ls_colname = lstr_rit.s_identifica[li_counter]
	ls_colval = string(lstr_rit.l_identifica[li_counter])
	ls_filter = ls_filter + " AND " + ls_colname + " = " + ls_colval
next
ls_filter = Mid(ls_filter,5)


	
	Retrieve()
	ll_nr = rowcount()
	
	if ll_nr>0 then
		selectrow(1,true)
	end if
	ll_row = Find( ls_filter, 1, RowCount( ))
	ScrollToRow(ll_row)


end event

event ue_modify;call super::ue_modify;long			ll_row, ll_nr
integer		li_size, li_counter
string		ls_filter, ls_colname, ls_colval
s_rit_wp		lstr_rit





is_list.s_modo = modo_modifica
uf_get_key_col_values()
OpenWithParm(iw_support, is_list, is_resp_window)

if UpperBound(is_list.l_identifica) > 0 then
	is_list.l_identifica[1] = 0
end if

ls_filter = ""
lstr_rit = Message.PowerObjectParm
if isValid( lstr_rit ) then
	li_size = UpperBound(lstr_rit.s_identifica)
	for  li_counter = 1 to li_size
		ls_colname = lstr_rit.s_identifica[li_counter]
		ls_colval = string(lstr_rit.l_identifica[li_counter])
		ls_filter = ls_filter + " AND " + ls_colname + " = " + ls_colval
	next
	ls_filter = Mid(ls_filter,5)
	
	
	
	
	
		
		Retrieve()
		ll_nr = rowcount()
		
		if ll_nr>0 then
			selectrow(1,true)
		end if
		ll_row = Find( ls_filter, 1, RowCount( ))
		if ll_row >1 then
			ScrollToRow(ll_row)
		end if
	
end if

this.post SetFocus()

end event

event ue_append;call super::ue_append;is_list.s_modo = modo_inserisci
OpenWithParm(iw_support, is_list, is_resp_window)
if UpperBound(is_list.l_identifica) > 0 then
	is_list.l_identifica[1] = 0
end if
TriggerEvent("ue_retrieve")
end event

event rowfocuschanged;call super::rowfocuschanged;SelectRow(0,FALSE)
SelectRow(currentrow, TRUE)
end event

event getfocus;call super::getfocus;SelectRow(GetRow(), TRUE)
m_app_frame.m_modifica.m_salva.Disable()
m_app_frame.m_modifica.m_aggiungiincoda.Disable()
//m_app_frame.m_modifica.m_cancellacriteri.Disable()
m_app_frame.m_modifica.m_ricerca.ToolBarItemText = "Visualizza"
end event

event ue_delete;call super::ue_delete;

long	ll_sbagli

ll_sbagli = Event ue_core_update (0,0)
ll_sbagli = Event ue_commit(ll_sbagli)

SelectRow(GetRow(), TRUE)
end event

event losefocus;call super::losefocus;m_app_frame.m_modifica.m_salva.Enable()
m_app_frame.m_modifica.m_aggiungiincoda.Enable()
//m_app_frame.m_modifica.m_cancellacriteri.Enable()
m_app_frame.m_modifica.m_ricerca.ToolBarItemText = "Ricerca"
end event

event ue_key;


string			ls_column, ls_style
w_data_main		lw_win
u_dw_main		lu_dw

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
	case KeyF12!
		if (keyFlags=0) then
			lw_win = u_freddie.iw_current
			lu_dw = lw_win.idw_master
			lu_dw.triggerevent("ue_update")
		end if
		if (keyFlags=3) then
			lw_win = u_freddie.iw_current
			lw_win.trigger event key (KeyF12!,3)
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

