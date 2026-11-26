forward
global type w_orafo_st_caus_mov from Window
end type
type cb_stampa1 from commandbutton within w_orafo_st_caus_mov
end type
type cb_salva_su_file from commandbutton within w_orafo_st_caus_mov
end type
type cb_imp_st from commandbutton within w_orafo_st_caus_mov
end type
type cb_preview1 from commandbutton within w_orafo_st_caus_mov
end type
type sle_copie from singlelineedit within w_orafo_st_caus_mov
end type
type st_3 from statictext within w_orafo_st_caus_mov
end type
type st_2 from statictext within w_orafo_st_caus_mov
end type
type sle_pg from singlelineedit within w_orafo_st_caus_mov
end type
type cb_7 from commandbutton within w_orafo_st_caus_mov
end type
type sle_zoom from singlelineedit within w_orafo_st_caus_mov
end type
type cb_6 from commandbutton within w_orafo_st_caus_mov
end type
type cb_pg_dopo from commandbutton within w_orafo_st_caus_mov
end type
type cb_pg_prima from commandbutton within w_orafo_st_caus_mov
end type
type dw_1 from datawindow within w_orafo_st_caus_mov
end type
type cb_5 from commandbutton within w_orafo_st_caus_mov
end type
type cb_canc_sog from commandbutton within w_orafo_st_caus_mov
end type
type dw_sog_stampa from u_dw_ext_main within w_orafo_st_caus_mov
end type
type dw_data from u_dw_ext_main within w_orafo_st_caus_mov
end type
type cb_4 from commandbutton within w_orafo_st_caus_mov
end type
type st_1 from statictext within w_orafo_st_caus_mov
end type
type sle_configurazione from singlelineedit within w_orafo_st_caus_mov
end type
type cb_preview from commandbutton within w_orafo_st_caus_mov
end type
type dw_salva_conf from datawindow within w_orafo_st_caus_mov
end type
type cb_salva_conf from commandbutton within w_orafo_st_caus_mov
end type
type cb_stampa from commandbutton within w_orafo_st_caus_mov
end type
type cb_2 from commandbutton within w_orafo_st_caus_mov
end type
type cb_1 from commandbutton within w_orafo_st_caus_mov
end type
type dw_caus_scarico from datawindow within w_orafo_st_caus_mov
end type
type dw_caus_carico from datawindow within w_orafo_st_caus_mov
end type
type dw_causali from datawindow within w_orafo_st_caus_mov
end type
type dw_stampa_scarico from datawindow within w_orafo_st_caus_mov
end type
type dw_stampa_carico from datawindow within w_orafo_st_caus_mov
end type
type gb_1 from groupbox within w_orafo_st_caus_mov
end type
end forward

global type w_orafo_st_caus_mov from Window
int X=5
int Y=64
int Width=3689
int Height=2136
boolean TitleBar=true
string Title="Stampa parametrica"
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
cb_stampa1 cb_stampa1
cb_salva_su_file cb_salva_su_file
cb_imp_st cb_imp_st
cb_preview1 cb_preview1
sle_copie sle_copie
st_3 st_3
st_2 st_2
sle_pg sle_pg
cb_7 cb_7
sle_zoom sle_zoom
cb_6 cb_6
cb_pg_dopo cb_pg_dopo
cb_pg_prima cb_pg_prima
dw_1 dw_1
cb_5 cb_5
cb_canc_sog cb_canc_sog
dw_sog_stampa dw_sog_stampa
dw_data dw_data
cb_4 cb_4
st_1 st_1
sle_configurazione sle_configurazione
cb_preview cb_preview
dw_salva_conf dw_salva_conf
cb_salva_conf cb_salva_conf
cb_stampa cb_stampa
cb_2 cb_2
cb_1 cb_1
dw_caus_scarico dw_caus_scarico
dw_caus_carico dw_caus_carico
dw_causali dw_causali
dw_stampa_scarico dw_stampa_scarico
dw_stampa_carico dw_stampa_carico
gb_1 gb_1
end type
global w_orafo_st_caus_mov w_orafo_st_caus_mov

type variables
string is_sql_caus_car, is_sql_caus_scar
integer ii_zoom=100
end variables

forward prototypes
public subroutine wf_stampa (datawindow dw_caus, datawindow dw_stampa)
public subroutine wf_allinea_dw_stampa (datawindow dw_stampa_2, datawindow dw_stampa)
public subroutine wf_salva_conf (string ls_codice)
end prototypes

