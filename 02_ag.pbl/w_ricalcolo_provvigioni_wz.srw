forward
global type w_ricalcolo_provvigioni_wz from w_wiz_main
end type
type dw_ricalcolo_provvigioni_ext from u_dw_ext_main within w_ricalcolo_provvigioni_wz
end type
type cb_ricalcola from commandbutton within w_ricalcolo_provvigioni_wz
end type
type st_1 from statictext within w_ricalcolo_provvigioni_wz
end type
type st_3 from statictext within w_ricalcolo_provvigioni_wz
end type
type st_2 from statictext within w_ricalcolo_provvigioni_wz
end type
type st_4 from statictext within w_ricalcolo_provvigioni_wz
end type
end forward

global type w_ricalcolo_provvigioni_wz from w_wiz_main
int Width=1719
int Height=900
boolean TitleBar=true
string Title="Ricalcolo riepiloghi provvigioni"
dw_ricalcolo_provvigioni_ext dw_ricalcolo_provvigioni_ext
cb_ricalcola cb_ricalcola
st_1 st_1
st_3 st_3
st_2 st_2
st_4 st_4
end type
global w_ricalcolo_provvigioni_wz w_ricalcolo_provvigioni_wz

type variables
w_wait_01	iw_wait
end variables

on w_ricalcolo_provvigioni_wz.create
int iCurrent
call super::create
this.dw_ricalcolo_provvigioni_ext=create dw_ricalcolo_provvigioni_ext
this.cb_ricalcola=create cb_ricalcola
this.st_1=create st_1
this.st_3=create st_3
this.st_2=create st_2
this.st_4=create st_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_ricalcolo_provvigioni_ext
this.Control[iCurrent+2]=this.cb_ricalcola
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_3
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.st_4
end on

on w_ricalcolo_provvigioni_wz.destroy
call super::destroy
destroy(this.dw_ricalcolo_provvigioni_ext)
destroy(this.cb_ricalcola)
destroy(this.st_1)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_4)
end on

event open;call super::open;
dw_ricalcolo_provvigioni_ext.insertrow(0)
end event

type dw_ricalcolo_provvigioni_ext from u_dw_ext_main within w_ricalcolo_provvigioni_wz
int X=32
int Y=128
int Width=1618
int Height=644
int TabOrder=10
boolean BringToTop=true
string DataObject="d_ricalcolo_provvigioni_ext"
end type

type cb_ricalcola from commandbutton within w_ricalcolo_provvigioni_wz
int X=37
int Y=24
int Width=261
int Height=84
int TabOrder=20
boolean BringToTop=true
string Text="&Ricalcola"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
integer  	li_i, li_ret = 0
string		ls_select, ls_select_ini
decimal {0}	ld_da_num_progressivo, ld_a_num_progressivo
date			ldt_da_data_registrazione, ldt_a_data_registrazione
long			ll_id_documento
time 			lt_i, lt_f
datastore	lds_riep_provvigioni
u_liq_provvigioni lu_liq_provvigioni

open(iw_wait,"w_wait_01")

iw_wait.st_wait.text = "Ricalcolo delle provvigioni Agente"
iw_wait.st_wait_b.text = ""
lt_i = Now()
st_3.text = string(lt_i)


ld_da_num_progressivo = dw_ricalcolo_provvigioni_ext.getitemnumber(1, "da_num_progressivo")
ld_a_num_progressivo	 = dw_ricalcolo_provvigioni_ext.getitemnumber(1, "a_num_progressivo")

ldt_da_data_registrazione = dw_ricalcolo_provvigioni_ext.getitemdate(1, "da_data_registrazione")
ldt_a_data_registrazione  = dw_ricalcolo_provvigioni_ext.getitemdate(1, "a_data_registrazione")

lds_riep_provvigioni = CREATE datastore
lds_riep_provvigioni.dataobject = "ds_ricalcolo_provvigioni_gd"
lds_riep_provvigioni.settransobject(SQLCA)

