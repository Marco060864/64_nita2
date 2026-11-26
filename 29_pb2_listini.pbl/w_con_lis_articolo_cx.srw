forward
global type w_con_lis_articolo_cx from w_p_data
end type
type dw_con_lis_articolo_cond_ff from u_dw_master_main within tabpage_1
end type
type dw_con_lis_articolo_cond_ff from u_dw_master_main within tabpage_1
end type
type tabpage_3 from userobject within tab_1
end type
type dw_con_lis_articolo_cond_art_ff from u_dw_master_main within tabpage_3
end type
type tabpage_4 from userobject within tab_1
end type
type dw_con_lis_articolo_cond_altro_ff from u_dw_master_main within tabpage_4
end type
type tabpage_2 from userobject within tab_1
end type
type dw_con_lis_articolo_appl_ff from u_dw_master_main within tabpage_2
end type
type cb_1 from commandbutton within w_con_lis_articolo_cx
end type
type tabpage_3 from userobject within tab_1
dw_con_lis_articolo_cond_art_ff dw_con_lis_articolo_cond_art_ff
end type
type tabpage_4 from userobject within tab_1
dw_con_lis_articolo_cond_altro_ff dw_con_lis_articolo_cond_altro_ff
end type
type tabpage_2 from userobject within tab_1
dw_con_lis_articolo_appl_ff dw_con_lis_articolo_appl_ff
end type
end forward

global type w_con_lis_articolo_cx from w_p_data
int X=430
int Width=2706
int Height=1320
WindowType WindowType=main!
boolean TitleBar=true
string Title="Condizioni Listini"
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
cb_1 cb_1
end type
global w_con_lis_articolo_cx w_con_lis_articolo_cx

type variables
window iw_con_lis_art
string			is_old_dwo_name
long il_id
long a=0
end variables

forward prototypes
private function integer wf_post_itemchanged (readonly long row)
public subroutine wf_abilita_campi (string tipo)
public function string uf_sqlcond_ricerca ()
end prototypes

private function integer wf_post_itemchanged (readonly long row);tab_1.tabpage_1.dw_con_lis_articolo_cond_ff.setitem(row,"id_art_a", tab_1.tabpage_1.dw_con_lis_articolo_cond_ff.getitemnumber(row,"id_art_da") )

return 0
end function

public subroutine wf_abilita_campi (string tipo);CHOOSE CASE tipo
	CASE 'P'
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Modify('id_listino.BackGround.Color ='+ String(RGB( 255,255,255)))
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Object.id_listino.Edit.displayonly = 'NO'
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Modify('listino_descrizione.BackGround.Color ='+ String(RGB( 255,255,255)))
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Object.listino_descrizione.Edit.displayonly = 'NO'
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Modify('id_valuta.BackGround.Color ='+ String(RGB( 255,255,255)))
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Object.id_valuta.Edit.displayonly = 'NO'
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Modify('id_valuta_des.BackGround.Color ='+ String(RGB( 255,255,255)))
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Object.id_valuta_des.Edit.displayonly = 'NO'
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Modify('importo.BackGround.Color ='+ String(RGB( 255,255,255)))
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Object.importo.Edit.displayonly = 'NO'
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Modify('percentuali.BackGround.Color ='+ String(RGB( 255,255,255)))
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Object.percentuali.Edit.displayonly = 'NO'
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Modify('spesa.BackGround.Color ='+ String(RGB( 255,255,255)))
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Object.spesa.Edit.displayonly = 'NO'
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Modify('spesa_fissa.BackGround.Color ='+ String(RGB( 255,255,255)))
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Object.spesa_fissa.Edit.displayonly = 'NO'
	CASE 'I'
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Modify('id_listino.BackGround.Color ='+ String(RGB( 255,255,255)))
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Object.id_listino.Edit.displayonly = 'NO'
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Modify('listino_descrizione.BackGround.Color ='+ String(RGB( 255,255,255)))
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Object.listino_descrizione.Edit.displayonly = 'NO'
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Modify('id_valuta.BackGround.Color ='+ String(RGB( 255,255,255)))
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Object.id_valuta.Edit.displayonly = 'NO'
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Modify('id_valuta_des.BackGround.Color ='+ String(RGB( 255,255,255)))
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Object.id_valuta_des.Edit.displayonly = 'NO'
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Modify('importo.BackGround.Color ='+ String(RGB( 255,255,255)))
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Object.importo.Edit.displayonly = 'NO'
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Modify('percentuali.BackGround.Color ='+ String(RGB( 192,192,192)))
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Object.percentuali.Edit.displayonly = 'YES'
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Modify('spesa.BackGround.Color ='+ String(RGB( 255,255,255)))
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Object.spesa.Edit.displayonly = 'NO'
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Modify('spesa_fissa.BackGround.Color ='+ String(RGB( 255,255,255)))
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Object.spesa_fissa.Edit.displayonly = 'NO'	
	CASE 'C'
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Modify('id_listino.BackGround.Color ='+ String(RGB( 192,192,192)))
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Object.id_listino.Edit.displayonly = 'YES'
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Modify('listino_descrizione.BackGround.Color ='+ String(RGB( 192,192,192)))
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Object.listino_descrizione.Edit.displayonly = 'YES'		
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Modify('id_valuta.BackGround.Color ='+ String(RGB( 192,192,192)))
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Object.id_valuta.Edit.displayonly = 'YES'		
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Modify('id_valuta_des.BackGround.Color ='+ String(RGB( 192,192,192)))
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Object.id_valuta_des.Edit.displayonly = 'YES'		
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Modify('importo.BackGround.Color ='+ String(RGB( 192,192,192)))
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Object.importo.Edit.displayonly = 'YES'		
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Modify('percentuali.BackGround.Color ='+ String(RGB( 192,192,192)))
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Object.percentuali.Edit.displayonly = 'YES'		
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Modify('spesa.BackGround.Color ='+ String(RGB( 192,192,192)))
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Object.spesa.Edit.displayonly = 'YES'		
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Modify('spesa_fissa.BackGround.Color ='+ String(RGB( 192,192,192)))
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Object.spesa_fissa.Edit.displayonly = 'YES'
	CASE 'S'
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Modify('id_listino.BackGround.Color ='+ String(RGB( 192,192,192)))
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Object.id_listino.Edit.displayonly = 'YES'
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Modify('listino_descrizione.BackGround.Color ='+ String(RGB( 192,192,192)))
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Object.listino_descrizione.Edit.displayonly = 'YES'		
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Modify('id_valuta.BackGround.Color ='+ String(RGB( 192,192,192)))
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Object.id_valuta.Edit.displayonly = 'YES'		
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Modify('id_valuta_des.BackGround.Color ='+ String(RGB( 192,192,192)))
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Object.id_valuta_des.Edit.displayonly = 'YES'
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Modify('importo.BackGround.Color ='+ String(RGB( 192,192,192)))
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Object.importo.Edit.displayonly = 'YES'
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Modify('percentuali.BackGround.Color ='+ String(RGB( 255,255,255)))
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Object.percentuali.Edit.displayonly = 'NO'
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Modify('spesa.BackGround.Color ='+ String(RGB( 192,192,192)))
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Object.spesa.Edit.displayonly = 'YES'
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Modify('spesa_fissa.BackGround.Color ='+ String(RGB( 192,192,192)))
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Object.spesa_fissa.Edit.displayonly = 'YES'
	CASE 'R'
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Modify('id_listino.BackGround.Color ='+ String(RGB( 192,192,192)))
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Object.id_listino.Edit.displayonly = 'YES'
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Modify('listino_descrizione.BackGround.Color ='+ String(RGB( 192,192,192)))
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Object.listino_descrizione.Edit.displayonly = 'YES'
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Modify('id_valuta.BackGround.Color ='+ String(RGB( 255,255,255)))
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Object.id_valuta.Edit.displayonly = 'NO'
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Modify('id_valuta_des.BackGround.Color ='+ String(RGB( 255,255,255)))
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Object.id_valuta_des.Edit.displayonly = 'NO'
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Modify('importo.BackGround.Color ='+ String(RGB( 255,255,255)))
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Object.importo.Edit.displayonly = 'NO'
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Modify('percentuali.BackGround.Color ='+ String(RGB( 192,192,192)))
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Object.percentuali.Edit.displayonly = 'YES'
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Modify('spesa.BackGround.Color ='+ String(RGB( 192,192,192)))
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Object.spesa.Edit.displayonly = 'YES'
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Modify('spesa_fissa.BackGround.Color ='+ String(RGB( 192,192,192)))
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Object.spesa_fissa.Edit.displayonly = 'YES'
	CASE 'D'
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Modify('id_listino.BackGround.Color ='+ String(RGB( 192,192,192)))
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Object.id_listino.Edit.displayonly = 'YES'
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Modify('listino_descrizione.BackGround.Color ='+ String(RGB( 192,192,192)))
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Object.listino_descrizione.Edit.displayonly = 'YES'
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Modify('id_valuta.BackGround.Color ='+ String(RGB( 192,192,192)))
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Object.id_valuta.Edit.displayonly = 'YES'
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Modify('id_valuta_des.BackGround.Color ='+ String(RGB( 192,192,192)))
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Object.id_valuta_des.Edit.displayonly = 'YES'
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Modify('importo.BackGround.Color ='+ String(RGB( 192,192,192)))
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Object.importo.Edit.displayonly = 'YES'
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Modify('percentuali.BackGround.Color ='+ String(RGB( 255,255,255)))
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Object.percentuali.Edit.displayonly = 'NO'
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Modify('spesa.BackGround.Color ='+ String(RGB( 192,192,192)))
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Object.spesa.Edit.displayonly = 'YES'
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Modify('spesa_fissa.BackGround.Color ='+ String(RGB( 192,192,192)))
		tab_1.tabpage_2.dw_con_lis_articolo_appl_ff.Object.spesa_fissa.Edit.displayonly = 'YES'
