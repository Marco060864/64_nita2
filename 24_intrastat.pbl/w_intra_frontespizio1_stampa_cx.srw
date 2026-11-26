forward
global type w_intra_frontespizio1_stampa_cx from w_p_data
end type
type dw_intra_fronte1_stampa from u_dw_master_main within tabpage_1
end type
type dw_intra_fronte1_stampa from u_dw_master_main within tabpage_1
end type
type tabpage_2 from userobject within tab_1
end type
type dw_intra_riep1_acq_ff from u_dw_master_main within tabpage_2
end type
type dw_intra_2bis_dogana from u_dw_master_main within tabpage_2
end type
type st_1 from statictext within tabpage_2
end type
type tabpage_3 from userobject within tab_1
end type
type dw_intra_riep2_acq_ff from u_dw_master_main within tabpage_3
end type
type st_2 from statictext within tabpage_3
end type
type dw_intra_2ter_dogana from u_dw_master_main within tabpage_3
end type
type cb_acq from commandbutton within w_intra_frontespizio1_stampa_cx
end type
type cb_ascii from commandbutton within w_intra_frontespizio1_stampa_cx
end type
type cb_1 from commandbutton within w_intra_frontespizio1_stampa_cx
end type
type p_1 from picture within w_intra_frontespizio1_stampa_cx
end type
type tabpage_2 from userobject within tab_1
dw_intra_riep1_acq_ff dw_intra_riep1_acq_ff
dw_intra_2bis_dogana dw_intra_2bis_dogana
st_1 st_1
end type
type tabpage_3 from userobject within tab_1
dw_intra_riep2_acq_ff dw_intra_riep2_acq_ff
st_2 st_2
dw_intra_2ter_dogana dw_intra_2ter_dogana
end type
end forward

global type w_intra_frontespizio1_stampa_cx from w_p_data
int X=626
int Y=312
int Width=2725
int Height=1576
boolean TitleBar=true
string Title="Stampa Intra Frontespizio Acquisizioni"
cb_acq cb_acq
cb_ascii cb_ascii
cb_1 cb_1
p_1 p_1
end type
global w_intra_frontespizio1_stampa_cx w_intra_frontespizio1_stampa_cx

on w_intra_frontespizio1_stampa_cx.create
int iCurrent
call super::create
this.cb_acq=create cb_acq
this.cb_ascii=create cb_ascii
this.cb_1=create cb_1
this.p_1=create p_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_acq
this.Control[iCurrent+2]=this.cb_ascii
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.p_1
end on

on w_intra_frontespizio1_stampa_cx.destroy
call super::destroy
destroy(this.cb_acq)
destroy(this.cb_ascii)
destroy(this.cb_1)
destroy(this.p_1)
end on

event open;call super::open;idw_master = tab_1.tabpage_1.dw_intra_fronte1_stampa
idw_master.is_list = Message.PowerObjectParm

IF UpperBound(idw_master.is_list.s_identifica) = 0 THEN
	ib_NonModale = TRUE
	idw_master.is_list.s_modo = modo_inserisci
	idw_master.ias_key_name[1] = "id_i_fronte"
END IF
DELETE FROM "intra_2bis_dogana"  ;
DELETE FROM "intra_ter_dogana"  ;
DELETE FROM "intra_frontespizio_output"  ;

il_HelpTopic = 73
end event

event ue_post_open;call super::ue_post_open;cb_nuovo.visible=false
end event

type p_crescente from w_p_data`p_crescente within w_intra_frontespizio1_stampa_cx
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_intra_frontespizio1_stampa_cx
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_intra_frontespizio1_stampa_cx
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_intra_frontespizio1_stampa_cx
int X=334
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_intra_frontespizio1_stampa_cx
boolean Visible=false
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_intra_frontespizio1_stampa_cx
boolean Visible=false
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_intra_frontespizio1_stampa_cx
int Y=44
boolean Visible=false
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_intra_frontespizio1_stampa_cx
int X=1285
boolean BringToTop=true
end type

event cb_salva::clicked;call super::clicked;
long ll_id_fronte, ll_totrows, ll_row
integer i
string prog_riga, cod_stato, iva_operatore, ammontare, cod_nat_transaz, massa_netta, unita_supp
string val_statistico, cond_consegna, modo_trasporto, paese_dest, prov_dest, intra, iva, num_prog_ele, tipo_rec
string cod_nomenclatura, mese_rif, trim_rif, anno_rif, stato_operatore, segno, natura_trans
string val_stat, nomenclatura, amm_val, paese_origine, prov_origine, amm_valuta

ll_id_fronte = tab_1.tabpage_1.dw_intra_fronte1_stampa.getitemnumber(1,"id_i_fronte")

DELETE FROM intra_2bis_dog WHERE id_i_fronte = :ll_id_fronte;

ll_totrows = tab_1.tabpage_2.dw_intra_2bis_dogana.rowcount()
for i=1 to ll_totrows
  prog_riga = string(tab_1.tabpage_2.dw_intra_2bis_dogana.getitemnumber(i,"prog_riga"))
  cod_stato = tab_1.tabpage_2.dw_intra_2bis_dogana.getitemstring(i,"cod_stato")  
  iva_operatore = tab_1.tabpage_2.dw_intra_2bis_dogana.getitemstring(i,"iva_operatore")  
  ammontare = string(tab_1.tabpage_2.dw_intra_2bis_dogana.getitemnumber(i,"ammontare"))  
  cod_nat_transaz = string(tab_1.tabpage_2.dw_intra_2bis_dogana.getitemnumber(i,"cod_nat_transaz"))  
  massa_netta = string(tab_1.tabpage_2.dw_intra_2bis_dogana.getitemnumber(i,"massa_netta"))
  unita_supp = string(tab_1.tabpage_2.dw_intra_2bis_dogana.getitemnumber(i,"unita_supp"))
  val_statistico = string(tab_1.tabpage_2.dw_intra_2bis_dogana.getitemnumber(i,"val_statistico"))  
  cond_consegna = tab_1.tabpage_2.dw_intra_2bis_dogana.getitemstring(i,"cond_consegna")  
  modo_trasporto = string(tab_1.tabpage_2.dw_intra_2bis_dogana.getitemnumber(i,"modo_trasporto"))  
  paese_dest = tab_1.tabpage_2.dw_intra_2bis_dogana.getitemstring(i,"paese_dest")  
  intra = tab_1.tabpage_2.dw_intra_2bis_dogana.getitemstring(i,"intra")
  iva = string(tab_1.tabpage_2.dw_intra_2bis_dogana.getitemnumber(i,"iva"))  
  num_prog_ele = string(tab_1.tabpage_2.dw_intra_2bis_dogana.getitemnumber(i,"num_prog_ele"))  
  tipo_rec = string(tab_1.tabpage_2.dw_intra_2bis_dogana.getitemnumber(i,"tipo_rec"))  
  cod_nomenclatura = tab_1.tabpage_2.dw_intra_2bis_dogana.getitemstring(i,"cod_nomenclatura")  
  amm_val = string(tab_1.tabpage_2.dw_intra_2bis_dogana.getitemnumber(i,"amm_val"))    
  paese_origine = tab_1.tabpage_2.dw_intra_2bis_dogana.getitemstring(i,"paese_origine")  
  prov_origine = tab_1.tabpage_2.dw_intra_2bis_dogana.getitemstring(i,"prov_origine")  
  
  INSERT INTO intra_2bis_dog (id_i_fronte, prog_riga, cod_stato, iva_operatore, ammontare, cod_nat_transaz, massa_netta,
              unita_supp, val_statistico, cond_consegna, modo_trasporto, paese_dest, intra, iva, num_prog_ele,
				  tipo_rec, cod_nomenclatura, amm_val, paese_origine, prov_origine)
  VALUES (:ll_id_fronte, :prog_riga, :cod_stato, :iva_operatore, :ammontare, :cod_nat_transaz, :massa_netta, :unita_supp,
          :val_statistico, :cond_consegna, :modo_trasporto, :paese_dest, :intra, :iva, :num_prog_ele,
			 :tipo_rec, :cod_nomenclatura, :amm_val, :paese_origine, :prov_origine) ; 
  
next


DELETE FROM intra_ter_dog WHERE id_i_fronte = :ll_id_fronte;

ll_totrows = tab_1.tabpage_3.dw_intra_2ter_dogana.rowcount()
for i=1 to ll_totrows
   prog_riga = tab_1.tabpage_3.dw_intra_2ter_dogana.getitemstring(i,"prog_riga")
   mese_rif = tab_1.tabpage_3.dw_intra_2ter_dogana.getitemstring(i,"mese_rif")
   trim_rif = tab_1.tabpage_3.dw_intra_2ter_dogana.getitemstring(i,"trim_rif")
   anno_rif = tab_1.tabpage_3.dw_intra_2ter_dogana.getitemstring(i,"anno_rif")	
   stato_operatore = tab_1.tabpage_3.dw_intra_2ter_dogana.getitemstring(i,"stato_operatore")	
   iva_operatore = tab_1.tabpage_3.dw_intra_2ter_dogana.getitemstring(i,"iva_operatore")
   segno = tab_1.tabpage_3.dw_intra_2ter_dogana.getitemstring(i,"segno")
   ammontare = tab_1.tabpage_3.dw_intra_2ter_dogana.getitemstring(i,"ammontare")
   natura_trans = tab_1.tabpage_3.dw_intra_2ter_dogana.getitemstring(i,"natura_trans")	
   val_stat = tab_1.tabpage_3.dw_intra_2ter_dogana.getitemstring(i,"val_stat")	
   tipo_rec = tab_1.tabpage_3.dw_intra_2ter_dogana.getitemstring(i,"tipo_rec")
   num_prog_ele = tab_1.tabpage_3.dw_intra_2ter_dogana.getitemstring(i,"num_prog_ele")
   iva = tab_1.tabpage_3.dw_intra_2ter_dogana.getitemstring(i,"iva")
   intra = tab_1.tabpage_3.dw_intra_2ter_dogana.getitemstring(i,"intra")	
   nomenclatura = tab_1.tabpage_3.dw_intra_2ter_dogana.getitemstring(i,"nomenclatura")		
	amm_valuta = tab_1.tabpage_3.dw_intra_2ter_dogana.getitemstring(i,"amm_valuta")	
	
  INSERT INTO intra_ter_dog (id_i_fronte, prog_riga, mese_rif, trim_rif, anno_rif, stato_operatore, iva_operatore,
              segno, ammontare, natura_trans, val_stat, tipo_rec, num_prog_ele, iva, intra, nomenclatura, amm_valuta)
  VALUES (:ll_id_fronte, :prog_riga, :mese_rif, :trim_rif, :anno_rif, :stato_operatore, :iva_operatore, :segno,
          :ammontare, :natura_trans, :val_stat, :tipo_rec, :num_prog_ele, :iva, :intra, :nomenclatura, :amm_valuta) ; 	
next

end event

type tab_1 from w_p_data`tab_1 within w_intra_frontespizio1_stampa_cx
int Y=172
int Width=2624
int Height=1296
int TabOrder=10
boolean BringToTop=true
long BackColor=79741120
int Weight=700
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type

on tab_1.create
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_2
this.Control[iCurrent+2]=this.tabpage_3
end on

on tab_1.destroy
call super::destroy
destroy(this.tabpage_2)
destroy(this.tabpage_3)
end on

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=18
int Y=104
int Width=2587
int Height=1176
long BackColor=79741120
string Text="Frontespizio"
long TabBackColor=79741120
long TabTextColor=255
long PictureMaskColor=553648127
dw_intra_fronte1_stampa dw_intra_fronte1_stampa
end type

on tabpage_1.create
this.dw_intra_fronte1_stampa=create dw_intra_fronte1_stampa
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_intra_fronte1_stampa
end on

on tabpage_1.destroy
call super::destroy
destroy(this.dw_intra_fronte1_stampa)
end on

