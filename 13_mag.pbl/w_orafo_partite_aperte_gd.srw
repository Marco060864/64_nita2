forward
global type w_orafo_partite_aperte_gd from window
end type
type cb_deseleziona from commandbutton within w_orafo_partite_aperte_gd
end type
type cb_2 from commandbutton within w_orafo_partite_aperte_gd
end type
type cb_1 from commandbutton within w_orafo_partite_aperte_gd
end type
type dw_single from datawindow within w_orafo_partite_aperte_gd
end type
end forward

global type w_orafo_partite_aperte_gd from window
integer x = 320
integer y = 348
integer width = 3397
integer height = 988
boolean titlebar = true
string title = "Gestione Partite"
windowtype windowtype = response!
long backcolor = 79741120
event ue_post_open ( )
cb_deseleziona cb_deseleziona
cb_2 cb_2
cb_1 cb_1
dw_single dw_single
end type
global w_orafo_partite_aperte_gd w_orafo_partite_aperte_gd

type variables
s_orafo_partite s_dati_partita
DECIMAL{4} ld_qta_riaperta[], ll_id_partita_riaperta[],  ld_QTA_riaperta_ZOPPA[]
long  il_id_riga_scar[]
	


end variables

forward prototypes
public subroutine wf_riapri_partite_chiuse ()
public subroutine wf_qta_selezionata (long row)
public subroutine wf_ripristina_scarichi ()
public subroutine wf_ges_par_zoppe (string as_filtro)
public subroutine wf_riapri_partita_zoppa (long al_num_riga_scar, decimal ad_val_scarico, integer al_conta)
public function long wf_imposta_tipo_partita (long al_riga)
end prototypes

event ue_post_open();
dw_single.object.da_scaricare.text=string(s_dati_partita.s_ld_quantita_da_scaricare, "#,0.00")
dw_single.object.legato_da_scaricare.text=string(s_dati_partita.s_ld_quantita_legato, "#,0.00")

long ll_num_righe, ll_id_tit_1000[], ll_riga_trovata, ll_id_metallo
string ls_filtro, ls_cod_metallo
integer li_ret,  li_max, i, li_controllo_filtro
decimal{4} ld_qta_disponibile, ld_coef_calo, ld_titolo

ll_num_righe=s_dati_partita.s_dw_aper_partita.rowcount()

//ci sono carichi da scaricare
if ll_num_righe > 0 and not (isnull(s_dati_partita.s_dw_aper_partita.rowcount())) then
	//ricopio le righe di apertura nella finestra attuale
	li_ret=s_dati_partita.s_dw_aper_partita.rowscopy(1, s_dati_partita.s_dw_aper_partita.rowcount(),primary!, dw_single, 1, primary!)
	
	if li_ret<>1 then 
		messagebox("Errore", "Righe copiate: "+string(li_ret))
		s_dati_partita.s_ld_quantita_selezionata=0
		closewithreturn(this, s_dati_partita)
	end if
	
	if s_dati_partita.s_ll_id_titolo>0 then	
				
		select m.codice, m.id_metallo
		into :ls_cod_metallo, :ll_id_metallo
		from orafo_metallo m,  orafo_titolo t
		where t.id_titolo=:s_dati_partita.s_ll_id_titolo
		and m.id_metallo=t.id_metallo;
		if sqlca.sqlcode<>0 then
			messagebox("Errore", "Metallo non trovato!")
			return
		end if
		
		
		select titolo into :ld_titolo from orafo_titolo where id_titolo=:s_dati_partita.s_ll_id_titolo;
		if ld_titolo>=990 or s_dati_partita.s_scarica_ogni_titolo='S' then 
			//se scarico ogni titolo imposto il filtro largo
			ls_filtro="id_sog_commerciale="+string(s_dati_partita.s_ll_id_sog_com)+ &
			" and (metallo_codice='"+ls_cod_metallo+"')"
		else
			//altrimenti no
			declare cerca_titolo cursor for
			select id_titolo from orafo_titolo where (titolo<=1000 and titolo>=990) and id_metallo=:ll_id_metallo;
			
			open cerca_titolo;
			fetch cerca_titolo into :ll_id_tit_1000[1];
			
			i=1
			//i titoli comparabili a 1000 li prendo sempre
			do while ll_id_tit_1000[i]>0
					i++
					fetch cerca_titolo into :ll_id_tit_1000[i];
			loop
			close cerca_titolo;
			
			if upperbound(ll_id_tit_1000)>0  then
				ls_filtro="id_sog_commerciale="+string(s_dati_partita.s_ll_id_sog_com)+ &
				" and (metallo_codice='"+ls_cod_metallo+"')"+&
				" and (id_titolo="+string(s_dati_partita.s_ll_id_titolo)+&
				" or id_titolo="+string(ll_id_tit_1000[1])+")"
				i=0
				for i=2 to upperbound(ll_id_tit_1000)
					ls_filtro=left(ls_filtro, len(ls_filtro) - 1)
					ls_filtro=ls_filtro + " or id_titolo="+string(ll_id_tit_1000[i])+")"
				next	
			else
				
				ls_filtro="id_sog_commerciale="+string(s_dati_partita.s_ll_id_sog_com)+ &
				" and (metallo_codice='"+ls_cod_metallo+"')"+&
				" and id_titolo="+string(s_dati_partita.s_ll_id_titolo)
			end if
		
		end if
			
		if dw_single.rowcount()>0 then
			dw_single.setfilter(ls_filtro)
			li_controllo_filtro=dw_single.filter()
			if li_controllo_filtro<>1 then 
				messagebox("Errore!", "Filtro non valido! Contattare Assistenza!")
			end if
		end if
	else
		
	end if
		
	for i = 1 to dw_single.rowcount()
		if isnull(s_dati_partita.s_ld_coef_calo) then
			dw_single.setitem(i, "coef_calo", dw_single.getitemdecimal(i, "titolo"))
		else
			dw_single.setitem(i, "coef_calo", s_dati_partita.s_ld_coef_calo)
		end if
	next
		
