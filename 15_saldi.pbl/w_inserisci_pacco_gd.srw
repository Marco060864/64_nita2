forward
global type w_inserisci_pacco_gd from w_np_single_data
end type
end forward

global type w_inserisci_pacco_gd from w_np_single_data
integer width = 2242
integer height = 1664
end type
global w_inserisci_pacco_gd w_inserisci_pacco_gd

on w_inserisci_pacco_gd.create
call super::create
end on

on w_inserisci_pacco_gd.destroy
call super::destroy
end on

type p_msg_log from w_np_single_data`p_msg_log within w_inserisci_pacco_gd
end type

type p_crescente from w_np_single_data`p_crescente within w_inserisci_pacco_gd
end type

type p_decrescente from w_np_single_data`p_decrescente within w_inserisci_pacco_gd
end type

type dw_single from w_np_single_data`dw_single within w_inserisci_pacco_gd
integer x = 26
integer y = 29
integer width = 2107
integer height = 1459
string dataobject = "d_pacco_per_data"
end type

event dw_single::itemchanged;call super::itemchanged;string ls_tipo_pacco

if dwo.name='codice' then
	ls_tipo_pacco=left(data, 3)
	if ls_tipo_pacco="801" then setitem(row, "descrizione", "Non Urgente")
	if ls_tipo_pacco="803" then setitem(row, "descrizione", "Urgente per Data")
	if ls_tipo_pacco="802" then setitem(row, "descrizione", "Urgente Cliente Lista")
	if ls_tipo_pacco="804" then setitem(row, "descrizione", "Urgententissima")
end if
end event

