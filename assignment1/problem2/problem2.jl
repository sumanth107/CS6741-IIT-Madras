### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ 689d8ac0-735d-11eb-0817-434ec70fa224
using Plots

# ╔═╡ f82b11d0-7367-11eb-3f79-6f832f26cb57
using DataFrames

# ╔═╡ 3410a170-735d-11eb-32d5-8755c8b0182e
md"# CS6741: _Assignment - 1_"

# ╔═╡ 4fb81930-735d-11eb-2845-fd88149fa6dc
md"## Problem 2"

# ╔═╡ 52ac2bde-735d-11eb-2924-896ce88677eb
deck = [i<5 ? "J" : "N" for i in 1:52 ] 

# ╔═╡ 52839542-735d-11eb-30b5-c95e5f469c8c
md"With Replacement"

# ╔═╡ 338590c0-7363-11eb-1fff-2df60d1202a8
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

# ╔═╡ 335e59b0-7363-11eb-2452-9ff24a08cd20
jack1

# ╔═╡ 334c5850-7363-11eb-083e-bf5187a7a5fb
plot(jack1, legend=false, xlabel = "n", ylabel = "probability", title = "Experiment with Replacement")

# ╔═╡ 35c38b20-7369-11eb-09b1-1b94dfd778b0
DataFrame(n = 1:5, probability = jack1)

# ╔═╡ af7602d0-7365-11eb-29a3-0dfa9c2301ae
md"Without replacement"

# ╔═╡ af5a6480-7365-11eb-3933-595c9e432177
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

# ╔═╡ af379a40-7365-11eb-0a74-05e2ab5fd2a4
jack2

# ╔═╡ af291b50-7365-11eb-3e90-c943c70d775c
plot(jack2, legend=false, xlabel = "n", ylabel = "probability", title = "Experiment Without Replacement")

# ╔═╡ b08998e0-7369-11eb-1f7b-6787fe61e9b2
DataFrame(n = 1:5, probability = jack2)

# ╔═╡ Cell order:
# ╟─3410a170-735d-11eb-32d5-8755c8b0182e
# ╟─4fb81930-735d-11eb-2845-fd88149fa6dc
# ╠═689d8ac0-735d-11eb-0817-434ec70fa224
# ╠═52ac2bde-735d-11eb-2924-896ce88677eb
# ╟─52839542-735d-11eb-30b5-c95e5f469c8c
# ╠═338590c0-7363-11eb-1fff-2df60d1202a8
# ╠═335e59b0-7363-11eb-2452-9ff24a08cd20
# ╠═f82b11d0-7367-11eb-3f79-6f832f26cb57
# ╠═334c5850-7363-11eb-083e-bf5187a7a5fb
# ╠═35c38b20-7369-11eb-09b1-1b94dfd778b0
# ╟─af7602d0-7365-11eb-29a3-0dfa9c2301ae
# ╠═af5a6480-7365-11eb-3933-595c9e432177
# ╠═af379a40-7365-11eb-0a74-05e2ab5fd2a4
# ╠═af291b50-7365-11eb-3e90-c943c70d775c
# ╠═b08998e0-7369-11eb-1f7b-6787fe61e9b2
