--[[
    ASURA Troller v12
    Scrollable MAIN • Simple Fly (no stuck) • Selected targets panel + LEFT
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local TCS = game:GetService("TextChatService")
local CG = game:GetService("CoreGui")
local VU = game:GetService("VirtualUser")
local RS = game:GetService("ReplicatedStorage")
local TS = game:GetService("TeleportService")
local LP = Players.LocalPlayer
local Mouse = LP:GetMouse()

local C = {
    Bg = Color3.fromRGB(10, 8, 16),
    Card = Color3.fromRGB(18, 14, 28),
    Card2 = Color3.fromRGB(26, 20, 40),
    Acc = Color3.fromRGB(145, 75, 255),
    Acc2 = Color3.fromRGB(105, 45, 210),
    Soft = Color3.fromRGB(185, 140, 255),
    Text = Color3.fromRGB(245, 240, 255),
    Dim = Color3.fromRGB(125, 115, 145),
    Green = Color3.fromRGB(70, 210, 130),
    Red = Color3.fromRGB(220, 65, 85)
}

local S = {
    Sel = {}, Fling = false, Spam = false, Noclip = false,
    AntiAFK = true, AntiSit = true, Fly = false, Speed = false,
    InfJump = false, ClickTP = false, Reanim = false, VCBypass = false,
    Delay = 2.5, MsgCount = 0, Angle = 0, Symbols = "",
    SpeedVal = 50, FlySpeed = 50, Minimized = false
}

local SpamMsgs = {
    "TMX MEIN WATER 💦", "TMX MEIN KELA 🍌", "TMX MEIN DINO 🦖",
    "TMX MEIN FIRE 🔥", "TMX MEIN VOID 🟣", "TMX MEIN FAN 💨",
    "TMX MEIN SALT 🧂", "ASURA IS HIM 🔥", "GET FLUNG BY ASURA",
    "ASURA DOMINATING", "L + RATIO + ASURA", "ASURA TOO COLD 🥶"
}

pcall(function()
    if CG:FindFirstChild("AsuraUI") then CG.AsuraUI:Destroy() end
    if typeof(gethui) == "function" and gethui():FindFirstChild("AsuraUI") then gethui().AsuraUI:Destroy() end
end)

local function tw(o, p, t, s, d)
    local a = TweenService:Create(o, TweenInfo.new(t or 0.2, s or Enum.EasingStyle.Quad, d or Enum.EasingDirection.Out), p)
    a:Play()
    return a
end

local SG = Instance.new("ScreenGui")
SG.Name = "AsuraUI"
SG.ResetOnSpawn = false
SG.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
SG.Parent = (typeof(gethui) == "function" and gethui()) or CG

local Main = Instance.new("Frame", SG)
Main.Size = UDim2.new(0, 0, 0, 0)
Main.Position = UDim2.new(0.5, 0, 0.5, 0)
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.BackgroundColor3 = C.Bg
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)
local ms = Instance.new("UIStroke", Main)
ms.Color = C.Acc
ms.Thickness = 1.2
ms.Transparency = 0.45
tw(Main, {Size = UDim2.new(0, 340, 0, 420)}, 0.35, Enum.EasingStyle.Back)

local Top = Instance.new("Frame", Main)
Top.Size = UDim2.new(1, 0, 0, 42)
Top.BackgroundColor3 = C.Card
Top.BorderSizePixel = 0
Instance.new("UICorner", Top).CornerRadius = UDim.new(0, 12)
local tf = Instance.new("Frame", Top)
tf.Size = UDim2.new(1, 0, 0, 14)
tf.Position = UDim2.new(0, 0, 1, -14)
tf.BackgroundColor3 = C.Card
tf.BorderSizePixel = 0
local al = Instance.new("Frame", Top)
al.Size = UDim2.new(0, 0, 0, 2)
al.Position = UDim2.new(0, 0, 1, -2)
al.BackgroundColor3 = C.Acc
al.BorderSizePixel = 0
tw(al, {Size = UDim2.new(1, 0, 0, 2)}, 0.5)

local Title = Instance.new("TextLabel", Top)
Title.Size = UDim2.new(1, -80, 1, 0)
Title.Position = UDim2.new(0, 16, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "ASURA"
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 16
Title.TextColor3 = C.Soft
Title.TextXAlignment = Enum.TextXAlignment.Left

local MinBtn = Instance.new("TextButton", Top)
MinBtn.Size = UDim2.new(0, 26, 0, 26)
MinBtn.Position = UDim2.new(1, -60, 0.5, -13)
MinBtn.BackgroundColor3 = C.Card2
MinBtn.Text = "–"
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 16
MinBtn.TextColor3 = C.Dim
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0, 7)
MinBtn.MouseEnter:Connect(function() tw(MinBtn, {BackgroundColor3 = C.Acc2, TextColor3 = C.Text}) end)
MinBtn.MouseLeave:Connect(function() tw(MinBtn, {BackgroundColor3 = C.Card2, TextColor3 = C.Dim}) end)

local Close = Instance.new("TextButton", Top)
Close.Size = UDim2.new(0, 26, 0, 26)
Close.Position = UDim2.new(1, -30, 0.5, -13)
Close.BackgroundColor3 = C.Card2
Close.Text = "✕"
Close.Font = Enum.Font.GothamBold
Close.TextSize = 12
Close.TextColor3 = C.Dim
Instance.new("UICorner", Close).CornerRadius = UDim.new(0, 7)
Close.MouseEnter:Connect(function() tw(Close, {BackgroundColor3 = C.Red, TextColor3 = C.Text}) end)
Close.MouseLeave:Connect(function() tw(Close, {BackgroundColor3 = C.Card2, TextColor3 = C.Dim}) end)
Close.MouseButton1Click:Connect(function()
    S.Fling = false S.Spam = false S.Fly = false
    tw(Main, {Size = UDim2.new(0, 0, 0, 0)}, 0.25, Enum.EasingStyle.Back, Enum.EasingDirection.In)
    task.wait(0.25) SG:Destroy()
end)

-- Minimize (same)
local MiniBar = Instance.new("Frame", SG)
MiniBar.Size = UDim2.new(0, 140, 0, 36)
MiniBar.Position = UDim2.new(0.5, -70, 0, 20)
MiniBar.BackgroundColor3 = C.Bg
MiniBar.BorderSizePixel = 0
MiniBar.Visible = false
MiniBar.Active = true
Instance.new("UICorner", MiniBar).CornerRadius = UDim.new(0, 18)
local mbs = Instance.new("UIStroke", MiniBar)
mbs.Color = C.Acc
mbs.Thickness = 1.2
mbs.Transparency = 0.35
local miniTitle = Instance.new("TextLabel", MiniBar)
miniTitle.Size = UDim2.new(1, -40, 1, 0)
miniTitle.Position = UDim2.new(0, 14, 0, 0)
miniTitle.BackgroundTransparency = 1
miniTitle.Text = "ASURA"
miniTitle.Font = Enum.Font.GothamBlack
miniTitle.TextSize = 13
miniTitle.TextColor3 = C.Soft
miniTitle.TextXAlignment = Enum.TextXAlignment.Left
local expandBtn = Instance.new("TextButton", MiniBar)
expandBtn.Size = UDim2.new(0, 28, 0, 28)
expandBtn.Position = UDim2.new(1, -32, 0.5, -14)
expandBtn.BackgroundColor3 = C.Acc2
expandBtn.Text = "+"
expandBtn.Font = Enum.Font.GothamBold
expandBtn.TextSize = 16
expandBtn.TextColor3 = C.Text
Instance.new("UICorner", expandBtn).CornerRadius = UDim.new(0, 14)

local mDrag, mDS, mSP
MiniBar.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        mDrag = true mDS = i.Position mSP = MiniBar.Position
    end
end)
MiniBar.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then mDrag = false end
end)
UIS.InputChanged:Connect(function(i)
    if mDrag and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
        local d = i.Position - mDS
        MiniBar.Position = UDim2.new(mSP.X.Scale, mSP.X.Offset + d.X, mSP.Y.Scale, mSP.Y.Offset + d.Y)
    end
end)

