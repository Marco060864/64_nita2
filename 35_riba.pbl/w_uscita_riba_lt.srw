forward
global type w_uscita_riba_lt from Window
end type
type cb_5 from commandbutton within w_uscita_riba_lt
end type
type cb_2 from commandbutton within w_uscita_riba_lt
end type
type dw_1 from datawindow within w_uscita_riba_lt
end type
end forward

global type w_uscita_riba_lt from Window
int X=23
int Y=224
int Width=2939
int Height=1544
boolean TitleBar=true
string Title="Prepara disco - RIBA"
long BackColor=78682240
boolean ControlMenu=true
WindowType WindowType=response!
cb_5 cb_5
cb_2 cb_2
dw_1 dw_1
end type
global w_uscita_riba_lt w_uscita_riba_lt

type variables
string ls_path
end variables

forward prototypes
public function string uf_elimina_virgola (string ls_par)
end prototypes

public function string uf_elimina_virgola (string ls_par);boolean b_v

b_v = true

return(ls_par)
end function

on w_uscita_riba_lt.create
this.cb_5=create cb_5
this.cb_2=create cb_2
this.dw_1=create dw_1
this.Control[]={this.cb_5,&
this.cb_2,&
this.dw_1}
end on

on w_uscita_riba_lt.destroy
destroy(this.cb_5)
destroy(this.cb_2)
destroy(this.dw_1)
end on

event open;

long ll_id, ll_row, ll_riga, ll_num_dis, ll_conta, ll_risp
string ls_riga
integer i
date d_dat
integer	li_num_dis_app 

dw_1.settransobject(sqlca)

s_distinta par_dis 
par_dis=message.powerobjectparm
ll_id = par_dis.l_id_dis_banca   
d_dat = par_dis.d_dat_rib			
ls_path = par_dis.ls_path_riba

DATASTORE ds_testa  
ds_testa = CREATE DATASTORE
ds_testa.DATAOBJECT = "rec_testa_lt"
ds_testa.SETTRANSOBJECT(SQLCA)
ds_testa.RETRIEVE(ll_id, d_dat)

ll_riga=ds_testa.getrow()
if ll_riga > 0 then
	ls_riga=ds_testa.getitemstring(ll_riga, "testa")
end if
ll_row=dw_1.insertrow(0)
dw_1.setitem(ll_row, "riga", ls_riga)


DESTROY ds_testa

select  count(*)
into 	  :li_num_dis_app
from 	  riga_dis_banca
where   id_distinta_banca = :ll_id
;

select  count(*)
into 	  :ll_num_dis
from 	  riga_dis_banca
where   id_distinta_banca = :ll_id
and	  id_riga_distinta_banca IN ( select 	id_riga_distinta_banca 
												from 		scadenza 
												where 	id_riga_distinta_banca = riga_dis_banca.id_riga_distinta_banca)
;

if (li_num_dis_app <> ll_num_dis) then
	messagebox("Attenzione", "Una o più righe della distinta non sono associate ad una scadenza ~ne non verranno incluse nel file.~nPer includerle nel file, correggerle e ripetere l'operazione.")
end if

