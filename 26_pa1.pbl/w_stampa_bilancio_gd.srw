forward
global type w_stampa_bilancio_gd from window
end type
type dw_6 from datawindow within w_stampa_bilancio_gd
end type
type dw_5 from datawindow within w_stampa_bilancio_gd
end type
type cb_9 from commandbutton within w_stampa_bilancio_gd
end type
type dw_4 from datawindow within w_stampa_bilancio_gd
end type
type dw_3 from datawindow within w_stampa_bilancio_gd
end type
type cb_8 from commandbutton within w_stampa_bilancio_gd
end type
type dw_2 from datawindow within w_stampa_bilancio_gd
end type
type cb_2 from commandbutton within w_stampa_bilancio_gd
end type
type cb_7 from commandbutton within w_stampa_bilancio_gd
end type
type cb_6 from commandbutton within w_stampa_bilancio_gd
end type
type cb_5 from commandbutton within w_stampa_bilancio_gd
end type
type cb_4 from commandbutton within w_stampa_bilancio_gd
end type
type dw_1 from datawindow within w_stampa_bilancio_gd
end type
type cb_3 from commandbutton within w_stampa_bilancio_gd
end type
type cb_1 from commandbutton within w_stampa_bilancio_gd
end type
end forward

global type w_stampa_bilancio_gd from window
integer x = 4
integer y = 365
integer width = 3657
integer height = 1536
boolean titlebar = true
string title = "Stampa Bilancio"
boolean controlmenu = true
windowtype windowtype = response!
windowstate windowstate = maximized!
long backcolor = 79741120
event ue_post_open ( )
dw_6 dw_6
dw_5 dw_5
cb_9 cb_9
dw_4 dw_4
dw_3 dw_3
cb_8 cb_8
dw_2 dw_2
cb_2 cb_2
cb_7 cb_7
cb_6 cb_6
cb_5 cb_5
cb_4 cb_4
dw_1 dw_1
cb_3 cb_3
cb_1 cb_1
end type
global w_stampa_bilancio_gd w_stampa_bilancio_gd

type variables
long il_zoom
end variables

forward prototypes
public subroutine wf_excel (datawindow adw)
end prototypes

event ue_post_open;dw_1.Height=(this.Height) - 272
integer i
decimal ld_dec_significativi

s_param ls_param
ls_param=Message.PowerObjectParm
ld_dec_significativi=ls_param.dec_significativi



end event

public subroutine wf_excel (datawindow adw);
long ll_righe, i, ll_riga_inserita, ll_righe_inserite,a
string ls_cod, ls_des, ls_mastro, ls_sottomastro, ls_old_mastro, ls_old_sottomastro
decimal{2} ldc_saldo, ldc_tot_dare, ldc_tot_avere
string ls_col_cod, ls_col_des, ls_col_saldo, ls_col_dare_avere


ll_righe=adw.retrieve(1, "#,0.00")

choose case adw
	case dw_3, dw_5
		ll_riga_inserita=dw_2.insertrow(0)
		dw_2.setitem(1, "descrizione", "ATTIVITA'")
		dw_2.setitem(1, "des_p", "PASSIVITA'")
		ls_col_cod="codice"
		ls_col_des="descrizione"
		ls_col_saldo="saldo"
		ls_col_dare_avere="cdare_valuta"
		ll_righe_inserite=1
	case dw_4, dw_6
		
		ls_col_cod="cod_p"
		ls_col_des="des_p"
		ls_col_saldo="saldo_p"
		ls_col_dare_avere="cavere_valuta"
		ll_righe_inserite=dw_2.rowcount()
		
end choose

