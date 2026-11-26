forward
global type w_orafo_fabbisogni_cx from Window
end type
type st_risultato_extra_necessario from statictext within w_orafo_fabbisogni_cx
end type
type st_7 from statictext within w_orafo_fabbisogni_cx
end type
type st_6 from statictext within w_orafo_fabbisogni_cx
end type
type st_5 from statictext within w_orafo_fabbisogni_cx
end type
type st_risultato_extra_peso from statictext within w_orafo_fabbisogni_cx
end type
type st_4 from statictext within w_orafo_fabbisogni_cx
end type
type st_risultato_pezzi from statictext within w_orafo_fabbisogni_cx
end type
type st_3 from statictext within w_orafo_fabbisogni_cx
end type
type ddlb_1 from dropdownlistbox within w_orafo_fabbisogni_cx
end type
type st_risultato_misura from statictext within w_orafo_fabbisogni_cx
end type
type st_risultato_peso from statictext within w_orafo_fabbisogni_cx
end type
type cb_2 from commandbutton within w_orafo_fabbisogni_cx
end type
type cb_calcola from commandbutton within w_orafo_fabbisogni_cx
end type
type dw_articolo from datawindow within w_orafo_fabbisogni_cx
end type
type tab_1 from tab within w_orafo_fabbisogni_cx
end type
type tabpage_1 from userobject within tab_1
end type
type st_1 from statictext within tabpage_1
end type
type dw_comp from datawindow within tabpage_1
end type
type tabpage_2 from userobject within tab_1
end type
type cb_cambia_padre from commandbutton within tabpage_2
end type
type dw_prod from datawindow within tabpage_2
end type
type st_2 from statictext within tabpage_2
end type
type tv_1 from treeview within w_orafo_fabbisogni_cx
end type
type dw_um from datawindow within w_orafo_fabbisogni_cx
end type
type st_8 from statictext within w_orafo_fabbisogni_cx
end type
type gb_1 from groupbox within w_orafo_fabbisogni_cx
end type
type tabpage_1 from userobject within tab_1
st_1 st_1
dw_comp dw_comp
end type
type tabpage_2 from userobject within tab_1
cb_cambia_padre cb_cambia_padre
dw_prod dw_prod
st_2 st_2
end type
type tab_1 from tab within w_orafo_fabbisogni_cx
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
end forward

global type w_orafo_fabbisogni_cx from Window
int X=168
int Y=51
int Width=2637
int Height=1824
boolean TitleBar=true
string Title="Fabbisogni articoli"
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
st_risultato_extra_necessario st_risultato_extra_necessario
st_7 st_7
st_6 st_6
st_5 st_5
st_risultato_extra_peso st_risultato_extra_peso
st_4 st_4
st_risultato_pezzi st_risultato_pezzi
st_3 st_3
ddlb_1 ddlb_1
st_risultato_misura st_risultato_misura
st_risultato_peso st_risultato_peso
cb_2 cb_2
cb_calcola cb_calcola
dw_articolo dw_articolo
tab_1 tab_1
tv_1 tv_1
dw_um dw_um
st_8 st_8
gb_1 gb_1
end type
global w_orafo_fabbisogni_cx w_orafo_fabbisogni_cx

type variables
string is_tipo_qta=""
decimal peso_articolo, lunghezza_articolo , titolo_originario
long  ll_id_padre
string ls_codice
boolean cambia_Padre
end variables

forward prototypes
public subroutine wf_calcola (long al_id_art, decimal ad_qta_finale, ref datawindow adw_ret, ref datastore ads_ret)
public subroutine calcola_fabbisogno ()
end prototypes

public subroutine wf_calcola (long al_id_art, decimal ad_qta_finale, ref datawindow adw_ret, ref datastore ads_ret);long ll_righe, i, ll_id_art, ll_ret,ll_id_tab_iva, ll_row, ll_id_un_conf
decimal {4} ld_fat_conv, ld_molt
decimal{2} ld_qta, ld_qta_padre
string ls_tipo_conv, ls_um, ls_up, ls_des
integer li_ret
s_ordine ls_vuoto, ls_ordine

