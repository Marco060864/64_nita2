forward
global type w_orafo_stampa_etichette_rpt from window
end type
type st_5 from statictext within w_orafo_stampa_etichette_rpt
end type
type sle_cod_azienda from singlelineedit within w_orafo_stampa_etichette_rpt
end type
type cb_inserisci_blank from commandbutton within w_orafo_stampa_etichette_rpt
end type
type dw_2 from datawindow within w_orafo_stampa_etichette_rpt
end type
type cb_4 from commandbutton within w_orafo_stampa_etichette_rpt
end type
type cb_3 from commandbutton within w_orafo_stampa_etichette_rpt
end type
type cbx_1 from checkbox within w_orafo_stampa_etichette_rpt
end type
type em_1 from editmask within w_orafo_stampa_etichette_rpt
end type
type st_4 from statictext within w_orafo_stampa_etichette_rpt
end type
type cb_formato from commandbutton within w_orafo_stampa_etichette_rpt
end type
type cb_avanti from commandbutton within w_orafo_stampa_etichette_rpt
end type
type cb_indietro from commandbutton within w_orafo_stampa_etichette_rpt
end type
type st_pagina from statictext within w_orafo_stampa_etichette_rpt
end type
type st_3 from statictext within w_orafo_stampa_etichette_rpt
end type
type st_2 from statictext within w_orafo_stampa_etichette_rpt
end type
type st_1 from statictext within w_orafo_stampa_etichette_rpt
end type
type cb_stampa from commandbutton within w_orafo_stampa_etichette_rpt
end type
type dw_1 from datawindow within w_orafo_stampa_etichette_rpt
end type
type cb_impostazioni from commandbutton within w_orafo_stampa_etichette_rpt
end type
end forward

global type w_orafo_stampa_etichette_rpt from window
integer x = 82
integer y = 84
integer width = 2999
integer height = 1928
boolean titlebar = true
string title = "Stampa Etichette"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 79741120
st_5 st_5
sle_cod_azienda sle_cod_azienda
cb_inserisci_blank cb_inserisci_blank
dw_2 dw_2
cb_4 cb_4
cb_3 cb_3
cbx_1 cbx_1
em_1 em_1
st_4 st_4
cb_formato cb_formato
cb_avanti cb_avanti
cb_indietro cb_indietro
st_pagina st_pagina
st_3 st_3
st_2 st_2
st_1 st_1
cb_stampa cb_stampa
dw_1 dw_1
cb_impostazioni cb_impostazioni
end type
global w_orafo_stampa_etichette_rpt w_orafo_stampa_etichette_rpt

type variables
datawindow dw
string configurazione_attuale
end variables

forward prototypes
public subroutine imposta_label_data_window (ref datawindow dw_label)
public subroutine riempi ()
public function string code_into_ean13 (string barcode)
public subroutine riempi_da_stampa ()
public subroutine riempi_da_righe ()
public subroutine riempi_visconti ()
public subroutine riempi_da_listar ()
public subroutine riempi_da_rch ()
public function string cod_into_ean_8 (string barcode)
end prototypes

public subroutine imposta_label_data_window (ref datawindow dw_label);integer num_col, altezza, larghezza, dist_colonne, dist_righe, marg_sup, marg_sx
string ls_ret, ls_objects, ls_oldstr
string ls_nome[], ls_font, ls_autosize
long  ll_x, ll_y, ll_dim_campo, ll_dim_carattere, ll_alt_campo, ll_rotaz, ll_bold
integer ll_start_pos, i, ll_pos_ini

dw_label.Reset ( )
SELECT "parametri_stampa_etichette"."numero_colonne", 
		"parametri_stampa_etichette"."larghezza_etichetta" ,   
		"parametri_stampa_etichette"."altezza_etichetta" ,   
		"parametri_stampa_etichette"."distanza_righe",   
		"parametri_stampa_etichette"."distanza_colonne",
		"parametri_stampa_etichette"."margine_superiore",
		"parametri_stampa_etichette"."margine_sinistro"
into :num_col,:larghezza,:altezza,:dist_righe,:dist_colonne,:marg_sup,:marg_sx
FROM "parametri_stampa_etichette"  
WHERE "parametri_stampa_etichette"."nome_configurazione" = :configurazione_attuale     
;


ls_ret=dw_label.modify('DataWindow.Label.Columns	 				= '+string(num_col))
ls_ret=ls_ret+dw_label.modify('DataWindow.Label.Rows						= 1')
ls_ret=ls_ret+dw_label.modify('DataWindow.Label.Columns.Spacing		= '+string(dist_colonne * 10))
ls_ret=ls_ret+dw_label.modify('DataWindow.Label.Rows.Spacing			= '+string(dist_righe * 10))
ls_ret=ls_ret+dw_label.modify('DataWindow.Label.Height					= '+string(altezza * 10))
ls_ret=ls_ret+dw_label.modify('DataWindow.Label.Width					= '+string(larghezza * 10))
if ls_ret<>"" then messagebox("error",ls_ret)


