module EchogramPyPlot

using PyPlot
using ColorSchemes
using EchogramColorSchemes

export echogram, eg

"""
    echogram(m; vmin = nothing, vmax = nothing, cmap=nothing, range=nothing)

Create publication quality echograms via Matplotlib.

"""
function echogram(m; vmin = nothing, vmax = nothing, cmap=nothing, range=nothing)

    y, x =size(m)
    
    if range==nothing
        top = 0.0
        bottom = y
    elseif isa(range, Number)
        top = 0.0
        bottom = range
    elseif isa(range, Tuple)
        top, bottom = range
    end
    
    stepr = 10^floor(log10(bottom-top))
    stepy = y * stepr / (bottom-top)
    yticks = 0:stepy:y
    yticklabels = top:stepr:bottom
    
    if length(yticks) < 3
        yticks = 0:stepy/5:y
        yticklabels = top:stepr/5:bottom
    end
    
    yticks = floor.(Int, yticks)
    yticklabels = floor.(Int, yticklabels)
    ax = gca()
    ax.invert_yaxis()
    ax.set_yticks(yticks)
    ax.set_yticklabels(yticklabels)

    if cmap == nothing
        cmap = addwhite(EK80) # Default
    end

    if isa(cmap, ColorScheme)
        cmap = cmap.colors
    end

    pcolormesh(m, vmin = vmin, vmax = vmax, cmap=ColorMap(cmap), rasterized=true)
end

"""
    eg(A; vmin = nothing, vmax = nothing, cmap=nothing, range=nothing)

Show a quick interactive echogram of `A`.

"""
function eg(A; vmin = nothing, vmax = nothing, cmap=nothing, range=nothing)
    figure()
    echogram(A; vmin = vmin, vmax = vmax, cmap=cmap, range=range)
    PyPlot.colorbar()
end



end # module
