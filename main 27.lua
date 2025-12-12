-- Auto-build Key System + Main GUI with Join Discord button on both GUIs
-- Join Discord button copies: https://discord.gg/X2WBMt2pS

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Remove old GUI if exists
if playerGui:FindFirstChild("AutoKeyGUI") then
    playerGui.AutoKeyGUI:Destroy()
end

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AutoKeyGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Helpers
local function makeUICorner(frame, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = radius or UDim.new(0, 12)
    corner.Parent = frame
end

local function addHoverEffect(button)
    local originalColor = button.BackgroundColor3
    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = originalColor:Lerp(Color3.fromRGB(150,150,150), 0.3)
    end)
    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = originalColor
    end)
end

-- ===== KEY INPUT FRAME =====
local keyFrame = Instance.new("Frame")
keyFrame.Name = "KeyFrame"
keyFrame.Size = UDim2.new(0, 350, 0, 250) -- increased height for Discord button
keyFrame.Position = UDim2.new(0.5, -175, -1, 0)
keyFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
keyFrame.Parent = screenGui
makeUICorner(keyFrame)

-- Slide-in tween for keyFrame
local slideTweenInfo = TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local slideTween = TweenService:Create(keyFrame, slideTweenInfo, {Position = UDim2.new(0.5, -175, 0.5, -125)})
slideTween:Play()

-- KeyBox
local keyBox = Instance.new("TextBox")
keyBox.Size = UDim2.new(0, 250, 0, 40)
keyBox.Position = UDim2.new(0.5, -125, 0, 20)
keyBox.PlaceholderText = "Enter Key..."
keyBox.Text = ""
keyBox.TextScaled = true
keyBox.ClearTextOnFocus = false
keyBox.BackgroundColor3 = Color3.fromRGB(60,60,60)
keyBox.TextColor3 = Color3.fromRGB(255,255,255)
keyBox.Parent = keyFrame
makeUICorner(keyBox)

-- Verify Button
local verifyButton = Instance.new("TextButton")
verifyButton.Size = UDim2.new(0, 120, 0, 40)
verifyButton.Position = UDim2.new(0.5, -60, 0, 70)
verifyButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
verifyButton.TextColor3 = Color3.fromRGB(255,255,255)
verifyButton.Text = "Verify Key"
verifyButton.TextScaled = true
verifyButton.Parent = keyFrame
makeUICorner(verifyButton)
addHoverEffect(verifyButton)

-- Get Key Button (keyFrame)
local getKeyButtonKeyFrame = Instance.new("TextButton")
getKeyButtonKeyFrame.Size = UDim2.new(0, 120, 0, 35)
getKeyButtonKeyFrame.Position = UDim2.new(0.5, -60, 0, 120)
getKeyButtonKeyFrame.BackgroundColor3 = Color3.fromRGB(80,80,80)
getKeyButtonKeyFrame.Text = "Get Key"
getKeyButtonKeyFrame.TextColor3 = Color3.fromRGB(255,255,255)
getKeyButtonKeyFrame.TextScaled = true
getKeyButtonKeyFrame.Parent = keyFrame
makeUICorner(getKeyButtonKeyFrame)
addHoverEffect(getKeyButtonKeyFrame)

-- Join Discord Button (keyFrame)
local discordButtonKeyFrame = Instance.new("TextButton")
discordButtonKeyFrame.Size = UDim2.new(0, 200, 0, 40)
discordButtonKeyFrame.Position = UDim2.new(0.5, -100, 0, 165)
discordButtonKeyFrame.Text = "Join Discord"
discordButtonKeyFrame.TextScaled = true
discordButtonKeyFrame.BackgroundColor3 = Color3.fromRGB(60,120,240)
discordButtonKeyFrame.TextColor3 = Color3.fromRGB(255,255,255)
discordButtonKeyFrame.Parent = keyFrame
makeUICorner(discordButtonKeyFrame)
addHoverEffect(discordButtonKeyFrame)

-- Status Label
local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, -20, 0, 25)
statusLabel.Position = UDim2.new(0, 10, 0, 210)
statusLabel.BackgroundTransparency = 1
statusLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
statusLabel.Text = ""
statusLabel.TextScaled = true
statusLabel.Parent = keyFrame

