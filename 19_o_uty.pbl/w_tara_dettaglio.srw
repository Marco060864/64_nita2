forward
global type w_tara_dettaglio from w_semplice_gd
end type
end forward

global type w_tara_dettaglio from w_semplice_gd
integer width = 2098
integer height = 1032
string title = "Dettaglio Tara"
boolean maxbox = false
windowtype windowtype = popup!
end type
global w_tara_dettaglio w_tara_dettaglio

type variables
long il_id_riga
end variables

on w_tara_dettaglio.create
call super::create
end on

on w_tara_dettaglio.destroy
call super::destroy
end on

event open;long  ll_ret


il_id_riga=message.doubleparm
dw_1.settransobject(sqlca)
ll_ret=dw_1.retrieve(il_id_riga)
if ll_ret<=0 then
	dw_1. trigger event ue_insert(0)
end if
end event

type cb_stampa from w_semplice_gd`cb_stampa within w_tara_dettaglio
integer x = 1079
integer y = 744
end type

type cb_ricerca from w_semplice_gd`cb_ricerca within w_tara_dettaglio
boolean visible = false
end type

type cb_primo from w_semplice_gd`cb_primo within w_tara_dettaglio
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_tara_dettaglio
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_tara_dettaglio
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_tara_dettaglio
end type

type dw_1 from w_semplice_gd`dw_1 within w_tara_dettaglio
integer width = 1966
integer height = 680
string dataobject = "d_tara_dettaglio"
end type

event dw_1::ue_post_insert;call super::ue_post_insert;long ll_numero

setitem(al_riga, "id_riga_documento", il_id_riga)

ll_numero=getitemnumber(1, "c_max_numero")
if isnull(ll_numero) or ll_numero<=0 then ll_numero=1
setitem(al_riga, "numero", ll_numero)

end event

type cb_inserisci from w_semplice_gd`cb_inserisci within w_tara_dettaglio
integer y = 740
end type

type cb_salva from w_semplice_gd`cb_salva within w_tara_dettaglio
integer y = 740
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_tara_dettaglio
integer y = 740
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_tara_dettaglio
integer x = 1422
integer y = 740
end type

type cb_ok from w_semplice_gd`cb_ok within w_tara_dettaglio
integer x = 1710
integer y = 740
integer width = 279
end type

