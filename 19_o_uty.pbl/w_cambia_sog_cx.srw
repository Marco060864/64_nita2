forward
global type w_cambia_sog_cx from w_001
end type
type dw_1 from udw_base within w_cambia_sog_cx
end type
type dw_2 from udw_figlia within w_cambia_sog_cx
end type
type cb_inserisci from commandbutton within w_cambia_sog_cx
end type
type cb_salva from commandbutton within w_cambia_sog_cx
end type
type cb_cancella from commandbutton within w_cambia_sog_cx
end type
type cb_annulla from commandbutton within w_cambia_sog_cx
end type
type cb_ok from commandbutton within w_cambia_sog_cx
end type
type st_2 from statictext within w_cambia_sog_cx
end type
type cbx_1 from checkbox within w_cambia_sog_cx
end type
type cb_solo_conto from commandbutton within w_cambia_sog_cx
end type
type cb_cambia from commandbutton within w_cambia_sog_cx
end type
end forward

global type w_cambia_sog_cx from w_001
integer x = 786
integer y = 424
integer width = 2834
integer height = 1424
string title = "Cambia Codice Soggetto/Conto"
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = main!
long backcolor = 80269524
dw_1 dw_1
dw_2 dw_2
cb_inserisci cb_inserisci
cb_salva cb_salva
cb_cancella cb_cancella
cb_annulla cb_annulla
cb_ok cb_ok
st_2 st_2
cbx_1 cbx_1
cb_solo_conto cb_solo_conto
cb_cambia cb_cambia
end type
global w_cambia_sog_cx w_cambia_sog_cx

type variables
integer i_dw_corrente 
integer ii_conta
end variables

forward prototypes
public function integer wf_salva_dw (ref udw_base adw_1, ref udw_figlia adw_2, integer as_flag)
end prototypes

public function integer wf_salva_dw (ref udw_base adw_1, ref udw_figlia adw_2, integer as_flag);
integer li_ret

li_ret=adw_1.triggerevent("ue_update")

if as_flag=2 and li_ret=1 then	
	li_ret=adw_2.triggerevent("ue_update")
end if
return li_ret
	
	
end function

on w_cambia_sog_cx.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_2=create dw_2
this.cb_inserisci=create cb_inserisci
this.cb_salva=create cb_salva
this.cb_cancella=create cb_cancella
this.cb_annulla=create cb_annulla
this.cb_ok=create cb_ok
this.st_2=create st_2
this.cbx_1=create cbx_1
this.cb_solo_conto=create cb_solo_conto
this.cb_cambia=create cb_cambia
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.cb_inserisci
this.Control[iCurrent+4]=this.cb_salva
this.Control[iCurrent+5]=this.cb_cancella
this.Control[iCurrent+6]=this.cb_annulla
this.Control[iCurrent+7]=this.cb_ok
this.Control[iCurrent+8]=this.st_2
this.Control[iCurrent+9]=this.cbx_1
this.Control[iCurrent+10]=this.cb_solo_conto
this.Control[iCurrent+11]=this.cb_cambia
end on

on w_cambia_sog_cx.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.cb_inserisci)
destroy(this.cb_salva)
destroy(this.cb_cancella)
destroy(this.cb_annulla)
destroy(this.cb_ok)
destroy(this.st_2)
destroy(this.cbx_1)
destroy(this.cb_solo_conto)
destroy(this.cb_cambia)
end on

event open;call super::open;long ll_id
dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)

if dw_1.retrieve()>0 then
	ll_id=dw_1.getitemnumber(1,1)
	dw_2.retrieve(ll_id)
end if
	
end event

