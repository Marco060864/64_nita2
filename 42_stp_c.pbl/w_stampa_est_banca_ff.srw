forward
global type w_stampa_est_banca_ff from Window
end type
type st_1 from statictext within w_stampa_est_banca_ff
end type
type cb_9 from commandbutton within w_stampa_est_banca_ff
end type
type dw_2 from datawindow within w_stampa_est_banca_ff
end type
type cb_8 from commandbutton within w_stampa_est_banca_ff
end type
type cb_7 from commandbutton within w_stampa_est_banca_ff
end type
type cb_6 from commandbutton within w_stampa_est_banca_ff
end type
type cb_1 from commandbutton within w_stampa_est_banca_ff
end type
type cb_5 from commandbutton within w_stampa_est_banca_ff
end type
type cb_2 from commandbutton within w_stampa_est_banca_ff
end type
type dw_1 from datawindow within w_stampa_est_banca_ff
end type
type cb_3 from commandbutton within w_stampa_est_banca_ff
end type
type cb_4 from commandbutton within w_stampa_est_banca_ff
end type
end forward

global type w_stampa_est_banca_ff from Window
int X=5
int Y=4
int Width=3205
int Height=2184
boolean TitleBar=true
string Title="Estratto Conto"
long BackColor=79741120
boolean ControlMenu=true
WindowState WindowState=maximized!
WindowType WindowType=response!
st_1 st_1
cb_9 cb_9
dw_2 dw_2
cb_8 cb_8
cb_7 cb_7
cb_6 cb_6
cb_1 cb_1
cb_5 cb_5
cb_2 cb_2
dw_1 dw_1
cb_3 cb_3
cb_4 cb_4
end type
global w_stampa_est_banca_ff w_stampa_est_banca_ff

type variables
long il_zoom
string is_conto[]
long il_conto[]
integer k
string selezione
end variables

on w_stampa_est_banca_ff.create
this.st_1=create st_1
this.cb_9=create cb_9
this.dw_2=create dw_2
this.cb_8=create cb_8
this.cb_7=create cb_7
this.cb_6=create cb_6
this.cb_1=create cb_1
this.cb_5=create cb_5
this.cb_2=create cb_2
this.dw_1=create dw_1
this.cb_3=create cb_3
this.cb_4=create cb_4
this.Control[]={this.st_1,&
this.cb_9,&
this.dw_2,&
this.cb_8,&
this.cb_7,&
this.cb_6,&
this.cb_1,&
this.cb_5,&
this.cb_2,&
this.dw_1,&
this.cb_3,&
this.cb_4}
end on

on w_stampa_est_banca_ff.destroy
destroy(this.st_1)
destroy(this.cb_9)
destroy(this.dw_2)
destroy(this.cb_8)
destroy(this.cb_7)
destroy(this.cb_6)
destroy(this.cb_1)
destroy(this.cb_5)
destroy(this.cb_2)
destroy(this.dw_1)
destroy(this.cb_3)
destroy(this.cb_4)
end on

event open;date data_saldo_iniziale, data_saldo_attuale, da_data_estratto, a_data_estratto
long  ll_decimali, ll_val
string ls_valuta, ls_conto[]
decimal ll_saldo_iniziale, ll_saldo_estratto, ld_cambio

LONG ll_row, ll_breakrow, ll_conto[]
INTEGER I, li_ret

datastore ds_stampa
ds_stampa=create datastore
s_passa_date str_parametri  

str_parametri=message.powerobjectparm
data_saldo_iniziale=str_parametri.data_saldo_iniziale
data_saldo_attuale=str_parametri.data_saldo_fine
da_data_estratto=str_parametri.data_inizio_estratto
a_data_estratto=str_parametri.data_fine_estratto
ls_valuta=str_parametri.valuta
ld_cambio=str_parametri.cambio
ll_decimali=str_parametri.decimali
ll_val=str_parametri.id_valuta

dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
selezione=''

