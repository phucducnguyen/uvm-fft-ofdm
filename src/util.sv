// typedef struct {
//     shortreal real_part;
//     shortreal imag_part;
// ) complex_t;
typedef real floating_point;
typedef reg[16:0] fixed_point;
const int nfract = 15;
const int nbits = nfract + 1;
const int sf = 1<<(nfract);

class complex_t #(type T=floating_point);
    T real_part;
    T imag_part;

    // Constructor
    function new();
        real_part = T'(0.0);
        imag_part = T'(0.0);
    endfunction : new

    function T get_real();
        return this.real_part;
    endfunction : get_real

    function T get_imag();
        return this.imag_part;
    endfunction : get_imag

    function void equal(complex_t rhs);
        this.real_part = T'(rhs.real_part);
        this.imag_part = T'(rhs.imag_part);
    endfunction : equal

    function void equal_real(T rhs);
        this.real_part = rhs;
    endfunction : equal_real

    function void equal_imag(T rhs);
        this.imag_part = rhs;
    endfunction : equal_imag

    function void add(complex_t a, complex_t b);
        this.real_part = T'(a.real_part + b.real_part);
        this.imag_part = T'(a.imag_part + b.imag_part);
    endfunction : add

    function void subtract(complex_t a, complex_t b);
        this.real_part = T'(a.real_part - b.real_part);
        this.imag_part = T'(a.imag_part - b.imag_part);
    endfunction : subtract

    function void multiply(complex_t a, complex_t b);
        this.real_part = T'((a.real_part*b.real_part) - (a.imag_part*b.imag_part));
        this.imag_part = T'((a.real_part*b.imag_part) + (a.imag_part*b.real_part));
    endfunction : multiply

    function void multiply_const(complex_t a, T b);
        this.real_part = T'(a.real_part / b) ;
        this.imag_part = T'(a.imag_part / b);
    endfunction : multiply_const

    function void divide_const(complex_t a, T b);
        assert(b != 0) else begin 
            $error("Error: Divide by ");
        end
        this.real_part = T'(a.real_part / b) ;
        this.imag_part = T'(a.imag_part / b);
    endfunction : divide_const

    function void convert_to_float(complex_t fp_value); // Convert fixed point to floating point
        

    // def mhx(fd):
    // iv=int(fd*sf)
    // if iv<0:
    //     iv=(1<<(nbits))+iv
    // return f"{fd:5f} {iv:x}"
    // int iv_r = int'();
    endfunction : convert_to_float

    function void convert_to_fixed(); //complex_t fp_value - Convert floating point to fixed point
        // int value_real;
        // int value_imag;
        // value_real = int'(this.get_real()*sf);
        // value_imag = int'(this.get_imag()*sf);
        int value_real;
        int value_imag;
        this.real_part = int'(this.get_real()*sf);
        this.imag_part = int'(this.get_imag()*sf);
        // $display("r: %p - i: %p", this.get_real(), this.get_imag());
        // $display("r: %p - i: %p", value_real, value_imag);
        if (this.real_part < 0) begin
            this.real_part = (1<<(nbits)) + value_real;
        end
        // $display("r: %h", value_real);
    endfunction : convert_to_fixed

    function void display();
        $display("r: %1.16f - i: %1.16f", this.real_part, this.imag_part);
    endfunction : display

endclass

// 



// Init 128 complex array
function void init_complex_array_128(complex_t value[127:0]);
    for (int i = 0; i < 128; i++) begin
        value[i] = new();
    end
endfunction : init_complex_array_128

// Two complex_t array - set equal
function void equal_complex_array_128(complex_t lhs[127:0], complex_t rhs[127:0]);
    for (int i = 0; i < 128; i++) begin
        lhs[i].equal(rhs[i]);
    end
endfunction : equal_complex_array_128

// Display complex_t array
function void display_complex_128(complex_t value[127:0]);
    for (int i = 0; i < 128; i++) begin
        value[i].display();
    end
endfunction : display_complex_128

// """Make a bit reversed copy of the input vector.
// Used by both the FFT and IFFT (DIT type code)"""
function void bit_reverse(complex_t in_complex[127:0], complex_t out_complex[127:0]);
    // complex_t out_complex[127:0];
    int ix, qq, wx, rx;
    // for (int ix = 0; ix < 128; ix++) begin
    //     $display("******************INSIDE BIT REVERSE");
    //     in_complex[ix].display();
    //     out_complex[ix].display();
    // end
    for (int ix = 0; ix < 128; ix++) begin
        wx = ix;
        rx = 0;
        for (qq = 0; qq < 7; qq++) begin
            rx <<= 1;
            // $display("******************INSIDE BIT REVERSE - rx: %p", rx);
            if (wx & 1 != 0) begin
                rx |= 1;
                // $display("******************INSIDE BIT REVERSE - INSIDE IF LOOP - rx: %p", rx);
            end
            wx >>= 1;
        end
        out_complex[ix].equal(in_complex[rx]);
        // $display("******************INSIDE BIT REVERSE - rx: %p", rx);
        // $display("******************INSIDE BIT REVERSE - ix: %p", ix);
        // $display("******************INSIDE BIT REVERSE - in_complex[rx]: %p", in_complex[rx]);
        // $display("******************INSIDE BIT REVERSE - out_complex[ix]: %p", out_complex[ix]);
    end
endfunction

function void ifftwiddle_complex(reg [5:0] ix, complex_t rv);
//   complex_t rv;
//   rv=new();
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