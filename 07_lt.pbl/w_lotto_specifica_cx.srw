forward
global type w_lotto_specifica_cx from w_p_data
end type
type dw_lotto_ff from u_dw_master_main within tabpage_1
end type
type dw_1 from u_dw_master_main within tabpage_1
end type
type dw_2 from u_dw_master_main within tabpage_1
end type
type st_1 from statictext within tabpage_1
end type
type st_2 from statictext within tabpage_1
end type
type st_3 from statictext within tabpage_1
end type
type cb_preview from commandbutton within tabpage_1
end type
type cb_1 from commandbutton within tabpage_1
end type
type dw_lotto_ff from u_dw_master_main within tabpage_1
end type
type dw_1 from u_dw_master_main within tabpage_1
end type
type dw_2 from u_dw_master_main within tabpage_1
end type
type st_1 from statictext within tabpage_1
end type
type st_2 from statictext within tabpage_1
end type
type st_3 from statictext within tabpage_1
end type
type cb_preview from commandbutton within tabpage_1
end type
type cb_1 from commandbutton within tabpage_1
end type
type cb_an_canc from commandbutton within w_lotto_specifica_cx
end type
type cb_rip from commandbutton within w_lotto_specifica_cx
end type
end forward

global type w_lotto_specifica_cx from w_p_data
int X=530
int Width=3369
int Height=2188
boolean TitleBar=true
string Title="Lotto specifica"
long BackColor=79217864
cb_an_canc cb_an_canc
cb_rip cb_rip
end type
global w_lotto_specifica_cx w_lotto_specifica_cx

type variables
datastore ds_mov_lotto, ds_riepilogo
long il_id_retrieve, il_id_documento[], il_id_doc_car
end variables

forward prototypes
public subroutine wf_retrieve_lista ()
end prototypes

public subroutine wf_retrieve_lista ();long ll_row, ll_id_lotto_padre

if tab_1.tabpage_1.dw_1.rowcount()<1 then
	ll_id_lotto_padre=tab_1.tabpage_1.dw_lotto_ff.GetItemNumber(1,"id_lotto")
	tab_1.tabpage_1.dw_2.retrieve(ll_id_lotto_padre, ll_id_lotto_padre)
end if
end subroutine

on w_lotto_specifica_cx.create
int iCurrent
call super::create
this.cb_an_canc=create cb_an_canc
this.cb_rip=create cb_rip
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_an_canc
this.Control[iCurrent+2]=this.cb_rip
end on

on w_lotto_specifica_cx.destroy
call super::destroy
destroy(this.cb_an_canc)
destroy(this.cb_rip)
end on

event open;call super::open;idw_master = tab_1.tabpage_1.dw_lotto_ff
idw_master.is_list = Message.PowerObjectParm

idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_sql_ident[1] = "id_lotto"

end event

event ue_post_open;call super::ue_post_open;long ll_id_lotto, ll_id_lotto_padre

if tab_1.tabpage_1.dw_1.RowCount()>0 then
	tab_1.tabpage_1.dw_1.selectrow(1,true)
	ll_id_lotto=tab_1.tabpage_1.dw_1.getitemnumber(1,"id_lotto")
	ll_id_lotto_padre=tab_1.tabpage_1.dw_lotto_ff.GetItemNumber(1,"id_lotto")
	
	
	char	 lc_tipo_ges_lotti, lc_salpa
	
	SELECT tipo_ges_lotti
	INTO	 :lc_tipo_ges_lotti
	FROM	 pers_par_sistema
	;
	
	SELECT salpa
	INTO	 :lc_salpa
	FROM	 pers_par_sistema
	;
	
	if (lc_tipo_ges_lotti = 'G' ) and (lc_salpa = 'S') then
		tab_1.tabpage_1.dw_2.dataobject = "d_documenti_pf_mp_gd"
		tab_1.tabpage_1.dw_2.settransobject(sqlca)

		tab_1.tabpage_1.dw_2.retrieve(0, ll_id_lotto_padre)		
	
	else
		tab_1.tabpage_1.dw_2.retrieve(ll_id_lotto, ll_id_lotto_padre)
	end if
end if
ds_riepilogo=create datastore
ds_mov_lotto=create datastore
ds_mov_lotto.dataobject="d_mov_lotto_ds"
ds_riepilogo.dataobject="ds_riepilogo_lotti_lt"
ds_riepilogo.settransobject(sqlca)
ds_riepilogo.retrieve()
ds_mov_lotto.settransobject(sqlca)
ds_mov_lotto.retrieve()

