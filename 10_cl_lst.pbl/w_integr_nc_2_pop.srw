forward
global type w_integr_nc_2_pop from w_semplice_gd
end type
end forward

global type w_integr_nc_2_pop from w_semplice_gd
integer width = 2706
integer height = 544
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
end type
global w_integr_nc_2_pop w_integr_nc_2_pop

on w_integr_nc_2_pop.create
call super::create
end on

on w_integr_nc_2_pop.destroy
call super::destroy
end on

event open;long ll_id_riga

dw_1.settransobject(sqlca)

ll_id_riga=message.doubleparm

if ll_id_riga>0 then
	if dw_1.retrieve(ll_id_riga)<=0 then
		dw_1.trigger event ue_insert(1)
		dw_1.setitem(1, "id_riga_documento",ll_id_riga)
	end if
else
	close(this)
end if
end event

event ue_postopen;//
end event

type cb_stampa from w_semplice_gd`cb_stampa within w_integr_nc_2_pop
boolean visible = false
end type

type cb_ricerca from w_semplice_gd`cb_ricerca within w_integr_nc_2_pop
boolean visible = false
end type

type cb_primo from w_semplice_gd`cb_primo within w_integr_nc_2_pop
integer x = 1015
integer y = 352
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_integr_nc_2_pop
integer x = 1431
integer y = 352
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_integr_nc_2_pop
integer x = 1175
integer y = 352
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_integr_nc_2_pop
integer x = 1303
integer y = 352
end type

type dw_1 from w_semplice_gd`dw_1 within w_integr_nc_2_pop
integer width = 2610
integer height = 280
string dataobject = "d_nota_cred_agg_2_gd"
boolean vscrollbar = false
boolean livescroll = false
end type

type cb_inserisci from w_semplice_gd`cb_inserisci within w_integr_nc_2_pop
integer x = 96
integer y = 336
end type

type cb_salva from w_semplice_gd`cb_salva within w_integr_nc_2_pop
integer x = 379
integer y = 336
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_integr_nc_2_pop
integer x = 667
integer y = 336
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_integr_nc_2_pop
integer x = 1769
integer y = 340
end type

type cb_ok from w_semplice_gd`cb_ok within w_integr_nc_2_pop
integer x = 2062
integer y = 340
end type

