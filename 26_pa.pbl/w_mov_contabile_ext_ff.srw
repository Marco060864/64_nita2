forward
global type w_mov_contabile_ext_ff from w_wiz_main
end type
type dw_mov_contabile_ext_ff from u_dw_ext_main within w_mov_contabile_ext_ff
end type
type cb_annulla from commandbutton within w_mov_contabile_ext_ff
end type
type cb_ok from commandbutton within w_mov_contabile_ext_ff
end type
end forward

global type w_mov_contabile_ext_ff from w_wiz_main
int X=430
int Y=348
int Width=2789
int Height=940
WindowType WindowType=response!
boolean TitleBar=true
string Title="Dettagli Movimento Contabile"
event ue_feed_array ( )
dw_mov_contabile_ext_ff dw_mov_contabile_ext_ff
cb_annulla cb_annulla
cb_ok cb_ok
end type
global w_mov_contabile_ext_ff w_mov_contabile_ext_ff

type variables
boolean ib_modified
string is_array[]
end variables

forward prototypes
public function long uf_validate ()
end prototypes

event ue_feed_array;

long ll_CurrRow
ll_CurrRow = dw_mov_contabile_ext_ff.GetRow()

IF ll_CurrRow > 0 THEN
	dw_mov_contabile_ext_ff.AcceptText()
	IF ib_modified = TRUE THEN
		is_array[1] = "1"
	ELSE
		is_array[1] = "0"
	END IF
	is_array[2] = dw_mov_contabile_ext_ff.uf_Get_Colval("id_mov_contabile")
	is_array[3] = dw_mov_contabile_ext_ff.uf_Get_Colval("id_conto")
	is_array[4] = dw_mov_contabile_ext_ff.uf_Get_Colval("conto_codice")
	is_array[5] = dw_mov_contabile_ext_ff.uf_Get_Colval("conto_descrizione")
	is_array[6] = dw_mov_contabile_ext_ff.uf_Get_Colval("valuta_codice")
	is_array[7] = dw_mov_contabile_ext_ff.uf_Get_Colval("valuta_descrizione")
	is_array[8] = dw_mov_contabile_ext_ff.uf_Get_Colval("cambio")
	is_array[9] = dw_mov_contabile_ext_ff.uf_Get_Colval("des_contabile")
	is_array[10] = dw_mov_contabile_ext_ff.uf_Get_Colval("dare")
	is_array[11] = dw_mov_contabile_ext_ff.uf_Get_Colval("avere")
	is_array[12] = dw_mov_contabile_ext_ff.uf_Get_Colval("data_val_banca")
	is_array[13] = dw_mov_contabile_ext_ff.uf_Get_Colval("data_inizio_competenza")
	is_array[14] = dw_mov_contabile_ext_ff.uf_Get_Colval("data_fine_competenza")
	is_array[15] = dw_mov_contabile_ext_ff.uf_Get_Colval("rateo_risconto")
END IF
end event

public function long uf_validate ();

long ll_CurrRow, ll_RetVal
date ld_data_inizio, ld_data_fine
ll_RetVal = 0
ll_CurrRow = dw_mov_contabile_ext_ff.GetRow()

IF ll_CurrRow > 0 THEN
	dw_mov_contabile_ext_ff.AcceptText()
	ld_data_inizio = dw_mov_contabile_ext_ff.GetItemDate(ll_CurrRow, "data_inizio_competenza")
	ld_data_fine = dw_mov_contabile_ext_ff.GetItemDate(ll_CurrRow, "data_fine_competenza")
	IF ld_data_fine < ld_data_inizio THEN
		MessageBox("Dettagli Movimento Contabile", "La data fine competenza deve precedere~rla data inizio competenza.")
		dw_mov_contabile_ext_ff.SetFocus()
		dw_mov_contabile_ext_ff.SetColumn("data_fine_competenza")
		ll_RetVal = 1
	END IF
END IF

RETURN ll_RetVal
end function

on w_mov_contabile_ext_ff.create
int iCurrent
call super::create
this.dw_mov_contabile_ext_ff=create dw_mov_contabile_ext_ff
this.cb_annulla=create cb_annulla
this.cb_ok=create cb_ok
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_mov_contabile_ext_ff
this.Control[iCurrent+2]=this.cb_annulla
this.Control[iCurrent+3]=this.cb_ok
end on

