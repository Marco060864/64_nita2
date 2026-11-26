forward
global type w_chiudi_partite_cx from w_wiz_main
end type
type tab_1 from tab within w_chiudi_partite_cx
end type
type tabpage_2 from userobject within tab_1
end type
type dw_2 from u_dw_pura within tabpage_2
end type
type sle_dr from singlelineedit within tabpage_2
end type
type st_1 from statictext within tabpage_2
end type
type cb_2 from commandbutton within tabpage_2
end type
type cb_annulla from commandbutton within w_chiudi_partite_cx
end type
type dw_1 from u_dw_ext_main within w_chiudi_partite_cx
end type
type cb_1 from commandbutton within w_chiudi_partite_cx
end type
type cb_3 from commandbutton within w_chiudi_partite_cx
end type
type tabpage_2 from userobject within tab_1
dw_2 dw_2
sle_dr sle_dr
st_1 st_1
cb_2 cb_2
end type
type tab_1 from tab within w_chiudi_partite_cx
tabpage_2 tabpage_2
end type
end forward

global type w_chiudi_partite_cx from w_wiz_main
int Width=3067
int Height=1672
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
cb_3 cb_3
end type
global w_chiudi_partite_cx w_chiudi_partite_cx

type variables
DataWindow idw_filtro, idw_recuperati, idw_selezionati
Boolean ib_removing, ib_down_source, ib_down_target
String is_filter
long ll_val
end variables

on w_chiudi_partite_cx.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.cb_annulla=create cb_annulla
this.dw_1=create dw_1
this.cb_1=create cb_1
this.cb_3=create cb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.cb_annulla
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.cb_3
end on

on w_chiudi_partite_cx.destroy
call super::destroy
destroy(this.tab_1)
destroy(this.cb_annulla)
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.cb_3)
end on

event open;call super::open;long 	 ll_Conto
string ls_des, ls_cod

dw_1.SetTransObject(SQLCA)
dw_1.insertrow(0)


ib_removing = FALSE


tab_1.tabpage_2.dw_2.SetTransObject(SQLCA)






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

select e.id_valuta into :ll_val 
from esercizio e, azienda a where a.id_esercizio=e.id_esercizio;
dw_1.setitem(1,'id_valuta',ll_val)

end event

type tab_1 from tab within w_chiudi_partite_cx
int X=27
int Y=332
int Width=2985
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
int Width=2949
int Height=1076
long BackColor=79741120
string Text="Seleziona"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_2 dw_2
sle_dr sle_dr
st_1 st_1
cb_2 cb_2
end type

on tabpage_2.create
this.dw_2=create dw_2
this.sle_dr=create sle_dr
this.st_1=create st_1
this.cb_2=create cb_2
this.Control[]={this.dw_2,&
this.sle_dr,&
this.st_1,&
this.cb_2}
end on

on tabpage_2.destroy
destroy(this.dw_2)
destroy(this.sle_dr)
destroy(this.st_1)
destroy(this.cb_2)
end on

type dw_2 from u_dw_pura within tabpage_2
int X=0
int Y=24
int Width=1559
int TabOrder=11
boolean BringToTop=true
string DataObject="d_chiudi_partita_lt"
boolean TitleBar=true
string Title="Dare"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event clicked;IF ROW>0 THEN
	this.selectrow(0,false)
	this.selectrow(row,true)
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

type sle_dr from singlelineedit within tabpage_2
int X=695
int Y=956
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

type st_1 from statictext within tabpage_2
int X=110
int Y=968
int Width=521
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
int X=1646
int Y=56
int Width=443
int Height=144
int TabOrder=30
boolean BringToTop=true
string Text="Chiudi partite"
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long  ll_row_dr, ll_id_mov_partita_sx
long ll_conto_sx, ll_mov_sx, ll_reg_sx, ll_par_sx, ll_val_sx 

decimal ld_num_sx, ld_saldo_sx, ld_importo, ld_imp2

ll_row_dr=dw_2.GetSelectedRow(0)

if ll_row_dr<=0  then
	messagebox('Attenzione',"Nella finestra non è stata selezionata alcuna riga.~r~nImpossibile proseguire con la chiusura delle partite")   
	return
end if

ll_conto_sx=dw_2.getitemnumber(ll_row_dr,'id_conto')
ll_reg_sx=dw_2.getitemnumber(ll_row_dr,'id_reg_pd')
ld_saldo_sx=dw_2.getitemdecimal(ll_row_dr,'saldo')
ll_par_sx=dw_2.getitemnumber(ll_row_dr,'id_par_aperta')

select id_valuta into :ll_val_sx
from par_aperta where id_par_aperta=:ll_par_sx;

select id_mov_contabile, numero 
into :ll_mov_sx, :ld_num_sx
from  mov_contabile
where id_reg_pd=:ll_reg_sx and id_conto=:ll_conto_sx;


