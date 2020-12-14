local function bin(n)
	local s=""
	if n==0 then return("0"):rep(36)end
	while n>0 do
		s=(n%2)..s
		n=n//2
	end
	return ("0"):rep(-#s%36)..s
end

local currentMask
local memory = {}
local memory2 = {}
for v in input:gmatch("[^\n]+") do
	local mask = v:match("mask = (.+)")
	if mask then
		currentMask = mask
	else
		local index, value = v:match("(%d+).-(%d+)")
		index, value = tonumber(index), tonumber(value)
		local binary = bin(value)
		local binary2 = bin(index)
		local new = ""
		local new2 = ""
		for i = 1, #currentMask do
			if currentMask:sub(i, i) == "X" then
				new = new..binary:sub(i, i)
			else
				new = new..currentMask:sub(i, i)
			end
			if currentMask:sub(i, i) == "0" then
				new2 = new2..binary2:sub(i, i)
			elseif currentMask:sub(i, i) == "1" then
				new2 = new2.."1"
			else
				new2 = new2.."X"
			end
		end
		local indices = {new2}
		repeat
			local finished = true
			local newIndices = {}
			for i = 1, #indices do
				if indices[i]:find("X") then
					newIndices[#newIndices+1] = indices[i]:gsub("^(.-)X", "%10")
					newIndices[#newIndices+1] = indices[i]:gsub("^(.-)X", "%11")
					finished = false
				else
					newIndices[#newIndices+1] = indices[i]
				end
			end
			indices = newIndices
		until finished
		memory[index] = tonumber(new, 2)
		for _, b in pairs(indices) do
			memory2[tonumber(b, 2)] = value
		end
	end
end
local sum = 0
for k, v in pairs(memory) do
	sum = sum + v
end
print(sum) -- part 1
local sum2 = 0
for k, v in pairs(memory2) do
	sum2 = sum2 + v
end
print(sum2) -- part 2
