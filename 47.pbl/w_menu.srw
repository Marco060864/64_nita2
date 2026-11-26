//objectcomments w con tree view menu dopo login utente
forward
global type w_menu from window
end type
type st_16 from statictext within w_menu
end type
type sle_cerca from singlelineedit within w_menu
end type
type pb_12 from picturebutton within w_menu
end type
type pb_11 from picturebutton within w_menu
end type
type pb_10 from picturebutton within w_menu
end type
type pb_9 from picturebutton within w_menu
end type
type pb_8 from picturebutton within w_menu
end type
type pb_7 from picturebutton within w_menu
end type
type pb_6 from picturebutton within w_menu
end type
type pb_5 from picturebutton within w_menu
end type
type pb_4 from picturebutton within w_menu
end type
type pb_3 from picturebutton within w_menu
end type
type pb_2 from picturebutton within w_menu
end type
type pb_1 from picturebutton within w_menu
end type
type st_15 from statictext within w_menu
end type
type p_15 from picture within w_menu
end type
type p_14 from picture within w_menu
end type
type p_13 from picture within w_menu
end type
type st_12 from statictext within w_menu
end type
type p_12 from picture within w_menu
end type
type p_11 from picture within w_menu
end type
type st_11 from statictext within w_menu
end type
type st_4 from statictext within w_menu
end type
type p_4 from picture within w_menu
end type
type st_2 from statictext within w_menu
end type
type p_2 from picture within w_menu
end type
type st_10 from statictext within w_menu
end type
type p_10 from picture within w_menu
end type
type st_9 from statictext within w_menu
end type
type p_9 from picture within w_menu
end type
type st_5 from statictext within w_menu
end type
type p_5 from picture within w_menu
end type
type st_8 from statictext within w_menu
end type
type p_8 from picture within w_menu
end type
type st_6 from statictext within w_menu
end type
type p_6 from picture within w_menu
end type
type st_1 from statictext within w_menu
end type
type p_1 from picture within w_menu
end type
type st_7 from statictext within w_menu
end type
type p_7 from picture within w_menu
end type
type st_3 from statictext within w_menu
end type
type p_3 from picture within w_menu
end type
type gb_1 from groupbox within w_menu
end type
type st_13 from statictext within w_menu
end type
type st_14 from statictext within w_menu
end type
type tv_menu from treeview within w_menu
end type
end forward

global type w_menu from window
integer x = 832
integer y = 400
integer width = 1307
integer height = 2448
windowtype windowtype = child!
long backcolor = 67108864
event ue_setlevel ( )
event ue_comment ( )
st_16 st_16
sle_cerca sle_cerca
pb_12 pb_12
pb_11 pb_11
pb_10 pb_10
pb_9 pb_9
pb_8 pb_8
pb_7 pb_7
pb_6 pb_6
pb_5 pb_5
pb_4 pb_4
pb_3 pb_3
pb_2 pb_2
pb_1 pb_1
st_15 st_15
p_15 p_15
p_14 p_14
p_13 p_13
st_12 st_12
p_12 p_12
p_11 p_11
st_11 st_11
st_4 st_4
p_4 p_4
st_2 st_2
p_2 p_2
st_10 st_10
p_10 p_10
st_9 st_9
p_9 p_9
st_5 st_5
p_5 p_5
st_8 st_8
p_8 p_8
st_6 st_6
p_6 p_6
st_1 st_1
p_1 p_1
st_7 st_7
p_7 p_7
st_3 st_3
p_3 p_3
gb_1 gb_1
st_13 st_13
st_14 st_14
tv_menu tv_menu
end type
global w_menu w_menu

type variables
s_voce		Item_Array[]
integer		ii_size
long		il_rootItem
s_window		s_oggetto
integer		ii_level		// livello corrente
long 		il_id_menu
string 		is_menu_name
boolean		 lb_avvisato=false
long il_voci, il_flag

//RIK PB9
string is_menu
long il_voci_settore
//Memorizza ultimo tasto premuto
integer il_pres
end variables

forward prototypes
public function long uf_insert_voice (long al_item_voice_father, long al_id_voice, string as_voice_name, long al_id_object, string as_parameters)
public function long uf_expand (integer ai_levels)
public function long uf_expand_level (long al_handle_voice, integer al_levels)
public function integer uf_view_level (long al_handle, integer ai_level, integer ai_lmax)
public subroutine uf_start_window (integer ai_idoggetto, ref window aw_window, string as_parametri, long al_id_voce)
public subroutine uf_gest_tasti ()
public function integer wf_cerca (string as_testo)
end prototypes

public function long uf_insert_voice (long al_item_voice_father, long al_id_voice, string as_voice_name, long al_id_object, string as_parameters);// Questa funzione "disegna" la voce di menu, popolando un oggetto Item ed inserendolo
// come "ultimo" nel menu
//
// Argomenti:    String          sa_name        Label da dare alla voce
//               Integer         la_level       Livello di assegnazione
//               Integer         ia_idvoice     
//               Integer         ia_object      ID della finestra associata(?)
//               String          sa_parametri   Stringa di parametri di chiamata
//
//	La radice, ad esempio, viene creata con:
//               ll_NewVoce = uf_design_voice(sa_name, 0, 0, 0, "")

integer           li_NewItem
TreeViewItem      ltvi_Item
window 				lw_instance
s_voice				lstr_voice
//Carico la struttura che sarà contenuta in data e che conterrà tutto quanto serve a gestire il tree
lstr_voice.l_id_voice = al_id_voice
lstr_voice.l_id_object = al_id_object
lstr_voice.w_win_instance = lw_instance
lstr_voice.s_parameters = as_parameters
//Istanzio le proprietà dell'handle che sarà creato
ltvi_Item.label = as_voice_name
ltvi_Item.PictureIndex = 1
If IsNull(al_id_object) Then
//Può contenere sottovoci
	if al_item_voice_father = 0 then
	//Creo la radice
		ltvi_Item.PictureIndex = 8
		ltvi_Item.SelectedPictureIndex = 8
	else
		ltvi_Item.PictureIndex = 10
		ltvi_Item.SelectedPictureIndex = 11
	end if

else
//Non può contenere sottovoci
	ltvi_Item.PictureIndex = 9
	ltvi_Item.SelectedPictureIndex = 9
end if
ltvi_Item.Data = lstr_voice
//Inserisco l'handle
li_NewItem = this.tv_menu.InsertItemLast(al_item_voice_father, ltvi_Item)

RETURN li_NewItem 

end function

public function long uf_expand (integer ai_levels);//Crea la radice ed espande l'albero di un numero ai_levels di livelli
treeviewitem ltvi_root

il_rootitem= uf_insert_voice(0,0,is_menu_name,0,"")
tv_menu.GetItem(il_rootitem, ltvi_root)
ltvi_root.PictureIndex = 8
ltvi_root.SelectedPictureIndex = 8
tv_menu.SetItem(il_rootitem, ltvi_root)

tv_menu.SetRedraw ( false )
uf_view_level (il_rootitem,0,ai_levels)
tv_menu.SelectItem(il_rootitem)
tv_menu.SetRedraw ( true )

return 0
end function

public function long uf_expand_level (long al_handle_voice, integer al_levels);//Espande l'albero di un numero al_levels di livelli e crea gli item

string	ls_nome_voce, ls_parametri_voce
integer  il_count, ll_levels
TreeViewItem 	ltvi_current
s_voice 			lstr_voice, lstr_array[]
long 				ll_id_voce, id_oggetto_voce, ll_id_menu, ll_new_handle, ll_array_count, ll_array_size

