forward
global type w_tv_classe_articolo_cx from w_001
end type
type cb_1 from commandbutton within w_tv_classe_articolo_cx
end type
type tv_2 from u_tree_orafo within w_tv_classe_articolo_cx
end type
type tv_1 from u_tree_orafo within w_tv_classe_articolo_cx
end type
type cb_cancella from commandbutton within w_tv_classe_articolo_cx
end type
type dw_1 from udw_base within w_tv_classe_articolo_cx
end type
type cb_salva from commandbutton within w_tv_classe_articolo_cx
end type
type cb_esci from commandbutton within w_tv_classe_articolo_cx
end type
type dw_2 from udw_figlia within w_tv_classe_articolo_cx
end type
type cb_inserisci_dw from commandbutton within w_tv_classe_articolo_cx
end type
type cb_salva_dw from commandbutton within w_tv_classe_articolo_cx
end type
type cb_cancella_dw from commandbutton within w_tv_classe_articolo_cx
end type
type r_1 from rectangle within w_tv_classe_articolo_cx
end type
type st_2 from statictext within w_tv_classe_articolo_cx
end type
type cb_app_classe from commandbutton within w_tv_classe_articolo_cx
end type
type cb_stampa from commandbutton within w_tv_classe_articolo_cx
end type
end forward

global type w_tv_classe_articolo_cx from w_001
int Width=3392
int Height=1576
cb_1 cb_1
tv_2 tv_2
tv_1 tv_1
cb_cancella cb_cancella
dw_1 dw_1
cb_salva cb_salva
cb_esci cb_esci
dw_2 dw_2
cb_inserisci_dw cb_inserisci_dw
cb_salva_dw cb_salva_dw
cb_cancella_dw cb_cancella_dw
r_1 r_1
st_2 st_2
cb_app_classe cb_app_classe
cb_stampa cb_stampa
end type
global w_tv_classe_articolo_cx w_tv_classe_articolo_cx

type variables
long	il_item_corrente
string is_sql


end variables

forward prototypes
public function long wf_cerca_figli (long al_item_corrente)
public function long wf_cerca_pari (long al_item_corr_pari)
public subroutine wf_ricerca (long al_riga_corrente, string as_data)
public function integer wf_salva_dw ()
end prototypes

public function long wf_cerca_figli (long al_item_corrente);
long ll_hnd_trovato,ll_riga, ll_item,ll_hnd_PARI,ll_hnd_test, ll_ritorno
s_tv_classe s_classi
integer li_ret
treeviewitem tv_item

if isnull(al_item_corrente) then return -1

ll_hnd_trovato=tv_1.finditem(childtreeitem!, al_item_corrente)
if ll_hnd_trovato>0 then
	li_ret=tv_1.getitem(ll_hnd_trovato, tv_item)
	s_classi=tv_item.data
	s_classi.hnd_corrente=ll_hnd_trovato
	ll_ritorno=ll_hnd_trovato
	s_classi.hnd_padre=al_item_corrente
	ll_riga=dw_1.insertrow(0)
	dw_1.setitem(ll_riga, "id_classe_padre", s_classi.id_classe_padre)
	dw_1.setitem(ll_riga, "id_classe_figlio", s_classi.id_classe)
	dw_1.setitem(ll_riga, "hnd_padre", s_classi.hnd_padre)
	dw_1.setitem(ll_riga, "hnd_corrente", s_classi.hnd_corrente)
	wf_cerca_figli(ll_hnd_trovato)
	return ll_ritorno
else
	ll_hnd_PARI=wf_cerca_pari(al_item_corrente)
	if ll_hnd_PARI >0 then 
		ll_ritorno=wf_cerca_figli(ll_hnd_PARI)
		if ll_ritorno>0 then
			return ll_ritorno
		else
			return ll_hnd_PARI
		end if
	else
		return al_item_corrente
	end if
	
	
	
	
end if
end function

public function long wf_cerca_pari (long al_item_corr_pari);long ll_hnd_i_pari,ll_riga1, ll_ritorno
integer li_ret1
s_tv_classe s_classi1
treeviewitem tv_item1, tv_2item


