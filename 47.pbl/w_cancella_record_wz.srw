forward
global type w_cancella_record_wz from w_wiz_main
end type
type dw_controllo_con_riga from datawindow within w_cancella_record_wz
end type
type p_msg_log from picture within w_cancella_record_wz
end type
type st_controlla_documento from statictext within w_cancella_record_wz
end type
type cb_uscire from commandbutton within w_cancella_record_wz
end type
type cb_anulla from commandbutton within w_cancella_record_wz
end type
type cb_ok from commandbutton within w_cancella_record_wz
end type
type dw_cancella_record_lt from datawindow within w_cancella_record_wz
end type
type tv_canc from treeview within w_cancella_record_wz
end type
type dw_controllo_riga from datawindow within w_cancella_record_wz
end type
type dw_controllo_scadenza from datawindow within w_cancella_record_wz
end type
type st_canc_in_corso from statictext within w_cancella_record_wz
end type
end forward

global type w_cancella_record_wz from w_wiz_main
int X=832
int Y=356
int Width=2482
int Height=1316
WindowType WindowType=response!
boolean Visible=false
boolean TitleBar=true
string Title="Cancellazione documento"
event ue_set_property ( )
event type integer ue_uscita ( string as_motivo )
dw_controllo_con_riga dw_controllo_con_riga
p_msg_log p_msg_log
st_controlla_documento st_controlla_documento
cb_uscire cb_uscire
cb_anulla cb_anulla
cb_ok cb_ok
dw_cancella_record_lt dw_cancella_record_lt
tv_canc tv_canc
dw_controllo_riga dw_controllo_riga
dw_controllo_scadenza dw_controllo_scadenza
st_canc_in_corso st_canc_in_corso
end type
global w_cancella_record_wz w_cancella_record_wz

type variables
datastore		ids_cd

long		il_handle

uo_msg_log	iuo_msg_log

s_par_record	istr_par_record

string		is_title = ""
string		is_message_error = ""

boolean		ib_recurse_ok = true
end variables

forward prototypes
public subroutine wf_string2array (string as_string, ref string aa_array[])
public function string wf_split_id_tabella (string as_tabella)
public subroutine wf_populate_tv (string as_tabella_db, long al_handle)
public subroutine wf_insert_row_ds (string as_tabella, string as_id_tabella1, long al_id1, string as_id_tabella2, long al_id2, string as_id_tabella3, long al_id3, integer ai_priorita)
public subroutine wf_prepare_trova_id (string as_tabella_db, long al_id, ref long al_array_id[])
public function integer wf_recurse_record (string as_tabella_db, long al_id, string as_tabella_padre, long al_id_padre, integer ai_priorita)
public function integer wf_uscita ()
public function long wf_controlla_lotto (long al_id_riga_documento)
public subroutine wf_cancella_lotto (integer al_id_riga_lotto, integer al_id_doc)
end prototypes

event ue_set_property;call super::ue_set_property;

end event

event ue_uscita;call super::ue_uscita;
if istr_par_record.visible = true then		
	This.cb_uscire.Visible = True
	This.cb_uscire.Text = "Non è possibile cancellare il record. Clic per uscire."
	
	This.dw_cancella_record_lt.Enabled = False
	This.tv_canc.Enabled = False
	This.cb_uscire.SetFocus()
	iuo_msg_log.uf_new_text("Non cancellabile.~rUscire.", 0)
else
	MessageBox( "Attenzione !!!",as_motivo ,StopSign! )
end if	

return 0
end event

public subroutine wf_string2array (string as_string, ref string aa_array[]);

long		ll_pos, ll_i
string	ls_string


ls_string = as_string
ll_i = 1
DO WHILE pos(ls_string, ",") > 0
	ll_pos = pos(ls_string, ",")
	if ll_pos > 0 AND Not IsNull(ll_pos) then
		aa_array[ll_i] = trim(left(ls_string, ll_pos - 1))
		ls_string = trim(right(ls_string, len(ls_string) - ll_pos))
	end if
	ll_i ++
LOOP
aa_array[ll_i] = ls_string
end subroutine

public function string wf_split_id_tabella (string as_tabella);
string	ls_id_tabella, ls_id_foreign, ls_string[]
long		ll_row, ll_i

ll_row = This.dw_cancella_record_lt.Find("tabella = '" + as_tabella + &
			"'", 1, This.dw_cancella_record_lt.RowCount())
if ll_row > 0 then
	ls_id_tabella = This.dw_cancella_record_lt.GetItemString(ll_row, "id_tabella")
	ls_id_foreign = This.dw_cancella_record_lt.GetItemString(ll_row, "id_foreign")
	
	wf_string2array(ls_id_tabella, ls_string[])
	
	if UpperBound(ls_string) > 1 then
		for ll_i = 1 to UpperBound(ls_string)
			if ls_string[ll_i] <> ls_id_foreign then
				ls_id_tabella = ls_string[ll_i]
			end if
		next
	end if
