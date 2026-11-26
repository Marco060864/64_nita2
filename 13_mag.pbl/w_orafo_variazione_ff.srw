forward
global type w_orafo_variazione_ff from w_variazione_ff
end type
type dw_3 from udw_base within w_orafo_variazione_ff
end type
type st_2 from statictext within w_orafo_variazione_ff
end type
end forward

global type w_orafo_variazione_ff from w_variazione_ff
integer width = 3493
integer height = 1828
string title = "Variazioni Orafo"
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = popup!
dw_3 dw_3
st_2 st_2
end type
global w_orafo_variazione_ff w_orafo_variazione_ff

type variables

end variables

forward prototypes
public subroutine wf_setfocus (datawindow dwo, long row, string column)
public subroutine wf_controlla_uc (long ll_riga_old)
end prototypes

public subroutine wf_setfocus (datawindow dwo, long row, string column);
long null_value

dw_prezzo_variaz_gd.Scrolltorow(row)
dw_prezzo_variaz_gd.SetColumn(column)

end subroutine

public subroutine wf_controlla_uc (long ll_riga_old);dwItemStatus l_status
long ll_riga, ll_art_cod, ll_id_pietra
string ls_prima_art, ls_dopo_art, ls_pericolo_art
long ll_prima_uc, ll_dopo_uc, ll_pericolo_uc

l_status=dw_prezzo_variaz_gd.getitemstatus(ll_riga_old,0,primary!)
if (l_status=newmodified!)  then
	ll_id_pietra= dw_prezzo_variaz_gd.getitemnumber(ll_riga_old,"id_pietra")
  	dw_prezzo_variaz_gd.setitem(ll_riga_old,"id_pietra",1)
	 
	dw_prezzo_variaz_gd.setsort("articolo_codice")
	dw_prezzo_variaz_gd.sort() 
	
	ll_riga=dw_prezzo_variaz_gd.find("id_pietra = 1",1,dw_prezzo_variaz_gd.rowcount())
	
	if ll_riga > 1 then 
		  
		  ll_prima_uc=dw_prezzo_variaz_gd.getitemnumber(ll_riga -1,"id_unita_confezione")
  	end if
  
  	if ll_riga < dw_prezzo_variaz_gd.rowcount() then 
	  
		  ll_dopo_uc=dw_prezzo_variaz_gd.getitemnumber(ll_riga +1,"id_unita_confezione")
 	end if
  
  
  	ll_pericolo_uc=dw_prezzo_variaz_gd.getitemnumber(ll_riga,"id_unita_confezione")
	 
	 
	if  (ll_pericolo_uc=ll_prima_uc) or (ll_pericolo_uc=ll_dopo_uc) then
		messagebox('Attenzione!',"L'articolo inserito è già esistente")
		dw_prezzo_variaz_gd.scrolltorow(ll_riga)
		
		messagebox('Attenzione!',"L'ultimo articolo inserito verrà cancellato")
		cb_cancella.TriggerEvent("clicked")
   end if
	
   dw_prezzo_variaz_gd.setitem(ll_riga,"id_pietra",ll_id_pietra)		
end if	  




end subroutine

on w_orafo_variazione_ff.create
int iCurrent
call super::create
this.dw_3=create dw_3
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_3
this.Control[iCurrent+2]=this.st_2
end on

on w_orafo_variazione_ff.destroy
call super::destroy
destroy(this.dw_3)
destroy(this.st_2)
end on

event resize;call super::resize;dw_3.settransobject(sqlca)
dw_3.insertrow(1)


dw_prezzo_variaz_gd.width=newwidth - 120
dw_prezzo_variaz_gd.height=newheight - 780
end event

type p_msg_log from w_variazione_ff`p_msg_log within w_orafo_variazione_ff
end type

type p_crescente from w_variazione_ff`p_crescente within w_orafo_variazione_ff
end type

type p_decrescente from w_variazione_ff`p_decrescente within w_orafo_variazione_ff
end type

type cb_ok from w_variazione_ff`cb_ok within w_orafo_variazione_ff
end type

