forward
global type w_registro_in_esercizio_gd from w_np_single_data
end type
type cb_allinea_progressivi from commandbutton within w_registro_in_esercizio_gd
end type
end forward

global type w_registro_in_esercizio_gd from w_np_single_data
integer width = 2853
integer height = 973
boolean maxbox = false
boolean resizable = false
cb_allinea_progressivi cb_allinea_progressivi
end type
global w_registro_in_esercizio_gd w_registro_in_esercizio_gd

on w_registro_in_esercizio_gd.create
int iCurrent
call super::create
this.cb_allinea_progressivi=create cb_allinea_progressivi
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_allinea_progressivi
end on

on w_registro_in_esercizio_gd.destroy
call super::destroy
destroy(this.cb_allinea_progressivi)
end on

event open;call super::open;this.y=200
end event

type p_msg_log from w_np_single_data`p_msg_log within w_registro_in_esercizio_gd
end type

type p_crescente from w_np_single_data`p_crescente within w_registro_in_esercizio_gd
end type

type p_decrescente from w_np_single_data`p_decrescente within w_registro_in_esercizio_gd
end type

type dw_single from w_np_single_data`dw_single within w_registro_in_esercizio_gd
integer width = 2728
string dataobject = "d_registro_gd"
end type

event dw_single::clicked;call super::clicked;//long ll_righe, ll_num_progressivo, ll_id_registro, ll_num_progressivo_reg
//integer i
//string ls_tipo_registro
//if string(dwo.name)="cb_allinea" then
//	ll_righe=dw_single.rowcount()
//	for i= 1 to ll_righe
//		ll_id_registro=dw_single.getitemnumber(i, "registro_id_registro")
//		select max(num_progressivo)
//		into :ll_num_progressivo
//		from documento
//		where id_registro=:ll_id_registro;
//		if isnull(ll_num_progressivo) then ll_num_progressivo=0
//		ls_tipo_registro=dw_single.getitemstring(i, "registro_tipo_registro")
//		if left(ls_tipo_registro, 1)='I' then
//			select max(num_progressivo)
//			into :ll_num_progressivo_reg
//			from reg_pd
//			where id_registro=:ll_id_registro;
//			if isnull(ll_num_progressivo_reg) then ll_num_progressivo_reg=0
//			ll_num_progressivo=max(ll_num_progressivo_reg, ll_num_progressivo)
//		end if
//		dw_single.setitem(i, "num_progressivo", ll_num_progressivo+1)
//	next
//end if
end event

type cb_allinea_progressivi from commandbutton within w_registro_in_esercizio_gd
integer x = 62
integer y = 746
integer width = 453
integer height = 90
integer taborder = 11
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Allinea Prograssivi"
end type

event clicked;long ll_righe, ll_num_progressivo, ll_id_registro, ll_num_progressivo_reg
integer i
string ls_tipo_registro

	ll_righe=dw_single.rowcount()
	for i= 1 to ll_righe
		ll_id_registro=dw_single.getitemnumber(i, "registro_id_registro")
		select max(num_progressivo)
		into :ll_num_progressivo
		from documento
		where id_registro=:ll_id_registro;
		if isnull(ll_num_progressivo) then ll_num_progressivo=0
		ls_tipo_registro=dw_single.getitemstring(i, "registro_tipo_registro")
		if left(ls_tipo_registro, 1)='I' then
			select max(num_progressivo)
			into :ll_num_progressivo_reg
			from reg_pd
			where id_registro=:ll_id_registro;
			if isnull(ll_num_progressivo_reg) then ll_num_progressivo_reg=0
			ll_num_progressivo=max(ll_num_progressivo_reg, ll_num_progressivo)
		end if
		dw_single.setitem(i, "num_progressivo", ll_num_progressivo+1)
	next
dw_single.triggerevent("ue_update")
end event

