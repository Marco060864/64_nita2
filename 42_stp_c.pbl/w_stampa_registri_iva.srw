forward
global type w_stampa_registri_iva from w_stampa_liq_iva1_ff
end type
end forward

global type w_stampa_registri_iva from w_stampa_liq_iva1_ff
integer width = 3909
integer height = 2544
string title = ""
end type
global w_stampa_registri_iva w_stampa_registri_iva

type variables
string ls_flag_definitiva, rs_tipo_registro
long ll_id_rg_cont_reg, li_num_reg_ini, li_num_reg_fine, rl_id_attivita
date  rd_dalla_data,rd_alla_data
end variables

on w_stampa_registri_iva.create
call super::create
end on

on w_stampa_registri_iva.destroy
call super::destroy
end on

event open;s_pagine s_pag[]
integer a
//ldw_dett_reg,
reg_iva_parametri str_param
string ls_filtro,ls_filtro_rip, ls_omg
string flag_ripristino, flag_tutti_reg, ls_azienda
datawindowchild  ldw_riep_reg, ldw_dett_reg
long ret,rl_n_registro,rl_id_registro,cur_numero,cur_id_registro,rl_id_esercizio,cur_id_registro2
long ll_num_reg, ll_num_cont, num_prot, ll_pag_prep, ll_pag_usate
//ll_id_rg_cont_reg,
date ldt_inizio_es, ldt_fine_es
long  i, ll_righe, ll_num_pag
integer li_anno, li_a_pag, li_pagine, ret_child
//, li_num_reg_ini li_num_reg_fine
date ld_data_inizio, ld_rip
il_zoom=100

str_param=message.powerobjectparm

rs_tipo_registro=str_param.tipo_registro
rd_dalla_data=str_param.dalla_data
rd_alla_data=str_param.alla_data
ls_filtro=str_param.ls_filtro
ls_flag_definitiva=str_param.ls_flag_definitiva
rl_id_attivita=str_param.ll_id_attivita
rl_id_registro=str_param.ll_id_registro
rl_n_registro=str_param.ll_n_registro
rl_id_esercizio=str_param.ll_id_esercizio
ls_filtro_rip=str_param.ls_filtro_rip
flag_ripristino=str_param.flag_ripristino
flag_tutti_reg=str_param.tutti_registri
ld_rip=str_param.data_ripristino

if str_param.las_aghi='N' then 
	dw_1.dataobject='d_stampa_registri_iva_comp_a4'
elseif str_param.las_aghi='P' then
	dw_1.dataobject='d_stampa_registri_iva_comp_np'

end if

dw_1.settransobject(sqlca)
if flag_tutti_reg='S' then 
	
	select id_registro
	into :ll_id_rg_cont_reg
	from registro
	where numero=0
	and id_esercizio=:rl_id_esercizio
	and id_attivita=:rl_id_attivita
	and tipo_registro=:rs_tipo_registro;
	if sqlca.sqlcode<>0 then
		messagebox("Attenzione!", "Registro numero '0' non trovato!")
		return
	end if
	//aggiungo i numeri per filtro
	li_num_reg_ini=1
	li_num_reg_fine=9999
	
else
	ll_id_rg_cont_reg=rl_id_registro
	li_num_reg_ini=rl_n_registro
	li_num_reg_fine=rl_n_registro
end if



select data_inizio, data_fine
into :ldt_inizio_es, :ldt_fine_es
from esercizio
where id_esercizio=:rl_id_esercizio;
if sqlca.sqlcode<>0 then
	messagebox("Errore!", "Date esercizio non recuperate!")
end if
select num_protocollo
into :num_prot
from contatori_registri
where id_registro= :ll_id_rg_cont_reg;


if sqlca.sqlcode = -1 then
	messagebox("Attenzione!", "Numero Protocollo non recuperato! La numerazione potrebbe risultare non corretta")
end if

if ls_flag_definitiva<>'S' or ( ls_flag_definitiva='S' and flag_tutti_reg='S' ) then
	num_prot= -100 
end if

if flag_ripristino='S' then
	if str_param.las_aghi='P' then
		ret=dw_1.retrieve(rs_tipo_registro,rd_dalla_data,rd_alla_data,rl_id_esercizio, num_prot, li_num_reg_ini, li_num_reg_fine)
	else
		ret=dw_1.retrieve(rs_tipo_registro,rd_dalla_data,rd_alla_data,rl_id_esercizio, num_prot, ld_rip)
	end if
