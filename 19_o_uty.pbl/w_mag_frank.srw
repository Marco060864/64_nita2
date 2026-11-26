forward
global type w_mag_frank from w_semplice_cx
end type
type cb_importa from commandbutton within w_mag_frank
end type
type dw_2 from udw_001 within w_mag_frank
end type
end forward

global type w_mag_frank from w_semplice_cx
integer width = 4288
integer height = 2236
cb_importa cb_importa
dw_2 dw_2
end type
global w_mag_frank w_mag_frank

on w_mag_frank.create
int iCurrent
call super::create
this.cb_importa=create cb_importa
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_importa
this.Control[iCurrent+2]=this.dw_2
end on

on w_mag_frank.destroy
call super::destroy
destroy(this.cb_importa)
destroy(this.dw_2)
end on

event resize;call super::resize;cb_importa.y=cb_cancella.y
cb_importa.x=cb_cancella.x + cb_cancella.width +400
dw_1.height=newheight - 292 - dw_2.height 

end event

event open;call super::open;dw_1.retrieve()
end event

type cb_stampa from w_semplice_cx`cb_stampa within w_mag_frank
end type

type cb_ricerca from w_semplice_cx`cb_ricerca within w_mag_frank
end type

type cb_primo from w_semplice_cx`cb_primo within w_mag_frank
end type

type cb_ultimo from w_semplice_cx`cb_ultimo within w_mag_frank
end type

type cb_indietro from w_semplice_cx`cb_indietro within w_mag_frank
end type

type cb_avanti from w_semplice_cx`cb_avanti within w_mag_frank
end type

type dw_1 from w_semplice_cx`dw_1 within w_mag_frank
integer width = 4165
string dataobject = "d_acc_francesco"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type cb_inserisci from w_semplice_cx`cb_inserisci within w_mag_frank
end type

type cb_salva from w_semplice_cx`cb_salva within w_mag_frank
end type

type cb_cancella from w_semplice_cx`cb_cancella within w_mag_frank
end type

type cb_annulla from w_semplice_cx`cb_annulla within w_mag_frank
end type

type cb_ok from w_semplice_cx`cb_ok within w_mag_frank
end type

type cb_importa from commandbutton within w_mag_frank
integer x = 2478
integer y = 984
integer width = 297
integer height = 96
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Importa"
end type

event clicked;string ls_path, ls_file, ls_acc, ls_acc_new,ls_des_new
integer i
long ll_righe, ll_riga_trovata, ll_inserita
datetime ldt_null

setnull(ldt_null)

getfileopenname("Cerca report", ls_path, ls_file, "CSV, *.csv", "csv" , "C:\nita\mag_frank")
if  not(trim(ls_file)="" or isnull(ls_file)) then
	ls_file=left(ls_path, len(ls_path) - 3)+"csv"
	dw_2.importfile(CSV!,ls_file)
//	dw_1.setfilter("acc_francesco > ' ' ")
//	dw_1.filter()
	for i= dw_2.rowcount() to 1 step - 1
		ls_acc=dw_2.getitemstring(i, "acc_francesco")
		if isnull(ls_acc) then
			dw_2.deleterow(i)
		end if	
		
	next
	if messagebox("Attenzione!", "Saranno aggiornate le descrizione degli accessori esistenti e aggiunti i nuovi accessori: procedere?", stopsign!, yesno!)=1 then
		ll_righe=dw_2.rowcount()
		for i = 2 to  ll_righe
			ls_acc_new=dw_2.getitemstring(i, "acc_francesco")
			ls_des_new=dw_2.getitemstring(i, "des_acc_francesco")
		
			ll_riga_trovata=0
			ll_riga_trovata=dw_1.find("acc_francesco='"+ls_acc_new+"'", 1, dw_1.rowcount())
			if ll_riga_trovata>0 then
				if isnull(ls_des_new) or ls_des_new="" then ls_des_new=dw_1.getitemstring(ll_riga_trovata, "des_acc_francesco")
				if ls_des_new<>dw_1.getitemstring(ll_riga_trovata, "des_acc_francesco") then
					dw_1.setitem(ll_riga_trovata, "des_acc_francesco", ls_des_new)
					//20221216 samy vuole anche la data di inserimento
					dw_1.setitem(ll_riga_trovata, "ultima_modifica", today())
				end if
				
			else
				//dw_2.rowscopy(i, i, primary!, dw_1, dw_1.rowcount(), primary!)
				ll_inserita=dw_1.insertrow(0)
				if isnull(ls_des_new) or ls_des_new="" then  ls_des_new= "?"
				dw_1.setitem(ll_inserita, "acc_francesco", ls_acc_new)
				dw_1.setitem(ll_inserita, "des_acc_francesco", ls_des_new)
				dw_1.setitem(ll_inserita, "ultima_modifica", today())
				//dw_1.setitem(i, ", "Inserita riga "+string(i)+" del file xls")
			end if
		next
		
	end if
end if
end event

type dw_2 from udw_001 within w_mag_frank
boolean visible = false
integer x = 119
integer y = 1460
integer width = 3419
integer height = 632
integer taborder = 70
boolean bringtotop = true
boolean titlebar = true
string dataobject = "d_acc_francesco_carica"
boolean vscrollbar = true
boolean resizable = true
end type

