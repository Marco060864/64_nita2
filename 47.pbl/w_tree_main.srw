forward
global type w_tree_main from Window
end type
type tv_tree from treeview within w_tree_main
end type
type cb_print_setup from commandbutton within w_tree_main
end type
type cb_print from commandbutton within w_tree_main
end type
type cb_annulla from commandbutton within w_tree_main
end type
type cb_chiude from commandbutton within w_tree_main
end type
type cb_salva from commandbutton within w_tree_main
end type
end forward

global type w_tree_main from Window
int X=833
int Y=373
int Width=1998
int Height=1401
boolean TitleBar=true
string Title="Untitled"
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
event ue_comment ( )
event ue_help ( helpcommand ae_hcom,  long al_helpid,  string as_helpkey )
event ue_postopen ( )
tv_tree tv_tree
cb_print_setup cb_print_setup
cb_print cb_print
cb_annulla cb_annulla
cb_chiude cb_chiude
cb_salva cb_salva
end type
global w_tree_main w_tree_main

type variables
s_item_array	istr_item_array[]
long		il_root_item
integer		ii_size
long		il_dragitem
string		is_dragType
boolean		ib_updated
string		is_title, is_root_name
long		il_starting_value
long		il_width, il_height
long		il_helpTopic = 1

end variables

forward prototypes
public subroutine uf_open_tree ()
public subroutine uf_create_tree ()
public subroutine uf_create_row (string sa_name, long la_parent, long la_ancestor)
public function boolean uf_is_ancestor (long la_handle, long la_target)
public function long uf_design_voice (string sa_name, long la_level, long la_parent)
public subroutine uf_adjust_control (windowobject awobj_control, long al_ratio)
end prototypes

event ue_help;if ae_Hcom = Keyword! then
	ShowHelp(u_freddie.is_helpfile, Keyword!, as_HelpKey)
else
	if ae_Hcom = Topic! then
		ShowHelp(u_freddie.is_helpfile, Topic!, al_HelpId)
	end if
end if

end event

event ue_postopen;
PowerObject		lpo_object
datawindow		ldw_data
integer 			li_size, li_i
integer			li_size_k, li_k
integer			li_size_z, li_z
tab				ltb_panel
UserObject		luo_tab_page
li_size = UpperBound( this.Control )

for li_i = 1 to li_size 
	if not isNull(this.Control[li_i]) then


		if this.Control[li_i].TypeOf() = DataWindow! then
	      ldw_data = this.Control[li_i]
			ldw_data.Object.DataWindow.Help.Command = 1 
			ldw_data.Object.DataWindow.Help.TypeID.Retrieve.Argument = string(this.il_HelpTopic)
		end if	

		
		if this.Control[li_i].TypeOf() = Tab! then
			ltb_panel = this.Control[li_i]
			li_size_k = UpperBound( ltb_panel.Control )
			for li_k = 1 to li_size_k 
				if not isNull(ltb_panel.Control[li_k]) then

					object tipo
					tipo = ltb_panel.Control[li_k].TypeOf()
					if ltb_panel.Control[li_k].TypeOf() = UserObject! then
						luo_tab_page = ltb_panel.Control[li_k]
						li_size_z = UpperBound( luo_tab_page.Control )
						for li_z = 1 to li_size_z 
							if luo_tab_page.Control[li_z].TypeOf() = DataWindow! then
								lpo_object = luo_tab_page.Control[li_z]
								ldw_data   = lpo_object
								ldw_data.Object.DataWindow.Help.Command = 1 
								ldw_data.Object.DataWindow.Help.TypeID.Retrieve.Argument = string(this.il_HelpTopic)
							end if
						next
					end if
				end if	

			
				if ltb_panel.Control[li_k].TypeOf() = DataWindow! then
					lpo_object = ltb_panel.Control[li_k]
					ldw_data   = lpo_object
					ldw_data.Object.DataWindow.Help.Command = 1 
					ldw_data.Object.DataWindow.Help.TypeID.Retrieve.Argument = string(this.il_HelpTopic)
				end if
			next	
		end if	
	end if	
next	

end event

