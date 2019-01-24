using Pkg
pkg"rm ExamplePackage" # removes from project/manifest
pkgpath = joinpath(DEPOT_PATH[1], "dev", "ExamplePackage")
rm(pkgpath, recursive = true, force=true) # removes from actual filesystem
pkg"add IJulia InstantiateFromURL"
pkg"build"
pkg"precompile"
using InstantiateFromURL
activate_github("QuantEcon/QuantEconLecturePackages", tag = "v0.9.5")
activate_github("QuantEcon/QuantEconLectureAllPackages", tag = "v0.9.5")