forward
global type u_cod_barre from nonvisualobject
end type
end forward

global type u_cod_barre from nonvisualobject
end type
global u_cod_barre u_cod_barre

forward prototypes
public function integer uf_check_digit (string tipo, integer lunghezza, string cod_barre)
public function integer uf_ver_cod_barre (string codice, integer lunghezza, string alfanumerico, string cod_barre, string tipo)
public function string uf_gen_automatica (long id_tipo_cod_barre)
end prototypes

public function integer uf_check_digit (string tipo, integer lunghezza, string cod_barre);

Integer  li_i, li_pari, li_dispari, li_check_digit, li_decina
Decimal {1} ld_i, ld_app

setnull(li_check_digit)
if tipo = 'E' then
	
	for li_i=1 to lunghezza - 1
		ld_i = li_i/2
		
		if ld_i = truncate(li_i/2, 0) then		
			li_pari = li_pari + Integer(Mid( cod_barre, li_i, 1 ))
		else		
			li_dispari = li_dispari + Integer(Mid( cod_barre, li_i, 1 ))
		end if
	end for
	
	li_check_digit = (li_pari * 3) + li_dispari

	ld_app = li_check_digit / 10
	if ld_app = truncate(li_check_digit/10, 0) then		
		li_check_digit = 0
	else
		do
			li_decina += 10
			
		loop while li_check_digit > li_decina
		
		li_check_digit = li_decina - li_check_digit
	end if
else
	messagebox("Calcolo del Check Digit", "Non è possibile calcolare il Check Digit ~r~nper le tipologie non EAN")
end if

Return li_check_digit
end function

public function integer uf_ver_cod_barre (string codice, integer lunghezza, string alfanumerico, string cod_barre, string tipo);

Integer		li_return, li_i

if tipo = 'E' and len(cod_barre) = lunghezza - 1 then
	cod_barre += '0'
end if

if len(cod_barre) <> lunghezza and alfanumerico <> 'S' then
	messagebox("Verifica inserimento codice a barre", &
				  "I codici della tipologia " + codice + ",~r~ndevono essere di " + &
				   string(lunghezza) + " cifre")	
	li_return = -1					
end if

if len(cod_barre) <> lunghezza and alfanumerico = 'S' then
	messagebox("Verifica inserimento codice a barre", &
				  "I codici della tipologia " + codice + ",~r~ndevono essere di " + &
				   string(lunghezza) + " caratteri")	
	li_return = -1
end if

if alfanumerico <> 'S' and not isnumber(cod_barre) then
	messagebox("Verifica inserimento codice a barre", "La tipologia " + codice + &
				  "  ~r~nsupporta solamente codici numerici !!!")
	li_return = -1
end if

Return li_return
end function

public function string uf_gen_automatica (long id_tipo_cod_barre);
String 	ls_return, ls_valore, ls_progressivo, ls_check_digit, ls_tipo, ls_prog_calc, ls_descrizione
Integer	li_lunghezza, li_num_parte, li_lun_prec,  li_check_digit, li_lun_tipo, li_i  
long li_prog_calc

setnull(ls_return)

DECLARE c_parti CURSOR FOR
	SELECT num_parte, lunghezza, valore, progressivo, check_digit, descrizione
	FROM	 parti_tipo_cod_barre
	WHERE  id_tipo_cod_barre = :id_tipo_cod_barre
	ORDER BY num_parte
	;

OPEN c_parti;

if SQLCA.SQLCODE = -1 then
	messagebox("Generazione automatica codice a barre", SQLCA.SQLERRTEXT)
	return '-1'
end if

FETCH NEXT c_parti	INTO	 :li_num_parte, :li_lunghezza, :ls_valore, :ls_progressivo, :ls_check_digit, :ls_descrizione;

if SQLCA.SQLCODE = -1 then
	messagebox("Generazione automatica codice a barre", SQLCA.SQLERRTEXT)
	CLOSE c_parti;	
	return '-1'
end if

do while SQLCA.SQLCODE = 0
	if not isnull(ls_valore) and not isnull(ls_return) then			
		ls_return += mid(ls_valore, 1, li_lunghezza)
	elseif not isnull(ls_valore) and isnull(ls_return) then
		ls_return = mid(ls_valore, 1, li_lunghezza)		
	elseif ls_progressivo = 'S' then		
		
		
		SELECT SUM(lunghezza)
		INTO	 :li_lun_prec
		FROM	 parti_tipo_cod_barre
		WHERE  id_tipo_cod_barre = :id_tipo_cod_barre
		AND	 num_parte < :li_num_parte
		;
		
		if SQLCA.SQLCODE = -1 then
			messagebox("Generazione automatica codice a barre", SQLCA.SQLERRTEXT)
			CLOSE c_parti;			
			return '-1'			
		end if
		
		SELECT CAST(ifnull( MAX(SUBSTR(codice, :li_lun_prec  + 1, :li_lunghezza)), 0, MAX(SUBSTR(codice, :li_lun_prec  + 1, :li_lunghezza))) AS NUMERIC(20)) + 1
		INTO	 :li_prog_calc
		FROM	 cod_barre
		WHERE  id_tipo_cod_barre = :id_tipo_cod_barre
		AND    gen_automatica = 'S'
		;

		choose case SQLCA.SQLCODE
			case -1 
				messagebox("Generazione automatica codice a barre", SQLCA.SQLERRTEXT)
				CLOSE c_parti;
				return '-1'
		end choose
		
		ls_prog_calc = string(li_prog_calc)
		
		
		
		if len(ls_prog_calc) < li_lunghezza then
			for li_i = len(ls_prog_calc) + 1 to li_lunghezza
				ls_prog_calc = '0' + ls_prog_calc
			next
		end if
		
		
		if len(ls_prog_calc) > li_lunghezza then
			messagebox("Generazione automatica codice a barre", "Non è possibile generare il codice, ~r~nil progressivo relativo alla parte " + ls_descrizione + " ha raggiunto le cifre disponibili")
			CLOSE c_parti;			
			return '-1'
		end if		
		
		if not isnull(ls_return) then
			ls_return += string(ls_prog_calc)
		else
			ls_return = string(ls_prog_calc)
		end if
		
	elseif ls_check_digit = 'S' then
		
		SELECT tipo, lunghezza
		INTO	 :ls_tipo, :li_lun_tipo
		FROM	 tipo_cod_barre
		WHERE	 id_tipo_cod_barre = :id_tipo_cod_barre
		;
		
		if SQLCA.SQLCODE = -1 then
			messagebox("Generazione automatica codice a barre", SQLCA.SQLERRTEXT)
			CLOSE c_parti;			
			return '-1'
		end if		
		
		li_check_digit = uf_Check_Digit(ls_tipo, li_lun_tipo, ls_return)

		if not isnull(li_check_digit) then
			ls_return += string(li_check_digit)
		end if
	end if	
	FETCH NEXT c_parti	INTO	 :li_num_parte, :li_lunghezza, :ls_valore, :ls_progressivo, :ls_check_digit, :ls_descrizione;
loop

CLOSE c_parti;

if SQLCA.SQLCODE = -1 then
	messagebox("Generazione automatica codice a barre", SQLCA.SQLERRTEXT)
	return '-1'
end if

return ls_return
end function

on u_cod_barre.create
TriggerEvent( this, "constructor" )
end on

on u_cod_barre.destroy
TriggerEvent( this, "destructor" )
end on

