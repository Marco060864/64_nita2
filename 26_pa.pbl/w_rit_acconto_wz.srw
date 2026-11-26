forward
global type w_rit_acconto_wz from w_wiz_main
end type
type cb_annulla from commandbutton within w_rit_acconto_wz
end type
type cb_ok from commandbutton within w_rit_acconto_wz
end type
type dw_rit_acconto_ff from u_dw_ext_main within w_rit_acconto_wz
end type
end forward

global type w_rit_acconto_wz from w_wiz_main
int X=343
int Y=348
int Width=2962
int Height=1368
WindowType WindowType=response!
boolean TitleBar=true
string Title="Ritenute d'acconto"
event ue_genera ( )
event ue_post_open ( )
cb_annulla cb_annulla
cb_ok cb_ok
dw_rit_acconto_ff dw_rit_acconto_ff
end type
global w_rit_acconto_wz w_rit_acconto_wz

type variables
long il_id_reg_pd, il_id_sog_commerciale
string  is_info_reg_pd, is_info_sc
decimal idc_per_impon, idc_imponibile
decimal idc_cassa_prev, idc_per_cassa_prev
decimal idc_imp_ritenuta
decimal idc_per_rit_acconto, idc_rit_acconto
decimal idc_per_rit_previd, idc_rit_previd
decimal idc_rimborsi
s_list_main is_list
long il_esente, il_valuta, il_val_lire
end variables

forward prototypes
public function long uf_calc_imponibile ()
public function integer uf_crea_rit_acconto ()
end prototypes

event ue_genera;

IF uf_crea_rit_acconto() = 0 THEN
	MessageBox(dw_rit_acconto_ff.is_title, "Creazione ritenuta d'acconto non riuscita")
ELSE
	COMMIT;
END IF
end event

event ue_post_open;

datawindow		ldw_data
integer 			li_size, li_i

li_size = UpperBound( this.Control )

for li_i = 1 to li_size 
	if not isNull(this.Control[li_i]) then
		if this.Control[li_i].TypeOf() = DataWindow! then

	      ldw_data = this.Control[li_i]
			ldw_data.Object.DataWindow.Help.Command = 1 
			ldw_data.Object.DataWindow.Help.TypeID.Retrieve.Argument = string(this.il_helptopic)
		end if	
	end if	
next	

select id_tab_iva_art_15
into :il_esente
from par_sistema;


decimal {4} ldc_per_tributo 
decimal {4} ldc_dare, ldc_avere, ldc_importo, ldc_comp_totale 
decimal {4} ldc_rimborsi 
long ll_CurrRow, ll_id_tributo, ll_SQL_Tributo

string ls_descrizione

ll_CurrRow = dw_rit_acconto_ff.GetRow()

  SELECT "tributo"."per_imponibile",   
         "tributo"."per_tributo",   
         "tributo"."descrizione",
			"sog_commerciale"."id_tributo"
    INTO :idc_per_impon,   
         :ldc_per_tributo,   
         :ls_descrizione,
			:ll_id_tributo
    FROM "DBA"."sog_commerciale",   
         "DBA"."tributo"  
   WHERE ( "tributo"."id_tributo" = "sog_commerciale"."id_tributo" ) and  
         ( ( "sog_commerciale"."id_sog_commerciale" = :il_id_sog_commerciale ) )   ;

ll_SQL_Tributo = SQLCA.SQLCode

SELECT "DBA".reg_pd.importo
	INTO :ldc_importo  
	FROM "DBA".reg_pd
	WHERE "DBA".reg_pd.id_reg_pd = :il_id_reg_pd;

