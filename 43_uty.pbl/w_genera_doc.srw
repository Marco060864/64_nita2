forward
global type w_genera_doc from Window
end type
type dw_3 from datawindow within w_genera_doc
end type
type dw_2 from datawindow within w_genera_doc
end type
type st_5 from statictext within w_genera_doc
end type
type st_4 from statictext within w_genera_doc
end type
type st_3 from statictext within w_genera_doc
end type
type sle_1 from singlelineedit within w_genera_doc
end type
type st_2 from statictext within w_genera_doc
end type
type st_1 from statictext within w_genera_doc
end type
type dw_1 from datawindow within w_genera_doc
end type
type cb_2 from commandbutton within w_genera_doc
end type
type cb_1 from commandbutton within w_genera_doc
end type
end forward

global type w_genera_doc from Window
int X=833
int Y=361
int Width=2844
int Height=1425
boolean TitleBar=true
string Title="Untitled"
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
dw_3 dw_3
dw_2 dw_2
st_5 st_5
st_4 st_4
st_3 st_3
sle_1 sle_1
st_2 st_2
st_1 st_1
dw_1 dw_1
cb_2 cb_2
cb_1 cb_1
end type
global w_genera_doc w_genera_doc

type variables

end variables

on w_genera_doc.create
this.dw_3=create dw_3
this.dw_2=create dw_2
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.sle_1=create sle_1
this.st_2=create st_2
this.st_1=create st_1
this.dw_1=create dw_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={ this.dw_3,&
this.dw_2,&
this.st_5,&
this.st_4,&
this.st_3,&
this.sle_1,&
this.st_2,&
this.st_1,&
this.dw_1,&
this.cb_2,&
this.cb_1}
end on

on w_genera_doc.destroy
destroy(this.dw_3)
destroy(this.dw_2)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.sle_1)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.dw_1)
destroy(this.cb_2)
destroy(this.cb_1)
end on

event open;randomize(0)
dw_1.settransobject(sqlca)
end event

type dw_3 from datawindow within w_genera_doc
int X=1765
int Y=189
int Width=385
int Height=961
int TabOrder=40
boolean Visible=false
string DataObject="d_articolo_generaz_gd"
boolean LiveScroll=true
end type

type dw_2 from datawindow within w_genera_doc
int X=2172
int Y=181
int Width=558
int Height=957
int TabOrder=20
boolean Visible=false
string DataObject="d_sog_com_generaz_gd"
boolean LiveScroll=true
end type

type st_5 from statictext within w_genera_doc
int X=851
int Y=1173
int Width=252
int Height=93
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleShadowBox!
string Text="none"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_4 from statictext within w_genera_doc
int X=147
int Y=1185
int Width=631
int Height=77
boolean Enabled=false
string Text="Progressivfo Documenti:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_genera_doc
int X=741
int Y=69
int Width=686
int Height=77
boolean Enabled=false
string Text="Documenti da generare:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_1 from singlelineedit within w_genera_doc
int X=1459
int Y=49
int Width=284
int Height=101
int TabOrder=50
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long BackColor=16777215
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_genera_doc
int X=2428
int Y=1177
int Width=252
int Height=93
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleShadowBox!
string Text="none"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_genera_doc
int X=1838
int Y=1185
int Width=540
int Height=77
boolean Enabled=false
string Text="Totale Documenti:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_1 from datawindow within w_genera_doc
int X=65
int Y=197
int Width=2657
int Height=937
int TabOrder=10
string DataObject="d_documento_descr_generaz_lt"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event retrievestart;return 2
end event

type cb_2 from commandbutton within w_genera_doc
int X=87
int Y=45
int Width=247
int Height=109
int TabOrder=30
string Text="Ok"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(parent)
end event

type cb_1 from commandbutton within w_genera_doc
int X=1825
int Y=49
int Width=865
int Height=109
int TabOrder=60
string Text="Genera"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_id_reg, ll_id_prof, ll_num_prog, ll_id_sog_com, ll_id_valuta, j
long ll_id_art, ll_id_doc, ll_id_u_conf, ll_riga, i, ll_id_caus
decimal{2} ld_quantita
date ld_data_reg
time lt_ora_reg
string ls_cod_art, ls_des_art
long random, num_righe_doc
long num_doc, num_sog_com, num_art

