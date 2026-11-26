forward
global type w_stampa_ordine_st from window
end type
type dw_2 from datawindow within w_stampa_ordine_st
end type
type cb_2 from commandbutton within w_stampa_ordine_st
end type
type cb_7 from commandbutton within w_stampa_ordine_st
end type
type cb_6 from commandbutton within w_stampa_ordine_st
end type
type cb_5 from commandbutton within w_stampa_ordine_st
end type
type cb_4 from commandbutton within w_stampa_ordine_st
end type
type dw_1 from datawindow within w_stampa_ordine_st
end type
type cb_3 from commandbutton within w_stampa_ordine_st
end type
type cb_1 from commandbutton within w_stampa_ordine_st
end type
end forward

global type w_stampa_ordine_st from window
integer x = 55
integer y = 365
integer width = 3562
integer height = 1562
boolean titlebar = true
string title = "Lista Ordini a Fornitori"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = popup!
windowstate windowstate = maximized!
long backcolor = 79741120
event ue_post_open ( )
dw_2 dw_2
cb_2 cb_2
cb_7 cb_7
cb_6 cb_6
cb_5 cb_5
cb_4 cb_4
dw_1 dw_1
cb_3 cb_3
cb_1 cb_1
end type
global w_stampa_ordine_st w_stampa_ordine_st

type variables
integer il_zoom
string is_testa

end variables

forward prototypes
public subroutine wf_recupera_prezzo (long al_righe)
public function decimal wf_storna_ordinato (datawindow dw_ordini)
end prototypes

event ue_post_open();datawindowchild dwc_titolo
integer rtncode

dw_1.sort()
dw_1.Height=(this.Height) - 272
dw_1.Object.DataWindow.Print.preview='yes'

rtncode = dw_1.GetChild('id_titolo', dwc_titolo)
IF rtncode = -1 THEN MessageBox("Error", "Not a DataWindowChild")
dwc_titolo.SetTransObject(SQLCA)
dwc_titolo.Retrieve()

dw_1.setitem(1,'c_articolo_des',is_testa)


	


end event

public subroutine wf_recupera_prezzo (long al_righe);integer i
long ll_id_uc, ll_id_sog, ll_id_listino, ll_id_variazione
decimal ldc_pr_man, ldc_prezzo


for i= 1 to al_righe
	
	ll_id_sog=dw_1.getitemnumber(1, "id_sog_commerciale")
	select id_listino
	into :ll_id_listino
	from sog_commerciale
	where id_sog_commerciale=:ll_id_sog
	;
	if ll_id_listino>0 then
		select id_variazione
		into :ll_id_variazione
		from variazione
		where data_inizio<=today()
		and (data_fine is null or data_fine>= today())
		and id_listino= :ll_id_listino;
		
	else
		select id_variazione
		into :ll_id_variazione
		from variazione v, listino l
		where data_inizio<=today()
		and (data_fine is null or data_fine>= today())
		and l.lis_base='S' and l.tipo='A'
		and v.id_listino=l.id_listino;
	end if
	
	
	ll_id_uc=dw_1.getitemnumber(i, "id_unita_confezione")
	select prezzo_manifattura, prezzo
	into :ldc_pr_man, :ldc_prezzo
	from prezzo
	where id_variazione=:ll_id_variazione
	and id_unita_confezione=:ll_id_uc
	;
	if ldc_pr_man>0 then
		ldc_prezzo=ldc_pr_man
	end if
	dw_1.setitem(i, "prezzo", ldc_prezzo)
next
end subroutine

public function decimal wf_storna_ordinato (datawindow dw_ordini);//devo trovare eventuali ordini gia ordinati al fornitore per aggiungere le loro qta alla disponibilità
//secondo la richiesta di samy 150612
INTEGER I, A
STRING ls_bollo
long ll_id_art,ll_id_ordine, ll_righe
decimal ldc_peso
datastore ds_trova_peso_ordinato

ds_trova_peso_ordinato=create datastore
ds_trova_peso_ordinato.dataobject="d_prod_trova_art_prodotto_gd"
ds_trova_peso_ordinato.SetTransObject(sqlca)

FOR I= 1 TO DW_1.ROWCOUNT()
	ll_id_art=dw_1.getitemnumber(i, "id_articolo")
	LS_BOLLO=dw_1.getitemSTRING(i, "SIGLA_PREZZO")
	if isnull(ls_bollo) or ls_bollo<" " then ls_bollo="X"
	//adesso giro per trovare gli ordini già passati
	dw_ordini.setfilter("documento_ordinato_fo='S'")
	dw_ordini.filter()
	for a= 1 to dw_ordini.rowcount()
		ds_trova_peso_ordinato.setfilter("c_bollo='"+ls_bollo+"'")
		ds_trova_peso_ordinato.filter()
		ll_id_ordine=dw_ordini.getitemnumber(a, "id_documento")
		//ora trovo il peso già ordinato ...
		ll_righe=ds_trova_peso_ordinato.retrieve(ll_id_ordine, ll_id_art)
		if ll_righe>0 then
			ldc_peso=ds_trova_peso_ordinato.getitemdecimal(ll_righe, "c_somma_peso")
		end if
		
	next
	if ldc_peso>0 then
		dw_1.setitem(i, "cmc", ldc_peso)
		ldc_peso=0
	end if
next
destroy ds_trova_peso_ordinato
return 2
end function

event open;
s_ordine_fornitori pass_dati
string ll_num[], ls_rag[]
integer i
date ld_date[]
string  LS_BOLLO
decimal ldc_prova
long ll_id_art

