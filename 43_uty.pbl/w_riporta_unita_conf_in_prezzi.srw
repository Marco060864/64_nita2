forward
global type w_riporta_unita_conf_in_prezzi from Window
end type
type ddlb_1 from dropdownlistbox within w_riporta_unita_conf_in_prezzi
end type
type st_2 from statictext within w_riporta_unita_conf_in_prezzi
end type
type cb_1 from commandbutton within w_riporta_unita_conf_in_prezzi
end type
type st_1 from statictext within w_riporta_unita_conf_in_prezzi
end type
end forward

global type w_riporta_unita_conf_in_prezzi from Window
int X=1057
int Y=483
int Width=1295
int Height=723
boolean TitleBar=true
string Title="Aggiorna Prezzo"
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
ddlb_1 ddlb_1
st_2 st_2
cb_1 cb_1
st_1 st_1
end type
global w_riporta_unita_conf_in_prezzi w_riporta_unita_conf_in_prezzi

on w_riporta_unita_conf_in_prezzi.create
this.ddlb_1=create ddlb_1
this.st_2=create st_2
this.cb_1=create cb_1
this.st_1=create st_1
this.Control[]={this.ddlb_1,&
this.st_2,&
this.cb_1,&
this.st_1}
end on

on w_riporta_unita_conf_in_prezzi.destroy
destroy(this.ddlb_1)
destroy(this.st_2)
destroy(this.cb_1)
destroy(this.st_1)
end on

type ddlb_1 from dropdownlistbox within w_riporta_unita_conf_in_prezzi
int X=735
int Y=365
int Width=216
int Height=230
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"A",&
"V"}
end type

type st_2 from statictext within w_riporta_unita_conf_in_prezzi
int X=106
int Y=221
int Width=1028
int Height=77
boolean Enabled=false
string Text="le unità confezioni nella tabella Prezzo"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_1 from commandbutton within w_riporta_unita_conf_in_prezzi
int X=113
int Y=378
int Width=249
int Height=109
int TabOrder=10
string Text="Avvia"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;integer id_var
integer id_unita_conf
string ls_tipo_listino
ls_tipo_listino=ddlb_1.text
open(w_attesa)
SELECT "variazione"."id_variazione"
INTO :id_var
FROM "variazione", "listino"
WHERE	(today() >= "variazione"."data_inizio") AND
	(today() <= "variazione"."data_fine") AND
	("variazione"."id_listino" = "listino"."id_listino") AND
	("listino"."tipo" = :ls_tipo_listino) AND
	("listino"."lis_base" = 'S')

;



DECLARE elenco_unita_confezioni CURSOR FOR
  	SELECT "unita_confezione"."id_unita_confezione"
    	FROM "unita_confezione"  ;

OPEN elenco_unita_confezioni;

FETCH elenco_unita_confezioni 
	INTO :id_unita_conf;

DO WHILE  not(SQLCA.SQLCode <> 0)
	
	INSERT 
	INTO "prezzo" ("id_unita_confezione","id_variazione")
	VALUES (:id_unita_conf , :id_var );
	
	FETCH elenco_unita_confezioni
	INTO :id_unita_conf;
	
LOOP

CLOSE elenco_unita_confezioni;
close(w_attesa)
close( w_riporta_unita_conf_in_prezzi )
end event

type st_1 from statictext within w_riporta_unita_conf_in_prezzi
int X=168
int Y=93
int Width=947
int Height=106
boolean Enabled=false
string Text="Premere ~"Avvia~" per riportare tutte "
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=79741120
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

