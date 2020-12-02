### A Pluto.jl notebook ###
# v0.12.11

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : missing
        el
    end
end

# ╔═╡ c07c32b0-2d84-11eb-373d-29d9ad5a26d1
begin
	using EvoDynamics
	using Agents
	using DataFrames
	using VegaLite
	using Random
	using PlutoUI
end

# ╔═╡ 5117b2e0-2d85-11eb-0738-ffa47ea351bf
md"""
# Modeling host-parasite interactions
"""

# ╔═╡ 36c1c160-2d85-11eb-21cd-83594530d2f3
md"""
## Define model parameters
"""

# ╔═╡ b92df730-2d90-11eb-3a57-49c437cdaec6
function nspecies_per_node(model)
  output = zeros(model.properties[:nspecies], nv(model))
  for species in model.properties[:nspecies]
    for node in 1:nv(model)
      for ag in get_node_contents(node, model)
        output[model.agents[ag].species, node] += 1
      end
    end
  end
  return Tuple(output)
end

# ╔═╡ ebdd6df0-2d90-11eb-0f91-d7afe1cef062
function plot_N(dd)
	p = @vlplot(data = dd, width=400,
		mark = :line,
		x = :t,
		y = :N,
		color = "species:n"
		)
	return p
end

# ╔═╡ defd7e60-2d84-11eb-33ca-d787ec50f2a9
nspecies = 3

# ╔═╡ ec941e50-2d91-11eb-1b1e-6948b2787258
function reshape_df(modeldata)
	nrows, ncols = size(modeldata)
	dd = DataFrame(Dict(
		:t => repeat(0:nrows-1, outer=nspecies),
		:N => vec(Matrix(modeldata[!, 2:end])),
		:species => repeat(1:nspecies, inner=nrows)
		)
	)
	return dd
end

# ╔═╡ a2a9bc40-2d92-11eb-2911-59637de62229
md"""
r1: $(@bind r1 Slider(0.0:0.01:1.0, default=0.1))
s1: $(@bind s1 Slider(0.0:0.01:1.0, default=0.5)) 
c12: $(@bind c12 Slider(-1:0.01:1.0, default=0.1)) 
c13: $(@bind c13 Slider(-1:0.01:1.0, default=0.1)) \
r2: $(@bind r2 Slider(0.0:0.01:1.0, default=0.1))
s2: $(@bind s2 Slider(0.0:0.01:1.0, default=0.5)) 
c21: $(@bind c21 Slider(-1:0.01:1.0, default=0.1)) 
c23: $(@bind c23 Slider(-1:0.01:1.0, default=0.1)) \
r3: $(@bind r3 Slider(0.0:0.01:1.0, default=0.1))
s3: $(@bind s3 Slider(0.0:0.01:1.0, default=0.5))
c31: $(@bind c31 Slider(-1:0.01:1.0, default=0.1)) 
c32: $(@bind c32 Slider(-1:0.01:1.0, default=0.1))\
"""

# ╔═╡ 2824c210-2d85-11eb-17a4-7fa7452af204
parameters = Dict(
  :ngenes => fill(1, nspecies),
  :nphenotypes => fill(1, nspecies),
  :growthrates => (r1, r2, r3),
  :competitionCoeffs => [0 c12 c13; c21 0 c23; c31 c32 0],
  :pleiotropyMat => fill([true], nspecies),
  :epistasisMat =>  fill([1], nspecies),
  :expressionArrays => fill([1], nspecies),
  :selectionCoeffs => (s1, s2, s3),
  :ploidy => fill(1, nspecies),
  :optPhenotypes => fill([2.5], nspecies),
  :covMat => fill([1.0], nspecies),
  :mutProbs => fill((0.1, 0.0, 0.0), nspecies),
  :mutMagnitudes => fill((0.01, 0.0, 0.0), nspecies),
  :N => Dict(1 => (100, 100, 100)),
  :K => Dict(1 => (1000, 1000, 1000)),
  :migration_rates => fill(nothing, nspecies),
  :E => Tuple(fill((0.01), nspecies)),
  :generations => 50,
  :space => nothing
)

# ╔═╡ e03f6be0-2d92-11eb-1d0f-b7a08768f3a7
md"""
__r1__: $r1 __s1__: $s1 __c12__: $c12  __c13__: $c13\
__r2__: $r2 __s2__: $s2 __c21__: $c21  __c23__: $c23\
__r3__: $r3 __s3__: $s3 __c31__: $c31  __c32__: $c23\

"""

# ╔═╡ dd5a6ad0-2d86-11eb-1418-6fd5d286f0cd
agentdata, modeldata, model = runmodel(parameters, mdata=[nspecies_per_node]);

# ╔═╡ 2bc6bc70-2d8f-11eb-2efc-8b50f25a71e9
dd = reshape_df(modeldata);

# ╔═╡ e40d0090-2d90-11eb-3be1-6b7d4e4d944c
plot_N(dd)

# ╔═╡ Cell order:
# ╟─5117b2e0-2d85-11eb-0738-ffa47ea351bf
# ╠═c07c32b0-2d84-11eb-373d-29d9ad5a26d1
# ╟─36c1c160-2d85-11eb-21cd-83594530d2f3
# ╠═b92df730-2d90-11eb-3a57-49c437cdaec6
# ╠═ec941e50-2d91-11eb-1b1e-6948b2787258
# ╠═ebdd6df0-2d90-11eb-0f91-d7afe1cef062
# ╠═defd7e60-2d84-11eb-33ca-d787ec50f2a9
# ╠═2824c210-2d85-11eb-17a4-7fa7452af204
# ╟─a2a9bc40-2d92-11eb-2911-59637de62229
# ╟─e03f6be0-2d92-11eb-1d0f-b7a08768f3a7
# ╠═dd5a6ad0-2d86-11eb-1418-6fd5d286f0cd
# ╠═2bc6bc70-2d8f-11eb-2efc-8b50f25a71e9
# ╠═e40d0090-2d90-11eb-3be1-6b7d4e4d944c
