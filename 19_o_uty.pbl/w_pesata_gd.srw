forward
global type w_pesata_gd from w_np_single_data
end type
type ole_1 from olecustomcontrol within w_pesata_gd
end type
type cb_1 from commandbutton within w_pesata_gd
end type
type cb_preview from commandbutton within w_pesata_gd
end type
type cb_imp_st from commandbutton within w_pesata_gd
end type
type cb_stampa from commandbutton within w_pesata_gd
end type
type st_1 from statictext within w_pesata_gd
end type
type dw_1 from u_dw_ext_main within w_pesata_gd
end type
type cb_salva from commandbutton within w_pesata_gd
end type
type cb_cancella from commandbutton within w_pesata_gd
end type
end forward

global type w_pesata_gd from w_np_single_data
integer width = 4891
integer height = 2228
event type long ue_post_insert ( long al_riga_inserita )
ole_1 ole_1
cb_1 cb_1
cb_preview cb_preview
cb_imp_st cb_imp_st
cb_stampa cb_stampa
st_1 st_1
dw_1 dw_1
cb_salva cb_salva
cb_cancella cb_cancella
end type
global w_pesata_gd w_pesata_gd

type variables
date idt_data
boolean lb_solo_stampa
string Is_sql, is_ultima_colonna
long il_prog, il_a_prog
end variables

forward prototypes
public function string wf_bilancia ()
end prototypes

public function string wf_bilancia ();long	ll_row
string Buffer, buffer2
integer li_pos
decimal ld_peso_netto
string ls_peso
boolean lb_test
//' Open the serial port

  OLE_1.object.CommPort = 1  //' Set the port number 
   
  OLE_1.object.Settings = "1200,N,7,1"  //' Set UART parameters

OLE_1.object.PortOpen = True           //' Required, might lock port
 
	sleep(1)
  //MsComm1.Output = "Text string"    ' Send data
  Buffer = OLE_1.object.Input //' Read data
 
  OLE_1.object.PortOpen = False
  if len(buffer)>30 then
	 	li_pos=pos(Buffer, "+", 16)
   else
		li_pos=pos(Buffer, "+", 1)
  end if
  ls_peso=mid(buffer, li_pos, 11)
  ls_peso=left(ls_peso, 10)
  ls_peso=right(ls_peso, 9)
ls_peso=trim(ls_peso)
li_pos=pos(ls_peso, ".")
ls_peso=left(ls_peso, li_pos - 1)+","+right(ls_peso, len(ls_peso) - li_pos)
return(ls_peso)
					
end function

on w_pesata_gd.create
int iCurrent
call super::create
this.ole_1=create ole_1
this.cb_1=create cb_1
this.cb_preview=create cb_preview
this.cb_imp_st=create cb_imp_st
this.cb_stampa=create cb_stampa
this.st_1=create st_1
this.dw_1=create dw_1
this.cb_salva=create cb_salva
this.cb_cancella=create cb_cancella
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ole_1
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_preview
this.Control[iCurrent+4]=this.cb_imp_st
this.Control[iCurrent+5]=this.cb_stampa
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.dw_1
this.Control[iCurrent+8]=this.cb_salva
this.Control[iCurrent+9]=this.cb_cancella
end on

on w_pesata_gd.destroy
call super::destroy
destroy(this.ole_1)
destroy(this.cb_1)
destroy(this.cb_preview)
destroy(this.cb_imp_st)
destroy(this.cb_stampa)
destroy(this.st_1)
destroy(this.dw_1)
destroy(this.cb_salva)
destroy(this.cb_cancella)
end on

event open;idw_master = dw_single
is_wintype = "W_NP_SINGLE_DATA"
//dw_single.Retrieve()
this.y = 100

dw_1.settransobject(sqlca)
dw_1.insertrow(1)
DW_1.SETITEM(1, "num_documento", "Catena")
DW_1.SETITEM(1, "data_filtro", today())

dw_1.trigger event itemchanged(1, dw_1.object.data_filtro, string(today()))

//DW_1.SETITEM(1, "num_progressivo", ll_num_prog)


end event

event resize;call super::resize;dw_single.Height = newheight - 100 -150

end event

type p_msg_log from w_np_single_data`p_msg_log within w_pesata_gd
end type

type p_crescente from w_np_single_data`p_crescente within w_pesata_gd
end type

