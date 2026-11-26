forward
global type w_scaglione_provvigione_lt from w_np_single_data
end type
end forward

global type w_scaglione_provvigione_lt from w_np_single_data
int Width=3232
int Height=1332
boolean TitleBar=true
string Title="Scaglione Provvigione"
end type
global w_scaglione_provvigione_lt w_scaglione_provvigione_lt

forward prototypes
public subroutine wf_controlla ()
public function boolean wf_controlla_update ()
end prototypes

public subroutine wf_controlla ();decimal li_per,li_app,li_imp
long ll_row,i
string ls_sconto
ll_row=dw_single.getrow()
ls_sconto=dw_single.gettext()
if ls_sconto='P' then
	li_per=-1
	for i=1 to dw_single.rowcount()
		li_app=dw_single.getitemnumber(i,"scag_provvigione_a_per_sconto")
		if li_app>li_per then li_per=li_app
	next
	li_per++
	if li_per>=100 then setnull(li_per)
	ll_row=dw_single.getrow()
	dw_single.setitem(ll_row,"scag_provvigione_da_per_sconto",li_per)
elseif ls_sconto='I' then
	li_imp=-1
	for i=1 to dw_single.rowcount()
		li_app=dw_single.getitemnumber(i,"a_imp_sconto")
		if li_app>li_imp then li_imp=li_app
	next
	li_imp++
	ll_row=dw_single.getrow()
	dw_single.setitem(ll_row,"da_imp_sconto",li_imp)
end if
end subroutine

public function boolean wf_controlla_update ();long ll_rows,i,j
decimal ld_imp_riga,ld_per_riga,ld_imp_cont,ld_per_cont,ld_imp_app,ld_per_app,ld_null
string ls_tipo_sconto
boolean lb_ritorno
integer li_null
lb_ritorno=true
li_null=0
setnull(ld_null)
ll_rows=dw_single.rowcount()
for i=1 to ll_rows
	ls_tipo_sconto=dw_single.getitemstring(i,"tipo_sconto")
	if ls_tipo_sconto='P' then
		ld_per_cont= -1
		ld_per_riga=dw_single.getitemnumber(i,"scag_provvigione_da_per_sconto")
		if not isnull(ld_per_riga) then
			if i>1 then
				for j=i -1 to 1 step -1
					ld_per_app=dw_single.getitemnumber(j,"scag_provvigione_a_per_sconto")
					if ld_per_app>ld_per_cont then ld_per_cont=ld_per_app
				next
				if ld_per_cont<99 or li_null>1 then 
					if ld_per_riga<=ld_per_cont then
						dw_single.setitem(i,"scag_provvigione_da_per_sconto",ld_per_cont+1)
						ld_per_riga=ld_per_cont+1
					end if
					ld_per_app=dw_single.getitemnumber(i,"scag_provvigione_a_per_sconto")
					if ld_per_app<=ld_per_riga  or isnull(ld_per_app) then
						dw_single.setitem(i,"scag_provvigione_a_per_sconto",ld_per_riga +1)
					end if
				else
					lb_ritorno=false
				end if
			else
				
				if isnull(dw_single.getitemnumber(1,"scag_provvigione_a_per_sconto")) then
					ld_per_app=dw_single.getitemnumber(1,"scag_provvigione_da_per_sconto")
					dw_single.setitem(i,"scag_provvigione_a_per_sconto",ld_per_riga +1)
				end if
			end if
			
		else
			li_null++
			if li_null<=1 then
				dw_single.setitem(i,"scag_provvigione_a_per_sconto",ld_null)
			else
				return false
			end if
		end if
	elseif ls_tipo_sconto='I' then
		ld_imp_cont= -1
		ld_imp_riga=dw_single.getitemnumber(i,"da_imp_sconto")
		if not isnull(ld_imp_riga) then
			if i>1 then
				for j=i -1 to 1 step -1
					ld_imp_app=dw_single.getitemnumber(j,"a_imp_sconto")
					if ld_imp_app>ld_imp_cont then ld_imp_cont=ld_imp_app
				next
				if ld_imp_riga<=ld_imp_cont then 
					dw_single.setitem(i,"da_imp_sconto",ld_imp_cont+1)
					ld_imp_riga=ld_imp_cont+1
				end if
				ld_imp_app=dw_single.getitemnumber(i,"a_imp_sconto")
				if ld_imp_app<=ld_imp_riga or isnull(ld_imp_app)then
					dw_single.setitem(i,"a_imp_sconto",ld_imp_riga +1)
				end if
			else
				if isnull(dw_single.getitemnumber(1,"a_imp_sconto")) then
					ld_imp_app=dw_single.getitemnumber(1,"da_imp_sconto") 
					dw_single.setitem(i,"a_imp_sconto",ld_imp_riga +1 )
				end if
			end if
		else
			li_null++
			if li_null<=1 then
				dw_single.setitem(i,"a_imp_sconto",ld_null)
			else
				return false
			end if
			
		end if
	end if
next

return lb_ritorno

end function

on w_scaglione_provvigione_lt.create
call super::create
end on

on w_scaglione_provvigione_lt.destroy
call super::destroy
end on

