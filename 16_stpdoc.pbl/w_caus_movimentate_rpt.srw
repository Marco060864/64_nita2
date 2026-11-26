forward
global type w_caus_movimentate_rpt from w_stampa
end type
end forward

global type w_caus_movimentate_rpt from w_stampa
end type
global w_caus_movimentate_rpt w_caus_movimentate_rpt

type variables
string ls_sql_1="",  is_sql_originale
end variables

on w_caus_movimentate_rpt.create
call super::create
end on

on w_caus_movimentate_rpt.destroy
call super::destroy
end on

event open;call super::open;dw_1.settransobject(sqlca)

end event

event ue_postopen;call super::ue_postopen;s_param_articoli s_par
string ls_filtro

s_par=message.powerobjectparm
//20240904 finire: recuperare i dati dalla finestra selezione e applicarli a sqlpreview come in altre stampe (w_new_stampa_magazzino)
//poi fare il retrieve()
if s_par.da_data> date("1990-01-01") and  s_par.a_data > date("1990-01-01")  then
	ls_filtro="Da data: "+string(s_par.da_data, "dd/mm/yy")+" a data: "+string(s_par.a_data, "dd/mm/yy")
	ls_sql_1+=" and (documento.data_documento>= date('"+string(s_par.da_data, "yyyy-mm-dd")+"')) and  (documento.data_documento<= date('"+string(s_par.a_data, "yyyy-mm-dd")+"'))"
end if
if s_par.da_cod_art> " " then //è il metallo
	ls_filtro+=" - Metallo: "+ s_par.da_cod_art
	ls_sql_1+=" and (orafo_metallo.codice= '"+string(s_par.da_cod_art)+"') "
end if
if s_par.da_sog_comm> " " then
	if s_par.da_sog_comm="C" then
		ls_filtro+=" - SOLO CLIENTI "
	elseif s_par.da_sog_comm="F" then
		ls_filtro+=" - SOLO FORNITORI "
	end if
	ls_sql_1+=" and (sog_commerciale.tipo= '"+string(s_par.da_sog_comm)+"') "
end if

dw_1.modify("t_filtro.text='"+ls_filtro+"'")
dw_1.retrieve()


end event

type pb_1 from w_stampa`pb_1 within w_caus_movimentate_rpt
end type

type cb_preview from w_stampa`cb_preview within w_caus_movimentate_rpt
end type

type dw_1 from w_stampa`dw_1 within w_caus_movimentate_rpt
string dataobject = "d_caus_movimentate"
end type

event dw_1::sqlpreview;call super::sqlpreview;string ls_sql, ls_sql_2, ls_sql_unione
integer i, li_pos


if sqltype<>PreviewUpdate!	then
	if is_sql_originale="" or isnull(is_sql_originale) then is_sql_originale=sqlsyntax  //20230803 provo così, è forse più semplice...
	//ls_sql=sqlsyntax
	li_pos=pos(upper(is_sql_originale), "GROUP BY")
	//ls_sql_2=left(ls_sql, li_pos - 1)
	if li_pos>0 then 
		ls_sql_2=left(is_sql_originale, li_pos - 1)
	else
		ls_sql_2=is_sql_originale
	end if
	ls_sql_unione=ls_sql_2+ls_sql_1
	ls_sql_unione+=" "+ right(is_sql_originale, len(is_sql_originale) - li_pos +1)
	i=SetSQLPreview(ls_sql_unione)
	if i<>1 then
		messagebox("Errore!", "Filtro non applicato!")
	end if
	
end if

end event

type pb_salva_su_file from w_stampa`pb_salva_su_file within w_caus_movimentate_rpt
end type

type pb_stampa from w_stampa`pb_stampa within w_caus_movimentate_rpt
end type

type sle_pg from w_stampa`sle_pg within w_caus_movimentate_rpt
end type

type st_1 from w_stampa`st_1 within w_caus_movimentate_rpt
end type

type st_2 from w_stampa`st_2 within w_caus_movimentate_rpt
end type

type sle_copie from w_stampa`sle_copie within w_caus_movimentate_rpt
end type

type sle_zoom from w_stampa`sle_zoom within w_caus_movimentate_rpt
end type

type cb_7 from w_stampa`cb_7 within w_caus_movimentate_rpt
end type

type cb_6 from w_stampa`cb_6 within w_caus_movimentate_rpt
end type

type cb_pg_dopo from w_stampa`cb_pg_dopo within w_caus_movimentate_rpt
end type

type cb_pg_prima from w_stampa`cb_pg_prima within w_caus_movimentate_rpt
end type

type cb_esci from w_stampa`cb_esci within w_caus_movimentate_rpt
end type

