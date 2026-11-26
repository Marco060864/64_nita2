forward
global type w_ten_scr_contabili_ff from w_p_data
end type
type dw_ten_scr_contabili_ff from u_dw_master_main within w_ten_scr_contabili_ff
end type
end forward

global type w_ten_scr_contabili_ff from w_p_data
int Width=2547
int Height=1069
boolean TitleBar=true
string Title="Tenutari Scritture Contabili"
dw_ten_scr_contabili_ff dw_ten_scr_contabili_ff
end type
global w_ten_scr_contabili_ff w_ten_scr_contabili_ff

event open;call super::open;
il_HelpTopic = 94

idw_master = dw_ten_scr_contabili_ff
idw_master.is_list = Message.PowerObjectParm

idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_sql_ident[1] = "ten_scr_contabili.id_ten_scr_contabili"
end event

on w_ten_scr_contabili_ff.create
int iCurrent
call w_p_data::create
this.dw_ten_scr_contabili_ff=create dw_ten_scr_contabili_ff
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=dw_ten_scr_contabili_ff
end on

on w_ten_scr_contabili_ff.destroy
call w_p_data::destroy
destroy(this.dw_ten_scr_contabili_ff)
end on

type p_crescente from w_p_data`p_crescente within w_ten_scr_contabili_ff
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_ten_scr_contabili_ff
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_ten_scr_contabili_ff
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_ten_scr_contabili_ff
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_ten_scr_contabili_ff
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_ten_scr_contabili_ff
int TabOrder=40
boolean Visible=false
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_ten_scr_contabili_ff
int TabOrder=30
boolean Visible=false
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_ten_scr_contabili_ff
int X=2218
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_ten_scr_contabili_ff
int X=1486
int Y=1061
int Width=892
int Height=421
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
long BackColor=79741120
end type

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=19
int Y=105
int Width=855
int Height=301
end type

type cb_ricerca from w_p_data`cb_ricerca within w_ten_scr_contabili_ff
boolean BringToTop=true
end type

type dw_ten_scr_contabili_ff from u_dw_master_main within w_ten_scr_contabili_ff
int X=46
int Y=181
int Width=2433
int TabOrder=10
string DataObject="d_ten_scr_contabili_ff"
end type

event ue_init;call super::ue_init;is_title = "Tenutari Scritture Contabili"
end event

event itemchanged;call super::itemchanged;long ll_CurrRow
string ls_CF, ls_PI
string ls_title

ll_CurrRow = GetRow()
CHOOSE CASE dwo.name
	CASE "cod_fiscale"

		ls_CF = data
		if ls_CF <> "" AND not IsNull(ls_CF) then
			IF f_controlla_codice_fiscale(ls_CF, "IT") = 0 THEN
				RETURN 0
			ELSE
				MessageBox(is_title, "Codice Fiscale non valido.", Exclamation!)
			END IF
		end if
	CASE "par_iva"
		ls_PI = data
		if ls_PI <> "" AND not IsNull(ls_PI) then
			IF f_controlla_partita_iva(ls_PI, "IT") = 0 THEN
				RETURN 0
			ELSE
				MessageBox(is_title, "Partita IVA non valida.", Exclamation!)
			END IF
		end if
		
END CHOOSE



end event

event ue_default;call super::ue_default;string ls_cod_fiscale
CHOOSE CASE adwo_current.name
	CASE "par_iva"
		ls_cod_fiscale = GetItemString( al_row,"cod_fiscale")
		IF f_controlla_partita_iva(ls_cod_fiscale, "IT") = 0 THEN
			SetItem(al_row, "par_iva", ls_cod_fiscale)
		END IF
END CHOOSE
end event

