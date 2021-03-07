### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ 48e6fad0-79e9-11eb-0694-93e8f9f86982
using DataFrames

# ╔═╡ d21311f0-7ab0-11eb-10b8-2de5edd903c7
using Dates

# ╔═╡ 4e35e5be-7b4f-11eb-21a2-ef04ec29df1c
begin
	using HTTP
	using JSON
end

# ╔═╡ 183f2590-7cf7-11eb-2407-05edd6fe00b0
using Plots

# ╔═╡ 342876a0-79e9-11eb-0b04-3bfec9cbea7b
md"# _Assignment-2_"

# ╔═╡ 48e77000-79e9-11eb-0507-8189881b04c9
md"## Problem 1"

# ╔═╡ 48e6d3c0-79e9-11eb-2280-4f5a2c56ebf0
df1 = DataFrame(
	religion = ["Agnostic", "Atheist", "Buddhist", "Catholic", "Don't know/refused", "Evangelist Prot", "Hindu", "Historically Black Prot", "Jehovah's Witness", "Jewish"],
	)

# ╔═╡ 48e685a0-79e9-11eb-08c5-adbe76affe7e
begin
	df1."<\$10k" = [27, 12, 27, 418, 15, 575, 1, 228, 20, 19]
	df1."\$10-20k" = [34, 27, 21, 617, 14, 869, 9, 244, 27, 19]
	df1."\$20-30k" = [60,37,30,732,15,1064,7,236,24,25]
	df1."\$30-40k" = [81, 52, 34, 670, 11, 982, 9, 238, 24, 25]
	df1."\$40-50k" = [76, 35, 33, 638, 10, 881, 11, 197, 21, 30]
	df1."\$50-75k" = [137, 70, 58, 1116, 35, 1486, 34, 223, 30, 95]
	df1."\$75-100k" = [122, 52, 60, 666, 15, 1678, 14, 203, 10, 75]
	df1."\$100-150k" = [109, 45, 78, 987, 234, 12, 11, 89, 100, 11]
	df1.">150k"= [84, 10, 18, 200, 700, 22, 22, 12, 87, 1]
	df1."Don't know/refused" = [96, 78, 67, 456, 890, 11, 12, 189, 90, 2]
end

# ╔═╡ 48e5e960-79e9-11eb-2ea9-1b684a0cda14
df1

# ╔═╡ 48e59b40-79e9-11eb-19be-a3759f061cf7
df1_ = sort(DataFrames.stack(df1, 2:11), [:religion, order(:variable, by=length)])

# ╔═╡ 48e4d7f0-79e9-11eb-241e-85d1ba4c219a
df1_tidy = select(df1_, :religion, :variable => :income, :value => :freq)

# ╔═╡ 48a6bd80-79e9-11eb-3e49-0f1b64248fef
md"## Problem 2"

# ╔═╡ 48a4e8c0-79e9-11eb-16c4-5bda8cf022b6
df2 = DataFrame(
	id = ["MX17004" for _ in 1:12],
	year = [2010 for _ in 1:12],
	month = [1,1,2,2,3,3,4,4,5,5,6,6],
	element = ["tmax", "tmin","tmax", "tmin","tmax", "tmin","tmax", "tmin","tmax", "tmin","tmax", "tmin"]
	)

# ╔═╡ 48a49aa0-79e9-11eb-3dcc-05f2334f5133
begin
	tu = [[i for i in 23.5:0.1:39.5]; [missing, missing, missing]]
	tl = [[i for i in 10.5:0.1:19.5]; [missing, missing, missing]]
end

# ╔═╡ 1a1c1002-7a93-11eb-36ba-4d7f63f8f657
begin	
	for i in 1:28
		df2[:, "d"*string(i)] = [i%2==0 ? rand(tu) : rand(tl) for i in 1:12]
	end
end

