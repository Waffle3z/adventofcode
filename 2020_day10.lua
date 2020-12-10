local nums = {}
for v in input:gmatch("[^\n]+") do
	nums[#nums+1] = tonumber(v)
end
table.sort(nums)
nums[0] = 0
nums[#nums+1] = nums[#nums] + 3
local d1, d3 = 0, 0
for i = 1, #nums do
	if nums[i] - nums[i-1] == 1 then
		d1 = d1 + 1
	else
		d3 = d3 + 1
	end
end
print(d1*d3)

local cache = {}
local function f(index)
	if not nums[index+1] then return 1 end
	if cache[index] then return cache[index] end
	local count = 0
	for i = index+1, #nums do
		if nums[i] > nums[index] + 3 then break end
		count = count + f(i)
	end
	cache[index] = count
	return count
end
print(f(0))