ll_hnd_i_pari=tv_1.finditem(nexttreeitem!, al_item_corr_PARI)
if ll_hnd_i_pari>0 then
	li_ret1=tv_1.getitem(ll_hnd_i_pari, tv_item1)
	s_classi1=tv_item1.data
	s_classi1.hnd_corrente=ll_hnd_i_pari
	s_classi1.hnd_padre=tv_1.finditem(parenttreeitem!, ll_hnd_i_pari)
	if s_classi1.hnd_padre<=0 then
		s_classi1.hnd_padre=1
	end if
	ll_riga1=dw_1.insertrow(0)
	dw_1.setitem(ll_riga1, "id_classe_padre", s_classi1.id_classe_padre)
	dw_1.setitem(ll_riga1, "id_classe_figlio", s_classi1.id_classe)
	dw_1.setitem(ll_riga1, "hnd_padre", s_classi1.hnd_padre)
	dw_1.setitem(ll_riga1, "hnd_corrente", s_classi1.hnd_corrente)
else
	ll_hnd_i_pari=tv_1.finditem(parenttreeitem!, al_item_corr_PARI)
	if ll_hnd_i_pari>0 then
		ll_ritorno=wf_cerca_pari(ll_hnd_i_pari)
		return ll_ritorno
	end if
end if
return ll_hnd_i_pari


end function

public subroutine wf_ricerca (long al_riga_corrente, string as_data);
s_ric_param ls_ric_param
w_search_main lw_sm
ls_ric_param.s_filter_value=as_data
ls_ric_param.s_filter_name="articolo_codice"
openwithparm(lw_sm,ls_ric_param,"w_articolo_coddes_sw")
ls_ric_param=message.powerobjectparm
if upperbound(ls_ric_param.s_id_seg_value)>0 then
	dw_2.setitem(al_riga_corrente, "classe_articolo_id_articolo",long(ls_ric_param.s_id_seg_value[1]))
	dw_2.setitem(al_riga_corrente,"articolo_codice", ls_ric_param.s_main_value)
	dw_2.setitem(al_riga_corrente, "articolo_descrizione",ls_ric_param.s_ausil_value[1])
end if
end subroutine

public function integer wf_salva_dw ();integer li_ret


li_ret=dw_2.triggerevent("ue_update")
return li_ret
end function

on w_tv_classe_articolo_cx.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.tv_2=create tv_2
this.tv_1=create tv_1
this.cb_cancella=create cb_cancella
this.dw_1=create dw_1
this.cb_salva=create cb_salva
this.cb_esci=create cb_esci
this.dw_2=create dw_2
this.cb_inserisci_dw=create cb_inserisci_dw
this.cb_salva_dw=create cb_salva_dw
this.cb_cancella_dw=create cb_cancella_dw
this.r_1=create r_1
this.st_2=create st_2
this.cb_app_classe=create cb_app_classe
this.cb_stampa=create cb_stampa
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.tv_2
this.Control[iCurrent+3]=this.tv_1
this.Control[iCurrent+4]=this.cb_cancella
this.Control[iCurrent+5]=this.dw_1
this.Control[iCurrent+6]=this.cb_salva
this.Control[iCurrent+7]=this.cb_esci
this.Control[iCurrent+8]=this.dw_2
this.Control[iCurrent+9]=this.cb_inserisci_dw
this.Control[iCurrent+10]=this.cb_salva_dw
this.Control[iCurrent+11]=this.cb_cancella_dw
this.Control[iCurrent+12]=this.r_1
this.Control[iCurrent+13]=this.st_2
this.Control[iCurrent+14]=this.cb_app_classe
this.Control[iCurrent+15]=this.cb_stampa
end on

on w_tv_classe_articolo_cx.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.tv_2)
destroy(this.tv_1)
destroy(this.cb_cancella)
destroy(this.dw_1)
destroy(this.cb_salva)
destroy(this.cb_esci)
destroy(this.dw_2)
destroy(this.cb_inserisci_dw)
destroy(this.cb_salva_dw)
destroy(this.cb_cancella_dw)
destroy(this.r_1)
destroy(this.st_2)
destroy(this.cb_app_classe)
destroy(this.cb_stampa)
end on

