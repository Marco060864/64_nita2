forward
global type w_or_ges_listino_cx from w_001
end type
type dw_1 from udw_base within w_or_ges_listino_cx
end type
type dw_3 from udw_base within w_or_ges_listino_cx
end type
type dw_2 from udw_figlia within w_or_ges_listino_cx
end type
type cb_seleziona from commandbutton within w_or_ges_listino_cx
end type
type cb_trova_listini from commandbutton within w_or_ges_listino_cx
end type
type cb_cancella from commandbutton within w_or_ges_listino_cx
end type
type cb_inserisci from commandbutton within w_or_ges_listino_cx
end type
type cb_varia from commandbutton within w_or_ges_listino_cx
end type
type cb_varia_tutto from commandbutton within w_or_ges_listino_cx
end type
type cb_1 from commandbutton within w_or_ges_listino_cx
end type
type dw_4 from udw_base within w_or_ges_listino_cx
end type
type cb_stampa from commandbutton within w_or_ges_listino_cx
end type
type cbx_ricarico from checkbox within w_or_ges_listino_cx
end type
end forward

global type w_or_ges_listino_cx from w_001
int Width=2981
int Height=1600
WindowType WindowType=main!
boolean TitleBar=true
string Title="Varia Prezzi in Listini"
long BackColor=80269524
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
dw_1 dw_1
dw_3 dw_3
dw_2 dw_2
cb_seleziona cb_seleziona
cb_trova_listini cb_trova_listini
cb_cancella cb_cancella
cb_inserisci cb_inserisci
cb_varia cb_varia
cb_varia_tutto cb_varia_tutto
cb_1 cb_1
dw_4 dw_4
cb_stampa cb_stampa
cbx_ricarico cbx_ricarico
end type
global w_or_ges_listino_cx w_or_ges_listino_cx

forward prototypes
public subroutine wf_ricerca (long al_riga_corrente, string as_data)
end prototypes

public subroutine wf_ricerca (long al_riga_corrente, string as_data);
s_ric_param ls_ric_param
w_search_main lw_sm
ls_ric_param.s_filter_value=as_data
ls_ric_param.s_filter_name="articolo_codice"
openwithparm(lw_sm,ls_ric_param,"w_articolo_coddes_sw")
ls_ric_param=message.powerobjectparm
if upperbound(ls_ric_param.s_id_seg_value)>0 then
	dw_2.setitem(al_riga_corrente, "lista_art_key_id_articolo",long(ls_ric_param.s_id_seg_value[1]))
	dw_2.setitem(al_riga_corrente,"articolo_codice", ls_ric_param.s_main_value)
	dw_2.setitem(al_riga_corrente, "articolo_descrizione",ls_ric_param.s_ausil_value[1])
end if
end subroutine

on w_or_ges_listino_cx.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_3=create dw_3
this.dw_2=create dw_2
this.cb_seleziona=create cb_seleziona
this.cb_trova_listini=create cb_trova_listini
this.cb_cancella=create cb_cancella
this.cb_inserisci=create cb_inserisci
this.cb_varia=create cb_varia
this.cb_varia_tutto=create cb_varia_tutto
this.cb_1=create cb_1
this.dw_4=create dw_4
this.cb_stampa=create cb_stampa
this.cbx_ricarico=create cbx_ricarico
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_3
this.Control[iCurrent+3]=this.dw_2
this.Control[iCurrent+4]=this.cb_seleziona
this.Control[iCurrent+5]=this.cb_trova_listini
this.Control[iCurrent+6]=this.cb_cancella
this.Control[iCurrent+7]=this.cb_inserisci
this.Control[iCurrent+8]=this.cb_varia
this.Control[iCurrent+9]=this.cb_varia_tutto
this.Control[iCurrent+10]=this.cb_1
this.Control[iCurrent+11]=this.dw_4
this.Control[iCurrent+12]=this.cb_stampa
this.Control[iCurrent+13]=this.cbx_ricarico
end on

on w_or_ges_listino_cx.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_3)
destroy(this.dw_2)
destroy(this.cb_seleziona)
destroy(this.cb_trova_listini)
destroy(this.cb_cancella)
destroy(this.cb_inserisci)
destroy(this.cb_varia)
destroy(this.cb_varia_tutto)
destroy(this.cb_1)
destroy(this.dw_4)
destroy(this.cb_stampa)
destroy(this.cbx_ricarico)
end on

