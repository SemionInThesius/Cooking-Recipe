-- FULL SCRIPT: WASTELAND BLUES - ALL-IN-ONE SYSTEM
-- Features: Scrap AutoFarm, MaxWeight, Fly, Third Person, AutoSell, Aimbot, Silent Aim, FOV Circle

local MacLib = loadstring(game:HttpGet("https://github.com/biggaboy212/Maclib/releases/latest/download/maclib.txt"))()
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Camera = workspace.CurrentCamera

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
LocalPlayer.CharacterAdded:Connect(function(char)
	Character = char
end)

local LootContainers = workspace:WaitForChild("Game_Main"):WaitForChild("LootContainers")
local validScrapItems = {"OilCar", "ScrapCar", "ExhaustCar", "RotOilCar"}



-- UTILS
local function enableNoclip()
	for _, part in pairs(Character:GetDescendants()) do
		if part:IsA("BasePart") then
			part.CanCollide = false
		end
	end
end

local function tpToContainer(part)
	local tpPos = part.Position + Vector3.new(0, 3, 0)
	local lookAt = part.Position
	Character:PivotTo(CFrame.new(tpPos, lookAt))
end


-- GUI
local Window = MacLib:Window({
	Title = "Ugly's Wasteland",
	Subtitle = "whoisthisugly",
	Size = UDim2.fromOffset(850, 600),
	DragStyle = 1,
	ShowUserInfo = false,
	Keybind = Enum.KeyCode.RightControl,
	AcrylicBlur = true,
})
-- Mouse Lock System (X toggle + always enforce)
local mouseLocked = true

RunService.RenderStepped:Connect(function()
	if mouseLocked then
		UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
	else
		UserInputService.MouseBehavior = Enum.MouseBehavior.Default
	end
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.KeyCode == Enum.KeyCode.X then
		mouseLocked = not mouseLocked
		Window:Notify({
			Title = "Mouse Lock",
			Description = mouseLocked and "Mouse locked to center (press X to toggle)" or "Mouse unlocked (press X to toggle)",
			Lifetime = 3
		})
	end
end)


local TabGroup = Window:TabGroup()
local AutoFarmTab = TabGroup:Tab({ Name = "AutoFarm", Image = "rbxassetid://18821914323" })
local GeneralTab = TabGroup:Tab({ Name = "General", Image = "rbxassetid://10734950309" })

local AutoFarmSection = AutoFarmTab:Section({ Side = "Left" })

local GunLootables = workspace:WaitForChild("Game_Main"):WaitForChild("GunLootables")
local gunOptions = {}
local selectedGun = nil


local GunTpSection = AutoFarmTab:Section({ Side = "Right" })

local function refreshGunDropdown()
	local freshList = {}
	for _, gun in ipairs(GunLootables:GetChildren()) do
		local weapon = gun:FindFirstChild("AssignedWeapon")
		local timer = gun:FindFirstChild("ItemLootTimer")
		if weapon and not timer then
			table.insert(freshList, weapon.Value)
		end
	end
	if #freshList > 0 then
		currentGunList = freshList
		if gunDropdown then
			gunDropdown:Destroy()  -- eski dropdown'u sil
		end
		gunDropdown = GunTpSection:Dropdown({
			Name = "Available Guns",
			Options = currentGunList,
			Default = currentGunList[1],
			Callback = function(selected)
				selectedGun = selected
			end
		})
	end
end

-- İlk başta oluştur
refreshGunDropdown()

-- Listeyi her 5 saniyede bir yenile
task.spawn(function()
	while true do
		task.wait(5)
		refreshGunDropdown()
	end
end)

