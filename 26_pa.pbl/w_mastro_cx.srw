forward
global type w_mastro_cx from w_p_data
end type
type dw_mastro_ff from u_dw_master_main within w_mastro_cx
end type
type dw_sottomastro_gd from u_dw_master_main within w_mastro_cx
end type
type dw_sottomastro_gd_t from statictext within w_mastro_cx
end type
type cb_1 from commandbutton within w_mastro_cx
end type
type cb_2 from commandbutton within w_mastro_cx
end type
end forward

global type w_mastro_cx from w_p_data
int X=298
int Y=573
int Width=2611
int Height=1369
boolean TitleBar=true
string Title="Inserimento PDC - Sottomastri"
dw_mastro_ff dw_mastro_ff
dw_sottomastro_gd dw_sottomastro_gd
dw_sottomastro_gd_t dw_sottomastro_gd_t
cb_1 cb_1
cb_2 cb_2
end type
global w_mastro_cx w_mastro_cx

on w_mastro_cx.create
int iCurrent
call w_p_data::create
this.dw_mastro_ff=create dw_mastro_ff
this.dw_sottomastro_gd=create dw_sottomastro_gd
this.dw_sottomastro_gd_t=create dw_sottomastro_gd_t
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=dw_mastro_ff
this.Control[iCurrent+2]=dw_sottomastro_gd
this.Control[iCurrent+3]=dw_sottomastro_gd_t
this.Control[iCurrent+4]=cb_1
this.Control[iCurrent+5]=cb_2
end on

on w_mastro_cx.destroy
call w_p_data::destroy
destroy(this.dw_mastro_ff)
destroy(this.dw_sottomastro_gd)
destroy(this.dw_sottomastro_gd_t)
destroy(this.cb_1)
destroy(this.cb_2)
end on

event open;call super::open;il_HelpTopic = 178
idw_master = This.dw_mastro_ff
idw_master.is_list = Message.PowerObjectParm

idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_sql_ident[1] = "mastro.id_mastro"
end event

type p_crescente from w_p_data`p_crescente within w_mastro_cx
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_mastro_cx
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_mastro_cx
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_mastro_cx
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_mastro_cx
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_mastro_cx
int X=1706
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_mastro_cx
int X=2003
boolean Enabled=false
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_mastro_cx
int X=2300
boolean BringToTop=true
end type

event cb_salva::clicked;call super::clicked;
end event

type tab_1 from w_p_data`tab_1 within w_mastro_cx
int Y=1541
int Height=81
int TabOrder=40
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
long BackColor=79741120
end type

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=19
int Y=105
int Width=2323
end type

