forward
global type w_stampa_estratto_ff_3 from window
end type
type cb_mail from commandbutton within w_stampa_estratto_ff_3
end type
type cbx_1 from checkbox within w_stampa_estratto_ff_3
end type
type st_1 from statictext within w_stampa_estratto_ff_3
end type
type cb_9 from commandbutton within w_stampa_estratto_ff_3
end type
type dw_2 from datawindow within w_stampa_estratto_ff_3
end type
type cb_8 from commandbutton within w_stampa_estratto_ff_3
end type
type cb_7 from commandbutton within w_stampa_estratto_ff_3
end type
type cb_6 from commandbutton within w_stampa_estratto_ff_3
end type
type cb_1 from commandbutton within w_stampa_estratto_ff_3
end type
type cb_5 from commandbutton within w_stampa_estratto_ff_3
end type
type cb_2 from commandbutton within w_stampa_estratto_ff_3
end type
type dw_1 from datawindow within w_stampa_estratto_ff_3
end type
type cb_3 from commandbutton within w_stampa_estratto_ff_3
end type
type cb_4 from commandbutton within w_stampa_estratto_ff_3
end type
end forward

global type w_stampa_estratto_ff_3 from window
integer x = 5
integer y = 4
integer width = 3351
integer height = 2208
boolean titlebar = true
string title = "Estratto Conto"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = popup!
long backcolor = 80263581
cb_mail cb_mail
cbx_1 cbx_1
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
global w_stampa_estratto_ff_3 w_stampa_estratto_ff_3

type variables
long il_zoom
string is_conto[]
long il_conto[]
long k
string selezione
string is_telefoni, is_vis_finale, is_vis_reg
string is_iniz
long ll_utile_sp
string ls_filter
s_passa_date ist_parametri  
end variables

forward prototypes
public subroutine uf_telefono (integer al_conto)
public subroutine uf_visible ()
end prototypes

public subroutine uf_telefono (integer al_conto);

long ll_anag
string ls_tel, ls_fax, ls_inter

select id_anagrafica 
into :ll_anag
from sog_commerciale
where id_conto=:al_conto;

select num_riferimento, interlocutore 
into :ls_tel, :ls_inter 
from telefono
where id_anagrafica=:ll_anag and tipo<>'F';

select num_riferimento, interlocutore 
into :ls_fax, :ls_inter 
from telefono
where id_anagrafica=:ll_anag and tipo='F';

if isnull(ls_inter) then ls_inter='--'
if isnull(ls_fax) then ls_fax='--'
if isnull(ls_tel) then ls_tel='--'

dw_1.object.tel.text=ls_tel
dw_1.object.fax.text=ls_fax
dw_1.object.inter.text=ls_inter

end subroutine

public subroutine uf_visible ();

dw_1.object.tel.visible=false
dw_1.object.fax.visible=false
dw_1.object.inter.visible=false
dw_1.object.tel_text.visible=false
dw_1.object.fax_text.visible=false
dw_1.object.ref_text.visible=false

end subroutine

