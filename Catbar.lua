-- SERVICES
local Players = game:GetService("Players")
local RS = game:GetService("RunService")
local player = Players.LocalPlayer

-- OWNER + ADMIN
local AUTH_USERS = {
    ["User_KVH"] = true,   -- Owner
    ["Ja31445"] = true     -- Admin
}

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

-- ROW 2: Pulse Hitboxes & Spin (only admin/owner)
local hitBtn, spinBtn
if isAuth then
	local row2 = createRow()
	hitBtn = smallButton(row2,"Pulse Hitboxes",Color3.fromRGB(120,200,255))
	spinBtn = smallButton(row2,"Spin",Color3.fromRGB(0,170,0))
else
	hitBtn = createButton(container,"Pulse Hitboxes",Color3.fromRGB(120,200,255))
end

-- ROW 3: Emergency Escape & Freeze (admin/owner)
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
		if isAuth then
			spinBtn.BackgroundColor3 = Color3.fromRGB(0,170,0)
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
			local hrp=v.Character.HumanoidRootPart
			hrp.Size=huge
			hrp.Transparency=0.6
			hrp.CanCollide=false
		end
	end
	task.wait(0.1)
	for _,v in pairs(Players:GetPlayers()) do
		if v~=player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
			local hrp=v.Character.HumanoidRootPart
			hrp.Size=Vector3.new(2,2,1)
			hrp.Transparency=1
		end
	end
end
hitBtn.MouseButton1Click:Connect(pulseHitbox)

-- SPIN (admins only)
local spinning=false
local spinConnection
if isAuth then
	spinBtn.MouseButton1Click:Connect(function()
		local char=player.Character
		local hrp=char and char:FindFirstChild("HumanoidRootPart")
		if not hrp then return end
		if not spinning then
			spinning=true
			spinConnection=RS.RenderStepped:Connect(function()
				hrp.CFrame = hrp.CFrame * CFrame.Angles(0,math.rad(20),0)
			end)
		else
			spinning=false
			if spinConnection then spinConnection:Disconnect() end
		end
	end)
end

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
-- COMMAND SYSTEM (admin/owner only + self-unfreeze)
----------------------------------------------------------------
local function setupCommandListeners()
	local function listenCommands(p)
		p.Chatted:Connect(function(msg)
			local myHRP = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
			local myHum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
			if not myHRP or not myHum then return end

			-- Commands from owner/admin
			if AUTH_USERS[p.Name] then
				if msg == "/kick" then
					player:Kick("Kicked by "..p.Name)
				elseif msg == "/destroy" then
					if gui then gui:Destroy() end
				elseif msg == "/freeze" then
					myHRP.Anchored = true
				elseif msg == "/unfreeze" then
					myHRP.Anchored = false
				elseif msg == "/kill" then
					myHum.Health = 0
				end
			end

			-- Self-unfreeze (only if frozen player is admin/owner)
			if msg == "/unfreeze" and AUTH_USERS[player.Name] then
				myHRP.Anchored = false
			end
		end)
	end

	-- Listen to all players including local player
	for _,p in pairs(Players:GetPlayers()) do
		listenCommands(p)
	end
	Players.PlayerAdded:Connect(listenCommands)
	listenCommands(player) -- local player can self-unfreeze
end

setupCommandListeners()
