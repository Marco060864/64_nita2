forward
global type w_dividi_scadenza_gd from w_data_main
end type
type dw_1 from udw_base within w_dividi_scadenza_gd
end type
end forward

global type w_dividi_scadenza_gd from w_data_main
integer width = 4992
integer height = 1816
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
dw_1 dw_1
end type
global w_dividi_scadenza_gd w_dividi_scadenza_gd

type variables
long il_id_scad_originale

end variables

event open;call super::open;u_dw_master_main udw_scad

decimal ldc_scad_imp
string ls_imp, ls_err

udw_scad=message.powerobjectparm

udw_scad.rowscopy(1, udw_scad.rowcount(), primary!, dw_1, 1, primary!)

il_id_scad_originale=dw_1.getitemnumber(1, "id_scadenza")

ldc_scad_imp=dw_1.getitemdecimal(1, "scadenza_importo")
ls_imp=string(ldc_scad_imp, "#,0.00")
ls_err=dw_1.modify("t_imp_originale.text='"+ls_imp+"'")

dw_1.settransobject(sqlca)

end event

on w_dividi_scadenza_gd.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on w_dividi_scadenza_gd.destroy
call super::destroy
destroy(this.dw_1)
end on

type p_msg_log from w_data_main`p_msg_log within w_dividi_scadenza_gd
end type

type p_crescente from w_data_main`p_crescente within w_dividi_scadenza_gd
end type

type p_decrescente from w_data_main`p_decrescente within w_dividi_scadenza_gd
end type

type dw_1 from udw_base within w_dividi_scadenza_gd
event ue_post_insert ( long al_riga )
integer x = 50
integer y = 40
integer width = 4850
integer height = 1636
boolean bringtotop = true
string dataobject = "d_dividi_scadenza_gd"
end type

event ue_post_insert(long al_riga);dwitemstatus ldw_itemstatus
long ll_null, ll_test

setnull(ll_null)

setitem(al_riga, "id_scadenza", ll_null)
ll_test=setitemstatus(al_riga, 0, primary!, newmodified!)


end event

event ue_key;call super::ue_key;choose case key	
case Keyadd!
		
	if (keyFlags=2) then
			triggerevent("ue_insert")
	end if
case KeySubtract!
		if (keyFlags=2) then
						triggerevent("ue_delete")
		end if

case KeyS!
		if (keyFlags=2) then
			triggerevent("ue_update")
		end if
end choose
end event

event ue_insert;long ll_riga_corrente, ll_righe

ll_riga_corrente=dw_1.getrow()
ll_righe=dw_1.rowcount()
if ll_riga_corrente=1 then
	dw_1.rowscopy(1,1, primary!, dw_1, ll_righe, primary!)
end if
post event ue_post_insert(ll_righe + 1)
return ll_righe + 1
end event

event ue_update;call super::ue_update
if ancestorreturnvalue=1 then
	update dba.scadenza
	set esito_pagamento='B'
	where id_scadenza=:il_id_scad_originale
	;
	if sqlca.sqlcode=0 then
		commit;
	else
		rollback;
		messagebox("Attenzione!", "Scadenza originale non bloccata!")
	end if
	
end if
return ancestorreturnvalue
end event

