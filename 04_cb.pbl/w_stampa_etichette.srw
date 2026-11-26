forward
global type w_stampa_etichette from Window
end type
type st_6 from statictext within w_stampa_etichette
end type
type st_5 from statictext within w_stampa_etichette
end type
type sle_2 from singlelineedit within w_stampa_etichette
end type
type sle_1 from singlelineedit within w_stampa_etichette
end type
type cb_4 from commandbutton within w_stampa_etichette
end type
type cb_3 from commandbutton within w_stampa_etichette
end type
type cbx_1 from checkbox within w_stampa_etichette
end type
type em_1 from editmask within w_stampa_etichette
end type
type st_4 from statictext within w_stampa_etichette
end type
type cb_1 from commandbutton within w_stampa_etichette
end type
type cb_avanti from commandbutton within w_stampa_etichette
end type
type cb_indietro from commandbutton within w_stampa_etichette
end type
type st_pagina from statictext within w_stampa_etichette
end type
type st_3 from statictext within w_stampa_etichette
end type
type st_2 from statictext within w_stampa_etichette
end type
type st_1 from statictext within w_stampa_etichette
end type
type cb_stampa from commandbutton within w_stampa_etichette
end type
type dw_1 from datawindow within w_stampa_etichette
end type
type cb_2 from commandbutton within w_stampa_etichette
end type
end forward

global type w_stampa_etichette from Window
int X=1056
int Y=484
int Width=2958
int Height=2072
boolean TitleBar=true
string Title="Stampa etichette codici a barre"
long BackColor=80133307
boolean ControlMenu=true
WindowType WindowType=response!
st_6 st_6
st_5 st_5
sle_2 sle_2
sle_1 sle_1
cb_4 cb_4
cb_3 cb_3
cbx_1 cbx_1
em_1 em_1
st_4 st_4
cb_1 cb_1
cb_avanti cb_avanti
cb_indietro cb_indietro
st_pagina st_pagina
st_3 st_3
st_2 st_2
st_1 st_1
cb_stampa cb_stampa
dw_1 dw_1
cb_2 cb_2
end type
global w_stampa_etichette w_stampa_etichette

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
public subroutine riempi_da_stampa_sc ()
end prototypes

public subroutine imposta_label_data_window (ref datawindow dw_label);

integer num_col, altezza, larghezza, dist_colonne, dist_righe, marg_sup, marg_sx


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

string ls_ret
ls_ret=dw_label.modify('DataWindow.Label.Columns	 				= '+string(num_col))

ls_ret=ls_ret+dw_label.modify('DataWindow.Label.Rows						= 1')
ls_ret=ls_ret+dw_label.modify('DataWindow.Label.Columns.Spacing		= '+string(dist_colonne * 100))

ls_ret=ls_ret+dw_label.modify('DataWindow.Label.Rows.Spacing			= '+string(dist_righe * 100))
ls_ret=ls_ret+dw_label.modify('DataWindow.Label.Height					= '+string(altezza * 100))
ls_ret=ls_ret+dw_label.modify('DataWindow.Label.Width					= '+string(larghezza * 100))
if ls_ret<>"" then messagebox("error",ls_ret)



dw_label.Object.DataWindow.Print.Margin.Top = (marg_sup * 100)
dw_label.Object.DataWindow.Print.Margin.Left = (marg_sx * 100)

if cbx_1.checked = true then
	dw_label.modify('cornice.X	= '+ "200")	
	dw_label.modify('cornice.y	= '+ "200")		
	dw_label.modify('cornice.width	= '+ string(((larghezza*100)-400)))
	dw_label.modify('cornice.Height	= '+ string(((altezza*100)-400)))
	dw_label.modify('cornice.pen.style	= '+ "0")		
	dw_label.modify('cornice.pen.width	= '+ "70")	

else 
	dw_label.modify('cornice.Visible	= '+ "0")	
	dw_label.modify('cornice.pen.style	= '+ "5")
end if


if ls_ret<>"" then messagebox("error",ls_ret)


string ls_nome, ls_font, ls_autosize
integer ll_x, ll_y, ll_dim_campo, ll_dim_carattere, ll_alt_campo, ll_rotaz, ll_bold

ll_x = 0
ll_y = 0
ll_dim_campo = 0
ll_dim_carattere = 0
ll_alt_campo = 0
ll_rotaz = 0
ll_bold = 0
ls_font = ""
ls_autosize='N'

ls_nome = "codice"
select x, y, dim_campo, dim_carattere, alt_campo, rotazione, grassetto, font, autosize
into :ll_x, :ll_y, :ll_dim_campo, :ll_dim_carattere, :ll_alt_campo, :ll_rotaz, :ll_bold, :ls_font, :ls_autosize
from formato_stampa_etichette
where nome_formato = :ls_nome
and nome_configurazione = :configurazione_attuale;
if not isnull(ll_x) and ll_x <> 0 then dw_label.modify('codice.x		= '+string(ll_x*100))
if not isnull(ll_y) and ll_y <> 0 then dw_label.modify('codice.y		= '+string(ll_y*100))
if not isnull(ll_dim_carattere) and ll_dim_carattere <> 0 then dw_label.modify('codice.font.height		= '+string(ll_dim_carattere*100))
if not isnull(ll_alt_campo) and ll_alt_campo <> 0 then dw_label.modify('codice.height		= '+string(ll_alt_campo*100))
if not isnull(ll_dim_campo) and ll_dim_campo <> 0 then dw_label.modify('codice.Width		= '+string(ll_dim_campo*100))	
if not isnull(ll_bold) and ll_bold <> 0 then dw_label.modify('codice.font.Weight		= '+string(ll_bold))	
if not isnull(ls_font) and ls_font <> "" then dw_label.modify('codice.font.face		= "'+ ls_font + '"')	
if not isnull(ls_autosize) and ls_autosize <> "" then 
	if ls_autosize = 'S' then
		dw_label.modify('codice.Height.AutoSize		= Yes')	
	else
		dw_label.modify('codice.Height.AutoSize		= No')			
	end if
		
end if
if not isnull(ll_rotaz) and ll_rotaz <> 0 then dw_label.modify('codice.font.escapement		= '+string(ll_rotaz*10))	
	
ll_x = 0
ll_y = 0
ll_dim_campo = 0
ll_dim_carattere = 0
ll_alt_campo = 0
ll_rotaz = 0
ll_bold = 0
ls_font = ""
ls_autosize='N'