ls_ordine=ls_vuoto
adw_ret.Reset()
	
	SetNull(ld_qta)
	ls_ordine.cod_padre=dw_articolo.GetitemString(1,"articolo_cod")
	ls_ordine.riga=1
	
	ls_ordine.misura_num=dw_um.GetitemNumber(1,"dim_l")
	ls_ordine.u_misura=dw_um.Getitemstring(1,"um_vol_simbolo")
	
	ls_ordine.peso_num=dw_um.GetitemNumber(1,"peso_netto")
	ls_ordine.u_peso=dw_um.GetitemString(1,"um_peso_simbolo")
	
	ld_qta=ad_qta_finale
	ls_ordine.quantita=ld_qta
	ls_ordine.id_padre=al_id_art
	
	ls_ordine=f_esplodi_dw_fabbisogno(tv_1,0,true,0,date('1910/10/10'),date('3000/10/10'),0,"","",0,false,&
			adw_ret, al_id_art, ld_qta, ls_ordine,0,true)
	li_ret=UpperBound(ls_ordine.cod_figlio)
	if (li_ret=0) then
		
		
			ls_ordine.cod_figlio[1]=ls_ordine.cod_padre
			ld_qta_padre=ld_qta
			ls_des=dw_articolo.GetitemString(1,"articolo_des")
			ls_ordine.quantita=ld_qta_padre
			ls_ordine.id_figlio[1]=ls_ordine.id_padre
			ls_ordine.qta_figlio[1]=ld_qta_padre
			ls_ordine.des_figlio[1]=ls_des
			ls_ordine.u_misura_figlio[1]=ls_ordine.u_misura
			ls_ordine.u_peso_figlio[1]=ls_ordine.u_peso
			ll_row=adw_ret.InsertRow(0)
			adw_ret.SetRow(ll_row)
			adw_ret.setitem(ll_row,"riga_documento_id_articolo",ls_ordine.id_padre)
			adw_ret.setitem(ll_row,"quantita",ld_qta_padre)
			adw_ret.setitem(ll_row,"c_articolo_cod",ls_ordine.cod_padre)
			adw_ret.setitem(ll_row,"riga_documento_descrizione",ls_des)
		end if
		

	adw_ret.SetSort("rag_soc_1 A")
	adw_ret.Sort()
	li_ret=adw_ret.RowsCopy(1,adw_ret.rowCount(),Primary!,ads_ret,1,Primary!)

end subroutine

public subroutine calcola_fabbisogno ();
dw_articolo.acceptText()


if not(isnull(dw_articolo.getitemnumber(1,"id_articolo"))) then
	
	
	dec s_titolo 
string titolo
long id_articolo
id_articolo = dw_articolo.getitemnumber(1,"id_articolo")
ddlb_1.Reset()
select "articolo"."id_titolo"
into :titolo
from "articolo"
where "articolo"."id_articolo" = :id_articolo ;

  SELECT "unita_confezione"."peso_netto",   
         "unita_confezione"."dim_l"  
	INTO :peso_articolo, :lunghezza_articolo
   FROM "unita_confezione"  
   WHERE ( "unita_confezione"."id_articolo" = :id_articolo ) and  
         ( ( "unita_confezione"."unita_base" = 'S' ) )    ;



if titolo<>"" or not(isnull(titolo)) then
decimal titolo_prodotto  

ddlb_1.SetRedraw(FALSE)
	SELECT "orafo_titolo"."id_metallo", "orafo_titolo"."titolo" 
	into :titolo_prodotto, :titolo_originario
	FROM "orafo_titolo" 
	WHERE ( "orafo_titolo"."id_titolo" = :titolo) ;
	
DECLARE elenco_titoli CURSOR FOR

  SELECT DISTINCT "orafo_titolo"."titolo"  
    FROM "orafo_titolo"  
   WHERE "orafo_titolo"."id_metallo" = :titolo_prodotto ;
	
	OPEN elenco_titoli ;
	

FETCH elenco_titoli
	INTO :s_titolo;

DO WHILE  not(SQLCA.SQLCode <> 0)
	ddlb_1.AddItem(string(s_titolo))
	FETCH elenco_titoli
	INTO :s_titolo;
	
LOOP



CLOSE elenco_titoli;



ddlb_1.SetRedraw(TRUE)	
ddlb_1.SelectItem(string(titolo_originario), 1)
ddlb_1.SetFocus ( )
 ddlb_1.trigger event SelectionChanged(0)
else 
	messagebox("Alert", "L'articolo non ha titolo")
end if
else
	
	ddlb_1.Reset()

end if


end subroutine

