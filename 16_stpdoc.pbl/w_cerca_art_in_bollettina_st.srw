forward
global type w_cerca_art_in_bollettina_st from w_001
end type
type cb_annulla from commandbutton within w_cerca_art_in_bollettina_st
end type
type cb_stampa from commandbutton within w_cerca_art_in_bollettina_st
end type
type dw_1 from u_dw_ext_main within w_cerca_art_in_bollettina_st
end type
type st_2 from statictext within w_cerca_art_in_bollettina_st
end type
type cb_1 from commandbutton within w_cerca_art_in_bollettina_st
end type
type cb_2 from commandbutton within w_cerca_art_in_bollettina_st
end type
type cb_3 from commandbutton within w_cerca_art_in_bollettina_st
end type
type cb_4 from commandbutton within w_cerca_art_in_bollettina_st
end type
type cb_5 from commandbutton within w_cerca_art_in_bollettina_st
end type
type cb_6 from commandbutton within w_cerca_art_in_bollettina_st
end type
type cb_7 from commandbutton within w_cerca_art_in_bollettina_st
end type
end forward

global type w_cerca_art_in_bollettina_st from w_001
integer x = 1499
integer y = 204
integer width = 1806
integer height = 924
boolean minbox = true
windowtype windowtype = popup!
cb_annulla cb_annulla
cb_stampa cb_stampa
dw_1 dw_1
st_2 st_2
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
cb_4 cb_4
cb_5 cb_5
cb_6 cb_6
cb_7 cb_7
end type
global w_cerca_art_in_bollettina_st w_cerca_art_in_bollettina_st

on w_cerca_art_in_bollettina_st.create
int iCurrent
call super::create
this.cb_annulla=create cb_annulla
this.cb_stampa=create cb_stampa
this.dw_1=create dw_1
this.st_2=create st_2
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.cb_4=create cb_4
this.cb_5=create cb_5
this.cb_6=create cb_6
this.cb_7=create cb_7
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_annulla
this.Control[iCurrent+2]=this.cb_stampa
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.cb_2
this.Control[iCurrent+7]=this.cb_3
this.Control[iCurrent+8]=this.cb_4
this.Control[iCurrent+9]=this.cb_5
this.Control[iCurrent+10]=this.cb_6
this.Control[iCurrent+11]=this.cb_7
end on

on w_cerca_art_in_bollettina_st.destroy
call super::destroy
destroy(this.cb_annulla)
destroy(this.cb_stampa)
destroy(this.dw_1)
destroy(this.st_2)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.cb_4)
destroy(this.cb_5)
destroy(this.cb_6)
destroy(this.cb_7)
end on

event open;long ll_id_ese
date ldt_data_inizio

dw_1.settransobject(sqlca)
dw_1.insertrow(1)

trigger event ue_postopen()





end event

event ue_postopen;call super::ue_postopen;date ldt_da_data

ldt_da_data=relativedate(date(today()), - 60)
dw_1.setitem(1, "da_data",ldt_da_data )


end event