CHOOSE CASE SQLCA.SQLCode
	CASE 0
		IF IsNull(ldc_importo) THEN
			
			
			 DECLARE lcur_importo CURSOR FOR  
			  SELECT "mov_contabile"."dare",   
						"mov_contabile"."avere"  
				 FROM "anagrafica",   
						"mov_contabile",   
						"sog_commerciale",   
						"conto"  
				WHERE ( "sog_commerciale"."id_anagrafica" = "anagrafica"."id_anagrafica" ) and  
						( "conto"."id_conto" = "sog_commerciale"."id_conto" ) and  
						( "conto"."id_conto" = "mov_contabile"."id_conto" ) and  
						( ( "mov_contabile"."id_reg_pd" = :il_id_reg_pd ) AND  
						( "anagrafica"."nat_giuridica" = 'F' )); 
						

			OPEN lcur_importo;
			FETCH lcur_importo INTO :ldc_dare, :ldc_avere;
			IF SQLCA.SQLCode = 0 THEN
				IF IsNull(ldc_dare) THEN 
					ldc_importo = ldc_avere
				ELSEIF IsNull(ldc_avere) THEN 
					ldc_importo = ldc_dare
				END IF
			END IF
			CLOSE lcur_importo;
		END IF
END CHOOSE
	

idc_imponibile = uf_calc_imponibile()
IF IsNull(idc_imponibile) THEN idc_imponibile = ldc_importo

SELECT sum("DBA".mov_iva.imponibile)  
	INTO :idc_rimborsi
	FROM "DBA".mov_iva, "DBA".tab_iva  
	WHERE ( "DBA".tab_iva.id_tab_iva = "DBA".mov_iva.id_tab_iva ) AND  
		( ( "DBA".mov_iva.id_reg_pd = :il_id_reg_pd ) AND  
		
		
		( "DBA".tab_iva.id_tab_iva = :il_esente ) );
		

IF IsNull(idc_rimborsi) THEN idc_rimborsi = 0

SELECT "DBA".anagrafica.cassa_previdenza,  
		 "DBA".anagrafica.rit_previdenziale 
	INTO :idc_per_cassa_prev,
		  :idc_per_rit_previd
	FROM "DBA".anagrafica,
		  "DBA".sog_commerciale
	WHERE ("DBA".anagrafica.id_anagrafica = "DBA".sog_commerciale.id_anagrafica) AND
	      ("DBA".sog_commerciale.id_sog_commerciale = :il_id_sog_commerciale)  ;

IF IsNull(idc_per_cassa_prev) THEN idc_per_cassa_prev = 0
IF IsNull(idc_per_rit_previd) THEN idc_per_rit_previd = 0


if il_val_lire=il_valuta then
	idc_cassa_prev = Round(((idc_imponibile * idc_per_cassa_prev) / (100 + idc_per_cassa_prev)), 0)
else	
	idc_cassa_prev = Round(((idc_imponibile * idc_per_cassa_prev) / (100 + idc_per_cassa_prev)), 2)
end if

IF IsNull(idc_cassa_prev) THEN idc_cassa_prev = 0

if il_val_lire=il_valuta then
	idc_rit_acconto = Round(((ldc_per_tributo * (idc_imponibile - idc_cassa_prev)) / 100), 0)
else
	idc_rit_acconto = Round(((ldc_per_tributo * (idc_imponibile - idc_cassa_prev)) / 100), 2)
end if

IF IsNull(idc_rit_acconto) 	THEN idc_rit_acconto = 0

IF ll_CurrRow = 0 OR IsNull(ll_CurrRow) THEN
	dw_rit_acconto_ff.InsertRow(0)
	ll_CurrRow = dw_rit_acconto_ff.GetRow()
END IF

IF ll_id_tributo > 0 THEN
	dw_rit_acconto_ff.SetItem(ll_CurrRow, "id_tributo_cod", ll_id_tributo)
END IF

dw_rit_acconto_ff.SetItem(ll_CurrRow, "rimborso", idc_rimborsi)
dw_rit_acconto_ff.SetItem(ll_CurrRow, "per_cassa_previdenza", idc_per_cassa_prev)
dw_rit_acconto_ff.SetItem(ll_CurrRow, "cassa_previdenza", idc_cassa_prev)

