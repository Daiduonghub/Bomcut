-- Kairos UI Library | Purple Glass
-- Reusable Roblox LuaU UI library. Intended for experiences you own/control.
-- API: CreateWindow, CreateTab, CreateButton, CreateToggle, CreateSlider,
--      CreateDropdown, CreateTextBox, CreateLabel, SetTheme, Notify

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")

local Library = {Version = "1.0.0", Tabs = {}, ThemeName = "Purple Glass"}
local LocalPlayer = Players.LocalPlayer
local Themes = {
    ["Purple Glass"] = Color3.fromRGB(180, 100, 255),
    ["Cyan Neon"] = Color3.fromRGB(0, 210, 255),
    ["Ocean Blue"] = Color3.fromRGB(65, 130, 255),
    ["Pink Bubble"] = Color3.fromRGB(255, 105, 195),
    ["Emerald"] = Color3.fromRGB(55, 220, 145),
    ["Sunset Orange"] = Color3.fromRGB(255, 145, 70),
    ["Gold"] = Color3.fromRGB(255, 205, 75),
    ["Rose Red"] = Color3.fromRGB(245, 75, 105),
}
local Accent = Themes[Library.ThemeName]
local Registry = {accent = {}, strokes = {}, tabs = {}, text = {}}
local function tween(o, t, props)
    local x = TweenService:Create(o, TweenInfo.new(t or .18, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), props)
    x:Play(); return x
end
local function new(class, props, parent)
    local o = Instance.new(class)
    for k,v in pairs(props or {}) do o[k] = v end
    o.Parent = parent
    return o
end
local function corner(o, r) new("UICorner", {CornerRadius = UDim.new(0, r or 10)}, o) end
local function stroke(o, color, transparency)
    local s = new("UIStroke", {Color = color or Accent, Thickness = 1, Transparency = transparency or .45}, o)
    table.insert(Registry.strokes, s); return s
end
local function text(parent, value, size, color, font)
    local o = new("TextLabel", {BackgroundTransparency = 1, Text = tostring(value), TextSize = size or 13,
        TextColor3 = color or Color3.fromRGB(245,239,255), Font = font or Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Center,
        TextWrapped = true}, parent)
    table.insert(Registry.text, o); return o
end
local function card(parent, height)
    local f = new("Frame", {Size = UDim2.new(1,-4,0,height), BackgroundColor3 = Color3.fromRGB(35,25,54),
        BackgroundTransparency = .08, BorderSizePixel = 0}, parent)
    corner(f, 11); stroke(f, Accent, .72); return f
end
local function makeButton(parent, caption, height)
    local b = new("TextButton", {Size = UDim2.new(1,-4,0,height or 38), BackgroundColor3 = Accent,
        BackgroundTransparency = .18, BorderSizePixel = 0, Text = caption, TextColor3 = Color3.new(1,1,1),
        TextSize = 13, Font = Enum.Font.GothamSemibold, AutoButtonColor = false}, parent)
    corner(b, 9); table.insert(Registry.accent,b)
    b.MouseEnter:Connect(function() tween(b,.12,{BackgroundTransparency=.04}) end)
    b.MouseLeave:Connect(function() tween(b,.12,{BackgroundTransparency=.18}) end)
    return b
end