on w_stampa_estratto_ff_3.create
this.cb_mail=create cb_mail
this.cbx_1=create cbx_1
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
this.Control[]={this.cb_mail,&
this.cbx_1,&
this.st_1,&
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

on w_stampa_estratto_ff_3.destroy
destroy(this.cb_mail)
destroy(this.cbx_1)
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
date data_iniziale_eco, data_finale_eco, ld_da, ld_a
long ll_apertura, ll_chiusura, ll_decimali, ll_val
string ls_valuta,ls_mm, ls_tipo_mm
decimal ld_cambio, ll_saldo_iniziale, ll_saldo_estratto

LONG ll_row, ll_breakrow,  ll_conto[]
INTEGER I, li_ret

datastore ds_stampa
ds_stampa=create datastore
s_passa_date str_parametri  

str_parametri=message.powerobjectparm
ist_parametri=message.powerobjectparm
data_saldo_iniziale=str_parametri.data_saldo_iniziale
data_saldo_attuale=str_parametri.data_saldo_fine
da_data_estratto=str_parametri.data_inizio_estratto
a_data_estratto=str_parametri.data_fine_estratto
ll_apertura=str_parametri.prof_apertura
ll_chiusura=str_parametri.prof_chiusura
ls_valuta=str_parametri.valuta
ld_cambio=str_parametri.cambio
ll_decimali=str_parametri.decimali
is_telefoni=str_parametri.telefono
is_vis_finale=str_parametri.vis_finale
data_iniziale_eco=str_parametri.data_iniziale_eco
data_finale_eco=str_parametri.data_fine_eco
is_vis_reg=str_parametri.vis_reg
is_iniz=str_parametri.sum_iniz
ll_val=str_parametri.id_valuta

if str_parametri.contropartita='S' then
	dw_1.dataobject='ds_calc_estratto_partita'
end if	
dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
selezione=''

select id_conto_utile_sp into :ll_utile_sp from par_sistema;
ls_filter="id_prof_reg<>"+string(ll_chiusura)

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
	
		
		ls_mm=Left(is_conto[1], 2)
		select tipo into :ls_tipo_mm from mastro where codice=:ls_mm;
		if ls_tipo_mm='C' or ls_tipo_mm='R' or ls_tipo_mm='E' then
			ld_da=data_iniziale_eco
			ld_a=data_finale_eco
		else
			ld_da=data_saldo_iniziale
			ld_a=data_saldo_attuale
		end if	
		
	
      ds_stampa.dataobject='ds_calc_saldo_iniziale_2'
      ds_stampa.reset()
		ds_stampa.settransobject(sqlca)
		li_ret=ds_stampa.retrieve(il_conto[1],ld_da,str_parametri.data_inizio_estratto,str_parametri.cambio,str_parametri.decimali, str_parametri.id_valuta )
		
		if il_conto[1]=ll_utile_sp then 
			ds_stampa.setfilter(ls_filter)
			ds_stampa.filter()
			li_ret=ds_stampa.rowcount()
		end if	
		
		if li_ret>0 then 
			ll_saldo_iniziale=ds_stampa.getitemdecimal(ds_stampa.rowcount(),'saldo_iniziale')
		else	
   		ll_saldo_iniziale=0
		end if	

		ds_stampa.dataobject='ds_calc_saldo_attuale_2'
		ds_stampa.reset()
		ds_stampa.settransobject(sqlca)
		li_ret=ds_stampa.retrieve(il_conto[1],ld_a,str_parametri.cambio,str_parametri.decimali, str_parametri.id_valuta )
		
		if il_conto[1]=ll_utile_sp then 
			ds_stampa.setfilter(ls_filter)
			ds_stampa.filter()
			li_ret=ds_stampa.rowcount()
		end if	
		
		if li_ret>0 then ll_saldo_estratto=ds_stampa.getitemdecimal(ds_stampa.rowcount(),'saldo_attuale')
		if is_iniz='S' then ll_saldo_iniziale=0
		li_ret=dw_1.retrieve(is_conto[1],da_data_estratto,a_data_estratto, ll_apertura, ll_chiusura, ll_decimali, str_parametri.id_valuta, ls_valuta,ll_saldo_iniziale, ll_saldo_estratto,is_vis_reg,str_parametri.data_stampa) 
      
		if is_telefoni='S' then 
			uf_telefono(il_conto[1])
		else
			uf_visible()
		end if	
		
		if li_ret=0 then li_ret=dw_1.insertrow(0)
else
	messagebox('Attenzione', 'Nessuno dei conti selezionati ha effettuato movimenti')
end if

destroy ds_stampa
if selezione<>'' then 
	dw_2.retrieve(selezione)
	
	if str_parametri.ordinamento='S' then dw_2.setsort('descrizione')
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

cbx_1.Checked = FALSE
end event

event resize;dw_1.width=newwidth - 60
dw_1.height=newheight - 200
end event

type cb_mail from commandbutton within w_stampa_estratto_ff_3
integer x = 859
integer y = 40
integer width = 261
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Mail"
end type

event clicked;integer i, li_pos
string ls_ret, ls_filename, ls_path, ls_cliente
string ls_trova

/* devi creare un pdf cercando la stampante adatta e poi creare una mail con allegato
il pdf*/

//aggiungere un campo dir_export sulla tabella utenti
select dir_export
into :ls_path
from dba.utenti
where id_utenti=:u_freddie.s_utenti.i_idutente
;
//ll_id_utenti=u_freddie.s_utenti.i_idutente

if isnull(ls_path) or ls_path="" then
	select dir_export
	into :ls_path
	from par_sistema
	;
end if
if ls_path>"" then 
	if right(ls_path, 1)<>'\' then ls_path+='\'
else
	ls_path="c:\"
end if
//il nome del file sarà = alle prime 6 lettere del cliente + data e ora

ls_cliente=dw_2.getitemstring(dw_2.GETROW(),"codice")
if isnull(ls_cliente) or ls_cliente=""  then
	ls_cliente="EC"
end if


ls_cliente+="_"+string(today(), "yy-mm-dd hh-mm;'none'")


ls_filename=ls_path+ls_cliente


ls_ret=dw_1.Modify("DataWindow.Print.filename = '"+ls_filename+"'")

ls_ret=dw_1.Modify("DataWindow.Print.printername = 'Acrobat PDFWriter'")
dw_1.print()
openwithparm(w_invia_mail, ls_filename+".pdf")
end event

type cbx_1 from checkbox within w_stampa_estratto_ff_3
integer x = 2409
integer y = 56
integer width = 494
integer height = 76
integer taborder = 110
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Escludi saldo a 0 "
boolean lefttext = true
end type

type st_1 from statictext within w_stampa_estratto_ff_3
integer x = 18
integer y = 12
integer width = 247
integer height = 68
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Conto"
boolean focusrectangle = false
end type

type cb_9 from commandbutton within w_stampa_estratto_ff_3
integer x = 27
integer y = 84
integer width = 110
integer height = 72
integer taborder = 70
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "V"
end type

event clicked;
dw_2.visible=true
end event

type dw_2 from datawindow within w_stampa_estratto_ff_3
integer x = 5
integer y = 156
integer width = 1362
integer height = 1904
integer taborder = 20
string dataobject = "d_lista_estratto"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
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

type cb_8 from commandbutton within w_stampa_estratto_ff_3
integer x = 1669
integer y = 40
integer width = 334
integer height = 92
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stp Completo"
end type

event clicked;printsetup()

date data_saldo_iniziale, data_saldo_attuale, da_data_estratto, a_data_estratto
date data_iniziale_eco, ld_da, data_finale_eco, ld_a
long ll_apertura, ll_chiusura, ll_decimali
string ls_valuta, ls_mm, ls_tipo_mm
decimal ld_cambio, ll_saldo_iniziale, ll_saldo_estratto
decimal{2} ld_saldo

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
data_iniziale_eco=str_parametri.data_iniziale_eco
data_finale_eco=str_parametri.data_fine_eco

long job

job = PrintOpen( )

for i=1 to upperbound(il_conto[]) - 1 
   ds_stampa.dataobject='ds_calc_saldo_iniziale_2'
      ds_stampa.reset()
		ds_stampa.settransobject(sqlca)
		ls_mm=Left(is_conto[i], 2)
		select tipo into :ls_tipo_mm from mastro where codice=:ls_mm;
		
		if ls_tipo_mm='C' or ls_tipo_mm='R' or ls_tipo_mm='E' then
			ld_da=data_iniziale_eco
			ld_a=data_finale_eco
		else
			ld_da=data_saldo_iniziale
			ld_a=data_saldo_attuale
		end if	
		
		li_ret=ds_stampa.retrieve(il_conto[i],ld_da,str_parametri.data_inizio_estratto,str_parametri.cambio,str_parametri.decimali, str_parametri.id_valuta )
		
		if il_conto[i]=ll_utile_sp then 
			ds_stampa.setfilter(ls_filter)
			ds_stampa.filter()
			li_ret=ds_stampa.rowcount()
		end if	
		
		if li_ret>0 then 
			ll_saldo_iniziale=ds_stampa.getitemdecimal(ds_stampa.rowcount(),'saldo_iniziale')
			
		else	
   		ll_saldo_iniziale=0
			
		end if	

		ds_stampa.dataobject='ds_calc_saldo_attuale_2'
		ds_stampa.reset()
		ds_stampa.settransobject(sqlca)
		li_ret=ds_stampa.retrieve(il_conto[i],ld_a,str_parametri.cambio,str_parametri.decimali, str_parametri.id_valuta )
		
		if il_conto[i]=ll_utile_sp then 
			ds_stampa.setfilter(ls_filter)
			ds_stampa.filter()
			li_ret=ds_stampa.rowcount()
		end if	
		
		if li_ret>0 then 
			ll_saldo_estratto=ds_stampa.getitemdecimal(ds_stampa.rowcount(),'saldo_attuale')
		
		else	
			ll_saldo_estratto=0
		end if	
		
		if is_iniz='S' then ll_saldo_iniziale=0
		li_ret=dw_1.retrieve(is_conto[i],da_data_estratto,a_data_estratto, ll_apertura, ll_chiusura, ll_decimali, str_parametri.id_valuta, ls_valuta,ll_saldo_iniziale, ll_saldo_estratto,is_vis_reg,str_parametri.data_stampa) 
      
		if is_telefoni='S' then uf_telefono(il_conto[i])
		if li_ret=0 then li_ret=dw_1.insertrow(0)
		
		ld_saldo=dw_1.getitemdecimal(1,"sum_saldo")
		if cbx_1.Checked and ld_saldo=0 then
			
		else
			
			PrintDataWindow(job, dw_1)
			//dw_1.print()
			
		end if
next
PrintClose(job)
destroy ds_stampa










end event

type cb_7 from commandbutton within w_stampa_estratto_ff_3
boolean visible = false
integer x = 2944
integer y = 40
integer width = 315
integer height = 92
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salva su file"
end type

event clicked;dw_1.SaveAs()
end event

type cb_6 from commandbutton within w_stampa_estratto_ff_3
integer x = 1408
integer y = 40
integer width = 238
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Zoom Out"
end type

event clicked;il_zoom=il_zoom - 10
dw_1.object.datawindow.zoom=il_zoom


end event

type cb_1 from commandbutton within w_stampa_estratto_ff_3
integer x = 1152
integer y = 40
integer width = 238
integer height = 92
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Zoom In"
end type

event clicked;il_zoom=il_zoom+10
dw_1.object.datawindow.zoom=il_zoom
end event

type cb_5 from commandbutton within w_stampa_estratto_ff_3
integer x = 2930
integer y = 40
integer width = 247
integer height = 92
integer taborder = 120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Annulla"
end type

event clicked;close(parent)
end event

type cb_2 from commandbutton within w_stampa_estratto_ff_3
integer x = 2016
integer y = 40
integer width = 361
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stp Selezionati"
end type

event clicked;printsetup()

date data_saldo_iniziale, data_saldo_attuale, da_data_estratto, a_data_estratto
date ld_da, data_iniziale_eco, ld_a, data_finale_eco
long ll_apertura, ll_chiusura, ll_decimali
string ls_valuta, ls_tipo_mm, ls_mm
decimal ld_cambio, ll_saldo_iniziale, ll_saldo_estratto

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
data_iniziale_eco=str_parametri.data_iniziale_eco
data_finale_eco=str_parametri.data_fine_eco

integer li_row
li_row=0
DO WHILE dw_2.GetSelectedRow(li_row)<>0
	   li_row=dw_2.GetSelectedRow(li_row)
		ds_stampa.dataobject='ds_calc_saldo_iniziale_2'
      ds_stampa.reset()
		ds_stampa.settransobject(sqlca)
		
		ls_mm=Left(is_conto[li_row], 2)
		select tipo into :ls_tipo_mm from mastro where codice=:ls_mm;
		if ls_tipo_mm='C' or ls_tipo_mm='R' or ls_tipo_mm='E' then
			ld_da=data_iniziale_eco
			ld_a=data_finale_eco
		else
			ld_da=data_saldo_iniziale
			ld_a=data_saldo_attuale
		end if	
		
		li_ret=ds_stampa.retrieve(il_conto[li_row],ld_da,str_parametri.data_inizio_estratto,str_parametri.cambio,str_parametri.decimali, str_parametri.id_valuta )
		
		if il_conto[li_row]=ll_utile_sp then 
			ds_stampa.setfilter(ls_filter)
			ds_stampa.filter()
			li_ret=ds_stampa.rowcount()
		end if	
		
		if li_ret>0 then 
			ll_saldo_iniziale=ds_stampa.getitemdecimal(ds_stampa.rowcount(),'saldo_iniziale')
		
		else	
   		ll_saldo_iniziale=0
		end if	
      

		ds_stampa.dataobject='ds_calc_saldo_attuale_2'
		ds_stampa.reset()
		ds_stampa.settransobject(sqlca)
		li_ret=ds_stampa.retrieve(il_conto[li_row],ld_a,str_parametri.cambio,str_parametri.decimali, str_parametri.id_valuta )
		
		if il_conto[li_row]=ll_utile_sp then 
			ds_stampa.setfilter(ls_filter)
			ds_stampa.filter()
			li_ret=ds_stampa.rowcount()
		end if	
		
		if li_ret>0 then 
			ll_saldo_estratto=ds_stampa.getitemdecimal(ds_stampa.rowcount(),'saldo_attuale')
		else
			ll_saldo_estratto=0
		end if	
		if is_iniz='S' then ll_saldo_iniziale=0
		li_ret=dw_1.retrieve(is_conto[li_row],da_data_estratto,a_data_estratto, ll_apertura, ll_chiusura, ll_decimali, str_parametri.id_valuta, ls_valuta,ll_saldo_iniziale, ll_saldo_estratto,is_vis_reg,str_parametri.data_stampa) 
      
	 	if is_telefoni='S' then uf_telefono(il_conto[li_row])
		if li_ret=0 then li_ret=dw_1.insertrow(0)
		
		
		if cbx_1.Checked = TRUE  and dw_1.getitemdecimal(dw_1.rowcount(),"sum_saldo")=0 then
		else
			dw_1.print()
		end if	
		
		
LOOP
dw_2.visible=false

destroy ds_stampa

end event

type dw_1 from datawindow within w_stampa_estratto_ff_3
integer y = 160
integer width = 3269
integer height = 1912
integer taborder = 10
string dataobject = "ds_calc_estratto_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
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
	setfocus(parent)
end if	
end event

event retrievestart;
end event

event retrieveend;
if is_vis_finale='N' then
	dw_1.Modify("vis_finale.Visible=0")
	dw_1.Modify("vis_finale_txt.Visible=0")	
end if	
end event

type cb_3 from commandbutton within w_stampa_estratto_ff_3
integer x = 192
integer y = 40
integer width = 315
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Precedente"
end type

event clicked;date data_saldo_iniziale, data_saldo_attuale, da_data_estratto, a_data_estratto
date data_iniziale_eco, ld_da, ld_a, data_finale_eco
long ll_apertura, ll_chiusura, ll_decimali
string ls_valuta, ls_mm, ls_tipo_mm
decimal ld_cambio,ll_saldo_iniziale, ll_saldo_estratto

LONG ll_row, ll_breakrow, ll_conto[]
INTEGER I, li_ret

datastore ds_stampa
ds_stampa=create datastore
s_passa_date str_parametri  

str_parametri=ist_parametri
data_saldo_iniziale=str_parametri.data_saldo_iniziale
data_saldo_attuale=str_parametri.data_saldo_fine
da_data_estratto=str_parametri.data_inizio_estratto
a_data_estratto=str_parametri.data_fine_estratto
ll_apertura=str_parametri.prof_apertura
ll_chiusura=str_parametri.prof_chiusura
ls_valuta=str_parametri.valuta
ld_cambio=str_parametri.cambio
ll_decimali=str_parametri.decimali
data_iniziale_eco=str_parametri.data_iniziale_eco
data_finale_eco=str_parametri.data_fine_eco
if k>1 then
   k=k - 1 
   ds_stampa.dataobject='ds_calc_saldo_iniziale_2'
      ds_stampa.reset()
		ds_stampa.settransobject(sqlca)
		
		ls_mm=Left(is_conto[k], 2)
		select tipo into :ls_tipo_mm from mastro where codice=:ls_mm;
		if ls_tipo_mm='C' or ls_tipo_mm='R' or ls_tipo_mm='E' then
			ld_da=data_iniziale_eco
			ld_a=data_finale_eco
		else
			ld_da=data_saldo_iniziale
			ld_a=data_saldo_attuale
		end if	
		
		li_ret=ds_stampa.retrieve(il_conto[k],ld_da,str_parametri.data_inizio_estratto,str_parametri.cambio,str_parametri.decimali, str_parametri.id_valuta )
		
		if il_conto[K]=ll_utile_sp then 
			ds_stampa.setfilter(ls_filter)
			ds_stampa.filter()
			li_ret=ds_stampa.rowcount()
		end if	
		
		if li_ret>0 then 
			ll_saldo_iniziale=ds_stampa.getitemdecimal(ds_stampa.rowcount(),'saldo_iniziale')
		else	
   		ll_saldo_iniziale=0
		end if	

		ds_stampa.dataobject='ds_calc_saldo_attuale_2'
		ds_stampa.reset()
		ds_stampa.settransobject(sqlca)
		li_ret=ds_stampa.retrieve(il_conto[k],ld_a,str_parametri.cambio,str_parametri.decimali, str_parametri.id_valuta )
		
		if il_conto[K]=ll_utile_sp then 
			ds_stampa.setfilter(ls_filter)
			ds_stampa.filter()
			li_ret=ds_stampa.rowcount()
		end if	
		
		if li_ret>0 then ll_saldo_estratto=ds_stampa.getitemdecimal(ds_stampa.rowcount(),'saldo_attuale')
		if is_iniz='S' then ll_saldo_iniziale=0
		li_ret=dw_1.retrieve(is_conto[k],da_data_estratto,a_data_estratto, ll_apertura, ll_chiusura, ll_decimali, str_parametri.id_valuta, ls_valuta,ll_saldo_iniziale, ll_saldo_estratto,is_vis_reg,str_parametri.data_stampa) 
	   
		if is_telefoni='S' then uf_telefono(il_conto[K])
		if li_ret=0 then li_ret=dw_1.insertrow(0)

end if	

destroy ds_stampa
end event

type cb_4 from commandbutton within w_stampa_estratto_ff_3
integer x = 521
integer y = 40
integer width = 306
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Successivo"
end type

event clicked;date data_saldo_iniziale, data_saldo_attuale, da_data_estratto, a_data_estratto
date data_iniziale_eco, ld_da, ld_a, data_finale_eco
long ll_apertura, ll_chiusura, ll_decimali
string ls_valuta, ls_mm, ls_tipo_mm
decimal ld_cambio, ll_saldo_iniziale, ll_saldo_estratto

LONG ll_row, ll_breakrow,  ll_conto[]
INTEGER I, li_ret

datastore ds_stampa
ds_stampa=create datastore
s_passa_date str_parametri  
str_parametri=ist_parametri
data_saldo_iniziale=str_parametri.data_saldo_iniziale
data_saldo_attuale=str_parametri.data_saldo_fine
da_data_estratto=str_parametri.data_inizio_estratto
a_data_estratto=str_parametri.data_fine_estratto
ll_apertura=str_parametri.prof_apertura
ll_chiusura=str_parametri.prof_chiusura
ls_valuta=str_parametri.valuta
ld_cambio=str_parametri.cambio
ll_decimali=str_parametri.decimali
data_iniziale_eco=str_parametri.data_iniziale_eco
data_finale_eco=str_parametri.data_fine_eco

if k<upperbound(il_conto[]) - 1 then
   k=k+1
   ds_stampa.dataobject='ds_calc_saldo_iniziale_2'
      ds_stampa.reset()
		ds_stampa.settransobject(sqlca)
		
		ls_mm=Left(is_conto[k], 2)
		select tipo into :ls_tipo_mm from mastro where codice=:ls_mm;
		if ls_tipo_mm='C' or ls_tipo_mm='R' or ls_tipo_mm='E' then
			ld_da=data_iniziale_eco
			ld_a=data_finale_eco
		else
			ld_da=data_saldo_iniziale
			ld_a=data_saldo_attuale
		end if	
		
		li_ret=ds_stampa.retrieve(il_conto[k],ld_da,str_parametri.data_inizio_estratto,str_parametri.cambio,str_parametri.decimali, str_parametri.id_valuta )
		
		if il_conto[k]=ll_utile_sp then 
			ds_stampa.setfilter(ls_filter)
			ds_stampa.filter()
			li_ret=ds_stampa.rowcount()
		end if	
		
		if li_ret>0 then 
			ll_saldo_iniziale=ds_stampa.getitemdecimal(ds_stampa.rowcount(),'saldo_iniziale')
		else	
   		ll_saldo_iniziale=0
		end if	

		ds_stampa.dataobject='ds_calc_saldo_attuale_2'
		ds_stampa.reset()
		ds_stampa.settransobject(sqlca)
		li_ret=ds_stampa.retrieve(il_conto[k],ld_a,str_parametri.cambio,str_parametri.decimali, str_parametri.id_valuta )
		
		if il_conto[k]=ll_utile_sp then 
			ds_stampa.setfilter(ls_filter)
			ds_stampa.filter()
			li_ret=ds_stampa.rowcount()
		end if	
		
		if li_ret>0 then ll_saldo_estratto=ds_stampa.getitemdecimal(ds_stampa.rowcount(),'saldo_attuale')
		if is_iniz='S' then ll_saldo_iniziale=0
		li_ret=dw_1.retrieve(is_conto[k],da_data_estratto,a_data_estratto, ll_apertura, ll_chiusura, ll_decimali, str_parametri.id_valuta, ls_valuta,ll_saldo_iniziale, ll_saldo_estratto,is_vis_reg,str_parametri.data_stampa) 
      
		if is_telefoni='S' then uf_telefono(il_conto[K])
		if li_ret=0 then li_ret=dw_1.insertrow(0)
end if	

destroy ds_stampa
end event

