forward
global type w_art_cambia_immagine from w_001
end type
type dw_1 from udw_base within w_art_cambia_immagine
end type
type cb_seleziona from commandbutton within w_art_cambia_immagine
end type
type sle_path from singlelineedit within w_art_cambia_immagine
end type
type cb_cambia from commandbutton within w_art_cambia_immagine
end type
type cb_2 from commandbutton within w_art_cambia_immagine
end type
type cb_3 from commandbutton within w_art_cambia_immagine
end type
type cb_inserisci from commandbutton within w_art_cambia_immagine
end type
type cb_salva from commandbutton within w_art_cambia_immagine
end type
type cb_cancella from commandbutton within w_art_cambia_immagine
end type
type pb_1 from picturebutton within w_art_cambia_immagine
end type
type cb_1 from commandbutton within w_art_cambia_immagine
end type
type r_1 from rectangle within w_art_cambia_immagine
end type
type ln_1 from line within w_art_cambia_immagine
end type
type ln_2 from line within w_art_cambia_immagine
end type
end forward

global type w_art_cambia_immagine from w_001
integer width = 4037
integer height = 2003
string title = "Cambiare cartelle alle foto degli articoli"
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = main!
dw_1 dw_1
cb_seleziona cb_seleziona
sle_path sle_path
cb_cambia cb_cambia
cb_2 cb_2
cb_3 cb_3
cb_inserisci cb_inserisci
cb_salva cb_salva
cb_cancella cb_cancella
pb_1 pb_1
cb_1 cb_1
r_1 r_1
ln_1 ln_1
ln_2 ln_2
end type
global w_art_cambia_immagine w_art_cambia_immagine

on w_art_cambia_immagine.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_seleziona=create cb_seleziona
this.sle_path=create sle_path
this.cb_cambia=create cb_cambia
this.cb_2=create cb_2
this.cb_3=create cb_3
this.cb_inserisci=create cb_inserisci
this.cb_salva=create cb_salva
this.cb_cancella=create cb_cancella
this.pb_1=create pb_1
this.cb_1=create cb_1
this.r_1=create r_1
this.ln_1=create ln_1
this.ln_2=create ln_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_seleziona
this.Control[iCurrent+3]=this.sle_path
this.Control[iCurrent+4]=this.cb_cambia
this.Control[iCurrent+5]=this.cb_2
this.Control[iCurrent+6]=this.cb_3
this.Control[iCurrent+7]=this.cb_inserisci
this.Control[iCurrent+8]=this.cb_salva
this.Control[iCurrent+9]=this.cb_cancella
this.Control[iCurrent+10]=this.pb_1
this.Control[iCurrent+11]=this.cb_1
this.Control[iCurrent+12]=this.r_1
this.Control[iCurrent+13]=this.ln_1
this.Control[iCurrent+14]=this.ln_2
end on

on w_art_cambia_immagine.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_seleziona)
destroy(this.sle_path)
destroy(this.cb_cambia)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.cb_inserisci)
destroy(this.cb_salva)
destroy(this.cb_cancella)
destroy(this.pb_1)
destroy(this.cb_1)
destroy(this.r_1)
destroy(this.ln_1)
destroy(this.ln_2)
end on

event open;call super::open;dw_1.settransobject(sqlca)
end event

