### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ 6226652e-8c5e-11eb-2778-cf6c6ce8f509
begin
	using Plots
	plotly()
	using PlutoUI
	using FreqTables
	using StatsBase
	using StatsPlots
end

# ╔═╡ bcda0e42-8cd2-11eb-0710-4582f8f04294
using Statistics

# ╔═╡ 3605a5e0-8cd3-11eb-28e6-d1dad4924c0d
using Distributions

# ╔═╡ 7ad4b300-8cd3-11eb-0c8b-5928be781805
using QuadGK

# ╔═╡ 97ca73e0-8d5b-11eb-369e-c5587ce5b784
using RDatasets

# ╔═╡ aa0bc310-8d5b-11eb-28b2-1b16047e2a5e
using DataFrames

# ╔═╡ 03bae3de-92f3-11eb-001d-bfef9bbd5702
using CSV

# ╔═╡ 127387e0-92fb-11eb-3ca5-7d009f12136f
using Dates

# ╔═╡ 3a7223b0-9516-11eb-3383-076741739c2c
using Random

# ╔═╡ 31822420-8cd4-11eb-327d-f31f5e53e49c
md"# Assignment-3"

# ╔═╡ 921c7212-92d1-11eb-2e39-f177ea1bedbd
md"## Problem-1"

# ╔═╡ e0b1f032-92d1-11eb-2dc4-63e26e82b2fb
kl(dist1, dist2) = quadgk(x -> (pdf(dist1,x)*log(pdf(dist1,x)/pdf(dist2,x))), -10, 10)[1]

# ╔═╡ 36a5d2f0-8cd2-11eb-2570-557c9de7ec8c
begin
	q = Normal(0,1)
	prob1 = []
	for i in 1:5
		p = TDist(i)
		push!(prob1, kl(p, q))
	end
	prob1
end

# ╔═╡ 013573c0-8d5c-11eb-3e37-61eb3f6942b3
DataFrame(v=[1,2,3,4,5], KL_Divergence = prob1)

# ╔═╡ 01256e30-8d5c-11eb-314a-c3bf5bac7209
md" ## Problem-2"

# ╔═╡ 8feb37e0-944a-11eb-0672-a55870d9aad7
function conv_n(n)
	con_2 = [sum(pdf(Uniform(0,1),x-k)*pdf(Uniform(0,1),k)*0.01 for k=0:0.01:10) for x=0:0.01:10]
	if n==2
		return con_2
	end
	conv_n = [sum([pdf(Uniform(0,1),x-k) for k=0:0.01:10].*con_2)*0.01 for x=0:0.01:10]
	for i in 4:n
		conv_n = [sum([pdf(Uniform(0,1),x-k) for k=0:0.01:10].*conv_n)*0.01 for x=0:0.01:10]	
	end
	return conv_n
end

# ╔═╡ ee803100-92d5-11eb-2c7d-7bceec617e9d
function kl2(c2, nor)
	q2 = pdf(nor, 0:0.01:10)
	l2 = [c2[i]*log(c2[i]/q2[i])*0.01 for i in 1:1001]
	l2 = filter(x -> !isnan(x), l2)
	return sum(l2)
end

# ╔═╡ 00f2ec80-8d5c-11eb-2dad-9fdbc923e669
begin
	plot(0:0.01:10, conv_n(2), label="Conv-2")
	plot!(Normal(1, 1/6), label="Normal")
end

# ╔═╡ 00c12e20-8d5c-11eb-3055-f581a97cbcef
begin
	plot(0:0.01:10, conv_n(3), label="Conv-3")
	plot!(Normal(1.5, 0.25), label="Normal")
end

# ╔═╡ 0092cb20-8d5c-11eb-1935-dfad49655d6d
begin
	plot(0:0.01:10, conv_n(4), label="Conv-4")
	plot!(Normal(2, 1/3), label="Normal")
end

# ╔═╡ 006356b0-8d5c-11eb-0756-01a193dd9e07
begin
	plot(0:0.01:10, conv_n(5), label="Conv-5")
	plot!(Normal(2.5, (1/12)*5), label="Normal")
