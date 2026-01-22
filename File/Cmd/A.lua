-- [[ HITBOX EXPANDER DISCORD V5 - MOBILE OPTIMIZED ]] --
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = Players.LocalPlayer

-- Global Variables
_G.HeadSize = 10
_G.Disabled = false
_G.EspEnabled = false
_G.HitboxColor = "Bright violet"
_G.TeamCheck = true

-- Notification
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Info";
    Text = "This script support all games.";
    Duration = 5;
})

-- UI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SilentExecute_Mobile"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
-- Ukuran diperkecil agar tidak mentok bawah layar (Ukuran HP Friendly)
MainFrame.Size = UDim2.new(0, 280, 0, 320) 
MainFrame.Position = UDim2.new(0.5, -140, 0.4, -160)
MainFrame.BackgroundColor3 = Color3.fromRGB(47, 49, 54)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

-- Header
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 35)
Header.BackgroundColor3 = Color3.fromRGB(32, 34, 37)
Header.BorderSizePixel = 0
Header.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "HITBOX EXPANDER"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Font = Enum.Font.Gotham
Title.TextSize = 12
Title.Parent = Header

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 22, 0, 22)
CloseBtn.Position = UDim2.new(1, -28, 0, 6)
CloseBtn.Text = "×"
CloseBtn.BackgroundColor3 = Color3.fromRGB(240, 71, 71)
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.Gotham
CloseBtn.Parent = Header
Instance.new("UICorner", CloseBtn)

local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 22, 0, 22)
MinBtn.Position = UDim2.new(1, -55, 0, 6)
MinBtn.Text = "-"
MinBtn.BackgroundColor3 = Color3.fromRGB(79, 84, 92)
MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinBtn.Font = Enum.Font.Gotham
MinBtn.Parent = Header
Instance.new("UICorner", MinBtn)

-- Scrolling Content (Dibuat fleksibel)
local Container = Instance.new("ScrollingFrame")
Container.Size = UDim2.new(1, -16, 1, -75) -- Menyisakan tempat untuk credit
Container.Position = UDim2.new(0, 8, 0, 42)
Container.BackgroundTransparency = 1
Container.CanvasSize = UDim2.new(0, 0, 0, 500) -- Konten di dalam bisa di scroll
Container.ScrollBarThickness = 2
Container.Parent = MainFrame

local UIList = Instance.new("UIListLayout")
UIList.Padding = UDim.new(0, 6)
UIList.Parent = Container

-- Size Input Compact
local SizeContainer = Instance.new("Frame")
SizeContainer.Size = UDim2.new(1, 0, 0, 35)
SizeContainer.BackgroundTransparency = 1
SizeContainer.Parent = Container

local SizeLabel = Instance.new("TextLabel")
SizeLabel.Size = UDim2.new(0.5, 0, 1, 0)
SizeLabel.Text = "Size Radius:"
SizeLabel.Font = Enum.Font.Gotham
SizeLabel.TextColor3 = Color3.fromRGB(185, 187, 190)
SizeLabel.BackgroundTransparency = 1
SizeLabel.TextXAlignment = Enum.TextXAlignment.Left
SizeLabel.Parent = SizeContainer

local SizeInput = Instance.new("TextBox")
SizeInput.Size = UDim2.new(0.4, 0, 0, 25)
SizeInput.Position = UDim2.new(0.55, 0, 0.15, 0)
SizeInput.BackgroundColor3 = Color3.fromRGB(64, 68, 75)
SizeInput.Text = "10"
SizeInput.TextColor3 = Color3.new(1,1,1)
SizeInput.Font = Enum.Font.Gotham
SizeInput.Parent = SizeContainer
Instance.new("UICorner", SizeInput)
SizeInput.FocusLost:Connect(function() _G.HeadSize = tonumber(SizeInput.Text) or 10 end)

-- Toggle Builder
local function AddToggle(name, default, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 35)
    btn.BackgroundColor3 = default and Color3.fromRGB(114, 137, 218) or Color3.fromRGB(64, 68, 75)
    btn.Text = name .. (default and ": ON" or ": OFF")
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.Gotham
    btn.Parent = Container
    Instance.new("UICorner", btn)
    
    local s = default
    btn.MouseButton1Click:Connect(function()
        s = not s
        btn.Text = name .. (s and ": ON" or ": OFF")
        btn.BackgroundColor3 = s and Color3.fromRGB(114, 137, 218) or Color3.fromRGB(64, 68, 75)
        callback(s)
    end)
end

AddToggle("Enable Hitbox", false, function(v) _G.Disabled = v end)
AddToggle("Chams ESP", false, function(v) _G.EspEnabled = v end)
AddToggle("Team Check", true, function(v) _G.TeamCheck = v end)

-- Dropdown Color
local Dropdown = Instance.new("Frame")
Dropdown.Size = UDim2.new(1, 0, 0, 35)
Dropdown.BackgroundColor3 = Color3.fromRGB(64, 68, 75)
Dropdown.ClipsDescendants = true
Dropdown.Parent = Container
Instance.new("UICorner", Dropdown)

