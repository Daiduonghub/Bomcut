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
AutoFarm = false
CurrentQuestName = nil
QuestCooldown = 0
currentTarget = nil
activeTween = nil
StopActiveTween = function() end
AddHighlight = function() end
RemoveHighlight = function() end
FastAttack = false
FastAttackDelay = 0.03

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
    
    local function updateCanvas()
        TabFrame.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y + 20)
    end
    
    updateCanvas()
    TabLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateCanvas)
    TabFrame.ChildAdded:Connect(function()
        task.wait()
        updateCanvas()
    end)
    TabFrame.ChildRemoved:Connect(function()
        task.wait()
        updateCanvas()
    end)
    
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
        task.wait()
        updateCanvas()
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
local TabSettings = Library:CreateTab("Settings")
local Tab1 = Library:CreateTab("Main")

--  ---------UI CONTROL---------
-- Thêm biến này TRƯỚC CreateToggle
local FirstToggleInit = true

Library:CreateToggle(Tab1, "Auto Farm Level", false, function(v)
    AutoFarm = v
    
    -- Chặn notify lần init đầu tiên (khi tạo toggle)
    if FirstToggleInit then
        FirstToggleInit = false
        return
    end
    
    if v then
        CurrentQuestName = nil
        QuestCooldown = 0
        AddHighlight()
        Library:Notify("AbyssalHub", "Auto Farm: ON", 2)
    else
        currentTarget = nil
        if StopActiveTween then StopActiveTween() end
        if LP and LP.Character then
            local root = LP.Character:FindFirstChild("HumanoidRootPart")
            if root then root.Anchored = false end
        end
        RemoveHighlight()
        Library:Notify("AbyssalHub", "Auto Farm: OFF", 2)
    end
end)

-- Re-add highlight khi player respawn
LP.CharacterAdded:Connect(function(char)
    if AutoFarm then
        task.wait(0.5) -- Chờ character load xong
        AddHighlight()
    end
end)

-- Fast Attack toggle
Library:CreateToggle(TabSettings, "Fast Attack", false, function(v)
    FastAttack = v
end)

Library:CreateSlider(TabSettings, "Fast Attack Delay", 0.01, 0.2, 0.03, function(v)
    FastAttackDelay = v
end)

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

-- ⬇️ QUAN TRỌNG: ÉP UPDATE CANVAS THỦ CÔNG ⬇️
TabStats.Frame.Visible = true
task.wait(0.15)
local layout = TabStats.Frame:FindFirstChildOfClass("UIListLayout")
if layout then
    TabStats.Frame.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 20)
end

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
-- AUTO FARM LEVEL - BLOX FRUITS SEA 1 (FIX TWEEN + QUEST)
-- ============================================================

local RS = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

repeat task.wait() until game:IsLoaded() and LP.Character

local Net = RS:WaitForChild("Modules"):WaitForChild("Net")
local RegisterAttack = Net:WaitForChild("RE/RegisterAttack")
local RegisterHit = Net:WaitForChild("RE/RegisterHit")
local Remotes = RS:WaitForChild("Remotes")
local CommF_ = Remotes:WaitForChild("CommF_")

