
Update 2.1.1:
	- Auto fix engine and Body to 0 if value is too low (repair.lua)
	- AcualIncluded missing GetVehicleProperties and SetVehicleProperties
	- Added NOS Cooldown to reduce spamming of NOS to get insane boosts(nos.lua)

Update 2.1:
	- Fixed livery issues (police.lua & livery.lua)
		- Issues like claiming stock was installed when it wasn't
	- Added RGB Paint tool for Primary and Secondary (new file paintrgb.lua and edited paints.lua)
		- New spraying animations to go along with paints.lua and paintsrgb.lua
		- This adds a new button the "paintcan" item menu
	- Included edited GetVehicleProperties and SetVehicleProperties functions to be replaced in qb-core
		- This enables the saving of Drift Wheels, BulletProof Wheels, RGB Paint and their finishes.
	- Added Support for planes, boats and helicopters (functions.lua)
		- This requires slight edits to every client file
		- Replace "GetClosestVehicle(coords.x, coords.y, coords.z, 3.5, 0, 71)" with "getClosest(coords)"
		
Update 2.0.3:
	- Improved how the vehicles names and prices are found from the shared (functions.lua)
		- This gives better support for import custom vehicles
		- Now checks for the models HASH instead of name
		- This removes the need for the Config.carNames in the config.lua. Feel free to delete these.
		- If the car is set up in your shared correctly, it will find the info better.
	- Fixed liveries saying vehicle isn't owned even when it was. (livery.lua)
	- Set back NOS effect, forgot to change it while testing effects. (nos.lua)
		
Update 2.0.2:
	- Removed /test command left over from debugging police.lua
	- Added check to police.lua to stop passengers bringing up the menu
	- Added Resrapy Menu to Police repair station
		- Only Primary, Secondary and Pearlescent is available
	- Fixed mispelling breaking Custom Bumpers
	- Changes to the Rim section slightly, to help prevent errors
	- Changes to NOS syncing
		- Purge is white again
		- Hopefully synced better between players now
		- Added "OldFlame" toggle to top of nos.lua to toggle qbcore exhaust flame effect
		- Added tyreSync toggle to enable purge coming out as tiresmoke colour.
	- Fix for stash crafting.
		- Fixed removing items from slots then hitting 0
		- Fixed items being used beyond 0
		- Fixed the same item in serveral more than one slot being removed.

Update 2.0.1:
	- Fixed engine and transmission not saving on removing
	- NOS effects should now be synced between players
	- Attempt at fixing SQL issues for people
	- SQL is now required.
		- The only known way to fix NOS being picked up on script start, was to change how it found the info
	- Fixed traveldistance requiring qb-mechanicjob
	- Fixed police.lua requiring qb-customs

---------------------- INSTALLATION

- To install simply place this in your resource folder