a=1
for i= 1 to ll_righe
	ls_cod=adw.getitemstring(i, "conto_codice")
	//mastro
	ls_mastro=left(ls_cod,2)
	if ls_mastro<>ls_old_mastro then
		ls_old_mastro=ls_mastro
		ls_des=adw.getitemstring(i, "mastro_descrizione")
		ldc_saldo=adw.getitemdecimal(i, "campo1")
		if i +a >= ll_righe_inserite then
			ll_riga_inserita=dw_2.insertrow(0)
		else
			
			ll_riga_inserita=i+a
			a++
		end if
		dw_2.setitem(ll_riga_inserita, ls_col_cod, "MASTRO")
		dw_2.setitem(ll_riga_inserita, ls_col_des, ls_des+"-"+ls_mastro)
		dw_2.setitem(ll_riga_inserita, ls_col_saldo, ldc_saldo)
	end if
	ls_sottomastro=left(ls_cod, 4)
	if ls_sottomastro<> ls_old_sottomastro then
		ls_old_sottomastro=ls_sottomastro
		ls_des=adw.getitemstring(i, "sottomastro_descrizione")
		ldc_saldo=adw.getitemdecimal(i, "campo")
		if i +a >= ll_righe_inserite then
			ll_riga_inserita=dw_2.insertrow(0)
		else
			
			ll_riga_inserita=i+a
			a++
			
		end if
		dw_2.setitem(ll_riga_inserita, ls_col_cod, "SOTTOMASTRO")
		dw_2.setitem(ll_riga_inserita, ls_col_des, ls_des+"-"+ls_sottomastro)
		dw_2.setitem(ll_riga_inserita, ls_col_saldo, ldc_saldo)
	end if
	ls_des=adw.getitemstring(i, "conto_descrizione")
	ldc_saldo=adw.getitemdecimal(i, ls_col_dare_avere)
	if i + a >= ll_righe_inserite+1 then
			ll_riga_inserita=dw_2.insertrow(0)
	else
		
		ll_riga_inserita=i+a
	end if
	dw_2.setitem(ll_riga_inserita, ls_col_cod, ls_cod)
	dw_2.setitem(ll_riga_inserita, ls_col_des, ls_des)
	dw_2.setitem(ll_riga_inserita, ls_col_saldo, ldc_saldo)
next
if adw=dw_4 then
	ldc_tot_dare=dw_2.getitemdecimal(1, "c_tot_dare")
	ldc_tot_avere=dw_2.getitemdecimal(1, "c_tot_avere")
	ll_riga_inserita=dw_2.insertrow(0)
	dw_2.setitem(ll_riga_inserita, "saldo_p", ldc_tot_avere)
	dw_2.setitem(ll_riga_inserita, "saldo", ldc_tot_dare)
end if

end subroutine

event open;close(w_attesa)

decimal ld_cambio,ld_dec_significativi
long ll_id_azienda, ll_cod_esercizio, i
date ld_data_in, ld_data_fin
string ls_stp

s_param ls_param
ls_param=Message.PowerObjectParm
ld_cambio=ls_param.cambio
ld_dec_significativi=ls_param.dec_significativi
ll_id_azienda=ls_param.id_azienda
ll_cod_esercizio=ls_param.cod_esercizio
ld_data_in=ls_param.data_in
ld_data_fin=ls_param.data_fin
ls_stp=ls_param.tipo_stp





ld_dec_significativi=ls_param.dec_significativi
string ls_formato,ls_dec
if ld_dec_significativi=0 then
   ls_formato="#,0"
   else
	ls_formato="#,0."
end if

ls_dec="0"
for i=1 to ld_dec_significativi 
    ls_formato=ls_formato+ls_dec
next



if ls_stp='S' then 
	dw_1.dataobject='d_stampa_bilancio3_aghi'
end if

dw_1.settransobject(sqlca)
dw_1.retrieve(ld_cambio,ll_id_azienda,ll_cod_esercizio,ld_data_in,ld_data_fin,ls_formato)
il_zoom=100
this.event post ue_post_open()
end event

on w_stampa_bilancio_gd.create
this.dw_6=create dw_6
this.dw_5=create dw_5
this.cb_9=create cb_9
this.dw_4=create dw_4
this.dw_3=create dw_3
this.cb_8=create cb_8
this.dw_2=create dw_2
this.cb_2=create cb_2
this.cb_7=create cb_7
this.cb_6=create cb_6
this.cb_5=create cb_5
this.cb_4=create cb_4
this.dw_1=create dw_1
this.cb_3=create cb_3
this.cb_1=create cb_1
this.Control[]={this.dw_6,&
this.dw_5,&
this.cb_9,&
this.dw_4,&
this.dw_3,&
this.cb_8,&
this.dw_2,&
this.cb_2,&
this.cb_7,&
this.cb_6,&
this.cb_5,&
this.cb_4,&
this.dw_1,&
this.cb_3,&
this.cb_1}
end on

on w_stampa_bilancio_gd.destroy
destroy(this.dw_6)
destroy(this.dw_5)
destroy(this.cb_9)
destroy(this.dw_4)
destroy(this.dw_3)
destroy(this.cb_8)
destroy(this.dw_2)
destroy(this.cb_2)
destroy(this.cb_7)
destroy(this.cb_6)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.dw_1)
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

type dw_6 from datawindow within w_stampa_bilancio_gd
boolean visible = false
integer x = 1766
integer y = 960
integer width = 1624
integer height = 803
integer taborder = 80
string title = "none"
string dataobject = "d_stp_bil_rice_gd"
boolean livescroll = true
end type

