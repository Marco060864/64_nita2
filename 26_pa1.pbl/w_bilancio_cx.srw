forward
global type w_bilancio_cx from window
end type
type cb_1 from commandbutton within w_bilancio_cx
end type
type cb_2 from commandbutton within w_bilancio_cx
end type
type dw_1 from u_dw_ext_main within w_bilancio_cx
end type
end forward

global type w_bilancio_cx from window
integer x = 834
integer y = 362
integer width = 2512
integer height = 899
boolean titlebar = true
string title = "Bilancio"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 80263581
cb_1 cb_1
cb_2 cb_2
dw_1 dw_1
end type
global w_bilancio_cx w_bilancio_cx

type variables
long ll_id1,ll_id2,ll_id3,ll_id4
long ll_val_es
end variables

forward prototypes
public subroutine uf_ss (string as_type, string as_dett)
end prototypes

public subroutine uf_ss (string as_type, string as_dett);

long ll_id_conto, ll_ap, ll_ch, ll_riga, ll_num_righe, ll_group, ll_next_group
long ll_mm1, ll_mm2, i, ll_ret
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
ll_ret=ds_bil.retrieve()

select pref_cod_cliente, pref_cod_fornitore into :ls_cl, :ls_fo
from par_sistema;
select id_mastro into :ll_mm1 from mastro where codice=:ls_cl;
select id_mastro into :ll_mm2 from mastro where codice=:ls_fo;
if as_type='C' and as_dett='F' then
	
	ds_bil.setfilter("id_mm<>"+string(ll_mm1)+" and id_mm<>"+string(ll_mm2))
   ll_ret=ds_bil.filter()
end if	
if as_type='C' and as_dett='C' then
	ds_bil.setfilter("id_mm="+string(ll_mm1)+" and id_mm="+string(ll_mm2))
   ll_ret=ds_bil.filter()
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

on w_bilancio_cx.create
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_1=create dw_1
this.Control[]={this.cb_1,&
this.cb_2,&
this.dw_1}
end on

on w_bilancio_cx.destroy
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

type cb_1 from commandbutton within w_bilancio_cx
integer x = 2213
integer y = 42
integer width = 249
integer height = 83
integer taborder = 10
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stampa"
end type

event clicked;

dw_1.accepttext()
delete from chiusura_apertura;
string ls_mod, ls_cf, ls_bloc, ls_stp, ls_aper
long ll_es1,ll_azienda, ll_test, ll_test2, ll_es2
long ll_id_val, ll_cod_es1
decimal ld_dec_sign, ld_cambio
date ld_da,ld_a, ld_in,ld_fn, ld_in2

s_param ls_param
uo_bilancio lo_sp

long ll_val_lire
select id_val_lire into :ll_val_lire from par_sistema;

ll_es1=dw_1.getitemnumber(1,"id_esercizio")

ll_test=0
ll_test2=0
ls_aper=dw_1.getitemstring(1,'apertura')
ls_mod=dw_1.getitemstring(1,"modalita")
if ls_mod='C' then 
	ls_cf=dw_1.getitemstring(1,"cliforn")  
else 
	ls_cf='C'
end if

ll_azienda=dw_1.getitemnumber(1,"id_azienda")
ls_stp=dw_1.getitemstring(1,'tipo_stp')

if ls_cf='F' then
	if ls_mod='C' then
		ll_test2=1
	else
		messagebox("Attenzione",'La modalità SOLO CLIENTI è attiva solo per il livello CONTO')
		return
	end if
end if	

ll_id_val=dw_1.getitemnumber(1,"valuta")
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

select bloccato  into :ls_bloc
from esercizio where id_esercizio=:ll_es1;

