
-- == Key Validation GUI == --

local allowedUsers = {
    ["javer6578"] = "123",  -- Test key 1
    ["TestUser2"] = "TestKey456",  -- Test key 2
    ["TestUser3"] = "TestKey789"   -- Test key 3
}

local loggingWebhook = "https://discord.com/api/webhooks/your_webhook_url"

local UserInputKey = ""

-- Create GUI for key input
local KeyGUI = Instance.new("ScreenGui")
KeyGUI.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
KeyGUI.Name = "KeyInputGUI"

local background = Instance.new("Frame")
background.Parent = KeyGUI
background.Size = UDim2.new(0, 300, 0, 200)
background.Position = UDim2.new(0.5, -150, 0.5, -100)
background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
background.BackgroundTransparency = 0.5

local title = Instance.new("TextLabel")
title.Parent = background
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "Enter Key"
title.Font = Enum.Font.SourceSans
title.TextSize = 24
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundTransparency = 1

local keyInputBox = Instance.new("TextBox")
keyInputBox.Parent = background
keyInputBox.Size = UDim2.new(0, 250, 0, 40)
keyInputBox.Position = UDim2.new(0, 25, 0, 60)
keyInputBox.PlaceholderText = "Enter Key"
keyInputBox.ClearTextOnFocus = true
keyInputBox.TextInputType = Enum.TextInputType.Password

local submitButton = Instance.new("TextButton")
submitButton.Parent = background
submitButton.Size = UDim2.new(0, 250, 0, 40)
submitButton.Position = UDim2.new(0, 25, 0, 120)
submitButton.Text = "Submit"
submitButton.BackgroundColor3 = Color3.fromRGB(0, 122, 255)
submitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
submitButton.Font = Enum.Font.SourceSans

submitButton.MouseButton1Click:Connect(function()
    local actualName = game.Players.LocalPlayer.Name
    local enteredKey = keyInputBox.Text

    local correctKey = allowedUsers[actualName]
    local keyIsValid = (correctKey == enteredKey)

    sendLoginLog(actualName, enteredKey, keyIsValid)

    if not keyIsValid then
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Access Denied!",
            Text = "Key does not match your account.",
            Duration = 4
        })
        wait(2)
        game.Players.LocalPlayer:Kick("Access Denied: Wrong Key or Username.")
        return
    end

    KeyGUI:Destroy()
    loadHackGUIAndFeatures()
end)

function sendLoginLog(username, key, success)
    local HttpService = game:GetService("HttpService")
    local data = {
        ["embeds"] = {{
            ["title"] = "Key Check Log",
            ["description"] = success and "✅ Access Granted" or "❌ Access Denied",
            ["color"] = success and tonumber("0x00FF00") or tonumber("0xFF0000"),
            ["fields"] = {
                {["name"] = "Username", ["value"] = username},
                {["name"] = "Key", ["value"] = key},
                {["name"] = "Executor", ["value"] = identifyexecutor and identifyexecutor() or "Unknown"}
            },
            ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
        }}
    }
    local body = HttpService:JSONEncode(data)
    local headers = {["Content-Type"] = "application/json"}
    local request = http_request or request or syn.request

    request({
        Url = loggingWebhook,
        Method = "POST",
        Headers = headers,
        Body = body
    })
end

function loadHackGUIAndFeatures()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/SemionInThesius/Cooking-Recipe/refs/heads/main/Cooking%20Recipe"))()
end
