forward
global type w_stampa_libro_giornale1_rpt_laser from w_stampa_libro_giornale1_rpt
end type
end forward

global type w_stampa_libro_giornale1_rpt_laser from w_stampa_libro_giornale1_rpt
end type
global w_stampa_libro_giornale1_rpt_laser w_stampa_libro_giornale1_rpt_laser

on w_stampa_libro_giornale1_rpt_laser.create
call super::create
end on

on w_stampa_libro_giornale1_rpt_laser.destroy
call super::destroy
end on

type cb_annulla from w_stampa_libro_giornale1_rpt`cb_annulla within w_stampa_libro_giornale1_rpt_laser
end type

type dw_1 from w_stampa_libro_giornale1_rpt`dw_1 within w_stampa_libro_giornale1_rpt_laser
end type

type st_1 from w_stampa_libro_giornale1_rpt`st_1 within w_stampa_libro_giornale1_rpt_laser
end type

type cb_1 from w_stampa_libro_giornale1_rpt`cb_1 within w_stampa_libro_giornale1_rpt_laser
end type

event cb_1::clicked;
open(w_attesa)

string ls_ela_def, flag_sbil
ls_ela_def=dw_1.getitemstring(1,"ela_def")


long ll_id_reg_pd, ll_id_mov_contabile, ll_id_esercizio, ll_max_mov_contabile
string ls_num_doc, ls_descrizione, ls_codice_conto, ls_descrizione_conto 
decimal ld_dare, ld_avere
date ld_ult_data, ld_fino_data, ld_data_registrazione, ld_data_doc, ld_da_data

ld_ult_data=dw_1.getitemdate(1,"ult_data")
ld_fino_data=dw_1.getitemdate(1,"fino_data")
ld_da_data=dw_1.getitemdate(1,"da_data")

IF isnull(ld_ult_data) THEN
		if isnull(ld_da_data) then
	   	ld_ult_data=date('01/01/1901')
		else
	   	ld_ult_data=ld_da_data
		end if
END IF

DECLARE vista_libro_cur CURSOR FOR  
SELECT "ws_libro_giornale"."id_reg_pd",  
      "ws_libro_giornale"."id_mov_contabile", 
      "ws_libro_giornale"."data_registrazione",   
		"ws_libro_giornale"."num_documento",   
		"ws_libro_giornale"."data_documento",   
		"ws_libro_giornale"."descrizione",   
		"ws_libro_giornale"."codice",   
		"ws_libro_giornale"."descrizione_a",   
		"ws_libro_giornale"."dare",   
		"ws_libro_giornale"."avere"  
 FROM "ws_libro_giornale"  
WHERE ( "ws_libro_giornale"."data_registrazione" > :ld_ult_data ) AND  
		( "ws_libro_giornale"."data_registrazione" <= :ld_fino_data )   
USING SQLCA;

OPEN vista_libro_cur;

FETCH vista_libro_cur INTO :ll_id_reg_pd, 
									:ll_id_mov_contabile,
                           :ld_data_registrazione,   
									:ls_num_doc,   
									:ld_data_doc,   
									:ls_descrizione,   
									:ls_codice_conto,   
									:ls_descrizione_conto,   
									:ld_dare,   
									:ld_avere;  

DO WHILE SQLCA.SQLCODE=0  
	
	IF SQLCA.SQLCODE=0 THEN
		
		  INSERT INTO "libro_giornale"  
         ( "id_reg_pd", 
			  "id_mov_contabile",
			  "data_registrazione",   
           "num_documento",   
           "data_documento",   
           "descrizione",   
           "codice",   
           "descrizione_a",   
           "dare",   
           "avere" )  
  VALUES ( :ll_id_reg_pd,
           :ll_id_mov_contabile,
           :ld_data_registrazione,   
           :ls_num_doc,   
           :ld_data_doc,   
           :ls_descrizione,   
           :ls_codice_conto,   
           :ls_descrizione_conto,   
           :ld_dare,   
           :ld_avere )  ;
		
      IF ls_ela_def="S" THEN 
		   UPDATE ws_libro_giornale
			  	SET st_stampa_bollato = 'I',
				    st_stampa_bollato_a = 'I'
			 WHERE id_reg_pd=:ll_id_reg_pd and
					 id_mov_contabile=:ll_id_mov_contabile;
	   END IF		 

   END IF
	
   
	FETCH vista_libro_cur INTO :ll_id_reg_pd,  
										:ll_id_mov_contabile,
	                         	:ld_data_registrazione,   
										:ls_num_doc,   
										:ld_data_doc,   
										:ls_descrizione,   
										:ls_codice_conto,   
										:ls_descrizione_conto,   
										:ld_dare,   
   									:ld_avere; 
	