-- ===== MAIN GUI =====
local mainGUI = Instance.new("Frame")
mainGUI.Size = UDim2.new(0, 400, 0, 250)
mainGUI.Position = UDim2.new(0.5, -200, -1, 0)
mainGUI.BackgroundColor3 = Color3.fromRGB(30,30,30)
mainGUI.Visible = true
mainGUI.BackgroundTransparency = 1
mainGUI.Parent = screenGui
makeUICorner(mainGUI)

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -20, 0, 50)
title.Position = UDim2.new(0, 10, 0, 10)
title.BackgroundTransparency = 1
title.Text = "Sentry Script Loader"
title.TextScaled = true
title.TextColor3 = Color3.fromRGB(255,255,255)
title.Parent = mainGUI

-- Status Label (main GUI)
local mainStatus = Instance.new("TextLabel")
mainStatus.Size = UDim2.new(1, -20, 0, 30)
mainStatus.Position = UDim2.new(0, 10, 0, 130)
mainStatus.BackgroundTransparency = 1
mainStatus.TextColor3 = Color3.fromRGB(255,200,0)
mainStatus.Text = ""
mainStatus.TextScaled = true
mainStatus.Parent = mainGUI

-- Load Script Button
local loadScriptButton = Instance.new("TextButton")
loadScriptButton.Size = UDim2.new(0,200,0,40)
loadScriptButton.Position = UDim2.new(0.5,-100,0,180)
loadScriptButton.Text = "Load Script"
loadScriptButton.TextScaled = true
loadScriptButton.BackgroundColor3 = Color3.fromRGB(70,70,70)
loadScriptButton.TextColor3 = Color3.fromRGB(255,255,255)
loadScriptButton.Parent = mainGUI
makeUICorner(loadScriptButton)
addHoverEffect(loadScriptButton)

-- Join Discord Button (main GUI)
local discordButtonMain = Instance.new("TextButton")
discordButtonMain.Size = UDim2.new(0, 200, 0, 40)
discordButtonMain.Position = UDim2.new(0.5, -100, 0, 120)
discordButtonMain.Text = "Join Discord"
discordButtonMain.TextScaled = true
discordButtonMain.BackgroundColor3 = Color3.fromRGB(60,120,240)
discordButtonMain.TextColor3 = Color3.fromRGB(255,255,255)
discordButtonMain.Parent = mainGUI
makeUICorner(discordButtonMain)
addHoverEffect(discordButtonMain)

-- ===== BUTTON FUNCTIONALITY =====

-- Tween for main GUI slide+fade
local tweenInfo = TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local slideFadeTween = TweenService:Create(mainGUI, tweenInfo, {Position = UDim2.new(0.5,-200,0.5,-125), BackgroundTransparency = 0})

-- Verify Key Button
verifyButton.MouseButton1Click:Connect(function()
    local enteredKey = string.upper(keyBox.Text)
    if enteredKey == "SENTRY" then
        statusLabel.Text = "Key verified!"
        local bounceUp = TweenService:Create(keyFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = keyFrame.Position + UDim2.new(0,0,-0.02,0)})
        local bounceDown = TweenService:Create(keyFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = keyFrame.Position})
        bounceUp:Play()
        bounceUp.Completed:Connect(function()
            bounceDown:Play()
        end)
        task.wait(0.5)
        keyFrame.Visible = false
        slideFadeTween:Play()
    else
        statusLabel.Text = "Wrong key!"
    end
end)

-- Get Key Button (key GUI)
getKeyButtonKeyFrame.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard("https://rekonise.com/sentryhub-get-key-kehty")
        statusLabel.Text = "Copied to clipboard!"
    else
        statusLabel.Text = "Clipboard not supported."
    end
end)

-- Join Discord Buttons
discordButtonKeyFrame.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard("https://discord.gg/X2WBMt2pS")
        statusLabel.Text = "Discord link copied!"
    else
        statusLabel.Text = "Clipboard not supported."
    end
end)

discordButtonMain.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard("https://discord.gg/X2WBMt2pS")
        mainStatus.Text = "Discord link copied!"
    else
        mainStatus.Text = "Clipboard not supported."
    end
end)

-- Load Script Button
loadScriptButton.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/braydencoriano3-cmyk/NFL-universe-football-script/refs/heads/main/main.lua"))()
    mainGUI.Visible = false
end)