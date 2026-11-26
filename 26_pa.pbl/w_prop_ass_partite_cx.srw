forward
global type w_prop_ass_partite_cx from w_wiz_main
end type
type tab_1 from tab within w_prop_ass_partite_cx
end type
type tabpage_2 from userobject within tab_1
end type
type dw_2 from u_dw_pura within tabpage_2
end type
type dw_3 from u_dw_pura within tabpage_2
end type
type sle_av from singlelineedit within tabpage_2
end type
type st_2 from statictext within tabpage_2
end type
type cb_2 from commandbutton within tabpage_2
end type
type ln_1 from line within tabpage_2
end type
type ln_2 from line within tabpage_2
end type
type ln_3 from line within tabpage_2
end type
type cb_3 from commandbutton within tabpage_2
end type
type cb_annulla from commandbutton within w_prop_ass_partite_cx
end type
type dw_1 from u_dw_ext_main within w_prop_ass_partite_cx
end type
type cb_1 from commandbutton within w_prop_ass_partite_cx
end type
type cb_4 from commandbutton within w_prop_ass_partite_cx
end type
type tabpage_2 from userobject within tab_1
dw_2 dw_2
dw_3 dw_3
sle_av sle_av
st_2 st_2
cb_2 cb_2
ln_1 ln_1
ln_2 ln_2
ln_3 ln_3
cb_3 cb_3
end type
type tab_1 from tab within w_prop_ass_partite_cx
tabpage_2 tabpage_2
end type
end forward

global type w_prop_ass_partite_cx from w_wiz_main
int Width=3264
int Height=1572
WindowType WindowType=response!
boolean TitleBar=true
string Title="Compensazione partite aperte"
long BackColor=80263581
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
tab_1 tab_1
cb_annulla cb_annulla
dw_1 dw_1
cb_1 cb_1
cb_4 cb_4
end type
global w_prop_ass_partite_cx w_prop_ass_partite_cx

type variables
DataWindow idw_filtro, idw_recuperati, idw_selezionati
Boolean ib_removing, ib_down_source, ib_down_target
String is_filter
long ll_val
end variables

forward prototypes
public subroutine uf_setta_riga ()
end prototypes

public subroutine uf_setta_riga ();long ll_row
	
ll_row=tab_1.tabpage_2.dw_2.getrow()
tab_1.tabpage_2.dw_3.scrolltorow(ll_row)
IF ll_row>0 THEN
	tab_1.tabpage_2.dw_3.selectrow(0,false)
	tab_1.tabpage_2.dw_3.selectrow(ll_row,true)
END IF

end subroutine

on w_prop_ass_partite_cx.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.cb_annulla=create cb_annulla
this.dw_1=create dw_1
this.cb_1=create cb_1
this.cb_4=create cb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.cb_annulla
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.cb_4
end on

on w_prop_ass_partite_cx.destroy
call super::destroy
destroy(this.tab_1)
destroy(this.cb_annulla)
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.cb_4)
end on

event open;call super::open;long 	 ll_Conto
string ls_des, ls_cod

dw_1.SetTransObject(SQLCA)
dw_1.insertrow(0)


ib_removing = FALSE


tab_1.tabpage_2.dw_2.SetTransObject(SQLCA)
tab_1.tabpage_2.dw_3.SetTransObject(SQLCA)







ll_conto=message.doubleparm
if ll_conto<>0 and not isnull(ll_conto) then
   select codice, descrizione
	into :ls_cod,:ls_des
	from conto
	where id_conto=:ll_conto;
	dw_1.setitem(1,'id_conto',ll_conto)
	dw_1.setitem(1,'da_cod',ls_cod)
	dw_1.setitem(1,'da_des',ls_des)
   cb_1.TriggerEvent(Clicked!)
end if	
end event

type tab_1 from tab within w_prop_ass_partite_cx
int X=9
int Y=248
int Width=3214
int Height=1196
int TabOrder=10
boolean BringToTop=true
boolean RaggedRight=true
int SelectedTab=1
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_2}
end on

