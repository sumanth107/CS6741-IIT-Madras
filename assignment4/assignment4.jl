### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ 33a95c80-ab76-11eb-0627-99207ded4be3
begin
	using DataFrames
	using StatsBase
	using Distributions
	using Statistics
	using Plots
	using QuadGK
	using StatsPlots
end

# ╔═╡ 7af0d920-ab75-11eb-307a-59fcdf748a80
md"# Assignment-4"

# ╔═╡ 369ab010-ab76-11eb-0d94-3fb0dc30a7d5
md"## Problem-1"

# ╔═╡ 369ab010-ab76-11eb-20d7-f3b529125cd6
md"Monte Carlo Simulations"

# ╔═╡ 366659a0-ab76-11eb-1b33-1b76be944deb
begin
	count_1 = 0
	n1 = 10^6
	for _ in 1:n1
		head_count = 0
		for i in 1:50
			toss = rand(["H", "T"])
			if toss == "H"
				head_count += 1
			end
		end
		if head_count > 29
			count_1 += 1
		end
	end
	count_1/n1
end

# ╔═╡ 366659a0-ab76-11eb-1db7-bb6257cb1154
md"Binomial Distribution"

# ╔═╡ 859c5d80-ab76-11eb-0726-8f2955017c6d
sum([binomial(50,k)*0.5^50 for k in 30:50])

# ╔═╡ 856c9aee-ab76-11eb-0843-71fb837d5b27
md"Central Limit Theorem"

# ╔═╡ 856a5100-ab76-11eb-1a4b-dba0e91257e9
1-cdf(Normal(25, 0.5*sqrt(50)), 29.5)

# ╔═╡ 8529eca0-ab76-11eb-24fe-d79ea5c86025
md"## Problem-2"

# ╔═╡ 83ee05b0-ab80-11eb-0fcf-99157bc0c768
md"CLT Computation"

# ╔═╡ 84f0b430-ab76-11eb-12d1-ddab2e48002c
function f2(p)
	return 1-cdf(Normal(p*50, sqrt(p*(1-p)*50)), 29.5)
end

# ╔═╡ 84ee4330-ab76-11eb-113c-6f3846698f55
begin
	p_vals = [_ for _ in 0:0.00001:1]
	p2 = 0
	for j in p_vals
		if f2(j) >= 0.5
			p2 = j
			break
		end
	end
	p2
end

# ╔═╡ 8aaa6b00-ab80-11eb-16a8-cd1b5f7bb39e
md"Verification: Binomial"

# ╔═╡ 84bea7b0-ab76-11eb-2921-9fb00807dd36
sum([binomial(50,k)*0.59^k * (1-0.59)^(50-k) for k in 30:50])

# ╔═╡ 9c284320-ab80-11eb-00de-55629d71335e
md"Verification: Monte Carlo"

# ╔═╡ 84bc36b0-ab76-11eb-055e-3fe8ca2c5bb7
begin
	count_2 = 0
	n2 = 10^6
	coin = [["H" for i in 1:59];["T" for i in 1:41]]
	for _ in 1:n2
		head_count2 = 0
		for i in 1:50
			toss = rand(coin)
			if toss == "H"
				head_count2 += 1
			end
		end
		if head_count2 > 29
			count_2 += 1
		end
	end
	count_2/n2
end

# ╔═╡ 58557050-ab80-11eb-34f9-1931c5ab7a0b
md"## Problem-3"

# ╔═╡ 58532662-ab80-11eb-234c-63e093f43c7a
function f3(days)
	return 1- cdf(Normal(100*days, 30*sqrt(days)), 3000-0.5)
end

# ╔═╡ 5819edf2-ab80-11eb-1d32-1958598bfd4b
begin
	n = [_ for _ in 1:1000]
	ans3 = 0
	for i in n
		if f3(i) >= 0.95
			ans3 = i
			break
		end
	end
	ans3
end

# ╔═╡ 0ab38332-acef-11eb-04a4-056e1e361662
md"## Problem-4"

# ╔═╡ 0ab13940-acef-11eb-2c44-dbb2c99ece1b
function Conv(D, n)
	pts = 10^6
	smp = []
	for i in 1:pts
		sample = 0
		for _ in 1:n
			sample += rand(D) 
		end
		mn = mean(D)*n
		sd = sqrt(var(D)*n)
		sample = (sample-mn)/sd
		push!(smp, sample)
	end
	smp = Float64.(smp)
	return smp
end

# ╔═╡ 046e9120-ae4a-11eb-150b-657ae91b0c03
mean(Normal()), var(Normal()), skewness(Normal()), kurtosis(Normal())

# ╔═╡ 6f4ac560-afd8-11eb-0c5b-bd5d036893af
md"(a) Uniform distribution between 0 and 1"

# ╔═╡ 25d08b60-ae46-11eb-2a53-813d6aaa2f75
uniform = Conv(Uniform(0,1), 13)

# ╔═╡ 25cabf02-ae46-11eb-3eaf-c975d03f1fbc
mean(uniform), var(uniform), skewness(uniform), kurtosis(uniform)

# ╔═╡ 8bebb850-afd8-11eb-2341-0354d6f2e0c2
md"(b) Binomial distribution with p = 0.01 (n=1)"