dw_label.Object.DataWindow.Print.Margin.Top = (marg_sup * 10)
dw_label.Object.DataWindow.Print.Margin.Left = (marg_sx * 10)

if cbx_1.checked = true then
	dw_label.modify('cornice.X	= '+ "200")	
	dw_label.modify('cornice.y	= '+ "200")		
	dw_label.modify('cornice.width	= '+ string(((larghezza*10)-400)))
	dw_label.modify('cornice.Height	= '+ string(((altezza*10)-400)))
	dw_label.modify('cornice.pen.style	= '+ "0")		
	dw_label.modify('cornice.pen.width	= '+ "70")	

else 
	dw_label.modify('cornice.Visible	= '+ "0")	
	dw_label.modify('cornice.pen.style	= '+ "5")
end if

if ls_ret<>"" then messagebox("error",ls_ret)


ls_objects = dw_1.Object.DataWindow.Objects	

ls_oldstr = "~t"
ll_start_pos = Pos(ls_objects, ls_oldstr)
DO while ll_start_pos > 0
	i++
	ls_nome[i]=mid(ls_objects, ll_pos_ini+1, (ll_start_pos - 1) - (ll_pos_ini) )
	
	ll_pos_ini=ll_start_pos
	ll_start_pos = Pos(ls_objects, ls_oldstr, ll_pos_ini+1)
LOOP 
if len(ls_objects) > ll_pos_ini then
	ls_nome[i+1]=mid(ls_objects, ll_pos_ini+1, len(ls_objects) - (ll_pos_ini) )
end if
	

for i = 1 to upperbound(ls_nome)
	select x, y, dim_campo, dim_carattere, alt_campo, rotazione, grassetto, font, autosize
	into :ll_x, :ll_y, :ll_dim_campo, :ll_dim_carattere, :ll_alt_campo, :ll_rotaz, :ll_bold, :ls_font, :ls_autosize
	from formato_stampa_etichette
	where nome_formato = :ls_nome[i]
	and nome_configurazione = :configurazione_attuale;
	if sqlca.sqlcode=0 then
		if not isnull(ll_x) and ll_x <> 0 then dw_label.modify(ls_nome[i]+'.x= '+string(ll_x*10))
		if not isnull(ll_y) and ll_y <> 0 then dw_label.modify(ls_nome[i]+'.y= '+string(ll_y*10))
		if not isnull(ll_dim_carattere) and ll_dim_carattere <> 0 then dw_label.modify(ls_nome[i]+'.font.height= '+string(ll_dim_carattere*10))
		if not isnull(ll_alt_campo) and ll_alt_campo <> 0 then dw_label.modify(ls_nome[i]+'.height= '+string(ll_alt_campo*10))
		if not isnull(ll_dim_campo) and ll_dim_campo <> 0 then dw_label.modify(ls_nome[i]+'.Width	= '+string(ll_dim_campo*10))	
		if not isnull(ll_bold) and ll_bold <> 0 then dw_label.modify(ls_nome[i]+'.font.Weight= '+string(ll_bold))	
		if not isnull(ls_font) and ls_font <> "" then dw_label.modify(ls_nome[i]+'.font.face= "'+ ls_font + '"')	
		if not isnull(ls_autosize) and ls_autosize <> "" then 
			if ls_autosize = 'S' then
				dw_label.modify(ls_nome[i]+'.Height.AutoSize	= Yes')	
			else
				dw_label.modify(ls_nome[i]+'.Height.AutoSize	= No')			
			end if
		end if
		if not isnull(ll_rotaz) and ll_rotaz <> 0 then dw_label.modify(ls_nome[i]+'.font.escapement='+string(ll_rotaz*10))	
	else
		dw_label.modify(ls_nome[i]+'.font.height= 0')
	
		
	end if		
next	

end subroutine

public subroutine riempi ();string calling_dw, ls_cod

calling_dw = dw.className()
SELECT CODICE
INTO :LS_COD
FROM AZIENDA
WHERE ID_AZIENDA=1;



CHOOSE CASE calling_dw
	CASE "dw_riga_documento_ordine_gd"
		if upper(ls_cod)='VISCONTI' then
			riempi_visconti()
		else
			
			riempi_da_righe()
			
		end if
	CASE "dw_selezionati_lt"
		riempi_da_stampa()
		
   case "dw_1"
		riempi_da_listar()		
		
   case "dw_2"
		riempi_da_rch()				
		
	CASE ELSE
		messagebox("Attenzione!","Sconosciuta DataWindow")
END CHOOSE

end subroutine

public function string code_into_ean13 (string barcode);string result
integer  Left_A, Left_B, Right, First_Flag, Second_Flag, Check_char,FFC, i
char A_o_B[10,5]

A_o_B[1,1] = "A"
A_o_B[1,2] = "A"
A_o_B[1,3] = "A"
A_o_B[1,4] = "A"
A_o_B[1,5] = "A"

A_o_B[2,1] = "A"
A_o_B[2,2] = "B"
A_o_B[2,3] = "A"
A_o_B[2,4] = "B"
A_o_B[2,5] = "B"

