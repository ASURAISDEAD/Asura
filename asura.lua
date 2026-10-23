--[[
    ASURA Troller v9
    Better Fly Animation • Reanimation • Clean Minimize
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
    InfJump = false, ESP = false, ClickTP = false, Reanim = false,
    Delay = 2.5, MsgCount = 0, Angle = 0, Symbols = "",
    SpeedVal = 50, FlySpeed = 60, Minimized = false
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
    local a = TweenService:Create(o, TweenInfo.new(t or 0.22, s or Enum.EasingStyle.Quad, d or Enum.EasingDirection.Out), p)
    a:Play()
    return a
end

local SG = Instance.new("ScreenGui")
SG.Name = "AsuraUI"
SG.ResetOnSpawn = false
SG.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
SG.Parent = (typeof(gethui) == "function" and gethui()) or CG

-------------------------------------------------
-- MAIN WINDOW
-------------------------------------------------
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

tw(Main, {Size = UDim2.new(0, 320, 0, 400)}, 0.35, Enum.EasingStyle.Back)

-- Top bar
local Top = Instance.new("Frame", Main)
Top.Size = UDim2.new(1, 0, 0, 40)
Top.BackgroundColor3 = C.Card
Top.BorderSizePixel = 0
Instance.new("UICorner", Top).CornerRadius = UDim.new(0, 12)
local tf = Instance.new("Frame", Top)
tf.Size = UDim2.new(1, 0, 0, 12)
tf.Position = UDim2.new(0, 0, 1, -12)
tf.BackgroundColor3 = C.Card
tf.BorderSizePixel = 0

local al = Instance.new("Frame", Top)
al.Size = UDim2.new(0, 0, 0, 1.5)
al.Position = UDim2.new(0, 0, 1, -1.5)
al.BackgroundColor3 = C.Acc
al.BorderSizePixel = 0
tw(al, {Size = UDim2.new(1, 0, 0, 1.5)}, 0.5)

local Title = Instance.new("TextLabel", Top)
Title.Size = UDim2.new(1, -80, 1, 0)
Title.Position = UDim2.new(0, 14, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "ASURA"
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 15
Title.TextColor3 = C.Soft
Title.TextXAlignment = Enum.TextXAlignment.Left

local MinBtn = Instance.new("TextButton", Top)
MinBtn.Size = UDim2.new(0, 24, 0, 24)
MinBtn.Position = UDim2.new(1, -56, 0.5, -12)
MinBtn.BackgroundColor3 = C.Card2
MinBtn.Text = "–"
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 16
MinBtn.TextColor3 = C.Dim
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0, 6)
MinBtn.MouseEnter:Connect(function() tw(MinBtn, {BackgroundColor3 = C.Acc2, TextColor3 = C.Text}) end)
MinBtn.MouseLeave:Connect(function() tw(MinBtn, {BackgroundColor3 = C.Card2, TextColor3 = C.Dim}) end)

local Close = Instance.new("TextButton", Top)
Close.Size = UDim2.new(0, 24, 0, 24)
Close.Position = UDim2.new(1, -28, 0.5, -12)
Close.BackgroundColor3 = C.Card2
Close.Text = "✕"
Close.Font = Enum.Font.GothamBold
Close.TextSize = 11
Close.TextColor3 = C.Dim
Instance.new("UICorner", Close).CornerRadius = UDim.new(0, 6)
Close.MouseEnter:Connect(function() tw(Close, {BackgroundColor3 = C.Red, TextColor3 = C.Text}) end)
Close.MouseLeave:Connect(function() tw(Close, {BackgroundColor3 = C.Card2, TextColor3 = C.Dim}) end)
Close.MouseButton1Click:Connect(function()
    S.Fling = false S.Spam = false S.Fly = false
    tw(Main, {Size = UDim2.new(0, 0, 0, 0)}, 0.25, Enum.EasingStyle.Back, Enum.EasingDirection.In)
    task.wait(0.25) SG:Destroy()
end)

-------------------------------------------------
-- CLEAN MINIMIZED BAR
-------------------------------------------------
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

-- Drag mini bar
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
        tw(Main, {Size = UDim2.new(0, 320, 0, 400)}, 0.3, Enum.EasingStyle.Back)
    end
end

MinBtn.MouseButton1Click:Connect(function() setMinimized(true) end)
expandBtn.MouseButton1Click:Connect(function() setMinimized(false) end)

-- Drag main
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

-------------------------------------------------
-- SIDE NAV
-------------------------------------------------
local Nav = Instance.new("Frame", Main)
Nav.Size = UDim2.new(0, 56, 1, -48)
Nav.Position = UDim2.new(0, 6, 0, 44)
Nav.BackgroundColor3 = C.Card
Nav.BorderSizePixel = 0
Instance.new("UICorner", Nav).CornerRadius = UDim.new(0, 10)

local NL = Instance.new("UIListLayout", Nav)
NL.Padding = UDim.new(0, 4)
NL.HorizontalAlignment = Enum.HorizontalAlignment.Center
local NP = Instance.new("UIPadding", Nav)
NP.PaddingTop = UDim.new(0, 8)

local Content = Instance.new("Frame", Main)
Content.Size = UDim2.new(1, -74, 1, -52)
Content.Position = UDim2.new(0, 68, 0, 48)
Content.BackgroundTransparency = 1

local Pages, NavBtns = {}, {}

local function makeNav(name, icon, order)
    local b = Instance.new("TextButton", Nav)
    b.Size = UDim2.new(0, 44, 0, 42)
    b.BackgroundColor3 = C.Card
    b.Text = ""
    b.AutoButtonColor = false
    b.LayoutOrder = order
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)

    local ic = Instance.new("TextLabel", b)
    ic.Size = UDim2.new(1, 0, 0, 20)
    ic.Position = UDim2.new(0, 0, 0, 4)
    ic.BackgroundTransparency = 1
    ic.Text = icon
    ic.TextSize = 14
    ic.Font = Enum.Font.GothamBold
    ic.TextColor3 = C.Dim

    local lb = Instance.new("TextLabel", b)
    lb.Size = UDim2.new(1, 0, 0, 12)
    lb.Position = UDim2.new(0, 0, 1, -15)
    lb.BackgroundTransparency = 1
    lb.Text = name
    lb.Font = Enum.Font.Gotham
    lb.TextSize = 8
    lb.TextColor3 = C.Dim

    NavBtns[name] = {btn = b, icon = ic, label = lb}

    local page = Instance.new("Frame", Content)
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.Visible = false
    Pages[name] = page

    b.MouseButton1Click:Connect(function()
        for k, v in pairs(Pages) do v.Visible = (k == name) end
        for k, v in pairs(NavBtns) do
            local a = (k == name)
            tw(v.btn, {BackgroundColor3 = a and C.Acc2 or C.Card}, 0.18)
            tw(v.icon, {TextColor3 = a and C.Text or C.Dim}, 0.18)
            tw(v.label, {TextColor3 = a and C.Soft or C.Dim}, 0.18)
        end
    end)
end

makeNav("FLING", "⚡", 1)
makeNav("SPAM", "💬", 2)
makeNav("MISC", "✦", 3)
Pages.FLING.Visible = true
NavBtns.FLING.btn.BackgroundColor3 = C.Acc2
NavBtns.FLING.icon.TextColor3 = C.Text
NavBtns.FLING.label.TextColor3 = C.Soft

local function pill(parent, text, x, y, w, active, cb)
    local b = Instance.new("TextButton", parent)
    b.Size = UDim2.new(0, w or 70, 0, 24)
    b.Position = UDim2.new(0, x, 0, y)
    b.BackgroundColor3 = active and C.Acc or C.Card2
    b.Text = text
    b.Font = Enum.Font.GothamBold
    b.TextSize = 10
    b.TextColor3 = active and C.Text or C.Dim
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    local on = active
    b.MouseButton1Click:Connect(function()
        on = not on
        tw(b, {BackgroundColor3 = on and C.Acc or C.Card2, TextColor3 = on and C.Text or C.Dim}, 0.15)
        if cb then cb(on) end
    end)
    return b
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
    b.TextSize = 11
    b.TextColor3 = C.Text
    b.PlaceholderColor3 = C.Dim
    b.ClearTextOnFocus = false
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 7)
    Instance.new("UIPadding", b).PaddingLeft = UDim.new(0, 10)
    return b
