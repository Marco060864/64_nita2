forward
global type w_stampa_reg_iva_rpt from w_wiz_main
end type
type cb_ok from commandbutton within w_stampa_reg_iva_rpt
end type
type cb_annulla from commandbutton within w_stampa_reg_iva_rpt
end type
type dw_1 from u_dw_ext_main within w_stampa_reg_iva_rpt
end type
end forward

global type w_stampa_reg_iva_rpt from w_wiz_main
integer width = 2171
integer height = 1188
string title = "Stampa Registri IVA - AGHI"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
cb_ok cb_ok
cb_annulla cb_annulla
dw_1 dw_1
end type
global w_stampa_reg_iva_rpt w_stampa_reg_iva_rpt

type variables
date		id_data_registrazione
s_con_effetti	istr_struct
boolean		ib_feed_struct = FALSE

long il_id_esercizio
date il_data_da
date il_data_a
integer ii_tab_seq
integer ii_tab_seq_num
date il_data_da_esr
date il_data_a_esr
string is_tipo_reg
date ld_ist_prop_iniziale 
date ld_ist_prop_finale
end variables

forward prototypes
public function date uf_prossimo_mese (readonly date data_attuale)
public subroutine wf_tutti_registri ()
public function string uf_controlla_dati (string as_tipo_reg, date adt_data_inizio, string as_tutti_reg, long al_num_reg, long al_id_esercizio, date adt_inizio_es, date adt_fine_es, long al_id_attivita)
end prototypes

public function date uf_prossimo_mese (readonly date data_attuale);integer mese,anno,day,giorni_mese
date nuova_data
anno=year(data_attuale)
mese=month(data_attuale)
if mese=12 then
	mese=1
	anno=anno+1
else
mese=mese+1
end if
day=day(data_attuale)


giorni_mese=f_gmese(mese,anno)
if day>giorni_mese then
	day=giorni_mese
end if

nuova_data=date(string(day)+"/"+string(mese)+"/"+string(anno))
nuova_data=relativedate(nuova_data, -1)
return nuova_data
end function

public subroutine wf_tutti_registri ();

string ls_tipo_registro,ls_tutti
long ll_id_esercizio,ll_id_attivita, ll_null
date_stampa_parametri str_param
str_date_prop str_date
date ld_data_prop_iniziale, ld_data_prop_finale
string mai_stampato,periodo
setnull(ll_null)
ls_tipo_registro=dw_1.getitemstring(1,"tipo_registro")					
ll_id_esercizio=dw_1.getitemnumber(1,"registro")
ls_tutti=dw_1.getitemstring(1,"tutti_reg")
if not isnull(ls_tipo_registro) and not isnull(ll_id_esercizio) and ls_tutti='S' then
	str_param.id_esercizio=ll_id_esercizio
	str_param.tipologia=ls_tipo_registro
	
	
	openwithparm (w_date_stampa_registri_iva,str_param)			
	str_date=message.powerobjectparm
	ld_data_prop_iniziale=str_date.data_prop_iniziale
	mai_stampato=str_date.mai_stampato
	if isnull(ld_data_prop_iniziale) then 
		dw_1.setitem(1,"tutti_reg",'N')
		dw_1.setitem(1,"numero_registro",ll_null)
	end if	
	ld_data_prop_finale=uf_prossimo_mese(ld_data_prop_iniziale)
	
	dw_1.setitem(1,"dalla_data",ld_data_prop_iniziale)			
	dw_1.setitem(1,"alla_data",ld_data_prop_finale)	
	ld_ist_prop_iniziale=ld_data_prop_iniziale
	ld_ist_prop_finale=ld_data_prop_finale
		
end if

end subroutine

public function string uf_controlla_dati (string as_tipo_reg, date adt_data_inizio, string as_tutti_reg, long al_num_reg, long al_id_esercizio, date adt_inizio_es, date adt_fine_es, long al_id_attivita);
long ll_id_registro, ll_id_registro_zero
date ldt_ult_data


