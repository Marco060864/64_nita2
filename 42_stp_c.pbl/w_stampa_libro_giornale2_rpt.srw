forward
global type w_stampa_libro_giornale2_rpt from window
end type
type sle_1 from singlelineedit within w_stampa_libro_giornale2_rpt
end type
type cb_8 from commandbutton within w_stampa_libro_giornale2_rpt
end type
type cb_3 from commandbutton within w_stampa_libro_giornale2_rpt
end type
type cbx_ripristino from checkbox within w_stampa_libro_giornale2_rpt
end type
type st_1 from statictext within w_stampa_libro_giornale2_rpt
end type
type cb_2 from commandbutton within w_stampa_libro_giornale2_rpt
end type
type cb_7 from commandbutton within w_stampa_libro_giornale2_rpt
end type
type cb_6 from commandbutton within w_stampa_libro_giornale2_rpt
end type
type cb_5 from commandbutton within w_stampa_libro_giornale2_rpt
end type
type cb_4 from commandbutton within w_stampa_libro_giornale2_rpt
end type
type dw_1 from datawindow within w_stampa_libro_giornale2_rpt
end type
type cb_stampa from commandbutton within w_stampa_libro_giornale2_rpt
end type
type cb_1 from commandbutton within w_stampa_libro_giornale2_rpt
end type
end forward

global type w_stampa_libro_giornale2_rpt from window
integer x = 5
integer y = 48
integer width = 3657
integer height = 2360
boolean titlebar = true
string title = "Stampa Libro Giornale Contabile"
boolean controlmenu = true
windowtype windowtype = response!
windowstate windowstate = maximized!
long backcolor = 79741120
event ue_post_open ( )
sle_1 sle_1
cb_8 cb_8
cb_3 cb_3
cbx_ripristino cbx_ripristino
st_1 st_1
cb_2 cb_2
cb_7 cb_7
cb_6 cb_6
cb_5 cb_5
cb_4 cb_4
dw_1 dw_1
cb_stampa cb_stampa
cb_1 cb_1
end type
global w_stampa_libro_giornale2_rpt w_stampa_libro_giornale2_rpt

type variables
long il_zoom

st_lib_giornale ist_lib_giornale
end variables

event ue_post_open;dw_1.Height=(this.Height) - 272






end event

event open;integer li_pagine, li_a_pag, li_anno
string ls_des_registro

close(w_attesa)

ist_lib_giornale=message.powerobjectparm

sle_1.text="100"
Choose case ist_lib_giornale.ord_testa
	Case 'S'	
		
		if ist_lib_giornale.ordinamento='N' then
			if ist_lib_giornale.manageriale='M' then 
				dw_1.dataobject='d_libro_giornale_new_rpt_a4_manag'
			else
				if ist_lib_giornale.las_aghi='N' then
					dw_1.dataobject='d_libro_giornale_new_rpt_a4'
				elseif 	ist_lib_giornale.las_aghi='P' then
					dw_1.dataobject='d_libro_giornale_new2_rpt_np'
				end if
			end if
		
		else	
   		if ist_lib_giornale.manageriale='M' then 
				dw_1.dataobject='d_libro_giornale_new_rpt2_a4_manag'
			else
				if ist_lib_giornale.las_aghi='N' then 
					dw_1.dataobject='d_libro_giornale_new2_rpt_a4'
				elseif 	ist_lib_giornale.las_aghi='P' then
					dw_1.dataobject='d_libro_giornale_new2_rpt_np'
				else
					dw_1.dataobject='d_libro_giornale_new2_rpt'
				end if	
			end if
		end if	
		
	Case 'N'
		dw_1.dataobject='d_libro_giornale_new3_rpt'
		if ist_lib_giornale.ordinamento='N' then
			if ist_lib_giornale.manageriale='M' then 
				dw_1.dataobject='d_libro_giornale_new_rpt3_a4_manag'
			else
				if ist_lib_giornale.las_aghi='N' then 
					dw_1.dataobject='d_libro_giornale_new3_rpt_a4'
				elseif 	ist_lib_giornale.las_aghi='P' then
					dw_1.dataobject='d_libro_giornale_new2_rpt_np'
				end if
					
			end if
		
		else	
 	  		if ist_lib_giornale.manageriale='M' then 
				dw_1.dataobject='d_libro_giornale_new_rpt4_a4_manag'
			else
				if ist_lib_giornale.las_aghi='N' then 
					dw_1.dataobject='d_libro_giornale_new4_rpt_a4'
				elseif 	ist_lib_giornale.las_aghi='P' then
					dw_1.dataobject='d_libro_giornale_new2_rpt_np'
				else
					dw_1.dataobject='d_libro_giornale_new4_rpt'
				end if	
			end if
		end if	
End Choose

dw_1.settransobject(sqlca)
il_zoom=100
dw_1.retrieve(ist_lib_giornale.sdt_da_data,ist_lib_giornale.sdt_a_data,ist_lib_giornale.d_num,ist_lib_giornale.a_num,ist_lib_giornale.ss_elab_definitiva)