local function setMinimized(state)
    S.Minimized = state
    if state then
        Main.Visible = false
        MiniBar.Visible = true
        MiniBar.Size = UDim2.new(0, 0, 0, 36)
        tw(MiniBar, {Size = UDim2.new(0, 140, 0, 36)}, 0.25, Enum.EasingStyle.Back)
    else
        MiniBar.Visible = false
        Main.Visible = true
        Main.Size = UDim2.new(0, 0, 0, 0)
        tw(Main, {Size = UDim2.new(0, 340, 0, 420)}, 0.3, Enum.EasingStyle.Back)
    end
end
MinBtn.MouseButton1Click:Connect(function() setMinimized(true) end)
expandBtn.MouseButton1Click:Connect(function() setMinimized(false) end)

local drag, ds, sp
Top.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        drag = true ds = i.Position sp = Main.Position
    end
end)
Top.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then drag = false end
end)
UIS.InputChanged:Connect(function(i)
    if drag and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
        local d = i.Position - ds
        Main.Position = UDim2.new(sp.X.Scale, sp.X.Offset + d.X, sp.Y.Scale, sp.Y.Offset + d.Y)
    end
end)

-- Tabs
local TabBar = Instance.new("Frame", Main)
TabBar.Size = UDim2.new(1, -20, 0, 32)
TabBar.Position = UDim2.new(0, 10, 0, 48)
TabBar.BackgroundTransparency = 1

