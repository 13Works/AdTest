local Library = {["Keybind"] = Enum.KeyCode.P}

Library.DefaultThemes = {
	["Dark"] = {
		["Main"] = Color3.new(0.0784314, 0.0784314, 0.0784314),
		["Bar"] = Color3.new(0.0784314, 0.0784314, 0.0784314),
		["Image"] = Color3.new(0.0784314, 0.0784314, 0.0784314),
		["Indicator"] = Color3.new(0.117647, 0.843137, 0.376471),
		["Interaction"] = Color3.new(1, 1, 1),
		["Input"] = Color3.new(0.0980392, 0.0980392, 0.0980392),
		["Item"] = Color3.new(0.113725, 0.113725, 0.113725),
		["ItemHolder"] = Color3.new(0.0784314, 0.0784314, 0.0784314),
		["Signal"] = Color3.new(0.117647, 0.117647, 0.117647),
		["Slider"] = Color3.new(1, 1, 1),
		["Stroke"] = Color3.new(0.196078, 0.196078, 0.196078),
		["Status"] = {
			[true] = Color3.new(0.117647, 0.843137, 0.376471),
			[false] = Color3.new(0.0588235, 0.0588235, 0.0588235)
		},
		["Background"] = Color3.new(0.0588235, 0.0588235, 0.0588235),
		["Icon"] = Color3.new(1, 1, 1),
		["SubBackground"] = Color3.new(0.0980392, 0.0980392, 0.0980392),
		["Scrollbar"] = Color3.new(0.784314, 0.784314, 0.784314),
		["Header"] = Color3.new(1, 1, 1),
		["Footer"] = Color3.new(0.588235, 0.588235, 0.588235),
		["Title"] = Color3.new(0.784314, 0.784314, 0.784314),
		["PlaceHolderText"] = Color3.new(0.588235, 0.588235, 0.588235),
		["Description"] = Color3.new(0.392157, 0.392157, 0.392157)
	},
	["Light"] = {
		["Background"] = Color3.new(0.921569, 0.921569, 0.921569),
		["Bar"] = Color3.new(0.784314, 0.784314, 0.784314),
		["Description"] = Color3.new(0.588235, 0.588235, 0.588235),
		["Interaction"] = Color3.new(0, 0, 0),
		["Image"] = Color3.new(0.960784, 0.960784, 0.960784),
		["Icon"] = Color3.new(0.392157, 0.392157, 0.392157),
		["Indicator"] = Color3.new(0.117647, 0.843137, 0.376471),
		["Status"] = {
			[true] = Color3.new(0.117647, 0.843137, 0.376471),
			[false] = Color3.new(0.921569, 0.921569, 0.921569)
		},
		["Input"] = Color3.new(0.921569, 0.921569, 0.921569),
		["Item"] = Color3.new(1, 1, 1),
		["ItemHolder"] = Color3.new(0.960784, 0.960784, 0.960784),
		["Main"] = Color3.new(1, 1, 1),
		["Signal"] = Color3.new(1, 1, 1),
		["Slider"] = Color3.new(1, 1, 1),
		["Stroke"] = Color3.new(0.784314, 0.784314, 0.784314),
		["SubBackground"] = Color3.new(0.921569, 0.921569, 0.921569),
		["Title"] = Color3.new(0.196078, 0.196078, 0.196078),
		["PlaceHolderText"] = Color3.new(0.588235, 0.588235, 0.588235),
		["Header"] = Color3.new(0, 0, 0),
		["Footer"] = Color3.new(0.392157, 0.392157, 0.392157),
		["Scrollbar"] = Color3.new(0, 0, 0)
	}
}

local RS = game:GetService("ReplicatedStorage")
local UIS = game:GetService("UserInputService")
local TS = game.TweenService
local tInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local DefaultTheme = "Dark"

local function Tween(Args)
	local DefaultThemes = Library.DefaultThemes
	local Item = Args.Item
	local Properties = Args.Properties
	local ItemType = Args.ItemType
	local TargetTheme = Args.TargetTheme

	if not ItemType and not Item:IsA("ScrollingFrame") then
		if not Properties then
			warn("Missing properties for tween. Item:", Item)
			return
		end
		local StandardTween = TS:Create(Item, tInfo, Properties)
		StandardTween:Play()
		if Args.Wait then
			StandardTween.Completed:Wait()
		end
		return
	end

	local ClassColors = {
		["TextLabel"] = "TextColor3",
		["TextButton"] = "BackgroundColor3",
		["CanvasGroup"] = "BackgroundColor3",
		["ImageLabel"] = "BackgroundColor3",
		["Frame"] = "BackgroundColor3",
		["UIStroke"] = "Color",
		["ScrollingFrame"] = "BackgroundColor3",
		["ImageButton"] = "BackgroundColor3",
		["TextBox"] = "BackgroundColor3"
	}

	local ClassName = Item.ClassName

	if ClassName == "ScrollingFrame" then
		TS:Create(Item, tInfo, Properties or {
			["ScrollBarImageColor3"] = DefaultThemes[TargetTheme]["Scrollbar"]
		}):Play()
	elseif ClassName == "TextBox" then
		TS:Create(Item, tInfo, Properties or {
			["PlaceholderColor3"] = DefaultThemes[TargetTheme]["PlaceHolderText"]
		}):Play()
		TS:Create(Item, tInfo, Properties or {
			["TextColor3"] = DefaultThemes[TargetTheme]["Title"]
		}):Play()
	elseif ClassName == "TextButton" then
		TS:Create(Item, tInfo, Properties or {
			["TextColor3"] = DefaultThemes[TargetTheme]["Title"]
		}):Play()
	elseif ClassName == "ImageButton" then
		TS:Create(Item, tInfo, Properties or {
			["ImageColor3"] = DefaultThemes[TargetTheme]["Icon"]
		}):Play()
	end

	if ItemType == "Slider" then
		TS:Create(Item.UIStroke, tInfo, Properties or {
			["Transparency"] = (TargetTheme == "Dark" and 1 or 0)
		}):Play()
	elseif ItemType == "Status" and Item.Parent:GetAttribute("State") ~= nil then
		local State = Item.Parent:GetAttribute("State")
		TS:Create(Item, tInfo, {
			["BackgroundColor3"] = DefaultThemes[TargetTheme][ItemType][State]
		}):Play()
		return
	end

	if ItemType and DefaultThemes[TargetTheme][ItemType] then
		TS:Create(Item, tInfo, Properties or {
			[ClassColors[ClassName]] = DefaultThemes[TargetTheme][ItemType]
		}):Play()
	end
