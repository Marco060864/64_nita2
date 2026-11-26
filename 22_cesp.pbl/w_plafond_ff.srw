forward
global type w_plafond_ff from Window
end type
type cb_3 from commandbutton within w_plafond_ff
end type
type cbx_1 from checkbox within w_plafond_ff
end type
type dw_2 from u_dw_ext_main within w_plafond_ff
end type
type dw_1 from u_dw_ext_main within w_plafond_ff
end type
type cb_2 from commandbutton within w_plafond_ff
end type
type cb_1 from commandbutton within w_plafond_ff
end type
end forward

global type w_plafond_ff from Window
int X=833
int Y=361
int Width=1591
int Height=453
boolean TitleBar=true
string Title="Plafond"
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
cb_3 cb_3
cbx_1 cbx_1
dw_2 dw_2
dw_1 dw_1
cb_2 cb_2
cb_1 cb_1
end type
global w_plafond_ff w_plafond_ff

forward prototypes
public subroutine wf_calcola_plafond (date ld_data_fine)
end prototypes

public subroutine wf_calcola_plafond (date ld_data_fine);string ls_cod,ls_des,ls_tipo,ls_data_fine
long ll_id_cespite,i,ll_riga
decimal ld_valore,ld_plafond1,ld_plafond2,ld_plafond,ld_importo
date ld_data_storico,ld_data_venduto
boolean lb_controllo,lb_venduto
integer li_giorni,li_mese,li_giorni_div
ls_data_fine=string(ld_data_fine,'yy/mm/dd')
lb_controllo=false
ld_plafond1=0
  DECLARE cespite CURSOR FOR  
  SELECT "cespite"."codice",   
         "cespite"."descrizione",   
         "cespite"."id_cespite",   
         "cespite"."valore_acq"  
    FROM "cespite"  
   WHERE ( "cespite"."sog_contr_manut" = 'N' ) AND  
         ( "cespite"."autotraportatori" = 'S' )  AND
			("cespite"."amm_normale"<>0) ;
OPEN cespite;
fetch cespite into :ls_cod, :ls_des, :ll_id_cespite, :ld_valore;
do while sqlca.sqlcode=0 
	lb_venduto=false
	setnull(ld_data_venduto)
	DECLARE storico_cespite CURSOR FOR  
	SELECT "storico_cespite"."data_mov",   
			 "storico_cespite"."tipo_mov",   
			 "storico_cespite"."importo"  
	FROM "storico_cespite"  
	WHERE "storico_cespite"."id_cespite"=:ll_id_cespite
	AND (DATEFORMAT("storico_cespite"."data_mov",'yy/mm/dd'))<= :ls_data_fine
	ORDER BY "storico_cespite"."data_mov" DESC  ;
	open storico_cespite;
	do while sqlca.sqlcode=0
		fetch storico_cespite into :ld_data_storico, :ls_tipo, :ld_importo;
		if sqlca.sqlcode=0 then
			choose case ls_tipo
				case 'I'
					ld_valore=ld_valore - ld_importo
					lb_controllo=true
				case 'R'
					ld_valore=ld_valore - ld_importo					
					lb_controllo=true
				case 'D'
					ld_valore=ld_valore + ld_importo					
					lb_controllo=true
				case 'S'
					ld_valore=ld_valore + ld_importo					
					lb_controllo=true
				case 'M'
					lb_controllo=true
				case 'V'
					if year(ld_data_storico) = year(ld_data_fine) then
						lb_venduto=true
						ld_data_venduto=ld_data_storico
					end if
				CASE 'A' 
					lb_controllo=true
				case else
					lb_controllo=false
			end choose
		end if
	loop
	close storico_cespite;
	if lb_controllo=true then
		if lb_venduto=true then
			li_giorni=0
			li_mese=month(ld_data_venduto)
			for i=li_mese -1  to 1 step -1
				li_giorni=li_giorni+f_gmese(i,year(ld_data_fine))
			next
			li_giorni=li_giorni + day(ld_data_venduto)
		else
			if f_gmese(2,year(ld_data_fine))=29 then
				li_giorni=366
			else
				li_giorni=365
			end if
		end if
		li_giorni_div=365
		if f_gmese(2,year(ld_data_fine))=29 then
			li_giorni_div=366
		end if
		ld_valore=(((ld_valore / li_giorni_div) * li_giorni) * 25) / 100
		ll_riga=dw_2.insertrow(99999)
		dw_2.setitem(ll_riga,"codice",ls_cod)
		dw_2.setitem(ll_riga,"descrizione",ls_des)
		dw_2.setitem(ll_riga,"valore",ld_valore)		
		dw_2.setitem(ll_riga,"giorni",li_giorni)
		if li_giorni<365 then dw_2.setitem(ll_riga,"venduto",'S')
		ld_plafond1=ld_plafond1+ld_valore
	end if
	lb_controllo=false
	fetch cespite into :ls_cod, :ls_des, :ll_id_cespite, :ld_valore;
