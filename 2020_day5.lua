local biggest = 0
local exists = {}
for line in input:gmatch("[^\n]+") do
	local value = tonumber(line:gsub(".",{L=0,R=1,F=0,B=1}), 2)
	biggest = math.max(biggest, value)
	exists[value] = true
end
print(biggest)
for n = 1, biggest do
	if exists[n-1] and exists[n+1] and not exists[n] then
		print(n)
	end
end
