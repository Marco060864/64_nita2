forward
global type w_stampa_estratto_triplo_ff from window
end type
type cb_8 from commandbutton within w_stampa_estratto_triplo_ff
end type
type cb_mail from commandbutton within w_stampa_estratto_triplo_ff
end type
type cb_7 from commandbutton within w_stampa_estratto_triplo_ff
end type
type cb_6 from commandbutton within w_stampa_estratto_triplo_ff
end type
type cb_1 from commandbutton within w_stampa_estratto_triplo_ff
end type
type cb_5 from commandbutton within w_stampa_estratto_triplo_ff
end type
type cb_4 from commandbutton within w_stampa_estratto_triplo_ff
end type
type cb_3 from commandbutton within w_stampa_estratto_triplo_ff
end type
type cb_2 from commandbutton within w_stampa_estratto_triplo_ff
end type
type dw_1 from datawindow within w_stampa_estratto_triplo_ff
end type
end forward

global type w_stampa_estratto_triplo_ff from window
integer x = 7
integer y = 48
integer width = 3763
integer height = 2400
boolean titlebar = true
string title = "Estratto Conto"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = popup!
long backcolor = 79741120
cb_8 cb_8
cb_mail cb_mail
cb_7 cb_7
cb_6 cb_6
cb_1 cb_1
cb_5 cb_5
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
dw_1 dw_1
end type
global w_stampa_estratto_triplo_ff w_stampa_estratto_triplo_ff

type variables
long il_zoom
string is_cliente
end variables

on w_stampa_estratto_triplo_ff.create
this.cb_8=create cb_8
this.cb_mail=create cb_mail
this.cb_7=create cb_7
this.cb_6=create cb_6
this.cb_1=create cb_1
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.dw_1=create dw_1
this.Control[]={this.cb_8,&
this.cb_mail,&
this.cb_7,&
this.cb_6,&
this.cb_1,&
this.cb_5,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.dw_1}
end on

on w_stampa_estratto_triplo_ff.destroy
destroy(this.cb_8)
destroy(this.cb_mail)
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

is_cliente=str_parametri.da_conto

	dw_1.settransobject(sqlca)
ll_ret=dw_1.retrieve(str_parametri.da_conto,da_data_estratto,a_data_estratto, ll_apertura, ll_chiusura, ll_decimali,&
str_parametri.id_valuta, ls_valuta,str_parametri.saldo_iniziale,&
str_parametri.saldo_finale,'N',str_parametri.data_stampa, str_parametri.a_conto, &
str_parametri.saldo_iniziale2, str_parametri.saldo_finale2, str_parametri.fido,str_parametri.cas_effetti, &
str_parametri.conto3, str_parametri.saldo_iniziale3, str_parametri.saldo_finale3) 
if ll_ret <=0 then
            messagebox('Information',"Nel periodo selezionato non sono presenti movimenti per il cliente " + str_parametri.da_conto+"~r~n"+&    
				            "Il saldo attuale del conto è " + string(str_parametri.saldo_finale),Information!,ok!)   
            close(this)
else
   il_zoom=100
end if



end event

event resize;dw_1.width=newwidth - 70
dw_1.height=newheight - 200
end event

type cb_8 from commandbutton within w_stampa_estratto_triplo_ff
integer x = 3006
integer y = 35
integer width = 249
integer height = 93
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Preview"
end type

event clicked;dw_1.object.datawindow.print.preview='yes'
dw_1.object.datawindow.print.preview.rulers='yes'
end event

type cb_mail from commandbutton within w_stampa_estratto_triplo_ff
integer x = 1668
integer y = 45
integer width = 256
integer height = 90
integer taborder = 70
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

ls_cliente=is_cliente

ls_cliente+="_"+string(today(), "yy-mm-dd hh-mm;'none'")


ls_filename=ls_path+ls_cliente


ls_ret=dw_1.Modify("DataWindow.Print.filename = '"+ls_filename+"'")

ls_ret=dw_1.Modify("DataWindow.Print.printername = 'Acrobat PDFWriter'")
dw_1.print()
openwithparm(w_invia_mail, ls_filename+".pdf")
end event

type cb_7 from commandbutton within w_stampa_estratto_triplo_ff
boolean visible = false
integer x = 2922
integer y = 42
integer width = 315
integer height = 93
integer taborder = 60
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

type cb_6 from commandbutton within w_stampa_estratto_triplo_ff
integer x = 2311
integer y = 42
integer width = 296
integer height = 93
integer taborder = 50
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

type cb_1 from commandbutton within w_stampa_estratto_triplo_ff
integer x = 1975
integer y = 42
integer width = 296
integer height = 93
integer taborder = 60
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

type cb_5 from commandbutton within w_stampa_estratto_triplo_ff
integer x = 40
integer y = 42
integer width = 249
integer height = 93
integer taborder = 70
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

type cb_4 from commandbutton within w_stampa_estratto_triplo_ff
integer x = 1159
integer y = 42
integer width = 464
integer height = 93
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Pagina Successiva"
end type

event clicked;dw_1.ScrollNextPage ( ) 
end event

type cb_3 from commandbutton within w_stampa_estratto_triplo_ff
integer x = 673
integer y = 42
integer width = 464
integer height = 93
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Pagina Precedente"
end type

event clicked;dw_1.ScrollPriorPage ( ) 

end event

type cb_2 from commandbutton within w_stampa_estratto_triplo_ff
integer x = 3324
integer y = 42
integer width = 249
integer height = 93
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stampa"
end type

event clicked;printsetup()
dw_1.print()
end event

type dw_1 from datawindow within w_stampa_estratto_triplo_ff
integer x = 40
integer y = 157
integer width = 3650
integer height = 2106
integer taborder = 10
string dataobject = "ds_calc_estratto_triplo"
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
end if	

end event

