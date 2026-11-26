forward
global type w_conto_apertura_euro_ff from w_wiz_main
end type
type cb_ok from commandbutton within w_conto_apertura_euro_ff
end type
type cb_annulla from commandbutton within w_conto_apertura_euro_ff
end type
type dw_1 from u_dw_ext_main within w_conto_apertura_euro_ff
end type
end forward

global type w_conto_apertura_euro_ff from w_wiz_main
int Width=1495
int Height=748
WindowType WindowType=response!
boolean TitleBar=true
string Title="Estratto Conto"
long BackColor=78748035
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
cb_ok cb_ok
cb_annulla cb_annulla
dw_1 dw_1
end type
global w_conto_apertura_euro_ff w_conto_apertura_euro_ff

type variables
long ll_reg, ll_conto
end variables

on w_conto_apertura_euro_ff.create
int iCurrent
call super::create
this.cb_ok=create cb_ok
this.cb_annulla=create cb_annulla
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ok
this.Control[iCurrent+2]=this.cb_annulla
this.Control[iCurrent+3]=this.dw_1
end on

on w_conto_apertura_euro_ff.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.cb_annulla)
destroy(this.dw_1)
end on

event open;call super::open;ll_reg=message.doubleparm

dw_1.settransobject(sqlca)
dw_1.InsertRow(0)

ll_conto=0

end event

event closequery;if ll_conto=0 then return 1
end event

type cb_ok from commandbutton within w_conto_apertura_euro_ff
event clicked pbm_bnclicked
int X=46
int Y=36
int Width=270
int Height=84
int TabOrder=20
boolean BringToTop=true
string Text="OK"
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_test

ll_conto=dw_1.getitemnumber(1,'id_conto')
if isnull(ll_conto) then
	messagebox('Attenzione!','Non è stato selezionato nessun conto!')
	dw_1.reset()
   dw_1.insertrow(1)
	ll_conto=0
else	
	select count(*) into :ll_test from mov_contabile where id_conto=:ll_conto and id_reg_pd=:ll_reg;
	if ll_test>0 then	
		messagebox('Attenzione!',"Il conto selezionato è stato movimentato nell'esercizio precedente," +&
									 "non può essere utilizzato per pareggiare la scrittura!")
		dw_1.reset()
      dw_1.insertrow(1)
		ll_conto=0
	else	
		closewithreturn(parent,ll_conto)
	end if	
end if
									 

	
	
	
	
end event

type cb_annulla from commandbutton within w_conto_apertura_euro_ff
int X=338
int Y=36
int Width=256
int Height=84
int TabOrder=30
boolean BringToTop=true
string Text="Annulla"
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

Close(Parent)
end event

type dw_1 from u_dw_ext_main within w_conto_apertura_euro_ff
int X=55
int Y=152
int Width=1381
int Height=476
int TabOrder=10
boolean BringToTop=true
string DataObject="d_conto_apertura_euro"
end type

event itemchanged;integer li_ok
string ls_sql_cond, ls_cond
string ls_dbc[], ls_dwc[], ls_dbv[]

CHOOSE CASE dwo.name

	CASE "da_cod"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_conto" 
		
		ls_dwc[1] = "da_cod"
		ls_dwc[2] = "da_des"
		ls_dwc[3] = "id_conto"
		
		li_ok = uf_autofind_col(dwo.Name, "conto_pdc", "codice", "A", data, ls_sql_cond, 3, &
			ls_dbc, ls_dbv, ls_dwc)
	  
		IF (li_ok > 0) THEN
			RETURN 2
		END IF
		
		
	case "da_des"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_conto" 
		
		ls_dwc[1] = "da_cod"
		ls_dwc[2] = "da_des"
		ls_dwc[3] = "id_conto"
		
		li_ok = uf_autofind_col(dwo.Name, "conto_pdc", "descrizione", "A", data, ls_sql_cond, 3, &
			ls_dbc, ls_dbv, ls_dwc)	
			
		IF (li_ok > 0) THEN
			RETURN 2
		END IF
		
end choose

end event

event ue_set_search;string ls_cond

CHOOSE CASE as_nomecol
	
	CASE "da_cod", "da_des"
		is_search_window = "w_conti_pdc_sw"

		IF as_nomecol = "da_cod" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "conto_codice"
		ELSEIF as_nomecol = "da_des" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "conto_descrizione"
		END IF

END CHOOSE	
end event

event ue_use_search;string ls_null, ls_filtro

setnull(ls_null)

CHOOSE CASE as_nomecol

	CASE "da_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_conto", is_ricpar.s_id_seg_value[1])
		uf_set_colval("da_des", is_ricpar.s_ausil_value[1])

	CASE "da_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_conto", is_ricpar.s_id_seg_value[1])
		uf_set_colval("da_cod", is_ricpar.s_ausil_value[1])

END CHOOSE








end event

