forward
global type w_msg_log from Window
end type
type mle_move from multilineedit within w_msg_log
end type
type mle_text from multilineedit within w_msg_log
end type
end forward

global type w_msg_log from Window
int X=2158
int Y=5
int Width=1143
int Height=469
boolean Visible=false
long BackColor=79741120
boolean Resizable=true
boolean ToolBarVisible=false
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
WindowType WindowType=popup!
mle_move mle_move
mle_text mle_text
end type
global w_msg_log w_msg_log

type variables
long	il_x_pos, il_y_pos
end variables

forward prototypes
public function integer uf_ges_scrollbar ()
public function integer uf_text (string as_text)
end prototypes

public function integer uf_ges_scrollbar ();
long		ll_altezza, ll_alt_font
integer	li_nr_line

ll_altezza= mle_text.height
li_nr_line= mle_text.LineCount()
If li_nr_line< 0 then li_nr_line=1
ll_alt_font= Abs(mle_text.textsize)
If (ll_alt_font * li_nr_line* 8) > ll_altezza then
	mle_text.vscrollbar=TRUE
else
	mle_text.vscrollbar=FALSE
end if
RETURN 0
end function

public function integer uf_text (string as_text);
mle_text.Text = as_text
post uf_ges_scrollbar()

RETURN 0
end function

on w_msg_log.create
this.mle_move=create mle_move
this.mle_text=create mle_text
this.Control[]={ this.mle_move,&
this.mle_text}
end on

on w_msg_log.destroy
destroy(this.mle_move)
destroy(this.mle_text)
end on

event open;this.x= 2200
this.y=1
this.width=1200
this.height= 280
end event

event resize;mle_text.x= 70
mle_text.y=1
mle_text.width=this.width - 110
mle_text.height= this.height - 40
mle_move.height= this.height - 40
uf_ges_scrollbar()
end event

type mle_move from multilineedit within w_msg_log
event ue_lb_dwn pbm_lbuttondown
event ue_lb_up pbm_lbuttonup
event ue_doubleclicked pbm_lbuttondblclk
int Width=65
int Height=421
boolean Border=false
boolean DisplayOnly=true
string Pointer="Arrow!"
long TextColor=33554432
long BackColor=276856960
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event ue_lb_dwn;
il_x_pos= xpos
il_y_pos= ypos

end event

event ue_lb_up;parent.x= parent.x + (xpos - il_x_pos)
parent.y= parent.y + (ypos - il_y_pos)

il_x_pos=0
il_y_pos=0
end event

event ue_doubleclicked;
parent.visible=FALSE
end event

type mle_text from multilineedit within w_msg_log
int X=69
int Width=1025
int Height=421
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean AutoVScroll=true
boolean DisplayOnly=true
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