type st_1 from w_001`st_1 within w_art_cambia_immagine
integer x = 88
integer y = 1798
end type

type dw_1 from udw_base within w_art_cambia_immagine
integer x = 26
integer y = 192
integer width = 3924
integer height = 1565
boolean bringtotop = true
string dataobject = "d_art_cambia_path_immagine_gd"
boolean hscrollbar = true
end type

event retrievestart;call super::retrievestart;return 2
end event

type cb_seleziona from commandbutton within w_art_cambia_immagine
integer x = 845
integer y = 51
integer width = 417
integer height = 90
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Scegli Articoli"
end type

event clicked;s_dw_ritorna st_p
integer li_righe
long ll_id_art

//li_righe=dw_1.getrow()
//ll_id_lista=dw_1.getitemnumber(li_righe, "id_lista_articoli")
//IF ll_id_lista>0 THEN

	openwithparm(w_auto_aggiunta_cx, 0)
	
	
	st_p=message.powerobjectparm
	
	if isvalid(st_p) then
		for li_righe= 1 to st_p.ds.rowcount()
			ll_id_art=st_p.ds.getitemnumber(li_righe, "id_articolo")
			dw_1.retrieve(ll_id_art)
		next
			
	end if
	
	dw_1.sort()
//	if dw_1.rowcount()>0 then
//		if messagebox("Attenzione!", "Salvare la lista corrente?", stopsign!,yesno!)=1 then
//			//wf_salva_dw(dw_1,dw_2,2)
//		end if
//	end if
//else
//	messagebox("Attenzione!", "Salvare la lista corrente prima di effettuare la selezione!")
//end if
	
end event

type sle_path from singlelineedit within w_art_cambia_immagine
integer x = 1335
integer y = 51
integer width = 907
integer height = 90
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "s:\foto\"
borderstyle borderstyle = stylelowered!
end type

type cb_cambia from commandbutton within w_art_cambia_immagine
integer x = 2454
integer y = 51
integer width = 578
integer height = 90
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cambia path immagine"
end type

event clicked;integer i, li_pos, li_FileNum
boolean lb_test
string ls_file, ls_path, ls_nome_file, ls_messaggio
string ls_path_default, ls_path_attuale, ls_file_origine, ls_file_destinazione


dw_1.setfilter("scegli=1")
dw_1.filter()

ls_path=sle_path.text

select dir_immagini
into :ls_path_default
from dba.par_sistema
;

for i=1 to dw_1.rowcount()
	ls_file=dw_1.getitemstring(i, "immagine")
	ls_nome_file=f_estrai_nome_file(ls_file)
	
	//ora sposto anche la foto
	li_pos=pos(ls_file, "\")
	if li_pos>0 then
		li_pos=pos(ls_file, ls_nome_file)
		ls_path_attuale=left(ls_file, li_pos -1)
	else
		ls_path_attuale=ls_path_default
		if right(ls_path_attuale, 1)<>"\" then ls_path_attuale +="\"
	end if
	//ora copio il file dalla sua posizione e lo incollo nel path scelto
	//lascio il file originale anche nella posizione originaria
	li_FileNum = FileCopy (ls_path_attuale+ls_nome_file, ls_path+ls_nome_file, FALSE)
	if li_FileNum<>1 then
		ls_messaggio="File: "+ls_path_attuale+ls_nome_file+" non spostato nella cartella: "+ls_path
		dw_1.setitem(i, "note", ls_messaggio)
		continue
	else
		ls_messaggio='Spostato: OK!'
		dw_1.setitem(i, "note", ls_messaggio)
		dw_1.setitem(i, "immagine", ls_path+ls_nome_file)
	end if
	ls_file_origine=ls_path_attuale+ls_file
	ls_file_destinazione=ls_path_attuale+string(today(), "yy_mm_dd" )+"_"+ls_file
	lb_test=MoveFileA(ls_file_origine,ls_file_destinazione )
	if not (lb_test) then
			ls_messaggio+=" - File: "+ls_path_attuale+ls_nome_file+" non rinominato"
			dw_1.setitem(i, "note",ls_messaggio)
	end if
	ls_messaggio=""
	
next

dw_1.setfilter("")
dw_1.filter()
end event

type cb_2 from commandbutton within w_art_cambia_immagine
integer x = 40
integer y = 51
integer width = 223
integer height = 90
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Sel. tutti"
end type

event clicked;INTEGER I
LONG ll_righe

ll_righe=dw_1.rowcount()
for i= 1 to ll_righe
	DW_1.SETITEM(I, "SCEGLI", 1)
	
	
NEXT
end event

type cb_3 from commandbutton within w_art_cambia_immagine
integer x = 278
integer y = 51
integer width = 282
integer height = 90
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Desel. tutti"
end type

event clicked;INTEGER I
LONG ll_righe

ll_righe=dw_1.rowcount()
for i= 1 to ll_righe
	DW_1.SETITEM(I, "SCEGLI", 0)
	
	
NEXT
end event

type cb_inserisci from commandbutton within w_art_cambia_immagine
integer x = 3376
integer y = 51
integer width = 260
integer height = 90
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Inserisci"
end type

event clicked;long ll_riga, ll_id

ll_riga=dw_1.trigger event ue_insert(0)

end event

type cb_salva from commandbutton within w_art_cambia_immagine
integer x = 3076
integer y = 51
integer width = 260
integer height = 90
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salva"
end type

event clicked;
dw_1.trigger event ue_update()

end event

type cb_cancella from commandbutton within w_art_cambia_immagine
integer x = 3672
integer y = 51
integer width = 260
integer height = 90
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancella"
end type

event clicked;long ll_riga_da_cancellare

	ll_riga_da_cancellare=dw_1.getrow()
	if ll_riga_da_cancellare>0 then
	 	dw_1.trigger event ue_delete(ll_riga_da_cancellare)
	end if
end event

type pb_1 from picturebutton within w_art_cambia_immagine
integer x = 2249
integer y = 51
integer width = 117
integer height = 90
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "ToDoList!"
alignment htextalign = left!
end type

event clicked;integer li_pos
string ls_path, ls_file, ls_ok
	
getfileopenname("Cerca Cartella", ls_path, ls_file)
if  trim(ls_file)>"" then
//	li_ret=messagebox("Richiesta conferma!","Vuoi riportare il solo nome del file?", Information!,yesno! )
	//if  li_ret=1 then
		li_pos=pos(ls_path, ls_file)
		sle_path.text= left(ls_path, li_pos -1)
		 
//	else
//		 tab_1.tabpage_1.dw_prof_documento_gen_ff.setitem(row, "nome_report", ls_path)
//	end if
end if	
end event

type cb_1 from commandbutton within w_art_cambia_immagine
integer x = 571
integer y = 51
integer width = 245
integer height = 90
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Pulisci"
end type

event clicked;dw_1.reset()
end event

type r_1 from rectangle within w_art_cambia_immagine
integer linethickness = 3
long fillcolor = 134217738
integer x = 22
integer y = 6
integer width = 3931
integer height = 160
end type

type ln_1 from line within w_art_cambia_immagine
integer linethickness = 5
integer beginx = 2403
integer beginy = 10
integer endx = 2403
integer endy = 160
end type

type ln_2 from line within w_art_cambia_immagine
integer linethickness = 5
integer beginx = 1298
integer beginy = 10
integer endx = 1298
integer endy = 160
end type

