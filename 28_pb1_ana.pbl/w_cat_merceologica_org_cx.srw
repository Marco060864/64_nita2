forward
global type w_cat_merceologica_org_cx from w_tree_main
end type
end forward

global type w_cat_merceologica_org_cx from w_tree_main
int Width=2017
boolean TitleBar=true
string Title="Categorie Merceologiche"
end type
global w_cat_merceologica_org_cx w_cat_merceologica_org_cx

on w_cat_merceologica_org_cx.create
call w_tree_main::create
end on

on w_cat_merceologica_org_cx.destroy
call w_tree_main::destroy
end on

type tv_tree from w_tree_main`tv_tree within w_cat_merceologica_org_cx
int TabOrder=10
end type

event tv_tree::ue_load_item;integer il_count
s_item_array lstr_item
string ls_label_cod, ls_label_descr

DECLARE lcur_item CURSOR FOR
SELECT ID_cat_merceologica, ID_cat_mer_superiore , codice, descrizione
    FROM cat_merceologica
	 WHERE cat_merceologica.id_azienda in (0,1);
OPEN lcur_item;

TriggerEvent("ue_sql_verify")
il_count= 0
do while sqlca.sqlcode = 0
	
	fetch lcur_item into :lstr_item.l_id_item, :lstr_item.l_id_parent_item, :ls_label_cod, :ls_label_descr;
	if not IsNull(ls_label_cod) then
		lstr_item.s_label = ls_label_cod +" - "
	end if
	if not IsNull(ls_label_descr) then
		lstr_item.s_label = lstr_item.s_label + ls_label_descr
	end if
	il_count++
	Trigger Event ue_array_insert ( il_count, lstr_item)
	 
loop

close lcur_item;

end event

event tv_tree::ue_init;call super::ue_init;long ll_null
is_title = "Categorie Merceologiche"
is_root_name = "Categorie Merceologiche"

end event

event tv_tree::ue_dd_update;UPDATE Cat_merceologica 
	SET id_cat_mer_superiore = :ll_target_item
	WHERE Cat_merceologica.id_cat_merceologica  = :ll_drag_item
	USING SQLCA ;

IF SQLCA.SQLNRows <> 1 THEN
	MessageBox("Categorie Merceologiche","Problemi in accesso al database!")
	Close(parent)
else
	ib_updated = TRUE
END IF
end event

event tv_tree::clicked;call super::clicked;
end event

type cb_print_setup from w_tree_main`cb_print_setup within w_cat_merceologica_org_cx
int TabOrder=0
end type

type cb_print from w_tree_main`cb_print within w_cat_merceologica_org_cx
int TabOrder=0
end type

type cb_annulla from w_tree_main`cb_annulla within w_cat_merceologica_org_cx
int TabOrder=0
end type

type cb_chiude from w_tree_main`cb_chiude within w_cat_merceologica_org_cx
int TabOrder=0
end type

type cb_salva from w_tree_main`cb_salva within w_cat_merceologica_org_cx
int TabOrder=0
end type

