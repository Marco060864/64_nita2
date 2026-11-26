forward
global type w_imp_galk from w_semplice_gd
end type
type cb_importa from commandbutton within w_imp_galk
end type
end forward

global type w_imp_galk from w_semplice_gd
integer width = 3173
cb_importa cb_importa
end type
global w_imp_galk w_imp_galk

on w_imp_galk.create
int iCurrent
call super::create
this.cb_importa=create cb_importa
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_importa
end on

on w_imp_galk.destroy
call super::destroy
destroy(this.cb_importa)
end on

event resize;call super::resize;cb_importa.y=cb_annulla.y
cb_importa.x=cb_ricerca.x - cb_importa.width -50
end event

type cb_stampa from w_semplice_gd`cb_stampa within w_imp_galk
end type

type cb_ricerca from w_semplice_gd`cb_ricerca within w_imp_galk
end type

type cb_primo from w_semplice_gd`cb_primo within w_imp_galk
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_imp_galk
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_imp_galk
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_imp_galk
end type

type dw_1 from w_semplice_gd`dw_1 within w_imp_galk
integer width = 3031
string dataobject = "d_imp_galv_k"
end type

type cb_inserisci from w_semplice_gd`cb_inserisci within w_imp_galk
end type

type cb_salva from w_semplice_gd`cb_salva within w_imp_galk
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_imp_galk
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_imp_galk
end type

type cb_ok from w_semplice_gd`cb_ok within w_imp_galk
end type

type cb_importa from commandbutton within w_imp_galk
integer x = 2167
integer y = 1204
integer width = 261
integer height = 96
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "IMP"
end type

event clicked;string ls_file, ls_path

getfileopenname("Cerca report", ls_path, ls_file, "Excel, *.xls", "xls" , "C:\nita\exp_doc") //20230519 xls diventa xlsx .... proviamo
if  not(trim(ls_file)="" or isnull(ls_file)) then
	
	dw_1.importfile(Text!,ls_file)
end if
end event

