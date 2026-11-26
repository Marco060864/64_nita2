forward
global type w_imp_prezzi from w_base
end type
type dw_3 from udw_001 within w_imp_prezzi
end type
type cb_3 from commandbutton within w_imp_prezzi
end type
type cb_2 from commandbutton within w_imp_prezzi
end type
type cb_1 from commandbutton within w_imp_prezzi
end type
type dw_2 from udw_001 within w_imp_prezzi
end type
type dw_1 from udw_001 within w_imp_prezzi
end type
end forward

global type w_imp_prezzi from w_base
integer width = 3003
integer height = 2312
dw_3 dw_3
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_2 dw_2
dw_1 dw_1
end type
global w_imp_prezzi w_imp_prezzi

event open;call super::open;dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
dw_3.settransobject(sqlca)
end event

on w_imp_prezzi.create
int iCurrent
call super::create
this.dw_3=create dw_3
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_2=create dw_2
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_3
this.Control[iCurrent+2]=this.cb_3
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.dw_2
this.Control[iCurrent+6]=this.dw_1
end on

on w_imp_prezzi.destroy
call super::destroy
destroy(this.dw_3)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_2)
destroy(this.dw_1)
end on

type dw_3 from udw_001 within w_imp_prezzi
integer x = 82
integer y = 1964
integer width = 2240
integer height = 204
integer taborder = 20
string dataobject = "d_txt_prezzi_da_imp"
end type

type cb_3 from commandbutton within w_imp_prezzi
integer x = 2491
integer y = 824
integer width = 402
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "salva"
end type

event clicked;dw_2.trigger event ue_update()
end event

type cb_2 from commandbutton within w_imp_prezzi
integer x = 2341
integer y = 376
integer width = 434
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Importa Prezzi"
end type

event clicked;integer i
string ls_cod_art, ls_confermato
long ll_id_uc, ll_id_variazione,ll_riga_inserita,ll_id_variazione_test
decimal ldc_prezzo,ldc_prezzo_es, ldc_prezzo_man_es,ldc_prezzo_man
//"C:\Program Files\SQL Anywhere 17\Bin32\dbsrv17.exe" -c 512M -x tcpip  -n nita  "C:\nita\db\munna.db" -n pannaart  "C:\nita\dbital\munna.db" -n italpanna
ll_id_variazione=164

for i= 1 to dw_1.rowcount()
	ll_id_uc=0
	ls_cod_art=""
	ldc_prezzo=0
	ldc_prezzo_man=0
	ls_cod_art=dw_1.getitemstring(i, "cod_art")
	select id_unita_confezione into :ll_id_uc from dba.articolo a, dba.unita_confezione u
	where u.id_articolo=a.id_articolo and u.unita_base='S' and a.codice=:ls_cod_art;
	if ll_id_uc>0 then
		ll_riga_inserita=dw_2.insertrow(0)
		dw_2.setitem(ll_riga_inserita, "id_unita_confezione", ll_id_uc)
		dw_2.setitem(ll_riga_inserita, "id_variazione", ll_id_variazione)
		ldc_prezzo=dw_1.getitemdecimal(ll_riga_inserita, "prezzo")
		if ldc_prezzo>0 then
			dw_2.setitem(ll_riga_inserita, "prezzo", ldc_prezzo)
		else
			ldc_prezzo_man=dw_1.getitemdecimal(ll_riga_inserita, "prezzo_man")
			dw_2.setitem(ll_riga_inserita, "prezzo_manifattura", ldc_prezzo_man)
		end if
		ls_confermato=dw_1.getitemstring(i, "confermato")
		dw_2.setitem(ll_riga_inserita, "confermato", ls_confermato)
		
//		select prezzo, prezzo_manifattura, id_variazione  into :ldc_prezzo_es, :ldc_prezzo_man_es, :ll_id_variazione_test from dba.prezzo
//		where id_variazione=:ll_id_variazione and id_unita_confezione=:ll_id_uc;
//		if isnull(ll_id_variazione_test) or ll_id_variazione_test<=0 then //faccio insert
			insert into dba.prezzo (id_variazione, id_unita_confezione, prezzo, prezzo_manifattura, confermato)
			values (:ll_id_variazione, :ll_id_uc, :ldc_prezzo, :ldc_prezzo_man, :ls_confermato);
			if sqlca.sqlNrows>0 then
				commit;
			else
				rollback;
				update dba.prezzo set prezzo=:ldc_prezzo, prezzo_manifattura=:ldc_prezzo_man, confermato=:ls_confermato
				where id_variazione=:ll_id_variazione and id_unita_confezione=:ll_id_uc;
				if sqlca.sqlNrows>0 then
					commit;
				else
					rollback;
					messagebox("Attenzione!", "Articolo: "+ls_cod_art+" prezzo NON salvato!")
				end if
			end if
//		else
//			//if ldc_prezzo=ldc_prezzo_es or ldc_prezzo_man_es=ldc_prezzo_man then /7faccio comuqnue update
//			update dba.prezzo set prezzo=:ldc_prezzo, prezzo_manifattura=:ldc_prezzo_man, confermato=:ls_confermato
//			where id_variazione=:ll_id_variazione and id_unita_confezione=:ll_id_uc;
//			if sqlca.sqlNrows>0 then
//				commit;
//			else
//				rollback;
//				messagebox("Attenzione!", "Articolo: "+ls_cod_art+" prezzo NON salvato!")
//			end if
//				
//		end if
	end if
	
next
end event

type cb_1 from commandbutton within w_imp_prezzi
integer x = 2341
integer y = 100
integer width = 434
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Carica TXT"
end type

event clicked;string  ls_path, ls_file
integer li_ret

getfileopenname("Cerca DOCasci_", ls_path, ls_file, "txt", "testo, *.txt", "C:\nita\varie")
//if  not(trim(ls_file)="" or isnull(ls_file)) then
//	 tab_1.tabpage_1.dw_prof_documento_gen_ff.setitem(row, "nome_report", ls_path)
//	end if
//end if	 

li_ret=dw_1.importfile(ls_file, 2 )

end event

type dw_2 from udw_001 within w_imp_prezzi
integer x = 46
integer y = 40
integer width = 2071
integer height = 856
integer taborder = 10
string dataobject = "d_imp_prezzi_salva"
boolean vscrollbar = true
end type

type dw_1 from udw_001 within w_imp_prezzi
integer x = 64
integer y = 940
integer width = 2843
integer height = 988
integer taborder = 10
string dataobject = "d_imp_prezzi"
boolean vscrollbar = true
end type