END CHOOSE
end subroutine

public function string uf_sqlcond_ricerca ();


string ls_value
long ll_cond
date ld_cond

ls_value=''

ll_cond=tab_1.tabpage_1.dw_con_lis_articolo_cond_ff.getitemnumber(1,'id_sog_commerciale')
if ll_cond <>0 and not isnull(ll_cond) then	ls_value="con_lis_articolo.id_sog_commerciale="+string(ll_cond)+" and "

ll_cond=tab_1.tabpage_1.dw_con_lis_articolo_cond_ff.getitemnumber(1,'id_unita_confezione')
if ll_cond <>0 and not isnull(ll_cond) then	ls_value="con_lis_articolo.id_unita_confezione="+string(ll_cond)+" and "

ll_cond=tab_1.tabpage_1.dw_con_lis_articolo_cond_ff.getitemnumber(1,'id_listino')
if ll_cond <>0 and not isnull(ll_cond) then	ls_value="con_lis_articolo.id_listino="+string(ll_cond)+" and "

ll_cond=tab_1.tabpage_1.dw_con_lis_articolo_cond_ff.getitemnumber(1,'id_cat_merceologica')
if ll_cond <>0 and not isnull(ll_cond) then	ls_value="con_lis_articolo.id_cat_merceologica="+string(ll_cond)+" and "

ll_cond=tab_1.tabpage_1.dw_con_lis_articolo_cond_ff.getitemnumber(1,'id_art_da')
if ll_cond <>0 and not isnull(ll_cond) then	ls_value=ls_value + "con_lis_articolo.id_art_da="+string(ll_cond)+" and "

ll_cond=tab_1.tabpage_1.dw_con_lis_articolo_cond_ff.getitemnumber(1,'id_art_a')
if ll_cond <>0 and not isnull(ll_cond) then	ls_value=ls_value + "con_lis_articolo.id_art_a="+string(ll_cond)+" and "

ll_cond=tab_1.tabpage_1.dw_con_lis_articolo_cond_ff.getitemnumber(1,'id_cat_com_articolo')
if ll_cond <>0 and not isnull(ll_cond) then	ls_value=ls_value + "con_lis_articolo.id_cat_com_articolo="+string(ll_cond)+" and "

ll_cond=tab_1.tabpage_1.dw_con_lis_articolo_cond_ff.getitemnumber(1,'id_anagrafica')
if ll_cond <>0 and not isnull(ll_cond) then	ls_value=ls_value + "con_lis_articolo.id_anagrafica="+string(ll_cond)+" and "

ll_cond=tab_1.tabpage_1.dw_con_lis_articolo_cond_ff.getitemnumber(1,'id_sog_commerciale_fornitore')
if ll_cond <>0 and not isnull(ll_cond) then	ls_value=ls_value + "con_lis_articolo.id_sog_commerciale_fornitore="+string(ll_cond)+" and "

