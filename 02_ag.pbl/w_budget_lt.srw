forward
global type w_budget_lt from w_np_single_data
end type
end forward

global type w_budget_lt from w_np_single_data
int X=814
int Y=653
int Width=2090
boolean TitleBar=true
string Title="Budget e Premio ad Importo"
end type
global w_budget_lt w_budget_lt

forward prototypes
public subroutine wf_controlla_update ()
end prototypes

public subroutine wf_controlla_update ();long ll_rows,i,j
long ld_per_riga,ld_per_cont,ld_per_app,ld_null,ld_fine,ld_anno_con,ld_anno_riga,ld_anno_app
string ls_tipo_sconto
setnull(ld_null)
ll_rows=dw_single.rowcount()
for i=1 to ll_rows
	ld_per_cont= 0
	ld_anno_con=0
	ld_per_riga=dw_single.getitemnumber(i,"mese")
	ld_anno_riga=dw_single.getitemnumber(i,"anno")
	if not isnull(ld_per_riga) then
		if i>1 then
			for j=i -1 to 1 step -1
				ld_per_app=dw_single.getitemnumber(j,"mese")
				ld_anno_app=dw_single.getitemnumber(j,"anno")				
				if ld_per_app>ld_per_cont and ld_anno_app=ld_anno_riga then 
					ld_per_cont=ld_per_app
					ld_anno_con=1
				end if
			next
			if ld_per_riga<=ld_per_cont and ld_anno_con=1 then 
				dw_single.setitem(i,"mese",ld_per_cont+1)
			end if
		end if
	else
		dw_single.setitem(i,"data_fine",ld_null)
	end if
next

end subroutine

on w_budget_lt.create
call w_np_single_data::create
end on

on w_budget_lt.destroy
call w_np_single_data::destroy
end on

event ue_post_open;call super::ue_post_open;

long 			ll_row
long			ll_id_valuta

ll_row = dw_single.rowcount()

if ll_row <= 0 then
	ll_row = dw_single.insertrow(0)
	dw_single.setitem(ll_row,"anno",year(today()) )
	dw_single.setitem(ll_row,"mese", 1 )
	SELECT 	"par_sistema"."id_valuta"
	INTO		:ll_id_valuta
	FROM 		"par_sistema";
	dw_single.setitem(ll_row,"id_valuta",ll_id_valuta)
end if





end event

type p_crescente from w_np_single_data`p_crescente within w_budget_lt
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_budget_lt
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_budget_lt
int X=51
int Width=1957
string DataObject="d_budget_gd"
BorderStyle BorderStyle=StyleLowered!
end type

event dw_single::ue_insert;call super::ue_insert;
long		ll_n_row
long		ll_row
long		ll_id_valuta
integer		li_mese
integer		li_anno




ll_n_row = this.rowcount()
ll_row = this.getrow()

this.setitem(ll_row,"id_azienda",1)
SELECT 	"par_sistema"."id_valuta"
INTO		:ll_id_valuta
FROM 		"par_sistema";
this.setitem(ll_row,"id_valuta",ll_id_valuta)


if ll_n_row > 1 then
	li_mese = this.getitemnumber(ll_n_row,"mese")
	li_anno = this.getitemnumber(ll_n_row,"anno")
	if not isnull(li_mese) then
		li_mese ++
		if li_mese > 12 then 
			li_mese = 1
			li_anno ++
		end if
		this.setitem(ll_row,"mese",li_mese)
		this.setitem(ll_row,"anno",li_anno)
		this.sort()
		this.setrow(ll_n_row)
		this.setcolumn("mese")
	else
		MESSAGEBOX("ERRORE!","Il periodo precedente non ha data Fine" ) 
		this.deleterow(ll_row)
	end if
end if
end event

event dw_single::updatestart;call super::updatestart;
end event