local Tabs = {"MAIN", "FLING", "SPAM"}
local Btns, Pages = {}, {}
for i, name in ipairs(Tabs) do
    local b = Instance.new("TextButton", TabBar)
    b.Size = UDim2.new(1/3, -4, 1, 0)
    b.Position = UDim2.new((i-1)/3, 2, 0, 0)
    b.BackgroundColor3 = C.Card
    b.Text = name
    b.Font = Enum.Font.GothamMedium
    b.TextSize = 12
    b.TextColor3 = C.Dim
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
    Btns[name] = b
    local p = Instance.new("Frame", Main)
    p.Size = UDim2.new(1, -20, 1, -90)
    p.Position = UDim2.new(0, 10, 0, 86)
    p.BackgroundTransparency = 1
    p.Visible = (i == 1)
    Pages[name] = p
end
local function switch(name)
    for k, p in pairs(Pages) do
        p.Visible = (k == name)
        Btns[k].BackgroundColor3 = (k == name) and C.Acc2 or C.Card
        Btns[k].TextColor3 = (k == name) and C.Text or C.Dim
    end
end
for name, b in pairs(Btns) do
    b.MouseButton1Click:Connect(function() switch(name) end)
end
switch("MAIN")

local function section(parent, title, y)
    local l = Instance.new("TextLabel", parent)
    l.Size = UDim2.new(1, 0, 0, 18)
    l.Position = UDim2.new(0, 0, 0, y)
    l.BackgroundTransparency = 1
    l.Text = title
    l.Font = Enum.Font.GothamMedium
    l.TextSize = 11
    l.TextColor3 = C.Dim
    l.TextXAlignment = Enum.TextXAlignment.Left
    return l
end

local function toggle(parent, text, y, def, cb)
    local row = Instance.new("Frame", parent)
    row.Size = UDim2.new(1, -8, 0, 32)
    row.Position = UDim2.new(0, 4, 0, y)
    row.BackgroundColor3 = C.Card
    row.BorderSizePixel = 0
    Instance.new("UICorner", row).CornerRadius = UDim.new(0, 8)
    local lbl = Instance.new("TextLabel", row)
    lbl.Size = UDim2.new(0.7, 0, 1, 0)
    lbl.Position = UDim2.new(0, 12, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.Font = Enum.Font.GothamMedium
    lbl.TextSize = 13
    lbl.TextColor3 = C.Text
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    local btn = Instance.new("TextButton", row)
    btn.Size = UDim2.new(0, 52, 0, 22)
    btn.Position = UDim2.new(1, -62, 0.5, -11)
    btn.BackgroundColor3 = def and C.Green or C.Card2
    btn.Text = def and "ON" or "OFF"
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 11
    btn.TextColor3 = def and C.Text or C.Dim
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    local on = def
    btn.MouseButton1Click:Connect(function()
        on = not on
        tw(btn, {BackgroundColor3 = on and C.Green or C.Card2, TextColor3 = on and C.Text or C.Dim}, 0.15)
        btn.Text = on and "ON" or "OFF"
        if cb then cb(on) end
    end)
    return row
end

local function bigBtn(parent, text, y, col)
    local b = Instance.new("TextButton", parent)
    b.Size = UDim2.new(1, 0, 0, 34)
    b.Position = UDim2.new(0, 0, 0, y)
    b.BackgroundColor3 = col or C.Acc
    b.Text = text
    b.Font = Enum.Font.GothamBold
    b.TextSize = 13
    b.TextColor3 = C.Text
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
    b.MouseEnter:Connect(function() tw(b, {BackgroundColor3 = C.Soft}, 0.12) end)
    b.MouseLeave:Connect(function() tw(b, {BackgroundColor3 = col or C.Acc}, 0.12) end)
    return b
end

local function inp(parent, ph, y, def)
    local b = Instance.new("TextBox", parent)
    b.Size = UDim2.new(1, 0, 0, 28)
    b.Position = UDim2.new(0, 0, 0, y)
    b.BackgroundColor3 = C.Card
    b.PlaceholderText = ph
    b.Text = def or ""
    b.Font = Enum.Font.Gotham
    b.TextSize = 12
    b.TextColor3 = C.Text
    b.PlaceholderColor3 = C.Dim
    b.ClearTextOnFocus = false
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 7)
    Instance.new("UIPadding", b).PaddingLeft = UDim.new(0, 10)
    return b
end

-------------------------------------------------
-- MAIN PAGE (SCROLLABLE)
-------------------------------------------------
local MP = Pages.MAIN