else
	if str_param.las_aghi='P' then
		ret=dw_1.retrieve(rs_tipo_registro,rd_dalla_data,rd_alla_data,rl_id_esercizio, num_prot, li_num_reg_ini, li_num_reg_fine)
	else
		ret=dw_1.retrieve(rs_tipo_registro,rd_dalla_data,rd_alla_data,rl_id_esercizio, num_prot,rd_dalla_data)
	end if
end if	

if str_param.las_aghi='P' then
	

else
	ret_child=dw_1.getchild("dettagli_registro",ldw_dett_reg)
	ret_child=dw_1.getchild("riepilogo_registro",ldw_riep_reg)
end if


if str_param.las_aghi='P' then

	select pagine_prep, pagine_usate, anno
	into :li_a_pag, :li_pagine, :li_anno
	from dba.contatori_bollati
	where id_registro=:rl_id_registro;
	select descrizione
	into :ls_param.dich_per 
	from dba.registro
	where id_registro=:rl_id_registro;
		
	dw_1.Object.t_reg.text=ls_param.dich_per

	dw_1.object.pagine.text=string(li_pagine)
	dw_1.object.t_anno.text=string(li_anno)
	dw_1.object.na_pag.text=string(li_a_pag)
	
//	dw_1.setitem(1, "c_pag_preparate", li_a_pag)
//	dw_1.setitem(1, "c_pag_usate", li_pagine)
//	dw_1.setitem(dw_1.rowcount(), "c_pag_preparate", li_a_pag)
//	dw_1.setitem(dw_1.rowcount(), "c_pag_usate", li_pagine)
	FOR a = 1 to dw_1.RowCount()
      s_pag[a].l_pag_usate= li_pagine
		s_pag[a].l_pag_preparate=li_a_pag
	NEXT
	dw_1.Object.Data[1,39, dw_1.RowCount(),40] = s_pag
	
	
//	dw_1.Object.dettagli_registro.Object.t_reg.text=ls_param.dich_per
//
//	dw_1.object.dettagli_registro.object.pagine.text=string(li_pagine)
//	dw_1.object.dettagli_registro.object.t_anno.text=string(li_anno)
//	dw_1.object.dettagli_registro.object.na_pag.text=string(li_a_pag)
end if
if ret<1 then
	messagebox("Attenzione!", "Non esistono movimenti in questo registro!")
	close(this)
	return
else
	select registri_omaggio
	into :ls_omg from par_sistema;
	if ls_omg='S' and rs_tipo_registro='IV' then
		long ll_row, ll_row2
		decimal {4} ll_imp ,ll_iva,ll_%, ll_omaggio
		ll_omaggio=0
		IF dw_1.dataobject='d_stampa_registri_iva_comp_np' THEN
			ll_row2=dw_1.rowcount()
			for ll_row=1 to ll_row2

			ll_iva=dw_1.getitemdecimal(ll_row,'imposta')

			ll_%=dw_1.getitemdecimal(ll_row,'per_aliquota')

			ll_imp=dw_1.getitemdecimal(ll_row,'imponibile_d')
			if ll_%<>0 and not isnull(ll_%) then
				if ABS(ll_imp)<>ABS((ll_iva*100)/ll_%) then ll_omaggio=ll_omaggio + ABS(((ll_iva*100)/ll_%)) - ABS(ll_imp)
			end if	
		next
		ELSE
			ll_row2=ldw_dett_reg.rowcount()
			
			for ll_row=1 to ll_row2
				ll_iva=ldw_dett_reg.getitemdecimal(ll_row,'imposta')
				
				ll_%=ldw_dett_reg.getitemdecimal(ll_row,'per_aliquota')
				
				ll_imp=ldw_dett_reg.getitemdecimal(ll_row,'imponibile_d')
				
				if ll_%<>0 and not isnull(ll_%) then
					if ABS(ll_imp)<>ABS((ll_iva*100)/ll_%) then ll_omaggio=ll_omaggio + ABS(((ll_iva*100)/ll_%)) - ABS(ll_imp)
				end if	
			next	
		END IF	
	end if	
end if
if ll_imp>0 then
	dw_1.Object.omaggio.Text='Note:Totale imponibile omaggio: '+string(ll_omaggio)
end if



IF dw_1.dataobject='d_stampa_registri_iva_comp_np' THEN 
//	dw_1.setfilter(ls_filtro)
//	ret=dw_1.filter()
	if dw_1.rowcount()<1 then
		messagebox("Attenzione!", "Nessun movimento presente nel registro!")
		close(this)
		return
	end if	
