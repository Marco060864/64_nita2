forward
global type w_dati_contabili_rpt from window
end type
type cbx_2 from checkbox within w_dati_contabili_rpt
end type
type st_attendere from statictext within w_dati_contabili_rpt
end type
type cbx_filtro from checkbox within w_dati_contabili_rpt
end type
type dw_2 from datawindow within w_dati_contabili_rpt
end type
type pb_1 from picturebutton within w_dati_contabili_rpt
end type
type cbx_1 from checkbox within w_dati_contabili_rpt
end type
type cbx_ordina from checkbox within w_dati_contabili_rpt
end type
type cb_1 from commandbutton within w_dati_contabili_rpt
end type
type cb_pg_prima from commandbutton within w_dati_contabili_rpt
end type
type cb_pg_dopo from commandbutton within w_dati_contabili_rpt
end type
type cb_preview from commandbutton within w_dati_contabili_rpt
end type
type cb_stampa from commandbutton within w_dati_contabili_rpt
end type
type cb_imp_st from commandbutton within w_dati_contabili_rpt
end type
type cb_6 from commandbutton within w_dati_contabili_rpt
end type
type cb_7 from commandbutton within w_dati_contabili_rpt
end type
type cb_salva_su_file from commandbutton within w_dati_contabili_rpt
end type
type sle_zoom from singlelineedit within w_dati_contabili_rpt
end type
type sle_copie from singlelineedit within w_dati_contabili_rpt
end type
type st_2 from statictext within w_dati_contabili_rpt
end type
type st_1 from statictext within w_dati_contabili_rpt
end type
type sle_pg from singlelineedit within w_dati_contabili_rpt
end type
type dw_1 from datawindow within w_dati_contabili_rpt
end type
end forward

global type w_dati_contabili_rpt from window
integer x = 22
integer y = 13
integer width = 3584
integer height = 1821
boolean titlebar = true
string title = "Stampa Dati Contabili"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = popup!
long backcolor = 79741120
event ue_post_open ( )
cbx_2 cbx_2
st_attendere st_attendere
cbx_filtro cbx_filtro
dw_2 dw_2
pb_1 pb_1
cbx_1 cbx_1
cbx_ordina cbx_ordina
cb_1 cb_1
cb_pg_prima cb_pg_prima
cb_pg_dopo cb_pg_dopo
cb_preview cb_preview
cb_stampa cb_stampa
cb_imp_st cb_imp_st
cb_6 cb_6
cb_7 cb_7
cb_salva_su_file cb_salva_su_file
sle_zoom sle_zoom
sle_copie sle_copie
st_2 st_2
st_1 st_1
sle_pg sle_pg
dw_1 dw_1
end type
global w_dati_contabili_rpt w_dati_contabili_rpt

type variables
integer ii_zoom=100
s_param_articoli s_parametri
end variables

forward prototypes
public subroutine wf_aggiungi_conto_saldo_precedente ()
end prototypes

public subroutine wf_aggiungi_conto_saldo_precedente ();LONG LL_ID_CONTO, ll_righe, i, ll_riga, ll_id_valuta
DATASTORE DS_CONTO
DATE LDT_DATA_INIZIO, LDT_DATA_FINE
decimal ldc_saldo
string ls_codice, ls_des
long ll_id_prof_reg_apertura


st_attendere.visible=true
setredraw(false)
DS_CONTO=CREATE DATASTORE
DS_CONTO.DATAOBJECT="D_LISTA_CONTO_GD"
DS_CONTO.SETTRANSOBJECT(SQLCA)
ll_righe=DS_CONTO.RETRIEVE(s_parametri.da_sog_comm, s_parametri.a_sog_comm)

select data_inizio, data_fine
into :LDT_DATA_INIZIO, :LDT_DATA_FINE
from esercizio
where id_esercizio=:s_parametri.ll_magazzino;

