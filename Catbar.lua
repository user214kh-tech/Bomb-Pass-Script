-- SERVICES
local Players = game:GetService("Players")
local RS = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

-- OWNER + ADMIN LIST
local AUTH_USERS = {
["User_KVH"] = true, -- Owner
["Ja31445"] = true,
["vukisbest6"] = true,
["Kartikeya_880"] = true,
["Marcel_pietruk2"] = true,
["reyyyyyyyn_3"] = true
}

-- GUI SETUP
local gui = Instance.new("ScreenGui")
gui.Name = "CatbarGui"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- NOTIFICATION SYSTEM
local function notify(text)
    local notifFrame = Instance.new("Frame", gui)
    notifFrame.Size = UDim2.new(0, 250, 0, 40)
    notifFrame.Position = UDim2.new(0, -300, 1, -60)
    notifFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    notifFrame.BorderSizePixel = 0
    Instance.new("UICorner", notifFrame)

    local accent = Instance.new("Frame", notifFrame)
    accent.Size = UDim2.new(0, 4, 1, 0)
    accent.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    accent.BorderSizePixel = 0
    Instance.new("UICorner", accent)

    local lab = Instance.new("TextLabel", notifFrame)
    lab.Size = UDim2.new(1, -10, 1, 0)
    lab.Position = UDim2.new(0, 10, 0, 0)
    lab.BackgroundTransparency = 1
    lab.Text = text
    lab.TextColor3 = Color3.new(1, 1, 1)
    lab.Font = Enum.Font.SourceSansBold
    lab.TextSize = 14
    lab.TextXAlignment = Enum.TextXAlignment.Left

    notifFrame:TweenPosition(UDim2.new(0, 20, 1, -60), "Out", "Quart", 0.5, true)
    task.wait(5)
    notifFrame:TweenPosition(UDim2.new(0, -300, 1, -60), "In", "Quart", 0.5, true)
    task.wait(0.5)
    notifFrame:Destroy()
end

-- Check for Owner Presence
local function checkOwner(p)
    if p.Name == "User_KVH" then
        notify("CatBar's Script Owner is in the server")
    end
end

for _, v in pairs(Players:GetPlayers()) do checkOwner(v) end
Players.PlayerAdded:Connect(checkOwner)

-- MAIN FRAME
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0,180,0,0)
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
close.TextColor3 = Color3.new(1,1,1)
close.BackgroundColor3 = Color3.fromRGB(200,50,50)
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
container.Size = UDim2.new(1,0,0,0)
container.Position = UDim2.new(0,0,0,25)
container.BackgroundTransparency = 1

local layout = Instance.new("UIListLayout", container)
layout.Padding = UDim.new(0,6)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
frame.Size = UDim2.new(0,180,0,layout.AbsoluteContentSize.Y+45)
end)

-- BUTTON HELPERS
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

local isAuth = AUTH_USERS[player.Name]

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

-- RAINBOW LOGIC
local rainbowMode = false
task.spawn(function()
while true do
if rainbowMode then
for i=0,1,0.02 do
if not rainbowMode then break end
rainbow.BackgroundColor3 = Color3.fromHSV(i,1,1)
task.wait(0.03)
end
else task.wait() end
end
end)

rainbow.MouseButton1Click:Connect(function()
rainbowMode = not rainbowMode
if rainbowMode then
frame.BackgroundColor3 = Color3.fromRGB(255,255,255)
frame.BackgroundTransparency = 0
title.TextColor3 = Color3.new(0,0,0)
for _,v in pairs(container:GetDescendants()) do
if v:IsA("TextButton") then v.BackgroundColor3 = Color3.new(0,0,0) v.TextColor3 = Color3.new(1,1,1) end
end
close.BackgroundColor3 = Color3.new(0,0,0)
else
rainbow.BackgroundColor3 = Color3.new(1,1,1)
frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
frame.BackgroundTransparency = 0.2
title.TextColor3 = Color3.new(1,1,1)
hitBtn.BackgroundColor3 = Color3.fromRGB(120,200,255)
infJumpBtn.BackgroundColor3 = Color3.fromRGB(0,170,0)
if isAuth then emergency.BackgroundColor3 = Color3.fromRGB(200,120,0) freezeBtn.BackgroundColor3 = Color3.fromRGB(120,120,255) end
speedBtn.BackgroundColor3 = Color3.fromRGB(200,50,50)
close.BackgroundColor3 = Color3.fromRGB(200,50,50)
end
end)

-- SPEED
local speedOn = false
local originalSpeed
speedBtn.MouseButton1Click:Connect(function()
local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
if not hum then return end
if not speedOn then
originalSpeed = hum.WalkSpeed
hum.WalkSpeed = 60
speedBtn.Text = "Speed Boost ON"
speedOn = true
else
hum.WalkSpeed = originalSpeed or 16
speedBtn.Text = "Speed Boost OFF"
speedOn = false
end
end)

-- HITBOX
local huge = Vector3.new(2e11,2e11,2e11)
local function pulseHitbox()
for _,v in pairs(Players:GetPlayers()) do
if v~=player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
if not AUTH_USERS[v.Name] or isAuth then
local hrp = v.Character.HumanoidRootPart
hrp.Size = huge
hrp.Transparency = 0.6
hrp.CanCollide = false
end
end
end
task.wait(0.1)
for _,v in pairs(Players:GetPlayers()) do
if v~=player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
local hrp = v.Character.HumanoidRootPart
hrp.Size = Vector3.new(2,2,1)
hrp.Transparency = 1
end
end
end
hitBtn.MouseButton1Click:Connect(pulseHitbox)

