forward
global type w_acc_statistica_rbol_st from w_base
end type
type dw_3 from u_dw_ext_main within w_acc_statistica_rbol_st
end type
type cb_4 from commandbutton within w_acc_statistica_rbol_st
end type
type cb_3 from commandbutton within w_acc_statistica_rbol_st
end type
type cb_2 from commandbutton within w_acc_statistica_rbol_st
end type
type dw_2 from udw_001 within w_acc_statistica_rbol_st
end type
type cb_1 from commandbutton within w_acc_statistica_rbol_st
end type
type dw_1 from udw_001 within w_acc_statistica_rbol_st
end type
end forward

global type w_acc_statistica_rbol_st from w_base
integer x = 3269
integer y = 1500
integer width = 1778
integer height = 1248
dw_3 dw_3
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
dw_2 dw_2
cb_1 cb_1
dw_1 dw_1
end type
global w_acc_statistica_rbol_st w_acc_statistica_rbol_st

event open;call super::open;
dw_1.insertrow(1)
dw_2.settransobject(sqlca)
dw_2.retrieve()
date ldt_data_inizio, ldt_data_fine
ldt_data_inizio=date("01/01/"+string(year(today())))
ldt_data_fine=date(today())
//ldt_data_iniziodate("01-01"+string(year(today())))
dw_1.setitem(1, "da_data", ldt_data_inizio)
dw_1.setitem(1, "a_data", ldt_data_fine)

end event

on w_acc_statistica_rbol_st.create
int iCurrent
call super::create
this.dw_3=create dw_3
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.dw_2=create dw_2
this.cb_1=create cb_1
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_3
this.Control[iCurrent+2]=this.cb_4
this.Control[iCurrent+3]=this.cb_3
this.Control[iCurrent+4]=this.cb_2
this.Control[iCurrent+5]=this.dw_2
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.dw_1
end on

on w_acc_statistica_rbol_st.destroy
call super::destroy
destroy(this.dw_3)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.dw_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event ue_postopen;call super::ue_postopen;this.x=3200
this.y=1500


end event

type dw_3 from u_dw_ext_main within w_acc_statistica_rbol_st
event type integer ue_tipo_reg ( )
integer x = 41
integer y = 308
integer width = 745
integer height = 584
integer taborder = 40
string dataobject = "d_scegli_prof_doc"
end type

event itemfocuschanged;call super::itemfocuschanged;



end event

event ue_key;call super::ue_key;long ll_riga
choose case key
case Keyadd!	
	if (keyFlags=2) then
		triggerevent("ue_insert")
	end if
case KeySubtract!
if (keyFlags=2) then
		ll_riga=getrow()
		if ll_riga>0 then
			deleterow(ll_riga)
		end if
	end if
end choose

end event

event ue_set_search;string ls_sql_cond 
CHOOSE CASE as_nomecol
		
	CASE "da_cod_articolo"
		is_search_window = "w_articolo_coddes_per_silver_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "articolo_codice"
		is_ricpar.b_imm_retrieve = TRUE

END CHOOSE	
end event

event ue_use_search;CHOOSE CASE as_nomecol

	CASE "da_cod_articolo"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		
	
		



END CHOOSE

end event

type cb_4 from commandbutton within w_acc_statistica_rbol_st
integer x = 795
integer y = 668
integer width = 274
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Salva"
end type

event clicked;dw_2.trigger event ue_update()

end event

type cb_3 from commandbutton within w_acc_statistica_rbol_st
integer x = 795
integer y = 520
integer width = 274
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Cancella"
end type

event clicked;long ll_riga_da_cancellare
ll_riga_da_cancellare=dw_2.getrow()
dw_2.trigger event ue_delete(ll_riga_da_cancellare)		

end event

event rbuttondown;integer i ,li_righe
li_righe=dw_2.rowcount()
for i=li_righe to 1 step -1
	dw_2.trigger event ue_delete(i)		
next

end event

type cb_2 from commandbutton within w_acc_statistica_rbol_st
integer x = 795
integer y = 372
integer width = 274
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Inserisci"
end type

event clicked;long ll_riga
ll_riga=dw_2.trigger event ue_insert(0)
end event

type dw_2 from udw_001 within w_acc_statistica_rbol_st
integer x = 1079
integer y = 44
integer width = 617
integer height = 1016
integer taborder = 20
string dataobject = "d_acc_per_statistica"
end type

type cb_1 from commandbutton within w_acc_statistica_rbol_st
integer x = 23
integer y = 960
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
string text = "STAMPA"
end type

event clicked;s_array s_dati_selezione
integer i

dw_1.accepttext()
dw_2.accepttext()
 s_dati_selezione.as_string[1]=string(dw_1.getitemdate(1, "da_data"))
 s_dati_selezione.as_string[2]=string(dw_1.getitemdate(1, "a_data"))
 for i = 1 to dw_2.rowcount()
	s_dati_selezione.as_string[i+2]=dw_2.getitemstring(i, "accessorio")
next
for i = 1 to dw_3.rowcount()	
	 s_dati_selezione.ll_id_prof[i]=dw_3.getitemnumber(i, "id_prof_documento")
next

OPENWITHPARm(w_acc_statistica_rbol, s_dati_selezione)
end event

type dw_1 from udw_001 within w_acc_statistica_rbol_st
integer x = 41
integer y = 44
integer width = 745
integer height = 220
integer taborder = 10
string dataobject = "d_da_data_a_data"
end type