char lc_commerciale

select commerciale
into :lc_commerciale
from par_sistema;
if lc_commerciale='S' then 
	cb_cancella.visible=false
end if

post wf_retrieve_lista()


end event

event close;call super::close;string str
long i, j
boolean corretto
s_par_record lstr_par_documento

str=tab_1.tabpage_1.dw_lotto_ff.object.datawindow.readonly

if  str = "yes" then
	
	if upperbound(il_id_documento)>0 then
		if not isnull(il_id_doc_car) then
			delete from riga_doc_lotto where id_doc=:il_id_doc_car;
		end if
			
		corretto=true
		for i = 1 to upperbound(il_id_documento)
			for j=1 to upperbound(il_id_documento)
				if (i<>j)and(il_id_documento[i]=il_id_documento[j]) then SetNull(il_id_documento[j])
			next
		next
		
		for i = 1 to upperbound(il_id_documento)
			if not IsNull(il_id_documento[i]) then
				lstr_par_documento.nome_tabella="documento" 
				lstr_par_documento.nome_id_tabella="id_documento"
				lstr_par_documento.id_tabella=il_id_documento[i]
				lstr_par_documento.visible=false
				openwithparm(w_utl_cancella_documento_wz,lstr_par_documento)
				if message.doubleparm<1 then corretto=false
			end if
		next
		if not corretto then messagebox("Errore...","Si è verificato un errore durante il salvataggio!")
	end if
	
	
	ds_mov_lotto.update()
	ds_riepilogo.update()
	tab_1.tabpage_1.dw_1.update()
	tab_1.tabpage_1.dw_lotto_ff.deleterow(1)
	tab_1.tabpage_1.dw_lotto_ff.update()
	
end if





end event

event closequery;
long			ll_mods
integer		li_ync, li_retval
u_dw_main	ludw_1
boolean		lb_ok

ludw_1 = u_freddie.iudw_current
lb_ok = true
if not IsNull (ludw_1) then
	if ludw_1.acceptText()>0 then lb_ok = true else lb_ok = false
end if
if not lb_ok then return 1
if idw_master.acceptText() >0 then lb_ok = true else lb_ok = false
if not lb_ok then return 1

if idw_master.uf_to_update() > 0 then
	li_ync = MessageBox(idw_master.is_title, "Ci sono modifiche non salvate nella " + &
		"finestra.~n~rVuoi salvarle?", Question!, YesNoCancel!)
	CHOOSE CASE li_ync
		CASE 1
			
			THIS.triggerevent("ue_update")
			ll_mods = idw_master.uf_to_update()
			if ll_mods = 0 then 
			
				tab_1.tabpage_1.dw_lotto_ff.object.datawindow.readonly="yes"			
			
				li_retval = 0
			else
				li_retval = 1
			end if
			
		CASE 2
			
			li_retval = 0
			
		CASE 3
			
			li_retval = 1
			
	END CHOOSE
else
	
	li_retval = 0
	
end if

return li_retval

end event

type p_crescente from w_p_data`p_crescente within w_lotto_specifica_cx
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_lotto_specifica_cx
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_lotto_specifica_cx
int X=37
int Y=20
int Width=334
boolean BringToTop=true
string Text="Esci e salva"
end type

event cb_ok::clicked;call super::clicked;

end event

type cb_annulla from w_p_data`cb_annulla within w_lotto_specifica_cx
int X=402
int Y=20
int Width=480
boolean BringToTop=true
string Text="Esci senza salvare"
end type

event cb_annulla::clicked;tab_1.tabpage_1.dw_lotto_ff.object.datawindow.readonly="No"
parent.TriggerEvent("ue_close")

end event

