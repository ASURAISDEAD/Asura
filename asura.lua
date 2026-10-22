--[[
    ASURA Troller v2
    Fixed fling • Live status • Built-in spam messages • Smaller GUI
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local TCS = game:GetService("TextChatService")
local CG = game:GetService("CoreGui")
local VU = game:GetService("VirtualUser")
local LP = Players.LocalPlayer

-- Theme
local T = {
    Bg = Color3.fromRGB(16,16,20),
    Surf = Color3.fromRGB(26,26,32),
    Surf2 = Color3.fromRGB(36,36,44),
    Acc = Color3.fromRGB(220,40,40),
    AccD = Color3.fromRGB(150,25,25),
    Txt = Color3.fromRGB(240,240,245),
    Dim = Color3.fromRGB(140,140,155),
    Ok = Color3.fromRGB(40,200,100),
    Off = Color3.fromRGB(110,110,120)
}

local S = {
    Sel = {},
    Fling = false,
    Spam = false,
    Noclip = false,
    AntiAFK = true,
    AntiSit = true,
    Style = "REAL",
    Delay = 2.5,
    MsgCount = 0
}

-- Built-in spam messages
local SpamMsgs = {
    "TMX MEIN WATER 💦",
    "TMX MEIN KELA 🍌",
    "TMX MEIN DINO 🦖",
    "TMX MEIN FIRE 🔥",
    "TMX MEIN VOID 🟣",
    "TMX MEIN FAN 💨",
    "TMX MEIN SALT 🧂",
    "ASURA ON TOP 💀",
    "ASURA IS HIM 🔥",
    "GET FLUNG BY ASURA",
    "ASURA DOMINATING",
    "L + RATIO + ASURA"
}

pcall(function() if CG:FindFirstChild("AsuraTroller") then CG.AsuraTroller:Destroy() end end)

local SG = Instance.new("ScreenGui")
SG.Name = "AsuraTroller"
SG.ResetOnSpawn = false
SG.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
SG.Parent = (gethui and gethui()) or CG

-- Main (smaller)
local M = Instance.new("Frame", SG)
M.Size = UDim2.new(0, 340, 0, 410)
M.Position = UDim2.new(0.5, -170, 0.5, -205)
M.BackgroundColor3 = T.Bg
M.BorderSizePixel = 0
M.Active = true
Instance.new("UICorner", M).CornerRadius = UDim.new(0, 8)
local stroke = Instance.new("UIStroke", M)
stroke.Color = T.Acc
stroke.Thickness = 1.2
stroke.Transparency = 0.35

-- Title bar (draggable)
local TB = Instance.new("Frame", M)
TB.Size = UDim2.new(1, 0, 0, 34)
TB.BackgroundColor3 = T.Surf
TB.BorderSizePixel = 0
Instance.new("UICorner", TB).CornerRadius = UDim.new(0, 8)
local fix = Instance.new("Frame", TB)
fix.Size = UDim2.new(1, 0, 0, 10)
fix.Position = UDim2.new(0, 0, 1, -10)
fix.BackgroundColor3 = T.Surf
fix.BorderSizePixel = 0

local title = Instance.new("TextLabel", TB)
title.Size = UDim2.new(1, -40, 1, 0)
title.Position = UDim2.new(0, 12, 0, 0)
title.BackgroundTransparency = 1
title.Text = "ASURA  •  TROLLER"
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.TextColor3 = T.Txt
title.TextXAlignment = Enum.TextXAlignment.Left

local close = Instance.new("TextButton", TB)
close.Size = UDim2.new(0, 26, 0, 26)
close.Position = UDim2.new(1, -30, 0.5, -13)
close.BackgroundColor3 = T.AccD
close.Text = "✕"
close.Font = Enum.Font.GothamBold
close.TextSize = 12
close.TextColor3 = T.Txt
Instance.new("UICorner", close).CornerRadius = UDim.new(0, 5)
close.MouseButton1Click:Connect(function()
    S.Fling = false
    S.Spam = false
    SG:Destroy()
end)

-- Dragging
local dragging, dragStart, startPos
TB.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = i.Position
        startPos = M.Position
    end
end)
TB.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)
UIS.InputChanged:Connect(function(i)
    if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
        local d = i.Position - dragStart
        M.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
    end
end)

