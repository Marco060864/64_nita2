forward
global type w_ins_cod_barre_gd from w_np_single_data
end type
type cb_1 from commandbutton within w_ins_cod_barre_gd
end type
type cb_2 from commandbutton within w_ins_cod_barre_gd
end type
type cb_3 from commandbutton within w_ins_cod_barre_gd
end type
type dw_1 from u_dw_main within w_ins_cod_barre_gd
end type
end forward

global type w_ins_cod_barre_gd from w_np_single_data
int Width=3401
int Height=1752
boolean TitleBar=true
string Title="Inserimento dei codici a barre"
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
dw_1 dw_1
end type
global w_ins_cod_barre_gd w_ins_cod_barre_gd

type variables
string is_dacod,is_acod
string is_inser
end variables

forward prototypes
public subroutine wf_unita_base (long ll_row)
end prototypes

public subroutine wf_unita_base (long ll_row);Long ll_id_unita_confezione, ll_id_articolo
String ls_codice
			
ll_id_articolo = dw_single.GetItemNumber(ll_row, "unita_confezione_id_articolo")
			
SELECT id_unita_confezione, codice
INTO 	 :ll_id_unita_confezione, :ls_codice
FROM	 unita_confezione
WHERE	 id_articolo = :ll_id_articolo
AND	 unita_base = 'S'
;
			
CHOOSE CASE SQLCA.SQLCODE 
	CASE -1
		messagebox("", SQLCA.SQLERRTEXT)
	CASE 0
		dw_single.SetItem(ll_row, "id_unita_confezione", ll_id_unita_confezione)
		dw_single.SetItem(ll_row, "c_unita_confezione_cod", ls_codice)					
END CHOOSE 			
end subroutine

on w_ins_cod_barre_gd.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.cb_3
this.Control[iCurrent+4]=this.dw_1
end on

on w_ins_cod_barre_gd.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.dw_1)
end on

event open;call super::open;if is_inser='I' then
	dw_1.settransobject(sqlca)
	dw_1.retrieve()
	dw_single.visible=false
	dw_1.visible=true
end if	
	
end event

event closequery;
end event