if ist_lib_giornale.las_aghi='P' then
	select pagine_prep, pagine_usate, anno
	into :li_a_pag, :li_pagine, :li_anno
	from dba.contatori_bollati
	where id_registro=:ist_lib_giornale.id_registro;
	select descrizione
	into :ls_des_registro 
	from dba.registro
	where id_registro=:ist_lib_giornale.id_registro;
		
	dw_1.Object.t_reg.text=ls_des_registro

	dw_1.object.pagine2.text=string(li_pagine)
	dw_1.object.t_anno.text=string(li_anno)
	dw_1.object.na_pag.text=string(li_a_pag)
	
end if

dw_1.Object.DataWindow.Print.preview=true

string ls_filter
if ist_lib_giornale.mod_reg<9999 then
	ls_filter="mod_reg="+string(ist_lib_giornale.mod_reg)
	dw_1.setfilter(ls_filter)
	dw_1.filter()
end if	

cb_3.Enabled = false




end event

on w_stampa_libro_giornale2_rpt.create
this.sle_1=create sle_1
this.cb_8=create cb_8
this.cb_3=create cb_3
this.cbx_ripristino=create cbx_ripristino
this.st_1=create st_1
this.cb_2=create cb_2
this.cb_7=create cb_7
this.cb_6=create cb_6
this.cb_5=create cb_5
this.cb_4=create cb_4
this.dw_1=create dw_1
this.cb_stampa=create cb_stampa
this.cb_1=create cb_1
this.Control[]={this.sle_1,&
this.cb_8,&
this.cb_3,&
this.cbx_ripristino,&
this.st_1,&
this.cb_2,&
this.cb_7,&
this.cb_6,&
this.cb_5,&
this.cb_4,&
this.dw_1,&
this.cb_stampa,&
this.cb_1}
end on

on w_stampa_libro_giornale2_rpt.destroy
destroy(this.sle_1)
destroy(this.cb_8)
destroy(this.cb_3)
destroy(this.cbx_ripristino)
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.cb_7)
destroy(this.cb_6)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.dw_1)
destroy(this.cb_stampa)
destroy(this.cb_1)
end on

event key;

keycode			lk_code
string			ls_nome
windowobject	lw_me

lk_code = key



choose case lk_code
	case KeyF12!
		if keyflags=3 then
			ls_nome = this.ClassName()
			MessageBox ("ClassName",ls_nome)
		end if
	case KeyF1!
		if (keyflags = 0 Or keyflags = 1 Or keyflags = 2) then
		end if
end choose
end event

type sle_1 from singlelineedit within w_stampa_libro_giornale2_rpt
integer x = 1477
integer y = 36
integer width = 183
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

event modified;if long(sle_1.text)>0 then
	il_zoom=long(sle_1.text)
	dw_1.object.datawindow.zoom=il_zoom
end if
end event

type cb_8 from commandbutton within w_stampa_libro_giornale2_rpt
integer x = 1957
integer y = 40
integer width = 421
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Mostra sbilanciate"
end type

event clicked;string ls_filtro

if cb_8.text='Mostra sbilanciate' then
	ls_filtro="ver_dare_avere=1"
	dw_1.setfilter(ls_filtro)
	dw_1.Filter()
	cb_8.text='Mostra tutte'
else	
	ls_filtro=""
	dw_1.setfilter(ls_filtro)
	dw_1.Filter()
	cb_8.text='Mostra sbilanciate'
end if	
end event

type cb_3 from commandbutton within w_stampa_libro_giornale2_rpt
integer x = 2391
integer y = 40
integer width = 439
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stampa sbilanciata"
end type

event clicked;	printsetup()
	dw_1.print()
end event

type cbx_ripristino from checkbox within w_stampa_libro_giornale2_rpt
integer x = 2857
integer y = 44
integer width = 498
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Stampa di Ripristino"
boolean lefttext = true
end type

type st_1 from statictext within w_stampa_libro_giornale2_rpt
integer x = 297
integer y = 48
integer width = 187
integer height = 76
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "St. V."
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_stampa_libro_giornale2_rpt
integer x = 2848
integer y = 40
integer width = 517
integer height = 84
integer taborder = 60
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Setup"
end type

event clicked;printsetup()
end event

type cb_7 from commandbutton within w_stampa_libro_giornale2_rpt
event clicked pbm_bnclicked
integer x = 1669
integer y = 40
integer width = 119
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Out"
end type

event clicked;il_zoom=il_zoom - 1
dw_1.object.datawindow.zoom=il_zoom
sle_1.text=string(il_zoom)
end event

type cb_6 from commandbutton within w_stampa_libro_giornale2_rpt
event clicked pbm_bnclicked
integer x = 1358
integer y = 40
integer width = 119
integer height = 84
integer taborder = 70
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "In"
end type

event clicked;il_zoom=il_zoom+1
dw_1.object.datawindow.zoom=il_zoom
sle_1.text=string(il_zoom)
end event

type cb_5 from commandbutton within w_stampa_libro_giornale2_rpt
integer x = 480
integer y = 40
integer width = 411
integer height = 84
integer taborder = 80
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Pag. Precedente"
end type