end

# ╔═╡ 00339422-8d5c-11eb-2c95-a5d2461e4ab4
begin
	plot(0:0.01:10, conv_n(6), label="Conv-6")
	plot!(Normal(3, (1/12)*6), label="Normal")
end

# ╔═╡ 0003f8a0-8d5c-11eb-0e19-5f7c1dfa5801
begin
	plot(0:0.01:10, conv_n(7), label="Conv-7")
	plot!(Normal(3.5, (1/12)*7), label="Normal")
end

# ╔═╡ a1008520-92d4-11eb-1afb-c3614a5b5724
begin
	plot(0:0.01:10, conv_n(8), label="Conv-8")
	plot!(Normal(4, (1/12)*8), label="Normal")
end

# ╔═╡ a0c63b40-92d4-11eb-2e90-413f2332d34d
begin
	plot(0:0.01:10, conv_n(9), label="Conv-9")
	plot!(Normal(4.5, (1/12)*9), label="Normal")
end

# ╔═╡ b859d870-92d4-11eb-3cda-7775d87277b8
begin
	plot(0:0.01:10, conv_n(10), label="Conv-10")
	plot!(Normal(5, (1/12)*10), label="Normal")
end

# ╔═╡ b8373540-92d4-11eb-226e-4f49d9f5b954
begin
	prob2 = []
	for i in 2:10
		push!(prob2, kl2(conv_n(i), Normal(0.5*i, (1/12)*i)))
	end
	prob2
end

# ╔═╡ b827a4e0-92d4-11eb-25a4-c59436176178
plot(2:10, prob2, title="KL Divergence vs n", xlabel="n", ylabel="KL Divergence", legend=false)

# ╔═╡ b8063a30-92d4-11eb-0e19-edad53321cc1
md"## Problem-3"

# ╔═╡ b7f6a9d0-92d4-11eb-05a2-17962791e8cc
d = [[1 for _ in 1:170]; [2 for _ in 1:145]; [3 for _ in 1:140]; [4 for _ in 1:54]; [5 for _ in 1:140]; [6 for _ in 1:70]; [7 for _ in 1:60]; [8 for _ in 1:60]; [9 for _ in 1:50]; [10 for _ in 1:60]; [11 for _ in 1:40]; [13 for _ in 1:20]; [14 for _ in 1:10]]

# ╔═╡ b7d984e0-92d4-11eb-2fd9-a77842f15e53
skewness(d)

# ╔═╡ b7c95840-92d4-11eb-183c-f336133c09ee
mean(d), median(d), mode(d)

# ╔═╡ ecd0d430-9452-11eb-0192-4f16bdff0ac7
begin
	plot()
	histogram!(d)
	plot!([mean(d), mean(d)], [0, 54], label="Mean", line=(3, :dash, :red))
	plot!([median(d), median(d)], [0, 140], label="Median", line=(3, :dot, :yellow))
	plot!([mode(d), mode(d)], [0, 170], label="Mode", line=(5, :dash, :green))
end

# ╔═╡ b7accf90-92d4-11eb-08be-a72b9e71871e
md"## Problem-4"

# ╔═╡ b79db460-92d4-11eb-27bb-7b4504420842
range_(x) = maximum(x)- minimum(x)

# ╔═╡ a5e7a680-92da-11eb-08d8-711c90d9ae04
begin
	Random.seed!(2)
	prob4 = []
	for i in 1:10000
		push!(prob4, range_(rand(Uniform(0,1), 30)))
	end
	prob4
end

# ╔═╡ a5b1c970-92da-11eb-0d89-5b1fbc0778ce
mean(prob4), median(prob4)

# ╔═╡ af5d1bbe-9463-11eb-3ff3-070e11e36d4e
begin
	plot()
	histogram!(prob4, legend=:topleft, label=false)
	plot!([mean(prob4), mean(prob4)], [0, 460], label="Mean", line=(4, :dash, :red))
	plot!([median(prob4), median(prob4)], [0, 520], label="Median", line=(4, :dash, :green))
	plot!([0.9676, 0.9676], [0, 580], label="Mode", line=(6, :yellow))