- Add these lines to your qb-core > shared lua under the Items section

	--jim-mechanic Vehicles
	["mechanic_tools"] 				= {["name"] = "mechanic_tools", 			["label"] = "Mechanic tools", 		    ["weight"] = 0, 		["type"] = "item", 		["image"] = "mechanic_tools.png", 		["unique"] = true, 		["useable"] = true, 	["shouldClose"] = true,   ["combinable"] = nil,   ["description"] = "Needed for vehicle repairs"},
	["toolbox"] 					= {["name"] = "toolbox", 			 	  	["label"] = "Toolbox", 		            ["weight"] = 0, 		["type"] = "item", 		["image"] = "toolbox.png", 				["unique"] = true, 		["useable"] = true, 	["shouldClose"] = true,   ["combinable"] = nil,   ["description"] = "Needed for Performance part removal"},
	["ducttape"] 					= {["name"] = "ducttape", 			 	  	["label"] = "Duct Tape", 		       	["weight"] = 0, 		["type"] = "item", 		["image"] = "bodyrepair.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,   ["combinable"] = nil,   ["description"] = "Good for quick fixes"},
	
	--Performance
	["turbo"] 		 	 		 	= {["name"] = "turbo", 						["label"] = "Supercharger Turbo", 		["weight"] = 0, 		["type"] = "item", 		["image"] = "turbo.png", 				["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,   ["combinable"] = nil,   ["description"] = "Who doesn't need a 65mm Turbo??"},
	["car_armor"] 					= {["name"] = "car_armor", 					["label"] = "Vehicle Armor", 			["weight"] = 0, 		["type"] = "item", 		["image"] = "armour.png", 				["unique"] = true, 		["useable"] = true, 	["shouldClose"] = true,   ["combinable"] = nil,   ["description"] = ""},
	
	["nos"] 					    = {["name"] = "nos", 			 	  	  	["label"] = "NOS Bottle", 		        ["weight"] = 0, 		["type"] = "item", 		["image"] = "nos.png", 				    ["unique"] = true, 		["useable"] = true, 	["shouldClose"] = true,   ["combinable"] = nil,   ["description"] = "A full bottle of NOS"},
	["noscan"] 					    = {["name"] = "noscan", 			 	  	["label"] = "Empty NOS Bottle", 		["weight"] = 0, 		["type"] = "item", 		["image"] = "noscan.png", 				["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,  ["combinable"] = nil,   ["description"] = "An Empty bottle of NOS"},

	["engine1"] 				    = {["name"] = "engine1", 			 	  	["label"] = "Shonen Engine",            ["weight"] = 0, 		["type"] = "item", 		["image"] = "shonen.png", 				["unique"] = true, 		["useable"] = true, 	["shouldClose"] = true,   ["combinable"] = nil,   ["description"] = ""},
	["engine2"] 				    = {["name"] = "engine2", 			 	  	["label"] = "V8 Engine",        	    ["weight"] = 0, 		["type"] = "item", 		["image"] = "v8engine.png", 			["unique"] = true, 		["useable"] = true, 	["shouldClose"] = true,   ["combinable"] = nil,   ["description"] = ""},
	["engine3"] 				    = {["name"] = "engine3", 			 	  	["label"] = "V10 Engine",          		["weight"] = 0, 		["type"] = "item", 		["image"] = "v10engine.png", 			["unique"] = true, 		["useable"] = true, 	["shouldClose"] = true,   ["combinable"] = nil,   ["description"] = ""},
	["engine4"] 				    = {["name"] = "engine4", 			 	  	["label"] = "V12 Engine",               ["weight"] = 0, 		["type"] = "item", 		["image"] = "v12engine.png", 			["unique"] = true, 		["useable"] = true, 	["shouldClose"] = true,   ["combinable"] = nil,   ["description"] = ""},

	["transmission1"] 				= {["name"] = "transmission1", 				["label"] = "Transmission Lvl 1",       ["weight"] = 0, 		["type"] = "item", 		["image"] = "transmission1.png",  		["unique"] = true, 		["useable"] = true, 	["shouldClose"] = true,   ["combinable"] = nil,   ["description"] = ""},
	["transmission2"] 				= {["name"] = "transmission2", 				["label"] = "Transmission Lvl 2",       ["weight"] = 0, 		["type"] = "item", 		["image"] = "transmission2.png",  		["unique"] = true, 		["useable"] = true, 	["shouldClose"] = true,   ["combinable"] = nil,   ["description"] = ""},
	["transmission3"] 				= {["name"] = "transmission3",				["label"] = "Transmission Lvl 3",       ["weight"] = 0, 		["type"] = "item", 		["image"] = "transmission3.png",   		["unique"] = true, 		["useable"] = true, 	["shouldClose"] = true,   ["combinable"] = nil,   ["description"] = ""},

	["brakes1"] 					= {["name"] = "brakes1", 			 		["label"] = "Performance Brakes",       ["weight"] = 0, 		["type"] = "item", 		["image"] = "brakes1.png", 		    	["unique"] = true, 		["useable"] = true, 	["shouldClose"] = true,   ["combinable"] = nil,   ["description"] = ""},
	["brakes2"] 					= {["name"] = "brakes2", 			 		["label"] = "GT Big Brakes",            ["weight"] = 0, 		["type"] = "item", 		["image"] = "brakes2.png", 		    	["unique"] = true, 		["useable"] = true, 	["shouldClose"] = true,   ["combinable"] = nil,   ["description"] = ""},
	["brakes3"] 					= {["name"] = "brakes3", 			 		["label"] = "Competition Brakes",       ["weight"] = 0, 		["type"] = "item", 		["image"] = "brakes3.png", 		    	["unique"] = true, 		["useable"] = true, 	["shouldClose"] = true,   ["combinable"] = nil,   ["description"] = ""},
	
	["suspension1"] 				= {["name"] = "suspension1", 				["label"] = "Lowered Suspension", 		["weight"] = 0, 		["type"] = "item", 		["image"] = "suspension1.png", 			["unique"] = true, 		["useable"] = true, 	["shouldClose"] = true,   ["combinable"] = nil,   ["description"] = ""},
	["suspension2"] 				= {["name"] = "suspension2",  				["label"] = "Street Suspension",		["weight"] = 0, 		["type"] = "item", 		["image"] = "suspension2.png", 			["unique"] = true, 		["useable"] = true, 	["shouldClose"] = true,   ["combinable"] = nil,   ["description"] = "Street Racing level Suspension"},
	["suspension3"] 				= {["name"] = "suspension3",  				["label"] = "Racing Suspension",		["weight"] = 0, 		["type"] = "item", 		["image"] = "suspension3.png", 			["unique"] = true, 		["useable"] = true, 	["shouldClose"] = true,   ["combinable"] = nil,   ["description"] = "Street Racing level Suspension"},
	["suspension4"] 				= {["name"] = "suspension4",  				["label"] = "Rally Suspension",			["weight"] = 0, 		["type"] = "item", 		["image"] = "suspension4.png", 			["unique"] = true, 		["useable"] = true, 	["shouldClose"] = true,   ["combinable"] = nil,   ["description"] = "Street Racing level Suspension"},
	
	["bprooftires"] 				= {["name"] = "bprooftires", 			   	["label"] = "Bulletproof Tires", 		["weight"] = 0, 		["type"] = "item", 		["image"] = "bprooftires.png", 			["unique"] = true, 		["useable"] = true, 	["shouldClose"] = true,   ["combinable"] = nil,   ["description"] = ""},
	["drifttires"] 					= {["name"] = "drifttires", 			   	["label"] = "Drift Tires", 				["weight"] = 0, 		["type"] = "item", 		["image"] = "drifttires.png", 			["unique"] = true, 		["useable"] = true, 	["shouldClose"] = true,   ["combinable"] = nil,   ["description"] = ""},
	
	--Cosmetics
	["underglow_controller"] 		 = {["name"] = "underglow_controller", 		["label"] = "Neon Controller", 			["weight"] = 0, 		["type"] = "item", 		["image"] = "underglow_controller.png", ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   	["description"] = "RGB LED Vehicle Remote"},
	["headlights"] 		 	 		 = {["name"] = "headlights", 				["label"] = "Xenon Headlights", 		["weight"] = 0, 		["type"] = "item", 		["image"] = "headlights.png", 			["unique"] = true, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   	["description"] = "8k HID headlights"},
	
	["tint_supplies"] 				 = {["name"] = "tint_supplies", 			["label"] = "Tint Supplies", 			["weight"] = 0, 		["type"] = "item", 		["image"] = "tint_supplies.png", 		["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,    ["description"] = "Supplies for window tinting"},

	["customplate"] 				 = {["name"] = "customplate", 				["label"] = "Customized Plates", 		["weight"] = 0, 		["type"] = "item", 		["image"] = "plate.png", 				["unique"] = true, 		["useable"] = true, 	["shouldClose"] = true,   ["combinable"] = nil,   ["description"] = ""},
	["hood"] 						 = {["name"] = "hood", 						["label"] = "Vehicle Hood", 			["weight"] = 0, 		["type"] = "item", 		["image"] = "hood.png", 				["unique"] = true, 		["useable"] = true, 	["shouldClose"] = true,   ["combinable"] = nil,   ["description"] = ""},
	["roof"] 						 = {["name"] = "roof", 						["label"] = "Vehicle Roof", 			["weight"] = 0, 		["type"] = "item", 		["image"] = "roof.png", 				["unique"] = true, 		["useable"] = true, 	["shouldClose"] = true,   ["combinable"] = nil,   ["description"] = ""},
	["spoiler"] 					 = {["name"] = "spoiler", 					["label"] = "Vehicle Spoiler", 			["weight"] = 0, 		["type"] = "item", 		["image"] = "spoiler.png", 				["unique"] = true, 		["useable"] = true, 	["shouldClose"] = true,   ["combinable"] = nil,   ["description"] = ""},
	["bumper"] 						 = {["name"] = "bumper", 					["label"] = "Vehicle Bumper", 			["weight"] = 0, 		["type"] = "item", 		["image"] = "bumper.png", 				["unique"] = true, 		["useable"] = true, 	["shouldClose"] = true,   ["combinable"] = nil,   ["description"] = ""},
	["skirts"] 						 = {["name"] = "skirts", 					["label"] = "Vehicle Skirts", 			["weight"] = 0, 		["type"] = "item", 		["image"] = "skirts.png", 				["unique"] = true, 		["useable"] = true, 	["shouldClose"] = true,   ["combinable"] = nil,   ["description"] = ""},
	["exhaust"] 					 = {["name"] = "exhaust", 					["label"] = "Vehicle Exhaust", 			["weight"] = 0, 		["type"] = "item", 		["image"] = "exhaust.png", 				["unique"] = true, 		["useable"] = true, 	["shouldClose"] = true,   ["combinable"] = nil,   ["description"] = ""},
	["seat"] 						 = {["name"] = "seat", 						["label"] = "Seat Cosmetics", 			["weight"] = 0, 		["type"] = "item", 		["image"] = "seat.png", 				["unique"] = true, 		["useable"] = true, 	["shouldClose"] = true,   ["combinable"] = nil,   ["description"] = ""},

	["rims"] 						 = {["name"] = "rims", 						["label"] = "Custom Wheel Rims", 		["weight"] = 0, 		["type"] = "item", 		["image"] = "rims.png", 				["unique"] = true, 		["useable"] = true, 	["shouldClose"] = true,   ["combinable"] = nil,   ["description"] = ""},
	
	["livery"] 						 = {["name"] = "livery", 					["label"] = "Livery Roll", 				["weight"] = 0, 		["type"] = "item", 		["image"] = "livery.png", 				["unique"] = true, 		["useable"] = true, 	["shouldClose"] = true,   ["combinable"] = nil,   ["description"] = ""},
	["paintcan"] 					 = {["name"] = "paintcan", 					["label"] = "Vehicle Spray Can", 		["weight"] = 0, 		["type"] = "item", 		["image"] = "weapontint_orange.png", 	["unique"] = true, 		["useable"] = true, 	["shouldClose"] = true,   ["combinable"] = nil,   ["description"] = ""},
	["tires"] 						 = {["name"] = "tires", 					["label"] = "Drift Smoke Tires",        ["weight"] = 0, 		["type"] = "item", 		["image"] = "tires.png", 	  		    ["unique"] = true, 		["useable"] = true, 	["shouldClose"] = true,   ["combinable"] = nil,   ["description"] = ""},

	["horn"] 						 = {["name"] = "horn", 						["label"] = "Custom Vehicle Horn", 		["weight"] = 0, 		["type"] = "item", 		["image"] = "horn.png", 				["unique"] = true, 		["useable"] = true, 	["shouldClose"] = true,   ["combinable"] = nil,   ["description"] = ""},

	["internals"] 					 = {["name"] = "internals", 				["label"] = "Internal Cosmetics", 		["weight"] = 0, 		["type"] = "item", 		["image"] = "internals.png", 			["unique"] = true, 		["useable"] = true, 	["shouldClose"] = true,   ["combinable"] = nil,   ["description"] = ""},
	["externals"] 					 = {["name"] = "externals", 				["label"] = "Exterior Cosmetics", 		["weight"] = 0, 		["type"] = "item", 		["image"] = "mirror.png", 				["unique"] = true, 		["useable"] = true, 	["shouldClose"] = true,   ["combinable"] = nil,   ["description"] = ""},
	

- Add the image files from the zip to your qb-inventory > html > images folder

----------------------

- This script requires qb-menu and qb-input for all the menus
- This script requires qb-target for opening stores, crafting tables and cash registers (if you don't want to use these then you can disable/remove them)

- Rims menu can be a bit..weird, but thats unfortunately due to GTA's way of indexing the wheels ID's and Names
	- Custom Rims will most likely be named "NULL" and may now even show on the vehicles
	- Custom Wheel variants for the rims will posibly be named " - Var 1" and " - Var 2" this is due to different wheels just being another version of the rims.

----------------------

There are expanded features included in this scripts with SQL
The included .SQL file needs to be imported into your player_vehicles database to add the appropriate columns (traveldistance, hasnitro, noslevel)

The hasnitro and noslevel columns being added enables the of saving Nitrous levels through server restarts

The traveldistance column adds an Odometer to the toolbox/mechanic_tools menus, this this can retrieved in miles or kilometers.

Adding the sql is completely optional and the script works without them

----------------------

How do I enable extra vehicle damages?

It's easy! It's not enabled by default in QBCore and looks like it hasn't been updated in a while.

Within `qb-vehiclefailure` is commented out exports that enable extra vehicle damage

Search for each instance of `--exports['qb-vehicletuning']`
Remove the `--` and change the name of the export to `['qb-mechanicjob']`

You will need to do 3 times within `qb-vehiclefailure` and then you can restart your server.

When you damage and drive around in your vehicles now, you will have a chance of damaging another component. These numbers go down VERY slowly unless you edit the exports above.

----------------------

How do I create PolyZones for a new job location?

These locations determine where a person will be put on duty or taken off duty, and the places where items can be used, if you set them to be restricted to zones.

To start you need to be near the building you want to add.

Type `/pzcreate poly` to start creating a PolyZone. Pick a name, this doesn't matter as you can set this later in locations.lua
You will then get a red line right where you are standing.

Use your ARROW keys to move this around to the first corner/point you want to place.
When its in the correct place, type `/pzadd` and this will lock the current point and allow you to create another

Repeat this until your last corner/point where you will type `/pzfinish`. 

This will save all the vectors of the points you have chosen and place them in a file called: `polyzone_created_zones.txt`

In this file is the vectors that you need to copy over to my scripts.

----------------------

To add the ability to save RGB paints, their finishes and drift/bulletproof tires you need to change two functions in your qb-core/client/functions.lua

Replace GetVehicleProperties and SetVehicleProperties functions with these:

function QBCore.Functions.GetVehicleProperties(vehicle)
    if DoesEntityExist(vehicle) then
        local colorPrimary, colorSecondary = GetVehicleColours(vehicle)
        local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)
        local extras = {}
		local nilfinish = nil
		local PrimaryFinish = nil
		local SecondaryFinish = nil
		
        if GetIsVehiclePrimaryColourCustom(vehicle) then
            r, g, b = GetVehicleCustomPrimaryColour(vehicle)
			PrimaryFinish, nilfinish = GetVehicleColours(vehicle)
            colorPrimary = { r, g, b, PrimaryFinish }
        end

        if GetIsVehicleSecondaryColourCustom(vehicle) then
            r, g, b = GetVehicleCustomSecondaryColour(vehicle)
			nilfinish, SecondaryFinish = GetVehicleColours(vehicle)
            colorSecondary = { r, g, b, SecondaryFinish }
        end

        for extraId = 0, 12 do
            if DoesExtraExist(vehicle, extraId) then
                local state = IsVehicleExtraTurnedOn(vehicle, extraId) == 1
                extras[tostring(extraId)] = state
            end
        end

        if GetVehicleMod(vehicle, 48) == -1 and GetVehicleLivery(vehicle) ~= 0 then
            modLivery = GetVehicleLivery(vehicle)
        else
            modLivery = GetVehicleMod(vehicle, 48)
        end

        return {
            model = GetEntityModel(vehicle),
            plate = QBCore.Functions.GetPlate(vehicle),
            plateIndex = GetVehicleNumberPlateTextIndex(vehicle),
            bodyHealth = QBCore.Shared.Round(GetVehicleBodyHealth(vehicle), 0.1),
            engineHealth = QBCore.Shared.Round(GetVehicleEngineHealth(vehicle), 0.1),
            tankHealth = QBCore.Shared.Round(GetVehiclePetrolTankHealth(vehicle), 0.1),
            fuelLevel = QBCore.Shared.Round(GetVehicleFuelLevel(vehicle), 0.1),
            dirtLevel = QBCore.Shared.Round(GetVehicleDirtLevel(vehicle), 0.1),
            color1 = colorPrimary,
            color2 = colorSecondary,
            pearlescentColor = pearlescentColor,
            interiorColor = GetVehicleInteriorColor(vehicle),
            dashboardColor = GetVehicleDashboardColour(vehicle),
            wheelColor = wheelColor,
            wheels = GetVehicleWheelType(vehicle),
            windowTint = GetVehicleWindowTint(vehicle),
            xenonColor = GetVehicleXenonLightsColour(vehicle),
            neonEnabled = {
                IsVehicleNeonLightEnabled(vehicle, 0),
                IsVehicleNeonLightEnabled(vehicle, 1),
                IsVehicleNeonLightEnabled(vehicle, 2),
                IsVehicleNeonLightEnabled(vehicle, 3)
            },
            neonColor = table.pack(GetVehicleNeonLightsColour(vehicle)),
            extras = extras,
            tyreSmokeColor = table.pack(GetVehicleTyreSmokeColor(vehicle)),
            modSpoilers = GetVehicleMod(vehicle, 0),
            modFrontBumper = GetVehicleMod(vehicle, 1),
            modRearBumper = GetVehicleMod(vehicle, 2),
            modSideSkirt = GetVehicleMod(vehicle, 3),
            modExhaust = GetVehicleMod(vehicle, 4),
            modFrame = GetVehicleMod(vehicle, 5),
            modGrille = GetVehicleMod(vehicle, 6),
            modHood = GetVehicleMod(vehicle, 7),
            modFender = GetVehicleMod(vehicle, 8),
            modRightFender = GetVehicleMod(vehicle, 9),
            modRoof = GetVehicleMod(vehicle, 10),
            modEngine = GetVehicleMod(vehicle, 11),
            modBrakes = GetVehicleMod(vehicle, 12),
            modTransmission = GetVehicleMod(vehicle, 13),
            modHorns = GetVehicleMod(vehicle, 14),
            modSuspension = GetVehicleMod(vehicle, 15),
            modArmor = GetVehicleMod(vehicle, 16),
            modTurbo = IsToggleModOn(vehicle, 18),
            modSmokeEnabled = IsToggleModOn(vehicle, 20),
            modXenon = IsToggleModOn(vehicle, 22),
            modFrontWheels = GetVehicleMod(vehicle, 23),
            modBackWheels = GetVehicleMod(vehicle, 24),
            modCustomTiresF = GetVehicleModVariation(vehicle, 23),
            modCustomTiresR = GetVehicleModVariation(vehicle, 24),
            modPlateHolder = GetVehicleMod(vehicle, 25),
            modVanityPlate = GetVehicleMod(vehicle, 26),
            modTrimA = GetVehicleMod(vehicle, 27),
            modOrnaments = GetVehicleMod(vehicle, 28),
            modDashboard = GetVehicleMod(vehicle, 29),
            modDial = GetVehicleMod(vehicle, 30),
            modDoorSpeaker = GetVehicleMod(vehicle, 31),
            modSeats = GetVehicleMod(vehicle, 32),
            modSteeringWheel = GetVehicleMod(vehicle, 33),
            modShifterLeavers = GetVehicleMod(vehicle, 34),
            modAPlate = GetVehicleMod(vehicle, 35),
            modSpeakers = GetVehicleMod(vehicle, 36),
            modTrunk = GetVehicleMod(vehicle, 37),
            modHydrolic = GetVehicleMod(vehicle, 38),
            modEngineBlock = GetVehicleMod(vehicle, 39),
            modAirFilter = GetVehicleMod(vehicle, 40),
            modStruts = GetVehicleMod(vehicle, 41),
            modArchCover = GetVehicleMod(vehicle, 42),
            modAerials = GetVehicleMod(vehicle, 43),
            modTrimB = GetVehicleMod(vehicle, 44),
            modTank = GetVehicleMod(vehicle, 45),
            modWindows = GetVehicleMod(vehicle, 46),
            modLivery = modLivery,
			modDrift = GetDriftTyresEnabled(vehicle),
			modBProofTires = GetVehicleTyresCanBurst(vehicle),
        }
    else
        return
    end
end

function QBCore.Functions.SetVehicleProperties(vehicle, props)
    if DoesEntityExist(vehicle) then
        local colorPrimary, colorSecondary = GetVehicleColours(vehicle)
        local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)
        SetVehicleModKit(vehicle, 0)
        if props.plate then SetVehicleNumberPlateText(vehicle, props.plate) end
        if props.plateIndex then SetVehicleNumberPlateTextIndex(vehicle, props.plateIndex) end
        if props.bodyHealth then SetVehicleBodyHealth(vehicle, props.bodyHealth + 0.0) end
        if props.engineHealth then SetVehicleEngineHealth(vehicle, props.engineHealth + 0.0) end
        if props.fuelLevel then SetVehicleFuelLevel(vehicle, props.fuelLevel + 0.0) end
        if props.dirtLevel then SetVehicleDirtLevel(vehicle, props.dirtLevel + 0.0) end
        if props.color1 then 
			if type(props.color1) == "number" then SetVehicleColours(vehicle, props.color1, colorSecondary) else
				SetVehicleCustomPrimaryColour(vehicle, props.color1[1], props.color1[2], props.color1[3])
				SetVehicleColours(vehicle, props.color1[4], colorSecondary)
           end
        end
        if props.color2 then
            if type(props.color2) == "number" then SetVehicleColours(vehicle, props.color1 or colorPrimary, props.color2) else
                SetVehicleCustomSecondaryColour(vehicle, props.color2[1], props.color2[2], props.color2[3])
				colorPrimary, colorSecondary = GetVehicleColours(vehicle)
				SetVehicleColours(vehicle, colorPrimary, props.color2[4])
           end
        end
        if props.pearlescentColor then SetVehicleExtraColours(vehicle, props.pearlescentColor, wheelColor) end
        if props.interiorColor then SetVehicleInteriorColor(vehicle, props.interiorColor) end
        if props.dashboardColor then SetVehicleDashboardColour(vehicle, props.dashboardColor) end
        if props.wheelColor then SetVehicleExtraColours(vehicle, props.pearlescentColor or pearlescentColor, props.wheelColor) end
        if props.wheels then SetVehicleWheelType(vehicle, props.wheels) end
        if props.windowTint then SetVehicleWindowTint(vehicle, props.windowTint) end 
		if props.neonEnabled then
            SetVehicleNeonLightEnabled(vehicle, 0, props.neonEnabled[1])
            SetVehicleNeonLightEnabled(vehicle, 1, props.neonEnabled[2])
            SetVehicleNeonLightEnabled(vehicle, 2, props.neonEnabled[3])
            SetVehicleNeonLightEnabled(vehicle, 3, props.neonEnabled[4])
        end
        if props.extras then for id, enabled in pairs(props.extras) do if enabled then SetVehicleExtra(vehicle, tonumber(id), 0) else SetVehicleExtra(vehicle, tonumber(id), 1) end end end
        if props.neonColor then SetVehicleNeonLightsColour(vehicle, props.neonColor[1], props.neonColor[2], props.neonColor[3]) end
        if props.modSmokeEnabled then ToggleVehicleMod(vehicle, 20, true) end
        if props.tyreSmokeColor then SetVehicleTyreSmokeColor(vehicle, props.tyreSmokeColor[1], props.tyreSmokeColor[2], props.tyreSmokeColor[3]) end
        if props.modSpoilers then SetVehicleMod(vehicle, 0, props.modSpoilers, false) end
        if props.modFrontBumper then SetVehicleMod(vehicle, 1, props.modFrontBumper, false) end
        if props.modRearBumper then SetVehicleMod(vehicle, 2, props.modRearBumper, false) end
        if props.modSideSkirt then SetVehicleMod(vehicle, 3, props.modSideSkirt, false) end
        if props.modExhaust then SetVehicleMod(vehicle, 4, props.modExhaust, false) end
        if props.modFrame then SetVehicleMod(vehicle, 5, props.modFrame, false) end
        if props.modGrille then SetVehicleMod(vehicle, 6, props.modGrille, false) end
        if props.modHood then SetVehicleMod(vehicle, 7, props.modHood, false) end
        if props.modFender then SetVehicleMod(vehicle, 8, props.modFender, false) end
        if props.modRightFender then SetVehicleMod(vehicle, 9, props.modRightFender, false) end
        if props.modRoof then SetVehicleMod(vehicle, 10, props.modRoof, false) end
        if props.modEngine then SetVehicleMod(vehicle, 11, props.modEngine, false) end
        if props.modBrakes then SetVehicleMod(vehicle, 12, props.modBrakes, false) end
        if props.modTransmission then SetVehicleMod(vehicle, 13, props.modTransmission, false) end
        if props.modHorns then SetVehicleMod(vehicle, 14, props.modHorns, false) end
        if props.modSuspension then SetVehicleMod(vehicle, 15, props.modSuspension, false) end
        if props.modArmor then SetVehicleMod(vehicle, 16, props.modArmor, false) end
        if props.modTurbo then ToggleVehicleMod(vehicle, 18, props.modTurbo) end
        if props.modXenon then ToggleVehicleMod(vehicle, 22, props.modXenon) end
        if props.xenonColor then SetVehicleXenonLightsColor(vehicle, props.xenonColor) end
        if props.modFrontWheels then SetVehicleMod(vehicle, 23, props.modFrontWheels, false) end
        if props.modBackWheels then SetVehicleMod(vehicle, 24, props.modBackWheels, false) end
        if props.modCustomTiresF then SetVehicleMod(vehicle, 23, props.modFrontWheels, props.modCustomTiresF) end
        if props.modCustomTiresR then SetVehicleMod(vehicle, 24, props.modBackWheels, props.modCustomTiresR) end
        if props.modPlateHolder then SetVehicleMod(vehicle, 25, props.modPlateHolder, false) end
        if props.modVanityPlate then SetVehicleMod(vehicle, 26, props.modVanityPlate, false) end
        if props.modTrimA then SetVehicleMod(vehicle, 27, props.modTrimA, false) end
        if props.modOrnaments then SetVehicleMod(vehicle, 28, props.modOrnaments, false) end
        if props.modDashboard then SetVehicleMod(vehicle, 29, props.modDashboard, false) end
        if props.modDial then SetVehicleMod(vehicle, 30, props.modDial, false) end
        if props.modDoorSpeaker then SetVehicleMod(vehicle, 31, props.modDoorSpeaker, false) end
        if props.modSeats then SetVehicleMod(vehicle, 32, props.modSeats, false) end
        if props.modSteeringWheel then SetVehicleMod(vehicle, 33, props.modSteeringWheel, false) end
        if props.modShifterLeavers then SetVehicleMod(vehicle, 34, props.modShifterLeavers, false) end
		if props.modAPlate then SetVehicleMod(vehicle, 35, props.modAPlate, false) end
        if props.modSpeakers then SetVehicleMod(vehicle, 36, props.modSpeakers, false) end
        if props.modTrunk then SetVehicleMod(vehicle, 37, props.modTrunk, false) end
        if props.modHydrolic then SetVehicleMod(vehicle, 38, props.modHydrolic, false) end
        if props.modEngineBlock then SetVehicleMod(vehicle, 39, props.modEngineBlock, false) end
        if props.modAirFilter then SetVehicleMod(vehicle, 40, props.modAirFilter, false) end
        if props.modStruts then SetVehicleMod(vehicle, 41, props.modStruts, false) end
        if props.modArchCover then SetVehicleMod(vehicle, 42, props.modArchCover, false) end
        if props.modAerials then SetVehicleMod(vehicle, 43, props.modAerials, false) end
        if props.modTrimB then SetVehicleMod(vehicle, 44, props.modTrimB, false) end
        if props.modTank then SetVehicleMod(vehicle, 45, props.modTank, false) end
        if props.modWindows then SetVehicleMod(vehicle, 46, props.modWindows, false) end
        if props.modLivery then SetVehicleMod(vehicle, 48, props.modLivery, false) SetVehicleLivery(vehicle, props.modLivery) end
		if props.modDrift then SetDriftTyresEnabled(vehicle, true) end	
		SetVehicleTyresCanBurst(vehicle, props.modBProofTires)
    end
end