-- Tabs
local TabBar = Instance.new("Frame", M)
TabBar.Size = UDim2.new(1, -16, 0, 28)
TabBar.Position = UDim2.new(0, 8, 0, 40)
TabBar.BackgroundTransparency = 1

local Tabs, Btns, Pages = {"FLING", "SPAM", "TARGETS"}, {}, {}
for i, n in ipairs(Tabs) do
    local b = Instance.new("TextButton", TabBar)
    b.Size = UDim2.new(1/3, -3, 1, 0)
    b.Position = UDim2.new((i-1)/3, 1.5, 0, 0)
    b.BackgroundColor3 = T.Surf
    b.Text = n
    b.Font = Enum.Font.GothamBold
    b.TextSize = 11
    b.TextColor3 = T.Dim
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 5)
    Btns[n] = b

    local p = Instance.new("Frame", M)
    p.Size = UDim2.new(1, -16, 1, -78)
    p.Position = UDim2.new(0, 8, 0, 74)
    p.BackgroundTransparency = 1
    p.Visible = (i == 1)
    Pages[n] = p
end

local function switch(n)
    for k, p in pairs(Pages) do
        p.Visible = (k == n)
        Btns[k].BackgroundColor3 = (k == n) and T.Acc or T.Surf
        Btns[k].TextColor3 = (k == n) and T.Txt or T.Dim
    end
end
for n, b in pairs(Btns) do
    b.MouseButton1Click:Connect(function() switch(n) end)
end
switch("FLING")

-------------------------------------------------
-- FLING PAGE
-------------------------------------------------
local FP = Pages.FLING

local search = Instance.new("TextBox", FP)
search.Size = UDim2.new(1, 0, 0, 26)
search.BackgroundColor3 = T.Surf
search.PlaceholderText = "Search players..."
search.Text = ""
search.Font = Enum.Font.Gotham
search.TextSize = 12
search.TextColor3 = T.Txt
search.PlaceholderColor3 = T.Dim
search.ClearTextOnFocus = false
Instance.new("UICorner", search).CornerRadius = UDim.new(0, 5)
Instance.new("UIPadding", search).PaddingLeft = UDim.new(0, 8)

local list = Instance.new("ScrollingFrame", FP)
list.Size = UDim2.new(1, 0, 0, 175)
list.Position = UDim2.new(0, 0, 0, 32)
list.BackgroundColor3 = T.Surf
list.BorderSizePixel = 0
list.ScrollBarThickness = 3
list.ScrollBarImageColor3 = T.Acc
list.CanvasSize = UDim2.new(0, 0, 0, 0)
Instance.new("UICorner", list).CornerRadius = UDim.new(0, 5)

local layout = Instance.new("UIListLayout", list)
layout.SortOrder = Enum.SortOrder.Name
layout.Padding = UDim.new(0, 3)
local pad = Instance.new("UIPadding", list)
pad.PaddingTop = UDim.new(0, 4)
pad.PaddingLeft = UDim.new(0, 4)
pad.PaddingRight = UDim.new(0, 4)
layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    list.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 8)
end)

local Rows = {}
local SelLabel

local function updCount()
    local c = 0
    for _ in pairs(S.Sel) do c = c + 1 end
    if SelLabel then SelLabel.Text = c .. " selected" end
end

local function makeRow(pl)
    if Rows[pl] or pl == LP then return end
    local r = Instance.new("TextButton", list)
    r.Size = UDim2.new(1, -6, 0, 26)
    r.BackgroundColor3 = T.Surf2
    r.Text = ""
    r.AutoButtonColor = false
    Instance.new("UICorner", r).CornerRadius = UDim.new(0, 4)

    local nl = Instance.new("TextLabel", r)
    nl.Size = UDim2.new(1, -75, 1, 0)
    nl.Position = UDim2.new(0, 7, 0, 0)
    nl.BackgroundTransparency = 1
    nl.Text = pl.DisplayName ~= pl.Name and (pl.DisplayName .. " (@" .. pl.Name .. ")") or pl.Name
    nl.Font = Enum.Font.Gotham
    nl.TextSize = 11
    nl.TextColor3 = T.Txt
    nl.TextXAlignment = Enum.TextXAlignment.Left
    nl.TextTruncate = Enum.TextTruncate.AtEnd

    local st = Instance.new("TextLabel", r)
    st.Size = UDim2.new(0, 60, 1, 0)
    st.Position = UDim2.new(1, -64, 0, 0)
    st.BackgroundTransparency = 1
    st.Text = "IN GAME"
    st.Font = Enum.Font.GothamBold
    st.TextSize = 10
    st.TextColor3 = T.Ok

    r.MouseButton1Click:Connect(function()
        if S.Sel[pl] then
            S.Sel[pl] = nil
            r.BackgroundColor3 = T.Surf2
        else
            S.Sel[pl] = true
            r.BackgroundColor3 = T.AccD
        end
        updCount()
    end)

    Rows[pl] = {row = r, status = st, name = nl}
