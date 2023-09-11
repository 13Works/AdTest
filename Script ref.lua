local VirtualUser = VirtualUser
Player.Idled:connect(function()
    VirtualUser:ClickButton2(Vector2.new())
end)

for i, v in pairs(getconnections(Player.Idled)) do
    v:Disable()
end
repeat
    wait()
until Player.PlayerGui:FindFirstChild("PlayButton", true)
RunService.Stepped:Connect(function()
    pcall(function()
        if Player.PlayerGui:FindFirstChild("NewsApp", true).Enabled then
            for i, v in pairs(getconnections(Player.PlayerGui:FindFirstChild("PlayButton", true).MouseButton1Click)) do
                v:Fire()
            end
        end
        if Player.PlayerGui:FindFirstChild("ChooseParent", true) then
            for i, v in pairs(getconnections(Player.PlayerGui:FindFirstChild("ChooseParent", true).MouseButton1Click)) do
                v:Fire()
            end
        end
        if Workspace:FindFirstChild("ServerSidedMapSeats") then
            Workspace.ServerSidedMapSeats:Destroy()
        end
    end)
end)

local Table = {6152116144, 185655149}
local Set = setfpscap
local getupvalue = getupvalue or debug.getupvalue
local getconstant = getconstant or debug.getconstant
local getconstants = getconstants or debug.getconstants
local getgc = getgc or get_gc_objects or debug.getgc
local getreg = getreg or getregistry or debug.getregistry
local get_thread_context = get_thread_context or getthreadcontext or getidentity or syn.get_thread_identity
local get_thread_identity = get_thread_context
local set_thread_context = set_thread_context or setthreadcontext or setidentity or syn.set_thread_identity
local set_thread_identity = set_thread_context
local Remotes = {}
local Inventorys = ReplicatedStorage.ClientDB.Inventory
local InventoryGiftsSubDB = require(Inventorys.InventoryGiftsSubDB)

local Stores = {"CoffeeShop", "Supermarket", "PizzaShop", "ToyShop", "Obbies", "Neighborhood", "CampingShop",
                "AutoShop", "Nursery", "Cave", "IceCream", "PotionShop", "SkyCastle", "Hospital", "HatShop", "PetShop",
                "School", "BabyShop", "HotSpringHouse", "SafetyHub", "DebugInterior", "VIP", "Salon", "SpleefMinigame",
                "SimonSaysMinigame", "WinterCastle"}

local Baths = {"StylishShower", "CheapBathtub", "ModernShower", "Bathtub", "GingerbreadShower", "HotTub"}

local FreeFoods = {"ham_vip", "water_vip", "chocolate_milk_vip", "popcorn_vip", "marshmallow_on_a_stick",
                   "healing_apple", "teachers_apple"}

local Beds = {"FancyPetBed", "ModernPetBed", "CircularPetBed", "RectangularPetBed", "NormalCrib", "BasicCrib",
              "RoyalCrib", "PoshCrib"}
local Tasks = {"hungry", "sleepy", "thirsty", "bored", "dirty", "camping", "sick", "school", "pool_party", "salon",
               "pizza_party"}

local Eggs = {"cracked_egg", "regular_pet_egg", "royal_egg", "retired_egg", "seasia_2023_egg", "mythic_egg",
              "japan_2022_egg", "danger_2023_egg"}

local gifts = {"smallgift", "biggift", "massivegift", "legend_hat_2022_simple_chest", "legend_hat_2022_regal_chest"}
local Obbys = {"miniworld", "coastal_climb", "shipwreck_bay", "ancient_ruins", "lonelypeak", "pyramid", "tinyisles"}

local RetardedBullShit = {"CashRegister", "GoldenCashRegister"}

local PP = {}

local Part = Instance.new("Part")
Part.Name = "P"
Part.Size = Vector3.new(9e9, 0, 9e9)
Part.Anchored = true
Part.Transparency = 0.5
Part.CFrame = CFrame.new(5000, 5000, 5000)
Part.Parent = Workspace
ReplicatedStorage:WaitForChild("ClientModules"):WaitForChild("Core"):WaitForChild("InteriorsM"):WaitForChild(
    "InteriorsM")
local Location = nil
for i, v in pairs(getgc()) do
    if type(v) == "function" then
        if getfenv(v).script == ReplicatedStorage.ClientModules.Core.InteriorsM.InteriorsM then
            if table.find(getconstants(v), "LocationAPI/SetLocation") then
                Location = v
                break
            end
        end
    end
end

local SetLocation = function(A, B, C)
    local O = get_thread_identity()
    set_thread_identity(2)
    Location(A, B, C)
    set_thread_identity(O)
end
local Home = function()
    if Workspace.HouseInteriors.blueprint:FindFirstChildWhichIsA("Model") then
        return Workspace.HouseInteriors.blueprint:FindFirstChildWhichIsA("Model").Name
    else
        return false
    end
end
local PersonHome = function()
    if Workspace.HouseInteriors.blueprint:FindFirstChildWhichIsA("Model") then
        return Workspace.HouseInteriors.blueprint:FindFirstChildWhichIsA("Model").Name
    else
        return false
    end
end
local Store = function()
    if Workspace.Interiors:FindFirstChildWhichIsA("Model") then
        if not string.find(Workspace.Interiors:FindFirstChildWhichIsA("Model").Name, "MainMap") and
            not string.find(Workspace.Interiors:FindFirstChildWhichIsA("Model").Name, "Neighborhood") then
            return Workspace.Interiors:FindFirstChildWhichIsA("Model").Name
        else
            return false
        end
    else
        return false
    end
end

local MainMap = function()
    if Workspace.Interiors:FindFirstChildWhichIsA("Model") then
        if string.find(Workspace.Interiors:FindFirstChildWhichIsA("Model").Name, "MainMap") then
            return Workspace.Interiors:FindFirstChildWhichIsA("Model").Name
        else
            return false
        end
    else
        return false
    end
end

local Neighborhood = function()
    if Workspace.Interiors:FindFirstChildWhichIsA("Model") then
        if string.find(Workspace.Interiors:FindFirstChildWhichIsA("Model").Name, "Neighborhood") then
            return Workspace.Interiors:FindFirstChildWhichIsA("Model").Name
        else
            return false
        end
    else
        return false
    end
end

local GoToStore = function(Name)
    if Store() == Name then
        return true
    end

    SetLocation(Name, "MainDoor", {})

    while Store() ~= Name do
        wait()
    end
    if Home() then
        return true
    end
    return false
end

local GoToHome = function()
    SetLocation("housing", "MainDoor", {
        ["house_owner"] = Player
    })
    while not Home() do
        wait()

    end
    if Home() then

        return true
    end

    return false

end

