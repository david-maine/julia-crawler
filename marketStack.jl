import JSON
import HTTP
import DataFrames

conf = JSON.parsefile("conf.json")
cred = JSON.parsefile("cred.json")

endpoint=conf["market_stack"]["url"] * "exchanges"
key = cred["market_stack"]["key"]

params = Dict(:access_key => key)
r = HTTP.request("GET", endpoint; query = params)
data = JSON.parse(String(r.body))

df =  DataFrames.DataFrame(name = String[], acronym = Any[])

for e ∈ data["data"]
    push!(df, [e["name"], e["acronym"]])
end

df