LDT_DATA_INIZIO=relativedate(LDT_DATA_INIZIO, -1)

select data_inizio, data_fine
into :LDT_DATA_INIZIO, :LDT_DATA_FINE
from esercizio
where data_fine= :LDT_DATA_INIZIO;


for i= 1 to ll_righe
	ldc_saldo=0
	LL_ID_CONTO=ds_conto.getitemnumber(i, "id_conto")
	if dw_1.find("conto_id_conto="+string(LL_ID_CONTO), 1, dw_1.rowcount())<=0 then 
		ls_codice=ds_conto.getitemstring(i, "codice")
		ls_des=ds_conto.getitemstring(i, "descrizione")
		select ifnull(sum(dare), 0, sum(dare)) - ifnull(sum(avere), 0, sum(avere)), max(r.id_VALUTA)
		into :ldc_saldo, :ll_id_valuta
		from dba.mov_contabile m, reg_pd r
		where r.data_competenza>= :LDT_DATA_INIZIO
		and r.data_competenza<= :LDT_DATA_FINE
		and m.id_conto=:LL_ID_CONTO
		and m.id_reg_pd=r.id_reg_pd
		;
		if ldc_saldo<>0 AND NOT ISNULL(ldc_saldo) then
			//inserisco la riga
			ll_riga=dw_1.insertrow(0)
			dw_1.setitem(ll_riga, "conto_codice", ls_codice)
			dw_1.setitem(ll_riga, "conto_descrizione", ls_des)
			dw_1.setitem(ll_riga, "mastro_codice", left(ls_codice, 2))
			dw_1.setitem(ll_riga, "c_saldo_manuale", ldc_saldo)
			dw_1.setitem(ll_riga, "id_valuta", ll_id_valuta)
				
			
		end if
	end if
next
//rifaccio il sort e il groupcalc
dw_1.sort()
dw_1.groupcalc()
st_attendere.visible=false
setredraw(true)
destroy ds_conto
end subroutine

on w_dati_contabili_rpt.create
this.cbx_2=create cbx_2
this.st_attendere=create st_attendere
this.cbx_filtro=create cbx_filtro
this.dw_2=create dw_2
this.pb_1=create pb_1
this.cbx_1=create cbx_1
this.cbx_ordina=create cbx_ordina
this.cb_1=create cb_1
this.cb_pg_prima=create cb_pg_prima
this.cb_pg_dopo=create cb_pg_dopo
this.cb_preview=create cb_preview
this.cb_stampa=create cb_stampa
this.cb_imp_st=create cb_imp_st
this.cb_6=create cb_6
this.cb_7=create cb_7
this.cb_salva_su_file=create cb_salva_su_file
this.sle_zoom=create sle_zoom
this.sle_copie=create sle_copie
this.st_2=create st_2
this.st_1=create st_1
this.sle_pg=create sle_pg
this.dw_1=create dw_1
this.Control[]={this.cbx_2,&
this.st_attendere,&
this.cbx_filtro,&
this.dw_2,&
this.pb_1,&
this.cbx_1,&
this.cbx_ordina,&
this.cb_1,&
this.cb_pg_prima,&
this.cb_pg_dopo,&
this.cb_preview,&
this.cb_stampa,&
this.cb_imp_st,&
this.cb_6,&
this.cb_7,&
this.cb_salva_su_file,&
this.sle_zoom,&
this.sle_copie,&
this.st_2,&
this.st_1,&
this.sle_pg,&
this.dw_1}
end on

on w_dati_contabili_rpt.destroy
destroy(this.cbx_2)
destroy(this.st_attendere)
destroy(this.cbx_filtro)
destroy(this.dw_2)
destroy(this.pb_1)
destroy(this.cbx_1)
destroy(this.cbx_ordina)
destroy(this.cb_1)
destroy(this.cb_pg_prima)
destroy(this.cb_pg_dopo)
destroy(this.cb_preview)
destroy(this.cb_stampa)
destroy(this.cb_imp_st)
destroy(this.cb_6)
destroy(this.cb_7)
destroy(this.cb_salva_su_file)
destroy(this.sle_zoom)
destroy(this.sle_copie)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.sle_pg)
destroy(this.dw_1)
end on

