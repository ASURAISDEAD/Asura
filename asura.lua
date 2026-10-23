--[[
    ASURA Troller v7
    Clean Purple/Black UI • Animated • Completely Redesigned
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

-- Purple / Black theme
local C = {
    Bg = Color3.fromRGB(12, 10, 18),
    Card = Color3.fromRGB(20, 16, 30),
    Card2 = Color3.fromRGB(28, 22, 42),
    Accent = Color3.fromRGB(140, 70, 255),
    Accent2 = Color3.fromRGB(100, 40, 200),
    Soft = Color3.fromRGB(180, 130, 255),
    Text = Color3.fromRGB(245, 240, 255),
    Dim = Color3.fromRGB(130, 120, 150),
    Green = Color3.fromRGB(80, 220, 140),
    Red = Color3.fromRGB(220, 70, 90)
}

local S = {
    Sel = {}, Fling = false, Spam = false, Noclip = false,
    AntiAFK = true, AntiSit = true, Fly = false, Speed = false,
    InfJump = false, ESP = false, ClickTP = false,
    Delay = 2.5, MsgCount = 0, Angle = 0, Symbols = "",
    SpeedVal = 50, FlySpeed = 50
}

local SpamMsgs = {
    "TMX MEIN WATER 💦", "TMX MEIN KELA 🍌", "TMX MEIN DINO 🦖",
    "TMX MEIN FIRE 🔥", "TMX MEIN VOID 🟣", "TMX MEIN FAN 💨",
    "TMX MEIN SALT 🧂", "ASURA IS HIM 🔥", "GET FLUNG BY ASURA",
    "ASURA DOMINATING", "L + RATIO + ASURA", "ASURA TOO COLD 🥶"
}

-- Cleanup
pcall(function()
    if CG:FindFirstChild("AsuraUI") then CG.AsuraUI:Destroy() end
    if typeof(gethui) == "function" and gethui():FindFirstChild("AsuraUI") then gethui().AsuraUI:Destroy() end
end)

local function tween(obj, props, time, style, dir)
    local t = TweenService:Create(obj, TweenInfo.new(time or 0.25, style or Enum.EasingStyle.Quad, dir or Enum.EasingDirection.Out), props)
    t:Play()
    return t
end

local SG = Instance.new("ScreenGui")
SG.Name = "AsuraUI"
SG.ResetOnSpawn = false
SG.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
SG.Parent = (typeof(gethui) == "function" and gethui()) or CG

-- Main window
local Main = Instance.new("Frame", SG)
Main.Size = UDim2.new(0, 0, 0, 0)
Main.Position = UDim2.new(0.5, 0, 0.5, 0)
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.BackgroundColor3 = C.Bg
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 14)

local mainStroke = Instance.new("UIStroke", Main)
mainStroke.Color = C.Accent
mainStroke.Thickness = 1.5
mainStroke.Transparency = 0.5

-- Open animation
tween(Main, {Size = UDim2.new(0, 380, 0, 460)}, 0.4, Enum.EasingStyle.Back)

-- Top bar
local Top = Instance.new("Frame", Main)
Top.Size = UDim2.new(1, 0, 0, 48)
Top.BackgroundColor3 = C.Card
Top.BorderSizePixel = 0
Instance.new("UICorner", Top).CornerRadius = UDim.new(0, 14)
local topFix = Instance.new("Frame", Top)
topFix.Size = UDim2.new(1, 0, 0, 16)
topFix.Position = UDim2.new(0, 0, 1, -16)
topFix.BackgroundColor3 = C.Card
topFix.BorderSizePixel = 0

-- Accent line under top
local accentLine = Instance.new("Frame", Top)
accentLine.Size = UDim2.new(0, 0, 0, 2)
accentLine.Position = UDim2.new(0, 0, 1, -2)
accentLine.BackgroundColor3 = C.Accent
accentLine.BorderSizePixel = 0
tween(accentLine, {Size = UDim2.new(1, 0, 0, 2)}, 0.6, Enum.EasingStyle.Quad)

local Title = Instance.new("TextLabel", Top)
Title.Size = UDim2.new(1, -60, 1, 0)
Title.Position = UDim2.new(0, 18, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "ASURA"
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 18
Title.TextColor3 = C.Soft
Title.TextXAlignment = Enum.TextXAlignment.Left

local Sub = Instance.new("TextLabel", Top)
Sub.Size = UDim2.new(0, 80, 0, 16)
Sub.Position = UDim2.new(0, 90, 0.5, -2)
Sub.BackgroundTransparency = 1
Sub.Text = "TROLLER"
Sub.Font = Enum.Font.Gotham
Sub.TextSize = 11
Sub.TextColor3 = C.Dim
Sub.TextXAlignment = Enum.TextXAlignment.Left

local Close = Instance.new("TextButton", Top)
Close.Size = UDim2.new(0, 28, 0, 28)
Close.Position = UDim2.new(1, -38, 0.5, -14)
Close.BackgroundColor3 = C.Card2
Close.Text = "✕"
Close.Font = Enum.Font.GothamBold
Close.TextSize = 13
Close.TextColor3 = C.Dim
Instance.new("UICorner", Close).CornerRadius = UDim.new(0, 8)
Close.MouseEnter:Connect(function() tween(Close, {BackgroundColor3 = C.Red, TextColor3 = C.Text}) end)
Close.MouseLeave:Connect(function() tween(Close, {BackgroundColor3 = C.Card2, TextColor3 = C.Dim}) end)
Close.MouseButton1Click:Connect(function()
    S.Fling = false S.Spam = false S.Fly = false
    tween(Main, {Size = UDim2.new(0, 0, 0, 0)}, 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In)
    task.wait(0.3)
    SG:Destroy()
end)

-- Dragging
local drag, dStart, sPos
Top.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        drag = true dStart = i.Position sPos = Main.Position
    end
end)
Top.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then drag = false end
end)
UIS.InputChanged:Connect(function(i)
    if drag and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
        local d = i.Position - dStart
        Main.Position = UDim2.new(sPos.X.Scale, sPos.X.Offset + d.X, sPos.Y.Scale, sPos.Y.Offset + d.Y)
    end
end)

