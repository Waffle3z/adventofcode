local grid = {}
for v in getinput():gmatch("[^\n]+") do
	local row = {}
	for i = 1, #v do
		row[i] = v:sub(i, i)
	end
	grid[#grid+1] = row
end

local function equal(a, b)
	for i = 1, #a do
		for j = 1, #a[i] do
			if a[i][j] ~= b[i][j] then return false end
		end
	end
	return true
end

local function countAdjacent(i, j)
	local count = 0
	for x = i-1, i+1 do
		for y = j-1, j+1 do
			if not (x == i and y == j) then
				if grid[x] and grid[x][y] == "#" then
					count = count + 1
				end
			end
		end
	end
	return count
end
local function countVisible(i, j)
	local count = 0
	for dy = -1, 1 do
		for dx = -1, 1 do
			if not (dy == 0 and dx == 0) then
				for d = 1, math.max(#grid, #grid[1]) do
					if not grid[i+dx*d] then break end
					if grid[i+dx*d][j+dy*d] == "#" then
						count = count + 1
					end
					if grid[i+dx*d][j+dy*d] ~= "." then break end
				end
			end
		end
	end
	return count
end
local grid2 = grid

while true do -- part 1
	local copy = {}
	copy[0] = {}
	copy[#copy+1] = {}
	for i = 1, #grid do
		copy[i] = {}
		for j = 1, #grid[i] do
			copy[i][j] = grid[i][j]
		end
	end
	for i = 1, #copy do
		for j = 1, #copy[i] do
			local adj = countAdjacent(i, j)
			if copy[i][j] == "L" and adj == 0 then
				copy[i][j] = "#"
			elseif copy[i][j] == "#" and adj >= 4 then
				copy[i][j] = "L"
			end
		end
	end
	if equal(copy, grid) then
		local count = 0
		for i = 1, #grid do
			for j = 1, #grid[i] do
				if grid[i][j] == "#" then
					count = count + 1
				end
			end
		end
		print(count)
		break
	end
	grid = copy
end

grid = grid2 -- part 2
while true do
	local copy = {}
	copy[0] = {}
	copy[#copy+1] = {}
	for i = 1, #grid do
		copy[i] = {}
		for j = 1, #grid[i] do
			copy[i][j] = grid[i][j]
		end
	end
	for i = 1, #copy do
		for j = 1, #copy[i] do
			local adj = countVisible(i, j)
			if copy[i][j] == "L" and adj == 0 then
				copy[i][j] = "#"
			elseif copy[i][j] == "#" and adj >= 5 then
				copy[i][j] = "L"
			end
		end
	end
	if equal(copy, grid) then
		local count = 0
		for i = 1, #grid do
			for j = 1, #grid[i] do
				if grid[i][j] == "#" then
					count = count + 1
				end
			end
		end
		print(count)
		break
	end
	grid = copy
end
