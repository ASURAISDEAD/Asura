local P,RS,TS,UIS,TCS,CG=game:GetService("Players"),game:GetService("RunService"),game:GetService("TweenService"),game:GetService("UserInputService"),game:GetService("TextChatService"),game:GetService("CoreGui")
local LP=P.LocalPlayer
local Theme={Bg=Color3.fromRGB(18,18,22),Surf=Color3.fromRGB(28,28,34),Surf2=Color3.fromRGB(38,38,46),Acc=Color3.fromRGB(220,40,40),AccD=Color3.fromRGB(160,25,25),Txt=Color3.fromRGB(240,240,245),Dim=Color3.fromRGB(150,150,160),Ok=Color3.fromRGB(40,200,100),Off=Color3.fromRGB(120,120,130)}
local S={Sel={},Fling=false,Spam=false,Noclip=false,AntiAFK=true,Style="REAL",Delay=3.5,Msg="SCRIPT BY ASURA\n=ASURA ON TOP=",Target="",Sym="",Name=LP.Name}

pcall(function()if CG:FindFirstChild("AsuraTroller")then CG.AsuraTroller:Destroy()end end)
local SG=Instance.new("ScreenGui",CG)SG.Name="AsuraTroller"SG.ResetOnSpawn=false
local M=Instance.new("Frame",SG)M.Size=UDim2.new(0,400,0,480)M.Position=UDim2.new(.5,-200,.5,-240)M.BackgroundColor3=Theme.Bg M.BorderSizePixel=0
Instance.new("UICorner",M).CornerRadius=UDim.new(0,10)
local St=Instance.new("UIStroke",M)St.Color=Theme.Acc St.Thickness=1.5 St.Transparency=.4

local TB=Instance.new("Frame",M)TB.Size=UDim2.new(1,0,0,40)TB.BackgroundColor3=Theme.Surf TB.BorderSizePixel=0
Instance.new("UICorner",TB).CornerRadius=UDim.new(0,10)
local TF=Instance.new("Frame",TB)TF.Size=UDim2.new(1,0,0,12)TF.Position=UDim2.new(0,0,1,-12)TF.BackgroundColor3=Theme.Surf TF.BorderSizePixel=0
local TL=Instance.new("TextLabel",TB)TL.Size=UDim2.new(1,-50,1,0)TL.Position=UDim2.new(0,14,0,0)TL.BackgroundTransparency=1 TL.Text="ASURA  •  TROLLER"TL.Font=Enum.Font.GothamBold TL.TextSize=15 TL.TextColor3=Theme.Txt TL.TextXAlignment=Enum.TextXAlignment.Left
local CB=Instance.new("TextButton",TB)CB.Size=UDim2.new(0,30,0,30)CB.Position=UDim2.new(1,-36,.5,-15)CB.BackgroundColor3=Theme.AccD CB.Text="✕"CB.Font=Enum.Font.GothamBold CB.TextSize=13 CB.TextColor3=Theme.Txt
Instance.new("UICorner",CB).CornerRadius=UDim.new(0,6)
CB.MouseButton1Click:Connect(function()S.Fling=false S.Spam=false SG:Destroy()end)

local drag,ds,sp
TB.InputBegan:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 then drag=true ds=i.Position sp=M.Position end end)
TB.InputEnded:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 then drag=false end end)
UIS.InputChanged:Connect(function(i)if drag and i.UserInputType==Enum.UserInputType.MouseMovement then local d=i.Position-ds M.Position=UDim2.new(sp.X.Scale,sp.X.Offset+d.X,sp.Y.Scale,sp.Y.Offset+d.Y)end end)

