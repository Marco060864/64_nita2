forward
global type w_anagrafica_cx from w_p_data
end type
type dw_anagrafica_gen_ff from u_dw_master_main within tabpage_1
end type
type dw_anagrafica_gen_ff from u_dw_master_main within tabpage_1
end type
type tabpage_commerciale from userobject within tab_1
end type
type dw_anagrafica_comm_ff from u_dw_master_main within tabpage_commerciale
end type
type dw_banca_sog_commerciale_gd from u_dw_master_main within tabpage_commerciale
end type
type dw_con_spec_scadenza_gd from u_dw_master_main within tabpage_commerciale
end type
type dw_banca_sog_commerciale_gd_t from statictext within tabpage_commerciale
end type
type dw_con_spec_scadenza_gd_t from statictext within tabpage_commerciale
end type
type tabpage_ritenute from userobject within tab_1
end type
type dw_anagrafica_riten_ff from u_dw_master_main within tabpage_ritenute
end type
type tabpage_telefoni from userobject within tab_1
end type
type dw_telefono_lt from u_dw_master_main within tabpage_telefoni
end type
type tabpage_sog_comm from userobject within tab_1
end type
type dw_sog_comm_lt from u_dw_master_main within tabpage_sog_comm
end type
type tabpage_commerciale from userobject within tab_1
dw_anagrafica_comm_ff dw_anagrafica_comm_ff
dw_banca_sog_commerciale_gd dw_banca_sog_commerciale_gd
dw_con_spec_scadenza_gd dw_con_spec_scadenza_gd
dw_banca_sog_commerciale_gd_t dw_banca_sog_commerciale_gd_t
dw_con_spec_scadenza_gd_t dw_con_spec_scadenza_gd_t
end type
type tabpage_ritenute from userobject within tab_1
dw_anagrafica_riten_ff dw_anagrafica_riten_ff
end type
type tabpage_telefoni from userobject within tab_1
dw_telefono_lt dw_telefono_lt
end type
type tabpage_sog_comm from userobject within tab_1
dw_sog_comm_lt dw_sog_comm_lt
end type
end forward

global type w_anagrafica_cx from w_p_data
int X=430
int Y=261
int Width=2849
int Height=1741
boolean TitleBar=true
string Title="Anagrafica"
end type
global w_anagrafica_cx w_anagrafica_cx

type variables
string is_title_modifica
end variables

forward prototypes
public subroutine uf_ricerca ()
public subroutine uf_set_title ()
end prototypes

public subroutine uf_ricerca ();

w_search_main lw_sm
long ll_id_anagrafica
string ls_SQL_cond = "", ls_dwcol[], ls_dbfield[]
s_ric_param ls_ricpar

idw_master.is_ricpar.s_filter_name = "rag_soc_1"

ls_dwcol[1] = "rag_soc_1"
ls_dwcol[2] = "rag_soc_2"
ls_dwcol[3] = "cod_fiscale"
ls_dwcol[4] = "par_iva"

ls_dbfield[1] = "rag_soc_1"
ls_dbfield[2] = "rag_soc_2"
ls_dbfield[3] = "cod_fiscale"
ls_dbfield[4] = "par_iva"

ls_SQL_cond = f_get_SQL_cond(tab_1.tabpage_1.dw_anagrafica_gen_ff, tab_1.tabpage_1.dw_anagrafica_gen_ff.GetRow(), ls_dwcol, ls_dbfield)
idw_master.is_ricpar.s_SQL_cond = ls_SQL_cond

idw_master.is_ricpar.b_imm_retrieve = TRUE

OpenWithParm(lw_sm, idw_master.is_ricpar, "w_anagrafica_sw")
idw_master.is_ricpar = Message.PowerObjectParm

