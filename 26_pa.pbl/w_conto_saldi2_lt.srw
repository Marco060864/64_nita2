forward
global type w_conto_saldi2_lt from w_list_main
end type
end forward

global type w_conto_saldi2_lt from w_list_main
int X=430
int Y=425
int Width=2826
boolean TitleBar=true
string Title="Saldi dei Conti per Esercizio"
end type
global w_conto_saldi2_lt w_conto_saldi2_lt

on w_conto_saldi2_lt.create
call w_list_main::create
end on

on w_conto_saldi2_lt.destroy
call w_list_main::destroy
end on

event open;call super::open;il_HelpTopic = 31

ias_key_name[1] = "id_conto"

end event

type p_crescente from w_list_main`p_crescente within w_conto_saldi2_lt
boolean BringToTop=true
end type

type p_decrescente from w_list_main`p_decrescente within w_conto_saldi2_lt
boolean BringToTop=true
end type

type dw_list from w_list_main`dw_list within w_conto_saldi2_lt
int Width=2707
string DataObject="d_conto_saldi2_lt"
end type

event dw_list::ue_init;call super::ue_init;is_title = "dw_conto_saldi2_lt"
is_resp_window = "w_conto_saldi2_cx"

end event

event dw_list::doubleclicked;is_list.s_win_parametri = "id_esercizio =" + string(GetItemNumber(GetRow(),"id_esercizio"))
CALL super::doubleclicked


end event

event dw_list::retrieveend;call super::retrieveend;long ll_row

ll_row = GetRow()
if ll_row > 0 then Parent.Title = "Saldi dei Conti - Esercizio: " + GetItemString(ll_row,"esercizio_codice")
end event

