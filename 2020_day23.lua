local t = {}
for i = 1, #input do
	t[i] = tonumber(input:sub(i, i))
end

local function remove(i)
	if i > #t then
		return remove(i - #t)
	end
	return table.remove(t, i)
end

local t2 = {table.unpack(t)}
local current = t[1]
local size = #t
for step = 1, 100 do
	local index
	for i = 1, #t do
		if t[i] == current then
			index = i
			break
		end
	end
	local a, b, c = remove(index+1)
	if index+1>#t then
		b=remove(1)
	else
		b=remove(index+1)
	end
	if index+1>#t then
		c=remove(1)
	else
		c=remove(index+1)
	end
	for i = current-1, -math.huge, -1 do
		if i < 1 then
			i = i + size
		end
		if i ~= a and i ~= b and i ~= c then
			local foundindex
			for j = 1, #t do
				if t[j] == i then
					foundindex = j
					break
				end
			end
			table.insert(t, (foundindex + 1-1)%size+1, a)
			table.insert(t, (foundindex + 2-1)%size+1, b)
			table.insert(t, (foundindex + 3-1)%size+1, c)
			break
		end
	end
	for i = 1, #t do
		if t[i] == current then
			current = t[i%#t+1]
			break
		end
	end
end
print(table.concat(t):rep(2):match("1(.+)1")) -- part 1

t = t2
local links = {}
local references = {}
for i = 1, size do
	links[i] = {value = t[i]}
	references[t[i]] = links[i]
end
for i = 1, size-1 do
	links[i].next = links[i+1]
	links[i+1].previous = links[i]
end
local lastlink = links[size]
for i = size+1, 1e6 do
	lastlink = {value = i, previous = lastlink}
	lastlink.previous.next = lastlink
	references[i] = lastlink
end
lastlink.next, links[1].previous = links[1], lastlink

local current = links[1]
for step = 1, 1e7 do
	local index
	for i = 1, #t do
		if t[i] == current then
			index = i
			break
		end
	end
	local a = current.next
	local b = a.next
	local c = b.next
	local d = c.next
	for i = current.value-1, -math.huge, -1 do
		if i < 1 then
			i = i + 1e6
		end
		if i ~= a.value and i ~= b.value and i ~= c.value then
			local link = references[i]
			c.next, link.next.previous = link.next, c
			link.next, a.previous = a, link
			break
		end
	end
	current.next = d
	d.previous = current
	current = d
end
local link = references[1]
print(link.next.value * link.next.next.value) -- part 2
