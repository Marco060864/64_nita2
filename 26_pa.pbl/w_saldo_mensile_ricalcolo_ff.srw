forward
global type w_saldo_mensile_ricalcolo_ff from w_wiz_main
end type
type cb_chiudi from commandbutton within w_saldo_mensile_ricalcolo_ff
end type
type cb_ricalcola from commandbutton within w_saldo_mensile_ricalcolo_ff
end type
type dw_saldo_mensile_ricalcolo_ff from u_dw_ext_main within w_saldo_mensile_ricalcolo_ff
end type
end forward

global type w_saldo_mensile_ricalcolo_ff from w_wiz_main
int X=832
int Y=360
int Width=2144
int Height=664
boolean TitleBar=true
string Title="Ricalcolo Saldi Mensili"
cb_chiudi cb_chiudi
cb_ricalcola cb_ricalcola
dw_saldo_mensile_ricalcolo_ff dw_saldo_mensile_ricalcolo_ff
end type
global w_saldo_mensile_ricalcolo_ff w_saldo_mensile_ricalcolo_ff

type variables
u_saldo_mensile_ricalcolo	iu_saldo_mensile_ricalcolo
end variables

forward prototypes
public subroutine uf_ricalcola ()
public function long uf_proponi_esercizio ()
end prototypes

public subroutine uf_ricalcola ();

long ll_CurrRow, ll_id_esercizio
string ls_conto_cod_da, ls_conto_cod_a, ls_esercizio_tutti

ll_CurrRow = dw_saldo_mensile_ricalcolo_ff.GetRow()

IF ll_CurrRow > 0 THEN
	ll_id_esercizio    = dw_saldo_mensile_ricalcolo_ff.GetItemNumber(ll_CurrRow, "id_esercizio")
	ls_conto_cod_da    = dw_saldo_mensile_ricalcolo_ff.GetItemString(ll_CurrRow, "conto_da_cod")
	ls_conto_cod_a     = dw_saldo_mensile_ricalcolo_ff.GetItemString(ll_CurrRow, "conto_a_cod")
	ls_esercizio_tutti = dw_saldo_mensile_ricalcolo_ff.GetItemString(ll_CurrRow, "esercizio_tutti")
	
	
	IF (ll_id_esercizio > 0) THEN
		
			SetPointer(HourGlass!)
			cb_chiudi.visible = FALSE
			cb_ricalcola.visible = FALSE
			
			iu_saldo_mensile_ricalcolo.uf_esegui(ll_id_esercizio, ls_conto_cod_da, ls_conto_cod_a, ls_esercizio_tutti)
			
			cb_chiudi.visible = TRUE
			cb_ricalcola.visible = TRUE
			SetPointer(Arrow!)
		
	ELSE
		MessageBox("Ricalcolo Saldi Mensili", "Immettere l'esercizio e i conti per i quali eseguire il ricalcolo.", Exclamation!)
	END IF
END IF
end subroutine

public function long uf_proponi_esercizio ();

long ll_RetVal

SELECT dba.azienda.id_esercizio_proposto
	INTO :ll_RetVal
	FROM dba.azienda
	WHERE dba.azienda.id_azienda in (0,1)
	USING SQLCA;
	
CHOOSE CASE SQLCA.SQLCode
	CASE -1
		MessageBox("Errore sul DataBase", "w_saldo_mensile_ricalcolo_ff / uf_proponi_esercizio / 1")
END CHOOSE

RETURN ll_RetVal
end function

on w_saldo_mensile_ricalcolo_ff.create
int iCurrent
call super::create
this.cb_chiudi=create cb_chiudi
this.cb_ricalcola=create cb_ricalcola
this.dw_saldo_mensile_ricalcolo_ff=create dw_saldo_mensile_ricalcolo_ff
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_chiudi
this.Control[iCurrent+2]=this.cb_ricalcola
this.Control[iCurrent+3]=this.dw_saldo_mensile_ricalcolo_ff
end on

on w_saldo_mensile_ricalcolo_ff.destroy
call super::destroy
destroy(this.cb_chiudi)
destroy(this.cb_ricalcola)
destroy(this.dw_saldo_mensile_ricalcolo_ff)
end on

event open;

long ll_CurrRow

ll_CurrRow = dw_saldo_mensile_ricalcolo_ff.GetRow()
IF ll_CurrRow = 0 THEN
	ll_CurrRow = dw_saldo_mensile_ricalcolo_ff.InsertRow(0)
	dw_saldo_mensile_ricalcolo_ff.SetItem(ll_CurrRow, "id_esercizio", uf_proponi_esercizio())
END IF

iu_saldo_mensile_ricalcolo = create u_saldo_mensile_ricalcolo

dw_saldo_mensile_ricalcolo_ff.Event ue_post_open()
end event

event close;

IF IsValid(iu_saldo_mensile_ricalcolo) THEN
	Destroy iu_saldo_mensile_ricalcolo
END IF
end event

type cb_chiudi from commandbutton within w_saldo_mensile_ricalcolo_ff
int X=389
int Y=40
int Width=247
int Height=88
int TabOrder=30
string Text="&Chiudi"
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Close(Parent)
end event

type cb_ricalcola from commandbutton within w_saldo_mensile_ricalcolo_ff
int X=46
int Y=40
int Width=297
int Height=88
int TabOrder=20
string Text="&Ricalcola"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

IF MessageBox("Ricalcolo Saldi Mensili", "Attenzione: Questa operazione potrebbe durare parecchi minuti.~rContinuare?", Exclamation!, YesNo!) = 1 THEN
	uf_ricalcola()
