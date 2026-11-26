forward
global type w_cat_codifica_cx from w_p_data
end type
type dw_cat_codifica_ff from u_dw_master_main within w_cat_codifica_cx
end type
type dw_cod_parte_lt from u_dw_master_main within w_cat_codifica_cx
end type
type dw_cod_parte_lt_t from statictext within w_cat_codifica_cx
end type
end forward

global type w_cat_codifica_cx from w_p_data
int Width=2460
int Height=1229
boolean TitleBar=true
string Title="Categoria di Codifica"
dw_cat_codifica_ff dw_cat_codifica_ff
dw_cod_parte_lt dw_cod_parte_lt
dw_cod_parte_lt_t dw_cod_parte_lt_t
end type
global w_cat_codifica_cx w_cat_codifica_cx

forward prototypes
public function long uf_regen_cod_parte (long al_id_cat_codifica)
public function long uf_fix_cat_codifica (long al_id_cat_codifica)
end prototypes

public function long uf_regen_cod_parte (long al_id_cat_codifica);
long ll_id_cat_codifica, ll_row, ll_count, ll_id_parte, ll_size, ll_new_row, ll_carattere
long 		ll_array[], ll_num_sezione[], ll_sezione, ll_parti_lunghezza[], ll_lunghezza
string 	ls_descrizione[], ls_descr, ls_mas_input

ll_size= dw_cod_parte_lt.RowCount()
For ll_count = 0 to ll_size -1
	ll_id_parte= dw_cod_parte_lt.GetItemNumber(ll_size - ll_count ,"id_cod_parte")
	DELETE FROM "scelta_parte"  
   WHERE "scelta_parte"."id_cod_parte" = :ll_id_parte ;
	dw_cod_parte_lt.DeleteRow(ll_size - ll_count)
next
DECLARE lcur_parte CURSOR FOR
	SELECT "parte_regola"."id_parte_regola" , "parte_regola"."num_sezione", "parte_regola"."descrizione" , "parte_regola"."lunghezza"  
    FROM "dba"."cat_codifica",   
         "dba"."scomposizione",   
         "dba"."parte_regola"  
   WHERE ( "scomposizione"."id_scomposizione" = "cat_codifica"."id_scomposizione" ) and  
         ( "parte_regola"."id_scomposizione" = "scomposizione"."id_scomposizione" ) and  
         ( ( "cat_codifica"."id_cat_codifica" = :al_id_cat_codifica ) )   ;

IF sqlca.sqlcode < 0 THEN
	MessageBox ("DataBase Error!", sqlca.sqlerrtext, exclamation!)
	RETURN 0
END IF
OPEN lcur_parte;
ll_count = 0
do while sqlca.sqlcode = 0
	
	fetch lcur_parte into :ll_id_parte,:ll_sezione  ,:ls_descr ,:ll_lunghezza ;
	if sqlca.sqlcode < 0 then
		MessageBox ("DataBase Error", sqlca.sqlerrtext, exclamation!)
		return 0
	end if
	if sqlca.sqlcode = 0 then
		ll_count++
		ll_array[ll_count] = ll_id_parte
		ll_num_sezione[ll_count]= ll_sezione
		ls_descrizione[ll_count]=ls_descr
		ll_parti_lunghezza[ll_count]= ll_lunghezza
	end if
loop
close lcur_parte;

For ll_count = 1 to UpperBound(ll_array)
	
	ll_new_row=dw_cod_parte_lt.InsertRow(0)
	dw_cod_parte_lt.SetItem(ll_new_row, "id_cat_codifica", al_id_cat_codifica)
	dw_cod_parte_lt.SetItem(ll_new_row, "id_parte_regola", ll_array[ll_count])
	dw_cod_parte_lt.SetItem(ll_new_row, "parte_regola_num_sezione", ll_num_sezione[ll_count])
	dw_cod_parte_lt.SetItem(ll_new_row, "parte_regola_descrizione", ls_descrizione[ll_count])
	

	ll_id_parte = ll_array[ll_count]
	ls_mas_input = ""
	for ll_carattere = 1 to ll_parti_lunghezza[ll_count]
		ls_mas_input = ls_mas_input + "X"
	next
	dw_cod_parte_lt.SetItem(ll_new_row, "cod_parte_mas_input", ls_mas_input)
