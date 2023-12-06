Config.PermissionsType = 'job' -- or licence ONLY CAN USE ONE

---@param If Config.PermissionsType = 'job' 
Config.Jobs = {
    'ambulance'
}

---@param If Config.PermissionsType = 'licence' 
Config.WhitelistedCreators = {
    "license:a7f20b53252b5aa3594634afec39ced9e93a0222",
}

function CheckPlayerPermissions(id)
    local havePermissions = false
    if Config.PermissionsType == 'job' then ---@param For job permissions
        for o,p in ipairs(Config.Jobs) do
            print(p, PlayerJob(id))
            if p == PlayerJob(id) then 
                havePermissions = true
                break
            end
        end
    elseif Config.PermissionsType == 'licence' then 
        for o,p in ipairs(Config.WhitelistedCreators) do
            for k,v in ipairs(GetPlayerIdentifiers(id)) do
                if v == p then 
                    havePermissions = true
                    break
                end
            end
        end
    else 
        print('Bad config')
    end
    return havePermissions
end

