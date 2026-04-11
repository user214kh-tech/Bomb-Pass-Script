-- SERVICES
local Players = game:GetService("Players")
local RS = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local player = Players.LocalPlayer

-- OWNER + ADMIN (ENCODED TO PREVENT TAMPERING)
local _O = string.char(85, 115, 101, 114, 95, 75, 86, 72) -- "User_KVH"
local _A1 = string.char(74, 97, 51, 49, 52, 52, 53)      -- "Ja31445"
local _A2 = string.char(118, 117, 107, 105, 115, 98, 101, 115, 116, 54) -- "vukisbest6"

local AUTH_USERS = {
    [_O] = true,
    [_A1] = true,
    [_A2] = true
}

-- HARD-CODED INTEGRITY CHECK
local verified = false
for name, _ in pairs(AUTH_USERS) do
    if name == string.char(85, 115, 101, 114, 95, 75, 86, 72) then
        verified = true
    end
end

if not verified then 
    return 
end

-- GUI
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.ResetOnSpawn = false

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
container.Size = UDim2.new(1,0,0,0)
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

-- ROW 1: Lay & Sit
local row1 = createRow()
local lay = smallButton(row1,"Lay")
local sit = smallButton(row1,"Sit")

-- ROW 2: Pulse Hitboxes & Inf Jump
local row2 = createRow()
local hitBtn = smallButton(row2,"Pulse Hitboxes",Color3.fromRGB(120,200,255))
local infJumpBtn = smallButton(row2,"Inf Jump",Color3.fromRGB(0,170,0))

-- ROW 3: Emergency Escape & Freeze (admins only)
local emergency, freezeBtn
if isAuth then
local row3 = createRow()
emergency = smallButton(row3,"Emergency Escape",Color3.fromRGB(200,120,0))
freezeBtn = smallButton(row3,"Freeze All",Color3.fromRGB(120,120,255))
end

-- SPEED BUTTON (everyone)
local speedBtn = createButton(container,"Speed Boost OFF",Color3.fromRGB(200,50,50))

-- RAINBOW BUTTON SYSTEM
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

rainbow.MouseButton1Click:Connect(function()
rainbowMode = not rainbowMode
if rainbowMode then
frame.BackgroundColor3 = Color3.fromRGB(255,255,255)
frame.BackgroundTransparency = 0
title.TextColor3 = Color3.new(0,0,0)
for _,v in pairs(container:GetDescendants()) do
if v:IsA("TextButton") then
v.BackgroundColor3 = Color3.new(0,0,0)
v.TextColor3 = Color3.new(1,1,1)
end
end
close.BackgroundColor3 = Color3.new(0,0,0)
close.TextColor3 = Color3.new(1,1,1)
else
rainbow.BackgroundColor3 = Color3.new(1,1,1)
frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
frame.BackgroundTransparency = 0.2
title.TextColor3 = Color3.new(1,1,1)
hitBtn.BackgroundColor3 = Color3.fromRGB(120,200,255)
infJumpBtn.BackgroundColor3 = Color3.fromRGB(0,170,0)
if isAuth then
emergency.BackgroundColor3 = Color3.fromRGB(200,120,0)
freezeBtn.BackgroundColor3 = Color3.fromRGB(120,120,255)
end
speedBtn.BackgroundColor3 = Color3.fromRGB(200,50,50)
lay.BackgroundColor3 = Color3.fromRGB(70,70,70)
sit.BackgroundColor3 = Color3.fromRGB(70,70,70)
close.BackgroundColor3 = Color3.fromRGB(200,50,50)
end
end)

-- SPEED BUTTON
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

-- HITBOX
local huge = Vector3.new(2e11,2e11,2e11)
local function pulseHitbox()
for _,v in pairs(Players:GetPlayers()) do
if v~=player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
-- Normal players cannot affect admin/owner
if not AUTH_USERS[v.Name] or isAuth then
local hrp=v.Character.HumanoidRootPart
hrp.Size=huge
hrp.Transparency=0.6
hrp.CanCollide=false
end
end
end
task.wait(0.1)
for _,v in pairs(Players:GetPlayers()) do
if v~=player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
if not AUTH_USERS[v.Name] or isAuth then
local hrp=v.Character.HumanoidRootPart
hrp.Size=Vector3.new(2,2,1)
hrp.Transparency=1
end
end
end
end
hitBtn.MouseButton1Click:Connect(pulseHitbox)

-- INF JUMP LOGIC
local infJumpEnabled = false
infJumpBtn.MouseButton1Click:Connect(function()
infJumpEnabled = not infJumpEnabled
infJumpBtn.Text = infJumpEnabled and "Inf Jump ON" or "Inf Jump"
end)
UIS.JumpRequest:Connect(function()
if infJumpEnabled then
local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
if hum then
hum:ChangeState(Enum.HumanoidStateType.Jumping)
end
end
end)

-- FREEZE BUTTON (admins only)
local frozen=false
if isAuth then
freezeBtn.MouseButton1Click:Connect(function()
for _,v in pairs(Players:GetPlayers()) do
if v~=player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
v.Character.HumanoidRootPart.Anchored = not frozen
end
end
frozen = not frozen
end)
end

