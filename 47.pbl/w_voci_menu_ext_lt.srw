forward
global type w_voci_menu_ext_lt from Window
end type
type cb_2 from commandbutton within w_voci_menu_ext_lt
end type
type cb_1 from commandbutton within w_voci_menu_ext_lt
end type
type st_voci_menu_ext_lt_t from statictext within w_voci_menu_ext_lt
end type
type dw_voci_menu_ext_lt from u_dw_ext_main within w_voci_menu_ext_lt
end type
end forward

global type w_voci_menu_ext_lt from Window
int X=458
int Y=225
int Width=2890
int Height=1529
boolean TitleBar=true
string Title="Scelta Voci Menu"
long BackColor=79741120
boolean ControlMenu=true
WindowType WindowType=response!
cb_2 cb_2
cb_1 cb_1
st_voci_menu_ext_lt_t st_voci_menu_ext_lt_t
dw_voci_menu_ext_lt dw_voci_menu_ext_lt
end type
global w_voci_menu_ext_lt w_voci_menu_ext_lt

type variables
s_list_main	istr_for_win

end variables

forward prototypes
public function long wf_inserisci_riga (long al_id_voci_menu)
public function long wf_collect_menu (long al_id_menu)
public function long wf_collect_voci_menu (long al_id_voci_menu)
end prototypes

public function long wf_inserisci_riga (long al_id_voci_menu);

long 		ll_id_voci_menu, ll_id_menu, ll_id_voci_menu_padre, ll_id_oggetti, &
			ll_vmenu_order, ll_row
string	ls_vmenu_voce, ls_micro_help, ls_help, ls_vmenu_parametri, ls_text


SELECT "dba"."voci_menu"."id_voci_menu", "dba"."voci_menu"."id_menu",
		"dba"."voci_menu"."id_voci_menu_padre", "dba"."voci_menu"."vmenu_voce",
		"dba"."voci_menu"."vmenu_micro_help", "dba"."voci_menu"."vmenu_help",
		"dba"."voci_menu"."id_oggetti", "dba"."voci_menu"."vmenu_parametri", 
		"dba"."voci_menu"."vmenu_order"
  	 INTO :ll_id_voci_menu, :ll_id_menu, :ll_id_voci_menu_padre, :ls_vmenu_voce, 
			:ls_micro_help, :ls_help, :ll_id_oggetti, :ls_vmenu_parametri, :ll_vmenu_order
  	 FROM "dba"."voci_menu"  
	 WHERE "dba"."voci_menu"."id_voci_menu" = :al_id_voci_menu ;
CHOOSE CASE sqlca.sqlcode
	CASE 0
		ll_row = dw_voci_menu_ext_lt.InsertRow(0)
		if ll_row > 0 then
			dw_voci_menu_ext_lt.SetItem(ll_row, "id_voci_menu", ll_id_voci_menu)
			dw_voci_menu_ext_lt.SetItem(ll_row, "id_menu", ll_id_menu)
			dw_voci_menu_ext_lt.SetItem(ll_row, "id_voci_menu_padre", ll_id_voci_menu_padre)
			dw_voci_menu_ext_lt.SetItem(ll_row, "vmenu_voce", ls_vmenu_voce)
			dw_voci_menu_ext_lt.SetItem(ll_row, "vmenu_micro_help", ls_micro_help)
			dw_voci_menu_ext_lt.SetItem(ll_row, "vmenu_help", ls_help)
			dw_voci_menu_ext_lt.SetItem(ll_row, "id_oggetti", ll_id_oggetti)
			dw_voci_menu_ext_lt.SetItem(ll_row, "vmenu_parametri", ls_vmenu_parametri)
			dw_voci_menu_ext_lt.SetItem(ll_row, "vmenu_order", ll_vmenu_order)
			
			if ll_row = 1 then
				ls_text = " voce):"
			else
				ls_text = " voci):"
			end if
			st_voci_menu_ext_lt_t.Text = "Sono state scelte le seguenti voci del menu (" + &
					string(ll_row) + ls_text
		else
			MessageBox("Avviso", "Inserimento riga non riuscito.")
			Return -1
		end if
	CASE -1, 100
		MessageBox ("DataBase Error", sqlca.sqlerrtext, exclamation!)
		Return -1
END CHOOSE

Return ll_row
end function

public function long wf_collect_menu (long al_id_menu);

long				ll_id_vm[]
long 				ll_id_voci_menu, ll_i

declare lcur_menu cursor for
  SELECT distinct id_voci_menu
	 FROM voci_menu
	 WHERE ( voci_menu.id_menu = :al_id_menu )   ;
open lcur_menu;
if sqlca.sqlcode < 0 then
	MessageBox ("DataBase Error IdMenu-1!", sqlca.sqlerrtext, exclamation!)
	return -1
end if 
do while sqlca.sqlcode = 0
	fetch lcur_menu into :ll_id_voci_menu ;
	if sqlca.sqlcode = 0 then
		
		ll_id_vm[UpperBound(ll_id_vm)+1] = ll_id_voci_menu
	elseif sqlca.sqlcode < 0 then
		MessageBox ("DataBase Error IdMenu-2!", sqlca.sqlerrtext, exclamation!)
		return -1
	end if
