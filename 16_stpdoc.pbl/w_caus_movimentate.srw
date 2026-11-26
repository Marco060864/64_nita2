forward
global type w_caus_movimentate from w_selezione_ext
end type
end forward

global type w_caus_movimentate from w_selezione_ext
integer width = 1326
integer height = 776
boolean maxbox = false
boolean resizable = false
end type
global w_caus_movimentate w_caus_movimentate

on w_caus_movimentate.create
call super::create
end on

on w_caus_movimentate.destroy
call super::destroy
end on

event open;call super::open;date ldt_primo_del_mese
datawindowchild dwc_metallo

dw_1.getchild("metallo", dwc_metallo)

dwc_metallo.settransobject(sqlca)
dwc_metallo.retrieve()

dw_1.setitem(1, "a_data", today())
ldt_primo_del_mese=date("01/"+string(month(today()))+"/"+string(year(today())))
dw_1.setitem(1, "da_data", ldt_primo_del_mese)


end event

type cb_1 from w_selezione_ext`cb_1 within w_caus_movimentate
integer x = 82
integer y = 492
end type

type cb_ok from w_selezione_ext`cb_ok within w_caus_movimentate
integer x = 773
integer y = 492
end type

event cb_ok::clicked;call super::clicked;string ls_cod_esercizio
s_param_articoli s_par
dw_1.accepttext()

//id-articolo
s_par.da_cod_art=dw_1.getitemstring(1, "metallo")


//num_bollettina
s_par.da_sog_comm=dw_1.getitemstring(1, "tipo_sog_commerciale")


s_par.a_data=dw_1.getitemdate(1, "a_data")
s_par.da_data=dw_1.getitemdate(1, "da_data")
//num_progressivo

openwithparm(w_caus_movimentate_rpt, s_par)
end event

type dw_1 from w_selezione_ext`dw_1 within w_caus_movimentate
integer width = 1166
integer height = 376
string dataobject = "d_caus_mov_ext"
end type

event dw_1::itemfocuschanged;//
end event

