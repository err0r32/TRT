IS_ENABLED = Game.GetEnabledContentPackages()
Main = {}
local mods = require("mods")

function Main.GetPackageByName(name)
    for package in ContentPackageManager.EnabledPackages.All do
        if package.Name == name then
            return package
        end
    end

    return nil
end

function Main.GetPackageById(id)
    for package in ContentPackageManager.EnabledPackages.All do
        if tostring(package.UgcId) == id then
            return package
        end
    end
end

Game.AddCommand("relocale", "Reloads all enabled mods.", function()
    local package = Main.GetPackageByName("Total Russian Translation (TRT)")
    if package == nil then
        print("Package not found.")
        return
    end
    ContentPackageManager.EnabledPackages.EnableRegular(package)
    local result = ContentPackageManager.ReloadContentPackage(package)
    if result.IsFailure then
        print(result.Error)
    end
    print("Package reloaded.")
end, GetValidArguments)

Game.AddCommand("relocalemods", "Reloads all enabled mods.", function()
    for _, package in pairs(IS_ENABLED) do
        if package.name == "Total Russian Translation (TRT)" then return end
        print("Reloading all localization files...")
        for _, id in pairs(mods) do
            local package = Main.GetPackageById(id)
            if package == nil then
                print("Package not found.")
                return
            end
            ContentPackageManager.EnabledPackages.EnableRegular(package)
            local result = ContentPackageManager.ReloadContentPackage(package)
            if result.IsFailure then
                print(result.Error)
            end
            print("Package reloaded.")
        end
    end
end, GetValidArguments)