on w_orafo_fabbisogni_cx.create
this.st_risultato_extra_necessario=create st_risultato_extra_necessario
this.st_7=create st_7
this.st_6=create st_6
this.st_5=create st_5
this.st_risultato_extra_peso=create st_risultato_extra_peso
this.st_4=create st_4
this.st_risultato_pezzi=create st_risultato_pezzi
this.st_3=create st_3
this.ddlb_1=create ddlb_1
this.st_risultato_misura=create st_risultato_misura
this.st_risultato_peso=create st_risultato_peso
this.cb_2=create cb_2
this.cb_calcola=create cb_calcola
this.dw_articolo=create dw_articolo
this.tab_1=create tab_1
this.tv_1=create tv_1
this.dw_um=create dw_um
this.st_8=create st_8
this.gb_1=create gb_1
this.Control[]={this.st_risultato_extra_necessario,&
this.st_7,&
this.st_6,&
this.st_5,&
this.st_risultato_extra_peso,&
this.st_4,&
this.st_risultato_pezzi,&
this.st_3,&
this.ddlb_1,&
this.st_risultato_misura,&
this.st_risultato_peso,&
this.cb_2,&
this.cb_calcola,&
this.dw_articolo,&
this.tab_1,&
this.tv_1,&
this.dw_um,&
this.st_8,&
this.gb_1}
end on

on w_orafo_fabbisogni_cx.destroy
destroy(this.st_risultato_extra_necessario)
destroy(this.st_7)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.st_risultato_extra_peso)
destroy(this.st_4)
destroy(this.st_risultato_pezzi)
destroy(this.st_3)
destroy(this.ddlb_1)
destroy(this.st_risultato_misura)
destroy(this.st_risultato_peso)
destroy(this.cb_2)
destroy(this.cb_calcola)
destroy(this.dw_articolo)
destroy(this.tab_1)
destroy(this.tv_1)
destroy(this.dw_um)
destroy(this.st_8)
destroy(this.gb_1)
end on

event open;dw_articolo.insertrow(0)
dw_um.settransobject(sqlca)
setnull(ll_id_padre)
cambia_Padre=FALSE
end event

type st_risultato_extra_necessario from statictext within w_orafo_fabbisogni_cx
int X=1584
int Y=547
int Width=249
int Height=51
boolean Enabled=false
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_7 from statictext within w_orafo_fabbisogni_cx
int X=1968
int Y=451
int Width=249
int Height=77
boolean Enabled=false
string Text="Pezzi:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_6 from statictext within w_orafo_fabbisogni_cx
int X=1382
int Y=451
int Width=249
int Height=77
boolean Enabled=false
string Text="Misura:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_5 from statictext within w_orafo_fabbisogni_cx
int X=819
int Y=458
int Width=208
int Height=77
boolean Enabled=false
string Text="Legato:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_risultato_extra_peso from statictext within w_orafo_fabbisogni_cx
int X=2249
int Y=547
int Width=263
int Height=58
long TextColor=33554432
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_4 from statictext within w_orafo_fabbisogni_cx
int X=1847
int Y=544
int Width=388
int Height=64
boolean Enabled=false
string Text="Peso in eccesso:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_risultato_pezzi from statictext within w_orafo_fabbisogni_cx
int X=2242
int Y=445
int Width=263
int Height=77
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=16777215
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_orafo_fabbisogni_cx
int X=95
int Y=445
int Width=150
int Height=77
boolean Enabled=false
string Text="Titolo"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type ddlb_1 from dropdownlistbox within w_orafo_fabbisogni_cx
int X=263
int Y=451
int Width=512
int Height=419
int TabOrder=50
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event selectionchanged;integer campo
decimal titolo_ratio
long a,b,c

dw_articolo.acceptText()


campo = 0
if string(dw_articolo.getitemnumber(1,"qta_gr"))<>"" then
	campo=1
end if

if string(dw_articolo.getitemnumber(1,"qta_cm"))<>"" then
	campo=2
end if

if string(dw_articolo.getitemnumber(1,"qta_pz"))<>"" then
	campo=3
end if
IF titolo_originario<>0 THEN
titolo_ratio = dec(ddlb_1.text) / titolo_originario
ELSE
	MESSAGEBox("alert","titolo articolo mancante!")	
	return 0