end

search:GetPropertyChangedSignal("Text"):Connect(function()
    local f = search.Text:lower()
    for pl, d in pairs(Rows) do
        d.row.Visible = (f == "" or pl.Name:lower():find(f, 1, true) or (pl.DisplayName and pl.DisplayName:lower():find(f, 1, true)))
    end
end)

-- Bottom controls
local bot = Instance.new("Frame", FP)
bot.Size = UDim2.new(1, 0, 0, 95)
bot.Position = UDim2.new(0, 0, 0, 215)
bot.BackgroundTransparency = 1

SelLabel = Instance.new("TextLabel", bot)
SelLabel.Size = UDim2.new(1, 0, 0, 16)
SelLabel.BackgroundTransparency = 1
SelLabel.Text = "0 selected"
SelLabel.Font = Enum.Font.Gotham
SelLabel.TextSize = 11
SelLabel.TextColor3 = T.Dim
SelLabel.TextXAlignment = Enum.TextXAlignment.Left

local function toggleBtn(txt, x, y, def, cb)
    local b = Instance.new("TextButton", bot)
    b.Size = UDim2.new(0.48, 0, 0, 24)
    b.Position = UDim2.new(x, 0, 0, y)
    b.BackgroundColor3 = def and T.Acc or T.Surf2
    b.Text = txt .. (def and ": ON" or ": OFF")
    b.Font = Enum.Font.GothamBold
    b.TextSize = 10
    b.TextColor3 = T.Txt
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 4)
    local on = def
    b.MouseButton1Click:Connect(function()
        on = not on
        b.BackgroundColor3 = on and T.Acc or T.Surf2
        b.Text = txt .. (on and ": ON" or ": OFF")
        cb(on)
    end)
end

toggleBtn("NOCLIP", 0, 20, false, function(v) S.Noclip = v end)
toggleBtn("ANTI-AFK", 0.52, 20, true, function(v) S.AntiAFK = v end)
toggleBtn("ANTI-SIT", 0, 48, true, function(v) S.AntiSit = v end)

local realB = Instance.new("TextButton", bot)
realB.Size = UDim2.new(0.48, 0, 0, 24)
realB.Position = UDim2.new(0.52, 0, 0, 48)
realB.BackgroundColor3 = T.Acc
realB.Text = "REAL FLING"
realB.Font = Enum.Font.GothamBold
realB.TextSize = 10
realB.TextColor3 = T.Txt
Instance.new("UICorner", realB).CornerRadius = UDim.new(0, 4)

local fakeB = Instance.new("TextButton", bot)
fakeB.Size = UDim2.new(0.48, 0, 0, 24)
fakeB.Position = UDim2.new(0, 0, 0, 48)
fakeB.BackgroundColor3 = T.Surf2
fakeB.Text = "FAKE FLING"
fakeB.Font = Enum.Font.GothamBold
fakeB.TextSize = 10
fakeB.TextColor3 = T.Txt
Instance.new("UICorner", fakeB).CornerRadius = UDim.new(0, 4)

-- positions fixed above

realB.MouseButton1Click:Connect(function()
    S.Style = "REAL"
    realB.BackgroundColor3 = T.Acc
    fakeB.BackgroundColor3 = T.Surf2
end)
fakeB.MouseButton1Click:Connect(function()
    S.Style = "FAKE"
    fakeB.BackgroundColor3 = T.Acc
    realB.BackgroundColor3 = T.Surf2
end)

