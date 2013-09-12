RdRand.jl
=========

## Introduction

The RdRand package provides an interface for using Intel's [RDRAND][rdrand]
instruction, which provides extremely high quality random numbers. The instruction is currently
only available on [Ivy Bridge][ivy] processors.

On a 1.8 GHz Intel Core i5 (i5-3427U) each `rdrand()` call takes about 50
nanoseconds, while `rand()`, which uses a [SIMD Mersenne Twister implementation][mt], takes about 5 nanoseconds.

[rdrand]: http://en.wikipedia.org/wiki/RdRand
[ivy]: http://en.wikipedia.org/wiki/Ivy_Bridge_(microarchitecture)
[mt]: http://www.math.sci.hiroshima-u.ac.jp/~m-mat/MT/SFMT/#dSFMT

## Installation

In the Julia interpreter type:

`Pkg.add("RdRand")`

## API

* `rdrand()`: provides a random number on the interval [0,1]
* `rdrand16()`: provides a Uint16 random number
* `rdrand32()`: provides a Uint32 random number
* `rdrand64()`: provides a Uint64 random number

## Randomness

The random numbers are generated by combining a high quality hardware source of entropy (thermal noise) 
with a cryptographically secure random number generator (CSPRNG). 
Quoting Intel's [guide][guide]:

>With respect to the RNG taxonomy discussed above, the DRNG follows the cascade construction RNG model, using a processor resident entropy source to repeatedly seed a hardware-implemented CSPRNG. Unlike software approaches, it includes a high-quality entropy source implementation that can be sampled quickly to repeatedly seed the CSPRNG with high-quality entropy. Furthermore, it represents a self-contained hardware module that is isolated from software attacks on its internal state. The result is a solution that achieves RNG objectives with considerable robustness: statistical quality (independence, uniform distribution), highly unpredictable random number sequences, high performance, and protection against attack.

![image](https://f.cloud.github.com/assets/1629780/817025/7624f0fc-ef62-11e2-8619-15ff9206831f.png)

[guide]: http://software.intel.com/en-us/articles/intel-digital-random-number-generator-drng-software-implementation-guide
