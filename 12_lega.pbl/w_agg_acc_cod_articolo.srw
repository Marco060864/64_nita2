forward
global type w_agg_acc_cod_articolo from w_semplice_gd
end type
type cb_1 from commandbutton within w_agg_acc_cod_articolo
end type
type dw_2 from udw_001 within w_agg_acc_cod_articolo
end type
type cb_2 from commandbutton within w_agg_acc_cod_articolo
end type
type cb_3 from commandbutton within w_agg_acc_cod_articolo
end type
end forward

global type w_agg_acc_cod_articolo from w_semplice_gd
integer width = 5659
integer height = 2324
cb_1 cb_1
dw_2 dw_2
cb_2 cb_2
cb_3 cb_3
end type
global w_agg_acc_cod_articolo w_agg_acc_cod_articolo

on w_agg_acc_cod_articolo.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.dw_2=create dw_2
this.cb_2=create cb_2
this.cb_3=create cb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.cb_3
end on

on w_agg_acc_cod_articolo.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.dw_2)
destroy(this.cb_2)
destroy(this.cb_3)
end on

event open;call super::open;dw_2.settransobject(sqlca)
dw_2.retrieve()
end event

type cb_stampa from w_semplice_gd`cb_stampa within w_agg_acc_cod_articolo
integer x = 535
integer y = 2068
end type

type cb_ricerca from w_semplice_gd`cb_ricerca within w_agg_acc_cod_articolo
integer x = 1600
integer y = 2096
end type

type cb_primo from w_semplice_gd`cb_primo within w_agg_acc_cod_articolo
integer x = 1138
integer y = 1964
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_agg_acc_cod_articolo
integer x = 1554
integer y = 1964
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_agg_acc_cod_articolo
integer x = 1298
integer y = 1964
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_agg_acc_cod_articolo
integer x = 1426
integer y = 1964
end type

type dw_1 from w_semplice_gd`dw_1 within w_agg_acc_cod_articolo
integer width = 3232
integer height = 1880
string dataobject = "d_aggiungi_acc_ad_art2"
end type

type cb_inserisci from w_semplice_gd`cb_inserisci within w_agg_acc_cod_articolo
integer x = 219
integer y = 1948
end type

type cb_salva from w_semplice_gd`cb_salva within w_agg_acc_cod_articolo
integer x = 503
integer y = 1948
end type

event cb_salva::clicked;string ls_art, ls_art_ok
long i, ll_id_art

for i= 1 to dw_1.rowcount()
	//ls_art=dw_1.getitemstring(i, "articolo")
	ls_art_ok=dw_1.getitemstring(i, "c_art_new")
	if ls_art_ok> " " then
		ll_id_art=dw_1.getitemnumber(i, "id_articolo")
		update dba.articolo set codice=:ls_art_ok where id_articolo=:ll_id_art;
		if sqlca.sqlNrows>0 then
			commit;
			dw_1.setitem(i, "articolo_codice",ls_art_ok)
	//		update dba.bollettine_excel set articolo=:ls_art_ok where articolo=:ls_art;
	//		if sqlca.sqlNrows>0 then
	//			commit;
	//			dw_1.setitem(i, "articolo",ls_art_ok)
	//		else
	//			rollback;
	//			dw_1.setitem(i, "articolo",ls_art+"????!")
	//		end if
		else
			rollback;
			//dw_1.setitem(i, "articolo_codice",ls_art+"????!")
		end if
	end if
	
	


	
next
messagebox("OK!", "Completato!")


//dw_1.trigger event ue_update()
end event

type cb_cancella from w_semplice_gd`cb_cancella within w_agg_acc_cod_articolo
integer x = 791
integer y = 1948
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_agg_acc_cod_articolo
integer x = 1893
integer y = 1952
integer weight = 700
string text = "Rinomina"
end type

event cb_annulla::clicked;string ls_art, ls_accessorio, ls_art_ok, ls_acc_des3
integer i, li_pos

for i= 1 to dw_1.rowcount()
	ls_art=dw_1.getitemstring(i, "articolo")
	li_pos=pos(ls_art, "-")
	if li_pos> 0 then
		ls_art_ok=left(ls_art, li_pos - 1)
		ls_accessorio=dw_1.getitemstring(i, "accessorio")
		ls_acc_des3=""
		ls_acc_des3=dw_1.getitemstring(i, "prezzo_des_3")
		if ls_acc_des3> " " then ls_accessorio=ls_acc_des3
		if ls_accessorio> " " then
			if ls_accessorio<>'X' and ls_accessorio<>'XXX' then
				ls_art_ok+="_"+ls_accessorio+right(ls_art, 6)
			else
				ls_art_ok=ls_art
			end if
		else
			ls_art_ok=ls_art
		end if
		dw_1.setitem(i, "c_art_new",ls_art_ok)
	end if
	
next

end event

type cb_ok from w_semplice_gd`cb_ok within w_agg_acc_cod_articolo
integer x = 2185
integer y = 1952
end type