END IF
dec tmp
CHOOSE CASE campo
	CASE 1
		
		if peso_articolo<>0 then
		tmp = dw_articolo.getitemnumber(1,"qta_gr") / (titolo_ratio * peso_articolo)
	else
		MESSAGEBox("alert","peso articolo mancante!")	
		return 0
	end if
		
		st_risultato_pezzi.text=string(truncate(tmp,0))
		st_risultato_misura.text=string(tmp *  lunghezza_articolo,"#.00")
		st_risultato_peso.text=string(dw_articolo.getitemnumber(1,"qta_gr"))
		
		
		if ((tmp - truncate(tmp,0)) * peso_articolo) = 0 then
			st_risultato_extra_peso.text = "0"
		else
			st_risultato_extra_peso.text = string((tmp - truncate(tmp,0)) * peso_articolo,"#.00")
		end if
		
		if ((tmp - truncate(tmp,0)) * peso_articolo) = 0 then
			st_risultato_extra_necessario.text = "0"
		else
			st_risultato_extra_necessario.text = string(peso_articolo - ((tmp - truncate(tmp,0)) * peso_articolo),"#.00")
		end if
		
	CASE 2
		
		if lunghezza_articolo <> 0 then
		tmp = dw_articolo.getitemnumber(1,"qta_cm") / (titolo_ratio * lunghezza_articolo)
	else
		MESSAGEBox("alert","lunghezza articolo mancante!")	
		return 0
	end if
		st_risultato_pezzi.text=string(truncate(tmp,0))
		st_risultato_peso.text=string(tmp *  peso_articolo,"#.00")
		st_risultato_misura.text=string(dw_articolo.getitemnumber(1,"qta_cm"))
		
		if ((tmp - truncate(tmp,0)) * peso_articolo) = 0 then
			st_risultato_extra_peso.text = "0"
		else
			st_risultato_extra_peso.text = string((tmp - truncate(tmp,0)) * peso_articolo,"#.00")
		end if
		if ((tmp - truncate(tmp,0)) * peso_articolo) = 0 then
			st_risultato_extra_necessario.text = "0"
		else
			st_risultato_extra_necessario.text = string(peso_articolo - ((tmp - truncate(tmp,0)) * peso_articolo),"#.00")
		end if
		
	CASE 3
		
		
		tmp = dw_articolo.getitemnumber(1,"qta_pz") / (titolo_ratio)
		
		st_risultato_misura.text = string(tmp * lunghezza_articolo,"#.00")
		st_risultato_peso.text   = string(tmp * peso_articolo,"#.00")
		st_risultato_pezzi.text  = string(truncate(tmp,0))
		if tmp = 0 then
			st_risultato_extra_peso.text = "0"
		else
			st_risultato_extra_peso.text = string(tmp ,"#.00")
		end if
		st_risultato_extra_peso.text="0"
		
		if ((tmp - truncate(tmp,0)) * peso_articolo) = 0 then
			st_risultato_extra_necessario.text = "0"
		else
			st_risultato_extra_necessario.text = string(peso_articolo - ((tmp - truncate(tmp,0)) * peso_articolo),"#.00")
		end if
	CASE ELSE
		
END CHOOSE

end event

type st_risultato_misura from statictext within w_orafo_fabbisogni_cx
int X=1664
int Y=445
int Width=263
int Height=77
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=16777215
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_risultato_peso from statictext within w_orafo_fabbisogni_cx
int X=1046
int Y=445
int Width=263
int Height=77
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=16777215
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_2 from commandbutton within w_orafo_fabbisogni_cx
int X=2637
int Y=531
int Width=249
int Height=109
int TabOrder=40
boolean Visible=false
string Text="none"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_righe, i, ll_id_art, ll_ret,ll_id_tab_iva, ll_row, ll_id_un_conf
decimal {4} ld_fat_conv, ld_molt
decimal{2} ld_qta, ld_qta_padre
string ls_tipo_conv, ls_um, ls_up, ls_des
integer li_ret
s_ordine ls_vuoto, ls_ordine

