forward
global type w_lista_art_def_cx from w_testa_righe_cx
end type
type cb_seleziona from commandbutton within w_lista_art_def_cx
end type
type cb_applica from uo_cb within w_lista_art_def_cx
end type
type cb_abbandona from uo_cb within w_lista_art_def_cx
end type
type ln_1 from line within w_lista_art_def_cx
end type
type ln_2 from line within w_lista_art_def_cx
end type
end forward

global type w_lista_art_def_cx from w_testa_righe_cx
integer x = 59
integer y = 84
integer width = 2309
integer height = 1384
string title = "Definizione Liste di Articoli"
windowtype windowtype = response!
cb_seleziona cb_seleziona
cb_applica cb_applica
cb_abbandona cb_abbandona
ln_1 ln_1
ln_2 ln_2
end type
global w_lista_art_def_cx w_lista_art_def_cx

forward prototypes
public subroutine wf_ricerca (long al_riga_corrente, string as_data)
end prototypes

public subroutine wf_ricerca (long al_riga_corrente, string as_data);
s_ric_param ls_ric_param
w_search_main lw_sm
ls_ric_param.s_filter_value=as_data
ls_ric_param.s_filter_name="articolo_codice"
openwithparm(lw_sm,ls_ric_param,"w_articolo_coddes_sw")
ls_ric_param=message.powerobjectparm
if upperbound(ls_ric_param.s_id_seg_value)>0 then
	dw_2.setitem(al_riga_corrente, "lista_art_key_id_articolo",long(ls_ric_param.s_id_seg_value[1]))
	dw_2.setitem(al_riga_corrente,"articolo_codice", ls_ric_param.s_main_value)
	dw_2.setitem(al_riga_corrente, "articolo_descrizione",ls_ric_param.s_ausil_value[1])
end if
end subroutine

on w_lista_art_def_cx.create
int iCurrent
call super::create
this.cb_seleziona=create cb_seleziona
this.cb_applica=create cb_applica
this.cb_abbandona=create cb_abbandona
this.ln_1=create ln_1
this.ln_2=create ln_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_seleziona
this.Control[iCurrent+2]=this.cb_applica
this.Control[iCurrent+3]=this.cb_abbandona
this.Control[iCurrent+4]=this.ln_1
this.Control[iCurrent+5]=this.ln_2
end on

on w_lista_art_def_cx.destroy
call super::destroy
destroy(this.cb_seleziona)
destroy(this.cb_applica)
destroy(this.cb_abbandona)
destroy(this.ln_1)
destroy(this.ln_2)
end on

event open;call super::open;integer li_test

li_test=message.doubleparm

if li_test=1 then
	cb_abbandona.visible=true
	cb_applica.visible=true
else
	cb_abbandona.visible=false
	cb_applica.visible=false
end if
end event

type st_1 from w_testa_righe_cx`st_1 within w_lista_art_def_cx
end type

type dw_1 from w_testa_righe_cx`dw_1 within w_lista_art_def_cx
integer x = 352
integer y = 24
integer width = 1929
integer height = 512
string dataobject = "d_lista_art_def_gd"
end type

event dw_1::rowfocuschanging;
end event

type dw_2 from w_testa_righe_cx`dw_2 within w_lista_art_def_cx
integer x = 347
integer y = 552
integer width = 1934
integer height = 724
string dataobject = "d_lista_art_key_gd"
end type

event dw_2::itemchanged;st_ass_art_sottoclasse st_associa
IF DWO.NAME='articolo_codice' then
	select id_articolo, codice, descrizione
	into :st_associa.id_articolo, :st_associa.cod_articolo, :st_associa.des_articolo
	from articolo
	where codice=:data;
	if sqlca.sqlcode=0 then
		setitem(row, "lista_art_key_id_articolo", st_associa.id_articolo)
		setitem(row, "articolo_codice", st_associa.cod_articolo)
		setitem(row, "articolo_descrizione", st_associa.des_articolo)
	else
		wf_ricerca(row, data)
	end if
end if
		
end event

event dw_2::clicked;string ls_data
if dwo.name="articolo_codice_sw" then
	ls_data=getitemstring(row, "articolo_codice")
	wf_ricerca(row, ls_data)
end if
end event

event dw_2::updatestart;integer li_righe
if dw_2.rowcount()>0 then
	li_righe=dw_2.getitemnumber(dw_2.rowcount(), "esiste_doppio")
	if li_righe>0 then 
		dw_2.setfilter("art_doppi=1")
		dw_2.filter()
		for li_righe=dw_2.rowcount() to 1 step -1
			dw_2.deleterow(li_righe)
		next
		dw_2.setfilter("")
		dw_2.filter()
	end if
end if
end event

type cb_inserisci from w_testa_righe_cx`cb_inserisci within w_lista_art_def_cx
integer x = 23
integer y = 404
integer width = 293
integer height = 108
integer taborder = 50
end type

