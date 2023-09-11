local Ad = {}
local RS = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local API = RS:WaitForChild("API")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer.PlayerGui

getupvalue = getupvalue or function()
    print("[no getupvalue]")
end

for remotename, hashedremote in getupvalue(require(RS:WaitForChild("Fsys")).load("RouterClient").init, 4) or {} do
    hashedremote.Name = remotename
end

for _, Remote in API:GetChildren() do
    local Name = Remote.Name:split("/")[2]
    if Remote:IsA("RemoteEvent") then
        Ad[Name] = function(Args)
            Remote:FireServer(unpack(Args))
        end
    elseif Remote:IsA("RemoteFunction") then
        Ad[Name] = function(Args)
            Remote:InvokeServer(unpack(Args))
        end
    end
end

--- CUSTOMS ---

local function GetPets(Properties)
    local Pets = {}

    for Unique, Info in Ad:GetInventory().pets do
        for Property, Value in Properties or {} do
            if Info.properties[Property] == Value or
                (Info.properties[Property] == nil and (Value == false or Value == nil)) then
                Pets[Info.kind] = Pets[Info.kind] or {}
                Pets[Info.kind][Unique] = Info
            end
        end
    end

    return Pets
end

function Ad:GetInventory()
    return require(RS.ClientModules.Core.ClientData).get_data()[LocalPlayer.Name].inventory
end

function Ad:GetAilments()
    local Ailments = {}

    for _, Ailment in PlayerGui.AilmentsMonitorApp.Ailments:GetChildren() do
        if Ailment:IsA("Frame") then
            table.insert(Ailments, Ailment.Name)
        end
    end

    return Ailments
end

function Ad:GetFullgrownPets()
    return GetPets({
        ["age"] = 6,
        ["neon"] = false
    })
end

function Ad:GetLuminousPets()
    return GetPets({
        ["age"] = 6,
        ["neon"] = true
    })
end

function Ad:GetQuestIds()
    local QuestIds = {}
    if not PlayerGui:FindFirstChild("QuestApp") then
        return {}
    end
    for _, Quest in PlayerGui.QuestApp.Board.Body.Contents.ScrollingFrame:GetChildren() do
        table.insert(QuestIds, Quest.Body:GetAttribute("QuestId"))
    end
    return QuestIds
end

function Ad:GetFurniture()
    local Furniture = {}
    for _, Piece in workspace:WaitForChild("HouseInteriors"):WaitForChild("furniture"):GetChildren() do
        Furniture[Piece.Name] = Piece:FindFirstChildWhichIsA("Model")
    end
    return Furniture
end

function Ad:FindFurniturePiece(TargetPiece)
    local Furniture = Ad:GetFurniture()
    for FurnitureName, Piece in Furniture do
        if Piece.name:lower():find(TargetPiece:lower()) then
            local owner, house_index, unknown, can_edit, id = unpack(FurnitureName:split("/"))
            return {
                ["owner"] = owner,
                ["house_index"] = house_index,
                ["unknown"] = unknown,
                ["can_edit"] = can_edit,
                ["id"] = id,
                ["name"] = FurnitureName,
                ["kind"] = Piece.Name:lower(),
                ["object"] = Piece
            }
        end
    end
    return {}
end

function Ad:GetHouseOrigin()
    return workspace.HouseInteriors.blueprint[LocalPlayer.Name].SpecialParts.FurnitureOrigin.Position
end

return Ad
