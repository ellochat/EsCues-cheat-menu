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
local InfoSection = MainTab:CreateSection("i forgot what to put here")

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
        WalkSpeedSlider:Set(16) -- The new slider integer value
})

-- Infinite Jump Toggle (with disconnect on toggle off)
local infJumpConnection = nil

MainTab:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = false,
    Flag = "InfJump",
    Callback = function(Value)
        if Value == true then
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
            end)
        else
            if infJumpConnection then
                infJumpConnection:Disconnect()
                infJumpConnection = nil
            end
        end
    end
})

-- Invincibility Toggle (Godmode)
local godmodeRunning = false
local godmodeThread = nil

MainTab:CreateToggle({
    Name = "Invincibility",
    CurrentValue = false,
    Flag = "godmode",
    Callback = function(Value)
        local player = game.Players.LocalPlayer

        if Value == true then
            godmodeRunning = true
            godmodeThread = task.spawn(function()
                while godmodeRunning do
                    local character = player.Character
                    if character and character:FindFirstChild("Humanoid") then
                        local humanoid = character.Humanoid
                        -- Heal or prevent death
                        humanoid.Health = humanoid.MaxHealth
                    end
                    task.wait(0.5) -- Adjust as needed
                end
            end)
        else
            godmodeRunning = false
        end
    end
})
local TrollTab = Window:CreateTab("Trolls", nil)

-- Shared sound variable
local sound

local SoundInput = TrollTab:CreateInput({
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
        sound.Looped = false
        sound.Parent = workspace
    end,
})

local SoundButton = TrollTab:CreateButton({
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
    end,
})

local StopButton = TrollTab:CreateButton({
    Name = "Stop Sound",
    Callback = function()
        if sound and sound.IsPlaying then
            sound:Stop()
        end
    end,
})
local JerkR15Button = TrollTab:CreateButton({
   Name = "jerk it for r15",
   Callback = function()
   loadstring(game:HttpGet("https://pastefy.app/YZoglOyJ/raw"))()
   end,
})
local JerkR6Button = TrollTab:CreateButton({
   Name = "jerk it for r6",
   Callback = function()
   loadstring(game:HttpGet("https://pastefy.app/wa3v2Vgm/raw"))()
   end,
})
local killall = TrollTab:CreateButton({
   Name = "Kill All",
   Callback = function()
local Players = game:GetService("Players")

for _, player in ipairs(Players:GetPlayers()) do
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.Health = 0
    end
end

   end,
})
local UserInput = TrollTab:CreateInput({
   Name = "Username",
   CurrentValue = "",
   PlaceholderText = "Input Placeholder",
   RemoveTextAfterFocusLost = false,
   Flag = "Input1",
   Callback = function(User)
   -- The function that takes place when the input is changed
   -- The variable (Text) is a string for the value in the text box
   end,
})
local killSpecificButton = TrollTab:CreateButton({
   Name = "Button Example",
   Callback = function()
   local person = game.workspace:FindFirstChild(User)
            person.humanoid.Health = 0
   end,
})
