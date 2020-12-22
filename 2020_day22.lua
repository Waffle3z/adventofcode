local deck1, deck2 = {}, {}
local deck = deck1
for v in input:gmatch("[^\n]+") do
	if v:match("Player 1") then
		deck = deck1
	elseif v:match("Player 2") then
		deck = deck2
	elseif tonumber(v) then
		deck[#deck+1] = tonumber(v)
	end
end

local copy1, copy2 = {table.unpack(deck1)}, {table.unpack(deck2)}
while #deck1 > 0 and #deck2 > 0 do
	local a, b = table.remove(deck1, 1), table.remove(deck2, 1)

	if a > b then
		deck1[#deck1+1] = a
		deck1[#deck1+1] = b
	else
		deck2[#deck2+1] = b
		deck2[#deck2+1] = a
	end
end
local deck = #deck1 == 0 and deck2 or deck1
local sum = 0
for i = 1, #deck do
	sum = sum + i*deck[#deck+1-i]
end
print(sum) -- part 1

deck1, deck2 = copy1, copy2
local function play(deck1, deck2, depth)
	local seen = {}
	local round = 0
	while #deck1 > 0 and #deck2 > 0 do
		round = round + 1
		local serial = table.concat(deck1,",").." | "..table.concat(deck2,",")
		if seen[serial] then return true end
		seen[serial] = true
		local a, b = table.remove(deck1, 1), table.remove(deck2, 1)
		local player1won = false
		if #deck1 >= a and #deck2 >= b then
			player1won = play({table.unpack(deck1, 1, a)}, {table.unpack(deck2, 1, b)}, depth+1)
		else
			player1won = a > b
		end
		if player1won then
			deck1[#deck1+1] = a
			deck1[#deck1+1] = b
		else
			deck2[#deck2+1] = b
			deck2[#deck2+1] = a
		end
	end
	local deck = #deck1 == 0 and deck2 or deck1
	local sum = 0
	for i = 1, #deck do
		sum = sum + i*deck[#deck+1-i]
	end
	return deck == deck1, sum
end

print(play(deck1, deck2, 1)) -- part 2
