local valid = 0
local valid2 = 0
for line in input:gmatch("[^\n]+") do
	local a, b, l, p = line:match("(%d+)%-(%d+) (.): (.*)")
	a,b=tonumber(a),tonumber(b)
	local counts = {}
	for v in p:gmatch(".") do counts[v]=(counts[v] or 0)+1 end
	local n = counts[l] or 0
	if n>=a and n<=b then valid = valid + 1 end
	if (p:sub(a,a)==l) ~= (p:sub(b,b)==l) then
		valid2 = valid2 + 1
	end
end
print(valid, valid2)
