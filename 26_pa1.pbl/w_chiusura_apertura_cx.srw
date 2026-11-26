forward
global type w_chiusura_apertura_cx from Window
end type
type cb_2 from commandbutton within w_chiusura_apertura_cx
end type
type cb_1 from commandbutton within w_chiusura_apertura_cx
end type
type dw_1 from u_dw_ext_main within w_chiusura_apertura_cx
end type
end forward

global type w_chiusura_apertura_cx from Window
int X=1010
int Y=604
int Width=2213
int Height=832
boolean TitleBar=true
string Title="Chiusura dei Conti"
long BackColor=79741120
boolean ControlMenu=true
WindowType WindowType=response!
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_chiusura_apertura_cx w_chiusura_apertura_cx

type variables
long il_prof
string is_modo,is_es
long ll_id1,ll_id2,ll_id3,ll_id4
end variables

on w_chiusura_apertura_cx.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_chiusura_apertura_cx.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;
dw_1.insertrow(0)
datawindowchild ldc_es,ldc_es1,ldc_es2
long rtncode
string ls_cod,ls_des
date ldat_data
rtncode=dw_1.getchild('id_esercizio',ldc_es)
if rtncode= -1 then 
	messagebox("Errore","Errore di assegnazione della dw child")
end if
ldc_es.settransobject(sqlca)
ldc_es.retrieve()

s_list_main is_par
is_par = Message.PowerObjectParm
is_modo=is_par.s_win_parametri

long ll_con
if is_par.s_win_parametri='C' then 
	
	messagebox('Attenzione','Prima di procedere con la chiusura definitiva è opportuno eseguire ~r~nil ricalcolo dei saldi mensili!')
	this.title='Chiusura dei Conti'
	select prof_registrazione.codice,prof_registrazione.descrizione,prof_registrazione.id_prof_registrazione
	into :ls_cod,:ls_des,:il_prof
	from prof_registrazione,par_sistema
	where prof_registrazione.id_prof_registrazione=par_sistema.id_prof_reg_chiusura;

	select id_conto_utile_sp,id_conto_utile_ce,id_conto_perdite_sp,id_conto_perdite_ce
	into :ll_id1,:ll_id2,:ll_id3,:ll_id4
	from par_sistema;
	ll_con=ll_id1+ll_id2+ll_id3+ll_id4
	if isnull(ll_con) then
		messagebox("Informazione","Non sono stati impostati i conti in parametri di sistema")
		cb_1.enabled=false
	end if
	ldat_data=date('31/12/'+string(year(today())))
	dw_1.setitem(1,"data_c",ldat_data)
else
	this.title='Apertura dei Conti'	
	select prof_registrazione.codice,prof_registrazione.descrizione,prof_registrazione.id_prof_registrazione
	into :ls_cod,:ls_des,:il_prof
	from prof_registrazione,par_sistema
	where prof_registrazione.id_prof_registrazione=par_sistema.id_prof_reg_apertura;
	
	select id_conto_utile_sp,id_conto_perdite_sp
	into :ll_id1,:ll_id2
	from par_sistema;
	ll_con=ll_id1+ll_id2
	if isnull(ll_con) then
		messagebox("Informazione","Non sono stati impostati i conti in parametri di sistema")
		cb_1.enabled=false
	end if
	ldat_data=date('01/01/'+string(year(today())))
	dw_1.setitem(1,"data_c",ldat_data)
end if
if sqlca.sqlcode<>0 then 
	messagebox('Errore',"Errore in parametri di sistema.~r~nnon è stato scelto nessun profilo per la chiusura")
else
	dw_1.setitem(1,"prof_reg_cod",ls_cod)
	dw_1.setitem(1,"prof_reg_des",ls_des)	
end if	




end event

event key;

keycode			lk_code
string			ls_nome
windowobject	lw_me

lk_code = key

choose case lk_code
	case KeyF12!
		if keyflags=3 then
			ls_nome = this.ClassName()
			MessageBox ("ClassName",ls_nome)
		end if
	case KeyF1!
		if (keyflags = 0 Or keyflags = 1 Or keyflags = 2) then
		end if
end choose
end event

