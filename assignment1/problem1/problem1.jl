### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ f50a6b80-7354-11eb-3fc8-b185f2ca05cc
using Plots	

# ╔═╡ 9d8e2e00-7354-11eb-0d8f-93f507243505
md"# CS6741: _Assignment - 1_"

# ╔═╡ e428ac50-7354-11eb-3ea8-7786e5a6d402
md"## Problem 1"

# ╔═╡ 087d35d0-7355-11eb-3758-c1d80641f02a
begin
	N = 10^3
	l = 0
	s = []
	for i in 1:N
		l += rand(Int)
		push!(s, sum(l)/i)
	end
end	

# ╔═╡ 155e5450-7355-11eb-185a-3b52470f9b38
plot(1:N,s, legend=false, xlabel = "Number of choosen integers (N)", ylabel = "Mean", title = "Mean vs N")

# ╔═╡ Cell order:
# ╠═9d8e2e00-7354-11eb-0d8f-93f507243505
# ╟─e428ac50-7354-11eb-3ea8-7786e5a6d402
# ╠═f50a6b80-7354-11eb-3fc8-b185f2ca05cc
# ╠═087d35d0-7355-11eb-3758-c1d80641f02a
# ╠═155e5450-7355-11eb-185a-3b52470f9b38
