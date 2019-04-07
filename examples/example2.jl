#!/usr/bin/env julia

using SimradEK60
using SimradEK60TestData
using EchogramPyPlot
using EchogramColorSchemes
using ColorSchemes
using PyPlot
using LaTeXStrings

filename = EK60_SAMPLE
ps = pings(filename)
ps38 = [p for p in ps if p.frequency == 38000]
Sv38 = Sv(ps38)
r38 = R(ps38)

c = addwhite(ColorSchemes.viridis.colors[1:16:end])
echogram(Sv38, vmin=-95, vmax=-50, cmap=ColorMap("EK500", c.colors, length(c)), range=maximum(r38))
cbar = PyPlot.colorbar()
cbar[:set_label](L" $S_v$ [dB re 1 $m^{-1}$] ")
xlabel("Pings")
ylabel("Range [m]")
savefig("example2.png")
