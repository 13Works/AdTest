wait(2)
local RS = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local table = loadstring(game:HttpGet(('https://raw.githubusercontent.com/13Works/CustomFunctions/main/table.lua'),true))()
local Ad = loadstring(game:HttpGet(('https://raw.githubusercontent.com/13Works/AdFunctions/main/Ad.lua'),true))(); print(Ad)
local Library = loadstring(game:HttpGet(('https://raw.githubusercontent.com/13Works/AdFunctions/main/Library.lua'),true))()
local Settings = {}

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer.PlayerGui

local Window = Library:NewWindow(Settings)
Window.Title = "New Window"
Window.Description = "Testing"
Window:Load()

local Connections = {}

------------- PET FARM FUNCTIONS -------------
local PetFarmAilments = {}
local camping = Vector3.new(-346.4987487792969, 18.902881622314453, -1743.13720703125)
local pool_party = Vector3.new(-639.586548, 21.5143299, -1444.55005)

local Baseplate = Instance.new("Part")
Baseplate.Parent = workspace
Baseplate.Transparency = 1
Baseplate.Anchored = true
Baseplate.Size = Vector3.new(1000, 1000, 1000)
Baseplate.Position = LocalPlayer.Character.HumanoidRootPart.Position - Vector3(0, 10, 0)

local function ListenForCompletion(Ailment: string)
	repeat
		task.wait(1)
	until not table.findvalue(Ad:GetAilments(), Ailment)
	PetFarmAilments[Ailment].is_doing = nil
end

PetFarmAilments.sick = {["do"] = function(Pet)
	if PetFarmAilments.sick.is_doing then return end
	Ad.BuyItem("food", "healing_apple", {})
	Ad.FeedPet("healing_apple")
	PetFarmAilments.sick.is_doing = true
	task.spawn(ListenForCompletion, "sick")
end}
	
PetFarmAilments.school = {["location"] = true; ["do"] = function(Pet)
	if PetFarmAilments.school.is_doing then return end
	Ad.SetLocation("School")
	PetFarmAilments.school.is_doing = true
	task.spawn(ListenForCompletion, "school")
end};
	
PetFarmAilments.bored = {["do"] = function(Pet)
	if PetFarmAilments.bored.is_doing then return end
	Ad.SetLocation("housing", "MainDoor", {["house_owner"] = LocalPlayer})
	local Origin = Ad:GetHouseOrigin()
	local Piano = Ad:FindFurniturePieces("piano")[1]
	
	if not Piano then
		local PianoInfo = {["kind"] = "piano", ["properties"] = {["cframe"] = CFrame.new(-Origin)}}
		Ad.BuyFurnitures({PianoInfo})
		Piano = Ad:FindFurniturePieces("piano")[1]
	end
	
	Ad.ActivateFurniture(
		LocalPlayer,
		Piano.interior_id,
		"Seat1",
		{["cframe"] = LocalPlayer.Character.HumanoidRootPart.CFrame},
		Pet
	)
	
	PetFarmAilments.bored.is_doing = true
	task.spawn(ListenForCompletion, "bored")
end};
	
PetFarmAilments.camping = {["do"] = function(Pet)
	if PetFarmAilments.camping.is_doing then return end
	Ad.SetLocation("housing", "MainDoor", {["house_owner"] = LocalPlayer})

	local TargetLocation = camping
	local Origin = Ad:GetHouseOrigin()
	local Seats = Ad:FindFurniturePieces("smallchair")
	local TargetSeat = Ad:FindFurnitureInPosition(Seats, TargetLocation)

	if next(Seats) == nil or not TargetSeat then
		local SeatInfo = {["kind"] = "smallchair", ["properties"] = {["cframe"] = CFrame.new(-Origin + TargetLocation)}}
		Ad.BuyFurnitures({SeatInfo})
		print("Purchased new seat at position:", TargetLocation); task.wait(1)
		Seats = Ad:FindFurniturePieces("smallchair")
		TargetSeat = Ad:FindFurnitureInPosition(Seats, TargetLocation)
	end

	Ad.ActivateFurniture(LocalPlayer, TargetSeat.interior_id, "Seat1", {["cframe"] = CFrame.new(TargetLocation)}, Pet)
	PetFarmAilments.camping.is_doing = true
	task.spawn(ListenForCompletion, "camping")
end};
	