ls_ordine=ls_vuoto
tab_1.tabpage_1.dw_comp.Reset()
	
	ll_id_art=dw_articolo.GetitemNumber(1,"id_articolo")
	SetNull(ld_qta)
	ls_ordine.cod_padre=dw_articolo.GetitemString(1,"articolo_cod")
	ls_ordine.riga=1
	
	ls_ordine.misura_num=dw_um.GetitemNumber(1,"dim_l")
	ls_ordine.u_misura=dw_um.Getitemstring(1,"um_vol_simbolo")
	
	ls_ordine.peso_num=dw_um.GetitemNumber(1,"peso_netto")
	ls_ordine.u_peso=dw_um.GetitemString(1,"um_peso_simbolo")
	
	ld_qta=10
	ls_ordine.quantita=ld_qta
	ls_ordine.id_padre=dw_articolo.GetitemNumber(1,"id_articolo")
	
	ls_ordine=f_esplodi_dw_fabbisogno(tv_1,0,true,0,date('1910/10/10'),date('3000/10/10'),0,"","",0,false,&
			tab_1.tabpage_1.dw_comp, ll_id_art,&
			ld_qta, ls_ordine,0,true)
	li_ret=UpperBound(ls_ordine.cod_figlio)
	if (li_ret=0) then
		
		
			ls_ordine.cod_figlio[1]=ls_ordine.cod_padre
			ld_qta_padre=ld_qta
			ls_des=dw_articolo.GetitemString(1,"articolo_des")
			ls_ordine.quantita=ld_qta_padre
			ls_ordine.id_figlio[1]=ls_ordine.id_padre
			ls_ordine.qta_figlio[1]=ld_qta_padre
			ls_ordine.des_figlio[1]=ls_des
			ls_ordine.u_misura_figlio[1]=ls_ordine.u_misura
			ls_ordine.u_peso_figlio[1]=ls_ordine.u_peso
			ll_row=tab_1.tabpage_1.dw_comp.InsertRow(0)
			tab_1.tabpage_1.dw_comp.SetRow(ll_row)
			tab_1.tabpage_1.dw_comp.setitem(ll_row,"quantita",ld_qta_padre)
			tab_1.tabpage_1.dw_comp.setitem(ll_row,"c_articolo_cod",ls_ordine.cod_padre)
			tab_1.tabpage_1.dw_comp.setitem(ll_row,"riga_documento_descrizione",ls_des)
		end if
		

	tab_1.tabpage_1.dw_comp.SetSort("rag_soc_1 A")
	tab_1.tabpage_1.dw_comp.Sort()
end event

type cb_calcola from commandbutton within w_orafo_fabbisogni_cx
int X=1115
int Y=650
int Width=358
int Height=90
int TabOrder=20
string Text="Calcola"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_id_art, ll_id_um, ll_id_um_rif, ll_riga
decimal{2} ld_qta_imp, ld_qta_base, ld_qta_finale
decimal{4} ld_fat_conv
s_ric_param is_ricpar
datastore ds_esplosioni


dw_articolo.accepttext()
if is_tipo_qta= "peso" or is_tipo_qta= "misura" then
	if not(dw_um.rowcount()>0) then 
		return
	end if
end if
choose case is_tipo_qta
		
		case "peso"
			ll_id_um=dw_um.getitemnumber(1,"id_um_peso")
			if IsNull(ll_id_um) then
				messagebox('Errore!',"Manca l'unità di misura per il peso dell'articolo")
				return
			end if
			ld_qta_base=dw_um.getitemdecimal(1,"peso_netto")
			if isnull(ld_qta_base)or(ld_qta_base<=0)  then
				messagebox('Errore!',"Manca il peso unitario dell'articolo")
				return
			end if
			ll_id_um_rif=dw_um.getitemnumber(1,"id_um_peso_rif")
			ld_qta_imp=dw_articolo.getitemdecimal(1,"qta_gr")
			ld_fat_conv=dw_um.getitemdecimal(1,"peso_conversione")
		case "misura"
			ll_id_um=dw_um.getitemnumber(1,"id_um_vol")
			if IsNull(ll_id_um) then
				messagebox('Errore!',"Manca l'unità di misura per il volume dell'articolo")
				return
			end if
			ld_qta_base=dw_um.getitemdecimal(1,"dim_l")
			if isnull(ld_qta_base)or(ld_qta_base<=0)  then
				messagebox('Errore!',"Manca la misura unitaria dell'articolo")
				return
			end if
			ll_id_um_rif=dw_um.getitemnumber(1,"id_um_vol_rif")		
			ld_qta_imp=dw_articolo.getitemdecimal(1,"qta_cm")
			ld_fat_conv=dw_um.getitemdecimal(1,"vol_conversione")
		case "pezzi"
		ld_qta_base=1
		ld_fat_conv=1
		ld_qta_imp=dw_articolo.getitemdecimal(1,"qta_pz")
	
	case else
		return
end choose

ll_id_art=dw_articolo.Getitemnumber(1,"id_articolo")


ds_esplosioni= create datastore
ds_esplosioni.dataobject="d_orafo_fabbisogno_righe_esplose_gd"
ds_esplosioni.settransobject(SQLCA)