type p_decrescente from w_np_single_data`p_decrescente within w_pesata_gd
end type

type dw_single from w_np_single_data`dw_single within w_pesata_gd
event type long ue_post_insert ( long al_riga_inserita )
integer x = 55
integer y = 196
integer width = 4722
integer height = 1868
string title = "Pesata"
string dataobject = "d_pesata_gd"
end type

event type long dw_single::ue_post_insert(long al_riga_inserita);long ll_righe_stesso_prog, ll_num_prog_attuale


ll_num_prog_attuale= getitemnumber(1, "num_progressivo")
if isnull(ll_num_prog_attuale) then ll_num_prog_attuale=0
ll_righe_stesso_prog= getitemnumber(1, "c_righe_stesso_prog")
if ll_righe_stesso_prog>100 then
	setitem( al_riga_inserita, "num_progressivo", ll_num_prog_attuale+1)
	dw_1.setitem(1, "num_progressivo", ll_num_prog_attuale+1)
	il_prog= ll_num_prog_attuale+1
	//prima salvo
	//setitem(1, "peso_lordo", 0)  //tolgo l'ho messo su initial nella dw20241217
	trigger event ue_update(0,0)
	dw_1.trigger event itemchanged(al_riga_inserita, dw_1.object.num_progressivo, string(ll_num_prog_attuale+1))
else
	if ll_num_prog_attuale=0 then ll_num_prog_attuale=1
	setitem( al_riga_inserita, "num_progressivo", ll_num_prog_attuale)
	
end if
//inserisco id operatore
setitem( al_riga_inserita, "id_operatore", u_freddie.s_utenti.i_idutente )
//20250825 inserisco anche articolo di default (A+)
setitem( al_riga_inserita, "id_articolo", 8942 )

ib_askforsave =false
trigger event ue_update(0,0)
return al_riga_inserita
end event

event dw_single::itemfocuschanged;decimal ldc_peso_lordo, ldc_peso
string ls_peso

if dwo.name='peso_lordo' then   //sppostato in itemchanged
	ldc_peso_lordo=getitemdecimal(row, "peso_lordo")
	//if ldc_peso_lordo>0 then
		//if messagebox("Attenzione!", "Vuoi davvero cambiare il valore del peso?", stopsign!,  yesno!)= 1 then
			ls_peso=wf_bilancia()
	
			ldc_peso=dec(ls_peso)
			if row<> 1 then
				if messagebox("Attenzione!", "LA RIGA CORRENTE NON è la 1!!! Il peso da bilancia verrà riportato in questa riga! Continuo????", stopsign!, yesno!)<>1 then return
				if ldc_peso>0 then setitem(row,"peso_lordo",ldc_peso)
			else
				setitem(row,"peso_lordo",ldc_peso)
			end if
//		else
//			setcolumn("tara")
//		end if
//	else
//		ls_peso=wf_bilancia()
//		ldc_peso=dec(ls_peso)
//		setitem(row,"peso_lordo", ldc_peso)
//	end if
end if
//else

if dwo.name='id_operatore' and is_ultima_colonna="nota" then  //cambiato 20241217 prima era "nota"+"tara" ma ora si deve andare anche su nota quindi....
	setcolumn("id_articolo")
	trigger event ue_insert(0,0)
end if
is_ultima_colonna=dwo.name

end event

event dw_single::sqlpreview;call super::sqlpreview;string ls_data, ls_sql,LS_PROG
integer i
ls_sql=sqlsyntax
if request = PreviewFunctionRetrieve! then
	
	if idt_data>date("01-01-1901") then
		ls_data=string(idt_data, "yyyy-mm-dd")
		ls_sql+=" where pesata.data='" +ls_data+"'"
		//ls_sql=sqlsyntax + ls_sql
	end if
		
	if il_prog>0 then
		LS_PROG=STRING(il_prog)
		if pos(ls_sql, "where") >0 then
			ls_sql+=" and pesata.num_progressivo>=" +LS_PROG
		else
			ls_sql+=" where pesata.num_progressivo>=" +LS_PROG
		end if
	end if
	if il_a_prog>0 then
		LS_PROG=STRING(il_a_prog)
		if pos(ls_sql, "where") >0 then
			ls_sql+=" and pesata.num_progressivo<=" +LS_PROG
		else
			ls_sql+=" where pesata.num_progressivo<=" +LS_PROG
		end if
	end if
	
	if idt_data>date("01-01-1901")  or il_prog>0 then
		i=SetSQLPreview(ls_sql)
		if i<>1 then
			messagebox("Errore!", "Filtro data non applicato!")
		end if
	end if
	
