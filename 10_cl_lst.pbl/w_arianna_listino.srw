forward
global type w_arianna_listino from w_semplice_gd
end type
end forward

global type w_arianna_listino from w_semplice_gd
integer width = 3675
end type
global w_arianna_listino w_arianna_listino

on w_arianna_listino.create
call super::create
end on

on w_arianna_listino.destroy
call super::destroy
end on

type cb_stampa from w_semplice_gd`cb_stampa within w_arianna_listino
end type

type cb_ricerca from w_semplice_gd`cb_ricerca within w_arianna_listino
end type

type cb_primo from w_semplice_gd`cb_primo within w_arianna_listino
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_arianna_listino
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_arianna_listino
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_arianna_listino
end type

type dw_1 from w_semplice_gd`dw_1 within w_arianna_listino
integer width = 3534
string dataobject = "d_imp_listino_bucci"
end type

type cb_inserisci from w_semplice_gd`cb_inserisci within w_arianna_listino
end type

type cb_salva from w_semplice_gd`cb_salva within w_arianna_listino
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_arianna_listino
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_arianna_listino
integer weight = 700
string text = "IMPORTA"
end type

event cb_annulla::clicked;string  ls_path, ls_file
integer li_ret

getfileopenname("Cerca DOCasci_", ls_path, ls_file, "txt", "testo, *.txt", "C:\nita\varie")
//if  not(trim(ls_file)="" or isnull(ls_file)) then
//	 tab_1.tabpage_1.dw_prof_documento_gen_ff.setitem(row, "nome_report", ls_path)
//	end if
//end if	 

li_ret=dw_1.importfile(ls_file, 2 )
end event

type cb_ok from w_semplice_gd`cb_ok within w_arianna_listino
end type

