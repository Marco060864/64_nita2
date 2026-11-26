forward
global type w_st_doc_pdf_excel from w_001
end type
type dw_1 from udw_base within w_st_doc_pdf_excel
end type
type rb_tutte from radiobutton within w_st_doc_pdf_excel
end type
type rb_solo_mail from radiobutton within w_st_doc_pdf_excel
end type
type rb_prezzi_confermati from radiobutton within w_st_doc_pdf_excel
end type
type dw_2 from udw_base within w_st_doc_pdf_excel
end type
type cb_stampa from commandbutton within w_st_doc_pdf_excel
end type
type st_2 from statictext within w_st_doc_pdf_excel
end type
type st_3 from statictext within w_st_doc_pdf_excel
end type
type st_4 from statictext within w_st_doc_pdf_excel
end type
type st_5 from statictext within w_st_doc_pdf_excel
end type
type st_7 from statictext within w_st_doc_pdf_excel
end type
type st_8 from statictext within w_st_doc_pdf_excel
end type
type st_9 from statictext within w_st_doc_pdf_excel
end type
type st_6 from statictext within w_st_doc_pdf_excel
end type
type rb_prezzi_controllati from radiobutton within w_st_doc_pdf_excel
end type
type cbx_sintetica from checkbox within w_st_doc_pdf_excel
end type
type sle_report from singlelineedit within w_st_doc_pdf_excel
end type
type cbx_prezzo from checkbox within w_st_doc_pdf_excel
end type
type cbx_importo from checkbox within w_st_doc_pdf_excel
end type
type pb_excel from picturebutton within w_st_doc_pdf_excel
end type
type dw_3 from udw_000 within w_st_doc_pdf_excel
end type
type st_10 from statictext within w_st_doc_pdf_excel
end type
type sle_path from singlelineedit within w_st_doc_pdf_excel
end type
type st_11 from statictext within w_st_doc_pdf_excel
end type
type r_1 from rectangle within w_st_doc_pdf_excel
end type
type r_2 from rectangle within w_st_doc_pdf_excel
end type
type r_3 from rectangle within w_st_doc_pdf_excel
end type
type r_4 from rectangle within w_st_doc_pdf_excel
end type
end forward

global type w_st_doc_pdf_excel from w_001
integer x = 1057
integer y = 483
integer width = 4407
integer height = 1644
string title = "W_st_doc_pdf_excel"
dw_1 dw_1
rb_tutte rb_tutte
rb_solo_mail rb_solo_mail
rb_prezzi_confermati rb_prezzi_confermati
dw_2 dw_2
cb_stampa cb_stampa
st_2 st_2
st_3 st_3
st_4 st_4
st_5 st_5
st_7 st_7
st_8 st_8
st_9 st_9
st_6 st_6
rb_prezzi_controllati rb_prezzi_controllati
cbx_sintetica cbx_sintetica
sle_report sle_report
cbx_prezzo cbx_prezzo
cbx_importo cbx_importo
pb_excel pb_excel
dw_3 dw_3
st_10 st_10
sle_path sle_path
st_11 st_11
r_1 r_1
r_2 r_2
r_3 r_3
r_4 r_4
end type
global w_st_doc_pdf_excel w_st_doc_pdf_excel

type variables
string is_sql
end variables

forward prototypes
public subroutine wf_retrieve ()
public subroutine wf_stampa_pdf (integer ai_ordinamento, long al_id_doc)
end prototypes

public subroutine wf_retrieve ();date ldt_inizio, ldt_fine
ldt_inizio=dw_2.getitemdate(1, "Data_Inizio")
ldt_fine=dw_2.getitemdate(1, "Data_fine")
dw_1.retrieve(ldt_inizio, ldt_fine)

end subroutine

public subroutine wf_stampa_pdf (integer ai_ordinamento, long al_id_doc);string dwsyntax, ls_path_libreria, ls_art_mancanti, ls_path
string ls_des_prof, ls_COD_prof, ls_num_doc, ls_nome_file, ls_test
string ls_destinatario, ls_azienda, ls_testo, ls_indirizzo_e_mail
string ls_oggetto, ls_mail_cc,ls_mail_cc_2, ls_tipo_reg, ls_ret, ls_return, ls_nome_report
long ll_id_ana, ll_id_sog_com, ll_id_prof_doc, ll_len
date ldt_data_doc
datastore ds_stampa
integer li_ret, li_num_righe, li_pos,li_pos_2


