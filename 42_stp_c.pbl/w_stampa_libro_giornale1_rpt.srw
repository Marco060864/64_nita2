forward
global type w_stampa_libro_giornale1_rpt from w_wiz_main
end type
type cb_annulla from commandbutton within w_stampa_libro_giornale1_rpt
end type
type dw_1 from u_dw_ext_main within w_stampa_libro_giornale1_rpt
end type
type st_1 from statictext within w_stampa_libro_giornale1_rpt
end type
type cb_1 from commandbutton within w_stampa_libro_giornale1_rpt
end type
type cb_stampa from commandbutton within w_stampa_libro_giornale1_rpt
end type
end forward

global type w_stampa_libro_giornale1_rpt from w_wiz_main
integer x = 1106
integer y = 400
integer width = 2395
integer height = 1308
string title = "Stampa Libro Giornale Contabile"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
cb_annulla cb_annulla
dw_1 dw_1
st_1 st_1
cb_1 cb_1
cb_stampa cb_stampa
end type
global w_stampa_libro_giornale1_rpt w_stampa_libro_giornale1_rpt

type variables
date		id_data_registrazione
s_con_effetti	istr_struct
boolean		ib_feed_struct = FALSE



end variables

forward prototypes
public function boolean uf_controlla_data (date ad_data_registrazione)
public subroutine uf_blocca_scritture ()
public subroutine uf_conferma_stampa ()
end prototypes

public function boolean uf_controlla_data (date ad_data_registrazione);

long ll_id_esercizio
boolean lb_RetVal = FALSE

SELECT esercizio.id_esercizio
	INTO :ll_id_esercizio
	FROM dba.esercizio
	WHERE (esercizio.data_inizio <= :ad_data_registrazione) AND
			(esercizio.data_fine >= :ad_data_registrazione)
	USING SQLCA;
	
CHOOSE CASE SQLCA.SQLCode
	CASE 0
		lb_RetVal = TRUE
END CHOOSE

RETURN lb_RetVal
end function

public subroutine uf_blocca_scritture ();


date ld_ult_data, ld_fino_data
long ll_id_reg_pd

ld_ult_data=dw_1.getitemdate(1,"ult_data")
ld_fino_data=dw_1.getitemdate(1,"fino_data")

IF isnull(ld_ult_data) THEN
   ld_ult_data=date("1968/01/01")
END IF

 DECLARE reg_pd_cur CURSOR FOR  
  SELECT "reg_pd"."id_reg_pd"  
    FROM "reg_pd"  
   WHERE ( "reg_pd"."data_registrazione" > :ld_ult_data ) AND  
         ( "reg_pd"."data_registrazione" <= :ld_fino_data ) AND  
         ( "reg_pd"."st_stampa_bollato" = 'N' )   ;
			
			
OPEN reg_pd_cur;

FETCH reg_pd_cur INTO :ll_id_reg_pd;

DO WHILE SQLCA.SQLCODE=0 
   IF SQLCA.SQLCODE=0 THEN 
	   
	   UPDATE reg_pd
		   SET st_stampa_bollato = 'I'
		 WHERE id_reg_pd=:ll_id_reg_pd;
		 
		
		
	   UPDATE mov_contabile
		   SET st_stampa_bollato = 'I'
		 WHERE id_reg_pd=:ll_id_reg_pd;
		 
   END IF
	FETCH reg_pd_cur INTO :ll_id_reg_pd;
LOOP

CLOSE reg_pd_cur;

end subroutine

public subroutine uf_conferma_stampa ();

open(w_attesa)

long ll_id_reg_pd, ll_id_mov_contabile, ll_num_prog, ll_max_prog, ll_id_esercizio
decimal ld_max_saldo_dare, ld_riporto
date ld_fino_data

ld_fino_data=dw_1.getitemdate(1,"fino_data")
ll_id_esercizio=dw_1.getitemnumber(1,"id_esercizio")

DECLARE libro_cur CURSOR FOR  
SELECT "libro_giornale"."id_reg_pd",  
       "libro_giornale"."id_mov_contabile",  
       "libro_giornale"."num_prog"
  FROM "libro_giornale"  
 USING SQLCA;

OPEN libro_cur;

FETCH libro_cur INTO :ll_id_reg_pd,:ll_id_mov_contabile,:ll_num_prog; 

DO WHILE SQLCA.SQLCODE=0 
	IF SQLCA.SQLCODE=0 THEN
		
	   UPDATE mov_contabile
		   SET st_stampa_bollato='S',
			    st_data_bollato=:ld_fino_data,
				 prog_stampato=:ll_num_prog
		 WHERE id_mov_contabile=:ll_id_mov_contabile;
	END IF
   FETCH libro_cur INTO :ll_id_reg_pd,:ll_id_mov_contabile,:ll_num_prog; 	
LOOP
CLOSE libro_cur;

