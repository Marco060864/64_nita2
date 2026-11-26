forward
global type w_registro_ca_sw from w_search_main
end type
end forward

global type w_registro_ca_sw from w_search_main
end type
global w_registro_ca_sw w_registro_ca_sw

on w_registro_ca_sw.create
call w_search_main::create
end on

on w_registro_ca_sw.destroy
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

type dw_lista from w_search_main`dw_lista within w_registro_ca_sw
string DataObject="d_registro_ca_lt"
end type

event dw_lista::ue_return_values;call super::ue_return_values;is_ricpar.s_id_seg_value[1] = THIS.uf_get_colval("registro_id_registro")
CHOOSE CASE is_ricpar.s_filter_name
	CASE "tipo_registro"
		is_ricpar.s_main_value = THIS.uf_get_colval("tipo_registro")
		is_ricpar.s_ausil_value[1] = THIS.uf_get_colval("registro_descrizione")
		is_ricpar.s_id_seg_value[1] = THIS.uf_get_colval("registro_id_registro")
	CASE "registro_descrizione"
		is_ricpar.s_main_value = THIS.uf_get_colval("registro_descrizione")
		is_ricpar.s_ausil_value[1] = THIS.uf_get_colval("tipo_registro")
		is_ricpar.s_id_seg_value[1] = THIS.uf_get_colval("registro_id_registro")
END CHOOSE

end event

event dw_lista::ue_init;call super::ue_init;is_list.s_win_chiave[1] = "registro_id_registro"
end event