A_o_B[3,1] = "A"
A_o_B[3,2] = "B"
A_o_B[3,3] = "B"
A_o_B[3,4] = "A"
A_o_B[3,5] = "B"

A_o_B[4,1] = "A"
A_o_B[4,2] = "B"
A_o_B[4,3] = "B"
A_o_B[4,4] = "B"
A_o_B[4,5] = "A"

A_o_B[5,1] = "B"
A_o_B[5,2] = "A"
A_o_B[5,3] = "A"
A_o_B[5,4] = "B"
A_o_B[5,5] = "B"

A_o_B[6,1] = "B"
A_o_B[6,2] = "B"
A_o_B[6,3] = "A"
A_o_B[6,4] = "A"
A_o_B[6,5] = "B"

A_o_B[7,1] = "B"
A_o_B[7,2] = "B"
A_o_B[7,3] = "B"
A_o_B[7,4] = "A"
A_o_B[7,5] = "A"

A_o_B[8,1] = "B"
A_o_B[8,2] = "A"
A_o_B[8,3] = "B"
A_o_B[8,4] = "A"
A_o_B[8,5] = "B"

A_o_B[9,1] = "B"
A_o_B[9,2] = "A"
A_o_B[9,3] = "B"
A_o_B[9,4] = "B"
A_o_B[9,5] = "A"

A_o_B[10,1] = "B"
A_o_B[10,2] = "B"
A_o_B[10,3] = "A"
A_o_B[10,4] = "B"
A_o_B[10,5] = "A"

Left_A = 48
Left_B = 64
Right = 80
First_Flag = 33
Second_Flag = 96
Check_char = 112
Result = ""


if (Len(barcode)<> 13) or (not(IsNumber(barcode))) then
	messageBox("Alert", "Il codice non è un numero di 13 cifre")
	return Result
end if

FFC = integer(Mid(barCode,1,1))

result  = result + char(FFC + First_Flag)
result  = result + char(integer(Mid(barCode,2,1)) + Second_Flag)

for i = 3 to 7
	if  A_o_B[FFC + 1, i - 2 ]  =  "B" then
		
		result  = result + char(integer(Mid(barCode,i,1)) + Left_B)
	else
		
		result  = result + char(integer(Mid(barCode,i,1)) + Left_A)
	end if


next

result = result + "|"

for i = 8 to 12
	result  = result + char(integer(Mid(barCode,i,1)) + Right)
next

result  = result + char(integer(Mid(barCode,13,1)) + Check_char)

return Result
end function

public subroutine riempi_da_stampa ();long ll_id_val, ll_id_var, ll_id_art
integer i, li_cifre
string ls_rag, ls_calling_dw, ls_tipo_arr
decimal ldc_cambio

dw_1.reset()	
st_2.text = configurazione_attuale
	
ls_calling_dw = dw.className()
if ls_calling_dw = "dw_selezionati_lt" and  dw.dataobject<>"d_var_articoli_art_lt" then
	for i = 1 to dw.rowCount()
		ls_rag=dw.getitemstring(i, "rag_soc_1")
		dw_1.retrieve(ls_rag)
	next	
else
	ll_id_val=dw_2.getitemnumber(1, "id_valuta")
	ll_id_var=dw_2.getitemnumber(1, "id_variazione")
	select cifra_arrotondamento, tipo_arrotondamento
	into :li_cifre, :ls_tipo_arr
	from valuta
	where id_valuta=:ll_id_val;
	ldc_cambio=dw_2.getitemdecimal(1, "cambio")
	for i = 1 to dw.rowCount()
		ll_id_art=dw.getitemnumber(i, "id_articolo")
		dw_1.retrieve(ll_id_art, ll_id_var, ll_id_val, li_cifre, ls_tipo_arr, ldc_cambio)
	next

end if




end subroutine

public subroutine riempi_da_righe ();integer i  
long ll_id_riga, ll_id_articolo
st_2.text = configurazione_attuale
		
for i = 1 to dw.rowCount()
	ll_id_riga=dw.getItemNumber(i, "id_riga_documento")
	ll_id_articolo=dw.getItemNumber(i, "riga_documento_id_articolo")
	if ll_id_articolo>0 then
		dw_1.retrieve(ll_id_riga)
	end if
next
		
		
		
end subroutine

public subroutine riempi_visconti ();integer i  
string cod_art, cod_bar, descr,ls_desc_valuta,lS_id_cat_merc, cod_bar_t
long unit_conf, ll_id_documento, ll_id_valuta, ll_lingua, ll_id_sog_commerciale, ll_id_articolo
decimal {4} prezzo, larghezza, altezza
ll_id_documento=dw.getitemnumber(1, "id_documento")
select d.id_sog_commerciale, d.id_valuta, v.descrizione
into :ll_id_sog_commerciale, :ll_id_valuta, :ls_desc_valuta
from documento d, valuta v
where id_documento=:ll_id_documento
and v.id_valuta=d.id_valuta;

select a.id_lingua
into :ll_lingua
from anagrafica a, sog_commerciale s
where a.id_anagrafica=s.id_anagrafica
and s.id_sog_commerciale=:ll_id_sog_commerciale;