local mainScroll = Instance.new("ScrollingFrame", MP)
mainScroll.Size = UDim2.new(1, 0, 1, 0)
mainScroll.BackgroundTransparency = 1
mainScroll.BorderSizePixel = 0
mainScroll.ScrollBarThickness = 4
mainScroll.ScrollBarImageColor3 = C.Acc
mainScroll.ScrollingEnabled = true
mainScroll.CanvasSize = UDim2.new(0, 0, 0, 420)

section(mainScroll, "MOVEMENT", 0)
toggle(mainScroll, "Fly", 20, false, function(v) S.Fly = v end)

local speedRow = Instance.new("Frame", mainScroll)
speedRow.Size = UDim2.new(1, -8, 0, 32)
speedRow.Position = UDim2.new(0, 4, 0, 56)
speedRow.BackgroundColor3 = C.Card
speedRow.BorderSizePixel = 0
Instance.new("UICorner", speedRow).CornerRadius = UDim.new(0, 8)
local speedLbl = Instance.new("TextLabel", speedRow)
speedLbl.Size = UDim2.new(0.4, 0, 1, 0)
speedLbl.Position = UDim2.new(0, 12, 0, 0)
speedLbl.BackgroundTransparency = 1
speedLbl.Text = "Speed"
speedLbl.Font = Enum.Font.GothamMedium
speedLbl.TextSize = 13
speedLbl.TextColor3 = C.Text
speedLbl.TextXAlignment = Enum.TextXAlignment.Left
local speedBox = Instance.new("TextBox", speedRow)
speedBox.Size = UDim2.new(0, 48, 0, 22)
speedBox.Position = UDim2.new(0.42, 0, 0.5, -11)
speedBox.BackgroundColor3 = C.Card2
speedBox.Text = "50"
speedBox.Font = Enum.Font.GothamBold
speedBox.TextSize = 12
speedBox.TextColor3 = C.Soft
speedBox.ClearTextOnFocus = false
Instance.new("UICorner", speedBox).CornerRadius = UDim.new(0, 5)
speedBox.FocusLost:Connect(function()
    local n = tonumber(speedBox.Text)
    if n and n > 0 then S.SpeedVal = math.clamp(n, 1, 500) speedBox.Text = tostring(S.SpeedVal) end
end)
local speedBtn = Instance.new("TextButton", speedRow)
speedBtn.Size = UDim2.new(0, 52, 0, 22)
speedBtn.Position = UDim2.new(1, -62, 0.5, -11)
speedBtn.BackgroundColor3 = C.Card2
speedBtn.Text = "OFF"
speedBtn.Font = Enum.Font.GothamBold
speedBtn.TextSize = 11
speedBtn.TextColor3 = C.Dim
Instance.new("UICorner", speedBtn).CornerRadius = UDim.new(0, 6)
local speedOn = false
speedBtn.MouseButton1Click:Connect(function()
    speedOn = not speedOn
    S.Speed = speedOn
    tw(speedBtn, {BackgroundColor3 = speedOn and C.Green or C.Card2, TextColor3 = speedOn and C.Text or C.Dim}, 0.15)
    speedBtn.Text = speedOn and "ON" or "OFF"
end)

toggle(mainScroll, "Infinite Jump", 92, false, function(v) S.InfJump = v end)
toggle(mainScroll, "Noclip", 128, false, function(v) S.Noclip = v end)
toggle(mainScroll, "Click TP", 164, false, function(v) S.ClickTP = v end)

section(mainScroll, "PROTECTION", 204)
toggle(mainScroll, "Anti AFK", 224, true, function(v) S.AntiAFK = v end)
toggle(mainScroll, "Anti Sit", 260, true, function(v) S.AntiSit = v end)
toggle(mainScroll, "Reanimation", 296, false, function(v) S.Reanim = v end)
toggle(mainScroll, "VC Bypass", 332, false, function(v) S.VCBypass = v end)

local rejoin = bigBtn(mainScroll, "REJOIN", 376, C.Card2)
rejoin.MouseButton1Click:Connect(function() TS:Teleport(game.PlaceId, LP) end)

-------------------------------------------------
-- FLING PAGE
-------------------------------------------------
local FP = Pages.FLING
local search = inp(FP, "Search players...", 0)

-- Player list
local list = Instance.new("ScrollingFrame", FP)
list.Size = UDim2.new(1, 0, 0, 130)
list.Position = UDim2.new(0, 0, 0, 34)
list.BackgroundColor3 = C.Card
list.BorderSizePixel = 0
list.ScrollBarThickness = 3
list.ScrollBarImageColor3 = C.Acc
list.CanvasSize = UDim2.new(0, 0, 0, 0)
list.ScrollingEnabled = true
Instance.new("UICorner", list).CornerRadius = UDim.new(0, 8)

local layout = Instance.new("UIListLayout", list)
layout.SortOrder = Enum.SortOrder.Name
layout.Padding = UDim.new(0, 3)
local lpad = Instance.new("UIPadding", list)
lpad.PaddingTop = UDim.new(0, 4)
lpad.PaddingLeft = UDim.new(0, 4)
lpad.PaddingRight = UDim.new(0, 4)
layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    list.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 8)
end)