-- TP tuşu
GunTpSection:Button({
	Name = "📍 TP to Gun",
	Callback = function()
		for _, gun in ipairs(GunLootables:GetChildren()) do
			local weapon = gun:FindFirstChild("AssignedWeapon")
			local timer = gun:FindFirstChild("ItemLootTimer")
			if weapon and weapon.Value == selectedGun and not timer then
				local targetPart = gun:FindFirstChild("PrimaryPart") or gun:FindFirstChildWhichIsA("BasePart")
				if targetPart then
					Character:PivotTo(targetPart.CFrame + Vector3.new(0, 3, 0))
					Character:WaitForChild("Humanoid"):ChangeState(Enum.HumanoidStateType.GettingUp)
					Character:WaitForChild("Humanoid"):ChangeState(Enum.HumanoidStateType.RunningNoPhysics)
					Window:Notify({
						Title = "TP to Gun",
						Description = "You were teleported to " .. selectedGun,
						Lifetime = 2
					})
				end
				break
			end
		end
	end
})

RunService.Stepped:Connect(function()
    
end)


local CombatSection = GeneralTab:Section({ Side = "Left" })
local ESPSection = GeneralTab:Section({ Side = "Right" })

local adminDetectionEnabled = false
local adminAlertPlayed = {}

-- Yeni ses (admin alarm)
local AdminAlarmSound = Instance.new("Sound", workspace)
AdminAlarmSound.SoundId = "rbxassetid://9062380528"
AdminAlarmSound.Volume = 1
AdminAlarmSound.Name = "AdminAlertSound"

-- GUI: ADMIN DETECTED yazısı (ekranın üst kısmı)
local screenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
screenGui.Name = "AdminWarningGui"
screenGui.ResetOnSpawn = false
screenGui.Enabled = false

local warningText = Instance.new("TextLabel", screenGui)
warningText.Size = UDim2.new(0.4, 0, 0.08, 0)
warningText.Position = UDim2.new(0.3, 0, 0.1, 0)
warningText.BackgroundTransparency = 1
warningText.Text = "🚨 ADMIN DETECTED 🚨"
warningText.TextColor3 = Color3.fromRGB(255, 0, 0)
warningText.TextStrokeTransparency = 0.3
warningText.Font = Enum.Font.GothamBlack
warningText.TextScaled = true
warningText.Visible = false

-- ESP tagları
local function markAdmin(player)
	local char = player.Character
	if not char then return end

	if not char:FindFirstChild("AdminESP") then
		-- Highlight
		local highlight = Instance.new("Highlight")
		highlight.Name = "AdminESP"
		highlight.FillColor = Color3.fromRGB(170, 0, 255)
		highlight.OutlineColor = Color3.new(1, 1, 1)
		highlight.OutlineTransparency = 0
		highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		highlight.Adornee = char
		highlight.Parent = char
	end

	if char:FindFirstChild("Head") and not char:FindFirstChild("AdminBillboard") then
		local bill = Instance.new("BillboardGui", char)
		bill.Name = "AdminBillboard"
		bill.Size = UDim2.new(0, 200, 0, 30)
		bill.StudsOffset = Vector3.new(0, 4, 0)
		bill.Adornee = char.Head
		bill.AlwaysOnTop = true

		local label = Instance.new("TextLabel", bill)
		label.Size = UDim2.new(1, 0, 1, 0)
		label.BackgroundTransparency = 1
		label.TextColor3 = Color3.fromRGB(255, 0, 255)
		label.TextStrokeTransparency = 0.5
		label.TextScaled = true

		local dept = player:FindFirstChild("PlayerDepartments")
		local role = dept and dept:FindFirstChild("[WB] Actors") and dept["[WB] Actors"]:FindFirstChild("Role")
		label.Text = role and ("ADMIN: " .. role.Value) or "ADMIN"
	end
end

