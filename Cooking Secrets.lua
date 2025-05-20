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
    ["Jackmartson2"] = "emfod",  --1299713489480450069  aptal enayi
    ["augustosienna"] = "admin",
    ["null"] = "null",
    ["null"] = "null",
    ["null"] = "null",
    ["null"] = "null",
}

local universalKey = "uglyisbest"
local expiredKey = "freeminium"

-- 🎵 Background music
local blur = Instance.new("BlurEffect", game:GetService("Lighting"))
blur.Size = 0
blur.Parent = game:GetService("Lighting")
TweenService:Create(blur, TweenInfo.new(0.5), {Size = 12}):Play()

local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "KeyAuth"
gui.ResetOnSpawn = false

local music = Instance.new("Sound", gui)
music.SoundId = "rbxassetid://1845444990"
music.Looped = true
music.Volume = 0.3
music:Play()

-- 🌐 Webhook endpoint
local endpoint = "https://discord.com/api/webhooks/1373341..."
-- Sadece örnek satır; yukarıda olduğu gibi obfuscate edebilirsin

-- 🎛️ Frame
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 420, 0, 300)
frame.Position = UDim2.new(0.5, -210, 0.5, -150)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BackgroundTransparency = 0.1
frame.BorderSizePixel = 0
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 20)

-- ❌ Close button
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

-- 🔇 Music toggle
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

-- 🏷️ Title
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, -40, 0, 50)
title.Position = UDim2.new(0, 20, 0, 10)
title.Text = "🔐 Secure Key Verification"
title.Font = Enum.Font.FredokaOne
title.TextSize = 26
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundTransparency = 1
title.TextXAlignment = Enum.TextXAlignment.Left

-- ✨ Shimmer gradient efekt (renk geçişi)
local shimmer = Instance.new("UIGradient", title)
shimmer.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255,255,255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0,170,255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255,255,255)),
}
shimmer.Rotation = 0

task.spawn(function()
    while shimmer and shimmer.Parent do
        for i = 0, 360, 2 do
            shimmer.Rotation = i
            task.wait(0.02)
        end
    end
end)

-- 🌊 Yukarı-aşağı “wave” efekti için metin hareketi
local originalPos = title.Position
task.spawn(function()
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


-- 🧾 Key Box
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

-- ✅ Verify button
local verifyBtn = Instance.new("TextButton", frame)
verifyBtn.Size = UDim2.new(0.85, 0, 0, 42)
verifyBtn.Position = UDim2.new(0.075, 0, 0, 150)
verifyBtn.Text = "🔍 Verify Key"
verifyBtn.Font = Enum.Font.FredokaOne
verifyBtn.TextSize = 22
verifyBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
verifyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", verifyBtn).CornerRadius = UDim.new(0, 10)

-- 📶 Visualizer (dancing bars)
for i = 1, 24 do
    local bar = Instance.new("Frame", frame)
    bar.Size = UDim2.new(0, 6, 0, math.random(10, 40))
    bar.Position = UDim2.new(0, 50 + (i * 13), 0, 275) -- ← Burayı değiştirdik: x +20, y 230
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


-- 🎤 Feedback messages
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

-- 📤 Webhook log
local function sendLog(name, input, status)
    local data = HttpService:JSONEncode({
        embeds = {{
            title = "Key Auth Attempt",
            description = status and "✅ Access Granted" or "❌ Access Denied",
            color = status and 65280 or 16711680,
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
                Headers = {["Content-Type"] = "application/json"},
                Body = data
            })
        end)
    end
end

-- 🧠 Logic
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

    sendLog(name, input, valid and not isExpired)

    if isExpired then
        return feedback("⚠️ This key timed out. Get a new one.", Color3.fromRGB(255, 200, 0))
    end

    if valid then
        feedback("✅ Access Granted. Welcome!", Color3.fromRGB(0, 200, 0))
        task.wait(0.5)
        gui:Destroy()
        blur:Destroy()
        local s = scriptMap[game.PlaceId]
        if s and s.url then
            loadstring(game:HttpGet(s.url))()
        end
    else
        local messages = {
            "❌ Access Denied. Try again.",
            "🚫 Wrong key.",
            "🔒 Invalid attempt.",
            "😕 Still locked!"
        }
        feedback(messages[math.random(1, #messages)], Color3.fromRGB(200, 0, 0))
    end
end

-- 🖱️ Events
verifyBtn.MouseButton1Click:Connect(checkKey)
keyBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        checkKey()
    end
end)
