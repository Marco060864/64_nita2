forward
global type w_agg_prezzo_comp_in_distinta from w_001
end type
type dw_1 from udw_base within w_agg_prezzo_comp_in_distinta
end type
type dw_2 from udw_figlia within w_agg_prezzo_comp_in_distinta
end type
type cb_aggiorna from commandbutton within w_agg_prezzo_comp_in_distinta
end type
type cb_seleziona_tutti from commandbutton within w_agg_prezzo_comp_in_distinta
end type
type dw_3 from udw_base within w_agg_prezzo_comp_in_distinta
end type
type cb_1 from commandbutton within w_agg_prezzo_comp_in_distinta
end type
type dw_4 from udw_base within w_agg_prezzo_comp_in_distinta
end type
type cb_stampa from commandbutton within w_agg_prezzo_comp_in_distinta
end type
type cb_2 from commandbutton within w_agg_prezzo_comp_in_distinta
end type
end forward

global type w_agg_prezzo_comp_in_distinta from w_001
integer width = 3456
integer height = 1908
dw_1 dw_1
dw_2 dw_2
cb_aggiorna cb_aggiorna
cb_seleziona_tutti cb_seleziona_tutti
dw_3 dw_3
cb_1 cb_1
dw_4 dw_4
cb_stampa cb_stampa
cb_2 cb_2
end type
global w_agg_prezzo_comp_in_distinta w_agg_prezzo_comp_in_distinta

forward prototypes
public function string wf_selezione (long row, datawindow adw_origine, string as_col_origine, datawindow adw_dest, string as_col_dest, string as_filtro_agg)
end prototypes

public function string wf_selezione (long row, datawindow adw_origine, string as_col_origine, datawindow adw_dest, string as_col_dest, string as_filtro_agg);long i, ll_righe, ll_row
string ls_filter
boolean lb_filter

if as_filtro_agg<>"" then
	ls_filter=as_filtro_agg+" and ("
else
	ls_filter="("
end if
lb_filter=(as_col_origine<>"")and(as_col_dest<>"")
if NOT(KeyDown(KeyShift!))And NOT(KeyDown(KeyControl!)) then
	ll_righe=adw_origine.RowCount()
	ll_row=row
	
	for i = 1 to ll_righe
		if i=ll_row then continue
		if adw_origine.IsSelected(i) then adw_origine.SelectRow(i,false)
	next
	
	adw_origine.SelectRow(ll_row, not (adw_origine.isselected(ll_row)))
	if lb_filter then ls_filter = ls_filter + as_col_dest+' ='+string(adw_origine.GetItemNumber(ll_row,as_col_origine))+' or '
elseif KeyDown(KeyShift!) then
		ll_row=row
		adw_origine.SelectRow(ll_row,true)
		ll_righe=adw_origine.RowCount()
		ll_row=ll_righe
		
		for i= 1 to ll_row
			if adw_origine.IsSelected(i) then ll_row=i
		next
		
		for i=ll_row+1 to ll_righe
			if adw_origine.IsSelected(i) then ll_righe=i
		next
		
		for i = ll_row to ll_righe
			adw_origine.SelectRow(i,true)
			if lb_filter then ls_filter = ls_filter + as_col_dest+'='+string(adw_origine.GetItemNumber(i,as_col_origine))+' or '					
		next
	elseif KeyDown(KeyControl!) then
		
		ll_row=row
		adw_origine.SelectRow(ll_row,Not adw_origine.IsSelected(ll_row))
		
		ll_righe=adw_origine.RowCount()
		for i = 1 to ll_righe
			if adw_origine.IsSelected(i) then
				if lb_filter then ls_filter = ls_filter + as_col_dest+'='+string(adw_origine.GetItemNumber(i,as_col_origine))+' or '	
			end if
		next
end if
	return ""

	

end function

on w_agg_prezzo_comp_in_distinta.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_2=create dw_2
this.cb_aggiorna=create cb_aggiorna
this.cb_seleziona_tutti=create cb_seleziona_tutti
this.dw_3=create dw_3
this.cb_1=create cb_1
this.dw_4=create dw_4
this.cb_stampa=create cb_stampa
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.cb_aggiorna
this.Control[iCurrent+4]=this.cb_seleziona_tutti
this.Control[iCurrent+5]=this.dw_3
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.dw_4
this.Control[iCurrent+8]=this.cb_stampa
this.Control[iCurrent+9]=this.cb_2
end on

on w_agg_prezzo_comp_in_distinta.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.cb_aggiorna)
destroy(this.cb_seleziona_tutti)
destroy(this.dw_3)
destroy(this.cb_1)
destroy(this.dw_4)
destroy(this.cb_stampa)
destroy(this.cb_2)
end on

event open;call super::open;dw_1.settransobject(sqlca)

dw_2.settransobject(sqlca)
dw_3.settransobject(sqlca)
dw_4.settransobject(sqlca)
dw_1.retrieve()
end event