-- ADMIN LOOP
task.spawn(function()
	while true do
		if adminDetectionEnabled then
			for _, player in pairs(Players:GetPlayers()) do
				if player ~= LocalPlayer and not adminAlertPlayed[player] then
					local dept = player:FindFirstChild("PlayerDepartments")
					if dept and dept:FindFirstChild("[WB] Actors") and dept["[WB] Actors"].Value == true then
						local roleVal = dept["[WB] Actors"]:FindFirstChild("Role")
						local roleText = roleVal and roleVal.Value or "Unknown Role"

						-- ESP ve UI
						markAdmin(player)

						-- Bildirim
						Window:Notify({
							Title = "⚠️ ADMIN DETECTED",
							Description = "👤 " .. player.Name .. "\n🎖️ Role: " .. roleText,
							Lifetime = 5
						})

						-- Ses ve ekran uyarısı
						AdminAlarmSound:Play()
						warningText.Visible = true
						screenGui.Enabled = true
						task.delay(5, function()
							warningText.Visible = false
							screenGui.Enabled = false
						end)

						adminAlertPlayed[player] = true
					end
				end
			end
		end
		task.wait(2)
	end
end)

-- TOGGLE: ESP Paneline
ESPSection:Toggle({
	Name = "🚨 Admin Detection System",
	Default = false,
	Callback = function(state)
		adminDetectionEnabled = state
		if not state then
			for _, player in pairs(Players:GetPlayers()) do
				local char = player.Character
				if char then
					if char:FindFirstChild("AdminESP") then char.AdminESP:Destroy() end
					if char:FindFirstChild("AdminBillboard") then char.AdminBillboard:Destroy() end
				end
			end
			adminAlertPlayed = {}
			warningText.Visible = false
			screenGui.Enabled = false
		end
	end,
})

-- LEVEL ESP MODULE
local levelEspEnabled = false

local function createLevelESP(player)
    local char = player.Character
    if not char or not char:FindFirstChild("Head") then return end

    if char:FindFirstChild("LevelESP") then return end

    local levelVal = player:FindFirstChild("PlayerStatistics") and player.PlayerStatistics:FindFirstChild("Level")
    if not levelVal then return end

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "LevelESP"
    billboard.Adornee = char.Head
    billboard.Size = UDim2.new(0, 100, 0, 20)
    billboard.StudsOffset = Vector3.new(0, 3.5, 0)
    billboard.AlwaysOnTop = true
    billboard.Parent = char

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(0, 255, 255)
    label.TextStrokeTransparency = 0.5
    label.TextScaled = true
    label.Text = "Level: " .. tostring(levelVal.Value)
    label.Parent = billboard

    -- Otomatik güncelleme
    levelVal:GetPropertyChangedSignal("Value"):Connect(function()
        label.Text = "Level: " .. tostring(levelVal.Value)
    end)
end

local function clearLevelESP()
    for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
        if player.Character and player.Character:FindFirstChild("LevelESP") then
            player.Character.LevelESP:Destroy()
        end
    end
end

local function toggleLevelESP(state)
    levelEspEnabled = state
    if not state then
        clearLevelESP()
        return
    end

    for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
        if player ~= game.Players.LocalPlayer then
            createLevelESP(player)
            player.CharacterAdded:Connect(function()
                task.wait(1)
                createLevelESP(player)
            end)
        end
    end

    game:GetService("Players").PlayerAdded:Connect(function(player)
        player.CharacterAdded:Connect(function()
            task.wait(1)
            createLevelESP(player)
        end)
    end)
end

ESPSection:Toggle({
    Name = "| Level ESP",
    Default = false,
    Callback = function(state)
        toggleLevelESP(state)
    end,
})



-- AIMBOT, SILENT AIM & ESP CONFIG
local Holding = false
local LockedTarget = nil
_G.AimbotEnabled = false
_G.CircleVisible = true
_G.CircleRadius = 150
_G.Smoothness = 0.05
_G.CircleThickness = 2
_G.AimPart = "Head"

local FOVCircle = Drawing.new("Circle")
FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
FOVCircle.Radius = _G.CircleRadius
FOVCircle.Filled = false
FOVCircle.Color = Color3.fromRGB(255, 255, 255)
FOVCircle.Visible = _G.CircleVisible
FOVCircle.Transparency = 0.7
FOVCircle.NumSides = 64
FOVCircle.Thickness = _G.CircleThickness

