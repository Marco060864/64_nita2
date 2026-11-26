forward
global type w_sog_commerciale_lt from w_list_main
end type
end forward

global type w_sog_commerciale_lt from w_list_main
int X=430
int Y=425
int Width=2803
int Height=1057
boolean TitleBar=true
string Title="Soggetti Commerciali"
end type
global w_sog_commerciale_lt w_sog_commerciale_lt

event open;call super::open;

string param 
param = dw_list.is_list.s_win_parametri
if isnull( param ) then param = ""


CHOOSE CASE param

	CASE "C"
		il_HelpTopic = 13
	CASE "F"		
		il_HelpTopic = 14
	CASE "A"		
		il_HelpTopic = 15
	CASE "V"		
		il_HelpTopic = 16
	CASE "P"				
		il_HelpTopic = 17
	CASE ""
		il_HelpTopic = 12
		
END CHOOSE


ias_key_name[1] = "id_sog_commerciale"
end event

on w_sog_commerciale_lt.create
call w_list_main::create
end on

on w_sog_commerciale_lt.destroy
call w_list_main::destroy
end on

type p_crescente from w_list_main`p_crescente within w_sog_commerciale_lt
boolean BringToTop=true
end type

type p_decrescente from w_list_main`p_decrescente within w_sog_commerciale_lt
boolean BringToTop=true
end type

type dw_list from w_list_main`dw_list within w_sog_commerciale_lt
int Width=2675
string DataObject="d_sog_commerciale_lt"
end type

event dw_list::ue_init;call super::ue_init;is_title = "Soggetti Commerciali"
is_resp_window = "w_sog_commerciale_cx"
end event

event dw_list::ue_retrieve;

string ls_Filtro, ls_Parametro

ls_Parametro = THIS.is_list.s_win_parametri
if isnull(ls_parametro) then ls_parametro = ""
if ls_parametro <> "" then 
	ls_filtro = "sog_commerciale.tipo = '" + ls_parametro + "'"
else
	ls_filtro = ""
end if

CHOOSE CASE ls_Parametro

	CASE "C"
		Parent.Title = "Clienti"
	CASE "F"		
		Parent.Title = "Fornitori"
	CASE "A"		
		Parent.Title = "Agenti"
	CASE "V"		
		Parent.Title = "Vettori"
	CASE "P"				
		Parent.Title = "Clienti Potenziali"
	CASE ""
		Parent.Title = "Soggetti Commerciali"
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