# ╔═╡ f6220f52-7aa2-11eb-010b-c51ee14c2dc7
begin
	df2[:, "d29"] = [rand(tu), rand(tl), missing, missing, rand(tu), rand(tl), rand(tu), rand(tl), rand(tu), rand(tl), rand(tu), rand(tl)]
	df2[:, "d30"] = [rand(tu), rand(tl), missing, missing, rand(tu), rand(tl), rand(tu), rand(tl), rand(tu), rand(tl), rand(tu), rand(tl)]
	df2[:, "d31"] = [rand(tu), rand(tl), missing, missing, rand(tu), rand(tl), missing, missing, rand(tu), rand(tl), missing, missing]
end

# ╔═╡ c51dfb70-7a9e-11eb-0d46-71fda8a042d9
df2

# ╔═╡ 53bbe6d0-7ab3-11eb-2c0d-97e358800223
begin
	df2.d2[3] = 27.3     #setting same values as displayed in the picture
	df2.d3[3] = 24.1
	df2.d2[4] = 14.4
	df2.d3[4] = 14.4
	df2.d5[5] = 32.1
	df2.d5[6] = 14.2
end

# ╔═╡ bfd7fcf0-7ab3-11eb-3384-535ae46e1d3f
df2

# ╔═╡ d17da0d0-7a91-11eb-29a3-f1a659e11270
rev1 = DataFrames.stack(df2, 5:35)

# ╔═╡ 2b109710-7a97-11eb-0eff-ef6e0f305f78
rev1.variable = [x[2:end] for x in rev1.variable]

# ╔═╡ 2ae9fc40-7a97-11eb-23df-c5ec76312359
rev1

# ╔═╡ 84a1c220-7aa8-11eb-006f-973223dbbecb
rev2 = unstack(rev1, :element, :value)

# ╔═╡ e7b97330-7ab2-11eb-0fdf-1d30d3aa6b35
rev3 = rev2[completecases(rev2), :]

# ╔═╡ 848efd6e-7aa8-11eb-0571-bd95d8cecbd7
rev4 = select(rev3, :id, [:year, :month, :variable] => ByRow((y, m, d) -> Date(string(y)*"-"*string(m)*"-"*d)) => :date, :tmax, :tmin)

# ╔═╡ 8c575f10-7aa9-11eb-09ff-d7f1beb980ca
df2_tidy = sort(rev4, :date)

# ╔═╡ 4686f870-7ab2-11eb-2ac7-cdabc4f7971e
md"## Problem 3"

# ╔═╡ eaf3ddb0-7ab2-11eb-1574-ff478caaf035
df3 = DataFrame(
	year = [2000 for _ in 1:15],
	artist = [["2 Pac" for i in 1:7]; ["2Ge+her" for i in 1:3]; ["3 Doors Down" for i in 1:5]],
	time = [["4:22" for i in 1:7]; ["3:15" for i in 1:3]; ["3:53" for i in 1:5]],
	track = [["Baby Don't Cry" for i in 1:7]; ["The Hardest Part Of Breaking Up" for i in 1:3]; ["Kryptonite" for i in 1:5]],
	date = [Date("2000-2-26"), Date("2000-3-4"), Date("2000-3-11"), Date("2000-3-18"), Date("2000-3-25"), Date("2000-4-1"), Date("2000-4-8"), Date("2000-9-2"), Date("2000-9-9"), Date("2000-9-16"), Date("2000-4-8"), Date("2000-4-15"), Date("2000-4-22"), Date("2000-4-29"), Date("2000-5-6")],
	week = [1,2,3,4,5,6,7,1,2,3,1,2,3,4,5],
	rank = [87, 82, 72, 77, 87, 94, 99, 91, 87, 92, 81, 70, 68, 67, 66]
	)

# ╔═╡ 844b1a90-7b40-11eb-0976-014a15a0c61b
begin
	d = Dict()
	idx = 1
	for x in unique(df3.track)
		d[x] = idx
		idx += 1
	end
	id = [d[x] for x in df3.track]
	df3.id = id
end

# ╔═╡ 842ee000-7b40-11eb-3ae0-f34c0a710740
df3

# ╔═╡ 83b654a0-7b40-11eb-30f9-2bac0ff5b19b
df3_tidy_1 = select(df3, :id, :date, :rank)

