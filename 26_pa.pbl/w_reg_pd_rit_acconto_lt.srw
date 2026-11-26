forward
global type w_reg_pd_rit_acconto_lt from w_list_main
end type
end forward

global type w_reg_pd_rit_acconto_lt from w_list_main
int Width=2798
boolean TitleBar=true
string Title="Registrazioni Prima Nota per Ritenute d'Acconto"
end type
global w_reg_pd_rit_acconto_lt w_reg_pd_rit_acconto_lt

on w_reg_pd_rit_acconto_lt.create
call w_list_main::create
end on

on w_reg_pd_rit_acconto_lt.destroy
call w_list_main::destroy
end on

event open;call super::open;
il_HelpTopic = 323

ias_key_name[1] = "id_reg_pd"

end event

type p_crescente from w_list_main`p_crescente within w_reg_pd_rit_acconto_lt
boolean BringToTop=true
end type

type p_decrescente from w_list_main`p_decrescente within w_reg_pd_rit_acconto_lt
boolean BringToTop=true
end type

type dw_list from w_list_main`dw_list within w_reg_pd_rit_acconto_lt
int Width=2675
string DataObject="d_reg_pd_rit_acconto_lt"
end type

event dw_list::ue_init;call super::ue_init;is_title = "Registrazioni Prima Nota per Ritenute d'Acconto"
is_resp_window = "w_rit_acconto_wz"
end event

event dw_list::ue_retrieve;

string ls_Filtro, ls_Parametro

ls_Parametro = "IA"

Parent.Title = "Registrazioni Prima Nota per Ritenute d'Acconto"
ls_Filtro = f_tilde_quote("registro.tipo_registro") + " = '" + ls_Parametro + "'"




iu_scan.f_reset_cur_as_ini()
if ls_filtro <> "" then
	iu_scan.f_add_where_condition(ls_filtro)
end if
THIS.object.datawindow.table.select = iu_scan.f_getcurrent()
Retrieve()

end event

event dw_list::doubleclicked;long ll_row, ll_id_reg_pd
s_list_main lstr_for_win

ll_row = GetRow()
lstr_for_win.s_modo = modo_modifica

IF ll_row > 0 THEN
	ll_id_reg_pd = GetItemNumber(ll_row, "id_reg_pd")
	lstr_for_win.l_identifica[1] = ll_id_reg_pd

	OpenWithParm(w_rit_acconto_wz, lstr_for_win)
END IF
end event