st_2.text = configurazione_attuale
string tmp	
for i = 1 to dw.rowCount()
	tmp ="c_articolo_cod"
	cod_art = dw.getItemString(i,tmp)	
	unit_conf = dw.getItemNumber(i,"riga_documento_id_unita_confezione")	
	ll_id_articolo=dw.getItemNumber(i, "riga_documento_id_articolo")
	if ll_id_articolo>0 and not isnull(ll_id_articolo) then
		select descrizione
		into :descr
		from des_articolo
		where id_lingua=:ll_lingua
		and id_articolo=:ll_id_articolo;
	end if
	if isnull(descr) or descr='' then
		descr = dw.getItemString(i,"riga_documento_descrizione")	
	end if
	prezzo = dw.getItemNumber(i,"prezzo")	
	
	  SELECT "cod_barre"."codice"
		 INTO :cod_bar
		 FROM "cod_barre"   
	WHERE "cod_barre"."id_unita_confezione" = :unit_conf;
		
	
	select c.descrizione
	into :lS_id_cat_merc
	from articolo a, cat_merceologica c
	where A.id_articolo=:ll_id_articolo
	AND C.ID_CAT_MERCEOLOGICA=A.ID_CAT_MERCEOLOGICA;
	
	
	
	select dim_l, dim_H
	into :larghezza, :altezza
	from unita_confezione
	where id_unita_confezione=:unit_conf
	and unita_base='S';
	
	
		INTEGER LL_ROW
		
		ll_row=dw_1.insertRow(0)		
		dw_1.setItem(ll_row,"codice",cod_art)	
		
		cod_bar_t = cod_bar 
		
		
		cod_bar = code_into_EAN13(cod_bar)
		
		dw_1.setItem(ll_row,"cod_barre",cod_bar)	
		dw_1.setItem(ll_row,"cod_barre_t",cod_bar_t)			
		dw_1.setItem(ll_row,"des_valuta",	ls_desc_valuta)
		dw_1.setItem(ll_row,"descrizione",descr)	
		
		dw_1.setItem(ll_row,"prezzo",prezzo)	
		dw_1.setItem(ll_row,"larghezza",larghezza)	
		dw_1.setItem(ll_row,"lunghezza",altezza)	
		dw_1.setItem(ll_row,"CAT_MERC_DES",lS_id_cat_merc)
		descr=''
		lS_id_cat_merc=''
		larghezza=0
		altezza=0
		cod_art=''
		cod_bar=''
		prezzo=0
		ls_desc_valuta=''
next

end subroutine

public subroutine riempi_da_listar ();integer i  
string cod_art, cod_bar, descr,ls_desc_valuta, cod_bar_t
long unit_conf, ll_id_documento, ll_id_valuta, ll_lingua 
long LL_ROW,ll_id_sog_commerciale, ll_id_articolo
decimal {4} prezzo, larghezza, profondita

string ls_uc_base, ls_uc_cod
decimal {4} prezzo_p


st_2.text = configurazione_attuale
string tmp	
for i = 1 to dw.rowCount()
	IF dw.IsSelected (i) then	

		prezzo_p = dw.getItemNumber(i,"prezzo1")     
		cod_bar = dw.getItemstring(i,"cod_art_forn")     
		descr = dw.getItemstring(i,"descrizione")     
		ls_desc_valuta = ''
		cod_art = dw.getItemstring(i,"codice")     
		
	   SELECT "unita_confezione"."id_unita_confezione" , "unita_confezione"."unita_base", "unita_confezione"."codice"
      INTO :unit_conf, :ls_uc_base, :ls_uc_cod
      FROM "unita_confezione","articolo"  
      WHERE ( "articolo"."codice" = :cod_art ) AND  
	    		( "unita_confezione"."id_articolo" = "articolo"."id_articolo" ) AND  
            ( "unita_confezione"."unita_base" = 'S' );   		
				
		if isnull(ls_uc_base) then ls_uc_base = 'N'		
		
		
		
		
		  SELECT "prezzo"."prezzo"
			 into :prezzo 
			 FROM "articolo",   
					"prezzo",   
					"unita_confezione"  
			WHERE ( "unita_confezione"."id_unita_confezione" = "prezzo"."id_unita_confezione" ) and  
					( "unita_confezione"."id_articolo" = "articolo"."id_articolo" ) 
		and  
					( "articolo"."codice" = :cod_art ) 
		and
					("prezzo"."id_variazione" = 
		
		(
		  SELECT "variazione"."id_variazione"  
			 
			 FROM "listino",   
					"variazione"  
			WHERE ( "variazione"."id_listino" = "listino"."id_listino" ) and  
					(  "listino"."tipo" = 'V' ) AND  
					( "listino"."lis_base" = 'S' ) AND  
					( "variazione"."data_inizio" <= today(*)  ) AND  
					(( "variazione"."data_fine" >= today(*) ) OR  
					( "variazione"."data_fine" is NULL ) )  
		))
		;				
		
		dw_1.setItem(ll_row,"des_valuta",	ls_desc_valuta)
		dw_1.setItem(ll_row,"descrizione",descr)	
		if prezzo > 0 then dw_1.setItem(ll_row,"prezzo",prezzo)	
		if prezzo_p > 0 then dw_1.setItem(ll_row,"prezzo_p",prezzo_p)		
			
	end if		