end

function Library:NewWindow(Settings)
	local Window = {}
	Settings = Settings or {
		["Config"] = {},
		["Accounts"] = {}
	}

	local Panel = game:GetObjects("rbxassetid://14712850290")[1].Panel
	local Main = Panel.Main
	Window.Object = Main

	local LoadingFrame = Main["Loading frame"]
	local Content = Main.Content
	local Templates = Content.Sections.Templates:Clone()
	Content.Sections.Templates:Destroy()

	LoadingFrame.GroupTransparency = 1
	LoadingFrame.Visible = true
	Content.Visible = false
	Templates.Visible = false
	Main.Visible = false

	Main.Size = Main:GetAttribute("StartingSize")
	Main.Position = UDim2.fromScale(0.5, 0.5)
	Main.AnchorPoint = Vector2.new(0.5, 0.5)
	LoadingFrame.Bar.Fill.Size = UDim2.fromScale(0, 1)
	Panel.Parent = game:GetService("CoreGui")

	function Window:GetSetting(Object, IsOption)
		local ItemHolder = Object.Parent.Name
		if IsOption then
			if Object.Parent:GetAttribute("ItemType") == "ItemHolder" then
				return Settings.Config[ItemHolder] and Settings.Config[ItemHolder][IsOption] and
					Settings.Config[ItemHolder][IsOption][Object.Name] or nil
			else
				return Settings.Config[IsOption] and Settings.Config[IsOption][Object.Name] or nil
			end
		else
			if Object.Parent:GetAttribute("ItemType") == "ItemHolder" then
				return Settings.Config[ItemHolder] and Settings.Config[ItemHolder][Object.Name] or nil
			else
				return Settings.Config[Object.Name] or nil
			end
		end
	end

	function Window:SetSetting(Object, Value, IsOption, IsOptionHolder)
		Value = Value or nil
		local ItemHolder = IsOption and Object.Parent.Parent.Parent or Object.Parent
		if IsOption then
			if ItemHolder:GetAttribute("ItemType") == "ItemHolder" then
				Settings.Config[ItemHolder.Name] = Settings.Config[ItemHolder.Name] or {}
				Settings.Config[ItemHolder.Name][IsOption] = Settings.Config[ItemHolder.Name][IsOption] or {}
				Settings.Config[ItemHolder.Name][IsOption][Object.Name] = Value or nil
				if next(Settings.Config[ItemHolder.Name][IsOption] or {}) == nil then
					Settings.Config[ItemHolder.Name][IsOption] = nil
				end
			else
				Settings.Config[IsOption] = Settings.Config[IsOption] or {}
				Settings.Config[IsOption][Object.Name] = Value or nil
			end
		else
			if IsOptionHolder then
				for i, Option in Value do
					if ItemHolder:GetAttribute("ItemType") == "ItemHolder" then
						Settings.Config[ItemHolder.Name] = Settings.Config[ItemHolder.Name] or {}
						Settings.Config[ItemHolder.Name][Object.Name] =
							Settings.Config[ItemHolder.Name][Object.Name] or {}
						Settings.Config[ItemHolder.Name][Object.Name][i] = Value[i] or nil
						if next(Settings.Config[ItemHolder.Name][Object.Name] or {}) == nil then
							Settings.Config[ItemHolder.Name][Object.Name] = nil
						end
					else
						Settings.Config[Object.Name] = Settings.Config[Object.Name] or {}
						Settings.Config[Object.Name][i] = Value[i] or nil
					end
				end
			else
				if ItemHolder:GetAttribute("ItemType") == "ItemHolder" then
					Settings.Config[ItemHolder.Name] = Settings.Config[ItemHolder.Name] or {}
					Settings.Config[ItemHolder.Name][Object.Name] = Value or nil
				else
					Settings.Config[Object.Name] = Value or nil
				end
			end
		end
		if next(Settings.Config[ItemHolder.Name] or {}) == nil then
			Settings.Config[ItemHolder.Name] = nil
		end
	end

	local function LoadProfiles(Accounts)
		local PlayerList = Content.PlayerList

		local Profile = PlayerList.Profile
		Profile.Thumbnail.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. LocalPlayer.UserId ..
			"&width=50&height=50&format=png"
		Profile.Username.Text = "<font color='rgb(150, 150, 150)' size='17'>@</font>" .. LocalPlayer.Name

		PlayerList.Title.Text = "Alts"
		for Name, Info in Accounts or {} do
			local Thumbnail = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. Info.UserId ..
				"&width=50&height=50&format=png"
			Window:NewButton({
				["Title"] = Name,
				["IconId"] = Thumbnail,
				["Parent"] = PlayerList.Players
			}, function(self)
				warn("Sending trade to", self:GetText())
			end)
		end
		print("Loaded profile & accounts")
	end

	function Window:ChangeTheme(TargetTheme)
		if not Library.DefaultThemes[TargetTheme] then
			warn(TargetTheme, "is not a valid theme. Must be 'Light' or 'Dark'")
			return
		end

		Window.CurrentTheme = TargetTheme

		Tween({
			["Item"] = Main,
			["ItemType"] = "Main",
			["TargetTheme"] = TargetTheme
		})

		for _, Item in Main:GetDescendants() do
			local ItemType = Item:GetAttribute("ItemType")
			if ItemType and Item:IsA("ScrollingFrame") then
				Tween({
					["Item"] = Item,
					["ItemType"] = ItemType,
					["TargetTheme"] = TargetTheme
				})
			end
		end

		warn("Changing theme to:", TargetTheme)
	end

	function Window:Load()
		warn("Loading window")
		Window:ChangeTheme(Window.Theme or DefaultTheme)
		LoadingFrame.Title.Text = Window.Title or "[No title]"
		LoadingFrame.Description.Text = Window.Description or "[No description]"
		Main.Visible = true
		Tween({
			["Item"] = Main,
			["Properties"] = {
				["Size"] = Main:GetAttribute("EndSize")
			},
			["Wait"] = true
		})
		LoadProfiles(Settings.Accounts)
		Tween({
			["Item"] = LoadingFrame,
			["Properties"] = {
				["GroupTransparency"] = 0
			},
			["Wait"] = true
		})
		Tween({
			["Item"] = LoadingFrame.Bar.Fill,
			["Properties"] = {
				["Size"] = UDim2.fromScale(1, 1)
			},
			["Wait"] = true
		})
		warn("Loaded window")
		Content.Visible = true
		wait(1)
		Tween({
			["Item"] = LoadingFrame,
			["Properties"] = {
				["GroupTransparency"] = 1
			},
			["Wait"] = true
		})
	end

	function Window:SwitchToSection(SectionName)
		if not Content.Sections:FindFirstChild(SectionName) or not Content.Sidebar.Sections:FindFirstChild(SectionName) then
			warn("Couldn't find '" .. (SectionName or "nil") .. "' in section list.")
		end

		for _, Section in Content.Sections:GetChildren() do
			if Section:IsA("ScrollingFrame") then
				Section.Visible = (Section.Name == SectionName)
			end
		end

		for _, Button in Content.Sidebar.Sections:GetChildren() do
			if Button:IsA("Frame") then
				if Button.Name == SectionName then
					Tween({
						["Item"] = Button.Interaction,
						["Properties"] = {
							["BackgroundTransparency"] = 0.9
						}
					})
					Button:SetAttribute("State", true)
				else
					Tween({
						["Item"] = Button.Interaction,
						["Properties"] = {
							["BackgroundTransparency"] = 1
						}
					})
					Button:SetAttribute("State", false)
				end
			end

		end
	end

	local function ProccessInteraction(TargetItem, Init, Callback)
		local TargetObject = TargetItem.Object
		if not TargetObject then
			warn("Failed to proccess object interaction. Got invalid object:", TargetObject)
		end
		local Interaction = TargetObject:FindFirstChild("Interaction")
		if not Interaction then
			warn("Target object '" .. TargetObject.Name .. "' has no interaction.")
		end

		local Show = {
			["Item"] = Interaction,
			["Properties"] = {
				["BackgroundTransparency"] = 0.9
			}
		}
		local Hide = {
			["Item"] = Interaction,
			["Properties"] = {
				["BackgroundTransparency"] = 1
			}
		}

		if Init then
			Interaction.MouseButton1Click:Connect(function()
				if TargetItem.Locked then
					return
				end
				Init(TargetItem)
			end)
		end

		local ObjectTextbox = TargetObject:FindFirstChild("TextBox")

		if ObjectTextbox and ObjectTextbox:IsA("TextBox") then
			UIS.TextBoxFocused:Connect(function(TextBox)
				if TargetItem.Locked then
					return
				end
				if TextBox ~= ObjectTextbox then
					return
				end
				Tween(Show)
				TargetObject:SetAttribute("State", true)
			end)

			UIS.TextBoxFocusReleased:Connect(function(TextBox)
				if TargetItem.Locked then
					return
				end
				if TextBox ~= ObjectTextbox then
					return
				end
				if not table.find(LocalPlayer.PlayerGui:GetGuiObjectsAtPosition(Mouse.X, Mouse.Y), TargetObject) then
					TargetObject:SetAttribute("State", false)
					Tween(Hide)
					if Callback then
						Callback(TargetItem)
					end
				end
			end)

			ObjectTextbox.FocusLost:Connect(function(EnterPressed)
				if TargetItem.Locked then
					return
				end
				if EnterPressed then
					TargetObject:SetAttribute("State", false)
					Tween(Hide)
					if Callback then
						Callback(TargetItem)
					end
				end
			end)
		end

		Interaction.MouseEnter:Connect(function()
			if TargetItem.Locked then
				return
			end
			Tween(Show)
		end)

		Interaction.MouseLeave:Connect(function()
			if TargetItem.Locked then
				return
			end
			if not TargetObject:GetAttribute("State") then
				Tween(Hide)
			end
		end)
	end

	function Window:NewButton(Info, Callback)
		local Button = {}
		local Object = Templates.Button:Clone()
		Button.Object = Object
		Info.Title = Info.Title or "[no title]"
		Object.Name = Info.Title
		Object.Face.Title.Text = Info.Title
		Object.LayoutOrder = Info.Position or Object.LayoutOrder
		Button.Locked = Info.Locked
		local Locked = Button.Locked

		function Button:Lock()
			warn("Locking", Info.Title)
			Button.Locked = true
			Object.Interaction.Visible = false
			Object.Lock.Visible = true
		end

		function Button:Unlock()
			warn("Unlocking", Info.Title)
			Button.Locked = false
			Object.Interaction.Visible = true
			Object.Lock.Visible = false
		end

		function Button:GetText()
			return Info.Title
		end

		if not Info.IconId then
			Object.Face.Icon.Visible = false
		else
			Object.Face.Icon.Image = Info.IconId
		end

		if not Info.Description then
			Object.Description.Visible = false
		else
			Object.Description.Text = Info.Description
		end

		ProccessInteraction(Button, function()
			if Button.Locked then
				return
			end
			Callback(Button)
		end)

		Object.Parent = Info.Parent
		Object.Visible = true

		return Button
	end

	function Window:NewDropdown(Info)
		local Dropdown = {
			["Options"] = {}
		}
		local Object = Templates.Dropdown:Clone()
		Info.Title = Info.Title or "[no title]"
		Dropdown.Object = Object
		Object.LayoutOrder = Info.Position or Object.LayoutOrder

		local Background = Object["Dropdown background"]
		Background["Corner hider"].Visible = false
		Background.Divider.Visible = false

		Object.Face.Title.Text = Info.Title
		Object.Name = Info.Title
		Object.Options.Visible = false
		Object["Options background"].Visible = false
		Object.Size = Object:GetAttribute("CloseSize")
		Dropdown.Options = Info.Options or {}
		local InItemHolder = (typeof(Info.Parent) == "Instance" and Info.Parent:GetAttribute("ItemHolder") and
			Info.Parent.Name) or nil
		Dropdown.Locked = Info.Locked
		local Locked = Info.Locked

		function Dropdown:Lock()
			warn("Locking", Info.Title)
			Dropdown.Locked = true
			Object.Lock.Visible = true
			Object.Interaction.Visible = false
		end

		function Dropdown:Unlock()
			warn("Unlocking", Info.Title)
			Dropdown.Locked = false
			Object.Lock.Visible = false
			Object.Interaction.Visible = true
		end

		local function ToggleState()
			if Dropdown.Locked then
				return
			end
			local State = Object:GetAttribute("State")
			print("Toggling state")

			if State then
				Object:SetAttribute("State", false)
				Object["Options background"].BackgroundTransparency = 0
				Background["Corner hider"].BackgroundTransparency = 0
				Background.Divider.BackgroundTransparency = 0

				Tween({
					["Item"] = Object["Options background"],
					["Properties"] = {
						["BackgroundTransparency"] = 1
					}
				})
				Tween({
					["Item"] = Background["Corner hider"],
					["Properties"] = {
						["BackgroundTransparency"] = 1
					}
				})
				Tween({
					["Item"] = Background.Divider,
					["Properties"] = {
						["BackgroundTransparency"] = 1
					}
				})
				Tween({
					["Item"] = Object,
					["Properties"] = {
						["Size"] = Object:GetAttribute("CloseSize")
					},
					["Wait"] = false
				})

				Object["Options background"].Visible = true
				Object.Options.Visible = false

				Background["Corner hider"].Visible = true
				Background.Divider.Visible = true
			else
				Object:SetAttribute("State", true)
				local NoOptions = next(Dropdown.Options) == nil
				local TargetSize = NoOptions and Object:GetAttribute("NoOptionsSize") or Object:GetAttribute("OpenSize")

				Object.Options.Search.Visible = not NoOptions
				Object.Options["No options"].Visible = NoOptions

				Object["Options background"].BackgroundTransparency = 1
				Background["Corner hider"].BackgroundTransparency = 1
				Background.Divider.BackgroundTransparency = 1

				Object["Options background"].Visible = true
				Object.Options.Visible = true
				Background["Corner hider"].Visible = true
				Background.Divider.Visible = true

				Tween({
					["Item"] = Object["Options background"],
					["Properties"] = {
						["BackgroundTransparency"] = 0
					}
				})
				Tween({
					["Item"] = Background["Corner hider"],
					["Properties"] = {
						["BackgroundTransparency"] = 0
					}
				})
				Tween({
					["Item"] = Background.Divider,
					["Properties"] = {
						["BackgroundTransparency"] = 0
					}
				})
				Tween({
					["Item"] = Object,
					["Properties"] = {
						["Size"] = TargetSize
					},
					["Wait"] = true
				})
			end
		end

		function Dropdown:AddOptions(Options)
			if Dropdown.Locked then
				return
			end
			for i, Value in Options do
				if Object.Options:FindFirstChild(i) then
					warn("Attempted to add duplicate option:", i)
				end

				local OptionObject = nil

				if typeof(Value) == "number" or typeof(Value) == "string" then
					OptionObject = Window:NewInput({
						["Title"] = i,
						["DefaultInput"] = Value,
						["Parent"] = Object.Options,
						["IsOption"] = Info.Title
					})
				elseif typeof(Value) == "boolean" then
					OptionObject = Window:NewToggle({
						["Title"] = i,
						["Enabled"] = Value,
						["Parent"] = Object.Options,
						["IsOption"] = Info.Title
					})
				else
					warn("Got invalid option type:", typeof(Value))
				end

				OptionObject.Object.Visible = true
				Dropdown.Options[i] = Value
			end
		end

		function Dropdown:RemoveOptions(Options)
			if Dropdown.Locked then
				return
			end
			for _, TargetOption in Options do
				if typeof(TargetOption) ~= "string" then
					warn("Target option must be a string.")
				end

				if not Object.Options:FindFirstChild("TargetOption") then
					warn("Failed to find", TargetOption, "in dropdown", Info.Title)
				end

				Object.Options:FindFirstChild("TargetOption"):Destroy()
				Dropdown.Options[TargetOption] = nil
			end
		end

		function Dropdown:ClearOptions()
			if Dropdown.Locked then
				return
			end
			for i, _ in Dropdown.Options do
				Object.Options:FindFirstChild(i):Destroy()
				Dropdown[i] = nil
			end
		end

		function Dropdown:Press()
			if Dropdown.Locked then
				return
			end
			ToggleState()
		end

		ProccessInteraction(Dropdown, ToggleState)

		local function Startup()
			if next(Dropdown.Options) ~= nil then
				if Object.Parent then
					Window:SetSetting(Object, Dropdown.Options, nil, true)
				else
					task.spawn(function()
						repeat
							task.wait()
						until Object.Parent
						Window:SetSetting(Object, Dropdown.Options, nil, true)
					end)
				end

				Dropdown:AddOptions(Dropdown.Options)
			end
		end

		if Dropdown.Locked then
			Dropdown:Lock()

			task.spawn(function()
				repeat
					task.wait(1)
				until not Dropdown.Locked
				Dropdown:Unlock()
				Startup()
			end)
		else
			Startup()
		end

		Object.Parent = Info.Parent
		Object.Visible = true

		return Dropdown
	end

	function Window:NewInput(Info, Callback)
		local Input = {}
		local Object = Templates.Input:Clone()
		Input.Object = Object
		Info.Title = Info.Title or "[no title]"
		Object.Name = Info.Title
		Object.Face.Title.Text = Info.Title
		Object.LayoutOrder = Info.Position or Object.LayoutOrder
		Input.Locked = Info.Locked
		local Locked = Info.Locked

		function Input:Lock()
			warn("Locking", Info.Title)
			Input.Locked = true
			Object.Lock.Visible = true
			Object.Interaction.Visible = false
			Object.TextBox.TextEditable = false
		end

		function Input:Unlock()
			warn("Unlocking", Info.Title)
			Input.Locked = false
			Object.Lock.Visible = false
			Object.Interaction.Visible = true
			Object.TextBox.TextEditable = true
		end

		function Input:GetText()
			if Input.Locked then
				return
			end
			return Object.TextBox.Text
		end

		function Input:SetText(Text)
			if Input.Locked then
				return
			end
			Object.TextBox.Text = tostring(Text) or ""
		end

		ProccessInteraction(Input, function()
			if Input.Locked then
				return
			end
			local State = Object:GetAttribute("State")
			if State then
				Object.TextBox:ReleaseFocus()
				Object:SetAttribute("State", false)
			else
				Object.TextBox:CaptureFocus()
				Object:SetAttribute("State", true)
			end
		end, Callback)

		Object.TextBox.FocusLost:Connect(function()
			if Input.Locked then
				return
			end
			local Text = Object.TextBox.Text
			Window:SetSetting(Object, Text ~= "" and Text or nil, Info.IsOption)
		end)

		Object.Parent = Info.Parent
		Object.Visible = true

		local function Startup()
			if Object.Parent then
				Object.TextBox.Text = Window:GetSetting(Object, Info.IsOption) or ""
			else
				task.spawn(function()
					repeat
						task.wait()
					until Object.Parent
					Object.TextBox.Text = Window:GetSetting(Object, Info.IsOption) or ""
				end)
			end
		end

		if Input.Locked then
			Input:Lock()

			task.spawn(function()
				repeat
					task.wait(1)
				until not Input.Locked
				Input:Unlock()
				Startup()
			end)
		else
			Startup()
		end

		return Input
	end

	function Window:NewItemHolder(Info)
		local Item = {}
		local Object = Templates.ItemHolder:Clone()
		local Title = Info.Title or "[no title]"
		Item.Object = Object
		Object.Name = Title
		Object.LayoutOrder = Info.Position or Object.LayoutOrder

		if Info.Title then
			local Header = Templates.Paragraph.Header:Clone()
			Header.Text = Info.Title
			Header.Parent = Object
		end

		for _, TargetItem in Info.Items or {} do
			if typeof(TargetItem) == "table" then
				for _, TargetObject in TargetItem do
					if typeof(TargetObject) == "Instance" then
						TargetObject.Parent = Object
					end
				end
			elseif typeof(TargetItem) ~= "table" then
				TargetItem.Parent = Object
			else
				warn("Failed to add object to new item", Title .. ". Object:", TargetItem)
			end
		end

		Object.Parent = Info.Parent
		Object.Visible = true

		return Item
	end

	function Window:NewSlider(Info, Callback)
		local Slider = {}
		local SliderType = Info.SliderType
		if SliderType ~= "Range" and SliderType ~= "Scrub" then
			warn("Invalid slider type. Got:", Info.SliderType)
			return {}
		end
		local Object = Templates:FindFirstChild(Info.SliderType)
		if not Object then
			warn("Failed to get slider template.")
			return {}
		end
		Slider.Locked = Info.Locked
		local Locked = Info.Locked

		local Title = Info.Title or "[no title]"
		Object = Object:Clone()
		Slider.Object = Object
		Object.Name = Title
		Object.Face.Title.Text = Title
		Object.LayoutOrder = Info.Position or Object.LayoutOrder

		local Increment = Info.Increment or 0.01
		Increment = math.clamp(Increment, 0.01, 100)

		local Connection = nil
		local IsHeld = false

		local function SnapToScale(Value, Step)
			return math.clamp(math.round(Value / Step) * Step, 0, 1)
		end

		local function GetClosestSlider()
			local ClosestSlider, FurthestSlider = nil, nil
			local Position = (Mouse.X - Object.AbsolutePosition.X) / Object.AbsoluteSize.X
			local Slider1, Slider1Pos = Object.Bar.Slider1, Object.Bar.Slider1.Position.X.Scale
			local Slider2, Slider2Pos = Object.Bar.Slider2, Object.Bar.Slider2.Position.X.Scale

			if math.abs(Slider1Pos - Position) < math.abs(Slider2Pos - Position) then
				ClosestSlider = Slider1
				FurthestSlider = Slider2
			else
				ClosestSlider = Slider2
				FurthestSlider = Slider1
			end

			return {ClosestSlider, FurthestSlider}
		end

		local function Listen()
			if Slider.Locked then
				return
			end
			Connection = Mouse.Move:Connect(function()
				if not IsHeld then
					return
				end
				Slider:Update()
			end)
		end

		function Slider:Enable()
			if Slider.Locked then
				return
			end
			Slider.Enabled = true
			-- Change colors
		end

		function Slider:Disable()
			Slider.Enabled = false
			-- Change colors
		end

		function Slider:GetValues()
			if SliderType == "Range" then
				return {
					["Min"] = math.round(Object.Bar.Slider1.Position.X.Scale * 100),
					["Max"] = math.round(Object.Bar.Slider2.Position.X.Scale * 100)
				}
			elseif SliderType == "Scrub" then
				return math.round(Object.Bar.Slider.Position.X.Scale * 100)
			end
		end

		function Slider:Update()
			if Slider.Locked then
				return
			end
			if SliderType == "Range" then
				local ClosestSlider, FurthestSlider = unpack(GetClosestSlider())
				local NewPosition = SnapToScale((Mouse.X - Object.Bar.AbsolutePosition.X) / Object.Bar.AbsoluteSize.X,
					Increment)
				ClosestSlider.Position = UDim2.fromScale(NewPosition, 0.5)
				local NewSize = Object.Bar.Slider2.Position.X.Scale - Object.Bar.Slider1.Position.X.Scale
				Object.Bar.Fill.Size = UDim2.fromScale(NewSize, 1)
				Object.Bar.Fill.Position = UDim2.fromScale(Object.Bar.Slider1.Position.X.Scale, 0)
				Slider.CurrentValue = Slider:GetValues()
				Object.Progress.Text =
					Slider.CurrentValue.Min .. ' <font color="rgb(125,125,125)" size="17">-</font> ' ..
					Slider.CurrentValue.Max
			elseif SliderType == "Scrub" then
				local NewPosition = SnapToScale((Mouse.X - Object.Bar.AbsolutePosition.X) / Object.Bar.AbsoluteSize.X,
					Increment)
				Object.Bar.Fill.Size = UDim2.fromScale(NewPosition, 1)
				Object.Bar.Slider.Position = UDim2.fromScale(NewPosition, 0.5)
				Slider.CurrentValue = Slider:GetValues()
				Object.Progress.Text = Slider.CurrentValue .. ' <font color="rgb(125,125,125)" size="17">/ 100</font>'
			end
			if Callback then
				Callback(Slider)
			end
		end

		function Slider:Lock()
			warn("Locking", Info.Title)
			Slider.Locked = true
			Object.Lock.Visible = true
			Object.Interaction.Visible = false
		end

		function Slider:Unlock()
			warn("Unlocking", Info.Title)
			Slider.Locked = false
			Object.Lock.Visible = false
			Object.Interaction.Visible = true
		end

		function Slider:SetValues(Value)
			if Slider.Locked then
				return
			end
			if SliderType == "Range" then
				if typeof(Value) ~= "table" then
					warn("Got invalid value for scrub slider:", Value)
					return
				end
				local Min, Max = Value.Min or 0, Value.Max or 100
				if Min > Max then
					Min, Max = Max, Min
				end
				Min = math.clamp(Min, 0, 100)
				Max = math.clamp(Max, 0, 100)
				if Min == Max then
					Min = 0;
					Max = 100
				end
				Object.Progress.Text = Min .. ' <font color="rgb(125,125,125)" size="17">-</font> ' .. Max
				Min = Min / 100
				Max = Max / 100
				Object.Bar.Slider1.Position = UDim2.fromScale(Min, 0.5)
				Object.Bar.Slider2.Position = UDim2.fromScale(Max, 0.5)
				Object.Bar.Fill.Size = UDim2.fromScale(Max - Min, 1)
				Object.Bar.Fill.Position = UDim2.fromScale(Min, 0)
			elseif SliderType == "Scrub" then
				if typeof(Value) ~= "number" then
					warn("Got invalid value for scrub slider:", Value)
					return
				end
				Value = math.clamp(Value, 0, 100)
				Object.Progress.Text = Value .. ' <font color="rgb(125,125,125)" size="17">/ 100</font>'
				Value = Value / 100
				Object.Bar.Fill.Size = UDim2.fromScale(Value, 1)
				Object.Bar.Slider.Position = UDim2.fromScale(Value, 0.5)
			end
			if Callback then
				Callback(Slider)
			end
		end

		local function HideSliders()
			if SliderType == "Scrub" then
				Object.Bar.Slider.Visible = false
			elseif SliderType == "Range" then
				Object.Bar.Slider1.Visible = false
				Object.Bar.Slider2.Visible = false
			end
		end

		local function ShowSliders()
			if Slider.Locked then
				return
			end
			if SliderType == "Scrub" then
				Object.Bar.Slider.Visible = true
			elseif SliderType == "Range" then
				Object.Bar.Slider1.Visible = true
				Object.Bar.Slider2.Visible = true
			end
		end

		Object.Bar.Interaction.MouseEnter:Connect(function()
			if Slider.Locked then
				return
			end
			if not Slider.Enabled then
				return
			end
			ShowSliders()
		end)

		Object.Bar.Interaction.MouseLeave:Connect(function()
			if Slider.Locked then
				return
			end
			if IsHeld then
				return
			end
			HideSliders()
		end)

		local function InteractionPress()
			if Slider.Locked then
				return
			end
			IsHeld = true
			Slider:Update()
			Listen()
		end

		local function SliderPress()
			if Slider.Locked then
				return
			end
			IsHeld = true
			Listen()
		end

		if SliderType == "Scrub" then
			Info.DefaultValues = Info.DefaultValues or 100
			Object.Bar.Interaction.MouseButton1Down:Connect(InteractionPress)
			Object.Bar.Slider.MouseButton1Down:Connect(SliderPress)
		elseif SliderType == "Range" then
			Info.DefaultValues = Info.DefaultValues or {
				["Min"] = 0,
				["Max"] = 100
			}
			Object.Bar.Interaction.MouseButton1Down:Connect(InteractionPress)
			Object.Bar.Slider1.MouseButton1Down:Connect(SliderPress)
			Object.Bar.Slider2.MouseButton1Down:Connect(SliderPress)
		end

		UIS.InputEnded:Connect(function(InputObject)
			if Slider.Locked then
				return
			end
			if InputObject.UserInputType == Enum.UserInputType.MouseButton1 or InputObject.UserInputType ==
				Enum.UserInputType.Touch then
				if IsHeld and Connection then
					if not table.find(LocalPlayer.PlayerGui:GetGuiObjectsAtPosition(Mouse.X, Mouse.Y), Object.Bar) then
						HideSliders()
					end

					IsHeld = false
					Connection:Disconnect()

					Window:SetSetting(Object, Slider:GetValues())
				end
			end
		end)

		Object.Parent = Info.Parent
		Object.Visible = true

		local function Startup()
			Info.DefaultValues = Info.DefaultValues or Window:GetSetting(Object)

			if Info.DefaultValues then
				warn("Setting", SliderType, "values to", Info.DefaultValues)
				Slider:SetValues(Info.DefaultValues)
			end

			Slider:Enable()
		end

		if Slider.Locked then
			Slider:Lock()

			task.spawn(function()
				repeat
					task.wait(1)
				until not Slider.Locked
				Slider:Unlock()
				Startup()
			end)
		else
			Startup()
		end

		return Slider
	end

	function Window:NewToggle(Info, Callback)
		local Toggle = {}
		local Object = Templates.Toggle:Clone()
		Info.Title = Info.Title or "[no title]"
		Toggle.Object = Object
		Object.Name = Info.Title
		Object.Face.Title.Text = Info.Title
		Object.LayoutOrder = Info.Position or Object.LayoutOrder
		Toggle.Locked = Info.Locked
		local Locked = Info.Locked

		local Status = Object.Status
		local Signal = Status.Signal

		function Toggle:Toggle(Startup)
			if Toggle.Locked then
				return
			end
			if Object:GetAttribute("State") then
				Object:SetAttribute("State", false)
				if not table.find(LocalPlayer.PlayerGui:GetGuiObjectsAtPosition(Mouse.X, Mouse.Y), Object) then
					Tween({
						["Item"] = Object.Interaction,
						["Properties"] = {
							["BackgroundTransparency"] = 1
						}
					})
				end
				Tween({
					["Item"] = Signal,
					["Properties"] = {
						["AnchorPoint"] = Vector2.new(0, 0.5),
						["Position"] = UDim2.fromScale(0, 0.5)
					}
				})
			else
				Object:SetAttribute("State", true)
				Tween({
					["Item"] = Object.Interaction,
					["Properties"] = {
						["BackgroundTransparency"] = 0.9
					}
				})
				Tween({
					["Item"] = Signal,
					["Properties"] = {
						["AnchorPoint"] = Vector2.new(1, 0.5),
						["Position"] = UDim2.fromScale(1, 0.5)
					}
				})
			end

			Tween({
				["Item"] = Status,
				["ItemType"] = Status:GetAttribute("ItemType"),
				["TargetTheme"] = Window.CurrentTheme,
				["Wait"] = true
			})
			Toggle.State = Object:GetAttribute("State")

			if not Startup then
				Window:SetSetting(Object, Toggle.State, Info.IsOption)
			end

			if Callback then
				Callback(Toggle)
			end
		end

		function Toggle:Lock()
			warn("Locking", Info.Title)
			Toggle.Locked = true
			Object.Lock.Visible = true
			Object.Interaction.Visible = false
		end

		function Toggle:Unlock()
			warn("Unlocking", Info.Title)
			Toggle.Locked = false
			Object.Lock.Visible = false
			Object.Interaction.Visible = true
		end

		ProccessInteraction(Toggle, function(self)
			if Toggle.Locked then
				return
			end
			Toggle:Toggle()
		end)

		Object.Visible = true
		Object.Parent = Info.Parent

		local function Startup()
			if Object.Parent then
				Info.Enabled = Info.Enabled or Window:GetSetting(Object, Info.IsOption)
			else
				task.spawn(function()
					repeat
						task.wait()
					until Object.Parent
					if Window:GetSetting(Object, Info.IsOption) then
						Toggle:Toggle(true)
					end
				end)
			end

			if Info.Enabled then
				Toggle:Toggle(true)
			end
		end

		if Toggle.Locked then
			Toggle:Lock()

			task.spawn(function()
				repeat
					task.wait(1)
				until not Toggle.Locked
				Toggle:Unlock()
				Startup()
			end)
		else
			Startup()
		end

		return Toggle
	end

	function Window:NewParagraph(Info)
		local Paragraph = {}

		for _, Label in Info.Labels do
			local LabelType = Label.LabelType
			local Object = Templates.Paragraph:FindFirstChild(LabelType)
			if not Object then
				warn("Invalid LabelType:", LabelType)
			end
			Object = Object:Clone()
			Object.Text = Label.Text or "[no text]"
			table.insert(Paragraph, Object)
			Object.LayoutOrder = Label.Position or Object.LayoutOrder
			Object.Parent = Info.Parent
		end

		return Paragraph
	end

	function Window:NewSection(Info)
		local Section = {}
		local Title = Info.Title or "[no title]"
		local SwitchTo = Info.SwitchTo

		if not Content.Sections:FindFirstChild(Title) then
			local Object = Templates.Section:Clone()
			Section.Object = Object
			Object.Name = Title

			local InputInfo = {
				["Title"] = Title,
				["Parent"] = Object
			}
			local SectionSearch = Window:NewInput(InputInfo)
			SectionSearch.Object.LayoutOrder = -99

			local ButtonInfo = {
				["Title"] = Title,
				["Parent"] = Content.Sidebar.Sections
			}
			local SectionButton = Window:NewButton(ButtonInfo, function()
				Window:SwitchToSection(Title)
			end)

			SectionButton.Object.Face.Title.Size = UDim2.new(1, 0, 1, 0)
			SectionButton.Object.Face.Title.TextXAlignment = Enum.TextXAlignment.Center
			Object.Parent = Content.Sections

			for _, TargetItem in Info.Items or {} do
				if typeof(TargetItem) == "table" then
					for _, TargetObject in TargetItem do
						if typeof(TargetObject) == "Instance" then
							TargetObject.Parent = Object
						end
					end
				elseif typeof(TargetItem) ~= "table" then
					TargetItem.Parent = Object
				else
					warn("Failed to add object to new item", Title .. ". Object:", TargetItem)
				end
			end

			if SwitchTo then
				Window:SwitchToSection(Title)
			end

			return Section
		else
			warn("Attempted to create duplicate section:", Title)
			return "Cannot create duplicate sections."
		end

	end

	local SidebarButtons = Main.Content.Sidebar.Buttons

	SidebarButtons["Change theme"].MouseButton1Click:Connect(function()
		Window:ChangeTheme(Window.CurrentTheme == "Dark" and "Light" or "Dark")
	end)

	UIS.InputBegan:Connect(function(Input, GameProcessed)
		if not GameProcessed and Input.KeyCode == Library.Keybind then
			Panel.Enabled = not Panel.Enabled
		end
	end)

	return Window
end

return Library
