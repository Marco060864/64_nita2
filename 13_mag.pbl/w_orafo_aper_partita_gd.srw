forward
global type w_orafo_aper_partita_gd from Window
end type
type tab_1 from tab within w_orafo_aper_partita_gd
end type
type tabpage_1 from userobject within tab_1
end type
type st_4 from statictext within tabpage_1
end type
type st_3 from statictext within tabpage_1
end type
type cb_7 from commandbutton within tabpage_1
end type
type sle_zoom from singlelineedit within tabpage_1
end type
type cb_zoom_out from commandbutton within tabpage_1
end type
type cb_zoom_in from commandbutton within tabpage_1
end type
type cb_preview_1 from commandbutton within tabpage_1
end type
type cb_stampa_1 from commandbutton within tabpage_1
end type
type cb_cerca from commandbutton within tabpage_1
end type
type cb_2 from commandbutton within tabpage_1
end type
type dw_single from datawindow within tabpage_1
end type
type dw_1 from datawindow within tabpage_1
end type
type cbx_mostra_chiuse from checkbox within tabpage_1
end type
type st_1 from statictext within tabpage_1
end type
type st_2 from statictext within tabpage_1
end type
type r_1 from rectangle within tabpage_1
end type
type tabpage_2 from userobject within tab_1
end type
type cb_8 from commandbutton within tabpage_2
end type
type cb_6 from commandbutton within tabpage_2
end type
type cb_cancella from commandbutton within tabpage_2
end type
type cb_5 from commandbutton within tabpage_2
end type
type cb_4 from commandbutton within tabpage_2
end type
type cb_salva from commandbutton within tabpage_2
end type
type st_21 from statictext within tabpage_2
end type
type st_11 from statictext within tabpage_2
end type
type dw_2 from datawindow within tabpage_2
end type
type dw_partite_errate from datawindow within tabpage_2
end type
type cb_1 from commandbutton within tabpage_2
end type
type tabpage_3 from userobject within tab_1
end type
type cb_3 from commandbutton within tabpage_3
end type
type dw_3 from datawindow within tabpage_3
end type
type tabpage_1 from userobject within tab_1
st_4 st_4
st_3 st_3
cb_7 cb_7
sle_zoom sle_zoom
cb_zoom_out cb_zoom_out
cb_zoom_in cb_zoom_in
cb_preview_1 cb_preview_1
cb_stampa_1 cb_stampa_1
cb_cerca cb_cerca
cb_2 cb_2
dw_single dw_single
dw_1 dw_1
cbx_mostra_chiuse cbx_mostra_chiuse
st_1 st_1
st_2 st_2
r_1 r_1
end type
type tabpage_2 from userobject within tab_1
cb_8 cb_8
cb_6 cb_6
cb_cancella cb_cancella
cb_5 cb_5
cb_4 cb_4
cb_salva cb_salva
st_21 st_21
st_11 st_11
dw_2 dw_2
dw_partite_errate dw_partite_errate
cb_1 cb_1
end type
type tabpage_3 from userobject within tab_1
cb_3 cb_3
dw_3 dw_3
end type
type tab_1 from tab within w_orafo_aper_partita_gd
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type
end forward

global type w_orafo_aper_partita_gd from Window
int X=5
int Y=48
int Width=2903
int Height=1784
boolean TitleBar=true
string Title="Gestione Partite Orafe"
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
tab_1 tab_1
end type
global w_orafo_aper_partita_gd w_orafo_aper_partita_gd

type variables
long ll_id_sog_com
end variables

event open;
long lung

tab_1.tabpage_1.dw_single.setTransObject(sqlca)
LL_ID_SOG_COM = message.DoubleParm	
if isNull(LL_ID_SOG_COM) or (LL_ID_SOG_COM<1) then
	
	tab_1.tabpage_1.dw_single.post retrieve(1, 2147483647) 
else
	tab_1.tabpage_1.dw_single.post retrieve(LL_ID_SOG_COM,LL_ID_SOG_COM)
end if
end event

