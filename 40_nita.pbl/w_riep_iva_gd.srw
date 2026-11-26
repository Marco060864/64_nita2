forward
global type w_riep_iva_gd from w_np_single_data
end type
end forward

global type w_riep_iva_gd from w_np_single_data
int X=197
int Y=653
int Width=3251
int Height=865
boolean TitleBar=true
string Title="Riepilogo IVA"
end type
global w_riep_iva_gd w_riep_iva_gd

on w_riep_iva_gd.create
call w_np_single_data::create
end on

on w_riep_iva_gd.destroy
call w_np_single_data::destroy
end on

event ue_insert;
end event

type p_crescente from w_np_single_data`p_crescente within w_riep_iva_gd
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_riep_iva_gd
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_riep_iva_gd
int Width=3127
string DataObject="d_riep_iva_gd"
end type

event dw_single::ue_init;call super::ue_init;is_title = "Riepilogo IVA"
end event

event dw_single::ue_set_search;call super::ue_set_search;
CHOOSE CASE as_nomecol
		
	CASE "id_attivita_des"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_attivita_gd"
		is_ricpar.s_titolo_finestra = "Attività Svolte"
		
END CHOOSE

end event

event dw_single::ue_insert;
end event

