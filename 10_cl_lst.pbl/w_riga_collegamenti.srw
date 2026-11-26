forward
global type w_riga_collegamenti from w_padre_figlio_nipote_cx
end type
type pb_cerca from picturebutton within w_riga_collegamenti
end type
type dw_4 from udw_001 within w_riga_collegamenti
end type
type dw_5 from udw_001 within w_riga_collegamenti
end type
type dw_6 from udw_001 within w_riga_collegamenti
end type
end forward

global type w_riga_collegamenti from w_padre_figlio_nipote_cx
integer width = 4347
integer height = 3344
pb_cerca pb_cerca
dw_4 dw_4
dw_5 dw_5
dw_6 dw_6
end type
global w_riga_collegamenti w_riga_collegamenti

on w_riga_collegamenti.create
int iCurrent
call super::create
this.pb_cerca=create pb_cerca
this.dw_4=create dw_4
this.dw_5=create dw_5
this.dw_6=create dw_6
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_cerca
this.Control[iCurrent+2]=this.dw_4
this.Control[iCurrent+3]=this.dw_5
this.Control[iCurrent+4]=this.dw_6
end on

on w_riga_collegamenti.destroy
call super::destroy
destroy(this.pb_cerca)
destroy(this.dw_4)
destroy(this.dw_5)
destroy(this.dw_6)
end on

event open;call super::open;dw_4.settransobject(sqlca)
dw_5.settransobject(sqlca)
dw_6.settransobject(sqlca)
end event

type dw_3 from w_padre_figlio_nipote_cx`dw_3 within w_riga_collegamenti
integer x = 87
integer y = 1148
integer width = 4155
integer height = 424
boolean titlebar = true
string title = "Riga Padre (derivazione)"
string dataobject = "d_riga_padre_collegamenti"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
end type

type cb_ricerca from w_padre_figlio_nipote_cx`cb_ricerca within w_riga_collegamenti
integer x = 974
integer y = 2932
end type

type dw_1 from w_padre_figlio_nipote_cx`dw_1 within w_riga_collegamenti
integer x = 78
integer width = 3154
integer height = 540
string dataobject = "d_doc_collegamenti_ra"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
end type

type dw_2 from w_padre_figlio_nipote_cx`dw_2 within w_riga_collegamenti
integer x = 82
integer y = 600
integer width = 4155
integer height = 532
string dataobject = "d_collegamenti_riga"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
end type

event dw_2::rowfocuschanged;long ll_id  //primary key del master da riportare per il retrieve del detail

//se esiste la riga
if currentrow>0 then
	//recupero la primary key dal padre
	ll_id=getitemnumber(currentrow, 3)
	// se esiste PK ..
	if ll_id>=0 then
		//la riporto per il retrieve del detail
		dw_3.retrieve(ll_id)
	else
		dw_3.reset()
	end if
	ll_id=getitemnumber(currentrow, 3)
	if ll_id>=0 then
		dw_4.retrieve(ll_id)
		dw_5.retrieve(ll_id)
	else
		dw_4.reset()
		dw_5.reset()
	end if
	ll_id=getitemnumber(currentrow, 1)
	if ll_id>=0 then
		dw_6.retrieve(ll_id)
	else
		dw_6.reset()
	end if
else
	dw_3.reset()
	dw_4.reset()
	dw_5.reset()
end if
//setrowfocusindicator(hand!)
end event

type cb_inserisci from w_padre_figlio_nipote_cx`cb_inserisci within w_riga_collegamenti
integer x = 105
integer y = 2928
end type

type cb_salva from w_padre_figlio_nipote_cx`cb_salva within w_riga_collegamenti
integer x = 393
integer y = 2928
end type

type cb_cancella from w_padre_figlio_nipote_cx`cb_cancella within w_riga_collegamenti
integer x = 681
integer y = 2928
end type

type cb_annulla from w_padre_figlio_nipote_cx`cb_annulla within w_riga_collegamenti
integer x = 1275
integer y = 2924
end type

type cb_ok from w_padre_figlio_nipote_cx`cb_ok within w_riga_collegamenti
integer x = 1568
integer y = 2928
end type

type pb_cerca from picturebutton within w_riga_collegamenti
integer x = 3291
integer y = 72
integer width = 329
integer height = 288
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "C:\nita\icone\Ricerca.png"
alignment htextalign = left!
end type

event clicked;long ll_id, ll_riga, ll_conto, ll_id_guida
string ls_prefisso
s_ricerca s_ric
w_new_ricerca_sw w_ric_sw

s_ric.dataobject='d_doc_sw'
s_ric.titolo_finestra="Ricerca Documento"

//if ib_applica_filtro then
//	s_ric.filtro[1]=string(dw_1.getitemnumber(1, "doc_num_prog"))
//	s_ric.colonna_filtro[1]="doc_num_prog"
//	s_ric.filtro[2]=string(dw_1.getitemnumber(1, "guida_id"))
//	s_ric.colonna_filtro[2]="guida_id"
//	
//	s_ric.filtro[3]=string(dw_1.getitemnumber(1, "reg_id"))
//	s_ric.colonna_filtro[3]="reg_id"
//	ib_applica_filtro=false
//end if

openwithparm(w_ric_sw, s_ric)

if isvalid(message) then 
	ll_id=message.doubleparm
	if ll_id>0 then
		dw_1.is_sql="where documento.id_documento="+string(ll_id)+" "
		ll_riga=dw_1.retrieve()
		if ll_riga>0 then
			ll_id=dw_1.getitemnumber(1,1)
			if dw_2.retrieve(ll_id)>0 then
				dw_2.trigger event Rowfocuschanged(1)
//				ll_id=dw_2.getitemnumber(1, 2)
//				dw_3.retrieve(ll_id)
//				dw_4.retrieve(ll_id)
			end if
		end if
	end if
end if
end event

type dw_4 from udw_001 within w_riga_collegamenti
integer x = 82
integer y = 2108
integer width = 4155
integer height = 420
integer taborder = 40
boolean bringtotop = true
boolean titlebar = true
string title = "Riga da bollettina Cod barre"
string dataobject = "d_riga_da_bollettina_collegamenti"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
end type

type dw_5 from udw_001 within w_riga_collegamenti
integer x = 82
integer y = 1592
integer width = 4155
integer height = 508
integer taborder = 40
boolean bringtotop = true
boolean titlebar = true
string title = "Riga Figlia (derivazione)"
string dataobject = "d_riga_figlio_collegamenti"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
end type

type dw_6 from udw_001 within w_riga_collegamenti
integer x = 82
integer y = 2548
integer width = 4155
integer height = 640
integer taborder = 50
boolean bringtotop = true
boolean titlebar = true
string title = "Riga da bollettina Produzione"
string dataobject = "d_riga_da_bol_produzione_collegamenti"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
end type