type cb_annulla from w_variazione_ff`cb_annulla within w_orafo_variazione_ff
end type

type cb_nuovo from w_variazione_ff`cb_nuovo within w_orafo_variazione_ff
end type

type cb_inserisci from w_variazione_ff`cb_inserisci within w_orafo_variazione_ff
integer x = 1778
end type

type cb_cancella from w_variazione_ff`cb_cancella within w_orafo_variazione_ff
integer x = 2080
end type

type cb_salva from w_variazione_ff`cb_salva within w_orafo_variazione_ff
integer x = 2382
end type

event cb_salva::clicked;dwItemStatus l_status
long ll_riga, ll_art_cod, ll_ret
string ls_prima_art, ls_dopo_art, ls_pericolo_art
long ll_prima_uc, ll_dopo_uc, ll_pericolo_uc
ll_riga=dw_prezzo_variaz_gd.getrow()
l_status=dw_prezzo_variaz_gd.getitemstatus(ll_riga,0,primary!)


if (l_status=newmodified!)  then

	  dw_prezzo_variaz_gd.setitem(ll_riga,"id_pietra",1)
	  dw_prezzo_variaz_gd.setsort("articolo_codice")
	  dw_prezzo_variaz_gd.sort() 
	  ll_riga=dw_prezzo_variaz_gd.find("id_pietra = 1",1,dw_prezzo_variaz_gd.rowcount())
	  dw_prezzo_variaz_gd.setitem(ll_riga,"id_pietra",0)
	  if ll_riga > 1 then 
		        ls_prima_art=dw_prezzo_variaz_gd.getitemstring(ll_riga -1,"articolo_codice")
	           ll_prima_uc=dw_prezzo_variaz_gd.getitemnumber(ll_riga -1,"id_unita_confezione")
     end if

	  if ll_riga < dw_prezzo_variaz_gd.rowcount() then 
		        ls_dopo_art=dw_prezzo_variaz_gd.getitemstring(ll_riga +1,"articolo_codice")
	           ll_dopo_uc=dw_prezzo_variaz_gd.getitemnumber(ll_riga +1,"id_unita_confezione")
	  end if
	  ls_pericolo_art=dw_prezzo_variaz_gd.getitemstring(ll_riga,"articolo_codice")
	  ll_pericolo_uc=dw_prezzo_variaz_gd.getitemnumber(ll_riga,"id_unita_confezione")
	 
	 
	 if ((ls_pericolo_art=ls_prima_art) and (ll_pericolo_uc=ll_prima_uc)) or ((ls_pericolo_art=ls_dopo_art) and (ll_pericolo_uc=ll_dopo_uc)) then
		messagebox('Attenzione!',"L'articolo inserito è già esistente")
		dw_prezzo_variaz_gd.scrolltorow(ll_riga)
		
		
	   messagebox('Attenzione!',"L'ultimo articolo inserito verrà cancellato")
		cb_cancella.TriggerEvent("clicked")
    end if
	
    		
end if	  

Super::EVENT Clicked()
end event

type tab_1 from w_variazione_ff`tab_1 within w_orafo_variazione_ff
end type

type tabpage_1 from w_variazione_ff`tabpage_1 within tab_1
end type

type cb_ricerca from w_variazione_ff`cb_ricerca within w_orafo_variazione_ff
end type

type dw_variazione_ff from w_variazione_ff`dw_variazione_ff within w_orafo_variazione_ff
integer x = 69
integer width = 3008
end type

type dw_prezzo_variaz_gd from w_variazione_ff`dw_prezzo_variaz_gd within w_orafo_variazione_ff
integer x = 41
integer y = 736
integer width = 3333
string dataobject = "d_orafo_prezzo_variaz_gd"
boolean ib_is_shared = true
end type