local TabBar=Instance.new("Frame",M)TabBar.Size=UDim2.new(1,-20,0,32)TabBar.Position=UDim2.new(0,10,0,48)TabBar.BackgroundTransparency=1
local Tabs,Btns,Pages={"FLING","SPAM","TARGETS"},{},{}
for i,n in ipairs(Tabs)do
    local b=Instance.new("TextButton",TabBar)b.Size=UDim2.new(1/3,-4,1,0)b.Position=UDim2.new((i-1)/3,2,0,0)b.BackgroundColor3=Theme.Surf b.Text=n b.Font=Enum.Font.GothamBold b.TextSize=12 b.TextColor3=Theme.Dim
    Instance.new("UICorner",b).CornerRadius=UDim.new(0,5)Btns[n]=b
    local p=Instance.new("Frame",M)p.Size=UDim2.new(1,-20,1,-92)p.Position=UDim2.new(0,10,0,88)p.BackgroundTransparency=1 p.Visible=(i==1)Pages[n]=p
end
local function sw(n)for k,p in pairs(Pages)do p.Visible=(k==n)Btns[k].BackgroundColor3=(k==n)and Theme.Acc or Theme.Surf Btns[k].TextColor3=(k==n)and Theme.Txt or Theme.Dim end end
for n,b in pairs(Btns)do b.MouseButton1Click:Connect(function()sw(n)end)end sw("FLING")

-- FLING
local FP=Pages.FLING
local SB=Instance.new("TextBox",FP)SB.Size=UDim2.new(1,0,0,30)SB.BackgroundColor3=Theme.Surf SB.PlaceholderText="Search..."SB.Text=""SB.Font=Enum.Font.Gotham SB.TextSize=12 SB.TextColor3=Theme.Txt SB.PlaceholderColor3=Theme.Dim SB.ClearTextOnFocus=false
Instance.new("UICorner",SB).CornerRadius=UDim.new(0,5)Instance.new("UIPadding",SB).PaddingLeft=UDim.new(0,10)
local LF=Instance.new("ScrollingFrame",FP)LF.Size=UDim2.new(1,0,0,200)LF.Position=UDim2.new(0,0,0,36)LF.BackgroundColor3=Theme.Surf LF.BorderSizePixel=0 LF.ScrollBarThickness=3 LF.ScrollBarImageColor3=Theme.Acc LF.CanvasSize=UDim2.new(0,0,0,0)
Instance.new("UICorner",LF).CornerRadius=UDim.new(0,5)
local LL=Instance.new("UIListLayout",LF)LL.SortOrder=Enum.SortOrder.Name LL.Padding=UDim.new(0,3)
Instance.new("UIPadding",LF).PaddingTop=UDim.new(0,4)Instance.new("UIPadding",LF).PaddingLeft=UDim.new(0,4)
LL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()LF.CanvasSize=UDim2.new(0,0,0,LL.AbsoluteContentSize.Y+8)end)

local Rows={}
local function mkRow(pl)
    if Rows[pl]or pl==LP then return end
    local r=Instance.new("TextButton",LF)r.Size=UDim2.new(1,-6,0,28)r.BackgroundColor3=Theme.Surf2 r.Text=""r.AutoButtonColor=false
    Instance.new("UICorner",r).CornerRadius=UDim.new(0,4)
    local nl=Instance.new("TextLabel",r)nl.Size=UDim2.new(1,-80,1,0)nl.Position=UDim2.new(0,8,0,0)nl.BackgroundTransparency=1 nl.Text=pl.Name nl.Font=Enum.Font.Gotham nl.TextSize=12 nl.TextColor3=Theme.Txt nl.TextXAlignment=Enum.TextXAlignment.Left
    local st=Instance.new("TextLabel",r)st.Name="St"st.Size=UDim2.new(0,65,1,0)st.Position=UDim2.new(1,-70,0,0)st.BackgroundTransparency=1 st.Text="IN GAME"st.Font=Enum.Font.GothamBold st.TextSize=10 st.TextColor3=Theme.Ok
    r.MouseButton1Click:Connect(function()
        if S.Sel[pl]then S.Sel[pl]=nil r.BackgroundColor3=Theme.Surf2 else S.Sel[pl]=true r.BackgroundColor3=Theme.AccD end
        updCnt()
    end)
    Rows[pl]={r=r,st=st,nl=nl}
