forward
global type w_bil_scalare_cx from Window
end type
type cb_1 from commandbutton within w_bil_scalare_cx
end type
type cb_2 from commandbutton within w_bil_scalare_cx
end type
type dw_1 from u_dw_ext_main within w_bil_scalare_cx
end type
end forward

global type w_bil_scalare_cx from Window
int X=832
int Y=360
int Width=2181
int Height=848
boolean TitleBar=true
string Title="Bilancio"
long BackColor=80263581
boolean ControlMenu=true
WindowType WindowType=response!
cb_1 cb_1
cb_2 cb_2
dw_1 dw_1
end type
global w_bil_scalare_cx w_bil_scalare_cx

type variables
long ll_id1,ll_id2,ll_id3,ll_id4
long ll_val_es
end variables

forward prototypes
public subroutine uf_ss (string as_type, string as_dett)
end prototypes

public subroutine uf_ss (string as_type, string as_dett);

long ll_id_conto, ll_ap, ll_ch, ll_riga, ll_num_righe, ll_group, ll_next_group, ll_mm1, ll_mm2, i
decimal ld_conto,ld_dare,ld_avere, ld_null
boolean lb_flag
string ls_cl, ls_fo

setnull(ld_null)

datastore ds_bil
ds_bil=create datastore
if as_type='M' then
	ds_bil.dataobject="ds_mm_bil"
else
	ds_bil.dataobject="ds_ss_bil"
end if	
ds_bil.settransobject(sqlca)
ds_bil.retrieve()

select pref_cod_cliente, pref_cod_fornitore into :ls_cl, :ls_fo
from par_sistema;
select id_mastro into :ll_mm1 from mastro where codice=:ls_cl;
select id_mastro into :ll_mm2 from mastro where codice=:ls_fo;
if as_type='C' and as_dett='F' then
	ds_bil.setfilter("id_mm<>"+string(ll_mm1)+" or id_mm<>"+string(ll_mm2))
   ds_bil.filter()
end if	
if as_type='C' and as_dett='C' then
	ds_bil.setfilter("id_mm="+string(ll_mm1)+" and id_mm="+string(ll_mm2))
   ds_bil.filter()
end if	

ll_riga=ds_bil.rowcount()
for i=1 to ll_riga
	ds_bil.setitem(i,"id_bil_cee",0)
next	
ds_bil.update()

ll_num_righe=1
if ll_riga>0 then
	DO
		ll_group=ds_bil.FindGroupChange(ll_num_righe,1)
		if ll_group>0 then
			ll_next_group=ds_bil.FindGroupChange(ll_group+1,1)
			if ll_next_group>0 then
				ll_riga=ll_next_group - 1
			else
				ll_riga=ds_bil.RowCount()
			end if
		end if
		lb_flag=true
		ll_id_conto=ds_bil.getitemnumber(ll_riga,'id_conto')
		ld_dare=ds_bil.getitemnumber(ll_riga,'sumdare')
		ld_avere=ds_bil.getitemnumber(ll_riga,'sumavere')
		if isnull(ld_dare) then ld_dare=0
		if isnull(ld_avere) then ld_avere=0			
		ld_conto=ld_dare - ld_avere
		if ld_conto<0 then 
			lb_flag=false
			ld_conto=ld_conto* -1
		end if
		if ld_conto<>0 then
			if lb_flag=false then
				UPDATE chiusura_apertura
				SET saldo_avere=:ld_conto, saldo_dare=:ld_null, id_bil_cee=1
				WHERE id_conto=:ll_id_conto; 
			else
				UPDATE chiusura_apertura
				SET saldo_dare=:ld_conto, saldo_avere=:ld_null, id_bil_cee=1
				WHERE id_conto=:ll_id_conto; 
			end if
		end if

		ll_num_righe=ll_group+1
	Loop Until ll_group=0 or ll_riga>=ds_bil.rowcount()
	
	destroy ds_bil
	delete from chiusura_apertura where id_bil_cee=0;
	commit;
	
end if
end subroutine

event open;
dw_1.insertrow(0)
dw_1.setfocus()
datawindowchild ldc_es,ldc_es1,ldc_es2,ldc_val,ldc_azienda

long ll_es
date ld_data, ld_d1, ld_d2
string ls_cod,ls_des, ls_data