local flingBtn = Instance.new("TextButton", FP)
flingBtn.Size = UDim2.new(1, 0, 0, 32)
flingBtn.Position = UDim2.new(0, 0, 1, -36)
flingBtn.BackgroundColor3 = T.Acc
flingBtn.Text = "START FLING"
flingBtn.Font = Enum.Font.GothamBold
flingBtn.TextSize = 13
flingBtn.TextColor3 = T.Txt
Instance.new("UICorner", flingBtn).CornerRadius = UDim.new(0, 6)

-------------------------------------------------
-- SPAM PAGE
-------------------------------------------------
local SP = Pages.SPAM

local function input(ph, y, def)
    local b = Instance.new("TextBox", SP)
    b.Size = UDim2.new(1, 0, 0, 26)
    b.Position = UDim2.new(0, 0, 0, y)
    b.BackgroundColor3 = T.Surf
    b.PlaceholderText = ph
    b.Text = def or ""
    b.Font = Enum.Font.Gotham
    b.TextSize = 12
    b.TextColor3 = T.Txt
    b.PlaceholderColor3 = T.Dim
    b.ClearTextOnFocus = false
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 5)
    Instance.new("UIPadding", b).PaddingLeft = UDim.new(0, 8)
    return b
end

local targetBox = input("Target name (optional)", 0, "")
local delayBox = input("Delay (seconds)", 32, "2.5")
local nameBox = input("Your name", 64, LP.Name)

local msgLabel = Instance.new("TextLabel", SP)
msgLabel.Size = UDim2.new(1, 0, 0, 16)
msgLabel.Position = UDim2.new(0, 0, 0, 96)
msgLabel.BackgroundTransparency = 1
msgLabel.Text = "Built-in messages (auto cycles + ASURA every 25)"
msgLabel.Font = Enum.Font.Gotham
msgLabel.TextSize = 11
msgLabel.TextColor3 = T.Dim
msgLabel.TextXAlignment = Enum.TextXAlignment.Left

local msgList = Instance.new("ScrollingFrame", SP)
msgList.Size = UDim2.new(1, 0, 0, 110)
msgList.Position = UDim2.new(0, 0, 0, 114)
msgList.BackgroundColor3 = T.Surf
msgList.BorderSizePixel = 0
msgList.ScrollBarThickness = 3
msgList.ScrollBarImageColor3 = T.Acc
Instance.new("UICorner", msgList).CornerRadius = UDim.new(0, 5)
local msgLay = Instance.new("UIListLayout", msgList)
msgLay.Padding = UDim.new(0, 2)
local msgPad = Instance.new("UIPadding", msgList)
msgPad.PaddingTop = UDim.new(0, 4)
msgPad.PaddingLeft = UDim.new(0, 6)

for _, m in ipairs(SpamMsgs) do
    local l = Instance.new("TextLabel", msgList)
    l.Size = UDim2.new(1, -10, 0, 18)
    l.BackgroundTransparency = 1
    l.Text = "• " .. m
    l.Font = Enum.Font.Gotham
    l.TextSize = 11
    l.TextColor3 = T.Txt
    l.TextXAlignment = Enum.TextXAlignment.Left
