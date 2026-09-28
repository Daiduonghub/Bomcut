-- ============================================================
-- UI LIBRARY "ABYSSALHUB"
-- ============================================================
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LP = Players.LocalPlayer

if CoreGui:FindFirstChild("AbyssalHub") then
    CoreGui.AbyssalHub:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AbyssalHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 520, 0, 360)
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -180)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 8, 18)
MainFrame.BackgroundTransparency = 0.05
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 18)
MainCorner.Parent = MainFrame

local MainGradient = Instance.new("UIGradient")
MainGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(15, 10, 30)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(8, 5, 20)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 10, 40))
}
MainGradient.Rotation = 135
MainGradient.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(140, 60, 255)
MainStroke.Thickness = 1.5
MainStroke.Transparency = 0.15
MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
MainStroke.Parent = MainFrame

task.spawn(function()
    while MainFrame.Parent do
        TweenService:Create(MainStroke, TweenInfo.new(2.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Transparency = 0.65, Color = Color3.fromRGB(80, 180, 255)}):Play()
        task.wait(2.5)
        TweenService:Create(MainStroke, TweenInfo.new(2.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Transparency = 0.15, Color = Color3.fromRGB(140, 60, 255)}):Play()
        task.wait(2.5)
    end
end)

local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Size = UDim2.new(1, 0, 0, 52)
Header.BackgroundTransparency = 1
Header.Parent = MainFrame

local HeaderLine = Instance.new("Frame")
HeaderLine.Size = UDim2.new(1, -24, 0, 1)
HeaderLine.Position = UDim2.new(0, 12, 1, -1)
HeaderLine.BackgroundColor3 = Color3.fromRGB(140, 60, 255)
HeaderLine.BackgroundTransparency = 0.5
HeaderLine.BorderSizePixel = 0
HeaderLine.Parent = Header

local LogoDot = Instance.new("Frame")
LogoDot.Size = UDim2.new(0, 10, 0, 10)
LogoDot.Position = UDim2.new(0, 20, 0.5, -5)
LogoDot.BackgroundColor3 = Color3.fromRGB(140, 60, 255)
LogoDot.BorderSizePixel = 0
LogoDot.Parent = Header

local LogoCorner = Instance.new("UICorner")
LogoCorner.CornerRadius = UDim.new(1, 0)
LogoCorner.Parent = LogoDot

task.spawn(function()
    while LogoDot.Parent do
        TweenService:Create(LogoDot, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {BackgroundColor3 = Color3.fromRGB(80, 180, 255)}):Play()
        task.wait(1.5)
        TweenService:Create(LogoDot, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {BackgroundColor3 = Color3.fromRGB(140, 60, 255)}):Play()
        task.wait(1.5)
    end
end)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -60, 1, 0)
Title.Position = UDim2.new(0, 38, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "ABYSSALHUB"
Title.TextColor3 = Color3.fromRGB(235, 225, 255)
Title.TextSize = 21
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local SubTitle = Instance.new("TextLabel")
SubTitle.Size = UDim2.new(0, 80, 1, 0)
SubTitle.Position = UDim2.new(0, 178, 0, 0)
SubTitle.BackgroundTransparency = 1
SubTitle.Text = "v1.0"
SubTitle.TextColor3 = Color3.fromRGB(140, 60, 255)
SubTitle.TextSize = 12
SubTitle.Font = Enum.Font.Gotham
SubTitle.TextXAlignment = Enum.TextXAlignment.Left
SubTitle.Parent = Header

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 32, 0, 32)
CloseBtn.Position = UDim2.new(1, -42, 0, 10)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 90)
CloseBtn.BackgroundTransparency = 0.85
CloseBtn.Text = "×"
CloseBtn.TextColor3 = Color3.fromRGB(255, 200, 210)
CloseBtn.TextSize = 22
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.BorderSizePixel = 0
CloseBtn.Parent = Header

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseBtn

CloseBtn.MouseEnter:Connect(function()
    TweenService:Create(CloseBtn, TweenInfo.new(0.15), {BackgroundTransparency = 0.5, TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
end)
CloseBtn.MouseLeave:Connect(function()
    TweenService:Create(CloseBtn, TweenInfo.new(0.15), {BackgroundTransparency = 0.85, TextColor3 = Color3.fromRGB(255, 200, 210)}):Play()
end)

-- ============================================================
-- КНОПКА РАЗВОРАЧИВАНИЯ (КРАСИВАЯ ИКОНКА)
-- ============================================================
local MaximizeBtn = Instance.new("TextButton")
MaximizeBtn.Size = UDim2.new(0, 32, 0, 32)
MaximizeBtn.Position = UDim2.new(1, -80, 0, 10)
MaximizeBtn.BackgroundColor3 = Color3.fromRGB(80, 180, 255)
MaximizeBtn.BackgroundTransparency = 0.85
MaximizeBtn.Text = ""
MaximizeBtn.BorderSizePixel = 0
MaximizeBtn.Parent = Header

local MaxCorner = Instance.new("UICorner")
MaxCorner.CornerRadius = UDim.new(0, 8)
MaxCorner.Parent = MaximizeBtn

-- Иконка развернуть (две стрелки в углы)
local MaximizeIcon = Instance.new("ImageLabel")
MaximizeIcon.Name = "MaximizeIcon"
MaximizeIcon.Size = UDim2.new(0, 16, 0, 16)
MaximizeIcon.Position = UDim2.new(0.5, -8, 0.5, -8)
MaximizeIcon.BackgroundTransparency = 1
MaximizeIcon.Image = "rbxassetid://10709798950"
MaximizeIcon.ImageColor3 = Color3.fromRGB(200, 230, 255)
MaximizeIcon.Parent = MaximizeBtn

-- Иконка свернуть (две стрелки внутрь)
local MinimizeIcon = Instance.new("ImageLabel")
MinimizeIcon.Name = "MinimizeIcon"
MinimizeIcon.Size = UDim2.new(0, 16, 0, 16)
MinimizeIcon.Position = UDim2.new(0.5, -8, 0.5, -8)
MinimizeIcon.BackgroundTransparency = 1
MinimizeIcon.Image = "rbxassetid://10709799483"
MinimizeIcon.ImageColor3 = Color3.fromRGB(200, 230, 255)
MinimizeIcon.Visible = false
MinimizeIcon.Parent = MaximizeBtn

MaximizeBtn.MouseEnter:Connect(function()
    TweenService:Create(MaximizeBtn, TweenInfo.new(0.15), {BackgroundTransparency = 0.5}):Play()
    TweenService:Create(MaximizeIcon, TweenInfo.new(0.15), {ImageColor3 = Color3.fromRGB(255, 255, 255)}):Play()
    TweenService:Create(MinimizeIcon, TweenInfo.new(0.15), {ImageColor3 = Color3.fromRGB(255, 255, 255)}):Play()
end)
MaximizeBtn.MouseLeave:Connect(function()
    TweenService:Create(MaximizeBtn, TweenInfo.new(0.15), {BackgroundTransparency = 0.85}):Play()
    TweenService:Create(MaximizeIcon, TweenInfo.new(0.15), {ImageColor3 = Color3.fromRGB(200, 230, 255)}):Play()
    TweenService:Create(MinimizeIcon, TweenInfo.new(0.15), {ImageColor3 = Color3.fromRGB(200, 230, 255)}):Play()
end)

local SideBar = Instance.new("Frame")
SideBar.Name = "SideBar"
SideBar.Size = UDim2.new(0, 120, 1, -66)
SideBar.Position = UDim2.new(0, 8, 0, 58)
SideBar.BackgroundColor3 = Color3.fromRGB(6, 4, 14)
SideBar.BackgroundTransparency = 0.35
SideBar.BorderSizePixel = 0
SideBar.Parent = MainFrame

local SideCorner = Instance.new("UICorner")
SideCorner.CornerRadius = UDim.new(0, 12)
SideCorner.Parent = SideBar

local SideLayout = Instance.new("UIListLayout")
SideLayout.Padding = UDim.new(0, 6)
SideLayout.SortOrder = Enum.SortOrder.LayoutOrder
SideLayout.Parent = SideBar

local SidePadding = Instance.new("UIPadding")
SidePadding.PaddingTop = UDim.new(0, 8)
SidePadding.PaddingLeft = UDim.new(0, 8)
SidePadding.PaddingRight = UDim.new(0, 8)
SidePadding.Parent = SideBar

local ContentArea = Instance.new("Frame")
ContentArea.Name = "ContentArea"
ContentArea.Size = UDim2.new(1, -140, 1, -74)
ContentArea.Position = UDim2.new(0, 132, 0, 66)
ContentArea.BackgroundTransparency = 1
ContentArea.Parent = MainFrame

-- ============================================================
-- API
-- ============================================================
local Library = {}
Library.Tabs = {}
Library.CurrentTab = nil

--- ============================================================
-- GLOBAL VARS (KHAI BÁO TRƯỚC ĐỂ TOGGLE KHÔNG LỖI)
-- ============================================================
-- State
_G.Aim = { Enabled = false, FOV = 150, Smooth = 0.15, Team = false, WallCheck = true, Part = "Head", Key = Enum.UserInputType.MouseButton2 }
_G.Silent = { Enabled = false, FOV = 200, Team = false }
_G.Trig = { Enabled = false, Delay = 0.05, Range = 30, Team = false }
_G.ESP = { Box = false, Name = false, Health = false, Dist = false, Tracer = false, Skeleton = false, Team = true }
_G.Move = { Speed = false, SpeedVal = 50, Jump = false, JumpVal = 100, Fly = false, FlySpeed = 50, Noclip = false }

-- ============================================================
-- HIGHLIGHT PLAYER KHI BẬT AUTO FARM
-- ============================================================
local PlayerHighlight = nil

AddHighlight = function()
    local char = LP.Character
    if not char then return end
    
    -- Xóa cũ nếu có
    if PlayerHighlight then
        pcall(function() PlayerHighlight:Destroy() end)
        PlayerHighlight = nil
    end
    
    -- Tạo Highlight (màu fill)
    PlayerHighlight = Instance.new("Highlight")
    PlayerHighlight.Name = "AbyssalHighlight"
    PlayerHighlight.FillColor = Color3.fromRGB(140, 60, 255)
    PlayerHighlight.OutlineColor = Color3.fromRGB(200, 180, 255)
    PlayerHighlight.FillTransparency = 0.5
    PlayerHighlight.OutlineTransparency = 0
    PlayerHighlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    PlayerHighlight.Adornee = char
    PlayerHighlight.Parent = char
end

RemoveHighlight = function()
    if PlayerHighlight then
        pcall(function() PlayerHighlight:Destroy() end)
        PlayerHighlight = nil
    end
    
    local char = LP.Character
    if char then
        for _, child in ipairs(char:GetChildren()) do
            if child.Name == "AbyssalHighlight" then
                pcall(function() child:Destroy() end)
            end
        end
    end
end

local ActiveNotifications = {}

local function UpdateNotifPositions()
    for i, notif in ipairs(ActiveNotifications) do
        if notif and notif.Parent then
            local targetY = -90 - ((i - 1) * 80) -- mỗi notify cách 80px
            TweenService:Create(notif, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Position = UDim2.new(1, -340, 1, targetY)
            }):Play()
        end
    end
end

function Library:Notify(title, text, duration)
    duration = duration or 4
    
    local NotifFrame = Instance.new("Frame")
    NotifFrame.Size = UDim2.new(0, 320, 0, 70)
    NotifFrame.BackgroundColor3 = Color3.fromRGB(14, 10, 26)
    NotifFrame.BackgroundTransparency = 0.05
    NotifFrame.BorderSizePixel = 0
    NotifFrame.Parent = ScreenGui
    
    local NotifCorner = Instance.new("UICorner")
    NotifCorner.CornerRadius = UDim.new(0, 12)
    NotifCorner.Parent = NotifFrame
    
    local NotifStroke = Instance.new("UIStroke")
    NotifStroke.Color = Color3.fromRGB(140, 60, 255)
    NotifStroke.Thickness = 1
    NotifStroke.Transparency = 0.3
    NotifStroke.Parent = NotifFrame
    
    local Accent = Instance.new("Frame")
    Accent.Size = UDim2.new(0, 4, 1, -16)
    Accent.Position = UDim2.new(0, 0, 0, 8)
    Accent.BackgroundColor3 = Color3.fromRGB(140, 60, 255)
    Accent.BorderSizePixel = 0
    Accent.Parent = NotifFrame
    
    local AccentCorner = Instance.new("UICorner")
    AccentCorner.CornerRadius = UDim.new(0, 4)
    AccentCorner.Parent = Accent
    
    local NotifTitle = Instance.new("TextLabel")
    NotifTitle.Size = UDim2.new(1, -30, 0, 24)
    NotifTitle.Position = UDim2.new(0, 18, 0, 10)
    NotifTitle.BackgroundTransparency = 1
    NotifTitle.Text = title
    NotifTitle.TextColor3 = Color3.fromRGB(235, 225, 255)
    NotifTitle.TextSize = 15
    NotifTitle.Font = Enum.Font.GothamBold
    NotifTitle.TextXAlignment = Enum.TextXAlignment.Left
    NotifTitle.Parent = NotifFrame
    
    local NotifText = Instance.new("TextLabel")
    NotifText.Size = UDim2.new(1, -30, 0, 20)
    NotifText.Position = UDim2.new(0, 18, 0, 36)
    NotifText.BackgroundTransparency = 1
    NotifText.Text = text
    NotifText.TextColor3 = Color3.fromRGB(180, 180, 200)
    NotifText.TextSize = 12
    NotifText.Font = Enum.Font.Gotham
    NotifText.TextXAlignment = Enum.TextXAlignment.Left
    NotifText.TextWrapped = true
    NotifText.Parent = NotifFrame
    
    -- Thêm vào đầu list (notify mới nhất ở index 1)
    table.insert(ActiveNotifications, 1, NotifFrame)
    
    -- Vị trí ban đầu (ngoài màn hình bên phải, cùng Y như target)
    NotifFrame.Position = UDim2.new(1, 20, 1, -90)
    
    -- Delay 1 frame để update position
    task.spawn(function()
        task.wait()
        UpdateNotifPositions()
    end)
    
    -- Auto remove
    task.delay(duration, function()
        -- Xóa khỏi list trước (để các notify khác dịch xuống)
        for i, n in ipairs(ActiveNotifications) do
            if n == NotifFrame then
                table.remove(ActiveNotifications, i)
                break
            end
        end
        
        -- Animate out
        local outPos = UDim2.new(1, 20, 1, NotifFrame.Position.Y.Offset)
        local out = TweenService:Create(NotifFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Position = outPos,
            BackgroundTransparency = 1
        })
        out:Play()
        out.Completed:Connect(function()
            NotifFrame:Destroy()
            UpdateNotifPositions()
        end)
    end)
end

function Library:CreateTab(name)
    local TabBtn = Instance.new("TextButton")
    TabBtn.Size = UDim2.new(1, 0, 0, 34)
    TabBtn.BackgroundColor3 = Color3.fromRGB(28, 22, 45)
    TabBtn.BackgroundTransparency = 0.5
    TabBtn.Text = name
    TabBtn.TextColor3 = Color3.fromRGB(180, 180, 200)
    TabBtn.TextSize = 13
    TabBtn.Font = Enum.Font.GothamMedium
    TabBtn.BorderSizePixel = 0
    TabBtn.Parent = SideBar
    
    local TabCorner = Instance.new("UICorner")
    TabCorner.CornerRadius = UDim.new(0, 8)
    TabCorner.Parent = TabBtn
    
    local TabFrame = Instance.new("ScrollingFrame")
    TabFrame.Size = UDim2.new(1, 0, 1, 0)
    TabFrame.BackgroundTransparency = 1
    TabFrame.BorderSizePixel = 0
    TabFrame.ScrollBarThickness = 4
    TabFrame.ScrollBarImageColor3 = Color3.fromRGB(140, 60, 255)
    TabFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y -- THAY BẰNG DÒNG NÀY
    TabFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    TabFrame.Visible = false
    TabFrame.Parent = ContentArea
    
    local TabLayout = Instance.new("UIListLayout")
    TabLayout.Padding = UDim.new(0, 10)
    TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabLayout.Parent = TabFrame
    
    local TabPad = Instance.new("UIPadding")
    TabPad.PaddingTop = UDim.new(0, 6)
    TabPad.PaddingLeft = UDim.new(0, 6)
    TabPad.PaddingRight = UDim.new(0, 6)
    TabPad.PaddingBottom = UDim.new(0, 6)
    TabPad.Parent = TabFrame
    
    local tabObj = {Button = TabBtn, Frame = TabFrame, Name = name}
    table.insert(Library.Tabs, tabObj)
    
    TabBtn.MouseEnter:Connect(function()
        if Library.CurrentTab ~= tabObj then
            TweenService:Create(TabBtn, TweenInfo.new(0.15), {BackgroundTransparency = 0.3}):Play()
        end
    end)
    TabBtn.MouseLeave:Connect(function()
        if Library.CurrentTab ~= tabObj then
            TweenService:Create(TabBtn, TweenInfo.new(0.15), {BackgroundTransparency = 0.5}):Play()
        end
    end)
    TabBtn.MouseButton1Click:Connect(function()
    for _, t in ipairs(Library.Tabs) do
        t.Frame.Visible = false
        TweenService:Create(t.Button, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(28, 22, 45),
            BackgroundTransparency = 0.5,
            TextColor3 = Color3.fromRGB(180, 180, 200)
        }):Play()
    end
    TabFrame.Visible = true
    TweenService:Create(TabBtn, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(140, 60, 255),
        BackgroundTransparency = 0.2,
        TextColor3 = Color3.fromRGB(255, 255, 255)
    }):Play()
    Library.CurrentTab = tabObj
