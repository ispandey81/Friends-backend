using Pkg
Pkg.instantiate()

using PackageCompiler

create_sysimage(:Friends;
    sysimage_path="Friends.so",
    precompile_execution_file="deploy/precompile.jl")