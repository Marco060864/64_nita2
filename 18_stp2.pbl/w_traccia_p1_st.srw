forward
global type w_traccia_p1_st from w_stampa
end type
type sle_bol from singlelineedit within w_traccia_p1_st
end type
type pb_2 from picturebutton within w_traccia_p1_st
end type
type dw_2 from udw_000 within w_traccia_p1_st
end type
type pb_3 from picturebutton within w_traccia_p1_st
end type
type cbx_bsgrassa from checkbox within w_traccia_p1_st
end type
type cbx_bcarrello from checkbox within w_traccia_p1_st
end type
type cbx_bcassa from checkbox within w_traccia_p1_st
end type
type cbx_btriplo from checkbox within w_traccia_p1_st
end type
type cbx_1controllo from checkbox within w_traccia_p1_st
end type
type cbx_csgrosso from checkbox within w_traccia_p1_st
end type
type cbx_clucido from checkbox within w_traccia_p1_st
end type
type cbx_cexlucido from checkbox within w_traccia_p1_st
end type
type cbx_ccarrello from checkbox within w_traccia_p1_st
end type
type cbx_cspazzola from checkbox within w_traccia_p1_st
end type
type rb_bsgrassa from radiobutton within w_traccia_p1_st
end type
type rb_bcarrello from radiobutton within w_traccia_p1_st
end type
type rb_bcassa from radiobutton within w_traccia_p1_st
end type
type rb_btriplo from radiobutton within w_traccia_p1_st
end type
type rb_clucido from radiobutton within w_traccia_p1_st
end type
type rb_cexlucido from radiobutton within w_traccia_p1_st
end type
type rb_1_controllo from radiobutton within w_traccia_p1_st
end type
type rb_csgrosso from radiobutton within w_traccia_p1_st
end type
type rb_ccarrello from radiobutton within w_traccia_p1_st
end type
type rb_sspazzola from radiobutton within w_traccia_p1_st
end type
type rb_tutti from radiobutton within w_traccia_p1_st
end type
type ddlb_filtra from dropdownlistbox within w_traccia_p1_st
end type
end forward

global type w_traccia_p1_st from w_stampa
integer width = 8087
integer height = 1908
sle_bol sle_bol
pb_2 pb_2
dw_2 dw_2
pb_3 pb_3
cbx_bsgrassa cbx_bsgrassa
cbx_bcarrello cbx_bcarrello
cbx_bcassa cbx_bcassa
cbx_btriplo cbx_btriplo
cbx_1controllo cbx_1controllo
cbx_csgrosso cbx_csgrosso
cbx_clucido cbx_clucido
cbx_cexlucido cbx_cexlucido
cbx_ccarrello cbx_ccarrello
cbx_cspazzola cbx_cspazzola
rb_bsgrassa rb_bsgrassa
rb_bcarrello rb_bcarrello
rb_bcassa rb_bcassa
rb_btriplo rb_btriplo
rb_clucido rb_clucido
rb_cexlucido rb_cexlucido
rb_1_controllo rb_1_controllo
rb_csgrosso rb_csgrosso
rb_ccarrello rb_ccarrello
rb_sspazzola rb_sspazzola
rb_tutti rb_tutti
ddlb_filtra ddlb_filtra
end type
global w_traccia_p1_st w_traccia_p1_st

type variables
string is_sql
end variables