# ╔═╡ 839a8f40-7b40-11eb-1b97-832b36b234ad
df3_tidy_2 = unique(select(df3, :id, :artist, :track, :time))

# ╔═╡ 8e9f99c0-7b4b-11eb-1eef-0f41a604b1cb
md"## Problem 4"

# ╔═╡ 54938532-7c3f-11eb-31d0-bfebb6b42637
dat = HTTP.get("https://api.covid19india.org/data.json")

# ╔═╡ 5b50add0-7c3f-11eb-04c9-a13c89828dc6
str = String(dat.body)

# ╔═╡ 5b353690-7c3f-11eb-01e3-3d37a06d1e26
jdat = JSON.parse(str)

# ╔═╡ 5b16b210-7c3f-11eb-1cbe-3fe40a919746
jdat["cases_time_series"]

# ╔═╡ 5b001cd0-7c3f-11eb-093f-7d0075869460
begin
	df4 = DataFrame(dailyconfirmed = String[], dailydeceased = String[], totalconfirmed = String[], dailyrecovered = String[], dateymd = String[], totaldeceased = String[], totalrecovered = String[], date = String[])
	for x in jdat["cases_time_series"]
		push!(df4, x)
	end
end

# ╔═╡ 10f3a1e0-7c42-11eb-1334-abcc1f9d9672
df4

# ╔═╡ 10d655e0-7c42-11eb-0139-afd2d483726e
mod = select(df4, :dateymd => (x -> [parse(Int, i[1:4]) for i in x]) => :year, :dateymd => (x -> [parse(Int, i[6:7]) for i in x]) => :month, :dailyconfirmed => (x -> [parse(Int, i) for i in x]) => :dailyconfirmed, :dailydeceased => (x -> [parse(Int, i) for i in x]) => :dailydeceased, :dailyrecovered => (x -> [parse(Int, i) for i in x]) => :dailyrecovered)

# ╔═╡ 19f40e50-7c43-11eb-02c3-3d6e05eb39c7
mod1 = groupby(mod, [:year, :month])

# ╔═╡ 28a67820-7c48-11eb-116a-b956ccc24c05
mod2 = combine(mod1, :dailyconfirmed => (x->sum(x)) => :confirmed, :dailydeceased => (x->sum(x)) => :deceased, :dailyrecovered => (x->sum(x)) => :recovered)

# ╔═╡ 288cfcb0-7c48-11eb-2177-33ce68e45ac0
m = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]

# ╔═╡ 28730c10-7c48-11eb-0227-ef9fe5f3c3f0
prob4 = select(mod2, :year, :month=>(x -> [m[i] for i in x])=>:month, :confirmed, :deceased, :recovered)

# ╔═╡ 22671ee0-7cf4-11eb-13d0-c1eb55c2358c
md"## Problem 5"

# ╔═╡ 2266a9b0-7cf4-11eb-3ba4-2151b15cc306
begin
	df5 = select(mod, :dailyconfirmed, :dailydeceased, :dailyrecovered)
	df5.day = [_ for _ in 1:402]
	df5 = df5[!, [4,1,2,3]]
	df5
end

# ╔═╡ 21e2d3b0-7cf4-11eb-2d94-5395ce1ff4c5
begin
	moving_confirmed = [sum(df5.dailyconfirmed[i:i+6])/7 for i in 1:length(df5.dailyconfirmed)-6]
	moving_deceased = [sum(df5.dailydeceased[i:i+6])/7 for i in 1:length(df5.dailydeceased)-6]
	moving_recovered = [sum(df5.dailyrecovered[i:i+6])/7 for i in 1:length(df5.dailyrecovered)-6]
end

# ╔═╡ 9d32f1a0-7cf7-11eb-2e26-c1d372f4c41f
begin
	p1 = plot(1:402, df5.dailyconfirmed, label = "Daily Confirmed", title = "Daily Confirmed", xlabel = "Days", ylabel = "No. of Cases")
	plot!(7:402, moving_confirmed, line=2.5, label ="Moving Average")