next
return 0

end function

public function long uf_fix_cat_codifica (long al_id_cat_codifica);
long 		ll_row, ll_count, ll_id_parte, ll_new_row, ll_row_found, ll_size, ll_lunghezza
long 		ll_array[], ll_num_sezione[], ll_sezione, ll_parti_lunghezza[], ll_carattere
string 	ls_descrizione[], ls_descr,ls_mas_input

DECLARE lcur_parte CURSOR FOR
	SELECT "parte_regola"."id_parte_regola", "parte_regola"."num_sezione", "parte_regola"."descrizione", "parte_regola"."lunghezza"  
    FROM "dba"."cat_codifica",   
         "dba"."scomposizione",   
         "dba"."parte_regola"  
   WHERE ( "scomposizione"."id_scomposizione" = "cat_codifica"."id_scomposizione" ) and  
         ( "parte_regola"."id_scomposizione" = "scomposizione"."id_scomposizione" ) and  
         ( ( "cat_codifica"."id_cat_codifica" = :al_id_cat_codifica ) )   ;

IF sqlca.sqlcode < 0 THEN
	MessageBox ("DataBase Error!", sqlca.sqlerrtext, exclamation!)
	RETURN 0
END IF
OPEN lcur_parte;
ll_count = 0
do while sqlca.sqlcode = 0
	
	fetch lcur_parte into :ll_id_parte,:ll_sezione  ,:ls_descr ,:ll_lunghezza ;
	if sqlca.sqlcode < 0 then
		MessageBox ("DataBase Error", sqlca.sqlerrtext, exclamation!)
		return 0
	end if
	if sqlca.sqlcode = 0 then
		ll_count++
		ll_array[ll_count] = ll_id_parte
		ll_num_sezione[ll_count]= ll_sezione
		ls_descrizione[ll_count]=ls_descr
		ll_parti_lunghezza[ll_count]=ll_lunghezza
	end if
loop
close lcur_parte;

For ll_count = 1 to UpperBound(ll_array)
	ll_row_found=dw_cod_parte_lt.Find("id_parte_regola = " + String(ll_array[ll_count]) , 1 ,dw_cod_parte_lt.RowCount())
	CHOOSE CASE ll_row_found
		CASE 0
			
			ll_new_row=dw_cod_parte_lt.InsertRow(0)
			dw_cod_parte_lt.SetItem(ll_new_row, "id_cat_codifica", al_id_cat_codifica)
			dw_cod_parte_lt.SetItem(ll_new_row, "id_parte_regola",ll_array[ll_count])
			dw_cod_parte_lt.SetItem(ll_new_row, "parte_regola_num_sezione", ll_num_sezione[ll_count])
			dw_cod_parte_lt.SetItem(ll_new_row, "parte_regola_descrizione", ls_descrizione[ll_count])
			
			ll_id_parte = ll_array[ll_count]
			ls_mas_input = ""
			for ll_carattere = 1 to ll_parti_lunghezza[ll_count]
				ls_mas_input = ls_mas_input + "X"
			next
			dw_cod_parte_lt.SetItem(ll_new_row, "cod_parte_mas_input", ls_mas_input)
	END CHOOSE
next


return 0

end function

on w_cat_codifica_cx.create
int iCurrent
call w_p_data::create
this.dw_cat_codifica_ff=create dw_cat_codifica_ff
this.dw_cod_parte_lt=create dw_cod_parte_lt
this.dw_cod_parte_lt_t=create dw_cod_parte_lt_t
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=dw_cat_codifica_ff
this.Control[iCurrent+2]=dw_cod_parte_lt
this.Control[iCurrent+3]=dw_cod_parte_lt_t
end on

on w_cat_codifica_cx.destroy
call w_p_data::destroy
destroy(this.dw_cat_codifica_ff)
destroy(this.dw_cod_parte_lt)
destroy(this.dw_cod_parte_lt_t)
end on

event open;call super::open;il_HelpTopic = 106

idw_master = dw_cat_codifica_ff
idw_master.is_list = Message.PowerObjectParm

idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_sql_ident[1] = "cat_codifica.id_cat_codifica"

end event

