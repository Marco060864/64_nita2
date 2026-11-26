forward
global type w_orafo_st_lista_art_prezzo_peso_gd from window
end type
type dw_2 from udw_000 within w_orafo_st_lista_art_prezzo_peso_gd
end type
type cb_cambia_cat_codifica from commandbutton within w_orafo_st_lista_art_prezzo_peso_gd
end type
type cb_2 from commandbutton within w_orafo_st_lista_art_prezzo_peso_gd
end type
type cb_7 from commandbutton within w_orafo_st_lista_art_prezzo_peso_gd
end type
type cb_6 from commandbutton within w_orafo_st_lista_art_prezzo_peso_gd
end type
type cb_5 from commandbutton within w_orafo_st_lista_art_prezzo_peso_gd
end type
type cb_4 from commandbutton within w_orafo_st_lista_art_prezzo_peso_gd
end type
type dw_1 from datawindow within w_orafo_st_lista_art_prezzo_peso_gd
end type
type cb_3 from commandbutton within w_orafo_st_lista_art_prezzo_peso_gd
end type
type cb_1 from commandbutton within w_orafo_st_lista_art_prezzo_peso_gd
end type
end forward

global type w_orafo_st_lista_art_prezzo_peso_gd from window
integer x = 5
integer y = 364
integer width = 3557
integer height = 1604
boolean titlebar = true
string title = "Stampa Listini"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
windowtype windowtype = popup!
windowstate windowstate = maximized!
long backcolor = 79741120
event ue_post_open ( )
dw_2 dw_2
cb_cambia_cat_codifica cb_cambia_cat_codifica
cb_2 cb_2
cb_7 cb_7
cb_6 cb_6
cb_5 cb_5
cb_4 cb_4
dw_1 dw_1
cb_3 cb_3
cb_1 cb_1
end type
global w_orafo_st_lista_art_prezzo_peso_gd w_orafo_st_lista_art_prezzo_peso_gd

type variables
long il_zoom,il_cat_codifica
string is_filtro
end variables

event ue_post_open;dw_1.Height=(this.Height) - 272
end event

event open;String ls_nome_azienda, ls_filtro, ls_parametri, ls_ordinamento, ls_da_articolo, ls_a_articolo, ls_tipo_arrotondamento
Long	 ll_id_variazione, ll_righe
Integer li_cifra_arrotondamento, li_ret
string ls_des_codifica
datawindowchild dwc_codifica
str_anag_art str_param

ls_filtro=message.StringParm
str_param=message.PowerObjectParm

il_cat_codifica=str_param.id_cat_codifica
dw_2.insertrow(1)
li_ret=dw_2.GetChild('codice', dwc_codifica)
dwc_codifica.settransobject(SQLCA)
ll_righe=dwc_codifica.retrieve()
//dw_2.settransobject(sqlca)
//dw_2.retrieve()
dw_2.setitem(1, "codice", 69)




//select descrizione
//into :ls_des_codifica
//from dba.cat_codifica
//where id_cat_codifica=:il_cat_codifica;
//if ls_des_codifica>"" then
//	dw_1.modify("t_des_cat_codifica.text='pippo'")
//end if
//
ls_filtro=str_param.filtro


is_filtro=str_param.filtro
ls_parametri=str_param.parametri
ls_ordinamento=str_param.ordinamento
ls_da_articolo=str_param.da_art
ls_a_articolo=str_param.a_art
ll_id_variazione=str_param.id_variazione


if str_param.i_tipo_stampa=1 then
	dw_1.dataobject="d_orafo_st_lista_art_pr_peso_mis_gdx"
end if
if  str_param.tipo_stampa='G' then
	dw_1.dataobject="d_orafo_st_lista_art_galvanica_gd"
elseif str_param.tipo_stampa='R' then
	dw_1.dataobject="d_orafo_st_lista_art_galvanica2_gd"
elseif str_param.tipo_stampa='C' then
	dw_1.dataobject="d_confronto_prezzo_rpt"
elseif str_param.tipo_stampa='2' then
	dw_1.dataobject="d_2020_prezzo_gd"
end if


dw_1.settransobject(sqlca)
dw_1.Retrieve(ll_id_variazione, ls_da_articolo, ls_a_articolo, &
str_param.id_valuta, str_param.cambio,str_param.num_dec, str_param.tipo_arr )
If ls_ordinamento = 'A' then
	ls_ordinamento = 'codice'	
ElseIf ls_ordinamento = 'C' then
	ls_ordinamento = 'cat_com_articolo_codice'
ElseIf ls_ordinamento = 'M' then
	ls_ordinamento = 'cat_merceologica_codice'	
ElseIf ls_ordinamento = 'F' then
	ls_ordinamento = 'cat_fiscale_codice'
End If

dw_1.SetSort(ls_ordinamento)
dw_1.Sort()

il_zoom=100
this.event post ue_post_open()
dw_1.groupcalc()






end event

on w_orafo_st_lista_art_prezzo_peso_gd.create
this.dw_2=create dw_2
this.cb_cambia_cat_codifica=create cb_cambia_cat_codifica
this.cb_2=create cb_2
this.cb_7=create cb_7
this.cb_6=create cb_6
this.cb_5=create cb_5
this.cb_4=create cb_4
this.dw_1=create dw_1
this.cb_3=create cb_3
this.cb_1=create cb_1
this.Control[]={this.dw_2,&
this.cb_cambia_cat_codifica,&
this.cb_2,&
this.cb_7,&
this.cb_6,&
this.cb_5,&
this.cb_4,&
this.dw_1,&
this.cb_3,&
this.cb_1}
end on

