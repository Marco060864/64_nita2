forward
global type u_ges_ordini from nonvisualobject
end type
end forward

global type u_ges_ordini from nonvisualobject
end type
global u_ges_ordini u_ges_ordini

forward prototypes
public function integer apri_lista (long al_id_cliente, long al_id_art_originale, long al_id_documento, long al_id_sorgente)
end prototypes

public function integer apri_lista (long al_id_cliente, long al_id_art_originale, long al_id_documento, long al_id_sorgente);s_new_ordini new_ordini
w_orafo_lista_dis_cliente_gd  w_lista
long ll_ret

new_ordini.s_ll_id_cliente=al_id_cliente
new_ordini.s_ll_id_art_originale=al_id_art_originale
new_ordini.s_ll_id_documento=al_id_documento
new_ordini.s_ll_id_sorgente=al_id_sorgente
OpenWithParm(w_lista, new_ordini)
ll_ret=message.doubleparm


return ll_ret
end function

on u_ges_ordini.create
TriggerEvent( this, "constructor" )
end on

on u_ges_ordini.destroy
TriggerEvent( this, "destructor" )
end on