end

# ╔═╡ a59da532-92da-11eb-2ec1-4559274daa6d
md"## Problem-6"

# ╔═╡ a5811c80-92da-11eb-276c-513d6bdea038
df = CSV.read("states.csv", DataFrame)

# ╔═╡ a56b2380-92da-11eb-18c9-17fd14dbb74b
df1 = select(df, :Date, :State, :Confirmed)

# ╔═╡ a51bcb00-92da-11eb-3b9f-1f84e32b651f
begin
	w = [unique(df1.Date)[1]]
	for _ in 1:61
		push!(w, w[end]+Day(7))
	end
	w
end	

# ╔═╡ a50b7750-92da-11eb-2b85-fb0b3222113a
begin
	idx = 1
	d6 = Dict()
	for x in unique(df1.Date)
		if x < w[idx+1]
			d6[x] = idx
		else
			idx += 1
			d6[x] = idx
		end
	end
	week = [d6[x] for x in df1.Date]
	df1.week = week
end

# ╔═╡ fcf06940-92fc-11eb-0256-634186101aeb
df2 = select(df1, :week, :State, :Confirmed)

# ╔═╡ fcc9804e-92fc-11eb-2523-8b964e75671e
df3 = select(DataFrames.unstack(df2, :State, :Confirmed, allowduplicates=true), Not("India"))

# ╔═╡ 86918960-9300-11eb-1d23-cd8cfd888d72
df4 = select(df3, Not("State Unassigned"))

# ╔═╡ 8672b6c0-9300-11eb-3867-3f93522ad69a
function weekly(df4, col)
	for i in 62:-1:2
		df4[!, col][i] -= df4[!, col][i-1]
	end
end

# ╔═╡ 865f55d0-9300-11eb-2169-29b287d8c896
begin
	for x in names(df4)[2:end]
		weekly(df4, x)
	end
end

# ╔═╡ 7e90eaa0-9308-11eb-2488-01c585ee0d6e
df4

# ╔═╡ 7e07bd70-9308-11eb-0a63-57e594df24a9
function covmat(df)
	nc = ncol(df)
	t = zeros(nc, nc)
	for (i, c1) in enumerate(eachcol(df))
		for (j, c2) in enumerate(eachcol(df))
			sx, sy = skipmissings(c1, c2)
			t[i, j] = cov(collect(sx), collect(sy), corrected=false)
		end
	end
	return t
end

# ╔═╡ e8649660-9313-11eb-11ab-073bee5a5a4d
h1 = covmat(select(df4, Not(:week)))

# ╔═╡ 120b2a50-9315-11eb-0829-017151d5bdd2
heatmap(names(df4)[2:end], names(df4)[2:end], h1)

# ╔═╡ 117245b0-9315-11eb-3bf5-c3a14f77cb21
function cormat(df)
	nc = ncol(df)
	t = zeros(nc, nc)
	for (i, c1) in enumerate(eachcol(df))
		for (j, c2) in enumerate(eachcol(df))
			sx, sy = skipmissings(c1, c2)
			t[i, j] = cor(collect(sx), collect(sy))
		end
	end
	return t
end

# ╔═╡ 11116100-9315-11eb-3fe2-5f97e23762e7
h2 = cormat(select(df4, Not(:week)))

# ╔═╡ c8157070-937f-11eb-02d7-d5cb63a6ec16
heatmap(names(df4)[2:end], names(df4)[2:end], h2)

# ╔═╡ edcd0c60-937f-11eb-1487-2b93866aece9
function spearmat(df)
	nc = ncol(df)
	t = zeros(nc, nc)
	for (i, c1) in enumerate(eachcol(df))
		for (j, c2) in enumerate(eachcol(df))
			sx, sy = skipmissings(c1, c2)
			t[i, j] = corspearman(collect(sx), collect(sy))
		end
	end
	return t
end

