forward
global type w_scag_art_offerta_lt from w_np_single_data
end type
end forward

global type w_scag_art_offerta_lt from w_np_single_data
int Width=3401
int Height=912
WindowType WindowType=response!
boolean TitleBar=true
string Title="Scaglioni di provvigione"
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
end type
global w_scag_art_offerta_lt w_scag_art_offerta_lt

type variables
long il_id_con_provvigione
end variables

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

on w_scag_art_offerta_lt.create
call super::create
end on

on w_scag_art_offerta_lt.destroy
call super::destroy
end on

type p_crescente from w_np_single_data`p_crescente within w_scag_art_offerta_lt
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_scag_art_offerta_lt
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_scag_art_offerta_lt
int X=23
int Y=20
int Width=3346
int Height=784
string DataObject="d_scag_art_offerta_gd"
BorderStyle BorderStyle=StyleLowered!
end type

event dw_single::itemchanged;string ls_per,ls_imp
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
		else
			messagebox("Errore","Errore di impostazione nei parametri di sistema",stopsign!)
			this.deleterow(row)
		end if		
		dw_single.setitem(row,"scag_provvigione_da_per_sconto",ld_null)
		dw_single.setitem(row,"scag_provvigione_a_per_sconto",ld_null)
	end if
end if


end event

event dw_single::ue_insert;call super::ue_insert;wf_controlla()
long ll_valuta, ll_id_con_lis_articolo, ll_row

ll_row = getrow()

if (ll_row > 0) then

	SELECT id_valuta 
	INTO   :ll_valuta
	FROM   par_sistema
	;
	
	if (not isnull(ll_valuta)) then this.object.scag_provvigione_id_valuta[ll_row] = ll_valuta
	
	ll_id_con_lis_articolo = message.doubleparm
	
	if (not isnull(il_id_con_provvigione)) then 
		this.object.id_con_provvigione[ll_row] = il_id_con_provvigione
	else
		messagebox("Ue_insert", "Si è verificato un errore nel recupero della condizione di provvigione ")
	end if
end if

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

event dw_single::sqlpreview;long ll_id_con_lis_articolo, ll_da_id_art, ll_a_id_art, ll_id_cat_com_articolo
date ldt_da_data, ldt_a_data
string ls_sqlsyntax
long	ll_id_anagrafica 
long  ll_id_sog_commerciale, ll_id_cat_com_sc		

if (request=PreviewFunctionRetrieve!) then
	ll_id_con_lis_articolo = message.doubleparm
	
	SELECT id_art_da, id_art_a, id_cat_com_articolo, 
			 date(data_inizio), date(data_fine), id_anagrafica,
			 id_sog_commerciale, id_cat_com_sc
	INTO	 :ll_da_id_art, :ll_a_id_art, :ll_id_cat_com_articolo, 
			 :ldt_da_data, :ldt_a_data, :ll_id_anagrafica,
			 :ll_id_sog_commerciale, :ll_id_cat_com_sc			 
	FROM	 con_lis_articolo
	WHERE  id_con_lis_articolo = :ll_id_con_lis_articolo
	;
	
	if SQLCA.SQLCODE = -1 then 
		messagebox("DBError", SQLCA.SQLERRTEXT) 
	elseif (SQLCA.SQLCODE=0) then
		DATASTORE lds_con_provvigione
		lds_con_provvigione = CREATE datastore
		lds_con_provvigione.dataobject = "ds_con_provvigione_gd"
		lds_con_provvigione.settransobject(sqlca)
		ls_sqlsyntax = lds_con_provvigione.object.datawindow.table.select
	
		if (not isnull(ll_da_id_art)) then
			ls_sqlsyntax = ls_sqlsyntax + " AND id_articolo = " + string(ll_da_id_art)
		end if
		
		if (not isnull(ll_da_id_art)) then
			ls_sqlsyntax = ls_sqlsyntax + " AND id_articolo_a = " + string(ll_a_id_art)
		end if
		
		if (not isnull(ldt_da_data)) then
			ls_sqlsyntax = ls_sqlsyntax + " AND data_inizio = '" + string(ldt_da_data, 'yyyy-mm-dd') + "'"
		end if
		
		if (not isnull(ldt_a_data)) then
			ls_sqlsyntax = ls_sqlsyntax + " AND data_fine = '" + string(ldt_a_data, 'yyyy-mm-dd') + "'"
		end if
		
		if (not isnull(ll_id_cat_com_articolo)) then
			ls_sqlsyntax = ls_sqlsyntax + " AND id_cat_com_articolo = " + string(ll_id_cat_com_articolo)
		end if	

		
		if (not isnull(ll_id_anagrafica)) then
			ls_sqlsyntax = ls_sqlsyntax + " AND id_anagrafica = " + string(ll_id_anagrafica)
		end if	
		
		
		if (not isnull(ll_id_sog_commerciale)) then
			ls_sqlsyntax = ls_sqlsyntax + " AND id_sog_commerciale = " + string(ll_id_sog_commerciale)
		end if	
		
		if (not isnull(ll_id_cat_com_articolo)) then
			ls_sqlsyntax = ls_sqlsyntax + " AND id_cat_com_sc = " + string(ll_id_cat_com_sc)
		end if	
		
		
		integer li_rows, li_i
		
		lds_con_provvigione.object.datawindow.table.select	= ls_sqlsyntax
		li_rows = lds_con_provvigione.retrieve()
		
		if (li_rows = 0) then
			
			INSERT INTO con_provvigione ( id_articolo, id_articolo_a, id_cat_com_articolo,
				data_inizio, data_fine, id_anagrafica, id_sog_commerciale, id_cat_com_sc )
			VALUES ( :ll_da_id_art, :ll_a_id_art, :ll_id_cat_com_articolo, :ldt_da_data, 
						:ldt_a_data, :ll_id_anagrafica,
						:ll_id_sog_commerciale, :ll_id_cat_com_sc)
			;
			
			li_rows = lds_con_provvigione.retrieve()
		end if
		
		if (li_rows > 0) then
			il_id_con_provvigione = lds_con_provvigione.object.id_con_provvigione[1]
			ls_sqlsyntax = sqlsyntax
			ls_sqlsyntax = ls_sqlsyntax + " AND scag_provvigione.id_con_provvigione IN ("
			for li_i = 1 to li_rows
				if (li_i > 1) then ls_sqlsyntax = ls_sqlsyntax + ", "
				ls_sqlsyntax = ls_sqlsyntax + string(lds_con_provvigione.object.id_con_provvigione[li_i])
			next
			ls_sqlsyntax = ls_sqlsyntax + ") "
			
			setsqlpreview(ls_sqlsyntax)
		end if
		
		DESTROY lds_con_provvigione
	end if
end if
end event

