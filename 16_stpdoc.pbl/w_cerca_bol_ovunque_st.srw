forward
global type w_cerca_bol_ovunque_st from w_001
end type
type cb_annulla from commandbutton within w_cerca_bol_ovunque_st
end type
type cb_stampa from commandbutton within w_cerca_bol_ovunque_st
end type
type dw_1 from u_dw_ext_main within w_cerca_bol_ovunque_st
end type
end forward

global type w_cerca_bol_ovunque_st from w_001
integer x = 997
integer y = 204
integer width = 1806
integer height = 720
boolean minbox = true
windowtype windowtype = popup!
cb_annulla cb_annulla
cb_stampa cb_stampa
dw_1 dw_1
end type
global w_cerca_bol_ovunque_st w_cerca_bol_ovunque_st

on w_cerca_bol_ovunque_st.create
int iCurrent
call super::create
this.cb_annulla=create cb_annulla
this.cb_stampa=create cb_stampa
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_annulla
this.Control[iCurrent+2]=this.cb_stampa
this.Control[iCurrent+3]=this.dw_1
end on

on w_cerca_bol_ovunque_st.destroy
call super::destroy
destroy(this.cb_annulla)
destroy(this.cb_stampa)
destroy(this.dw_1)
end on

event open;long ll_id_ese
date ldt_data_inizio

dw_1.settransobject(sqlca)
dw_1.insertrow(1)

trigger event ue_postopen()





end event

event ue_postopen;call super::ue_postopen;date ldt_da_data

ldt_da_data=relativedate(date(today()), - 60)
dw_1.setitem(1, "da_data",ldt_da_data )

dw_1.post setfocus()
dw_1.post setcolumn("num_bol")


end event

type st_1 from w_001`st_1 within w_cerca_bol_ovunque_st
end type

type cb_annulla from commandbutton within w_cerca_bol_ovunque_st
integer x = 50
integer y = 20
integer width = 247
integer height = 108
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Annulla"
end type

event clicked;close(parent)
end event

type cb_stampa from commandbutton within w_cerca_bol_ovunque_st
integer x = 1463
integer y = 20
integer width = 247
integer height = 108
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stampa"
boolean default = true
end type

event clicked;string ls_cod_esercizio, ls_rag_sociale
s_param_articoli s_par
dw_1.accepttext()

select rag_soc_1 into :ls_rag_sociale from dba.azienda;
if pos(upper(ls_rag_sociale), "ITALPANNA")>0 then
	//  provv_imp_carea_2
	s_par.da_sog_comm=dw_1.getitemstring(1, "num_bol")
	openwithparm(w_cerca_bol_ovunque_rpt, s_par)
else
	//id-articolo
	s_par.ll_magazzino=dw_1.getitemnumber(1, "id_articolo")
	
	
	//num_bollettina
	s_par.da_sog_comm=dw_1.getitemstring(1, "num_bol")
	
	
	s_par.a_data=dw_1.getitemdate(1, "a_data")
	s_par.da_data=dw_1.getitemdate(1, "da_data")
	//num_progressivo
	s_par.id_cat_codifica=dw_1.getitemnumber(1, "num_prog")
	s_par.par_stampa=dw_1.getitemstring(1, "ancora_qui")
	
	s_par.filtro="Stampa dati contabili per Esercizio: "+ls_cod_esercizio+" fino al: "+string(s_par.a_data)
	if s_par.da_sog_comm>"" then
		s_par.filtro+= " - Num. Bollettina: "+s_par.da_sog_comm
	end if


	openwithparm(w_cerca_bol_ovunque_rpt, s_par)
end if
end event

type dw_1 from u_dw_ext_main within w_cerca_bol_ovunque_st
integer x = 27
integer y = 196
integer width = 1728
integer height = 384
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_cerca_bol_ovunque_st"
end type

event itemchanged;call super::itemchanged;string ls_id_conto

choose case string(dwo.name)
	case "da_conto"
		ls_id_conto=getitemstring(row, "a_conto")
		if isnull(ls_id_conto) then
			setitem(row, "a_conto", data)
		end if
		
end choose
end event