LOOP
CLOSE vista_libro_cur;




long ll_id_reg_pd1, ll_progressivo, ll_id_mov_contabile1, flag
decimal ld_saldo_riga, ld_saldo_scritt, ld_saldo_dare, ld_saldo_avere

ld_saldo_scritt=0
ld_saldo_dare=0
ld_saldo_avere=0

DECLARE libro_cur CURSOR FOR  
SELECT "libro_giornale"."id_reg_pd",  
       "libro_giornale"."id_mov_contabile",  
       "libro_giornale"."dare",
		 "libro_giornale"."avere"  
  FROM "libro_giornale"  
ORDER BY "libro_giornale"."data_registrazione",
         "libro_giornale"."id_reg_pd",
			"libro_giornale"."id_mov_contabile"
 USING SQLCA;

OPEN libro_cur;

FETCH libro_cur INTO :ll_id_reg_pd,:ll_id_mov_contabile,:ld_dare, :ld_avere;  


decimal tot_dare,tot_avere
string ls_sbil
select sum(dare),sum(avere)
  into :tot_dare,:tot_avere
  from libro_giornale
 where id_reg_pd=:ll_id_reg_pd;
if tot_dare<>tot_avere then
	UPDATE libro_giornale
		SET fl_sbil=:ls_sbil
	WHERE  id_reg_pd=:ll_id_reg_pd;
end if

ll_id_reg_pd1=ll_id_reg_pd
ll_id_mov_contabile1=ll_id_mov_contabile

ll_id_esercizio=dw_1.getitemnumber(1,"id_esercizio")

SELECT num_progressivo
  INTO :ll_progressivo
  FROM esercizio
 WHERE id_esercizio=:ll_id_esercizio;
 
IF ISNULL(ll_progressivo) THEN
   ll_progressivo=0
END IF

ll_progressivo=ll_progressivo+1

UPDATE libro_giornale
   SET num_prog=:ll_progressivo
 WHERE id_mov_contabile=:ll_id_mov_contabile;
flag=1

DO WHILE SQLCA.SQLCODE=0  
	
	IF SQLCA.SQLCODE=0 THEN 
	   
		
		tot_dare=0
		tot_avere=0
		setnull(ls_sbil)
		select sum(dare),sum(avere)
		  into :tot_dare,:tot_avere
		  from libro_giornale
		 where id_reg_pd=:ll_id_reg_pd1;
       if tot_dare<>tot_avere then 
			ls_sbil="S" 
		   flag_sbil="S" 
		end if
      
		if not isnull(ld_dare) then
	      ld_saldo_dare=ld_saldo_dare+ld_dare
		end if
		if not isnull(ld_avere) then
		   ld_saldo_avere=ld_saldo_avere+ld_avere
      end if

	   
		if ll_id_reg_pd=ll_id_reg_pd1 then
			
			if not isnull(ld_dare) then
				ld_saldo_scritt=ld_saldo_scritt+ld_dare
			end if
			
			
			if flag=1 then
						UPDATE libro_giornale
			         SET saldo_dare=:ld_saldo_dare,
							 saldo_avere=:ld_saldo_avere,
							 num_prog=:ll_progressivo,
							 fl_sbil=:ls_sbil
					 WHERE id_mov_contabile=:ll_id_mov_contabile;
					 flag=0
			      else
						flag=0
			         UPDATE libro_giornale
			         SET saldo_dare=:ld_saldo_dare,
							 saldo_avere=:ld_saldo_avere,
							 num_prog=:ll_progressivo,
							 descrizione= null,
							 data_documento= null,
							 fl_sbil=:ls_sbil
					 WHERE id_mov_contabile=:ll_id_mov_contabile;
			end if
		end if
		
		
		IF ll_id_reg_pd<>ll_id_reg_pd1 THEN
			
			
			ll_progressivo=ll_progressivo+1
			UPDATE libro_giornale
            SET num_prog=:ll_progressivo,
				    saldo_dare=:ld_saldo_dare,
					 saldo_avere=:ld_saldo_avere,
					 fl_sbil=:ls_sbil
			 WHERE id_mov_contabile=:ll_id_mov_contabile;
			 
			
			
			UPDATE libro_giornale
            SET saldo_riga=:ld_saldo_scritt,
				    fl_sbil=:ls_sbil
			 WHERE id_mov_contabile=:ll_id_mov_contabile1;
			 
			
			ll_id_reg_pd1=ll_id_reg_pd
			ll_id_mov_contabile1=ll_id_mov_contabile
			if not isnull(ld_dare) then
			   ld_saldo_scritt=ld_dare
			     else
					 ld_saldo_scritt=0
			end if
			
     END IF
              
   END IF
	
   
	FETCH libro_cur INTO :ll_id_reg_pd,:ll_id_mov_contabile, :ld_dare, :ld_avere;  
   setnull(ls_sbil)
	
