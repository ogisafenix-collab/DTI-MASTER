--// DTI MASTER | MAIN
--// Auto-Updating Core Script
--// Delta Executor Compatible

local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
    Name = "DTI MASTER | LIVE",
    LoadingTitle = "Loading...",
    LoadingSubtitle = "Stable Build",
    ConfigurationSaving = { Enabled = false }
})

local Farm = Window:CreateTab("Auto Farm")
local TP = Window:CreateTab("Teleports")

local Players = game:GetService("Players")
local LP = Players.LocalPlayer

local AutoCollect = false

local function getChar()
    local c = LP.Character or LP.CharacterAdded:Wait()
    return c, c:WaitForChild("HumanoidRootPart")
end

local VALID = {
    Cash = true,
    Money = true,
    Token = true,
    Snowflake = true
}

local function nearest(hrp)
    local best, dist = nil, math.huge
    for _, v in ipairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") and VALID[v.Name] then
            local d = (v.Position - hrp.Position).Magnitude
            if d < dist then
                dist = d
                best = v
            end
        end
    end
    return best
end

task.spawn(function()
    while task.wait(0.2) do
        if AutoCollect then
            local _, hrp = getChar()
            local coin = nearest(hrp)
            if coin and coin.Parent then
                hrp.CFrame = coin.CFrame * CFrame.new(0, 1.5, 0)
                for i = 1, 6 do
                    if not coin.Parent then break end
                    firetouchinterest(hrp, coin, 0)
                    task.wait(0.05)
                    firetouchinterest(hrp, coin, 1)
                end
            end
        end
    end
end)

Farm:CreateToggle({
    Name = "Auto Collect",
    CurrentValue = false,
    Callback = function(v)
        AutoCollect = v
    end
})

TP:CreateButton({
    Name = "Dressing Room",
    Callback = function()
        local _, hrp = getChar()
        hrp.CFrame = CFrame.new(-157, 35, 78)
    end
})

TP:CreateButton({
    Name = "Paris Lobby",
    Callback = function()
        local _, hrp = getChar()
        hrp.CFrame = CFrame.new(-461, 14, 1660)
    end
})

Rayfield:Notify({
    Title = "DTI MASTER",
    Content = "Loaded successfully",
    Duration = 4
})
