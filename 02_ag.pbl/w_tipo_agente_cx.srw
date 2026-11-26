forward
global type w_tipo_agente_cx from w_p_data
end type
type dw_tipo_agente_ff from u_dw_master_main within w_tipo_agente_cx
end type
type dw_scag_enasarco_gd from u_dw_master_main within w_tipo_agente_cx
end type
type st_2 from statictext within w_tipo_agente_cx
end type
end forward

global type w_tipo_agente_cx from w_p_data
int Width=2203
int Height=1296
boolean TitleBar=true
string Title="Tipo Agente"
dw_tipo_agente_ff dw_tipo_agente_ff
dw_scag_enasarco_gd dw_scag_enasarco_gd
st_2 st_2
end type
global w_tipo_agente_cx w_tipo_agente_cx

forward prototypes
public subroutine wf_controlla_update ()
end prototypes

public subroutine wf_controlla_update ();long ll_rows,i,j
date ld_per_riga,ld_per_cont,ld_per_app,ld_null,ld_fine
string ls_tipo_sconto
setnull(ld_null)
ll_rows=dw_scag_enasarco_gd.rowcount()
for i=1 to ll_rows
	ld_per_cont= date('01/01/1800')
	ld_per_riga=dw_scag_enasarco_gd.getitemdate(i,"data_inizio")
	if not isnull(ld_per_riga) then
		if i>1 then
			for j=i -1 to 1 step -1
				ld_per_app=dw_scag_enasarco_gd.getitemdate(j,"data_fine")
				if ld_per_app>ld_per_cont then ld_per_cont=ld_per_app
			next
			if ld_per_riga<=ld_per_cont then 
				dw_scag_enasarco_gd.setitem(i,"data_inizio",RelativeDate(ld_per_cont,1))
				ld_per_riga=RelativeDate(ld_per_cont,1)
			end if
			ld_per_app=dw_scag_enasarco_gd.getitemdate(i,"data_fine")
			if ld_per_app<=ld_per_riga  or isnull(ld_per_app) then
				if i<dw_scag_enasarco_gd.rowcount() then
					ld_fine=dw_scag_enasarco_gd.getitemdate(i+1,"data_inizio")
				else
					ld_fine=dw_scag_enasarco_gd.getitemdate(i,"data_inizio")
				end if
				dw_scag_enasarco_gd.setitem(i,"data_fine",RelativeDate(ld_fine, -1))
			end if
		end if
	else
		dw_scag_enasarco_gd.setitem(i,"data_fine",ld_null)
	end if
next

end subroutine

on w_tipo_agente_cx.create
int iCurrent
call super::create
this.dw_tipo_agente_ff=create dw_tipo_agente_ff
this.dw_scag_enasarco_gd=create dw_scag_enasarco_gd
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_tipo_agente_ff
this.Control[iCurrent+2]=this.dw_scag_enasarco_gd
this.Control[iCurrent+3]=this.st_2
end on

on w_tipo_agente_cx.destroy
call super::destroy
destroy(this.dw_tipo_agente_ff)
destroy(this.dw_scag_enasarco_gd)
destroy(this.st_2)
end on

event open;call super::open;idw_master = dw_tipo_agente_ff
idw_master.is_list = Message.PowerObjectParm
IF UpperBound(idw_master.is_list.s_identifica) = 0 THEN
	idw_master.ias_key_name[1] = "id_tipo_agente"
	idw_master.is_list.s_modo = modo_inserisci
END IF
idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_SQL_ident[1] = "tipo_agente.id_tipo_agente"
ib_nonmodale=true
end event

event ue_post_open;call super::ue_post_open;
end event

event ue_master_delete;call super::ue_master_delete;dw_tipo_agente_ff.deleterow(dw_tipo_agente_ff.getrow())
cb_nuovo.event trigger clicked()
end event

type p_crescente from w_p_data`p_crescente within w_tipo_agente_cx
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_tipo_agente_cx
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_tipo_agente_cx
int X=37
int Y=32
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_tipo_agente_cx
int X=329
int Y=32
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_tipo_agente_cx
int X=622
int Y=32
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_tipo_agente_cx
int X=1317
int Y=32
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_tipo_agente_cx
int X=1609
int Y=32
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_tipo_agente_cx
int X=1902
int Y=32
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_tipo_agente_cx
int Y=1440
int Height=40
int TabOrder=30
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
long BackColor=79741120
end type

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=18
int Y=104
int Width=2322
end type

type cb_ricerca from w_p_data`cb_ricerca within w_tipo_agente_cx
int X=987
int Y=32
boolean BringToTop=true
end type

event cb_ricerca::clicked;call super::clicked;w_search_main lw_sm
long ll_id_tipo_agente
s_ric_param ls_ricpar
idw_master.is_ricpar.s_filter_value = ""
idw_master.is_ricpar.s_filter_name = "codice"
OpenWithParm(lw_sm, idw_master.is_ricpar, "w_tipo_agente_sw")
idw_master.is_ricpar = Message.PowerObjectParm
IF UpperBound(idw_master.is_ricpar.s_id_seg_value) > 0 THEN
	ll_id_tipo_agente = long(idw_master.is_ricpar.s_id_seg_value[1])
	idw_master.is_list.s_modo = modo_modifica
	idw_master.is_list.s_identifica[1] = "id_tipo_agente"
	idw_master.is_list.l_identifica[1] = ll_id_tipo_agente
	idw_master.Event ue_retrieve(0, 0)
END IF
idw_master.SetFocus()
end event

type dw_tipo_agente_ff from u_dw_master_main within w_tipo_agente_cx
int X=37
int Y=128
int Width=2126
int Height=196
int TabOrder=10
string DataObject="d_tipo_agente_ff"
end type

event ue_init;call super::ue_init;is_list.s_identifica[1]="id_tipo_agente"
iudw_children[1] = dw_scag_enasarco_gd
end event

type dw_scag_enasarco_gd from u_dw_master_main within w_tipo_agente_cx
int X=37
int Y=412
int Width=2126
int Height=776
int TabOrder=20
string DataObject="d_scag_enasarco_gd"
boolean VScrollBar=true
end type

event ue_init;call super::ue_init;is_title = "Scaglioni Enasarco"
is_list.s_identifica[1] = "id_tipo_agente"

end event

event ue_insert;call super::ue_insert;
long		ll_n_row
long		ll_row
long		ll_id_valuta
date		ld_data

ll_n_row = this.rowcount()
ll_row = this.getrow()

this.setitem(ll_row,"id_azienda",1)

if ll_n_row > 1 then
	ld_data = this.getitemdate(ll_n_row - 1,"data_fine")
	
	if not isnull(ld_data) then
		ld_data = RelativeDate(ld_data, 1)
		this.setitem(ll_row,"data_inizio",ld_data)
		this.sort()
		this.setrow(ll_n_row)
		this.setcolumn("data_inizio")
	else
		MESSAGEBOX("ERRORE!","Il periodo precedente non ha data Fine" ) 
		this.deleterow(ll_row)
	end if
end if
end event

event itemchanged;call super::itemchanged;
end event

event updatestart;call super::updatestart;long ll_row
ll_row=this.getrow()
this.sort()
this.setrow(ll_row)
wf_controlla_update()
end event

type st_2 from statictext within w_tipo_agente_cx
int X=37
int Y=336
int Width=2126
int Height=76
boolean Enabled=false
boolean BringToTop=true
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
string Text=" Scaglione Enasarco"
boolean FocusRectangle=false
long TextColor=1090519039
long BackColor=276856960
long BorderColor=276856960
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