end)
    
    return tabObj
end

function Library:CreateToggle(tab, name, default, callback)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, -12, 0, 40)
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(22, 16, 38)
    ToggleFrame.BackgroundTransparency = 0.4
    ToggleFrame.BorderSizePixel = 0
    ToggleFrame.Parent = tab.Frame
    
    local TCorner = Instance.new("UICorner")
    TCorner.CornerRadius = UDim.new(0, 10)
    TCorner.Parent = ToggleFrame
    
    local TLabel = Instance.new("TextLabel")
    TLabel.Size = UDim2.new(1, -70, 1, 0)
    TLabel.Position = UDim2.new(0, 14, 0, 0)
    TLabel.BackgroundTransparency = 1
    TLabel.Text = name
    TLabel.TextColor3 = Color3.fromRGB(220, 220, 240)
    TLabel.TextSize = 13
    TLabel.Font = Enum.Font.GothamMedium
    TLabel.TextXAlignment = Enum.TextXAlignment.Left
    TLabel.Parent = ToggleFrame
    
    local ToggleBg = Instance.new("Frame")
    ToggleBg.Size = UDim2.new(0, 42, 0, 22)
    ToggleBg.Position = UDim2.new(1, -54, 0.5, -11)
    ToggleBg.BackgroundColor3 = Color3.fromRGB(45, 38, 65)
    ToggleBg.BorderSizePixel = 0
    ToggleBg.Parent = ToggleFrame
    
    local TogCorner = Instance.new("UICorner")
    TogCorner.CornerRadius = UDim.new(1, 0)
    TogCorner.Parent = ToggleBg
    
    local Knob = Instance.new("Frame")
    Knob.Size = UDim2.new(0, 16, 0, 16)
    Knob.Position = UDim2.new(0, 3, 0.5, -8)
    Knob.BackgroundColor3 = Color3.fromRGB(200, 200, 220)
    Knob.BorderSizePixel = 0
    Knob.Parent = ToggleBg
    
    local KCorner = Instance.new("UICorner")
    KCorner.CornerRadius = UDim.new(1, 0)
    KCorner.Parent = Knob
    
    local TButton = Instance.new("TextButton")
    TButton.Size = UDim2.new(1, 0, 1, 0)
    TButton.BackgroundTransparency = 1
    TButton.Text = ""
    TButton.Parent = ToggleFrame
    
    local state = default or false
    
    local function update(v)
        state = v
        if state then
            TweenService:Create(ToggleBg, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(140, 60, 255)}):Play()
            TweenService:Create(Knob, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {Position = UDim2.new(0, 23, 0.5, -8), BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Play()
        else
            TweenService:Create(ToggleBg, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(45, 38, 65)}):Play()
            TweenService:Create(Knob, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {Position = UDim2.new(0, 3, 0.5, -8), BackgroundColor3 = Color3.fromRGB(200, 200, 220)}):Play()
        end
        if callback then callback(state) end
    end
    
    TButton.MouseButton1Click:Connect(function()
        update(not state)
    end)
    
    update(state)
    return {Set = update, Get = function() return state end, Frame = ToggleFrame}
end

function Library:CreateButton(tab, name, callback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, -12, 0, 40)
    Btn.BackgroundColor3 = Color3.fromRGB(140, 60, 255)
    Btn.BackgroundTransparency = 0.15
    Btn.Text = name
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.TextSize = 14
    Btn.Font = Enum.Font.GothamBold
    Btn.BorderSizePixel = 0
    Btn.Parent = tab.Frame
    
    local BCorner = Instance.new("UICorner")
    BCorner.CornerRadius = UDim.new(0, 10)
    BCorner.Parent = Btn
    
    local BStroke = Instance.new("UIStroke")
    BStroke.Color = Color3.fromRGB(180, 120, 255)
    BStroke.Thickness = 1
    BStroke.Transparency = 0.4
    BStroke.Parent = Btn
    
    local origSize = Btn.Size
    
    Btn.MouseEnter:Connect(function()
        TweenService:Create(Btn, TweenInfo.new(0.15), {BackgroundTransparency = 0}):Play()
    end)
    Btn.MouseLeave:Connect(function()
        TweenService:Create(Btn, TweenInfo.new(0.15), {BackgroundTransparency = 0.15}):Play()
    end)
    
    Btn.MouseButton1Down:Connect(function()
        TweenService:Create(Btn, TweenInfo.new(0.08, Enum.EasingStyle.Quad), {
            Size = UDim2.new(origSize.X.Scale, origSize.X.Offset - 6, origSize.Y.Scale, origSize.Y.Offset - 4)
        }):Play()
    end)
    Btn.MouseButton1Up:Connect(function()
        TweenService:Create(Btn, TweenInfo.new(0.15, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = origSize
        }):Play()
        if callback then callback() end
    end)
    
    return Btn
end

function Library:CreateLabel(tab, text)
    local Lbl = Instance.new("TextLabel")
    Lbl.Size = UDim2.new(1, -12, 0, 30)
    Lbl.BackgroundTransparency = 1
    Lbl.Text = text
    Lbl.TextColor3 = Color3.fromRGB(200, 200, 220)
    Lbl.TextSize = 13
    Lbl.Font = Enum.Font.Gotham
    Lbl.TextXAlignment = Enum.TextXAlignment.Left
    Lbl.Parent = tab.Frame
    
    return {
        Frame = Lbl,
        Set = function(self, newText) Lbl.Text = newText end,
        SetColor = function(self, color) Lbl.TextColor3 = color end
    }
end

function Library:CreateSlider(tab, name, min, max, default, callback)
    local SlideFrame = Instance.new("Frame")
    SlideFrame.Size = UDim2.new(1, -12, 0, 54)
    SlideFrame.BackgroundColor3 = Color3.fromRGB(22, 16, 38)
    SlideFrame.BackgroundTransparency = 0.4
    SlideFrame.BorderSizePixel = 0
    SlideFrame.Parent = tab.Frame
    
    local SCorner = Instance.new("UICorner")
    SCorner.CornerRadius = UDim.new(0, 10)
    SCorner.Parent = SlideFrame
    
    local SLabel = Instance.new("TextLabel")
    SLabel.Size = UDim2.new(1, -20, 0, 22)
    SLabel.Position = UDim2.new(0, 14, 0, 4)
    SLabel.BackgroundTransparency = 1
    SLabel.Text = name
    SLabel.TextColor3 = Color3.fromRGB(220, 220, 240)
    SLabel.TextSize = 13
    SLabel.Font = Enum.Font.GothamMedium
    SLabel.TextXAlignment = Enum.TextXAlignment.Left
    SLabel.Parent = SlideFrame
    
    local ValueLbl = Instance.new("TextLabel")
    ValueLbl.Size = UDim2.new(0, 60, 0, 22)
    ValueLbl.Position = UDim2.new(1, -74, 0, 4)
    ValueLbl.BackgroundTransparency = 1
    ValueLbl.Text = tostring(default)
    ValueLbl.TextColor3 = Color3.fromRGB(140, 60, 255)
    ValueLbl.TextSize = 13
    ValueLbl.Font = Enum.Font.GothamBold
    ValueLbl.TextXAlignment = Enum.TextXAlignment.Right
    ValueLbl.Parent = SlideFrame
    
    local Bar = Instance.new("Frame")
    Bar.Size = UDim2.new(1, -28, 0, 6)
    Bar.Position = UDim2.new(0, 14, 1, -16)
    Bar.BackgroundColor3 = Color3.fromRGB(45, 38, 65)
    Bar.BorderSizePixel = 0
    Bar.Parent = SlideFrame
    
    local BarCorner = Instance.new("UICorner")
    BarCorner.CornerRadius = UDim.new(1, 0)
    BarCorner.Parent = Bar
    
    local Fill = Instance.new("Frame")
    Fill.Size = UDim2.new(0, 0, 1, 0)
    Fill.BackgroundColor3 = Color3.fromRGB(140, 60, 255)
    Fill.BorderSizePixel = 0
    Fill.Parent = Bar
    
    local FillCorner = Instance.new("UICorner")
    FillCorner.CornerRadius = UDim.new(1, 0)
    FillCorner.Parent = Fill
    
    -- Градиент на заполненной части
    local FillGradient = Instance.new("UIGradient")
    FillGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(80, 180, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 80, 255))
    }
    FillGradient.Parent = Fill
    
    -- Круглый ползунок (родитель - Bar, НЕ Fill!)
    local Dot = Instance.new("Frame")
    Dot.Size = UDim2.new(0, 18, 0, 18)
    Dot.Position = UDim2.new(0, -9, 0.5, -9)
    Dot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Dot.BorderSizePixel = 0
    Dot.ZIndex = 3
    Dot.Parent = Bar -- ВАЖНО: Bar, а не Fill
    
    local DotCorner = Instance.new("UICorner")
    DotCorner.CornerRadius = UDim.new(1, 0)
    DotCorner.Parent = Dot
    
    local DotGradient = Instance.new("UIGradient")
    DotGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 180, 255))
    }
    DotGradient.Rotation = 90
    DotGradient.Parent = Dot
    
    local DotStroke = Instance.new("UIStroke")
    DotStroke.Color = Color3.fromRGB(140, 60, 255)
    DotStroke.Thickness = 2
    DotStroke.Transparency = 0.1
    DotStroke.Parent = Dot
    
    -- Свечение вокруг ползунка
    local DotGlow = Instance.new("ImageLabel")
    DotGlow.Size = UDim2.new(0, 34, 0, 34)
    DotGlow.Position = UDim2.new(0.5, -17, 0.5, -17)
    DotGlow.BackgroundTransparency = 1
    DotGlow.Image = "rbxassetid://5028857084"
    DotGlow.ImageColor3 = Color3.fromRGB(140, 60, 255)
    DotGlow.ImageTransparency = 0.3
    DotGlow.ZIndex = 2
    DotGlow.Parent = Dot
    
    local value = default
    local dragging = false
    
    local function setValue(v)
        value = math.clamp(v, min, max)
        local alpha = (value - min) / (max - min)
        Fill.Size = UDim2.new(alpha, 0, 1, 0)
        -- Обновление позиции Dot по alpha
        Dot.Position = UDim2.new(alpha, -9, 0.5, -9)
        ValueLbl.Text = tostring(math.floor(value * 100) / 100)
        if callback then callback(value) end
    end
    
    local BarBtn = Instance.new("TextButton")
    BarBtn.Size = UDim2.new(1, 0, 1, 0)
    BarBtn.BackgroundTransparency = 1
    BarBtn.Text = ""
    BarBtn.ZIndex = 4
    BarBtn.Parent = Bar
    
    local function updateFromX(x)
        local barPos = Bar.AbsolutePosition.X
        local barSize = Bar.AbsoluteSize.X
        local alpha = math.clamp((x - barPos) / barSize, 0, 1)
        setValue(min + (max - min) * alpha)
    end
    
    BarBtn.MouseButton1Down:Connect(function()
        dragging = true
    end)
    BarBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            updateFromX(input.Position.X)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 
        or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if not dragging then return end
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            updateFromX(input.Position.X)
        elseif input.UserInputType == Enum.UserInputType.Touch then
            updateFromX(input.Position.X)
        end
    end)
    
    -- Анимация пульсации ползунка
    task.spawn(function()
        while Dot.Parent do
            TweenService:Create(DotStroke, TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Transparency = 0.6}):Play()
            TweenService:Create(DotGlow, TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {ImageTransparency = 0.6}):Play()
            task.wait(1.2)
            TweenService:Create(DotStroke, TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Transparency = 0.1}):Play()
            TweenService:Create(DotGlow, TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {ImageTransparency = 0.3}):Play()
            task.wait(1.2)
        end
    end)
    
    setValue(default)
    return {Set = setValue, Get = function() return value end, Frame = SlideFrame}
