forward
global type w_mov_magazzino_lt from w_list_main
end type
end forward

global type w_mov_magazzino_lt from w_list_main
boolean TitleBar=true
string Title="Movimenti Semplificati"
end type
global w_mov_magazzino_lt w_mov_magazzino_lt

event open;call super::open;il_HelpTopic = 53
ias_key_name[1] = "id_documento"

end event

on w_mov_magazzino_lt.create
call w_list_main::create
end on

on w_mov_magazzino_lt.destroy
call w_list_main::destroy
end on

type p_crescente from w_list_main`p_crescente within w_mov_magazzino_lt
boolean BringToTop=true
end type

type p_decrescente from w_list_main`p_decrescente within w_mov_magazzino_lt
boolean BringToTop=true
end type

type dw_list from w_list_main`dw_list within w_mov_magazzino_lt
string DataObject="d_documento_lt"
end type

event dw_list::ue_init;call super::ue_init;is_title = "Movimenti Semplificati"
is_resp_window = "w_documento_ordine_cx"
end event

event dw_list::ue_retrieve;

string ls_Filtro, ls_Parametro

ls_Parametro = THIS.is_list.s_win_parametri
if IsNull(ls_parametro) then ls_parametro = ""

Parent.Title = "Movimenti Semplificati"
ls_filtro = "registro.tipo_registro = 'GV' OR registro.tipo_registro = 'GA'"
is_resp_window = "w_mov_magazzino_cx"

iu_scan.f_reset_cur_as_ini()
if ls_filtro <> "" then
	iu_scan.f_add_where_condition(ls_filtro)
end if
THIS.object.datawindow.table.select = iu_scan.f_getcurrent()
Retrieve()

end event

