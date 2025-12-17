local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")
local cam = workspace.CurrentCamera

local screen = Instance.new("ScreenGui")
screen.Name = "NFLUniverseHub"
screen.Parent = player:WaitForChild("PlayerGui")
screen.ResetOnSpawn = false

local main = Instance.new("Frame")
main.Size = UDim2.new(0, 550, 0, 280)
main.Position = UDim2.new(0.5, 0, 0.5, 0)
main.AnchorPoint = Vector2.new(0.5,0.5)
main.BackgroundColor3 = Color3.fromRGB(30,30,30)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = screen
Instance.new("UICorner", main).CornerRadius = UDim.new(0,15)

local header = Instance.new("TextLabel")
header.Size = UDim2.new(1,0,0,45)
header.Position = UDim2.new(0,0,0,0)
header.BackgroundTransparency = 1
header.Text = "NFL Universe Hub"
header.Font = Enum.Font.GothamBold
header.TextSize = 22
header.TextColor3 = Color3.fromRGB(255,255,255)
header.Parent = main

local toggleMain = Instance.new("TextButton")
toggleMain.Size = UDim2.new(0,100,0,28)
toggleMain.Position = UDim2.new(1, -110, 0, 8)
toggleMain.Text = "Hide GUI"
toggleMain.BackgroundColor3 = Color3.fromRGB(50,50,50)
toggleMain.TextColor3 = Color3.fromRGB(255,255,255)
toggleMain.Parent = main
Instance.new("UICorner", toggleMain).CornerRadius = UDim.new(0,8)

local guiVisible = true
toggleMain.MouseButton1Click:Connect(function()
    guiVisible = not guiVisible
    main.Visible = guiVisible
    toggleMain.Text = guiVisible and "Hide GUI" or "Show GUI"
end)

local tabBar = Instance.new("Frame")
tabBar.Size = UDim2.new(1, -20, 0, 32)
tabBar.Position = UDim2.new(0,10,0,50)
tabBar.BackgroundTransparency = 1
tabBar.Parent = main

local tabLayout = Instance.new("UIListLayout", tabBar)
tabLayout.FillDirection = Enum.FillDirection.Horizontal
tabLayout.Padding = UDim.new(0,5)
tabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
tabLayout.VerticalAlignment = Enum.VerticalAlignment.Center

local tabNames = {"Movement","Player","Camera","Fun","Visual"}
local pages = {}

for _,name in ipairs(tabNames) do
    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1, -20, 1, -90)
    page.Position = UDim2.new(0,10,0,85)
    page.BackgroundTransparency = 1
    page.ScrollBarThickness = 6
    page.Visible = false
    page.Parent = main

    local layout = Instance.new("UIListLayout")
    layout.FillDirection = Enum.FillDirection.Vertical
    layout.Padding = UDim.new(0,6)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = page

    pages[name] = page
end

pages["Movement"].Visible = true

for _,name in ipairs(tabNames) do
    local btn = Instance.new("TextButton")
    btn.Text = name
    btn.Size = UDim2.new(0,90,0,28)
    btn.BackgroundColor3 = Color3.fromRGB(45,45,45)
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.Parent = tabBar
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,8)

    btn.MouseButton1Click:Connect(function()
        for _,p in pairs(pages) do p.Visible = false end
        pages[name].Visible = true
    end)
end

local function createToggle(parent,text,callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0,200,0,28)
    btn.BackgroundColor3 = Color3.fromRGB(50,50,50)
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.Text = text.." [OFF]"
    btn.Parent = parent
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,8)

    local state = false
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.Text = text.." ["..(state and "ON" or "OFF").."]"
        callback(state)
    end)
end

local function createSlider(parent,text,min,max,default,callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1,0,0,35)
    frame.BackgroundTransparency = 1
    frame.Parent = parent

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1,0,0,15)
    label.Position = UDim2.new(0,0,0,0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(255,255,255)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 14
    label.Text = text.." "..default
    label.Parent = frame

    local slider = Instance.new("TextBox")
    slider.Size = UDim2.new(1,0,0,20)
    slider.Position = UDim2.new(0,0,0,15)
    slider.BackgroundColor3 = Color3.fromRGB(50,50,50)
    slider.TextColor3 = Color3.fromRGB(255,255,255)
    slider.Text = tostring(default)
    slider.ClearTextOnFocus = false
    slider.Font = Enum.Font.GothamBold
    slider.TextSize = 14
    slider.Parent = frame

    slider:GetPropertyChangedSignal("Text"):Connect(function()
        local val = tonumber(slider.Text)
        if val then
            if val < min then val = min end
            if val > max then val = max end
            label.Text = text.." "..val
            callback(val)
        end
    end)
end

createSlider(pages["Movement"], "WalkSpeed", 16, 500, hum.WalkSpeed, function(val) hum.WalkSpeed = val end)
createSlider(pages["Movement"], "JumpPower", 50, 500, hum.JumpPower, function(val) hum.JumpPower = val end)

createSlider(pages["Camera"], "FOV", 70, 120, cam.FieldOfView, function(val) cam.FieldOfView = val end)

createToggle(pages["Fun"], "Spin", function(on)
    task.spawn(function()
        while on and char.PrimaryPart do
            task.wait(0.05)
            char:SetPrimaryPartCFrame(char.PrimaryPart.CFrame * CFrame.Angles(0,0.25,0))
        end
    end)
end)

local autoChaseEnabled = false
createToggle(pages["Player"], "Auto Chase", function(on)
    autoChaseEnabled = on
end)

RunService.RenderStepped:Connect(function()
    if autoChaseEnabled then
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        local target, minDist = nil, math.huge
        for _,p in pairs(Players:GetPlayers()) do
            if p ~= player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local dist = (p.Character.HumanoidRootPart.Position - hrp.Position).Magnitude
                if dist < minDist then
                    minDist = dist
                    target = p
                end
            end
        end
        if target then
            local dir = (target.Character.HumanoidRootPart.Position - hrp.Position).Unit
            hrp.CFrame = hrp.CFrame + dir * 5
        end
    end
end)

local highlightEnabled = false
local function updateHighlights()
    for _,p in pairs(Players:GetPlayers()) do
        if p ~= player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = p.Character.HumanoidRootPart
            local highlight = hrp:FindFirstChild("Highlight") or Instance.new("Highlight", hrp)
            highlight.Adornee = hrp
            highlight.FillColor = Color3.fromRGB(255,0,0)
            highlight.FillTransparency = highlightEnabled and 0.5 or 1
        end
    end
end

createToggle(pages["Player"], "Highlight Players", function(on)
    highlightEnabled = on
    updateHighlights()
end)

Players.PlayerAdded:Connect(function()
    if highlightEnabled then
        task.wait(1)
        updateHighlights()
    end
end)