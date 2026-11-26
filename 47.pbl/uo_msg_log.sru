forward
global type uo_msg_log from nonvisualobject
end type
end forward

global type uo_msg_log from nonvisualobject
end type
global uo_msg_log uo_msg_log

type variables
string		is_ltext_buffer
integer		ii_priority=2
end variables

forward prototypes
public function integer uf_new_text (string as_text, integer ai_priority)
public function integer uf_manage_msg ()
public function integer uf_show_msg_log ()
public function integer uf_hide_msg_log ()
public function integer uf_leave_msg ()
public function integer uf_catch_msg ()
public function integer uf_manage_msg (string as_status)
end prototypes

public function integer uf_new_text (string as_text, integer ai_priority);
string		ls_text
char			lch_new_text[],lch_parsed[], lch_meta_1, lch_meta_2
boolean		lb_creturn
long			ll_size, ll_count, ll_parsed_count, ll_line_nr

w_msg_log.mle_text.textsize=-8
ls_text= w_msg_log.mle_text.text
if IsNull(ls_text) then ls_text="" 
If not ls_text= "" then ls_text=ls_text + Char(13) + Char(10)
w_msg_log.uf_text(ls_text + as_text)


RETURN 0

end function

public function integer uf_manage_msg ();
If IsValid(w_msg_log) then
	If IsValid(w_msg_log) then
		If w_msg_log.Visible=TRUE then
			w_msg_log.Visible=FALSE
			RETURN 0
		else
			w_msg_log.Visible=TRUE
			w_msg_log.uf_text(is_ltext_buffer)
			RETURN 1
		end if	
	else
		RETURN 0
	end if
else
	RETURN 0
end if



end function

public function integer uf_show_msg_log ();
if w_msg_log.Visible=FALSE then
	w_msg_log.uf_text(is_ltext_buffer)
	w_msg_log.Visible=TRUE
end if

RETURN 1


end function

public function integer uf_hide_msg_log ();

If w_msg_log.Visible=TRUE then
	w_msg_log.Visible=FALSE
	is_ltext_buffer= w_msg_log.mle_text.text
end if
RETURN 0


end function

public function integer uf_leave_msg ();
If IsValid(w_msg_log) then
	is_ltext_buffer=w_msg_log.mle_text.text 
end if


RETURN 1

end function

public function integer uf_catch_msg ();
If IsValid(w_msg_log) then
	CHOOSE CASE ii_priority
		CASE 0
			w_msg_log.mle_text.textsize=-16
		CASE 1
			w_msg_log.mle_text.textsize=-8
		CASE 2
			w_msg_log.mle_text.textsize=-8
		CASE 3
			w_msg_log.mle_text.textsize=-8
	END CHOOSE
	w_msg_log.uf_text(is_ltext_buffer)
end if

RETURN 0


end function

public function integer uf_manage_msg (string as_status);

CHOOSE CASE as_status
	CASE "O"
		IF IsValid(w_msg_log) THEN
			w_msg_log.Visible=TRUE
			RETURN 0
		END IF
	CASE "C"
		IF IsValid(w_msg_log) THEN
			w_msg_log.Visible=FALSE
			RETURN 1
		END IF
END CHOOSE
end function

on uo_msg_log.create
TriggerEvent( this, "constructor" )
end on

on uo_msg_log.destroy
TriggerEvent( this, "destructor" )
end on

