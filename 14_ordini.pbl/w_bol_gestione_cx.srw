forward
global type w_bol_gestione_cx from w_testa_righe_cx
end type
type dw_3 from udw_base within w_bol_gestione_cx
end type
end forward

global type w_bol_gestione_cx from w_testa_righe_cx
integer width = 4864
integer height = 2612
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = main!
dw_3 dw_3
end type
global w_bol_gestione_cx w_bol_gestione_cx

type variables
long il_id_doc, il_id_articolo

end variables

on w_bol_gestione_cx.create
int iCurrent
call super::create
this.dw_3=create dw_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_3
end on

on w_bol_gestione_cx.destroy
call super::destroy
destroy(this.dw_3)
end on

event open;call super::open;dw_3.settransobject(sqlca)
dw_3.insertrow(1)
end event

type st_1 from w_testa_righe_cx`st_1 within w_bol_gestione_cx
end type

type dw_1 from w_testa_righe_cx`dw_1 within w_bol_gestione_cx
integer width = 3808
integer height = 1276
string dataobject = "D_BOL_GESTIONE_GD"
end type

event dw_1::clicked;call super::clicked;//long ll_id
//integer li_test  
//
//if row>0 then
//	
//	ll_id=getitemnumber(row, 1)
//	
//	if ll_id>0 then
//		
//		if dw_2.trigger event ue_update()=1 then
//			dw_2.retrieve(ll_id)
//		else
//			messagebox("Attenzione!", "Salvataggio non riuscito!")
//		end if
//		
//	else
//		dw_2.reset()
//	end if
//end if
//setrowfocusindicator(hand!)
end event

event dw_1::ue_update;return 1
//
end event

event dw_1::rowfocuschanged;//
long ll_id

if currentrow>0 then
	
	il_id_doc=getitemnumber(currentrow, 1)
	
	dw_2.retrieve()
end if
setrowfocusindicator(hand!)
end event

type dw_2 from w_testa_righe_cx`dw_2 within w_bol_gestione_cx
integer y = 1316
integer width = 4151
integer height = 912
string dataobject = "d_riga_bol_gestione_gd"
end type

event dw_2::sqlpreview;call super::sqlpreview;string ls_sql
integer i

ls_sql=sqlsyntax
	
if il_id_doc>0 then
	ls_sql=ls_sql + " and (riga_documento.id_documento= "+string(il_id_doc)+")"
	i=SetSQLPreview(ls_sql)
	if i<>1 then
		messagebox("Errore!", "Filtro non applicato!")
	end if
end if
	
if il_id_articolo>0 then
ls_sql=ls_sql + " and (riga_documento.id_articolo= "+string(il_id_articolo)+")"
i=SetSQLPreview(ls_sql)
if i<>1 then
	messagebox("Errore!", "Filtro non applicato!")
end if
end if
	


end event

event dw_2::updateend;call super::updateend;INTEGER I
string ls_ord_fornitore
long ll_id_riga_ordine

IF ROWSUPDATED>0 THEN
	FOR I= 1 to dw_2.rowcount()
		ll_id_riga_ordine=dw_2.getitemnumber(i, "provv_imp_subage_2")
		if ll_id_riga_ordine>0 then
			ls_ord_fornitore=dw_2.getitemstring(i, "riga_documento_ordinato_fo")
			update riga_documento
			set ordinato_fo=:ls_ord_fornitore
			where id_riga_documento=:ll_id_riga_ordine
			;
			if sqlca.sqlNrows>0 then 
				commit;
			else
				rollback;
				messagebox("Attenzione!", "Riga ordine non aggiornata!")
				exit
			end if
			exit
		end if
		
	next
	
END IF
end event

type cb_inserisci from w_testa_righe_cx`cb_inserisci within w_bol_gestione_cx
integer x = 32
integer y = 2284
end type

type cb_salva from w_testa_righe_cx`cb_salva within w_bol_gestione_cx
integer x = 320
integer y = 2284
end type

event cb_salva::clicked;
	wf_salva_dw(dw_1, dw_2, 2)

end event

type cb_cancella from w_testa_righe_cx`cb_cancella within w_bol_gestione_cx
integer x = 608
integer y = 2284
end type

type cb_annulla from w_testa_righe_cx`cb_annulla within w_bol_gestione_cx
integer x = 1093
integer y = 2284
end type

type cb_ok from w_testa_righe_cx`cb_ok within w_bol_gestione_cx
integer x = 1385
integer y = 2284
end type

type dw_3 from udw_base within w_bol_gestione_cx
integer x = 3895
integer y = 36
integer width = 878
integer height = 192
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_art_ext"
end type

event itemchanged;call super::itemchanged;long ll_appoggio

il_id_articolo=long(data)

ll_appoggio=il_id_doc
il_id_doc=0
if il_id_articolo>0 then
	dw_2.retrieve()
end if
il_id_doc=ll_appoggio
end event