event ue_insert_mode;call super::ue_insert_mode;cb_ok.Enabled = FALSE
end event

event ue_post_open;call super::ue_post_open;
if (UpperBound(idw_master.is_list.s_par_value) =1) AND &
	((idw_master.GetItemStatus(idw_master.GetRow(), 0, Primary!) =New!) OR(idw_master.GetItemStatus(idw_master.GetRow(), 0, Primary!) =NewModified!)) then
	If not(IsNull(idw_master.is_list.s_par_value[1]) OR  idw_master.is_list.s_par_value[1]="") then
		idw_master.SetItem(idw_master.GetRow(), "id_scomposizione",Long(idw_master.is_list.s_par_value[1]))
		f_displayonly(idw_master,"id_scomposizione" ,TRUE )
	end if
end if
end event

type p_crescente from w_p_data`p_crescente within w_cat_codifica_cx
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_cat_codifica_cx
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_cat_codifica_cx
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_cat_codifica_cx
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_cat_codifica_cx
int X=663
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_cat_codifica_cx
int TabOrder=40
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_cat_codifica_cx
boolean BringToTop=true
end type

event cb_cancella::clicked;
If IsValid(u_freddie.iudw_current) then
	If idw_master <> u_freddie.iudw_current then parent.triggerevent("ue_delete")
end if
end event

type cb_salva from w_p_data`cb_salva within w_cat_codifica_cx
int X=2126
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_cat_codifica_cx
int X=1121
int Y=21
int Width=252
int Height=141
int TabOrder=30
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
long BackColor=79741120
end type

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=19
int Y=105
int Width=215
int Height=21
end type

