pal({[0]=129,2,136,8,142,137,9,10,138,11,139,3,131,140,1},1)

function _update()
	--prevents program from exiting
end


--map range of values to new range
function num_map(x,
			  in_min,
			  in_max,
			  out_min,
			  out_max)
														
	in_range=in_max-in_min
	out_range=out_max-out_min
	in_pos = x-in_min
	proportion=in_pos/in_range
	out_pos=proportion*out_range
	
	output=out_pos+out_min
	return output
end		

--iterate over mandelbrot function
--render 
function mandelbrot()
 
	local max_iterations=100
	local height=127
	local width=127
	local cplane=2
	local zoom=2
	
	local cx=-0.5
	local cy=0
	local r_min=cx-cplane/zoom
	local r_max=cx+cplane/zoom
	local i_min=cy-cplane/zoom
	local i_max=cy+cplane/zoom
	

 
 for x=0,127 do
 local xa=num_map(x,0,width,r_min,r_max)
 	for y=0,127 do
 		local yb=num_map(y,0,height,i_min,i_max)
 		--constant complex number c for each point of plane
		local za=xa
		local zb=yb
		local ca=za
		local cb=zb
		local cardiod=false
		local bulb=false
		
		--number of iterations
 	local n=0
		
		--check if point in main cardiod
		local cb2=cb*cb
		local casubq=ca-0.25
		local q=casubq*casubq+cb2
		local a=q*q+q*casubq
		local b=0.25*cb2
		
		--check if point in period 2 bulb
		local p2=ca*ca+2*ca+1+cb2
		
		if p2 <= 0.0625 then
			n=max_iterations
		end
		
		if a<=b then
			n=max_iterations
		end
		
 		while (n<max_iterations) do
 		local za2=za*za
 		local zb2=zb*zb
 		local magnitude=za2+zb2
 			-- check if z magnitude tends to infinite
 			if magnitude > 4 then
 				break
 			end
 			zb=2*za*zb+cb
 			za=za2-zb2+ca
 			n=n+1
 		end
 		
 		color=num_map(n,0,max_iterations,1,15)
 		
 		if n==max_iterations then
 			color=0
 		end
 		--set pixel color based on number
 		--of iterations before escape
 		pset(x,y,color)
 	end
 end

end

cls()

mandelbrot()
