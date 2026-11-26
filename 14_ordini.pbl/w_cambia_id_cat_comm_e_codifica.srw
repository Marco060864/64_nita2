forward
global type w_cambia_id_cat_comm_e_codifica from w_pop
end type
type cb_1 from commandbutton within w_cambia_id_cat_comm_e_codifica
end type
type dw_2 from udw_001 within w_cambia_id_cat_comm_e_codifica
end type
end forward

global type w_cambia_id_cat_comm_e_codifica from w_pop
integer width = 4357
integer height = 2300
cb_1 cb_1
dw_2 dw_2
end type
global w_cambia_id_cat_comm_e_codifica w_cambia_id_cat_comm_e_codifica

on w_cambia_id_cat_comm_e_codifica.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.dw_2
end on

on w_cambia_id_cat_comm_e_codifica.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.dw_2)
end on

type dw_1 from w_pop`dw_1 within w_cambia_id_cat_comm_e_codifica
integer x = 9
integer y = 28
integer width = 2098
integer height = 1968
string dataobject = "d_id_art_cod_sl"
end type

event dw_1::clicked;call super::clicked;long ll_righe, ll_row
integer i
ll_row=row
if NOT(KeyDown(KeyShift!))And NOT(KeyDown(KeyControl!)) then
	ll_righe=RowCount()
	
	
	for i = 1 to ll_righe
		if i=ll_row then continue
		if IsSelected(i) then SelectRow(i,false)
	next
	
	SelectRow(ll_row, not (isselected(ll_row)))

elseif KeyDown(KeyShift!) then
		
		SelectRow(ll_row,true)
		ll_righe=RowCount()
		ll_row=ll_righe
		
		for i= 1 to ll_row
			if IsSelected(i) then ll_row=i
		next
		
		for i=ll_row+1 to ll_righe
			if IsSelected(i) then ll_righe=i
		next
		
		
	elseif KeyDown(KeyControl!) then
		ll_row=row
		SelectRow(ll_row,Not IsSelected(ll_row))
		ll_righe=RowCount()
		
end if
end event

type cb_1 from commandbutton within w_cambia_id_cat_comm_e_codifica
integer x = 1966
integer y = 2048
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
string text = "none"
end type

event clicked;//long ll_Rows, ll_i, ll_CurrRow
//decimal ldc_tot_scadenza_importo
//long contatore
//
//ll_Rows = idw_source.RowCount()
//
//ib_removing = TRUE
//idw_source.SetRow(1)
//
//FOR ll_i = ll_Rows TO 1 STEP -1
//	IF idw_source.IsSelected(ll_i) THEN
//		contatore=contatore+1
//
//		idw_source.rowsmove(ll_i,ll_i,primary!,idw_target,1,primary!)
//		idw_target.selectrow(contatore,true)
//		
//	END IF
//NEXT
//
//idw_target.Sort()
//
//ib_removing = FALSE
//
//dw_selezionati_lt.setfocus()
end event

type dw_2 from udw_001 within w_cambia_id_cat_comm_e_codifica
integer x = 2135
integer y = 28
integer width = 2098
integer height = 1968
integer taborder = 20
boolean bringtotop = true
end type

