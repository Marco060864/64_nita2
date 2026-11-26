forward
global type w_riepilogo_ricalcolo_wz from w_wiz_main
end type
type cb_chiudi from commandbutton within w_riepilogo_ricalcolo_wz
end type
type cb_ricalcola from commandbutton within w_riepilogo_ricalcolo_wz
end type
type dw_riepilogo_ricalcolo_ff from u_dw_ext_main within w_riepilogo_ricalcolo_wz
end type
type st_prbar from statictext within w_riepilogo_ricalcolo_wz
end type
type uo_prbar from u_meter within w_riepilogo_ricalcolo_wz
end type
type st_codart from statictext within w_riepilogo_ricalcolo_wz
end type
end forward

global type w_riepilogo_ricalcolo_wz from w_wiz_main
int X=833
int Y=361
int Width=2199
int Height=657
boolean TitleBar=true
string Title="Ricalcolo Saldi Mensili"
cb_chiudi cb_chiudi
cb_ricalcola cb_ricalcola
dw_riepilogo_ricalcolo_ff dw_riepilogo_ricalcolo_ff
st_prbar st_prbar
uo_prbar uo_prbar
st_codart st_codart
end type
global w_riepilogo_ricalcolo_wz w_riepilogo_ricalcolo_wz

type variables
u_riepilogo_ricalcolo	iu_calc
end variables

forward prototypes
public subroutine uf_ricalcola ()
public function long uf_proponi_esercizio ()
end prototypes

public subroutine uf_ricalcola ();


long		ll_row, ll_ideser
string	ls_art1, ls_art2, ls_tutti
string	ls_msg
boolean	lb_ok
pointer	lp_1


ll_row = dw_riepilogo_ricalcolo_ff.GetRow()

ll_ideser = dw_riepilogo_ricalcolo_ff.GetItemNumber (ll_row,"id_esercizio")
ls_tutti = dw_riepilogo_ricalcolo_ff.GetItemString (ll_row,"esercizio_tutti")
ls_art1 = dw_riepilogo_ricalcolo_ff.GetItemString (ll_row,"art_da_cod")
if isNull (ls_art1) then ls_art1=""
ls_art2 = dw_riepilogo_ricalcolo_ff.GetItemString (ll_row,"art_a_cod")
if isNull (ls_art2) then ls_art2=""
ls_msg = ""
lb_ok = true

if ls_tutti="N" then
	if isNull(ll_ideser) or (ll_ideser<=0) then
		ls_msg += "Si deve scegliere un esercizio oppure tutti!~r"
	end if
end if


if (ls_art1>"") and (ls_art2>"") then
	if ls_art1>ls_art2 then
		ls_msg += "Il secondo codice deve essere maggiore o uguale al primo!~r"
	end if
end if


if ls_msg > "" then
	messageBox("Attenzione, errori!",ls_msg)
	lb_ok = false
end if


if lb_ok then
	
	lp_1 = SetPointer (HourGlass!)
	st_prbar.visible = true
	
	
	
	iu_calc.uf_esegui(ll_ideser, ls_art1, ls_art2, ls_tutti, uo_prbar, st_codart)

	
	
	st_prbar.visible = false
	SetPointer (lp_1)
	
end if

end subroutine

public function long uf_proponi_esercizio ();

long ll_RetVal

ll_retVal = u_freddie.gl_null

SELECT dba.azienda.id_esercizio_proposto
	INTO :ll_RetVal
	FROM dba.azienda
	WHERE dba.azienda.id_azienda in (0,1)
	USING SQLCA;
	
CHOOSE CASE SQLCA.SQLCode
	CASE -1
		MessageBox("Errore sul DataBase", "w_riepilogo_ricalcolo_ff / uf_proponi_esercizio / 1")
END CHOOSE

RETURN ll_RetVal

end function

on w_riepilogo_ricalcolo_wz.create
int iCurrent
call w_wiz_main::create
this.cb_chiudi=create cb_chiudi
this.cb_ricalcola=create cb_ricalcola
this.dw_riepilogo_ricalcolo_ff=create dw_riepilogo_ricalcolo_ff
this.st_prbar=create st_prbar
this.uo_prbar=create uo_prbar
this.st_codart=create st_codart
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=cb_chiudi
this.Control[iCurrent+2]=cb_ricalcola
this.Control[iCurrent+3]=dw_riepilogo_ricalcolo_ff
this.Control[iCurrent+4]=st_prbar
this.Control[iCurrent+5]=uo_prbar
this.Control[iCurrent+6]=st_codart
end on

on w_riepilogo_ricalcolo_wz.destroy
call w_wiz_main::destroy
destroy(this.cb_chiudi)
destroy(this.cb_ricalcola)
destroy(this.dw_riepilogo_ricalcolo_ff)
destroy(this.st_prbar)
destroy(this.uo_prbar)
destroy(this.st_codart)
end on

event open;

long ll_CurrRow

dw_riepilogo_ricalcolo_ff.reset()
dw_riepilogo_ricalcolo_ff.triggerevent("ue_insert")

iu_calc = create u_riepilogo_ricalcolo

dw_riepilogo_ricalcolo_ff.Event ue_post_open()
end event

event close;

if IsValid(iu_calc) then destroy iu_calc

end event

type cb_chiudi from commandbutton within w_riepilogo_ricalcolo_wz
int X=389
int Y=41
int Width=247
int Height=89
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

type cb_ricalcola from commandbutton within w_riepilogo_ricalcolo_wz
int X=46
int Y=41
int Width=298
int Height=89
int TabOrder=20
string Text="&Ricalcola"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

string		ls_msg, ls_tit

ls_tit = "Ricalcolo Riepiloghi"
ls_msg = "Attenzione: Questa operazione potrebbe durare parecchi minuti.~rContinuare?"

