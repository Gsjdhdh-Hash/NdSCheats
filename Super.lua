-- Configuration
local autoTrain = true
local delayTime = 0.1

-- Services
local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local virtualUser = game:GetService("VirtualUser")
local localPlayer = players.LocalPlayer

-- Prevent multiple script instances
if _G.MuscleBeachScriptRunning then
    return
else
    _G.MuscleBeachScriptRunning = true
end

-- Optimization
setfpscap(60)

-- Anti-AFK Feature (Runs automatically on startup)
localPlayer.Idled:Connect(function()
    virtualUser:CaptureController()
    virtualUser:ClickButton2(Vector2.new(0,0))
end)

-- Main Training Loop
task.spawn(function()
    while autoTrain and task.wait(delayTime) do
        -- Trigger lifting remote
        local liftRemote = replicatedStorage:FindFirstChild("LiftRemote") or replicatedStorage:FindFirstChild("TrainRemote")
        if liftRemote and liftRemote:IsA("RemoteEvent") then
            liftRemote:FireServer()
        end
        
        -- Trigger tool action
        local character = localPlayer.Character
        if character then
            local tool = character:FindFirstChildOfClass("Tool")
            if tool then
                tool:Activate()
            end
        end
    end
end)
