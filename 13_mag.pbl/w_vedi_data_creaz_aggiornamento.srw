forward
global type w_vedi_data_creaz_aggiornamento from w_semplice_gd
end type
end forward

global type w_vedi_data_creaz_aggiornamento from w_semplice_gd
integer width = 4576
integer height = 2264
boolean maxbox = false
boolean resizable = false
windowtype windowtype = popup!
end type
global w_vedi_data_creaz_aggiornamento w_vedi_data_creaz_aggiornamento

on w_vedi_data_creaz_aggiornamento.create
call super::create
end on

on w_vedi_data_creaz_aggiornamento.destroy
call super::destroy
end on

event open;s_array s_utente

s_utente=message.powerobjectparm
dw_1.settransobject(sqlca)
dw_1.retrieve(s_utente.ll_id_doc[1],s_utente.ll_id_doc[2] )
end event

type cb_stampa from w_semplice_gd`cb_stampa within w_vedi_data_creaz_aggiornamento
end type

type cb_ricerca from w_semplice_gd`cb_ricerca within w_vedi_data_creaz_aggiornamento
end type

type cb_primo from w_semplice_gd`cb_primo within w_vedi_data_creaz_aggiornamento
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_vedi_data_creaz_aggiornamento
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_vedi_data_creaz_aggiornamento
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_vedi_data_creaz_aggiornamento
end type

type dw_1 from w_semplice_gd`dw_1 within w_vedi_data_creaz_aggiornamento
integer width = 4448
string dataobject = "d_vedi_agg_riga_doc"
end type

type cb_inserisci from w_semplice_gd`cb_inserisci within w_vedi_data_creaz_aggiornamento
end type

type cb_salva from w_semplice_gd`cb_salva within w_vedi_data_creaz_aggiornamento
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_vedi_data_creaz_aggiornamento
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_vedi_data_creaz_aggiornamento
end type

type cb_ok from w_semplice_gd`cb_ok within w_vedi_data_creaz_aggiornamento
end type