-- Side nav
local Nav = Instance.new("Frame", Main)
Nav.Size = UDim2.new(0, 70, 1, -56)
Nav.Position = UDim2.new(0, 8, 0, 52)
Nav.BackgroundColor3 = C.Card
Nav.BorderSizePixel = 0
Instance.new("UICorner", Nav).CornerRadius = UDim.new(0, 12)

local NavLayout = Instance.new("UIListLayout", Nav)
NavLayout.Padding = UDim.new(0, 6)
NavLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
local NavPad = Instance.new("UIPadding", Nav)
NavPad.PaddingTop = UDim.new(0, 10)

local Content = Instance.new("Frame", Main)
Content.Size = UDim2.new(1, -94, 1, -64)
Content.Position = UDim2.new(0, 86, 0, 56)
Content.BackgroundTransparency = 1

local Pages, NavBtns = {}, {}
local currentPage = "FLING"

local function makeNav(name, icon, order)
    local b = Instance.new("TextButton", Nav)
    b.Size = UDim2.new(0, 54, 0, 48)
    b.BackgroundColor3 = C.Card
    b.Text = ""
    b.AutoButtonColor = false
    b.LayoutOrder = order
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 10)

    local ic = Instance.new("TextLabel", b)
    ic.Size = UDim2.new(1, 0, 0, 22)
    ic.Position = UDim2.new(0, 0, 0, 6)
    ic.BackgroundTransparency = 1
    ic.Text = icon
    ic.TextSize = 16
    ic.Font = Enum.Font.GothamBold
    ic.TextColor3 = C.Dim

    local lb = Instance.new("TextLabel", b)
    lb.Size = UDim2.new(1, 0, 0, 14)
    lb.Position = UDim2.new(0, 0, 1, -18)
    lb.BackgroundTransparency = 1
    lb.Text = name
    lb.Font = Enum.Font.Gotham
    lb.TextSize = 9
    lb.TextColor3 = C.Dim

    NavBtns[name] = {btn = b, icon = ic, label = lb}

    local page = Instance.new("Frame", Content)
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.Visible = false
    Pages[name] = page

    b.MouseButton1Click:Connect(function()
        for k, v in pairs(Pages) do
            v.Visible = (k == name)
        end
        for k, v in pairs(NavBtns) do
            local active = (k == name)
            tween(v.btn, {BackgroundColor3 = active and C.Accent2 or C.Card}, 0.2)
            tween(v.icon, {TextColor3 = active and C.Text or C.Dim}, 0.2)
            tween(v.label, {TextColor3 = active and C.Soft or C.Dim}, 0.2)
        end
        currentPage = name
    end)