local DropBtn = Instance.new("TextButton")
DropBtn.Size = UDim2.new(1, 0, 0, 35)
DropBtn.BackgroundTransparency = 1
DropBtn.Text = "Color: " .. _G.HitboxColor
DropBtn.TextColor3 = Color3.new(1,1,1)
DropBtn.Font = Enum.Font.Gotham
DropBtn.Parent = Dropdown

local DropScroll = Instance.new("ScrollingFrame")
DropScroll.Size = UDim2.new(1, 0, 0, 120)
DropScroll.Position = UDim2.new(0, 0, 0, 35)
DropScroll.BackgroundTransparency = 1
DropScroll.CanvasSize = UDim2.new(0, 0, 0, 2000)
DropScroll.ScrollBarThickness = 2
DropScroll.Parent = Dropdown

Instance.new("UIListLayout", DropScroll)

local isDropped = false
DropBtn.MouseButton1Click:Connect(function()
    isDropped = not isDropped
    TweenService:Create(Dropdown, TweenInfo.new(0.3), {Size = isDropped and UDim2.new(1, 0, 0, 155) or UDim2.new(1, 0, 0, 35)}):Play()
end)

local brickColors = {"Bright red", "Bright blue", "Bright green", "Bright yellow", "Bright violet", "White", "Black", "Really blue", "Really red", "New Yeller", "Lime green", "Hot pink", "Cyan", "Deep blue", "Maroon", "Gold", "Alder", "Dark green", "Royal blue", "Persimmon", "Medium blue", "Teal", "Pink", "Crimson", "Fog", "Ghost grey", "Flint", "Sand blue", "Sky blue", "Slime green", "Shamrock", "Sea green", "Electric blue", "Grape juice", "Plum", "Eggplant", "CGA brown", "Brick yellow", "Cool yellow", "Pastel blue", "Pastel green", "Pastel orange", "Pastel violet", "Baby blue", "Lilac", "Bright orange", "Earth orange", "Dark orange", "Reddish brown", "Camo", "Dark cold grey", "Artichoke", "Lapis", "Sand red", "Mulberry", "Fossil", "Burlap", "Beige", "Cocoa", "Mauve", "Sunrise", "Dusty Rose", "Copper", "Sand green", "Olive", "Navy blue", "Storm blue", "Steel blue", "Neon orange", "Pistachio", "Rose", "Magenta", "Deep orange", "Salmon", "Earth green", "Shadow blue", "Cinder", "Dusk", "Khaki", "Linen", "Lavender", "Silver"}

for _, name in pairs(brickColors) do
    local c = Instance.new("TextButton")
    c.Size = UDim2.new(1, 0, 0, 25)
    c.BackgroundTransparency = 1
    c.Text = name
    c.TextColor3 = Color3.new(0.8, 0.8, 0.8)
    c.Font = Enum.Font.Gotham
    c.Parent = DropScroll
    c.MouseButton1Click:Connect(function()
        _G.HitboxColor = name
        DropBtn.Text = "Color: " .. name
        isDropped = false
        Dropdown.Size = UDim2.new(1, 0, 0, 35)
    end)
end

-- Footer (Credit)
local CreditText = Instance.new("TextLabel")
CreditText.Size = UDim2.new(1, 0, 0, 25)
CreditText.Position = UDim2.new(0, 0, 1, -25)
CreditText.BackgroundColor3 = Color3.fromRGB(32, 34, 37)
CreditText.Text = "Made By @SilentExecute"
CreditText.TextColor3 = Color3.fromRGB(114, 137, 218)
CreditText.Font = Enum.Font.GothamMedium
CreditText.TextSize = 11
CreditText.Parent = MainFrame

-- [[ LOGIC ]] --
RunService.RenderStepped:Connect(function()
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            local isTeammate = _G.TeamCheck and v.Team == LocalPlayer.Team and v.Team ~= nil
            local hrp = v.Character.HumanoidRootPart
            local high = v.Character:FindFirstChild("Highlight")

            if _G.Disabled and not isTeammate then
                hrp.Size = Vector3.new(_G.HeadSize, _G.HeadSize, _G.HeadSize)
                hrp.Transparency = 0.7
                hrp.BrickColor = BrickColor.new(_G.HitboxColor)
                hrp.Material = Enum.Material.Neon
                hrp.CanCollide = false
            else
                hrp.Size = Vector3.new(2, 2, 1)
                hrp.Transparency = 1
            end

            if _G.EspEnabled and not isTeammate then
                if not high then high = Instance.new("Highlight", v.Character) end
                high.FillColor = BrickColor.new(_G.HitboxColor).Color
            else
                if high then high:Destroy() end
            end
        end
    end
end)

-- [[ UNIVERSAL DRAG ]] --
local dragToggle, dragStart, startPos
MainFrame.InputBegan:Connect(function(input)
    if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
        dragToggle = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragToggle and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then dragToggle = false end
end)

MinBtn.MouseButton1Click:Connect(function()
    local isMin = MainFrame.Size.Y.Offset < 100
    TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = not isMin and UDim2.new(0, 280, 0, 35) or UDim2.new(0, 280, 0, 320)}):Play()
    Container.Visible = isMin
    CreditText.Visible = isMin
end)

CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)