dw_rit_acconto_ff.SetItem(ll_CurrRow, "info_reg", is_info_reg_pd)
dw_rit_acconto_ff.SetItem(ll_CurrRow, "info_fornitore", is_info_sc)

dw_rit_acconto_ff.SetItem(ll_CurrRow, "per_imp_ritenuta", idc_per_impon)

CHOOSE CASE ll_SQL_Tributo
	CASE 0
		idc_imp_ritenuta = ((idc_imponibile -  idc_cassa_prev ) * idc_per_impon) / 100
	CASE 100
		idc_imp_ritenuta = 0
END CHOOSE	
dw_rit_acconto_ff.SetItem(ll_CurrRow, "imp_ritenuta", idc_imp_ritenuta)



dw_rit_acconto_ff.SetItem(ll_CurrRow, "per_rit_acconto", ldc_per_tributo)
dw_rit_acconto_ff.SetItem(ll_CurrRow, "rit_acconto", idc_rit_acconto)

dw_rit_acconto_ff.SetItem(ll_CurrRow, "per_rit_previdenziale", idc_per_rit_previd)

if il_valuta=il_val_lire then
	idc_rit_previd = Round((((idc_imponibile - idc_cassa_prev) * idc_per_rit_previd) / 300), 0)
else
	idc_rit_previd = Round((((idc_imponibile - idc_cassa_prev) * idc_per_rit_previd) / 300), 2)
end if	
dw_rit_acconto_ff.SetItem(ll_CurrRow, "rit_previdenziale", idc_rit_previd)
dw_rit_acconto_ff.SetItem(ll_CurrRow, "tot_fattura", ldc_importo)

ldc_comp_totale = (ldc_importo - idc_rit_acconto - idc_rit_previd)
IF IsNull(ldc_comp_totale) THEN ldc_comp_totale = 0

dw_rit_acconto_ff.SetItem(ll_CurrRow, "com_totale", ldc_comp_totale)

dw_rit_acconto_ff.SetItem(ll_CurrRow, "id_valuta", il_valuta)


end event

public function long uf_calc_imponibile ();
decimal ldc_imponibile

SetNull(ldc_imponibile)

SELECT sum("DBA".mov_iva.imponibile)  
INTO :ldc_imponibile  
FROM "DBA".mov_iva, "DBA".tab_iva  
WHERE ( "DBA".tab_iva.id_tab_iva = "DBA".mov_iva.id_tab_iva ) AND  
	( ( "DBA".mov_iva.id_reg_pd = :il_id_reg_pd) AND  
	
	
	( "DBA".tab_iva.id_tab_iva <> :il_esente ) );
	
RETURN ldc_imponibile
end function

public function integer uf_crea_rit_acconto ();

integer li_retval = 1
long ll_row, ll_id_tributo, ll_num_reg_progressivo, ll_num_documento
decimal {4} ldc_per_cassa_previd, ldc_per_imp_riten, ldc_per_rit_acconto, ldc_per_rit_previd
decimal {4} ldc_comp_totale, ldc_com_totale, ldc_rimborso, ldc_cassa_previd, ldc_imp_riten
decimal {4} ldc_rit_acconto, ldc_rit_previd
string ls_descrizione
date ld_data_registrazione, ld_data_competenza, ld_data_documento

SetPointer(HourGlass!)

ll_row = dw_rit_acconto_ff.GetRow()