end if
end event

event dw_single::ue_insert;long ll_currow, ll_riga_inserita
integer li_colNumber,  li_num_prog, li_ultimo_prog
string ls_num_documento
date ldt_data

if ib_allow_insert then 
	ll_currow = THIS.GetRow()
	
	ll_riga_inserita=THIS.InsertRow(1)
	ls_num_documento=dw_1.getitemstring(1, "num_documento")
	post setitem(1, "num_documento", ls_num_documento)
	ldt_data=today()
	if rowcount()>1 then
		li_num_prog=getitemnumber(1, "c_max_prog")
	else
		li_num_prog=dw_1.getitemnumber(1, "num_progressivo")
	end if
	li_ultimo_prog=dw_1.getitemnumber(1, "a_num_progressivo")
	if isnull(li_num_prog) or li_num_prog=0 or  li_num_prog> li_ultimo_prog  then
		if li_num_prog>0 then
			messagebox("Attenzione!", "Completata serie di inserimento!")
		else
			messagebox("Attenzione!", "Inserirte il numero progressivo iniziale!!!")
		end if
			deleterow(ll_riga_inserita)
			return
	end if
	
	post setitem(1, "num_progressivo", li_num_prog)
	
	//THIS.ScrollToRow(ll_currow)  /cambio 20241217
	THIS.ScrollToRow(1)
	//post setcolumn("peso_lordo")  //NOEEEEEE deve andare sulla data 20241108
end if
post event ue_post_insert(ll_riga_inserita)


end event

event dw_single::ue_delete;long		ll_row,ll_ret
ll_ret = 0
if this.RowCount() > 0 then
	if ib_allow_delete then
		if THIS.getconfirm(ici_confirm_delete) then
			ll_row = this.getrow()
			messagebox("Attenzione!", "Per cancellare la riga inserire la password!")
			open(w_orafo_password)
			if Message.StringParm<>"OK" then
				return 0
			end if
			
			this.DeleteRow(0)
			this.SetFocus()
			ll_row  = ll_row  -1
			if ll_row > 0 then this.setrow(ll_row)
			ll_ret = 0
		else
			ll_ret = 1
		end if	
	else
		ll_ret = 1
	end if	
else
	ll_ret = 1
end if



long	ll_sbagli

ll_sbagli = Event ue_core_update (0,0)
ll_sbagli = Event ue_commit(ll_sbagli)

return ll_ret
end event

event dw_single::itemchanged;call super::itemchanged;//decimal ldc_peso_lordo, ldc_peso
//string ls_peso
//if dwo.name='peso_lordo' then
//	ldc_peso_lordo=getitemdecimal(row, "peso_lordo")
//	if ldc_peso_lordo>0 then
//		if messagebox("Attenzione!", "Vuoi davvero cambiare il valore del peso?", stopsign!,  yesno!)= 1 then
//			ls_peso=wf_bilancia()
//	
//			ldc_peso=dec(ls_peso)
//			setitem(row,"peso_lordo",ldc_peso)
//			
//		else
//			setcolumn("tara")
//		end if
//	else
//		ls_peso=wf_bilancia()
//		ldc_peso=dec(ls_peso)
//		setitem(row,"peso_lordo", ldc_peso)
//	end if
//end if
end event

event dw_single::rowfocuschanged;call super::rowfocuschanged;long ll_prog


//20241217 e perché azzera???????? PER ORA LO COMMENTO
if currentrow>0 then
//	ll_prog=getitemnumber(1, "peso_lordo")
//	if isnull(ll_prog) then 
//		ll_prog=0
//		setitem(1, "peso_lordo", 0)
//	end if
	ib_askforsave = false
	triggerevent("ue_update")
end if

end event

event dw_single::ue_update;long	ll_sbagli

//ll_sbagli = Super::Event ue_update(0,0)
if ll_sbagli = 0 then
	ll_sbagli = Event ue_core_update (0,0)
	ll_sbagli = Event ue_commit(ll_sbagli)
end if

end event

