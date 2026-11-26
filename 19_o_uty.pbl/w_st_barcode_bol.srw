forward
global type w_st_barcode_bol from w_stampa_001
end type
end forward

global type w_st_barcode_bol from w_stampa_001
end type
global w_st_barcode_bol w_st_barcode_bol

forward prototypes
public function integer wf_check_digit (string cod_barre, integer lunghezza)
public function string wf_crea_codice_barre (string codice)
end prototypes

public function integer wf_check_digit (string cod_barre, integer lunghezza);Integer  li_i, li_pari, li_dispari, li_check_digit, li_decina
Decimal {1} ld_i, ld_app
string stringa[18]
integer i,j1,j2

setnull(li_check_digit)

       
    for i = 1 to (lunghezza - 1)
        stringa[i] = mid(cod_barre,i,1)
    next
   
    i=18
    j1=0
    j2=0
   
    do while (i>0)
        j1 = j1 + integer(stringa[i])
        if (i>1) then j2 = j2 +integer( stringa[i - 1])
        i = i - 2
    loop
       
    j2= j1 * 3 + j2
    j2= 10 - mod(j2,10)
    if j2=10 then j2=0
    li_check_digit = integer(char(48+j2))
   

//    messagebox("Calcolo del Check Digit", "Non è possibile calcolare il Check Digit ~r~nper le tipologie non EAN")


Return li_check_digit


//Integer  li_i, li_pari, li_dispari, li_check_digit, li_decina, li_lunghezza
//Decimal {1} ld_i, ld_app
//
//setnull(li_check_digit)
//li_lunghezza=8
//
//for li_i=1 to li_lunghezza - 1
//	ld_i = li_i/2
//	
//	if ld_i = truncate(li_i/2, 0) then		
//		li_pari = li_pari + Integer(Mid( codice, li_i, 1 ))
//	else		
//		li_dispari = li_dispari + Integer(Mid( codice, li_i, 1 ))
//	end if
//end for
//
//li_check_digit = (li_pari * 3) + li_dispari
//
//ld_app = li_check_digit / 10
//if ld_app = truncate(li_check_digit/10, 0) then		
//	li_check_digit = 0
//else
//	do
//		li_decina += 10
//		
//	loop while li_check_digit > li_decina
//	
//	li_check_digit = li_decina - li_check_digit
//end if
//
//Return li_check_digit
end function

public function string wf_crea_codice_barre (string codice);string result
integer  Left_A, Left_B, Right, First_Flag, Second_Flag, Check_char,FFC, i
char A_o_B[10,5]

A_o_B[1,1] = "A"
A_o_B[1,2] = "A"
A_o_B[1,3] = "A"
A_o_B[1,4] = "A"
A_o_B[1,5] = "A"

A_o_B[2,1] = "A"
A_o_B[2,2] = "B"
A_o_B[2,3] = "A"
A_o_B[2,4] = "B"
A_o_B[2,5] = "B"

A_o_B[3,1] = "A"
A_o_B[3,2] = "B"
A_o_B[3,3] = "B"
A_o_B[3,4] = "A"
A_o_B[3,5] = "B"

A_o_B[4,1] = "A"
A_o_B[4,2] = "B"
A_o_B[4,3] = "B"
A_o_B[4,4] = "B"
A_o_B[4,5] = "A"

A_o_B[5,1] = "B"
A_o_B[5,2] = "A"
A_o_B[5,3] = "A"
A_o_B[5,4] = "B"
A_o_B[5,5] = "B"

A_o_B[6,1] = "B"
A_o_B[6,2] = "B"
A_o_B[6,3] = "A"
A_o_B[6,4] = "A"
A_o_B[6,5] = "B"

A_o_B[7,1] = "B"
A_o_B[7,2] = "B"
A_o_B[7,3] = "B"
A_o_B[7,4] = "A"
A_o_B[7,5] = "A"