next


end subroutine

public subroutine riempi_da_rch ();integer i  
string cod_art, cod_bar, descr,ls_desc_valuta, cod_bar_t
long unit_conf, ll_id_documento, ll_id_valuta, ll_lingua, ll_id_sog_commerciale, ll_id_articolo
decimal {4} prezzo, larghezza, profondita

string ls_uc_base, ls_uc_cod
decimal {4} prezzo_p

st_2.text = configurazione_attuale
string tmp	
for i = 1 to dw.rowCount()
  IF dw.IsSelected (i) then
	prezzo_p = dw.getItemNumber(i,"riga_documento_prezzo")  
	ll_id_articolo = dw.getItemNumber(i,"riga_documento_id_articolo")   
	descr = dw.getItemstring(i,"articolo_descrizione")     
	ls_desc_valuta = ''
	cod_art = dw.getItemstring(i,"articolo_codice")     
	
	
	SELECT "unita_confezione"."id_unita_confezione" , "unita_confezione"."unita_base", "unita_confezione"."codice"
	INTO :unit_conf, :ls_uc_base, :ls_uc_cod
	FROM "unita_confezione","articolo"  
	WHERE ( "articolo"."codice" = :cod_art ) AND  
			( "unita_confezione"."id_articolo" = "articolo"."id_articolo" ) AND  
			( "unita_confezione"."unita_base" = 'S' );   			
	
	if isnull(ls_uc_base) then ls_uc_base = 'N'
			
	
	
	
	  SELECT "prezzo"."prezzo"
		 into :prezzo 
		 FROM "articolo",   
				"prezzo",   
				"unita_confezione"  
		WHERE ( "unita_confezione"."id_unita_confezione" = "prezzo"."id_unita_confezione" ) and  
				( "unita_confezione"."id_articolo" = "articolo"."id_articolo" ) 
	and  
				( "articolo"."codice" = :cod_art ) 
	and
				("prezzo"."id_variazione" = 
	
	(
	  SELECT "variazione"."id_variazione"  
		 
		 FROM "listino",   
				"variazione"  
		WHERE ( "variazione"."id_listino" = "listino"."id_listino" ) and  
				(  "listino"."tipo" = 'V' ) AND  
				( "listino"."lis_base" = 'S' ) AND  
				( "variazione"."data_inizio" <= today(*)  ) AND  
				(( "variazione"."data_fine" >= today(*) ) OR  
				( "variazione"."data_fine" is NULL ) )  
	))
	;				
	
	 SELECT "cod_barre"."codice"
    INTO :cod_bar
    FROM "cod_barre"   
 
   WHERE "cod_barre"."id_unita_confezione" = :unit_conf;
	
	INTEGER LL_ROW
	string ls_ean_conf
	integer li_lun_bar
	
	ll_row=dw_1.insertRow(0)		
	dw_1.setItem(ll_row,"codice",cod_art)	
	
	cod_bar_t = cod_bar
	
	li_lun_bar= len(cod_bar)	
	
	if li_lun_bar = 8 then 
		cod_bar = cod_into_EAN_8(cod_bar)
	else
		cod_bar = code_into_EAN13(cod_bar)
	end if			
	
	dw_1.setItem(ll_row,"cod_barre",cod_bar)	
	dw_1.setItem(ll_row,"cod_barre_t",cod_bar_t)			
	dw_1.setItem(ll_row,"des_valuta",	ls_desc_valuta)
	dw_1.setItem(ll_row,"descrizione",descr)	
	if prezzo > 0 then dw_1.setItem(ll_row,"prezzo",prezzo)	
	if prezzo_p > 0 then dw_1.setItem(ll_row,"prezzo_p",prezzo_p)		
		
	if ls_uc_base <> "S" then
		ls_ean_conf = "EAN CONF. " + trim(ls_uc_cod)
		dw_1.setItem(ll_row,"desc_uc",ls_ean_conf)			
		
	end if		
 end if		
next


end subroutine

public function string cod_into_ean_8 (string barcode);string result
integer  Left_A, Left_B, Right, First_Flag, Second_Flag, Check_char,FFC, i
char A_o_B[10,5]

A_o_B[1,1] = "A"
A_o_B[1,2] = "A"
A_o_B[1,3] = "A"
A_o_B[1,4] = "A"
A_o_B[1,5] = "A"

A_o_B[2,1] = "A"
A_o_B[2,2] = "B"
A_o_B[2,3] = "A"
A_o_B[2,4] = "B"
A_o_B[2,5] = "B"

A_o_B[3,1] = "A"
A_o_B[3,2] = "B"
A_o_B[3,3] = "B"
A_o_B[3,4] = "A"
A_o_B[3,5] = "B"

A_o_B[4,1] = "A"
A_o_B[4,2] = "B"
A_o_B[4,3] = "B"
A_o_B[4,4] = "B"
A_o_B[4,5] = "A"