type cb_ricerca from w_p_data`cb_ricerca within w_cat_codifica_cx
boolean BringToTop=true
end type

type dw_cat_codifica_ff from u_dw_master_main within w_cat_codifica_cx
int X=46
int Y=161
int Width=2355
int Height=261
int TabOrder=20
string DataObject="d_cat_codifica_ff"
end type

event ue_init;call super::ue_init;is_list.s_identifica[1] = "id_cat_codifica"
iudw_children[1] = dw_cod_parte_lt
end event

event ue_update;call super::ue_update;
long		ll_id_cat_codifica, ll_id_scomposizione, ll_row
long 		ll_id_parte_regola[], ll_num_sezione[], li_parti_lunghezza[]
long 		ll_id_parte, ll_sezione, ll_lunghezza
long		ll_count, ll_size, ll_carattere
string 	ls_mas_input


ll_row = GetRow()
ll_id_scomposizione = this.GetItemNumber (ll_row,"id_scomposizione")
ll_id_cat_codifica = this.GetItemNumber(ll_row, "id_cat_codifica")

if (dw_cod_parte_lt.RowCount() = 0) and &
	(this.GetItemStatus(ll_row, 0, Primary!) = NotModified!) and &
	(ll_id_scomposizione > 0) and (ll_id_cat_codifica > 0) then
	
	
	DECLARE lcur_parti_regola CURSOR FOR
	SELECT  parte_regola.id_parte_regola, parte_regola.num_sezione,  parte_regola.lunghezza
		 FROM parte_regola
		 WHERE parte_regola.id_scomposizione = :ll_id_scomposizione
		 ORDER BY parte_regola.num_sezione;
	OPEN lcur_parti_regola;
	IF sqlca.sqlcode < 0 THEN
		MessageBox ("DataBase Error!", sqlca.sqlerrtext, exclamation!)
		RETURN 1
	END IF
	ll_count= 0
	do while sqlca.sqlcode = 0
		fetch lcur_parti_regola into :ll_id_parte, :ll_sezione, :ll_lunghezza ;
		if sqlca.sqlcode = 0 then
			ll_count++
			ll_id_parte_regola[ll_count] = ll_id_parte
			ll_num_sezione[ll_count] = ll_sezione
			li_parti_lunghezza[ll_count] = ll_lunghezza
		else
			if sqlca.sqlcode < 0 then
				MessageBox ("DataBase Error", sqlca.sqlerrtext, exclamation!)
				return 1
			else
				exit
			end if
		end if
	loop
	
	
	ll_size = UpperBound(ll_id_parte_regola)
	for ll_count = 1 to ll_size
		ll_id_parte = ll_id_parte_regola[ll_count]
		ls_mas_input = ""
		for ll_carattere = 1 to li_parti_lunghezza[ll_count]
			ls_mas_input = ls_mas_input + "X"
		next
		
		INSERT INTO cod_parte (id_cat_codifica, id_parte_regola, mas_input)
		VALUES (:ll_id_cat_codifica, :ll_id_parte, :ls_mas_input) USING SQLCA;
	next
	
	COMMIT USING SQLCA;
	if SQLCA.SQLCode < 0 then 
		MessageBox("Categorie Codifica","Problemi di Connessione con il Database.")
		ROLLBACK USING SQLCA;
	END IF
	dw_cod_parte_lt.is_list.l_identifica[1] = ll_id_cat_codifica
	dw_cod_parte_lt.Retrieve(ll_id_cat_codifica)
	cb_ok.Enabled = TRUE
end if



	

end event

event ue_modify;call super::ue_modify;

long				ll_row
dwItemStatus 	ls_status


ll_row = dw_cat_codifica_ff.GetRow()
ls_status = dw_cat_codifica_ff.GetItemStatus(ll_row, 0, Primary!)
if (ls_status = NewModified! or ls_status = New!) And is_list.s_win_parametri = "dal menu" then
	f_displayonly(dw_cat_codifica_ff,"id_scomposizione",False)
	f_displayonly(dw_cat_codifica_ff,"id_scomposizione_des",False)
else
	f_displayonly(dw_cat_codifica_ff,"id_scomposizione",True)
	f_displayonly(dw_cat_codifica_ff,"id_scomposizione_des",True)
end if

end event

event ue_insert;call super::ue_insert;

long				ll_row
dwItemStatus 	ls_status

ll_row = dw_cat_codifica_ff.GetRow()
ls_status = dw_cat_codifica_ff.GetItemStatus(ll_row, 0, Primary!)
if (ls_status = NewModified! or ls_status = New!) And is_list.s_win_parametri = "dal menu" then
	f_displayonly(dw_cat_codifica_ff,"id_scomposizione",False)
	f_displayonly(dw_cat_codifica_ff,"id_scomposizione_des",False)
end if

end event

type dw_cod_parte_lt from u_dw_master_main within w_cat_codifica_cx
int X=46
int Y=521
int Width=2355
int Height=601
int TabOrder=10
string DataObject="d_cod_parte_lt"
boolean VScrollBar=true
end type

event ue_init;call super::ue_init;is_title= "Codifica Parte"
is_list.s_win_zoom= "w_cod_parte_ff"
is_list.s_identifica[1] = "id_cat_codifica"
is_list.s_win_chiave[1] = "id_cod_parte"
is_list.s_par_name[1] = "id_cat_codifica"
end event

event ue_insert;
long ll_id_cat_codifica, ll_row

ll_row= dw_cat_codifica_ff.GetRow()
ll_id_cat_codifica= dw_cat_codifica_ff.GetItemNumber(ll_row, "id_cat_codifica")
parent.uf_fix_cat_codifica(ll_id_cat_codifica)


end event

event ue_delete;
long ll_id_cat_codifica, ll_row

ll_row = dw_cat_codifica_ff.GetRow()
ll_id_cat_codifica = dw_cat_codifica_ff.GetItemNumber(ll_row, "id_cat_codifica")
parent.uf_regen_cod_parte(ll_id_cat_codifica)

end event

event ue_modify;
long ll_count
boolean lb_new= FALSE

For ll_count = 1 to RowCount()
	If GetItemStatus(ll_count,0,Primary!) = New! OR GetItemStatus(GetRow(),0,Primary!) = NewModified! then
		lb_new= TRUE
	end if
next
if not lb_new then
	call super::ue_modify
else
	MessageBox(is_title,"Salvare i dati prima di entrare nel dettaglio.")
end if
end event

type dw_cod_parte_lt_t from statictext within w_cat_codifica_cx
int X=46
int Y=421
int Width=2355
int Height=81
boolean Enabled=false
boolean BringToTop=true
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
string Text="Parametri delle sezioni del Codice"
boolean FocusRectangle=false
long TextColor=16777215
long BackColor=276856960
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