type cb_1 from commandbutton within w_agg_acc_cod_articolo
integer x = 2693
integer y = 1980
integer width = 402
integer height = 112
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "ART_2"
end type

event clicked;string ls_art, ls_accessorio, ls_art_ok, ls_acc_des3, ls_test,ls_finale, ls_iniziale
integer i, li_pos, li_pos2

for i= 1 to dw_1.rowcount()
	ls_art=dw_1.getitemstring(i, "articolo_codice")
	li_pos=pos(ls_art, "-")
	if li_pos> 0 then
		ls_finale=right(ls_art, 6)
		ls_art_ok=left(ls_art, li_pos - 1)
		li_pos2=pos(ls_art, "_@_")
		if li_pos2>0 then
			ls_iniziale=left(ls_art, li_pos2 - 1)
			ls_accessorio=mid(ls_art, li_pos2+2, len(ls_art) - (li_pos2+1) - 6)
			ls_art_ok=ls_iniziale+ls_accessorio+"_@"+ls_finale
		
		else
			continue
		end if
		
//		ls_test=left(ls_art, li_pos - 1)
//		if pos(ls_test, "_")> 0 then continue
//		//ls_accessorio=dw_1.getitemstring(i, "accessorio")
//		ls_acc_des3=""
//		ls_acc_des3=dw_1.getitemstring(i, "prezzo_des_3")
//		if ls_acc_des3> " " then ls_accessorio=ls_acc_des3
//		if ls_accessorio> " " then
//			if ls_accessorio<>'X' and ls_accessorio<>'XXX' then
//				ls_art_ok+="_"+ls_accessorio+right(ls_art, 6)
//			else
//				ls_art_ok=ls_art
//			end if
//		else
//			li_pos=pos(ls_art, "_@")
//			ls_art_ok=left(ls_art, li_pos - 1)+right(ls_art, len(ls_art) - (li_pos + 1))
//			select accessorio into :ls_accessorio from dba.bollettine_excel where articolo=:ls_art_ok;
//			if ls_accessorio> " " then
//				ls_art_ok=left(ls_art, li_pos - 1)
//				ls_art_ok+="_"+ls_accessorio+right(ls_art, 6)
//			else
//				ls_art_ok=ls_art
//			end if
//		end if
		dw_1.setitem(i, "c_art_new",ls_art_ok)
	end if
	
next
end event

type dw_2 from udw_001 within w_agg_acc_cod_articolo
integer x = 3063
integer y = 84
integer width = 2395
integer height = 1832
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_cancella_art_errati2021"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type cb_2 from commandbutton within w_agg_acc_cod_articolo
integer x = 4663
integer y = 2004
integer width = 402
integer height = 112
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Cancella"
end type

event clicked;integer i
long ll_id_art
string ls_test

for i= 1 to dw_2.rowcount()
	
	ll_id_art=dw_2.getitemnumber(i, "articolo_id_articolo")
	if ll_id_art> 0 then
		
		delete dba.articolo  where id_articolo=:ll_id_art;
		if sqlca.sqlNrows>0 then
			commit;
			dw_2.setitem(i, "articolo_codice","cancellato")
		else
			rollback;
			select string(num_progressivo)+' - '+string(data_documento) into :ls_test from documento d, riga_documento r where r.id_articolo=:ll_id_art and d.id_documento=r.id_documento;
			if isnull(ls_test) then ls_test="Fallita"
			dw_2.setitem(i, "articolo_codice",ls_test)
		end if
	end if
	
next
messagebox("OK!", "Completato!")
end event

type cb_3 from commandbutton within w_agg_acc_cod_articolo
integer x = 4160
integer y = 2032
integer width = 402
integer height = 112
integer taborder = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

event clicked;dw_2.print(true, true)
end event

