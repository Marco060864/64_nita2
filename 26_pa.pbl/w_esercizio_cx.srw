forward
global type w_esercizio_cx from w_p_data
end type
type dw_esercizio_ff from u_dw_master_main within w_esercizio_cx
end type
type dw_registro_esercizio_gd from u_dw_master_main within w_esercizio_cx
end type
type cb_1 from commandbutton within w_esercizio_cx
end type
end forward

global type w_esercizio_cx from w_p_data
int Width=2409
int Height=1628
boolean TitleBar=true
string Title="Esercizi Contabili e loro Registri"
dw_esercizio_ff dw_esercizio_ff
dw_registro_esercizio_gd dw_registro_esercizio_gd
cb_1 cb_1
end type
global w_esercizio_cx w_esercizio_cx

type variables
uo_pipe1 iuo_pipe_mod_registro
end variables

forward prototypes
public function integer uf_start_pipe (integer an_ret_descriz)
end prototypes

public function integer uf_start_pipe (integer an_ret_descriz);

long				ll_row, ll_id_esercizio
integer 			li_start_res
uo_sp_trans 	ltrans_src, ltrans_dest

ll_row = dw_esercizio_ff.GetRow()
ll_id_esercizio = dw_esercizio_ff.GetItemNumber(ll_row,"id_esercizio")

ltrans_src = CREATE uo_sp_trans
ltrans_dest = CREATE uo_sp_trans
ltrans_src.dbms = SQLCA.dbms
ltrans_src.dbparm = SQLCA.dbparm
ltrans_dest.dbms = SQLCA.dbms
ltrans_dest.dbparm = SQLCA.dbparm

CONNECT USING ltrans_src;
CONNECT USING ltrans_dest;

iuo_pipe_mod_registro = CREATE uo_pipe1

iuo_pipe_mod_registro.dataobject = "pl_mod_registro"

Open(w_pipe_risultati)
iuo_pipe_mod_registro.ist_status_read = w_pipe_risultati.st_rr
iuo_pipe_mod_registro.ist_status_written = w_pipe_risultati.st_rw
iuo_pipe_mod_registro.ist_status_error = w_pipe_risultati.st_re

li_start_res = iuo_pipe_mod_registro.Start(ltrans_src,ltrans_dest,w_pipe_risultati.dw_pipe_errors,ll_id_esercizio,an_ret_descriz)

IF li_start_res = 1  THEN
	COMMIT USING ltrans_dest;
	COMMIT USING ltrans_src;
	
	Close(w_pipe_risultati)
ELSE
	MessageBox("Creazione Automatica Registri","Impossibile creare automaticamente i registri." + &
					"~rErrore interno numero " + String(li_start_res) + "~r(w_esercizio_cx " + &
					"/ uf_start_pipe)")
	COMMIT USING ltrans_dest;
	COMMIT USING ltrans_src;
	w_pipe_risultati.Visible = True
END IF

DISCONNECT USING ltrans_src;
IF ltrans_src.SQLCode = -1 THEN
	MessageBox("Attenzione:", "Errore durante chiusura del database sorgente.")
END IF
DISCONNECT USING ltrans_dest;
IF ltrans_dest.SQLCode = -1 THEN
	MessageBox("Attenzione:", "Errore durante chiusura del database destinazione.")
END IF

DESTROY iuo_pipe_mod_registro
DESTROY ltrans_dest
DESTROY ltrans_src

Return(li_start_res)
end function

on w_esercizio_cx.create
int iCurrent
call super::create
this.dw_esercizio_ff=create dw_esercizio_ff
this.dw_registro_esercizio_gd=create dw_registro_esercizio_gd
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_esercizio_ff
this.Control[iCurrent+2]=this.dw_registro_esercizio_gd
this.Control[iCurrent+3]=this.cb_1
end on

on w_esercizio_cx.destroy
call super::destroy
destroy(this.dw_esercizio_ff)
destroy(this.dw_registro_esercizio_gd)
destroy(this.cb_1)
end on

event open;call super::open;il_HelpTopic = 74
idw_master = dw_esercizio_ff
idw_master.is_list = Message.PowerObjectParm

idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_sql_ident[1] = "esercizio.id_esercizio"

end event

type p_crescente from w_p_data`p_crescente within w_esercizio_cx
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_esercizio_cx
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_esercizio_cx
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_esercizio_cx
int X=320
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_esercizio_cx
int X=599
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_esercizio_cx
int X=1545
boolean BringToTop=true
string Text="Aggiorna"
end type

event cb_inserisci::clicked;


long			ll_row, ll_row1, ll_id_esercizio, ll_num_vecchio, ll_num_nuovo, ll_id_mod_registro, ll_foundrow
integer		li_result
string   	ls_descrizione, ls_find

ib_askforsave = False

ll_row = dw_esercizio_ff.GetRow()
ll_id_esercizio = dw_esercizio_ff.GetItemNumber(ll_row, "id_esercizio")
ll_num_vecchio = dw_registro_esercizio_gd.RowCount()
li_result = uf_start_pipe(99)

if li_result = 1 then
	dw_registro_esercizio_gd.Retrieve(ll_id_esercizio)
	ll_num_nuovo = dw_registro_esercizio_gd.RowCount()
	
	if ll_num_nuovo > ll_num_vecchio then
		ll_row1 = 1
		DO WHILE ll_row1 <= ll_num_nuovo
			ll_id_mod_registro = dw_registro_esercizio_gd.GetItemNumber(ll_row1, "registro_id_mod_registro")
			
			SELECT "mod_registro"."descrizione"
				INTO :ls_descrizione
				FROM "mod_registro"
				WHERE ( "mod_registro"."id_mod_registro" = :ll_id_mod_registro )   ;
			
			ls_find = "registro_descrizione = 'NewLine...' AND registro_id_mod_registro = " &
						+ String(ll_id_mod_registro) + " AND id_esercizio = " &
						+ String(ll_id_esercizio)
			ll_foundrow = dw_registro_esercizio_gd.Find(ls_find, 1, ll_num_nuovo)
			if ll_foundrow > 0 then
				dw_registro_esercizio_gd.SetItem(ll_foundrow, "registro_descrizione", ls_descrizione)
			end if
			ll_row1 = ll_row1 + 1
		LOOP
		parent.TriggerEvent("ue_update")
	end if
end if

end event

type cb_cancella from w_p_data`cb_cancella within w_esercizio_cx
int X=1824
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_esercizio_cx
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_esercizio_cx
int X=2103
int Y=1260
int Width=187
int Height=80
int TabOrder=30
boolean Visible=false
boolean BringToTop=true
long BackColor=79741120
end type

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=18
int Y=104
int Width=151
end type