else
	MessageBox("Attenzione (wf_split_id_tabella)", "Non trovo la tabella <" + as_tabella +">.")
	ls_id_tabella = ""
end if
Return ls_id_tabella
end function

public subroutine wf_populate_tv (string as_tabella_db, long al_handle);

TreeViewItem	ltvi_Current
long  			ll_row, ll_rows, ll_handle, ll_i = 1, ll_level
string			ls_tabella, ls_nome_tabella

ll_rows = This.dw_cancella_record_lt.RowCount()

ll_row = This.dw_cancella_record_lt.Find("tabella = '" + as_tabella_db + "'", 1, ll_rows)
ls_nome_tabella = This.dw_cancella_record_lt.GetItemString(ll_row, "nome_tabella")
if al_handle = 0 then
	ll_handle = tv_canc.InsertItemLast(0, ls_nome_tabella, 1)
else
	tv_canc.GetItem(al_handle, ltvi_Current)
	ll_level = ltvi_Current.Level
	ll_handle = tv_canc.InsertItemLast(al_handle, ls_nome_tabella, ll_level + 1)
end if

if ll_handle = -1 then
	MessageBox("Avviso", "Errore durante inserimento voci nella TreeView")
	Return
end if

for ll_row = 1 to ll_rows
	ll_row = This.dw_cancella_record_lt.Find("padre = '" + as_tabella_db + "'", ll_row, ll_rows)
	if ll_row > 0 then
		ls_tabella = This.dw_cancella_record_lt.GetItemString(ll_row, "tabella")
		wf_populate_tv(ls_tabella, ll_handle)
	else
		ll_row = ll_rows
	end if
next
Return


end subroutine

public subroutine wf_insert_row_ds (string as_tabella, string as_id_tabella1, long al_id1, string as_id_tabella2, long al_id2, string as_id_tabella3, long al_id3, integer ai_priorita);

long 		ll_row, ll_row_dw
string	ls_id_foreign

ids_cd.InsertRow(0)
ll_row = ids_cd.RowCount()
ids_cd.SetItem(ll_row, "tabella", as_tabella)
ids_cd.SetItem(ll_row, "id_tabella", as_id_tabella1)
ids_cd.SetItem(ll_row, "id_foreign", as_id_tabella2)
ids_cd.SetItem(ll_row, "padre", as_id_tabella3)
ids_cd.SetItem(ll_row, "id_1", al_id1)
ids_cd.SetItem(ll_row, "id_2", al_id2)
ids_cd.SetItem(ll_row, "id_3", al_id3)
ids_cd.SetItem(ll_row, "priorita", ai_priorita)
end subroutine

public subroutine wf_prepare_trova_id (string as_tabella_db, long al_id, ref long al_array_id[]);

long			ll_row, ll_i
string		ls_tabella, ls_id_foreign, ls_id_ritorno, ls_id
long 			ll_id1[]
string		ls_string[]

ll_row = This.dw_cancella_record_lt.Find("tabella = '" + as_tabella_db + "'", 1, This.dw_cancella_record_lt.RowCount())
if ll_row > 0 then
	ls_tabella = This.dw_cancella_record_lt.GetItemString(ll_row, "tabella")
	ls_id_ritorno = wf_split_id_tabella(ls_tabella)
	ls_id_foreign = This.dw_cancella_record_lt.GetItemString(ll_row, "id_foreign")
	
	f_trova_id(ls_tabella, ls_id_ritorno, ls_id_foreign, al_id, ll_id1[])
	al_array_id = ll_id1
else
	
	MessageBox("Attenzione (wf_prepare_trova_id)", "La tabella <" +as_tabella_db+ "> non esiste nella lista " + &
					"delle tabelle previste per questa elaborazione.")
	Return
end if
end subroutine

public function integer wf_recurse_record (string as_tabella_db, long al_id, string as_tabella_padre, long al_id_padre, integer ai_priorita);

long			ll_rows, ll_row, ll_row_ds, ll_i, ll_j, ll_aux1, ll_aux2
string		ls_id, ls_tabella, ls_id_tabella, ls_id_foreign, ls_sn
long 			ll_id[], ll_id_doc
string 		ls_figlia[], ls_figlia_null[]
integer		li_priorita

li_priorita	= ai_priorita
li_priorita++

ll_rows = This.dw_cancella_record_lt.RowCount()

ls_figlia = ls_figlia_null
ll_i = 1

as_tabella_db = lower(as_tabella_db)
for ll_row = 1 to ll_rows
	ll_row = This.dw_cancella_record_lt.Find("padre = '" + as_tabella_db + "'", ll_row, ll_rows)
	if ll_row > 0 then
		ls_figlia[ll_i] = This.dw_cancella_record_lt.GetItemString(ll_row, "tabella")
		ll_i ++
	else
		ll_row = ll_rows
	end if