event dw_prezzo_variaz_gd::itemchanged;call super::itemchanged;
CHOOSE CASE STRING(dwo.name)		
  CASE "prezzo_coef_calo"
	 DECIMAL{2} ll_coef_max, ll_coef_min, ll_coef_calo
	 long ll_id_titolo, ll_riga
	 
	 ll_id_titolo=this.getitemnumber(row,"articolo_id_titolo")
	 
	 
	 SELECT orafo_titolo.coef_calo_massimo, orafo_titolo.coef_calo_minimo
		 INTO :ll_coef_max, :ll_coef_min
		 FROM orafo_titolo
		 WHERE orafo_titolo.id_titolo = :ll_id_titolo;
		 IF SQLCA.SQLCODE=0 THEN
			 
			 ll_coef_calo=DEC(data)
			 IF not((ll_coef_calo>=ll_coef_min)and(ll_coef_calo<=ll_coef_max)) THEN
				 messagebox("Coefficiente di calo non valido","Il coefficiente deve esser compreso tra "+&
				 +string(ll_coef_min)+" e "+string(ll_coef_max))
				 post wf_setfocus(this,row,string(dwo.name))
			 END IF
		 END IF
	  
END CHOOSE




















end event

event dw_prezzo_variaz_gd::ue_set_search;call super::ue_set_search;long ll_row, ll_id_articolo

CHOOSE CASE as_nomecol
	
	CASE "articolo_codice"
		is_search_window = "w_articolo_coddes_documento_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "articolo_codice"
			
	CASE "articolo_descrizione"
		is_search_window = "w_articolo_coddes_documento_sw"
		
		is_ricpar.s_filter_value = as_valcol
		
		
		is_ricpar.s_filter_name = "articolo_descrizione"
		
	CASE "c_unita_confezione_cod"
		ll_row = GetRow()
		IF ll_row > 0 THEN
			ll_id_articolo = GetItemNumber(ll_row, "id_articolo")
		ELSE
			SetNull(ll_id_articolo)
		END IF
		is_ricpar.s_sql_cond = "unita_confezione.id_articolo = " + string(ll_id_articolo)
		is_search_window = "w_unita_confezione_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "unita_confezione_codice"

	CASE "c_unita_confezione_des"
		ll_row = GetRow()
		IF ll_row > 0 THEN
			ll_id_articolo = GetItemNumber(ll_row, "id_articolo")
		ELSE
			SetNull(ll_id_articolo)
		END IF
		is_ricpar.s_sql_cond = "unita_confezione.id_articolo = " + string(ll_id_articolo)
		is_search_window = "w_unita_confezione_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "unita_confezione_descrizione"

END CHOOSE



end event

event dw_prezzo_variaz_gd::ue_use_search;call super::ue_use_search;

end event

event dw_prezzo_variaz_gd::rowfocuschanging;post wf_controlla_uc(currentrow)




end event

event dw_prezzo_variaz_gd::rowfocuschanged;call super::rowfocuschanged;
end event

event dw_prezzo_variaz_gd::updatestart;
end event

event dw_prezzo_variaz_gd::ue_key;DataWindowChild	ldw_dropdown
DataWindowChild	ldw_drop
string				ls_column, ls_style, ls_tipof, ls_filter, ls_colval
integer				li_cdw, li_size, li_i, li_ret
w_search_main		lw_sm
w_data_main			lw_win
w_mod_single_data lw_mw
w_p_data				lw_pwin
u_dw_main			lu_dw

long					ll_retv


ll_retv = 0


