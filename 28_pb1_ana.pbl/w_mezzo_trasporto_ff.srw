forward
global type w_mezzo_trasporto_ff from w_p_data
end type
type dw_mezzo_trasporto_ff from u_dw_master_main within w_mezzo_trasporto_ff
end type
end forward

global type w_mezzo_trasporto_ff from w_p_data
int Width=2423
int Height=848
boolean TitleBar=true
string Title="Gestione Mezzi di Trasporto"
dw_mezzo_trasporto_ff dw_mezzo_trasporto_ff
end type
global w_mezzo_trasporto_ff w_mezzo_trasporto_ff

on w_mezzo_trasporto_ff.create
int iCurrent
call super::create
this.dw_mezzo_trasporto_ff=create dw_mezzo_trasporto_ff
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_mezzo_trasporto_ff
end on

on w_mezzo_trasporto_ff.destroy
call super::destroy
destroy(this.dw_mezzo_trasporto_ff)
end on

event open;call super::open;il_HelpTopic = 75
idw_master = dw_mezzo_trasporto_ff
idw_master.is_list = Message.PowerObjectParm

if Upperbound(idw_master.is_list.s_identifica)=0 then
	idw_master.ias_key_name[1] = "id_mezzo_trasporto"
	idw_master.is_list.s_modo=modo_inserisci
end if

idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_sql_ident[1] = "mezzo_trasporto.id_mezzo_trasporto"
ib_nonmodale=true






end event

type cb_ok from w_p_data`cb_ok within w_mezzo_trasporto_ff
int X=37
int Y=28
end type

type cb_annulla from w_p_data`cb_annulla within w_mezzo_trasporto_ff
int X=329
int Y=28
end type

type cb_nuovo from w_p_data`cb_nuovo within w_mezzo_trasporto_ff
int X=622
int Y=28
end type

type cb_inserisci from w_p_data`cb_inserisci within w_mezzo_trasporto_ff
int X=1541
int Y=28
end type

type cb_cancella from w_p_data`cb_cancella within w_mezzo_trasporto_ff
int X=1829
int Y=28
end type

type cb_salva from w_p_data`cb_salva within w_mezzo_trasporto_ff
int X=2121
int Y=28
end type

type tab_1 from w_p_data`tab_1 within w_mezzo_trasporto_ff
int Y=1404
int Height=76
end type

type cb_ricerca from w_p_data`cb_ricerca within w_mezzo_trasporto_ff
int X=1243
int Y=28
end type

type dw_mezzo_trasporto_ff from u_dw_master_main within w_mezzo_trasporto_ff
int X=37
int Y=160
int Width=2345
int Height=580
int TabOrder=10
boolean BringToTop=true
string DataObject="d_mezzo_trasporto_ff"
end type