next

if UpperBound(ls_figlia) > 0 then
	for ll_i = 1 to UpperBound(ls_figlia)
		ll_row = This.dw_cancella_record_lt.Find("tabella = '" + ls_figlia[ll_i] + &
				"'", 1, ll_rows)
		
		
		ll_aux2=al_id
		if ls_figlia[ll_i]="riga_doc_lotto" then
			
			
			select id_documento
			into :ll_id_doc
			from riga_documento
			where riga_documento.id_riga_documento=:al_id;
			ll_aux1=wf_controlla_lotto(al_id)
			if ll_aux1<0 then
				is_message_error='Impossibile cancellare! Esistono scarichi collegati al documento!'
				wf_uscita()
				ib_recurse_ok	= false
			elseif ll_aux1>0 then
				al_id=ll_aux1
			end if
		end if
		wf_prepare_trova_id(ls_figlia[ll_i], al_id, ll_id[])
		if UpperBound(ll_id) > 0 then
			for ll_j = 1 to UpperBound(ll_id)
				
				
				wf_recurse_record(ls_figlia[ll_i], ll_id[ll_j], as_tabella_db, al_id,li_priorita)
				
				
				This.dw_cancella_record_lt.SetItem(ll_row, "num_righe", UpperBound(ll_id))
				This.dw_cancella_record_lt.SetItem(ll_row, "priorita", li_priorita)
				This.dw_cancella_record_lt.SetItem(ll_row, "visibile", "1")
				ls_id_foreign = This.dw_cancella_record_lt.GetItemString(ll_row, "id_foreign")
				ls_id_tabella = wf_split_id_tabella(ls_figlia[ll_i])				
				
				
				if ls_figlia[ll_i]="riga_doc_lotto" then
					wf_insert_row_ds(ls_figlia[ll_i], ls_id_tabella, ll_id[ll_j], ls_id_foreign, ll_id_doc, "", 0,li_priorita)
				else
					wf_insert_row_ds(ls_figlia[ll_i], ls_id_tabella, ll_id[ll_j], ls_id_foreign, al_id, "", 0,li_priorita)
				end if
			next
		end if
		al_id=ll_aux2
		
		if This.dw_cancella_record_lt.GetItemString(ll_row, "controllo") = "S" then

			ls_sn = this.dw_cancella_record_lt.Event ue_controlla_children(ls_figlia[ll_i], al_id)
			if ls_sn = "N" then
				
				wf_uscita()
				ib_recurse_ok	= false
				
			end if
		
		end if
	next
end if

Return 0
end function

public function integer wf_uscita ();
if istr_par_record.visible = true then		
	This.cb_uscire.Visible = True
	This.cb_uscire.Text = "Non è possibile cancellare il record. Clic per uscire."
	
	This.dw_cancella_record_lt.Enabled = False
	This.tv_canc.Enabled = False
	This.cb_uscire.SetFocus()
	iuo_msg_log.uf_new_text("Non cancellabile.~rUscire.", 0)
else
	MessageBox( "Warning !!!",is_message_error,StopSign! )
end if	
return 0
end function

public function long wf_controlla_lotto (long al_id_riga_documento);long ll_id_riga_lotto, ll_id_lotto, ll_altro_id, ll_id_caus_mag, ll_id_art
char lc_car
decimal ld_val

select id_riga_lotto, id_caus_magazzino, id_articolo
into :ll_id_riga_lotto, :ll_id_caus_mag, :ll_id_art
from riga_documento
where riga_documento.id_riga_documento=:al_id_riga_documento;

if (ll_id_caus_mag = 0 or isnull(ll_id_caus_mag)) then
	return 0
else 
	select gestisce_lotti
	into :lc_car
	from caus_magazzino
	where caus_magazzino.id_caus_magazzino=:ll_id_caus_mag;
	if sqlca.sqlcode<>0 then return -1
end if

If lc_car<>"" then 
	if ll_id_riga_lotto>0 then
		
		select id_lotto
		into :ll_id_lotto
		from riga_doc_lotto
		where riga_doc_lotto.id_riga_lotto=:ll_id_riga_lotto;
		if sqlca.sqlcode<>0 then return -1
		
		if lc_car='C' then
			
			select id_riga_lotto
			into :ll_altro_id
			from riga_doc_lotto
			where (riga_doc_lotto.id_lotto=:ll_id_lotto)and(id_riga_lotto<>:ll_id_riga_lotto);
			
			if ll_altro_id > 0 then
				return -1
			else
				return ll_id_riga_lotto
			end if
		end if
	
		if lc_car='A' then
			
			select valore_scarico
			into :ld_val
			from riga_doc_lotto
			where (riga_doc_lotto.id_riga_lotto=:ll_id_riga_lotto);
			
			if ld_val = 0 then
				return -1
			else
				return ll_id_riga_lotto
			end if
		end if
	
	
		if lc_car='S' or lc_car='R' then return ll_id_riga_lotto
	
	elseif IsNull(ll_id_art) then
		
		return 0
	else
		return -1
	end if