public subroutine wf_stampa (datawindow dw_caus, datawindow dw_stampa);string ls_sql, ls_data_da, ls_data_a, ls_filtro
string ls_legato_fino, ls_tot_doc, ls_solo_preziosi, ls_a_data
integer li_pos_and, i
long ll_id_caus_mag, ll_id_sog,ll_righe
date ldt_da_data, ldt_a_data

dw_1.accepttext()

ls_sql=dw_stampa.getsqlselect()
li_pos_and=pos(ls_sql, "and (riga_documento.id_caus_magazzino=")
if li_pos_and>0 then
ls_sql=left(ls_sql, li_pos_and - 1)
end if
if dw_caus.rowcount()<1 then return
for i = 1 to dw_caus.rowcount()
	ll_id_caus_mag=dw_caus.getitemnumber(i, "caus_magazzino_id_caus_magazzino")
	if i=1 then
		ls_sql= ls_sql+" and (riga_documento.id_caus_magazzino="+string(ll_id_caus_mag)
	else
		ls_sql= ls_sql+" or riga_documento.id_caus_magazzino="+string(ll_id_caus_mag)
	end if
	if i=dw_caus.rowcount() then
		ls_sql= ls_sql+")"
	end if
next
ldt_da_data=dw_data.getitemdate(1, "da_data")
ldt_a_data=dw_data.getitemdate(1, "a_data")
if not isnull(ldt_da_data) then
	ls_data_da=string(ldt_da_data, 'yy/mm/dd')
	ls_sql=ls_sql+" and dateformat(documento.data_documento, 'yy/mm/dd') >='" + ls_data_da+"'"
	if not isnull(ldt_a_data) then
		ls_data_a=string(ldt_a_data, 'yy/mm/dd')
		ls_sql=ls_sql+" and dateformat(documento.data_documento, 'yy/mm/dd') <='" + ls_data_a+"'"
	end if
end if
ll_id_sog=dw_sog_stampa.getitemnumber(1, "id_sog_commerciale")
if ll_id_sog>0 then
	ls_sql=ls_sql+" and (documento.id_sog_commerciale="+string(ll_id_sog)+")"
else
end if
	
	
li_pos_and=dw_stampa.setsqlselect(ls_sql)
if li_pos_and=1 then
	
	if isnull(ldt_a_data) then
		ls_a_data='--'
	else
		ls_a_data=string(ldt_a_data)
	end if
	ls_filtro="Filtri applicati: da data: "+string(ldt_da_data)+ " a data: "+ls_a_data
	ll_righe=dw_caus_carico.rowcount()
	if ll_righe >0 then ls_filtro= ls_filtro + "~r~nCausali scelte: "
	for i = 1 to ll_righe
		ls_sql=dw_caus_carico.getitemstring(i, "caus_magazzino_codice")
		ls_filtro=ls_filtro+ls_sql+ " - " 
	
	next
	
	ll_id_sog=dw_1.getrow()
	if ll_id_sog>0 then
		ls_solo_preziosi=dw_1.getitemstring(ll_id_sog, "solo_preziosi")
		ls_tot_doc=dw_1.getitemstring(ll_id_sog, "tot_doc")
		ls_legato_fino =dw_1.getitemstring(ll_id_sog, "legato_fino")
		ll_id_sog=dw_1.getitemnumber(ll_id_sog, "magazzino")
	end if
	if isnull(ls_solo_preziosi) then ls_solo_preziosi='N'
	if isnull(ls_tot_doc) then ls_tot_doc='N'
	if isnull(ls_legato_fino) then ls_legato_fino='L'
	if isnull(ll_id_sog) then ll_id_sog=0
	dw_stampa.retrieve(ldt_da_data,ldt_a_data, ls_filtro, ls_tot_doc ,ls_legato_fino,ls_solo_preziosi, ll_id_sog)
else
	messagebox("Errore", "Filtro non applicato")
end if
end subroutine

public subroutine wf_allinea_dw_stampa (datawindow dw_stampa_2, datawindow dw_stampa);
end subroutine

public subroutine wf_salva_conf (string ls_codice);
integer i,  li_ret
long ll_id_caus, ll_id_codice, ll_id_sog_com, ll_riga_da_salvare, ll_riga
date ldt_da_data, ldt_a_data

datastore ds_salva_righe
ds_salva_righe=create datastore
ds_salva_righe.dataobject="ds_salva_configurazione"
ds_salva_righe.settransobject(sqlca)
ds_salva_righe.retrieve()

