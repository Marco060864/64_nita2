forward
global type w_copia_distinta_da_altro_articolo from w_semplice_gd
end type
type cb_copia_distinta from commandbutton within w_copia_distinta_da_altro_articolo
end type
end forward

global type w_copia_distinta_da_altro_articolo from w_semplice_gd
integer width = 2423
string title = "Ricopia Distinta da altro Articolo"
cb_copia_distinta cb_copia_distinta
end type
global w_copia_distinta_da_altro_articolo w_copia_distinta_da_altro_articolo

on w_copia_distinta_da_altro_articolo.create
int iCurrent
call super::create
this.cb_copia_distinta=create cb_copia_distinta
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_copia_distinta
end on

on w_copia_distinta_da_altro_articolo.destroy
call super::destroy
destroy(this.cb_copia_distinta)
end on

event resize;call super::resize;cb_copia_distinta.y=newheight - 224
cb_copia_distinta.x=cb_stampa.x +50


end event

type cb_stampa from w_semplice_gd`cb_stampa within w_copia_distinta_da_altro_articolo
boolean visible = false
end type

type cb_ricerca from w_semplice_gd`cb_ricerca within w_copia_distinta_da_altro_articolo
boolean visible = false
end type

type cb_primo from w_semplice_gd`cb_primo within w_copia_distinta_da_altro_articolo
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_copia_distinta_da_altro_articolo
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_copia_distinta_da_altro_articolo
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_copia_distinta_da_altro_articolo
end type

type dw_1 from w_semplice_gd`dw_1 within w_copia_distinta_da_altro_articolo
string dataobject = "d_art_sel_per_distinta"
end type

type cb_inserisci from w_semplice_gd`cb_inserisci within w_copia_distinta_da_altro_articolo
end type

type cb_salva from w_semplice_gd`cb_salva within w_copia_distinta_da_altro_articolo
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_copia_distinta_da_altro_articolo
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_copia_distinta_da_altro_articolo
end type

type cb_ok from w_semplice_gd`cb_ok within w_copia_distinta_da_altro_articolo
end type

type cb_copia_distinta from commandbutton within w_copia_distinta_da_altro_articolo
integer x = 1765
integer y = 1180
integer width = 357
integer height = 96
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Copia distinta"
end type

event clicked;integer i, a, li_ret
long ll_id_articolo, ll_id_distinta, ll_righe, ll_id_new_distinta, ll_null, ll_test
string ls_codice, ls_des_articolo
datastore ds_righe_distinta

setnull(ll_null)
ds_righe_distinta=create datastore
ds_righe_distinta.dataobject="d_riga_dis_base_lt"
ds_righe_distinta.settransobject(sqlca)

for i =1 to dw_1.rowcount()
	ll_id_articolo=dw_1.getitemnumber(i, "id_articolo")
	ll_id_distinta=dw_1.getitemnumber(i, "id_distinta")
	select id_distinta
	into :ll_id_new_distinta
	from dba.distinta
	where id_articolo=:ll_id_articolo
	;
	select codice, descrizione
	into :ls_codice, :ls_des_articolo
	from dba.articolo
	where id_articolo=:ll_id_articolo
	;
	if isnull(ll_id_new_distinta) or ll_id_new_distinta<=0 then
		insert into dba.distinta(codice, descrizione, id_articolo, data_ora_creazione, data_ora_ult_cambiamento, tipo_applicazione, id_azienda)
		values(:ls_codice, :ls_des_articolo, :ll_id_articolo, today(), today(),'V',1);
		if sqlca.sqlcode=0 then
			commit;
			select id_distinta
			into :ll_id_new_distinta
			from dba.distinta
			where id_articolo=:ll_id_articolo
			;
		else
			rollback;
			messagebox("Attenzione!", "Distinta NON salvata: articolo "+ls_codice+"!")
		end if
	end if
	select count()
	into :ll_test
	from dba.riga_distinta
	where id_distinta=:ll_id_new_distinta;
	if ll_test>0 then
		messagebox("Attenzione!", "Righe Distinta già esistenti: articolo "+ls_codice+"!")
		continue
	end if
	ll_righe=ds_righe_distinta.retrieve(ll_id_distinta)
	for a=1 to ll_righe
		ds_righe_distinta.setitem(a, "riga_Distinta_id_riga_distinta", ll_null)	
		ds_righe_distinta.setitem(a, "id_distinta", ll_id_new_distinta)
		ds_righe_distinta.setitemstatus(a, 0, primary!, newmodified!)
	
	next
	li_ret=ds_righe_distinta.update()
	if li_ret=1 then 
		commit;
		dw_1.setitem(i, "OK", "S")
	else
		rollback;
		messagebox("Attenzione!", "Righe Distinta NON copiate: articolo "+ls_codice+"!")
	end if
	
next
end event

