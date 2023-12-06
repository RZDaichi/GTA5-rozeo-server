local QBCore = exports['qb-core']:GetCoreObject()

local VehicleNitrous = {}

RegisterNetEvent('jim-mechanic:server:LoadNitrous', function(Plate)
	VehicleNitrous[Plate] = { hasnitro = true, level = 100, }
	TriggerClientEvent('jim-mechanic:client:LoadNitrous', -1, Plate)
	TriggerClientEvent('hud:client:UpdateNitrous', -1, VehicleNitrous[Plate].hasnitro, VehicleNitrous[Plate].level, false)
	TriggerEvent('jim-mechanic:database:LoadNitro', Plate, 100)
end)

RegisterNetEvent('jim-mechanic:server:UnloadNitrous', function(Plate)
	VehicleNitrous[Plate] = nil
	TriggerClientEvent('jim-mechanic:client:UnloadNitrous', -1, Plate)
	TriggerEvent('jim-mechanic:database:UnloadNitro', Plate)
end)

RegisterNetEvent('jim-mechanic:server:UpdateNitroLevel', function(Plate, level)
	VehicleNitrous[Plate].level = level
	TriggerClientEvent('jim-mechanic:client:UpdateNitroLevel', -1, Plate, level)
	TriggerEvent('jim-mechanic:database:UpdateNitroLevel', Plate, level)
end)

QBCore.Functions.CreateCallback('jim-mechanic:GetNosLoadedVehs', function(source, cb)
	local result = MySQL.Sync.fetchAll('SELECT * FROM player_vehicles WHERE hasnitro = @nos', {["@nos"] = true,})
	if result[1] then
		for k, v in pairs(result) do
			if v["hasnitro"] then
				if Config.Debug then print("VehicleNitrous["..tostring(v["plate"]).."] = { level = "..tonumber(v["noslevel"])..", hasnitro = "..tostring(v["hasnitro"]).." }") end
				VehicleNitrous[v["plate"]] = { hasnitro = true, level = tonumber(v["noslevel"]), }
				TriggerClientEvent('jim-mechanic:client:LoadNitrous', -1, tostring(v["plate"]))
				TriggerClientEvent('hud:client:UpdateNitrous', -1, VehicleNitrous[v["plate"]].hasnitro, VehicleNitrous[v["plate"]].level, false)
			end
		end
	end
	cb(VehicleNitrous)
end)

QBCore.Functions.CreateCallback('jim-mechanic:GetNosLoaded', function(source, cb, plate)
	local result = MySQL.Sync.fetchAll('SELECT * FROM player_vehicles WHERE plate = ?', {plate})
	if result[1].hasnitro ~= nil then
		for k, v in pairs(result) do
			if result[k]["hasnitro"] ~= nil and result[k]["hasnitro"] == 1 then
				if Config.Debug then print("VehicleNitrous["..tostring(result[k]["plate"]).."] = { level = "..tonumber(result[k]["noslevel"])..", hasnitro = "..tostring(result[k]["hasnitro"]).." }") end
				VehicleNitrous[result[k]["plate"]] = { hasnitro = true, level = tonumber(result[k]["noslevel"]), }
				TriggerClientEvent('jim-mechanic:client:LoadNitrous', -1, tostring(result[k]["plate"]))
				TriggerClientEvent('hud:client:UpdateNitrous', -1, VehicleNitrous[result[k]["plate"]].hasnitro, VehicleNitrous[result[k]["plate"]].level, false)
			end
		end
	end
	cb(VehicleNitrous)
end)

RegisterNetEvent('jim-mechanic:database:LoadNitro', function(plate, level)
	MySQL.Async.execute('UPDATE player_vehicles SET noslevel = ? WHERE plate = ?', {level, plate})
	MySQL.Async.execute('UPDATE player_vehicles SET hasnitro = ? WHERE plate = ?', {hasnitro, plate})
end)

RegisterNetEvent('jim-mechanic:database:UnloadNitro', function(plate)
	MySQL.Async.execute('UPDATE player_vehicles SET noslevel = ? WHERE plate = ?', {0, plate}) 
	MySQL.Async.execute('UPDATE player_vehicles SET hasnitro = ? WHERE plate = ?', {0, plate}) 
end)

RegisterNetEvent('jim-mechanic:database:UpdateNitroLevel', function(plate, level)
	MySQL.Async.execute('UPDATE player_vehicles SET noslevel = ? WHERE plate = ?', {level, plate})
end)

--Syncing stuff
RegisterNetEvent('jim-mechanic:server:SyncPurge', function(netId, enabled)
	for k, v in pairs(QBCore.Functions.GetPlayers()) do
		local P = QBCore.Functions.GetPlayer(v)
		TriggerClientEvent('jim-mechanic:client:SyncPurge', P.PlayerData.source, netId, enabled)
	end
end)
RegisterNetEvent('jim-mechanic:server:SyncTrail', function(netId, enabled)
	for k, v in pairs(QBCore.Functions.GetPlayers()) do
		local P = QBCore.Functions.GetPlayer(v)
		TriggerClientEvent('jim-mechanic:client:SyncTrail', P.PlayerData.source, netId, enabled)
	end
end)
RegisterNetEvent('jim-mechanic:server:SyncFlame', function(netId, scale)
	for k, v in pairs(QBCore.Functions.GetPlayers()) do
		local P = QBCore.Functions.GetPlayer(v)
		TriggerClientEvent('jim-mechanic:client:SyncFlame', P.PlayerData.source, netId, scale)
	end
end)