tv_menu.GetItem( al_handle_voice, ltvi_current)
If not IsNull(ltvi_current.Data) then lstr_voice= ltvi_current.Data
ll_id_voce= lstr_voice.l_id_voice
al_levels= al_levels - 1
If Not (IsNull(ll_id_voce) OR  ll_id_voce=0) then
//Non è un primo livello
	SetNull(ll_id_menu)
	// Dichiarazione del cursore sui dati da prelevare
	DECLARE lcur_voci_no_primo CURSOR FOR
		SELECT ID_voci_menu, vmenu_voce, ID_oggetti, vmenu_parametri
		FROM Voci_Menu 
		WHERE ( "voci_menu"."id_menu" IS NULL) AND
				("voci_menu"."id_voci_menu_padre" = :ll_id_voce)    
		ORDER BY vmenu_order, vmenu_voce;

	OPEN lcur_voci_no_primo;
	
	// Condizione di errore
	IF sqlca.sqlcode < 0 THEN
		MessageBox ("DataBase Error!", sqlca.sqlerrtext, exclamation!)
		RETURN 0
	END IF
	
	// Se invece va bene si popola l'array di istanza item_array[]
	il_count = 0
	do while sqlca.sqlcode = 0
		//Con la fetch mi scarico il cursore su un array
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
		//Con l'array inserisco le voci e ciclo( se al_levels > 1, ma per il momento non uso questa
		//	potenzialità
		ll_new_handle=uf_insert_voice(al_handle_voice,lstr_array[ll_array_count].l_id_voice, &
				lstr_array[ll_array_count].s_voice_name, lstr_array[ll_array_count].l_id_object, lstr_array[ll_array_count].s_parameters) 
		if al_levels > 0 then
			uf_expand_level(ll_new_handle, al_levels)
		end if
	NEXT

else
	//E' la radice
	ll_id_menu= il_id_menu
	SetNull(ll_id_voce)

	// Dichiarazione del cursore sui dati da prelevare
	DECLARE lcur_voci_primo CURSOR FOR
		SELECT ID_voci_menu, vmenu_voce, ID_oggetti, vmenu_parametri
		FROM Voci_Menu 
		WHERE 
//		( "voci_menu"."id_menu" = :ll_id_menu ) 
//		AND 	("voci_menu"."id_voci_menu_padre" IS NULL)    
 		("voci_menu"."id_voci_menu_padre" = :il_voci_settore )    				
		ORDER BY vmenu_order, vmenu_voce;
	
	// Condizione di errore
	IF sqlca.sqlcode < 0 THEN
		MessageBox ("DataBase Error!", sqlca.sqlerrtext, exclamation!)
		RETURN 0
	END IF
	OPEN lcur_voci_primo;
	// Se invece va bene si popola l'array di istanza item_array[]
	il_count = 0
	do while sqlca.sqlcode = 0
	//Con la fetch mi scarico il cursore su un array
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
		//Con l'array inserisco le voci e ciclo( se al_levels > 1, ma per il momento non uso questa
		//	potenzialità
		ll_new_handle=uf_insert_voice(al_handle_voice,lstr_array[ll_array_count].l_id_voice, &
				lstr_array[ll_array_count].s_voice_name, lstr_array[ll_array_count].l_id_object, lstr_array[ll_array_count].s_parameters) 
		if al_levels > 0 then
			uf_expand_level(ll_new_handle, al_levels)
		end if
	NEXT

end if

return 0
end function

public function integer uf_view_level (long al_handle, integer ai_level, integer ai_lmax);// Questa funzione espande l'albero di menu ad un particolare livello compreso tra
// un minimo ed un massimo. Il livello fino a cui espandere viene portato giu per
// la ricorsione dal parametro ai_lmax
//
// la prima volta viene chiamato con il_rootitem, poi la ricorsione fa il suo effetto...
//
//
// tv_menu.FindItem mi permette di navigare nel treeview del menu.
//
//		NextTreeItem!  Prende il successivo nodo dello stesso livello nel sottoalbero
//		ChildTreeItem! Prende il primo nodo "figlio".
//
//	Con questi due valori si può navigare ricorsivamente l'albero
//

// nel punto in cui mi trovo devo ogni volta:
//
//		a: vedere se il livello mio è maggiore, uguale o minore del livello che voglio
//    b: se devo ESPANDERE devo anche guardare i figli, tutti i figli
//		c: se devo CHIUDERE non devo fare altro

//
long				ll_item
TreeViewItem	ltvi_item, ltvi_item_current
s_voice			lstr_voice
//AND (not al_handle = il_rootitem)
tv_menu.GetItem(al_handle, ltvi_item_current)
// se il livello dell'item corrente è <max
if ai_level<ai_lmax then
	// espandi questo
	ll_item = tv_menu.FindItem (ChildTreeItem!, al_handle)
	lstr_voice= ltvi_item_current.Data
	If (IsNull(lstr_voice.l_id_object) OR lstr_voice.l_id_object =0) AND &
(not ltvi_item_current.ExpandedOnce)  AND (ll_item <= 0)then
		uf_expand_level(al_handle, 1)
	end if
	
	tv_menu.ExpandItem(al_handle)
	// trova i figli. Il primo...
	ll_item = tv_menu.FindItem (ChildTreeItem!, al_handle)
	if ll_item <> -1 then
		// nel caso ci sia un figlio
		do while  ll_item <> -1
			uf_view_level (ll_item,ai_level+1,ai_lmax)
			ll_item = tv_menu.FindItem (NextTreeItem!, ll_item)
		loop
	end if
else
	tv_menu.CollapseItem(al_handle)
	// trova i figli. Il primo...
	ll_item = tv_menu.FindItem (ChildTreeItem!, al_handle)
	if ll_item <> -1 then
		// nel caso ci sia un figlio
		do while  ll_item <> -1
			uf_view_level (ll_item,ai_level+1,ai_lmax)
			ll_item = tv_menu.FindItem (NextTreeItem!, ll_item)
		loop
	end if
end if

return 0
end function

public subroutine uf_start_window (integer ai_idoggetto, ref window aw_window, string as_parametri, long al_id_voce);//   Scopo: Permette il lancio di una window da un item
string 		is_oggetto, ls_pwd, ls_controllo_pwd
s_list_main ls_list_null

if al_id_voce <> 0 AND Not IsNull(al_id_voce) then
	SELECT voci_menu.vmenu_pwd
	INTO :ls_pwd
	FROM voci_menu
	WHERE voci_menu.id_voci_menu = :al_id_voce
	USING SQLCA ;
	if ls_pwd <> "" AND Not IsNull(ls_pwd) then
		// apro la finestra di richiesta pwd
		Open(w_pwd_voci_menu_ff)
		ls_controllo_pwd = Message.StringParm
		if trim(ls_controllo_pwd)  <> trim(ls_pwd) then
			MessageBox("Attenzione", "Password errata. Impossibile procedere.", Exclamation!)
			Return
		end if
	end if
else
	// errore generale - chiamata senza id_voci_menu non dovrebbe esistere!
	Return
end if
IF IsNull(ai_idoggetto) then 
	MessageBox("Menu","La voce non è associata ad alcuna finestra.")
ELSE
// Se l'id dell'oggetto esiste
	SELECT oggetti.ogg_oggetto
	INTO :is_oggetto
	FROM oggetti
	WHERE oggetti.id_oggetti = :ai_idoggetto
	USING SQLCA ;
	ls_list_null.s_win_parametri = as_parametri
	OpenSheetWithParm(aw_window, ls_list_null, is_oggetto, w_app_frame, 0, Original!)
END IF
end subroutine

public subroutine uf_gest_tasti ();p_1.BorderStyle  = StyleRaised!
p_2.BorderStyle  = StyleRaised!
p_3.BorderStyle  = StyleRaised!
p_4.BorderStyle  = StyleRaised!
p_5.BorderStyle  = StyleRaised!
p_6.BorderStyle  = StyleRaised!
p_7.BorderStyle  = StyleRaised!
p_8.BorderStyle  = StyleRaised!
p_9.BorderStyle  = StyleRaised!
p_10.BorderStyle = StyleRaised!
p_11.BorderStyle = StyleRaised!
p_12.BorderStyle = StyleRaised!
p_13.BorderStyle = StyleRaised!
p_14.BorderStyle = StyleRaised!
p_15.BorderStyle = StyleRaised!