select p.codice, d.num_documento, d.data_documento, d.id_sog_commerciale, d.id_prof_documento, p.nome_report, r.tipo_registro
	into :ls_cod_prof, :ls_num_doc, :ldt_data_doc, :ll_id_sog_com, :ll_id_prof_doc, :ls_nome_report, :ls_tipo_reg
	from prof_documento p, documento d, registro r
	where d.id_prof_documento=p.id_prof_documento and r.id_registro=d.id_registro
	and d.id_documento=:al_id_doc;
	
	//se è karizia e rbol e > 31-12-2018  16-7-2018 devo cambiare report da cambiare la data con quella per partire
	if cbx_sintetica.checked then
		//ls_nome_report="d_ddt_rbol_e" //per esterni: samy 20201001
		ls_nome_report=f_scegli_report(al_id_doc, ls_nome_report,ll_id_prof_doc,ll_id_sog_com,ldt_data_doc) //anche qui occorre fare il giochino 20230612
	else
		ls_nome_report=f_scegli_report(al_id_doc, ls_nome_report,ll_id_prof_doc,ll_id_sog_com,ldt_data_doc)
	end if
	sle_report.text=ls_nome_report
	sle_report.textcolor=255
	sle_report.Weight=700 //bold

select codice, libreria
into :ls_test, :ls_path_libreria
from conf_oggetti
where codice= :ls_nome_report;

if ls_path_libreria> " " then
	ls_oggetto=ls_cod_prof+" n. "+ls_num_doc+" del "+string(ldt_data_doc, "dd/mm/yyyy")
	dwsyntax = LibraryExport(ls_path_libreria, ls_nome_report, ExportDataWindow!)
	IF dwsyntax>"" THEN
		ds_stampa=create datastore
		ds_stampa.create(dwsyntax)
		ds_stampa.settransobject(sqlca)
		li_num_righe=ds_stampa.retrieve(al_id_doc)
	
		//090712 per samy: inserisco eventuali articoli mancanti al completamento del pronto
		ls_art_mancanti=f_controlla_pronto(al_id_doc)
		if ls_art_mancanti>" " then
			ds_stampa.modify("t_art_mancanti.text='"+ls_art_mancanti+"'")
		end if
		//fine 090712 per samy
	else
		messagebox("Errore!", "Dw di stampa "+ls_nome_report+" non trovata! Aggiungila in 'INSERISCI STAMPE'")
//		return -1	
	end if
	
	
//	select dir_output
//	into :ls_path
//	from orafo_par_sistema;
//	if isnull(ls_path) or ls_path="" then
//		messagebox("Attenzione!", "Specificare la directory di output nei parametri di sistema!")
////		return -1
//	end if
	ls_path=sle_path.text  //20250623 prendo path da sle_path
		if isnull(ls_path) or ls_path<=" " then 
			ls_path="\\server2021\pdf_excel_karizia\pdf\"  //20250623 cambio path
		else
			ls_path+="\pdf\"
		end if
	if not(DirectoryExists(ls_path)) then
    		//la creo
		CreateDirectory(ls_path)
   	 	//MessageBox("Info", "La cartella non esiste.")
	end if
	//if right(ls_path, 1)<>"\" then ls_path+="\"
	ls_nome_file=ls_path+ls_cod_prof+ls_num_doc+"_"+string(ldt_data_doc, "dd-mm-yyyy")+".pdf"
	ls_nome_file=f_controlla_nome_file(ls_nome_file)
	//ls_test=ds_stampa.Modify("DataWindow.Print.filename = '"+ls_nome_file+"'")
	
	if cbx_prezzo.checked then
		//16-03-2016 se  è una bolla (DV) e è stato attivato il flag "senza prezzo" rendo invisibile prezzo e importo
		if ls_tipo_reg='DV' then
			ds_stampa.Modify("c_prezzo.visible =0")
			ds_stampa.modify("riga_documento_tot_riga_val_doc.visible=0")
		end if
	end if
	//240713 se voglio che funga devo aggiungere la stampante da usare 
	//che deve essere una postscript (vedi esempio successivo)
	//dichiarazione intento nuova 2017-04-19