IF ll_row > 0 THEN
	ll_id_tributo        = dw_rit_acconto_ff.GetItemNumber(ll_row, "id_tributo_cod")
	ldc_per_rit_previd   = dw_rit_acconto_ff.uf_GetItemDecimal(ll_row, "per_rit_previdenziale")
	ldc_rit_previd       = dw_rit_acconto_ff.uf_GetItemDecimal(ll_row, "rit_previdenziale")

	
	
	IF ll_id_tributo > 0 OR ldc_per_rit_previd > 0 OR ldc_rit_previd > 0 THEN
		ls_descrizione       = dw_rit_acconto_ff.GetItemString(ll_row, "descrizione")
		ldc_com_totale       = dw_rit_acconto_ff.uf_GetItemDecimal(ll_row, "com_totale")
		ldc_rimborso         = dw_rit_acconto_ff.uf_GetItemDecimal(ll_row, "rimborso")
		ldc_per_cassa_previd = dw_rit_acconto_ff.uf_GetItemDecimal(ll_row, "per_cassa_previdenza")
		ldc_cassa_previd     = dw_rit_acconto_ff.uf_GetItemDecimal(ll_row, "cassa_previdenza")
		ldc_per_imp_riten    = dw_rit_acconto_ff.uf_GetItemDecimal(ll_row, "per_imp_ritenuta")
		ldc_imp_riten        = dw_rit_acconto_ff.uf_GetItemDecimal(ll_row, "imp_ritenuta")
		ldc_per_rit_acconto  = dw_rit_acconto_ff.uf_GetItemDecimal(ll_row, "per_rit_acconto")
		ldc_rit_acconto      = dw_rit_acconto_ff.uf_GetItemDecimal(ll_row, "rit_acconto")
		ldc_comp_totale      = dw_rit_acconto_ff.uf_GetItemDecimal(ll_row, "tot_fattura")

		IF NOT (ldc_imp_riten > 0) THEN ldc_imp_riten = ldc_comp_totale
		
		
		  SELECT "reg_pd"."num_progressivo",   
				"reg_pd"."data_registrazione",   
				"reg_pd"."data_competenza",   
				"reg_pd"."num_documento",   
				"reg_pd"."data_documento"  
		 INTO :ll_num_reg_progressivo,   
				:ld_data_registrazione,   
				:ld_data_competenza,   
				:ll_num_documento,   
				:ld_data_documento  
		 FROM "reg_pd"  
		WHERE "reg_pd"."id_reg_pd" = :il_id_reg_pd   ;
	
		CHOOSE CASE SQLCA.SQLCode
			CASE -1
				MessageBox("Errore sul DataBase","w_rit_acconto_wz / uf_crea_rit_acconto / 1")
				RETURN 0
		END CHOOSE
	
		INSERT INTO "compenso"
			( "id_sog_commerciale",
			  "id_reg_pd",
			  "id_tributo",
			  "descrizione",
			  "com_totale",
			  "rimborsi",   
			  "per_cassa_previdenza",   
			  "cassa_previdenza",   
			  "per_imp_ritenuta",   
			  "imp_ritenuta",   
			  "per_rit_acconto",   
			  "rit_acconto",   
			  "per_rit_previdenziale",   
			  "rit_previdenziale",
			  "num_reg_progressivo",
			  "data_registrazione",
			  "data_competenza",
			  "num_documento",
			  "data_documento")  
		VALUES (:il_id_sog_commerciale,   
			:il_id_reg_pd,   
			:ll_id_tributo,   
			:ls_descrizione,   
			:ldc_com_totale,   
			:ldc_rimborso,   
			:ldc_per_cassa_previd,   
			:ldc_cassa_previd,   
			:ldc_per_imp_riten,   
			:ldc_imp_riten,   
			:ldc_per_rit_acconto,   
			:ldc_rit_acconto,   
			:ldc_per_rit_previd,   
			:ldc_rit_previd,
			:ll_num_reg_progressivo,
			:ld_data_registrazione,
			:ld_data_competenza,
			:ll_num_documento,
			:ld_data_documento)  ;

		IF SQLCA.SQLCode <> 0 THEN
			li_retval = 0
		END IF
	END IF
ELSE
	li_retval = 0
END IF

RETURN li_retval

SetPointer(Arrow!)
end function

on w_rit_acconto_wz.create
int iCurrent
call super::create
this.cb_annulla=create cb_annulla
this.cb_ok=create cb_ok
this.dw_rit_acconto_ff=create dw_rit_acconto_ff
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_annulla
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.dw_rit_acconto_ff
end on

