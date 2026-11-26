forward
global type w_lista_scritture_per_registro from w_001
end type
type dw_1 from udw_base within w_lista_scritture_per_registro
end type
type dw_2 from udw_base within w_lista_scritture_per_registro
end type
type cb_trova_prog_errati from commandbutton within w_lista_scritture_per_registro
end type
type dw_3 from udw_base within w_lista_scritture_per_registro
end type
type cb_salva from commandbutton within w_lista_scritture_per_registro
end type
type rb_1 from radiobutton within w_lista_scritture_per_registro
end type
type rb_2 from radiobutton within w_lista_scritture_per_registro
end type
end forward

global type w_lista_scritture_per_registro from w_001
integer width = 3024
integer height = 1917
dw_1 dw_1
dw_2 dw_2
cb_trova_prog_errati cb_trova_prog_errati
dw_3 dw_3
cb_salva cb_salva
rb_1 rb_1
rb_2 rb_2
end type
global w_lista_scritture_per_registro w_lista_scritture_per_registro

type variables
//long il_id_registro

//string is_sql
end variables

on w_lista_scritture_per_registro.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_2=create dw_2
this.cb_trova_prog_errati=create cb_trova_prog_errati
this.dw_3=create dw_3
this.cb_salva=create cb_salva
this.rb_1=create rb_1
this.rb_2=create rb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.cb_trova_prog_errati
this.Control[iCurrent+4]=this.dw_3
this.Control[iCurrent+5]=this.cb_salva
this.Control[iCurrent+6]=this.rb_1
this.Control[iCurrent+7]=this.rb_2
end on

on w_lista_scritture_per_registro.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.cb_trova_prog_errati)
destroy(this.dw_3)
destroy(this.cb_salva)
destroy(this.rb_1)
destroy(this.rb_2)
end on

event open;call super::open;dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
dw_3.settransobject(sqlca)
dw_1.retrieve()

dw_2.insertrow(1)

//is_sql=dw_1.getsqlselect()
end event

type st_1 from w_001`st_1 within w_lista_scritture_per_registro
end type

type dw_1 from udw_base within w_lista_scritture_per_registro
integer x = 59
integer y = 26
integer width = 1726
integer height = 1766
boolean bringtotop = true
string dataobject = "d_lista_scritture_per_registro"
end type

event sqlpreview;call super::sqlpreview;//string ls_sql
//
//if il_id_registro>0 then
//	ls_sql=is_sql
//	ls_sql+= " and registro.id_registro= "+string(il_id_registro)
//	setsqlpreview(ls_sql)
//end if
end event

type dw_2 from udw_base within w_lista_scritture_per_registro
integer x = 2253
integer y = 26
integer width = 702
integer height = 154
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_sel_registro_ext"
end type

event itemchanged;call super::itemchanged;long ll_id_registro

ll_id_registro=long(data)

if ll_id_registro>0 then
	dw_1.setfilter("reg_pd_id_registro="+string(ll_id_registro))
else
	dw_1.setfilter("")
end if
	dw_1.filter()
end event

type cb_trova_prog_errati from commandbutton within w_lista_scritture_per_registro
integer x = 2458
integer y = 205
integer width = 501
integer height = 90
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Prog. Incongruenti"
end type

event clicked;long i, ll_num_prog, ll_num_prog_succ, ll_righe, ll_riga_inserita

ll_righe=dw_1.rowcount()

dw_3.reset()
for i= 1 to ll_righe
	
	if i>1 and i<ll_righe then
		ll_num_prog=dw_1.getitemnumber(i - 1, "reg_pd_num_progressivo")
		ll_num_prog_succ=dw_1.getitemnumber(i, "reg_pd_num_progressivo")
		if ll_num_prog_succ <> ll_num_prog + 1 then
			ll_riga_inserita=dw_3.insertrow(0)
			dw_3.setitem(ll_riga_inserita, "num_riga", i)
			dw_3.setitem(ll_riga_inserita, "descrizione", "Prog. Prec.: "+string(ll_num_prog)+" - Prog.: "+string(ll_num_prog_succ))
		end if
	end if
	
	
next
end event

type dw_3 from udw_base within w_lista_scritture_per_registro
integer x = 1814
integer y = 307
integer width = 1141
integer height = 1485
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_prog_incongruenti"
end type

event rowfocuschanged;call super::rowfocuschanged;long ll_riga_dw_1

if currentrow>0 then
	ll_riga_dw_1=dw_3.getitemnumber(currentrow, "num_riga")
	if ll_riga_dw_1> 0 then
		dw_1.scrolltorow(ll_riga_dw_1)
	end if
end if
end event

type cb_salva from commandbutton within w_lista_scritture_per_registro
integer x = 1814
integer y = 205
integer width = 388
integer height = 90
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "<<< Salva Prog."
end type

event clicked;dw_1.trigger event ue_update()
end event

type rb_1 from radiobutton within w_lista_scritture_per_registro
integer x = 1814
integer y = 26
integer width = 439
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "ordina per data"
end type

event clicked;string ls_sort

ls_sort="reg_pd_id_registro, reg_pd_data_registrazione, reg_pd_num_progressivo" 
dw_1.setsort(ls_sort)
dw_1.sort()
dw_1.groupcalc()
end event

type rb_2 from radiobutton within w_lista_scritture_per_registro
integer x = 1814
integer y = 102
integer width = 439
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "ordina per prog."
end type

event clicked;string ls_sort

ls_sort="reg_pd_id_registro, reg_pd_num_progressivo, reg_pd_data_registrazione" 
dw_1.setsort(ls_sort)
dw_1.sort()
dw_1.groupcalc()
end event

