forward
global type w_bur_spedizione_gd from w_semplice_gd
end type
type cb_csv from commandbutton within w_bur_spedizione_gd
end type
type dw_2 from udw_000 within w_bur_spedizione_gd
end type
end forward

global type w_bur_spedizione_gd from w_semplice_gd
cb_csv cb_csv
dw_2 dw_2
end type
global w_bur_spedizione_gd w_bur_spedizione_gd

on w_bur_spedizione_gd.create
int iCurrent
call super::create
this.cb_csv=create cb_csv
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_csv
this.Control[iCurrent+2]=this.dw_2
end on

on w_bur_spedizione_gd.destroy
call super::destroy
destroy(this.cb_csv)
destroy(this.dw_2)
end on

type cb_stampa from w_semplice_gd`cb_stampa within w_bur_spedizione_gd
end type

type cb_ricerca from w_semplice_gd`cb_ricerca within w_bur_spedizione_gd
end type

type cb_primo from w_semplice_gd`cb_primo within w_bur_spedizione_gd
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_bur_spedizione_gd
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_bur_spedizione_gd
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_bur_spedizione_gd
end type

type dw_1 from w_semplice_gd`dw_1 within w_bur_spedizione_gd
string dataobject = "d_bur_spedizione"
end type

type cb_inserisci from w_semplice_gd`cb_inserisci within w_bur_spedizione_gd
end type

type cb_salva from w_semplice_gd`cb_salva within w_bur_spedizione_gd
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_bur_spedizione_gd
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_bur_spedizione_gd
end type

type cb_ok from w_semplice_gd`cb_ok within w_bur_spedizione_gd
end type

type cb_csv from commandbutton within w_bur_spedizione_gd
integer x = 2350
integer y = 180
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
long  ll_riga_trovata, ll_riga_inserita
date ldt_data_spedizione
//20251025: buratto domani: Francesco vuole che inserisca le righe da file csv con una sola colonna "Bollettina" a partire da riga 2
getfileopenname("Cerca report", ls_path, ls_file, "Excel, *.csv", "csv" , "C:\nita\exp_doc") //20230519 xls diventa xlsx .... proviamo
if  not(trim(ls_file)="" or isnull(ls_file)) then
	dw_2.reset()
	dw_2.importfile(Text!,ls_file)
	for i= 1 to dw_2.rowcount()
		ls_bol=dw_2.getitemstring(i, "bollettina")
		ll_riga_trovata=0
		ll_riga_trovata=dw_1.find("bollettina='"+ls_bol+"'", 1, 999999999)
		if ll_riga_trovata>0 then continue
		ldt_data_spedizione=dw_2.getitemdate(i, "data_spedizione")
		ll_riga_inserita=dw_1.insertrow(0)
		dw_1.setitem(ll_riga_inserita, "bollettina", ls_bol)
		dw_1.setitem(ll_riga_inserita, "data_spedizione", ldt_data_spedizione)
		dw_1.trigger event ue_update()		
	next
end if	 
end event

type dw_2 from udw_000 within w_bur_spedizione_gd
boolean visible = false
integer x = 2149
integer y = 1128
integer taborder = 80
boolean bringtotop = true
string dataobject = "d_imp_bur_spedizione"
end type

