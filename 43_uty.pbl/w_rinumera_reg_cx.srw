forward
global type w_rinumera_reg_cx from w_wiz_main
end type
type cb_ok from commandbutton within w_rinumera_reg_cx
end type
type cb_annulla from commandbutton within w_rinumera_reg_cx
end type
type dw_1 from u_dw_ext_main within w_rinumera_reg_cx
end type
end forward

global type w_rinumera_reg_cx from w_wiz_main
int Width=1851
int Height=968
WindowType WindowType=response!
boolean TitleBar=true
string Title="Stampa Registri IVA - AGHI"
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
cb_ok cb_ok
cb_annulla cb_annulla
dw_1 dw_1
end type
global w_rinumera_reg_cx w_rinumera_reg_cx

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

on w_rinumera_reg_cx.create
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

on w_rinumera_reg_cx.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.cb_annulla)
destroy(this.dw_1)
end on

event open;call super::open;


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
END IF


end event

event closequery;call super::closequery;

end event

type cb_ok from commandbutton within w_rinumera_reg_cx
event clicked pbm_bnclicked
int X=50
int Y=40
int Width=261
int Height=84
int TabOrder=20
boolean BringToTop=true
string Text="Rinumera"
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;integer ll_reg
ll_reg=dw_1.getitemnumber(1,'numero_registro')

openwithparm(w_numera_gd,ll_reg)
end event

type cb_annulla from commandbutton within w_rinumera_reg_cx
int X=343
int Y=40
int Width=261
int Height=84
int TabOrder=30
boolean BringToTop=true
string Text="Annulla"
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

Close(Parent)
end event

type dw_1 from u_dw_ext_main within w_rinumera_reg_cx
event type integer ue_tipo_reg ( )
int X=23
int Y=160
int Width=1751
int Height=672
int TabOrder=10
string DataObject="d_rinumera_ff"
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