else

end if
wf_riapri_partite_chiuse()
ls_filtro=ls_filtro+" and stato='A' and cod_tipo_partita = '"+ s_dati_partita.s_tipo_partita+"'"
if dw_single.rowcount()>0 then
	dw_single.setfilter(ls_filtro)
	li_ret=dw_single.filter()
	if li_ret<> 1 then messagebox("Errore", "Nel filtro")
end if

if dw_single.rowcount()<1 then
	messagebox("Attenzione!", "Non esistono partite da scaricare!")
	s_dati_partita.s_ld_quantita_selezionata=0
	closewithreturn(this, s_dati_partita)
	return
end if


if s_dati_partita.s_ld_quantita_da_scaricare=0 then
	open (w_input_box)
	s_dati_partita.s_ld_quantita_legato=message.doubleparm
	s_dati_partita.s_ld_quantita_da_scaricare=round(s_dati_partita.s_ld_quantita_legato*s_dati_partita.s_ld_coef_calo/1000, 2)  //20240430 aggiunto arrotondamento
	dw_single.object.da_scaricare.text=string(s_dati_partita.s_ld_quantita_da_scaricare, "#,0.00")
	dw_single.object.legato_da_scaricare.text=string(s_dati_partita.s_ld_quantita_legato, "#,0.00")
end if
integer  a
i=1
DO WHILE s_dati_partita.s_ld_quantita_da_scaricare>0 and i <= dw_single.rowcount()
	wf_qta_selezionata(i)
	i+=1
loop


if s_dati_partita.s_ld_quantita_da_scaricare > 0 then
	
	li_ret=messagebox("Attenzione!", "La quantità da scaricare ("+string(s_dati_partita.s_ld_quantita_da_scaricare)+") è superiore a quella disponibile~r~n"&
					+"Vuoi  scaricare la quantità disponibile?", stopsign!, yesno!)
		if li_ret=1 then
			ld_coef_calo=dw_single.getitemdecimal(1, "coef_calo")
			ld_qta_disponibile=dw_single.getitemdecimal(1,"fino_selezionato")
			s_dati_partita.s_ld_quantita_da_scaricare=ld_qta_disponibile
			dw_single.object.da_scaricare.text=string(ld_qta_disponibile, "#,0.00")
			ld_qta_disponibile=round( ld_qta_disponibile*1000/ld_coef_calo, 2)
			s_dati_partita.s_ld_quantita_legato=ld_qta_disponibile
			
			dw_single.object.legato_da_scaricare.text=string(ld_qta_disponibile, "#,0.00")
	
			dw_single.modify("datawindow.color=10140531")
	
			return
		else
			for a= (i - 1) to 1 step -1
				wf_qta_selezionata(a)
			next
			wf_ripristina_scarichi()
			if dw_single.rowcount()>0 then
				ld_coef_calo=dw_single.getitemdecimal(1, "coef_calo")
				ld_qta_disponibile=dw_single.getitemdecimal(1, "somma_fino_res")
				ld_qta_disponibile= ld_qta_disponibile*1000/ld_coef_calo
				messagebox("Attenzione!", "La quantità da scaricare è superiore a quella disponibile~r~n"&
								+"Selezionare una quantità inferiore o uguale a "&
								+string(ld_qta_disponibile))
			end if
			s_dati_partita.s_ld_quantita_selezionata=0
			closewithreturn(this, s_dati_partita)
			return
		end if
		
else //22-01-13 per gestire le partite in derivazione (la qta del carico basta per scaricare)
	//dw_single.modify("datawindow.color=10140531")
	//se l'istanza "s_dati_partita.s_i_partite_da_derivazione"=1 allora siamo in una gestione partita in derivazione
	//si deve chiudere automaticamente la finestra delle partite con un click sul bottone "scarica"
	if s_dati_partita.s_i_partite_da_derivazione=1 then
		cb_1.triggerevent(clicked!)
		return
	end if
