forward
global type u_debug from nonvisualobject
end type
end forward

global type u_debug from nonvisualobject
end type
global u_debug u_debug

type variables

integer		ii_log_hnd[10]
integer		ii_maxhnd = 10
end variables

forward prototypes
public function integer uf_log_open (string as_filename, integer ai_channel, boolean ab_purge)
public function integer uf_log_close (integer ai_channel)
public function integer uf_log_msg (integer ai_channel, string as_mess)
end prototypes

public function integer uf_log_open (string as_filename, integer ai_channel, boolean ab_purge);

integer	li_retval


if ai_channel > ii_maxhnd then
	li_retval = -1
else
	if ii_log_hnd[ai_channel] <0 then
		if ab_purge then
			li_retval = FileOpen (as_filename, LineMode!, Write!, LockWrite!, Replace!)
		else
			li_retval = FileOpen (as_filename, LineMode!, Write!, LockWrite!, Append!)
		end if
		if isNull (li_retval) then li_retVal = -1
	else
		li_retval = -1
	end if
end if

if li_retval >=0 then ii_log_hnd[ai_channel] = li_retval

return li_retval

end function

public function integer uf_log_close (integer ai_channel);

integer	li_retval

if ai_channel > ii_maxhnd then
	li_retval = -1
else
	if ii_log_hnd[ai_channel] >= 0 then
		
		li_retval = fileclose(ii_log_hnd[ai_channel])
	else
		li_retval = -1
	end if
	if IsNull(li_retval) then li_retval = -1
end if

if li_retval > 0 then ii_log_hnd[ai_channel] = 0

return li_retval

end function

public function integer uf_log_msg (integer ai_channel, string as_mess);

integer	li_retval

if ai_channel > ii_maxhnd then
	li_retval = -1
else
	if ii_log_hnd[ai_channel] >= 0 then
		
		li_retval= filewrite(ii_log_hnd[ai_channel],as_mess)
	else
		
		li_retval = -1
	end if
	if IsNull(li_retval) then li_retval = -1
end if

return li_retval

end function

on u_debug.create
TriggerEvent( this, "constructor" )
end on

on u_debug.destroy
TriggerEvent( this, "destructor" )
end on

event constructor;
integer li_i
for li_i = 1 to ii_maxhnd
	ii_log_hnd[li_i] = -1
next
end event