end

-- ============================================================
-- HAM TAO DROPDOWN (LIST CHON, KEO DUOC)
-- ============================================================
function Library:CreateDropdown(tab, name, options, default, callback)
    options = options or {}
    default = default or (options[1] or "")
    
    -- Khung chua
    local DropFrame = Instance.new("Frame")
    DropFrame.Size = UDim2.new(1, -12, 0, 40)
    DropFrame.BackgroundColor3 = Color3.fromRGB(22, 16, 38)
    DropFrame.BackgroundTransparency = 0.4
    DropFrame.BorderSizePixel = 0
    DropFrame.ClipsDescendants = false
    DropFrame.ZIndex = 5
    DropFrame.Parent = tab.Frame
    
    local DCorner = Instance.new("UICorner")
    DCorner.CornerRadius = UDim.new(0, 10)
    DCorner.Parent = DropFrame
    
    -- Label ten
    local DLabel = Instance.new("TextLabel")
    DLabel.Size = UDim2.new(0.5, 0, 1, 0)
    DLabel.Position = UDim2.new(0, 14, 0, 0)
    DLabel.BackgroundTransparency = 1
    DLabel.Text = name
    DLabel.TextColor3 = Color3.fromRGB(220, 220, 240)
    DLabel.TextSize = 13
    DLabel.Font = Enum.Font.GothamMedium
    DLabel.TextXAlignment = Enum.TextXAlignment.Left
    DLabel.ZIndex = 6
    DLabel.Parent = DropFrame
    
    -- Hien thi lua chon hien tai
    local SelectedLbl = Instance.new("TextLabel")
    SelectedLbl.Size = UDim2.new(0.45, -30, 1, 0)
    SelectedLbl.Position = UDim2.new(0.5, 0, 0, 0)
    SelectedLbl.BackgroundTransparency = 1
    SelectedLbl.Text = tostring(default)
    SelectedLbl.TextColor3 = Color3.fromRGB(140, 60, 255)
    SelectedLbl.TextSize = 13
    SelectedLbl.Font = Enum.Font.GothamBold
    SelectedLbl.TextXAlignment = Enum.TextXAlignment.Right
    SelectedLbl.ZIndex = 6
    SelectedLbl.Parent = DropFrame
    
    -- Mui ten chi xuong
    local Arrow = Instance.new("TextLabel")
    Arrow.Size = UDim2.new(0, 20, 1, 0)
    Arrow.Position = UDim2.new(1, -24, 0, 0)
    Arrow.BackgroundTransparency = 1
    Arrow.Text = "▼"
    Arrow.TextColor3 = Color3.fromRGB(140, 60, 255)
    Arrow.TextSize = 10
    Arrow.Font = Enum.Font.GothamBold
    Arrow.ZIndex = 6
    Arrow.Parent = DropFrame
    
    -- Nut click
    local DButton = Instance.new("TextButton")
    DButton.Size = UDim2.new(1, 0, 1, 0)
    DButton.BackgroundTransparency = 1
    DButton.Text = ""
    DButton.ZIndex = 7
    DButton.Parent = DropFrame
    
    -- Bang danh sach (list options)
    local ListFrame = Instance.new("ScrollingFrame")
    ListFrame.Size = UDim2.new(1, 0, 0, 0)
    ListFrame.Position = UDim2.new(0, 0, 1, 4)
    ListFrame.BackgroundColor3 = Color3.fromRGB(18, 12, 30)
    ListFrame.BackgroundTransparency = 0.05
    ListFrame.BorderSizePixel = 0
    ListFrame.ScrollBarThickness = 3
    ListFrame.ScrollBarImageColor3 = Color3.fromRGB(140, 60, 255)
    ListFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    ListFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    ListFrame.Visible = false
    ListFrame.ZIndex = 20
    ListFrame.Parent = DropFrame
    
    local LCorner = Instance.new("UICorner")
    LCorner.CornerRadius = UDim.new(0, 8)
    LCorner.Parent = ListFrame
    
    local LStroke = Instance.new("UIStroke")
    LStroke.Color = Color3.fromRGB(140, 60, 255)
    LStroke.Thickness = 1
    LStroke.Transparency = 0.4
    LStroke.Parent = ListFrame
    
    local LLayout = Instance.new("UIListLayout")
    LLayout.Padding = UDim.new(0, 2)
    LLayout.SortOrder = Enum.SortOrder.LayoutOrder
    LLayout.Parent = ListFrame
    
    local LPad = Instance.new("UIPadding")
    LPad.PaddingTop = UDim.new(0, 4)
    LPad.PaddingLeft = UDim.new(0, 4)
    LPad.PaddingRight = UDim.new(0, 4)
    LPad.PaddingBottom = UDim.new(0, 4)
    LPad.Parent = ListFrame
    
    local isOpen = false
    local currentValue = default
    local optionButtons = {}
    
    -- Ham cap nhat gia tri hien thi
    local function setValue(v)
        currentValue = v
        SelectedLbl.Text = tostring(v)
        if callback then callback(v) end
    end
    
    -- Tao tung option trong list
    for _, opt in ipairs(options) do
        local OptBtn = Instance.new("TextButton")
        OptBtn.Size = UDim2.new(1, 0, 0, 28)
        OptBtn.BackgroundColor3 = Color3.fromRGB(28, 22, 45)
        OptBtn.BackgroundTransparency = 0.5
        OptBtn.Text = tostring(opt)
        OptBtn.TextColor3 = Color3.fromRGB(220, 220, 240)
        OptBtn.TextSize = 12
        OptBtn.Font = Enum.Font.GothamMedium
        OptBtn.BorderSizePixel = 0
        OptBtn.TextXAlignment = Enum.TextXAlignment.Left
        OptBtn.ZIndex = 21
        OptBtn.Parent = ListFrame
        
        local OCorner = Instance.new("UICorner")
        OCorner.CornerRadius = UDim.new(0, 6)
        OCorner.Parent = OptBtn
        
        local OPad = Instance.new("UIPadding")
        OPad.PaddingLeft = UDim.new(0, 10)
        OPad.Parent = OptBtn
        
        table.insert(optionButtons, {Btn = OptBtn, Value = opt})
        
        OptBtn.MouseEnter:Connect(function()
            if currentValue ~= opt then
                TweenService:Create(OptBtn, TweenInfo.new(0.1), {BackgroundTransparency = 0.2}):Play()
            end
        end)
        OptBtn.MouseLeave:Connect(function()
            if currentValue ~= opt then
                TweenService:Create(OptBtn, TweenInfo.new(0.1), {BackgroundTransparency = 0.5}):Play()
            end
        end)
        
        OptBtn.MouseButton1Click:Connect(function()
            -- Reset tat ca ve mau cu
            for _, ob in ipairs(optionButtons) do
                TweenService:Create(ob.Btn, TweenInfo.new(0.15), {
                    BackgroundColor3 = Color3.fromRGB(28, 22, 45),
                    BackgroundTransparency = 0.5,
                    TextColor3 = Color3.fromRGB(220, 220, 240)
                }):Play()
            end
            -- Highlight option duoc chon
            TweenService:Create(OptBtn, TweenInfo.new(0.15), {
                BackgroundColor3 = Color3.fromRGB(140, 60, 255),
                BackgroundTransparency = 0.2,
                TextColor3 = Color3.fromRGB(255, 255, 255)
            }):Play()
            
            setValue(opt)
            
            -- Dong list
            isOpen = false
            TweenService:Create(ListFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                Size = UDim2.new(1, 0, 0, 0)
            }):Play()
            task.delay(0.2, function()
                ListFrame.Visible = false
            end)
            TweenService:Create(Arrow, TweenInfo.new(0.2), {Rotation = 0}):Play()
        end)
    end
    
    -- Highlight option mac dinh
    for _, ob in ipairs(optionButtons) do
        if ob.Value == currentValue then
            ob.Btn.BackgroundColor3 = Color3.fromRGB(140, 60, 255)
            ob.Btn.BackgroundTransparency = 0.2
            ob.Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        end
    end
    
    -- Toggle dong/mo list
    DButton.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        
        if isOpen then
            -- Mo
            ListFrame.Visible = true
            local listHeight = math.min(#options * 30 + 12, 150)
            TweenService:Create(ListFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = UDim2.new(1, 0, 0, listHeight)
            }):Play()
            TweenService:Create(Arrow, TweenInfo.new(0.2), {Rotation = 180}):Play()
        else
            -- Dong
            TweenService:Create(ListFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                Size = UDim2.new(1, 0, 0, 0)
            }):Play()
            TweenService:Create(Arrow, TweenInfo.new(0.2), {Rotation = 0}):Play()
            task.delay(0.2, function()
                ListFrame.Visible = false
            end)
        end
    end)
    
    -- Hover hieu ung nut
    DButton.MouseEnter:Connect(function()
        TweenService:Create(DropFrame, TweenInfo.new(0.15), {BackgroundTransparency = 0.2}):Play()
    end)
    DButton.MouseLeave:Connect(function()
        TweenService:Create(DropFrame, TweenInfo.new(0.15), {BackgroundTransparency = 0.4}):Play()
    end)
    
    -- Tra ve object de dieu khien tu ben ngoai
    return {
        Frame = DropFrame,
        Set = setValue,
        Get = function() return currentValue end,
        SetOptions = function(newOptions)
            -- Xoa list cu
            for _, ob in ipairs(optionButtons) do
                ob.Btn:Destroy()
            end
            optionButtons = {}
            
            -- Tao lai
            for _, opt in ipairs(newOptions) do
                local OptBtn = Instance.new("TextButton")
                OptBtn.Size = UDim2.new(1, 0, 0, 28)
                OptBtn.BackgroundColor3 = Color3.fromRGB(28, 22, 45)
                OptBtn.BackgroundTransparency = 0.5
                OptBtn.Text = tostring(opt)
                OptBtn.TextColor3 = Color3.fromRGB(220, 220, 240)
                OptBtn.TextSize = 12
                OptBtn.Font = Enum.Font.GothamMedium
                OptBtn.BorderSizePixel = 0
                OptBtn.TextXAlignment = Enum.TextXAlignment.Left
                OptBtn.ZIndex = 21
                OptBtn.Parent = ListFrame
                
                local OCorner = Instance.new("UICorner")
                OCorner.CornerRadius = UDim.new(0, 6)
                OCorner.Parent = OptBtn
                
                local OPad = Instance.new("UIPadding")
                OPad.PaddingLeft = UDim.new(0, 10)
                OPad.Parent = OptBtn
                
                table.insert(optionButtons, {Btn = OptBtn, Value = opt})
                
                OptBtn.MouseButton1Click:Connect(function()
                    for _, ob in ipairs(optionButtons) do
                        TweenService:Create(ob.Btn, TweenInfo.new(0.15), {
                            BackgroundColor3 = Color3.fromRGB(28, 22, 45),
                            BackgroundTransparency = 0.5,
                            TextColor3 = Color3.fromRGB(220, 220, 240)
                        }):Play()
                    end
                    TweenService:Create(OptBtn, TweenInfo.new(0.15), {
                        BackgroundColor3 = Color3.fromRGB(140, 60, 255),
                        BackgroundTransparency = 0.2,
                        TextColor3 = Color3.fromRGB(255, 255, 255)
                    }):Play()
                    
                    setValue(opt)
                    
                    isOpen = false
                    TweenService:Create(ListFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                        Size = UDim2.new(1, 0, 0, 0)
                    }):Play()
                    task.delay(0.2, function()
                        ListFrame.Visible = false
                    end)
                    TweenService:Create(Arrow, TweenInfo.new(0.2), {Rotation = 0}):Play()
                end)
            end
        end
    }