event open;string ls_test
   
s_parametri=message.powerobjectparm



if isnull(s_parametri.filtro) then s_parametri.filtro='Nessun filtro'
if isnull(s_parametri.ll_magazzino) then
	select id_esercizio
	into :s_parametri.ll_magazzino
	from azienda;
end if
if isnull(s_parametri.a_data) then  
	select data_fine
	into :s_parametri.a_data
	from esercizio
	where id_esercizio=:s_parametri.ll_magazzino;
end if
dw_1.dataobject=s_parametri.tipo_stampa
dw_1.settransobject(sqlca)
if s_parametri.tipo_stampa="d_dati_contabili_no_ese_rpt" then
	dw_1.retrieve(s_parametri.ll_magazzino, s_parametri.a_data, s_parametri.filtro,s_parametri.da_data)
else
	dw_1.retrieve(s_parametri.ll_magazzino, s_parametri.a_data, s_parametri.filtro)
end if
post wf_aggiungi_conto_saldo_precedente()
end event

event resize;dw_1.height=newheight - 264
dw_1.width=newwidth - 75

end event

type cbx_2 from checkbox within w_dati_contabili_rpt
integer x = 1353
integer y = 131
integer width = 322
integer height = 99
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Vedi Righe"
boolean lefttext = true
end type

event clicked;if checked then
	dw_1.modify("datawindow.detail.height = 72")
else
	dw_1.modify("datawindow.detail.height = 0")
end if
end event

type st_attendere from statictext within w_dati_contabili_rpt
boolean visible = false
integer x = 1697
integer y = 157
integer width = 1818
integer height = 80
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 65535
string text = "Attendere prego ... l~'operazione potrebbe richiedere qualche minuto!"
alignment alignment = center!
boolean focusrectangle = false
end type

type cbx_filtro from checkbox within w_dati_contabili_rpt
integer x = 856
integer y = 131
integer width = 453
integer height = 99
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Escludi saldo = 0"
boolean lefttext = true
end type

event clicked;if checked then
	dw_1.setfilter("saldo_finale <> 0")
	dw_1.filter()
	dw_1.sort()
	dw_1.groupcalc()
else
	dw_1.setfilter("")
	dw_1.filter()
	dw_1.sort()
	dw_1.groupcalc()
end if
end event

type dw_2 from datawindow within w_dati_contabili_rpt
boolean visible = false
integer x = 223
integer y = 493
integer width = 2534
integer height = 1123
integer taborder = 130
string title = "none"
string dataobject = "d_salva_cl_fo_excel"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type pb_1 from picturebutton within w_dati_contabili_rpt
integer x = 2721
integer y = 16
integer width = 121
integer height = 122
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "S:\pb\notip.bmp"
alignment htextalign = left!
end type

event clicked;integer i
long ll_riga_inserita
boolean lb_found
long ll_breakrow
string ls_test, ls_conto


dw_2.settransobject(sqlca)
dw_2.reset()

lb_found = FALSE
ll_breakrow = 0