st_1.weight=400
st_2.weight=400
st_3.weight=400
st_4.weight=400
st_5.weight=400
st_6.weight=400
st_7.weight=400
st_8.weight=400
st_9.weight=400
st_10.weight=400
st_11.weight=400
st_12.weight=400
st_13.weight=400
st_14.weight=400
st_15.weight=400


end subroutine

public function integer wf_cerca (string as_testo);string       ls_testo, ls_nome, ls_param, ls_menu_name, ls_sql
long         ll_id_voce, ll_id_oggetto, ll_count, ll_array_size, jj
long         ll_rootitem
integer      ll_id_menu, ll_rows, ll_r
s_voice      lstr_array[]
treeviewitem l_tvi
datastore    lds

// copia variabili di istanza in locali
ll_id_menu  = integer(il_id_menu)
ll_rootitem = il_rootitem

// svuota il tree corrente
tv_menu.DeleteItem(ll_rootitem)

// crea la radice "Ricerca: xxx" e aggiorna variabili di istanza
ls_menu_name = "Ricerca: " + as_testo
il_rootitem  = uf_insert_voice(0, 0, ls_menu_name, 0, "")
is_menu_name = ls_menu_name

// corregge icona della radice (altrimenti prende icona da foglia)
tv_menu.GetItem(il_rootitem, l_tvi)
l_tvi.PictureIndex         = 8
l_tvi.SelectedPictureIndex = 8
tv_menu.SetItem(il_rootitem, l_tvi)

// costruisce la query con LIKE %testo%
ls_testo = as_testo 

// esegue la query tramite datastore dinamico
lds = create datastore
lds.dataobject = "d_cerca_menu2"
lds.SetTransObject(sqlca)

ll_rows = lds.Retrieve(ls_testo)

// se non trova niente avvisa e termina
if ll_rows <= 0 then
    MessageBox("Ricerca", "Nessuna voce trovata per: " + as_testo, Information!)
    destroy lds
    return 0
end if

// popola il treeview con le voci trovate
tv_menu.SetRedraw(false)
for ll_r = 1 to ll_rows
    ll_id_voce    = lds.GetItemNumber(ll_r, "id_voci_menu")
    ls_nome       = lds.GetItemString(ll_r, "vmenu_voce")
    ll_id_oggetto = lds.GetItemNumber(ll_r, "id_oggetti")
    ls_param      = lds.GetItemString(ll_r, "vmenu_parametri")
    uf_insert_voice(il_rootitem, ll_id_voce, ls_nome, ll_id_oggetto, ls_param)
next
tv_menu.ExpandItem(il_rootitem)
tv_menu.SetRedraw(true)

// libera memoria datastore
destroy lds
return 1

end function

event close;// Test Override Close Window
if isvalid(u_freddie.iudw_current) then
	if u_freddie.iudw_current.ib_query_mode then
		m_app_frame.uf_enable_modifica(true)
	end if	
end if
end event

event open;il_voci=0

long			ll_menuid
string		sl_menuname, ls_cod_az
window		lw_pw

il_id_menu = Message.DoubleParm
This.Title = u_freddie.s_utenti.s_utente

SELECT menu.menu_descrizione
	INTO :is_menu
	FROM menu
	WHERE menu.ID_menu = :il_id_menu
	USING SQLCA ;

IF SQLCA.SQLCode = 100 OR SQLCA.SQLCode < 0 then
	//Vi sono stati problemi con la select	
	MessageBox("Database Error", SQLCA.SQLErrText, Exclamation!)
else
	//Non vi sono stati problemi con la select e posso aprire il menu
	is_menu_name=is_menu
	This.uf_expand(1)
END IF


//	Resize della finestra in funzione dell'altezza del frame
lw_pw = parentwindow()
this.x = lw_pw.workspacex()
this.y = lw_pw.workspacey() - 180	//185// toolbar & menu
this.height = lw_pw.workspaceheight() - 210		// toolbar & menu & microhelp

tv_menu.SetFocus()

Select codice into :ls_cod_az from azienda;
st_12.text=ls_cod_az
gb_1.text=is_menu

//Visibilità Tasti
String ls_vis, ls_def
Long ll_ut
ll_ut=u_freddie.ii_id_utenti

Select def_menu into :ls_def from utenti where id_utenti=:ll_ut;

select header_vis into :ls_vis from voci_menu
where id_menu=:il_id_menu and header_menu='A';
if ls_vis='N' then 
	p_1.visible=FALSE
else
	if ls_def='A' then p_1.triggerevent("clicked")
end if	
select header_vis into :ls_vis from voci_menu
where id_menu=:il_id_menu and header_menu='I';
if ls_vis='N' then 
	p_2.visible=FALSE
else
	if ls_def='I' then p_2.triggerevent("clicked")
end if		
select header_vis into :ls_vis from voci_menu
where id_menu=:il_id_menu and header_menu='C';
if ls_vis='N' then 
	p_3.visible=FALSE
else
	if ls_def='C' then p_3.triggerevent("clicked")
end if		
select header_vis into :ls_vis from voci_menu
where id_menu=:il_id_menu and header_menu='S';
if ls_vis='N' then 
	p_4.visible=FALSE
else
	if ls_def='S' then p_4.triggerevent("clicked")
end if		
select header_vis into :ls_vis from voci_menu
where id_menu=:il_id_menu and header_menu='F';
if ls_vis='N' then 
	p_5.visible=FALSE
else
	if ls_def='F' then p_5.triggerevent("clicked")
end if		
select header_vis into :ls_vis from voci_menu
where id_menu=:il_id_menu and header_menu='Z';
if ls_vis='N' then 
	p_6.visible=FALSE
else
	if ls_def='Z' then p_6.triggerevent("clicked")
end if		
select header_vis into :ls_vis from voci_menu
where id_menu=:il_id_menu and header_menu='M';
if ls_vis='N' then 
	p_7.visible=FALSE
else
	if ls_def='M' then p_7.triggerevent("clicked")
end if		
select header_vis into :ls_vis from voci_menu
where id_menu=:il_id_menu and header_menu='R';
if ls_vis='N' then 
	p_8.visible=FALSE
else
	if ls_def='R' then p_8.triggerevent("clicked")
end if		
select header_vis into :ls_vis from voci_menu
where id_menu=:il_id_menu and header_menu='G';
if ls_vis='N' then 
	p_9.visible=FALSE
else
	if ls_def='G' then p_9.triggerevent("clicked")
end if		
select header_vis into :ls_vis from voci_menu
where id_menu=:il_id_menu and header_menu='E';
if ls_vis='N' then 
	p_10.visible=FALSE
else
	if ls_def='E' then p_10.triggerevent("clicked")
end if		
select header_vis into :ls_vis from voci_menu
where id_menu=:il_id_menu and header_menu='T';
if ls_vis='N' then 
	p_11.visible=FALSE
else
	if ls_def='T' then p_11.triggerevent("clicked")
end if		
select header_vis into :ls_vis from voci_menu
where id_menu=:il_id_menu and header_menu='P';
if ls_vis='N' then 
	p_12.visible=FALSE
else
	if ls_def='P' then p_12.triggerevent("clicked")
end if		
end event

event resize;if newwidth >= 1100 then
	tv_menu.Width = newwidth - 70
//	tv_menu.Height = newheight - 380 //150
	tv_menu.Height = newheight - 1200 //150
else
	width = 1100
	tv_menu.Width = 1100 - 95
//	tv_menu.Height = newheight - 380
	tv_menu.Height = newheight - 1200
end if
end event