-- SELECTED TARGETS PANEL
local selLabel = Instance.new("TextLabel", FP)
selLabel.Size = UDim2.new(1, 0, 0, 16)
selLabel.Position = UDim2.new(0, 0, 0, 170)
selLabel.BackgroundTransparency = 1
selLabel.Text = "SELECTED TARGETS"
selLabel.Font = Enum.Font.GothamMedium
selLabel.TextSize = 11
selLabel.TextColor3 = C.Dim
selLabel.TextXAlignment = Enum.TextXAlignment.Left

local selList = Instance.new("ScrollingFrame", FP)
selList.Size = UDim2.new(1, 0, 0, 70)
selList.Position = UDim2.new(0, 0, 0, 188)
selList.BackgroundColor3 = C.Card
selList.BorderSizePixel = 0
selList.ScrollBarThickness = 3
selList.ScrollBarImageColor3 = C.Acc
selList.CanvasSize = UDim2.new(0, 0, 0, 0)
selList.ScrollingEnabled = true
Instance.new("UICorner", selList).CornerRadius = UDim.new(0, 8)
local selLay = Instance.new("UIListLayout", selList)
selLay.Padding = UDim.new(0, 3)
local selPad = Instance.new("UIPadding", selList)
selPad.PaddingTop = UDim.new(0, 4)
selPad.PaddingLeft = UDim.new(0, 4)
selPad.PaddingRight = UDim.new(0, 4)

local Rows, SelRows = {}, {}
local countLabel

local function updCount()
    local c = 0
    for _ in pairs(S.Sel) do c = c + 1 end
    if countLabel then countLabel.Text = c .. " selected" end
end

local function refreshSelPanel()
    for _, r in pairs(SelRows) do r:Destroy() end
    SelRows = {}
    local c = 0
    for pl in pairs(S.Sel) do
        c = c + 1
        local r = Instance.new("Frame", selList)
        r.Size = UDim2.new(1, -4, 0, 22)
        r.BackgroundColor3 = C.Card2
        Instance.new("UICorner", r).CornerRadius = UDim.new(0, 5)

        local n = Instance.new("TextLabel", r)
        n.Size = UDim2.new(1, -55, 1, 0)
        n.Position = UDim2.new(0, 8, 0, 0)
        n.BackgroundTransparency = 1
        n.Text = pl.Name
        n.Font = Enum.Font.Gotham
        n.TextSize = 11
        n.TextColor3 = C.Text
        n.TextXAlignment = Enum.TextXAlignment.Left
        n.TextTruncate = Enum.TextTruncate.AtEnd

        local st = Instance.new("TextLabel", r)
        st.Size = UDim2.new(0, 45, 1, 0)
        st.Position = UDim2.new(1, -48, 0, 0)
        st.BackgroundTransparency = 1
        st.Font = Enum.Font.GothamBold
        st.TextSize = 10
        if pl.Parent then
            st.Text = "ON"
            st.TextColor3 = C.Green
        else
            st.Text = "LEFT"
            st.TextColor3 = C.Red
            n.TextColor3 = C.Dim
        end
        table.insert(SelRows, r)
    end
    if c == 0 then
        local e = Instance.new("TextLabel", selList)
        e.Size = UDim2.new(1, 0, 0, 22)
        e.BackgroundTransparency = 1
        e.Text = "  No targets selected"
        e.Font = Enum.Font.Gotham
        e.TextSize = 11
        e.TextColor3 = C.Dim
        e.TextXAlignment = Enum.TextXAlignment.Left
        table.insert(SelRows, e)
    end
    selList.CanvasSize = UDim2.new(0, 0, 0, selLay.AbsoluteContentSize.Y + 8)
    updCount()
end

local function makeRow(pl)
    if Rows[pl] or pl == LP then return end
    local r = Instance.new("TextButton", list)
    r.Size = UDim2.new(1, -4, 0, 24)
    r.BackgroundColor3 = C.Card2
    r.Text = ""
    r.AutoButtonColor = false
    Instance.new("UICorner", r).CornerRadius = UDim.new(0, 5)

    local nl = Instance.new("TextLabel", r)
    nl.Size = UDim2.new(1, -55, 1, 0)
    nl.Position = UDim2.new(0, 8, 0, 0)
    nl.BackgroundTransparency = 1
    nl.Text = pl.DisplayName ~= pl.Name and (pl.DisplayName .. " @" .. pl.Name) or pl.Name
    nl.Font = Enum.Font.Gotham
    nl.TextSize = 11
    nl.TextColor3 = C.Text
    nl.TextXAlignment = Enum.TextXAlignment.Left
    nl.TextTruncate = Enum.TextTruncate.AtEnd

    local st = Instance.new("TextLabel", r)
    st.Size = UDim2.new(0, 45, 1, 0)
    st.Position = UDim2.new(1, -48, 0, 0)
    st.BackgroundTransparency = 1
    st.Text = "ON"
    st.Font = Enum.Font.GothamBold
    st.TextSize = 10
    st.TextColor3 = C.Green

    r.MouseButton1Click:Connect(function()
        if S.Sel[pl] then
            S.Sel[pl] = nil
            tw(r, {BackgroundColor3 = C.Card2}, 0.12)
        else
            S.Sel[pl] = true
            tw(r, {BackgroundColor3 = C.Acc2}, 0.12)
        end
        refreshSelPanel()
    end)
    Rows[pl] = {row = r, status = st, name = nl}