on tab_1.destroy
destroy(this.tabpage_2)
end on

event selectionchanged;
end event

event selectionchanging;choose case newindex
	case 2
		if (oldindex=3  or oldindex=4) then
			return 1
		end if
end choose
end event

type tabpage_2 from userobject within tab_1
int X=18
int Y=104
int Width=3177
int Height=1076
long BackColor=79741120
string Text="Seleziona"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_2 dw_2
dw_3 dw_3
sle_av sle_av
st_2 st_2
cb_2 cb_2
ln_1 ln_1
ln_2 ln_2
ln_3 ln_3
cb_3 cb_3
end type

on tabpage_2.create
this.dw_2=create dw_2
this.dw_3=create dw_3
this.sle_av=create sle_av
this.st_2=create st_2
this.cb_2=create cb_2
this.ln_1=create ln_1
this.ln_2=create ln_2
this.ln_3=create ln_3
this.cb_3=create cb_3
this.Control[]={this.dw_2,&
this.dw_3,&
this.sle_av,&
this.st_2,&
this.cb_2,&
this.ln_1,&
this.ln_2,&
this.ln_3,&
this.cb_3}
end on

on tabpage_2.destroy
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.sle_av)
destroy(this.st_2)
destroy(this.cb_2)
destroy(this.ln_1)
destroy(this.ln_2)
destroy(this.ln_3)
destroy(this.cb_3)
end on

type dw_2 from u_dw_pura within tabpage_2
int X=0
int Y=24
int Width=1787
int TabOrder=11
boolean BringToTop=true
string DataObject="d_prop_partita_dr_lt"
boolean TitleBar=true
string Title="Dare"
end type

event clicked;IF ROW>0 THEN
	this.selectrow(0,false)
	this.selectrow(row,true)
	tab_1.tabpage_2.dw_3.selectrow(0,false)
	tab_1.tabpage_2.dw_3.selectrow(row,true)
	tab_1.tabpage_2.dw_3.scrolltorow(row)
	tab_1.tabpage_2.dw_2.scrolltorow(row)
END IF
end event

event rowfocuschanged;

IF ib_removing = FALSE THEN
	IF NOT KeyDown(KeyControl!) AND NOT KeyDown(KeyShift!) THEN
		SelectRow(0,FALSE)
		SelectRow(currentrow, TRUE)
	END IF
	
	IF KeyDown(KeyShift!) THEN
		SelectRow(currentrow, NOT THIS.IsSelected(currentrow))
	END IF
END IF
end event

event sqlpreview;
end event

event ue_key;call super::ue_key;post uf_setta_riga()
end event

type dw_3 from u_dw_pura within tabpage_2
int X=1824
int Y=24
int Width=1339
int TabOrder=11
boolean BringToTop=true
string DataObject="d_prop_partita_av_lt"
boolean TitleBar=true
string Title="Avere"
end type

event ue_key;
end event

type sle_av from singlelineedit within tabpage_2
int X=2830
int Y=960
int Width=247
int Height=92
int TabOrder=20
boolean BringToTop=true
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

type st_2 from statictext within tabpage_2
int X=2327
int Y=972
int Width=480
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Partite recuperate:"
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

type cb_2 from commandbutton within tabpage_2
int X=1559
int Y=900
int Width=443
int Height=144
int TabOrder=30
boolean BringToTop=true
string Text="Associa partite"
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long  ll_id_mov_partita_sx, ll_id_mov_partita_dx,i, ll_val_sx, ll_val_dx, ll_val_scad
long ll_conto, ll_reg_sx, ll_reg_dx, ll_mov_sx, ll_mov_dx, ll_par_sx, ll_par_dx
decimal ld_num_sx, ld_num_dx, ld_saldo, ld_importo, ld_imp2

FOR i=1 to dw_2.rowcount()
IF dw_2.getitemnumber(i,'id_conto')=1 then
		
