forward
global type w_bilancio_nuovo_cx from window
end type
type cb_st_confronta from commandbutton within w_bilancio_nuovo_cx
end type
type cb_1 from commandbutton within w_bilancio_nuovo_cx
end type
type cb_2 from commandbutton within w_bilancio_nuovo_cx
end type
type dw_1 from u_dw_ext_main within w_bilancio_nuovo_cx
end type
end forward

global type w_bilancio_nuovo_cx from window
integer x = 834
integer y = 362
integer width = 2000
integer height = 515
boolean titlebar = true
string title = "Bilancio"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 80263581
cb_st_confronta cb_st_confronta
cb_1 cb_1
cb_2 cb_2
dw_1 dw_1
end type
global w_bilancio_nuovo_cx w_bilancio_nuovo_cx

type variables
long ll_id1,ll_id2,ll_id3,ll_id4
long ll_val_es
end variables

forward prototypes
public subroutine uf_ss (string as_type, string as_dett)
end prototypes

public subroutine uf_ss (string as_type, string as_dett);

long ll_id_conto, ll_ap, ll_ch, ll_riga, ll_num_righe, ll_group, ll_next_group
long ll_mm1, ll_mm2, i, ll_ret
decimal ld_conto,ld_dare,ld_avere, ld_null
boolean lb_flag
string ls_cl, ls_fo

setnull(ld_null)

datastore ds_bil
ds_bil=create datastore
if as_type='M' then
	ds_bil.dataobject="ds_mm_bil"
else
	ds_bil.dataobject="ds_ss_bil"
end if	
ds_bil.settransobject(sqlca)
ll_ret=ds_bil.retrieve()

select pref_cod_cliente, pref_cod_fornitore into :ls_cl, :ls_fo
from par_sistema;
select id_mastro into :ll_mm1 from mastro where codice=:ls_cl;
select id_mastro into :ll_mm2 from mastro where codice=:ls_fo;
if as_type='C' and as_dett='F' then
	
	ds_bil.setfilter("id_mm<>"+string(ll_mm1)+" and id_mm<>"+string(ll_mm2))
   ll_ret=ds_bil.filter()
end if	
if as_type='C' and as_dett='C' then
	ds_bil.setfilter("id_mm="+string(ll_mm1)+" and id_mm="+string(ll_mm2))
   ll_ret=ds_bil.filter()
end if	

ll_riga=ds_bil.rowcount()
for i=1 to ll_riga
	ds_bil.setitem(i,"id_bil_cee",0)
next	
ds_bil.update()

ll_num_righe=1
if ll_riga>0 then
	DO
		ll_group=ds_bil.FindGroupChange(ll_num_righe,1)
		if ll_group>0 then
			ll_next_group=ds_bil.FindGroupChange(ll_group+1,1)
			if ll_next_group>0 then
				ll_riga=ll_next_group - 1
			else
				ll_riga=ds_bil.RowCount()
			end if
		end if
		lb_flag=true
		ll_id_conto=ds_bil.getitemnumber(ll_riga,'id_conto')
		ld_dare=ds_bil.getitemnumber(ll_riga,'sumdare')
		ld_avere=ds_bil.getitemnumber(ll_riga,'sumavere')
		if isnull(ld_dare) then ld_dare=0
		if isnull(ld_avere) then ld_avere=0			
		ld_conto=ld_dare - ld_avere
		if ld_conto<0 then 
			lb_flag=false
			ld_conto=ld_conto* -1
		end if
		if ld_conto<>0 then
			if lb_flag=false then
				UPDATE chiusura_apertura
				SET saldo_avere=:ld_conto, saldo_dare=:ld_null, id_bil_cee=1
				WHERE id_conto=:ll_id_conto; 
			else
				UPDATE chiusura_apertura
				SET saldo_dare=:ld_conto, saldo_avere=:ld_null, id_bil_cee=1
				WHERE id_conto=:ll_id_conto; 
			end if
		end if

		ll_num_righe=ll_group+1
	Loop Until ll_group=0 or ll_riga>=ds_bil.rowcount()
	
	destroy ds_bil
	delete from chiusura_apertura where id_bil_cee=0;
	commit;
	
end if
end subroutine

event open;
dw_1.insertrow(0)
dw_1.setfocus()

