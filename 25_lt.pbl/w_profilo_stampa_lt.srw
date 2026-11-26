forward
global type w_profilo_stampa_lt from w_search_main
end type
end forward

global type w_profilo_stampa_lt from w_search_main
int Width=2071
boolean TitleBar=true
string Title="Ricerca Profili di Stampa"
boolean Resizable=false
end type
global w_profilo_stampa_lt w_profilo_stampa_lt

on w_profilo_stampa_lt.create
call super::create
end on

on w_profilo_stampa_lt.destroy
call super::destroy
end on

type cb_cerca from w_search_main`cb_cerca within w_profilo_stampa_lt
int X=1490
int Y=184
end type

type dw_lista from w_search_main`dw_lista within w_profilo_stampa_lt
int Width=1422
string DataObject="d_profilo_stampa_lt"
end type

event dw_lista::doubleclicked;call super::doubleclicked;
end event

event dw_lista::ue_return_values;call super::ue_return_values;long ll_ret, ll_row

ll_row=getrow()
ll_ret=dw_lista.getitemnumber(ll_row,"id_proflo_stampa")

is_ricpar.s_id_seg_value[1] = THIS.uf_get_colval("id_proflo_stampa")




end event

type sle_showsort from w_search_main`sle_showsort within w_profilo_stampa_lt
int Width=1422
end type

type cb_annulla from w_search_main`cb_annulla within w_profilo_stampa_lt
int X=1495
end type

type cb_ok from w_search_main`cb_ok within w_profilo_stampa_lt
int X=1221
end type

type sle_ricerca from w_search_main`sle_ricerca within w_profilo_stampa_lt
int Width=1056
end type