end

makeNav("FLING", "⚡", 1)
makeNav("SPAM", "💬", 2)
makeNav("MISC", "✦", 3)

-- Activate first tab
Pages.FLING.Visible = true
NavBtns.FLING.btn.BackgroundColor3 = C.Accent2
NavBtns.FLING.icon.TextColor3 = C.Text
NavBtns.FLING.label.TextColor3 = C.Soft

-------------------------------------------------
-- HELPERS
-------------------------------------------------
local function card(parent, y, h)
    local f = Instance.new("Frame", parent)
    f.Size = UDim2.new(1, 0, 0, h or 40)
    f.Position = UDim2.new(0, 0, 0, y)
    f.BackgroundColor3 = C.Card
    f.BorderSizePixel = 0
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 10)
    return f
end

local function pill(parent, text, x, y, w, active, cb)
    local b = Instance.new("TextButton", parent)
    b.Size = UDim2.new(0, w or 80, 0, 28)
    b.Position = UDim2.new(0, x, 0, y)
    b.BackgroundColor3 = active and C.Accent or C.Card2
    b.Text = text
    b.Font = Enum.Font.GothamBold
    b.TextSize = 11
    b.TextColor3 = active and C.Text or C.Dim
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
    local on = active
    b.MouseButton1Click:Connect(function()
        on = not on
        tween(b, {BackgroundColor3 = on and C.Accent or C.Card2, TextColor3 = on and C.Text or C.Dim}, 0.2)
        if cb then cb(on) end
    end)
    return b
end

local function bigBtn(parent, text, y, color)
    local b = Instance.new("TextButton", parent)
    b.Size = UDim2.new(1, 0, 0, 38)
    b.Position = UDim2.new(0, 0, 0, y)
    b.BackgroundColor3 = color or C.Accent
    b.Text = text
    b.Font = Enum.Font.GothamBold
    b.TextSize = 14
    b.TextColor3 = C.Text
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 10)
    b.MouseEnter:Connect(function() tween(b, {BackgroundColor3 = C.Soft}, 0.15) end)
    b.MouseLeave:Connect(function() tween(b, {BackgroundColor3 = color or C.Accent}, 0.15) end)
    return b
end

local function inp(parent, ph, y)
    local b = Instance.new("TextBox", parent)
    b.Size = UDim2.new(1, 0, 0, 32)
    b.Position = UDim2.new(0, 0, 0, y)
    b.BackgroundColor3 = C.Card
    b.PlaceholderText = ph
    b.Text = ""
    b.Font = Enum.Font.Gotham
    b.TextSize = 12
    b.TextColor3 = C.Text
    b.PlaceholderColor3 = C.Dim
    b.ClearTextOnFocus = false
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
    local p = Instance.new("UIPadding", b)
    p.PaddingLeft = UDim.new(0, 12)
    return b
end

-------------------------------------------------
-- FLING PAGE
-------------------------------------------------
local FP = Pages.FLING

local search = inp(FP, "Search players...", 0)

