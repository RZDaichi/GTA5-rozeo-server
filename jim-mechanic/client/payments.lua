local QBCore = exports['qb-core']:GetCoreObject()

Config.RegisterLocations = {
	--Add your box locations and job name for each payment register and it will add it to the qb-target loop above
	{ coords = vector3(-35.91, -1040.47, 28.6), w = 0.4, d = 0.4, heading = 340.0, job = "mechanic", img = "<center><p><img src=https://static.wikia.nocookie.net/gtawiki/images/b/be/BennysOriginalMotorWorks-GTAO-Logo.png width=150px></p>" }, -- Bennys Workshop next to PDM
	{ coords = vector3(-200.68, -1314.53, 31.08), w = 0.4, d = 0.4, heading = 0.0, job = "mechanic", img = "<center><p><img src=https://static.wikia.nocookie.net/gtawiki/images/b/be/BennysOriginalMotorWorks-GTAO-Logo.png width=150px></p>" }, -- Alta Street Bennys Workshop
	{ coords = vector3(-343.75, -140.86, 39.02), w = 0.4, d = 0.4, heading = 180.0, job = "mechanic", img = "<center><p><img src=https://static.wikia.nocookie.net/gtawiki/images/f/f2/GTAV-LSCustoms-Logo.png width=150px></p>" }, -- LS Customs in city
	{ coords = vector3(471.76, -1311.61, 29.20), w = 0.4, d = 0.4, heading = 120.0, job = "mechanic", img = "<center><p><img src=https://static.wikia.nocookie.net/gtawiki/images/0/0c/HayesAutoBodyShop-GTAV-Logo.png width=150px></p>" }, -- Hayes Autos
	{ coords = vector3(1189.38, 2639.29, 38.44), w = 0.4, d = 0.4, heading = 270.0, job = "mechanic", img = "<center><p><img src=https://static.wikia.nocookie.net/gtawiki/images/f/f2/GTAV-LSCustoms-Logo.png width=150px></p>" }, -- LS Customs route 68
	{ coords = vector3(99.71, 6617.16, 32.47), w = 0.4, d = 0.4, heading = 140.0, job = "mechanic", img = "<center><p><img src=https://static.wikia.nocookie.net/gtawiki/images/f/f2/GTAV-LSCustoms-Logo.png width=150px></p>" }, -- Beekers Garage Paleto
	{ coords = vector3(146.44, -3014.09, 6.94), w = 0.4, d = 0.4, heading = 195.0, job = "mechanic", img = "<center><p><img src=https://static.wikia.nocookie.net/gtawiki/images/f/f2/GTAV-LSCustoms-Logo.png width=150px></p>" }, -- LS Tuner Shop
	{ coords = vector3(-1147.41, -2001.07, 13.18), w = 0.4, d = 0.4, heading = 285.0, job = "mechanic", img = "<center><p><img src=https://static.wikia.nocookie.net/gtawiki/images/f/f2/GTAV-LSCustoms-Logo.png width=150px></p>" }, -- Airport LS Customs
}

local till = {}
Citizen.CreateThread(function()
	for k, v in pairs(Config.RegisterLocations) do
		exports['qb-target']:AddBoxZone("MechReceipt: "..k, v.coords, v.w, v.d, { name="MechReceipt: "..k, heading = v.heading, debugPoly=Config.Debug, minZ=v.coords.z-0.1, maxZ=v.coords.z+0.4 }, 
			{ options = { { event = "jim-payments:client:Charge", icon = "fas fa-credit-card", label = Loc[Config.Lan]["payments"].charge, job = v.job, img = v.img }, },
			  distance = 2.0
		})
		RequestModel(GetHashKey("prop_till_03")) while not HasModelLoaded(GetHashKey("prop_till_03")) do Citizen.Wait(1) end
		till[#till+1] = CreateObject(GetHashKey("prop_till_03"), v.coords.x, v.coords.y, v.coords.z,false,false,false)
		SetEntityHeading(till[#till],v.heading+0.0)
		FreezeEntityPosition(till[#till], true)
	end
end)

AddEventHandler('onResourceStop', function(r) if r == GetCurrentResourceName() then for k, v in pairs(Config.RegisterLocations) do exports['qb-target']:RemoveZone("MechReceipt: "..k) 
for i = 1, #till do DeleteEntity(till[#till]) end end end end)

RegisterNetEvent("jim-mechanic:client:PayPopup", function(amount, biller, billtype)
	exports['qb-menu']:openMenu({
		{ isMenuHeader = true, header = "🧾 "..PlayerJob.label.." Payment 🧾", txt = "Do you want accept the payment?" },
		{ isMenuHeader = true, header = "", txt = billtype:gsub("^%l", string.upper).." Payment: $"..amount },
		{ header = "✅ Yes", txt = "", params = { isServer = true, event = "jim-payments:server:PayPopup", args = { accept = true, amount = amount, biller = biller, billtype = billtype } } },
		{ header = "❌ No", txt = "", params = { isServer = true, event = "jim-payments:server:PayPopup", args = { accept = false, amount = amount, biller = biller, billtype = billtype } } }, })
end)