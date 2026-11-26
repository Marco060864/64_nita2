forward
global type w_magg_qta_merce_cxcopia from w_testa_righe_cx
end type
end forward

global type w_magg_qta_merce_cxcopia from w_testa_righe_cx
integer width = 2903
integer height = 2216
string title = "Maggiorazione per scarsa qyantità"
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = main!
end type
global w_magg_qta_merce_cxcopia w_magg_qta_merce_cxcopia

on w_magg_qta_merce_cxcopia.create
call super::create
end on

on w_magg_qta_merce_cxcopia.destroy
call super::destroy
end on

event open;call super::open;DataWindowChild dwc_sog

integer rtncode

rtncode = dw_2.GetChild('id_sog_commerciale', dwc_sog)

IF rtncode = -1 THEN MessageBox("Error", "Not a DataWindowChild")

// Establish the connection

CONNECT USING SQLCA;

// Set the transaction object for the child

dwc_sog.SetTransObject(SQLCA)

// Populate with values for eastern states

dwc_sog.Retrieve()

// Set transaction object for main DW and retrieve




end event

type st_1 from w_testa_righe_cx`st_1 within w_magg_qta_merce_cxcopia
end type

type dw_1 from w_testa_righe_cx`dw_1 within w_magg_qta_merce_cxcopia
integer width = 2770
integer height = 740
string dataobject = "d_magg_qta_merce_gd"
end type

type dw_2 from w_testa_righe_cx`dw_2 within w_magg_qta_merce_cxcopia
integer y = 796
integer width = 2770
integer height = 1124
string title = "Maggiorazione per scarsa quantità"
string dataobject = "d_magg_per_sog_gd"
end type

type cb_inserisci from w_testa_righe_cx`cb_inserisci within w_magg_qta_merce_cxcopia
integer x = 1202
integer y = 1952
end type

type cb_salva from w_testa_righe_cx`cb_salva within w_magg_qta_merce_cxcopia
integer x = 1490
integer y = 1952
end type

type cb_cancella from w_testa_righe_cx`cb_cancella within w_magg_qta_merce_cxcopia
integer x = 1778
integer y = 1952
end type

type cb_annulla from w_testa_righe_cx`cb_annulla within w_magg_qta_merce_cxcopia
integer x = 2263
integer y = 1952
end type

type cb_ok from w_testa_righe_cx`cb_ok within w_magg_qta_merce_cxcopia
integer x = 2555
integer y = 1952
end type

