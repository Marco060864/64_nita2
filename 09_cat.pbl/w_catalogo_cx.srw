forward
global type w_catalogo_cx from window
end type
type ole_imm from olecustomcontrol within w_catalogo_cx
end type
type cb_salva from commandbutton within w_catalogo_cx
end type
type cb_1 from commandbutton within w_catalogo_cx
end type
type cb_formati from commandbutton within w_catalogo_cx
end type
type cb_ok from commandbutton within w_catalogo_cx
end type
type cb_annulla from commandbutton within w_catalogo_cx
end type
type tab_1 from tab within w_catalogo_cx
end type
type tabpage_1 from userobject within tab_1
end type
type dw_catalogo from datawindow within tabpage_1
end type
type dw_riga_catalogo from datawindow within tabpage_1
end type
type cb_nuovo_cat from commandbutton within tabpage_1
end type
type cb_elimina_cat from commandbutton within tabpage_1
end type
type cb_modifica_testa from commandbutton within tabpage_1
end type
type cb_3 from commandbutton within tabpage_1
end type
type cb_nuovo_tipo from commandbutton within tabpage_1
end type
type cb_elimina_tipo from commandbutton within tabpage_1
end type
type gb_1 from groupbox within tabpage_1
end type
type gb_2 from groupbox within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_catalogo dw_catalogo
dw_riga_catalogo dw_riga_catalogo
cb_nuovo_cat cb_nuovo_cat
cb_elimina_cat cb_elimina_cat
cb_modifica_testa cb_modifica_testa
cb_3 cb_3
cb_nuovo_tipo cb_nuovo_tipo
cb_elimina_tipo cb_elimina_tipo
gb_1 gb_1
gb_2 gb_2
end type
type tabpage_3 from userobject within tab_1
end type
type cb_articoli from commandbutton within tabpage_3
end type
type cb_canc_articolo from commandbutton within tabpage_3
end type
type sle_1 from singlelineedit within tabpage_3
end type
type st_art_senza_foto from statictext within tabpage_3
end type
type cb_stampa_lista from commandbutton within tabpage_3
end type
type ddlb_art_senza_foto from listbox within tabpage_3
end type
type st_1 from statictext within tabpage_3
end type
type rb_vert from radiobutton within tabpage_3
end type
type rb_oriz from radiobutton within tabpage_3
end type
type dw_1 from datawindow within tabpage_3
end type
type cb_preview from commandbutton within tabpage_3
end type
type cb_2 from commandbutton within tabpage_3
end type
type cb_stampa from commandbutton within tabpage_3
end type
type gb_3 from groupbox within tabpage_3
end type
type tabpage_3 from userobject within tab_1
cb_articoli cb_articoli
cb_canc_articolo cb_canc_articolo
sle_1 sle_1
st_art_senza_foto st_art_senza_foto
cb_stampa_lista cb_stampa_lista
ddlb_art_senza_foto ddlb_art_senza_foto
st_1 st_1
rb_vert rb_vert
rb_oriz rb_oriz
dw_1 dw_1
cb_preview cb_preview
cb_2 cb_2
cb_stampa cb_stampa
gb_3 gb_3
end type
type tab_1 from tab within w_catalogo_cx
tabpage_1 tabpage_1
tabpage_3 tabpage_3
end type
end forward

shared variables

end variables

global type w_catalogo_cx from window
integer x = 832
integer y = 372
integer width = 2747
integer height = 1744
boolean titlebar = true
string title = "Stampe cataloghi"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 79741120
ole_imm ole_imm
cb_salva cb_salva
cb_1 cb_1
cb_formati cb_formati
cb_ok cb_ok
cb_annulla cb_annulla
tab_1 tab_1
end type
global w_catalogo_cx w_catalogo_cx

type variables
string is_filter="" , is_sql_old
long il_dest_stampa=0

end variables

forward prototypes
public subroutine wf_sel_riga (datawindow adw_datawindow, long al_riga)
public function s_template wf_carica_template (long al_id_template)
public function string wf_componi_formula (long al_id_formula)
public subroutine wf_carica_testi (long al_id_template, long al_id_lingua, ref s_testo as_testi[])
public subroutine wf_scala (ref integer al_dim_x, ref integer al_dim_y, integer al_max_x, integer al_max_y)
public function long wf_imposta_penna (integer al_type, integer al_amp, long al_colore, long al_dc)
public subroutine wf_stampa_catalogo ()
public function integer wf_leggo_dati_testa_piede (long ll_id_catalogo, string ls_nome_catalogo, ref integer li_ampt, ref integer li_ampl, ref string ls_car_ditta, ref string ls_car_rditta, ref character lc_num_pag, ref integer li_logo_mtop, ref integer li_logo_msx, ref integer li_logo_amp_x, ref integer li_logo_amp_y, ref character lc_stampa_righe_az, ref integer li_amp_pie, ref integer li_logo_pie_mtop, ref integer li_logo_pie_msx, ref integer li_logo_pie_amp_x, ref integer li_logo_pie_amp_y, ref character lc_num_pag_pie, ref string ls_note_pie, ref string ls_logo_pie, ref integer li_ampl_pie)
public subroutine wf_trova_misure_e_risoluzione_foto (string ls_nome_immagine, ref integer alt, ref integer lar, ref long ll_img_dpi_x, ref long ll_img_dpi_y)
public subroutine wf_valori_azienda (ref string ls_codice, ref string ls_rag_soc_1, ref string ls_par_iva, ref string ls_cod_fiscale, ref string ls_cciaa, ref string ls_trib_iscrizione, ref decimal ld_tot_capitale, ref string ls_logo, ref string ls_img_dir, ref string ls_nota_azienda, ref string ls_indirizzo, ref string ls_cap, ref string ls_localita, ref string ls_provincia, ref string ls_nazione)
public function string wf_ricerca (long row, string as_codice)
end prototypes

public subroutine wf_sel_riga (datawindow adw_datawindow, long al_riga);long i

for i = 1 to adw_datawindow.RowCount()
	if adw_datawindow.IsSelected(i) then adw_datawindow.SelectRow(i,false)
next
adw_datawindow.SetRow(al_riga)
adw_datawindow.SelectRow(al_riga,true)
end subroutine

public function s_template wf_carica_template (long al_id_template);s_template ls_template

select margine_sx, margine_dx, margine_top, margine_bottom, dim_x, dim_y, distanza, art_x, art_y, fronte_retro, riempi_riquadro, uno_a_uno
into :ls_template.margine_sx, :ls_template.margine_dx, :ls_template.margine_top,&
	 :ls_template.margine_bottom, :ls_template.dim_x, :ls_template.dim_y,&
	 :ls_template.distanza, :ls_template.art_x, :ls_template.art_y, :ls_template.fronte_retro, :ls_template.riempi_riq, :ls_template.uno_a_uno
from s_template
where id_template=:al_id_template;

if sqlca.sqlcode<>0 then 
	messagebox('Errore!','Impossibile risalire al formato!')
	return ls_template
end if

return ls_template
end function

public function string wf_componi_formula (long al_id_formula);

long		ll_id_cat_cod,ll_id_cat_comm,ll_id_cat_merc,ll_id_cat_fisc,ll_id_gruppo
long		ll_id_produttore,ll_id_fornitore,ll_id_magazzino
string	ls_da_art, ls_a_art, ls_produttore,ls_fornitore
string 	ls_where
long 		ll_id_metallo, ll_id_titolo, ll_id_listino, ll_id_variazione
decimal{4}	ld_da_peso, ld_a_peso, ld_da_prezzo, ld_a_prezzo
date 		ldt_da_data, ldt_a_data

string ls_filter

if ls_filter<>"" then return ls_filter

select "s_formula"."id_cat_codifica", "s_formula"."da_art_cod", "s_formula"."a_art_cod", "s_formula"."id_cat_comm",
		"s_formula"."id_cat_merc", "s_formula"."id_cat_fisc", "s_formula"."id_gruppo", "s_formula"."id_produttore",
		"s_formula"."id_fornitore", "s_formula"."id_magazzino", "s_formula"."da_peso", "s_formula"."da_prezzo", 
		"s_formula"."id_titolo", "s_formula"."id_metallo", "s_formula"."a_peso", "s_formula"."a_prezzo", "s_formula"."id_listino",
		"s_formula"."da_data", "s_formula"."a_data", "s_formula"."id_variazione"
into	:ll_id_cat_cod, :ls_da_art, :ls_a_art, :ll_id_cat_comm, :ll_id_cat_merc,&
		:ll_id_cat_fisc, :ll_id_gruppo, :ll_id_produttore, :ll_id_fornitore, :ll_id_magazzino, :ld_da_peso, :ld_da_prezzo,&
		:ll_id_titolo, :ll_id_metallo, :ld_a_peso, :ld_a_prezzo, :ll_id_listino, :ldt_da_data, :ldt_a_data, :ll_id_variazione
from s_formula
where id_formula=:al_id_formula;

if Not IsNull(ll_id_cat_cod) then
	ls_filter = ls_filter + " cat_codifica.id_cat_codifica = "+string(ll_id_cat_cod)+ " and"
end if
if Not IsNull(ls_da_art) and ls_da_art <> "" then
	ls_filter = ls_filter + " articolo.codice >= '"+ls_da_art+"' and"
end if

if Not IsNull(ls_a_art) and ls_a_art <> "" then
	ls_filter = ls_filter + " articolo.codice <= '"+ls_a_art + "' and"	
end if
if Not IsNull(ll_id_cat_comm) then
	ls_filter = ls_filter + " cat_com_articolo.id_cat_com_articolo = "+string(ll_id_cat_comm)+ " and"		
end if
if Not IsNull(ll_id_cat_merc) then
	ls_filter = ls_filter + " cat_merceologica.id_cat_merceologica= "+string(ll_id_cat_merc)+ " and"			
end if
if Not IsNull(ll_id_cat_fisc) then
	ls_filter = ls_filter + " cat_fiscale.id_cat_fiscale= "+string(ll_id_cat_fisc)+ " and"				
end if

if Not IsNull(ll_id_produttore) then
	ls_filter = ls_filter + " anagrafica.id_anagrafica = "+string(ll_id_produttore)+ " and"						
end if
if Not IsNull(ll_id_fornitore) then
	ls_filter = ls_filter + " sog_commerciale_gen.id_sog_commerciale= "+string(ll_id_fornitore)+ " and"						
end if

if Not IsNull(ll_id_listino) and Not IsNull(ll_id_variazione) then
		ls_filter = ls_filter + " prezzo.id_variazione = "+string(ll_id_variazione)+ " and"						
end if


if Not IsNull(ll_id_metallo) then
	ls_filter = ls_filter + " orafo_metallo.id_metallo = "+string(ll_id_metallo)+ " and"						
end if

if Not IsNull(ll_id_titolo) then
	ls_filter = ls_filter + " orafo_titolo.id_titolo = "+string(ll_id_titolo)+ " and"						
end if


string ls_temp

if Not IsNull(ld_da_peso) then
	ls_temp = string(ld_da_peso)
	ls_temp = Trim(ls_temp)
	ls_temp = Replace(ls_temp,Pos(ls_temp,","),1,".")
	ls_filter = ls_filter + " unita_confezione.peso_netto >= "+ls_temp+ " and"						
end if
if Not IsNull(ld_a_peso) then
	ls_temp = string(ld_a_peso)
	ls_temp = Trim(ls_temp)
	ls_temp = Replace(ls_temp,Pos(ls_temp,","),1,".")
	ls_filter = ls_filter + " unita_confezione.peso_netto <= "+ls_temp+ " and"						
