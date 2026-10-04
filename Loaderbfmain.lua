-- ============================================================
-- UI LIBRARY "ABYSSALHUB"
-- ============================================================
local CoreGui = game:GetService("CoreGui")
local TextService = game:GetService("TextService")
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
SubTitle.Text = "v1.0-Blox fruits"
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
CleanupFly = function() end
AddHighlight = function() end
RemoveHighlight = function() end
FA_On = false
FA_Delay = 0.03
BM_On = false
BM_Max = 5  -- thay vì BM_Range / BM_Offset
-- Bring Mob — khai báo trước để toggle thấy được
BroughtMobData  = {}
RestoreMob      = function() end
ForceRestoreAllMobs = function() end   -- ★ stub, gán thực sau
-- ★ Combo state
ComboPhase  = "melee"
ComboTarget = nil
ComboStart  = 0
FarmWeapon = nil  -- category: "Melee" / "Sword" / "Gun" / nil

local WeaponDB = {
    Melee = {
        "Black Leg", "Electro", "Fishman Karate", "Superhuman",
        "Death Step",  "Dragon Claw", "Sharkman Karate", "Electric Claw",
        "Dragon Talon", "Godhuman", "Sanguine Art",
    },
    Sword = {
        "Katana", "Cutlass", "Iron Mace", "Triple Katana",
        "Dual Katana", "Saddi", "Wando", "Bisento",
        "Yama", "Dark Blade", "Shisui", "True Triple Katana",
        "Cursed Dual Katana", "Longsword",
        "Buddy Sword", "Pole", "Koko", "Rengoku",
        "Midnight Blade", "Tushita", "Spikey Trident",
        "Hallow Scythe", "Dark Dagger", "Fox Lamp",
    },
    Gun = {
        "Flintlock", "Slingshot", "Musket", "Dual Flintlock",
        "Cannon", "Kabucha", "Cursed Dual Pistol",
        "Bizarre Rifle", "Acidum Rifle", "Serpent Bow",
        "Soul Cane", "Dragonstorm",
    },
}

local function FindWeaponByCategory(cat)
    if not cat or cat == "None" then return nil end

    local list = WeaponDB[cat]
    if not list then return nil end

    local bp = LP:FindFirstChild("Backpack")
    if not bp then return nil end

    -- Tìm vũ khí đầu tiên trong list mà player có
    for _, name in ipairs(list) do
        if bp:FindFirstChild(name) then return name end
    end
    return nil
end

-- ============================================================
-- BOSS DATABASE — spawn CFrame + respawn + sea
-- ============================================================
BossDB = {
    -- ══════════ FIRST SEA ══════════
    ["Gorilla King"]       = { Level = 25,   Sea = 1, HP = 2000,   Respawn = 120,Spawn = CFrame.new(-1189.11267, 13.9037971, -552.591553) },
    ["Bobby"]              = { Level = 55,   Sea = 1, HP = 5000,   Respawn = 90,  Spawn = CFrame.new(-1121.37622, 52.1586761, 4121.94678) },
    ["The Saw"]            = { Level = 100,  Sea = 1, HP = 8000,   Respawn = 120, Spawn = CFrame.new( 1361,  87,  -1544) },
    ["Fajita"]             = { Level = 130,  Sea = 1, HP = 12000,  Respawn = 120, Spawn = CFrame.new( 1380,  87,  -1298) },
    ["Saber Expert"]       = { Level = 175,  Sea = 1, HP = 20000,  Respawn = 180, Spawn = CFrame.new(-1405,  20,     45) },
    ["Wysper"]             = { Level = 175,  Sea = 1, HP = 15000,  Respawn = 180, Spawn = CFrame.new(-5244, 431,  -2279) },
    ["Thunder God"]        = { Level = 175,  Sea = 1, HP = 15000,  Respawn = 180, Spawn = CFrame.new(-5244, 431,  -2279) },
    ["Iron Mace"]          = { Level = 285,  Sea = 1, HP = 35000,  Respawn = 240, Spawn = CFrame.new(-1840,   7,  -2735) },
    ["Greybeard"]          = { Level = 375,  Sea = 1, HP = 50000,  Respawn = 300, Spawn = CFrame.new( 6112,  19,   1567) },
    ["Vice Admiral"]       = { Level = 375,  Sea = 1, HP = 50000,  Respawn = 300, Spawn = CFrame.new(-2566,   6,   3314) },
    ["Darkbeard"]          = { Level = 1000, Sea = 1, HP = 100000, Respawn = 600, Spawn = CFrame.new( 5790,  60,   4975) },

    -- ══════════ SECOND SEA ══════════
    ["Diamond"]            = { Level = 1000, Sea = 2, HP = 75000,  Respawn = 240, Spawn = CFrame.new(-1650,  20,   -200) },
    ["Don Swan"]           = { Level = 1000, Sea = 2, HP = 80000,  Respawn = 300, Spawn = CFrame.new(-1580,   7,  -2992) },
    ["Muscle King"]        = { Level = 850,  Sea = 2, HP = 60000,  Respawn = 240, Spawn = CFrame.new(-5808,  51,   8829) },
    ["Pirate Big Brother"] = { Level = 1200, Sea = 2, HP = 95000,  Respawn = 300, Spawn = CFrame.new( 6337,  -1,   1145) },
    ["Jeremy"]             = { Level = 1250, Sea = 2, HP = 100000, Respawn = 300, Spawn = CFrame.new( 1099,   5,    130) },
    ["Cursed Captain"]     = { Level = 1325, Sea = 2, HP = 120000, Respawn = 300, Spawn = CFrame.new(-5808,  51,   8829) },

    -- ══════════ THIRD SEA ══════════
    ["Island Empress"]     = { Level = 1450, Sea = 3, HP = 180000, Respawn = 300, Spawn = CFrame.new( 5257,  39,   4051) },
    ["Cursed Skeleton"]    = { Level = 1500, Sea = 3, HP = 180000, Respawn = 300, Spawn = CFrame.new(-5401,  18,   8450) },
    ["Kilo Admiral"]       = { Level = 1525, Sea = 3, HP = 190000, Respawn = 300, Spawn = CFrame.new(-7657, 5607, -1412) },
    ["Stone"]              = { Level = 1550, Sea = 3, HP = 200000, Respawn = 300, Spawn = CFrame.new(-7903, 5635, -1411) },
    ["Cake Queen"]         = { Level = 1575, Sea = 3, HP = 200000, Respawn = 300, Spawn = CFrame.new(  487,   5,    327) },
    ["King Cake"]          = { Level = 1600, Sea = 3, HP = 210000, Respawn = 300, Spawn = CFrame.new(  524,   5,    484) },
    ["Misery"]             = { Level = 1600, Sea = 3, HP = 210000, Respawn = 300, Spawn = CFrame.new(-1580,   7,  -2992) },
    ["Captain Elephant"]   = { Level = 1625, Sea = 3, HP = 220000, Respawn = 300, Spawn = CFrame.new(-7667, 5747, -1964) },
    ["Beautiful Pirate"]   = { Level = 1650, Sea = 3, HP = 230000, Respawn = 300, Spawn = CFrame.new(-7819, 5545, -1727) },
    ["Candy Pirate"]       = { Level = 1650, Sea = 3, HP = 220000, Respawn = 300, Spawn = CFrame.new(-1683,  50,    171) },
    ["Cake Prince"]        = { Level = 1700, Sea = 3, HP = 240000, Respawn = 360, Spawn = CFrame.new(-1601,  37,    153) },
    ["Soul Reaper"]        = { Level = 1700, Sea = 3, HP = 240000, Respawn = 360, Spawn = CFrame.new( 6090,  -1,   1494) },
    ["Fishman Lord"]       = { Level = 1700, Sea = 3, HP = 240000, Respawn = 360, Spawn = CFrame.new(-5315,  12,   8515) },
    ["Longma"]             = { Level = 1725, Sea = 3, HP = 250000, Respawn = 360, Spawn = CFrame.new(-4718, 850,  -1945) },
    ["Cyborg"]             = { Level = 1725, Sea = 3, HP = 250000, Respawn = 360, Spawn = CFrame.new(-2440,  13,   3216) },
    ["Tank"]               = { Level = 1750, Sea = 3, HP = 260000, Respawn = 360, Spawn = CFrame.new(-4842, 718,  -2622) },
    ["Dough King"]         = { Level = 1800, Sea = 3, HP = 280000, Respawn = 600, Spawn = CFrame.new(-1498,  51,     60) },
    ["Rip_Indra"]          = { Level = 3000, Sea = 3, HP = 500000, Respawn = 900, Spawn = CFrame.new(-4962, 281,  -2880) },
}