event open;call super::open;dw_1.settransobject(sqlca)
dw_1.insertrow(1)
dw_2.settransobject(sqlca)
dw_3.settransobject(sqlca)
end event

type dw_1 from udw_base within w_or_ges_listino_cx
int X=27
int Y=20
int Width=1079
int Height=452
boolean BringToTop=true
string DataObject="d_or_sel_listino_wz"
boolean VScrollBar=false
end type

type dw_3 from udw_base within w_or_ges_listino_cx
int X=14
int Y=604
int Width=2213
int Height=836
int TabOrder=20
boolean BringToTop=true
string DataObject="d_or_list_da_variare"
end type

event clicked;s_st_cat_immediato st_cat
long ll_righe, i, ll_id_listino, ll_id_var
long ll_id_art, a, ll_id_uc
decimal ld_prezzo_manifattura


if dwo.name="pb_stampa" then
	ll_righe=dw_2.rowcount()
	ll_id_listino=dw_3.getitemnumber(row, "id_listino")
	
	select id_sog_commerciale
	into :st_cat.id_sog_commerciale[1]
	from sog_commerciale
	where id_listino=:ll_id_listino
	;
	if st_cat.id_sog_commerciale[1]>0 then
		ll_id_var=dw_3.getitemnumber(row, "id_variazione")
		for i= 1 to ll_righe
			ll_id_art=dw_2.getitemnumber(i, "lista_art_key_id_articolo")
			select id_unita_confezione
			into :ll_id_uc
			from unita_confezione
			where id_articolo=:ll_id_art
			and unita_base='S';
			select prezzo_manifattura
			into :ld_prezzo_manifattura
			from prezzo
			where id_variazione=:ll_id_var
			and id_unita_confezione=:ll_id_uc;
			if sqlca.sqlcode=0 then
				a++
				st_cat.cod_articolo[a]=dw_2.getitemstring(i, "articolo_codice")
				st_cat.id_articolo[a]=ll_id_art
			end if
		next
		openwithparm(w_st_foto_articolo_cx, st_cat)
	end if
end if
end event

type dw_2 from udw_figlia within w_or_ges_listino_cx
event ue_rbutton_dblclick pbm_rbuttondblclk
int X=1257
int Y=20
int Width=1655
int Height=572
int TabOrder=50
boolean BringToTop=true
string DataObject="d_lista_art_key_gd"
end type

event clicked;string ls_data
if dwo.name="articolo_codice_sw" then
	ls_data=getitemstring(row, "articolo_codice")
	wf_ricerca(row, ls_data)
end if

long ll_id_art, ll_id_var,ll_id_uc
integer li_num_uc, i
datastore ds_uc
decimal ld_prezzo_man, ld_prezzo
string ls_testo
w_001 w_parent
w_parent=this.getparent()


if row>0 and dwo.name="ind" then
	ll_id_art=dw_2.getitemnumber(row,"lista_art_key_id_articolo")
	if ll_id_art>0 then
		ll_id_var=dw_1.getitemnumber(1, "id_variazione")
		if ll_id_var>0 then
			ds_uc=create datastore
			ds_uc.dataobject="ds_art_uc"
			ds_uc.settransobject(sqlca)
			li_num_uc=ds_uc.retrieve(ll_id_art)
			for i=1 to li_num_uc
				ll_id_uc=ds_uc.getitemnumber(i, "id_unita_confezione")
				select prezzo, prezzo_manifattura
				into :ld_prezzo, :ld_prezzo_man
				from prezzo
				where id_variazione=:ll_id_var 
				and id_unita_confezione=:ll_id_uc;
				if isnull(ld_prezzo) then ld_prezzo=0
				if isnull(ld_prezzo_man) then ld_prezzo_man=0
				ls_testo+="Prezzo: "+string(ld_prezzo)+&
							" - Pr. Man.: "+string(ld_prezzo_man)+"~r~n"
							
			next

			if ls_testo>"" then
				if isvalid(w_parent)  then
					w_parent.st_1.text=ls_testo
					w_parent.st_1.x=this.x + xpos+35
					w_parent.st_1.y=this.y + ypos
					w_parent.st_1.width=1000
					w_parent.st_1.visible=true	
					timer(1.3, w_parent)
				end if
			END IF
			destroy(ds_uc)
		end if	
	end if
		
		
		
	destroy(ds_uc)
end if
end event

