local meta = {__index = function(t,k) t[k] = newtable() return t[k] end}
function newtable() return setmetatable({}, meta) end

local grid = newtable()
local grid2 = newtable()
for v in input:gmatch("[^\n]+") do
	local row = newtable()
	for i=1,#v do row[i] = v:sub(i,i) == "#" and 1 or 0 end
	grid[1][#grid[1]+1] = row
	grid2[1][1][#grid2[1][1]+1] = row
end
local minz, maxz = 1, 1
local miny, maxy = 1, #grid[1]
local minx, maxx = 1, #grid[1][1]
local minw, maxw = 1, #grid2[1][1][1]

local steps = 6
for i = 1, steps do
	local newgrid = newtable()
	local newgrid2 = newtable()
	for z = minz-i, maxz+i do
		for y = miny-i, maxy+i do
			for x = minx-i, maxx+i do
				local neighbors = 0
				for dz = -1, 1 do
					for dy = -1, 1 do
						for dx = -1, 1 do
							if (not (dz == 0 and dy == 0 and dx == 0)) and grid[z+dz][y+dy][x+dx] == 1 then
								neighbors = neighbors + 1
							end
						end
					end
				end
				local value = tonumber(grid[z][y][x]) or 0
				if value == 1 then
					if neighbors ~= 2 and neighbors ~= 3 then
						value = 0
					end
				elseif neighbors == 3 then
					value = 1
				end
				newgrid[z][y][x] = value
				for w = minw-i, maxw+i do
					local neighbors = 0
					for dz = -1, 1 do
						for dy = -1, 1 do
							for dx = -1, 1 do
								for dw = -1, 1 do
									if (not (dz == 0 and dy == 0 and dx == 0 and dw == 0)) and grid2[z+dz][y+dy][x+dx][w+dw] == 1 then
										neighbors = neighbors + 1
									end
								end
							end
						end
					end
					local value = tonumber(grid2[z][y][x][w]) or 0
					if value == 1 then
						if neighbors ~= 2 and neighbors ~= 3 then
							value = 0
						end
					elseif neighbors == 3 then
						value = 1
					end
					newgrid2[z][y][x][w] = value
				end
			end
		end
	end
	grid = newgrid
	grid2 = newgrid2
end
local count, count2 = 0, 0
for z = minz-steps, maxz+steps do
	for y = miny-steps, maxy+steps do
		for x = minx-steps, maxx+steps do
			count = count + grid[z][y][x]
			for w = minw-steps, maxw+steps do
				count2 = count2 + grid2[z][y][x][w]
			end
		end
	end
end
print(count) -- part 1
print(count2) -- part 2
