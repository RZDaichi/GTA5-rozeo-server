local QBCore = exports['qb-core']:GetCoreObject()

----Commands
--[[QBCore.Commands.Add("test", "", {}, false, function(source, args)
	local src = source
    local CurrentVehicle = GetVehiclePedIsIn(src)
	TriggerServerEvent('jim-mechanic:server:LoadNitrous', trim(GetVehicleNumberPlateText(CurrentVehicle)))
end)]]

QBCore.Commands.Add("odo", "Toggle Odometer", {}, false, function(source, args)
	TriggerClientEvent("jim-mechanic:client:OdometerTog", source)
end)

QBCore.Commands.Add("checkdamage", Loc[Config.Lan]["servfunction"].checkdamage, {}, false, function(source, args)
	TriggerClientEvent("jim-mechanic:client:Repair:Check", source, -2)
end)

QBCore.Commands.Add("checkmods", Loc[Config.Lan]["servfunction"].checkmods, {}, false, function(source, args)
	TriggerClientEvent("jim-mechanic:client:Menu:List", source)
end)

QBCore.Commands.Add("flipvehicle", Loc[Config.Lan]["servfunction"].flipvehicle, {}, false, function(source, args)
	TriggerClientEvent("jim-mechanic:flipvehicle", source)
end)

QBCore.Commands.Add("togglesound", Loc[Config.Lan]["servfunction"].togglesound, {{name="on/off", help= Loc[Config.Lan]["servfunction"].togglesounddesc}}, false, function(source, args)
	TriggerClientEvent("jim-mechanic:togglesound", source, args[1])
end)

QBCore.Commands.Add("cleancar", Loc[Config.Lan]["servfunction"].cleancar, {}, false, function(source)
	TriggerClientEvent("jim-mechanic:client:cleanVehicle", source, false)
end)

QBCore.Commands.Add("hood", Loc[Config.Lan]["servfunction"].hood, {}, false, function(source)
	TriggerClientEvent("jim-mechanic:client:openDoor", source, 4)
end)

QBCore.Commands.Add("trunk", Loc[Config.Lan]["servfunction"].trunk, {}, false, function(source)
	TriggerClientEvent("jim-mechanic:client:openDoor", source, 5)
end)

QBCore.Commands.Add("door", Loc[Config.Lan]["servfunction"].door, {{name="0-3", help="Door ID"}}, false, function(source, args)
	TriggerClientEvent("jim-mechanic:client:openDoor", source, args[1])
end)

QBCore.Commands.Add("seat", Loc[Config.Lan]["servfunction"].seat, {{name="id", help="Seat ID"}}, false, function(source, args)
	TriggerClientEvent("jim-mechanic:seat", source, args[1])
end)

QBCore.Functions.CreateCallback("jim-mechanic:checkVehicleOwner", function(source, cb, plate)
	MySQL.Async.fetchAll('SELECT * FROM player_vehicles WHERE plate = ?',{plate}, function(result)
        if result[1] then cb(true)
        else cb(false) end
	end)
end)

RegisterNetEvent("jim-mechanic:updateVehicle", function(myCar, plate)
	local result = MySQL.Sync.fetchAll('SELECT * FROM player_vehicles WHERE plate = ?', {plate})
	if result[1] then
		MySQL.Async.execute('UPDATE player_vehicles SET mods = ? WHERE plate = ?', {json.encode(myCar), plate})
	end
end)

--Grabbing traveldistance from database, if you haven't added "traveldistance" column to player_vehicles this won't show up
QBCore.Functions.CreateCallback("jim-mechanic:distGrab", function(source, cb, plate)
	local result = MySQL.Sync.fetchAll('SELECT * FROM player_vehicles WHERE plate = ?', {plate})
	if result[1] then
		if result[1]["traveldistance"] ~= nil then cb(result[1]["traveldistance"])
		else cb("") end
	else cb("") end
end)

--ODOMETER STUFF
RegisterNetEvent('jim-mechanic:server:UpdateDrivingDistance', function(plate)
	local result = MySQL.Sync.fetchAll('SELECT * FROM player_vehicles WHERE plate = ?', {plate})
	if result[1] then
		if result[1].traveldistance ~= nil then
			MySQL.Async.execute('UPDATE player_vehicles SET traveldistance = ? WHERE plate = ?', {result[1]["traveldistance"] + 55, plate}) 
			if Config.Debug then print(result[1]["traveldistance"] + 95) end
		end
	end
end)