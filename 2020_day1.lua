t={}
for n in input:gmatch("%d+") do t[#t+1]=tonumber(n)end

for i=1,#t do
	for j=i+1,#t do
		if t[i]+t[j]==2020 then
			print("part 1", t[i]*t[j])
		end
		for k=j+1,#t do
			if t[i]+t[j]+t[k]==2020 then
				print("part 2", t[i]*t[j]*t[k])
			end
		end
	end
end