ll_riga=dw_salva_conf.rowcount()
if ll_riga>0 then
	ll_riga_da_salvare=dw_salva_conf.find("codice='"+ls_codice+"'", 1,ll_riga )
	if ll_riga_da_salvare>0 then
		ll_id_codice=dw_salva_conf.getitemnumber(ll_riga_da_salvare, "id_codice")
		i=messagebox("Attenzione!", "Codice esistente: sovrascriverlo?", stopsign!, yesno!)
		if i=1 then
			i=ds_salva_righe.find("id_codice="+string(ll_id_codice), 1, ds_salva_righe.rowcount())
			do while i > 0
				ds_salva_righe.deleterow(i)
				i=ds_salva_righe.find("id_codice="+string(ll_id_codice), 1,ds_salva_righe.rowcount())
			loop
			
		else
			
			setfocus(sle_configurazione)
			return
		end if
	else
		ll_riga_da_salvare=dw_salva_conf.insertrow(0)
	end if
else
	ll_riga_da_salvare=dw_salva_conf.insertrow(0)
end if

li_ret=ds_salva_righe.update()
if li_ret<>1 then 
	messagebox("Errore!", "Cancellazione righe non effettuata!")
	return
end if
dw_salva_conf.setitem(ll_riga_da_salvare, "codice", ls_codice)
ldt_da_data=dw_data.getitemdate(1, "da_data")
ldt_a_data=dw_data.getitemdate(1, "a_data")
ll_id_sog_com=dw_sog_stampa.getitemnumber(1, "id_sog_commerciale")
if not isnull(ldt_da_data) then
	dw_salva_conf.setitem(ll_riga_da_salvare, "da_data", ldt_da_data)
	if not isnull(ldt_a_data) then
		dw_salva_conf.setitem(ll_riga_da_salvare, "a_data", ldt_a_data)
	end if
end if
dw_salva_conf.setitem(ll_riga_da_salvare, "id_sog_commerciale", ll_id_sog_com)
li_ret=dw_salva_conf.update()

if li_ret<>1 then 
	messagebox("Errore!", "Salvataggio Testa non effettuato!")
	return
end if
ll_id_codice=dw_salva_conf.getitemnumber(ll_riga_da_salvare, "id_codice")
for i = 1 to dw_caus_carico.rowcount()
	ll_id_caus=dw_caus_carico.getitemnumber(i, "caus_magazzino_id_caus_magazzino")
	ds_salva_righe.insertrow(1)
	ds_salva_righe.setitem(1, "id_caus_magazzino", ll_id_caus)
	ds_salva_righe.setitem(1, "carico_scarico", "C")
	ds_salva_righe.setitem(1, "id_codice", ll_id_codice)
next

li_ret=ds_salva_righe.update()
if li_ret<>1 then 
	messagebox("Errore!", "Configurazione non salvata!")
else
	
end if
destroy ds_salva_righe

end subroutine

on w_orafo_st_caus_mov.create
this.cb_stampa1=create cb_stampa1
this.cb_salva_su_file=create cb_salva_su_file
this.cb_imp_st=create cb_imp_st
this.cb_preview1=create cb_preview1
this.sle_copie=create sle_copie
this.st_3=create st_3
this.st_2=create st_2
this.sle_pg=create sle_pg
this.cb_7=create cb_7
this.sle_zoom=create sle_zoom
this.cb_6=create cb_6
this.cb_pg_dopo=create cb_pg_dopo
this.cb_pg_prima=create cb_pg_prima
this.dw_1=create dw_1
this.cb_5=create cb_5
this.cb_canc_sog=create cb_canc_sog
this.dw_sog_stampa=create dw_sog_stampa
this.dw_data=create dw_data
this.cb_4=create cb_4
this.st_1=create st_1
this.sle_configurazione=create sle_configurazione
this.cb_preview=create cb_preview
this.dw_salva_conf=create dw_salva_conf
this.cb_salva_conf=create cb_salva_conf
this.cb_stampa=create cb_stampa
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_caus_scarico=create dw_caus_scarico
this.dw_caus_carico=create dw_caus_carico
this.dw_causali=create dw_causali
this.dw_stampa_scarico=create dw_stampa_scarico
this.dw_stampa_carico=create dw_stampa_carico
this.gb_1=create gb_1
this.Control[]={this.cb_stampa1,&
this.cb_salva_su_file,&
this.cb_imp_st,&
this.cb_preview1,&
this.sle_copie,&
this.st_3,&
this.st_2,&
this.sle_pg,&
this.cb_7,&
this.sle_zoom,&
this.cb_6,&
this.cb_pg_dopo,&
this.cb_pg_prima,&
this.dw_1,&
this.cb_5,&
this.cb_canc_sog,&
this.dw_sog_stampa,&
this.dw_data,&
this.cb_4,&
this.st_1,&
this.sle_configurazione,&
this.cb_preview,&
this.dw_salva_conf,&
this.cb_salva_conf,&
this.cb_stampa,&
this.cb_2,&
this.cb_1,&
this.dw_caus_scarico,&
this.dw_caus_carico,&
this.dw_causali,&
this.dw_stampa_scarico,&
this.dw_stampa_carico,&
this.gb_1}
end on

