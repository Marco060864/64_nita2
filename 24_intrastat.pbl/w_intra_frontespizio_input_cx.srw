forward
global type w_intra_frontespizio_input_cx from w_p_data
end type
type p_1 from picture within w_intra_frontespizio_input_cx
end type
type dw_crea_fronte_ff from u_dw_master_main within w_intra_frontespizio_input_cx
end type
end forward

global type w_intra_frontespizio_input_cx from w_p_data
int X=370
int Y=136
int Width=1774
int Height=848
boolean TitleBar=true
string Title="Frontespizio"
p_1 p_1
dw_crea_fronte_ff dw_crea_fronte_ff
end type
global w_intra_frontespizio_input_cx w_intra_frontespizio_input_cx

on w_intra_frontespizio_input_cx.create
int iCurrent
call super::create
this.p_1=create p_1
this.dw_crea_fronte_ff=create dw_crea_fronte_ff
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_1
this.Control[iCurrent+2]=this.dw_crea_fronte_ff
end on

on w_intra_frontespizio_input_cx.destroy
call super::destroy
destroy(this.p_1)
destroy(this.dw_crea_fronte_ff)
end on

event open;call super::open;idw_master = dw_crea_fronte_ff
idw_master.is_list = Message.PowerObjectParm

IF UpperBound(idw_master.is_list.s_identifica) = 0 THEN
	ib_NonModale = TRUE
	idw_master.is_list.s_modo = modo_inserisci
	idw_master.ias_key_name[1] = "id_i_fronte"
END IF

il_helptopic = 70 
end event

type p_crescente from w_p_data`p_crescente within w_intra_frontespizio_input_cx
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_intra_frontespizio_input_cx
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_intra_frontespizio_input_cx
int X=59
int Y=28
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_intra_frontespizio_input_cx
int X=334
int Y=28
int Width=274
boolean Visible=false
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_intra_frontespizio_input_cx
int X=357
int Y=32
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_intra_frontespizio_input_cx
int X=1115
boolean Visible=false
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_intra_frontespizio_input_cx
int X=1157
int Y=28
boolean BringToTop=true
end type

event cb_cancella::clicked;w_p_data  lw_win
u_dw_main  lu_dw

lw_win = u_freddie.iw_current
lu_dw= u_freddie.iudw_current

IF IsValid(lu_dw) THEN
	IF isValid (lu_dw.iudw_parent) then
		if not lu_dw.ib_dw_shared THEN
			if lu_dw.rowcount() >0 then
				parent.triggerevent("ue_delete")
			end if
		end if
	else
		idw_master.event ue_delete (0,0)
	end if
end if

end event

type cb_salva from w_p_data`cb_salva within w_intra_frontespizio_input_cx
int X=1458
int Y=28
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_intra_frontespizio_input_cx
int X=0
int Y=0
int Width=247
int Height=128
int TabOrder=0
boolean Visible=false
string Tag="Dati Riepilogo"
boolean BringToTop=true
long BackColor=79741120
end type

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=18
int Y=104
int Width=210
int Height=8
long BackColor=79741120
string Text="Dati Riepilogo"
long TabBackColor=79741120
end type

