forward
global type w_mod_prz_cx from w_p_data
end type
type dw_articolo_prezzo_ff from u_dw_master_main within w_mod_prz_cx
end type
type dw_mod_prz_gd from u_dw_master_main within w_mod_prz_cx
end type
end forward

global type w_mod_prz_cx from w_p_data
int Width=3301
int Height=1484
boolean TitleBar=true
string Title="Modifica prezzi validi di un articolo / unità conf."
dw_articolo_prezzo_ff dw_articolo_prezzo_ff
dw_mod_prz_gd dw_mod_prz_gd
end type
global w_mod_prz_cx w_mod_prz_cx

type variables

end variables

forward prototypes
public function decimal wf_calcola_prezzo (integer as_azione, decimal ad_prezzo_o, decimal ad_percentuale, decimal ad_valore, long al_id_var_rif, long al_id_valuta)
end prototypes

public function decimal wf_calcola_prezzo (integer as_azione, decimal ad_prezzo_o, decimal ad_percentuale, decimal ad_valore, long al_id_var_rif, long al_id_valuta);

decimal ld_prezzo
long	  ll_id_articolo, ll_id_unita_confezione, ll_id_locazione_1, ll_id_magazzino
date    ldt_data_registrazione

ld_prezzo = ad_prezzo_o
ll_id_unita_confezione = dw_articolo_prezzo_ff.getitemnumber(1, "id_unita_confezione")

ll_id_locazione_1 = idw_master.is_list.l_id_varie
ldt_data_registrazione = date(idw_master.is_list.s_provenienza)

choose case as_azione
	case 1
		if (not isnull(ad_percentuale)) then ld_prezzo = ( ad_prezzo_o * ad_percentuale / 100 ) + ad_prezzo_o
	case 2
		if (not isnull(ad_valore)) then ld_prezzo = ad_valore + ad_prezzo_o
	case 3
		SELECT id_articolo
		INTO	 :ll_id_articolo
		FROM	 unita_confezione
		WHERE  id_unita_confezione = :ll_id_unita_confezione
		AND    unita_base = 'S'
		;
		
		SELECT id_magazzino
		INTO	 :ll_id_magazzino
		FROM	 locazione
		WHERE  id_locazione = :ll_id_locazione_1
		;
		
		if (isnull(ll_id_magazzino)) then ll_id_magazzino = 0

		setnull(ldt_data_registrazione)
		
		if (isnull(idw_master.is_list.s_provenienza) or  idw_master.is_list.s_provenienza = '') then 
			ldt_data_registrazione = today()
		else
			ldt_data_registrazione = date(idw_master.is_list.s_provenienza)
		end if

		
		SELECT fn_ultimo_costo(1, :ll_id_articolo, :ll_id_magazzino, YEAR(:ldt_data_registrazione), MONTH(:ldt_data_registrazione), :al_id_valuta )
		INTO	 :ld_prezzo
		FROM	 sys.dummy
		;
		
		if (not isnull(ad_percentuale)) then ld_prezzo = ( ld_prezzo * ad_percentuale / 100 ) + ld_prezzo
	case 4
		SELECT prezzo
		INTO	 :ld_prezzo
		FROM	 prezzo
		WHERE  id_variazione = :al_id_var_rif
		AND	 id_unita_confezione = :ll_id_unita_confezione
		;
		
		if (not isnull(ad_percentuale)) then ld_prezzo = ( ld_prezzo * ad_percentuale / 100 ) + ld_prezzo
	case 5
		SELECT prezzo
		INTO	 :ld_prezzo
		FROM	 prezzo
		WHERE  id_variazione = :al_id_var_rif
		AND	 id_unita_confezione = :ll_id_unita_confezione
		;
		
		if (not isnull(ad_valore)) then ld_prezzo = ad_valore + ld_prezzo
		
	case 10
		
		if (not isnull(ad_percentuale)) then ld_prezzo = ( ad_prezzo_o / (100 - ad_percentuale) * 100 )
		
end choose
if isnull(ld_prezzo) then ld_prezzo = 0

if (ld_prezzo > 0) then
	ld_prezzo = f_round_2(al_id_valuta, ld_prezzo)
end if
return ld_prezzo

end function

on w_mod_prz_cx.create
int iCurrent
call super::create
this.dw_articolo_prezzo_ff=create dw_articolo_prezzo_ff
this.dw_mod_prz_gd=create dw_mod_prz_gd
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_articolo_prezzo_ff
this.Control[iCurrent+2]=this.dw_mod_prz_gd
end on

on w_mod_prz_cx.destroy
call super::destroy
destroy(this.dw_articolo_prezzo_ff)
destroy(this.dw_mod_prz_gd)
end on

event open;call super::open;