else
	return 0
end if

end function

public subroutine wf_cancella_lotto (integer al_id_riga_lotto, integer al_id_doc);long ll_id_caus_mag, ll_id_lotto, ll_id_doc
char lc_gest, lc_tipo
decimal ld_qta1, ld_qta2
decimal ld_peso_netto_scaricato 
long    ll_id_articolo
char    lc_tipo_ges_lotti
string  ls_tipo_mov

SELECT tipo_ges_lotti
INTO	 :lc_tipo_ges_lotti
FROM	 pers_par_sistema
;

select id_caus_magazzino
into :ll_id_caus_mag
from riga_documento
where (riga_documento.id_riga_lotto=:al_id_riga_lotto)and(riga_documento.id_documento=:al_id_doc);
if sqlca.sqlcode<>0 then return

select gestisce_lotti
into :lc_gest
from caus_magazzino
where caus_magazzino.id_caus_magazzino=:ll_id_caus_mag;

if al_id_riga_lotto>0 then
	select id_lotto, valore_scarico, id_doc
	into :ll_id_lotto, :ld_qta1, :ll_id_doc
	from riga_doc_lotto
	where riga_doc_lotto.id_riga_lotto=:al_id_riga_lotto;

	if lc_gest='C' then
		
		delete from lotto
		where lotto.id_lotto=:ll_id_lotto;
	end if
	
	if lc_gest='S' then
		
		
		select qta_scaricata, peso_netto_scaricato, id_articolo
		into :ld_qta2, :ld_peso_netto_scaricato, :ll_id_articolo
		from lotto
		where lotto.id_lotto=:ll_id_lotto
		;

		if (lc_tipo_ges_lotti = 'G') then
			SELECT m.tipo
			INTO	 :ls_tipo_mov
			FROM	 unita_confezione u, unita_misura m
			WHERE  u.id_articolo = :ll_id_articolo
			AND	 u.unita_base = 'S'
			AND	 m.id_unita_misura = u.id_unita_misura
			;
			
			if (ls_tipo_mov = 'P') then
				ld_qta1 = ld_peso_netto_scaricato - ld_qta1
				
				update lotto
				set peso_netto_scaricato = :ld_qta1 
				where lotto.id_lotto=:ll_id_lotto;
			else
				ld_qta1= ld_qta2 - ld_qta1
				
				update lotto
				set qta_scaricata = :ld_qta1
				where lotto.id_lotto=:ll_id_lotto;
			end if
		else
		
			ld_qta1= ld_qta2 - ld_qta1
			
			update lotto
			set qta_scaricata = :ld_qta1
			where lotto.id_lotto=:ll_id_lotto;
		end if
	end if
		
	if lc_gest='A' then
		
			
		select tipo_lotto 
		into :lc_tipo
		from lotto
		where lotto.id_lotto=:ll_id_lotto;
		choose case lc_tipo
			case 'Y'
				lc_tipo='S'
			case 'X'
				lc_tipo='P'
		end choose
		update lotto
		set tipo_lotto=:lc_tipo, qta_scaricata=0
		where lotto.id_lotto=:ll_id_lotto;
			
		delete from riga_doc_lotto
		where riga_doc_lotto.id_riga_lotto=:al_id_riga_lotto;
	end if
	
	if lc_gest='R' then
		
			
		select tipo_lotto , qta_iniziale
		into :lc_tipo, :ld_qta1
		from lotto
		where lotto.id_lotto=:ll_id_lotto;
		choose case lc_tipo
			case 'Z'
				lc_tipo='X'
			case 'K'
				lc_tipo='Y'
		end choose
		update lotto
		set tipo_lotto=:lc_tipo, qta_scaricata=:ld_qta1
		where lotto.id_lotto=:ll_id_lotto;
			
		select quantita
		into :ld_qta1
		from riga_documento
		where (riga_documento.id_documento=:ll_id_doc)and(riga_documento.id_riga_lotto=:al_id_riga_lotto);
		update riga_doc_lotto
		set valore_scarico=:ld_qta1
		where riga_doc_lotto.id_riga_lotto=:al_id_riga_lotto;
	end if
end if

end subroutine