for i = 1 to ll_num_dis
	
	DATASTORE ds_14  
	ds_14 = CREATE DATASTORE
	ds_14.DATAOBJECT = "rec_14_lt"
	ds_14.SETTRANSOBJECT(SQLCA)
	
	
	ds_14.RETRIEVE(ll_id)

	ll_conta = 0
	ll_conta= ds_14.rowcount()
	if ll_conta <> ll_num_dis then
		messagebox ('Attenzione', 'Creata una scadenza in modo non corretto / REC14')
		exit
	else	
		ll_riga=ds_14.getrow()
		
		
		integer li_pos
		string ls_imp, ls_imp_int, ls_imp_dec, ls_tipo				
		ls_tipo = ds_14.getitemstring(i, "codice_divisa")
		
		choose case ls_tipo
			case "I"
				
				ls_imp = trim(string(round(ds_14.getitemdecimal(i, "importo"), 0)))
				ls_imp = "0000000000000" + ls_imp
				ls_imp = right(ls_imp,13)
			case "E"				
				ls_imp = trim(string(round(ds_14.getitemdecimal(i, "imp_totale"),2)))				
				li_pos = pos(ls_imp,",")			
				if li_pos > 0 then 
					ls_imp_int = "00000000000" + left(ls_imp,(li_pos - 1))
					ls_imp_int = right(ls_imp_int,11)
					ls_imp_dec = "00" + trim(mid(ls_imp,(li_pos+1),2))
					ls_imp_dec = right(ls_imp_dec,2)
					ls_imp = ls_imp_int + ls_imp_dec
				else
					ls_imp = "00000000000" + left(ls_imp,(li_pos - 1))
					ls_imp = right(ls_imp,11) + "00"					
				end if				
		end choose
		
		ds_14.setitem(i,"importo_euro",ls_imp)
		
		
		if ll_riga > 0 then
			ls_riga=ds_14.getitemstring(i, "rec_14")
			
			
			
		end if
		ll_row=dw_1.insertrow(0)
		dw_1.setitem(ll_row, "riga", ls_riga)
	end if
	DESTROY ds_14
	DATASTORE ds_20  
	ds_20 = CREATE DATASTORE
	ds_20.DATAOBJECT = "rec_20_lt"
	ds_20.SETTRANSOBJECT(SQLCA)
	ds_20.RETRIEVE(ll_id)
	
	ll_conta= ds_20.rowcount()

	IF ll_conta <> ll_num_dis then
		messagebox ('Attenzione', 'Creata una scadenza in modo non corretto / REC20')
		exit
	else	
		ll_riga=ds_20.getrow()	
		if ll_riga > 0 then
			ls_riga=ds_20.getitemstring(i, "rec_20")
			
			
			
	
		end if
		ll_row=dw_1.insertrow(0)
		dw_1.setitem(ll_row, "riga", ls_riga)
	end if
		
	DESTROY ds_20

	DATASTORE ds_30  
	ds_30 = CREATE DATASTORE
	ds_30.DATAOBJECT = "rec_30_lt"
	ds_30.SETTRANSOBJECT(SQLCA)
	ds_30.RETRIEVE(ll_id)
	
	ll_conta= ds_30.rowcount()

	IF ll_conta <> ll_num_dis then
		messagebox ('Attenzione', 'Creata una scadenza in modo non corretto / REC30')
		exit
	else	
		ll_riga=ds_30.getrow()
		if ll_riga > 0 then
			ls_riga=ds_30.getitemstring(i, "rec_30")
	
			
			
		end if
		ll_row=dw_1.insertrow(0)
		dw_1.setitem(ll_row, "riga", ls_riga)
	end if
	
	DESTROY ds_30
	DATASTORE ds_40  
	ds_40 = CREATE DATASTORE
	ds_40.DATAOBJECT = "rec_40_lt"
	ds_40.SETTRANSOBJECT(SQLCA)
	ds_40.RETRIEVE(ll_id)

	ll_conta= ds_40.rowcount()

	IF ll_conta <> ll_num_dis then
		messagebox ('Attenzione', 'Creata una scadenza in modo non corretto / REC40')
		exit
	else	
		ll_riga=ds_40.getrow()
		if ll_riga > 0 then
			ls_riga=ds_40.getitemstring(i, "rec_40")
	
			
			
		end if
		ll_row=dw_1.insertrow(0)
		dw_1.setitem(ll_row, "riga", ls_riga)
	end if
	
	DESTROY ds_40
	DATASTORE ds_50  
	ds_50 = CREATE DATASTORE
	ds_50.DATAOBJECT = "rec_50_lt"
	ds_50.SETTRANSOBJECT(SQLCA)
	ds_50.RETRIEVE(ll_id)
	
	ll_conta= ds_50.rowcount()

	IF ll_conta <> ll_num_dis then
		messagebox ('Attenzione', 'Creata una scadenza in modo non corretto / REC50')
		exit
	else	
		ll_riga=ds_50.getrow()
		if ll_riga > 0 then
			ls_riga=ds_50.getitemstring(i, "rec_50")
			
			
	
		end if
		ll_row=dw_1.insertrow(0)
		dw_1.setitem(ll_row, "riga", ls_riga)
	end if
	
	DESTROY ds_50
	
	DATASTORE ds_51  
	ds_51 = CREATE DATASTORE
	ds_51.DATAOBJECT = "rec_51_lt"
	ds_51.SETTRANSOBJECT(SQLCA)
	ds_51.RETRIEVE(ll_id)

	ll_conta= ds_51.rowcount()
	
	IF ll_conta <> ll_num_dis then
		messagebox ('Attenzione', 'Creata una scadenza in modo non corretto / REC51')
		exit
	else	
		ll_riga=ds_51.getrow()
		if ll_riga > 0 then
			ls_riga=ds_51.getitemstring(i, "rec_51")
			
			
	
		end if
		ll_row=dw_1.insertrow(0)
		dw_1.setitem(ll_row, "riga", ls_riga)
	end if
		
	DESTROY ds_51
	DATASTORE ds_70  
	ds_70 = CREATE DATASTORE
	ds_70.DATAOBJECT = "rec_70_lt"
	ds_70.SETTRANSOBJECT(SQLCA)
	ds_70.RETRIEVE(ll_id)
	
	ll_conta= ds_70.rowcount()

	IF ll_conta <> ll_num_dis then
		messagebox ('Attenzione', 'Creata una scadenza in modo non corretto / REC70')
		exit
	else	
		ll_riga=ds_70.getrow()
		if ll_riga > 0 then
			ls_riga=ds_70.getitemstring(i, "rec_70")
			
			
		
		end if
		ll_row=dw_1.insertrow(0)
		dw_1.setitem(ll_row, "riga", ls_riga)
	end if
	
	DESTROY ds_70