local GoToNeighborhood = function()
    SetLocation("Neighborhood", "MainDoor", {})
    while not Neighborhood() do
        wait()

    end
    if Neighborhood() then

        return true
    end
    return false
end

local GoToMainMap = function()
    SetLocation("MainMap", "Neighborhood/MainDoor", {})
    while not MainMap() do

        wait()
    end
    if MainMap() then

        return true
    end
    return false
end

local GoToPersonsHouse = function(Name)
    SetLocation("housing", "MainDoor", {
        ["house_owner"] = Players[Name]
    })
    while not PersonHome() do

        wait()
    end
    if PersonHome() then

        return true
    end
    return false
end
local Bed = function(Name)
    GoToHome()
    Player.Character.HumanoidRootPart.CFrame = Workspace.HouseInteriors.blueprint:FindFirstChildWhichIsA('Model')
        :GetModelCFrame():ToWorldSpace(CFrame.new(0, 0, -6))
    for i, v in pairs(Workspace.HouseInteriors.furniture:GetChildren()) do
        if v:FindFirstChildWhichIsA("Model") and (table.find(Beds, v:FindFirstChildWhichIsA("Model").Name)) then
            local String = string.split(v.Name, "/f")[2]
            print(String)
            return "f" .. String
        end
    end
end
local Cash = function()
    for i, v in pairs(Workspace.HouseInteriors.furniture:GetChildren()) do
        if v:FindFirstChildWhichIsA("Model") and (table.find(RetardedBullShit, v:FindFirstChildWhichIsA("Model").Name)) then
            local String = string.split(v.Name, "/f")[2]
            print(String)
            return "f" .. String
        end
    end
end

local Showers = function(Name)
    GoToHome()
    Player.Character.HumanoidRootPart.CFrame = Workspace.HouseInteriors.blueprint:FindFirstChildWhichIsA('Model')
        :GetModelCFrame():ToWorldSpace(CFrame.new(0, 0, -6))
    for i, v in pairs(Workspace.HouseInteriors.furniture:GetChildren()) do
        if v:FindFirstChildWhichIsA("Model") and (table.find(Baths, v:FindFirstChildWhichIsA("Model").Name)) then
            local String = string.split(v.Name, "true/")[2]
            print(String)
            return String
        end
    end
end

local NoCliper = function()
    for i, v in next, Player.Character:GetChildren() do
        if v:IsA("BasePart") then
            v.CanCollide = false
            v.Velocity = Vector3.new(0, 0, 0)
        end
    end
    return Player.Character
end

local Neons = {}
local AilmentFurnitues = {}
local Neon = {}
local Spec = {}
local Key = {}
local PetID
local Pet
local PetsShow = {}
local List = {}
local JoJo = {}
local GGO = {}
for i, v in pairs(require(ReplicatedStorage.ClientModules.Core.ClientData).get_data()[Player.Name].inventory.pets) do
    local key = tostring(v["id"]) .. " - " .. tostring(v["properties"]["age"]) .. " years old"
    if not table.find(List, Key) and v.kind ~= "practice_dog" then
        PetsShow[key] = v
        table.insert(List, key)
        table.sort(List)
    end
end
for i, v in pairs(require(ReplicatedStorage.ClientModules.Core.ClientData).get_data()[Player.Name].inventory.pets) do
    if not table.find(JoJo, tostring(v["id"])) and v.kind ~= "practice_dog" then
        local Key2 = tostring(v["id"])
        GGO[Key2] = v
        table.insert(JoJo, Key2)
        table.sort(JoJo)
    end
end

UserInputService.WindowFocusReleased:Connect(function()
    if Render then
        RunService:Set3dRenderingEnabled(false)
        if table.find(Table, game.PlaceId) then
            Set(30)
        else
            Set(15)
        end
    end
end)
UserInputService.WindowFocused:Connect(function()
    if Render then
        RunService:Set3dRenderingEnabled(true)
        Set(100)
    end
end)

for i, v in pairs(getupvalue(require(ReplicatedStorage.Fsys).load("RouterClient").init, 4)) do
    v.Name = i
end
pcall(function()
    ReplicatedStorage.API:FindFirstChild("DailyLoginAPI/ClaimDailyReward"):InvokeServer()
end)