pass_dati=message.powerobjectparm


ll_num=pass_dati.num_doc
ld_date=pass_dati.data_reg
ls_rag=pass_dati.rag_sociale

if pass_dati.personalizza='V' then
	dw_1.dataobject="d_stampa_ordini_vener_gd"
	is_testa=''
	for i=1 to UpperBound ( pass_dati.num_prog )
		is_testa=is_testa + string(pass_dati.num_prog[i])+ ',  '
	next
	
else
	is_testa=''
	for i=1 to UpperBound ( ll_num )
		is_testa=is_testa + "Cliente: "+ls_rag[i]+   ' - Num.  '+ ll_num[i] + '  del  ' +  string(ld_date[i]) + ',  '
	next
	
end if




is_testa=left(is_testa, len(is_testa) - 3)
dw_1.SetTransObject(sqlca)
dw_2.SetTransObject(sqlca)
dw_2.insertrow(1)
pass_dati.dw_righe.RowsCopy (1, pass_dati.dw_righe.rowcount(), primary!, dw_1, 1, 	primary! )

//190612 devo sotrnare dal conteggio della disponibilita gli ordini già passati
//perché si considerano già ordinati al fornitore e quindi già disponibili
//Modifica sospesa fino a chiarimento
//wf_storna_ordinato(pass_dati.dw_ORDINI )
 
//sposto in ue_post_open 261012
//dw_1.setitem(1,'c_articolo_des',is_testa)
//261012 samy non lo vuole più ...meglio ...
//wf_recupera_prezzo(pass_dati.dw_righe.rowcount())


il_zoom=100
this.event post ue_post_open()

end event

on w_stampa_ordine_st.create
this.dw_2=create dw_2
this.cb_2=create cb_2
this.cb_7=create cb_7
this.cb_6=create cb_6
this.cb_5=create cb_5
this.cb_4=create cb_4
this.dw_1=create dw_1
this.cb_3=create cb_3
this.cb_1=create cb_1
this.Control[]={this.dw_2,&
this.cb_2,&
this.cb_7,&
this.cb_6,&
this.cb_5,&
this.cb_4,&
this.dw_1,&
this.cb_3,&
this.cb_1}
end on

on w_stampa_ordine_st.destroy
destroy(this.dw_2)
destroy(this.cb_2)
destroy(this.cb_7)
destroy(this.cb_6)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.dw_1)
destroy(this.cb_3)
destroy(this.cb_1)
end on

event key;

keycode			lk_code
string			ls_nome
windowobject	lw_me

lk_code = key

choose case lk_code
	case KeyF12!
		if keyflags=3 then
			ls_nome = this.ClassName()
			MessageBox ("ClassName",ls_nome)
		end if
	case KeyF1!
		if (keyflags = 0 Or keyflags = 1 Or keyflags = 2) then
		end if
end choose
end event

event resize;dw_1.width=newwidth - 80
dw_1.height=newheight - 200
end event

type dw_2 from datawindow within w_stampa_ordine_st
integer x = 369
integer y = 10
integer width = 530
integer height = 160
integer taborder = 10
string title = "none"
string dataobject = "d_cat_codifica_ordini_ext"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;long ll_id_cat_codifica
string ls_filter

if data> " " then
	//ll_id_cat_codifica=long(data)
	ls_filter="c_id_cat_codifica="+data
	
else
	ls_filter=""
end if
dw_1.setfilter(ls_filter)
dw_1.filter()
dw_1.sort()
dw_1.groupcalc()
end event

type cb_2 from commandbutton within w_stampa_ordine_st
integer x = 2472
integer y = 45
integer width = 388
integer height = 90
integer taborder = 31
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salva su &File"
end type

event clicked;dw_1.SaveAs()
end event

type cb_7 from commandbutton within w_stampa_ordine_st
event clicked pbm_bnclicked
integer x = 1997
integer y = 45
integer width = 260
integer height = 90
integer taborder = 30
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Zoom Out"
end type

event clicked;il_zoom=il_zoom - 10
dw_1.object.datawindow.zoom=il_zoom
end event

type cb_6 from commandbutton within w_stampa_ordine_st
event clicked pbm_bnclicked
integer x = 1723
integer y = 45
integer width = 260
integer height = 90
integer taborder = 40
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Zoom In"
end type

event clicked;il_zoom=il_zoom+10
dw_1.object.datawindow.zoom=il_zoom
end event

type cb_5 from commandbutton within w_stampa_ordine_st
integer x = 1474
integer y = 45
integer width = 102
integer height = 90
integer taborder = 50
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "<"
end type

event clicked;dw_1.ScrollPriorPage ( ) 
end event

type cb_4 from commandbutton within w_stampa_ordine_st
integer x = 1587
integer y = 45
integer width = 102
integer height = 90
integer taborder = 20
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = ">"
end type

event clicked;dw_1.ScrollNextPage ( ) 
end event

type dw_1 from datawindow within w_stampa_ordine_st
integer x = 18
integer y = 173
integer width = 3441
integer height = 1261
integer taborder = 60
string dataobject = "d_stampa_ordini_gd"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event sqlpreview;
end event

type cb_3 from commandbutton within w_stampa_ordine_st
integer x = 2882
integer y = 45
integer width = 249
integer height = 90
integer taborder = 10
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stam&pa"
end type

event clicked;printsetup()
dw_1.print()
end event

type cb_1 from commandbutton within w_stampa_ordine_st
integer x = 22
integer y = 45
integer width = 249
integer height = 90
integer taborder = 70
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Annulla"
end type

event clicked;close(parent)
end event

