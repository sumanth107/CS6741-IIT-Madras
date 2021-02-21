### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ 9132aea0-7422-11eb-04b7-038d652d0341
using DataFrames

# ╔═╡ bb2d0180-741b-11eb-0949-9755ee4f8b83
md"# CS6741:_Assignment-1_"

# ╔═╡ d25cacc0-741b-11eb-0c16-e90040a90158
md"## Problem 6"

# ╔═╡ d21a9ab0-741b-11eb-1613-7165a3204215
p_range = [i for i in 0:0.125:1]

# ╔═╡ d1543d70-741b-11eb-3119-8f732b1a5e96
pool = [[[-1 for i in 1:8*p];[1 for j in 1:(1-p)*8]] for p in p_range]

# ╔═╡ 2fc69ba0-7421-11eb-36f3-25e825ab7f7e
md"Experimental Solution"

# ╔═╡ dc0d72e0-741b-11eb-120b-c18f43f49fb6
begin
	num = 10^6
	cnt = [0 for i in 1:9]
	for _ in 1:num
		cash = [10 for j in 1:9]
		for i in 1:20	
			x = [rand(k) for k in pool]
			for q in 1:9
				cash[q] += x[q]
			end
		end
		for j in 1:9
			if cash[j] > 9
				cnt[j] += 1
			end
		end
	end
	exp  = [cnt[i]/num	for i in 1:9]		
end

# ╔═╡ 98870e32-7422-11eb-349c-59d633f1a628
DataFrame(p = p_range, probability = exp)

# ╔═╡ 266702c0-7421-11eb-3dce-55cf55175944
md"Theoritical Solution"

# ╔═╡ dbe689f2-741b-11eb-2947-032993ec7953
begin
	prob6 = []
	for p in p_range
		push!(prob6,sum([binomial(20, k)*(p)^k*(1-p)^(20-k) for k in 0:10]))
	end
	prob6
end

# ╔═╡ dbd96a8e-741b-11eb-22be-837df77e400e
DataFrame(p = p_range, Theoritical = prob6, Experimental = exp)

# ╔═╡ Cell order:
# ╠═bb2d0180-741b-11eb-0949-9755ee4f8b83
# ╠═d25cacc0-741b-11eb-0c16-e90040a90158
# ╠═9132aea0-7422-11eb-04b7-038d652d0341
# ╠═d21a9ab0-741b-11eb-1613-7165a3204215
# ╠═d1543d70-741b-11eb-3119-8f732b1a5e96
# ╟─2fc69ba0-7421-11eb-36f3-25e825ab7f7e
# ╠═dc0d72e0-741b-11eb-120b-c18f43f49fb6
# ╠═98870e32-7422-11eb-349c-59d633f1a628
# ╟─266702c0-7421-11eb-3dce-55cf55175944
# ╠═dbe689f2-741b-11eb-2947-032993ec7953
# ╠═dbd96a8e-741b-11eb-22be-837df77e400e