end if
cb_1.setfocus()
end event

public subroutine wf_riapri_partite_chiuse ();
decimal{4} ld_val_scarico,  ld_val_scar[], ld_val_scarico_originale, ld_resto
integer li_riga_scarico, i, li_num_righe, li_ret, a
long ll_id_partita, ll_id_part[], ll_riga_trovata, ll_id_titolo, ll_id_riga_scar
string ls_stato

s_dati_partita.s_dw_scar_partita.setfilter&
("id_riga_documento="+string(s_dati_partita.s_ll_id_riga_partita))
li_riga_scarico=s_dati_partita.s_dw_scar_partita.filter()
if li_riga_scarico > 0 then
	li_num_righe=s_dati_partita.s_dw_scar_partita.rowcount()
	for i = li_num_righe to 1 step -1
		
		ld_val_scarico=s_dati_partita.s_dw_scar_partita.getitemdecimal(i, "val_scarico")
		
		ls_stato=s_dati_partita.s_dw_scar_partita.getitemstring(i, "stato")
		if isnull(ls_stato) then
			ll_id_partita=s_dati_partita.s_dw_scar_partita.getitemnumber(i, "id_partita")
			if not isnull(ll_id_partita) then
				ll_riga_trovata=s_dati_partita.s_dw_aper_partita.find&
				("id_partita="+string(ll_id_partita), 1, s_dati_partita.s_dw_aper_partita.rowcount())
			else
				ll_riga_trovata=s_dati_partita.s_dw_aper_partita.find&
				("id_titolo="+string(s_dati_partita.s_ll_id_titolo)&
				+" and id_documento="+string(s_dati_partita.s_id_documento)&
				+" and stato='Z'", 1, s_dati_partita.s_dw_aper_partita.rowcount())	
			end if
			ls_stato=s_dati_partita.s_dw_aper_partita.getitemstring&
				(ll_riga_trovata, "stato")
		end if
		ll_id_titolo=s_dati_partita.s_dw_scar_partita.getitemnumber(i, "id_titolo")
		if isnull(ls_stato) then 
			
		else 
			
		end if
		if ls_stato='Z' or ll_id_titolo=s_dati_partita.s_ll_id_titolo then
			wf_riapri_partita_zoppa(i, ld_val_scarico, li_num_righe)
			continue
		end if
		if ld_val_scarico<=0 then continue
		
		
		
		
		ll_id_partita=s_dati_partita.s_dw_scar_partita.getitemnumber(i, "id_partita")
		a=a+1
		
		
		ld_qta_riaperta[a]=ld_val_scarico
		ll_id_partita_riaperta[a]=ll_id_partita
		
		
		ll_riga_trovata=dw_single.find("id_partita="+string(ll_id_partita), 1, dw_single.rowcount())
		
		if ll_riga_trovata<1 then 
			
			exit
		end if
		ld_val_scarico_originale=dw_single.getitemdecimal(ll_riga_trovata, "val_scarico")

		
		
		
		select resto, id_riga_documento
		into :ld_resto, :ll_id_riga_scar
		from orafo_scar_partita
		where id_partita=:ll_id_partita
		and resto<>0
		and not(resto is null)
		;
		if sqlca.sqlcode=0 and s_dati_partita.s_ll_id_riga_partita<>ll_id_riga_scar then 
			il_id_riga_scar[i]=ll_id_riga_scar
		end if
		ld_val_scarico =(ld_val_scarico_originale  - ld_val_scarico) - ld_resto
		ld_resto=0
		
		li_ret=dw_single.setitem(ll_riga_trovata, "stato", 'A')
		if li_ret<>1 then messagebox("Set stato", "fallito set stato")
		
		
		ll_id_part[a]=ll_id_partita
		ld_val_scar[a]=ld_val_scarico

		
		
		
		s_dati_partita.s_dw_scar_partita.deleterow(i)
		
	next
	
end if
	
	for i = 1 to upperbound(ll_id_part)
		li_riga_scarico=dw_single.find("id_partita="+ string(ll_id_part[i]), 1, dw_single.rowcount())
		dw_single.setitem(li_riga_scarico, "val_scarico", ld_val_scar[i])
	next


end subroutine

public subroutine wf_qta_selezionata (long row);long  ll_id_partita, ll_riga_trovata
integer li_ret
decimal{4} ld_qta_selezionata, ld_qta_da_scaricare, ld_arrotonda, ld_resto
string ls_trova

	
ls_trova= dw_single.getitemstring(row, "stato")
if ls_trova= 'Z' or isnull(ls_trova) then 
	return
