local rulenames = {}
local rules = {}
local myticket = {}
local tickets = {}
local a, b, c = getinput():match("(.+)\n\nyour ticket:(.+)\n\nnearby tickets:(.+)")
for v in a:gmatch("[^\n]+") do
	rulenames[#rulenames+1] = v:match("[^:]+")
	local nums = {}
	for n in v:gmatch("%d+") do
		nums[#nums+1] = tonumber(n)
	end
	rules[#rules+1] = nums
end
for n in b:gmatch("%d+") do
	myticket[#myticket+1] = tonumber(n)
end
for v in c:gmatch("[^\n]+") do
	local t = {}
	for n in v:gmatch("%d+") do
		t[#t+1] = tonumber(n)
	end
	tickets[#tickets+1] = t
end

local ranges = {}
for i = 1, #myticket do
	ranges[i] = {low = math.huge, high = -math.huge}
end
for _, t in pairs(tickets) do
	for i = 1, #t do
		ranges[i].low = math.min(ranges[i].low, t[i])
		ranges[i].high = math.max(ranges[i].high, t[i])
	end
end

local errorrate = 0
local invalids = {}
for index, t in pairs(tickets) do
	for i = 1, #t do
		local valid = false
		for _, r in pairs(rules) do
			if (t[i] >= r[1] and t[i] <= r[2]) or (t[i] >= r[3] and t[i] <= r[4]) then
				valid = true
				break
			end
		end
		if not valid then
			errorrate = errorrate + t[i]
			if invalids[#invalids] ~= index then
				invalids[#invalids+1] = index
			end
		end
	end
end
print(errorrate) -- part 1

for i = #invalids, 1, -1 do
	table.remove(tickets, invalids[i])
end

local product = 1
for _ = 1, #myticket do
	for i = 1, #myticket do
		local possible = {}
		for index, r in pairs(rules) do
			local valid = true
			for _, t in pairs(tickets) do
				if not ((t[i] >= r[1] and t[i] <= r[2]) or (t[i] >= r[3] and t[i] <= r[4])) then
					valid = false
					break
				end
			end
			if valid then
				possible[#possible+1] = index
			end
		end
		if #possible == 1 then
			local rule = possible[1]
			if rulenames[rule]:match("^departure") then
				product = product * myticket[i]
			end
			for _, t in pairs(tickets) do
				table.remove(t, i)
			end
			table.remove(myticket, i)
			table.remove(rulenames, rule)
			table.remove(rules, rule)
			break
		end
	end
end
print(product) -- part 2