DO WHILE NOT (lb_found)
    ll_breakrow = dw_1.FindGroupChange(ll_breakrow, 2)
    // If no breaks are found, exit.
    IF ll_breakrow <= 0 THEN EXIT

	
	ls_conto=dw_1.GetItemstring(ll_breakrow, "conto_codice")
	if left(ls_conto, 2)<>ls_test and ls_test>" " then
		ll_riga_inserita=dw_2.insertrow(0)
		dw_2.setitem(ll_riga_inserita, "codice", ls_test) 
		dw_2.setitem(ll_riga_inserita, "descrizione", dw_1.GetItemstring(ll_breakrow - 1,"mastro_descrizione") )
		dw_2.setitem(ll_riga_inserita, "saldoiniziale", dw_1.GetItemdecimal(ll_breakrow - 1, "c_saldo_1") )
		dw_2.setitem(ll_riga_inserita, "tot_dare", dw_1.GetItemdecimal(ll_breakrow - 1, "c_tot_dare_1") )
		dw_2.setitem(ll_riga_inserita, "tot_avere", dw_1.GetItemdecimal(ll_breakrow - 1, "c_tot_avere_1"))
		dw_2.setitem(ll_riga_inserita, "saldo_finale", dw_1.GetItemdecimal(ll_breakrow - 1, "c_saldo_finale_1"))
	end if
	ll_riga_inserita=dw_2.insertrow(0)
	dw_2.setitem(ll_riga_inserita, "codice", ls_conto) 
	dw_2.setitem(ll_riga_inserita, "descrizione", dw_1.GetItemstring(ll_breakrow, "conto_descrizione_1") )
	dw_2.setitem(ll_riga_inserita, "saldoiniziale", dw_1.GetItemdecimal(ll_breakrow, "saldo_iniziale") )
	dw_2.setitem(ll_riga_inserita, "tot_dare", dw_1.GetItemdecimal(ll_breakrow, "somma_dare") )
	dw_2.setitem(ll_riga_inserita, "tot_avere", dw_1.GetItemdecimal(ll_breakrow, "somma_avere"))
	dw_2.setitem(ll_riga_inserita, "saldo_finale", dw_1.GetItemdecimal(ll_breakrow, "saldo_finale"))
   

	
	ls_test=left(ls_conto, 2)
	 
	 
	  // Increment starting row to find next break
    ll_breakrow = ll_breakrow + 1
LOOP
dw_2.SaveAs("", excel8!, true)
end event

event rbuttondown;integer i
long ll_riga_inserita
boolean lb_found
long ll_breakrow
string ls_test, ls_conto, ls_indirizzo, ls_pi, ls_telefono
long ll_ana
string ls_cap, ls_loc, ls_pr

dw_2.dataobject="d_salva_cl_fo_piu_dati_excel"
dw_2.settransobject(sqlca)
dw_2.reset()

lb_found = FALSE
ll_breakrow = 0