ld_cond=tab_1.tabpage_1.dw_con_lis_articolo_cond_ff.getitemdate(1,'Data_inizio')
if string(ld_cond) <>'' and not isnull(ld_cond) then	ls_value=ls_value + "con_lis_articolo.data_inizio>=date('"+string(ld_cond,"yyyy-mm-dd")+"') and "

ld_cond=tab_1.tabpage_1.dw_con_lis_articolo_cond_ff.getitemdate(1,'Data_fine')
if string(ld_cond) <>'' and not isnull(ld_cond) then	ls_value=ls_value + "con_lis_articolo.data_fine=<date('"+string(ld_cond,"yyyy-mm-dd")+"') and "

ll_cond=tab_1.tabpage_1.dw_con_lis_articolo_cond_ff.getitemnumber(1,'id_cat_com_sc')
if ll_cond <>0 and not isnull(ll_cond) then	ls_value=ls_value + "con_lis_articolo.id_cat_com_sc="+string(ll_cond)+" and "





ls_value=left(ls_value, (Len(ls_value) -4))

return ls_value



end function

event open;call super::open;

this.y = 10
idw_master = tab_1.tabpage_1.dw_con_lis_articolo_cond_ff
idw_master.is_list = Message.PowerObjectParm

if Upperbound(idw_master.is_list.s_identifica)=0 then
	idw_master.ias_key_name[1] = "id_con_lis_articolo"
	idw_master.is_list.s_modo=modo_inserisci
end if

idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_sql_ident[1] = "con_lis_articolo.id_con_lis_articolo"

end event

on w_con_lis_articolo_cx.create
int iCurrent
call super::create
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
end on

on w_con_lis_articolo_cx.destroy
call super::destroy
destroy(this.cb_1)
end on

event closequery;
long			ll_mods
integer		li_ync, li_retval
u_dw_main	ludw_1
boolean		lb_ok

ludw_1 = u_freddie.iudw_current
lb_ok = true
if not IsNull (ludw_1) then
	
end if
if not lb_ok then return 1
if idw_master.acceptText() >0 then lb_ok = true else lb_ok = false
if not lb_ok then return 1

if idw_master.uf_to_update() > 0 then
	li_ync = MessageBox(idw_master.is_title, "Ci sono modifiche non salvate nella " + &
		"finestra.~n~rVuoi salvarle?", Question!, YesNoCancel!)
	CHOOSE CASE li_ync
		CASE 1
			
			THIS.triggerevent("ue_update")
			ll_mods = idw_master.uf_to_update()
			if ll_mods = 0 then 
				li_retval = 0
			else
				li_retval = 1
			end if
			
		CASE 2
			
			li_retval = 0
			
		CASE 3
			
			li_retval = 1
			
	END CHOOSE
else
	
	li_retval = 0
	
end if

return li_retval

end event

event ue_master_delete;integer li_ret, li_app
li_ret = messagebox("ATTENZIONE","Confermi l'eliminazione del Record", Information!, YesNo! )
if li_ret = 1 then
			li_app = tab_1.tabpage_1.dw_con_lis_articolo_cond_ff.deleterow(0)
			if (li_app = 1) then
				tab_1.tabpage_1.dw_con_lis_articolo_cond_ff.update()
				tab_1.tabpage_1.dw_con_lis_articolo_cond_ff.insertrow(0)
			end if
end if
end event

event ue_post_open;call super::ue_post_open;cb_ricerca.visible = true

if not isnull(tab_1.tabpage_1.dw_con_lis_articolo_cond_ff.getitemnumber(1,'id_sog_commerciale')) then 
	cb_ricerca.TriggerEvent(Clicked!)
end if	
end event

type p_crescente from w_p_data`p_crescente within w_con_lis_articolo_cx
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_con_lis_articolo_cx
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_con_lis_articolo_cx
int X=37
int Y=28
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_con_lis_articolo_cx
int X=329
int Y=28
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_con_lis_articolo_cx
int X=622
int Y=28
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_con_lis_articolo_cx
int X=1806
boolean Visible=false
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_con_lis_articolo_cx
int X=2089
int Y=28
boolean BringToTop=true
end type

event cb_cancella::clicked;

tab_1.tabpage_1.dw_con_lis_articolo_cond_ff.setfocus()
	CALL Super::Clicked

end event

type cb_salva from w_p_data`cb_salva within w_con_lis_articolo_cx
int X=2382
int Y=28
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_con_lis_articolo_cx
int X=27
int Y=156
int Width=2610
int Height=1032
boolean BringToTop=true
long BackColor=79741120
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.tabpage_2=create tabpage_2
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_3
this.Control[iCurrent+2]=this.tabpage_4
this.Control[iCurrent+3]=this.tabpage_2
end on

on tab_1.destroy
call super::destroy
destroy(this.tabpage_3)
destroy(this.tabpage_4)
destroy(this.tabpage_2)
end on

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=18
int Y=104
int Width=2574
int Height=912
long BackColor=79741120
string Text="Sogg. Commerciale"
long TabBackColor=79741120
dw_con_lis_articolo_cond_ff dw_con_lis_articolo_cond_ff
end type

on tabpage_1.create
this.dw_con_lis_articolo_cond_ff=create dw_con_lis_articolo_cond_ff
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_con_lis_articolo_cond_ff
end on

on tabpage_1.destroy
call super::destroy
destroy(this.dw_con_lis_articolo_cond_ff)
end on