type cb_2 from commandbutton within w_chiusura_apertura_cx
int X=23
int Y=44
int Width=247
int Height=84
int TabOrder=10
string Text="Annulla"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(parent)
end event

type cb_1 from commandbutton within w_chiusura_apertura_cx
int X=1810
int Y=44
int Width=361
int Height=84
int TabOrder=20
string Text="Simula"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
long ll_id_es,ll_id_reg, ll_num_scr, ll_esercizio_argomento, ll_prof, ll_reg_pd
date ld_date, ld_data_comp
string ls_trasf
ll_id_es=dw_1.getitemnumber(1,"id_esercizio")
ll_esercizio_argomento=ll_id_es
if parent.title='Apertura dei Conti' then
	select data_inizio
	into :ld_date
	from esercizio
	where id_esercizio=:ll_id_es;
	ld_date=relativedate(ld_date, - 1)
	select id_esercizio
	into :ll_esercizio_argomento
	from esercizio
	where data_fine=:ld_date;
end if	
string ls_bloccato
select bloccato 
into :ls_bloccato
from esercizio
where id_esercizio=:ll_id_es;

if ls_bloccato='N' then   
	
	select count(*) 
		into :ll_num_scr
		from saldo_mensile
		where dare_mn <> null or dare_mn <> 0;
	if ll_num_scr = 0 then
		select count(*) 
			into :ll_num_scr
			from saldo_mensile
			where avere_mn <> null or avere_mn <> 0;
	end if
	
	IF ll_num_scr > 0 THEN  
		messagebox ('Attenzione', 'Risultano scritture Manageriali !')
	End if
		
	ll_id_reg=dw_1.getitemnumber(1,"id_registro")
	if not isnull(ll_id_es) and not isnull(ll_id_reg) then  
		open(w_attesa)
		delete from chiusura_apertura;
		if sqlca.sqlcode=0 then
			commit;
		else
			rollback;
			messagebox("Errore!", "Tabella chiusura_apertura non azzerata!")
			
			return
		end if
		date ld_d
		uo_chiusura_apertura lo_sp
		ld_d=dw_1.getitemdate(1,"data_c")
		
		
		
		
		ls_trasf=dw_1.getitemstring(1,"d_fin")
		ld_data_comp=date(ls_trasf)
		lo_sp= create uo_chiusura_apertura 
		if parent.title='Apertura dei Conti' then
			ls_trasf=dw_1.getitemstring(1,"d_in")
			ld_data_comp=date(ls_trasf)
			select id_prof_reg_chiusura
			into :ll_prof
			from par_sistema;
			select min(id_reg_pd)
			into :ll_reg_pd
			from reg_pd
			where id_prof_registrazione=:ll_prof and data_competenza=:ld_date;
			
			
			long ll_val, ll_val_prec
	      select id_valuta into :ll_val from esercizio where id_esercizio=:ll_id_es;
			select id_valuta into :ll_val_prec from esercizio where id_esercizio=:ll_esercizio_argomento;
			
			
			
			
			
			
			
			string ls_cod_az, ls_cod_es
			select codice into :ls_cod_az from azienda;
			select codice into :ls_cod_es from esercizio where id_esercizio=:ll_id_es;
			if ls_cod_az='DUR' and ls_cod_es='01' then
				insert into chiusura_apertura
				   (id_conto, saldo_dare, saldo_avere)
				select id_conto, fn_conv_valuta(:ll_val_prec,avere,:ll_val), fn_conv_valuta(:ll_val_prec,dare,:ll_val)
				from mov_contabile
				where id_reg_pd=:ll_reg_pd or id_reg_pd=:ll_reg_pd + 1;
			else
			
				insert into chiusura_apertura
				       (id_conto, saldo_dare, saldo_avere)
				select id_conto, fn_conv_valuta(:ll_val_prec,avere,:ll_val), fn_conv_valuta(:ll_val_prec,dare,:ll_val) 
				from mov_contabile
				where id_reg_pd=:ll_reg_pd;
			end if	
			
			commit;
			
			
			date ld_dt_inizio
			long ll_conto_euro, ll_test
			decimal ld_imp_euro
			select data_inizio into :ld_dt_inizio from esercizio where id_esercizio=:ll_id_es;
			if year(ld_dt_inizio)=2002 OR (ls_cod_az='DUR' and ls_cod_es='01')  then
				messagebox('Attenzione',"La scittura di apertura di passaggio dall'esercizio in LIRE all'EURO ~r~n"+&
												"potrebbe, a causa della conversione dei singoli movimenti, risultare sbilanciata.~r~n"+&
												"Selezionare un conto di appoggio non movimentato da utilizzare per pareggiare la scrittura!")
												 
				open(w_conto_apertura_euro_ff)
				ll_conto_euro=message.doubleparm
				
				if ls_cod_az='DUR' and ls_cod_es='01' then
					select sum(dare) - sum(avere) into :ld_imp_euro from mov_contabile where id_reg_pd=:ll_reg_pd or id_reg_pd=:ll_reg_pd + 1;
				else
				
					select sum(dare) - sum(avere) into :ld_imp_euro from mov_contabile where id_reg_pd=:ll_reg_pd;
				end if	
				if round(ld_imp_euro,2)<>0 then
					if round(ld_imp_euro,2)>0 then
							insert into chiusura_apertura (id_conto, saldo_avere)
									 values (:ll_conto_euro, fn_conv_valuta(:ll_val_prec,:ld_imp_euro,:ll_val));
					else
							insert into chiusura_apertura (id_conto, saldo_dare)
									 values (:ll_conto_euro, fn_conv_valuta(:ll_val_prec,:ld_imp_euro,:ll_val));	
					end if
					commit;
				end if
			end if	
			
			
			update chiusura_apertura
			set id_prof_registrazione=:ll_prof,data=:ld_d,tipo='P';
			
		else	
			 lo_sp.of_conti_sp(il_prof,ld_d,ll_id_es,ll_id1,ll_id3,'CA')
			 lo_sp.of_conti_ce(il_prof,ld_d,ll_id_es,ll_id2,ll_id4,'CA')
		end if
		
		string ls_tipo_chiusura
		ls_tipo_chiusura=dw_1.getitemstring(1,"modalita")
		if ls_tipo_chiusura='P' then
			
			
			
			
			if is_modo='C' then
				open(w_stampa_chiusura_gd)
			else
				open(w_stampa_apertura_gd)
			end if
		else
			if is_modo='C' then
				update esercizio set bloccato='S' where id_esercizio=:ll_id_es;
				lo_sp.of_registrazione_chiusura(il_prof,ll_id_reg,ld_d, ld_data_comp)
				openwithparm(w_stampa_chiusura_gd,ll_reg_pd)
			else
	
				long ll_es_apertura,ll_id_ap
				string ls_bloc,ls_codice
				ll_es_apertura=dw_1.getitemnumber(1,"id_esercizio")
				select id_esercizio,bloccato,codice
				into :ll_id_ap,:ls_bloc,:ls_codice
				from esercizio
				where data_fine=(	select max(data_fine) 
										from esercizio 
										where data_fine<( select data_inizio 
																from esercizio 		
																where id_esercizio=:ll_es_apertura));
				if sqlca.sqlcode=0 and ls_bloc='N' then
					messagebox('Errore',"L'esercizio "+ls_codice+" non è stato chiuso!")
					close(w_attesa)
				else																
					lo_sp.of_registrazione_apertura(il_prof,ll_id_reg,ld_d, ld_data_comp)
					open(w_stampa_apertura_gd)
				end if
			end if
			
		end if
	else 
			messagebox("Informazione","Si deve inserire l'esercizio e il registro")
	end if 
	destroy lo_sp