-- state boss farm
BossFarmOn   = false
SelectedBoss = "None"
BossTarget   = nil

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

local ActiveNotifications = {}   -- list of { Frame = ..., Height = ... }

local function UpdateNotifPositions()
    local cumulative = 20   -- bottom margin
    for i, notif in ipairs(ActiveNotifications) do
        if notif.Frame and notif.Frame.Parent then
            cumulative = cumulative + notif.Height
            local y = -cumulative
            TweenService:Create(notif.Frame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Position = UDim2.new(1, -340, 1, y)
            }):Play()
            cumulative = cumulative + 10   -- gap giữa các notif
        end
    end
end

function Library:Notify(title, text, duration)
    duration = duration or 4

    -- ★ Đo chiều cao text thực tế
    local TEXT_WIDTH   = 320 - 40   -- khung 320 rộng, padding trái phải 20 mỗi bên
    local TEXT_SIZE    = 12
    local titleHeight  = 24
    local topPad       = 10
    local midGap       = 2
    local bottomPad    = 12

    local measured = TextService:GetTextSize(
        text,
        TEXT_SIZE,
        Enum.Font.Gotham,
        Vector2.new(TEXT_WIDTH, 1000)
    )
    local textHeight  = math.max(20, measured.Y)
    local notifHeight = topPad + titleHeight + midGap + textHeight + bottomPad

    local NotifFrame = Instance.new("Frame")
    NotifFrame.Size = UDim2.new(0, 320, 0, notifHeight)   -- ★ chiều cao động
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
    NotifTitle.Size = UDim2.new(1, -30, 0, titleHeight)
    NotifTitle.Position = UDim2.new(0, 18, 0, topPad)
    NotifTitle.BackgroundTransparency = 1
    NotifTitle.Text = title
    NotifTitle.TextColor3 = Color3.fromRGB(235, 225, 255)
    NotifTitle.TextSize = 15
    NotifTitle.Font = Enum.Font.GothamBold
    NotifTitle.TextXAlignment = Enum.TextXAlignment.Left
    NotifTitle.TextYAlignment = Enum.TextYAlignment.Top
    NotifTitle.Parent = NotifFrame

    local NotifText = Instance.new("TextLabel")
    NotifText.Size = UDim2.new(1, -30, 0, textHeight)   -- ★ dùng chiều cao đo được
    NotifText.Position = UDim2.new(0, 18, 0, topPad + titleHeight + midGap)
    NotifText.BackgroundTransparency = 1
    NotifText.Text = text
    NotifText.TextColor3 = Color3.fromRGB(180, 180, 200)
    NotifText.TextSize = TEXT_SIZE
    NotifText.Font = Enum.Font.Gotham
    NotifText.TextXAlignment = Enum.TextXAlignment.Left
    NotifText.TextYAlignment = Enum.TextYAlignment.Top
    NotifText.TextWrapped = true
    NotifText.Parent = NotifFrame

    -- Đẩy vào list — notif mới nhất ở index 1
    table.insert(ActiveNotifications, 1, {
        Frame  = NotifFrame,
        Height = notifHeight,
    })

    -- Vị trí ban đầu: offscreen bên phải
    NotifFrame.Position = UDim2.new(1, 20, 1, -notifHeight - 20)

    task.spawn(function()
        task.wait()
        UpdateNotifPositions()
    end)

    -- Auto remove
    task.delay(duration, function()
        for i, n in ipairs(ActiveNotifications) do
            if n.Frame == NotifFrame then
                table.remove(ActiveNotifications, i)
                break
            end
        end

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
OpenButton.Text = "Abyssal[Premium]"
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
local TabSettings = Library:CreateTab("Setting Farm")
local TabFarm = Library:CreateTab("Farming")

--  ---------UI CONTROL---------
-- Thêm biến này TRƯỚC CreateToggle
local FirstToggleInit = true

Library:CreateToggle(TabFarm, "Auto Farm Level", false, function(v)
    AutoFarm = v

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
        ForceRestoreAllMobs()  -- ★ force cleanup mob đang bring
        CleanupFly()
        RemoveHighlight()
        Library:Notify("AbyssalHub", "Auto Farm: OFF", 2)
    end
end)

-- Re-add highlight khi player respawn
LP.CharacterAdded:Connect(function(char)
    if AutoFarm then
        task.wait(0.5)   -- Chờ character load xong
        AddHighlight()
    end
end)

-- ══════════════════════════════════════════════
-- BOSS FARM UI
-- ══════════════════════════════════════════════
local FirstBossToggleInit = true
Library:CreateLabel(TabFarm, "── BOSS FARM ──")

-- build dropdown options sort theo Sea → Level
local _bossOpts = {"None"}
local _sorted = {}
for nm, d in pairs(BossDB) do
    table.insert(_sorted, {Name = nm, Level = d.Level, Sea = d.Sea})
end
table.sort(_sorted, function(a, b)
    if a.Sea ~= b.Sea then return a.Sea < b.Sea end
    return a.Level < b.Level
end)
for _, b in ipairs(_sorted) do
    table.insert(_bossOpts, string.format("%s [Lv.%d]", b.Name, b.Level))
end

Library:CreateDropdown(TabFarm, "Select Boss", _bossOpts, "None", function(v)
    if v == "None" then
        SelectedBoss = "None"
    else
        -- cắt " [Lv.xxx]" ra lấy tên gốc
        SelectedBoss = v:match("^(.-)%s*%[Lv") or v
    end
    BossTarget = nil
end)

Library:CreateToggle(TabFarm, "Auto Farm Boss", false, function(v)
    BossFarmOn = v

    if FirstBossToggleInit then
        FirstBossToggleInit = false
        return
    end

    if v then
        AddHighlight()
        Library:Notify("AbyssalHub", "Boss Farm: ON — " .. tostring(SelectedBoss), 2)
    else
        BossTarget = nil
        ForceRestoreAllMobs()  -- ★
        if not AutoFarm then
            CleanupFly()
            RemoveHighlight()
        end
        Library:Notify("AbyssalHub", "Boss Farm: OFF", 2)
    end
end)

Library:CreateDropdown(TabSettings, "Farm Weapon", {"None", "Melee", "Sword", "Gun"}, "None", function(v)
    FarmWeapon = (v == "None") and nil or v   -- lưu category
end)

Library:CreateToggle(TabSettings, "FastAtk", false, function(v)
    FA_On = v
end)

Library:CreateSlider(TabSettings, "AtkSpeed", 0.01, 0.2, 0.03, function(v)
    FA_Delay = v
end)

Library:CreateTextBox(TabSettings, "Tween speed", 120, function(v)
    TweenSpeed = math.clamp(math.floor(v), 30, 500)
end)

Library:CreateToggle(TabSettings, "BringMob", false, function(v)
    BM_On = v
    if not v then
        ForceRestoreAllMobs()
    end
end)

Library:CreateTextBox(TabSettings, "Mob count (1-5)", 5, function(v)
    BM_Max = math.clamp(math.floor(v), 1, 5)
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
-- AUTO FARM LEVEL + BRING MOB (REWRITE - FIXED)
-- ============================================================

local RS = game:GetService("ReplicatedStorage")

repeat task.wait() until game:IsLoaded() and LP.Character

local Net          = RS:WaitForChild("Modules"):WaitForChild("Net")
local RegisterAttack = Net:WaitForChild("RE/RegisterAttack")
local RegisterHit    = Net:WaitForChild("RE/RegisterHit")
local CommF_       = RS:WaitForChild("Remotes"):WaitForChild("CommF_")

-- ============================================================
-- QUEST LIST
-- ============================================================
local FirstSeaQuests = {
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
    { MinLevel = 1,  MaxLevel = 9,   QuestName = "BanditQuest1", QuestId = 1, NpcName = "Bandit Hero", NpcPosition = CFrame.new(1059, 16, 1549), MobName = "Bandit", MobSpawn = CFrame.new(1141, 17, 1690) }
}

-- ============================================================
-- CONFIG
-- ============================================================
if AttackDelay == nil then AttackDelay = 0.5 end
if HitCount   == nil then HitCount = 3 end
if TweenSpeed == nil then TweenSpeed = 120 end   -- 120 studs/s, bay nhẹ nhàng
if CurrentMobName == nil then CurrentMobName = "Bandit" end
if QuestCFrame == nil then QuestCFrame = CFrame.new(1059, 16, 1547) end
if QuestCooldown == nil then QuestCooldown = 0 end
if CurrentQuestName == nil then CurrentQuestName = nil end
if currentTarget == nil then currentTarget = nil end

local PLAYER_FLY_Y  = 15
local ATTACK_RANGE  = 60
local STOP_RANGE    = 12
local DETECT_RANGE  = 300
local MIN_Y = -50     -- -50 thay vì 20, để bay vào Magma/Sky vẫn OK     -- không bay thấp hơn mức này (tránh rớt biển)
local HitHash       = "168716de"

-- Slot cố định — cluster gọn thay vì hình tròn
local SLOT_OFFSETS = {
    Vector3.new( 0,  0,  0),
    Vector3.new( 3,  0,  3),
    Vector3.new(-3,  0,  3),
    Vector3.new( 3,  0, -3),
    Vector3.new(-3,  0, -3),
}

-- ============================================================
-- HELPERS
-- ============================================================
local function GetPlayerParts()
    local char = LP.Character
    if not char then return nil end
    local root = char:FindFirstChild("HumanoidRootPart")
    local hum  = char:FindFirstChild("Humanoid")
    if not root or not hum or hum.Health <= 0 then return nil end
    return root
end

local function GetMobParts(mob)
    if not mob or not mob.Parent then return nil end
    local hum  = mob:FindFirstChild("Humanoid")
    local root = mob:FindFirstChild("HumanoidRootPart")
    if not hum or not root or hum.Health <= 0 then return nil end
    return root, hum
end

local function FindNearestMob(name, maxDist)
    maxDist = maxDist or 2000
    local myRoot = GetPlayerParts()
    if not myRoot then return nil end

    local enemies = workspace:FindFirstChild("Enemies")
    if not enemies then return nil end

    local best, bestDist = nil, maxDist
    for _, mob in ipairs(enemies:GetChildren()) do
        if mob.Name == name then
            local mRoot = GetMobParts(mob)
            if mRoot then
                local d = (myRoot.Position - mRoot.Position).Magnitude
                if d < bestDist then
                    bestDist = d
                    best = mob
                end
            end
        end
    end
    return best, bestDist
end

-- ★ BATCH PARTS — chỉ lấy 5 parts chính, cache lại
local PART_CACHE = {}

local function GetAttackParts(mob)
    local cached = PART_CACHE[mob]
    if cached and cached[1] and cached[1].Parent then
        return cached
    end

    local names = {"Head", "UpperTorso", "LowerTorso", "LeftHand", "RightHand"}
    local parts = {}
    for _, n in ipairs(names) do
        local p = mob:FindFirstChild(n)
        if p and p:IsA("BasePart") then
            table.insert(parts, p)
        end
    end

    if #parts == 0 then
        local hrp = mob:FindFirstChild("HumanoidRootPart")
        if hrp then table.insert(parts, hrp) end
    end

    PART_CACHE[mob] = parts
    return parts
end

-- ============================================================
-- MOVEMENT SYSTEM (LinearVelocity - bay bằng physics thật)
-- ============================================================
local farmTargetPos = nil
local farmMoving    = false
local flyBV         = nil
local flyAttach     = nil
local flyAlign      = nil
local flyAlignAtt   = nil

-- ============================================================
-- NOCLIP (giữ CanCollide = false liên tục khi bay)
-- ============================================================
local noclipActive = false

local function SetNoclip(on)
    noclipActive = on
end

-- Noclip: Stepped (trước physics)
RunService.Stepped:Connect(function()
    if not noclipActive then return end
    local char = LP.Character
    if not char then return end

    for _, part in ipairs(char:GetDescendants()) do
        if part:IsA("BasePart") and part.CanCollide then
            part.CanCollide = false
        end
    end
end)

-- Ép đứng thẳng: RenderStepped (sau physics, trước render)
RunService.RenderStepped:Connect(function()
    if not AutoFarm and not BossFarmOn then return end
    if not noclipActive then return end

    local char = LP.Character
    if not char then return end

    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end

    local pos  = root.Position
    local look = root.CFrame.LookVector
    local flat = Vector3.new(look.X, 0, look.Z)

    if flat.Magnitude > 0.001 then
        root.CFrame = CFrame.lookAt(pos, pos + flat.Unit)
    end
end)

-- ============================================================
-- SETUP FLY OBJECTS
-- ============================================================
local function EnsureFlyObjects()
    local root = GetPlayerParts()
    if not root then return false end

    if flyAttach and flyAttach.Parent == root
       and flyAlignAtt and flyAlignAtt.Parent == root
       and flyBV and flyBV.Parent == root
       and flyAlign and flyAlign.Parent == root then
        return true
    end

    if flyAttach   and flyAttach.Parent   then flyAttach:Destroy()   end
    if flyAlignAtt and flyAlignAtt.Parent then flyAlignAtt:Destroy() end
    if flyBV       and flyBV.Parent       then flyBV:Destroy()       end
    if flyAlign    and flyAlign.Parent    then flyAlign:Destroy()    end

    -- Attachment cho LinearVelocity
    flyAttach = Instance.new("Attachment")
    flyAttach.Name = "AbyssalFlyAttach"
    flyAttach.Parent = root

    -- Attachment riêng cho AlignOrientation
    flyAlignAtt = Instance.new("Attachment")
    flyAlignAtt.Name = "AbyssalAlignAttach"
    flyAlignAtt.Parent = root

    -- LinearVelocity
    flyBV = Instance.new("LinearVelocity")
    flyBV.Name = "AbyssalFlyBV"
    flyBV.Attachment0 = flyAttach
    flyBV.MaxForce = 1e6
    flyBV.RelativeTo = Enum.ActuatorRelativeTo.World
    flyBV.VectorVelocity = Vector3.zero
    flyBV.Parent = root

    -- AlignOrientation — dùng attachment riêng, khóa cứng
    flyAlign = Instance.new("AlignOrientation")
    flyAlign.Name = "AbyssalFlyAlign"
    flyAlign.Attachment0 = flyAlignAtt
    flyAlign.Mode = Enum.OrientationAlignmentMode.OneAttachment
    flyAlign.MaxTorque = 1e9
    flyAlign.MaxAngularVelocity = 500        -- giới hạn, tránh physics solver văng
    flyAlign.Responsiveness = 200
    flyAlign.RigidityEnabled = true
    flyAlign.PrimaryAxis   = Vector3.new(0, 1, 0)
    flyAlign.SecondaryAxis = Vector3.new(0, 0, 1)
    flyAlign.Parent = root

    local hum = root.Parent and root.Parent:FindFirstChild("Humanoid")
if hum then
    pcall(function()
        hum.PlatformStand  = true
        hum.AutoRotate     = false     -- ★ TẮT tự xoay theo hướng bay
        hum.WalkSpeed      = 0
        hum.JumpPower      = 0
        hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
        hum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
        hum:SetStateEnabled(Enum.HumanoidStateType.Physics, false)
        hum:SetStateEnabled(Enum.HumanoidStateType.Climbing, false)
    end)
end

SetNoclip(true)

    return true
end

local function DisableFly()
    if flyBV then flyBV.VectorVelocity = Vector3.zero end
    farmMoving    = false
    farmTargetPos = nil
end

StopActiveTween = function()
    DisableFly()
end

local function FlyTo(targetPos)
    if targetPos.Y < MIN_Y then
        targetPos = Vector3.new(targetPos.X, MIN_Y, targetPos.Z)
    end
    farmTargetPos = targetPos
    farmMoving    = true
end

-- ============================================================
-- HEARTBEAT — cập nhật velocity mỗi frame
-- ============================================================
RunService.Heartbeat:Connect(function(dt)
    if (not AutoFarm and not BossFarmOn) or not farmMoving or not farmTargetPos then
        if flyBV then flyBV.VectorVelocity = Vector3.zero end
        return
    end

    local root = GetPlayerParts()
    if not root then
        DisableFly()
        return
    end

    if not EnsureFlyObjects() then return end

    flyAttach.Parent    = root
    flyAlignAtt.Parent  = root
    flyBV.Parent        = root
    flyAlign.Parent     = root

    local current = root.Position
    local dx = farmTargetPos.X - current.X
    local dz = farmTargetPos.Z - current.Z
    local yDiff = farmTargetPos.Y - current.Y

    local horizDir  = Vector3.new(dx, 0, dz)
    local horizDist = horizDir.Magnitude
    local dist3D    = (farmTargetPos - current).Magnitude

    -- tới nơi
    if dist3D < 3 and math.abs(yDiff) < 3 then
        flyBV.VectorVelocity = Vector3.zero
        farmMoving    = false
        farmTargetPos = nil
        return
    end

    -- === HORIZONTAL ===
    local hSpeed = TweenSpeed
    if horizDist < 60 then
        hSpeed = math.max(TweenSpeed * (horizDist / 60), 5)
    end

    local horizVel = Vector3.zero
    if horizDist > 1 then
        horizVel = horizDir.Unit * hSpeed
    end

    -- === VERTICAL (tách riêng, tỉ lệ + deadzone) ===
    local vVel = 0
    if math.abs(yDiff) > 2 then
        -- vận tốc tỉ lệ khoảng cách Y, cap ở 0.7 * TweenSpeed
        vVel = math.clamp(yDiff * 3, -TweenSpeed * 0.7, TweenSpeed * 0.7)
    end

    local targetVel = horizVel + Vector3.new(0, vVel, 0)

    -- lerp mượt — triệt tiêu giật
    local curVel = flyBV.VectorVelocity
    flyBV.VectorVelocity = curVel:Lerp(targetVel, math.min(dt * 12, 1))
end)

-- ============================================================
-- CLEANUP khi tắt farm
-- ============================================================
CleanupFly = function()
    local char = LP.Character
    if char then
        local root = char:FindFirstChild("HumanoidRootPart")
        if root then
            -- ★ zero velocity TRƯỚC khi destroy, không để char bay tiếp
            root.AssemblyLinearVelocity  = Vector3.zero
            root.AssemblyAngularVelocity = Vector3.zero
        end
    end

    if flyAttach   then flyAttach:Destroy()   flyAttach   = nil end
    if flyAlignAtt then flyAlignAtt:Destroy() flyAlignAtt = nil end
    if flyBV       then flyBV:Destroy()       flyBV       = nil end
    if flyAlign    then flyAlign:Destroy()    flyAlign    = nil end

    SetNoclip(false)

    if char then
        local hum = char:FindFirstChild("Humanoid")
        if hum then
            pcall(function()
                hum.PlatformStand = false
                hum.AutoRotate    = true
                hum.WalkSpeed     = 16
                hum.JumpPower     = 50
                hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
                hum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, true)
                hum:SetStateEnabled(Enum.HumanoidStateType.Physics, true)
                hum:SetStateEnabled(Enum.HumanoidStateType.Climbing, true)
                hum:ChangeState(Enum.HumanoidStateType.GettingUp)
            end)
        end
    end
end

-- ============================================================
-- EQUIP WEAPON
-- ============================================================
local function EquipFarmWeapon()
    if not FarmWeapon or FarmWeapon == "None" then return end

    local char = LP.Character
    if not char then return end

    -- Tìm weapon tương ứng với category (Melee/Sword/Gun)
    local weaponName = FindWeaponByCategory(FarmWeapon)
    if not weaponName then return end   -- không có weapon nào trong backpack

    -- Đã equip đúng weapon → thôi
    if char:FindFirstChild(weaponName) then return end

    -- Tìm tool trong Backpack
    local bp = LP:FindFirstChild("Backpack")
    if not bp then return end

    local tool = bp:FindFirstChild(weaponName)
    if not tool then return end

    -- BƯỚC 1: chuyển tool vào Character
    local hum = char:FindFirstChild("Humanoid")
    if hum then
        pcall(function() hum:EquipTool(tool) end)
    end

    -- BƯỚC 2: đợi tool chuyển xong
    task.wait(0.15)

    -- BƯỚC 3: fire EquipEvent
    local toolInChar = char:FindFirstChild(weaponName)
    if toolInChar then
        local eqEvent = toolInChar:FindFirstChild("EquipEvent")
        if eqEvent then
            pcall(function() eqEvent:FireServer(true) end)
        end
    end
end

-- ============================================================
-- QUEST SYSTEM
-- ============================================================
local function HasActiveQuest()
    local pg = LP:FindFirstChild("PlayerGui")
    if not pg then return false end
    local frame = pg:FindFirstChild("TrackedQuestFrame", true)
    return frame and frame.Visible
end

local function FindQuestByLevel(level)
    for _, q in ipairs(FirstSeaQuests) do
        if level >= q.MinLevel and level <= q.MaxLevel then return q end
    end
    return FirstSeaQuests[1]
end

local function AutoAcceptQuest()
    local level = 1
    pcall(function()
        if LP:FindFirstChild("Data") and LP.Data:FindFirstChild("Level") then
            level = LP.Data.Level.Value
        end
    end)

    local q = FindQuestByLevel(level)
    if not q then return nil end

    local key = q.QuestName .. "|" .. tostring(q.QuestId)
    local hasQuest = HasActiveQuest()

    if not hasQuest or CurrentQuestName ~= key then
        if tick() < QuestCooldown then return nil end

        pcall(function()
            CommF_:InvokeServer("StartQuest", q.QuestName, q.QuestId)
        end)

        CurrentQuestName = key
        CurrentMobName   = q.MobName
        QuestCFrame      = q.MobSpawn
        QuestCooldown    = tick() + 3
        return q
    end
    return q
end

-- ============================================================
-- MOBILE TAP (giả lập chạm vào màn hình)
-- ============================================================
local function SimulateTap(x, y)
    -- Ưu tiên executor function (Delta, Codex, ...)
    if mousemoveabs and mouse1click then
        pcall(function()
            mousemoveabs(x, y)
            task.wait(0.02)
            mouse1click()
        end)
        return
    end

    -- Fallback: VirtualInputManager
    local VIM = game:GetService("VirtualInputManager")
    pcall(function()
        VIM:SendMouseButtonEvent(x, y, 0, true, game, 1)
        task.wait(0.02)
        VIM:SendMouseButtonEvent(x, y, 0, false, game, 1)
    end)
end

-- ============================================================
-- ATTACK HELPER — dùng chung cho farm level và boss
-- ============================================================
-- ============================================================
-- ATTACK HELPER — burst spam, dùng chung farm level + boss
-- ============================================================
local function DoAttack(targets)
    if not targets or #targets == 0 then return end

    local firstTarget = targets[1]

    if firstTarget ~= ComboTarget then
        ComboTarget = firstTarget
        ComboPhase  = "melee"
        ComboStart  = tick()
    end

    if ComboPhase == "melee" and tick() - ComboStart > 1.5 then
        ComboPhase = "gun"
    end

    if FarmWeapon == "Gun" then
        if ComboPhase == "melee" then
            -- ★ MELEE BURST
            local char = LP.Character
            local hum  = char and char:FindFirstChild("Humanoid")
            if hum then pcall(function() hum:UnequipTools() end) end

            RegisterAttack:FireServer(0.1, 5)

            for _, m in ipairs(targets) do
                local parts = GetAttackParts(m)
                for _, p in ipairs(parts) do
                    RegisterHit:FireServer(p, {}, HitHash)
                    RegisterHit:FireServer(p, {})
                end
            end
        else
            -- ★ GUN PHASE — equip gun + tap
            EquipFarmWeapon()
            local camera = workspace.CurrentCamera
            if not camera then return end
            for _, m in ipairs(targets) do
                local head = m:FindFirstChild("Head")
                if head then
                    local sp, on = camera:WorldToScreenPoint(head.Position)
                    if on then SimulateTap(sp.X, sp.Y) end
                end
            end
        end
    else
        -- ★ MELEE / SWORD BURST
        EquipFarmWeapon()

        RegisterAttack:FireServer(0.1, 5)

        for _, m in ipairs(targets) do
            local parts = GetAttackParts(m)
            for _, p in ipairs(parts) do
                RegisterHit:FireServer(p, {}, HitHash)
                RegisterHit:FireServer(p, {})
            end
        end

        -- FastAtk: spam thêm 3 lượt ngay lập tức
        if FA_On then
            for _ = 1, 3 do
                for _, m in ipairs(targets) do
                    local parts = GetAttackParts(m)
                    for _, p in ipairs(parts) do
                        RegisterHit:FireServer(p, {}, HitHash)
                        RegisterHit:FireServer(p, {})
                    end
                end
            end
        end
    end
end

-- ============================================================
-- MAIN FARM LOOP
-- ============================================================
task.spawn(function()
    while true do
        task.wait(0.01)

        -- cleanup cache mob chết mỗi 100 loop
if not _cleanupTick or tick() - _cleanupTick > 5 then
    _cleanupTick = tick()
    for m, _ in pairs(PART_CACHE) do
        if not m.Parent then PART_CACHE[m] = nil end
    end
end

        if not AutoFarm then
            if not BossFarmOn then
                StopActiveTween()
                currentTarget = nil
                ComboPhase  = "melee"
                ComboTarget = nil
                local root = GetPlayerParts()
                if root and root.Anchored then root.Anchored = false end
            end
        else
            local ok, err = pcall(function()
                local root = GetPlayerParts()
                if not root then
                    task.wait(0.5)
                    return
                end

                pcall(AutoAcceptQuest)

                local target = FindNearestMob(CurrentMobName, 2000)

                -- Không có mob → bay tới spawn quest
                if not target then
                    if QuestCFrame then
                        local spawnPos = QuestCFrame.Position + Vector3.new(0, PLAYER_FLY_Y, 0)
                        local d = (root.Position - spawnPos).Magnitude
                        if d > 20 then
                            if not farmMoving then
                                FlyTo(spawnPos)
                            else
                                farmTargetPos = spawnPos
                            end
                        end
                    end
                    return
                end

                local mRoot = GetMobParts(target)
                if not mRoot then return end

                -- Khoảng cách NGANG (bỏ Y)
                local dx = root.Position.X - mRoot.Position.X
                local dz = root.Position.Z - mRoot.Position.Z
                local horizDist = math.sqrt(dx * dx + dz * dz)

                -- ===== DI CHUYỂN =====
                if horizDist > STOP_RANGE then
                    if not farmMoving then
                        FlyTo(mRoot.Position + Vector3.new(0, PLAYER_FLY_Y, 0))
                    else
                        local newTarget = mRoot.Position + Vector3.new(0, PLAYER_FLY_Y, 0)
                        if newTarget.Y < MIN_Y then
                            newTarget = Vector3.new(newTarget.X, MIN_Y, newTarget.Z)
                        end
                        farmTargetPos = newTarget
                    end
                else
                    farmMoving    = false
                    farmTargetPos = nil
                    if flyBV then flyBV.VectorVelocity = Vector3.zero end
                end

                -- ===== ĐÁNH =====
                if horizDist <= ATTACK_RANGE then
                    -- Gom tất cả mob cùng loại trong tầm
                    local targets = {target}
                    local enemies = workspace:FindFirstChild("Enemies")
                    if enemies then
                        for _, m in ipairs(enemies:GetChildren()) do
                            if m.Name == CurrentMobName and m ~= target then
                                local mr = GetMobParts(m)
                                if mr and (root.Position - mr.Position).Magnitude <= ATTACK_RANGE then
                                    table.insert(targets, m)
                                end
                            end
                        end
                    end

                    DoAttack(targets)
                end
            end)

            if not ok then
                warn("[AbyssalHub] Farm error: " .. tostring(err))
            end
        end
    end
end)

-- ============================================================
-- BRING MOB — B teleport tới vị trí A (mob gần player nhất)
-- ============================================================
RestoreMob = function(mob)
    PART_CACHE[mob] = nil
    local data = BroughtMobData[mob]
    BroughtMobData[mob] = nil
    if not mob or not mob.Parent then return end

    local mHum  = mob:FindFirstChild("Humanoid")
    local mRoot = mob:FindFirstChild("HumanoidRootPart")

    -- ★ TRẢ NETWORK về server trước khi teleport về
    if mRoot and data and data.HadOwnership then
        pcall(function()
            mRoot:SetNetworkOwnershipAuto()
        end)
    end

    if mHum and data then
    pcall(function()
        mHum.WalkSpeed     = data.WalkSpeed or 16
        mHum.JumpPower     = data.JumpPower or 50
        mHum.PlatformStand = false
        mHum:ChangeState(Enum.HumanoidStateType.Running)
    end)
end
-- không teleport, mob tự đi về (với WalkSpeed gốc)
    if mRoot then
        for _, child in ipairs(mRoot:GetChildren()) do
            if child.Name == "StunObjects" or child.Name == "StunObject" then
                pcall(function() child:Destroy() end)
            end
        end
        if data and data.OrigCFrame then
            pcall(function()
                mRoot.CFrame = data.OrigCFrame
                mRoot.AssemblyLinearVelocity  = Vector3.zero
                mRoot.AssemblyAngularVelocity = Vector3.zero
            end)
        end
    end

    for _, flagName in ipairs({"Busy", "Stun", "Stunned", "Grabbed", "Attacking", "Blocking"}) do
        local flag = mob:FindFirstChild(flagName)
        if flag and flag:IsA("BoolValue") then flag.Value = false end
    end
end

ForceRestoreAllMobs = function()
    for mob in pairs(BroughtMobData) do
        if mob and mob.Parent then
            RestoreMob(mob)
        end
    end
    BroughtMobData = {}
    for m in pairs(PART_CACHE) do
        PART_CACHE[m] = nil
    end
end

RunService.Heartbeat:Connect(function(dt)
    if not AutoFarm or not BM_On then return end

    local root = GetPlayerParts()
    if not root then return end

    local enemies = workspace:FindFirstChild("Enemies")
    if not enemies then return end

    local list = {}
    for _, mob in ipairs(enemies:GetChildren()) do
        if mob.Name == CurrentMobName then
            local mRoot = mob:FindFirstChild("HumanoidRootPart")
            local mHum  = mob:FindFirstChild("Humanoid")
            if mRoot and mHum and mHum.Health > 0 then
                local d = (root.Position - mRoot.Position).Magnitude
                if d <= DETECT_RANGE then
                    table.insert(list, {Mob = mob, Root = mRoot, Hum = mHum, Dist = d})
                end
            end
        end
    end
    table.sort(list, function(a, b) return a.Dist < b.Dist end)

    if #list < 2 then return end

    local max  = BM_Max or 5
    local kept = {}

    local anchorMob = list[1]
    local anchorPos = anchorMob.Root.Position
    kept[anchorMob.Mob] = true

    if (root.Position - anchorPos).Magnitude > 20 then return end

    for i = 2, math.min(#list, max) do
        local entry = list[i]
        local mob, mRoot, mHum = entry.Mob, entry.Root, entry.Hum
        kept[mob] = true

        if not BroughtMobData[mob] then
            BroughtMobData[mob] = {
                WalkSpeed  = mHum.WalkSpeed,
                JumpPower  = mHum.JumpPower,
                OrigCFrame = mRoot.CFrame,
            }
        end

        -- ★ WALKSPEED cao + MoveTo — AI hợp lệ
        pcall(function()
            mHum.WalkSpeed = 500
            mHum:MoveTo(anchorPos)
        end)

        -- xóa StunObjects liên tục
        for _, child in ipairs(mRoot:GetChildren()) do
            if child.Name == "StunObjects" or child.Name == "StunObject" then
                pcall(function() child:Destroy() end)
            end
        end

        -- clear flag
        for _, flagName in ipairs({"Busy", "Stun", "Stunned", "Grabbed"}) do
            local flag = mob:FindFirstChild(flagName)
            if flag and flag:IsA("BoolValue") then flag.Value = false end
        end
    end

    local toRestore = {}
    for mob in pairs(BroughtMobData) do
        if not kept[mob] then table.insert(toRestore, mob) end
    end
    for _, mob in ipairs(toRestore) do
        RestoreMob(mob)
    end
end)

-- ============================================================
-- ANTI-LOCK — quét mob bị flag lock, tự động giải phóng
-- ============================================================
task.spawn(function()
    while true do
        task.wait(0.3)
        if not (BM_On and AutoFarm) then continue end

        local enemies = workspace:FindFirstChild("Enemies")
        if not enemies then continue end

        for _, mob in ipairs(enemies:GetChildren()) do
            if mob.Name == CurrentMobName then
                local hrp = mob:FindFirstChild("HumanoidRootPart")
                local hum = mob:FindFirstChild("Humanoid")
                if hrp and hum and hum.Health > 0 then
                    -- xóa StunObjects
                    for _, child in ipairs(hrp:GetChildren()) do
                        if child.Name == "StunObjects" or child.Name == "StunObject" then
                            pcall(function() child:Destroy() end)
                        end
                    end

                    -- reset nếu state bị kẹt
                    local state = hum:GetState()
                    if state == Enum.HumanoidStateType.Physics 
                       or state == Enum.HumanoidStateType.Ragdoll
                       or state == Enum.HumanoidStateType.FallingDown 
                       or state == Enum.HumanoidStateType.Dead then
                        pcall(function()
                            hum.PlatformStand = false
                            hum:ChangeState(Enum.HumanoidStateType.Running)
                        end)
                    end

                    -- xóa hẳn flag
                    for _, flagName in ipairs({"Busy", "Stun", "Stunned", "Grabbed"}) do
                        local flag = mob:FindFirstChild(flagName)
                        if flag then
                            if flag:IsA("BoolValue") then
                                pcall(function() flag.Value = false end)
                            else
                                pcall(function() flag:Destroy() end)
                            end
                        end
                    end
                end
            end
        end
    end
end)

-- ============================================================
-- BOSS FARM LOOP
-- ============================================================
local function _norm(s)
    return (s or ""):lower():gsub("[%s_%-]", "")
end

local function _FindBossInWorkspace(name, spawnPos)
    local target = _norm(name)
    local containers = {
        workspace:FindFirstChild("Enemies"),
        workspace:FindFirstChild("Bosses"),
        workspace:FindFirstChild("Characters"),
        workspace:FindFirstChild("NPCs"),
        workspace:FindFirstChild("Mobs"),
    }

    -- PASS 1: match normalized
    for _, cont in ipairs(containers) do
        if cont then
            for _, obj in ipairs(cont:GetChildren()) do
                if obj:IsA("Model") and _norm(obj.Name) == target then
                    local hum = obj:FindFirstChild("Humanoid")
                    if hum and hum.Health > 0 then
                        return obj, hum
                    end
                end
            end
        end
    end

    -- PASS 2: quét bán kính spawn
    if spawnPos then
        local best, bestD = nil, 50
        for _, cont in ipairs(containers) do
            if cont then
                for _, obj in ipairs(cont:GetChildren()) do
                    if obj:IsA("Model") then
                        local hrp = obj:FindFirstChild("HumanoidRootPart")
                        local hum = obj:FindFirstChild("Humanoid")
                        if hrp and hum and hum.Health > 0 then
                            local d = (hrp.Position - spawnPos).Magnitude
                            if d < bestD then
                                bestD = d
                                best = obj
                            end
                        end
                    end
                end
            end
        end
        if best then return best, best:FindFirstChild("Humanoid") end
    end

    -- PASS 3: quét toàn workspace
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and _norm(obj.Name) == target then
            local hum = obj:FindFirstChild("Humanoid")
            if hum and hum.Health > 0 then
                return obj, hum
            end
        end
    end

    return nil
end

task.spawn(function()
    while true do
        task.wait(0.01)

        if not BossFarmOn or SelectedBoss == "None" or not BossDB[SelectedBoss] then
            task.wait(0.5)
        else
            local ok, err = pcall(function()
                local root = GetPlayerParts()
                if not root then return end

                local bossData = BossDB[SelectedBoss]
                local boss, bossHum = _FindBossInWorkspace(SelectedBoss, bossData.Spawn.Position)

                -- boss chưa spawn → bay tới spawn đợi
                if not boss then
                    BossTarget = nil
                    local spawnPos = bossData.Spawn.Position + Vector3.new(0, PLAYER_FLY_Y, 0)
                    local d = (root.Position - spawnPos).Magnitude
                    if d > 25 then
                        if not farmMoving then FlyTo(spawnPos) else farmTargetPos = spawnPos end
                    else
                        farmMoving    = false
                        farmTargetPos = nil
                        if flyBV then flyBV.VectorVelocity = Vector3.zero end
                    end
                    return
                end

                -- boss đang sống
                BossTarget = boss
                local bossRoot = boss:FindFirstChild("HumanoidRootPart")
                if not bossRoot then return end

                local dx = root.Position.X - bossRoot.Position.X
                local dz = root.Position.Z - bossRoot.Position.Z
                local horizDist = math.sqrt(dx * dx + dz * dz)

                -- di chuyển
                if horizDist > STOP_RANGE then
                    local goal = bossRoot.Position + Vector3.new(0, PLAYER_FLY_Y, 0)
                    if not farmMoving then FlyTo(goal) else farmTargetPos = goal end
                else
                    farmMoving    = false
                    farmTargetPos = nil
                    if flyBV then flyBV.VectorVelocity = Vector3.zero end
                end

                -- ĐÁNH — dùng chung DoAttack với farm level
                if horizDist <= ATTACK_RANGE then
                    DoAttack({boss})
                end
            end)

            if not ok then
                warn("[AbyssalHub] Boss farm error: " .. tostring(err))
            end
        end
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