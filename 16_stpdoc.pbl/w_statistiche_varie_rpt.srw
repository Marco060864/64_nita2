forward
global type w_statistiche_varie_rpt from w_stampa_001
end type
type cb_ordina from commandbutton within w_statistiche_varie_rpt
end type
type cbx_1 from checkbox within w_statistiche_varie_rpt
end type
type cbx_2 from checkbox within w_statistiche_varie_rpt
end type
end forward

global type w_statistiche_varie_rpt from w_stampa_001
cb_ordina cb_ordina
cbx_1 cbx_1
cbx_2 cbx_2
end type
global w_statistiche_varie_rpt w_statistiche_varie_rpt

type variables
s_param_articoli istr_par

string is_h_g1, is_h_g2
end variables

on w_statistiche_varie_rpt.create
int iCurrent
call super::create
this.cb_ordina=create cb_ordina
this.cbx_1=create cbx_1
this.cbx_2=create cbx_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ordina
this.Control[iCurrent+2]=this.cbx_1
this.Control[iCurrent+3]=this.cbx_2
end on

on w_statistiche_varie_rpt.destroy
call super::destroy
destroy(this.cb_ordina)
destroy(this.cbx_1)
destroy(this.cbx_2)
end on

event open;

istr_par=message.powerobjectparm

dw_1.dataobject=istr_par.tipo_stampa

dw_1.settransobject(sqlca)
if istr_par.tipo_stampa='d_statistiche_art_venduto_rpt' then
	
end if

dw_1.retrieve(istr_par.da_data, istr_par.a_data)




end event

type dw_1 from w_stampa_001`dw_1 within w_statistiche_varie_rpt
integer taborder = 60
string dataobject = "d_statistiche_varie_rpt"
end type

event dw_1::sqlpreview;call super::sqlpreview;string ls_sql, ls_appoggio
ls_sql=upper(sqlsyntax)
long ll_id_lista, ll_conta, ll_conta_ok


if isvalid(istr_par) then
	
	if istr_par.da_sog_comm>"" then
		
		ls_sql+=" and sog_commerciale.codice>='"+istr_par.da_sog_comm+"' "
	end if
	if istr_par.a_sog_comm>"" then
		ls_sql+=" and sog_commerciale.codice<='"+istr_par.a_sog_comm+"' "
	end if
	if istr_par.da_cod_art>"" then
		ls_sql+=" and articolo.codice>='"+istr_par.da_cod_art+"' "	
	end if
	if istr_par.a_cod_art>"" then
		ls_sql+=" and articolo.codice<='"+istr_par.a_cod_art+"' "	
	end if

	//se è alzato un flag allora invece di "and" è una "or" con il registro
	if istr_par.ordinamento='S' then
		ls_sql+=" and (documento.id_prof_documento="+string(istr_par.ll_magazzino)+&
					" or registro.tipo_registro='"+(istr_par.solo_preziosi)+"') "
	else
	
		if istr_par.ll_magazzino>0 then
			ls_sql+=" and documento.id_prof_documento="+string(istr_par.ll_magazzino)	
		end if
		
		//solo preziosi sta per tipo registro, quindi faccio filtro per tipo registro ...
		if istr_par.solo_preziosi>"" then
			ls_sql+=" and registro.tipo_registro='"+(istr_par.solo_preziosi)+"' "
		end if
	end if

	
	for ll_conta=1 to upperbound(istr_par.li_titolo)
		if ll_conta=1 then
			ls_sql+=" and (cat_zona.id_cat_zona="+string(istr_par.li_titolo[ll_conta])
		else
			ls_sql+=" or cat_zona.id_cat_zona="+string(istr_par.li_titolo[ll_conta])
		end if
		
	next
	if upperbound(istr_par.li_titolo)>0 then ls_sql+=" ) "
	
	
end if
select k.id_lista_articoli
into :ll_id_lista
from lista_art_key k, lista_art_def d
where d.id_lista_articoli=k.id_lista_articoli
and d.cod_lista_articoli='XXXX'
;
if ll_id_lista>0 then
	do
		ll_conta=pos(ls_sql, "WHERE", ll_conta+1)
		if ll_conta>0 then ll_conta_ok=ll_conta
	loop while ll_conta>0 
	if ll_conta_ok>0 then
		ls_sql=left(ls_sql, ll_conta_ok - 1)+ ", lista_art_key "+right(ls_sql, len(ls_sql) - (ll_conta_ok -1))
		ls_sql+=" and lista_art_key.id_articolo=articolo.id_articolo and lista_art_key.id_lista_articoli="+string(ll_id_lista)		
	end if
end if


if len(ls_sql)>len(sqlsyntax) then
	setsqlpreview(ls_sql)
end if
end event

event dw_1::retrieveend;is_h_g1=dw_1.describe("datawindow.trailer.1.height")
is_h_g2=dw_1.describe("datawindow.trailer.2.height")
end event

event dw_1::doubleclicked;call super::doubleclicked;long ll_id_doc
w_orafo_documento_ordine_cx w_orafo
s_list_main s_list

if row<=0  then return
s_list.s_identifica[1]="id_documento"
s_list.s_modo=modo_modifica
ll_id_doc=getitemnumber(row, "id_documento")
if ll_id_doc>0 then
	s_list.l_identifica[1]=ll_id_doc
	openwithparm(w_orafo, s_list)
end if
end event

type sle_pg from w_stampa_001`sle_pg within w_statistiche_varie_rpt
integer taborder = 80
end type