ll_conto=dw_3.getitemnumber(i,'id_conto')
ll_reg_sx=dw_2.getitemnumber(i,'id_reg_pd')
ll_reg_dx=dw_3.getitemnumber(i,'id_reg_pd')
ld_saldo=dw_2.getitemdecimal(i,'saldo')
ll_par_sx=dw_2.getitemnumber(i,'id_par_aperta')
ll_par_dx=dw_3.getitemnumber(i,'id_par_aperta')

select id_valuta into :ll_val_sx
from par_aperta where id_par_aperta=:ll_par_sx;
select id_valuta into :ll_val_dx
from par_aperta where id_par_aperta=:ll_par_dx;

select id_mov_contabile, numero 
into :ll_mov_sx, :ld_num_sx
from  mov_contabile
where id_reg_pd=:ll_reg_sx and id_conto=:ll_conto;

select id_mov_contabile, numero 
into :ll_mov_dx, :ld_num_dx
from  mov_contabile
where id_reg_pd=:ll_reg_dx and id_conto=:ll_conto;

if ll_reg_sx=0 then setnull(ll_reg_sx);if ll_reg_dx=0 then setnull(ll_reg_dx);
if ll_mov_sx=0 then setnull(ll_mov_sx);if ll_mov_dx=0 then setnull(ll_mov_dx);

select fn_conv_valuta(:ll_val,:ld_saldo,:ll_val_sx) into :ld_imp2 from sys.dummy; 
ld_imp2=f_round_2(ll_val_sx,ld_imp2)   

INSERT INTO mov_partita (id_par_aperta, id_mov_contabile, id_reg_pd, num_riga_mov_contabile, data, importo, imp_valuta, id_azienda, id_par_associata)
	    			  VALUES (:ll_par_sx, :ll_mov_dx, :ll_reg_dx, :ld_num_dx, today(), :ld_imp2, :ld_imp2, 1, :ll_par_dx) ;

commit;

select max(id_mov_partita)
into :ll_id_mov_partita_sx
from mov_partita;

select fn_conv_valuta(:ll_val,:ld_saldo,:ll_val_dx) into :ld_imp2 from sys.dummy; 
ld_imp2=f_round_2(ll_val_dx,ld_imp2)   

INSERT INTO mov_partita (id_par_aperta, id_mov_contabile, id_reg_pd, num_riga_mov_contabile, data, importo, imp_valuta, id_azienda, id_par_associata)
	    			  VALUES (:ll_par_dx, :ll_mov_sx, :ll_reg_sx, :ld_num_sx, today(), :ld_imp2, :ld_imp2, 1, :ll_par_sx ) ;

commit;

select max(id_mov_partita)
into :ll_id_mov_partita_dx
from mov_partita;

update par_aperta 
set stato='C'
where id_par_aperta=:ll_par_dx;
commit;
   
update par_aperta 
set stato='C'
where id_par_aperta=:ll_par_sx;
commit;

ld_importo=ld_saldo
long ll_scad
decimal ld_importo_scad
date ld_data_scad
  
DECLARE lcur_scadenza_sx CURSOR FOR
SELECT id_scadenza,importo, data_scadenza, id_valuta
		FROM scadenza
		WHERE id_par_aperta=:ll_par_sx and ( esito_pagamento='E' or esito_pagamento='D' )
		order by data_scadenza;

OPEN lcur_scadenza_sx;
FETCH lcur_scadenza_sx INTO :ll_scad, :ld_importo_scad, :ld_data_scad, :ll_val_scad;

