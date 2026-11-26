forward
global type w_per_agente_rpt from w_stampa_001
end type
end forward

global type w_per_agente_rpt from w_stampa_001
end type
global w_per_agente_rpt w_per_agente_rpt

type variables
s_param_articoli is_causali
end variables

on w_per_agente_rpt.create
call super::create
end on

on w_per_agente_rpt.destroy
call super::destroy
end on

event open;string dwsyntax, ls_codice,ls_path_libreria

is_causali=message.powerobjectparm



ls_codice=is_causali.tipo_stampa
select libreria
into :ls_path_libreria
from conf_oggetti
where codice=:ls_codice;

if ls_path_libreria>"" then
	dwsyntax = LibraryExport(ls_path_libreria, ls_codice, ExportDataWindow!)
	IF dwsyntax>"" THEN
		dw_1.create(dwsyntax)
		dw_1.settransobject(sqlca)
		dw_1.retrieve(is_causali.da_data,is_causali.a_data, is_causali.filtro)
	ELSE
		MESSAGEBOX("ERRORE!", "DW non creata!")
	END IF
else
	MESSAGEBOX("ERRORE!", "Indicare il percorso della libreria!")
end if




end event

event dw_1::sqlpreview;call super::sqlpreview;string ls_sql
integer i, li_pos

ls_sql=sqlsyntax
for i=1 to upperbound(is_causali.li_titolo)
	if i=1 then
		ls_sql+=" and (riga_documento.id_caus_magazzino= "+string(is_causali.li_titolo[i])
	else
		ls_sql+=" or riga_documento.id_caus_magazzino= "+string(is_causali.li_titolo[i])
	end if
	if i=upperbound(is_causali.li_titolo) then
		ls_sql+=")"
	end if
next

if is_causali.da_cod_art > "" then
	ls_sql+=" and (documento.id_gruppo_agenti= "+is_causali.da_cod_art+ " )"
end if
if is_causali.a_sog_comm > "" then
	ls_sql+=" and (documento.id_sog_commerciale= "+is_causali.a_sog_comm+ " )"
end if


if ls_sql > sqlsyntax then
	i=SetSQLPreview(ls_sql)
	if i<>1 then
		messagebox("Errore!", "Filtro non applicato!")
	end if
end if

end event

event dw_1::doubleclicked;long ll_id_doc
w_orafo_documento_ordine_cx w_orafo
s_list_main s_list

if row<=0  then return
s_list.s_identifica[1]="id_documento"
s_list.s_modo=modo_modifica
ll_id_doc=getitemnumber(row, "id_documento")
if ll_id_doc>0 then
	s_list.l_identifica[1]=ll_id_doc
	openwithparm(w_orafo, s_list)
end if
end event

