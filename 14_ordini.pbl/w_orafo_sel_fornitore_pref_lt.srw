forward
global type w_orafo_sel_fornitore_pref_lt from Window
end type
type cb_2 from commandbutton within w_orafo_sel_fornitore_pref_lt
end type
type cb_1 from commandbutton within w_orafo_sel_fornitore_pref_lt
end type
type dw_1 from datawindow within w_orafo_sel_fornitore_pref_lt
end type
end forward

global type w_orafo_sel_fornitore_pref_lt from Window
int X=836
int Y=372
int Width=1501
int Height=1351
boolean TitleBar=true
string Title="Fornitore preferito non trovato... seleziona nuovo"
long BackColor=79741120
boolean ControlMenu=true
WindowType WindowType=response!
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_orafo_sel_fornitore_pref_lt w_orafo_sel_fornitore_pref_lt

type variables
long il_id_articolo
long il_id_sog_com

end variables

on w_orafo_sel_fornitore_pref_lt.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={ this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_orafo_sel_fornitore_pref_lt.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;il_id_articolo=Message.DoubleParm
dw_1.settransobject(sqlca)
dw_1.retrieve()

end event

type cb_2 from commandbutton within w_orafo_sel_fornitore_pref_lt
int X=776
int Y=1127
int Width=342
int Height=84
int TabOrder=10
string Text="Annulla"
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;SetNull(il_id_sog_com)
closewithreturn(parent,il_id_sog_com)
end event

type cb_1 from commandbutton within w_orafo_sel_fornitore_pref_lt
int X=299
int Y=1127
int Width=289
int Height=84
int TabOrder=30
string Text="Ok"
boolean Default=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long row, ll_id_sog_com

row=dw_1.GetRow()
if row<>0 then
	il_id_sog_com=dw_1.getItemNumber(row,"id_sog_commerciale")
	update articolo
	set id_sog_commerciale=:il_id_sog_com
	where id_articolo=:il_id_articolo;
else
	SetNull(il_id_sog_com)
end if
closewithreturn(parent,il_id_sog_com)
end event

type dw_1 from datawindow within w_orafo_sel_fornitore_pref_lt
int X=40
int Y=29
int Width=1398
int Height=1057
int TabOrder=20
string DataObject="d_orafo_sel_fontitore_pref_lt"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

event doubleclicked;cb_1.TriggerEvent(clicked!)
end event

event clicked;this.SetRow(row)
end event