ls_nome = "descrizione"
select x, y, dim_campo, dim_carattere, alt_campo, rotazione, grassetto, font, autosize
into :ll_x, :ll_y, :ll_dim_campo, :ll_dim_carattere, :ll_alt_campo, :ll_rotaz, :ll_bold, :ls_font, :ls_autosize
from formato_stampa_etichette
where nome_formato = :ls_nome
and nome_configurazione = :configurazione_attuale;
if not isnull(ll_x) and ll_x <> 0 then dw_label.modify('descrizione.x		= '+string(ll_x*100))
if not isnull(ll_y) and ll_y <> 0 then dw_label.modify('descrizione.y		= '+string(ll_y*100))
if not isnull(ll_dim_carattere) and ll_dim_carattere <> 0 then dw_label.modify('descrizione.font.height		= '+string(ll_dim_carattere*100))
if not isnull(ll_alt_campo) and ll_alt_campo <> 0 then dw_label.modify('descrizione.height		= '+string(ll_alt_campo*100))
if not isnull(ll_dim_campo) and ll_dim_campo <> 0 then dw_label.modify('descrizione.Width		= '+string(ll_dim_campo*100))	
if not isnull(ll_bold) and ll_bold <> 0 then dw_label.modify('descrizione.font.Weight		= '+string(ll_bold))	
if not isnull(ls_font) and ls_font <> "" then dw_label.modify('descrizione.font.face		= "'+ ls_font + '"')	
if not isnull(ls_autosize) and ls_autosize <> "" then 
	if ls_autosize = 'S' then
		dw_label.modify('descrizione.Height.AutoSize		= Yes')	
	else
		dw_label.modify('descrizione.Height.AutoSize		= No')			
	end if
		
end if
if not isnull(ll_rotaz) and ll_rotaz <> 0 then dw_label.modify('descrizione.font.escapement		= '+string(ll_rotaz*10))

ll_x = 0
ll_y = 0
ll_dim_campo = 0
ll_dim_carattere = 0
ll_alt_campo = 0
ll_rotaz = 0
ll_bold = 0
ls_font = ""
ls_autosize='N'

ls_nome = "des_valuta"
select x, y, dim_campo, dim_carattere, alt_campo, rotazione, grassetto, font, autosize
into :ll_x, :ll_y, :ll_dim_campo, :ll_dim_carattere, :ll_alt_campo, :ll_rotaz, :ll_bold, :ls_font, :ls_autosize
from formato_stampa_etichette
where nome_formato = :ls_nome
and nome_configurazione = :configurazione_attuale;
if not isnull(ll_x) and ll_x <> 0 then dw_label.modify('des_valuta.x		= '+string(ll_x*100))
if not isnull(ll_y) and ll_y <> 0 then dw_label.modify('des_valuta.y		= '+string(ll_y*100))
if not isnull(ll_dim_carattere) and ll_dim_carattere <> 0 then dw_label.modify('des_valuta.font.height		= '+string(ll_dim_carattere*100))
if not isnull(ll_alt_campo) and ll_alt_campo <> 0 then dw_label.modify('des_valuta.height		= '+string(ll_alt_campo*100))
if not isnull(ll_dim_campo) and ll_dim_campo <> 0 then dw_label.modify('des_valuta.Width		= '+string(ll_dim_campo*100))	
if not isnull(ll_bold) and ll_bold <> 0 then dw_label.modify('des_valuta.font.Weight		= '+string(ll_bold))	
if not isnull(ls_font) and ls_font <> "" then dw_label.modify('des_valuta.font.face		= "'+ ls_font + '"')	
if not isnull(ls_autosize) and ls_autosize <> "" then 
	if ls_autosize = 'S' then
		dw_label.modify('des_valuta.Height.AutoSize		= Yes')	
	else
		dw_label.modify('des_valuta.Height.AutoSize		= No')			
	end if		
end if
if not isnull(ll_rotaz) and ll_rotaz <> 0 then dw_label.modify('des_valuta.font.escapement		= '+string(ll_rotaz*10))

ll_x = 0
ll_y = 0
ll_dim_campo = 0
ll_dim_carattere = 0
ll_alt_campo = 0
ll_rotaz = 0
ll_bold = 0
ls_font = ""
ls_autosize='N'

ls_nome = "prezzo"
select x, y, dim_campo, dim_carattere, alt_campo, rotazione, grassetto, font, autosize
into :ll_x, :ll_y, :ll_dim_campo, :ll_dim_carattere, :ll_alt_campo, :ll_rotaz, :ll_bold, :ls_font, :ls_autosize
from formato_stampa_etichette
where nome_formato = :ls_nome
and nome_configurazione = :configurazione_attuale;
if not isnull(ll_x) and ll_x <> 0 then dw_label.modify('prezzo.x		= '+string(ll_x*100))
if not isnull(ll_y) and ll_y <> 0 then dw_label.modify('prezzo.y		= '+string(ll_y*100))
if not isnull(ll_dim_carattere) and ll_dim_carattere <> 0 then dw_label.modify('prezzo.font.height		= '+string(ll_dim_carattere*100))
if not isnull(ll_alt_campo) and ll_alt_campo <> 0 then dw_label.modify('prezzo.height		= '+string(ll_alt_campo*100))
if not isnull(ll_dim_campo) and ll_dim_campo <> 0 then dw_label.modify('prezzo.Width		= '+string(ll_dim_campo*100))	
if not isnull(ll_bold) and ll_bold <> 0 then dw_label.modify('prezzo.font.Weight		= '+string(ll_bold))	
if not isnull(ls_font) and ls_font <> "" then dw_label.modify('prezzo.font.face		= "'+ ls_font + '"')	
if not isnull(ls_autosize) and ls_autosize <> "" then 
	if ls_autosize = 'S' then
		dw_label.modify('prezzo.Height.AutoSize		= Yes')	
	else
		dw_label.modify('prezzo.Height.AutoSize		= No')			
	end if		
end if
if not isnull(ll_rotaz) and ll_rotaz <> 0 then dw_label.modify('prezzo.font.escapement		= '+string(ll_rotaz*10))


ll_x = 0
ll_y = 0
ll_dim_campo = 0
ll_dim_carattere = 0
ll_alt_campo = 0
ll_rotaz = 0
ll_bold = 0
ls_font = ""
ls_autosize='N'

ls_nome = "cod_barre"
select x, y, dim_campo, dim_carattere, alt_campo, rotazione, grassetto, font, autosize
into :ll_x, :ll_y, :ll_dim_campo, :ll_dim_carattere, :ll_alt_campo, :ll_rotaz, :ll_bold, :ls_font, :ls_autosize
from formato_stampa_etichette
where nome_formato = :ls_nome
and nome_configurazione = :configurazione_attuale;
if not isnull(ll_x) and ll_x <> 0 then dw_label.modify('cod_barre.x		= '+string(ll_x*100))
if not isnull(ll_y) and ll_y <> 0 then dw_label.modify('cod_barre.y		= '+string(ll_y*100))
if not isnull(ll_dim_carattere) and ll_dim_carattere <> 0 then dw_label.modify('cod_barre.font.height		= '+string(ll_dim_carattere*100))
if not isnull(ll_alt_campo) and ll_alt_campo <> 0 then dw_label.modify('cod_barre.height		= '+string(ll_alt_campo*100))
if not isnull(ll_dim_campo) and ll_dim_campo <> 0 then dw_label.modify('cod_barre.Width		= '+string(ll_dim_campo*100))	
if not isnull(ll_bold) and ll_bold <> 0 then dw_label.modify('cod_barre.font.Weight		= '+string(ll_bold))	
if not isnull(ls_autosize) and ls_autosize <> "" then 
	if ls_autosize = 'S' then
		dw_label.modify('cod_barre.Height.AutoSize		= Yes')	
	else
		dw_label.modify('cod_barre.Height.AutoSize		= No')			
	end if		
