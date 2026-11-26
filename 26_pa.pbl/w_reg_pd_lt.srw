forward
global type w_reg_pd_lt from w_list_main
end type
end forward

global type w_reg_pd_lt from w_list_main
int Width=2798
end type
global w_reg_pd_lt w_reg_pd_lt

on w_reg_pd_lt.create
call w_list_main::create
end on

on w_reg_pd_lt.destroy
call w_list_main::destroy
end on

event open;call super::open;ias_key_name[1] = "id_reg_pd"

end event

type p_crescente from w_list_main`p_crescente within w_reg_pd_lt
boolean BringToTop=true
end type

type p_decrescente from w_list_main`p_decrescente within w_reg_pd_lt
boolean BringToTop=true
end type

type dw_list from w_list_main`dw_list within w_reg_pd_lt
int Width=2675
string DataObject="d_reg_pd_lt"
end type

event dw_list::ue_init;call super::ue_init;is_title = "Registrazioni Prima Nota"
is_resp_window = "w_reg_pd_cx"


end event

event dw_list::ue_retrieve;

string ls_Filtro, ls_Parametro

ls_Parametro = THIS.is_list.s_win_parametri

CHOOSE CASE ls_Parametro
	CASE "PN"
		Parent.Title = "Registrazioni Prima Nota (PN)"
		ls_Filtro = f_tilde_quote("registro.tipo_registro") + " = '" + ls_Parametro + "'"
	CASE "MN"		
		Parent.Title = "Registrazioni Manageriali (MN)"
		ls_Filtro = f_tilde_quote("registro.tipo_registro") + " = '" + ls_Parametro + "'"
	CASE "PM"		
		Parent.Title = "Registrazioni Prima Nota/Manageriali (PN/MN)"
		ls_Filtro = f_tilde_quote("registro.tipo_registro") + " = 'PN' OR " + f_tilde_quote("registro.tipo_registro") + " = 'MN'"
	CASE "IA"		
		Parent.Title = "Registrazioni IVA Acquisti (IA)"
		ls_Filtro = f_tilde_quote("registro.tipo_registro") + " = '" + ls_Parametro + "'"
	CASE "IV"				
		Parent.Title = "Registrazioni IVA Vendite (IV)"
		ls_Filtro = f_tilde_quote("registro.tipo_registro") + " = '" + ls_Parametro + "'"		
	CASE "AV"
		Parent.Title = "Registrazioni IVA Acquisti/IVA Vendite (IA/IV)"
		ls_Filtro = f_tilde_quote("registro.tipo_registro") + " = 'IA' OR " + f_tilde_quote("registro.tipo_registro") + " = 'IV'"
	CASE "IC"
		Parent.Title = "Registrazioni IVA Corrispettivi (IC)"
		ls_Filtro = f_tilde_quote("registro.tipo_registro") + " = '" + ls_Parametro + "'"
	CASE "PI"
		Parent.Title = "Tutte le Registrazioni (PN/MN/IA/IV)"
		ls_filtro = ""
	CASE "MP"
		Parent.Title = "Contabilizzazione Registrazioni Manageriali"
		ls_Filtro = f_tilde_quote("registro.tipo_registro") + " = 'MN'"		
	CASE ELSE
		Parent.Title = "Tutte le Registrazioni (PN/MN/IA/IV)"
		ls_filtro = ""
END CHOOSE

iu_scan.f_reset_cur_as_ini()
if ls_filtro <> "" then
	iu_scan.f_add_where_condition(ls_filtro)
end if
THIS.object.datawindow.table.select = iu_scan.f_getcurrent()
Retrieve()

end event

event dw_list::ue_delete;

long ll_CurrRow, ll_IDReg_PD, ll_IDPar_Aperta, ll_RetVal
integer li_RetVal
ll_CurrRow = dw_list.GetRow()
li_RetVal = MessageBox("Registrazioni Prima Nota","Confermi l'eliminazione della registrazione?", Question!, YesNo!, 2)

IF ll_CurrRow > 0 AND li_RetVal = 1 THEN
	ll_IDReg_PD = dw_list.GetItemNumber(ll_CurrRow, "id_reg_pd")
	SQLCA.sp_Elimina_Reg_PD(ll_IDReg_PD, ll_RetVal)
	IF ll_RetVal <> 0 THEN
		MessageBox("Registrazioni Contabili", "Impossibile eliminare la registrazione.")
	END IF

	THIS.Event ue_retrieve(0,0)

END IF
end event