NEXT


double ld_tot_importo

choose case ls_tipo
	case "I"
		SELECT SUM(s.importo)
		INTO   :ld_tot_importo
		FROM	 riga_dis_banca r, scadenza s
		WHERE	 r.id_distinta_banca = :ll_id
		AND    s.id_riga_distinta_banca = r.id_riga_distinta_banca
		;
	case "E"				
		select sum(round(imp_totale,2))
		into :ld_tot_importo
		from riga_dis_banca
		where id_distinta_banca = :ll_id;
end choose

DATASTORE ds_coda  							
ds_coda = CREATE DATASTORE
ds_coda.DATAOBJECT = "rec_coda_lt"
ds_coda.SETTRANSOBJECT(SQLCA)

ds_coda.RETRIEVE(ll_id, d_dat, ll_num_dis, ld_tot_importo)

ll_riga=ds_coda.rowcount()
if ll_riga > 0 then	
	
	
	ls_imp = trim(string(ds_coda.getitemdecimal(ll_riga, "tot_importi_negativi")))		
	ls_tipo = ds_coda.getitemstring(ll_riga, "codice_divisa")
	
	choose case ls_tipo
		case "I"
			
			li_pos = pos(ls_imp,",")			
			ls_imp = "000000000000000" +  left(ls_imp,(li_pos - 1))
			ls_imp = right(ls_imp,15)
		case "E"				
			li_pos = pos(ls_imp,",")			
			if li_pos > 0 then 
				ls_imp_int = "0000000000000" + left(ls_imp,(li_pos - 1))
				ls_imp_int = right(ls_imp_int,13)
				ls_imp_dec = "00" + trim(mid(ls_imp,(li_pos+1),2))
				ls_imp_dec = right(ls_imp_dec,2)
				ls_imp = ls_imp_int + ls_imp_dec
			else
				ls_imp = "0000000000000" + left(ls_imp,(li_pos - 1))
				ls_imp = right(ls_imp,13) + "00"					
			end if				
	end choose
	
	ds_coda.setitem(ll_riga,"tot_importi_negativi_euro",ls_imp)
	
	
	ls_riga=ds_coda.getitemstring(1, "coda")
	
	
end if
ll_row=dw_1.insertrow(0)
dw_1.setitem(ll_row, "riga", ls_riga)

DESTROY ds_coda


close (w_attesa)
integer li_ret
ll_risp = messagebox ('Attenzione', 'Inizio creazione disco RIBA', Question!, YesNo! , 1)

IF ll_risp = 1 then
	li_ret = dw_1.SaveAs(ls_path,Text! , FALSE)
	if li_ret <> 1 then
		 messagebox ('Attenzione', 'Creazione dischetto FALLITA !!')
	else
		messagebox ('Fine','Fine creazione dischetto RIBA')
	end if
end if

close(w_uscita_riba_lt)
close(w_sel_data_ff)



end event

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

type cb_5 from commandbutton within w_uscita_riba_lt
int X=41
int Y=40
int Width=247
int Height=92
int TabOrder=30
string Text="Annulla"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(parent)
end event

type cb_2 from commandbutton within w_uscita_riba_lt
int X=2610
int Y=32
int Width=247
int Height=92
int TabOrder=20
string Text="Stampa"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;printsetup()
dw_1.print()
end event

type dw_1 from datawindow within w_uscita_riba_lt
int X=41
int Y=156
int Width=2839
int Height=1280
int TabOrder=10
string DataObject="d_prep_riba_lt"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

