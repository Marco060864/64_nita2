forward
global type w_ricerca_art_da_accessorio from w_padre_figlio_cx
end type
type cb_trova from commandbutton within w_ricerca_art_da_accessorio
end type
type cb_stampa from commandbutton within w_ricerca_art_da_accessorio
end type
type dw_3 from udw_001 within w_ricerca_art_da_accessorio
end type
type cb_trova_k from commandbutton within w_ricerca_art_da_accessorio
end type
type cb_excel from commandbutton within w_ricerca_art_da_accessorio
end type
end forward

global type w_ricerca_art_da_accessorio from w_padre_figlio_cx
integer width = 5083
integer height = 2240
cb_trova cb_trova
cb_stampa cb_stampa
dw_3 dw_3
cb_trova_k cb_trova_k
cb_excel cb_excel
end type
global w_ricerca_art_da_accessorio w_ricerca_art_da_accessorio

type variables
string is_acc
end variables

on w_ricerca_art_da_accessorio.create
int iCurrent
call super::create
this.cb_trova=create cb_trova
this.cb_stampa=create cb_stampa
this.dw_3=create dw_3
this.cb_trova_k=create cb_trova_k
this.cb_excel=create cb_excel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_trova
this.Control[iCurrent+2]=this.cb_stampa
this.Control[iCurrent+3]=this.dw_3
this.Control[iCurrent+4]=this.cb_trova_k
this.Control[iCurrent+5]=this.cb_excel
end on

on w_ricerca_art_da_accessorio.destroy
call super::destroy
destroy(this.cb_trova)
destroy(this.cb_stampa)
destroy(this.dw_3)
destroy(this.cb_trova_k)
destroy(this.cb_excel)
end on

event open;string ls_acc
dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
dw_3.settransobject(sqlca)
dw_3.insertrow(1)
dw_2.insertrow(1)

i_dw_corrente=1
//dw_1.trigger event ue_insert(0)

//if dw_1.retrieve()>0 then
//	ls_acc=dw_1.getitemstring(1,1)
//	dw_2.retrieve(ls_acc)
//end if
end event

type cb_ricerca from w_padre_figlio_cx`cb_ricerca within w_ricerca_art_da_accessorio
integer x = 974
integer y = 1932
end type

type dw_1 from w_padre_figlio_cx`dw_1 within w_ricerca_art_da_accessorio
integer x = 46
integer y = 24
integer width = 864
integer height = 464
string dataobject = "d_accessorio_ricerca"
end type

event dw_1::rowfocuschanged;//
end event

type dw_2 from w_padre_figlio_cx`dw_2 within w_ricerca_art_da_accessorio
integer x = 41
integer width = 4960
integer height = 1388
string title = "w_ricerca_art_da_accessorio"
string dataobject = "d_trova_art_da_accessorio_k"
end type

event dw_2::sqlpreview;call super::sqlpreview;	string ls_sql
	integer i
	
	ls_sql=sqlsyntax
	
	
	ls_sql+=is_acc
	i=SetSQLPreview(ls_sql)
	if i<>1 then
		messagebox("Errore!", "Filtro non applicato!")
	end if
end event

type cb_inserisci from w_padre_figlio_cx`cb_inserisci within w_ricerca_art_da_accessorio
integer x = 96
integer y = 1932
end type

type cb_salva from w_padre_figlio_cx`cb_salva within w_ricerca_art_da_accessorio
integer x = 384
integer y = 1932
end type

type cb_cancella from w_padre_figlio_cx`cb_cancella within w_ricerca_art_da_accessorio
integer x = 672
integer y = 1932
end type

type cb_annulla from w_padre_figlio_cx`cb_annulla within w_ricerca_art_da_accessorio
integer x = 1266
integer y = 1928
end type

type cb_ok from w_padre_figlio_cx`cb_ok within w_ricerca_art_da_accessorio
integer x = 1563
integer y = 1932
end type

type cb_trova from commandbutton within w_ricerca_art_da_accessorio
integer x = 928
integer y = 28
integer width = 343
integer height = 456
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "TROVA"
end type

event clicked;string ls_acc  //primary key del master da riportare per il retrieve del detail
integer i
//se esiste la riga
dw_1.accepttext()
if dw_1.getrow()>0 then
	if dw_1.rowcount()>1 then
		for i= 1 to dw_1.rowcount()
			ls_acc=upper(dw_1.getitemstring(i, 1))
			is_acc+= " and cod_accessori_k.descrizione like '%"+ls_acc+ "%' "
		next
	else
		ls_acc=upper(dw_1.getitemstring(1, 1))
		is_acc= " and cod_accessori_k.descrizione like '%"+ls_acc+ "%' "
		// se esiste PK ..
		
	end if
	if is_acc>" " then
		//la riporto per il retrieve del detail
		dw_2.retrieve(ls_acc)
	else
		dw_2.reset()
	end if
else
	dw_2.reset()
end if
//setrowfocusindicator(hand!)
end event

type cb_stampa from commandbutton within w_ricerca_art_da_accessorio
integer x = 2190
integer y = 28
integer width = 649
integer height = 456
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Stampa"
end type

event clicked;dw_2.print(true,true)
end event

type dw_3 from udw_001 within w_ricerca_art_da_accessorio
integer x = 4137
integer y = 24
integer width = 864
integer height = 464
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_accessorio_k_ricerca"
end type

event rowfocuschanged;//
end event

type cb_trova_k from commandbutton within w_ricerca_art_da_accessorio
integer x = 3771
integer y = 28
integer width = 343
integer height = 456
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "TROVA"
end type

event clicked;string ls_acc  //primary key del master da riportare per il retrieve del detail
integer i
//se esiste la riga
dw_3.accepttext()
if dw_3.getrow()>0 then
	if dw_3.rowcount()>1 then
		for i= 1 to dw_3.rowcount()
			ls_acc=upper(dw_3.getitemstring(i, 1))
			is_acc+= " and bollettine_excel.accessorio ='"+ls_acc+ "' "
		next
	else
		ls_acc=upper(dw_3.getitemstring(1, 1))
		is_acc= " and bollettine_excel.accessorio ='"+ls_acc+ "' "
		// se esiste PK ..
		
	end if
	if is_acc>" " then
		//la riporto per il retrieve del detail
		dw_2.retrieve(ls_acc)
	else
		dw_2.reset()
	end if
else
	dw_2.reset()
end if
//setrowfocusindicator(hand!)
end event

type cb_excel from commandbutton within w_ricerca_art_da_accessorio
integer x = 3145
integer y = 28
integer width = 343
integer height = 456
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Excel"
end type

event clicked;string ls_nome_file
integer li_ret

ls_nome_file="c:\nita\excel\"
ls_nome_file+=dw_3.getitemstring(1, "accessorio")+string(today(), "dd_mm_yyyy")+".xls"
li_ret=dw_2.saveas( ls_nome_file, Excel!,    true) 
if li_ret=1 then
	messagebox("OK!", "File salvato in "+ls_nome_file)
else
	messagebox("Ahi!", "File NON salvato")
end if
end event

