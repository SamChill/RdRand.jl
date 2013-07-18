#!/usr/bin/env julia
using Base.Test
using RdRand

function bench(N)
    for i=1:N
        rdrand()
    end
end

rdrand()

N = 10_000_000
t = @elapsed bench(N)

@printf("%i rdrand() calls took %.3f seconds\n", N, t)
@printf("%.3f nanoseconds per call\n", t/N*1e9)