DO WHILE NOT (lb_found)
    ll_breakrow = dw_1.FindGroupChange(ll_breakrow, 2)
    // If no breaks are found, exit.
    IF ll_breakrow <= 0 THEN EXIT

	
	ls_conto=dw_1.GetItemstring(ll_breakrow, "conto_codice")
	if left(ls_conto, 2)<>ls_test and ls_test>" " then
		ll_riga_inserita=dw_2.insertrow(0)
		dw_2.setitem(ll_riga_inserita, "codice", ls_test) 
		dw_2.setitem(ll_riga_inserita, "descrizione", dw_1.GetItemstring(ll_breakrow - 1,"mastro_descrizione") )
		dw_2.setitem(ll_riga_inserita, "saldoiniziale", dw_1.GetItemdecimal(ll_breakrow - 1, "c_saldo_1") )
		dw_2.setitem(ll_riga_inserita, "tot_dare", dw_1.GetItemdecimal(ll_breakrow - 1, "c_tot_dare_1") )
		dw_2.setitem(ll_riga_inserita, "tot_avere", dw_1.GetItemdecimal(ll_breakrow - 1, "c_tot_avere_1"))
		dw_2.setitem(ll_riga_inserita, "saldo_finale", dw_1.GetItemdecimal(ll_breakrow - 1, "c_saldo_finale_1"))
	end if
	ll_riga_inserita=dw_2.insertrow(0)
	dw_2.setitem(ll_riga_inserita, "codice", ls_conto) 
	dw_2.setitem(ll_riga_inserita, "descrizione", dw_1.GetItemstring(ll_breakrow, "conto_descrizione_1") )
	dw_2.setitem(ll_riga_inserita, "saldoiniziale", dw_1.GetItemdecimal(ll_breakrow, "saldo_iniziale") )
	dw_2.setitem(ll_riga_inserita, "tot_dare", dw_1.GetItemdecimal(ll_breakrow, "somma_dare") )
	dw_2.setitem(ll_riga_inserita, "tot_avere", dw_1.GetItemdecimal(ll_breakrow, "somma_avere"))
	dw_2.setitem(ll_riga_inserita, "saldo_finale", dw_1.GetItemdecimal(ll_breakrow, "saldo_finale"))
   
	//ls_telefono
	select indirizzo, par_iva, a.id_anagrafica, a.cap, a.localita, a.provincia
	into :ls_indirizzo, :ls_pi, :ll_ana, :ls_cap, :ls_loc, :ls_pr
	from dba.anagrafica a, sog_commerciale s
	where s.codice=:ls_conto
	and s.id_anagrafica=a.id_anagrafica
	;
	select first(num_riferimento)
	into :ls_telefono
	from telefono
	where id_anagrafica=:ll_ana
	;
	
	dw_2.setitem(ll_riga_inserita, "indirizzo", ls_indirizzo)
	dw_2.setitem(ll_riga_inserita, "telefono", ls_telefono)
	dw_2.setitem(ll_riga_inserita, "pi", ls_pi)
	dw_2.setitem(ll_riga_inserita, "cap", ls_cap)
	dw_2.setitem(ll_riga_inserita, "localita", ls_loc)
	dw_2.setitem(ll_riga_inserita, "provincia", ls_pr)
	ls_test=left(ls_conto, 2)
	 
	 
	  // Increment starting row to find next break
    ll_breakrow = ll_breakrow + 1
LOOP
dw_2.SaveAs("", excel8!, true)
end event

type cbx_1 from checkbox within w_dati_contabili_rpt
integer x = 443
integer y = 131
integer width = 384
integer height = 99
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Escludi CL/FO"
boolean lefttext = true
end type

event clicked;string ls_cl, ls_fo, ls_filtro
if checked then
	select pref_cod_cliente, pref_cod_fornitore
	into :ls_cl, :ls_fo
	from par_sistema;
	
	if ls_cl>"" and ls_fo>"" then
		ls_filtro="left(  conto_codice , 2 ) <> '"+ls_cl+"'"
		ls_filtro+=" and left(  conto_codice , 2 ) <> '"+ls_fo+"'"
		dw_1.setfilter(ls_filtro)
		dw_1.filter()
	end if
else
	dw_1.setfilter("")
	dw_1.filter()
end if
end event

type cbx_ordina from checkbox within w_dati_contabili_rpt
integer x = 26
integer y = 131
integer width = 391
integer height = 99
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ord. Rag.Soc."
boolean lefttext = true
end type

event clicked;if cbx_ordina.checked then
	dw_1.setsort("conto_descrizione")
	dw_1.sort()
else
	dw_1.setsort("conto_codice")
	dw_1.sort()
end if
end event

type cb_1 from commandbutton within w_dati_contabili_rpt
integer x = 37
integer y = 35
integer width = 260
integer height = 90
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Annulla"
end type

event clicked;close(parent)
end event

type cb_pg_prima from commandbutton within w_dati_contabili_rpt
integer x = 325
integer y = 35
integer width = 91
integer height = 90
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "<"
end type

event clicked;dw_1.ScrollPriorPage ( ) 
end event

type cb_pg_dopo from commandbutton within w_dati_contabili_rpt
integer x = 435
integer y = 35
integer width = 91
integer height = 90
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = ">"
end type

event clicked;dw_1.ScrollNextPage ( ) 
end event