//	If ls_tipo_reg='IV' then  //20250605 commento perché qui NON serve
//		ll_id_ana=ds_stampa.getitemnumber(1, "id_anagrafica")
//	//	ldt_data_doc=ds_stampa.getitemdate(1, "documento_data_documento")
//		ls_return="Operazione non imponibile ai sensi dello Art. 8 2° C. D.P.R. 633 del 26/10/72 e modifiche successive  come  da Vs. dichiarazione di intento N. "&
//		+f_dich_intento_2017(ll_id_ana, ldt_data_doc, "", al_id_doc)
//		ds_stampa.modify("t_dich_intento.text='"+ls_return+"'") 
//		//inserisco galvanica specchietto solo se è d_fattura_s2 silver 18-10-2019
////		if cbx_galvanica.checked and ls_nome_report="D_FATTURA_S2" then
////				ds_stampa.modify("dw_galv.visible=true")
////				ds_stampa.retrieve(al_id_doc)
////		end if
//	end if
	 //fine 2017-04-19
	ds_stampa.Modify("Export.PDF.Method = Distill!")
	ds_stampa.Modify("DataWindow.Print.printername = 'Sybase DataWindow PS'")
	ds_stampa.Modify("Export.PDF.Distill.CustomPostScript='Yes'")

	//ordino secondo il flag impostato nella finestra 13/10/2021 richiesta Samy per Karizia
	if ai_ordinamento = 1 and ls_tipo_reg="DV" then  //20250604 sarebbe 1="C" cliente 
		ls_nome_file=left(ls_nome_file, len(ls_nome_file) - 4)+"_"+string(ai_ordinamento)+".pdf"
		ds_stampa.setsort("c_ordina_per_cliente, data_prev_consegna_1, c_num_pacco, riga_documento_id_riga_documento")
		ds_stampa.sort()
	end if		
	
	li_ret=ds_stampa.SaveAs(ls_nome_file, PDF!, FALSE)
	IF LI_RET<> 1 THEN
		messagebox("Errore!", "File PDF non generato!")	
	else  //20230908 per LABELLA: ogni tanto crea pdf vuoto, allora controllo len del file e vedo se è pieno p no... altrimenti ristampo finché non lo fa bene!!!!!
		ll_len = FileLength64(ls_nome_file)
		do while ll_len <=3500
			li_ret=ds_stampa.SaveAs(ls_nome_file, PDF!, FALSE)
		loop
	end if
	//20230908 fine
//	//28-04-2016
//	if cbx_brogliaccio.checked then
//		wf_stampa_brogliaccio(al_id_doc, ls_path+"BROGL_"+ls_num_doc+"_"+string(ldt_data_doc, "dd-mm-yyyy")+".pdf")
//		ls_nome_file+=";"+ls_path+"BROGL_"+ls_num_doc+"_"+string(ldt_data_doc, "dd-mm-yyyy")+".pdf"
//	end if
	//fine 28-04-2016
	destroy(ds_stampa)
else
	messagebox("Errore!", "Dw di stampa "+ls_nome_report+" non trovata! Aggiungila in 'INSERISCI STAMPE' ")
end if
end subroutine

