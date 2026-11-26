forward
global type w_unita_confezione_ff from w_p_data
end type
type dw_unita_confezione_ff from u_dw_master_main within tabpage_1
end type
type dw_scorte_gd from u_dw_master_main within tabpage_1
end type
type st_scorte from statictext within tabpage_1
end type
type cb_1 from commandbutton within tabpage_1
end type
type cb_2 from commandbutton within tabpage_1
end type
type dw_unita_confezione_ff from u_dw_master_main within tabpage_1
end type
type dw_scorte_gd from u_dw_master_main within tabpage_1
end type
type st_scorte from statictext within tabpage_1
end type
type cb_1 from commandbutton within tabpage_1
end type
type cb_2 from commandbutton within tabpage_1
end type
type tabpage_2 from userobject within tab_1
end type
type dw_cod_barre_gd from u_dw_master_main within tabpage_2
end type
type tabpage_3 from userobject within tab_1
end type
type dw_1 from u_dw_master_main within tabpage_3
end type
type cb_3 from commandbutton within tabpage_3
end type
type tabpage_2 from userobject within tab_1
dw_cod_barre_gd dw_cod_barre_gd
end type
type tabpage_3 from userobject within tab_1
dw_1 dw_1
cb_3 cb_3
end type
end forward

global type w_unita_confezione_ff from w_p_data
int Width=2665
int Height=2024
boolean TitleBar=true
string Title="Unità Confezione"
end type
global w_unita_confezione_ff w_unita_confezione_ff

forward prototypes
public function integer wf_retrieve_magazzino ()
public subroutine wf_set_scorte ()
end prototypes

public function integer wf_retrieve_magazzino ();
long		ll_row_number,ll_i,ll_id_magazzino
string	ls_codice_magazzino

ll_row_number	= this.tab_1.tabpage_1.dw_scorte_gd.RowCount()
if ll_row_number > 0 then
	for ll_i = 1 to ll_row_number
		ll_id_magazzino = this.tab_1.tabpage_1.dw_scorte_gd.GetItemNumber( ll_i,"id_magazzino" )
		
		if not isNull(ll_id_magazzino) then
			select "magazzino"."codice"
				into :ls_codice_magazzino
				from "dba"."magazzino"
				where "magazzino"."id_magazzino" = :ll_id_magazzino
				using SQLCA;
				
			if SQLCA.SQLCode = 0 then
				this.tab_1.tabpage_1.dw_scorte_gd.SetItem( ll_i,"c_magazzino",ls_codice_magazzino )
			else
				if SQLCA.SQLCode = -1 then
					MessageBox( "Database error","Error : " + SQLCA.SQLErrText,StopSign! )
				end if
			end if		
		end if		
		
	next
end if


return 0
end function

public subroutine wf_set_scorte ();

long		ll_row
string	ls_base


ll_row = tab_1.tabpage_1.dw_unita_confezione_ff.getRow()
ls_base = tab_1.tabpage_1.dw_unita_confezione_ff.getItemString(ll_row,"unita_base")
if ls_base = "S" then
	tab_1.tabpage_1.st_scorte.visible		= true
	tab_1.tabpage_1.dw_scorte_gd.visible = true
	tab_1.tabpage_1.dw_scorte_gd.enabled = true
	this.height = 1753
else
	tab_1.tabpage_1.st_scorte.visible		= false
	tab_1.tabpage_1.dw_scorte_gd.visible = false
	tab_1.tabpage_1.dw_scorte_gd.enabled = false
	tab_1.tabpage_2.dw_cod_barre_gd.height=830
	tab_1.height=1105
	
	this.height = 1360
	
end if
end subroutine

on w_unita_confezione_ff.create
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
end on

on w_unita_confezione_ff.destroy
call super::destroy
end on

event open;call super::open;datawindowChild ldwo_obj_peso, ldwo_obj_volume,ldwo_obj_peso_des, ldwo_obj_volume_des

idw_master = tab_1.tabpage_1.dw_unita_confezione_ff
idw_master.is_list = Message.PowerObjectParm

idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_sql_ident[1] = "unita_confezione.id_unita_confezione"


