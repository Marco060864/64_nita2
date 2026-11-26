forward
global type w_stampa_agenti_gd from w_stampa_bilancio2_gd
end type
end forward

global type w_stampa_agenti_gd from w_stampa_bilancio2_gd
int Width=3754
int Height=1929
end type
global w_stampa_agenti_gd w_stampa_agenti_gd

on w_stampa_agenti_gd.create
call w_stampa_bilancio2_gd::create
end on

on w_stampa_agenti_gd.destroy
call w_stampa_bilancio2_gd::destroy
end on

event open;string ls_da_agente,ls_a_agente
sel_agente str_param
str_param=message.powerobjectparm
ls_da_agente=str_param.da_agente
ls_a_agente=str_param.a_agente


dw_1.settransobject(sqlca)
dw_1.retrieve(ls_da_agente,ls_a_agente)
dw_1.Object.DataWindow.Print.Preview='YES'
event post ue_post_open()
end event

event ue_post_open;dw_1.Height=(this.Height) - 272


end event

type dw_1 from w_stampa_bilancio2_gd`dw_1 within w_stampa_agenti_gd
int Height=1673
string DataObject="d_stampa_ec_agenti"
boolean HScrollBar=true
end type