if ll_reg_sx=0 then setnull(ll_reg_sx)
if ll_mov_sx=0 then setnull(ll_mov_sx)

ld_importo=ld_saldo_sx

select fn_conv_valuta(:ll_val,:ld_importo,:ll_val_sx) into :ld_imp2 from sys.dummy; 
ld_imp2=f_round_2(ll_val_sx,ld_imp2)   

INSERT INTO mov_partita (id_par_aperta, data, importo, imp_valuta, id_azienda)
	    			  VALUES (:ll_par_sx, today(), :ld_imp2, :ld_imp2, 1) ;

commit;

select max(id_mov_partita)
into :ll_id_mov_partita_sx
from mov_partita;

						
Update par_aperta 
set stato='C'
where id_par_aperta=:ll_par_sx;
commit;


long ll_scad, ll_val_scad
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


cb_1.TriggerEvent(Clicked!)
	
end event

type cb_annulla from commandbutton within w_chiudi_partite_cx
int X=2629
int Y=32
int Width=329
int Height=84
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

type dw_1 from u_dw_ext_main within w_chiudi_partite_cx
int X=27
int Y=36
int Width=2002
int Height=260
int TabOrder=20
boolean BringToTop=true
string DataObject="d_ass_partite_fil_ff"
end type

event ue_set_search;CHOOSE CASE as_nomecol
	
	CASE "da_cod", "da_des"
		
      is_search_window = "w_conti_pdc_sw"
		IF as_nomecol = "da_cod" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "conto_codice"
		ELSEIF as_nomecol = "da_des" THEN
			
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "conto_descrizione"
		END IF
end choose		
end event

event ue_use_search;CHOOSE CASE as_nomecol
CASE "da_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_conto", is_ricpar.s_id_seg_value[1])
		uf_set_colval("da_des", is_ricpar.s_ausil_value[1])
		
		
	CASE "da_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_conto", is_ricpar.s_id_seg_value[1])
		uf_set_colval("da_cod", is_ricpar.s_ausil_value[1])
		
end choose		
end event

event itemchanged;
string ls_dbc[], ls_dbv[], ls_dwc[]

integer li_ok



choose case dwo.name
	CASE "da_cod"

		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_conto"
		ls_dwc[1] = "da_cod"
		ls_dwc[2] = "da_des"
		ls_dwc[3] = "id_conto"
		li_ok = uf_autofind_col(string(dwo.name), "conto", "codice", "A", data, "", 3, ls_dbc, ls_dbv, ls_dwc)
		IF li_ok > 0 THEN
			RETURN 2
		END IF
	CASE "da_des"

		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_conto"
		ls_dwc[1] = "da_cod"
		ls_dwc[2] = "da_des"
		ls_dwc[3] = "id_conto"
		li_ok = uf_autofind_col(string(dwo.name), "conto", "descrizione", "A", data, "", 3, ls_dbc, ls_dbv, ls_dwc)
		IF li_ok > 0 THEN
			RETURN 2
		END IF

END CHOOSE

end event

type cb_1 from commandbutton within w_chiudi_partite_cx
int X=2629
int Y=116
int Width=329
int Height=92
int TabOrder=30
boolean BringToTop=true
string Text="Carica partite"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;date ld_data
long ll_conto, ll_ret
long ll_id_reg_pd,ll_id_par_aperta,i

ll_conto=dw_1.getitemnumber(1,'id_conto')
ll_val=dw_1.getitemnumber(1,'id_valuta') 

if not isnull(ll_conto) then 
	ld_data=dw_1.getitemdate(1,'data_reg')
	if isnull(ld_data) then ld_data=date('01/01/1900')
	ll_ret=tab_1.tabpage_2.dw_2.retrieve(ll_conto,ld_data,ll_val)    
	tab_1.tabpage_2.sle_dr.text=string(ll_ret)
	if ll_RET<>0 then
		FOR i=1 TO ll_RET
			ll_id_par_aperta=tab_1.tabpage_2.dw_2.getitemnumber(i,"id_par_aperta")
			select id_reg_pd
			into :ll_id_reg_pd
			from par_aperta
			where id_par_aperta=:ll_id_par_aperta;
			tab_1.tabpage_2.dw_2.setitem(i,"id_reg_pd",ll_id_reg_pd)
		NEXT
	end if
	
else 
	messagebox('Attenzione', 'Non hai selezionato nessun conto')
end if


end event

type cb_3 from commandbutton within w_chiudi_partite_cx
int X=2629
int Y=208
int Width=329
int Height=92
int TabOrder=50
boolean BringToTop=true
string Text="Dissocia"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_conto

ll_conto=dw_1.getitemnumber(1,'id_conto')
openwithparm(w_dissocia_partite_cx,ll_conto)

 cb_1.TriggerEvent(Clicked!)
end event