end

# ╔═╡ 5a117040-7f22-11eb-273c-335462605a4c
plot(1:402, df5.dailyconfirmed, label = "Daily Confirmed", title = "Daily Confirmed", xlabel = "Days", ylabel = "No. of Cases")

# ╔═╡ 58f5c710-7f22-11eb-3b7d-b524973b627c
plot(7:402, moving_confirmed, label = "Moving Average", title = "Daily Confirmed", xlabel = "Days", ylabel = "No. of Cases", color = "red")

# ╔═╡ 39fd2122-7f25-11eb-141a-af760fbf066b
plot(1:402, df5.dailydeceased, label = "Daily Deceased", title = "Daily Deceased", xlabel = "Days", ylabel = "No. of Cases")

# ╔═╡ 39b43140-7f25-11eb-0d15-096d6c44e1f5
plot(7:402, moving_deceased, label = "Moving Average", title = "Daily Deceased", xlabel = "Days", ylabel = "No. of Cases", color = "red")

# ╔═╡ 2381cef0-7cfa-11eb-33cc-ddec50d2ae5b
begin
	p2 = plot(1:402, df5.dailydeceased, label = "Daily Deceased", title = "Daily Deceased", xlabel = "Days", ylabel = "No. of Cases")
	plot!(7:402, moving_deceased, line=2.5, label ="Moving Average")
end

# ╔═╡ 5a581960-7f26-11eb-2766-497d327ea7f1
plot(1:402, df5.dailyrecovered, label = "Daily Recovered", title = "Daily Recovered", xlabel = "Days", ylabel = "No. of Cases")

# ╔═╡ 59e7cb60-7f26-11eb-0dd3-9970417e7aa5
plot(7:402, moving_recovered, label = "Moving Average", title = "Daily Recovered", xlabel = "Days", ylabel = "No. of Cases", color = "red")

# ╔═╡ 2361eade-7cfa-11eb-01bb-65e11ca435d5
begin
	p3 = plot(1:402, df5.dailyrecovered, label = "Daily Recovered", title = "Daily Recovered", xlabel = "Days", ylabel = "No. of Cases")
	plot!(7:402, moving_recovered, line=2.5, label ="Moving Average")
end

# ╔═╡ 2349f610-7cfa-11eb-3746-611143bb746e
plot(p1, p2, p3, layout = (3,1), size = (400, 800), legend=true, legendfontsize = 6)

# ╔═╡ 7921e780-7cfc-11eb-14a4-095ae78aa2e7
df5

# ╔═╡ b455599e-7cfb-11eb-0f81-e3f600b4685b
begin
	df5_ = DataFrame()
	df5_.day = copy(df5.day)
	df5_.dailyconfirmed = copy(df5.dailyconfirmed)
	df5_.moving_confirmed = [[NaN for _ in 1:6]; moving_confirmed]
	df5_.dailydeceased = copy(df5.dailyconfirmed)
	df5_.moving_deceased = [[NaN for _ in 1:6]; moving_deceased]
	df5_.dailyrecovered = copy(df5.dailyrecovered)
	df5_.moving_recovered = [[NaN for _ in 1:6]; moving_recovered]
	df5_
end

