forward
global type w_stampa_bol_mag2_ff from Window
end type
type cbx_def from checkbox within w_stampa_bol_mag2_ff
end type
type cb_2 from commandbutton within w_stampa_bol_mag2_ff
end type
type cb_6 from commandbutton within w_stampa_bol_mag2_ff
end type
type cb_1 from commandbutton within w_stampa_bol_mag2_ff
end type
type cb_4 from commandbutton within w_stampa_bol_mag2_ff
end type
type cb_3 from commandbutton within w_stampa_bol_mag2_ff
end type
type cb_5 from commandbutton within w_stampa_bol_mag2_ff
end type
type dw_1 from datawindow within w_stampa_bol_mag2_ff
end type
end forward

global type w_stampa_bol_mag2_ff from Window
int X=1051
int Y=480
int Width=3753
int Height=2104
boolean TitleBar=true
string Title="Stampa Bollato Magazzino"
long BackColor=80133307
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
cbx_def cbx_def
cb_2 cb_2
cb_6 cb_6
cb_1 cb_1
cb_4 cb_4
cb_3 cb_3
cb_5 cb_5
dw_1 dw_1
end type
global w_stampa_bol_mag2_ff w_stampa_bol_mag2_ff

type variables
long il_zoom
string is_tipo
end variables

on w_stampa_bol_mag2_ff.create
this.cbx_def=create cbx_def
this.cb_2=create cb_2
this.cb_6=create cb_6
this.cb_1=create cb_1
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_5=create cb_5
this.dw_1=create dw_1
this.Control[]={this.cbx_def,&
this.cb_2,&
this.cb_6,&
this.cb_1,&
this.cb_4,&
this.cb_3,&
this.cb_5,&
this.dw_1}
end on

on w_stampa_bol_mag2_ff.destroy
destroy(this.cbx_def)
destroy(this.cb_2)
destroy(this.cb_6)
destroy(this.cb_1)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_5)
destroy(this.dw_1)
end on

event open;date da_data, a_data
string ls_tipo, ls_da_sog, ls_a_sog, ls_vis_pz
long i, ll_ultimo, ll_cont, ll_cont2, ll_prot

s_bol_mag str_parametri  

str_parametri=message.powerobjectparm
da_data   = str_parametri.da_data
a_data    = str_parametri.a_data
ls_tipo   = str_parametri.tipo
ls_da_sog = str_parametri.da_sog
ls_a_sog  = str_parametri.a_sog
ls_vis_pz = str_parametri.vis_pz

if ls_vis_pz='S' then 
	dw_1.dataobject='d_st_bol_mag2_pz'
	dw_1.settransobject(sqlca)
end if	

is_tipo = ls_tipo

if isnull(ls_da_sog) then ls_da_sog = " "
if isnull(ls_a_sog)  then ls_a_sog = "ZZZZZ"

dw_1.settransobject(sqlca)
dw_1.reset()

select cont_bol_mag, cont_bol_mag2
into :ll_cont, :ll_cont2
from par_sistema;
if isnull(ll_cont)  then ll_cont  = 0
if isnull(ll_cont2) then ll_cont2 = 0


if ls_tipo = 'C' then 
	ll_prot = ll_cont
else 
	ll_prot = ll_cont2
end if

dw_1.retrieve(ls_tipo, da_data, a_data, ls_da_sog, ls_a_sog, ll_prot)

il_zoom=100
end event

type cbx_def from checkbox within w_stampa_bol_mag2_ff
int X=1902
int Y=56
int Width=462
int Height=76
string Text="Stampa &Definitiva"
BorderStyle BorderStyle=StyleLowered!
boolean LeftText=true
long TextColor=33554432
long BackColor=80133307
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_2 from commandbutton within w_stampa_bol_mag2_ff
int X=3323
int Y=40
int Width=247
int Height=92
int TabOrder=60
string Text="Stampa"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_cont_bol, ll_totrows, ll_ultima

printsetup()
dw_1.print()

if cbx_def.checked = true then
   ll_totrows = dw_1.rowcount()
	ll_ultima = dw_1.getitemnumber(ll_totrows, "prot")
	
	if isnull(ll_ultima) then ll_ultima = 0
	if ll_ultima > 0 then
		if is_tipo = 'C' then
			update par_sistema
			set cont_bol_mag = :ll_ultima;
		else
			update par_sistema
			set cont_bol_mag2 = :ll_ultima;			
		end if
	end if
	
end if
end event

type cb_6 from commandbutton within w_stampa_bol_mag2_ff
int X=2953
int Y=40
int Width=297
int Height=92
int TabOrder=50
string Text="Zoom Out"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;il_zoom=il_zoom - 10
dw_1.object.datawindow.zoom=il_zoom


end event

type cb_1 from commandbutton within w_stampa_bol_mag2_ff
int X=2615
int Y=40
int Width=297
int Height=92
int TabOrder=40
string Text="Zoom In"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;il_zoom=il_zoom+10
dw_1.object.datawindow.zoom=il_zoom
end event

type cb_4 from commandbutton within w_stampa_bol_mag2_ff
int X=1161
int Y=40
int Width=466
int Height=92
int TabOrder=30
string Text="Pagina Successiva"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.ScrollNextPage ( ) 
end event

type cb_3 from commandbutton within w_stampa_bol_mag2_ff
int X=672
int Y=40
int Width=466
int Height=92
int TabOrder=20
string Text="Pagina Precedente"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.ScrollPriorPage ( ) 

end event

type cb_5 from commandbutton within w_stampa_bol_mag2_ff
int X=41
int Y=40
int Width=247
int Height=92
int TabOrder=10
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

type dw_1 from datawindow within w_stampa_bol_mag2_ff
int X=32
int Y=164
int Width=3643
int Height=1812
int TabOrder=70
string DataObject="d_st_bol_mag2"
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event retrievestart;return 2
end event

event retrieveend;
long ll_breakrow, i, ll_breakrow2, j

ll_breakrow = 0
i=1
DO WHILE NOT (ll_breakrow<0)
   ll_breakrow = dw_1.FindGroupChange(ll_breakrow, 1)
	ll_breakrow2 = dw_1.FindGroupChange(ll_breakrow+1, 1)
	IF ll_breakrow2 <= 0 THEN ll_breakrow2=dw_1.rowcount() +1
	
	IF ll_breakrow <= 0 THEN 
		EXIT
	else	
		for j=ll_breakrow to ll_breakrow2 - 1
			dw_1.setItem(j, "aa", i) 
		next	
	   i=i+1
   END IF
	
	ll_breakrow = ll_breakrow + 1
LOOP

end event

