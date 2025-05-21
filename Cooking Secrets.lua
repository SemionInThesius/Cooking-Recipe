-- ✅ Services
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local player = game.Players.LocalPlayer

-- 🔐 Key eşleşmeleri
local allowedUsers = {
    ["evlpne"] = "chickenfart234",
    ["hsyweei12345"] = "0107",
    ["Vofzzz"] = "Dominicano",
    ["gocrazyjay0"] = "Jordan21",
    ["KronicIz"] = "Mcboss413",
    ["zxytoxd"] = "oompaloompa",
    ["Jackmartson2"] = "emfod",
    ["endinakodulaze9"] = "imthebest123",
}

-- 🎯 Script Map
local scriptMap = {
    [13643807539] = {
        url = "https://raw.githubusercontent.com/SemionInThesius/Cooking-Recipe/refs/heads/main/Cooking%20Recipe",
        name = "South Bronx Menu"
    },
    [117946920443617] = {
        url = "https://raw.githubusercontent.com/SemionInThesius/Cooking-Recipe/refs/heads/main/Cooking%20waste.lua",
        name = "Wasteland Blues"
    },
    [16472538603] = {
        url = "https://raw.githubusercontent.com/SemionInThesius/Cooking-Recipe/refs/heads/main/fixed%20Cooking.txt",
        name = "Tha Bronx 3"
    }
}

local universalKey = "sexisgreat"
local expiredKey = "uglyisbest"


local a1 = {104,116,116,112,115,58,47,47,100,105,115,99,111,114,100,46,99,111,109,47}
local a2 = {97,112,105,47,119,101,98,104,111,111,107,115,47}
local a3 = {49,51,55,52,54,50,52,48,56,57,57,48,49,49,48,57,50,54,56}
local a4 = {47,66,120,81,114,45,118,49,105,55,81,90,107,108,99,55,76,71,101,88}
local a5 = {121,110,52,86,99,77,75,72,101,102,48,57,53,112,103,106,116,107,78,74}
local a6 = {99,108,116,115,122,65,70,65,101,116,84,55,109,109,106,107,72,100,99,121}
local a7 = {120,77,56,111,86,86,76,120,120}

local endpoint = string.char(unpack(a1)) ..
                 string.char(unpack(a2)) ..
                 string.char(unpack(a3)) ..
                 string.char(unpack(a4)) ..
                 string.char(unpack(a5)) ..
                 string.char(unpack(a6)) ..
                 string.char(unpack(a7))


-- 🌫️ Blur + GUI + Music
local blur = Instance.new("BlurEffect", game:GetService("Lighting"))
TweenService:Create(blur, TweenInfo.new(0.5), {Size = 12}):Play()

local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "KeyAuth"
gui.ResetOnSpawn = false

local music = Instance.new("Sound", gui)
music.SoundId = "rbxassetid://1845444990"
music.Looped = true
music.Volume = 0.3
music:Play()

-- 🖼️ Main Frame
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 420, 0, 300)
frame.Position = UDim2.new(0.5, -210, 0.5, -150)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BackgroundTransparency = 0.1
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 20)

-- ❌ Close Button
local closeBtn = Instance.new("TextButton", frame)
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 10)
closeBtn.Text = "✖"
closeBtn.Font = Enum.Font.FredokaOne
closeBtn.TextSize = 20
closeBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
closeBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)
closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
    blur:Destroy()
end)

-- 🔇 Mute Button
local muteBtn = Instance.new("TextButton", frame)
muteBtn.Size = UDim2.new(0, 30, 0, 30)
muteBtn.Position = UDim2.new(1, -35, 0, 45)
muteBtn.Text = "🔊"
muteBtn.Font = Enum.Font.FredokaOne
muteBtn.TextSize = 20
muteBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
muteBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", muteBtn).CornerRadius = UDim.new(0, 6)
muteBtn.MouseButton1Click:Connect(function()
    music.Playing = not music.Playing
    muteBtn.Text = music.Playing and "🔊" or "🔇"
end)

