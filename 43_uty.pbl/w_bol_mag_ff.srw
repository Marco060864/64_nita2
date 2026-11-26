forward
global type w_bol_mag_ff from w_wiz_main
end type
type dw_1 from u_dw_ext_main within w_bol_mag_ff
end type
type cb_ok from commandbutton within w_bol_mag_ff
end type
type cb_1 from commandbutton within w_bol_mag_ff
end type
end forward

global type w_bol_mag_ff from w_wiz_main
int Width=2798
int Height=1084
boolean TitleBar=true
string Title="Stampa Bollato Magazzino"
long BackColor=80133307
dw_1 dw_1
cb_ok cb_ok
cb_1 cb_1
end type
global w_bol_mag_ff w_bol_mag_ff

on w_bol_mag_ff.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_ok=create cb_ok
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.cb_1
end on

on w_bol_mag_ff.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_ok)
destroy(this.cb_1)
end on

event open;call super::open;	dw_1.InsertRow(0)

end event

type dw_1 from u_dw_ext_main within w_bol_mag_ff
int X=37
int Y=168
int Width=2665
int TabOrder=10
boolean BringToTop=true
string DataObject="d_ext_bol_mag"
end type

event itemchanged;string    ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
long      ll_ok, ll_priorita, ll_riga_corrente, ll_id_riga
ls_sql_cond = ""

CHOOSE CASE dwo.name
	CASE 'da_sog_cod'
		ls_sql_cond = ""
		ls_dbc[1] = "id_sog_commerciale"
		ls_dbc[2] = "codice"		
		ls_dbc[3] = "rag_soc_1"		
		
		ls_dwc[1] = "id_da_sog"
		ls_dwc[2] = "da_sog_cod"
		ls_dwc[3] = "da_sog_des"
		
		ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &
										"codice", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF

	
	CASE "da_sog_des"
		ls_sql_cond = ""
		ls_dbc[1] = "id_sog_commerciale"
		ls_dbc[2] = "codice"
		ls_dbc[3] = "rag_soc_1"		
		
		ls_dwc[1] = "id_da_sog"
		ls_dwc[2] = "da_sog_cod"
		ls_dwc[3] = "da_sog_des"

		ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &
										"rag_soc_1", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
		
	CASE 'a_sog_cod'
		ls_sql_cond = ""
		ls_dbc[1] = "id_sog_commerciale"
		ls_dbc[2] = "codice"		
		ls_dbc[3] = "rag_soc_1"		
		
		ls_dwc[1] = "id_a_sog"
		ls_dwc[2] = "a_sog_cod"
		ls_dwc[3] = "a_sog_des"
		
		ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &
										"codice", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF

	
	CASE "a_sog_des"
		ls_sql_cond = ""
		ls_dbc[1] = "id_sog_commerciale"
		ls_dbc[2] = "codice"
		ls_dbc[3] = "rag_soc_1"		
		
		ls_dwc[1] = "id_a_sog"
		ls_dwc[2] = "a_sog_cod"
		ls_dwc[3] = "a_sog_des"

		ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &
										"rag_soc_1", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF		
END CHOOSE
end event

event ue_set_search;CHOOSE CASE as_nomecol
	CASE "da_sog_cod"
			is_search_window = "w_sog_commerciale_gen_coddes_sw"
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "codice"
			
	CASE "da_sog_des"
			is_search_window = "w_sog_commerciale_gen_coddes_sw"
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "rag_soc_1"
			
	CASE "a_sog_cod"
			is_search_window = "w_sog_commerciale_gen_coddes_sw"
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "codice"
			
	CASE "a_sog_des"
			is_search_window = "w_sog_commerciale_gen_coddes_sw"
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "rag_soc_1"			

END CHOOSE
end event

event ue_use_search;
CHOOSE CASE as_nomecol
	CASE "da_sog_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_da_sog", is_ricpar.s_id_seg_value[1])
		uf_set_colval("da_sog_des", is_ricpar.s_ausil_value[1])
		
	CASE "da_sog_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_da_sog", is_ricpar.s_id_seg_value[1])
		uf_set_colval("da_sog_cod", is_ricpar.s_ausil_value[1])
		
	CASE "a_sog_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_a_sog", is_ricpar.s_id_seg_value[1])
		uf_set_colval("a_sog_des", is_ricpar.s_ausil_value[1])
		
	CASE "a_sog_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_a_sog", is_ricpar.s_id_seg_value[1])
		uf_set_colval("a_sog_cod", is_ricpar.s_ausil_value[1])		
END CHOOSE
end event

type cb_ok from commandbutton within w_bol_mag_ff
int X=37
int Y=36
int Width=247
int Height=100
int TabOrder=20
boolean BringToTop=true
string Text="&Stampa"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.accepttext()

s_bol_mag str_parametri  

string  ls_conto, ls_conto2, ls_mastro, ls_sottomastro, ls_valuta, ls_finale, ls_vis_pz
decimal ld_cambio
long ll_apertura, ll_id_registro, ll_id_esercizio, ll_chiusura, ll_cifre_decimali, ll_row
date  ld_inizio, ld_data_competenza, d_dat_in, d_dat_fin
integer li_d_day, li_d_fine , i
char lc_valuta
string ls_tipo, ls_da_sog, ls_a_sog, ls_stam

ll_row = dw_1.getrow()

str_parametri.da_sog  = ''
str_parametri.a_sog   = ''

d_dat_in  = dw_1.getitemdate(ll_row, 'da_data')
d_dat_fin = dw_1.getitemdate(ll_row, 'a_data')
ls_tipo   = dw_1.getitemstring(ll_row, 'car_sca')
ls_da_sog = dw_1.getitemstring(ll_row, 'da_sog_cod')
ls_a_sog  = dw_1.getitemstring(ll_row, 'a_sog_cod')
ls_stam   = dw_1.getitemstring(ll_row, 'tipo_stp')
ls_vis_pz = dw_1.getitemstring(1,'vis_pz') 

IF d_dat_in > d_dat_fin THEN
	messagebox ('Attenzione', 'Verificare date inserite')
	return
end if

if isnull(d_dat_fin) then
	messagebox ('Attenzione', 'Inserire = fino a data')
end if

str_parametri.da_data = d_dat_in
str_parametri.a_data  = d_dat_fin
str_parametri.tipo    = ls_tipo
str_parametri.da_sog  = ls_da_sog
str_parametri.a_sog   = ls_a_sog
str_parametri.vis_pz  = ls_vis_pz
 		
if dw_1.getitemstring(1,'tipo_stp')='L' then
	openwithparm(w_stampa_bol_mag_ff , str_parametri)
else 
	openwithparm(w_stampa_bol_mag2_ff, str_parametri)
end if	


end event

type cb_1 from commandbutton within w_bol_mag_ff
int X=329
int Y=36
int Width=247
int Height=100
int TabOrder=20
boolean BringToTop=true
string Text="&Annulla"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