ls_select_ini = lds_riep_provvigioni.Object.DataWindow.Table.select

ls_select = ls_select_ini + " WHERE riep_provvigioni.stato_provvigioni = 'C' "

if (ld_da_num_progressivo > 0) then
	ls_select = ls_select + " AND documento.num_progressivo >= " + string(ld_da_num_progressivo)
end if
if (ld_a_num_progressivo > 0) then
	ls_select = ls_select + " AND documento.num_progressivo <= " + string(ld_a_num_progressivo)
end if

if (not isnull(ldt_da_data_registrazione)) then
	ls_select = ls_select + " AND documento.data_registrazione >= '" + string(ldt_da_data_registrazione, 'yyyy-mm-dd') + "' "
end if
if (not isnull(ldt_a_data_registrazione)) then
	ls_select = ls_select + " AND documento.data_registrazione >= '" + string(ldt_a_data_registrazione, 'yyyy-mm-dd') + "' "
end if

lds_riep_provvigioni.Object.DataWindow.Table.select = ls_select
li_ret = lds_riep_provvigioni.retrieve()	

if (li_ret > 0) then
	messagebox("Attenzione", "Ci sono dei documenti utilizzati in una liquidazione definitiva")
	destroy lds_riep_provvigioni
	return
end if

ls_select = ls_select_ini

if (ld_da_num_progressivo > 0) then
	ls_select = ls_select + " WHERE documento.num_progressivo >= " + string(ld_da_num_progressivo)
end if
if (ld_a_num_progressivo > 0) then
	ls_select = ls_select + " AND documento.num_progressivo <= " + string(ld_a_num_progressivo)
end if

if (not isnull(ldt_da_data_registrazione)) then
	ls_select = ls_select + " AND documento.data_registrazione >= '" + string(ldt_da_data_registrazione, 'yyyy-mm-dd') + "' "
end if
if (not isnull(ldt_a_data_registrazione)) then
	ls_select = ls_select + " AND documento.data_registrazione >= '" + string(ldt_a_data_registrazione, 'yyyy-mm-dd') + "' "
end if

ls_select = ls_select + " ORDER BY documento.id_documento"

lds_riep_provvigioni.Object.DataWindow.Table.select = ls_select
li_ret = lds_riep_provvigioni.retrieve()	

lu_liq_provvigioni = CREATE u_liq_provvigioni

for li_i = 1 to li_ret
	ll_id_documento = lds_riep_provvigioni.getitemnumber(li_i, "id_documento")
	if (ll_id_documento > 0) then
		
		DELETE FROM	riep_prov_righe r
				 FROM	riep_provvigioni p
		WHERE r.id_riep_provvigioni = p.id_riep_provvigioni 
		AND	p.id_documento = :ll_id_documento
		;
		
		DELETE FROM	riep_provvigioni
		WHERE id_documento = :ll_id_documento
		;
		
		CHOOSE CASE SQLCA.SQLCODE
			CASE -1
				messagebox("DBError", SQLCA.SQLERRTEXT)
			CASE 0
				COMMIT USING SQLCA;
				lu_liq_provvigioni.uf_liq_provvigioni(ll_id_documento)
		END CHOOSE
	end if
next

destroy lu_liq_provvigioni
destroy lds_riep_provvigioni

lt_f = Now()
st_4.text = string(lt_f)

close(iw_wait)

end event

type st_1 from statictext within w_ricalcolo_provvigioni_wz
int X=361
int Y=32
int Width=165
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Inizio:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_ricalcolo_provvigioni_wz
int X=535
int Y=32
int Width=334
int Height=76
boolean Enabled=false
boolean BringToTop=true
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_ricalcolo_provvigioni_wz
int X=1134
int Y=32
int Width=133
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Fine:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_4 from statictext within w_ricalcolo_provvigioni_wz
int X=1275
int Y=32
int Width=334
int Height=76
boolean Enabled=false
boolean BringToTop=true
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