type ole_1 from olecustomcontrol within w_pesata_gd
event oncomm ( )
integer x = 4558
integer y = 32
integer width = 174
integer height = 152
integer taborder = 60
boolean bringtotop = true
boolean border = false
boolean focusrectangle = false
string binarykey = "w_pesata_gd.win"
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
end type

type cb_1 from commandbutton within w_pesata_gd
integer x = 37
integer y = 20
integer width = 343
integer height = 100
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Pulisci"
end type

event clicked;//dw_single.reset()
integer i

for i= dw_single.rowcount() to 1 step -1
	dw_single.deleterow(i)
next
//dw_single.rowsmove(1, dw_single.rowcount(), primary!, dw_single, 1, delete!)


//dw_single.dataobject="d_pesata_gd"
//dw_single.settransobject(sqlca)
end event

type cb_preview from commandbutton within w_pesata_gd
integer x = 3680
integer y = 24
integer width = 261
integer height = 88
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Preview"
end type

event clicked;if cb_preview.text='Preview' then
	cb_preview.text='Ritorna'
	dw_single.object.datawindow.print.preview='yes'
	dw_single.object.datawindow.print.preview.rulers='yes'
else
	cb_preview.text='Preview'
	dw_single.object.datawindow.print.preview='No'
	dw_single.object.datawindow.print.preview.rulers='no'
end if
end event

type cb_imp_st from commandbutton within w_pesata_gd
integer x = 3950
integer y = 24
integer width = 297
integer height = 88
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Imp. Stamp."
end type

event clicked;printsetup()
dw_single.object.datawindow.print.preview='yes'
dw_single.object.datawindow.print.preview.rulers='yes'
end event

type cb_stampa from commandbutton within w_pesata_gd
integer x = 4256
integer y = 24
integer width = 261
integer height = 88
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Stampa"
end type

event clicked;s_array s_dati

//printsetup()
//dw_single.print()


s_dati.as_string[1]=string(dw_1.getitemdate(1, "data_filtro"))
s_dati.li_anno[1]=dw_1.getitemnumber(1, "num_progressivo")
s_dati.li_anno[2]=dw_1.getitemnumber(1, "a_num_progressivo")
s_dati.ll_id_doc[1]=u_freddie.s_utenti.i_idutente

OpenWithParm(w_pesata_rpt, s_dati)
end event

type st_1 from statictext within w_pesata_gd
integer x = 379
integer y = 92
integer width = 439
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Carica pesata del:"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_1 from u_dw_ext_main within w_pesata_gd
integer x = 818
integer y = 8
integer width = 1408
integer height = 172
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_data_filtro_ext"
end type

event itemchanged;call super::itemchanged;if dwo.name="data_filtro"  or dwo.name="num_progressivo" or dwo.name="a_num_progressivo"  then
	if dwo.name="data_filtro" then
		idt_data=date(data)
		il_prog=getitemnumber(1, "num_progressivo")
	elseif  dwo.name="num_progressivo" then
		il_prog=long(data)
		idt_data=getitemdate(1, "data_filtro")
	elseif  dwo.name="a_num_progressivo" then
		il_a_prog=long(data)
		idt_data=getitemdate(1, "data_filtro")
		il_prog=getitemnumber(1, "num_progressivo")
	end if
	if isnull(il_prog) then il_prog=1
	dw_single.retrieve()
//	Messagebox("attenzione!", "Questa funzione serve per ricercare e stampare il ricercato! " &
//					+"Non puoi inserire nuove righe né, tantomeno, salvarle. Per inserire nuove righe devi premere 'Pulisci'.")

end if
end event

type cb_salva from commandbutton within w_pesata_gd
integer x = 2999
integer y = 24
integer width = 261
integer height = 88
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salva"
end type

event clicked;DW_single.TRIGGER EVENT UE_UPDATE(0,0)
end event

type cb_cancella from commandbutton within w_pesata_gd
integer x = 3273
integer y = 24
integer width = 261
integer height = 88
integer taborder = 21
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancella"
end type

event clicked;long ll_riga_da_cancellare

ll_riga_da_cancellare=dw_1.getrow()
if ll_riga_da_cancellare>0 then 
	if messagebox("Attenzione!", "Voui davvero cancellare DEFINITIVAMENTE la riga "+string(ll_riga_da_cancellare)+"?", stopsign!, yesno!)=1 then
		dw_single.deleterow(ll_riga_da_cancellare)
		dw_single.trigger event ue_update(0,0)
	end if
end if


end event

