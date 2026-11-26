forward
global type w_scad_buratto_rpt from w_stampa
end type
type dw_2 from udw_000 within w_scad_buratto_rpt
end type
type cb_2 from commandbutton within w_scad_buratto_rpt
end type
type dw_3 from udw_000 within w_scad_buratto_rpt
end type
type st_3 from statictext within w_scad_buratto_rpt
end type
type cbx_1 from checkbox within w_scad_buratto_rpt
end type
end forward

global type w_scad_buratto_rpt from w_stampa
integer width = 4270
dw_2 dw_2
cb_2 cb_2
dw_3 dw_3
st_3 st_3
cbx_1 cbx_1
end type
global w_scad_buratto_rpt w_scad_buratto_rpt

on w_scad_buratto_rpt.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.cb_2=create cb_2
this.dw_3=create dw_3
this.st_3=create st_3
this.cbx_1=create cbx_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.dw_3
this.Control[iCurrent+4]=this.st_3
this.Control[iCurrent+5]=this.cbx_1
end on

on w_scad_buratto_rpt.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.cb_2)
destroy(this.dw_3)
destroy(this.st_3)
destroy(this.cbx_1)
end on

event open;call super::open;long ll_id_prof


dw_1.setredraw(false)
ll_id_prof=message.doubleparm
//if ll_id_prof=184 then dw_1.dataobject="d_fermo_buratto_scadenza_gd"  //20230828 commento perché è di default
if ll_id_prof=226 then dw_1.dataobject="d_fermo_attesa_scadenza_gd"
if ll_id_prof=170 then dw_1.dataobject="d_fermo_galvanica_scadenza_gd"
if ll_id_prof=224 then dw_1.dataobject="d_fermo_ceramico_scadenza_gd"
//if ll_id_prof=228 then dw_1.dataobject="d_fermo_spaz_esterni_scadenza_gd"  //20241015 tolto perchéP fatto con la scopa (icona) e cambiato anche nome alla dw che non esiste più con questo nome

dw_1.settransobject(sqlca)
dw_1.retrieve()

dw_2.settransobject(sqlca)
dw_2.insertrow(1)

dw_3.settransobject(sqlca)
dw_3.insertrow(1)

end event

event ue_postopen;call super::ue_postopen;long ll_id_utenti
dw_1.setredraw(true)

ll_id_utenti=u_freddie.s_utenti.i_idutente
dw_1.modify("t_operatore.text='"+string(ll_id_utenti)+"'")
end event

type pb_1 from w_stampa`pb_1 within w_scad_buratto_rpt
integer x = 2514
end type

type cb_preview from w_stampa`cb_preview within w_scad_buratto_rpt
integer x = 1998
end type

type dw_1 from w_stampa`dw_1 within w_scad_buratto_rpt
integer width = 4142
string dataobject = "d_fermo_buratto_scadenza_gd"
end type

event dw_1::doubleclicked;call super::doubleclicked;string ls_ordina
integer li_ret
setredraw(false)
if dwo.name="t_3" then
	setredraw(false)
	setsort("c_ordina_giorno, c_data_consegna")
	sort()
	setredraw(true)
elseif dwo.type="text" then
	ls_ordina=left(string (dwo.name), len(string (dwo.name)) - 2)
	setsort(ls_ordina)
	li_ret=sort()
	//messagebox("!", li_ret)
	
end if
setredraw(true)
end event

type pb_salva_su_file from w_stampa`pb_salva_su_file within w_scad_buratto_rpt
integer x = 2341
end type

type pb_stampa from w_stampa`pb_stampa within w_scad_buratto_rpt
integer x = 2162
end type

type sle_pg from w_stampa`sle_pg within w_scad_buratto_rpt
integer x = 1285
integer width = 251
end type

type st_1 from w_stampa`st_1 within w_scad_buratto_rpt
integer x = 1006
end type

type st_2 from w_stampa`st_2 within w_scad_buratto_rpt
end type

type sle_copie from w_stampa`sle_copie within w_scad_buratto_rpt
end type

type sle_zoom from w_stampa`sle_zoom within w_scad_buratto_rpt
end type

type cb_7 from w_stampa`cb_7 within w_scad_buratto_rpt
end type

type cb_6 from w_stampa`cb_6 within w_scad_buratto_rpt
end type

