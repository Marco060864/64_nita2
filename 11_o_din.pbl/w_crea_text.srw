forward
global type w_crea_text from w_001
end type
type dw_7 from datawindow within w_crea_text
end type
type cb_ok from commandbutton within w_crea_text
end type
type cb_cancella from commandbutton within w_crea_text
end type
type cb_cerca from commandbutton within w_crea_text
end type
type cb_annulla from commandbutton within w_crea_text
end type
type cb_1 from commandbutton within w_crea_text
end type
end forward

global type w_crea_text from w_001
int Width=2427
int Height=440
WindowType WindowType=response!
boolean TitleBar=true
string Title="Inserisci Testo e Proprieta"
boolean ControlMenu=false
dw_7 dw_7
cb_ok cb_ok
cb_cancella cb_cancella
cb_cerca cb_cerca
cb_annulla cb_annulla
cb_1 cb_1
end type
global w_crea_text w_crea_text

type variables
datawindowchild idw_sys_col, idw_tab_alias
long il_id_conf
end variables

on w_crea_text.create
int iCurrent
call super::create
this.dw_7=create dw_7
this.cb_ok=create cb_ok
this.cb_cancella=create cb_cancella
this.cb_cerca=create cb_cerca
this.cb_annulla=create cb_annulla
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_7
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.cb_cancella
this.Control[iCurrent+4]=this.cb_cerca
this.Control[iCurrent+5]=this.cb_annulla
this.Control[iCurrent+6]=this.cb_1
end on

on w_crea_text.destroy
call super::destroy
destroy(this.dw_7)
destroy(this.cb_ok)
destroy(this.cb_cancella)
destroy(this.cb_cerca)
destroy(this.cb_annulla)
destroy(this.cb_1)
end on

event open;s_dinamica s_dina
integer li_ret


s_dina=message.powerobjectparm
if s_dina.ls_tipo='crea_column' then
	il_id_conf=s_dina.id_conf_oggetti
	
	dw_7.dataobject="d_col_disponibili"
	
	

	if dw_7.dataobject="d_col_disponibili" then
		
		li_ret=dw_7.getchild("tabelle_alias", idw_sys_col)
		if li_ret=-1 then messagebox("Errore!", "Child non creata!")
		idw_sys_col.settransobject(sqlca)
		idw_sys_col.setfilter("id_conf_oggetti="+string(il_id_conf))
		idw_sys_col.filter()
		idw_sys_col.retrieve()
		
		li_ret=dw_7.getchild("nome", idw_tab_alias)
		if li_ret=-1 then messagebox("Errore!", "idw_tab_alias Child non creata!")
		idw_tab_alias.settransobject(sqlca)
		
		idw_tab_alias.retrieve("", "")
		
	end if
	dw_7.insertrow(1)
else
	dw_7.insertrow(1)
	dw_7.setitem(1,"nome",s_dina.ls_nome)
	dw_7.setitem(1,"testo",s_dina.ls_testo)
	dw_7.setitem(1,"tipo",s_dina.ls_tipo)
end if
end event

type dw_7 from datawindow within w_crea_text
int X=32
int Y=20
int Width=2345
int Height=196
int TabOrder=10
boolean BringToTop=true
string DataObject="d_crea_text"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

event itemchanged;long ll_riga
integer li_pos, li_ret
string ls_tipo, ls_num_dec, ls_val_tipo,  ls_nome_alias,ls_nome_tab
datawindowchild ldw_tab_alias

if dwo.name="nome" then
	ll_riga=idw_tab_alias.getrow()
	if ll_riga> 0 then
		ls_tipo=idw_tab_alias.getitemstring(ll_riga, "coltype")
		if pos(ls_tipo, "char")>0 then
			ls_tipo+= "("+string(idw_tab_alias.getitemnumber(ll_riga, "length"))+")"
		elseif ls_tipo="numeric" then
			ls_tipo="decimal"
			ls_tipo+= "("+string(idw_tab_alias.getitemnumber(ll_riga, "syslength"))+")"
		end if
		
		setitem(1, "testo", ls_tipo)
	end if
end if

if dwo.name="tabelle_alias" then
	li_ret=dw_7.getchild("nome", ldw_tab_alias)
	if li_ret=-1 then messagebox("Errore!", "Child non creata!")
	ldw_tab_alias.settransobject(sqlca)
	ll_riga=idw_sys_col.getrow()
	ls_nome_alias=idw_sys_col.getitemstring(ll_riga, "nome_alias")
	ls_nome_tab=idw_sys_col.getitemstring(ll_riga, "nome_tabella")
	ldw_tab_alias.retrieve(ls_nome_tab, ls_nome_alias)
end if
end event

type cb_ok from commandbutton within w_crea_text
int X=2130
int Y=232
int Width=247
int Height=108
int TabOrder=20
boolean BringToTop=true
string Text="OK"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;s_dinamica s_dina
if dw_7.rowcount()>0 then
	dw_7.accepttext()
	s_dina.ls_testo=dw_7.getitemstring(1, "testo")
	s_dina.ls_nome=dw_7.getitemstring(1, "nome")
	s_dina.ls_tipo=dw_7.getitemstring(1, "tipo")
	s_dina.cancella='N' 
	
	closewithreturn(parent, s_dina)
end if
end event

type cb_cancella from commandbutton within w_crea_text
int X=1815
int Y=232
int Width=247
int Height=108
int TabOrder=30
boolean BringToTop=true
string Text="Cancella"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;s_dinamica s_dina
if messagebox("Attenzione!","Procedere alla cancellazione dell'oggetto?", stopsign!,yesno!)=1 then
	s_dina.cancella="S"
	s_dina.ls_tipo=dw_7.getitemstring(1, "tipo")
	closewithreturn(parent, s_dina)
end if
end event

type cb_cerca from commandbutton within w_crea_text
int X=1490
int Y=232
int Width=265
int Height=108
int TabOrder=40
boolean BringToTop=true
string Text="Cerca File"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;integer li_ret
string ls_path, ls_file
	
getfileopenname("Cerca report", ls_path, ls_file)
if  not(trim(ls_file)="" or isnull(ls_file)) then
	dw_7.setitem(1, "testo", ls_path)
end if	 
end event

type cb_annulla from commandbutton within w_crea_text
int X=1189
int Y=232
int Width=247
int Height=108
int TabOrder=50
boolean BringToTop=true
string Text="Annulla"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(parent)
end event

type cb_1 from commandbutton within w_crea_text
int X=41
int Y=232
int Width=357
int Height=108
int TabOrder=50
boolean BringToTop=true
string Text="Carica Tabelle"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
openwithparm(w_tab_dw_gd, il_id_conf)
end event

