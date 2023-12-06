local QBCore = exports['qb-core']:GetCoreObject()

Config.StoreLocations = {
	--Add your poly zone box locations and job name for each store and it will add it to the qb-target loop above
	{ coords = vector3(-37.53, -1036.11, 28.6), w = 1.6, d = 0.6, heading = 340.0, job = "mechanic" }, -- Bennys Workshop next to PDM
	{ coords = vector3(-199.44, -1319.16, 31.11), w = 0.85, d = 1.8, heading = 359.0, job = "mechanic" }, -- Alta Street Bennys Workshop
	{ coords = vector3(-347.9, -133.19, 39.01), w = 1.2, d = 0.25, heading = 340.0, job = "mechanic" }, -- LS Customs in city
	{ coords = vector3(474.83, -1308.06, 29.21), w = 1.6, d = 0.5, heading = 295.0, job = "mechanic" }, -- Hayes Autos
	{ coords = vector3(1171.64, 2635.84, 37.78), w = 0.6, d = 0.5, heading = 45.0, job = "mechanic" }, -- LS Customs route 68
	{ coords = vector3(109.9, 6632.02, 31.79), w = 0.6, d = 0.5, heading = 270.0, job = "mechanic" }, -- Beekers Garage Paleto
	{ coords = vector3(128.64, -3014.68, 7.04), w = 1.6, d = 3.0, heading = 0.0, job = "mechanic" }, -- Gabz LS Tuner Shop
	{ coords = vector3(-1144.2, -2003.91, 13.18), w = 1.6, d = 0.6, heading = 45.0, job = "mechanic" }, -- Airport LS Customs
}
-- Add the store locations
Citizen.CreateThread(function()
	if Config.Stores then
		for k, v in pairs(Config.StoreLocations) do
			exports['qb-target']:AddBoxZone("MechStore"..k, v.coords, v.w, v.d, { name="MechStore"..k, heading = v.heading, debugPoly=Config.Debug, minZ=v.coords.z-1.0, maxZ=v.coords.z+1.0 }, 
				{ options = { { event = "jim-mechanic:client:Store:Menu", icon = "fas fa-cogs", label = Loc[Config.Lan]["stores"].browse, job = v.job }, },
				  distance = 2.0
			})
		end
	end
end)

-- Menu to pick the store
RegisterNetEvent('jim-mechanic:client:Store:Menu', function(data)
    exports['qb-menu']:openMenu({
        { header = Loc[Config.Lan]["stores"].tools, txt = "", params = { event = "jim-mechanic:client:Store", args = { id = 1, job = data.job } } },
        { header = Loc[Config.Lan]["stores"].perform, txt = "", params = { event = "jim-mechanic:client:Store", args = { id = 2, job = data.job } } },
        { header = Loc[Config.Lan]["stores"].cosmetic, txt = "", params = { event = "jim-mechanic:client:Store", args = { id = 3, job = data.job } } },
    })
end)

-- Open the selected store
RegisterNetEvent('jim-mechanic:client:Store', function(data)
	if data.id == 1 then TriggerServerEvent("inventory:server:OpenInventory", "shop", data.job, Config.ToolItems) 
	elseif data.id == 2 then TriggerServerEvent("inventory:server:OpenInventory", "shop", data.job, Config.PerformItems)
	elseif data.id == 3 then TriggerServerEvent("inventory:server:OpenInventory", "shop", data.job, Config.StoreItems) end
end)

Config.ToolItems = {
    label = Loc[Config.Lan]["stores"].tools, slots = 7,
    items = {
	[1] = { name = "mechanic_tools", price = 0, amount = 10, info = {}, type = "item", slot = 1, },
	[2] = { name = "toolbox", price = 0, amount = 10, info = {}, type = "item", slot = 2, },
	[3] = { name = "ducttape", price = 0, amount = 100, info = {}, type = "item", slot = 3, },
	[4] = { name = "paintcan", price = 0, amount = 50, info = {}, type = "item", slot = 4, },
	[5] = { name = "tint_supplies", price = 0, amount = 50, info = {}, type = "item", slot = 5, },
	[6] = { name = "underglow_controller", price = 0, amount = 50, info = {}, type = "item", slot = 6, },
	[7] = { name = "cleaningkit", price = 0, amount = 100, info = {}, type = "item", slot = 7, }, }
}