local a = {
    ["sleepy"] = function(c)
        spawn(function()
            while wait(3) and c.Parent == Player.PlayerGui.AilmentsMonitorApp.Ailments and PetFarm do
                if c.Parent == Player.PlayerGui.AilmentsMonitorApp.Ailments then
                    ReplicatedStorage:FindFirstChild('HousingAPI/ActivateFurniture', true):InvokeServer(Player, Bed(),
                        'UseBlock', {
                            ['cframe'] = Player.Character.HumanoidRootPart.CFrame
                        }, C)
                end
            end
        end)
        repeat
            wait(0)
        until c.Parent ~= Player.PlayerGui.AilmentsMonitorApp.Ailments
    end,
    ['dirty'] = function(c)
        spawn(function()
            while c.Parent == Player.PlayerGui.AilmentsMonitorApp.Ailments and wait(3) do
                ReplicatedStorage:FindFirstChild("HousingAPI/ActivateFurniture", true):InvokeServer(Player, Showers(),
                    'UseBlock', {
                        ['cframe'] = Player.Character.HumanoidRootPart.CFrame
                    }, C)
            end
        end)
        repeat
            wait()
        until c.Parent ~= Player.PlayerGui.AilmentsMonitorApp.Ailments
    end,
    ["hungry"] = function(c)
        ReplicatedStorage:FindFirstChild("ShopAPI/BuyItem", true):InvokeServer('food', 'pizza', {})
        ReplicatedStorage:FindFirstChild("ToolAPI/BakeItem", true):InvokeServer()
        while Player.Character:FindFirstChild('PizzaTool') do
            wait()
        end
        while not Player.Character:FindFirstChild('PizzaTool') do
            wait()
        end
        local Foods = require(ReplicatedStorage.ClientModules.Core.ClientData).get_data()[Player.Name].inventory.food or
                          {}
        local Pizza
        for i, v in pairs(Foods) do
            if v.id == 'pizza' then
                Pizza = v.unique
                break
            end
        end
        if not Pizza then
            return
        end
        wait(2)
        ReplicatedStorage:FindFirstChild("PetObjectAPI/CreatePetObject", true):InvokeServer(
            "__Enum_PetObjectCreatorType_2", {
                ["unique_id"] = Pizza
            })
        ReplicatedStorage:FindFirstChild("PetAPI/ConsumeFoodItem", true):FireServer(Pizza)
        repeat
            wait()
        until c.Parent ~= Player.PlayerGui.AilmentsMonitorApp.Ailments
    end,
    ["thirsty"] = function(c)
        ReplicatedStorage:FindFirstChild("ShopAPI/BuyItem", true):InvokeServer('food', 'tea', {})
        local Foods = require(ReplicatedStorage.ClientModules.Core.ClientData).get_data()[Player.Name].inventory.food or
                          {}
        local Tea
        for i, v in pairs(Foods) do
            if v.id == 'tea' then
                Tea = v.unique
                break
            end
        end
        if not Tea then
            return
        end
        wait(2)
        ReplicatedStorage:FindFirstChild("PetObjectAPI/CreatePetObject", true):InvokeServer(
            "__Enum_PetObjectCreatorType_2", {
                ["unique_id"] = Tea
            })
        ReplicatedStorage:FindFirstChild("PetAPI/ConsumeFoodItem", true):FireServer(Tea)
        repeat
            wait()
        until c.Parent ~= Player.PlayerGui.AilmentsMonitorApp.Ailments
    end,
    ["sick"] = function(c)
        repeat
            wait(0)
            ReplicatedStorage:FindFirstChild("MonitorAPI/HealWithDoctor", true):FireServer()
        until c.Parent ~= Player.PlayerGui.AilmentsMonitorApp.Ailments
    end,
    ["adoption_party"] = function(c)
        GoToStore('Nursery')
        repeat
            wait()
        until c.Parent ~= Player.PlayerGui.AilmentsMonitorApp.Ailments
    end,
    ["school"] = function(c)
        GoToStore('School')
        repeat
            wait()
        until c.Parent ~= Player.PlayerGui.AilmentsMonitorApp.Ailments
    end,
    ["pizza_party"] = function(c)
        GoToStore("PizzaShop")
        repeat
            wait()
        until c.Parent ~= Player.PlayerGui.AilmentsMonitorApp.Ailments
    end,
    ["salon"] = function(c)
        GoToStore("Salon")
        repeat
            wait()
        until c.Parent ~= Player.PlayerGui.AilmentsMonitorApp.Ailments
    end,
    ["pool_party"] = function(c)
        GoToMainMap()
        Player.Character.HumanoidRootPart.CFrame = CFrame.new(
            Workspace.StaticMap.Pool.PoolOrigin.Position + Vector3.new(0, 5, 0))
        repeat
            wait()
        until c.Parent ~= Player.PlayerGui.AilmentsMonitorApp.Ailments
    end,
    ["camping"] = function(c)
        GoToMainMap()
        Player.Character.HumanoidRootPart.CFrame = CFrame.new(
            Workspace.StaticMap.Campsite.CampsiteOrigin.Position + Vector3.new(0, 5, 0))
        repeat
            wait()
        until c.Parent ~= Player.PlayerGui.AilmentsMonitorApp.Ailments
    end,
    ['bored'] = function(c)
        GoToMainMap()
        Player.Character.HumanoidRootPart.CFrame = CFrame.new(
            Workspace.StaticMap.Park.AilmentTarget.Position + Vector3.new(0, 5, 0))
        repeat
            wait()
        until c.Parent ~= Player.PlayerGui.AilmentsMonitorApp.Ailments
    end
}

local repo = 'https://raw.githubusercontent.com/wally-rblx/LinoriaLib/main/'
local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()
local Window = Library:CreateWindow({
    Title = MarketplaceService:GetProductInfo(game.PlaceId).Name,
    Center = true,
    AutoShow = true
})

local Tabs = {
    Main = Window:AddTab('Main'),
    Misc = Window:AddTab("Misc"),
    Events = Window:AddTab("Events"),
    ['UI Settings'] = Window:AddTab('UI Settings')
}

local LeftGroupBox = Tabs.Main:AddLeftGroupbox('AutoFarms')
local LeftGroupBox2 = Tabs.Main:AddLeftGroupbox("Quick Helper")
local RightGroupBox = Tabs.Main:AddRightGroupbox('Quick Misc')
local RightGroupBox2 = Tabs.Main:AddRightGroupbox("Teleports")

local LeftBox = Tabs.Misc:AddLeftGroupbox('Groupbox')
local RightBox = Tabs.Misc:AddRightGroupbox('Groupbox')

local LeftEventGroupBox = Tabs.Events:AddLeftGroupbox('AutoFarms')

local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu')

LeftGroupBox:AddToggle('BabyFarm', {
    Text = 'BabyFarm',
    Default = false,
    Tooltip = '',
    Callback = function(A)
        BabyFarm = A
        spawn(function()
            if BabyFarm then
                ReplicatedStorage.API["TeamAPI/ChooseTeam"]:InvokeServer("Babies", true)
            end
            if not BabyFarm then
                ReplicatedStorage.API["TeamAPI/ChooseTeam"]:InvokeServer("Parents", true)
            end
        end)
        spawn(function()
            while wait(1) and BabyFarm do
                pcall(function()
                    for i, v in pairs(Player.PlayerGui.AilmentsMonitorApp.Ailments:GetChildren()) do
                        if v:IsA("ImageButton") then
                            wait(.1)
                            ReplicatedStorage.API["MonitorAPI/AddAdditive"]:FireServer(v.Name, math.random(1, 100))
                        end
                    end
                end)
            end
        end)
    end
})
Toggles.BabyFarm:OnChanged(function(State)
    BabyFarm = Toggles.BabyFarm.Value
end)

LeftBox:AddToggle('AutoInvis', {
    Text = 'Auto Invis',
    Default = false,
    Tooltip = '',
    Callback = function(A)
        Invis = A
        spawn(function()
            while Invis do
                wait()
                pcall(function()
                    if Player.Character:FindFirstChild("LowerTorso") then
                        Player.Character:FindFirstChild("LowerTorso"):FindFirstChild("Root"):Destroy()
                    end
                end)
            end
        end)
    end
})
Toggles.AutoInvis:OnChanged(function(State)
    Invis = Toggles.AutoInvis.Value
end)

LeftBox:AddToggle('CPU', {
    Text = 'CPU Usage Improver',
    Default = false,
    Tooltip = '',
    Callback = function(A)
        Render = A
    end
})
Toggles.CPU:OnChanged(function(State)
    Render = Toggles.CPU.Value
end)

LeftBox:AddToggle('Hide', {
    Text = 'Low Render',
    Default = false,
    Tooltip = '',
    Callback = function(A)
        for i, v in next, Workspace.Interiors:GetDescendants() do
            if v:IsA("BasePart") and Hide then
                v.Transparency = 1
            end
        end

        Workspace.Interiors.DescendantAdded:Connect(function(v)
            if v:IsA('BasePart') and Hide then
                v.Transparency = 1
            end
        end)
    end
})
Toggles.Hide:OnChanged(function()
    Hide = Toggles.Hide.Value
end)

