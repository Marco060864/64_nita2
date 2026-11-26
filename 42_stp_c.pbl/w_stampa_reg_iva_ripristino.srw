forward
global type w_stampa_reg_iva_ripristino from w_stampa_reg_iva_rpt
end type
type st_1 from statictext within w_stampa_reg_iva_ripristino
end type
end forward

global type w_stampa_reg_iva_ripristino from w_stampa_reg_iva_rpt
int Height=1516
st_1 st_1
end type
global w_stampa_reg_iva_ripristino w_stampa_reg_iva_ripristino

on w_stampa_reg_iva_ripristino.create
int iCurrent
call super::create
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
end on

on w_stampa_reg_iva_ripristino.destroy
call super::destroy
destroy(this.st_1)
end on

type cb_ok from w_stampa_reg_iva_rpt`cb_ok within w_stampa_reg_iva_ripristino
int X=37
int Y=96
boolean BringToTop=true
end type

event cb_ok::clicked;
string ls_tipo_registro,ls_flag_registri,ls_filtro,ls_flag_definitiva,ls_ret,ls_filtro_rip
long ll_row,ll_n_registro,ll_id_attivita,ll_id_esercizio,ll_id_registro,num_progressivo_rip,ll_n_registro2
date ld_dalla_data,ld_alla_data,data_ripristino
reg_iva_parametri str_param

dw_1.accepttext()
ll_row=dw_1.getrow()
ls_tipo_registro=dw_1.getitemstring(ll_row,"tipo_registro")
ld_dalla_data=dw_1.getitemdate(ll_row,"dalla_data")
ld_alla_data=dw_1.getitemdate(ll_row,"alla_data")
ls_flag_registri=dw_1.getitemstring(ll_row,"tutti_reg")
ll_n_registro=dw_1.getitemnumber(ll_row,"numero_registro")
ls_flag_definitiva=dw_1.getitemstring(ll_row,"elab_prova")
data_ripristino=dw_1.getitemdate(ll_row,"dalla_data_ripristino")
num_progressivo_rip=dw_1.getitemnumber(ll_row,"num_progressivo")
ls_ret='OK'


if ls_flag_registri="S" then 
	ls_filtro=""
else
	ls_filtro="numero= "+string(ll_n_registro)
end if
if ls_ret='OK'then
	
	ls_tipo_registro=dw_1.getitemstring(1,"tipo_registro")
	ll_n_registro=dw_1.getitemnumber(1,"numero_registro")
	ll_n_registro2=dw_1.getitemnumber(1,"numero_registro")
	ll_id_attivita=dw_1.getitemnumber(1,"id_attivita")
	
	IF isnull (ll_n_registro) then
			ll_n_registro = 0
			ll_n_registro2 = 100
	end if
			 
			ll_id_esercizio=dw_1.getitemnumber(1,"registro")
				select "registro"."id_registro"
				into :ll_id_registro
				from "registro"
				where ("registro"."tipo_registro"=:ls_tipo_registro)and
						("registro"."id_attivita"=:ll_id_attivita)and
						(("registro"."numero">=:ll_n_registro) and ("registro"."numero"<=:ll_n_registro2)) and
						("registro"."id_esercizio"=:ll_id_esercizio);
	
if ls_flag_registri='S'then
	ls_filtro_rip="data_registrazione>=date('"+string(data_ripristino)+"') and num_progressivo>="+string(num_progressivo_rip)
else
	ls_filtro_rip="("+ls_filtro+") and (data_registrazione>=date('"+string(data_ripristino)+"')) and (num_progressivo>="+string(num_progressivo_rip)+")"
		
end if	

str_param.tipo_registro=ls_tipo_registro
str_param.dalla_data=ld_dalla_data
str_param.alla_data=ld_alla_data
str_param.ls_filtro=ls_filtro
str_param.ls_flag_definitiva=ls_flag_definitiva
str_param.ll_n_registro=ll_n_registro
str_param.ll_id_registro=ll_id_registro
str_param.ll_id_attivita=ll_id_attivita
str_param.ll_id_esercizio=ll_id_esercizio
str_param.ls_filtro_rip=ls_filtro_rip
str_param.flag_ripristino='S'

openwithparm(w_stampa_registri_iva,str_param)
end if 










end event

type cb_annulla from w_stampa_reg_iva_rpt`cb_annulla within w_stampa_reg_iva_ripristino
int X=329
int Y=96
boolean BringToTop=true
end type

type dw_1 from w_stampa_reg_iva_rpt`dw_1 within w_stampa_reg_iva_ripristino
int Y=292
int Width=1659
int Height=1120
string DataObject="d_registri_iva_ripristino"
end type

type st_1 from statictext within w_stampa_reg_iva_ripristino
int X=626
int Y=40
int Width=1047
int Height=220
boolean Enabled=false
boolean BringToTop=true
string Text="Utility di ripristino Stampa interrotta: immettere i dati relativi alla stampa originale da recuperare e indicare la data e il numero progressivo in cui si è interrotta. "
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