ELSE
	ret=ldw_dett_reg.setfilter(ls_filtro)
	ret=ldw_dett_reg.filter()
	if ldw_dett_reg.rowcount()<1 then
		messagebox("Attenzione!", "Nessun movimento presente nel registro!")
		close(this)
		return
	end if	
	ret=ldw_riep_reg.setfilter(ls_filtro)
	ret=ldw_riep_reg.filter()
	ldw_riep_reg.groupcalc()
END IF

this.event post ue_post_open()

//if ls_flag_definitiva='S' then
//	ll_num_pag=dw_1.getitemnumber(1,"page")	
//	
//	select pagine_prep, pagine_usate
//	into :ll_pag_prep , :ll_pag_usate
//	from contatori_bollati
//	where id_registro=:ll_id_rg_cont_reg;
//	
//	if sqlca.sqlcode=0 then
//		ll_pag_prep=ll_pag_prep - ll_pag_usate
//		
//		if ll_num_pag>ll_pag_prep then
//			messagebox("Informazione","Non sono state preparate abbastanza pagine per questa stampa!")
//			close(this)
//		else
//			//dw_1.print(false)
//			//ret=messagebox("Stampa registri IVA","La stampa è andata a buon fine?",question!,yesno!)
//			
//			if ret=1 then
//					if flag_tutti_reg='S' then 
//						setnull(num_prot)
//					else	
//						if dw_1.dataobject='d_stampa_registri_iva_comp_np' then
//							num_prot=dw_1.getitemnumber(1, "prot_per_contatori")
//						else
//							
//							num_prot=ldw_dett_reg.getitemnumber(1, "prot_per_contatori")
//						end if	
//					end if	
//					update contatori_registri 
//					set ultima_data=:rd_alla_data, num_protocollo=:num_prot
//					where  id_attivita= :rl_id_attivita 
//					and id_registro=:ll_id_rg_cont_reg ;
//
//					if sqlca.sqlnrows>0 then
//						commit;
//					else
//						insert
//						into contatori_registri(id_azienda,id_attivita,data_stampa,tipologia,id_registro,ultima_data, num_protocollo)
//						values(1,:rl_id_attivita,today(),:rs_tipo_registro,:ll_id_rg_cont_reg, :rd_alla_data, :num_prot);
//						if sqlca.sqlcode=0 then
//							commit;	
//						else
//							Messagebox("Errore", "Salvataggio contatori registro non riusciuto,~r~n il protocollo da segnare è: "+string(num_prot))
//						end if
//					end if
//					
//			
//			
//
//					select pagine_usate 
//					into :ll_pag_usate 
//					from contatori_bollati
//					where id_registro=:ll_id_rg_cont_reg;
//
//					if sqlca.sqlcode=0 then
//						if not isnull(ll_pag_usate) then
//							ll_num_pag=ll_num_pag+ll_pag_usate
//						end if
//						
//						update contatori_bollati
//						set pagine_usate=:ll_num_pag
//						where id_registro=:ll_id_rg_cont_reg;
//						if sqlca.sqlnrows>0 then
//							commit;
//							
//						else
//							rollback;
//							messagebox("Errore","Pagine usate non aggiornate!")
//						end if
//					
//					else
//						messagebox("Errore","Le pagine per questo tipo di stampa non sono state preparate.",StopSign!)
//					end if
//					close(w_stampa_reg_iva_rpt)		
//					close(this)		
//			else
//				if flag_ripristino='S' then
//				else
//					open(w_stampa_reg_iva_ripristino)
//				end if
//			end if
//		end if			
//		
//	
//	else
//		messagebox("Informazione","Non sono state preparate abbastanza pagine per questa stampa!")
//		CloseWithReturn(this,"N")
//	end if
//end if
end event

event ue_post_open;call super::ue_post_open;long ll_righe, i, ll_num_primo, ll_num_secondo
integer a
ll_righe=dw_1.rowcount()

for i= 1 to ll_righe - 1
	ll_num_primo=long(dw_1.getitemstring(i, "prog_reg_bis"))
	ll_num_secondo=long(dw_1.getitemstring(i+1, "prog_reg_bis"))
	if ll_num_primo=ll_num_secondo - 1 then 
		continue
	else
//		a=0
//		do while ll_num_primo < ll_num_secondo 
//			a++
			messagebox("Attenzione!", "Scrittura n. "+string(ll_num_primo + a)+ " NON trovata! Controlla Progressivi!")
//			ll_num_secondo= ll_num_secondo - 2
//		
//		loop	
	end if
next
end event

