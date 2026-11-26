forward
global type w_mod_reg_pd_cx from Window
end type
type dw_2 from u_dw_ext_main within w_mod_reg_pd_cx
end type
type dw_1 from u_dw_master_main within w_mod_reg_pd_cx
end type
type cb_4 from commandbutton within w_mod_reg_pd_cx
end type
type cb_salva from commandbutton within w_mod_reg_pd_cx
end type
type cb_annulla from commandbutton within w_mod_reg_pd_cx
end type
type cb_ok from commandbutton within w_mod_reg_pd_cx
end type
end forward

global type w_mod_reg_pd_cx from Window
int X=1056
int Y=484
int Width=2935
int Height=1512
boolean TitleBar=true
string Title="Modifica registrazioni"
long BackColor=80263328
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
dw_2 dw_2
dw_1 dw_1
cb_4 cb_4
cb_salva cb_salva
cb_annulla cb_annulla
cb_ok cb_ok
end type
global w_mod_reg_pd_cx w_mod_reg_pd_cx

on w_mod_reg_pd_cx.create
this.dw_2=create dw_2
this.dw_1=create dw_1
this.cb_4=create cb_4
this.cb_salva=create cb_salva
this.cb_annulla=create cb_annulla
this.cb_ok=create cb_ok
this.Control[]={this.dw_2,&
this.dw_1,&
this.cb_4,&
this.cb_salva,&
this.cb_annulla,&
this.cb_ok}
end on

on w_mod_reg_pd_cx.destroy
destroy(this.dw_2)
destroy(this.dw_1)
destroy(this.cb_4)
destroy(this.cb_salva)
destroy(this.cb_annulla)
destroy(this.cb_ok)
end on

event open;dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
dw_2.insertrow(0)
end event

type dw_2 from u_dw_ext_main within w_mod_reg_pd_cx
int X=27
int Y=228
int Width=2309
int Height=160
int TabOrder=40
string DataObject="d_filtra_reg"
end type

event itemchanged;long ll_reg
date ld_d, ld_a
string ls_reg
if dwo.name='registro' then
	ll_reg=long(data)
	select tipo_registro into :ls_reg from registro where id_registro=:ll_reg;
	dw_2.setitem(1,'reg',ls_reg)
	select data_inizio, data_fine into :ld_d, :ld_a
	from esercizio e, registro r
	where r.id_esercizio=e.id_esercizio and r.id_registro=:ll_reg;
	dw_2.setitem(1,'da_data',ld_d)
	dw_2.setitem(1,'a_data',ld_a)
end if	
	
end event

type dw_1 from u_dw_master_main within w_mod_reg_pd_cx
int X=23
int Y=452
int Width=2802
int Height=920
int TabOrder=50
string DataObject="d_reg_pd_mod"
boolean HScrollBar=true
boolean VScrollBar=true
boolean HSplitScroll=true
end type

event getfocus;
end event

event losefocus;
end event

type cb_4 from commandbutton within w_mod_reg_pd_cx
int X=2359
int Y=232
int Width=471
int Height=156
int TabOrder=30
string Text="Carica registrazioni"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string ls_reg
date ld_d, ld_a
long ll_reg

dw_2.accepttext()
ll_reg=dw_2.getitemnumber(1,'registro')
ld_d=dw_2.getitemdate(1,'da_data')
ld_a=dw_2.getitemdate(1,'a_data')
select tipo_registro into :ls_reg from registro where id_registro=:ll_reg;

if isnull(ld_d) or isnull(ld_a) then
	messagebox('Attenzione!','Una delle date non è stata inserita correttamente!') 
	return
end if	
	
dw_1.retrieve(ls_reg,ld_d,ld_a)
end event

type cb_salva from commandbutton within w_mod_reg_pd_cx
int X=2510
int Y=64
int Width=247
int Height=108
int TabOrder=60
string Text="Salva"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.update()
end event

type cb_annulla from commandbutton within w_mod_reg_pd_cx
int X=325
int Y=28
int Width=247
int Height=108
int TabOrder=20
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

type cb_ok from commandbutton within w_mod_reg_pd_cx
int X=32
int Y=28
int Width=247
int Height=108
int TabOrder=10
string Text="OK"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.update()
close(parent)
end event