idw_master = dw_articolo_prezzo_ff
idw_master.is_list = Message.PowerObjectParm
if Upperbound(idw_master.is_list.s_identifica)=0 then
	idw_master.ias_key_name[1] = "id_unita_confezione"
	idw_master.is_list.s_modo=modo_inserisci
end if
idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_sql_ident[1] = "id_unita_confezione"
end event

event ue_post_open;call super::ue_post_open;cb_ricerca.visible = true

end event

type p_crescente from w_p_data`p_crescente within w_mod_prz_cx
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_mod_prz_cx
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_mod_prz_cx
int X=37
int Y=32
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_mod_prz_cx
int X=329
int Y=32
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_mod_prz_cx
int X=622
int Y=32
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_mod_prz_cx
int X=2414
int Y=32
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_mod_prz_cx
int X=2706
int Y=32
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_mod_prz_cx
int X=2999
int Y=32
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_mod_prz_cx
int X=32
int Y=1676
int Height=288
boolean BringToTop=true
end type

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=18
int Y=104
int Width=2322
int Height=168
end type

type cb_ricerca from w_p_data`cb_ricerca within w_mod_prz_cx
int X=2121
int Y=32
boolean BringToTop=true
end type

event cb_ricerca::clicked;string ls_filtro,ls_codice
long ll_seg_value

w_search_main lw_sm
ls_codice = ""

idw_master.is_ricpar.s_filter_value = ""
idw_master.is_ricpar.s_filter_name = "unita_confezione_codice"

openwithparm(lw_sm,idw_master.is_ricpar,"w_unita_confezione_coddes_sw")
idw_master.is_ricpar=message.powerobjectparm
if upperbound(idw_master.is_ricpar.s_id_seg_value)>0 then
	ll_seg_value=long(idw_master.is_ricpar.s_id_seg_value[1])
	
	idw_master.is_list.s_modo=modo_modifica
	idw_master.is_list.s_identifica[1]="id_unita_confezione"
	idw_master.is_list.l_identifica[1]=ll_seg_value
	idw_master.event ue_retrieve(0,0)
	idw_master.setfocus()
end if

end event

type dw_articolo_prezzo_ff from u_dw_master_main within w_mod_prz_cx
int X=37
int Y=160
int Width=3232
int Height=292
int TabOrder=10
boolean BringToTop=true
string DataObject="d_mod_prz_ff"
end type

event ue_init;call super::ue_init;is_list.s_identifica[1] = "id_unita_confezione"
iudw_children[1] = dw_mod_prz_gd
end event

type dw_mod_prz_gd from u_dw_master_main within w_mod_prz_cx
int X=32
int Y=480
int Width=3232
int Height=900
int TabOrder=12
boolean BringToTop=true
string DataObject="d_mod_prz_gd"
boolean VScrollBar=true
end type

event ue_init;call super::ue_init;is_list.s_identifica[1] = "id_unita_confezione"
end event

event doubleclicked;call super::doubleclicked;choose case dwo.name
	case "prezzo_prezzo"
		integer li_azione, li_id_var_rif, li_row
		decimal ld_prezzo_o, ld_valore, ld_prezzo
		decimal {2} ld_percentuale
		long	  ll_id_valuta	
		
		li_row = getrow()
		li_azione = this.getitemnumber(li_row, "azione")
		ld_prezzo_o = this.getitemnumber(li_row, "prezzo_o")
		ld_percentuale = this.getitemnumber(li_row, "percentuale")
		ld_valore = this.getitemnumber(li_row, "valore")
		li_id_var_rif = this.getitemnumber(li_row, "id_var_rif")
		ll_id_valuta = this.getitemnumber(li_row, "id_valuta")	

		
		ld_prezzo = wf_calcola_prezzo(li_azione, ld_prezzo_o, ld_percentuale, ld_valore, li_id_var_rif, ll_id_valuta)
		
		this.setitem(li_row, "prezzo_prezzo", ld_prezzo)
end choose
end event

event sqlpreview;string ls_sqlsyntax, ls_data
date	 ldt_data_registrazione

if (request=PreviewFunctionRetrieve!) then
	setnull(ldt_data_registrazione)
	
	if (isnull(is_list.s_provenienza) or  is_list.s_provenienza = '') then 
		ldt_data_registrazione = today()
	else
		ldt_data_registrazione = date(is_list.s_provenienza)
	end if
	
	ls_data = string(ldt_data_registrazione,'yyyy-mm-dd')
	
	ls_sqlsyntax = sqlsyntax + " AND variazione.data_inizio <= '" + ls_data + &
						"' AND ( variazione.data_fine >= '" + ls_data + &
						"' OR	variazione.data_fine is null)" + &
						" ORDER BY listino.tipo, listino.codice "
	
	this.setSQLpreview(ls_sqlsyntax)
end if
end event

