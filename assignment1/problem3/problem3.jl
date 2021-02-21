### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ 592d8200-7373-11eb-20fc-3bc8db7bf636
using DataFrames

# ╔═╡ f4aad1a2-739c-11eb-2773-f9cb09e0188e
using Plots

# ╔═╡ 142d25b0-73b5-11eb-1999-df6d79d0f2dc
md"# CS6741: _Assignment - 1_"

# ╔═╡ 1f18dcd0-73b5-11eb-1b6e-6f02c7adc8c8
md"## Problem 3"

# ╔═╡ 95b21a50-7374-11eb-3609-ef1ac55ed478
md"With Replacement"

# ╔═╡ e2c3a270-7372-11eb-0244-2f327667cfc0
deck = [i<5 ? "J" : "N" for i in 1:52 ] 

# ╔═╡ 1e177860-7373-11eb-3f79-d3f7b0995f59
begin
	jack1 = []
	for n in 1:5
		c1 = 0
		num = 10^6
		for _ in 1:num
			r1 = [(rand(deck)=="J") for i in 1:5]
			if sum(r1) == n
				c1+=1	
			end
		end
		push!(jack1, c1/num)
	end
end

# ╔═╡ 6c996e80-7373-11eb-1119-2124c9c575ed
theoritical1 = [binomial(5,k)*(4/52)^k*(48/52)^(5-k) for k in 1:5]

# ╔═╡ 6c283620-7373-11eb-259c-3fe7b6880e70
jack1

# ╔═╡ 786fcf90-737a-11eb-22f8-f54cded38f97
error1 = [abs(theoritical1[i] - jack1[i]) for i in 1:5]

# ╔═╡ 92362f70-7373-11eb-0194-af5e56b25ed9
DataFrame(Theoritical = theoritical1, Experimental = jack1)

# ╔═╡ 3a9ef340-739c-11eb-25da-c7b829624c50
begin
	plot(jack1, legend=true, xlabel = "n", ylabel = "probability", title = "Experiment With Replacement", label = "Experimental")
	plot!(theoritical1, label = "Theoritical")
end

# ╔═╡ 84745870-7374-11eb-3223-795c179b44d9
md"Without Replacement"

# ╔═╡ 1e175150-7373-11eb-2ded-7f2ba47d21b5
begin
	jack2 = []
	for n in 1:5
		c2 = 0
		num = 10^5
		for _ in 1:num
			deck1 = copy(deck)
			r2 = []
			for _1 in 1:5
				temp = rand(deck1)
				push!(r2, temp)
				deleteat!(deck1, findfirst(x->x==temp, deck1))
			end
			if count(y->y=="J", r2) == n
				c2 += 1
			end
		end
		push!(jack2, c2/num)
	end
end

# ╔═╡ 1e16b510-7373-11eb-1944-1ff2ce66e1e9
theoritical2 = [binomial(4,k)*binomial(48,5-k)/binomial(52,5) for k in 1:5]

# ╔═╡ 1e1666f0-7373-11eb-3683-494317363c18
jack2

# ╔═╡ a419b1f0-7399-11eb-196b-53384dd2e78a
error2 = [abs(theoritical2[i] - jack2[i]) for i in 1:5]

# ╔═╡ 0f869f80-739e-11eb-32a7-f5f260bdc156
begin
	plot(jack2, legend=true, xlabel = "n", ylabel = "probability", title = "Experiment With Replacement", label = "Experimental")
	plot!(theoritical2, label = "Theoritical")
end

# ╔═╡ 1d5fc120-7373-11eb-3422-9dca58b45fb8
DataFrame(Theoritical = theoritical2, Experimental = jack2)

# ╔═╡ Cell order:
# ╟─142d25b0-73b5-11eb-1999-df6d79d0f2dc
# ╟─1f18dcd0-73b5-11eb-1b6e-6f02c7adc8c8
# ╠═592d8200-7373-11eb-20fc-3bc8db7bf636
# ╠═f4aad1a2-739c-11eb-2773-f9cb09e0188e
# ╟─95b21a50-7374-11eb-3609-ef1ac55ed478
# ╠═e2c3a270-7372-11eb-0244-2f327667cfc0
# ╠═1e177860-7373-11eb-3f79-d3f7b0995f59
# ╠═6c996e80-7373-11eb-1119-2124c9c575ed
# ╠═6c283620-7373-11eb-259c-3fe7b6880e70
# ╠═786fcf90-737a-11eb-22f8-f54cded38f97
# ╠═92362f70-7373-11eb-0194-af5e56b25ed9
# ╠═3a9ef340-739c-11eb-25da-c7b829624c50
# ╟─84745870-7374-11eb-3223-795c179b44d9
# ╠═1e175150-7373-11eb-2ded-7f2ba47d21b5
# ╠═1e16b510-7373-11eb-1944-1ff2ce66e1e9
# ╠═1e1666f0-7373-11eb-3683-494317363c18
# ╠═a419b1f0-7399-11eb-196b-53384dd2e78a
# ╠═0f869f80-739e-11eb-32a7-f5f260bdc156
# ╠═1d5fc120-7373-11eb-3422-9dca58b45fb8
