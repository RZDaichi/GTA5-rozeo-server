local QBCore = exports['qb-core']:GetCoreObject()

PlayerJob = {}

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.GetPlayerData(function(PlayerData) PlayerJob = PlayerData.job
        if PlayerData.job.onduty then
			for k, v in pairs(Config.JobRoles) do if v == PlayerJob.name then havejob = true end end
			if havejob then TriggerServerEvent("QBCore:ToggleDuty") end end
    end)
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate') AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo) PlayerJob = JobInfo onDuty = PlayerJob.onduty end)
RegisterNetEvent('QBCore:Client:SetDuty') AddEventHandler('QBCore:Client:SetDuty', function(duty) onDuty = duty end)

AddEventHandler('onResourceStart', function(resource)
    if GetCurrentResourceName() == resource then
		QBCore.Functions.GetPlayerData(function(PlayerData)
			PlayerJob = PlayerData.job
			for k, v in pairs(Config.JobRoles) do if v == PlayerJob.name then havejob = true end end
			if havejob then onDuty = PlayerJob.onduty end end) 
	end
	Wait(500)
end)

Config.Locations = {
	{	label = "mechanic", -- Set this to the required job
		zones = {
			vector2(-39.657638549805, -1026.12890625),
			vector2(-54.971218109131, -1066.3665771484),
			vector2(-20.210899353027, -1079.1593017578),
			vector2(-6.8900542259216, -1038.0417480469),
		},
		blip = vector3(-43.05, -1043.99, 28.76),
		bliplabel = "Bennys Workshop",    -- Bennys Workshop next to PDM
		blipcolor = 55,
	},
	{	label = "mechanic", -- Set this to the required job
		zones = {
			vector2(-189.07, -1311.31),
			vector2(-188.36, -1343.46),
			vector2(-217.37, -1343.54),
			vector2(-217.99, -1340.32),
			vector2(-244.44, -1342.33),
			vector2(-244.07, -1312.06)
		},
		blip = vector3(-211.55, -1324.55, 30.9),
		bliplabel = "Bennys Workshop",    -- Alta Street Bennys Workshop
		blipcolor = 55,
	},
	{	label = "mechanic", -- Set this to the required job
		zones = {
			vector2(-356.63, -137.9),
			vector2(-347.32, -111.48),
			vector2(-309.05, -128.79),
			vector2(-324.44, -148.96)
		},
		blip = vector3(-336.84, -136.39, 39.01),
		bliplabel = "Los Santos Customs",    -- LS CUSTOMS in city
		blipcolor = 55,
	},
	{	label = "mechanic", -- Set this to the required job
		zones = {
		  vector2(490.57400512695, -1302.0946044922),
		  vector2(490.27529907227, -1305.3948974609),
		  vector2(509.71032714844, -1336.8293457031),
		  vector2(483.09429931641, -1339.0887451172),
		  vector2(479.38552856445, -1330.6906738281),
		  vector2(469.89437866211, -1309.5773925781)
		},
		blip = vector3(480.52, -1318.24, 29.2),
		bliplabel = "Hayes Autos",    -- Hayes Autos
		blipcolor = 55,
	},
	{	label = "mechanic", -- Set this to the required job
		zones = {
			vector2(1190.58, 2645.39),
			vector2(1190.72, 2634.46),
			vector2(1170.39, 2634.2),
			vector2(1170.33, 2645.83)
		},
		blip = vector3(1177.62, 2640.83, 37.75),
		bliplabel = "Los Santos Customs",    -- LS CUSTOMS Route 68
		blipcolor = 55,
	},
	{	label = "mechanic", -- Set this to the required job
		zones = {
			vector2(117.79, 6625.31),
			vector2(102.88, 6611.96),
			vector2(95.51, 6619.93),
			vector2(108.8, 6633.98)
		},
		blip = vector3(108.36, 6623.67, 31.79),
		bliplabel = "Beekers Garage",    -- Beekers Garage Paleto
		blipcolor = 55,
	},
	{	label = "mechanic", -- Set this to the required job
		zones = {
		  vector2(154.69816589355, -3007.0153808594),
		  vector2(120.64015197754, -3006.7275390625),
		  vector2(120.48593902588, -3051.8874511719),
		  vector2(154.61296081543, -3051.5419921875)
		},
		blip = vector3(139.91, -3023.83, 7.04),
		bliplabel = "LS Tuner Shop",    -- Gabz LS Tuner Shop
		blipcolor = 55,
	},	
	{	label = "mechanic", -- Set this to the required job
		zones = {
			vector2(-1118.5782470703, -2017.4730224609),
			vector2(-1143.9351806641, -2042.6685791016),
			vector2(-1172.8060302734, -2014.1071777344),
			vector2(-1147.3665771484, -1988.7028808594)
		},
		blip = vector3(-1138.22, -1995.11, 13.17),
		bliplabel = "Los Santos Customs",    -- Airport LS Customs
		blipcolor = 55,
	},
    -- Add a new job like this with location
	-- Check out https://github.com/mkafrin/PolyZone/wiki/Using-the-creation-script for information on how to make polyzones, its really easy
	-- When you have the vectors, copy them into a new zone below and it should work!
	-- The name is the players Job Role eg. "mechanic", if you set Config.JobRequiredForLocation to false, this can be whatever.
    --{	label = "mechanic",
	--	zones = {
	--		vector2(-308.60556030273, -983.15423583984),
	--		vector2(-294.68597412109, -988.24194335938),
	--		vector2(-297.03381347656, -994.37298583984),
	--		vector2(-346.31329345703, -976.38232421875),
	--		vector2(-343.78552246094, -970.34112548828)
	--	}
	--},
	--		
	--SIMPLE BLIP SETUP
	--If blip info is there it will generate a blip
	--If blip label is added (can be removed) it will add the chosen blip name otherwise it will default to "Mechanic Shop"
	--Blip colours can be found here: https://docs.fivem.net/docs/game-references/blips/
	--		blip = vector3(530.48, -1336.1, 29.27),
	--		bliplabel = "Bennys",
	--		blipcolor = 8,
    --},
}
CreateThread(function()
	if Config.LocationRequired then
		for k, v in pairs(Config.Locations) do
			JobLocation = PolyZone:Create(Config.Locations[k].zones, {
				name = Config.Locations[k].label,
				debugPoly = Config.Debug
			})
			JobLocation:onPlayerInOut(function(isPointInside)
				if isPointInside then
					if Config.JobRequiredForLocation then 
						if PlayerJob.name == tostring(Config.Locations[k].label) then
							if onDuty ~= true then TriggerServerEvent("QBCore:ToggleDuty") end
						end
					elseif not Config.JobRequiredForLocation then 
						for k, v in pairs(Config.JobRoles) do
							if v == PlayerJob.name  and onDuty ~= true then TriggerServerEvent("QBCore:ToggleDuty") end
						end
					end
				else
					if Config.JobRequiredForLocation then
						if PlayerJob.name == tostring(Config.Locations[k].label) then
							if onDuty ~= false then TriggerServerEvent("QBCore:ToggleDuty") end
						end
					elseif not Config.JobRequiredForLocation then 
						for k, v in pairs(Config.JobRoles) do
							if v == PlayerJob.name and onDuty ~= false then TriggerServerEvent("QBCore:ToggleDuty") end
						end
					end
				end
			end)		
		end
	end
end)

CreateThread(function()
	if Config.LocationBlips then
		for k, v in pairs(Config.Locations) do
			if Config.Locations[k].blip ~= nil then
				local blip = AddBlipForCoord(Config.Locations[k].blip)
				SetBlipAsShortRange(blip, true)
				SetBlipSprite(blip, 446)
				SetBlipColour(blip, Config.Locations[k].blipcolor)
				SetBlipScale(blip, 0.7)
				SetBlipDisplay(blip, 6)
				BeginTextCommandSetBlipName('STRING')
				if Config.Locations[k].bliplabel ~= nil then AddTextComponentString(Config.Locations[k].bliplabel)
				else AddTextComponentString("Mechanic Shop") end
				EndTextCommandSetBlipName(blip)
			end
		end
	end
end)