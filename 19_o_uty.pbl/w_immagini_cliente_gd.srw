forward
global type w_immagini_cliente_gd from w_np_single_data
end type
type cbx_riproponi_sog from radiobutton within w_immagini_cliente_gd
end type
type cbx_riproponi_articolo from radiobutton within w_immagini_cliente_gd
end type
type cb_stampa from commandbutton within w_immagini_cliente_gd
end type
type cbx_libero from radiobutton within w_immagini_cliente_gd
end type
type cbx_automatico from checkbox within w_immagini_cliente_gd
end type
end forward

global type w_immagini_cliente_gd from w_np_single_data
int Width=2967
int Height=1312
boolean TitleBar=true
string Title="Associa Immagini a Soggetti Commerciali"
cbx_riproponi_sog cbx_riproponi_sog
cbx_riproponi_articolo cbx_riproponi_articolo
cb_stampa cb_stampa
cbx_libero cbx_libero
cbx_automatico cbx_automatico
end type
global w_immagini_cliente_gd w_immagini_cliente_gd

forward prototypes
public subroutine wf_nome_imm_automatico (long al_riga)
end prototypes

public subroutine wf_nome_imm_automatico (long al_riga);string ls_conto, ls_imm_base, ls_imm, ls_cod_ana
if al_riga>0 then
	if al_riga<>dw_single.getrow() then al_riga=dw_single.getrow()
	ls_conto=dw_single.getitemstring(al_riga, "sog_commerciale_codice")
	select a.codice
	into :ls_cod_ana
	from anagrafica a, sog_commerciale s
	where a.id_anagrafica=s.id_anagrafica
	and s.codice=:ls_conto;
	ls_imm_base=dw_single.getitemstring(al_riga, "articolo_immagine")
	ls_imm=left(ls_imm_base, len(ls_imm_base) - 4) +"_"+ ls_cod_ana+right(ls_imm_base, 4)
	dw_single.setitem(al_riga, "immagini_cliente_nome_immagine", ls_imm)
end if
end subroutine

on w_immagini_cliente_gd.create
int iCurrent
call super::create
this.cbx_riproponi_sog=create cbx_riproponi_sog
this.cbx_riproponi_articolo=create cbx_riproponi_articolo
this.cb_stampa=create cb_stampa
this.cbx_libero=create cbx_libero
this.cbx_automatico=create cbx_automatico
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_riproponi_sog
this.Control[iCurrent+2]=this.cbx_riproponi_articolo
this.Control[iCurrent+3]=this.cb_stampa
this.Control[iCurrent+4]=this.cbx_libero
this.Control[iCurrent+5]=this.cbx_automatico
end on

on w_immagini_cliente_gd.destroy
call super::destroy
destroy(this.cbx_riproponi_sog)
destroy(this.cbx_riproponi_articolo)
destroy(this.cb_stampa)
destroy(this.cbx_libero)
destroy(this.cbx_automatico)
end on

event resize;
end event