if as_tutti_reg='S' then
	
	
	select id_registro
	into :ll_id_registro_zero
	from registro
	where numero=0
	and id_esercizio=:al_id_esercizio
	and id_attivita=:al_id_attivita
	and tipo_registro=:as_tipo_reg;
	
	if sqlca.sqlcode<>0 then
		messagebox("Attenzione!", "Registro numero '0' non trovato!")
		return 'NO'
	end if
	
	select ultima_data
	into :ldt_ult_data
	from contatori_registri
	where id_registro=:ll_id_registro_zero
	and	tipologia=:as_tipo_reg
	and ultima_data>=:adt_inizio_es
	and ultima_data<=:adt_fine_es;
	if sqlca.sqlcode<>0 then
		if sqlca.sqlcode<>100 then 
			messagebox("Attenzione!", "Data di riferimento non trovata. Errori nei dati inseriti!")
		else
			return 'OK'
			
		end if
	end if
	
else
	select id_registro
	into :ll_id_registro
	from registro
	where numero=:al_num_reg
	and tipo_registro=:as_tipo_reg
	and id_esercizio=:al_id_esercizio;
	if sqlca.sqlcode=0 then
		select ultima_data
		into :ldt_ult_data
		from contatori_registri
		where id_registro=:ll_id_registro;
	else 
		messagebox("Attenzione!", "Controllo su scritture già stampate fallito: registro non trovato! (riga 26, uf_controlla_dati)")
	end if
end if
if sqlca.sqlcode=0 then
	if day(ldt_ult_data)=1 and month(ldt_ult_data)=1 then 
		if adt_data_inizio>=ldt_ult_data then
			return 'OK'
		else
			messagebox("Attenzione!", "Esistono scritture già stampate nell'intervallo di tempo designato. Stampa annullata!")
		end if
	else
		if adt_data_inizio>ldt_ult_data then
			return 'OK'
		else
			messagebox("Attenzione!", "Esistono scritture già stampate nell'intervallo di tempo designato. Stampa annullata!")
		end if
	end if
elseif sqlca.sqlcode=100 then
	return 'OK'
	
end if
return 'NO'

end function

on w_stampa_reg_iva_rpt.create
int iCurrent
call super::create
this.cb_ok=create cb_ok
this.cb_annulla=create cb_annulla
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ok
this.Control[iCurrent+2]=this.cb_annulla
this.Control[iCurrent+3]=this.dw_1
end on

on w_stampa_reg_iva_rpt.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.cb_annulla)
destroy(this.dw_1)
end on

event open;call super::open;long ll_id_attivita, ll_id_ese
datawindowchild ldw_registro, ldw_tipo_reg, ldw_num_reg,ldw_attivita

dw_1.getchild("id_attivita",ldw_attivita)
ldw_attivita.settransobject(sqlca)
ldw_attivita.retrieve()


dw_1.getchild("registro",ldw_registro)
ldw_registro.settransobject(sqlca)
ldw_registro.retrieve()



dw_1.getchild("tipo_registro",ldw_tipo_reg)
ldw_tipo_reg.settransobject(sqlca)
ldw_tipo_reg.retrieve()

IF dw_1.GetRow() = 0 THEN
	dw_1.InsertRow(0)
	select id_attivita
	into :ll_id_attivita
	from dba.attivita
	;
	if ll_id_attivita>0 then
		dw_1.setitem(1, "id_attivita", ll_id_attivita)
	end if
	select id_esercizio
	into :ll_id_ese
	from dba.azienda
	;
	if ll_id_ese>0 then
		dw_1.setitem(1, "registro", ll_id_ese)
		dw_1.trigger event itemchanged(1, dw_1.object.registro, string(ll_id_ese))
	end if
END IF



end event

event closequery;call super::closequery;

end event

type cb_ok from commandbutton within w_stampa_reg_iva_rpt
event clicked pbm_bnclicked
integer x = 27
integer y = 44
integer width = 261
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stampa"
boolean cancel = true
end type

