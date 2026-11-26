forward
global type w_imp_fat_cee_ff from w_p_data
end type
type dw_imp_fat_cee_ff from u_dw_master_main within w_imp_fat_cee_ff
end type
end forward

global type w_imp_fat_cee_ff from w_p_data
int Width=1747
int Height=737
boolean TitleBar=true
string Title="Calcolo Imposta Fattura"
dw_imp_fat_cee_ff dw_imp_fat_cee_ff
end type
global w_imp_fat_cee_ff w_imp_fat_cee_ff

type variables
string is_tag
decimal idc_imponibile
long il_id_prof_registrazione
end variables

on w_imp_fat_cee_ff.create
int iCurrent
call w_p_data::create
this.dw_imp_fat_cee_ff=create dw_imp_fat_cee_ff
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=dw_imp_fat_cee_ff
end on

on w_imp_fat_cee_ff.destroy
call w_p_data::destroy
destroy(this.dw_imp_fat_cee_ff)
end on

event open;call super::open;

string las_array[]

ib_AskForSave = FALSE
dw_imp_fat_cee_ff.ib_allow_update = FALSE

idw_master = dw_imp_fat_cee_ff
idw_master.is_list = Message.PowerObjectParm

u_freddie.sp_pop(las_array)

is_tag = las_array[1]
idc_imponibile = dec(las_array[2])
il_id_prof_registrazione = long(las_array[3])
end event

event closequery;RETURN 0
end event

event ue_post_open;call super::ue_post_open;long ll_CurrRow, ll_NewRow

ll_CurrRow = dw_imp_fat_cee_ff.GetRow()

IF ll_CurrRow = 0 THEN 
	ll_NewRow = dw_imp_fat_cee_ff.InsertRow(0)
	dw_imp_fat_cee_ff.ScrollToRow(ll_NewRow)
	dw_imp_fat_cee_ff.SetItem(ll_NewRow, "importo", idc_imponibile)
END IF
end event

event close;

string las_array[]
long ll_CurrRow
decimal ldc_tot_fattura

ll_CurrRow = dw_imp_fat_cee_ff.GetRow()
ldc_tot_fattura = dw_imp_fat_cee_ff.uf_GetItemDecimal(ll_CurrRow, "tot_fattura")

las_array[1] = "imp_cee"
las_array[2] = string(ldc_tot_fattura)

u_freddie.sp_clear()
u_freddie.sp_push(las_array)

RETURN 0
end event

type p_crescente from w_p_data`p_crescente within w_imp_fat_cee_ff
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_imp_fat_cee_ff
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_imp_fat_cee_ff
int TabOrder=20
boolean BringToTop=true
boolean Default=true
end type

event cb_ok::clicked;Event ue_close()
end event

type cb_annulla from w_p_data`cb_annulla within w_imp_fat_cee_ff
int TabOrder=40
boolean BringToTop=true
boolean Cancel=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_imp_fat_cee_ff
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_imp_fat_cee_ff
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_imp_fat_cee_ff
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_imp_fat_cee_ff
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_imp_fat_cee_ff
int X=1075
int Y=21
int Width=275
int Height=161
int TabOrder=30
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
long BackColor=79741120
end type

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=19
int Y=105
int Width=238
int Height=41
end type

type cb_ricerca from w_p_data`cb_ricerca within w_imp_fat_cee_ff
boolean BringToTop=true
end type

type dw_imp_fat_cee_ff from u_dw_master_main within w_imp_fat_cee_ff
int X=46
int Y=161
int Width=1646
int Height=461
int TabOrder=10
string DataObject="d_imp_fat_cee_ff"
end type

event ue_retrieve;RETURN 0
end event

event ue_default;call super::ue_default;

long ll_CurrRow, ll_id_tab_iva_cod
decimal ldc_importo, ldc_imposta, ldc_per_aliquota, ldc_per_detrazione  

ll_CurrRow = THIS.GetRow()

CHOOSE CASE string(adwo_current.name)
	CASE "id_tab_iva_cod"
		SELECT "prof_registrazione"."id_tab_iva"  
			INTO :ll_id_tab_iva_cod
			FROM "prof_registrazione"  
			WHERE "prof_registrazione"."id_prof_registrazione" = :il_id_prof_registrazione   ;

		CHOOSE CASE SQLCA.SQLCode
			CASE 0
				THIS.SetItem(ll_CurrRow, "id_tab_iva_cod", ll_id_tab_iva_cod)
			CASE -1
				MessageBox("Errore sul DataBase", "dw_imp_fat_cee_ff / ue_default / 1")
				RETURN
		END CHOOSE


	CASE "imposta"
		ll_id_tab_iva_cod = THIS.GetItemNumber(ll_CurrRow, "id_tab_iva_des")
		
		SELECT "tab_iva"."per_aliquota", "tab_iva"."per_detrazione"  
			INTO :ldc_per_aliquota, :ldc_per_detrazione  
			FROM "tab_iva"  
			WHERE "tab_iva"."id_tab_iva" = :ll_id_tab_iva_cod   ;
		
		CHOOSE CASE SQLCA.SQLCode
			CASE 0
				ldc_importo = THIS.uf_GetItemDecimal(ll_CurrRow, "importo")
				ldc_imposta = (ldc_importo / 100 * ldc_per_aliquota) / 100 * ldc_per_detrazione
				THIS.SetItem(ll_CurrRow, "imposta", ldc_imposta)
			CASE -1
				MessageBox("Errore sul DataBase", "dw_imp_fat_cee_ff / ue_default / 1")
				RETURN
		END CHOOSE

END CHOOSE

end event

