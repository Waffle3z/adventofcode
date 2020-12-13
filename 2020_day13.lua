local depart, data = input:match("(%d+)\n(.+)")
depart = tonumber(depart)
local list = {}
for v in data:gmatch("[^,]+") do
	list[#list+1] = tonumber(v) or v
end
local min, id = math.huge, 1
for i = 1, #list do
	if tonumber(list[i]) then
		local value = math.ceil(depart / list[i]) * list[i] - depart
		if min > value then
			min, id = value, list[i]
		end
	end
end
print(id * min) -- part 1

t={}
for i = 1, #list do if tonumber(list[i]) then t[#t+1]="(x+"..(i-1)..")%"..list[i].."=0" end end -- chinese remainder theorem
print(table.concat(t,",")) -- paste into wolframalpha