on w_menu.create
this.st_16=create st_16
this.sle_cerca=create sle_cerca
this.pb_12=create pb_12
this.pb_11=create pb_11
this.pb_10=create pb_10
this.pb_9=create pb_9
this.pb_8=create pb_8
this.pb_7=create pb_7
this.pb_6=create pb_6
this.pb_5=create pb_5
this.pb_4=create pb_4
this.pb_3=create pb_3
this.pb_2=create pb_2
this.pb_1=create pb_1
this.st_15=create st_15
this.p_15=create p_15
this.p_14=create p_14
this.p_13=create p_13
this.st_12=create st_12
this.p_12=create p_12
this.p_11=create p_11
this.st_11=create st_11
this.st_4=create st_4
this.p_4=create p_4
this.st_2=create st_2
this.p_2=create p_2
this.st_10=create st_10
this.p_10=create p_10
this.st_9=create st_9
this.p_9=create p_9
this.st_5=create st_5
this.p_5=create p_5
this.st_8=create st_8
this.p_8=create p_8
this.st_6=create st_6
this.p_6=create p_6
this.st_1=create st_1
this.p_1=create p_1
this.st_7=create st_7
this.p_7=create p_7
this.st_3=create st_3
this.p_3=create p_3
this.gb_1=create gb_1
this.st_13=create st_13
this.st_14=create st_14
this.tv_menu=create tv_menu
this.Control[]={this.st_16,&
this.sle_cerca,&
this.pb_12,&
this.pb_11,&
this.pb_10,&
this.pb_9,&
this.pb_8,&
this.pb_7,&
this.pb_6,&
this.pb_5,&
this.pb_4,&
this.pb_3,&
this.pb_2,&
this.pb_1,&
this.st_15,&
this.p_15,&
this.p_14,&
this.p_13,&
this.st_12,&
this.p_12,&
this.p_11,&
this.st_11,&
this.st_4,&
this.p_4,&
this.st_2,&
this.p_2,&
this.st_10,&
this.p_10,&
this.st_9,&
this.p_9,&
this.st_5,&
this.p_5,&
this.st_8,&
this.p_8,&
this.st_6,&
this.p_6,&
this.st_1,&
this.p_1,&
this.st_7,&
this.p_7,&
this.st_3,&
this.p_3,&
this.gb_1,&
this.st_13,&
this.st_14,&
this.tv_menu}
end on

on w_menu.destroy
destroy(this.st_16)
destroy(this.sle_cerca)
destroy(this.pb_12)
destroy(this.pb_11)
destroy(this.pb_10)
destroy(this.pb_9)
destroy(this.pb_8)
destroy(this.pb_7)
destroy(this.pb_6)
destroy(this.pb_5)
destroy(this.pb_4)
destroy(this.pb_3)
destroy(this.pb_2)
destroy(this.pb_1)
destroy(this.st_15)
destroy(this.p_15)
destroy(this.p_14)
destroy(this.p_13)
destroy(this.st_12)
destroy(this.p_12)
destroy(this.p_11)
destroy(this.st_11)
destroy(this.st_4)
destroy(this.p_4)
destroy(this.st_2)
destroy(this.p_2)
destroy(this.st_10)
destroy(this.p_10)
destroy(this.st_9)
destroy(this.p_9)
destroy(this.st_5)
destroy(this.p_5)
destroy(this.st_8)
destroy(this.p_8)
destroy(this.st_6)
destroy(this.p_6)
destroy(this.st_1)
destroy(this.p_1)
destroy(this.st_7)
destroy(this.p_7)
destroy(this.st_3)
destroy(this.p_3)
destroy(this.gb_1)
destroy(this.st_13)
destroy(this.st_14)
destroy(this.tv_menu)
end on

event key;If key=KeyF1! then
	Choose Case il_pres
		Case 1
			p_15.triggerevent("clicked")		
		Case 2
			p_1.triggerevent("clicked")		
		Case 3
			p_2.triggerevent("clicked")		
		Case 4
			p_3.triggerevent("clicked")		
		Case 5
			p_4.triggerevent("clicked")		
		Case 6
			p_5.triggerevent("clicked")		
		Case 7
			p_6.triggerevent("clicked")		
		Case 8
			p_7.triggerevent("clicked")		
		Case 9
			p_8.triggerevent("clicked")		
		Case 10
			p_9.triggerevent("clicked")		
		Case 11
			p_10.triggerevent("clicked")		
		Case 12
			p_11.triggerevent("clicked")	
		Case 13
			p_12.triggerevent("clicked")	
		Case 14
			p_13.triggerevent("clicked")	
		Case 15
			p_14.triggerevent("clicked")	
		
			
			
			
	End Choose		
End if	

If key=KeyF2! then
	Choose Case il_pres
		Case 1
			p_2.triggerevent("clicked")		
		Case 2
			p_3.triggerevent("clicked")		
		Case 3
			p_4.triggerevent("clicked")		
		Case 4
			p_5.triggerevent("clicked")		
		Case 5
			p_6.triggerevent("clicked")		
		Case 6
			p_7.triggerevent("clicked")		
		Case 7
			p_8.triggerevent("clicked")		
		Case 8
			p_9.triggerevent("clicked")		
		Case 9
			p_10.triggerevent("clicked")		
		Case 10
			p_11.triggerevent("clicked")		
		Case 11
			p_12.triggerevent("clicked")	
		Case 12
			p_13.triggerevent("clicked")
		Case 13
			p_14.triggerevent("clicked")
		Case 14
			p_15.triggerevent("clicked")
		Case 15
			p_1.triggerevent("clicked")					
	End Choose		
End if	

		
end event

type st_16 from statictext within w_menu
integer x = 59
integer y = 1088
integer width = 174
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Filtra:"
boolean focusrectangle = false
end type

type sle_cerca from singlelineedit within w_menu
integer x = 224
integer y = 1076
integer width = 782
integer height = 92
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 16777215
borderstyle borderstyle = styleraised!
end type

event modified;string ls_filtro
// 20260611 Lorenzo. Ho creato una funzione(wf_cerca) che in base a quello che scriviamo nella tabella di ricerca trova ciò che cerchiamo
if trim(sle_cerca.text) = "" then
    tv_menu.DeleteItem(il_rootitem)
    parent.uf_expand(1)
    return
end if

if len(trim(sle_cerca.text)) < 3 then return
ls_filtro=sle_cerca.text
ls_filtro='%'+ ls_filtro + '%'

wf_cerca(trim(ls_filtro))
end event

type pb_12 from picturebutton within w_menu
integer x = 951
integer y = 568
integer width = 183
integer height = 160
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string picturename = "C:\nita\icone\Personale.png"
alignment htextalign = left!
end type

event clicked;//Cancello voci precedenti
long ll_handle, ll_roothandle, ll_last, ii
treeviewitem l_tvi
ll_handle = tv_menu.FindItem(CurrentTreeItem!, 0)
ll_roothandle = tv_menu.FindItem(RootTreeItem!, 0)

tv_menu.GetItem(ll_handle , l_tvi)
ll_last=tv_menu.InsertItemLast(ll_roothandle, l_tvi)

for ii= ll_last to 1 step -1
	tv_menu.DeleteItem ( ii )
next	


//Espando nuovo livello
is_menu_name='Personalizzazioni'
select id_voci_menu into :il_voci_settore
from voci_menu where header_menu='P' and id_menu=:il_id_menu;
parent.uf_expand(1)

uf_gest_tasti()
st_12.weight=700
//this.BorderStyle = StyleLowered!
il_pres=12
end event

type pb_11 from picturebutton within w_menu
integer x = 951
integer y = 800
integer width = 183
integer height = 160
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string picturename = "C:\nita\icone\listino.png"
alignment htextalign = left!
end type

event clicked;//Cancello voci precedenti
long ll_handle, ll_roothandle, ll_last, ii
treeviewitem l_tvi
ll_handle = tv_menu.FindItem(CurrentTreeItem!, 0)
ll_roothandle = tv_menu.FindItem(RootTreeItem!, 0)

tv_menu.GetItem(ll_handle , l_tvi)
ll_last=tv_menu.InsertItemLast(ll_roothandle, l_tvi)

for ii= ll_last to 1 step -1
	tv_menu.DeleteItem ( ii )
next	


//Espando nuovo livello
is_menu_name='Listini e Distinta Base'
select id_voci_menu into :il_voci_settore
from voci_menu where header_menu='L' and id_menu=:il_id_menu;
parent.uf_expand(1)

uf_gest_tasti()
st_14.weight=700
//this.BorderStyle = StyleLowered!
il_pres=11
end event

