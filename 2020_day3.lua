local grid={}
for line in input:gmatch("[^\n]+") do
	row={}
	for c in line:rep(323):gmatch(".")do row[#row+1]=c end
	grid[#grid+1]=row
end
local x,y=1,1
local part1=0
while grid[y] do
	if grid[y][x]=="#" then
		part1=part1+1
	end
	x,y=x+3,y+1
end
print(part1)

local part2=1
for _, p in pairs({{1,1},{3,1},{5,1},{7,1},{1,2}})do
	local x,y,count=1,1,0
	while grid[y] do
		if grid[y][x]=="#" then
			count=count+1
		end
		x,y=x+p[1],y+p[2]
	end
	part2=part2*count
end
print(part2)