event clicked;
dw_1.ScrollPriorPage ( ) 
end event

type cb_4 from commandbutton within w_stampa_libro_giornale2_rpt
integer x = 910
integer y = 40
integer width = 411
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Pag. Successiva"
end type

event clicked;dw_1.ScrollNextPage ( ) 
end event

type dw_1 from datawindow within w_stampa_libro_giornale2_rpt
integer x = 14
integer y = 148
integer width = 3611
integer height = 2112
integer taborder = 90
string dataobject = "d_libro_giornale_new_rpt"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event doubleclicked;long ll_riga_ripristino, ll_num_prog
decimal ld_riporto


if cbx_ripristino.checked then
	selectrow(row, not (isselected(row)))
	ll_riga_ripristino=dw_1.getrow()
	
	rowsmove(1, ll_riga_ripristino, primary!, this, 1, filter!)
end if
end event

event retrieveend;
long ll_breakrow, i, ll_breakrow2, j

ll_breakrow = 0
i=1
DO WHILE NOT (ll_breakrow<0)
   ll_breakrow = dw_1.FindGroupChange(ll_breakrow, 1)
	ll_breakrow2 = dw_1.FindGroupChange(ll_breakrow+1, 1)
	IF ll_breakrow2 <= 0 THEN ll_breakrow2=dw_1.rowcount() +1
	
	IF ll_breakrow <= 0 THEN 
		EXIT
	else	
		for j=ll_breakrow to ll_breakrow2 - 1
			dw_1.setItem(j, "aa", i) 
		next	
	   i=i+1
   END IF
	
	ll_breakrow = ll_breakrow + 1
LOOP

end event

type cb_stampa from commandbutton within w_stampa_libro_giornale2_rpt
integer x = 3387
integer y = 40
integer width = 247
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stampa"
end type

event clicked;long ll_ult_row, ll_ret,ll_pagine_usate


ll_ult_row=dw_1.rowcount()
if cbx_ripristino.checked then
	
			
else
	dw_1.setfilter("")
	dw_1.filter()
end if
if ist_lib_giornale.ss_elab_definitiva='S' then
		
	select pagine_prep, pagine_usate
	into :ll_ret, :ll_pagine_usate
	from contatori_bollati
	where tipo='PN' and  id_esercizio=:ist_lib_giornale.sl_id_esercizio;
	ll_ret=ll_ret - ll_pagine_usate
	ll_pagine_usate=dw_1.getitemnumber(1, 'pagine')
	
	if ll_pagine_usate>ll_ret then
		messagebox("Attenzione!", "Le pagine disponibili non sono sufficienti: ~r~ndisponibili n° "+string(ll_ret)&
		+"~r~nnecessarie n° "+string( ll_pagine_usate))
		return
	end if
	
	
	
	ll_ret=dw_1.find("ver_dare_avere=1", 1, ll_ult_row)
	if ll_ret>0 then 
		ll_ret=messagebox("Errore!", "La scrittura n° "+ string(ll_ret)+ " è sbilanciata!"&
		+"~r~nVuoi informazioni su tutte le scritture sbilanciate rilevate?", stopsign!, yesno!)
		if ll_ret=1 then
			
			dw_1.setfilter("ver_dare_avere=0")
			dw_1.filter()
			cb_3.Enabled = TRUE
		end if
		return
	end if
	
	printsetup()
	dw_1.print()
	ll_ret=messagebox("Attenzione!", "La stampa è andata a buon fine?",  stopsign!, yesno!)
	if ll_ret=1 then 
		
		ist_lib_giornale.sl_ult_progressivo=long(dw_1.getitemstring(ll_ult_row, "num_prog2"))
		
		ist_lib_giornale.sd_riporto=dw_1.getitemdecimal(ll_ult_row, "rip")
		
		update esercizio
		set 	ult_data_stampa_bollato= :ist_lib_giornale.sdt_a_data,
				num_progressivo=:ist_lib_giornale.sl_ult_progressivo,
				riporto=:ist_lib_giornale.sd_riporto
		where id_esercizio=:ist_lib_giornale.sl_id_esercizio;
		if sqlca.sqlcode=0 then
			
			commit;
			
		
		
			update contatori_bollati
			set pagine_usate=pagine_usate + :ll_pagine_usate
			where tipo='PN'
			and id_esercizio=:ist_lib_giornale.sl_id_esercizio
			and id_registro=:ist_lib_giornale.id_registro;
			if sqlca.sqlcode=0 then
				commit;
			else
				messagebox("Errore!", "Contatore pagine usate non aggiornate")
				rollback;
			end if
		else 
			messagebox("Errore!", "Dati esercizio non aggiornati")
			rollback;
			
		end if
	else 
		
	end if
else
	printsetup()
	dw_1.print()
end if

CLOSE(PARENT)

end event

type cb_1 from commandbutton within w_stampa_libro_giornale2_rpt
integer x = 23
integer y = 40
integer width = 247
integer height = 84
integer taborder = 100
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Annulla"
end type

event clicked;close(parent)
end event