on w_orafo_aper_partita_gd.create
this.tab_1=create tab_1
this.Control[]={this.tab_1}
end on

on w_orafo_aper_partita_gd.destroy
destroy(this.tab_1)
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
	
end choose

end event

type tab_1 from tab within w_orafo_aper_partita_gd
int X=23
int Y=32
int Width=2825
int Height=1632
int TabOrder=10
boolean RaggedRight=true
int SelectedTab=1
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
end on

event selectionchanged;string ls_filtro

if oldindex=2 and newindex=1 then
	tab_1.tabpage_2.visible = FALSE
end if

if newindex=3 then
	if isNull(LL_ID_SOG_COM) or (LL_ID_SOG_COM<1) then 
	
		tab_1.tabpage_3.dw_3.retrieve(1, 2147483647) 
	else
		tab_1.tabpage_3.dw_3.retrieve(LL_ID_SOG_COM,LL_ID_SOG_COM)
	end if
	ls_filtro=tab_1.tabpage_1.dw_single.object.datawindow.setfilter
	messagebox("W", ls_filtro)
end if

end event

type tabpage_1 from userobject within tab_1
int X=18
int Y=104
int Width=2789
int Height=1512
long BackColor=79741120
string Text="Partite Aperte"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
st_4 st_4
st_3 st_3
cb_7 cb_7
sle_zoom sle_zoom
cb_zoom_out cb_zoom_out
cb_zoom_in cb_zoom_in
cb_preview_1 cb_preview_1
cb_stampa_1 cb_stampa_1
cb_cerca cb_cerca
cb_2 cb_2
dw_single dw_single
dw_1 dw_1
cbx_mostra_chiuse cbx_mostra_chiuse
st_1 st_1
st_2 st_2
r_1 r_1
end type

on tabpage_1.create
this.st_4=create st_4
this.st_3=create st_3
this.cb_7=create cb_7
this.sle_zoom=create sle_zoom
this.cb_zoom_out=create cb_zoom_out
this.cb_zoom_in=create cb_zoom_in
this.cb_preview_1=create cb_preview_1
this.cb_stampa_1=create cb_stampa_1
this.cb_cerca=create cb_cerca
this.cb_2=create cb_2
this.dw_single=create dw_single
this.dw_1=create dw_1
this.cbx_mostra_chiuse=create cbx_mostra_chiuse
this.st_1=create st_1
this.st_2=create st_2
this.r_1=create r_1
this.Control[]={this.st_4,&
this.st_3,&
this.cb_7,&
this.sle_zoom,&
this.cb_zoom_out,&
this.cb_zoom_in,&
this.cb_preview_1,&
this.cb_stampa_1,&
this.cb_cerca,&
this.cb_2,&
this.dw_single,&
this.dw_1,&
this.cbx_mostra_chiuse,&
this.st_1,&
this.st_2,&
this.r_1}
end on

on tabpage_1.destroy
destroy(this.st_4)
destroy(this.st_3)
destroy(this.cb_7)
destroy(this.sle_zoom)
destroy(this.cb_zoom_out)
destroy(this.cb_zoom_in)
destroy(this.cb_preview_1)
destroy(this.cb_stampa_1)
destroy(this.cb_cerca)
destroy(this.cb_2)
destroy(this.dw_single)
destroy(this.dw_1)
destroy(this.cbx_mostra_chiuse)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.r_1)
end on

type st_4 from statictext within tabpage_1
int X=101
int Y=1208
int Width=517
int Height=76
boolean Enabled=false
string Text="Titolo Diverso"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within tabpage_1
int X=23
int Y=1136
int Width=247
int Height=76
boolean Enabled=false
string Text="Legenda:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_7 from commandbutton within tabpage_1
int X=2066
int Y=840
int Width=393
int Height=96
int TabOrder=50
string Text="Imposta Stampa"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;printsetup()

end event

type sle_zoom from singlelineedit within tabpage_1
int X=1289
int Y=844
int Width=288
int Height=88
int TabOrder=70
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_zoom_out from commandbutton within tabpage_1
int X=1161
int Y=840
int Width=123
int Height=96
int TabOrder=60
string Text="Out"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;integer li_zoom