type st_1 from w_stampa_001`st_1 within w_statistiche_varie_rpt
integer x = 1193
integer width = 283
end type

type st_2 from w_stampa_001`st_2 within w_statistiche_varie_rpt
end type

type sle_copie from w_stampa_001`sle_copie within w_statistiche_varie_rpt
integer taborder = 90
end type

type sle_zoom from w_stampa_001`sle_zoom within w_statistiche_varie_rpt
integer x = 512
integer width = 137
integer taborder = 70
end type

type cb_salva_su_file from w_stampa_001`cb_salva_su_file within w_statistiche_varie_rpt
integer taborder = 50
end type

type cb_7 from w_stampa_001`cb_7 within w_statistiche_varie_rpt
integer x = 658
integer width = 96
integer taborder = 40
end type

type cb_6 from w_stampa_001`cb_6 within w_statistiche_varie_rpt
integer x = 416
integer width = 96
integer taborder = 120
end type

type cb_imp_st from w_stampa_001`cb_imp_st within w_statistiche_varie_rpt
integer taborder = 30
end type

type cb_stampa from w_stampa_001`cb_stampa within w_statistiche_varie_rpt
end type

type cb_preview from w_stampa_001`cb_preview within w_statistiche_varie_rpt
integer taborder = 100
end type

type cb_pg_dopo from w_stampa_001`cb_pg_dopo within w_statistiche_varie_rpt
integer x = 329
integer width = 78
integer taborder = 110
end type

type cb_pg_prima from w_stampa_001`cb_pg_prima within w_statistiche_varie_rpt
integer x = 242
integer width = 78
integer taborder = 130
end type

type cb_1 from w_stampa_001`cb_1 within w_statistiche_varie_rpt
integer width = 197
integer taborder = 140
end type

type cb_ordina from commandbutton within w_statistiche_varie_rpt
integer x = 768
integer y = 32
integer width = 210
integer height = 88
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ordina"
end type

event clicked;string ls_null
setnull(ls_null)
dw_1.setsort(ls_null)
dw_1.sort()
dw_1.groupcalc()

end event

type cbx_1 from checkbox within w_statistiche_varie_rpt
integer x = 997
integer width = 160
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "G1:"
boolean checked = true
boolean lefttext = true
end type

event clicked;if checked then
	dw_1.modify("datawindow.trailer.1.height = "+is_h_g1)
else
	dw_1.modify("datawindow.trailer.1.height = 0")
end if
end event

type cbx_2 from checkbox within w_statistiche_varie_rpt
integer x = 997
integer y = 64
integer width = 155
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "G2:"
boolean checked = true
boolean lefttext = true
end type

event clicked;if checked then
	dw_1.modify("datawindow.trailer.2.height = "+is_h_g2)
else
	dw_1.modify("datawindow.trailer.2.height = 0")
end if
end event