end if
if not isnull(ll_rotaz) and ll_rotaz <> 0 then dw_label.modify('cod_barre.font.escapement		= '+string(ll_rotaz*10))

ll_x = 0
ll_y = 0
ll_dim_campo = 0
ll_dim_carattere = 0
ll_alt_campo = 0
ll_rotaz = 0
ll_bold = 0
ls_font = ""
ls_autosize='N'

ls_nome = "codice_t"
select x, y, dim_campo, dim_carattere, alt_campo, rotazione, grassetto, font, autosize
into :ll_x, :ll_y, :ll_dim_campo, :ll_dim_carattere, :ll_alt_campo, :ll_rotaz, :ll_bold, :ls_font, :ls_autosize
from formato_stampa_etichette
where nome_formato = :ls_nome
and nome_configurazione = :configurazione_attuale;
if not isnull(ll_x) and ll_x <> 0 then dw_label.modify('codice_t.x		= '+string(ll_x*100))
if not isnull(ll_y) and ll_y <> 0 then dw_label.modify('codice_t.y		= '+string(ll_y*100))
if not isnull(ll_dim_carattere) and ll_dim_carattere <> 0 then dw_label.modify('codice_t.font.height		= '+string(ll_dim_carattere*100))
if not isnull(ll_alt_campo) and ll_alt_campo <> 0 then dw_label.modify('codice_t.height		= '+string(ll_alt_campo*100))
if not isnull(ll_dim_campo) and ll_dim_campo <> 0 then dw_label.modify('codice_t.Width		= '+string(ll_dim_campo*100))	
if not isnull(ll_bold) and ll_bold <> 0 then dw_label.modify('codice_t.font.Weight		= '+string(ll_bold))	
if not isnull(ls_font) and ls_font <> "" then dw_label.modify('codice_t.font.face		= "'+ ls_font + '"')	
if not isnull(ls_autosize) and ls_autosize <> "" then 
	if ls_autosize = 'S' then
		dw_label.modify('codice_t.Height.AutoSize		= Yes')	
	else
		dw_label.modify('codice_t.Height.AutoSize		= No')			
	end if		
end if
if not isnull(ll_rotaz) and ll_rotaz <> 0 then dw_label.modify('codice_t.font.escapement		= '+string(ll_rotaz*10))

ll_x = 0
ll_y = 0
ll_dim_campo = 0
ll_dim_carattere = 0
ll_alt_campo = 0
ll_rotaz = 0
ll_bold = 0
ls_font = ""
ls_autosize='N'

ls_nome = "descrizione_t"
select x, y, dim_campo, dim_carattere, alt_campo, rotazione, grassetto, font, autosize
into :ll_x, :ll_y, :ll_dim_campo, :ll_dim_carattere, :ll_alt_campo, :ll_rotaz, :ll_bold, :ls_font, :ls_autosize
from formato_stampa_etichette
where nome_formato = :ls_nome
and nome_configurazione = :configurazione_attuale;

if not isnull(ll_x) and ll_x <> 0 then dw_label.modify('descrizione_t.x		= '+string(ll_x*100))
if not isnull(ll_y) and ll_y <> 0 then dw_label.modify('descrizione_t.y		= '+string(ll_y*100))
if not isnull(ll_dim_carattere) and ll_dim_carattere <> 0 then dw_label.modify('descrizione_t.font.height		= '+string(ll_dim_carattere*100))
if not isnull(ll_alt_campo) and ll_alt_campo <> 0 then dw_label.modify('descrizione_t.height		= '+string(ll_alt_campo*100))
if not isnull(ll_dim_campo) and ll_dim_campo <> 0 then dw_label.modify('descrizione_t.Width		= '+string(ll_dim_campo*100))	
if not isnull(ll_bold) and ll_bold <> 0 then dw_label.modify('descrizione_t.font.Weight		= '+string(ll_bold))	
if not isnull(ls_font) and ls_font <> "" then dw_label.modify('descrizione_t.font.face		= "'+ ls_font + '"')	
if not isnull(ls_autosize) and ls_autosize <> "" then 
	if ls_autosize = 'S' then
		dw_label.modify('descrizione_t.Height.AutoSize		= Yes')	
	else
		dw_label.modify('descrizione_t.Height.AutoSize		= No')			
	end if		
end if
if not isnull(ll_rotaz) and ll_rotaz <> 0 then dw_label.modify('descrizione_t.font.escapement		= '+string(ll_rotaz*10))

ll_x = 0
ll_y = 0
ll_dim_campo = 0
ll_dim_carattere = 0
ll_alt_campo = 0
ll_rotaz = 0
ll_bold = 0
ls_font = ""
ls_autosize='N'

ls_nome = "prezzo_t"
select x, y, dim_campo, dim_carattere, alt_campo, rotazione, grassetto, font, autosize
into :ll_x, :ll_y, :ll_dim_campo, :ll_dim_carattere, :ll_alt_campo, :ll_rotaz, :ll_bold, :ls_font, :ls_autosize
from formato_stampa_etichette
where nome_formato = :ls_nome
and nome_configurazione = :configurazione_attuale;
if not isnull(ll_x) and ll_x <> 0 then dw_label.modify('prezzo_t.x		= '+string(ll_x*100))
if not isnull(ll_y) and ll_y <> 0 then dw_label.modify('prezzo_t.y		= '+string(ll_y*100))
if not isnull(ll_dim_carattere) and ll_dim_carattere <> 0 then dw_label.modify('prezzo_t.font.height		= '+string(ll_dim_carattere*100))
if not isnull(ll_alt_campo) and ll_alt_campo <> 0 then dw_label.modify('prezzo_t.height		= '+string(ll_alt_campo*100))
if not isnull(ll_dim_campo) and ll_dim_campo <> 0 then dw_label.modify('prezzo_t.Width		= '+string(ll_dim_campo*100))	
if not isnull(ll_bold) and ll_bold <> 0 then dw_label.modify('prezzo_t.font.Weight		= '+string(ll_bold))	
if not isnull(ls_font) and ls_font <> "" then dw_label.modify('prezzo_t.font.face		= "'+ ls_font + '"')	
if not isnull(ls_autosize) and ls_autosize <> "" then 
	if ls_autosize = 'S' then
		dw_label.modify('prezzo_t.Height.AutoSize		= Yes')	
	else
		dw_label.modify('prezzo_t.Height.AutoSize		= No')			
	end if		
end if
if not isnull(ll_rotaz) and ll_rotaz <> 0 then dw_label.modify('prezzo_t.font.escapement		= '+string(ll_rotaz*10))

ll_x = 0
ll_y = 0
ll_dim_campo = 0
ll_dim_carattere = 0
ll_alt_campo = 0
ll_rotaz = 0
ll_bold = 0
ls_font = ""
ls_autosize='N'