# ╔═╡ Cell order:
# ╟─342876a0-79e9-11eb-0b04-3bfec9cbea7b
# ╟─48e77000-79e9-11eb-0507-8189881b04c9
# ╠═48e6fad0-79e9-11eb-0694-93e8f9f86982
# ╠═d21311f0-7ab0-11eb-10b8-2de5edd903c7
# ╠═48e6d3c0-79e9-11eb-2280-4f5a2c56ebf0
# ╠═48e685a0-79e9-11eb-08c5-adbe76affe7e
# ╠═48e5e960-79e9-11eb-2ea9-1b684a0cda14
# ╠═48e59b40-79e9-11eb-19be-a3759f061cf7
# ╠═48e4d7f0-79e9-11eb-241e-85d1ba4c219a
# ╟─48a6bd80-79e9-11eb-3e49-0f1b64248fef
# ╠═48a4e8c0-79e9-11eb-16c4-5bda8cf022b6
# ╠═48a49aa0-79e9-11eb-3dcc-05f2334f5133
# ╠═1a1c1002-7a93-11eb-36ba-4d7f63f8f657
# ╠═f6220f52-7aa2-11eb-010b-c51ee14c2dc7
# ╠═c51dfb70-7a9e-11eb-0d46-71fda8a042d9
# ╠═53bbe6d0-7ab3-11eb-2c0d-97e358800223
# ╠═bfd7fcf0-7ab3-11eb-3384-535ae46e1d3f
# ╠═d17da0d0-7a91-11eb-29a3-f1a659e11270
# ╠═2b109710-7a97-11eb-0eff-ef6e0f305f78
# ╠═2ae9fc40-7a97-11eb-23df-c5ec76312359
# ╠═84a1c220-7aa8-11eb-006f-973223dbbecb
# ╠═e7b97330-7ab2-11eb-0fdf-1d30d3aa6b35
# ╠═848efd6e-7aa8-11eb-0571-bd95d8cecbd7
# ╠═8c575f10-7aa9-11eb-09ff-d7f1beb980ca
# ╟─4686f870-7ab2-11eb-2ac7-cdabc4f7971e
# ╠═eaf3ddb0-7ab2-11eb-1574-ff478caaf035
# ╠═844b1a90-7b40-11eb-0976-014a15a0c61b
# ╠═842ee000-7b40-11eb-3ae0-f34c0a710740
# ╠═83b654a0-7b40-11eb-30f9-2bac0ff5b19b
# ╠═839a8f40-7b40-11eb-1b97-832b36b234ad
# ╟─8e9f99c0-7b4b-11eb-1eef-0f41a604b1cb
# ╠═4e35e5be-7b4f-11eb-21a2-ef04ec29df1c
# ╠═54938532-7c3f-11eb-31d0-bfebb6b42637
# ╠═5b50add0-7c3f-11eb-04c9-a13c89828dc6
# ╠═5b353690-7c3f-11eb-01e3-3d37a06d1e26
# ╠═5b16b210-7c3f-11eb-1cbe-3fe40a919746
# ╠═5b001cd0-7c3f-11eb-093f-7d0075869460
# ╠═10f3a1e0-7c42-11eb-1334-abcc1f9d9672
# ╠═10d655e0-7c42-11eb-0139-afd2d483726e
# ╠═19f40e50-7c43-11eb-02c3-3d6e05eb39c7
# ╠═28a67820-7c48-11eb-116a-b956ccc24c05
# ╠═288cfcb0-7c48-11eb-2177-33ce68e45ac0
# ╠═28730c10-7c48-11eb-0227-ef9fe5f3c3f0
# ╟─22671ee0-7cf4-11eb-13d0-c1eb55c2358c
# ╠═2266a9b0-7cf4-11eb-3ba4-2151b15cc306
# ╠═183f2590-7cf7-11eb-2407-05edd6fe00b0
# ╠═21e2d3b0-7cf4-11eb-2d94-5395ce1ff4c5
# ╠═9d32f1a0-7cf7-11eb-2e26-c1d372f4c41f
# ╠═5a117040-7f22-11eb-273c-335462605a4c
# ╠═58f5c710-7f22-11eb-3b7d-b524973b627c
# ╠═39fd2122-7f25-11eb-141a-af760fbf066b
# ╠═39b43140-7f25-11eb-0d15-096d6c44e1f5
# ╠═2381cef0-7cfa-11eb-33cc-ddec50d2ae5b
# ╠═5a581960-7f26-11eb-2766-497d327ea7f1
# ╠═59e7cb60-7f26-11eb-0dd3-9970417e7aa5
# ╠═2361eade-7cfa-11eb-01bb-65e11ca435d5
# ╠═2349f610-7cfa-11eb-3746-611143bb746e
# ╠═7921e780-7cfc-11eb-14a4-095ae78aa2e7
# ╠═b455599e-7cfb-11eb-0f81-e3f600b4685b
