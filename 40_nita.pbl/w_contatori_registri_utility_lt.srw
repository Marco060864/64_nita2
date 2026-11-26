forward
global type w_contatori_registri_utility_lt from w_np_single_data
end type
end forward

global type w_contatori_registri_utility_lt from w_np_single_data
WindowType WindowType=response!
boolean TitleBar=true
string Title="Dettaglio Stampa Registro"
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
end type
global w_contatori_registri_utility_lt w_contatori_registri_utility_lt

on w_contatori_registri_utility_lt.create
call w_np_single_data::create
end on

on w_contatori_registri_utility_lt.destroy
call w_np_single_data::destroy
end on

event open;idw_master = dw_single
is_wintype = "W_NP_SINGLE_DATA"
this.y = 100
string ls_param,ls_tipologia, ls_id_attivita, ls_registro, ls_param2
integer li_pos,li_lung_parola,li_id_attivita, li_registro, li_pos2, li_pos1

ls_param=message.stringparm
li_pos=pos(ls_param,'-')
if li_pos>0 then
	ls_id_attivita=left(ls_param, li_pos - 1)
	ls_param=right(ls_param, len(ls_param) - li_pos)
	li_pos=pos(ls_param,'-')
	ls_tipologia=left(ls_param, li_pos - 1)
	ls_param=right(ls_param, len(ls_param) - li_pos)
	ls_registro=ls_param
else
	return
end if

li_id_attivita=long(ls_id_attivita)
li_registro=long(ls_registro)


dw_single.settransobject(sqlca)
dw_single.retrieve(li_id_attivita,ls_tipologia,li_registro)

end event

event ue_retrieve;
end event

event ue_insert;
end event

event ue_delete;call super::ue_delete;
end event

type p_crescente from w_np_single_data`p_crescente within w_contatori_registri_utility_lt
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_contatori_registri_utility_lt
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_contatori_registri_utility_lt
string DataObject="d_contatori_registri_utility_lt"
end type

event dw_single::ue_retrieve;
end event

event dw_single::ue_insert;
end event