event open;call super::open;

long ll_hndl_padre, ll_hndl_figlio,ll_item_corrente, ll_ret
treeviewitem tv1_item
datastore ds_strut_classi, ds_classi
integer i
string ls_cod_padre, ls_cod_figlio, ls_cod_padre_old, ls_classe
long ll_id_figlio, ll_id_padre,ll_riga_trovata, ll_righe
s_tv_classe s_classi

dw_2.settransobject(sqlca)
is_sql=dw_2.getsqlselect()
dw_1.settransobject(sqlca)
ll_righe=dw_1.retrieve()

if ll_righe>0 then
	tv1_item.label="Struttura Classi"
	tv1_item.data=s_classi
	tv1_item.pictureindex=4
	tv1_item.selectedpictureindex=4
	tv1_item.Expanded=true
	tv_1.InsertItemFirst(0, tv1_item)
	
	tv1_item.pictureindex=2
	tv1_item.selectedpictureindex=2
end if
for i = 1 to ll_righe
	
	ls_cod_figlio=dw_1.getitemstring(i, "classe_figlio")
	s_classi.id_classe=dw_1.getitemnumber(i, "id_classe_figlio")
	s_classi.id_classe_padre=dw_1.getitemnumber(i, "id_classe_padre")
	s_classi.hnd_padre=dw_1.getitemnumber(i, "hnd_padre")
	s_classi.hnd_corrente=dw_1.getitemnumber(i, "hnd_corrente")
	tv1_item.data=s_classi
	tv1_item.label=ls_cod_figlio
	ll_hndl_figlio= tv_1.finditem(childtreeitem!, s_classi.hnd_padre)
	if ll_hndl_figlio>1 then
		ll_ret=tv_1.InsertItem(s_classi.hnd_padre, ll_hndl_figlio, tv1_item)
	else
		ll_ret=tv_1.InsertItemFirst(s_classi.hnd_padre, tv1_item)
	end if
next
if ll_righe>0 then il_item_corrente=dw_1.getitemnumber(ll_righe, "max_hnd")



ds_classi=create datastore
ds_classi.dataobject="d_classe_gd"
ds_classi.settransobject(sqlca)
ll_righe=ds_classi.retrieve()

tv1_item.label="Lista Classi"
tv1_item.data=""
tv1_item.pictureindex=4
tv1_item.selectedpictureindex=4
tv1_item.Expanded=true
ll_item_corrente=tv_2.InsertItemFirst(0, tv1_item)
ll_hndl_padre =tv_2.FindItem (roottreeitem!, 0)

tv1_item.pictureindex=2
tv1_item.selectedpictureindex=2

for I=1 to ll_righe
	ls_classe=ds_classi.getitemstring(i, "cod_classe")
	s_classi.id_classe=ds_classi.getitemnumber(i, "id_classe")
	tv1_item.label=ls_classe
	tv1_item.data=s_classi
	if i=1 then
		ll_item_corrente=tv_2.InsertItemFirst(ll_hndl_padre, tv1_item)
	else
		ll_hndl_padre =tv_2.FindItem (parenttreeitem!, ll_item_corrente)
		ll_item_corrente=tv_2.InsertItem(ll_hndl_padre,ll_item_corrente,tv1_item)
	end if
next
destroy(ds_classi)

end event

event timer;
end event

type cb_1 from commandbutton within w_tv_classe_articolo_cx
int X=3077
int Y=12
int Width=238
int Height=176
int TabOrder=120
boolean Visible=false
boolean BringToTop=true
string Text="none"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

long ll_hndl_padre, ll_hndl_figlio,ll_item_corrente
treeviewitem tv1_item
datastore ds_strut_classi, ds_classi
integer i, ll_righe
string ls_cod_padre, ls_cod_figlio, ls_cod_padre_old, ls_classe
long ll_id_figlio, ll_id_padre,ll_riga_trovata
s_tv_classe s_classi

tv_2.DeleteItem(0)
tv_1.DeleteItem(0)

