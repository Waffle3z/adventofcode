local ingredients = {}
local occurrences = {}
local allergens = {}

for v in input:gmatch("[^\n]+") do
	local s, a = v:match("(.+) %(contains (.+)%)")
	local set = {}
	for w in s:gmatch("%w+") do
		set[w] = true
		ingredients[w] = ingredients[w] or {}
		occurrences[w] = (occurrences[w] or 0) + 1
	end
	for w in a:gmatch("%w+") do
		allergens[w] = allergens[w] or {}
		allergens[w][#allergens[w]+1] = set
	end
end

local has_allergen = {}
local possibilities = {}
for a, t in pairs(allergens) do
	local set
	for k, v in pairs(t) do
		if not set then
			set = v
		else
			local valid = {}
			for a, _ in pairs(v) do
				if set[a] then
					valid[a] = true
				end
			end
			set = valid
		end
	end
	for k, v in pairs(set) do
		possibilities[a] = possibilities[a] or {}
		possibilities[a][#possibilities[a]+1] = k
		has_allergen[k] = true
	end
end

local solved = {}
local list = {}
repeat
	local remove = {}
	for k, t in pairs(possibilities) do
		if #t == 1 then
			solved[t[1]] = k
			list[#list+1] = t[1]
			remove[k] = true
			for _, v in pairs(possibilities) do
				if v ~= t then
					for i = #v, 1, -1 do
						if v[i] == t[1] then
							table.remove(v, i)
							break
						end
					end
				end
			end
		end
	end
	for k, v in pairs(remove) do
		possibilities[k] = nil
	end
until not next(possibilities)
table.sort(list, function(a, b) return solved[a] < solved[b] end)

local count = 0
for k, v in pairs(ingredients) do
	if not has_allergen[k] then
		count = count + occurrences[k]
	end
end
print(count) -- part 1
print(table.concat(list, ",")) -- part 2