UPDATE reg_pd
SET st_stampa_bollato='S',
	 st_data_bollato=:ld_fino_data
WHERE st_stampa_bollato='I';

SELECT max (num_prog)
  INTO :ll_max_prog
  FROM libro_giornale;

SELECT max (saldo_dare)
  INTO :ld_max_saldo_dare
  FROM libro_giornale;
 
SELECT riporto
  INTO :ld_riporto
  FROM esercizio
  WHERE id_esercizio=:ll_id_esercizio;
 

ld_max_saldo_dare=ld_max_saldo_dare+ld_riporto
UPDATE esercizio
SET num_progressivo=:ll_max_prog,
	 ult_data_stampa_bollato=:ld_fino_data,
	 riporto=:ld_max_saldo_dare
WHERE id_esercizio=:ll_id_esercizio;


delete from libro_giornale;


  
  

end subroutine

on w_stampa_libro_giornale1_rpt.create
int iCurrent
call super::create
this.cb_annulla=create cb_annulla
this.dw_1=create dw_1
this.st_1=create st_1
this.cb_1=create cb_1
this.cb_stampa=create cb_stampa
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_annulla
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.cb_stampa
end on

on w_stampa_libro_giornale1_rpt.destroy
call super::destroy
destroy(this.cb_annulla)
destroy(this.dw_1)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.cb_stampa)
end on

event open;call super::open;



datawindowchild ldw_id_esercizio, ldw_mod_reg, ldw_reg

dw_1.getchild("id_registro",ldw_reg)
ldw_reg.settransobject(sqlca)
ldw_reg.retrieve()

dw_1.getchild("id_esercizio",ldw_id_esercizio)
ldw_id_esercizio.settransobject(sqlca)
ldw_id_esercizio.retrieve()

dw_1.getchild("mod_reg",ldw_mod_reg)
ldw_mod_reg.settransobject(sqlca)
ldw_mod_reg.retrieve()

IF dw_1.GetRow() = 0 THEN
	dw_1.InsertRow(0)
END IF

long ll_id_esercizio_proposto, ll_num_prog
date ld_ult_data

  SELECT "azienda"."id_esercizio_proposto"  
    INTO :ll_id_esercizio_proposto  
    FROM "azienda"  
   WHERE "azienda"."id_azienda" = 1   ;

  SELECT "esercizio"."ult_data_stampa_bollato", 
         "esercizio"."num_progressivo"  
    INTO :ld_ult_data,   
         :ll_num_prog 
    FROM "esercizio"  
   WHERE "esercizio"."id_esercizio" = :ll_id_esercizio_proposto   ;
	
ld_ult_data=relativedate(ld_ult_data,1)	

dw_1.setitem(1,"id_esercizio",ll_id_esercizio_proposto)
dw_1.setitem(1,"ult_progress",ll_num_prog )
dw_1.setitem(1,"ult_data",ld_ult_data)	

	


end event

event closequery;call super::closequery;

end event

type cb_annulla from commandbutton within w_stampa_libro_giornale1_rpt
integer x = 343
integer y = 40
integer width = 261
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Annulla"
boolean cancel = true
end type

event clicked;

Close(Parent)
end event

type dw_1 from u_dw_ext_main within w_stampa_libro_giornale1_rpt
integer x = 50
integer y = 284
integer width = 2267
integer height = 856
integer taborder = 10
string dataobject = "d_libro_giornale1_rpt"
end type

event itemchanged;

long ll_id_esercizio_proposto, ll_num_prog, ll_registro
date ld_ult_data, ld_data_inizio
string ls_tipo_reg

IF dwo.Name = "id_esercizio" THEN
	
   ll_id_esercizio_proposto=dec(data)
	
  
  SELECT "esercizio"."ult_data_stampa_bollato", 
         "esercizio"."num_progressivo", "esercizio"."data_inizio"  
    INTO :ld_ult_data,   
         :ll_num_prog, :ld_data_inizio 
    FROM "esercizio"  
   WHERE "esercizio"."id_esercizio" = :ll_id_esercizio_proposto   ;

	if isnull(ld_ult_data) then
	   ld_ult_data=ld_data_inizio
	else	
	   ld_ult_data=relativedate(ld_ult_data,1)
	end if
	
	
	
	dw_1.setitem(1,"id_esercizio",ll_id_esercizio_proposto)
	dw_1.setitem(1,"ult_progress",ll_num_prog )
	dw_1.setitem(1,"ult_data",ld_ult_data)	

END IF

IF dwo.Name = "manageriale" THEN
	ll_id_esercizio_proposto=dw_1.getitemnumber(1, "id_esercizio")
	if ll_id_esercizio_proposto>0 then
		ls_tipo_reg=data+'N'
		select first(id_registro)
		into :ll_registro
		from dba.registro
		where id_esercizio=:ll_id_esercizio_proposto
		and tipo_registro=:ls_tipo_reg
		;
		if ll_registro>0 then
			dw_1.setitem(1,'id_registro',ll_registro)
		end if
	end if
