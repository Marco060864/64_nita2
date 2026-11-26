forward
global type w_stampa_estratto_multi_ff from Window
end type
type cb_7 from commandbutton within w_stampa_estratto_multi_ff
end type
type cb_6 from commandbutton within w_stampa_estratto_multi_ff
end type
type cb_1 from commandbutton within w_stampa_estratto_multi_ff
end type
type cb_5 from commandbutton within w_stampa_estratto_multi_ff
end type
type cb_4 from commandbutton within w_stampa_estratto_multi_ff
end type
type cb_3 from commandbutton within w_stampa_estratto_multi_ff
end type
type cb_2 from commandbutton within w_stampa_estratto_multi_ff
end type
type dw_1 from datawindow within w_stampa_estratto_multi_ff
end type
end forward

global type w_stampa_estratto_multi_ff from Window
int X=9
int Y=48
int Width=3735
int Height=2376
boolean TitleBar=true
string Title="Estratto Conto"
long BackColor=79741120
boolean ControlMenu=true
WindowType WindowType=response!
cb_7 cb_7
cb_6 cb_6
cb_1 cb_1
cb_5 cb_5
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
dw_1 dw_1
end type
global w_stampa_estratto_multi_ff w_stampa_estratto_multi_ff

type variables
long il_zoom
end variables

on w_stampa_estratto_multi_ff.create
this.cb_7=create cb_7
this.cb_6=create cb_6
this.cb_1=create cb_1
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.dw_1=create dw_1
this.Control[]={this.cb_7,&
this.cb_6,&
this.cb_1,&
this.cb_5,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.dw_1}
end on

on w_stampa_estratto_multi_ff.destroy
destroy(this.cb_7)
destroy(this.cb_6)
destroy(this.cb_1)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.dw_1)
end on

event open;date data_saldo_iniziale, data_saldo_attuale, da_data_estratto, a_data_estratto
long ll_apertura, ll_chiusura, ll_decimali,ll_ret, ll_val
string ls_valuta
decimal ld_cambio


s_passa_date str_parametri  

str_parametri=message.powerobjectparm
data_saldo_iniziale=str_parametri.data_saldo_iniziale
data_saldo_attuale=str_parametri.data_saldo_fine
da_data_estratto=str_parametri.data_inizio_estratto
a_data_estratto=str_parametri.data_fine_estratto
ll_apertura=str_parametri.prof_apertura
ll_chiusura=str_parametri.prof_chiusura
ls_valuta=str_parametri.valuta
ld_cambio=str_parametri.cambio
ll_decimali=str_parametri.decimali
ll_val=str_parametri.id_valuta



dw_1.settransobject(sqlca)
ll_ret=dw_1.retrieve(str_parametri.da_conto,da_data_estratto,a_data_estratto, ll_apertura, ll_chiusura, ll_decimali, str_parametri.id_valuta, ls_valuta,str_parametri.saldo_iniziale, str_parametri.saldo_finale,'N',str_parametri.id_valuta,str_parametri.data_stampa) 
if ll_ret <=0 then
            messagebox('Information',"Nel periodo selezionato non sono presenti movimenti per il cliente " + str_parametri.da_conto+"~r~n"+&    
				            "Il saldo attuale del conto è " + string(str_parametri.saldo_finale),Information!,ok!)   
            close(this)
else
   il_zoom=100
end if



end event

type cb_7 from commandbutton within w_stampa_estratto_multi_ff
int X=2921
int Y=40
int Width=315
int Height=92
int TabOrder=60
boolean Visible=false
string Text="Salva su file"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.SaveAs()
end event

type cb_6 from commandbutton within w_stampa_estratto_multi_ff
int X=2313
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

type cb_1 from commandbutton within w_stampa_estratto_multi_ff
int X=1975
int Y=40
int Width=297
int Height=92
int TabOrder=60
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

type cb_5 from commandbutton within w_stampa_estratto_multi_ff
int X=41
int Y=40
int Width=247
int Height=92
int TabOrder=70
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

type cb_4 from commandbutton within w_stampa_estratto_multi_ff
int X=1161
int Y=40
int Width=466
int Height=92
int TabOrder=40
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

type cb_3 from commandbutton within w_stampa_estratto_multi_ff
int X=672
int Y=40
int Width=466
int Height=92
int TabOrder=30
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

type cb_2 from commandbutton within w_stampa_estratto_multi_ff
int X=3323
int Y=40
int Width=247
int Height=92
int TabOrder=20
string Text="Stampa"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;printsetup()
dw_1.print()
end event

type dw_1 from datawindow within w_stampa_estratto_multi_ff
int X=41
int Y=160
int Width=3648
int Height=2104
int TabOrder=10
string DataObject="ds_calc_estratto_multi"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event doubleclicked;long reg_pd
if row>0 then
	reg_pd=dw_1.getitemnumber(row,'id_reg_pd')
	s_list_main idw_master
	idw_master.l_identifica[1]=reg_pd
	idw_master.s_identifica[1]='id_reg_pd'
	idw_master.s_modo=modo_modifica
	idw_master.s_win_chiave[1]='id_reg_pd'
	idw_master.s_provenienza='richiamo'
	openwithparm(w_reg_pd_cx,idw_master)
end if	

end event