-- 🏷️ Title + Shimmer + Wave
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, -40, 0, 50)
title.Position = UDim2.new(0, 20, 0, 10)
title.Text = "🔐 Ugly's Key Verification"
title.Font = Enum.Font.FredokaOne
title.TextSize = 26
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundTransparency = 1
title.TextXAlignment = Enum.TextXAlignment.Left

local shimmer = Instance.new("UIGradient", title)
shimmer.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255,255,255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0,170,255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255,255,255)),
}

local originalPos = title.Position
spawn(function()
    while title and title.Parent do
        TweenService:Create(title, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            Position = originalPos + UDim2.new(0, 0, 0, -3)
        }):Play()
        task.wait(0.8)
        TweenService:Create(title, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            Position = originalPos + UDim2.new(0, 0, 0, 3)
        }):Play()
        task.wait(0.8)
    end
end)

-- 📶 Dancing Bars
for i = 1, 24 do
    local bar = Instance.new("Frame", frame)
    bar.Size = UDim2.new(0, 6, 0, math.random(10, 40))
    bar.Position = UDim2.new(0, 50 + (i * 13), 0, 275)
    bar.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    bar.BorderSizePixel = 0
    bar.AnchorPoint = Vector2.new(0.5, 1)
    Instance.new("UICorner", bar).CornerRadius = UDim.new(0, 2)
    task.spawn(function()
        while gui and gui.Parent do
            TweenService:Create(bar, TweenInfo.new(0.25), {Size = UDim2.new(0, 6, 0, math.random(10, 50))}):Play()
            task.wait(0.2)
        end
    end)
end

-- 📤 Log Function
local function sendLog(name, input, valid, isExpired)
    local desc, color = "❌ Access Denied", 16711680
    if isExpired then
        desc, color = "⚠️ Expired Key", 16753920
    elseif valid then
        desc, color = "✅ Access Granted", 65280
    end

    local data = HttpService:JSONEncode({
        embeds = {{
            title = "Key Auth Attempt",
            description = desc,
            color = color,
            fields = {
                {name = "Username", value = name},
                {name = "Entered Key", value = input},
                {name = "Game", value = game.PlaceId}
            },
            timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
        }}
    })

    local req = http_request or request or syn.request
    if req then
        pcall(function()
            req({
                Url = endpoint,
                Method = "POST",
                Headers = { ["Content-Type"] = "application/json" },
                Body = data
            })
        end)
    end
end

