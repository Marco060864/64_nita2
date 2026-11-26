forward
global type w_documento_lt from w_list_main
end type
end forward

global type w_documento_lt from w_list_main
boolean TitleBar=true
string Title="Documenti"
end type
global w_documento_lt w_documento_lt

event open;call super::open;string ls_Parametro

ls_Parametro = dw_list.is_list.s_win_parametri
if isnull( ls_Parametro) then ls_Parametro = ""

CHOOSE CASE ls_Parametro

	CASE "P"
		il_HelpTopic = 52
	CASE "O"
		il_HelpTopic = 51
	CASE "D"
		il_HelpTopic = 48
	CASE "F"
		il_HelpTopic = 49
	CASE "L"			
		il_HelpTopic = 50
	CASE "G"
		il_HelpTopic = 50
	CASE "I"
		il_HelpTopic = 50
	CASE ""
		il_HelpTopic = 50
		
END CHOOSE

ias_key_name[1] = "id_documento"

end event

on w_documento_lt.create
call w_list_main::create
end on

on w_documento_lt.destroy
call w_list_main::destroy
end on

type p_crescente from w_list_main`p_crescente within w_documento_lt
boolean BringToTop=true
end type

type p_decrescente from w_list_main`p_decrescente within w_documento_lt
boolean BringToTop=true
end type

type dw_list from w_list_main`dw_list within w_documento_lt
string DataObject="d_documento_lt"
BorderStyle BorderStyle=StyleLowered!
end type

event dw_list::ue_init;call super::ue_init;is_title = "Documenti"
is_resp_window = "w_documento_ordine_cx"
end event

event dw_list::ue_retrieve;

string ls_Filtro, ls_Parametro

ls_Parametro = THIS.is_list.s_win_parametri
if isnull(ls_parametro) then ls_parametro = ""


CHOOSE CASE ls_Parametro

	CASE "P"
		Parent.Title = "Preventivi"
		ls_filtro = "registro.tipo_registro = 'PV' OR registro.tipo_registro = 'PA'"
		is_resp_window = "w_documento_ordine_cx"
	CASE "O"
		Parent.Title = "Ordini"
		ls_filtro = "registro.tipo_registro = 'OA' OR registro.tipo_registro = 'OV'"
		is_resp_window = "w_documento_ordine_cx"
	CASE "D"
		Parent.Title = "Bolle"
		ls_filtro = "registro.tipo_registro = 'DA' OR registro.tipo_registro = 'DV'"
		is_resp_window = "w_documento_ordine_cx"
	CASE "F"
		Parent.Title = "Fatture"
		ls_filtro = "registro.tipo_registro = 'IA' OR registro.tipo_registro = 'IV'"
		is_resp_window = "w_documento_ordine_cx"
	CASE "L"			
		Parent.Title = "Liste di Prelievo"
		ls_filtro = "registro.tipo_registro = 'LA' OR registro.tipo_registro = 'LV'"
		is_resp_window = ""
	CASE "G"
		Parent.Title = "Generico"
		ls_filtro = "registro.tipo_registro = 'GA' OR registro.tipo_registro = 'GV'"	
		is_resp_window = ""
	CASE "I"
		Parent.Title = "Generico"
		ls_filtro = "registro.tipo_registro = 'IA' OR registro.tipo_registro = 'IV'"	
		is_resp_window = ""
	CASE ""
		Parent.Title = "Documenti"
		ls_filtro = ""	
		is_resp_window = "w_documento_ordine_cx"
	CASE ELSE
		Parent.Title = "PARAMETRO NON VALIDO! CONTROLLARE LA CHIAMATA!"
END CHOOSE

iu_scan.f_reset_cur_as_ini()
if ls_filtro <> "" then
	iu_scan.f_add_where_condition(ls_filtro)
end if
THIS.object.datawindow.table.select = iu_scan.f_getcurrent()
Retrieve()

end event

