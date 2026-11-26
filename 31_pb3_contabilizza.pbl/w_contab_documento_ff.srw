forward
global type w_contab_documento_ff from w_wiz_main
end type
type p_msg_log from picture within w_contab_documento_ff
end type
type rb_acquisti from radiobutton within w_contab_documento_ff
end type
type rb_vendite from radiobutton within w_contab_documento_ff
end type
type dw_contab_documento_gd from u_dw_pura within w_contab_documento_ff
end type
type cb_chiudi from commandbutton within w_contab_documento_ff
end type
type cb_contabilizza from commandbutton within w_contab_documento_ff
end type
type gb_1 from groupbox within w_contab_documento_ff
end type
type rb_corrispettivi from radiobutton within w_contab_documento_ff
end type
type dw_1 from datawindow within w_contab_documento_ff
end type
type st_1 from statictext within w_contab_documento_ff
end type
end forward

global type w_contab_documento_ff from w_wiz_main
int X=174
int Y=300
int Width=2574
int Height=1112
WindowType WindowType=response!
boolean TitleBar=true
string Title="Contabilizzazione Documenti"
p_msg_log p_msg_log
rb_acquisti rb_acquisti
rb_vendite rb_vendite
dw_contab_documento_gd dw_contab_documento_gd
cb_chiudi cb_chiudi
cb_contabilizza cb_contabilizza
gb_1 gb_1
rb_corrispettivi rb_corrispettivi
dw_1 dw_1
st_1 st_1
end type
global w_contab_documento_ff w_contab_documento_ff

type variables
integer 		ii_anno = Year(Today())
string 		is_tipo_documento = "IV"
string 		is_item_precedente
uo_msg_log	iuo_msg_log
u_contab_documento iu_contab_documento
integer		ii_msg_status = 0

end variables

forward prototypes
public function decimal uf_ricerca_max_num_progr (long al_id_registro)
public subroutine uf_contabilizza ()
public subroutine uf_imposta_tipo_documento ()
end prototypes

public function decimal uf_ricerca_max_num_progr (long al_id_registro);

decimal ldc_max_num_progressivo, ldc_RetVal = 0

SetNull(ldc_max_num_progressivo)
SELECT Max(reg_pd.num_progressivo)
	INTO :ldc_max_num_progressivo
	FROM reg_pd
	WHERE reg_pd.id_registro = :al_id_registro;

IF NOT IsNull(ldc_max_num_progressivo) THEN ldc_RetVal = ldc_max_num_progressivo

RETURN ldc_RetVal
end function

public subroutine uf_contabilizza ();

long ll_id_registro, ll_righe, ll_i
decimal ldc_cprogr_dal, ldc_cprogr_al
date ld_data_dal, ld_data_al
char lc_flag
string ls_msg 
CONSTANT DECIMAL LCDC_MAX_NUM_PROGRESSIVO = 999999999999.0
ll_righe = dw_contab_documento_gd.RowCount()

IF ll_righe > 0 THEN
	SetPointer(HourGlass!)
	cb_contabilizza.enabled = FALSE
	cb_chiudi.enabled = FALSE
	
	iuo_msg_log.uf_show_msg_log()
	iuo_msg_log.uf_new_text("Contabilizzazione in corso. Attendere...", 2)

	dw_contab_documento_gd.AcceptText()
	FOR ll_i = 1 TO ll_righe
		lc_flag = dw_contab_documento_gd.GetItemString(ll_i, "ccontab_flag")
		
		ldc_cprogr_dal = dw_contab_documento_gd.GetItemNumber(ll_i, "cprogr_dal")
		ldc_cprogr_al = dw_contab_documento_gd.GetItemNumber(ll_i, "cprogr_al")
		IF IsNull(ldc_cprogr_al) THEN ldc_cprogr_al = LCDC_MAX_NUM_PROGRESSIVO

		
		ld_data_dal = dw_contab_documento_gd.GetItemDate(ll_i, "cdata_dal")
		ld_data_al = dw_contab_documento_gd.GetItemDate(ll_i, "cdata_al")
		IF IsNull(ld_data_al) THEN ld_data_al = Date("31-12-3000")

		ll_id_registro = dw_contab_documento_gd.GetItemNumber(ll_i, "registro_id_registro")

		IF (lc_flag = "S") AND (ldc_cprogr_dal <= ldc_cprogr_al) AND (ld_data_dal <= ld_data_al) THEN
			
         IF iu_contab_documento.uf_crea_reg_pd(ll_id_registro,    &
			                                      ldc_cprogr_dal,    &
															  ldc_cprogr_al,     &
															  ld_data_dal,       &
															  ld_data_al,        &
															  is_tipo_documento, &
															  ls_msg) <> 0 THEN
				ll_i = ll_righe
			END IF
		END IF
		dw_contab_documento_gd.SetItem(ll_i, "ccontab_flag", "N")
	NEXT
	iuo_msg_log.uf_new_text(ls_msg, 2)

	cb_contabilizza.enabled = TRUE
	cb_chiudi.enabled = TRUE
	SetPointer(Arrow!)
