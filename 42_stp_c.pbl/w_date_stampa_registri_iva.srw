forward
global type w_date_stampa_registri_iva from Window
end type
type cb_1 from commandbutton within w_date_stampa_registri_iva
end type
type dw_1 from datawindow within w_date_stampa_registri_iva
end type
type st_1 from statictext within w_date_stampa_registri_iva
end type
type r_2 from rectangle within w_date_stampa_registri_iva
end type
end forward

global type w_date_stampa_registri_iva from Window
int X=832
int Y=360
int Width=1381
int Height=920
boolean TitleBar=true
string Title="Ultime date di stampa"
long BackColor=79741120
boolean ToolBarVisible=false
WindowType WindowType=response!
cb_1 cb_1
dw_1 dw_1
st_1 st_1
r_2 r_2
end type
global w_date_stampa_registri_iva w_date_stampa_registri_iva

type variables
string ls_confronto,mai_stampato
end variables

event open;string ls_tipo_registro
long ll_id_esercizio,cur_id_registro,ll_newrow,cur_numero,contatore,i,cont_null
date data_stampa,data_stampa_conf, data_0
date_stampa_parametri str_param

str_param=message.powerobjectparm
ll_id_esercizio=str_param.id_esercizio
ls_tipo_registro=str_param.tipologia
				
DECLARE registri_cur CURSOR FOR
		SELECT r.id_registro, r.numero
		FROM  registro r
		WHERE (tipo_registro=:ls_tipo_registro)
		  and (id_esercizio=:ll_id_esercizio)
		
		ORDER BY numero;
					
OPEN registri_cur;
	
FETCH registri_cur INTO :cur_id_registro,:cur_numero;
		
DO WHILE sqlca.sqlcode=0
			
	select max(ultima_data)
	into :data_stampa
	from contatori_registri
	where (tipologia=:ls_tipo_registro)
	  and (id_registro=:cur_id_registro);
	
	if cur_numero<>0 then 
		data_stampa_conf=data_stampa
	else
		data_0=data_stampa
	end if	
	  
	if sqlca.sqlcode=100 then
			messagebox("A","un registro non è presente nelle date di stampa ")
	else
			contatore=contatore+1
			ll_newrow=dw_1.insertrow(0)
			dw_1.scrolltorow(ll_newrow)
			dw_1.setitem(contatore,"data_stampa",data_stampa)
			dw_1.setitem(contatore,"tipologia",ls_tipo_registro)
			dw_1.setitem(contatore,"numero",string(cur_numero))		
	end if
	
	FETCH registri_cur INTO :cur_id_registro,:cur_numero;
		
LOOP
	
CLOSE registri_cur;

ls_confronto='S'
FOR i=1 to contatore step 1
	data_stampa=dw_1.getitemdate(i,"data_stampa")
	if dw_1.getitemstring(i,"numero") <>'0' then
		if data_stampa<>data_stampa_conf or isnull(data_stampa) or data_stampa>data_0 or isnull(data_0) then
			ls_confronto='N'
		end if
	end if	
NEXT

if ls_confronto='S' then
   dw_1.setfilter("numero='0'")
	dw_1.filter()
	if dw_1.rowcount() = 0 then
		dw_1.setfilter("")
  	   dw_1.filter()
	else
		ls_confronto='S'
		data_stampa=dw_1.getitemdate(1,"data_stampa")
	end if
end if


if ls_confronto='N' then
	FOR i=1 to contatore step 1
		data_stampa=dw_1.getitemdate(i,"data_stampa")
		if isnull(data_stampa) then cont_null=cont_null+1
	NEXT
	if cont_null=contatore then
		mai_stampato='S'
		st_1.text='Questa tipologia non è stata mai stampata.'
	else
		st_1.text='Le date di stampa dei registri appartenenti alla tipologia selezionata non sono coincidenti; non è possibile andare avanti!'
	end if
else
	data_stampa=relativedate(data_stampa,1)
	st_1.text='La data di inizio stampa proposta è '+string(data_stampa)
end if




		
end event

on w_date_stampa_registri_iva.create
this.cb_1=create cb_1
this.dw_1=create dw_1
this.st_1=create st_1
this.r_2=create r_2
this.Control[]={this.cb_1,&
this.dw_1,&
this.st_1,&
this.r_2}
end on

on w_date_stampa_registri_iva.destroy
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.st_1)
destroy(this.r_2)
end on

type cb_1 from commandbutton within w_date_stampa_registri_iva
int X=480
int Y=700
int Width=393
int Height=104
int TabOrder=20
string Text="OK"
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
date data_prop_iniziale
str_date_prop str_date

if ls_confronto='S' then
	data_prop_iniziale=dw_1.getitemdate(1,"data_stampa")
	str_date.data_prop_iniziale=relativedate(data_prop_iniziale,1)	
	closewithreturn(parent,str_date)
else
	if mai_stampato='S'	then
		setnull(data_prop_iniziale)
		str_date.data_prop_iniziale=data_prop_iniziale
		str_date.mai_stampato=mai_stampato
		closewithreturn(parent,str_date)
	else
	setnull(data_prop_iniziale)
	str_date.data_prop_iniziale=data_prop_iniziale	
	closewithreturn(parent,str_date)
end if
end if 
end event

type dw_1 from datawindow within w_date_stampa_registri_iva
int X=73
int Y=316
int Width=1211
int Height=360
int TabOrder=10
string DataObject="d_app_date_stp_reg_iva"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

type st_1 from statictext within w_date_stampa_registri_iva
int X=55
int Y=60
int Width=1243
int Height=184
boolean Enabled=false
string Text="Ultime date di stampa per la tipologia di registri selezionata"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type r_2 from rectangle within w_date_stampa_registri_iva
int X=37
int Y=260
int Width=1294
int Height=496
boolean Enabled=false
int LineThickness=8
long LineColor=15780518
long FillColor=79741120
end type