end

-- ============================================================
-- HAM TAO TEXTBOX (NHAP SO)
-- ============================================================
function Library:CreateTextBox(tab, name, default, callback)
    local BoxFrame = Instance.new("Frame")
    BoxFrame.Size = UDim2.new(1, -12, 0, 40)
    BoxFrame.BackgroundColor3 = Color3.fromRGB(22, 16, 38)
    BoxFrame.BackgroundTransparency = 0.4
    BoxFrame.BorderSizePixel = 0
    BoxFrame.Parent = tab.Frame
    
    local BCorner = Instance.new("UICorner")
    BCorner.CornerRadius = UDim.new(0, 10)
    BCorner.Parent = BoxFrame
    
    local BLabel = Instance.new("TextLabel")
    BLabel.Size = UDim2.new(0.5, 0, 1, 0)
    BLabel.Position = UDim2.new(0, 14, 0, 0)
    BLabel.BackgroundTransparency = 1
    BLabel.Text = name
    BLabel.TextColor3 = Color3.fromRGB(220, 220, 240)
    BLabel.TextSize = 13
    BLabel.Font = Enum.Font.GothamMedium
    BLabel.TextXAlignment = Enum.TextXAlignment.Left
    BLabel.Parent = BoxFrame
    
    local Input = Instance.new("TextBox")
    Input.Size = UDim2.new(0.45, -10, 0, 26)
    Input.Position = UDim2.new(0.5, 0, 0.5, -13)
    Input.BackgroundColor3 = Color3.fromRGB(14, 10, 24)
    Input.BackgroundTransparency = 0.2
    Input.BorderSizePixel = 0
    Input.Text = tostring(default)
    Input.TextColor3 = Color3.fromRGB(140, 60, 255)
    Input.TextSize = 13
    Input.Font = Enum.Font.GothamBold
    Input.PlaceholderText = "Nhap so..."
    Input.PlaceholderColor3 = Color3.fromRGB(120, 120, 140)
    Input.ClearTextOnFocus = false
    Input.Parent = BoxFrame
    
    local ICorner = Instance.new("UICorner")
    ICorner.CornerRadius = UDim.new(0, 6)
    ICorner.Parent = Input
    
    local IStroke = Instance.new("UIStroke")
    IStroke.Color = Color3.fromRGB(140, 60, 255)
    IStroke.Thickness = 1
    IStroke.Transparency = 0.4
    IStroke.Parent = Input
    
    Input.Focused:Connect(function()
        TweenService:Create(IStroke, TweenInfo.new(0.15), {Transparency = 0, Thickness = 1.5}):Play()
    end)
    Input.FocusLost:Connect(function()
        TweenService:Create(IStroke, TweenInfo.new(0.15), {Transparency = 0.4, Thickness = 1}):Play()
        local num = tonumber(Input.Text) or default
        if callback then callback(num) end
    end)
    
    return {
        Frame = BoxFrame,
        Get = function() return tonumber(Input.Text) or default end,
        Set = function(v) Input.Text = tostring(v) end
    }
