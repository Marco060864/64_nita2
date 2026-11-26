forward
global type w_pacco_bollettina from w_testa_righe_cx
end type
type dw_3 from udw_base within w_pacco_bollettina
end type
type cb_stampa from commandbutton within w_pacco_bollettina
end type
type cb_apri from commandbutton within w_pacco_bollettina
end type
end forward

global type w_pacco_bollettina from w_testa_righe_cx
integer width = 2747
integer height = 2016
boolean minbox = true
windowtype windowtype = popup!
dw_3 dw_3
cb_stampa cb_stampa
cb_apri cb_apri
end type
global w_pacco_bollettina w_pacco_bollettina

on w_pacco_bollettina.create
int iCurrent
call super::create
this.dw_3=create dw_3
this.cb_stampa=create cb_stampa
this.cb_apri=create cb_apri
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_3
this.Control[iCurrent+2]=this.cb_stampa
this.Control[iCurrent+3]=this.cb_apri
end on

on w_pacco_bollettina.destroy
call super::destroy
destroy(this.dw_3)
destroy(this.cb_stampa)
destroy(this.cb_apri)
end on

event open;//datawindowchild dwc_profili
long ll_id

dw_3.settransobject(sqlca)
dw_3.insertrow(1)
integer rtncode

//rtncode = dw_3.GetChild('id_prof_documento', dwc_profili)
//
//IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild")
//
//// Establish the connection
//
//CONNECT USING SQLCA;
//
//// Set the transaction object for the child
//
//dwc_profili.SetTransObject(SQLCA)
//
//// Populate with values for eastern states
////se è aperto da "fare pronto cassaforte" allora il filtro è il num_registro=6 altrimenti num_reg=2
//
//dwc_profili.setfilter("prof_documento_tipo_registro='GV'" )
//rtncode=dwc_profili.filter()
//
//dwc_profili.Retrieve()
//dw_3.setitem(1, "id_prof_documento", 65)
dw_3.setitem(1, "anno", string(year(today())))


dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)

dw_1.insertrow(0)
post setfocus(dw_1)
dw_1.post setcolumn("codice")

//if dw_1.retrieve()>0 then
//	ll_id=dw_1.getitemnumber(1,1)
//	dw_2.retrieve(ll_id)
//end if
//	
end event

type st_1 from w_testa_righe_cx`st_1 within w_pacco_bollettina
end type

type dw_1 from w_testa_righe_cx`dw_1 within w_pacco_bollettina
integer x = 26
integer width = 2022
integer height = 413
string dataobject = "d_pacco"
end type

event dw_1::rowfocuschanged;long ll_id
integer li_test  

if currentrow>0 then
	
	ll_id=getitemnumber(currentrow, 1)
	
	if ll_id>0 then
		
		if dw_2.trigger event ue_update()=1 then
			
			dw_2.retrieve(ll_id)
		else
			messagebox("Attenzione!", "Salvataggio non riuscito!")
		end if
		
	else
		dw_2.reset()
	end if
end if
setrowfocusindicator(hand!)
end event

event dw_1::editchanged;call super::editchanged;if  dwo.name="codice" then
	if len(data)= 13 then
		setfocus(dw_2)
		cb_inserisci.trigger event clicked()
	end if
	
end if
end event

event dw_1::itemchanged;call super::itemchanged;modify(dwo.name+".color='0~tIf(isrowmodified(),12615680,0)'")
end event

