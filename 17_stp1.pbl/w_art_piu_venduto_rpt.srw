forward
global type w_art_piu_venduto_rpt from w_stampa_001
end type
type rb_vedi_righe from radiobutton within w_art_piu_venduto_rpt
end type
type rb_2 from radiobutton within w_art_piu_venduto_rpt
end type
type rb_3 from radiobutton within w_art_piu_venduto_rpt
end type
end forward

global type w_art_piu_venduto_rpt from w_stampa_001
integer width = 3653
rb_vedi_righe rb_vedi_righe
rb_2 rb_2
rb_3 rb_3
end type
global w_art_piu_venduto_rpt w_art_piu_venduto_rpt

type variables
long il_cliente, il_id_art
string as_da_articolo, as_ad_articolo, is_messaggio
end variables

on w_art_piu_venduto_rpt.create
int iCurrent
call super::create
this.rb_vedi_righe=create rb_vedi_righe
this.rb_2=create rb_2
this.rb_3=create rb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_vedi_righe
this.Control[iCurrent+2]=this.rb_2
this.Control[iCurrent+3]=this.rb_3
end on

on w_art_piu_venduto_rpt.destroy
call super::destroy
destroy(this.rb_vedi_righe)
destroy(this.rb_2)
destroy(this.rb_3)
end on

event open;call super::open;str_fil_flag str_param



dw_1.settransobject(sqlca)

str_param=message.powerobjectparm

il_cliente=str_param.id_banca
as_da_articolo=str_param.da_cod
as_ad_articolo=str_param.a_cod

if str_param.flag<>"d_art_piu_venduto" and str_param.flag>" " then
	dw_1.dataobject=str_param.flag
	dw_1.settransobject(sqlca)	
end if
if str_param.flag="d_mov_art_fo" then
	is_messaggio=str_param.parametri
	select id_articolo into :il_id_art from dba.articolo where codice=:str_param.da_cod;
//	dw_1.retrieve(str_param.da_data, str_param.a_data, str_param.id_banca, ll_id_art )
else
	is_messaggio="Articoli più lavorati "+str_param.parametri
end if
dw_1.retrieve(str_param.da_data, str_param.a_data)

dw_1.object.t_1.text=is_messaggio

dw_1.post sort()
end event

type dw_1 from w_stampa_001`dw_1 within w_art_piu_venduto_rpt
integer x = 27
integer y = 156
integer width = 3543
integer height = 1512
string dataobject = "d_art_piu_venduto"
end type

event dw_1::sqlpreview;call super::sqlpreview;string ls_sql

integer i
//if pos(is_messaggio, "Mov.")>0 then return 
ls_sql=sqlsyntax

if pos(is_messaggio, "Mov.")>0 then
		ls_sql+=" and riga_documento.id_articolo="+string(il_id_art)+" " 
else
	if as_da_articolo> " " then
			ls_sql+=" and articolo.codice>='"+as_da_articolo+"' " 
	end if
	if as_ad_articolo> " " then
		ls_sql+=" and articolo.codice<='"+as_ad_articolo+"' "
	end if
end if
if il_cliente> 0 then
	ls_sql+=" and documento.id_sog_commerciale="+string(il_cliente) 
end if
if ls_sql<>sqlsyntax then
	i=SetSQLPreview(ls_sql)
	if i<>1 then
		messagebox("Errore!", "Filtro non applicato!")
	end if
end if
end event

type sle_pg from w_stampa_001`sle_pg within w_art_piu_venduto_rpt
integer x = 1783
integer width = 174
end type

type st_1 from w_stampa_001`st_1 within w_art_piu_venduto_rpt
integer x = 1632
integer width = 160
string text = "St.Pg.:"
end type

type st_2 from w_stampa_001`st_2 within w_art_piu_venduto_rpt
end type

type sle_copie from w_stampa_001`sle_copie within w_art_piu_venduto_rpt
end type

type sle_zoom from w_stampa_001`sle_zoom within w_art_piu_venduto_rpt
integer x = 667
end type

type cb_salva_su_file from w_stampa_001`cb_salva_su_file within w_art_piu_venduto_rpt
end type

type cb_7 from w_stampa_001`cb_7 within w_art_piu_venduto_rpt
integer x = 818
end type

type cb_6 from w_stampa_001`cb_6 within w_art_piu_venduto_rpt
integer x = 553
end type

type cb_imp_st from w_stampa_001`cb_imp_st within w_art_piu_venduto_rpt
end type

type cb_stampa from w_stampa_001`cb_stampa within w_art_piu_venduto_rpt
end type

type cb_preview from w_stampa_001`cb_preview within w_art_piu_venduto_rpt
end type

type cb_pg_dopo from w_stampa_001`cb_pg_dopo within w_art_piu_venduto_rpt
end type

type cb_pg_prima from w_stampa_001`cb_pg_prima within w_art_piu_venduto_rpt
end type

type cb_1 from w_stampa_001`cb_1 within w_art_piu_venduto_rpt
end type

type rb_vedi_righe from radiobutton within w_art_piu_venduto_rpt
integer x = 951
integer y = 72
integer width = 320
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Vedi Righe"
end type

event clicked;if checked then
	dw_1.modify("datawindow.detail.height = 80")
else
	dw_1.modify("datawindow.detail.height = 0")
end if
end event

type rb_2 from radiobutton within w_art_piu_venduto_rpt
integer x = 1275
integer width = 320
integer height = 92
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Per Codice"
end type

event clicked;dw_1.setsort("articolo_codice A, documento_data_documento A, documento_num_documento A ")
dw_1.sort()
end event

type rb_3 from radiobutton within w_art_piu_venduto_rpt
integer x = 1271
integer y = 76
integer width = 347
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Per Venduto"
boolean checked = true
end type

event clicked;dw_1.setsort("c_sum_peso_netto D, articolo_codice A, documento_data_documento A, documento_num_documento A ")
dw_1.sort()
end event