PetFarmAilments.pool_party = {["do"] = function(Pet)
	if PetFarmAilments.pool_party.is_doing then return end
	Ad.SetLocation("housing", "MainDoor", {["house_owner"] = LocalPlayer})

	local TargetLocation = pool_party
	local Origin = Ad:GetHouseOrigin()
	local Seats = Ad:FindFurniturePieces("smallchair")
	local TargetSeat = Ad:FindFurnitureInPosition(Seats, TargetLocation)

	if next(Seats) == nil or not TargetSeat then
		local SeatInfo = {["kind"] = "smallchair", ["properties"] = {["cframe"] = CFrame.new(-Origin + TargetLocation)}}
		Ad.BuyFurnitures({SeatInfo})
		print("Purchased new seat at position:", TargetLocation); task.wait(1)
		Seats = Ad:FindFurniturePieces("smallchair")
		TargetSeat = Ad:FindFurnitureInPosition(Seats, TargetLocation)
	end

	Ad.ActivateFurniture(LocalPlayer, TargetSeat.interior_id, "Seat1", {["cframe"] = CFrame.new(TargetLocation)}, Pet)
	PetFarmAilments.pool_party.is_doing = true
	task.spawn(ListenForCompletion, "pool_party")
end};
	
PetFarmAilments.adoption_party = {["location"] = true; ["do"] = function(Pet)
	if PetFarmAilments.adoption_party.is_doing then return end
	Ad.SetLocation("Nursery")
	PetFarmAilments.adoption_party.is_doing = true
	task.spawn(ListenForCompletion, "adoption_party")
end};

PetFarmAilments.salon = {["location"] = true; ["do"] = function(Pet)
	if PetFarmAilments.salon.is_doing then return end
	Ad.SetLocation("Salon")
	PetFarmAilments.salon.is_doing = true
	task.spawn(ListenForCompletion, "salon")
end};

PetFarmAilments.pizza_party = {["location"] = true; ["do"] = function(Pet)
	if PetFarmAilments.pizza_party.is_doing then return end
	Ad.SetLocation("PizzaShop")
	PetFarmAilments.pizza_party.is_doing = true
	task.spawn(ListenForCompletion, "pizza_party")
end};

PetFarmAilments.hungry = {["do"] = function(Pet)
	if PetFarmAilments.thirsty.is_doing then return end
	Ad.FeedPet("apple")
	PetFarmAilments.hungry.is_doing = true
	task.spawn(ListenForCompletion, "hungry")
end};

PetFarmAilments.thirsty = {["do"] = function(Pet)
	if PetFarmAilments.thirsty.is_doing then return end
	Ad.FeedPet("tea")
	PetFarmAilments.thirsty.is_doing = true
	task.spawn(ListenForCompletion, "thirsty")
end};
	
PetFarmAilments.sleepy = {["static"] = true; ["do"] = function(Pet)
	if PetFarmAilments.sleepy.is_doing then return end
	Ad.SetLocation("housing", "MainDoor", {["house_owner"] = LocalPlayer})
	Ad.ActivateFurniture(
		LocalPlayer,
		Ad:FindFurniturePiece("bed"),
		"UseBlock",
		{["cframe"] = LocalPlayer.Character.HumanoidRootPart.CFrame},
		Pet
	)
	PetFarmAilments.sleepy.is_doing = true
	task.spawn(ListenForCompletion, "sleepy")
end};
	
PetFarmAilments.dirty = {["static"] = true; ["do"] = function(Pet)
	if PetFarmAilments.dirty.is_doing then return end
	Ad.SetLocation("housing", "MainDoor", {["house_owner"] = LocalPlayer})
	Ad.ActivateFurniture(
		LocalPlayer,
		Ad:FindFurniturePiece("shower"),
		"UseBlock",
		{["cframe"] = LocalPlayer.Character.HumanoidRootPart.CFrame},
		Pet
	)
	PetFarmAilments.dirty.is_doing = true
	task.spawn(ListenForCompletion, "dirty")
end};

local function IsDoingAilment()
	for Ailment, Info in PetFarmAilments do
		if Info.is_doing then return true end
	end
	return false
end

------------- FARMING SECTION -------------

