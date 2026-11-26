forward
global type w_articolo_new from w_padre_figlio_cx
end type
end forward

global type w_articolo_new from w_padre_figlio_cx
integer width = 4091
integer height = 2248
end type
global w_articolo_new w_articolo_new

on w_articolo_new.create
call super::create
end on

on w_articolo_new.destroy
call super::destroy
end on

event ue_postopen;call super::ue_postopen;//long ll_id, ll_riga

//dw_1.modify("datawindow.querymode=yes")

//if text='Ricerca' then
//	text='Trova'
//	dw_1.modify("datawindow.querymode=yes")
//else
//	text='Ricerca'
//	dw_1.accepttext()
//	dw_1.Modify("DataWindow.QueryMode=no")
//	ll_riga=dw_1.retrieve()
//end if
end event

type cb_ricerca from w_padre_figlio_cx`cb_ricerca within w_articolo_new
integer x = 960
integer y = 1948
end type

event cb_ricerca::clicked;long ll_id, ll_riga
string ls_foto, ls_path

if text='Ricerca' then
	text='Trova'
	dw_1.modify("datawindow.querymode=yes")
else
	text='Ricerca'
	dw_1.accepttext()
	dw_1.Modify("DataWindow.QueryMode=no")
	ll_riga=dw_1.retrieve()
	if ll_riga>0 then
		ls_foto=dw_1.getitemstring(dw_1.getrow(), "immagine")
		if pos(ls_foto, "\")>0 then
			dw_1.setitem(dw_1.getrow(), "c_foto", ls_foto)
		else
			select dir_immagini into :ls_path from dba.par_sistema;
			if right(ls_path, 1)="\" then ls_path=left(ls_path, len(ls_path) - 1)
			ls_foto=ls_path+"\"+ls_foto
			dw_1.setitem(dw_1.getrow(), "c_foto", ls_foto)
		end if
	end if
end if

end event

type dw_1 from w_padre_figlio_cx`dw_1 within w_articolo_new
integer width = 3849
integer height = 1556
string dataobject = "d_articolo_new"
boolean vscrollbar = true
end type

event dw_1::doubleclicked;//
end event

event dw_1::rowfocuschanged;long ll_id  //primary key del master da riportare per il retrieve del detail
string ls_foto, ls_path
//se esiste la riga
if currentrow>0 then
	IF CB_RICERCA.TEXT="Ricerca" then
		//recupero la primary key dal padre
		ll_id=getitemnumber(currentrow, 1)
		// se esiste PK ..
		if ll_id>=0 then
			//la riporto per il retrieve del detail
			dw_2.retrieve(ll_id)
			ls_foto=dw_1.getitemstring(dw_1.getrow(), "immagine")
			if pos(ls_foto, "\")>0 then
				dw_1.setitem(dw_1.getrow(), "c_foto", ls_foto)
			else
				select dir_immagini into :ls_path from dba.par_sistema;
				if right(ls_path, 1)="\" then ls_path=left(ls_path, len(ls_path) - 1)
				ls_foto=ls_path+"\"+ls_foto
				dw_1.setitem(dw_1.getrow(), "c_foto", ls_foto)
			end if
		else
			dw_2.reset()
		end if
	else
		dw_2.reset()
	end if
else
	dw_2.reset()
end if
//setrowfocusindicator(hand!)
end event

event dw_1::retrieveend;call super::retrieveend;long ll_id

if rowcount>0 then
	ll_id=getitemnumber(rowcount, 1)

	dw_2.retrieve(ll_id)
end if
end event

event dw_1::itemchanged;call super::itemchanged;//choose case dwo.name
//	case "id_articolo"
//		cb_ricerca.text='Trova'
//		cb_ricerca.triggerevent(clicked!)	
//	case "articolo_codice"
//		cb_ricerca.text='Trova'
//		cb_ricerca.triggerevent(clicked!)	
//end choose
end event

event dw_1::updateend;call super::updateend;long ll_id

if rowsinserted>0 then
	ll_id=getitemnumber(getrow(), "id_articolo")
	dw_2.retrieve(ll_id)
	
end if
end event

type dw_2 from w_padre_figlio_cx`dw_2 within w_articolo_new
integer x = 69
integer y = 1636
integer width = 3849
integer height = 284
string dataobject = "d_orafo_unita_confezione2_lt"
end type

type cb_inserisci from w_padre_figlio_cx`cb_inserisci within w_articolo_new
integer x = 82
integer y = 1948
end type

type cb_salva from w_padre_figlio_cx`cb_salva within w_articolo_new
integer x = 370
integer y = 1948
end type

type cb_cancella from w_padre_figlio_cx`cb_cancella within w_articolo_new
integer x = 658
integer y = 1948
end type

type cb_annulla from w_padre_figlio_cx`cb_annulla within w_articolo_new
integer x = 1253
integer y = 1948
end type

type cb_ok from w_padre_figlio_cx`cb_ok within w_articolo_new
integer x = 1550
integer y = 1948
end type

