forward
global type w_trasporto_mezzo_ff from w_p_data
end type
type dw_trasporto_mezzo_ff from u_dw_master_main within w_trasporto_mezzo_ff
end type
end forward

global type w_trasporto_mezzo_ff from w_p_data
int Width=2423
int Height=848
dw_trasporto_mezzo_ff dw_trasporto_mezzo_ff
end type
global w_trasporto_mezzo_ff w_trasporto_mezzo_ff

on w_trasporto_mezzo_ff.create
int iCurrent
call super::create
this.dw_trasporto_mezzo_ff=create dw_trasporto_mezzo_ff
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_trasporto_mezzo_ff
end on

on w_trasporto_mezzo_ff.destroy
call super::destroy
destroy(this.dw_trasporto_mezzo_ff)
end on

type cb_ok from w_p_data`cb_ok within w_trasporto_mezzo_ff
int X=37
int Y=28
end type

type cb_annulla from w_p_data`cb_annulla within w_trasporto_mezzo_ff
int X=329
int Y=28
end type

type cb_nuovo from w_p_data`cb_nuovo within w_trasporto_mezzo_ff
int X=622
int Y=28
end type

type cb_inserisci from w_p_data`cb_inserisci within w_trasporto_mezzo_ff
int X=1541
int Y=28
end type

type cb_cancella from w_p_data`cb_cancella within w_trasporto_mezzo_ff
int X=1829
int Y=28
end type

type cb_salva from w_p_data`cb_salva within w_trasporto_mezzo_ff
int X=2121
int Y=28
end type

type tab_1 from w_p_data`tab_1 within w_trasporto_mezzo_ff
int Y=1404
int Height=76
end type

type cb_ricerca from w_p_data`cb_ricerca within w_trasporto_mezzo_ff
int X=1243
int Y=28
end type

type dw_trasporto_mezzo_ff from u_dw_master_main within w_trasporto_mezzo_ff
int X=37
int Y=160
int Width=2345
int Height=580
int TabOrder=10
boolean BringToTop=true
string DataObject="d_trasporto_mezzo_ff"
end type

