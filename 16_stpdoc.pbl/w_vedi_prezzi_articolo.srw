forward
global type w_vedi_prezzi_articolo from w_padre_figlio_cx
end type
end forward

global type w_vedi_prezzi_articolo from w_padre_figlio_cx
integer width = 4165
integer height = 1904
end type
global w_vedi_prezzi_articolo w_vedi_prezzi_articolo

forward prototypes
public function integer wf_salva_dw (ref udw_001 adw_1, ref udw_002 adw_2, integer as_flag)
end prototypes

public function integer wf_salva_dw (ref udw_001 adw_1, ref udw_002 adw_2, integer as_flag);integer li_ret
li_ret=adw_2.triggerevent("ue_update")

return li_ret
end function

on w_vedi_prezzi_articolo.create
call super::create
end on

on w_vedi_prezzi_articolo.destroy
call super::destroy
end on

event open;long ll_id
dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)

i_dw_corrente=1
//dw_1.trigger event ue_insert(0)

dw_1.insertrow(1)
end event

type cb_ricerca from w_padre_figlio_cx`cb_ricerca within w_vedi_prezzi_articolo
boolean visible = false
integer x = 905
integer y = 1580
end type

type dw_1 from w_padre_figlio_cx`dw_1 within w_vedi_prezzi_articolo
integer x = 64
integer y = 20
integer width = 699
integer height = 220
string dataobject = "d_id_art_ext"
end type

event dw_1::itemchanged;call super::itemchanged;long ll_id_art


if long(data)>0 then
	
	 ll_id_art= long(data) //		if	messagebox("Attenzione!", "Se ci sono state modifiche DEVONO essere salvate! Ci sono state modifiche?", stopsign!, yesno!)=1 then
//			li_ret=dw_2.trigger event ue_update()
//		end if
		dw_2.retrieve(ll_id_art)
		
//	else
//		messagebox("Attenzione!", "Manca la variazione entro la quale cercare!")
	
end if
end event

event dw_1::updateend;//
end event

event dw_1::rowfocuschanged;long ll_id  //primary key del master da riportare per il retrieve del detail

//se esiste la riga
if currentrow>0 then
	//recupero la primary key dal padre
	ll_id=getitemnumber(currentrow, 1)
	// se esiste PK ..
	if ll_id>=0 then
		//la riporto per il retrieve del detail
		dw_2.retrieve(ll_id)
	else
		dw_2.reset()
	end if
else
	dw_2.reset()
end if
//setrowfocusindicator(hand!)
end event

type dw_2 from w_padre_figlio_cx`dw_2 within w_vedi_prezzi_articolo
integer x = 64
integer y = 272
integer width = 4014
integer height = 1240
string dataobject = "d_orafo_listino_var_base_art_gd"
end type

event dw_2::itemchanged;call super::itemchanged;

if dwo.name="prezzo" then
	post setitem(row, "ultima_modifica", today())
end if
end event

type cb_inserisci from w_padre_figlio_cx`cb_inserisci within w_vedi_prezzi_articolo
boolean visible = false
integer x = 27
integer y = 1580
end type

type cb_salva from w_padre_figlio_cx`cb_salva within w_vedi_prezzi_articolo
integer x = 315
integer y = 1580
end type

event cb_salva::clicked;
wf_salva_dw(dw_1, dw_2, 2)

end event

type cb_cancella from w_padre_figlio_cx`cb_cancella within w_vedi_prezzi_articolo
boolean visible = false
integer x = 603
integer y = 1580
end type

type cb_annulla from w_padre_figlio_cx`cb_annulla within w_vedi_prezzi_articolo
integer x = 1198
integer y = 1576
end type

type cb_ok from w_padre_figlio_cx`cb_ok within w_vedi_prezzi_articolo
integer x = 1495
integer y = 1580
end type

