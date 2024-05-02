// This file include ifft twiddle factory
// and fft twidle factory
function void ifftwiddle_complex(reg [5:0] ix, complex_t rv);
	case(ix)
    0 : begin
        rv.equal_real(1.0);
        rv.equal_imag(0.0);
    end
    1 : begin
        rv.equal_real(0.9987954562051724);
        rv.equal_imag(0.049067674327418015);
    end
    2 : begin
        rv.equal_real(0.9951847266721969);
        rv.equal_imag(0.0980171403295606);
    end
    3 : begin
        rv.equal_real(0.989176509964781);
        rv.equal_imag(0.14673047445536175);
    end
    4 : begin
        rv.equal_real(0.9807852804032304);
        rv.equal_imag(0.19509032201612825);
    end
    5 : begin
        rv.equal_real(0.970031253194544);
        rv.equal_imag(0.24298017990326387);
    end
    6 : begin
        rv.equal_real(0.9569403357322088);
        rv.equal_imag(0.29028467725446233);
    end
    7 : begin
        rv.equal_real(0.9415440651830208);
        rv.equal_imag(0.33688985339222005);
    end
    8 : begin
        rv.equal_real(0.9238795325112867);
        rv.equal_imag(0.3826834323650898);
    end
    9 : begin
        rv.equal_real(0.9039892931234433);
        rv.equal_imag(0.4275550934302821);
    end
    10 :begin
        rv.equal_real(0.881921264348355);
        rv.equal_imag(0.47139673682599764);
    end
    11 :begin
        rv.equal_real(0.8577286100002721);
        rv.equal_imag(0.5141027441932217);
    end
    12 :begin
        rv.equal_real(0.8314696123025452);
        rv.equal_imag(0.5555702330196022);
    end
    13 :begin
        rv.equal_real(0.8032075314806449);
        rv.equal_imag(0.5956993044924334);
    end
    14 :begin
        rv.equal_real(0.773010453362737);
        rv.equal_imag(0.6343932841636455);
    end
    15 :begin
        rv.equal_real(0.7409511253549591);
        rv.equal_imag(0.6715589548470183);
    end
    16 :begin
        rv.equal_real(0.7071067811865476);
        rv.equal_imag(0.7071067811865475);
    end
    17 :begin
        rv.equal_real(0.6715589548470183);
        rv.equal_imag(0.7409511253549591);
    end
    18 :begin
        rv.equal_real(0.6343932841636455);
        rv.equal_imag(0.773010453362737);
    end
    19 :begin
        rv.equal_real(0.5956993044924335);
        rv.equal_imag(0.8032075314806448);
    end
    20 :begin
        rv.equal_real(0.5555702330196023);
        rv.equal_imag(0.8314696123025452);
    end
    21 :begin
        rv.equal_real(0.5141027441932217);
        rv.equal_imag(0.8577286100002721);
    end
    22 :begin
        rv.equal_real(0.4713967368259978);
        rv.equal_imag(0.8819212643483549);
    end
    23 :begin
        rv.equal_real(0.4275550934302822);
        rv.equal_imag(0.9039892931234433);
    end
    24 :begin
        rv.equal_real(0.38268343236508984);
        rv.equal_imag(0.9238795325112867);
    end
    25 :begin
        rv.equal_real(0.33688985339222005);
        rv.equal_imag(0.9415440651830208);
    end
    26 :begin
        rv.equal_real(0.29028467725446233);
        rv.equal_imag(0.9569403357322089);
    end
    27 :begin
        rv.equal_real(0.24298017990326398);
        rv.equal_imag(0.970031253194544);
    end
    28 :begin
        rv.equal_real(0.19509032201612833);
        rv.equal_imag(0.9807852804032304);
    end
    29 :begin
        rv.equal_real(0.14673047445536175);
        rv.equal_imag(0.989176509964781);
    end
    30 :begin
        rv.equal_real(0.09801714032956077);
        rv.equal_imag(0.9951847266721968);
    end
    31 :begin
        rv.equal_real(0.049067674327418126);
        rv.equal_imag(0.9987954562051724);
    end
    32 :begin
        rv.equal_real(0.000000000000000061);
        rv.equal_imag(1.0);
    end
    33 :begin
        rv.equal_real(-0.04906767432741801);
        rv.equal_imag(0.9987954562051724);
    end
    34 :begin
        rv.equal_real(-0.09801714032956065);
        rv.equal_imag(0.9951847266721969);
    end
    35 :begin
        rv.equal_real(-0.14673047445536164);
        rv.equal_imag(0.989176509964781);
    end
    36 :begin
        rv.equal_real(-0.1950903220161282);
        rv.equal_imag(0.9807852804032304);
    end
    37 :begin
        rv.equal_real(-0.24298017990326387);
        rv.equal_imag(0.970031253194544);
    end
    38 :begin
        rv.equal_real(-0.29028467725446216);
        rv.equal_imag(0.9569403357322089);
    end
    39 :begin
        rv.equal_real(-0.33688985339221994);
        rv.equal_imag(0.9415440651830208);
    end
    40 :begin
        rv.equal_real(-0.3826834323650897);
        rv.equal_imag(0.9238795325112867);
    end
    41 :begin
        rv.equal_real(-0.42755509343028186);
        rv.equal_imag(0.9039892931234434);
    end
    42 :begin
        rv.equal_real(-0.4713967368259977);
        rv.equal_imag(0.881921264348355);
    end
    43 :begin
        rv.equal_real(-0.5141027441932217);
        rv.equal_imag(0.8577286100002721);
    end
    44 :begin
        rv.equal_real(-0.555570233019602);
        rv.equal_imag(0.8314696123025455);
    end
    45 :begin
        rv.equal_real(-0.5956993044924334);
        rv.equal_imag(0.8032075314806449);
    end
    46 :begin
        rv.equal_real(-0.6343932841636454);
        rv.equal_imag(0.7730104533627371);
    end
    47 :begin
        rv.equal_real(-0.6715589548470184);
        rv.equal_imag(0.740951125354959);
    end
    48 :begin
        rv.equal_real(-0.7071067811865475);
        rv.equal_imag(0.7071067811865476);
    end
    49 :begin
        rv.equal_real(-0.7409511253549589);
        rv.equal_imag(0.6715589548470186);
    end
    50 :begin
        rv.equal_real(-0.773010453362737);
        rv.equal_imag(0.6343932841636455);
    end
    51 :begin
        rv.equal_real(-0.8032075314806448);
        rv.equal_imag(0.5956993044924335);
    end
    52 :begin
        rv.equal_real(-0.8314696123025453);
        rv.equal_imag(0.5555702330196022);
    end
    53 :begin
        rv.equal_real(-0.857728610000272);
        rv.equal_imag(0.5141027441932218);
    end
    54 :begin
        rv.equal_real(-0.8819212643483549);
        rv.equal_imag(0.47139673682599786);
    end
    55 :begin
        rv.equal_real(-0.9039892931234433);
        rv.equal_imag(0.42755509343028203);
    end
    56 :begin
        rv.equal_real(-0.9238795325112867);
        rv.equal_imag(0.3826834323650899);
    end
    57 :begin
        rv.equal_real(-0.9415440651830207);
        rv.equal_imag(0.33688985339222033);
    end
    58 :begin
        rv.equal_real(-0.9569403357322088);
        rv.equal_imag(0.2902846772544624);
    end
    59 :begin
        rv.equal_real(-0.970031253194544);
        rv.equal_imag(0.24298017990326407);
    end
    60 :begin
        rv.equal_real(-0.9807852804032304);
        rv.equal_imag(0.1950903220161286);
    end
    61 :begin
        rv.equal_real(-0.989176509964781);
        rv.equal_imag(0.1467304744553618);
    end
    62 :begin
        rv.equal_real(-0.9951847266721968);
        rv.equal_imag(0.09801714032956083);
    end
    63 :begin
        rv.equal_real(-0.9987954562051724);
        rv.equal_imag(0.049067674327417966);
        end
    endcase