# ╔═╡ 06b4528e-afe3-11eb-3e7e-7194532baff9
mean(Binomial(9702, 0.01)), var(Binomial(9702, 0.01)), skewness(Binomial(9702, 0.01)), kurtosis(Binomial(9702, 0.01))

# ╔═╡ 6774c190-ae4a-11eb-1bd1-8b685924fde0
md"(c) Binomial distribution with p = 0.5 (n=1)"

# ╔═╡ 3dac3bce-ae4b-11eb-12af-f5373440a994
bin_2 = Conv(Binomial(1, 0.5), 21)

# ╔═╡ ba925102-afd8-11eb-093f-f58a796d434d
mean(bin_2), var(bin_2), skewness(bin_2), kurtosis(bin_2)

# ╔═╡ 97b99fd0-afdd-11eb-18a2-831fa6f73106
md"(d) Chi-square distribution with 3 degrees of freedom"

# ╔═╡ 65f72880-afda-11eb-0695-5577d0eb1d20
chi = Conv(Chisq(3), 268)

# ╔═╡ 8635dba0-afda-11eb-141d-d3cea3c5bb33
mean(chi), var(chi), skewness(chi), kurtosis(chi)

# ╔═╡ f6a9e530-acf0-11eb-0dd8-3783e2c9a723
md"## Problem-5"

# ╔═╡ bf0c7d00-acef-11eb-2eb0-3d75a3c406ea
begin
	plot(0:percentile(Chisq(99), 90)+1, Chisq(99), label=false)
	plot!(percentile(Chisq(99), 90): 200, Chisq(99), fill = (0, :red, 0.3), label=false)
end

# ╔═╡ 0ab000c2-acef-11eb-159e-034874aa29ef
percentile(Chisq(99), 90)

# ╔═╡ 0aaf6480-acef-11eb-23eb-c1c2aa6b4ffa
99*5/117.4068831867789

# ╔═╡ 0aaf1660-acef-11eb-3f59-a9e02959cfa5


# ╔═╡ 09e7a7b0-acef-11eb-054b-b91ec96b8674


# ╔═╡ Cell order:
# ╟─7af0d920-ab75-11eb-307a-59fcdf748a80
# ╠═33a95c80-ab76-11eb-0627-99207ded4be3
# ╟─369ab010-ab76-11eb-0d94-3fb0dc30a7d5
# ╟─369ab010-ab76-11eb-20d7-f3b529125cd6
# ╠═366659a0-ab76-11eb-1b33-1b76be944deb
# ╟─366659a0-ab76-11eb-1db7-bb6257cb1154
# ╠═859c5d80-ab76-11eb-0726-8f2955017c6d
# ╟─856c9aee-ab76-11eb-0843-71fb837d5b27
# ╠═856a5100-ab76-11eb-1a4b-dba0e91257e9
# ╟─8529eca0-ab76-11eb-24fe-d79ea5c86025
# ╟─83ee05b0-ab80-11eb-0fcf-99157bc0c768
# ╠═84f0b430-ab76-11eb-12d1-ddab2e48002c
# ╠═84ee4330-ab76-11eb-113c-6f3846698f55
# ╟─8aaa6b00-ab80-11eb-16a8-cd1b5f7bb39e
# ╠═84bea7b0-ab76-11eb-2921-9fb00807dd36
# ╟─9c284320-ab80-11eb-00de-55629d71335e
# ╠═84bc36b0-ab76-11eb-055e-3fe8ca2c5bb7
# ╟─58557050-ab80-11eb-34f9-1931c5ab7a0b
# ╠═58532662-ab80-11eb-234c-63e093f43c7a
# ╠═5819edf2-ab80-11eb-1d32-1958598bfd4b
# ╟─0ab38332-acef-11eb-04a4-056e1e361662
# ╠═0ab13940-acef-11eb-2c44-dbb2c99ece1b
# ╠═046e9120-ae4a-11eb-150b-657ae91b0c03
# ╟─6f4ac560-afd8-11eb-0c5b-bd5d036893af
# ╠═25d08b60-ae46-11eb-2a53-813d6aaa2f75
# ╠═25cabf02-ae46-11eb-3eaf-c975d03f1fbc
# ╟─8bebb850-afd8-11eb-2341-0354d6f2e0c2
# ╠═06b4528e-afe3-11eb-3e7e-7194532baff9
# ╟─6774c190-ae4a-11eb-1bd1-8b685924fde0
# ╠═3dac3bce-ae4b-11eb-12af-f5373440a994
# ╠═ba925102-afd8-11eb-093f-f58a796d434d
# ╟─97b99fd0-afdd-11eb-18a2-831fa6f73106
# ╠═65f72880-afda-11eb-0695-5577d0eb1d20
# ╠═8635dba0-afda-11eb-141d-d3cea3c5bb33
# ╟─f6a9e530-acf0-11eb-0dd8-3783e2c9a723
# ╠═bf0c7d00-acef-11eb-2eb0-3d75a3c406ea
# ╠═0ab000c2-acef-11eb-159e-034874aa29ef
# ╠═0aaf6480-acef-11eb-23eb-c1c2aa6b4ffa
# ╠═0aaf1660-acef-11eb-3f59-a9e02959cfa5
# ╠═09e7a7b0-acef-11eb-054b-b91ec96b8674
