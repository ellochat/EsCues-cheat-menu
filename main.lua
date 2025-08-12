-- Safely load Rayfield
local success, RayfieldLibOrError = pcall(function()
    return loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
end)

if not success or not RayfieldLibOrError then
    warn("Failed to load Rayfield library:", RayfieldLibOrError)
    return
end

local RayfieldLib = RayfieldLibOrError

-- Create UI window
local Window = RayfieldLib:CreateWindow({
    Name = "EsCue's Universal Cheat Menu",
    LoadingTitle = "Loading...",
    LoadingSubtitle = "by EsCue",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "EsCueHub",
        FileName = "Config"
    },
    Discord = {
        Enabled = false,
        Invite = "",
        RememberJoins = true
    },
    KeySystem = true,
    KeySettings = {
        Title = "EsCue Hub",
        Subtitle = "Key System",
        Note = "Get key from pastebin",
        FileName = "EsCueKey",
        SaveKey = true,
        GrabKeyFromSite = true, -- if Rayfield supports grabbing from URL
        Key = "https://pastebin.com/raw/skz86Q4h" -- change if required
    }
})

local Tab = Window:CreateTab("Main", 4483362458)

--------------------------------------------------------
-- Fling Button
--------------------------------------------------------
Tab:CreateButton({
    Name = "Fling All",
    Callback = function()
        local function SkidFling(Target)
            if not Target.Character or not Target.Character:FindFirstChild("HumanoidRootPart") then return end

            local Char = game.Players.LocalPlayer.Character
            if not Char or not Char:FindFirstChild("HumanoidRootPart") then return end

            -- Weld accessories for more mass
            for _, Accessory in ipairs(Char:GetChildren()) do
                if Accessory:IsA("Accessory") and Accessory:FindFirstChild("Handle") then
                    Accessory.Handle.Massless = false
                end
            end

            -- Fling loop
            local BV = Instance.new("BodyVelocity")
            BV.Velocity = Vector3.new(0, 0, 0)
            BV.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            BV.Parent = Char.HumanoidRootPart

            task.spawn(function()
                while Target and Target.Parent do
                    BV.Velocity = (Target.Character.HumanoidRootPart.Position - Char.HumanoidRootPart.Position).Unit * 100
                    task.wait()
                end
                BV:Destroy()
            end)
        end

        for _, Player in ipairs(game.Players:GetPlayers()) do
            if Player ~= game.Players.LocalPlayer then
                SkidFling(Player)
            end
        end
    end
})

--------------------------------------------------------
-- Fly Toggle
--------------------------------------------------------
local flying = false
local speed = 100
local bodyGyro, bodyVel

local function startFly()
    local Char = game.Players.LocalPlayer.Character
    if not Char or not Char:FindFirstChild("HumanoidRootPart") then return end

    flying = true
    local HRP = Char.HumanoidRootPart

    bodyGyro = Instance.new("BodyGyro")
    bodyGyro.P = 9e4
    bodyGyro.Parent = HRP

    bodyVel = Instance.new("BodyVelocity")
    bodyVel.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    bodyVel.Velocity = Vector3.new()
    bodyVel.Parent = HRP

    game:GetService("RunService").RenderStepped:Connect(function()
        if not flying then return end
        local moveDirection = Vector3.new()

        local camera = workspace.CurrentCamera
        if game.UserInputService:IsKeyDown(Enum.KeyCode.W) then
            moveDirection += camera.CFrame.LookVector
        end
        if game.UserInputService:IsKeyDown(Enum.KeyCode.S) then
            moveDirection -= camera.CFrame.LookVector
        end
        if game.UserInputService:IsKeyDown(Enum.KeyCode.A) then
            moveDirection -= camera.CFrame.RightVector
        end
        if game.UserInputService:IsKeyDown(Enum.KeyCode.D) then
            moveDirection += camera.CFrame.RightVector
        end
        if game.UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            moveDirection += Vector3.new(0, 1, 0)
        end
        if game.UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
            moveDirection -= Vector3.new(0, 1, 0)
        end

        if moveDirection.Magnitude > 0 then
            moveDirection = moveDirection.Unit
        end

        bodyVel.Velocity = moveDirection * speed
        bodyGyro.CFrame = camera.CFrame
    end)
end

local function stopFly()
    flying = false
    if bodyGyro then bodyGyro:Destroy() end
    if bodyVel then bodyVel:Destroy() end
end

Tab:CreateToggle({
    Name = "Fly",
    CurrentValue = false,
    Flag = "FlyToggle",
    Callback = function(Value)
        if Value then
            startFly()
        else
            stopFly()
        end
    end
})