dw_1.getchild('id_esercizio',ldc_es)
ldc_es.settransobject(sqlca)
ldc_es.retrieve()
dw_1.getchild('id_azienda',ldc_azienda)
ldc_azienda.settransobject(sqlca)
ldc_azienda.retrieve()
dw_1.getchild('valuta',ldc_val)
ldc_val.settransobject(sqlca)
ldc_val.retrieve()
dw_1.setitem(1,'tipo_mov','P')

dw_1.setitem(1,'id_azienda',1)


ld_data=today()
select id_esercizio, data_inizio,data_fine, id_valuta
into :ll_es, :ld_d1,:ld_d2, :ll_val_es
from esercizio
where data_inizio<=:ld_data and data_fine>=:ld_data;
dw_1.setitem(1,'id_esercizio',ll_es)
ls_data=string(ld_d1,"dd/mm/yyyy")
dw_1.setitem(1,"d_in",ls_data)
ls_data=string(ld_d2,"dd/mm/yyyy")
dw_1.setitem(1,"d_fin",ls_data)	
dw_1.setitem(1,"da",ld_d1)
dw_1.setitem(1,"a",ld_d2)	
dw_1.setitem(1,"valuta",ll_val_es)



end event

on w_bil_scalare_cx.create
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_1=create dw_1
this.Control[]={this.cb_1,&
this.cb_2,&
this.dw_1}
end on

on w_bil_scalare_cx.destroy
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_1)
end on

event key;

keycode			lk_code
string			ls_nome
windowobject	lw_me

lk_code = key

choose case lk_code
	case KeyF12!
		if keyflags=3 then
			ls_nome = this.ClassName()
			MessageBox ("ClassName",ls_nome)
		end if
	case KeyF1!
		if (keyflags = 0 Or keyflags = 1 Or keyflags = 2) then
		end if
end choose
end event

type cb_1 from commandbutton within w_bil_scalare_cx
int X=1874
int Y=40
int Width=247
int Height=84
int TabOrder=10
string Text="Stampa"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

dw_1.accepttext()
delete from chiusura_apertura;
string ls_mod, ls_cf, ls_bloc, ls_stp, ls_aper
long ll_es1,ll_azienda
long ll_id_val, ll_cod_es1, ll_ap, ll_ch
decimal ld_dec_sign, ld_cambio
date ld_da,ld_a, ld_in,ld_fn, ld_in2

s_param ls_param
uo_bilancio_scalare lo_sp

long ll_val_lire
select id_val_lire into :ll_val_lire from par_sistema;

ll_es1=dw_1.getitemnumber(1,"id_esercizio")

select id_prof_reg_apertura, id_prof_reg_chiusura 
into :ll_AP, :ll_CH from par_sistema;

ll_azienda=dw_1.getitemnumber(1,"id_azienda")
ls_stp=dw_1.getitemstring(1,'tipo_stp')
ll_id_val=dw_1.getitemnumber(1,"valuta")
ls_cf=dw_1.getitemstring(1,'cliforn')

if ll_val_es=ll_val_lire then
	SELECT dec_significativi, cambio
	INTO :ld_dec_sign  ,:ld_cambio
	FROM valuta WHERE id_valuta = :ll_id_val;
else	
	SELECT dec_significativi, parita_euro
	INTO :ld_dec_sign  ,:ld_cambio
	FROM valuta WHERE id_valuta = :ll_id_val;
end if
ld_dec_sign=abs(ld_dec_sign)

ld_da=dw_1.getitemdate(1,"da")
ld_a=dw_1.getitemdate(1,"a")
ld_in=date(dw_1.getitemstring(1,"d_in"))
ld_fn=date(dw_1.getitemstring(1,"d_fin"))
if isnull(ld_da) then	ld_da=ld_in	
if isnull(ld_a) then	ld_a=ld_fn	

date ld_comp
open(w_attesa)
select data_competenza into :ld_comp 
from reg_pd where id_prof_registrazione=:ll_ch;
if sqlca.sqlcode<>0 then 
	ld_comp=date('1990-01-01')
else
	ld_comp=relativedate(ld_comp, 1 )
end if

lo_sp = create uo_bilancio_scalare
if ld_in=ld_da and ld_comp = ld_in then 
	lo_sp.of_conti_sp_ch(ld_in, ld_fn,ll_ap,ll_id_val)
else		
	if ld_in=ld_da then
	 	lo_sp.of_conti_sp_iniz(ld_comp, relativedate(ld_da,- 1),ll_ap,ll_id_val)
	else	
	 	lo_sp.of_conti_ce_iniz(ld_in, relativedate(ld_da,- 1),ll_ap,ll_id_val)
		lo_sp.of_conti_sp_iniz(ld_comp, relativedate(ld_da,- 1),ll_ap,ll_id_val)
	end if	