type cb_ricerca from w_p_data`cb_ricerca within w_intra_frontespizio1_stampa_cx
int X=626
boolean BringToTop=true
end type

event cb_ricerca::clicked;w_search_main		lw_sm
long					ll_i_fronte, ll_row, ll_ret, ll_ret2
dec ld_appimp
s_ric_param			ls_ricpar

idw_master.is_ricpar.s_filter_name = "denominazione"
idw_master.is_ricpar.s_filter_value=""
idw_master.is_ricpar.s_sql_cond="riepilogo='A'"
OpenWithParm (lw_sm, idw_master.is_ricpar, "w_intra_frontespizio_sw")
idw_master.is_ricpar = Message.PowerObjectParm

IF UpperBound(idw_master.is_ricpar.s_id_seg_value) > 0 THEN
	ll_i_fronte = long(idw_master.is_ricpar.s_id_seg_value[1])
	idw_master.is_list.s_modo = modo_modifica
	idw_master.is_list.s_identifica[1] = "id_i_fronte"
	idw_master.is_list.l_identifica[1] = ll_i_fronte
	idw_master.Event ue_retrieve(0, 0)
	idw_master.SetFocus()
	DELETE FROM  INTRA_2BIS_DOGANA;
	DELETE FROM  INTRA_TER_DOGANA;
	DELETE FROM  INTRA_FRONTESPIZIO_OUTPUT;
	commit; 
end if


string prog_riga, cod_stato, iva_operatore, ammontare2, cod_nat_transaz, massa_netta, unita_supp
string val_statistico, cond_consegna, modo_trasporto, paese_dest, prov_dest, intra, iva2, num_prog_ele, tipo_rec
string cod_nomenclatura, mese_rif, trim_rif, anno_rif, stato_operatore, segno2, natura_trans
string val_stat2, nomenclatura, amm_val, paese_origine, prov_origine, amm_valuta2

declare intra2bis cursor for

select prog_riga, cod_stato, iva_operatore, ammontare, cod_nat_transaz, massa_netta, unita_supp, val_statistico, 
       cond_consegna, modo_trasporto, paese_dest, intra, iva, num_prog_ele, tipo_rec,
       cod_nomenclatura, amm_val, paese_origine, prov_origine
from intra_2bis_dog
where id_i_fronte = :ll_i_fronte;

open intra2bis;

fetch next intra2bis 
into :prog_riga, :cod_stato, :iva_operatore, :ammontare2, :cod_nat_transaz, :massa_netta, :unita_supp, :val_statistico, 
     :cond_consegna, :modo_trasporto, :paese_dest, :intra, :iva2, :num_prog_ele, :tipo_rec,
     :cod_nomenclatura, :amm_val, :paese_origine, :prov_origine;

do while sqlca.sqlcode = 0
	
  INSERT INTO INTRA_2BIS_DOGANA (prog_riga, cod_stato, iva_operatore, ammontare, cod_nat_transaz, massa_netta,
              unita_supp, val_statistico, cond_consegna, modo_trasporto, paese_dest, intra, iva, num_prog_ele,
				  tipo_rec, cod_nomenclatura, amm_val, paese_origine, prov_origine)
  VALUES (:prog_riga, :cod_stato, :iva_operatore, :ammontare2, :cod_nat_transaz, :massa_netta, :unita_supp,
          :val_statistico, :cond_consegna, :modo_trasporto, :paese_dest, :intra, :iva2, :num_prog_ele,
			 :tipo_rec, :cod_nomenclatura, :amm_val, :paese_origine, :prov_origine) ; 	

	fetch next intra2bis 
	into :prog_riga, :cod_stato, :iva_operatore, :ammontare2, :cod_nat_transaz, :massa_netta, :unita_supp, :val_statistico, 
        :cond_consegna, :modo_trasporto, :paese_dest, :intra, :iva2, :num_prog_ele, :tipo_rec,
        :cod_nomenclatura, :amm_val, :paese_origine, :prov_origine;
loop

ll_ret = tab_1.tabpage_2.dw_intra_2bis_dogana.retrieve()


declare intra2ter cursor for

select prog_riga, mese_rif, trim_rif, anno_rif, stato_operatore, iva_operatore, 
       segno, ammontare, natura_trans, val_stat, tipo_rec, num_prog_ele, iva, intra, nomenclatura, amm_valuta
from intra_ter_dog
where id_i_fronte = :ll_i_fronte;

open intra2ter;

fetch next intra2ter
into :prog_riga, :mese_rif, :trim_rif, :anno_rif, :stato_operatore, :iva_operatore, 
     :segno2, :ammontare2, :natura_trans, :val_stat2, :tipo_rec, :num_prog_ele, :iva2, :intra, :nomenclatura, :amm_valuta2;
	  
do while sqlca.sqlcode = 0
	
  INSERT INTO intra_ter_dogana (prog_riga, mese_rif, trim_rif, anno_rif, stato_operatore, iva_operatore,
              segno, ammontare, natura_trans, val_stat, tipo_rec, num_prog_ele, iva, intra, nomenclatura, amm_valuta)
  VALUES (:prog_riga, :mese_rif, :trim_rif, :anno_rif, :stato_operatore, :iva_operatore, :segno2,
          :ammontare2, :natura_trans, :val_stat2, :tipo_rec, :num_prog_ele, :iva2, :intra, :nomenclatura, :amm_valuta2) ; 	

fetch next intra2ter
into :prog_riga, :mese_rif, :trim_rif, :anno_rif, :stato_operatore, :iva_operatore, 
     :segno2, :ammontare2, :natura_trans, :val_stat2, :tipo_rec, :num_prog_ele, :iva2, :intra, :nomenclatura, :amm_valuta2;
loop

ll_ret2 = tab_1.tabpage_3.dw_intra_2ter_dogana.retrieve()

if (ll_ret+ll_ret2) > 0 then
integer li_rig, li_id,li_prog,li_prog1
long  iva_dele,valuta,a_amm_val,tot_valuta , rif_disk,   an
long tri, me, tot1, tot2, amm1
integer per, cs1, cs2, i
string riep, period, cas1, cas2,  amm2
integer  rif,  dummy, num, tipo, prog, trim, anno, mese 
double  amm, trans,  val_stat,  ammontare, natura, val, a_amm, a_val, tot_amm, tot_val
string iso2,stato, iva_oper, segno, iva_op, cod, dest, prov, cond, iva_sog
double massa, unita, modo,tot_massa, tot_unita, tot_stat, a_massa, a_unita, a_stat,IVA,amm_valuta
integer prog_rig,amm_1,amm_temp, prog_disk
string ss_segno, segno_1, segno_fin, ls_app

li_prog=0
li_prog1=0 




DELETE FROM INTRA_FRONTESPIZIO_OUTPUT;

li_rig = tab_1.tabpage_1.dw_intra_fronte1_stampa.getrow()
li_id = tab_1.tabpage_1.dw_intra_fronte1_stampa.getitemnumber (li_rig, "id_i_fronte")

if li_id>0 then
	
	

	SELECT partita_iva, rif_disk, riepilogo, anno, 
			 tipo_riepilogo, trimestre, mese, casella1,
			 casella2, iva_delegato, tot_rig_sez1, 
			 amm_compl_sez1, tot_rig_sez2, amm_compl_sez2 
	INTO :iva_sog, :rif_disk, :riep, :an, 
		  :period, :tri, :me, :cas1,
		  :cas2, :iva_dele, :tot1, 
		  :amm1, :tot2, :amm2
	FROM intra_frontespizio_input
	WHERE ID_I_FRONTE = :li_id;	
   
	

ld_appimp = dec(amm1)
if ld_appimp < 1000 then
	ld_appimp = 1
else
	ld_appimp = round(ld_appimp/1000,0)
end if
amm1 = long(ld_Appimp)

ld_appimp = abs(dec(amm2))
if ld_appimp < 1000 then
	ld_appimp = -1
else
	ld_appimp = (round(ld_appimp/1000,0)*-1)
end if
amm2 = string(ld_Appimp)


string ll_num_neg
long ll_lung
ll_lung = len(amm2)
ll_num_neg = right(amm2,1)

IF ll_num_neg = '0' THEN
 amm2 = Replace(amm2, ll_lung, 1, "p")
END IF

IF ll_num_neg = '1' THEN
	amm2 = Replace(amm2, ll_lung, 1, "q")
END IF
IF ll_num_neg = '2' THEN
	amm2 = Replace(amm2, ll_lung, 1, "r")
END IF
IF ll_num_neg = '3' THEN
	amm2 = Replace(amm2, ll_lung, 1, "s")
END IF
IF ll_num_neg = '4' THEN
	amm2 = Replace(amm2, ll_lung, 1, "t")
END IF
IF ll_num_neg = '5' THEN
	amm2 = Replace(amm2, ll_lung, 1, "u")
END IF
IF ll_num_neg = '6' THEN
	amm2 = Replace(amm2, ll_lung, 1, "v")
END IF
IF ll_num_neg = '7' THEN
	amm2 = Replace(amm2, ll_lung, 1, "w")
END IF
IF ll_num_neg = '8' THEN
 amm2 = Replace(amm2, ll_lung, 1, "x")
END IF

IF ll_num_neg = '9' THEN
	amm2 = Replace(amm2, ll_lung, 1, "y")
END IF

 amm2 = Replace(amm2, 1, 1, " ")


	
	if isnull(cas1) then cas1 = 'F'
	if isnull(cas2) then cas2 = 'F'	
	

	IF period = 'T' then
		per = tri
	else
		per = me
	end if
	IF cas1 = 'F'then
		cs1 = 0
	else
		cs1 = 1
	end if
	IF cas2 = 'F'then
		cs2 = 0
	else
		cs2 = 1
	end if
	

	select rif_disk
	into :PROG_DISK
	from intra_frontespizio_input
	WHERE ID_I_FRONTE = :li_id;
		
	if isnull(string(prog_disk)) then prog_disk = 0	
	
	
	
	update intra_frontespizio_output
		set num_prog_ele = :PROG_DISK
	using sqlca;
	
	rif_disk = prog_disk

	INSERT INTO INTRA_FRONTESPIZIO_OUTPUT (intra, IVA, num_prog_ele, tipo_rec, 
				prog_riga, tipo_riepilogo, anno_rif, periodicita, periodo, iva_contrib, casella1, 
				casella2, iva_delegato, num_det_sez1, amm_sez1, num_sez2, amm_sez2)
		VALUES ('INTRA', :iva_sog, :rif_disk, 0, 0, :riep, :an, :period, :per, :iva_sog, :cs1, 
							  :cs2, :iva_dele, :tot1, :amm1, :tot2, :amm2); 


	IF SQLCA.SQLCODE <> 0 THEN
			MESSAGEBOX ('ERRORE', 'Causato errore durante passagio dati')
	END IF	

		
	select sum (ammontare)
	into :amm_1
	from intra_2bis_dogana;
	
	
	prog_rig = ll_ret
	
	
	
	

	update intra_frontespizio_input
	 
	 set  tot_rig_sez1 = :prog_rig, tot_sez1 = 1
	 where id_i_fronte = :li_id
	 using SQLCA;
	 
	tab_1.tabpage_1.dw_intra_fronte1_stampa.Retrieve( ) 
	
	
	
	
	prog_rig = ll_ret2	
	
	
	
	
	
	amm_1=0;
	
	declare somma cursor for
	select ammontare,segno
	from intra_ter_dogana;
	
	open somma;
	
	fetch somma into :amm_temp, :ss_segno;
	
	do while SQLCA.sqlcode = 0
	
	  if ss_segno="+" then
		  amm_1 += amm_temp
	  else
		  amm_1 -= amm_temp
	  end if
	
	  fetch somma into :amm_temp, :ss_segno;
	loop
	close somma;
	
	update intra_frontespizio_input
	 
	 set  tot_rig_sez2  = :prog_rig, tot_sez2 = :prog_rig 
	 where id_i_fronte = :li_id
	 using SQLCA;
	 
	tab_1.tabpage_1.dw_intra_fronte1_stampa.retrieve()
	cb_ascii.enabled=true
	
	
	string ls_1bis,ls_1ter,ls_fronte
	string ls_path,ls_prog,ls1,ls2
	integer li_app
	boolean lb_es
	select path_stampa
	into :ls_prog
	from intra_contatore;
	lb_es=fileexists(ls_prog)
	if lb_es=false then
		getfileopenname("Apri",ls1,ls2)
		if Right(ls1,8)='isql.exe' then
			update intra_contatore set path_stampa=:ls1;
		end if
		ls_prog=ls1
	end if
	ls1=ls_prog
	select path_batch
	into :ls_path
	from intra_contatore;
	
		
	string ls_intra, ls_iva, ls_num_prog_ele, ls_tipo_rec, ls_prog_riga, ls_tipo_riepilogo, ls_anno_rif
	string ls_periodicita, ls_periodo, ls_iva_contrib, ls_casella1, ls_casella2, ls_iva_delegato
	string ls_num_det_sez1, ls_amm_sez1, ls_num_sez2, ls_amm_sez2
		  
	SELECT intra, iva, num_prog_ele, tipo_rec, Prog_riga, Tipo_riepilogo, Anno_rif, Periodicita,
      	Periodo, IVA_contrib, Casella1, Casella2, IVA_delegato, num_det_sez1,amm_sez1,num_sez2,amm_sez2
	into :ls_intra, :ls_iva, :ls_num_prog_ele, :ls_tipo_rec, :ls_prog_riga, :ls_tipo_riepilogo, :ls_anno_rif,
	     :ls_periodicita, :ls_periodo, :ls_iva_contrib, :ls_casella1, :ls_casella2, :ls_iva_delegato, 
		  :ls_num_det_sez1, :ls_amm_sez1, :ls_num_sez2, :ls_amm_sez2
	FROM INTRA_frontespizio_output; 
	
	if isnull(ls_iva) then ls_iva = ' '
	ls_iva = trim(ls_iva)
	ls_app = '00000000000' 
	ls_app = ls_app + ls_iva
	ls_iva = right(ls_app, 11)
	
	if isnull(ls_num_prog_ele) then ls_num_prog_ele = ' '
	ls_num_prog_ele = trim(ls_num_prog_ele)	
	ls_app = '000000'
	ls_app = ls_app + ls_num_prog_ele
	ls_num_prog_ele = right(ls_app, 6)
	
	if isnull(ls_prog_riga) then ls_prog_riga = ' '
	ls_prog_riga = trim(ls_prog_riga)	
	ls_app = '00000'
	ls_app = ls_app + ls_prog_riga
	ls_prog_riga = right(ls_app, 5)

	if isnull(ls_anno_rif) then ls_anno_rif = ' '
	ls_anno_rif = trim(ls_anno_rif)		
	ls_app = '00'
	ls_app = ls_app + ls_anno_rif
	ls_anno_rif = right(ls_app, 2)
	
	if isnull(ls_periodo) then ls_periodo = ' '
	ls_periodo = trim(ls_periodo)				
	ls_app = '00'
	ls_app = ls_app + ls_periodo
	ls_periodo = right(ls_app, 2)	

	if isnull(ls_iva_contrib) then ls_iva_contrib = ' '
	ls_iva_contrib = trim(ls_iva_contrib)					
	ls_app = '00000000000' 
	ls_app = ls_app + ls_iva_contrib
	ls_iva_contrib = right(ls_app, 11)
	
	if isnull(ls_casella1) or ls_casella1 = '' then ls_casella1 = '0'
	if isnull(ls_casella2) or ls_casella2 = '' then ls_casella2 = '0'

	if isnull(ls_iva_delegato) then ls_iva_delegato = ' '
	ls_iva_delegato = trim(ls_iva_delegato)					
	ls_app = '00000000000' 
	ls_app = ls_app + ls_iva_delegato
	ls_iva_delegato = right(ls_app, 11)
	
	
	if isnull(ls_num_det_sez1) then ls_num_det_sez1 = ' '
	ls_num_det_sez1 = trim(ls_num_det_sez1)			
	ls_app = '00000'
	ls_app = ls_app + ls_num_det_sez1
	ls_num_det_sez1 = right(ls_app, 5)

	if isnull(ls_amm_sez1) then ls_amm_sez1 = ' '
	ls_amm_sez1 = trim(ls_amm_sez1)				
	ls_app = '0000000000000' 
	ls_app = ls_app + ls_amm_sez1
	ls_amm_sez1 = right(ls_app, 13)	
	
	if isnull(ls_num_sez2) then ls_num_sez2 = ' '
	ls_num_sez2 = trim(ls_num_sez2)				
	ls_app = '00000'
	ls_app = ls_app + ls_num_sez2
	ls_num_sez2 = right(ls_app, 5)	
	
	if isnull(ls_amm_sez2) then ls_amm_sez2 = ' '
	ls_amm_sez2 = trim(ls_amm_sez2)					
	ls_app = '0000000000000' 
	ls_app = ls_app + ls_amm_sez2
	ls_amm_sez2 = right(ls_app, 13)		
	

   UPDATE INTRA_FRONTESPIZIO_OUTPUT
	SET intra = :ls_intra, iva = :ls_iva, num_prog_ele = :ls_num_prog_ele, tipo_rec = :ls_tipo_rec,
	    prog_riga = :ls_prog_riga, tipo_riepilogo = :ls_tipo_riepilogo, anno_rif = :ls_anno_rif, 
		 periodicita = :ls_periodicita, periodo = :ls_periodo, iva_contrib = :ls_iva_contrib,
		 casella1 = :ls_casella1, casella2 = :ls_casella2, iva_delegato = :ls_iva_delegato, 
		 num_det_sez1 = :ls_num_det_sez1, amm_sez1 = :ls_amm_sez1, num_sez2 = :ls_num_sez2, amm_sez2 = :ls_amm_sez2;
	
	
	ls_fronte="SELECT intra, iva, num_prog_ele, tipo_rec, Prog_riga, Tipo_riepilogo, Anno_rif, Periodicita,"+&
		" Periodo, IVA_contrib, Casella1, Casella2, IVA_delegato, num_det_sez1,amm_sez1,num_sez2,amm_sez2" +&
		" FROM INTRA_frontespizio_output; "+&
		" OUTPUT TO "+  ls_path + "\fronte_acq.TXT "+&
		" FORMAT FIXED" +&
		" COLUMN WIDTHS (5,11,6,1,5,1,2,1,2,11,1,1,11,5,13,5,13);"
	li_app=fileopen((ls_path+"\fronte_app.sql"),LineMode!,Write!,LockWrite!,Replace!)
	filewrite(li_app,ls_fronte)
	fileclose(li_app)
	li_app=run(ls1+' -q -c "UID=DBA; PWD=SQL;" read '+ ls_path+'\fronte_app.sql')

 
 string ls_cod_stato, ls_iva_operatore, ls_ammontare, ls_amm_val, ls_cod_nat_transaz, ls_cod_nomenclatura, ls_massa_netta
 string ls_unita_sup, ls_val_statistico, ls_cond_consegna, ls_modo_trasp, ls_paese_dest, ls_paese_orig, ls_prov_orig
 integer li_pos
 dec ld_massa_netta, ld_amm_val
 
 DATASTORE ds_intra2bis 
 ds_intra2bis = CREATE DATASTORE
 ds_intra2bis.DATAOBJECT = "ds_intra2bis"
 ds_intra2bis.SETTRANSOBJECT(SQLCA)
 ll_row=ds_intra2bis.RETRIEVE()   
 if ll_row > 0 then
	FOR i=1 TO ds_intra2bis.rowcount()
		ls_iva = ds_intra2bis.getitemstring(i,"iva")
		ls_num_prog_ele = ds_intra2bis.getitemstring(i,"num_prog_ele")
		ls_prog_riga = ds_intra2bis.getitemstring(i,"prog_riga")
		ls_ammontare = ds_intra2bis.getitemstring(i,"ammontare")
		ls_amm_val = ds_intra2bis.getitemstring(i,"amm_val")		
		ls_massa_netta = ds_intra2bis.getitemstring(i,"massa_netta")
		ls_unita_sup = ds_intra2bis.getitemstring(i,"unita_supp")
		ls_val_statistico = ds_intra2bis.getitemstring(i,"val_statistico")
		
		
		li_pos = pos (ls_amm_val,".")
		if not isnull(li_pos) and li_pos<> 0 then ls_amm_val = replace(ls_amm_val, li_pos,1,",")				
		
		ld_amm_val = dec(ls_amm_val)
		ld_amm_val = round(ld_amm_val,0)
		ls_amm_val = string(ld_amm_val)
		
		li_pos = pos (ls_massa_netta,".")
		if not isnull(li_pos) and li_pos<> 0 then ls_massa_netta = replace(ls_massa_netta, li_pos,1,",")
		ld_massa_netta=dec(ls_massa_netta)
		ld_massa_netta=round(ld_massa_netta,0)
		ls_massa_netta=string(ld_massa_netta)				
		
		
		ld_appimp = dec(ls_ammontare)
		if ld_appimp < 1000 then
			ld_appimp = 1
		else
			ld_appimp = round(ld_appimp/1000,0)
		end if
		ls_ammontare = string(ld_Appimp)
		
		ld_appimp = dec(ls_val_statistico)
		if ld_appimp < 1000 then
			ld_appimp = 1
		else
			ld_appimp = round(ld_appimp/1000,0)
		end if
		ls_val_statistico = string(ld_Appimp)	
		
		
		
 		if isnull(ls_iva) then ls_iva = ' '
		 ls_iva = trim(ls_iva)					
		 ls_app = '00000000000' 
		 ls_app = ls_app + ls_iva
		 ls_iva = right(ls_app, 11)		
 
		 if isnull(ls_num_prog_ele) then ls_num_prog_ele = ' '
		 ls_num_prog_ele = trim(ls_num_prog_ele)		 
		 ls_app = '000000' 
		 ls_app = ls_app + ls_num_prog_ele
		 ls_num_prog_ele = right(ls_app, 6)		
 
		 if isnull(ls_prog_riga) then ls_prog_riga = ' '
		 ls_prog_riga = trim(ls_prog_riga)		  
		 ls_app = '00000'
		 ls_app = ls_app + ls_prog_riga
		 ls_prog_riga = right(ls_app, 5) 
 
		 if isnull(ls_ammontare) then ls_ammontare = ' '
		 ls_ammontare = trim(ls_ammontare)		   
		 ls_app = '0000000000000'
		 ls_app = ls_app + ls_ammontare
		 ls_ammontare = right(ls_app, 13) 
	 
		 if isnull(ls_amm_val) then ls_amm_val = ' '
		 ls_amm_val = trim(ls_amm_val)		   
		 ls_app = '0000000000000'
		 ls_app = ls_app + ls_amm_val
		 ls_amm_val = right(ls_app, 13) 

		 if isnull(ls_massa_netta) then ls_massa_netta = ' '
		 ls_massa_netta = trim(ls_massa_netta)		    
		 ls_app = '0000000000'
		 ls_app = ls_app + ls_massa_netta
		 ls_massa_netta = right(ls_app, 10)  

		 if isnull(ls_unita_sup) then ls_unita_sup = ' '
		 ls_unita_sup = trim(ls_unita_sup)	 
		 ls_app = '0000000000'
		 ls_app = ls_app + ls_unita_sup
		 ls_unita_sup = right(ls_app, 10)   
 
		 if isnull(ls_val_statistico) then ls_val_statistico = ' '
		 ls_val_statistico = trim(ls_val_statistico)	  
		 ls_app = '0000000000000'
		 ls_app = ls_app + ls_val_statistico
		 ls_val_statistico = right(ls_app, 13)  
		 
		ds_intra2bis.setitem(i,"iva", ls_iva)
		ds_intra2bis.setitem(i,"num_prog_ele",ls_num_prog_ele)
		ds_intra2bis.setitem(i,"prog_riga",ls_prog_riga)
		ds_intra2bis.setitem(i,"ammontare",ls_ammontare)
		ds_intra2bis.setitem(i,"amm_val",ls_amm_val)		
		ds_intra2bis.setitem(i,"massa_netta",ls_massa_netta)
		ds_intra2bis.setitem(i,"unita_supp",ls_unita_sup)
		ds_intra2bis.setitem(i,"val_statistico",ls_val_statistico)	
		ds_intra2bis.update()
	NEXT

 end if

	ls_1bis="SELECT intra, iva, num_prog_ele, tipo_rec, Prog_riga, Cod_stato, Iva_operatore, Ammontare,"+&
	"Amm_val, cod_nat_transaz, Cod_nomenclatura, Massa_netta, Unita_supp, Val_statistico,Cond_consegna,Modo_trasporto,Paese_dest,Paese_origine,Prov_origine" +&
	" FROM INTRA_2bis_dogana order by prog_riga;"+&
	" OUTPUT TO "+ ls_path +"\intra_2bis.TXT"+&
	" FORMAT FIXED"+&
	" COLUMN WIDTHS (5,11,6,1,5,2,12,13,13,1,8,10,10,13,1,1,2,2,2);"
	li_app=fileopen((ls_path+"\intra_2bis.sql"),LineMode!,Write!,LockWrite!,Replace!)
	filewrite(li_app,ls_1bis)
	fileclose(li_app)
	li_app=run(ls1+' -q -c "UID=DBA; PWD=SQL;" read '+ ls_path+'\intra_2bis.sql')

string ls_mese_rif, ls_trim_rif, ls_stato_operatore, ls_segno, ls_natura_trans, ls_nomenclatura, ls_val_stat

 DATASTORE ds_intra2ter 
 ds_intra2ter = CREATE DATASTORE
 ds_intra2ter.DATAOBJECT = "ds_intra2ter"
 ds_intra2ter.SETTRANSOBJECT(SQLCA)
 ll_row=ds_intra2ter.RETRIEVE()   
 if ll_row > 0 then
	FOR i=1 TO ds_intra2ter.rowcount()
		ls_iva = ds_intra2ter.getitemstring(i,"iva")
		ls_num_prog_ele = ds_intra2ter.getitemstring(i,"num_prog_ele")
		ls_prog_riga = ds_intra2ter.getitemstring(i,"prog_riga")
		ls_mese_rif = ds_intra2ter.getitemstring(i,"mese_rif")
		ls_Trim_rif = ds_intra2ter.getitemstring(i,"Trim_rif")
		ls_anno_rif = ds_intra2ter.getitemstring(i,"anno_rif")
		ls_ammontare = ds_intra2ter.getitemstring(i,"ammontare")
		ls_amm_val = ds_intra2ter.getitemstring(i,"amm_valuta")		
		ls_val_stat = ds_intra2ter.getitemstring(i,"val_stat")		
		
		
		li_pos = pos (ls_amm_val,".")
		if not isnull(li_pos) and li_pos<> 0 then ls_amm_val = replace(ls_amm_val, li_pos,1,",")		
		
		ld_amm_val = dec(ls_amm_val)
		ld_amm_val = round(ld_amm_val,0)
		ls_amm_val = string(ld_amm_val)		
		
		ld_appimp = dec(ls_ammontare)
		if ld_appimp < 1000 then
			ld_appimp = 1
		else
			ld_appimp = round(ld_appimp/1000,0)
		end if
		ls_ammontare = string(ld_Appimp)				
		
		ld_appimp = dec(ls_val_stat)
		if ld_appimp < 1000 then
			ld_appimp = 1
		else
			ld_appimp = round(ld_appimp/1000,0)
		end if
		ls_val_stat = string(ld_Appimp)	
		
		
		
 		if isnull(ls_iva) then ls_iva = ' '
		 ls_iva = trim(ls_iva)	  
		 ls_app = '00000000000'
		 ls_app = ls_app + ls_iva
		 ls_iva = right(ls_app, 11)   
 
		 if isnull(ls_num_prog_ele) then ls_num_prog_ele = ' '
		 ls_num_prog_ele = trim(ls_num_prog_ele)	  
		 ls_app = '000000' 
		 ls_app = ls_app + ls_num_prog_ele
		 ls_num_prog_ele = right(ls_app, 6)		
 
		 if isnull(ls_prog_riga) then ls_prog_riga = ' '
		 ls_prog_riga = trim(ls_prog_riga)	   
		 ls_app = '00000'
		 ls_app = ls_app + ls_prog_riga
		 ls_prog_riga = right(ls_app, 5) 
		 
		 if isnull(ls_mese_rif) then ls_mese_rif = ' '
		 ls_mese_rif = trim(ls_mese_rif)	   
		 ls_app = '00'
		 ls_app = ls_app + ls_mese_rif
		 ls_mese_rif = right (ls_app, 2)
	 
		 if isnull(ls_anno_rif) then ls_anno_rif = ' '
		 ls_anno_rif = trim(ls_anno_rif)		
		 ls_app = '00'
		 ls_app = ls_app + ls_anno_rif
		 ls_anno_rif = right(ls_app, 2) 
 
		 if isnull(ls_Trim_rif) then ls_Trim_rif = ' '
		 ls_Trim_rif = trim(ls_Trim_rif)		 
		 ls_app = '0'
		 ls_app = ls_app + ls_Trim_rif
		 ls_Trim_rif = right (ls_app, 1) 
	  
		 if isnull(ls_ammontare) then ls_ammontare = ' '
		 ls_ammontare = trim(ls_ammontare)	    
		 ls_app = '0000000000000'
		 ls_app = ls_app + ls_ammontare
		 ls_ammontare = right (ls_app, 13)
 
		 if isnull(ls_amm_val) then ls_amm_val = ' '
		 ls_amm_val = trim(ls_amm_val)	     
		 ls_app = '0000000000000'
		 ls_app = ls_app + ls_amm_val
		 ls_amm_val = right (ls_app, 13) 

		 if isnull(ls_val_stat) then ls_val_stat = ' '
		 ls_val_stat = trim(ls_val_stat)	     
		 ls_app = '0000000000000'
		 ls_app = ls_app + ls_val_stat
		 ls_val_stat = right (ls_app, 13) 
		 
		ds_intra2ter.setitem(i,"iva", ls_iva)
		ds_intra2ter.setitem(i,"num_prog_ele",ls_num_prog_ele)
		ds_intra2ter.setitem(i,"prog_riga",ls_prog_riga)
		ds_intra2ter.setitem(i,"mese_rif",ls_mese_rif)
		ds_intra2ter.setitem(i,"Trim_rif",ls_Trim_rif)
		ds_intra2ter.setitem(i,"anno_rif",ls_anno_rif)
		ds_intra2ter.setitem(i,"ammontare",ls_ammontare)	
		ds_intra2ter.setitem(i,"amm_valuta",ls_amm_val)			
		ds_intra2ter.setitem(i,"val_stat",ls_val_stat)		
		ds_intra2ter.update()
	NEXT

 end if

	ls_1ter="SELECT intra, iva, num_prog_ele, tipo_rec, Prog_riga, Mese_rif, Trim_rif, Anno_rif,"+&
	"Stato_operatore, Iva_operatore, Segno, Ammontare, Amm_valuta, Natura_trans,Nomenclatura,Val_stat" +&
	" FROM INTRA_ter_dogana order by prog_riga;"+&
	" OUTPUT TO "+ ls_path +"\intra_2ter.TXT"+&
	" FORMAT FIXED"+&
	" COLUMN WIDTHS (5,11,6,1,5,2,1,2,2,12,1,13,13,1,8,13);"
	li_app=fileopen((ls_path+"\intra_2ter.sql"),LineMode!,Write!,Shared! ,Replace!)
	filewrite(li_app,ls_1ter)
	fileclose(li_app)
	li_app=run(ls1+' -q -c "UID=DBA; PWD=SQL;" read '+ ls_path+'\intra_2ter.sql')
	string ls_cessioni,ls_riga
	integer li_app2,li_eof
	ls_cessioni=ls_path+"\acquisizioni.txt"
	li_app=fileopen(ls_cessioni,LineMode!,Write!,Shared!,Replace!)
	li_app2=fileopen((ls_path+"\fronte_acq.txt"),LineMode!,read!,Shared!,append!)
	li_eof=0
	do while li_eof<>-100 
		li_eof=fileread(li_app2,ls_riga)
		if li_eof<> -100 then
			filewrite(li_app,ls_riga)
		end if
	loop
	fileclose(li_app2)
	fileclose(li_app)
	li_app=fileopen(ls_cessioni,LineMode!,Write!,Shared! ,Append!)
	li_app2=fileopen((ls_path+"\intra_2bis.txt"),LineMode!,read!,Shared!,append!)
	li_eof=0
	do while li_eof<>-100 
		li_eof=fileread(li_app2,ls_riga)
		if li_eof<> -100 then
			filewrite(li_app,ls_riga)
		end if
	loop
	fileclose(li_app2)
	fileclose(li_app)
	li_app=fileopen(ls_cessioni,LineMode!,Write!,Shared!,Append!)
	li_app2=fileopen((ls_path+"\intra_2ter.txt"),LineMode!,read!,Shared! ,append!)
	li_eof=0
	do while li_eof<>-100 
		li_eof=fileread(li_app2,ls_riga)
		if li_eof<> -100 then
			filewrite(li_app,ls_riga)
		end if
	loop
	fileclose(li_app2)
	fileclose(li_app)
	
	
else
	messagebox("Errore","Si deve prima selezionare un frontespizio!")	
	
end if
end if

end event

type dw_intra_fronte1_stampa from u_dw_master_main within tabpage_1
int X=9
int Y=24
int Width=2565
int Height=1136
int TabOrder=21
string DataObject="d_intra_frontespizio1_stampa"
boolean VScrollBar=true
end type

event ue_init;call super::ue_init;is_list.s_identifica[1]="id_i_fronte"
iudw_children[1]=tab_1.tabpage_2.dw_intra_riep1_acq_ff
iudw_children[2]=tab_1.tabpage_3.dw_intra_riep2_acq_ff

end event

type tabpage_2 from userobject within tab_1
int X=18
int Y=104
int Width=2587
int Height=1176
long BackColor=80659129
string Text="Intra 2Bis"
long TabBackColor=80659129
long TabTextColor=255
long PictureMaskColor=536870912
dw_intra_riep1_acq_ff dw_intra_riep1_acq_ff
dw_intra_2bis_dogana dw_intra_2bis_dogana
st_1 st_1
end type

on tabpage_2.create
this.dw_intra_riep1_acq_ff=create dw_intra_riep1_acq_ff
this.dw_intra_2bis_dogana=create dw_intra_2bis_dogana
this.st_1=create st_1
this.Control[]={this.dw_intra_riep1_acq_ff,&
this.dw_intra_2bis_dogana,&
this.st_1}
end on

on tabpage_2.destroy
destroy(this.dw_intra_riep1_acq_ff)
destroy(this.dw_intra_2bis_dogana)
destroy(this.st_1)
end on

type dw_intra_riep1_acq_ff from u_dw_master_main within tabpage_2
int X=9
int Y=72
int Width=2565
int Height=240
int TabOrder=10
string DataObject="d_intra_frontespizio1_stampa_2"
end type

event ue_init;call super::ue_init;ib_dw_shared=true
ias_key_name[1] = "id_i_fronte"
iudw_children[1]=tab_1.tabpage_2.dw_intra_2bis_dogana

end event

type dw_intra_2bis_dogana from u_dw_master_main within tabpage_2
int X=5
int Y=324
int Width=2569
int Height=816
int TabOrder=20
string DataObject="d_intra_2bis_dogana"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event ue_init;call super::ue_init;
end event

type st_1 from statictext within tabpage_2
int X=23
int Y=4
int Width=247
int Height=64
boolean Enabled=false
boolean BringToTop=true
string Text="Riepilogo"
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type tabpage_3 from userobject within tab_1
int X=18
int Y=104
int Width=2587
int Height=1176
long BackColor=79741120
string Text="Intra 2Ter"
long TabBackColor=79741120
long TabTextColor=255
long PictureMaskColor=536870912
dw_intra_riep2_acq_ff dw_intra_riep2_acq_ff
st_2 st_2
dw_intra_2ter_dogana dw_intra_2ter_dogana
end type

on tabpage_3.create
this.dw_intra_riep2_acq_ff=create dw_intra_riep2_acq_ff
this.st_2=create st_2
this.dw_intra_2ter_dogana=create dw_intra_2ter_dogana
this.Control[]={this.dw_intra_riep2_acq_ff,&
this.st_2,&
this.dw_intra_2ter_dogana}
end on

on tabpage_3.destroy
destroy(this.dw_intra_riep2_acq_ff)
destroy(this.st_2)
destroy(this.dw_intra_2ter_dogana)
end on

type dw_intra_riep2_acq_ff from u_dw_master_main within tabpage_3
int X=9
int Y=72
int Width=2565
int Height=240
int TabOrder=4
string DataObject="d_intra_frontespizio1_stampa_2"
end type

event ue_init;call super::ue_init;ib_dw_shared=true
ias_key_name[1] = "id_i_fronte"
end event

type st_2 from statictext within tabpage_3
int X=23
int Y=4
int Width=247
int Height=68
boolean Enabled=false
boolean BringToTop=true
string Text="Riepilogo"
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_intra_2ter_dogana from u_dw_master_main within tabpage_3
int X=5
int Y=324
int Width=2569
int Height=844
int TabOrder=3
string DataObject="d_intra_2ter_dogana"
boolean VScrollBar=true
end type

type cb_acq from commandbutton within w_intra_frontespizio1_stampa_cx
event clicked pbm_bnclicked
int X=919
int Y=40
int Width=329
int Height=84
int TabOrder=20
boolean BringToTop=true
string Text="Cessioni"
int TextSize=-8
int Weight=400
string FaceName="Arial"
boolean Italic=true
boolean Underline=true
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(parent)
s_list_main ls_list_null
OpenSheetWithParm( w_intra_frontespizio_stampa_cx, ls_list_null, w_app_frame, 0, Original!)
end event

type cb_ascii from commandbutton within w_intra_frontespizio1_stampa_cx
int X=2313
int Y=40
int Width=347
int Height=88
int TabOrder=30
boolean Enabled=false
boolean BringToTop=true
string Text="SCAMBI.CEE"
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string ls_path
select path_batch
into :ls_path
from intra_contatore;
integer li_app,li_app2,li_eof, prog_disk
boolean lb_esiste
string ls_riga
lb_esiste=fileexists(ls_path+"\cessioni.txt")
if lb_esiste=true then
	li_app=fileopen((ls_path+"\scambi.cee"),LineMode!,Write!,shared!,Replace!)
	li_app2=fileopen((ls_path+"\cessioni.txt"),LineMode!,read!,shared!,append!)
	li_eof=0
	do while li_eof<>-100 
		li_eof=fileread(li_app2,ls_riga)
		if li_eof<> -100 then
			filewrite(li_app,ls_riga)
		end if
	loop
	fileclose(li_app2)
	fileclose(li_app)
	li_app=fileopen((ls_path+"\scambi.cee"),LineMode!,Write!,shared!,append!)
	li_app2=fileopen((ls_path+"\acquisizioni.txt"),LineMode!,read!,shared!,append!)
	li_eof=0
	do while li_eof<>-100 
		li_eof=fileread(li_app2,ls_riga)
		if li_eof<> -100 then
			filewrite(li_app,ls_riga)
		end if
	loop
	fileclose(li_app2)
	fileclose(li_app)
	filedelete(ls_path+"\cessioni.txt")
	filedelete(ls_path+"\acquisizioni.txt")
	
	
else
	
	lb_esiste = fileexists(ls_path+"\acquisizioni.txt")
	if lb_esiste = false then
		messagebox("Attenzione!","Non trovo il file 'acquisizioni.txt'. Generazione impossibile")
		return
	end if	
	
	integer li_rit
	li_rit=messagebox("Informazione","Il file delle cessioni non esiste creare ugualmente il file scambi.cee?",information!,yesno!)
	if li_rit=1 then
		li_app=fileopen((ls_path+"\scambi.cee"),LineMode!,Write!,shared!,Replace!)
		li_app2=fileopen((ls_path+"\acquisizioni.txt"),LineMode!,read!,shared!,append!)
		li_eof=0
		do while li_eof<>-100 
			li_eof=fileread(li_app2,ls_riga)
			if li_eof<> -100 then
				filewrite(li_app,ls_riga)
			end if
		loop
		fileclose(li_app2)
		fileclose(li_app)
		filedelete(ls_path+"\acquisizioni.txt")
		
		
	end if
end if


Messagebox('Informazione', 'Il File '+ls_path +'\SCAMBI.CEE è stato creato')


end event

type cb_1 from commandbutton within w_intra_frontespizio1_stampa_cx
int X=1737
int Y=40
int Width=530
int Height=88
int TabOrder=30
boolean BringToTop=true
string Text="Gen. Riepilogo ACQ."
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;integer li_rig, li_id,li_prog,li_prog1, li_ret
long  iva_dele,valuta,a_amm_val,tot_valuta , rif_disk,   an
long tri, me, tot1, tot2, amm1, ll_row
integer per, cs1, cs2, i
string riep, period, cas1, cas2,  amm2
integer  rif,  dummy, num, tipo, prog, trim, anno, mese 
double  amm, trans,  val_stat,  ammontare, natura, val, a_amm, a_val, tot_amm, tot_val
string iso2,stato, iva_oper, segno, intra, iva_op, cod, dest, prov, cond, nomenclatura, iva_sog
double massa, unita, modo,tot_massa, tot_unita, tot_stat, a_massa, a_unita, a_stat,IVA,amm_valuta
integer prog_rig,amm_1,amm_temp, prog_disk
string ss_segno, segno_1, segno_fin, ls_app
dec ld_appimp
string IVA_OP_old,	NOMENCLATURA_old,	COND_old		
double natura_old, MODO_old


li_prog=0
li_prog1=0 




DELETE FROM INTRA_FRONTESPIZIO_OUTPUT;
if sqlca.sqlcode=0 then 
	commit;
else
	rollback;
	messagebox("Errore", "delete INTRA_FRONTESPIZIO_OUTPUT")
end if
li_rig = tab_1.tabpage_1.dw_intra_fronte1_stampa.getrow()
li_id = tab_1.tabpage_1.dw_intra_fronte1_stampa.getitemnumber (li_rig, "id_i_fronte")

if li_id>0 then
	
	

	SELECT partita_iva, rif_disk, riepilogo, anno, 
			 tipo_riepilogo, trimestre, mese, casella1,
			 casella2, iva_delegato, tot_rig_sez1, 
			 amm_compl_sez1, tot_rig_sez2, amm_compl_sez2 
	INTO :iva_sog, :rif_disk, :riep, :an, 
		  :period, :tri, :me, :cas1,
		  :cas2, :iva_dele, :tot1, 
		  :amm1, :tot2, :amm2
	FROM intra_frontespizio_input
	WHERE ID_I_FRONTE = :li_id;	
   
	
	
ld_appimp = dec(amm1)
if ld_appimp < 1 then
	ld_appimp = 1
else
	ld_appimp = round(ld_appimp,0)
end if
amm1 = long(ld_Appimp)

ld_appimp = abs(dec(amm2))
if ld_appimp < 1 then
	ld_appimp = -1
else
	ld_appimp = (round(ld_appimp,0)*-1)
end if
amm2 = string(ld_Appimp)

string ll_num_neg
long ll_lung
ll_lung = len(amm2)
ll_num_neg = right(amm2,1)

IF ll_num_neg = '0' THEN
 amm2 = Replace(amm2, ll_lung, 1, "p")
END IF

IF ll_num_neg = '1' THEN
	amm2 = Replace(amm2, ll_lung, 1, "q")
END IF
IF ll_num_neg = '2' THEN
	amm2 = Replace(amm2, ll_lung, 1, "r")
END IF
IF ll_num_neg = '3' THEN
	amm2 = Replace(amm2, ll_lung, 1, "s")
END IF
IF ll_num_neg = '4' THEN
	amm2 = Replace(amm2, ll_lung, 1, "t")
END IF
IF ll_num_neg = '5' THEN
	amm2 = Replace(amm2, ll_lung, 1, "u")
END IF
IF ll_num_neg = '6' THEN
	amm2 = Replace(amm2, ll_lung, 1, "v")
END IF
IF ll_num_neg = '7' THEN
	amm2 = Replace(amm2, ll_lung, 1, "w")
END IF
IF ll_num_neg = '8' THEN
 amm2 = Replace(amm2, ll_lung, 1, "x")
END IF

IF ll_num_neg = '9' THEN
	amm2 = Replace(amm2, ll_lung, 1, "y")
END IF

 amm2 = Replace(amm2, 1, 1, " ")


	
	if isnull(cas1) then cas1 = 'F'
	if isnull(cas2) then cas2 = 'F'	
	

	IF period = 'T' then
		per = tri
	else
		per = me
	end if
	IF cas1 = 'F' then
		cs1 = 0
	else
		cs1 = 1
	end if
	IF cas2 = 'F' then
		cs2 = 0
	else
		cs2 = 1
	end if
	
		select max (num_disk)
	into :prog_disk
	from intra_contatore;
	
	if isnull(string(prog_disk)) then prog_disk = 0	
	
	PROG_DISK = PROG_DISK + 1
	
	UPDATE intra_contatore
			SET NUM_disk=:PROG_DISK
	USING SQLCA;
	IF SQLCA.SQLCODE=0 THEN
		COMMIT;
	ELSE
		ROLLBACK;
		MESSAGEBOX("Errore", "numero disco non salvato")
	end if
		
	update intra_frontespizio_output
		set num_prog_ele = :PROG_DISK
	using sqlca;
	IF SQLCA.SQLCODE=0 THEN
		COMMIT;
	ELSE
		ROLLBACK;
		MESSAGEBOX("Errore", "intra_frontespizio_output non salvato")
	end if
	
	 update intra_frontespizio_input
		set rif_disk = :PROG_DISK
		WHERE ID_I_FRONTE = :li_id
		using sqlca;
	IF SQLCA.SQLCODE=0 THEN
		COMMIT;
	ELSE
		ROLLBACK;
		MESSAGEBOX("Errore", "intra_frontespizio_input non salvato")
	end if
	rif_disk = prog_disk


	INSERT INTO INTRA_FRONTESPIZIO_OUTPUT (intra, IVA, num_prog_ele, tipo_rec, 
				prog_riga, tipo_riepilogo, anno_rif, periodicita, periodo, iva_contrib, casella1, 
				casella2, iva_delegato, num_det_sez1, amm_sez1, num_sez2, amm_sez2)
		VALUES ('EUROA', :iva_sog, :rif_disk, 0, 0, :riep, :an, :period, :per, :iva_sog, :cs1, 
							  :cs2, :iva_dele, :tot1, :amm1, :tot2, :amm2); 


	IF SQLCA.SQLCODE <> 0 THEN
		MESSAGEBOX ('ERRORE', 'Causato errore durante passagio dati')
		rollback;
	else
		commit;
	END IF
	
	
	
	
		
	DELETE FROM  INTRA_2BIS_DOGANA;
	IF SQLCA.SQLCODE <> 0 THEN
		MESSAGEBOX ('ERRORE', 'INTRA_2BIS_DOGANA non cancellato!')
		rollback;
	else
		commit;
	END IF
	
		
	li_rig = tab_1.tabpage_1.dw_intra_fronte1_stampa.getrow()
	li_id = tab_1.tabpage_1.dw_intra_fronte1_stampa.getitemnumber (li_rig, "id_i_fronte")
	
	
IF period = 'M' then	
	DECLARE  INTRA_2BISD CURSOR FOR
	select 'EUROA', f.partita_iva, f.rif_disk, 1,0, a.nazione, a.par_iva, t.amm_operazioni,          
				t.amm_valuta, r.cod_nat_trans, l.cod_nomen, t.massa_netta, t.unita_suppl, 
				t.valore_stat,	c.gruppo,  m.codice, i.cod_iso, d.cod_iso, o.provincia
	from intra_frontespizio_input f, intra_2BIS t, anagrafica a, 
		  intra_nat_transazione r, intra_nomenclatura l,  sog_commerciale s,intra_condizioni_consegna c,
		  intra_tab_codici_iso i,intra_modo_trasporto m, localita o, 
		  intra_tab_codici_iso d
	where t.id_i_fronte =:LI_ID
	AND f.id_i_fronte = t.id_i_fronte
	AND s.id_sog_commerciale =  t.id_sog_commerciale
	AND a.id_anagrafica = s.id_anagrafica
	and t.id_i_nat_trans*=r.id_i_nat_trans
	and t.id_i_nomenclatura*=l.id_i_nomenclatura  
	and t.id_localita*=o.id_localita 
	and t.id_i_cod_cons*=c.id_i_cod_cons
	and t.id_i_tab_iso*=i.id_i_tab_iso
	and t.id_i_modo_trsp*=m.id_i_modo_trsp
	and t.id_i_tab_iso*=d.id_i_tab_iso
	order by a.par_iva , r.cod_nat_trans, l.cod_nomen
	USING SQLCA;
	
	OPEN  INTRA_2BISD;
	
	FETCH  INTRA_2BISD INTO :INTRA, :IVA, :NUM, :TIPO, :PROG, :COD, :IVA_OP, :AMMONTARE,&
			 :AMM_VALUTA, :NATURA, :NOMENCLATURA, :MASSA, :UNITA, :VAL , :COND, :MODO, :DEST, :ISO2, :PROV;
		
	DO WHILE SQLCA.SQLCODE = 0
		if isnull(IVA_OP) then iva_op=''
		if isnull(natura) then natura=0
		if isnull(NOMENCLATURA) then NOMENCLATURA=''
		if isnull(MODO) then MODO=0
		if isnull(COND) then COND=''
		if	 not (IVA_OP=IVA_OP_old and &
				NATURA=natura_old and &
				NOMENCLATURA=NOMENCLATURA_old and &
				COND=COND_old and &
				MODO=MODO_old) then
				
			
		
		
		
	
			li_prog++
			prog=li_prog
			
			INSERT INTO INTRA_2BIS_DOGANA (intra, iva, num_prog_ele, tipo_rec, prog_riga, cod_stato, & 
							iva_operatore, ammontare, amm_val, cod_nat_transaz, cod_nomenclatura, massa_netta, unita_supp, &
							val_statistico, cond_consegna, modo_trasporto, paese_dest,paese_origine, prov_origine)
						
						VALUES (:INTRA, :IVA, :rif_disk, :TIPO, :PROG, :COD, :IVA_OP, :AMMONTARE,&
						  :AMM_VALUTA, :NATURA, :NOMENCLATURA, :MASSA, :UNITA, :VAL,&
						  :COND, :MODO, :DEST, :ISO2, :PROV);
		
		
	else
		
			SELECT AMMONTARE, AMM_VAL, MASSA_NETTA, UNITA_SUPP, VAL_STATISTICO
			INTO   :A_AMM, :A_VAL, :A_MASSA, :A_UNITA, :A_STAT
			FROM   INTRA_2BIS_DOGANA
			WHERE  IVA_OPERATORE = :IVA_OP
			AND    COD_NAT_TRANSAZ = :NATURA
			AND    COD_NOMENCLATURA = :NOMENCLATURA
			AND    COND_CONSEGNA = :COND
			AND    MODO_TRASPORTO = :MODO;
	
			
			tot_amm = 0
			tot_massa=0
			tot_unita = 0
			tot_stat=0
			tot_val=0
			
			tot_amm   = a_amm + ammontare
			tot_massa = a_massa + massa
			tot_unita = a_unita + unita 
			tot_stat  = a_stat + val 
			tot_val   = a_val  + amm_valuta
			
			UPDATE INTRA_2BIS_DOGANA                
			SET AMMONTARE = :TOT_AMM ,AMM_VAL=:TOT_VAL, MASSA_NETTA=:TOT_MASSA, UNITA_SUPP=:TOT_UNITA, VAL_STATISTICO=:TOT_STAT
			WHERE  IVA_OPERATORE = :IVA_OP
			AND    COD_NAT_TRANSAZ = :NATURA
			AND    COD_NOMENCLATURA = :NOMENCLATURA
			AND    COND_CONSEGNA = :COND
			AND    MODO_TRASPORTO = :MODO;
			
	END IF
		IVA_OP_old=IVA_OP
		NATURA_old=natura 
		NOMENCLATURA_old=NOMENCLATURA
		COND_Old=COND
		MODO_old=MODO
	
	FETCH  INTRA_2BISD INTO :INTRA, :IVA, :NUM, :TIPO, :PROG, :COD, :IVA_OP, :AMMONTARE,&
			 :AMM_VALUTA, :NATURA, :NOMENCLATURA, :MASSA, :UNITA, :VAL, :COND, :MODO, :DEST, :ISO2, :PROV;
		
	LOOP
	CLOSE  INTRA_2BISD;
	
	if sqlca.sqlcode=0 then
		commit;
	else
		rollback;
		messagebox("Errore", "intra 1bisdogana")
	end if
	
else 
	
	DECLARE  INTRA_2BISD_2 CURSOR FOR
	select 'EUROA', f.partita_iva, f.rif_disk, 1,0, a.nazione, a.par_iva, t.amm_operazioni,          
				t.amm_valuta, r.cod_nat_trans, l.cod_nomen, t.massa_netta, t.unita_suppl, 
				t.valore_stat
				
	from intra_frontespizio_input f, intra_2BIS t, anagrafica a, 
		  intra_nat_transazione r, intra_nomenclatura l,  sog_commerciale s
		  
		  
		  
	where t.id_i_fronte =:LI_ID
	AND f.id_i_fronte = t.id_i_fronte
	AND s.id_sog_commerciale =  t.id_sog_commerciale
	AND a.id_anagrafica = s.id_anagrafica
	and  t.id_i_nat_trans*=r.id_i_nat_trans 
	and t.id_i_nomenclatura*=l.id_i_nomenclatura
	
	
	
	
	
	order by a.par_iva, r.cod_nat_trans, l.cod_nomen
	USING SQLCA;
	
	OPEN  INTRA_2BISD_2;
	
	FETCH  INTRA_2BISD_2 INTO :INTRA, :IVA, :NUM, :TIPO, :PROG, :COD, :IVA_OP, :AMMONTARE,&
			 :AMM_VALUTA, :NATURA, :NOMENCLATURA, :MASSA, :UNITA, :VAL ; 
		
	DO WHILE SQLCA.SQLCODE = 0
		if isnull(IVA_OP) then iva_op=''
		if isnull(natura) then natura=0
		if isnull(NOMENCLATURA) then NOMENCLATURA=''
		if isnull(MODO) then MODO=0
		if isnull(COND) then COND=''
	if	 not (IVA_OP=IVA_OP_old and &
				NATURA=natura_old and &
				NOMENCLATURA=NOMENCLATURA_old and &
				COND=COND_old and &
				MODO=MODO_old) then
			li_prog++
			prog=li_prog
			
			INSERT INTO INTRA_2BIS_DOGANA (intra, iva, num_prog_ele, tipo_rec, prog_riga, cod_stato, & 
							iva_operatore, ammontare, amm_val, cod_nat_transaz, cod_nomenclatura, massa_netta, unita_supp, &
							val_statistico, cond_consegna, modo_trasporto, paese_dest,paese_origine, prov_origine)
						
						VALUES (:INTRA, :IVA, :rif_disk, :TIPO, :PROG, :COD, :IVA_OP, :AMMONTARE,&
						  :AMM_VALUTA, :NATURA, :NOMENCLATURA, :MASSA, :UNITA, :VAL,&
						  :COND, :MODO, :DEST, :ISO2, :PROV);
		
		
	else
			SELECT AMMONTARE, AMM_VAL, MASSA_NETTA, UNITA_SUPP, VAL_STATISTICO
			INTO   :A_AMM, :A_VAL, :A_MASSA, :A_UNITA, :A_STAT
			FROM   INTRA_2BIS_DOGANA
			WHERE  IVA_OPERATORE = :IVA_OP
			AND    COD_NAT_TRANSAZ = :NATURA
			AND    COD_NOMENCLATURA = :NOMENCLATURA
			AND    COND_CONSEGNA = :COND
			AND    MODO_TRASPORTO = :MODO;
	
			
			tot_amm = 0
			tot_massa=0
			tot_unita = 0
			tot_stat=0
			tot_val=0
			
			tot_amm   = a_amm + ammontare
			tot_massa = a_massa + massa
			tot_unita = a_unita + unita 
			tot_stat  = a_stat + val 
			tot_val   = a_val  + amm_valuta
			
			UPDATE INTRA_2BIS_DOGANA                
			SET AMMONTARE = :TOT_AMM ,AMM_VAL=:TOT_VAL, MASSA_NETTA=:TOT_MASSA, UNITA_SUPP=:TOT_UNITA, VAL_STATISTICO=:TOT_STAT
			WHERE  IVA_OPERATORE = :IVA_OP
			AND    COD_NAT_TRANSAZ = :NATURA
			AND    COD_NOMENCLATURA = :NOMENCLATURA
			AND    COND_CONSEGNA = :COND
			AND    MODO_TRASPORTO = :MODO;
			
	END IF
	IVA_OP_old=IVA_OP
	NATURA_old=natura
	NOMENCLATURA_old=NOMENCLATURA
	COND_old=COND
	MODO_old=MODO
	
	FETCH  INTRA_2BISD_2 INTO :INTRA, :IVA, :NUM, :TIPO, :PROG, :COD, :IVA_OP, :AMMONTARE,&
			 :AMM_VALUTA, :NATURA, :NOMENCLATURA, :MASSA, :UNITA, :VAL ; 
		
	LOOP
	CLOSE  INTRA_2BISD_2;	
	if sqlca.sqlcode=0 then
		commit;
	else
		rollback;
	end if
end if
	
	prog_rig = tab_1.tabpage_2.dw_intra_2bis_dogana.Retrieve( ) 
	
	
	select sum (ammontare)
	into :amm_1
	from intra_2bis_dogana;
	
	
	update intra_frontespizio_input
	 
	 set  tot_rig_sez1 = :prog_rig, tot_sez1 = 1
	 where id_i_fronte = :li_id
	 using SQLCA;
	 if sqlca.sqlcode=0 then
		commit;
	else
		rollback;
		messagebox("Errore", "intra_frontespizio_input")
	end if
	tab_1.tabpage_1.dw_intra_fronte1_stampa.Retrieve( ) 
		
	
	
	
	DELETE FROM  INTRA_TER_DOGANA;
	 if sqlca.sqlcode=0 then
		commit;
	else
		rollback;
		messagebox("Errore", "cancella INTRA_TER_DOGANA")
	end if
	li_rig = tab_1.tabpage_1.dw_intra_fronte1_stampa.getrow()
	li_id = tab_1.tabpage_1.dw_intra_fronte1_stampa.getitemnumber (li_rig, "id_i_fronte")
	
	IVA_OP_old=''
	natura_old=-1
	NOMENCLATURA_old =''
	COND_old =''
	MODO_old= -1
	
	DECLARE  INTRA_2TERD CURSOR FOR
	select 'EUROA', f.partita_iva, f.rif_disk, 2,0, t.mese_rif, t.trim_rif, t.anno_rif, a.nazione, a.par_iva,          
				t.segn, t.amm_oper, t.amm_valut,r.cod_nat_trans, l.cod_nomen, t.val_stat
	from intra_frontespizio_input f, intra_2ter t, anagrafica a, 
		  intra_nat_transazione r, intra_nomenclatura l,  sog_commerciale s
	where t.id_i_fronte = :LI_ID
	AND f.id_i_fronte = t.id_i_fronte
	AND s.id_sog_commerciale =  t.id_sog_commerciale
	AND a.id_anagrafica = s.id_anagrafica
	and t.id_i_nat_trans*=r.id_i_nat_trans  
	and  t.id_i_nomenclatura*= l.id_i_nomenclatura
	order by a.par_iva, r.cod_nat_trans, l.cod_nomen
	USING SQLCA;
	
	OPEN  INTRA_2TERD;
	
	FETCH  INTRA_2TERD INTO :INTRA, :IVA, :NUM, :TIPO, :PROG, :MESE, :TRIM, :ANNO, :STATO, &
									:IVA_OP, :SEGNO, :AMMONTARE, :VALUTA, :NATURA, :NOMENCLATURA, :VAL;
	
	DO WHILE SQLCA.SQLCODE = 0
		if isnull(IVA_OP) then iva_op=''
		if isnull(natura) then natura=0
		if isnull(NOMENCLATURA) then NOMENCLATURA=''
		if isnull(MODO) then MODO=0
		if isnull(COND) then COND=''
	if	 not (IVA_OP=IVA_OP_old and &
				NATURA=natura_old and &
				NOMENCLATURA=NOMENCLATURA_old) then
			li_prog1++
			prog=li_prog1
			INSERT INTO INTRA_TER_DOGANA (intra, iva, num_prog_ele, tipo_rec, prog_riga, mese_rif, & 
							trim_rif, anno_rif, stato_operatore, iva_operatore, segno, ammontare, &
							amm_valuta, natura_trans, nomenclatura, val_stat)
				
				VALUES (:INTRA, :IVA, :rif_disk, :TIPO, :PROG, :MESE, &
							:TRIM, :ANNO, :STATO, :IVA_OP, :SEGNO, :AMMONTARE, &
							:VALUTA, :NATURA, :NOMENCLATURA, :VAL);
							
		
	else	
			SELECT AMMONTARE, VAL_STAT, AMM_VALUTA, SEGNO
			INTO   :A_AMM, :A_VAL, :A_AMM_VAL, :SEGNO_1
			FROM   INTRA_TER_DOGANA
			WHERE  IVA_OPERATORE = :IVA_OP
			AND    NATURA_TRANS = :NATURA
			AND    NOMENCLATURA = :NOMENCLATURA;
			
			tot_amm = 0
			tot_val = 0
			tot_valuta=0
			segno_fin='+'
		
		
		IF SEGNO_1 = '+'  AND SEGNO = '+' THEN 
			TOT_AMM = A_AMM + AMMONTARE
			TOT_VAL = A_VAL + VAL
			TOT_VALUTA=A_AMM_VAL+VALUTA
			SEGNO_FIN='+'
		END IF
		
		IF SEGNO_1 = '+'  AND SEGNO = '-'  AND A_AMM > AMMONTARE THEN
			TOT_AMM = A_AMM - AMMONTARE
			TOT_VAL = A_VAL - VAL
			TOT_VALUTA=A_AMM_VAL - VALUTA
			SEGNO_FIN = '+'
	
				ELSEIF SEGNO_1 = '+'  AND SEGNO = '-'  AND A_AMM < AMMONTARE THEN
						 TOT_AMM = AMMONTARE - A_AMM
						 TOT_VAL = VAL - A_VAL 
						 TOT_VALUTA= VALUTA - A_AMM_VAL
						 SEGNO_FIN = '-'
		END IF
		
		IF SEGNO_1 = '-'  AND SEGNO = '+'  AND A_AMM > AMMONTARE THEN
			TOT_AMM = A_AMM - AMMONTARE
			TOT_VAL = A_VAL - VAL
			TOT_VALUTA=A_AMM_VAL - VALUTA
			SEGNO_FIN = '-'
			
				ELSEIF SEGNO_1 = '-'  AND SEGNO = '+'  AND A_AMM < AMMONTARE THEN
						 TOT_AMM = AMMONTARE - A_AMM
						 TOT_VAL = VAL - A_VAL 
						 TOT_VALUTA= VALUTA - A_AMM_VAL
						 SEGNO_FIN = '+'
		END IF
		
		IF SEGNO_1 = '-'  AND SEGNO = '-' THEN
			TOT_AMM = AMMONTARE + A_AMM 
			TOT_VAL = VAL + A_VAL
			TOT_VALUTA=VALUTA + A_AMM_VAL		
			SEGNO_FIN='-'   
		END IF
	
	 
			UPDATE INTRA_TER_DOGANA
			SET AMMONTARE = :TOT_AMM , VAL_STAT = :TOT_VAL, AMM_VALUTA= :TOT_VALUTA, SEGNO = :SEGNO_FIN
			WHERE  IVA_OPERATORE = :IVA_OP
			AND    NATURA_TRANS = :NATURA
			AND    NOMENCLATURA = :NOMENCLATURA;
			
	END IF
		IVA_OP_old=IVA_OP
	NATURA_old=natura
	NOMENCLATURA_old=NOMENCLATURA
	
	FETCH  INTRA_2TERD INTO :INTRA, :IVA, :NUM, :TIPO, :PROG, :MESE, :TRIM, :ANNO, :STATO, &
									:IVA_OP, :SEGNO, :AMMONTARE, :VALUTA, :NATURA, :NOMENCLATURA, :VAL;
	LOOP
	CLOSE  INTRA_2TERD;
	if sqlca.sqlcode=0 then
		commit;
	else
		rollback;
		messagebox("Errroe", "INTRA_2TERD")
	end if
	prog_rig = tab_1.tabpage_3.dw_intra_2ter_dogana.Retrieve( ) 
	
	
	
	
	amm_1=0;
	
	declare somma cursor for
	select ammontare,segno
	from intra_ter_dogana;
	
	open somma;
	
	fetch somma into :amm_temp, :ss_segno;
	
	do while SQLCA.sqlcode = 0
	
	  if ss_segno="+" then
		  amm_1 += amm_temp
	  else
		  amm_1 -= amm_temp
	  end if
	
	  fetch somma into :amm_temp, :ss_segno;
	loop
	close somma;
	if sqlca.sqlcode=0 then
		commit;
	else
		rollback;
		messagebox("Errroe", "somma")
	end if
	update intra_frontespizio_input
	 
	 set  tot_rig_sez2  = :prog_rig, tot_sez2 = :prog_rig 
	 where id_i_fronte = :li_id
	 using SQLCA;
	 if sqlca.sqlcode=0 then
		commit;
	else
		rollback;
		messagebox("Errroe", "intra_frontespizio_input")
	end if
	 
	tab_1.tabpage_1.dw_intra_fronte1_stampa.retrieve()
	cb_ascii.enabled=true
	
	
	string ls_1bis,ls_1ter,ls_fronte
	string ls_path,ls_prog,ls1,ls2
	integer li_app
	boolean lb_es
	select path_stampa
	into :ls_prog
	from intra_contatore;
	lb_es=fileexists(ls_prog)
	if lb_es=false then
		getfileopenname("Apri",ls1,ls2)
		if Right(ls1,8)='isql.exe' then
			update intra_contatore set path_stampa=:ls1;
			if sqlca.sqlcode=0 then
				commit;
			else 
				messagebox("Errore!", "intra_contatore non SOMMATO!")
				rollback;
			end if
		end if
		ls_prog=ls1
	end if
	ls1=ls_prog
	select path_batch
	into :ls_path
	from intra_contatore;
	
		
	string ls_intra, ls_iva, ls_num_prog_ele, ls_tipo_rec, ls_prog_riga, ls_tipo_riepilogo, ls_anno_rif
	string ls_periodicita, ls_periodo, ls_iva_contrib, ls_casella1, ls_casella2, ls_iva_delegato
	string ls_num_det_sez1, ls_amm_sez1, ls_num_sez2, ls_amm_sez2
		  
	SELECT intra, iva, num_prog_ele, tipo_rec, Prog_riga, Tipo_riepilogo, Anno_rif, Periodicita,
      	Periodo, IVA_contrib, Casella1, Casella2, IVA_delegato, num_det_sez1,amm_sez1,num_sez2,amm_sez2
	into :ls_intra, :ls_iva, :ls_num_prog_ele, :ls_tipo_rec, :ls_prog_riga, :ls_tipo_riepilogo, :ls_anno_rif,
	     :ls_periodicita, :ls_periodo, :ls_iva_contrib, :ls_casella1, :ls_casella2, :ls_iva_delegato, 
		  :ls_num_det_sez1, :ls_amm_sez1, :ls_num_sez2, :ls_amm_sez2
	FROM INTRA_frontespizio_output; 
	
	if isnull(ls_iva) then ls_iva = ' '
	ls_iva = trim(ls_iva)
	ls_app = '00000000000' 
	ls_app = ls_app + ls_iva
	ls_iva = right(ls_app, 11)
	
	if isnull(ls_num_prog_ele) then ls_num_prog_ele = ' '
	ls_num_prog_ele = trim(ls_num_prog_ele)	
	ls_app = '000000'
	ls_app = ls_app + ls_num_prog_ele
	ls_num_prog_ele = right(ls_app, 6)
	
	if isnull(ls_prog_riga) then ls_prog_riga = ' '
	ls_prog_riga = trim(ls_prog_riga)	
	ls_app = '00000'
	ls_app = ls_app + ls_prog_riga
	ls_prog_riga = right(ls_app, 5)

	if isnull(ls_anno_rif) then ls_anno_rif = ' '
	ls_anno_rif = trim(ls_anno_rif)		
	ls_app = '00'
	ls_app = ls_app + ls_anno_rif
	ls_anno_rif = right(ls_app, 2)
	
	if isnull(ls_periodo) then ls_periodo = ' '
	ls_periodo = trim(ls_periodo)				
	ls_app = '00'
	ls_app = ls_app + ls_periodo
	ls_periodo = right(ls_app, 2)	

	if isnull(ls_iva_contrib) then ls_iva_contrib = ' '
	ls_iva_contrib = trim(ls_iva_contrib)					
	ls_app = '00000000000' 
	ls_app = ls_app + ls_iva_contrib
	ls_iva_contrib = right(ls_app, 11)
	
	if isnull(ls_casella1) or ls_casella1 = '' then ls_casella1 = '0'
	if isnull(ls_casella2) or ls_casella2 = '' then ls_casella2 = '0'

	if isnull(ls_iva_delegato) then ls_iva_delegato = ' '
	ls_iva_delegato = trim(ls_iva_delegato)					
	ls_app = '00000000000' 
	ls_app = ls_app + ls_iva_delegato
	ls_iva_delegato = right(ls_app, 11)
	
	
	ls_num_det_sez1=string(tab_1.tabpage_2.dw_intra_2bis_dogana.rowcount())
	if isnull(ls_num_det_sez1) then ls_num_det_sez1 = ' '
	ls_num_det_sez1 = trim(ls_num_det_sez1)			
	ls_app = '00000'
	ls_app = ls_app + ls_num_det_sez1
	ls_num_det_sez1 = right(ls_app, 5)

	if isnull(ls_amm_sez1) then ls_amm_sez1 = ' '
	ls_amm_sez1 = trim(ls_amm_sez1)				
	ls_app = '0000000000000' 
	ls_app = ls_app + ls_amm_sez1
	ls_amm_sez1 = right(ls_app, 13)	
	
	
	ls_num_sez2=string(tab_1.tabpage_3.dw_intra_2ter_dogana.rowcount())
	if isnull(ls_num_sez2) then ls_num_sez2 = ' '
	ls_num_sez2 = trim(ls_num_sez2)				
	ls_app = '00000'
	ls_app = ls_app + ls_num_sez2
	ls_num_sez2 = right(ls_app, 5)	
	
	if isnull(ls_amm_sez2) then ls_amm_sez2 = ' '
	ls_amm_sez2 = trim(ls_amm_sez2)					
	ls_app = '0000000000000' 
	ls_app = ls_app + ls_amm_sez2
	ls_amm_sez2 = right(ls_app, 13)		
	

   UPDATE INTRA_FRONTESPIZIO_OUTPUT
	SET intra = :ls_intra, iva = :ls_iva, num_prog_ele = :ls_num_prog_ele, tipo_rec = :ls_tipo_rec,
	    prog_riga = :ls_prog_riga, tipo_riepilogo = :ls_tipo_riepilogo, anno_rif = :ls_anno_rif, 
		 periodicita = :ls_periodicita, periodo = :ls_periodo, iva_contrib = :ls_iva_contrib,
		 casella1 = :ls_casella1, casella2 = :ls_casella2, iva_delegato = :ls_iva_delegato, 
		 num_det_sez1 = :ls_num_det_sez1, amm_sez1 = :ls_amm_sez1, 
		 num_sez2 = :ls_num_sez2, amm_sez2 = :ls_amm_sez2;
		 
	 if sqlca.sqlcode=0 then
		commit;
	else
		rollback;
		messagebox("Errroe", "INTRA_FRONTESPIZIO_OUTPUT")
	end if
	
	
	ls_fronte="SELECT intra, iva, num_prog_ele, tipo_rec, Prog_riga, Tipo_riepilogo, Anno_rif, Periodicita,"+&
		" Periodo, IVA_contrib, Casella1, Casella2, IVA_delegato, num_det_sez1,amm_sez1,num_sez2,amm_sez2" +&
		" FROM INTRA_frontespizio_output; "+&
		" OUTPUT TO "+  ls_path + "\fronte_acq.TXT "+&
		" FORMAT FIXED" +&
		" COLUMN WIDTHS (5,11,6,1,5,1,2,1,2,11,1,1,11,5,13,5,13);"
	li_app=fileopen((ls_path+"\fronte_app.sql"),LineMode!,Write!,LockWrite!,Replace!)
	filewrite(li_app,ls_fronte)
	fileclose(li_app)
	li_app=run(ls1+' -q -c "UID=DBA; PWD=SQL;" read '+ ls_path+'\fronte_app.sql')

 
 string ls_cod_stato, ls_iva_operatore, ls_ammontare, ls_amm_val, ls_cod_nat_transaz, ls_cod_nomenclatura, ls_massa_netta
 string ls_unita_sup, ls_val_statistico, ls_cond_consegna, ls_modo_trasp, ls_paese_dest, ls_paese_orig, ls_prov_orig
 integer li_pos
 dec ld_massa_netta, ld_amm_val
 
 DATASTORE ds_intra2bis 
 ds_intra2bis = CREATE DATASTORE
 ds_intra2bis.DATAOBJECT = "ds_intra2bis"
 ds_intra2bis.SETTRANSOBJECT(SQLCA)
 ll_row=ds_intra2bis.RETRIEVE()   
 if ll_row > 0 then
	FOR i=1 TO ds_intra2bis.rowcount()
		ls_iva = ds_intra2bis.getitemstring(i,"iva")
		ls_num_prog_ele = ds_intra2bis.getitemstring(i,"num_prog_ele")
		ls_prog_riga = ds_intra2bis.getitemstring(i,"prog_riga")
		ls_ammontare = ds_intra2bis.getitemstring(i,"ammontare")
		ls_amm_val = ds_intra2bis.getitemstring(i,"amm_val")		
		ls_massa_netta = ds_intra2bis.getitemstring(i,"massa_netta")
		ls_unita_sup = ds_intra2bis.getitemstring(i,"unita_supp")
		ls_val_statistico = ds_intra2bis.getitemstring(i,"val_statistico")
		
		
		li_pos = pos (ls_amm_val,".")
		if not isnull(li_pos) and li_pos<> 0 then ls_amm_val = replace(ls_amm_val, li_pos,1,",")		
		
		ld_amm_val = dec(ls_amm_val)
		ld_amm_val = round(ld_amm_val,0)
		ls_amm_val = string(ld_amm_val)	
		
		li_pos = pos (ls_massa_netta,".")
		if not isnull(li_pos) and li_pos<> 0 then ls_massa_netta = replace(ls_massa_netta, li_pos,1,",")
		ld_massa_netta=dec(ls_massa_netta)
		ld_massa_netta=round(ld_massa_netta,0)
		ls_massa_netta=string(ld_massa_netta)		
		
		ld_appimp = dec(ls_ammontare)
		if ld_appimp < 1000 then
			ld_appimp = 1
		else
			ld_appimp = round(ld_appimp/1000,0)
		end if
		ls_ammontare = string(ld_Appimp)
		
		ld_appimp = dec(ls_val_statistico)
		if ld_appimp < 1000 then
			ld_appimp = 1
		else
			ld_appimp = round(ld_appimp/1000,0)
		end if
		ls_val_statistico = string(ld_Appimp)	
		
		
 		if isnull(ls_iva) then ls_iva = ' '
		 ls_iva = trim(ls_iva)					
		 ls_app = '00000000000' 
		 ls_app = ls_app + ls_iva
		 ls_iva = right(ls_app, 11)		
 
		 if isnull(ls_num_prog_ele) then ls_num_prog_ele = ' '
		 ls_num_prog_ele = trim(ls_num_prog_ele)		 
		 ls_app = '000000' 
		 ls_app = ls_app + ls_num_prog_ele
		 ls_num_prog_ele = right(ls_app, 6)		
 
		 if isnull(ls_prog_riga) then ls_prog_riga = ' '
		 ls_prog_riga = trim(ls_prog_riga)		  
		 ls_app = '00000'
		 ls_app = ls_app + ls_prog_riga
		 ls_prog_riga = right(ls_app, 5) 
 
		 if isnull(ls_ammontare) then ls_ammontare = ' '
		 ls_ammontare = trim(ls_ammontare)		   
		 ls_app = '0000000000000'
		 ls_app = ls_app + ls_ammontare
		 ls_ammontare = right(ls_app, 13) 
	 
		 if isnull(ls_amm_val) then ls_amm_val = ' '
		 ls_amm_val = trim(ls_amm_val)		   
		 ls_app = '0000000000000'
		 ls_app = ls_app + ls_amm_val
		 ls_amm_val = right(ls_app, 13) 

		 if isnull(ls_massa_netta) then ls_massa_netta = ' '
		 ls_massa_netta = trim(ls_massa_netta)		    
		 ls_app = '0000000000'
		 ls_app = ls_app + ls_massa_netta
		 ls_massa_netta = right(ls_app, 10)  

		 if isnull(ls_unita_sup) then ls_unita_sup = ' '
		 ls_unita_sup = trim(ls_unita_sup)	 
		 ls_app = '0000000000'
		 ls_app = ls_app + ls_unita_sup
		 ls_unita_sup = right(ls_app, 10)   
 
		 if isnull(ls_val_statistico) then ls_val_statistico = ' '
		 ls_val_statistico = trim(ls_val_statistico)	  
		 ls_app = '0000000000000'
		 ls_app = ls_app + ls_val_statistico
		 ls_val_statistico = right(ls_app, 13)  
		 
		ds_intra2bis.setitem(i,"iva", ls_iva)
		ds_intra2bis.setitem(i,"num_prog_ele",ls_num_prog_ele)
		ds_intra2bis.setitem(i,"prog_riga",ls_prog_riga)
		ds_intra2bis.setitem(i,"ammontare",ls_ammontare)
		ds_intra2bis.setitem(i,"amm_val",ls_amm_val)		
		ds_intra2bis.setitem(i,"massa_netta",ls_massa_netta)
		ds_intra2bis.setitem(i,"unita_supp",ls_unita_sup)
		ds_intra2bis.setitem(i,"val_statistico",ls_val_statistico)	
		li_ret=ds_intra2bis.update()
		if li_ret=1 then
			commit;
		else
			rollback;
			messagebox("Errrore", "ds_intra2bis")
		end if
	NEXT

 end if


 

	ls_1bis="SELECT intra, iva, num_prog_ele, tipo_rec, Prog_riga, Cod_stato, Iva_operatore, Ammontare,"+&
	"Amm_val, cod_nat_transaz, Cod_nomenclatura, Massa_netta, Unita_supp, Val_statistico,Cond_consegna,Modo_trasporto,Paese_dest,Paese_origine,Prov_origine" +&
	" FROM INTRA_2bis_dogana order by prog_riga;"+&
	" OUTPUT TO "+ ls_path +"\intra_2bis.TXT"+&
	" FORMAT FIXED"+&
	" COLUMN WIDTHS (5,11,6,1,5,2,12,13,13,1,8,10,10,13,1,1,2,2,2);"
	li_app=fileopen((ls_path+"\intra_2bis.sql"),LineMode!,Write!,LockWrite!,Replace!)
	filewrite(li_app,ls_1bis)
	fileclose(li_app)
	li_app=run(ls1+' -q -c "UID=DBA; PWD=SQL;" read '+ ls_path+'\intra_2bis.sql')

string ls_mese_rif, ls_trim_rif, ls_stato_operatore, ls_segno, ls_natura_trans, ls_nomenclatura, ls_val_stat

 DATASTORE ds_intra2ter 
 ds_intra2ter = CREATE DATASTORE
 ds_intra2ter.DATAOBJECT = "ds_intra2ter"
 ds_intra2ter.SETTRANSOBJECT(SQLCA)
 ll_row=ds_intra2ter.RETRIEVE()   
 if ll_row > 0 then
	FOR i=1 TO ds_intra2ter.rowcount()
		ls_iva = ds_intra2ter.getitemstring(i,"iva")
		ls_num_prog_ele = ds_intra2ter.getitemstring(i,"num_prog_ele")
		ls_prog_riga = ds_intra2ter.getitemstring(i,"prog_riga")
		ls_mese_rif = ds_intra2ter.getitemstring(i,"mese_rif")
		ls_Trim_rif = ds_intra2ter.getitemstring(i,"Trim_rif")
		ls_anno_rif = ds_intra2ter.getitemstring(i,"anno_rif")
		ls_ammontare = ds_intra2ter.getitemstring(i,"ammontare")
		ls_amm_val = ds_intra2ter.getitemstring(i,"amm_valuta")		
		ls_val_stat = ds_intra2ter.getitemstring(i,"val_stat")		
		
		
		li_pos = pos (ls_amm_val,".")
		if not isnull(li_pos) and li_pos<> 0 then ls_amm_val = replace(ls_amm_val, li_pos,1,",")		
		
		ld_amm_val = dec(ls_amm_val)
		ld_amm_val = round(ld_amm_val,0)
		ls_amm_val = string(ld_amm_val)	
		
		ld_appimp = dec(ls_ammontare)
			ld_appimp = round(ld_appimp/1000,0)
		
		ls_ammontare = string(ld_Appimp)				
		
		ld_appimp = dec(ls_val_stat)
			ld_appimp = round(ld_appimp/1000,0)
		ls_val_stat = string(ld_Appimp)	
		
		
		
 		if isnull(ls_iva) then ls_iva = ' '
		 ls_iva = trim(ls_iva)	  
		 ls_app = '00000000000'
		 ls_app = ls_app + ls_iva
		 ls_iva = right(ls_app, 11)   
 
		 if isnull(ls_num_prog_ele) then ls_num_prog_ele = ' '
		 ls_num_prog_ele = trim(ls_num_prog_ele)	  
		 ls_app = '000000' 
		 ls_app = ls_app + ls_num_prog_ele
		 ls_num_prog_ele = right(ls_app, 6)		
 
		 if isnull(ls_prog_riga) then ls_prog_riga = ' '
		 ls_prog_riga = trim(ls_prog_riga)	   
		 ls_app = '00000'
		 ls_app = ls_app + ls_prog_riga
		 ls_prog_riga = right(ls_app, 5) 
		 
		 if isnull(ls_mese_rif) then ls_mese_rif = ' '
		 ls_mese_rif = trim(ls_mese_rif)	   
		 ls_app = '00'
		 ls_app = ls_app + ls_mese_rif
		 ls_mese_rif = right (ls_app, 2)
	 
		 if isnull(ls_anno_rif) then ls_anno_rif = ' '
		 ls_anno_rif = trim(ls_anno_rif)		
		 ls_app = '00'
		 ls_app = ls_app + ls_anno_rif
		 ls_anno_rif = right(ls_app, 2) 
 
		 if isnull(ls_Trim_rif) then ls_Trim_rif = ' '
		 ls_Trim_rif = trim(ls_Trim_rif)		 
		 ls_app = '0'
		 ls_app = ls_app + ls_Trim_rif
		 ls_Trim_rif = right (ls_app, 1) 
	  
		 if isnull(ls_ammontare) then ls_ammontare = ' '
		 ls_ammontare = trim(ls_ammontare)	    
		 ls_app = '0000000000000'
		 ls_app = ls_app + ls_ammontare
		 ls_ammontare = right (ls_app, 13)
 
		 if isnull(ls_amm_val) then ls_amm_val = ' '
		 ls_amm_val = trim(ls_amm_val)	     
		 ls_app = '0000000000000'
		 ls_app = ls_app + ls_amm_val
		 ls_amm_val = right (ls_app, 13) 

		 if isnull(ls_val_stat) then ls_val_stat = ' '
		 ls_val_stat = trim(ls_val_stat)	     
		 ls_app = '0000000000000'
		 ls_app = ls_app + ls_val_stat
		 ls_val_stat = right (ls_app, 13) 
		 
		ds_intra2ter.setitem(i,"iva", ls_iva)
		ds_intra2ter.setitem(i,"num_prog_ele",ls_num_prog_ele)
		ds_intra2ter.setitem(i,"prog_riga",ls_prog_riga)
		ds_intra2ter.setitem(i,"mese_rif",ls_mese_rif)
		ds_intra2ter.setitem(i,"Trim_rif",ls_Trim_rif)
		ds_intra2ter.setitem(i,"anno_rif",ls_anno_rif)
		ds_intra2ter.setitem(i,"ammontare",ls_ammontare)	
		ds_intra2ter.setitem(i,"amm_valuta",ls_amm_val)			
		ds_intra2ter.setitem(i,"val_stat",ls_val_stat)		
		li_ret=ds_intra2ter.update()
		if li_ret=1 then
			commit;
		else
			rollback;
			messagebox("Errore", "ds_intra2ter")
		end if
NEXT

 end if



	ls_1ter="SELECT intra, iva, num_prog_ele, tipo_rec, Prog_riga, Mese_rif, Trim_rif, Anno_rif,"+&
	"Stato_operatore, Iva_operatore, Segno, Ammontare, Amm_valuta, Natura_trans,Nomenclatura,Val_stat" +&
	" FROM INTRA_ter_dogana order by prog_riga;"+&
	" OUTPUT TO "+ ls_path +"\intra_2ter.TXT"+&
	" FORMAT FIXED"+&
	" COLUMN WIDTHS (5,11,6,1,5,2,1,2,2,12,1,13,13,1,8,13);"
	li_app=fileopen((ls_path+"\intra_2ter.sql"),LineMode!,Write!,Shared! ,Replace!)
	filewrite(li_app,ls_1ter)
	fileclose(li_app)
	li_app=run(ls1+' -q -c "UID=DBA; PWD=SQL;" read '+ ls_path+'\intra_2ter.sql')

	messagebox("Informazione","Generazione riepilogo ACQUISIZIONI terminata correttamente")	
	
	string ls_cessioni,ls_riga
	integer li_app2,li_eof
	ls_cessioni=ls_path+"\acquisizioni.txt"
	li_app=fileopen(ls_cessioni,LineMode!,Write!,Shared!,Replace!)
	li_app2=fileopen((ls_path+"\fronte_acq.txt"),LineMode!,read!,Shared!,append!)
	IF li_app>0 AND li_app2>0 THEN
		li_eof=0
		do while li_eof<>-100 
			li_eof=fileread(li_app2,ls_riga)
			if li_eof<> -100 then
				filewrite(li_app,ls_riga)
			end if
		loop
	end if
	li_ret = fileclose(li_app2)
	li_ret = fileclose(li_app)
	li_app=fileopen(ls_cessioni,LineMode!,Write!,Shared! ,Append!)
	li_app2=fileopen((ls_path+"\intra_2bis.txt"),LineMode!,read!,Shared!,append!)
	IF li_app>0 AND li_app2>0 THEN
		li_eof=0
		do while li_eof<>-100 
			li_eof=fileread(li_app2,ls_riga)
			if li_eof<> -100 then
				filewrite(li_app,ls_riga)
			end if
		loop
	end if
	li_ret = fileclose(li_app2)
	li_ret = fileclose(li_app)
	li_app=fileopen(ls_cessioni,LineMode!,Write!,Shared!,Append!)
	li_app2=fileopen((ls_path+"\intra_2ter.txt"),LineMode!,read!,Shared! ,append!)
	IF li_app>0 AND li_app2>0 THEN
		li_eof=0
		do while li_eof<>-100 
			li_eof=fileread(li_app2,ls_riga)
			if li_eof<> -100 then
				filewrite(li_app,ls_riga)
			end if
		loop
	end if
	li_ret = fileclose(li_app2)
	li_ret = fileclose(li_app)
else
	messagebox("Errore","Si deve prima selezionare un frontespizio!")
end if
end event

type p_1 from picture within w_intra_frontespizio1_stampa_cx
int X=1582
int Y=40
int Width=110
int Height=88
boolean BringToTop=true
string PictureName="s:\pb\commonframework\printer.bmp"
boolean FocusRectangle=false
boolean OriginalSize=true
end type

event clicked;

long ll_righe, ll_id

s_st_param strut_dich  

ll_righe = tab_1.tabpage_1.dw_intra_fronte1_stampa.getrow()
if ll_righe > 0 then
	ll_id=tab_1.tabpage_1.dw_intra_fronte1_stampa.getitemnumber(ll_righe, "id_i_fronte")
	strut_dich.id_esercizio = ll_id
	
	OpenWithParm(w_stampa_intra_acq, strut_dich)
end if
end event

