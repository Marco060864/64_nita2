forward
global type w_cancella_scritture_cx from w_wiz_main
end type
type tab_1 from tab within w_cancella_scritture_cx
end type
type tabpage_1 from userobject within tab_1
end type
type dw_1 from u_dw_ext_main within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_1 dw_1
end type
type tabpage_2 from userobject within tab_1
end type
type dw_2 from u_dw_pura within tabpage_2
end type
type cb_2 from commandbutton within tabpage_2
end type
type cb_3 from commandbutton within tabpage_2
end type
type cb_4 from commandbutton within tabpage_2
end type
type cb_5 from commandbutton within tabpage_2
end type
type dw_3 from u_dw_ext_main within tabpage_2
end type
type sle_1 from singlelineedit within tabpage_2
end type
type st_2 from statictext within tabpage_2
end type
type sle_2 from singlelineedit within tabpage_2
end type
type st_3 from statictext within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_2 dw_2
cb_2 cb_2
cb_3 cb_3
cb_4 cb_4
cb_5 cb_5
dw_3 dw_3
sle_1 sle_1
st_2 st_2
sle_2 sle_2
st_3 st_3
end type
type tab_1 from tab within w_cancella_scritture_cx
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type cb_1 from commandbutton within w_cancella_scritture_cx
end type
type cb_6 from commandbutton within w_cancella_scritture_cx
end type
type st_1 from statictext within w_cancella_scritture_cx
end type
end forward

global type w_cancella_scritture_cx from w_wiz_main
integer y = 437
integer width = 2761
integer height = 1620
string title = "Elimina Scritture Contabili"
tab_1 tab_1
cb_1 cb_1
cb_6 cb_6
st_1 st_1
end type
global w_cancella_scritture_cx w_cancella_scritture_cx

type variables
DataWindow idw_source, idw_target
Boolean ib_removing, ib_down_source, ib_down_target
String is_filter




end variables

forward prototypes
public subroutine uf_drop_many ()
public subroutine uf_drop (long al_row_source)
public subroutine uf_drop_all ()
public subroutine uf_remove (long al_row_target)
public subroutine uf_remove_all ()
public subroutine uf_remove_many ()
public subroutine uf_aggiorna_totale_righe (long ll_id_reg_pd, string ls_segno, string ls_ris_sto)
public subroutine uf_cancella_risconti_storni (long ll_id_reg_pd)
end prototypes

public subroutine uf_drop_many ();

long ll_Rows, ll_i, ll_CurrRow
decimal ldc_tot_scadenza_importo

ll_Rows = idw_source.RowCount()

ib_removing = TRUE
idw_source.SetRow(1)

FOR ll_i = ll_Rows TO 1 STEP -1
	IF idw_source.IsSelected(ll_i) THEN
		uf_drop(ll_i)
	END IF
NEXT
idw_target.Sort()

ib_removing = FALSE


end subroutine

public subroutine uf_drop (long al_row_source);

long ll_id_reg_pd, ll_NewRow, ll_find, ll_CurrRow
date ld_data_reg
string  ls_search


ll_CurrRow = idw_target.GetRow()


ll_id_reg_pd  = idw_source.GetItemnumber(al_row_source, "reg_pd_id_reg_pd")
ld_data_reg   = idw_source.GetItemDate(al_row_source, "reg_pd_data_registrazione")

ls_search = "reg_pd_id_reg_pd= " + string(ll_id_reg_pd)
ll_find = idw_target.find(ls_search, 1, idw_target.RowCount())

		ll_NewRow = idw_target.InsertRow(0)
		idw_target.SetItem(ll_NewRow, "reg_pd_id_reg_pd", ll_id_reg_pd)
		idw_target.SetItem(ll_NewRow, "reg_pd_data_registrazione", ld_data_reg)
		
		idw_source.DeleteRow(al_row_source)
	
	
	idw_target.SelectRow(ll_NewRow, TRUE)

long ll_num, ll_num_righe, ll_conta
string ls_num, ls_conta

ll_num=tab_1.tabpage_2.dw_3.getitemnumber(1, 'righe_sel')
ls_num=string(ll_num)
tab_1.tabpage_2.sle_2.text= ls_num

ll_num_righe = tab_1.tabpage_2.dw_2.rowcount()
	if ll_num_righe > 0 then
		ll_conta = tab_1.tabpage_2.dw_2.getitemnumber(1, 'conta')
		ls_conta = string(ll_conta)
		tab_1.tabpage_2.sle_1.text= ls_conta
	end if
