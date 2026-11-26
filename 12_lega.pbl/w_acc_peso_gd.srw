forward
global type w_acc_peso_gd from w_semplice_gd
end type
type cb_da_excel from commandbutton within w_acc_peso_gd
end type
end forward

global type w_acc_peso_gd from w_semplice_gd
integer width = 2112
integer height = 1548
boolean maxbox = false
boolean resizable = false
windowtype windowtype = popup!
cb_da_excel cb_da_excel
end type
global w_acc_peso_gd w_acc_peso_gd

on w_acc_peso_gd.create
int iCurrent
call super::create
this.cb_da_excel=create cb_da_excel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_da_excel
end on

on w_acc_peso_gd.destroy
call super::destroy
destroy(this.cb_da_excel)
end on

type cb_stampa from w_semplice_gd`cb_stampa within w_acc_peso_gd
end type

type cb_ricerca from w_semplice_gd`cb_ricerca within w_acc_peso_gd
end type

type cb_primo from w_semplice_gd`cb_primo within w_acc_peso_gd
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_acc_peso_gd
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_acc_peso_gd
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_acc_peso_gd
end type

type dw_1 from w_semplice_gd`dw_1 within w_acc_peso_gd
integer width = 1952
string dataobject = "d_acc_peso_gd"
end type

type cb_inserisci from w_semplice_gd`cb_inserisci within w_acc_peso_gd
end type

type cb_salva from w_semplice_gd`cb_salva within w_acc_peso_gd
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_acc_peso_gd
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_acc_peso_gd
end type

type cb_ok from w_semplice_gd`cb_ok within w_acc_peso_gd
end type

type cb_da_excel from commandbutton within w_acc_peso_gd
integer x = 489
integer y = 1316
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
//			dw_1.post retrieve(ldt_data_sped)
//		else
//			rollback;
//			messagebox("Attenzione!", "bol.: "+ls_bol+" NON inserita in ver_giorno_merce_fo!")
//			//return
//		end if
//	next
end if	 

end event

