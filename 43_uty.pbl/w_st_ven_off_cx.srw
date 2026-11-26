forward
global type w_st_ven_off_cx from w_wiz_main
end type
type dw_1 from u_dw_ext_main within w_st_ven_off_cx
end type
type cb_1 from commandbutton within w_st_ven_off_cx
end type
type cb_2 from commandbutton within w_st_ven_off_cx
end type
type dw_2 from u_dw_ext_main within w_st_ven_off_cx
end type
type dw_3 from u_dw_ext_main within w_st_ven_off_cx
end type
end forward

global type w_st_ven_off_cx from w_wiz_main
int Width=1769
int Height=956
boolean TitleBar=true
string Title="Stampa venduto articoli in Offerta"
long BackColor=80133307
dw_1 dw_1
cb_1 cb_1
cb_2 cb_2
dw_2 dw_2
dw_3 dw_3
end type
global w_st_ven_off_cx w_st_ven_off_cx

on w_st_ven_off_cx.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_2=create dw_2
this.dw_3=create dw_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.dw_2
this.Control[iCurrent+5]=this.dw_3
end on

on w_st_ven_off_cx.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_2)
destroy(this.dw_3)
end on

event open;call super::open;dw_1.insertrow(0)
end event

event ue_post_open;call super::ue_post_open;datawindowchild ldw_tipo

dw_1.GetChild("da_mod_reg", ldw_tipo)
dw_1.accepttext()


ldw_tipo.settransobject(sqlca)
ldw_tipo.retrieve()

end event

type dw_1 from u_dw_ext_main within w_st_ven_off_cx
int X=37
int Y=164
int Width=1646
int Height=640
int TabOrder=10
boolean BringToTop=true
string DataObject="d_ven_off_sel"
end type

type cb_1 from commandbutton within w_st_ven_off_cx
int X=1106
int Y=32
int Width=247
int Height=100
int TabOrder=30
boolean BringToTop=true
string Text="&Stampa"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;date ld_da_data, ld_a_data, ld_data_stampa
long ll_ret, i, ll_ret2, ll_id_art, ll_ret3
string ls_da_art, ls_a_art, ls_tipo_reg
integer li_anno, li_mese
st_ven_off str

ld_da_data = dw_1.getitemdate(1,"da_data")
ld_a_data  = dw_1.getitemdate(1,"a_data")
ld_data_stampa = dw_1.getitemdate(1,"data_stampa") 
if isnull(ld_data_stampa) then ld_data_stampa = today() 
li_anno = year(ld_data_stampa) 
li_mese = month(ld_data_stampa) 
ls_tipo_reg = dw_1.getitemstring(1,"da_mod_reg")


DATASTORE ds_con_lis
ds_con_lis = CREATE DATASTORE
ds_con_lis.DATAOBJECT = "ds_ven_off_con"
ds_con_lis.SETTRANSOBJECT(SQLCA)

dw_2.SETTRANSOBJECT(SQLCA)
dw_2.reset()

dw_3.SETTRANSOBJECT(SQLCA)
dw_3.reset()

ll_ret = ds_con_lis.retrieve(ld_da_data, ld_a_data) 

FOR i=1 TO ll_ret
	ls_da_art = ds_con_lis.getitemstring(i,"articolo_codice")
	ls_a_art  = ds_con_lis.getitemstring(i,"articolo_codice_1")
	ll_ret2 = dw_2.retrieve(ls_da_art, ls_a_art)
NEXT

ll_ret2 = dw_2.rowcount()

FOR i=1 TO ll_ret2
	ll_id_art = dw_2.getitemnumber(i,"id_articolo")
	ll_ret3 = dw_3.retrieve(ll_id_art,ld_da_data,ld_a_data,ls_tipo_reg, li_anno, li_mese) 
NEXT

destroy ds_con_lis

str.dw = dw_3
str.data1 = ld_da_data
str.data2 = ld_a_data
str.anno  = li_anno 
str.mese  = li_mese 
str.data_stampa = ld_data_stampa 

if ll_ret3 > 0 then openWithParm(w_st_ven_off_rpt, str)

end event

type cb_2 from commandbutton within w_st_ven_off_cx
int X=1431
int Y=32
int Width=247
int Height=100
int TabOrder=40
boolean BringToTop=true
string Text="&Esci"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Close(Parent)
end event

type dw_2 from u_dw_ext_main within w_st_ven_off_cx
int X=37
int Y=8
int Width=297
int Height=140
int TabOrder=20
boolean Visible=false
boolean BringToTop=true
string DataObject="ds_ven_off_art"
end type

event retrievestart;return 2
end event

type dw_3 from u_dw_ext_main within w_st_ven_off_cx
int X=375
int Y=12
int Width=366
int Height=140
int TabOrder=11
boolean Visible=false
boolean BringToTop=true
string DataObject="ds_ven_off_doc"
end type

event retrievestart;RETURN 2
end event

