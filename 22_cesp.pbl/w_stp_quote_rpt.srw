forward
global type w_stp_quote_rpt from w_stampa_001
end type
end forward

global type w_stp_quote_rpt from w_stampa_001
end type
global w_stp_quote_rpt w_stp_quote_rpt

type variables
s_cespiti ls_par
long il_id_dich_per
end variables

event open;dw_1.settransobject(sqlca)
dw_1.retrieve() 
end event

on w_stp_quote_rpt.create
call super::create
end on

on w_stp_quote_rpt.destroy
call super::destroy
end on

type dw_1 from w_stampa_001`dw_1 within w_stp_quote_rpt
string DataObject="d_prev_quote_rpt"
end type

event cb_stampa::clicked;printsetup()
dw_1.print()


end event

