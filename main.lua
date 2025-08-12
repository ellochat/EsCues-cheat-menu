-- Safely load Rayfield
local success, RayfieldLib = pcall(function()
    return loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
end)

if not success or not RayfieldLib then
    warn("Failed to load Rayfield library.")
    return
end

-- Create UI window
local Window = RayfieldLib:CreateWindow({
    Name = "EsCue's Universal Cheat Menu",
    Icon = 0,
    LoadingTitle = "Entering the cheat menu!",
    LoadingSubtitle = "by @EscueGT on YouTube",
    ShowText = "Rayfield",
    Theme = "AmberGlow",
    ToggleUIKeybind = "K",

    ConfigurationSaving = {
        Enabled = true,
        FolderName = nil,
        FileName = "Escue cheat menu"
    },

    Discord = {
        Enabled = true,
        Invite = "JkUXvaYwvQ",
        RememberJoins = true
    },

    KeySystem = true,
    KeySettings = {
        Title = "EsCue's Key System",
        Subtitle = "(it's ez)",
        Note = "Join the Discord: https://discord.gg/JkUXvaYwvQ",
        FileName = "EsCueKey",
        SaveKey = true,
        GrabKeyFromSite = true,
        Key = { "https://pastebin.com/raw/skz86Q4h" }
    }
})

-- Create tab and section
local MainTab = Window:CreateTab("Main Tab", 10511856020)
MainTab:CreateSection("Main Features")

-- Notify execution
RayfieldLib:Notify({
    Title = "Executed!",
    Content = "Script executed successfully!",
    Duration = 5
})

-- WalkSpeed Slider
local WalkSpeedSlider = MainTab:CreateSlider({
    Name = "WalkSpeed",
    Range = {0, 500},
    Increment = 1,
    Suffix = "walk 👍",
    CurrentValue = 16,
    Flag = "WalkSpeedSlider",
    Callback = function(Value)
        local player = game.Players.LocalPlayer
        if player and player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.WalkSpeed = Value
        end
    end
})

-- Reset WalkSpeed Button
MainTab:CreateButton({
    Name = "Reset WalkSpeed",
    Callback = function()
        local player = game.Players.LocalPlayer
        if player and player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.WalkSpeed = 16
        end
        WalkSpeedSlider:Set(16)
    end
})

-- Infinite Jump Toggle
local infJumpConnection = nil
MainTab:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = false,
    Flag = "InfJump",
    Callback = function(Value)
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")

        if Value then
            infJumpConnection = game:GetService("UserInputService").JumpRequest:Connect(function()
                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end)
        else
            if infJumpConnection then
                infJumpConnection:Disconnect()
                infJumpConnection = nil
            end
        end
    end
})

-- Invincibility Toggle
local godmodeRunning = false
MainTab:CreateToggle({
    Name = "Invincibility",
    CurrentValue = false,
    Flag = "godmode",
    Callback = function(Value)
        local player = game.Players.LocalPlayer

        if Value then
            godmodeRunning = true
            task.spawn(function()
                while godmodeRunning do
                    if player.Character and player.Character:FindFirstChild("Humanoid") then
                        player.Character.Humanoid.Health = player.Character.Humanoid.MaxHealth
                    end
                    task.wait(0.5)
                end
            end)
        else
            godmodeRunning = false
        end
    end
})

-- Troll Tab
local TrollTab = Window:CreateTab("Trolls", nil)

-- Shared sound variable
local sound
TrollTab:CreateInput({
    Name = "Sound ID",
    CurrentValue = "",
    PlaceholderText = "Enter a Sound ID",
    RemoveTextAfterFocusLost = false,
    Flag = "SoundInput",
    Callback = function(Text)
        if sound then
            sound:Destroy()
        end
        sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://" .. Text
        sound.Volume = 5
        sound.Parent = workspace
    end
})

TrollTab:CreateButton({
    Name = "Play Sound",
    Callback = function()
        if sound then
            sound:Play()
        else
            RayfieldLib:Notify({
                Title = "Error",
                Content = "No sound loaded.",
                Duration = 4
            })
        end
    end
})

TrollTab:CreateButton({
    Name = "Stop Sound",
    Callback = function()
        if sound and sound.IsPlaying then
            sound:Stop()
        end
    end
})

-- Pre-made scripts
TrollTab:CreateButton({
    Name = "jerk it for r15",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/YZoglOyJ/raw"))()
    end
})

TrollTab:CreateButton({
    Name = "jerk it for r6",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/wa3v2Vgm/raw"))()
    end
})

-- Kill All button
TrollTab:CreateButton({
    Name = "Kill All",
    Callback = function()
        local Players = game:GetService("Players")
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr.Character and plr.Character:FindFirstChild("Humanoid") then
                plr.Character.Humanoid.Health = 0
            end
        end
    end
})

-- Kill specific player
local targetUsername = ""
TrollTab:CreateInput({
    Name = "Username",
    CurrentValue = "",
    PlaceholderText = "Enter a username",
    RemoveTextAfterFocusLost = false,
    Flag = "Input1",
    Callback = function(User)
        targetUsername = User
    end
})

TrollTab:CreateButton({
    Name = "Kill Player",
    Callback = function()
        local targetPlayer = game.Players:FindFirstChild(targetUsername)
        if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("Humanoid") then
            targetPlayer.Character.Humanoid.Health = 0
        else
            RayfieldLib:Notify({
                Title = "Error",
                Content = "Player not found or no Humanoid.",
                Duration = 4
            })
        end
    end
})
local player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local speed = FlySpeed

local bv, bg

local function startFlying()
    local character = player.Character or player.CharacterAdded:Wait()
    local root = character:WaitForChild("HumanoidRootPart")

    bv = Instance.new("BodyVelocity")
    bv.Name = "FlyVelocity"
    bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
    bv.Velocity = Vector3.zero
    bv.Parent = root

    bg = Instance.new("BodyGyro")
    bg.Name = "FlyGyro"
    bg.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
    bg.CFrame = root.CFrame
    bg.Parent = root

    RS:BindToRenderStep("FlyMovement", Enum.RenderPriority.Character.Value, function()
        if not player.Character then return end
        local root = player.Character:FindFirstChild("HumanoidRootPart")
        if not root or not bv or not bg then return end

        local moveDirection = Vector3.new()
        if UIS:IsKeyDown(Enum.KeyCode.W) then moveDirection += workspace.CurrentCamera.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.S) then moveDirection -= workspace.CurrentCamera.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.A) then moveDirection -= workspace.CurrentCamera.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.D) then moveDirection += workspace.CurrentCamera.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.Space) then moveDirection += Vector3.new(0,1,0) end
        if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then moveDirection -= Vector3.new(0,1,0) end

        bv.Velocity = moveDirection * speed
        bg.CFrame = workspace.CurrentCamera.CFrame
    end)
end

local function stopFlying()
    RS:UnbindFromRenderStep("FlyMovement")
    if bv then bv:Destroy() bv = nil end
    if bg then bg:Destroy() bg = nil end
end

local FlyToggle = MainTab:CreateToggle({
   Name = "Fly",
   CurrentValue = false,
   Flag = "ToggleFly",
   Callback = function(Value)
       if Value then
           startFlying()
       else
           stopFlying()
       end
   end,
})
local FlySpeedSlider = MainTab:CreateSlider({
   Name = "Fly speed",
   Range = {0, 500},
   Increment = 10,
   Suffix = "speed",
   CurrentValue = 10,
   Flag = "Slider1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(FlySpeed)
            
   end,
})
