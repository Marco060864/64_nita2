forward
global type w_rinumera_bol_da_ordine_cx from w_001
end type
type dw_1 from udw_base within w_rinumera_bol_da_ordine_cx
end type
type cbx_rinumera_cod_barre from checkbox within w_rinumera_bol_da_ordine_cx
end type
type dw_2 from udw_base within w_rinumera_bol_da_ordine_cx
end type
type cb_carica from commandbutton within w_rinumera_bol_da_ordine_cx
end type
type cb_salva from commandbutton within w_rinumera_bol_da_ordine_cx
end type
end forward

global type w_rinumera_bol_da_ordine_cx from w_001
dw_1 dw_1
cbx_rinumera_cod_barre cbx_rinumera_cod_barre
dw_2 dw_2
cb_carica cb_carica
cb_salva cb_salva
end type
global w_rinumera_bol_da_ordine_cx w_rinumera_bol_da_ordine_cx

on w_rinumera_bol_da_ordine_cx.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cbx_rinumera_cod_barre=create cbx_rinumera_cod_barre
this.dw_2=create dw_2
this.cb_carica=create cb_carica
this.cb_salva=create cb_salva
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cbx_rinumera_cod_barre
this.Control[iCurrent+3]=this.dw_2
this.Control[iCurrent+4]=this.cb_carica
this.Control[iCurrent+5]=this.cb_salva
end on

on w_rinumera_bol_da_ordine_cx.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cbx_rinumera_cod_barre)
destroy(this.dw_2)
destroy(this.cb_carica)
destroy(this.cb_salva)
end on

event open;call super::open;date ldt_da_data

dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
dw_2.insertrow(1)

ldt_da_data=relativedate(ldt_da_data, -30)
dw_2.setitem(1, "da_data", ldt_da_data)
end event

type st_1 from w_001`st_1 within w_rinumera_bol_da_ordine_cx
end type

type dw_1 from udw_base within w_rinumera_bol_da_ordine_cx
integer x = 37
integer y = 364
integer width = 2999
integer height = 1072
boolean bringtotop = true
string dataobject = "d_doc"
end type

event itemfocuschanged;call super::itemfocuschanged;string ls_numero
if dwo.name="num_documento" then
	if row>0 and cbx_rinumera_cod_barre.checked then
		open(w_ins_barcode_pop)
		ls_numero=message.stringparm
		if ls_numero>"" then
			post setitem(row, "num_documento", ls_numero)
		end if	
	end if
end if
end event

event sqlpreview;call super::sqlpreview;string ls_sql, ls_data
integer i
long ll_id_prof, ll_id_sog
date ldt_da_data, ldt_a_data

if request = PreviewFunctionRetrieve! then
	ll_id_prof=dw_2.getitemnumber(1, "id_prof_doc")
	ldt_da_data=dw_2.getitemdate(1, "da_data")
	ldt_a_data=dw_2.getitemdate(1, "a_data")
	ll_id_sog =dw_2.getitemnumber(1, "id_soggetto")

ls_sql=" and  (documento.id_prof_documento= "+string(ll_id_prof) +") "
ls_sql+= " and  (documento.id_sog_commerciale= "+string(ll_id_sog)+") "
		ls_data=string(ldt_da_data, "yyyy-mm-dd")
		ldt_da_data=date(ls_data)	
		ls_data=string(ldt_a_data, "yyyy-mm-dd")
		ldt_a_data=date(ls_data)

ls_sql+= " and  (documento.data_documento>= '"+string(ldt_da_data, "yyyy-mm-dd")+"') "
ls_sql+= " and  (documento.data_documento<= '"+string(ldt_a_data, "yyyy-mm-dd")+"') "
ls_sql=sqlsyntax + ls_sql
i=SetSQLPreview(ls_sql)
if i<>1 then
	messagebox("Errore!", "Filtro data non applicato!")

end if

end if
end event

type cbx_rinumera_cod_barre from checkbox within w_rinumera_bol_da_ordine_cx
integer x = 41
integer y = 164
integer width = 937
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
string text = "Rinumerazione con Codice a Barre"
end type

type dw_2 from udw_base within w_rinumera_bol_da_ordine_cx
integer x = 1024
integer y = 16
integer width = 2025
integer height = 212
boolean bringtotop = true
string dataobject = "d_correggi_bol_selezione"
boolean vscrollbar = false
boolean livescroll = false
end type

type cb_carica from commandbutton within w_rinumera_bol_da_ordine_cx
integer x = 1024
integer y = 244
integer width = 256
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Carica"
end type

event clicked;dw_1.retrieve()
end event

type cb_salva from commandbutton within w_rinumera_bol_da_ordine_cx
integer x = 1344
integer y = 244
integer width = 256
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salva"
end type

event clicked;dw_1.trigger event ue_update()
end event