on w_rit_acconto_wz.destroy
call super::destroy
destroy(this.cb_annulla)
destroy(this.cb_ok)
destroy(this.dw_rit_acconto_ff)
end on

event open;
il_HelpTopic = 323

is_wintype = "w_wiz_main"
u_freddie.center_window(this)
This.TriggerEvent("ue_initvar")
ib_openok = f_check_serial(is_serialize)
if ib_openok then
	ib_openok = f_check_win_password(is_password)
end if
if ib_openok then
	
	
	
	
	
	
	
	is_list = Message.PowerObjectParm
	
	
	il_id_reg_pd = is_list.l_identifica[1]
	
	
	
	
	
	
	
	
	select id_val_lire into :il_val_lire from par_sistema; 
	
	SELECT "sog_commerciale"."id_sog_commerciale", "reg_pd"."id_valuta"  
		INTO :il_id_sog_commerciale, :il_valuta  
		FROM "sog_commerciale",   
				"conto",   
				"reg_pd"  
		WHERE ( "conto"."id_conto" = "sog_commerciale"."id_conto" ) and  
				( "reg_pd"."id_conto" = "conto"."id_conto" ) and  
				( ( "reg_pd"."id_reg_pd" = :il_id_reg_pd ) )   ;
	
	
	CHOOSE CASE SQLCA.SQLCode
		CASE 0
			IF NOT IsNull(il_id_sog_commerciale) THEN
				is_info_sc = f_info_sc(il_id_sog_commerciale)
				is_info_reg_pd = f_info_reg_pd(il_id_reg_pd)
			END IF			
			
		CASE 100
			 DECLARE lcur_fornitore CURSOR FOR  
			  SELECT "sog_commerciale"."id_sog_commerciale"
				 FROM "mov_contabile",   
						"sog_commerciale",   
						"anagrafica"  
				WHERE ( "mov_contabile"."id_conto" = "sog_commerciale"."id_conto" ) and  
						( "anagrafica"."id_anagrafica" = "sog_commerciale"."id_anagrafica" ) and  
						( ( "mov_contabile"."id_reg_pd" = :il_id_reg_pd ) AND  
						( "anagrafica"."nat_giuridica" = 'F' )) ; 
						
	
			OPEN lcur_fornitore;
			FETCH lcur_fornitore INTO :il_id_sog_commerciale;
			IF SQLCA.SQLCode = 0 THEN
				is_info_sc = f_info_sc(il_id_sog_commerciale)
				is_info_reg_pd = f_info_reg_pd(il_id_reg_pd)
			END IF
			CLOSE lcur_fornitore;
	
	
		CASE -1
			MessageBox("Errore sul DataBase", "w_rit_acconto_wz / open / 1")
			RETURN 0
	END CHOOSE
	iuo_msg_log = create uo_msg_log
	iuo_msg_log.uf_new_text("Sessione del " + String(Today()) + " - " + String(Now()),2)
	THIS.Event ue_post_open()
	dw_rit_acconto_ff.Event Post ue_post_open()
else
	Close(This)
end if





end event

type cb_annulla from commandbutton within w_rit_acconto_wz
int X=343
int Y=40
int Width=270
int Height=84
int TabOrder=20
string Text="Annulla"
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Close(Parent)
end event

type cb_ok from commandbutton within w_rit_acconto_wz
int X=46
int Y=40
int Width=261
int Height=84
int TabOrder=10
string Text="Ok"
boolean Default=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

Parent.Event ue_genera()
Close(Parent)
end event

type dw_rit_acconto_ff from u_dw_ext_main within w_rit_acconto_wz
event ue_ricalcola_perc ( )
event ue_ricalcola_imp ( )
event ue_ricalcola_netto ( )
int X=50
int Y=156
int Width=2857
int Height=1080
int TabOrder=11
string DataObject="d_rit_acconto_ff"
end type

event ue_ricalcola_imp;call super::ue_ricalcola_imp;
end event

event ue_ricalcola_netto;call super::ue_ricalcola_netto;long ll_CurrRow
decimal ldc_tot_fattura