on w_orafo_st_lista_art_prezzo_peso_gd.destroy
destroy(this.dw_2)
destroy(this.cb_cambia_cat_codifica)
destroy(this.cb_2)
destroy(this.cb_7)
destroy(this.cb_6)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.dw_1)
destroy(this.cb_3)
destroy(this.cb_1)
end on

event key;

keycode			lk_code
string			ls_nome
windowobject	lw_me

lk_code = key

choose case lk_code
	case KeyF12!
		if keyflags=3 then
			ls_nome = this.ClassName()
			MessageBox ("ClassName",ls_nome)
		end if
	case KeyF1!
		if (keyflags = 0 Or keyflags = 1 Or keyflags = 2) then
		end if
end choose
end event

type dw_2 from udw_000 within w_orafo_st_lista_art_prezzo_peso_gd
integer x = 928
integer width = 699
integer height = 164
integer taborder = 60
string dataobject = "d_cod_external"
end type

type cb_cambia_cat_codifica from commandbutton within w_orafo_st_lista_art_prezzo_peso_gd
integer x = 1719
integer y = 48
integer width = 402
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cambia Codifica"
end type

event clicked;integer i, a
string ls_test
long ll_id_cat_codifica,ll_id_articolo

ll_id_cat_codifica=dw_2.getitemnumber(1, "codice")
for i =1 to dw_1.rowcount()
	ls_test=dw_1.getitemstring(i, "c_scelto")
	if ls_test='N' then
		ll_id_articolo=dw_1.getitemnumber(i,"articolo_id_articolo")
		update dba.articolo set id_cat_codifica=:ll_id_cat_codifica
		where id_articolo=:ll_id_articolo;
		if sqlca.sqlNrows>0 then
			commit;
		else
			rollback;
			messagebox("Attenzione", "Articolo: "+string(ll_id_articolo)+ " NON Cambiato!!")
			a++
		end if
	end if
next
messagebox("Benone!", "Spostamento completato con "+string(a)+" errori!")
end event

type cb_2 from commandbutton within w_orafo_st_lista_art_prezzo_peso_gd
integer x = 2981
integer y = 44
integer width = 389
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salva su &File"
end type

event clicked;dw_1.SaveAs()
end event

type cb_7 from commandbutton within w_orafo_st_lista_art_prezzo_peso_gd
event clicked pbm_bnclicked
integer x = 2505
integer y = 44
integer width = 261
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Zoom Out"
end type

event clicked;il_zoom=il_zoom - 10
dw_1.object.datawindow.zoom=il_zoom
end event

type cb_6 from commandbutton within w_orafo_st_lista_art_prezzo_peso_gd
event clicked pbm_bnclicked
integer x = 2231
integer y = 44
integer width = 261
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Zoom In"
end type

event clicked;il_zoom=il_zoom+10
dw_1.object.datawindow.zoom=il_zoom
end event

type cb_5 from commandbutton within w_orafo_st_lista_art_prezzo_peso_gd
integer x = 302
integer y = 48
integer width = 283
integer height = 84
integer taborder = 60
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Pag. Prec."
end type

event clicked;dw_1.ScrollPriorPage ( ) 
end event

type cb_4 from commandbutton within w_orafo_st_lista_art_prezzo_peso_gd
integer x = 608
integer y = 44
integer width = 283
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Pag. Succ."
end type

event clicked;dw_1.ScrollNextPage ( ) 
end event

type dw_1 from datawindow within w_orafo_st_lista_art_prezzo_peso_gd
integer x = 23
integer y = 176
integer width = 3429
integer height = 1280
integer taborder = 70
string dataobject = "d_orafo_st_lista_art_prezzo_peso_gd3"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event sqlpreview;
String ls_filtro
String Ls_SQLSyntax

str_anag_art str_param

str_param=message.PowerObjectParm

if str_param.flag='S' then
  ls_filtro=" prezzo >0 or prezzo_manifattura>0 "
	ls_SQLSyntax = SQLSyntax + ' AND (' + ls_filtro + ') '
	if is_filtro>'' then
		ls_SQLSyntax+=" and ("+is_filtro+")"
	end if
	This.SetSQLPreview(ls_SQLSyntax)	
else
	if is_filtro>'' then
		ls_SQLSyntax = SQLSyntax +" and ("+is_filtro+")"
		This.SetSQLPreview(ls_SQLSyntax)	
	end if
	
end if
if il_cat_codifica>0 then
	ls_SQLSyntax = SQLSyntax +" and articolo.id_cat_codifica="+&
						string(il_cat_codifica)
	This.SetSQLPreview(ls_SQLSyntax)	
end if



end event

type cb_3 from commandbutton within w_orafo_st_lista_art_prezzo_peso_gd
integer x = 3387
integer y = 44
integer width = 247
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stam&pa"
end type

event clicked;printsetup()
dw_1.print()
end event

type cb_1 from commandbutton within w_orafo_st_lista_art_prezzo_peso_gd
integer x = 23
integer y = 44
integer width = 247
integer height = 84
integer taborder = 80
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Annulla"
end type

event clicked;close(parent)
end event