ld_qta_finale=ld_qta_imp/(ld_qta_base*ld_fat_conv)
wf_calcola(ll_id_art,ld_qta_finale, tab_1.tabpage_1.dw_comp,ds_esplosioni)

ds_esplosioni.reset()
tab_1.tabpage_2.dw_prod.reset()

if (tab_1.selectedTab = 2) and  (isnull(ll_id_padre) or cambia_Padre)   then
	is_ricpar.s_filter_name = "articolo_codice"
	OpenWithParm(w_articolo_coddes_documento_sw,is_ricpar)
	is_ricpar=message.PowerObjectParm
	ls_codice=is_ricpar.s_main_value
	if upperbound(is_ricpar.s_id_seg_value)>0 then
		cambia_Padre=FALSE
		ll_id_padre=long(is_ricpar.s_id_seg_value[1])
	end if
	dw_um.retrieve(ll_id_padre)
end if
	

	
	wf_calcola(ll_id_padre,1, tab_1.tabpage_2.dw_prod,ds_esplosioni)
	tab_1.tabpage_2.dw_prod.reset()
	ll_riga = ds_esplosioni.find("riga_documento_id_articolo = "+string(ll_id_art),0,ds_esplosioni.rowcount())
	
	if ll_riga>0 then
		ld_qta_finale=ld_qta_finale / ds_esplosioni.getItemdecimal(ll_riga,"quantita")
		
		ll_riga=tab_1.tabpage_2.dw_prod.InsertRow(0)
		tab_1.tabpage_2.dw_prod.SetRow(ll_riga)
		tab_1.tabpage_2.dw_prod.setitem(ll_riga,"riga_documento_id_articolo",ll_id_padre)
		tab_1.tabpage_2.dw_prod.setitem(ll_riga,"quantita",ld_qta_finale)
		tab_1.tabpage_2.dw_prod.setitem(ll_riga,"c_articolo_cod",ls_codice)
	
		ld_qta_base=dw_um.getitemdecimal(1,"peso_netto")
		tab_1.tabpage_2.dw_prod.setitem(ll_riga,"riga_documento_peso_netto",ld_qta_base*ld_qta_finale)
	
		ld_qta_base=dw_um.getitemdecimal(1,"dim_l")
		tab_1.tabpage_2.dw_prod.setitem(ll_riga,"riga_documento_dim_l",ld_qta_base*ld_qta_finale)
	
	
else
	messagebox('','No padre!')
	end if

dw_um.retrieve(ll_id_art)



		
end event

type dw_articolo from datawindow within w_orafo_fabbisogni_cx
int X=51
int Y=29
int Width=2505
int Height=304
int TabOrder=10
string DataObject="d_orafo_fabbisogni_articolo_ff"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

event clicked;

s_ric_param is_ricpar
decimal titolo, titolo_prodotto

dw_articolo.accepttext()
choose case dwo.name
	case "articolo_cod_sw"
		is_ricpar.s_filter_value	= dw_articolo.GetItemString(1,"articolo_cod")
		is_ricpar.s_filter_name 	= "articolo_codice"
		OpenWithParm(w_articolo_coddes_documento_sw,is_ricpar)
		is_ricpar=message.PowerObjectParm
		SetItem(1,"articolo_cod",is_ricpar.s_main_value)
		if upperbound(is_ricpar.s_ausil_value)>0 then
			SetItem(1,"articolo_des",is_ricpar.s_ausil_value[1])
		
		
		
			
		
		titolo =  dec(is_ricpar.s_ausil_value[9])
		SELECT "orafo_titolo"."titolo" 
		into :titolo_prodotto
		FROM "orafo_titolo" 
		WHERE ( "orafo_titolo"."id_titolo" = :titolo) ;
				
		SetItem(1,"titolo_articolo",titolo_prodotto)
		
		
		end if
		if upperbound(is_ricpar.s_id_seg_value)>0 then
			SetItem(1,"id_articolo", long(is_ricpar.s_id_seg_value[1]))
			dw_um.retrieve(long(is_ricpar.s_id_seg_value[1]))

		end if

	case "articolo_des_sw"
		is_ricpar.s_filter_value = dw_articolo.GetItemString(1,"articolo_des")
		is_ricpar.s_filter_name = "articolo_descrizione"
		OpenWithParm(w_articolo_coddes_documento_sw,is_ricpar)
		is_ricpar=message.PowerObjectParm
		SetItem(1,"articolo_des",is_ricpar.s_main_value)
		if upperbound(is_ricpar.s_ausil_value)>0 then
			SetItem(1,"articolo_cod",is_ricpar.s_ausil_value[1])
		
		
		
			
		
		titolo =  dec(is_ricpar.s_ausil_value[9])
		SELECT "orafo_titolo"."titolo" 
		into :titolo_prodotto
		FROM "orafo_titolo" 
		WHERE ( "orafo_titolo"."id_titolo" = :titolo) ;
				
		SetItem(1,"titolo_articolo",titolo_prodotto)
		
		
		end if
		if upperbound(is_ricpar.s_id_seg_value)>0 then
			SetItem(1,"id_articolo", long(is_ricpar.s_id_seg_value[1]))	
			dw_um.retrieve(long(is_ricpar.s_id_seg_value[1]))
		end if

