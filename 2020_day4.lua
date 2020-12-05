local required = {"byr","iyr","eyr","hgt","hcl","ecl","pid"}--"cid",

local part1 = 0
local part2 = 0
for passport in (input.."\n\n"):gmatch(".-\n\n") do
	local data = {}
	for a, b in passport:gmatch("(%S+):(%S+)") do
		data[a] = b
	end
	local isvalid = true
	for k, v in pairs(required) do
		if not data[v] then
			isvalid = false
		end
	end
	if isvalid then
		part1 = part1 + 1
		data.byr = tonumber(data.byr)
		data.iyr = tonumber(data.iyr)
		data.eyr = tonumber(data.eyr)
		local cm
		data.hgt, cm = data.hgt:match("(%d+)(.+)")
		data.hgt = tonumber(data.hgt)
		if data.byr >= 1920 and data.byr <= 2002
		and data.iyr >= 2010 and data.iyr <= 2020
		and data.eyr >= 2020 and data.eyr <= 2030
		and ((cm=="cm"and data.hgt>=150 and data.hgt<=193)or(cm=="in"and data.hgt>=59 and data.hgt<=76))
		and data.hcl:sub(1,1)=="#" and tonumber(data.hcl:sub(2),16) and #data.hcl==7
		and ("amb blu brn gry grn hzl oth"):find(data.ecl)
		and tonumber(data.pid) and #data.pid == 9
		then
			part2 = part2 + 1
		end
	end
end
print(part1, part2)