local Farming = Window:NewSection({["Title"] = "Farming", ["SwitchTo"] = true, ["Items"] = {
	Window:NewButton({["Title"] = "Print config", ["Description"] = "Description"}, function(self)
		table.print(Settings.Config)
	end);

	Window:NewItemHolder({["Title"] = "Pet farm", ["Items"] = {
		Window:NewToggle({["Title"] = "Enabled", ["Locked"] = true, ["Position"] = 0}, function(self)
			print(self.State and "Enabling" or "Disabling" ,"pet farm")
			if self.State then
				local Spawned, Pet
				
				for Unique, Info in Ad:GetInventory().pets do
					Spawned, Pet = Ad.Equip(Unique)
					break
				end
				
				while self.State do
					task.wait(1)
					local Ailments = Ad:GetAilments()
					if #Ailments > 0 then
						for _, Ailment in Ailments do
							local AilmentInfo = PetFarmAilments[Ailment]

							if Ailment.static then
								repeat task.wait(1) until not IsDoingAilment()
								Ailment["do"](Pet)
								repeat task.wait(1) until not self.State or Ailment.is_doing == false
							else
								Ailment["do"](Pet)
							end
						end
					end
				end
			end
		end);

		Window:NewToggle({["Title"] = "Create neons", ["Position"] = 1}, function(self)
			print(self.State and "Enabling" or "Disabling" ,"create neons")
			while self.State do
				task.wait(1)
				local Fullgrowns = Ad:GetFullgrownPets()
				if next(Fullgrowns) == nil then continue end
				for kind, pets in Fullgrowns do
					if not (#table.keys(pets) >= 4) then continue end
					local PetsToFuse = {}
					
					for unique, info in pets do
						table.insert(PetsToFuse, unique)
						if #PetsToFuse == 4 then break end
					end
					
					Ad.DoNeonFusion(PetsToFuse)
				end
			end
		end);

		Window:NewToggle({["Title"] = "Create mega neons", ["Position"] = 2}, function(self)
			print(self.State and "Enabling" or "Disabling" ,"create mega neons")
			while self.State do
				task.wait(1)
				local Luminous = Ad:GetLuminousPets()
				if next(Luminous) == nil then continue end
				for kind, pets in Luminous do
					if not (#table.keys(pets) >= 4) then continue end
					local PetsToFuse = {}

					for unique, info in pets do
						table.insert(PetsToFuse, unique)
						if #PetsToFuse == 4 then break end
					end
					
					Ad.DoNeonFusion(PetsToFuse)
				end
			end
		end);

		Window:NewToggle({["Title"] = "Farm by rarity", ["Locked"] = true, ["Position"] = 3}, function(self)
			print(self.State and "Enabling" or "Disabling" ,"farm by rarity")
		end);

		Window:NewDropdown({["Title"] = "Rarities to farm", ["Locked"] = true, ["Position"] = 4, ["Options"] = {
			["All"] = true;
			["Legendary"] = false;
			["Ultra-rare"] = false;
			["Rare"] = false;
			["Uncommon"] = false;
			["Common"] = false;
		}}, function(Options)

		end);

		Window:NewToggle({["Title"] = "Farm by pet type", ["Locked"] = true, ["Position"] = 5}, function(self)
			print(self.State and "Enabling" or "Disabling" ,"farm by pet type")
		end);

		Window:NewDropdown({["Title"] = "Pet types to farm", ["Locked"] = true, ["Position"] = 6, ["Options"] = {
			["All"] = true;
		}}, function(Options)

		end);
	}});

	Window:NewItemHolder({["Title"] = "Potion farm", ["Items"] = {
		Window:NewToggle({["Title"] = "Enabled", ["Locked"] = true, ["Position"] = 0}, function(self)
			print(self.State and "Enabling" or "Disabling" ,"potion farm")
		end);

		Window:NewDropdown({["Title"] = "Potion pet", ["Locked"] = true, ["Position"] = 1}, function(Options)

		end);
	}});

	Window:NewItemHolder({["Title"] = "Egg farm", ["Items"] = {
		Window:NewToggle({["Title"] = "Enabled", ["Locked"] = true, ["Position"] = 0}, function(self)
			print(self.State and "Enabling" or "Disabling" ,"potion farm")
		end);

		Window:NewToggle({["Title"] = "Buy eggs on hatch", ["Locked"] = true, ["Position"] = 1}, function(self)
			print(self.State and "Enabling" or "Disabling" ,"buy eggs on hatch")
		end);

		Window:NewDropdown({["Title"] = "Eggs to buy", ["Locked"] = true, ["Position"] = 2}, function(Options)

		end);

		Window:NewToggle({["Title"] = "Farm hatched pet", ["Locked"] = true, ["Position"] = 3}, function(self)
			print(self.State and "Enabling" or "Disabling" ,"farm hatched pet")
		end);

		Window:NewToggle({["Title"] = "Farm hatched rarities", ["Locked"] = true, ["Position"] = 5}, function(self)
			print(self.State and "Enabling" or "Disabling" ,"farm hatched rarities")
		end);

		Window:NewDropdown({["Title"] = "Hatched rarities to farm", ["Locked"] = true, ["Position"] = 6}, function(Options)

		end);
	}});

	Window:NewItemHolder({["Title"] = "Fruit farm", ["Items"] = {
		Window:NewToggle({["Title"] = "Enabled", ["Position"] = 0}, function(self)
			print(self.State and "Enabling" or "Disabling" ,"event farm")
			while self.State do
				Ad.PickFruit("berry", 1)
				Ad.PickFruit("pear", 1)
				Ad.PickFruit("mango", 1)
				task.wait()
			end
		end);
		
		Window:NewToggle({["Title"] = "Exchange cookies", ["Position"] = 1}, function(self)
			print(self.State and "Enabling" or "Disabling" ,"exchange cookies")
			local InvalidKinds = {}
			while self.State do
				for Unique, Info in require(RS.ClientModules.Core.ClientData).get_data()[LocalPlayer.Name].inventory.food do
					if not table.find(InvalidKinds, Info.kind) and Info.kind:find("campfire_cookie") then
						Ad.ExchangeItemForReward("lures_2023_campfire_cookies_liveops", Unique)
					elseif table.find(InvalidKinds, Info.kind) then
						continue
					else
						table.insert(InvalidKinds, Info.kind)
						continue
					end
				end
				task.wait(1)
			end
		end);

		Window:NewToggle({["Title"] = "Use bait", ["Position"] = 2}, function(self)
			print(self.State and "Enabling" or "Disabling" ,"exchange cookies")
		end);

		Window:NewDropdown({["Title"] = "Bait to use", ["Position"] = 3, ["Options"] = {}});

		Window:NewToggle({["Title"] = "Cook recipes", ["Position"] = 4}, function(self)
			print(self.State and "Enabling" or "Disabling" ,"cook recipes")
			while self.State do
				local RecipesToCook = Settings.Config["Farming"] and Settings.Config["Farming"]["FruitFarm"] and Settings.Config["Farming"]["Recipes to cook"] or {}
				for Recipe, Value in RecipesToCook do
					if Value then
						Ad.CookRecipe(Value and (Recipe == "Standard" and "daily_recipe" or Recipe == "Super" and "super_recipe") or nil) 
					end
				end
			end
		end);

		Window:NewDropdown({["Title"] = "Recipes to cook", ["Position"] = 5, ["Options"] = {
			["All"] = true,
			["Standard"] = false, 
			["Super"] = false, 
		}});

		Window:NewDropdown({["Title"] = "Fruit to harvest", ["Position"] = 6, ["Options"] = {
			["All"] = true,
			["Berry"] = false, 
			["Mango"] = false, 
			["Pear"] = false
		}});
	}});

	Window:NewToggle({["Title"] = "Cash farm", ["Locked"] = true}, function(self)
		print(self.State and "Enabling" or "Disabling" ,"cash farm")
	end);

	Window:NewToggle({["Title"] = "Baby farm"}, function(self)
		if self.State then
			Ad.ChooseTeam("Babies")
			while self.State do
				task.wait(1)
				local Ailments = Ad:GetAilments()
				if next(Ailments) == nil then continue end
				for _, Ailment in Ailments do
					Ad.AddAdditive(Ailment, math.random(100))
				end
			end
		else
			Ad.ChooseTeam("Parents")
		end
		print(self.State and "Enabling" or "Disabling" ,"baby farm")
	end);

	Window:NewToggle({["Title"] = "Claim quests"}, function(self)
		print(self.State and "Enabling" or "Disabling" ,"claim claim quests")
		while self.State do
			task.wait(1)
			local Quests = Ad:GetQuestIds()
			for _, QuestId in Quests do
				Ad.ClaimQuest(QuestId)
			end
		end
	end);

	Window:NewToggle({["Title"] = "Claim star rewards"}, function(self)
		print(self.State and "Enabling" or "Disabling" ,"claim star rewards")
	end);
}})

------------- AUTOMATION SECTION -------------
local Automation = Window:NewSection({["Title"] = "Automation", ["Items"] = {
	Window:NewToggle({["Title"] = "Auto accept trades"}, function(self)
		print(self.State and "Enabling" or "Disabling" ,"auto accept trades")
	end);
	
	Window:NewItemHolder({["Title"] = "Auto trade", ["Items"] = {
		Window:NewToggle({["Title"] = "Enabled", ["Position"] = 0}, function(self)
			print(self.State and "Enabling" or "Disabling" ,"auto trade")
		end);

		Window:NewToggle({["Title"] = "Auto trade categories", ["Position"] = 1}, function(self)
			print(self.State and "Enabling" or "Disabling" ,"auto trade categories")
		end);

		Window:NewDropdown({["Title"] = "Categories to trade", ["Position"] = 2, ["Options"] = {
			["All"] = true;
			["Pets"] = false;
			["Food"] = false;
			["Vehicles"] = false;
			["Strollers"] = false;
			["Gifts"] = false;
		}}, function(Options)

		end);

		Window:NewToggle({["Title"] = "Auto trade properties", ["Position"] = 3}, function(self)
			print(self.State and "Enabling" or "Disabling" ,"auto trade properties")
		end);

		Window:NewDropdown({["Title"] = "Properties to trade", ["Position"] = 4, ["Options"] = {
			["All"] = true;
			["Fullgrown"] = false;
			["Luminous"] = false;
			["Mega"] = false;
			["Flyable"] = false;
			["Rideable"] = false;
		}}, function(Options)

		end);


		Window:NewToggle({["Title"] = "Auto trade rarities", ["Position"] = 5}, function(self)
			print(self.State and "Enabling" or "Disabling" ,"auto trade rarities")
		end);

		Window:NewDropdown({["Title"] = "Rarities to trade", ["Position"] = 6, ["Options"] = {
			["All"] = true;
			["Legendary"] = false;
			["Ultra-rare"] = false;
			["Rare"] = false;
			["Uncommon"] = false;
			["Common"] = false;
		}}, function(Options)

		end);
		
		Window:NewInput({["Title"] = "Player to trade", ["Position"] = 7});
	}});
	
	Window:NewItemHolder({["Title"] = "Auto grow", ["Items"] = {
		Window:NewToggle({["Title"] = "Enabled", ["Position"] = 0}, function(self)
			print(self.State and "Enabling" or "Disabling" ,"auto grow")
		end);

		Window:NewToggle({["Title"] = "Auto grow selected pets", ["Position"] = 1}, function(self)
			print(self.State and "Enabling" or "Disabling" ,"auto grow selected pets")
		end);

		Window:NewDropdown({["Title"] = "Pets to grow", ["Position"] = 2, ["Options"] = {
			["All"] = true;
		}}, function(Options)

		end);

		Window:NewToggle({["Title"] = "Auto grow rarities", ["Position"] = 3}, function(self)
			print(self.State and "Enabling" or "Disabling" ,"auto grow rarities")
		end);

		Window:NewDropdown({["Title"] = "Rarities to grow", ["Position"] = 4, ["Options"] = {
			["All"] = true;
			["Legendary"] = false;
			["Ultra-rare"] = false;
			["Rare"] = false;
			["Uncommon"] = false;
			["Common"] = false;
		}}, function(Options)

		end);

		Window:NewToggle({["Title"] = "Auto grow pet type", ["Position"] = 5}, function(self)
			print(self.State and "Enabling" or "Disabling" ,"auto grow pet type")
		end);

		Window:NewDropdown({["Title"] = "Pet types to grow", ["Position"] = 6, ["Options"] = {
			["All"] = true;
		}}, function(Options)

		end);
	}});

	Window:NewItemHolder({["Title"] = "Auto open", ["Items"] = {
		Window:NewToggle({["Title"] = "Enabled", ["Position"] = 0}, function(self)
			print(self.State and "Enabling" or "Disabling" ,"auto open")
		end);

		Window:NewToggle({["Title"] = "Auto open rarities", ["Position"] = 1}, function(self)
			print(self.State and "Enabling" or "Disabling" ,"auto open rarities")
		end);

		Window:NewDropdown({["Title"] = "Rarities to open", ["Position"] = 2, ["Options"] = {
			["All"] = true;
			["Legendary"] = false;
			["Ultra-rare"] = false;
			["Rare"] = false;
			["Uncommon"] = false;
			["Common"] = false;
		}}, function(Options)

		end);

		Window:NewToggle({["Title"] = "Auto open selected gifts", ["Position"] = 3}, function(self)
			print(self.State and "Enabling" or "Disabling" ,"auto open selected gifts")
		end);

		Window:NewDropdown({["Title"] = "Gifts to open", ["Position"] = 4, ["Options"] = {
			["All"] = true;
		}}, function(Options)

		end);
	}});
}})

------------- SHOP SECTION -------------
local Shop = Window:NewSection({["Title"] = "Shop"})

local EggsItem = Window:NewItemHolder({["Title"] = "Eggs", ["Parent"] = Shop.Object})
local PetsDB = require(RS.ClientDB.Inventory.InventoryPetsSubDB.InventoryPetsSubDB).entries
local Eggs = {
	["Urban Egg"] = "urban_2023_egg";
	["Danger Egg"] = "danger_2023_egg";
	["Southeast Asia Egg"] = "seasia_2023_egg";
	["Japan Egg"] = "japan_2022_egg";
	["Woodland Egg"] = "woodland_2022_egg";
	["Mythic Egg"] = "mythic_egg";
	["Retired Egg"] = "retired_egg";
	["Royal Egg"] = "royal_egg";
	["Pet Egg"] = "regular_pet_egg";
	["Cracked Egg"] = "cracked_egg";
}

for _, kind in Eggs do
	local Info = PetsDB[kind]; if not Info then continue end
	Window:NewButton({["Title"] = "Buy " .. Info.name, ["Description"] = "$" .. Info.cost, ["IconId"] = Info.image, ["Parent"] = EggsItem.Object}, function()
		Ad.BuyItem("pets", kind, {})
	end)
end

Window:NewToggle({["Title"] = "Auto buy eggs", ["Parent"] = EggsItem.Object}, function(self)
	while self.State do
		print("Buying")
		local EggsToBuy = Settings.Config["Eggs"] and Settings.Config["Eggs"]["Eggs to auto buy"] or {}
		local Amount = Settings.Config["Eggs"] and Settings.Config["Eggs"]["Amount of eggs to buy"] or math.huge
		Amount = tonumber(Amount)

		local function Buy()
			if EggsToBuy["All"] then
				for _, kind in Eggs do
					Ad.BuyItem("pets", kind, {})
					task.wait(0.05)
				end
				return
			end

			for Egg, Value in EggsToBuy do
				if Value then
					Ad.BuyItem("pets", Eggs[Egg], {})
					task.wait(0.05)
				end
			end
		end
		
		if next(EggsToBuy) ~= nil then
			if Amount ~= math.huge then
				for i = 1, Amount do Buy() end
				self:Toggle(); break
			else
				Buy()
			end
		end

		task.wait()
	end
end);

Window:NewInput({["Title"] = "Amount of eggs to buy", ["Parent"] = EggsItem.Object}, function(self)
	local Amount = tonumber(self:GetText())
	if not Amount or Amount == 0 then
		self:SetText(""); Amount = math.huge
	end
	print(Amount, "amount of eggs to buy")
end)

Window:NewDropdown({["Title"] = "Eggs to auto buy", ["Parent"] = EggsItem.Object, ["Options"] = {
	["All"] = false;
	["Urban Egg"] = false;
	["Danger Egg"] = false;
	["Southeast Asia Egg"] = false;
	["Japan Egg"] = false;
	["Woodland Egg"] = false;
	["Mythic Egg"] = false;
	["Retired Egg"] = false;
	["Royal Egg"] = false;
	["Pet Egg"] = false;
	["Cracked Egg"] = false;
}});

local GiftsItem = Window:NewItemHolder({["Title"] = "Gifts", ["Parent"] = Shop.Object})
local GiftsDB = require(RS.ClientDB.Inventory.InventoryGiftsSubDB).entries
local Gifts = {
	["Massive Gift"] = "massivegift";
	["Big Gift"] = "biggift";
	["Small Gift"] = "smallgift";
	["Regal Chest"] = "legend_hat_2022_regal_chest";
	["Standard Wing Chest"] = "wings_2022_bucks_wing_chest";
	["Simple Chest"] = "legend_hat_2022_simple_chest";
}

for _, kind in Gifts do
	local Info = GiftsDB[kind]; if not Info then continue end
	Window:NewButton({["Title"] = "Buy " .. Info.name, ["Description"] = "$" .. Info.cost, ["IconId"] = Info.image, ["Parent"] = GiftsItem.Object}, function()
		Ad.BuyItem("gifts", kind, {})
	end)
end

Window:NewToggle({["Title"] = "Auto buy gifts", ["Parent"] = GiftsItem.Object}, function(self)
	while self.State do
		local GiftsToBuy = Settings.Config["Gifts"] and Settings.Config["Gifts"]["Gifts to auto buy"] or {}
		local Amount = Settings.Config["Gifts"] and Settings.Config["Gifts"]["Amount of gifts to buy"] or math.huge
		Amount = tonumber(Amount)

		local function Buy()
			if GiftsToBuy["All"] then
				for _, kind in Gifts do
					Ad.BuyItem("gifts", kind, {})
					task.wait(0.05)
				end
				return
			end

			for Gift, Value in GiftsToBuy do
				if Value then
					Ad.BuyItem("gifts", Gifts[Gift], {})
					task.wait(0.05)
				end
			end
		end

		if next(GiftsToBuy) ~= nil then
			if Amount ~= math.huge then
				for i = 1, Amount do Buy() end
				self:Toggle(); break
			else
				Buy()
			end
		end

		task.wait()
	end
end);

Window:NewInput({["Title"] = "Amount of gifts to buy", ["Parent"] = GiftsItem.Object}, function(self)
	local Amount = tonumber(self:GetText())
	if not Amount or Amount == 0 then
		self:SetText(""); Amount = math.huge
	end
	print(Amount, "amount of gifts to buy")
end)

Window:NewDropdown({["Title"] = "Gifts to auto buy", ["Parent"] = GiftsItem.Object, ["Options"] = {
	["All"] = false;
	["Massive Gift"] = false;
	["Big Gift"] = false;
	["Small Gift"] = false;
	["Regal Chest"] = false;
	["Standard Wing Chest"] = false;
	["Standard Chest"] = false;
}});

local StrollersItem = Window:NewItemHolder({["Title"] = "Strollers", ["Parent"] = Shop.Object})
local StrollersDB = require(RS.ClientDB.Inventory.InventoryStrollersSubDB).entries
local Strollers = {
	["Teacup Stroller"] = "teacup_stroller";
	["Ballon Stroller"] = "balloon_stroller";
	["Rocket Ship Stroller"] = "rocket_ship_stroller";
	["Hover Stroller"] = "hover_stroller";
	["Rainbow Stroller"] = "rainbow_stroller";
	["Princess Stroller"] = "princess_stroller";
	["Shopping Cart Stroller"] = "shopping_cart_stroller";
	["Pelican Stroller"] = "pelican_stroller";
	["Camper's Wheelbarrow Stroller"] = "camping_2023_wheelbarrow_stroller";
	["Wheelbarrow Stroller"] = "wheelbarrow_stroller";
	["Magic Carpet Stroller"] = "magic_carpet_stroller";
	["Magic Moon Stroller"] = "magic_moon_stroller";
	["Car Stroller"] = "car_stroller";
	["Double Stroller"] = "double_stroller";
	["Stroller"] = "stroller-c";
}

for _, kind in Strollers do
	local Info = StrollersDB[kind]; if not Info then continue end
	Window:NewButton({["Title"] = "Buy " .. Info.name, ["Description"] = "$" .. Info.cost, ["IconId"] = Info.image, ["Parent"] = StrollersItem.Object}, function()
		local Color = Settings.Config.Strollers and Settings.Config.Strollers["Stroller color"] or Color3.new(1, 1, 1)
		Ad.BuyItem("strollers", kind, {["chosen_rgb"] = Color})
	end)
end

Window:NewToggle({["Title"] = "Auto buy strollers", ["Parent"] = StrollersItem.Object}, function(self)
	while self.State do
		local StrollersToBuy = Settings.Config["Strollers"] and Settings.Config["Strollers"]["Strollers to auto buy"] or {}
		local Amount = Settings.Config["Strollers"] and Settings.Config["Strollers"]["Amount of strollers to buy"] or math.huge
		Amount = tonumber(Amount)
		local Color = Settings.Config.Strollers and Settings.Config.Strollers["Stroller color"] or Color3.new(1, 1, 1)
		
		local function Buy()
			if StrollersToBuy["All"] then
				for _, kind in Strollers do
					Ad.BuyItem("strollers", kind, {["chosen_rgb"] = Color})
					task.wait(0.05)
				end
				return
			end

			for Stroller, Value in StrollersToBuy do
				if Value then
					Ad.BuyItem("strollers", Strollers[Stroller], {["chosen_rgb"] = Color})
					task.wait(0.05)
				end
			end
		end
		
		if next(StrollersToBuy) ~= nil then
			if Amount ~= math.huge then
				for i = 1, Amount do Buy() end
				self:Toggle(); break
			else
				Buy()
			end
		end
		
		task.wait()
	end
end);

Window:NewInput({["Title"] = "Amount of strollers to buy", ["Parent"] = StrollersItem.Object}, function(self)
	local Amount = tonumber(self:GetText())
	if not Amount or Amount == 0 then
		self:SetText(""); Amount = math.huge
	end
	print(Amount, "amount of strollers to buy")
end)

Window:NewDropdown({["Title"] = "Strollers to auto buy", ["Parent"] = StrollersItem.Object, ["Options"] = {
	["All"] = false;
	["Teacup Stroller"] = false;
	["Ballon Stroller"] = false;
	["Rocket Ship Stroller"] = false;
	["Hover Stroller"] = false;
	["Rainbow Stroller"] = false;
	["Princess Stroller"] = false;
	["Shopping Cart Stroller"] = false;
	["Pelican Stroller"] = false;
	["Camper's Wheelbarrow Stroller"] = false;
	["Wheelbarrow Stroller"] = false;
	["Magic Carpet Stroller"] = false;
	["Magic Moon Stroller"] = false;
	["Car Stroller"] = false;
	["Double Stroller"] = false;
	["Stroller"] = false;
}});

------------- NOTIFICATIONS SECTION -------------
local Notifications = Window:NewSection({["Title"] = "Notifications", ["Items"] = {
	Window:NewToggle({["Title"] = "Close chat"}, function(self)
		print(self.State and "Closing" or "Opening" ,"chat")
	end);

	Window:NewItemHolder({["Title"] = "Webhook notifications", ["Items"] = {
		Window:NewToggle({["Title"] = "Enable", ["Position"] = 0}, function(self)
			print(self.State and "Enabling" or "Disabling" ,"webhook notifications")
		end);

		Window:NewInput({["Title"] = "Webhook URL", ["Position"] = 1});

		Window:NewSlider({["Title"] = "Send speed (minutes)", ["Position"] = 2, ["SliderType"] = "Scrub", ["DefaultValues"] = 10});
		
		Window:NewDropdown({["Title"] = "Notifications", ["Position"] = 3, ["Options"] = {
			["All"] = true;
			["Player loaded"] = false;
			["Player left"] = false;
			["Created neon"] = false;
			["Created mega neon"] = false;
			["All fullgrown"] = false;
			["All luminous"] = false;
			["Potion count"] = false;
			["Bucks"] = false;
			["Amount of eggs hatched"] = false;
			["Pets hatched"] = false;
			["Session time"] = false;
		}}, function(Options)

		end);
	}})
}})

------------- OPTIMIZATION SECTION -------------
local Optimization = Window:NewSection({["Title"] = "Optimization", ["Items"] = {
	Window:NewToggle({["Title"] = "Hide pets"}, function(self)
		print(self.State and "Hiding" or "Showing" ,"pets")
	end);

	Window:NewToggle({["Title"] = "Hide players"}, function(self)
		print(self.State and "Hiding" or "Showing" ,"players")
	end);

	Window:NewToggle({["Title"] = "Hide UI"}, function(self)
		print(self.State and "Hiding" or "Showing" ,"UI elements")
		for _, App in LocalPlayer.PlayerGui do
			if App.Name ~= "AilmentsMonitorApp" and App.Name ~= "TradeApp" then
				App.Enabled = not self.State
			end
		end
	end);

	Window:NewToggle({["Title"] = "Hide parts"}, function(self)
		print(self.State and "Hiding" or "Showing" ,"parts")
		local Interiors = workspace:FindFirstChild("Interiors")
		if not Interiors then warn("error getting interiors.") end
		
		local function HideParts(Part: BasePart)
			if not Part:IsA("BasePart") then return end
			Part.Transparency = 1
		end
		
		local function ShowParts(Part: BasePart)
			Part.Transparency = 0
		end
		
		Connections[self.Object.Name] = self.State and Interiors.DescendantAdded:Connect(HideParts) or nil
		
		for _, Part in Interiors:GetDescendants() do
			if self.State then
				HideParts(Part)
			else
				ShowParts(Part)
			end
		end 
	end);
	
	Window:NewItemHolder({["Title"] = "Render on release", ["Items"] = {
		Window:NewToggle({["Title"] = "Enable", ["Position"] = 0}, function(self)
			print(self.State and "Enabling" or "Disabling" ,"render on release")
		end);

		Window:NewToggle({["Title"] = "Black screen", ["Enabled"] = true, ["Position"] = 1}, function(self)
			print(self.State and "Enabling" or "Disabling" ,"black screen")
		end);
	}});

	Window:NewItemHolder({["Title"] = "FPS Limiter", ["Items"] = {
		Window:NewToggle({["Title"] = "Enable", ["Position"] = 0}, function(self)
			print(self.State and "Enabling" or "Disabling" ,"render on release")
		end);

		Window:NewSlider({["Title"] = "FPS limit", ["Position"] = 1, ["SliderType"] = "Range", ["DefaultValues"] = {["Min"] = 1, ["Max"] = 20}}, function(self)
			print(self.State and "Enabling" or "Disabling" ,"black screen")
		end);
	}});

	Window:NewToggle({["Title"] = "Disable animations"}, function(self)
		print(self.State and "Enabling" or "Disabling" ,"disable animations")
	end);

	Window:NewToggle({["Title"] = "Disable particles"}, function(self)
		print(self.State and "Enabling" or "Disabling" ,"Disable particles")
	end);

	Window:NewToggle({["Title"] = "Disable interaction icons"}, function(self)
		print(self.State and "Enabling" or "Disabling" ,"Disable interaction icons")
	end);

	Window:NewToggle({["Title"] = "Disable sounds"}, function(self)
		print(self.State and "Enabling" or "Disabling" ,"Disable sounds")
	end);
}})
