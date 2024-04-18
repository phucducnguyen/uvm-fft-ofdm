`define bit_reverse(output_vec, input_vec) \
	begin \
		int idx; \
		for (idx = 0; idx < $size(input_vec); idx++) begin \
            int reversed_idx = idx; \
            reversed_idx = ((reversed_idx & 0x55) << 1) | ((reversed_idx >> 1) & 0x55); \
            reversed_idx = ((reversed_idx & 0x33) << 2) | ((reversed_idx >> 2) & 0x33); \
            reversed_idx = ((reversed_idx & 0x0F) << 4) | ((reversed_idx >> 4) & 0x0F); \
            output_vec[idx] = input_vec[reversed_idx]; \
        end \
	end
