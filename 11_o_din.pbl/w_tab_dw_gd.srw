forward
global type w_tab_dw_gd from w_np_single_data
end type
type cb_esporta from commandbutton within w_tab_dw_gd
end type
end forward

global type w_tab_dw_gd from w_np_single_data
int Width=2025
int Height=996
boolean TitleBar=true
string Title="Tabelle del Report di Stampa"
cb_esporta cb_esporta
end type
global w_tab_dw_gd w_tab_dw_gd

on w_tab_dw_gd.create
int iCurrent
call super::create
this.cb_esporta=create cb_esporta
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_esporta
end on

on w_tab_dw_gd.destroy
call super::destroy
destroy(this.cb_esporta)
end on

event open;call super::open;DataWindowChild dwc_conf
integer rtncode
long ll_id_conf

rtncode = dw_single.GetChild('id_conf_oggetti', dwc_conf)
IF rtncode = -1 THEN MessageBox("Error", "Not a DataWindowChild")


CONNECT USING SQLCA;	


dwc_conf.SetTransObject(SQLCA)


dwc_conf.Retrieve()

ll_id_conf=message.doubleparm
if ll_id_conf>0 then
	dw_single.setfilter("id_conf_oggetti="+string(ll_id_conf))
	dw_single.filter()
end if
end event

type p_crescente from w_np_single_data`p_crescente within w_tab_dw_gd
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_tab_dw_gd
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_tab_dw_gd
int X=32
int Y=152
int Width=1911
int Height=724
string DataObject="d_din_tab_alias"
end type

type cb_esporta from commandbutton within w_tab_dw_gd
int X=91
int Y=12
int Width=247
int Height=108
int TabOrder=10
boolean BringToTop=true
string Text="Esporta"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_single.saveas()
end event