event clicked;
string ls_tipo_registro,ls_flag_registri,ls_filtro,ls_flag_definitiva,ls_ret, ls_ripristino
long ll_row,ll_n_registro,ll_id_attivita,ll_id_esercizio,ll_id_registro, ll_n_registro2
date ld_dalla_data,ld_alla_data, ld_ripristino
long ll_io,ll_ret
date d_data_in, d_data_fi, 	d_data_in_1, d_data_fi_1
reg_iva_parametri str_param
string ls_io
dw_1.accepttext()
ll_row=dw_1.getrow()
ls_tipo_registro=dw_1.getitemstring(ll_row,"tipo_registro")
ld_dalla_data=dw_1.getitemdate(ll_row,"dalla_data")
ld_alla_data=dw_1.getitemdate(ll_row,"alla_data")
ls_flag_registri=dw_1.getitemstring(ll_row,"tutti_reg")
ll_n_registro=dw_1.getitemnumber(ll_row,"numero_registro")
ls_flag_definitiva=dw_1.getitemstring(ll_row,"elab_prova")
ls_ripristino=dw_1.getitemstring(ll_row,"elab_rip")
ld_ripristino=dw_1.getitemdate(ll_row,"data_ripristino")
if ls_ripristino='S' and isnull(ld_ripristino) then
	messagebox('ATTENZIONE','Immetere la data da cui ripartire a stampre il registro!')
	return
end if	
if ls_ripristino='S' then
	ll_ret=messagebox('ATTENZIONE',"Prima di proseguire è opportuno sistemare l'ultimo protocollo stampato~r~n sui contatori registri", Information!, YesNo!)
	if ll_ret=1 then return
end if	
ll_id_attivita=dw_1.getitemnumber(1,"id_attivita")
ls_ret='OK'

ll_id_esercizio=dw_1.getitemnumber(1,"registro")

long ll_righe, ll_contr, ll_rec_righe, ll_found, ll_prog_mancante
integer i_i

//DATASTORE ds_controllo  
//ds_controllo = CREATE DATASTORE
//ds_controllo.DATAOBJECT = "ds_contr_prot_iva"
//ds_controllo.SETTRANSOBJECT(SQLCA)
//ds_controllo.RETRIEVE(ls_tipo_registro, ld_dalla_data, ld_alla_data, ll_id_esercizio)
//
//ll_rec_righe= ds_controllo.Rowcount()
//if ll_rec_righe > 0 then
//	
//	ll_contr = ds_controllo.getitemnumber(ll_rec_righe, "controllo")
//	
//	if ll_contr = 0 then
//		messagebox ('Attenzione', 'Errore nella consecutivita~ dei protocolli')
//		ll_found = ds_controllo.Find("discriminante= 9999", 1, ll_rec_righe)
//		ll_prog_mancante= ds_controllo.getitemnumber(ll_found, "progressivo")
//		messagebox ('Progressivo Mancante', 'Controllare il n. ' + string(ll_prog_mancante))
//		
//	end if
//end if

//DESTROY ds_controllo

ll_io=dw_1.getitemnumber(1,"registro")
select "esercizio"."data_inizio","esercizio"."data_fine"
into :d_data_in,:d_data_fi
from "dba"."esercizio"
where "esercizio"."id_esercizio"=:ll_io;


d_data_in_1=dw_1.getitemdate(1,"dalla_data")
d_data_fi_1=dw_1.getitemdate(1,"alla_data")

if (d_data_in_1 < d_data_in) or (d_data_fi_1 < d_data_in) or (d_data_fi_1 < d_data_in_1) or (d_data_in_1 > d_data_fi) or (d_data_fi_1 > d_data_fi) then
	messagebox("Messaggio di errore","Le date inserite non sono corrette   "&
   + "REINSERIRE")
	return
end if
if ls_flag_definitiva="S" then
	
	if ls_flag_registri='S' then ll_n_registro=0
	
	ls_ret=uf_controlla_dati(ls_tipo_registro, d_data_in_1,ls_flag_registri, ll_n_registro, ll_id_esercizio,d_data_in, d_data_fi,ll_id_attivita )
	if ls_ret='OK' then 
		if ls_flag_registri='N' then
		
		else 
		end if
	else 
		Messagebox("Controllo","Impossibile stampare i registri selezionati, i dati risultano bloccati" )
	end if