CombatSection:Toggle({
	Name = "| Aimbot",
	Default = false,
	Callback = function(enabled)
		_G.AimbotEnabled = enabled
	end,
})

CombatSection:Toggle({
	Name = "| FOV Circle",
	Default = true,
	Callback = function(enabled)
		_G.CircleVisible = enabled
		FOVCircle.Visible = enabled
	end,
})

CombatSection:Slider({
	Name = "FOV Radius",
	Default = 150,
	Minimum = 0,
	Maximum = 350,
	Callback = function(value)
		_G.CircleRadius = value
		FOVCircle.Radius = value
	end,
})

CombatSection:Slider({
	Name = "Smoothness",
	Default = 5,
	Minimum = 0,
	Maximum = 100,
	Callback = function(value)
		_G.Smoothness = value / 100
	end,
})

CombatSection:Slider({
	Name = "FOV Thickness",
	Default = 2,
	Minimum = 1,
	Maximum = 10,
	Callback = function(value)
		_G.CircleThickness = value
		FOVCircle.Thickness = value
	end,
})

CombatSection:Dropdown({
	Name = "Body Parts",
	Options = {"Head", "UpperTorso", "LowerTorso", "LeftLeg", "RightLeg", "LeftArm", "RightArm"},
	Default = "Head",
	Callback = function(part)
		_G.AimPart = part
	end,
})

local function GetClosestPlayer()
	local closest, dist = nil, _G.CircleRadius
	for _, plr in pairs(Players:GetPlayers()) do
		if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and plr.Character:FindFirstChild("Humanoid") and plr.Character.Humanoid.Health > 0 then
			local part = plr.Character:FindFirstChild(_G.AimPart)
			if part then
				local screenPos, onScreen = Camera:WorldToScreenPoint(part.Position)
				if onScreen then
					local mousePos = UserInputService:GetMouseLocation()
					local distFromMouse = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
					if distFromMouse < dist then
						dist = distFromMouse
						closest = part
					end
				end
			end
		end
	end
	return closest
end

UserInputService.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton2 then
		Holding = true
		LockedTarget = GetClosestPlayer()
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton2 then
		Holding = false
		LockedTarget = nil
	end
end)

RunService.RenderStepped:Connect(function()
	-- Silent Aim placeholder logic (you can hook raycasts or modify bullet direction here)
	if Holding and _G.AimbotEnabled and LockedTarget and LockedTarget.Parent then
		local pos = LockedTarget.Position
		local camPos = Camera.CFrame.Position
		local newCFrame = CFrame.new(camPos, pos)
		Camera.CFrame = Camera.CFrame:Lerp(newCFrame, _G.Smoothness)
	end
	if _G.CircleVisible then
		FOVCircle.Position = UserInputService:GetMouseLocation()
		FOVCircle.Radius = _G.CircleRadius
		FOVCircle.Thickness = _G.CircleThickness
		FOVCircle.Visible = true
	else
		FOVCircle.Visible = false
	end
end)

-- ESP TOGGLES
ESPSection:Toggle({
	Name = "| Boxes",
	Default = false,
	Callback = function(state)
		if state then loadstring(game:HttpGet('https://pastebin.com/raw/i9EFDTBn'))() end
	end,
})

ESPSection:Toggle({
	Name = "| Name",
	Default = false,
	Callback = function(state)
		if state then loadstring(game:HttpGet('https://pastebin.com/raw/eaXVeBdR'))() end
	end,
})

ESPSection:Toggle({
	Name = "| Health Bar",
	Default = false,
	Callback = function(state)
		if state then loadstring(game:HttpGet('https://pastebin.com/raw/RZ7kbGD6'))() end
	end,
})