ls_nome = "cod_barre_t"
select x, y, dim_campo, dim_carattere, alt_campo, rotazione, grassetto, font, autosize
into :ll_x, :ll_y, :ll_dim_campo, :ll_dim_carattere, :ll_alt_campo, :ll_rotaz, :ll_bold, :ls_font, :ls_autosize
from formato_stampa_etichette
where nome_formato = :ls_nome
and nome_configurazione = :configurazione_attuale;
if not isnull(ll_x) and ll_x <> 0 then dw_label.modify('cod_barre_t.x		= '+string(ll_x*100))
if not isnull(ll_y) and ll_y <> 0 then dw_label.modify('cod_barre_t.y		= '+string(ll_y*100))
if not isnull(ll_dim_carattere) and ll_dim_carattere <> 0 then dw_label.modify('cod_barre_t.font.height		= '+string(ll_dim_carattere*100))
if not isnull(ll_alt_campo) and ll_alt_campo <> 0 then dw_label.modify('cod_barre_t.height		= '+string(ll_alt_campo*100))
if not isnull(ll_dim_campo) and ll_dim_campo <> 0 then dw_label.modify('cod_barre_t.Width		= '+string(ll_dim_campo*100))	
if not isnull(ll_bold) and ll_bold <> 0 then dw_label.modify('cod_barre_t.font.Weight		= '+string(ll_bold))	
if not isnull(ls_font) and ls_font <> "" then dw_label.modify('cod_barre_t.font.face		= "'+ ls_font + '"')	
if not isnull(ls_autosize) and ls_autosize <> "" then 
	if ls_autosize = 'S' then
		dw_label.modify('cod_barre_t.Height.AutoSize		= Yes')	
	else
		dw_label.modify('cod_barre_t.Height.AutoSize		= No')			
	end if		
end if
if not isnull(ll_rotaz) and ll_rotaz <> 0 then dw_label.modify('cod_barre_t.font.escapement		= '+string(ll_rotaz*10))

ll_x = 0
ll_y = 0
ll_dim_campo = 0
ll_dim_carattere = 0
ll_alt_campo = 0
ll_rotaz = 0
ll_bold = 0
ls_font = ""
ls_autosize='N'

ls_nome = "pp_t"
select x, y, dim_campo, dim_carattere, alt_campo, rotazione, grassetto, font, autosize
into :ll_x, :ll_y, :ll_dim_campo, :ll_dim_carattere, :ll_alt_campo, :ll_rotaz, :ll_bold, :ls_font, :ls_autosize
from formato_stampa_etichette
where nome_formato = :ls_nome
and nome_configurazione = :configurazione_attuale;
if not isnull(ll_x) and ll_x <> 0 then dw_label.modify('pp_t.x		= '+string(ll_x*100))
if not isnull(ll_y) and ll_y <> 0 then dw_label.modify('pp_t.y		= '+string(ll_y*100))
if not isnull(ll_dim_carattere) and ll_dim_carattere <> 0 then dw_label.modify('pp_t.font.height		= '+string(ll_dim_carattere*100))
if not isnull(ll_alt_campo) and ll_alt_campo <> 0 then dw_label.modify('pp_t.height		= '+string(ll_alt_campo*100))
if not isnull(ll_dim_campo) and ll_dim_campo <> 0 then dw_label.modify('pp_t.Width		= '+string(ll_dim_campo*100))	
if not isnull(ll_bold) and ll_bold <> 0 then dw_label.modify('pp_t.font.Weight		= '+string(ll_bold))	
if not isnull(ls_font) and ls_font <> "" then dw_label.modify('pp_t.font.face		= "'+ ls_font + '"')	
if not isnull(ls_autosize) and ls_autosize <> "" then 
	if ls_autosize = 'S' then
		dw_label.modify('pp_t.Height.AutoSize		= Yes')	
	else
		dw_label.modify('pp_t.Height.AutoSize		= No')			
	end if		
end if
if not isnull(ll_rotaz) and ll_rotaz <> 0 then dw_label.modify('pp_t.font.escapement		= '+string(ll_rotaz*10))

ll_x = 0
ll_y = 0
ll_dim_campo = 0
ll_dim_carattere = 0
ll_alt_campo = 0
ll_rotaz = 0
ll_bold = 0
ls_font = ""
ls_autosize='N'

ls_nome = "pc_t"
select x, y, dim_campo, dim_carattere, alt_campo, rotazione, grassetto, font, autosize
into :ll_x, :ll_y, :ll_dim_campo, :ll_dim_carattere, :ll_alt_campo, :ll_rotaz, :ll_bold, :ls_font, :ls_autosize
from formato_stampa_etichette
where nome_formato = :ls_nome
and nome_configurazione = :configurazione_attuale;
if not isnull(ll_x) and ll_x <> 0 then dw_label.modify('pc_t.x		= '+string(ll_x*100))
if not isnull(ll_y) and ll_y <> 0 then dw_label.modify('pc_t.y		= '+string(ll_y*100))
if not isnull(ll_dim_carattere) and ll_dim_carattere <> 0 then dw_label.modify('pc_t.font.height		= '+string(ll_dim_carattere*100))
if not isnull(ll_alt_campo) and ll_alt_campo <> 0 then dw_label.modify('pc_t.height		= '+string(ll_alt_campo*100))
if not isnull(ll_dim_campo) and ll_dim_campo <> 0 then dw_label.modify('pc_t.Width		= '+string(ll_dim_campo*100))	
if not isnull(ll_bold) and ll_bold <> 0 then dw_label.modify('pc_t.font.Weight		= '+string(ll_bold))	
if not isnull(ls_font) and ls_font <> "" then dw_label.modify('pc_t.font.face		= "'+ ls_font + '"')	
if not isnull(ls_autosize) and ls_autosize <> "" then 
	if ls_autosize = 'S' then
		dw_label.modify('pc_t.Height.AutoSize		= Yes')	
	else
		dw_label.modify('pc_t.Height.AutoSize		= No')			
	end if		
end if
if not isnull(ll_rotaz) and ll_rotaz <> 0 then dw_label.modify('pc_t.font.escapement		= '+string(ll_rotaz*10))

ll_x = 0
ll_y = 0
ll_dim_campo = 0
ll_dim_carattere = 0
ll_alt_campo = 0
ll_rotaz = 0
ll_bold = 0
ls_font = ""
ls_autosize='N'

