forward
global type w_st_sottoscorta_gd from Window
end type
type dw_1 from datawindow within w_st_sottoscorta_gd
end type
type cb_8 from commandbutton within w_st_sottoscorta_gd
end type
type cb_2 from commandbutton within w_st_sottoscorta_gd
end type
type cb_7 from commandbutton within w_st_sottoscorta_gd
end type
type cb_6 from commandbutton within w_st_sottoscorta_gd
end type
type cb_5 from commandbutton within w_st_sottoscorta_gd
end type
type cb_4 from commandbutton within w_st_sottoscorta_gd
end type
type cb_3 from commandbutton within w_st_sottoscorta_gd
end type
type cb_1 from commandbutton within w_st_sottoscorta_gd
end type
end forward

global type w_st_sottoscorta_gd from Window
int X=5
int Y=364
int Width=3525
int Height=1940
boolean TitleBar=true
string Title="Stampa Sottoscorta"
long BackColor=79741120
boolean ControlMenu=true
WindowType WindowType=response!
event ue_post_open ( )
dw_1 dw_1
cb_8 cb_8
cb_2 cb_2
cb_7 cb_7
cb_6 cb_6
cb_5 cb_5
cb_4 cb_4
cb_3 cb_3
cb_1 cb_1
end type
global w_st_sottoscorta_gd w_st_sottoscorta_gd

type variables
long il_zoom
end variables

event ue_post_open;dw_1.Height=(this.Height) - 272


long ll_row

ll_row=dw_1.getrow()





end event

event open;long ll_anno, ll_mese,ll_giorno, ll_esercizio, ll_attivita, ll_locazione, ll_id_prof_doc, ll_magazzino, ll_id_art
string dw_filter, ls_esistenza, ls_a_art, ls_da_art
decimal ld_esi_fisica, ld_esi_fiscale, ld_disp
integer ll_row, i
str_sottoscorta str_param

setnull(ll_id_prof_doc)
dw_1.settransobject(sqlca)

str_param=message.PowerObjectParm

ls_a_art=str_param.a_articolo
ls_da_art=str_param.da_articolo
ll_anno=str_param.data_anno
ll_mese=str_param.data_mese
ll_giorno=str_param.data_giorno
ll_esercizio=str_param.id_esercizio
ll_attivita=str_param.id_attivita
ll_locazione=str_param.locazione

dw_1.SetTransObject(sqlca)
dw_1.Retrieve(ls_a_art, ls_da_art, ll_anno, ll_esercizio, ll_attivita, ll_mese, ll_giorno)

if ll_locazione>0 then
	dw_filter="id_locazione='"+string(ll_locazione)+"'"
	dw_1.setfilter(dw_filter)
	dw_1.filter()
	select id_magazzino
	into :ll_magazzino
	from locazione
	where id_locazione=:ll_locazione;
else
	ll_magazzino=0
end if	

ll_row=dw_1.getrow()
if ll_row>0 then
	for i=1 to ll_row 
   	ll_id_art=dw_1.getitemnumber(i,"id_articolo")

SELECT fn_esi_disp(1, :ll_id_art, :ll_magazzino, :ll_anno, :ll_mese, :ll_id_prof_doc) AS esistenza, CAST(SUBSTR(esistenza, 1, 20) AS NUMERIC(18,4)), CAST(SUBSTR(esistenza, 21, 20) AS NUMERIC(18,4)), CAST(SUBSTR(esistenza, 41, 20) AS NUMERIC(18,4))
	INTO	 :ls_esistenza, :ld_esi_fisica, :ld_esi_fiscale, :ld_disp
	FROM	 SYS.DUMMY
	;
	
	If SQLCA.SQLCODE = 100 Then
		Return
	ElseIf SQLCA.SQLCODE = -1 Then
		MessageBox("", SQLCA.SQLErrText)
		Return
	End if	
	dw_1.SetItem(ll_Row, "c_esistenza", ld_esi_fiscale)
	dw_1.SetItem(ll_Row, "c_esistenza_fisica", ld_esi_fisica)
	dw_1.SetItem(ll_row, "c_disponibilita", ld_disp)	
	next
end if


dw_filter="sum_sotto<=0"
dw_1.setfilter(dw_filter)
dw_1.filter()

end event

on w_st_sottoscorta_gd.create
this.dw_1=create dw_1
this.cb_8=create cb_8
this.cb_2=create cb_2
this.cb_7=create cb_7
this.cb_6=create cb_6
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_1=create cb_1
this.Control[]={this.dw_1,&
this.cb_8,&
this.cb_2,&
this.cb_7,&
this.cb_6,&
this.cb_5,&
this.cb_4,&
this.cb_3,&
this.cb_1}
end on

on w_st_sottoscorta_gd.destroy
destroy(this.dw_1)
destroy(this.cb_8)
destroy(this.cb_2)
destroy(this.cb_7)
destroy(this.cb_6)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_1)
end on

event key;

keycode			lk_code
string			ls_nome
windowobject	lw_me

lk_code = key

choose case lk_code
	case KeyF12!
		if keyflags=3 then
			ls_nome = this.ClassName()
			MessageBox ("ClassName",ls_nome)
		end if
	case KeyF1!
		if (keyflags = 0 Or keyflags = 1 Or keyflags = 2) then
		end if
end choose
end event

type dw_1 from datawindow within w_st_sottoscorta_gd
int X=23
int Y=152
int Width=3424
int Height=1564
int TabOrder=80
string DataObject="d_st_sottoscorta"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

type cb_8 from commandbutton within w_st_sottoscorta_gd
int X=2981
int Y=40
int Width=384
int Height=84
int TabOrder=70
string Text="Componi ordine"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_row

ll_row=dw_1.getrow()


openwithparm(w_ordina_scorta_cx,dw_1)








end event

type cb_2 from commandbutton within w_st_sottoscorta_gd
int X=2299
int Y=40
int Width=389
int Height=84
int TabOrder=40
string Text="Salva su &File"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.SaveAs()
end event

type cb_7 from commandbutton within w_st_sottoscorta_gd
event clicked pbm_bnclicked
int X=1655
int Y=40
int Width=251
int Height=84
int TabOrder=30
string Text="Zoom Out"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;il_zoom=il_zoom - 10
dw_1.object.datawindow.zoom=il_zoom
end event

type cb_6 from commandbutton within w_st_sottoscorta_gd
event clicked pbm_bnclicked
int X=1381
int Y=40
int Width=251
int Height=84
int TabOrder=50
string Text="Zoom In"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;il_zoom=il_zoom+10
dw_1.object.datawindow.zoom=il_zoom
end event

type cb_5 from commandbutton within w_st_sottoscorta_gd
int X=425
int Y=40
int Width=375
int Height=84
int TabOrder=60
string Text="Pag Precedente"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.ScrollPriorPage ( ) 
end event

type cb_4 from commandbutton within w_st_sottoscorta_gd
int X=837
int Y=40
int Width=375
int Height=84
int TabOrder=20
string Text="Pag Successiva"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.ScrollNextPage ( ) 
end event

type cb_3 from commandbutton within w_st_sottoscorta_gd
int X=2706
int Y=40
int Width=247
int Height=84
int TabOrder=10
string Text="Stam&pa"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;printsetup()
dw_1.print()
end event

type cb_1 from commandbutton within w_st_sottoscorta_gd
int X=23
int Y=40
int Width=247
int Height=84
int TabOrder=90
string Text="&Annulla"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(parent)
end event