end choose
end event

event itemchanged;

string ls_tipo
integer li_ret
integer dummy 
s_ric_param is_ricpar
setNull(dummy)

if is_tipo_qta="" then
	calcola_fabbisogno()
end if
choose case dwo.name
	case "qta_gr"
		ls_tipo="peso"
		if (is_tipo_qta<>"peso")and(is_tipo_qta<>"") then
			li_ret=1 
			if li_ret=1 then 
			is_tipo_qta="peso"
			setitem(1,"qta_cm",dummy)
			setitem(1,"qta_pz",dummy)
			calcola_fabbisogno()
			else
			post setitem(1,"qta_gr",dummy)
			
			end if
		
		else 
			is_tipo_qta="peso"
			
			calcola_fabbisogno()
		end if
		
	case "qta_cm"
		ls_tipo="misura"
		if (is_tipo_qta<>"misura")and(is_tipo_qta<>"") then
			li_ret= 1 
			if li_ret=1 then 
				is_tipo_qta="misura"
			setitem(1,"qta_gr",dummy)
			setitem(1,"qta_pz",dummy)
			calcola_fabbisogno()
			else
			post 	setitem(1,"qta_cm",dummy)
				
			end if
		else 
			is_tipo_qta="misura"
			calcola_fabbisogno()
		end if
	case "qta_pz"
		ls_tipo="pezzi"
		if (is_tipo_qta<>"pezzi")and(is_tipo_qta<>"") then
			li_ret= 1 
			if li_ret=1 then 
				is_tipo_qta="pezzi"
			setitem(1,"qta_cm",dummy)
			setitem(1,"qta_gr",dummy)
			calcola_fabbisogno()
			else
			post setitem(1,"qta_pz",dummy)
				
			end if
		else 
			is_tipo_qta="pezzi"
			calcola_fabbisogno()
		end if
		
		case "articolo_cod"
		string codice_articolo, descrizione
		long id_articolo, id_titolo, titolo_prodotto
		
		codice_articolo = data
		
		select id_articolo, descrizione , id_titolo
		into :id_articolo, :descrizione, :id_titolo
		from articolo
		where codice = :codice_articolo
		;
		
		if sqlca.SQLcode = 0 then
			
		
		
		
			
		
		
		SELECT "orafo_titolo"."titolo" 
		into :titolo_prodotto
		FROM "orafo_titolo" 
		WHERE ( "orafo_titolo"."id_titolo" = :id_titolo) ;
				
		SetItem(1,"titolo_articolo",titolo_prodotto)
		
		
			SetItem(1,"articolo_des", descrizione)
			SetItem(1,"id_articolo", id_articolo)	
			calcola_fabbisogno()
			dw_um.retrieve(id_articolo)
		else
			
			
			
		
		is_ricpar.s_filter_value	= data
		is_ricpar.s_filter_name 	= "articolo_codice"
		OpenWithParm(w_articolo_coddes_documento_sw,is_ricpar)
		is_ricpar=message.PowerObjectParm
		POST SetItem(1,"articolo_cod",is_ricpar.s_main_value)
		if upperbound(is_ricpar.s_ausil_value)>0 then
		 	SetItem(1,"articolo_des",is_ricpar.s_ausil_value[1])
		end if
		if upperbound(is_ricpar.s_id_seg_value)>0 then
		 	SetItem(1,"id_articolo", long(is_ricpar.s_id_seg_value[1]))
			 dw_um.retrieve(long(is_ricpar.s_id_seg_value[1]))
		end if
		calcola_fabbisogno()
		end if
		
		
		case "articolo_des"
		
		is_ricpar.s_filter_value = data
		is_ricpar.s_filter_name = "articolo_descrizione"
		OpenWithParm(w_articolo_coddes_documento_sw,is_ricpar)
		is_ricpar=message.PowerObjectParm
		POST SetItem(1,"articolo_des",is_ricpar.s_main_value)
		if upperbound(is_ricpar.s_ausil_value)>0 then
			SetItem(1,"articolo_cod",is_ricpar.s_ausil_value[1])
		end if
		if upperbound(is_ricpar.s_id_seg_value)>0 then
			 SetItem(1,"id_articolo", long(is_ricpar.s_id_seg_value[1]))	
			dw_um.retrieve(long(is_ricpar.s_id_seg_value[1]))
		end if
		calcola_fabbisogno()
		