type st_1 from w_001`st_1 within w_cambia_sog_cx
end type

type dw_1 from udw_base within w_cambia_sog_cx
integer x = 46
integer y = 16
integer width = 2734
integer height = 756
boolean bringtotop = true
string dataobject = "d_anag_sog_conto2_lt"
end type

event rowfocuschanged;long ll_id  

if currentrow>0 then
	
	ll_id=getitemnumber(currentrow, 1)
	
	if ll_id>0 then
		
		dw_2.retrieve(ll_id)
	else
		dw_2.reset()
	end if
end if
setrowfocusindicator(hand!)
end event

event getfocus;call super::getfocus;i_dw_corrente=1
end event

event ue_key;
end event

type dw_2 from udw_figlia within w_cambia_sog_cx
integer x = 46
integer y = 780
integer width = 2286
integer height = 388
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_cambia_cod_soggetto_cx"
boolean vscrollbar = false
end type

event getfocus;call super::getfocus;i_dw_corrente=2
end event

event rowfocuschanged;
end event

event ue_key;
end event

event itemchanged;call super::itemchanged;string ls_mastro, ls_conto, ls_num_conto
integer li_conto

if dwo.name='sottomastro_codice' then
	ls_mastro=dw_2.getitemstring(1, "mastro_codice")
	if ls_mastro> " " then
		if data> " " then
			ls_mastro+=data
			select max(codice)
			into :ls_conto
			from dba.conto
			where left(codice,4)=:ls_mastro
			;
			if ls_conto> " " then
				li_conto=integer(right(ls_conto, 4))
				li_conto++
				ls_num_conto=string(li_conto)
				do while len(ls_num_conto)<4 
					ls_num_conto='0'+ls_num_conto
				loop
				ls_conto=left(ls_conto, 4)+ls_num_conto
				dw_2.setitem(1, "new_codice", ls_conto)
				
			end if
		end if
	end if
			
end if
end event

type cb_inserisci from commandbutton within w_cambia_sog_cx
boolean visible = false
integer x = 46
integer y = 1244
integer width = 261
integer height = 96
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Inserisci"
end type

event clicked;long ll_riga, ll_id
if i_dw_corrente=1 then
	ll_riga=dw_1.trigger event ue_insert(0)
elseif i_dw_corrente=2 then
	ll_riga=dw_1.getrow()
	if ll_riga>0 then
		ll_id=dw_1.getitemnumber(ll_riga, 1)
		if isnull(ll_id)  then
			if ii_conta=2 then
				ii_conta=0
				return
			end if
			if wf_salva_dw(dw_1,dw_2, 1)=1 then
				ii_conta++
				this.triggerevent(clicked!)
			end if
		else
			ll_riga=dw_2.trigger event ue_insert(0)
			dw_2.setitem(ll_riga, 1, ll_id)
		end if
	end if
end if
end event

type cb_salva from commandbutton within w_cambia_sog_cx
boolean visible = false
integer x = 334
integer y = 1244
integer width = 261
integer height = 96
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salva"
end type

event clicked;if i_dw_corrente=1 then
	wf_salva_dw(dw_1, dw_2, 1)
elseif  i_dw_corrente=2 then
	wf_salva_dw(dw_1, dw_2, 2)
end if
end event

type cb_cancella from commandbutton within w_cambia_sog_cx
boolean visible = false
integer x = 622
integer y = 1244
integer width = 261
integer height = 96
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancella"
end type

event clicked;long ll_riga_da_cancellare
if i_dw_corrente=1 then
	ll_riga_da_cancellare=dw_1.getrow()
	if ll_riga_da_cancellare>0 then
	 	dw_1.trigger event ue_delete(ll_riga_da_cancellare)
		
		
		dw_2.reset()
	end if
elseif  i_dw_corrente=2 then
	ll_riga_da_cancellare=dw_2.getrow()
	if ll_riga_da_cancellare>0 then
		dw_2.trigger event ue_delete(ll_riga_da_cancellare)
	end if
end if
end event

type cb_annulla from commandbutton within w_cambia_sog_cx
integer x = 2519
integer y = 804
integer width = 261
integer height = 96
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Annulla"
boolean cancel = true
end type

event clicked;close(parent)
end event

type cb_ok from commandbutton within w_cambia_sog_cx
integer x = 2359
integer y = 804
integer width = 137
integer height = 96
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ok"
boolean default = true
end type

event clicked;if messagebox("Salvare?", "Salvare i dati prima di chiudere?", stopsign!, yesno!)=1 then
	wf_salva_dw(dw_1, dw_2, 2)
end if
close(parent)
end event

type st_2 from statictext within w_cambia_sog_cx
integer x = 46
integer y = 1172
integer width = 2295
integer height = 108
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Dopo aver cambiato uno o più codici è opportuno verificare la stampa del bilancio, le stampe dei saldi contabili (estratto conto) e provvedere al ricalcolo dei saldi mensili!"
boolean focusrectangle = false
end type

type cbx_1 from checkbox within w_cambia_sog_cx
integer x = 2368
integer y = 924
integer width = 343
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Solo Conto"
end type

event clicked;long ll_id

if checked then
	dw_1.dataobject='d_cambia_conto_lt'
	dw_1.settransobject(sqlca)
	dw_2.dataobject='d_cambia_conto2_lt'
	dw_2.settransobject(sqlca)
	cb_solo_conto.visible=true
	cb_cambia.visible=false
	
else
	dw_1.dataobject='d_anag_sog_conto2_lt'
	dw_1.settransobject(sqlca)
	dw_2.dataobject='d_cambia_cod_soggetto_cx'
	dw_2.settransobject(sqlca)
	cb_solo_conto.visible=false
	cb_cambia.visible=true
end if

if dw_1.retrieve()>0 then
	ll_id=dw_1.getitemnumber(1,1)
	dw_2.retrieve(ll_id)
end if
end event

type cb_solo_conto from commandbutton within w_cambia_sog_cx
boolean visible = false
integer x = 2363
integer y = 1028
integer width = 411
integer height = 140
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cambia Conto"
end type

event clicked;string ls_cod_old, ls_cod_new
long ll_id_sottomastro_new

dw_2.accepttext()
ls_cod_old=dw_1.getitemstring(dw_1.getrow(), "conto_codice")
ls_cod_new=dw_2.getitemstring(1, "new_codice")

Select id_sottomastro
into :ll_id_sottomastro_new
from sottomastro s, mastro m
where s.codice=substr(:ls_cod_new,3, 2)
and m.codice=left(:ls_cod_new, 2)
and s.id_mastro=m.id_mastro
;
if ll_id_sottomastro_new>0 then

	update conto
	set codice=:ls_cod_new, id_sottomastro=:ll_id_sottomastro_new
	where codice=:ls_cod_old
	;
	if sqlca.sqlnrows>0 then
		commit;
		dw_1.retrieve()
	else
		rollback;
		messagebox("Attenzione!", "Codice non cambiato!")
	end if
end if
end event

type cb_cambia from commandbutton within w_cambia_sog_cx
integer x = 2363
integer y = 1028
integer width = 411
integer height = 140
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "CAMBIA"
end type

event clicked;string ls_cod_old, ls_cod_new
long ll_row, ll_id_sottomastro_new

dw_2.accepttext()
ls_cod_old=dw_2.getitemstring(1, "sog_commerciale_codice")
ls_cod_new=dw_2.getitemstring(1, "new_codice")

Select id_sottomastro
into :ll_id_sottomastro_new
from sottomastro s, mastro m
where s.codice=substr(:ls_cod_new,3, 2)
and m.codice=left(:ls_cod_new, 2)
and s.id_mastro=m.id_mastro
;
if ll_id_sottomastro_new>0 then

	update conto
	set codice=:ls_cod_new, id_sottomastro=:ll_id_sottomastro_new
	where codice=:ls_cod_old
	;
	if sqlca.sqlcode=0 then
		update sog_commerciale
		set codice=:ls_cod_new
		where codice=:ls_cod_old
		;
		if sqlca.sqlcode=0 then
			commit;
			ll_row=dw_1.getrow()
			dw_1.retrieve()
			dw_1.scrolltorow(ll_row)
		else
			rollback;
			messagebox("Errore!", "Codice su sog_commerciale non salvato!")
		end if
	else
		rollback;
		messagebox("Errore!", "Codice su conto non salvato!")
	end if
else
	messagebox("Errore!", "Il sottomastro indicato non è stato trovato!")
end if
end event

