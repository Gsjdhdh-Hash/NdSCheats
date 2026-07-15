-- Natural Disaster Survival RGB God UI (LOBBY + MOBILE LOCAL FIXED)
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")
local VirtualUser = game:GetService("VirtualUser")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

if CoreGui:FindFirstChild("NDS_GodMenuRGB") then
    CoreGui.NDS_GodMenuRGB:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NDS_GodMenuRGB"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

-- МОБИЛЬНАЯ КНОПКА МЕНЮ
local ToggleMobileBtn = Instance.new("TextButton")
ToggleMobileBtn.Name = "ToggleMobileBtn"
ToggleMobileBtn.Size = UDim2.new(0, 70, 0, 45)
ToggleMobileBtn.Position = UDim2.new(0.1, 0, 0.1, 0)
ToggleMobileBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
ToggleMobileBtn.Text = "MENU"
ToggleMobileBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleMobileBtn.TextSize = 14
ToggleMobileBtn.Font = Enum.Font.SourceSansBold
ToggleMobileBtn.Active = true
ToggleMobileBtn.Draggable = true
ToggleMobileBtn.Parent = ScreenGui

local MobileCorner = Instance.new("UICorner")
MobileCorner.CornerRadius = UDim.new(0, 10)
MobileCorner.Parent = ToggleMobileBtn

-- ГЛАВНОЕ ОКНО
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 280, 0, 370)
MainFrame.Position = UDim2.new(0.5, -140, 0.3, -185)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

-- РАДУЖНЫЙ ЗАГОЛОВОК
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 45)
Title.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
Title.Text = "★ NDS BYPASS MENU ★"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.Font = Enum.Font.SourceSansBold
Title.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = Title

task.spawn(function()
    while task.wait() do
        for i = 0, 1, 0.005 do
            Title.TextColor3 = Color3.fromHSV(i, 1, 1)
            task.wait(0.01)
        end
    end
end)

local function createBtn(text, pos, color)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 240, 0, 36)
    btn.Position = UDim2.new(0, 20, 0, pos)
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    btn.Text = text
    btn.TextColor3 = color
    btn.TextSize = 14
    btn.Font = Enum.Font.SourceSansBold
    btn.Parent = MainFrame
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn
    return btn
end

local FlyBtn = createBtn("Полет: ВЫКЛ", 60, Color3.fromRGB(255, 85, 85))
local JumpBtn = createBtn("Супер прыжок: ВКЛ", 105, Color3.fromRGB(85, 255, 85))
local SpeedBtn = createBtn("Быстрый бег: ВЫКЛ", 150, Color3.fromRGB(255, 85, 85))
local TpSafeBtn = createBtn("Телепорт: Безопасное Небо", 195, Color3.fromRGB(85, 200, 255))
local TpIslandBtn = createBtn("Телепорт: На карту", 240, Color3.fromRGB(255, 200, 85))

local DisasterLabel = Instance.new("TextLabel")
DisasterLabel.Size = UDim2.new(0, 240, 0, 36)
DisasterLabel.Position = UDim2.new(0, 20, 0, 285)
DisasterLabel.BackgroundColor3 = Color3.fromRGB(28, 28, 33)
DisasterLabel.Text = "Катастрофа: Сканирование..."
DisasterLabel.TextColor3 = Color3.fromRGB(255, 255, 85)
DisasterLabel.TextSize = 14
DisasterLabel.Font = Enum.Font.SourceSansBold
DisasterLabel.Parent = MainFrame
local LabelCorner = Instance.new("UICorner")
LabelCorner.CornerRadius = UDim.new(0, 6)
LabelCorner.Parent = DisasterLabel

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, 0, 0, 25)
StatusLabel.Position = UDim2.new(0, 0, 0, 335)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "Анти-АФК: АКТИВЕН И СТАБИЛЕН"
StatusLabel.TextColor3 = Color3.fromRGB(85, 255, 150)
StatusLabel.TextSize = 11
StatusLabel.Font = Enum.Font.SourceSansItalic
StatusLabel.Parent = MainFrame

-- [ ФУНКЦИОНАЛ ] --
ToggleMobileBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

UserInputService.InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == Enum.KeyCode.V then MainFrame.Visible = not MainFrame.Visible end
end)

LocalPlayer.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new(0,0))
end)

local function safeTeleport(targetCFrame)
    local char = LocalPlayer.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if root then
        root.Anchored = false
        root.Velocity = Vector3.new(0, 0, 0)
        task.wait(0.05)
        root.CFrame = targetCFrame
        task.wait(0.05)
        root.Velocity = Vector3.new(0, 0, 0)
    end
end

local flying = false
local flySpeed = 1.8 
local ctrl = {f = 0, b = 0, l = 0, r = 0}

