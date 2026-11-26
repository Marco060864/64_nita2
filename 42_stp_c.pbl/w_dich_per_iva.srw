forward
global type w_dich_per_iva from w_p_data
end type
type dw_1 from u_dw_master_main within w_dich_per_iva
end type
type cb_1 from commandbutton within w_dich_per_iva
end type
type cb_calcola from commandbutton within w_dich_per_iva
end type
type p_1 from picture within w_dich_per_iva
end type
end forward

global type w_dich_per_iva from w_p_data
int X=123
int Y=188
int Height=1556
boolean TitleBar=true
string Title="Gestione Dichiarazione Periodica IVA"
long BackColor=78682240
dw_1 dw_1
cb_1 cb_1
cb_calcola cb_calcola
p_1 p_1
end type
global w_dich_per_iva w_dich_per_iva

type variables

end variables

forward prototypes
public subroutine uf_aggiorna_sk ()
end prototypes

public subroutine uf_aggiorna_sk ();decimal {4} ll_vp1, ll_vp2, ll_vp3, ll_vp4, ll_vp5, ll_vp6, ll_vp7,ll_vp8, ll_vp9, ll_vp10 ,ll_vp11
string ls_tipo
long  ld_iva_deb
long ll_row, ld_iva_ver, ld_dif
string ls

ls_tipo = dw_1.getitemstring(1, "tipo_dichiarazione")

ll_vp5 = dw_1.getitemnumber(1, "vp5")  
ll_vp6 = dw_1.getitemnumber(1, "vp6")  
ll_vp7 = dw_1.getitemnumber(1, "vp7") 
ll_vp8 = dw_1.getitemnumber(1, "vp8") 
ll_vp9 = dw_1.getitemnumber(1, "vp9") 

if ls_tipo = 'T' then
	if ll_vp10 > 0 then
		ll_vp9 = (ll_vp10 * 1.5) /100
		dw_1.setitem(1, "vp9", ll_vp9)
	end if
end if


if ll_vp5 > ll_vp6 then
	ll_vp10 = (ll_vp5 - (ll_vp6 + ll_vp7 + ll_vp8) + ll_vp9)
	dw_1.setitem(1, "vp10", ll_vp10)
end if

if ll_vp5 < ll_vp6 then
	ll_vp11 = ((ll_vp6 + ll_vp7) - ll_vp5)
	dw_1.setitem(1, "vp11", ll_vp11)
end if

ll_row = dw_1.rowcount()

if ll_row > 0 then
	
	ld_iva_deb= dw_1.getitemnumber(ll_row, "vp10")

	if not (isnull(ld_iva_deb)) then
		ld_iva_ver = long (RIGHT(string(ld_iva_deb), 3))
		
		if ld_iva_ver > 500 then
			ld_dif = long (RIGHT(string(ld_iva_deb), 3)) - 500

		else
			ld_dif = long (RIGHT(string(ld_iva_deb), 3)) 

		end if
		
	ld_iva_ver = ld_iva_deb - ld_dif
	dw_1.setitem(ll_row, "vp12", ld_iva_ver)
	end if
	
end if
end subroutine

on w_dich_per_iva.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_1=create cb_1
this.cb_calcola=create cb_calcola
this.p_1=create p_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_calcola
this.Control[iCurrent+4]=this.p_1
end on

on w_dich_per_iva.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.cb_calcola)
destroy(this.p_1)
end on

event open;call super::open;long ll_screenh

idw_master = dw_1
idw_master.is_list = Message.PowerObjectParm

idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_sql_ident[1] = "dich_per_iva.id_dich_per_iva"

ib_NonModale = TRUE

IF UpperBound(idw_master.is_list.s_identifica) = 0 THEN
	idw_master.ias_key_name[1] = "id_dich_per_iva"
	idw_master.is_list.s_modo = modo_inserisci
	
END IF

end event