type pb_10 from picturebutton within w_menu
integer x = 544
integer y = 800
integer width = 183
integer height = 160
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string picturename = "C:\nita\icone\Stampa.png"
alignment htextalign = left!
end type

event clicked;//Cancello voci precedenti
long ll_handle, ll_roothandle, ll_last, ii
treeviewitem l_tvi
ll_handle = tv_menu.FindItem(CurrentTreeItem!, 0)
ll_roothandle = tv_menu.FindItem(RootTreeItem!, 0)

tv_menu.GetItem(ll_handle , l_tvi)
ll_last=tv_menu.InsertItemLast(ll_roothandle, l_tvi)

for ii= ll_last to 1 step -1
	tv_menu.DeleteItem ( ii )
next	


//Espando nuovo livello
is_menu_name='Stampe'
select id_voci_menu into :il_voci_settore
from voci_menu where header_menu='T' and id_menu=:il_id_menu;

parent.uf_expand(1)

uf_gest_tasti()
st_11.weight=700
//this.BorderStyle = StyleLowered!
il_pres=10
end event

type pb_9 from picturebutton within w_menu
integer x = 155
integer y = 800
integer width = 183
integer height = 160
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string picturename = "C:\nita\icone\ordini.png"
alignment htextalign = left!
end type

event clicked;//Cancello voci precedenti
long ll_handle, ll_roothandle, ll_last, ii
treeviewitem l_tvi
ll_handle = tv_menu.FindItem(CurrentTreeItem!, 0)
ll_roothandle = tv_menu.FindItem(RootTreeItem!, 0)

tv_menu.GetItem(ll_handle , l_tvi)
ll_last=tv_menu.InsertItemLast(ll_roothandle, l_tvi)

for ii= ll_last to 1 step -1
	tv_menu.DeleteItem ( ii )
next	


//Espando nuovo livello
is_menu_name='Ordini e Grafica'
select id_voci_menu into :il_voci_settore
from voci_menu where header_menu='O' and id_menu=:il_id_menu;
parent.uf_expand(1)

uf_gest_tasti()
st_13.weight=700
//this.BorderStyle = StyleLowered!
il_pres=13
end event

type pb_8 from picturebutton within w_menu
integer x = 544
integer y = 568
integer width = 183
integer height = 160
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string picturename = "C:\nita\icone\articoli.png"
alignment htextalign = left!
end type

event clicked;//Cancello voci precedenti
long ll_handle, ll_roothandle, ll_last, ii
treeviewitem l_tvi
ll_handle = tv_menu.FindItem(CurrentTreeItem!, 0)
ll_roothandle = tv_menu.FindItem(RootTreeItem!, 0)

tv_menu.GetItem(ll_handle , l_tvi)
ll_last=tv_menu.InsertItemLast(ll_roothandle, l_tvi)

for ii= ll_last to 1 step -1
	tv_menu.DeleteItem ( ii )
next	


//Espando nuovo livello
is_menu_name='Articoli'
select id_voci_menu into :il_voci_settore
from voci_menu where header_menu='R' and id_menu=:il_id_menu;
parent.uf_expand(1)

uf_gest_tasti()
st_8.weight=700
//this.BorderStyle = StyleLowered!
il_pres=8
end event

type pb_7 from picturebutton within w_menu
integer x = 155
integer y = 568
integer width = 183
integer height = 160
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string picturename = "C:\nita\icone\Magazzino.png"
alignment htextalign = left!
end type

event clicked;//Cancello voci precedenti
long ll_handle, ll_roothandle, ll_last, ii
treeviewitem l_tvi
ll_handle = tv_menu.FindItem(CurrentTreeItem!, 0)
ll_roothandle = tv_menu.FindItem(RootTreeItem!, 0)

tv_menu.GetItem(ll_handle , l_tvi)
ll_last=tv_menu.InsertItemLast(ll_roothandle, l_tvi)

for ii= ll_last to 1 step -1
	tv_menu.DeleteItem ( ii )
next	


//Espando nuovo livello
is_menu_name='Magazzino'
select id_voci_menu into :il_voci_settore
from voci_menu where header_menu='M' and id_menu=:il_id_menu;
parent.uf_expand(1)


uf_gest_tasti()
st_7.weight=700
//this.BorderStyle = StyleLowered!
il_pres=7
end event

type pb_6 from picturebutton within w_menu
integer x = 951
integer y = 332
integer width = 183
integer height = 160
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string picturename = "C:\nita\icone\cespiti.png"
alignment htextalign = left!
end type

event clicked;//Cancello voci precedenti
long ll_handle, ll_roothandle, ll_last, ii
treeviewitem l_tvi
ll_handle = tv_menu.FindItem(CurrentTreeItem!, 0)
ll_roothandle = tv_menu.FindItem(RootTreeItem!, 0)

tv_menu.GetItem(ll_handle , l_tvi)
ll_last=tv_menu.InsertItemLast(ll_roothandle, l_tvi)

for ii= ll_last to 1 step -1
	tv_menu.DeleteItem ( ii )
next	


//Espando nuovo livello
is_menu_name='Ammortamenti'
select id_voci_menu into :il_voci_settore
from voci_menu where header_menu='Z' and id_menu=:il_id_menu;
parent.uf_expand(1)

uf_gest_tasti()
st_6.weight=700
//this.BorderStyle = StyleLowered!
il_pres=6
end event

type pb_5 from picturebutton within w_menu
integer x = 544
integer y = 332
integer width = 183
integer height = 160
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string picturename = "C:\nita\icone\finanza.png"
alignment htextalign = left!
end type

event clicked;//Cancello voci precedenti
long ll_handle, ll_roothandle, ll_last, ii
treeviewitem l_tvi
ll_handle = tv_menu.FindItem(CurrentTreeItem!, 0)
ll_roothandle = tv_menu.FindItem(RootTreeItem!, 0)

tv_menu.GetItem(ll_handle , l_tvi)
ll_last=tv_menu.InsertItemLast(ll_roothandle, l_tvi)

for ii= ll_last to 1 step -1
	tv_menu.DeleteItem ( ii )
next	


//Espando nuovo livello
is_menu_name='Finanza'
select id_voci_menu into :il_voci_settore
from voci_menu where header_menu='F' and id_menu=:il_id_menu;
parent.uf_expand(1)

uf_gest_tasti()
st_5.weight=700
//this.BorderStyle = StyleLowered!
il_pres=5
end event

type pb_4 from picturebutton within w_menu
integer x = 155
integer y = 332
integer width = 183
integer height = 160
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string picturename = "C:\nita\icone\anagrafiche.png"
alignment htextalign = left!
end type

event clicked;
//Cancello voci precedenti
long ll_handle, ll_roothandle, ll_last, ii
treeviewitem l_tvi
ll_handle = tv_menu.FindItem(CurrentTreeItem!, 0)
ll_roothandle = tv_menu.FindItem(RootTreeItem!, 0)

tv_menu.GetItem(ll_handle , l_tvi)
ll_last=tv_menu.InsertItemLast(ll_roothandle, l_tvi)

for ii= ll_last to 1 step -1
	tv_menu.DeleteItem ( ii )
next	


//Espando nuovo livello
is_menu_name='Anagrafica'
select id_voci_menu into :il_voci_settore
from voci_menu where header_menu='S' and id_menu=:il_id_menu;
parent.uf_expand(1)

uf_gest_tasti()
st_4.weight=700
//this.BorderStyle = StyleLowered!
il_pres=4
end event

type pb_3 from picturebutton within w_menu
integer x = 951
integer y = 92
integer width = 183
integer height = 160
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string picturename = "C:\nita\icone\Contabilita.png"
alignment htextalign = left!
end type

event clicked;//Cancello voci precedenti
long ll_handle, ll_roothandle, ll_last, ii
treeviewitem l_tvi
ll_handle = tv_menu.FindItem(CurrentTreeItem!, 0)
ll_roothandle = tv_menu.FindItem(RootTreeItem!, 0)

tv_menu.GetItem(ll_handle , l_tvi)
ll_last=tv_menu.InsertItemLast(ll_roothandle, l_tvi)

