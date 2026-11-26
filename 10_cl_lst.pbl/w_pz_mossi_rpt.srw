forward
global type w_pz_mossi_rpt from w_stampa
end type
end forward

global type w_pz_mossi_rpt from w_stampa
integer width = 3611
long backcolor = 134217731
end type
global w_pz_mossi_rpt w_pz_mossi_rpt

forward prototypes
public subroutine wf_calcola_totali ()
end prototypes

public subroutine wf_calcola_totali ();integer i
long ll_sald, ll_rclf

for i= 1 to dw_1.rowcount()
	//ll_sald+=dw_1.getitemnumber(i, "c_pz_sald")
	//ll_rclf+=dw_1.getitemnumber(i, "c_pz_rclf")
	ll_sald+=long(dw_1.Object.c_pz_sald[i])
	ll_rclf+=long(dw_1.Object.c_pz_rclf[i])
next

dw_1.object.t_tot_sald.text= string( ll_sald, "#,0")
dw_1.object.t_tot_rclf.text= string( ll_rclf, "#,0")

end subroutine

on w_pz_mossi_rpt.create
call super::create
end on

on w_pz_mossi_rpt.destroy
call super::destroy
end on

event open;call super::open;s_dw_ritorna s_dw


s_dw=message.powerobjectparm

dw_1.settransobject(sqlca)

dw_1.object.data=s_dw.ds.object.data
end event

event ue_postopen;call super::ue_postopen;post wf_calcola_totali()
end event

type pb_1 from w_stampa`pb_1 within w_pz_mossi_rpt
end type

type cb_preview from w_stampa`cb_preview within w_pz_mossi_rpt
end type

type dw_1 from w_stampa`dw_1 within w_pz_mossi_rpt
integer width = 3493
string dataobject = "d_pz_mossi_gd"
end type

type pb_salva_su_file from w_stampa`pb_salva_su_file within w_pz_mossi_rpt
end type

type pb_stampa from w_stampa`pb_stampa within w_pz_mossi_rpt
end type

type sle_pg from w_stampa`sle_pg within w_pz_mossi_rpt
end type

type st_1 from w_stampa`st_1 within w_pz_mossi_rpt
end type

type st_2 from w_stampa`st_2 within w_pz_mossi_rpt
end type

type sle_copie from w_stampa`sle_copie within w_pz_mossi_rpt
end type

type sle_zoom from w_stampa`sle_zoom within w_pz_mossi_rpt
end type

type cb_7 from w_stampa`cb_7 within w_pz_mossi_rpt
end type

type cb_6 from w_stampa`cb_6 within w_pz_mossi_rpt
end type

type cb_pg_dopo from w_stampa`cb_pg_dopo within w_pz_mossi_rpt
end type

type cb_pg_prima from w_stampa`cb_pg_prima within w_pz_mossi_rpt
end type

type cb_esci from w_stampa`cb_esci within w_pz_mossi_rpt
end type

