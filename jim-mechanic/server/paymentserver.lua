local QBCore = exports['qb-core']:GetCoreObject()

local balance = nil

--REMOVE THIS COMMAND IF YOU ONLY WANT TO USE THE REGISTER SYSTEM
QBCore.Commands.Add('charge', 'Charge A Player', {{name = 'id', help = 'Player ID'}, {name = 'amount', help = 'Sale Amount'}, {name = 'type', help = 'Cash/Card'}}, false, function(source, args) 
	local biller = QBCore.Functions.GetPlayer(source)
	local billed = QBCore.Functions.GetPlayer(tonumber(args[1]))
	local amount = tonumber(args[2])
	local billtype = string.lower(tostring(args[3]))
	for k, v in pairs(Config.JobRoles) do if v == biller.PlayerData.job.name then havejob = true end end if havejob then
		if billed ~= nil then
				if billtype == "cash" then balance = billed.Functions.GetMoney(billtype)
					if balance >= amount then billed.Functions.RemoveMoney('cash', amount) TriggerEvent("qb-bossmenu:server:addAccountMoney", tostring(biller.PlayerData.job.name), amount)	TriggerEvent('jim-payments:Tickets:Give', amount, tostring(biller.PlayerData.job.name))
					else 
						TriggerClientEvent("QBCore:Notify", source, "Customer doesn't have enough cash to pay", "error")
						TriggerClientEvent("QBCore:Notify", tonumber(citizen), "You don't have enough cash to pay", "error")
					end
				elseif billtype == "card" then
			if biller.PlayerData.citizenid ~= billed.PlayerData.citizenid then
				if amount and amount > 0 then
					MySQL.Async.insert(
						'INSERT INTO phone_invoices (citizenid, amount, society, sender, sendercitizenid) VALUES (?, ?, ?, ?, ?)',
						{billed.PlayerData.citizenid, amount, biller.PlayerData.job.name,
						 biller.PlayerData.charinfo.firstname, biller.PlayerData.citizenid})
					TriggerClientEvent('qb-phone:RefreshPhone', billed.PlayerData.source)
					TriggerClientEvent('QBCore:Notify', source, 'Invoice Successfully Sent', 'success')
					TriggerClientEvent('QBCore:Notify', billed.PlayerData.source, 'New Invoice Received')
				else TriggerClientEvent('QBCore:Notify', source, 'Must Be A Valid Amount Above 0', 'error') end
			else TriggerClientEvent('QBCore:Notify', source, 'You Cannot Bill Yourself', 'error') end
			else TriggerClientEvent('QBCore:Notify', source, "Invalid choice, 'Cash' or 'Card'", 'error') end
		else TriggerClientEvent('QBCore:Notify', source, 'Player Not Online', 'error') end
	else TriggerClientEvent('QBCore:Notify', source, 'No Access', 'error') end
end)