ls_nome = "prezzo_p"
select x, y, dim_campo, dim_carattere, alt_campo, rotazione, grassetto, font, autosize
into :ll_x, :ll_y, :ll_dim_campo, :ll_dim_carattere, :ll_alt_campo, :ll_rotaz, :ll_bold, :ls_font, :ls_autosize
from formato_stampa_etichette
where nome_formato = :ls_nome
and nome_configurazione = :configurazione_attuale;
if not isnull(ll_x) and ll_x <> 0 then dw_label.modify('prezzo_p.x		= '+string(ll_x*100))
if not isnull(ll_y) and ll_y <> 0 then dw_label.modify('prezzo_p.y		= '+string(ll_y*100))
if not isnull(ll_dim_carattere) and ll_dim_carattere <> 0 then dw_label.modify('prezzo_p.font.height		= '+string(ll_dim_carattere*100))
if not isnull(ll_alt_campo) and ll_alt_campo <> 0 then dw_label.modify('prezzo_p.height		= '+string(ll_alt_campo*100))
if not isnull(ll_dim_campo) and ll_dim_campo <> 0 then dw_label.modify('prezzo_p.Width		= '+string(ll_dim_campo*100))	
if not isnull(ll_bold) and ll_bold <> 0 then dw_label.modify('prezzo_p.font.Weight		= '+string(ll_bold))	
if not isnull(ls_font) and ls_font <> "" then dw_label.modify('prezzo_p.font.face		= "'+ ls_font + '"')	
if not isnull(ls_autosize) and ls_autosize <> "" then 
	if ls_autosize = 'S' then
		dw_label.modify('prezzo_p.Height.AutoSize		= Yes')	
	else
		dw_label.modify('prezzo_p.Height.AutoSize		= No')			
	end if		
end if
if not isnull(ll_rotaz) and ll_rotaz <> 0 then dw_label.modify('prezzo_p.font.escapement		= '+string(ll_rotaz*10))

ll_x = 0
ll_y = 0
ll_dim_campo = 0
ll_dim_carattere = 0
ll_alt_campo = 0
ll_rotaz = 0
ll_bold = 0
ls_font = ""
ls_autosize='N'

ls_nome = "desc_uc"
select x, y, dim_campo, dim_carattere, alt_campo, rotazione, grassetto, font, autosize
into :ll_x, :ll_y, :ll_dim_campo, :ll_dim_carattere, :ll_alt_campo, :ll_rotaz, :ll_bold, :ls_font, :ls_autosize
from formato_stampa_etichette
where nome_formato = :ls_nome
and nome_configurazione = :configurazione_attuale;
if not isnull(ll_x) and ll_x <> 0 then dw_label.modify('desc_uc.x		= '+string(ll_x*100))
if not isnull(ll_y) and ll_y <> 0 then dw_label.modify('desc_uc.y		= '+string(ll_y*100))
if not isnull(ll_dim_carattere) and ll_dim_carattere <> 0 then dw_label.modify('desc_uc.font.height		= '+string(ll_dim_carattere*100))
if not isnull(ll_alt_campo) and ll_alt_campo <> 0 then dw_label.modify('desc_uc.height		= '+string(ll_alt_campo*100))
if not isnull(ll_dim_campo) and ll_dim_campo <> 0 then dw_label.modify('desc_uc.Width		= '+string(ll_dim_campo*100))	
if not isnull(ll_bold) and ll_bold <> 0 then dw_label.modify('desc_uc.font.Weight		= '+string(ll_bold))	
if not isnull(ls_font) and ls_font <> "" then dw_label.modify('desc_uc.font.face		= "'+ ls_font + '"')	
if not isnull(ls_autosize) and ls_autosize <> "" then 
	if ls_autosize = 'S' then
		dw_label.modify('desc_uc.Height.AutoSize		= Yes')	
	else
		dw_label.modify('desc_uc.Height.AutoSize		= No')			
	end if		
end if
if not isnull(ll_rotaz) and ll_rotaz <> 0 then dw_label.modify('desc_uc.font.escapement		= '+string(ll_rotaz*10))

ll_x = 0
ll_y = 0
ll_dim_campo = 0
ll_dim_carattere = 0
ll_alt_campo = 0
ll_rotaz = 0
ll_bold = 0
ls_font = ""
ls_autosize='N'

ls_nome = "libero"
select x, y, dim_campo, dim_carattere, alt_campo, rotazione, grassetto, font, autosize
into :ll_x, :ll_y, :ll_dim_campo, :ll_dim_carattere, :ll_alt_campo, :ll_rotaz, :ll_bold, :ls_font, :ls_autosize
from formato_stampa_etichette
where nome_formato = :ls_nome
and nome_configurazione = :configurazione_attuale;
if not isnull(ll_x) and ll_x <> 0 then dw_label.modify('libero.x		= '+string(ll_x*100))
if not isnull(ll_y) and ll_y <> 0 then dw_label.modify('libero.y		= '+string(ll_y*100))
if not isnull(ll_dim_carattere) and ll_dim_carattere <> 0 then dw_label.modify('libero.font.height		= '+string(ll_dim_carattere*100))
if not isnull(ll_alt_campo) and ll_alt_campo <> 0 then dw_label.modify('libero.height		= '+string(ll_alt_campo*100))
if not isnull(ll_dim_campo) and ll_dim_campo <> 0 then dw_label.modify('libero.Width		= '+string(ll_dim_campo*100))	
if not isnull(ll_bold) and ll_bold <> 0 then dw_label.modify('libero.font.Weight		= '+string(ll_bold))	
if not isnull(ls_font) and ls_font <> "" then dw_label.modify('libero.font.face		= "'+ ls_font + '"')	
if not isnull(ls_autosize) and ls_autosize <> "" then 
	if ls_autosize = 'S' then
		dw_label.modify('libero.Height.AutoSize		= Yes')	
	else
		dw_label.modify('libero.Height.AutoSize		= No')			
	end if		
end if
if not isnull(ll_rotaz) and ll_rotaz <> 0 then dw_label.modify('libero.font.escapement		= '+string(ll_rotaz*10))

ll_x = 0
ll_y = 0
ll_dim_campo = 0
ll_dim_carattere = 0
ll_alt_campo = 0
ll_rotaz = 0
ll_bold = 0
ls_font = ""
ls_autosize='N'

ls_nome = "libero2"
select x, y, dim_campo, dim_carattere, alt_campo, rotazione, grassetto, font, autosize
into :ll_x, :ll_y, :ll_dim_campo, :ll_dim_carattere, :ll_alt_campo, :ll_rotaz, :ll_bold, :ls_font, :ls_autosize
from formato_stampa_etichette
where nome_formato = :ls_nome
and nome_configurazione = :configurazione_attuale;
if not isnull(ll_x) and ll_x <> 0 then dw_label.modify('libero2.x		= '+string(ll_x*100))
if not isnull(ll_y) and ll_y <> 0 then dw_label.modify('libero2.y		= '+string(ll_y*100))
if not isnull(ll_dim_carattere) and ll_dim_carattere <> 0 then dw_label.modify('libero2.font.height		= '+string(ll_dim_carattere*100))
if not isnull(ll_alt_campo) and ll_alt_campo <> 0 then dw_label.modify('libero2.height		= '+string(ll_alt_campo*100))
if not isnull(ll_dim_campo) and ll_dim_campo <> 0 then dw_label.modify('libero2.Width		= '+string(ll_dim_campo*100))	
if not isnull(ll_bold) and ll_bold <> 0 then dw_label.modify('libero2.font.Weight		= '+string(ll_bold))	
if not isnull(ls_font) and ls_font <> "" then dw_label.modify('libero2.font.face		= "'+ ls_font + '"')	
if not isnull(ls_autosize) and ls_autosize <> "" then 
	if ls_autosize = 'S' then
		dw_label.modify('libero2.Height.AutoSize		= Yes')	
	else
		dw_label.modify('libero2.Height.AutoSize		= No')			
	end if		
