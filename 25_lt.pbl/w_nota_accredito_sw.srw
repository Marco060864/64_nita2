forward
global type w_nota_accredito_sw from w_search_main
end type
type st_4 from statictext within w_nota_accredito_sw
end type
end forward

global type w_nota_accredito_sw from w_search_main
int Height=1429
boolean TitleBar=true
string Title="Selezione Partita Aperta"
st_4 st_4
end type
global w_nota_accredito_sw w_nota_accredito_sw

on w_nota_accredito_sw.create
int iCurrent
call w_search_main::create
this.st_4=create st_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=st_4
end on

on w_nota_accredito_sw.destroy
call w_search_main::destroy
destroy(this.st_4)
end on

type cb_cerca from w_search_main`cb_cerca within w_nota_accredito_sw
int Y=261
end type

type dw_lista from w_search_main`dw_lista within w_nota_accredito_sw
int Y=361
string DataObject="d_par_aperta_lt"
end type

event dw_lista::ue_init;call super::ue_init;is_list.s_win_chiave[1] = "id_par_aperta"
end event

event dw_lista::ue_return_values;call super::ue_return_values;is_ricpar.s_id_seg_value[1] = THIS.uf_get_colval("id_par_aperta")

end event

type sle_showsort from w_search_main`sle_showsort within w_nota_accredito_sw
int Y=1021
end type

type cb_modi from w_search_main`cb_modi within w_nota_accredito_sw
int Y=1161
end type

type cb_nuovo from w_search_main`cb_nuovo within w_nota_accredito_sw
int Y=1161
end type

type cb_annulla from w_search_main`cb_annulla within w_nota_accredito_sw
int Y=1161
end type

type cb_ok from w_search_main`cb_ok within w_nota_accredito_sw
int Y=1161
end type

type st_3 from w_search_main`st_3 within w_nota_accredito_sw
int Y=381
end type

type sle_ricerca from w_search_main`sle_ricerca within w_nota_accredito_sw
int Y=261
end type

type sle_filtro from w_search_main`sle_filtro within w_nota_accredito_sw
int Y=141
end type

type st_2 from w_search_main`st_2 within w_nota_accredito_sw
int Y=149
end type

type st_1 from w_search_main`st_1 within w_nota_accredito_sw
int Y=269
end type

type ddlb_tiposel from w_search_main`ddlb_tiposel within w_nota_accredito_sw
int Y=141
end type

type st_4 from statictext within w_nota_accredito_sw
int X=69
int Y=41
int Width=1802
int Height=77
boolean Enabled=false
string Text="Selezionare la Partita Aperta alla quale si riferisce la Nota di Accredito/Addebito."
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