LeftBox:AddToggle('Crash', {
    Text = 'Crash Server',
    Default = false,
    Tooltip = '',
    Callback = function(A)
        Crash = A
        RunService.RenderStepped:Connect(function()
            if Crash then
                for i = 1, 50 do
                    ReplicatedStorage.API["TeamAPI/ChooseTeam"]:InvokeServer("Babies", true)
                end
            end
        end)
    end
})
Toggles.Crash:OnChanged(function(State)
    Crash = Toggles.Crash.Value
end)

LeftGroupBox:AddToggle('FK', {
    Text = 'Auto Claim Quest',
    Default = false,
    Tooltip = '',
    Callback = function(A)
        spawn(function()
            while wait() and FK do
                pcall(function()
                    ReplicatedStorage.API:FindFirstChild("QuestAPI/ClaimQuest"):InvokeServer(tostring(Player.PlayerGui
                                                                                                          .QuestApp
                                                                                                          .Board.Body
                                                                                                          .Contents
                                                                                                          .ScrollingFrame
                                                                                                          .QuestTemplate
                                                                                                          .Body:GetAttribute(
                        "QuestId")))
                end)
            end
        end)
    end
})
Toggles.FK:OnChanged(function(State)
    FK = Toggles.FK.Value
end)

LeftGroupBox:AddToggle('Neon', {
    Text = 'Auto Neon',
    Default = false,
    Tooltip = '',
    Callback = function(A)
        spawn(function()
            while Neon and wait() do
                pcall(function()
                    local N = 0
                    for i, v in pairs(require(ReplicatedStorage.ClientModules.Core.ClientData).get_data()[Player.Name]
                                          .inventory.pets) do
                        local Old = v.id
                        if string.find(Old, v.id) and v.properties.age == 6 then
                            N = N + 1
                            table.insert(Neons, v.unique)
                            if N == 4 then
                                ReplicatedStorage.API:FindFirstChild("PetAPI/DoNeonFusion")
                                    :InvokeServer({unpack(Neons)})
                                table.clear(Neons)
                                N = 0
                            end
                        end
                    end
                end)
            end
        end)
    end
})
Toggles.Neon:OnChanged(function(State)
    Neon = Toggles.Neon.Value
end)

LeftGroupBox:AddDropdown('Pets', {
    Values = List,
    Default = 1,
    Multi = false,
    Text = 'Pets',
    Tooltip = '',
    Callback = function(A)
        Key = PetsShow[A]
    end
})

Options.Pets:OnChanged(function()
    Key = PetsShow[Options.Pets.Value]
end)

LeftGroupBox:AddToggle('Pet', {
    Text = 'PetFarm',
    Default = false,
    Tooltip = '',
    Callback = function(A)
        RunService.RenderStepped:connect(function()
            if PetFarm then
                pcall(function()
                    Workspace["P"].CFrame = Player.Character.HumanoidRootPart.CFrame * CFrame.new(Vector3.new(0, -5, 0))
                    NoCliper()
                end)
            end
        end)
        spawn(function()
            while wait(20) and PetFarm and Refresh do
                pcall(function()
                    ReplicatedStorage.API["ToolAPI/Unequip"]:InvokeServer(PetID)
                    Pet = ReplicatedStorage.API["ToolAPI/Equip"]:InvokeServer(PetID)
                end)
            end
        end)
        if Key ~= nil then
            PetID = Key.unique
            ReplicatedStorage.API["ToolAPI/Unequip"]:InvokeServer(PetID)
            Pet, C = ReplicatedStorage.API["ToolAPI/Equip"]:InvokeServer(PetID)
        end
        spawn(function()
            while wait() and PetFarm do
                pcall(function()
                    local Ailment = Player.PlayerGui.AilmentsMonitorApp.Ailments:FindFirstChildWhichIsA("Frame")
                    if Ailment then
                        local Name = Ailment.Name
                        if a[Name] then
                            a[Name](Ailment)
                        end
                    end
                    if Pet and C then
                        if C.Parent ~= Workspace.Pets then
                            ReplicatedStorage.API["ToolAPI/Unequip"]:InvokeServer(PetID)
                            Pet, C = ReplicatedStorage.API["ToolAPI/Equip"]:InvokeServer(PetID)
                        end
                    else
                        ReplicatedStorage.API["ToolAPI/Unequip"]:InvokeServer(PetID)
                        Pet, C = ReplicatedStorage.API["ToolAPI/Equip"]:InvokeServer(PetID)
                    end
                end)
            end
        end)
    end
})
Toggles.Pet:OnChanged(function(State)
    PetFarm = Toggles.Pet.Value
end)

LeftGroupBox:AddToggle('SwitchOut', {
    Text = 'SwitchOutFullyGrown',
    Default = false,
    Tooltip = '',
    Callback = function(A)
        SwitchOutFullyGrown = A
        spawn(function()
            while SwitchOutFullyGrown and wait() do
                pcall(function()
                    local Pets = require(ReplicatedStorage.ClientModules.Core.ClientData).get_data()[Player.Name]
                                     .inventory.pets or {}
                    if Pets[PetID] and Pets[PetID]["properties"]["age"] == 6 then
                        print(Pets[PetID]["properties"]["age"])
                        for i, v in pairs(Pets) do
                            if v["properties"]["age"] ~= 6 then
                                PetID = v.unique
                            end
                        end
                    end
                end)
            end
        end)
    end
})
Toggles.SwitchOut:OnChanged(function(State)
    SwitchOutFullyGrown = Toggles.SwitchOut.Value
end)

LeftGroupBox:AddToggle('SwitchOutEgg', {
    Text = 'SwitchOutEgg',
    Default = false,
    Tooltip = '',
    Callback = function(A)
        SwitchOutEgg = A
        spawn(function()
            while SwitchOutEgg and wait() do
                pcall(function()
                    local Pets = require(ReplicatedStorage.ClientModules.Core.ClientData).get_data()[Player.Name]
                                     .inventory.pets or {}
                    if not Pets[PetID]["id"]:match("egg") and not Pets[PetID]["id"]:match("basic_egg") then
                        for i, v in pairs(Pets) do
                            if v["id"]:match("egg") and not v["id"]:match("basic_egg") then
                                PetID = v.unique
                            end
                        end
                    end
                end)
            end
        end)
    end
})
Toggles.SwitchOutEgg:OnChanged(function(State)
    SwitchOutEgg = Toggles.SwitchOutEgg.Value
end)