END IF

MessageBox("Ricalcolo Saldi Mensili", "Operazione terminata correttamente!")
close(parent)
	

end event

type dw_saldo_mensile_ricalcolo_ff from u_dw_ext_main within w_saldo_mensile_ricalcolo_ff
int X=46
int Y=180
int Width=2011
int Height=340
int TabOrder=10
string DataObject="d_saldo_mensile_ricalcolo_ff"
end type

event ue_init;call super::ue_init;is_colonne_drop[1] = "id_esercizio"
end event

event ue_set_search;

CHOOSE CASE as_nomecol
	CASE "conto_da_cod", "conto_da_des"
		is_search_window = "w_conti_pdc_sw"

		IF as_nomecol = "conto_da_cod" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "conto_codice"
		ELSEIF as_nomecol = "conto_da_des" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "conto_descrizione"
		END IF

		is_ricpar.b_imm_retrieve = TRUE

	CASE "conto_a_cod", "conto_a_des"
		is_search_window = "w_conti_pdc_sw"

		IF as_nomecol = "conto_a_cod" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "conto_codice"
		ELSEIF as_nomecol = "conto_a_des" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "conto_descrizione"
		END IF

		is_ricpar.b_imm_retrieve = TRUE
END CHOOSE
end event

event ue_use_search;

CHOOSE CASE as_nomecol
	CASE "conto_da_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_conto_da", is_ricpar.s_id_seg_value[1])
		uf_set_colval("conto_da_des", is_ricpar.s_ausil_value[1])
		if isnull(this.getitemstring(1, "conto_a_cod")) or this.getitemstring(1, "conto_a_cod")='' then
			 uf_set_colval("conto_a_cod", is_ricpar.s_main_value)
			 uf_set_colval("conto_a_des", is_ricpar.s_ausil_value[1])
		end if	 

	CASE "conto_da_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_conto_da", is_ricpar.s_id_seg_value[1])
		uf_set_colval("conto_da_cod", is_ricpar.s_ausil_value[1])
		if isnull(this.getitemstring(1, "conto_a_cod")) or this.getitemstring(1, "conto_a_cod")='' then
			 uf_set_colval("conto_a_des", is_ricpar.s_main_value)
			 uf_set_colval("conto_a_cod", is_ricpar.s_ausil_value[1])
		end if	 
		
	CASE "conto_a_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_conto_da", is_ricpar.s_id_seg_value[1])
		uf_set_colval("conto_a_des", is_ricpar.s_ausil_value[1])

	CASE "conto_a_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_conto_a", is_ricpar.s_id_seg_value[1])
		uf_set_colval("conto_a_cod", is_ricpar.s_ausil_value[1])

END CHOOSE
end event

event ue_default;call super::ue_default;

long ll_CurrRow, ll_id_esercizio, ll_id_conto_da
string ls_conto_cod_da, ls_conto_des_da

CHOOSE CASE string(adwo_current.name)
	CASE "id_esercizio"
		
		
		THIS.SetItem(al_row, "id_esercizio", uf_proponi_esercizio())
	CASE "conto_a_cod"
		ll_id_conto_da = THIS.GetItemNumber(al_row, "id_conto_da")
		ls_conto_cod_da = THIS.GetItemString(al_row, "conto_da_cod")
		ls_conto_des_da = THIS.GetItemString(al_row, "conto_da_des")
		
		THIS.SetItem(al_row, "id_conto_a", ll_id_conto_da)
		THIS.SetItem(al_row, "conto_a_cod", ls_conto_cod_da)
		THIS.SetItem(al_row, "conto_a_des", ls_conto_des_da)
END CHOOSE
end event

event itemchanged;

integer li_ok
string ls_dbc[], ls_dbv[], ls_dwc[], ls_campo

CHOOSE CASE dwo.name
	CASE "conto_da_cod", "conto_da_des"
		
		if dwo.name="conto_da_cod" then 
			ls_campo='codice'
		else
			ls_campo='descrizione'
		end if	

		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_conto"
		ls_dwc[1] = "conto_da_cod"
		ls_dwc[2] = "conto_da_des"
		ls_dwc[3] = "id_conto_da"
		li_ok = uf_autofind_col(string(dwo.name), "conto", ls_campo, "A", data, "", 3, ls_dbc, ls_dbv, ls_dwc)
		 
		IF li_ok > 0 THEN
			if isnull(this.getitemstring(1, "conto_a_cod")) or this.getitemstring(1, "conto_a_cod")='' then
			 this.setitem(1, "conto_a_cod", this.getitemstring(1, "conto_da_cod"))
		    this.setitem(1, "conto_a_des", this.getitemstring(1, "conto_da_des"))
		end if	
			RETURN 2
		END IF
	CASE "conto_a_cod", "conto_a_des"
		
		if dwo.name="conto_a_cod" then 
			ls_campo='codice'
		else
			ls_campo='descrizione'
		end if	

		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_conto"
		ls_dwc[1] = "conto_a_cod"
		ls_dwc[2] = "conto_a_des"
		ls_dwc[3] = "id_conto_da"
		li_ok = uf_autofind_col(string(dwo.name), "conto", ls_campo, "A", data, "", 3, ls_dbc, ls_dbv, ls_dwc)
		IF li_ok > 0 THEN
			RETURN 2
		END IF
	CASE "esercizio_tutti"
		CHOOSE CASE data
			CASE "0"
				THIS.Modify("id_esercizio.Background.Mode = 1")
			CASE "1"
				THIS.Modify("id_esercizio.Background.Mode = 0")
		END CHOOSE

END CHOOSE
end event

