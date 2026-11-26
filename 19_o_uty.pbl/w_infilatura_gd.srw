forward
global type w_infilatura_gd from w_np_single_data
end type
end forward

global type w_infilatura_gd from w_np_single_data
int Width=1317
boolean TitleBar=true
string Title="Definizione Infilatura per Articolo"
long BackColor=80269524
end type
global w_infilatura_gd w_infilatura_gd

forward prototypes
public subroutine wf_ricerca (integer al_riga_corrente, string as_data)
end prototypes

public subroutine wf_ricerca (integer al_riga_corrente, string as_data);s_ric_param ls_ric_param
w_search_main lw_sm
ls_ric_param.s_filter_value=as_data
ls_ric_param.s_filter_name="articolo_codice"
openwithparm(lw_sm,ls_ric_param,"w_articolo_coddes_sw")
ls_ric_param=message.powerobjectparm
if upperbound(ls_ric_param.s_id_seg_value)>0 then
	dw_single.setitem(al_riga_corrente, "id_articolo",long(ls_ric_param.s_id_seg_value[1]))
	dw_single.setitem(al_riga_corrente,"articolo_codice", ls_ric_param.s_main_value)
	
end if
end subroutine

on w_infilatura_gd.create
call super::create
end on

on w_infilatura_gd.destroy
call super::destroy
end on

type dw_single from w_np_single_data`dw_single within w_infilatura_gd
int X=23
int Y=32
int Width=1211
string DataObject="d_infilatura_gd"
end type

event dw_single::itemchanged;
st_ass_art_sottoclasse st_associa
IF DWO.NAME='articolo_codice' then
	select id_articolo, codice, descrizione
	into :st_associa.id_articolo, :st_associa.cod_articolo, :st_associa.des_articolo
	from articolo
	where codice=:data;
	if sqlca.sqlcode=0 then
		setitem(row, "id_articolo", st_associa.id_articolo)
		setitem(row, "articolo_codice", st_associa.cod_articolo)
		
	else
		wf_ricerca(row, data)
	end if
	
end if
end event

event dw_single::clicked;call super::clicked;string ls_data
if dwo.name="articolo_codice_sw" then
	ls_data=getitemstring(row, "articolo_codice")
	wf_ricerca(row, ls_data)
end if
end event