type cb_ricerca from w_p_data`cb_ricerca within w_con_lis_articolo_cx
int X=1499
int Y=28
boolean BringToTop=true
end type

event cb_ricerca::clicked;


long ll_row


INTEGER			NUM_STOP		= 15			

DATA_FIELD		LST_DATA[]					
STRING			LS_SQL_SCRIPT				

INTEGER			CUR_ROW						
INTEGER			C0								
long				ll_id_con_lis_articolo	
long				ll_priorita					
long 				ll_riga_corrente








w_search_main lw_sm
string ls_sql_cond

idw_master.is_ricpar.s_filter_value = tab_1.tabpage_1.dw_con_lis_articolo_cond_ff.getitemstring(1,'applicazione')
idw_master.is_ricpar.s_filter_name = "applicazione"

ls_SQL_cond = uf_sqlcond_ricerca()
idw_master.is_ricpar.s_SQL_cond = ls_SQL_cond

OpenWithParm(lw_sm, idw_master.is_ricpar, "w_con_lis_art_sw") 
idw_master.is_ricpar = Message.PowerObjectParm


IF UpperBound(idw_master.is_ricpar.s_id_seg_value) > 0 THEN
	
	ll_id_con_lis_articolo = long(idw_master.is_ricpar.s_id_seg_value[1])
end if





ll_row=tab_1.tabpage_1.dw_con_lis_articolo_cond_ff.rowcount()
if ll_row>1 then 
	tab_1.tabpage_1.dw_con_lis_articolo_cond_ff.deleterow(ll_row)
	tab_1.tabpage_1.dw_con_lis_articolo_cond_ff.setitem(1, "data_inizio", date("01/01" + string(year(today()))))
end if	

if ll_id_con_lis_articolo > 0 then
	tab_1.tabpage_1.dw_con_lis_articolo_cond_ff.retrieve(ll_id_con_lis_articolo)
end if


ll_priorita=calcola_priorita(tab_1.tabpage_1.dw_con_lis_articolo_cond_ff)
ll_riga_corrente=tab_1.tabpage_1.dw_con_lis_articolo_cond_ff.getrow()
tab_1.tabpage_1.dw_con_lis_articolo_cond_ff.setitem(ll_riga_corrente, "priorita", ll_priorita)


end event

type dw_con_lis_articolo_cond_ff from u_dw_master_main within tabpage_1
int X=14
int Y=20
int Width=2546
int Height=876
int TabOrder=3
string DataObject="d_con_lis_articolo_cond_ff"
end type

event ue_init;call super::ue_init;iudw_children[1] = tab_1.tabpage_3.dw_con_lis_articolo_cond_art_ff
iudw_children[2] = tab_1.tabpage_4.dw_con_lis_articolo_cond_altro_ff
iudw_children[3] = tab_1.tabpage_2.dw_con_lis_articolo_appl_ff
is_list.s_identifica[1] = "id_con_lis_articolo"
is_title = "Condizioni Listini"


end event

event ue_set_search;call super::ue_set_search;CHOOSE CASE as_nomecol
	CASE "c_destinazione_des"
		is_search_window = "w_destinazione_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "rag_soc_1" 
	
	CASE "s_c_codice_1"
			is_search_window = "w_sog_commerciale_gen_coddes_sw"
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "codice"

	CASE "rag_soc_1"
			is_search_window = "w_sog_commerciale_gen_coddes_sw"
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "rag_soc_1"
END CHOOSE

CHOOSE CASE as_nomecol
	CASE "id_cat_com_sc"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_cat_com_sc_gd"
		is_ricpar.s_titolo_finestra = "Categorie Commerciali"
		is_ricpar.s_ausil_value[1] = "id_cat_com_sc_des"
END CHOOSE
end event

event ue_use_search;string ls_null 
setnull(ls_null)
CHOOSE CASE as_nomecol
	CASE "c_destinazione_des"
		if isnull(is_ricpar.s_ausil_value[1]) then is_ricpar.s_ausil_value[1]=" "
		uf_set_colval(as_nomecol, is_ricpar.s_ausil_value[2] + " - " + is_ricpar.s_main_value + " - " + is_ricpar.s_ausil_value[1])
		uf_set_colval("id_destinazione", is_ricpar.s_id_seg_value[1])
	
	CASE "s_c_codice_1"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_sog_commerciale", is_ricpar.s_id_seg_value[1])
		uf_set_colval("rag_soc_1", is_ricpar.s_ausil_value[1])
		uf_set_colval("id_cat_com_sc", ls_null)			
		
	CASE "rag_soc_1"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_sog_commerciale", is_ricpar.s_id_seg_value[1])
		uf_set_colval("s_c_codice_1", is_ricpar.s_ausil_value[1])
		uf_set_colval("id_cat_com_sc", ls_null)			
END CHOOSE
end event

event itemchanged;long ll_null
string    ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
long      ll_ok
string ls_null
setnull(ls_null)
setnull(ll_null)
ls_sql_cond = ""
CHOOSE CASE dwo.name
	
	CASE 'c_destinazione_des'
		this.object.s_c_codice_1[row] = ls_null
		this.object.s_c_codice_1[row] = ls_null
		
		ls_sql_cond = ""
		ls_dbc[1] = "id_destinazione"
		ls_dwc[1] = "id_destinazione"
		ls_dbc[2] = "destinazione_rag_soc_1"
		ls_dwc[2] = "c_destinazione_des"
		ll_ok = uf_autofind_col(dwo.Name, "destinazione", &
										"rag_soc_1", "A", data, & 
										ls_sql_cond, 2, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF

	CASE 's_c_codice_1'
		ls_sql_cond = ""
		ls_dbc[1] = "id_sog_commerciale"
		ls_dwc[1] = "id_sog_commerciale"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "s_c_codice_1"
		ls_dbc[3] = "rag_soc_1"
		ls_dwc[3] = "rag_soc_1"
		ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &
										"codice", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
	
	CASE "rag_soc_1"
		ls_sql_cond = ""
		ls_dbc[1] = "id_sog_commerciale"
		ls_dwc[1] = "id_sog_commerciale"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "s_c_codice_1"
		ls_dbc[3] = "rag_soc_1"
		ls_dwc[3] = "rag_soc_1"
		ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &
										"rag_soc_1", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
END CHOOSE
end event

event ue_update;call super::ue_update;
end event

event ue_insert;call super::ue_insert;long ll_id_valuta, ll_row
ll_row =getrow()

this.setitem(ll_row, "data_inizio", date(string(year(today())) + "/01/01"))

SELECT 	id_valuta
INTO		:ll_id_valuta
FROM 		par_sistema
;

if (SQLCA.SQLCODE = 0) then
	this.setitem(ll_row, "id_valuta", ll_id_valuta)	
end if

end event

event updatestart;

Long	   ll_id_valuta, ll_id_listino
Long 		ll_row
decimal	ld_importo
boolean	lb_exit
string 	ls_tipo

ll_row = GetRow()

if (ll_row = 0) then	return 0

ls_tipo = GetItemString(ll_row,'tipo_applicazione')
	
ld_importo = THIS.GetItemNumber(ll_row,"importo")
ll_id_listino = THIS.GetItemNumber(ll_row,"id_listino")
	ll_id_valuta = This.GetItemNumber(ll_row, "id_valuta")
	

	CHOOSE CASE ls_tipo
		CASE 'P'
			
			IF (ll_id_listino = 0 OR isnull(ll_id_listino)) AND &
					(ld_importo = 0 OR isnull(ld_importo)) THEN
				MessageBox('Errore',"E' necessario inserire un listino o un prezzo !")
				lb_exit = TRUE
			END IF
			
			If (IsNull(ll_id_valuta)) Then
				MessageBox("Condizioni di listino", "La Valuta è obbligatoria")
				return
			End If
	END CHOOSE
	IF ls_tipo = 'I' Then
			ll_row = THIS.GetRow()
			ll_id_listino = THIS.GetItemNumber(ll_row,"id_listino")
			IF ll_id_listino = 0 OR isnull(ll_id_listino) THEN
				MessageBox('Errore','Deve essere obbligatoriamente inserito un listino !')
				lb_exit = TRUE
			END IF
		End If

	IF (ls_tipo = 'P') OR (ls_tipo = 'I') OR (ls_tipo = 'R') THEN
		ll_row = THIS.GetRow()
		ld_importo = THIS.GetItemNumber(ll_row,"importo")
		ll_id_valuta = THIS.GetItemNumber(ll_row,"id_valuta")
		IF ((ld_importo <> 0) OR (NOT isnull(ld_importo))) AND (isnull(ll_id_valuta)) THEN
			MessageBox('Errore',"E' nacessario scegliere una valuta tra quelle disponibili !")
			lb_exit = TRUE
		END IF
	END IF

	IF lb_exit = TRUE THEN
		RETURN 1
	END IF
	
end event

type tabpage_3 from userobject within tab_1
int X=18
int Y=104
int Width=2574
int Height=912
long BackColor=79741120
string Text="Articolo"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_con_lis_articolo_cond_art_ff dw_con_lis_articolo_cond_art_ff
end type

on tabpage_3.create
this.dw_con_lis_articolo_cond_art_ff=create dw_con_lis_articolo_cond_art_ff
this.Control[]={this.dw_con_lis_articolo_cond_art_ff}
end on

on tabpage_3.destroy
destroy(this.dw_con_lis_articolo_cond_art_ff)
end on

type dw_con_lis_articolo_cond_art_ff from u_dw_master_main within tabpage_3
int X=18
int Y=20
int Width=2537
int Height=836
int TabOrder=12
boolean BringToTop=true
string DataObject="d_con_lis_articolo_cond_art_ff"
end type

event ue_init;call super::ue_init;ib_dw_shared = TRUE
is_list.s_colonne_drop[1] = "id_cat_com_articolo"
is_list.s_colonne_drop[2] = "id_cat_com_articolo_des"

end event

event itemchanged;string    ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
long      ll_ok
long ll_null
string ls_null
setnull(ls_null)
setnull(ll_null)
ls_sql_cond = ""
CHOOSE CASE dwo.name
	CASE "art_da_codice"
		ls_sql_cond = ""
		ls_dbc[1] = "id_articolo"
		ls_dwc[1] = "id_art_da"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "art_da_codice"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "art_da_descrizione"
		ll_ok = uf_autofind_col(dwo.Name, "articolo", &
										"codice", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
										
		IF (ll_ok > 0) THEN
			 if isnull(this.getitemstring(1, "art_a_codice")) or this.getitemstring(1, "art_a_codice")='' then
			   this.setitem(1, "id_art_a",this.getitemnumber(1, "id_art_da"))
			   this.setitem(1, "art_a_codice",data)
			   this.setitem(1, "art_a_descrizione",this.getitemstring(1, "art_da_descrizione"))
	      end if	
			RETURN 2
		END IF
		
	CASE "art_da_descrizione"
		ls_sql_cond = ""
		ls_dbc[1] = "id_articolo"
		ls_dwc[1] = "id_art_da"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "art_da_codice"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "art_da_descrizione"
		ll_ok = uf_autofind_col(dwo.Name, "articolo", &
										"descrizione", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)								
										
		IF (ll_ok > 0) THEN
			if isnull(this.getitemstring(1, "art_a_codice")) or this.getitemstring(1, "art_a_codice")='' then
			  this.setitem(1, "art_a_descrizione",data)
			  this.setitem(1, "art_a_codice",this.getitemstring(1, "art_da_codice"))
			  this.setitem(1, "id_art_a",this.getitemstring(1, "id_art_da"))			  
	      end if	
			RETURN 2
		END IF
		
		CASE "art_a_codice"
		ls_sql_cond = ""
		ls_dbc[1] = "id_articolo"
		ls_dwc[1] = "id_art_a"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "art_a_codice"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "art_a_descrizione"
		ll_ok = uf_autofind_col(dwo.Name, "articolo", &
										"codice", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF	
		
	CASE "art_a_descrizione"
		ls_sql_cond = ""
		ls_dbc[1] = "id_articolo"
		ls_dwc[1] = "id_art_a"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "art_a_codice"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "art_a_descrizione"
		
		ll_ok = uf_autofind_col(dwo.Name, "articolo", &
										"descrizione", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF			
						
	CASE "u_c_codice"
		uf_set_colval("art_da_codice", ls_null)
		uf_set_colval("art_da_descrizione", ls_null)	
		uf_set_colval("art_a_codice", ls_null)
		uf_set_colval("art_a_descrizione", ls_null)	
		uf_set_colval("id_cat_com_articolo", ls_null)
		ls_sql_cond = ""
		ls_dbc[1] = "id_unita_confezione"
		ls_dwc[1] = "id_unita_confezione"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "u_c_codice"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "u_c_descrizione"
		ll_ok = uf_autofind_col(dwo.Name, "unita_confezione", &
										"codice", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
			


	CASE "u_c_descrizione"
		uf_set_colval("art_da_codice", ls_null)
		uf_set_colval("art_da_descrizione", ls_null)	
		uf_set_colval("art_a_codice", ls_null)
		uf_set_colval("art_a_descrizione", ls_null)	
		uf_set_colval("id_cat_com_articolo", ls_null)
		ls_sql_cond = ""
		ls_dbc[1] = "id_unita_confezione"
		ls_dwc[1] = "id_unita_confezione"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "u_c_codice"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "u_c_descrizione"
		ll_ok = uf_autofind_col(dwo.Name, "unita_confezione", &
										"descrizione", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
			
	CASE "id_cat_com_articolo"
		uf_set_colval("art_da_codice", ls_null)
		uf_set_colval("art_da_descrizione", ls_null)	
		uf_set_colval("art_a_codice", ls_null)
		uf_set_colval("art_a_descrizione", ls_null)	
		uf_set_colval("u_c_codice", ls_null)	
		uf_set_colval("u_c_descrizione", ls_null)			
END CHOOSE
end event

event ue_set_search;call super::ue_set_search;CHOOSE CASE as_nomecol
	CASE "art_da_codice"
			is_search_window = "w_articolo_coddes_sw"
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name ="articolo_codice"
	CASE "art_da_descrizione"
			is_search_window = "w_articolo_coddes_sw"
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name ="articolo_descrizione"
	CASE "art_a_codice"
			is_search_window = "w_articolo_coddes_sw"
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name ="articolo_codice"
	CASE "art_a_descrizione"
			is_search_window = "w_articolo_coddes_sw"
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name ="articolo_descrizione"
	CASE "u_c_codice"
			is_search_window = "w_unita_confezione_coddes_sw"
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "unita_confezione_codice"
	CASE "u_c_descrizione"
			is_search_window = "w_unita_confezione_coddes_sw"
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name ="unita_confezione_descrizione"
END CHOOSE

CHOOSE CASE as_nomecol
	CASE "id_cat_com_articolo"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_cat_com_articolo_gd"
		is_ricpar.s_titolo_finestra = "Categorie Commerciali degli Articoli"
		is_ricpar.s_ausil_value[1] = "id_cat_com_articolo_des"
		is_ricpar.i_width = 2949
		is_ricpar.i_height = 877
	CASE "id_cat_com_articolo_des"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_cat_com_articolo_gd"
		is_ricpar.s_titolo_finestra = "Categorie Commerciali degli Articoli"
		is_ricpar.s_ausil_value[1] = "id_cat_com_articolo"
		is_ricpar.i_width = 2949
		is_ricpar.i_height = 877
END CHOOSE
end event

event ue_use_search;string ls_null 
setnull(ls_null)
CHOOSE CASE as_nomecol
	CASE "art_da_codice"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_art_da", is_ricpar.s_id_seg_value[1])
		uf_set_colval("art_da_descrizione", is_ricpar.s_ausil_value[1])			
		uf_set_colval("u_c_codice", ls_null)			
		uf_set_colval("u_c_descrizione", ls_null)			
		uf_set_colval("id_cat_com_articolo", ls_null)			
		wf_post_itemchanged(this.getrow())
		if isnull(this.getitemstring(1, "art_a_codice")) or this.getitemstring(1, "art_a_codice")='' then
			uf_set_colval("art_a_codice", is_ricpar.s_main_value)
			uf_set_colval("art_a_descrizione", is_ricpar.s_ausil_value[1])
	   end if		
		
	CASE "art_da_descrizione"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_art_da", is_ricpar.s_id_seg_value[1])
		uf_set_colval("art_da_codice", is_ricpar.s_ausil_value[1])
		uf_set_colval("u_c_codice", ls_null)			
		uf_set_colval("u_c_descrizione", ls_null)			
		uf_set_colval("id_cat_com_articolo", ls_null)	
		wf_post_itemchanged(this.getrow())
			if isnull(this.getitemstring(1, "art_a_codice")) or this.getitemstring(1, "art_a_codice")='' then
			uf_set_colval("art_a_descrizione", is_ricpar.s_main_value)
			uf_set_colval("art_a_codice", is_ricpar.s_ausil_value[1])
	   end if	
	CASE "art_a_codice"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_art_a", is_ricpar.s_id_seg_value[1])
		uf_set_colval("art_a_descrizione", is_ricpar.s_ausil_value[1])
		uf_set_colval("u_c_codice", ls_null)			
		uf_set_colval("u_c_descrizione", ls_null)			
		uf_set_colval("id_cat_com_articolo", ls_null)	

	CASE "art_a_descrizione"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_art_a", is_ricpar.s_id_seg_value[1])
		uf_set_colval("art_a_codice", is_ricpar.s_ausil_value[1])
		uf_set_colval("u_c_codice", ls_null)			
		uf_set_colval("u_c_descrizione", ls_null)			
		uf_set_colval("id_cat_com_articolo", ls_null)	
	CASE "u_c_codice"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_unita_confezione", is_ricpar.s_id_seg_value[1])
		uf_set_colval("u_c_descrizione", is_ricpar.s_ausil_value[1])
		uf_set_colval("id_cat_com_articolo", ls_null)	
		uf_set_colval("art_da_codice", ls_null)	
		uf_set_colval("art_da_descrizione", ls_null)	
		uf_set_colval("art_a_codice", ls_null)			
		uf_set_colval("art_a_descrizione", ls_null)		
	CASE "u_c_descrizione"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_unita_confezione", is_ricpar.s_id_seg_value[1])
		uf_set_colval("u_c_codice", is_ricpar.s_ausil_value[1])
		uf_set_colval("id_cat_com_articolo", ls_null)
		uf_set_colval("art_da_codice", ls_null)	
		uf_set_colval("art_da_descrizione", ls_null)	
		uf_set_colval("art_a_codice", ls_null)			
		uf_set_colval("art_a_descrizione", ls_null)		
END CHOOSE
end event

type tabpage_4 from userobject within tab_1
int X=18
int Y=104
int Width=2574
int Height=912
long BackColor=79741120
string Text="Altri Dati"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_con_lis_articolo_cond_altro_ff dw_con_lis_articolo_cond_altro_ff
end type

on tabpage_4.create
this.dw_con_lis_articolo_cond_altro_ff=create dw_con_lis_articolo_cond_altro_ff
this.Control[]={this.dw_con_lis_articolo_cond_altro_ff}
end on

on tabpage_4.destroy
destroy(this.dw_con_lis_articolo_cond_altro_ff)
end on

type dw_con_lis_articolo_cond_altro_ff from u_dw_master_main within tabpage_4
int X=23
int Y=24
int Width=2533
int Height=836
int TabOrder=12
boolean BringToTop=true
string DataObject="d_con_lis_articolo_cond_altro_ff"
end type

event ue_init;call super::ue_init;ib_dw_shared = TRUE
is_list.s_colonne_drop[1] = "id_cat_merceologica"
is_list.s_colonne_drop[2] = "id_cat_merceologica_des"

is_list.s_colonne_drop[3] = "tras_mezzo"
is_list.s_colonne_drop[4] = "id_tipo_trasporto"
end event

event itemchanged;long ll_null
string    ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
long      ll_ok
string ls_null
setnull(ls_null)
setnull(ll_null)
ls_sql_cond = ""
CHOOSE CASE dwo.name
	CASE "codice_fornitore"
		ls_sql_cond = "sog_commerciale_gen.tipo = 'F'"  
		ls_dbc[1] = "id_sog_commerciale"
		ls_dwc[1] = "id_sog_commerciale_fornitore"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "codice_fornitore"
		ls_dbc[3] = "rag_soc_1"
		ls_dwc[3] = "descrizione_fornitore"
		ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &
										"codice", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
		
	CASE "descrizione_fornitore"
		ls_sql_cond = "sog_commerciale_gen.tipo = 'F'"  
		ls_dbc[1] = "id_sog_commerciale"
		ls_dwc[1] = "id_sog_commerciale_fornitore"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "codice_fornitore"
		ls_dbc[3] = "rag_soc_1"
		ls_dwc[3] = "descrizione_fornitore"
		ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &
										"rag_soc_1", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
		
	CASE "produttore"
		ls_sql_cond = ""
		ls_dbc[1] = "id_anagrafica"
		ls_dwc[1] = "id_anagrafica"
		ls_dbc[2] = "rag_soc_1"
		ls_dwc[2] = "produttore"
		ll_ok = uf_autofind_col(dwo.Name, "anagrafica", &
										"rag_soc_1", "A", data, & 
										ls_sql_cond, 2, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF

	
	CASE "tras_mezzo"
		if (not isnull(data)) then this.setitem(row, "id_tipo_trasporto", ll_null)
	CASE "id_tipo_trasporto"
		if (not isnull(data)) then this.setitem(row, "tras_mezzo", ls_null)		
	
END CHOOSE
end event

event ue_set_search;call super::ue_set_search;CHOOSE CASE as_nomecol
	CASE "codice_fornitore"
			is_search_window = "w_sog_commerciale_gen_coddes_sw"
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "codice"
			is_ricpar.s_sql_cond = f_tilde_quote("sog_commerciale_gen.tipo") + " = 'F' "
	CASE "descrizione_fornitore"
			is_search_window = "w_sog_commerciale_gen_coddes_sw"
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "rag_soc_1"
			is_ricpar.s_sql_cond = f_tilde_quote("sog_commerciale_gen.tipo") + " = 'F' "
	CASE "produttore"
			is_search_window = "w_anagrafica_sw"
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name ="rag_soc_1"
END CHOOSE

CHOOSE CASE as_nomecol
	CASE "id_cat_com_articolo"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_cat_com_articolo_gd"
		is_ricpar.s_titolo_finestra = "Categorie Commerciali degli Articoli"
		is_ricpar.s_ausil_value[1] = "id_cat_com_articolo_des"
		is_ricpar.i_width = 2949
		is_ricpar.i_height = 877
	CASE "id_cat_com_articolo_des"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_cat_com_articolo_gd"
		is_ricpar.s_titolo_finestra = "Categorie Commerciali degli Articoli"
		is_ricpar.s_ausil_value[1] = "id_cat_com_articolo"
		is_ricpar.i_width = 2949
		is_ricpar.i_height = 877
	CASE "id_cat_merceologica"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_cat_merceologica_gd"
		is_ricpar.s_titolo_finestra = "Categorie Merceologiche degli Articoli"
		is_ricpar.s_ausil_value[1] = "id_cat_merceologica"
		is_ricpar.i_width = 2930
		is_ricpar.i_height = 860
	CASE "id_cat_merceologica_des"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_cat_merceologica_gd"
		is_ricpar.s_titolo_finestra = "Categorie Merceologiche degli Articoli"
		is_ricpar.s_ausil_value[1] = "id_cat_merceologica"
		is_ricpar.i_width = 2930
		is_ricpar.i_height = 860		
END CHOOSE
end event

event ue_use_search;string ls_null 
setnull(ls_null)
CHOOSE CASE as_nomecol
	CASE "codice_fornitore"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_sog_commerciale_fornitore", is_ricpar.s_id_seg_value[1])
		uf_set_colval("descrizione_fornitore", is_ricpar.s_ausil_value[1])

	CASE "descrizione_fornitore"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_sog_commerciale_fornitore", is_ricpar.s_id_seg_value[1])
		uf_set_colval("codice_fornitore", is_ricpar.s_ausil_value[1])

	CASE "produttore"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_anagrafica", is_ricpar.s_id_seg_value[1])
	
END CHOOSE
end event

type tabpage_2 from userobject within tab_1
int X=18
int Y=104
int Width=2574
int Height=912
long BackColor=79741120
string Text="Applicazioni"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_con_lis_articolo_appl_ff dw_con_lis_articolo_appl_ff
end type

on tabpage_2.create
this.dw_con_lis_articolo_appl_ff=create dw_con_lis_articolo_appl_ff
this.Control[]={this.dw_con_lis_articolo_appl_ff}
end on

on tabpage_2.destroy
destroy(this.dw_con_lis_articolo_appl_ff)
end on

type dw_con_lis_articolo_appl_ff from u_dw_master_main within tabpage_2
event ue_verifica_percentuale ( long riga,  string as_colonna )
int X=18
int Y=24
int Width=2537
int Height=868
int TabOrder=3
boolean BringToTop=true
string DataObject="d_con_lis_articolo_appl_ff"
end type

event ue_verifica_percentuale;call super::ue_verifica_percentuale;
string ls_flag
setnull(ls_flag)
messagebox("Attenzione!", "Prima di ogni valore pecentuale va specificato il segno!"&
+"~r~nIl formato deve essere del seguente tipo: +13+5+10 ")
setitem(riga, as_colonna, ls_flag) 
setcolumn(as_colonna)
end event

event ue_init;call super::ue_init;ib_dw_shared = TRUE
is_list.s_colonne_drop[1] = "id_valuta"
is_list.s_colonne_drop[2] = "id_valuta_des"

is_list.s_colonne_drop[3] = "id_listino"
is_list.s_colonne_drop[4] = "listino_descrizione"

end event

event itemchanged;integer li_flag
string ls_flag, ls_tipo

if string(dwo.name)="percentuali" or string(dwo.name)="spesa" then
	li_flag=f_verifica_percentuali(data)
	if li_flag=0 then
		post event ue_verifica_percentuale(row, string(dwo.name))
	end if
end if

string ls_null
setnull(ls_null)		

CHOOSE CASE dwo.name
	CASE "percentuali"
		if (not isnull(data)) then
			this.setitem(row, "ultimo_sconto", ls_null)
			this.modify("ultimo_sconto.background.color = '12632256'")
			this.modify("ultimo_sconto.protect = 1")
		else
			this.modify("ultimo_sconto.background.color ='16777215'")			
			this.modify("ultimo_sconto.protect = 0")			
		end if
		
	CASE "ultimo_sconto"
		if (data = 'S') then
			this.setitem(row, "percentuali", ls_null)
			this.modify("percentuali.background.color ='12632256'")
			this.modify("percentuali.protect = 1")			
		else
			this.modify("percentuali.background.color ='16777215'")	
			this.modify("percentuali.protect = 0")			
		end if
		
END CHOOSE
end event

type cb_1 from commandbutton within w_con_lis_articolo_cx
int X=1783
int Y=28
int Width=274
int Height=84
int TabOrder=10
boolean BringToTop=true
string Text="&Stampa"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;datawindow idw_sel
idw_sel=tab_1.tabpage_1.dw_con_lis_articolo_cond_ff
string ls_tipo,sogg_com_cod,u_c_codice,da_articolo,a_articolo,ls_fornitore,ls_produttore,ls_filtro,ls_parametri
long id_cat_com_sc,id_cat_com_articolo,qta_minima,qta_massima,ll_row
date data_inizio,data_fine
str_fil_flag str_param
ll_row=idw_sel.getrow()
sogg_com_cod=idw_sel.getitemstring(ll_row,"s_c_codice_1")
u_c_codice=idw_sel.getitemstring(ll_row,"u_c_codice")
id_cat_com_sc=idw_sel.getitemnumber(ll_row,"id_cat_com_sc")
da_articolo=idw_sel.getitemstring(ll_row,"art_da_codice")
a_articolo=idw_sel.getitemstring(ll_row,"art_a_codice")
id_cat_com_articolo=idw_sel.getitemnumber(ll_row,"id_cat_com_articolo")
ls_fornitore=idw_sel.getitemstring(ll_row,"codice_fornitore")
ls_produttore=idw_sel.getitemstring(ll_row,"produttore")
data_inizio=idw_sel.getitemdate(ll_row,"data_inizio")
data_fine=idw_sel.getitemdate(ll_row,"data_fine")
qta_minima=idw_sel.getitemnumber(ll_row,"qta_minima")
qta_massima=idw_sel.getitemnumber(ll_row,"qta_massima")
ls_tipo=idw_sel.getitemstring(ll_row,"applicazione")
if da_articolo>a_articolo then
	messagebox("Attenzione!"," l'articolo iniziale ha un codice maggiore di quello finale",exclamation!)
else


if ls_tipo<>''and ls_filtro='' then
	ls_filtro='applicazione='+'"'+string(ls_tipo)+'"'
else
if ls_tipo<>''and ls_filtro<>'' then
	ls_filtro=ls_filtro+' and (applicazione='+'"'+string(ls_tipo)+'"'+')'
end if
end if





if sogg_com_cod<>''and ls_filtro='' then
	ls_filtro='s_c_codice_1='+'"'+string(sogg_com_cod)+'"'
else
if sogg_com_cod<>''and ls_filtro<>'' then
	ls_filtro=ls_filtro+' and (s_c_codice_1='+'"'+string(sogg_com_cod)+'"'+')'
end if
end if

if not isnull( id_cat_com_sc) and ls_filtro='' then
	ls_filtro='id_cat_com_sc='+string(id_cat_com_sc)
else
if not isnull( id_cat_com_sc)and ls_filtro<>'' then
	ls_filtro=ls_filtro+' and (id_cat_com_sc='+string(id_cat_com_sc)+')'
end if
end if


if da_articolo<>''and ls_filtro='' then
	ls_filtro='(art_a_codice>='+'"'+string(da_articolo)+'")'
else
if da_articolo<>''and ls_filtro<>'' then
	ls_filtro=ls_filtro+' and (art_da_codice>='+'"'+string(da_articolo)+'")'
end if
end if

if a_articolo<>''and ls_filtro='' then
	ls_filtro='(art_a_codice<='+'"'+string(a_articolo)+'")'
else
if a_articolo<>''and ls_filtro<>'' then
	ls_filtro=ls_filtro+' and (art_a_codice<='+'"'+string(a_articolo)+'")'
end if
end if

if not isnull(id_cat_com_articolo) and ls_filtro='' then
	ls_filtro='id_cat_com_articolo='+string(id_cat_com_articolo)
else
if not isnull(id_cat_com_articolo)and ls_filtro<>'' then
	ls_filtro=ls_filtro+' and (id_cat_com_articolo='+string(id_cat_com_articolo)+')'
end if
end if

if ls_fornitore<>''and ls_filtro='' then
	ls_filtro='codice_fornitore='+'"'+string(ls_fornitore)+'"'
else
if ls_fornitore<>''and ls_filtro<>'' then
	ls_filtro=ls_filtro+' and (codice_fornitore='+'"'+string(ls_fornitore)+'"'+')'
end if
end if

if ls_produttore<>''and ls_filtro='' then
	ls_filtro='produttore='+'"'+string(ls_produttore)+'"'
else
if ls_produttore<>''and ls_filtro<>'' then
	ls_filtro=ls_filtro+' and (produttore='+'"'+string(ls_produttore)+'"'+')'
end if
end if

if not isnull(data_inizio) and ls_filtro='' then
	ls_filtro='data_inizio=date("'+string(data_inizio)+'")'
else

if not isnull(data_inizio) and ls_filtro<>'' then
	ls_filtro=ls_filtro+' and data_inizio=date("'+string(data_inizio)+'")'
end if
end if

if not isnull(data_fine) and ls_filtro='' then
	ls_filtro='data_fine=date("'+string(data_fine)+'")'
else

if not isnull(data_fine) and ls_filtro<>'' then
	ls_filtro=ls_filtro+' and data_fine=date("'+string(data_fine)+'")'
end if
end if




OpenWithParm(w_stp_con_lis_art_gd,ls_filtro)
end if
end event