DO WHILE ( SQLCA.SQLCode = 0 ) and ld_importo>0
	
	   select fn_conv_valuta(:ll_val,:ld_importo,:ll_val_scad) into :ld_imp2 from sys.dummy; 
		ld_imp2=f_round_2(ll_val_scad,ld_imp2)   
	
		CHOOSE CASE ld_importo_scad
				
				CASE ld_imp2
					INSERT INTO "mov_scadenza"  
							 ( "id_mov_scadenza",   
								"id_scadenza",   
								"id_mov_partita",   
								"data",   
								"importo",   
								"imp_valuta",     
								"id_azienda" )  
					VALUES ( null,   
								:ll_scad,   
								:ll_id_mov_partita_sx,   
								:ld_data_scad,   
								:ld_importo_scad,   
								:ld_importo_scad,    
								1 )  ;			  
					if sqlca.sqlcode<>0 then
						messagebox("Attenzione!", "Gestione chiusura scadenze fallita! 304 updateend dw_mov_contabile_gd")
					else
						update scadenza
						set esito_pagamento='P'
						where id_scadenza=:ll_scad;	
					end if
					ld_imp2=0
						
				CASE is>ld_imp2
					INSERT INTO "mov_scadenza"  
							 ( "id_mov_scadenza",   
								"id_scadenza",   
								"id_mov_partita",   
								"data",   
								"importo",   
								"imp_valuta",     
								"id_azienda" )  
					VALUES ( null,   
								:ll_scad,   
								:ll_id_mov_partita_sx,   
								:ld_data_scad,   
								:ld_imp2,   
								:ld_imp2,    
								1 )  ;			  
					if sqlca.sqlcode<>0 then
						messagebox("Attenzione!", "Gestione chiusura scadenze fallita! 304 updateend dw_mov_contabile_gd")
					end if
					ld_imp2=0
					
				CASE is<ld_imp2	
					INSERT INTO "mov_scadenza"  
							 ( "id_mov_scadenza",   
								"id_scadenza",   
								"id_mov_partita",   
								"data",   
								"importo",   
								"imp_valuta",     
								"id_azienda" )  
					VALUES ( null,   
								:ll_scad,   
								:ll_id_mov_partita_sx,   
								:ld_data_scad,   
								:ld_importo_scad,   
								:ld_importo_scad,    
								1 )  ;			  

					if sqlca.sqlcode<>0 then
						messagebox("Attenzione!", "Gestione chiusura scadenze fallita! 304 updateend dw_mov_contabile_gd")
					else
						update scadenza
						set esito_pagamento='P'
						where id_scadenza=:ll_scad;	
					end if
					ld_imp2=ld_imp2 - ld_importo_scad
					select fn_conv_valuta(:ll_val_scad,:ld_imp2,:ll_val) into :ld_imp2 from sys.dummy; 
					ld_importo=f_round_2(ll_val,ld_imp2)   
					
		END CHOOSE
		FETCH lcur_scadenza_sx INTO :ll_scad, :ld_importo_scad, :ld_data_scad;
LOOP	

CLOSE lcur_scadenza_sx;
commit;