type dw_5 from datawindow within w_stampa_bilancio_gd
boolean visible = false
integer x = 1774
integer y = 842
integer width = 1624
integer height = 803
integer taborder = 80
string title = "none"
string dataobject = "d_stp_bil_costie_gd"
boolean livescroll = true
end type

type cb_9 from commandbutton within w_stampa_bilancio_gd
boolean visible = false
integer x = 1924
integer y = 26
integer width = 183
integer height = 99
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "PATR"
end type

event clicked;integer rtncode, a
long ll_righe, i, ll_riga_inserita, ll_righe_4
string ls_cod, ls_des, ls_mastro, ls_sottomastro, ls_old_mastro, ls_old_sottomastro
decimal{2} ldc_saldo



dw_5.settransobject(sqlca)
dw_6.settransobject(sqlca)
wf_excel(dw_5)
wf_excel(dw_6)






end event

type dw_4 from datawindow within w_stampa_bilancio_gd
boolean visible = false
integer x = 1788
integer y = 579
integer width = 1624
integer height = 803
integer taborder = 70
string title = "none"
string dataobject = "d_stp_bil_pasp_gd"
boolean livescroll = true
end type

type dw_3 from datawindow within w_stampa_bilancio_gd
boolean visible = false
integer x = 1792
integer y = 250
integer width = 1624
integer height = 803
integer taborder = 80
string title = "none"
string dataobject = "d_stp_bil_attp_gd"
boolean livescroll = true
end type

type cb_8 from commandbutton within w_stampa_bilancio_gd
boolean visible = false
integer x = 2951
integer y = 32
integer width = 344
integer height = 99
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
end type

event clicked;dw_2.SaveAs()
end event

type dw_2 from datawindow within w_stampa_bilancio_gd
boolean visible = false
integer x = 40
integer y = 410
integer width = 1701
integer height = 803
integer taborder = 70
string title = "none"
string dataobject = "d_attivita_gd"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type cb_2 from commandbutton within w_stampa_bilancio_gd
boolean visible = false
integer x = 1690
integer y = 29
integer width = 183
integer height = 99
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "ECO"
end type

event clicked;integer rtncode, a
long ll_righe, i, ll_riga_inserita, ll_righe_4
string ls_cod, ls_des, ls_mastro, ls_sottomastro, ls_old_mastro, ls_old_sottomastro
decimal{2} ldc_saldo


dw_2.visible=true
dw_3.visible=true
dw_2.settransobject(sqlca)
dw_3.settransobject(sqlca)


dw_4.visible=true
dw_4.settransobject(sqlca)
wf_excel(dw_3)
wf_excel(dw_4)






end event

type cb_7 from commandbutton within w_stampa_bilancio_gd
event clicked pbm_bnclicked
integer x = 2505
integer y = 42
integer width = 260
integer height = 83
integer taborder = 40
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Zoom Out"
end type

event clicked;il_zoom=il_zoom - 10
dw_1.object.datawindow.zoom=il_zoom
end event

type cb_6 from commandbutton within w_stampa_bilancio_gd
event clicked pbm_bnclicked
integer x = 2231
integer y = 42
integer width = 260
integer height = 83
integer taborder = 50
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Zoom In"
end type

event clicked;il_zoom=il_zoom+10
dw_1.object.datawindow.zoom=il_zoom
end event

type cb_5 from commandbutton within w_stampa_bilancio_gd
integer x = 680
integer y = 42
integer width = 464
integer height = 83
integer taborder = 30
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Pagina Precedente"
end type

event clicked;dw_1.ScrollPriorPage ( ) 
end event

type cb_4 from commandbutton within w_stampa_bilancio_gd
integer x = 1159
integer y = 42
integer width = 464
integer height = 83
integer taborder = 20
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Pagina Successiva"
end type

event clicked;dw_1.ScrollNextPage ( ) 
end event

type dw_1 from datawindow within w_stampa_bilancio_gd
integer x = 26
integer y = 141
integer width = 3610
integer height = 1261
integer taborder = 60
string dataobject = "d_stampa_bilancio"
boolean vscrollbar = true
boolean livescroll = true
end type

type cb_3 from commandbutton within w_stampa_bilancio_gd
integer x = 3387
integer y = 42
integer width = 249
integer height = 83
integer taborder = 10
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stampa"
end type

event clicked;printsetup()
dw_1.print()
end event

type cb_1 from commandbutton within w_stampa_bilancio_gd
integer x = 22
integer y = 42
integer width = 249
integer height = 83
integer taborder = 70
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Annulla"
end type

event clicked;close(parent)
end event

