forward
global type w_passa_listino_sql from w_semplice_cx
end type
type cb_carica from commandbutton within w_passa_listino_sql
end type
type dw_2 from udw_001 within w_passa_listino_sql
end type
type cb_importa from commandbutton within w_passa_listino_sql
end type
type dw_3 from udw_001 within w_passa_listino_sql
end type
type cb_1 from commandbutton within w_passa_listino_sql
end type
type hpb_1 from hprogressbar within w_passa_listino_sql
end type
end forward

global type w_passa_listino_sql from w_semplice_cx
integer width = 4745
integer height = 2204
cb_carica cb_carica
dw_2 dw_2
cb_importa cb_importa
dw_3 dw_3
cb_1 cb_1
hpb_1 hpb_1
end type
global w_passa_listino_sql w_passa_listino_sql

on w_passa_listino_sql.create
int iCurrent
call super::create
this.cb_carica=create cb_carica
this.dw_2=create dw_2
this.cb_importa=create cb_importa
this.dw_3=create dw_3
this.cb_1=create cb_1
this.hpb_1=create hpb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_carica
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.cb_importa
this.Control[iCurrent+4]=this.dw_3
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.hpb_1
end on

on w_passa_listino_sql.destroy
call super::destroy
destroy(this.cb_carica)
destroy(this.dw_2)
destroy(this.cb_importa)
destroy(this.dw_3)
destroy(this.cb_1)
destroy(this.hpb_1)
end on

event open;call super::open;
dw_1.retrieve()
dw_2.settransobject(sqlca)
dw_3.settransobject(sqlca)
end event

event resize;call super::resize;dw_1.width=1554
dw_3.height=dw_1.height - 184
dw_3.y=dw_1.y +184
hpb_1.x=cb_ricerca.x -100 - hpb_1.width - cb_ricerca.width
hpb_1.y=cb_ricerca.y
end event

type cb_stampa from w_semplice_cx`cb_stampa within w_passa_listino_sql
end type

type cb_ricerca from w_semplice_cx`cb_ricerca within w_passa_listino_sql
end type

type cb_primo from w_semplice_cx`cb_primo within w_passa_listino_sql
end type

type cb_ultimo from w_semplice_cx`cb_ultimo within w_passa_listino_sql
end type

type cb_indietro from w_semplice_cx`cb_indietro within w_passa_listino_sql
end type

type cb_avanti from w_semplice_cx`cb_avanti within w_passa_listino_sql
end type

type dw_1 from w_semplice_cx`dw_1 within w_passa_listino_sql
integer width = 1554
string dataobject = "d_car_list_munna"
boolean vscrollbar = true
end type

type cb_inserisci from w_semplice_cx`cb_inserisci within w_passa_listino_sql
end type

type cb_salva from w_semplice_cx`cb_salva within w_passa_listino_sql
end type

type cb_cancella from w_semplice_cx`cb_cancella within w_passa_listino_sql
end type

type cb_annulla from w_semplice_cx`cb_annulla within w_passa_listino_sql
end type

type cb_ok from w_semplice_cx`cb_ok within w_passa_listino_sql
end type

type cb_carica from commandbutton within w_passa_listino_sql
integer x = 1623
integer y = 24
integer width = 402
integer height = 112
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Carica"
end type

event clicked;integer li_ret, i
string ls_path, ls_file
long ll_null

setnull(ll_null)
	
getfileopenname("Cerca report", ls_path, ls_file, "Excel, *.csv", "csv" , "C:\nita\exp_doc")

li_ret=dw_2.importfile(Text!,ls_file, 2, 999999)  //importo il documento
end event

type dw_2 from udw_001 within w_passa_listino_sql
boolean visible = false
integer x = 50
integer y = 1964
integer width = 2679
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_list_da_caricare_munna"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type cb_importa from commandbutton within w_passa_listino_sql
integer x = 2062
integer y = 24
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
string text = "Importa"
end type

event clicked;long i, ll_id_uc, ll_id_var, ll_riga_trovata, ll_righe
string ls_art
decimal ldc_prezzo, ldc_pr_man

ll_riga_trovata=dw_1.find("scegli='S'", 1, 999999)
if ll_riga_trovata>0 then
	ll_id_var=dw_1.getitemnumber(ll_riga_trovata, "id_variazione")
	dw_3.retrieve(ll_id_var)
	ll_righe=dw_2.rowcount()
	for i=1 to ll_righe
		ls_art=dw_2.getitemstring(i, "cod_articolo")
		if left(ls_art, 1)="'" then ls_art=right(ls_art, len(ls_art) - 1)
		if right(ls_art, 1)="'" then ls_art=left(ls_art, len(ls_art) - 1)
		ll_id_uc=0
		select id_unita_confezione into :ll_id_uc
		from dba.unita_confezione u, dba.articolo a
		where u.id_articolo=a.id_articolo and u.unita_base='S'
		and a.codice=:ls_art;
		if ll_id_uc>0 then
			ldc_prezzo=dw_2.getitemdecimal(i, "prezzo")
			ldc_pr_man=dw_2.getitemdecimal(i, "prezzo_manifattura")
			ll_riga_trovata=dw_3.find("id_unita_confezione="+string(ll_id_uc), 1, 999999)
			if ll_riga_trovata>0 then
				if ldc_pr_man>0 then dw_3.setitem(ll_riga_trovata, "prezzo_prezzo_manifattura", ldc_pr_man)
				if ldc_prezzo>0 then  dw_3.setitem(ll_riga_trovata, "prezzo_prezzo", ldc_prezzo)
			else //l'articolo NON è presente nel listino, occorre inserirlo
				ll_riga_trovata=dw_3.insertrow(0)
				dw_3.setitem(ll_riga_trovata, "id_unita_confezione", ll_id_uc)
				dw_3.setitem(ll_riga_trovata, "id_variazione", ll_id_var)
				if ldc_pr_man>0 then dw_3.setitem(ll_riga_trovata, "prezzo_prezzo_manifattura", ldc_pr_man)
				if ldc_prezzo>0 then  dw_3.setitem(ll_riga_trovata, "prezzo_prezzo", ldc_prezzo)
			end if
		end if		
		hpb_1.position= i*100 / ll_righe
	next
end if
end event

type dw_3 from udw_001 within w_passa_listino_sql
integer x = 1618
integer y = 184
integer width = 3063
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_orafo_prezzo_variaz_gd"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type cb_1 from commandbutton within w_passa_listino_sql
integer x = 2514
integer y = 24
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
string text = "SALVA"
end type

event clicked;dw_3.trigger event ue_update()
end event

type hpb_1 from hprogressbar within w_passa_listino_sql
integer x = 1979
integer y = 676
integer width = 955
integer height = 68
boolean bringtotop = true
unsignedinteger maxposition = 100
integer setstep = 10
end type