for ii= ll_last to 1 step -1
	tv_menu.DeleteItem ( ii )
next	


//Espando nuovo livello
is_menu_name='Contabilità'
select id_voci_menu into :il_voci_settore
from voci_menu where header_menu='C' and id_menu=:il_id_menu;
parent.uf_expand(1)


uf_gest_tasti()
st_3.weight=700
//this.BorderStyle = StyleLowered!
il_pres=3
end event

type pb_2 from picturebutton within w_menu
integer x = 544
integer y = 92
integer width = 183
integer height = 160
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string picturename = "C:\nita\icone\Impostazioni.png"
alignment htextalign = left!
end type

event clicked;
//Cancello voci precedenti
long ll_handle, ll_roothandle, ll_last, ii
treeviewitem l_tvi
ll_handle = tv_menu.FindItem(CurrentTreeItem!, 0)
ll_roothandle = tv_menu.FindItem(RootTreeItem!, 0)

tv_menu.GetItem(ll_handle , l_tvi)
ll_last=tv_menu.InsertItemLast(ll_roothandle, l_tvi)

for ii= ll_last to 1 step -1
	tv_menu.DeleteItem ( ii )
next	


//Espando nuovo livello
is_menu_name='Impostazioni'
select id_voci_menu into :il_voci_settore
from voci_menu where header_menu='I' and id_menu=:il_id_menu;
parent.uf_expand(1)

uf_gest_tasti()
st_2.weight=700
//this.BorderStyle  = StyleLowered!
il_pres=2
end event

type pb_1 from picturebutton within w_menu
integer x = 155
integer y = 92
integer width = 183
integer height = 160
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string picturename = "C:\nita\icone\Azienda.png"
alignment htextalign = left!
end type

event clicked;
//Cancello voci precedenti
long ll_handle, ll_roothandle, ll_last, ii
treeviewitem l_tvi
ll_handle = tv_menu.FindItem(CurrentTreeItem!, 0)
ll_roothandle = tv_menu.FindItem(RootTreeItem!, 0)

tv_menu.GetItem(ll_handle , l_tvi)
ll_last=tv_menu.InsertItemLast(ll_roothandle, l_tvi)

for ii= ll_last to 1 step -1
	tv_menu.DeleteItem ( ii )
next	


//Espando nuovo livello
is_menu_name='Dati Azienda'
select id_voci_menu into :il_voci_settore
from voci_menu where header_menu='A' and 
id_menu=:il_id_menu;
parent.uf_expand(1)

uf_gest_tasti()
st_1.weight=700
//this.BorderStyle = StyleLowered!
il_pres=1
end event

type st_15 from statictext within w_menu
boolean visible = false
integer x = 837
integer y = 1584
integer width = 338
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16711680
long backcolor = 67108864
boolean enabled = false
string text = "Varie"
alignment alignment = center!
boolean focusrectangle = false
end type

type p_15 from picture within w_menu
boolean visible = false
integer x = 923
integer y = 1424
integer width = 183
integer height = 160
boolean originalsize = true
string picturename = "S:\pb\Menu\intra.bmp"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;
//Cancello voci precedenti
long ll_handle, ll_roothandle, ll_last, ii
treeviewitem l_tvi
ll_handle = tv_menu.FindItem(CurrentTreeItem!, 0)
ll_roothandle = tv_menu.FindItem(RootTreeItem!, 0)

tv_menu.GetItem(ll_handle , l_tvi)
ll_last=tv_menu.InsertItemLast(ll_roothandle, l_tvi)

for ii= ll_last to 1 step -1
	tv_menu.DeleteItem ( ii )
next	


//Espando nuovo livello
is_menu_name='Varie'
select id_voci_menu into :il_voci_settore
from voci_menu where header_menu='V' and id_menu=:il_id_menu;
parent.uf_expand(1)

uf_gest_tasti()
st_15.weight=700
this.BorderStyle = StyleLowered!
il_pres=15
end event

type p_14 from picture within w_menu
integer x = 137
integer y = 1556
integer width = 183
integer height = 160
string picturename = "C:\nita\icone\listino.png"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;
//Cancello voci precedenti
long ll_handle, ll_roothandle, ll_last, ii
treeviewitem l_tvi
ll_handle = tv_menu.FindItem(CurrentTreeItem!, 0)
ll_roothandle = tv_menu.FindItem(RootTreeItem!, 0)

tv_menu.GetItem(ll_handle , l_tvi)
ll_last=tv_menu.InsertItemLast(ll_roothandle, l_tvi)

for ii= ll_last to 1 step -1
	tv_menu.DeleteItem ( ii )
next	


//Espando nuovo livello
is_menu_name='Listini e Distinta Base'
select id_voci_menu into :il_voci_settore
from voci_menu where header_menu='L' and id_menu=:il_id_menu;
parent.uf_expand(1)

uf_gest_tasti()
st_14.weight=700
this.BorderStyle = StyleLowered!
il_pres=14
end event

type p_13 from picture within w_menu
integer x = 379
integer y = 1580
integer width = 183
integer height = 160
string picturename = "C:\nita\icone\ordini.png"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;
//Cancello voci precedenti
long ll_handle, ll_roothandle, ll_last, ii
treeviewitem l_tvi
ll_handle = tv_menu.FindItem(CurrentTreeItem!, 0)
ll_roothandle = tv_menu.FindItem(RootTreeItem!, 0)

tv_menu.GetItem(ll_handle , l_tvi)
ll_last=tv_menu.InsertItemLast(ll_roothandle, l_tvi)

for ii= ll_last to 1 step -1
	tv_menu.DeleteItem ( ii )
next	


//Espando nuovo livello
is_menu_name='Ordini e Grafica'
select id_voci_menu into :il_voci_settore
from voci_menu where header_menu='O' and id_menu=:il_id_menu;
parent.uf_expand(1)

uf_gest_tasti()
st_13.weight=700
this.BorderStyle = StyleLowered!
il_pres=13
end event

type st_12 from statictext within w_menu
integer x = 832
integer y = 724
integer width = 434
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16711680
long backcolor = 67108864
boolean enabled = false
string text = "Personali"
alignment alignment = center!
boolean focusrectangle = false
end type

type p_12 from picture within w_menu
integer x = 741
integer y = 1272
integer width = 183
integer height = 160
string picturename = "C:\nita\icone\Personale.png"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;
//Cancello voci precedenti
long ll_handle, ll_roothandle, ll_last, ii
treeviewitem l_tvi
ll_handle = tv_menu.FindItem(CurrentTreeItem!, 0)
ll_roothandle = tv_menu.FindItem(RootTreeItem!, 0)

tv_menu.GetItem(ll_handle , l_tvi)
ll_last=tv_menu.InsertItemLast(ll_roothandle, l_tvi)

for ii= ll_last to 1 step -1
	tv_menu.DeleteItem ( ii )
next	


//Espando nuovo livello
is_menu_name='Personalizzazioni'
select id_voci_menu into :il_voci_settore
from voci_menu where header_menu='P' and id_menu=:il_id_menu;
parent.uf_expand(1)

uf_gest_tasti()
st_12.weight=700
this.BorderStyle = StyleLowered!
il_pres=12
end event

type p_11 from picture within w_menu
integer x = 1038
integer y = 1220
integer width = 183
integer height = 160
string picturename = "C:\nita\icone\Stampa.png"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;
//Cancello voci precedenti
long ll_handle, ll_roothandle, ll_last, ii
treeviewitem l_tvi
ll_handle = tv_menu.FindItem(CurrentTreeItem!, 0)
ll_roothandle = tv_menu.FindItem(RootTreeItem!, 0)

tv_menu.GetItem(ll_handle , l_tvi)
ll_last=tv_menu.InsertItemLast(ll_roothandle, l_tvi)

for ii= ll_last to 1 step -1
	tv_menu.DeleteItem ( ii )
next	


//Espando nuovo livello
is_menu_name='Stampe'
select id_voci_menu into :il_voci_settore
from voci_menu where header_menu='T' and id_menu=:il_id_menu;

parent.uf_expand(1)

