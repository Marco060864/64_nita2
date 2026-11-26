forward
global type w_righe_no_partita_st from w_wiz_main
end type
type cb_ok from commandbutton within w_righe_no_partita_st
end type
type dw_disallineate from datawindow within w_righe_no_partita_st
end type
type dw_1 from datawindow within w_righe_no_partita_st
end type
type cb_annulla from commandbutton within w_righe_no_partita_st
end type
type sle_pg from singlelineedit within w_righe_no_partita_st
end type
type st_1 from statictext within w_righe_no_partita_st
end type
type st_2 from statictext within w_righe_no_partita_st
end type
type sle_copie from singlelineedit within w_righe_no_partita_st
end type
type sle_zoom from singlelineedit within w_righe_no_partita_st
end type
type cb_salva_su_file from commandbutton within w_righe_no_partita_st
end type
type cb_7 from commandbutton within w_righe_no_partita_st
end type
type cb_6 from commandbutton within w_righe_no_partita_st
end type
type cb_imp_st from commandbutton within w_righe_no_partita_st
end type
type cb_stampa from commandbutton within w_righe_no_partita_st
end type
type cb_preview from commandbutton within w_righe_no_partita_st
end type
type st_num_righe from statictext within w_righe_no_partita_st
end type
type cb_correggi from commandbutton within w_righe_no_partita_st
end type
type cb_val_scarico_aper from commandbutton within w_righe_no_partita_st
end type
type cb_ricontrolla from commandbutton within w_righe_no_partita_st
end type
end forward

global type w_righe_no_partita_st from w_wiz_main
int X=78
int Y=48
int Width=3543
int Height=1560
boolean TitleBar=true
string Title="Stampa Saldi Clienti/Fornitori"
boolean Resizable=false
cb_ok cb_ok
dw_disallineate dw_disallineate
dw_1 dw_1
cb_annulla cb_annulla
sle_pg sle_pg
st_1 st_1
st_2 st_2
sle_copie sle_copie
sle_zoom sle_zoom
cb_salva_su_file cb_salva_su_file
cb_7 cb_7
cb_6 cb_6
cb_imp_st cb_imp_st
cb_stampa cb_stampa
cb_preview cb_preview
st_num_righe st_num_righe
cb_correggi cb_correggi
cb_val_scarico_aper cb_val_scarico_aper
cb_ricontrolla cb_ricontrolla
end type
global w_righe_no_partita_st w_righe_no_partita_st

type variables
INTEGER II_ZOOM=100
end variables

forward prototypes
public function string uf_controlla_dati ()
public function date uf_prossimo_mese (readonly date data_attuale)
end prototypes

public function string uf_controlla_dati ();


string ls_tipo_registro,ls_flag_registri,ls_filtro,ls_flag_definitiva,ls_ret,ls_st_reg_iva,ls_st_reg2_iva
long ll_row,ll_n_registro
date ld_dalla_data,ld_alla_data

ll_row=dw_1.getrow()
ls_tipo_registro=dw_1.getitemstring(ll_row,"tipo_registro")
ld_dalla_data=dw_1.getitemdate(ll_row,"dalla_data")
ld_alla_data=dw_1.getitemdate(ll_row,"alla_data")
ls_flag_registri=dw_1.getitemstring(ll_row,"tutti_reg")
ll_n_registro=dw_1.getitemnumber(ll_row,"numero_registro")
ls_flag_definitiva=dw_1.getitemstring(ll_row,"elab_prova")




ls_ret='OK'
if ls_flag_registri='N' then
	
DECLARE ws_registri_iva_cur CURSOR FOR
  SELECT "ws_registri_iva"."st_reg_iva"  
    FROM "ws_registri_iva",   
           
   WHERE ( "ws_registri_iva"."tipo_registro" = :ls_tipo_registro ) and  
         ( "ws_registri_iva"."numero" = :ll_n_registro  ) and  
         ( "ws_registri_iva"."data_registrazione" >= :ld_dalla_data  ) and  
         ( "ws_registri_iva"."data_registrazione" <= :ld_alla_data ); 
         

OPEN ws_registri_iva_cur;

FETCH ws_registri_iva_cur INTO :ls_st_reg_iva;

DO WHILE sqlca.sqlcode=0
	IF ls_st_reg_iva<>'N' THEN
	   ls_ret='KO'
   END IF
	FETCH ws_registri_iva_cur INTO :ls_st_reg_iva;
LOOP

CLOSE ws_registri_iva_cur;


