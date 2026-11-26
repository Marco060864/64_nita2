forward
global type w_par_automatiche_st from w_stampa_001
end type
end forward

global type w_par_automatiche_st from w_stampa_001
end type
global w_par_automatiche_st w_par_automatiche_st

event open;call super::open;s_stampa s_st

s_st=message.powerobjectparm

dw_1.settransobject(sqlca)
dw_1.retrieve(s_st.data_inizio, s_st.data_fine)
end event

on w_par_automatiche_st.create
call super::create
end on

on w_par_automatiche_st.destroy
call super::destroy
end on

type dw_1 from w_stampa_001`dw_1 within w_par_automatiche_st
string dataobject = "d_par_automatiche_st2"
end type

type sle_pg from w_stampa_001`sle_pg within w_par_automatiche_st
end type

type st_1 from w_stampa_001`st_1 within w_par_automatiche_st
end type

type st_2 from w_stampa_001`st_2 within w_par_automatiche_st
end type

type sle_copie from w_stampa_001`sle_copie within w_par_automatiche_st
end type

type sle_zoom from w_stampa_001`sle_zoom within w_par_automatiche_st
end type

type cb_salva_su_file from w_stampa_001`cb_salva_su_file within w_par_automatiche_st
end type

type cb_7 from w_stampa_001`cb_7 within w_par_automatiche_st
end type

type cb_6 from w_stampa_001`cb_6 within w_par_automatiche_st
end type

type cb_imp_st from w_stampa_001`cb_imp_st within w_par_automatiche_st
end type

type cb_stampa from w_stampa_001`cb_stampa within w_par_automatiche_st
end type

type cb_preview from w_stampa_001`cb_preview within w_par_automatiche_st
end type

type cb_pg_dopo from w_stampa_001`cb_pg_dopo within w_par_automatiche_st
end type

type cb_pg_prima from w_stampa_001`cb_pg_prima within w_par_automatiche_st
end type

type cb_1 from w_stampa_001`cb_1 within w_par_automatiche_st
end type

