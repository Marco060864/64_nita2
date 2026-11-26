forward
global type w_rinumera_prog_per_data from w_base
end type
type cb_2 from commandbutton within w_rinumera_prog_per_data
end type
type cb_1 from commandbutton within w_rinumera_prog_per_data
end type
type cb_annulla from uo_commandbutton within w_rinumera_prog_per_data
end type
type cb_salva from uo_commandbutton within w_rinumera_prog_per_data
end type
type dw_1 from udw_001 within w_rinumera_prog_per_data
end type
end forward

global type w_rinumera_prog_per_data from w_base
integer width = 3575
boolean center = true
cb_2 cb_2
cb_1 cb_1
cb_annulla cb_annulla
cb_salva cb_salva
dw_1 dw_1
end type
global w_rinumera_prog_per_data w_rinumera_prog_per_data

on w_rinumera_prog_per_data.create
int iCurrent
call super::create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.cb_annulla=create cb_annulla
this.cb_salva=create cb_salva
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_2
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_annulla
this.Control[iCurrent+4]=this.cb_salva
this.Control[iCurrent+5]=this.dw_1
end on

on w_rinumera_prog_per_data.destroy
call super::destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.cb_annulla)
destroy(this.cb_salva)
destroy(this.dw_1)
end on

event open;call super::open;dw_1.settransobject(sqlca)
//dw_2.settransobject(sqlca)
//dw_2.insertrow(1)
dw_1.retrieve()
end event

type cb_2 from commandbutton within w_rinumera_prog_per_data
integer x = 2702
integer y = 1052
integer width = 343
integer height = 100
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Moltiplica"
end type

event clicked;integer i

for i=1 to dw_1.rowcount()
	//dw_1.setitem(i, "num_documento", string(i))
	dw_1.setitem(i, "num_progressivo", i*1000)
//	ls_globale="2023000000"
//	if i<10 then ls_globale+="00000"+string(i)
//	if i>=10 and i<100 then ls_globale+="0000"+string(i)
//	if i>=100 and i<1000 then ls_globale+="000"+string(i)
//	if i>=1000 and i<10000 then ls_globale+="00"+string(i)
//	if i>=10000 and i<100000 then ls_globale+="0"+string(i)
//	if i>=100000 and i<1000000 then ls_globale+=string(i)
//	
//	ldc_globale=dec(ls_globale)
//	dw_1.setitem(i, "prog_globale",ldc_globale)
//	dw_1.setitem(i, "doc_globale", ldc_globale)

next
end event

type cb_1 from commandbutton within w_rinumera_prog_per_data
integer x = 1371
integer y = 1056
integer width = 448
integer height = 100
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "cb_rinumera"
end type

event clicked;integer i
string ls_globale
decimal ldc_globale

for i = 1 to dw_1.rowcount()
	dw_1.setitem(i, "num_documento", string(i))
	dw_1.setitem(i, "num_progressivo", i)
	ls_globale="2023000000"
	if i<10 then ls_globale+="00000"+string(i)
	if i>=10 and i<100 then ls_globale+="0000"+string(i)
	if i>=100 and i<1000 then ls_globale+="000"+string(i)
	if i>=1000 and i<10000 then ls_globale+="00"+string(i)
	if i>=10000 and i<100000 then ls_globale+="0"+string(i)
	if i>=100000 and i<1000000 then ls_globale+=string(i)
	
	ldc_globale=dec(ls_globale)
	dw_1.setitem(i, "prog_globale",ldc_globale)
	dw_1.setitem(i, "doc_globale", ldc_globale)
next
end event

type cb_annulla from uo_commandbutton within w_rinumera_prog_per_data
string tag = "Chiude senza salvare nulla."
integer x = 2107
integer y = 1028
integer width = 261
integer height = 96
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
string text = "Chiudi"
end type

event clicked;close(parent)
end event

type cb_salva from uo_commandbutton within w_rinumera_prog_per_data
string tag = "Salva la finestra che ha il fuoco. Se essa è figlia, salva anche la finestra madre."
integer x = 718
integer y = 1024
integer width = 261
integer height = 96
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
string text = "Salva"
end type

event clicked;dw_1.trigger event ue_update()

end event

type dw_1 from udw_001 within w_rinumera_prog_per_data
integer x = 18
integer y = 36
integer width = 3433
integer height = 932
integer taborder = 10
string dataobject = "d_rinumera_prog_per_data"
end type

