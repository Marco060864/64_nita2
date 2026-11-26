forward
global type w_cat_merceologica_gd from w_np_single_data
end type
end forward

global type w_cat_merceologica_gd from w_np_single_data
integer width = 4041
integer height = 1812
string title = "Categorie Merceologiche"
end type
global w_cat_merceologica_gd w_cat_merceologica_gd

type variables
integer	ii_gestisci_prd
end variables

forward prototypes
public subroutine uf_set_row_fields (long al_row)
end prototypes

public subroutine uf_set_row_fields (long al_row);
dwItemStatus	ldws_row
long				ll_id_anag_modello
string			ls_codice

IF (ii_gestisci_prd = 0) THEN
	ll_id_anag_modello = dw_single.GetItemNumber(al_row, "id_anag_modello")
	
	SELECT dba.anag_modello.codice
	INTO :ls_codice
	FROM dba.anag_modello
	WHERE (dba.anag_modello.id_anag_modello = :ll_id_anag_modello);
	
	IF SQLCA.SQLCode = 0 THEN
		ldws_row = dw_single.GetItemStatus(al_row, 0, Primary!)
		dw_single.SetItem(al_row, "c_anag_modello_cod", ls_codice)
		dw_single.SetItemStatus(al_row, 0, Primary!, ldws_row)
	END IF
END IF
end subroutine

on w_cat_merceologica_gd.create
call super::create
end on

on w_cat_merceologica_gd.destroy
call super::destroy
end on

event open;
s_list_main	lstr_list

il_HelpTopic = 107

lstr_list = Message.PowerObjectParm


ii_gestisci_prd = 1

//IF lstr_list.s_win_parametri = "CP" THEN
//	dw_single.DataObject = "d_cat_merceologica_gd_prd"
//	dw_single.SetTransObject(SQLCA)
//	ii_gestisci_prd = 0
//END IF

CALL SUPER::open
end event

event ue_comment;call super::ue_comment;
end event

type p_msg_log from w_np_single_data`p_msg_log within w_cat_merceologica_gd
end type

type p_crescente from w_np_single_data`p_crescente within w_cat_merceologica_gd
end type

type p_decrescente from w_np_single_data`p_decrescente within w_cat_merceologica_gd
end type

type dw_single from w_np_single_data`dw_single within w_cat_merceologica_gd
event ue_set_calc_fileds ( )
integer x = 23
integer width = 3927
integer height = 1576
string dataobject = "d_cat_merceologica_gd"
end type

event dw_single::ue_set_calc_fileds;call super::ue_set_calc_fileds;
long ll_conta, ll_num_row

ll_num_row = RowCount()

FOR ll_conta=1 TO ll_num_row
	uf_set_row_fields(ll_conta)
NEXT
end event

event dw_single::ue_init;call super::ue_init;is_title = "Categorie Merceologiche"
end event

event dw_single::ue_set_search;call super::ue_set_search;
CONSTANT integer lci_w_tipo_parte = 2798
CONSTANT integer lci_h_tipo_parte = 873

CHOOSE CASE as_nomecol
		
	CASE "id_reg_fiscale_cod"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_reg_fiscale_gd"
		is_ricpar.s_titolo_finestra = "Registri Fiscali"
		is_ricpar.s_ausil_value[1] = "id_reg_fiscale_des"
	CASE "id_reg_fiscale_des"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_reg_fiscale_gd"
		is_ricpar.s_titolo_finestra = "Registri Fiscali"
		is_ricpar.s_ausil_value[1] = "id_reg_fiscale_cod"

	
	CASE "c_anag_modello_cod"
		is_search_window = "w_anag_modello_coddes_sw"
		is_ricpar.s_filter_value = uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name = "codice"

	CASE "id_tipo_parte_cod"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_tipo_parte_gd"
		is_ricpar.s_titolo_finestra = "Tipi Parte"
		is_ricpar.s_ausil_value[1] = "id_tipo_parte"
		is_ricpar.i_width = lci_w_tipo_parte
		is_ricpar.i_height = lci_h_tipo_parte

END CHOOSE
end event

event dw_single::ue_use_search;call super::ue_use_search;

CHOOSE CASE as_nomecol

	CASE "c_anag_modello_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_anag_modello", is_ricpar.s_id_seg_value[1])

END CHOOSE
end event

event dw_single::itemchanged;call super::itemchanged;
integer	li_ok
string	ls_dbc[], ls_dwc[], ls_dbv[]
string	ls_sql_cond

CHOOSE CASE dwo.Name

	CASE "c_anag_modello_cod"
		ls_sql_cond = ""
		ls_dbc[1] = "id_anag_modello"
		ls_dbc[2] = "codice"
		ls_dwc[1] = "id_anag_modello"
		ls_dwc[2] = "c_anag_modello_cod"
		li_ok = uf_autofind_col(dwo.Name, "anag_modello", "codice", "A", data, &
			ls_sql_cond, 2, ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN RETURN 2

END CHOOSE
end event

event dw_single::retrieveend;call super::retrieveend;Trigger Event ue_set_calc_fileds()
end event