DECLARE ws_registri2_iva_cur CURSOR FOR
  SELECT "ws_registri_iva"."st_reg_iva_a"  
    FROM "ws_registri_iva",   
           
   WHERE ( "ws_registri_iva"."tipo_registro" = :ls_tipo_registro ) and  
         ( "ws_registri_iva"."numero" = :ll_n_registro  ) and 
         ( "ws_registri_iva"."data_registrazione" >= :ld_dalla_data  ) and  
         ( "ws_registri_iva"."data_registrazione" <= :ld_alla_data ); 
         

OPEN ws_registri2_iva_cur ;

FETCH ws_registri2_iva_cur  INTO :ls_st_reg2_iva;

DO WHILE sqlca.sqlcode=0
	IF ls_st_reg2_iva<>'N' THEN
	   ls_ret='KO'
   END IF
	FETCH ws_registri2_iva_cur INTO :ls_st_reg2_iva;
LOOP

CLOSE ws_registri2_iva_cur;
return ls_ret
else
	
	
	
	
	
DECLARE ws_registri3_iva_cur CURSOR FOR
  SELECT "ws_registri_iva"."st_reg_iva"  
    FROM "ws_registri_iva",   
           
   WHERE ( "ws_registri_iva"."tipo_registro" = :ls_tipo_registro ) and  
         
         ( "ws_registri_iva"."data_registrazione" >= :ld_dalla_data  ) and  
         ( "ws_registri_iva"."data_registrazione" <= :ld_alla_data ); 
         

OPEN ws_registri3_iva_cur;

FETCH ws_registri3_iva_cur INTO :ls_st_reg_iva;

DO WHILE sqlca.sqlcode=0
	IF ls_st_reg_iva<>'N' THEN
	   ls_ret='KO'
   END IF
	FETCH ws_registri3_iva_cur INTO :ls_st_reg_iva;
LOOP

CLOSE ws_registri3_iva_cur;


DECLARE ws_registri4_iva_cur CURSOR FOR
  SELECT "ws_registri_iva"."st_reg_iva_a"  
    FROM "ws_registri_iva",   
           
   WHERE ( "ws_registri_iva"."tipo_registro" = :ls_tipo_registro ) and  
         
         ( "ws_registri_iva"."data_registrazione" >= :ld_dalla_data  ) and  
         ( "ws_registri_iva"."data_registrazione" <= :ld_alla_data ); 
         

OPEN ws_registri4_iva_cur ;

FETCH ws_registri4_iva_cur  INTO :ls_st_reg2_iva;

DO WHILE sqlca.sqlcode=0
	IF ls_st_reg2_iva<>'N' THEN
	   ls_ret='KO'
   END IF
	FETCH ws_registri2_iva_cur INTO :ls_st_reg2_iva;
LOOP

CLOSE ws_registri4_iva_cur;
return ls_ret
end if

end function

public function date uf_prossimo_mese (readonly date data_attuale);integer mese,anno,day,giorni_mese
date nuova_data
anno=year(data_attuale)
mese=month(data_attuale)
if mese=12 then
	mese=1
	anno=anno+1
else
mese=mese+1
end if
day=day(data_attuale)


giorni_mese=f_gmese(mese,anno)
if day>giorni_mese then
	day=giorni_mese
end if

nuova_data=date(string(day)+"/"+string(mese)+"/"+string(anno))
return nuova_data
end function

on w_righe_no_partita_st.create
int iCurrent
call super::create
this.cb_ok=create cb_ok
this.dw_disallineate=create dw_disallineate
this.dw_1=create dw_1
this.cb_annulla=create cb_annulla
this.sle_pg=create sle_pg
this.st_1=create st_1
this.st_2=create st_2
this.sle_copie=create sle_copie
this.sle_zoom=create sle_zoom
this.cb_salva_su_file=create cb_salva_su_file
this.cb_7=create cb_7
this.cb_6=create cb_6
this.cb_imp_st=create cb_imp_st
this.cb_stampa=create cb_stampa
this.cb_preview=create cb_preview
this.st_num_righe=create st_num_righe
this.cb_correggi=create cb_correggi
this.cb_val_scarico_aper=create cb_val_scarico_aper
this.cb_ricontrolla=create cb_ricontrolla
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ok
this.Control[iCurrent+2]=this.dw_disallineate
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.cb_annulla
this.Control[iCurrent+5]=this.sle_pg
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.sle_copie
this.Control[iCurrent+9]=this.sle_zoom
this.Control[iCurrent+10]=this.cb_salva_su_file
this.Control[iCurrent+11]=this.cb_7
this.Control[iCurrent+12]=this.cb_6
this.Control[iCurrent+13]=this.cb_imp_st
this.Control[iCurrent+14]=this.cb_stampa
this.Control[iCurrent+15]=this.cb_preview
this.Control[iCurrent+16]=this.st_num_righe
this.Control[iCurrent+17]=this.cb_correggi
this.Control[iCurrent+18]=this.cb_val_scarico_aper
this.Control[iCurrent+19]=this.cb_ricontrolla
end on