end if
ls_trova=""
if row > 0 then
	
	dw_single.SelectRow(Row, NOT dw_single.IsSelected(Row))
	
	ld_qta_da_scaricare=s_dati_partita.s_ld_quantita_da_scaricare
	if dw_single.IsSelected(Row) then
		ld_qta_selezionata = dw_single.getitemdecimal(row, "fino_residuo")
		if ld_qta_selezionata<= ld_qta_da_scaricare then 
			dw_single.setitem(row, "stato", 'C')
			
			
			
			ld_arrotonda=dw_single.getitemdecimal(row, "orafo_metallo_val_arrotondamento")
			if isnull(ld_arrotonda) then ld_arrotonda=0.1
			IF ld_qta_da_scaricare - ld_qta_selezionata <=ld_arrotonda THEN 
				
				ld_resto= (ld_qta_da_scaricare - ld_qta_selezionata)* - 1
				
				
				ld_qta_selezionata =ld_qta_da_scaricare
			END IF
		END IF
		if ld_qta_selezionata > ld_qta_da_scaricare then 
			
			ld_arrotonda=dw_single.getitemdecimal(row, "orafo_metallo_val_arrotondamento")
			if isnull(ld_arrotonda) then ld_arrotonda=0.1
			IF ld_qta_selezionata - ld_qta_da_scaricare <=ld_arrotonda THEN
		 
				dw_single.setitem(row, "stato", 'C')
				
				ld_resto=ld_qta_selezionata - ld_qta_da_scaricare 
				
			END IF	
			ld_qta_selezionata =ld_qta_da_scaricare
		END IF
		s_dati_partita.s_ld_quantita_da_scaricare =s_dati_partita.s_ld_quantita_da_scaricare - ld_qta_selezionata
		
		if s_dati_partita.s_ld_quantita_da_scaricare = 0 	then
			dw_single.modify("datawindow.color=10140531")
		end if
		
		
		
		dw_single.setitem(row, "qta_da_scaricare", ld_qta_selezionata)
		
		ld_qta_da_scaricare=dw_single.getitemdecimal(row, "val_scarico")
		
		if ld_qta_da_scaricare<0 then 
			messagebox("Errore!", "Lo scarico è negativo! Nessuna operazione completata!")
			return
		end if
		
		if isnull(ld_qta_da_scaricare) then ld_qta_da_scaricare=0
		
		
		ll_id_partita=dw_single.getitemnumber(row, "id_partita")
		if ll_id_partita<1 then messagebox("Attenzione!", "Partita non trovata!")
		
		ll_riga_trovata=s_dati_partita.s_dw_scar_partita.insertrow(0)							
		
		li_ret=s_dati_partita.s_dw_scar_partita.setitem(ll_riga_trovata, "id_riga_documento", s_dati_partita.s_ll_id_riga_partita)
		if li_ret<>1 then messagebox("Errore", "No id_riga_partita")
		
		li_ret=s_dati_partita.s_dw_scar_partita.setitem(ll_riga_trovata, "id_partita", ll_id_partita)
		if li_ret<>1 then messagebox("Errore", "No id_partita")
		
		
		li_ret=s_dati_partita.s_dw_scar_partita.setitem(ll_riga_trovata, "val_scarico", ld_qta_selezionata)
		if li_ret<>1 then messagebox("Errore", "No val_scarico")
		
		
		
		if ld_resto<>0 then
			li_ret=s_dati_partita.s_dw_scar_partita.setitem(ll_riga_trovata, "resto", ld_resto)
			if li_ret<>1 then messagebox("Errore", "No Resto")
		end if
		
		ld_resto=0
		
		
		
		
		
		ld_qta_selezionata+=ld_qta_da_scaricare
		
		dw_single.setitem(row, "val_scarico", ld_qta_selezionata)
	else
		
		ld_arrotonda=dw_single.getitemdecimal(row, "orafo_metallo_val_arrotondamento")
		if isnull(ld_arrotonda) then ld_arrotonda=0.1
		ld_qta_selezionata=dw_single.getitemdecimal(row, "qta_da_scaricare")
		s_dati_partita.s_ld_quantita_da_scaricare += ld_qta_selezionata
		if s_dati_partita.s_ld_quantita_da_scaricare<>0 then
			dw_single.modify("datawindow.color=12632256")
		end if
		ld_qta_selezionata=dw_single.getitemdecimal(row, "val_scarico") - ld_qta_selezionata
		if ld_qta_selezionata<0 - ld_arrotonda then
			messagebox("Errore!", "Il valore scaricato non può essere negativo: r.71,wf_qta_selezionata")
			return
		end if
		dw_single.setitem(row, "val_scarico", ld_qta_selezionata)
		dw_single.setitem(row, "qta_da_scaricare", 0)
		dw_single.setitem(row, "stato", 'A')
		
		
		ll_id_partita=dw_single.getitemnumber(row, "id_partita")
		if ll_id_partita<1 then messagebox("Attenzione!", "Partita non trovata!")
		ls_trova="id_partita="+string(ll_id_partita)+" and id_riga_documento="+string(s_dati_partita.s_ll_id_riga_partita)
		ll_riga_trovata=s_dati_partita.s_dw_scar_partita.find(ls_trova, 1,&
		s_dati_partita.s_dw_scar_partita.rowcount())
		if ll_riga_trovata < 1  then
			messagebox("Attenzione!", "Riga non trovata nella cancellazione scarichi")
		else
			s_dati_partita.s_dw_scar_partita.deleterow(ll_riga_trovata)
		end if
		
		
	end if
