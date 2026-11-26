forward
global type u_tv_menu from treeview
end type
end forward

global type u_tv_menu from treeview
int Width=947
int Height=1333
int TabOrder=1
string PictureName[]={"DataWindow5!",&
"Query!",&
"Menu5!",&
"DataWindow5!",&
"Custom039!",&
"Custom050!",&
"Custom093!",&
"S:\PB\CommonFrameWork\menu.bmp",&
"S:\PB\CommonFrameWork\genappl.bmp",&
"S:\PB\CommonFrameWork\cfolder.bmp",&
"S:\PB\CommonFrameWork\ofolder.bmp",&
"NotFound!"}
long PictureMaskColor=553648127
long StatePictureMaskColor=536870912
long BackColor=16777215
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
event type long ue_expand ( integer ai_levels )
event type integer ue_insert_voice ( long al_item_voice_father,  long al_id_voice,  string as_voice_name,  long al_id_object,  string as_parameters )
event type long ue_view_level ( long al_handle,  integer ai_level,  integer ai_lmax )
event type long ue_expand_level ( long al_handle_voice,  long al_levels )
event ue_start_window ( integer ai_id_oggetto,  ref window aw_window,  string as_parametri )
event ue_draw_level ( integer ai_level )
event type long ue_delete_down ( long al_handle )
event ue_delete_item ( )
end type
global u_tv_menu u_tv_menu

type variables
long		il_rootitem, il_id_menu = 0
string		is_menu_name

end variables

event ue_expand;
treeviewitem ltvi_root

il_rootitem= Event ue_insert_voice(0,0,is_menu_name,0,"")
This.GetItem(il_rootitem, ltvi_root)
ltvi_root.PictureIndex = 8
ltvi_root.SelectedPictureIndex = 8
This.SetItem(il_rootitem, ltvi_root)

This.SetRedraw ( false )
Event ue_view_level (il_rootitem,0,ai_levels)
This.SelectItem(il_rootitem)
This.SetRedraw ( true )

return 0
end event

event ue_insert_voice;

integer           li_NewItem
TreeViewItem      ltvi_Item
window 				lw_instance
s_voice				lstr_voice
lstr_voice.l_id_voice = al_id_voice
lstr_voice.l_id_object = al_id_object
lstr_voice.w_win_instance = lw_instance
lstr_voice.s_parameters = as_parameters
ltvi_Item.label = as_voice_name
ltvi_Item.PictureIndex = 1
If IsNull(al_id_object) Then
	if al_item_voice_father = 0 then
	
		ltvi_Item.PictureIndex = 8
		ltvi_Item.SelectedPictureIndex = 8
	else
		ltvi_Item.PictureIndex = 10
		ltvi_Item.SelectedPictureIndex = 11
	end if

else
	ltvi_Item.PictureIndex = 9
	ltvi_Item.SelectedPictureIndex = 9
end if
ltvi_Item.Data = lstr_voice
li_NewItem = this.InsertItemLast(al_item_voice_father, ltvi_Item)

RETURN li_NewItem 

end event

event ue_view_level;


long				ll_item
TreeViewItem	ltvi_item, ltvi_item_current
s_voice			lstr_voice
This.GetItem(al_handle, ltvi_item_current)
if ai_level<ai_lmax then
	
	ll_item = This.FindItem (ChildTreeItem!, al_handle)
	lstr_voice= ltvi_item_current.Data
	If (IsNull(lstr_voice.l_id_object) OR lstr_voice.l_id_object =0) AND &
(not ltvi_item_current.ExpandedOnce)  AND (ll_item <= 0)then
		Event ue_expand_level(al_handle, 1)
	end if
	
	This.ExpandItem(al_handle)
	
	ll_item = This.FindItem (ChildTreeItem!, al_handle)
	if ll_item <> -1 then
		
		do while  ll_item <> -1
			Event ue_view_level (ll_item,ai_level+1,ai_lmax)
			ll_item = This.FindItem (NextTreeItem!, ll_item)
		loop
	end if
else
	This.CollapseItem(al_handle)
	
	ll_item = This.FindItem (ChildTreeItem!, al_handle)
	if ll_item <> -1 then
		
		do while  ll_item <> -1
			Event ue_view_level (ll_item,ai_level+1,ai_lmax)
			ll_item = FindItem (NextTreeItem!, ll_item)
		loop
	end if
end if

return 0
end event

event ue_expand_level;
string	ls_nome_voce, ls_parametri_voce
integer  il_count, ll_levels
TreeViewItem 	ltvi_current
s_voice 			lstr_voice, lstr_array[]
long 				ll_id_voce, id_oggetto_voce, ll_id_menu, ll_new_handle, ll_array_count, ll_array_size