loop
close cespite;

lb_controllo=false
ld_plafond2=0
  DECLARE cespite_non_auto CURSOR FOR  
  SELECT "cespite"."codice",   
         "cespite"."descrizione",   
         "cespite"."id_cespite",   
         "cespite"."valore_acq"  
    FROM "cespite"  
   WHERE ( "cespite"."sog_contr_manut" = 'N' ) AND  
         ( "cespite"."autotraportatori" = 'N' )  AND
			( "cespite"."amm_normale"<>0) ;
OPEN cespite_non_auto;
fetch cespite_non_auto into :ls_cod, :ls_des, :ll_id_cespite, :ld_valore;
do while sqlca.sqlcode=0 
	lb_venduto=false
	setnull(ld_data_venduto)
	DECLARE storico_cespite_non_auto CURSOR FOR  
	SELECT "storico_cespite"."data_mov",   
			 "storico_cespite"."tipo_mov",   
			 "storico_cespite"."importo"  
	FROM "storico_cespite"  
	WHERE "storico_cespite"."id_cespite"=:ll_id_cespite
	AND (DATEFORMAT("storico_cespite"."data_mov",'yy/mm/dd'))<= :ls_data_fine
	ORDER BY "storico_cespite"."data_mov" DESC  ;
	open storico_cespite_non_auto;
	do while sqlca.sqlcode=0
		fetch storico_cespite_non_auto into :ld_data_storico, :ls_tipo, :ld_importo;
		if sqlca.sqlcode=0 then
			choose case ls_tipo
				case 'I'
					ld_valore=ld_valore - ld_importo
					lb_controllo=true
				case 'R'
					ld_valore=ld_valore - ld_importo					
					lb_controllo=true
				case 'D'
					ld_valore=ld_valore + ld_importo					
					lb_controllo=true
				case 'S'
					ld_valore=ld_valore + ld_importo					
					lb_controllo=true
				case 'M'
					lb_controllo=true
				case 'V'
					if year(ld_data_storico) = year(ld_data_fine) then
						lb_venduto=true
						ld_data_venduto=ld_data_storico
					end if
				CASE 'A' 
					lb_controllo=true
				case else
					lb_controllo=false
			end choose
		end if
	loop
	close storico_cespite_non_auto;
	if lb_controllo=true then
		if lb_venduto=true then
			li_giorni=0
			li_mese=month(ld_data_venduto)
			for i=li_mese - 1 to 1 step -1
				li_giorni=li_giorni+f_gmese(i,year(ld_data_fine))
			next
			li_giorni=li_giorni + day(ld_data_venduto)
		else
			if f_gmese(2,year(ld_data_fine))=29 then
				li_giorni=366
			else
				li_giorni=365
			end if
		end if
		li_giorni_div=365
		if f_gmese(2,year(ld_data_fine))=29 then
			li_giorni_div=366
		end if
		ld_valore=(((ld_valore / li_giorni_div) * li_giorni) * 5) / 100
		ll_riga=dw_2.insertrow(0)
		dw_2.setitem(ll_riga,"codice",ls_cod)
		dw_2.setitem(ll_riga,"descrizione",ls_des)
		dw_2.setitem(ll_riga,"valore",ld_valore)
		dw_2.setitem(ll_riga,"giorni",li_giorni)
		if li_giorni<365 then dw_2.setitem(ll_riga,"venduto",'S')
		ld_plafond2=ld_plafond2+ld_valore
	end if
	lb_controllo=false
	fetch cespite_non_auto into :ls_cod, :ls_des, :ll_id_cespite, :ld_valore;
