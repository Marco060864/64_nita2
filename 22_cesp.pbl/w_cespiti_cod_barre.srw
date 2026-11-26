forward
global type w_cespiti_cod_barre from w_stampa_001
end type
type cb_2 from commandbutton within w_cespiti_cod_barre
end type
type cb_salva from commandbutton within w_cespiti_cod_barre
end type
type cbx_1 from checkbox within w_cespiti_cod_barre
end type
end forward

global type w_cespiti_cod_barre from w_stampa_001
integer x = 23
integer y = 12
cb_2 cb_2
cb_salva cb_salva
cbx_1 cbx_1
end type
global w_cespiti_cod_barre w_cespiti_cod_barre

on w_cespiti_cod_barre.create
int iCurrent
call super::create
this.cb_2=create cb_2
this.cb_salva=create cb_salva
this.cbx_1=create cbx_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_2
this.Control[iCurrent+2]=this.cb_salva
this.Control[iCurrent+3]=this.cbx_1
end on

on w_cespiti_cod_barre.destroy
call super::destroy
destroy(this.cb_2)
destroy(this.cb_salva)
destroy(this.cbx_1)
end on

event open;call super::open;dw_1.settransobject(sqlca)
dw_1.retrieve()
end event

type dw_1 from w_stampa_001`dw_1 within w_cespiti_cod_barre
string dataobject = "d_crea_cod_barre_gd"
end type

type sle_pg from w_stampa_001`sle_pg within w_cespiti_cod_barre
boolean visible = false
integer x = 3152
integer y = 285
integer width = 201
end type

type st_1 from w_stampa_001`st_1 within w_cespiti_cod_barre
boolean visible = false
integer x = 2885
integer y = 294
end type

type st_2 from w_stampa_001`st_2 within w_cespiti_cod_barre
boolean visible = false
integer x = 3079
integer y = 256
end type

type sle_copie from w_stampa_001`sle_copie within w_cespiti_cod_barre
boolean visible = false
integer x = 3226
integer y = 246
end type

type sle_zoom from w_stampa_001`sle_zoom within w_cespiti_cod_barre
integer x = 658
end type

type cb_salva_su_file from w_stampa_001`cb_salva_su_file within w_cespiti_cod_barre
boolean visible = false
integer x = 3196
integer y = 179
end type

type cb_7 from w_stampa_001`cb_7 within w_cespiti_cod_barre
integer x = 808
end type

type cb_6 from w_stampa_001`cb_6 within w_cespiti_cod_barre
integer x = 541
end type

type cb_imp_st from w_stampa_001`cb_imp_st within w_cespiti_cod_barre
integer x = 2955
end type

type cb_stampa from w_stampa_001`cb_stampa within w_cespiti_cod_barre
integer weight = 700
end type

type cb_preview from w_stampa_001`cb_preview within w_cespiti_cod_barre
integer x = 2666
end type

type cb_pg_dopo from w_stampa_001`cb_pg_dopo within w_cespiti_cod_barre
end type

type cb_pg_prima from w_stampa_001`cb_pg_prima within w_cespiti_cod_barre
end type

type cb_1 from w_stampa_001`cb_1 within w_cespiti_cod_barre
end type

type cb_2 from commandbutton within w_cespiti_cod_barre
integer x = 1083
integer y = 35
integer width = 201
integer height = 90
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Crea"
end type

event clicked;long i, ll_num_prog
string ls_num_prog, ls_max_cod_barre,ls_check, ls_codice, ls_codice_ok
string ls_test
//dw_1.setfilter("cod_barre> ' '")
//dw_1.filter()

select max(cod_barre)
into :ls_max_cod_barre
from dba.cespite
;
if isnull(ls_max_cod_barre) then 
	ll_num_prog=0
else
	ls_num_prog=mid(ls_max_cod_barre, 3, len(ls_max_cod_barre) - 3)
	ll_num_prog=long(ls_num_prog)
end if
for i = 1 to dw_1.rowcount()
	ls_test=dw_1.getitemstring(i, "cod_barre")
	
	if isnull(ls_test) then
	
		ll_num_prog++
	
		ls_num_prog=string(ll_num_prog)
	
		do while len(ls_num_prog)<10
			ls_num_prog="0"+ls_num_prog
		loop
		ls_codice='80'+ls_num_prog
		ls_check=string(f_check_digit(ls_codice, 13))
		
		ls_codice+= ls_check
		ls_codice_ok=f_crea_codice_a_barre(ls_codice)
		
		dw_1.setitem(i, "cod_barre", ls_codice_ok)
	end if
	//dw_1
next

//dw_1.setfilter("")
//dw_1.filter()

end event

type cb_salva from commandbutton within w_cespiti_cod_barre
integer x = 1393
integer y = 35
integer width = 194
integer height = 90
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salva"
end type

event clicked;integer li_ret

li_ret=dw_1.update()
if li_ret=1 then
	commit;
else
	rollback;
	messagebox(  this.classname() +" - Salvataggio non riuscito!",sqlca.sqlerrtext)
end if
	
	
	
return li_ret
end event

type cbx_1 from checkbox within w_cespiti_cod_barre
integer x = 1891
integer y = 22
integer width = 739
integer height = 115
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Escludi Cod Barre Esistenti"
end type

event clicked;if checked then
	dw_1.setfilter("cod_barre< ' '")
else
	dw_1.setfilter("")
end if
dw_1.filter()
end event