on w_orafo_st_caus_mov.destroy
destroy(this.cb_stampa1)
destroy(this.cb_salva_su_file)
destroy(this.cb_imp_st)
destroy(this.cb_preview1)
destroy(this.sle_copie)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.sle_pg)
destroy(this.cb_7)
destroy(this.sle_zoom)
destroy(this.cb_6)
destroy(this.cb_pg_dopo)
destroy(this.cb_pg_prima)
destroy(this.dw_1)
destroy(this.cb_5)
destroy(this.cb_canc_sog)
destroy(this.dw_sog_stampa)
destroy(this.dw_data)
destroy(this.cb_4)
destroy(this.st_1)
destroy(this.sle_configurazione)
destroy(this.cb_preview)
destroy(this.dw_salva_conf)
destroy(this.cb_salva_conf)
destroy(this.cb_stampa)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_caus_scarico)
destroy(this.dw_caus_carico)
destroy(this.dw_causali)
destroy(this.dw_stampa_scarico)
destroy(this.dw_stampa_carico)
destroy(this.gb_1)
end on

event open;datawindowchild ldw_maga
String ls_par 


dw_1.getchild("magazzino",ldw_maga)
ldw_maga.settransobject(sqlca)
ldw_maga.retrieve()

s_list_main s_list
s_list=message.powerobjectparm
if isvalid(s_list) then
	if s_list.s_win_parametri='C' then
		dw_stampa_carico.dataobject='d_orafo_stampa_par_causale'
		dw_stampa_scarico.dataobject='d_orafo_stampa_par_causale'
	end if
end if


dw_caus_carico.settransobject(sqlca)
dw_caus_scarico.settransobject(sqlca)
dw_causali.settransobject(sqlca)
dw_stampa_carico.settransobject(sqlca)
dw_stampa_scarico.settransobject(sqlca)
dw_causali.post retrieve()


dw_data.insertrow(1)
date ldt_da_data
string ls_anno
ls_anno=string(year(today()))
ls_anno='01/01/'+ls_anno
ldt_da_data= date(ls_anno)
dw_data.setitem(1, "da_data", ldt_da_data)
dw_data.setitem(1, "a_data",today())


dw_sog_stampa.insertrow(1)



dw_salva_conf.settransobject(sqlca)
dw_salva_conf.retrieve()
dw_salva_conf.ShareData ( dw_1 )
end event

event show;is_sql_caus_car=dw_caus_carico.getsqlselect()
is_sql_caus_scar=dw_caus_scarico.getsqlselect()
end event

type cb_stampa1 from commandbutton within w_orafo_st_caus_mov
int X=3374
int Y=844
int Width=261
int Height=88
int TabOrder=210
string Text="&Stampa"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;printsetup()
dw_stampa_carico.print()
end event

type cb_salva_su_file from commandbutton within w_orafo_st_caus_mov
int X=2880
int Y=848
int Width=320
int Height=88
int TabOrder=200
string Text="Salva su &File"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_stampa_carico.SaveAs()
end event

type cb_imp_st from commandbutton within w_orafo_st_caus_mov
int X=3337
int Y=724
int Width=297
int Height=88
int TabOrder=190
string Text="Imp. Stamp."
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;printsetup()
dw_stampa_carico.object.datawindow.print.preview='yes'
dw_stampa_carico.object.datawindow.print.preview.rulers='yes'
end event

type cb_preview1 from commandbutton within w_orafo_st_caus_mov
int X=3369
int Y=612
int Width=261
int Height=88
int TabOrder=180
string Text="Preview"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if cb_preview1.text='Preview' then
	cb_preview1.text='Ritorna'
	dw_stampa_carico.object.datawindow.print.preview='yes'
dw_stampa_carico.object.datawindow.print.preview.rulers='yes'
else
	cb_preview1.text='Preview'
	dw_stampa_carico.object.datawindow.print.preview='no'
dw_stampa_carico.object.datawindow.print.preview.rulers='no'
end if
end event

type sle_copie from singlelineedit within w_orafo_st_caus_mov
int X=3109
int Y=636
int Width=206
int Height=92
int TabOrder=170
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

type st_3 from statictext within w_orafo_st_caus_mov
int X=3131
int Y=584
int Width=151
int Height=76
boolean Enabled=false
string Text="Copie:"
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

