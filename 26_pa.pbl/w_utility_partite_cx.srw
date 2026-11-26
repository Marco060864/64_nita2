forward
global type w_utility_partite_cx from w_wiz_main
end type
type tab_1 from tab within w_utility_partite_cx
end type
type tabpage_2 from userobject within tab_1
end type
type dw_2 from u_dw_pura within tabpage_2
end type
type sle_av from singlelineedit within tabpage_2
end type
type st_2 from statictext within tabpage_2
end type
type cb_3 from commandbutton within tabpage_2
end type
type cb_2 from commandbutton within tabpage_2
end type
type cbx_1 from checkbox within tabpage_2
end type
type cb_annulla from commandbutton within w_utility_partite_cx
end type
type dw_1 from u_dw_ext_main within w_utility_partite_cx
end type
type cb_1 from commandbutton within w_utility_partite_cx
end type
type cb_4 from commandbutton within w_utility_partite_cx
end type
type tabpage_2 from userobject within tab_1
dw_2 dw_2
sle_av sle_av
st_2 st_2
cb_3 cb_3
cb_2 cb_2
cbx_1 cbx_1
end type
type tab_1 from tab within w_utility_partite_cx
tabpage_2 tabpage_2
end type
end forward

global type w_utility_partite_cx from w_wiz_main
int Width=2871
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
global w_utility_partite_cx w_utility_partite_cx

type variables
DataWindow idw_filtro, idw_recuperati, idw_selezionati
Boolean ib_removing, ib_down_source, ib_down_target
String is_filter
long ll_val, il_val_euro
end variables

on w_utility_partite_cx.create
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

on w_utility_partite_cx.destroy
call super::destroy
destroy(this.tab_1)
destroy(this.cb_annulla)
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.cb_4)
end on

event open;call super::open;

long 	 ll_Conto
string ls_des, ls_cod

dw_1.SetTransObject(SQLCA)
dw_1.insertrow(0)

ib_removing = FALSE


tab_1.tabpage_2.dw_2.SetTransObject(SQLCA)

select id_val_euro into :il_val_euro
from par_sistema;

dw_1.setitem(1, 'id_valuta', il_val_euro)
dw_1.setitem(1, 'val_euro', il_val_euro)
dw_1.setitem(1, 'saldo', 0.25)
dw_1.setitem(1, 'data_reg', today())
end event

type tab_1 from tab within w_utility_partite_cx
int X=9
int Y=248
int Width=2802
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
int Width=2766
int Height=1076
long BackColor=79741120
string Text="Seleziona"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_2 dw_2
sle_av sle_av
st_2 st_2
cb_3 cb_3
cb_2 cb_2
cbx_1 cbx_1
end type

on tabpage_2.create
this.dw_2=create dw_2
this.sle_av=create sle_av
this.st_2=create st_2
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cbx_1=create cbx_1
this.Control[]={this.dw_2,&
this.sle_av,&
this.st_2,&
this.cb_3,&
this.cb_2,&
this.cbx_1}
end on

on tabpage_2.destroy
destroy(this.dw_2)
destroy(this.sle_av)
destroy(this.st_2)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cbx_1)
end on

type dw_2 from u_dw_pura within tabpage_2
int X=0
int Y=24
int Width=2738
int TabOrder=11
boolean BringToTop=true
string DataObject="d_utility_partita_lt"
boolean TitleBar=true
string Title="Dare"
boolean HScrollBar=true
boolean HSplitScroll=true
end type

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

type sle_av from singlelineedit within tabpage_2
int X=1925
int Y=864
int Width=247
int Height=84
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
int X=1422
int Y=880
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

type cb_3 from commandbutton within tabpage_2
int X=9
int Y=956
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

end event

type cb_2 from commandbutton within tabpage_2
int X=2281
int Y=860
int Width=443
int Height=180
int TabOrder=30
boolean BringToTop=true
string Text="&Chiudi partite"
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long  ll_id_mov_partita_sx, ll_id_mov_partita_dx,i, ll_val_sx, ll_val_dx, ll_val_scad
long ll_conto, ll_reg_sx, ll_mov_sx, ll_par_sx
decimal ld_num_sx, ld_saldo, ld_importo, ld_imp2

