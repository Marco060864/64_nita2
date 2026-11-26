forward
global type w_confronta_prezzi_2013 from w_testa_righe_cx
end type
type dw_3 from udw_base within w_confronta_prezzi_2013
end type
type dw_4 from udw_base within w_confronta_prezzi_2013
end type
type cb_1 from commandbutton within w_confronta_prezzi_2013
end type
type cb_2 from commandbutton within w_confronta_prezzi_2013
end type
type cb_3 from commandbutton within w_confronta_prezzi_2013
end type
type cb_canc from commandbutton within w_confronta_prezzi_2013
end type
type cb_4 from commandbutton within w_confronta_prezzi_2013
end type
end forward

global type w_confronta_prezzi_2013 from w_testa_righe_cx
integer width = 5682
integer height = 2864
dw_3 dw_3
dw_4 dw_4
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
cb_canc cb_canc
cb_4 cb_4
end type
global w_confronta_prezzi_2013 w_confronta_prezzi_2013

event open;call super::open;dw_3.settransobject(sqlca)
dw_4.settransobject(sqlca)

dw_3.retrieve()
end event

on w_confronta_prezzi_2013.create
int iCurrent
call super::create
this.dw_3=create dw_3
this.dw_4=create dw_4
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.cb_canc=create cb_canc
this.cb_4=create cb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_3
this.Control[iCurrent+2]=this.dw_4
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.cb_2
this.Control[iCurrent+5]=this.cb_3
this.Control[iCurrent+6]=this.cb_canc
this.Control[iCurrent+7]=this.cb_4
end on

on w_confronta_prezzi_2013.destroy
call super::destroy
destroy(this.dw_3)
destroy(this.dw_4)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.cb_canc)
destroy(this.cb_4)
end on

type st_1 from w_testa_righe_cx`st_1 within w_confronta_prezzi_2013
end type

type dw_1 from w_testa_righe_cx`dw_1 within w_confronta_prezzi_2013
integer x = 41
integer y = 40
integer width = 2249
integer height = 428
string dataobject = "d_listini_siverp2013"
end type

event dw_1::rowfocuschanged;long ll_id
integer li_test  



if currentrow>0 then
	
	ll_id=getitemnumber(currentrow, 1)
	
	if ll_id>0 then
		dw_2.retrieve(ll_id)
		
		
	else
		dw_2.reset()
	end if
end if
setrowfocusindicator(hand!)
	
end event

type dw_2 from w_testa_righe_cx`dw_2 within w_confronta_prezzi_2013
integer y = 492
integer width = 5266
integer height = 744
string dataobject = "d_prezzi_silverp2018"
boolean hscrollbar = true
end type

type cb_inserisci from w_testa_righe_cx`cb_inserisci within w_confronta_prezzi_2013
integer x = 443
integer y = 2596
end type

type cb_salva from w_testa_righe_cx`cb_salva within w_confronta_prezzi_2013
integer x = 4215
integer y = 2588
end type

event cb_salva::clicked;integer li_ret

li_ret=dw_4.trigger event ue_update()
end event

type cb_cancella from w_testa_righe_cx`cb_cancella within w_confronta_prezzi_2013
integer x = 1015
integer y = 2596
end type

type cb_annulla from w_testa_righe_cx`cb_annulla within w_confronta_prezzi_2013
integer x = 1504
integer y = 2596
end type

type cb_ok from w_testa_righe_cx`cb_ok within w_confronta_prezzi_2013
integer x = 1792
integer y = 2596
end type

type dw_3 from udw_base within w_confronta_prezzi_2013
integer x = 3488
integer y = 48
integer width = 1943
integer height = 364
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_variazione_lt"
end type

event rowfocuschanged;call super::rowfocuschanged;long ll_id
integer li_test  



if currentrow>0 then
	
	ll_id=getitemnumber(currentrow, "variazione_id_variazione")
	
	if ll_id>0 then
		dw_4.retrieve(ll_id)
		
		
	else
		dw_4.reset()
	end if
end if
setrowfocusindicator(hand!)
end event

type dw_4 from udw_base within w_confronta_prezzi_2013
integer x = 105
integer y = 1252
integer width = 5230
integer height = 1180
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_ges_listino_silver"
boolean hscrollbar = true
end type

type cb_1 from commandbutton within w_confronta_prezzi_2013
integer x = 3191
integer y = 2592
integer width = 320
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Confronta"
end type

event clicked;long i, ll_righe, ll_righe4, ll_riga, ll_id_uc, ll_id_art
string ls_cod_art, ls_find

ll_righe=dw_2.rowcount()
ll_righe4=dw_4.rowcount()

for i =  ll_righe to 1 step -1
	select id_articolo
	into :ll_id_art
	from dba.articolo
	where codice=:ls_cod_art;
	if ll_id_art>0 then
	
		ls_cod_art=dw_2.getitemstring(i, "articolo_pr_codice")
		ls_find="articolo_codice='"+ls_cod_art+"'"

		ll_riga=dw_4.find(ls_find, 1, ll_righe4)
		if ll_riga>0 then
			dw_2.deleterow(i)		
		end if
	else
		dw_2.deleterow(i)	
	end if
next
end event

type cb_2 from commandbutton within w_confronta_prezzi_2013
integer x = 3593
integer y = 2588
integer width = 521
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Passa da 2013 a 2014"
end type

event clicked;long i, ll_righe, ll_righe3, ll_riga_inserita, ll_id_uc, ll_id_var
string ls_cod_art, ls_des1, ls_des2, ls_des3
decimal ldc_prezzo, ldc_pr_man, ldc_calo, ldc_imballo, ldc_galv
datetime ldt_ult_modifica