ESPSection:Toggle({
	Name = "| Skeleton",
	Default = false,
	Callback = function(state)
		if state then loadstring(game:HttpGet('https://pastebin.com/raw/nRmXUbTA'))() end
	end,
})

ESPSection:Toggle({
	Name = "| Tracer",
	Default = false,
	Callback = function(state)
		if state then loadstring(game:HttpGet('https://pastebin.com/raw/pZaywk6y'))() end
	end,
})

ESPSection:Toggle({
	Name = "| Gun ESP",
	Default = false,
	Callback = function(state)
		if state then
			for _, player in pairs(Players:GetPlayers()) do
				if player ~= LocalPlayer then
					if player.Character and player.Character:FindFirstChildOfClass("Tool") then
						local tool = player.Character:FindFirstChildOfClass("Tool")
						local billboard = player.Character:FindFirstChild("ToolDisplay")
						if billboard then billboard:Destroy() end
						billboard = Instance.new("BillboardGui")
						billboard.Name = "ToolDisplay"
						billboard.Size = UDim2.new(0, 100, 0, 20)
						billboard.StudsOffset = Vector3.new(0, 3, 0)
						billboard.Adornee = player.Character:FindFirstChild("Head")
						billboard.AlwaysOnTop = true
						billboard.Parent = player.Character

						local label = Instance.new("TextLabel")
						label.Size = UDim2.new(1, 0, 1, 0)
						label.BackgroundTransparency = 1
						label.TextColor3 = Color3.new(1, 1, 0)
						label.TextStrokeTransparency = 0.5
						label.Text = tool.Name
						label.Parent = billboard
					end
				end
			end
		end
	end
})

ESPSection:Toggle({
	Name = "| Radar",
	Default = false,
	Callback = function(state)
		if state then loadstring(game:HttpGet('https://pastebin.com/raw/cGRig6ey'))() end
	end,
})

-- Autofarm Toggle
local autoFarm = false
AutoFarmSection:Toggle({
	Name = "Start Scrap AutoFarm",
	Default = false,
	Callback = function(state)
		autoFarm = state
		if autoFarm then
			task.spawn(function()
				while autoFarm do
					for _, container in ipairs(LootContainers:GetChildren()) do
						if not autoFarm then break end
						local lootFolder = container:FindFirstChild("Loot")
						if lootFolder and container.PrimaryPart then
							for _, item in ipairs(lootFolder:GetChildren()) do
								if table.find(validScrapItems, item.Name) then
									tpToContainer(container.PrimaryPart)
Character:WaitForChild("Humanoid"):ChangeState(Enum.HumanoidStateType.GettingUp)
Character:WaitForChild("Humanoid"):ChangeState(Enum.HumanoidStateType.RunningNoPhysics)
									enableNoclip()
									task.wait(0.25)
									local tickToggle = false
									local startTime = tick()
									while tick() - startTime < 1 and autoFarm do
										VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.F, false, game)
										task.wait(0.05)
										VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.F, false, game)
										if tickToggle then
											Camera.CFrame = Camera.CFrame * CFrame.Angles(math.rad(1), 0, 0)
										else
											Camera.CFrame = Camera.CFrame * CFrame.Angles(math.rad(-1), 0, 0)
										end
										tickToggle = not tickToggle
										task.wait(0.05)
									end
									break
								end
							end
						end
					end
					task.wait(1.2)
				end
			end)
		end
	end,
})

-- FULL SCRIPT: WASTELAND BLUES - AUTO MAIL FARM MODULE
-- Features: Mail Pickup, Mail Delivery, Camera Facing, Q/F Key Simulation

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local Camera = workspace.CurrentCamera

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

-- SETTINGS
local mailPickupPos = Vector3.new(-1584.816, 147.421, -2861.567)
local mailDeliveryPos = Vector3.new(2523.644, 148.996, -4680.395)

