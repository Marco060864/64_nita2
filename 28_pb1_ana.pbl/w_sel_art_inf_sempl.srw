forward
global type w_sel_art_inf_sempl from w_wiz_main
end type
type dw_1 from u_dw_ext_main within w_sel_art_inf_sempl
end type
type cb_1 from commandbutton within w_sel_art_inf_sempl
end type
type dw_dist from datawindow within w_sel_art_inf_sempl
end type
end forward

global type w_sel_art_inf_sempl from w_wiz_main
int Width=3241
int Height=1076
boolean TitleBar=true
string Title="Selezione Articolo"
long BackColor=80133307
dw_1 dw_1
cb_1 cb_1
dw_dist dw_dist
end type
global w_sel_art_inf_sempl w_sel_art_inf_sempl

type variables
string ls_stringa, ls_tipo
end variables

on w_sel_art_inf_sempl.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_1=create cb_1
this.dw_dist=create dw_dist
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.dw_dist
end on

on w_sel_art_inf_sempl.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.dw_dist)
end on

event open;call super::open;long ll_id_sog_com, ll_id_cat_com, ll_ret, ll_id_dist, i, ll_id_art, ll_row
string ls_da_art, ls_a_art, filter, ls_sn_dist, ls_cod, ls_des, ls_descat, ls_rag

s_ric_art str

dw_1.settransobject(sqlca)
dw_dist.settransobject(sqlca)
dw_dist.reset()

str = message.powerobjectparm

ls_da_art = str.s_da_art 
ls_a_art = str.s_a_art 
ll_id_sog_com = str.s_id_sog_com
ll_id_cat_com = str.s_id_cat_com  
ls_stringa = str.stringa
ls_tipo = str.tipo_str
ls_sn_dist = str.sn_dist

if ls_sn_dist = 'S' then
	select id_distinta
	into :ll_id_dist
	from distinta 
	where codice = :ls_da_art;
	
	dw_dist.retrieve(ll_id_dist)
	for i=1 to dw_dist.rowcount()
		 ll_id_art = dw_dist.getitemnumber(i,"id_articolo")
		 
		 select codice, descrizione, id_cat_com_articolo, id_sog_commerciale
		 into :ls_cod, :ls_des, :ll_id_cat_com, :ll_id_sog_com
		 from articolo 
		 where id_articolo = :ll_id_art;

		 select descrizione
		 into :ls_descat
		 from cat_com_articolo
		 where id_cat_com_articolo = :ll_id_cat_com;
		 
		 select rag_soc_1
		 into :ls_rag
		 from sog_commerciale_gen
		 where id_sog_commerciale = :ll_id_sog_com;

		 if not isnull(ll_id_art) then
			 ll_row = dw_1.insertrow(0)
			 dw_1.setitem(ll_row,"id_articolo",ll_id_art)
			 dw_1.setitem(ll_row,"articolo_codice",ls_cod)
			 dw_1.setitem(ll_row,"articolo_descrizione",ls_des)
			 dw_1.setitem(ll_row,"cat_com_articolo_descrizione",ls_descat)
			 dw_1.setitem(ll_row,"sog_commerciale_gen_rag_soc_1",ls_rag)
			 dw_1.setitem(ll_row,"id_cat_com_articolo",ll_id_cat_com)
			 dw_1.setitem(ll_row,"id_sog_commerciale",ll_id_sog_com)			 
  		 end if	 
	next
	
else
	filter = ""
	if isnull(ls_da_art) then ls_da_art = " "
	if isnull(ls_a_art) then ls_a_art = "ZZZZZ"
	if isnull(ls_stringa) then ls_stringa = ""
	if ls_stringa <> "" then
		ls_da_art = " "	
		ls_a_art = "ZZZZZ"	
	end if
	
	ll_ret = dw_1.retrieve(ls_da_art, ls_a_art)
	if not isnull(ll_id_sog_com) then filter = "id_sog_commerciale = " + string(ll_id_sog_com)
	if not isnull(ll_id_cat_com) then 
		if filter <> "" then
			filter = "AND id_cat_com_articolo = " + string(ll_id_cat_com)
		else
			filter = "id_cat_com_articolo = " + string(ll_id_cat_com)		
		end if
	end if
	
	dw_1.setfilter(filter)
	dw_1.filter()