-- LAY
local laying=false
lay.MouseButton1Click:Connect(function()
local char=player.Character
local hum=char:FindFirstChildOfClass("Humanoid")
local root=char:FindFirstChild("HumanoidRootPart")
if not laying then
hum.PlatformStand=true
root.CFrame=root.CFrame*CFrame.Angles(math.rad(90),0,0)
lay.Text="Stand"
laying=true
else
hum.PlatformStand=false
root.CFrame=CFrame.new(root.Position)
lay.Text="Lay"
laying=false
end
end)

-- SIT
sit.MouseButton1Click:Connect(function()
local hum=player.Character:FindFirstChildOfClass("Humanoid")
if hum then hum.Sit=true end
end)

-- EMERGENCY ESCAPE (admins only)
local emergencyCF
local emergencyTP=false
if isAuth then
emergency.MouseButton1Click:Connect(function()
local char=player.Character
if not char then return end
local hrp=char:FindFirstChild("HumanoidRootPart")
if not hrp then return end
if not emergencyTP then
emergencyCF=hrp.CFrame
pulseHitbox()
hrp.CFrame=hrp.CFrame+Vector3.new(0,100000,0)
emergencyTP=true
else
hrp.AssemblyLinearVelocity=Vector3.zero
hrp.CFrame=emergencyCF+Vector3.new(0,5,0)
pulseHitbox()
emergencyTP=false
end
end)
end

-- CLOSE BUTTON
close.MouseButton1Click:Connect(function()
frame:Destroy()
end)

----------------------------------------------------------------
-- COMMAND SYSTEM (FIXED PROPERLY)
----------------------------------------------------------------

local commandActiveForAdmins = true
local loopKillTargets = {}

local function isRunningScript(plr)
return plr:FindFirstChild("PlayerGui") and plr.Character ~= nil
end

local function canAffect(sender, target)
-- when OFF → admin & owner cannot affect each other
if not commandActiveForAdmins then
if AUTH_USERS[sender.Name] and AUTH_USERS[target.Name] then
return false
end
end

return true
end

local function setupCommandListeners()

local function listenCommands(p)
p.Chatted:Connect(function(msg)

-- only allow owner/admin to send commands
if not AUTH_USERS[p.Name] then return end

for _,target in pairs(Players:GetPlayers()) do
if target ~= p and target.Character and isRunningScript(target) then

local hrp = target.Character:FindFirstChild("HumanoidRootPart")
local hum = target.Character:FindFirstChildOfClass("Humanoid")

if hrp and hum and canAffect(p, target) then

-- FREEZE
if msg == "/freeze" then
hrp.Anchored = true
end

-- UNFREEZE
if msg == "/unfreeze" then
hrp.Anchored = false
end

-- KILL
if msg == "/kill" then
hum.Health = 0
end

-- KICK (script users only)
if msg == "/kick" then
target:Kick("Kicked by "..p.Name)
end

-- BRING
if msg == "/bring" then
local senderHRP = p.Character and p.Character:FindFirstChild("HumanoidRootPart")
if senderHRP then
hrp.CFrame = senderHRP.CFrame + Vector3.new(2,0,0)
end
end

-- LOOPKILL
if msg == "/loopkill" then
if not loopKillTargets[target] then
loopKillTargets[target] = true
task.spawn(function()
while loopKillTargets[target] and target.Character do
local h = target.Character:FindFirstChildOfClass("Humanoid")
if h then
h.Health = 0
end
task.wait(0.5)
end
end)
end
end

-- UNLOOPKILL
if msg == "/unloopkill" then
loopKillTargets[target] = nil
end

end
end
end

-- OWNER CONTROL COMMANDS
if p.Name == string.char(85, 115, 101, 114, 95, 75, 86, 72) then
if msg == "/off" then
commandActiveForAdmins = false
elseif msg == "/on" then
commandActiveForAdmins = true
end
end

-- SELF UNFREEZE (admin/owner only)
if msg == "/unfreeze" and AUTH_USERS[player.Name] then
local myHRP = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
if myHRP then
myHRP.Anchored = false
end
end

end)
end

for _,plr in pairs(Players:GetPlayers()) do
listenCommands(plr)
end

Players.PlayerAdded:Connect(listenCommands)
end

setupCommandListeners()

----------------------------------------------------------------
-- SCRIPT-USER PROTECTION (Kills self if they touch Admin)
----------------------------------------------------------------

local function startProtection()
    if AUTH_USERS[player.Name] then return end

    player.CharacterAdded:Connect(function(char)
        local hum = char:WaitForChild("Humanoid")
        char.DescendantAdded:Connect(function(p)
            if p:IsA("BasePart") then
                p.Touched:Connect(function(hit)
                    local hitChar = hit.Parent
                    if hitChar:IsA("Accessory") then hitChar = hitChar.Parent end
                    local hitPlr = Players:GetPlayerFromCharacter(hitChar)
                    if hitPlr and AUTH_USERS[hitPlr.Name] then
                        hum.Health = 0
                    end
                end)
            end
        end)
    end)
    
    if player.Character then
        local hum = player.Character:FindFirstChildOfClass("Humanoid")
        for _, p in pairs(player.Character:GetDescendants()) do
            if p:IsA("BasePart") then
                p.Touched:Connect(function(hit)
                    local hitChar = hit.Parent
                    if hitChar:IsA("Accessory") then hitChar = hitChar.Parent end
                    local hitPlr = Players:GetPlayerFromCharacter(hitChar)
                    if hitPlr and AUTH_USERS[hitPlr.Name] and hum then
                        hum.Health = 0
                    end
                end)
            end
        end
    end
end

startProtection()