type cb_pg_dopo from w_stampa`cb_pg_dopo within w_scad_buratto_rpt
end type

type cb_pg_prima from w_stampa`cb_pg_prima within w_scad_buratto_rpt
end type

type cb_esci from w_stampa`cb_esci within w_scad_buratto_rpt
integer x = 3282
integer y = 84
integer width = 210
integer height = 80
end type

type dw_2 from udw_000 within w_scad_buratto_rpt
integer x = 2697
integer y = 60
integer width = 553
integer height = 104
integer taborder = 19
boolean bringtotop = true
string dataobject = "d_ricerca_in_stampe"
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;long ll_riga_trovata
string ls_filtro

if data> " " then
	ls_filtro="documento_num_documento like '%"+data+"%'"   //documento_num_documento like '%1651053%'
ELSE
	ls_filtro=""
end if
dw_1.setfilter(ls_filtro)
dw_1.filter()

end event

type cb_2 from commandbutton within w_scad_buratto_rpt
integer x = 3273
integer width = 229
integer height = 80
integer taborder = 23
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salva"
end type

event clicked;integer li_ret
dw_1.accepttext()

li_ret=dw_1.update()
//li_ret2=sqlca.sqlcode
//li_ret3=sqlca.sqlnrows
if li_ret=1 then
	commit;
else
	rollback;
	messagebox(  this.classname() +" - Salvataggio non riuscito!",sqlca.sqlerrtext)
end if

end event

type dw_3 from udw_000 within w_scad_buratto_rpt
integer x = 3534
integer y = 4
integer width = 681
integer height = 156
integer taborder = 33
boolean bringtotop = true
string dataobject = "d_da_data_a_data"
end type

event itemchanged;call super::itemchanged;if dwo.name="a_data" then
	string ls_filter
	date ldt_inizio, ldt_fine
	ldt_inizio=getitemdate( 1, "da_data")
	ldt_fine=date(data)
	dw_1.setfilter("")
	dw_1.filter()
//	ls_filter=dw_1.describe("datawindow.table.filter")
//	if isnull(ls_filter) or ls_filter="?" then 
//		ls_filter=""
//	else
//		ls_filter+=" and "
//	end if
	IF dw_1.dataobject="d_fermo_galvanica_scadenza_gd" THEN LS_FILTER= "c_galvanica >'' and "
	ls_filter+= "  c_data_consegna  >= date("+string(ldt_inizio, "yyyy-mm-dd")+") and  c_data_consegna  <= date("+string(ldt_fine, "yyyy-mm-dd") +")"
	dw_1.setfilter(ls_filter)
	dw_1.filter()
	
	
end if
end event

type st_3 from statictext within w_scad_buratto_rpt
integer x = 2743
integer width = 457
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "N.BOL. Contiene:"
boolean focusrectangle = false
end type

type cbx_1 from checkbox within w_scad_buratto_rpt
integer x = 1573
integer y = 40
integer width = 402
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Vedi Tutto"
end type

event clicked;integer i
string ls_campo[]

ls_campo[1]="documento_num_documento_1"
ls_campo[2]="documento_data_documento"
ls_campo[3]="documento_num_documento"
ls_campo[4]="riga_documento_id_articolo"
ls_campo[5]="riga_documento_descrizione"
ls_campo[6]="riga_documento_quantita"
ls_campo[7]="riga_documento_peso_netto"
ls_campo[8]="c_data_consegna"
ls_campo[9]="c_galvanica"
ls_campo[10]="num_ordine"
ls_campo[11]="c_giorno"
if checked then
	for i=1 to upperbound(ls_campo)
		ls_campo[i]+=".visible=1"
		dw_1.modify(ls_campo[i])
	next
else
	//ls_campo[i]+=".visible='1~tif(documento_num_documento=documento_num_documento[-1] and getrow()>1, 0,1)'"

	//20250508: se si rivogliono vedere filtrati NON doppi si chiude e si riapre .... sigh!!!
	for i=1 to upperbound(ls_campo)
		ls_campo[i]+=".visible='1~tif(documento_num_documento=documento_num_documento[-1] and getrow()>1, 0,1)'"
		dw_1.modify(ls_campo[i])
	next
	
end if
end event