loop
close cespite_non_auto;
ld_plafond=ld_plafond1+ld_plafond2
integer li_anno_reg
string ls_data_reg
long ll_cespite_reg
decimal ld_val_reg
li_anno_reg=year(ld_data_fine)+1
ls_data_reg='01/01/'+string(li_anno_reg)
select id_cespite,valore_acq
into :ll_cespite_reg,:ld_val_reg
from cespite
where dateformat(data_inizio_utilizzo,'yy/mm/dd')>=:ls_data_reg
and ((amm_normale=0) or (amm_normale is null))
and sog_contr_manut='N';
if ld_val_reg > ld_plafond  then
	ld_val_reg=ld_plafond
end if
update cespite set quota_amm_prev_norm=:ld_val_reg
where id_cespite=:ll_cespite_reg;

end subroutine

event open;dw_1.insertrow(1)
cb_3.visible=false
end event

on w_plafond_ff.create
this.cb_3=create cb_3
this.cbx_1=create cbx_1
this.dw_2=create dw_2
this.dw_1=create dw_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={ this.cb_3,&
this.cbx_1,&
this.dw_2,&
this.dw_1,&
this.cb_2,&
this.cb_1}
end on

on w_plafond_ff.destroy
destroy(this.cb_3)
destroy(this.cbx_1)
destroy(this.dw_2)
destroy(this.dw_1)
destroy(this.cb_2)
destroy(this.cb_1)
end on

type cb_3 from commandbutton within w_plafond_ff
int X=298
int Y=21
int Width=247
int Height=89
int TabOrder=31
string Text="Stampa"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;printsetup()
dw_2.print()
end event

type cbx_1 from checkbox within w_plafond_ff
int X=481
int Y=21
int Width=247
int Height=77
string Text="Stampa"
boolean LeftText=true
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_2 from u_dw_ext_main within w_plafond_ff
int X=23
int Y=421
int Width=1509
int Height=321
int TabOrder=20
string DataObject="d_stampa_plafond_lt"
boolean HScrollBar=true
end type

type dw_1 from u_dw_ext_main within w_plafond_ff
int X=23
int Y=141
int Width=1509
int Height=181
int TabOrder=10
string DataObject="d_plafond_ff"
end type

type cb_2 from commandbutton within w_plafond_ff
int X=23
int Y=21
int Width=247
int Height=89
int TabOrder=30
string Text="Annulla"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(parent)
end event

type cb_1 from commandbutton within w_plafond_ff
int X=1285
int Y=21
int Width=247
int Height=89
int TabOrder=40
string Text="Plafond"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
string ls_primo
date ld_data,ld_data_fine
dw_1.accepttext()
ls_primo=dw_1.getitemstring(1,"primo")
ld_data=dw_1.getitemdate(1,"data_plafond")
if ls_primo='S' then
	
	ld_data_fine=date(('31/12/')+(string(year(ld_data) - 1)))
else 
	ld_data_fine=date(('01/01/')+(string(year(ld_data) - 1)))
end if
dw_2.reset()
wf_calcola_plafond(ld_data_fine)
if cbx_1.checked=true then
	parent.windowstate=Maximized! 
	dw_2.x=23
	dw_2.y=141
	dw_2.Height = parent.Height - 20
	dw_2.Width = parent.Width - 20
	dw_2.Object.DataWindow.Print.Preview='yes'
	cb_1.visible=false
	cb_2.text='OK'
	cb_3.visible=true
	cbx_1.visible=false
end if
end event

