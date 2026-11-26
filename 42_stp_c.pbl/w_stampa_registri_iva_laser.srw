forward
global type w_stampa_registri_iva_laser from w_stampa_liq_iva1_ff
end type
type st_1 from statictext within w_stampa_registri_iva_laser
end type
end forward

global type w_stampa_registri_iva_laser from w_stampa_liq_iva1_ff
boolean TitleBar=true
string Title="Stampa Registri IVA"
st_1 st_1
end type
global w_stampa_registri_iva_laser w_stampa_registri_iva_laser

on w_stampa_registri_iva_laser.create
int iCurrent
call super::create
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
end on

on w_stampa_registri_iva_laser.destroy
call super::destroy
destroy(this.st_1)
end on

event open;

reg_iva_parametri str_param
string rs_tipo_registro,ls_filtro,ls_flag_definitiva,ls_filtro_rip,flag_ripristino, ls_azienda
datawindowchild ldw_dett_reg, ldw_riep_reg
long ret,rl_n_registro,rl_id_attivita,rl_id_registro,cur_numero,cur_id_registro,rl_id_esercizio,cur_id_registro2
integer i

date rd_dalla_data,rd_alla_data
il_zoom=100
str_param=message.powerobjectparm
rs_tipo_registro=str_param.tipo_registro
rd_dalla_data=str_param.dalla_data
rd_alla_data=str_param.alla_data
ls_filtro=str_param.ls_filtro
ls_flag_definitiva=str_param.ls_flag_definitiva
rl_id_attivita=str_param.ll_id_attivita
rl_id_registro=str_param.ll_id_registro
rl_n_registro=str_param.ll_n_registro
rl_id_esercizio=str_param.ll_id_esercizio
ls_filtro_rip=str_param.ls_filtro_rip
flag_ripristino=str_param.flag_ripristino
dw_1.settransobject(sqlca)
dw_1.retrieve(rs_tipo_registro,rd_dalla_data,rd_alla_data,rl_id_esercizio)
dw_1.getchild("dettagli_registro",ldw_dett_reg)
dw_1.getchild("riepilogo_registro",ldw_riep_reg)


select rag_soc_1
 into :ls_azienda
 from azienda
 where id_azienda = 1;
 

for i = 1 to ldw_dett_reg.rowcount()
	dw_1.object.dettagli_registro.object.az[i]    = ls_azienda
	dw_1.object.dettagli_registro.object.tipo[i]  = rs_tipo_registro
	dw_1.object.dettagli_registro.object.dat1[i]  = rd_dalla_data
	dw_1.object.dettagli_registro.object.dat2[i]  = rd_alla_data
next


if flag_ripristino='S'then
	ret=ldw_dett_reg.setfilter(ls_filtro_rip)
else

ret=ldw_dett_reg.setfilter(ls_filtro)
end if
ret=ldw_riep_reg.setfilter(ls_filtro)
ret=ldw_dett_reg.filter()
ret=ldw_riep_reg.filter()

ldw_riep_reg.groupcalc()

if ls_flag_definitiva='S' then
printsetup()
ret=messagebox("Stampa registri IVA","La stampa è andata a buon fine?",question!,yesno!)
if ret=1 then
	
	if ls_filtro='' then
		update ws_registri_iva
	set st_reg_iva='S',
	 st_reg_iva_a='S'
	where (ws_registri_iva.tipo_registro=:rs_tipo_registro)and
			(ws_registri_iva.data_registrazione>=:rd_dalla_data)and
			(ws_registri_iva.data_registrazione<=:rd_alla_data)and
			(ws_registri_iva.st_reg_iva='I')and(ws_registri_iva.st_reg_iva_a='I');
				
		
		
		
		
		
		
		
		
		DECLARE ws_registri_iva_cur CURSOR FOR
		SELECT "ws_registri_iva"."numero"
		FROM "ws_registri_iva"
		WHERE ("ws_registri_iva"."tipo_registro"=:rs_tipo_registro)and
				("ws_registri_iva"."data_registrazione">=:rd_dalla_data)and
				("ws_registri_iva"."data_registrazione"<=:rd_alla_data)
		ORDER BY numero;
				
		
		OPEN ws_registri_iva_cur;
		
		FETCH ws_registri_iva_cur INTO :cur_numero;
		
		DO WHILE sqlca.sqlcode=0
			
			
			select "registro"."id_registro"
				into :cur_id_registro
				from "registro"
				where ("registro"."tipo_registro"=:rs_tipo_registro)and
						("registro"."id_attivita"=:rl_id_attivita)and
						("registro"."numero"=:cur_numero)and
						("registro"."id_esercizio"=:rl_id_esercizio);
					
			if cur_id_registro<>cur_id_registro2 then
				cur_id_registro2=cur_id_registro		
				
						
			insert
			into contatori_registri(id_azienda,id_attivita,data_stampa,tipologia,id_registro)
			values(1,:rl_id_attivita,today(),:rs_tipo_registro,:cur_id_registro2);		
		end if
		FETCH ws_registri_iva_cur INTO :cur_numero;
		
	LOOP
	
	CLOSE ws_registri_iva_cur;
		
			
		
	else
	update ws_registri_iva
	set st_reg_iva='S',
	 st_reg_iva_a='S'
	where (ws_registri_iva.tipo_registro=:rs_tipo_registro)and
			(ws_registri_iva.data_registrazione>=:rd_dalla_data)and
			(ws_registri_iva.data_registrazione<=:rd_alla_data)and
			(ws_registri_iva.numero=:rl_n_registro)and
			(ws_registri_iva.st_reg_iva='I')and(ws_registri_iva.st_reg_iva_a='I');
			
		
		insert
		into contatori_registri(id_azienda,id_attivita,data_stampa,tipologia,id_registro)
		values(1,:rl_id_attivita,today(),:rs_tipo_registro,:rl_id_registro);
			
		close(this)	
		end if		
			
			
			
			
			
			
			
	else
		
close(this)		
close(w_stampa_reg_iva_rpt)

if flag_ripristino='S' then
else
open(w_stampa_reg_iva_ripristino)
end if


end if

end if			
	
end event

event cb_2::clicked;call super::clicked;printsetup()
end event

type dw_1 from w_stampa_liq_iva1_ff`dw_1 within w_stampa_registri_iva_laser
int TabOrder=70
string DataObject="d_stampa_registri_iva_comp_laser"
end type

event cb_3::clicked;
printsetup()
dw_1.print()
end event

type st_1 from statictext within w_stampa_registri_iva_laser
int X=2258
int Y=48
int Width=247
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="R."
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

