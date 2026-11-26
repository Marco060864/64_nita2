forward
global type udw_figlia from datawindow
end type
end forward

global type udw_figlia from datawindow
integer width = 494
integer height = 364
integer taborder = 10
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
event type integer ue_update ( )
event type long ue_insert ( integer al_riga_precedente )
event ue_delete ( integer al_riga_da_cancellare )
event ue_rbutton_dblclick pbm_rbuttondblclk
event ue_initial ( long al_riga )
event ue_key pbm_dwnkey
end type
global udw_figlia udw_figlia

event ue_update;integer li_ret

li_ret=update()
if li_ret=1 then
	commit;
else
	rollback;
	messagebox(  this.classname() +" - Salvataggio non riuscito!",sqlca.sqlerrtext)
end if
	
	
	
return li_ret

end event

event type long ue_insert(integer al_riga_precedente);
long ll_riga
ll_riga=this.insertrow(al_riga_precedente)
scrolltorow(ll_riga)
post event ue_initial(ll_riga)
return ll_riga
end event

event ue_delete;
if al_riga_da_cancellare=0 then
	this.rowsmove(1, this.rowcount(), primary!, this, 1, delete!)
else
	this.deleterow(al_riga_da_cancellare)
end if

end event

event ue_key;if keyflags=2 then
	CHOOSE CASE key
		
		CASE KeyS!
			trigger event ue_update()
		CASE KeyI!
			trigger event ue_insert(getrow())
		CASE  keyadd!
			trigger event ue_insert(0)
		CASE KeyD!, keysubtract!
			trigger event ue_delete(getrow())
	END CHOOSE
end if
end event

event losefocus;this.modify("datawindow.color = 79741120")
end event

event getfocus;this.modify("datawindow.color = 10789024")
end event

on udw_figlia.create
end on

on udw_figlia.destroy
end on