on w_cancella_record_wz.create
int iCurrent
call super::create
this.dw_controllo_con_riga=create dw_controllo_con_riga
this.p_msg_log=create p_msg_log
this.st_controlla_documento=create st_controlla_documento
this.cb_uscire=create cb_uscire
this.cb_anulla=create cb_anulla
this.cb_ok=create cb_ok
this.dw_cancella_record_lt=create dw_cancella_record_lt
this.tv_canc=create tv_canc
this.dw_controllo_riga=create dw_controllo_riga
this.dw_controllo_scadenza=create dw_controllo_scadenza
this.st_canc_in_corso=create st_canc_in_corso
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_controllo_con_riga
this.Control[iCurrent+2]=this.p_msg_log
this.Control[iCurrent+3]=this.st_controlla_documento
this.Control[iCurrent+4]=this.cb_uscire
this.Control[iCurrent+5]=this.cb_anulla
this.Control[iCurrent+6]=this.cb_ok
this.Control[iCurrent+7]=this.dw_cancella_record_lt
this.Control[iCurrent+8]=this.tv_canc
this.Control[iCurrent+9]=this.dw_controllo_riga

this.Control[iCurrent+10]=this.dw_controllo_scadenza
this.Control[iCurrent+11]=this.st_canc_in_corso
end on

on w_cancella_record_wz.destroy
call super::destroy
destroy(this.dw_controllo_con_riga)
destroy(this.p_msg_log)
destroy(this.st_controlla_documento)
destroy(this.cb_uscire)
destroy(this.cb_anulla)
destroy(this.cb_ok)
destroy(this.dw_cancella_record_lt)
destroy(this.tv_canc)
destroy(this.dw_controllo_riga)
destroy(this.dw_controllo_scadenza)
destroy(this.st_canc_in_corso)
end on

event open;call super::open;
long			ll_row, ll_tvi
string		ls_message, ls_SN
string		ls_args[]

istr_par_record	= Message.PowerObjectParm

iuo_msg_log = create uo_msg_log
iuo_msg_log.uf_new_text("Sessione del " + String(Today()) + " - " + String(Now()),2)

This.dw_cancella_record_lt.Event ue_insert_table()

TriggerEvent("ue_set_property")
this.title	= is_title


ls_args[1] = istr_par_record.nome_tabella
ls_args[2] = istr_par_record.nome_id_tabella
ls_args[3] = string(istr_par_record.id_tabella)
ls_args[4] = ""
ls_args[5] = ""
ls_args[6] = ""
ls_args[7] = ""

if this.dw_cancella_record_lt.Event ue_controlla_master() = "N" then
	wf_uscita()	
	CloseWithReturn(this,0)
	return 0
end if

ids_cd = CREATE datastore
if Not IsValid(ids_cd) then
	MessageBox("Errore Critico", "Impossibile creare DataStore per cancellazione.")
	Return
else
	ids_cd.DataObject = 'd_cancella_record_lt'	
end if

ll_row = This.dw_cancella_record_lt.Find("tabella = '" + ls_args[1] + &
			"'", 1, This.dw_cancella_record_lt.RowCount())		
			
if ll_row > 0 then
	
	wf_recurse_record(istr_par_record.nome_tabella,istr_par_record.id_tabella, "", 0, 0)
	
	if ib_recurse_ok = false then
		CloseWithReturn(this,0)
		return 0		
	end if
	
	This.dw_cancella_record_lt.SetItem(ll_row, "num_righe", 1)
	This.dw_cancella_record_lt.SetItem(ll_row, "priorita", 0)
	This.dw_cancella_record_lt.SetItem(ll_row, "visibile", "1")

	wf_insert_row_ds(ls_args[1],ls_args[2],long(ls_args[3]),ls_args[4],long(ls_args[5]),ls_args[6],long(ls_args[7]),0)

	This.dw_cancella_record_lt.SetFilter("visibile = '1'")
	This.dw_cancella_record_lt.Filter()

	This.wf_populate_tv(ls_args[1], 0)
	ll_tvi = This.tv_canc.FindItem(RootTreeItem! , 0)
	This.tv_canc.ExpandAll(ll_tvi)
	
	iuo_msg_log.uf_new_text("Per cancellare le righe solo da una tabella - spostare la tabella nel cestino.", 3)
	tv_canc.SetFocus()
end if


if istr_par_record.visible = true then
	this.visible = true
else	
	cb_ok.triggerevent ("clicked")
end if	



end event

type dw_controllo_con_riga from datawindow within w_cancella_record_wz
event clicked pbm_dwnlbuttonclk
int X=37
int Y=380
int Width=2368
int Height=436
int TabOrder=60
boolean Visible=false
boolean TitleBar=true
BorderStyle BorderStyle=StyleShadowBox!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event clicked;This.setFocus()
end event

type p_msg_log from picture within w_cancella_record_wz
int X=64
int Y=180
int Width=105
int Height=80
string PictureName="s:\pb\commonframework\info_in.bmp"
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
boolean FocusRectangle=false
end type

event clicked;
integer li_in

li_in=iuo_msg_log.uf_manage_msg()
parent.SetFocus()

end event