end if

if dwo.name = "password" then
	if data='cometa' then
		dw_1.object.num_def.visible=true
		dw_1.object.mod_reg.visible=true
		dw_1.object.password.visible=false
	end if
end if	
		
if dwo.name = "ela_def" then
	if data='N' then
		dw_1.setitem(1,'num_def','N')
		dw_1.setitem(1,'password','')
		dw_1.object.num_def.visible=FALSE
		dw_1.object.mod_reg.visible=FALSE
		dw_1.object.password.visible=TRUE
	end if
end if		
		
	




	



end event

type st_1 from statictext within w_stampa_libro_giornale1_rpt
integer x = 55
integer y = 144
integer width = 1627
integer height = 132
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
string text = "Immettere la data della registrazione contabile fino alla quale si desidera stampare il Libro Giornale."
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_stampa_libro_giornale1_rpt
boolean visible = false
integer x = 841
integer y = 32
integer width = 261
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stampa "
end type

event clicked;


open(w_attesa)

string ls_ela_def, flag_sbil
ls_ela_def=dw_1.getitemstring(1,"ela_def")


integer li_rispo
IF ls_ela_def = 'S' THEN 
OpenWithParm(w_stampa_libro_giornale2_rpt,ls_ela_def)
	li_rispo=messagebox("Conferma Stampa","La Stampa è andata a buon fine?",question!,yesno!)
   end if 
end event

type cb_stampa from commandbutton within w_stampa_libro_giornale1_rpt
integer x = 55
integer y = 40
integer width = 261
integer height = 84
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stampa"
end type

event clicked;dw_1.accepttext()

st_lib_giornale lst_lib_giornale

integer a
a=0

dw_1.accepttext()
lst_lib_giornale.sl_id_esercizio=dw_1.getitemnumber(1, "id_esercizio")
lst_lib_giornale.ss_elab_definitiva=dw_1.getitemstring(1, "ela_def")
if lst_lib_giornale.ss_elab_definitiva='S' then
	lst_lib_giornale.sdt_da_data=dw_1.getitemdate(1, "ult_data")
	if isnull(lst_lib_giornale.sdt_da_data) then a=1
	
	
	
	if dw_1.getitemstring(1, "num_def")='S' and dw_1.getitemstring(1, "password")='cometa' then
		lst_lib_giornale.d_num=dw_1.getitemnumber(1, "da_numero")
		lst_lib_giornale.a_num=dw_1.getitemnumber(1, "a_numero")
		lst_lib_giornale.mod_reg=dw_1.getitemnumber(1, "mod_reg")
	else	
		lst_lib_giornale.d_num=1
		lst_lib_giornale.a_num=99999999
		lst_lib_giornale.mod_reg=9999
	end if	
	
else
	lst_lib_giornale.sdt_da_data=dw_1.getitemdate(1, "da_data")
	if isnull(lst_lib_giornale.sdt_da_data) then a=1
	
	lst_lib_giornale.d_num=dw_1.getitemnumber(1, "da_numero")
	if isnull(lst_lib_giornale.d_num) then lst_lib_giornale.d_num=1
	lst_lib_giornale.a_num=dw_1.getitemnumber(1, "a_numero")
	if isnull(lst_lib_giornale.a_num) then lst_lib_giornale.a_num=99999999
	
	lst_lib_giornale.mod_reg=dw_1.getitemnumber(1, "mod_reg")
	if isnull(lst_lib_giornale.mod_reg) then lst_lib_giornale.mod_reg=9999
	
	
end if
lst_lib_giornale.sdt_a_data=dw_1.getitemdate(1, "fino_data")
if isnull(lst_lib_giornale.sdt_a_data) then a=1
lst_lib_giornale.las_aghi=dw_1.getitemstring(1,'tipo_stp')
lst_lib_giornale.ordinamento=dw_1.getitemstring(1,'ordinamento')

lst_lib_giornale.ord_testa=dw_1.getitemstring(1,'ord_testa')

lst_lib_giornale.manageriale=dw_1.getitemstring(1,'manageriale')
if a=1 or lst_lib_giornale.sdt_a_data<lst_lib_giornale.sdt_da_data then 
	messagebox('Attenzione','Una le date non è stata inerita correttamente')
	return 1
end if

lst_lib_giornale.id_registro=dw_1.getitemnumber(1, "id_registro")
if  isnull(lst_lib_giornale.id_registro) or lst_lib_giornale.id_registro=0 then 
	messagebox('Attenzione','Occorre indicare il registro!')
	return 1
end if
openwithparm(w_stampa_libro_giornale2_rpt, lst_lib_giornale)






end event