end choose

end event

type tab_1 from tab within w_orafo_fabbisogni_cx
int X=37
int Y=669
int Width=2523
int Height=1030
int TabOrder=80
boolean RaggedRight=true
int SelectedTab=1
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

type tabpage_1 from userobject within tab_1
event create ( )
event destroy ( )
int X=15
int Y=90
int Width=2494
int Height=928
long BackColor=79741120
string Text="Componenti"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
st_1 st_1
dw_comp dw_comp
end type

on tabpage_1.create
this.st_1=create st_1
this.dw_comp=create dw_comp
this.Control[]={this.st_1,&
this.dw_comp}
end on

on tabpage_1.destroy
destroy(this.st_1)
destroy(this.dw_comp)
end on

type st_1 from statictext within tabpage_1
int X=18
int Y=16
int Width=962
int Height=74
boolean Enabled=false
string Text="Componenti del'articolo"
boolean FocusRectangle=false
long BackColor=67108864
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_comp from datawindow within tabpage_1
int X=22
int Y=93
int Width=2439
int Height=816
int TabOrder=21
string DataObject="d_orafo_fabbisogno_righe_esplose_gd"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

type tabpage_2 from userobject within tab_1
int X=15
int Y=90
int Width=2494
int Height=928
long BackColor=79741120
string Text="Prodotti finiti"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
cb_cambia_padre cb_cambia_padre
dw_prod dw_prod
st_2 st_2
end type

on tabpage_2.create
this.cb_cambia_padre=create cb_cambia_padre
this.dw_prod=create dw_prod
this.st_2=create st_2
this.Control[]={this.cb_cambia_padre,&
this.dw_prod,&
this.st_2}
end on

on tabpage_2.destroy
destroy(this.cb_cambia_padre)
destroy(this.dw_prod)
destroy(this.st_2)
end on

type cb_cambia_padre from commandbutton within tabpage_2
int X=2044
int Y=26
int Width=377
int Height=96
int TabOrder=60
string Text="Cambia padre"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;cambia_Padre=TRUE
cb_calcola.triggerevent(clicked!)
end event

type dw_prod from datawindow within tabpage_2
int X=22
int Y=150
int Width=2428
int Height=765
int TabOrder=22
string DragIcon="afo_base\orafo_ordini.pbl"
string DataObject="d_orafo_fabbisogno_righe_esplose_gd"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

type st_2 from statictext within tabpage_2
int X=18
int Y=16
int Width=2180
int Height=77
boolean Enabled=false
string Text="Quantità di articolo "
boolean FocusRectangle=false
long BackColor=67108864
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type tv_1 from treeview within w_orafo_fabbisogni_cx
int X=2608
int Y=122
int Width=494
int Height=365
int TabOrder=60
boolean Visible=false
boolean BringToTop=true
string PictureName[]={"Custom039!"}
long PictureMaskColor=536870912
long StatePictureMaskColor=536870912
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_um from datawindow within w_orafo_fabbisogni_cx
int X=2695
int Y=915
int Width=962
int Height=250
int TabOrder=30
boolean Visible=false
boolean BringToTop=true
string DataObject="d_orafo_fabbisogni_um_articolo_gd"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean LiveScroll=true
end type

type st_8 from statictext within w_orafo_fabbisogni_cx
int X=746
int Y=544
int Width=827
int Height=64
boolean Enabled=false
string Text="Metallo necessario per un' altra unità:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_orafo_fabbisogni_cx
int X=48
int Y=365
int Width=2509
int Height=256
int TabOrder=70
string Text="Valori stimati"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