IF UpperBound(idw_master.is_ricpar.s_id_seg_value) > 0 THEN
	ll_id_anagrafica = long(idw_master.is_ricpar.s_id_seg_value[1])
	idw_master.is_list.s_modo = modo_modifica
	idw_master.is_list.s_identifica[1] = "id_anagrafica"
	idw_master.is_list.l_identifica[1] = ll_id_anagrafica	
	idw_master.Event ue_retrieve(0, 0)
	idw_master.SetItemStatus(idw_master.GetRow(), 0, Primary!, NotModified!)
END IF

idw_master.SetFocus()
end subroutine

public subroutine uf_set_title ();

long      	ll_CurrRow
string   	ls_Persona, ls_msg
string 		ls_title, ls_space, ls_minus, ls_rag_soc_1, ls_CurrTitle

ls_space = " "
ls_minus = " - "
ll_CurrRow = tab_1.tabpage_1.dw_anagrafica_gen_ff.GetRow()

IF ll_CurrRow > 0 THEN
	ls_Persona = tab_1.tabpage_1.dw_anagrafica_gen_ff.GetItemString(ll_CurrRow, "nat_giuridica")
	IF ls_Persona = "G"  THEN
		tab_1.tabpage_ritenute.Enabled = FALSE
		tab_1.tabpage_ritenute.Visible = FALSE
	ELSE
		tab_1.tabpage_ritenute.Enabled = TRUE
		tab_1.tabpage_ritenute.Visible = TRUE
	END IF
	IF (ll_CurrRow > 0) THEN
		ls_rag_soc_1 = tab_1.tabpage_1.dw_anagrafica_gen_ff.GetItemString(ll_CurrRow, "rag_soc_1")
		ls_title = ls_rag_soc_1
		IF IsNull(ls_title) THEN
				ls_title = ls_space
		END IF	
		
		THIS.Title = "Anagrafica - " + ls_title
	END IF
END IF
end subroutine

on w_anagrafica_cx.create
int iCurrent
call w_p_data::create
iCurrent=UpperBound(this.Control)
end on

on w_anagrafica_cx.destroy
call w_p_data::destroy
end on

event open;call super::open;

long ll_screenh
environment le_env

this.il_HelpTopic = 11

idw_master = tab_1.tabpage_1.dw_anagrafica_gen_ff
idw_master.is_list = Message.PowerObjectParm

idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_sql_ident[1] = "anagrafica.id_anagrafica"

ib_NonModale = TRUE

IF UpperBound(idw_master.is_list.s_identifica) = 0 THEN
	idw_master.ias_key_name[1] = "id_anagrafica"
	idw_master.is_list.s_modo = modo_inserisci
	
	
	GetEnvironment(le_env)
	ll_screenh = PixelsToUnits(le_env.screenheight,YPixelsToUnits!)
	THIS.y = 0
END IF

end event

event close;call super::close;
long				ll_row
integer			li_size, li_i
string			ls_colname
u_dw_main		ludw_1
s_rit_wp			istr_rit


ludw_1 = idw_master
ll_row = ludw_1.getRow()
istr_rit = ludw_1.is_ritorni
istr_rit.s_modo_rit = "X"
if ll_row>0 then
	li_size = UpperBound(ludw_1.is_list.s_identifica)
	for li_i = 1 to li_size
		ls_colname = ludw_1.is_list.s_identifica[li_i]
		istr_rit.l_identifica[li_i] = ludw_1.GetItemNumber(ll_row, ls_colname)
	next
end if
Message.PowerObjectParm = istr_rit


end event

event ue_master_delete;call super::ue_master_delete;

if (idw_master.Event ue_delete(0, 0) = 0) then
	ib_AskForSave = false
	IF (idw_master.Event ue_update(0, 0) = 0) then
		ib_AskForSave = true
		idw_master.is_list.s_modo = modo_inserisci
		idw_master.Event ue_insert(0, 0)
	else
		idw_master.Event ue_retrieve(0, 0)
	end if
	idw_master.SetItemStatus(idw_master.GetRow(), 0, Primary!, NotModified!)
end if
idw_master.SetFocus()

end event