event dw_2::itemchanged;st_ass_art_sottoclasse st_associa
IF DWO.NAME='articolo_codice' then
	select id_articolo, codice, descrizione
	into :st_associa.id_articolo, :st_associa.cod_articolo, :st_associa.des_articolo
	from articolo
	where codice=:data;
	if sqlca.sqlcode=0 then
		setitem(row, "lista_art_key_id_articolo", st_associa.id_articolo)
		setitem(row, "articolo_codice", st_associa.cod_articolo)
		setitem(row, "articolo_descrizione", st_associa.des_articolo)
	else
		wf_ricerca(row, data)
	end if
end if
		
end event

event updatestart;integer li_righe
li_righe=dw_2.rowcount()
if li_righe>0 then
	li_righe=dw_2.getitemnumber(li_righe, "esiste_doppio")
	if li_righe>0 then 
		dw_2.setfilter("art_doppi=1")
		dw_2.filter()
		for li_righe=dw_2.rowcount() to 1 step -1

			dw_2.deleterow(li_righe)
		next
		dw_2.setfilter("")
		dw_2.filter()
	end if
end if
end event

event ue_key;choose case key
	case keydelete!
		cb_cancella.triggerevent(clicked!)
	case Keyadd!
		if (keyFlags=2) then
			cb_inserisci.triggerevent(clicked!)
		end if

	case KeySubtract!
		if (keyFlags=2) then
			cb_cancella.triggerevent(clicked!)
		end if	
	case keytab!
     if getrow()=rowcount() and getcolumn()=4 then
		cb_inserisci.triggerevent(clicked!)
	end if

	
end choose
end event

event ue_insert;
long ll_riga
ll_riga=this.insertrow(al_riga_precedente+1)
scrolltorow(ll_riga)
setitem(ll_riga, "lista_art_key_id_lista_articoli", 0)
post setcolumn(3)
post setfocus(this)
return ll_riga
end event

event rowfocuschanged;setrowfocusindicator(hand!)
end event

type cb_seleziona from commandbutton within w_or_ges_listino_cx
int X=827
int Y=496
int Width=242
int Height=84
int TabOrder=80
boolean BringToTop=true
string Text="Seleziona"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;s_dw_ritorna st_p
long ll_righe
 
openwithparm(w_auto_aggiunta_cx, 0)
	
st_p=message.powerobjectparm
	
if isvalid(st_p) then
	ll_righe=dw_2.rowcount()+1
	if ll_righe<=0 then ll_righe=1
	st_p.ds.rowscopy(1, st_p.ds.rowcount(), primary!, dw_2, ll_righe, primary!)
end if
dw_2.sort()
	
end event

type cb_trova_listini from commandbutton within w_or_ges_listino_cx
int X=2272
int Y=608
int Width=315
int Height=108
int TabOrder=90
boolean BringToTop=true
string Text="Trova Listini"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
long ll_id_lista, ll_id_variazione,ll_lis_trovati, i, ll_righe
long ll_id_art
dwitemstatus d_status

setpointer(hourglass!)

dw_2.accepttext()
SELECT ID_LISTA_articoli
INTO :LL_ID_LISTA
FROM LISTA_ART_DEF
where id_lista_articoli=0;
if sqlca.sqlcode<>0 then
	insert into LISTA_ART_DEF (id_lista_articoli, cod_lista_articoli)
	values(0, '0000');
	if sqlca.sqlcode=0 then
		commit;
		delete lista_art_key
		where id_lista_articoli=0;
		if sqlca.sqlcode=0 then
			commit;
		else
			rollback;
			messagebox("Errore!", "Azzeramento Lista 0 non riuscito!")
			return
		end if
	else
		rollback;
		messagebox("Errore!", "Lista 0 non inserita!")
		return
	end if
else
	delete lista_art_key
	where id_lista_articoli=0;
	if sqlca.sqlcode=0 then
		commit;
	else
		rollback;
		messagebox("Errore!", "Azzeramento Lista 0 non riuscito!")
		return
	end if
end if
ll_righe=dw_2.rowcount()
for i=1 to ll_righe
	ll_id_art=dw_2.getitemnumber(i, "lista_art_key_id_articolo")
	if ll_id_art>0 then
		insert into lista_art_key (id_lista_articoli, id_articolo)
		values(0, :ll_id_art);
	end if
next
if sqlca.sqlcode=0 then
	commit;
else
	rollback;
	messagebox("Errore!", "Inserimento lista non riuscito!")
	return
