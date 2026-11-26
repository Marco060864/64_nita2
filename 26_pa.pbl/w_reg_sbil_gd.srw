forward
global type w_reg_sbil_gd from Window
end type
type cb_2 from commandbutton within w_reg_sbil_gd
end type
type dw_1 from datawindow within w_reg_sbil_gd
end type
type cb_1 from commandbutton within w_reg_sbil_gd
end type
end forward

global type w_reg_sbil_gd from Window
int X=1056
int Y=484
int Width=2569
int Height=1516
boolean TitleBar=true
string Title="Untitled"
long BackColor=67108864
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
cb_2 cb_2
dw_1 dw_1
cb_1 cb_1
end type
global w_reg_sbil_gd w_reg_sbil_gd

on w_reg_sbil_gd.create
this.cb_2=create cb_2
this.dw_1=create dw_1
this.cb_1=create cb_1
this.Control[]={this.cb_2,&
this.dw_1,&
this.cb_1}
end on

on w_reg_sbil_gd.destroy
destroy(this.cb_2)
destroy(this.dw_1)
destroy(this.cb_1)
end on

event open;dw_1.settransobject(sqlca)
dw_1.retrieve()
end event

type cb_2 from commandbutton within w_reg_sbil_gd
int X=27
int Y=20
int Width=270
int Height=108
int TabOrder=20
string Text="Annulla"
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(parent)
end event

type dw_1 from datawindow within w_reg_sbil_gd
int X=23
int Y=248
int Width=2478
int Height=1120
int TabOrder=20
string DataObject="d_reg_sbil_gd"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean HSplitScroll=true
boolean LiveScroll=true
end type

type cb_1 from commandbutton within w_reg_sbil_gd
int X=1938
int Y=28
int Width=567
int Height=180
int TabOrder=10
string Text="ELABORA"
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_row, ll_val_lire, i, ll_segno, ll_conto
long ll_reg_pd, ll_id_iva, ll_id_mc, ll_reg_pd_ante
decimal ld_avere, ld_dare, ld_tot_reg,ld_tot_iva
STRING LS_TIPO
LL_ROW=dw_1.rowcount()
select id_val_lire into :LL_VAL_LIRE
from par_sistema;  

ll_reg_pd_ante=0

messagebox('ATTENZIONE!',"ASSICURARSI CHE NESSUN UTENTE STIA LAVORANDO DURANTE L'ELABORAZIONE")

FOR I=1 TO LL_ROW

    LL_REG_PD=dw_1.getitemnumber(i,'id_reg_pd')
	 
	 if ll_reg_pd<>ll_reg_pd_ante then
		
		 SELECT r.tipo_registro into :ls_tipo
	 	 from registro r, reg_pd pd
	 	 where r.id_registro=pd.id_registro
	 	 and pd.id_reg_pd=:LL_REG_PD;
	 
	    IF LS_TIPO='PN' THEN
 			 
			 
			 update mov_contabile set avere= ROUND(avere,0) , dare=ROUND(dare,0)
  			 where id_reg_pd=:LL_REG_PD;
				 
		 ELSE
			
  	   	 
 	    	 if dw_1.getitemnumber(i,'id_valuta')=ll_val_lire then
			    update reg_pd set importo=round(importo,0) , imp_valuta=round(imp_valuta,0)
				 where id_reg_pd=:LL_REG_PD;
			 else	  	 
  			    update reg_pd set importo=round(importo,0)
				 where id_reg_pd=:LL_REG_PD;
	   	 end if
			 update mov_iva set imponibile=round(imponibile,0) , imposta=round(imposta,0)
			 where id_reg_pd=:LL_REG_PD;
 			 update mov_contabile set avere=round(avere,0) , dare=round(dare,0)
			 where id_reg_pd=:LL_REG_PD;
	 
			 
			 select importo, segno_reg_iva, id_conto into :ld_tot_reg, :ll_segno, :ll_conto
			 from reg_pd where id_reg_pd=:LL_REG_PD;
	 	  	 select (sum(imponibile) + sum(imposta)) into :ld_tot_iva
			 from mov_iva where id_reg_pd=:LL_REG_PD;
			 if (ld_tot_reg - ld_tot_iva) <>0 then
		          select min(id_mov_iva) into :ll_id_iva
					 from mov_iva where id_reg_pd=:LL_REG_PD;
					 update mov_iva set imponibile=( imponibile + (:ld_tot_reg - :ld_tot_iva) )
            	 where id_mov_iva=:LL_ID_IVA;
			 end if
		
			 
	  	 	 select sum(avere), sum(dare) into :ld_avere, :ld_dare
			 from mov_contabile where id_reg_pd=:LL_REG_PD;
			 if (ld_dare - ld_avere) <>0 then
				 if ll_segno = 1 then 
				    select max(id_mov_contabile) into :ll_id_mc
					 from mov_contabile where id_reg_pd=:LL_REG_PD and numero<>9999 and (dare=0 or  dare is null);
					 update mov_contabile set avere=( avere + (:ld_dare - :ld_avere))
  			       where id_mov_contabile=:LL_ID_MC;
				 else			 	
					 select max(id_mov_contabile) into :ll_id_mc
					 from mov_contabile where id_reg_pd=:LL_REG_PD and numero<>9999 and (avere=0 or  avere is null);  
					 update mov_contabile set dare=( dare + (:ld_dare - :ld_avere))
  		 	       where id_mov_contabile=:LL_ID_MC;
				end if	 
			 end if
		 END IF	 	 
	 end if
	 ll_reg_pd_ante=ll_reg_pd
NEXT		

messagebox('INFORMATION!','OPERAZIONE CONCLUSA')

end event

