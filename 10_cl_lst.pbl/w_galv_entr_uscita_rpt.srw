forward
global type w_galv_entr_uscita_rpt from w_stampa
end type
type cbx_dettaglio from checkbox within w_galv_entr_uscita_rpt
end type
type cbx_giornaliero from checkbox within w_galv_entr_uscita_rpt
end type
type pb_controlla_bol from picturebutton within w_galv_entr_uscita_rpt
end type
type dw_2 from udw_001 within w_galv_entr_uscita_rpt
end type
type pb_st_2 from picturebutton within w_galv_entr_uscita_rpt
end type
end forward

global type w_galv_entr_uscita_rpt from w_stampa
integer width = 4553
cbx_dettaglio cbx_dettaglio
cbx_giornaliero cbx_giornaliero
pb_controlla_bol pb_controlla_bol
dw_2 dw_2
pb_st_2 pb_st_2
end type
global w_galv_entr_uscita_rpt w_galv_entr_uscita_rpt

on w_galv_entr_uscita_rpt.create
int iCurrent
call super::create
this.cbx_dettaglio=create cbx_dettaglio
this.cbx_giornaliero=create cbx_giornaliero
this.pb_controlla_bol=create pb_controlla_bol
this.dw_2=create dw_2
this.pb_st_2=create pb_st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_dettaglio
this.Control[iCurrent+2]=this.cbx_giornaliero
this.Control[iCurrent+3]=this.pb_controlla_bol
this.Control[iCurrent+4]=this.dw_2
this.Control[iCurrent+5]=this.pb_st_2
end on

on w_galv_entr_uscita_rpt.destroy
call super::destroy
destroy(this.cbx_dettaglio)
destroy(this.cbx_giornaliero)
destroy(this.pb_controlla_bol)
destroy(this.dw_2)
destroy(this.pb_st_2)
end on

event open;call super::open;s_date_e_sog s_date



s_date=message.powerobjectparm

if s_date.id_sog_com=1 then
	dw_1.dataobject="d_galv_entr_uscita_2"
	pb_controlla_bol.enabled=true

end if
dw_1.settransobject(sqlca)
dw_1.retrieve(s_date.da_data, s_date.a_data)
end event

event resize;call super::resize;iudw_corrente.width=newwidth - 1000
dw_2.x=iudw_corrente.width + 50
dw_2.height=iudw_corrente.height

pb_controlla_bol.x=dw_2.x
pb_controlla_bol.y=pb_stampa.y
end event

type pb_1 from w_stampa`pb_1 within w_galv_entr_uscita_rpt
integer x = 3040
end type

type cb_preview from w_stampa`cb_preview within w_galv_entr_uscita_rpt
integer x = 2437
end type

type dw_1 from w_stampa`dw_1 within w_galv_entr_uscita_rpt
integer width = 3479
string dataobject = "d_galv_entr_uscita"
boolean hscrollbar = false
end type

type pb_salva_su_file from w_stampa`pb_salva_su_file within w_galv_entr_uscita_rpt
integer x = 2843
end type

type pb_stampa from w_stampa`pb_stampa within w_galv_entr_uscita_rpt
integer x = 2633
end type

type sle_pg from w_stampa`sle_pg within w_galv_entr_uscita_rpt
integer x = 1312
end type

type st_1 from w_stampa`st_1 within w_galv_entr_uscita_rpt
integer x = 1033
end type

type st_2 from w_stampa`st_2 within w_galv_entr_uscita_rpt
end type

type sle_copie from w_stampa`sle_copie within w_galv_entr_uscita_rpt
end type

type sle_zoom from w_stampa`sle_zoom within w_galv_entr_uscita_rpt
end type

type cb_7 from w_stampa`cb_7 within w_galv_entr_uscita_rpt
end type

type cb_6 from w_stampa`cb_6 within w_galv_entr_uscita_rpt
end type

type cb_pg_dopo from w_stampa`cb_pg_dopo within w_galv_entr_uscita_rpt
end type

type cb_pg_prima from w_stampa`cb_pg_prima within w_galv_entr_uscita_rpt
end type