dw_single.object.datawindow.print.preview='yes'
dw_single.object.datawindow.print.preview.rulers='yes'
li_zoom=integer(dw_single.describe("datawindow.zoom"))
if li_zoom>10 then 
	dw_single.object.datawindow.zoom= li_zoom - 10
	sle_zoom.text="Zoom: "+string(li_zoom - 10)
	cb_preview_1.text="Ritorna"
end if	
end event

type cb_zoom_in from commandbutton within tabpage_1
int X=1586
int Y=840
int Width=123
int Height=96
int TabOrder=100
string Text="In"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;integer li_zoom

dw_single.object.datawindow.print.preview='yes'
dw_single.object.datawindow.print.preview.rulers='yes'
li_zoom=integer(dw_single.describe("datawindow.zoom"))
dw_single.object.datawindow.zoom= li_zoom + 10
sle_zoom.text="Zoom: "+string(li_zoom+10)
cb_preview_1.text="Ritorna"
	
	
end event

type cb_preview_1 from commandbutton within tabpage_1
int X=1742
int Y=840
int Width=311
int Height=96
int TabOrder=90
string Text="Preview"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if dw_single.object.datawindow.print.preview='yes' then
	dw_single.object.datawindow.print.preview='no'
	text="Preview"
else
	dw_single.object.datawindow.print.preview='yes'
	dw_single.object.datawindow.print.preview.rulers='yes'
	text="Ritorna"
end if

end event

type cb_stampa_1 from commandbutton within tabpage_1
int X=2478
int Y=840
int Width=302
int Height=96
int TabOrder=70
string Text="Stampa"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;integer li_ret
if trim(sle_zoom.text)<>"" and trim(sle_zoom.text)<>"Zoom: 100" then
	li_ret=messagebox("Attenzione!", "La pagina sarà stampata alla percentuale di ~r~nriduzione/ingrandimento indicata dallo Zoom!"+&
	"~r~n Vuoi stampare con "+ sle_zoom.text+"?",information!, yesno! )
	if li_ret=1 then
		dw_single.print()
	end if
else
	dw_single.print()
end if

end event

type cb_cerca from commandbutton within tabpage_1
int X=23
int Y=840
int Width=370
int Height=96
int TabOrder=60
string Text="Cerca"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_id_partita
if this.text='Cerca' then
	
	dw_single.Object.DataWindow.Querymode='yes'
	dw_1.reset()
	this.text='Applica'
else
	
	dw_single.Object.DataWindow.QueryMode='no'
	this.text='Cerca'
	if ll_id_sog_com>0 then
		ll_id_partita=dw_single.retrieve(ll_id_sog_com, ll_id_sog_com)
	else
		ll_id_partita=dw_single.retrieve(0,2147483647)
	end if
	if ll_id_partita>0 then
		dw_single.selectRow(0,FALSE)
		dw_single.selectRow(1,TRUE)
		
		ll_id_partita = dw_single.getitemNumber(1,"orafo_aper_partita_id_partita")
		dw_1.settransObject(SQLCA)
		dw_1.retrieve(ll_id_partita)
	end if
end if
end event

type cb_2 from commandbutton within tabpage_1
int X=27
int Y=1396
int Width=370
int Height=108
int TabOrder=30
string Text="Verifica"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;open(w_orafo_password)
if Message.StringParm="OK" then
	tab_1.tabpage_2.dw_partite_errate.Reset()
	tab_1.tabpage_2.dw_2.reset()
	tab_1.tabpage_2.visible = TRUE
	tab_1.SelectTab(2)
end if

end event

type dw_single from datawindow within tabpage_1
event ue_key pbm_dwnkey
int Y=36
int Width=2779
int Height=792
int TabOrder=10
string DataObject="d_orafo_aper_partita_tutte_gd"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event ue_key;if key= keyenter! then
	if tab_1.tabpage_1.cb_cerca.text='Applica' then
		tab_1.tabpage_1.cb_cerca.triggerevent(clicked!)
	end if
end if
end event