end if
end subroutine

public subroutine wf_ripristina_scarichi ();
integer i, li_ret
long ll_riga_trovata
for i = upperbound(ll_id_partita_riaperta) to 1 step -1
	ll_riga_trovata=s_dati_partita.s_dw_scar_partita.insertrow(0)
	li_ret=s_dati_partita.s_dw_scar_partita.setitem(ll_riga_trovata,&
						"id_riga_documento", s_dati_partita.s_ll_id_riga_partita)
	if li_ret<>1 then messagebox("Errore!", "Setitem fallito id_riga-doc")					
	li_ret=s_dati_partita.s_dw_scar_partita.setitem(ll_riga_trovata,&
						"id_partita", ll_id_partita_riaperta[i])
	if li_ret<>1 then messagebox("Errore!", "Setitem fallito id_partita")
	li_ret=s_dati_partita.s_dw_scar_partita.setitem(ll_riga_trovata,&
								"val_scarico", ld_qta_riaperta[i])
	if li_ret<>1 then messagebox("Errore!", "Setitem fallito val-scarico")
								
next
end subroutine

public subroutine wf_ges_par_zoppe (string as_filtro);
long ll_riga_trovata, ll_riga_trovata2, ll_id_tipo_partita
integer li_ret
decimal ld_qta_disponibile, ld_val_aper, ld_val_scar_originale
string ls_filtro



ll_riga_trovata=s_dati_partita.s_dw_aper_partita.find&
						("id_documento="+string(s_dati_partita.s_id_documento)+&
						" and id_titolo="+string(s_dati_partita.s_ll_id_titolo)+&
						" and stato='Z'",1, s_dati_partita.s_dw_aper_partita.rowcount())
			
			
		
		if ll_riga_trovata < 1 then
			ll_riga_trovata = s_dati_partita.s_dw_aper_partita.insertrow(0)
			IF UPPERBOUND(ld_qta_riaperta_zoppa)<1 then
				ld_qta_riaperta_zoppa[1]=0
			end if
			li_ret=s_dati_partita.s_dw_aper_partita.setitem(ll_riga_trovata, "id_documento", s_dati_partita.s_id_documento)
			if li_ret<>1 then messagebox("Errore!", "setitem id_doc")
			li_ret=s_dati_partita.s_dw_aper_partita.setitem(ll_riga_trovata, "id_titolo", s_dati_partita.s_ll_id_titolo)
			if li_ret<>1 then messagebox("Errore!", "setitem id_tit")
			ll_id_tipo_partita=wf_imposta_tipo_partita(ll_riga_trovata)
			if ll_id_tipo_partita= -1 then 
				s_dati_partita.s_dw_aper_partita.deleterow(ll_riga_trovata)
				return
			end if	
			li_ret=s_dati_partita.s_dw_aper_partita.setitem(ll_riga_trovata, "id_tipo_partita", ll_id_tipo_partita)
			if li_ret<>1 then messagebox("Errore!", "setitem id_tipo")
			li_ret=s_dati_partita.s_dw_aper_partita.setitem(ll_riga_trovata, "stato", "Z")
			if li_ret<>1 then messagebox("Errore!", "setitem stato")
			li_ret=s_dati_partita.s_dw_aper_partita.setitem(ll_riga_trovata, "val_apertura", s_dati_partita.s_ld_quantita_da_scaricare)
			if li_ret<>1 then messagebox("Errore!", "setitem val_aper")
			li_ret=s_dati_partita.s_dw_aper_partita.setitem(ll_riga_trovata, "val_scarico", s_dati_partita.s_ld_quantita_da_scaricare)
			if li_ret<>1 then messagebox("Errore!", "setitem val_scar")
		else
			
			
			li_ret=s_dati_partita.s_dw_aper_partita.setitem(ll_riga_trovata, "id_documento", s_dati_partita.s_id_documento)
			if li_ret<>1 then messagebox("Errore!", "setitem id_doc")
			ld_val_aper=s_dati_partita.s_dw_aper_partita.getitemdecimal(ll_riga_trovata, "val_apertura")
			IF UPPERBOUND(ld_qta_riaperta_zoppa)<1 then
				ld_qta_riaperta_zoppa[1]=ld_val_aper
			end if
			ll_riga_trovata2=s_dati_partita.s_dw_scar_partita.find("id_riga_documento="+&
			string(s_dati_partita.s_ll_id_riga_partita)+ " and (id_titolo="+&
			string(s_dati_partita.s_ll_id_titolo) +" or stato='Z')" , 1, s_dati_partita.s_dw_scar_partita.rowcount())
			if ll_riga_trovata2 > 0 then
				
				ld_val_scar_originale=s_dati_partita.s_dw_scar_partita.&
				getitemdecimal(ll_riga_trovata2, "val_scarico")
				
			else
				ld_val_scar_originale=0
			end if
			if not isnull(ld_val_aper) then
				
				ld_val_aper +=(s_dati_partita.s_ld_quantita_da_scaricare - ld_val_scar_originale)
				
				li_ret=s_dati_partita.s_dw_aper_partita.setitem(ll_riga_trovata, "val_apertura", ld_val_aper)
				if li_ret<>1 then messagebox("Errore!", "setitem val_aper")
				li_ret=s_dati_partita.s_dw_aper_partita.setitem(ll_riga_trovata, "val_scarico", ld_val_aper)
				if li_ret<>1 then messagebox("Errore!", "setitem val_scar")
			end if
		end if
		
		ll_riga_trovata2=s_dati_partita.s_dw_scar_partita.find("id_riga_documento="+&
			string(s_dati_partita.s_ll_id_riga_partita)+ " and (id_titolo="+&
			string(s_dati_partita.s_ll_id_titolo) +" or stato='Z')", 1, s_dati_partita.s_dw_scar_partita.rowcount())
		
		
		if ll_riga_trovata2 < 1 then
			ll_riga_trovata2=s_dati_partita.s_dw_scar_partita.insertrow(0)
			IF UPPERBOUND(ld_qta_riaperta_zoppa)<1 then
				ld_qta_riaperta_zoppa[2]=0
			end if
			
		else
			
		end if
		
		
		
		li_ret=s_dati_partita.s_dw_scar_partita.setitem&
		(ll_riga_trovata2, "id_titolo", s_dati_partita.s_ll_id_titolo)
		if li_ret<>1 then messagebox("Errore!", "Setitem fallito id_titolo")
		li_ret=s_dati_partita.s_dw_scar_partita.setitem&
		(ll_riga_trovata2, "id_riga_documento", s_dati_partita.s_ll_id_riga_partita)
		if li_ret<>1 then messagebox("Errore!", "Setitem fallito id_riga_par")
		li_ret=s_dati_partita.s_dw_scar_partita.setitem&
		(ll_riga_trovata2, "val_scarico", s_dati_partita.s_ld_quantita_da_scaricare)
		if li_ret<>1 then messagebox("Errore!", "Setitem fallito val_scarico")
		
		
		if dw_single.rowcount()>0 then
			ld_qta_disponibile=dw_single.getitemdecimal(1, "fino_selezionato")
		end if
		if isnull(ld_qta_disponibile) then ld_qta_disponibile=0
		ld_qta_disponibile+=s_dati_partita.s_ld_quantita_da_scaricare
		s_dati_partita.s_ld_quantita_selezionata=ld_qta_disponibile
		if dw_single.rowcount()>0 then
			
			li_ret=dw_single.setitem(1, "qta_zoppa", s_dati_partita.s_ld_quantita_da_scaricare)
			if li_ret<>1 then messagebox("Errore!", "Setitem fallito qta_zoppa")
		end if
		
		s_dati_partita.s_ld_quantita_da_scaricare =0
		dw_single.modify("datawindow.color=10140531")
		
		