end subroutine

public subroutine uf_drop_all ();

long ll_Rows, ll_i, ll_CurrRow
decimal ldc_tot_scadenza_importo

ll_Rows = idw_source.RowCount()

ib_removing = TRUE
idw_source.SetRow(1)

FOR ll_i = ll_Rows TO 1 STEP -1
	uf_drop(ll_i)
NEXT
idw_target.Sort()

ib_removing = FALSE


end subroutine

public subroutine uf_remove (long al_row_target);

long ll_id_reg_pd, ll_NewRow, ll_find, ll_CurrRow
date ld_data_reg
string  ls_search

ll_id_reg_pd           = idw_target.GetItemNumber(al_row_target, "reg_pd_id_reg_pd")
ld_data_reg         = idw_target.GetItemDate(al_row_target, "reg_pd_data_registrazione")

ll_NewRow = idw_source.InsertRow(0)

idw_source.SetItem(ll_NewRow, "reg_pd_id_reg_pd", ll_id_reg_pd)
idw_source.SetItem(ll_NewRow, "reg_pd_data_registrazione", ld_data_reg)

idw_source.SelectRow(ll_NewRow, TRUE)

idw_target.SetRow(al_row_target)

idw_target.DeleteRow(0)


long ll_num, ll_num_row, ll_num_righe, ll_conta
string ls_num, ls_conta
ll_num_row = idw_target.rowcount()

if ll_num_row > 0 then

	ll_num=tab_1.tabpage_2.dw_3.getitemnumber(1, 'righe_sel')
	ls_num=string(ll_num)
	tab_1.tabpage_2.sle_2.text= ls_num
	
	ll_num_righe = tab_1.tabpage_2.dw_2.rowcount()
	if ll_num_righe > 0 then
		ll_conta = tab_1.tabpage_2.dw_2.getitemnumber(1, 'conta')
		ls_conta = string(ll_conta)
		tab_1.tabpage_2.sle_1.text= ls_conta
	end if
end if
end subroutine

public subroutine uf_remove_all ();

long ll_Rows, ll_i

ll_Rows = idw_target.RowCount()

ib_removing = TRUE
FOR ll_i = ll_Rows TO 1 STEP -1
	uf_remove(ll_i)
NEXT
idw_source.Sort()
ib_removing = FALSE
end subroutine

public subroutine uf_remove_many ();

long ll_Rows, ll_i

ll_Rows = idw_target.RowCount()

ib_removing = TRUE
FOR ll_i = ll_Rows TO 1 STEP -1
	IF idw_target.IsSelected(ll_i) THEN
		uf_remove(ll_i)
	END IF
NEXT


idw_source.Sort()

idw_target.SelectRow(0, FALSE)
idw_target.Sort()
ib_removing = FALSE
end subroutine

public subroutine uf_aggiorna_totale_righe (long ll_id_reg_pd, string ls_segno, string ls_ris_sto);

string ls_quota_rat_ris, ls_storno
long ll_rif_conto, ll_rif_scr_storno, ll_rif_scr_rat_ris, ll_id_mov_contabile
long var_comodo, ll_num, ll_mov_reg_pd
decimal ld_dare, ld_avere, ld_tot_dare, ld_tot_avere, LD_IMP_RISC;

