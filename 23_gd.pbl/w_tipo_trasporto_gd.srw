forward
global type w_tipo_trasporto_gd from w_np_single_data
end type
end forward

global type w_tipo_trasporto_gd from w_np_single_data
int Width=2606
boolean TitleBar=true
string Title="Tipi di Trasporto"
end type
global w_tipo_trasporto_gd w_tipo_trasporto_gd

on w_tipo_trasporto_gd.create
call w_np_single_data::create
end on

on w_tipo_trasporto_gd.destroy
call w_np_single_data::destroy
end on

event open;call super::open;il_HelpTopic = 111
end event

type p_crescente from w_np_single_data`p_crescente within w_tipo_trasporto_gd
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_tipo_trasporto_gd
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_tipo_trasporto_gd
int Width=2469
string DataObject="d_tipo_trasporto_gd"
end type

event dw_single::ue_init;call super::ue_init;is_title = "Tipi di Trasporto"
end event

event dw_single::clicked;call super::clicked;string ls_spesa, ls_int_cons
long ll_count, ll_len
string 			ls_nomedwo, ls_tipodwo, la_array[]
s_list_main lstr_list
w_search_main	lw_sm

ls_nomedwo = dwo.name
ls_tipodwo = dwo.type
if ls_nomedwo="spese_gestite_msw" AND row > 0 then
	AcceptText()
	lstr_list.s_win_parametri = GetItemString(row,"spese_gestite")
	OpenWithParm(w_spesa_scelta_lt,lstr_list)
	u_freddie.sp_pop(la_array)
	SetItem(row,"spese_gestite", la_array[1])
	ScrollToRow(row)
	u_freddie.sp_drop()
	
end if

end event

event dw_single::ue_key;call super::ue_key;string ls_spesa, ls_int_cons
long ll_count, ll_len, ll_row
string 			ls_nomedwo, ls_tipodwo, la_array[]
s_list_main lstr_list


ll_row = GetRow()

if key=KeyF4! and ll_row > 0 AND GetColumnName( ) = "spese_gestite" then
	AcceptText()
	lstr_list.s_win_parametri = GetItemString(ll_row,"spese_gestite")
	OpenWithParm(w_spesa_scelta_lt,lstr_list)
	u_freddie.sp_pop(la_array)
	SetItem(ll_row,"spese_gestite", la_array[1])
	u_freddie.sp_drop()
	
end if
end event

