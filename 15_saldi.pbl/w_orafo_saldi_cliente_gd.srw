forward
global type w_orafo_saldi_cliente_gd from Window
end type
type tab_1 from tab within w_orafo_saldi_cliente_gd
end type
type tabpage_1 from userobject within tab_1
end type
type dw_single from datawindow within tabpage_1
end type
type tabpage_2 from userobject within tab_1
end type
type dw_2 from datawindow within tabpage_2
end type
type cb_1 from commandbutton within w_orafo_saldi_cliente_gd
end type
type tabpage_1 from userobject within tab_1
dw_single dw_single
end type
type tabpage_2 from userobject within tab_1
dw_2 dw_2
end type
type tab_1 from tab within w_orafo_saldi_cliente_gd
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
end forward

global type w_orafo_saldi_cliente_gd from Window
int X=833
int Y=361
int Width=2053
int Height=1381
boolean TitleBar=true
string Title="Saldi"
long BackColor=79741120
boolean ControlMenu=true
WindowType WindowType=response!
event ue_post_open ( )
tab_1 tab_1
cb_1 cb_1
end type
global w_orafo_saldi_cliente_gd w_orafo_saldi_cliente_gd

forward prototypes
public subroutine wf_carica_saldi ()
end prototypes

event ue_post_open;
wf_carica_saldi()
end event

public subroutine wf_carica_saldi ();
decimal{4} ld_fino_entrata, ld_fino_uscita, ld_fino_saldo
integer i, a
string ls_campo, ls_cod_metallo, ls_cod_metallo_old

for a = 1 to 4
	if a= 1 then ls_campo="fino_"
	if a =2 then ls_campo="calo_"
	if a =3 then ls_campo="fino_calo_"
	if a =4 then ls_campo="lire_"
	for i= 1 to tab_1.tabpage_1.dw_single.rowcount()
			ld_fino_entrata=tab_1.tabpage_1.dw_single.getitemdecimal(i, ls_campo+"entrata")
			ld_fino_uscita=tab_1.tabpage_1.dw_single.getitemdecimal(i, ls_campo+"uscita")
			if isnull(ld_fino_entrata) then ld_fino_entrata=0
			if isnull(ld_fino_uscita) then ld_fino_uscita=0
			if i= 1 then 
				tab_1.tabpage_1.dw_single.setitem(i, ls_campo+"saldo", ld_fino_entrata - ld_fino_uscita)
			else
				ls_cod_metallo_old=tab_1.tabpage_1.dw_single.getitemstring(i - 1, "orafo_metallo_codice")
				
				ls_cod_metallo=tab_1.tabpage_1.dw_single.getitemstring(i, "orafo_metallo_codice")
				if ls_cod_metallo = ls_cod_metallo_old and not isnull(ls_cod_metallo_old) then
					ld_fino_saldo=tab_1.tabpage_1.dw_single.getitemdecimal(i - 1, ls_campo+"saldo")
				else
					ld_fino_saldo=0
				end if
					ld_fino_saldo= ld_fino_saldo+ld_fino_entrata - ld_fino_uscita
					tab_1.tabpage_1.dw_single.setitem(i, ls_campo+"saldo", ld_fino_saldo)
			end if
		
	next
next
end subroutine

on w_orafo_saldi_cliente_gd.create
this.tab_1=create tab_1
this.cb_1=create cb_1
this.Control[]={ this.tab_1,&
this.cb_1}
end on

on w_orafo_saldi_cliente_gd.destroy
destroy(this.tab_1)
destroy(this.cb_1)
end on

event open;Long ll_ID_sog_commerciale
String ls_cod_sog_commerciale, ls_rag_soc_1



ll_ID_sog_commerciale = Message.DoubleParm

SELECT s.codice, a.rag_soc_1
INTO   :ls_cod_sog_commerciale, :ls_rag_soc_1
FROM   sog_commerciale s, anagrafica a
WHERE  s.id_sog_commerciale = :ll_ID_sog_commerciale
AND    a.id_anagrafica = s.id_anagrafica;

CHOOSE CASE SQLca.SQLcode
	CASE 0
		w_orafo_saldi_cliente_gd.Title = "Saldi di " + ls_cod_sog_commerciale + ' - ' + ls_rag_soc_1 

		
		tab_1.tabpage_1.dw_single.settransobject(sqlca)
		tab_1.tabpage_1.dw_single.Retrieve(ll_id_sog_commerciale)
	
		tab_1.tabpage_2.dw_2.settransobject(sqlca)
		tab_1.tabpage_2.dw_2.Retrieve(ll_id_sog_commerciale)
	CASE 100, -1
		Return
END CHOOSE
 post event ue_post_open()
end event

type tab_1 from tab within w_orafo_saldi_cliente_gd
event create ( )
event destroy ( )
int X=19
int Y=17
int Width=1994
int Height=1261
int TabOrder=10
boolean RaggedRight=true
int SelectedTab=1
long BackColor=79741120
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
this.Control[]={ this.tabpage_1,&
this.tabpage_2}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

type tabpage_1 from userobject within tab_1
event create ( )
event destroy ( )
int X=19
int Y=105
int Width=1957
int Height=1141
long BackColor=79741120
string Text="Saldo soggetto"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_single dw_single
end type

on tabpage_1.create
this.dw_single=create dw_single
this.Control[]={ this.dw_single}
end on

on tabpage_1.destroy
destroy(this.dw_single)
end on

type dw_single from datawindow within tabpage_1
int X=5
int Y=17
int Width=1925
int Height=1101
int TabOrder=31
string DataObject="d_orafo_saldi_cliente_righe_gran_tb2"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

type tabpage_2 from userobject within tab_1
event create ( )
event destroy ( )
int X=19
int Y=105
int Width=1957
int Height=1141
long BackColor=79741120
string Text="Totali per Tipo Causale"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_2 dw_2
end type

on tabpage_2.create
this.dw_2=create dw_2
this.Control[]={ this.dw_2}
end on

on tabpage_2.destroy
destroy(this.dw_2)
end on

type dw_2 from datawindow within tabpage_2
int X=28
int Y=37
int Width=1921
int Height=1061
int TabOrder=11
string DataObject="d_orafo_saldi_cliente_tipo_causale_tb"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event scrollhorizontal;
end event

type cb_1 from commandbutton within w_orafo_saldi_cliente_gd
int X=503
int Y=1101
int Width=247
int Height=109
int TabOrder=20
string Text="none"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long handle, i
run("c:\programmi\microsoft office\office\excel.exe  c:\documenti\categorie.xls", maximized!)
handle=openchannel("excel.exe", "categorie.xls")
for i = 1 to 5
	setremote("r"+string(i)+"c1", "ciao", "excel", "categorie.xls")
	setremote("r"+string(i)+"c2", "Marco", "excel", "categorie.xls")
	
	string ls_ProfData
	
	next
closechannel(handle)

end event