end if	

ll_lis_trovati=dw_3.retrieve()
ll_id_variazione=dw_1.getitemnumber(1, "id_variazione")
if ll_id_variazione>0 then
	for i= 1 to ll_lis_trovati
		dw_3.setitem(i, "listino_base_calcolo", ll_id_variazione)
	next
end if

setpointer(arrow!)
	

end event

type cb_cancella from commandbutton within w_or_ges_listino_cx
int X=302
int Y=496
int Width=242
int Height=84
int TabOrder=60
boolean BringToTop=true
string Text="Cancella"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_2.trigger event ue_delete(dw_2.getrow())

end event

type cb_inserisci from commandbutton within w_or_ges_listino_cx
int X=567
int Y=496
int Width=242
int Height=84
int TabOrder=70
boolean BringToTop=true
string Text="Inserisci"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_2.trigger event ue_insert(dw_2.getrow())
end event

type cb_varia from commandbutton within w_or_ges_listino_cx
int X=2642
int Y=756
int Width=247
int Height=108
int TabOrder=40
boolean Visible=false
boolean BringToTop=true
string Text="Varia"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
long i, ll_num_articoli, ll_id_variazione, ll_id_uc,ll_id_art
decimal ld_prezzo, ld_prezzo_man, ld_var_perc, ld_var_importo
datastore ds_uc
integer li_num_uc, a
string ls_cosa_aggiorno, ls_articolo, ls_listino, ls_tipo_listino
setpointer(hourglass!)

dw_4.reset()
dw_1.accepttext()
dw_2.accepttext()
ll_num_articoli=dw_2.rowcount()
ll_id_variazione=dw_1.getitemnumber(1, "id_variazione")
if ll_id_variazione>0 then
	select tipo
	into :ls_tipo_listino
	from listino l, variazione v
	where v.id_listino=l.id_listino
	and v.id_variazione=:ll_id_variazione;
	
	ls_cosa_aggiorno=dw_1.getitemstring(1, "cosa_aggiorno")	
	
	ds_uc=create datastore
	ds_uc.dataobject="ds_art_uc"
	ds_uc.settransobject(sqlca)
	
	ld_var_perc=dw_1.getitemdecimal(1, "percentuale")
	ld_var_importo= dw_1.getitemdecimal(1, "importo")
	
	for i=1 to ll_num_articoli
		ll_id_art=dw_2.getitemnumber(i, "lista_art_key_id_articolo")
		li_num_uc=ds_uc.retrieve(ll_id_art)	
		for a=1 to li_num_uc
			
			ll_id_uc=ds_uc.getitemnumber(a, "id_unita_confezione")
			
			select prezzo_manifattura, prezzo
			into :ld_prezzo_man, :ld_prezzo
			from prezzo
			where id_variazione=:ll_id_variazione and id_unita_confezione=:ll_id_uc;
			if sqlca.sqlcode=0 then
				if isnull(ld_prezzo_man) then ld_prezzo_man=0
				if isnull(ld_prezzo) then ld_prezzo=0
				if ls_cosa_aggiorno="G" or ls_cosa_aggiorno="E" then 
					if cbx_ricarico.checked then
						ld_prezzo_man=f_ricarico(ld_prezzo_man,ll_id_art )
						if ls_tipo_listino='V' then ld_prezzo_man=f_round(ld_prezzo_man, -2,"S")
					else
						if ld_var_perc<>0 then
							ld_prezzo_man+=(ld_prezzo_man*ld_var_perc/100)
							if ls_tipo_listino='V' then ld_prezzo_man=f_round(ld_prezzo_man, -2,"S")
						elseif ld_var_importo<>0 then
							ld_prezzo_man+=ld_var_importo
							if ls_tipo_listino='V' then ld_prezzo_man=f_round(ld_prezzo_man, -2,"S")
						end if
					end if
					update prezzo
					set prezzo_manifattura=:ld_prezzo_man 
					where id_variazione=:ll_id_variazione and id_unita_confezione=:ll_id_uc;
					if sqlca.sqlnrows>0 then
						commit;
					else
						rollback;
						dw_4.insertrow(1)
						ls_articolo=dw_2.getitemstring(i, "articolo_codice")
						ls_listino=dw_1.getitemstring(1, "c_listino")
						dw_4.setitem(1, "articolo", ls_articolo)
						dw_4.setitem(1, "listino", "G_"+ls_listino)
					end if
				end if
				if ls_cosa_aggiorno="P" or ls_cosa_aggiorno="E" then
					if cbx_ricarico.checked then
						ld_prezzo=f_ricarico(ld_prezzo, ll_id_art)
						if ls_tipo_listino='V' then ld_prezzo=f_round(ld_prezzo, -2,"S")
					else
						if ld_var_perc<>0 then
							ld_prezzo+=(ld_prezzo*ld_var_perc /100)
							if ls_tipo_listino='V' then ld_prezzo=f_round(ld_prezzo, -2,"S")
						elseif ld_var_importo<>0 then
							ld_prezzo+=ld_var_importo
							if ls_tipo_listino='V' then ld_prezzo=f_round(ld_prezzo, -2,"S")
						end if
					end if			
					update prezzo
					set prezzo=:ld_prezzo 
					where id_variazione=:ll_id_variazione and id_unita_confezione=:ll_id_uc;
					if sqlca.sqlnrows>0 then
						commit;
					else
						rollback;
						dw_4.insertrow(1)
						ls_articolo=dw_2.getitemstring(i, "articolo_codice")
						ls_listino=dw_1.getitemstring(1, "c_listino")
						dw_4.setitem(1, "articolo", ls_articolo)
						dw_4.setitem(1, "listino", "P_"+ls_listino)
					end if
				end if
			else
				dw_4.insertrow(1)
				ls_articolo=dw_2.getitemstring(i, "articolo_codice")
				ls_listino=dw_1.getitemstring(1, "c_listino")
				dw_4.setitem(1, "articolo", ls_articolo)
				dw_4.setitem(1, "listino", ls_listino)
			end if
		next
		
		
	next
	
	destroy(ds_uc)