idw_master.GetChild("id_unita_mis_peso",ldwo_obj_peso)
idw_master.GetChild("id_unita_mis_volume",ldwo_obj_volume)
idw_master.GetChild("id_unita_mis_peso_des",ldwo_obj_peso_des)
idw_master.GetChild("id_unita_mis_volume_des",ldwo_obj_volume_des)
ldwo_obj_peso.SetFilter("tipo = 'P'")
ldwo_obj_volume.SetFilter("tipo = 'V'")
ldwo_obj_peso_des.SetFilter("tipo = 'P'")
ldwo_obj_volume_des.SetFilter("tipo = 'V'")  





end event

event ue_post_open;call super::ue_post_open;long ll_row, ll_id_peso, ll_id_volume

wf_set_scorte()

ll_row = tab_1.tabpage_1.dw_unita_confezione_ff.getrow()

ll_id_peso = tab_1.tabpage_1.dw_unita_confezione_ff.getitemnumber(ll_row,"id_unita_mis_peso_des")
ll_id_volume = tab_1.tabpage_1.dw_unita_confezione_ff.getitemnumber(ll_row,"id_unita_mis_volume_des")

if isnull(ll_id_peso) or ll_id_peso <= 0 then
	SELECT 	"par_sistema"."id_unita_mis_peso"
		INTO	:ll_id_peso
	FROM		"par_sistema";
end if

if isnull(ll_id_volume) or ll_id_volume <= 0 then
	SELECT 	"par_sistema"."id_unita_mis_volume"
		INTO	:ll_id_volume
	FROM		"par_sistema";
end if

tab_1.tabpage_1.dw_unita_confezione_ff.setitem(ll_row,"id_unita_mis_peso_des",ll_id_peso)
tab_1.tabpage_1.dw_unita_confezione_ff.setitem(ll_row,"id_unita_mis_volume_des",ll_id_volume)
end event

event resize;call super::resize;
end event

type p_crescente from w_p_data`p_crescente within w_unita_confezione_ff
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_unita_confezione_ff
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_unita_confezione_ff
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_unita_confezione_ff
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_unita_confezione_ff
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_unita_confezione_ff
int X=1783
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_unita_confezione_ff
int X=2080
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_unita_confezione_ff
int X=2377
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_unita_confezione_ff
int Y=168
int Width=2606
int Height=1768
boolean BringToTop=true
long BackColor=79741120
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type

on tab_1.create
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_2
this.Control[iCurrent+2]=this.tabpage_3
end on

on tab_1.destroy
call super::destroy
destroy(this.tabpage_2)
destroy(this.tabpage_3)
end on

type tabpage_1 from w_p_data`tabpage_1 within tab_1
event create ( )
event destroy ( )
int X=18
int Y=104
int Width=2569
int Height=1648
long BackColor=79741120
string Text="Unità confezione"
long TabBackColor=79741120
dw_unita_confezione_ff dw_unita_confezione_ff
dw_scorte_gd dw_scorte_gd
st_scorte st_scorte
cb_1 cb_1
cb_2 cb_2
end type

on tabpage_1.create
this.dw_unita_confezione_ff=create dw_unita_confezione_ff
this.dw_scorte_gd=create dw_scorte_gd
this.st_scorte=create st_scorte
this.cb_1=create cb_1
this.cb_2=create cb_2
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_unita_confezione_ff
this.Control[iCurrent+2]=this.dw_scorte_gd
this.Control[iCurrent+3]=this.st_scorte
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.cb_2
end on

on tabpage_1.destroy
call super::destroy
destroy(this.dw_unita_confezione_ff)
destroy(this.dw_scorte_gd)
destroy(this.st_scorte)
destroy(this.cb_1)
destroy(this.cb_2)
end on

