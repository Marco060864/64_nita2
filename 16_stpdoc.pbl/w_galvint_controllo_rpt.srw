forward
global type w_galvint_controllo_rpt from w_stampa
end type
end forward

global type w_galvint_controllo_rpt from w_stampa
integer width = 3566
integer height = 2028
end type
global w_galvint_controllo_rpt w_galvint_controllo_rpt

type variables
s_param_articoli s_par
end variables

on w_galvint_controllo_rpt.create
call super::create
end on

on w_galvint_controllo_rpt.destroy
call super::destroy
end on

event open;call super::open;
//ll_magazzino sta per id_prof_documento
S_PAR=MESSAGE.POWEROBJECTPARM

dw_1.settransobject(sqlca)

dw_1.retrieve(s_par.ll_magazzino)

end event

type pb_1 from w_stampa`pb_1 within w_galvint_controllo_rpt
end type

type cb_preview from w_stampa`cb_preview within w_galvint_controllo_rpt
end type

type dw_1 from w_stampa`dw_1 within w_galvint_controllo_rpt
integer width = 3419
integer height = 1684
string dataobject = "d_galvint_controllo_rpt"
end type

event dw_1::sqlpreview;call super::sqlpreview;string ls_sql
integer i



ls_sql=sqlsyntax
if sqltype<>PreviewUpdate!	then
	if s_par.da_data>date("1900-01-01") then
		ls_sql+=" and documento.data_documento>= "+String(s_par.da_data, "yyyymmdd")
	end if
	if s_par.a_data>date("1900-01-01") then
		ls_sql+=" and documento.data_documento<= "+String(s_par.a_data, "yyyymmdd")
	end if
	i=SetSQLPreview(ls_sql)
	if i<>1 then
		messagebox("Errore!", "Filtro non applicato!")
	end if
end if
end event

type pb_salva_su_file from w_stampa`pb_salva_su_file within w_galvint_controllo_rpt
end type

type pb_stampa from w_stampa`pb_stampa within w_galvint_controllo_rpt
end type

type sle_pg from w_stampa`sle_pg within w_galvint_controllo_rpt
end type

type st_1 from w_stampa`st_1 within w_galvint_controllo_rpt
end type

type st_2 from w_stampa`st_2 within w_galvint_controllo_rpt
end type

type sle_copie from w_stampa`sle_copie within w_galvint_controllo_rpt
end type

type sle_zoom from w_stampa`sle_zoom within w_galvint_controllo_rpt
end type

type cb_7 from w_stampa`cb_7 within w_galvint_controllo_rpt
end type

type cb_6 from w_stampa`cb_6 within w_galvint_controllo_rpt
end type

type cb_pg_dopo from w_stampa`cb_pg_dopo within w_galvint_controllo_rpt
end type

type cb_pg_prima from w_stampa`cb_pg_prima within w_galvint_controllo_rpt
end type

type cb_esci from w_stampa`cb_esci within w_galvint_controllo_rpt
end type

