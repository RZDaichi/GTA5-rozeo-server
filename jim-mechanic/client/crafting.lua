local QBCore = exports['qb-core']:GetCoreObject()

Config.CraftingLocations = {
	--Add your poly zone box locations and job name for each store and it will add it to the qb-target loop
	{ coords = vector3(-38.25, -1038.99, 28.6), w = 4.0, d = 0.6, heading = 340.0, job = "mechanic" }, -- Bennys Workshop next to PDM
	{ coords = vector3(-198.74, -1314.46, 31.09), w = 2.8, d = 1.0, heading = 270.0, job = "mechanic" }, -- Alta Street Bennys Workshop
	{ coords = vector3(-340.44, -141.9, 39.01), w = 3.2, d = 1.0, heading = 255.0, job = "mechanic" }, -- LS Customs in city
	{ coords = vector3(472.54, -1313.22, 29.21), w = 3.2, d = 1.0, heading = 30.0, job = "mechanic" }, -- Hayes Autos
	{ coords = vector3(1176.69, 2635.44, 37.75), w = 3.2, d = 1.0, heading = 270.0, job = "mechanic" }, -- LS Customs route 68
	{ coords = vector3(105.98, 6628.84, 31.79), w = 3.2, d = 1.0, heading = 315.0, job = "mechanic" }, -- Beekers Garage Paleto
	{ coords = vector3(136.71, -3051.29, 7.04), w = 0.6, d = 1.0, heading = 0.0, job = "mechanic" }, -- Gabz LS Tuner Shop
	{ coords = vector3(-1158.71, -2002.37, 13.18), w = 0.6, d = 3.8, heading = 45.0, job = "mechanic" }, -- Airport LS Customs
}
-- Add the store locations
Citizen.CreateThread(function()
	if Config.Crafting then
		for k, v in pairs(Config.CraftingLocations) do
			exports['qb-target']:AddBoxZone("MechCraft: "..k, v.coords, v.w, v.d, { name="MechCraft: "..k, heading = v.heading, debugPoly=Config.Debug, minZ=v.coords.z-1.0, maxZ=v.coords.z+1.0 }, 
				{ options = { { event = "jim-mechanic:client:Crafting:Menu", icon = "fas fa-cogs", label = Loc[Config.Lan]["crafting"].menuheader, job = v.job }, },
				  distance = 2.0
			})
		end
	end
end)