CHOOSE CASE LS_RIS_STO
CASE "RISCONTO"
	   choose case ls_segno
			case "D"
				
				
				DECLARE mov_contabile_d_cur CURSOR FOR
				SELECT  id_mov_contabile, dare, avere
				  FROM mov_contabile
				 WHERE id_reg_pd=:ll_id_reg_pd;
				 										 
				 
				OPEN mov_contabile_d_cur;
				
				FETCH mov_contabile_d_cur INTO :ll_id_mov_contabile,:ld_dare,:ld_avere; 
				
				DO WHILE SQLCA.SQLCODE=0
			     	IF SQLCA.SQLCODE=0 THEN 
						if ld_avere>0 then 
							
							ld_tot_avere=ld_tot_avere+ld_avere
							ll_num=ll_num+1
							UPDATE mov_contabile
								SET numero=:ll_num
							 WHERE id_mov_contabile=:ll_id_mov_contabile;
						end if
						if ld_dare>0 then 
							var_comodo=ll_id_mov_contabile 
						end if
					END IF
					FETCH mov_contabile_d_cur INTO :ll_id_mov_contabile,:ld_dare,:ld_avere;
							
					LOOP
					CLOSE mov_contabile_d_cur; 
					commit;		
					
					if ld_tot_avere>0 and ll_num>0 then
						
						ll_num=ll_num+1
						UPDATE mov_contabile
						SET numero=:ll_num, dare=:ld_tot_avere
						WHERE id_mov_contabile=:var_comodo;
						commit;
						  else
							
							select id_reg_pd
							into :ll_mov_reg_pd
							from mov_contabile
							where id_mov_contabile=:var_comodo;  
							
							delete from mov_contabile
							where id_mov_contabile=:var_comodo;
							
							delete from reg_pd
							where id_reg_pd=:ll_mov_reg_pd;
					end if
	      case "A"
				
				
				DECLARE mov_contabile_a_cur CURSOR FOR
				SELECT  id_mov_contabile, dare, avere
				  FROM mov_contabile
				 WHERE id_reg_pd=:ll_id_reg_pd;
				 										 
				 
				OPEN mov_contabile_a_cur;
				
				FETCH mov_contabile_a_cur INTO :ll_id_mov_contabile,:ld_dare,:ld_avere; 
				
				DO WHILE SQLCA.SQLCODE=0
					IF SQLCA.SQLCODE=0 THEN 
						if ld_dare>0 then 
							
							ld_tot_dare=ld_tot_dare+ld_dare
							ll_num=ll_num+1
							UPDATE mov_contabile
								SET numero=:ll_num
							 WHERE id_mov_contabile=:ll_id_mov_contabile;
						end if
						if ld_avere>0 then 
							var_comodo=ll_id_mov_contabile 
						end if
					END IF
					FETCH mov_contabile_a_cur INTO :ll_id_mov_contabile,:ld_dare,:ld_avere;
							
					LOOP
					CLOSE mov_contabile_a_cur; 
					commit;		
					
					if ld_tot_dare>0 and ll_num>0  then
						
						ll_num=ll_num+1
						UPDATE mov_contabile
						SET numero=:ll_num, avere=:ld_tot_dare
						WHERE id_mov_contabile=:var_comodo;
						commit;
						  else
							
							select id_reg_pd
							into :ll_mov_reg_pd
							from mov_contabile
							where id_mov_contabile=:var_comodo;  
							
							delete from mov_contabile
							where id_mov_contabile=:var_comodo;
							
							delete from reg_pd
							where id_reg_pd=:ll_mov_reg_pd;
					end if
			end choose