type p_crescente from w_p_data`p_crescente within w_anagrafica_cx
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_anagrafica_cx
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_anagrafica_cx
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_anagrafica_cx
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_anagrafica_cx
boolean BringToTop=true
end type

event cb_nuovo::clicked;call super::clicked;
end event

type cb_inserisci from w_p_data`cb_inserisci within w_anagrafica_cx
int X=1943
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_anagrafica_cx
int X=2241
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_anagrafica_cx
int X=2538
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_anagrafica_cx
int Width=2748
int Height=1441
boolean BringToTop=true
tabpage_commerciale tabpage_commerciale
tabpage_ritenute tabpage_ritenute
tabpage_telefoni tabpage_telefoni
tabpage_sog_comm tabpage_sog_comm
end type

on tab_1.create
this.tabpage_commerciale=create tabpage_commerciale
this.tabpage_ritenute=create tabpage_ritenute
this.tabpage_telefoni=create tabpage_telefoni
this.tabpage_sog_comm=create tabpage_sog_comm
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=tabpage_commerciale
this.Control[iCurrent+2]=tabpage_ritenute
this.Control[iCurrent+3]=tabpage_telefoni
this.Control[iCurrent+4]=tabpage_sog_comm
end on

on tab_1.destroy
call super::destroy
destroy(this.tabpage_commerciale)
destroy(this.tabpage_ritenute)
destroy(this.tabpage_telefoni)
destroy(this.tabpage_sog_comm)
end on

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=19
int Y=105
int Width=2711
int Height=1321
long BackColor=79741120
string Text="Generale"
long TabBackColor=79741120
dw_anagrafica_gen_ff dw_anagrafica_gen_ff
end type

on tabpage_1.create
this.dw_anagrafica_gen_ff=create dw_anagrafica_gen_ff
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=dw_anagrafica_gen_ff
end on

on tabpage_1.destroy
call super::destroy
destroy(this.dw_anagrafica_gen_ff)
end on