end

-- ============================================================
-- ФУНКЦИЯ СОЗДАНИЯ IMAGE
-- ============================================================
function Library:CreateImage(tab, imageId, height)
    local Img = Instance.new("ImageLabel")
    Img.Size = UDim2.new(1, -12, 0, height or 120)
    Img.BackgroundColor3 = Color3.fromRGB(22, 16, 38)
    Img.BackgroundTransparency = 0.4
    Img.BorderSizePixel = 0
    Img.Image = imageId
    Img.ScaleType = Enum.ScaleType.Fit
    Img.Parent = tab.Frame
    
    local ICorner = Instance.new("UICorner")
    ICorner.CornerRadius = UDim.new(0, 10)
    ICorner.Parent = Img
    
    return Img
end

-- ============================================================
-- СИСТЕМА ВКЛ/ВЫКЛ UI
-- ============================================================
local UIOpen = true
local ToggleKey = Enum.KeyCode.RightControl

local OpenButton = Instance.new("TextButton")
OpenButton.Size = UDim2.new(0, 90, 0, 34)
OpenButton.Position = UDim2.new(0, 20, 0, 20)
OpenButton.BackgroundColor3 = Color3.fromRGB(140, 60, 255)
OpenButton.BackgroundTransparency = 0.15
OpenButton.Text = "ABYSSALHUB"
OpenButton.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenButton.TextSize = 12
OpenButton.Font = Enum.Font.GothamBold
OpenButton.BorderSizePixel = 0
OpenButton.Visible = false
OpenButton.Parent = ScreenGui

local OpenCorner = Instance.new("UICorner")
OpenCorner.CornerRadius = UDim.new(0, 10)
OpenCorner.Parent = OpenButton

local OriginalSize = UDim2.new(0, 520, 0, 360)
local OriginalPos = UDim2.new(0.5, -260, 0.5, -180)
local IsMaximized = false

local function HideUI()
    UIOpen = false
    local tween = TweenService:Create(MainFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        BackgroundTransparency = 1
    })
    tween:Play()
    tween.Completed:Connect(function()
        MainFrame.Visible = false
        OpenButton.Visible = true
    end)
end

local function ShowUI()
    UIOpen = true
    OpenButton.Visible = false
    MainFrame.Visible = true
    local targetSize = IsMaximized and UDim2.new(0, 800, 0, 520) or OriginalSize
    local targetPos = IsMaximized and UDim2.new(0.5, -400, 0.5, -260) or OriginalPos
    TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = targetSize,
        Position = targetPos,
        BackgroundTransparency = 0.05
    }):Play()
end

UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == ToggleKey then
        if UIOpen then HideUI() else ShowUI() end
    end
end)

OpenButton.MouseButton1Click:Connect(ShowUI)
CloseBtn.MouseButton1Click:Connect(HideUI)

MaximizeBtn.MouseButton1Click:Connect(function()
    IsMaximized = not IsMaximized
    if IsMaximized then
        TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 800, 0, 520),
            Position = UDim2.new(0.5, -400, 0.5, -260)
        }):Play()
        -- Переключение иконок
        MaximizeIcon.Visible = false
        MinimizeIcon.Visible = true
        Library:Notify("AbyssalHub", "Da phong to UI", 2)
    else
        TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = OriginalSize,
            Position = OriginalPos
        }):Play()
        -- Переключение иконок
        MaximizeIcon.Visible = true
        MinimizeIcon.Visible = false
        Library:Notify("AbyssalHub", "Da thu nho UI", 2)
    end
end)

-- ============================================================
-- ДЕМОНСТРАЦИЯ (СОЗДАНИЕ ЭЛЕМЕНТОВ)
-- ============================================================
local TabStats = Library:CreateTab("Stats & Server")
local TabCombat = Library:CreateTab("Combat")
local TabVisual = Library:CreateTab("Visual")
local TabMove   = Library:CreateTab("Movement")

-- ---- COMBAT ----
Library:CreateLabel(TabCombat, "── AIMBOT ──")

Library:CreateToggle(TabCombat, "Aimbot (giữ chuột phải)", false, function(v) _G.Aim.Enabled = v end)
Library:CreateSlider(TabCombat, "FOV", 10, 500, 150, function(v) _G.Aim.FOV = v end)
Library:CreateSlider(TabCombat, "Smooth", 0.01, 1, 0.15, function(v) _G.Aim.Smooth = v end)
Library:CreateToggle(TabCombat, "Bỏ qua đồng đội", false, function(v) _G.Aim.Team = v end)

Library:CreateLabel(TabCombat, "── SILENT ──")
Library:CreateToggle(TabCombat, "Silent Aim", false, function(v) _G.Silent.Enabled = v end)
Library:CreateSlider(TabCombat, "Silent FOV", 10, 500, 200, function(v) _G.Silent.FOV = v end)

Library:CreateLabel(TabCombat, "── TRIGGER ──")
Library:CreateToggle(TabCombat, "Triggerbot", false, function(v) _G.Trig.Enabled = v end)
Library:CreateSlider(TabCombat, "Trig delay", 0.01, 0.5, 0.05, function(v) _G.Trig.Delay = v end)
Library:CreateSlider(TabCombat, "Trig range (px)", 5, 200, 30, function(v) _G.Trig.Range = v end)

