forward
global type w_mostra_immagine from w_splash
end type
type cb_1 from commandbutton within w_mostra_immagine
end type
type p_1 from picture within w_mostra_immagine
end type
type p_2 from picture within w_mostra_immagine
end type
end forward

global type w_mostra_immagine from w_splash
integer x = 961
integer y = 613
integer width = 1371
integer height = 1252
boolean enabled = true
boolean titlebar = true
string title = "Mostra Immagini"
boolean controlmenu = true
boolean minbox = true
boolean border = true
cb_1 cb_1
p_1 p_1
p_2 p_2
end type
global w_mostra_immagine w_mostra_immagine

forward prototypes
public subroutine wf_mostra (string as_imm)
end prototypes

public subroutine wf_mostra (string as_imm);string ls_imm, ls_path
integer  li_w_max, li_h, li_w
decimal ldc_dim_rapporto


li_h=800
li_w_max=1000
select dir_immagini
into :ls_path
from par_sistema;

if as_imm>"" then
	if pos(as_imm, "\") <=0 then ls_imm=ls_path+"\"+as_imm
	p_1.picturename=ls_imm
	ldc_dim_rapporto=p_1.width/p_1.height
	li_w=ldc_dim_rapporto*li_h
	if li_w>li_w_max then
		li_w=li_w_max
		li_h=1/ldc_dim_rapporto*li_w
	end if		
	p_2.picturename=ls_imm
	p_2.width=li_w
	p_2.height=li_h
end if
end subroutine

on w_mostra_immagine.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.p_1=create p_1
this.p_2=create p_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.p_1
this.Control[iCurrent+3]=this.p_2
end on

on w_mostra_immagine.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.p_1)
destroy(this.p_2)
end on

event open;call super::open;string ls_imm

ls_imm=message.stringparm
wf_mostra(ls_imm)
end event

type p_splash from w_splash`p_splash within w_mostra_immagine
boolean visible = false
integer x = 32
integer y = 16
integer width = 1285
integer height = 1140
boolean originalsize = false
end type

type cb_1 from commandbutton within w_mostra_immagine
integer x = 946
integer y = 1024
integer width = 343
integer height = 100
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Chiudi"
end type

event clicked;close(parent)
end event

type p_1 from picture within w_mostra_immagine
boolean visible = false
integer x = 489
integer y = 988
integer width = 192
integer height = 168
boolean bringtotop = true
boolean originalsize = true
boolean focusrectangle = false
end type

type p_2 from picture within w_mostra_immagine
integer x = 59
integer y = 16
integer width = 1234
integer height = 956
boolean bringtotop = true
boolean focusrectangle = false
end type

