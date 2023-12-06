local QBCore = exports['qb-core']:GetCoreObject()
--========================================================== Drift
RegisterNetEvent('jim-mechanic:client:applyDrift', function()
	if not jobChecks() then return end
	local playerPed	= PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	if not inCar() then return end
	if not nearPoint(coords) then return end
	if not IsPedInAnyVehicle(playerPed, false) then vehicle = getClosest(coords) pushVehicle(vehicle) end
	if Config.isVehicleOwned and not IsVehicleOwned(trim(GetVehicleNumberPlateText(vehicle))) then TriggerEvent("QBCore:Notify", Loc[Config.Lan]["common"].owned, "error") return end
	if DoesEntityExist(vehicle) then
		if GetNumVehicleMods(vehicle,11) == 0 then TriggerEvent("QBCore:Notify", Loc[Config.Lan]["common"].noOptions, "error") return end
		if GetDriftTyresEnabled(vehicle) ~= false then TriggerEvent("QBCore:Notify", Loc[Config.Lan]["common"].already, "error") else
			SetVehicleEngineOn(vehicle, false, false, true)
			TaskTurnPedToFaceEntity(playerPed, vehicle, 1000)
			Wait(1000)
			time = math.random(7000,10000)
			QBCore.Functions.Progressbar("drink_something", Loc[Config.Lan]["tires"].install, time, false, true, { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true, },
			{ animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 8, }, {}, {}, function()
				SetVehicleTyreFixed(vehicle, 0)
				SetVehicleTyreFixed(vehicle, 1)
				SetVehicleTyreFixed(vehicle, 2)
				SetVehicleTyreFixed(vehicle, 3)
				SetVehicleTyreFixed(vehicle, 4)
				SetDriftTyresEnabled(vehicle, true)
				emptyHands(playerPed)
				updateCar(vehicle)
				TriggerServerEvent('jim-mechanic:server:removeDrift')
				if GetVehicleTyresCanBurst(vehicle) ~= 1 then 
					TriggerServerEvent('jim-mechanic:server:giveBulletProof')
					SetVehicleTyresCanBurst(vehicle, true)
					TriggerEvent("QBCore:Notify", Loc[Config.Lan]["tires"].swap, "success")
				end
				TriggerEvent("QBCore:Notify", Loc[Config.Lan]["tires"].installed, "success")
			end, function() -- Cancel
				TriggerEvent("QBCore:Notify", Loc[Config.Lan]["tires"].failed, "error")
				emptyHands(playerPed)
			end)
		end
	end
end)

RegisterNetEvent('jim-mechanic:client:giveDrift', function()
	if not jobChecks() then return end
	local playerPed	= PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	vehicle = getClosest(coords) pushVehicle(vehicle)
	if Config.isVehicleOwned and not IsVehicleOwned(trim(GetVehicleNumberPlateText(vehicle))) then TriggerEvent("QBCore:Notify", Loc[Config.Lan]["common"].owned, "error") return end
	if DoesEntityExist(vehicle) then
		TaskTurnPedToFaceEntity(playerPed, vehicle, 1000)
		Wait(1000)
		QBCore.Functions.Progressbar("accepted_key", Loc[Config.Lan]["tires"].removing, 8000, false, true, { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = false, },
		{ animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 8, }, {}, {}, function() -- Done
			SetVehicleTyreFixed(vehicle, 0)
			SetVehicleTyreFixed(vehicle, 1)
			SetVehicleTyreFixed(vehicle, 2)
			SetVehicleTyreFixed(vehicle, 3)
			SetVehicleTyreFixed(vehicle, 4)
			SetDriftTyresEnabled(vehicle, false)
			emptyHands(playerPed)
			updateCar(vehicle)
			TriggerServerEvent('jim-mechanic:server:giveDrift')
			TriggerEvent("QBCore:Notify", Loc[Config.Lan]["tires"].remove, "success")
		end, function() -- Cancel
			TriggerEvent("QBCore:Notify", Loc[Config.Lan]["tires"].remfail, "error")
			emptyHands(playerPed)
		end)
	end
end)