end if

if ls_flag_registri="S" then 
	ls_filtro=""
else
	ls_filtro="numero= "+string(ll_n_registro)
end if

if ls_ret='OK' then
	ls_tipo_registro=dw_1.getitemstring(1,"tipo_registro")
 	ll_n_registro=dw_1.getitemnumber(1,"numero_registro")
  	ll_n_registro2=dw_1.getitemnumber(1,"numero_registro")
 	
	if isnull (ll_n_registro) then 
		ll_n_registro = 0
		ll_n_registro2 = 1000
	end if
	select "registro"."id_registro"
	into :ll_id_registro
	from "registro"
	where ("registro"."tipo_registro"=:ls_tipo_registro)and
	("registro"."id_attivita"=:ll_id_attivita)and
	(("registro"."numero">=:ll_n_registro) and ("registro"."numero"<=:ll_n_registro2))and
	("registro"."id_esercizio"=:ll_id_esercizio);
	
	str_param.tipo_registro=ls_tipo_registro
	str_param.dalla_data=ld_dalla_data
	str_param.alla_data=ld_alla_data
	str_param.ls_filtro=ls_filtro
	str_param.ls_flag_definitiva=ls_flag_definitiva
	str_param.ll_n_registro=ll_n_registro
	str_param.ll_id_registro=ll_id_registro
	str_param.ll_id_attivita=ll_id_attivita
	str_param.ll_id_esercizio=ll_id_esercizio
	str_param.tutti_registri=ls_flag_registri
   str_param.las_aghi=dw_1.getitemstring(1,'tipo_stp')
   
	str_param.flag_ripristino=ls_ripristino
	str_param.data_ripristino=ld_ripristino
   
	openwithparm(w_stampa_registri_iva,str_param)
	
	
string ls_ritorno
ls_ritorno = Message.StringParm
 if ls_ritorno='N' then
	if ls_flag_registri='N'then
	else
	end if
		ll_n_registro=dw_1.getitemnumber(1,"numero_registro")
		ll_n_registro=dw_1.getitemnumber(1,"numero_registro")
 end if	
end if 










end event

type cb_annulla from commandbutton within w_stampa_reg_iva_rpt
integer x = 343
integer y = 44
integer width = 261
integer height = 84
integer taborder = 30
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

type dw_1 from u_dw_ext_main within w_stampa_reg_iva_rpt
event type integer ue_tipo_reg ( )
integer x = 23
integer y = 160
integer width = 2089
integer height = 912
integer taborder = 10
string dataobject = "d_registri_iva_rpt"
end type

event ue_tipo_reg;call super::ue_tipo_reg;long						ll_ret,ll_num,ll_id_attivita
datawindowchild		ldw_child,ldw_des

SetNull(ll_num)

this.AcceptText()
ll_id_attivita=this.getitemnumber(1,"id_attivita")
this.GetChild("Numero_registro", ldw_child)
this.GetChild("descrizione", ldw_des)
this.SetItem( this.GetRow(),"Numero_registro",ll_num )
ldw_child.SetTransObject(SQLCA)
ldw_child.Retrieve(is_tipo_reg, il_id_esercizio,ll_id_attivita)
ldw_des.SetTransObject(SQLCA)
ldw_des.Retrieve(is_tipo_reg, il_id_esercizio,ll_id_attivita)
return 0
end event

event itemchanged;
integer li_anno, li_mese, li_ret
string ls_def, ls_flag_tutti,ls_flag_definitiva,ls_tipo_registro,periodo,ls_data_prop_iniziale,mai_stampato
long ll_n_registro,ll_id_attivita,ll_id_registro,ll_id_esercizio
date_stampa_parametri str_param
str_date_prop str_date
this.accepttext()