local list = Instance.new("ScrollingFrame", FP)
list.Size = UDim2.new(1, 0, 0, 160)
list.Position = UDim2.new(0, 0, 0, 40)
list.BackgroundColor3 = C.Card
list.BorderSizePixel = 0
list.ScrollBarThickness = 3
list.ScrollBarImageColor3 = C.Accent
list.CanvasSize = UDim2.new(0, 0, 0, 0)
list.ScrollingEnabled = true
Instance.new("UICorner", list).CornerRadius = UDim.new(0, 10)

local layout = Instance.new("UIListLayout", list)
layout.SortOrder = Enum.SortOrder.Name
layout.Padding = UDim.new(0, 4)
local lpad = Instance.new("UIPadding", list)
lpad.PaddingTop = UDim.new(0, 6)
lpad.PaddingLeft = UDim.new(0, 6)
lpad.PaddingRight = UDim.new(0, 6)
layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    list.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 12)
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
    r.Size = UDim2.new(1, -4, 0, 28)
    r.BackgroundColor3 = C.Card2
    r.Text = ""
    r.AutoButtonColor = false
    Instance.new("UICorner", r).CornerRadius = UDim.new(0, 6)

    local nl = Instance.new("TextLabel", r)
    nl.Size = UDim2.new(1, -70, 1, 0)
    nl.Position = UDim2.new(0, 10, 0, 0)
    nl.BackgroundTransparency = 1
    nl.Text = pl.DisplayName ~= pl.Name and (pl.DisplayName .. "  @" .. pl.Name) or pl.Name
    nl.Font = Enum.Font.Gotham
    nl.TextSize = 12
    nl.TextColor3 = C.Text
    nl.TextXAlignment = Enum.TextXAlignment.Left
    nl.TextTruncate = Enum.TextTruncate.AtEnd

    local st = Instance.new("TextLabel", r)
    st.Size = UDim2.new(0, 58, 1, 0)
    st.Position = UDim2.new(1, -62, 0, 0)
    st.BackgroundTransparency = 1
    st.Text = "ONLINE"
    st.Font = Enum.Font.GothamBold
    st.TextSize = 10
    st.TextColor3 = C.Green

    r.MouseButton1Click:Connect(function()
        if S.Sel[pl] then
            S.Sel[pl] = nil
            tween(r, {BackgroundColor3 = C.Card2}, 0.15)
        else
            S.Sel[pl] = true
            tween(r, {BackgroundColor3 = C.Accent2}, 0.15)
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
ctrl.Size = UDim2.new(1, 0, 0, 90)
ctrl.Position = UDim2.new(0, 0, 0, 210)
ctrl.BackgroundTransparency = 1

SelLabel = Instance.new("TextLabel", ctrl)
SelLabel.Size = UDim2.new(0.4, 0, 0, 20)
SelLabel.BackgroundTransparency = 1
SelLabel.Text = "0 selected"
SelLabel.Font = Enum.Font.Gotham
SelLabel.TextSize = 12
SelLabel.TextColor3 = C.Dim
SelLabel.TextXAlignment = Enum.TextXAlignment.Left

local clearB = pill(ctrl, "Clear", 120, 0, 60, false, function()
    for pl, d in pairs(Rows) do S.Sel[pl] = nil tween(d.row, {BackgroundColor3 = C.Card2}, 0.1) end
    updCount()
end)
local allB = pill(ctrl, "All", 186, 0, 50, false, function()
    for pl, d in pairs(Rows) do if pl.Parent then S.Sel[pl] = true tween(d.row, {BackgroundColor3 = C.Accent2}, 0.1) end end
    updCount()
end)

pill(ctrl, "Noclip", 0, 30, 80, false, function(v) S.Noclip = v end)
pill(ctrl, "Anti AFK", 88, 30, 80, true, function(v) S.AntiAFK = v end)
pill(ctrl, "Anti Sit", 176, 30, 80, true, function(v) S.AntiSit = v end)

local flingBtn = bigBtn(FP, "FLING  •  OFF", 310, C.Accent)
flingBtn.MouseButton1Click:Connect(function()
    S.Fling = not S.Fling
    flingBtn.Text = S.Fling and "FLING  •  ON" or "FLING  •  OFF"
    tween(flingBtn, {BackgroundColor3 = S.Fling and C.Green or C.Accent}, 0.2)
end)

-------------------------------------------------
-- SPAM PAGE
-------------------------------------------------
local SP = Pages.SPAM

local targetBox = inp(SP, "Target name (optional)", 0)
local delayBox = inp(SP, "Delay (seconds)", 40)
delayBox.Text = "2.5"
local symBox = inp(SP, "Symbols  e.g.  @#!$%", 80)

local msgCard = card(SP, 120, 150)
local msgTitle = Instance.new("TextLabel", msgCard)
msgTitle.Size = UDim2.new(1, -16, 0, 22)
msgTitle.Position = UDim2.new(0, 12, 0, 6)
msgTitle.BackgroundTransparency = 1
msgTitle.Text = "Messages  (ASURA ON TOP every 25)"
msgTitle.Font = Enum.Font.Gotham
msgTitle.TextSize = 11
msgTitle.TextColor3 = C.Dim
msgTitle.TextXAlignment = Enum.TextXAlignment.Left

local msgList = Instance.new("ScrollingFrame", msgCard)
msgList.Size = UDim2.new(1, -12, 1, -32)
msgList.Position = UDim2.new(0, 6, 0, 28)
msgList.BackgroundTransparency = 1
msgList.ScrollBarThickness = 3
msgList.ScrollBarImageColor3 = C.Accent
msgList.ScrollingEnabled = true
local msgLay = Instance.new("UIListLayout", msgList)
msgLay.Padding = UDim.new(0, 2)
for _, m in ipairs(SpamMsgs) do
    local l = Instance.new("TextLabel", msgList)
    l.Size = UDim2.new(1, -8, 0, 18)
    l.BackgroundTransparency = 1
    l.Text = "  " .. m
    l.Font = Enum.Font.Gotham
    l.TextSize = 12
    l.TextColor3 = C.Text
    l.TextXAlignment = Enum.TextXAlignment.Left
end
msgList.CanvasSize = UDim2.new(0, 0, 0, #SpamMsgs * 20 + 4)

local spamBtn = bigBtn(SP, "SPAM  •  OFF", 284, C.Accent)
spamBtn.MouseButton1Click:Connect(function()
    S.Spam = not S.Spam
    if S.Spam then
        spamBtn.Text = "SPAM  •  ON"
        tween(spamBtn, {BackgroundColor3 = C.Green}, 0.2)
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
        tween(spamBtn, {BackgroundColor3 = C.Accent}, 0.2)
    end
end)

-------------------------------------------------
-- MISC PAGE
-------------------------------------------------
local MP = Pages.MISC

local function miscPill(txt, y, def, cb)
    local b = Instance.new("TextButton", MP)
    b.Size = UDim2.new(1, 0, 0, 36)
    b.Position = UDim2.new(0, 0, 0, y)
    b.BackgroundColor3 = def and C.Accent or C.Card
    b.Text = "  " .. txt .. (def and "   ON" or "   OFF")
    b.Font = Enum.Font.GothamBold
    b.TextSize = 13
    b.TextColor3 = def and C.Text or C.Dim
    b.TextXAlignment = Enum.TextXAlignment.Left
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 10)
    local on = def
    b.MouseButton1Click:Connect(function()
        on = not on
        tween(b, {BackgroundColor3 = on and C.Accent or C.Card, TextColor3 = on and C.Text or C.Dim}, 0.2)
        b.Text = "  " .. txt .. (on and "   ON" or "   OFF")
        if cb then cb(on) end
    end)
end

miscPill("FLY", 0, false, function(v) S.Fly = v end)
miscPill("SPEED", 44, false, function(v) S.Speed = v end)
miscPill("INFINITE JUMP", 88, false, function(v) S.InfJump = v end)
miscPill("ESP NAMES", 132, false, function(v) S.ESP = v end)
miscPill("CLICK TP", 176, false, function(v) S.ClickTP = v end)

local rejoin = bigBtn(MP, "REJOIN", 230, C.Card2)
rejoin.MouseButton1Click:Connect(function() TS:Teleport(game.PlaceId, LP) end)

local hop = bigBtn(MP, "SERVER HOP", 276, C.Card2)
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

local tip = Instance.new("TextLabel", MP)
tip.Size = UDim2.new(1, 0, 0, 40)
tip.Position = UDim2.new(0, 0, 0, 330)
tip.BackgroundTransparency = 1
tip.Text = "Fly: WASD + Space / Ctrl\nClick TP: click ground to teleport"
tip.Font = Enum.Font.Gotham
tip.TextSize = 11
tip.TextColor3 = C.Dim
tip.TextWrapped = true

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
end)