Config.PerformItems = {
    label = Loc[Config.Lan]["stores"].perform, slots = 19,
    items = {
	[1] = { name = "turbo", price = 0, amount = 50, info = {}, type = "item", slot = 1, }, 
	[2] = { name = "engine1", price = 0, amount = 50, info = {}, type = "item", slot = 2, }, 
	[3] = { name = "engine2", price = 0, amount = 50, info = {}, type = "item", slot = 3, }, 
	[4] = { name = "engine3", price = 0, amount = 50, info = {}, type = "item", slot = 4, }, 
	[5] = { name = "engine4", price = 0, amount = 50, info = {}, type = "item", slot = 5, }, 
	[6] = { name = "transmission1", price = 0, amount = 50, info = {}, type = "item", slot = 6, },		
	[7] = { name = "transmission2", price = 0, amount = 50, info = {}, type = "item", slot = 7, },		
	[8] = { name = "transmission3", price = 0, amount = 50, info = {}, type = "item", slot = 8, },		
	[9] = { name = "brakes1", price = 0, amount = 50, info = {}, type = "item", slot = 9, },
	[10] = { name = "brakes2", price = 0, amount = 50, info = {}, type = "item", slot = 10, },
	[11] = { name = "brakes3", price = 0, amount = 50, info = {}, type = "item", slot = 11, },
	[12] = { name = "car_armor", price = 0, amount = 50, info = {}, type = "item", slot = 12, },
	[13] = { name = "suspension1", price = 0, amount = 50, info = {}, type = "item", slot = 13, },
	[14] = { name = "suspension2", price = 0, amount = 50, info = {}, type = "item", slot = 14, },
	[15] = { name = "suspension3", price = 0, amount = 50, info = {}, type = "item", slot = 15, },
	[16] = { name = "suspension4", price = 0, amount = 50, info = {}, type = "item", slot = 16, },
	[17] = { name = "bprooftires", price = 0, amount = 50, info = {}, type = "item", slot = 17, },
	[18] = { name = "drifttires", price = 0, amount = 50, info = {}, type = "item", slot = 18, },
	[19] = { name = "nos", price = 0, amount = 50, info = {}, type = "item", slot = 19, }, }
}

Config.StoreItems = {
    label = Loc[Config.Lan]["stores"].cosmetic, slots = 15,
    items = {
	[1] = { name = "hood", price = 0, amount = 50, info = {}, type = "item", slot = 1, },
	[2] = { name = "roof", price = 0, amount = 50, info = {}, type = "item", slot = 2, },
	[3] = { name = "spoiler", price = 0, amount = 50, info = {}, type = "item", slot = 3, },
	[4] = { name = "bumper", price = 0, amount = 50, info = {}, type = "item", slot = 4, },
	[5] = { name = "skirts", price = 0, amount = 50, info = {}, type = "item", slot = 5, },
	[6] = { name = "exhaust", price = 0, amount = 50, info = {}, type = "item", slot = 6, },
	[7] = { name = "seat", price = 0, amount = 50, info = {}, type = "item", slot = 7, },
	[8] = { name = "livery", price = 0, amount = 50, info = {}, type = "item", slot = 8, },
	[9] = { name = "tires", price = 0, amount = 50, info = {}, type = "item", slot = 9, },
	[10] = { name = "horn", price = 0, amount = 50, info = {}, type = "item", slot = 10, },
	[11] = { name = "internals", price = 0, amount = 50, info = {}, type = "item", slot = 11, },
	[12] = { name = "externals", price = 0, amount = 50, info = {}, type = "item", slot = 12, },
	[13] = { name = "customplate", price = 0, amount = 50, info = {}, type = "item", slot = 13, },
	[14] = { name = "headlights", price = 0, amount = 50, info = {}, type = "item", slot = 14, },
	[15] = { name = "rims", price = 0, amount = 100, info = {}, type = "item", slot = 15, }, }
}

AddEventHandler('onResourceStop', function(r) if r == GetCurrentResourceName() then for k, v in pairs(Config.StoreLocations) do exports['qb-target']:RemoveZone("MechStore"..k) end end end)