CASE "STORNO"	
		choose case ls_segno
			case "A"
				
				
				DECLARE mov_contabile_sd_cur CURSOR FOR
				SELECT  id_mov_contabile, dare, avere
				  FROM mov_contabile
				 WHERE id_reg_pd=:ll_id_reg_pd;
				 										 
				 
				OPEN mov_contabile_sd_cur;
				
				FETCH mov_contabile_sd_cur INTO :ll_id_mov_contabile,:ld_dare,:ld_avere; 
				
				DO WHILE SQLCA.SQLCODE=0
			     	IF SQLCA.SQLCODE=0 THEN 
						if ld_avere>0 then 
							
							ld_tot_avere=ld_tot_avere+ld_avere
							ll_num=ll_num+1
							UPDATE mov_contabile
								SET numero=:ll_num
							 WHERE id_mov_contabile=:ll_id_mov_contabile;
						end if
						if ld_dare>0 then
							var_comodo=ll_id_mov_contabile 
						end if
					END IF
					FETCH mov_contabile_sd_cur INTO :ll_id_mov_contabile,:ld_dare,:ld_avere;
							
					LOOP
					CLOSE mov_contabile_sd_cur; 
					commit;		
					
					if ld_tot_avere>0 and ll_num>0 then
						
						ll_num=ll_num+1
						UPDATE mov_contabile
						SET numero=:ll_num, dare=:ld_tot_avere
						WHERE id_mov_contabile=:var_comodo;
						commit;
						  else
							
							select id_reg_pd
							into :ll_mov_reg_pd
							from mov_contabile
							where id_mov_contabile=:var_comodo;  
							
							delete from mov_contabile
							where id_mov_contabile=:var_comodo;
							
							delete from reg_pd
							where id_reg_pd=:ll_mov_reg_pd;
					end if
	      case "D"
				
				
				DECLARE mov_contabile_sa_cur CURSOR FOR
				SELECT  id_mov_contabile, dare, avere
				  FROM mov_contabile
				 WHERE id_reg_pd=:ll_id_reg_pd;
				 										 
				 
				OPEN mov_contabile_sa_cur;
				
				FETCH mov_contabile_sa_cur INTO :ll_id_mov_contabile,:ld_dare,:ld_avere; 
				
				DO WHILE SQLCA.SQLCODE=0
					IF SQLCA.SQLCODE=0 THEN 
					   if ld_dare>0 then 
							
							
							ld_tot_dare=ld_tot_dare+ld_dare
							ll_num=ll_num+1
							UPDATE mov_contabile
								SET numero=:ll_num
							 WHERE id_mov_contabile=:ll_id_mov_contabile;
						end if
						if ld_avere>0 then 
							var_comodo=ll_id_mov_contabile 
						end if
					END IF
					FETCH mov_contabile_sa_cur INTO :ll_id_mov_contabile,:ld_dare,:ld_avere;
							
					LOOP
					CLOSE mov_contabile_sa_cur; 
					commit;		
					
					if ld_tot_dare>0 and ll_num>0  then
						
						ll_num=ll_num+1
						UPDATE mov_contabile
						SET numero=:ll_num, avere=:ld_tot_dare
						WHERE id_mov_contabile=:var_comodo;
						commit;
						  else
							
							select id_reg_pd
							into :ll_mov_reg_pd
							from mov_contabile
							where id_mov_contabile=:var_comodo;  
							
						   delete from mov_contabile
							where id_mov_contabile=:var_comodo;
							
							delete from reg_pd
							where id_reg_pd=:ll_mov_reg_pd;
					end if
			end choose
END CHOOSE
	
end subroutine

public subroutine uf_cancella_risconti_storni (long ll_id_reg_pd);

string ls_quota_rat_ris, ls_storno, ls_segno, ls_ris_sto
long ll_rif_conto, ll_rif_scr_storno, ll_rif_scr_rat_ris, ll_id_mov_contabile
long ll_mov_reg_pd,var_comodo, ll_num
integer li_numero
decimal ld_dare, ld_avere, ld_tot_dare, ld_tot_avere, LD_IMP_RISC;

SELECT quota_rat_ris, storno, segno, rif_conto, rif_scr_storno, rif_scr_rat_ris, FLAG_RAT_RIS
INTO :ls_quota_rat_ris, :ls_storno, :ls_segno, :ll_rif_conto, 
                        :ll_rif_scr_storno, :ll_rif_scr_rat_ris, :LD_IMP_RISC
  FROM ges_ratei_risconti
 WHERE rif_scrittura=:ll_id_reg_pd;
 
IF sqlca.sqlcode=0 THEN 
	
	IF ls_quota_rat_ris='S' THEN 
		
		SELECT id_mov_contabile
		  INTO :ll_id_mov_contabile
		FROM mov_contabile
	  WHERE id_reg_pd=:ll_rif_scr_rat_ris AND 
				id_conto=:ll_rif_conto AND 
				(dare=:LD_IMP_RISC OR avere=:LD_IMP_RISC);
	  
	  DELETE FROM mov_contabile
	  WHERE id_mov_contabile=:ll_id_mov_contabile;
	END IF
	
	IF ls_storno='S' THEN 
		
		SELECT id_mov_contabile
		  INTO :ll_id_mov_contabile
		FROM mov_contabile
	  WHERE id_reg_pd=:ll_rif_scr_storno AND 
				id_conto=:ll_rif_conto AND 
				(dare=:LD_IMP_RISC OR avere=:LD_IMP_RISC);
	  
	  DELETE FROM mov_contabile
	  WHERE id_mov_contabile=:ll_id_mov_contabile;
	END IF

END IF

IF ls_quota_rat_ris='S' THEN  
   ls_ris_sto="RISCONTO"
   uf_aggiorna_totale_righe(ll_rif_scr_rat_ris, ls_segno, ls_ris_sto)
END IF
IF ls_storno='S' THEN  
   ls_ris_sto="STORNO"
   uf_aggiorna_totale_righe(ll_rif_scr_storno, ls_segno, ls_ris_sto)