end

search:GetPropertyChangedSignal("Text"):Connect(function()
    local f = search.Text:lower()
    for pl, d in pairs(Rows) do
        d.row.Visible = (f == "" or pl.Name:lower():find(f, 1, true) or (pl.DisplayName and pl.DisplayName:lower():find(f, 1, true)))
    end
end)

local fCtrl = Instance.new("Frame", FP)
fCtrl.Size = UDim2.new(1, 0, 0, 28)
fCtrl.Position = UDim2.new(0, 0, 0, 264)
fCtrl.BackgroundTransparency = 1

countLabel = Instance.new("TextLabel", fCtrl)
countLabel.Size = UDim2.new(0.4, 0, 1, 0)
countLabel.BackgroundTransparency = 1
countLabel.Text = "0 selected"
countLabel.Font = Enum.Font.Gotham
countLabel.TextSize = 12
countLabel.TextColor3 = C.Dim
countLabel.TextXAlignment = Enum.TextXAlignment.Left

local clearB = Instance.new("TextButton", fCtrl)
clearB.Size = UDim2.new(0, 55, 0, 24)
clearB.Position = UDim2.new(0.45, 0, 0, 2)
clearB.BackgroundColor3 = C.Card2
clearB.Text = "Clear"
clearB.Font = Enum.Font.GothamMedium
clearB.TextSize = 11
clearB.TextColor3 = C.Text
Instance.new("UICorner", clearB).CornerRadius = UDim.new(0, 6)
clearB.MouseButton1Click:Connect(function()
    for pl, d in pairs(Rows) do S.Sel[pl] = nil tw(d.row, {BackgroundColor3 = C.Card2}, 0.1) end
    refreshSelPanel()
end)

local allB = Instance.new("TextButton", fCtrl)
allB.Size = UDim2.new(0, 45, 0, 24)
allB.Position = UDim2.new(0.7, 0, 0, 2)
allB.BackgroundColor3 = C.Card2
allB.Text = "All"
allB.Font = Enum.Font.GothamMedium
allB.TextSize = 11
allB.TextColor3 = C.Text
Instance.new("UICorner", allB).CornerRadius = UDim.new(0, 6)
allB.MouseButton1Click:Connect(function()
    for pl, d in pairs(Rows) do if pl.Parent then S.Sel[pl] = true tw(d.row, {BackgroundColor3 = C.Acc2}, 0.1) end end
    refreshSelPanel()
end)

local flingBtn = bigBtn(FP, "FLING  •  OFF", 298, C.Acc)
flingBtn.MouseButton1Click:Connect(function()
    S.Fling = not S.Fling
    flingBtn.Text = S.Fling and "FLING  •  ON" or "FLING  •  OFF"
    tw(flingBtn, {BackgroundColor3 = S.Fling and C.Green or C.Acc}, 0.18)
end)

refreshSelPanel()

-------------------------------------------------
-- SPAM PAGE
-------------------------------------------------
local SP = Pages.SPAM
local targetBox = inp(SP, "Target name (optional)", 0)
local delayBox = inp(SP, "Delay (seconds)", 34, "2.5")
local symBox = inp(SP, "Symbols  @#!$%", 68)

