local card, door = input:match("(%d+)\n(%d+)")
card, door = tonumber(card), tonumber(door)
local v = 1
for i = 1, math.huge do
	v = v * 7 % 20201227
	if v == card then
		local n = 1
		for j = 1, i do
			n = n * door % 20201227
		end
		print(n)
		break
	end
end
