if SERVER then return end
local mods = require("mods")

function DisableTextPackage(workshopId)
    local targetPackage
    for package in ContentPackageManager.EnabledPackages.All do
        if tostring(package.UgcId) == workshopId then
            targetPackage = package
            break
        end
    end

    if targetPackage == nil then
        print("Could not find package with workshop id ", workshopId)
        return
    end

    for file in targetPackage.Files do
        if LuaUserData.IsTargetType(file, "Barotrauma.TextFile") and string.endsWith(file.Path.Value, "ussian.xml") then
            file.UnloadFile()
            print("Disabled " .. file.Path.Value .. " in package ", workshopId)
            break
        end
    end
end

for _, id in pairs(mods) do
    DisableTextPackage(id)
end