on w_righe_no_partita_st.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.dw_disallineate)
destroy(this.dw_1)
destroy(this.cb_annulla)
destroy(this.sle_pg)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.sle_copie)
destroy(this.sle_zoom)
destroy(this.cb_salva_su_file)
destroy(this.cb_7)
destroy(this.cb_6)
destroy(this.cb_imp_st)
destroy(this.cb_stampa)
destroy(this.cb_preview)
destroy(this.st_num_righe)
destroy(this.cb_correggi)
destroy(this.cb_val_scarico_aper)
destroy(this.cb_ricontrolla)
end on

event closequery;

end event

event open;call super::open;long ll_riga
date ld_data, ldt_data_inizio

ll_riga=dw_1.insertrow(0)
ld_data=today()
dw_1.setitem(ll_riga, "a_data", ld_data)
select data_inizio
into :ldt_data_inizio
from esercizio e, azienda a
where e.id_esercizio=a.id_esercizio
and a.id_azienda=1;
if sqlca.sqlcode=0 then
	
	dw_1.setitem(1, "da_data", ldt_data_inizio)
else
	messagebox("Errore!", "Esercizio non recuperato: confronta esercizio corrente in dati azienda")
end if
dw_disallineate.settransobject(sqlca)

end event

event ue_post_open;call super::ue_post_open;
end event

event resize;dw_DISALLIneate.height=newheight - 300
dw_DISALLIneate.width=newwidth - 75
end event

type cb_ok from commandbutton within w_righe_no_partita_st
event clicked pbm_bnclicked
int X=2107
int Y=148
int Width=219
int Height=88
int TabOrder=10
boolean BringToTop=true
string Text="Cerca"
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;date ld_da_data, ld_a_data
long ll_righe

dw_disallineate.dataobject='d_trova_righe_no_scarico'
dw_disallineate.settransobject(sqlca)
dw_disallineate.setfilter("")
dw_disallineate.filter()
ld_da_data=dw_1.getitemdate(1,"da_data")
ld_a_data=dw_1.getitemdate(1,"a_data")
If (IsNull(ld_da_data) or IsNull(ld_a_data)) then
	MessageBox("Stampa movimenti disallineati","Le date di inizio e fine sono obbligatorie",exclamation!)
	Return
End If
If ld_da_data > ld_a_data then
	MessageBox("Stampa movimenti disallineati","La data iniziale è maggiore di quella finale",exclamation!)
	Return
End If

ll_righe=dw_disallineate.retrieve(ld_da_data, ld_a_data)
dw_disallineate.setfilter("abs(test)>1000")
dw_disallineate.filter()
st_num_righe.text="Righe controllate: "+string(ll_righe)
if dw_disallineate.rowcount()>0 then cb_correggi.enabled=true

end event

type dw_disallineate from datawindow within w_righe_no_partita_st
int X=27
int Y=256
int Width=3456
int Height=1144
int TabOrder=130
boolean BringToTop=true
string DataObject="d_trova_righe_no_scarico"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event printstart;integer li_copie
string ls_pg, ls_orienta

li_copie=integer(sle_copie.text)
if isnull(li_copie) or li_copie=0 then li_copie=1
Modify("DataWindow.Print.copies = "+string(li_copie))

ls_pg=sle_pg.text
Modify("DataWindow.Print.Page.Range = '"+ls_pg+"'")
end event

type dw_1 from datawindow within w_righe_no_partita_st
int X=9
int Y=144
int Width=997
int Height=100
int TabOrder=120
boolean BringToTop=true
string DataObject="d_da_data"
boolean Border=false
boolean LiveScroll=true
end type

type cb_annulla from commandbutton within w_righe_no_partita_st
int X=37
int Y=24
int Width=219
int Height=88
int TabOrder=110
boolean BringToTop=true
string Text="&Chiudi"
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

Close(Parent)
end event

type sle_pg from singlelineedit within w_righe_no_partita_st
int X=1422
int Y=20
int Width=503
int Height=92
int TabOrder=20
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_righe_no_partita_st
int X=1157
int Y=28
int Width=270
int Height=76
boolean Enabled=false
string Text="Stampa Pg.:"
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