type cb_ricerca from w_p_data`cb_ricerca within w_esercizio_cx
boolean BringToTop=true
end type

type dw_esercizio_ff from u_dw_master_main within w_esercizio_cx
int X=18
int Y=160
int Width=2350
int Height=328
int TabOrder=20
string DataObject="d_esercizio_ff"
end type

event ue_insert;call super::ue_insert;

This.Object.codice.edit.displayonly = False
This.Object.data_inizio.protect = False
This.Object.data_fine.protect = False
This.Object.bloccato.protect = False
This.Object.ult_data_stampa_bollato.protect = False
This.Object.num_progressivo.protect = False
end event

event ue_modify;call super::ue_modify;

long				ll_row
dwItemStatus 	ls_status

ll_row = dw_esercizio_ff.GetRow()
ls_status = dw_esercizio_ff.GetItemStatus(ll_row, 0, Primary!)
if Not (ls_status = NewModified! or ls_status = New!) then
	This.Object.codice.edit.displayonly = True
	This.Object.data_inizio.protect = True
	This.Object.data_fine.protect = True
	This.Object.bloccato.protect = True
	
	
end if

end event

event ue_init;call super::ue_init;is_list.s_identifica[1] = "id_esercizio"
iudw_children[1] = dw_registro_esercizio_gd
is_title = "Esercizi Contabili"
end event

event ue_update;long				ll_row, ll_id_esercizio
dwItemStatus 	ls_status
integer			li_yn, li_result
string			ls_mess

ll_row = dw_esercizio_ff.GetRow()
ls_status = dw_esercizio_ff.GetItemStatus(ll_row, 0, Primary!)
li_yn = 0	
if ls_status = NewModified! then
	li_yn = MessageBox("Creazione Esercizio", "E' possibile creare automaticamente " + &
					"una serie di registri, secondo i Modelli Registro.~rSi desidera farlo ora?", + &
					Question!, YesNo!)
end if
Call Super::ue_update
if li_yn = 1 then
	li_result = uf_start_pipe(1)
	if li_result = 1 then
		ll_id_esercizio = dw_esercizio_ff.GetItemNumber(ll_row, "id_esercizio")
		dw_registro_esercizio_gd.Retrieve(ll_id_esercizio)
	end if
end if
end event

event itemchanged;long ll_RetVal
string ls_pwd
if dwo.name='sblocca' and data='S' then
	s_any_array lstr_any_array
	messagebox("Attenzione!", "Si sta abilitando la modifica dei valori di riferimento  ~r~n del libro giornale."+&
	"Per salvare i dati inserire la password")
	OpenWithParm(w_wizard_pwd_contatori_ff, lstr_any_array)
	lstr_any_array = Message.PowerObjectParm
	
	ls_pwd = lstr_any_array.s_array[1]
	
	IF ls_pwd = "cometa" THEN
	ELSE
		MessageBox("Wizard", "Password errata.")
		return 2
	END IF
end if
end event

event clicked;call super::clicked;s_any_array lstr_any_array
string ls_pwd
if upper(string(dwo.name))='BLOCCATO' then
	messagebox("Attenzione!", "Si sta abilitando la modifica dei valori di riferimento  ~r~n del libro giornale."+&
	"Per salvare i dati inserire la password")
	OpenWithParm(w_wizard_pwd_contatori_ff, lstr_any_array)
	lstr_any_array = Message.PowerObjectParm
	
	ls_pwd = lstr_any_array.s_array[1]
	
	IF ls_pwd = "cometa" THEN
		this.object.bloccato.protect=false
	ELSE
		MessageBox("Wizard", "Password errata.")
		return 2
	END IF
end if
	
end event

type dw_registro_esercizio_gd from u_dw_master_main within w_esercizio_cx
event ue_post_itemchanged ( long ll_riga )
int X=27
int Y=596
int Width=2350
int Height=900
int TabOrder=10
string DataObject="d_registro_esercizio_gd"
boolean VScrollBar=true
end type

event ue_post_itemchanged;call super::ue_post_itemchanged;integer null_num
setnull(null_num)

ll_riga=Message.WordParm

dw_registro_esercizio_gd.setitem(ll_riga,"registro_perc_prorata",null_num)
dw_registro_esercizio_gd.SetColumn("registro_perc_prorata")
end event

event ue_init;call super::ue_init;is_list.s_identifica[1] = "id_esercizio"
is_title = "Registri dell'esercizio"
end event

event constructor;call super::constructor;
This.Object.registro_tipo_registro.Protect = 1
This.Object.registro_numero.Protect = 1
This.Object.registro_id_attivita.Protect = 1



end event

event doubleclicked;call super::doubleclicked;string ls_tipologia,ls_param
long ll_id_attivita, ll_rif_registro

ls_tipologia=this.getitemstring(row,"registro_tipo_registro")
ll_id_attivita=this.getitemnumber(row,"registro_id_attivita")
ll_rif_registro= this.getitemnumber(row,"registro_id_registro")

if (ls_tipologia="IA") or (ls_tipologia="IV") or (ls_tipologia="IC") then

	ls_param=string(ll_id_attivita)+"-"+ls_tipologia+"-"+string(ll_rif_registro)
	openwithparm(w_contatori_registri_lt,ls_param,parent)
else
	messagebox("ATTENZIONE","Non ci sono dettagli per questo registro",exclamation!)
end if 


end event

event itemchanged;call super::itemchanged;

integer li_flag
string ls_tipo_registro
long ll_id_esercizio,ll_id_attivita,ll_riga, ll_id_registro
decimal ld_perc_prorata
integer null_num 		

					
SetNull(null_num)

li_flag=0

IF dwo.Name="registro_perc_prorata" THEN
	ll_riga=getrow()
	ls_tipo_registro=dw_registro_esercizio_gd.getitemstring(ll_riga,"registro_tipo_registro")
	ll_id_registro=dw_registro_esercizio_gd.getitemnumber(ll_riga,"registro_id_registro")
		
   if ls_tipo_registro='IA' then 
	   ll_id_attivita=dw_registro_esercizio_gd.getitemnumber(ll_riga,"registro_id_attivita")
		ll_id_esercizio=dw_esercizio_ff.getitemnumber(1,"id_esercizio")
		
		
		DECLARE registro_cur CURSOR FOR  
       SELECT "registro"."perc_prorata"  
         FROM "registro"  
        WHERE ( "registro"."id_esercizio" = :ll_id_esercizio ) AND  
              ( "registro"."id_attivita" = :ll_id_attivita ) AND  
              ( "registro"."tipo_registro" = 'IA' ) AND 
				  ( "registro"."id_registro" <> :ll_id_registro )   ;
		OPEN registro_cur;
		FETCH registro_cur INTO :ld_perc_prorata;
		DO WHILE SQLCA.SQLCODE=0
			
			if not isnull(ld_perc_prorata) and ld_perc_prorata<>dec(data) then
			   li_flag=1
		   end if
		   FETCH registro_cur INTO :ld_perc_prorata;
	   LOOP
		CLOSE registro_cur;	
		
		IF li_flag=1 THEN
		   messagebox("Controllo", "Attenzione,~nla percentuale prorata inserita è diversa da quella~ninserita in un altro Registro Acquisti!")
			
        	this.PostEvent("ue_post_itemchanged",ll_riga,0)
				ELSE
				 
				 
				 
				 ld_perc_prorata=dec(data)
				 UPDATE registro
				    SET perc_prorata=:ld_perc_prorata
				  WHERE ( "registro"."id_esercizio" = :ll_id_esercizio ) AND  
						  ( "registro"."id_attivita" = :ll_id_attivita ) AND  
						  ( "registro"."tipo_registro" = 'IA' ) ;
				 dw_registro_esercizio_gd.retrieve(ll_id_esercizio)
	   END IF
   end if
	
END IF


end event

event ue_insert;
end event

type cb_1 from commandbutton within w_esercizio_cx
int X=887
int Y=40
int Width=635
int Height=84
int TabOrder=1
boolean BringToTop=true
string Text="Elimina Esercizio/Registri"
int TextSize=-8
int Weight=400
string FaceName="Arial"
boolean Italic=true
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
long ll_curow, ll_id_es, num_reg, num_registro

ll_curow = dw_esercizio_ff.getrow()
ll_id_es = dw_esercizio_ff.getitemnumber ( ll_curow, 'id_esercizio')


select count(id_registro)
into :num_reg
from registro
WHERE id_esercizio =:ll_id_es
and id_registro not in (select documento.id_registro from documento
										where documento.id_registro = registro.id_registro)
and id_registro not in (select reg_pd.id_registro from reg_pd
										where reg_pd.id_registro = registro.id_registro);

select count(id_registro)
into :num_registro
from registro
WHERE id_esercizio =:ll_id_es;

IF num_reg = num_registro THEN

	DELETE FROM registro
	WHERE id_esercizio =:ll_id_es
	and id_registro not in (select documento.id_registro from documento
											where documento.id_registro = registro.id_registro)
	and id_registro not in (select reg_pd.id_registro from reg_pd
											where reg_pd.id_registro = registro.id_registro);
											
	dw_registro_esercizio_gd.retrieve(ll_id_es)

END IF

DELETE FROM esercizio
WHERE id_esercizio =:ll_id_es;

IF SQLCA.SQLCODE <> 0 THEN
	Messagebox ('Attenzione', 'Impossibile cancellare i registri in quanto movimentati', Stopsign!)
ELSE
	Messagebox ('OK', 'Cancellazione Effettuata')
	dw_esercizio_ff.retrieve()
END IF


end event