# ╔═╡ edb9f990-937f-11eb-10ab-c3b4690d0820
h3 = spearmat(select(df4, Not(:week)))

# ╔═╡ 0100fc20-9384-11eb-0ca9-abf9ee528c71
heatmap(names(df4)[2:end], names(df4)[2:end], h3)

# ╔═╡ 00b54d20-9384-11eb-0a07-939822033cfd
md"## Problem-7"

# ╔═╡ dd6e8c50-9392-11eb-1203-5d0545b6e262
function OneSidedTail(x)
	return percentile(Normal(), 100-x)
end

# ╔═╡ d497aea0-9396-11eb-1326-bb8ccdab97b1
OneSidedTail(95)

# ╔═╡ c2228d40-949e-11eb-1580-13903c3debc5
round(cdf(Normal(), OneSidedTail(95)), sigdigits=2)

# ╔═╡ d4878200-9396-11eb-0ce6-d716f5d09a42
function OneSidedTail_T(x)
	return percentile(TDist(10), 100-x)
end

# ╔═╡ 0fd204f0-939e-11eb-2931-8f37169d1e65
OneSidedTail_T(95)

# ╔═╡ d53ed322-949e-11eb-1372-ad66eb8a846e
round(cdf(TDist(10), OneSidedTail_T(95)), sigdigits=2)

# ╔═╡ 9bb92d80-949e-11eb-28e5-29b3ba881baa
begin
	plot(Normal(), OneSidedTail(95),5.5, label="Normal", line=(4, :blue), xlim=(-5.5, 5.5))
	plot!(Normal(), -5.5, OneSidedTail(95), label=false, line=(4, :blue), fill=(0,:blue, 0.3))
end

# ╔═╡ 9cd6ab6e-949e-11eb-082e-3da568f2989c
begin
	plot(TDist(10),OneSidedTail_T(95),5.5, label="Student's T", line=(4, :red))
	plot!(TDist(10), -5.5, OneSidedTail_T(95), line=(4, :red), label=false, fill=(0,:red,0.3))
end

# ╔═╡ 0fad65f0-939e-11eb-3143-db94ccc38ff7
begin
	plot(Normal(), OneSidedTail(95),5.5, label="Normal", line=(4, :blue), xlim=(-5.5, 5.5))
	plot!(Normal(), -5.5, OneSidedTail(95), label=false, line=(4, :blue), fill=(0,:blue, 0.3))
	plot!(TDist(10),OneSidedTail_T(95),5.5, label="Student's T", line=(4, :red))
	plot!(TDist(10), -5.5, OneSidedTail_T(95), line=(4, :red), label=false, fill=(0,:red,0.3))
end