LeftGroupBox:AddToggle('Species', {
    Text = 'Switch Out Pet Species',
    Default = false,
    Tooltip = '',
    Callback = function(A)
        True = A
        spawn(function()
            while True and wait() do
                pcall(function()
                    local Pets = require(ReplicatedStorage.ClientModules.Core.ClientData).get_data()[Player.Name]
                                     .inventory.pets or {}
                    if v["id"] ~= sp or v["properties"]["age"] == 6 then
                        for i, v in pairs(Pets) do
                            if v["id"] == sp and v["properties"]["age"] ~= 6 then
                                PetID = v.unique
                            end
                        end
                    end
                end)
            end
        end)
    end
})
Toggles.Species:OnChanged(function(State)
    True = Toggles.Species.Value
end)

LeftGroupBox:AddDropdown('tg55', {
    Values = JoJo,
    Default = 1,
    Multi = false,
    Text = 'Pet Species',
    Tooltip = '',
    Callback = function(A)
        sp = A
    end
})

Options.tg55:OnChanged(function()
    sp = Options.tg55.Value
end)

LeftGroupBox:AddToggle('fffgg', {
    Text = 'Auto use Grow Potions',
    Default = false,
    Tooltip = '',
    Callback = function(A)
        Grow = A
        spawn(function()
            while Grow and wait() do
                pcall(function()
                    local Foods = require(ReplicatedStorage.ClientModules.Core.ClientData).get_data()[Player.Name]
                                      .inventory.food or {}
                    local Tea
                    for i, v in pairs(Foods) do
                        if v.kind == "pet_age_potion" then
                            Tea = v.unique
                            break
                        end
                    end
                    if not Tea then
                        return
                    end
                    wait(2)
                    local Pets = require(ReplicatedStorage.ClientModules.Core.ClientData).get_data()[Player.Name]
                                     .inventory.pets or {}
                    for i, v in next, Pets do
                        if v.kind == Petsc and v["properties"]["age"] ~= 6 then
                            PetID = v.unique
                            ReplicatedStorage.API["ToolAPI/Unequip"]:InvokeServer(PetID)
                            ReplicatedStorage.API["ToolAPI/Equip"]:InvokeServer(PetID)
                        end
                    end
                    ReplicatedStorage:FindFirstChild("PetObjectAPI/CreatePetObject", true):InvokeServer(
                        "__Enum_PetObjectCreatorType_2", {
                            ["unique_id"] = Tea
                        })
                    ReplicatedStorage:FindFirstChild("PetAPI/ConsumeFoodItem", true):FireServer(Tea)
                end)
            end
        end)
    end
})

Toggles.fffgg:OnChanged(function(State)
    Grow = Toggles.fffgg.Value
end)

LeftGroupBox:AddDropdown('rrt5', {
    Values = List,
    Default = 1,
    Multi = false,
    Text = 'Pets',
    Tooltip = '',
    Callback = function(A)
        Petsc = A
    end
})

Options.rrt5:OnChanged(function()
    Petsc = Options.rrt5.Value
end)

LeftGroupBox:AddToggle('Heal', {
    Text = 'Heal Others',
    Default = false,
    Tooltip = '',
    Callback = function(A)
        HealOthers = A
        spawn(function()
            while HealOthers and wait(2) do
                ReplicatedStorage.API["MonitorAPI/HealWithDoctor"]:FireServer()
            end
        end)
    end
})
Toggles.Heal:OnChanged(function(State)
    HealOthers = Toggles.Heal.Value
end)

RightGroupBox:AddToggle('Family', {
    Text = 'No Baby Pick Up',
    Default = false,
    Tooltip = '',
    Callback = function(A)
        if Family then
            ReplicatedStorage.API["FamilyAPI/CreateFamily"]:InvokeServer()
        elseif not Family then
            ReplicatedStorage.API["FamilyAPI/LeaveFamily"]:InvokeServer()
        end
    end
})
Toggles.Family:OnChanged(function(State)
    Family = Toggles.Family.Value
end)

LeftBox:AddToggle('FWdsd', {
    Text = 'Auto Buy Eggs',
    Default = false,
    Tooltip = '',
    Callback = function(A)
        Loll = A
        spawn(function()
            while Loll and wait() do
                pcall(function()
                    wait(1)
                    ReplicatedStorage.API["ShopAPI/BuyItem"]:InvokeServer("pets", Egg, {})
                end)
            end
        end)
    end
})
Toggles.FWdsd:OnChanged(function(State)
    Loll = Toggles.FWdsd.Value
end)
LeftBox:AddToggle('FWdsd2', {
    Text = 'Auto Buy Gifts',
    Default = false,
    Tooltip = '',
    Callback = function(A)
        Loll = A
        spawn(function()
            while Loll and wait() do
                pcall(function()
                    wait(1)
                    ReplicatedStorage.API["ShopAPI/BuyItem"]:InvokeServer("gifts", Gifts, {})
                end)
            end
        end)
    end
})
Toggles.FWdsd2:OnChanged(function(State)
    Loll = Toggles.FWdsd2.Value
end)

LeftBox:AddToggle('FW44dsd', {
    Text = 'Auto Open Gifts',
    Default = false,
    Tooltip = '',
    Callback = function(A)
        System = A
        spawn(function()
            while System do
                wait(2)
                local gifts = require(ReplicatedStorage.ClientModules.Core.ClientData).get_data()[Player.Name].inventory
                                  .gifts or {}
                local GiftTable
                local GiftID
                local Gift

                for i, v in pairs(gifts) do
                    Gift = v.unique

                    pcall(function()
                        ReplicatedStorage.API["ToolAPI/Equip"]:InvokeServer(Gift)
                        ReplicatedStorage.API:FindFirstChild("ShopAPI/OpenGift"):InvokeServer(Gift)
                    end)
                end
            end
        end)
    end
})
Toggles.FW44dsd:OnChanged(function(State)
    System = Toggles.FW44dsd.Value
end)

LeftBox:AddDropdown('Eggs', {
    Values = Eggs,
    Default = 1,
    Multi = false,
    Text = 'Eggs',
    Tooltip = '',
    Callback = function(A)
        Egg = A
    end
})

Options.Eggs:OnChanged(function()
    Egg = Options.Eggs.Value
end)

LeftBox:AddDropdown('Gifts', {
    Values = gifts,
    Default = 1,
    Multi = false,
    Text = 'Gifts',
    Tooltip = '',
    Callback = function(A)
        Gifts = A
    end
})

Options.Gifts:OnChanged(function()
    Gifts = Options.Gifts.Value
end)

