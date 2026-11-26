forward
global type w_asp_beni_cx from w_p_data
end type
type dw_asp_beni_ff from u_dw_master_main within w_asp_beni_cx
end type
end forward

global type w_asp_beni_cx from w_p_data
int Width=1234
int Height=616
boolean TitleBar=true
string Title="Inserimento Aspetto dei beni"
dw_asp_beni_ff dw_asp_beni_ff
end type
global w_asp_beni_cx w_asp_beni_cx

on w_asp_beni_cx.create
int iCurrent
call super::create
this.dw_asp_beni_ff=create dw_asp_beni_ff
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_asp_beni_ff
end on

on w_asp_beni_cx.destroy
call super::destroy
destroy(this.dw_asp_beni_ff)
end on

event open;call super::open;

idw_master = dw_asp_beni_ff
idw_master.is_list = Message.PowerObjectParm

if Upperbound(idw_master.is_list.s_identifica)=0 then
	idw_master.ias_key_name[1] = "id_asp_beni"
	idw_master.is_list.s_modo=modo_inserisci
end if

end event

type p_crescente from w_p_data`p_crescente within w_asp_beni_cx
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_asp_beni_cx
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_asp_beni_cx
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_asp_beni_cx
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_asp_beni_cx
int X=631
int Y=44
boolean Visible=false
boolean BringToTop=true
FontCharSet FontCharSet=Ansi!
end type

type cb_inserisci from w_p_data`cb_inserisci within w_asp_beni_cx
int X=923
int Y=48
boolean Visible=false
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_asp_beni_cx
int X=1211
int Y=48
boolean Visible=false
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_asp_beni_cx
int X=1504
int Y=48
boolean Visible=false
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_asp_beni_cx
int X=37
int Y=1468
boolean BringToTop=true
end type

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=18
int Y=104
int Width=2322
int Height=1200
end type

type cb_ricerca from w_p_data`cb_ricerca within w_asp_beni_cx
boolean Visible=false
boolean BringToTop=true
end type

type dw_asp_beni_ff from u_dw_master_main within w_asp_beni_cx
int X=46
int Y=156
int Width=1129
int Height=340
int TabOrder=10
boolean BringToTop=true
string DataObject="d_asp_beni_ff"
end type

