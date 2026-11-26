forward
global type w_correggi_fino_calo_errato_gd from w_np_single_data
end type
type cb_correggi from commandbutton within w_correggi_fino_calo_errato_gd
end type
type cb_salva from commandbutton within w_correggi_fino_calo_errato_gd
end type
type cb_1 from commandbutton within w_correggi_fino_calo_errato_gd
end type
type cbx_no_righe_componenti from checkbox within w_correggi_fino_calo_errato_gd
end type
end forward

global type w_correggi_fino_calo_errato_gd from w_np_single_data
integer width = 5207
integer height = 2296
cb_correggi cb_correggi
cb_salva cb_salva
cb_1 cb_1
cbx_no_righe_componenti cbx_no_righe_componenti
end type
global w_correggi_fino_calo_errato_gd w_correggi_fino_calo_errato_gd

on w_correggi_fino_calo_errato_gd.create
int iCurrent
call super::create
this.cb_correggi=create cb_correggi
this.cb_salva=create cb_salva
this.cb_1=create cb_1
this.cbx_no_righe_componenti=create cbx_no_righe_componenti
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_correggi
this.Control[iCurrent+2]=this.cb_salva
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.cbx_no_righe_componenti
end on

on w_correggi_fino_calo_errato_gd.destroy
call super::destroy
destroy(this.cb_correggi)
destroy(this.cb_salva)
destroy(this.cb_1)
destroy(this.cbx_no_righe_componenti)
end on

event resize;call super::resize;dw_single.Width = newwidth - 80
dw_single.Height = newheight - 300
end event

type p_msg_log from w_np_single_data`p_msg_log within w_correggi_fino_calo_errato_gd
end type

type p_crescente from w_np_single_data`p_crescente within w_correggi_fino_calo_errato_gd
end type

type p_decrescente from w_np_single_data`p_decrescente within w_correggi_fino_calo_errato_gd
end type

type dw_single from w_np_single_data`dw_single within w_correggi_fino_calo_errato_gd
integer y = 160
integer width = 5097
integer height = 1940
string dataobject = "d_trova_fino_calo_errato_gd"
borderstyle borderstyle = stylelowered!
end type

event dw_single::doubleclicked;call super::doubleclicked;long ll_id_doc
w_orafo_documento_ordine_cx w_orafo
s_list_main s_list

long ll_id_riga
if row>0 then
	ll_id_doc=getitemnumber(row, "documento_id_documento")
	s_list.s_identifica[1]="id_documento"
	s_list.s_modo=modo_modifica
	
	if ll_id_doc>0 then
		s_list.l_identifica[1]=ll_id_doc
		openwithparm(w_orafo, s_list)
	end if
end if

end event

type cb_correggi from commandbutton within w_correggi_fino_calo_errato_gd
integer x = 183
integer y = 32
integer width = 343
integer height = 100
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Correggi"
end type

event clicked;integer i
decimal ldc_peso_netto,  ldc_fino, ldc_calo,ldc_coef_calo, ldc_titolo
decimal ldc_diff_calo_titolo
long ll_id_titolo

for i = 1 to dw_single.rowcount()
	ldc_peso_netto=dw_single.getitemdecimal(i, "peso_netto")
	ldc_peso_netto=f_round(ldc_peso_netto, -2, "M")
	ll_id_titolo=dw_single.getitemnumber(i, "articolo_id_titolo")
	ldc_fino=f_converti_in_fino(ldc_peso_netto, ll_id_titolo)
	ldc_coef_calo=dw_single.getitemdecimal(i, "coef_calo")
	ldc_titolo=dw_single.getitemdecimal(i, "titolo")
	ldc_diff_calo_titolo=ldc_coef_calo - ldc_titolo
	ldc_calo=f_round(ldc_peso_netto*ldc_diff_calo_titolo/1000, -2, 'M')
	dw_single.setitem(i, "fino", ldc_fino)
	dw_single.setitem(i, "calo", ldc_calo)
next
end event

type cb_salva from commandbutton within w_correggi_fino_calo_errato_gd
integer x = 681
integer y = 32
integer width = 343
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salva"
end type

event clicked;dw_single.triggerevent("ue_update")
end event

type cb_1 from commandbutton within w_correggi_fino_calo_errato_gd
integer x = 3589
integer y = 44
integer width = 343
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Chiudi"
end type

event clicked;close(parent)
end event

type cbx_no_righe_componenti from checkbox within w_correggi_fino_calo_errato_gd
integer x = 1120
integer y = 36
integer width = 869
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "NO righe Esplose (componenti)"
end type

event clicked;if checked then
	dw_single.setfilter("c_fino_calo <> peso_fc and isnull(id_riga_doc_padre)")
	dw_single.filter()
else
	dw_single.setfilter("c_fino_calo <> peso_fc")
	dw_single.filter()
end if
end event

