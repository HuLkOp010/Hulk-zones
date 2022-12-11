local zones = {
	{ ['x'] = 95.5825, ['y'] = -1932.7419, ['z'] = 20.8037},
	{ ['x'] = 62.6242, ['y'] = 3702.2761, ['z'] = 42.8350 },
	{ ['x'] = -1117.3521, ['y'] = 4925.6797, ['z'] = 219.0000 } 
}

local notifIn = false
local notifOut = false
local closestZone = 1



Citizen.CreateThread(function()
	while not NetworkIsPlayerActive(PlayerId()) do
		Citizen.Wait(0)
	end
	
	while true do
		local playerPed = GetPlayerPed(-1)
		local x, y, z = table.unpack(GetEntityCoords(playerPed, true))
		local minDistance = 100000
		for i = 1, #zones, 1 do
			dist = Vdist(zones[i].x, zones[i].y, zones[i].z, x, y, z)
			if dist < minDistance then
				minDistance = dist
				closestZone = i
			end
		end
		Citizen.Wait(15000)
	end
end)



Citizen.CreateThread(function()
	while not NetworkIsPlayerActive(PlayerId()) do
		Citizen.Wait(0)
	end
	
	while true do
		Citizen.Wait(0)
		local player = GetPlayerPed(-1)
		local x,y,z = table.unpack(GetEntityCoords(player, true))
		local dist = Vdist(zones[closestZone].x, zones[closestZone].y, zones[closestZone].z, x, y, z)
	
		if dist <= 100.0 then  
			if not notifIn then																			 
				NetworkSetFriendlyFireOption(true)
				ClearPlayerWantedLevel(PlayerId())
				lib.notify({
					title = 'Hulk Zones',
					description = 'Entered the Gang Territory',
					type = 'success'
				})
				notifIn = true
				notifOut = false
			end
		else
			if not notifOut then
				NetworkSetFriendlyFireOption(true)
				lib.notify({
					title = 'Hulk Zones',
					description = 'Left the Gang Territory',
					type = 'error'
				})
				notifOut = true
				notifIn = false
			end
		end
	end
end)


