forward
global type w_mag_frank2 from w_semplice_cx
end type
type cb_importa from commandbutton within w_mag_frank2
end type
end forward

global type w_mag_frank2 from w_semplice_cx
integer width = 3689
integer height = 2236
cb_importa cb_importa
end type
global w_mag_frank2 w_mag_frank2

on w_mag_frank2.create
int iCurrent
call super::create
this.cb_importa=create cb_importa
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_importa
end on

on w_mag_frank2.destroy
call super::destroy
destroy(this.cb_importa)
end on

event resize;call super::resize;cb_importa.y=cb_cancella.y
cb_importa.x=cb_cancella.x + cb_cancella.width +100
end event

type cb_stampa from w_semplice_cx`cb_stampa within w_mag_frank2
end type

type cb_ricerca from w_semplice_cx`cb_ricerca within w_mag_frank2
end type

type cb_primo from w_semplice_cx`cb_primo within w_mag_frank2
end type

type cb_ultimo from w_semplice_cx`cb_ultimo within w_mag_frank2
end type

type cb_indietro from w_semplice_cx`cb_indietro within w_mag_frank2
end type

type cb_avanti from w_semplice_cx`cb_avanti within w_mag_frank2
end type

type dw_1 from w_semplice_cx`dw_1 within w_mag_frank2
integer width = 3589
string dataobject = "d_acc_francesco"
end type

type cb_inserisci from w_semplice_cx`cb_inserisci within w_mag_frank2
end type

type cb_salva from w_semplice_cx`cb_salva within w_mag_frank2
end type

type cb_cancella from w_semplice_cx`cb_cancella within w_mag_frank2
end type

type cb_annulla from w_semplice_cx`cb_annulla within w_mag_frank2
end type

type cb_ok from w_semplice_cx`cb_ok within w_mag_frank2
end type

type cb_importa from commandbutton within w_mag_frank2
integer x = 2478
integer y = 984
integer width = 402
integer height = 112
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Importa"
end type

event clicked;string ls_path, ls_file

getfileopenname("Cerca report", ls_path, ls_file, "CSV, *.csv", "csv" , "C:\nita\mag_frank")
if  not(trim(ls_file)="" or isnull(ls_file)) then
	ls_file=left(ls_path, len(ls_path) - 3)+"csv"
	dw_1.importfile(CSV!,ls_file)
	
end if
end event