type cb_2 from w_stampa_liq_iva1_ff`cb_2 within w_stampa_registri_iva
integer x = 2985
end type

type dw_1 from w_stampa_liq_iva1_ff`dw_1 within w_stampa_registri_iva
integer x = 50
integer y = 160
integer width = 3762
integer height = 2256
string dataobject = "d_stampa_registri_iva_comp"
end type

type cb_7 from w_stampa_liq_iva1_ff`cb_7 within w_stampa_registri_iva
end type

type cb_6 from w_stampa_liq_iva1_ff`cb_6 within w_stampa_registri_iva
end type

type cb_5 from w_stampa_liq_iva1_ff`cb_5 within w_stampa_registri_iva
end type

type cb_4 from w_stampa_liq_iva1_ff`cb_4 within w_stampa_registri_iva
end type

type cb_3 from w_stampa_liq_iva1_ff`cb_3 within w_stampa_registri_iva
integer x = 3250
end type

event cb_3::clicked;string setting, flag_tutti_reg, flag_ripristino
long ll_num_pag, ll_pag_prep, ll_pag_usate, num_prot
//ll_id_rg_cont_reg
integer ret, ret_child
datawindowchild ldw_dett_reg


SETTING = DW_1.object.datawindow.grid.lines
dw_1.Object.DataWindow.Grid.Lines = 2

printsetup()


if ls_flag_definitiva='S' then
	ret_child=dw_1.getchild("dettagli_registro",ldw_dett_reg)
	ll_num_pag=dw_1.getitemnumber(1,"page")	
	
	select pagine_prep, pagine_usate
	into :ll_pag_prep , :ll_pag_usate
	from contatori_bollati
	where id_registro=:ll_id_rg_cont_reg;
	
	if sqlca.sqlcode=0 then
		ll_pag_prep=ll_pag_prep - ll_pag_usate
		
		if ll_num_pag>ll_pag_prep then
			messagebox("Informazione","Non sono state preparate abbastanza pagine per questa stampa!")
			//close(this)
		else
			dw_1.print(false)
			ret=messagebox("Stampa registri IVA","La stampa è andata a buon fine?",question!,yesno!)
			
			if ret=1 then
					if flag_tutti_reg='S' then 
						setnull(num_prot)
					else	
						if dw_1.dataobject='d_stampa_registri_iva_comp_np' then
							num_prot=dw_1.getitemnumber(1, "prot_per_contatori")
						else
							
							num_prot=ldw_dett_reg.getitemnumber(1, "prot_per_contatori")
						end if	
					end if	
					update contatori_registri 
					set ultima_data=:rd_alla_data, num_protocollo=:num_prot
					where  id_attivita= :rl_id_attivita 
					and id_registro=:ll_id_rg_cont_reg ;

					if sqlca.sqlnrows>0 then
						commit;
					else
						insert
						into contatori_registri(id_azienda,id_attivita,data_stampa,tipologia,id_registro,ultima_data, num_protocollo)
						values(1,:rl_id_attivita,today(),:rs_tipo_registro,:ll_id_rg_cont_reg, :rd_alla_data, :num_prot);
						if sqlca.sqlcode=0 then
							commit;	
						else
							Messagebox("Errore", "Salvataggio contatori registro non riusciuto,~r~n il protocollo da segnare è: "+string(num_prot))
						end if
					end if
					
			
			

					select pagine_usate 
					into :ll_pag_usate 
					from contatori_bollati
					where id_registro=:ll_id_rg_cont_reg;

					if sqlca.sqlcode=0 then
						if not isnull(ll_pag_usate) then
							ll_num_pag=ll_num_pag+ll_pag_usate
						end if
						
						update contatori_bollati
						set pagine_usate=:ll_num_pag
						where id_registro=:ll_id_rg_cont_reg;
						if sqlca.sqlnrows>0 then
							commit;
							
						else
							rollback;
							messagebox("Errore","Pagine usate non aggiornate!")
						end if
					
					else
						messagebox("Errore","Le pagine per questo tipo di stampa non sono state preparate.",StopSign!)
					end if
					close(w_stampa_reg_iva_rpt)		
					//close(this)		
			else
				if flag_ripristino='S' then
				else
					open(w_stampa_reg_iva_ripristino)
				end if
			end if
		end if			
		
	
	else
		messagebox("Informazione","Non sono state preparate abbastanza pagine per questa stampa!")
		//CloseWithReturn(this,"N")
	end if
else
	dw_1.print(true)
end if



end event

type cb_1 from w_stampa_liq_iva1_ff`cb_1 within w_stampa_registri_iva
end type

