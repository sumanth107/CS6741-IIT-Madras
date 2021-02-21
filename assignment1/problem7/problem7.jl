### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ 0301dd20-7433-11eb-0c87-31c7a608b2d8
using DataFrames

# ╔═╡ 1e5f3e70-7431-11eb-1684-7943baec5640
md"# CS6741:_Assignment-1_"

# ╔═╡ 35c4edd0-7431-11eb-2a35-7f79a6c6848a
md"## Problem 7"

# ╔═╡ 35369082-7431-11eb-0905-5300c065da4d
p_range = [i for i in 0:0.125:1]

# ╔═╡ 40cda2d0-7431-11eb-3ffe-475868c57490
pool = [[[-1 for i in 1:8*p];[1 for j in 1:(1-p)*8]] for p in p_range]

# ╔═╡ 40a81970-7431-11eb-114f-676f4063eba9
begin
	num1 = 10^4
	cnt1 = [0 for i in 1:9]
	for _ in 1:num1
		cash = [10 for j in 1:9]
		flg = [0 for j in 1:9]
		for i in 1:20	
			x = [rand(k) for k in pool]
			for q in 1:9
				cash[q] += x[q]
				if cash[q] == 0
					flg[q] = 1
				end
			end
		end
		for j in 1:9
			if flg[j] == 1
				cnt1[j] += 1
			end
		end
	end
	prob7 = [cnt1[i]/num1	for i in 1:9]		
end

# ╔═╡ 405d2dc0-7431-11eb-0875-3b5d1ab4e77e
DataFrame(p = p_range, probability = prob7)

# ╔═╡ Cell order:
# ╟─1e5f3e70-7431-11eb-1684-7943baec5640
# ╟─35c4edd0-7431-11eb-2a35-7f79a6c6848a
# ╠═0301dd20-7433-11eb-0c87-31c7a608b2d8
# ╠═35369082-7431-11eb-0905-5300c065da4d
# ╠═40cda2d0-7431-11eb-3ffe-475868c57490
# ╠═40a81970-7431-11eb-114f-676f4063eba9
# ╠═405d2dc0-7431-11eb-0875-3b5d1ab4e77e