ls_tipo_registro=dw_1.getitemstring(1,"tipo_registro")
ll_n_registro=dw_1.getitemnumber(1,"numero_registro")
ll_id_attivita=dw_1.getitemnumber(1,"id_attivita")
ll_id_esercizio=dw_1.getitemnumber(1,"registro")
ls_flag_definitiva=this.getitemstring(1,"elab_prova")
ls_flag_tutti=this.getitemstring(1,"tutti_reg")

datawindowchild		ldw_child
this.GetChild("Numero_registro", ldw_child)

CHOOSE CASE dwo.Name
	
   CASE "registro"
	   	parent.cb_ok.enabled=true
		   il_id_esercizio = Long(data)
		   THIS.TriggerEvent("ue_tipo_reg")
         wf_tutti_registri()
			
	CASE "tipo_registro"
		   parent.cb_ok.enabled=true
		   is_tipo_reg = data
		   THIS.TriggerEvent("ue_tipo_reg")
	      wf_tutti_registri()
	
   CASE "numero_registro"
		   parent.cb_ok.enabled=true
		   this.Accepttext()
         select id_registro into :ll_id_registro
			from registro
			where tipo_registro=:ls_tipo_registro 
			  and id_attivita=:ll_id_attivita 
			  and numero=:ll_n_registro 
			  and id_esercizio=:ll_id_esercizio;
				
		   select max(ultima_data)
			into :ld_ist_prop_iniziale
			from  contatori_registri
			where tipologia=:ls_tipo_registro
			  and id_attivita=:ll_id_attivita
			  and id_registro=:ll_id_registro;	
				
			if sqlca.SQLCode = 100 then
				MessageBox("ricerca data", &
					"registro mai stampato")
		   elseif sqlca.SQLCode > 0 then
				MessageBox("Database Error", &
				sqlca.SQLErrText, Exclamation!)
			end if
		   
		   if isnull(ld_ist_prop_iniziale) then
				select data_inizio
				into :ld_ist_prop_iniziale
				from esercizio
				where id_esercizio=:ll_id_esercizio;
		   else	
				ld_ist_prop_iniziale=relativedate(ld_ist_prop_iniziale,1)
		   end if
				
		   this.setitem(1,"dalla_data",ld_ist_prop_iniziale)
		   li_anno=year(ld_ist_prop_iniziale)
		   li_mese=month(ld_ist_prop_iniziale)
		   li_ret=f_gmese(li_mese,li_anno)
		   ld_ist_prop_finale=date(string(li_ret)+"/"+string(li_mese)+"/"+string(li_anno))
				
		   select liq_iva
			into :periodo
			from attivita
			where id_attivita=:ll_id_attivita;
		   if periodo='T' then
				ld_ist_prop_finale=uf_prossimo_mese(ld_ist_prop_iniziale)
				ld_ist_prop_finale=uf_prossimo_mese(ld_ist_prop_finale)
			end if	
		   this.setitem(1,"alla_data",ld_ist_prop_finale)
						
			
	CASE "tutti_reg"
			parent.cb_ok.enabled=true
			this.accepttext()
			
		   post	wf_tutti_registri()
			if ldw_child.Find("numero=0", 1, ldw_child.rowcount()  )>0 then this.setitem(1,'numero_registro',0) 	
			
			

   CASE "elab_prova"
			parent.cb_ok.enabled=true
			this.accepttext()
			if data='S'and not isnull(this.getitemnumber(1,'numero_registro')) then
				
				if  ldw_child.Find("numero=0", 1, ldw_child.rowcount()  )>0 and ll_n_registro<>0 then
					messagebox('Attenzione','Non è possibile stampare questo registro singolarmente!~r~nSelezionare tutti i registri.')
				   return 2
				end if
				
								
				this.setitem(1,"dalla_data",ld_ist_prop_iniziale)
				if dw_1.getitemdate(1,"alla_data")<ld_ist_prop_iniziale then dw_1.setitem(1,"alla_data",ld_ist_prop_finale)
			end if
		
 END CHOOSE
 
 


end event

event itemfocuschanged;call super::itemfocuschanged;



end event