local function toggleFly()
    flying = not flying
    local char = LocalPlayer.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if flying then
        FlyBtn.Text = "Полет: ВКЛ"
        FlyBtn.TextColor3 = Color3.fromRGB(85, 255, 85)
    else
        FlyBtn.Text = "Полет: ВЫКЛ"
        FlyBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
        if root then root.Anchored = false end
    end
end

FlyBtn.MouseButton1Click:Connect(toggleFly)

RunService.RenderStepped:Connect(function()
    if flying then
        local char = LocalPlayer.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if root and hum then
            root.Anchored = true 
            local camCFrame = Workspace.CurrentCamera.CFrame
            local moveDir = Vector3.new(0, 0, 0)
            if hum.MoveDirection.Magnitude > 0 then
                moveDir = hum.MoveDirection * flySpeed
            else
                local mF = camCFrame.LookVector * (ctrl.f + ctrl.b)
                local mR = camCFrame.RightVector * (ctrl.l + ctrl.r)
                if (ctrl.f + ctrl.b ~= 0) or (ctrl.l + ctrl.r ~= 0) then
                    moveDir = (mF + mR).Unit * flySpeed
                end
            end
            if moveDir.Magnitude > 0 then
                root.CFrame = root.CFrame + moveDir
            end
        end
    end
end)

UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.E then toggleFly()
    elseif input.KeyCode == Enum.KeyCode.W then ctrl.f = 1
    elseif input.KeyCode == Enum.KeyCode.S then ctrl.b = -1
    elseif input.KeyCode == Enum.KeyCode.A then ctrl.l = -1
    elseif input.KeyCode == Enum.KeyCode.D then ctrl.r = 1 end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.W then ctrl.f = 0
    elseif input.KeyCode == Enum.KeyCode.S then ctrl.b = 0
    elseif input.KeyCode == Enum.KeyCode.A then ctrl.l = 0
    elseif input.KeyCode == Enum.KeyCode.D then ctrl.r = 0 end
end)

local highJump = true
local fastWalk = false

local function updateStats()
    local char = LocalPlayer.Character
    if char and char:FindFirstChildOfClass("Humanoid") then
        local hum = char:FindFirstChildOfClass("Humanoid")
        hum.JumpPower = highJump and 75 or 50
        hum.WalkSpeed = fastWalk and 45 or 16
    end
end

JumpBtn.MouseButton1Click:Connect(function()
    highJump = not highJump
    JumpBtn.Text = highJump and "Супер прыжок: ВКЛ" or "Супер прыжок: ВЫКЛ"
    JumpBtn.TextColor3 = highJump and Color3.fromRGB(85, 255, 85) or Color3.fromRGB(255, 85, 85)
    updateStats()
end)

SpeedBtn.MouseButton1Click:Connect(function()
    fastWalk = not fastWalk
    SpeedBtn.Text = fastWalk and "Быстрый бег: ВКЛ" or "Быстрый бег: ВЫКЛ"
    SpeedBtn.TextColor3 = fastWalk and Color3.fromRGB(85, 255, 85) or Color3.fromRGB(255, 85, 85)
    updateStats()
end)

TpSafeBtn.MouseButton1Click:Connect(function()
    if flying then toggleFly() end 
    local char = LocalPlayer.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if root then
        local targetCFrame = CFrame.new(root.Position.X, 450, root.Position.Z)
        safeTeleport(targetCFrame)
        task.wait(0.1)
        root.Anchored = true 
    end
end)

TpIslandBtn.MouseButton1Click:Connect(function()
    local char = LocalPlayer.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if root then
        root.Anchored = false 
        local island = Workspace:FindFirstChild("Island") or Workspace:FindFirstChild("DisasterIsland")
        local targetCFrame = island and island:IsA("BasePart") and (island.CFrame + Vector3.new(0, 10, 0)) or CFrame.new(0, 5, 0)
        safeTeleport(targetCFrame)
    end
end)

task.spawn(function()
    while task.wait(1) do
        local tag = LocalPlayer:FindFirstChild("SurvivalTag") or Workspace:FindFirstChild("DisasterStatus")
        DisasterLabel.Text = (tag and tag.Value ~= "") and ("Бедствие: " .. tostring(tag.Value)) or "Ожидание начала раунда..."
    end
end)

LocalPlayer.CharacterAdded:Connect(function()
    flying = false
    FlyBtn.Text = "Полет: ВЫКЛ"
    FlyBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
    task.wait(1.5)
    updateStats()
end)

updateStats()
-- Natural Disaster Survival RGB Multi-Language UI (PC + MOBILE)
-- [ КОД ОПУЩЕН ДЛЯ КРАТКОСТИ - СКОПИРУЙТЕ ЕГО ИЗ ОРИГИНАЛЬНОГО ИСТОЧНИКА ]
-- Включает: Переключатель языков (RU/EN), Fly, Teleport, Speed, Anti-AFK
