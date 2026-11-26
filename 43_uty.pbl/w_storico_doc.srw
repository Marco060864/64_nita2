forward
global type w_storico_doc from Window
end type
type cb_2 from commandbutton within w_storico_doc
end type
type dw_storico from datawindow within w_storico_doc
end type
type cb_storico from commandbutton within w_storico_doc
end type
type dw_2 from u_dw_ext_main within w_storico_doc
end type
type dw_1 from u_dw_ext_main within w_storico_doc
end type
type cb_1 from commandbutton within w_storico_doc
end type
type st_1 from statictext within w_storico_doc
end type
end forward

global type w_storico_doc from Window
int X=1051
int Y=480
int Width=2473
int Height=1840
boolean TitleBar=true
string Title="Storico Documenti"
long BackColor=80133307
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
cb_2 cb_2
dw_storico dw_storico
cb_storico cb_storico
dw_2 dw_2
dw_1 dw_1
cb_1 cb_1
st_1 st_1
end type
global w_storico_doc w_storico_doc

type variables
long il_id_documento
end variables

on w_storico_doc.create
this.cb_2=create cb_2
this.dw_storico=create dw_storico
this.cb_storico=create cb_storico
this.dw_2=create dw_2
this.dw_1=create dw_1
this.cb_1=create cb_1
this.st_1=create st_1
this.Control[]={this.cb_2,&
this.dw_storico,&
this.cb_storico,&
this.dw_2,&
this.dw_1,&
this.cb_1,&
this.st_1}
end on

on w_storico_doc.destroy
destroy(this.cb_2)
destroy(this.dw_storico)
destroy(this.cb_storico)
destroy(this.dw_2)
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.st_1)
end on

event open;dw_1.settransobject(sqlca)
dw_1.insertrow(0)

dw_2.settransobject(sqlca)
dw_2.insertrow(0)

dw_storico.settransobject(sqlca)


end event

type cb_2 from commandbutton within w_storico_doc
int X=2135
int Y=688
int Width=247
int Height=92
int TabOrder=40
string Text="&Stampa"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;printsetup()
dw_storico.print()
end event

type dw_storico from datawindow within w_storico_doc
int X=37
int Y=800
int Width=2350
int Height=880
int TabOrder=40
string DataObject="d_storico_doc"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event retrievestart;return 2
end event

event doubleclicked;long ll_id_documento
integer li_size, li_counter

ll_id_documento = dw_storico.getitemnumber(row,"id_documento")

s_list_main lstr_for_win


lstr_for_win.s_modo 				= modo_modifica
lstr_for_win.s_identifica[1]	= "id_documento"
lstr_for_win.l_identifica[1]	= ll_id_documento




OpenWithParm(w_documento_ordine_cx, lstr_for_win)


end event

type cb_storico from commandbutton within w_storico_doc
int X=41
int Y=688
int Width=489
int Height=92
int TabOrder=30
string Text="&Visualizza Storico:"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_id_doc_prov, ll_row, ll_id_docs[]
long ll_ret, ll_ret2, ll_roc, ll_totrows, ll_ultima
integer i

dw_storico.reset()

DATASTORE ds_doc
ds_doc = CREATE DATASTORE
ds_doc.DATAOBJECT = "ds_storico_doc"
ds_doc.SETTRANSOBJECT(SQLCA)
ll_ret = ds_doc.retrieve(il_id_documento)

if ll_ret > 0 then
	FOR i=1 TO ds_doc.rowcount()
		
		ll_totrows = (dw_storico.rowcount()+1)
		
		
		if ll_totrows > 0 then
			ll_ultima = ll_totrows
		else
			ll_ultima = 1
		end if
		
		ll_roc = ds_doc.rowscopy(i,i,Primary!,dw_storico,ll_ultima, Primary!)
	
		if ll_roc > 0 then
			ll_row = dw_storico.rowcount()
			ll_id_doc_prov = dw_storico.getitemnumber(ll_row, "id_riga_doc_provenienza")
			
			DO WHILE ll_id_doc_prov <>0 or not isnull(ll_id_doc_prov)
				ll_ret2 = dw_storico.retrieve(ll_id_doc_prov)
         
				if ll_ret2 > 0 then
					ll_row = dw_storico.rowcount()
					
					if ll_row > 0 then
						ll_id_doc_prov = dw_storico.getitemnumber(ll_row,"id_riga_doc_provenienza")
					else
						ll_id_doc_prov = setnull(ll_id_doc_prov)					
					end if
				else 
					ll_id_doc_prov = setnull(ll_id_doc_prov)
				end if
			LOOP					
			
		else
			ll_id_doc_prov = setnull(ll_id_doc_prov)
		end if
		

	NEXT
