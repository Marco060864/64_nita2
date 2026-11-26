forward
global type uo_f7400 from nonvisualobject
end type
end forward

global type uo_f7400 from nonvisualobject
end type
global uo_f7400 uo_f7400

forward prototypes
public function integer uf_importa_barcode (string as_nomefile, string as_port, ref w_documento_ordine_cx adw_documento, string as_term)
end prototypes

public function integer uf_importa_barcode (string as_nomefile, string as_port, ref w_documento_ordine_cx adw_documento, string as_term);string path, ls_run, ls_riga, ls_cod_bar, ls_qta, ls_port
integer li_ret, li_esito, li_app, li_eof, li_pos1, li_pos2, li_pos3, li_lung, li_pos
string sl_codice	, sl_descrizione, ls_msg
dec ld_qta
long ll_row, ll_id_articolo, ll_molt

select dir_export
into :path
from par_sistema;

if isnull(path) then path = ""
path = trim(path)

as_port = trim(as_port)
ls_port = right(as_port,1)
if isnull(ls_port) or ls_port = "" then ls_port = "1"

li_ret = messagebox("Importazione Barcodes","Posizionare il lettore in ricezione...",Exclamation!,OkCancel!)
if li_ret = 1 then
	if fileExists(as_nomefile) then
		fileDelete(as_nomefile)
	end if		

	
	
	
	
	
	
	if as_term = "740" then
		ls_run = path + "\ybri.exe /c" + ls_port + " /p /v" 
	elseif as_term = "734" then
		ls_run = path + "\F734.exe -p COM" + ls_port + " -o " + as_nomefile + " -l status.lis" 
		
	end if
	
	
	
	
	
	li_esito = Run(ls_run)
	if li_esito <> 1 then
		
		messagebox("ATTENZIONE!!","Ricezione dati fallita",stopsign!)
		return 1
	end if
	
	messagebox("Ricezione in corso...","Attendere il segnale acustico e premere OK",exclamation!)

	ll_row = adw_documento.tab_1.tabpage_2.dw_riga_documento_ordine_gd.getrow()	
	sl_codice = adw_documento.tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemstring(ll_row,"c_articolo_cod")	
	if isnull(sl_codice) or sl_codice = "" then adw_documento.tab_1.tabpage_2.dw_riga_documento_ordine_gd.deleterow(ll_row)
	
	if fileExists(as_nomefile) then
		li_app=fileopen((as_nomefile),LineMode!,Read!,Shared!,Append!)

		li_eof=0
		do while li_eof<>-100 
			li_eof=fileread(li_app,ls_riga)
			if li_eof<>-100 then
				if not isnull(ls_riga) and ls_riga <> "" then
					li_pos1 = Pos(ls_riga, "|")
					li_pos2 = Pos(ls_riga, "|", li_pos1 +1)
					li_pos3 = Pos(ls_riga, "|", li_pos2 +1)
			
					if as_term = "740" then
						ls_cod_bar = mid(ls_riga, li_pos1+1, ((li_pos2 - 1)- li_pos1))
						ls_qta     = mid(ls_riga, li_pos2+1, ((li_pos3 - 1)- li_pos2))
					elseif as_term = "734" then
						ls_cod_bar = left(ls_riga,(li_pos1 - 1))
						ls_qta     = mid(ls_riga, li_pos1+1, ((li_pos2 - 1)- li_pos1))						
					end if
					
					li_pos = pos(ls_qta,".")
					if li_pos > 0 then ls_qta = Replace(ls_qta, li_pos, 1, ",")
					ld_qta = dec(ls_qta)
							
					li_lung = len(ls_cod_bar)
					if li_lung >= 8 then
						select articolo.codice, articolo.descrizione, articolo.id_Articolo
						into :sl_codice, :sl_descrizione, :ll_id_articolo
						from articolo, unita_confezione, cod_barre
						where cod_barre.codice=:ls_cod_bar
						and cod_barre.id_unita_confezione=unita_confezione.id_unita_confezione
						and articolo.id_articolo=unita_confezione.id_articolo;
						
						select unita_confezione.molteplicita
						into :ll_molt
						from unita_confezione, cod_barre
						where cod_barre.codice=:ls_cod_bar
						and unita_confezione.id_unita_confezione = cod_barre.id_unita_confezione;						
						if isnull(ll_molt) or ll_molt = 0 then ll_molt = 1
						if as_term = "740" then ld_qta = ld_qta * ll_molt
						
						if sqlca.sqlcode = 0 then
							adw_documento.tab_1.tabpage_2.dw_riga_documento_ordine_gd.TriggerEvent("ue_insert")
							ll_row = adw_documento.tab_1.tabpage_2.dw_riga_documento_ordine_gd.getrow()
					
							adw_documento.tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem(ll_row,"riga_documento_id_articolo",ll_id_articolo)
							adw_documento.tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem(ll_row,"c_articolo_cod",sl_codice)
							adw_documento.tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem(ll_row,"riga_documento_descrizione",sl_descrizione)
							
							adw_documento.tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem(ll_row,"quantita",ld_qta)				
							adw_documento.tab_1.tabpage_2.dw_riga_documento_ordine_gd.TriggerEvent("ue_set_arti_riga")
				
							adw_documento.tab_1.tabpage_2.dw_riga_documento_ordine_gd.TriggerEvent("ue_set_contropartita")
							adw_documento.tab_1.tabpage_2.dw_riga_documento_ordine_gd.event ue_rec_prezzo(ll_row,ld_qta)		
							adw_documento.wf_se_cambia_qta(ll_row,string(ld_qta))
						
							adw_documento.tab_1.tabpage_2.dw_riga_documento_ordine_gd.event ue_set_calc_riga(ll_row)	
						else 
							
							
	
							adw_documento.tab_1.tabpage_2.dw_riga_documento_ordine_gd.TriggerEvent("ue_insert")
							ll_row = adw_documento.tab_1.tabpage_2.dw_riga_documento_ordine_gd.getrow()
					
							
							
							adw_documento.tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem(ll_row,"riga_documento_descrizione",ls_cod_bar)
							
							adw_documento.tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem(ll_row,"quantita",ld_qta)				
							adw_documento.tab_1.tabpage_2.dw_riga_documento_ordine_gd.TriggerEvent("ue_set_arti_riga")
				
							adw_documento.tab_1.tabpage_2.dw_riga_documento_ordine_gd.TriggerEvent("ue_set_contropartita")
							adw_documento.tab_1.tabpage_2.dw_riga_documento_ordine_gd.event ue_rec_prezzo(ll_row,ld_qta)		
							adw_documento.wf_se_cambia_qta(ll_row,string(ld_qta))
						
							adw_documento.tab_1.tabpage_2.dw_riga_documento_ordine_gd.event ue_set_calc_riga(ll_row)	
						end if
					end if
			
				end if
			end if
		loop	
		
		fileclose(li_app)	
	else
		messagebox("ATTENZIONE!!","File Barcodes.txt non trovato",stopsign!)
	end if
	
	
end if

return 0
end function

on uo_f7400.create
TriggerEvent( this, "constructor" )
end on

on uo_f7400.destroy
TriggerEvent( this, "destructor" )
end on