end

-------------------------------------------------
-- FLING PAGE
-------------------------------------------------
local FP = Pages.FLING
local search = inp(FP, "Search...", 0)

local list = Instance.new("ScrollingFrame", FP)
list.Size = UDim2.new(1, 0, 0, 140)
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

local Rows, SelLabel = {}
local function updCount()
    local c = 0
    for _ in pairs(S.Sel) do c = c + 1 end
    if SelLabel then SelLabel.Text = c .. " selected" end
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
    nl.Size = UDim2.new(1, -58, 1, 0)
    nl.Position = UDim2.new(0, 8, 0, 0)
    nl.BackgroundTransparency = 1
    nl.Text = pl.DisplayName ~= pl.Name and (pl.DisplayName .. " @" .. pl.Name) or pl.Name
    nl.Font = Enum.Font.Gotham
    nl.TextSize = 11
    nl.TextColor3 = C.Text
    nl.TextXAlignment = Enum.TextXAlignment.Left
    nl.TextTruncate = Enum.TextTruncate.AtEnd

    local st = Instance.new("TextLabel", r)
    st.Size = UDim2.new(0, 50, 1, 0)
    st.Position = UDim2.new(1, -52, 0, 0)
    st.BackgroundTransparency = 1
    st.Text = "ON"
    st.Font = Enum.Font.GothamBold
    st.TextSize = 9
    st.TextColor3 = C.Green

    r.MouseButton1Click:Connect(function()
        if S.Sel[pl] then
            S.Sel[pl] = nil
            tw(r, {BackgroundColor3 = C.Card2}, 0.12)
        else
            S.Sel[pl] = true
            tw(r, {BackgroundColor3 = C.Acc2}, 0.12)
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

local ctrl = Instance.new("Frame", FP)
ctrl.Size = UDim2.new(1, 0, 0, 80)
ctrl.Position = UDim2.new(0, 0, 0, 182)
ctrl.BackgroundTransparency = 1

SelLabel = Instance.new("TextLabel", ctrl)
SelLabel.Size = UDim2.new(0.35, 0, 0, 18)
SelLabel.BackgroundTransparency = 1
SelLabel.Text = "0 selected"
SelLabel.Font = Enum.Font.Gotham
SelLabel.TextSize = 11
SelLabel.TextColor3 = C.Dim
SelLabel.TextXAlignment = Enum.TextXAlignment.Left

pill(ctrl, "Clear", 100, 0, 50, false, function()
    for pl, d in pairs(Rows) do S.Sel[pl] = nil tw(d.row, {BackgroundColor3 = C.Card2}, 0.1) end
    updCount()
end)
pill(ctrl, "All", 156, 0, 40, false, function()
    for pl, d in pairs(Rows) do if pl.Parent then S.Sel[pl] = true tw(d.row, {BackgroundColor3 = C.Acc2}, 0.1) end end
    updCount()
end)

pill(ctrl, "Noclip", 0, 26, 68, false, function(v) S.Noclip = v end)
pill(ctrl, "AntiAFK", 74, 26, 68, true, function(v) S.AntiAFK = v end)
pill(ctrl, "AntiSit", 148, 26, 68, true, function(v) S.AntiSit = v end)

local flingBtn = bigBtn(FP, "FLING  •  OFF", 270, C.Acc)
flingBtn.MouseButton1Click:Connect(function()
    S.Fling = not S.Fling
    flingBtn.Text = S.Fling and "FLING  •  ON" or "FLING  •  OFF"
    tw(flingBtn, {BackgroundColor3 = S.Fling and C.Green or C.Acc}, 0.18)
end)

-------------------------------------------------
-- SPAM PAGE
-------------------------------------------------
local SP = Pages.SPAM
local targetBox = inp(SP, "Target name (optional)", 0)
local delayBox = inp(SP, "Delay (seconds)", 34, "2.5")
local symBox = inp(SP, "Symbols  @#!$%", 68)

local msgCard = Instance.new("Frame", SP)
msgCard.Size = UDim2.new(1, 0, 0, 130)
msgCard.Position = UDim2.new(0, 0, 0, 104)
msgCard.BackgroundColor3 = C.Card
msgCard.BorderSizePixel = 0
Instance.new("UICorner", msgCard).CornerRadius = UDim.new(0, 8)

local msgTitle = Instance.new("TextLabel", msgCard)
msgTitle.Size = UDim2.new(1, -12, 0, 18)
msgTitle.Position = UDim2.new(0, 10, 0, 4)
msgTitle.BackgroundTransparency = 1
msgTitle.Text = "Messages (ASURA every 25)"
msgTitle.Font = Enum.Font.Gotham
msgTitle.TextSize = 10
msgTitle.TextColor3 = C.Dim
msgTitle.TextXAlignment = Enum.TextXAlignment.Left

local msgList = Instance.new("ScrollingFrame", msgCard)
msgList.Size = UDim2.new(1, -8, 1, -24)
msgList.Position = UDim2.new(0, 4, 0, 22)
msgList.BackgroundTransparency = 1
msgList.ScrollBarThickness = 3
msgList.ScrollBarImageColor3 = C.Acc
msgList.ScrollingEnabled = true
local msgLay = Instance.new("UIListLayout", msgList)
msgLay.Padding = UDim.new(0, 1)
for _, m in ipairs(SpamMsgs) do
    local l = Instance.new("TextLabel", msgList)
    l.Size = UDim2.new(1, -6, 0, 16)
    l.BackgroundTransparency = 1
    l.Text = "  " .. m
    l.Font = Enum.Font.Gotham
    l.TextSize = 11
    l.TextColor3 = C.Text
    l.TextXAlignment = Enum.TextXAlignment.Left
end
msgList.CanvasSize = UDim2.new(0, 0, 0, #SpamMsgs * 17 + 4)

local spamBtn = bigBtn(SP, "SPAM  •  OFF", 246, C.Acc)
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
-- MISC PAGE
-------------------------------------------------
local MP = Pages.MISC

local function miscRow(txt, y, def, cb)
    local b = Instance.new("TextButton", MP)
    b.Size = UDim2.new(1, 0, 0, 30)
    b.Position = UDim2.new(0, 0, 0, y)
    b.BackgroundColor3 = def and C.Acc or C.Card
    b.Text = "  " .. txt .. (def and "  ON" or "  OFF")
    b.Font = Enum.Font.GothamBold
    b.TextSize = 12
    b.TextColor3 = def and C.Text or C.Dim
    b.TextXAlignment = Enum.TextXAlignment.Left
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 7)
    local on = def
    b.MouseButton1Click:Connect(function()
        on = not on
        tw(b, {BackgroundColor3 = on and C.Acc or C.Card, TextColor3 = on and C.Text or C.Dim}, 0.15)
        b.Text = "  " .. txt .. (on and "  ON" or "  OFF")
        if cb then cb(on) end
    end)
    return b
end

miscRow("FLY", 0, false, function(v) S.Fly = v end)

-- Speed with number
local speedRow = Instance.new("Frame", MP)
speedRow.Size = UDim2.new(1, 0, 0, 30)
speedRow.Position = UDim2.new(0, 0, 0, 36)
speedRow.BackgroundColor3 = C.Card
speedRow.BorderSizePixel = 0
Instance.new("UICorner", speedRow).CornerRadius = UDim.new(0, 7)

local speedToggle = Instance.new("TextButton", speedRow)
speedToggle.Size = UDim2.new(0.55, 0, 1, 0)
speedToggle.BackgroundTransparency = 1
speedToggle.Text = "  SPEED  OFF"
speedToggle.Font = Enum.Font.GothamBold
speedToggle.TextSize = 12
speedToggle.TextColor3 = C.Dim
speedToggle.TextXAlignment = Enum.TextXAlignment.Left
local speedOn = false
speedToggle.MouseButton1Click:Connect(function()
    speedOn = not speedOn
    S.Speed = speedOn
    speedToggle.Text = speedOn and "  SPEED  ON" or "  SPEED  OFF"
    tw(speedRow, {BackgroundColor3 = speedOn and C.Acc or C.Card}, 0.15)
    speedToggle.TextColor3 = speedOn and C.Text or C.Dim
end)

local speedBox = Instance.new("TextBox", speedRow)
speedBox.Size = UDim2.new(0.38, 0, 0, 22)
speedBox.Position = UDim2.new(0.58, 0, 0.5, -11)
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

miscRow("INF JUMP", 72, false, function(v) S.InfJump = v end)
miscRow("ESP NAMES", 108, false, function(v) S.ESP = v end)
miscRow("CLICK TP", 144, false, function(v) S.ClickTP = v end)
miscRow("REANIMATION", 180, false, function(v) S.Reanim = v end)

local rejoin = bigBtn(MP, "REJOIN", 222, C.Card2)
rejoin.MouseButton1Click:Connect(function() TS:Teleport(game.PlaceId, LP) end)

local hop = bigBtn(MP, "SERVER HOP", 262, C.Card2)
hop.MouseButton1Click:Connect(function()
    pcall(function()
        local http = game:GetService("HttpService")
        local servers = http:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"))
        for _, s in ipairs(servers.data) do
            if s.playing < s.maxPlayers and s.id ~= game.JobId then
                TS:TeleportToPlaceInstance(game.PlaceId, s.id, LP)
                break
            end
        end
    end)
end)

-------------------------------------------------
-- CORE LOGIC
-------------------------------------------------
local function getRoot(c)
    return c and (c:FindFirstChild("HumanoidRootPart") or c:FindFirstChild("Torso") or c:FindFirstChild("UpperTorso"))
end

for _, pl in ipairs(Players:GetPlayers()) do makeRow(pl) end
Players.PlayerAdded:Connect(function(pl) task.wait(0.3) makeRow(pl) end)
Players.PlayerRemoving:Connect(function(pl)
    if Rows[pl] then
        Rows[pl].status.Text = "OFF"
        Rows[pl].status.TextColor3 = C.Red
        Rows[pl].name.TextColor3 = C.Dim
    end
end)

task.spawn(function()
    while SG.Parent do
        for pl, d in pairs(Rows) do
            if pl.Parent then
                d.status.Text = "ON"
                d.status.TextColor3 = C.Green
                d.name.TextColor3 = C.Text
            else
                d.status.Text = "OFF"
                d.status.TextColor3 = C.Red
                d.name.TextColor3 = C.Dim
            end
        end
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

-- Orbit Fling
task.spawn(function()
    while true do
        if S.Fling then
            local my = getRoot(LP.Character)
            if my then
                for pl in pairs(S.Sel) do
                    if pl.Parent and pl.Character then
                        local tr = getRoot(pl.Character)
                        if tr then
                            S.Angle = S.Angle + 0.4
                            local r = 1.5 + math.sin(S.Angle * 2.2) * 3.5
                            pcall(function()
                                my.CFrame = tr.CFrame * CFrame.Angles(0, S.Angle, 0) * CFrame.new(0, 0, r)
                                tr.AssemblyAngularVelocity = Vector3.new(0, 99999, 0)
                                tr.AssemblyLinearVelocity = Vector3.new(math.random(-120,120), 180 + math.random(0,80), math.random(-120,120))
                            end)
                        end
                    end
                end
            end
            task.wait(0.02)
        else task.wait(0.1) end
    end
end)

-------------------------------------------------
-- BETTER FLY (smooth CFrame + BodyVelocity hybrid)
-------------------------------------------------
local flyBV, flyBG, flyConn
local currentVel = Vector3.zero

local function startFly()
    local char = LP.Character
    if not char then return end
    local root = getRoot(char)
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not root or not hum then return end

    hum.PlatformStand = true
    currentVel = Vector3.zero

    flyBV = Instance.new("BodyVelocity")
    flyBV.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    flyBV.Velocity = Vector3.zero
    flyBV.P = 2000
    flyBV.Parent = root

    flyBG = Instance.new("BodyGyro")
    flyBG.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
    flyBG.P = 5000
    flyBG.D = 400
    flyBG.CFrame = root.CFrame
    flyBG.Parent = root

    flyConn = RunService.RenderStepped:Connect(function(dt)
        if not S.Fly or not root or not root.Parent then return end
        local cam = workspace.CurrentCamera
        local move = Vector3.zero

        if UIS:IsKeyDown(Enum.KeyCode.W) then move = move + cam.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.S) then move = move - cam.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.A) then move = move - cam.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.D) then move = move + cam.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.Space) then move = move + Vector3.new(0, 1, 0) end
        if UIS:IsKeyDown(Enum.KeyCode.LeftControl) or UIS:IsKeyDown(Enum.KeyCode.LeftShift) then
            move = move - Vector3.new(0, 1, 0)
        end

        local target = move.Magnitude > 0 and move.Unit * S.FlySpeed or Vector3.zero
        -- smooth acceleration (feels more natural)
        currentVel = currentVel:Lerp(target, math.clamp(dt * 8, 0, 1))
        flyBV.Velocity = currentVel

        -- smooth rotation to camera
        flyBG.CFrame = flyBG.CFrame:Lerp(cam.CFrame, math.clamp(dt * 10, 0, 1))
    end)
