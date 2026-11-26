forward
global type w_bilancio_cdc_cx from Window
end type
type cb_1 from commandbutton within w_bilancio_cdc_cx
end type
type cb_2 from commandbutton within w_bilancio_cdc_cx
end type
type dw_1 from u_dw_ext_main within w_bilancio_cdc_cx
end type
end forward

global type w_bilancio_cdc_cx from Window
int X=832
int Y=360
int Width=2464
int Height=772
boolean TitleBar=true
string Title="Bilancio"
long BackColor=80263581
boolean ControlMenu=true
WindowType WindowType=response!
cb_1 cb_1
cb_2 cb_2
dw_1 dw_1
end type
global w_bilancio_cdc_cx w_bilancio_cdc_cx

type variables
long ll_id1,ll_id2,ll_id3,ll_id4
end variables

forward prototypes
public subroutine uf_calc_bilancio (string data_da, string data_a)
end prototypes

public subroutine uf_calc_bilancio (string data_da, string data_a);long ll_id_conto
decimal ld_conto,ld_dare,ld_avere
boolean lb_flag

declare lc_conti_ce cursor for
	select c.id_conto, 
			CAST (SUM (M.DARE) AS decimal)  DARE,
			CAST (SUM (M.AVERE) AS decimal)  AVERE
    from conto c, mov_centri_costo m, reg_pdc r, mastro mm, sottomastro s
    where c.id_conto = m.id_conto
	 AND M.ID_REG_PDc = R.ID_REG_PDc
	 and c.id_sottomastro=s.id_sottomastro
	 and s.id_mastro=mm.id_mastro	
    AND (dateformat(R.DATA,'yy/mm/dd') >=:data_da) AND (dateformat(R.DATA,'yy/mm/dd') <=  :data_a )
	 and mm.id_pdc=:ll_id1
	 GROUP BY C.ID_CONTO
	 ORDER BY C.ID_CONTO;
open lc_conti_ce;
do while sqlca.sqlcode=0
	fetch lc_conti_ce into :ll_id_conto,:ld_dare,:ld_avere;
	if sqlca.sqlcode=0 then 
		lb_flag=true
			if isnull(ld_dare) then ld_dare=0
			if isnull(ld_avere) then ld_avere=0			
			ld_conto=ld_dare - ld_avere
		if ld_conto<0 then 
			lb_flag=false
			ld_conto=ld_conto* -1
		end if
			
		
		if ld_conto<>0 then
			if lb_flag=false then
				insert into  chiusura_apertura  (id_conto,saldo_avere)
				values (:ll_id_conto,:ld_conto);
			else
				insert into  chiusura_apertura  (id_conto,saldo_dare)
				values (:ll_id_conto,:ld_conto);
			end if
		end if
	end if

loop
close lc_conti_ce;

end subroutine

event open;
dw_1.insertrow(0)
dw_1.setfocus()
datawindowchild ldc_es,ldc_es1,ldc_es2,ldc_val,ldc_azienda

string ls_cod,ls_des
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

long ll_con
select id_pdc_cen_costo
into :ll_id1
from azienda;

if isnull(ll_id1) then 
	cb_1.enabled=false
	messagebox('Errore',"Errore nei parametri~r~n Inserire il pdc in riferimento ai centri di costo nei dettagli dell'azienda")
end if
end event

on w_bilancio_cdc_cx.create
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_1=create dw_1
this.Control[]={this.cb_1,&
this.cb_2,&
this.dw_1}
end on

on w_bilancio_cdc_cx.destroy
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

type cb_1 from commandbutton within w_bilancio_cdc_cx
int X=2167
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
string ls_mod
string ls_cf
long ll_id_prof,ll_id_reg,ll_id_es,ll_id_azienda, ll_test, ll_test2
decimal ld_dec_significativi, ld_cambio
date ld_data
string ls_bloc
string ls_da,ls_a
uo_chiusura_apertura lo_sp
ll_id_es=dw_1.getitemnumber(1,"id_esercizio")

ll_test=0
ll_test2=0



ls_mod=dw_1.getitemstring(1,"modalita")	

  ld_cambio=dw_1.getitemnumber(1,"valuta")
  SELECT "valuta"."dec_significativi"  
    INTO :ld_dec_significativi  
    FROM "valuta"  
   WHERE "valuta"."cambio" = :ld_cambio   ;