end if		
		
	if Not IsNull(ld_da_prezzo) then
		ls_temp = string(ld_da_prezzo)
		ls_temp = Trim(ls_temp)
		ls_temp = Replace(ls_temp,Pos(ls_temp,","),1,".")
		ls_filter = ls_filter + " prezzo.prezzo_manifattura >= "+ls_temp+ " and"						
	end if
	if Not IsNull(ld_a_prezzo) then
		ls_temp = string(ld_a_prezzo)
		ls_temp = Trim(ls_temp)
		ls_temp = Replace(ls_temp,Pos(ls_temp,","),1,".")
		ls_filter = ls_filter + " prezzo.prezzo_manifattura <= "+ls_temp+ " and"						
	end if		

IF ls_filter <>"" THEN
	ls_filter = Left(ls_filter,Len(ls_filter)-3)
	return ls_filter
END IF

return ''
end function

public subroutine wf_carica_testi (long al_id_template, long al_id_lingua, ref s_testo as_testi[]);long i
s_testo ls_testo_app

declare trova_testi cursor for
	select campo, &
			riga, &
			note,&
			font,&
			altezza,&
			red,&
			green,&
			blue,&
			x
	from s_testo
	where (s_testo.id_template=:al_id_template)and
			(s_testo.id_lingua=:al_id_lingua);
i=0
open trova_testi;
do
	i++
	fetch trova_testi into :ls_testo_app.campo,&
							:ls_testo_app.riga,&
							:ls_testo_app.note,&
							:ls_testo_app.font,&
							:ls_testo_app.altezza,&
							:ls_testo_app.red,&
							:ls_testo_app.green,&
							:ls_testo_app.blue,&
							:ls_testo_app.x;
	if sqlca.sqlcode=0 then
		as_testi[i]=ls_testo_app
		if IsNull(as_testi[i].red) then as_testi[i].red=0
		if IsNull(as_testi[i].green) then as_testi[i].green=0
		if IsNull(as_testi[i].blue) then as_testi[i].blue=0
	end if
loop while sqlca.sqlcode=0							
close trova_testi;
if (sqlca.sqlcode<>0)and(i=1) then
	messagebox('Errore','Non esistono testi nella lingua scelta per il catalogo!')
end if




end subroutine

public subroutine wf_scala (ref integer al_dim_x, ref integer al_dim_y, integer al_max_x, integer al_max_y);

decimal rapp_x, rapp_y, rapporto_finale

rapp_x=al_max_x/al_dim_x
rapp_y=al_max_y/al_dim_y

rapporto_finale=Min(rapp_x, rapp_y)

al_dim_x=al_dim_x*rapporto_finale
al_dim_y=al_dim_y*rapporto_finale
end subroutine

public function long wf_imposta_penna (integer al_type, integer al_amp, long al_colore, long al_dc);long ll_penna, ll_pippo

ll_penna=CreatePen(al_type,al_amp,al_colore)
messagebox('',ll_penna)
ll_pippo=SelectObject(al_dc, ll_penna)
messagebox('',ll_pippo)

return ll_pippo
end function

public subroutine wf_stampa_catalogo ();long ll_riga, i, k, j, altezza, larghezza, ll_ret, ll_ripeti_sfondo_x, ll_ripeti_sfondo_y, job, num_imm
long ll_penna_riquadro, ll_penna_noimm

integer li_pag_x=2100, li_pag_y=2970
decimal ld_dpi_x, ld_dpi_y
decimal{2} ld_prezzo


integer li_amp_testo, li_alt_testo
long ll_id_catalogo, ll_id_pagina, ll_id_template, ll_id_formula, ll_id_lingua, ll_red, ll_blue, ll_green
integer li_ampt, li_ampl, li_file, li_art_x, li_art_y_prima, li_art_y_altre, li_temp, num_pag
integer x1, x2, y1, y2, li_scarto_x, li_scarto_y, li_dim_tot_y, li_dim_tot_x, alt, lar, li_ret
integer li_logo_mtop, li_logo_msx, li_logo_amp_x, li_logo_amp_y, li_dim_righe
integer li_amp_pie, li_ampl_pie, li_logo_pie_mtop, li_logo_pie_msx, li_logo_pie_amp_x, li_logo_pie_amp_y
string ls_note_pie, ls_logo_pie
long ll_articolo_corrente, ll_num_righe, conta_pag, myDC
decimal ld_app, rapporto
integer li_alt_righe[], li_amp_testa_prima, li_amp_testa_altre, li_testa_1, li_alt_corrente
integer li_alt_max_riga, li_diff_alt_riga,li_amp_pie_prima, li_amp_pie_altre, li_piede_1
boolean lb_logo_def	
		
char lc_prima_testa, lc_altre_testa, lc_num_pag, lc_sfondo_centrato, lc_stampa_righe_az
char ls_f_drive[255], ls_f_name[255], ls_f_path[255], lc_prima_pie, lc_altre_pie, lc_num_pag_pie
string ls_formula, ls_file, ls_car_ditta, ls_car_rditta, ls_temp, ls_nome_catalogo
string ls_nome_immagine, ls_img_dir, ls_sfondo
unsignedlong lul_path
unsignedint lui_file
string ls_nota_azienda, ls_indirizzo, ls_cap, ls_localita, ls_provincia, ls_nazione

s_template ls_template
s_testo ls_testi[]
s_bitmap ls_bitmap[], ls_bitmap_vuota[]

tab_1.tabpage_3.ddlb_art_senza_foto.reset()

if tab_1.tabpage_3.rb_oriz.checked then
	x1 = li_pag_x
	li_pag_x = li_pag_y
	li_pag_y = x1
end if

ll_riga=tab_1.tabpage_1.dw_catalogo.GetRow()
if ll_riga<=0 then
	messagebox("Errore!", "Nessun catalogo impostato! Torna alla pagina catalogo e impostalo!")
	return
end if
ll_id_catalogo=tab_1.tabpage_1.dw_catalogo.GetItemNumber(ll_riga,"id_catalogo")
ll_id_lingua=tab_1.tabpage_1.dw_catalogo.GetItemNumber(ll_riga,"id_lingua")
lc_prima_testa=tab_1.tabpage_1.dw_catalogo.GetItemString(ll_riga,"prima_testa")
lc_altre_testa=tab_1.tabpage_1.dw_catalogo.GetItemString(ll_riga,"altre_testa")
lc_prima_pie=tab_1.tabpage_1.dw_catalogo.GetItemString(ll_riga,"prima_piede")
lc_altre_pie=tab_1.tabpage_1.dw_catalogo.GetItemString(ll_riga,"altre_piede")
ls_sfondo=tab_1.tabpage_1.dw_catalogo.GetItemString(ll_riga,"s_catalogo_sfondo")
lc_sfondo_centrato=tab_1.tabpage_1.dw_catalogo.GetItemString(ll_riga,"sfondo_centrato")
if (lc_prima_testa='S') or (lc_altre_testa='S') then
	if (wf_leggo_dati_testa_piede(ll_id_catalogo, ls_nome_catalogo, li_ampt, li_ampl, ls_car_ditta, ls_car_rditta, & 
		lc_num_pag, li_logo_mtop, li_logo_msx, li_logo_amp_x, li_logo_amp_y, lc_stampa_righe_az, &
		li_amp_pie, li_logo_pie_mtop, li_logo_pie_msx, li_logo_pie_amp_x, li_logo_pie_amp_y, &
			lc_num_pag_pie, ls_note_pie, ls_logo_pie, li_ampl_pie)) <>1 then
		messagebox("Errore", "Dati per testa o piede non recuperati")
		return
	end if
end if
	
ll_riga=tab_1.tabpage_1.dw_riga_catalogo.GetRow()
if ll_riga<=0 then
	messagebox("Errore!", "Manca riga catalogo!")
	return
end if
ll_id_pagina=tab_1.tabpage_1.dw_riga_catalogo.GetItemNumber(ll_riga,"id_pagina")
ll_red=tab_1.tabpage_1.dw_riga_catalogo.GetItemNumber(ll_riga,"red")
ll_green=tab_1.tabpage_1.dw_riga_catalogo.GetItemNumber(ll_riga,"green")
ll_blue=tab_1.tabpage_1.dw_riga_catalogo.GetItemNumber(ll_riga,"blue")

ll_id_template=tab_1.tabpage_1.dw_riga_catalogo.GetItemNumber(ll_riga,"id_template")
ls_template=wf_carica_template(ll_id_template)

wf_carica_testi(ll_id_template,ll_id_lingua,ls_testi)
if UpperBound(ls_testi)=0 then 
	messagebox("Errore!", "Nessun testo definito!")
	return
end if

long ll_font
string ls_codice, ls_rag_soc_1, ls_par_iva, ls_cod_fiscale, ls_cciaa, ls_trib_iscrizione, ls_logo
decimal ld_tot_capitale

wf_valori_azienda(ls_codice, ls_rag_soc_1, ls_par_iva, ls_cod_fiscale, ls_cciaa, &
ls_trib_iscrizione, ld_tot_capitale, ls_logo, ls_img_dir, ls_nota_azienda, &
						ls_indirizzo, ls_cap, ls_localita, ls_provincia, ls_nazione)


if isnull(ls_template.uno_a_uno) then ls_template.uno_a_uno='N'


IF ls_template.uno_a_uno<>'S' then
	
		
	li_temp = li_pag_x - (ls_template.margine_sx+ls_template.margine_dx)
	li_dim_tot_x=ls_template.dim_x
		
	if Not(IsNull(ll_red)or IsNull(ll_green)or IsNull(ll_blue)) then li_dim_tot_x=li_dim_tot_x+40
	li_art_x=1
	li_temp=li_temp - (li_dim_tot_x)
	if li_temp>0 then
		do 
			li_temp = li_temp - (ls_template.distanza+li_dim_tot_x)
			li_art_x++
		loop while li_temp>0
		li_art_x = li_art_x - 1
	else
		messagebox('Errore!','1)  I parametri di stampa non sono coerenti!')
		return
	end if
		
	if Not(IsNull(ls_template.art_x)) then
		if li_art_x>ls_template.art_x then
			li_art_x=ls_template.art_x
		elseif li_art_x<ls_template.art_x then
			if messagebox('Attenzione','Il numero di oggetti in orizzontale impostato è troppo alto!'+char(13)+&
				+'Proseguire con un numero adatto?',StopSign!,YesNo!)=2 then return
		end if
	end if
	
	
		
	li_temp = li_pag_Y - (ls_template.margine_top+ls_template.margine_bottom)
	li_dim_tot_y=ls_template.dim_y
		
	if Not(IsNull(ll_red)or IsNull(ll_green)or IsNull(ll_blue)) then li_dim_tot_y=li_dim_tot_y+40
		
			
				
	for j=1 to UpperBound(ls_testi)
		li_alt_righe[ls_testi[j].riga]=0
	next
	
	for i = 1 to UpperBound(ls_testi)
		if li_alt_righe[ls_testi[i].riga]<ls_testi[i].altezza then
			li_alt_righe[ls_testi[i].riga]=ls_testi[i].altezza
		end if
	next
			
	for i=2 to UpperBound(li_alt_righe)
		if IsNull(li_alt_righe[i])or(li_alt_righe[i]=0) then
			li_alt_righe[i]=li_alt_righe[i - 1]
		end if
	next
			
	for i = 1 to UpperBound(li_alt_righe)
		li_dim_tot_y=li_dim_tot_y + 20 + li_alt_righe[i]
	next
	
		
	if (lc_prima_testa='S') then
		li_temp = li_temp - (li_ampt+50)	
	end if
	if (lc_prima_pie='S') then
		li_temp = li_temp - (li_amp_pie+50)	
	end if
		
	li_art_y_prima=1
	li_temp=li_temp - (li_dim_tot_y)
	if li_temp>0 then
		do 
			li_temp = li_temp - (ls_template.distanza+li_dim_tot_y)
			li_art_y_prima++
		loop while li_temp>0
		li_art_y_prima = li_art_y_prima - 1
	else
		messagebox('Errore!','2)  I parametri di stampa non sono coerenti!')
		return
	end if
		
	if Not(IsNull(ls_template.art_y)) then	
		if li_art_y_prima>ls_template.art_y then
			li_art_y_prima=ls_template.art_y
		elseif li_art_y_prima<ls_template.art_y then
			if messagebox('Attenzione','Per la prima pagina il numero di oggetti in verticale impostato è troppo alto!'+char(13)+&
				+'Proseguire con un numero adatto?',StopSign!,YesNo!)=2 then return
		end if
	end if
	
		
	li_temp = li_pag_Y - (ls_template.margine_top+ls_template.margine_bottom)
	if (lc_altre_testa='S') then
		li_temp = li_temp - (li_ampt+50)	
	end if
	if (lc_altre_pie='S') then
		li_temp = li_temp - (li_amp_pie+50)	
	end if
	
	li_art_y_altre=1
	li_temp=li_temp - (li_dim_tot_y)
	if li_temp>0 then
		do 
			li_temp = li_temp - (ls_template.distanza+li_dim_tot_y)
			li_art_y_altre++
		loop while li_temp>0
		li_art_y_altre = li_art_y_altre - 1
	else
		messagebox('Errore!','3)  I parametri di stampa non sono coerenti!')
		return
	end if
		
	if Not(IsNull(ls_template.art_y)) then		
		if li_art_y_altre>ls_template.art_y then
			li_art_y_altre=ls_template.art_y
		elseif li_art_y_altre<ls_template.art_y then
			if messagebox('Attenzione','Per le pagine successive alla prima il numero di oggetti in verticale impostato è troppo alto!'+char(13)+&
				+'Proseguire con un numero adatto?',StopSign!,YesNo!)=2 then return
		end if
	end if
