forward
global type w_controlla_tot_errati_gd from w_001
end type
type dw_1 from udw_base within w_controlla_tot_errati_gd
end type
type cb_stampa from commandbutton within w_controlla_tot_errati_gd
end type
type rb_1 from radiobutton within w_controlla_tot_errati_gd
end type
type rb_2 from radiobutton within w_controlla_tot_errati_gd
end type
type rb_3 from radiobutton within w_controlla_tot_errati_gd
end type
end forward

global type w_controlla_tot_errati_gd from w_001
integer width = 3822
integer height = 2276
boolean minbox = true
boolean maxbox = true
boolean resizable = true
dw_1 dw_1
cb_stampa cb_stampa
rb_1 rb_1
rb_2 rb_2
rb_3 rb_3
end type
global w_controlla_tot_errati_gd w_controlla_tot_errati_gd

on w_controlla_tot_errati_gd.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_stampa=create cb_stampa
this.rb_1=create rb_1
this.rb_2=create rb_2
this.rb_3=create rb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_stampa
this.Control[iCurrent+3]=this.rb_1
this.Control[iCurrent+4]=this.rb_2
this.Control[iCurrent+5]=this.rb_3
end on

on w_controlla_tot_errati_gd.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_stampa)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.rb_3)
end on

event open;call super::open;dw_1.settransobject(sqlca)
dw_1.retrieve()
end event

event resize;call super::resize;dw_1.height=height - 450
dw_1.width=width - 120
rb_1.y=dw_1.y+dw_1.height+15
rb_2.y=rb_1.y + 70
rb_3.y=rb_2.y +70
end event

type st_1 from w_001`st_1 within w_controlla_tot_errati_gd
end type

type dw_1 from udw_base within w_controlla_tot_errati_gd
integer x = 37
integer y = 28
integer width = 3698
integer height = 1792
boolean bringtotop = true
string dataobject = "d_controlla_tot_errati_gd"
end type

event doubleclicked;call super::doubleclicked;long ll_id_doc
w_orafo_documento_ordine_cx w_orafo
s_list_main s_list

if row<=0  then return
s_list.s_identifica[1]="id_documento"
s_list.s_modo=modo_modifica
ll_id_doc=getitemnumber(row, "documento_id_documento")
if ll_id_doc>0 then
	s_list.l_identifica[1]=ll_id_doc
	openwithparm(w_orafo, s_list)
end if
end event

type cb_stampa from commandbutton within w_controlla_tot_errati_gd
integer x = 3072
integer y = 1848
integer width = 261
integer height = 88
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Stampa"
end type

event clicked;printsetup()
dw_1.print()
end event

type rb_1 from radiobutton within w_controlla_tot_errati_gd
integer x = 46
integer y = 1836
integer width = 613
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
string text = "Nascondi Bolelttine"
end type

event clicked;if checked then
	dw_1.setfilter("prof_documento_codice<>'BOL' and prof_documento_codice<>'SBOL'")
else
	dw_1.setfilter("")
end if
	dw_1.filter()
end event

type rb_2 from radiobutton within w_controlla_tot_errati_gd
integer x = 46
integer y = 1912
integer width = 818
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
string text = "Nascondi Giusti con metallo"
end type

event clicked;if checked then
	
	dw_1.setfilter("riga_documento_tot_riga_val_az<>c_met_e_complessivo")
else
	dw_1.setfilter("")
end if
	dw_1.filter()
end event

type rb_3 from radiobutton within w_controlla_tot_errati_gd
integer x = 46
integer y = 1988
integer width = 658
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
string text = "Nascondi entrambi"
end type

event clicked;if checked then
	
	dw_1.setfilter("riga_documento_tot_riga_val_az<>c_met_e_complessivo and prof_documento_codice<>'BOL' and prof_documento_codice<>'SBOL'")
else
	dw_1.setfilter("")
end if
	dw_1.filter()
end event

