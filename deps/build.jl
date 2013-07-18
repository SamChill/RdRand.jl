p = pwd()
cd(Pkg.dir("RdRand/deps/"))
run(`make`)
cd(p)