uf_gest_tasti()
st_11.weight=700
this.BorderStyle = StyleLowered!
il_pres=11
end event

type st_11 from statictext within w_menu
integer x = 434
integer y = 956
integer width = 402
integer height = 68
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16711680
long backcolor = 67108864
boolean enabled = false
string text = "Stampe"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_4 from statictext within w_menu
integer x = 55
integer y = 488
integer width = 357
integer height = 68
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16711680
long backcolor = 67108864
boolean enabled = false
string text = "Anagrafica"
alignment alignment = center!
boolean focusrectangle = false
end type

type p_4 from picture within w_menu
integer x = 352
integer y = 1200
integer width = 183
integer height = 160
string picturename = "C:\nita\icone\anagrafiche.png"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;
//Cancello voci precedenti
long ll_handle, ll_roothandle, ll_last, ii
treeviewitem l_tvi
ll_handle = tv_menu.FindItem(CurrentTreeItem!, 0)
ll_roothandle = tv_menu.FindItem(RootTreeItem!, 0)

tv_menu.GetItem(ll_handle , l_tvi)
ll_last=tv_menu.InsertItemLast(ll_roothandle, l_tvi)

for ii= ll_last to 1 step -1
	tv_menu.DeleteItem ( ii )
next	


//Espando nuovo livello
is_menu_name='Anagrafica'
select id_voci_menu into :il_voci_settore
from voci_menu where header_menu='S' and id_menu=:il_id_menu;
parent.uf_expand(1)

uf_gest_tasti()
st_4.weight=700
this.BorderStyle = StyleLowered!
il_pres=4
end event

type st_2 from statictext within w_menu
integer x = 434
integer y = 252
integer width = 416
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16711680
long backcolor = 67108864
boolean enabled = false
string text = "Impostazioni"
alignment alignment = center!
boolean focusrectangle = false
end type

type p_2 from picture within w_menu
integer x = 850
integer y = 1900
integer width = 183
integer height = 160
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;
//Cancello voci precedenti
long ll_handle, ll_roothandle, ll_last, ii
treeviewitem l_tvi
ll_handle = tv_menu.FindItem(CurrentTreeItem!, 0)
ll_roothandle = tv_menu.FindItem(RootTreeItem!, 0)

tv_menu.GetItem(ll_handle , l_tvi)
ll_last=tv_menu.InsertItemLast(ll_roothandle, l_tvi)

for ii= ll_last to 1 step -1
	tv_menu.DeleteItem ( ii )
next	


//Espando nuovo livello
is_menu_name='Impostazioni'
select id_voci_menu into :il_voci_settore
from voci_menu where header_menu='I' and id_menu=:il_id_menu;
parent.uf_expand(1)

uf_gest_tasti()
st_2.weight=700
this.BorderStyle = StyleLowered!
il_pres=2
end event

type st_10 from statictext within w_menu
boolean visible = false
integer x = 69
integer y = 1956
integer width = 357
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16711680
long backcolor = 67108864
boolean enabled = false
string text = "Intrastat"
alignment alignment = center!
boolean focusrectangle = false
end type

type p_10 from picture within w_menu
boolean visible = false
integer x = 155
integer y = 1796
integer width = 183
integer height = 160
boolean originalsize = true
string picturename = "c:\nita\prova.ico"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;
//Cancello voci precedenti
long ll_handle, ll_roothandle, ll_last, ii
treeviewitem l_tvi
ll_handle = tv_menu.FindItem(CurrentTreeItem!, 0)
ll_roothandle = tv_menu.FindItem(RootTreeItem!, 0)

tv_menu.GetItem(ll_handle , l_tvi)
ll_last=tv_menu.InsertItemLast(ll_roothandle, l_tvi)

for ii= ll_last to 1 step -1
	tv_menu.DeleteItem ( ii )
next	


//Espando nuovo livello
is_menu_name='Intrastat'
select id_voci_menu into :il_voci_settore
from voci_menu where header_menu='E' and id_menu=:il_id_menu;
parent.uf_expand(1)

uf_gest_tasti()
st_10.weight=700
this.BorderStyle = StyleLowered!
il_pres=10
end event

type st_9 from statictext within w_menu
boolean visible = false
integer x = 914
integer y = 1724
integer width = 311
integer height = 68
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16711680
long backcolor = 67108864
boolean enabled = false
string text = "Altro"
alignment alignment = center!
boolean focusrectangle = false
end type

type p_9 from picture within w_menu
boolean visible = false
integer x = 978
integer y = 1564
integer width = 183
integer height = 160
boolean enabled = false
boolean originalsize = true
string picturename = "c:\nita\altro.ico"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;
//Cancello voci precedenti
long ll_handle, ll_roothandle, ll_last, ii
treeviewitem l_tvi
ll_handle = tv_menu.FindItem(CurrentTreeItem!, 0)
ll_roothandle = tv_menu.FindItem(RootTreeItem!, 0)

tv_menu.GetItem(ll_handle , l_tvi)
ll_last=tv_menu.InsertItemLast(ll_roothandle, l_tvi)

for ii= ll_last to 1 step -1
	tv_menu.DeleteItem ( ii )
next	


//Espando nuovo livello
is_menu_name='Agenti'
select id_voci_menu into :il_voci_settore
from voci_menu where header_menu='G' and id_menu=:il_id_menu;
parent.uf_expand(1)

uf_gest_tasti()
st_9.weight=700
this.BorderStyle = StyleLowered!
il_pres=9
end event

type st_5 from statictext within w_menu
integer x = 434
integer y = 488
integer width = 402
integer height = 68
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16711680
long backcolor = 67108864
boolean enabled = false
string text = "Finanza"
alignment alignment = center!
boolean focusrectangle = false
end type

type p_5 from picture within w_menu
integer x = 187
integer y = 1344
integer width = 183
integer height = 160
string picturename = "C:\nita\icone\finanza.png"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;
//Cancello voci precedenti
long ll_handle, ll_roothandle, ll_last, ii
treeviewitem l_tvi
ll_handle = tv_menu.FindItem(CurrentTreeItem!, 0)
ll_roothandle = tv_menu.FindItem(RootTreeItem!, 0)

tv_menu.GetItem(ll_handle , l_tvi)
ll_last=tv_menu.InsertItemLast(ll_roothandle, l_tvi)

for ii= ll_last to 1 step -1
	tv_menu.DeleteItem ( ii )
next	


//Espando nuovo livello
is_menu_name='Finanza'
select id_voci_menu into :il_voci_settore
from voci_menu where header_menu='F' and id_menu=:il_id_menu;
parent.uf_expand(1)

uf_gest_tasti()
st_5.weight=700
this.BorderStyle = StyleLowered!
il_pres=5
end event

type st_8 from statictext within w_menu
integer x = 453
integer y = 724
integer width = 357
integer height = 68
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16711680
long backcolor = 67108864
boolean enabled = false
string text = "Articoli"
alignment alignment = center!
boolean focusrectangle = false
end type

type p_8 from picture within w_menu
integer x = 622
integer y = 1204
integer width = 183
integer height = 160
string picturename = "C:\nita\icone\articoli.png"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;
//Cancello voci precedenti
long ll_handle, ll_roothandle, ll_last, ii
treeviewitem l_tvi
ll_handle = tv_menu.FindItem(CurrentTreeItem!, 0)
ll_roothandle = tv_menu.FindItem(RootTreeItem!, 0)

tv_menu.GetItem(ll_handle , l_tvi)
ll_last=tv_menu.InsertItemLast(ll_roothandle, l_tvi)

for ii= ll_last to 1 step -1
	tv_menu.DeleteItem ( ii )
next	


//Espando nuovo livello
is_menu_name='Articoli'
select id_voci_menu into :il_voci_settore
from voci_menu where header_menu='R' and id_menu=:il_id_menu;
parent.uf_expand(1)

uf_gest_tasti()
st_8.weight=700
this.BorderStyle = StyleLowered!
il_pres=8
end event