-- ---- VISUAL ----
Library:CreateLabel(TabVisual, "── ESP ──")
Library:CreateToggle(TabVisual, "Box", false, function(v) _G.ESP.Box = v end)
Library:CreateToggle(TabVisual, "Name", false, function(v) _G.ESP.Name = v end)
Library:CreateToggle(TabVisual, "Health bar", false, function(v) _G.ESP.Health = v end)
Library:CreateToggle(TabVisual, "Distance", false, function(v) _G.ESP.Dist = v end)
Library:CreateToggle(TabVisual, "Tracer", false, function(v) _G.ESP.Tracer = v end)
Library:CreateToggle(TabVisual, "Ẩn đồng đội", true, function(v) _G.ESP.Team = v end)

-- ---- MOVEMENT ----
Library:CreateLabel(TabMove, "── MOVEMENT ──")
Library:CreateToggle(TabMove, "Speed hack", false, function(v) _G.Move.Speed = v end)
Library:CreateSlider(TabMove, "Speed", 16, 250, 50, function(v) _G.Move.SpeedVal = v end)
Library:CreateToggle(TabMove, "Jump hack", false, function(v) _G.Move.Jump = v end)
Library:CreateSlider(TabMove, "Jump power", 50, 500, 100, function(v) _G.Move.JumpVal = v end)
Library:CreateToggle(TabMove, "Fly (WASD + Space)", false, function(v) _G.Move.Fly = v end)
Library:CreateSlider(TabMove, "Fly speed", 10, 300, 50, function(v) _G.Move.FlySpeed = v end)
Library:CreateToggle(TabMove, "Noclip", false, function(v) _G.Move.Noclip = v end)

-- ---------- TAB STATS & SERVER ----------
local Player = Players.LocalPlayer
local JoinTime = tick()

Library:CreateLabel(TabStats, "── SERVER INFO ──")

local TimeLabel = Library:CreateLabel(TabStats, "Thoi gian trong server: 00:00:00")
TimeLabel:SetColor(Color3.fromRGB(140, 60, 255))

local ServerIdLabel = Library:CreateLabel(TabStats, "Server ID: ...")
ServerIdLabel:SetColor(Color3.fromRGB(80, 180, 255))

local PlayerCountLabel = Library:CreateLabel(TabStats, "Nguoi choi: 0/0")
PlayerCountLabel:SetColor(Color3.fromRGB(180, 180, 200))

local PlayerNameLabel = Library:CreateLabel(TabStats, "Ten: " .. Player.Name)
PlayerNameLabel:SetColor(Color3.fromRGB(180, 180, 200))

local UserIdLabel = Library:CreateLabel(TabStats, "User ID: " .. Player.UserId)
UserIdLabel:SetColor(Color3.fromRGB(180, 180, 200))

Library:CreateLabel(TabStats, "── PERFORMANCE ──")

local FpsLabel = Library:CreateLabel(TabStats, "FPS: 0")
FpsLabel:SetColor(Color3.fromRGB(255, 200, 100))

local PingLabel = Library:CreateLabel(TabStats, "Ping: 0 ms")
PingLabel:SetColor(Color3.fromRGB(255, 120, 120))

local MemoryLabel = Library:CreateLabel(TabStats, "Memory: 0 MB")
MemoryLabel:SetColor(Color3.fromRGB(120, 255, 180))

TabStats.Frame.Visible = false
-- Hàm format HH:MM:SS
local function FormatTime(seconds)
    local hours = math.floor(seconds / 3600)
    local minutes = math.floor((seconds % 3600) / 60)
    local secs = math.floor(seconds % 60)
    return string.format("%02d:%02d:%02d", hours, minutes, secs)
end

local Player = Players.LocalPlayer

-- Mốc thời gian script bắt đầu chạy
local JoinTime = tick()

-- Ước lượng thời gian player đã ở trong server TRƯỚC khi script chạy
local InitialOffset = 0
pcall(function()
    local serverUptime = workspace.DistributedGameTime
    if serverUptime < 300 then
        InitialOffset = serverUptime
    end
end)

-- Loop update mỗi 1 giây
task.spawn(function()
    while TabStats.Frame.Parent do
        local elapsed = (tick() - JoinTime) + InitialOffset
        TimeLabel:Set("Time server: " .. FormatTime(elapsed))
        task.wait(1)
    end
end)

pcall(function()
    local serverId = game.JobId
    if serverId == "" then serverId = "Studio / Private" end
    ServerIdLabel:Set("Server ID: " .. serverId)
end)

task.spawn(function()
    while TabStats.Frame.Parent do
        local current = #Players:GetPlayers()
        local max = Players.MaxPlayers
        PlayerCountLabel:Set("Players: " .. current .. "/" .. max)
        task.wait(2)
    end
end)

task.spawn(function()
    local frames = 0
    local lastTime = tick()
    RunService.RenderStepped:Connect(function()
        frames = frames + 1
    end)
    while TabStats.Frame.Parent do
        local now = tick()
        local elapsed = now - lastTime
        if elapsed > 0 then
            local fps = math.floor(frames / elapsed)
            FpsLabel:Set("FPS: " .. fps)
        end
        frames = 0
        lastTime = now
        task.wait(0.5)
    end
end)

task.spawn(function()
    while TabStats.Frame.Parent do
        local ping = math.floor(Player:GetNetworkPing() * 1000)
        PingLabel:Set("Ping: " .. ping .. " ms")
        task.wait(2)
    end
end)

task.spawn(function()
    while TabStats.Frame.Parent do
        local mem = math.floor(game:GetService("Stats"):GetTotalMemoryUsageMb())
        MemoryLabel:Set("Memory: " .. mem .. " MB")
        task.wait(3)
    end
end)

-- ============================================================
-- RIVALS FEATURES
-- ============================================================
local LP = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local UIS = UserInputService

-- ============================================================
-- HELPERS
-- ============================================================
local function IsAlive(plr)
    local c = plr.Character
    if not c then return false end
    local h = c:FindFirstChildOfClass("Humanoid")
    return h and h.Health > 0
end

local function GetRoot(plr)
    local c = plr.Character
    return c and c:FindFirstChild("HumanoidRootPart")
end

local function IsTeam(plr)
    if plr == LP then return true end
    local myTeam = LP.Team
    local theirTeam = plr.Team
    return myTeam ~= nil and theirTeam ~= nil and myTeam == theirTeam
end

local function GetTargets()
    local list = {}
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LP and IsAlive(plr) then
            if not _G.Aim.Team or not IsTeam(plr) then
                table.insert(list, plr)
            end
        end
    end
    return list
end

local function WorldToScreen(pos)
    local sp, onScreen = Camera:WorldToViewportPoint(pos)
    return Vector2.new(sp.X, sp.Y), onScreen, sp.Z
end

local function GetFOVTarget(fov, part)
    local center = Camera.ViewportSize / 2
    local best, bestDist = nil, fov
    for _, plr in ipairs(GetTargets()) do
        local root = GetRoot(plr)
        if root then
            local targetPart = plr.Character:FindFirstChild(part) or root
            local sp, onScreen = WorldToScreen(targetPart.Position)
            if onScreen then
                local d = (sp - center).Magnitude
                if d < bestDist then
                    bestDist = d
                    best = plr
                end
            end
        end
    end
    return best
end

-- ============================================================
-- AIMBOT (Camera lock)
-- ============================================================
local aimHeld = false
UIS.InputBegan:Connect(function(i, gpe)
    if gpe then return end
    if i.UserInputType == _G.Aim.Key then aimHeld = true end
end)
UIS.InputEnded:Connect(function(i)
    if i.UserInputType == _G.Aim.Key then aimHeld = false end
end)

RunService.RenderStepped:Connect(function()
    if not _G.Aim.Enabled or not aimHeld then return end
    local target = GetFOVTarget(_G.Aim.FOV, _G.Aim.Part)
    if not target then return end
    local part = target.Character:FindFirstChild(_G.Aim.Part) or GetRoot(target)
    if not part then return end
    local goal = CFrame.new(Camera.CFrame.Position, part.Position)
    Camera.CFrame = Camera.CFrame:Lerp(goal, 1 - _G.Aim.Smooth)
end)

