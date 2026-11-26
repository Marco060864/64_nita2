forward
global type w_bilancio_cee_sw from w_search_main
end type
end forward

global type w_bilancio_cee_sw from w_search_main
boolean TitleBar=true
string Title="PDC CEE"
end type
global w_bilancio_cee_sw w_bilancio_cee_sw

on w_bilancio_cee_sw.create
call w_search_main::create
end on

on w_bilancio_cee_sw.destroy
call w_search_main::destroy
end on

event key;call super::key;

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

type dw_lista from w_search_main`dw_lista within w_bilancio_cee_sw
string DataObject="d_bilancio_cee_sw"
end type

event dw_lista::ue_return_values;call super::ue_return_values;is_ricpar.s_id_seg_value[1] = uf_get_colval("id_bilancio_cee")		
is_ricpar.s_main_value = uf_get_colval("riferimento")
is_ricpar.s_ausil_value[1] = uf_get_colval("descrizione")
end event

event dw_lista::ue_init;call super::ue_init;is_list.s_win_chiave[1] = "id_bilancio_cee"
is_resp_window="w_bilancio_cee_cx"

end event

