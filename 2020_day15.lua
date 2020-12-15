local t = {}
for v in input:gmatch("[^,]+") do
	t[#t+1] = tonumber(v)
end
local last = {}
for i=1,#t-1 do last[t[i]] = i end
local lastn, lastv = t[#t], #t
for i = #t+1, 30000000 do
	local n = t[#t]
	if last[n] then
		t[#t+1] = #t - last[n]
	else
		t[#t+1] = 0
	end
	if lastn then last[lastn] = lastv end
	lastn, lastv = t[#t], #t
	if i%1e5 == 0 then print("-"..(i/1e6)) end
end
print(t[2020])
print(t[#t])