//   return rv;
endfunction : ifftwiddle_complex

function void fftwiddle_complex(reg [5:0] ix, complex_t rv);
  	case(ix)
    0 :	begin
		rv.equal_real(1.0);
		rv.equal_imag(0.0);
	end
	1 :begin
		rv.equal_real(0.9987954562051724);
		rv.equal_imag(-0.049067674327418015);
		end
	2 :begin
		rv.equal_real(0.9951847266721969);
		rv.equal_imag(-0.0980171403295606);
		end
	3 :begin
		rv.equal_real(0.989176509964781);
		rv.equal_imag(-0.14673047445536175);
		end
	4 :begin
		rv.equal_real(0.9807852804032304);
		rv.equal_imag(-0.19509032201612825);
		end
	5 :begin
		rv.equal_real(0.970031253194544);
		rv.equal_imag(-0.24298017990326387);
		end
	6 :begin
		rv.equal_real(0.9569403357322088);
		rv.equal_imag(-0.29028467725446233);
		end
	7 :begin
		rv.equal_real(0.9415440651830208);
		rv.equal_imag(-0.33688985339222005);
		end
	8 :begin
		rv.equal_real(0.9238795325112867);
		rv.equal_imag(-0.3826834323650898);
		end
	9 :begin
		rv.equal_real(0.9039892931234433);
		rv.equal_imag(-0.4275550934302821);
		end
	10 :begin
		rv.equal_real(0.881921264348355);
		rv.equal_imag(-0.47139673682599764);
		end
	11 :begin
		rv.equal_real(0.8577286100002721);
		rv.equal_imag(-0.5141027441932217);
		end
	12 :begin
		rv.equal_real(0.8314696123025452);
		rv.equal_imag(-0.5555702330196022);
		end
	13 :begin
		rv.equal_real(0.8032075314806449);
		rv.equal_imag(-0.5956993044924334);
		end
	14 :begin
		rv.equal_real(0.773010453362737);
		rv.equal_imag(-0.6343932841636455);
		end
	15 :begin
		rv.equal_real(0.7409511253549591);
		rv.equal_imag(-0.6715589548470183);
		end
	16 :begin
		rv.equal_real(0.7071067811865476);
		rv.equal_imag(-0.7071067811865475);
		end
	17 :begin
		rv.equal_real(0.6715589548470183);
		rv.equal_imag(-0.7409511253549591);
		end
	18 :begin
		rv.equal_real(0.6343932841636455);
		rv.equal_imag(-0.773010453362737);
		end
	19 :begin
		rv.equal_real(0.5956993044924335);
		rv.equal_imag(-0.8032075314806448);
		end
	20 :begin
		rv.equal_real(0.5555702330196023);
		rv.equal_imag(-0.8314696123025452);
		end
	21 :begin
		rv.equal_real(0.5141027441932217);
		rv.equal_imag(-0.8577286100002721);
		end
	22 :begin
		rv.equal_real(0.4713967368259978);
		rv.equal_imag(-0.8819212643483549);
		end
	23 :begin
		rv.equal_real(0.4275550934302822);
		rv.equal_imag(-0.9039892931234433);
		end
	24 :begin
		rv.equal_real(0.38268343236508984);
		rv.equal_imag(-0.9238795325112867);
		end
	25 :begin
		rv.equal_real(0.33688985339222005);
		rv.equal_imag(-0.9415440651830208);
		end
	26 :begin
		rv.equal_real(0.29028467725446233);
		rv.equal_imag(-0.9569403357322089);
		end
	27 :begin
		rv.equal_real(0.24298017990326398);
		rv.equal_imag(-0.970031253194544);
		end
	28 :begin
		rv.equal_real(0.19509032201612833);
		rv.equal_imag(-0.9807852804032304);
		end
	29 :begin
		rv.equal_real(0.14673047445536175);
		rv.equal_imag(-0.989176509964781);
		end
	30 :begin
		rv.equal_real(0.09801714032956077);
		rv.equal_imag(-0.9951847266721968);
		end
	31 :begin
		rv.equal_real(0.049067674327418126);
		rv.equal_imag(-0.9987954562051724);
		end
	32 :begin
		rv.equal_real(6.123233995736766e-17);
		rv.equal_imag(-1.0);
		end
	33 :begin
		rv.equal_real(-0.04906767432741801);
		rv.equal_imag(-0.9987954562051724);
		end
	34 :begin
		rv.equal_real(-0.09801714032956065);
		rv.equal_imag(-0.9951847266721969);
		end
	35 :begin
		rv.equal_real(-0.14673047445536164);
		rv.equal_imag(-0.989176509964781);
		end
	36 :begin
		rv.equal_real(-0.1950903220161282);
		rv.equal_imag(-0.9807852804032304);
		end
	37 :begin
		rv.equal_real(-0.24298017990326387);
		rv.equal_imag(-0.970031253194544);
		end
	38 :begin
		rv.equal_real(-0.29028467725446216);
		rv.equal_imag(-0.9569403357322089);
		end
	39 :begin
		rv.equal_real(-0.33688985339221994);
		rv.equal_imag(-0.9415440651830208);
		end
	40 :begin
		rv.equal_real(-0.3826834323650897);
		rv.equal_imag(-0.9238795325112867);
		end
	41 :begin
		rv.equal_real(-0.42755509343028186);
		rv.equal_imag(-0.9039892931234434);
		end
	42 :begin
		rv.equal_real(-0.4713967368259977);
		rv.equal_imag(-0.881921264348355);
		end
	43 :begin
		rv.equal_real(-0.5141027441932217);
		rv.equal_imag(-0.8577286100002721);
		end
	44 :begin
		rv.equal_real(-0.555570233019602);
		rv.equal_imag(-0.8314696123025455);
		end
	45 :begin
		rv.equal_real(-0.5956993044924334);
		rv.equal_imag(-0.8032075314806449);
		end
	46 :begin
		rv.equal_real(-0.6343932841636454);
		rv.equal_imag(-0.7730104533627371);
		end
	47 :begin
		rv.equal_real(-0.6715589548470184);
		rv.equal_imag(-0.740951125354959);
		end
	48 :begin
		rv.equal_real(-0.7071067811865475);
		rv.equal_imag(-0.7071067811865476);
		end
	49 :begin
		rv.equal_real(-0.7409511253549589);
		rv.equal_imag(-0.6715589548470186);
		end
	50 :begin
		rv.equal_real(-0.773010453362737);
		rv.equal_imag(-0.6343932841636455);
		end
	51 :begin
		rv.equal_real(-0.8032075314806448);
		rv.equal_imag(-0.5956993044924335);
		end
	52 :begin
		rv.equal_real(-0.8314696123025453);
		rv.equal_imag(-0.5555702330196022);
		end
	53 :begin
		rv.equal_real(-0.857728610000272);
		rv.equal_imag(-0.5141027441932218);
		end
	54 :begin
		rv.equal_real(-0.8819212643483549);
		rv.equal_imag(-0.47139673682599786);
		end
	55 :begin
		rv.equal_real(-0.9039892931234433);
		rv.equal_imag(-0.42755509343028203);
		end
	56 :begin
		rv.equal_real(-0.9238795325112867);
		rv.equal_imag(-0.3826834323650899);
		end
	57 :begin
		rv.equal_real(-0.9415440651830207);
		rv.equal_imag(-0.33688985339222033);
		end
	58 :begin
		rv.equal_real(-0.9569403357322088);
		rv.equal_imag(-0.2902846772544624);
		end
	59 :begin
		rv.equal_real(-0.970031253194544);
		rv.equal_imag(-0.24298017990326407);
		end
	60 :begin
		rv.equal_real(-0.9807852804032304);
		rv.equal_imag(-0.1950903220161286);
		end
	61 :begin
		rv.equal_real(-0.989176509964781);
		rv.equal_imag(-0.1467304744553618);
		end
	62 :begin
		rv.equal_real(-0.9951847266721968);
		rv.equal_imag(-0.09801714032956083);
		end
	63 :begin
		rv.equal_real(-0.9987954562051724);	
		rv.equal_imag(-0.049067674327417966);
	end
	endcase
endfunction : fftwiddle_complex