END IF


end subroutine

on w_cancella_scritture_cx.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.cb_1=create cb_1
this.cb_6=create cb_6
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_6
this.Control[iCurrent+4]=this.st_1
end on

on w_cancella_scritture_cx.destroy
call super::destroy
destroy(this.tab_1)
destroy(this.cb_1)
destroy(this.cb_6)
destroy(this.st_1)
end on

event open;call super::open;

long ll_CurrRow    
DataWindowChild dwc_drop, dwc_drop2, dwc_drop3

string ls_sort


tab_1.tabpage_1.dw_1.GetChild("prof1", dwc_drop)
dwc_drop.SetTransObject(SQLCA)
dwc_drop.Retrieve()

tab_1.tabpage_1.dw_1.GetChild("prof2", dwc_drop2)
dwc_drop2.SetTransObject(SQLCA)
dwc_drop2.Retrieve()


tab_1.tabpage_1.dw_1.GetChild("esercizio", dwc_drop3)
dwc_drop3.SetTransObject(SQLCA)
dwc_drop3.Retrieve()


ib_removing = FALSE
		idw_source = tab_1.tabpage_2.DW_2
		idw_target = tab_1.tabpage_2.DW_3

		
		
		idw_source.SetTransObject(SQLCA)
		idw_source.Retrieve()
		idw_source.SetFilter(is_filter)
		idw_source.Filter()



ll_CurrRow = tab_1.tabpage_1.DW_1.GetRow()
IF ll_CurrRow = 0 THEN tab_1.tabpage_1.DW_1.InsertRow(0)

end event

type tab_1 from tab within w_cancella_scritture_cx
integer x = 46
integer y = 156
integer width = 2661
integer height = 1320
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean raggedright = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

event selectionchanged;long ll_conta, ll_num_righe
string ls_conta

if newindex = 2 then
	ll_num_righe = tab_1.tabpage_2.dw_2.rowcount()
	if ll_num_righe > 0 then
		ll_conta = tab_1.tabpage_2.dw_2.getitemnumber(1, 'conta')
		ls_conta = string(ll_conta)
		tab_1.tabpage_2.sle_1.text= ls_conta
	end if
end if
end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 2624
integer height = 1200
long backcolor = 79741120
string text = "Imposta Filtri"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_1 dw_1
end type

on tabpage_1.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on tabpage_1.destroy
destroy(this.dw_1)
end on

type dw_1 from u_dw_ext_main within tabpage_1
event ue_setup_filter ( )
integer x = 14
integer y = 116
integer width = 2587
integer height = 1072
string dataobject = "d_seleziona_scritture2_ff"
end type

event ue_setup_filter;call super::ue_setup_filter;

long ll_CurrRow, ll_num_reg1, ll_num_reg2
date ld_data_scad_dal, ld_data_scad_al
string ls_tipo_scadenza, ls_profilo_da,  ls_profilo_a, ls_data_scad,  ll_num_reg
string  ls_tipo_reg_da, ls_tipo_reg_a, doc1, doc2, ls_eser, ls_esercizio

STRING ls_prof, ls_profilo, ls_doc
constant string LCS_AND = " AND "

is_filter = ""

ll_CurrRow = THIS.GetRow()

