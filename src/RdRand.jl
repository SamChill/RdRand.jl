#!/usr/bin/env julia

module RdRand

export rdrand16, rdrand32, rdrand64, rdrand

const librdrand = joinpath(Pkg.dir("RdRand"), "deps", "librdrand")

rdrand_cpucheck() = ccall( (:cpucheck,librdrand), Int, ())

if rdrand_cpucheck() != 0
    error("RdRand: unsupported cpu")
end

rdrand16() = ccall( (:rdrand16,librdrand), Uint16, ())
rdrand32() = ccall( (:rdrand32,librdrand), Uint32, ())
rdrand64() = ccall( (:rdrand64,librdrand), Uint64, ())
rdrand() = rdrand64()/typemax(Uint64)

end