end
msgList.CanvasSize = UDim2.new(0, 0, 0, #SpamMsgs * 20 + 8)

local spamBtn = Instance.new("TextButton", SP)
spamBtn.Size = UDim2.new(1, 0, 0, 32)
spamBtn.Position = UDim2.new(0, 0, 1, -36)
spamBtn.BackgroundColor3 = T.Acc
spamBtn.Text = "START SPAM"
spamBtn.Font = Enum.Font.GothamBold
spamBtn.TextSize = 13
spamBtn.TextColor3 = T.Txt
Instance.new("UICorner", spamBtn).CornerRadius = UDim.new(0, 6)

-------------------------------------------------
-- TARGETS PAGE
-------------------------------------------------
local TP = Pages.TARGETS

local tt = Instance.new("TextLabel", TP)
tt.Size = UDim2.new(1, 0, 0, 18)
tt.BackgroundTransparency = 1
tt.Text = "TRACKED TARGETS"
tt.Font = Enum.Font.GothamBold
tt.TextSize = 12
tt.TextColor3 = T.Txt
tt.TextXAlignment = Enum.TextXAlignment.Left

local tList = Instance.new("ScrollingFrame", TP)
tList.Size = UDim2.new(1, 0, 1, -24)
tList.Position = UDim2.new(0, 0, 0, 22)
tList.BackgroundColor3 = T.Surf
tList.BorderSizePixel = 0
tList.ScrollBarThickness = 3
tList.ScrollBarImageColor3 = T.Acc
Instance.new("UICorner", tList).CornerRadius = UDim.new(0, 5)
local tLay = Instance.new("UIListLayout", tList)
tLay.Padding = UDim.new(0, 4)
local tPad = Instance.new("UIPadding", tList)
tPad.PaddingTop = UDim.new(0, 5)
tPad.PaddingLeft = UDim.new(0, 5)

local tRows = {}
local function refreshTargets()
    for _, r in pairs(tRows) do r:Destroy() end
    tRows = {}
    local c = 0
    for pl in pairs(S.Sel) do
        c = c + 1
        local r = Instance.new("Frame", tList)
        r.Size = UDim2.new(1, -8, 0, 28)
        r.BackgroundColor3 = T.Surf2
        Instance.new("UICorner", r).CornerRadius = UDim.new(0, 4)

        local n = Instance.new("TextLabel", r)
        n.Size = UDim2.new(1, -70, 1, 0)
        n.Position = UDim2.new(0, 7, 0, 0)
        n.BackgroundTransparency = 1
        n.Text = pl.Name
        n.Font = Enum.Font.Gotham
        n.TextSize = 11
        n.TextColor3 = T.Txt
        n.TextXAlignment = Enum.TextXAlignment.Left

        local st = Instance.new("TextLabel", r)
        st.Size = UDim2.new(0, 58, 1, 0)
        st.Position = UDim2.new(1, -62, 0, 0)
        st.BackgroundTransparency = 1
        st.Font = Enum.Font.GothamBold
        st.TextSize = 10
        if pl.Parent then
            st.Text = "IN GAME"
            st.TextColor3 = T.Ok
        else
            st.Text = "LEFT"
            st.TextColor3 = T.Off
        end
        table.insert(tRows, r)
    end
    if c == 0 then
        local e = Instance.new("TextLabel", tList)
        e.Size = UDim2.new(1, 0, 0, 40)
        e.BackgroundTransparency = 1
        e.Text = "No targets selected.\nSelect players in FLING tab."
        e.Font = Enum.Font.Gotham
        e.TextSize = 12
        e.TextColor3 = T.Dim
        e.TextWrapped = true
        table.insert(tRows, e)
    end
    tList.CanvasSize = UDim2.new(0, 0, 0, tLay.AbsoluteContentSize.Y + 10)
end

-------------------------------------------------
-- CORE LOGIC
-------------------------------------------------

-- Populate players
local function refreshPlayers()
    for _, pl in ipairs(Players:GetPlayers()) do
        makeRow(pl)
    end
end
refreshPlayers()
Players.PlayerAdded:Connect(function(pl)
    task.wait(0.3)
    makeRow(pl)
end)
Players.PlayerRemoving:Connect(function(pl)
    if Rows[pl] then
        Rows[pl].status.Text = "LEFT"
        Rows[pl].status.TextColor3 = T.Off
        Rows[pl].name.TextColor3 = T.Off
    end
    task.delay(0.15, refreshTargets)
end)

-- Live status
task.spawn(function()
    while SG.Parent do
        for pl, d in pairs(Rows) do
            if pl.Parent then
                d.status.Text = "IN GAME"
                d.status.TextColor3 = T.Ok
                d.name.TextColor3 = T.Txt
            else
                d.status.Text = "LEFT"
                d.status.TextColor3 = T.Off
                d.name.TextColor3 = T.Off
            end
        end
        refreshTargets()
        task.wait(0.7)
    end
end)

-- Noclip
RunService.Stepped:Connect(function()
    if S.Noclip and LP.Character then
        for _, p in ipairs(LP.Character:GetDescendants()) do
            if p:IsA("BasePart") then p.CanCollide = false end
        end
    end
end)

-- Anti-AFK + Anti-Sit
LP.Idled:Connect(function()
    if S.AntiAFK then
        VU:CaptureController()
        VU:ClickButton2(Vector2.new())
    end
end)

RunService.Heartbeat:Connect(function()
    if S.AntiSit and LP.Character then
        local hum = LP.Character:FindFirstChildOfClass("Humanoid")
        if hum and hum.Sit then
            hum.Sit = false
        end
    end
end)

-- Improved Fling
local function getRoot(char)
    return char and (char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso"))
end

flingBtn.MouseButton1Click:Connect(function()
    S.Fling = not S.Fling
    flingBtn.Text = S.Fling and "STOP FLING" or "START FLING"
    flingBtn.BackgroundColor3 = S.Fling and T.AccD or T.Acc
end)

-- Continuous fling loop (low delay)
task.spawn(function()
    while true do
        if S.Fling then
            local myRoot = getRoot(LP.Character)
            if myRoot then
                for pl in pairs(S.Sel) do
                    if pl.Parent and pl.Character then
                        local targetRoot = getRoot(pl.Character)
                        if targetRoot then
                            if S.Style == "REAL" then
                                pcall(function()
                                    local bv = Instance.new("BodyVelocity")
                                    bv.Name = "AsuraFling"
                                    bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
                                    bv.Velocity = Vector3.new(0, 0, 0)
                                    bv.Parent = myRoot

                                    myRoot.CFrame = targetRoot.CFrame

                                    local bang = Instance.new("BodyAngularVelocity")
                                    bang.Name = "AsuraSpin"
                                    bang.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
                                    bang.AngularVelocity = Vector3.new(0, 99999, 0)
                                    bang.Parent = targetRoot

                                    local bv2 = Instance.new("BodyVelocity")
                                    bv2.Name = "AsuraForce"
                                    bv2.MaxForce = Vector3.new(1e5, 1e5, 1e5)
                                    bv2.Velocity = (targetRoot.Position - myRoot.Position).Unit * 200 + Vector3.new(0, 150, 0)
                                    bv2.Parent = targetRoot

                                    task.wait(0.08)
                                    pcall(function() bv:Destroy() end)
                                    pcall(function() bang:Destroy() end)
                                    pcall(function() bv2:Destroy() end)
                                end)
                            else
                                pcall(function()
                                    targetRoot.AssemblyAngularVelocity = Vector3.new(9999, 9999, 9999)
                                end)
                            end
                        end
                    end
                end
            end
            task.wait(0.05)
        else
            task.wait(0.2)
        end
    end
end)

-- Chat function
local function sendChat(msg)
    pcall(function()
        if TCS.ChatVersion == Enum.ChatVersion.TextChatService then
            local ch = TCS.TextChannels:FindFirstChild("RBXGeneral")
            if ch then ch:SendAsync(msg) end
        else
            local ev = game:GetService("ReplicatedStorage"):FindFirstChild("DefaultChatSystemChatEvents")
            if ev and ev:FindFirstChild("SayMessageRequest") then
                ev.SayMessageRequest:FireServer(msg, "All")
            end
        end
    end)
end

-- Spam with built-in messages + ASURA every 25
spamBtn.MouseButton1Click:Connect(function()
    S.Spam = not S.Spam
    spamBtn.Text = S.Spam and "STOP SPAM" or "START SPAM"
    spamBtn.BackgroundColor3 = S.Spam and T.AccD or T.Acc

    if S.Spam then
        S.Delay = tonumber(delayBox.Text) or 2.5
        S.MsgCount = 0
        local targetName = targetBox.Text
        local yourName = nameBox.Text

        task.spawn(function()
            local idx = 1
            while S.Spam and SG.Parent do
                S.MsgCount = S.MsgCount + 1

                local msg
                if S.MsgCount % 25 == 0 then
                    msg = "ASURA ON TOP 💀🔥"
                else
                    msg = SpamMsgs[idx]
                    idx = idx % #SpamMsgs + 1
                end

                if targetName ~= "" then
                    msg = targetName .. " " .. msg
                end
                if yourName ~= "" then
                    msg = msg .. " | " .. yourName
                end

                sendChat(msg)
                task.wait(S.Delay)
            end
        end)
    end
end)

print("[ASURA] v2 Loaded • Fling fixed • Built-in spam ready")
