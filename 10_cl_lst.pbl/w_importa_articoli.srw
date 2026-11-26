forward
global type w_importa_articoli from w_001
end type
type dw_1 from udw_base within w_importa_articoli
end type
type dw_2 from udw_base within w_importa_articoli
end type
type cb_imp_articoli from commandbutton within w_importa_articoli
end type
type cb_car_articoli from commandbutton within w_importa_articoli
end type
type cb_esp_articoli from commandbutton within w_importa_articoli
end type
type dw_3 from udw_base within w_importa_articoli
end type
type dw_4 from udw_base within w_importa_articoli
end type
end forward

global type w_importa_articoli from w_001
integer width = 3867
integer height = 2252
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = main!
dw_1 dw_1
dw_2 dw_2
cb_imp_articoli cb_imp_articoli
cb_car_articoli cb_car_articoli
cb_esp_articoli cb_esp_articoli
dw_3 dw_3
dw_4 dw_4
end type
global w_importa_articoli w_importa_articoli

forward prototypes
public subroutine wf_articolo (long al_id_articolo, long al_riga_doc)
end prototypes

public subroutine wf_articolo (long al_id_articolo, long al_riga_doc);string ls_codice
long ll_riga_trovata, ll_id_art_locale,  ll_null
long ll_id_um, ll_riga_uc, ll_id_uc, ll_riga_trovata_uc

setnull(ll_null)

//
//	ls_codice=dw_4.getitemstring(ll_riga_trovata, "codice")
//	select id_articolo
//	into :ll_id_art_locale
//	from dba.articolo
//	where codice=:ls_codice
//	;
//	if ll_id_art_locale>0 then //l'articolo esiste già non si deve fare nulla
//		dw_2.SetItem(al_riga_doc,"id_articolo", ll_id_art_locale)
//	else //l'articolo non esiste occorre inserirlo
//		dw_6.reset()
//		dw_7.reset()
//		ll_riga_trovata_uc=dw_5.find("id_articolo="+string(al_id_articolo), 1, dw_5.rowcount())
//		if ll_riga_trovata_uc>0 then
//			dw_4.rowscopy(ll_riga_trovata, ll_riga_trovata, primary!, dw_6, 1, primary!)
//			dw_6.setitem(1, "id_articolo", ll_null)
//			dw_6.setitem(1,"id_sog_comm_variante", ll_null)
//			dw_6.setitemstatus(1, 0, Primary!, NewModified!)
//			dw_6.trigger event ue_update()
//			ll_id_art_locale=dw_6.getitemnumber(1, "id_articolo")
//			dw_2.SetItem(al_riga_doc,"id_articolo", ll_id_art_locale)
//			ll_id_um=dw_5.getitemnumber(ll_riga_trovata_uc, "id_unita_misura")
//			ll_riga_uc=dw_7.retrieve(ll_id_art_locale)
//			if ll_riga_uc>0 then
//				ll_id_uc=dw_7.getitemnumber(1, "id_unita_confezione")
//				dw_2.SetItem(al_riga_doc,"id_unita_confezione", ll_id_uc)
//				dw_7.setitem(1, "id_unita_misura", ll_id_um)
//				dw_7.trigger event ue_update()
//			else
//				dw_5.rowscopy(ll_riga_trovata_uc, ll_riga_trovata_uc, primary!, dw_7, 1, primary!)
//				dw_7.SetItem(1,"id_unita_confezione", ll_null)
//				dw_7.setitem(1, "id_articolo", ll_id_art_locale)
//				dw_7.setitemstatus(1, 0, Primary!, NewModified!)
//				dw_7.trigger event ue_update()	
//				ll_id_uc=dw_7.getitemnumber(1, "id_unita_confezione")
//				dw_2.SetItem(al_riga_doc,"id_unita_confezione", ll_id_uc)
//			end if
//		end if
//	end if
//end if
end subroutine

on w_importa_articoli.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_2=create dw_2
this.cb_imp_articoli=create cb_imp_articoli
this.cb_car_articoli=create cb_car_articoli
this.cb_esp_articoli=create cb_esp_articoli
this.dw_3=create dw_3
this.dw_4=create dw_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.cb_imp_articoli
this.Control[iCurrent+4]=this.cb_car_articoli
this.Control[iCurrent+5]=this.cb_esp_articoli
this.Control[iCurrent+6]=this.dw_3
this.Control[iCurrent+7]=this.dw_4
end on

on w_importa_articoli.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.cb_imp_articoli)
destroy(this.cb_car_articoli)
destroy(this.cb_esp_articoli)
destroy(this.dw_3)
destroy(this.dw_4)
end on

event open;call super::open;dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
dw_3.settransobject(sqlca)
dw_4.settransobject(sqlca)

end event