ll_righe=dw_2.rowcount()
ll_righe3=dw_3.getrow()
ll_id_var=dw_3.getitemnumber(ll_righe3, "variazione_id_variazione")
	
for i =  1 to ll_righe 
	ls_cod_art=dw_2.getitemstring(i, "articolo_pr_codice")
	ll_id_uc=0
	select id_unita_confezione
	into :ll_id_uc
	from articolo a, unita_confezione u
	where u.id_articolo=a.id_articolo
	and u.unita_base='S'
	and a.codice=:ls_cod_art
	;
	if ll_id_uc>0 then
		ldc_prezzo=dw_2.getitemdecimal(i, "prezzo_pr_prezzo")
		ldc_calo=dw_2.getitemdecimal(i, "prezzo_pr_coef_calo")
		ldc_pr_man=dw_2.getitemdecimal(i, "prezzo_pr_prezzo_manifattura")
		ldc_imballo=dw_2.getitemdecimal(i, "prezzo_pr_costo_imballo")
		ldc_galv=dw_2.getitemdecimal(i, "prezzo_pr_galvanica")
		ls_des1=dw_2.getitemstring(i, "prezzo_pr_des_1")
		ls_des2=dw_2.getitemstring(i, "prezzo_pr_des_2")
		ls_des3=dw_2.getitemstring(i, "prezzo_pr_des_3")
		ldt_ult_modifica=dw_2.getitemdatetime(i, "prezzo_pr_ultima_modifica")
		if isnull(ldt_ult_modifica) or ldt_ult_modifica<datetime("1980/01/01 00:00:00") then
			ldt_ult_modifica=datetime(today())
		end if
		
		ll_riga_inserita=dw_4.trigger event ue_insert(0)
		dw_4.setitem(ll_riga_inserita, "prezzo_id_unita_confezione", ll_id_uc)
		dw_4.setitem(ll_riga_inserita,"prezzo_id_variazione", ll_id_var)
		
		dw_4.setitem(ll_riga_inserita,"prezzo_prezzo", ldc_prezzo)
		dw_4.setitem(ll_riga_inserita,"prezzo_coef_calo", ldc_calo)
		dw_4.setitem(ll_riga_inserita,"prezzo_prezzo_manifattura", ldc_pr_man)
		dw_4.setitem(ll_riga_inserita,"prezzo_costo_imballo", ldc_imballo)
		dw_4.setitem(ll_riga_inserita,"prezzo_galvanica", ldc_galv)
		dw_4.setitem(ll_riga_inserita,"prezzo_des_1", ls_des1)
		
		dw_4.setitem(ll_riga_inserita,"prezzo_des_2", ls_des2)
		dw_4.setitem(ll_riga_inserita,"prezzo_des_3", ls_des3)
		dw_4.setitem(ll_riga_inserita,"prezzo_ultima_modifica", ldt_ult_modifica)
		
		dw_4.setitem(ll_riga_inserita,"articolo_codice", ls_cod_art)
	end if
		
	
next
end event

type cb_3 from commandbutton within w_confronta_prezzi_2013
integer x = 2661
integer y = 2556
integer width = 320
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "sort"
end type

event clicked;dw_4.setsort("prezzo_id_unita_confezione")
dw_4.sort()
end event

type cb_canc from commandbutton within w_confronta_prezzi_2013
integer x = 2642
integer y = 2672
integer width = 320
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "canc"
end type

event clicked;long ll_riga



ll_riga=dw_4.find("prezzo_id_unita_confezione=prezzo_id_unita_confezione[-1]", 1, dw_4.rowcount())

if ll_riga>0 then
	dw_4.scrolltorow(ll_riga)
	if messagebox("RIGA:"+string(ll_riga), "CANCELLI?", stopsign!, yesno!)=1 then
		dw_4.deleterow(ll_riga)
	end if
end if
end event

type cb_4 from commandbutton within w_confronta_prezzi_2013
integer x = 2693
integer y = 332
integer width = 713
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Passa da pippo a prezzo LISA"
end type

event clicked;long i, ll_righe, ll_riga_trovata, ll_id_uc, ll_id_var, ll_righe4
string ls_confermato, ls_des1, ls_des2, ls_des3
decimal ldc_prezzo, ldc_pr_man
datetime ldt_ult_modifica

ll_righe=dw_2.rowcount()
ll_id_var=dw_2.getitemnumber(ll_righe, "id_variazione")
ll_righe4=dw_4.rowcount()
ldt_ult_modifica=datetime(today())
for i =  1 to ll_righe 
	
	ll_id_uc=dw_2.getitemnumber(i, "id_unita_confezione")
	ll_riga_trovata=dw_4.find("prezzo_id_unita_confezione= "+string(ll_id_uc), 1, ll_righe4)
	if ll_riga_trovata>0 then
		ls_confermato=dw_4.getitemstring(ll_riga_trovata, "prezzo_confermato")
		if ls_confermato='S' then 
			continue
		else
			ldc_prezzo=dw_2.getitemdecimal(i, "prezzopippo")
			
			ldc_pr_man=dw_2.getitemdecimal(i, "prezzopippo_manifattura")
			ls_des3=dw_2.getitemstring(i, "des_3")
	
					
			dw_4.setitem(ll_riga_trovata,"prezzo_prezzo", ldc_prezzo)
			dw_4.setitem(ll_riga_trovata,"prezzo_prezzo_manifattura", ldc_pr_man)
			dw_4.setitem(ll_riga_trovata,"prezzo_des_3", ls_des3)
			dw_4.setitem(ll_riga_trovata,"prezzo_ultima_modifica", ldt_ult_modifica)
		end if
	end if
		
	
next
end event