type st_1 from w_001`st_1 within w_cerca_art_in_bollettina_st
end type

type cb_annulla from commandbutton within w_cerca_art_in_bollettina_st
integer x = 27
integer y = 164
integer width = 192
integer height = 76
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Annulla"
end type

event clicked;close(parent)
end event

type cb_stampa from commandbutton within w_cerca_art_in_bollettina_st
boolean visible = false
integer x = 425
integer y = 148
integer width = 247
integer height = 76
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stampa"
boolean default = true
end type

event clicked;string ls_cod_esercizio
s_param_articoli s_par
dw_1.accepttext()

//id-articolo
s_par.ll_magazzino=dw_1.getitemnumber(1, "id_articolo")


//num_bollettina
s_par.da_sog_comm=dw_1.getitemstring(1, "num_bol")


s_par.a_data=dw_1.getitemdate(1, "a_data")
s_par.da_data=dw_1.getitemdate(1, "da_data")
//num_progressivo
s_par.id_cat_codifica=dw_1.getitemnumber(1, "num_prog")
s_par.par_stampa=dw_1.getitemstring(1, "ancora_qui")
s_par.da_scadenza=dw_1.getitemdate(1, "data_scadenza")
s_par.filtro="Stampa dati contabili per Esercizio: "+ls_cod_esercizio+" fino al: "+string(s_par.a_data)
if s_par.da_sog_comm>"" then
	s_par.filtro+= " - Num. Bollettina: "+s_par.da_sog_comm
end if
if s_par.da_scadenza> date("2000-01-01") then
	s_par.segno_coef_calo=dw_1.getitemstring(1, "segno_data_scadenza")
	s_par.filtro+= " - Data scadenza "+s_par.segno_coef_calo+" a: "+string(s_par.da_scadenza, "dd/mm/yyyy")
end if
s_par.tipo_stampa="d_cerca_art_in_bollettina_tb"
openwithparm(w_cerca_art_in_bollettina_rpt, s_par)
end event

type dw_1 from u_dw_ext_main within w_cerca_art_in_bollettina_st
integer x = 27
integer y = 268
integer width = 1728
integer height = 456
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_cerca_art_in_bollettina_st"
end type

event itemchanged;call super::itemchanged;string ls_id_conto

choose case string(dwo.name)
	case "da_conto"
		ls_id_conto=getitemstring(row, "a_conto")
		if isnull(ls_id_conto) then
			setitem(row, "a_conto", data)
		end if
		
end choose
end event

type st_2 from statictext within w_cerca_art_in_bollettina_st
integer x = 27
integer y = 4
integer width = 1225
integer height = 152
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Se su ~"Num. Bollettina~" metti la parte iniziale troverà le BOL con num. documento che inizia in quel modo, se metti ~"-~" e il numero di 5-7 cifre della bollettina (cod. barre) cerca la singola bollettina."
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_cerca_art_in_bollettina_st
integer x = 1262
integer y = 84
integer width = 247
integer height = 76
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "St. New"
boolean default = true
end type

event clicked;string ls_cod_esercizio
s_param_articoli s_par
dw_1.accepttext()

//id-articolo
s_par.ll_magazzino=dw_1.getitemnumber(1, "id_articolo")


//num_bollettina
s_par.da_sog_comm=dw_1.getitemstring(1, "num_bol")


s_par.a_data=dw_1.getitemdate(1, "a_data")
s_par.da_data=dw_1.getitemdate(1, "da_data")
//num_progressivo
s_par.id_cat_codifica=dw_1.getitemnumber(1, "num_prog")
s_par.par_stampa=dw_1.getitemstring(1, "ancora_qui")
s_par.da_scadenza=dw_1.getitemdate(1, "data_scadenza")
s_par.filtro="Stampa dati contabili per Esercizio: "+ls_cod_esercizio+" fino al: "+string(s_par.a_data)
if s_par.da_sog_comm>"" then
	s_par.filtro+= " - Num. Bollettina: "+s_par.da_sog_comm
end if
if s_par.da_scadenza> date("2000-01-01") then
	s_par.segno_coef_calo=dw_1.getitemstring(1, "segno_data_scadenza")
	s_par.filtro+= " - Data scadenza "+s_par.segno_coef_calo+" a: "+string(s_par.da_scadenza, "dd/mm/yyyy")
end if
s_par.tipo_stampa="d_new_cerca_art_in_bol_tb"
s_par.li_fiscale=dw_1.getitemnumber(1, "rag_sociale")

openwithparm(w_cerca_art_in_bollettina_rpt, s_par)
end event

type cb_2 from commandbutton within w_cerca_art_in_bollettina_st
integer x = 1522
integer y = 84
integer width = 247
integer height = 76
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "St. FO"
boolean default = true
end type

event clicked;string ls_cod_esercizio
s_param_articoli s_par
dw_1.accepttext()

//id-articolo
s_par.ll_magazzino=dw_1.getitemnumber(1, "id_articolo")


//num_bollettina
s_par.da_sog_comm=dw_1.getitemstring(1, "num_bol")


s_par.a_data=dw_1.getitemdate(1, "a_data")
s_par.da_data=dw_1.getitemdate(1, "da_data")
//num_progressivo
s_par.id_cat_codifica=dw_1.getitemnumber(1, "num_prog")
s_par.par_stampa=dw_1.getitemstring(1, "ancora_qui")
s_par.da_scadenza=dw_1.getitemdate(1, "data_scadenza")
s_par.filtro="Stampa dati contabili per Esercizio: "+ls_cod_esercizio+" fino al: "+string(s_par.a_data)
if s_par.da_sog_comm>"" then
	s_par.filtro+= " - Num. Bollettina: "+s_par.da_sog_comm
end if
if s_par.da_scadenza> date("2000-01-01") then
	s_par.segno_coef_calo=dw_1.getitemstring(1, "segno_data_scadenza")
	s_par.filtro+= " - Data scadenza "+s_par.segno_coef_calo+" a: "+string(s_par.da_scadenza, "dd/mm/yyyy")
end if
s_par.tipo_stampa="d_new_cerca_art_bol_fo_tb"
s_par.li_fiscale=dw_1.getitemnumber(1, "rag_sociale")

openwithparm(w_cerca_art_in_bollettina_rpt, s_par)
end event

type cb_3 from commandbutton within w_cerca_art_in_bollettina_st
integer x = 1522
integer y = 4
integer width = 247
integer height = 76
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "St. FO2"
boolean default = true
end type

event clicked;string ls_cod_esercizio
s_param_articoli s_par
dw_1.accepttext()

//id-articolo
s_par.ll_magazzino=dw_1.getitemnumber(1, "id_articolo")


//num_bollettina
s_par.da_sog_comm=dw_1.getitemstring(1, "num_bol")


s_par.a_data=dw_1.getitemdate(1, "a_data")
s_par.da_data=dw_1.getitemdate(1, "da_data")
//num_progressivo
s_par.id_cat_codifica=dw_1.getitemnumber(1, "num_prog")
s_par.par_stampa=dw_1.getitemstring(1, "ancora_qui")
s_par.da_scadenza=dw_1.getitemdate(1, "data_scadenza")
s_par.filtro="Stampa dati contabili per Esercizio: "+ls_cod_esercizio+" fino al: "+string(s_par.a_data)
if s_par.da_sog_comm>"" then
	s_par.filtro+= " - Num. Bollettina: "+s_par.da_sog_comm
end if
if s_par.da_scadenza> date("2000-01-01") then
	s_par.segno_coef_calo=dw_1.getitemstring(1, "segno_data_scadenza")
	s_par.filtro+= " - Data scadenza "+s_par.segno_coef_calo+" a: "+string(s_par.da_scadenza, "dd/mm/yyyy")
end if
if s_par.par_stampa='S' then
	s_par.tipo_stampa="d_new_cerca_art_bol_fo_sped_evasa_tb"
else
	s_par.tipo_stampa="d_new_cerca_art_bol_fo_sped_tb"
end if
s_par.li_fiscale=dw_1.getitemnumber(1, "rag_sociale")

openwithparm(w_cerca_art_in_bollettina_rpt, s_par)
end event

type cb_4 from commandbutton within w_cerca_art_in_bollettina_st
integer x = 1522
integer y = 164
integer width = 247
integer height = 76
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "St. GEN"
boolean default = true
end type

event clicked;string ls_cod_esercizio
s_param_articoli s_par
dw_1.accepttext()

//id-articolo
s_par.ll_magazzino=dw_1.getitemnumber(1, "id_articolo")


//num_bollettina
s_par.da_sog_comm=dw_1.getitemstring(1, "num_bol")


s_par.a_data=dw_1.getitemdate(1, "a_data")
s_par.da_data=dw_1.getitemdate(1, "da_data")
//num_progressivo
s_par.id_cat_codifica=dw_1.getitemnumber(1, "num_prog")
s_par.par_stampa=dw_1.getitemstring(1, "ancora_qui")
s_par.da_scadenza=dw_1.getitemdate(1, "data_scadenza")
s_par.filtro="Stampa dati contabili per Esercizio: "+ls_cod_esercizio+" fino al: "+string(s_par.a_data)
if s_par.da_sog_comm>"" then
	s_par.filtro+= " - Num. Bollettina: "+s_par.da_sog_comm
end if
if s_par.da_scadenza> date("2000-01-01") then
	s_par.segno_coef_calo=dw_1.getitemstring(1, "segno_data_scadenza")
	s_par.filtro+= " - Data scadenza "+s_par.segno_coef_calo+" a: "+string(s_par.da_scadenza, "dd/mm/yyyy")
end if
s_par.tipo_stampa="d_new_cerca_art_bol_fo_gen_est_tb"
s_par.li_fiscale=dw_1.getitemnumber(1, "rag_sociale")

openwithparm(w_cerca_art_in_bollettina_rpt, s_par)
end event

type cb_5 from commandbutton within w_cerca_art_in_bollettina_st
integer x = 1262
integer y = 164
integer width = 247
integer height = 76
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "SPED.K."
boolean default = true
end type

event clicked;string ls_cod_esercizio
s_param_articoli s_par
dw_1.accepttext()

//id-articolo
s_par.ll_magazzino=dw_1.getitemnumber(1, "id_articolo")


//num_bollettina
s_par.da_sog_comm=dw_1.getitemstring(1, "num_bol")


s_par.a_data=dw_1.getitemdate(1, "a_data")
s_par.da_data=dw_1.getitemdate(1, "da_data")
//num_progressivo
s_par.id_cat_codifica=dw_1.getitemnumber(1, "num_prog")
s_par.par_stampa=dw_1.getitemstring(1, "ancora_qui")
s_par.da_scadenza=dw_1.getitemdate(1, "data_scadenza")
s_par.filtro="Stampa dati contabili per Esercizio: "+ls_cod_esercizio+" fino al: "+string(s_par.a_data)
if s_par.da_sog_comm>"" then
	s_par.filtro+= " - Num. Bollettina: "+s_par.da_sog_comm
end if
if s_par.da_scadenza> date("2000-01-01") then
	s_par.segno_coef_calo=dw_1.getitemstring(1, "segno_data_scadenza")
	s_par.filtro+= " - Data scadenza "+s_par.segno_coef_calo+" a: "+string(s_par.da_scadenza, "dd/mm/yyyy")
end if
s_par.tipo_stampa="d_new_cerca_art_bol_fo_gen_sped_tb"
s_par.li_fiscale=dw_1.getitemnumber(1, "rag_sociale")

openwithparm(w_cerca_art_in_bollettina_rpt, s_par)
end event

type cb_6 from commandbutton within w_cerca_art_in_bollettina_st
integer x = 891
integer y = 164
integer width = 357
integer height = 76
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Giornoxgiorno"
boolean default = true
end type

event clicked;string ls_cod_esercizio
s_param_articoli s_par
dw_1.accepttext()

//id-articolo
s_par.ll_magazzino=dw_1.getitemnumber(1, "id_articolo")


//num_bollettina
s_par.da_sog_comm=dw_1.getitemstring(1, "num_bol")


s_par.a_data=dw_1.getitemdate(1, "a_data")
s_par.da_data=dw_1.getitemdate(1, "da_data")
//num_progressivo
s_par.id_cat_codifica=dw_1.getitemnumber(1, "num_prog")
s_par.par_stampa=dw_1.getitemstring(1, "ancora_qui")
//if s_par.par_stampa="S" then s_par.par_sta
	
s_par.da_scadenza=dw_1.getitemdate(1, "data_scadenza")
s_par.filtro="Stampa dati contabili per Esercizio: "+ls_cod_esercizio+" fino al: "+string(s_par.a_data)
if s_par.da_sog_comm>"" then
	s_par.filtro+= " - Num. Bollettina: "+s_par.da_sog_comm
end if
if s_par.da_scadenza> date("2000-01-01") then
	s_par.segno_coef_calo=dw_1.getitemstring(1, "segno_data_scadenza")
	s_par.filtro+= " - Data scadenza "+s_par.segno_coef_calo+" a: "+string(s_par.da_scadenza, "dd/mm/yyyy")
end if
s_par.tipo_stampa="d_new_cerca_art_bol_fo_gxg_tb"
s_par.li_fiscale=dw_1.getitemnumber(1, "rag_sociale")

openwithparm(w_cerca_art_in_bollettina_rpt, s_par)
end event

type cb_7 from commandbutton within w_cerca_art_in_bollettina_st
integer x = 1266
integer y = 4
integer width = 247
integer height = 76
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stampa"
end type

event clicked;string ls_cod_esercizio
s_param_articoli s_par
dw_1.accepttext()

//num_bollettina
s_par.da_sog_comm=dw_1.getitemstring(1, "num_bol")
s_par.da_sog_comm=left(s_par.da_sog_comm, len(s_par.da_sog_comm) - 1)

s_par.a_data=dw_1.getitemdate(1, "a_data")
s_par.da_data=dw_1.getitemdate(1, "da_data")

s_par.ll_magazzino=dw_1.getitemnumber(1, "id_articolo")
s_par.filtro="Stampa Confronto PEZZI originali/RBOL: "+ls_cod_esercizio+" fino al: "+string(s_par.a_data)
if s_par.da_sog_comm>"" then
	s_par.filtro+= " - Cliente: "+s_par.da_sog_comm
end if

s_par.tipo_stampa="d_pz_originali_rbol"
openwithparm(w_confronto_pz_orig_rbol_rpt, s_par)
end event