type cb_nuovo from w_p_data`cb_nuovo within w_lotto_specifica_cx
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_lotto_specifica_cx
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_lotto_specifica_cx
int X=2331
int Y=20
int Width=343
boolean BringToTop=true
end type

event cb_cancella::constructor;call super::constructor;
end event

event cb_cancella::clicked;
char		lc_tipo_ges_lotti
long		ll_id_lotto
integer	li_ret

SELECT tipo_ges_lotti
INTO	 :lc_tipo_ges_lotti
FROM	 pers_par_sistema
;

ll_id_lotto = tab_1.tabpage_1.dw_lotto_ff.getitemnumber(1, "id_lotto")

if (lc_tipo_ges_lotti = 'G') and (ll_id_lotto > 0) then
	u_lotti_uso_generale l_u_cancella_lotti 

	li_ret = messagebox("Cancellazione Lotto", "Sei sicuro di voler cancellare il lotto ?", Question!, YesNo!, 2)
	if (li_ret = 1) then
		l_u_cancella_lotti = CREATE u_lotti_uso_generale 
			l_u_cancella_lotti.uf_canc_lotto_prod(ll_id_lotto)
		DESTROY l_u_cancella_lotti	
	end if
	return
end if




string ls_find, ls_tipo_lotto, ls_cod_lotto, ls_prof_doc
long ll_num_righe, ll_riga, ll_id_art, ls_numero_lotto, Ll_riga_mia, ll_riga_trovata, ll_num_prog
long ll_id_prof_doc, ll_id_prof_car, ll_id_prof_scar, ll_vuoto[]
integer li_num_colonne, i
decimal{4} ll_qta_scar,ll_qta,ld_qta_iniz, ld_qta_car


il_id_retrieve=tab_1.tabpage_1.dw_lotto_ff.getitemnumber(1, "id_lotto")

ls_tipo_lotto=tab_1.tabpage_1.dw_lotto_ff.getitemstring(1, "tipo_lotto")
if ls_tipo_lotto= "M" then
	Messagebox("Errore!", "Non puoi cancellare un lotto di materie prime!")
	return
end if
if ls_tipo_lotto="s" then
	ls_cod_lotto=tab_1.tabpage_1.dw_lotto_ff.getitemstring(1, "cod_esterno")
	if ls_cod_lotto="" or isnull(ls_cod_lotto) then 
		messagebox("Attenzione!", "Non esiste codice lotto!")
		il_id_documento=ll_vuoto
		return
	end if
end if

ll_riga_trovata=tab_1.tabpage_1.dw_2.find("id_lotto="+string(il_id_retrieve), 1, tab_1.tabpage_1.dw_2.rowcount())
do while ll_riga_trovata>0
	ll_id_prof_doc=tab_1.tabpage_1.dw_2.GetItemNumber(ll_riga_trovata,"id_prof_documento")
	select codice
	into :ls_prof_doc
	from prof_documento
	where prof_documento.id_prof_documento=:ll_id_prof_doc;
	if ls_prof_doc='SCLOT' then
		messagebox("Errore!", "Non puoi cancellare un lotto già utilizzato in un documento!")
		il_id_documento=ll_vuoto		
		return
	end if
	
	if ls_prof_doc='CL' then il_id_doc_car=tab_1.tabpage_1.dw_2.GetItemNumber(ll_riga_trovata,"id_documento")
	
	il_id_documento[upperbound(il_id_documento)+1]=tab_1.tabpage_1.dw_2.GetItemNumber(ll_riga_trovata,"id_documento")
	ll_riga_trovata++
	if ll_riga_trovata>tab_1.tabpage_1.dw_2.rowcount() then exit
	ll_riga_trovata=tab_1.tabpage_1.dw_2.find("id_lotto="+string(il_id_retrieve), ll_riga_trovata, tab_1.tabpage_1.dw_2.rowcount())
loop

select id_prof_documento
into :ll_id_prof_car
from prof_documento
where prof_documento.codice='CL';
select id_prof_documento
into :ll_id_prof_scar
from prof_documento
where prof_documento.codice='SL';

ls_find="id_prof_documento="+string(ll_id_prof_car)+" or id_prof_documento="+string(ll_id_prof_scar)
ll_riga_trovata=tab_1.tabpage_1.dw_2.find(ls_find, 1, tab_1.tabpage_1.dw_2.rowcount())
do while ll_riga_trovata>0
	
	il_id_documento[upperbound(il_id_documento)+1]=tab_1.tabpage_1.dw_2.GetItemNumber(ll_riga_trovata,"id_documento")
	ll_riga_trovata++
	if ll_riga_trovata>tab_1.tabpage_1.dw_2.rowcount() then exit
	ll_riga_trovata=tab_1.tabpage_1.dw_2.find(ls_find, ll_riga_trovata, tab_1.tabpage_1.dw_2.rowcount())
loop

	
ll_num_righe=tab_1.tabpage_1.dw_1.rowcount()
for i = 1 to ll_num_righe
	ll_qta_scar = tab_1.tabpage_1.dw_1.getitemdecimal(i, "qta_scaricata")
	ll_qta =tab_1.tabpage_1.dw_1.getitemdecimal(i, "quantita")
	ll_qta_scar -=ll_qta
	tab_1.tabpage_1.dw_1.setitem(i, "qta_scaricata", ll_qta_scar)
next
ls_numero_lotto=tab_1.tabpage_1.dw_lotto_ff.getitemnumber(1, "numero")
ls_find="num_lotto_prod=" + string(ls_numero_lotto)
ll_riga=ds_mov_lotto.find(ls_find, 1, ds_mov_lotto.rowcount())
do while ll_riga>0
	ll_num_righe=ds_mov_lotto.DELETEROW(LL_RIGA)
	ll_riga=ds_mov_lotto.find(ls_find, 1, ds_mov_lotto.rowcount())
loop
li_num_colonne=integer(tab_1.tabpage_1.dw_lotto_ff.object.datawindow.column.count)
for i = 1 to li_num_colonne
	ls_find="#"+string(i)+".background.color = 419833"
	tab_1.tabpage_1.dw_lotto_ff.modify(ls_find)
next
tab_1.tabpage_1.dw_lotto_ff.object.datawindow.readonly="yes"

ls_find="datawindow.detail.color='536870912~tif("
for i=1 to upperbound(il_id_documento)
	ls_find=ls_find+"(id_documento="+string(il_id_documento[i])+") or"
next
ls_find=Left(ls_find,Len(ls_find) - 3)
ls_find=ls_find+", 419833, 536870912)'"
tab_1.tabpage_1.dw_2.modify(ls_find)

this.enabled=false
cb_an_canc.enabled=true
end event

type cb_salva from w_p_data`cb_salva within w_lotto_specifica_cx
int X=1125
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_lotto_specifica_cx
int X=37
int Y=128
int Width=3296
int Height=1956
int TabOrder=10
boolean BringToTop=true
end type

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=18
int Y=104
int Width=3259
int Height=1836
long BackColor=79741120
string Text="Ricerca Lotti"
long TabBackColor=79741120
dw_lotto_ff dw_lotto_ff
dw_1 dw_1
dw_2 dw_2
st_1 st_1
st_2 st_2
st_3 st_3
cb_preview cb_preview
cb_1 cb_1
end type