DECLARE cur_conto CURSOR FOR 
   select id_conto, codice
	from conto
	where codice>=:str_parametri.da_conto and codice<=:str_parametri.a_conto
	USING SQLCA;

	OPEN cur_conto;
	FETCH cur_conto INTO :il_conto[1], :is_conto[1];
   i=1
      

	DO WHILE SQLCA.SQLCode = 0
		setnull(k)
		if str_parametri.solo_per='N' then
			select id_mov_contabile
			into :k
			from mov_contabile 
			where id_conto=:il_conto[i];
		else
			select m.id_mov_contabile
			into :k
			from mov_contabile m, reg_pd r
			where m.id_reg_pd=r.id_reg_pd
			and   m.id_conto=:il_conto[i] and r.data_competenza>=:da_data_estratto and r.data_competenza<=:a_data_estratto;
		end if	
		if not isnull(k) then  
			 i=i+1
	       if selezione<>'' then 
				selezione=selezione + ","  + string(il_conto[i - 1])
		    else
	         selezione= string(il_conto[i - 1])
			end if
		end if
		
		FETCH cur_conto INTO :il_conto[i],:is_conto[i];
	LOOP

close cur_conto;

if SELEZIONE<>'' then
      ds_stampa.dataobject='ds_saldo_iniziale_banca'
      ds_stampa.reset()
		ds_stampa.settransobject(sqlca)
		li_ret=ds_stampa.retrieve(il_conto[1],str_parametri.data_saldo_iniziale,str_parametri.data_inizio_estratto,str_parametri.cambio,str_parametri.decimali, ll_val )
		if li_ret>0 then 
			ll_saldo_iniziale=ds_stampa.getitemdecimal(ds_stampa.rowcount(),'saldo_iniziale')
		else	
   		ll_saldo_iniziale=0
		end if	

		ds_stampa.dataobject='ds_saldo_attuale_banca'
		ds_stampa.reset()
		ds_stampa.settransobject(sqlca)
		li_ret=ds_stampa.retrieve(il_conto[1],str_parametri.data_saldo_iniziale,str_parametri.cambio,str_parametri.decimali, ll_val )
		if li_ret>0 then ll_saldo_estratto=ds_stampa.getitemdecimal(ds_stampa.rowcount(),'saldo_attuale')
		li_ret=dw_1.retrieve(is_conto[1],da_data_estratto,a_data_estratto,  ll_decimali, str_parametri.id_valuta, ls_valuta,ll_saldo_iniziale, ll_saldo_estratto,str_parametri.data_stampa) 
      if li_ret=0 then li_ret=dw_1.insertrow(0)
else
	messagebox('Attenzione', 'Nessuno dei conti selezionati ha effettuato movimenti')
end if

destroy ds_stampa
if selezione<>'' then 
	dw_2.retrieve(selezione)
	dw_2.sort()
	dw_2.SelectRow ( 1, true )
	if dw_2.rowcount()>0 then
		for i=1 to dw_2.rowcount()
			il_conto[i]=dw_2.getitemnumber(i,'id_conto')
			is_conto[i]=dw_2.getitemstring(i,'codice')
		next
	end if	
end if
k=1




            il_zoom=100


dw_2.visible=false
end event

type st_1 from statictext within w_stampa_est_banca_ff
int X=18
int Y=12
int Width=247
int Height=68
boolean Enabled=false
string Text="Conto"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_9 from commandbutton within w_stampa_est_banca_ff
int X=27
int Y=84
int Width=110
int Height=72
int TabOrder=70
string Text="V"
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
dw_2.visible=true
end event

type dw_2 from datawindow within w_stampa_est_banca_ff
int X=5
int Y=156
int Width=1362
int Height=1904
int TabOrder=20
string DataObject="d_lista_est_banca"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

event sqlpreview;string ls_sql

ls_sql=sqlsyntax +  "WHERE id_conto in ("+selezione+")"
setsqlpreview(ls_sql)

end event

event clicked;if row>0 then
IF KeyDown(KeyControl!) THEN
	dw_2.SelectRow ( row, true )
ELSE	
	dw_2.SelectRow ( 0, false )
	dw_2.SelectRow ( row, true )
	k=row - 1
	cb_4.TriggerEvent(Clicked!)
	
	dw_2.visible=false
END IF
end if 
end event

type cb_8 from commandbutton within w_stampa_est_banca_ff
int X=1993
int Y=40
int Width=398
int Height=92
int TabOrder=80
string Text="Stampa Completo"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;printsetup()

date data_saldo_iniziale, data_saldo_attuale, da_data_estratto, a_data_estratto
long ll_apertura, ll_chiusura, ll_decimali
string ls_valuta, ls_conto[]
decimal ll_saldo_iniziale, ll_saldo_estratto, ld_cambio

LONG ll_conto[]
INTEGER I, li_ret

datastore ds_stampa
ds_stampa=create datastore
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

long job