ll_CurrRow = THIS.GetRow()

ldc_tot_fattura = THIS.uf_GetItemDecimal(ll_CurrRow, "tot_fattura")
idc_rit_acconto = THIS.uf_GetItemDecimal(ll_CurrRow, "rit_acconto")
idc_rit_previd = THIS.uf_GetItemDecimal(ll_CurrRow, "rit_previdenziale")

THIS.SetItem(ll_CurrRow, "com_totale", (ldc_tot_fattura - idc_rit_acconto - idc_rit_previd))
end event

event itemchanged;

long ll_CurrRow
decimal ldc_cassa_prev_old , ldc_rimborso_old, ldc_tot_fattura, ldc_per_impon_old, ldc_imp_riten_old
ll_CurrRow = THIS.GetRow()

CHOOSE CASE string(dwo.name)
	CASE "per_imp_ritenuta"
		
		ldc_imp_riten_old = THIS.uf_GetItemDecimal(ll_CurrRow, "imp_ritenuta")
		THIS.AcceptText()
		idc_per_impon = THIS.uf_GetItemDecimal(ll_CurrRow, "per_imp_ritenuta")
		idc_imp_ritenuta = (((idc_imponibile - idc_cassa_prev) * idc_per_impon) / 100) 
		THIS.SetItem(ll_CurrRow, "imp_ritenuta", idc_imp_ritenuta)
		idc_imponibile = idc_imp_ritenuta + idc_cassa_prev
		
		
		
		
		THIS.Event ue_ricalcola_netto()
	CASE "per_cassa_previdenza"
		THIS.AcceptText()
		idc_per_cassa_prev = THIS.uf_GetItemDecimal(ll_CurrRow, "per_cassa_previdenza")
		ldc_cassa_prev_old = idc_cassa_prev
		idc_cassa_prev = ((idc_imponibile - ldc_cassa_prev_old) * idc_per_cassa_prev) / 100 
		idc_imponibile = idc_imponibile - ldc_cassa_prev_old + idc_cassa_prev
		THIS.SetItem(ll_CurrRow, "cassa_previdenza", idc_cassa_prev)
		
		THIS.Event ue_ricalcola_netto()
	CASE "per_rit_acconto"
		THIS.AcceptText()
		idc_per_rit_acconto = THIS.uf_GetItemDecimal(ll_CurrRow, "per_rit_acconto")
		idc_rit_acconto = idc_imp_ritenuta / 100 * idc_per_rit_acconto
		THIS.SetItem(ll_CurrRow, "rit_acconto", idc_rit_acconto)
		
		THIS.Event ue_ricalcola_netto()
	CASE "per_rit_previdenziale"
		THIS.AcceptText()
		idc_per_rit_previd = THIS.uf_GetItemDecimal(ll_CurrRow, "per_rit_previdenziale")
		idc_rit_previd = ((idc_imponibile - idc_cassa_prev) * idc_per_rit_previd) / 300
		THIS.SetItem(ll_CurrRow, "rit_previdenziale", idc_rit_previd)
		
		THIS.Event ue_ricalcola_netto()
	CASE "rimborso"
		ldc_rimborso_old = THIS.uf_GetItemDecimal(ll_CurrRow, "rimborso")
		THIS.AcceptText()
		ldc_tot_fattura = THIS.uf_GetItemDecimal(ll_CurrRow, "tot_fattura")
		idc_rimborsi = THIS.uf_GetItemDecimal(ll_CurrRow, "rimborso")
		ldc_tot_fattura = ldc_tot_fattura - ldc_rimborso_old + idc_rimborsi
		THIS.SetItem(ll_CurrRow, "tot_fattura", ldc_tot_fattura)
		
		THIS.Event ue_ricalcola_netto()
END CHOOSE
end event

event ue_init;call super::ue_init;is_Colonne_Drop[1] = "id_tributo_cod"
is_Colonne_Drop[2] = "id_tributo_des"
end event

event doubleclicked;
end event

