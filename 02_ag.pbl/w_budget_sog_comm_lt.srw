forward
global type w_budget_sog_comm_lt from w_np_single_data
end type
end forward

global type w_budget_sog_comm_lt from w_np_single_data
int X=814
int Y=653
int Width=2049
int Height=841
boolean TitleBar=true
string Title="importi di liquidazione provvigioni generale"
end type
global w_budget_sog_comm_lt w_budget_sog_comm_lt

type variables
long il_sog_com
end variables

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

on w_budget_sog_comm_lt.create
call w_np_single_data::create
end on

on w_budget_sog_comm_lt.destroy
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

event open;idw_master = dw_single
is_wintype = "W_NP_SINGLE_DATA"
il_sog_com=message.doubleparm
dw_single.Retrieve(il_sog_com)
this.y = 100
end event

type p_crescente from w_np_single_data`p_crescente within w_budget_sog_comm_lt
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_budget_sog_comm_lt
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_budget_sog_comm_lt
int X=33
int Y=33
int Width=1948
string DataObject="d_budget_sog_commerciale_gd"
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
this.setitem(ll_row,"id_sog_commerciale",il_sog_com)

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

event dw_single::retrieveend;call super::retrieveend;
If rowcount=0 Then
	Integer 	li_ret
	
	Decimal	ld_importo, ld_premio
	Long	   ll_id_valuta, ll_Row
	Integer	li_anno, li_mese
	
	DECLARE c_budget CURSOR FOR
		SELECT	anno, mese, importo, id_valuta, premio
		FROM	   budget
		WHERE	   id_sog_commerciale IS NULL;	
	
	OPEN c_budget;

	
	FETCH c_budget INTO :li_anno, :li_mese, :ld_importo, :ll_id_valuta, :ld_premio;
	
	CHOOSE CASE SQLCA.SQLCODE
		CASE -1
			MessageBox("Budget e Premi ad Importo", SQLCA.SQLERRTEXT)
		CASE 0
			li_ret = Messagebox("Budget e Premi ad Importo", "Vuoi riportare gli Importi impostati nei parametri di sistema", Question!, YesNo!, 1)
			If li_ret = 1 Then
				DO
					dw_single.InsertRow(0)
					dw_single.ScrollToRow(999)
					ll_row = dw_single.GetRow()
					
					dw_single.Object.id_sog_commerciale[ll_row] = il_sog_com					
					dw_single.Object.anno[ll_row] = li_anno
					dw_single.Object.mese[ll_row] = li_mese
					dw_single.Object.importo[ll_row] = ld_importo
					dw_single.Object.id_valuta[ll_row] = ll_id_valuta
					dw_single.Object.premio[ll_row] = ld_premio
					
					FETCH c_budget INTO :li_anno, :li_mese, :ld_importo, :ll_id_valuta, :ld_premio;
					If SQLCA.SQLCODE = -1 Then
						MessageBox("Budget e Premi ad Importo", SQLCA.SQLERRTEXT)
					End If
				LOOP WHILE SQLCA.SQLCODE = 0
			End If
		END CHOOSE
	CLOSE c_budget;
End If
end event