-- ============================================================
-- SILENT AIM (hook mouse hit)
-- ============================================================
local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    if _G.Silent.Enabled and (method == "FindPartOnRay" or method == "FindPartOnRayWithIgnoreList" or method == "Raycast") then
        local target = GetFOVTarget(_G.Silent.FOV, "Head")
        if target then
            local head = target.Character and target.Character:FindFirstChild("Head")
            if head then
                if method == "Raycast" then
                    local args = {...}
                    local params = args[2]
                    local origin = Camera.CFrame.Position
                    local dir = (head.Position - origin)
                    args[2] = RaycastParams.new()
                    args[2].FilterDescendantsInstances = {target.Character}
                    args[2].FilterType = Enum.RaycastFilterType.Include
                    return oldNamecall(self, origin, dir, args[2])
                else
                    local args = {...}
                    args[1] = Ray.new(Camera.CFrame.Position, (head.Position - Camera.CFrame.Position).Unit * 1000)
                    return oldNamecall(self, unpack(args))
                end
            end
        end
    end
    return oldNamecall(self, ...)
end)

-- ============================================================
-- TRIGGERBOT (dựa vào crosshair gần target)
-- ============================================================
task.spawn(function()
    while task.wait(_G.Trig.Delay) do
        if not _G.Trig.Enabled then continue end
        local center = Camera.ViewportSize / 2
        for _, plr in ipairs(GetTargets()) do
            local root = GetRoot(plr)
            if root then
                local sp, onScreen, depth = WorldToScreen(root.Position)
                if onScreen and (sp - center).Magnitude < _G.Trig.Range then
                    if not _G.Trig.Team or not IsTeam(plr) then
                        pcall(function()
                            mouse1click()
                        end)
                        break
                    end
                end
            end
        end
    end
end)

-- ============================================================
-- ESP
-- ============================================================
local ESPFolder = Instance.new("Folder")
ESPFolder.Name = "AbyssalESP"
ESPFolder.Parent = ScreenGui

local drawings = {}
local function newDrawing(class, props)
    local d = Drawing.new(class)
    for k, v in pairs(props) do d[k] = v end
    return d
end

local function createESP(plr)
    local t = {
        Box = newDrawing("Square", {Thickness = 1, Filled = false, Color = Color3.fromRGB(140, 60, 255), Transparency = 1, Visible = false}),
        Name = newDrawing("Text", {Size = 14, Center = true, Outline = true, Color = Color3.fromRGB(255, 255, 255), Transparency = 1, Visible = false}),
        HealthBg = newDrawing("Square", {Thickness = 1, Filled = true, Color = Color3.fromRGB(20, 20, 20), Transparency = 0.5, Visible = false}),
        HealthBar = newDrawing("Square", {Thickness = 1, Filled = true, Color = Color3.fromRGB(0, 255, 100), Transparency = 1, Visible = false}),
        Dist = newDrawing("Text", {Size = 12, Center = true, Outline = true, Color = Color3.fromRGB(200, 200, 200), Transparency = 1, Visible = false}),
        Tracer = newDrawing("Line", {Thickness = 1, Color = Color3.fromRGB(140, 60, 255), Transparency = 1, Visible = false}),
    }
    drawings[plr] = t
    return t
end

for _, plr in ipairs(Players:GetPlayers()) do
    if plr ~= LP then createESP(plr) end
end
Players.PlayerAdded:Connect(function(plr)
    if plr ~= LP then createESP(plr) end
end)
Players.PlayerRemoving:Connect(function(plr)
    if drawings[plr] then
        for _, d in pairs(drawings[plr]) do pcall(function() d:Remove() end) end
        drawings[plr] = nil
    end
end)

RunService.RenderStepped:Connect(function()
    for plr, t in pairs(drawings) do
        local enabled = _G.ESP.Box or _G.ESP.Name or _G.ESP.Health or _G.ESP.Dist or _G.ESP.Tracer
        if not enabled or not IsAlive(plr) or (_G.ESP.Team and IsTeam(plr)) then
            for _, d in pairs(t) do d.Visible = false end
            continue
        end

        local char = plr.Character
        local root = char:FindFirstChild("HumanoidRootPart")
        local head = char:FindFirstChild("Head")
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not root or not head then
            for _, d in pairs(t) do d.Visible = false end
            continue
        end

        local topPos, topOn = WorldToScreen(head.Position + Vector3.new(0, 0.5, 0))
        local botPos, botOn = WorldToScreen(root.Position - Vector3.new(0, 3, 0))

        if not (topOn and botOn) then
            for _, d in pairs(t) do d.Visible = false end
            continue
        end

        local height = math.abs(botPos.Y - topPos.Y)
        local width = height * 0.6
        local boxPos = Vector2.new(topPos.X - width / 2, topPos.Y)
        local boxSize = Vector2.new(width, height)
        local dist = (Camera.CFrame.Position - root.Position).Magnitude

        t.Box.Visible = _G.ESP.Box
        t.Box.Position = boxPos
        t.Box.Size = boxSize

        t.Name.Visible = _G.ESP.Name
        t.Name.Position = Vector2.new(topPos.X, topPos.Y - 16)
        t.Name.Text = plr.Name

        t.Dist.Visible = _G.ESP.Dist
        t.Dist.Position = Vector2.new(topPos.X, botPos.Y + 4)
        t.Dist.Text = string.format("%d m", dist)

        t.HealthBg.Visible = _G.ESP.Health
        t.HealthBg.Position = Vector2.new(boxPos.X - 6, boxPos.Y)
        t.HealthBg.Size = Vector2.new(3, height)

        t.HealthBar.Visible = _G.ESP.Health
        local hpct = hum.Health / hum.MaxHealth
        t.HealthBar.Position = Vector2.new(boxPos.X - 6, boxPos.Y + height * (1 - hpct))
        t.HealthBar.Size = Vector2.new(3, height * hpct)
        t.HealthBar.Color = Color3.fromRGB(255 * (1 - hpct), 255 * hpct, 0)

        t.Tracer.Visible = _G.ESP.Tracer
        t.Tracer.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
        t.Tracer.To = Vector2.new(topPos.X, botPos.Y)
    end
end)

-- ============================================================
-- MOVEMENT
-- ============================================================
local flyBV, flyBG

RunService.Stepped:Connect(function()
    local char = LP.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    local root = char:FindFirstChild("HumanoidRootPart")
    if not hum or not root then return end

    hum.WalkSpeed = _G.Move.Speed and _G.Move.SpeedVal or 16
    hum.JumpPower = _G.Move.Jump and _G.Move.JumpVal or 50
    hum.UseJumpPower = _G.Move.Jump

    if _G.Move.Noclip then
        for _, p in ipairs(char:GetDescendants()) do
            if p:IsA("BasePart") and p.CanCollide then p.CanCollide = false end
        end
    end

    if _G.Move.Fly then
        if not flyBV then
            flyBV = Instance.new("BodyVelocity", root)
            flyBV.MaxForce = Vector3.new(1e5, 1e5, 1e5)
            flyBV.Velocity = Vector3.zero
        end
        local dir = Vector3.zero
        local cam = Camera.CFrame
        if UIS:IsKeyDown(Enum.KeyCode.W) then dir += cam.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.S) then dir -= cam.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.A) then dir -= cam.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.D) then dir += cam.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.Space) then dir += Vector3.new(0, 1, 0) end
        if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then dir -= Vector3.new(0, 1, 0) end
        flyBV.Velocity = dir.Magnitude > 0 and dir.Unit * _G.Move.FlySpeed or Vector3.zero
    else
        if flyBV then flyBV:Destroy() flyBV = nil end
    end
end)

-- ============================================================
-- АВТОВЫБОР ПЕРВОЙ ВКЛАДКИ
-- ============================================================
pcall(function()
    Library:Notify("AbyssalHub", "Script loaded successfully!", 5)
end)

pcall(function()
    if Library.Tabs[1] then
        for _, t in ipairs(Library.Tabs) do
            t.Frame.Visible = false
        end
        Library.Tabs[1].Frame.Visible = true
        Library.CurrentTab = Library.Tabs[1]
        
        TweenService:Create(Library.Tabs[1].Button, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(140, 60, 255),
            BackgroundTransparency = 0.2,
            TextColor3 = Color3.fromRGB(255, 255, 255)
        }):Play()
    end
end)

return Library