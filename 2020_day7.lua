local contains = {}
for line in input:gmatch("[^\n]+") do
	line=line:sub(1,-2)
	local color, other = line:match("(.+) bags contain (.+)")
	contains[color] = contains[color] or {}
	if other ~= "no other bags" then
		for bag in other:gmatch("[^,]+") do
			local count, bag=bag:match("%s*(%d+) (.+) bags?")
			contains[color][bag] = count
		end
	end
end

local trees = {}
local function f(tree, x)
	for k, v in pairs(contains[x] or {}) do
		tree[k] = true
		f(tree, k)
	end
end
for k, v in pairs(contains) do
	trees[k] = {}
	f(trees[k], k)
end

local count = 0
for k, v in pairs(trees) do
	if v["shiny gold"] then
		count = count + 1
	end
end
print(count) -- part 1

function g(x)
	local sum = 0
	for k, v in pairs(contains[x] or {}) do
		sum = sum + v * (g(k) + 1)
	end
	return sum
end
print(g("shiny gold")) -- part 2