task.spawn(function()
    while SG.Parent do
        for pl, d in pairs(Rows) do
            if pl.Parent then
                d.status.Text = "ONLINE"
                d.status.TextColor3 = C.Green
                d.name.TextColor3 = C.Text
            else
                d.status.Text = "LEFT"
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

-- Fly
local flyBV, flyBG
RunService.RenderStepped:Connect(function()
    if S.Fly and LP.Character then
        local root = getRoot(LP.Character)
        local hum = LP.Character:FindFirstChildOfClass("Humanoid")
        if root and hum then
            if not flyBV then
                flyBV = Instance.new("BodyVelocity")
                flyBV.MaxForce = Vector3.new(9e9, 9e9, 9e9)
                flyBV.Velocity = Vector3.zero
                flyBV.Parent = root
                flyBG = Instance.new("BodyGyro")
                flyBG.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
                flyBG.P = 9e4
                flyBG.Parent = root
                hum.PlatformStand = true
            end
            local cam = workspace.CurrentCamera
            local dir = Vector3.zero
            if UIS:IsKeyDown(Enum.KeyCode.W) then dir = dir + cam.CFrame.LookVector end
            if UIS:IsKeyDown(Enum.KeyCode.S) then dir = dir - cam.CFrame.LookVector end
            if UIS:IsKeyDown(Enum.KeyCode.A) then dir = dir - cam.CFrame.RightVector end
            if UIS:IsKeyDown(Enum.KeyCode.D) then dir = dir + cam.CFrame.RightVector end
            if UIS:IsKeyDown(Enum.KeyCode.Space) then dir = dir + Vector3.new(0,1,0) end
            if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then dir = dir - Vector3.new(0,1,0) end
            flyBV.Velocity = dir.Magnitude > 0 and dir.Unit * S.FlySpeed or Vector3.zero
            flyBG.CFrame = cam.CFrame
        end
    else
        if flyBV then flyBV:Destroy() flyBV = nil end
        if flyBG then flyBG:Destroy() flyBG = nil end
        if LP.Character then
            local h = LP.Character:FindFirstChildOfClass("Humanoid")
            if h then h.PlatformStand = false end
        end
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
                    bb.Size = UDim2.new(0, 120, 0, 28)
                    bb.StudsOffset = Vector3.new(0, 2.5, 0)
                    bb.AlwaysOnTop = true
                    local tl = Instance.new("TextLabel", bb)
                    tl.Size = UDim2.new(1, 0, 1, 0)
                    tl.BackgroundTransparency = 1
                    tl.Text = pl.Name
                    tl.Font = Enum.Font.GothamBold
                    tl.TextSize = 13
                    tl.TextColor3 = C.Soft
                    tl.TextStrokeTransparency = 0.4
                end
            end
        end
        task.wait(1)
    end
end)

print("[ASURA] v7  •  Purple UI  •  Animated")