type cb_ricerca from w_p_data`cb_ricerca within w_mastro_cx
int X=1701
int Y=37
boolean BringToTop=true
end type

type dw_mastro_ff from u_dw_master_main within w_mastro_cx
int X=46
int Y=165
int Width=2483
int Height=245
int TabOrder=30
string DataObject="d_mastro_ff"
end type

event ue_init;call super::ue_init;
is_list.s_identifica[1] = "id_mastro"
is_list.s_identifica[2] = "id_azienda"
iudw_children[1] = dw_sottomastro_gd
is_list.s_win_chiave[1] = "id_sottomastro"
is_list.s_win_chiave[2] = "id_azienda"
end event

type dw_sottomastro_gd from u_dw_master_main within w_mastro_cx
int X=46
int Y=545
int Width=2483
int Height=605
int TabOrder=10
string DataObject="d_sottomastro_gd"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event ue_init;call super::ue_init;is_title = "Inserimento PDC - Sottomastri"

is_list.s_identifica[1] = "id_mastro"
is_list.s_identifica[2] = "id_azienda"
is_list.s_win_chiave[1] = "id_sottomastro"
is_list.s_win_chiave[2] = "id_azienda"
is_list.s_win_zoom = "w_sottomastro_cx"
end event

event ue_initial;call super::ue_initial;long ll_total, ll_count, ll_codice, ll_max_codice = 0
string ls_codice

ll_total = RowCount()
for ll_count = 1 to ll_total
	ls_codice = GetItemString(ll_count, "codice")
	ll_codice = Long(ls_codice)
	if ll_codice > 0 then
		ll_max_codice = Max(ll_codice, ll_max_codice)
	end if
next 
ls_codice = String(ll_max_codice + 1)
SetItem(GetRow(), "codice", f_lpad(ls_codice, "0",2))
end event

event doubleclicked;

long ll_RetVal, ll_CurrRow
dwItemStatus l_status

ll_CurrRow = THIS.GetRow()

IF ll_CurrRow > 0 THEN
	l_status = THIS.GetItemStatus(ll_CurrRow, 0, Primary!)
	IF l_status <> New! AND l_status <> NewModified! THEN
		ll_RetVal = Super::Event DoubleClicked(xpos, ypos, row, dwo)
		RETURN ll_RetVal
	END IF
END IF
end event

event ue_set_search;call super::ue_set_search;CHOOSE CASE as_nomecol
		
	CASE "bilancio_cee_riferimento"
		is_search_window = "w_bilancio_cee_sw"
		is_ricpar.s_filter_value = as_valcol	
		is_ricpar.s_filter_name = "riferimento"
		is_ricpar.b_imm_retrieve = TRUE
END CHOOSE
end event

event ue_use_search;call super::ue_use_search;CHOOSE CASE as_nomecol
	CASE "bilancio_cee_riferimento"
		uf_set_colval("sottomastro_id_bilancio_cee", is_ricpar.s_id_seg_value[1])		
		uf_set_colval("bilancio_cee_descrizione", is_ricpar.s_ausil_value[1])	
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
END CHOOSE
end event

event updateend;call super::updateend;
end event

event itemchanged;call super::itemchanged;long ll_id_bilancio_cee, null_num, ll_riferimento,ll_riga

SetNull(null_num)

if string(dwo.name)="bilancio_cee_riferimento" then
	ll_riga=getrow()
   ll_riferimento=dec(data)
	
	if isnull(ll_riferimento) then
	  	
		dw_sottomastro_gd.SetItem(ll_riga, "sottomastro_id_bilancio_cee", null_num)
	end if
	
end if



end event

type dw_sottomastro_gd_t from statictext within w_mastro_cx
int X=46
int Y=465
int Width=1989
int Height=81
boolean Enabled=false
boolean BringToTop=true
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
string Text=" Sottomastro"
boolean FocusRectangle=false
long TextColor=16777215
long BackColor=276856960
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_1 from commandbutton within w_mastro_cx
int X=1797
int Y=1181
int Width=737
int Height=85
int TabOrder=20
boolean BringToTop=true
string Text="Usa per Riclassificare CEE"
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;integer bil_cee, sottomastro, conto_bil_cee, ll_id_mastro

 	DECLARE sottomastro_cur CURSOR FOR  
  	 SELECT id_bilancio_cee, id_sottomastro
      FROM sottomastro;
 
   OPEN sottomastro_cur;

   FETCH sottomastro_cur INTO :bil_cee, :sottomastro;

DO WHILE sqlca.sqlcode=0
 
  		UPDATE conto
			SET id_bilancio_cee = :bil_cee
			WHERE id_sottomastro = :sottomastro
      USING SQLCA;
	FETCH sottomastro_cur INTO :bil_cee, :sottomastro;

LOOP

CLOSE sottomastro_cur;

ll_id_mastro = dw_sottomastro_gd.GetItemNumber (1, "id_mastro")	
dw_sottomastro_gd.retrieve(ll_id_mastro)
messagebox("Message", "I Conti sono stati riclassificati!")
end event

type cb_2 from commandbutton within w_mastro_cx
int X=65
int Y=1181
int Width=595
int Height=85
int TabOrder=12
boolean BringToTop=true
string Text="Elimina Sottomastro/Conti"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

integer ll_crow, li_id_mm, ll_id_mastro, ll_id
INTEGER LS_RISP

LS_RISP = messagebox ('Informazione', 'Sei sicuro di voler eliminare ~r~n i Conti non movimentati?',Question!,YesNoCancel!,1 )

IF LS_RISP = 1 THEN
	ll_crow = dw_sottomastro_gd.getrow()
	li_id_mm = dw_sottomastro_gd.getitemnumber(ll_crow, 'id_sottomastro')
	
	delete from conto
		where conto.id_sottomastro = :li_id_mm
		and conto.id_conto not in (select s.id_conto from saldo_mensile  s
									where conto.id_conto = s.id_conto)
									using SQLCA;
											
	delete from sottomastro
		where sottomastro.id_sottomastro = :li_id_mm
		and sottomastro.id_sottomastro not in (select conto.id_sottomastro from conto
									where conto.id_sottomastro = sottomastro.id_sottomastro)
									using SQLCA;
	
	select id_sottomastro
		into :ll_id
		from sottomastro
			where sottomastro.id_sottomastro = :li_id_mm;
	
	IF ll_id <> 0 then
		messagebox ('Attenzione', 'Ci sono conti movimentati per questo sottomastro', StopSign!)
	END IF
			
	
	ll_id_mastro = dw_sottomastro_gd.GetItemNumber (1, "id_mastro")	
	dw_sottomastro_gd.retrieve (ll_id_mastro)

END IF
end event