ll_id_azienda=dw_1.getitemnumber(1,"id_azienda")

date ld_da,ld_a
ld_da=dw_1.getitemdate(1,"da")
ld_a=dw_1.getitemdate(1,"a")
date ld_in,ld_fin
string ls_in,ls_fin
ls_in=dw_1.getitemstring(1,"d_in")
ls_fin=dw_1.getitemstring(1,"d_fin")
ld_in=date(ls_in)
ld_fin=date(ls_fin)

	




	long ll_id_e
	ll_id_e=dw_1.getitemnumber(1,"id_esercizio")
	ld_cambio=dw_1.getitemnumber(1,"valuta")
	
	if ((ld_cambio<>0) and (not isnull(ld_cambio))) and &
		not isnull(ll_id_e) then
		open(w_attesa)
		long il_prof
		date ld_d
	
		ld_d=today()
		il_prof=1
		ll_id_es=dw_1.getitemnumber(1,"id_esercizio")
		if not isnull(ll_id_es) then
			
			ld_d=dw_1.getitemdate(1,"data_c")
			lo_sp= create uo_chiusura_apertura 
			ll_test=1
			ls_da=string(dw_1.getitemdate(1,"da"),"yy/mm/dd")
			ls_a=string(dw_1.getitemdate(1,"a"),"yy/mm/dd")
						
			uf_calc_bilancio(ls_da,ls_a)

			close(w_attesa)
		end if
	end if



ld_da=dw_1.getitemdate(1,"da")
ld_a=dw_1.getitemdate(1,"a")
ll_id_e=dw_1.getitemnumber(1,"id_esercizio")
ld_cambio=dw_1.getitemnumber(1,"valuta")
if ((ld_cambio<>0) and (not isnull(ld_cambio))) and &
		 not isnull(ll_id_e) then
	

		
		
		
		
		
		
		
		long ll_cod_esercizio
		select esercizio.codice
		into :ll_cod_esercizio
		from esercizio
		where esercizio.id_esercizio=:ll_id_e;
		
		
		
		date ld_data_in, ld_data_fin
		string ls_stp
		ls_stp=dw_1.getitemstring(1,'tipo_stp')
		ld_data_in=dw_1.getitemdate(1,"da")
		ld_data_fin=dw_1.getitemdate(1,"a")
		s_param ls_param
		ls_param.cambio=ld_cambio
		ls_param.dec_significativi=ld_dec_significativi
		ls_param.id_azienda=ll_id_azienda
		ls_param.cod_esercizio=ll_cod_esercizio
		ls_param.data_in=ld_data_in
		ls_param.data_fin=ld_data_fin
		ls_param.tipo_stp=ls_stp
		
		
		
		
		
		
		
		if ll_test2=1 then
			openwithparm(w_stampa_bilancio_cl_gd,ls_param)
		else
		
		
		CHOOSE CASE ls_mod
			CASE 'C'
		
					openwithparm(w_stampa_bilancio_cdc_gd,ls_param) 
			
			CASE 'M'
			
					openwithparm(w_stampa_bilancio2_cdc_gd,ls_param) 
			
			CASE 'S'
					openwithparm(w_stampa_bilancio_sm_cl_gd_cdc,ls_param)
				
		END CHOOSE
	end if	
else
	messagebox("Informazione","Non sono state inserite tutte le informazioni necessarie")
end if

end event

type cb_2 from commandbutton within w_bilancio_cdc_cx
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

type dw_1 from u_dw_ext_main within w_bilancio_cdc_cx
int X=23
int Y=160
int Width=2382
int Height=500
int TabOrder=30
string DataObject="d_bilancio_cdc_ff"
end type

event itemchanged;call super::itemchanged;date ld_d1,ld_d2
string ls_data

if dwo.name="id_esercizio" then
	select data_inizio,data_fine
	into :ld_d1,:ld_d2
	from esercizio
	where id_esercizio=:data;
	ls_data=string(ld_d1,"dd/mm/yyyy")
	dw_1.setitem(1,"d_in",ls_data)
	ls_data=string(ld_d2,"dd/mm/yyyy")
	dw_1.setitem(1,"d_fin",ls_data)	
end if

date ld_d_in, ld_d_fin, ld_a, ld_da 
string ls_colonna 

if string(dwo.name)="da" then
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
end if	

if string(dwo.name)="a" then
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
end if	

end event