end if

dw_1.setrow(1)
dw_1.selectrow(1,true)
end event

type dw_1 from u_dw_ext_main within w_sel_art_inf_sempl
int X=32
int Y=32
int Width=3122
int TabOrder=10
boolean BringToTop=true
string DataObject="d_ric_art_inf"
boolean VScrollBar=true
end type

event clicked;call super::clicked;if row > 0 then
	this.selectrow(0,false)
	this.selectrow(row,true)
	this.setfocus()
	this.setrow(row)
end if
end event

event doubleclicked;
choose case dwo.name		
	case 'sog_commerciale_gen_rag_soc_1_t'
		dw_1.setsort("sog_commerciale_gen_rag_soc_1 A")
		dw_1.sort()								
	case 'cat_com_articolo_descrizione_t'
		dw_1.setsort("cat_com_articolo_descrizione A")
		dw_1.sort()						
	case 'articolo_codice_t'
		dw_1.setsort("articolo_codice A")
		dw_1.sort()				
	case 'articolo_descrizione_t'
		dw_1.setsort("articolo_descrizione A")
		dw_1.sort()		
	case else
		if row > 0 then
			this.selectrow(0,false)
			this.selectrow(row,true)
			this.setfocus()
			this.setrow(row)
		end if		
		cb_1.triggerevent(clicked!)		
end choose


end event

event ue_key;call super::ue_key;long ll_row, ll_totrows


ll_totrows = this.rowcount()

choose case key
	
	case KeyEnter!
		if (keyflags = 0 Or keyflags = 1 Or keyflags = 2) then
			cb_1.triggerevent(clicked!)
		end if
		
	case keyuparrow!	
		ll_totrows = this.rowcount()
		ll_row = this.getrow()
		if ll_row > 1 then
			this.setrow(this.getrow() - 1)
			this.selectrow(0,false)
			this.selectrow(ll_row - 1,true)
		end if
		
	case keydownarrow!			
		ll_totrows = this.rowcount()
		ll_row = this.getrow()
		if ll_row < ll_totrows then
			this.setrow(this.getrow()+1)
			this.selectrow(0,false)
			this.selectrow(ll_row + 1, true)			
		end if
end choose
end event

event sqlpreview;String ls_filtro, ls_ordinamento
String Ls_SQLSyntax

if ls_stringa <> "" then
ls_SQLSyntax = SQLSyntax

choose case ls_tipo
	case "CA"
		ls_SQLSyntax = ls_SQLSyntax + "AND (articolo.codice like '" + ls_stringa + "%')"
	case "DA"		
		ls_SQLSyntax = ls_SQLSyntax + "AND (articolo.descrizione like '%" + ls_stringa + "%')"
	case "CF"						
		ls_SQLSyntax = ls_SQLSyntax + "AND (sog_commerciale_gen.codice like '%" + ls_stringa + "%')"		
	case "DF"				
		ls_SQLSyntax = ls_SQLSyntax + "AND (sog_commerciale_gen.rag_soc_1 like '%" + ls_stringa + "%')"		
	case "CC"				
		ls_SQLSyntax = ls_SQLSyntax + "AND (cat_com_articolo.codice like '%" + ls_stringa + "%')"				
	case "DC"				
		ls_SQLSyntax = ls_SQLSyntax + "AND (cat_com_articolo.descrizione like '%" + ls_stringa + "%')"						
end choose


This.SetSQLPreview(ls_SQLSyntax)
end if
end event

type cb_1 from commandbutton within w_sel_art_inf_sempl
int X=2629
int Y=824
int Width=526
int Height=108
int TabOrder=20
boolean BringToTop=true
string Text="&Informazioni Articolo"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long i, ll_totrows, ll_id_art

ll_totrows = dw_1.rowcount()

FOR i=1 TO ll_totrows
	if dw_1.isselected(i) = true then
		ll_id_art = dw_1.getitemnumber(i,"id_articolo")
		if not isnull(ll_id_art) then openwithparm(w_dati_articolo_cx,ll_id_Art)
	end if
NEXT

end event

type dw_dist from datawindow within w_sel_art_inf_sempl
int X=576
int Y=500
int Width=494
int Height=360
int TabOrder=20
boolean Visible=false
boolean BringToTop=true
string DataObject="ds_riga_dis"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

