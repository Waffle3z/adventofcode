part1,part2=0,0
for v in (input.."\n\n"):gmatch("(.-)\n\n") do
	t={}
	for i=1,#v do
		if v:sub(i,i)~="\n"then
			t[v:sub(i,i)]=true
		end
	end
	for k,v in pairs(t)do part1=part1+1 end
	for x in v:gmatch("[^\n]+") do
		for k, _ in pairs(t) do
			if not x:find(k) then
				t[k] = false
			end
		end
	end
	for k,v in pairs(t)do if v then part2=part2+1 end end
end
print(part1,part2)
