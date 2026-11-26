forward
global type w_variante_comp_ff from Window
end type
type cb_2 from commandbutton within w_variante_comp_ff
end type
type cb_1 from commandbutton within w_variante_comp_ff
end type
type tv_1 from u_tv_distinta within w_variante_comp_ff
end type
type dw_variante_comp_ff from datawindow within w_variante_comp_ff
end type
end forward

global type w_variante_comp_ff from Window
int X=823
int Y=360
int Width=1897
int Height=1436
boolean TitleBar=true
string Title="Untitled"
long BackColor=78682240
boolean ControlMenu=true
WindowType WindowType=response!
cb_2 cb_2
cb_1 cb_1
tv_1 tv_1
dw_variante_comp_ff dw_variante_comp_ff
end type
global w_variante_comp_ff w_variante_comp_ff

type variables
s_componente is_comp[]
end variables

event open;long ll_distinta,ll_pos,i
date ld_inizio,ld_fine
string ls_parametri
tv_1=message.powerobjectparm
is_comp=tv_1.is_comp
if upperbound(is_comp)>0 then		
	for i=1 to upperbound(is_comp)
		dw_variante_comp_ff.insertrow(0)
		dw_variante_comp_ff.modify("campo"+string(i)+".visible=1")
		dw_variante_comp_ff.modify("campo"+string(i)+".protect=0")
		dw_variante_comp_ff.modify("campo"+string(i)+".TabSequence	="+string(i*10))
		dw_variante_comp_ff.modify("campo"+string(i)+".Height=69")
		dw_variante_comp_ff.modify("campo"+string(i)+".border=5")
		dw_variante_comp_ff.modify("campo"+string(i)+".dddw.AutoHScroll=yes")
		dw_variante_comp_ff.modify("campo"+string(i)+".dddw.AllowEdit=yes")
		dw_variante_comp_ff.modify("campo"+string(i)+".dddw.Name='d_riga_componente_lt'")
		dw_variante_comp_ff.modify("campo"+string(i)+".dddw.DataColumn='riga_componente_id_articolo'")
		dw_variante_comp_ff.modify("campo"+string(i)+".dddw.DisplayColumn='articolo_codice'")
		dw_variante_comp_ff.modify("campo"+string(i)+".dddw.PercentWidth=400")
		dw_variante_comp_ff.modify("campo"+string(i)+".dddw.VScrollBar=Yes")				
		datawindowchild ldw_child	
		dw_variante_comp_ff.getchild('campo'+string(i),ldw_child)
		ldw_child.settransobject(sqlca)
		string ls_sql
		long ll_id_componente
		ll_id_componente=tv_1.is_comp[i].id_componente
		ls_sql=ldw_child.getsqlselect()
		ls_sql=ls_sql+' and "riga_componente"."id_componente" ='+string(ll_id_componente)
		ldw_child.setsqlselect(ls_sql)
		ldw_child.retrieve()
		string cod
		select codice
		into:cod
		from componente
		where id_componente =:ll_id_componente;
		dw_variante_comp_ff.modify("text"+string(i)+".visible=1")
		dw_variante_comp_ff.modify("text"+string(i)+".text='"+cod+"'")
	next
end if


end event

on w_variante_comp_ff.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.tv_1=create tv_1
this.dw_variante_comp_ff=create dw_variante_comp_ff
this.Control[]={this.cb_2,&
this.cb_1,&
this.tv_1,&
this.dw_variante_comp_ff}
end on

on w_variante_comp_ff.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.tv_1)
destroy(this.dw_variante_comp_ff)
end on

type cb_2 from commandbutton within w_variante_comp_ff
int X=1609
int Y=176
int Width=247
int Height=76
int TabOrder=30
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

type cb_1 from commandbutton within w_variante_comp_ff
int X=1609
int Y=52
int Width=247
int Height=76
int TabOrder=20
string Text="OK"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;integer i
long ll_val
boolean lb_ok
lb_ok=true
for i=1 to upperbound(is_comp)
	ll_val=dw_variante_comp_ff.getitemnumber(1,"campo"+string(i))
	if ll_val=0 or isnull(ll_val) then
		lb_ok=false
	end if
next
if lb_ok=true then
	tv_1.is_comp=is_comp
	u_tv_distinta luo_dis
	luo_dis=create u_tv_distinta
	luo_dis.is_comp=tv_1.is_comp
	CloseWithReturn(parent,luo_dis)
else
	messagebox("Informazione","Non sono stati inseriti uno o più componenti!",information!)
end if
end event

type tv_1 from u_tv_distinta within w_variante_comp_ff
int X=1618
int Y=312
int Width=293
int Height=196
int TabOrder=40
boolean Visible=false
end type

type dw_variante_comp_ff from datawindow within w_variante_comp_ff
int X=14
int Y=16
int Width=1577
int Height=1304
int TabOrder=10
string DataObject="d_variante_comp_ff"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

event itemchanged;string ls_num,ls_data
integer li_campo
ls_data=string(dwo.name)
ls_num=right(ls_data,2)
li_campo=integer(ls_num)
if li_campo=0 or isnull(li_campo) then
	ls_num=right(ls_data,1)
	li_campo=integer(ls_num)
	is_comp[li_campo].id_articolo=long(data)
end if
end event