else  
	
	li_art_x = li_pag_x - (ls_template.margine_sx+ls_template.margine_dx)
	li_dim_tot_x = 0
	
	
	li_art_y_prima = li_pag_Y - (ls_template.margine_top+ls_template.margine_bottom)
	if (lc_prima_testa='S') then
		li_art_y_prima = li_art_y_prima - (li_ampt+50)
		li_amp_testa_prima=li_ampt
		if isnull(li_amp_testa_prima) then li_amp_testa_prima=0
	end if
	if (lc_prima_pie='S') then
		li_art_y_prima = li_art_y_prima - (li_amp_pie+50)	
		li_amp_pie_prima=li_amp_pie
		if isnull(li_amp_pie_prima) then li_amp_pie_prima=0
	end if
	
	li_art_y_altre = li_pag_Y - (ls_template.margine_top+ls_template.margine_bottom)
	if (lc_altre_testa='S') then
		li_art_y_altre = li_art_y_altre - (li_ampt+50)	
		li_amp_testa_altre=li_ampt
		if isnull(li_amp_testa_altre) then li_amp_testa_altre=0
	end if
	if (lc_altre_pie='S') then
		li_art_y_altre = li_art_y_altre - (li_amp_pie+50)	
		li_amp_pie_altre=li_amp_pie
		if isnull(li_amp_pie_altre) then li_amp_pie_altre=0
	end if
	li_dim_tot_y = 0
	
	
	for j=1 to UpperBound(ls_testi)
		li_alt_righe[ls_testi[j].riga]=0
	next
	
	for i = 1 to UpperBound(ls_testi)
		if li_alt_righe[ls_testi[i].riga]<ls_testi[i].altezza then
			li_alt_righe[ls_testi[i].riga]=ls_testi[i].altezza
		end if
	next
			
	for i=2 to UpperBound(li_alt_righe)
		if IsNull(li_alt_righe[i])or(li_alt_righe[i]=0) then
			li_alt_righe[i]=li_alt_righe[i - 1]
		end if
	next
			
	for i = 1 to UpperBound(li_alt_righe)
		li_dim_tot_y=li_dim_tot_y + 20 + li_alt_righe[i]
	next
	li_dim_righe=li_dim_tot_y
	li_dim_tot_y=0
end if 

ll_num_righe=tab_1.tabpage_3.dw_1.RowCount()
if ll_num_righe=0 then 
	messagebox('Attenzione!','Non ci sono articoli per la formula corrente!')
	return
end if
ll_riga=ll_num_righe

if ls_template.uno_a_uno<>'S' then
	num_pag=1
	if ll_num_righe>(li_art_x*li_art_y_prima) then
		ll_num_righe=ll_num_righe - (li_art_x*li_art_y_prima)
		num_pag++
		do while ll_num_righe>(li_art_x*li_art_y_altre)
			ll_num_righe=ll_num_righe - (li_art_x*li_art_y_altre)
			num_pag++
		loop 
	end if
else 
	num_pag=ll_num_righe 
								  
end if

ll_num_righe=ll_riga
ll_riga=1


PrintSetup()

if messagebox("Attenzione!", "Vuoi davvero stampare?", Exclamation!, yesno!)=2 then return

job=PrintOpen()

myDC=PRP_GetDC(job)

ole_imm.object.printsize=6

ll_penna_riquadro=CreatePen(0,10,rgb(ll_red,ll_green,ll_blue))
ll_penna_noimm=CreatePen(0,10,rgb(255,0,0))

constant integer HorzRes = 8	
constant integer VertRes = 10	
constant integer HorzSize = 4	
constant integer VertSize = 6  
constant integer PhysicalOffsetX = 112	
constant integer PhysicalOffsetY = 113	

long ll_PixelDiX, ll_PixelDiY, ll_MmDiX, ll_MmDiY

ll_PixelDiX = getdevicecaps(mydc,HorzRes) 
ll_PixelDiY = getdevicecaps(mydc,VertRes) 
ll_MmDiX = getdevicecaps(mydc,HorzSize) 
ll_MmDiY = getdevicecaps(mydc,VertSize) 

ld_Dpi_X = ll_PixelDiX / (10*ll_MmDiX)
ld_Dpi_Y = ll_PixelDiY / (10*ll_MmDiY)


ll_id_catalogo=1
if ls_template.fronte_retro='S' then
	ll_id_pagina=2
	if messagebox('Stampa Catalogo '+ls_nome_catalogo,"E' stata selezionata l'opzione di stampa 'fronte e retro'"+char(13)+&
	+"Verranno stampate prima le pagine dispari e poi quelle pari.."+char(13)+"Continuare?",Information!,OkCancel!)=2 then return
else
	ll_id_pagina=1
