local instructions = {}
for v in getinput():gmatch("[^\n]+") do
	local op, value = v:match("(%S+) (%S+)")
	instructions[#instructions+1] = {op = op, value = tonumber(value)}
end

local acc = 0
local visited = {}
local ip = 1
while not visited[ip] do
	visited[ip] = true
	local line = instructions[ip]
	if line.op == "acc" then
		acc = acc + line.value
		ip = ip + 1
	elseif line.op == "nop" then
		ip = ip + 1
	elseif line.op == "jmp" then
		ip = ip + line.value
	end
end
print(acc) -- part 1

local versions = {}
for i = 1, #instructions do
	local copy = {}
	for j = 1, #instructions do
		copy[j] = {op = instructions[j].op, value = instructions[j].value}
	end
	local changed = false
	if copy[i].op == "jmp" then
		copy[i].op = "nop"
		changed = true
	elseif copy[i].op == "nop" then
		copy[i].op = "jmp"
		changed = true
	end
	if changed then
		versions[#versions + 1] = {instructions = copy, acc = 0, ip = 1}
	end
end

while true do
	for i = #versions, 1, -1 do
		local v = versions[i]
		local line = v.instructions[v.ip]
		if not line then
			print(v.acc) -- part 2
			return
		else
			if line.op == "acc" then
				v.acc = v.acc + line.value
				v.ip = v.ip + 1
			elseif line.op == "nop" then
				v.ip = v.ip + 1
			elseif line.op == "jmp" then
				v.ip = v.ip + line.value
			end
		end
	end
end