type cb_ricerca from w_p_data`cb_ricerca within w_anagrafica_cx
int Width=307
boolean BringToTop=true
end type

event cb_ricerca::clicked;call super::clicked;

uf_ricerca()
end event

type dw_anagrafica_gen_ff from u_dw_master_main within tabpage_1
int X=28
int Y=37
int Width=2652
int Height=1253
int TabOrder=3
string DataObject="d_anagrafica_gen_ff"
end type

event ue_init;call super::ue_init;window 	lw_parent
tab    	lw_tab

is_title = "Anagrafica"
is_list.s_identifica[1] = "id_anagrafica"

iudw_children[1] = tab_1.tabpage_commerciale.dw_anagrafica_comm_ff
iudw_children[2] = tab_1.tabpage_commerciale.dw_banca_sog_commerciale_gd
iudw_children[3] = tab_1.tabpage_commerciale.dw_con_spec_scadenza_gd
iudw_children[4] = tab_1.tabpage_ritenute.dw_anagrafica_riten_ff
iudw_children[5] = tab_1.tabpage_telefoni.dw_telefono_lt
iudw_children[6] = tab_1.tabpage_sog_comm.dw_sog_comm_lt
lw_tab = Parent.GetParent()
lw_parent = lw_tab.GetParent()
is_title_modifica = lw_parent.Title
end event

event ue_initial;call super::ue_initial;

long ll_CurRow, ll_Valuta_Par_Sistema


SELECT "par_sistema"."id_valuta" 
INTO :ll_Valuta_Par_Sistema 
FROM "par_sistema" 
WHERE "par_sistema"."id_azienda" = 1;



ll_CurRow = tab_1.tabpage_1.dw_anagrafica_gen_ff.GetRow()


tab_1.tabpage_commerciale.dw_anagrafica_comm_ff.SetItem(ll_CurRow, "id_valuta_cod", ll_Valuta_Par_Sistema)

end event

event ue_validate_row;call super::ue_validate_row;
return 0
end event

event itemchanged;call super::itemchanged;long ll_CurrRow
string ls_Nazione, ls_CF, ls_PI, ls_Persona
string ls_title, ls_space, ls_minus,  ls_codice, ls_rag_soc_1
window lw_parent
tab    lw_tab

ls_space = " "
ls_minus = " - "
ll_CurrRow = GetRow()
CHOOSE CASE dwo.name
	CASE "cod_fiscale"
		ls_Nazione = GetItemString(ll_CurrRow, "nazione")
		ls_CF = data
		if ls_Nazione = "IT" AND ls_CF <> "" AND not IsNull(ls_CF) then
			if GetItemString( ll_CurrRow,"nat_giuridica") = "G" then
				IF f_controlla_partita_iva(ls_CF, ls_Nazione) = 0 THEN
					RETURN 0
				ELSE
					MessageBox(is_title, "Codice Fiscale non valido.", Exclamation!)
				END IF
			else
				IF f_controlla_codice_fiscale(ls_CF, ls_Nazione) = 0 THEN
					RETURN 0
				ELSE
					MessageBox(is_title, "Codice Fiscale non valido.", Exclamation!)
				END IF
			END IF	
		end if
	CASE "par_iva"
		ls_Nazione = GetItemString(ll_CurrRow, "nazione")
		ls_PI = data
		if ls_Nazione = "IT"  AND ls_PI <> "" AND not IsNull(ls_PI) then
			IF f_controlla_partita_iva(ls_PI, ls_Nazione) = 0 THEN
				RETURN 0
			ELSE
				MessageBox(is_title, "Partita IVA non valida.", Exclamation!)
			END IF
		end if
	CASE "nat_giuridica"
		ls_Persona = This.GetText()
		IF ls_Persona = "G"  THEN
			tab_1.tabpage_ritenute.Enabled = FALSE
			tab_1.tabpage_ritenute.Visible = FALSE
		ELSE
			tab_1.tabpage_ritenute.Enabled = TRUE
			tab_1.tabpage_ritenute.Visible = TRUE
		END IF
	CASE "rag_soc_1"
		uf_set_title()		
		
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

event ue_set_search;call super::ue_set_search;
CHOOSE CASE as_nomecol
		
	CASE "id_linguaggio"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_linguaggio_gd"
		is_ricpar.s_titolo_finestra = "Linguaggi"
		is_ricpar.s_ausil_value[1] = "id_linguaggio_des"
	CASE "id_linguaggio_des"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_linguaggio_gd"
		is_ricpar.s_titolo_finestra = "Linguaggi"
		is_ricpar.s_ausil_value[1] = "id_linguaggio"
		
	CASE "id_lingua"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_lingua_gd"
		is_ricpar.s_titolo_finestra = "Lingue"
		is_ricpar.s_ausil_value[1] = "id_lingua_des"
	CASE "id_lingua_des"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_lingua_gd"
		is_ricpar.s_titolo_finestra = "Lingue"
		is_ricpar.s_ausil_value[1] = "id_lingua"
				
	CASE "id_titolo"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_titolo_gd"
		is_ricpar.s_titolo_finestra = "Titoli"
		
END CHOOSE

end event

event updateend;call super::updateend;
end event

event ue_retrieve;call super::ue_retrieve;uf_set_title()
end event

type tabpage_commerciale from userobject within tab_1
int X=19
int Y=105
int Width=2711
int Height=1321
long BackColor=79741120
string Text="Commerciale"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_anagrafica_comm_ff dw_anagrafica_comm_ff
dw_banca_sog_commerciale_gd dw_banca_sog_commerciale_gd
dw_con_spec_scadenza_gd dw_con_spec_scadenza_gd
dw_banca_sog_commerciale_gd_t dw_banca_sog_commerciale_gd_t
dw_con_spec_scadenza_gd_t dw_con_spec_scadenza_gd_t
end type

on tabpage_commerciale.create
this.dw_anagrafica_comm_ff=create dw_anagrafica_comm_ff
this.dw_banca_sog_commerciale_gd=create dw_banca_sog_commerciale_gd
this.dw_con_spec_scadenza_gd=create dw_con_spec_scadenza_gd
this.dw_banca_sog_commerciale_gd_t=create dw_banca_sog_commerciale_gd_t
this.dw_con_spec_scadenza_gd_t=create dw_con_spec_scadenza_gd_t
this.Control[]={ this.dw_anagrafica_comm_ff,&
this.dw_banca_sog_commerciale_gd,&
this.dw_con_spec_scadenza_gd,&
this.dw_banca_sog_commerciale_gd_t,&
this.dw_con_spec_scadenza_gd_t}
end on

on tabpage_commerciale.destroy
destroy(this.dw_anagrafica_comm_ff)
destroy(this.dw_banca_sog_commerciale_gd)
destroy(this.dw_con_spec_scadenza_gd)
destroy(this.dw_banca_sog_commerciale_gd_t)
destroy(this.dw_con_spec_scadenza_gd_t)
end on

type dw_anagrafica_comm_ff from u_dw_master_main within tabpage_commerciale
int X=28
int Y=37
int Width=2652
int Height=353
int TabOrder=3
string DataObject="d_anagrafica_comm_ff"
end type

event ue_init;call super::ue_init;ib_dw_shared = TRUE
is_title = "Anagrafica"
is_list.s_colonne_drop[1] = "id_valuta_cod"
is_list.s_colonne_drop[2] = "id_valuta_des"
is_list.s_colonne_drop[3] = "id_tipo_trasporto_cod"
is_list.s_colonne_drop[4] = "id_tipo_trasporto_des"
end event

event ue_set_search;call super::ue_set_search;
CHOOSE CASE as_nomecol
		
	CASE "id_valuta_cod"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_valuta_gd"
		is_ricpar.s_titolo_finestra = "Valute"
		is_ricpar.s_ausil_value[1] = "id_valuta_des"
		is_ricpar.i_width = 2798
		is_ricpar.i_height = 861
	CASE "id_valuta_des"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_valuta_gd"
		is_ricpar.s_titolo_finestra = "Valute"
		is_ricpar.s_ausil_value[1] = "id_valuta_cod"
		is_ricpar.i_width = 2798
		is_ricpar.i_height = 861
		
	CASE "id_tipo_trasporto_cod"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_tipo_trasporto_gd"
		is_ricpar.s_titolo_finestra = "Tipi di Trasporto"
		is_ricpar.s_ausil_value[1] = "id_tipo_trasporto_des"
		is_ricpar.i_width = 2606
		is_ricpar.i_height = 873
	CASE "id_tipo_trasporto_des"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_tipo_trasporto_gd"
		is_ricpar.s_titolo_finestra = "Tipi di Trasporto"
		is_ricpar.s_ausil_value[1] = "id_tipo_trasporto_cod"
		is_ricpar.i_width = 2606
		is_ricpar.i_height = 873
		
END CHOOSE

end event

type dw_banca_sog_commerciale_gd from u_dw_master_main within tabpage_commerciale
int X=28
int Y=497
int Width=2652
int Height=341
int TabOrder=3
string DataObject="d_banca_sog_commerciale_gd"
boolean VScrollBar=true
end type

event ue_init;call super::ue_init;is_list.s_identifica[1] = "id_anagrafica"
is_title = "Banche"
end event

event ue_set_search;call super::ue_set_search;CHOOSE CASE as_nomecol
	CASE "cc_den_abi_cab"
		is_search_window = "w_banca_appoggio_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "den_abi" 
		is_ricpar.b_AsNeeded = TRUE
END CHOOSE
end event

event ue_use_search;call super::ue_use_search;CHOOSE CASE as_nomecol
	CASE "cc_den_abi_cab"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_banca_appoggio", is_ricpar.s_id_seg_value[1])
END CHOOSE
end event

event itemchanged;call super::itemchanged;string    ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
long      ll_ok

CHOOSE CASE dwo.name

	CASE 'cc_den_abi_cab'
  
  
		ls_dbc[1] = "id_banca_sog_commerciale"
		ls_dwc[1] = "id_banca_sog_commerciale"
		ls_dbc[2] = "den_abi"
		ls_dwc[2] = "cc_den_abi_cab"
		ll_ok = uf_autofind_col(dwo.Name, "banca_sog_commerciale_gen", &  
										"den_abi" + ' - ' + "den_cab", "A", data, & 
										ls_sql_cond, 2, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF

END CHOOSE

end event

type dw_con_spec_scadenza_gd from u_dw_master_main within tabpage_commerciale
int X=28
int Y=957
int Width=2652
int Height=361
int TabOrder=3
string DataObject="d_con_spec_scadenza_gd"
boolean VScrollBar=true
end type

event ue_init;call super::ue_init;is_list.s_identifica[1] = "id_anagrafica"
is_title = "Condizioni Speciali per Scadenze"
end event

event ue_validate_row;call super::ue_validate_row;


datawindow ld_con_spec_scad
long ll_CurrRow, li_g_inizio, li_m_inizio, li_g_fine, li_m_fine, li_g_app, li_m_app
boolean lb_Data_Inizio, lb_Data_Fine, lb_Data_App

ll_CurrRow = tab_1.tabpage_commerciale.dw_con_spec_scadenza_gd.GetRow()
ld_con_spec_scad = tab_1.tabpage_commerciale.dw_con_spec_scadenza_gd


li_g_inizio = ld_con_spec_scad.GetItemNumber(ll_CurrRow, "giorno_inizio_periodo")
li_m_inizio = ld_con_spec_scad.GetItemNumber(ll_CurrRow, "mese_inizio_periodo")
li_g_fine = ld_con_spec_scad.GetItemNumber(ll_CurrRow, "giorno_fine_periodo")
li_m_fine = ld_con_spec_scad.GetItemNumber(ll_CurrRow, "mese_fine_periodo")
li_g_app = ld_con_spec_scad.GetItemNumber(ll_CurrRow, "giorno_applicazione")
li_m_app = ld_con_spec_scad.GetItemNumber(ll_CurrRow, "mese_applicazione")


lb_Data_Inizio = f_controlla_data_gm(li_g_inizio, li_m_inizio)
lb_Data_Fine = f_controlla_data_gm(li_g_fine, li_m_fine)
lb_Data_App = f_controlla_data_gm(li_g_app, li_m_app)


IF NOT lb_Data_Inizio THEN 
	
	as_error_text = "Il Giorno e il Mese Inizio non appartengono ad una data valida."
	RETURN 1
END IF

IF NOT lb_Data_Fine THEN 
	
	as_error_text = "Il Giorno e il Mese Fine non appartengono ad una data valida."
	RETURN 1
END IF

IF NOT lb_Data_App THEN 
	
	as_error_text = "Il Giorno e il Mese Applicazione non appartengono ad una data valida."
	RETURN 1
END IF

RETURN 0
end event

event itemchanged;call super::itemchanged;
datawindow ld_con_spec_scad
long ll_CurrRow, li_g_inizio, li_m_inizio, li_g_fine, li_m_fine, li_g_app, li_m_app
boolean lb_Data_Inizio, lb_Data_Fine, lb_Data_App

ll_CurrRow = GetRow()
ld_con_spec_scad = this
CHOOSE CASE dwo.name
	CASE "giorno_inizio_periodo"
		li_m_inizio = ld_con_spec_scad.GetItemNumber(ll_CurrRow, "mese_inizio_periodo")
		li_g_inizio = LONG(data)
		
		lb_Data_Inizio = f_controlla_data_gm(li_g_inizio, li_m_inizio)
		IF NOT lb_Data_Inizio THEN 
			MessageBox(is_title, "Il Giorno e il Mese Inizio non appartengono ad una data valida", StopSign!, OK!)
	
			RETURN 1
		END IF
	CASE "mese_inizio_periodo"
		li_g_inizio = ld_con_spec_scad.GetItemNumber(ll_CurrRow, "giorno_inizio_periodo")
		li_m_inizio = LONG(data)
		
		lb_Data_Inizio = f_controlla_data_gm(li_g_inizio, li_m_inizio)
		IF NOT lb_Data_Inizio THEN 
			MessageBox(is_title, "Il Giorno e il Mese Inizio non appartengono ad una data valida", StopSign!, OK!)
	
			RETURN 1
		END IF
	CASE "giorno_fine_periodo"
		li_m_fine = ld_con_spec_scad.GetItemNumber(ll_CurrRow, "mese_fine_periodo")
		li_g_fine = LONG(data)
		
		lb_Data_Fine = f_controlla_data_gm(li_g_fine, li_m_fine)
	
		IF NOT lb_Data_Fine THEN 
			MessageBox(is_title, "Il Giorno e il Mese Fine non appartengono ad una data valida", StopSign!, OK!)
			RETURN 1
		END IF
	CASE "mese_fine_periodo"
		li_g_fine = ld_con_spec_scad.GetItemNumber(ll_CurrRow, "giorno_fine_periodo")
		li_m_fine = LONG(data)
		
		lb_Data_Fine = f_controlla_data_gm(li_g_fine, li_m_fine)
	
		IF NOT lb_Data_Fine THEN 
			MessageBox(is_title, "Il Giorno e il Mese Fine non appartengono ad una data valida", StopSign!, OK!)
			RETURN 1
		END IF
	CASE "giorno_applicazione"	
		li_m_app = ld_con_spec_scad.GetItemNumber(ll_CurrRow, "mese_applicazione")
		li_g_app = LONG(data)
		
		lb_Data_App = f_controlla_data_gm(li_g_app, li_m_app)
		IF NOT lb_Data_App THEN 
			MessageBox(is_title, "Il Giorno e il Mese Applicazione non appartengono ad una data valida", StopSign!, OK!)
			RETURN 1
		END IF
	CASE "mese_applicazione"	
		li_g_app = ld_con_spec_scad.GetItemNumber(ll_CurrRow, "giorno_applicazione")
		li_m_app = LONG(data)
		
		lb_Data_App = f_controlla_data_gm(li_g_app, li_m_app)
		IF NOT lb_Data_App THEN 
			MessageBox(is_title, "Il Giorno e il Mese Applicazione non appartengono ad una data valida", StopSign!, OK!)
			RETURN 1
		END IF
END CHOOSE



end event

type dw_banca_sog_commerciale_gd_t from statictext within tabpage_commerciale
int X=28
int Y=417
int Width=2652
int Height=81
boolean Enabled=false
boolean BringToTop=true
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
string Text=" Banche"
boolean FocusRectangle=false
long TextColor=16777215
long BackColor=276856960
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_con_spec_scadenza_gd_t from statictext within tabpage_commerciale
int X=28
int Y=877
int Width=2652
int Height=81
boolean Enabled=false
boolean BringToTop=true
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
string Text=" Condizioni Speciali per Scadenze"
boolean FocusRectangle=false
long TextColor=16777215
long BackColor=276856960
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type tabpage_ritenute from userobject within tab_1
int X=19
int Y=105
int Width=2711
int Height=1321
long BackColor=79741120
string Text="Ritenute"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_anagrafica_riten_ff dw_anagrafica_riten_ff
end type

on tabpage_ritenute.create
this.dw_anagrafica_riten_ff=create dw_anagrafica_riten_ff
this.Control[]={ this.dw_anagrafica_riten_ff}
end on

on tabpage_ritenute.destroy
destroy(this.dw_anagrafica_riten_ff)
end on

type dw_anagrafica_riten_ff from u_dw_master_main within tabpage_ritenute
event ue_proteggi_percentuali ( )
int X=28
int Y=37
int Width=2652
int Height=1253
int TabOrder=3
string DataObject="d_anagrafica_riten_ff"
end type

event ue_proteggi_percentuali;call super::ue_proteggi_percentuali;


end event

event ue_init;call super::ue_init;ib_dw_shared = TRUE
is_title = "Anagrafica"
is_list.s_colonne_drop[1] = "id_att_svolta_cod"
is_list.s_colonne_drop[2] = "id_att_svolta_des"
is_list.s_colonne_drop[3] = "id_tributo_cod"
is_list.s_colonne_drop[4] = "id_tributo_des"

end event

event ue_set_search;call super::ue_set_search;
CHOOSE CASE as_nomecol
		
	CASE "id_att_svolta_cod"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_att_svolta_gd"
		is_ricpar.s_titolo_finestra = "Attività Svolte"
		is_ricpar.s_ausil_value[1] = "id_att_svolta_des"
		
	CASE "id_att_svolta_des"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_att_svolta_gd"
		is_ricpar.s_titolo_finestra = "Attività Svolte"
		is_ricpar.s_ausil_value[1] = "id_att_svolta_cod"
		
	CASE "id_tributo_cod"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_tributo_gd"
		is_ricpar.s_titolo_finestra = "Tributi"
		is_ricpar.s_ausil_value[1] = "id_tributo_des"
		is_ricpar.i_width = 2917
		is_ricpar.i_height = 869
		
	CASE "id_tributo_des"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_tributo_gd"
		is_ricpar.s_titolo_finestra = "Tributi"
		is_ricpar.s_ausil_value[1] = "id_tributo_cod"
		is_ricpar.i_width = 2917
		is_ricpar.i_height = 869
		
END CHOOSE

end event

event ue_retrieve;call super::ue_retrieve;THIS.Event ue_Proteggi_Percentuali()
end event

event itemfocuschanged;integer li_RetVal

CHOOSE CASE string(dwo.name)
	CASE "con_previdenziale", "cassa_previdenza", "rit_previdenziale"
		THIS.PostEvent("ue_Proteggi_Percentuali")
END CHOOSE

li_RetVal = Super::Event ItemFocusChanged(row, dwo)
RETURN li_RetVal


end event

type tabpage_telefoni from userobject within tab_1
int X=19
int Y=105
int Width=2711
int Height=1321
long BackColor=79741120
string Text="Telefoni"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_telefono_lt dw_telefono_lt
end type

on tabpage_telefoni.create
this.dw_telefono_lt=create dw_telefono_lt
this.Control[]={ this.dw_telefono_lt}
end on

on tabpage_telefoni.destroy
destroy(this.dw_telefono_lt)
end on

type dw_telefono_lt from u_dw_master_main within tabpage_telefoni
int X=28
int Y=37
int Width=2661
int Height=1253
int TabOrder=3
string DataObject="d_telefono_lt"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event ue_init;call super::ue_init;is_resp_window = "w_telefono_ff"
is_list.s_identifica[1] = "id_anagrafica"
is_list.s_win_chiave[1] = "id_telefono"
is_list.s_par_name[1] = "id_anagrafica"

is_title = "Telefoni"
end event

type tabpage_sog_comm from userobject within tab_1
int X=19
int Y=105
int Width=2711
int Height=1321
long BackColor=79741120
string Text="Sogg.Comm."
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_sog_comm_lt dw_sog_comm_lt
end type

on tabpage_sog_comm.create
this.dw_sog_comm_lt=create dw_sog_comm_lt
this.Control[]={ this.dw_sog_comm_lt}
end on

on tabpage_sog_comm.destroy
destroy(this.dw_sog_comm_lt)
end on

type dw_sog_comm_lt from u_dw_master_main within tabpage_sog_comm
int X=28
int Y=37
int Width=2661
int Height=1253
int TabOrder=3
string Tag="dw_sog_comm"
string DataObject="d_anag_sog_commerciale_lt"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event ue_init;call super::ue_init;

is_title 					= "Soggetto Commerciale"
is_resp_window	 			= "w_sog_commerciale_cx"
is_list.s_identifica[1] = "id_anagrafica"
is_list.s_win_chiave[1] = "id_sog_commerciale"
is_list.s_par_name[1] 	= "id_anagrafica"

end event

