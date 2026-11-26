forward
global type w_con_lis_sempl_ff from w_p_data
end type
type dw_con_lis_sempl_ff from u_dw_master_main within w_con_lis_sempl_ff
end type
end forward

global type w_con_lis_sempl_ff from w_p_data
int Height=1465
boolean TitleBar=true
string Title="Dettaglio condizioni speciali"
dw_con_lis_sempl_ff dw_con_lis_sempl_ff
end type
global w_con_lis_sempl_ff w_con_lis_sempl_ff

on w_con_lis_sempl_ff.create
int iCurrent
call w_p_data::create
this.dw_con_lis_sempl_ff=create dw_con_lis_sempl_ff
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=dw_con_lis_sempl_ff
end on

on w_con_lis_sempl_ff.destroy
call w_p_data::destroy
destroy(this.dw_con_lis_sempl_ff)
end on

event open;call super::open;idw_master 				= dw_con_lis_sempl_ff
idw_master.is_list 	= Message.PowerObjectParm
idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_sql_ident[1] = "con_lis_articolo.id_con_lis_articolo"
end event

type p_crescente from w_p_data`p_crescente within w_con_lis_sempl_ff
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_con_lis_sempl_ff
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_con_lis_sempl_ff
boolean BringToTop=true
end type

event cb_ok::clicked;long ll_row, ll_id
string s_col_name
integer li_counter
long ll_size

if isValid(u_freddie.iudw_current) then
	u_freddie.iudw_current.AcceptText()
end if
if parent.idw_master.uf_To_Update() > 0 then
	parent.TriggerEvent("ue_update")
end if
ll_row = idw_master.GetRow()

is_filter = ""
ll_size = UpperBound(idw_master.is_list.s_identifica)
if ll_row>0 then
	for  li_counter = 1 to ll_size
		s_col_name = idw_master.is_list.s_identifica[li_counter]
		is_filter = is_filter + " AND " + s_col_name + " = " + string(idw_master.GetItemNumber(ll_row, s_col_name))
	next
	is_filter = Mid(is_filter,5)
end if
ib_close_query = FALSE

parent.TriggerEvent("ue_close")

end event

type cb_annulla from w_p_data`cb_annulla within w_con_lis_sempl_ff
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_con_lis_sempl_ff
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_con_lis_sempl_ff
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_con_lis_sempl_ff
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_con_lis_sempl_ff
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_con_lis_sempl_ff
boolean Visible=false
boolean BringToTop=true
long BackColor=79741120
end type

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=19
int Y=17
int Width=2323
int Height=1289
boolean Visible=false
long BackColor=79741120
long TabBackColor=79741120
end type

type cb_ricerca from w_p_data`cb_ricerca within w_con_lis_sempl_ff
boolean BringToTop=true
end type

type dw_con_lis_sempl_ff from u_dw_master_main within w_con_lis_sempl_ff
int X=46
int Y=161
int Width=2309
int Height=1181
int TabOrder=1
string DataObject="d_con_lis_sempl_ff"
end type

event ue_init;call super::ue_init;is_title = "Condizioni speciali - dettaglio"
end event

event itemchanged;call super::itemchanged;long		ll_id_valuta
date		ld_data_fine,ld_data_inizio
decimal	ldc_cambio,ldc_qta_minima,ldc_qta_massima

choose case dwo.name
		
	case 'con_lis_articolo_id_valuta_des','con_lis_articolo_id_valuta'				
		ll_id_valuta	= long(data)
		select valuta.cambio
			into :ldc_cambio
			from valuta
			where valuta.id_valuta = :ll_id_valuta
			using SQLCA;
		
		if SQLCA.SQLCode = 0 then
			post SetItem( row,"con_lis_articolo_cambio",ldc_cambio )
		end if
		
	case 'con_lis_articolo_data_fine'	
		ld_data_fine 	= date(data)
		ld_data_inizio	= this.GetItemDate( row,"con_lis_articolo_data_inizio" )
		if not isNull(ld_data_inizio) and not isNull(ld_data_fine) then
			if ld_data_fine < ld_data_inizio then
				return 1
			end if
		end if
		
	case 'con_lis_articolo_qta_massima'
		ldc_qta_massima	= dec(data)
		ldc_qta_minima		= this.uf_GetItemDecimal( row,"con_lis_articolo_qta_minima" )
		if not isNull(ldc_qta_massima) and not isNull(ldc_qta_minima) then
			if ldc_qta_massima < ldc_qta_minima then
				return 1
			end if
		end if
			
end choose
end event

event ue_validate_row;call super::ue_validate_row;date	ld_data_fine,ld_data_inizio
ld_data_fine 	= this.GetItemDate( al_row,"con_lis_articolo_data_fine" )
ld_data_inizio	= this.GetItemDate( al_row,"con_lis_articolo_data_inizio" )
if not isNull(ld_data_inizio) and not isNull(ld_data_fine) then
	if ld_data_fine < ld_data_inizio then
		as_error_text	= "Data inizio maggiore di data fine"
		return 1
	end if
end if

return 0

end event