end subroutine

public subroutine wf_riapri_partita_zoppa (long al_num_riga_scar, decimal ad_val_scarico, integer al_conta);long ll_riga_zoppa
decimal ld_val_aper
integer li_ret

ll_riga_zoppa=s_dati_partita.s_dw_aper_partita.find&
("id_documento="+string(s_dati_partita.s_id_documento)+&
" and id_titolo="+string(s_dati_partita.s_ll_id_titolo)&
+ " and stato='Z'", 1, s_dati_partita.s_dw_aper_partita.rowcount())
if ll_riga_zoppa>0 then
	
	ld_val_aper=s_dati_partita.s_dw_aper_partita.getitemdecimal(ll_riga_zoppa,"val_apertura")
	ld_qta_riaperta_zoppa[1]=ld_val_aper
	ld_qta_riaperta_zoppa[2]=ad_val_scarico
	
	
	
	if ld_val_aper <= ad_val_scarico then
		
		ld_val_aper=0
		
	else
		
		ld_val_aper=ld_val_aper - ad_val_scarico
	end if
	
	li_ret=s_dati_partita.s_dw_aper_partita.setitem(ll_riga_zoppa, "id_documento", s_dati_partita.s_id_documento)
	if li_ret<>1 then messagebox("Errore!", "setitem id_doc")
	
	li_ret=s_dati_partita.s_dw_aper_partita.setitem(ll_riga_zoppa,"val_apertura", ld_val_aper)
	if li_ret<>1 then messagebox("Errore!", "Setitem val_apertura fallito")
	li_ret=s_dati_partita.s_dw_aper_partita.setitem(ll_riga_zoppa,"val_scarico", ld_val_aper)
	if li_ret<>1 then messagebox("Errore!", "Setitem val_scarico fallito")
	li_ret=s_dati_partita.s_dw_scar_partita.setitem(al_num_riga_scar, "val_scarico", 0)
	if li_ret<>1 then messagebox("Errore!", "Setitem scar  val_scarico fallito")
