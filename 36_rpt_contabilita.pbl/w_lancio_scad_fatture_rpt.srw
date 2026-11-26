forward
global type w_lancio_scad_fatture_rpt from w_print_main
end type
end forward

global type w_lancio_scad_fatture_rpt from w_print_main
int Width=1719
int Height=880
boolean TitleBar=true
string Title="Stampa"
end type
global w_lancio_scad_fatture_rpt w_lancio_scad_fatture_rpt

type variables
integer ii_tab_seq_pro
integer ii_tab_seq_dat
long il_id_esercizio
long il_num_pro
date id_ult_dat
end variables

on w_lancio_scad_fatture_rpt.create
call super::create
end on

on w_lancio_scad_fatture_rpt.destroy
call super::destroy
end on

event ue_pre_print;call super::ue_pre_print;
long		ll_retval
date		ld_da_data, ld_ad_data

String 	statement, ls_selezione


ld_da_data	= tab_1.tabpage_select.dw_selection.GetItemDate(1,"dalla_data")
ld_ad_data	= tab_1.tabpage_select.dw_selection.GetItemDate(1,"fino_data")




if ld_da_data > ld_ad_data then
	if MessageBox( "Attenzione","Data 'da' maggiore di Data 'a',continuare ?",Question!,YesNo!,2 ) = 2 then
		return -1
	end if
end if	



if Not IsNull(ld_da_data) then
	
	
	statement 		= "{Scadenza.Data_Scadenza} >= Date (" + string(ld_da_data, "yyyy, mm, dd") + ")"
	ls_selezione 	= " Dalla data scadenza " + string(ld_da_data, "dd/mm/yyyy") + ", "
else
	
	ls_selezione 	= " Dalla data scadenza - non definita, "
end if

if Not IsNull(ld_ad_data) then
	
	if statement <> "" then
		statement 		= statement + " AND {Scadenza.Data_Scadenza} <= Date (" + string(ld_ad_data, "yyyy, mm, dd") + ")"
	else	
	
	    statement 		= "{Scadenza.Data_Scadenza} <= Date (" + string(ld_ad_data, "yyyy, mm, dd") + ")"
	end if
	ls_selezione 	= ls_selezione + "alla data scadenza " + string(ld_ad_data, "dd/mm/yyyy") + "."
else
	
	ls_selezione 	= ls_selezione + "alla data scadenza - non definita."	
end if



is_selection = statement

istr_formule[1].formula_name 		= "selezione"
istr_formule[1].formula_string 	= "'" + ls_selezione + "'"

istr_formule[2].formula_name 		= "id_valuta"
istr_formule[2].formula_string 	= string(tab_1.tabpage_select.dw_selection.getitemnumber(1, "id_valuta"))

return 0

end event

event open;call super::open;


end event

event ue_pre_open;this.Title = istr_coddes_rpt.titolo_finestra
end event

type cb_esci from w_print_main`cb_esci within w_lancio_scad_fatture_rpt
int X=983
end type

type tab_1 from w_print_main`tab_1 within w_lancio_scad_fatture_rpt
int X=32
int Y=220
int Width=1655
int Height=552
end type

type tabpage_select from w_print_main`tabpage_select within tab_1
int X=18
int Y=112
int Width=1618
int Height=424
end type

type dw_selection from w_print_main`dw_selection within tabpage_select
int X=23
int Y=36
int Width=1577
int Height=352
string DataObject="d_lancio_scad_fatture_ff"
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

event dw_selection::ue_initial;string	ls_data_oggi
date 		ld_inizio_esercizio

SELECT esercizio.data_inizio INTO :ld_inizio_esercizio
	FROM dba.esercizio WHERE esercizio.id_azienda = 1 ;			
	
this.SetItem(1, "dalla_data",ld_inizio_esercizio )
this.SetItem( 1,"fino_data",Today() )

long	ll_id_valuta 

SELECT id_valuta
INTO	 :ll_id_valuta
FROM	 par_sistema
;

if (ll_id_valuta > 0) then 
	this.setitem(1, "id_valuta", ll_id_valuta)
end if

end event

event dw_selection::ue_init;call super::ue_init;
is_drop_column[1]	= "id_valuta"
is_drop_column[2]	= "id_valuta_des"

end event

type tabpage_stampante from w_print_main`tabpage_stampante within tab_1
int X=18
int Y=112
int Width=1618
int Height=424
end type

type tabpage_export from w_print_main`tabpage_export within tab_1
int X=18
int Y=112
int Width=1618
int Height=424
end type

type cb_stampa from w_print_main`cb_stampa within w_lancio_scad_fatture_rpt
int X=731
end type

event cb_stampa::pre_print;tab_1.tabpage_select.dw_selection.AcceptText ( )
end event