# ╔═╡ Cell order:
# ╟─31822420-8cd4-11eb-327d-f31f5e53e49c
# ╠═6226652e-8c5e-11eb-2778-cf6c6ce8f509
# ╠═bcda0e42-8cd2-11eb-0710-4582f8f04294
# ╠═3605a5e0-8cd3-11eb-28e6-d1dad4924c0d
# ╠═7ad4b300-8cd3-11eb-0c8b-5928be781805
# ╠═97ca73e0-8d5b-11eb-369e-c5587ce5b784
# ╠═aa0bc310-8d5b-11eb-28b2-1b16047e2a5e
# ╠═03bae3de-92f3-11eb-001d-bfef9bbd5702
# ╠═127387e0-92fb-11eb-3ca5-7d009f12136f
# ╠═3a7223b0-9516-11eb-3383-076741739c2c
# ╟─921c7212-92d1-11eb-2e39-f177ea1bedbd
# ╠═e0b1f032-92d1-11eb-2dc4-63e26e82b2fb
# ╠═36a5d2f0-8cd2-11eb-2570-557c9de7ec8c
# ╠═013573c0-8d5c-11eb-3e37-61eb3f6942b3
# ╟─01256e30-8d5c-11eb-314a-c3bf5bac7209
# ╠═8feb37e0-944a-11eb-0672-a55870d9aad7
# ╠═ee803100-92d5-11eb-2c7d-7bceec617e9d
# ╠═00f2ec80-8d5c-11eb-2dad-9fdbc923e669
# ╠═00c12e20-8d5c-11eb-3055-f581a97cbcef
# ╠═0092cb20-8d5c-11eb-1935-dfad49655d6d
# ╠═006356b0-8d5c-11eb-0756-01a193dd9e07
# ╠═00339422-8d5c-11eb-2c95-a5d2461e4ab4
# ╠═0003f8a0-8d5c-11eb-0e19-5f7c1dfa5801
# ╠═a1008520-92d4-11eb-1afb-c3614a5b5724
# ╠═a0c63b40-92d4-11eb-2e90-413f2332d34d
# ╠═b859d870-92d4-11eb-3cda-7775d87277b8
# ╠═b8373540-92d4-11eb-226e-4f49d9f5b954
# ╠═b827a4e0-92d4-11eb-25a4-c59436176178
# ╟─b8063a30-92d4-11eb-0e19-edad53321cc1
# ╠═b7f6a9d0-92d4-11eb-05a2-17962791e8cc
# ╠═b7d984e0-92d4-11eb-2fd9-a77842f15e53
# ╠═b7c95840-92d4-11eb-183c-f336133c09ee
# ╠═ecd0d430-9452-11eb-0192-4f16bdff0ac7
# ╟─b7accf90-92d4-11eb-08be-a72b9e71871e
# ╠═b79db460-92d4-11eb-27bb-7b4504420842
# ╠═a5e7a680-92da-11eb-08d8-711c90d9ae04
# ╠═a5b1c970-92da-11eb-0d89-5b1fbc0778ce
# ╠═af5d1bbe-9463-11eb-3ff3-070e11e36d4e
# ╟─a59da532-92da-11eb-2ec1-4559274daa6d
# ╠═a5811c80-92da-11eb-276c-513d6bdea038
# ╠═a56b2380-92da-11eb-18c9-17fd14dbb74b
# ╠═a51bcb00-92da-11eb-3b9f-1f84e32b651f
# ╠═a50b7750-92da-11eb-2b85-fb0b3222113a
# ╠═fcf06940-92fc-11eb-0256-634186101aeb
# ╠═fcc9804e-92fc-11eb-2523-8b964e75671e
# ╠═86918960-9300-11eb-1d23-cd8cfd888d72
# ╠═8672b6c0-9300-11eb-3867-3f93522ad69a
# ╠═865f55d0-9300-11eb-2169-29b287d8c896
# ╠═7e90eaa0-9308-11eb-2488-01c585ee0d6e
# ╠═7e07bd70-9308-11eb-0a63-57e594df24a9
# ╠═e8649660-9313-11eb-11ab-073bee5a5a4d
# ╠═120b2a50-9315-11eb-0829-017151d5bdd2
# ╠═117245b0-9315-11eb-3bf5-c3a14f77cb21
# ╠═11116100-9315-11eb-3fe2-5f97e23762e7
# ╠═c8157070-937f-11eb-02d7-d5cb63a6ec16
# ╠═edcd0c60-937f-11eb-1487-2b93866aece9
# ╠═edb9f990-937f-11eb-10ab-c3b4690d0820
# ╠═0100fc20-9384-11eb-0ca9-abf9ee528c71
# ╟─00b54d20-9384-11eb-0a07-939822033cfd
# ╠═dd6e8c50-9392-11eb-1203-5d0545b6e262
# ╠═d497aea0-9396-11eb-1326-bb8ccdab97b1
# ╠═c2228d40-949e-11eb-1580-13903c3debc5
# ╠═d4878200-9396-11eb-0ce6-d716f5d09a42
# ╠═0fd204f0-939e-11eb-2931-8f37169d1e65
# ╠═d53ed322-949e-11eb-1372-ad66eb8a846e
# ╠═9bb92d80-949e-11eb-28e5-29b3ba881baa
# ╠═9cd6ab6e-949e-11eb-082e-3da568f2989c
# ╠═0fad65f0-939e-11eb-3143-db94ccc38ff7