on w_traccia_p1_st.create
int iCurrent
call super::create
this.sle_bol=create sle_bol
this.pb_2=create pb_2
this.dw_2=create dw_2
this.pb_3=create pb_3
this.cbx_bsgrassa=create cbx_bsgrassa
this.cbx_bcarrello=create cbx_bcarrello
this.cbx_bcassa=create cbx_bcassa
this.cbx_btriplo=create cbx_btriplo
this.cbx_1controllo=create cbx_1controllo
this.cbx_csgrosso=create cbx_csgrosso
this.cbx_clucido=create cbx_clucido
this.cbx_cexlucido=create cbx_cexlucido
this.cbx_ccarrello=create cbx_ccarrello
this.cbx_cspazzola=create cbx_cspazzola
this.rb_bsgrassa=create rb_bsgrassa
this.rb_bcarrello=create rb_bcarrello
this.rb_bcassa=create rb_bcassa
this.rb_btriplo=create rb_btriplo
this.rb_clucido=create rb_clucido
this.rb_cexlucido=create rb_cexlucido
this.rb_1_controllo=create rb_1_controllo
this.rb_csgrosso=create rb_csgrosso
this.rb_ccarrello=create rb_ccarrello
this.rb_sspazzola=create rb_sspazzola
this.rb_tutti=create rb_tutti
this.ddlb_filtra=create ddlb_filtra
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_bol
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.dw_2
this.Control[iCurrent+4]=this.pb_3
this.Control[iCurrent+5]=this.cbx_bsgrassa
this.Control[iCurrent+6]=this.cbx_bcarrello
this.Control[iCurrent+7]=this.cbx_bcassa
this.Control[iCurrent+8]=this.cbx_btriplo
this.Control[iCurrent+9]=this.cbx_1controllo
this.Control[iCurrent+10]=this.cbx_csgrosso
this.Control[iCurrent+11]=this.cbx_clucido
this.Control[iCurrent+12]=this.cbx_cexlucido
this.Control[iCurrent+13]=this.cbx_ccarrello
this.Control[iCurrent+14]=this.cbx_cspazzola
this.Control[iCurrent+15]=this.rb_bsgrassa
this.Control[iCurrent+16]=this.rb_bcarrello
this.Control[iCurrent+17]=this.rb_bcassa
this.Control[iCurrent+18]=this.rb_btriplo
this.Control[iCurrent+19]=this.rb_clucido
this.Control[iCurrent+20]=this.rb_cexlucido
this.Control[iCurrent+21]=this.rb_1_controllo
this.Control[iCurrent+22]=this.rb_csgrosso
this.Control[iCurrent+23]=this.rb_ccarrello
this.Control[iCurrent+24]=this.rb_sspazzola
this.Control[iCurrent+25]=this.rb_tutti
this.Control[iCurrent+26]=this.ddlb_filtra
end on

on w_traccia_p1_st.destroy
call super::destroy
destroy(this.sle_bol)
destroy(this.pb_2)
destroy(this.dw_2)
destroy(this.pb_3)
destroy(this.cbx_bsgrassa)
destroy(this.cbx_bcarrello)
destroy(this.cbx_bcassa)
destroy(this.cbx_btriplo)
destroy(this.cbx_1controllo)
destroy(this.cbx_csgrosso)
destroy(this.cbx_clucido)
destroy(this.cbx_cexlucido)
destroy(this.cbx_ccarrello)
destroy(this.cbx_cspazzola)
destroy(this.rb_bsgrassa)
destroy(this.rb_bcarrello)
destroy(this.rb_bcassa)
destroy(this.rb_btriplo)
destroy(this.rb_clucido)
destroy(this.rb_cexlucido)
destroy(this.rb_1_controllo)
destroy(this.rb_csgrosso)
destroy(this.rb_ccarrello)
destroy(this.rb_sspazzola)
destroy(this.rb_tutti)
destroy(this.ddlb_filtra)
end on

event open;call super::open;dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)

dw_2.insertrow(1)
dw_2.setitem(1, "da_data", relativedate(date(today()), - 30))
dw_2.setitem(1, "a_data", today())
dw_1.retrieve(relativedate(date(today()), - 30), today())

dw_1.modify("detail.background.color=255")

end event

type pb_1 from w_stampa`pb_1 within w_traccia_p1_st
integer x = 2267
end type

type cb_preview from w_stampa`cb_preview within w_traccia_p1_st
integer x = 1664
end type

type dw_1 from w_stampa`dw_1 within w_traccia_p1_st
integer x = 9
integer y = 180
integer width = 7991
string dataobject = "d_tracciagen__h2test"
boolean hsplitscroll = true
end type

event dw_1::sqlpreview;call super::sqlpreview;string ls_sql
integer i

if is_sql> " " then
	ls_sql=sqlsyntax
	ls_sql+= is_sql
	i=SetSQLPreview(ls_sql)
	is_sql=""
	sle_bol.text=""
end if
	
end event

type pb_salva_su_file from w_stampa`pb_salva_su_file within w_traccia_p1_st
integer x = 2071
end type

