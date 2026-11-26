forward
global type w_utility_stampa_lib_gio_rpt from w_wiz_main
end type
type cb_ok from commandbutton within w_utility_stampa_lib_gio_rpt
end type
type cb_annulla from commandbutton within w_utility_stampa_lib_gio_rpt
end type
type dw_1 from u_dw_ext_main within w_utility_stampa_lib_gio_rpt
end type
type st_1 from statictext within w_utility_stampa_lib_gio_rpt
end type
type st_2 from statictext within w_utility_stampa_lib_gio_rpt
end type
type st_3 from statictext within w_utility_stampa_lib_gio_rpt
end type
end forward

global type w_utility_stampa_lib_gio_rpt from w_wiz_main
int X=1098
int Y=789
int Width=1523
int Height=1021
boolean TitleBar=true
string Title="Ripristino Stampa Libro Giornale"
cb_ok cb_ok
cb_annulla cb_annulla
dw_1 dw_1
st_1 st_1
st_2 st_2
st_3 st_3
end type
global w_utility_stampa_lib_gio_rpt w_utility_stampa_lib_gio_rpt

type variables

end variables

forward prototypes
public subroutine uf_conferma_stampa ()
end prototypes

public subroutine uf_conferma_stampa ();

long ll_id_reg_pd, ll_id_mov_contabile, ll_num_prog, ll_max_prog, ll_id_esercizio
decimal ld_max_saldo_dare,ld_riporto
string ls_ela_def
date ld_fino_data


ls_ela_def=dw_1.getitemstring(1,"ela_def")
ll_id_esercizio=dw_1.getitemnumber(1,"id_esercizio")
ld_fino_data=dw_1.getitemdate(1,"fino_data")



DECLARE libro_cur CURSOR FOR  
SELECT "libro_giornale"."id_reg_pd",  
       "libro_giornale"."id_mov_contabile",  
       "libro_giornale"."num_prog"
  FROM "libro_giornale"  
 USING SQLCA;

OPEN libro_cur;

FETCH libro_cur INTO :ll_id_reg_pd,:ll_id_mov_contabile,:ll_num_prog; 

DO WHILE SQLCA.SQLCODE=0 
	IF SQLCA.SQLCODE=0 THEN
		
	   UPDATE mov_contabile
		   SET st_stampa_bollato='S',
			    st_data_bollato=:ld_fino_data,
				 prog_stampato=:ll_num_prog
		 WHERE id_mov_contabile=:ll_id_mov_contabile;
	END IF
   FETCH libro_cur INTO :ll_id_reg_pd,:ll_id_mov_contabile,:ll_num_prog; 	
LOOP
CLOSE libro_cur;

UPDATE reg_pd
SET st_stampa_bollato='S',
	 st_data_bollato=:ld_fino_data
WHERE st_stampa_bollato='I';

SELECT max (num_prog)
  INTO :ll_max_prog
  FROM libro_giornale;

SELECT max (saldo_dare)
  INTO :ld_max_saldo_dare
  FROM libro_giornale;
  
SELECT riporto
  INTO :ld_riporto
  FROM esercizio
  WHERE id_esercizio=:ll_id_esercizio;
 
ld_max_saldo_dare=ld_max_saldo_dare+ld_riporto
 
UPDATE esercizio
SET num_progressivo=:ll_max_prog,
	 ult_data_stampa_bollato=:ld_fino_data,
	 riporto=:ld_max_saldo_dare
WHERE id_esercizio=:ll_id_esercizio;


delete from libro_giornale;


  
  

end subroutine

on w_utility_stampa_lib_gio_rpt.create
int iCurrent
call w_wiz_main::create
this.cb_ok=create cb_ok
this.cb_annulla=create cb_annulla
this.dw_1=create dw_1
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=cb_ok
this.Control[iCurrent+2]=cb_annulla
this.Control[iCurrent+3]=dw_1
this.Control[iCurrent+4]=st_1
this.Control[iCurrent+5]=st_2
this.Control[iCurrent+6]=st_3
end on

on w_utility_stampa_lib_gio_rpt.destroy
call w_wiz_main::destroy
destroy(this.cb_ok)
destroy(this.cb_annulla)
destroy(this.dw_1)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
end on

event open;call super::open;

long ll_progress

datawindowchild ldw_id_esercizio

dw_1.getchild("id_esercizio",ldw_id_esercizio)
ldw_id_esercizio.settransobject(sqlca)
ldw_id_esercizio.retrieve()

select min(num_prog)
into :ll_progress
from libro_giornale;

dw_1.InsertRow(1)

if not isnull(ll_progress) then
	dw_1.setitem(1,"num_prog",ll_progress)
end if

	delete from libro_giornale
   where id_mov_contabile is null;

dw_1.setitem(1,"ela_def",'S')
end event

event closequery;call super::closequery;

end event

event key;call super::key;

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