type p_crescente from w_p_data`p_crescente within w_dich_per_iva
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_dich_per_iva
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_dich_per_iva
int X=27
int Y=28
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_dich_per_iva
int Y=28
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_dich_per_iva
int X=1664
int Y=44
int Width=87
int Height=68
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
FontCharSet FontCharSet=Ansi!
end type

type cb_inserisci from w_p_data`cb_inserisci within w_dich_per_iva
int X=1582
int Y=24
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_dich_per_iva
int X=1819
int Y=28
boolean BringToTop=true
end type

event cb_cancella::clicked;
long ll_riga

ll_riga=dw_1.getrow()
if ll_riga > 0 then
	dw_1.deleterow(ll_riga)
end if
end event

type cb_salva from w_p_data`cb_salva within w_dich_per_iva
int X=2098
int Y=28
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_dich_per_iva
int X=2190
int Y=1332
int Width=192
int Height=148
int TabOrder=30
boolean Visible=false
boolean BringToTop=true
long BackColor=78682240
end type

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=18
int Y=104
int Width=155
int Height=28
end type

type cb_ricerca from w_p_data`cb_ricerca within w_dich_per_iva
int X=1545
int Y=28
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
int Weight=700
FontCharSet FontCharSet=Ansi!
end type

event cb_ricerca::clicked;w_search_main		lw_sm
long					ll_i_dich, ll_row
s_ric_param			ls_ricpar

idw_master.is_ricpar.s_filter_name = "id_dich_per_iva"
idw_master.is_ricpar.s_filter_value=""
OpenWithParm (lw_sm, idw_master.is_ricpar, "w_dich_iva_sc")
idw_master.is_ricpar = Message.PowerObjectParm
IF UpperBound(idw_master.is_ricpar.s_id_seg_value) > 0 THEN
	ll_i_dich = long(idw_master.is_ricpar.s_id_seg_value[1])
	idw_master.is_list.s_modo = modo_modifica
	idw_master.is_list.s_identifica[1] = "id_dich_per_iva"
	idw_master.is_list.l_identifica[1] = ll_i_dich
	idw_master.Event ue_retrieve(0, 0)
	idw_master.SetFocus()
end if

dw_1.enabled = true
cb_calcola.enabled = true
uf_aggiorna_sk()
end event

type dw_1 from u_dw_master_main within w_dich_per_iva
int X=23
int Y=132
int Width=2354
int Height=1312
int TabOrder=10
boolean BringToTop=true
string DataObject="d_dich_per_iva"
end type

event ue_init;call super::ue_init;is_list.s_identifica[1] = "id_dich_per_iva"

end event

type cb_1 from commandbutton within w_dich_per_iva
int X=306
int Y=28
int Width=535
int Height=84
int TabOrder=20
boolean BringToTop=true
string Text="Agg./Mod. Modello"
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

long ll_vp1, ll_vp5, ll_risp, ll_row
date ld_dat1, ld_dat2, ld_dat_dich
decimal {4} de_imponibile, de_imposta, de_imponibile_cee, ll_rif_liq
long ll_id_dich, ll_righe

ll_righe = dw_1.getrow()
IF ll_righe > 0 THEN   
	ll_id_dich= dw_1.getitemnumber(ll_righe, "id_dich_per_iva")

messagebox ('valore recuperato', ll_id_dich)

ll_risp=	messagebox('Attenzione', 'Si procede con la nuova elaborazione del modello ?',Question!,YesNo! ,1)

