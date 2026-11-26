forward
global type w_crea_giroconto from w_001
end type
type dw_1 from udw_base within w_crea_giroconto
end type
type dw_2 from udw_base within w_crea_giroconto
end type
type dw_3 from udw_base within w_crea_giroconto
end type
type cb_vai from commandbutton within w_crea_giroconto
end type
type cb_1 from commandbutton within w_crea_giroconto
end type
end forward

global type w_crea_giroconto from w_001
integer width = 3803
integer height = 2096
dw_1 dw_1
dw_2 dw_2
dw_3 dw_3
cb_vai cb_vai
cb_1 cb_1
end type
global w_crea_giroconto w_crea_giroconto

on w_crea_giroconto.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_2=create dw_2
this.dw_3=create dw_3
this.cb_vai=create cb_vai
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.dw_3
this.Control[iCurrent+4]=this.cb_vai
this.Control[iCurrent+5]=this.cb_1
end on

on w_crea_giroconto.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.cb_vai)
destroy(this.cb_1)
end on

event open;call super::open;dw_1.settransobject(sqlca)
dw_1.retrieve()

dw_2.settransobject(sqlca)

dw_3.settransobject(sqlca)
end event

type st_1 from w_001`st_1 within w_crea_giroconto
end type

type dw_1 from udw_base within w_crea_giroconto
integer x = 27
integer y = 24
integer width = 3726
integer height = 768
boolean bringtotop = true
string dataobject = "d_crea_giroconto_gd"
boolean hscrollbar = true
end type

type dw_2 from udw_base within w_crea_giroconto
integer x = 27
integer y = 828
integer width = 3726
integer height = 452
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_salva_reg_pd"
boolean hscrollbar = true
end type

type dw_3 from udw_base within w_crea_giroconto
integer x = 27
integer y = 1348
integer width = 3726
integer height = 452
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_salva_mov_contabile"
boolean hscrollbar = true
end type

type cb_vai from commandbutton within w_crea_giroconto
integer x = 229
integer y = 1872
integer width = 562
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Iva Acquisti a Erario/iva"
end type

event clicked;integer i, a
long ll_id_prof_reg, ll_id_reg, ll_num_prog, ll_id_valuta
long ll_riga_inserita, ll_test, ll_id_reg_pd
date ldt_data, ldt_data_doc
decimal ldc_valore
string ls_num_doc, ls_des_contabile

select id_prof_registrazione
into :ll_id_prof_reg
from prof_registrazione
where codice='GIROCONT'
;

ll_id_reg = dw_1.getitemnumber(1, "reg_pd_id_registro")

select max(num_progressivo)
into :ll_num_prog
from reg_pd
where id_registro=:ll_id_reg
;

for i= 1 to dw_1.rowcount()
	ll_num_prog++
	ls_des_contabile=dw_1.getitemstring(i, "MOV_CONTABILE_des_contabile")
	ls_num_doc=dw_1.getitemstring(i, "reg_pd_num_documento")
	ldt_data_doc=dw_1.getitemdate(i, "reg_pd_data_documento")
	ldt_data=dw_1.getitemdate(i, "reg_pd_data_competenza")
	ll_id_valuta=dw_1.getitemnumber(i, "reg_pd_id_valuta")
	ldc_valore=dw_1.getitemdecimal(i, "mov_contabile_dare")
	ll_riga_inserita=dw_2.trigger event ue_insert(0)
	dw_2.setitem(ll_riga_inserita, "id_registro",  ll_id_reg)
	dw_2.setitem(ll_riga_inserita, "id_prof_registrazione",  ll_id_prof_reg)
	dw_2.setitem(ll_riga_inserita, "num_progressivo",  ll_num_prog)
	dw_2.setitem(ll_riga_inserita, "data_competenza",  ldt_data)
	dw_2.setitem(ll_riga_inserita, "data_registrazione",  ldt_data)
	dw_2.setitem(ll_riga_inserita, "id_valuta",  ll_id_valuta)
	dw_2.setitem(ll_riga_inserita, "cambio",  1)
	
	ll_test=dw_2.trigger event ue_update()
	ll_id_reg_pd=dw_2.getitemnumber(ll_riga_inserita, "id_reg_pd")
	
	
	for a=1 to 2
		ll_riga_inserita=dw_3.trigger event ue_insert(0)
		dw_3.setitem(ll_riga_inserita, "id_reg_pd", ll_id_reg_pd )
		
		dw_3.setitem(ll_riga_inserita, "numero", a )
		dw_3.setitem(ll_riga_inserita, "id_valuta", ll_id_valuta)
		dw_3.setitem(ll_riga_inserita, "cambio",  1)
		dw_3.setitem(ll_riga_inserita, "des_contabile",  "IA/ER "+ls_des_contabile)
		dw_3.setitem(ll_riga_inserita, "data_inizio_competenza", ldt_data)
		dw_3.setitem(ll_riga_inserita, "data_fine_competenza", ldt_data)
		if a=1 then
			dw_3.setitem(ll_riga_inserita, "avere", ldc_valore)
			dw_3.setitem(ll_riga_inserita, "id_conto", 64 )
		else
			dw_3.setitem(ll_riga_inserita, "id_conto", 996 )
			dw_3.setitem(ll_riga_inserita, "dare", ldc_valore )
		end if
		ll_test=dw_3.trigger event ue_update()		
	next
next
end event

type cb_1 from commandbutton within w_crea_giroconto
integer x = 846
integer y = 1872
integer width = 622
integer height = 100
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Iva Vendite a Erario/iva"
end type

event clicked;integer i, a
long ll_id_prof_reg, ll_id_reg, ll_num_prog, ll_id_valuta
long ll_riga_inserita, ll_test, ll_id_reg_pd
date ldt_data, ldt_data_doc
decimal ldc_valore
string ls_num_doc, ls_des_contabile

dw_1.dataobject="d_crea_giroconto_iv_gd"
dw_1.settransobject(sqlca)
dw_1.retrieve()


select id_prof_registrazione
into :ll_id_prof_reg
from prof_registrazione
where codice='GIROCONT'
;

ll_id_reg = dw_1.getitemnumber(1, "reg_pd_id_registro")

select max(num_progressivo)
into :ll_num_prog
from reg_pd
where id_registro=:ll_id_reg
;

for i= 1 to dw_1.rowcount()
	ll_num_prog++
	ls_num_doc=dw_1.getitemstring(i, "reg_pd_num_documento")
	ls_des_contabile=dw_1.getitemstring(i, "MOV_CONTABILE_des_contabile")
	ldt_data_doc=dw_1.getitemdate(i, "reg_pd_data_documento")
	ldt_data=dw_1.getitemdate(i, "reg_pd_data_competenza")
	ll_id_valuta=dw_1.getitemnumber(i, "reg_pd_id_valuta")
	ldc_valore=dw_1.getitemdecimal(i, "mov_contabile_avere")
	ll_riga_inserita=dw_2.trigger event ue_insert(0)
	dw_2.setitem(ll_riga_inserita, "id_registro",  ll_id_reg)
	dw_2.setitem(ll_riga_inserita, "id_prof_registrazione",  ll_id_prof_reg)
	dw_2.setitem(ll_riga_inserita, "num_progressivo",  ll_num_prog)
	dw_2.setitem(ll_riga_inserita, "data_competenza",  ldt_data)
	dw_2.setitem(ll_riga_inserita, "data_registrazione",  ldt_data)
	dw_2.setitem(ll_riga_inserita, "id_valuta",  ll_id_valuta)
	dw_2.setitem(ll_riga_inserita, "cambio",  1)
	
	ll_test=dw_2.trigger event ue_update()
	ll_id_reg_pd=dw_2.getitemnumber(ll_riga_inserita, "id_reg_pd")
	
	
	for a=1 to 2
		ll_riga_inserita=dw_3.trigger event ue_insert(0)
		dw_3.setitem(ll_riga_inserita, "id_reg_pd", ll_id_reg_pd )
		
		dw_3.setitem(ll_riga_inserita, "numero", a )
		dw_3.setitem(ll_riga_inserita, "id_valuta", ll_id_valuta)
		dw_3.setitem(ll_riga_inserita, "cambio",  1)
		dw_3.setitem(ll_riga_inserita, "des_contabile",  "IV/ER "+ls_des_contabile)
		dw_3.setitem(ll_riga_inserita, "data_inizio_competenza", ldt_data)
		dw_3.setitem(ll_riga_inserita, "data_fine_competenza", ldt_data)
		if a=1 then
			dw_3.setitem(ll_riga_inserita, "dare", ldc_valore)
			dw_3.setitem(ll_riga_inserita, "id_conto", 200 )
		else
			dw_3.setitem(ll_riga_inserita, "id_conto", 996 )
			dw_3.setitem(ll_riga_inserita, "avere", ldc_valore )
		end if
				
	next
	ll_test=dw_3.trigger event ue_update()
next
end event