end if
if not isnull(ll_rotaz) and ll_rotaz <> 0 then dw_label.modify('libero2.font.escapement		= '+string(ll_rotaz*10))

ll_x = 0
ll_y = 0
ll_dim_campo = 0
ll_dim_carattere = 0
ll_alt_campo = 0
ll_rotaz = 0
ll_bold = 0
ls_font = ""
ls_autosize='N'

ls_nome = "simbolo"
select x, y, dim_campo, dim_carattere, alt_campo, rotazione, grassetto, font, autosize
into :ll_x, :ll_y, :ll_dim_campo, :ll_dim_carattere, :ll_alt_campo, :ll_rotaz, :ll_bold, :ls_font, :ls_autosize
from formato_stampa_etichette
where nome_formato = :ls_nome
and nome_configurazione = :configurazione_attuale;
if not isnull(ll_x) and ll_x <> 0 then dw_label.modify('simbolo.x		= '+string(ll_x*100))
if not isnull(ll_y) and ll_y <> 0 then dw_label.modify('simbolo.y		= '+string(ll_y*100))
if not isnull(ll_dim_carattere) and ll_dim_carattere <> 0 then dw_label.modify('simbolo.font.height		= '+string(ll_dim_carattere*100))
if not isnull(ll_alt_campo) and ll_alt_campo <> 0 then dw_label.modify('simbolo.height		= '+string(ll_alt_campo*100))
if not isnull(ll_dim_campo) and ll_dim_campo <> 0 then dw_label.modify('simbolo.Width		= '+string(ll_dim_campo*100))	
if not isnull(ll_bold) and ll_bold <> 0 then dw_label.modify('simbolo.font.Weight		= '+string(ll_bold))	
if not isnull(ls_font) and ls_font <> "" then dw_label.modify('simbolo.font.face		= "'+ ls_font + '"')	
if not isnull(ls_autosize) and ls_autosize <> "" then 
	if ls_autosize = 'S' then
		dw_label.modify('simbolo.Height.AutoSize		= Yes')	
	else
		dw_label.modify('simbolo.Height.AutoSize		= No')			
	end if		
end if
if not isnull(ll_rotaz) and ll_rotaz <> 0 then dw_label.modify('simbolo.font.escapement		= '+string(ll_rotaz*10))




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
		
	CASE "dw_sel_sc_lt"
		riempi_da_stampa_sc()		
		
   case "dw_1"
		riempi_da_listar()		
		
   case "dw_2"
		riempi_da_rch()				
		
	CASE ELSE
		messagebox("Alert","Unknown calling dataWindow")
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

public subroutine riempi_da_stampa ();
integer i, li_lun_bar, j
string cod_art, cod_bar, descr, cod_bar_t, ls_uc_base, ls_uc_cod
long unit_conf, ll_id_cod_barre
decimal {4} prezzo, prezzo_p
	
st_2.text = configurazione_attuale
string tmp	
for i = 1 to dw.rowCount()
	
cod_art = dw.getItemString(i,"articolo_codice")	
descr = dw.getItemString(i,"articolo_descrizione")	
unit_conf = dw.getItemNumber(i,"unita_confezione_id_unita_confezione")

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
 
  SELECT "prezzo"."prezzo"
    into :prezzo_p 
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
         ( "listino"."codice" = '3' ) AND  
         ( "variazione"."data_inizio" <= today(*)  ) AND  
         (( "variazione"."data_fine" >= today(*) ) OR  
         ( "variazione"."data_fine" is NULL ) )  
))
;




if isnull(unit_conf) then
  SELECT "unita_confezione"."id_unita_confezione" , "unita_confezione"."unita_base", "unita_confezione"."codice"
    INTO :unit_conf, :ls_uc_base, :ls_uc_cod
    FROM "unita_confezione","articolo"  
   WHERE ( "articolo"."codice" = :cod_art ) AND  
			( "unita_confezione"."id_articolo" = "articolo"."id_articolo" ) AND  
         ( "unita_confezione"."unita_base" = 'S' );   
else
	
	
  SELECT "unita_confezione"."unita_base", "unita_confezione"."codice" 
    INTO :ls_uc_base, :ls_uc_cod
    FROM "unita_confezione"
   WHERE "unita_confezione"."id_unita_confezione" = :unit_conf;   	
end if

if isnull(ls_uc_base) then ls_uc_base = 'N'

cod_bar = dw.getItemString(i,"cod_barre_codice") 
if isnull(cod_bar) or cod_bar = "" then
	select max(id_cod_barre)
	into :ll_id_cod_barre
	from cod_barre
	WHERE "cod_barre"."id_unita_confezione" = :unit_conf;
	
  SELECT "cod_barre"."codice"
    INTO :cod_bar
    FROM "cod_barre"   
 
   WHERE id_cod_barre = :ll_id_cod_barre;
end if	

	INTEGER LL_ROW
	string ls_ean_conf
	
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
	
	dw_1.setItem(ll_row,"descrizione",descr)	
	if prezzo > 0 then dw_1.setItem(ll_row,"prezzo",prezzo)	
	if prezzo_p > 0 then dw_1.setItem(ll_row,"prezzo_p",prezzo_p)		

	if ls_uc_base <> "S" then
		ls_ean_conf = "EAN CONF. " + trim(ls_uc_cod)
		dw_1.setItem(ll_row,"desc_uc",ls_ean_conf)			
		
	else
		dw_1.setItem(ll_row,"desc_uc",ls_uc_cod)
	end if
	
  INTEGER ll_copie	
  ll_copie = integer(em_1.text) 	
  for j = 1 to (ll_copie - 1)
	  ll_row=dw_1.insertRow(0)			
	  dw_1.setItem(ll_row,"codice",cod_art)	
     dw_1.setItem(ll_row,"cod_barre",cod_bar)	
	  dw_1.setItem(ll_row,"cod_barre_t",cod_bar_t)		
	
	  dw_1.setItem(ll_row,"descrizione",descr)	
	  if prezzo > 0 then dw_1.setItem(ll_row,"prezzo",prezzo)	
	  if prezzo_p > 0 then dw_1.setItem(ll_row,"prezzo_p",prezzo_p)		

	  if ls_uc_base <> "S" then
		  ls_ean_conf = "EAN CONF. " + trim(ls_uc_cod)
		  dw_1.setItem(ll_row,"desc_uc",ls_ean_conf)	
	else
		dw_1.setItem(ll_row,"desc_uc",ls_uc_cod)		  
  	  end if	  
  next

next

end subroutine