end if
lo_sp.of_conti_ce_parz(ld_da, ld_a,ll_ch,ll_id_val)
lo_sp.of_conti_sp_parz(ld_da, ld_a,ll_ch,ll_id_val)

close(w_attesa)

select esercizio.codice
into :ll_cod_es1
from esercizio
where esercizio.id_esercizio=:ll_es1;
ls_param.cambio=ld_cambio
ls_param.dec_significativi=ld_dec_sign
ls_param.id_azienda=ll_azienda
ls_param.cod_esercizio=ll_cod_es1
ls_param.data_in=ld_da
ls_param.data_fin=ld_a
ls_param.tipo_stp=ls_stp
if isnull(ll_es1) or isnull(ld_cambio) or isnull(ld_dec_sign) or isnull(ld_da) or isnull(ld_a) then
	messagebox("Informazione","Non sono state inserite tutte le informazioni necessarie")
else
	if dw_1.getitemstring(1,'modalita')='S' then
		
		CHOOSE CASE ls_cf
			CASE 'S'
				openwithparm(w_st_bil_scalare2_gd,ls_param) 
		   CASE 'N'
		   	openwithparm(w_st_bil_scalare_gd,ls_param) 
		   CASE 'U'
		   	openwithparm(w_st_bil_scalare3_gd,ls_param) 
	   END CHOOSE	
	else	
		CHOOSE CASE ls_cf
			CASE 'S'
				openwithparm(w_st_bil_inventari2_gd,ls_param) 
		   CASE 'N'
		   	openwithparm(w_st_bil_inventari_gd,ls_param) 
		   CASE 'U'
				messagebox('Attenzione','La modalità solo CL/FO è attiva solo per il bilancio Scalare')
		
		END CHOOSE	
	end if	
end if

end event

type cb_2 from commandbutton within w_bil_scalare_cx
event clicked pbm_bnclicked
int X=23
int Y=40
int Width=247
int Height=84
int TabOrder=20
string Text="Annulla"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(parent)
end event

type dw_1 from u_dw_ext_main within w_bil_scalare_cx
int X=23
int Y=160
int Width=2094
int Height=568
int TabOrder=30
string DataObject="d_bil_scalare_ff"
end type

event itemchanged;date ld_d1,ld_d2
string ls_data
date ld_d_in, ld_d_fin, ld_a, ld_da 
string ls_colonna 
long ll_valuta

CHOOSE CASE dwo.name

	CASE "id_esercizio"
			select data_inizio,data_fine, id_valuta
			into :ld_d1,:ld_d2, :ll_val_es
			from esercizio
			where id_esercizio=:data;
			ls_data=string(ld_d1,"dd/mm/yyyy")
			dw_1.setitem(1,"d_in",ls_data)
			ls_data=string(ld_d2,"dd/mm/yyyy")
			dw_1.setitem(1,"d_fin",ls_data)	
			dw_1.setitem(1,"da",ld_d1)
			dw_1.setitem(1,"a",ld_d2)	
			
			dw_1.setitem(1,"valuta",ll_val_es)

	CASE "da"
	      ls_data=dw_1.getitemstring(1,"d_in")
			ld_d_in=date(ls_data) 
		   ls_data=dw_1.getitemstring(1,"d_fin")
			ld_d_fin=date(ls_data)
			ld_da=date(data)
			if ld_da<ld_d_in or ld_da>ld_d_fin then
				messagebox("Controllo", "Attenzione, la Data Iniziale non rientra~nnell'Esercizio selezionato!")
      		ls_colonna="da"
      		POST F_SET_COLUMN(DW_1,LS_COLONNA)
		   end if
	
	CASE "a"
			ls_data=dw_1.getitemstring(1,"d_in")
			ld_d_in=date(ls_data) 	
			ls_data=dw_1.getitemstring(1,"d_fin")
			ld_d_fin=date(ls_data)	
			ld_a=date(data)
			if ld_a<ld_d_in or ld_a>ld_d_fin then
  				messagebox("Controllo", "Attenzione, la Data Finale non rientra~nnell'Esercizio selezionato!")
   		   ls_colonna="a"
      		POST F_SET_COLUMN(DW_1,LS_COLONNA)
   		end if
			
END CHOOSE

end event