FirstSeaQuests = {
    { MinLevel = 650, MaxLevel = 700, QuestName = "FountainQuest", QuestId = 2, NpcName = "Hero", NpcPosition = CFrame.new(5257, 39, 4051), MobName = "Galley Captain", MobSpawn = CFrame.new(5790, 60, 4975) },
    { MinLevel = 625, MaxLevel = 649, QuestName = "FountainQuest", QuestId = 1, NpcName = "Hero", NpcPosition = CFrame.new(5257, 39, 4051), MobName = "Galley Pirate", MobSpawn = CFrame.new(5554, 82, 3971) },
    { MinLevel = 550, MaxLevel = 624, QuestName = "SkyExp2Quest", QuestId = 2, NpcName = "Conylee", NpcPosition = CFrame.new(-7903, 5635, -1411), MobName = "Nomadic Pirate", MobSpawn = CFrame.new(-7819, 5545, -1727) },
    { MinLevel = 525, MaxLevel = 549, QuestName = "SkyExp2Quest", QuestId = 1, NpcName = "Conylee", NpcPosition = CFrame.new(-7903, 5635, -1411), MobName = "Royal Squad", MobSpawn = CFrame.new(-7667, 5747, -1964) },
    { MinLevel = 475, MaxLevel = 524, QuestName = "SkyExp1Quest", QuestId = 2, NpcName = "Instance", NpcPosition = CFrame.new(-7903, 5635, -1411), MobName = "Shanda", MobSpawn = CFrame.new(-7657, 5607, -1412) },
    { MinLevel = 450, MaxLevel = 474, QuestName = "SkyExp1Quest", QuestId = 1, NpcName = "Instance", NpcPosition = CFrame.new(-7903, 5635, -1411), MobName = "God's Guard", MobSpawn = CFrame.new(-4718, 850, -1945) },
    { MinLevel = 400, MaxLevel = 449, QuestName = "FishmanQuest", QuestId = 2, NpcName = "Villager", NpcPosition = CFrame.new(6112, 19, 1567), MobName = "Fishman Commando", MobSpawn = CFrame.new(6337, -1, 1145) },
    { MinLevel = 375, MaxLevel = 399, QuestName = "FishmanQuest", QuestId = 1, NpcName = "Villager", NpcPosition = CFrame.new(6112, 19, 1567), MobName = "Fishman Warrior", MobSpawn = CFrame.new(6090, -1, 1494) },
    { MinLevel = 325, MaxLevel = 374, QuestName = "MagmaQuest", QuestId = 2, NpcName = "Military Spy", NpcPosition = CFrame.new(-5315, 12, 8515), MobName = "Military Spy", MobSpawn = CFrame.new(-5808, 51, 8829) },
    { MinLevel = 300, MaxLevel = 324, QuestName = "MagmaQuest", QuestId = 1, NpcName = "Military Spy", NpcPosition = CFrame.new(-5315, 12, 8515), MobName = "Military Soldier", MobSpawn = CFrame.new(-5401, 18, 8450) },
    { MinLevel = 250, MaxLevel = 299, QuestName = "ColosseumQuest", QuestId = 1, NpcName = "Noble", NpcPosition = CFrame.new(-1580, 7, -2992), MobName = "Toga Warrior", MobSpawn = CFrame.new(-1840, 7, -2735) },
    { MinLevel = 210, MaxLevel = 249, QuestName = "PrisonerQuest", QuestId = 2, NpcName = "Military Detective", NpcPosition = CFrame.new(487, 5, 327), MobName = "Dangerous Prisoner", MobSpawn = CFrame.new(1099, 5, 130) },
    { MinLevel = 190, MaxLevel = 209, QuestName = "PrisonerQuest", QuestId = 1, NpcName = "Military Detective", NpcPosition = CFrame.new(487, 5, 327), MobName = "Prisoner", MobSpawn = CFrame.new(524, 5, 484) },
    { MinLevel = 175, MaxLevel = 189, QuestName = "SkyQuest", QuestId = 2, NpcName = "Mad Scientist", NpcPosition = CFrame.new(-4842, 718, -2622), MobName = "Dark Master", MobSpawn = CFrame.new(-5244, 431, -2279) },
    { MinLevel = 150, MaxLevel = 174, QuestName = "SkyQuest", QuestId = 1, NpcName = "Mad Scientist", NpcPosition = CFrame.new(-4842, 718, -2622), MobName = "Sky Bandit", MobSpawn = CFrame.new(-4962, 281, -2880) },
    { MinLevel = 120, MaxLevel = 149, QuestName = "MarineQuest2", QuestId = 1, NpcName = "Navy Lieutenant", NpcPosition = CFrame.new(-2440, 13, 3216), MobName = "Chief Petty Officer", MobSpawn = CFrame.new(-2566, 6, 3314) },
    { MinLevel = 100, MaxLevel = 119, QuestName = "SnowQuest", QuestId = 2, NpcName = "Snow Adventurer", NpcPosition = CFrame.new(1386, 87, -1298), MobName = "Snowman", MobSpawn = CFrame.new(1361, 87, -1544) },
    { MinLevel = 90, MaxLevel = 99, QuestName = "SnowQuest", QuestId = 1, NpcName = "Snow Adventurer", NpcPosition = CFrame.new(1386, 87, -1298), MobName = "Snow Bandit", MobSpawn = CFrame.new(1279, 104, -1433) },
    { MinLevel = 75, MaxLevel = 89, QuestName = "DesertQuest", QuestId = 2, NpcName = "Desert Adventurer", NpcPosition = CFrame.new(897, 7, 4388), MobName = "Desert Officer", MobSpawn = CFrame.new(1134, 10, 4424) },
    { MinLevel = 60, MaxLevel = 74, QuestName = "DesertQuest", QuestId = 1, NpcName = "Desert Adventurer", NpcPosition = CFrame.new(897, 7, 4388), MobName = "Desert Bandit", MobSpawn = CFrame.new(944, 7, 4277) },
    { MinLevel = 40, MaxLevel = 59, QuestName = "BuggyQuest1", QuestId = 2, NpcName = "Rich Man", NpcPosition = CFrame.new(-1140, 5, 3828), MobName = "Brute", MobSpawn = CFrame.new(-1390, 16, 4101) },
    { MinLevel = 30, MaxLevel = 39, QuestName = "BuggyQuest1", QuestId = 1, NpcName = "Rich Man", NpcPosition = CFrame.new(-1140, 5, 3828), MobName = "Pirate", MobSpawn = CFrame.new(-1201, 14, 3938) },
    { MinLevel = 15, MaxLevel = 29, QuestName = "JungleQuest", QuestId = 2, NpcName = "Adventurer", NpcPosition = CFrame.new(-1601, 37, 153), MobName = "Gorilla", MobSpawn = CFrame.new(-1237, 6, -510) },
    { MinLevel = 10, MaxLevel = 14, QuestName = "JungleQuest", QuestId = 1, NpcName = "Adventurer", NpcPosition = CFrame.new(-1683.78, 50.35, 171.07), MobName = "Monkey", MobSpawn = CFrame.new(-1498, 51, 60) },
    { MinLevel = 1, MaxLevel = 9, QuestName = "BanditQuest1", QuestId = 1, NpcName = "Bandit Hero", NpcPosition = CFrame.new(1059, 16, 1549), MobName = "Bandit", MobSpawn = CFrame.new(1141, 17, 1690) }
}