select data_in_liq, data_fi_liq
	into :ld_dat1, :ld_dat2
	from dich_per_iva
	where id_dich_per_iva = :ll_id_dich;
		
	If ll_risp = 1 then  
	
	open(w_attesa)
		
		DATASTORE ds_acq  
		ds_acq = CREATE DATASTORE
		ds_acq.DATAOBJECT = "d_mov_iva_acq_ven"
		ds_acq.SETTRANSOBJECT(SQLCA)
		ds_acq.RETRIEVE('IA', ld_dat1, ld_dat2)  
		ll_row= ds_acq.rowcount()
		
			if ll_row > 0 then
				de_imponibile= ds_acq.getitemnumber(ll_row, "a")
				de_imposta= ds_acq.getitemnumber(ll_row, "b")
				de_imponibile_cee = ds_acq.getitemnumber(ll_row, "tot_imp_cee")
		
			
			update dich_per_iva
				set vp3 = :de_imponibile, vp6 =:de_imposta , vp4 = :de_imponibile_cee
				where id_dich_per_iva = :ll_id_dich;
				
			end if
		
		DESTROY ds_acq
		
		
		DATASTORE ds_vend  
		ds_vend = CREATE DATASTORE
		ds_vend.DATAOBJECT = "d_mov_iva_acq_ven"
		ds_vend.SETTRANSOBJECT(SQLCA)
		ds_vend.RETRIEVE('IV', ld_dat1, ld_dat2)  
		ll_row= ds_vend.rowcount()
		
			if ll_row > 0 then
				de_imponibile     = ds_vend.getitemnumber(ll_row, "a")
				de_imposta        = ds_vend.getitemnumber(ll_row, "b")
				de_imponibile_cee = ds_vend.getitemnumber(ll_row, "tot_imp_cee")
		
			
			update dich_per_iva
				set vp1 = :de_imponibile, vp5 =:de_imposta , vp2 = :de_imponibile_cee
				where id_dich_per_iva = :ll_id_dich;
				
			end if
		
		DESTROY ds_vend
		
		
		DATASTORE ds_corr 
		ds_corr = CREATE DATASTORE
		ds_corr.DATAOBJECT = "d_mov_iva_acq_ven"
		ds_corr.SETTRANSOBJECT(SQLCA)
		ds_corr.RETRIEVE('IC', ld_dat1, ld_dat2)  
		ll_row= ds_corr.rowcount()
		
			if ll_row > 0 then
				de_imponibile= ds_corr.getitemnumber(ll_row, "a")
				de_imposta= ds_corr.getitemnumber(ll_row, "b")
				
			 select vp1, vp5
				 into :ll_vp1, :ll_vp5
				 from dich_per_iva
				 where id_dich_per_iva = :ll_id_dich;
		
			de_imponibile = ll_vp1 + de_imponibile
			de_imposta    = ll_vp5 + de_imposta
			
		
			update dich_per_iva
				set vp1 = :de_imponibile, vp5 =:de_imposta
				where id_dich_per_iva = :ll_id_dich;
			
			end if
		
		DESTROY ds_corr
		
		
		DATASTORE ds_credito 
		ds_credito = CREATE DATASTORE
		ds_credito.DATAOBJECT = "ds_lista_dich_periodiche_iva"
		ds_credito.SETTRANSOBJECT(SQLCA)
		ds_credito.RETRIEVE()  
		ll_row= ds_credito.rowcount()
		
		if ll_row > 1 then
		ll_row = (ll_row - 1)
		
		  ll_rif_liq = ds_credito.getitemnumber(ll_row, "iva_credito")
		  if not (isnull(ll_rif_liq)) then
		
			update dich_per_iva
				set vp7 = :ll_rif_liq
				where id_dich_per_iva = :ll_id_dich;
			end if
			
		end if  
		DESTROY ds_credito
	close (w_attesa)			
	END IF 

END IF 
end event

type cb_calcola from commandbutton within w_dich_per_iva
int X=878
int Y=24
int Width=265
int Height=84
int TabOrder=40
boolean BringToTop=true
string Text="Calcola"
int TextSize=-8
int Weight=700
string FaceName="Arial"
boolean Italic=true
boolean Underline=true
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;uf_aggiorna_sk()
end event

type p_1 from picture within w_dich_per_iva
int X=1193
int Y=20
int Width=110
int Height=88
boolean BringToTop=true
string PictureName="s:\pb\commonframework\printer.bmp"
boolean FocusRectangle=false
boolean OriginalSize=true
end type

event clicked;
long ll_righe, ll_id

s_st_param strut_dich  

ll_righe = dw_1.getrow()
if ll_righe > 0 then
	ll_id=dw_1.getitemnumber(ll_righe, "id_dich_per_iva")
	strut_dich.id_esercizio = ll_id
	
	OpenWithParm(w_stampa_dichiarazione_rpt, strut_dich)
end if

end event