--========================================================== Bullet Proof
RegisterNetEvent('jim-mechanic:client:applyBulletProof', function()
	if not jobChecks() then return end
	local playerPed	= PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	if not inCar() then return end
	if not nearPoint(coords) then return end
	if not IsPedInAnyVehicle(playerPed, false) then vehicle = getClosest(coords) pushVehicle(vehicle) end
	if Config.isVehicleOwned and not IsVehicleOwned(trim(GetVehicleNumberPlateText(vehicle))) then TriggerEvent("QBCore:Notify", Loc[Config.Lan]["common"].owned, "error") return end
	if DoesEntityExist(vehicle) then
		if GetNumVehicleMods(vehicle,11) == 0 then TriggerEvent("QBCore:Notify", Loc[Config.Lan]["common"].noOptions, "error") return end
		if GetVehicleTyresCanBurst(vehicle) == false then TriggerEvent("QBCore:Notify", Loc[Config.Lan]["common"].already2, "error") else
			SetVehicleEngineOn(vehicle, false, false, true)
			TaskTurnPedToFaceEntity(playerPed, vehicle, 1000)
			Wait(1000)
			time = math.random(7000,10000)
			QBCore.Functions.Progressbar("drink_something", Loc[Config.Lan]["tires"].install2, time, false, true, { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = false, },
			{ animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 8, }, {}, {}, function()
				SetVehicleTyreFixed(vehicle, 0)
				SetVehicleTyreFixed(vehicle, 1)
				SetVehicleTyreFixed(vehicle, 2)
				SetVehicleTyreFixed(vehicle, 3)
				SetVehicleTyreFixed(vehicle, 4)
				SetVehicleTyresCanBurst(vehicle, false)
				emptyHands(playerPed)
				updateCar(vehicle)
				TriggerServerEvent('jim-mechanic:server:removeBulletProof')
				if GetDriftTyresEnabled(vehicle) ~= false then
					TriggerServerEvent('jim-mechanic:server:giveDrift')
					SetDriftTyresEnabled(vehicle, false)
					TriggerEvent("QBCore:Notify", Loc[Config.Lan]["tires"].swap2, "success")
				end
				TriggerEvent("QBCore:Notify", Loc[Config.Lan]["tires"].installed2, "success")
			end, function() -- Cancel
				TriggerEvent("QBCore:Notify", Loc[Config.Lan]["tires"].failed2, "error")
				ClearPedTasks(playerPed)
			end)
		end
	end
end)

RegisterNetEvent('jim-mechanic:client:giveBulletProof', function()
	if not jobChecks() then return end
	local playerPed	= PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	vehicle = getClosest(coords) pushVehicle(vehicle)
	if Config.isVehicleOwned and not IsVehicleOwned(trim(GetVehicleNumberPlateText(vehicle))) then TriggerEvent("QBCore:Notify", Loc[Config.Lan]["common"].owned, "error") return end
	if DoesEntityExist(vehicle) then
		TaskTurnPedToFaceEntity(playerPed, vehicle, 1000)
		Wait(1000)
		QBCore.Functions.Progressbar("accepted_key", Loc[Config.Lan]["tires"].removing2, 8000, false, true, { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true, },
		{ animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 8, }, {}, {}, function()
			SetVehicleTyreFixed(vehicle, 0)
			SetVehicleTyreFixed(vehicle, 1)
			SetVehicleTyreFixed(vehicle, 2)
			SetVehicleTyreFixed(vehicle, 3)
			SetVehicleTyreFixed(vehicle, 4)
			SetVehicleTyresCanBurst(vehicle, true)
			ClearPedTasks(playerPed)
			updateCar(vehicle)
			TriggerServerEvent('jim-mechanic:server:giveBulletProof')
			TriggerEvent("QBCore:Notify", Loc[Config.Lan]["tires"].remove2, "success")
		end, function()
			TriggerEvent("QBCore:Notify", Loc[Config.Lan]["tires"].remfail, "error")
			ClearPedTasks(playerPed)								
		end)
	end
end)