else
	long ll_id_prof,ll_num
	date ld_data
	select id_prof_reg_chiusura
	into :ll_id_prof
	from par_sistema; 
		
	select reg_pd.data_registrazione,reg_pd.num_progressivo
	into :ld_data,:ll_num
	from reg_pd,esercizio
	where reg_pd.id_prof_registrazione=:ll_id_prof
	and esercizio.id_esercizio=:ll_id_es
	and reg_pd.data_registrazione=esercizio.data_fine;
	messagebox("Errore","L'esercizio è già stato chiuso con la registrazione "+string(ll_num)+"~r~nin data "+string(ld_data,'dd/mm/yyyy'))
end if

end event

type dw_1 from u_dw_ext_main within w_chiusura_apertura_cx
int X=23
int Y=180
int Width=2149
int Height=524
int TabOrder=30
string DataObject="d_chiusura_apertura_ff"
end type

event ue_set_search;
is_es=string(dw_1.getitemnumber(1,'id_esercizio'))

CHOOSE CASE as_nomecol
	CASE "reg_cod"
		is_search_window = "w_registro_ca_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "tipo_registro"
		
		if is_es<>"" then is_ricpar.s_sql_cond='esercizio.id_esercizio='+is_es +"and registro.tipo_registro='PN'"
		is_ricpar.b_imm_retrieve = TRUE
	CASE "reg_des"
		is_search_window = "w_registro_ca_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "registro_descrizione"
		
		if is_es<>"" then is_ricpar.s_sql_cond='esercizio.id_esercizio='+is_es+"and registro.tipo_registro='PN'"
		is_ricpar.b_imm_retrieve = TRUE