type cb_ricerca from w_p_data`cb_ricerca within w_intra_frontespizio_input_cx
int X=859
int Y=28
boolean BringToTop=true
end type

event cb_ricerca::clicked;call super::clicked;
w_search_main		lw_sm
long					ll_i_fronte, ll_row
s_ric_param			ls_ricpar

idw_master.is_ricpar.s_filter_name = "denominazione"
idw_master.is_ricpar.s_filter_value=""
OpenWithParm (lw_sm, idw_master.is_ricpar, "w_intra_frontespizio_input_sw")
idw_master.is_ricpar = Message.PowerObjectParm
IF UpperBound(idw_master.is_ricpar.s_id_seg_value) > 0 THEN
	ll_i_fronte = long(idw_master.is_ricpar.s_id_seg_value[1])
	idw_master.is_list.s_modo = modo_modifica
	idw_master.is_list.s_identifica[1] = "id_i_fronte"
	idw_master.is_list.l_identifica[1] = ll_i_fronte
	idw_master.Event ue_retrieve(0, 0)
	idw_master.SetFocus()
end if


end event

type p_1 from picture within w_intra_frontespizio_input_cx
int X=649
int Y=40
int Width=183
int Height=104
boolean BringToTop=true
string PictureName="s:\pb\commonframework\beuro.bmp"
boolean FocusRectangle=false
end type

type dw_crea_fronte_ff from u_dw_master_main within w_intra_frontespizio_input_cx
int X=46
int Y=168
int Width=1650
int Height=544
int TabOrder=10
string DataObject="d_crea_fronte_ff"
end type

event ue_insert;call super::ue_insert;string ls_denominazione,ls_par_iva,ls_cod_fiscale,ls_indirizzo,ls_cap,ls_localita,ls_provincia
long ll_riga
  SELECT "azienda"."rag_soc_1",   
         "azienda"."par_iva",   
         "azienda"."cod_fiscale",   
         "sede"."indirizzo",   
         "sede"."cap",   
         "sede"."localita",   
         "sede"."provincia"  
    INTO :ls_denominazione,   
         :ls_par_iva,   
         :ls_cod_fiscale,   
         :ls_indirizzo,   
         :ls_cap,   
         :ls_localita,   
         :ls_provincia  
    FROM "azienda",   
         "sede"  
   WHERE ( "azienda"."id_azienda" = 1) and
			( "azienda"."id_azienda" = "sede"."id_azienda" ) and  
         ( "sede"."tipo_sede" = 'L' )    ;
if sqlca.sqlcode=0 then
	if rowcount()>0 then
		if getrow()=0 then
			ll_riga=1
		else
			ll_riga=getrow()
		end if
	end if
	if ll_riga>0 then
		dw_crea_fronte_ff.setitem(ll_riga,"denominazione",ls_denominazione)
		dw_crea_fronte_ff.setitem(ll_riga,"partita_iva",ls_par_iva)
		dw_crea_fronte_ff.setitem(ll_riga,"codice_fiscale",ls_cod_fiscale)		
		dw_crea_fronte_ff.setitem(ll_riga,"domicilio_fiscale",ls_indirizzo)
		dw_crea_fronte_ff.setitem(ll_riga,"cap",dec(ls_cap))		
		dw_crea_fronte_ff.setitem(ll_riga,"comune",ls_localita)			
		dw_crea_fronte_ff.setitem(ll_riga,"provincia",ls_provincia)			
	end if
end if
end event

event itemchanged;date ld_data_inizio, ld_inizio, ld_fine
integer li_anno,li_giorni, li_anno2
string ls_anno
select esercizio.data_inizio
into :ld_data_inizio
from azienda,esercizio
where azienda.id_azienda=1
and azienda.id_esercizio_proposto=esercizio.id_esercizio;

if sqlca.sqlcode=0 then
	li_anno=year(ld_data_inizio)
end if


choose case dwo.name
	case 'mese'
		ld_inizio=date('01/'+data+'/'+string(li_anno))
		li_giorni=f_gmese(integer(data),li_anno)
		ld_fine=date(string(li_giorni)+'/'+data+'/'+string(li_anno))		
		dw_crea_fronte_ff.setitem(1,"da_data1",ld_inizio)
		dw_crea_fronte_ff.setitem(1,"a_data1",ld_fine)	
		
		dw_crea_fronte_ff.setitem(1,"trimestre",0)
		
	case 'trimestre'
		choose case data
			case '1'
				ld_inizio=date('01/01/'+string(li_anno))
				ld_fine=date('31/03/'+string(li_anno))
			case '2'
				ld_inizio=date('01/04/'+string(li_anno))
				ld_fine=date('30/06/'+string(li_anno))				
			case '3'
				ld_inizio=date('01/07/'+string(li_anno))
				ld_fine=date('30/09/'+string(li_anno))
			case '4'
				ld_inizio=date('01/10/'+string(li_anno))
				ld_fine=date('31/12/'+string(li_anno))
		end choose
		dw_crea_fronte_ff.setitem(1,"da_data1",ld_inizio)
		dw_crea_fronte_ff.setitem(1,"a_data1",ld_fine)		
		
		dw_crea_fronte_ff.setitem(1,"mese",0)		
	case 'anno'		
		ld_inizio=date('01/01/'+data)
		ld_fine=date('31/12/'+data)		
		dw_crea_fronte_ff.setitem(1,"da_data1",ld_inizio)
		dw_crea_fronte_ff.setitem(1,"a_data1",ld_fine)		
		
		dw_crea_fronte_ff.setitem(1,"mese",0)
		dw_crea_fronte_ff.setitem(1,"trimestre",0)
end choose

ls_anno = right(string(li_anno),2)
li_anno2 = integer(ls_anno)
dw_crea_fronte_ff.setitem(1,"anno",li_anno2)
end event