-- ============================================================
-- BIẾN CẤU HÌNH
-- ============================================================
-- Chỉ set nếu chưa tồn tại (không ghi đè toggle)
if AutoFarm == nil then AutoFarm = false end
if CurrentQuestName == nil then CurrentQuestName = nil end
if CurrentMobName == nil then CurrentMobName = "Bandit" end
if QuestCFrame == nil then QuestCFrame = CFrame.new(1059, 16, 1547) end
if AttackDelay == nil then AttackDelay = 0.5 end
if HitCount == nil then HitCount = 3 end
if TweenSpeed == nil then TweenSpeed = 150 end
if QuestCooldown == nil then QuestCooldown = 0 end

-- ============================================================
-- TÌM MOB
-- ============================================================
local function FindNearestMob(name, maxDist)
    maxDist = maxDist or 5000
    local char = LP.Character
    if not char then return nil end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return nil end
    
    local enemiesFolder = workspace:FindFirstChild("Enemies")
    if not enemiesFolder then return nil end
    
    local closest, closestDist = nil, maxDist
    for _, mob in ipairs(enemiesFolder:GetChildren()) do
        if mob.Name == name then
            local hum = mob:FindFirstChild("Humanoid")
            local mroot = mob:FindFirstChild("HumanoidRootPart")
            if hum and mroot and hum.Health > 0 then
                local dist = (root.Position - mroot.Position).Magnitude
                if dist < closestDist then
                    closestDist = dist
                    closest = mob
                end
            end
        end
    end
    return closest, closestDist
