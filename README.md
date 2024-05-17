# FFT and Slicing Block for OFDM Communication System

Welcome to the FFT and Slicing Block project for a simple OFDM communications system!
This repository contains the design and implementation of a 128-point FFT block and a slicing block, tailored to meet specific OFDM system requirements. Below you will find the detailed specifications, module functionality, and port descriptions.

## Project Overview

This project focuses on the development of a critical component for OFDM communication systems. The primary goals are to implement a 128-point FFT and accurately slice the data to extract encoded information. The system adheres to the following specifications:

### System Specifications

    FFT Size: 128 points (complex)
    Frequency Bins:
        Tones are at even-numbered bins 4 to 52.
        Active Tones: 24 tones, each coded as two bits (4 levels) resulting in 48 bits per symbol (one 128-point FFT).
        Fixed Tones: Bins 55 and 57 are used for synchronization and other purposes.
    Complex Input:
        The FFT accepts complex inputs from an IQ decoder.
        Each of the 128 points is provided as a pair of complex fixed-point signed 16-bit numbers (1.15 format).
    Data Encoding:
        2-bit digital data is mapped to frequency bin data for the IFFT.
        The data encoding levels are:
            00 = 0%
            01 = 33%
            10 = 66%
            11 = 100%
    Data Decoding:
        The FFT output converts the complex waveform into frequency bins.
        Each used frequency bin represents 2 bits of output.
        The decoding levels are:
            <25% full scale = 00
            >=25% and <50% full scale = 01
            >=50% and <75% full scale = 10
            >=75% full scale = 11

### Module Functionality

The module converts the transmitted complex waveform into a set of frequency bins and slices the data to retrieve the encoded information. The output is produced as bytes, with each FFT block and slicing resulting in 48 bits.

### Ports Description
|Name	|Direction	|Bits	|Description|
|----	|---------	|----	|-----------|
|Clk	|In	|1	|Positive edge system clock|
|Reset	|In	|1	|Active high asynchronous reset|
|PushIn	|In	|1	|Data is present on the input|
|FirstData	|In	|1	|This is the first data in an FFT block|
|DinR	|In	|16	|Real part of input (coded 1.15 2’s complement)|
|DinI	|In	|16	|Imaginary part of input (coded 1.15 2’s complement)|
|PushOut	|Out	|1	|Data is present on the output|
|DataOut	|Out	|48	|Output data bits|

### Getting Started

To clone and run this project, execute the following commands:

```bash
git clone https://github.com/phucducnguyen/uvm-fft-ofdm.git
cd uvm-fft-ofdm
```

Thank you for your interest in the FFT and Slicing Block project for OFDM communication systems!