RegisterNetEvent('jim-mechanic:client:Crafting:Menu', function()
    exports['qb-menu']:openMenu({
        { isMenuHeader = true, header = Loc[Config.Lan]["crafting"].menuheader, txt = "", },
		{ header = "", txt = Loc[Config.Lan]["common"].close, params = { event = "" } },
		{ header = Loc[Config.Lan]["crafting"].toolheader, txt = #Crafting.Tools..Loc[Config.Lan]["crafting"].numitems, params = { event = "jim-mechanic:Crafting", args = { craftable = Crafting.Tools, header = Loc[Config.Lan]["crafting"].toolheader, } } },
        { header = Loc[Config.Lan]["crafting"].performheader, txt = #Crafting.Perform..Loc[Config.Lan]["crafting"].numitems, params = { event = "jim-mechanic:Crafting", args = { craftable = Crafting.Perform, header = Loc[Config.Lan]["crafting"].performheader, } } },
        { header = Loc[Config.Lan]["crafting"].cosmetheader, txt = #Crafting.Cosmetic..Loc[Config.Lan]["crafting"].numitems, params = { event = "jim-mechanic:Crafting", args = { craftable = Crafting.Cosmetic, header = Loc[Config.Lan]["crafting"].cosmetheader, } } },
    })
end)

RegisterNetEvent('jim-mechanic:Crafting', function(data)
	local Menu = {}
	Menu[#Menu + 1] = { header = data.header, txt = "", isMenuHeader = true }
	Menu[#Menu + 1] = { header = "", txt = Loc[Config.Lan]["common"].ret, params = { event = "jim-mechanic:client:Crafting:Menu" } }
		for i = 1, #data.craftable do
			for k, v in pairs(data.craftable[i]) do
				if k ~= "amount" then
					local text = ""
					setheader = QBCore.Shared.Items[tostring(k)].label
					if data.craftable[i]["amount"] ~= nil then setheader = setheader.." x"..data.craftable[i]["amount"] end
					for l, b in pairs(data.craftable[i][tostring(k)]) do
						if b == 1 then number = "" else number = " x"..b end
						text = text.."- "..QBCore.Shared.Items[l].label..number.."<br>"
						settext = text
					end
					Menu[#Menu + 1] = { header = "<img src=nui://"..Config.img..QBCore.Shared.Items[k].image.." width=30px> "..setheader, txt = settext, params = { event = "jim-mechanic:Crafting:MakeItem", args = { item = k, craftable = data.craftable, header = data.header } } }
					settext, setheader = nil
				end
			end
		end
	exports['qb-menu']:openMenu(Menu)
end)

RegisterNetEvent('jim-mechanic:Crafting:MakeItem', function(data)
	for i = 1, #data.craftable do
		for k, v in pairs(data.craftable[i]) do
			if data.item == k then
				QBCore.Functions.TriggerCallback('jim-mechanic:Crafting:get', function(amount) 
					if not amount then TriggerEvent('QBCore:Notify', Loc[Config.Lan]["crafting"].ingredients, 'error') else TriggerEvent('jim-mechanic:Crafting:ItemProgress', data) end		
				end, data.item, data.craftable)
			end
		end
	end
end)

RegisterNetEvent('jim-mechanic:Crafting:ItemProgress', function(data)
	QBCore.Functions.Progressbar('making_food',  "Crafting "..QBCore.Shared.Items[data.item].label, 7000, false, false, { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = false, }, 
	{ animDict = "mini@repair", anim = "fixing_a_ped", flags = 8, },
	{}, {}, function()  
		TriggerServerEvent('jim-mechanic:Crafting:GetItem', data.item, data.craftable)
		emptyHands(PlayerPedId())
		TriggerEvent("jim-mechanic:Crafting", data)
	end, function() -- Cancel
		TriggerEvent('inventory:client:busy:status', false)
		emptyHands(PlayerPedId())
	end)
end)

AddEventHandler('onResourceStop', function(r) if r == GetCurrentResourceName() then for k, v in pairs(Config.CraftingLocations) do exports['qb-target']:RemoveZone("MechCraft: "..k) end end end)

Crafting = {}
Crafting.Tools = {
	[1] = { ['mechanic_tools'] = { ['iron'] = 1, } },
	[2] = { ['toolbox'] = { ['iron'] = 1, } },
	[3] = { ['ducttape'] = { ['plastic'] = 1, } },
	[4] = { ['paintcan'] = { ['aluminum'] = 1, } },
	[5] = { ['tint_supplies'] = { ['iron'] = 1, } },
	[6] = { ['underglow_controller'] = { ['iron'] = 1, } },
	[7] = { ['cleaningkit'] = { ['rubber'] = 1, } },
}
Crafting.Perform = {
	[1] = { ['turbo'] = { ['steel'] = 1, } },
	[2] = { ['car_armor'] = { ['plastic'] = 1, } },
	[3] = { ['engine1'] = { ['steel'] = 1, } },
	[4] = { ['engine2'] = { ['steel'] = 1, } },
	[5] = { ['engine3'] = { ['steel'] = 1, } },
	[6] = { ['engine4'] = { ['steel'] = 1, } },
	[7] = { ['transmission1'] = { ['steel'] = 1, } },
	[8] = { ['transmission2'] = { ['steel'] = 1, } },
	[9] = { ['transmission3'] = { ['steel'] = 1, } },
	[10] = { ['brakes1'] = { ['steel'] = 1, } },
	[11] = { ['brakes2'] = { ['steel'] = 1, } },
	[12] = { ['brakes3'] = { ['steel'] = 1, } },
	[13] = { ['suspension1'] = { ['steel'] = 1, } },
	[14] = { ['suspension2'] = { ['steel'] = 1, } },
	[15] = { ['suspension3'] = { ['steel'] = 1, } },
	[16] = { ['suspension4'] = { ['steel'] = 1, } },
	[17] = { ['bprooftires'] = { ['rubber'] = 1, } },
	[18] = { ['drifttires'] = { ['rubber'] = 1, } },
	[19] = { ['nos'] = { ['noscan'] = 1, } },
	[20] = { ['noscan'] = { ['steel'] = 1, } },
}
Crafting.Cosmetic = {
	[1] = { ['hood'] = { ['plastic'] = 1, } },
	[2] = { ['roof'] = { ['plastic'] = 1, } },
	[3] = { ['spoiler'] = { ['plastic'] = 1, } },
	[4] = { ['bumper'] = { ['plastic'] = 1, } },
	[5] = { ['skirts'] = { ['plastic'] = 1, } },
	[6] = { ['exhaust'] = { ['iron'] = 1, } },
	[7] = { ['seat'] = { ['plastic'] = 1, } },
	[8] = { ['livery'] = { ['plastic'] = 2 },
			["amount"] = 3, -- Example, can make multiple of one item
		  },
	[9] = { ['tires'] = { ['rubber'] = 1, } },
	[10] = { ['horn'] = { ['plastic'] = 1, } },
	[11] = { ['internals'] = { ['plastic'] = 1, } },
	[12] = { ['externals'] = { ['plastic'] = 1, } },
	[13] = { ['customplate'] = { ['steel'] = 1, } },
	[14] = { ['headlights'] = { ['plastic'] = 1, } },
	[15] = { ['rims'] = { ['iron'] = 1, } },
}