type cb_preview from commandbutton within w_dati_contabili_rpt
integer x = 1942
integer y = 35
integer width = 260
integer height = 90
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Preview"
end type

event clicked;if cb_preview.text='Preview' then
	cb_preview.text='Ritorna'
	dw_1.object.datawindow.print.preview='yes'
	dw_1.object.datawindow.print.preview.rulers='yes'
else
	cb_preview.text='Preview'
	dw_1.object.datawindow.print.preview='no'
	dw_1.object.datawindow.print.preview.rulers='no'
end if
end event

type cb_stampa from commandbutton within w_dati_contabili_rpt
integer x = 3269
integer y = 35
integer width = 260
integer height = 90
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Stampa"
end type

event clicked;printsetup()
dw_1.print()
end event

type cb_imp_st from commandbutton within w_dati_contabili_rpt
integer x = 2224
integer y = 35
integer width = 296
integer height = 90
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Imp. Stamp."
end type

event clicked;printsetup()
end event

type cb_6 from commandbutton within w_dati_contabili_rpt
integer x = 607
integer y = 35
integer width = 121
integer height = 90
integer taborder = 40
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "In"
end type

event clicked;ii_zoom=ii_zoom+5
dw_1.object.datawindow.zoom=ii_zoom
sle_zoom.text=string(ii_zoom)
end event

type cb_7 from commandbutton within w_dati_contabili_rpt
integer x = 856
integer y = 35
integer width = 121
integer height = 90
integer taborder = 60
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Out"
end type

event clicked;ii_zoom=ii_zoom - 5
dw_1.object.datawindow.zoom=ii_zoom
sle_zoom.text=string(ii_zoom)
end event

type cb_salva_su_file from commandbutton within w_dati_contabili_rpt
integer x = 3003
integer y = 35
integer width = 249
integer height = 90
integer taborder = 100
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salva &File"
end type

event clicked;dw_1.SaveAs()
end event

type sle_zoom from singlelineedit within w_dati_contabili_rpt
integer x = 731
integer y = 32
integer width = 124
integer height = 93
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "100"
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

event modified;ii_zoom=integer(this.text)
dw_1.object.datawindow.zoom=ii_zoom

end event

type sle_copie from singlelineedit within w_dati_contabili_rpt
integer x = 1737
integer y = 32
integer width = 154
integer height = 93
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_dati_contabili_rpt
integer x = 1602
integer y = 42
integer width = 143
integer height = 77
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Copie:"
boolean focusrectangle = false
end type

type st_1 from statictext within w_dati_contabili_rpt
integer x = 1020
integer y = 42
integer width = 271
integer height = 77
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Stampa Pg.:"
boolean focusrectangle = false
end type

type sle_pg from singlelineedit within w_dati_contabili_rpt
integer x = 1284
integer y = 32
integer width = 296
integer height = 93
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type dw_1 from datawindow within w_dati_contabili_rpt
integer x = 22
integer y = 266
integer width = 3515
integer height = 1418
integer taborder = 120
string dataobject = "d_dati_contabili_rpt"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event printstart;integer li_copie
string ls_pg, ls_orienta

li_copie=integer(sle_copie.text)
if isnull(li_copie) or li_copie=0 then li_copie=1
dw_1.Modify("DataWindow.Print.copies = "+string(li_copie))

ls_pg=sle_pg.text
dw_1.Modify("DataWindow.Print.Page.Range = '"+ls_pg+"'")
end event

event sqlpreview;string ls_sql
ls_sql=sqlsyntax
if s_parametri.da_sog_comm>"" then
	ls_sql+=" and conto.codice>='"+string(s_parametri.da_sog_comm)+ "' "
end if
if s_parametri.a_sog_comm>"" then
	ls_sql+=" and conto.codice<='"+string(s_parametri.a_sog_comm)+ "' "
end if
if ls_sql> sqlsyntax then
	setsqlpreview(ls_sql)
end if
end event

