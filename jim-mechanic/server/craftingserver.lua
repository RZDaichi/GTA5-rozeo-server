local QBCore = exports['qb-core']:GetCoreObject()

local function GetStashItems(stashId)
	local items = {}
	local result = MySQL.Sync.fetchScalar('SELECT items FROM stashitems WHERE stash = ?', {stashId})
	if result then
		local stashItems = json.decode(result)
		if stashItems then
			for k, item in pairs(stashItems) do
				local itemInfo = QBCore.Shared.Items[item.name:lower()]
				if itemInfo then
					items[item.slot] = {
						name = itemInfo["name"],
						amount = tonumber(item.amount),
						info = item.info ~= nil and item.info or "",
						label = itemInfo["label"],
						description = itemInfo["description"] ~= nil and itemInfo["description"] or "",
						weight = itemInfo["weight"],
						type = itemInfo["type"],
						unique = itemInfo["unique"],
						useable = itemInfo["useable"],
						image = itemInfo["image"],
						slot = item.slot,
					}
				end
			end
		end
	end
	return items
end

---Crafting 
RegisterServerEvent('jim-mechanic:Crafting:GetItem', function(ItemMake, craftable)
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	--This grabs the table from client and removes the item requirements
	if craftable ~= nil then
		if Config.StashCraft then 
			for i = 1, #craftable do
				for k, v in pairs(craftable[i]) do
					if ItemMake == k and k ~= "amount" then
						if craftable[i]["amount"] ~= nil then amount = craftable[i]["amount"] else amount = 1 end			
						for j, c in pairs(craftable[i][k]) do
							stashItems = GetStashItems(Player.PlayerData.job.name .. "Safe")
							for l, b in pairs(stashItems) do
								if b.name == j then
									if (stashItems[l].amount - c) <= 0 then stashItems[l] = nil	else stashItems[l].amount = stashItems[l].amount - c end 
									TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[j], "use", c)
									TriggerEvent('qb-inventory:server:SaveStashItems', Player.PlayerData.job.name .. "Safe", stashItems)
									if Config.Debug then print("Removing "..QBCore.Shared.Items[j].label.." x"..c.." from stash: '"..Player.PlayerData.job.name.."Safe'") end
									c = (c-c) break
								end
							end
							
						end
					end
				end
			end
		else
			for i = 1, #craftable do
				for k, v in pairs(craftable[i]) do
					if ItemMake == k and k ~= "amount" then
						if craftable[i]["amount"] ~= nil then amount = craftable[i]["amount"] else amount = 1 end
						for l, b in pairs(craftable[i][k]) do
							TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[tostring(l)], "remove", b) 
							Player.Functions.RemoveItem(tostring(l), b)
						end
					end
				end
			end	
		end
	end
	--This should give the item, while the rest removes the requirements
	Player.Functions.AddItem(ItemMake, amount, false, {["quality"] = nil})
	TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[ItemMake], "add", amount) 
end)

---ITEM REQUIREMENT CHECKS
QBCore.Functions.CreateCallback('jim-mechanic:Crafting:get', function(source, cb, item, craftable)
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local hasitem = false
	local hasanyitem = nil
	if Config.StashCraft then 
		stashItems = GetStashItems(Player.PlayerData.job.name .. "Safe")
		for i = 1, #craftable do
			for k, v in pairs(craftable[i]) do		
				if k == item then
					for j, c in pairs(craftable[i][k]) do
						for l, b in pairs(stashItems) do
							if b.name == j and b.amount >= c then
								hasitem = true
								if Config.Debug then print(b.label.." x"..b.amount.." found in stash: '"..Player.PlayerData.job.name.."Safe'") end
							else hasanytime = false 							
							end
						end
					end
				end
			end
		end
	else
		for i = 1, #craftable do
			for k, v in pairs(craftable[i]) do
				if k == item then
					for l, b in pairs(craftable[i][k]) do
						if QBCore.Functions.GetPlayer(source).Functions.GetItemByName(l) and QBCore.Functions.GetPlayer(source).Functions.GetItemByName(l).amount >= b then hasitem = true
						else hasanyitem = false
						end
					end
				end
			end
		end
	end
	if hasanyitem ~= nil then hasitem = false end
if hasitem then cb(true) else cb(false) end end)