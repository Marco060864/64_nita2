forward
global type w_trova_reg_fuori_esercizio from w_np_single_data
end type
type cb_correggi from commandbutton within w_trova_reg_fuori_esercizio
end type
end forward

global type w_trova_reg_fuori_esercizio from w_np_single_data
integer width = 2423
integer height = 1980
cb_correggi cb_correggi
end type
global w_trova_reg_fuori_esercizio w_trova_reg_fuori_esercizio

on w_trova_reg_fuori_esercizio.create
int iCurrent
call super::create
this.cb_correggi=create cb_correggi
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_correggi
end on

on w_trova_reg_fuori_esercizio.destroy
call super::destroy
destroy(this.cb_correggi)
end on

event open;call super::open;

//"d_trova_prezzo_des_2_art"
end event

type p_msg_log from w_np_single_data`p_msg_log within w_trova_reg_fuori_esercizio
end type

type p_crescente from w_np_single_data`p_crescente within w_trova_reg_fuori_esercizio
end type

type p_decrescente from w_np_single_data`p_decrescente within w_trova_reg_fuori_esercizio
end type

type dw_single from w_np_single_data`dw_single within w_trova_reg_fuori_esercizio
integer x = 27
integer y = 128
integer width = 2281
integer height = 1692
string dataobject = "d_trova_reg_fuori_esercizio"
end type

type cb_correggi from commandbutton within w_trova_reg_fuori_esercizio
integer x = 1490
integer y = 20
integer width = 832
integer height = 92
integer taborder = 11
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Data Reg. corretta: correggi esercizio"
end type

event clicked;long ll_righe, i, ll_id_registro
string ls_tipo_reg
integer li_numero_reg
date ldt_data_reg


ll_righe=dw_single.rowcount()

for i= 1 to ll_righe
	ls_tipo_reg=dw_single.getitemstring(i, "registro_tipo_registro")
	if ls_tipo_reg='PN' then
		li_numero_reg=dw_single.getitemnumber(i, "registro_numero")
		ldt_data_reg=dw_single.getitemdate(i, "reg_pd_data_registrazione")
		select r.id_registro
		into :ll_id_registro
		from registro r, esercizio e
		where r.id_esercizio=e.id_esercizio
		and data_inizio<= :ldt_data_reg and data_fine>=:ldt_data_reg
		and r.tipo_registro=:ls_tipo_reg
		and r.numero=:li_numero_reg
		;
		dw_single.setitem(i, "reg_pd_id_registro", ll_id_registro)
//		if dw_single.update()=1 then
//			commit;
//		else
//			rollback;
//			messagebox("Attenzione!", "Salvataggio riga "+string(i)+" non riuscito!")
//		end if
	end if
next
end event