num_doc=long(sle_1.text)
if IsNull(num_doc) then return

dw_2.settransobject(sqlca)
num_sog_com=dw_2.retrieve()
if num_sog_com<1 then return
dw_3.settransobject(sqlca)
num_art=dw_3.retrieve()
if num_art<1 then return

for j=1 to num_doc
	if mod(j,100)=0 then 
		commit;
	end if
	
	random=rand(100)
	ld_data_reg=relativedate(today(),- random)	
	lt_ora_reg=relativetime(now(),-5)	
	
	if (j=1) or mod(j,100)=0 then
		do 
		
			select id_prof_documento
			into :ll_id_prof
			from prof_documento
			where prof_documento.id_prof_documento=:random;
			if IsNull(ll_id_prof) then random=rand(100)
		loop while IsNull(ll_id_prof)
	end if
	
	select id_registro
	into :ll_id_reg
	from prof_documento, mod_registro, registro
	where (prof_documento.id_prof_documento=:ll_id_prof)
	and(mod_registro.id_mod_registro=prof_documento.id_mod_registro_prop)
	and(registro.id_mod_registro=mod_registro.id_mod_registro);
	
	select id_caus_magazzino
	into :ll_id_caus
	from prof_documento, caus_magazzino
	where (prof_documento.id_prof_documento=:ll_id_prof)
	and(caus_magazzino.id_caus_magazzino=prof_documento.id_caus_magazzino_prop);
	
	
	if mod(j,num_sog_com)<>0 then
		ll_id_sog_com=dw_2.getitemnumber(mod(j,num_sog_com),"id_sog_commerciale")
	else
		ll_id_sog_com=dw_2.getitemnumber(1,"id_sog_commerciale")
	end if
	
	select id_valuta
	into :ll_id_valuta
	from valuta
	where valuta.descrizione='Lire';
	
	
	select max(num_progressivo)
	into :ll_num_prog
	from documento
	where (documento.id_prof_documento=:ll_id_prof)and(documento.id_registro=:ll_id_reg);
	if IsNull(ll_num_prog) then 
		ll_num_prog=1
	else
		ll_num_prog++
	end if
	insert into documento (documento.id_prof_documento, documento.id_registro, documento.num_progressivo, documento.data_registrazione,
								documento.id_sog_commerciale, documento.id_valuta, documento.id_caus_magazzino, documento.ora_registrazione)
	values (:ll_id_prof, :ll_id_reg, :ll_num_prog, :ld_data_reg, :ll_id_sog_com, :ll_id_valuta, :ll_id_caus, :lt_ora_reg);
	select Max(id_documento)
	into :ll_id_doc
	from documento;
	num_righe_doc=rand(20)
	for i=1 to num_righe_doc
		if mod(j+i,num_art)<>0 then
			
			ll_id_art=dw_3.getitemnumber(mod(j+i,num_art),"id_articolo")
			ls_des_art=dw_3.getitemstring(mod(j+i,num_art),"descrizione")		
			
			ll_id_u_conf=dw_3.getitemnumber(mod(j+i,num_art),"id_unita_confezione")
		else
			ll_id_art=dw_3.getitemnumber(1,"id_articolo")
			ls_des_art=dw_3.getitemstring(1,"descrizione")		
			ll_id_u_conf=dw_3.getitemnumber(1,"id_unita_confezione")
		end if			
		
		insert into riga_documento (riga_documento.id_documento, riga_documento.num_riga, riga_documento.id_valuta, 
										riga_documento.id_articolo, riga_documento.quantita, riga_documento.id_caus_magazzino,
										riga_documento.descrizione, riga_documento.id_unita_confezione)
		values (:ll_id_doc, :i, :ll_id_valuta, :ll_id_art, :random, :ll_id_caus, :ls_des_art, :ll_id_u_conf);
		random=rand(100)
	next
	dw_1.retrieve(ll_id_doc)
	st_5.text=string(j)
	if mod(j,1000)=0 then 
		if messagebox('Generazione','Continuo?',StopSign!,yesNo!)=2 then exit
	end if
next
st_2.text=string(dw_1.rowcount())
end event

