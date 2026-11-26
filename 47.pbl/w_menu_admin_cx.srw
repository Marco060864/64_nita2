forward
global type w_menu_admin_cx from w_p_data
end type
type dw_menu_admin_ff from u_dw_master_main within w_menu_admin_cx
end type
type dw_voce_menu_gd from u_dw_master_main within w_menu_admin_cx
end type
type dw_voce_menu_ric_ff from u_dw_master_main within w_menu_admin_cx
end type
type p_arrow from picture within w_menu_admin_cx
end type
end forward

global type w_menu_admin_cx from w_p_data
int Width=2977
int Height=1405
dw_menu_admin_ff dw_menu_admin_ff
dw_voce_menu_gd dw_voce_menu_gd
dw_voce_menu_ric_ff dw_voce_menu_ric_ff
p_arrow p_arrow
end type
global w_menu_admin_cx w_menu_admin_cx

type variables

end variables

on w_menu_admin_cx.create
int iCurrent
call w_p_data::create
this.dw_menu_admin_ff=create dw_menu_admin_ff
this.dw_voce_menu_gd=create dw_voce_menu_gd
this.dw_voce_menu_ric_ff=create dw_voce_menu_ric_ff
this.p_arrow=create p_arrow
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=dw_menu_admin_ff
this.Control[iCurrent+2]=dw_voce_menu_gd
this.Control[iCurrent+3]=dw_voce_menu_ric_ff
this.Control[iCurrent+4]=p_arrow
end on

on w_menu_admin_cx.destroy
call w_p_data::destroy
destroy(this.dw_menu_admin_ff)
destroy(this.dw_voce_menu_gd)
destroy(this.dw_voce_menu_ric_ff)
destroy(this.p_arrow)
end on

event open;call super::open;idw_master = dw_menu_admin_ff
idw_master.is_list = Message.PowerObjectParm

idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_sql_ident[1] = "menu.id_menu"

u_freddie.istr_menu.sl_start = -100

end event

type p_crescente from w_p_data`p_crescente within w_menu_admin_cx
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_menu_admin_cx
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_menu_admin_cx
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_menu_admin_cx
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_menu_admin_cx
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_menu_admin_cx
int X=2035
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_menu_admin_cx
int X=2332
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_menu_admin_cx
int X=2629
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_menu_admin_cx
int X=2286
int Y=241
int Width=183
int Height=101
int TabOrder=30
boolean Visible=false
boolean BringToTop=true
long BackColor=79741120
end type

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=19
int Y=105
int Width=147
end type

type cb_ricerca from w_p_data`cb_ricerca within w_menu_admin_cx
boolean BringToTop=true
end type

type dw_menu_admin_ff from u_dw_master_main within w_menu_admin_cx
int X=46
int Y=161
int Width=2858
int Height=301
int TabOrder=20
string DataObject="d_menu_admin_ff"
end type

event ue_init;call super::ue_init;
iudw_children[1] = dw_voce_menu_gd

end event

type dw_voce_menu_gd from u_dw_master_main within w_menu_admin_cx
int X=46
int Y=501
int Width=1121
int Height=761
int TabOrder=10
string DataObject="d_voce_menu_gd"
boolean VScrollBar=true
end type

event ue_init;call super::ue_init;
is_list.s_identifica[1] = "id_menu"

iudw_children[1] = dw_voce_menu_ric_ff

is_list.s_win_chiave[1] = "id_voci_menu"
is_list.s_win_zoom = "w_menu_admin_ric_cx"

This.SetRowFocusIndicator(p_arrow)

end event

event ue_modify;

long 				ll_row
integer 			li_size, li_counter
string 			ls_filter, ls_colname, ls_colval
s_list_main 	lstr_for_win
s_rit_wp			lstr_rit

