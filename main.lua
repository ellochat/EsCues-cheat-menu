local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))

local Window = Rayfield:CreateWindow({
   Name = "EsCue's universal cheat menu",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "Entering the cheat menu!",
   LoadingSubtitle = "by @EscueGT on youtube",
   ShowText = "Rayfield", -- for mobile users to unhide rayfield, change if you'd like
   Theme = "Default", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   ToggleUIKeybind = "K", -- The keybind to toggle the UI visibility (string like "K" or Enum.KeyCode)

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "Escue cheat menu"
   },

   Discord = {
      Enabled = true, -- Prompt the user to join your Discord server if their executor supports it
      Invite = "JkUXvaYwvQ", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the discord every time they load it up
   },

   KeySystem = true, -- Set this to true to use our key system
   KeySettings = {
      Title = "EsCue's Key System",
      Subtitle = "(its ez)",
      Note = "join the discord if you didnt already, invite is https://discord.gg/JkUXvaYwvQ link in the key tab", -- Use this to tell the user how to get a key
      FileName = "EsCueKey", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = true, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"https://pastebin.com/raw/skz86Q4h"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   }
})

local MainTab = Window:CreateTab("Main Tab", 10511856020) -- Title, Image
local InfoSection = MainTab:CreateSection("Info!")

Rayfield:Notify({
   Title = "Executed!",
   Content = "Script executed!",
   Duration = 5,
   Image = nil,
        local Slider = MainTab:CreateSlider({
   Name = "walkspeed",
   Range = {0, 300},
   Increment = 1,
   Suffix = "walk 👍",
   CurrentValue = 16,
   Flag = "walkspeedSlider", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
                    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = (Value)
   -- The variable (Value) is a number which correlates to the value the slider is currently at
   end,
                local Button = MainTab:CreateButton({
   Name = "Reset WalkSpeed",
   Callback = function()
                game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
   end,
                        local Toggle = MainTab:CreateToggle({
   Name = "Infinite Jump",
   CurrentValue = false,
   Flag = "InfJump", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
   if (Value) == true then
                         local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

local canJump = true
local jumpCooldown = 0.1 -- Cooldown time in seconds

local function onJumpRequest()
	if canJump then
		humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
		canJump = false
		task.wait(jumpCooldown)
		canJump = true
	end
end

game:GetService("UserInputService").JumpRequest:Connect(onJumpRequest)               
    end
   -- The variable (Value) is a boolean on whether the toggle is true or false
   end,
})
})
})
})
})