type st_2 from statictext within w_orafo_st_caus_mov
int X=3246
int Y=400
int Width=270
int Height=76
boolean Enabled=false
string Text="Stampa Pg.:"
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

type sle_pg from singlelineedit within w_orafo_st_caus_mov
int X=3136
int Y=476
int Width=503
int Height=92
int TabOrder=160
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_7 from commandbutton within w_orafo_st_caus_mov
int X=2734
int Y=848
int Width=128
int Height=88
int TabOrder=140
string Text="Out"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;ii_zoom=ii_zoom - 5
dw_stampa_carico.object.datawindow.zoom=ii_zoom
sle_zoom.text=string(ii_zoom)
end event

type sle_zoom from singlelineedit within w_orafo_st_caus_mov
int X=2583
int Y=844
int Width=146
int Height=92
int TabOrder=150
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
string Text="100"
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;ii_zoom=integer(this.text)
dw_stampa_carico.object.datawindow.zoom=ii_zoom

end event

type cb_6 from commandbutton within w_orafo_st_caus_mov
int X=2478
int Y=848
int Width=101
int Height=88
int TabOrder=130
string Text="In"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;ii_zoom=ii_zoom+5
dw_stampa_carico.object.datawindow.zoom=ii_zoom
sle_zoom.text=string(ii_zoom)
end event

type cb_pg_dopo from commandbutton within w_orafo_st_caus_mov
int X=2359
int Y=848
int Width=91
int Height=88
int TabOrder=120
string Text=">"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_stampa_carico.ScrollNextPage ( ) 
end event

type cb_pg_prima from commandbutton within w_orafo_st_caus_mov
int X=2245
int Y=848
int Width=91
int Height=88
int TabOrder=110
string Text="<"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_stampa_carico.ScrollPriorPage ( ) 
end event

type dw_1 from datawindow within w_orafo_st_caus_mov
int X=2245
int Y=412
int Width=859
int Height=392
int TabOrder=50
string DataObject="d_sel_tikal"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

type cb_5 from commandbutton within w_orafo_st_caus_mov
int X=2953
int Y=252
int Width=247
int Height=108
int TabOrder=90
string Text="Cancella"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
integer li_message
long ll_row
li_message=messagebox("Cancellazione"," Continuare la cancellazione", Exclamation!,Okcancel!,2)
if li_message= 1 then
      ll_row = dw_salva_conf.getrow()
      if ll_row > 0 then
         	dw_salva_conf.deleterow(ll_row)
	         dw_salva_conf.update()
	         dw_salva_conf.retrieve()
            dw_caus_carico.reset()
            dw_caus_scarico.reset()
            dw_stampa_carico.reset()
            dw_stampa_scarico.reset()
				sle_configurazione.text=" "
      end if
else
	return 0
end if
end event

type cb_canc_sog from commandbutton within w_orafo_st_caus_mov
int X=713
int Y=104
int Width=503
int Height=108
int TabOrder=100
string Text="Cancella Sog. Comm."
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_sog_stampa.reset()
dw_sog_stampa.insertrow(1)
wf_stampa(dw_caus_carico, dw_stampa_carico)
wf_stampa(dw_caus_scarico, dw_stampa_scarico)
wf_allinea_dw_stampa(dw_stampa_scarico, dw_stampa_carico)

wf_allinea_dw_stampa(dw_stampa_carico, dw_stampa_scarico)

end event

type dw_sog_stampa from u_dw_ext_main within w_orafo_st_caus_mov
int X=9
int Y=228
int Width=1207
int Height=168
int TabOrder=70
string DataObject="d_orafo_sog_st_par"
end type

event ue_set_search;call super::ue_set_search;
CHOOSE CASE as_nomecol
	
CASE "codice"
		is_search_window = "w_sog_commerciale_gen_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "codice"
end  choose
end event

event ue_use_search;call super::ue_use_search;CHOOSE CASE as_nomecol
	
	CASE "codice"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		
		uf_set_colval("id_sog_commerciale", is_ricpar.s_id_seg_value[1])
		uf_set_colval("rag_soc_1", is_ricpar.s_ausil_value[1])
			
			wf_stampa(dw_caus_carico, dw_stampa_carico)
			wf_stampa(dw_caus_scarico, dw_stampa_scarico)
			wf_allinea_dw_stampa(dw_stampa_scarico, dw_stampa_carico)
			
			wf_allinea_dw_stampa(dw_stampa_carico, dw_stampa_scarico)
end choose




end event

