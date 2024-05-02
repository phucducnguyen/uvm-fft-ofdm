typedef real floating_point;
typedef reg signed [16:0] fixed_point;
const int nfract = 15;
const int nbits = nfract + 2;
const int sf = 1<<(nfract);

class complex_t#(type T=floating_point);
    T real_part;
    T imag_part;

    // Constructor
    function new(T re = T'(0.0), T im = T'(0.0));
        real_part = re;
        imag_part = im;
    endfunction : new

    function T get_real();
        return this.real_part;
    endfunction : get_real

    function T get_imag();
        return this.imag_part;
    endfunction : get_imag

    function void equal(complex_t#(T) rhs);
        this.real_part = rhs.real_part;
        this.imag_part = rhs.imag_part;
    endfunction : equal

    function void equal_real(T rhs);
        this.real_part = rhs;
    endfunction : equal_real

    function void equal_imag(T rhs);
        this.imag_part = rhs;
    endfunction : equal_imag

    function void add(complex_t#(T) a, complex_t#(T) b);
        this.real_part = a.real_part + b.real_part;
        this.imag_part = a.imag_part + b.imag_part;
    endfunction : add

    function void subtract(complex_t#(T) a, complex_t#(T) b);
        this.real_part = a.real_part - b.real_part;
        this.imag_part = a.imag_part - b.imag_part;
    endfunction : subtract

    function void multiply(complex_t#(T) a, complex_t#(T) b);
        this.real_part = (a.real_part*b.real_part) - (a.imag_part*b.imag_part);
        this.imag_part = (a.real_part*b.imag_part) + (a.imag_part*b.real_part);
    endfunction : multiply

    function void multiply_const(complex_t#(T) a, T b);
        this.real_part = a.real_part / b ;
        this.imag_part = a.imag_part / b;
    endfunction : multiply_const

    function void divide_const(complex_t#(T) a, T b);
        assert(b != 0) else begin 
            $error("Error: Divide by ");
        end
        this.real_part = a.real_part / b ;
        this.imag_part = a.imag_part / b;
    endfunction : divide_const

	function T absolute();
		T res;
        res = this.real_part*this.real_part + this.imag_part*this.imag_part;
		return res;
    endfunction : absolute

    function void convert_to_float(complex_t#(T) fp_value); // Convert fixed point to floating point
    endfunction : convert_to_float

    function complex_t#(fixed_point) convert_to_fixed(); //complex_t fp_value - Convert floating point to fixed point
        complex_t#(fixed_point) res;
        res = new();
        res.real_part = int'(this.get_real()*sf);
        res.imag_part = int'(this.get_imag()*sf);
        // $display("r: %p - i: %p", this.get_real(), this.get_imag());
        // $display("r: %p - i: %p", res.real_part, res.imag_part);
        if (res.real_part < 0) begin
            res.real_part = (1<<(nbits)) + res.real_part;
            // res.imag_part = (1<<(nbits)) + res.imag_part;
        end
        // $display("r: %p - i: %p", res.real_part, res.imag_part);
        // $display("r: %h", value_real);
        return res;
    endfunction : convert_to_fixed

    function void display(reg[1:0] display = 1);
        if (display == 1) begin
            $display("r: %1.16f - i: %1.16f", this.real_part, this.imag_part);
        end
        else if (display == 0) begin
            $display("r: %7d - i: %7d", this.real_part, this.imag_part);
        end
        else begin
            $display("r: %6h - i: %6h", this.real_part, this.imag_part);
        end
    endfunction : display

endclass