public subroutine uf_open_tree ();long     ll_New, ll_New1
integer  il_count, id_menu, li_dummy
string	ls_select, ls_name, ls_add, ls_menu

ls_menu = Message.StringParm
tv_tree.TriggerEvent("ue_load_item")

ii_size = UpperBound(istr_item_array)
uf_create_tree()


 
 
end subroutine

public subroutine uf_create_tree ();long          ll_index, ll_root
s_item_array       lstr_item
treeviewitem  l_tvi

ll_root = uf_design_voice(is_root_name, 0, 0)
il_root_item = ll_root
if IsNull(il_starting_value) then
	FOR ll_index = 1 to ii_size
			lstr_item = istr_item_array[ll_index]
			IF IsNull(lstr_item.l_id_parent_item) THEN
				if lstr_item.b_visited then
					MessageBox("Categorie Merceologiche","Verificata l'esistenza di un ciclo di categorie merceologiche")
					Close(this)
				else
					lstr_item.b_visited = TRUE
					uf_create_row(lstr_item.s_label ,lstr_item.l_id_item, ll_root)
				end if
				
			END IF
	NEXT
else
	FOR ll_index = 1 to ii_size
		lstr_item = istr_item_array[ll_index]
		IF lstr_item.l_id_parent_item = il_starting_value THEN
			if lstr_item.b_visited then
				MessageBox("Categorie Merceologiche","Verificata l'esistenza di un ciclo di categorie merceologiche")
				Close(this)
			else
				lstr_item.b_visited = TRUE
				uf_create_row(lstr_item.s_label ,lstr_item.l_id_item, ll_root)
			end if
			
		END IF
	NEXT
end if
tv_tree.GetItem(ll_root, l_tvi)
l_tvi.PictureIndex = 3
tv_tree.SetItem(ll_root,l_tvi)
tv_tree.ExpandAll(ll_root)

end subroutine

public subroutine uf_create_row (string sa_name, long la_parent, long la_ancestor);long        ll_index
integer     li_new
s_item_array    lstr_item

li_new = uf_design_voice(sa_name, la_ancestor, la_parent)

FOR ll_index = 1 to ii_size
		lstr_item = istr_item_array[ll_index]
		IF lstr_item.l_id_parent_item = la_parent THEN
			if lstr_item.b_visited then
				MessageBox("Categorie Merceologiche","Verificata l'esistenza di un ciclo di categorie merceologiche")
				Close(this)
			else
				lstr_item.b_visited = TRUE
				uf_create_row(lstr_item.s_label ,lstr_item.l_id_item,  li_New)
			end if
		END IF
NEXT


end subroutine

public function boolean uf_is_ancestor (long la_handle, long la_target);long ll_tvi
boolean lb_is_ancestor

ll_tvi = tv_tree.FindItem(ParentTreeItem! , la_target)
if ll_tvi = la_handle then
	lb_is_ancestor = TRUE
else 
	if ll_tvi > 0 then
		lb_is_ancestor = lb_is_ancestor OR uf_is_ancestor(la_handle, ll_tvi)
	end if
end if
return lb_is_ancestor
end function

public function long uf_design_voice (string sa_name, long la_level, long la_parent);Long            ll_NewItem
TreeViewItem      ltvi_Item

ltvi_Item.label = sa_name
ltvi_Item.PictureIndex = 1
ltvi_Item.SelectedPictureIndex = 2
ll_NewItem = this.tv_tree.InsertItemLast(la_level, ltvi_Item)
tv_tree.Trigger Event ue_data_property (ltvi_Item ,la_parent)

tv_tree.SetItem(ll_NewItem, ltvi_Item)
Return(ll_NewItem)
end function

public subroutine uf_adjust_control (windowobject awobj_control, long al_ratio);
end subroutine

on w_tree_main.create
this.tv_tree=create tv_tree
this.cb_print_setup=create cb_print_setup
this.cb_print=create cb_print
this.cb_annulla=create cb_annulla
this.cb_chiude=create cb_chiude
this.cb_salva=create cb_salva
this.Control[]={ this.tv_tree,&
this.cb_print_setup,&
this.cb_print,&
this.cb_annulla,&
this.cb_chiude,&
this.cb_salva}
end on

