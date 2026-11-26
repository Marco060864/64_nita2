forward
global type w_contatori_registri_gd from w_np_single_data
end type
end forward

global type w_contatori_registri_gd from w_np_single_data
int Width=2130
int Height=860
boolean TitleBar=true
string Title="Contatori Registri"
end type
global w_contatori_registri_gd w_contatori_registri_gd

type variables
datawindowchild ldw_registro
end variables

on w_contatori_registri_gd.create
call super::create
end on

on w_contatori_registri_gd.destroy
call super::destroy
end on

event open;call super::open;

dw_single.getchild("id_registro",ldw_registro)
ldw_registro.settransobject(sqlca)
ldw_registro.retrieve()
end event

type p_crescente from w_np_single_data`p_crescente within w_contatori_registri_gd
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_contatori_registri_gd
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_contatori_registri_gd
int X=32
int Width=2016
string DataObject="d_contatori_registri_gd"
end type

event dw_single::ue_update;long ll_RetVal
string ls_pwd
s_any_array lstr_any_array
messagebox("Attenzione!", "La modifica dei valori in atto può pregiudicare~r~n la coerenza dei dati del sistema."+&
"Per salvare i dati inserire la password")
OpenWithParm(w_wizard_pwd_contatori_ff, lstr_any_array)
lstr_any_array = Message.PowerObjectParm

ls_pwd = lstr_any_array.s_array[1]

IF ls_pwd = "cometa" THEN
	Super::Event ue_update(0,0)
ELSE
	MessageBox("Wizard", "Password errata.")
END IF

end event

event dw_single::ue_delete;long ll_RetVal
string ls_pwd
s_any_array lstr_any_array
messagebox("Attenzione!", "La modifica dei valori in atto può pregiudicare~r~n la coerenza dei dati del sistema."+&
"Per salvare i dati inserire la password")
OpenWithParm(w_wizard_pwd_contatori_ff, lstr_any_array)
lstr_any_array = Message.PowerObjectParm

ls_pwd = lstr_any_array.s_array[1]

IF ls_pwd = "cometa" THEN
	Super::Event ue_delete(0,0)
ELSE
	MessageBox("Wizard", "Password errata.")
END IF

end event

event dw_single::itemchanged;string DWfilter2
char lc_tipologia[2]
long ll_data


choose case dwo.name
   
    case "id_registro"
		      
				
				ll_data=long(data)
			   select tipo_registro
				into :lc_tipologia
            from registro
            where id_registro=:ll_data;
		      this.setitem(row,"tipologia",lc_tipologia)

end choose

end event

