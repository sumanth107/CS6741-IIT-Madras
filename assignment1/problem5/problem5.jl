### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ ab639880-740d-11eb-28c2-8b753a8d33c4
md"# CS6741: _Assignment - 1_"

# ╔═╡ df7e8620-740d-11eb-150e-6d8641860e7f
md"## Problem 5"

# ╔═╡ 9fd9fe40-740e-11eb-23c6-577244623baa
special_char = ["~","!","@","#","\$","%","^","&","*","(",")","_","+","=","-","'"]

# ╔═╡ 9f90c040-740e-11eb-24fa-01049e5f8c14
alph = [string(Char(i)) for i in 65:90]

# ╔═╡ 9eb8afbe-740e-11eb-0eaa-0d12e053c1a1
alph1 = [string(Char(i)) for i in 97:122]

# ╔═╡ b49cef40-740e-11eb-1dc7-e1754c3a79c4
pool = [alph; alph1; [0,1,2,3,4,5,6,7,8,9]; special_char]

# ╔═╡ a9989fb0-7411-11eb-255c-85b05489fcb1
md" At least 2 characters match such that they are 2 characters away"

# ╔═╡ ea98a040-740d-11eb-132c-43922d7d24e9
begin 
	password1 = [rand(pool) for _ in 1:8]
	num_5 = 10^6
	cnt1 = 0
	for i in 1:num_5
		hack1 = []
		hack1 = [rand(pool) for _ in 1:8]
		check1 = [(hack1[j] == password1[j]) for j in 1:8]
		if sum(check1)>1
			flg = 0
			for k in 1:5
				if check1[k] && check1[k+3]
					flg += 1
				end
			end
			if flg > 0
				cnt1 += 1
			end
		end
	end
	cnt1
end

# ╔═╡ Cell order:
# ╟─ab639880-740d-11eb-28c2-8b753a8d33c4
# ╟─df7e8620-740d-11eb-150e-6d8641860e7f
# ╠═9fd9fe40-740e-11eb-23c6-577244623baa
# ╠═9f90c040-740e-11eb-24fa-01049e5f8c14
# ╠═9eb8afbe-740e-11eb-0eaa-0d12e053c1a1
# ╠═b49cef40-740e-11eb-1dc7-e1754c3a79c4
# ╟─a9989fb0-7411-11eb-255c-85b05489fcb1
# ╠═ea98a040-740d-11eb-132c-43922d7d24e9