else
	messagebox("Incredibile!", "Lo scarico non ha apertura!")
end if
end subroutine

public function long wf_imposta_tipo_partita (long al_riga);
long ll_id_tipo_partita
select id_tipo_partita
into :ll_id_tipo_partita
from orafo_tipo_partita
where cod_tipo_partita='APZ';
if sqlca.sqlcode<>0 then
	insert into orafo_tipo_partita (orafo_tipo_partita.cod_tipo_partita, orafo_tipo_partita.id_azienda)
	 values ('APZ', 1);
	 if sqlca.sqlcode<>0 then
		messagebox("Errore!", "strano, l'inserimento è fallito!")
		select min(id_tipo_partita)
		into :ll_id_tipo_partita
		from orafo_tipo_partita
		where substr(cod_tipo_partita, 1,1)='A';
		if sqlca.sqlcode<>0 then
			ll_id_tipo_partita= -1
		end if
	else
		select id_tipo_partita
		into :ll_id_tipo_partita
		from orafo_tipo_partita
		where cod_tipo_partita='APZ';
	end if
end if
return ll_id_tipo_partita
end function

on w_orafo_partite_aperte_gd.create
this.cb_deseleziona=create cb_deseleziona
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_single=create dw_single
this.Control[]={this.cb_deseleziona,&
this.cb_2,&
this.cb_1,&
this.dw_single}
end on

on w_orafo_partite_aperte_gd.destroy
destroy(this.cb_deseleziona)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_single)
end on

event open;
s_dati_partita=message.Powerobjectparm
integer i


post event ue_post_open()
end event

type cb_deseleziona from commandbutton within w_orafo_partite_aperte_gd
integer x = 2921
integer y = 780
integer width = 439
integer height = 108
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Deseleziona Tutto"
end type

event clicked;integer li_righe, i
long li_riga_selezionata
li_righe=dw_single.rowcount()
for i = 0 to li_righe - 1
	li_riga_selezionata=dw_single.GetSelectedRow ( i )
	if li_riga_selezionata<=0 then exit
	wf_qta_selezionata(li_riga_selezionata)
next
end event

type cb_2 from commandbutton within w_orafo_partite_aperte_gd
integer x = 434
integer y = 780
integer width = 375
integer height = 108
integer taborder = 20
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Non Scaricare"
boolean cancel = true
end type

event clicked;
integer i, a
long ll_riga_trovata_aper,ll_riga_scarico
decimal ld_val_aper
for i= 1 to dw_single.rowcount()
	if dw_single.IsSelected(i) then
		wf_qta_selezionata(i)
	end if
next	
i=0
wf_ripristina_scarichi()
ll_riga_scarico=s_dati_partita.s_dw_scar_partita.find&
("id_titolo="+string(s_dati_partita.s_ll_id_titolo)+ " or stato='Z' and id_riga_documento="&
+string(s_dati_partita.s_ll_id_riga_partita), 1, s_dati_partita.s_dw_scar_partita.rowcount())
ll_riga_trovata_aper=s_dati_partita.s_dw_aper_partita.find&
						("id_documento="+string(s_dati_partita.s_id_documento)+&
						" and id_titolo="+string(s_dati_partita.s_ll_id_titolo)+&
						" and stato='Z'",1, s_dati_partita.s_dw_aper_partita.rowcount())

if upperbound(ld_qta_riaperta_zoppa)>0 and ll_riga_scarico>0 then
	if ld_qta_riaperta_zoppa[1]<>0 then
		 	i=s_dati_partita.s_dw_aper_partita.setitem&
			(ll_riga_trovata_aper, "val_apertura", ld_qta_riaperta_zoppa[1])
			if i <> 1 then messagebox("errore!", "setitem aper fallito")
			i=s_dati_partita.s_dw_aper_partita.setitem&
			(ll_riga_trovata_aper, "val_scarico", ld_qta_riaperta_zoppa[1])
			if i <> 1 then messagebox("errore!", "setitem scar aper fallito")		
			
			if upperbound(ld_qta_riaperta_zoppa) < 2 then ld_qta_riaperta_zoppa[2]=0
			i=s_dati_partita.s_dw_scar_partita.setitem&
			(ll_riga_scarico, "val_scarico",ld_qta_riaperta_zoppa[2])
			if i <> 1 then messagebox("errore!", "setitem scar fallito")
	else
			i=s_dati_partita.s_dw_aper_partita.setitem&
			(ll_riga_trovata_aper, "val_apertura", 0)
			if i <> 1 then messagebox("errore!", "setitem aper fallito")
			i=s_dati_partita.s_dw_aper_partita.setitem&
			(ll_riga_trovata_aper, "val_scarico", 0)
			if i <> 1 then messagebox("errore!", "setitem scar aper fallito")
			i=s_dati_partita.s_dw_scar_partita.setitem&
			(ll_riga_scarico, "val_scarico",0)
			if i <> 1 then messagebox("errore!", "setitem scar fallito")
	end if