local msgCard = Instance.new("Frame", SP)
msgCard.Size = UDim2.new(1, 0, 0, 145)
msgCard.Position = UDim2.new(0, 0, 0, 104)
msgCard.BackgroundColor3 = C.Card
msgCard.BorderSizePixel = 0
Instance.new("UICorner", msgCard).CornerRadius = UDim.new(0, 8)
local msgTitle = Instance.new("TextLabel", msgCard)
msgTitle.Size = UDim2.new(1, -12, 0, 18)
msgTitle.Position = UDim2.new(0, 10, 0, 4)
msgTitle.BackgroundTransparency = 1
msgTitle.Text = "Messages  (ASURA every 25)"
msgTitle.Font = Enum.Font.GothamMedium
msgTitle.TextSize = 11
msgTitle.TextColor3 = C.Dim
msgTitle.TextXAlignment = Enum.TextXAlignment.Left
local msgList = Instance.new("ScrollingFrame", msgCard)
msgList.Size = UDim2.new(1, -8, 1, -26)
msgList.Position = UDim2.new(0, 4, 0, 22)
msgList.BackgroundTransparency = 1
msgList.ScrollBarThickness = 3
msgList.ScrollBarImageColor3 = C.Acc
msgList.ScrollingEnabled = true
local msgLay = Instance.new("UIListLayout", msgList)
msgLay.Padding = UDim.new(0, 2)
for _, m in ipairs(SpamMsgs) do
    local l = Instance.new("TextLabel", msgList)
    l.Size = UDim2.new(1, -6, 0, 16)
    l.BackgroundTransparency = 1
    l.Text = "  " .. m
    l.Font = Enum.Font.Gotham
    l.TextSize = 12
    l.TextColor3 = C.Text
    l.TextXAlignment = Enum.TextXAlignment.Left
end
msgList.CanvasSize = UDim2.new(0, 0, 0, #SpamMsgs * 18 + 4)

local spamBtn = bigBtn(SP, "SPAM  •  OFF", 260, C.Acc)
spamBtn.MouseButton1Click:Connect(function()
    S.Spam = not S.Spam
    if S.Spam then
        spamBtn.Text = "SPAM  •  ON"
        tw(spamBtn, {BackgroundColor3 = C.Green}, 0.18)
        S.Delay = tonumber(delayBox.Text) or 2.5
        S.Symbols = symBox.Text
        S.MsgCount = 0
        local tgt = targetBox.Text
        task.spawn(function()
            local idx = 1
            while S.Spam and SG.Parent do
                S.MsgCount = S.MsgCount + 1
                local msg = (S.MsgCount % 25 == 0) and "ASURA ON TOP 💀🔥" or SpamMsgs[idx]
                if S.MsgCount % 25 ~= 0 then idx = idx % #SpamMsgs + 1 end
                if tgt ~= "" then msg = tgt .. " " .. msg end
                if S.Symbols ~= "" then msg = S.Symbols .. " " .. msg .. " " .. S.Symbols end
                pcall(function()
                    if TCS.ChatVersion == Enum.ChatVersion.TextChatService then
                        local ch = TCS.TextChannels:FindFirstChild("RBXGeneral")
                        if ch then ch:SendAsync(msg) end
                    else
                        local ev = RS:FindFirstChild("DefaultChatSystemChatEvents")
                        if ev and ev:FindFirstChild("SayMessageRequest") then
                            ev.SayMessageRequest:FireServer(msg, "All")
                        end
                    end
                end)
                task.wait(S.Delay)
            end
        end)
    else
        spamBtn.Text = "SPAM  •  OFF"
        tw(spamBtn, {BackgroundColor3 = C.Acc}, 0.18)
    end
end)

-------------------------------------------------
-- CORE
-------------------------------------------------
local function getRoot(c)
    return c and (c:FindFirstChild("HumanoidRootPart") or c:FindFirstChild("Torso") or c:FindFirstChild("UpperTorso"))
end

for _, pl in ipairs(Players:GetPlayers()) do makeRow(pl) end
Players.PlayerAdded:Connect(function(pl) task.wait(0.3) makeRow(pl) end)
Players.PlayerRemoving:Connect(function(pl)
    if Rows[pl] then
        Rows[pl].status.Text = "LEFT"
        Rows[pl].status.TextColor3 = C.Red
        Rows[pl].name.TextColor3 = C.Dim
    end
    task.delay(0.1, refreshSelPanel)
end)

task.spawn(function()
    while SG.Parent do
        for pl, d in pairs(Rows) do
            if pl.Parent then
                d.status.Text = "ON"
                d.status.TextColor3 = C.Green
                d.name.TextColor3 = C.Text
            else
                d.status.Text = "LEFT"
                d.status.TextColor3 = C.Red
                d.name.TextColor3 = C.Dim
            end
        end
        refreshSelPanel()
        task.wait(0.8)
    end
end)

RunService.Stepped:Connect(function()
    if S.Noclip and LP.Character then
        for _, p in ipairs(LP.Character:GetDescendants()) do
            if p:IsA("BasePart") then p.CanCollide = false end
        end
    end
end)

LP.Idled:Connect(function()
    if S.AntiAFK then VU:CaptureController() VU:ClickButton2(Vector2.new()) end
end)

RunService.Heartbeat:Connect(function()
    if S.AntiSit and LP.Character then
        local h = LP.Character:FindFirstChildOfClass("Humanoid")
        if h and h.Sit then h.Sit = false h.PlatformStand = false end
    end
end)

-- Zero delay fling
RunService.Heartbeat:Connect(function()
    if not S.Fling then return end
    local my = getRoot(LP.Character)
    if not my then return end
    for pl in pairs(S.Sel) do
        if pl.Parent and pl.Character then
            local tr = getRoot(pl.Character)
            if tr then
                S.Angle = S.Angle + 0.55
                local r = 1.2 + math.sin(S.Angle * 2.5) * 3.2
                pcall(function()
                    my.CFrame = tr.CFrame * CFrame.Angles(0, S.Angle, 0) * CFrame.new(0, 0, r)
                    tr.AssemblyAngularVelocity = Vector3.new(math.random(-99999,99999), 99999, math.random(-99999,99999))
                    tr.AssemblyLinearVelocity = Vector3.new(math.random(-250,250), 300 + math.random(0,150), math.random(-250,250))
                end)
            end
        end
    end
end)

-------------------------------------------------
-- SIMPLE FLY (no animation / no stuck)
-------------------------------------------------
local flyConn
local function stopFly()
    if flyConn then flyConn:Disconnect() flyConn = nil end
    if LP.Character then
        local h = LP.Character:FindFirstChildOfClass("Humanoid")
        if h then h.PlatformStand = false end
        local root = getRoot(LP.Character)
        if root then
            -- remove any leftover velocity objects
            for _, v in ipairs(root:GetChildren()) do
                if v.Name == "AsuraFlyBV" or v.Name == "AsuraFlyBG" then v:Destroy() end
            end
            root.AssemblyLinearVelocity = Vector3.zero
        end
    end
end

local function startFly()
    stopFly()
    local char = LP.Character
    if not char then return end
    local root = getRoot(char)
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not root or not hum then return end

    hum.PlatformStand = true

    -- pure CFrame fly - no BodyVelocity animation lag
    flyConn = RunService.RenderStepped:Connect(function(dt)
        if not S.Fly then return end
        if not root or not root.Parent then stopFly() return end
        local cam = workspace.CurrentCamera
        local move = Vector3.zero
        if UIS:IsKeyDown(Enum.KeyCode.W) then move = move + cam.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.S) then move = move - cam.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.A) then move = move - cam.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.D) then move = move + cam.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.Space) then move = move + Vector3.new(0, 1, 0) end
        if UIS:IsKeyDown(Enum.KeyCode.LeftControl) or UIS:IsKeyDown(Enum.KeyCode.LeftShift) then
            move = move + Vector3.new(0, -1, 0)
        end
        if move.Magnitude > 0 then
            root.CFrame = root.CFrame + move.Unit * S.FlySpeed * dt * 3.5
        end
        -- face camera direction lightly
        local look = cam.CFrame.LookVector * Vector3.new(1, 0, 1)
        if look.Magnitude > 0.1 then
            root.CFrame = CFrame.new(root.Position, root.Position + look)
        end
        root.AssemblyLinearVelocity = Vector3.zero
        root.AssemblyAngularVelocity = Vector3.zero
    end)
