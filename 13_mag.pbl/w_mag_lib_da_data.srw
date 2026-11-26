forward
global type w_mag_lib_da_data from w_selezione_ext
end type
type cb_2 from commandbutton within w_mag_lib_da_data
end type
type cb_3 from commandbutton within w_mag_lib_da_data
end type
type dw_2 from udw_001 within w_mag_lib_da_data
end type
end forward

global type w_mag_lib_da_data from w_selezione_ext
integer width = 3493
integer height = 1556
cb_2 cb_2
cb_3 cb_3
dw_2 dw_2
end type
global w_mag_lib_da_data w_mag_lib_da_data

on w_mag_lib_da_data.create
int iCurrent
call super::create
this.cb_2=create cb_2
this.cb_3=create cb_3
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_2
this.Control[iCurrent+2]=this.cb_3
this.Control[iCurrent+3]=this.dw_2
end on

on w_mag_lib_da_data.destroy
call super::destroy
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.dw_2)
end on

event open;call super::open;dw_2.settransobject(sqlca)

dw_1.setitem(1, "da_data", relativedate(today(), -90))
dw_1.setitem(1, "a_data", today())
end event

type cb_1 from w_selezione_ext`cb_1 within w_mag_lib_da_data
integer x = 82
integer y = 1196
end type

type cb_ok from w_selezione_ext`cb_ok within w_mag_lib_da_data
integer x = 832
integer y = 40
integer width = 398
integer height = 240
end type

event cb_ok::clicked;call super::clicked;date ld_da_data, ld_a_data
long ll_id_doc,ll_riga
string ls_num

dw_1.accepttext()
ld_da_data=dw_1.getitemdate(1,"da_data")
ld_a_data=dw_1.getitemdate(1,"a_data")

declare trova_doc cursor for 
	select id_documento
	from dba.documento
	where id_prof_documento=236 and data_documento>= :ld_da_data and  data_documento<= :ld_a_data;
	
	OPEN trova_doc;

FETCH trova_doc INTO :ll_id_doc;


DO WHILE sqlca.sqlcode=0
	ll_riga=dw_2.insertrow(0)
	select num_documento into :ls_num from  documento where id_documento=:ll_id_doc;
	dw_2.setitem(ll_riga, "c_articolo_1"," doc. n. "+ls_num)
	dw_2.retrieve(ll_id_doc)
	FETCH trova_doc INTO :ll_id_doc;
	
LOOP

CLOSE trova_doc;

end event

type dw_1 from w_selezione_ext`dw_1 within w_mag_lib_da_data
integer width = 741
integer height = 240
string dataobject = "d_da_data_a_data"
end type

type cb_2 from commandbutton within w_mag_lib_da_data
integer x = 2935
integer y = 1196
integer width = 402
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stampa"
end type

event clicked;dw_2.print(true,true)




end event

type cb_3 from commandbutton within w_mag_lib_da_data
integer x = 2487
integer y = 1196
integer width = 402
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Excel"
end type

event clicked;string ls_nome_stampa

ls_nome_stampa="c:\nita\maglib\"
ls_nome_stampa+="ML_"+string(dw_1.getitemdate(1, "Da_data"), "dd-mm-yy")+".xls"
dw_2.SaveAs(ls_nome_stampa, Excel!, FALSE)













//long ll_id_prof_documento
//datastore ds_silver
//string ls_nome_stampa, ls_ret
//INTEGER LI_RET
//
//
//ll_id_prof_documento=idw_gen.getitemnumber(1, "id_prof_documento")
//if ll_id_prof_documento=236 then  //236 merce mag libero per Martina Kar 20241024
//	ds_silver=create datastore
//	ds_silver.dataobject="d_riga_doc_mag_libero"
//	ds_silver.settransobject(sqlca)
//	ds_silver.retrieve(il_id_documento)
//	//ds_silver.print(true,true)
//	ls_nome_stampa="c:\nita\maglib\"
//	ls_nome_stampa+="ML_"+idw_gen.getitemstring(1, "num_documento")+"_.xls"
//	
//	ds_silver.setsort("id_articolo")
//	ds_silver.sort()
//	li_ret=ds_silver.SaveAs(ls_nome_stampa, Excel!, FALSE)
//	
//	destroy ds_silver
//	
//
//end if
//
end event

type dw_2 from udw_001 within w_mag_lib_da_data
integer x = 59
integer y = 324
integer width = 3305
integer height = 828
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_riga_doc_mag_libero"
end type

event retrievestart;call super::retrievestart;return 2
end event

