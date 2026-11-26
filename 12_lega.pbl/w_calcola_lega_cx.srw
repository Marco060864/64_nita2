forward
global type w_calcola_lega_cx from w_001
end type
type dw_1 from udw_base within w_calcola_lega_cx
end type
type dw_2 from udw_base within w_calcola_lega_cx
end type
type dw_3 from datawindow within w_calcola_lega_cx
end type
type cb_1 from commandbutton within w_calcola_lega_cx
end type
type cb_2 from commandbutton within w_calcola_lega_cx
end type
type cb_3 from commandbutton within w_calcola_lega_cx
end type
end forward

global type w_calcola_lega_cx from w_001
int Width=1577
int Height=1384
boolean TitleBar=true
string Title="Calcolo Leghe"
boolean MinBox=true
boolean MaxBox=true
dw_1 dw_1
dw_2 dw_2
dw_3 dw_3
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
end type
global w_calcola_lega_cx w_calcola_lega_cx

on w_calcola_lega_cx.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_2=create dw_2
this.dw_3=create dw_3
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.dw_3
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.cb_2
this.Control[iCurrent+6]=this.cb_3
end on

on w_calcola_lega_cx.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
end on

event open;DataWindowChild dwc_lega, dwc_tit, dwc_des

integer rtncode
rtncode = dw_1.GetChild('id_lega', dwc_lega)
IF rtncode = -1 THEN MessageBox("Error", "Not a DataWindowChild")
rtncode = dw_1.GetChild('titolo', dwc_tit)
IF rtncode = -1 THEN MessageBox("Error", "Not a DataWindowChild")
rtncode = dw_1.GetChild('des', dwc_des)
IF rtncode = -1 THEN MessageBox("Error", "Not a DataWindowChild")


CONNECT USING SQLCA;	


dwc_lega.SetTransObject(SQLCA)
dw_2.settransobject(sqlca)
dwc_des.SetTransObject(SQLCA)
dwc_tit.SetTransObject(SQLCA)
dwc_lega.Retrieve()
dwc_des.Retrieve()
dwc_tit.Retrieve()
dw_1.insertrow(1)
dw_3.insertrow(1)



end event

type dw_1 from udw_base within w_calcola_lega_cx
int X=23
int Y=32
int Width=1518
int Height=268
boolean BringToTop=true
string DataObject="d_lega_testa_cx"
end type

event itemchanged;long ll_id_lega
decimal ldc_qta
dw_3.Setitem(1, "QTA_RICHIESTA",0)
ll_id_lega=long(data)
dw_2.retrieve(ll_id_lega, 0)
end event

type dw_2 from udw_base within w_calcola_lega_cx
int X=23
int Y=424
int Width=1509
int Height=852
int TabOrder=20
boolean BringToTop=true
string DataObject="d_riga_lega"
end type

type dw_3 from datawindow within w_calcola_lega_cx
int X=759
int Y=332
int Width=741
int Height=88
int TabOrder=50
boolean BringToTop=true
string DataObject="d_qta_richiesta"
boolean Border=false
boolean LiveScroll=true
end type

event itemchanged;long ll_id_lega, LL_ID_MET, LL_RIGA
decimal ldc_tit

ll_id_lega=dw_1.getitemnumber(1, "id_lega")
if ll_id_lega>0 then
	select id_metallo
	into :LL_ID_MET
	from orafo_titolo
	where id_titolo=:ll_id_lega;
	LL_RIGA=dw_2.find("id_metallo="+string(LL_ID_MET), 1, dw_2.rowcount())
	if LL_ID_MET>0 then
		ldc_tit=dw_2.getitemdecimal(LL_RIGA, "qta_lega")
		ldc_tit=dec(data)*1000/ldc_tit
		dw_2.retrieve(ll_id_lega, ldc_tit)
	end if
end if

end event

type cb_1 from commandbutton within w_calcola_lega_cx
int X=23
int Y=308
int Width=224
int Height=108
int TabOrder=30
boolean BringToTop=true
string Text="Inserisci"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_riga, ll_row
ll_riga=dw_1.getitemdecimal(1, "id_lega")
if ll_riga>0 then
	ll_row=dw_2.insertrow(0)
	dw_2.setitem(ll_row, "id_lega", ll_riga)
end if
end event

type cb_2 from commandbutton within w_calcola_lega_cx
int X=270
int Y=308
int Width=233
int Height=108
int TabOrder=40
boolean BringToTop=true
string Text="Cancella"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_riga_corrente
ll_riga_corrente=dw_2.getrow()
if ll_riga_corrente>0 then
	dw_2.deleterow(ll_riga_corrente)
end if
end event

type cb_3 from commandbutton within w_calcola_lega_cx
int X=521
int Y=308
int Width=224
int Height=108
int TabOrder=50
boolean BringToTop=true
string Text="Salva"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_2.update()
end event

