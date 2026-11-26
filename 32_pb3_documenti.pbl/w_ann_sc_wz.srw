forward
global type w_ann_sc_wz from w_wiz_main
end type
type dw_ann_sc_wz from u_dw_ext_main within w_ann_sc_wz
end type
end forward

global type w_ann_sc_wz from w_wiz_main
int Width=2267
int Height=808
boolean TitleBar=true
string Title="Annotazione del Sogg. Commerciale"
dw_ann_sc_wz dw_ann_sc_wz
end type
global w_ann_sc_wz w_ann_sc_wz

type variables

end variables

on w_ann_sc_wz.create
int iCurrent
call super::create
this.dw_ann_sc_wz=create dw_ann_sc_wz
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_ann_sc_wz
end on

on w_ann_sc_wz.destroy
call super::destroy
destroy(this.dw_ann_sc_wz)
end on

event open;call super::open;char lc_bloccante

dw_ann_sc_wz.settransobject(sqlca)
dw_ann_sc_wz.retrieve()

if (dw_ann_sc_wz.rowcount() > 0) then 
	lc_bloccante = dw_ann_sc_wz.getitemstring(1, "tipo_annotazione_bloccante")
	if (lc_bloccante = 'S') then w_ann_sc_wz.title = 'Annotazione bloccante del Sogg. Commerciale'
end if 
end event

type dw_ann_sc_wz from u_dw_ext_main within w_ann_sc_wz
int X=27
int Y=32
int Width=2171
int Height=644
int TabOrder=10
boolean BringToTop=true
string DataObject="d_ann_sc_wz"
boolean VScrollBar=true
end type

event sqlpreview;s_ann_sc	lst
string	ls_sql

lst = message.powerobjectparm

ls_sql = sqlsyntax
ls_sql = ls_sql + " AND annotazione.id_tipo_annotazione = " + string(lst.id_tipo_annotazione)
ls_sql = ls_sql + " AND	annotazione.id_sog_commerciale  = " + string(lst.id_sog_commerciale)

setsqlpreview(ls_sql)
end event