type cb_esci from w_stampa`cb_esci within w_galv_entr_uscita_rpt
integer x = 3259
end type

type cbx_dettaglio from checkbox within w_galv_entr_uscita_rpt
integer x = 1911
integer y = 12
integer width = 402
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Dettaglio"
end type

event clicked;if checked then
	dw_1.Modify("DataWindow.detail.Height=80")
else
	dw_1.Modify("DataWindow.detail.Height=0")
end if
end event

type cbx_giornaliero from checkbox within w_galv_entr_uscita_rpt
integer x = 1911
integer y = 88
integer width = 402
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Giornaliero"
end type

event clicked;if checked then
	dw_1.Modify("DataWindow.Trailer.2.Height=80")
else
	dw_1.Modify("DataWindow.Trailer.2.Height=0")
end if
end event

type pb_controlla_bol from picturebutton within w_galv_entr_uscita_rpt
integer x = 3566
integer y = 44
integer width = 393
integer height = 108
integer taborder = 18
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean enabled = false
string text = "CONTR. BOL"
boolean originalsize = true
alignment htextalign = left!
end type

event clicked;long i, ll_id_doc_grbol, ll_id_doc_kgalv, ll_righe, ll_riga_trovata, ll_riga_inserita, a, ll_id_riga_rbol, ll_num_prog
string ls_num_grbol, ls_num_kgalv
date ldt_data_doc

ll_righe=dw_1.rowcount()
for i = 1 to ll_righe
	ll_id_doc_grbol=dw_1.getitemnumber(i, "id_doc_grbol")
	ll_riga_trovata=dw_1.find("id_doc_kgalv="+string(ll_id_doc_grbol), 1, ll_righe)
	if ll_riga_trovata<=0 then
		a++
		ls_num_grbol=dw_1.getitemstring(i, "grbol_num_documento")
		ll_riga_inserita=dw_2.insertrow(0)
		if a=1 then
			dw_2.setitem(ll_riga_inserita, "num_bollettina","BOL in GRBOL  ma NON in KGALV" )
			ll_riga_inserita=dw_2.insertrow(0)
		end if
		dw_2.setitem(ll_riga_inserita, "num_bollettina",ls_num_grbol )
	end if
	//
next
a=0
for i = 1 to ll_righe
	ll_id_doc_kgalv=dw_1.getitemnumber(i, "id_doc_kgalv")
	ll_riga_trovata=dw_1.find("id_doc_grbol="+string(ll_id_doc_kgalv), 1, ll_righe)
	if ll_riga_trovata<=0 then
		a++
		ls_num_kgalv=dw_1.getitemstring(i, "kgalv_num_documento")
		ll_riga_inserita=dw_2.insertrow(0)
		if a=1 then
			dw_2.setitem(ll_riga_inserita, "num_bollettina","BOL in KGALV ma NON in GRBOL" )
			ll_riga_inserita=dw_2.insertrow(0)
		end if
		ll_id_riga_rbol=f_trova_rbol_da_bollettina(ll_id_doc_kgalv)
		if ll_id_riga_rbol> 0 then
			ll_num_prog=0
			select num_progressivo, data_documento
			into :ll_num_prog, :ldt_data_doc
			from dba.documento d, dba.riga_documento r
			where r.id_riga_documento=:ll_id_riga_rbol
			and d.id_documento=r.id_documento
			;
			ls_num_kgalv+= " - La BOL è in RBOL n. "+string(ll_num_prog) + " del "+ string(ldt_data_doc)
		end if
		dw_2.setitem(ll_riga_inserita, "num_bollettina", ls_num_kgalv )
	end if
	//ll_id_doc_kgalv=dw_1.getitemnumber(i, "id_doc_kgalv")
next
end event

type dw_2 from udw_001 within w_galv_entr_uscita_rpt
integer x = 3547
integer y = 172
integer width = 891
integer height = 1404
integer taborder = 28
boolean bringtotop = true
string dataobject = "d_st_bol_mancanti"
boolean vscrollbar = true
end type

type pb_st_2 from picturebutton within w_galv_entr_uscita_rpt
integer x = 4027
integer y = 44
integer width = 393
integer height = 108
integer taborder = 28
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "STAMPA"
boolean originalsize = true
end type

event clicked;dw_2.print( false, true)
end event