LeftGroupBox2:AddToggle('Trade', {
    Text = 'Auto Accept Trade"',
    Default = false,
    Tooltip = '',
    Callback = function(A)
        Trade = A
        spawn(function()
            while Trade do
                wait()
                pcall(function()
                    for i, v in pairs(Players:GetPlayers()) do
                        if v ~= Player then
                            ReplicatedStorage.API:FindFirstChild("TradeAPI/AcceptOrDeclineTradeRequest"):InvokeServer(v,
                                true)
                        end
                    end
                    ReplicatedStorage.API:FindFirstChild("TradeAPI/AcceptNegotiation"):FireServer()
                    ReplicatedStorage.API:FindFirstChild("TradeAPI/ConfirmTrade"):FireServer()
                    for i, v in pairs(getconnections(Player.PlayerGui.DialogApp.Dialog.NormalDialog.Buttons
                                                         .ButtonTemplate.MouseButton1Click)) do
                        v.Function()
                        v:Fire()
                    end
                end)
            end
        end)
    end
})
Toggles.Trade:OnChanged(function(State)
    Trade = Toggles.Trade.Value
end)

LeftGroupBox2:AddToggle('Buy', {
    Text = 'AutoBuy From Player"',
    Default = false,
    Tooltip = '',
    Callback = function(A)
        Buy = A
        spawn(function()
            while wait() and Buy do
                pcall(function()
                    ReplicatedStorage.API:FindFirstChild("RefreshmentStandAPI/BuyRefreshment"):InvokeServer(
                        "hotdog_stand", Playt)
                    ReplicatedStorage.API:FindFirstChild("RefreshmentStandAPI/BuyRefreshment"):InvokeServer(
                        "lemonade_stand", Playt)
                    for i, v in pairs(getconnections(Player.PlayerGui.DialogApp.Dialog.NormalDialog.Buttons
                                                         .ButtonTemplate.MouseButton1Click)) do
                        v.Function()
                        v:Fire()
                    end
                end)
            end
        end)
    end
})
Toggles.Buy:OnChanged(function(State)
    Buy = Toggles.Buy.Value
end)
LeftGroupBox2:AddToggle('Transfer', {
    Text = 'Transfer Money To Said Player"',
    Default = false,
    Tooltip = '',
    Callback = function(A)
        Sus = A
        spawn(function()
            while wait() and Sus do
                pcall(function()
                    local Is
                    if not Is then
                        GoToPersonsHouse(tostring(Playt))
                        Player.Character.HumanoidRootPart.CFrame =
                            Workspace.HouseInteriors.blueprint:FindFirstChildWhichIsA('Model'):GetModelCFrame()
                                :ToWorldSpace(CFrame.new(0, 0, -6))
                        wait(2)
                        Is = Cash()
                    end
                    if Is then
                        ReplicatedStorage.API:FindFirstChild("HousingAPI/ActivateFurniture"):InvokeServer(Playt, Cash(),
                            "UseBlock", 50, Player.Character)
                        for i, v in pairs(getconnections(Player.PlayerGui.DialogApp.Dialog.NormalDialog.Buttons
                                                             .ButtonTemplate.MouseButton1Click)) do
                            v.Function()
                            v:Fire()
                        end
                    end
                end)
            end
        end)
    end
})
Toggles.Transfer:OnChanged(function(State)
    Sus = Toggles.Transfer.Value
end)

LeftGroupBox2:AddToggle('TransferPet', {
    Text = 'Transfer Pets To Said Player"',
    Default = false,
    Tooltip = '',
    Callback = function(A)
        TransferPet = A
        spawn(function()
            while TransferPet and wait(1) do
                pcall(function()
                    if not Player.PlayerGui.TradeApp.Frame.Visible then
                        ReplicatedStorage.API:FindFirstChild("TradeAPI/SendTradeRequest"):FireServer(Playt)
                    end
                    if Player.PlayerGui.TradeApp.Frame.Visible then
                        if Petsd == "Pets" then
                            for i, v in pairs(
                                require(ReplicatedStorage.ClientModules.Core.ClientData).get_data()[Player.Name]
                                    .inventory.pets) do
                                ReplicatedStorage.API:FindFirstChild("TradeAPI/AddItemToOffer"):FireServer(v.unique)
                            end
                        end
                        if Petsd == "GrownPets" then
                            for i, v in pairs(
                                require(ReplicatedStorage.ClientModules.Core.ClientData).get_data()[Player.Name]
                                    .inventory.pets) do
                                if v["properties"]["age"] == 6 then
                                    ReplicatedStorage.API:FindFirstChild("TradeAPI/AddItemToOffer"):FireServer(v.unique)
                                end
                            end
                        end
                        if Petsd == "Eggs" then
                            for i, v in pairs(
                                require(ReplicatedStorage.ClientModules.Core.ClientData).get_data()[Player.Name]
                                    .inventory.pets) do
                                if v["id"]:find("egg") and not v["id"]:find("_2022") then
                                    ReplicatedStorage.API:FindFirstChild("TradeAPI/AddItemToOffer"):FireServer(v.unique)
                                end
                            end
                        end
                        if Petsd == "Gifts" then
                            for i, v in pairs(
                                require(ReplicatedStorage.ClientModules.Core.ClientData).get_data()[Player.Name]
                                    .inventory.gifts) do
                                ReplicatedStorage.API:FindFirstChild("TradeAPI/AddItemToOffer"):FireServer(v.unique)
                            end
                        end
                        ReplicatedStorage.API:FindFirstChild("TradeAPI/AcceptNegotiation"):FireServer()
                        ReplicatedStorage.API:FindFirstChild("TradeAPI/ConfirmTrade"):FireServer()
                        for i, v in pairs(getconnections(Player.PlayerGui.DialogApp.Dialog.NormalDialog.Buttons
                                                             .ButtonTemplate.MouseButton1Click)) do
                            v.Function()
                            v:Fire()
                        end
                    end
                end)
            end
        end)
    end
})
Toggles.TransferPet:OnChanged(function(State)
    TransferPet = Toggles.TransferPet.Value
end)

LeftGroupBox2:AddInput('NFt', {
    Default = 'UserName',
    Numeric = false,
    Finished = false,
    Text = 'Select Player',
    Tooltip = nil,
    Placeholder = 'Select Player'
})
Options.NFt:OnChanged(function(String)
    for i, v in pairs(Players:GetPlayers()) do
        if v.Name == (String) or v.Name:find(String) or v.DisplayName == String or v.DisplayName:find(String) then
            Playt = v
        end
    end
end)

LeftGroupBox2:AddDropdown('Method', {
    Values = {"Pets", "Gifts", "GrownPets", "Eggs"},
    Default = 1,
    Multi = false,
    Text = 'Transfer Items',
    Tooltip = '',
    Callback = function(A)
        Petsd = A
    end
})

Options.Method:OnChanged(function()
    Petsd = Options.Method.Value
end)

