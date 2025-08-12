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
    Range = {0, 300},
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