ds_classi=create datastore
ds_classi.dataobject="d_classe_gd"
ds_classi.settransobject(sqlca)
ll_righe=ds_classi.retrieve()

tv1_item.label="Lista Classi"
tv1_item.data=""
tv1_item.pictureindex=4
tv1_item.selectedpictureindex=4
tv1_item.Expanded=true
ll_item_corrente=tv_2.InsertItemFirst(0, tv1_item)
ll_hndl_padre =tv_2.FindItem (roottreeitem!, 0)

tv1_item.pictureindex=2
tv1_item.selectedpictureindex=2

for I=1 to ll_righe
	ls_classe=ds_classi.getitemstring(i, "cod_classe")
	s_classi.id_classe=ds_classi.getitemnumber(i, "id_classe")
	tv1_item.label=ls_classe
	tv1_item.data=s_classi
	if i=1 then
		ll_item_corrente=tv_2.InsertItemFirst(ll_hndl_padre, tv1_item)
	else
		ll_hndl_padre =tv_2.FindItem (parenttreeitem!, ll_item_corrente)
		ll_item_corrente=tv_2.InsertItem(ll_hndl_padre,ll_item_corrente,tv1_item)
	end if
next
destroy(ds_classi)



end event

type tv_2 from u_tree_orafo within w_tv_classe_articolo_cx
int X=23
int Y=8
int Width=626
int Height=1456
string DragIcon="Question!"
boolean BringToTop=true
end type

event clicked;

if handle>1 then
	selectitem(handle)
	
	
	this.Drag (begin!)
end if
end event

type tv_1 from u_tree_orafo within w_tv_classe_articolo_cx
int X=658
int Y=8
int Width=1239
int Height=1456
int TabOrder=20
string DragIcon="Question!"
boolean BringToTop=true
end type

event dragdrop;TreeViewItem	tv0_item,	tv1_item
long ll_hnd_padre, ll_hnd_figlio, ll_hnd_source
long ll_item_corr
treeview tv_source
s_tv_classe s_classi, s_classe_padre

source.Drag(end!)
SetDropHighlight(handle)
tv_source=source
ll_hnd_source=tv_source.finditem(currenttreeitem!, 0)
tv_source.getitem(ll_hnd_source,  tv1_item)
s_classi=tv1_item.data
if handle>0 then
	getitem(handle, tv0_item)
	s_classe_padre=tv0_item.data
	s_classi.hnd_padre=s_classe_padre.hnd_corrente
	s_classi.id_classe_padre=s_classe_padre.id_classe
	ll_hnd_figlio=finditem(childtreeitem!, handle)
	if ll_hnd_figlio>0 then
		s_classi.hnd_corrente=il_item_corrente+1
		tv1_item.data=s_classi
		ll_item_corr=InsertItem(handle,ll_hnd_figlio ,tv1_item)
		if ll_item_corr>0 then 
			il_item_corrente=ll_item_corr
		else
			messagebox("Errore!", "Item non inserito!")
			return
		end if
			
	else
		s_classi.hnd_corrente=il_item_corrente+1
		tv1_item.data=s_classi
		ll_item_corr=InsertItemfirst(handle, tv1_item)
		if ll_item_corr>0 then 
			il_item_corrente=ll_item_corr
		else
			messagebox("Errore!", "Item non inserito!")
			return
		end if
	end if
else
	if il_item_corrente=0 then
		tv0_item.label="Struttura Classi"
		tv0_item.data=s_classe_padre
		tv0_item.pictureindex=4
		tv0_item.selectedpictureindex=4
		tv0_item.Expanded=true
		ll_item_corr=InsertItemFirst(0, tv0_item)
		if ll_item_corr>0 then 
			il_item_corrente=ll_item_corr
		else
			messagebox("Errore!", "Item non inserito!")
			return
		end if
		s_classi.hnd_corrente=il_item_corrente+1
		s_classi.id_classe_padre=0
		s_classi.hnd_padre=1
		tv1_item.data=s_classi		
		ll_item_corr=InsertItemFirst(1, tv1_item)
		if ll_item_corr>0 then 
			il_item_corrente=ll_item_corr
		else
			messagebox("Errore!", "Item non inserito!")
			return
		end if
	elseif il_item_corrente>0 then
		ll_hnd_figlio=finditem(childtreeitem!, 1)
		s_classi.hnd_corrente=ll_hnd_figlio+1
		s_classi.id_classe_padre=0
		s_classi.hnd_padre=1
		tv1_item.data=s_classi
		ll_item_corr=InsertItem(1,ll_hnd_figlio ,tv1_item)
		if ll_item_corr>0 then 
			il_item_corrente=ll_item_corr
		else
			messagebox("Errore!", "Item non inserito!")
			return
		end if
	end if
	SetPointer(Arrow!)