for i=1 to upperbound(il_conto[]) - 1 
   ds_stampa.dataobject='ds_saldo_iniziale_banca'
      ds_stampa.reset()
		ds_stampa.settransobject(sqlca)
		li_ret=ds_stampa.retrieve(il_conto[i],str_parametri.data_saldo_iniziale,str_parametri.data_inizio_estratto,str_parametri.cambio,str_parametri.decimali, str_parametri.id_valuta )
		if li_ret>0 then 
			ll_saldo_iniziale=ds_stampa.getitemdecimal(ds_stampa.rowcount(),'saldo_iniziale')
		else	
   		ll_saldo_iniziale=0
		end if	

		ds_stampa.dataobject='ds_saldo_attuale_banca'
		ds_stampa.reset()
		ds_stampa.settransobject(sqlca)
		li_ret=ds_stampa.retrieve(il_conto[i],str_parametri.data_saldo_iniziale,str_parametri.cambio,str_parametri.decimali, str_parametri.id_valuta )
		if li_ret>0 then ll_saldo_estratto=ds_stampa.getitemdecimal(ds_stampa.rowcount(),'saldo_attuale')
		li_ret=dw_1.retrieve(is_conto[i],da_data_estratto,a_data_estratto, ll_decimali, str_parametri.id_valuta, ls_valuta,ll_saldo_iniziale, ll_saldo_estratto,str_parametri.data_stampa) 
      if li_ret=0 then li_ret=dw_1.insertrow(0)
		dw_1.print()
next



end event

type cb_7 from commandbutton within w_stampa_est_banca_ff
int X=2921
int Y=40
int Width=315
int Height=92
int TabOrder=70
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

type cb_6 from commandbutton within w_stampa_est_banca_ff
int X=1600
int Y=40
int Width=238
int Height=92
int TabOrder=60
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

type cb_1 from commandbutton within w_stampa_est_banca_ff
int X=1344
int Y=40
int Width=238
int Height=92
int TabOrder=90
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

type cb_5 from commandbutton within w_stampa_est_banca_ff
int X=2894
int Y=40
int Width=247
int Height=92
int TabOrder=100
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

type cb_2 from commandbutton within w_stampa_est_banca_ff
int X=2414
int Y=40
int Width=434
int Height=92
int TabOrder=30
string Text="Stampa Selezionati"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;printsetup()

date data_saldo_iniziale, data_saldo_attuale, da_data_estratto, a_data_estratto
long ll_apertura, ll_chiusura, ll_decimali
string ls_valuta, ls_conto[]
decimal ll_saldo_iniziale, ll_saldo_estratto, ld_cambio

LONG ll_conto[]
INTEGER I, li_ret

datastore ds_stampa
ds_stampa=create datastore
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


integer li_row
li_row=0
DO WHILE dw_2.GetSelectedRow(li_row)<>0
	   li_row=dw_2.GetSelectedRow(li_row)
		ds_stampa.dataobject='ds_saldo_iniziale_banca'
      ds_stampa.reset()
		ds_stampa.settransobject(sqlca)
		li_ret=ds_stampa.retrieve(il_conto[li_row],str_parametri.data_saldo_iniziale,str_parametri.data_inizio_estratto,str_parametri.cambio,str_parametri.decimali, str_parametri.id_valuta )
		if li_ret>0 then 
			ll_saldo_iniziale=ds_stampa.getitemdecimal(ds_stampa.rowcount(),'saldo_iniziale')
		else	
   		ll_saldo_iniziale=0
		end if	

		ds_stampa.dataobject='ds_saldo_attuale_banca'
		ds_stampa.reset()
		ds_stampa.settransobject(sqlca)
		li_ret=ds_stampa.retrieve(il_conto[li_row],str_parametri.data_saldo_iniziale,str_parametri.cambio,str_parametri.decimali, str_parametri.id_valuta )
		if li_ret>0 then ll_saldo_estratto=ds_stampa.getitemdecimal(ds_stampa.rowcount(),'saldo_attuale')
		li_ret=dw_1.retrieve(is_conto[li_row],da_data_estratto,a_data_estratto,  ll_decimali, str_parametri.id_valuta, ls_valuta,ll_saldo_iniziale, ll_saldo_estratto,str_parametri.data_stampa) 
      if li_ret=0 then li_ret=dw_1.insertrow(0)
		dw_1.print()
LOOP
dw_2.visible=false

end event