FOR i=1 to dw_2.rowcount()
	 IF dw_2.getitemnumber(i,'id_chek')=1 then

	    ll_reg_sx=dw_2.getitemnumber(i,'id_reg_pd')

	    ld_saldo=dw_2.getitemdecimal(i,'saldo')
    	 ll_par_sx=dw_2.getitemnumber(i,'id_par_aperta')
		 ll_conto=dw_2.getitemnumber(i,'id_conto')

		select id_valuta into :ll_val_sx
		from par_aperta where id_par_aperta=:ll_par_sx;

		select id_mov_contabile, numero 
		into :ll_mov_sx, :ld_num_sx
		from  mov_contabile
		where id_reg_pd=:ll_reg_sx and id_conto=:ll_conto;

		if ll_reg_sx=0 then setnull(ll_reg_sx)
		if ll_mov_sx=0 then setnull(ll_mov_sx)

		select fn_conv_valuta(:ll_val,:ld_saldo,:ll_val_sx) into :ld_imp2 from sys.dummy; 
		ld_imp2=f_round_2(ll_val_sx,ld_imp2)   

		INSERT INTO mov_partita (id_par_aperta, id_mov_contabile, id_reg_pd, num_riga_mov_contabile, data, importo, imp_valuta, id_azienda)
	    			  VALUES (:ll_par_sx, :ll_mov_sx, :ll_reg_sx, :ld_num_sx, today(), :ld_imp2, :ld_imp2, 1) ;

		commit;

		select max(id_mov_partita)
		into :ll_id_mov_partita_sx
		from mov_partita;
	
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

		tab_1.tabpage_2.dw_2.deleterow(i)
		i= i - 1
	END IF
NEXT

end event

type cbx_1 from checkbox within tabpage_2
int X=1509
int Y=968
int Width=658
int Height=76
boolean BringToTop=true
string Text="Seleziona tutte"
BorderStyle BorderStyle=StyleLowered!
boolean LeftText=true
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;integer i
if this.Checked = TRUE then
	FOR i=1 to tab_1.tabpage_2.dw_2.rowcount()
		 tab_1.tabpage_2.dw_2.setitem(i,'id_chek',1)
	NEXT		
else
	FOR i=1 to tab_1.tabpage_2.dw_2.rowcount()
		 tab_1.tabpage_2.dw_2.setitem(i,'id_chek',0)
	NEXT		
end if
end event

type cb_annulla from commandbutton within w_utility_partite_cx
int X=2578
int Y=36
int Width=242
int Height=100
int TabOrder=50
boolean BringToTop=true
string Text="&Annulla"
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

type dw_1 from u_dw_ext_main within w_utility_partite_cx
int X=27
int Y=28
int Width=2144
int Height=168
int TabOrder=20
boolean BringToTop=true
string DataObject="d_utility_partite_fil_ff"
end type

event ue_set_search;
end event

event ue_use_search;
end event

event itemchanged;if dwo.name="id_valuta" then
	if il_val_euro=long(data) then
		dw_1.setitem(1,'saldo', 0.25)
	else	
	   dw_1.setitem(1,'saldo', 500)
	end if	
end if


end event

type cb_1 from commandbutton within w_utility_partite_cx
int X=2254
int Y=36
int Width=279
int Height=96
int TabOrder=30
boolean BringToTop=true
string Text="&Carica"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;date ld_data
long ll_ret
decimal ll_saldo
string ls_filter


ll_val=dw_1.getitemnumber(1,'id_valuta')
ld_data=dw_1.getitemdate(1,'data_reg')
ll_saldo=dw_1.getitemnumber(1,'saldo')
if isnull(ll_saldo) or isnull(ll_val) or isnull(ld_data) then
	messagebox('Attenzione','Uno dei parametri non è stato inserito correttamente')
	return
end if	

ll_ret=tab_1.tabpage_2.dw_2.retrieve(ld_data,ll_val)

if il_val_euro=ll_val then
	ll_saldo=round((ll_saldo*100),0)
	ls_filter="abs(saldo)<="+string(ll_saldo)+string('/100')
else
	ls_filter="abs(saldo)<="+string(round(ll_saldo,0))
end if

tab_1.tabpage_2.dw_2.setfilter(ls_filter)
tab_1.tabpage_2.dw_2.filter()
ll_ret=tab_1.tabpage_2.dw_2.rowcount()
tab_1.tabpage_2.sle_av.text=string(ll_ret)


end event

type cb_4 from commandbutton within w_utility_partite_cx
int X=37
int Y=1212
int Width=398
int Height=92
int TabOrder=40
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

end event