END IF
dw_contab_documento_gd.Event ue_retrieve()
end subroutine

public subroutine uf_imposta_tipo_documento ();

IF rb_vendite.Checked = TRUE THEN is_tipo_documento = "IV"
IF rb_acquisti.Checked = TRUE THEN is_tipo_documento = "IA"
end subroutine

on w_contab_documento_ff.create
int iCurrent
call super::create
this.p_msg_log=create p_msg_log
this.rb_acquisti=create rb_acquisti
this.rb_vendite=create rb_vendite
this.dw_contab_documento_gd=create dw_contab_documento_gd
this.cb_chiudi=create cb_chiudi
this.cb_contabilizza=create cb_contabilizza
this.gb_1=create gb_1
this.rb_corrispettivi=create rb_corrispettivi
this.dw_1=create dw_1
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_msg_log
this.Control[iCurrent+2]=this.rb_acquisti
this.Control[iCurrent+3]=this.rb_vendite
this.Control[iCurrent+4]=this.dw_contab_documento_gd
this.Control[iCurrent+5]=this.cb_chiudi
this.Control[iCurrent+6]=this.cb_contabilizza
this.Control[iCurrent+7]=this.gb_1
this.Control[iCurrent+8]=this.rb_corrispettivi
this.Control[iCurrent+9]=this.dw_1
this.Control[iCurrent+10]=this.st_1
end on

on w_contab_documento_ff.destroy
call super::destroy
destroy(this.p_msg_log)
destroy(this.rb_acquisti)
destroy(this.rb_vendite)
destroy(this.dw_contab_documento_gd)
destroy(this.cb_chiudi)
destroy(this.cb_contabilizza)
destroy(this.gb_1)
destroy(this.rb_corrispettivi)
destroy(this.dw_1)
destroy(this.st_1)
end on

event open;call super::open;


dw_1.settransobject(sqlca)
dw_1.insertrow(0)
long ll_eser
SELECT id_esercizio_proposto   
INTO :ll_eser
FROM azienda   
WHERE id_azienda in (0, 1) ;

dw_1.setitem(1,'esercizio',ll_eser)




dw_contab_documento_gd.SetTransObject(SQLCA)
dw_contab_documento_gd.Event ue_retrieve()

iu_contab_documento = create u_contab_documento

IF dw_contab_documento_gd.RowCount() > 0 THEN
	is_item_precedente = dw_contab_documento_gd.GetColumnName()
END IF

uf_imposta_tipo_documento()

IF IsValid(w_msg_log) THEN
	w_msg_log.x = 900
	w_msg_log.width = 2700
	w_msg_log.height = 400
END IF



end event

event closequery;call super::closequery;

iuo_msg_log.uf_hide_msg_log()

end event

type p_msg_log from picture within w_contab_documento_ff
int X=873
int Y=24
int Width=105
int Height=88
string PictureName="s:\pb\commonframework\info_in.bmp"
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
boolean FocusRectangle=false
end type

event clicked;ii_msg_status = iuo_msg_log.uf_manage_msg()
parent.SetFocus()

end event

type rb_acquisti from radiobutton within w_contab_documento_ff
int X=2098
int Y=92
int Width=375
int Height=76
string Text="IVA &Acquisti"
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;is_tipo_documento = "IA"
dw_contab_documento_gd.Event ue_retrieve()
end event

