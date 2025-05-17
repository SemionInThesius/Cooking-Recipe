local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local player = game.Players.LocalPlayer

-- 🔐 Kullanıcı Adı → Key eşleşmeleri
local allowedUsers = {
    ["Ranviralt2"] = "admin",
    ["pleasegimmeerwin"] = "stinkyfart32",
    ["cameronherbst"] = "Cam1226",
    ["Mahmutkrsgl"] = "1903",
    ["Mercy_emo"] = "1904",
    ["asyakrsgl"] = "1905",
    ["evlpne"] = "chickenfart234",
    ["hsyweei12345"] = "0107",
    ["Vofzzz"] = "Dominicano",
    ["gocrazyjay0"] = "Jordan21",
    ["KronicIz"] = "Mcboss413",
    ["zxytoxd"] = "oompaloompa",
    ["SebastianDuckMaster"] = "oompaloompa",
    ["BrooklynHaze12"] = "Poppaishere",
    ["WolfRavenLucky"] = "UncleTayy",
    ["Lebronjammes38"] = "lebronking33",
    ["benn_kaz"] = "sikicikanye",
    ["2xclusive_Tay"] = "Tayysob",
    ["leshenhazretleri"] = "1900",
    ["rjames1001"] = "Cam1563",
    ["MikaSwungU"] = "J@thegoat1",
    ["StopAimingOnAltz233"] = "collin453",
    ["kooldboys3"] = "UncleTayy",
    ["Kappadotty"] = "jjsploitisgreat",
    ["g8pvlbpzgiu9hc8mclv6"] = "keel",
    ["Camehgghgggf"] = "Jake1226",
    ["Leroy_980"] = "imthebest",
    ["Stealth_Omega2008"] = "TO6789",
    ["lerro700"] = "12345678",
    ["leroynot2krazy"] = "Thisistooez",
    ["R4GE_SEV"] = "sev123",
    ["finnadestroyaboss"] = "imgayngl",
    ["augustosienna"] = "collin999",
    ["XxSebastianMaxxX2017"] = "loompa",
    ["null"] = "null",
    ["null"] = "null",
    ["null"] = "null",
    ["null"] = "null",
    ["null"] = "null",
}

-- 🎮 Oyun ID → Script URL eşleşmesi
local scriptMap = {
    [10179538382] = "https://raw.githubusercontent.com/SemionInThesius/Cooking-Recipe/refs/heads/main/Cooking%20Recipe",
    [117946920443617] = "https://raw.githubusercontent.com/SemionInThesius/Cooking-Recipe/refs/heads/main/Cooking%20waste.lua"
}

-- 🕵️‍♂️ Webhook (gizli, parça parça kodlanmış)
local a1 = {104,116,116,112,115,58,47,47}
local a2 = {100,105,115,99,111,114,100,46,99,111,109}
local a3 = {47,97,112,105,47,119,101,98,104,111,111,107,115,47}
local a4 = {49,51,55,49,50,52,53,52,51,50,50,52,55,54,56,49,49,50,56}
local a5 = {47,80,51,87,108,71,101,54,49,81,107,97,73,84,110,74,105,105}
local a6 = {86,108,48,65,76,76,118,82,97,66,82,70,51,83,48,48,98,45}
local a7 = {82,80,83,120,49,118,89,121,72,51,75,118,87,107,90,118,116,83,122,112,55,101,83,52,114,65,72,54,69,116,118,79,122}
local webhookURL = string.char(unpack(a1))..string.char(unpack(a2))..string.char(unpack(a3))..string.char(unpack(a4))..string.char(unpack(a5))..string.char(unpack(a6))..string.char(unpack(a7))

-- 🌫️ Blur efekti
local blur = Instance.new("BlurEffect")
blur.Parent = game:GetService("Lighting")
TweenService:Create(blur, TweenInfo.new(0.5), {Size = 12}):Play()

-- 🧱 GUI setup
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "KeyAuth"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 380, 0, 260)
frame.Position = UDim2.new(0.5, -190, 0.5, -130)
frame.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 16)
TweenService:Create(frame, TweenInfo.new(0.4), {BackgroundTransparency = 0.1}):Play()

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, -40, 0, 50)
title.Position = UDim2.new(0, 20, 0, 10)
title.Text = "🔐 Key Verification"
title.Font = Enum.Font.GothamBold
title.TextSize = 22
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundTransparency = 1
title.TextXAlignment = Enum.TextXAlignment.Left