end if
do
	for conta_pag= ll_id_catalogo to num_pag

		SetTextColor(mydc,0)		
	
		li_scarto_y=ls_template.margine_top+50		
		
		
		if ((lc_prima_testa='S')and(conta_pag=1))or((lc_altre_testa='S')and(conta_pag>1)) then
			
			lb_logo_def=(li_logo_amp_x>0)and(li_logo_amp_y>0)and(li_logo_mtop>0)and(li_logo_msx>0)
			
			
			ls_nome_immagine=ls_logo
			if ls_nome_immagine <> "" and not isnull(ls_nome_immagine) then
				IF POS(ls_nome_immagine, "\")<1 THEN ls_nome_immagine=ls_img_dir+'\'+ls_nome_immagine
				
				if FileExists(ls_nome_immagine) then 
					
					ole_imm.object.loadimage=ls_nome_immagine
					
					alt=ole_imm.object.imageHeight
					lar=ole_imm.object.imagewidth
					if lb_logo_def then
						alt=li_logo_amp_y
						lar=li_logo_amp_x
						x1=ls_template.margine_sx + li_logo_msx
						y1=ls_template.margine_top + li_logo_mtop
					else
					
						f_scala(lar,alt,(li_pag_x - ls_template.margine_sx - ls_template.margine_dx - li_ampl),li_ampl)
						x1 = ls_template.margine_sx
						y1 = ls_template.margine_top
					end if
					x2=x1+lar
					y2= y1+alt
					ls_bitmap[upperbound(ls_bitmap)+1].nome=ls_nome_immagine
					ls_bitmap[upperbound(ls_bitmap)].x1=ld_dpi_x*x1
					ls_bitmap[upperbound(ls_bitmap)].y1=ld_dpi_y*y1
					ls_bitmap[upperbound(ls_bitmap)].x2=ld_dpi_x*x2
					ls_bitmap[upperbound(ls_bitmap)].y2=ld_dpi_y*y2
					ls_bitmap[upperbound(ls_bitmap)].trasparente=false					
				else
					
					tab_1.tabpage_3.ddlb_art_senza_foto.additem("Logo Azienda")
					SetNull(ls_logo)		
					
				end if
			end if
			
			
			
			PrintDefinefont(job,1,ls_car_ditta,60*3.94,700,Default!,AnyFont!,false,false)
			PrintDefinefont(job,2,ls_car_rditta,35*3.94,400,Default!,AnyFont!,false,false)			
			
			if lc_stampa_righe_az='S' then
				if not(lb_logo_def) then 
					y1 = ls_template.margine_top
					PrintText(job,ls_rag_soc_1,3.94*x1,3.94*y1,1)
					
					ls_temp=ls_indirizzo
					y1 = ls_template.margine_top+100
					PrintText(job,ls_temp,3.94*x1,3.94*y1,2)
					
					ls_temp=ls_localita+" "+ls_cap+" "+ls_provincia+" "+ls_nazione
					y1 = ls_template.margine_top+140
					PrintText(job,ls_temp,3.94*x1,3.94*y1,2)

					
					y1 = ls_template.margine_top+180
					PrintText(job,ls_nota_azienda,3.94*x1,3.94*y1,2)
			
					
				else  
					
					ls_temp=ls_rag_soc_1
					li_amp_testo=f_calc_larghezza_testo(job,ls_car_ditta,60,ls_temp)
					if li_amp_testo<>-1 then
						
						if (li_pag_x - ls_template.margine_sx - li_logo_msx - li_logo_amp_x - 100 - ls_template.margine_dx)<li_amp_testo then
							ld_app=(li_pag_x - ls_template.margine_sx - li_logo_msx - li_logo_amp_x - 100 - ls_template.margine_dx)/li_amp_testo	
							ld_app=int(Len(ls_temp)*ld_app)
							ls_temp=Left(ls_temp,ld_app)
						end if
						x1= ls_template.margine_sx + li_logo_msx + li_logo_amp_x + 100
						y1= ls_template.margine_top
						PrintText(job,ls_temp,3.94*x1,3.94*y1,1)
					end if
					
					ls_temp=ls_indirizzo
					li_amp_testo=f_calc_larghezza_testo(job,ls_car_rditta,35,ls_temp)
					if li_amp_testo<>-1 then
						
						if (li_pag_x - ls_template.margine_sx - li_logo_msx - li_logo_amp_x - 100 - ls_template.margine_dx)<li_amp_testo then
							ld_app=(li_pag_x - ls_template.margine_sx - li_logo_msx - li_logo_amp_x - 100 - ls_template.margine_dx)/li_amp_testo	
							ld_app=int(Len(ls_temp)*ld_app)								
							ls_temp=Left(ls_temp,ld_app)
						end if
						x1= ls_template.margine_sx + li_logo_msx + li_logo_amp_x + 100
						y1 = ls_template.margine_top+100
						PrintText(job,ls_temp,3.94*x1,3.94*y1,2)
					end if				
					
					ls_temp=ls_localita+" "+ls_cap+" "+ls_provincia+" "+ls_nazione
					li_amp_testo=f_calc_larghezza_testo(job,ls_car_rditta,35,ls_temp)
					if li_amp_testo<>-1 then
						
						if (li_pag_x - ls_template.margine_sx - li_logo_msx - li_logo_amp_x - 100 - ls_template.margine_dx)<li_amp_testo then
							ld_app=(li_pag_x - ls_template.margine_sx - li_logo_msx - li_logo_amp_x - 100 - ls_template.margine_dx)/li_amp_testo	
							ld_app=int(Len(ls_temp)*ld_app)								
							ls_temp=Left(ls_temp,ld_app)
						end if
						x1= ls_template.margine_sx + li_logo_msx + li_logo_amp_x + 100
						y1 = ls_template.margine_top+140
						PrintText(job,ls_temp,3.94*x1,3.94*y1,2)
					end if			
					
					
					
					ls_temp=ls_nota_azienda
					li_amp_testo=f_calc_larghezza_testo(job,ls_car_rditta,35,ls_temp)
					if li_amp_testo<>-1 then
						
						if (li_pag_x - ls_template.margine_sx - li_logo_msx - li_logo_amp_x - 100 - ls_template.margine_dx)<li_amp_testo then
							ld_app=(li_pag_x - ls_template.margine_sx - li_logo_msx - li_logo_amp_x - 100 - ls_template.margine_dx)/li_amp_testo	
							ld_app=int(Len(ls_temp)*ld_app)								
							ls_temp=Left(ls_temp,ld_app)
						end if
						x1= ls_template.margine_sx + li_logo_msx + li_logo_amp_x + 100
						y1 = ls_template.margine_top+180
						PrintText(job,ls_temp,3.94*x1,3.94*y1,2)
					end if
					
					
					
					
						
	

					
					
						
				end if
			end if
			
	
			
			x1 = ls_template.margine_sx
			y1 = ls_template.margine_top + li_ampt
			x2 = li_pag_x - ls_template.margine_dx
			y2 = y1
			PrintLine(job, 3.94*x1, 3.94*y1, 3.94*x2, 3.94*y2, 10*3.94)
			
			
			if lc_num_pag='S' then
				ls_temp=string(Today(),"dd/mm/yy")+' - Stampa Catalogo '+ls_nome_catalogo+' - Pagina '+string(conta_pag)
				if ls_template.uno_a_uno<>'S' then ls_temp=ls_temp+' di '+string(num_pag)
				li_alt_testo=35
				li_amp_testo=f_calc_larghezza_testo(job,ls_car_rditta,li_alt_testo,ls_temp)
				if li_amp_testo<>-1 then
					x1=li_pag_x - ls_template.margine_dx - li_amp_testo
					y1=ls_template.margine_top + li_ampt - 70
					PrintDefineFont(job,3,ls_car_rditta,li_alt_testo*3.94,400,Default!,AnyFont!,false,false)
					PrintText(job,ls_temp,3.94*x1,3.94*y1,3)
				end if
			end if
			li_scarto_y=li_scarto_y+li_ampt
		end if
	
		
		if conta_pag=1 then
			li_temp=li_art_y_prima
		else
			li_temp=li_art_y_altre
		end if
		
		
		if ls_template.uno_a_uno<>'S' then
			for ll_articolo_corrente=1 to li_temp
				for i=1 to li_art_x
					
					
					if Not(IsNull(ll_red)or IsNull(ll_green)or IsNull(ll_blue)) then
						x1=ls_template.margine_sx+((i - 1)*(li_dim_tot_x+ls_template.distanza))
						y1=li_scarto_y
						x2=li_dim_tot_x
						y2=li_dim_tot_y
						SelectObject(mydc, ll_penna_riquadro)
						PrintRect(job, 3.94*x1, 3.94*y1, 3.94*x2, 3.94*y2,1)					
					end if
					
					ls_nome_immagine=tab_1.tabpage_3.dw_1.GetItemString(ll_riga,"articolo_immagine")
				  
					
					x1 = ls_template.margine_sx+20+((i - 1)*(li_dim_tot_x+ls_template.distanza))
					y1 = li_scarto_y + 20
					x2 = ls_template.dim_x
					y2 = ls_template.dim_y
					if ls_nome_immagine <> "" and not(isnull(ls_nome_immagine)) then
						
						IF POS(ls_nome_immagine,"\")<1 then ls_nome_immagine=ls_img_dir+'\'+ls_nome_immagine
							
						if FileExists(ls_nome_immagine) then 
							ole_imm.object.loadimage= ls_nome_immagine
							
							alt=ole_imm.object.imageHeight
							lar=ole_imm.object.imagewidth
							
							if ls_template.riempi_riq='S' then
								ls_bitmap[upperbound(ls_bitmap)+1]=f_taglia(lar, alt, x1, y1, x1+x2, y1+y2)
								ls_bitmap[upperbound(ls_bitmap)].nome=ls_nome_immagine							
								ls_bitmap[upperbound(ls_bitmap)].trasparente=false
								ls_bitmap[upperbound(ls_bitmap)].x1=ls_bitmap[upperbound(ls_bitmap)].x1*ld_dpi_x
								ls_bitmap[upperbound(ls_bitmap)].y1=ls_bitmap[upperbound(ls_bitmap)].y1*ld_dpi_y
								ls_bitmap[upperbound(ls_bitmap)].x2=ls_bitmap[upperbound(ls_bitmap)].x2*ld_dpi_x
								ls_bitmap[upperbound(ls_bitmap)].y2=ls_bitmap[upperbound(ls_bitmap)].y2*ld_dpi_y
								ls_bitmap[upperbound(ls_bitmap)].tagliata=true
							else
								ls_bitmap[upperbound(ls_bitmap)+1].nome=ls_nome_immagine
								
								f_scala(lar,alt,ls_template.dim_x,ls_template.dim_y)
								ls_bitmap[upperbound(ls_bitmap)].x1=ld_dpi_x*x1
								ls_bitmap[upperbound(ls_bitmap)].y1=ld_dpi_y*y1
								ls_bitmap[upperbound(ls_bitmap)].x2=ld_dpi_x*(x1+lar)
								ls_bitmap[upperbound(ls_bitmap)].y2=ld_dpi_y*(y1+alt)
								ls_bitmap[upperbound(ls_bitmap)].trasparente=false
							end if
						else
							
							tab_1.tabpage_3.ddlb_art_senza_foto.additem(ls_nome_immagine)
							
							SelectObject(mydc, ll_penna_noimm)
							PrintRect(job, 3.94*x1, 3.94*y1, 3.94*x2, 3.94*y2,1)
							PrintLine(job, 3.94*x1, 3.94*y1, 3.94*(x1+x2), 3.94*(y1+y2),1)
						end if
					else
						
						SelectObject(mydc, ll_penna_noimm)
						PrintRect(job, 3.94*x1, 3.94*y1, 3.94*x2, 3.94*y2,1)
						PrintLine(job, 3.94*x1, 3.94*y1, 3.94*(x1+x2), 3.94*(y1+y2),1)
					end if
					
					
					for k=1 to UpperBound(ls_testi)
						
						if ls_testi[k].campo='S' then
							choose case ls_testi[k].note
								case "articolo_nota_in_stampa"
									ls_temp=tab_1.tabpage_3.dw_1.GetItemString(ll_riga,"note_art")
								case "articolo_codice", 	"articolo_descrizione", "articolo_immagine", "cat_codcifica_codice"
									ls_temp=tab_1.tabpage_3.dw_1.GetItemString(ll_riga,ls_testi[k].note)
								case "cat_com_articolo_codice", "cat_fiscale_codice", "cat_merceologica_codice", "unita_confezione_codice"
									ls_temp=tab_1.tabpage_3.dw_1.GetItemString(ll_riga,ls_testi[k].note)								
								case "orafo_metallo_codice", "orafo_metallo_descrizione", "orafo_colore_codice", "orafo_colore_descrizione"
									ls_temp=tab_1.tabpage_3.dw_1.GetItemString(ll_riga,ls_testi[k].note)								
								case "anagrafica_rag_soc_1", "sog_commerciale_rag_soc_1"
									ls_temp=tab_1.tabpage_3.dw_1.GetItemString(ll_riga,ls_testi[k].note)
									
								case "prezzo_prezzo","prezzo_prezzo_manifattura", "orafo_metallo_quotazione",&
									 "unita_confezione_peso_netto",  "unita_confezione_dim_l","orafo_titolo_titolo", &
									 "articolo_coef_calo", "unita_confezione_peso_non_prezioso"
									ld_prezzo=tab_1.tabpage_3.dw_1.GetItemDecimal(ll_riga,ls_testi[k].note)
									
									ls_temp=string(ld_prezzo)
								case "orafo_metallo_data_quotazione"
									ls_temp=string(tab_1.tabpage_3.dw_1.GetItemDatetime(ll_riga,ls_testi[k].note))
							end choose
						else
							ls_temp=ls_testi[k].note
						end if
						
						
						li_amp_testo=f_calc_larghezza_testo(job,ls_testi[k].font,ls_testi[k].altezza,ls_temp)
						if li_amp_testo<>-1 then
							
							if ls_testi[k].x+li_amp_testo>ls_template.dim_x then
								ld_app=(ls_template.dim_x - ls_testi[k].x)/li_amp_testo	
								ld_app=int(Len(ls_temp)*ld_app)								
								ls_temp=Left(ls_temp,ld_app)
							end if
							
							x1 = ls_template.margine_sx+20+((i - 1)*(li_dim_tot_x+ls_template.distanza))
							x1= x1 + ls_testi[k].x
							y1 = li_scarto_y + 20 + ls_template.dim_y + 20
							if ls_testi[k].riga>1 then
								for j = 1 to (ls_testi[k].riga - 1)
									y1 = y1 + li_alt_righe[j] + 20
								next
							end if
							PrintDefinefont(job,4,ls_testi[k].font,ls_testi[k].altezza*3.94,400,Default!,AnyFont!,false,false)			
							SetTextColor(mydc,rgb(ls_testi[k].red,ls_testi[k].green,ls_testi[k].blue))
							PrintText(job,ls_temp,3.94*x1,3.94*y1,4)
						end if
					next
					
					ll_riga ++
					if ll_riga>ll_num_righe then exit
				next
				li_scarto_y = li_scarto_y+ li_dim_tot_y + ls_template.distanza
		
				if ll_riga>ll_num_righe then exit
			next					
		
		else
			long ll_img_dpi_x, ll_img_dpi_y
			
			li_dim_tot_x=0
			li_dim_tot_y=0
			li_temp = li_pag_Y - (ls_template.margine_top+ls_template.margine_bottom)
			
			
			
			for ll_articolo_corrente = 0 to (num_pag - conta_pag)
				if conta_pag=1 then 
					li_testa_1=li_amp_testa_prima
					li_piede_1=li_amp_pie_prima
				else
					li_testa_1=li_amp_testa_altre
					li_piede_1=li_amp_pie_altre
				end if
				ls_nome_immagine=tab_1.tabpage_3.dw_1.GetItemString(ll_riga,"articolo_immagine")
				if POS(ls_nome_immagine,"\")<1 then ls_nome_immagine=ls_img_dir+'\'+ls_nome_immagine
				wf_trova_misure_e_risoluzione_foto(ls_nome_immagine, &
					alt, lar, ll_img_dpi_x, ll_img_dpi_y)
				
				li_alt_corrente=alt+li_dim_righe
				
				if li_dim_tot_x=0 then li_dim_tot_x= - ls_template.distanza
				
				IF (li_dim_tot_x+ls_template.distanza+lar) > li_art_x then
					if li_dim_tot_x=- ls_template.distanza then li_dim_tot_x=0
					
					
					if Not(IsNull(ll_red)or IsNull(ll_green)or IsNull(ll_blue)) then li_dim_tot_y = li_dim_tot_y+ 40
					
					
					if ((li_dim_tot_y+li_alt_corrente+li_testa_1+li_piede_1+40+50)<li_temp) and (lar<li_art_x) then
						
						if ls_nome_immagine <> "" and FileExists(ls_nome_immagine) then
							
							ls_bitmap[upperbound(ls_bitmap)+1].nome=ls_nome_immagine							
							ls_bitmap[upperbound(ls_bitmap)].trasparente=false
							
							if Not(IsNull(ll_red)or IsNull(ll_green)or IsNull(ll_blue)) then
								x1=ls_template.margine_sx
								
								y1=ls_template.margine_top+50 + li_dim_tot_y+li_testa_1
								x2=lar + 40
								y2=alt+li_dim_righe+40  
								SelectObject(mydc, ll_penna_riquadro)
								PrintRect(job, 3.94*x1, 3.94*y1, 3.94*x2, 3.94*y2,1)
								ls_bitmap[upperbound(ls_bitmap)].x1=ld_dpi_x*(x1+20)
								ls_bitmap[upperbound(ls_bitmap)].y1=ld_dpi_y*(y1+20)
								ls_bitmap[upperbound(ls_bitmap)].x2=ld_dpi_x*(x1+lar+20)
								ls_bitmap[upperbound(ls_bitmap)].y2=ld_dpi_y*(y1+alt+20)
							end if
						else
							
							if Not(IsNull(ll_red)or IsNull(ll_green)or IsNull(ll_blue)) then
								x1=ls_template.margine_sx
								y1=ls_template.margine_top+50+ li_dim_tot_y+li_testa_1
								
								x2=lar + 40
								y2=alt+li_dim_righe+40
								SelectObject(mydc, ll_penna_riquadro)
								PrintRect(job, 3.94*x1, 3.94*y1, 3.94*x2, 3.94*y2,1)
								SelectObject(mydc, ll_penna_noimm)
								PrintRect(job, 3.94*x1, 3.94*y1, 3.94*lar, 3.94*alt,1)
								PrintLine(job, 3.94*x1, 3.94*y1, 3.94*(x1+20+lar), 3.94*(y1+20+alt),1)
							end if
						end if						
						
						
						li_alt_max_riga=li_alt_corrente
						li_scarto_y =ls_template.margine_top+50+  li_dim_tot_y  + li_testa_1
						li_dim_tot_y = li_dim_tot_y+li_alt_corrente+ls_template.distanza
						li_dim_tot_x = ls_template.distanza+lar
						if Not(IsNull(ll_red)or IsNull(ll_green)or IsNull(ll_blue)) then li_dim_tot_x = li_dim_tot_x+ 40
					else
						exit
					end if
				ELSE  
					if li_dim_tot_y=0 then
						li_dim_tot_y=li_alt_corrente +li_testa_1+ls_template.distanza
						li_alt_max_riga=0
					else
						li_diff_alt_riga=li_alt_corrente - li_alt_max_riga
						if li_diff_alt_riga>0 then 
							li_alt_max_riga=li_alt_corrente
							li_dim_tot_y += li_diff_alt_riga
						end if
					end if
					li_alt_max_riga=max(li_alt_corrente, li_alt_max_riga)
					if li_dim_tot_x=- ls_template.distanza then li_dim_tot_x=0
					
					
					
					if (li_dim_tot_y)+li_piede_1+40+50>(li_temp ) then 
						
						
						exit
					else
						
						
						IF ls_nome_immagine <> "" and  FileExists(ls_nome_immagine) then
							
							if POS(ls_nome_immagine,"\")<1 then ls_nome_immagine=ls_img_dir+'\'+ls_nome_immagine
							ls_bitmap[upperbound(ls_bitmap)+1].nome=ls_nome_immagine							
							ls_bitmap[upperbound(ls_bitmap)].trasparente=false
							if Not(IsNull(ll_red)or IsNull(ll_green)or IsNull(ll_blue)) then
								x1=ls_template.margine_sx + li_dim_tot_x
								y1=li_scarto_y
								x2=lar + 40
								y2=alt+li_dim_righe+40
								SelectObject(mydc, ll_penna_riquadro)
								PrintRect(job, 3.94*x1, 3.94*y1, 3.94*x2, 3.94*y2,1)
								ls_bitmap[upperbound(ls_bitmap)].x1=ld_dpi_x*(x1+20)
								ls_bitmap[upperbound(ls_bitmap)].y1=ld_dpi_y*(y1+20)
								ls_bitmap[upperbound(ls_bitmap)].x2=ld_dpi_x*(x1+lar+20)
								ls_bitmap[upperbound(ls_bitmap)].y2=ld_dpi_y*(y1+alt+20)
							else
								x1=ls_template.margine_sx + li_dim_tot_x
								y1=li_scarto_y
								ls_bitmap[upperbound(ls_bitmap)].x1=ld_dpi_x*(x1)
								ls_bitmap[upperbound(ls_bitmap)].y1=ld_dpi_y*(y1)
								ls_bitmap[upperbound(ls_bitmap)].x2=ld_dpi_x*(x1+lar)
								ls_bitmap[upperbound(ls_bitmap)].y2=ld_dpi_y*(y1+alt)
							end if
						ELSE
							
							if Not(IsNull(ll_red)or IsNull(ll_green)or IsNull(ll_blue)) then
								
								x1=ls_template.margine_sx+li_dim_tot_x
								y1=li_scarto_y
								x2=lar + 40
								y2=alt+li_dim_righe+40
								SelectObject(mydc, ll_penna_riquadro)
								PrintRect(job, 3.94*x1, 3.94*y1, 3.94*x2, 3.94*y2,1)
								SelectObject(mydc, ll_penna_noimm)
								PrintRect(job, 3.94*x1, 3.94*y1, 3.94*lar, 3.94*alt,1)
								PrintLine(job, 3.94*x1, 3.94*y1, 3.94*(x1+20+lar), 3.94*(y1+20+alt),1)
							else
								x1=ls_template.margine_sx+li_dim_tot_x
								y1=li_scarto_y
								SelectObject(mydc, ll_penna_noimm)
								PrintRect(job, 3.94*x1, 3.94*y1, 3.94*lar, 3.94*alt,1)
								PrintLine(job, 3.94*x1, 3.94*y1, 3.94*(x1+lar), 3.94*(y1+alt),1)
							end if
						END IF
						
						li_dim_tot_x = li_dim_tot_x+ls_template.distanza+lar
						if Not(IsNull(ll_red)or IsNull(ll_green)or IsNull(ll_blue)) then li_dim_tot_x = li_dim_tot_x+ 40
					end if
				end if
					
				
				for k=1 to UpperBound(ls_testi)
					
					if ls_testi[k].campo='S' then
						choose case ls_testi[k].note
							case "articolo_nota_in_stampa"
								ls_temp=tab_1.tabpage_3.dw_1.GetItemString(ll_riga,"note_art")
							case "articolo_codice", 	"articolo_descrizione", "articolo_immagine", "cat_codcifica_codice"
								ls_temp=tab_1.tabpage_3.dw_1.GetItemString(ll_riga,ls_testi[k].note)
							case "cat_com_articolo_codice", "cat_fiscale_codice", "cat_merceologica_codice", "unita_confezione_codice"
								ls_temp=tab_1.tabpage_3.dw_1.GetItemString(ll_riga,ls_testi[k].note)								
							case "orafo_metallo_codice", "orafo_metallo_descrizione", "orafo_colore_codice", "orafo_colore_descrizione"
								ls_temp=tab_1.tabpage_3.dw_1.GetItemString(ll_riga,ls_testi[k].note)								
							case "anagrafica_rag_soc_1", "sog_commerciale_rag_soc_1"
								ls_temp=tab_1.tabpage_3.dw_1.GetItemString(ll_riga,ls_testi[k].note)
								
							case "prezzo_prezzo","prezzo_prezzo_manifattura", "orafo_titolo_titolo", &
								"articolo_coef_calo", "unita_confezione_peso_non_prezioso",&
								"unita_confezione_peso_netto", "orafo_metallo_quotazione", "unita_confezione_dim_l"
								ld_prezzo=tab_1.tabpage_3.dw_1.GetItemDecimal(ll_riga,ls_testi[k].note)
								
								ls_temp=string(ld_prezzo)
								
							case "orafo_metallo_data_quotazione"
								ls_temp=string(tab_1.tabpage_3.dw_1.GetItemDatetime(ll_riga,ls_testi[k].note))
						end choose
					else
						ls_temp=ls_testi[k].note
					end if
					
					
					li_amp_testo=f_calc_larghezza_testo(job,ls_testi[k].font,ls_testi[k].altezza,ls_temp)
					if li_amp_testo<>-1 then
						
						if ls_testi[k].x+li_amp_testo>lar then
							ld_app=(lar - ls_testi[k].x)/li_amp_testo	
							ld_app=int(Len(ls_temp)*ld_app)								
							ls_temp=Left(ls_temp,ld_app)
						end if
						
						y1 = li_scarto_y + 20 + alt + 20
						if ls_testi[k].riga>1 then
							for j = 1 to (ls_testi[k].riga - 1)
								y1 = y1 + li_alt_righe[j] + 20
							next
						end if
						PrintDefinefont(job,4,ls_testi[k].font,ls_testi[k].altezza*3.94,400,Default!,AnyFont!,false,false)			
						SetTextColor(mydc,rgb(ls_testi[k].red,ls_testi[k].green,ls_testi[k].blue))
						PrintText(job,ls_temp,3.94*(x1 +20+ ls_testi[k].x),3.94*y1,4)
					end if
				next
				ll_riga++
			next
			
			
			if ll_articolo_corrente>0 then conta_pag = conta_pag + ll_articolo_corrente -1
		end if


		
		if ((lc_prima_pie='S')and(conta_pag=1))or((lc_altre_pie='S')and(conta_pag>1)) then
			
			lb_logo_def=(li_logo_pie_amp_x>0)and(li_logo_pie_amp_y>0)and(li_logo_pie_mtop>0)and(li_logo_pie_msx>0)
		
			
			x1 = ls_template.margine_sx
			y1 = li_pag_y - ls_template.margine_bottom - li_amp_pie
			x2 = li_pag_x - ls_template.margine_dx
			y2 = y1
			PrintLine(job, 3.94*x1, 3.94*y1, 3.94*x2, 3.94*y2, 10*3.94)		

			
			ls_nome_immagine=ls_logo_pie
			if ls_nome_immagine <> "" and not isnull(ls_nome_immagine) then
				if POS(ls_nome_immagine,"\")<1 then ls_nome_immagine=ls_img_dir+'\'+ls_nome_immagine
				if FileExists(ls_nome_immagine) then
					
					ole_imm.object.loadimage=ls_nome_immagine
					
					alt=ole_imm.object.imageHeight
					lar=ole_imm.object.imagewidth
					if lb_logo_def then
						alt=li_logo_pie_amp_y
						lar=li_logo_pie_amp_x
						x1=ls_template.margine_sx + li_logo_pie_msx
						y1=li_pag_y - ls_template.margine_bottom - li_amp_pie + li_logo_pie_mtop
					else
					
						f_scala(lar,alt,(li_pag_x - ls_template.margine_sx - ls_template.margine_dx - li_ampl_pie),li_ampl_pie)
						x1 = ls_template.margine_sx
						y1 = li_pag_y - ls_template.margine_bottom - li_amp_pie
					end if
					x2=x1+lar
					y2= y1+alt
					ls_bitmap[upperbound(ls_bitmap)+1].nome=ls_nome_immagine
					ls_bitmap[upperbound(ls_bitmap)].x1=ld_dpi_x*x1
					ls_bitmap[upperbound(ls_bitmap)].y1=ld_dpi_y*y1
					ls_bitmap[upperbound(ls_bitmap)].x2=ld_dpi_x*x2
					ls_bitmap[upperbound(ls_bitmap)].y2=ld_dpi_y*y2
					ls_bitmap[upperbound(ls_bitmap)].trasparente=false					
				else
					tab_1.tabpage_3.ddlb_art_senza_foto.additem("logo dell'azienda")
					SetNull(ls_logo_pie)		
				end if
			end if

			SetTextColor(mydc,0)		
		
			
			if ls_note_pie<>"" and not IsNull(ls_note_pie) then
				if not(lb_logo_def) then
					x1 = ls_template.margine_sx + li_ampl_pie + 100
					y1 = li_pag_y - ls_template.margine_bottom - li_amp_pie +50
					PrintText(job,ls_note_pie,3.94*x1,3.94*y1,2)
				else
					ls_temp=ls_note_pie
					li_amp_testo=f_calc_larghezza_testo(job,ls_car_rditta,35,ls_temp)
					if li_amp_testo<>-1 then
						
						if (li_pag_x - ls_template.margine_sx - li_logo_pie_msx - li_logo_pie_amp_x - 100 - ls_template.margine_dx)<li_amp_testo then
							ld_app=(li_pag_x - ls_template.margine_sx - li_logo_msx - li_logo_amp_x - 100 - ls_template.margine_dx)/li_amp_testo	
							ld_app=int(Len(ls_temp)*ld_app)								
							ls_temp=Left(ls_temp,ld_app)
						end if
						x1= ls_template.margine_sx + li_logo_pie_msx + li_logo_pie_amp_x + 100
						y1= li_pag_y - ls_template.margine_bottom - li_amp_pie +50
						PrintText(job,ls_temp,3.94*x1,3.94*y1,2)
					end if
				end if
			end if
	
			
			if lc_num_pag_pie='S' then
				ls_temp=string(Today(),"dd/mm/yy")+' - Stampa Catalogo '+ls_nome_catalogo+' - Pagina '+string(conta_pag)+&
							+' di '+string(num_pag)
				li_alt_testo=35
				li_amp_testo=f_calc_larghezza_testo(job,ls_car_rditta,li_alt_testo,ls_temp)
				if li_amp_testo<>-1 then
					x1=li_pag_x - ls_template.margine_dx - li_amp_testo
					y1=li_pag_y - ls_template.margine_bottom - li_amp_pie + 10
					PrintDefineFont(job,3,ls_car_rditta,li_alt_testo*3.94,400,Default!,AnyFont!,false,false)
					PrintText(job,ls_temp,3.94*x1,3.94*y1,3)
				end if
			end if
		end if		
					
		if upperbound(ls_bitmap)>0 then
			for num_imm=1 to upperbound(ls_bitmap)
				ole_imm.object.loadimage=ls_bitmap[num_imm].nome
				if ls_bitmap[num_imm].tagliata then
					ole_imm.object.ImageRectLeft=ls_bitmap[num_imm].rect_x1
					ole_imm.object.ImageRectTop=ls_bitmap[num_imm].rect_y1
					ole_imm.object.ImageRectRight=ls_bitmap[num_imm].rect_x2
					ole_imm.object.ImageRectBottom=ls_bitmap[num_imm].rect_y2
					ole_imm.object.CropImage=true
				end if
				ole_imm.object.printtop=ls_bitmap[num_imm].y1
				ole_imm.object.printleft=ls_bitmap[num_imm].x1
				ole_imm.object.printbottom=ls_bitmap[num_imm].y2
				ole_imm.object.printright=ls_bitmap[num_imm].x2
				if ls_bitmap[num_imm].trasparente then ole_imm.object.transparent=2
				ole_imm.object.printimage=myDC						
			next
			ls_bitmap=ls_bitmap_vuota
		end if
		
		
		if ll_id_pagina<>1 then 
			ll_riga=ll_riga+(li_art_x*li_art_y_altre)
			conta_pag++
		end if
		if ll_riga>ll_num_righe then exit
		
		if conta_pag<num_pag then
			PrintPage(job)
		end if
	next
	
	
	if ll_id_pagina=2 then
		if ll_id_catalogo=1 then
			
			DeleteObject(ll_penna_riquadro)
			DeleteObject(ll_penna_noimm)
			PrintClose(job)
			li_ret=DeleteDc(mydc)							
			messagebox('Stampa Catalogo '+ls_nome_catalogo,'Stampa pagine dispari completata'+char(13)+&
							+"Premendo 'Ok' si avvierà la stampa delle pagine pari")
	
			

			job=PrintOpen()
			myDC=PRP_GetDC(job)
			ole_imm.object.printsize=6
			ll_penna_riquadro=CreatePen(0,10,rgb(ll_red,ll_green,ll_blue))
			ll_penna_noimm=CreatePen(0,10,rgb(255,0,0))
			ll_riga=(li_art_x*li_art_y_prima) + 1
			li_temp=ls_template.margine_sx
			ls_template.margine_sx=ls_template.margine_dx
			ls_template.margine_dx=li_temp
		end if
		ll_id_catalogo++
	end if
loop until((ll_id_pagina=2)and(ll_id_catalogo=3))or(ll_id_pagina=1)


DeleteObject(ll_penna_riquadro)
DeleteObject(ll_penna_noimm)
PrintClose(job)
li_ret=DeleteDc(mydc)
ll_num_righe=tab_1.tabpage_3.ddlb_art_senza_foto.totalitems()
tab_1.tabpage_3.sle_1.text=string(ll_num_righe)
messagebox("Informazione", "Stampa Terminata!")
end subroutine

public function integer wf_leggo_dati_testa_piede (long ll_id_catalogo, string ls_nome_catalogo, ref integer li_ampt, ref integer li_ampl, ref string ls_car_ditta, ref string ls_car_rditta, ref character lc_num_pag, ref integer li_logo_mtop, ref integer li_logo_msx, ref integer li_logo_amp_x, ref integer li_logo_amp_y, ref character lc_stampa_righe_az, ref integer li_amp_pie, ref integer li_logo_pie_mtop, ref integer li_logo_pie_msx, ref integer li_logo_pie_amp_x, ref integer li_logo_pie_amp_y, ref character lc_num_pag_pie, ref string ls_note_pie, ref string ls_logo_pie, ref integer li_ampl_pie);select nome, amp_testa, amp_logo, car_ditta, car_righe_ditta, num_pag, 
			logo_mtop, logo_msx, logo_amp_x, logo_amp_y, righe_azienda, 
			amp_piede, logo_piede_mtop, logo_piede_msx, logo_piede_amp_x, logo_piede_amp_y, 
			num_pag_piede, note_piede, imm_piede, amp_logo_piede
into :ls_nome_catalogo, :li_ampt, :li_ampl, :ls_car_ditta, :ls_car_rditta, :lc_num_pag,
			: li_logo_mtop, :li_logo_msx, :li_logo_amp_x, :li_logo_amp_y, :lc_stampa_righe_az,
			 :li_amp_pie, :li_logo_pie_mtop, :li_logo_pie_msx, :li_logo_pie_amp_x, :li_logo_pie_amp_y, 
			:lc_num_pag_pie, :ls_note_pie, :ls_logo_pie, :li_ampl_pie
	from s_catalogo
	where id_catalogo=:ll_id_catalogo;
	
if isnull(li_logo_msx) then li_logo_msx=0	
if isnull(li_logo_amp_x) then li_logo_amp_x=0	

if sqlca.sqlcode<>0 then
	return 0
else
	return 1
end if

		
end function

public subroutine wf_trova_misure_e_risoluzione_foto (string ls_nome_immagine, ref integer alt, ref integer lar, ref long ll_img_dpi_x, ref long ll_img_dpi_y);
if ls_nome_immagine>'' then
	if fileexists(ls_nome_immagine) then
		ole_imm.object.loadimage=ls_nome_immagine
		
		alt=ole_imm.object.imageHeight
		lar=ole_imm.object.imagewidth
		
		ll_img_dpi_x = ole_imm.object.imageXDpi
		
		if isnull(ll_img_dpi_x) or (ll_img_dpi_x = 0) then ll_img_dpi_x = 72
		
		ll_img_dpi_y = ole_imm.object.imageYDpi
		
		if isnull(ll_img_dpi_y) or (ll_img_dpi_y = 0) then ll_img_dpi_y = 72						
		
		alt=(alt/ll_img_dpi_y)*254
		lar=(lar/ll_img_dpi_x)*254
	else
		tab_1.tabpage_3.ddlb_art_senza_foto.additem(ls_nome_immagine)
		alt=381     
		lar=381 
	end if
else	
	tab_1.tabpage_3.ddlb_art_senza_foto.additem(ls_nome_immagine)
	alt=381     
	lar=381 
end if
end subroutine

public subroutine wf_valori_azienda (ref string ls_codice, ref string ls_rag_soc_1, ref string ls_par_iva, ref string ls_cod_fiscale, ref string ls_cciaa, ref string ls_trib_iscrizione, ref decimal ld_tot_capitale, ref string ls_logo, ref string ls_img_dir, ref string ls_nota_azienda, ref string ls_indirizzo, ref string ls_cap, ref string ls_localita, ref string ls_provincia, ref string ls_nazione);
SELECT "azienda"."codice", "azienda"."rag_soc_1", 
		"azienda"."par_iva", "azienda"."cod_fiscale", "azienda"."cciaa", 
		"azienda"."trib_iscrizione", "azienda"."tot_capitale", 
		"azienda"."logo", note, indirizzo, cap, localita, provincia, nazione
INTO :ls_codice, :ls_rag_soc_1, 
:ls_par_iva, :ls_cod_fiscale, :ls_cciaa, 
:ls_trib_iscrizione, :ld_tot_capitale, 
:ls_logo, :ls_nota_azienda, :ls_indirizzo, :ls_cap, :ls_localita, :ls_provincia, :ls_nazione
FROM "azienda", sede
WHERE "azienda"."id_azienda" = 1
and azienda.id_azienda=sede.id_azienda
and sede.tipo_sede='L';

if isnull(ls_indirizzo) then ls_indirizzo="" 
if isnull(ls_cap) then ls_cap="" 
if isnull(ls_localita) then ls_localita="" 
if isnull(ls_provincia) then ls_provincia="" 
if isnull(ls_nazione) then ls_nazione="" 


SELECT "par_sistema"."dir_immagini"  
INTO :ls_img_dir  
FROM "dba"."par_sistema"  
WHERE "par_sistema"."id_azienda" = 1;
end subroutine

public function string wf_ricerca (long row, string as_codice);long ll_id_sog
s_ric_param ls_ric_param
w_search_main lw_sm
ls_ric_param.s_filter_value=as_codice
ls_ric_param.s_filter_name="articolo_codice"
openwithparm(lw_sm,ls_ric_param,"w_articolo_coddes_sw")
ls_ric_param=message.powerobjectparm
if upperbound(ls_ric_param.s_id_seg_value)>0 then
	return ls_ric_param.s_main_value
else
	return ""
end if
end function

on w_catalogo_cx.create
this.ole_imm=create ole_imm
this.cb_salva=create cb_salva
this.cb_1=create cb_1
this.cb_formati=create cb_formati
this.cb_ok=create cb_ok
this.cb_annulla=create cb_annulla
this.tab_1=create tab_1
this.Control[]={this.ole_imm,&
this.cb_salva,&
this.cb_1,&
this.cb_formati,&
this.cb_ok,&
this.cb_annulla,&
this.tab_1}
end on

on w_catalogo_cx.destroy
destroy(this.ole_imm)
destroy(this.cb_salva)
destroy(this.cb_1)
destroy(this.cb_formati)
destroy(this.cb_ok)
destroy(this.cb_annulla)
destroy(this.tab_1)
end on

event open;tab_1.tabpage_1.dw_catalogo.SetTransObject(sqlca)
tab_1.tabpage_1.dw_riga_catalogo.SetTransObject(sqlca)
tab_1.tabpage_1.dw_catalogo.retrieve()
is_sql_old=tab_1.tabpage_3.dw_1.getsqlselect()
end event

type ole_imm from olecustomcontrol within w_catalogo_cx
event paintevent ( )
event selectevent ( long lplleft,  long lpltop,  long lplright,  long lplbottom )
event statusevent ( long lppercent )
event click ( )
event dblclick ( )
event keydown ( integer keycode,  integer shift )
event keypress ( integer keyascii )
event keyup ( integer keycode,  integer shift )
event mousedown ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mousemove ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mouseup ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event scroll ( long scrolltype )
event errorevent ( integer nerrcount )
event thumbnail ( string filename,  long page )
event tag ( integer tagid,  integer tagtype,  long tagsize,  integer wordval,  long longval,  string strval )
event thumbtitle ( string title,  integer page )
boolean visible = false
integer x = 73
integer y = 8
integer width = 233
integer height = 108
integer taborder = 20
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_catalogo_cx.win"
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
end type

type cb_salva from commandbutton within w_catalogo_cx
integer x = 1673
integer y = 32
integer width = 288
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salva"
end type

event clicked;integer li_ret

li_ret=tab_1.tabpage_1.dw_catalogo.AcceptText()
if li_ret>0 then 
	if tab_1.tabpage_1.dw_catalogo.Update(true,true)>0 then
		commit;
	else
		messagebox("Errore", "Catalogo non salvato!")
		rollback;
	end if
end if

li_ret=tab_1.tabpage_1.dw_riga_catalogo.AcceptText()
if li_ret>0 then 
	if tab_1.tabpage_1.dw_riga_catalogo.Update(true,true)>0 then
		commit;
	else
		messagebox("Errore", "Catalogo non salvato!")
		rollback;
	end if
end if
end event

type cb_1 from commandbutton within w_catalogo_cx
integer x = 905
integer y = 32
integer width = 288
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Formule"
end type

event clicked;datawindowchild d_id_formula

Open(w_formula_lt)

tab_1.tabpage_1.dw_riga_catalogo.GetChild("id_formula",d_id_formula)
d_id_formula.SetTransObject(sqlca)
d_id_formula.Retrieve()

end event

type cb_formati from commandbutton within w_catalogo_cx
integer x = 553
integer y = 32
integer width = 288
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Formati"
end type

event clicked;datawindowchild d_id_template

Open(w_testi_cx)

tab_1.tabpage_1.dw_riga_catalogo.GetChild("id_template",d_id_template)
d_id_template.SetTransObject(sqlca)
d_id_template.Retrieve()

end event

type cb_ok from commandbutton within w_catalogo_cx
integer x = 2395
integer y = 32
integer width = 256
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ok"
end type

event clicked;cb_salva.TriggerEvent(clicked!)
close(parent)
end event

type cb_annulla from commandbutton within w_catalogo_cx
integer x = 2080
integer y = 32
integer width = 288
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Annulla"
end type

event clicked;close(parent)
end event

type tab_1 from tab within w_catalogo_cx
event create ( )
event destroy ( )
integer x = 37
integer y = 124
integer width = 2647
integer height = 1480
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 80269524
boolean raggedright = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_3 tabpage_3
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_3=create tabpage_3
this.Control[]={this.tabpage_1,&
this.tabpage_3}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_3)
end on

event selectionchanged;if newindex=2 then
	tab_1.tabpage_3.cb_articoli.enabled=true
end if
if newindex<>2 then
	tab_1.tabpage_3.cb_articoli.enabled=false
end if

end event

event selectionchanging;string ls_formula, LS_SQL
long ll_riga, ll_id_formula
integer li_ret

choose case newindex
	case 2
		
		
		ll_riga=tab_1.tabpage_1.dw_riga_catalogo.getrow()
		if ll_riga<=0 then
			messagebox("Errore!", "Non esiste riga di catalogo: inserirla!")
			return 1
		end if
		ll_id_formula=tab_1.tabpage_1.dw_riga_catalogo.GetItemNumber(ll_riga,"id_formula")
		ls_formula=wf_componi_formula(ll_id_formula)
		
		
		
		ls_sql=is_sql_old+"and "+ls_formula
		li_ret=tab_1.tabpage_3.dw_1.setsqlselect(ls_sql)
		if li_ret<>1 then
			messagebox("Errore", "Formula non assegnata")
		else
			tab_1.tabpage_3.dw_1.reset()
			tab_1.tabpage_3.dw_1.SetTransObject(sqlca)
			
			
			tab_1.tabpage_3.dw_1.Retrieve()
		end if
		
		case 1
			
			if tab_1.tabpage_3.cb_articoli.underline=true then
				ll_riga=messagebox("Attenzione!", "Se torni alla prima pagina cancelli la lista attuale di articoli da stampare.~r~n"&
							+"Vuoi tornare alla pagina uno ugualmente?", stopsign!,yesno! ) 
				if ll_riga=2 then
					return 1
				else
					tab_1.tabpage_3.cb_articoli.underline=false
				end if
			end if
end choose
end event

type tabpage_1 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 104
integer width = 2610
integer height = 1360
long backcolor = 79741120
string text = "Catalogo"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_catalogo dw_catalogo
dw_riga_catalogo dw_riga_catalogo
cb_nuovo_cat cb_nuovo_cat
cb_elimina_cat cb_elimina_cat
cb_modifica_testa cb_modifica_testa
cb_3 cb_3
cb_nuovo_tipo cb_nuovo_tipo
cb_elimina_tipo cb_elimina_tipo
gb_1 gb_1
gb_2 gb_2
end type

on tabpage_1.create
this.dw_catalogo=create dw_catalogo
this.dw_riga_catalogo=create dw_riga_catalogo
this.cb_nuovo_cat=create cb_nuovo_cat
this.cb_elimina_cat=create cb_elimina_cat
this.cb_modifica_testa=create cb_modifica_testa
this.cb_3=create cb_3
this.cb_nuovo_tipo=create cb_nuovo_tipo
this.cb_elimina_tipo=create cb_elimina_tipo
this.gb_1=create gb_1
this.gb_2=create gb_2
this.Control[]={this.dw_catalogo,&
this.dw_riga_catalogo,&
this.cb_nuovo_cat,&
this.cb_elimina_cat,&
this.cb_modifica_testa,&
this.cb_3,&
this.cb_nuovo_tipo,&
this.cb_elimina_tipo,&
this.gb_1,&
this.gb_2}
end on

on tabpage_1.destroy
destroy(this.dw_catalogo)
destroy(this.dw_riga_catalogo)
destroy(this.cb_nuovo_cat)
destroy(this.cb_elimina_cat)
destroy(this.cb_modifica_testa)
destroy(this.cb_3)
destroy(this.cb_nuovo_tipo)
destroy(this.cb_elimina_tipo)
destroy(this.gb_1)
destroy(this.gb_2)
end on

type dw_catalogo from datawindow within tabpage_1
integer x = 64
integer y = 76
integer width = 2048
integer height = 552
integer taborder = 50
string dataobject = "d_s_catalogo_gd"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;long ll_id_catalogo
if row>0 then 
	wf_sel_riga(this,row)
	ll_id_catalogo=GetItemNumber(row,"id_catalogo")
	dw_riga_catalogo.Retrieve(ll_id_catalogo)
end if

end event

event retrieveend;long ll_id_catalogo
if rowcount>0 then 
	wf_sel_riga(this,1)
	ll_id_catalogo=GetItemNumber(1,"id_catalogo")
	dw_riga_catalogo.Retrieve(ll_id_catalogo)
end if
end event

type dw_riga_catalogo from datawindow within tabpage_1
integer x = 69
integer y = 760
integer width = 2048
integer height = 524
integer taborder = 40
string dataobject = "d_s_riga_catalogo_gd"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;if row>0 then
	wf_sel_riga(this,row)
end if
 
end event

event doubleclicked;long ll_formula, ll_template
datawindowchild d_id_formula, d_id_template
string ls_formula_des
s_testo ls_testo_parm		

if row>0 then
	choose case dwo.name
		case "id_template"
			ll_template=this.GetItemNumber(row,"id_template")
			OpenWithParm(w_testi_cx,ll_template)
			ll_template=message.DoubleParm
			if ll_template>0 then
				this.GetChild("id_template",d_id_template)
				d_id_template.SetTransObject(sqlca)
				d_id_template.Retrieve()
	
	
	
	
				this.SetItem(row,"id_template",ll_template)
			end if
		case "id_formula"
			ll_formula=this.GetItemNumber(row,"id_formula")
			OpenWithParm(w_formula_lt,ll_formula)
			ll_formula=message.DoubleParm
			if ll_formula>0 then
				this.GetChild("id_formula",d_id_formula)
				d_id_formula.SetTransObject(sqlca)
				d_id_formula.Retrieve()
	
	
	
	
				this.SetItem(row,"id_formula",ll_formula)
			end if
		case "red", "green", "blue"
			ls_testo_parm.red=this.GetItemNumber(row,"red")
			ls_testo_parm.green=this.GetItemNumber(row,"green")
			ls_testo_parm.blue=this.GetItemNumber(row,"blue")
			OpenWithParm(w_colori_cx, ls_testo_parm)
			ls_testo_parm=message.PowerObjectParm
			if Not(IsNull(ls_testo_parm.red)) then this.SetItem(row,"red",ls_testo_parm.red)
			if Not(IsNull(ls_testo_parm.green)) then this.SetItem(row,"green",ls_testo_parm.green)
			if Not(IsNull(ls_testo_parm.blue)) then this.SetItem(row,"blue",ls_testo_parm.blue)			
	end choose
end if
	
end event

event itemchanged;choose case dwo.name
	case 's_pagina_riquadro'
		choose case data
			case 'S'
				SetItem(row,"red",0)
				SetItem(row,"green",0)
				SetItem(row,"blue",0)
			case 'N'
				long ll_null
				
				SetNull(ll_null)
				SetItem(row,"red",ll_null)
				SetItem(row,"green",ll_null)
				SetItem(row,"blue",ll_null)
		end choose
end choose
end event

event retrieveend;if rowcount>0 then 
	wf_sel_riga(this,1)
end if
end event

type cb_nuovo_cat from commandbutton within tabpage_1
integer x = 2158
integer y = 76
integer width = 320
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Nuovo"
end type

event clicked;long ll_riga

ll_riga=dw_catalogo.InsertRow(0)
dw_catalogo.SetRow(ll_riga)
dw_catalogo.ScrollToRow(ll_riga)
dw_catalogo.SetColumn("s_catalogo_nome")
dw_catalogo.SetItem(ll_riga,"amp_testa",450)
dw_catalogo.SetItem(ll_riga,"amp_logo",350)
dw_catalogo.SetItem(ll_riga,"car_ditta","Arial")
dw_catalogo.SetItem(ll_riga,"car_righe_ditta","Times New Roman")
dw_catalogo.SetItem(ll_riga,"num_pag",'S')
end event

type cb_elimina_cat from commandbutton within tabpage_1
integer x = 2158
integer y = 232
integer width = 320
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Elimina"
end type

event clicked;long ll_riga, ll_id_catalogo

ll_riga=dw_catalogo.GetRow()
if ll_riga>0 then
	dw_catalogo.DeleteRow(ll_riga)
	dw_riga_catalogo.Reset()
	ll_riga=dw_catalogo.RowCount()
	if ll_riga>0 then
		wf_sel_riga(dw_catalogo,1)
		ll_id_catalogo=dw_catalogo.getItemNumber(1,"id_catalogo")
		dw_riga_catalogo.Retrieve(ll_id_catalogo)
	end if
end if
end event

type cb_modifica_testa from commandbutton within tabpage_1
integer x = 2158
integer y = 392
integer width = 320
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Testata"
end type

event clicked;long ll_riga, ll_id_catalogo

ll_riga=dw_catalogo.getRow()
ll_id_catalogo=dw_catalogo.getItemNumber(ll_riga,"id_catalogo")
OpenWithParm(w_testata_ff,ll_id_catalogo)
end event

type cb_3 from commandbutton within tabpage_1
integer x = 2158
integer y = 540
integer width = 320
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Piè di pag."
end type

event clicked;long ll_riga, ll_id_catalogo

ll_riga=dw_catalogo.getRow()
ll_id_catalogo=dw_catalogo.getItemNumber(ll_riga,"id_catalogo")
OpenWithParm(w_piede_ff,ll_id_catalogo)
end event

type cb_nuovo_tipo from commandbutton within tabpage_1
integer x = 2162
integer y = 940
integer width = 320
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Nuovo"
end type

event clicked;long ll_riga, ll_id_catalogo

ll_riga=dw_catalogo.AcceptText()
if ll_riga>0 then dw_catalogo.Update(true,true)

ll_id_catalogo=dw_catalogo.GetItemNumber(dw_catalogo.GetRow(),"id_catalogo")
ll_riga=dw_riga_catalogo.InsertRow(0)
dw_riga_catalogo.SetRow(ll_riga)
dw_riga_catalogo.ScrollToRow(ll_riga)
dw_riga_catalogo.SetItem(ll_riga,"id_catalogo",ll_id_catalogo)
end event

type cb_elimina_tipo from commandbutton within tabpage_1
integer x = 2162
integer y = 1084
integer width = 320
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Elimina"
end type

event clicked;long ll_riga

ll_riga=dw_riga_catalogo.GetRow()
if ll_riga>0 then
	dw_riga_catalogo.DeleteRow(ll_riga)
end if
end event

type gb_1 from groupbox within tabpage_1
integer x = 23
integer y = 4
integer width = 2496
integer height = 660
integer taborder = 10
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Cataloghi"
end type

type gb_2 from groupbox within tabpage_1
integer x = 27
integer y = 684
integer width = 2496
integer height = 636
integer taborder = 40
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Tipi del catalogo selezionato"
end type

type tabpage_3 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 104
integer width = 2610
integer height = 1360
long backcolor = 79741120
string text = "Stampa"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
cb_articoli cb_articoli
cb_canc_articolo cb_canc_articolo
sle_1 sle_1
st_art_senza_foto st_art_senza_foto
cb_stampa_lista cb_stampa_lista
ddlb_art_senza_foto ddlb_art_senza_foto
st_1 st_1
rb_vert rb_vert
rb_oriz rb_oriz
dw_1 dw_1
cb_preview cb_preview
cb_2 cb_2
cb_stampa cb_stampa
gb_3 gb_3
end type

on tabpage_3.create
this.cb_articoli=create cb_articoli
this.cb_canc_articolo=create cb_canc_articolo
this.sle_1=create sle_1
this.st_art_senza_foto=create st_art_senza_foto
this.cb_stampa_lista=create cb_stampa_lista
this.ddlb_art_senza_foto=create ddlb_art_senza_foto
this.st_1=create st_1
this.rb_vert=create rb_vert
this.rb_oriz=create rb_oriz
this.dw_1=create dw_1
this.cb_preview=create cb_preview
this.cb_2=create cb_2
this.cb_stampa=create cb_stampa
this.gb_3=create gb_3
this.Control[]={this.cb_articoli,&
this.cb_canc_articolo,&
this.sle_1,&
this.st_art_senza_foto,&
this.cb_stampa_lista,&
this.ddlb_art_senza_foto,&
this.st_1,&
this.rb_vert,&
this.rb_oriz,&
this.dw_1,&
this.cb_preview,&
this.cb_2,&
this.cb_stampa,&
this.gb_3}
end on

on tabpage_3.destroy
destroy(this.cb_articoli)
destroy(this.cb_canc_articolo)
destroy(this.sle_1)
destroy(this.st_art_senza_foto)
destroy(this.cb_stampa_lista)
destroy(this.ddlb_art_senza_foto)
destroy(this.st_1)
destroy(this.rb_vert)
destroy(this.rb_oriz)
destroy(this.dw_1)
destroy(this.cb_preview)
destroy(this.cb_2)
destroy(this.cb_stampa)
destroy(this.gb_3)
end on

type cb_articoli from commandbutton within tabpage_3
integer x = 672
integer y = 1180
integer width = 503
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ins. Articoli Manuale"
end type

event clicked;integer li_row
li_row=dw_1.insertrow(0)
dw_1.scrolltorow(li_row)
dw_1.setcolumn("articolo_codice")
cb_articoli.underline=true


end event

type cb_canc_articolo from commandbutton within tabpage_3
integer x = 50
integer y = 1180
integer width = 503
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancella Articolo"
end type

event clicked;integer li_row

li_row=dw_1.getrow()
if li_row>0 then
	if messagebox("Attenzione!", "Sei sicuro di voler cancellare l'articolo corrente?",&
				stopsign!, yesno!)=1 then
			dw_1.deleterow(li_row)
	end if
end if
end event

type sle_1 from singlelineedit within tabpage_3
integer x = 2363
integer y = 940
integer width = 229
integer height = 76
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type st_art_senza_foto from statictext within tabpage_3
integer x = 2021
integer y = 940
integer width = 434
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
string text = "Tot. senza foto:"
boolean focusrectangle = false
end type

type cb_stampa_lista from commandbutton within tabpage_3
integer x = 2025
integer y = 1020
integer width = 571
integer height = 80
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stampa lista ~'senza foto~'"
end type

event clicked;long Job

Job = PrintOpen( )
ddlb_art_senza_foto.Print(Job, 500,1000)
PrintClose(Job)
end event

type ddlb_art_senza_foto from listbox within tabpage_3
integer x = 2030
integer y = 68
integer width = 562
integer height = 852
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within tabpage_3
integer x = 2034
integer width = 562
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
string text = "Lista articoli senza foto:"
boolean focusrectangle = false
end type

type rb_vert from radiobutton within tabpage_3
integer x = 1289
integer y = 1228
integer width = 338
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Verticale"
boolean checked = true
boolean lefttext = true
end type

type rb_oriz from radiobutton within tabpage_3
integer x = 1289
integer y = 1164
integer width = 338
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Orizzontale"
boolean lefttext = true
end type

event clicked;if checked then messagebox('Attenzione!!','Ricordarsi di verificare che la stampante sia impostata per la stampa in orizzontale')
end event

type dw_1 from datawindow within tabpage_3
event ue_key pbm_dwnkey
integer x = 32
integer y = 36
integer width = 1970
integer height = 1052
integer taborder = 50
string dataobject = "d_sel_stampa_gd"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_key;choose case key
	case KeyS!, keyf12!
		if keyflags=2 then
			cb_salva.triggerevent(clicked!)
		end if
	case Keydownarrow!
		if getrow()=rowcount()and keyflags=2 then
			cb_salva.triggerevent(clicked!)
		end if
	case KeyAdd!
		if keyflags=2 then
			cb_articoli.triggerevent(clicked!)
		end if
	case KeyDelete!,KeySubtract!
		if keyflags=2 then
			cb_canc_articolo.triggerevent(clicked!)
		end if
	case KeyPrintScreen!
		cb_stampa.triggerevent(clicked!)
	case KeyP!
		if keyflags=2 then
			cb_stampa.triggerevent(clicked!)
		end if
	case KeyX!
		if keyflags=2 then
			cb_annulla.triggerevent(clicked!)
		end if
	case keyenter!
		cb_articoli.triggerevent(clicked!)
end choose

end event

event retrievestart;return 2
end event

event itemchanged;datastore ds_aggiungi
long ll_riga, ll_id_formula, ll_id_variazione
string ls_sql, ls_codice_art

if dwo.name="articolo_codice" then
	ll_riga=tab_1.tabpage_1.dw_riga_catalogo.getrow()
	ll_id_formula=tab_1.tabpage_1.dw_riga_catalogo.GetItemNumber(ll_riga,"id_formula")
	select id_variazione
	into :ll_id_variazione
	from s_formula
	where id_formula=:ll_id_formula
	;
	if isnull(ll_id_variazione) or ll_id_variazione=0 then
		messagebox("Attenzione!", "La formula corrente manca del listino! ~r~nSarà utilizzato il listino base di vendita!")
		select id_variazione
		into :ll_id_variazione
		from listino l, variazione v
		where l.id_listino=v.id_listino
		and l.lis_base='S' and l.tipo='V'
		and v.data_inizio <=today() 
		and (v.data_fine>=today() or v.data_fine=null)
		;
	end if
	
	select codice
	into :ls_codice_art
	from articolo
	where codice=:data;
	if isnull(ls_codice_art) or ls_codice_art ="" then
		ls_codice_art=wf_ricerca(row, data)
		if ls_codice_art="" then 
			post setitem(row, dwo.name, "")
			post setcolumn("articolo_codice")
			return
		end if
	end if
		
	
	
	
	
	ds_aggiungi=creAte DATASTORE
	ds_aggiungi.dataobject="d_sel_stampa_gd"
	ds_aggiungi.settransobject(sqlca)
	ls_sql=ds_aggiungi.getsqlselect()
	
	ls_sql +=  " and prezzo.id_variazione = "+string(ll_id_variazione)
	ls_sql +=  " and articolo.codice = '"+ls_codice_art+"'"
	ds_aggiungi.setsqlselect(ls_sql)
	ds_aggiungi.retrieve()
	ds_aggiungi.rowscopy(1, 1, primary!, this, row+1, primary!)
	deleterow(row)
	
	
	
end if
end event

event rowfocuschanged;setrowfocusindicator(hand!)
end event

type cb_preview from commandbutton within tabpage_3
boolean visible = false
integer x = 329
integer y = 1588
integer width = 384
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Preview"
end type

event clicked;

end event

type cb_2 from commandbutton within tabpage_3
integer x = 1687
integer y = 1192
integer width = 384
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Riassumi"
end type

event clicked;long ll_riga, ll_ret

integer li_pag_x=2100, li_pag_y=2970

s_prev_parm ls_parm

ll_ret=tab_1.tabpage_1.dw_catalogo.AcceptText()
if ll_ret<0 then return
ll_ret=tab_1.tabpage_1.dw_riga_catalogo.AcceptText()
if ll_ret<0 then return

ll_riga=tab_1.tabpage_1.dw_catalogo.GetRow()
ls_parm.id_catalogo=tab_1.tabpage_1.dw_catalogo.GetItemNumber(ll_riga,"id_catalogo")
ls_parm.id_lingua=tab_1.tabpage_1.dw_catalogo.GetItemNumber(ll_riga,"id_lingua")
ll_riga=tab_1.tabpage_1.dw_riga_catalogo.GetRow()
ls_parm.id_pagina=tab_1.tabpage_1.dw_riga_catalogo.GetItemNumber(ll_riga,"id_pagina")

ls_parm.pag_x=li_pag_x
ls_parm.pag_y=li_pag_y

OpenWithParm(w_riassumi_stampa_cx,ls_parm)

end event

type cb_stampa from commandbutton within tabpage_3
integer x = 2158
integer y = 1176
integer width = 384
integer height = 112
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stampa"
end type

event clicked;integer li_ret
li_ret=tab_1.tabpage_1.dw_catalogo.AcceptText()
if li_ret<0 then 
	messagebox("Errore", "Dati non accettabili1")
	return
end if
li_ret=tab_1.tabpage_1.dw_riga_catalogo.AcceptText()
if li_ret<0 then 
	messagebox("Errore", "Dati non accettabili2")
	return
end if
li_ret=tab_1.tabpage_3.dw_1.AcceptText()
if li_ret<0 then 
	messagebox("Errore", "Dati non accettabili3")
	return
end if
wf_stampa_catalogo()
end event

type gb_3 from groupbox within tabpage_3
integer x = 1230
integer y = 1112
integer width = 1358
integer height = 212
integer taborder = 40
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Stampa"
end type

