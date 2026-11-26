forward
global type w_socio_ff from w_p_data
end type
type dw_1 from u_dw_master_main within w_socio_ff
end type
end forward

global type w_socio_ff from w_p_data
int Width=2757
int Height=1781
boolean TitleBar=true
string Title="Dettaglio Socio"
dw_1 dw_1
end type
global w_socio_ff w_socio_ff

event open;call super::open;il_HelpTopic = 185
idw_master = dw_1
idw_master.is_list = Message.PowerObjectParm

idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_sql_ident[1] = "socio.id_socio"
end event

on w_socio_ff.create
int iCurrent
call w_p_data::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=dw_1
end on

on w_socio_ff.destroy
call w_p_data::destroy
destroy(this.dw_1)
end on

type p_crescente from w_p_data`p_crescente within w_socio_ff
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_socio_ff
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_socio_ff
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_socio_ff
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_socio_ff
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_socio_ff
int TabOrder=40
boolean Visible=false
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_socio_ff
int TabOrder=30
boolean Visible=false
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_socio_ff
int X=2423
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_socio_ff
int X=1052
int Y=901
int Width=1258
int Height=481
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
long BackColor=79741120
end type

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=19
int Y=105
int Width=1221
int Height=361
end type

type cb_ricerca from w_p_data`cb_ricerca within w_socio_ff
boolean BringToTop=true
end type

type dw_1 from u_dw_master_main within w_socio_ff
int X=46
int Y=161
int Width=2652
int Height=1501
int TabOrder=10
string DataObject="d_socio_ff"
end type

event ue_init;call super::ue_init;is_list.s_identifica[1] = "id_socio"

end event

event ue_default;call super::ue_default;

string ls_nomecol, ls_valore
ls_nomecol = string(adwo_current.name)

CHOOSE CASE ls_nomecol
	CASE "ind_abitazione"
		ls_valore = GetItemString(al_row,"ind_residenza")
		SetItem (al_row,ls_nomecol,ls_valore)
	CASE "cap_abitazione"
		ls_valore = GetItemString(al_row,"cap_residenza")
		SetItem (al_row,ls_nomecol,ls_valore)
	CASE "loc_abitazione"
		ls_valore = GetItemString(al_row,"loc_residenza")
		SetItem (al_row,ls_nomecol,ls_valore)
	CASE "prov_abitazione"
		ls_valore = GetItemString(al_row,"prov_residenza")
		SetItem (al_row,ls_nomecol,ls_valore)
	CASE "naz_abitazione"
		ls_valore = GetItemString(al_row,"naz_residenza")
		SetItem (al_row,ls_nomecol,ls_valore)
	CASE ELSE
		
END CHOOSE
end event

event ue_set_search;call super::ue_set_search;
CHOOSE CASE as_nomecol
		
	CASE "id_car_sociale"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_car_sociale_gd"
		is_ricpar.s_titolo_finestra = "Cariche Sociali"

END CHOOSE

end event

event itemchanged;call super::itemchanged;long ll_CurrRow
string ls_Nazione, ls_CF
string ls_title

ll_CurrRow = GetRow()
CHOOSE CASE dwo.name
		
	CASE "cod_fiscale"
		ls_Nazione = GetItemString(ll_CurrRow, "naz_residenza")
		ls_CF = data
		if ls_Nazione = "IT" AND ls_CF <> "" AND not IsNull(ls_CF) then
			IF f_controlla_codice_fiscale(ls_CF, ls_Nazione) = 0 THEN
				RETURN 0
			ELSE
				MessageBox(is_title, "Codice Fiscale non valido.", Exclamation!)
			END IF
		end if

END CHOOSE



end event

