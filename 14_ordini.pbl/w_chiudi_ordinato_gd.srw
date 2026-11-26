forward
global type w_chiudi_ordinato_gd from w_np_single_data
end type
end forward

global type w_chiudi_ordinato_gd from w_np_single_data
integer width = 2510
integer height = 860
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
end type
global w_chiudi_ordinato_gd w_chiudi_ordinato_gd

on w_chiudi_ordinato_gd.create
call super::create
end on

on w_chiudi_ordinato_gd.destroy
call super::destroy
end on

event open;long ll_id_art, ll_righe, ll_righe_trovate
integer i, a
decimal ldc_peso, ldc_peso_ordine
u_dw_main dw_riga
string ls_codice_art

idw_master = dw_single
is_wintype = "W_NP_SINGLE_DATA"
dw_riga=message.powerobjectparm
i=dw_riga.getrow()

//ll_righe=dw_riga.rowcount()
//for i= 1 to ll_righe
	ldc_peso=dw_riga.getitemdecimal(i, "riga_documento_peso_netto")
	ll_id_art=dw_riga.getitemnumber(i, "riga_documento_id_articolo")
	if ll_id_art>0 then
		select codice
		into :ls_codice_art
		from dba.articolo
		where id_articolo= :ll_id_art
		;
		this.title=ls_codice_art
		ll_righe_trovate=dw_single.Retrieve(ll_id_art)
		if ll_righe_trovate>0 then
			do while ldc_peso>0 and a< ll_righe_trovate
				a++
				
				ldc_peso_ordine=dw_single.getitemdecimal(a, "riga_documento_peso_netto")
				ldc_peso -= ldc_peso_ordine
				if ldc_peso>0 then
					dw_single.setitem(a, "riga_documento_ordinato_fo", "S")
				end if			
				
			loop
			if ldc_peso>0 then 
				messagebox("Attenzione!", "Non esistono abbastanza ordini "+&
				"da chiudere per la quantità indicata nel documento del fornitore!")
			end if
		else
			messagebox("Attenzione!", "Articolo non ordinato")
		end if
	
	end if
//next



this.y = 100
end event

type p_msg_log from w_np_single_data`p_msg_log within w_chiudi_ordinato_gd
end type

type p_crescente from w_np_single_data`p_crescente within w_chiudi_ordinato_gd
end type

type p_decrescente from w_np_single_data`p_decrescente within w_chiudi_ordinato_gd
end type

type dw_single from w_np_single_data`dw_single within w_chiudi_ordinato_gd
integer width = 2400
string dataobject = "d_prod_trova_art_prodotto_gd"
end type

event dw_single::updateend;call super::updateend;long ll_id_bollettina, ll_id_riga_ordine
integer i
string ls_ordinato

if rowsupdated>0 then
	for i =1 to rowcount()
		ls_ordinato=getitemstring(i,	"riga_documento_ordinato_fo")
		if ls_ordinato='S' then
			ll_id_bollettina=getitemnumber(i,	"id_documento")
			
			select provv_imp_subage_2
			into :ll_id_riga_ordine
			from riga_documento
			where id_documento= :ll_id_bollettina
			and id_riga_doc_padre is null
			;
			if ll_id_riga_ordine>0 then
				update dba.riga_documento
				set ordinato_fo='S'
				where id_riga_documento= :ll_id_riga_ordine
				;
				if sqlca.sqlnrows>0 then
					commit;
				else
					rollback;
					messagebox("Attenzione!", "Riga ordine non chiusa!")
				end if
			else
				messagebox("Attenzione!", "Riga ordine non trovata!")
			end if
			
		end if
	next
end if
end event

