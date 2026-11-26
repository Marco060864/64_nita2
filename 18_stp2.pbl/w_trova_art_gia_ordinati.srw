forward
global type w_trova_art_gia_ordinati from w_pop
end type
type cb_chiudi from commandbutton within w_trova_art_gia_ordinati
end type
type cb_riporta from commandbutton within w_trova_art_gia_ordinati
end type
end forward

global type w_trova_art_gia_ordinati from w_pop
integer width = 1115
integer height = 2532
boolean resizable = false
windowtype windowtype = response!
string icon = "AppRectangle!"
cb_chiudi cb_chiudi
cb_riporta cb_riporta
end type
global w_trova_art_gia_ordinati w_trova_art_gia_ordinati

type variables
s_array il_id
end variables

on w_trova_art_gia_ordinati.create
int iCurrent
call super::create
this.cb_chiudi=create cb_chiudi
this.cb_riporta=create cb_riporta
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_chiudi
this.Control[iCurrent+2]=this.cb_riporta
end on

on w_trova_art_gia_ordinati.destroy
call super::destroy
destroy(this.cb_chiudi)
destroy(this.cb_riporta)
end on

event open;call super::open;string LS_FILTRO, ls_etichetta, ls_rag_soc


il_id=message.powerobjectparm



select rag_soc_1
into :ls_rag_soc
from sog_commerciale_gen 
where id_sog_commerciale=:il_id.ll_id_doc[2]
;
select codice
into :ls_etichetta
from dba.prof_documento
where id_prof_documento=:il_id.ll_id_doc[1]
;

ls_etichetta="Prof. Doc.: "+ls_etichetta+" - Sog.: "+left(ls_rag_soc, 12)
dw_1.modify("t_1.text='"+ls_etichetta+"'")

LS_FILTRO=string(il_id.ll_id_doc[2])
dw_1.is_sql="  AND documento.id_sog_commerciale = "+LS_FILTRO
dw_1.retrieve(il_id.ll_id_doc[1])

end event

type dw_1 from w_pop`dw_1 within w_trova_art_gia_ordinati
integer x = 37
integer y = 48
integer width = 1015
integer height = 2168
string dataobject = "d_trova_art_ordinati_da_cliente"
boolean vscrollbar = true
end type

event dw_1::sqlpreview;string ls_sql
long ll_pos

if this.is_sql>" " and sqltype=PreviewSelect! then

	ls_sql=sqlsyntax
	
//	ll_pos=pos(ls_sql, "WHERE")
//	if ll_pos>0 then
//		ls_sql=left(ls_sql, ll_pos - 1)
//	end if
	ls_sql+=this.is_sql
	//messagebox("S", ls_sql)
	setsqlpreview(ls_sql)

end if
end event

type cb_chiudi from commandbutton within w_trova_art_gia_ordinati
integer x = 640
integer y = 2256
integer width = 402
integer height = 112
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Chiudi"
end type

type cb_riporta from commandbutton within w_trova_art_gia_ordinati
integer x = 174
integer y = 2256
integer width = 402
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Riporta"
end type

event clicked;integer i
s_array s_id
string ls_filtro

ls_filtro="scegli=1"
dw_1.setfilter(ls_filtro)
dw_1.filter()
for i= 1 to dw_1.rowcount()
	
	s_id.as_string[i]=dw_1.getitemstring(i, "articolo_codice")
	
next
closewithreturn(parent, s_id)
end event