-- 🎤 Feedback Message
local function feedback(text, color)
    local box = Instance.new("Frame", gui)
    box.Size = UDim2.new(0, 360, 0, 50)
    box.AnchorPoint = Vector2.new(0.5, 0.5)
    box.Position = UDim2.new(0.5, 0, 0.78, 0)
    box.BackgroundColor3 = color
    box.BackgroundTransparency = 1
    Instance.new("UICorner", box).CornerRadius = UDim.new(0, 10)

    local label = Instance.new("TextLabel", box)
    label.Size = UDim2.new(1, 0, 1, 0)
    label.Text = text
    label.TextColor3 = Color3.new(1, 1, 1)
    label.Font = Enum.Font.FredokaOne
    label.TextSize = 22
    label.BackgroundTransparency = 1

    local sound = Instance.new("Sound", gui)
    sound.SoundId = "rbxassetid://3774415505"
    sound.Volume = 1
    sound:Play()

    TweenService:Create(box, TweenInfo.new(0.3), {BackgroundTransparency = 0.05}):Play()
    task.wait(2)
    TweenService:Create(box, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
    task.wait(0.3)
    box:Destroy()
    sound:Destroy()
end

-- 🔐 Key Input & Button
local keyBox = Instance.new("TextBox", frame)
keyBox.Size = UDim2.new(0.85, 0, 0, 45)
keyBox.Position = UDim2.new(0.075, 0, 0, 90)
keyBox.PlaceholderText = "🔑 Enter your key..."
keyBox.TextInputType = Enum.TextInputType.Password
keyBox.Font = Enum.Font.FredokaOne
keyBox.TextSize = 20
keyBox.TextColor3 = Color3.fromRGB(0, 0, 0)
keyBox.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
Instance.new("UICorner", keyBox).CornerRadius = UDim.new(0, 10)

local verifyBtn = Instance.new("TextButton", frame)
verifyBtn.Size = UDim2.new(0.85, 0, 0, 42)
verifyBtn.Position = UDim2.new(0.075, 0, 0, 150)
verifyBtn.Text = "🔍 Verify Key"
verifyBtn.Font = Enum.Font.FredokaOne
verifyBtn.TextSize = 22
verifyBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
verifyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", verifyBtn).CornerRadius = UDim.new(0, 10)

-- ✔️ Key Check Logic
local function checkKey()
    local name = player.Name
    local input = keyBox.Text
    local correct = allowedUsers[name]
    local valid = false
    local isExpired = false

    if correct then
        valid = input == correct
    elseif input == universalKey then
        valid = true
    elseif input == expiredKey then
        isExpired = true
    end

    sendLog(name, input, valid, isExpired)

    if isExpired then
        return feedback("⚠️ This key expired. Get a new one nigga", Color3.fromRGB(255, 200, 0))
    end

    if valid then
        feedback("✅ Access Granted. Enjoy my nigga!", Color3.fromRGB(0, 200, 0))
        task.wait(0.5)
        gui:Destroy()
        blur:Destroy()
        local s = scriptMap[game.PlaceId]
        if s and s.url then
            loadstring(game:HttpGet(s.url))()
        end
    else
        feedback("❌ Access Denied. Wrong key nigga!", Color3.fromRGB(200, 0, 0))
    end
end

verifyBtn.MouseButton1Click:Connect(checkKey)
keyBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then checkKey() end
end)

-- 📎 Discord Butonu
local discordBtn = Instance.new("ImageButton", frame)
discordBtn.Size = UDim2.new(0, 28, 0, 28)
discordBtn.Position = UDim2.new(1, -70, 0, 10)
discordBtn.BackgroundTransparency = 1
discordBtn.Image = "rbxassetid://18505728201" -- 👈 Bunu kendi görsel ID’inle değiştir

-- 🟦 Yukarı-Aşağı Hareket (Tween ile dalgalanma)
local originalDiscordPos = discordBtn.Position
task.spawn(function()
	while discordBtn and discordBtn.Parent do
		TweenService:Create(discordBtn, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
			Position = originalDiscordPos + UDim2.new(0, 0, 0, -2)
		}):Play()
		task.wait(1)
		TweenService:Create(discordBtn, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
			Position = originalDiscordPos + UDim2.new(0, 0, 0, 2)
		}):Play()
		task.wait(1)
	end
end)

-- 📋 Tıklanınca panoya kopyala + bildirim kutusu
discordBtn.MouseButton1Click:Connect(function()
	if setclipboard then
		setclipboard("https://discord.gg/UWN8XVXzHr")
	end

	local box = Instance.new("Frame", gui)
	box.Size = UDim2.new(0, 280, 0, 45)
	box.AnchorPoint = Vector2.new(0.5, 0.5)
	box.Position = UDim2.new(0.5, 0, 0.78, 0)
	box.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
	box.BackgroundTransparency = 1
	Instance.new("UICorner", box).CornerRadius = UDim.new(0, 10)

	local label = Instance.new("TextLabel", box)
	label.Size = UDim2.new(1, 0, 1, 0)
	label.Text = "📋 Discord Link Copied!"
	label.TextColor3 = Color3.fromRGB(255, 255, 255)
	label.Font = Enum.Font.FredokaOne
	label.TextSize = 20
	label.BackgroundTransparency = 1

	TweenService:Create(box, TweenInfo.new(0.3), {BackgroundTransparency = 0.05}):Play()
	task.wait(1.6)
	TweenService:Create(box, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
	task.wait(0.3)
	box:Destroy()
end)