type st_controlla_documento from statictext within w_cancella_record_wz
int X=517
int Y=480
int Width=1477
int Height=320
boolean Visible=false
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=79741120
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_uscire from commandbutton within w_cancella_record_wz
int X=37
int Y=36
int Width=2368
int Height=84
int TabOrder=80
boolean Visible=false
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if IsValid(ids_cd) then
	destroy ids_cd
end if
CloseWithReturn(Parent, 0)

end event

type cb_anulla from commandbutton within w_cancella_record_wz
int X=2048
int Y=36
int Width=352
int Height=84
int TabOrder=20
string Text="Annulla"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if IsValid(ids_cd) then
	destroy ids_cd
end if
CloseWithReturn(Parent, 0)
return 0

end event

type cb_ok from commandbutton within w_cancella_record_wz
int X=37
int Y=36
int Width=352
int Height=84
int TabOrder=10
string Text="OK"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
long		ll_rows, ll_i, ll_id_1, ll_id_2, ll_id_3,ll_ret
string	ls_tabella, ls_id_1, ls_id_2, ls_id_3
string	ls_sqlstatement
integer	li_ret, i
s_dberr	lstr_dberr
window	lw_err

pointer  lp_oldpointer  

ids_cd.Sort()
ll_rows = ids_cd.RowCount()
if ll_rows > 0 then
	ids_cd.Sort()
	
	li_ret	= MessageBox("Attenzione - ultimo avviso", "Si sta per cancellare " + &
					string(ll_rows) + " righe. Confermi?", Question!, YesNo!,1)
					
	if li_ret = 1 then
				if isvalid(istr_par_record.s_dw_aper_partita) then
					i=istr_par_record.s_dw_scar_partita.update()
					if i<>1 then 
						messagebox("Attenzione!", "Partite scarico collegate non salvate: operazione annullata")
						if IsValid(ids_cd) then
							destroy ids_cd
						end if
						CloseWithReturn(Parent, 0)
					end if
				
					i=istr_par_record.s_dw_aper_partita.update()
					if i<>1 then 
						messagebox("Attenzione!", "Partite APERTURA collegate non salvate: operazione annullata")
						if IsValid(ids_cd) then
							destroy ids_cd
						end if
						CloseWithReturn(Parent, 0)
					end if
				end if
			
			
		lp_oldpointer = SetPointer(HourGlass!)

		if istr_par_record.visible = false then
			parent.x		 						= 1130
			parent.y							 	= 1000
			parent.height 						= 300
			parent.width	 					= 1300
			cb_anulla.visible					= false
			cb_ok.visible						= false
			cb_uscire.visible					= false
			dw_cancella_record_lt.visible	= false
			dw_controllo_con_riga.visible	= false
			dw_controllo_riga.visible		= false
			dw_controllo_scadenza.visible	= false
			p_msg_log.visible					= false
			tv_canc.visible					= false
			st_controlla_documento.visible = false
			parent.visible					 	= true
			st_canc_in_corso.visible 		= true
		end if	

		for ll_i = 1 to ll_rows
			
			if ll_ret = 0 then
				ls_tabella 	= ids_cd.GetItemString(ll_i, "tabella")
				ls_id_1	 	= ids_cd.GetItemString(ll_i, "id_tabella")
				ls_id_2 		= ids_cd.GetItemString(ll_i, "id_foreign")
				ls_id_3 		= ids_cd.GetItemString(ll_i, "padre")
				ll_id_1 		= ids_cd.GetItemNumber(ll_i, "id_1")
				ll_id_2 		= ids_cd.GetItemNumber(ll_i, "id_2")
				ll_id_3 		= ids_cd.GetItemNumber(ll_i, "id_3")
				
				

				ls_sqlstatement = "DELETE FROM " + ls_tabella + " WHERE ( " + ls_tabella + "." + ls_id_1 + "=?"
				
				if ll_id_2 > 0 then
					ls_sqlstatement	= ls_sqlstatement + " AND " + ls_tabella + "." + ls_id_2 + "=?"
				end if
				
				if ll_id_3 > 0 then
					ls_sqlstatement	= ls_sqlstatement + " AND " + ls_tabella + "." + ls_id_3 + "=?"
				end if
					ls_sqlstatement	= ls_sqlstatement + " )"

				prepare SQLSA from :ls_sqlstatement ;

				if sqlca.sqlcode = -1 then
					lstr_dberr.l_sqlcode 	= sqlca.sqlcode
					lstr_dberr.s_sqlerrtext = sqlca.sqlerrtext
					OpenWithParm(lw_err,lstr_dberr,"w_db_err")
					ll_ret = -1
				end if
			
			
				if sqlca.sqlcode = 0 then
					if ll_id_1 > 0 and ll_id_2 = 0 and ll_id_3 = 0 then
						execute SQLSA using :ll_id_1;
					end if	
		
					if ll_id_2 > 0 and ll_id_3 = 0 then
						execute SQLSA using :ll_id_1, :ll_id_2 ;
					end if
				
					if ll_id_3 > 0 then
						execute SQLSA using :ll_id_1, :ll_id_2, :ll_id_3 ;
					end if
		
					if sqlca.sqlcode = -1 then
						lstr_dberr.l_sqlcode 	= sqlca.sqlcode
						lstr_dberr.s_sqlerrtext = sqlca.sqlerrtext
						OpenWithParm(lw_err,lstr_dberr,"w_db_err")
						ll_ret = -1
					end if	
				
				end if
			end if
		next

		if ll_ret = 0 then
			commit using SQLCA;
		else
			rollback using SQLCA;
		end if
		
		if sqlca.sqlcode = -1 then
			lstr_dberr.l_sqlcode 	= sqlca.sqlcode
			lstr_dberr.s_sqlerrtext = sqlca.sqlerrtext
			OpenWithParm(lw_err,lstr_dberr,"w_db_err")
		end if	

		SetPointer(lp_oldpointer)
		CloseWithReturn(Parent, 1)
	else	
		if IsValid(ids_cd) then
			destroy ids_cd
		end if
		CloseWithReturn(Parent, 0)
	end if
	
