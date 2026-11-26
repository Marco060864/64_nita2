forward
global type w_st_peso_netto_lordo from w_selezione_stampa
end type
end forward

global type w_st_peso_netto_lordo from w_selezione_stampa
integer x = 2999
integer width = 1056
integer height = 584
boolean resizable = false
end type
global w_st_peso_netto_lordo w_st_peso_netto_lordo

on w_st_peso_netto_lordo.create
call super::create
end on

on w_st_peso_netto_lordo.destroy
call super::destroy
end on

event open;call super::open;date ldt_da_data


ldt_da_data=date("01/"+string(month(today()))+"/"+string(year(today())))

dw_1.setitem(1, "da_data", ldt_da_data)


end event

type cb_1 from w_selezione_stampa`cb_1 within w_st_peso_netto_lordo
integer x = 64
integer y = 332
end type

type cb_stampa from w_selezione_stampa`cb_stampa within w_st_peso_netto_lordo
integer x = 567
integer y = 332
end type

event cb_stampa::clicked;call super::clicked;s_date_e_sog s_date

dw_1.accepttext()
s_date.da_data=dw_1.getitemdate(1, "da_data")
s_date.a_data=dw_1.getitemdate(1, "a_data")
openwithparm(w_netto_lordo, s_date)

end event

type dw_1 from w_selezione_stampa`dw_1 within w_st_peso_netto_lordo
integer width = 919
integer height = 240
string dataobject = "d_da_data_a_data_bol2"
end type

