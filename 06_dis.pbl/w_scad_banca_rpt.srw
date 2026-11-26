forward
global type w_scad_banca_rpt from w_stampa_001
end type
end forward

global type w_scad_banca_rpt from w_stampa_001
end type
global w_scad_banca_rpt w_scad_banca_rpt

type variables

end variables

event open;call super::open;string ls_filtro, ls_parametri
str_fil_flag str_param

str_param=message.powerobjectparm
ls_filtro=str_param.filtro


//ls_parametri=str_param.parametri
dw_1.settransobject(sqlca)
dw_1.retrieve(str_param.id_banca, str_param.da_data, str_param.a_data)

//this.event post ue_post_open()

end event

on w_scad_banca_rpt.create
call super::create
end on

on w_scad_banca_rpt.destroy
call super::destroy
end on

type dw_1 from w_stampa_001`dw_1 within w_scad_banca_rpt
string dataobject = "d_scad_banca_rpt"
end type

event dw_1::sqlpreview;call super::sqlpreview;//string ls_sql

//
//if st_param.id_banca="data" then
//	ls_sql=sqlsyntax
//	if il_magazzino>0 then
//		ls_sql=ls_sql + " and (riga_documento.id_locazione_1= "+string(il_magazzino)+" or riga_documento.id_locazione_2= "+string(il_magazzino)+")"
//		//messagebox("W", right(sqlsyntax, 400))
//		
//	end if
//	if ii_fiscale=1 then
//		ls_sql=ls_sql + " and not((caus_magazzino.mp_car_fiscali is null) and "&
//		+"(caus_magazzino.mp_scar_fiscali is null) and (caus_magazzino.mp_val_caricato is null) and "&
//		+"(caus_magazzino.mp_val_scaricato is null))"
//	end if
//	if upperbound(id_titolo)>0 then
//		select t.titolo, m.codice
//		into :ld_titolo[1], :ls_cod_met[1]
//		from orafo_titolo t, orafo_metallo m
//		where t.id_titolo=:id_titolo[1]
//		and m.id_metallo=t.id_metallo;
//		if sqlca.sqlcode<>0 then
//			messagebox("Errore", "Titolo1 non recuperato correttamente:sqlpreview, dw_1, 24")
//			return
//		end if
//		select t.titolo, m.codice
//		into :ld_titolo[2], :ls_cod_met[2]
//		from orafo_titolo t, orafo_metallo m
//		where t.id_titolo=:id_titolo[2]
//		and m.id_metallo=t.id_metallo;
//		if sqlca.sqlcode<>0 then
//			messagebox("Errore", "Titolo2 non recuperato correttamente:sqlpreview, dw_1, 33")
//			return
//		end if
//		ls_titolo[1]=string(ld_titolo[1])
//		ls_titolo[2]=string(ld_titolo[2])
//		//questo lo faccio per il formato dei decimali (, in win "." in PB)
//		for i= 1 to 2
//			li_pos=pos(ls_titolo[i], ",")
//			if li_pos>0 then
//				ls_titolo[i]=replace(ls_titolo[i], li_pos, 1, ".")
//			end if
//		next
//		ls_sql=ls_sql + " and orafo_titolo.titolo>= "+ls_titolo[1]&
//		+" and orafo_titolo.titolo<= "+ls_titolo[2]+" and orafo_metallo.codice= '"+ls_cod_met[1]+"'"
//		//+&" and orafo_metallo.codice<= '"+ls_cod_met[2]+"')"
//		
//	end if
//	
//	
//	setsqlpreview(ls_sql)
//	//messagebox("0", right(sqlsyntax, 400))
//end if
end event

type sle_pg from w_stampa_001`sle_pg within w_scad_banca_rpt
end type

type st_1 from w_stampa_001`st_1 within w_scad_banca_rpt
end type

type st_2 from w_stampa_001`st_2 within w_scad_banca_rpt
end type

type sle_copie from w_stampa_001`sle_copie within w_scad_banca_rpt
end type

type sle_zoom from w_stampa_001`sle_zoom within w_scad_banca_rpt
end type

type cb_salva_su_file from w_stampa_001`cb_salva_su_file within w_scad_banca_rpt
end type

type cb_7 from w_stampa_001`cb_7 within w_scad_banca_rpt
end type

type cb_6 from w_stampa_001`cb_6 within w_scad_banca_rpt
end type

type cb_imp_st from w_stampa_001`cb_imp_st within w_scad_banca_rpt
end type

type cb_stampa from w_stampa_001`cb_stampa within w_scad_banca_rpt
end type

type cb_preview from w_stampa_001`cb_preview within w_scad_banca_rpt
end type

type cb_pg_dopo from w_stampa_001`cb_pg_dopo within w_scad_banca_rpt
end type

type cb_pg_prima from w_stampa_001`cb_pg_prima within w_scad_banca_rpt
end type

type cb_1 from w_stampa_001`cb_1 within w_scad_banca_rpt
end type