type dw_2 from w_testa_righe_cx`dw_2 within w_pacco_bollettina
integer x = 0
integer y = 461
integer width = 2692
integer height = 1254
string dataobject = "d_pacco_bollettina"
end type

event dw_2::itemchanged;call super::itemchanged;long ll_id_bollettina,ll_id_test, ll_riga_inserita, ll_riga_trovata
long ll_id_prof,ll_riga2_inserita, ll_num_prog, ll_id_pacco
string ls_num_doc, ls_test,ls_anno
integer li_13, li_risultati
datastore ds_trova_bol_pacco

ds_trova_bol_pacco=create datastore
ds_trova_bol_pacco.dataobject="d_trova_bollettina_pacco"
ds_trova_bol_pacco.settransobject(sqlca)

if dwo.name="c_cod_barre"  then
	
	//prendo il profilo entro il quale devo ricercare dalla dw in alto (dw_2)
	//no! samy vuole che io lo trovi qualunque bollettina sia
	//quindi tipo_registro='GV'
	
	dw_3.accepttext()
	//ll_id_prof=dw_3.getitemnumber(1, "id_prof_documento")
	if len(data)=7 and li_13<>13 then
		ls_anno=dw_3.getitemstring(1,"anno")
		//left(string(today(), "yyyy/mm/dd"), 4)
		ls_num_doc=mid(data, 3, 5)
		ll_riga_trovata=ds_trova_bol_pacco.retrieve(ls_num_doc)
		if ll_riga_trovata>0 then
			if ll_riga_trovata>1 then
				
			else
				ll_id_bollettina=ds_trova_bol_pacco.getitemnumber(1, "id_riga_documento")
				setitem(row, "id_bollettina", ll_id_bollettina)
				dw_2.trigger event ue_update()
				ll_id_pacco=dw_1.getitemnumber(dw_1.getrow(), "id_pacco")
				retrieve(ll_id_pacco)
				cb_inserisci.trigger event clicked()
				post setfocus(this)
				post scrolltorow(rowcount())
				post setcolumn("c_cod_barre")
			end if
		end if
	
	
		
//		select count(*)
//		into :li_risultati
//		from dba.documento d, registro r, esercizio e//d, dba.prof_documento p
//		where right(num_documento, 5)=:ls_num_doc
//		//where d.num_progressivo=:ll_num_prog
//		//and (p.codice='BOL' or p.codice='SBOL' or p.codice='VBOL')
//		//tolto il 130115
//		//and d.id_prof_documento=:ll_id_prof
//		and d.id_registro=r.id_registro
//		and r.id_esercizio=e.id_esercizio
//		and e.codice=:ls_anno
//		//aggiuinto 130115
//		and r.tipo_registro='GV'
//		;
//		if li_risultati>1 then
//			messagebox("Attenzione!", "Trovate più di una bollettina!")
//			return
//		else
//			select rd.id_riga_documento
//			into :ll_id_bollettina
//			from dba.documento d, registro r, esercizio e, dba.riga_documento rd//d, dba.prof_documento p
//			where right(num_documento, 5)=:ls_num_doc
//			//where d.num_progressivo=:ll_num_prog
//			//and (p.codice='BOL' or p.codice='SBOL' or p.codice='VBOL')
//			//and d.id_prof_documento=:ll_id_prof
//			and d.id_registro=r.id_registro
//			and r.id_esercizio=e.id_esercizio
//			and e.codice=:ls_anno
//			and r.tipo_registro='GV'
//			and d.id_documento=rd.id_documento
//			;
////			select id_documento
////			into :ll_id_bollettina
////			from dba.documento d, registro r, esercizio e//d, dba.prof_documento p
////			where right(num_documento, 5)=:ls_num_doc
////			//where d.num_progressivo=:ll_num_prog
////			//and (p.codice='BOL' or p.codice='SBOL' or p.codice='VBOL')
////			//and d.id_prof_documento=:ll_id_prof
////			and d.id_registro=r.id_registro
////			and r.id_esercizio=e.id_esercizio
////			and e.codice=:ls_anno
////			and r.tipo_registro='GV'
////			;
//		end if
//		
//	
//		if ll_id_bollettina>0 then
//			setitem(row, "id_bollettina", ll_id_bollettina)
//			dw_2.trigger event ue_update()
//			ll_id_pacco=dw_1.getitemnumber(dw_1.getrow(), "id_pacco")
//			retrieve(ll_id_pacco)
//			cb_inserisci.trigger event clicked()
//			post setfocus(this)
//			post scrolltorow(rowcount())
//			post setcolumn("c_cod_barre")
//		else
//			messagebox("Attenzione!", "Bollettina: "+ls_num_doc+" non trovata!")
//		end if
//		
	end if
end if
destroy ds_trova_bol_pacco
end event

type cb_inserisci from w_testa_righe_cx`cb_inserisci within w_pacco_bollettina
integer x = 26
integer y = 1757
integer width = 230
integer height = 74
end type

event cb_inserisci::clicked;call super::clicked;post setfocus(dw_2)
dw_2.post setcolumn("c_cod_barre")

end event

type cb_salva from w_testa_righe_cx`cb_salva within w_pacco_bollettina
integer x = 293
integer y = 1757
integer width = 176
integer height = 74
end type

type cb_cancella from w_testa_righe_cx`cb_cancella within w_pacco_bollettina
integer x = 497
integer y = 1757
integer width = 230
integer height = 74
end type

type cb_annulla from w_testa_righe_cx`cb_annulla within w_pacco_bollettina
integer x = 1317
integer y = 1757
integer width = 230
integer height = 74
end type

type cb_ok from w_testa_righe_cx`cb_ok within w_pacco_bollettina
integer x = 1584
integer y = 1757
integer width = 201
integer height = 74
boolean default = false
end type

type dw_3 from udw_base within w_pacco_bollettina
integer x = 1050
integer y = 1728
integer width = 263
integer height = 179
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_scegli_profilo"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

type cb_stampa from commandbutton within w_pacco_bollettina
integer x = 1818
integer y = 1757
integer width = 205
integer height = 74
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stampa"
end type

event clicked;s_pacco s_pac
integer i

for i= 1 to dw_1.rowcount()
	s_pac.s_id_pacco[i]=dw_1.getitemnumber(i, "id_pacco")
next
openwithparm(w_st_pacco, s_pac)
end event

type cb_apri from commandbutton within w_pacco_bollettina
integer x = 761
integer y = 1757
integer width = 234
integer height = 74
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Duplica"
end type

event clicked;w_pacco_bollettina lw_pac_bol

open(lw_pac_bol)
end event