type dw_data from u_dw_ext_main within w_orafo_st_caus_mov
int X=9
int Y=28
int Width=690
int Height=184
int TabOrder=220
string DataObject="d_da_data_a_data"
end type

event itemchanged;date ldt_da_data
string ls_anno
if dwo.name='da_data' then
	if isnull(data) or data<=' ' then
		ls_anno=string(year(today()))
		ls_anno='01/01/'+ls_anno
		ldt_da_data= date(ls_anno)
		messagebox("Attenzione!", "La data di inizio è OBBLIGATORIA!")
		post setitem(1, "da_data", ldt_da_data)
		post setcolumn('da_data')
		return 1
	end if
end if
end event

type cb_4 from commandbutton within w_orafo_st_caus_mov
int X=2679
int Y=252
int Width=247
int Height=108
int TabOrder=80
string Text="Applica"
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string ls_tipo_stampa
if dw_1.getrow()>0 then
	ls_tipo_stampa=dw_1.getitemstring(1, "legato_fino")
	if ls_tipo_stampa="S" then
		dw_stampa_carico.dataobject="d_data_caus_tikal_ok_tb"
	else
		dw_stampa_carico.dataobject="d_data_tot_doc_caus_tb"
	end if
else
	dw_stampa_carico.dataobject="d_data_tot_doc_caus_tb"
end if
dw_stampa_carico.settransobject(sqlca)


wf_stampa(dw_caus_carico, dw_stampa_carico)


end event

type st_1 from statictext within w_orafo_st_caus_mov
int X=2400
int Y=72
int Width=1093
int Height=64
boolean Enabled=false
string Text="Inserisci codice della configurazione da salvare:"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_configurazione from singlelineedit within w_orafo_st_caus_mov
int X=2400
int Y=136
int Width=1010
int Height=92
int TabOrder=230
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_preview from commandbutton within w_orafo_st_caus_mov
int X=2405
int Y=252
int Width=247
int Height=108
int TabOrder=240
string Text="Preview"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
string ls_sql_carico, ls_sql_scarico, ls_car_scar, ls_codice, ls_cod, ls_rag_1
long ll_id_caus, ll_id_codice,ll_id_sog_com,ll_riga_corrente
integer li_pos_and, i=0, a=0
date ldt_da_data, ldt_a_data


ls_sql_carico=dw_caus_carico.getsqlselect()
ls_sql_scarico=dw_caus_scarico.getsqlselect()

dw_caus_carico.reset()
dw_caus_scarico.reset()
dw_stampa_carico.reset()
dw_stampa_scarico.reset()

ll_riga_corrente=dw_salva_conf.getrow()

if ll_riga_corrente<=0 then return

ll_id_codice=dw_salva_conf.getitemnumber(ll_riga_corrente, "id_codice")
declare recupera_config  cursor for
select id_caus_magazzino, carico_scarico
from orafo_stampa_par_righe
where id_codice=:ll_id_codice;



li_pos_and=pos(ls_sql_carico, "where")
if li_pos_and>0 then
	ls_sql_carico=left(ls_sql_carico, li_pos_and - 1)
end if
li_pos_and=pos(ls_sql_scarico, "where")
if li_pos_and>0 then
	ls_sql_scarico=left(ls_sql_scarico, li_pos_and - 1)
end if
open recupera_config;
do while sqlca.sqlcode=0  
	fetch recupera_config into :ll_id_caus, :ls_car_scar;
	if sqlca.sqlcode=0 then
		if ls_car_scar="C" then
			i++
			if i=1 then
				ls_sql_carico= ls_sql_carico+" where caus_magazzino.id_caus_magazzino="+string(ll_id_caus)
			else
				ls_sql_carico= ls_sql_carico+" or caus_magazzino.id_caus_magazzino="+string(ll_id_caus)
			end if
		else
			a++
			if a=1 then
				ls_sql_scarico= ls_sql_scarico+" where caus_magazzino.id_caus_magazzino="+string(ll_id_caus)
			else
				ls_sql_scarico= ls_sql_scarico+" or caus_magazzino.id_caus_magazzino="+string(ll_id_caus)
			end if
		end if
	end if
	li_pos_and=dw_causali.find("caus_magazzino_id_caus_magazzino="+string(ll_id_caus), 1,dw_causali.rowcount())
	if li_pos_and>0 then
		dw_causali.deleterow(li_pos_and)
	end if
loop
close recupera_config;
if i>0 then 
	
	dw_caus_carico.setsqlselect(ls_sql_carico)
	dw_caus_carico.retrieve()
end if
if a>0 then 
	
	dw_caus_scarico.setsqlselect(ls_sql_scarico)
	dw_caus_scarico.retrieve()