type st_1 from w_001`st_1 within w_agg_prezzo_comp_in_distinta
end type

type dw_1 from udw_base within w_agg_prezzo_comp_in_distinta
integer x = 23
integer y = 16
integer width = 1810
integer height = 396
boolean bringtotop = true
string dataobject = "d_cat_codifica_gd"
end type

event rowfocuschanged;call super::rowfocuschanged;long ll_id  //primary key del master da riportare per il retrieve del detail

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

type dw_2 from udw_figlia within w_agg_prezzo_comp_in_distinta
integer x = 37
integer y = 440
integer width = 2295
integer height = 1348
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_comp_da_aggiornare"
end type

event clicked;call super::clicked;wf_selezione(row,this,"",this,"","")
end event

type cb_aggiorna from commandbutton within w_agg_prezzo_comp_in_distinta
integer x = 2359
integer y = 704
integer width = 430
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Agg. Selezionati"
end type

event clicked;
integer i, li_ret,a
long    ll_Rows, ll_id_art
decimal ldc_tot_scadenza_importo
string ls_tipo_um
decimal ldc_peso, ldc_prezzo, ldc_qta, ldc_peso_tot, ldc_costo
long ll_riga

ll_Rows = dw_2.RowCount()

dw_2.SetRow(1)

FOR i = ll_Rows TO 1 STEP -1
	IF dw_2.IsSelected(i) THEN
		ll_id_art=dw_2.getitemnumber(i, "id_articolo")
		ls_tipo_um=dw_2.getitemstring(i, "unita_misura_tipo")
		
		ldc_peso=dw_2.getitemdecimal(i, "peso_netto")
		dw_3.reset()
		ll_riga=dw_3.retrieve(ll_id_art)
		if ll_riga>0 then
		
			for a= 1 to ll_riga
				ldc_qta=dw_3.getitemdecimal(a, "quantita")
				ldc_peso_tot=ldc_qta*ldc_peso
				if ls_tipo_um='N' then //è al pezzo
					ldc_prezzo=dw_2.getitemdecimal(i, "prezzo")
					ldc_costo=ldc_prezzo*ldc_qta
				else
					ldc_prezzo=dw_2.getitemdecimal(i, "prezzo_manifattura")
					ldc_costo=ldc_prezzo*ldc_peso_tot
				end if
				//se il costo è 0 (non è stato valorizzato il prezzo nel listino base)
				//allora non faccio nulla
				if ldc_costo>0 then
					dw_3.setitem(a, "costo", ldc_costo)
					dw_3.setitem(a, "peso_netto", ldc_peso_tot)
					li_ret=dw_3.trigger event ue_update()
					if li_ret<> 1 then messagebox("Attenzione!", "Riga "+ string(i) + " non salvata!")
									
				end if
			next
			li_ret=dw_3.RowsCopy(1, dw_3.RowCount(), Primary!, dw_4, dw_4.rowcount()+1, Primary!)
		end if
		
	END IF
NEXT


end event

type cb_seleziona_tutti from commandbutton within w_agg_prezzo_comp_in_distinta
integer x = 2359
integer y = 436
integer width = 430
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Seleziona Tutti"
end type

event clicked;integer i

for i= 1 to dw_2.rowcount()
	dw_2.SelectRow(I,true)
next
end event

type dw_3 from udw_base within w_agg_prezzo_comp_in_distinta
boolean visible = false
integer x = 2359
integer y = 864
integer width = 1083
integer height = 936
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_agg_riga_distinta"
end type

type cb_1 from commandbutton within w_agg_prezzo_comp_in_distinta
integer x = 2359
integer y = 564
integer width = 430
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Deseleziona Tutti"
end type

event clicked;integer i

for i= 1 to dw_2.rowcount()
	dw_2.SelectRow(I,false)
next
end event

type dw_4 from udw_base within w_agg_prezzo_comp_in_distinta
integer x = 1847
integer y = 24
integer width = 1568
integer height = 396
boolean bringtotop = true
string dataobject = "d_controlla_agg_riga_distinta"
boolean hscrollbar = true
end type

type cb_stampa from commandbutton within w_agg_prezzo_comp_in_distinta
integer x = 3054
integer y = 564
integer width = 343
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stampa"
end type

event clicked;datastore ds_stampa

ds_stampa=create datastore
ds_stampa.dataobject="d_st_2_colonne_dis"
ds_stampa.settransobject(sqlca)
printsetup()
dw_4.sort()
dw_4.rowscopy(1, dw_4.rowcount(), primary!, ds_stampa, 1, primary!)
//ds_stampa.print()
destroy ds_stampa
dw_4.print()
end event

type cb_2 from commandbutton within w_agg_prezzo_comp_in_distinta
integer x = 2912
integer y = 704
integer width = 489
integer height = 100
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stampa 2 colonne"
end type

event clicked;datastore ds_stampa

ds_stampa=create datastore
ds_stampa.dataobject="d_st_2_colonne_dis"
ds_stampa.settransobject(sqlca)
printsetup()
dw_4.sort()
dw_4.rowscopy(1, dw_4.rowcount(), primary!, ds_stampa, 1, primary!)
ds_stampa.print()
destroy ds_stampa
//dw_4.print()
end event

