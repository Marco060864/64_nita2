forward
global type w_caus_magazzino_ff from w_p_data
end type
type dw_caus_magazzino_ff from u_dw_master_main within w_caus_magazzino_ff
end type
end forward

global type w_caus_magazzino_ff from w_p_data
int Width=2716
int Height=1617
boolean TitleBar=true
string Title="Causali Magazzino"
dw_caus_magazzino_ff dw_caus_magazzino_ff
end type
global w_caus_magazzino_ff w_caus_magazzino_ff

forward prototypes
public function integer uf_gruppi ()
end prototypes

public function integer uf_gruppi ();


string	ls_gr_1, ls_gr_2, ls_gr_3, ls_gr_4, ls_nulla
long		ll_azienda, ll_row

ls_nulla		="<Nessuna Descrizione>"
ll_row		= dw_caus_magazzino_ff.getrow()
ll_azienda	= dw_caus_magazzino_ff.getitemnumber(ll_row, "id_azienda")  
 SELECT "par_sistema"."des_riep_gr1",   
         "par_sistema"."des_riep_gr2",   
         "par_sistema"."des_riep_gr3",   
         "par_sistema"."des_riep_gr4"  
    INTO :ls_gr_1,   
         :ls_gr_2,   
         :ls_gr_3,   
         :ls_gr_4  
    FROM "par_sistema",   
   WHERE ( "par_sistema"."id_azienda" = :ll_azienda );
	
if isnull(ls_gr_1) or ls_gr_1 =	"" then
	dw_caus_magazzino_ff.setitem(ll_row,"mp_gruppo_lib_1_t",ls_nulla)
else
	dw_caus_magazzino_ff.setitem(ll_row,"mp_gruppo_lib_1_t",ls_gr_1)
end if
if isnull(ls_gr_2) or ls_gr_2 =	"" then
	dw_caus_magazzino_ff.setitem(ll_row,"mp_gruppo_lib_2_t",ls_nulla)
else
	dw_caus_magazzino_ff.setitem(ll_row,"mp_gruppo_lib_2_t",ls_gr_2)
end if
if isnull(ls_gr_3) or ls_gr_3 =	"" then
	dw_caus_magazzino_ff.setitem(ll_row,"mp_gruppo_lib_3_t",ls_nulla)
else
	dw_caus_magazzino_ff.setitem(ll_row,"mp_gruppo_lib_3_t",ls_gr_3)
end if
if isnull(ls_gr_4) or ls_gr_4 =	"" then
	dw_caus_magazzino_ff.setitem(ll_row,"mp_gruppo_lib_4_t",ls_nulla)
else
	dw_caus_magazzino_ff.setitem(ll_row,"mp_gruppo_lib_4_t",ls_gr_4)
end if
return 0
end function

event open;call super::open;il_HelpTopic = 75
idw_master = dw_caus_magazzino_ff
idw_master.is_list = Message.PowerObjectParm

if Upperbound(idw_master.is_list.s_identifica)=0 then
	idw_master.ias_key_name[1] = "id_caus_magazzino"
	idw_master.is_list.s_modo=modo_inserisci
end if

idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_sql_ident[1] = "caus_magazzino.id_caus_magazzino"
ib_nonmodale=true






end event

on w_caus_magazzino_ff.create
int iCurrent
call w_p_data::create
this.dw_caus_magazzino_ff=create dw_caus_magazzino_ff
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=dw_caus_magazzino_ff
end on

on w_caus_magazzino_ff.destroy
call w_p_data::destroy
destroy(this.dw_caus_magazzino_ff)
end on

event ue_master_delete;call super::ue_master_delete;
integer li_ret
li_ret = MessageBox("ATTENZIONE","Confermi l'eliminazione del Record", StopSign!, YesNo!, 2 )
if li_ret = 1 then
			dw_caus_magazzino_ff.deleterow(0)
			dw_caus_magazzino_ff.update()
			
			dw_caus_magazzino_ff.insertrow(0)
end if
end event

type p_crescente from w_p_data`p_crescente within w_caus_magazzino_ff
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_caus_magazzino_ff
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_caus_magazzino_ff
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_caus_magazzino_ff
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_caus_magazzino_ff
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_caus_magazzino_ff
int X=1783
boolean Visible=false
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_caus_magazzino_ff
int X=2081
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_caus_magazzino_ff
int X=2378
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_caus_magazzino_ff
int X=1898
int Y=1001
int Width=481
int Height=481
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
long BackColor=79741120
end type

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=19
int Y=105
int Width=444
int Height=361
end type

type cb_ricerca from w_p_data`cb_ricerca within w_caus_magazzino_ff
boolean BringToTop=true
end type

event cb_ricerca::clicked;call super::clicked;string ls_filtro,ls_codice
long ll_seg_value
w_search_main lw_sm
ls_codice=""
idw_master.is_ricpar.s_filter_value=ls_codice
idw_master.is_ricpar.s_filter_name="codice"
openwithparm(lw_sm,idw_master.is_ricpar,"w_caus_mag_sw")
idw_master.is_ricpar=message.powerobjectparm
if upperbound(idw_master.is_ricpar.s_id_seg_value)>0 then
	ll_seg_value=long(idw_master.is_ricpar.s_id_seg_value[1])
	idw_master.is_list.s_modo=modo_modifica
	idw_master.is_list.s_identifica[1]="id_caus_magazzino"
	idw_master.is_list.l_identifica[1]=ll_seg_value
	idw_master.event ue_retrieve(0,0)
	idw_master.setfocus()
end if
end event

type dw_caus_magazzino_ff from u_dw_master_main within w_caus_magazzino_ff
int X=46
int Y=161
int Width=2606
int Height=1341
int TabOrder=10
string DataObject="d_caus_magazzino_ff"
end type

event ue_initial;call super::ue_initial;uf_gruppi()
end event

event ue_retrieve;call super::ue_retrieve;uf_gruppi()
end event