else
	
	if IsValid(ids_cd) then
		destroy ids_cd
	end if
	CloseWithReturn(Parent, 0)
end if
end event

type dw_cancella_record_lt from datawindow within w_cancella_record_wz
event ue_insert_table ( )
event type string ue_controlla_master ( )
event type string ue_controlla_children ( string as_figlia,  long al_id )
int X=37
int Y=160
int Width=1317
int Height=1020
int TabOrder=30
string DataObject="d_cancella_record_lt"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event ue_insert_table;



long	ll_row

if This.RowCount() = 0 then
	
	ll_row = This.InsertRow(0)
	
	This.SetItem(ll_row, "nome_tabella", "Documento")
	
	This.SetItem(ll_row, "tabella", "documento")
	
	This.SetItem(ll_row, "id_tabella", "id_documento")
	
	This.SetItem(ll_row, "id_foreign", "id_documento")
	
	This.SetItem(ll_row, "padre", "")
	
	This.SetItem(ll_row, "controllo", "N")
	
	This.SetItem(ll_row, "ordinamento", 100)
	
	ll_row = This.InsertRow(0)
	This.SetItem(ll_row, "nome_tabella", "Packing List")
	This.SetItem(ll_row, "tabella", "elem_pac_list")
	This.SetItem(ll_row, "id_tabella", "id_elem_pac_list")
	This.SetItem(ll_row, "id_foreign", "id_documento")
	This.SetItem(ll_row, "padre", "documento")
	This.SetItem(ll_row, "controllo", "N")
	This.SetItem(ll_row, "ordinamento", 50)
	
	ll_row = This.InsertRow(0)
	This.SetItem(ll_row, "nome_tabella", "Castelletto Agenti")
	This.SetItem(ll_row, "tabella", "riep_provvigioni")
	This.SetItem(ll_row, "id_tabella", "id_riep_provvigioni")
	This.SetItem(ll_row, "id_foreign", "id_documento")
	This.SetItem(ll_row, "padre", "documento")
	This.SetItem(ll_row, "controllo", "N")
	This.SetItem(ll_row, "ordinamento", 50)
	
	
	ll_row = This.InsertRow(0)
	This.SetItem(ll_row, "nome_tabella", "PostIt Documento")
	This.SetItem(ll_row, "tabella", "evid_documento")
	This.SetItem(ll_row, "id_tabella", "id_documento")
	This.SetItem(ll_row, "id_foreign", "id_documento")
	This.SetItem(ll_row, "padre", "documento")
	This.SetItem(ll_row, "controllo", "N")
	This.SetItem(ll_row, "ordinamento", 50)
	
	ll_row = This.InsertRow(0)
	This.SetItem(ll_row, "nome_tabella", "Spesa Documento")
	This.SetItem(ll_row, "tabella", "spesa_documento")
	This.SetItem(ll_row, "id_tabella", "id_documento, id_spesa")
	This.SetItem(ll_row, "id_foreign", "id_documento")
	This.SetItem(ll_row, "padre", "documento")
	This.SetItem(ll_row, "controllo", "N")
	This.SetItem(ll_row, "ordinamento", 50)
	
	ll_row = This.InsertRow(0)
	This.SetItem(ll_row, "nome_tabella", "Riga del Documento")
	This.SetItem(ll_row, "tabella", "riga_documento")
	This.SetItem(ll_row, "id_tabella", "id_riga_documento")
	This.SetItem(ll_row, "id_foreign", "id_documento")
	This.SetItem(ll_row, "padre", "documento")
	This.SetItem(ll_row, "controllo", "S")
	This.SetItem(ll_row, "ordinamento", 50)
	
	ll_row = This.InsertRow(0)
	This.SetItem(ll_row, "nome_tabella", "Castelletto IVA Documento")
	This.SetItem(ll_row, "tabella", "cast_iva_documento")
	This.SetItem(ll_row, "id_tabella", "id_documento, id_tab_iva")
	This.SetItem(ll_row, "id_foreign", "id_documento")
	This.SetItem(ll_row, "padre", "documento")
	This.SetItem(ll_row, "controllo", "N")
	This.SetItem(ll_row, "ordinamento", 50)
	
	ll_row = This.InsertRow(0)
	This.SetItem(ll_row, "nome_tabella", "Scadenza")
	This.SetItem(ll_row, "tabella", "scadenza")
	This.SetItem(ll_row, "id_tabella", "id_scadenza")
	This.SetItem(ll_row, "id_foreign", "id_documento")
	This.SetItem(ll_row, "padre", "documento")
   This.SetItem(ll_row, "controllo", "S")
	This.SetItem(ll_row, "ordinamento", 50)
	
	ll_row = This.InsertRow(0)
	This.SetItem(ll_row, "nome_tabella", "Riga Lettera Avviso Scadenza")
	This.SetItem(ll_row, "tabella", "riga_let_scadenza")
	This.SetItem(ll_row, "id_tabella", "id_scadenza, id_let_scadenza")
	This.SetItem(ll_row, "id_foreign", "id_scadenza")
	This.SetItem(ll_row, "padre", "scadenza")
	This.SetItem(ll_row, "controllo", "N")
	This.SetItem(ll_row, "ordinamento", 25)
	
	ll_row = This.InsertRow(0)
	This.SetItem(ll_row, "nome_tabella", "Movimenti di Scadenza")
	This.SetItem(ll_row, "tabella", "mov_scadenza")
	This.SetItem(ll_row, "id_tabella", "id_mov_scadenza")
	This.SetItem(ll_row, "id_foreign", "id_scadenza")
	This.SetItem(ll_row, "padre", "scadenza")
	This.SetItem(ll_row, "controllo", "N")
	This.SetItem(ll_row, "ordinamento", 25)
	
	ll_row = This.InsertRow(0)
	This.SetItem(ll_row, "nome_tabella", "Castelletto Contropartite Documento")
	This.SetItem(ll_row, "tabella", "cast_cpt_documento")
	This.SetItem(ll_row, "id_tabella", "id_documento, id_conto")
	This.SetItem(ll_row, "id_foreign", "id_documento")
	This.SetItem(ll_row, "padre", "documento")
	This.SetItem(ll_row, "controllo", "N")
	This.SetItem(ll_row, "ordinamento", 50)
		
	
	
	
	
	
	ll_row = This.InsertRow(0)
	This.SetItem(ll_row, "nome_tabella", "Righe Doc-Lotto")
	This.SetItem(ll_row, "tabella", "riga_doc_lotto")
	This.SetItem(ll_row, "id_tabella", "id_riga_lotto")
	This.SetItem(ll_row, "id_foreign", "id_riga_lotto")
	This.SetItem(ll_row, "padre", "riga_documento")
	This.SetItem(ll_row, "controllo", "S")
	This.SetItem(ll_row, "ordinamento", 25)
	