type cb_ricerca from w_p_data`cb_ricerca within w_unita_confezione_ff
int X=1463
boolean BringToTop=true
end type

event cb_ricerca::clicked;call super::clicked;
end event

type dw_unita_confezione_ff from u_dw_master_main within tabpage_1
event itemchanged pbm_dwnitemchange
event ue_init pbm_custom01
event ue_set_search ( string as_nomecol,  string as_valcol )
int X=5
int Y=16
int Width=2546
int Height=968
int TabOrder=1
string DataObject="d_unita_confezione_ff"
end type

event itemchanged;string		ls_nomecol
long			ll_row


ls_nomecol = dwo.name
ll_row = getrow()

choose case ls_nomecol
	case "unita_base"
		post function wf_set_scorte()
end choose

CHOOSE CASE dwo.name 
	CASE "peso_netto", "dim_l", "dim_h"
		decimal ld_peso_netto, ld_lunghezza, ld_larghezza
		integer  li_app
		long	  ll_id_articolo
		
		if (dwo.name = "peso_netto") then 
			ld_peso_netto = dec(data)
		else 
			ld_peso_netto = getitemnumber(ll_row, "peso_netto")
		end if
			
		if (dwo.name = "dim_l") then 
			ld_lunghezza = dec(data)
		else 
			ld_lunghezza = getitemnumber(ll_row, "dim_l")
		end if
			
		if (dwo.name = "dim_h") then 
			ld_larghezza = dec(data)
		else 
			ld_larghezza = getitemnumber(ll_row, "dim_h")
		end if
		
		if (ld_peso_netto > 0) and (ld_lunghezza > 0) and (ld_larghezza > 0) then
			SELECT 1
			INTO   :li_app
			FROM   azienda
			WHERE  id_azienda = 1
			AND	 UCASE(codice) = 'TIBERGRA'
			;
			
			if (SQLCA.SQLCODE = 0) then
				ll_id_articolo = dw_unita_confezione_ff.object.id_articolo[ll_row]
				SELECT 1
				INTO	 :li_app
				FROM   articolo a, tiber_par_sistema p
				WHERE	 a.id_articolo = :ll_id_articolo
				AND	 a.id_cat_merceologica = p.id_cat_merc_carta
				;
				
				if (SQLCA.SQLCODE = 0) then
					ld_peso_netto = (ld_lunghezza * ld_larghezza / 10000 * ld_peso_netto)
					post setitem(ll_row, "peso_netto", ld_peso_netto)
				end if
			end if
		end if
END CHOOSE
end event

event ue_init;call super::ue_init;is_title = "Unità Confezione"
is_list.s_identifica[1] = "id_unita_confezione"
iudw_children[1] = tab_1.tabpage_1.dw_scorte_gd
iudw_children[2]= tab_1.tabpage_2.dw_cod_barre_gd
iudw_children[3]= tab_1.tabpage_3.dw_1
end event

event ue_set_search;call super::ue_set_search;
CHOOSE CASE as_nomecol
		
	CASE "id_unita_misura"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_unita_misura_gd"
		is_ricpar.s_titolo_finestra = "Unità di Misura"
		is_ricpar.s_ausil_value[1] = "id_unita_misura_des"
		is_ricpar.i_width = 2963
		is_ricpar.i_height = 869
	CASE "id_unita_misura_des"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_unita_misura_gd"
		is_ricpar.s_titolo_finestra = "Unità di Misura"
		is_ricpar.s_ausil_value[1] = "id_unita_misura"
		is_ricpar.i_width = 2963
		is_ricpar.i_height = 869
		
	CASE "id_unita_mis_peso"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_unita_misura_gd"
		is_ricpar.s_titolo_finestra = "Unità di Misura"
		is_ricpar.s_ausil_value[1] = "id_unita_mis_peso_des"
		is_ricpar.i_width = 2963
		is_ricpar.i_height = 869
	CASE "id_unita_mis_peso_des"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_unita_misura_gd"
		is_ricpar.s_titolo_finestra = "Unità di Misura"
		is_ricpar.s_ausil_value[1] = "id_unita_mis_peso"
		is_ricpar.i_width = 2963
		is_ricpar.i_height = 869
		
	CASE "id_unita_mis_volume"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_unita_misura_gd"
		is_ricpar.s_titolo_finestra = "Unità di Misura"
		is_ricpar.s_ausil_value[1] = "id_unita_mis_volume_des"
		is_ricpar.i_width = 2963
		is_ricpar.i_height = 869
	CASE "id_unita_mis_volume_des"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_unita_misura_gd"
		is_ricpar.s_titolo_finestra = "Unità di Misura"
		is_ricpar.s_ausil_value[1] = "id_unita_mis_volume"
		is_ricpar.i_width = 2963
		is_ricpar.i_height = 869
		
END CHOOSE
end event

type dw_scorte_gd from u_dw_master_main within tabpage_1
event retrieveend pbm_dwnretrieveend
event ue_init pbm_custom01
event ue_set_search ( string as_nomecol,  string as_valcol )
event ue_use_search ( string as_nomecol )
int X=5
int Y=936
int Width=2546
int Height=392
int TabOrder=3
boolean Visible=false
boolean Enabled=false
string DataObject="d_scorta_gd"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event retrieveend;call super::retrieveend;
wf_retrieve_magazzino()
return 0
end event

event ue_init;call super::ue_init;is_list.s_identifica[1] = "id_unita_confezione"

end event

event ue_set_search;call super::ue_set_search;choose case as_nomecol
	case "c_magazzino"
		is_search_window = "w_magazzino_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice" 
end choose

end event

event ue_use_search;call super::ue_use_search;choose case as_nomecol
	case "c_magazzino"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_magazzino", is_ricpar.s_id_seg_value[1])
end choose
end event

type st_scorte from statictext within tabpage_1
int X=5
int Y=992
int Width=2546
int Height=80
boolean Enabled=false
boolean BringToTop=true
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
string Text=" Scorte"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=1090519039
long BackColor=276856960
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_1 from commandbutton within tabpage_1
int X=1074
int Y=664
int Width=293
int Height=80
int TabOrder=21
boolean BringToTop=true
string Text="Peso_netto"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;boolean lb_controllo
string ls_prova
char lc_rit[255]
long	ll_row
lc_rit=space(255)
ls_prova='Mettler 16'
lb_controllo=GetWeight(ls_prova,lc_rit)
ll_row = tab_1.tabpage_1.dw_unita_confezione_ff.getrow()
tab_1.tabpage_1.dw_unita_confezione_ff.setitem(ll_row,"peso_netto",dec(string(lc_rit)))

end event

type cb_2 from commandbutton within tabpage_1
int X=1824
int Y=664
int Width=297
int Height=80
int TabOrder=22
boolean BringToTop=true
string Text="Peso Lordo"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;boolean lb_controllo
string ls_prova
char lc_rit[255]
long	ll_row
lc_rit=space(255)
ls_prova='Mettler 16'
lb_controllo=GetWeight(ls_prova,lc_rit)
ll_row = tab_1.tabpage_1.dw_unita_confezione_ff.getrow()
tab_1.tabpage_1.dw_unita_confezione_ff.setitem(ll_row,"peso_lordo",dec(string(lc_rit)))

end event

type tabpage_2 from userobject within tab_1
int X=18
int Y=104
int Width=2569
int Height=1648
long BackColor=79741120
string Text="Codice a Barre"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_cod_barre_gd dw_cod_barre_gd
end type

on tabpage_2.create
this.dw_cod_barre_gd=create dw_cod_barre_gd
this.Control[]={this.dw_cod_barre_gd}
end on

on tabpage_2.destroy
destroy(this.dw_cod_barre_gd)
end on

type dw_cod_barre_gd from u_dw_master_main within tabpage_2
event ue_init pbm_custom01
event ue_set_search ( string as_nomecol,  string as_valcol )
int X=27
int Y=36
int Width=2523
int Height=1272
int TabOrder=3
string DataObject="d_insuc_cod_barre_gd"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event ue_init;call super::ue_init;is_title 					= "Codici a barre"
is_list.s_identifica[1] = "id_unita_confezione"
end event

event ue_set_search;call super::ue_set_search;
CHOOSE CASE as_nomecol
		
	CASE "id_tipo_cod_barre"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_tipo_cod_barre_gd"
		is_ricpar.s_titolo_finestra = "Tipi Codici a Barre"
		is_ricpar.i_width = 2295
		is_ricpar.i_height = 873

END CHOOSE
end event

event itemchanged;long 		ll_id_unita_confezione
String	ls_cod_art, ls_cod_uc	
String	ls_cod_barre, ls_check_digit, ls_tipo, ls_alfanumerico, ls_codice
Long	  	ll_id_tipo_cod_barre
Integer	li_ret, li_lunghezza, li_check_digit
		
u_cod_barre l_u_cod_barre

choose case dwo.name
	case "codice"
		
		
	
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
		
	case "gen_automatica"
		ls_cod_barre = This.Object.codice[row]
		if data = 'S' and isnull(ls_cod_barre) then
		
			ll_id_tipo_cod_barre = This.Object.id_tipo_cod_barre[row]
			ll_id_unita_confezione = This.Object.id_unita_confezione[row]
	
			If isnull(ll_id_tipo_cod_barre) then
				messagebox("Generazione automatica del codice a barre", "Specificare la tipologia del codice a barre che deve essere generato")
				return
			end if

			l_u_cod_barre = create u_cod_barre	
	
			ls_cod_barre = l_u_cod_barre.uf_gen_automatica(ll_id_tipo_cod_barre)
		
			if ls_cod_barre = '-1' then 
				SELECT a.codice, u.codice
				INTO	 :ls_cod_art, :ls_cod_uc
				FROM	 articolo a, unita_confezione u
				WHERE  u.id_unita_confezione = :ll_id_unita_confezione
				AND	 a.id_articolo = u.id_articolo
				;
				if SQLCA.SQLCODE = -1 then messagebox("Generazione automatica del codice a barre", SQLCA.SQLERRTEXT)
				
			else		
				This.Object.codice[Row] = ls_cod_barre
			end if
	End If		
end choose
end event

type tabpage_3 from userobject within tab_1
event create ( )
event destroy ( )
int X=18
int Y=104
int Width=2569
int Height=1648
long BackColor=79741120
string Text="Modelli"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_1 dw_1
cb_3 cb_3
end type

on tabpage_3.create
this.dw_1=create dw_1
this.cb_3=create cb_3
this.Control[]={this.dw_1,&
this.cb_3}
end on

on tabpage_3.destroy
destroy(this.dw_1)
destroy(this.cb_3)
end on

type dw_1 from u_dw_master_main within tabpage_3
int X=27
int Y=16
int Width=2519
int Height=700
int TabOrder=3
string DataObject="d_ricerca_unita_conf_base"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event losefocus;
end event

event rowfocuschanged;dw_1.selectrow(0,false)
dw_1.selectrow(currentrow,true)
dw_1.setrow(currentrow)

end event

type cb_3 from commandbutton within tabpage_3
int X=73
int Y=760
int Width=247
int Height=108
int TabOrder=22
boolean BringToTop=true
string Text="Riporta"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

long ll_row, ll_id_art
ll_row=dw_1.getrow()

ll_id_art=tab_1.tabpage_1.dw_unita_confezione_ff.getitemnumber(1, "id_articolo")
tab_1.tabpage_1.dw_unita_confezione_ff.reset()


ll_row=dw_1.rowscopy(ll_row, ll_row, primary!,tab_1.tabpage_1.dw_unita_confezione_ff,1, primary!)
if ll_row<>1 then messagebox("Errore!", "Riga non copiata!")
tab_1.tabpage_1.dw_unita_confezione_ff.setitem(1, "unita_base", 'N')
tab_1.tabpage_1.dw_unita_confezione_ff.setitem(1, "unita_documenti", 'N')
tab_1.tabpage_1.dw_unita_confezione_ff.setitem(1, "unita_prezzo", 'N')
tab_1.tabpage_1.dw_unita_confezione_ff.setitem(1, "unita_produzione", 'N')
tab_1.tabpage_1.dw_unita_confezione_ff.setitem(1, "id_articolo", ll_id_art)

setnull(ll_row)
tab_1.tabpage_1.dw_unita_confezione_ff.setitem(1, "id_unita_confezione", ll_row)

long ll_id_uc

tab_1.tabpage_1.dw_unita_confezione_ff.update()

select max(id_unita_confezione)
into :ll_id_uc
from unita_confezione;

idw_master.is_list.l_identifica[1]=ll_id_uc
end event