IF ll_CurrRow > 0 THEN
	ld_data_scad_dal     = THIS.GetItemDate(ll_CurrRow, "DATA1")
	ld_data_scad_al      = THIS.GetItemDate(ll_CurrRow, "DATA2")
 	ls_profilo_da        = THIS.GetItemString(ll_CurrRow, "prof1")
  	ls_profilo_a         = THIS.GetItemString(ll_CurrRow, "prof2")
	ls_tipo_reg_da       = THIS.GetItemString(ll_CurrRow, "tipo_reg1")
	ls_tipo_reg_a        = THIS.GetItemString(ll_CurrRow, "tipo_reg2")
	doc1                 = THIS.GetItemString(ll_CurrRow, "n_doc1")
	doc2                 = THIS.GetItemString(ll_CurrRow, "n_doc2")
	ls_eser              = THIS.GetItemString(ll_CurrRow, "esercizio")
	ll_num_reg1          = THIS.GetItemnumber(ll_CurrRow, "n_reg1")
	ll_num_reg2          = THIS.GetItemnumber(ll_CurrRow, "n_reg2")



	
	IF (NOT IsNull(ld_data_scad_dal)) AND (NOT IsNull(ld_data_scad_al)) THEN
		ls_data_scad = "(reg_pd_data_registrazione>= date('" + string(ld_data_scad_dal) + "')) AND (reg_pd_data_registrazione <= date('" + String(ld_data_scad_al) + "'))"
		IF is_filter = "" THEN
			is_filter = ls_data_scad
		ELSE
			is_filter = is_filter + LCS_AND + ls_data_scad
		END IF
	END IF
	
	
	IF (NOT IsNull(ls_profilo_da)) AND (NOT IsNull(ls_profilo_a)) THEN
		
		
		ls_profilo = "(prof_registrazione_codice >= '" + ls_profilo_da + "') AND (prof_registrazione_codice <= '" + ls_profilo_a + "')"
			IF is_filter = "" THEN
			is_filter = ls_profilo
		ELSE
			is_filter = is_filter + LCS_AND + ls_profilo
		END IF
	END IF
	
		
	IF (NOT IsNull(ls_tipo_reg_da)) AND (NOT IsNull(ls_tipo_reg_a)) THEN
		
		ls_prof = "(registro_tipo_registro >= '" + ls_tipo_reg_da + "') AND (registro_tipo_registro <= '" + ls_tipo_reg_a + "')"
		IF is_filter = "" THEN
			is_filter = ls_prof
		ELSE
			is_filter = is_filter + LCS_AND + ls_prof
		END IF
	END IF
	
			
	IF (NOT IsNull(doc1)) AND (NOT IsNull(doc2)) THEN
		
		ls_doc = "(reg_pd_num_documento >= '" + doc1 + "') AND (reg_pd_num_documento <= '" + doc2 + "')"
		IF is_filter = "" THEN
			is_filter = ls_doc
		ELSE
			is_filter = is_filter + LCS_AND + ls_doc
		END IF
	END IF

				
	IF NOT IsNull(ls_eser) THEN
		
		ls_esercizio = "(esercizio_codice = '" + ls_eser + "') "
		IF is_filter = "" THEN
			is_filter = ls_esercizio
		ELSE
			is_filter = is_filter + LCS_AND + ls_esercizio
		END IF
	END IF

				
	IF (NOT IsNull(ll_num_reg1)) AND (NOT IsNull(ll_num_reg2)) THEN
		
		ll_num_reg = "(reg_pd_num_progressivo >= " + string(ll_num_reg1) + ") AND (reg_pd_num_progressivo <= " + string(ll_num_reg2) + ")"
		IF is_filter = "" THEN
			is_filter = ll_num_reg
		ELSE
			is_filter = is_filter + LCS_AND + ll_num_reg
		END IF
	END IF


	
	idw_source.SetFilter(is_filter)
	idw_source.Filter()
END IF
end event

event itemchanged;call super::itemchanged;THIS.Event Post ue_Setup_Filter()
end event

event ue_init;call super::ue_init;is_colonne_drop[1]  = "prof1"
is_colonne_drop[2]  = "prof2"

end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 2624
integer height = 1200
long backcolor = 79741120
string text = "Scritture da Eliminare"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_2 dw_2
cb_2 cb_2
cb_3 cb_3
cb_4 cb_4
cb_5 cb_5
dw_3 dw_3
sle_1 sle_1
st_2 st_2
sle_2 sle_2
st_3 st_3
end type

on tabpage_2.create
this.dw_2=create dw_2
this.cb_2=create cb_2
this.cb_3=create cb_3
this.cb_4=create cb_4
this.cb_5=create cb_5
this.dw_3=create dw_3
this.sle_1=create sle_1
this.st_2=create st_2
this.sle_2=create sle_2
this.st_3=create st_3
this.Control[]={this.dw_2,&
this.cb_2,&
this.cb_3,&
this.cb_4,&
this.cb_5,&
this.dw_3,&
this.sle_1,&
this.st_2,&
this.sle_2,&
this.st_3}
end on

on tabpage_2.destroy
destroy(this.dw_2)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.cb_4)
destroy(this.cb_5)
destroy(this.dw_3)
destroy(this.sle_1)
destroy(this.st_2)
destroy(this.sle_2)
destroy(this.st_3)
end on

