forward
global type w_par_stampa_cl_fo_gd from w_np_single_data
end type
type dw_1 from datawindow within w_par_stampa_cl_fo_gd
end type
type cb_calcola from commandbutton within w_par_stampa_cl_fo_gd
end type
type dw_2 from udw_base within w_par_stampa_cl_fo_gd
end type
type cb_stampa from commandbutton within w_par_stampa_cl_fo_gd
end type
end forward

global type w_par_stampa_cl_fo_gd from w_np_single_data
integer width = 3664
integer height = 2598
dw_1 dw_1
cb_calcola cb_calcola
dw_2 dw_2
cb_stampa cb_stampa
end type
global w_par_stampa_cl_fo_gd w_par_stampa_cl_fo_gd

type variables
long il_id_causale[]
end variables

on w_par_stampa_cl_fo_gd.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_calcola=create cb_calcola
this.dw_2=create dw_2
this.cb_stampa=create cb_stampa
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_calcola
this.Control[iCurrent+3]=this.dw_2
this.Control[iCurrent+4]=this.cb_stampa
end on

on w_par_stampa_cl_fo_gd.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_calcola)
destroy(this.dw_2)
destroy(this.cb_stampa)
end on

event open;call super::open;dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
end event

type p_msg_log from w_np_single_data`p_msg_log within w_par_stampa_cl_fo_gd
end type

type p_crescente from w_np_single_data`p_crescente within w_par_stampa_cl_fo_gd
end type

type p_decrescente from w_np_single_data`p_decrescente within w_par_stampa_cl_fo_gd
end type

type dw_single from w_np_single_data`dw_single within w_par_stampa_cl_fo_gd
integer x = 29
integer y = 26
integer width = 2575
integer height = 1203
string dataobject = "D_PAR_STAMPA_PESATA"
end type

type dw_1 from datawindow within w_par_stampa_cl_fo_gd
integer x = 29
integer y = 1254
integer width = 3515
integer height = 1222
integer taborder = 140
boolean bringtotop = true
string dataobject = "d_or_saldi_parametrica"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;long ll_id_doc
w_orafo_documento_ordine_cx w_orafo
s_list_main s_list

if row<=0 then return
s_list.s_identifica[1]="id_documento"
s_list.s_modo=modo_modifica
ll_id_doc=getitemnumber(row, "riga_documento_id_documento")
if ll_id_doc>0 then
	s_list.l_identifica[1]=ll_id_doc
	openwithparm(w_orafo, s_list)
end if

		
end event

event printstart;//integer li_copie
//string ls_pg, ls_orienta
//
//li_copie=integer(sle_copie.text)
//if isnull(li_copie) or li_copie=0 then li_copie=1
//dw_1.Modify("DataWindow.Print.copies = "+string(li_copie))
//
//ls_pg=sle_pg.text
//dw_1.Modify("DataWindow.Print.Page.Range = '"+ls_pg+"'")
end event

event sqlpreview;
integer i
string ls_sql

	
for i=1 to upperbound(il_id_causale)
	if i=1 then
		ls_sql+=" and (caus_magazzino.id_caus_magazzino= "+string(il_id_causale[i])
	else
		ls_sql+=" or caus_magazzino.id_caus_magazzino= "+string(il_id_causale[i])
	end if
next
ls_sql+=")"
ls_sql=sqlsyntax + ls_sql
i=SetSQLPreview(ls_sql)
if i<>1 then
	messagebox("Errore!", "Filtro causali non applicato!")
end if

end event

event retrievestart;return 2
end event

type cb_calcola from commandbutton within w_par_stampa_cl_fo_gd
integer x = 3218
integer y = 1126
integer width = 322
integer height = 90
integer taborder = 11
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Calcola"
end type

event clicked;long ll_righe, ll_id_sog
date ldt_data_inizio, ldt_data_fine
integer i, a
string ls_soggetto,ls_configurazione
dw_1.reset()
for i = 1 to dw_single.rowcount()
	ldt_data_inizio=dw_single.getitemdate(i, "data_inizio")
	ldt_data_fine=dw_single.getitemdate(i, "data_fine")
	ll_id_sog=dw_single.getitemnumber(i, "id_sog_commerciale")
	select codice
	into :ls_soggetto
	from dba.sog_commerciale
	where id_sog_commerciale=:ll_id_sog;
	ls_configurazione=dw_single.getitemstring(i, "configurazione")
	if ls_configurazione >" " then
		dw_2.retrieve(ls_configurazione)
		for a= 1 to dw_2.rowcount()
			il_id_causale[a]=dw_2.getitemnumber(a, "id_caus_magazzino")
		next
	end if

	dw_1.retrieve(ldt_data_inizio, ldt_data_fine, ls_soggetto, ls_soggetto)
next


end event

type dw_2 from udw_base within w_par_stampa_cl_fo_gd
integer x = 2633
integer y = 26
integer width = 936
integer height = 973
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_sel_causali_gd"
end type

type cb_stampa from commandbutton within w_par_stampa_cl_fo_gd
integer x = 2779
integer y = 1126
integer width = 322
integer height = 90
integer taborder = 21
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stampa"
end type

event clicked;if dw_1.rowcount()>0 then
	printsetup()
	dw_1.print()
end if
end event

