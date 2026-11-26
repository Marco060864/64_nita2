forward
global type w_trova_bol_modificata_non_derivata from w_semplice_gd
end type
end forward

global type w_trova_bol_modificata_non_derivata from w_semplice_gd
integer width = 2341
integer height = 1548
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
end type
global w_trova_bol_modificata_non_derivata w_trova_bol_modificata_non_derivata

on w_trova_bol_modificata_non_derivata.create
call super::create
end on

on w_trova_bol_modificata_non_derivata.destroy
call super::destroy
end on

event open;s_date_estr_cc s_date
if isvalid(message.powerobjectparm) then
	s_date=message.powerobjectparm
	dw_1.settransobject(sqlca)
	dw_1.retrieve(s_date.da_data, s_date.a_data)
end if
end event

type cb_stampa from w_semplice_gd`cb_stampa within w_trova_bol_modificata_non_derivata
end type

type cb_ricerca from w_semplice_gd`cb_ricerca within w_trova_bol_modificata_non_derivata
end type

type cb_primo from w_semplice_gd`cb_primo within w_trova_bol_modificata_non_derivata
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_trova_bol_modificata_non_derivata
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_trova_bol_modificata_non_derivata
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_trova_bol_modificata_non_derivata
end type

type dw_1 from w_semplice_gd`dw_1 within w_trova_bol_modificata_non_derivata
integer width = 2263
string title = "Elenco Bollettine Modificate ma NON derivate"
string dataobject = "d_trova_bol_modificata_non_derivata"
end type

event dw_1::sqlpreview;//
end event

type cb_inserisci from w_semplice_gd`cb_inserisci within w_trova_bol_modificata_non_derivata
end type

type cb_salva from w_semplice_gd`cb_salva within w_trova_bol_modificata_non_derivata
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_trova_bol_modificata_non_derivata
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_trova_bol_modificata_non_derivata
end type

type cb_ok from w_semplice_gd`cb_ok within w_trova_bol_modificata_non_derivata
end type