end if
s_dati_partita.s_dw_scar_partita.setfilter("")
s_dati_partita.s_dw_scar_partita.filter()

s_dati_partita.s_ld_quantita_selezionata=0
closewithreturn(parent, s_dati_partita)
end event

type cb_1 from commandbutton within w_orafo_partite_aperte_gd
integer x = 23
integer y = 780
integer width = 375
integer height = 108
integer taborder = 10
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Scarica"
boolean default = true
end type

event clicked;integer li_ret
decimal{4} ld_val_scarico, ld_val_apertura, ld_arrotonda
string ls_aperta
long ll_id_partita, ll_riga_trovata
integer	li_ync, li_retval, li_num_righe, i, li_controllo
long		ll_mods
if dw_single.rowcount()>0 then
	if dw_single.getitemdecimal(1, "fino_selezionato") <= 0 then
		li_ret=messagebox("Attenzione!", "Non è stata selezionata alcuna partita!~r~n"&
					+" Uscire ugualmente?", stopsign!,yesno!)
		if li_ret=1 then
			wf_ripristina_scarichi()
			s_dati_partita.s_ld_quantita_selezionata=0
			closewithreturn(parent, s_dati_partita)
			return
		elseif li_ret=2 then
			return
		end if
	end if
	if dw_single.modifiedcount() > 0 then
		if s_dati_partita.s_i_partite_da_derivazione=1 then
			li_ync=1
		else
			li_ync=1
//			li_ync = MessageBox("Gestione partite", "Ci sono modifiche non salvate in Gestione partite.~n~r" + &
//			"Vuoi salvarle?", Question!, YesNoCancel!)
		end if
		CHOOSE CASE li_ync
			CASE 1
				s_dati_partita.s_ld_quantita_selezionata=dw_single.getitemdecimal(1, "fino_selezionato")
				s_dati_partita.s_dw_scar_partita.setfilter("")
				s_dati_partita.s_dw_scar_partita.filter()
				li_num_righe=dw_single.rowcount()
				for i = 1 to li_num_righe
						ld_val_apertura=dw_single.getitemdecimal(i, "val_apertura")
						ld_val_scarico=dw_single.getitemdecimal(i, "val_scarico")
						if (ld_val_scarico = ld_val_apertura)  then dw_single.setitem(i, "stato", 'C')
						ld_arrotonda=dw_single.getitemdecimal(i, "orafo_metallo_val_arrotondamento")
						if isnull(ld_arrotonda) then ld_arrotonda=0.1
						IF (ld_val_apertura - ld_val_scarico) <=ld_arrotonda THEN 
							dw_single.setitem(i, "stato", 'C')
							ld_val_scarico=ld_val_apertura
						end if
	
						ls_aperta=dw_single.getitemstring(i, "stato")
						ll_id_partita=dw_single.getitemnumber(i, "id_partita")
						
						ll_riga_trovata=s_dati_partita.s_dw_aper_partita.find&
						("id_partita="+string(ll_id_partita), 1, s_dati_partita.s_dw_aper_partita.rowcount())
						if ll_riga_trovata<1 then messagebox("Errore!", "Riga non trovata! (51 cb_1)")
						
						li_controllo=s_dati_partita.s_dw_aper_partita.setitem(ll_riga_trovata, "val_scarico", ld_val_scarico)
						if li_controllo<>1 then messagebox("setitem", "val_scarico non settato")
						
						li_controllo=s_dati_partita.s_dw_aper_partita.setitem(ll_riga_trovata, "stato", ls_aperta)
						if li_controllo<>1 then messagebox("setitem", "stato non settato")
						if upperbound(il_id_riga_scar)>=i then
						ll_riga_trovata=s_dati_partita.s_dw_scar_partita.find&
						("id_partita="+string(ll_id_partita) +" and id_riga_documento="&
						+string(il_id_riga_scar[i]), 1, s_dati_partita.s_dw_scar_partita.rowcount())
							if ll_riga_trovata>0 then
								s_dati_partita.s_dw_scar_partita.setitem(ll_riga_trovata, "resto",0)
							end if
						end if
						
						
						
				next
				li_retval=0
			CASE 2
				li_retval = 0
				cb_2.trigger event clicked()
				return
				
			CASE 3
				
				li_retval = 1
				return
		END CHOOSE
	else
		
		li_retval = 0
	end if
else
	li_retval=0
end if	
	if li_retval=0 then 
		s_dati_partita.s_dw_scar_partita.setfilter("")
		s_dati_partita.s_dw_scar_partita.filter()
		closewithreturn(parent, s_dati_partita)
	end if


end event

type dw_single from datawindow within w_orafo_partite_aperte_gd
integer x = 23
integer y = 44
integer width = 3337
integer height = 720
integer taborder = 30
string dataobject = "d_orafo_partite_aperte_tb"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;
IF ROW>0 THEN
	wf_qta_selezionata(row)
END IF
end event

