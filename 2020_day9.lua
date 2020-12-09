local nums = {}
for v in input:gmatch("[^\n]+") do
	nums[#nums+1] = tonumber(v)
end

local invalid = 0
for i = 26, #nums do
	local valid = false
	for j = i-25, i-1 do
		for k = j+1, i-1 do
			if nums[j] ~= nums[k] and nums[j] + nums[k] == nums[i] then
				valid = true
			end
		end
	end
	if not valid then
		print(nums[i]) -- part 1
		invalid = nums[i]
	end
end

for i = 1, #nums do
	local sum = 0
	local smallest, largest = math.huge, -math.huge
	for j = i, #nums do
		sum = sum + nums[j]
		smallest = math.min(smallest, nums[j])
		largest = math.max(largest, nums[j])
		if sum == invalid and i ~= j then
			print(smallest + largest) -- part 2
		end
	end
end