event dw_single::getfocus;call super::getfocus;
end event

event rowfocuschanged;long ll_id_partita

if rowcount()>0 then
	if currentrow>0 and cb_cerca.Text='Cerca'   then
		dw_single.selectRow(0,FALSE)
		dw_single.selectRow(currentrow,TRUE)
		
		ll_id_partita = this.getitemNumber(currentrow,"orafo_aper_partita_id_partita")
		dw_1.settransObject(SQLCA)
		dw_1.retrieve(ll_id_partita)
	
	
	
	
		decimal {2} uno,due, ld_arr
		long ll_id_titolo
		
		
		ll_id_titolo=getitemnumber(currentrow, "orafo_aper_partita_id_titolo")
		select val_arrotondamento
		into :ld_arr
		from orafo_metallo m, orafo_titolo t
		where t.id_metallo=m.id_metallo
		and t.id_titolo=:ll_id_titolo;
		if isnull(ld_arr) then ld_arr=0
		
		uno =  this.getitemnumber(currentrow,"orafo_aper_partita_val_scarico") 
		if uno>0  and dw_1.rowcount()>0 then
			due =  dw_1.getitemnumber(1,"somma_scarico") 
			if abs(uno - due) > ld_arr then
				messagebox("Errore!","I valori degli scarichi sono incongruenti!")
			end if
		elseif (isnull(uno) or uno=0) and dw_1.rowcount()>0 then
			messagebox("Errore!","I valori degli scarichi sono incongruenti!")
		elseif uno>0 and dw_1.rowcount()<1 then
			messagebox("Errore!","I valori degli scarichi sono incongruenti!")
		end if
	end if
end if

end event

event sqlpreview;string ls_sql
integer li_ret

if not(cbx_mostra_chiuse.checked) then
	ls_sql=sqlsyntax +" AND ( orafo_aper_partita.stato = 'A') "
	setsqlpreview(ls_sql)
end if
end event

event clicked;if row=1    then
	trigger event rowfocuschanged(1)
end if
end event

event itemchanged;if cb_cerca.text='Cerca' then
	return 2
end if
end event

type dw_1 from datawindow within tabpage_1
int X=462
int Y=952
int Width=2222
int Height=548
int TabOrder=20
boolean BringToTop=true
string DataObject="d_scarico_partite"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

type cbx_mostra_chiuse from checkbox within tabpage_1
int X=453
int Y=844
int Width=713
int Height=76
boolean BringToTop=true
string Text="Mostra anche partite chiuse"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
if isNull(LL_ID_SOG_COM) or (LL_ID_SOG_COM<1) then 
	
	dw_single.retrieve(1, 2147483647) 
else
	dw_single.retrieve(LL_ID_SOG_COM,LL_ID_SOG_COM)
end if
end event

type st_1 from statictext within tabpage_1
int X=23
int Y=952
int Width=434
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Scarichi relativi alle"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within tabpage_1
int X=27

int Y=1020
int Width=411
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="partite selezionate"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type r_1 from rectangle within tabpage_1
int X=14
int Y=1212
int Width=50
int Height=52
boolean Enabled=false
int LineThickness=4
long LineColor=65535
long FillColor=65535
end type

type tabpage_2 from userobject within tab_1
int X=18
int Y=104
int Width=2789
int Height=1512
boolean Visible=false
long BackColor=79741120
string Text="Verifica"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
cb_8 cb_8
cb_6 cb_6
cb_cancella cb_cancella
cb_5 cb_5
cb_4 cb_4
cb_salva cb_salva
st_21 st_21
st_11 st_11
dw_2 dw_2
dw_partite_errate dw_partite_errate
cb_1 cb_1
end type

on tabpage_2.create
this.cb_8=create cb_8
this.cb_6=create cb_6
this.cb_cancella=create cb_cancella
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_salva=create cb_salva
this.st_21=create st_21
this.st_11=create st_11
this.dw_2=create dw_2
this.dw_partite_errate=create dw_partite_errate
this.cb_1=create cb_1
this.Control[]={this.cb_8,&
this.cb_6,&
this.cb_cancella,&
this.cb_5,&
this.cb_4,&
this.cb_salva,&
this.st_21,&
this.st_11,&
this.dw_2,&
this.dw_partite_errate,&
this.cb_1}
end on