type dw_2 from u_dw_pura within tabpage_2
event ue_buttondown pbm_lbuttondown
event ue_buttonup pbm_lbuttonup
event ue_mousemove pbm_mousemove
integer y = 104
integer width = 1339
integer height = 980
integer taborder = 2
boolean titlebar = true
string title = "Scritture"
string dataobject = "d_reg_pd_canc_lt"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event ue_buttondown;call super::ue_buttondown;ib_down_source = TRUE
end event

event ue_buttonup;call super::ue_buttonup;ib_down_source = TRUE
end event

event ue_mousemove;call super::ue_mousemove;
end event

event clicked;call super::clicked;long ll_RetVal

IF KeyDown(KeyControl!) OR KeyDown(KeyShift!) OR (row = THIS.GetRow()) THEN
	THIS.SelectRow(row, NOT THIS.IsSelected(row))
END IF

end event

event dragenter;call super::dragenter;IF ib_down_source = TRUE THEN
	idw_source.DragIcon = 'Application!'
END IF

IF ib_down_target = TRUE THEN
	THIS.dragicon = 'Rectangle!'
END IF
end event

event dragleave;call super::dragleave;IF ib_down_target = TRUE THEN
	idw_source.DragIcon = 'Application!'
END IF
end event

event rowfocuschanged;call super::rowfocuschanged;

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

event dragdrop;call super::dragdrop;IF ib_down_target = TRUE THEN
	uf_remove_many()
END IF
idw_target.drag(end!)
end event

type cb_2 from commandbutton within tabpage_2
integer x = 1390
integer y = 268
integer width = 247
integer height = 108
integer taborder = 2
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = ">>"
end type

event clicked;

uf_drop_all()
end event

type cb_3 from commandbutton within tabpage_2
integer x = 1394
integer y = 420
integer width = 247
integer height = 108
integer taborder = 11
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = ">"
end type

event clicked;uf_drop_many()
end event

type cb_4 from commandbutton within tabpage_2
integer x = 1390
integer y = 704
integer width = 247
integer height = 108
integer taborder = 12
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "<"
end type

event clicked;uf_remove_many()
end event

type cb_5 from commandbutton within tabpage_2
integer x = 1390
integer y = 852
integer width = 247
integer height = 108
integer taborder = 13
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "<<"
end type

event clicked;uf_remove_all()
end event

type dw_3 from u_dw_ext_main within tabpage_2
event ue_rilascia ( )
event ue_buttondown pbm_lbuttondown
event ue_buttonup pbm_lbuttonup
event ue_mousemove pbm_mousemove
integer x = 1669
integer y = 104
integer width = 946
integer height = 980
integer taborder = 2
boolean titlebar = true
string title = "Selezione per Cancellazione"
string dataobject = "d_reg_pd_cancella_lt"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event ue_rilascia;call super::ue_rilascia;
long ll_Rows, ll_i, ll_id_scadenza, ll_NewRow, ll_num
date ld_data_scadenza
decimal ldc_imp_scadenza
string ls_crag_soc, ls_num

ll_Rows = idw_source.RowCount()
ib_removing = TRUE
idw_source.SetRow(1)

FOR ll_i = ll_Rows TO 1 STEP -1
	IF idw_source.IsSelected(ll_i) THEN
		uf_drop(ll_i)
	END IF
NEXT

idw_target.Sort()
ib_removing = FALSE


end event

event ue_buttondown;call super::ue_buttondown;ib_down_target = TRUE
end event

event ue_buttonup;call super::ue_buttonup;ib_down_target = FALSE
end event

event ue_mousemove;call super::ue_mousemove;
end event

event clicked;call super::clicked;long ll_RetVal

IF KeyDown(KeyControl!) THEN
	THIS.SelectRow(row, NOT THIS.IsSelected(row))
END IF

IF KeyDown(KeyShift!) THEN
	THIS.SelectRow(row, NOT THIS.IsSelected(row))
END IF

end event

event dragdrop;call super::dragdrop;DragObject ldo_source
DataWindow ldw_source

ldo_source = DraggedObject()

CHOOSE CASE TypeOf(ldo_source)
	CASE DataWindow!
		ldw_source = ldo_source
		IF ldw_source.DataObject = "d_reg_pd_canc_lt" AND (ib_down_source = TRUE) THEN
			THIS.EVENT ue_rilascia()
		END IF
END CHOOSE

IDW_source.drag(end!)



end event

event dragenter;call super::dragenter;IF ib_down_source = TRUE THEN
	THIS.dragicon = 'Rectangle!'