ll_row = GetRow()
if ll_row>0 then
	if not(is_resp_window = "") OR not(is_list.s_win_zoom = "") then
	
		li_size = UpperBound(is_list.s_win_chiave)
		is_list.s_modo = modo_modifica
		for li_counter = 1 to li_size
			is_list.l_win_chiave[li_counter] = GetItemNumber( ll_row, is_list.s_win_chiave[li_counter])
		next
		li_size = UpperBound(is_list.s_par_name)
		for li_counter = 1 to li_size
			
			
			
			
		next
		lstr_for_win.s_modo = is_list.s_modo
		lstr_for_win.s_identifica = is_list.s_win_chiave
		lstr_for_win.l_identifica = is_list.l_win_chiave
		lstr_for_win.s_par_name = is_list.s_par_name
		lstr_for_win.s_par_value = is_list.s_par_value
		lstr_for_win.s_win_parametri = u_freddie.iw_current.title
		
		
		
		if is_list.s_win_zoom = "" then
			OpenWithParm(iw_support, lstr_for_win,is_resp_window)
		else
			if not ((GetItemStatus(ll_row, 0, Primary!) = New!) OR (GetItemStatus(ll_row, 0, Primary!) = NewModified!)) then
				OpenWithParm(iw_support, lstr_for_win,is_list.s_win_zoom)
			end if
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
		
		
		
		
			TriggerEvent("ue_retrieve")
			if (RowCount()>0) and (is_resp_window <> "") then
				selectrow(1,true)
			end if
			ll_row = Find( ls_filter, 1, RowCount( ))
			ScrollToRow(ll_row)
		
		
	else
		
	end if
end if


end event

event doubleclicked;
long 				ll_row
s_menu_ric		lstr_menu

ll_row = GetRow()
if GetItemStatus(ll_row, 0, Primary!) = New! Or GetItemStatus(ll_row, 0, Primary!) = NewModified! then
	idw_master.Event ue_update(0,0)
end if
Call Super::DoubleClicked

u_freddie.istr_menu = lstr_menu
u_freddie.istr_menu.sl_start = -100


end event

event ue_delete;

long				ll_row, ll_id_voci_menu, ll_figlio, ll_i
string			ls_text
s_list_main		lstr_for_win

ll_row = GetRow()

ll_id_voci_menu = GetItemNumber(ll_row, "id_voci_menu")
SELECT Max("voci_menu"."id_voci_menu") INTO :ll_figlio
  FROM "dba"."voci_menu"  
  WHERE ( "voci_menu"."id_voci_menu_padre" = :ll_id_voci_menu ) ;
if Not IsNull(ll_figlio) And ll_figlio <> 0 then
	lstr_for_win.l_identifica[1] = 0
	lstr_for_win.l_identifica[2] = ll_id_voci_menu
	OpenWithParm(w_voci_menu_ext_lt, lstr_for_win)
	lstr_for_win = Message.PowerObjectParm
	
	if lstr_for_win.l_identifica[1] < 0 then
		dw_voce_menu_gd.SetFocus()
		Return -1
	end if
end if

if ib_allow_delete and THIS.getconfirm(ici_confirm_delete) then
	if IsNull(ll_figlio) Or ll_figlio = 0 then
		
		THIS.DeleteRow(ll_row)
	else
		
		FOR ll_i =1 TO UpperBound(lstr_for_win.l_identifica)
			ll_row = This.Find("id_voci_menu = "+string(lstr_for_win.l_identifica[ll_i]), &
						1, RowCount())
			THIS.DeleteRow(ll_row)
		NEXT
	end if
end if

cb_salva.TriggerEvent("Clicked")

end event

event rowfocuschanged;call super::rowfocuschanged;

long		ll_row, ll_row_gd
window 	lw_parent


ll_row = dw_menu_admin_ff.GetRow()
ll_row_gd = dw_voce_menu_gd.GetRow()
if ll_row > 0 then
	is_title = dw_menu_admin_ff.GetItemString(ll_row, "menu_descrizione")
	if ll_row_gd = 0 then
		is_title = "Nuova Voce Menu"
	end if
end if

lw_parent = GetParent()
lw_parent.Title = is_title

end event

type dw_voce_menu_ric_ff from u_dw_master_main within w_menu_admin_cx
int X=1189
int Y=501
int Width=1724
int Height=761
int TabOrder=11
string DataObject="d_voce_menu_ric_ff"
end type

event ue_init;call super::ue_init;ib_dw_shared = TRUE
is_list.s_colonne_drop[1] = "id_oggetti"
end event

type p_arrow from picture within w_menu_admin_cx
int X=69
int Y=741
int Width=55
int Height=65
boolean Visible=false
boolean BringToTop=true
string PictureName="s:\pb\cometa\arrow.bmp"
boolean FocusRectangle=false
end type

