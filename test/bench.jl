#!/usr/bin/env julia
using Base.Test
using RdRand

function bench_rdrand(N)
    for i=1:N
        rdrand()
    end
end

function bench_rand(N)
    for i=1:N
        rand()
    end
end

#warmup
bench_rdrand(1)
bench_rand(1)

N = 10_000_000
t1 = @elapsed bench_rdrand(N)
t2 = @elapsed bench_rand(N)

@printf("%i rdrand() calls took %.3f seconds\n", N, t1)
@printf("%.3f nanoseconds per call\n", t1/N*1e9)

@printf("%i rand() calls took %.3f seconds\n", N, t2)
@printf("%.3f nanoseconds per call\n", t2/N*1e9)
