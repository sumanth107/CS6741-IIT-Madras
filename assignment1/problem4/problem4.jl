### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ 094c7500-740b-11eb-1af7-75f6b0bde653
using DataFrames

# ╔═╡ 43bec8c0-7404-11eb-133d-b1cb5439a150
md"# CS6741: _Assignment - 1_"

# ╔═╡ 609b3e10-7404-11eb-341e-1d2cb552514a
md"## Problem 4"

# ╔═╡ 603fb090-7404-11eb-0ec7-4bad929368c8
special_char = ["~","!","@","#","\$","%","^","&","*","(",")","_","+","=","-","'"]

# ╔═╡ 603e02e0-7404-11eb-0a6f-4d87c6b58cc8
alph = [string(Char(i)) for i in 65:90]

# ╔═╡ 603db4c0-7404-11eb-22d7-3b563f17313e
alph1 = [string(Char(i)) for i in 97:122]

# ╔═╡ 603d66a0-7404-11eb-0d39-1fb84155ab5e
pool = [alph; alph1; [0,1,2,3,4,5,6,7,8,9]; special_char]

# ╔═╡ 5f769430-7404-11eb-0359-2174eebc17c0
begin 
	password = [rand(pool) for _ in 1:8]
	num_4 = 10^6
	cnt = 0
	for i in 1:num_4
		hack = []
		hack = [rand(pool) for _ in 1:8]
		check = [(hack[j] == password[j]) for j in 1:8]
		if sum(check)>1
			cnt += 1
		end
	end
	exp = cnt/num_4
end

# ╔═╡ ce6d32d0-740a-11eb-3a73-a9365bad060b
theory = 1 - (binomial(8,1)*77^7 + 77^8)/78^8

# ╔═╡ f8df97ae-740a-11eb-1f1a-337ae1a54e71
DataFrame(theoritical = theory, experimental = exp)

# ╔═╡ 8cb5f792-740b-11eb-1633-eb52967467f1
error = abs(theory-exp)

# ╔═╡ Cell order:
# ╟─43bec8c0-7404-11eb-133d-b1cb5439a150
# ╟─609b3e10-7404-11eb-341e-1d2cb552514a
# ╠═094c7500-740b-11eb-1af7-75f6b0bde653
# ╠═603fb090-7404-11eb-0ec7-4bad929368c8
# ╠═603e02e0-7404-11eb-0a6f-4d87c6b58cc8
# ╠═603db4c0-7404-11eb-22d7-3b563f17313e
# ╠═603d66a0-7404-11eb-0d39-1fb84155ab5e
# ╠═5f769430-7404-11eb-0359-2174eebc17c0
# ╠═ce6d32d0-740a-11eb-3a73-a9365bad060b
# ╠═f8df97ae-740a-11eb-1f1a-337ae1a54e71
# ╠═8cb5f792-740b-11eb-1633-eb52967467f1