on tabpage_1.create
this.dw_lotto_ff=create dw_lotto_ff
this.dw_1=create dw_1
this.dw_2=create dw_2
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.cb_preview=create cb_preview
this.cb_1=create cb_1
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_lotto_ff
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.dw_2
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.cb_preview
this.Control[iCurrent+8]=this.cb_1
end on

on tabpage_1.destroy
call super::destroy
destroy(this.dw_lotto_ff)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.cb_preview)
destroy(this.cb_1)
end on

type cb_ricerca from w_p_data`cb_ricerca within w_lotto_specifica_cx
int X=1207
int Y=24
boolean BringToTop=true
end type

type dw_lotto_ff from u_dw_master_main within tabpage_1
int X=5
int Y=76
int Width=1600
int Height=828
int TabOrder=11
string DataObject="d_lotto_specifica_ff"
end type

event ue_set_search;call super::ue_set_search;
end event

event ue_use_search;call super::ue_use_search;
end event

event itemchanged;call super::itemchanged;
end event

event ue_init;call super::ue_init;is_list.s_identifica[1]="id_lotto"
iudw_children[1] = tab_1.tabpage_1.dw_1
iudw_children[2] = tab_1.tabpage_1.dw_2
end event

type dw_1 from u_dw_master_main within tabpage_1
int X=1673
int Y=76
int Width=1582
int Height=828
int TabOrder=3
string DataObject="d_lotti_padri_lt"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event ue_init;call super::ue_init;is_list.s_identifica[1]="id_lotto"


end event

event rowfocuschanged;call super::rowfocuschanged;long id_lotto_base,ll_riga, ll_id_lotto_padre

if dw_1.rowcount()>0 then
	dw_1.selectrow(dw_1.getselectedrow(1),false)
	
	dw_1.selectrow(currentrow,true)
	id_lotto_base=dw_1.getitemnumber(currentrow,"id_lotto")   
	ll_id_lotto_padre=tab_1.tabpage_1.dw_lotto_ff.GetItemNumber(1,"id_lotto")	
	tab_1.tabpage_1.dw_2.retrieve(id_lotto_base, ll_id_lotto_padre)
end if 
end event

type dw_2 from u_dw_master_main within tabpage_1
int X=5
int Y=1024
int Width=3250
int Height=808
int TabOrder=3
string DataObject="d_lotti_figli_ltbuona2"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event ue_init;call super::ue_init;
is_list.s_win_chiave [1] = "id_documento"

is_list.s_win_zoom="w_documento_ordine_cx"
end event

event ue_retrieve;
end event

type st_1 from statictext within tabpage_1
int X=5
int Width=411
int Height=60
boolean Enabled=false
boolean BringToTop=true
string Text="Lotto:"
boolean FocusRectangle=false
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within tabpage_1
int X=1682
int Width=411
int Height=60
boolean Enabled=false
boolean BringToTop=true
string Text="Lotti base utilizzati"
boolean FocusRectangle=false
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within tabpage_1
int X=5
int Y=956
int Width=1207
int Height=64
boolean Enabled=false
boolean BringToTop=true
string Text="Tracciabilità del lotto di base selezionato"
boolean FocusRectangle=false
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_preview from commandbutton within tabpage_1
event clicked pbm_bnclicked
int X=2949
int Y=920
int Width=247
int Height=88
int TabOrder=4
boolean BringToTop=true
string Text="Preview"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if this.text="Preview" then
  dw_2.object.datawindow.print.preview='yes'
  dw_2.object.datawindow.print.preview.zoom='100'
  this.text="Exit"
else
  dw_2.object.datawindow.print.preview='no'
  this.text="Preview"
end if	
end event

type cb_1 from commandbutton within tabpage_1
int X=2606
int Y=920
int Width=247
int Height=88
int TabOrder=5
boolean BringToTop=true
string Text="Stampa"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;


printsetup()
dw_2.print()
end event

type cb_an_canc from commandbutton within w_lotto_specifica_cx
int X=2766
int Y=20
int Width=521
int Height=84
int TabOrder=20
boolean Enabled=false
boolean BringToTop=true
string Text="Annulla cancellazione"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
integer li_num_colonne,i
string ls_find
long ll_vuoto[]

tab_1.tabpage_1.dw_lotto_ff.retrieve()
tab_1.tabpage_1.dw_1.retrieve(il_id_retrieve)
ds_mov_lotto.retrieve()
ds_riepilogo.retrieve()
tab_1.tabpage_1.dw_1.scrolltorow(2)
tab_1.tabpage_1.dw_1.scrolltorow(1)

li_num_colonne=integer(tab_1.tabpage_1.dw_lotto_ff.object.datawindow.column.count)
for i = 1 to li_num_colonne
	ls_find="#"+string(i)+".background.color = 16777215"
	tab_1.tabpage_1.dw_lotto_ff.modify(ls_find)
next
tab_1.tabpage_1.dw_2.modify("datawindow.detail.color=536870912")
il_id_documento=ll_vuoto
tab_1.tabpage_1.dw_lotto_ff.object.datawindow.readonly="no"

this.enabled=false
cb_cancella.enabled=true
end event

type cb_rip from commandbutton within w_lotto_specifica_cx
int X=1650
int Y=24
int Width=247
int Height=108
int TabOrder=21
boolean Visible=false
boolean BringToTop=true
string Text="none"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long i, ll_riga, id_doc, id_prof, ll_ret
datastore ds_riga_doc
boolean fatto=false

ds_riga_doc=create datastore
ds_riga_doc.dataobject="ds_riga_doc_lotto2_gd"
ds_riga_doc.settransobject(sqlca)
ds_riga_doc.retrieve()

ll_riga=ds_riga_doc.rowcount()
for i = 1 to ll_riga
	id_doc=ds_riga_doc.getitemnumber(i,"id_doc")
	select id_prof_documento
	into :id_prof
	from documento
	where documento.id_documento=:id_doc;
	if sqlca.sqlcode<>0 then
		ds_riga_doc.deleterow(i)
		fatto=true
		ll_riga=ds_riga_doc.rowcount()
	end if
next

if fatto then 
	ll_ret=ds_riga_doc.update()
	messagebox('','fatto')
end if

end event