-- OBJECTS
local mailmanPart = workspace:GetChildren()[1251]:FindFirstChild("TraderPart")
local mailboxPart = workspace.PneumaMail_System.PneumaMail.Cylinder

-- FUNCTIONS
local function lookAt(target)
    if target then
        local camPos = Camera.CFrame.Position
        Camera.CFrame = CFrame.new(camPos, target.Position)
    end
end

local function holdKey(key, duration)
    for _ = 1, duration * 10 do
        VirtualInputManager:SendKeyEvent(true, key, false, game)
        task.wait(0.1)
    end
    VirtualInputManager:SendKeyEvent(false, key, false, game)
end

local function hasPackage()
    local backpack = LocalPlayer:FindFirstChild("Backpack")
    if not backpack then return false end
    for _, tool in ipairs(backpack:GetChildren()) do
        if tool:IsA("Tool") and tool.Name == "Package" then
            return true
        end
    end
    return false
end

local mailPrompt = workspace:WaitForChild("PneumaMail_System")
	:WaitForChild("PneumaMail")
	:WaitForChild("Cylinder")
	:WaitForChild("Attachment")
	:WaitForChild("ProximityPrompt")

mailPrompt.HoldDuration = 0
mailPrompt.MaxActivationDistance = 90




local function tpLook(pos, target)
    Character:PivotTo(CFrame.new(pos, target.Position))
    Character:WaitForChild("Humanoid"):ChangeState(Enum.HumanoidStateType.RunningNoPhysics)
    lookAt(target)
end

local function deliverPackages()
    local backpack = LocalPlayer:FindFirstChild("Backpack")
    if not backpack then return end

    for _, tool in ipairs(backpack:GetChildren()) do
        if tool:IsA("Tool") and tool.Name == "Package" then
            Character:WaitForChild("Humanoid"):EquipTool(tool)
            task.wait(0.3)
            tpLook(mailDeliveryPos, mailboxPart)
            task.wait(0.3)
            holdKey(Enum.KeyCode.E, 0.1)
            task.wait(0.5)
        end
    end
end

-- MAIN LOOP
task.spawn(function()
    while true do
        if _G.AutoMailFarm then
            if not hasPackage() then
                tpLook(mailPickupPos, mailmanPart)
                task.wait(0.5)
                holdKey(Enum.KeyCode.Q, 3)
            else
                deliverPackages()
                task.wait(1)
                tpLook(mailPickupPos, mailmanPart)
            end
        end
        task.wait(1.5)
    end
end)

-- UI TOGGLE
AutoFarmSection:Toggle({
    Name = "📬 Auto Mail Farm",
    Default = false,
    Callback = function(state)
        _G.AutoMailFarm = state
        Window:Notify({
            Title = "📦 Mail Delivery",
            Description = state and "Auto Mail Activated" or "Auto Mail Deactivated",
            Lifetime = 3
        })
    end
})



-- Max Weight
AutoFarmSection:Button({
	Name = "💪 Max Weight Hack",
	Callback = function()
		local inv = LocalPlayer:FindFirstChild("PlayerInventory")
		if inv and inv:FindFirstChild("MaxWeight") then
			inv.MaxWeight.Value = 99999999999
			print("✅ MaxWeight set")
			Window:Notify({
				Title = "Max Weight",
				Description = "Max Weight is now ∞",
				Lifetime = 3
			})
		end
	end,
})
AutoFarmSection:Button({
	Name = "🖱️ Mouse Lock Toggle",
	Callback = function()
		mouseLocked = not mouseLocked
		if mouseLocked then
			UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
			Window:Notify({
				Title = "Mouse Lock",
				Description = "Mouse locked to center (press X to toggle)",
				Lifetime = 3
			})
		else
			UserInputService.MouseBehavior = Enum.MouseBehavior.Default
			Window:Notify({
				Title = "Mouse Lock",
				Description = "Mouse unlocked (press X to toggle)",
				Lifetime = 3
			})
		end
	end,
})