A_o_B[5,1] = "B"
A_o_B[5,2] = "A"
A_o_B[5,3] = "A"
A_o_B[5,4] = "B"
A_o_B[5,5] = "B"

A_o_B[6,1] = "B"
A_o_B[6,2] = "B"
A_o_B[6,3] = "A"
A_o_B[6,4] = "A"
A_o_B[6,5] = "B"

A_o_B[7,1] = "B"
A_o_B[7,2] = "B"
A_o_B[7,3] = "B"
A_o_B[7,4] = "A"
A_o_B[7,5] = "A"

A_o_B[8,1] = "B"
A_o_B[8,2] = "A"
A_o_B[8,3] = "B"
A_o_B[8,4] = "A"
A_o_B[8,5] = "B"

A_o_B[9,1] = "B"
A_o_B[9,2] = "A"
A_o_B[9,3] = "B"
A_o_B[9,4] = "B"
A_o_B[9,5] = "A"

A_o_B[10,1] = "B"
A_o_B[10,2] = "B"
A_o_B[10,3] = "A"
A_o_B[10,4] = "B"
A_o_B[10,5] = "A"

Left_A = 48
Left_B = 64
Right = 80
First_Flag = 33
Second_Flag = 96
Check_char = 112
Result = ""


if (Len(barcode)<> 8) or (not(IsNumber(barcode))) then
	messageBox("Alert", "Il codice non è un numero di 8 cifre")
	return Result
end if

FFC = integer(Mid(barCode,1,1))


result  = result + char(FFC + second_flag)

for i = 2 to 4
	
	if  A_o_B[FFC, i ]  =  "A" then
		
		result  = result + char(integer(Mid(barCode,i,1)) + Left_A)
	else
		
		result  = result + char(integer(Mid(barCode,i,1)) + Left_A)
	end if


next

result = result + "|"

for i = 5 to 7
	result  = result + char(integer(Mid(barCode,i,1)) + Right)
next

result  = result + char(integer(Mid(barCode,8,1)) + Check_char)
return Result
end function

on w_orafo_stampa_etichette_rpt.create
this.st_5=create st_5
this.sle_cod_azienda=create sle_cod_azienda
this.cb_inserisci_blank=create cb_inserisci_blank
this.dw_2=create dw_2
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cbx_1=create cbx_1
this.em_1=create em_1
this.st_4=create st_4
this.cb_formato=create cb_formato
this.cb_avanti=create cb_avanti
this.cb_indietro=create cb_indietro
this.st_pagina=create st_pagina
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.cb_stampa=create cb_stampa
this.dw_1=create dw_1
this.cb_impostazioni=create cb_impostazioni
this.Control[]={this.st_5,&
this.sle_cod_azienda,&
this.cb_inserisci_blank,&
this.dw_2,&
this.cb_4,&
this.cb_3,&
this.cbx_1,&
this.em_1,&
this.st_4,&
this.cb_formato,&
this.cb_avanti,&
this.cb_indietro,&
this.st_pagina,&
this.st_3,&
this.st_2,&
this.st_1,&
this.cb_stampa,&
this.dw_1,&
this.cb_impostazioni}
end on

on w_orafo_stampa_etichette_rpt.destroy
destroy(this.st_5)
destroy(this.sle_cod_azienda)
destroy(this.cb_inserisci_blank)
destroy(this.dw_2)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cbx_1)
destroy(this.em_1)
destroy(this.st_4)
destroy(this.cb_formato)
destroy(this.cb_avanti)
destroy(this.cb_indietro)
destroy(this.st_pagina)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_stampa)
destroy(this.dw_1)
destroy(this.cb_impostazioni)
end on

event open;integer li_ret
long ll_id_valuta, ll_id_variazione
string ls_call_dw
decimal ldc_cambio

configurazione_attuale = "default"
dw_1.Object.DataWindow.Print.Preview = "YES"
dw_1.Object.DataWindow.Print.Preview.Rulers = "YES"	

dw_2.settransobject(sqlca)
dw_2.insertrow(1)
select id_valuta
into :ll_id_valuta
from par_sistema
;
SELECT id_variazione
into :ll_id_variazione
from variazione v, listino l
where l.id_listino=v.id_listino
and l.tipo='V' and l.lis_base='S'
and v.data_inizio<=today()
and (v.data_fine>= today() or data_fine is null)
;
select parita_euro
into :ldc_cambio
from valuta
where id_valuta=:ll_id_valuta;
dw_2.setitem(1, "id_valuta", ll_id_valuta)
dw_2.setitem(1, "id_variazione", ll_id_variazione)
dw_2.setitem(1, "cambio", ldc_cambio)

dw = message.powerobjectParm
	string ls_cod
	SELECT CODICE
	INTO :LS_COD
	FROM AZIENDA
	WHERE ID_AZIENDA=1;

ls_call_dw=dw.classname()
if ls_call_dw="dw_riga_documento_ordine_gd" then
		dw_1.dataobject="d_orafo_st_etichette_da_righe"
