forward
global type w_pag_prep_bollato_gd from w_np_single_data
end type
end forward

global type w_pag_prep_bollato_gd from w_np_single_data
integer width = 2798
string title = "Contatori Pagine Preparate"
end type
global w_pag_prep_bollato_gd w_pag_prep_bollato_gd

type variables
datawindowchild   ldw_registro
end variables

forward prototypes
public subroutine wf_trova_anno_esercizio (long ll_data, long row)
end prototypes

public subroutine wf_trova_anno_esercizio (long ll_data, long row);

date ld_inizio, ld_fine
integer ll_y_inizio, ll_y_fine

select data_inizio, data_fine
into :ld_inizio, :ld_fine
from esercizio
where id_esercizio=:ll_data;
if sqlca.sqlcode=0 then
	ll_y_inizio=year(ld_inizio)
	ll_y_fine=year(ld_fine)
	if ll_y_inizio=ll_y_fine then 
		dw_single.setitem(row,"s_anno",string(ll_y_inizio))
	else
		dw_single.setitem(row,"s_anno",Right(string(ll_y_inizio), 2)+'/'+Right(string(ll_y_fine), 2) )
	end if
	dw_single.setitem(row, "anno", integer(dw_single.getitemstring(row, "s_anno")))
else
	messagebox("Errore!", "Date esercizio non recuperate!")
end if
end subroutine

on w_pag_prep_bollato_gd.create
call super::create
end on

on w_pag_prep_bollato_gd.destroy
call super::destroy
end on

event ue_post_open;call super::ue_post_open;
integer i
long ll_id_esercizio
for i= 1 to dw_single.rowcount()
	ll_id_esercizio=dw_single.getitemnumber(i, "id_esercizio")
	wf_trova_anno_esercizio(ll_id_esercizio, i)
next








end event

type p_msg_log from w_np_single_data`p_msg_log within w_pag_prep_bollato_gd
end type

type p_crescente from w_np_single_data`p_crescente within w_pag_prep_bollato_gd
end type

type p_decrescente from w_np_single_data`p_decrescente within w_pag_prep_bollato_gd
end type

type dw_single from w_np_single_data`dw_single within w_pag_prep_bollato_gd
integer width = 2693
string dataobject = "d_riep_contatori_bollato_ff"
boolean hscrollbar = false
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

event dw_single::itemchanged;
long ll_data, ll_y_inizio, ll_y_fine, li_ret
date ld_inizio, ld_fine
string ls_anno, ls_tipo



choose case dwo.name
	case 	"id_esercizio"
		ll_data=long(data)
		wf_trova_anno_esercizio(ll_data, row)
    
	
		
	case "id_registro", "id_registro_des"	
		select tipo_registro
		into :ls_tipo
		from registro
		where id_registro=:data;
		li_ret=dw_single.setitem(row,"tipo_registro",ls_tipo)
		
end choose		
end event

event dw_single::itemfocuschanged;call super::itemfocuschanged;   string dw_filter
	long ll_data
	
	  dw_single.getchild("id_registro",ldw_registro)
     ldw_registro.settransobject(sqlca)

	
	
	
	if dwo.name= "id_registro" or dwo.name="id_registro_des" then
	  
	  ll_data=dw_single.getitemnumber(row,'id_esercizio')
	  if not isnull(ll_data) then
	  dw_filter="id_esercizio=long('" +string(ll_data) +"')"  
     ldw_registro.setfilter(dw_filter)
	  ldw_registro.filter()
     end if
	
	
   end if		
end event