LOOP
UPDATE libro_giornale
  SET saldo_riga=:ld_saldo_scritt,
      fl_sbil=:ls_sbil
WHERE id_mov_contabile=:ll_id_mov_contabile1;
CLOSE libro_cur;


long tot_righe, i, ll_reg_pd, ll_num_prog
	decimal ld_max_dare, ld_max_avere
	date ld_data_reg
select count (id_reg_pd)
	into :tot_righe 
	from libro_giornale;

if flag_sbil<>"S" then
		
	
	select max (id_reg_pd)
	into :ll_reg_pd
	from libro_giornale;
	
	select max (num_prog)
	into :ll_num_prog
	from libro_giornale;
	
	
	select max (data_registrazione)
	into :ld_data_reg
	from libro_giornale;
	
	select max (saldo_dare)
	into :ld_max_dare
	from libro_giornale;
	
	select max (saldo_avere)
	into :ld_max_avere
	from libro_giornale;
	
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
		  else
			close(w_attesa)
			messagebox("Information!","Non ci sono scritture da stampare!",Information!)
	
			this.triggerEvent(open!)
	end if
end if

ls_ela_def=dw_1.getitemstring(1,"ela_def") 

if tot_righe>0 and flag_sbil<>'S' then
	OpenWithParm(w_stampa_libro_giornale2_rpt,ls_ela_def)
end if

integer rispo_sbil
if tot_righe>0 and flag_sbil='S' then
	close(w_attesa)
	rispo_sbil=messagebox("Controllo","Attenzione,~nci sono delle Scritture Sbilanciate.~nVuoi Stampare solo le Scritture Sbilanciate?",question!,yesno!)
	if rispo_sbil=1 then
		open(w_attesa)
	   Open(w_stampa_libro_giornale2_sbil) 
	     else
			  open(w_attesa)
           Open(w_stampa_libro_giornale2_completa2)
   end if                                         
end if
integer li_rispo

IF ls_ela_def = 'S' THEN  
if tot_righe>0 and flag_sbil<>'S' then 
	li_rispo=messagebox("Conferma Stampa","La Stampa è andata a buon fine?",question!,yesno!)
	
	if li_rispo=1  then 
		
   	if ls_ela_def='S' then  
			uf_conferma_stampa()
			close(w_attesa)
			close(parent)
				else  
				  
				  open(w_attesa)
				  delete from libro_giornale;
				  close(w_attesa)
				  close(parent)
		end if
	  else 
		close(parent)
		s_st_param ls_st_param
		ls_st_param.id_esercizio=ll_id_esercizio
		ls_st_param.fino_data=ld_fino_data
		ls_st_param.ela_def=ls_ela_def
		if ls_ela_def = 'S' then
			openWithParm(w_st_ripristino_lib_gio_rpt,ls_st_param)
		end if
   end if 
end if 
END IF 
if tot_righe>0 and ls_ela_def='S' and flag_sbil='S' then
	
	open(w_attesa)
   update ws_libro_giornale
	   set st_stampa_bollato='N',
		    st_stampa_bollato_a='N'
	 where st_stampa_bollato='I' and
		    st_stampa_bollato_a='I';
	close(w_attesa)
end if
end event

type cb_stampa from w_stampa_libro_giornale1_rpt`cb_stampa within w_stampa_libro_giornale1_rpt_laser
end type

