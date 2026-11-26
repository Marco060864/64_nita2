forward
global type w_cod_bolli_k from w_semplice_gd
end type
type cb_carica from commandbutton within w_cod_bolli_k
end type
type ole_1 from olecontrol within w_cod_bolli_k
end type
end forward

global type w_cod_bolli_k from w_semplice_gd
integer width = 3913
integer height = 1580
cb_carica cb_carica
ole_1 ole_1
end type
global w_cod_bolli_k w_cod_bolli_k

on w_cod_bolli_k.create
int iCurrent
call super::create
this.cb_carica=create cb_carica
this.ole_1=create ole_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_carica
this.Control[iCurrent+2]=this.ole_1
end on

on w_cod_bolli_k.destroy
call super::destroy
destroy(this.cb_carica)
destroy(this.ole_1)
end on

event resize;call super::resize;cb_carica.y=newheight - 224
cb_carica.x=cb_ricerca.x - 385



end event

type cb_stampa from w_semplice_gd`cb_stampa within w_cod_bolli_k
end type

type cb_ricerca from w_semplice_gd`cb_ricerca within w_cod_bolli_k
end type

type cb_primo from w_semplice_gd`cb_primo within w_cod_bolli_k
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_cod_bolli_k
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_cod_bolli_k
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_cod_bolli_k
end type

type dw_1 from w_semplice_gd`dw_1 within w_cod_bolli_k
integer width = 3767
string dataobject = "d_cod_bolli_k"
end type

type cb_inserisci from w_semplice_gd`cb_inserisci within w_cod_bolli_k
end type

type cb_salva from w_semplice_gd`cb_salva within w_cod_bolli_k
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_cod_bolli_k
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_cod_bolli_k
end type

type cb_ok from w_semplice_gd`cb_ok within w_cod_bolli_k
end type

type cb_carica from commandbutton within w_cod_bolli_k
integer x = 2459
integer y = 992
integer width = 325
integer height = 96
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Carica XLS"
end type

event clicked;string ls_path, ls_file

getfileopenname("Cerca Accessori", ls_path, ls_file, "Excel, *.xls", "xls" , "C:\nita\exp_doc")
if  not(trim(ls_file)="" or isnull(ls_file)) then
	ole_1.open(ls_path)
	ls_file=left(ls_path, len(ls_path) - 3)+"txt"
	if fileexists(ls_file) then FileDelete(ls_file)
	ole_1.object.activesheet.saveas(ls_file, 21)
	dw_1.importfile(Text!,ls_file,2)

end if	 
end event

type ole_1 from olecontrol within w_cod_bolli_k
event queryinterface ( oleobject riid,  ref pointer ppvobj )
event addref ( )
event release ( )
event selectionchange ( oleobject target )
event beforedoubleclick ( oleobject target,  boolean cancel )
event beforerightclick ( oleobject target,  boolean cancel )
event activate ( )
event deactivate ( )
event calculate ( )
event change ( oleobject target )
boolean visible = false
integer x = 2738
integer y = 1132
integer width = 320
integer height = 140
integer taborder = 90
boolean bringtotop = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_cod_bolli_k.win"
omactivation activation = activateondoubleclick!
omdisplaytype displaytype = displayascontent!
omcontentsallowed contentsallowed = containsany!
end type