END CHOOSE

end event

event ue_use_search;call super::ue_use_search;CHOOSE CASE as_nomecol
	CASE "reg_cod"
		uf_set_colval("reg_cod", is_ricpar.s_main_value)
		uf_set_colval("id_registro", is_ricpar.s_id_seg_value[1])
		uf_set_colval("reg_des", is_ricpar.s_ausil_value[1])
	CASE "reg_des"
		uf_set_colval("reg_des", is_ricpar.s_main_value)
		uf_set_colval("id_registro", is_ricpar.s_id_seg_value[1])
		uf_set_colval("reg_cod", is_ricpar.s_ausil_value[1])
END CHOOSE
end event

event itemchanged;
string    ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
integer li_ok, ll_null
setnull(ll_null)




if dwo.name='modalita' then
	if data='P' then
		cb_1.text='Simula'
	else
		if is_modo='C' then
			cb_1.text='Chiudi Conti'		
		else
			cb_1.text='Apertura Conti'		
		end if
	end if
end if

date ld_d1,ld_d2
string ls_data
if dwo.name="id_esercizio" then
	is_es=data
	
	select data_inizio,data_fine
	into :ld_d1,:ld_d2
	from esercizio
	where id_esercizio=:data;
	ls_data=string(ld_d1,"dd/mm/yyyy")
	dw_1.setitem(1,"d_in",ls_data)
	ls_data=string(ld_d2,"dd/mm/yyyy")	
	dw_1.setitem(1,"d_fin",ls_data)	
	if parent.title='Apertura dei Conti' then
		dw_1.setitem(1,'data_c',ld_d1)
	else
		dw_1.setitem(1,'data_c',ld_d2)
	end if
	
	dw_1.setitem(1,'reg_cod','')	
	dw_1.setitem(1,'reg_des','')		
	dw_1.setitem(1,'id_registro',ll_null)	
	

end if


ls_sql_cond = ""  
choose case dwo.name
		
	case "reg_cod"
		ls_dbc[1] = "descrizione"
		ls_dbc[2] = "tipo_registro"
		ls_dbc[3] = "id_registro"		
		ls_dwc[1] = "reg_des"
		ls_dwc[2] = "reg_cod"
		ls_dwc[3] = "id_registro"			
	   li_ok = uf_autofind_col(dwo.Name, "registro", &
										"tipo_registro", "A", data, &
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (li_ok > 0) THEN
			RETURN 2
		END IF
		
	case "reg_des"
		ls_dbc[1] = "descrizione"
		ls_dbc[2] = "tipo_registro"
		ls_dbc[3] = "id_registro"			
		ls_dwc[1] = "reg_des"
		ls_dwc[2] = "reg_cod"
		ls_dwc[3] = "id_registro"					
	   li_ok = uf_autofind_col(dwo.Name, "registro", &
										"descrizione", "A", data, &
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)

		
		IF (li_ok > 0) THEN
			RETURN 2
		END IF	

		
	
END CHOOSE

		
end event

