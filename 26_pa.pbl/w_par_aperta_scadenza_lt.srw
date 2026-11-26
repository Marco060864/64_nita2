forward
global type w_par_aperta_scadenza_lt from w_list_main
end type
type cb_1 from commandbutton within w_par_aperta_scadenza_lt
end type
end forward

global type w_par_aperta_scadenza_lt from w_list_main
int Width=1577
WindowType WindowType=response!
boolean TitleBar=true
string Title="Scadenze"
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
cb_1 cb_1
end type
global w_par_aperta_scadenza_lt w_par_aperta_scadenza_lt

type variables
long il_id_par_aperta
end variables

on w_par_aperta_scadenza_lt.create
int iCurrent
call super::create
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
end on

on w_par_aperta_scadenza_lt.destroy
call super::destroy
destroy(this.cb_1)
end on

event open;call super::open;string las_param[]

ias_key_name[1] = "id_scadenza"
u_freddie.sp_pop(las_param)
il_id_par_aperta = long(las_param[1])
end event

event ue_post_open;call super::ue_post_open;cb_1.SetFocus ( )
end event

type p_crescente from w_list_main`p_crescente within w_par_aperta_scadenza_lt
boolean BringToTop=true
end type

type p_decrescente from w_list_main`p_decrescente within w_par_aperta_scadenza_lt
boolean BringToTop=true
end type

type dw_list from w_list_main`dw_list within w_par_aperta_scadenza_lt
int X=5
int Y=156
int Width=1550
int Height=808
string DataObject="d_par_aperta_scadenza_lt"
end type

event dw_list::ue_init;call super::ue_init;is_title = "Scadenze"
is_resp_window = "w_Scadenza_cx"

end event

event dw_list::ue_retrieve;call super::ue_retrieve;string ls_filtro

ls_filtro = "par_aperta.id_par_aperta = " + string(il_id_par_aperta)

iu_scan.f_reset_cur_as_ini()
if ls_filtro <> "" then
	iu_scan.f_add_where_condition(ls_filtro)
end if
THIS.object.datawindow.table.select = iu_scan.f_getcurrent()
Retrieve()


end event

type cb_1 from commandbutton within w_par_aperta_scadenza_lt
int X=9
int Y=24
int Width=603
int Height=108
int TabOrder=10
boolean BringToTop=true
string Text="OK"
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(parent)
end event