type p_crescente from w_np_single_data`p_crescente within w_ins_cod_barre_gd
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_ins_cod_barre_gd
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_ins_cod_barre_gd
int X=32
int Y=196
int Width=3287
int Height=1396
int TabOrder=10
string DataObject="d_ins_cod_barre_gd"
boolean HScrollBar=false
end type

event dw_single::itemchanged;
integer li_ok
long ll_id_articolo, ll_row
string ls_sql_cond
string ls_dbc[], ls_dwc[], ls_dbv[]

CHOOSE CASE dwo.name
	
	
	CASE 'id_tipo_cod_barre'
		dw_single.setitem(row,'id_unita_confezione',dw_single.getitemnumber(row,'id_uc'))
		dw_single.setitem(row,'id_azienda',1)
	
		
	CASE 'articolo_codice'
		ls_sql_cond = ""
		ls_dbc[1] = "id_articolo"
		ls_dbc[2] = "codice"
		ls_dbc[3] = "descrizione"
		ls_dwc[1] = "unita_confezione_id_articolo"
		ls_dwc[2] = "articolo_codice"
		ls_dwc[3] = "articolo_descrizione"
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "codice", "A", data, ls_sql_cond, 3, &
			ls_dbc, ls_dbv, ls_dwc)
			
		wf_unita_base(row)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
	CASE 'articolo_descrizione'
		ls_sql_cond = ""
		ls_dbc[1] = "id_articolo"
		ls_dbc[2] = "codice"
		ls_dbc[3] = "descrizione"
		ls_dwc[1] = "unita_confezione_id_articolo"
		ls_dwc[2] = "articolo_codice"
		ls_dwc[3] = "articolo_descrizione"

		li_ok = uf_autofind_col(dwo.Name, "articolo", "descrizione", "A", data, ls_sql_cond, &
			3, ls_dbc, ls_dbv, ls_dwc)
			
		wf_unita_base(row)			

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
	CASE 'c_unita_confezione_cod'
		ll_row = GetRow()
		IF ll_row > 0 THEN
			ll_id_articolo = GetItemNumber(ll_row, "id_articolo")
		ELSE
			SetNull(ll_id_articolo)
		END IF
		ls_sql_cond = "unita_confezione.id_articolo = " + string(ll_id_articolo)
		ls_dbc[1] = "id_unita_confezione"
		ls_dbc[2] = "codice"
		ls_dwc[1] = "id_unita_confezione"
		ls_dwc[2] = "c_unita_confezione_cod"

		li_ok = uf_autofind_col(dwo.Name, "unita_confezione", "codice", "A", data, &
			ls_sql_cond, 3, ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF

	CASE "codice"
		
		String	ls_cod_barre, ls_check_digit, ls_tipo, ls_alfanumerico, ls_codice
		Long	  	ll_id_tipo_cod_barre
		Integer	li_ret, li_lunghezza, li_check_digit
		
		u_cod_barre l_u_cod_barre
		
		
	
		l_u_cod_barre = create u_cod_barre
		
		ll_id_tipo_cod_barre = this.Object.id_tipo_cod_barre[row]
		ls_cod_barre = data
		
		SELECT codice, tipo, check_digit, lunghezza, alfanumerico
		INTO	 :ls_codice, :ls_tipo, :ls_check_digit, :li_lunghezza, :ls_alfanumerico
		FROM	 tipo_cod_barre
		WHERE	 id_tipo_cod_barre = :ll_id_tipo_cod_barre
		;
		if SQLCA.SQLCODE = -1 then
			messagebox("Verifica del codice a barre", SQLCA.SQLERRTEXT)
		end if
		
		li_ret = l_u_cod_barre.uf_ver_cod_barre(ls_codice, li_lunghezza, ls_alfanumerico, ls_cod_barre, ls_tipo)
				
		if li_ret = -1 then 
			destroy l_u_cod_barre		
			return 2
		else
			if ls_check_digit = 'S' then
				li_check_digit = l_u_cod_barre.uf_Check_Digit(ls_tipo, li_lunghezza, ls_cod_barre)

				if not isnull(li_check_digit) then
					ls_cod_barre = mid (ls_cod_barre, 1, li_lunghezza - 1) + string(li_check_digit)
					this.Post SetItem(Row, "codice", ls_cod_barre)
				end if
			end if
		end if
END CHOOSE
end event

event dw_single::ue_set_search;

long ll_row, ll_id_articolo

CHOOSE CASE as_nomecol
	CASE "articolo_codice"
		is_search_window = "w_articolo_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "articolo_codice"
			
	CASE "articolo_descrizione"
		is_search_window = "w_articolo_coddes_sw"
		is_ricpar.s_filter_value = uf_get_colval("articolo_descrizione")
		is_ricpar.s_filter_name = "articolo_descrizione"
		
	CASE "c_unita_confezione_cod"
		ll_row = GetRow()
		IF ll_row > 0 THEN
			ll_id_articolo = GetItemNumber(ll_row, "unita_confezione_id_articolo")
		ELSE
			SetNull(ll_id_articolo)
		END IF
		is_ricpar.s_sql_cond = "unita_confezione.id_articolo = " + string(ll_id_articolo)
		is_search_window = "w_unita_confezione_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "unita_confezione_codice"
END CHOOSE
end event

event dw_single::ue_use_search;
Integer li_row

CHOOSE CASE as_nomecol
	CASE "articolo_codice"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("unita_confezione_id_articolo", is_ricpar.s_id_seg_value[1])
		uf_set_colval("articolo_descrizione", is_ricpar.s_ausil_value[1])
		
		uf_set_colval("id_unita_confezione", is_ricpar.s_id_seg_value[2])
		uf_set_colval("c_unita_confezione_cod", is_ricpar.s_ausil_value[2])
		uf_set_colval("c_unita_confezione_des", is_ricpar.s_ausil_value[3])
		
		li_row = This.GetRow()
		wf_unita_base(li_row)
		
	CASE "articolo_descrizione"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("unita_confezione_id_articolo", is_ricpar.s_id_seg_value[1])
		uf_set_colval("articolo_codice", is_ricpar.s_ausil_value[1])
		
		uf_set_colval("id_unita_confezione", is_ricpar.s_id_seg_value[2])
		uf_set_colval("c_unita_confezione_cod", is_ricpar.s_ausil_value[2])
		uf_set_colval("c_unita_confezione_des", is_ricpar.s_ausil_value[3])
		
		li_row = This.GetRow()
		wf_unita_base(li_row)
		
	CASE "c_unita_confezione_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_unita_confezione", is_ricpar.s_id_seg_value[1])		
		uf_set_colval("c_unita_confezione_des", is_ricpar.s_ausil_value[1])
END CHOOSE
end event

event dw_single::sqlpreview;

String ls_SQLSyntax


if request=PreviewFunctionRetrieve!  then

	s_passa_date str_parametri
	str_parametri=message.powerobjectparm

	is_inser=str_parametri.vis_reg
	is_dacod=str_parametri.da_conto
	is_acod=str_parametri.a_conto

	Ls_SQLSyntax = SQLSyntax + " AND cod_barre.id_cod_barre is not null AND articolo.codice >='" +is_dacod + "' AND articolo.codice <='" + is_acod +"'"

	if This.SetSQLPreview(ls_SQLSyntax)<>1 then
		messagebox("Errore!", "sqlpreview, dw_ins_cod_barre_gd, 14")
	end if

end if

end event

type cb_1 from commandbutton within w_ins_cod_barre_gd
int X=3086
int Y=28
int Width=247
int Height=108
int TabOrder=20
boolean BringToTop=true
string Text="Salva"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
if is_inser='I' then
	string ls_filter
	ls_filter="not ( isNull ( id_tipo_cod_barre ) or  isNull ( codice ) )"
	dw_1.setfilter(ls_filter)
	dw_1.filter()
	dw_single.reset()
	dw_1.RowsCopy(1, dw_1.rowcount(), Primary!, dw_single, 1, Primary!)	
end if	

dw_single.update()


dw_1.retrieve()
ls_filter=""
dw_1.setfilter(ls_filter)
dw_1.filter()
end event

type cb_2 from commandbutton within w_ins_cod_barre_gd
int X=32
int Y=28
int Width=247
int Height=108
int TabOrder=30
boolean BringToTop=true
string Text="Annulla"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
close(parent)
end event

type cb_3 from commandbutton within w_ins_cod_barre_gd
int X=402
int Y=28
int Width=247
int Height=108
int TabOrder=40
boolean BringToTop=true
string Text="Ok"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
If messagebox('Attenzione','Vuoi effettuare il salvataggio dei codici inseriti?',Information!,Yesno!)=1 then
	cb_1.triggerevent(clicked!)
end if	

close(parent)
end event

type dw_1 from u_dw_main within w_ins_cod_barre_gd
int X=32
int Y=192
int Width=3287
int Height=1396
int TabOrder=12
boolean Visible=false
string DataObject="ds_upd_cod_barre_gd"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event sqlpreview;

String ls_SQLSyntax


if request=PreviewFunctionRetrieve!  then
	s_passa_date str_parametri
	str_parametri=message.powerobjectparm

	is_inser=str_parametri.vis_reg
	is_dacod=str_parametri.da_conto
	is_acod=str_parametri.a_conto
	
	Ls_SQLSyntax = SQLSyntax + " AND cod_barre.id_cod_barre is null AND articolo.codice >='" +is_dacod + "' AND articolo.codice <='" + is_acod +"'"


	if This.SetSQLPreview(ls_SQLSyntax)<>1 then
		messagebox("Errore!", "sqlpreview, dw_ins_cod_barre_gd, 14")
	end if

end if

end event

event itemchanged;
integer li_ok
long ll_id_articolo, ll_row
string ls_sql_cond
string ls_dbc[], ls_dwc[], ls_dbv[]

CHOOSE CASE dwo.name
	
	
	CASE 'id_tipo_cod_barre'
		dw_1.setitem(row,'id_unita_confezione',dw_1.getitemnumber(row,'id_uc'))
		dw_1.setitem(row,'id_azienda',1)
	
		
	CASE 'articolo_codice'
		ls_sql_cond = ""
		ls_dbc[1] = "id_articolo"
		ls_dbc[2] = "codice"
		ls_dbc[3] = "descrizione"
		ls_dwc[1] = "unita_confezione_id_articolo"
		ls_dwc[2] = "articolo_codice"
		ls_dwc[3] = "articolo_descrizione"
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "codice", "A", data, ls_sql_cond, 3, &
			ls_dbc, ls_dbv, ls_dwc)
			
		wf_unita_base(row)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
	CASE 'articolo_descrizione'
		ls_sql_cond = ""
		ls_dbc[1] = "id_articolo"
		ls_dbc[2] = "codice"
		ls_dbc[3] = "descrizione"
		ls_dwc[1] = "unita_confezione_id_articolo"
		ls_dwc[2] = "articolo_codice"
		ls_dwc[3] = "articolo_descrizione"

		li_ok = uf_autofind_col(dwo.Name, "articolo", "descrizione", "A", data, ls_sql_cond, &
			3, ls_dbc, ls_dbv, ls_dwc)
			
		wf_unita_base(row)			

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
	CASE 'c_unita_confezione_cod'
		ll_row = GetRow()
		IF ll_row > 0 THEN
			ll_id_articolo = GetItemNumber(ll_row, "id_articolo")
		ELSE
			SetNull(ll_id_articolo)
		END IF
		ls_sql_cond = "unita_confezione.id_articolo = " + string(ll_id_articolo)
		ls_dbc[1] = "id_unita_confezione"
		ls_dbc[2] = "codice"
		ls_dwc[1] = "id_unita_confezione"
		ls_dwc[2] = "c_unita_confezione_cod"

		li_ok = uf_autofind_col(dwo.Name, "unita_confezione", "codice", "A", data, &
			ls_sql_cond, 3, ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF

	CASE "codice"
		
		String	ls_cod_barre, ls_check_digit, ls_tipo, ls_alfanumerico, ls_codice
		Long	  	ll_id_tipo_cod_barre
		Integer	li_ret, li_lunghezza, li_check_digit
		
		u_cod_barre l_u_cod_barre
		
		
	
		l_u_cod_barre = create u_cod_barre
		
		ll_id_tipo_cod_barre = this.Object.id_tipo_cod_barre[row]
		ls_cod_barre = data
		
		SELECT codice, tipo, check_digit, lunghezza, alfanumerico
		INTO	 :ls_codice, :ls_tipo, :ls_check_digit, :li_lunghezza, :ls_alfanumerico
		FROM	 tipo_cod_barre
		WHERE	 id_tipo_cod_barre = :ll_id_tipo_cod_barre
		;
		if SQLCA.SQLCODE = -1 then
			messagebox("Verifica del codice a barre", SQLCA.SQLERRTEXT)
		end if
		
		li_ret = l_u_cod_barre.uf_ver_cod_barre(ls_codice, li_lunghezza, ls_alfanumerico, ls_cod_barre, ls_tipo)
				
		if li_ret = -1 then 
			destroy l_u_cod_barre		
			return 2
		else
			if ls_check_digit = 'S' then
				li_check_digit = l_u_cod_barre.uf_Check_Digit(ls_tipo, li_lunghezza, ls_cod_barre)

				if not isnull(li_check_digit) then
					ls_cod_barre = mid (ls_cod_barre, 1, li_lunghezza - 1) + string(li_check_digit)
					this.Post SetItem(Row, "codice", ls_cod_barre)
				end if
			end if
		end if
END CHOOSE
end event

event ue_set_search;call super::ue_set_search;

long ll_row, ll_id_articolo

CHOOSE CASE as_nomecol
	CASE "articolo_codice"
		is_search_window = "w_articolo_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "articolo_codice"
			
	CASE "articolo_descrizione"
		is_search_window = "w_articolo_coddes_sw"
		is_ricpar.s_filter_value = uf_get_colval("articolo_descrizione")
		is_ricpar.s_filter_name = "articolo_descrizione"
		
	CASE "c_unita_confezione_cod"
		ll_row = GetRow()
		IF ll_row > 0 THEN
			ll_id_articolo = GetItemNumber(ll_row, "unita_confezione_id_articolo")
		ELSE
			SetNull(ll_id_articolo)
		END IF
		is_ricpar.s_sql_cond = "unita_confezione.id_articolo = " + string(ll_id_articolo)
		is_search_window = "w_unita_confezione_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "unita_confezione_codice"
END CHOOSE
end event

event ue_use_search;
Integer li_row

CHOOSE CASE as_nomecol
	CASE "articolo_codice"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("unita_confezione_id_articolo", is_ricpar.s_id_seg_value[1])
		uf_set_colval("articolo_descrizione", is_ricpar.s_ausil_value[1])
		
		uf_set_colval("id_unita_confezione", is_ricpar.s_id_seg_value[2])
		uf_set_colval("c_unita_confezione_cod", is_ricpar.s_ausil_value[2])
		uf_set_colval("c_unita_confezione_des", is_ricpar.s_ausil_value[3])
		
		li_row = This.GetRow()
		wf_unita_base(li_row)
		
	CASE "articolo_descrizione"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("unita_confezione_id_articolo", is_ricpar.s_id_seg_value[1])
		uf_set_colval("articolo_codice", is_ricpar.s_ausil_value[1])
		
		uf_set_colval("id_unita_confezione", is_ricpar.s_id_seg_value[2])
		uf_set_colval("c_unita_confezione_cod", is_ricpar.s_ausil_value[2])
		uf_set_colval("c_unita_confezione_des", is_ricpar.s_ausil_value[3])
		
		li_row = This.GetRow()
		wf_unita_base(li_row)
		
	CASE "c_unita_confezione_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_unita_confezione", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_unita_confezione_des", is_ricpar.s_ausil_value[1])
END CHOOSE
end event

event ue_key;choose case key

case Keyadd!

		if (keyFlags=2) then
			triggerevent("ue_insert")
		end if
		
case KeySubtract!
		if (keyFlags=2) then
			triggerevent("ue_delete")
		end if
		
end choose		
end event

event ue_insert;call super::ue_insert;long ll_currow
integer li_colNumber

ll_currow = THIS.GetRow()
if ll_currow<=0 then ll_currow=1
THIS.InsertRow(ll_currow)

end event

