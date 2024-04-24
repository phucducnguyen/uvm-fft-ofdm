// class complex_data_class;
//     real real_part;
//     real imag_part;

//     function new(real init_real, real init_imag);
//         real_part = init_real;
//         imag_part = init_imag;
//     endfunction

//     // Optionally, you might want to define operations on complex numbers,
//     // like addition, subtraction, multiplication, etc.
//     function complex_data add(complex_data rhs);
//         complex_data result;
//         result.real_part = this.real_part + rhs.real_part;
//         result.imag_part = this.imag_part + rhs.imag_part;
//         return result;
//     endfunction
// endclass

// Define complex data type
typedef struct {
    real real_part;
    real imag_part;
} complex_data;