This.GetItem( al_handle_voice, ltvi_current)
If not IsNull(ltvi_current.Data) then lstr_voice= ltvi_current.Data
ll_id_voce= lstr_voice.l_id_voice
al_levels= al_levels - 1
If Not (IsNull(ll_id_voce) OR  ll_id_voce=0) then
	SetNull(ll_id_menu)
	
	DECLARE lcur_voci_no_primo CURSOR FOR
		SELECT ID_voci_menu, vmenu_voce, ID_oggetti, vmenu_parametri
		FROM Voci_Menu 
		WHERE ( "voci_menu"."id_menu" IS NULL) AND
				("voci_menu"."id_voci_menu_padre" = :ll_id_voce)    
		ORDER BY vmenu_order, vmenu_voce;
	
	
	IF sqlca.sqlcode < 0 THEN
		MessageBox ("DataBase Error!", sqlca.sqlerrtext, exclamation!)
		RETURN 0
	END IF
	OPEN lcur_voci_no_primo;
	
	il_count = 0
	do while sqlca.sqlcode = 0
		
		fetch lcur_voci_no_primo into :ll_id_voce, :ls_nome_voce, :id_oggetto_voce, :ls_parametri_voce;
		if sqlca.sqlcode < 0 then
			MessageBox ("DataBase Error", sqlca.sqlerrtext, exclamation!)
			return 0
		end if
		if sqlca.sqlcode = 0 then
			ll_array_count ++
			lstr_array[ll_array_count].l_id_voice = ll_id_voce
			lstr_array[ll_array_count].s_voice_name = ls_nome_voce
			lstr_array[ll_array_count].l_id_object = id_oggetto_voce
			lstr_array[ll_array_count].s_parameters = ls_parametri_voce
		end if
	loop
	close lcur_voci_no_primo;
	ll_array_size= UpperBound(lstr_array)
	FOR ll_array_count = 1 to ll_array_size
		
		
		ll_new_handle=Event ue_insert_voice(al_handle_voice,lstr_array[ll_array_count].l_id_voice, &
				lstr_array[ll_array_count].s_voice_name, lstr_array[ll_array_count].l_id_object, lstr_array[ll_array_count].s_parameters) 
		if al_levels > 0 then
			Event ue_expand_level(ll_new_handle, al_levels)
		end if
	NEXT

else
	
	ll_id_menu= il_id_menu
	SetNull(ll_id_voce)

	
	DECLARE lcur_voci_primo CURSOR FOR
		SELECT ID_voci_menu, vmenu_voce, ID_oggetti, vmenu_parametri
		FROM Voci_Menu 
		WHERE ( "voci_menu"."id_menu" = :ll_id_menu ) AND
				("voci_menu"."id_voci_menu_padre" IS NULL)    
		ORDER BY vmenu_order, vmenu_voce;
	
	
	IF sqlca.sqlcode < 0 THEN
		MessageBox ("DataBase Error!", sqlca.sqlerrtext, exclamation!)
		RETURN 0
	END IF
	OPEN lcur_voci_primo;
	
	il_count = 0
	do while sqlca.sqlcode = 0
	
		fetch lcur_voci_primo into :ll_id_voce, :ls_nome_voce, :id_oggetto_voce, :ls_parametri_voce;
		if sqlca.sqlcode < 0 then
			MessageBox ("DataBase Error", sqlca.sqlerrtext, exclamation!)
			return 0
		end if
		if sqlca.sqlcode = 0 then
			ll_array_count ++
			lstr_array[ll_array_count].l_id_voice = ll_id_voce
			lstr_array[ll_array_count].s_voice_name = ls_nome_voce
			lstr_array[ll_array_count].l_id_object = id_oggetto_voce
			lstr_array[ll_array_count].s_parameters = ls_parametri_voce
		end if
	loop
	close lcur_voci_primo;
	ll_array_size= UpperBound(lstr_array)
	FOR ll_array_count = 1 to ll_array_size
		
		
		ll_new_handle=Event ue_insert_voice(al_handle_voice,lstr_array[ll_array_count].l_id_voice, &
				lstr_array[ll_array_count].s_voice_name, lstr_array[ll_array_count].l_id_object, lstr_array[ll_array_count].s_parameters) 
		if al_levels > 0 then
			Event ue_expand_level(ll_new_handle, al_levels)
		end if
	NEXT

end if

return 0
end event

event ue_start_window;
string 		ls_oggetto
s_list_main ls_list_null

