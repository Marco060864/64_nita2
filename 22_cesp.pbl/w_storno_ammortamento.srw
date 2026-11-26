forward
global type w_storno_ammortamento from w_001
end type
type dw_1 from udw_base within w_storno_ammortamento
end type
type dw_2 from udw_base within w_storno_ammortamento
end type
type cb_storna from commandbutton within w_storno_ammortamento
end type
type st_2 from statictext within w_storno_ammortamento
end type
type cb_stampa from commandbutton within w_storno_ammortamento
end type
end forward

global type w_storno_ammortamento from w_001
integer width = 3474
integer height = 2128
string title = "Storno Ammortamento"
dw_1 dw_1
dw_2 dw_2
cb_storna cb_storna
st_2 st_2
cb_stampa cb_stampa
end type
global w_storno_ammortamento w_storno_ammortamento

on w_storno_ammortamento.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_2=create dw_2
this.cb_storna=create cb_storna
this.st_2=create st_2
this.cb_stampa=create cb_stampa
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.cb_storna
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.cb_stampa
end on

on w_storno_ammortamento.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.cb_storna)
destroy(this.st_2)
destroy(this.cb_stampa)
end on

event open;call super::open;

dw_1.settransobject(sqlca)
dw_2.insertrow(0)



end event

type st_1 from w_001`st_1 within w_storno_ammortamento
integer x = 1568
end type

type dw_1 from udw_base within w_storno_ammortamento
integer x = 110
integer y = 256
integer width = 3296
integer height = 1716
boolean bringtotop = true
string dataobject = "d_storno_cespite_gd"
boolean hscrollbar = true
end type

type dw_2 from udw_base within w_storno_ammortamento
integer x = 709
integer y = 32
integer width = 590
integer height = 196
boolean bringtotop = true
string dataobject = "d_data_ammortamento_ext"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

event itemchanged;call super::itemchanged;date ldt_data
long ll_ret

ldt_data=date(data )

ll_ret=dw_1.retrieve(ldt_data)
end event

type cb_storna from commandbutton within w_storno_ammortamento
integer x = 2999
integer y = 28
integer width = 411
integer height = 192
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Storna"
end type

event clicked;integer li_righe, i, li_anni, a
decimal ldc_importo, ldc_perc_amm, ldc_fondo_precedente, ldc_perc_ant
string ls_stato
long ll_id_mov_cespite[]


if messagebox("Attenzione!", &
	"Questa procedura cancellerà i movimenti visualizzati. Sei sicuro di voler procedere?",&
	stopsign!, yesno!)=1 then
	

	li_righe=dw_1.rowcount()
	
	for i= 1 to li_righe
		ldc_importo=dw_1.getitemdecimal(i, "mov_cespite_importo")
		ldc_perc_amm=dw_1.getitemdecimal(i,"cespite_amm_normale")
		if ldc_perc_amm>0 then
			ldc_fondo_precedente=dw_1.getitemdecimal(i, "fondo_amm_norm")
			dw_1.setitem(i, "fondo_amm_norm", ldc_fondo_precedente - ldc_importo)
		end if
		ldc_perc_ant=dw_1.getitemdecimal(i,"cespite_amm_anticipato")
		if ldc_perc_ant>0 then
			ldc_fondo_precedente=dw_1.getitemdecimal(i, "fondo_amm_ant")
			dw_1.setitem(i, "fondo_amm_ant", ldc_fondo_precedente - ldc_importo)
		end if
		ls_stato=dw_1.getitemstring(i,"stato")
		if ls_stato='E' then
			dw_1.setitem(i,"stato", "U")
		end if
		li_anni=dw_1.getitemnumber(i,"anni_ammortizzati")
		dw_1.setitem(i,"anni_ammortizzati", li_anni - 1)
		ll_id_mov_cespite[i]=dw_1.getitemnumber(i,"mov_cespite_id_mov_cespite")
	next
	if dw_1.update()=1 then
		for i=1 to upperbound(ll_id_mov_cespite)
			delete from mov_cespite
			where id_mov_cespite=:ll_id_mov_cespite[i];
			if sqlca.sqlcode<>0 then
				a++
			end if
		next
			if a=0 then
				commit;
				messagebox("OK!", "Storno completato!")
			else
				messagebox("Attenzione!", "Qualcosa è andato storto: cancellazione non effettuata!")
				rollback;
			end if
	else
		rollback;
		messagebox("Attenzione!", "Qualcosa è andato storto: storno non effettuato!")
	end if
end if
end event

type st_2 from statictext within w_storno_ammortamento
integer x = 114
integer y = 16
integer width = 562
integer height = 236
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 134217747
string text = "Inserisci la data dell~'ammortamento che vuoi stornare e poi conferma:"
boolean focusrectangle = false
end type

type cb_stampa from commandbutton within w_storno_ammortamento
integer x = 2441
integer y = 28
integer width = 411
integer height = 192
integer taborder = 20
boolean bringtotop = true
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

