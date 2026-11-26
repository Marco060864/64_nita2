forward
global type w_conv_euro_lire_ff from w_np_single_data
end type
type dw_1 from datawindow within w_conv_euro_lire_ff
end type
end forward

global type w_conv_euro_lire_ff from w_np_single_data
int Width=2048
int Height=1004
boolean TitleBar=true
string Title="Euro Convertitore"
dw_1 dw_1
end type
global w_conv_euro_lire_ff w_conv_euro_lire_ff

type variables
decimal idc_cambio
integer ii_num_dec
string is_tipo_arr
end variables

forward prototypes
public subroutine wf_recupera_parametri ()
end prototypes

public subroutine wf_recupera_parametri ();idc_cambio=dw_1.getitemdecimal(1, "cambio")
ii_num_dec=dw_1.getitemnumber(1, "num_dec")
is_tipo_arr=dw_1.getitemstring(1, "tipo_arr")
end subroutine

on w_conv_euro_lire_ff.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on w_conv_euro_lire_ff.destroy
call super::destroy
destroy(this.dw_1)
end on

event open;call super::open;dw_1.insertrow(1)
idc_cambio=dw_1.getitemdecimal(1, "cambio")
ii_num_dec=dw_1.getitemnumber(1, "num_dec")
is_tipo_arr=dw_1.getitemstring(1, "tipo_arr")
end event

event resize;
end event

type dw_single from w_np_single_data`dw_single within w_conv_euro_lire_ff
int Y=208
int Height=664
string DataObject="d_conv_euro_lire_ff"
BorderStyle BorderStyle=StyleLowered!
end type

event dw_single::editchanged;if dwo.name='euro' then
	setitem(row, "lire", f_round(dec(data)*idc_cambio, ii_num_dec,is_tipo_arr))
elseif dwo.name='lire' then
	setitem(row, "euro", f_round(dec(data)/idc_cambio, ii_num_dec, is_tipo_arr))
end if
end event

type dw_1 from datawindow within w_conv_euro_lire_ff
int X=46
int Y=16
int Width=1920
int Height=184
int TabOrder=10
boolean BringToTop=true
string DataObject="d_parametri_euro"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

event itemchanged;post wf_recupera_parametri()
end event