elseif dw.dataobject<>"d_var_articoli_art_lt"  then
	dw_1.dataobject="d_orafo_label_soggetto"
end if

dw_1.settransobject(sqlca)


dw_1.SetRedraw(FALSE)
imposta_label_data_window(dw_1)
riempi()
dw_1.SetRedraw(TRUE)
em_1.text = "1"
end event

event resize;dw_1.width=this.width - 680
dw_1.height=this.height - 680

cb_impostazioni.x= dw_1.x + dw_1.width + 20
cb_formato.x= dw_1.x + dw_1.width + 20
cb_stampa.x=cb_impostazioni.x +cb_impostazioni.width +10

st_1.x=cb_impostazioni.x
em_1.x=cb_impostazioni.x
st_4.x=cb_impostazioni.x

cbx_1.x=cb_impostazioni.x
dw_2.x=cb_impostazioni.x

cb_inserisci_blank.x=cb_impostazioni.x

cb_indietro.x=cb_impostazioni.x
st_3.x=cb_impostazioni.x + cb_indietro.width +10
cb_avanti.x=st_3.x + st_3.width +10

st_5.y=dw_1.height + 50
sle_cod_azienda.y=st_5.y
end event

type st_5 from statictext within w_orafo_stampa_etichette_rpt
integer x = 1349
integer y = 1660
integer width = 613
integer height = 68
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Inserisci codice Azienda:"
alignment alignment = center!
boolean focusrectangle = false
end type

type sle_cod_azienda from singlelineedit within w_orafo_stampa_etichette_rpt
integer x = 1984
integer y = 1636
integer width = 887
integer height = 100
integer taborder = 120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event modified;string ls_cod_azienda
dw_1.SetRedraw(False)
imposta_label_data_window(dw_1)
riempi()
ls_cod_azienda=sle_cod_azienda.text
if ls_cod_azienda>"" then
		dw_1.object.t_cod_azienda.text=ls_cod_azienda
end if
dw_1.SetRedraw(TRUE)
end event

type cb_inserisci_blank from commandbutton within w_orafo_stampa_etichette_rpt
integer x = 2414
integer y = 1192
integer width = 389
integer height = 188
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Inserisci Vuoti"
end type

event clicked;dw_1.insertrow(1)
end event

type dw_2 from datawindow within w_orafo_stampa_etichette_rpt
integer x = 2304
integer y = 664
integer width = 599
integer height = 496
integer taborder = 60
string dataobject = "d_valuta_variazione"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;long ll_id_val
decimal ldc_cambio
if dwo.name='id_valuta' then
	ll_id_val=long(data)
	select parita_euro
	into :ldc_cambio
	from valuta
	where id_valuta=:ll_id_val;
	setitem(row, "cambio", ldc_cambio)
end if
end event

type cb_4 from commandbutton within w_orafo_stampa_etichette_rpt
integer x = 645
integer y = 100
integer width = 247
integer height = 76
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ruota"
end type

event clicked;//dw_1.Object.codice.Font.Escapement = 2700
//dw_1.Object.codice_t.Font.Escapement = 2700
//dw_1.Object.pc_t.Font.Escapement = 2700
//dw_1.Object.pp_t.Font.Escapement = 2700
//dw_1.Object.prezzo.Font.Escapement = 2700
//dw_1.Object.prezzo_p.Font.Escapement = 2700
//dw_1.Object.descrizione.Font.Escapement = 2700
//
//
//this.enabled=false
//cb_1.enabled=false
//cb_2.enabled=false
//cb_3.enabled=false
end event

type cb_3 from commandbutton within w_orafo_stampa_etichette_rpt
integer x = 201
integer y = 100
integer width = 247
integer height = 76
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Labels6"
end type

event clicked;//
//dw_1.Object.codice_t.font.face	= 'arial'
//dw_1.Object.codice_t.x = 2800
//dw_1.Object.codice_T.y = 600
//
//dw_1.Object.codice.font.height = 400
//dw_1.Object.codice.font.Weight	= 700
//dw_1.Object.codice.font.face	= 'arial'
//dw_1.Object.codice.x = 2200
//dw_1.Object.codice.y = 2000
//
//dw_1.Object.pc_t.font.face	= 'arial'
//dw_1.Object.pc_t.x = 1850
//dw_1.Object.pc_T.y = 600
//
//dw_1.Object.prezzo.font.height = 400
//dw_1.Object.prezzo.font.Weight = 700
//dw_1.Object.prezzo.font.face	= 'arial'
//dw_1.Object.prezzo.x = 1200
//dw_1.Object.prezzo.y = 2000
//
//dw_1.Object.pp_t.font.face	= 'arial'
//dw_1.Object.pp_t.x = 850
//dw_1.Object.pp_t.y = 600
//
//dw_1.Object.prezzo_p.font.height = 400
//dw_1.Object.prezzo_p.font.Weight = 700
//dw_1.Object.prezzo_p.font.face	= 'arial'
//dw_1.Object.prezzo_p.x = 200
//dw_1.Object.prezzo_p.y = 2000
//
//dw_1.Object.descrizione.font.height = 400
//dw_1.Object.descrizione.font.Weight	= 700
//dw_1.Object.descrizione.font.face	= 'tahoma'
//dw_1.Object.descrizione.width = 5000
//dw_1.Object.descrizione.x = 2000
//dw_1.Object.descrizione.y = 2600
//
//
//dw_1.Object.descrizione_t.x = 9000
//dw_1.Object.prezzo_t.x = 9000
//dw_1.Object.desc_uc.x = 9000
//dw_1.Object.des_valuta.x = 9000
//
//dw_1.Object.cod_barre.x = 700
//dw_1.Object.cod_barre.y = 2800
//dw_1.Object.cod_barre.height = 700
//dw_1.Object.cod_barre.font.height = 1900
//dw_1.Object.cod_barre.Width = 5000
//dw_1.Object.cod_barre.height = 600
//
//dw_1.Object.cod_barre_t.x = 1100
//dw_1.Object.cod_barre_t.y = 3400
//
//this.enabled=false
//cb_4.TriggerEvent(Clicked!)
//
//
//
//
//
end event