end if

select da_data, a_data, id_sog_commerciale
into :ldt_da_data, :ldt_a_data, :ll_id_sog_com
from orafo_stampa_parametrica
where id_codice=:ll_id_codice;
if sqlca.sqlcode=0 then
	dw_data.setitem(1, "da_data", ldt_da_data)
	if isnull(ldt_a_data) then ldt_a_data=today()
	dw_data.setitem(1, "a_data", ldt_a_data)
	if isnull(ll_id_sog_com) then
		
		dw_sog_stampa.reset()
		dw_sog_stampa.insertrow(1)
	else
		select codice, rag_soc_1
		into :ls_cod, :ls_rag_1
		from sog_commerciale_gen
		where id_sog_commerciale=:ll_id_sog_com;
		if sqlca.sqlcode=0 then
			dw_sog_stampa.setitem(1, "id_sog_commerciale", ll_id_sog_com)
			dw_sog_stampa.setitem(1, "codice", ls_cod)
			dw_sog_stampa.setitem(1, "rag_soc_1", ls_rag_1)
		else
			
		end if
	end if
else
	Messagebox("Attenzione!", "Periodo di riferimento non trovato!")
end if



end event

type dw_salva_conf from datawindow within w_orafo_st_caus_mov
int X=1253
int Y=80
int Width=1129
int Height=284
int TabOrder=290
string DataObject="d_gruppo_config"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event rowfocuschanged;SetrowFOCUSINDICATOR(HAND!)
dw_1.scrolltorow(currentrow)
end event

type cb_salva_conf from commandbutton within w_orafo_st_caus_mov
int X=3433
int Y=136
int Width=169
int Height=96
int TabOrder=60
string Text="Salva"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string ls_codice
integer li_ret
dw_1.accepttext()
if sle_configurazione.text<>"" or not(isnull(sle_configurazione.text)) then
	ls_codice=trim(sle_configurazione.text)
	wf_salva_conf(ls_codice)
else
	messagebox("Attenzione!", "Specificare il nome della configurazione!")
end if
end event

type cb_stampa from commandbutton within w_orafo_st_caus_mov
int X=2350
int Y=596
int Width=233
int Height=108
int TabOrder=250
string Text="Stampa"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string ls_sql[2]

s_stampa s_dati_stampa
if dw_stampa_carico.dataobject='d_orafo_stampa_par_causale' then
	s_dati_stampa.s_tit_caus='C'
end if
s_dati_stampa.dw_s_carico=dw_stampa_carico
s_dati_stampa.dw_s_scarico=dw_stampa_scarico
s_dati_stampa.dw_caus_car=dw_caus_carico
s_dati_stampa.dw_caus_scar=dw_caus_scarico
openwithparm(w_orafo_stampa_preview, s_dati_stampa)
end event

type cb_2 from commandbutton within w_orafo_st_caus_mov
int X=2405
int Y=664
int Width=233
int Height=108
int TabOrder=260
string Text="< Resetta"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_caus_scarico.rowsmove(1, dw_caus_scarico.rowcount(), primary!, dw_causali, 1, primary!)
dw_stampa_scarico.reset()


dw_caus_scarico.setsqlselect(is_sql_caus_scar)
end event

type cb_1 from commandbutton within w_orafo_st_caus_mov
int X=1051
int Y=584
int Width=123
int Height=108
int TabOrder=30
string Text=">>"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_caus_carico.rowsmove(1, dw_caus_carico.rowcount(), primary!, dw_causali, 1, primary!)
dw_stampa_carico.reset()
end event

type dw_caus_scarico from datawindow within w_orafo_st_caus_mov
int X=2386
int Y=444
int Width=174
int Height=136
int TabOrder=40
string DragIcon="S:\pb\commonframework\cometa.ico"
string DataObject="d_caus_mag_formule2"
boolean TitleBar=true
string Title="Scarichi"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

event dragdrop;
long ll_riga_sorgente, ll_id_caus_mag,ll_riga_gruppo
string ls_sql
integer li_pos_and, i, a, li_ret
decimal{2} ld_titolo
datawindow dw_sorgente
dw_sorgente=source

dw_sorgente.drag(end!)
if dw_sorgente=this then
	return
end if
ll_riga_sorgente=dw_sorgente.getrow()
dw_sorgente.rowsmove(ll_riga_sorgente,ll_riga_sorgente, primary!, this, 1, primary!)

if dw_sorgente=dw_caus_carico then
	if dw_caus_carico.rowcount()>0 then
		wf_stampa(dw_caus_carico, dw_stampa_carico)
	else
		dw_stampa_carico.reset()
	end if
