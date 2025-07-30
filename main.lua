-- Safely load Rayfield
local success, RayfieldLib = pcall(function()
    return loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
end)

if not success then
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
    Theme = "Default",
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
local InfoSection = MainTab:CreateSection("Info!")

-- Notify execution
RayfieldLib:Notify({
    Title = "Executed!",
    Content = "Script executed successfully!",
    Duration = 5
})

-- WalkSpeed Slider
MainTab:CreateSlider({
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
    end
})

-- Infinite Jump (with disconnect on toggle off)
local infJumpConnection = nil

MainTab:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = false,
    Flag = "InfJump",
    Callback = function(Value)
        if Value == true then
            -- Enable Infinite Jump
            local player = game.Players.LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()
            local humanoid = character:WaitForChild("Humanoid")

            local canJump = true
            local jumpCooldown = 0.1

            infJumpConnection = game:GetService("UserInputService").JumpRequest:Connect(function()
                if canJump then
                    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                    canJump = false
                    task.wait(jumpCooldown)
                    canJump = true
                        end
                    elseif Value == false then
                        return
                    end
                end
            end)
        else
            -- Disable Infinite Jump
            if infJumpConnection then
                infJumpConnection:Disconnect()
                infJumpConnection = nil
            end
        end
    end
})