type cbx_1 from checkbox within w_orafo_stampa_etichette_rpt
integer x = 2318
integer y = 588
integer width = 265
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Cornice:"
boolean lefttext = true
end type

type em_1 from editmask within w_orafo_stampa_etichette_rpt
integer x = 2331
integer y = 480
integer width = 247
integer height = 88
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
string mask = "###"
end type

type st_4 from statictext within w_orafo_stampa_etichette_rpt
integer x = 2336
integer y = 412
integer width = 329
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Numero Copie:"
boolean focusrectangle = false
end type

type cb_formato from commandbutton within w_orafo_stampa_etichette_rpt
integer x = 2309
integer y = 148
integer width = 315
integer height = 108
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Formato"
end type

event clicked;string ls_cod_azienda

OpenWithParm(w_orafo_formato_stampa_etichette, configurazione_attuale, parent)

dw_1.SetRedraw(False)
	imposta_label_data_window(dw_1)
	riempi()
	ls_cod_azienda=sle_cod_azienda.text
	if ls_cod_azienda>"" then
			dw_1.object.t_cod_azienda.text=ls_cod_azienda
	end if
	dw_1.SetRedraw(TRUE)
end event

type cb_avanti from commandbutton within w_orafo_stampa_etichette_rpt
integer x = 2725
integer y = 1444
integer width = 165
integer height = 76
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = ">"
end type

event clicked;dw_1.ScrollNextPage()
st_pagina.text =  dw_1.getItemString(dw_1.GetRow(),"page") 
end event

type cb_indietro from commandbutton within w_orafo_stampa_etichette_rpt
integer x = 2331
integer y = 1444
integer width = 165
integer height = 76
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "<"
end type

event clicked;dw_1.ScrollPriorPage()
st_pagina.text =  dw_1.getItemString(dw_1.GetRow(),"page") 
end event

type st_pagina from statictext within w_orafo_stampa_etichette_rpt
integer x = 2441
integer y = 1548
integer width = 379
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = " "
alignment alignment = center!
boolean focusrectangle = false
end type

type st_3 from statictext within w_orafo_stampa_etichette_rpt
integer x = 2491
integer y = 1424
integer width = 224
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Pagina"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_orafo_stampa_etichette_rpt
integer x = 2318
integer y = 340
integer width = 247
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = " "
boolean focusrectangle = false
end type

type st_1 from statictext within w_orafo_stampa_etichette_rpt
integer x = 2327
integer y = 272
integer width = 549
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Configurazione in uso:"
boolean focusrectangle = false
end type

type cb_stampa from commandbutton within w_orafo_stampa_etichette_rpt
integer x = 2647
integer y = 28
integer width = 261
integer height = 228
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stampa"
end type

event clicked;string ls_cod_azienda
integer i



printsetup()

dw_1.Object.DataWindow.Print.copies = em_1.text
dw_1.Print()
end event

type dw_1 from datawindow within w_orafo_stampa_etichette_rpt
integer x = 18
integer y = 16
integer width = 2245
integer height = 1556
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_orafo_label_articolo"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event retrievestart;return 2
end event

type cb_impostazioni from commandbutton within w_orafo_stampa_etichette_rpt
integer x = 2309
integer y = 28
integer width = 315
integer height = 108
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Impostazioni"
end type

event clicked;
OpenWithParm(w_orafo_parametri_stampa_etichette, configurazione_attuale)
string sl_msg, ls_cod_azienda
sl_msg = message.StringParm
IF (sl_msg <> "") THEN
	
	
	configurazione_attuale=message.StringParm
	st_2.text=configurazione_attuale
	dw_1.SetRedraw(False)
	imposta_label_data_window(dw_1)
	riempi()
	ls_cod_azienda=sle_cod_azienda.text
	if ls_cod_azienda>"" then
			dw_1.object.t_cod_azienda.text=ls_cod_azienda
	end if
	dw_1.SetRedraw(TRUE)
	
end if
dw_1.Object.DataWindow.Print.Preview.Rulers = "YES"

end event