end if

wf_stampa(this, dw_stampa_scarico)

wf_allinea_dw_stampa(dw_stampa_carico,dw_stampa_scarico)
wf_allinea_dw_stampa(dw_stampa_scarico,dw_stampa_carico)

end event

event clicked;if row>0 then
	this.drag(begin!)
end if
end event

type dw_caus_carico from datawindow within w_orafo_st_caus_mov
int X=5
int Y=404
int Width=1029
int Height=540
int TabOrder=20
string DragIcon="S:\pb\commonframework\cometa.ico"
string DataObject="d_caus_mag_formule2"
boolean TitleBar=true
string Title="Causali Scelte"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

event dragdrop;long ll_riga_sorgente, ll_id_caus_mag
string ls_sql
integer li_pos_and, i
datawindow dw_sorgente
dw_sorgente=source
dw_sorgente.drag(end!)
if dw_sorgente=this then
	return
end if
ll_riga_sorgente=dw_sorgente.getrow()
dw_sorgente.rowsmove(ll_riga_sorgente,ll_riga_sorgente, primary!, this, 1, primary!)

if  dw_sorgente=dw_caus_scarico then
	if dw_caus_scarico.rowcount()>0 then
		wf_stampa(dw_caus_scarico, dw_stampa_scarico)
	else
		dw_stampa_scarico.reset()
	end if
end if






end event

event clicked;if row>0 then
	this.drag(begin!)
end if
end event

type dw_causali from datawindow within w_orafo_st_caus_mov
int X=1193
int Y=408
int Width=1029
int Height=532
int TabOrder=270
string DragIcon="S:\pb\commonframework\cometa.ico"
string DataObject="d_caus_mag_formule2"
boolean TitleBar=true
string Title="Causali Disponibili"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
string Icon="Asterisk!"
end type

event clicked;if row>0 then
	this.drag(begin!)
end if
end event

event dragdrop;datawindow dw_sorgente
dw_sorgente=source
if dw_sorgente=this then return
long ll_riga_sorgente
dw_sorgente.drag(end!)
if dw_sorgente=this then
	return
end if
ll_riga_sorgente=dw_sorgente.getrow()
dw_sorgente.rowsmove(ll_riga_sorgente, ll_riga_sorgente, primary!, this, 1, primary!)

if dw_sorgente=dw_caus_carico then
	if dw_caus_carico.rowcount()>0 then
		
	else
		dw_stampa_carico.reset()
	end if
	if dw_caus_scarico.rowcount()>0 then
		
	end if
elseif  dw_sorgente=dw_caus_scarico then
	if dw_caus_scarico.rowcount()>0 then
		
	else
		dw_stampa_scarico.reset()
	end if
	if dw_caus_carico.rowcount()>0 then
		
	end if
end if
if dw_caus_scarico.rowcount()>0 then
	
else
	
end if
if  dw_caus_carico.rowcount()>0 then
	
else
	
end if

end event

type dw_stampa_scarico from datawindow within w_orafo_st_caus_mov
int X=2382
int Y=616
int Width=197
int Height=72
int TabOrder=300
string DataObject="d_st_data_tikal_tb"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

type dw_stampa_carico from datawindow within w_orafo_st_caus_mov
int Y=948
int Width=3643
int Height=1100
int TabOrder=280
string DataObject="d_data_caus_tikal_ok_tb"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event sqlpreview;string ls_sql
long ll_magazzino
ll_magazzino=dw_1.getrow()
if ll_magazzino>0 then
	ll_magazzino=dw_1.getitemnumber(ll_magazzino, "magazzino")
	if isnull(ll_magazzino) then ll_magazzino=0
	if ll_magazzino>0 then
		ls_sql=sqlsyntax + " and (riga_documento.id_locazione_1= "+string(ll_magazzino)+" or riga_documento.id_locazione_2= "+string(ll_magazzino)+")"
		
		setsqlpreview(ls_sql)
		
	end if
end if
end event

event printstart;integer li_copie
string ls_pg, ls_orienta

li_copie=integer(sle_copie.text)
if isnull(li_copie) or li_copie=0 then li_copie=1
dw_stampa_carico.Modify("DataWindow.Print.copies = "+string(li_copie))

ls_pg=sle_pg.text
dw_stampa_carico.Modify("DataWindow.Print.Page.Range = '"+ls_pg+"'")
end event

type gb_1 from groupbox within w_orafo_st_caus_mov
int X=1234
int Y=16
int Width=2400
int Height=380
int TabOrder=10
string Text="Richiama/Salva Configurazione"
long BackColor=79741120
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