loop
close lcur_menu;
FOR ll_i = 1 TO UpperBound(ll_id_vm)
	wf_collect_voci_menu(ll_id_vm[ll_i])
NEXT

Return 0
end function

public function long wf_collect_voci_menu (long al_id_voci_menu);

long				ll_id_vm[]
long 				ll_id_voci_menu, ll_ret, ll_i

ll_ret = wf_inserisci_riga(al_id_voci_menu)
istr_for_win.l_identifica[UpperBound(istr_for_win.l_identifica) + 1] = al_id_voci_menu
if ll_ret > 0 then
	declare lcur_voci_menu cursor for
	  SELECT distinct id_voci_menu
		 FROM voci_menu
		 WHERE ( voci_menu.id_voci_menu_padre = :al_id_voci_menu )   ;
	open lcur_voci_menu;
	if sqlca.sqlcode < 0 then
		MessageBox ("DataBase Error-1!", sqlca.sqlerrtext, exclamation!)
		return -1
	end if 
	
	do while sqlca.sqlcode = 0
		fetch lcur_voci_menu into :ll_id_voci_menu ;
		if sqlca.sqlcode = 0 then
			
			ll_id_vm[UpperBound(ll_id_vm)+1] = ll_id_voci_menu
		elseif sqlca.sqlcode < 0 then
			MessageBox ("DataBase Error-2!", sqlca.sqlerrtext, exclamation!)
			return -1
		end if
	loop
	close lcur_voci_menu;
	
	FOR ll_i = 1 TO UpperBound(ll_id_vm)
		wf_collect_voci_menu(ll_id_vm[ll_i])
	NEXT
else
	MessageBox("Attenzione", "Inserimento riga con l'ID " + string(al_id_voci_menu) + &
					" non riuscita.")
	Return -1
end if

Return 0
end function

on w_voci_menu_ext_lt.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_voci_menu_ext_lt_t=create st_voci_menu_ext_lt_t
this.dw_voci_menu_ext_lt=create dw_voci_menu_ext_lt
this.Control[]={ this.cb_2,&
this.cb_1,&
this.st_voci_menu_ext_lt_t,&
this.dw_voci_menu_ext_lt}
end on

on w_voci_menu_ext_lt.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_voci_menu_ext_lt_t)
destroy(this.dw_voci_menu_ext_lt)
end on

event close;
CloseWithReturn(This, istr_for_win)
end event

event open;

datawindowchild 	ldw_child1, ldw_child2
s_list_main			lstr_for_win
long					ll_id_menu, ll_id_voci_menu

dw_voci_menu_ext_lt.GetChild("id_oggetti",ldw_child1)
ldw_child1.SetTransObject(SQLCA)
ldw_child1.Retrieve()
dw_voci_menu_ext_lt.GetChild("id_voci_menu_padre",ldw_child2)
ldw_child2.SetTransObject(SQLCA)
ldw_child2.Retrieve()

lstr_for_win = Message.PowerObjectParm
ll_id_menu = lstr_for_win.l_identifica[1]
ll_id_voci_menu = lstr_for_win.l_identifica[2]
if IsNull(ll_id_menu) then ll_id_menu = 0
if IsNull(ll_id_voci_menu) then ll_id_voci_menu = 0
if ll_id_menu = 0 and ll_id_voci_menu <> 0 then
	
	wf_collect_voci_menu(ll_id_voci_menu)
else 
	if ll_id_menu <> 0 and ll_id_voci_menu = 0 then
		
		wf_collect_menu(ll_id_menu)
	else
		
		MessageBox("Avviso","Correggere la scelta del menu.")
		TriggerEvent("Close")
	end if
end if
end event

type cb_2 from commandbutton within w_voci_menu_ext_lt
int X=2355
int Y=41
int Width=439
int Height=85
int TabOrder=10
string Text="&Annulla la scelta"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;istr_for_win.l_identifica[1] = -5
Parent.TriggerEvent("Close")
end event

type cb_1 from commandbutton within w_voci_menu_ext_lt
int X=46
int Y=41
int Width=508
int Height=85
int TabOrder=30
string Text="&Conferma la scelta"
boolean Default=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if MessageBox("Conferma", "Confermi la scelta di TUTTE queste voci?", Question!, YesNo!) = 1 then
	Parent.TriggerEvent("Close")
else
	Return 1
end if
end event

type st_voci_menu_ext_lt_t from statictext within w_voci_menu_ext_lt
int X=46
int Y=161
int Width=2766
int Height=81
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
string Text=" Sono state selezionate le seguenti voci del menu:"
boolean FocusRectangle=false
long TextColor=16777215
long BackColor=276856960
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_voci_menu_ext_lt from u_dw_ext_main within w_voci_menu_ext_lt
int X=46
int Y=241
int Width=2766
int Height=1121
int TabOrder=20
string DataObject="d_voci_menu_ext_lt"
boolean HScrollBar=true
boolean VScrollBar=true
end type