on w_mov_contabile_ext_ff.destroy
call super::destroy
destroy(this.dw_mov_contabile_ext_ff)
destroy(this.cb_annulla)
destroy(this.cb_ok)
end on

event open;call super::open;
il_HelpTopic = 27

long ll_CurrRow
string ls_setting
s_any_array lstr_array
ib_modified = FALSE

lstr_array = Message.PowerObjectParm
is_array = lstr_array.s_array
ll_CurrRow = dw_mov_contabile_ext_ff.GetRow()

IF ll_CurrRow = 0 THEN dw_mov_contabile_ext_ff.InsertRow(0)

dw_mov_contabile_ext_ff.uf_Set_Colval("id_mov_contabile", is_array[2])
dw_mov_contabile_ext_ff.uf_Set_Colval("id_conto", is_array[3])
dw_mov_contabile_ext_ff.uf_Set_Colval("conto_codice", is_array[4])
dw_mov_contabile_ext_ff.uf_Set_Colval("conto_descrizione", is_array[5])
dw_mov_contabile_ext_ff.uf_Set_Colval("valuta_codice", is_array[6])
dw_mov_contabile_ext_ff.uf_Set_Colval("valuta_descrizione", is_array[7])
dw_mov_contabile_ext_ff.uf_Set_Colval("cambio", is_array[8])
dw_mov_contabile_ext_ff.uf_Set_Colval("des_contabile", is_array[9])
dw_mov_contabile_ext_ff.uf_Set_Colval("dare", is_array[10])
dw_mov_contabile_ext_ff.uf_Set_Colval("avere", is_array[11])
dw_mov_contabile_ext_ff.uf_Set_Colval("data_val_banca", is_array[12])
dw_mov_contabile_ext_ff.uf_Set_Colval("data_inizio_competenza", is_array[13])
dw_mov_contabile_ext_ff.uf_Set_Colval("data_fine_competenza", is_array[14])
dw_mov_contabile_ext_ff.uf_Set_Colval("rateo_risconto", is_array[15])


IF is_array[16] = "1" THEN
	
	
	dw_mov_contabile_ext_ff.Object.dare.Edit.DisplayOnly = TRUE
	dw_mov_contabile_ext_ff.Object.avere.Edit.DisplayOnly = TRUE
	dw_mov_contabile_ext_ff.Object.data_val_banca.Edit.DisplayOnly = TRUE
	dw_mov_contabile_ext_ff.Object.data_inizio_competenza.Edit.DisplayOnly = TRUE
	dw_mov_contabile_ext_ff.Object.data_fine_competenza.Edit.DisplayOnly = TRUE
	dw_mov_contabile_ext_ff.Object.rateo_risconto.Protect = TRUE
	
	
	
END IF	

il_HelpTopic = long(is_array[17])

dw_mov_contabile_ext_ff.TriggerEvent("ue_post_open")
end event

event close;call super::close;

s_any_array lstr_array

lstr_array.s_array = is_array
CloseWithReturn(THIS, lstr_array)
end event

type dw_mov_contabile_ext_ff from u_dw_ext_main within w_mov_contabile_ext_ff
int X=46
int Y=160
int Width=2674
int Height=640
int TabOrder=10
string DataObject="d_mov_contabile_ext_ff"
end type

event ue_init;call super::ue_init;is_colonne_drop[1] = "des_contabile"
end event

event editchanged;call super::editchanged;

ib_modified = TRUE
end event

event itemchanged;call super::itemchanged;

ib_modified = TRUE
end event

type cb_annulla from commandbutton within w_mov_contabile_ext_ff
int X=343
int Y=40
int Width=261
int Height=84
int TabOrder=30
boolean BringToTop=true
string Text="Annulla"
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Close(parent)
end event

type cb_ok from commandbutton within w_mov_contabile_ext_ff
int X=46
int Y=40
int Width=261
int Height=84
int TabOrder=20
boolean BringToTop=true
string Text="Ok"
boolean Default=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

IF uf_validate() = 0 THEN
	w_mov_contabile_ext_ff.Event ue_feed_array()
	Close(parent)
END IF
end event