on tabpage_2.destroy
destroy(this.cb_8)
destroy(this.cb_6)
destroy(this.cb_cancella)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cb_salva)
destroy(this.st_21)
destroy(this.st_11)
destroy(this.dw_2)
destroy(this.dw_partite_errate)
destroy(this.cb_1)
end on

type cb_8 from commandbutton within tabpage_2
int X=2290
int Y=124
int Width=338
int Height=108
int TabOrder=30
string Text="Cerca"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
if this.text='Cerca' then
	
	dw_partite_errate.Object.DataWindow.Querymode='yes'
	this.text='Applica'
else
	
	dw_partite_errate.Object.DataWindow.QueryMode='no'
	this.text='Cerca'
	if ll_id_sog_com>0 then
		dw_partite_errate.retrieve(ll_id_sog_com, ll_id_sog_com)
	else
		dw_partite_errate.retrieve(0,2147483647)
	end if
end if


end event

type cb_6 from commandbutton within tabpage_2
int X=178
int Y=1312
int Width=247
int Height=108
int TabOrder=40
string Text="Cancella"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;


int rtn
rtn = dw_2.DeleteRow(0)

IF rtn = 1 AND SQLCA.SQLNRows > 0 THEN
	messageBox("Alert","Cancellazione eseguita con successo!")

ELSE
	messageBox("Alert","Errore nella cancellazione")
END IF
end event

type cb_cancella from commandbutton within tabpage_2
int X=1792
int Y=124
int Width=338
int Height=108
int TabOrder=60
string Text="Cancella"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
int rtn
rtn = dw_partite_errate.DeleteRow(0)

IF rtn = 1 AND SQLCA.SQLNRows > 0 THEN
	messageBox("Alert","Cancellazione eseguita con successo!")

ELSE
	messageBox("Alert","Errore nella cancellazione")
END IF
end event

type cb_5 from commandbutton within tabpage_2
int X=105
int Y=124
int Width=375
int Height=108
int TabOrder=70
string Text="Copia"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
dw_partite_errate.setTransObject(sqlca)
if isNull(LL_ID_SOG_COM) or (LL_ID_SOG_COM<1) then 
	
	dw_partite_errate.retrieve(1, 2147483647) 
else
	dw_partite_errate.retrieve(LL_ID_SOG_COM,LL_ID_SOG_COM)
end if
end event

type cb_4 from commandbutton within tabpage_2
int X=178
int Y=1140
int Width=247
int Height=108
int TabOrder=40
string Text="Salva"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
int rtn
rtn = dw_2.Update()

IF rtn = 1 AND SQLCA.SQLNRows > 0 THEN
	messageBox("Alert","Salvataggio eseguito con successo!")

ELSE
	messageBox("Alert","Errore nel salvataggio")
END IF
end event

type cb_salva from commandbutton within tabpage_2
int X=1221
int Y=124
int Width=411
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

event clicked;
int rtn
rtn = dw_partite_errate.Update()

IF rtn = 1 AND SQLCA.SQLNRows > 0 THEN
	messageBox("Alert","Salvataggio eseguito con successo!")

ELSE
	messageBox("Alert","Errore nel salvataggio")
END IF
end event

type st_21 from statictext within tabpage_2
int X=105
int Y=1016
int Width=411
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="partite selezionate"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_11 from statictext within tabpage_2
int X=105
int Y=944
int Width=434
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Scarichi relativi alle"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_2 from datawindow within tabpage_2
int X=581
int Y=944
int Width=2085
int Height=540
int TabOrder=40
string DataObject="d_scarico_partite"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

type dw_partite_errate from datawindow within tabpage_2
int Y=284
int Width=2784
int Height=636
int TabOrder=50
string DataObject="d_orafo_aper_partita_tutte_gd"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event rowfocuschanged;long ll_id_partita