local keyBox = Instance.new("TextBox", frame)
keyBox.Size = UDim2.new(0.85, 0, 0, 40)
keyBox.Position = UDim2.new(0.075, 0, 0, 80)
keyBox.PlaceholderText = "Enter your access key..."
keyBox.TextInputType = Enum.TextInputType.Password
keyBox.Font = Enum.Font.Gotham
keyBox.TextSize = 18
keyBox.TextColor3 = Color3.fromRGB(0, 0, 0)
keyBox.BackgroundColor3 = Color3.fromRGB(235, 235, 235)
Instance.new("UICorner", keyBox).CornerRadius = UDim.new(0, 10)

-- ❌ Kapatma Butonu
local closeBtn = Instance.new("TextButton", frame)
closeBtn.Text = "X"
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 10)
closeBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
closeBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 20
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)

closeBtn.MouseButton1Click:Connect(function()
    TweenService:Create(frame, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
    TweenService:Create(blur, TweenInfo.new(0.3), {Size = 0}):Play()
    task.wait(0.3)
    gui:Destroy()
    blur:Destroy()
end)


local verifyBtn = Instance.new("TextButton", frame)
verifyBtn.Size = UDim2.new(0.85, 0, 0, 40)
verifyBtn.Position = UDim2.new(0.075, 0, 0, 145)
verifyBtn.Text = "Verify Key"
verifyBtn.Font = Enum.Font.GothamBold
verifyBtn.TextSize = 20
verifyBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
verifyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", verifyBtn).CornerRadius = UDim.new(0, 10)

-- 🧾 Webhook log fonksiyonu
local function sendLog(username, enteredKey, status)
    local color = status and 65280 or 16711680
    local embed = {
        ["title"] = "Key Auth Attempt",
        ["description"] = status and "✅ Access Granted" or "❌ Access Denied",
        ["color"] = color,
        ["fields"] = {
            {["name"] = "Username", ["value"] = username},
            {["name"] = "Entered Key", ["value"] = enteredKey},
            {["name"] = "Game ID", ["value"] = tostring(game.PlaceId)},
        },
        ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
    }
    local data = HttpService:JSONEncode({["embeds"] = {embed}})
    local req = http_request or request or syn.request
    pcall(function()
        req({
            Url = webhookURL,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = data
        })
    end)
end

-- ✅ Doğrulama ve script çalıştırma
local function checkKey()
    local name = player.Name
    local input = keyBox.Text
    local correct = allowedUsers[name]
    local valid = (input == correct)

    sendLog(name, input, valid)

    if not valid then
        player:Kick("Access Denied: Are you dumb you fucking nigger? you realy entered it wrong? bruhh just dont use it if you this dumb fr")
        return
    end

    -- 🎉 Access Granted UI + Ses
    local grantedFrame = Instance.new("Frame", gui)
    grantedFrame.Size = UDim2.new(0, 300, 0, 100)
    grantedFrame.Position = UDim2.new(0.5, -150, 0.5, -50)
    grantedFrame.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
    grantedFrame.BackgroundTransparency = 1
    Instance.new("UICorner", grantedFrame).CornerRadius = UDim.new(0, 10)

    local grantedLabel = Instance.new("TextLabel", grantedFrame)
    grantedLabel.Size = UDim2.new(1, 0, 1, 0)
    grantedLabel.BackgroundTransparency = 1
    grantedLabel.Text = "✅ Access Granted"
    grantedLabel.Font = Enum.Font.GothamBlack
    grantedLabel.TextSize = 28
    grantedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)

    local sound = Instance.new("Sound", gui)
    sound.SoundId = "rbxassetid://237877850"
    sound.Volume = 1
    sound:Play()

    TweenService:Create(grantedFrame, TweenInfo.new(0.4), {BackgroundTransparency = 0.1}):Play()
    task.wait(2)
    TweenService:Create(grantedFrame, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()
    task.wait(0.4)
    grantedFrame:Destroy()
    sound:Destroy()

    TweenService:Create(frame, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()
    TweenService:Create(blur, TweenInfo.new(0.4), {Size = 0}):Play()
    task.wait(0.5)
    gui:Destroy()
    blur:Destroy()

    local url = scriptMap[game.PlaceId]
    if url then
        loadstring(game:HttpGet(url))()
    else
        warn("No script assigned for this game.")
    end
end

-- 🔘 Tıklama ve ⌨️ Enter
verifyBtn.MouseButton1Click:Connect(checkKey)
keyBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        checkKey()
    end
end)