type st_2 from statictext within w_righe_no_partita_st
int X=1938
int Y=28
int Width=151
int Height=76
boolean Enabled=false
string Text="Copie:"
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

type sle_copie from singlelineedit within w_righe_no_partita_st
int X=2085
int Y=20
int Width=165
int Height=92
int TabOrder=30
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

type sle_zoom from singlelineedit within w_righe_no_partita_st
int X=750
int Y=20
int Width=146
int Height=92
int TabOrder=40
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
string Text="100"
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;ii_zoom=integer(this.text)
dw_disallineate.object.datawindow.zoom=ii_zoom

end event

type cb_salva_su_file from commandbutton within w_righe_no_partita_st
int X=2885
int Y=24
int Width=320
int Height=88
int TabOrder=50
string Text="Salva su &File"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_disallineate.SaveAs()
end event

type cb_7 from commandbutton within w_righe_no_partita_st
int X=901
int Y=24
int Width=242
int Height=88
int TabOrder=60
string Text="Zoom Out"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;ii_zoom=ii_zoom - 5
dw_disallineate.object.datawindow.zoom=ii_zoom
sle_zoom.text=string(ii_zoom)
end event

type cb_6 from commandbutton within w_righe_no_partita_st
int X=530
int Y=24
int Width=219
int Height=88
int TabOrder=100
string Text="Zoom In"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;ii_zoom=ii_zoom+5
dw_disallineate.object.datawindow.zoom=ii_zoom
sle_zoom.text=string(ii_zoom)
end event

type cb_imp_st from commandbutton within w_righe_no_partita_st
int X=2555
int Y=24
int Width=297
int Height=88
int TabOrder=90
string Text="Imp. Stamp."
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;printsetup()
dw_disallineate.object.datawindow.print.preview='yes'
dw_disallineate.object.datawindow.print.preview.rulers='yes'
end event

type cb_stampa from commandbutton within w_righe_no_partita_st
int X=3237
int Y=24
int Width=261
int Height=88
int TabOrder=80
string Text="&Stampa"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;printsetup()
dw_disallineate.print()
end event

type cb_preview from commandbutton within w_righe_no_partita_st
int X=2263
int Y=24
int Width=261
int Height=88
int TabOrder=70
string Text="Preview"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if cb_preview.text='Preview' then
	cb_preview.text='Ritorna'
	dw_disallineate.object.datawindow.print.preview='yes'
	dw_disallineate.object.datawindow.print.preview.rulers='yes'
else
	cb_preview.text='Preview'
	dw_disallineate.object.datawindow.print.preview='no'
	dw_disallineate.object.datawindow.print.preview.rulers='no'
end if
end event

type st_num_righe from statictext within w_righe_no_partita_st
int X=1024
int Y=152
int Width=571
int Height=88
boolean Enabled=false
boolean BringToTop=true
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

type cb_correggi from commandbutton within w_righe_no_partita_st
int X=2286
int Y=148
int Width=261
int Height=88
int TabOrder=140
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
string Text="Correggi"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;boolean lb_found
DECIMAL{4} LD_VAL_SCARICO
long ll_breakrow, ll_id_partita, ll_id_riga
ll_breakrow = 0
ll_id_riga=messagebox("Attenzione!", "Prima di procedere è opportuno fare una copia di sicurezza del DB!~r~n"&
+"Vuoi proseguire lo stesso?", stopsign!, yesno!)
if ll_id_riga=1 then
	ll_id_riga=0
	DO WHILE ll_breakrow>=0
	
	ll_breakrow = dw_DISALLINEATE.FindGroupChange(ll_breakrow, 1)
		
		IF ll_breakrow <= 0 THEN EXIT
		
		LD_VAL_SCARICO= dw_DISALLINEATE.GetItemdecimal(ll_breakrow, "fino_calo")
		ll_id_partita= dw_DISALLINEATE.GetItemNumber(ll_breakrow, "orafo_scar_partita_id_partita")
		ll_id_riga= dw_DISALLINEATE.GetItemNumber(ll_breakrow, "riga_documento_id_riga_partita")
		update orafo_scar_partita
		set val_scarico=:LD_VAL_SCARICO
		where id_partita=:ll_id_partita
		and id_riga_documento=:ll_id_riga
		;
		if sqlca.sqlnrows<=0 then lb_found=true
		
		ll_breakrow = ll_breakrow + 1
	LOOP
	if lb_found then messagebox("Errore!", "Ci sono righe senza partita: correzione incompleta")
	enabled=false
end if


end event

