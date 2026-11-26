forward
global type w_lung_peso_batch_cx from w_001
end type
type dw_1 from udw_base within w_lung_peso_batch_cx
end type
type dw_2 from udw_base within w_lung_peso_batch_cx
end type
type dw_3 from udw_base within w_lung_peso_batch_cx
end type
type cb_ricerca from commandbutton within w_lung_peso_batch_cx
end type
type cb_salva from commandbutton within w_lung_peso_batch_cx
end type
type cb_esci from commandbutton within w_lung_peso_batch_cx
end type
type dw_4 from udw_base within w_lung_peso_batch_cx
end type
type dw_5 from udw_base within w_lung_peso_batch_cx
end type
type st_2 from statictext within w_lung_peso_batch_cx
end type
type st_3 from statictext within w_lung_peso_batch_cx
end type
end forward

global type w_lung_peso_batch_cx from w_001
int Width=2555
int Height=1648
WindowType WindowType=main!
boolean TitleBar=true
string Title="Ricostruisci Lunghezze Personalizzate"
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
dw_1 dw_1
dw_2 dw_2
dw_3 dw_3
cb_ricerca cb_ricerca
cb_salva cb_salva
cb_esci cb_esci
dw_4 dw_4
dw_5 dw_5
st_2 st_2
st_3 st_3
end type
global w_lung_peso_batch_cx w_lung_peso_batch_cx

on w_lung_peso_batch_cx.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_2=create dw_2
this.dw_3=create dw_3
this.cb_ricerca=create cb_ricerca
this.cb_salva=create cb_salva
this.cb_esci=create cb_esci
this.dw_4=create dw_4
this.dw_5=create dw_5
this.st_2=create st_2
this.st_3=create st_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.dw_3
this.Control[iCurrent+4]=this.cb_ricerca
this.Control[iCurrent+5]=this.cb_salva
this.Control[iCurrent+6]=this.cb_esci
this.Control[iCurrent+7]=this.dw_4
this.Control[iCurrent+8]=this.dw_5
this.Control[iCurrent+9]=this.st_2
this.Control[iCurrent+10]=this.st_3
end on

on w_lung_peso_batch_cx.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.cb_ricerca)
destroy(this.cb_salva)
destroy(this.cb_esci)
destroy(this.dw_4)
destroy(this.dw_5)
destroy(this.st_2)
destroy(this.st_3)
end on

event open;call super::open;dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
dw_3.settransobject(sqlca)
end event

type dw_1 from udw_base within w_lung_peso_batch_cx
int X=18
int Y=24
int Width=1957
int Height=616
boolean BringToTop=true
string DataObject="d_lung_recupera_batch"
boolean HScrollBar=true
end type

type dw_2 from udw_base within w_lung_peso_batch_cx
int X=18
int Y=664
int Width=1184
int Height=432
int TabOrder=20
boolean BringToTop=true
string DataObject="d_lung_peso_batch"
end type

type dw_3 from udw_base within w_lung_peso_batch_cx
int X=1554
int Y=664
int Width=942
int Height=432
int TabOrder=40
boolean BringToTop=true
string DataObject="d_righe_lung_peso_batch"
end type

type cb_ricerca from commandbutton within w_lung_peso_batch_cx
int X=1495
int Y=1124
int Width=311
int Height=108
int TabOrder=50
boolean BringToTop=true
string Text="Ricerca Dati"
boolean Default=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.retrieve()
end event

type cb_salva from commandbutton within w_lung_peso_batch_cx
int X=1842
int Y=1124
int Width=311
int Height=108
int TabOrder=60
boolean BringToTop=true
string Text="Salva Dati"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long i, ll_righe,ll_righe_dw_2, ll_riga_trovata,ll_id_riga, ll_id_lung,ll_id_riga_da_salvare,  a
integer li_test 
datetime ldt_data_ora
long ll_id_sog, ll_id_art
decimal ld_dim_l, ld_peso_unitario
string ls_um

ll_righe=dw_1.rowcount()

