forward
global type w_menu_admin_lt from w_list_main
end type
type cb_copia from commandbutton within w_menu_admin_lt
end type
end forward

global type w_menu_admin_lt from w_list_main
int Width=1335
int Height=1177
boolean TitleBar=true
string Title="Lista dei Menu"
cb_copia cb_copia
end type
global w_menu_admin_lt w_menu_admin_lt

forward prototypes
public function long wf_scelta ()
end prototypes

public function long wf_scelta ();

long				ll_row, ll_id_menu, ll_figlio, ll_i, ll_sbagli
string			ls_text
s_list_main		lstr_for_win

ll_row = dw_list.GetRow()

ll_id_menu = dw_list.GetItemNumber(ll_row, "id_menu")
SELECT Min("voci_menu"."id_voci_menu") INTO :ll_figlio
  FROM "dba"."voci_menu"  
  WHERE ( "voci_menu"."id_menu" = :ll_id_menu ) ;
if Not IsNull(ll_figlio) And ll_figlio <> 0 then
	lstr_for_win.l_identifica[1] = ll_id_menu
	lstr_for_win.l_identifica[2] = 0
	OpenWithParm(w_voci_menu_ext_lt, lstr_for_win)
end if
Return ll_figlio
end function

on w_menu_admin_lt.create
int iCurrent
call w_list_main::create
this.cb_copia=create cb_copia
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=cb_copia
end on

on w_menu_admin_lt.destroy
call w_list_main::destroy
destroy(this.cb_copia)
end on

event open;call super::open;ias_key_name[1] = "id_menu"
end event

event resize;dw_list.Width = newwidth - 80
dw_list.Height = newheight - 180

cb_copia.Width = newwidth/2
cb_copia.y = newheight - 100

end event

type p_crescente from w_list_main`p_crescente within w_menu_admin_lt
boolean BringToTop=true
end type

type p_decrescente from w_list_main`p_decrescente within w_menu_admin_lt
boolean BringToTop=true
end type

type dw_list from w_list_main`dw_list within w_menu_admin_lt
int Width=1189
int TabOrder=10
string DataObject="d_menu_admin_lt"
end type

event dw_list::ue_init;call super::ue_init;is_resp_window = "w_menu_admin_cx"
is_title = "Lista dei Menu"
end event

event dw_list::ue_delete;

long				ll_row, ll_id_menu, ll_figlio, ll_i, ll_sbagli
string			ls_text
s_list_main		lstr_for_win

ll_row = GetRow()
SetPointer(HourGlass!)
ll_figlio = wf_scelta()
SetPointer(Arrow!)
if ll_figlio > 0 then
	lstr_for_win = Message.PowerObjectParm
	
	if lstr_for_win.l_identifica[1] < 0 then
		Return -1
	end if
end if
if ib_allow_delete and THIS.getconfirm(ici_confirm_delete) then
	
	THIS.DeleteRow(ll_row)
	
	if Not IsNull(ll_figlio) And ll_figlio <> 0 then
		FOR ll_i =1 TO UpperBound(lstr_for_win.l_identifica)
			DELETE FROM "dba"."voci_menu" 
				WHERE ( "dba"."voci_menu"."id_voci_menu" = :lstr_for_win.l_identifica[ll_i] ) ;
		NEXT
	end if
end if

ll_sbagli = Event ue_core_update (0,0)
ll_sbagli = Event ue_commit(ll_sbagli)

SelectRow(GetRow(), TRUE)
end event

type cb_copia from commandbutton within w_menu_admin_lt
int X=46
int Y=961
int Width=595
int Height=81
int TabOrder=20
boolean BringToTop=true
string Text="Duplica Menu"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

long				ll_row, ll_id_menu_orig, ll_id_menu, ll_id_voci_menu, ll_figlio, ll_i
string			ls_menu
s_list_main		lstr_for_win
long				ll_id_vm[]

ll_row = dw_list.GetRow()
SetPointer(HourGlass!)
ll_figlio = wf_scelta()
SetPointer(Arrow!)
if ll_figlio > 0 then
	lstr_for_win = Message.PowerObjectParm
	
	if lstr_for_win.l_identifica[1] < 0 then
		Return -1
	end if
end if
ls_menu = dw_list.GetItemString(ll_row, "menu_descrizione")
ll_id_menu_orig = dw_list.GetItemNumber(ll_row, "id_menu")
if MessageBox("Conferma", "Confermi la copia delle voci partendo da <" + &
		ls_menu + ">?", Question!, YesNo!) = 2 then
	Return -1
else
	ls_menu = ls_menu + " NUOVO!!!"
	
	INSERT INTO dba.menu(menu_descrizione) VALUES (:ls_menu) ;
	sqlca.identity(ll_id_menu);
	COMMIT using SQLCA;
	dw_list.Retrieve()
	
	declare lcur_menu cursor for
	  SELECT distinct id_voci_menu
		 FROM voci_menu
		 WHERE ( voci_menu.id_menu = :ll_id_menu_orig )   ;
	open lcur_menu;
	if sqlca.sqlcode < 0 then
		MessageBox ("DataBase Error-1!", sqlca.sqlerrtext, exclamation!)
		return -1
	end if 
	
	do while sqlca.sqlcode = 0
		fetch lcur_menu into :ll_id_voci_menu ;
		if sqlca.sqlcode = 0 then
			
			ll_id_vm[UpperBound(ll_id_vm)+1] = ll_id_voci_menu
		elseif sqlca.sqlcode < 0 then
			MessageBox ("DataBase Error-2!", sqlca.sqlerrtext, exclamation!)
			return -1
		end if
	loop
	close lcur_menu;
	
	for ll_i = 1 to UpperBound(ll_id_vm)
		f_recurse_voci_menu(ll_id_vm[ll_i], ll_id_menu, "M")
	next
	COMMIT using SQLCA;
end if
end event

