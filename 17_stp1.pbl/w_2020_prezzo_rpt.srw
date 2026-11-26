forward
global type w_2020_prezzo_rpt from w_stampa
end type
type cbx_1 from checkbox within w_2020_prezzo_rpt
end type
end forward

global type w_2020_prezzo_rpt from w_stampa
integer width = 4503
integer height = 2524
cbx_1 cbx_1
end type
global w_2020_prezzo_rpt w_2020_prezzo_rpt

type variables
s_new_scheda_mag s_new_mag
end variables

on w_2020_prezzo_rpt.create
int iCurrent
call super::create
this.cbx_1=create cbx_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_1
end on

on w_2020_prezzo_rpt.destroy
call super::destroy
destroy(this.cbx_1)
end on

event open;call super::open;string ls_titolo,ls_cat_com
date ldt_inizio, ldt_fine


s_new_mag=message.powerobjectparm
dw_1.dataobject=s_new_mag.tipo_stampa
dw_1.settransobject(sqlca)

dw_1.retrieve(s_new_mag.id_sog_commerciale)


select l.descrizione, data_inizio, data_fine  into :ls_titolo, :ldt_inizio, :ldt_fine 
from dba.listino l, dba.variazione v
where id_variazione=:s_new_mag.id_sog_commerciale
and v.id_listino=l.id_listino
;
ls_titolo="Listino: "+ls_titolo +" Var.: "+string(ldt_inizio, "dd/mm/yy")+"-"+string(ldt_fine, "dd/mm/yy")
//if s_new_mag.id_caus_magazzino[1]>0 then
//	select codice into :ls_cat_com from dba.cat_com_articolo
//	where id_cat_com_articolo=:s_new_mag.id_caus_magazzino[1]
//	;
//	ls_titolo+=" Filtro: Cat. Com: "+ls_cat_com
//end if
//if s_new_mag.sel_causali="S" then
//	ls_titolo+=" e solo prezzi>0"
//end if
dw_1.modify("t_titolo.text='"+ls_titolo+"'")


end event

type pb_1 from w_stampa`pb_1 within w_2020_prezzo_rpt
end type

type cb_preview from w_stampa`cb_preview within w_2020_prezzo_rpt
end type

type dw_1 from w_stampa`dw_1 within w_2020_prezzo_rpt
integer x = 27
integer width = 4384
integer height = 2140
string dataobject = "d_2020_prezzo_ricarichi_tb"
end type

event dw_1::sqlpreview;call super::sqlpreview;string ls_sql
integer li_ret, i

ls_sql=sqlsyntax
if upperbound(s_new_mag.id_caus_magazzino)=1 then
	ls_sql+= " and articolo.id_cat_com_articolo="+string(s_new_mag.id_caus_magazzino[1])+ " "
elseif upperbound(s_new_mag.id_caus_magazzino)>1 then
	for i= 1 to upperbound(s_new_mag.id_caus_magazzino)
		if i=1 then 
			ls_sql+= " and (articolo.id_cat_com_articolo="+string(s_new_mag.id_caus_magazzino[i])+ " "
		else
			ls_sql+= " or articolo.id_cat_com_articolo="+string(s_new_mag.id_caus_magazzino[i])+ " "
		end if
	next
	ls_sql+= ") "
end if

if upperbound(s_new_mag.id_vettore)=1 then
	ls_sql+= " and articolo.id_cat_codifica="+string(s_new_mag.id_vettore[1])+ " "
elseif upperbound(s_new_mag.id_vettore)>1 then
	for i= 1 to upperbound(s_new_mag.id_vettore)
		if i=1 then 
			ls_sql+= " and (articolo.id_cat_codifica="+string(s_new_mag.id_vettore[i])+ " "
		else
			ls_sql+= " or articolo.id_cat_codifica="+string(s_new_mag.id_vettore[i])+ " "
		end if
	next
	ls_sql+= ") "
end if
//20230104 samy vuole anche escludere delle cat codifica...
if upperbound(s_new_mag.id_vettore2)=1 then
	ls_sql+= " and articolo.id_cat_codifica<>"+string(s_new_mag.id_vettore2[1])+ " "
elseif upperbound(s_new_mag.id_vettore2)>1 then
	for i= 1 to upperbound(s_new_mag.id_vettore2)
		if i=1 then 
			ls_sql+= " and (articolo.id_cat_codifica<>"+string(s_new_mag.id_vettore2[i])+ " "
		else
			ls_sql+= " or articolo.id_cat_codifica<>"+string(s_new_mag.id_vettore2[i])+ " "
		end if
	next
	ls_sql+= ") "
end if

//if s_new_mag.id_caus_magazzino[2]>0 then
//	ls_sql+= " and articolo.id_cat_codifica="+string(s_new_mag.id_caus_magazzino[2])+ " "
//end if
if s_new_mag.sel_causali='S' then
	ls_sql+= " and (prezzo.prezzo_manifattura>0 ) "   //or prezzo.prezzo>0 ) "
end if
if ls_sql>sqlsyntax then
	li_ret=SetSQLPreview(ls_SQL)	
end if
end event

type pb_salva_su_file from w_stampa`pb_salva_su_file within w_2020_prezzo_rpt
end type

type pb_stampa from w_stampa`pb_stampa within w_2020_prezzo_rpt
end type

type sle_pg from w_stampa`sle_pg within w_2020_prezzo_rpt
end type

type st_1 from w_stampa`st_1 within w_2020_prezzo_rpt
end type

type st_2 from w_stampa`st_2 within w_2020_prezzo_rpt
end type

type sle_copie from w_stampa`sle_copie within w_2020_prezzo_rpt
end type

type sle_zoom from w_stampa`sle_zoom within w_2020_prezzo_rpt
end type

type cb_7 from w_stampa`cb_7 within w_2020_prezzo_rpt
end type

type cb_6 from w_stampa`cb_6 within w_2020_prezzo_rpt
end type

type cb_pg_dopo from w_stampa`cb_pg_dopo within w_2020_prezzo_rpt
end type

type cb_pg_prima from w_stampa`cb_pg_prima within w_2020_prezzo_rpt
end type

type cb_esci from w_stampa`cb_esci within w_2020_prezzo_rpt
integer x = 4151
integer y = 28
integer height = 124
end type

type cbx_1 from checkbox within w_2020_prezzo_rpt
integer x = 2770
integer y = 52
integer width = 370
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
string text = "Togli Flag"
end type

event clicked;if checked then
	dw_1.modify("c_esiste_distinta.visible= 0")
else
	dw_1.modify("c_esiste_distinta.visible= 1")
end if
end event