IF IsNull(ai_id_oggetto) then 
	MessageBox("Menu","La voce non è associata ad alcuna finestra.")
ELSE
	SELECT oggetti.ogg_oggetto
	INTO :ls_oggetto
	FROM oggetti
	WHERE oggetti.id_oggetti = :ai_id_oggetto
	USING SQLCA ;
	ls_list_null.s_win_parametri = as_parametri
	OpenSheetWithParm(aw_window, ls_list_null, ls_oggetto, w_app_frame, 0, Original!)
END IF
end event

event ue_draw_level;This.SetRedraw ( false )
This.Event ue_view_level (il_rootitem,0,ai_level)
This.SelectItem(il_rootitem)
This.SetRedraw ( true )
This.SetFocus()

end event

event ue_delete_down;TreeViewItem	l_tvi
long				ll_handle

ll_handle = GetItem(al_handle, l_tvi)
DO WHILE ll_handle > 0
	DeleteItem(ll_handle)
	ll_handle = FindItem(NextTreeItem!, ll_handle)
	if ll_handle <= 0 then
		ll_handle = FindItem(ChildTreeItem!, ll_handle)
	end if
	This.Event ue_delete_down(ll_handle)
LOOP
Return 0
end event

event ue_delete_item;

treeViewItem	l_tvi
long				ll_handle, ll_id_voci_menu, ll_figlio, ll_i
string			ls_text
s_list_main		lstr_for_win
s_voice			lstr_voce

ll_handle = This.FindItem(CurrentTreeItem!, 0)
if ll_handle = 1 then
	MessageBox("Avviso", "Per cancellare una intera voce del menu usare il~r" + &
				  				"programma che gestisce l'inserimento di una nuova voce.")
  Return
end if
This.GetItem(ll_handle, l_tvi)
lstr_voce = l_tvi.Data
ll_id_voci_menu = lstr_voce.l_id_voice
SELECT Max("voci_menu"."id_voci_menu") INTO :ll_figlio
  FROM "dba"."voci_menu"  
  WHERE ( "voci_menu"."id_voci_menu_padre" = :ll_id_voci_menu ) ;
if Not IsNull(ll_figlio) And ll_figlio <> 0 then
	lstr_for_win.l_identifica[1] = 0
	lstr_for_win.l_identifica[2] = ll_id_voci_menu
	OpenWithParm(w_voci_menu_ext_lt, lstr_for_win)
	lstr_for_win = Message.PowerObjectParm
	
	if lstr_for_win.l_identifica[1] < 0 then
		This.SetFocus()
		Return
	end if
end if

if MessageBox("Attenzione! Ultimo avviso:", + &
		"Si è sicuri di voler continuare con la cancellazione?", + &
		Question!, YesNo!) = 2 then Return
if Not IsNull(ll_figlio) And ll_figlio <> 0 then
	lstr_for_win.l_identifica[UpperBound(lstr_for_win.l_identifica) + 1] = ll_id_voci_menu
	
	FOR ll_i =1 TO UpperBound(lstr_for_win.l_identifica)
		DELETE FROM voci_menu WHERE id_voci_menu = :lstr_for_win.l_identifica[ll_i] ;
	NEXT
else
	DELETE FROM voci_menu WHERE id_voci_menu = :ll_id_voci_menu ;
end if
COMMIT using SQLCA;

end event

event doubleclicked;treeViewItem	l_tvi
boolean			lb_exp
s_voice 			lstr_voice

if GetItem(handle, l_tvi) = 1 then
	if (l_tvi.Level <> 1)  then
		lstr_voice= l_tvi.Data
		If not (IsNull(lstr_voice.l_id_object) OR lstr_voice.l_id_object = 0) then
			Event ue_start_window(lstr_voice.l_id_object, lstr_voice.w_win_instance,lstr_voice.s_parameters )
			l_tvi.Data = lstr_voice
			SetItem(handle, l_tvi)
		else
			if l_tvi.ExpandedOnce then
			
				if l_tvi.Expanded then
					
					collapseItem(handle)
				else
					
					ExpandItem(handle)
				end if
			else
			
				Event ue_expand_level(handle, 1)
				ExpandItem(handle)
			end if
		end if
	end if
end if

Return 1
end event

event key;treeViewItem	l_tvi
long				ll_tvi
boolean			lb_exp

ll_tvi = FindItem(CurrentTreeItem!,0)
if key = KeyEnter! then
	GetItem(ll_tvi, l_tvi)
	Event DoubleClicked(ll_tvi)
end if

return 1
end event

event selectionchanged;treeviewitem l_tvi 

This.GetItem(newhandle, l_tvi)

end event