ld_importo=ld_saldo
DECLARE lcur_scadenza_dx CURSOR FOR
			SELECT id_scadenza,importo, data_scadenza, id_valuta
				FROM scadenza
				WHERE id_par_aperta=:ll_par_dx and ( esito_pagamento='E' or esito_pagamento='D' )
				order by data_scadenza;

		OPEN lcur_scadenza_dx;
		FETCH lcur_scadenza_dx INTO :ll_scad, :ld_importo_scad, :ld_data_scad, :ll_val_scad;

		DO WHILE ( SQLCA.SQLCode = 0 ) and ld_importo>0
			
			select fn_conv_valuta(:ll_val,:ld_importo,:ll_val_scad) into :ld_imp2 from sys.dummy; 
		   ld_imp2=f_round_2(ll_val_scad,ld_imp2)   
			
			CHOOSE CASE ld_importo_scad
				
				CASE ld_imp2
					INSERT INTO "mov_scadenza"  
							 ( "id_mov_scadenza",   
								"id_scadenza",   
								"id_mov_partita",   
								"data",   
								"importo",   
								"imp_valuta",     
								"id_azienda" )  
					VALUES ( null,   
								:ll_scad,   
								:ll_id_mov_partita_dx,   
								:ld_data_scad,   
								:ld_importo_scad,   
								:ld_importo_scad,    
								1 )  ;			  
					if sqlca.sqlcode<>0 then
						messagebox("Attenzione!", "Gestione chiusura scadenze fallita! 304 updateend dw_mov_contabile_gd")
					else
						update scadenza
						set esito_pagamento='P'
						where id_scadenza=:ll_scad;	
					end if
					ld_imp2=0
						
				CASE is>ld_imp2
					INSERT INTO "mov_scadenza"  
							 ( "id_mov_scadenza",   
								"id_scadenza",   
								"id_mov_partita",   
								"data",   
								"importo",   
								"imp_valuta",     
								"id_azienda" )  
					VALUES ( null,   
								:ll_scad,   
								:ll_id_mov_partita_dx,   
								:ld_data_scad,   
								:ld_imp2,   
								:ld_imp2,    
								1 )  ;			  
					if sqlca.sqlcode<>0 then
						messagebox("Attenzione!", "Gestione chiusura scadenze fallita! 304 updateend dw_mov_contabile_gd")
					end if
					ld_importo=0
					
				CASE is<ld_imp2	
					INSERT INTO "mov_scadenza"  
							 ( "id_mov_scadenza",   
								"id_scadenza",   
								"id_mov_partita",   
								"data",   
								"importo",   
								"imp_valuta",     
								"id_azienda" )  
					VALUES ( null,   
								:ll_scad,   
								:ll_id_mov_partita_dx,   
								:ld_data_scad,   
								:ld_importo_scad,   
								:ld_importo_scad,    
								1 )  ;			  
					if sqlca.sqlcode<>0 then
						messagebox("Attenzione!", "Gestione chiusura scadenze fallita! 304 updateend dw_mov_contabile_gd")
					else
						update scadenza
						set esito_pagamento='P'
						where id_scadenza=:ll_scad;	
					end if
					ld_imp2=ld_imp2 - ld_importo_scad
					select fn_conv_valuta(:ll_val_scad,:ld_imp2,:ll_val) into :ld_imp2 from sys.dummy; 
					ld_importo=f_round_2(ll_val,ld_imp2)   
					
			END CHOOSE
			FETCH lcur_scadenza_dx INTO :ll_scad, :ld_importo_scad, :ld_data_scad;
LOOP	

CLOSE lcur_scadenza_dx;
commit;
tab_1.tabpage_2.dw_2.deleterow(i)
tab_1.tabpage_2.dw_3.deleterow(i)
i= i - 1

END IF
NEXT



	
end event

type ln_1 from line within tabpage_2
boolean Enabled=false
int BeginX=1422
int BeginY=848
int EndX=1422
int EndY=964
int LineThickness=8
long LineColor=33554432
end type

type ln_2 from line within tabpage_2
boolean Enabled=false
int BeginX=2094
int BeginY=848
int EndX=2094
int EndY=968
int LineThickness=8
long LineColor=33554432
end type

type ln_3 from line within tabpage_2
boolean Enabled=false
int BeginX=1422
int BeginY=968
int EndX=2094
int EndY=968
int LineThickness=8
long LineColor=33554432
end type

type cb_3 from commandbutton within tabpage_2
int X=443
int Y=888
int Width=398
int Height=92
int TabOrder=20
boolean BringToTop=true
string Text="Pag successiva"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;tab_1.tabpage_2.dw_2.ScrollNextPage ( ) 
tab_1.tabpage_2.dw_3.ScrollNextPage ( ) 
end event

type cb_annulla from commandbutton within w_prop_ass_partite_cx
int X=2848
int Y=28
int Width=329
int Height=144
int TabOrder=40
boolean BringToTop=true
string Text="&Chiudi"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
closewithreturn(parent,1)
end event

type dw_1 from u_dw_ext_main within w_prop_ass_partite_cx
int X=27
int Y=28
int Width=1765
int Height=152
int TabOrder=20
boolean BringToTop=true
string DataObject="d_prop_partite_fil_ff"
end type

event ue_set_search;
end event

