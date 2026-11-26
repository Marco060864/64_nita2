forward
global type w_correggi_intestatario_bollettine from w_np_single_data
end type
type cb_1 from commandbutton within w_correggi_intestatario_bollettine
end type
end forward

global type w_correggi_intestatario_bollettine from w_np_single_data
integer width = 1678
integer height = 1012
cb_1 cb_1
end type
global w_correggi_intestatario_bollettine w_correggi_intestatario_bollettine

on w_correggi_intestatario_bollettine.create
int iCurrent
call super::create
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
end on

on w_correggi_intestatario_bollettine.destroy
call super::destroy
destroy(this.cb_1)
end on

type p_msg_log from w_np_single_data`p_msg_log within w_correggi_intestatario_bollettine
end type

type p_crescente from w_np_single_data`p_crescente within w_correggi_intestatario_bollettine
end type

type p_decrescente from w_np_single_data`p_decrescente within w_correggi_intestatario_bollettine
end type

type dw_single from w_np_single_data`dw_single within w_correggi_intestatario_bollettine
integer x = 41
integer y = 144
integer width = 1499
string dataobject = "d_correggi_intestatario_doc"
end type

type cb_1 from commandbutton within w_correggi_intestatario_bollettine
integer x = 1221
integer y = 20
integer width = 343
integer height = 100
integer taborder = 11
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "CORREGGI"
end type

event clicked;LONG ll_id_sog_giusto, ll_id_sog_bollettina, ll_id_bollettina
integer i

FOR I= 1 TO DW_SINGLE.ROWCOUNT()
	ll_id_sog_giusto=DW_SINGLE.getitemnumber(i, "id_sog_com_ordine")
	ll_id_sog_bollettina=DW_SINGLE.getitemnumber(i, "id_sog_com_bollettina")
	if ll_id_sog_bollettina=ll_id_sog_giusto then continue
	ll_id_bollettina=DW_SINGLE.getitemnumber(i, "id_documento")
	update dba.documento
	set id_sog_commerciale= :ll_id_sog_giusto
	where id_documento=:ll_id_bollettina;
	if sqlca.sqlnrows>0 then
		commit;
		messagebox("OK!", "Tutto OK!")
	else
		rollback;
		messagebox("NO!", "NO")
		exit
	end if
	
next
	
end event

