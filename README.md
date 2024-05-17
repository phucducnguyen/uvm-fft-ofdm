Project

This semester, you are designing a fft and slicing block for a simple OFDM communications system.
There are many trade offs in such systems, but this system is designed to the following specifications:

    128 point FFT (complex)
    Tones are at even numbered bins 4 to 52
    ◦ 24 tones, each tone coded as two bits (4 levels)
    ▪ 48 bits per symbol (One 128 point FFT)
    Tone 55 and 57 are fixed tones (Used for sync and other things)
    ◦ Either may be present
    ◦ Can be used to approximate 100% height

The fft works with complex inputs (From an IQ decoder) The 128 points are provided as a pair of
complex fixed point signed 16 bit numbers with the binary point between bit 14 and 15. This is 1.
notation. The bit above the binary point allows the input to vary between -/+ 1/2^15 or +/- 0.999969.

The input to the FFT comes from an IFFT of the frequency bin data. The frequency bin data is coded
from 2 bits of digital data using 64 inputs to the IFFT. The result is a complex waveform that is
transmitted to the decoder. The data is encoded as 00= 0%, 01=33%, 10=66%, and 11=100%
frequency energy in a bin. The data is provided to the dut.

The DUT FFT converts the transmitted complex waveform into a set of frequency bins, and

Each used frequency bin represents 2 bits of output. This is represented by 4 sliced amplitudes. The
data is encoded at 0%, 33%, 66%, and 100% of full scale. Full scale can be found in the magnitude of
frequency bin 55 or 57 being 100%. The energy levels are coded/decoded as follows:

Value Coded Condition
00 0% <25% full scale
01 33% >=25% and <50%
10 66% >=50% and <75%
11 100% >=75% full scale

The output is in bytes. Each FFT block and slicing (finding the bits for a frequency) results in 48 bits.
The low order two bits are in bin 4, and the upper bits are in bin 52 (24 bins total)

The module has the following ports:

Name Dir Bits Comment
Clk In 1 Positive edge system clock
Reset In 1 Active high asynchronous reset
PushIn In 1 Data is present on the input
FirstData In 1 This is the first data in an FFT block
DinR In 16 Real part of input (coded 1.15 2’s complement)
DinI In 16 Imaginary part of input (coded 1.15 2’s complement)
PushOut Out 1 Data is present on the output
DataOut Out 48 Output data bits
