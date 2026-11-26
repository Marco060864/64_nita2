forward
global type w_estensione_tag from w_semplice_gd
end type
type cb_da_excel from commandbutton within w_estensione_tag
end type
type dw_2 from udw_000 within w_estensione_tag
end type
type rb_tutti from radiobutton within w_estensione_tag
end type
type rb_ext from radiobutton within w_estensione_tag
end type
type rb_tag from radiobutton within w_estensione_tag
end type
end forward

global type w_estensione_tag from w_semplice_gd
integer width = 3872
integer height = 2112
cb_da_excel cb_da_excel
dw_2 dw_2
rb_tutti rb_tutti
rb_ext rb_ext
rb_tag rb_tag
end type
global w_estensione_tag w_estensione_tag

on w_estensione_tag.create
int iCurrent
call super::create
this.cb_da_excel=create cb_da_excel
this.dw_2=create dw_2
this.rb_tutti=create rb_tutti
this.rb_ext=create rb_ext
this.rb_tag=create rb_tag
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_da_excel
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.rb_tutti
this.Control[iCurrent+4]=this.rb_ext
this.Control[iCurrent+5]=this.rb_tag
end on

on w_estensione_tag.destroy
call super::destroy
destroy(this.cb_da_excel)
destroy(this.dw_2)
destroy(this.rb_tutti)
destroy(this.rb_ext)
destroy(this.rb_tag)
end on

event resize;call super::resize;
rb_ext.y=cb_ultimo.y
rb_tag.y=cb_ultimo.y
rb_tutti.y=cb_ultimo.y

rb_ext.x=cb_ricerca.x - cb_ricerca.width -100
rb_tag.x=rb_ext.x -rb_ext.width - 20
rb_tutti.x=rb_tag.x -rb_tag.width - 20
cb_da_excel.x=cb_stampa.x + cb_stampa.width + 20
cb_da_excel.y=cb_stampa.y
end event

type cb_stampa from w_semplice_gd`cb_stampa within w_estensione_tag
end type

type cb_ricerca from w_semplice_gd`cb_ricerca within w_estensione_tag
end type

type cb_primo from w_semplice_gd`cb_primo within w_estensione_tag
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_estensione_tag
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_estensione_tag
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_estensione_tag
end type

type dw_1 from w_semplice_gd`dw_1 within w_estensione_tag
integer width = 3648
string dataobject = "d_estensione_tag"
end type

type cb_inserisci from w_semplice_gd`cb_inserisci within w_estensione_tag
end type

type cb_salva from w_semplice_gd`cb_salva within w_estensione_tag
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_estensione_tag
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_estensione_tag
end type

type cb_ok from w_semplice_gd`cb_ok within w_estensione_tag
end type

type cb_da_excel from commandbutton within w_estensione_tag
integer x = 2679
integer y = 1228
integer width = 261
integer height = 96
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "CSV"
end type

event clicked;string ls_path, ls_file, ls_bol
integer i, li_ret
date ldt_data
decimal ldc_peso
long ll_null, ll_test, ll_riga_inserimento

setnull(ll_null)
getfileopenname("Cerca report", ls_path, ls_file, "Excel, *.csv", "csv" , "C:\nita\exp_doc") //20230519 xls diventa xlsx .... proviamo
if  not(trim(ls_file)="" or isnull(ls_file)) then
	dw_2.reset()
	dw_2.importfile(Text!,ls_file,2)
//	if messagebox("W", "W", stopsign!, yesno!)=1 then
		for i= 1 to dw_2.rowcount()
			ls_bol=dw_2.getitemstring(i, "cod_est_tag")
			ll_test=0
			ll_test=dw_1.find("cod_est_tag='"+ls_bol+"'", 1, dw_1.rowcount())
			if ll_test>0 then
				messagebox("Attenzione!", "CODICE "+ls_bol+" ESISTE già in Estensione_tag!")
				continue
			end if
			ll_riga_inserimento=dw_1.rowcount()
			if isnull(ll_riga_inserimento) or ll_riga_inserimento=0 then ll_riga_inserimento=1
			li_ret=dw_2.rowscopy(i, i, primary!, dw_1, ll_riga_inserimento, primary!)
			ldc_peso=dw_1.getitemdecimal(ll_riga_inserimento, "peso")
			if isnull(ldc_peso) then dw_1.setitem(ll_riga_inserimento, "peso", 0)
	//		if sqlca.sqlNrows>0 then
	//			commit;
	//			dw_1.retrieve(ldt_data)
	//		else
	//			rollback;
	//			messagebox("Attenzione!", "bol.: "+ls_bol+" NON inserita in ver_giorno_merce_fo!")
	//			//return
	//		end if
		next
	//end if
end if	 

end event

type dw_2 from udw_000 within w_estensione_tag
boolean visible = false
integer x = 1454
integer y = 1520
integer width = 2327
integer taborder = 90
boolean bringtotop = true
string dataobject = "d_estensione_tag"
end type

type rb_tutti from radiobutton within w_estensione_tag
integer x = 2597
integer y = 1096
integer width = 261
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Tutti"
end type

event clicked;dw_1.setfilter("")
dw_1.filter()
end event

type rb_ext from radiobutton within w_estensione_tag
integer x = 2880
integer y = 1096
integer width = 247
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "EXT"
end type

event clicked;if checked then
	dw_1.setfilter("left(cod_Est_tag, 1)='E'")
	dw_1.filter()
end if
end event

type rb_tag from radiobutton within w_estensione_tag
integer x = 3241
integer y = 1088
integer width = 229
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Tag"
end type

event clicked;if checked then
	dw_1.setfilter("left(cod_Est_tag, 1)='T'")
	dw_1.filter()
end if
end event