LeftBox:AddButton('Grab Trading Linence', function()
    ReplicatedStorage.API:FindFirstChild("TradeAPI/BeginQuiz"):FireServer()
    for i, v in pairs(getgc(true)) do
        if type(v) == "table" and rawget(v, "question_index") then
            for i, v in pairs(v.quiz) do
                ReplicatedStorage.API:FindFirstChild("TradeAPI/AnswerQuizQuestion"):FireServer(v.answer)
            end
        end
    end
end)

LeftBox:AddButton('Give Badges', function()
    for i, v in pairs(Obbys) do
        wait(0.5)
        ReplicatedStorage.API["MinigameAPI/FinishObby"]:FireServer(v)
    end
end)

RightGroupBox2:AddInput('NFt', {
    Default = 'UserName',
    Numeric = false,
    Finished = false,
    Text = 'Select Player',
    Tooltip = nil,
    Placeholder = 'Select Player'
})
Options.NFt:OnChanged(function(String)
    for i, v in pairs(Players:GetPlayers()) do
        if v.Name == (String) or v.Name:find(String) or v.DisplayName == String or v.DisplayName:find(String) then
            GoToPersonsHouse(v.Name)
            Player.Character.HumanoidRootPart.CFrame =
                Workspace.HouseInteriors.blueprint:FindFirstChildWhichIsA('Model'):GetModelCFrame()
                    :ToWorldSpace(CFrame.new(0, 0, -6))
        end
    end
end)

RightGroupBox2:AddDropdown('Stores', {
    Values = Stores,
    Default = 0,
    Multi = false,
    Text = 'Locations',
    Tooltip = '',
    Callback = function(A)
        pcall(function()
            GoToStore(A)
            Player.Character.HumanoidRootPart.CFrame = Workspace.Interiors:FindFirstChildWhichIsA('Model').Doors
                                                           .MainDoor.WorkingParts.TouchToEnter.CFrame:ToWorldSpace(
                CFrame.new(0, 0, -6))
        end)
    end
})

Options.Stores:OnChanged(function()
    pcall(function()
        GoToStore(Options.Stores.Value)
        Player.Character.HumanoidRootPart.CFrame = Workspace.Interiors:FindFirstChildWhichIsA('Model').Doors.MainDoor
                                                       .WorkingParts.TouchToEnter.CFrame:ToWorldSpace(
            CFrame.new(0, 0, -6))
    end)
end)

local Button = RightGroupBox2:AddButton('Teleport Home', function()
    GoToHome()
    Player.Character.HumanoidRootPart.CFrame = Workspace.HouseInteriors.blueprint:FindFirstChildWhichIsA('Model')
        :GetModelCFrame():ToWorldSpace(CFrame.new(0, 0, -6))
end)

local Button2 = Button:AddButton('Teleport MainMap', function()
    GoToMainMap()
    Player.Character.HumanoidRootPart.CFrame = Workspace.Interiors:FindFirstChildWhichIsA("Model"):GetModelCFrame()
        :ToWorldSpace(CFrame.new(0, 0, -6))
    Player.Character.HumanoidRootPart.CFrame = CFrame.new(-247.35408, 17.3820152, -1518.88879)
end)

LeftBox:AddToggle('JoYes', {
    Text = 'Auto Free Food"',
    Default = false,
    Tooltip = '',
    Callback = function(A)
        JoYes = Toggles.JoYes.Value
        spawn(function()
            while JoYes and wait() do
                pcall(function()
                    ReplicatedStorage.API["ShopAPI/BuyItem"]:InvokeServer("food", Food, {})
                end)
            end
        end)
    end
})
Toggles.JoYes:OnChanged(function(State)
    JoYes = Toggles.JoYes.Value
end)

LeftBox:AddDropdown('Foods', {
    Values = FreeFoods,
    Default = 0,
    Multi = false,
    Text = 'Free Foods',
    Tooltip = '',
    Callback = function(A)
        Food = A
    end
})

Options.Foods:OnChanged(function()
    Food = Options.Foods.Value
end)

local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/1201for/V.G-Hub/main/Karrot-Esp"))()
RightGroupBox:AddToggle('ESP1', {
    Text = 'Esp Toggle',
    Default = false,
    Tooltip = '',
    Callback = function(A)
        ESP:Toggle(A)
    end
})
Toggles.ESP1:OnChanged(function(State)
    ESP:Toggle(Toggles.ESP1.Value)
end)

RightGroupBox:AddToggle('ESP2', {
    Text = 'Esp Players',
    Default = false,
    Tooltip = '',
    Callback = function(A)
        ESP.Players = A
    end
})
Toggles.ESP2:OnChanged(function(State)
    ESP.Players = Toggles.ESP2.Value
end)

RightGroupBox:AddToggle('ESP3', {
    Text = 'Esp Tracers',
    Default = false,
    Tooltip = '',
    Callback = function(A)
        ESP.Tracers = A
    end
})
Toggles.ESP3:OnChanged(function(State)
    ESP.Tracers = Toggles.ESP3.Value
end)

RightGroupBox:AddToggle('ESP4', {
    Text = 'Esp Names',
    Default = false,
    Tooltip = '',
    Callback = function(A)
        ESP.EspNames = A
    end
})
Toggles.ESP4:OnChanged(function(State)
    ESP.EspNames = Toggles.ESP4.Value
end)

RightGroupBox:AddToggle('ESP5', {
    Text = 'Esp Boxes',
    Default = false,
    Tooltip = '',
    Callback = function(A)
        ESP.Boxes = A
    end
})
Toggles.ESP5:OnChanged(function(State)
    ESP.Boxes = Toggles.ESP5.Value
end)

RightGroupBox:AddToggle('SSS', {
    Text = 'WalkSpeed Toggle',
    Default = false,
    Tooltip = '',
    Callback = function(A)
        WS = A
        RunService.Stepped:Connect(function()
            if WS then
                pcall(function()
                    Player.Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = WalkSpeed or 16
                end)
            end
        end)
    end
})
Toggles.SSS:OnChanged(function(State)
    Foe = Toggles.SSS.Value
end)
RightGroupBox:AddInput('SSF3', {
    Default = 'WalkSpeed',
    Numeric = true,
    Finished = false,
    Text = 'WalkSpeed',
    Tooltip = 'Numbers Only',
    Placeholder = 'WalkSpeed'
})
Options.SSF3:OnChanged(function(State)
    WalkSpeed = Options.SSF3.Value
end)

