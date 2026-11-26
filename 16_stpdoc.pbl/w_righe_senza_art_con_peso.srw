forward
global type w_righe_senza_art_con_peso from w_stampa_001
end type
type cb_aggiorna from commandbutton within w_righe_senza_art_con_peso
end type
end forward

global type w_righe_senza_art_con_peso from w_stampa_001
string title = "Mostra righe senza Articolo ma con Peso (Legato)"
cb_aggiorna cb_aggiorna
end type
global w_righe_senza_art_con_peso w_righe_senza_art_con_peso

on w_righe_senza_art_con_peso.create
int iCurrent
call super::create
this.cb_aggiorna=create cb_aggiorna
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_aggiorna
end on

on w_righe_senza_art_con_peso.destroy
call super::destroy
destroy(this.cb_aggiorna)
end on

event open;call super::open;dw_1.settransobject(sqlca)
dw_1.retrieve()
end event

type dw_1 from w_stampa_001`dw_1 within w_righe_senza_art_con_peso
string dataobject = "d_righe_senza_art_con_peso"
end type

event dw_1::doubleclicked;call super::doubleclicked;long ll_id_doc
w_orafo_documento_ordine_cx w_orafo
s_list_main s_list

if row>0 then
	s_list.s_identifica[1]="id_documento"
	s_list.s_modo=modo_modifica
	ll_id_doc=getitemnumber(row, "id_documento")
	if ll_id_doc>0 then
		s_list.l_identifica[1]=ll_id_doc
		openwithparm(w_orafo, s_list)
		
	end if
end if
end event

type sle_pg from w_stampa_001`sle_pg within w_righe_senza_art_con_peso
integer x = 1573
integer width = 388
end type

type st_1 from w_stampa_001`st_1 within w_righe_senza_art_con_peso
integer x = 1306
end type

type st_2 from w_stampa_001`st_2 within w_righe_senza_art_con_peso
end type

type sle_copie from w_stampa_001`sle_copie within w_righe_senza_art_con_peso
end type

type sle_zoom from w_stampa_001`sle_zoom within w_righe_senza_art_con_peso
integer x = 666
end type

type cb_salva_su_file from w_stampa_001`cb_salva_su_file within w_righe_senza_art_con_peso
end type

type cb_7 from w_stampa_001`cb_7 within w_righe_senza_art_con_peso
integer x = 816
end type

type cb_6 from w_stampa_001`cb_6 within w_righe_senza_art_con_peso
integer x = 549
end type

type cb_imp_st from w_stampa_001`cb_imp_st within w_righe_senza_art_con_peso
end type

type cb_stampa from w_stampa_001`cb_stampa within w_righe_senza_art_con_peso
end type

type cb_preview from w_stampa_001`cb_preview within w_righe_senza_art_con_peso
end type

type cb_pg_dopo from w_stampa_001`cb_pg_dopo within w_righe_senza_art_con_peso
end type

type cb_pg_prima from w_stampa_001`cb_pg_prima within w_righe_senza_art_con_peso
end type

type cb_1 from w_stampa_001`cb_1 within w_righe_senza_art_con_peso
end type

type cb_aggiorna from commandbutton within w_righe_senza_art_con_peso
integer x = 965
integer y = 35
integer width = 322
integer height = 90
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Aggiorna"
end type

event clicked;dw_1.retrieve()
end event

