forward
global type w_da_data_a_data_con_sog_com_st from w_selezione_stampa
end type
end forward

global type w_da_data_a_data_con_sog_com_st from w_selezione_stampa
integer width = 1746
integer height = 588
end type
global w_da_data_a_data_con_sog_com_st w_da_data_a_data_con_sog_com_st

on w_da_data_a_data_con_sog_com_st.create
call super::create
end on

on w_da_data_a_data_con_sog_com_st.destroy
call super::destroy
end on

event open;call super::open;datawindowchild dwc_dati

dw_1.getchild("id_sog_com", dwc_dati)
dwc_dati.settransobject(sqlca)
dwc_dati.retrieve()
end event

type cb_1 from w_selezione_stampa`cb_1 within w_da_data_a_data_con_sog_com_st
integer x = 69
integer y = 308
end type

type cb_stampa from w_selezione_stampa`cb_stampa within w_da_data_a_data_con_sog_com_st
integer x = 1248
integer y = 304
end type

event cb_stampa::clicked;call super::clicked;s_date_e_sog s_date

dw_1.accepttext()
s_date.da_data=dw_1.getitemdate(1, "da_data")
s_date.a_data=dw_1.getitemdate(1, "a_data")
s_date.id_sog_com=dw_1.getitemnumber(1, "id_sog_com")

openwithparm(w_trova_galvanica_10_st, s_date)
end event

type dw_1 from w_selezione_stampa`dw_1 within w_da_data_a_data_con_sog_com_st
integer width = 1591
integer height = 224
string dataobject = "da_data_a_data_con_sog_com_st"
end type