on w_st_doc_pdf_excel.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.rb_tutte=create rb_tutte
this.rb_solo_mail=create rb_solo_mail
this.rb_prezzi_confermati=create rb_prezzi_confermati
this.dw_2=create dw_2
this.cb_stampa=create cb_stampa
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
this.st_5=create st_5
this.st_7=create st_7
this.st_8=create st_8
this.st_9=create st_9
this.st_6=create st_6
this.rb_prezzi_controllati=create rb_prezzi_controllati
this.cbx_sintetica=create cbx_sintetica
this.sle_report=create sle_report
this.cbx_prezzo=create cbx_prezzo
this.cbx_importo=create cbx_importo
this.pb_excel=create pb_excel
this.dw_3=create dw_3
this.st_10=create st_10
this.sle_path=create sle_path
this.st_11=create st_11
this.r_1=create r_1
this.r_2=create r_2
this.r_3=create r_3
this.r_4=create r_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.rb_tutte
this.Control[iCurrent+3]=this.rb_solo_mail
this.Control[iCurrent+4]=this.rb_prezzi_confermati
this.Control[iCurrent+5]=this.dw_2
this.Control[iCurrent+6]=this.cb_stampa
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.st_3
this.Control[iCurrent+9]=this.st_4
this.Control[iCurrent+10]=this.st_5
this.Control[iCurrent+11]=this.st_7
this.Control[iCurrent+12]=this.st_8
this.Control[iCurrent+13]=this.st_9
this.Control[iCurrent+14]=this.st_6
this.Control[iCurrent+15]=this.rb_prezzi_controllati
this.Control[iCurrent+16]=this.cbx_sintetica
this.Control[iCurrent+17]=this.sle_report
this.Control[iCurrent+18]=this.cbx_prezzo
this.Control[iCurrent+19]=this.cbx_importo
this.Control[iCurrent+20]=this.pb_excel
this.Control[iCurrent+21]=this.dw_3
this.Control[iCurrent+22]=this.st_10
this.Control[iCurrent+23]=this.sle_path
this.Control[iCurrent+24]=this.st_11
this.Control[iCurrent+25]=this.r_1
this.Control[iCurrent+26]=this.r_2
this.Control[iCurrent+27]=this.r_3
this.Control[iCurrent+28]=this.r_4
end on

on w_st_doc_pdf_excel.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.rb_tutte)
destroy(this.rb_solo_mail)
destroy(this.rb_prezzi_confermati)
destroy(this.dw_2)
destroy(this.cb_stampa)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.st_7)
destroy(this.st_8)
destroy(this.st_9)
destroy(this.st_6)
destroy(this.rb_prezzi_controllati)
destroy(this.cbx_sintetica)
destroy(this.sle_report)
destroy(this.cbx_prezzo)
destroy(this.cbx_importo)
destroy(this.pb_excel)
destroy(this.dw_3)
destroy(this.st_10)
destroy(this.sle_path)
destroy(this.st_11)
destroy(this.r_1)
destroy(this.r_2)
destroy(this.r_3)
destroy(this.r_4)
end on

event ue_postopen;call super::ue_postopen;

date ldt_inizio, ldt_fine


ldt_inizio=dw_2.getitemdate(1, "Data_Inizio")
ldt_fine=dw_2.getitemdate(1, "Data_fine")
dw_1.retrieve(ldt_inizio, ldt_fine)
end event

event open;call super::open;DATE ldt_inizio
string ls_inizio
integer li_anno, li_mese

dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
dw_3.settransobject(sqlca)
dw_3.insertrow(1)

dw_2.insertrow(1)

dw_2.setitem(1, "data_fine", today())

ls_inizio=string(today(), "dd/mm/yy")
li_mese=month(today())
li_anno=year(today())
if li_mese=1 then 
	li_mese=12
	li_anno= li_anno - 1
else
	li_mese= li_mese - 1
end if
ls_inizio="01/"+string(li_mese)+"/"+string(li_anno)
ldt_inizio=date(ls_inizio)
dw_2.setitem(1, "data_inizio", ldt_inizio)
end event

