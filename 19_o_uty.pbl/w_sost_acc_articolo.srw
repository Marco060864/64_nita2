forward
global type w_sost_acc_articolo from w_semplice_cx
end type
type dw_2 from udw_001 within w_sost_acc_articolo
end type
type cb_csv from commandbutton within w_sost_acc_articolo
end type
type cb_vai from commandbutton within w_sost_acc_articolo
end type
type st_csv from statictext within w_sost_acc_articolo
end type
end forward

global type w_sost_acc_articolo from w_semplice_cx
integer width = 3456
integer height = 1376
dw_2 dw_2
cb_csv cb_csv
cb_vai cb_vai
st_csv st_csv
end type
global w_sost_acc_articolo w_sost_acc_articolo

on w_sost_acc_articolo.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.cb_csv=create cb_csv
this.cb_vai=create cb_vai
this.st_csv=create st_csv
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.cb_csv
this.Control[iCurrent+3]=this.cb_vai
this.Control[iCurrent+4]=this.st_csv
end on

on w_sost_acc_articolo.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.cb_csv)
destroy(this.cb_vai)
destroy(this.st_csv)
end on

event resize;call super::resize;cb_csv.y=newheight - 224
cb_csv.x=cb_ricerca.x - 285
cb_vai.x=cb_csv.x - 255
cb_vai.y=newheight - 224

st_csv.x=cb_vai.x
st_csv.y=newheight - 224 + 100
end event

type cb_stampa from w_semplice_cx`cb_stampa within w_sost_acc_articolo
end type

type cb_ricerca from w_semplice_cx`cb_ricerca within w_sost_acc_articolo
end type

type cb_primo from w_semplice_cx`cb_primo within w_sost_acc_articolo
end type

type cb_ultimo from w_semplice_cx`cb_ultimo within w_sost_acc_articolo
end type

type cb_indietro from w_semplice_cx`cb_indietro within w_sost_acc_articolo
end type

type cb_avanti from w_semplice_cx`cb_avanti within w_sost_acc_articolo
end type

type dw_1 from w_semplice_cx`dw_1 within w_sost_acc_articolo
integer width = 3346
string dataobject = "d_sost_acc_articolo"
end type

event dw_1::retrievestart;call super::retrievestart;return 2
end event

type cb_inserisci from w_semplice_cx`cb_inserisci within w_sost_acc_articolo
end type

type cb_salva from w_semplice_cx`cb_salva within w_sost_acc_articolo
end type

type cb_cancella from w_semplice_cx`cb_cancella within w_sost_acc_articolo
end type

type cb_annulla from w_semplice_cx`cb_annulla within w_sost_acc_articolo
end type

type cb_ok from w_semplice_cx`cb_ok within w_sost_acc_articolo
end type

type dw_2 from udw_001 within w_sost_acc_articolo
boolean visible = false
integer x = 78
integer y = 1220
integer width = 3031
integer taborder = 60
boolean bringtotop = true
string dataobject = "d_sost_acc_art_csv"
end type

type cb_csv from commandbutton within w_sost_acc_articolo
integer x = 2450
integer y = 968
integer width = 192
integer height = 96
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "XLS"
end type

event clicked;string ls_path, ls_file, ls_num_bollettina
integer i, li_ret
long ll_id_bollettina

getfileopenname("Cerca report", ls_path, ls_file, "Excel, *.xls", "xls" , "C:\nita\exp_doc")
if  not(trim(ls_file)="" or isnull(ls_file)) then
	dw_2.importfile(Text!,ls_file, 2)
end if


end event

type cb_vai from commandbutton within w_sost_acc_articolo
integer x = 2706
integer y = 996
integer width = 192
integer height = 96
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Vai"
end type

event clicked;integer i
long ll_id_art, ll_righe
string ls_acc_originale,ls_cod_articolo,ls_acc_nuovo, ls_cod_art_nuovo
dwitemstatus ldw_status

for I=1 to dw_2.rowcount()
	ll_id_art=dw_2.getitemnumber(i, "id_articolo")
	ls_acc_originale=dw_2.getitemstring(i, "acc_originale")
	ls_acc_nuovo=dw_2.getitemstring(i, "acc_nuovo")
	ll_righe=dw_1.retrieve(ll_id_art)
	ls_cod_articolo=dw_1.getitemstring(ll_righe, "codice")
	if pos(ls_cod_articolo, ls_acc_nuovo)>0 or pos(ls_cod_articolo, ls_acc_originale)<=0 then continue
	ls_cod_art_nuovo=replace(ls_cod_articolo, pos(ls_cod_articolo, ls_acc_originale), len(ls_acc_originale), ls_acc_nuovo)
	dw_1.setitem(ll_righe, "codice", ls_cod_art_nuovo)
	dw_1.setitem(ll_righe, "descrizione", ls_cod_art_nuovo)
	dw_1.trigger event ue_update()
next
end event

type st_csv from statictext within w_sost_acc_articolo
integer x = 2053
integer y = 1136
integer width = 1280
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Il file da importare deve essere salvato in CSV!!!"
boolean focusrectangle = false
end type

