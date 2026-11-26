forward
global type w_mod_single_data from w_np_single_data
end type
type cb_ok from commandbutton within w_mod_single_data
end type
type cb_annulla from commandbutton within w_mod_single_data
end type
type cb_inserisci from commandbutton within w_mod_single_data
end type
type cb_cancella from commandbutton within w_mod_single_data
end type
type cb_salva from commandbutton within w_mod_single_data
end type
end forward

global type w_mod_single_data from w_np_single_data
int Width=1738
int Height=1537
WindowType WindowType=response!
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
cb_ok cb_ok
cb_annulla cb_annulla
cb_inserisci cb_inserisci
cb_cancella cb_cancella
cb_salva cb_salva
end type
global w_mod_single_data w_mod_single_data

event resize;dw_single.Width = newwidth - 92
dw_single.Height = newheight - 200
cb_salva.x = newwidth - 320
cb_cancella.x = cb_salva.x - 275
cb_inserisci.x = cb_cancella.x - 275

end event

on w_mod_single_data.create
int iCurrent
call w_np_single_data::create
this.cb_ok=create cb_ok
this.cb_annulla=create cb_annulla
this.cb_inserisci=create cb_inserisci
this.cb_cancella=create cb_cancella
this.cb_salva=create cb_salva
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=cb_ok
this.Control[iCurrent+2]=cb_annulla
this.Control[iCurrent+3]=cb_inserisci
this.Control[iCurrent+4]=cb_cancella
this.Control[iCurrent+5]=cb_salva
end on

on w_mod_single_data.destroy
call w_np_single_data::destroy
destroy(this.cb_ok)
destroy(this.cb_annulla)
destroy(this.cb_inserisci)
destroy(this.cb_cancella)
destroy(this.cb_salva)
end on

event open;s_ric_param	lstr_param
string		ls_sql
integer		li_w, li_h

ib_close_query = TRUE
ib_askforsave = TRUE
u_freddie.iw_current = THIS
lstr_param = message.PowerObjectParm
u_freddie.center_window(this)

li_w =  lstr_param.i_width
li_h =  lstr_param.i_height
if isNull(li_w) then li_w = 0
if isNull(li_h) then li_h = 0
if (li_w>0) and (li_w<1738) then li_w = 1738
if (li_h>0) and (li_h<853) then li_w = 853
if (li_w>0) and (li_h > 0) then
	resize(li_w, li_h)
end if

if not IsNull(lstr_param.s_datawindow) then
	if lstr_param.s_datawindow > "" then
		dw_single.dataobject = lstr_param.s_datawindow
		title = lstr_param.s_titolo_finestra
		dw_single.SetTransObject(SQLCA)
		ls_sql = dw_single.object.datawindow.table.select
		dw_single.iu_scan.f_setinitial(ls_sql)
		dw_single.iu_scan.f_setcurrent(ls_sql)
		
	end if
end if

is_wintype = "W_MOD_SINGLE_DATA"
idw_master = dw_single
dw_single.Retrieve()
PostEvent("ue_post_open")


end event

type p_crescente from w_np_single_data`p_crescente within w_mod_single_data
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_mod_single_data
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_mod_single_data
int Y=161
int Width=1623
int Height=1261
int TabOrder=40
end type

event dw_single::losefocus;

end event

type cb_ok from commandbutton within w_mod_single_data
int X=46
int Y=41
int Width=247
int Height=89
int TabOrder=50
boolean BringToTop=true
string Text="Ok"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

dw_single.AcceptText()

dw_single.triggerevent("ue_update")

close(parent)

end event

type cb_annulla from commandbutton within w_mod_single_data
int X=321
int Y=41
int Width=247
int Height=89
int TabOrder=30
boolean BringToTop=true
string Text="Annulla"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(parent)

end event

type cb_inserisci from commandbutton within w_mod_single_data
int X=869
int Y=41
int Width=247
int Height=89
int TabOrder=20
boolean BringToTop=true
string Text="Inserisci"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;parent.triggerevent("ue_insert")

end event

type cb_cancella from commandbutton within w_mod_single_data
int X=1143
int Y=41
int Width=247
int Height=89
int TabOrder=10
boolean BringToTop=true
string Text="Cancella"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;parent.triggerevent("ue_delete")

end event

type cb_salva from commandbutton within w_mod_single_data
int X=1418
int Y=41
int Width=247
int Height=89
int TabOrder=5
boolean BringToTop=true
string Text="Salva"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;parent.triggerevent("ue_update")

end event