if MessageBox(ls_tit, ls_msg, Exclamation!, YesNo!) = 1 then
	uf_ricalcola()
end if

end event

type dw_riepilogo_ricalcolo_ff from u_dw_ext_main within w_riepilogo_ricalcolo_wz
int X=46
int Y=181
int Width=2081
int Height=341
int TabOrder=10
string DataObject="d_riepilogo_ricalcolo_ff"
end type

event ue_init;call super::ue_init;is_colonne_drop[1] = "id_esercizio"
end event

event ue_set_search;call super::ue_set_search;

CHOOSE CASE as_nomecol
	CASE "art_da_cod"
		is_search_window = "w_articolo_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "articolo_codice"

	CASE "art_da_des"
		is_search_window = "w_articolo_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "articolo_descrizione"

	CASE "art_a_cod"
		is_search_window = "w_articolo_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "articolo_codice"

	CASE "art_a_des"
		is_search_window = "w_articolo_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "articolo_descrizione"
		
END CHOOSE
end event

event ue_use_search;call super::ue_use_search;

CHOOSE CASE as_nomecol
	CASE "art_da_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("art_a_cod", is_ricpar.s_main_value)
		uf_set_colval("art_da_des", is_ricpar.s_ausil_value[1])
		uf_set_colval("art_a_des", is_ricpar.s_ausil_value[1])

	CASE "art_da_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("art_da_cod", is_ricpar.s_ausil_value[1])
		uf_set_colval("art_a_cod", is_ricpar.s_ausil_value[1])
		uf_set_colval("art_a_des", is_ricpar.s_main_value)
		
	CASE "art_a_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("art_a_des", is_ricpar.s_ausil_value[1])

	CASE "art_a_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("art_a_cod", is_ricpar.s_ausil_value[1])

END CHOOSE
end event

event itemchanged;call super::itemchanged;

long			ll_row, ll_a, ll_ok
string		ls_dbc[], ls_dbv[], ls_dwc[]
string		ls_b, ls_c, ls_pc
string		ls_sql_cond


ll_row = GetRow()
if ll_row > 0 then

	choose case dwo.name
		
		
		
		
		
		CASE "art_da_cod"
			ls_pc = data
			SELECT	"articolo"."id_articolo",
						"articolo"."codice",
						"articolo"."descrizione"
				INTO	:ll_a, :ls_b, :ls_c  
				FROM	"dba"."articolo"  
				WHERE "articolo"."codice" = :ls_pc;
			
			if sqlca.sqlcode=0 then
				setItem (ll_row,"art_da_cod",ls_b)
				setItem (ll_row,"art_da_des",ls_c)
				setItem (ll_row,"art_a_cod",ls_b)
				setItem (ll_row,"art_a_des",ls_c)
				return 2
			else
				setItem (ll_row,"art_a_des",u_freddie.gs_null)
				return 0
			end if

		CASE "art_a_des"
			ls_sql_cond = ""
			ls_dbc[1] = "codice"
			ls_dwc[1] = "art_a_cod"
			ls_dbc[2] = "descrizione"
			ls_dwc[2] = "art_a_des"
			ls_dbc[3] = "codice"
			ls_dwc[3] = "art_a_cod"
			ls_dbc[4] = "descrizione"
			ls_dwc[4] = "art_a_des"
			ll_ok = uf_autofind_col(dwo.Name, "articolo", &  
											"descrizione", "A", data, & 
											ls_sql_cond, 4, &
											ls_dbc, ls_dbv, ls_dwc)
			IF (ll_ok > 0) THEN
				RETURN 2
			END IF

		
		
		
		CASE "art_a_cod"
			ls_pc = data
			SELECT	"articolo"."id_articolo",
						"articolo"."codice",
						"articolo"."descrizione"
				INTO	:ll_a, :ls_b, :ls_c  
				FROM	"dba"."articolo"  
				WHERE "articolo"."codice" = :ls_pc;
			
			if sqlca.sqlcode=0 then
				setItem (ll_row,"art_a_cod",ls_b)
				setItem (ll_row,"art_a_des",ls_c)
				return 2
			else
				setItem (ll_row,"art_a_des",u_freddie.gs_null)
				return 0
			end if

		CASE "art_a_des"
			ls_sql_cond = ""
			ls_dbc[1] = "codice"
			ls_dwc[1] = "art_a_cod"
			ls_dbc[2] = "descrizione"
			ls_dwc[2] = "art_a_des"
			ll_ok = uf_autofind_col(dwo.Name, "articolo", &  
											"descrizione", "A", data, & 
											ls_sql_cond, 2, &
											ls_dbc, ls_dbv, ls_dwc)
			IF (ll_ok > 0) THEN
				RETURN 2
			END IF

		CASE "esercizio_tutti"
			setItem (ll_row,"id_esercizio",u_freddie.gl_null)

	END CHOOSE

end if
end event

event ue_initial;call super::ue_initial;

long		ll_Row

ll_row = this.GetRow()
THIS.SetItem(ll_row, "esercizio_tutti","N")
THIS.SetItem(ll_row, "id_esercizio", uf_proponi_esercizio())

end event

type st_prbar from statictext within w_riepilogo_ricalcolo_wz
int X=46
int Y=181
int Width=2081
int Height=341
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
string Text="Operazione in corso, si prega di attendere..."
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type uo_prbar from u_meter within w_riepilogo_ricalcolo_wz
int X=595
int Y=281
int Width=983
int TabOrder=40
boolean Visible=false
boolean BringToTop=true
boolean Border=true
long BackColor=1090519039
end type

on uo_prbar.destroy
call u_meter::destroy
end on

type st_codart from statictext within w_riepilogo_ricalcolo_wz
int X=595
int Y=401
int Width=979
int Height=77
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