type p_crescente from w_np_single_data`p_crescente within w_immagini_cliente_gd
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_immagini_cliente_gd
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_immagini_cliente_gd
int X=41
int Y=132
int Width=2843
int Height=1040
int TabOrder=30
string DataObject="d_immagini_cliente_gd"
end type

event dw_single::itemchanged;integer li_ok

string ls_sql_cond,  ls_campo_filtro
string ls_dbc[], ls_dwc[], ls_dbv[]


choose case string(dwo.name)

	
	CASE "sog_commerciale_codice", "anagrafica_rag_soc_1"
			ls_sql_cond = ""
			
			ls_dbc[1] = "codice"
			ls_dbc[2] = "rag_soc_1"
			ls_dbc[3]= "id_sog_commerciale"
			
			ls_dwc[1] = "sog_commerciale_codice"
			ls_dwc[2] = "anagrafica_rag_soc_1"
			ls_dwc[3] = "immagini_cliente_id_sog_commerciale"
			
			if string(dwo.name)="sog_commerciale_codice" then
				ls_campo_filtro="codice"
			else
				ls_campo_filtro="rag_soc_1"
			end if
			
			li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", ls_campo_filtro, "A", data, ls_sql_cond, 3, &
				ls_dbc, ls_dbv, ls_dwc)
				
			IF (li_ok > 0) THEN
				RETURN 
			else
				
			END IF
	CASE "articolo_codice"
			ls_sql_cond = ""
			
			ls_dbc[1] = "codice"
			ls_dbc[2] = "descrizione"
			ls_dbc[3] = "id_articolo"
			ls_dbc[4] = "immagine"
			
			ls_dwc[1] = "articolo_codice"
			ls_dwc[2] = "articolo_descrizione"
			ls_dwc[3] = "immagini_cliente_id_articolo"
			ls_dwc[4] = "articolo_immagine"
			
			li_ok = uf_autofind_col(dwo.Name, "articolo", "codice", "A", data, ls_sql_cond, 4, &
				ls_dbc, ls_dbv, ls_dwc)
				
			
			 if cbx_automatico.checked then 	post wf_nome_imm_automatico(row)
			IF (li_ok > 0) THEN
				RETURN 2
			else
				
			END IF
			
end choose
end event

event dw_single::ue_insert;long ll_riga, ll_id_sog, ll_id_articolo
string ls_codice, ls_rag_soc, ls_articolo, ls_des_articolo, ls_immagine

ll_riga=insertrow(0)
scrolltorow(ll_riga)

if ll_riga>1 then
	if cbx_riproponi_sog.checked then
		ls_codice=dw_single.getitemstring(ll_riga - 1, "sog_commerciale_codice")
		ls_rag_soc=	dw_single.getitemstring(ll_riga - 1, "anagrafica_rag_soc_1")
		ll_id_sog=dw_single.getitemnumber(ll_riga - 1, "immagini_cliente_id_sog_commerciale")
		dw_single.setitem(ll_riga,  "sog_commerciale_codice", ls_codice)
		dw_single.setitem(ll_riga,  "anagrafica_rag_soc_1", ls_rag_soc)
		dw_single.setitem(ll_riga,  "immagini_cliente_id_sog_commerciale", ll_id_sog)
		setcolumn("articolo_codice")
	end if
	if	cbx_riproponi_articolo.checked then
		ll_id_articolo=dw_single.getitemnumber(ll_riga - 1, "immagini_cliente_id_articolo")
		ls_articolo=dw_single.getitemstring(ll_riga - 1, "articolo_codice")
		ls_des_articolo=dw_single.getitemstring(ll_riga - 1, "articolo_descrizione")
		ls_immagine=dw_single.getitemstring(ll_riga - 1, "articolo_immagine")
		dw_single.setitem(ll_riga,  "articolo_codice", ls_articolo)
		dw_single.setitem(ll_riga,  "articolo_descrizione", ls_des_articolo)
		dw_single.setitem(ll_riga,  "immagini_cliente_id_articolo", ll_id_articolo)
		dw_single.setitem(ll_riga,  "articolo_immagine", ls_immagine)
		setcolumn("sog_commerciale_codice")
	end if
	
	scrolltorow(ll_riga)
end if

end event

event dw_single::rowfocuschanged;setrowfocusindicator(hand!)
end event

event dw_single::ue_set_search;call super::ue_set_search;if as_nomecol= "sog_commerciale_codice" or as_nomecol = "anagrafica_rag_soc_1" then
	is_search_window = "w_sog_commerciale_gen_coddes_sw"
	IF as_nomecol = "sog_commerciale_codice" THEN
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "codice"
	ELSEIF as_nomecol = "anagrafica_rag_soc_1" THEN
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "rag_soc_1"
	END IF
end if
if as_nomecol= "articolo_codice" then
	is_search_window = "w_articolo_coddes_sw"
	is_ricpar.s_filter_value = as_valcol
	is_ricpar.s_filter_name = "articolo_codice"
end if
	
end event

event dw_single::ue_use_search;string ls_imm

if as_nomecol="sog_commerciale_codice" then
	uf_set_colval(as_nomecol, is_ricpar.s_main_value)
	uf_set_colval("immagini_cliente_id_sog_commerciale", is_ricpar.s_id_seg_value[1])
	uf_set_colval("anagrafica_rag_soc_1", is_ricpar.s_ausil_value[1])
elseif 	as_nomecol="anagrafica_rag_soc_1" then
	uf_set_colval(as_nomecol, is_ricpar.s_main_value)
	uf_set_colval("immagini_cliente_id_sog_commerciale", is_ricpar.s_id_seg_value[1])
	uf_set_colval("sog_commerciale_codice", is_ricpar.s_ausil_value[1])
end if  

if as_nomecol="articolo_codice" then
	uf_set_colval(as_nomecol, is_ricpar.s_main_value)
	uf_set_colval("immagini_cliente_id_articolo", is_ricpar.s_id_seg_value[1])
	uf_set_colval("articolo_descrizione", is_ricpar.s_ausil_value[1])
	select immagine
	into :ls_imm
	from articolo
	where id_articolo=:is_ricpar.s_id_seg_value[1];
	uf_set_colval("articolo_immagine", ls_imm)
	
	if cbx_automatico.checked then 	post wf_nome_imm_automatico(getrow())
end if
end event

type cbx_riproponi_sog from radiobutton within w_immagini_cliente_gd
int X=1765
int Y=36
int Width=594
int Height=76
int TabOrder=10
boolean BringToTop=true
string Text="Riproponi Sog. Comm."
BorderStyle BorderStyle=StyleLowered!
boolean Checked=true
boolean LeftText=true
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cbx_riproponi_articolo from radiobutton within w_immagini_cliente_gd
int X=2405
int Y=36
int Width=475
int Height=76
int TabOrder=20
boolean BringToTop=true
string Text="Riproponi Articolo"
BorderStyle BorderStyle=StyleLowered!
boolean LeftText=true
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_stampa from commandbutton within w_immagini_cliente_gd
int X=46
int Y=12
int Width=247
int Height=108
int TabOrder=10
boolean BringToTop=true
string Text="Stampa"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;datastore ds_stampa

dw_single.triggerevent("ue_update")

ds_stampa=create datastore
ds_stampa.dataobject="d_immagini_cliente_rpt"
dw_single.rowscopy(1, dw_single.rowcount(), primary!, ds_stampa, 1, primary!)
printsetup()
ds_stampa.sort()
ds_stampa.print()
destroy (ds_stampa)

end event

type cbx_libero from radiobutton within w_immagini_cliente_gd
int X=1394
int Y=36
int Width=279
int Height=76
boolean BringToTop=true
string Text="Libero"
BorderStyle BorderStyle=StyleLowered!
boolean LeftText=true
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cbx_automatico from checkbox within w_immagini_cliente_gd
int X=320
int Y=36
int Width=750
int Height=76
boolean BringToTop=true
string Text="Nome immagine in automatico"
BorderStyle BorderStyle=StyleLowered!
boolean Checked=true
boolean LeftText=true
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