type cb_ok from commandbutton within w_utility_stampa_lib_gio_rpt
event clicked pbm_bnclicked
int X=51
int Y=41
int Width=261
int Height=85
int TabOrder=20
boolean BringToTop=true
string Text="Stampa"
boolean Cancel=true
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;



long ll_mes, ll_prog
string ls_ela_def
dw_1.accepttext()
ls_ela_def=dw_1.getitemstring(1,"ela_def")

ll_prog=dw_1.getitemnumber(1,"num_prog")
	
ll_mes= messagebox ('ATTENZIONE', 'La scelta selezionata è:  ' + string(ll_prog) + '  Vuoi continuare?', &
																					Exclamation!, OKCancel!, 2)

if ll_mes = 2 then
	close(parent)
else
	
	
	
	
	open(w_attesa,W_APP_FRAME)
	long tot_righe, i, ll_reg_pd, ll_num_prog, ll_max_mov_contabile
	decimal ld_max_dare, ld_max_avere
	date ld_data_reg
	
	
	delete from libro_giornale
   where id_mov_contabile is null;
	
	
	
	select count (id_reg_pd)
	into :tot_righe 
	from libro_giornale
	where num_prog>=:ll_prog;
	
	
	select max (id_reg_pd)
	into :ll_reg_pd
	from libro_giornale
	where num_prog>=:ll_prog;

	
	select max (num_prog)
	into :ll_num_prog
	from libro_giornale
	where num_prog>=:ll_prog;
   ll_num_prog=ll_num_prog+1 
	
	select max (data_registrazione)
	into :ld_data_reg
	from libro_giornale
	where num_prog>=:ll_prog;

	
	select max (saldo_dare)
	into :ld_max_dare
	from libro_giornale
	where num_prog>=:ll_prog;

	
	select max (saldo_avere)
	into :ld_max_avere
	from libro_giornale
	where num_prog>=:ll_prog;
    
	select max (id_mov_contabile)
	into :ll_max_mov_contabile
	from libro_giornale;
   ll_max_mov_contabile=ll_max_mov_contabile+1
	
	
	if tot_righe>0 then
		
		do while tot_righe>=27
			tot_righe=tot_righe - 27
		loop
		
		tot_righe=27 - tot_righe
		i=1
				
		do while i<= tot_righe
			  INSERT INTO "libro_giornale"  
					( "id_reg_pd",   
					  "data_registrazione",  
					  "num_prog",   
					  "saldo_dare",   
					  "saldo_avere",   
					  "saldo_riga",   
					  "riporto_dare",   
					  "riporto_avere",
					  "id_mov_contabile")  
		  VALUES ( :ll_reg_pd,   
					  :ld_data_reg,   
					  :ll_num_prog,   
					  :ld_max_dare,   
					  :ld_max_avere,   
					  0,   
					  0,   
					  0,
					  :ll_max_mov_contabile)  ;
		
			i=i+1
		loop
	end if
	
	
   
   
	
	
	
	ll_prog=dw_1.getitemnumber(1,"num_prog")
	openwithparm(w_stampa_ripristino_lib_gio_rpt,ll_prog)
end if


integer li_rispo
if tot_righe>0 then 
	li_rispo=messagebox("Conferma Stampa","La Stampa è andata a buon fine?",question!,yesno!)
	
	if li_rispo=1  then 
		
   	if ls_ela_def='S' then  
			open(w_attesa,W_APP_FRAME)
			uf_conferma_stampa()
			close(w_attesa)
			close(parent)
				else  
				  
				  open(w_attesa,W_APP_FRAME)
				  delete from libro_giornale;
				  close(w_attesa)
				  close(parent)
		end if
   end if   
end if 

end event

type cb_annulla from commandbutton within w_utility_stampa_lib_gio_rpt
int X=343
int Y=41
int Width=261
int Height=85
int TabOrder=30
boolean BringToTop=true
string Text="Annulla"
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

type dw_1 from u_dw_ext_main within w_utility_stampa_lib_gio_rpt
event type integer ue_tipo_reg ( )
int X=42
int Y=413
int Width=1409
int Height=489
int TabOrder=10
string DataObject="d_utility_lib_gio_ff"
end type

type st_1 from statictext within w_utility_stampa_lib_gio_rpt
int X=42
int Y=173
int Width=1468
int Height=77
boolean Enabled=false
boolean BringToTop=true
string Text="Utility di ripristino per la Stampa del Libro Giornale, specificando"
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_utility_stampa_lib_gio_rpt
int X=42
int Y=237
int Width=1468
int Height=77
boolean Enabled=false
boolean BringToTop=true
string Text="da  quale  Numero  Progressivo  di  Scrittura  si  vuol riprendere"
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_utility_stampa_lib_gio_rpt
int X=42
int Y=309
int Width=1468
int Height=77
boolean Enabled=false
boolean BringToTop=true
string Text="a stampare su Bollato"
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