end if

end event

event rightclicked;s_tv_classe s_classi
treeviewitem tv_item

if handle>0 then
	getitem(handle, tv_item)
	s_classi=tv_item.data
	messagebox("id_classe"+string(s_classi.id_classe), &
				"id_cl_padre:"+string(s_classi.id_classe_padre)+&
				" ~r~nnodo_padre:"+string(s_classi.hnd_padre)+&
				" - nodo_corrente:"+string(s_classi.hnd_corrente))
				
end if

end event

event clicked;long ll_hnd, ll_righe
treeviewitem tv_item
s_tv_classe s_classi

if handle>0 then
	ll_righe=dw_2.rowcount()
	if ll_righe>0 then
		if messagebox("Attenzione!", "Vuoi vedere gli articoli "+&
		"~r~nassociati a questa classe?", stopsign!, yesno!)<>1 then return
	end if
	getitem(handle	, tv_item)
	s_classi=tv_item.data
	ll_righe=dw_2.retrieve(s_classi.id_classe)
	if ll_righe=0 then
		messagebox("Vuoto!", "Nessun articolo associato alla classe: "+tv_item.label)
	end if
end if
end event

type cb_cancella from commandbutton within w_tv_classe_articolo_cx
int X=1943
int Y=16
int Width=247
int Height=108
int TabOrder=80
boolean BringToTop=true
string Text="Cancella"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_hnd

ll_hnd=tv_1.finditem(currenttreeitem!, 0)
if messagebox("Attenzione: Ultimo avviso!", "Sei proprio sicuro di voler cancellare~r~n"+&
					"il 'nodo' e tutti i suoi figli?", stopsign!, yesno!)=1 then
	if ll_hnd=1 then
		il_item_corrente=0
	end if
	tv_1.deleteitem(ll_hnd)
end if
end event

type dw_1 from udw_base within w_tv_classe_articolo_cx
int X=1938
int Y=1200
int Width=453
int Height=236
int TabOrder=40
boolean Visible=false
boolean BringToTop=true
string DataObject="d_classe_struttura_gd"
end type

type cb_salva from commandbutton within w_tv_classe_articolo_cx
int X=2226
int Y=16
int Width=247
int Height=108
int TabOrder=90
boolean BringToTop=true
string Text="Salva"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_hnd,ll_righe, ll_riga, ll_hnd_trovato, ll_riga_trovata
integer  li_ret, i
treeviewitem tv_item
s_tv_classe s_classi