type st_1 from w_001`st_1 within w_importa_articoli
end type

type dw_1 from udw_base within w_importa_articoli
integer x = 64
integer y = 40
integer width = 2843
integer height = 1196
integer taborder = 20
boolean bringtotop = true
string dataobject = "ds_articoli_2016"
boolean hscrollbar = true
end type

type dw_2 from udw_base within w_importa_articoli
integer x = 2985
integer y = 532
integer width = 603
integer height = 400
integer taborder = 30
boolean bringtotop = true
string dataobject = "ds_unita_confezione2_2016"
boolean hscrollbar = true
end type

type cb_imp_articoli from commandbutton within w_importa_articoli
integer x = 3022
integer y = 408
integer width = 471
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Importa Articoli"
end type

event clicked;long i, ll_righe, ll_id_art_locale,ll_null,ll_riga_trovata_uc, ll_id_art_nuovo, ll_id_art_per_Uc
string ls_codice
integer li_ret
long ll_riga_uc_esiste, ll_id_uc

dw_3.reset()
dw_4.reset()
setnull(ll_null)
ll_righe=dw_1.rowcount()
for i= 1 to ll_righe
	ls_codice=dw_1.getitemstring(i, "codice")
	if ls_codice> " " then
		ll_id_art_locale=0
		select id_articolo
		into :ll_id_art_locale
		from dba.articolo
		where codice=:ls_codice
		;
		if ll_id_art_locale>0 then
	
		else
			ll_id_art_per_Uc=dw_1.getitemnumber(i, "id_articolo")
			dw_3.reset()
			dw_4.reset()
			dw_1.rowscopy(i, i, primary!, dw_3, 1, primary!)
			dw_3.setitem(1, "id_articolo", ll_null)
			dw_3.setitem(1,"id_sog_comm_variante", ll_null)
			dw_3.setitem(1,"id_sog_commerciale", ll_null)
			dw_3.setitemstatus(1, 0, Primary!, NewModified!)
			li_ret=dw_3.trigger event ue_update()
			ll_id_art_nuovo=dw_3.getitemnumber(1, "id_articolo")
			//ll_riga_uc_esiste=dw_2.find("id_articolo="+string(ll_id_art_nuovo), 1, dw_2.rowcount())
			//if ll_riga_uc_esiste>0 then continue
			ll_riga_trovata_uc=dw_2.find("id_articolo="+string(ll_id_art_per_Uc), 1, dw_2.rowcount())
			if ll_riga_trovata_uc>0 then
				li_ret=dw_4.retrieve(ll_id_art_nuovo)
				if li_ret>0 then
					ll_id_uc=dw_4.getitemnumber(li_ret, "id_unita_confezione")
					dw_4.reset()
					dw_2.rowscopy(ll_riga_trovata_uc, ll_riga_trovata_uc, primary!, dw_4, 1, primary!)
					dw_4.SetItem(1,"id_unita_confezione", ll_id_uc)
					dw_4.setitem(1, "id_articolo", ll_id_art_nuovo)
					dw_4.setitemstatus(1, 0, Primary!, DataModified!)
				else
					dw_2.rowscopy(ll_riga_trovata_uc, ll_riga_trovata_uc, primary!, dw_4, 1, primary!)
					dw_4.SetItem(1,"id_unita_confezione", ll_null)
					dw_4.setitem(1, "id_articolo", ll_id_art_nuovo)
					dw_4.setitemstatus(1, 0, Primary!, NewModified!)
		
				end if
				
				
				li_ret=dw_4.trigger event ue_update()	
			else
				messagebox("Attenzione!", "uc non trovata!")
			end if
		end if
	end if
next
end event

type cb_car_articoli from commandbutton within w_importa_articoli
integer x = 3022
integer y = 268
integer width = 471
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Carica Articoli"
end type

event clicked;integer li_ret


string ls_path, ls_file
dw_1.reset()

getfileopenname("Cerca Articoli_asci_", ls_path, ls_file)
//if  not(trim(ls_file)="" or isnull(ls_file)) then
//	 tab_1.tabpage_1.dw_prof_documento_gen_ff.setitem(row, "nome_report", ls_path)
//	end if
//end if	 
if ls_file>" " then
	li_ret=dw_1.importfile(ls_file, 2, 99999)
	ls_file="Uc.xml"
	li_ret=dw_2.importfile(ls_file, 2, 99999)
end if
dw_1.sort()

//messagebox("A", li_ret)
//getfileopenname("Cerca RIGAasci_", ls_path, ls_file)
//li_ret=dw_2.importfile(ls_file, 2, 9999)
//messagebox("A", li_ret)
//
//getfileopenname("Cerca ARTasci_", ls_path, ls_file)
//li_ret=dw_4.importfile(ls_file, 2, 9999)
//messagebox("A", li_ret)
//
//getfileopenname("Cerca UCasci_", ls_path, ls_file)
//li_ret=dw_5.importfile(ls_file, 2, 9999)
//messagebox("A", li_ret)
//

end event

type cb_esp_articoli from commandbutton within w_importa_articoli
integer x = 3022
integer y = 128
integer width = 471
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Esporta Articoli"
end type

event clicked;dw_1.retrieve()
dw_2.retrieve()
dw_1.SaveAs("c:\passadati\articoli.xml", XML!, true)
dw_2.SaveAs("c:\passadati\uc.xml", XML!, true)
end event

type dw_3 from udw_base within w_importa_articoli
integer x = 82
integer y = 1268
integer width = 2807
integer height = 836
integer taborder = 40
boolean bringtotop = true
string dataobject = "ds_articolo_2016"
boolean hscrollbar = true
end type

type dw_4 from udw_base within w_importa_articoli
integer x = 2958
integer y = 1492
integer width = 832
integer height = 232
integer taborder = 40
boolean bringtotop = true
string dataobject = "ds_unita_confezione_2016"
boolean hscrollbar = true
end type