-- Fly Toggle
local flying = false
local FLYING = false
local CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
local lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
local SPEED = 0
local flyKeyDown, flyKeyUp

local function FLY()
	FLYING = true
	local T = Character:WaitForChild("HumanoidRootPart")
	local BG = Instance.new('BodyGyro')
	local BV = Instance.new('BodyVelocity')
	BG.P = 9e4
	BG.Parent = T
	BV.Parent = T
	BG.maxTorque = Vector3.new(9e9, 9e9, 9e9)
	BG.cframe = T.CFrame
	BV.velocity = Vector3.new(0, 0, 0)
	BV.maxForce = Vector3.new(9e9, 9e9, 9e9)
	task.spawn(function()
		repeat task.wait()
			if CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0 then
				SPEED = 50
			elseif SPEED ~= 0 then
				SPEED = 0
			end

			if (CONTROL.L + CONTROL.R) ~= 0 or (CONTROL.F + CONTROL.B) ~= 0 or (CONTROL.Q + CONTROL.E) ~= 0 then
				BV.velocity = ((Camera.CFrame.lookVector * (CONTROL.F + CONTROL.B)) + ((Camera.CFrame * CFrame.new(CONTROL.L + CONTROL.R, (CONTROL.F + CONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - Camera.CFrame.p)) * SPEED
				lCONTROL = {F = CONTROL.F, B = CONTROL.B, L = CONTROL.L, R = CONTROL.R}
			else
				BV.velocity = Vector3.new(0, 0, 0)
			end
			BG.cframe = Camera.CFrame
		until not FLYING
		CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
		lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
		SPEED = 0
		BG:Destroy()
		BV:Destroy()
		Character:FindFirstChildOfClass('Humanoid').PlatformStand = false
	end)

	flyKeyDown = UserInputService.InputBegan:Connect(function(input)
		local key = input.KeyCode
		if key == Enum.KeyCode.W then CONTROL.F = 1
		elseif key == Enum.KeyCode.S then CONTROL.B = -1
		elseif key == Enum.KeyCode.A then CONTROL.L = -1
		elseif key == Enum.KeyCode.D then CONTROL.R = 1
		elseif key == Enum.KeyCode.E then CONTROL.Q = 2
		elseif key == Enum.KeyCode.Q then CONTROL.E = -2 end
	end)

	flyKeyUp = UserInputService.InputEnded:Connect(function(input)
		local key = input.KeyCode
		if key == Enum.KeyCode.W then CONTROL.F = 0
		elseif key == Enum.KeyCode.S then CONTROL.B = 0
		elseif key == Enum.KeyCode.A then CONTROL.L = 0
		elseif key == Enum.KeyCode.D then CONTROL.R = 0
		elseif key == Enum.KeyCode.E then CONTROL.Q = 0
		elseif key == Enum.KeyCode.Q then CONTROL.E = 0 end
	end)
end

local function UNFLY()
	FLYING = false
	if flyKeyDown then flyKeyDown:Disconnect() end
	if flyKeyUp then flyKeyUp:Disconnect() end
	if Character:FindFirstChildOfClass('Humanoid') then
		Character:FindFirstChildOfClass('Humanoid').PlatformStand = false
	end
end

AutoFarmSection:Toggle({
	Name = "🛸 Fly Mode (WASD+QE)",
	Default = false,
	Callback = function(state)
		if state then FLY() else UNFLY() end
	end,
})

-- Third Person Button
AutoFarmSection:Button({
	Name = "🎥 Third Person Mode",
	Callback = function()
		LocalPlayer.CameraMode = Enum.CameraMode.Classic
		print("🎮 Third Person activated")
	end,
})

-- Auto Sell Button (TP to Wasteland Buyer & Q Press)
local sellThreshold = 20

AutoFarmSection:Slider({
	Name = "Sell Threshold",
	Default = 20,
	Minimum = 1,
	Maximum = 200,
	Callback = function(val)
		sellThreshold = val
	end,
})

AutoFarmSection:Button({
	Name = "💰 Auto Sell Scrap",
	Callback = function()
		local junkFolder = LocalPlayer:FindFirstChild("PlayerInventory") and LocalPlayer.PlayerInventory:FindFirstChild("Junk")
		if not junkFolder or #junkFolder:GetChildren() < sellThreshold then
			Window:Notify({
				Title = "Auto Sell",
				Description = "Not enough Junk items to sell (need " .. sellThreshold .. ")",
				Lifetime = 3
			})
			return
		end

		local sellCFrame = CFrame.new(-1199.2003, 146.197357, -2839.69507, 0.81645, -6.50977e-08, -0.57741, 1.15305e-07, 1, 5.02995e-08, 0.57741, -1.07646e-07, 0.81645)
		Character:PivotTo(sellCFrame)
		Character:WaitForChild("Humanoid"):ChangeState(Enum.HumanoidStateType.GettingUp)
		Character:WaitForChild("Humanoid"):ChangeState(Enum.HumanoidStateType.RunningNoPhysics)
		task.wait(0.3)

		local prompt = workspace:GetChildren()[403]:FindFirstChild("TraderPart", true)
		if prompt then
			local attachment = prompt:FindFirstChild("Attachment")
			if attachment then
				local proximityPrompt = attachment:FindFirstChild("ProximityPrompt")
				if proximityPrompt then
					proximityPrompt.MaxDistance = 100
					proximityPrompt.HoldDuration = 0
				end
			end
		end

		for _ = 1, 10 do
			VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Q, false, game)
			task.wait(0.05)
			VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
			task.wait(0.05)
		end
		print("✅ AutoSell executed")
	end,
})

-- GUN MODS SECTION
local GunModsSection = AutoFarmTab:Section({ Side = "Right" })

local currentSettings = {
    BaseDMG = 32,
    Recoil = 0.9,
    Firerate = 550,
    AmmoPerMag = 16,
    BulletSpread = 0.1,
    DmgBoost = 1.05,
    ShotgunFire = false
}

local function applyGunSettings()
    local backpack = LocalPlayer:FindFirstChild("Backpack")
    if not backpack then return end

    for _, tool in ipairs(backpack:GetChildren()) do
        if tool:IsA("Tool") and tool:FindFirstChild("SETTINGS") then
            local success, module = pcall(require, tool.SETTINGS)
            if success and type(module) == "table" and module.ReturnAllSettings then
                local settingsArray = module.ReturnAllSettings()
                if type(settingsArray) == "table" then
                    for key, val in pairs(currentSettings) do
                        if settingsArray[key] ~= nil then
                            settingsArray[key] = val
                        end
                    end
                end
            end

            if tool:FindFirstChild("Ammo") then
                tool.Ammo.Value = currentSettings.AmmoPerMag
            elseif tool:FindFirstChild("CurrentAmmo") then
                tool.CurrentAmmo.Value = currentSettings.AmmoPerMag
            end
        end
    end

    print("✅ Gun settings applied to all guns in backpack.")
    Window:Notify({
        Title = "Gun Mods",
        Description = "All backpack guns updated.",
        Lifetime = 3
    })
end

for key, val in pairs(currentSettings) do
    if type(val) == "boolean" then
        GunModsSection:Toggle({
            Name = key,
            Default = val,
            Callback = function(state)
                currentSettings[key] = state
                applyGunSettings()
            end
        })
    else
        GunModsSection:Slider({
            Name = key,
            Default = val,
            Minimum = 0,
            Maximum = key == "BaseDMG" and 500 or key == "Firerate" and 2000 or key == "AmmoPerMag" and 999 or 10,
            Callback = function(value)
                currentSettings[key] = value
                applyGunSettings()
            end
        })
    end
end