if messagebox("Attenzione!", "Vuoi davvero salvare?", stopsign!, yesno!)=1 then
	
	
	dw_1.reset()
	
	
	ll_hnd++
	ll_hnd_trovato=tv_1.finditem(childtreeitem!, ll_hnd)
	if ll_hnd_trovato>0 then
		li_ret=tv_1.getitem(ll_hnd_trovato, tv_item)
		s_classi=tv_item.data
		
		s_classi.hnd_corrente=ll_hnd_trovato
		s_classi.hnd_padre=ll_hnd
		
		ll_riga=dw_1.insertrow(0)
		dw_1.setitem(ll_riga, "id_classe_padre", s_classi.id_classe_padre)
		dw_1.setitem(ll_riga, "id_classe_figlio", s_classi.id_classe)
		dw_1.setitem(ll_riga, "hnd_padre", s_classi.hnd_padre)
		dw_1.setitem(ll_riga, "hnd_corrente", s_classi.hnd_corrente)
		
		ll_hnd=wf_cerca_figli(ll_hnd_trovato)
		
	
	
	
	
	
	
	
	
		
	end if
		
		
	
	ll_riga=dw_1.rowcount()
	dw_1.setsort("hnd_padre")
	li_ret=dw_1.sort()
	if li_ret<>1 then 
		messagebox("Errore!", "Sort non appplicato!")
		return
	end if

	for i= 1 to ll_riga
		ll_hnd=dw_1.getitemnumber(i, "hnd_corrente")
		
		dw_1.setitem(i, "hnd_corrente", (i+1)*10000)
		do
			ll_riga_trovata=dw_1.find("hnd_padre="+string(ll_hnd), ll_riga_trovata+1, ll_riga)
			if ll_riga_trovata>0 then 
				dw_1.setitem(ll_riga_trovata, "hnd_padre", (i+1)*10000)
			end if
		loop while ll_riga_trovata>0
		
	next
	for i=1 to ll_riga
		ll_hnd=dw_1.getitemnumber(i, "hnd_corrente")
		
		dw_1.setitem(i, "hnd_corrente", ll_hnd/10000)
		
		ll_hnd=dw_1.getitemnumber(i, "hnd_padre")
		if mod(ll_hnd, 10000)=0 then
			dw_1.setitem(i, "hnd_padre", ll_hnd/10000)
		end if
	next
	delete from classe_struttura;
	if sqlca.sqlcode=0 then
		commit;
	else
		rollback;
		messagebox("Errore!", "Tabella non azzerata")
	end if
	if dw_1.update()=1 then
		commit;
	else
		rollback;
		messagebox("Errore!", "Dati non Salvati!")
	end if
end if
end event

type cb_esci from commandbutton within w_tv_classe_articolo_cx
int X=3104
int Y=20
int Width=247
int Height=108
int TabOrder=100
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

type dw_2 from udw_figlia within w_tv_classe_articolo_cx
int X=1934
int Y=284
int Width=1422
int Height=1080
int TabOrder=30
boolean BringToTop=true
string DataObject="d_classe_articolo_gd"
end type

event itemchanged;st_ass_art_sottoclasse st_associa
IF DWO.NAME='articolo_codice' then
	select id_articolo, codice, descrizione
	into :st_associa.id_articolo, :st_associa.cod_articolo, :st_associa.des_articolo
	from articolo
	where codice=:data;
	if sqlca.sqlcode=0 then
		setitem(row, "classe_articolo_id_articolo", st_associa.id_articolo)
		setitem(row, "articolo_codice", st_associa.cod_articolo)
		setitem(row, "articolo_descrizione", st_associa.des_articolo)
	else
		wf_ricerca(row, data)
	end if
end if



end event

event ue_key;choose case key
	case keydelete!
		cb_cancella_dw.triggerevent(clicked!)
	case Keyadd!
		if (keyFlags=2) then
			cb_inserisci_dw.triggerevent(clicked!)
		end if

	case KeySubtract!
		if (keyFlags=2) then
			cb_cancella_dw.triggerevent(clicked!)
		end if			
     case KeyS!
		if (keyFlags=2) then
			cb_salva_dw.triggerevent(clicked!)		
		end if
	case KeyF12!
		cb_salva_dw.triggerevent(clicked!)		
	
end choose
end event

event clicked;string ls_data
if dwo.name="articolo_codice_sw" then
	ls_data=getitemstring(row, "articolo_codice")
	wf_ricerca(row, ls_data)
end if
end event

event sqlpreview;treeviewitem tv_item
long ll_hnd, ll_id_classe[], ll_pos
integer li_ret, li_conta=1, a
s_tv_classe s_classi
STRING ls_sql, ls_inizio,ls_sql_from, ls_des_text, ls_cod_classe[]

ls_sql=upper(is_sql)
if pos(ls_sql, "WHERE")>0 THEN
	ls_inizio= " AND "
else
	ls_inizio="WHERE"
end if