for i= 1 to ll_righe
	li_test=dw_1.getitemnumber(i, "test")
	if li_test=0 then
		ll_id_sog =dw_1.getitemnumber(i, "sog_commerciale_id_sog_commerciale")
		ldt_data_ora=dw_1.getitemdatetime(i, "data_ora_creazione")
		ll_id_art=dw_1.getitemnumber(i, "riga_documento_id_articolo")
		ls_um=dw_1.getitemstring(i, "unita_misura_simbolo")
		if isnull(ls_um) then ls_um='CM'
		ld_dim_l=dw_1.getitemdecimal(i, "riga_documento_dim_l")
		if isnull(ld_dim_l) then ld_dim_l=0
		ld_peso_unitario=dw_1.getitemdecimal(i, "peso_unitario")
		if isnull(ld_peso_unitario) then ld_peso_unitario=0
		ll_id_riga=dw_1.getitemnumber(i, "id_riga_documento")
		
		update orafo_lung_peso
		set id_sog_commerciale=:ll_id_sog, id_articolo=:ll_id_art,
		ultimo_aggiornamento=:ldt_data_ora, id_riga_documento=:ll_id_riga,
		lunghezza=:ld_dim_l, peso_unitario=:ld_peso_unitario,
		simbolo_um=:ls_um
		where  id_sog_commerciale=:ll_id_sog
		and  id_articolo=:ll_id_art
		and lunghezza=:ld_dim_l
		and simbolo_um=:ls_um;
		if sqlca.sqlnrows>0 then
			commit;
		else
			insert into orafo_lung_peso
			(id_sog_commerciale, id_articolo, ultimo_aggiornamento, lunghezza,
			simbolo_um, peso_unitario, id_riga_documento)
			values (:ll_id_sog, :ll_id_art, :ldt_data_ora, :ld_dim_l,
			:ls_um, :ld_peso_unitario, :ll_id_riga);
			if sqlca.sqlcode=0 then
				commit;
			else 
				rollback;
				dw_5.insertrow(1)
				dw_5.setitem(1, "id_riga", ll_id_riga)
				
			end if
		end if
		
	
	end if
next

ll_righe_dw_2=dw_2.retrieve()
dw_1.setfilter("")
dw_1.filter()
ll_righe=dw_1.retrieve()

for i= 1 to ll_righe
	li_test=dw_1.getitemnumber(i, "test")
	if li_test=0 then 
		ll_id_riga=dw_1.getitemnumber(i , "id_riga_documento")
	end if
	ll_riga_trovata=dw_2.find("id_riga_documento="+string(ll_id_riga), 1, ll_righe_dw_2)
	if ll_riga_trovata>0 then
		dw_3.reset()
		ll_id_lung=dw_2.getitemnumber(ll_riga_trovata, "id_lung_peso")
		ll_id_riga_da_salvare=dw_1.getitemnumber(i , "id_riga_documento")
		ldt_data_ora=dw_1.getitemdatetime(i , "data_ora_creazione")
		if dw_3.retrieve(ll_id_riga_da_salvare)=1 then
			dw_3.deleterow(1)
			if dw_3.update()=1 then
				commit;
			else
				rollback;
				messagebox("Errore!", "Riga non cancellata "+string(i))
			end if
		end if
		dw_3.insertrow(1)
		dw_3.setitem(1, "id_lung_peso", ll_id_lung)
		dw_3.setitem(1, "id_riga_documento", ll_id_riga_da_salvare)
		dw_3.setitem(1, "data_movimento", ldt_data_ora)
		if dw_3.update()=1 then
			commit;
		else
			rollback;
			messagebox("Errore!", "Riga non inserita "+string(i))
		end if
		
	else
		dw_4.insertrow(1)
		dw_4.setitem(1, "id_riga", ll_id_riga)
		
	end if
	
	
next

messagebox("Informazione!", "Operazione Conclusa!")
end event

type cb_esci from commandbutton within w_lung_peso_batch_cx
int X=2190
int Y=1124
int Width=311
int Height=108
int TabOrder=70
boolean BringToTop=true
string Text="Esci"
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(parent)
end event

type dw_4 from udw_base within w_lung_peso_batch_cx
int X=1202
int Y=664
int Width=347
int Height=432
int TabOrder=30
boolean BringToTop=true
string DataObject="d_id_riga_mancante"
end type

type dw_5 from udw_base within w_lung_peso_batch_cx
int X=1998
int Y=20
int Width=498
int Height=624
int TabOrder=20
boolean BringToTop=true
string DataObject="d_id_riga_mancante"
end type

type st_2 from statictext within w_lung_peso_batch_cx
int X=37
int Y=1112
int Width=1417
int Height=184
boolean Enabled=false
boolean BringToTop=true
string Text="Il programma prende in cosiderazione solo i movimenti che abbiano nel profilo documento il campo ~"aggiorna peso e lung. pers.~" impostato a ~"SI SEMPRE~"."
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

type st_3 from statictext within w_lung_peso_batch_cx
int X=46
int Y=1288
int Width=2386
int Height=196
boolean Enabled=false
boolean BringToTop=true
string Text="Dopo di che ordina i movimenti dal più vecchio al più recente e, in caso di movimenti generanti record con stesso articolo, lunghezza, unità di misura, soggetto comm., sovrascrive il più recente sopra al più vecchio e salva comunque nello storico quest'ultimo."
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