type cb_salva from w_testa_righe_cx`cb_salva within w_lista_art_def_cx
integer x = 23
integer y = 524
integer width = 302
integer height = 108
integer taborder = 70
end type

type cb_cancella from w_testa_righe_cx`cb_cancella within w_lista_art_def_cx
integer x = 23
integer y = 644
integer width = 302
integer height = 108
integer taborder = 100
end type

type cb_annulla from w_testa_righe_cx`cb_annulla within w_lista_art_def_cx
integer x = 23
integer y = 1164
integer width = 302
integer height = 108
integer taborder = 80
end type

type cb_ok from w_testa_righe_cx`cb_ok within w_lista_art_def_cx
integer x = 23
integer y = 1040
integer width = 302
integer height = 108
integer taborder = 90
string text = "OK"
end type

type cb_seleziona from commandbutton within w_lista_art_def_cx
integer x = 23
integer y = 920
integer width = 302
integer height = 108
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Seleziona"
end type

event clicked;s_dw_ritorna st_p
integer li_righe
long ll_id_lista

li_righe=dw_1.getrow()
ll_id_lista=dw_1.getitemnumber(li_righe, "id_lista_articoli")
IF ll_id_lista>0 THEN

	openwithparm(w_auto_aggiunta_cx, ll_id_lista)
	
	
	st_p=message.powerobjectparm
	
	if isvalid(st_p) then
		li_righe=dw_2.rowcount()+1
		if li_righe<=0 then li_righe=1
		st_p.ds.rowscopy(1, st_p.ds.rowcount(), primary!, dw_2, li_righe, primary!)
	end if
	dw_2.sort()
	if dw_2.rowcount()>0 then
		if messagebox("Attenzione!", "Salvare la lista corrente?", stopsign!,yesno!)=1 then
			wf_salva_dw(dw_1,dw_2,2)
		end if
	end if
else
	messagebox("Attenzione!", "Salvare la lista corrente prima di effettuare la selezione!")
end if
	
end event

type cb_applica from uo_cb within w_lista_art_def_cx
string tag = "Conferma ed applica la lista"
integer x = 23
integer y = 24
integer width = 302
integer taborder = 40
boolean bringtotop = true
string text = "Applica"
end type

event clicked;s_key_articoli st_chiavi
long ll_riga_corrente

ll_riga_corrente=dw_1.getrow()
st_chiavi.sn_applica_lista=true
st_chiavi.id_lista_articoli=dw_1.getitemnumber(ll_riga_corrente, "id_lista_articoli")

closewithreturn(parent, st_chiavi)
end event

type cb_abbandona from uo_cb within w_lista_art_def_cx
string tag = "Abbonda senza applicare Lista"
integer x = 23
integer y = 172
integer width = 302
integer taborder = 30
boolean bringtotop = true
string text = "Abbandona"
end type

event clicked;s_key_articoli st_chiavi
long ll_null

setnull(ll_null)
st_chiavi.sn_applica_lista=true
st_chiavi.id_lista_articoli=ll_null

closewithreturn(parent, st_chiavi)
end event

type ln_1 from line within w_lista_art_def_cx
long linecolor = 33554432
integer linethickness = 4
integer beginx = 27
integer beginy = 312
integer endx = 334
integer endy = 312
end type

type ln_2 from line within w_lista_art_def_cx
long linecolor = 33554432
integer linethickness = 4
integer beginx = 27
integer beginy = 836
integer endx = 334
integer endy = 836
end type