on w_tree_main.destroy
destroy(this.tv_tree)
destroy(this.cb_print_setup)
destroy(this.cb_print)
destroy(this.cb_annulla)
destroy(this.cb_chiude)
destroy(this.cb_salva)
end on

event open;this.width = 2000
this.height = 1300
il_width = this.width
il_height = this.height 

cb_salva.x = 50
cb_salva.y = 1180
cb_annulla.x =  750
cb_annulla.y = 1180
cb_chiude.x =  400
cb_chiude.y = 1180
cb_print.x = 1200
cb_print.y = 1180
cb_print_setup.x = 1550
cb_print_setup.y = 1180

PostEvent("ue_post_open")
end event

event resize;
long ll_size, ll_count, ll_ratio

ll_ratio = il_height - newheight
cb_salva.y = cb_salva.y - ll_ratio
cb_annulla.y = cb_annulla.y - ll_ratio
cb_chiude.y = cb_chiude.y  - ll_ratio
cb_print.y = cb_print.y - ll_ratio
cb_print_setup.y = cb_print_setup.y - ll_ratio
tv_tree.width = newwidth - 80
tv_tree.height = newheight - 200
il_width = newwidth
il_height = newheight
end event

event closequery;if ib_updated then
	
	CHOOSE CASE MessageBox(is_title, "Ci sono modifiche non salvate in Categorie Merceologiche.~n~r" + &
		"Vuoi salvarle?", Question!, YesNoCancel!)
		CASE 1
			
			COMMIT using SQLCA;
			RETURN 0
		CASE 2
			
			ROLLBACK using SQLCA;
			RETURN 0
		CASE 3
			
			RETURN 1
	END CHOOSE
else 
	RETURN 0
end if
end event

event key;

keycode			lk_code
string			ls_nome
windowobject	lw_me

lk_code = key

choose case lk_code
	case KeyF12!
		if keyflags=3 then
			ls_nome = this.ClassName()
			MessageBox ("ClassName",ls_nome)
		end if
	case KeyF1!
		if (keyflags = 0 Or keyflags = 1 Or keyflags = 2) then
			This.Event ue_help(Topic!, il_HelpTopic, "")
		end if
end choose
end event

type tv_tree from treeview within w_tree_main
event begindrag pbm_tvnbegindrag
event constructor pbm_constructor
event dragdrop pbm_tvndragdrop
event dragwithin pbm_tvndragwithin
event ue_load_item ( )
event ue_dd_update ( long ll_drag_item,  long ll_target_item )
event ue_init ( )
event ue_data_property ( ref treeviewitem atvi_item,  long al_id_value )
event ue_sql_verify ( )
event ue_array_insert ( long al_count,  s_item_array astr_item )
int X=46
int Y=41
int Width=1875
int Height=1101
int TabOrder=1
boolean DragAuto=true
BorderStyle BorderStyle=StyleLowered!
boolean DisableDragDrop=false
string PictureName[]={"Structure!",&
"Query!",&
"Cascade!"}
long PictureMaskColor=553648127
long StatePictureMaskColor=536870912
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event begindrag;treeviewitem     l_tvi

If handle <> il_root_item then
	il_dragitem = handle
	GetItem(handle, l_tvi)
else
	Drag(Cancel!)
end if
end event

event constructor;TriggerEvent("ue_init")
uf_open_tree()
end event

event dragdrop;treeViewItem ltvi_Dragged, ltvi_New, ltvi_OldParent, ltvi_NewParent
long ll_index, ll_oldParent, ll_NewParent, ll_NewId, ll_DragObjId, ll_null, ll_NewItem
integer li_null, li_buffer, li_order, li_idNuovaVoce
s_data_property lstr_data_newId, lstr_data_DragObjId
s_item_array lstr_item