type st_6 from statictext within w_menu
integer x = 869
integer y = 488
integer width = 357
integer height = 68
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16711680
long backcolor = 67108864
boolean enabled = false
string text = "Cespiti"
alignment alignment = center!
boolean focusrectangle = false
end type

type p_6 from picture within w_menu
integer x = 128
integer y = 1248
integer width = 183
integer height = 160
string picturename = "C:\nita\icone\cespiti.png"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;
//Cancello voci precedenti
long ll_handle, ll_roothandle, ll_last, ii
treeviewitem l_tvi
ll_handle = tv_menu.FindItem(CurrentTreeItem!, 0)
ll_roothandle = tv_menu.FindItem(RootTreeItem!, 0)

tv_menu.GetItem(ll_handle , l_tvi)
ll_last=tv_menu.InsertItemLast(ll_roothandle, l_tvi)

for ii= ll_last to 1 step -1
	tv_menu.DeleteItem ( ii )
next	


//Espando nuovo livello
is_menu_name='Ammortamenti'
select id_voci_menu into :il_voci_settore
from voci_menu where header_menu='Z' and id_menu=:il_id_menu;
parent.uf_expand(1)

uf_gest_tasti()
st_6.weight=700
this.BorderStyle = StyleLowered!
il_pres=6


end event

type st_1 from statictext within w_menu
integer x = 32
integer y = 252
integer width = 402
integer height = 68
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16711680
long backcolor = 67108864
boolean enabled = false
string text = "Dati Azienda"
alignment alignment = center!
boolean focusrectangle = false
end type

type p_1 from picture within w_menu
integer x = 498
integer y = 1876
integer width = 183
integer height = 160
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;
//Cancello voci precedenti
long ll_handle, ll_roothandle, ll_last, ii
treeviewitem l_tvi
ll_handle = tv_menu.FindItem(CurrentTreeItem!, 0)
ll_roothandle = tv_menu.FindItem(RootTreeItem!, 0)

tv_menu.GetItem(ll_handle , l_tvi)
ll_last=tv_menu.InsertItemLast(ll_roothandle, l_tvi)

for ii= ll_last to 1 step -1
	tv_menu.DeleteItem ( ii )
next	


//Espando nuovo livello
is_menu_name='Dati Azienda'
select id_voci_menu into :il_voci_settore
from voci_menu where header_menu='A' and 
id_menu=:il_id_menu;
parent.uf_expand(1)

uf_gest_tasti()
st_1.weight=700
this.BorderStyle = StyleLowered!
il_pres=1
end event

type st_7 from statictext within w_menu
integer x = 32
integer y = 724
integer width = 402
integer height = 68
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16711680
long backcolor = 67108864
boolean enabled = false
string text = "Magazzino"
alignment alignment = center!
boolean focusrectangle = false
end type

type p_7 from picture within w_menu
integer x = 658
integer y = 1392
integer width = 183
integer height = 160
string picturename = "C:\nita\icone\Magazzino.png"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;
//Cancello voci precedenti
long ll_handle, ll_roothandle, ll_last, ii
treeviewitem l_tvi
ll_handle = tv_menu.FindItem(CurrentTreeItem!, 0)
ll_roothandle = tv_menu.FindItem(RootTreeItem!, 0)

tv_menu.GetItem(ll_handle , l_tvi)
ll_last=tv_menu.InsertItemLast(ll_roothandle, l_tvi)

for ii= ll_last to 1 step -1
	tv_menu.DeleteItem ( ii )
next	


//Espando nuovo livello
is_menu_name='Magazzino'
select id_voci_menu into :il_voci_settore
from voci_menu where header_menu='M' and id_menu=:il_id_menu;
parent.uf_expand(1)


uf_gest_tasti()
st_7.weight=700
this.BorderStyle = StyleLowered!
il_pres=7
end event

type st_3 from statictext within w_menu
integer x = 855
integer y = 252
integer width = 402
integer height = 68
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16711680
long backcolor = 67108864
boolean enabled = false
string text = "Contabilità"
alignment alignment = center!
boolean focusrectangle = false
end type

type p_3 from picture within w_menu
integer x = 1070
integer y = 1848
integer width = 183
integer height = 160
string picturename = "C:\nita\icone\Contabilita.png"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;
//Cancello voci precedenti
long ll_handle, ll_roothandle, ll_last, ii
treeviewitem l_tvi
ll_handle = tv_menu.FindItem(CurrentTreeItem!, 0)
ll_roothandle = tv_menu.FindItem(RootTreeItem!, 0)

tv_menu.GetItem(ll_handle , l_tvi)
ll_last=tv_menu.InsertItemLast(ll_roothandle, l_tvi)

for ii= ll_last to 1 step -1
	tv_menu.DeleteItem ( ii )
next	


//Espando nuovo livello
is_menu_name='Contabilità'
select id_voci_menu into :il_voci_settore
from voci_menu where header_menu='C' and id_menu=:il_id_menu;
parent.uf_expand(1)


uf_gest_tasti()
st_3.weight=700
this.BorderStyle = StyleLowered!
il_pres=3
end event

type gb_1 from groupbox within w_menu
integer x = 27
integer y = 24
integer width = 1243
integer height = 1036
integer taborder = 10
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "none"
end type

type st_13 from statictext within w_menu
integer x = 50
integer y = 956
integer width = 448
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16711680
long backcolor = 67108864
boolean enabled = false
string text = "Ordini/Grafica"
end type

type st_14 from statictext within w_menu
integer x = 795
integer y = 956
integer width = 471
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16711680
long backcolor = 67108864
boolean enabled = false
string text = "Listini/Distinta"
alignment alignment = center!
boolean focusrectangle = false
end type

type tv_menu from treeview within w_menu
event doubleclicked pbm_tvndoubleclicked
event key pbm_tvnkeydown
event selectionchanged pbm_tvnselchanged
event ue_start_window ( )
integer x = 14
integer y = 1184
integer width = 1266
integer height = 1232
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
string picturename[] = {"DataWindow5!","Query!","Menu5!","DataWindow5!","Custom039!","Custom050!","Custom093!","C:\nita\icone\old\menu.bmp","C:\nita\icone\finestra.png","C:\nita\icone\cartellag.png","C:\nita\icone\cartellagaperta.png","","AddWatch!"}
long picturemaskcolor = 67108864
long statepicturemaskcolor = 553648127
end type

event doubleclicked;treeViewItem	l_tvi
boolean			lb_exp
s_voice 			lstr_voice

datetime ldt_dataora

if GetItem(handle, l_tvi)=1 then

	if (l_tvi.Level <> 1)  then
	
		lstr_voice= l_tvi.Data
		
		If not (IsNull(lstr_voice.l_id_object) OR lstr_voice.l_id_object =0) then
			parent.uf_start_window(lstr_voice.l_id_object, lstr_voice.w_win_instance,lstr_voice.s_parameters, lstr_voice.l_id_voice )
			l_tvi.Data = lstr_voice
			SetItem(handle, l_tvi)
			//aggiunto 2407200
			if  lstr_voice.l_id_voice> 0 then
				ldt_dataora=datetime(today(), now())
				
				insert into dba.conta_click_menu (id_utente, id_voci_menu, dataora)
				values( :u_freddie.s_utenti.i_idutente,  :lstr_voice.l_id_voice,:ldt_dataora )
				;
				if sqlca.sqlcode=0 then
					commit;
				else
					rollback;
					messagebox("Attenzione!", "Non salvato contatore per: "+string(lstr_voice.l_id_voice))
				end if
			end if //fine 20200724
		else
			if l_tvi.ExpandedOnce then
			//Se è stato esploso almeno una volta
				if l_tvi.Expanded then
					//Se è esploso lo collasso
					collapseItem(handle)
				else
					//Se non è esploso lo esplodo
					ExpandItem(handle)
				end if
			else
			//Se non è stato esploso almeno una volta	
				uf_expand_level(handle, 1)
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

event selectionchanged;treeviewitem l_tvi // item su cui si andrà (nuovo)

tv_menu.GetItem(newhandle, l_tvi)

end event

event ue_start_window();//
end event

event getfocus;//

end event