type st_1 from w_001`st_1 within w_st_doc_pdf_excel
end type

type dw_1 from udw_base within w_st_doc_pdf_excel
integer x = 18
integer y = 28
integer width = 3278
integer height = 1460
boolean bringtotop = true
string dataobject = "d_scegli_doc_da_st_pdf_excel"
end type

event doubleclicked;call super::doubleclicked;long ll_id_doc
w_orafo_documento_ordine_cx w_orafo
s_list_main s_list

if row<=0  then return
s_list.s_identifica[1]="id_documento"
s_list.s_modo=modo_modifica
ll_id_doc=getitemnumber(row, "id_documento")
if ll_id_doc>0 then
	s_list.l_identifica[1]=ll_id_doc
	openwithparm(w_orafo, s_list)
end if
end event

event sqlpreview;call super::sqlpreview;//filtro a seconda di quale bottone è premuto
string ls_sql
integer li_ret

if is_sql="" then
	is_sql= sqlsyntax
end if	
ls_sql=is_sql
if rb_prezzi_confermati.checked then
	ls_sql+=" and (documento.stampato='C' or documento.stampato='X')"
elseif rb_solo_mail.checked then
	ls_sql+=" and (documento.stampato='E' or documento.stampato='X')"
elseif rb_prezzi_controllati.checked then
	ls_sql+=" and (documento.creato_in_esenzione= 'C' ) "
else	//rb_tutti.checked
	ls_sql=is_sql
end if
li_ret=setsqlpreview(ls_sql)



end event

type rb_tutte from radiobutton within w_st_doc_pdf_excel
integer x = 3351
integer y = 552
integer width = 320
integer height = 48
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Tutte"
boolean checked = true
end type

event clicked;wf_retrieve()
end event

type rb_solo_mail from radiobutton within w_st_doc_pdf_excel
integer x = 3351
integer y = 616
integer width = 530
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Solo Inviate via  Mail"
end type

event clicked;wf_retrieve()
end event

type rb_prezzi_confermati from radiobutton within w_st_doc_pdf_excel
integer x = 3351
integer y = 696
integer width = 503
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Prezzi Confermati"
end type

event clicked;wf_retrieve()
end event

type dw_2 from udw_base within w_st_doc_pdf_excel
integer x = 3323
integer y = 28
integer width = 690
integer height = 176
boolean bringtotop = true
string dataobject = "d_sel_date_controlla_prezzi"
end type

event itemchanged;call super::itemchanged;date ldt_inizio, ldt_fine

IF DATE(DATA)> DATE("1900-01-01") THEN
	if string(dwo.name)="data_inizio" then
		ldt_inizio=DATE(DATA)
		ldt_fine=dw_2.getitemdate(1, "data_fine")
		IF ldt_fine> DATE("1900-01-01") THEN
			dw_1.retrieve(ldt_inizio, ldt_fine)
		END IF
	elseif string(dwo.name)="data_fine" then
		ldt_fine=DATE(DATA)
		ldt_inizio=dw_2.getitemdate(1, "data_inizio")
		IF ldt_inizio> DATE("1900-01-01") THEN
			dw_1.retrieve(ldt_inizio, ldt_fine)
		END IF
	end if
END IF
end event

type cb_stampa from commandbutton within w_st_doc_pdf_excel
boolean visible = false
integer x = 3337
integer y = 1392
integer width = 320
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stampa"
end type

event clicked;printsetup()

dw_1.print()
end event

type st_2 from statictext within w_st_doc_pdf_excel
integer x = 4494
integer y = 1052
integer width = 773
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "X= Stampato, Inviato e Confermato"
boolean focusrectangle = false
end type

type st_3 from statictext within w_st_doc_pdf_excel
integer x = 4494
integer y = 1132
integer width = 773
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "E= Stampato e Inviato"
boolean focusrectangle = false
end type

type st_4 from statictext within w_st_doc_pdf_excel
integer x = 4494
integer y = 1212
integer width = 773
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "C= Stampato e Confemato"
boolean focusrectangle = false
end type

type st_5 from statictext within w_st_doc_pdf_excel
integer x = 4494
integer y = 1292
integer width = 773
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "S= Stampato"
boolean focusrectangle = false
end type

type st_7 from statictext within w_st_doc_pdf_excel
boolean visible = false
integer x = 4626
integer y = 496
integer width = 640
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Corretto da SARA"
boolean focusrectangle = false
end type

type st_8 from statictext within w_st_doc_pdf_excel
boolean visible = false
integer x = 4626
integer y = 584
integer width = 640
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Corretto da ELEONORA"
boolean focusrectangle = false
end type

type st_9 from statictext within w_st_doc_pdf_excel
boolean visible = false
integer x = 4626
integer y = 676
integer width = 640
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Corretto da SAMY"
boolean focusrectangle = false
end type

type st_6 from statictext within w_st_doc_pdf_excel
boolean visible = false
integer x = 4626
integer y = 768
integer width = 640
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Corretto da ELISA"
boolean focusrectangle = false
end type

type rb_prezzi_controllati from radiobutton within w_st_doc_pdf_excel
integer x = 3351
integer y = 776
integer width = 503
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Prezzi Controllati"
end type

event clicked;wf_retrieve()
end event

type cbx_sintetica from checkbox within w_st_doc_pdf_excel
integer x = 3328
integer y = 240
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
string text = "Sintetica"
end type

type sle_report from singlelineedit within w_st_doc_pdf_excel
integer x = 3319
integer y = 416
integer width = 928
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cbx_prezzo from checkbox within w_st_doc_pdf_excel
integer x = 3648
integer y = 236
integer width = 384
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80269524
string text = "Senza prezzo"
boolean lefttext = true
end type

event clicked;if checked then cbx_importo.checked=true
end event

type cbx_importo from checkbox within w_st_doc_pdf_excel
integer x = 3630
integer y = 316
integer width = 402
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80269524
string text = "Senza Importo"
boolean lefttext = true
end type

type pb_excel from picturebutton within w_st_doc_pdf_excel
integer x = 3968
integer y = 1244
integer width = 343
integer height = 288
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\nita\icone\xls_down.jpg"
alignment htextalign = left!
end type

event clicked;date ldt_data_doc  
long ll_righe, ll_id_doc,ll_id_utente
string LS_NOME_FILE, ls_ordina, ls_tipo_reg, ls_sort,ls_versione_office
integer i
datastore ds_silver
datetime ldtime_data_ora

//20250604 stampo PDF della FATTURA o BOLLA in ordine per cliente (1) e poi per inserimento (non 1)
for i= 1 to dw_1.rowcount()
	if dw_1.getitemnumber(i, "c_scegli")=1 then
		ll_id_doc=0
		ll_id_doc=dw_1.getitemnumber(i, "id_documento")
		
		//20250604 FINE
			
		select r.tipo_registro, d.data_documento into :ls_tipo_reg, :ldt_data_doc
		from dba.registro r, documento d
		where r.id_registro=d.id_registro and d.id_documento=:ll_id_doc;
		wf_stampa_pdf(0, ll_id_doc)
		if ls_tipo_reg="DV" then 	wf_stampa_pdf(1, ll_id_doc)
			
		ds_silver=create datastore
		ls_ordina=dw_3.getitemstring(1, "ordina")
		if isnull(ls_ordina) or ls_ordina="" then ls_ordina='I'
		if ls_ordina="I" or isnull(ls_ordina)  then
			if ls_tipo_reg="DV" then
				ds_silver.dataobject="d_ddt_excel_ins_ra"
			else
				ds_silver.dataobject="d_doc_excel_ins_ra"
			end if
		else
			if ls_tipo_reg="DV" then
				ds_silver.dataobject="d_ddt_excel_ins_ra"
				ls_sort="c_ordina"
			else
				ds_silver.dataobject="d_doc_excel_id_art_ra"
			end if
		end if
		
		ds_silver.settransobject(sqlca)
		ll_righe=ds_silver.retrieve(ll_id_doc)
		if ls_sort>" " then 
			ds_silver.setsort(ls_sort)
			ds_silver.sort()
		end if
		LS_NOME_FILE=sle_path.text  //20250623 prendo path da sle_path
		if isnull(LS_NOME_FILE) or LS_NOME_FILE<=" " then 
			LS_NOME_FILE="\\server2021\pdf_excel_karizia\"  //20250623 cambio path
		else
			LS_NOME_FILE+="\"
		end if
		
		LS_NOME_FILE+="N_"+ dw_1.getitemstring(i, "num_documento")
		LS_NOME_FILE+= "_"+string(ldt_data_doc, "yy-mm-dd")
		ds_silver.saveas(LS_NOME_FILE+".xls",Excel!, false)
		
		destroy ds_silver
		// Creazione dell'oggetto Excel
		
		OLEObject excel
		excel = CREATE OLEObject
		IF excel.ConnectToNewObject("Excel.Application") <> 0 THEN
			 MessageBox("Errore", "Impossibile connettersi a Excel")
			 RETURN
		END IF
		
		// Rendere visibile Excel (utile per debugging)
		excel.Visible = TRUE  
		
		// Apri il file dei dati esportati
		OLEObject workbook
		OLEObject sheetData
		workbook = excel.Workbooks.Open(LS_NOME_FILE+".XLS")
		sheetData = workbook.Sheets(1)
		
		// Apri il file template **prima** di copiare i dati
		OLEObject templateWorkbook
		ls_versione_office=string(excel.Version)
		if pos(ls_versione_office, "8.0")>0 then
			templateWorkbook = excel.Workbooks.Open("c:\nita\excel\modelli\modello.xlt")
		else
			templateWorkbook = excel.Workbooks.Open("c:\nita\excel\modelli\modello.xls")
		end if
		// Attivare il template come file attivo
		//templateWorkbook.Activate()
		// Selezionare il foglio corretto nel template
		OLEObject sheetTemplate
		sheetTemplate = templateWorkbook.Sheets(1)
		
		// Copiare i dati dal file dati e incollarli nel template
		sheetData.UsedRange.Copy()
		//MessageBox("Debug", "Dati copiati correttamente?")
		sheetTemplate.Range("A2").Select()
		sheetTemplate.Paste()
		//sheetTemplate.Range("A2").PasteSpecial(-4122)  // Incolla solo valori
		//20250623 metto anche l'id utente
		ll_id_utente=u_freddie.s_utenti.i_idutente
		// Salva il file risultante con un nuovo nome
		templateWorkbook.SaveAs(LS_NOME_FILE+"_"+string(ll_id_utente)+"_OK.xls")
		
		// Chiudi i file e Excel correttamente
		workbook.Close(FALSE)  // Chiude il file dei dati senza salvare modifiche
		templateWorkbook.Close(TRUE)  // Salva e chiude il template
		excel.Quit()
		DESTROY excel
		ldtime_data_ora=datetime(today(), now())
		update dba.documento set data_ric_consegna =:ldtime_data_ora
		where id_documento=:ll_id_doc;
		if sqlca.sqlcode=0 then
			commit;
		else
			rollback;
			messagebox("Attenzione!", "Data ivnio Excel NON salvata!")
		end if
	end if
next
	
end event

type dw_3 from udw_000 within w_st_doc_pdf_excel
integer x = 3360
integer y = 1380
integer width = 480
integer height = 112
integer taborder = 80
boolean bringtotop = true
string dataobject = "d_ordinamento_rbol"
boolean border = false
string icon = "AppIcon!"
borderstyle borderstyle = stylebox!
end type

event rowfocuschanged;//
end event

type st_10 from statictext within w_st_doc_pdf_excel
integer x = 3401
integer y = 1312
integer width = 343
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ordina per:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_path from singlelineedit within w_st_doc_pdf_excel
integer x = 3538
integer y = 924
integer width = 832
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "\\server2021\pdf_excel_karizia"
borderstyle borderstyle = stylelowered!
end type

type st_11 from statictext within w_st_doc_pdf_excel
integer x = 3305
integer y = 936
integer width = 233
integer height = 56
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Salva in: "
alignment alignment = right!
boolean focusrectangle = false
end type

type r_1 from rectangle within w_st_doc_pdf_excel
boolean visible = false
long linecolor = 65535
linestyle linestyle = transparent!
integer linethickness = 3
long fillcolor = 65535
integer x = 4503
integer y = 484
integer width = 87
integer height = 76
end type

type r_2 from rectangle within w_st_doc_pdf_excel
boolean visible = false
long linecolor = 65535
linestyle linestyle = transparent!
integer linethickness = 3
long fillcolor = 30736255
integer x = 4503
integer y = 572
integer width = 87
integer height = 76
end type

type r_3 from rectangle within w_st_doc_pdf_excel
boolean visible = false
long linecolor = 65535
linestyle linestyle = transparent!
integer linethickness = 3
long fillcolor = 24599526
integer x = 4503
integer y = 664
integer width = 87
integer height = 76
end type

type r_4 from rectangle within w_st_doc_pdf_excel
boolean visible = false
long linecolor = 134217856
linestyle linestyle = transparent!
integer linethickness = 3
long fillcolor = 16776960
integer x = 4503
integer y = 752
integer width = 87
integer height = 76
end type

