forward
global type w_est_conto_cx from w_wiz_main
end type
type dw_est_conto_anno_lt from u_dw_pura within w_est_conto_cx
end type
type dw_est_conto_lt from u_dw_pura within w_est_conto_cx
end type
type cb_ok from commandbutton within w_est_conto_cx
end type
end forward

global type w_est_conto_cx from w_wiz_main
int X=833
int Y=361
int Width=2556
int Height=1525
WindowType WindowType=response!
boolean TitleBar=true
string Title="Estratto Conto"
dw_est_conto_anno_lt dw_est_conto_anno_lt
dw_est_conto_lt dw_est_conto_lt
cb_ok cb_ok
end type
global w_est_conto_cx w_est_conto_cx

on w_est_conto_cx.create
int iCurrent
call w_wiz_main::create
this.dw_est_conto_anno_lt=create dw_est_conto_anno_lt
this.dw_est_conto_lt=create dw_est_conto_lt
this.cb_ok=create cb_ok
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=dw_est_conto_anno_lt
this.Control[iCurrent+2]=dw_est_conto_lt
this.Control[iCurrent+3]=cb_ok
end on

on w_est_conto_cx.destroy
call w_wiz_main::destroy
destroy(this.dw_est_conto_anno_lt)
destroy(this.dw_est_conto_lt)
destroy(this.cb_ok)
end on

event open;call super::open;
il_HelpTopic = 309

long ll_id_conto
string ls_conto_cod, ls_conto_des
ll_id_conto = Message.DoubleParm

SELECT conto.codice,
       conto.descrizione
	INTO :ls_conto_cod, 
	     :ls_conto_des
	FROM conto
	WHERE conto.id_conto = :ll_id_conto;
	
CHOOSE CASE SQLCA.SQLCode
	CASE 0
		THIS.title = THIS.title + " - " + ls_conto_cod + " " + ls_conto_des
	CASE -1
		MessageBox("Errore sul DataBase","w_est_conto_cx / open / 1")
END CHOOSE

dw_est_conto_lt.SetTransObject(SQLCA)
dw_est_conto_lt.Retrieve(ll_id_conto)

dw_est_conto_anno_lt.SetTransObject(SQLCA)
dw_est_conto_anno_lt.Retrieve(ll_id_conto)
end event

type dw_est_conto_anno_lt from u_dw_pura within w_est_conto_cx
int X=46
int Y=801
int Width=2437
int Height=601
int TabOrder=11
string DataObject="d_est_conto_anno_lt"
boolean TitleBar=true
string Title="Saldi per Esercizio"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event rowfocuschanged;

long ll_id_esercizio, ll_row

SelectRow(0, FALSE)
SelectRow(currentrow, TRUE)

ll_id_esercizio = dw_est_conto_anno_lt.GetItemNumber(currentrow, "saldo_mensile_id_esercizio")
ll_row = dw_est_conto_lt.Find("registro_id_esercizio = " + string(ll_id_esercizio), 1, dw_est_conto_lt.RowCount())

dw_est_conto_lt.SetRow(ll_row)
dw_est_conto_lt.ScrollToRow(ll_row)
end event

type dw_est_conto_lt from u_dw_pura within w_est_conto_cx
int X=46
int Y=161
int Width=2437
int Height=601
int TabOrder=10
string DataObject="d_est_conto_lt"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event rowfocuschanged;

SelectRow(0, FALSE)
SelectRow(currentrow, TRUE)
end event

type cb_ok from commandbutton within w_est_conto_cx
event clicked pbm_bnclicked
int X=46
int Y=41
int Width=261
int Height=85
int TabOrder=20
boolean BringToTop=true
string Text="Chiudi"
boolean Default=true
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Close(Parent)
end event