END IF

end event

event dragleave;call super::dragleave;IF ib_down_source = TRUE THEN
	tab_1.tabpage_2.dw_2.DragIcon = 'Application!'
END IF



end event

event rowfocuschanged;call super::rowfocuschanged;
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

event ue_init;call super::ue_init;

end event

type sle_1 from singlelineedit within tabpage_2
integer x = 937
integer y = 1092
integer width = 402
integer height = 92
integer taborder = 14
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within tabpage_2
integer x = 302
integer y = 1108
integer width = 613
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean enabled = false
string text = "Scritture Recuperate:"
alignment alignment = center!
boolean focusrectangle = false
end type

type sle_2 from singlelineedit within tabpage_2
integer x = 2213
integer y = 1096
integer width = 402
integer height = 92
integer taborder = 15
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within tabpage_2
integer x = 1577
integer y = 1108
integer width = 613
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean enabled = false
string text = "Scritture Selezionate: "
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_cancella_scritture_cx
integer x = 50
integer y = 36
integer width = 279
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Chiudi"
end type

event clicked;Close(Parent)
end event

type cb_6 from commandbutton within w_cancella_scritture_cx
string tag = "Elimina scritture"
integer x = 2130
integer y = 44
integer width = 539
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Elimina Scritture"
end type

event clicked;

integer li_risp,  num_rig, i
long ll_RetVal, ll_num, ll_IDReg_PD
string stato, LS_STORNO, LS_QUOTA_RAT_RIS


li_risp = messagebox ('ATTENZIONE', 'Sei sicuro della selezione fatta?, ~rle scritture selezionare verranno cancellate',&
Information!, YesNoCancel!, 1)
IF li_risp = 1 THEN
	//MESSAGEBOX ('OK','SI PROCEDE CON LA CANCELLAZIONE')
	//MESSAGEBOX ('Attenzione','Questa operazione può richiedere alcuni minuti!!!')
	
	num_rig = tab_1.tabpage_2.dw_3.rowcount() 
	
	IF NUM_RIG = 0 THEN
		MESSAGEBOX ('ATTENZIONE', 'Non ci sono dati da cancellare')
	ELSE
		
	
		FOR I = 1 TO num_rig
			ll_IDReg_PD = tab_1.tabpage_2.dw_3.GetItemNumber(i, "reg_pd_id_reg_pd")
				
			SELECT st_stampa_bollato, num_progressivo
			INTO :stato, :ll_num
			FROM reg_pd
			WHERE id_reg_pd = :ll_IDReg_PD;
	
		SQLCA.sp_elimina_reg_pd (ll_IDReg_PD, ll_retval)

		IF ll_RetVal <> 0 THEN
			MessageBox("Registrazioni Contabili", "Impossibile eliminare la registrazione.")
			ELSE 
				
				
				
				LONG LL_RIF_SCRITTURA
				SELECT QUOTA_RAT_RIS, STORNO
				  INTO :LS_QUOTA_RAT_RIS, :LS_STORNO
				  FROM GES_RATEI_RISCONTI
				  WHERE RIF_SCRITTURA=:ll_IDReg_PD AND
						  (STORNO='S' OR QUOTA_RAT_RIS='S');
				 IF SQLCA.SQLCODE=0 THEN
					 IF LS_QUOTA_RAT_RIS='S' OR LS_STORNO='S' THEN
						MESSAGEBOX ('ATTENZIONE', 'Sono stati gestiti Ratei/Risconti')
						UF_CANCELLA_RISCONTI_STORNI(ll_IDReg_PD)
					 END IF
				 END IF
				
				
				DELETE FROM "ges_ratei_risconti"  
				WHERE "ges_ratei_risconti"."rif_scrittura" = :ll_IDReg_PD   ;
		END IF

		NEXT
		MESSAGEBOX ('OK', 'CANCELLAZIONE COMPLETATA')
		tab_1.tabpage_2.dw_3.retrieve()
	END IF
ELSE
	MESSAGEBOX ('OK','VERIFICA')
END IF

end event

type st_1 from statictext within w_cancella_scritture_cx
integer x = 389
integer y = 280
integer width = 1833
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean italic = true
long backcolor = 79741120
boolean enabled = false
string text = "Cancellazione in cascata di più scritture, non stampate sui registri bollati"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