choose case key
	
	case KeyF1!
		if (keyflags = 0 Or keyflags = 1 Or keyflags = 2) then
			
			u_freddie.iw_current.Event ue_help(Topic!, long(this.object.DataWindow.Help.TypeID.Retrieve.Argument), "")
		end if
		
	case KeyF5!
		if keyflags = 0 then
			ls_column = getColumnName()
			uf_reply_retrieve_dddw(ls_column)
			
		end if	
	
		
	case KeyF4!
		ll_retv = 1
		ib_during_f4 = true
		is_ricpar = is_e_ricpar
		ls_column = getColumnName()
		ls_style = this.describe(ls_column+".edit.style")
		is_ricpar.b_imm_retrieve = false
		is_ricpar.s_caller_column = ls_column
		is_ricpar.s_sql_cond = ""
		is_search_window = ""
		ls_colval = ""
		trigger event ue_set_search (ls_column,ls_colval)
		if (is_search_window) <> "" then
			choose case keyflags
				case 0	
					
					ls_colval = gettext()
					
					
					is_ricpar.b_imm_insert = false
					is_ricpar.s_caller_column = ls_column
					is_ricpar.b_imm_retrieve = false
					is_ricpar.s_sql_cond = ""
					trigger event ue_set_search (ls_column,ls_colval)
					if lower (ls_style) <> "dddw" then
						
						OpenWithParm (lw_sm,is_ricpar,is_search_window)
						
						
						
						is_ricpar = Message.PowerObjectParm
						IF UpperBound(is_ricpar.s_id_seg_value) > 0 THEN
							trigger event ue_use_search (ls_column)
						end if
					end if
					
				case 1	

					
					ls_colval = gettext()
					
					
					is_ricpar.b_imm_insert = true
					is_ricpar.s_caller_column = ls_column
					is_ricpar.b_imm_retrieve = false
					is_ricpar.s_sql_cond = ""
					trigger event ue_set_search (ls_column, ls_colval)
					if lower (ls_style) = "dddw" then
						
						OpenWithParm (lw_mw,is_ricpar,is_search_window)
						this.GetChild (ls_column, ldw_dropdown)
						ldw_dropdown.SetTransObject(SQLCA)
						ldw_dropdown.Retrieve ()
						li_size = upperbound(is_ricpar.s_ausil_value)
						for li_i = 1 to li_size
							if is_ricpar.s_ausil_value[li_i] > " " then
								this.GetChild (is_ricpar.s_ausil_value[li_i], ldw_dropdown)
								ldw_dropdown.SetTransObject(SQLCA)
								ldw_dropdown.Retrieve ()
							end if
						next
					else
						
						
						OpenWithParm (lw_sm,is_ricpar,is_search_window)
						is_ricpar = Message.PowerObjectParm
						IF UpperBound(is_ricpar.s_id_seg_value) > 0 THEN
							trigger event ue_use_search (ls_column)
						end if
					end if
				case 2	
				case 3	
					ls_colval = gettext()
					is_ricpar.b_imm_maint = true
					is_ricpar.s_caller_column = ls_column
					is_ricpar.b_imm_retrieve = false
					is_ricpar.s_sql_cond = ""
					trigger event ue_set_search (ls_column,ls_colval)
					if lower (ls_style) = "dddw" then
						
					else
						
						
						OpenWithParm (lw_sm,is_ricpar,is_search_window)
						if not IsNull(Message.PowerObjectParm) then
							is_ricpar = Message.PowerObjectParm
							trigger event ue_use_search (ls_column)
						end if
					end if
					is_ricpar.b_imm_maint = false
			end choose
		end if
		ib_during_f4 = false


	case Keyadd!
		
		
		if (keyFlags=2) then
			ll_retv = 1
			lw_win = u_freddie.iw_current
			ls_tipof = lw_win.is_wintype
			lu_dw = lw_win.idw_master
			choose case ls_tipof
				case "W_P_DATA"
					if this = lu_dw then
						if is_list.s_modo = modo_inserisci then 			
							if (event ue_update (0,0) = 0) then
								triggerevent("ue_insert")
							end if
							lu_dw.setFocus()
						end if
					else
						triggerevent("ue_insert")
					end if
				case else
					triggerevent("ue_insert")
			end choose
		end if
	case KeySubtract!
		if (keyFlags=2) then
			ll_retv = 1
			lw_win = u_freddie.iw_current
			ls_tipof = lw_win.is_wintype
			lu_dw = lw_win.idw_master
			choose case ls_tipof
				case "W_P_DATA"
					if this <> lu_dw then
						triggerevent("ue_delete")
					else
						
						
						
						lw_win.triggerevent("ue_master_delete")
					end if
				case else
					triggerevent("ue_delete")
			end choose
		end if

	case KeyS!
		if (keyFlags=2) then
			ll_retv = 1
			lw_win = u_freddie.iw_current
			lu_dw = lw_win.idw_master
			
			if IsNull(lu_dw) then lu_dw = this
			cb_salva.triggerevent("clicked")
		end if
	case KeyF12!
		if (keyFlags=0) then
			ll_retv = 1
			lw_win = u_freddie.iw_current
			lu_dw = lw_win.idw_master
			
			if IsNull(lu_dw) then lu_dw = this
			lu_dw.triggerevent("ue_update")
		end if
		
		
		if (keyflags=3) then
			lw_win = u_freddie.iw_current
			lw_win.trigger event key (keyF12!,3)
		end if
	case KeyN!
		if (keyFlags=2) then
			ll_retv = 1
				lw_win = u_freddie.iw_current
				ls_tipof = lw_win.is_wintype
				lu_dw = lw_win.idw_master
				if ls_tipof = "W_P_DATA" then
					if (lu_dw.is_list.s_modo = modo_inserisci) or (lw_win.ib_nonmodale = true) then 	
						if (lu_dw.event ue_update (0,0) = 0) then
							lu_dw.triggerevent("ue_insert")
						end if
						lu_dw.setFocus()
					end if
				end if
      end if

	case KeyF6!
		lw_win = u_freddie.iw_current
		ls_tipof = lw_win.is_wintype
		if ls_tipof = "W_P_DATA" then
			lw_win.ib_F6_in_dw = true
			if (keyflags=0) then		
				ll_retv = 0
				li_ret = -1
				do while li_ret<0
					li_cdw = lw_win.ii_dwcurr
					li_cdw++
					if li_cdw > lw_win.ii_dwcount then li_cdw = 1
					lw_win.ii_dwcurr = li_cdw
					lw_pwin = lw_win
					li_ret = lw_pwin.uf_dwsetfocus(lw_pwin.idw_tree[li_cdw])
				loop
			end if
			if (keyFlags=1) then		
				ll_retv = 0
				li_ret = -1
				do while li_ret<0
					li_cdw = lw_win.ii_dwcurr
					li_cdw --
					if li_cdw < 1 then li_cdw = lw_win.ii_dwcount
					lw_win.ii_dwcurr = li_cdw
					lw_pwin = lw_win
					li_ret = lw_pwin.uf_dwsetfocus(lw_pwin.idw_tree[li_cdw])
				loop
			end if
		end if
	case keydelete!		
		ls_column = getColumnName()
		ls_style = this.describe(ls_column+".edit.style")
		if ls_style = "ddlb" then
			uf_set_colval(ls_column,u_freddie.gs_null)
			ll_retv = 1
		end if
end choose


return ll_retv


end event

type dw_prezzo_variaz_gd_t from w_variazione_ff`dw_prezzo_variaz_gd_t within w_orafo_variazione_ff
boolean visible = false
integer x = 238
integer y = 1548
integer width = 2665
end type

type dw_3 from udw_base within w_orafo_variazione_ff
integer x = 553
integer y = 576
integer width = 558
integer height = 120
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_lista_gruppo_ext"
boolean vscrollbar = false
boolean livescroll = false
end type

event itemchanged;call super::itemchanged;STRING LS_FILTRO
if data>" " then
	LS_FILTRO="id_gruppo_articoli="+data
	dw_prezzo_variaz_gd.setfilter(LS_FILTRO)
	dw_prezzo_variaz_gd.filter()
else
	dw_prezzo_variaz_gd.setfilter("")
	dw_prezzo_variaz_gd.filter()
end if
end event

type st_2 from statictext within w_orafo_variazione_ff
integer x = 87
integer y = 584
integer width = 466
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Vedi solo Gruppo"
boolean focusrectangle = false
end type