end

local function GetHitPart(mob)
    local parts = {}
    for _, p in ipairs(mob:GetDescendants()) do
        if p:IsA("BasePart") and p.Name ~= "HumanoidRootPart" then
            table.insert(parts, p)
        end
    end
    if #parts == 0 then
        return mob:FindFirstChild("HumanoidRootPart")
    end
    return parts[math.random(1, #parts)]
end

-- ============================================================
-- FIRE REMOTE
-- ============================================================
local function FireRegisterAttack()
    pcall(function()
        RegisterAttack:FireServer(AttackDelay, HitCount)
    end)
end

local function FireRegisterHit(targetPart)
    pcall(function()
        RegisterHit:FireServer(targetPart, {}, "168716de")
    end)
end

-- ============================================================
-- QUEST SYSTEM (CHECK QUA PLAYERGUI - ĐƠN GIẢN)
-- ============================================================
local function GetLocalPlayer()
    return LP -- LP đã khai báo ở đầu file
end

local function HasActiveQuest()
    local player = GetLocalPlayer()
    if not player then return false end

    local playerGui = player:FindFirstChild("PlayerGui")
    if not playerGui then return false end

    -- FindFirstChild recursive để tìm sâu nếu frame bị nest
    local trackedFrame = playerGui:FindFirstChild("TrackedQuestFrame", true)
    if trackedFrame and trackedFrame.Visible then
        return true
    end

    return false
end

local function FindQuestByLevel(level)
    for _, q in ipairs(FirstSeaQuests) do
        if level >= q.MinLevel and level <= q.MaxLevel then
            return q
        end
    end
    return FirstSeaQuests[1]
end

local function AutoAcceptQuest()
    local level = LP.Data.Level.Value
    local questData = FindQuestByLevel(level)
    if not questData then return nil end
    
    local questKey = questData.QuestName .. "|" .. tostring(questData.QuestId)
    local hasQuest = HasActiveQuest()
    
    -- Nếu CHƯA có quest HOẶC quest khác level → nhận lại
    if not hasQuest or CurrentQuestName ~= questKey then
        if tick() < QuestCooldown then return nil end
        
        pcall(function()
            CommF_:InvokeServer("StartQuest", questData.QuestName, questData.QuestId)
        end)
        
        CurrentQuestName = questKey
        CurrentMobName = questData.MobName
        QuestCFrame = questData.MobSpawn
        QuestCooldown = tick() + 3
        
        return questData
    end
    
    return questData
end

-- ============================================================
-- VÒNG LẶP AUTO FARM (FIX - TỰ BAY TỚI SPAWN KHI KHÔNG CÓ MOB)
-- ============================================================
currentTarget = nil
activeTween = nil
local HitHash = "168716de"

StopActiveTween = function()
    if activeTween then
        activeTween:Cancel()
        activeTween = nil
    end
end

task.spawn(function()
    while task.wait(0.1) do
        local ok, err = pcall(function()
            if not AutoFarm then
                currentTarget = nil
                StopActiveTween()
                return
            end
            
            local char = LP.Character
            if not char then return end
            local root = char:FindFirstChild("HumanoidRootPart")
            local hum = char:FindFirstChild("Humanoid")
            if not root or not hum or hum.Health <= 0 then
                task.wait(0.5)
                return
            end
            
            pcall(AutoAcceptQuest)
            
            -- Tìm mob bán kính RỘNG 2000 studs
            local target = FindNearestMob(CurrentMobName, 2000)
            currentTarget = target
            
            if target then
                local tHum = target:FindFirstChild("Humanoid")
                local mobRoot = target:FindFirstChild("HumanoidRootPart")
                
                if tHum and tHum.Health > 0 and mobRoot then
                    local distToMob = (root.Position - mobRoot.Position).Magnitude
                    
                    if distToMob > 20 then
                        -- Xa mob → tween tới
                        if not activeTween or activeTween.PlaybackState ~= Enum.PlaybackState.Playing then
                            local dest = CFrame.new(mobRoot.Position + Vector3.new(0, 10, 0))
                            local dist = (root.Position - dest.Position).Magnitude
                            local duration = math.clamp(dist / TweenSpeed, 0.1, 15)
                            activeTween = TweenService:Create(root, TweenInfo.new(duration, Enum.EasingStyle.Sine), {
    CFrame = dest
})
                            activeTween:Play()
                            activeTween.Completed:Connect(function()
                                activeTween = nil
                            end)
                        end
                    else
                        StopActiveTween()
                        root.CFrame = CFrame.new(mobRoot.Position + Vector3.new(0, 10, 0))
                    end
                    
-- Đánh
if distToMob <= 15 then
    pcall(function()
        RegisterAttack:FireServer(AttackDelay, HitCount)
    end)
    
    for i = 1, HitCount do
        for _, p in ipairs(target:GetDescendants()) do
            if p:IsA("BasePart") then
                pcall(function()
                    RegisterHit:FireServer(p, {}, HitHash)
                end)
                pcall(function()
                    RegisterHit:FireServer(p, {})
                end)
            end
        end
        task.wait(AttackDelay / HitCount)
    end
end
            else
                -- Không có mob → bay tới vị trí spawn chờ
                currentTarget = nil
                
                if QuestCFrame then
                    local distToSpawn = (root.Position - QuestCFrame.Position).Magnitude
                    if distToSpawn > 20 then
                        if not activeTween or activeTween.PlaybackState ~= Enum.PlaybackState.Playing then
                            local dest = QuestCFrame + Vector3.new(0, 10, 0)
                            local dist = (root.Position - dest.Position).Magnitude
                            local duration = math.clamp(dist / TweenSpeed, 0.1, 15)
                            activeTween = TweenService:Create(root, TweenInfo.new(duration, Enum.EasingStyle.Sine), {
    CFrame = dest
})
                            activeTween:Play()
                            activeTween.Completed:Connect(function()
                                activeTween = nil
                            end)
                        end
                    end
                end
            end
        end)
        
        if not ok then
            warn("[AbyssalHub] Farm error: " .. tostring(err))
        end
    end
end)

-- Dùng STEPPED (chạy TRƯỚC physics) thay vì HEARTBEAT (chạy SAU physics)
-- Stepped: chỉ chống knockback, KHÔNG snap CFrame
RunService.Stepped:Connect(function()
    local char = LP.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    -- Không farm / không target → unanchor
    if not AutoFarm or not currentTarget then
        if root.Anchored then root.Anchored = false end
        return
    end
    
    local mobRoot = currentTarget:FindFirstChild("HumanoidRootPart")
    local mobHum = currentTarget:FindFirstChild("Humanoid")
    if not mobRoot or not mobHum or mobHum.Health <= 0 then
        currentTarget = nil
        root.Anchored = false
        return
    end
    
    local dist = (root.Position - mobRoot.Position).Magnitude
    
    if dist <= 20 then
        -- ✅ ĐÃ Ở TRÊN ĐẦU MOB → ANCHOR CỨNG
        if activeTween then
            activeTween:Cancel()
            activeTween = nil
        end
        
        root.Anchored = true
        root.CFrame = CFrame.new(mobRoot.Position + Vector3.new(0, 10, 0))
        root.Velocity = Vector3.zero
        root.RotVelocity = Vector3.zero
    else
        -- ⚠️ ĐANG BAY → UNANCHOR ĐỂ TWEEN HOẠT ĐỘNG
        if root.Anchored then root.Anchored = false end
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
        
        -- Force update CanvasSize
        local layout = Library.Tabs[1].Frame:FindFirstChildOfClass("UIListLayout")
        if layout then
            Library.Tabs[1].Frame.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 20)
        end
    end
end)

return Library