function Library:CreateWindow(options)
    options = options or {}
    local guiParent = options.Parent
    if not guiParent then
        if not LocalPlayer then error("CreateWindow must run on the client") end
        guiParent = LocalPlayer:WaitForChild("PlayerGui")
    end
    local gui = new("ScreenGui", {Name = options.Name or "KairosUI", ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling, DisplayOrder = 50}, guiParent)
    local main = new("Frame", {Name="Main", AnchorPoint=Vector2.new(.5,.5), Position=UDim2.fromScale(.5,.5),
        Size=UDim2.fromOffset(options.Width or 650, options.Height or 420), BackgroundColor3=Color3.fromRGB(17,12,28),
        BorderSizePixel=0, ClipsDescendants=true}, gui)
    corner(main,15); local mainStroke = stroke(main,Accent,.18)
    new("UIGradient", {Color=ColorSequence.new(Color3.fromRGB(17,12,28),Color3.fromRGB(43,25,65)),Rotation=28},main)
    local scale = new("UIScale", {Scale=1}, main)
    local function resize()
        local cam=workspace.CurrentCamera; if not cam then return end
        local v=cam.ViewportSize
        scale.Scale=math.clamp(math.min(v.X/(main.Size.X.Offset+20),v.Y/(main.Size.Y.Offset+40),1),.45,1)
    end
    if workspace.CurrentCamera then workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(resize) end
    resize()
    local header = new("Frame", {Size=UDim2.new(1,0,0,54),BackgroundColor3=Color3.fromRGB(27,18,43),BorderSizePixel=0,Active=true},main)
    local logo = new("Frame", {Position=UDim2.fromOffset(12,10),Size=UDim2.fromOffset(34,34),BackgroundColor3=Accent,BorderSizePixel=0},header); corner(logo,10)
    local lt=text(logo, "K", 19, Color3.new(1,1,1), Enum.Font.GothamBold); lt.Size=UDim2.fromScale(1,1); lt.TextXAlignment=Enum.TextXAlignment.Center
    local title=text(header,options.Title or "KAIROS HUB",16,Color3.fromRGB(249,242,255),Enum.Font.GothamBold); title.Position=UDim2.fromOffset(56,4); title.Size=UDim2.new(1,-150,0,26)
    local subtitle=text(header,options.Subtitle or "PURPLE GLASS UI LIBRARY",9,Color3.fromRGB(180,160,205)); subtitle.Position=UDim2.fromOffset(57,28); subtitle.Size=UDim2.new(1,-150,0,15)
    local close=makeButton(header,"×",30); close.Size=UDim2.fromOffset(30,30); close.Position=UDim2.new(1,-40,0,12); close.TextSize=20
    local minimize=makeButton(header,"−",30); minimize.Size=UDim2.fromOffset(30,30); minimize.Position=UDim2.new(1,-76,0,12); minimize.TextSize=19
    local sidebar=new("Frame",{Position=UDim2.fromOffset(0,54),Size=UDim2.new(0,150,1,-54),BackgroundColor3=Color3.fromRGB(25,17,40),BorderSizePixel=0},main)
    local navTitle=text(sidebar,"NAVIGATION",9,Color3.fromRGB(170,150,195),Enum.Font.GothamBold); navTitle.Position=UDim2.fromOffset(13,12); navTitle.Size=UDim2.new(1,-20,0,22)
    local nav=new("Frame",{Position=UDim2.fromOffset(8,40),Size=UDim2.new(1,-16,1,-50),BackgroundTransparency=1},sidebar)
    new("UIListLayout",{Padding=UDim.new(0,6),SortOrder=Enum.SortOrder.LayoutOrder},nav)
    local content=new("Frame",{Position=UDim2.fromOffset(150,54),Size=UDim2.new(1,-150,1,-54),BackgroundTransparency=1,ClipsDescendants=true},main)
    local pageTitle=text(content,"Dashboard",21,Color3.fromRGB(248,242,255),Enum.Font.GothamBold); pageTitle.Position=UDim2.fromOffset(16,12); pageTitle.Size=UDim2.new(1,-32,0,30)
    local desc=text(content,"Create controls with simple library functions.",10,Color3.fromRGB(174,157,199)); desc.Position=UDim2.fromOffset(16,41); desc.Size=UDim2.new(1,-32,0,20)
    local pages=new("Frame",{Position=UDim2.fromOffset(14,67),Size=UDim2.new(1,-28,1,-80),BackgroundTransparency=1},content)
    local window={Gui=gui,Main=main,Tabs={},Options=options}
    local dragging, dragStart, startPos
    header.InputBegan:Connect(function(input)
        if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
            dragging=true; dragStart=input.Position; startPos=main.Position
            input.Changed:Connect(function() if input.UserInputState==Enum.UserInputState.End then dragging=false end end)
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch) then
            local d=input.Position-dragStart
            main.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+d.X,startPos.Y.Scale,startPos.Y.Offset+d.Y)
        end
    end)
    local minimized=false
    minimize.Activated:Connect(function()
        minimized=not minimized; sidebar.Visible=not minimized; content.Visible=not minimized
        tween(main,.2,{Size=minimized and UDim2.fromOffset(options.Width or 650,54) or UDim2.fromOffset(options.Width or 650,options.Height or 420)})
        minimize.Text=minimized and "+" or "−"
    end)
    close.Activated:Connect(function() gui:Destroy() end)
    function window:SetTheme(themeName)
        if not Themes[themeName] then return false end
        Accent=Themes[themeName]; Library.ThemeName=themeName; mainStroke.Color=Accent
        for _,o in ipairs(Registry.accent) do if o.Parent then o.BackgroundColor3=Accent end end
        for _,s in ipairs(Registry.strokes) do if s.Parent then s.Color=Accent end end
        for _,tab in ipairs(window.Tabs) do tab.Button.TextColor3=Color3.fromRGB(245,239,255) end
        return true
    end
    function window:Notify(message,duration)
        local n=new("TextLabel",{AnchorPoint=Vector2.new(1,0),Position=UDim2.new(1,-12,0,65),Size=UDim2.fromOffset(240,42),BackgroundColor3=Color3.fromRGB(35,25,54),Text=tostring(message),TextColor3=Color3.fromRGB(245,239,255),TextSize=12,Font=Enum.Font.Gotham,TextWrapped=true,BorderSizePixel=0},gui)
        corner(n,10); stroke(n,Accent,.25); n.BackgroundTransparency=1; n.TextTransparency=1
        tween(n,.2,{BackgroundTransparency=.05,TextTransparency=0})
        task.delay(duration or 2.5,function() if n.Parent then tween(n,.2,{BackgroundTransparency=1,TextTransparency=1}); task.wait(.22); if n.Parent then n:Destroy() end end end)
    end
    function window:CreateTab(name)
        local btn=makeButton(nav,tostring(name),34); btn.BackgroundColor3=Color3.fromRGB(42,29,59); btn.BackgroundTransparency=.25; btn.TextXAlignment=Enum.TextXAlignment.Left
        local pad=new("UIPadding",{PaddingLeft=UDim.new(0,10)},btn)
        local page=new("ScrollingFrame",{Name=tostring(name),Size=UDim2.fromScale(1,1),BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=3,ScrollBarImageColor3=Accent,CanvasSize=UDim2.new(),AutomaticCanvasSize=Enum.AutomaticSize.Y,Visible=false},pages)
        new("UIListLayout",{Padding=UDim.new(0,8),SortOrder=Enum.SortOrder.LayoutOrder},page)
        new("UIPadding",{PaddingTop=UDim.new(0,3),PaddingBottom=UDim.new(0,6)},page)
        local tab={Name=name,Button=btn,Frame=page,Window=window}; table.insert(window.Tabs,tab)
        btn.Activated:Connect(function()
            for _,t in ipairs(window.Tabs) do t.Frame.Visible=false; tween(t.Button,.15,{BackgroundColor3=Color3.fromRGB(42,29,59),BackgroundTransparency=.25}) end
            page.Visible=true; pageTitle.Text=tostring(name); tween(btn,.15,{BackgroundColor3=Accent,BackgroundTransparency=.08})
            page.Position=UDim2.fromOffset(8,0); tween(page,.2,{Position=UDim2.fromOffset(0,0)})
            window.CurrentTab=tab
        end)
        if #window.Tabs==1 then btn:Activate() end
        function tab:CreateLabel(caption)
            local l=text(page,caption,12,Color3.fromRGB(206,190,225),Enum.Font.GothamMedium); l.Size=UDim2.new(1,-6,0,28); return l
        end
        function tab:CreateButton(caption,callback)
            local b=makeButton(page,caption,38)
            b.Activated:Connect(function() tween(b,.08,{Size=UDim2.new(1,-8,0,36)}); task.delay(.08,function() if b.Parent then tween(b,.12,{Size=UDim2.new(1,-4,0,38)}) end end); if callback then task.spawn(callback) end end)
            return {Instance=b}
        end
        function tab:CreateToggle(caption,default,callback)
            local f=card(page,44); local l=text(f,caption,12,Color3.fromRGB(245,239,255),Enum.Font.GothamMedium); l.Position=UDim2.fromOffset(12,0); l.Size=UDim2.new(1,-75,1,0)
            local track=new("TextButton",{AnchorPoint=Vector2.new(1,.5),Position=UDim2.new(1,-10,.5,0),Size=UDim2.fromOffset(42,23),BackgroundColor3=default and Accent or Color3.fromRGB(75,65,88),Text="",BorderSizePixel=0,AutoButtonColor=false},f); corner(track,12); table.insert(Registry.accent,track)
            local knob=new("Frame",{Position=default and UDim2.new(1,-21,.5,-8) or UDim2.new(0,3,.5,-8),Size=UDim2.fromOffset(16,16),BackgroundColor3=Color3.new(1,1,1),BorderSizePixel=0},track); corner(knob,10)
            local value=default==true; local function set(v) value=v; tween(track,.18,{BackgroundColor3=v and Accent or Color3.fromRGB(75,65,88)}); tween(knob,.18,{Position=v and UDim2.new(1,-21,.5,-8) or UDim2.new(0,3,.5,-8)}); if callback then callback(v) end end
            track.Activated:Connect(function() set(not value) end)
            return {Instance=f,Get=function() return value end,Set=set}
        end
        function tab:CreateSlider(caption,min,max,default,callback)
            min=tonumber(min) or 0; max=tonumber(max) or 100; if max<=min then max=min+1 end
            local f=card(page,62); local l=text(f,caption,12,Color3.fromRGB(245,239,255),Enum.Font.GothamMedium); l.Position=UDim2.fromOffset(12,4); l.Size=UDim2.new(1,-85,0,22)
            local val=text(f,tostring(default or min),11,Accent,Enum.Font.GothamBold); val.TextXAlignment=Enum.TextXAlignment.Right; val.Position=UDim2.new(1,-65,0,4); val.Size=UDim2.fromOffset(52,22)
            local bar=new("Frame",{Position=UDim2.new(0,12,0,39),Size=UDim2.new(1,-24,0,6),BackgroundColor3=Color3.fromRGB(72,58,91),BorderSizePixel=0},f); corner(bar,5)
            local pct=math.clamp(((tonumber(default) or min)-min)/(max-min),0,1)
            local fill=new("Frame",{Size=UDim2.new(pct,0,1,0),BackgroundColor3=Accent,BorderSizePixel=0},bar); corner(fill,5); table.insert(Registry.accent,fill)
            local knob=new("Frame",{AnchorPoint=Vector2.new(.5,.5),Position=UDim2.new(pct,0,.5,0),Size=UDim2.fromOffset(14,14),BackgroundColor3=Color3.new(1,1,1),BorderSizePixel=0},bar); corner(knob,8)
            local value=tonumber(default) or min; local held=false
            local function setFromX(x) local p=math.clamp((x-bar.AbsolutePosition.X)/bar.AbsoluteSize.X,0,1); value=math.floor(min+(max-min)*p+.5); tween(fill,.05,{Size=UDim2.new(p,0,1,0)}); tween(knob,.05,{Position=UDim2.new(p,0,.5,0)}); val.Text=tostring(value); if callback then callback(value) end end
            bar.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then held=true; setFromX(i.Position.X) end end)
            UserInputService.InputChanged:Connect(function(i) if held and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then setFromX(i.Position.X) end end)
            UserInputService.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then held=false end end)
            return {Instance=f,Get=function() return value end,Set=function(v) setFromX(bar.AbsolutePosition.X+bar.AbsoluteSize.X*((math.clamp(v,min,max)-min)/(max-min))) end}
        end
        function tab:CreateDropdown(caption,options,default,callback)
            local f=card(page,42); f.ClipsDescendants=false
            local b=makeButton(f,tostring(caption).."   ▾   "..tostring(default or options[1] or "Select"),34); b.Position=UDim2.fromOffset(5,4); b.Size=UDim2.new(1,-10,0,34); b.TextXAlignment=Enum.TextXAlignment.Left; new("UIPadding",{PaddingLeft=UDim.new(0,8)},b)
            local list=new("Frame",{Position=UDim2.new(0,5,0,40),Size=UDim2.new(1,-10,0,0),BackgroundColor3=Color3.fromRGB(35,25,54),BorderSizePixel=0,ClipsDescendants=true,ZIndex=5,Visible=false},f); corner(list,8); stroke(list,Accent,.35)
            local layout=new("UIListLayout",{Padding=UDim.new(0,3)},list)
            local value=default or options[1]
            for _,opt in ipairs(options) do local ob=makeButton(list,tostring(opt),28); ob.Size=UDim2.new(1,-6,0,28); ob.Position=UDim2.fromOffset(3,0); ob.ZIndex=6; ob.Activated:Connect(function() value=opt; b.Text=tostring(caption).."   ▾   "..tostring(value); list.Visible=false; f.Size=UDim2.new(1,-4,0,42); if callback then callback(value) end end) end
            b.Activated:Connect(function() list.Visible=not list.Visible; local h=list.Visible and math.min(#options*31,155) or 0; f.Size=UDim2.new(1,-4,0,42+h); tween(list,.18,{Size=UDim2.new(1,-10,0,h)}) end)
            return {Instance=f,Get=function() return value end,Set=function(v) if table.find(options,v) then value=v; b.Text=tostring(caption).."   ▾   "..tostring(v); if callback then callback(v) end end end}
        end
        function tab:CreateTextBox(caption,default,callback)
            local f=card(page,54); local l=text(f,caption,11,Color3.fromRGB(245,239,255),Enum.Font.GothamMedium); l.Position=UDim2.fromOffset(10,3); l.Size=UDim2.new(1,-20,0,19)
            local box=new("TextBox",{Position=UDim2.fromOffset(9,25),Size=UDim2.new(1,-18,0,23),BackgroundColor3=Color3.fromRGB(24,17,38),Text=tostring(default or ""),PlaceholderText="Enter value...",TextColor3=Color3.fromRGB(245,239,255),PlaceholderColor3=Color3.fromRGB(150,135,170),TextSize=11,Font=Enum.Font.Gotham,ClearTextOnFocus=false,BorderSizePixel=0},f); corner(box,6); stroke(box,Accent,.65)
            box.FocusLost:Connect(function(enter) if callback then callback(box.Text,enter) end end)
            return {Instance=f,Get=function() return box.Text end,Set=function(v) box.Text=tostring(v) end}
        end
        return tab
    end
    return window
end

function Library:SetTheme(name)
    if not Themes[name] then return false end
    Accent=Themes[name]; self.ThemeName=name
    for _,o in ipairs(Registry.accent) do if o.Parent then o.BackgroundColor3=Accent end end
    for _,s in ipairs(Registry.strokes) do if s.Parent then s.Color=Accent end end
    return true
end
Library.Themes = Themes
return Library