end

task.spawn(function()
    local was = false
    while SG.Parent do
        if S.Fly and not was then
            startFly()
            was = true
        elseif not S.Fly and was then
            stopFly()
            was = false
        end
        task.wait(0.1)
    end
end)

RunService.Heartbeat:Connect(function()
    if S.Speed and LP.Character then
        local h = LP.Character:FindFirstChildOfClass("Humanoid")
        if h then h.WalkSpeed = S.SpeedVal end
    end
end)

UIS.JumpRequest:Connect(function()
    if S.InfJump and LP.Character then
        local h = LP.Character:FindFirstChildOfClass("Humanoid")
        if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
    end
end)

Mouse.Button1Down:Connect(function()
    if S.ClickTP and Mouse.Hit then
        local r = getRoot(LP.Character)
        if r then r.CFrame = CFrame.new(Mouse.Hit.Position + Vector3.new(0, 3, 0)) end
    end
end)

task.spawn(function()
    while SG.Parent do
        if S.Reanim and LP.Character then
            pcall(function()
                local hum = LP.Character:FindFirstChildOfClass("Humanoid")
                if hum then
                    if hum.Health <= 0 then hum.Health = hum.MaxHealth end
                    hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
                    hum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
                    if hum:GetState() == Enum.HumanoidStateType.Dead then
                        hum:ChangeState(Enum.HumanoidStateType.GettingUp)
                    end
                end
            end)
        end
        task.wait(0.15)
    end
end)

task.spawn(function()
    while SG.Parent do
        if S.VCBypass then
            pcall(function()
                local vs = game:GetService("VoiceChatService")
                if vs then pcall(function() vs:joinVoice() end) end
            end)
        end
        task.wait(2)
    end
end)

print("[ASURA] v12  •  Scroll MAIN  •  Simple Fly  •  Selected Panel + LEFT")