SetNull(li_null)
if handle > 0  AND il_dragitem <> handle  AND not uf_is_ancestor(il_dragitem, handle) THEN
		This.GetItem(il_dragitem, ltvi_Dragged)
		This.GetItem(handle, ltvi_NewParent)
		lstr_data_newId = ltvi_NewParent.Data
		lstr_data_DragObjId = ltvi_Dragged.Data
		ll_newId = lstr_data_newId.l_id_value
		ll_DragObjId = lstr_data_DragObjId.l_id_value
		if handle <> il_root_item then
			Trigger event ue_dd_update(ll_DragObjId, ll_newId)
			FOR ll_index = 1 to ii_size
				lstr_item = istr_item_array[ll_index]
				IF istr_item_array[ll_index].l_id_item = ll_DragObjId THEN
					istr_item_array[ll_index].l_id_parent_item = ll_newId
				END IF
			NEXT
		else
			SetNull(ll_null)
			This.SetRedraw(TRUE)
			Trigger event ue_dd_update(ll_DragObjId, ll_null)
			FOR ll_index = 1 to ii_size
				lstr_item = istr_item_array[ll_index]
				IF istr_item_array[ll_index].l_id_item = ll_DragObjId THEN
					istr_item_array[ll_index].l_id_parent_item = ll_null
				END IF
			NEXT
		end if 
		DeleteItem(il_dragitem)
		SetNull(ltvi_Dragged.ItemHandle)
		uf_create_row(ltvi_Dragged.Label , ll_DragObjId,  handle)
		
		this.ExpandAll(handle)
end if




end event

event dragwithin;treeviewItem l_tvi
long ll_handleParent, ll_dragParent

SelectItem(handle)
end event

event ue_load_item;
end event

event ue_dd_update;
end event

event ue_init;
SetNull(il_starting_value)
end event

event ue_data_property;s_data_property lstr_data_property

lstr_data_property.l_id_value = al_id_value
atvi_item.Data = lstr_data_property




end event

event ue_sql_verify;IF sqlca.sqlcode < 0 THEN
	MessageBox ("DataBase Error!", sqlca.sqlerrtext, exclamation!)
	RETURN
END IF

end event

event ue_array_insert;if sqlca.sqlcode = 0 then
	istr_item_array[al_count] = astr_item
elseif sqlca.sqlcode < 0 then
	MessageBox ("DataBase Error", sqlca.sqlerrtext, exclamation!)
	return
end if

end event

type cb_print_setup from commandbutton within w_tree_main
int X=1555
int Y=1181
int Width=353
int Height=85
int TabOrder=10
string Text="Setup Stampa"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;PrintSetup( )
end event

type cb_print from commandbutton within w_tree_main
int X=1212
int Y=1181
int Width=307
int Height=85
int TabOrder=20
string Text="Stampa"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long Job

Job = PrintOpen( )

tv_tree.Print(Job, 100,100)

PrintClose(Job)
end event

type cb_annulla from commandbutton within w_tree_main
int X=801
int Y=1181
int Width=298
int Height=85
int TabOrder=30
string Text="Annulla"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if ib_updated then
	if MessageBox(is_title, "Confermi l'annullamento delle ultime modifiche.", Question!, YesNo!, 2) = 1 then
		ROLLBACK using SQLCA;
		if SQLCA.SQLCode <> 0 then
			MessageBox(is_title, "Problemi durante l'operazione di accesso al database.")
		else
			ib_updated = FALSE
		end if
		tv_tree.CollapseItem(il_root_item)
		tv_tree.DeleteItem(il_root_item)
		uf_open_tree()
	end if	
end if 

end event

type cb_chiude from commandbutton within w_tree_main
int X=389
int Y=1181
int Width=307
int Height=85
int TabOrder=40
string Text="Chiude"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Close(parent)
end event

type cb_salva from commandbutton within w_tree_main
int X=46
int Y=1181
int Width=307
int Height=85
int TabOrder=50
string Text="Salva"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if ib_updated then
	if MessageBox(is_title, "Confermi il salvataggio.", Question!, YesNo!, 1) = 1 then
		COMMIT using SQLCA;
		if SQLCA.SQLCode <> 0 then
			MessageBox(is_title, "Problemi durante l'operazione di accesso al database.")
			ROLLBACK using SQLCA;
		else
			ib_updated = FALSE
		end if
	end if	
end if 

	
end event