end
local function updCnt()local c=0 for _ in pairs(S.Sel)do c=c+1 end SelL.Text=c.." selected"end
SB:GetPropertyChangedSignal("Text"):Connect(function()
    local f=SB.Text:lower()
    for pl,d in pairs(Rows)do d.r.Visible=(f==""or pl.Name:lower():find(f,1,true))and true or false end
end)

local BB=Instance.new("Frame",FP)BB.Size=UDim2.new(1,0,0,80)BB.Position=UDim2.new(0,0,0,246)BB.BackgroundTransparency=1
local SelL=Instance.new("TextLabel",BB)SelL.Size=UDim2.new(1,0,0,18)SelL.BackgroundTransparency=1 SelL.Text="0 selected"SelL.Font=Enum.Font.Gotham SelL.TextSize=12 SelL.TextColor3=Theme.Dim SelL.TextXAlignment=Enum.TextXAlignment.Left

local function tog(txt,pos,def,cb)
    local b=Instance.new("TextButton",BB)b.Size=UDim2.new(.48,0,0,26)b.Position=pos b.BackgroundColor3=def and Theme.Acc or Theme.Surf2 b.Text=txt..(def and ": ON"or ": OFF")b.Font=Enum.Font.GothamBold b.TextSize=11 b.TextColor3=Theme.Txt
    Instance.new("UICorner",b).CornerRadius=UDim.new(0,4)local on=def
    b.MouseButton1Click:Connect(function()on=not on b.BackgroundColor3=on and Theme.Acc or Theme.Surf2 b.Text=txt..(on and ": ON"or ": OFF")cb(on)end)
end
tog("NOCLIP",UDim2.new(0,0,0,22),false,function(v)S.Noclip=v end)
tog("ANTI-AFK",UDim2.new(.52,0,0,22),true,function(v)S.AntiAFK=v end)

local RB=Instance.new("TextButton",BB)RB.Size=UDim2.new(.48,0,0,26)RB.Position=UDim2.new(0,0,0,52)RB.BackgroundColor3=Theme.Acc RB.Text="REAL FLING"RB.Font=Enum.Font.GothamBold RB.TextSize=11 RB.TextColor3=Theme.Txt
Instance.new("UICorner",RB).CornerRadius=UDim.new(0,4)
local FB=Instance.new("TextButton",BB)FB.Size=UDim2.new(.48,0,0,26)FB.Position=UDim2.new(.52,0,0,52)FB.BackgroundColor3=Theme.Surf2 FB.Text="FAKE FLING"FB.Font=Enum.Font.GothamBold FB.TextSize=11 FB.TextColor3=Theme.Txt
Instance.new("UICorner",FB).CornerRadius=UDim.new(0,4)
RB.MouseButton1Click:Connect(function()S.Style="REAL"RB.BackgroundColor3=Theme.Acc FB.BackgroundColor3=Theme.Surf2 end)
FB.MouseButton1Click:Connect(function()S.Style="FAKE"FB.BackgroundColor3=Theme.Acc RB.BackgroundColor3=Theme.Surf2 end)

local FlBtn=Instance.new("TextButton",FP)FlBtn.Size=UDim2.new(1,0,0,34)FlBtn.Position=UDim2.new(0,0,1,-40)FlBtn.BackgroundColor3=Theme.Acc FlBtn.Text="START FLING"FlBtn.Font=Enum.Font.GothamBold FlBtn.TextSize=14 FlBtn.TextColor3=Theme.Txt
Instance.new("UICorner",FlBtn).CornerRadius=UDim.new(0,6)

-- SPAM
local SP=Pages.SPAM
local function inp(ph,y,def)
    local b=Instance.new("TextBox",SP)b.Size=UDim2.new(1,0,0,30)b.Position=UDim2.new(0,0,0,y)b.BackgroundColor3=Theme.Surf b.PlaceholderText=ph b.Text=def or""b.Font=Enum.Font.Gotham b.TextSize=12 b.TextColor3=Theme.Txt b.PlaceholderColor3=Theme.Dim b.ClearTextOnFocus=false
    Instance.new("UICorner",b).CornerRadius=UDim.new(0,5)Instance.new("UIPadding",b).PaddingLeft=UDim.new(0,10)return b
