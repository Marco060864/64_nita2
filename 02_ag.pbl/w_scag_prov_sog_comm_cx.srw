forward
global type w_scag_prov_sog_comm_cx from w_p_data
end type
type dw_scag_prov_sog_comm_ff from u_dw_master_main within w_scag_prov_sog_comm_cx
end type
type dw_scag_prov_sog_comm_gd from u_dw_master_main within w_scag_prov_sog_comm_cx
end type
end forward

global type w_scag_prov_sog_comm_cx from w_p_data
int Height=1405
boolean TitleBar=true
string Title="Scaglioni provvigioni Soggetto Commerciale"
dw_scag_prov_sog_comm_ff dw_scag_prov_sog_comm_ff
dw_scag_prov_sog_comm_gd dw_scag_prov_sog_comm_gd
end type
global w_scag_prov_sog_comm_cx w_scag_prov_sog_comm_cx

type variables
long il_id_gruppo_agenti
long il_id_sog_comm
end variables

on w_scag_prov_sog_comm_cx.create
int iCurrent
call w_p_data::create
this.dw_scag_prov_sog_comm_ff=create dw_scag_prov_sog_comm_ff
this.dw_scag_prov_sog_comm_gd=create dw_scag_prov_sog_comm_gd
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=dw_scag_prov_sog_comm_ff
this.Control[iCurrent+2]=dw_scag_prov_sog_comm_gd
end on

on w_scag_prov_sog_comm_cx.destroy
call w_p_data::destroy
destroy(this.dw_scag_prov_sog_comm_ff)
destroy(this.dw_scag_prov_sog_comm_gd)
end on

event open;call super::open;Long				ll_id_con_provvigioni
long				ll_id_gruppo_agenti, ll_priorita, ll_id_sog_comm
string			ls_ws, ls_s_id1, ls_s_id2

idw_master = dw_scag_prov_sog_comm_ff
idw_master.is_list = Message.PowerObjectParm
ls_s_id1 = idw_master.is_list.s_identifica[1]
ls_s_id2 = idw_master.is_list.s_identifica[2]
ll_id_gruppo_agenti = idw_master.is_list.l_identifica[1]
ll_id_sog_comm = idw_master.is_list.l_identifica[2]
ls_ws = "S"
il_id_gruppo_agenti = ll_id_gruppo_agenti
il_id_sog_comm = ll_id_sog_comm 
SELECT "con_provvigione"."id_con_provvigioni" 
	  	INTO :ll_id_con_provvigioni
     	FROM "con_provvigione" 
	 	WHERE ("con_provvigione"."id_gruppo_agenti"  = :ll_id_gruppo_agenti  AND
		       "con_provvigione"."id_sog_commerciale"  = :ll_id_sog_comm AND
				 "con_provvigione"."id_cat_com_sc"  is Null  AND
				 "con_provvigione"."id_articolo"  is Null  AND
				 "con_provvigione"."id_cat_com_articolo"  is Null  AND
				 "con_provvigione"."id_con_pagamento" is Null  AND
				 "con_provvigione"."id_con_lis_articolo"  is Null) USING SQLCA ; 
IF (SQLCA.SQLCode = 0) THEN
	RETURN
END IF	
IF (SQLCA.SQLCode = 100) THEN
	SELECT "prior_con_provvigione"."priorita"
		INTO :ll_priorita
     	FROM "prior_con_provvigione" 
	 	WHERE ( "prior_con_provvigione"."gruppo_agente" = :ls_ws AND
		 		  "prior_con_provvigione"."sog_commerciale" = :ls_ws AND
				  "prior_con_provvigione"."con_lis_articolo" <> :ls_ws AND
				  "prior_con_provvigione"."cat_com_sc" <> :ls_ws AND
				  "prior_con_provvigione"."articolo" <> :ls_ws AND
				  "prior_con_provvigione"."cat_com_articolo" <> :ls_ws AND
				  "prior_con_provvigione"."cod_pagamento" <> :ls_ws) USING SQLCA  ;
	INSERT INTO "con_provvigione" ("con_provvigione"."id_gruppo_agenti",  &
										 "con_provvigione"."id_sog_commerciale",  &
										 "con_provvigione"."priorita",  &
										 "con_provvigione"."id_azienda")
 	   VALUES (:ll_id_gruppo_agenti, :ll_id_sog_comm, :ll_priorita, 1) USING SQLCA ;
END IF


		

end event

type p_crescente from w_p_data`p_crescente within w_scag_prov_sog_comm_cx
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_scag_prov_sog_comm_cx
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_scag_prov_sog_comm_cx
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_scag_prov_sog_comm_cx
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_scag_prov_sog_comm_cx
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_scag_prov_sog_comm_cx
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_scag_prov_sog_comm_cx
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_scag_prov_sog_comm_cx
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_scag_prov_sog_comm_cx
int Y=1401
int Height=81
int TabOrder=20
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
long BackColor=79741120
end type

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=19
int Y=105
int Width=2323
end type

type dw_scag_prov_sog_comm_ff from u_dw_master_main within w_scag_prov_sog_comm_cx
int X=46
int Y=161
int Width=2318
int Height=293
int TabOrder=10
string DataObject="d_scag_prov_sog_comm_ff"
end type

event ue_init;call super::ue_init;iudw_children[1] = dw_scag_prov_sog_comm_gd
is_title = "Scaglione Provvigioni Soggetto Commerciale"

end event

type dw_scag_prov_sog_comm_gd from u_dw_master_main within w_scag_prov_sog_comm_cx
int X=46
int Y=501
int Width=2318
int TabOrder=3
string DataObject="d_scag_prov_sog_comm_gd"
boolean VScrollBar=true
end type

event ue_init;call super::ue_init;is_list.s_identifica[1] = "id_con_provvigioni"
is_title = "Scaglioni Provvigioni"
end event

