forward
global type w_sog_comm_stp from w_pop
end type
type cb_stampa from commandbutton within w_sog_comm_stp
end type
end forward

global type w_sog_comm_stp from w_pop
integer width = 2185
integer height = 764
cb_stampa cb_stampa
end type
global w_sog_comm_stp w_sog_comm_stp

on w_sog_comm_stp.create
int iCurrent
call super::create
this.cb_stampa=create cb_stampa
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_stampa
end on

on w_sog_comm_stp.destroy
call super::destroy
destroy(this.cb_stampa)
end on

event open;call super::open;dw_1.insertrow(1)
end event

type dw_1 from w_pop`dw_1 within w_sog_comm_stp
integer width = 1970
integer height = 400
string dataobject = "d_scheda_sog_comm_rpt"
end type

type cb_stampa from commandbutton within w_sog_comm_stp
integer x = 1600
integer y = 488
integer width = 402
integer height = 112
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Stampa"
end type

event clicked;s_param_articoli str_param


dw_1.accepttext()
str_param.da_cod_art=dw_1.getitemstring(1, "da_sogg_cod")
str_param.da_sog_comm=dw_1.getitemstring(1,"da_sogg_des")
str_param.a_cod_art=dw_1.getitemstring(1,"a_sogg_cod")
str_param.a_sog_comm=dw_1.getitemstring(1,"a_sogg_des")
str_param.legato_fino=dw_1.getitemstring(1,"solo_c_f_v")


openwithparm(w_sog_comm_con_id, str_param)
end event