type dw_1 from datawindow within w_stampa_est_banca_ff
int Y=156
int Width=3182
int Height=1912
int TabOrder=10
string DataObject="ds_calc_est_banca"
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

event retrievestart;
end event

type cb_3 from commandbutton within w_stampa_est_banca_ff
int X=183
int Y=40
int Width=393
int Height=92
int TabOrder=40
boolean BringToTop=true
string Text="Precedente"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;date data_saldo_iniziale, data_saldo_attuale, da_data_estratto, a_data_estratto
long ll_apertura, ll_chiusura, ll_decimali
string ls_valuta, ls_conto[]
decimal ll_saldo_iniziale, ll_saldo_estratto, ld_cambio

LONG ll_row, ll_breakrow, ll_conto[]
INTEGER I, li_ret

datastore ds_stampa
ds_stampa=create datastore
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

if k>1 then
   k=k - 1 
   ds_stampa.dataobject='ds_saldo_iniziale_banca'
      ds_stampa.reset()
		ds_stampa.settransobject(sqlca)
		li_ret=ds_stampa.retrieve(il_conto[k],str_parametri.data_saldo_iniziale,str_parametri.data_inizio_estratto,str_parametri.cambio,str_parametri.decimali, str_parametri.id_valuta )
		if li_ret>0 then 
			ll_saldo_iniziale=ds_stampa.getitemdecimal(ds_stampa.rowcount(),'saldo_iniziale')
		else	
   		ll_saldo_iniziale=0
		end if	

		ds_stampa.dataobject='ds_saldo_attuale_banca'
		ds_stampa.reset()
		ds_stampa.settransobject(sqlca)
		li_ret=ds_stampa.retrieve(il_conto[k],str_parametri.data_saldo_iniziale,str_parametri.cambio,str_parametri.decimali, str_parametri.id_valuta )
		if li_ret>0 then ll_saldo_estratto=ds_stampa.getitemdecimal(ds_stampa.rowcount(),'saldo_attuale')
		li_ret=dw_1.retrieve(is_conto[k],da_data_estratto,a_data_estratto,  ll_decimali, str_parametri.id_valuta, ls_valuta,ll_saldo_iniziale, ll_saldo_estratto,str_parametri.data_stampa) 
	   if li_ret=0 then li_ret=dw_1.insertrow(0)

end if	
end event

type cb_4 from commandbutton within w_stampa_est_banca_ff
int X=603
int Y=40
int Width=393
int Height=92
int TabOrder=50
boolean BringToTop=true
string Text="Successivo"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;date data_saldo_iniziale, data_saldo_attuale, da_data_estratto, a_data_estratto
long ll_apertura, ll_chiusura, ll_decimali
string ls_valuta, ls_conto[]
decimal ll_saldo_iniziale, ll_saldo_estratto, ld_cambio

LONG ll_row, ll_breakrow,ll_conto[]
INTEGER I, li_ret

datastore ds_stampa
ds_stampa=create datastore
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

if k<upperbound(il_conto[]) - 1 then
   k=k+1
   ds_stampa.dataobject='ds_saldo_iniziale_banca'
      ds_stampa.reset()
		ds_stampa.settransobject(sqlca)
		li_ret=ds_stampa.retrieve(il_conto[k],str_parametri.data_saldo_iniziale,str_parametri.data_inizio_estratto,str_parametri.cambio,str_parametri.decimali, str_parametri.id_valuta )
		if li_ret>0 then 
			ll_saldo_iniziale=ds_stampa.getitemdecimal(ds_stampa.rowcount(),'saldo_iniziale')
		else	
   		ll_saldo_iniziale=0
		end if	

		ds_stampa.dataobject='ds_saldo_attuale_banca'
		ds_stampa.reset()
		ds_stampa.settransobject(sqlca)
		li_ret=ds_stampa.retrieve(il_conto[k],str_parametri.data_saldo_iniziale,str_parametri.cambio,str_parametri.decimali, str_parametri.id_valuta )
		if li_ret>0 then ll_saldo_estratto=ds_stampa.getitemdecimal(ds_stampa.rowcount(),'saldo_attuale')
		li_ret=dw_1.retrieve(is_conto[k],da_data_estratto,a_data_estratto,ll_decimali, str_parametri.id_valuta, ls_valuta,ll_saldo_iniziale, ll_saldo_estratto,str_parametri.data_stampa) 
      if li_ret=0 then li_ret=dw_1.insertrow(0)
end if	
end event