public subroutine riempi_da_righe ();integer i  
string cod_art, cod_bar, descr,ls_desc_valuta, cod_bar_t, ls_uc_base, ls_uc_cod
long unit_conf, ll_id_documento, ll_id_valuta, ll_lingua, ll_id_sog_commerciale, ll_id_articolo
decimal {4} prezzo, larghezza, profondita, prezzo_p
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
	descr = '' 
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
		
  SELECT "prezzo"."prezzo"
    into :prezzo_p 
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
         ( "listino"."codice" = '3' ) AND  
         ( "variazione"."data_inizio" <= today(*)  ) AND  
         (( "variazione"."data_fine" >= today(*) ) OR  
         ( "variazione"."data_fine" is NULL ) )  
))
;		
		
	
	
if isnull(unit_conf) then
  SELECT "unita_confezione"."id_unita_confezione" , "unita_confezione"."unita_base", "unita_confezione"."codice"
    INTO :unit_conf, :ls_uc_base, :ls_uc_cod
    FROM "unita_confezione","articolo"  
   WHERE ( "articolo"."codice" = :cod_art ) AND  
			( "unita_confezione"."id_articolo" = "articolo"."id_articolo" ) AND  
         ( "unita_confezione"."unita_base" = 'S' );   
else
  SELECT "unita_confezione"."unita_base", "unita_confezione"."codice" 
    INTO :ls_uc_base, :ls_uc_cod
    FROM "unita_confezione"
   WHERE "unita_confezione"."id_unita_confezione" = :unit_conf;   	
end if

if isnull(ls_uc_base) then ls_uc_base = 'N'

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

	  INTEGER ll_copie, j
	  ll_copie = integer(em_1.text) 	
	  for j = 1 to (ll_copie - 1)
		  ll_row=dw_1.insertRow(0)			
		  dw_1.setItem(ll_row,"codice",cod_art)	
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
	  next		


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

		
	  INTEGER ll_copie, j
	  ll_copie = integer(em_1.text) 	
	  for j = 1 to (ll_copie - 1)
		  ll_row=dw_1.insertRow(0)			
		  dw_1.setItem(ll_row,"codice",cod_art)	
		  dw_1.setItem(ll_row,"cod_barre",cod_bar)	
		  dw_1.setItem(ll_row,"cod_barre_t",cod_bar_t)		
		  dw_1.setItem(ll_row,"des_valuta",	ls_desc_valuta)		
		  dw_1.setItem(ll_row,"descrizione",descr)	
		  dw_1.setItem(ll_row,"prezzo",prezzo)	
	
		  dw_1.setItem(ll_row,"larghezza",larghezza)	
		  dw_1.setItem(ll_row,"lunghezza",altezza)	
		  dw_1.setItem(ll_row,"CAT_MERC_DES",lS_id_cat_merc)
	  next				
	  
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
long unit_conf, ll_id_documento, ll_id_valuta, ll_lingua, ll_id_sog_commerciale, ll_id_articolo
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
		
	  INTEGER ll_copie, j
	  ll_copie = integer(em_1.text) 	
	  for j = 1 to (ll_copie - 1)
		  ll_row=dw_1.insertRow(0)			
		  dw_1.setItem(ll_row,"codice",cod_art)	
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
	  next		
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
	
   INTEGER ll_copie, j
   ll_copie = integer(em_1.text) 	
   for j = 1 to (ll_copie - 1)
	   ll_row=dw_1.insertRow(0)			
  	   dw_1.setItem(ll_row,"codice",cod_art)	
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
   next			
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

public subroutine riempi_da_stampa_sc ();
integer i, li_lun_bar, j
string cod_art, cod_bar, descr, cod_bar_t, ls_uc_base, ls_uc_cod
long unit_conf, ll_id_cod_barre
decimal {4} prezzo, prezzo_p
	
st_2.text = configurazione_attuale
string tmp	
for i = 1 to dw.rowCount()
	
cod_art = dw.getItemString(i,"sog_commerciale_gen_codice")	
descr = dw.getItemString(i,"sog_commerciale_gen_rag_soc_1")	
cod_bar = dw.getItemstring(i,"sog_com_barre_cod_barre")

	INTEGER LL_ROW
	string ls_ean_conf
	
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
	
	dw_1.setItem(ll_row,"descrizione",descr)	

	
  INTEGER ll_copie	
  ll_copie = integer(em_1.text) 	
  for j = 1 to (ll_copie - 1)
	  ll_row=dw_1.insertRow(0)			
	  dw_1.setItem(ll_row,"codice",cod_art)	
     dw_1.setItem(ll_row,"cod_barre",cod_bar)	
	  dw_1.setItem(ll_row,"cod_barre_t",cod_bar_t)		
	
	  dw_1.setItem(ll_row,"descrizione",descr)	

  next

next

end subroutine

on w_stampa_etichette.create
this.st_6=create st_6
this.st_5=create st_5
this.sle_2=create sle_2
this.sle_1=create sle_1
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cbx_1=create cbx_1
this.em_1=create em_1
this.st_4=create st_4
this.cb_1=create cb_1
this.cb_avanti=create cb_avanti
this.cb_indietro=create cb_indietro
this.st_pagina=create st_pagina
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.cb_stampa=create cb_stampa
this.dw_1=create dw_1
this.cb_2=create cb_2
this.Control[]={this.st_6,&
this.st_5,&
this.sle_2,&
this.sle_1,&
this.cb_4,&
this.cb_3,&
this.cbx_1,&
this.em_1,&
this.st_4,&
this.cb_1,&
this.cb_avanti,&
this.cb_indietro,&
this.st_pagina,&
this.st_3,&
this.st_2,&
this.st_1,&
this.cb_stampa,&
this.dw_1,&
this.cb_2}
end on

on w_stampa_etichette.destroy
destroy(this.st_6)
destroy(this.st_5)
destroy(this.sle_2)
destroy(this.sle_1)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cbx_1)
destroy(this.em_1)
destroy(this.st_4)
destroy(this.cb_1)
destroy(this.cb_avanti)
destroy(this.cb_indietro)
destroy(this.st_pagina)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_stampa)
destroy(this.dw_1)
destroy(this.cb_2)
end on

event open;integer li_ret
configurazione_attuale = "default"
dw_1.Object.DataWindow.Print.Preview = "YES"
dw_1.Object.DataWindow.Print.Preview.Rulers = "YES"	


dw = message.powerobjectParm
	string ls_cod
	SELECT CODICE
	INTO :LS_COD
	FROM AZIENDA
	WHERE ID_AZIENDA=1;
	
	if pos(ls_cod, "VISCONTI")>0 then
		DW_1.DATAOBJECT="d_label_nome_azienda"
		dw_1.settransobject(sqlca)
		dw_1.object.st_nome_azienda.text=ls_cod
	end if
	dw_1.settransobject(sqlca)
	
em_1.text = "1"
dw_1.SetRedraw(FALSE)
imposta_label_data_window(dw_1)
riempi()
dw_1.SetRedraw(TRUE)
st_pagina.text =  dw_1.getItemString(1,"page") 

end event

type st_6 from statictext within w_stampa_etichette
int X=169
int Y=1808
int Width=352
int Height=52
boolean Enabled=false
string Text="Campo Libero 2"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_5 from statictext within w_stampa_etichette
int X=169
int Y=1644
int Width=352
int Height=60
boolean Enabled=false
string Text="Campo Libero 1"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_2 from singlelineedit within w_stampa_etichette
int X=165
int Y=1864
int Width=2057
int Height=92
int TabOrder=100
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;long i

