local rules = {}
local strings = {}

for v in input:gmatch("[^\n]+") do
	if v:match("%d") then
		if v:match("%a") then
			rules[tonumber(v:match("%d+"))] = v:match("%a")
			print(v)
		else
			local rulen, rule = v:match("(%d+): (.*)")
			local options = {}
			for w in rule:gmatch("[^|]+") do
				local set = {}
				for x in w:gmatch("%d+") do
					set[#set+1] = tonumber(x)
				end
				options[#options+1] = set
			end
			rules[tonumber(rulen)] = options
		end
	else
		strings[#strings+1] = v
	end
end

function f(s, rulen)
	if type(rules[rulen]) == "string" then
		if rules[rulen] == s:sub(1, 1) then
			return s:sub(2)
		end
	else
		for _, option in pairs(rules[rulen]) do
			local r = s
			for _, n in pairs(option) do
				r = f(r, n)
				if not r then break end
			end
			if r == "" or (r and rulen ~= 0) then return r end
		end
	end
end

local count = 0
for _, s in pairs(strings) do
	if f(s, 0) then
		count = count + 1
	end
end
print(count) -- part 1

--8: 42 | 42 8
--11: 42 31 | 42 11 31

--42*n
--42*m 31*m

local count = 0
for _, s in pairs(strings) do
	local count42, count31 = 0, 0
	repeat
		local r = f(s, 42)
		if r then
			s = r
			count42 = count42 + 1
		end
	until not r
	repeat
		local r = f(s, 31)
		if r then
			s = r
			count31 = count31 + 1
		end
	until not r
	if s == "" and count42 - count31 > 0 and count31 > 0 then
		count = count + 1
	end
end
print(count) -- part 2
