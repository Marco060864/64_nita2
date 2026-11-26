forward
global type w_art_cfg_stampa_gd from w_np_single_data
end type
end forward

global type w_art_cfg_stampa_gd from w_np_single_data
int Width=1714
boolean TitleBar=true
string Title="Configura Stampa Articoli"
long BackColor=80269524
end type
global w_art_cfg_stampa_gd w_art_cfg_stampa_gd

type variables
long il_art_cfg
STRING IS_SQL
end variables

forward prototypes
public subroutine wf_ricerca (long al_riga_corrente, string as_data)
end prototypes

public subroutine wf_ricerca (long al_riga_corrente, string as_data);
s_ric_param ls_ric_param
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

on w_art_cfg_stampa_gd.create
call super::create
end on

on w_art_cfg_stampa_gd.destroy
call super::destroy
end on

event open;long ll_righe
string ls_cod


IS_SQL=dw_single.getsqlpreview()
idw_master = dw_single
is_wintype = "W_NP_SINGLE_DATA"
this.y = 100

if isvalid(message) then
	il_art_cfg=message.doubleparm
	if il_art_cfg>0 then
		ll_righe=dw_single.Retrieve()
		if ll_righe<=0 then
			dw_single.insertrow(1)
			dw_single.setitem(1, "id_articolo", il_art_cfg)
			select codice
			into :ls_cod
			from articolo
			where id_articolo=:il_art_cfg;
			dw_single.setitem(1, "articolo_codice", ls_cod)
		end if	
	else
		ll_righe=dw_single.Retrieve()
	end if
else
	ll_righe=dw_single.Retrieve()
end if
end event

type p_crescente from w_np_single_data`p_crescente within w_art_cfg_stampa_gd
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_art_cfg_stampa_gd
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_art_cfg_stampa_gd
int X=32
int Width=1605
string DataObject="d_art_cfg_stampa_gd"
end type

event dw_single::itemchanged;st_ass_art_sottoclasse st_associa
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

event dw_single::sqlpreview;string ls_sql

IF sqltype=PreviewSelect! THEN
	if il_art_cfg>0 then
		ls_sql=sqlsyntax
		ls_sql+=" and art_cfg_stampa.id_articolo= "+string(il_art_cfg)
		setsqlpreview(ls_sql)
	end if
END IF



end event

