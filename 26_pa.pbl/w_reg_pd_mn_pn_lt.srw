forward
global type w_reg_pd_mn_pn_lt from w_reg_pd_lt
end type
type cb_contabilizza from commandbutton within w_reg_pd_mn_pn_lt
end type
end forward

global type w_reg_pd_mn_pn_lt from w_reg_pd_lt
int Height=1201
cb_contabilizza cb_contabilizza
end type
global w_reg_pd_mn_pn_lt w_reg_pd_mn_pn_lt

type variables
long il_previous_currow

s_contabilizzazione is_parm
end variables

on w_reg_pd_mn_pn_lt.create
int iCurrent
call w_reg_pd_lt::create
this.cb_contabilizza=create cb_contabilizza
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=cb_contabilizza
end on

on w_reg_pd_mn_pn_lt.destroy
call w_reg_pd_lt::destroy
destroy(this.cb_contabilizza)
end on

event resize;il_HelpTopic = 29

dw_list.Width = newwidth - 80
dw_list.Height = newheight - 200

cb_contabilizza.x = (newwidth / 2) - (cb_contabilizza.width / 2)
cb_contabilizza.y = newheight - 120
end event

type p_crescente from w_reg_pd_lt`p_crescente within w_reg_pd_mn_pn_lt
boolean BringToTop=true
end type

type p_decrescente from w_reg_pd_lt`p_decrescente within w_reg_pd_mn_pn_lt
boolean BringToTop=true
end type

type dw_list from w_reg_pd_lt`dw_list within w_reg_pd_mn_pn_lt
event ue_contabilizza ( )
end type

event dw_list::ue_contabilizza;call super::ue_contabilizza;

long ll_i, ll_Rows, ll_id_reg_pd, ll_num_progressivo 
integer li_RetVal
date ld_data_registrazione 
string ls_prog_scritture
string ls_descr_registro
ll_Rows = THIS.RowCount()

FOR ll_i = 1 TO ll_Rows
	IF IsSelected(ll_i) THEN
		ll_id_reg_pd = THIS.GetItemNumber(ll_i, "id_reg_pd")
		
		  SELECT "esercizio"."prog_scritture"
			 INTO :ls_prog_scritture   
			 FROM "esercizio",   
					"registro"  
			WHERE ( "registro"."id_esercizio" = "esercizio"."id_esercizio" )   
			AND 	("registro"."id_registro"=:is_parm.l_id_registro);

		ll_num_progressivo = f_proponi_num_reg_pd(is_parm.l_id_registro,ls_prog_scritture)
		
		UPDATE "dba"."reg_pd" 
			SET "id_registro"           = :is_parm.l_id_registro,
				 "num_progressivo"       = :ll_num_progressivo, 
			    "data_competenza"       = :is_parm.d_data_competenza,
			    "id_prof_registrazione" = :is_parm.l_id_prof_registrazione,
			  	 "data_registrazione"    = :is_parm.d_data_registrazione
			WHERE "dba"."reg_pd"."id_reg_pd" = :ll_id_reg_pd;
			
			
			
		CHOOSE CASE SQLCA.SQLCode
			CASE 0

				
			  SELECT "registro"."descrizione"  
				 INTO :ls_descr_registro  
				 FROM "reg_pd",   
						"registro"  
				WHERE ( "registro"."id_registro" = "reg_pd"."id_registro" ) and  
						( ( "reg_pd"."id_reg_pd" = :ll_id_reg_pd ) )   ;

				li_RetVal = MessageBox("Contabilizzazione Registrazioni Manageriali","Generata la registrazione numero " + &
											  string(ll_num_progressivo) + " con data " + &
											  string(is_parm.d_data_registrazione) + "~rnel registro " + &
											  ls_descr_registro + ".~rVisualizzare la registrazione?", Information!, YesNo!, 2)
											  
				IF li_RetVal = 1 THEN
					f_visualizza_reg_pd(ll_id_reg_pd)
				END IF
				
			CASE -1
				MessageBox("Errore sul DataBase","w_reg_pd_mn_pn_lt / ue_contabilizza / 1")
		END CHOOSE



	END IF
NEXT
THIS.Retrieve()
end event

event dw_list::ue_init;call super::ue_init;is_resp_window = ""
end event

event dw_list::rowfocuschanged;

IF NOT KeyDown(KeyControl!) AND NOT KeyDown(KeyShift!) THEN
	SelectRow(0,FALSE)
	SelectRow(currentrow, TRUE)
END IF

IF KeyDown(KeyShift!) THEN
	SelectRow(currentrow, NOT THIS.IsSelected(currentrow))
END IF

il_previous_currow = currentrow
end event

event dw_list::clicked;call super::clicked;long ll_RetVal

IF KeyDown(KeyControl!) THEN
	THIS.SelectRow(row, NOT THIS.IsSelected(row))
END IF

IF KeyDown(KeyShift!) THEN
	SelectRow(row, NOT THIS.IsSelected(row))
END IF

end event

event dw_list::ue_retrieve;call super::ue_retrieve;long ll_CurrRow

ll_CurrRow = THIS.GetRow()

IF ll_CurrRow > 0 THEN il_previous_currow = ll_CurrRow 
end event

event dw_list::ue_keystop;

end event

event dw_list::doubleclicked;

IF dw_list.GetRow () > 0 THEN
	dw_list.Drag (begin!)
	dw_list.DragIcon = 'Application!'
END IF

end event

event dw_list::dragenter;call super::dragenter;dw_list.DragIcon = 'Application!'
end event

event dw_list::dragleave;call super::dragleave;dw_list.DragIcon = 'None!'
end event

type cb_contabilizza from commandbutton within w_reg_pd_mn_pn_lt
int X=1258
int Y=961
int Width=380
int Height=89
int TabOrder=21
boolean BringToTop=true
string Text="&Contabilizza"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

Open(w_reg_pd_mn_pn_ff)
is_parm = Message.PowerObjectParm
IF is_parm.l_id_prof_registrazione > 0 AND & 
	is_parm.l_id_registro > 0 AND & 
	is_parm.d_data_registrazione > date("01/01/1900") AND &
	is_parm.d_data_competenza > date("01/01/1900") THEN
	dw_list.Event ue_contabilizza()
END IF
dw_list.SetFocus()
end event

event dragdrop;DragObject ldo_source
DataWindow ldw_source

ldo_source = DraggedObject()

CHOOSE CASE TypeOf(ldo_source)
	CASE DataWindow!
		ldw_source = ldo_source
		IF ldw_source.DataObject = "d_reg_pd_lt" THEN
			THIS.Trigger Event Clicked()
		END IF
END CHOOSE

end event

event dragenter;this.dragicon = 'Rectangle!'
end event

event dragleave;	this.dragicon = 'None!'
end event

