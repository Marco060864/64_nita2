forward
global type w_orafo_caus_magazzino_ff from w_caus_magazzino_ff
end type
end forward

global type w_orafo_caus_magazzino_ff from w_caus_magazzino_ff
integer height = 1984
end type
global w_orafo_caus_magazzino_ff w_orafo_caus_magazzino_ff

on w_orafo_caus_magazzino_ff.create
call super::create
end on

on w_orafo_caus_magazzino_ff.destroy
call super::destroy
end on

event open;call super::open;dw_caus_magazzino_ff.object.st_coef_vuoto.Visible=0
dw_caus_magazzino_ff.object.coef_vuoto.Visible=0
end event

type p_msg_log from w_caus_magazzino_ff`p_msg_log within w_orafo_caus_magazzino_ff
end type

type p_crescente from w_caus_magazzino_ff`p_crescente within w_orafo_caus_magazzino_ff
end type

type p_decrescente from w_caus_magazzino_ff`p_decrescente within w_orafo_caus_magazzino_ff
end type

type cb_ok from w_caus_magazzino_ff`cb_ok within w_orafo_caus_magazzino_ff
end type

type cb_annulla from w_caus_magazzino_ff`cb_annulla within w_orafo_caus_magazzino_ff
end type

type cb_nuovo from w_caus_magazzino_ff`cb_nuovo within w_orafo_caus_magazzino_ff
end type

type cb_inserisci from w_caus_magazzino_ff`cb_inserisci within w_orafo_caus_magazzino_ff
end type

type cb_cancella from w_caus_magazzino_ff`cb_cancella within w_orafo_caus_magazzino_ff
end type

type cb_salva from w_caus_magazzino_ff`cb_salva within w_orafo_caus_magazzino_ff
end type

type tab_1 from w_caus_magazzino_ff`tab_1 within w_orafo_caus_magazzino_ff
end type

type tabpage_1 from w_caus_magazzino_ff`tabpage_1 within tab_1
end type

type cb_ricerca from w_caus_magazzino_ff`cb_ricerca within w_orafo_caus_magazzino_ff
end type

type dw_caus_magazzino_ff from w_caus_magazzino_ff`dw_caus_magazzino_ff within w_orafo_caus_magazzino_ff
integer x = 50
integer height = 1692
string dataobject = "d_orafo_caus_magazzino_ff"
end type

event dw_caus_magazzino_ff::itemchanged;call super::itemchanged;

CHOOSE CASE dwo.name
	CASE "mp_qta_cl_clienti", "mp_qta_cl_fornitori", "mp_qta_cl_terzi"
			dw_caus_magazzino_ff.object.st_coef_vuoto.Visible=1
			dw_caus_magazzino_ff.object.coef_vuoto.Visible=1
END CHOOSE

end event

event dw_caus_magazzino_ff::ue_insert;call super::ue_insert;dw_caus_magazzino_ff.object.st_coef_vuoto.Visible=0
dw_caus_magazzino_ff.object.coef_vuoto.Visible=0
end event

event dw_caus_magazzino_ff::retrieveend;call super::retrieveend;

string ls_cli, ls_for, ls_ter

ls_cli = getitemString(1,"mp_qta_cl_clienti")
ls_for = getitemString(1,"mp_qta_cl_fornitori")
ls_ter = getitemString(1,"mp_qta_cl_terzi")

IF (ls_cli='+')OR(ls_for='+')OR(ls_ter='+') THEN
		dw_caus_magazzino_ff.object.st_coef_vuoto.Visible=1
		dw_caus_magazzino_ff.object.coef_vuoto.Visible=1
	ELSE
		dw_caus_magazzino_ff.object.st_coef_vuoto.Visible=0
		dw_caus_magazzino_ff.object.coef_vuoto.Visible=0
END IF

end event

event dw_caus_magazzino_ff::itemfocuschanged;call super::itemfocuschanged;

string ls_cli, ls_for, ls_ter

ls_cli = getitemString(1,"mp_qta_cl_clienti")
ls_for = getitemString(1,"mp_qta_cl_fornitori")
ls_ter = getitemString(1,"mp_qta_cl_terzi")

IF (ls_cli='+')OR(ls_for='+')OR(ls_ter='+') THEN
		dw_caus_magazzino_ff.object.st_coef_vuoto.Visible=1
		dw_caus_magazzino_ff.object.coef_vuoto.Visible=1
	ELSE
		dw_caus_magazzino_ff.object.st_coef_vuoto.Visible=0
		dw_caus_magazzino_ff.object.coef_vuoto.Visible=0
END IF
end event