end

local function stopFly()
    if flyConn then flyConn:Disconnect() flyConn = nil end
    if flyBV then flyBV:Destroy() flyBV = nil end
    if flyBG then flyBG:Destroy() flyBG = nil end
    currentVel = Vector3.zero
    if LP.Character then
        local h = LP.Character:FindFirstChildOfClass("Humanoid")
        if h then h.PlatformStand = false end
    end
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
        task.wait(0.08)
    end
end)

-- Speed
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

-------------------------------------------------
-- BASIC REANIMATION (keeps character alive / resets physics)
-------------------------------------------------
task.spawn(function()
    while SG.Parent do
        if S.Reanim and LP.Character then
            pcall(function()
                local hum = LP.Character:FindFirstChildOfClass("Humanoid")
                local root = getRoot(LP.Character)
                if hum and root then
                    -- prevent death / ragdoll
                    if hum.Health <= 0 then
                        hum.Health = hum.MaxHealth
                    end
                    hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
                    hum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
                    hum:SetStateEnabled(Enum.HumanoidStateType.Physics, false)
                    if hum:GetState() == Enum.HumanoidStateType.Dead then
                        hum:ChangeState(Enum.HumanoidStateType.GettingUp)
                    end
                end
            end)
        end
        task.wait(0.15)
    end
end)

-- ESP
local ESPFolder = Instance.new("Folder", SG)
ESPFolder.Name = "ESP"
task.spawn(function()
    while SG.Parent do
        for _, c in ipairs(ESPFolder:GetChildren()) do c:Destroy() end
        if S.ESP then
            for _, pl in ipairs(Players:GetPlayers()) do
                if pl ~= LP and pl.Character and pl.Character:FindFirstChild("Head") then
                    local bb = Instance.new("BillboardGui", ESPFolder)
                    bb.Adornee = pl.Character.Head
                    bb.Size = UDim2.new(0, 100, 0, 24)
                    bb.StudsOffset = Vector3.new(0, 2.3, 0)
                    bb.AlwaysOnTop = true
                    local tl = Instance.new("TextLabel", bb)
                    tl.Size = UDim2.new(1, 0, 1, 0)
                    tl.BackgroundTransparency = 1
                    tl.Text = pl.Name
                    tl.Font = Enum.Font.GothamBold
                    tl.TextSize = 12
                    tl.TextColor3 = C.Soft
                    tl.TextStrokeTransparency = 0.4
                end
            end
        end
        task.wait(1)
    end
end)

print("[ASURA] v9  •  Smooth Fly  •  Reanimation  •  Clean Minimize")