A_o_B[8,1] = "B"
A_o_B[8,2] = "A"
A_o_B[8,3] = "B"
A_o_B[8,4] = "A"
A_o_B[8,5] = "B"

A_o_B[9,1] = "B"
A_o_B[9,2] = "A"
A_o_B[9,3] = "B"
A_o_B[9,4] = "B"
A_o_B[9,5] = "A"

A_o_B[10,1] = "B"
A_o_B[10,2] = "B"
A_o_B[10,3] = "A"
A_o_B[10,4] = "B"
A_o_B[10,5] = "A"

Left_A = 48
Left_B = 64
Right = 80
First_Flag = 33
Second_Flag = 96
Check_char = 112
Result = ""


if (Len(codice)<> 13) or (not(IsNumber(codice))) then
	messageBox("Alert", "Il codice non è un numero di 13 cifre")
	return Result
end if

FFC = integer(Mid(codice,1,1))

result  = result + char(FFC + First_Flag)
result  = result + char(integer(Mid(codice,2,1)) + Second_Flag)


for i = 3 to 7
	if  A_o_B[FFC + 1, i - 2 ]  =  "B" then
		
		result  = result + char(integer(Mid(codice,i,1)) + Left_B)
	else
		
		result  = result + char(integer(Mid(codice,i,1)) + Left_A)
	end if


next

result = result + "|"

for i = 8 to 12
	result  = result + char(integer(Mid(codice,i,1)) + Right)
next

result  = result + char(integer(Mid(codice,13,1)) + Check_char)

return Result
end function

event open;call super::open;string ls_stato, ls_fornitore, ls_progressivo, ls_check, ls_codice, ls_codice_ok
long ll_codice

string ls_numero_bol
dw_1.insertrow(1)

ls_numero_bol=message.stringparm

if ls_numero_bol > " " then

	ls_stato='80'
	//ls_fornitore=right(ls_numero_bol, 5)
	ls_fornitore="55555"
	ls_progressivo=right(ls_numero_bol, 5)
	
	ls_codice= ls_stato+ls_fornitore+ls_progressivo
	ls_check=string(wf_check_digit(ls_codice, 13))
	
	ls_codice= ls_stato+ls_fornitore+ls_progressivo+ls_check
	//ls_codice_ok=wf_crea_codice_barre(ls_codice)
	ls_codice_ok=f_crea_codice_a_barre(ls_codice)
	dw_1.setitem(1, "cod_barre", ls_codice_ok)
end if

end event

on w_st_barcode_bol.create
call super::create
end on

on w_st_barcode_bol.destroy
call super::destroy
end on

type dw_1 from w_stampa_001`dw_1 within w_st_barcode_bol
string dataobject = "d_st_barcode_bol"
end type

type sle_pg from w_stampa_001`sle_pg within w_st_barcode_bol
end type

type st_1 from w_stampa_001`st_1 within w_st_barcode_bol
end type

type st_2 from w_stampa_001`st_2 within w_st_barcode_bol
end type

type sle_copie from w_stampa_001`sle_copie within w_st_barcode_bol
end type

type sle_zoom from w_stampa_001`sle_zoom within w_st_barcode_bol
end type

type cb_salva_su_file from w_stampa_001`cb_salva_su_file within w_st_barcode_bol
end type

type cb_7 from w_stampa_001`cb_7 within w_st_barcode_bol
end type

type cb_6 from w_stampa_001`cb_6 within w_st_barcode_bol
end type

type cb_imp_st from w_stampa_001`cb_imp_st within w_st_barcode_bol
end type

type cb_stampa from w_stampa_001`cb_stampa within w_st_barcode_bol
end type

type cb_preview from w_stampa_001`cb_preview within w_st_barcode_bol
end type

type cb_pg_dopo from w_stampa_001`cb_pg_dopo within w_st_barcode_bol
end type

type cb_pg_prima from w_stampa_001`cb_pg_prima within w_st_barcode_bol
end type

type cb_1 from w_stampa_001`cb_1 within w_st_barcode_bol
end type

