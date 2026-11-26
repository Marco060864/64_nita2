forward
global type w_grr_brog_contabile_rpt from w_print_main
end type
end forward

global type w_grr_brog_contabile_rpt from w_print_main
int Width=1765
int Height=1036
boolean TitleBar=true
string Title="Stampa Brogliaccio di Verifica"
end type
global w_grr_brog_contabile_rpt w_grr_brog_contabile_rpt

type variables
integer ii_tab_seq_pro
integer ii_tab_seq_dat
long il_id_esercizio
long il_num_pro
date id_ult_dat
end variables

on w_grr_brog_contabile_rpt.create
call super::create
end on

on w_grr_brog_contabile_rpt.destroy
call super::destroy
end on

event ue_pre_print;call super::ue_pre_print;
long		ll_retval
string	ls_da_cod, ls_ad_cod, ls_mov
date		ld_da_data, ld_ad_data

String 	statement, ls_selezione

ls_da_cod	= tab_1.tabpage_select.dw_selection.GetItemString(1,"dalla_caus")
ls_ad_cod	= tab_1.tabpage_select.dw_selection.GetItemString(1,"fino_caus")
ld_da_data	= tab_1.tabpage_select.dw_selection.GetItemDate(1,"dalla_data")
ld_ad_data	= tab_1.tabpage_select.dw_selection.GetItemDate(1,"fino_data")
ls_mov 		= tab_1.tabpage_select.dw_selection.GetItemString(1,"mov_sbilanciati")

statement  = " {Reg_PD.ID_Azienda} = 1"

if ls_da_cod > ls_ad_cod then
	if MessageBox( "Attenzione","Causale 'da' maggiore di causale 'a',continuare ?",Question!,YesNo!,2 ) = 2 then
		return -1
	end if
end if	

if ld_da_data > ld_ad_data then
	if MessageBox( "Attenzione","Data 'da' maggiore di Data 'a',continuare ?",Question!,YesNo!,2 ) = 2 then
		return -1
	end if
end if	



if Not IsNull(ld_da_data) then
	statement 		= statement + " AND {Reg_PD.Data_Registrazione} >= Date (" + string(ld_da_data, "yyyy, mm, dd") + ")"
	ls_selezione 	= " Dalla data registrazione " + string(ld_da_data, "dd/mm/yyyy") + ", "
else
	
	ls_selezione 	= " Dalla data registrazione - non definita, "
end if

if Not IsNull(ld_ad_data) then
	statement 		= statement + " AND {Reg_PD.Data_Registrazione} <= Date (" + string(ld_ad_data, "yyyy, mm, dd") + ")"
	ls_selezione 	= ls_selezione + "alla data registrazione " + string(ld_ad_data, "dd/mm/yyyy") + "."
else
	
	ls_selezione 	= ls_selezione + "alla data registrazione - non definita."	
end if

if Not IsNull(ls_da_cod) and ls_da_cod <> "" then
	statement 		= statement + " AND {Mov_Contabile.Des_Contabile} >= '" + ls_da_cod + "'"
	ls_selezione 	= ls_selezione + " Dalla causale contabile " + ls_da_cod + ", "
else
	ls_selezione = " Dalla causale contabile - non definita, "
end if

if Not IsNull(ls_ad_cod) and ls_ad_cod <> "" then
	statement 		= statement + " AND {Mov_Contabile.Des_Contabile} <= '" + ls_ad_cod + "'"
	ls_selezione 	= ls_selezione + "alla causale contabile " + ls_ad_cod + "."
else
	ls_selezione = ls_selezione + "alla causale contabile - non definita."
end if

if IsNull(ls_mov) or ls_mov = "" then
	ls_mov = "N"
end if	

if ls_mov = "N" then
	ls_selezione = ls_selezione + "Tutti i movimenti."
else
	ls_selezione = ls_selezione + "Solo i movimenti sbilanciati."
end if	


is_selection = statement

istr_formule[1].formula_name 		= "selezione"
istr_formule[1].formula_string 	= "'" + ls_selezione + "'"
istr_formule[2].formula_name 		= "mov_sbilanciati"
istr_formule[2].formula_string 	= "'" + ls_mov + "'"

istr_formule[3].formula_name 		= "id_valuta"
istr_formule[3].formula_string 	= string(tab_1.tabpage_select.dw_selection.getitemnumber(1, "id_valuta"))

return 0
end event

type cb_esci from w_print_main`cb_esci within w_grr_brog_contabile_rpt
int X=1349
end type

type tab_1 from w_print_main`tab_1 within w_grr_brog_contabile_rpt
int Y=200
int Width=1701
int Height=736
end type

type tabpage_select from w_print_main`tabpage_select within tab_1
int X=18
int Y=112
int Width=1664
int Height=608
end type

type dw_selection from w_print_main`dw_selection within tabpage_select
int X=41
int Width=1582
int Height=528
string DataObject="d_grr_brog_contabile_rpt"
end type

event dw_selection::itemchanged;call super::itemchanged;date		ld_dalla_data

CHOOSE CASE dwo.name
	CASE 'fino_data'
		ld_dalla_data = This.GetItemDate(1, "dalla_data")
		if Date(data) < ld_dalla_data then
			MessageBox("Attenzione", "Data fine non può essere inferiore alla data di inizio.")
			Post SetColumn("fino_data")
		end if
END CHOOSE

end event

event dw_selection::ue_init;call super::ue_init;is_drop_column[1] = "dalla_caus"
is_drop_column[2] = "fino_caus"

is_drop_column[3]	= "id_valuta"
is_drop_column[4]	= "id_valuta_des"

end event

event dw_selection::ue_initial;
long	ll_id_valuta 

SELECT id_valuta
INTO	 :ll_id_valuta
FROM	 par_sistema
;

if (ll_id_valuta > 0) then 
	this.setitem(1, "id_valuta", ll_id_valuta)
end if

end event

type tabpage_stampante from w_print_main`tabpage_stampante within tab_1
int X=18
int Y=112
int Width=1664
int Height=608
end type

type tabpage_export from w_print_main`tabpage_export within tab_1
int X=18
int Y=112
int Width=1664
int Height=608
end type

type cb_stampa from w_print_main`cb_stampa within w_grr_brog_contabile_rpt
int X=1093
end type

event cb_stampa::pre_print;call super::pre_print;


end event