RightGroupBox:AddToggle('EEE', {
    Text = 'JumpPower Toggle',
    Default = false,
    Tooltip = '',
    Callback = function(A)
        JP = A
        RunService.Stepped:Connect(function()
            if JP then
                pcall(function()
                    local H = Player.Character:FindFirstChildWhichIsA("Humanoid")
                    if H.UseJumpPower then
                        H.JumpPower = JumpPower or 50
                    else
                        H.JumpHeight = JumpPower or 50
                    end
                end)
            end
        end)
    end
})
Toggles.EEE:OnChanged(function(State)
    JP = Toggles.EEE.Value
end)
RightGroupBox:AddInput('SSF1', {
    Default = 'JumpPower',
    Numeric = true,
    Finished = false,
    Text = 'JumpPower',
    Tooltip = 'Numbers Only',
    Placeholder = 'JumpPower'
})

Options.SSF1:OnChanged(function(State)
    JumpPower = Options.SSF1.Value
end)

RightGroupBox:AddToggle('vvS', {
    Text = 'Infinite Jump',
    Default = InfiniteJump,
    Tooltip = '',
    Callback = function(A)
        InfiniteJump = A
        UserInputService.JumpRequest:connect(function()
            if InfiniteJump then
                Player.Character:FindFirstChildWhichIsA("Humanoid"):ChangeState("Jumping")
            end
        end)
    end
})

Toggles.vvS:OnChanged(function()
    InfiniteJump = Toggles.vvS.Value
end)

RightGroupBox:AddToggle('eeS', {
    Text = 'NoClip',
    Default = Sex2,
    Tooltip = '',
    Callback = function(A)
        noclips = A
        RunService.Stepped:connect(function(v)
            if noclips then
                pcall(function()
                    NoClip2(Player.Character)
                end)
            end
        end)
    end
})
Toggles.eeS:OnChanged(function()
    noclips = Toggles.eeS.Value
end)

RightGroupBox:AddToggle('aaS', {
    Text = 'H Fly',
    Default = Sex,
    Tooltip = 'Fly By Pressing H',
    Callback = function(A)
        Sex = A
        local Max = 0
        local LP = Players.LocalPlayer
        local Mouse = LP:GetMouse()
        Mouse.KeyDown:connect(function(k)
            if k:lower() == "h" and Sex then
                Max = Max + 1
                getgenv().Fly = false
                if Sex then
                    local T = LP.Character:FindFirstChild("UpperTorso", true) or
                                  LP.Character:FindFirstChild("HumanoidRootPart", true)
                    local S = {
                        F = 0,
                        B = 0,
                        L = 0,
                        R = 0
                    }
                    local S2 = {
                        F = 0,
                        B = 0,
                        L = 0,
                        R = 0
                    }
                    local SPEED = 5
                    local function FLY()
                        getgenv().Fly = true
                        local BodyGyro = Instance.new("BodyGyro", T)
                        local BodyVelocity = Instance.new("BodyVelocity", T)
                        BodyGyro.P = 9e4
                        BodyGyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
                        BodyGyro.cframe = T.CFrame
                        BodyVelocity.velocity = Vector3.new(0, 0, 0)
                        BodyVelocity.maxForce = Vector3.new(9e9, 9e9, 9e9)
                        spawn(function()
                            repeat
                                wait()
                                LP.Character.Humanoid.PlatformStand = true
                                if S.L + S.R ~= 0 or S.F + S.B ~= 0 then
                                    SPEED = 500
                                elseif not (S.L + S.R ~= 0 or S.F + S.B ~= 0) and SPEED ~= 0 then
                                    SPEED = 0
                                end
                                if (S.L + S.R) ~= 0 or (S.F + S.B) ~= 0 then
                                    BodyVelocity.velocity = ((Workspace.CurrentCamera.CoordinateFrame.lookVector *
                                                                (S.F + S.B)) +
                                                                ((Workspace.CurrentCamera.CoordinateFrame *
                                                                    CFrame.new(S.L + S.R, (S.F + S.B) * 0.2, 0).p) -
                                                                    Workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
                                    S2 = {
                                        F = S.F,
                                        B = S.B,
                                        L = S.L,
                                        R = S.R
                                    }
                                elseif (S.L + S.R) == 0 and (S.F + S.B) == 0 and SPEED ~= 0 then
                                    BodyVelocity.velocity = ((Workspace.CurrentCamera.CoordinateFrame.lookVector *
                                                                (S2.F + S2.B)) +
                                                                ((Workspace.CurrentCamera.CoordinateFrame *
                                                                    CFrame.new(S2.L + S2.R, (S2.F + S2.B) * 0.2, 0).p) -
                                                                    Workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
                                else
                                    BodyVelocity.velocity = Vector3.new(0, 0.1, 0)
                                end
                                BodyGyro.cframe = Workspace.CurrentCamera.CoordinateFrame
                            until not getgenv().Fly
                            S = {
                                F = 0,
                                B = 0,
                                L = 0,
                                R = 0
                            }
                            S2 = {
                                F = 0,
                                B = 0,
                                L = 0,
                                R = 0
                            }
                            SPEED = 0
                            BodyGyro:destroy()
                            BodyVelocity:destroy()
                            LP.Character.Humanoid.PlatformStand = false
                        end)
                    end
                    Mouse.KeyDown:connect(function(k)
                        if k:lower() == "w" then
                            S.F = 1
                        elseif k:lower() == "s" then
                            S.B = -1
                        elseif k:lower() == "a" then
                            S.L = -1
                        elseif k:lower() == "d" then
                            S.R = 1
                        end
                    end)
                    Mouse.KeyUp:connect(function(k)
                        if k:lower() == "w" then
                            S.F = 0
                        elseif k:lower() == "s" then
                            S.B = 0
                        elseif k:lower() == "a" then
                            S.L = 0
                        elseif k:lower() == "d" then
                            S.R = 0
                        end
                    end)
                    FLY()
                    if Max == 2 then
                        getgenv().Fly = false
                        Max = 0
                    end
                end
            end
        end)
    end
})
Toggles.aaS:OnChanged(function()
    Sex = Toggles.aaS.Value
end)

RightGroupBox:AddButton('ServerHop', function()
    ServerHop()
end)
RightGroupBox:AddButton('Rejoin', function()
    local Success, ErrorMessage = pcall(function()
        Rejoin()
    end)
    if ErrorMessage and not Success then
        warn(ErrorMessage)
    elseif Success and not ErrorMessage then
        print(Success)
    end
end)
-- I set NoUI so it does not show up in the keybinds menu
MenuGroup:AddButton('Unload', function()
    Library:Unload()
end)
MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', {
    Default = "RightControl",
    NoUI = true,
    Text = 'Menu keybind'
})

Library.ToggleKeybind = Options.MenuKeybind
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({'MenuKeybind'})
ThemeManager:SetFolder('V.G Hub')
SaveManager:SetFolder("V.G Hub/" .. game.PlaceId)
SaveManager:BuildConfigSection(Tabs['UI Settings'])
ThemeManager:ApplyToTab(Tabs['UI Settings'])
