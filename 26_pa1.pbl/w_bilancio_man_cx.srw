forward
global type w_bilancio_man_cx from Window
end type
type st_1 from statictext within w_bilancio_man_cx
end type
type cb_1 from commandbutton within w_bilancio_man_cx
end type
type cb_2 from commandbutton within w_bilancio_man_cx
end type
type dw_1 from u_dw_ext_main within w_bilancio_man_cx
end type
end forward

global type w_bilancio_man_cx from Window
int X=832
int Y=360
int Width=2395
int Height=764
boolean TitleBar=true
string Title="Bilancio Manageriale"
long BackColor=78682240
boolean ControlMenu=true
WindowType WindowType=response!
st_1 st_1
cb_1 cb_1
cb_2 cb_2
dw_1 dw_1
end type
global w_bilancio_man_cx w_bilancio_man_cx

type variables
long ll_id1,ll_id2,ll_id3,ll_id4
end variables

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

long ll_con
select id_conto_utile_sp,id_conto_utile_ce,id_conto_perdite_sp,id_conto_perdite_ce
into :ll_id1,:ll_id2,:ll_id3,:ll_id4
from par_sistema;
ll_con=ll_id1+ll_id2+ll_id3+ll_id4
if isnull(ll_con) then 
	cb_1.enabled=false
	messagebox('Errore',"Errore in parametri di sistema ~r~n Inserire i conti Utile e Perdita")
end if
end event

on w_bilancio_man_cx.create
this.st_1=create st_1
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_1=create dw_1
this.Control[]={this.st_1,&
this.cb_1,&
this.cb_2,&
this.dw_1}
end on

on w_bilancio_man_cx.destroy
destroy(this.st_1)
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

type st_1 from statictext within w_bilancio_man_cx
int X=50
int Y=148
int Width=2277
int Height=76
boolean Enabled=false
string Text="Questa stampa comprende i saldi Manageriali dei conti "
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=400
string FaceName="Arial"
boolean Italic=true
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_1 from commandbutton within w_bilancio_man_cx
int X=1509
int Y=40
int Width=837
int Height=84
int TabOrder=10
string Text="Stampa Bilanci Manageriali"
int TextSize=-8
int Weight=700
string FaceName="Arial"
boolean Italic=true
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

delete from chiusura_apertura;

long ll_id_prof,ll_id_reg,ll_id_es,ll_id_azienda
decimal ld_dec_significativi, ld_cambio
date ld_data
string ls_bloc
string ls_da,ls_a
uo_chiusura_apertura lo_sp
ll_id_es=dw_1.getitemnumber(1,"id_esercizio")

select bloccato 
into :ls_bloc
from esercizio
where id_esercizio=:ll_id_es;
IF ls_bloc = 'S' THEN    
	Messagebox ('Attenzione', 'Esercizio contabile chiuso ... ~r~nImpossibile stampare il bilancio manageriale~r~n'+&
										'Selezionare stampa bilancio')
ELSE  
	
	
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
				ls_da=string(dw_1.getitemdate(1,"da"),"yy/mm/dd")
				ls_a=string(dw_1.getitemdate(1,"a"),"yy/mm/dd")
							
				if ls_da="" and ls_a="" then
					lo_sp.of_conti_sp(il_prof,ld_d,ll_id_es,ll_id1,ll_id3,'B')
					lo_sp.of_conti_ce(il_prof,ld_d,ll_id_es,ll_id2,ll_id4,'B')
				else
					lo_sp.of_conti_sp_parziali(ls_da,ls_a,ll_id_es)
					lo_sp.of_conti_ce_parziali(ls_da,ls_a,ll_id_es)
				end if
				destroy lo_sp
				close(w_attesa)
			end if
		end if
	
	
	
	ld_da=dw_1.getitemdate(1,"da")
	ld_a=dw_1.getitemdate(1,"a")
	ll_id_e=dw_1.getitemnumber(1,"id_esercizio")
	ld_cambio=dw_1.getitemnumber(1,"valuta")
	if ((ld_cambio<>0) and (not isnull(ld_cambio))) and &
			 not isnull(ll_id_e) then
		
			string ls_mod
			string ls_cf
			long ll_cod_esercizio
			select esercizio.codice
			into :ll_cod_esercizio
			from esercizio
			where esercizio.id_esercizio=:ll_id_e;
			
			
			date ld_data_in, ld_data_fin
			ld_data_in=dw_1.getitemdate(1,"da")
			ld_data_fin=dw_1.getitemdate(1,"a")
			s_param ls_param
			ls_param.cambio=ld_cambio
			ls_param.dec_significativi=ld_dec_significativi
			ls_param.id_azienda=ll_id_azienda
			ls_param.cod_esercizio=ll_cod_esercizio
			ls_param.data_in=ld_data_in
			ls_param.data_fin=ld_data_fin
			
			
			
			
			
			ls_mod=dw_1.getitemstring(1,"modalita")
			ls_cf=dw_1.getitemstring(1,"cliforn")
			CHOOSE CASE ls_mod
				CASE 'C'
					if ls_cf='S' then
						
						openwithparm(w_stampa_man_bilancio_gd,ls_param) 
					else
						
						openwithparm(w_stampa_man_bilancio3_gd,ls_param) 
					end if
				CASE 'M'
					if ls_cf='S' then
						
						openwithparm(w_stampa_man_bilancio2_gd,ls_param) 
					else
						
						openwithparm(w_stampa_man_bilancio_m_gd,ls_param) 
					end if
				CASE 'S'
					if ls_cf='S' then
						openwithparm(w_stampa_man_bilancio_sm_cl_gd,ls_param)
					else
					
					openwithparm(w_stampa_man_bilancio_sm_gd,ls_param) 
				end if
			END CHOOSE
	
	else
		messagebox("Informazione","Non sono state inserite tutte le informazioni necessarie")
	end if
END IF
end event

type cb_2 from commandbutton within w_bilancio_man_cx
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

type dw_1 from u_dw_ext_main within w_bilancio_man_cx
int X=23
int Y=256
int Width=2313
int Height=392
int TabOrder=30
string DataObject="d_bilancio_man_ff"
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

