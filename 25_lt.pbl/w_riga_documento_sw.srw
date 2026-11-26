forward
global type w_riga_documento_sw from w_search_main
end type
end forward

global type w_riga_documento_sw from w_search_main
boolean TitleBar=true
string Title="Ricerca Documento"
end type
global w_riga_documento_sw w_riga_documento_sw

on w_riga_documento_sw.create
call w_search_main::create
end on

on w_riga_documento_sw.destroy
call w_search_main::destroy
end on

event open;call super::open;cb_modi.visible = FALSE
cb_nuovo.visible = FALSE
dw_lista.Object.cc_descrizione.width= 0
dw_lista.Object.c_tipo_registro.width= 0

end event

type dw_lista from w_search_main`dw_lista within w_riga_documento_sw
string DataObject="d_riga_documento_descr_lt"
end type

event dw_lista::ue_init;call super::ue_init;
end event

event dw_lista::ue_return_values;call super::ue_return_values;is_ricpar.s_main_value = THIS.uf_get_colval("cc_descrizione")
is_ricpar.s_id_seg_value[1] = THIS.uf_get_colval("riga_documento_id_riga_documento")

is_ricpar.s_ausil_value[1] = String(THIS.GetItemNumber(GetRow(),"riga_documento_num_riga"))



end event