end event

on w_bilancio_nuovo_cx.create
this.cb_st_confronta=create cb_st_confronta
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_1=create dw_1
this.Control[]={this.cb_st_confronta,&
this.cb_1,&
this.cb_2,&
this.dw_1}
end on

on w_bilancio_nuovo_cx.destroy
destroy(this.cb_st_confronta)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_1)
end on

type cb_st_confronta from commandbutton within w_bilancio_nuovo_cx
integer x = 1346
integer y = 51
integer width = 249
integer height = 83
integer taborder = 30
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Confronta"
end type

event clicked;dw_1.accepttext()

long ll_id_val, ll_cod_es1
decimal ld_dec_sign, ld_cambio
date ld_da,ld_a, ld_in,ld_fn, ld_in2

s_param ls_param

ls_param.tipo_stp="CONFRONTO"
ls_param.data_in=dw_1.getitemdate(1, "da")
ls_param.data_fin=dw_1.getitemdate(1, "a")

openwithparm(w_stampa_bilancio_nuovo_gd,ls_param)
	
	

end event

type cb_1 from commandbutton within w_bilancio_nuovo_cx
integer x = 1697
integer y = 51
integer width = 249
integer height = 83
integer taborder = 10
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stampa"
end type

event clicked;dw_1.accepttext()

long ll_id_val, ll_cod_es1
decimal ld_dec_sign, ld_cambio
date ld_da,ld_a, ld_in,ld_fn, ld_in2

s_param ls_param


ls_param.data_in=dw_1.getitemdate(1, "da")
ls_param.data_fin=dw_1.getitemdate(1, "a")

openwithparm(w_stampa_bilancio_nuovo_gd,ls_param)
	
	

end event

type cb_2 from commandbutton within w_bilancio_nuovo_cx
event clicked pbm_bnclicked
integer x = 22
integer y = 42
integer width = 249
integer height = 83
integer taborder = 20
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Annulla"
end type

event clicked;close(parent)
end event

type dw_1 from u_dw_ext_main within w_bilancio_nuovo_cx
integer y = 154
integer width = 1931
integer height = 230
integer taborder = 30
string dataobject = "d_bilancio_nuovo_ff"
end type

event itemchanged;date ld_d1,ld_d2
string ls_data
date ld_d_in, ld_d_fin, ld_a, ld_da 
string ls_colonna 

CHOOSE CASE dwo.name

	CASE "id_esercizio"
			select data_inizio,data_fine, id_valuta
			into :ld_d1,:ld_d2, :ll_val_es
			from esercizio
			where id_esercizio=:data;
			ls_data=string(ld_d1,"dd/mm/yyyy")
			dw_1.setitem(1,"d_in",ls_data)
			ls_data=string(ld_d2,"dd/mm/yyyy")
			dw_1.setitem(1,"d_fin",ls_data)	
			dw_1.setitem(1,"da",ld_d1)
			dw_1.setitem(1,"a",ld_d2)	
			
			dw_1.setitem(1,"valuta",ll_val_es)

	CASE "da"
	      ls_data=dw_1.getitemstring(1,"d_in")
			ld_d_in=date(ls_data) 
		   ls_data=dw_1.getitemstring(1,"d_fin")
			ld_d_fin=date(ls_data)
			ld_da=date(data)
			if ld_da<ld_d_in or ld_da>ld_d_fin then
				messagebox("Controllo", "Attenzione, la Data Iniziale non rientra~nnell'Esercizio selezionato!")
      		ls_colonna="da"
      		POST F_SET_COLUMN(DW_1,LS_COLONNA)
		   end if
	
	CASE "a"
			ls_data=dw_1.getitemstring(1,"d_in")
			ld_d_in=date(ls_data) 	
			ls_data=dw_1.getitemstring(1,"d_fin")
			ld_d_fin=date(ls_data)	
			ld_a=date(data)
			if ld_a<ld_d_in or ld_a>ld_d_fin then
  				messagebox("Controllo", "Attenzione, la Data Finale non rientra~nnell'Esercizio selezionato!")
   		   ls_colonna="a"
      		POST F_SET_COLUMN(DW_1,LS_COLONNA)
   		end if
			
END CHOOSE

end event