end
local TBox=inp("Target name (optional)",0,"")
local DBox=inp("Delay (seconds)",36,"3.5")
local NBox=inp("Your name",72,LP.Name)
local SyBox=inp("Symbols (e.g. @#!)",108,"")
local MBox=inp("Message",144,S.Msg)MBox.Size=UDim2.new(1,0,0,70)MBox.TextWrapped=true MBox.TextYAlignment=Enum.TextYAlignment.Top
local SpBtn=Instance.new("TextButton",SP)SpBtn.Size=UDim2.new(1,0,0,36)SpBtn.Position=UDim2.new(0,0,0,230)SpBtn.BackgroundColor3=Theme.Acc SpBtn.Text="START SPAM"SpBtn.Font=Enum.Font.GothamBold SpBtn.TextSize=14 SpBtn.TextColor3=Theme.Txt
Instance.new("UICorner",SpBtn).CornerRadius=UDim.new(0,6)

-- TARGETS
local TP=Pages.TARGETS
local TT=Instance.new("TextLabel",TP)TT.Size=UDim2.new(1,0,0,20)TT.BackgroundTransparency=1 TT.Text="TRACKED TARGETS"TT.Font=Enum.Font.GothamBold TT.TextSize=13 TT.TextColor3=Theme.Txt TT.TextXAlignment=Enum.TextXAlignment.Left
local TL2=Instance.new("ScrollingFrame",TP)TL2.Size=UDim2.new(1,0,1,-28)TL2.Position=UDim2.new(0,0,0,24)TL2.BackgroundColor3=Theme.Surf TL2.BorderSizePixel=0 TL2.ScrollBarThickness=3 TL2.ScrollBarImageColor3=Theme.Acc
Instance.new("UICorner",TL2).CornerRadius=UDim.new(0,5)
local TLay=Instance.new("UIListLayout",TL2)TLay.Padding=UDim.new(0,4)
Instance.new("UIPadding",TL2).PaddingTop=UDim.new(0,6)Instance.new("UIPadding",TL2).PaddingLeft=UDim.new(0,6)
local TRows={}
local function refTrack()
    for _,r in pairs(TRows)do r:Destroy()end TRows={}
    local c=0
    for pl in pairs(S.Sel)do
        c=c+1
        local r=Instance.new("Frame",TL2)r.Size=UDim2.new(1,-8,0,32)r.BackgroundColor3=Theme.Surf2
        Instance.new("UICorner",r).CornerRadius=UDim.new(0,4)
        local n=Instance.new("TextLabel",r)n.Size=UDim2.new(1,-80,1,0)n.Position=UDim2.new(0,8,0,0)n.BackgroundTransparency=1 n.Text=pl.Name n.Font=Enum.Font.Gotham n.TextSize=12 n.TextColor3=Theme.Txt n.TextXAlignment=Enum.TextXAlignment.Left
        local st=Instance.new("TextLabel",r)st.Size=UDim2.new(0,65,1,0)st.Position=UDim2.new(1,-70,0,0)st.BackgroundTransparency=1 st.Font=Enum.Font.GothamBold st.TextSize=10
        if pl.Parent then st.Text="IN GAME"st.TextColor3=Theme.Ok else st.Text="LEFT"st.TextColor3=Theme.Off end
        table.insert(TRows,r)
    end
    if c==0 then
        local e=Instance.new("TextLabel",TL2)e.Size=UDim2.new(1,0,0,40)e.BackgroundTransparency=1 e.Text="No targets selected.\nSelect in FLING tab."e.Font=Enum.Font.Gotham e.TextSize=12 e.TextColor3=Theme.Dim e.TextWrapped=true
        table.insert(TRows,e)
    end
    TL2.CanvasSize=UDim2.new(0,0,0,TLay.AbsoluteContentSize.Y+12)
end

