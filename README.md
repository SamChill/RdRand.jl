RdRand.jl
=========

## Introduction

The RdRand package provides an interface for using Intel's [RDRAND][rdrand]
instruction, which provides truly random numbers. The instruction is currently
only available on [Ivy Bridge][ivy] processors.

On a 1.8 GHz Intel Core i5 (i5-3427U) each call takes about 50 nanoseconds.

[rdrand]: http://en.wikipedia.org/wiki/RdRand
[ivy]: http://en.wikipedia.org/wiki/Ivy_Bridge_(microarchitecture)

## API

* `rdrand()`: provides a random number on the interval [0,1]
* `rdrand16()`: provides a Uint16 random number
* `rdrand32()`: provides a Uint32 random number
* `rdrand64()`: provides a Uint64 random number