ll_hnd=tv_1.finditem(currenttreeitem!, 0)
tv_1.getitem(ll_hnd, tv_item)
s_classi=tv_item.data
ls_cod_classe[li_conta]=tv_item.label
ls_sql+=ls_inizio+ " CLASSE_ARTICOLO.ID_CLASSE="+STRING(s_classi.id_classe)+" "
do while s_classi.id_classe_padre>0 
	li_conta++
	
	ll_hnd=tv_1.finditem(parenttreeitem!, ll_hnd)
	tv_1.getitem(ll_hnd, tv_item)
	ls_cod_classe[li_conta]=tv_item.label
	s_classi=tv_item.data
	
	ll_pos=pos(ls_sql, "WHERE")
	ls_sql_from=left(ls_sql, ll_pos - 1)
	ls_sql_from+=", CLASSE_ARTICOLO AS CL_ART_"+STRING(LI_CONTA)+" "
	LS_SQL=ls_sql_from+right(ls_sql, len(ls_sql) - (ll_pos - 1))
	
	ls_sql+=" AND CL_ART_"+STRING(LI_CONTA)+".ID_ARTICOLO=ARTICOLO.ID_ARTICOLO " 
	
	ls_sql+= " AND CL_ART_"+STRING(LI_CONTA)+".ID_CLASSE="+STRING(s_classi.id_classe)+" "
loop 
	
	
	
	
	
for a= li_conta to 1 step -1
	if a=li_conta then
		ls_des_text+=ls_cod_classe[a]
	else
		ls_des_text+="-"+ls_cod_classe[a]
	end if
next
dw_2.modify("classi_selezionate_t.text='"+ls_des_text+"'")

li_ret=setsqlpreview(ls_sql)



end event

type cb_inserisci_dw from commandbutton within w_tv_classe_articolo_cx
int X=2249
int Y=1376
int Width=261
int Height=96
int TabOrder=50
boolean BringToTop=true
string Text="Inserisci"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_riga, ll_id
			ll_riga=dw_2.trigger event ue_insert(0)
			dw_2.setcolumn("articolo_codice")
end event

type cb_salva_dw from commandbutton within w_tv_classe_articolo_cx
int X=2533
int Y=1376
int Width=261
int Height=96
int TabOrder=60
boolean BringToTop=true
string Text="Salva"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
	
long i, ll_righe, ll_id_classe, ll_id_articolo, ll_riga_trovata
long ll_righe_canc

ll_righe=dw_2.rowcount()
ll_riga_trovata=dw_2.find("isnull(classe_articolo_id_classe)", 1, ll_righe)
if ll_riga_trovata>0 then
	messagebox("Attenzione!", "Premere 'Applica Classe' prima di salvare")
	return
end if
ll_righe_canc=dw_2.deletedcount()
for i=1 to ll_righe_canc
	ll_id_classe=dw_2.getitemnumber(i, "classe_articolo_id_classe", delete!, false)
	ll_id_articolo=dw_2.getitemnumber(i, "classe_articolo_id_articolo", delete!, false)	
	delete from classe_articolo
	where id_classe=:ll_id_classe
	and id_articolo=:ll_id_articolo;
	if sqlca.sqlcode=0 then
		commit;
	else
		rollback;
		messagebox("Errore!", "Righe non cancellate!")	
	end if
next

for i=1 to ll_righe
	ll_id_classe=dw_2.getitemnumber(i, "classe_articolo_id_classe")
	ll_id_articolo=dw_2.getitemnumber(i, "classe_articolo_id_articolo")
	update classe_articolo
	set id_classe=:ll_id_classe, id_articolo=:ll_id_articolo
	where id_classe=:ll_id_classe and id_articolo=:ll_id_articolo;
	if sqlca.sqlnrows>0 then
		commit;
	else
		rollback;
		insert into classe_articolo
		(id_classe, id_articolo)
		values(:ll_id_classe, :ll_id_articolo);
		if sqlca.sqlcode=0 then
			commit;
		else
			rollback;
			messagebox("Errore!", "Salvataggio non riuscito!")
		end if
	end if
next
end event