-- INF JUMP
local infJumpEnabled = false
infJumpBtn.MouseButton1Click:Connect(function() infJumpEnabled = not infJumpEnabled infJumpBtn.Text = infJumpEnabled and "Inf Jump ON" or "Inf Jump" end)
UIS.JumpRequest:Connect(function() if infJumpEnabled then local h = player.Character:FindFirstChildOfClass("Humanoid") if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end end end)

-- LAY/SIT
local laying = false
lay.MouseButton1Click:Connect(function()
local char = player.Character
local hum = char:FindFirstChildOfClass("Humanoid")
local root = char:FindFirstChild("HumanoidRootPart")
if not laying then hum.PlatformStand = true root.CFrame *= CFrame.Angles(math.rad(90),0,0) lay.Text="Stand" laying=true
else hum.PlatformStand = false root.CFrame = CFrame.new(root.Position) lay.Text="Lay" laying=false end
end)

sit.MouseButton1Click:Connect(function() local h = player.Character:FindFirstChildOfClass("Humanoid") if h then h.Sit = true end end)

-- CLOSE
close.MouseButton1Click:Connect(function() gui:Destroy() end)

----------------------------------------------------------------
-- COMMAND SYSTEM
----------------------------------------------------------------
local commandActiveForAdmins = true
local loopKillTargets = {}
local sitTargets = {}
local distortTargets = {}

local function isRunningScript(plr) return plr:FindFirstChild("PlayerGui") and plr.Character ~= nil end

local function canAffect(sender, target)
if not commandActiveForAdmins then
if AUTH_USERS[sender.Name] and AUTH_USERS[target.Name] then return false end
end
return true
end

local function setupCommandListeners()
    local function listenCommands(p)
        p.Chatted:Connect(function(msg)
            if not AUTH_USERS[p.Name] then return end

            for _, target in pairs(Players:GetPlayers()) do
                if target ~= p and target.Character and isRunningScript(target) then
                    local hrp = target.Character:FindFirstChild("HumanoidRootPart")
                    local hum = target.Character:FindFirstChildOfClass("Humanoid")

                    if hrp and hum and canAffect(p, target) then
                        if msg == "/freeze" then hrp.Anchored = true
                        elseif msg == "/unfreeze" then hrp.Anchored = false
                        elseif msg == "/kill" then hum.Health = 0
                        elseif msg == "/kick" then target:Kick("Kicked by "..p.Name)
                        elseif msg == "/bring" then
                            local sHRP = p.Character and p.Character:FindFirstChild("HumanoidRootPart")
                            if sHRP then hrp.CFrame = sHRP.CFrame + Vector3.new(2,0,0) end
                        elseif msg == "/spin" then
                            local s = hrp:FindFirstChild("CatbarSpin") or Instance.new("BodyAngularVelocity")
                            s.Name = "CatbarSpin" s.MaxTorque = Vector3.new(0, math.huge, 0) s.AngularVelocity = Vector3.new(0, 50, 0) s.Parent = hrp
                        elseif msg == "/unspin" then
                            local s = hrp:FindFirstChild("CatbarSpin") if s then s:Destroy() end
                        elseif msg == "/sit" then
                            if not sitTargets[target] then
                                sitTargets[target] = true
                                task.spawn(function()
                                    while sitTargets[target] and target.Character do
                                        local h = target.Character:FindFirstChildOfClass("Humanoid")
                                        if h then h.Sit = true end
                                        task.wait(0.1)
                                    end
                                end)
                            end
                        elseif msg == "/unsit" then sitTargets[target] = nil hum.Sit = false
                        elseif msg == "/distort" and p.Name == "User_KVH" then
                            if not distortTargets[target] then
                                distortTargets[target] = true
                                task.spawn(function()
                                    local conn
                                    conn = RS.RenderStepped:Connect(function()
                                        if not distortTargets[target] then conn:Disconnect() return end
                                        local h = target.Character and target.Character:FindFirstChildOfClass("Humanoid")
                                        if h and h.MoveDirection.Magnitude > 0 then h:Move(-h.MoveDirection, false) end
                                    end)
                                end)
                            end
                        elseif msg == "/undistort" and p.Name == "User_KVH" then distortTargets[target] = nil
                        elseif msg == "/loopkill" then
                            if not loopKillTargets[target] then
                                loopKillTargets[target] = true
                                task.spawn(function()
                                    while loopKillTargets[target] and target.Character do
                                        local h = target.Character:FindFirstChildOfClass("Humanoid")
                                        if h then h.Health = 0 end
                                        task.wait(0.5)
                                    end
                                end)
                            end
                        elseif msg == "/unloopkill" then loopKillTargets[target] = nil
                        end
                    end
                end
            end

            -- OWNER CONTROLS
            if p.Name == "User_KVH" then
                if msg == "/off" then commandActiveForAdmins = false
                elseif msg == "/on" then commandActiveForAdmins = true end
            end
        end)
    end

    for _, plr in pairs(Players:GetPlayers()) do listenCommands(plr) end
    Players.PlayerAdded:Connect(listenCommands)
end

setupCommandListeners()
