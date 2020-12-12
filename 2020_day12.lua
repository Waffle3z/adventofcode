local directions = {[0]={dx = 1, dy = 0}, {dx = 0, dy = -1}, {dx = -1, dy = 0}, {dx = 0, dy = 1}}
local dirs = {E=0,S=1,W=2,N=3}
local dir = 0
local x, y = 0, 0
local wx, wy = 10, 1
local x2, y2 = 0, 0
for v in input:gmatch("[^\n]+") do
	local i, n = v:match("(.)(%d+)")
	n = tonumber(n)
	if i == "R" or i == "L" then
		local sign = i == "L" and -1 or 1
		dir = (dir+(n//90)*sign)%4
		for i = 1, 4+(n//90)*sign do
			wy, wx = -wx, wy --y2 - (wx - x2), x2 + (wy - y2)
		end
	else
		local d = dirs[i] and directions[dirs[i]] or directions[dir]
		x = x + d.dx*n
		y = y + d.dy*n
		if i == "F" then
			x2 = x2 + wx*n
			y2 = y2 + wy*n
		else
			wx = wx + d.dx*n
			wy = wy + d.dy*n
		end
	end
end
print(math.abs(x)+math.abs(y))
print(math.abs(x2)+math.abs(y2))
