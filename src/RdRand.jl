#!/usr/bin/env julia

module RdRand

export rdrand16, rdrand32, rdrand64, rdrand

const librdrand = joinpath(dirname(@__FILE__), "..", "deps", "librdrand")

rdrand_cpucheck() = ccall( (:cpucheck,librdrand), Int, ())

if rdrand_cpucheck() != 0
    error("RdRand: unsupported cpu")
end

rdrand16() = ccall( (:rdrand16,librdrand), UInt16, ())
rdrand32() = ccall( (:rdrand32,librdrand), UInt32, ())
rdrand64() = ccall( (:rdrand64,librdrand), UInt64, ())

#rdrand64 should be uniform from 0 to 2^64
#but rdrand() isn't quite uniform on [0,1].
#What does it mean for a floating point number to be
#"uniform" from [0,1]? Here the smallest non-zero
#number is 1/2^64, which is about 5x10^-20.
#Since floating point numbers can represent much
#smaller quantities, should some greater care be taken?
#This function does pass diehard suite of tests.
rdrand() = rdrand64()/typemax(UInt64)

end
