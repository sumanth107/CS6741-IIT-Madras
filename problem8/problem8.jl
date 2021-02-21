### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ 616927b0-744c-11eb-06b3-ff58ab84cda1
using DataFrames

# ╔═╡ 78f8a300-7448-11eb-1069-c9d33bc843dc
md"# CS6741:_Assignment-1_"

# ╔═╡ 522ede50-7449-11eb-1c2d-2b456baf201f
md"## Problem 8"

# ╔═╡ 522eb740-7449-11eb-0338-b143535d6815
p_range = [i for i in 0:0.125:1]

# ╔═╡ 51e9befe-7449-11eb-0e87-b7cf579cf5bf
pool = [[[-1 for i in 1:8*p];[1 for j in 1:(1-p)*8]] for p in p_range]

# ╔═╡ 9ad27da0-744a-11eb-0733-294d9149e039
function prob8(s) 
	num2 = 10^4
	cnt2 = 0
	if count(i->i==-1, s) == 8
		return 0/0
	end
	while num2 > 0
		cash = 10
		flg = 0
		for i in 1:20
			x = rand(s)
			cash += x
			if cash == 0
				flg = 1
			end
		end
		if (cash > 9) && (flg == 0)
			cnt2 += 1
		end
		if flg == 0
			num2 -= 1
		end
	end
	return cnt2/10^4
end

# ╔═╡ 9aac30f0-744a-11eb-0cd9-f51cc845b36d
exp = [prob8(k) for k in pool]

# ╔═╡ 9a9dd910-744a-11eb-0c94-b9d05beeb6ba
DataFrame(p = p_range, probability = exp)

# ╔═╡ d8a21a3e-7450-11eb-0d11-c98945afd96e
md"Verification of results using conditional probability"

# ╔═╡ d521cd20-7450-11eb-33e3-c9995afd4d89
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

# ╔═╡ ca584400-7450-11eb-141f-91697c74224b
begin 
	t = []
	for p in pool
		num3 = 10^4
		cnt3 = 0
		for _ in 1:num3
			cash = 10
			flg = 0
			for i in 1:20
				x = rand(p)
				cash += x
				if cash == 0
					flg = 1
				end
			end
			if (cash > 9) && (flg == 0)
				cnt3 += 1
			end
		end
		push!(t, cnt3/num3)
	end
	cond = [t[k]/(1-prob7[k]) for k in 1:9]
end

# ╔═╡ 14fab600-7451-11eb-1781-9187d4e2ba0e
DataFrame(p = p_range, Experiment = exp, Conditional = cond)

# ╔═╡ Cell order:
# ╟─78f8a300-7448-11eb-1069-c9d33bc843dc
# ╟─522ede50-7449-11eb-1c2d-2b456baf201f
# ╠═616927b0-744c-11eb-06b3-ff58ab84cda1
# ╠═522eb740-7449-11eb-0338-b143535d6815
# ╠═51e9befe-7449-11eb-0e87-b7cf579cf5bf
# ╠═9ad27da0-744a-11eb-0733-294d9149e039
# ╠═9aac30f0-744a-11eb-0cd9-f51cc845b36d
# ╠═9a9dd910-744a-11eb-0c94-b9d05beeb6ba
# ╟─d8a21a3e-7450-11eb-0d11-c98945afd96e
# ╠═d521cd20-7450-11eb-33e3-c9995afd4d89
# ╠═ca584400-7450-11eb-141f-91697c74224b
# ╠═14fab600-7451-11eb-1781-9187d4e2ba0e
