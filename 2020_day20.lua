local tiles = {}
for id, v in (input.."\n\n"):gmatch("Tile (%d+):\n(.-)\n\n") do
	local tile = {}
	for s in v:gmatch("[^\n]+") do
		local row = {}
		for i = 1, #s do
			row[i] = s:sub(i, i)
		end
		tile[#tile+1] = row
	end
	tiles[tonumber(id)] = tile
end

local function flip(tile)
	local new = {}
	for i = 1, #tile do
		local row = {}
		for j = #tile[i], 1, -1 do
			row[#row+1] = tile[i][j]
		end
		new[#new+1] = row
	end
	return new
end

local function rotate(tile)
	local new = {}
	for i = 1, #tile do
		new[i] = {}
		for j = 1, #tile[i] do
			new[i][j] = tile[j][i]
		end
	end
	return flip(new)
end

for _, t in pairs(tiles) do
	local versions = {t}
	for i = 1, 3 do
		versions[#versions+1] = rotate(versions[#versions])
	end
	for i = 1, 4 do
		versions[#versions+1] = flip(versions[i])
	end
	for _, v in pairs(versions) do
		v.top = table.concat(v[1])
		v.bottom = table.concat(v[#v])
		v.left, v.right = "", ""
		for i = 1, #v do
			v.left = v.left..v[i][1]
			v.right = v.right..v[i][#v[i]]
		end
	end
	t.versions = versions
end

local corner1
local product = 1
for id1, a in pairs(tiles) do
	local matches = 0
	for id2, b in pairs(tiles) do
		if id1 ~= id2 then
			for _, v in pairs(b.versions) do
				if v.top == a.bottom or v.bottom == a.top or v.left == a.right or v.right == a.left then
					matches = matches + 1
				end
			end
		end
	end
	if matches == 2 then -- the 4 tiles that only have 2 matches are the corners
		product = product * id1
		corner1 = corner1 or a
	end
end
print(product) -- part 1

local hasbeensolved = {[corner1] = true} -- designate some initial solved piece to affix the orientation
repeat
	local unsolved = false
	for id, b in pairs(tiles) do
		if not hasbeensolved[b] then
			unsolved = true
			for a, _ in pairs(hasbeensolved) do
				for _, v in pairs(b.versions) do
					local real
					if v.top == a.bottom then -- bottom of 1 is top of 2
						real = v
						b.offset = {1, 0} -- down 1
					elseif v.bottom == a.top then -- top of 1 is bottom of 2
						real = v
						b.offset = {-1, 0} -- up 1
					else
						if v.left == a.right then
							real = v
							b.offset = {0, 1}
						elseif v.right == a.left then
							real = v
							b.offset = {0, -1}
						end
					end
					if real then
						hasbeensolved[b] = true
						b.parent = a
						for i = 1, #real do
							for j = 1, #real[i] do
								b[i][j] = real[i][j]
							end
						end
						b.top, b.bottom, b.left, b.right = real.top, real.bottom, real.left, real.right
						break
					end
				end
				if b.parent then break end
			end
		end
	end
until not unsolved

local function getposition(tile)
	if not tile.parent then
		return {0, 0}
	else
		local parentpos = getposition(tile.parent)
		return {tile.offset[1] + parentpos[1], tile.offset[2] + parentpos[2]}
	end
end

for k, v in pairs(tiles) do
	v.position = getposition(v)
end

for k, v in pairs(tiles) do
	table.remove(v)
	table.remove(v, 1)
	for i = 1, #v do
		table.remove(v[i])
		table.remove(v[i], 1)
	end
end

local grid = {}
local minindex, maxindex = math.huge, -math.huge
local minindex2, maxindex2 = math.huge, -math.huge
for k, v in pairs(tiles) do
	print(k, v.position[1], v.position[2])
	grid[v.position[1]] = grid[v.position[1]] or {}
	grid[v.position[1]][v.position[2]] = v
	minindex = math.min(minindex, v.position[1])
	maxindex = math.max(maxindex, v.position[1])
	minindex2 = math.min(minindex2, v.position[2])
	maxindex2 = math.max(maxindex2, v.position[2])
end

local newgrid = {}
for i = minindex, maxindex do
	for x = 1, #grid[i][minindex2] do
		local s = {}
		for j = minindex2, maxindex2 do
			table.concat(grid[i][j][x]):gsub(".", function(c) s[#s+1] = c end)
		end
		print(table.concat(s))
		newgrid[#newgrid+1] = s
	end
end

print[[

..................#.
#....##....##....###
.#..#..#..#..#..#...

]]

local offsets = {{1, 1}, {1, 4}, {0, 5}, {0, 6}, {1, 7}, {1, 10}, {0, 11}, {0, 12}, {1, 13}, {1, 16}, {0, 17}, {0, 18}, {-1, 18}, {0, 19}}
for _, o in pairs(offsets) do
	o[1], o[2] = -o[1], o[2] -- found via trial and error
end

local coordinates = {}
for i = 1, #newgrid do
	for j = 1, #newgrid[i] do
		if newgrid[i][j] == "#" then
			local pass = true
			for _, o in pairs(offsets) do
				if not newgrid[i+o[1]] or newgrid[i+o[1]][j+o[2]] ~= "#" then
					pass = false
					break
				end
			end
			if pass then
				coordinates[i] = coordinates[i] or {}
				coordinates[i][j] = 1
				for _, o in pairs(offsets) do
					coordinates[i+o[1]] = coordinates[i+o[1]] or {}
					coordinates[i+o[1]][j+o[2]] = 1
				end
			end
		end
	end
end
local inseamonster = 0
local total = 0
for k, v in pairs(coordinates) do
	for _, n in pairs(v) do
		inseamonster = inseamonster + 1
	end
end
for k, v in pairs(newgrid) do
	for _, c in pairs(v) do
		if c == "#" then
			total = total + 1
		end
	end
end
print(total - inseamonster) -- part 2