type rb_vendite from radiobutton within w_contab_documento_ff
int X=1664
int Y=92
int Width=366
int Height=76
string Text="IVA &Vendite"
boolean Checked=true
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;is_tipo_documento = "IV"
dw_contab_documento_gd.Event ue_retrieve()
end event

type dw_contab_documento_gd from u_dw_pura within w_contab_documento_ff
event ue_retrieve ( )
int X=32
int Y=240
int Width=2469
int Height=740
int TabOrder=10
string DataObject="d_contab_documento2_gd"
boolean TitleBar=true
string Title="Registri per i quali eseguire la contabilizzazione"
boolean VScrollBar=true
end type

event ue_retrieve;

string ls_tipo_registro, ls_anno_da, ls_anno_a
date ld_data_inizio, ld_data_fine


long ll_eser
ll_eser=dw_1.getitemnumber(1,'esercizio')
SELECT data_inizio, data_fine  
INTO   :ld_data_inizio, :ld_data_fine  

FROM   esercizio  
WHERE  id_esercizio=:ll_eser; 





IF IsNull(ld_data_inizio) OR IsNull(ld_data_fine) THEN
	MessageBox("Contabilizzazione Documenti", "Attenzione: Non è stato impostato l'esercizio proposto dell'azienda corrente.")
ELSE
	IF rb_acquisti.Checked = TRUE THEN
		ls_tipo_registro = "IA"
	ELSEIF rb_vendite.Checked = TRUE THEN
		ls_tipo_registro = "IV"
	ELSEIF rb_corrispettivi.Checked = TRUE THEN
		ls_tipo_registro = "IC"
	END IF
	ls_anno_da = string(year(ld_data_inizio))
	ls_anno_a = string(year(ld_data_fine))

		dw_contab_documento_gd.Retrieve(ls_tipo_registro, ls_anno_da, ls_anno_a)
	
END IF
end event

event doubleclicked;

char lc_flag

lc_flag = dw_contab_documento_gd.GetItemString(row, "ccontab_flag")

CHOOSE CASE lc_flag
	CASE "S"
		dw_contab_documento_gd.SetItem(row, "ccontab_flag", "N")
	CASE ELSE
		dw_contab_documento_gd.SetItem(row, "ccontab_flag", "S")
END CHOOSE

end event

event itemfocuschanged;

modify(is_item_precedente + "_t" + ".Color='0'")
modify(dwo.name + "_t" + ".Color='16777215'")

is_item_precedente = dwo.name
end event

event editchanged;
string ls_data, ls_col

if dwo.name="cdata_dal" or dwo.name="cdata_al" then
   ls_col=dwo.name
	ls_data = left(data,2)+"/"+mid(data,3,2)+"/"+mid(data,5)
	if IsDate(ls_data) then
		this.setItem(row,ls_col,date(ls_data))
		return 2
	else
		return 0
	end if
	
end if

end event

type cb_chiudi from commandbutton within w_contab_documento_ff
int X=430
int Y=20
int Width=347
int Height=88
int TabOrder=30
string Text="&Chiudi"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Close(Parent)
end event

type cb_contabilizza from commandbutton within w_contab_documento_ff
int X=32
int Y=20
int Width=347
int Height=88
int TabOrder=20
string Text="C&ontabilizza"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

uf_contabilizza()
end event

type gb_1 from groupbox within w_contab_documento_ff
int X=1065
int Y=32
int Width=1435
int Height=160
int TabOrder=40
string Text="Tipo Documenti"
BorderStyle BorderStyle=StyleLowered!
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_corrispettivi from radiobutton within w_contab_documento_ff
int X=1152
int Y=92
int Width=457
int Height=76
boolean BringToTop=true
string Text="IVA Corrispettivi"
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;is_tipo_documento = "IC"
dw_contab_documento_gd.Event ue_retrieve()
end event

type dw_1 from datawindow within w_contab_documento_ff
int X=389
int Y=124
int Width=393
int Height=96
int TabOrder=50
boolean BringToTop=true
string DataObject="d_esercizio_list"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

event itemchanged;dw_contab_documento_gd.post Event ue_retrieve()
end event

type st_1 from statictext within w_contab_documento_ff
int X=101
int Y=140
int Width=247
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Esercizio:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

