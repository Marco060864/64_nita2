forward
global type w_conto_saldi_cx from w_wiz_main
end type
type cb_ok from commandbutton within w_conto_saldi_cx
end type
type dw_saldo_mensile_gd from u_dw_pura within w_conto_saldi_cx
end type
end forward

global type w_conto_saldi_cx from w_wiz_main
int X=833
int Y=361
int Width=2634
int Height=1497
WindowType WindowType=response!
boolean TitleBar=true
string Title="Saldi Mensili"
cb_ok cb_ok
dw_saldo_mensile_gd dw_saldo_mensile_gd
end type
global w_conto_saldi_cx w_conto_saldi_cx

forward prototypes
public subroutine uf_attiva_est_conto ()
end prototypes

public subroutine uf_attiva_est_conto ();

long ll_CurrRow, ll_IDConto
ll_CurrRow = dw_saldo_mensile_gd.GetRow()

IF ll_CurrRow > 0 THEN
	ll_IDConto = dw_saldo_mensile_gd.GetItemNumber(ll_CurrRow, "id_conto")

	IF ll_IDConto > 0 THEN
		OpenWithParm(w_est_conto_cx, ll_IDConto)
	END IF
END IF

end subroutine

on w_conto_saldi_cx.create
int iCurrent
call w_wiz_main::create
this.cb_ok=create cb_ok
this.dw_saldo_mensile_gd=create dw_saldo_mensile_gd
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=cb_ok
this.Control[iCurrent+2]=dw_saldo_mensile_gd
end on

on w_conto_saldi_cx.destroy
call w_wiz_main::destroy
destroy(this.cb_ok)
destroy(this.dw_saldo_mensile_gd)
end on

event open;call super::open;

long			ll_id_conto
string		ls_conto_cod, ls_conto_des
s_list_main	lstr_1

lstr_1 = message.PowerObjectParm

ll_id_conto = lstr_1.l_identifica[1]


SELECT conto.codice, conto.descrizione
	INTO :ls_conto_cod, :ls_conto_des
	FROM "dba".conto
	WHERE conto.id_conto = :ll_id_conto;
	
CHOOSE CASE SQLCA.SQLCode
	CASE 0
		THIS.title = THIS.title + " - " + ls_conto_cod + " " + ls_conto_des
	CASE -1
		MessageBox("Errore sul DataBase","w_conto_saldi_cx / open / 1")
END CHOOSE

dw_saldo_mensile_gd.SetTransObject(SQLCA)
dw_saldo_mensile_gd.Retrieve(ll_id_conto)

end event

type cb_ok from commandbutton within w_conto_saldi_cx
event clicked pbm_bnclicked
int X=46
int Y=41
int Width=261
int Height=85
int TabOrder=20
boolean BringToTop=true
string Text="Chiudi"
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Close(Parent)
end event

type dw_saldo_mensile_gd from u_dw_pura within w_conto_saldi_cx
int X=46
int Y=161
int Width=2497
int Height=1165
int TabOrder=10
string DataObject="d_saldo_mensile_gd"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event doubleclicked;call super::doubleclicked;

uf_attiva_est_conto()
end event

event rowfocuschanged;call super::rowfocuschanged;SelectRow(0, FALSE)
SelectRow(currentrow, TRUE)
end event

