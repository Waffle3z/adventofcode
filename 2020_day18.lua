local function eval(x)
	x = x:gsub("%b()", function(s)
		return eval(s:sub(2, -2))
	end)
	local value = 0
	local op = nil
	for v in x:gmatch("%S+") do
		if tonumber(v) then
			if not op then
				value = tonumber(v)
			elseif op == "*" then
				value = value * tonumber(v)
			elseif op == "+" then
				value = value + tonumber(v)
			end
		else
			op = v
		end
	end
	return value
end

local sum = 0

local sum2 = 0
meta = {
	__add = function(a, b) return setmetatable({value = a.value * b.value}, meta) end,
	__mul = function(a, b) return setmetatable({value = a.value + b.value}, meta) end
}

for v in input:gmatch("[^\n]+") do
	sum = sum + eval(v)
	v = v:gsub(".", {["*"] = "+", ["+"] = "*"}):gsub("%d+", function(d)
		return "setmetatable({value = "..d.."}, meta)"
	end)
	sum2 = sum2 + load("return "..v)().value
end
print(sum) -- part 1
print(sum2) -- part 2