IF dw_1.getitemstring(1,'tipo_mov')='P' or dw_1.getitemstring(1,'tipo_mov')='T' then
	
	IF ls_aper='S' then
			open(w_attesa)
			lo_sp= create uo_bilancio 
			ll_test=1
		 	if isnull(ld_a) then	ld_a=ld_fn		
			lo_sp.of_conti_sp_parz(ld_da,ld_a,ll_id_val)
			lo_sp.of_conti_ce_parz(ld_da,ld_a,ll_id_val)
			if dw_1.getitemstring(1,'tipo_mov')='P' then destroy lo_sp
			close(w_attesa)
	ELSE	
			open(w_attesa)
			lo_sp= create uo_bilancio 
			ll_test=1
			if ls_bloc='S' then
				if ld_a=ld_fn then 
					
					lo_sp.of_conti_ce_ch(ld_in, ld_fn,ll_id_val)
					lo_sp.of_conti_sp_ch(ld_in, ld_fn,ll_id_val)
				else
					
					lo_sp.of_conti_ce_parz(ld_in, ld_a,ll_id_val)
					lo_sp.of_conti_sp_parz(ld_in, ld_a,ll_id_val)
				end if	
			else
				
				select MAX(id_esercizio) into :ll_es2
				from esercizio where id_esercizio<:ll_es1;
				select bloccato, data_inizio into :ls_bloc, :ld_in2
				from esercizio where id_esercizio=:ll_es2;
				
				if ls_bloc='S' then
					
					lo_sp.of_conti_ce_parz(ld_in, ld_a,ll_id_val)
					lo_sp.of_conti_sp_parz(ld_in, ld_a,ll_id_val)
				else 
					
					lo_sp.of_conti_ce_parz(ld_in, ld_a,ll_id_val)
					lo_sp.of_conti_sp_parz(ld_in2, ld_a,ll_id_val)
				end if	
			end if
			if dw_1.getitemstring(1,'tipo_mov')='P' then destroy lo_sp
			close(w_attesa)
	END IF
END IF	

if dw_1.getitemstring(1,'tipo_mov')='M' or dw_1.getitemstring(1,'tipo_mov')='T' then
	if ll_test=0 then lo_sp= create uo_bilancio 
	lo_sp.of_conti_sp_parz_man(ld_da,ld_a,ll_es1,ll_id_val)
	lo_sp.of_conti_ce_parz_man(ld_da,ld_a,ll_es1,ll_id_val)
	destroy lo_sp
end if

if ls_mod='S' then uf_ss(ls_mod,'0')
if ls_mod='M' then uf_ss(ls_mod,'0')
if ls_mod='C' and ls_cf='F' then uf_ss(ls_mod,ls_cf)
if ls_mod='C' and ls_cf='C' then uf_ss(ls_mod,ls_cf)

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
	if ls_stp='C' then  //030914 confronto bilanci 
	openwithparm(w_stampa_bilancio_nuovo_gd,ls_param)
	
	
	
	//fine 030914	
	else
		if ll_test2=1 then
			openwithparm(w_stampa_bilancio_cl_gd,ls_param)
		else
			CHOOSE CASE ls_mod
				CASE 'C'
					if ls_cf='T' then
						openwithparm(w_stampa_bilancio_gd,ls_param) 
					else
						openwithparm(w_stampa_bilancio3_gd,ls_param) 
					end if
				CASE 'M'
					
					
					
						openwithparm(w_stampa_bilancio_m_gd,ls_param) 
					
				CASE 'S'
					
					
					
					openwithparm(w_stampa_bilancio_sm_gd,ls_param) 
					
			END CHOOSE
		end if	
	end if
end if
end event

type cb_2 from commandbutton within w_bilancio_cx
event clicked pbm_bnclicked
integer x = 22
integer y = 42
integer width = 249
integer height = 83
integer taborder = 20
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Annulla"
end type

event clicked;close(parent)
end event

type dw_1 from u_dw_ext_main within w_bilancio_cx
integer x = 22
integer y = 160
integer width = 2447
integer height = 624
integer taborder = 30
string dataobject = "d_bilancio_ff"
end type

event itemchanged;date ld_d1,ld_d2
string ls_data
date ld_d_in, ld_d_fin, ld_a, ld_da 
string ls_colonna 

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

