forward
global type w_par_aperta_lt from w_list_main
end type
end forward

global type w_par_aperta_lt from w_list_main
int Width=2752
boolean TitleBar=true
string Title="Partite Aperte"
end type
global w_par_aperta_lt w_par_aperta_lt

type variables

end variables

on w_par_aperta_lt.create
call super::create
end on

on w_par_aperta_lt.destroy
call super::destroy
end on

event open;call super::open;il_HelpTopic = 30

ias_key_name[1] = "id_par_aperta"
end event

type p_crescente from w_list_main`p_crescente within w_par_aperta_lt
boolean BringToTop=true
end type

type p_decrescente from w_list_main`p_decrescente within w_par_aperta_lt
boolean BringToTop=true
end type

type dw_list from w_list_main`dw_list within w_par_aperta_lt
int Width=2629
string DataObject="d_par_aperta_lt"
end type

event dw_list::ue_init;call super::ue_init;
end event

event dw_list::ue_retrieve;call super::ue_retrieve;


end event

event dw_list::doubleclicked;call super::doubleclicked;long par_ap
if row>0 then
	par_ap=dw_list.getitemnumber(row,'id_par_aperta')
	openwithparm(w_gest_par_aperta_cx,par_ap)
end if	
end event