type pb_stampa from w_stampa`pb_stampa within w_traccia_p1_st
integer x = 1861
end type

type sle_pg from w_stampa`sle_pg within w_traccia_p1_st
integer x = 1317
end type

type st_1 from w_stampa`st_1 within w_traccia_p1_st
integer x = 1038
end type

type st_2 from w_stampa`st_2 within w_traccia_p1_st
end type

type sle_copie from w_stampa`sle_copie within w_traccia_p1_st
end type

type sle_zoom from w_stampa`sle_zoom within w_traccia_p1_st
end type

type cb_7 from w_stampa`cb_7 within w_traccia_p1_st
end type

type cb_6 from w_stampa`cb_6 within w_traccia_p1_st
end type

type cb_pg_dopo from w_stampa`cb_pg_dopo within w_traccia_p1_st
end type

type cb_pg_prima from w_stampa`cb_pg_prima within w_traccia_p1_st
end type

type cb_esci from w_stampa`cb_esci within w_traccia_p1_st
integer x = 7547
integer y = 8
end type

type sle_bol from singlelineedit within w_traccia_p1_st
integer x = 3177
integer y = 32
integer width = 407
integer height = 100
integer taborder = 18
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
borderstyle borderstyle = stylelowered!
end type

type pb_2 from picturebutton within w_traccia_p1_st
boolean visible = false
integer x = 677
integer width = 119
integer height = 120
integer taborder = 28
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\nita\icone\Ricerca.png"
alignment htextalign = left!
end type

event clicked;string ls_filtro

ls_filtro=sle_bol.text
if ls_filtro> " " then
	//is_sql=" and c_num_bollettina like '%"+ls_filtro+"'"
	dw_1.dataobject="d_traccia_h"
	dw_1.settransobject(sqlca)	
	ls_filtro="%"+ls_filtro
	dw_1.retrieve(ls_filtro)
	parent.width=5550
	dw_1.width=parent.width - 200
else
	dw_1.dataobject="d_traccia_p1"
	dw_1.settransobject(sqlca)	
	dw_1.retrieve()
	parent.width=3550
	dw_1.width=parent.width - 200
end if

end event

type dw_2 from udw_000 within w_traccia_p1_st
integer x = 2459
integer y = 8
integer width = 681
integer height = 148
integer taborder = 28
boolean bringtotop = true
string dataobject = "d_da_data_a_data"
end type

event itemchanged;call super::itemchanged;date ld_da_data, ld_a_data

if dwo.name="a_data" then
	ld_da_data=getitemdate(1, "da_data")
	ld_a_data=date(data)
	if ld_a_data>date("1900-01-01") then
		dw_1.retrieve(ld_da_data, ld_a_data)
	end if
end if
end event

type pb_3 from picturebutton within w_traccia_p1_st
integer x = 3616
integer y = 36
integer width = 119
integer height = 120
integer taborder = 38
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\nita\icone\Ricerca.png"
alignment htextalign = left!
end type

event clicked;string ls_filtro

ls_filtro=sle_bol.text
if ls_filtro> " " then
	DW_1.SETFILTER("NUM_DOCUMENTO like '%"+LS_FILTRO+"'")
else
	DW_1.SETFILTER("")
end if
DW_1.FILTER()

end event

type cbx_bsgrassa from checkbox within w_traccia_p1_st
boolean visible = false
integer x = 3863
integer y = 180
integer width = 343
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "BSGRASSA"
end type

event clicked;string ls_filtro

if checked then
	
	ls_filtro="c_"+this.text+" >' '"
else
	ls_filtro=""
end if
dw_1.setfilter(ls_filtro)
dw_1.filter()
end event

type cbx_bcarrello from checkbox within w_traccia_p1_st
boolean visible = false
integer x = 4224
integer y = 180
integer width = 352
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "BCARRELLO"
end type

event clicked;string ls_filtro

if checked then
	ls_filtro="c_"+this.text+" >' '"
else
	ls_filtro=""
end if
dw_1.setfilter(ls_filtro)
dw_1.filter()
end event

type cbx_bcassa from checkbox within w_traccia_p1_st
boolean visible = false
integer x = 4613
integer y = 180
integer width = 343
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "BCASSA"
end type

event clicked;string ls_filtro

if checked then
	ls_filtro="c_"+this.text+" >' '"
else
	ls_filtro=""
end if
dw_1.setfilter(ls_filtro)
dw_1.filter()
end event

type cbx_btriplo from checkbox within w_traccia_p1_st
boolean visible = false
integer x = 4969
integer y = 180
integer width = 352
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "BTRIPLO"
end type

event clicked;string ls_filtro

if checked then
	ls_filtro="c_"+this.text+" >' '"
else
	ls_filtro=""
end if
dw_1.setfilter(ls_filtro)
dw_1.filter()
end event

type cbx_1controllo from checkbox within w_traccia_p1_st
boolean visible = false
integer x = 5307
integer y = 180
integer width = 402
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "1CONTROLLO"
end type

event clicked;string ls_filtro

if checked then
	ls_filtro="c_"+this.text+" >' '"
else
	ls_filtro=""
end if
dw_1.setfilter(ls_filtro)
dw_1.filter()
end event

type cbx_csgrosso from checkbox within w_traccia_p1_st
boolean visible = false
integer x = 5719
integer y = 180
integer width = 352
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "CSGROSSO"
end type

event clicked;string ls_filtro

if checked then
	ls_filtro="c_"+this.text+" >' '"
else
	ls_filtro=""
end if
dw_1.setfilter(ls_filtro)
dw_1.filter()
end event

type cbx_clucido from checkbox within w_traccia_p1_st
boolean visible = false
integer x = 6112
integer y = 880
integer width = 343
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "CLUCIDO"
end type

event clicked;string ls_filtro

if checked then
	ls_filtro="c_"+this.text+" >' '"
else
	ls_filtro=""
end if
dw_1.setfilter(ls_filtro)
dw_1.filter()
end event

type cbx_cexlucido from checkbox within w_traccia_p1_st
boolean visible = false
integer x = 6478
integer y = 180
integer width = 352
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "CEXLUCIDO"
end type

event clicked;string ls_filtro

if checked then
	ls_filtro="c_"+this.text+" >' '"
else
	ls_filtro=""
end if
dw_1.setfilter(ls_filtro)
dw_1.filter()
end event

type cbx_ccarrello from checkbox within w_traccia_p1_st
boolean visible = false
integer x = 6907
integer y = 180
integer width = 352
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "CCARRELLO"
end type

event clicked;string ls_filtro

if checked then
	ls_filtro="c_"+this.text+" >' '"
else
	ls_filtro=""
end if
dw_1.setfilter(ls_filtro)
dw_1.filter()
end event

type cbx_cspazzola from checkbox within w_traccia_p1_st
boolean visible = false
integer x = 7209
integer y = 180
integer width = 361
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "SSPAZZOLA"
end type

event clicked;string ls_filtro

if checked then
	ls_filtro="c_"+this.text+" >' '"
else
	ls_filtro=""
end if
dw_1.setfilter(ls_filtro)
dw_1.filter()
end event

type rb_bsgrassa from radiobutton within w_traccia_p1_st
boolean visible = false
integer x = 3854
integer y = 888
integer width = 343
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "BSGRASSA"
end type

event clicked;string ls_filtro

if checked then
	
	ls_filtro="c_"+this.text+" >' '"
else
	ls_filtro=""
end if
dw_1.setfilter(ls_filtro)
dw_1.filter()
end event

type rb_bcarrello from radiobutton within w_traccia_p1_st
boolean visible = false
integer x = 4229
integer y = 888
integer width = 352
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "BCARRELLO"
end type

event clicked;string ls_filtro

if checked then
	
	ls_filtro="c_"+this.text+" >' '"
else
	ls_filtro=""
end if
dw_1.setfilter(ls_filtro)
dw_1.filter()
end event

type rb_bcassa from radiobutton within w_traccia_p1_st
boolean visible = false
integer x = 4613
integer y = 888
integer width = 343
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "BCASSA"
end type

event clicked;string ls_filtro

if checked then
	
	ls_filtro="c_"+this.text+" >' '"
else
	ls_filtro=""
end if
dw_1.setfilter(ls_filtro)
dw_1.filter()
end event

type rb_btriplo from radiobutton within w_traccia_p1_st
boolean visible = false
integer x = 4987
integer y = 888
integer width = 311
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "BTRIPLO"
end type

event clicked;string ls_filtro

if checked then
	
	ls_filtro="c_"+this.text+" >' '"
else
	ls_filtro=""
end if
dw_1.setfilter(ls_filtro)
dw_1.filter()
end event

type rb_clucido from radiobutton within w_traccia_p1_st
boolean visible = false
integer x = 6121
integer y = 1104
integer width = 343
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "CLUCIDO"
end type

event clicked;string ls_filtro

if checked then
	
	ls_filtro="c_"+this.text+" >' '"
else
	ls_filtro=""
end if
dw_1.setfilter(ls_filtro)
dw_1.filter()
end event

type rb_cexlucido from radiobutton within w_traccia_p1_st
boolean visible = false
integer x = 6491
integer y = 888
integer width = 343
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "CEXLUCIDO"
end type

event clicked;string ls_filtro

if checked then
	
	ls_filtro="c_"+this.text+" >' '"
else
	ls_filtro=""
end if
dw_1.setfilter(ls_filtro)
dw_1.filter()
end event

type rb_1_controllo from radiobutton within w_traccia_p1_st
boolean visible = false
integer x = 5326
integer y = 888
integer width = 411
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "1_CONTROLLO"
end type

event clicked;string ls_filtro

if checked then
	
	ls_filtro="c_bcontrollo"+" >' '"
else
	ls_filtro=""
end if
dw_1.setfilter(ls_filtro)
dw_1.filter()
end event

type rb_csgrosso from radiobutton within w_traccia_p1_st
boolean visible = false
integer x = 5737
integer y = 888
integer width = 343
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "CSGROSSO"
end type

event clicked;string ls_filtro

if checked then
	
	ls_filtro="c_"+this.text+" >' '"
else
	ls_filtro=""
end if
dw_1.setfilter(ls_filtro)
dw_1.filter()
end event

type rb_ccarrello from radiobutton within w_traccia_p1_st
boolean visible = false
integer x = 6857
integer y = 888
integer width = 352
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "CCARRELLO"
end type

event clicked;string ls_filtro

if checked then
	
	ls_filtro="c_"+this.text+" >' '"
else
	ls_filtro=""
end if
dw_1.setfilter(ls_filtro)
dw_1.filter()
end event

type rb_sspazzola from radiobutton within w_traccia_p1_st
boolean visible = false
integer x = 7255
integer y = 888
integer width = 361
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "SSPAZZOLA"
end type

event clicked;string ls_filtro

if checked then
	
	ls_filtro="c_"+this.text+" >' '"
else
	ls_filtro=""
end if
dw_1.setfilter(ls_filtro)
dw_1.filter()
end event

type rb_tutti from radiobutton within w_traccia_p1_st
boolean visible = false
integer x = 3854
integer y = 804
integer width = 343
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Tutti"
end type

event clicked;string ls_filtro

if checked then
	
	ls_filtro=""
else
	ls_filtro=""
end if
dw_1.setfilter(ls_filtro)
dw_1.filter()
end event

type ddlb_filtra from dropdownlistbox within w_traccia_p1_st
integer x = 3826
integer y = 8
integer width = 480
integer height = 1064
integer taborder = 33
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean allowedit = true
boolean sorted = false
boolean hscrollbar = true
string item[] = {"BSGRASSA","BCARRELLO","BCASSA","BTRIPLO","1_CONTROLLO","CSGROSSO","CLUCIDO","CEXLUCIDO","CCARRELLO","SSPAZZOLA","TUTTI"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;string ls_filtro

ls_filtro=this.TEXT
if ls_filtro="TUTTI" then
	ls_filtro=""
	
else
	ls_filtro="c_"+ls_filtro+" >' '"
end if
dw_1.setfilter(ls_filtro)
dw_1.filter()
end event

