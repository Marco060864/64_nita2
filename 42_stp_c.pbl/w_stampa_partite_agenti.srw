forward
global type w_stampa_partite_agenti from Window
end type
type cb_5 from commandbutton within w_stampa_partite_agenti
end type
type cb_4 from commandbutton within w_stampa_partite_agenti
end type
type cb_3 from commandbutton within w_stampa_partite_agenti
end type
type cb_2 from commandbutton within w_stampa_partite_agenti
end type
type cb_1 from commandbutton within w_stampa_partite_agenti
end type
type dw_1 from datawindow within w_stampa_partite_agenti
end type
end forward

global type w_stampa_partite_agenti from Window
int X=7
int Y=48
int Width=3716
int Height=2282
boolean TitleBar=true
string Title="Estratto Conto per Agente"
long BackColor=79741120
boolean ControlMenu=true
WindowType WindowType=response!
event ue_post_open ( )
cb_5 cb_5
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_stampa_partite_agenti w_stampa_partite_agenti

event ue_post_open;

decimal ld_tot, ld_totale
long ld_dif, ll_num, ll_breakrow, ll_rig, ll_id_conto, somma_mov, conta, ll_righe
boolean lb_found
STRING ls_codice
open (w_attesa)

ll_righe = dw_1.rowcount()
if ll_righe >= 1 then
	
lb_found = FALSE
ll_breakrow = 0
			
DO WHILE NOT (lb_found)
ll_breakrow = dw_1.FindGroupChange(ll_breakrow, 1)
	
IF ll_breakrow <= 0 THEN
	ll_num = dw_1.rowcount()
					
	ls_codice=dw_1.object.conto_codice[ll_num]
		
		 SELECT count("mov_partita"."importo")
		 into :conta
		 	 FROM "par_aperta",   
         		"conto",   
		         "mov_partita"  
		   WHERE ( "par_aperta"."id_par_aperta" = "mov_partita"."id_par_aperta" ) and  
      		   ( "conto"."id_conto" = "par_aperta"."id_conto" ) and  
		         ( ( "conto"."codice" = :ls_codice ) AND  
      		   ( "par_aperta"."id_par_aperta_padre" is null ) ) ;   

		if conta > 0 then
		
			SELECT sum("mov_partita"."importo")
				 into :somma_mov
			 	 FROM "par_aperta",   
	         		"conto",   
			         "mov_partita"  
		   	WHERE ( "par_aperta"."id_par_aperta" = "mov_partita"."id_par_aperta" ) and  
      			   ( "conto"."id_conto" = "par_aperta"."id_conto" ) and  
		         	( ( "conto"."codice" = :ls_codice ) AND  
   	   		   ( "par_aperta"."id_par_aperta_padre" is null ) ) ;   
		else
			somma_mov = 0
		end if
		
		ld_tot=dw_1.object.tot_par[ll_num].object.som_par[1]
		ld_dif = ld_tot - somma_mov
		dw_1.Object.saldo_partite[ll_num] = ld_dif
	
		
EXIT
ELSE

	IF ll_breakrow > 1 THEN
		ll_num = (ll_breakrow - 1)
	END IF
	IF ll_breakrow = 1 THEN
		ll_num = dw_1.rowcount()
	END IF
	ls_codice=dw_1.object.conto_codice[ll_num]
		
		 SELECT count("mov_partita"."importo")
		 into :conta
		 	 FROM "par_aperta",   
         		"conto",   
		         "mov_partita"  
		   WHERE ( "par_aperta"."id_par_aperta" = "mov_partita"."id_par_aperta" ) and  
      		   ( "conto"."id_conto" = "par_aperta"."id_conto" ) and  
		         ( ( "conto"."codice" = :ls_codice ) AND  
      		   ( "par_aperta"."id_par_aperta_padre" is null ) ) ;   

		if conta > 0 then
		
			SELECT sum("mov_partita"."importo")
				 into :somma_mov
			 	 FROM "par_aperta",   
	         		"conto",   
			         "mov_partita"  
		   	WHERE ( "par_aperta"."id_par_aperta" = "mov_partita"."id_par_aperta" ) and  
      			   ( "conto"."id_conto" = "par_aperta"."id_conto" ) and  
		         	( ( "conto"."codice" = :ls_codice ) AND  
   	   		   ( "par_aperta"."id_par_aperta_padre" is null ) ) ;   
		else
			somma_mov = 0
		end if
		ld_tot=dw_1.object.tot_par[ll_num].object.som_par[1]
		ld_dif = ld_tot - somma_mov
		dw_1.Object.saldo_partite[ll_num] = ld_dif
		
	
	lb_found = false
	ll_breakrow = ll_breakrow + 1

END IF		
LOOP
else
	close (w_attesa)
	messagebox ('Attenzione', 'Non ci sono valori recuperati')

end if

	close (w_attesa)
end event

on w_stampa_partite_agenti.create
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_5,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_stampa_partite_agenti.destroy
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;date d_dat1, d_dat2
string ls_codice1, ls_codice2, ls_stato
s_param_partite s_parametri   
string ls_da_gr_ag, ls_a_gr_ag
s_parametri=message.powerobjectparm
ls_codice1 = s_parametri.codice1
ls_codice2 = s_parametri.codice2
d_dat1 = s_parametri.dat1
d_dat2 = s_parametri.dat2
ls_stato = s_parametri.stato
ls_da_gr_ag=s_parametri.da_gruppo_agente
ls_a_gr_ag=s_parametri.a_gruppo_agente

dw_1.settransobject(sqlca)

dw_1.retrieve(ls_codice1, ls_codice2, d_dat1, d_dat2, ls_stato,ls_da_gr_ag, ls_a_gr_ag)

LONG LL_ROW
INTEGER I
LL_ROW = DW_1.ROWCOUNT()

FOR I = 1 TO LL_ROW

	dw_1.setitem(I,"dat1", d_dat1)
	dw_1.setitem(I,"dat2", d_dat2)
NEXT

this.event post ue_post_open()
end event

type cb_5 from commandbutton within w_stampa_partite_agenti
int X=40
int Y=45
int Width=249
int Height=93
int TabOrder=60
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

type cb_4 from commandbutton within w_stampa_partite_agenti
int X=1412
int Y=45
int Width=464
int Height=93
int TabOrder=50
string Text="Pagina Successiva"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.ScrollNextPage ( ) 
end event

type cb_3 from commandbutton within w_stampa_partite_agenti
int X=900
int Y=45
int Width=464
int Height=93
int TabOrder=40
string Text="Pagina Precedente"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.ScrollPriorPage ( ) 

end event

type cb_2 from commandbutton within w_stampa_partite_agenti
int X=3321
int Y=45
int Width=249
int Height=93
int TabOrder=30
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

type cb_1 from commandbutton within w_stampa_partite_agenti
int X=3021
int Y=45
int Width=249
int Height=93
int TabOrder=20
string Text="Preview"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.object.datawindow.print.preview='yes'
dw_1.object.datawindow.print.preview.rulers='yes'
end event

type dw_1 from datawindow within w_stampa_partite_agenti
int X=69
int Y=186
int Width=3591
int Height=1987
int TabOrder=10
string DataObject="d_par_aperta_agenti_gl"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

