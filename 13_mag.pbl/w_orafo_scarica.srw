forward
global type w_orafo_scarica from Window
end type
type sle_cod_barre from singlelineedit within w_orafo_scarica
end type
type cb_1 from commandbutton within w_orafo_scarica
end type
type st_1 from statictext within w_orafo_scarica
end type
type dw_2 from datawindow within w_orafo_scarica
end type
type dw_1 from datawindow within w_orafo_scarica
end type
end forward

global type w_orafo_scarica from Window
int X=321
int Y=301
int Width=3059
int Height=961
boolean TitleBar=true
string Title="Scarico"
long BackColor=79741120
boolean ControlMenu=true
WindowType WindowType=response!
event ue_post_open ( )
sle_cod_barre sle_cod_barre
cb_1 cb_1
st_1 st_1
dw_2 dw_2
dw_1 dw_1
end type
global w_orafo_scarica w_orafo_scarica

event ue_post_open;long ll_locazione, ll_riga
long ll_numero_righe, ll_id_articolo
string ls_appoggio

ll_riga=dw_2.getrow()
ll_locazione=dw_2.getitemnumber(ll_riga, "id_locazione")

if ll_locazione>=1 or not isnull(ll_locazione) then
	dw_1.retrieve(ll_locazione)
   ll_numero_righe = dw_1.rowcount()
	
	for ll_riga = 1 to ll_numero_righe 
		ll_id_articolo = dw_1.getitemnumber(ll_riga,"riga_documento_id_articolo")
		SELECT "articolo"."codice"
		INTO :ls_appoggio
		FROM "articolo"
		WHERE "articolo"."id_articolo" = :ll_id_articolo;
		dw_1.setitem(ll_riga,"c_articolo_cod",ls_appoggio)
	next
	
end if 


end event

on w_orafo_scarica.create
this.sle_cod_barre=create sle_cod_barre
this.cb_1=create cb_1
this.st_1=create st_1
this.dw_2=create dw_2
this.dw_1=create dw_1
this.Control[]={ this.sle_cod_barre,&
this.cb_1,&
this.st_1,&
this.dw_2,&
this.dw_1}
end on

on w_orafo_scarica.destroy
destroy(this.sle_cod_barre)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.dw_2)
destroy(this.dw_1)
end on

event open;long ll_riga
ll_riga=dw_2.getrow()

dw_2.settransobject(sqlca)
dw_2.retrieve()

dw_1.settransobject(sqlca)


post event ue_post_open()
end event

type sle_cod_barre from singlelineedit within w_orafo_scarica
int X=1825
int Y=21
int Width=805
int Height=93
int TabOrder=21
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long BackColor=16777215
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;string ls_id_riga
long ll_riga, ll_id_riga
ls_id_riga=trim(this.text)
this.text=""
ls_id_riga=left(ls_id_riga, len(ls_id_riga) - 1)
ll_id_riga=long(ls_id_riga)
ll_riga=dw_1.find("id_riga_sorgente="+string(ll_id_riga), 1, dw_1.rowcount())
if ll_riga>0 then
	dw_1.selectrow(ll_riga, true)
else
	messagebox("Errore!", "L'articolo non è presente in questo magazzino!")
end if

end event

type cb_1 from commandbutton within w_orafo_scarica
int X=2748
int Y=25
int Width=257
int Height=85
int TabOrder=20
string Text="OK"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long i, ll_righe,a,rig
integer li_ret
ll_righe=dw_1.rowcount()

datastore ds_2
ds_2=create datastore
ds_2.settransobject(sqlca)
ds_2.dataobject="d_orafo_riga_documento_ordine_gd2"
ds_2.retrieve()
ds_2.reset()

for i=1 to ll_righe
  if dw_1.isselected(i) then
	a+=1
	  li_ret=dw_1.RowsCopy(i,i, Primary!, ds_2, a, Primary!)
	  
	  if li_ret<>1 then messagebox("1", "riga_non copiata")
	  dw_1.selectrow(i,false)
	  
end if
next

CloseWithReturn(w_orafo_scarica,ds_2) 



end event

type st_1 from statictext within w_orafo_scarica
int X=37
int Y=37
int Width=298
int Height=65
boolean Enabled=false
string Text="Magazzino"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_2 from datawindow within w_orafo_scarica
event ue_post_itemchanged ( long al_riga )
int X=385
int Y=17
int Width=1313
int Height=105
int TabOrder=10
string DataObject="d_magazzino1_gd"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

event ue_post_itemchanged;
long ll_locazione,ll_numero_righe,ll_id_articolo, ll_mag_corrente, ll_id_mag_principale
ll_locazione=dw_2.getitemnumber(al_riga, "id_locazione")
string ls_appoggio, ls_pref_mag_borsa_agenti
ls_appoggio=dw_2.describe("evaluate('lookupdisplay(id_locazione)'," +string(al_riga)+")")
select pref_mag_borsa_agenti
into :ls_pref_mag_borsa_agenti
from par_sistema;
select id_magazzino
into :ll_id_mag_principale
from par_sistema;
select id_magazzino
into :ll_mag_corrente
from locazione
where id_locazione=:ll_locazione;
if sqlca.sqlcode=0 then
	
	if left(ls_appoggio, 1)=ls_pref_mag_borsa_agenti then
		dw_1.dataobject="d_orafo_riga_documento_ordine_gd4"
		dw_1.settransobject(sqlca)
	elseif ll_id_mag_principale=ll_mag_corrente then
		dw_1.dataobject="d_orafo_riga_documento_ordine_gd3"
		dw_1.settransobject(sqlca)
	end if
else
	messagebox("Errore!", "Prefisso per i magazzini borsa agenti non trovato!")
end if

if ll_locazione>=1 or not isnull(ll_locazione) then
	dw_1.retrieve(ll_locazione)
   ll_numero_righe = dw_1.rowcount()

	for al_riga = 1 to ll_numero_righe 
		ll_id_articolo = dw_1.getitemnumber(al_riga,"riga_documento_id_articolo")
		SELECT "articolo"."codice"
		INTO :ls_appoggio
		FROM "articolo"
		WHERE "articolo"."id_articolo" = :ll_id_articolo;
		dw_1.setitem(al_riga,"c_articolo_cod",ls_appoggio)
	next
	
end if
setfocus(sle_cod_barre)
end event

event itemchanged;long ll_current, LL_LOCAZIONE
ll_current=dw_2.getrow()

post event ue_post_itemchanged(ll_current)



 
end event

type dw_1 from datawindow within w_orafo_scarica
int X=37
int Y=129
int Width=2977
int Height=721
int TabOrder=30
string DataObject="d_orafo_riga_documento_ordine_gd3"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event clicked;
dw_1.selectrow(row,not dw_1.isselected(row))


end event