end if

end event

type tv_canc from treeview within w_cancella_record_wz
int X=1408
int Y=160
int Width=997
int Height=1020
int TabOrder=50
BorderStyle BorderStyle=StyleLowered!
boolean DisableDragDrop=false
boolean LinesAtRoot=true
string PictureName[]={"Cascade!",&
"Horizontal!",&
"Tile!",&
"Layer!",&
"S:\PB\CommonFrameWork\genappl.bmp"}
long PictureMaskColor=553648127
long StatePictureMaskColor=553648127
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event selectionchanged;treeviewitem l_tvi 

This.GetItem(newhandle, l_tvi)

end event

type dw_controllo_riga from datawindow within w_cancella_record_wz
int X=37
int Y=500
int Width=2368
int Height=436
int TabOrder=70
boolean Visible=false
boolean BringToTop=true
boolean TitleBar=true
BorderStyle BorderStyle=StyleShadowBox!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event getfocus;Beep(10)
end event

type dw_controllo_scadenza from datawindow within w_cancella_record_wz
int X=37
int Y=620
int Width=2368
int Height=436
int TabOrder=40
boolean Visible=false
boolean BringToTop=true
boolean TitleBar=true
BorderStyle BorderStyle=StyleShadowBox!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event clicked;This.setFocus()
end event

type st_canc_in_corso from statictext within w_cancella_record_wz
int X=37
int Y=60
int Width=1024
int Height=160
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
string Text="Cancellazione in corso..."
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=79741120
int TextSize=-12
int Weight=700
string FaceName="Arial"
boolean Italic=true
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