if currentrow>0 and cb_8.Text='Cerca' then
	dw_partite_errate.selectRow(0,FALSE)
	dw_partite_errate.selectRow(currentrow,TRUE)
ll_id_partita = this.getitemNumber(currentrow,"orafo_aper_partita_id_partita")

dw_2.settransObject(SQLCA)
dw_2.retrieve(ll_id_partita)



dec uno,due
uno =  this.getitemnumber(currentrow,"orafo_aper_partita_val_scarico") 
if uno>0  and dw_2.rowcount()>0 then
	due =  dw_2.getitemnumber(1,"somma_scarico") 
	if uno <> due then
		messagebox("Errore!","I valori degli scarichi sono incongruenti!")
	end if
elseif (isnull(uno) or uno=0) and dw_2.rowcount()>0 then
	messagebox("Errore!","I valori degli scarichi sono incongruenti!")
elseif uno>0 and dw_2.rowcount()<1 then
	messagebox("Errore!","I valori degli scarichi sono incongruenti!")
end if

end if
end event

event getfocus;call super::getfocus;
end event

type cb_1 from commandbutton within tabpage_2
int X=617
int Y=124
int Width=443
int Height=108
int TabOrder=40
string Text="Calcola"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_id_partita
integer i, Net, num_err
num_err = 0

Net = MessageBox("Result", "Questa operazione può richiedere alcuni minuti. ~n &
Vuoi continuare?", Exclamation!, OKCancel!, 2)
IF Net = 1 THEN


FOR i=1 TO tab_1.tabpage_1.dw_single.rowcount()
	
tab_1.tabpage_1.dw_single.selectRow(0,FALSE)
tab_1.tabpage_1.dw_single.selectRow(i,TRUE)
ll_id_partita = tab_1.tabpage_1.dw_single.getitemNumber(i,"orafo_aper_partita_id_partita")
tab_1.tabpage_1.dw_1.settransObject(SQLCA)
tab_1.tabpage_1.dw_1.retrieve(ll_id_partita)
decimal {2} uno,due
uno =  tab_1.tabpage_1.dw_single.getitemnumber(i,"orafo_aper_partita_val_scarico") 
if uno>0  and tab_1.tabpage_1.dw_1.rowcount()>0 then
	due =  tab_1.tabpage_1.dw_1.getitemnumber(1,"somma_scarico") 
	if uno <> due then
		
		 tab_1.tabpage_1.dw_single.RowsCopy(i,	i, Primary!, dw_partite_errate, 1, Primary!)
		num_err++
	end if
elseif (isnull(uno) or uno=0) and tab_1.tabpage_1.dw_1.rowcount()>0 then
	
	tab_1.tabpage_1.dw_single.RowsCopy(i,	i, Primary!, dw_partite_errate, 1, Primary!)
		num_err++
elseif uno>0 and tab_1.tabpage_1.dw_1.rowcount()<1 then
	
	tab_1.tabpage_1.dw_single.RowsCopy(i,	i, Primary!, dw_partite_errate, 1, Primary!)
		num_err++
end if


NEXT
if num_err=0 then
	messageBox("Alert", "Non è stato rilevato nessuno scarico incongruente")
end if
end if
end event

type tabpage_3 from userobject within tab_1
int X=18
int Y=104
int Width=2789
int Height=1512
boolean Visible=false
long BackColor=79741120
string Text="Stampa"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
cb_3 cb_3
dw_3 dw_3
end type

on tabpage_3.create
this.cb_3=create cb_3
this.dw_3=create dw_3
this.Control[]={this.cb_3,&
this.dw_3}
end on

on tabpage_3.destroy
destroy(this.cb_3)
destroy(this.dw_3)
end on

type cb_3 from commandbutton within tabpage_3
int X=1413
int Y=1460
int Width=247
int Height=108
int TabOrder=40
string Text="Stampa"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_3.Print(TRUE)
end event

type dw_3 from datawindow within tabpage_3
int X=18
int Y=28
int Width=3122
int Height=1392
int TabOrder=50
string DataObject="d_orafo_aper_partita_gd_st"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

