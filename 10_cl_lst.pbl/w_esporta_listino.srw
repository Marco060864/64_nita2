forward
global type w_esporta_listino from w_001
end type
type cb_csv from commandbutton within w_esporta_listino
end type
type dw_1 from udw_001 within w_esporta_listino
end type
type dw_2 from udw_001 within w_esporta_listino
end type
type cb_carica_prezzi from commandbutton within w_esporta_listino
end type
end forward

global type w_esporta_listino from w_001
cb_csv cb_csv
dw_1 dw_1
dw_2 dw_2
cb_carica_prezzi cb_carica_prezzi
end type
global w_esporta_listino w_esporta_listino

on w_esporta_listino.create
int iCurrent
call super::create
this.cb_csv=create cb_csv
this.dw_1=create dw_1
this.dw_2=create dw_2
this.cb_carica_prezzi=create cb_carica_prezzi
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_csv
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.dw_2
this.Control[iCurrent+4]=this.cb_carica_prezzi
end on

on w_esporta_listino.destroy
call super::destroy
destroy(this.cb_csv)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.cb_carica_prezzi)
end on

event open;call super::open;dw_2.settransobject(sqlca)
end event

event ue_postopen;call super::ue_postopen;dw_2.retrieve(162)
end event

type st_1 from w_001`st_1 within w_esporta_listino
end type

type cb_csv from commandbutton within w_esporta_listino
integer x = 2286
integer y = 480
integer width = 402
integer height = 112
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "CSV"
end type

event clicked;string ls_path, ls_file, ls_bol
integer i
date ldt_data, ldt_data_sped
long ll_null, ll_test

setnull(ll_null)
getfileopenname("Cerca report", ls_path, ls_file, "Excel, *.csv", "csv" , "C:\nita\exp_doc") //20230519 xls diventa xlsx .... proviamo
if  not(trim(ls_file)="" or isnull(ls_file)) then
	dw_1.reset()
	dw_1.importfile(Text!,ls_file)
//	for i= 2 to dw_3.rowcount()
//		ls_bol=dw_3.getitemstring(i, "bollettina")
//		ll_test=0
//		ldt_data_sped= dw_2.getitemdate(1, "dt_data")
//		select id_ver_giorno_merce_fo into :ll_test from  dba.ver_giorno_merce_fo where num_bollettina=:ls_bol and data_spedizione=:ldt_data_sped ;
//		if ll_test>0 then
//			messagebox("Attenzione!", "bol.: "+ls_bol+" ESISTE già in ver_giorno_merce_fo!")
//			continue
//		end if
//		insert into dba.ver_giorno_merce_fo (id_ver_giorno_merce_fo, num_bollettina, data_spedizione, provenienza)
//		values (:ll_null, :ls_bol, :ldt_data_sped, 0);
//		if sqlca.sqlNrows>0 then
//			commit;
//			
//		else
//			rollback;
//			messagebox("Attenzione!", "bol.: "+ls_bol+" NON inserita in ver_giorno_merce_fo!")
//			//return
//		end if
//	next
//	dw_1.post retrieve(ldt_data_sped)
end if	 

end event

type dw_1 from udw_001 within w_esporta_listino
integer x = 434
integer y = 856
integer width = 2263
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_esporta_listino_ext"
boolean vscrollbar = true
end type

type dw_2 from udw_001 within w_esporta_listino
integer x = 1157
integer y = 28
integer width = 1527
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_esporta_munna"
boolean vscrollbar = true
end type

type cb_carica_prezzi from commandbutton within w_esporta_listino
integer x = 2272
integer y = 648
integer width = 402
integer height = 112
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Carica Prezzi"
end type

event clicked;string ls_cod_articolo
long ll_id_articolo,ll_id_uc,ll_id_variazione,ll_riga_trovata
decimal ldc_prezzo_pz,ldc_prezzo_manifattura,ldc_prezzo_al_pezzo2,ldc_prezzo_man2
integer i
ll_id_variazione=162

for i=1 to dw_1.rowcount()
	ls_cod_articolo=dw_1.getitemstring(i,1)
	ls_cod_articolo=mid (ls_cod_articolo,2,len(ls_cod_articolo) - 2)
//	ls_cod_articolo=left(ls_cod_articolo,len(ls_cod_articolo) - 1)
//	ls_cod_articolo=right(ls_cod_articolo,len(ls_cod_articolo) - 1)
	select id_articolo into :ll_id_articolo from articolo where codice=:ls_cod_articolo;
	select id_unita_confezione into :ll_id_uc from unita_confezione where id_articolo=:ll_id_articolo;
	ldc_prezzo_pz=dw_1.getitemdecimal (i,2)
	ldc_prezzo_manifattura=dw_1.getitemdecimal (i,3)
	ll_riga_trovata=dw_2.find("id_unita_confezione="+string(ll_id_uc), 1,dw_2.rowcount())
	ldc_prezzo_al_pezzo2=dw_2.getitemdecimal(ll_riga_trovata,"prezzo")
	ldc_prezzo_man2=dw_2.getitemdecimal(ll_riga_trovata,"prezzo_manifattura")
	if ldc_prezzo_pz>0 then
		if ldc_prezzo_pz<>ldc_prezzo_al_pezzo2 then 
			dw_2.setitem(ll_riga_trovata,"prezzo",ldc_prezzo_pz)
		end if
	end if
		if ldc_prezzo_manifattura>0 then
		if ldc_prezzo_manifattura<>ldc_prezzo_man2 then 
			dw_2.setitem(ll_riga_trovata,"prezzo_manifattura",ldc_prezzo_manifattura)
		end if
	end if
next

end event