end if
setpointer(arrow!)
end event

type cb_varia_tutto from commandbutton within w_or_ges_listino_cx
int X=2272
int Y=764
int Width=315
int Height=108
int TabOrder=100
boolean BringToTop=true
string Text="Varia"
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
long i, ll_num_articoli, ll_id_variazione, ll_id_uc
long ll_id_art, ll_num_listini, u, ll_var_base_calcolo
decimal ld_prezzo, ld_prezzo_man, ld_var_perc, ld_var_importo
datastore ds_uc
integer li_num_uc, a
string ls_cosa_aggiorno, ls_varia, ls_listino, ls_articolo, ls_tipo_listino

setpointer(hourglass!)
dw_4.reset()
dw_1.accepttext()
dw_2.accepttext()

if messagebox("Attenzione!", "Aggiornamento prezzi listino: continuare?", stopsign!,yesno!)=1 then
	cb_varia.triggerevent(clicked!)
	ll_num_articoli=dw_2.rowcount()
	ll_num_listini=dw_3.rowcount()
	
	ls_cosa_aggiorno=dw_1.getitemstring(1, "cosa_aggiorno")	
	
	ds_uc=create datastore
	ds_uc.dataobject="ds_art_uc"
	ds_uc.settransobject(sqlca)
	
		
	for i=1 to ll_num_articoli
		ll_id_art=dw_2.getitemnumber(i, "lista_art_key_id_articolo")
		li_num_uc=ds_uc.retrieve(ll_id_art)	
		for u=1 to ll_num_listini
			ls_varia=dw_3.getitemstring(u, "c_varia")
			ll_var_base_calcolo=dw_3.getitemnumber(u, "listino_base_calcolo")
			ll_id_variazione=dw_3.getitemnumber(u, "id_variazione")
			
			
			ls_tipo_listino=dw_3.getitemstring(u, "listino_tipo")
			
			if ll_var_base_calcolo=0 then ll_var_base_calcolo=ll_id_variazione
			ld_var_perc=dw_3.getitemdecimal(u, "percentuale")
			ld_var_importo= dw_3.getitemdecimal(u, "importo")
			if ll_id_variazione>0 and ll_var_base_calcolo>0 and ls_varia='S' then
				for a=1 to li_num_uc
					
					ll_id_uc=ds_uc.getitemnumber(a, "id_unita_confezione")
					
					select prezzo_manifattura, prezzo
					into :ld_prezzo_man, :ld_prezzo
					from prezzo
					where id_variazione=:ll_var_base_calcolo and id_unita_confezione=:ll_id_uc;
					if sqlca.sqlcode=0 then
						if isnull(ld_prezzo_man) then ld_prezzo_man=0
						if isnull(ld_prezzo) then ld_prezzo=0
						if ls_cosa_aggiorno="G" or ls_cosa_aggiorno="E" then 
							if cbx_ricarico.checked then
								
								ld_prezzo_man=f_ricarico(ld_prezzo_man, ll_id_art)	
								if ls_tipo_listino='V' then ld_prezzo_man=f_round(ld_prezzo_man, -2, "S")
							else
								if ld_var_perc<>0 then
									ld_prezzo_man+=(ld_prezzo_man*ld_var_perc/100)
									if ls_tipo_listino='V' then ld_prezzo_man=f_round(ld_prezzo_man, -2, "S")
								elseif ld_var_importo<>0 then
									ld_prezzo_man+=ld_var_importo
									if ls_tipo_listino='V' then ld_prezzo_man=f_round(ld_prezzo_man, -2, "S")
								end if
							end if
							update prezzo
							set prezzo_manifattura=:ld_prezzo_man 
							where id_variazione=:ll_id_variazione and id_unita_confezione=:ll_id_uc;
							if sqlca.sqlnrows>0 then
								commit;
							else
								rollback;
								dw_4.insertrow(1)
								ls_articolo=dw_2.getitemstring(i, "articolo_codice")
								ls_listino=dw_3.getitemstring(u, "listino_codice")
								dw_4.setitem(1, "articolo", ls_articolo)
								dw_4.setitem(1, "listino", 'G_'+ls_listino)
							end if
						end if
						if ls_cosa_aggiorno="P" or ls_cosa_aggiorno="E" then
							if cbx_ricarico.checked then
							
								ld_prezzo=f_ricarico(ld_prezzo, ll_id_art)	
								if ls_tipo_listino='V' then ld_prezzo=f_round(ld_prezzo, -2, "S")
							else
								if ld_var_perc<>0 then
									ld_prezzo+=(ld_prezzo*ld_var_perc /100)
									if ls_tipo_listino='V' then ld_prezzo=f_round(ld_prezzo, -2, "S")
								elseif ld_var_importo<>0 then
									ld_prezzo+=ld_var_importo
									if ls_tipo_listino='V' then ld_prezzo=f_round(ld_prezzo, -2, "S")
								end if
							end if
							update prezzo
							set prezzo=:ld_prezzo 
							where id_variazione=:ll_id_variazione and id_unita_confezione=:ll_id_uc;
							if sqlca.sqlnrows>0 then
								commit;
							else
								rollback;
								dw_4.insertrow(1)
								ls_articolo=dw_2.getitemstring(i, "articolo_codice")
								ls_listino=dw_3.getitemstring(u, "listino_codice")
								dw_4.setitem(1, "articolo", ls_articolo)
								dw_4.setitem(1, "listino", 'P_'+ls_listino)
							end if
						end if
					else
						dw_4.insertrow(1)
						ls_articolo=dw_2.getitemstring(i, "articolo_codice")
						ls_listino=dw_3.getitemstring(u, "listino_codice")
						dw_4.setitem(1, "articolo", ls_articolo)
						dw_4.setitem(1, "listino", ls_listino)
					end if					
						
				next
			end if
		next
	next
	for i=1 to ll_num_listini
		dw_3.setitem(i, "c_varia", "N")
	next
	dw_1.reset()
	dw_1.insertrow(1)
	destroy(ds_uc)
end if
setpointer(arrow!)
end event

type cb_1 from commandbutton within w_or_ges_listino_cx
int X=2587
int Y=1336
int Width=315
int Height=108
int TabOrder=110
boolean BringToTop=true
string Text="Esci"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(parent)
end event

type dw_4 from udw_base within w_or_ges_listino_cx
int X=2245
int Y=896
int Width=667
int Height=424
int TabOrder=30
boolean BringToTop=true
string DataObject="d_art_non_in_listino"
end type

type cb_stampa from commandbutton within w_or_ges_listino_cx
int X=2272
int Y=1336
int Width=279
int Height=108
int TabOrder=110
boolean BringToTop=true
string Text="Stampa"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;printsetup()
dw_3.print()
end event

type cbx_ricarico from checkbox within w_or_ges_listino_cx
int X=2615
int Y=620
int Width=297
int Height=76
boolean BringToTop=true
string Text="Ricarichi"
BorderStyle BorderStyle=StyleLowered!
boolean LeftText=true
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

