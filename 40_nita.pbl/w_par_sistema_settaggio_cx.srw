forward
global type w_par_sistema_settaggio_cx from w_p_data
end type
type dw_parametri_report_ff from u_dw_master_main within tabpage_1
end type
type dw_parametri_report_ff from u_dw_master_main within tabpage_1
end type
end forward

global type w_par_sistema_settaggio_cx from w_p_data
int Width=2098
int Height=1584
boolean TitleBar=true
string Title="Profili di stampa"
end type
global w_par_sistema_settaggio_cx w_par_sistema_settaggio_cx

type variables
boolean ib_control_save
end variables

forward prototypes
public subroutine wf_get_printer ()
end prototypes

public subroutine wf_get_printer ();
char		lc_array[], lc_temp[]	
long		ll_size,ll_i		
integer	li_rtn,li_count, li_env
string	ls_subkeylist[]
string   ls_regKey,ls_value,ls_default,ls_temp,ls_devices[]

stampanti str_parametri

environment env
li_env = GetEnvironment(env)

if li_env <> 1 then return 

ls_regKey	= "HKEY_LOCAL_MACHINE\System\CurrentControlSet\control\Print\Printers"

choose case env.OsType
	case Windows!
		ls_default	= "HKEY_CURRENT_CONFIG\System\CurrentControlSet\Control\Print\Printers"		
	case WindowsNT!
		ls_default	= "HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\Windows"		
end choose	



		
if RegistryKeys( ls_regKey,ls_subkeylist ) = -1 then
	MessageBox( "Errore","Errore nel leggere il registry",StopSign! )
	return 
end if

ll_size = UpperBound( ls_subkeylist )
if ll_size > 0 then
	
	
	for ll_i = 1 to ll_size 
		if RegistryGet( ls_regkey + "\" + ls_subkeylist[ll_i],"Name",ls_value ) = -1 then
			MessageBox( "Errore","Reading Subkey value",StopSign! )
			return 
		end if	
		
	next	
end if	


str_parametri.stampanti=ls_subkeylist
if RegistryGet( ls_default,"Default",ls_value )= -1 then ls_value='false'
str_parametri.defoult=ls_value

OpenWithParm(w_stampanti_lt, str_parametri)
ls_value=Message.StringParm	

tab_1.tabpage_1.dw_parametri_report_ff.setitem(1,"profilo_stampa_stampante",ls_value)

end subroutine

on w_par_sistema_settaggio_cx.create
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
end on

on w_par_sistema_settaggio_cx.destroy
call super::destroy
end on

event open;call super::open;idw_master = tab_1.tabpage_1.dw_parametri_report_ff

idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_sql_ident[1] = "profilo_stampa.id_proflo_stampa"

idw_master.is_list.s_modo = modo_inserisci
ib_nonmodale = true

ib_control_save = False
end event

event ue_post_open;call super::ue_post_open;string	ls_title
long 		ll_row 

u_freddie.iw_current = this





end event

type p_crescente from w_p_data`p_crescente within w_par_sistema_settaggio_cx
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_par_sistema_settaggio_cx
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_par_sistema_settaggio_cx
int X=32
int Width=238
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_par_sistema_settaggio_cx
int X=293
int Width=238
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_par_sistema_settaggio_cx
int X=553
int Width=238
boolean BringToTop=true
end type

event cb_nuovo::clicked;call super::clicked;ib_control_save = False
end event

type cb_inserisci from w_p_data`cb_inserisci within w_par_sistema_settaggio_cx
int X=1253
int Width=238
boolean Visible=false
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_par_sistema_settaggio_cx
int X=1527
int Width=238
boolean Visible=false
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_par_sistema_settaggio_cx
int X=1801
int Width=238
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_par_sistema_settaggio_cx
int X=37
int Y=164
int Width=2002
int Height=1304
boolean BringToTop=true
long BackColor=79741120
end type

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=18
int Y=104
int Width=1966
int Height=1184
long BackColor=79741120
string Text="Report"
long TabBackColor=79741120
dw_parametri_report_ff dw_parametri_report_ff
end type

on tabpage_1.create
this.dw_parametri_report_ff=create dw_parametri_report_ff
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_parametri_report_ff
end on

on tabpage_1.destroy
call super::destroy
destroy(this.dw_parametri_report_ff)
end on

type cb_ricerca from w_p_data`cb_ricerca within w_par_sistema_settaggio_cx
int X=1417
int Width=238
boolean BringToTop=true
end type

event cb_ricerca::clicked;



w_search_main 		lw_sm
string 				ls_filtro, ls_codice,  ls_parte_codice, ls_descrizione, ls_cod_cat_codifica
s_ric_param			ls_ric_param	
date					ld_data
integer				li_risposta, li_retvalue, li_size, li_count
long				   ll_id_stampa, ll_row
boolean				lb_1
u_dw_master_main	ldw_gen

ldw_gen= tab_1.tabpage_1.dw_parametri_report_ff
If ldw_gen.AcceptText() > 0 then
	ll_row= ldw_gen.GetRow()
	idw_master.is_ricpar.s_filter_value = 	""
	idw_master.is_ricpar.s_filter_name = "nome_report"
end if
		

OpenWithParm(lw_sm, idw_master.is_ricpar, "w_profilo_stampa_lt")

ls_ric_param= Message.PowerObjectParm
if not IsNull(ls_ric_param) then 
	idw_master.is_ricpar=ls_ric_param
	IF UpperBound(idw_master.is_ricpar.s_id_seg_value) > 0 THEN
		if idw_master.uf_to_update() > 0 then
				
				
				if ib_control_save = true then 
					li_risposta = MessageBox(idw_master.is_title, "Ci sono modifiche non salvate nella " + &
						"finestra.~n~rVuoi salvarle?", Question!, YesNo!,1)
					CHOOSE CASE li_risposta
						CASE 1
							
							li_retvalue=idw_master.event ue_update (0,0)
						CASE 2
							
							li_retvalue=0
					END CHOOSE
					ib_control_save = false 
				end if 
			end if
			ll_id_stampa=long(idw_master.is_ricpar.s_id_seg_value[1])
		   tab_1.tabpage_1.dw_parametri_report_ff.retrieve(ll_id_stampa)
		end if	
	end if     

end event

type dw_parametri_report_ff from u_dw_master_main within tabpage_1
int X=23
int Y=36
int Width=1925
int Height=1124
int TabOrder=30
boolean BringToTop=true
string DataObject="d_par_sistema_report_ff"
end type

event itemchanged;choose case dwo.name
	case "titolo_finestra"
		u_freddie.iw_current.Title = "Stampa : " + data
end choose


ib_control_save = True
end event

event ue_init;call super::ue_init;

is_title = "Parametri di Stampa"




end event

event clicked;call super::clicked;string ls_file, ls_path
integer li_ret
if dwo.name='cerca_file' then
	getfileopenname("Cerca report", ls_path, ls_file)
	if  not(trim(ls_file)="" or isnull(ls_file)) then
	li_ret=messagebox("Richiesta conferma!","Vuoi riportare il solo nome del file?", Information!,yesno! )
	if  li_ret=1 then
		setitem(row, "nome_report", ls_file)
	else
		setitem(row, "nome_report", ls_path)
	end if
end if
end if


if dwo.name='stampa_sw' then
     wf_get_printer()
end if

end event