type p_crescente from w_np_single_data`p_crescente within w_scaglione_provvigione_lt
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_scaglione_provvigione_lt
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_scaglione_provvigione_lt
int Width=3063
int Height=1140
string DataObject="d_scag_prov_gruppo_agenti"
end type

event dw_single::itemchanged;call super::itemchanged;string ls_per,ls_imp
decimal ld_null
setnull(ld_null)
if dwo.name="tipo_sconto" then
	wf_controlla()
	if data='P' then
		select tipo_prov_per_sconto
		into :ls_per
		from par_sistema;
		if sqlca.sqlcode=0 then
			this.setitem(row,"scag_provvigione_tipo_applicazione",ls_per)
			if ls_per='P' then
				dw_single.object.scag_provvigione_per_prov_capo_area.protect=0				
				dw_single.object.scag_provvigione_per_prov_capo_area.background.color=16777215				
				dw_single.object.scag_provvigione_per_prov_agente.protect=0
				dw_single.object.scag_provvigione_per_prov_agente.background.color=16777215		
				dw_single.object.scag_provvigione_per_prov_sub_agente.protect=0				
				dw_single.object.scag_provvigione_per_prov_sub_agente.background.color=16777215
				
				dw_single.object.scag_provvigione_imp_prov_capo_area.protect=1
				dw_single.object.scag_provvigione_imp_prov_capo_area.background.color=12632256
				dw_single.object.scag_provvigione_imp_prov_agente.protect=1
				dw_single.object.scag_provvigione_imp_prov_agente.background.color=12632256				
				dw_single.object.scag_provvigione_imp_prov_sub_agente.protect=1
				dw_single.object.scag_provvigione_imp_prov_sub_agente.background.color=12632256					
			else
				dw_single.object.scag_provvigione_imp_prov_capo_area.protect=1
				dw_single.object.scag_provvigione_imp_prov_capo_area.background.color=16777215
				dw_single.object.scag_provvigione_imp_prov_agente.protect=1
				dw_single.object.scag_provvigione_imp_prov_agente.background.color=16777215				
				dw_single.object.scag_provvigione_imp_prov_sub_agente.protect=1
				dw_single.object.scag_provvigione_imp_prov_sub_agente.background.color=16777215
				
				dw_single.object.scag_provvigione_per_prov_capo_area.protect=1				
				dw_single.object.scag_provvigione_per_prov_capo_area.background.color=12632256				
				dw_single.object.scag_provvigione_per_prov_agente.protect=1
				dw_single.object.scag_provvigione_per_prov_agente.background.color=12632256		
				dw_single.object.scag_provvigione_per_prov_sub_agente.protect=1
				dw_single.object.scag_provvigione_per_prov_sub_agente.background.color=12632256
			end if
		else
			messagebox("Errore","Errore di impostazione nei parametri di sistema",stopsign!)
			this.deleterow(row)
		end if
		dw_single.setitem(row,"da_imp_sconto",ld_null)
		dw_single.setitem(row,"a_imp_sconto",ld_null)				
	else
		select tipo_prov_imp_sconto
		into :ls_imp
		from par_sistema;
		if sqlca.sqlcode=0 then
			this.setitem(row,"scag_provvigione_tipo_applicazione",ls_imp)
			if ls_per='P' then
				dw_single.object.scag_provvigione_per_prov_capo_area.protect=0				
				dw_single.object.scag_provvigione_per_prov_capo_area.background.color=16777215				
				dw_single.object.scag_provvigione_per_prov_agente.protect=0
				dw_single.object.scag_provvigione_per_prov_agente.background.color=16777215		
				dw_single.object.scag_provvigione_per_prov_sub_agente.protect=0				
				dw_single.object.scag_provvigione_per_prov_sub_agente.background.color=16777215
				
				dw_single.object.scag_provvigione_imp_prov_capo_area.protect=1
				dw_single.object.scag_provvigione_imp_prov_capo_area.background.color=12632256
				dw_single.object.scag_provvigione_imp_prov_agente.protect=1
				dw_single.object.scag_provvigione_imp_prov_agente.background.color=12632256				
				dw_single.object.scag_provvigione_imp_prov_sub_agente.protect=1
				dw_single.object.scag_provvigione_imp_prov_sub_agente.background.color=12632256
			else
				dw_single.object.scag_provvigione_imp_prov_capo_area.protect=0
				dw_single.object.scag_provvigione_imp_prov_capo_area.background.color=16777215
				dw_single.object.scag_provvigione_imp_prov_agente.protect=0
				dw_single.object.scag_provvigione_imp_prov_agente.background.color=16777215				
				dw_single.object.scag_provvigione_imp_prov_sub_agente.protect=0
				dw_single.object.scag_provvigione_imp_prov_sub_agente.background.color=16777215
				
				dw_single.object.scag_provvigione_per_prov_capo_area.protect=1				
				dw_single.object.scag_provvigione_per_prov_capo_area.background.color=12632256				
				dw_single.object.scag_provvigione_per_prov_agente.protect=1
				dw_single.object.scag_provvigione_per_prov_agente.background.color=12632256		
				dw_single.object.scag_provvigione_per_prov_sub_agente.protect=1
				dw_single.object.scag_provvigione_per_prov_sub_agente.background.color=12632256				
			end if
		else
			messagebox("Errore","Errore di impostazione nei parametri di sistema",stopsign!)
			this.deleterow(row)
		end if
			dw_single.setitem(row,"scag_provvigione_da_per_sconto",ld_null)
			dw_single.setitem(row,"scag_provvigione_a_per_sconto",ld_null)
	end if
end if




end event

event dw_single::ue_insert;call super::ue_insert;

long ll_valuta, ll_row

select id_valuta 
into 	 :ll_valuta
from 	 par_sistema
;

ll_row = this.getrow()
setitem(ll_row,"scag_provvigione_id_valuta",ll_valuta)
end event

event dw_single::updatestart;call super::updatestart;long ll_row
boolean lb_con
ll_row=this.getrow()
this.sort()
this.setrow(ll_row)
lb_con=wf_controlla_update()
if lb_con=false then 
	Messagebox("Errore","I dati inseriti non sono validi impossibile salvare!",Stopsign!)
	return 1
END IF
end event

