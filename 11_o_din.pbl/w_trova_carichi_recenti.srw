forward
global type w_trova_carichi_recenti from w_001
end type
type dw_1 from udw_base within w_trova_carichi_recenti
end type
type cb_1 from commandbutton within w_trova_carichi_recenti
end type
end forward

global type w_trova_carichi_recenti from w_001
integer width = 2432
integer height = 1216
windowtype windowtype = response!
dw_1 dw_1
cb_1 cb_1
end type
global w_trova_carichi_recenti w_trova_carichi_recenti

type variables

end variables

on w_trova_carichi_recenti.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_1
end on

on w_trova_carichi_recenti.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_1)
end on

event open;call super::open;long ll_riga

dw_1.settransobject(sqlca)

ll_riga=dw_1.insertrow(0)
dw_1.setitem(ll_riga, "fisso", "Vs. Carico C/Lav. Fino DDT. n. ")
ll_riga=dw_1.insertrow(0)
dw_1.setitem(ll_riga, "fisso", "Ns. Scarico C/Lav. Fino DDT. n. ")


//long ll_id_sog, rtncode
//datawindowchild dwc_prof, dwc_sog
//date ldt_da_data
//
//
//rtncode =dw_2.getchild("id_soggetto", dwc_sog)
//IF rtncode = -1 THEN MessageBox("Error", "Not a DataWindowChild sog")
//CONNECT USING SQLCA;
//dwc_sog.SetTransObject(SQLCA)
//dwc_sog.Retrieve()
//
//rtncode =dw_2.getchild("id_prof_doc", dwc_prof)
//IF rtncode = -1 THEN MessageBox("Error", "Not a DataWindowChild Prof")
//CONNECT USING SQLCA;
//dwc_prof.SetTransObject(SQLCA)
//dwc_prof.Retrieve()
//
////dw_2.SetTransObject(SQLCA)
////dw_2.insertrow(1)
////
////ll_id_sog=message.doubleparm
////if ll_id_sog>0 then
////	dw_2.post setitem(1, "id_soggetto", ll_id_sog)
////end if
////dw_2.post setitem(1, "id_prof_doc", 50)
////dw_1.settransobject(sqlca)
////
////ldt_da_data=dw_2.getitemdate(1, "da_data")
////dw_2.post setitem(1, "da_data", relativedate(ldt_da_data, -30))
//
//

end event

type st_1 from w_001`st_1 within w_trova_carichi_recenti
end type

type dw_1 from udw_base within w_trova_carichi_recenti
integer x = 59
integer y = 230
integer width = 2282
integer height = 845
boolean bringtotop = true
string dataobject = "d_scritta_manuale"
end type

type cb_1 from commandbutton within w_trova_carichi_recenti
integer x = 2107
integer y = 128
integer width = 205
integer height = 90
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "OK"
end type

event clicked;integer i
string ls_numero, ls_fisso
decimal ldc_peso,  ldc_peso_old
s_per_carichi s_car



for I= 1 to 2
	ls_fisso=dw_1.getitemstring(i, "fisso")
	ls_numero=dw_1.getitemstring(i, "numero")
	
	ldc_peso=dw_1.getitemdecimal(i, "peso")
	s_car.ls_doc_carico[i]=ls_fisso+ls_numero+" GR. "+string(ldc_peso, "#,0.00")
	if ldc_peso_old>0 then
		s_car.peso=ldc_peso_old - ldc_peso	
	end if
	ldc_peso_old=ldc_peso
next

CloseWithReturn(Parent, s_car)
end event

