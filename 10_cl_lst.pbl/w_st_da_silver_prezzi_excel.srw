forward
global type w_st_da_silver_prezzi_excel from w_stampa
end type
type cbx_selezione from checkbox within w_st_da_silver_prezzi_excel
end type
type dw_2 from udw_000 within w_st_da_silver_prezzi_excel
end type
end forward

global type w_st_da_silver_prezzi_excel from w_stampa
integer width = 5042
integer height = 1748
cbx_selezione cbx_selezione
dw_2 dw_2
end type
global w_st_da_silver_prezzi_excel w_st_da_silver_prezzi_excel

event open;call super::open;

dw_1.settransobject(sqlca)
datawindow dw_100

dw_100=message.powerobjectparm
dw_100.rowscopy(1, 1000000, primary!, dw_1 , 1, primary!)



dw_2.insertrow(1)
//cbx_selezione.checked=true
//cbx_selezione.triggerevent(clicked!)

end event

on w_st_da_silver_prezzi_excel.create
int iCurrent
call super::create
this.cbx_selezione=create cbx_selezione
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_selezione
this.Control[iCurrent+2]=this.dw_2
end on

on w_st_da_silver_prezzi_excel.destroy
call super::destroy
destroy(this.cbx_selezione)
destroy(this.dw_2)
end on

event ue_postopen;call super::ue_postopen;dw_1.setfilter("prezzo_confermato='C'")
dw_1.filter()
end event

type pb_1 from w_stampa`pb_1 within w_st_da_silver_prezzi_excel
integer x = 4311
integer y = 24
end type

type cb_preview from w_stampa`cb_preview within w_st_da_silver_prezzi_excel
integer x = 3707
integer y = 24
end type

type dw_1 from w_stampa`dw_1 within w_st_da_silver_prezzi_excel
event type integer ue_update ( )
integer width = 4891
string dataobject = "d_silver_prezzi_stampa2"
end type

event type integer dw_1::ue_update();integer li_ret

li_ret=update()
if li_ret=1 then
	commit;
else
	rollback;
	messagebox(  this.classname() +" - Salvataggio non riuscito!",sqlca.sqlerrtext)
end if
	
	
	
return li_ret
end event

event dw_1::clicked;call super::clicked;string ls_nome_campo

if dwo.type="text" THEN
	ls_nome_campo=left(string(dwo.name), len(string(dwo.name)) - 2 ) 
	dw_1.modify(ls_nome_campo+".visible=0")
END IF
end event

type pb_salva_su_file from w_stampa`pb_salva_su_file within w_st_da_silver_prezzi_excel
integer x = 4114
integer y = 24
end type

type pb_stampa from w_stampa`pb_stampa within w_st_da_silver_prezzi_excel
integer x = 3904
integer y = 24
end type

type sle_pg from w_stampa`sle_pg within w_st_da_silver_prezzi_excel
integer x = 1307
end type

type st_1 from w_stampa`st_1 within w_st_da_silver_prezzi_excel
integer x = 1029
end type

type st_2 from w_stampa`st_2 within w_st_da_silver_prezzi_excel
boolean visible = true
end type

type sle_copie from w_stampa`sle_copie within w_st_da_silver_prezzi_excel
boolean visible = true
end type

type sle_zoom from w_stampa`sle_zoom within w_st_da_silver_prezzi_excel
end type

type cb_7 from w_stampa`cb_7 within w_st_da_silver_prezzi_excel
end type

type cb_6 from w_stampa`cb_6 within w_st_da_silver_prezzi_excel
end type

type cb_pg_dopo from w_stampa`cb_pg_dopo within w_st_da_silver_prezzi_excel
end type

type cb_pg_prima from w_stampa`cb_pg_prima within w_st_da_silver_prezzi_excel
end type

type cb_esci from w_stampa`cb_esci within w_st_da_silver_prezzi_excel
integer x = 4507
integer y = 40
end type

type cbx_selezione from checkbox within w_st_da_silver_prezzi_excel
integer x = 1650
integer y = 40
integer width = 585
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Tutti"
end type

event clicked;if checked then
	cbx_selezione.text="Solo Selezionati"
	dw_1.setfilter("prezzo_confermato='C' and c_scelto=1")
else
	cbx_selezione.text="Tutti"
	dw_1.setfilter("")
end if
dw_1.filter()
if checked then
	integer i
	string ls_accessorio, ls_cod_articolo
	
	
	for i= 1 to dw_1.rowcount()  //poi farò una fetch... 20231211... su des_3 deve andarci accessorio
		ls_cod_articolo=dw_1.getitemstring(i, "articolo_codice")
		select first( accessorio) into :ls_accessorio
		from dba.bollettine_excel where cod_art_assegnato=:ls_cod_articolo
		order by data desc;
		if ls_cod_articolo>" " then dw_1.setitem(i, "prezzo_des_3", ls_accessorio)
		
	next
end if
end event

type dw_2 from udw_000 within w_st_da_silver_prezzi_excel
integer x = 2706
integer width = 713
integer height = 164
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_da_data_a_data"
end type

event itemchanged;call super::itemchanged;string ls_filtro
datetime ldt_da_data, ldt_a_data
time ltt_time

if dwo.name="a_data" then
	ltt_time=time("00:00:00")
	ldt_da_data=datetime(dw_2.getitemdate(1, "da_data"), ltt_time)
	ldt_a_data=datetime(date(data), ltt_time)
	ls_filtro="prezzo_ultima_modifica>=datetime('"+string(ldt_da_data, "yyyy/mm/dd")+"') and prezzo_ultima_modifica>=datetime('"+string(ldt_da_data, "yyyy/mm/dd")+"')" 
	dw_1.setfilter(ls_filtro)
	dw_1.filter()

end if
end event