for i = 1 to dw_1.rowCount()
	dw_1.setitem(i,"libero2",sle_2.text)
next
end event

type sle_1 from singlelineedit within w_stampa_etichette
int X=165
int Y=1708
int Width=2057
int Height=92
int TabOrder=90
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;long i

for i = 1 to dw_1.rowCount()
	dw_1.setitem(i,"libero",sle_1.text)
next
end event

type cb_4 from commandbutton within w_stampa_etichette
int X=2629
int Y=1084
int Width=247
int Height=76
int TabOrder=70
boolean Visible=false
string Text="Ruota"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.Object.codice.Font.Escapement = 2700
dw_1.Object.codice_t.Font.Escapement = 2700
dw_1.Object.pc_t.Font.Escapement = 2700
dw_1.Object.pp_t.Font.Escapement = 2700
dw_1.Object.prezzo.Font.Escapement = 2700
dw_1.Object.prezzo_p.Font.Escapement = 2700
dw_1.Object.descrizione.Font.Escapement = 2700


this.enabled=false
cb_1.enabled=false
cb_2.enabled=false
cb_3.enabled=false
end event

type cb_3 from commandbutton within w_stampa_etichette
int X=2313
int Y=1084
int Width=247
int Height=76
int TabOrder=60
boolean Enabled=false
string Text="Labels6"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
dw_1.Object.codice_t.font.face	= 'arial'
dw_1.Object.codice_t.x = 2800
dw_1.Object.codice_T.y = 600

dw_1.Object.codice.font.height = 400
dw_1.Object.codice.font.Weight	= 700
dw_1.Object.codice.font.face	= 'arial'
dw_1.Object.codice.x = 2200
dw_1.Object.codice.y = 2000

dw_1.Object.pc_t.font.face	= 'arial'
dw_1.Object.pc_t.x = 1850
dw_1.Object.pc_T.y = 600

dw_1.Object.prezzo.font.height = 400
dw_1.Object.prezzo.font.Weight = 700
dw_1.Object.prezzo.font.face	= 'arial'
dw_1.Object.prezzo.x = 1200
dw_1.Object.prezzo.y = 2000

dw_1.Object.pp_t.font.face	= 'arial'
dw_1.Object.pp_t.x = 850
dw_1.Object.pp_t.y = 600

dw_1.Object.prezzo_p.font.height = 400
dw_1.Object.prezzo_p.font.Weight = 700
dw_1.Object.prezzo_p.font.face	= 'arial'
dw_1.Object.prezzo_p.x = 200
dw_1.Object.prezzo_p.y = 2000

dw_1.Object.descrizione.font.height = 400
dw_1.Object.descrizione.font.Weight	= 700
dw_1.Object.descrizione.font.face	= 'tahoma'
dw_1.Object.descrizione.width = 5000
dw_1.Object.descrizione.x = 2000
dw_1.Object.descrizione.y = 2600


dw_1.Object.descrizione_t.x = 9000
dw_1.Object.prezzo_t.x = 9000
dw_1.Object.desc_uc.x = 9000
dw_1.Object.des_valuta.x = 9000

dw_1.Object.cod_barre.x = 700
dw_1.Object.cod_barre.y = 2800
dw_1.Object.cod_barre.height = 700
dw_1.Object.cod_barre.font.height = 1900
dw_1.Object.cod_barre.Width = 5000
dw_1.Object.cod_barre.height = 600

dw_1.Object.cod_barre_t.x = 1100
dw_1.Object.cod_barre_t.y = 3400

this.enabled=false
cb_4.TriggerEvent(Clicked!)





end event

type cbx_1 from checkbox within w_stampa_etichette
int X=2615
int Y=652
int Width=274
int Height=76
string Text="Cornice:"
BorderStyle BorderStyle=StyleLowered!
boolean LeftText=true
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_1 from editmask within w_stampa_etichette
int X=2318
int Y=948
int Width=247
int Height=88
int TabOrder=50
BorderStyle BorderStyle=StyleLowered!
string Mask="###"
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;cb_2.triggerevent(clicked!)
end event

type st_4 from statictext within w_stampa_etichette
int X=2322
int Y=884
int Width=329
int Height=76
boolean Enabled=false
string Text="Numero Copie:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_1 from commandbutton within w_stampa_etichette
int X=2464
int Y=236
int Width=315
int Height=108
int TabOrder=20
string Text="Formato"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;OpenWithParm(w_formato_stampa_etichette, configurazione_attuale)
end event

type cb_avanti from commandbutton within w_stampa_etichette
int X=2725
int Y=1444
int Width=165
int Height=76
int TabOrder=110
string Text=">"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.ScrollNextPage()
st_pagina.text =  dw_1.getItemString(dw_1.GetRow(),"page") 
end event

type cb_indietro from commandbutton within w_stampa_etichette
int X=2331
int Y=1444
int Width=165
int Height=76
int TabOrder=80
string Text="<"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.ScrollPriorPage()
st_pagina.text =  dw_1.getItemString(dw_1.GetRow(),"page") 
end event

type st_pagina from statictext within w_stampa_etichette
int X=2437
int Y=1488
int Width=379
int Height=76
boolean Enabled=false
string Text=" "
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_stampa_etichette
int X=2482
int Y=1424
int Width=274
int Height=60
boolean Enabled=false
string Text="Pagina"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_stampa_etichette
int X=2327
int Y=652
int Width=247
int Height=76
boolean Enabled=false
string Text=" "
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_stampa_etichette
int X=2322
int Y=556
int Width=549
int Height=76
boolean Enabled=false
string Text="Configurazione in uso:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_stampa from commandbutton within w_stampa_etichette
int X=2459
int Y=400
int Width=320
int Height=108
int TabOrder=40
string Text="Stampa"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;printsetup()

dw_1.Print()
end event

type dw_1 from datawindow within w_stampa_etichette
int X=151
int Y=72
int Width=2075
int Height=1556
int TabOrder=30
boolean BringToTop=true
string DataObject="d_label"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
end type

type cb_2 from commandbutton within w_stampa_etichette
int X=2464
int Y=68
int Width=315
int Height=108
int TabOrder=10
boolean BringToTop=true
string Text="Impostazioni"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
OpenWithParm(w_parametri_stampa_etichette, configurazione_attuale)
string sl_msg
sl_msg = message.StringParm
IF (sl_msg <> "") THEN
	
	DW_1.DATAOBJECT="d_label"
	dw_1.settransobject(sqlca)	
	
	configurazione_attuale=message.StringParm
	dw_1.SetRedraw(False)
	imposta_label_data_window(dw_1)
	riempi()
	dw_1.SetRedraw(TRUE)
	st_pagina.text =  dw_1.getItemString(1,"page") 
end if
dw_1.Object.DataWindow.Print.Preview.Rulers = "YES"

if st_2.text =  "labels6" then cb_3.enabled=true
end event