type cb_cancella_dw from commandbutton within w_tv_classe_articolo_cx
int X=2816
int Y=1376
int Width=261
int Height=96
int TabOrder=70
boolean BringToTop=true
string Text="Cancella"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_riga_da_cancellare
	ll_riga_da_cancellare=dw_2.getrow()
	if ll_riga_da_cancellare>0 then
		dw_2.trigger event ue_delete(ll_riga_da_cancellare)
	end if
end event

type r_1 from rectangle within w_tv_classe_articolo_cx
int X=1902
int Y=4
int Width=608
int Height=136
boolean Enabled=false
int LineThickness=4
long LineColor=80269524
long FillColor=15793151
end type

type st_2 from statictext within w_tv_classe_articolo_cx
int X=1920
int Y=136
int Width=667
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="<<<<<<<<<<<<<<<<<<<<<"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_app_classe from commandbutton within w_tv_classe_articolo_cx
int X=1934
int Y=196
int Width=1422
int Height=84
int TabOrder=110
boolean BringToTop=true
string Text="Applica Classe"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_hnd,ll_righe,ll_riga_inserita, ll_id_art,ll_test
s_tv_classe s_classi
treeviewitem tv_item
integer i, a
string ls_cod_classe[], ls_cod_art,ls_des_art,ls_des_text
long ll_id_classe[]

integer li_conta=1

ll_hnd=tv_1.finditem(currenttreeitem!, 0)

if ll_hnd>0 then
	ll_righe=dw_2.rowcount()
	tv_1.getitem(ll_hnd, tv_item)
	s_classi=tv_item.data
	ls_cod_classe[li_conta]=tv_item.label
	ll_id_classe[li_conta]=s_classi.id_classe
	do while s_classi.id_classe_padre>0 
		li_conta++
		ll_hnd=tv_1.finditem(parenttreeitem!, ll_hnd)
		tv_1.getitem(ll_hnd, tv_item)
		s_classi=tv_item.data
		ls_cod_classe[li_conta]=tv_item.label
		ll_id_classe[li_conta]=s_classi.id_classe
	loop 
	for i=1 to ll_righe	
		ll_id_art=dw_2.getitemnumber(i, "classe_articolo_id_articolo")
		ls_cod_art=dw_2.getitemstring(i, "articolo_codice")
		ls_des_art=dw_2.getitemstring(i, "articolo_descrizione")
		for a= 1 to li_conta
			select id_classe
			into :ll_test
			from classe_articolo
			where id_articolo=:ll_id_art and id_classe=:ll_id_classe[a];
			if sqlca.sqlcode=0 then
				
				
				
				
			else
				if a=1 then
					
					dw_2.setitem(i, "classe_articolo_id_classe",ll_id_classe[a])
					dw_2.setitem(i, "classe_cod_classe",ls_cod_classe[a])
				else
					ll_riga_inserita=dw_2.insertrow(0)
					dw_2.setitem(ll_riga_inserita, "classe_articolo_id_classe",ll_id_classe[a])
					dw_2.setitem(ll_riga_inserita, "classe_cod_classe",ls_cod_classe[a])
					dw_2.setitem(ll_riga_inserita, "classe_articolo_id_articolo",ll_id_art)
					dw_2.setitem(ll_riga_inserita, "articolo_codice",ls_cod_art)
					dw_2.setitem(ll_riga_inserita, "articolo_descrizione",ls_des_art)
				end if
			end if
		next
	next
	for i= ll_righe to 1 step -1
		ll_test= dw_2.getitemnumber(i, "classe_articolo_id_classe") 
		if isnull(ll_test) then
			dw_2.deleterow(i)			
		end if
	next
	
	for a= li_conta to 1 step -1
		if a=li_conta then
			ls_des_text+=ls_cod_classe[a]
		else
			ls_des_text+="-"+ls_cod_classe[a]
		end if
	next
	dw_2.modify("classi_selezionate_t.text='"+ls_des_text+"'")
	
	
end if
end event

type cb_stampa from commandbutton within w_tv_classe_articolo_cx
int X=3099
int Y=1376
int Width=247
int Height=96
int TabOrder=80
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
dw_2.modify("articolo_codice_sw.visible=0")
dw_2.print()
dw_2.modify("articolo_codice_sw.visible=1")
end event

