using Pkg: Pkg
cd(@__DIR__)
Pkg.activate(pwd())
using Remark: Remark

function build()
    dir = Remark.slideshow(@__DIR__, title="LoggingExtras.jl")
end

slideshow_dir = build()

#Remark.open(slideshow_dir)
#exit()

###

using FileWatching
while true
    build()
    @info "Rebuilt"
    FileWatching.watch_folder(joinpath(@__DIR__, "src/"))
end

