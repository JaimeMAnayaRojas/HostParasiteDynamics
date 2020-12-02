# Host-Parasite Dynamics (Modelling project)

This repository was built to guide you during the theoretical project (P3) of the Host-Parasite Coevolution Module. This is under construction, so any criticisms are welcome and appreciated. If you follow the steps in that order, you should be able to get Julia installed, started, and make the model run. Then in comes, the scientific part, which is getting a hypothesis, modified the model to test the hypothesis, run the models, get the data, analyse the results, make a report, and present your results. 

## 1. Installing Julia and getting familiar with the language

Go to JuliaAcadamy and take the introductory course; it will help you to get started with Julia and Programing in general:

https://juliaacademy.com/p/intro-to-julia


## 2. Get to know your packages, the most important are Agents.jl and EvoDynamics.jl


For Agents.jl visit (https://juliadynamics.github.io/Agents.jl/stable/)[https://juliadynamics.github.io/Agents.jl/stable/]

For EvoDynamics.jl (https://kavir1698.github.io/EvoDynamics.jl/dev/)[https://kavir1698.github.io/EvoDynamics.jl/dev/]


## 3. Now, get familiar with our modelling framework. 

So, we will be using the script "model/host_parasite.jl" thanks to (Ali R. Vahdati)[https://vahdati.info/]

To make things easier, We will use Pluto notebooks for this kind of course exercises. Pluto notebooks support reactivity (changing one cell automatically updates all its dependent cells) and HTML inputs. You can change the parameters that students would want to change and define plots to observe the data. You can then explore the effect of parameters on the outputs visually without any coding.

To use the file, **open Julia**, then install the required packages:
`] add Pluto PlutoUI Agents EvoDynamics VegaLite DataFrames`

After that open Pluto by typing
`using Pluto`
`Pluto.run()`

This will open a page in your browser. Firefox doesn't handle it for me. I use Edge/Chrome. From the notebook, open the file "model/host_parasite.jl"

## 4. Now, play around with the model. 

Get familiar with the script and play around with the parameter values. Read some papers about host-parasite interactions and see if you can recreate some of those conditions. So, basically, you can decide which species will be parasites, host, or predators base on the interaction Coefficients (if it does not work, you may have to change the interactionCoefficients to competitionCoefficients in your parameter Dictionary).


## 5. Get the data.

At this point you should also be able to extract the data frame as a .csv, if you do not know how to doing check in google or take the Julia course on data frames:

https://juliaacademy.com/p/introduction-to-dataframes-jl


# Happy modelling... 