event ue_use_search;
end event

event itemchanged;
end event

type cb_1 from commandbutton within w_prop_ass_partite_cx
int X=1902
int Y=28
int Width=384
int Height=144
int TabOrder=30
boolean BringToTop=true
string Text="Carica"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;date ld_data
long ll_conto, ll_ret
long ll_id_reg_pd,ll_id_par_aperta,i,j

ll_val=dw_1.getitemnumber(1,'id_valuta') 

datastore ds_partita
ds_partita=create datastore

ds_partita.dataobject='ds_prop_partita_lt'
ds_partita.reset()
ds_partita.settransobject(sqlca)


ll_conto=dw_1.getitemnumber(1,'id_conto')

	ld_data=dw_1.getitemdate(1,'data_reg')
	if isnull(ld_data) then ld_data=date('01/01/1998')
	ll_ret=ds_partita.retrieve('aa',ld_data,'zz',ll_val)  
	
	FOR i=1 to ll_ret
		 IF ds_partita.getitemstring(i,'stato')='A' then
			 FOR j=i+1 to ll_ret
				  IF ds_partita.getitemstring(j,'stato')='A' then
				  	  IF ds_partita.getitemnumber(i,'id_conto')<>ds_partita.getitemnumber(j,'id_conto') or ds_partita.getitemnumber(i,'saldo')<>ds_partita.getitemnumber(j,'saldo') then
						  j=ll_ret
					  ELSE
						  long seg_2, seg_1
						  seg_1=ds_partita.getitemnumber(i,'segno_iva')
						  seg_2=ds_partita.getitemnumber(j,'segno_iva')
						  IF seg_1<>seg_2 then		
							  ds_partita.setitem(i,'stato','S')
						     ds_partita.setitem(j,'stato','S')	
						     j=ll_ret
						  END IF  
					  END IF	
				  END IF	  
			 NEXT	
		 END IF	
	NEXT
	
	
	ll_ret=ds_partita.setfilter("stato='S' and segno_iva="+string(1))
	ll_ret=ds_partita.filter()
	ll_ret=ds_partita.rowcount()
	ds_partita.RowsCopy(1, ll_ret, Primary!, tab_1.tabpage_2.dw_2, 1, Primary!)
	
	if ll_RET>0 then
		FOR i=1 TO ll_RET
			ll_id_par_aperta=tab_1.tabpage_2.dw_2.getitemnumber(i,"id_par_aperta")
			select id_reg_pd
			into :ll_id_reg_pd
			from par_aperta
			where id_par_aperta=:ll_id_par_aperta;
			tab_1.tabpage_2.dw_2.setitem(i,"id_reg_pd",ll_id_reg_pd)
		NEXT
	end if
	
   ll_ret=ds_partita.setfilter("stato='S' and segno_iva="+string(-1))
	ll_ret=ds_partita.filter()
	ll_ret=ds_partita.rowcount()
	ds_partita.RowsCopy(1, ll_ret, Primary!, tab_1.tabpage_2.dw_3, 1, Primary!)

	tab_1.tabpage_2.sle_av.text=string(ll_ret)
	if ll_RET>0 then
		FOR i=1 TO ll_RET
			ll_id_par_aperta=tab_1.tabpage_2.dw_3.getitemnumber(i,"id_par_aperta")
			select id_reg_pd
			into :ll_id_reg_pd
			from par_aperta
			where id_par_aperta=:ll_id_par_aperta;
			tab_1.tabpage_2.dw_3.setitem(i,"id_reg_pd",ll_id_reg_pd)
		NEXT
	end if
	
	


end event

type cb_4 from commandbutton within w_prop_ass_partite_cx
int X=55
int Y=1240
int Width=411
int Height=92
int TabOrder=30
boolean BringToTop=true
string Text="Pag precedente"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;tab_1.tabpage_2.dw_2.ScrollPriorPage ( ) 
tab_1.tabpage_2.dw_3.ScrollPriorPage ( ) 
end event

