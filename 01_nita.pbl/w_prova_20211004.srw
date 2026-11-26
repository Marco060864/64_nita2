forward
global type w_prova_20211004 from w_pop
end type
type cb_1 from commandbutton within w_prova_20211004
end type
type cb_2 from commandbutton within w_prova_20211004
end type
type cb_3 from commandbutton within w_prova_20211004
end type
type cb_4 from commandbutton within w_prova_20211004
end type
end forward

global type w_prova_20211004 from w_pop
integer width = 4983
integer height = 1608
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
cb_4 cb_4
end type
global w_prova_20211004 w_prova_20211004

type variables
string is_ok
end variables

on w_prova_20211004.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.cb_4=create cb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.cb_3
this.Control[iCurrent+4]=this.cb_4
end on

on w_prova_20211004.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.cb_4)
end on

event open;call super::open;dw_1.settransobject(sqlca)
end event

type dw_1 from w_pop`dw_1 within w_prova_20211004
integer width = 4786
integer height = 1240
string dataobject = "d_meglio_ora"
end type

event dw_1::sqlpreview;//string ls_sql
//long ll_pos
//
//if is_ok>" " and sqltype=PreviewSelect! then
//
////	ls_sql=sqlsyntax
////	
////	ll_pos=pos(ls_sql, "WHERE")
////	if ll_pos>0 then
////		ls_sql=left(ls_sql, ll_pos - 1)
////	end if
////	ls_sql+=this.is_sql
//	//messagebox("S", ls_sql)
//	setsqlpreview(is_ok)
//
//end if
end event

event dw_1::retrievestart;call super::retrievestart;return 2
end event

event dw_1::retrieveend;call super::retrieveend;dw_1.post sort()
end event

event dw_1::doubleclicked;long ll_id_doc, ll_id_riga
w_orafo_documento_ordine_cx w_orafo
s_list_main s_list

if row<=0 then return
s_list.s_identifica[1]="id_documento"
s_list.s_modo=modo_modifica
ll_id_riga=getitemnumber(row, "id_riga_doc_derivato")
select id_documento into :ll_id_doc from dba.riga_documento where id_riga_doc_provenienza=:ll_id_riga;
if ll_id_doc>0 then
	s_list.l_identifica[1]=ll_id_doc
	openwithparm(w_orafo, s_list)
end if

end event

event dw_1::rbuttondown;call super::rbuttondown;long ll_id_doc
w_orafo_documento_ordine_cx w_orafo
s_list_main s_list

if row<=0 then return
s_list.s_identifica[1]="id_documento"
s_list.s_modo=modo_modifica
ll_id_doc=getitemnumber(row, "id_doc_derivato")

if ll_id_doc>0 then
	s_list.l_identifica[1]=ll_id_doc
	openwithparm(w_orafo, s_list)
end if
end event

type cb_1 from commandbutton within w_prova_20211004
boolean visible = false
integer x = 2432
integer y = 1344
integer width = 402
integer height = 112
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "none"
end type

event clicked;integer li_FileNum, i, li_pos, li_pos2
string ls_testo, ls_ok

li_FileNum = FileOpen("c:\dati\pbd12-2017\prova_01.txt", textMode!, Read!, Shared! )  //EncodingUTF8!
filereadex(li_FileNum, ls_testo)
fileclose(li_FileNum)
li_pos= pos(ls_testo, "--", 1)
li_pos2=1
do while li_pos2>0
	li_pos2=li_pos+1
	li_pos2= pos(ls_testo, "--", li_pos2)	
	ls_ok+=" "+mid(ls_testo, li_pos+26, li_pos2 - li_pos - 26)
	li_pos=li_pos2+1
	li_pos= pos(ls_testo, "--", li_pos2)
	
loop

li_FileNum = FileOpen("c:\dati\pbd12-2017\prova_ok.txt", textMode!, WRITE!, LOCKWRITE!, replace! ) 
filewriteex(li_FileNum, ls_ok)

end event

type cb_2 from commandbutton within w_prova_20211004
boolean visible = false
integer x = 2921
integer y = 1356
integer width = 402
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "none"
end type

event clicked;integer li_FileNum, i, li_pos, li_pos2
string ls_testo, ls_ok

li_FileNum = FileOpen("c:\dati\pbd12-2017\prova_ok01.txt", textMode!, Read!, Shared! )  //EncodingUTF8!
filereadex(li_FileNum, ls_testo)
fileclose(li_FileNum)
li_pos= pos(ls_testo, "SELECT", 1)
li_pos2=1
do while li_pos2>0
	li_pos2=li_pos+1
	li_pos2= pos(ls_testo, "SELECT", li_pos2)	
	ls_ok+=" "+mid(ls_testo, li_pos, li_pos2 - 1 - li_pos)+";"
	li_pos=li_pos2+1
	li_pos= pos(ls_testo, "SELECT", li_pos2)
	
loop

li_FileNum = FileOpen("c:\dati\pbd12-2017\prova_okok.txt", textMode!, WRITE!, LOCKWRITE!, replace! ) 
filewriteex(li_FileNum, ls_ok)

end event

type cb_3 from commandbutton within w_prova_20211004
integer x = 101
integer y = 1324
integer width = 402
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Carica"
end type

event clicked;integer li_FileNum, i, li_pos, li_pos2, li_pos3
string ls_testo, ls_sql, ls_is_articolo
long ll_art, ll_id_riga

li_FileNum = FileOpen("c:\dati\pbd12-2017\prova_okok.txt", textMode!, Read!, Shared! )  //EncodingUTF8!
filereadex(li_FileNum, ls_testo)
fileclose(li_FileNum)
li_pos= pos(ls_testo, ";", 1)
li_pos2=1
do while li_pos>0
	is_ok=" "+mid(ls_testo, li_pos2, li_pos )
	li_pos3=pos(is_ok, "WHERE id_articolo=")
	ls_is_articolo=mid(is_ok, li_pos3+18, 5)
	ll_art=long (ls_is_articolo)
	li_pos3=pos(is_ok, "AND id_riga_documento=")
	ls_is_articolo=mid(is_ok, li_pos3+22, 7)
	ll_id_riga=long(ls_is_articolo)
	dw_1.retrieve(ll_art, ll_id_riga)
	li_pos2=li_pos+1
	li_pos= pos(ls_testo, ";", li_pos2)
	
loop

//li_FileNum = FileOpen("c:\dati\pbd12-2017\prova_okok.txt", textMode!, WRITE!, LOCKWRITE!, replace! ) 
//filewriteex(li_FileNum, is_ok)

end event

type cb_4 from commandbutton within w_prova_20211004
integer x = 4466
integer y = 1320
integer width = 402
integer height = 112
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Stampa"
end type

event clicked;dw_1.print(true, true)
end event