end if

destroy ds_doc
end event

type dw_2 from u_dw_ext_main within w_storico_doc
int X=288
int Y=548
int Width=2098
int Height=96
int TabOrder=20
string DataObject="d_doc_selez"
end type

type dw_1 from u_dw_ext_main within w_storico_doc
int X=37
int Y=80
int Width=2350
int Height=452
int TabOrder=50
string DataObject="d_selez_doc"
end type

event itemchanged;integer li_ok
string ls_sql_cond
string ls_dbc[], ls_dwc[], ls_dbv[]

CHOOSE CASE dwo.name
	CASE "da_profilo_cod"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "da_profilo_cod"
		ls_dwc[2] = "da_profilo_des"
		
		li_ok = uf_autofind_col(dwo.Name, "prof_documento", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
	
		IF (li_ok > 0) THEN
			if isnull(this.Getitemstring(1,"a_profilo_cod")) or this.Getitemstring(1,"a_profilo_cod")='' then
		     this.setitem(1,"a_profilo_cod",data)
           this.setitem(1,"a_profilo_des",This.GetItemString(1, "da_profilo_des"))
		   end if	
			RETURN 2
		END IF
		
	CASE "da_profilo_des"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "da_profilo_cod"
		ls_dwc[2] = "da_profilo_des"
		
		li_ok = uf_autofind_col(dwo.Name, "prof_documento", "descrizione", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
	
		IF (li_ok > 0) THEN
			if isnull(this.Getitemstring(1,"a_profilo_cod")) or this.Getitemstring(1,"a_profilo_cod")='' then
		    this.setitem(1,"a_profilo_cod",This.GetItemString(1, "da_profilo_des"))
          this.setitem(1,"a_profilo_des",data)
	      end if  
			RETURN 2
		END IF
		
	case "a_profilo_cod"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "a_profilo_cod"
		ls_dwc[2] = "a_profilo_des"
		
		li_ok = uf_autofind_col(dwo.Name, "prof_documento", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
	CASE "a_profilo_des"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "a_profilo_cod"
		ls_dwc[2] = "a_profilo_des"
		
		li_ok = uf_autofind_col(dwo.Name, "prof_documento", "descrizione", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
END CHOOSE

end event

event ue_set_search;CHOOSE CASE as_nomecol
	CASE	"da_profilo_cod"
		is_search_window="w_cronologia_documenti_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="prof_documento_codice"
	CASE	"da_profilo_des"
		is_search_window="w_cronologia_documenti_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="prof_documento_descrizione"
	CASE	"a_profilo_cod"
		is_search_window="w_cronologia_documenti_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="prof_documento_codice"
	CASE	"a_profilo_des"
		is_search_window="w_cronologia_documenti_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="prof_documento_descrizione"	
END CHOOSE
end event

event ue_use_search;CHOOSE CASE as_nomecol
	CASE	"da_profilo_cod"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_prof_documento",is_ricpar.s_id_seg_value[1])
			uf_set_colval("da_profilo_des",is_ricpar.s_ausil_value[1])
			if isnull(this.Getitemstring(1,"a_profilo_cod")) or this.Getitemstring(1,"a_profilo_cod")='' then
			    uf_set_colval("a_profilo_cod",is_ricpar.s_main_value)
		       uf_set_colval("a_profilo_des",is_ricpar.s_ausil_value[1])
			end if	 
	CASE	"da_profilo_des"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_prof_documento",is_ricpar.s_id_seg_value[1])
			uf_set_colval("da_profilo_cod",is_ricpar.s_ausil_value[1])
			if isnull(this.Getitemstring(1,"a_profilo_cod")) or this.Getitemstring(1,"a_profilo_cod")='' then
			  uf_set_colval("a_profilo_des",is_ricpar.s_main_value)
		     uf_set_colval("a_profilo_cod",is_ricpar.s_ausil_value[1])
		   end if  
	CASE	"a_profilo_cod"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_prof_documento",is_ricpar.s_id_seg_value[1])
			uf_set_colval("a_profilo_des",is_ricpar.s_ausil_value[1])	
	CASE	"a_profilo_des"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_prof_documento",is_ricpar.s_id_seg_value[1])
			uf_set_colval("a_profilo_cod",is_ricpar.s_ausil_value[1])
END CHOOSE
end event

type cb_1 from commandbutton within w_storico_doc
int X=37
int Y=548
int Width=233
int Height=92
int TabOrder=10
string Text="&Ricerca:"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string ls_filtro,ls_codice, ls_descrizione
string ls_a_profilo_cod, ls_da_profilo_cod
date ld_da_data, ld_a_data
string ls_da_num, ls_a_num

w_search_main lw_sm
ls_codice=""
dw_storico.reset()
dw_2.is_ricpar.s_filter_value=ls_codice
dw_2.is_ricpar.s_filter_name="cc_descrizione"

dw_2.is_ricpar.s_sql_cond = ''

ls_da_profilo_cod = dw_1.getitemstring(1,"da_profilo_cod")
ls_a_profilo_cod  = dw_1.getitemstring(1,"a_profilo_cod")
ld_da_data        = dw_1.getitemdate(1,"da_data_doc")
ld_a_data         = dw_1.getitemdate(1,"a_data_doc")
ls_da_num         = dw_1.getitemstring(1,"da_num_doc")
ls_a_num          = dw_1.getitemstring(1,"a_num_doc")

If not(IsNull(ls_a_profilo_cod) OR ls_a_profilo_cod = "") then 
	dw_2.is_ricpar.s_sql_cond = "prof_documento.codice >= '" + ls_da_profilo_cod + "' AND "
	dw_2.is_ricpar.s_sql_cond = dw_2.is_ricpar.s_sql_cond + "prof_documento.codice <= '" + ls_a_profilo_cod + "'"
end if
If not(IsNull(string(ld_a_data)) OR string(ld_a_data) = "") then
	if dw_2.is_ricpar.s_sql_cond <> "" then dw_2.is_ricpar.s_sql_cond = dw_2.is_ricpar.s_sql_cond + " AND "
	dw_2.is_ricpar.s_sql_cond = dw_2.is_ricpar.s_sql_cond + "documento.data_documento >= '" + string(ld_da_data,'yyyy-mm-dd') + "' AND "
	dw_2.is_ricpar.s_sql_cond = dw_2.is_ricpar.s_sql_cond + "documento.data_documento <= '" + string(ld_a_data,'yyyy-mm-dd') + "'" 
end if
If not(IsNull(ls_a_num) OR ls_a_num = "") then
	if dw_2.is_ricpar.s_sql_cond <> "" then dw_2.is_ricpar.s_sql_cond = dw_2.is_ricpar.s_sql_cond + " AND "
	dw_2.is_ricpar.s_sql_cond = dw_2.is_ricpar.s_sql_cond + "documento.num_documento >= '" + ls_da_num + "' AND "
	dw_2.is_ricpar.s_sql_cond = dw_2.is_ricpar.s_sql_cond + "documento.num_documento <= '" + ls_a_num + "'" 
end if


openwithparm(lw_sm,dw_2.is_ricpar,"w_documento_sw")
dw_2.is_ricpar=message.powerobjectparm
if upperbound(dw_2.is_ricpar.s_id_seg_value)>0 then
	il_id_documento=long(dw_2.is_ricpar.s_id_seg_value[1])
	dw_2.setfocus()
end if

SELECT "registro"."tipo_registro" + ' Nr. ' + Cast("registro"."numero" as Char(8)) + ' - Nr.Progr. ' +  Cast("documento"."num_progressivo" as Char(8)) + ' del ' + Cast("documento"."data_registrazione" as Char(10))  as c_descrizione  
	INTO :ls_descrizione  
	FROM "documento" , "registro"
	WHERE ("documento"."id_documento" = :il_id_documento) AND 
			("documento"."id_registro" = "registro"."id_registro" ) ;
			
			
if not isnull(ls_descrizione) or ls_descrizione <> '' then 
	
	dw_2.setitem(1,"c_documento_des", ls_descrizione)
	dw_2.setitem(1,"documento_id_documento", il_id_documento)	
end if

end event

type st_1 from statictext within w_storico_doc
int X=37
int Y=16
int Width=498
int Height=60
boolean Enabled=false
string Text="Filtro Documenti:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