type cb_val_scarico_aper from commandbutton within w_righe_no_partita_st
int X=2350
int Y=148
int Width=649
int Height=88
int TabOrder=150
boolean BringToTop=true
string Text="Allinea aperture e scarichi"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_righe_agg, ll_righe_annu, ll_stato_a, ll_stato_c
this.enabled=false
datastore ds_canc_scar_senza_righe, ds_aper_senza_scar
ds_canc_scar_senza_righe=create datastore
ds_canc_scar_senza_righe.dataobject="d_scarichi_senza_righe"
ds_canc_scar_senza_righe.settransobject(sqlca)
ll_righe_agg=ds_canc_scar_senza_righe.retrieve()
if ll_righe_agg>0 then
	if messagebox("Attenzione!", "Esistono scarichi senza righe. Cancellare?", stopsign! , yesno!)=1 then
		ds_canc_scar_senza_righe.rowsmove(1, ll_righe_agg, primary!, ds_canc_scar_senza_righe, 1, delete!)
		ll_righe_agg=ds_canc_scar_senza_righe.update()
		if ll_righe_agg=1 then
			commit;
		else
			messagebox("Errore!", "Esistono scarichi senza riga madre non cancellabili da questa procedura!")
			rollback;
		end if
	end if
end if
destroy(ds_canc_scar_senza_righe)

if messagebox("Attenzione!", "Continuo con il controllo dei valori ?", stopsign!, yesno!)<>1 then return

ds_aper_senza_scar=create datastore
ds_aper_senza_scar.dataobject="d_aper_senza_scar"
ds_aper_senza_scar.settransobject(sqlca)
ll_righe_agg=ds_aper_senza_scar.retrieve()
if ll_righe_agg>0 then
	for ll_righe_annu= 1 to ll_righe_agg
		ds_aper_senza_scar.setitem(ll_righe_annu, "orafo_aper_partita_val_scarico", 0)
		ds_aper_senza_scar.setitem(ll_righe_annu, "orafo_aper_partita_stato", "A")
	next
	ll_righe_agg=ds_aper_senza_scar.update()
	if ll_righe_agg=1 then
		commit;
	else
		messagebox("Errore!", "Esistono aperture con valore scarico non allineato!")
		rollback;
	end if
end if
destroy(ds_aper_senza_scar)
ll_righe_agg=0
ll_righe_annu=0

update orafo_aper_partita a
set val_scarico=(select sum(val_scarico) from orafo_scar_partita where id_partita=a.id_partita)
where val_scarico>(select sum(val_scarico) 
from orafo_scar_partita where id_partita=a.id_partita)
;
ll_righe_agg=sqlca.sqlnrows
if ll_righe_agg>0 then
	commit;
else
	rollback;
end if

update riga_documento
set id_riga_partita=null
where id_riga_partita >0
and id_riga_partita not in (select id_riga_documento from orafo_scar_partita)
;
ll_righe_annu=sqlca.sqlnrows
if ll_righe_annu>0 then
	commit;
else
	rollback;
end if

update orafo_aper_partita
set stato='C'
where val_apertura <= val_scarico
+ (select val_arrotondamento 
from orafo_metallo m, orafo_titolo t  
where t.id_titolo=orafo_aper_partita.id_titolo
and m.id_titolo=t.id_titolo)
and stato<>'C'
;
ll_stato_c=sqlca.sqlnrows
if ll_stato_c>0 then
	commit;
else
	rollback;
end if
 
update orafo_aper_partita
set stato='A'
where val_apertura>val_scarico
- (select val_arrotondamento 
from orafo_metallo m, orafo_titolo t  
where t.id_titolo=orafo_aper_partita.id_titolo
and m.id_titolo=t.id_titolo)
and stato<>'A'
;
ll_stato_a=sqlca.sqlnrows
if ll_stato_a>0 then
	commit;
else
	rollback;
end if

messagebox("Informazione!", "Valori scarico aggiornati: "+string(ll_righe_agg)+&
"~r~nLegami riga - scarico annullati: "+string(ll_righe_annu)&
+"~r~nPartite riaperte: "+string(ll_stato_a)&
+"~r~nPartite chiuse:"+string(ll_stato_c))
this.enabled=true
end event

type cb_ricontrolla from commandbutton within w_righe_no_partita_st
int X=3022
int Y=148
int Width=475
int Height=88
int TabOrder=160
boolean BringToTop=true
string Text="Righe Senza Partita"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_disallineate.dataobject='d_righe_senza_id_riga_partita'
dw_disallineate.settransobject(sqlca)
dw_disallineate.retrieve()
cb_correggi.enabled=false
end event