-- Logic
for _,pl in ipairs(P:GetPlayers())do mkRow(pl)end
P.PlayerAdded:Connect(mkRow)
P.PlayerRemoving:Connect(function(pl)
    if Rows[pl]then Rows[pl].st.Text="LEFT"Rows[pl].st.TextColor3=Theme.Off Rows[pl].nl.TextColor3=Theme.Off end
    task.delay(.1,refTrack)
end)

task.spawn(function()
    while SG.Parent do
        for pl,d in pairs(Rows)do
            if pl.Parent then d.st.Text="IN GAME"d.st.TextColor3=Theme.Ok d.nl.TextColor3=Theme.Txt
            else d.st.Text="LEFT"d.st.TextColor3=Theme.Off d.nl.TextColor3=Theme.Off end
        end
        refTrack()task.wait(.8)
    end
end)

RS.Stepped:Connect(function()
    if S.Noclip and LP.Character then
        for _,p in ipairs(LP.Character:GetDescendants())do if p:IsA("BasePart")then p.CanCollide=false end end
    end
end)
local VU=game:GetService("VirtualUser")
LP.Idled:Connect(function()if S.AntiAFK then VU:CaptureController()VU:ClickButton2(Vector2.new())end end)

local function root(c)return c and(c:FindFirstChild("HumanoidRootPart")or c:FindFirstChild("Torso")or c:FindFirstChild("UpperTorso"))end
FlBtn.MouseButton1Click:Connect(function()
    S.Fling=not S.Fling
    FlBtn.Text=S.Fling and"STOP FLING"or"START FLING"
    FlBtn.BackgroundColor3=S.Fling and Theme.AccD or Theme.Acc
end)
RS.Heartbeat:Connect(function()
    if not S.Fling then return end
    local mr=root(LP.Character)if not mr then return end
    for pl in pairs(S.Sel)do
        if pl.Parent and pl.Character then
            local tr=root(pl.Character)
            if tr then
                if S.Style=="REAL"then
                    local bv=Instance.new("BodyVelocity")bv.MaxForce=Vector3.new(1e9,1e9,1e9)bv.Velocity=Vector3.new()bv.Parent=mr
                    mr.CFrame=tr.CFrame task.defer(function()if bv then bv:Destroy()end end)
                    local bv2=Instance.new("BodyVelocity")bv2.MaxForce=Vector3.new(1e9,1e9,1e9)bv2.Velocity=Vector3.new(9999,9999,9999)bv2.Parent=tr
                    task.delay(.05,function()if bv2 then bv2:Destroy()end end)
                else tr.RotVelocity=Vector3.new(9999,9999,9999)end
            end
        end
    end
end)

local function chat(msg)
    pcall(function()
        if TCS.ChatVersion==Enum.ChatVersion.TextChatService then
            local ch=TCS.TextChannels:FindFirstChild("RBXGeneral")if ch then ch:SendAsync(msg)end
        else
            local ev=game:GetService("ReplicatedStorage"):FindFirstChild("DefaultChatSystemChatEvents")
            if ev and ev:FindFirstChild("SayMessageRequest")then ev.SayMessageRequest:FireServer(msg,"All")end
        end
    end)
end
SpBtn.MouseButton1Click:Connect(function()
    S.Spam=not S.Spam
    SpBtn.Text=S.Spam and"STOP SPAM"or"START SPAM"
    SpBtn.BackgroundColor3=S.Spam and Theme.AccD or Theme.Acc
    if S.Spam then
        S.Delay=tonumber(DBox.Text)or 3.5 S.Msg=MBox.Text S.Target=TBox.Text S.Name=NBox.Text S.Sym=SyBox.Text
        task.spawn(function()
            while S.Spam and SG.Parent do
                local m=S.Msg
                if S.Target~=""then m=S.Target.." "..m end
                if S.Sym~=""then m=S.Sym.." "..m.." "..S.Sym end
                if S.Name~=""then m=m.." | "..S.Name end
                chat(m)task.wait(S.Delay)
            end
        end)
    end
end)

print("[ASURA] Loaded")
