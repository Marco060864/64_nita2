forward
global type w_riepilogo_lt from w_list_main
end type
end forward

global type w_riepilogo_lt from w_list_main
int Width=2597
int Height=1033
boolean TitleBar=true
string Title="Riepiloghi di Magazzino"
end type
global w_riepilogo_lt w_riepilogo_lt

on w_riepilogo_lt.create
call w_list_main::create
end on

on w_riepilogo_lt.destroy
call w_list_main::destroy
end on

event open;call super::open;il_HelpTopic = 381
ias_key_name[1]="riepilogo_id_esercizio"
ias_key_name[2]="riepilogo_id_attivita"
ias_key_name[3]="riepilogo_id_articolo"
ias_key_name[4]="riepilogo_id_locazione"
ias_key_name[5]="riepilogo_anno"
ias_key_name[6]="riepilogo_mese"
end event

event ue_post_open;call super::ue_post_open;String	ls_des_riep_gr1, ls_des_riep_gr2, ls_des_riep_gr3, ls_des_riep_gr4

SELECT des_riep_gr1, des_riep_gr2, des_riep_gr3, des_riep_gr4
INTO	 :ls_des_riep_gr1, :ls_des_riep_gr2, :ls_des_riep_gr3, :ls_des_riep_gr4
FROM	 par_sistema
;

If SQLCA.SQLCODE = 0 Then
	If not IsNull(ls_des_riep_gr1) Then
		dw_list.Object.riepilogo_qta_gruppo_lib_1_t.Text = ls_des_riep_gr1
	End If

	If not IsNull(ls_des_riep_gr2) Then
		dw_list.Object.riepilogo_qta_gruppo_lib_2_t.Text = ls_des_riep_gr2
	End If
	If not IsNull(ls_des_riep_gr3) Then
		dw_list.Object.riepilogo_qta_gruppo_lib_3_t.Text = ls_des_riep_gr3
	End If	
	If not IsNull(ls_des_riep_gr4) Then
		dw_list.Object.riepilogo_qta_gruppo_lib_4_t.Text = ls_des_riep_gr4
	End If	
End If
end event

type p_crescente from w_list_main`p_crescente within w_riepilogo_lt
boolean BringToTop=true
end type

type p_decrescente from w_list_main`p_decrescente within w_riepilogo_lt
boolean BringToTop=true
end type

type dw_list from w_list_main`dw_list within w_riepilogo_lt
int X=33
int Y=29
int Width=2497
string DataObject="d_riepilogo_lt"
BorderStyle BorderStyle=StyleLowered!
end type

event dw_list::ue_init;call super::ue_init;is_title = "Riepiloghi di Magazzino"

is_resp_window= "w_riepilogo_cx"

end event

event dw_list::ue_key;


string			ls_column, ls_style
w_data_main		lw_win
u_dw_main		lu_dw

choose case key
	
	case KeyF1!
		if (keyflags = 0 Or keyflags = 1 Or keyflags = 2) then
			
			u_freddie.iw_current.Event ue_help(Topic!, long(this.object.DataWindow.Help.TypeID.Retrieve.Argument), "")
		end if

end choose


end event

event dw_list::ue_insert;
end event

