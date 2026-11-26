forward
global type w_stp_mov_cespite_rpt from w_stampa_001
end type
end forward

global type w_stp_mov_cespite_rpt from w_stampa_001
boolean TitleBar=true
string Title="Stampa Movimenti"
long BackColor=78748035
end type
global w_stp_mov_cespite_rpt w_stp_mov_cespite_rpt

type variables
s_cespiti ls_par
long il_id_dich_per
end variables

event open;
ls_par=Message.PowerObjectParm	

dw_1.settransobject(sqlca)
dw_1.retrieve(ls_par.da_data,ls_par.a_data,ls_par.da_cespite,ls_par.a_cespite,ls_par.da_cat,ls_par.a_cat) 
end event

on w_stp_mov_cespite_rpt.create
call super::create
end on

on w_stp_mov_cespite_rpt.destroy
call super::destroy
end on

type dw_1 from w_stampa_001`dw_1 within w_stp_mov_cespite_rpt
string DataObject="d_mov_cespite_rpt"
end type

event cb_stampa::clicked;printsetup()
dw_1.print()


end event

