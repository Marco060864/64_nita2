forward
global type w_risconti_lt from w_np_single_data
end type
type cb_1 from commandbutton within w_risconti_lt
end type
type cb_3 from commandbutton within w_risconti_lt
end type
type cb_4 from commandbutton within w_risconti_lt
end type
end forward

global type w_risconti_lt from w_np_single_data
int X=590
int Y=829
int Width=3086
int Height=1049
boolean TitleBar=true
string Title="Lista Risconti"
cb_1 cb_1
cb_3 cb_3
cb_4 cb_4
end type
global w_risconti_lt w_risconti_lt

on w_risconti_lt.create
int iCurrent
call w_np_single_data::create
this.cb_1=create cb_1
this.cb_3=create cb_3
this.cb_4=create cb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=cb_1
this.Control[iCurrent+2]=cb_3
this.Control[iCurrent+3]=cb_4
end on

on w_risconti_lt.destroy
call w_np_single_data::destroy
destroy(this.cb_1)
destroy(this.cb_3)
destroy(this.cb_4)
end on

event resize;
end event

event ue_insert;
end event

type p_crescente from w_np_single_data`p_crescente within w_risconti_lt
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_risconti_lt
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_risconti_lt
int Y=49
int Width=2967
int TabOrder=10
string DataObject="d_ges_rat_risc_lt"
end type

event dw_single::doubleclicked;call super::doubleclicked;long ll_riga, ll_num

ll_riga = dw_single.getrow()
ll_num = dw_single.getitemnumber (ll_riga, 'num_progressivo')

messagebox ('recupera', ll_num)

end event

event dw_single::ue_insert;
end event

event dw_single::itemchanged;call super::itemchanged;

long ll_riga, ll_rif_scrittura
decimal ld_flag_rat_ris

IF dwo.name="flag_rat_ris" THEN
        ll_riga=this.getrow()
        this.setitem(ll_riga,"quota_bloc",'S')
		  ll_rif_scrittura=this.getitemnumber(ll_riga,"rif_scrittura")
		  ld_flag_rat_ris=dec(data)
		  messagebox("ll_rif_scrittura",ll_rif_scrittura)
		  UPDATE ges_ratei_risconti
		     SET quota_bloc='S',
			      flag_rat_ris=:ld_flag_rat_ris
			WHERE rif_scrittura=:ll_rif_scrittura;
			this.retrieve()
			this.ScrollToRow (ll_riga) 
END IF


end event

type cb_1 from commandbutton within w_risconti_lt
int X=65
int Y=773
int Width=503
int Height=97
int TabOrder=20
boolean BringToTop=true
string Text="Calcola Risconti"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

long ll_rif_scrittura
decimal ld_importo_doc, ld_giorni1, ld_giorni2, ld_risconto
date ld_data_in_comp, ld_data_fin_comp, ld_data_mezzo


 DECLARE ratei_risconti_cur CURSOR FOR  
  SELECT "ges_ratei_risconti"."rif_scrittura",   
         "ges_ratei_risconti"."importo_doc",   
         "ges_ratei_risconti"."data_in_comp",   
         "ges_ratei_risconti"."data_fin_comp"  
    FROM "ges_ratei_risconti"  
   WHERE "ges_ratei_risconti"."quota_bloc" = 'N' AND
	      "ges_ratei_risconti"."tipo_record" = 'S';

OPEN ratei_risconti_cur;

FETCH ratei_risconti_cur INTO :ll_rif_scrittura,:ld_importo_doc,:ld_data_in_comp, :ld_data_fin_comp;

DO WHILE SQLCA.SQLCODE=0 
	
	ld_giorni1=DaysAfter(ld_data_in_comp,ld_data_fin_comp)
		
	
   ld_data_mezzo=date("31/12/"+string(integer(year(ld_data_fin_comp))- 1))
	ld_giorni2=DaysAfter(ld_data_mezzo,ld_data_fin_comp)
	
	
	ld_risconto=ld_importo_doc*ld_giorni2/ld_giorni1
	
	
	 UPDATE "ges_ratei_risconti"  
       SET "flag_rat_ris" = :ld_risconto  
     WHERE "ges_ratei_risconti"."rif_scrittura" = :ll_rif_scrittura   ;

	
   FETCH ratei_risconti_cur INTO :ll_rif_scrittura,:ld_importo_doc,:ld_data_in_comp, :ld_data_fin_comp;
LOOP

CLOSE ratei_risconti_cur;
dw_single.retrieve()


end event

type cb_3 from commandbutton within w_risconti_lt
int X=1921
int Y=773
int Width=503
int Height=97
int TabOrder=40
boolean BringToTop=true
string Text="Genera Scritture "
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;


OpenWithParm(w_risconto_ff,"Risconto")

dw_single.retrieve()
end event

type cb_4 from commandbutton within w_risconti_lt
int X=2510
int Y=773
int Width=503
int Height=97
int TabOrder=30
boolean BringToTop=true
string Text="Genera Storno"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;


OpenWithParm(w_risconto_ff,"Storno")

dw_single.retrieve()
end event

