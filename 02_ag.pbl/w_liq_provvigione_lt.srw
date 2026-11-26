forward
global type w_liq_provvigione_lt from w_np_single_data
end type
end forward

global type w_liq_provvigione_lt from w_np_single_data
int X=814
int Y=653
int Width=2446
int Height=837
boolean TitleBar=true
string Title="importi di liquidazione provvigioni generale"
end type
global w_liq_provvigione_lt w_liq_provvigione_lt

forward prototypes
public subroutine wf_controlla_update ()
end prototypes

public subroutine wf_controlla_update ();long ll_rows,i,j
date ld_per_riga,ld_per_cont,ld_per_app,ld_null,ld_fine
string ls_tipo_sconto
setnull(ld_null)
ll_rows=dw_single.rowcount()
for i=1 to ll_rows
	ld_per_cont= date('01/01/1800')
	ld_per_riga=dw_single.getitemdate(i,"data_inizio")
	if not isnull(ld_per_riga) then
		if i>1 then
			for j=i -1 to 1 step -1
				ld_per_app=dw_single.getitemdate(j,"data_fine")
				if ld_per_app>ld_per_cont then ld_per_cont=ld_per_app
			next
			if ld_per_riga<=ld_per_cont then 
				dw_single.setitem(i,"data_inizio",RelativeDate(ld_per_cont,1))
				ld_per_riga=RelativeDate(ld_per_cont,1)
			end if
			ld_per_app=dw_single.getitemdate(i,"data_fine")
			if ld_per_app<=ld_per_riga  or isnull(ld_per_app) then
				if i<dw_single.rowcount() then
					ld_fine=dw_single.getitemdate(i+1,"data_inizio")
				else
					ld_fine=dw_single.getitemdate(i,"data_inizio")
				end if
				dw_single.setitem(i,"data_fine",RelativeDate(ld_fine, -1))
			end if
		end if
	else
		dw_single.setitem(i,"data_fine",ld_null)
	end if
next

end subroutine

on w_liq_provvigione_lt.create
call w_np_single_data::create
end on

on w_liq_provvigione_lt.destroy
call w_np_single_data::destroy
end on

event ue_post_open;call super::ue_post_open;

long 			ll_row
string		ls_appoggio
long			ll_id_valuta


ll_row = dw_single.rowcount()

if ll_row <= 0 then
	ll_row = dw_single.insertrow(0)
	ls_appoggio = '01/01/'+right(string(today()),2)
	dw_single.setitem(ll_row,"data_inizio",date(ls_appoggio) )
	SELECT 	"par_sistema"."id_valuta"
	INTO		:ll_id_valuta
	FROM 		"par_sistema";
	dw_single.setitem(ll_row,"id_valuta",ll_id_valuta)
end if






end event

type p_crescente from w_np_single_data`p_crescente within w_liq_provvigione_lt
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_liq_provvigione_lt
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_liq_provvigione_lt
int X=33
int Y=33
int Width=2350
string DataObject="d_liq_provvigione_gd"
BorderStyle BorderStyle=StyleLowered!
end type

event dw_single::ue_insert;call super::ue_insert;


long		ll_n_row
long		ll_row
long		ll_id_valuta
date		ld_data



ll_n_row = this.rowcount()
ll_row = this.getrow()

SELECT 	"par_sistema"."id_valuta"
INTO		:ll_id_valuta
FROM 		"par_sistema";
this.setitem(ll_row,"id_valuta",ll_id_valuta)

if ll_n_row > 1 then
	ld_data = this.getitemdate(ll_n_row,"data_fine")
	
	ld_data = RelativeDate(ld_data, 1)
	this.setitem(ll_row,"data_inizio",ld_data)
	this.sort()
	this.setrow(ll_n_row)
	this.setcolumn("data_inizio")
end if
end event

event dw_single::updatestart;call super::updatestart;
end event

