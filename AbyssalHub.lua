local Library = {}
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

function Library:CreateWindow(hubName)
    -- 1. ScreenGui Chứa Menu Chính
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "AbyssalHubUI"
    ScreenGui.Parent = CoreGui
    ScreenGui.ResetOnSpawn = false

    -- Khung chính UI
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.Position = UDim2.new(0.3, 0, 0.25, 0)
    MainFrame.Size = UDim2.new(0, 500, 0, 320)
    MainFrame.BackgroundColor3 = Color3.fromRGB(13, 17, 23)
    MainFrame.BorderSizePixel = 0
    MainFrame.ClipsDescendants = true

    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 8)
    MainCorner.Parent = MainFrame

    local MainStroke = Instance.new("UIStroke")
    MainStroke.Color = Color3.fromRGB(30, 41, 59)
    MainStroke.Thickness = 1
    MainStroke.Parent = MainFrame

    -- Kéo thả UI
    local dragging, dragInput, dragStart, startPos
    MainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
        end
    end)
    MainFrame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    -- Topbar
    local Topbar = Instance.new("Frame")
    Topbar.Name = "Topbar"
    Topbar.Parent = MainFrame
    Topbar.Size = UDim2.new(1, 0, 0, 38)
    Topbar.BackgroundColor3 = Color3.fromRGB(21, 27, 36)
    Topbar.BorderSizePixel = 0

    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Parent = Topbar
    Title.Position = UDim2.new(0, 15, 0, 0)
    Title.Size = UDim2.new(1, -30, 1, 0)
    Title.Text = hubName or "ABYSSAL HUB"
    Title.TextColor3 = Color3.fromRGB(0, 210, 255)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 14
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.BackgroundTransparency = 1
    Title.Active = false

    -- Side Tab Container
    local TabContainer = Instance.new("ScrollingFrame")
    TabContainer.Name = "TabContainer"
    TabContainer.Parent = MainFrame
    TabContainer.Position = UDim2.new(0, 0, 0, 38)
    TabContainer.Size = UDim2.new(0, 125, 1, -38)
    TabContainer.BackgroundColor3 = Color3.fromRGB(17, 22, 30)
    TabContainer.BorderSizePixel = 0
    TabContainer.ScrollBarThickness = 0

    local TabList = Instance.new("UIListLayout")
    TabList.Parent = TabContainer
    TabList.SortOrder = Enum.SortOrder.LayoutOrder
    TabList.Padding = UDim.new(0, 4)

    local ContentContainer = Instance.new("Frame")
    ContentContainer.Name = "ContentContainer"
    ContentContainer.Parent = MainFrame
    ContentContainer.Position = UDim2.new(0, 130, 0, 42)
    ContentContainer.Size = UDim2.new(1, -135, 1, -46)
    ContentContainer.BackgroundTransparency = 1

    -- 2. ScreenGui Chứa Nút Toggle (Tách riêng để không bị ẩn theo menu)
    local ToggleGui = Instance.new("ScreenGui")
    ToggleGui.Name = "AbyssalHub_ToggleGui"
    ToggleGui.Parent = CoreGui
    ToggleGui.ResetOnSpawn = false

    local ToggleButton = Instance.new("ImageButton")
    ToggleButton.Name = "ToggleButton"
    ToggleButton.Parent = ToggleGui
    ToggleButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    ToggleButton.Position = UDim2.new(0.05, 0, 0.15, 0)
    ToggleButton.Size = UDim2.new(0, 50, 0, 50)
    ToggleButton.Image = "rbxassetid://122987919647953"
    ToggleButton.Active = true
    ToggleButton.Draggable = true

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 12)
    UICorner.Parent = ToggleButton

    local UIStroke = Instance.new("UIStroke")
    UIStroke.Color = Color3.fromRGB(0, 170, 255)
    UIStroke.Thickness = 2
    UIStroke.Parent = ToggleButton

    -- Logic Bật/Tắt Toàn Bộ ScreenGui (Khắc phục hoàn toàn lỗi rác UI)
    ToggleButton.MouseButton1Click:Connect(function()
        ScreenGui.Enabled = not ScreenGui.Enabled
    end)

    local Window = {}
    local firstTab = true

    function Window:CreateTab(tabName)
        local TabButton = Instance.new("TextButton")
        TabButton.Name = tabName .. "Tab"
        TabButton.Parent = TabContainer
        TabButton.Size = UDim2.new(1, -8, 0, 32)
        TabButton.Position = UDim2.new(0, 4, 0, 0)
        TabButton.BackgroundColor3 = Color3.fromRGB(21, 27, 36)
        TabButton.Text = tabName
        TabButton.TextColor3 = Color3.fromRGB(140, 155, 175)
        TabButton.Font = Enum.Font.GothamMedium
        TabButton.TextSize = 12

        local TabBtnCorner = Instance.new("UICorner")
        TabBtnCorner.CornerRadius = UDim.new(0, 6)
        TabBtnCorner.Parent = TabButton

        local TabPage = Instance.new("ScrollingFrame")
        TabPage.Name = tabName .. "Page"
        TabPage.Parent = ContentContainer
        TabPage.Size = UDim2.new(1, 0, 1, 0)
        TabPage.BackgroundTransparency = 1
        TabPage.Visible = false
        TabPage.ScrollBarThickness = 2
        TabPage.ScrollBarImageColor3 = Color3.fromRGB(0, 210, 255)

        local PageList = Instance.new("UIListLayout")
        PageList.Parent = TabPage
        PageList.SortOrder = Enum.SortOrder.LayoutOrder
        PageList.Padding = UDim.new(0, 6)

        PageList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            TabPage.CanvasSize = UDim2.new(0, 0, 0, PageList.AbsoluteContentSize.Y + 10)
        end)

        if firstTab then
            firstTab = false
            TabPage.Visible = true
            TabButton.BackgroundColor3 = Color3.fromRGB(0, 210, 255)
            TabButton.TextColor3 = Color3.fromRGB(13, 17, 23)
        end

        TabButton.MouseButton1Click:Connect(function()
            for _, page in pairs(ContentContainer:GetChildren()) do
                if page:IsA("ScrollingFrame") then page.Visible = false end
            end
            for _, btn in pairs(TabContainer:GetChildren()) do
                if btn:IsA("TextButton") then
                    btn.BackgroundColor3 = Color3.fromRGB(21, 27, 36)
                    btn.TextColor3 = Color3.fromRGB(140, 155, 175)
                end
            end
            TabPage.Visible = true
            TabButton.BackgroundColor3 = Color3.fromRGB(0, 210, 255)
            TabButton.TextColor3 = Color3.fromRGB(13, 17, 23)
        end)

        local TabElements = {}

        -- BUTTON
        function TabElements:CreateButton(btnName, callback)
            local Button = Instance.new("TextButton")
            Button.Parent = TabPage
            Button.Size = UDim2.new(1, -6, 0, 36)
            Button.BackgroundColor3 = Color3.fromRGB(21, 27, 36)
            Button.Text = btnName
            Button.TextColor3 = Color3.fromRGB(240, 240, 240)
            Button.Font = Enum.Font.GothamMedium
            Button.TextSize = 12

            local Corner = Instance.new("UICorner")
            Corner.CornerRadius = UDim.new(0, 6)
            Corner.Parent = Button

            local Stroke = Instance.new("UIStroke")
            Stroke.Color = Color3.fromRGB(35, 45, 60)
            Stroke.Thickness = 1
            Stroke.Parent = Button

            Button.MouseButton1Click:Connect(function()
                TweenService:Create(Button, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(0, 210, 255), TextColor3 = Color3.fromRGB(13, 17, 23)}):Play()
                task.wait(0.12)
                TweenService:Create(Button, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(21, 27, 36), TextColor3 = Color3.fromRGB(240, 240, 240)}):Play()
                pcall(callback)
            end)
        end

        -- TOGGLE
        function TabElements:CreateToggle(toggleName, default, callback)
            local toggled = default or false

            local ToggleBtn = Instance.new("TextButton")
            ToggleBtn.Parent = TabPage
            ToggleBtn.Size = UDim2.new(1, -6, 0, 36)
            ToggleBtn.BackgroundColor3 = Color3.fromRGB(21, 27, 36)
            ToggleBtn.Text = ""

            local Corner = Instance.new("UICorner")
            Corner.CornerRadius = UDim.new(0, 6)
            Corner.Parent = ToggleBtn

            local Label = Instance.new("TextLabel")
            Label.Parent = ToggleBtn
            Label.Position = UDim2.new(0, 10, 0, 0)
            Label.Size = UDim2.new(0.7, 0, 1, 0)
            Label.Text = toggleName
            Label.TextColor3 = Color3.fromRGB(240, 240, 240)
            Label.Font = Enum.Font.GothamMedium
            Label.TextSize = 12
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.BackgroundTransparency = 1
            Label.Active = false

            local Switch = Instance.new("Frame")
            Switch.Parent = ToggleBtn
            Switch.Position = UDim2.new(1, -38, 0.5, -9)
            Switch.Size = UDim2.new(0, 28, 0, 18)
            Switch.BackgroundColor3 = toggled and Color3.fromRGB(0, 210, 255) or Color3.fromRGB(13, 17, 23)

            local SwitchCorner = Instance.new("UICorner")
            SwitchCorner.CornerRadius = UDim.new(0, 4)
            SwitchCorner.Parent = Switch

            ToggleBtn.MouseButton1Click:Connect(function()
                toggled = not toggled
                TweenService:Create(Switch, TweenInfo.new(0.15), {
                    BackgroundColor3 = toggled and Color3.fromRGB(0, 210, 255) or Color3.fromRGB(13, 17, 23)
                }):Play()
                pcall(callback, toggled)
            end)
        end

        -- SLIDER
        function TabElements:CreateSlider(sliderName, min, max, default, callback)
            local value = default or min

            local SliderFrame = Instance.new("Frame")
            SliderFrame.Parent = TabPage
            SliderFrame.Size = UDim2.new(1, -6, 0, 42)
            SliderFrame.BackgroundColor3 = Color3.fromRGB(21, 27, 36)

            local Corner = Instance.new("UICorner")
            Corner.CornerRadius = UDim.new(0, 6)
            Corner.Parent = SliderFrame

            local Label = Instance.new("TextLabel")
            Label.Parent = SliderFrame
            Label.Position = UDim2.new(0, 10, 0, 4)
            Label.Size = UDim2.new(0.6, 0, 0, 16)
            Label.Text = sliderName
            Label.TextColor3 = Color3.fromRGB(240, 240, 240)
            Label.Font = Enum.Font.GothamMedium
            Label.TextSize = 12
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.BackgroundTransparency = 1

            local ValueLabel = Instance.new("TextLabel")
            ValueLabel.Parent = SliderFrame
            ValueLabel.Position = UDim2.new(1, -50, 0, 4)
            ValueLabel.Size = UDim2.new(0, 40, 0, 16)
            ValueLabel.Text = tostring(value)
            ValueLabel.TextColor3 = Color3.fromRGB(0, 210, 255)
            ValueLabel.Font = Enum.Font.GothamBold
            ValueLabel.TextSize = 12
            ValueLabel.BackgroundTransparency = 1

            local SlideBack = Instance.new("TextButton")
            SlideBack.Parent = SliderFrame
            SlideBack.Position = UDim2.new(0, 10, 0, 26)
            SlideBack.Size = UDim2.new(1, -20, 0, 6)
            SlideBack.BackgroundColor3 = Color3.fromRGB(13, 17, 23)
            SlideBack.Text = ""

            local BackCorner = Instance.new("UICorner")
            BackCorner.CornerRadius = UDim.new(0, 3)
            BackCorner.Parent = SlideBack

            local SlideBar = Instance.new("Frame")
            SlideBar.Parent = SlideBack
            SlideBar.Size = UDim2.new((value - min) / (max - min), 0, 1, 0)
            SlideBar.BackgroundColor3 = Color3.fromRGB(0, 210, 255)
            SlideBar.BorderSizePixel = 0

            local BarCorner = Instance.new("UICorner")
            BarCorner.CornerRadius = UDim.new(0, 3)
            BarCorner.Parent = SlideBar

            local isSliding = false
            local function update(input)
                local pos = math.clamp((input.Position.X - SlideBack.AbsolutePosition.X) / SlideBack.AbsoluteSize.X, 0, 1)
                value = math.floor(min + (max - min) * pos)
                ValueLabel.Text = tostring(value)
                SlideBar.Size = UDim2.new(pos, 0, 1, 0)
                pcall(callback, value)
            end

            SlideBack.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    isSliding = true
                    update(input)
                end
            end)
            UserInputService.InputChanged:Connect(function(input)
                if isSliding and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                    update(input)
                end
            end)
            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    isSliding = false
                end
            end)
        end

        -- BOX
        function TabElements:CreateBox(boxName, placeholder, callback)
            local BoxFrame = Instance.new("Frame")
            BoxFrame.Parent = TabPage
            BoxFrame.Size = UDim2.new(1, -6, 0, 36)
            BoxFrame.BackgroundColor3 = Color3.fromRGB(21, 27, 36)

            local Corner = Instance.new("UICorner")
            Corner.CornerRadius = UDim.new(0, 6)
            Corner.Parent = BoxFrame

            local Label = Instance.new("TextLabel")
            Label.Parent = BoxFrame
            Label.Position = UDim2.new(0, 10, 0, 0)
            Label.Size = UDim2.new(0.5, 0, 1, 0)
            Label.Text = boxName
            Label.TextColor3 = Color3.fromRGB(240, 240, 240)
            Label.Font = Enum.Font.GothamMedium
            Label.TextSize = 12
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.BackgroundTransparency = 1

            local TextBox = Instance.new("TextBox")
            TextBox.Parent = BoxFrame
            TextBox.Position = UDim2.new(1, -125, 0.5, -11)
            TextBox.Size = UDim2.new(0, 115, 0, 22)
            TextBox.BackgroundColor3 = Color3.fromRGB(13, 17, 23)
            TextBox.PlaceholderText = placeholder or "Nhập..."
            TextBox.Text = ""
            TextBox.TextColor3 = Color3.fromRGB(0, 210, 255)
            TextBox.Font = Enum.Font.Gotham
            TextBox.TextSize = 11

            local BoxCorner = Instance.new("UICorner")
            BoxCorner.CornerRadius = UDim.new(0, 4)
            BoxCorner.Parent = TextBox

            TextBox.FocusLost:Connect(function()
                pcall(callback, TextBox.Text)
            end)
        end

        -- DROPDOWN (Đã fix gộp vào TabElements chuẩn)
        function TabElements:CreateDropdown(text, options, defaultOption, callback)
            local dropdownFrame = Instance.new("Frame")
            local dropdownTitle = Instance.new("TextLabel")
            local dropdownBtn = Instance.new("TextButton")
            local optionsHolder = Instance.new("ScrollingFrame")
            local UIListLayout = Instance.new("UIListLayout")

            local selected = defaultOption or options[1]
            local isOpened = false

            dropdownFrame.Name = text .. "_Dropdown"
            dropdownFrame.Size = UDim2.new(1, -6, 0, 36)
            dropdownFrame.BackgroundColor3 = Color3.fromRGB(21, 27, 36)
            dropdownFrame.BorderSizePixel = 0
            dropdownFrame.Parent = TabPage

            local Corner = Instance.new("UICorner")
            Corner.CornerRadius = UDim.new(0, 6)
            Corner.Parent = dropdownFrame

            dropdownTitle.Size = UDim2.new(0.5, 0, 1, 0)
            dropdownTitle.Position = UDim2.new(0, 10, 0, 0)
            dropdownTitle.BackgroundTransparency = 1
            dropdownTitle.Text = text
            dropdownTitle.TextColor3 = Color3.fromRGB(240, 240, 240)
            dropdownTitle.TextXAlignment = Enum.TextXAlignment.Left
            dropdownTitle.Font = Enum.Font.GothamMedium
            dropdownTitle.TextSize = 12
            dropdownTitle.Parent = dropdownFrame

            dropdownBtn.Size = UDim2.new(0.4, 0, 0, 24)
            dropdownBtn.Position = UDim2.new(0.58, 0, 0.5, -12)
            dropdownBtn.BackgroundColor3 = Color3.fromRGB(13, 17, 23)
            dropdownBtn.Text = tostring(selected) .. " ▼"
            dropdownBtn.TextColor3 = Color3.fromRGB(0, 210, 255)
            dropdownBtn.Font = Enum.Font.Gotham
            dropdownBtn.TextSize = 11
            dropdownBtn.Parent = dropdownFrame

            local BtnCorner = Instance.new("UICorner")
            BtnCorner.CornerRadius = UDim.new(0, 4)
            BtnCorner.Parent = dropdownBtn

            optionsHolder.Size = UDim2.new(1, 0, 0, 0)
            optionsHolder.Position = UDim2.new(0, 0, 1, 5)
            optionsHolder.BackgroundColor3 = Color3.fromRGB(17, 22, 30)
            optionsHolder.Visible = false
            optionsHolder.CanvasSize = UDim2.new(0, 0, 0, #options * 25)
            optionsHolder.ScrollBarThickness = 2
            optionsHolder.ZIndex = 10
            optionsHolder.Parent = dropdownFrame

            UIListLayout.Parent = optionsHolder
            UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

            local function toggleDropdown()
                isOpened = not isOpened
                optionsHolder.Visible = isOpened
                if isOpened then
                    dropdownBtn.Text = tostring(selected) .. " ▲"
                    optionsHolder.Size = UDim2.new(1, 0, 0, math.min(#options * 25, 100))
                    dropdownFrame.Size = UDim2.new(1, -6, 0, 36 + optionsHolder.Size.Y.Offset + 5)
                else
                    dropdownBtn.Text = tostring(selected) .. " ▼"
                    optionsHolder.Size = UDim2.new(1, 0, 0, 0)
                    dropdownFrame.Size = UDim2.new(1, -6, 0, 36)
                end
            end

            dropdownBtn.MouseButton1Click:Connect(toggleDropdown)

            for _, opt in ipairs(options) do
                local optBtn = Instance.new("TextButton")
                optBtn.Size = UDim2.new(1, 0, 0, 25)
                optBtn.BackgroundColor3 = Color3.fromRGB(21, 27, 36)
                optBtn.BackgroundTransparency = 0.2
                optBtn.Text = tostring(opt)
                optBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
                optBtn.Font = Enum.Font.Gotham
                optBtn.TextSize = 11
                optBtn.ZIndex = 11
                optBtn.Parent = optionsHolder

                optBtn.MouseButton1Click:Connect(function()
                    selected = opt
                    toggleDropdown()
                    if callback then pcall(callback, selected) end
                end)
            end

            if callback then pcall(callback, selected) end
        end

        return TabElements
    end

    return Window
end

-- ====================================================================
-- SYSTEM VARS & LOGIC FARM
-- ====================================================================
if not game:IsLoaded() then game.Loaded:Wait() end

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer

-- ==========================================
-- 1. BIẾN TRẠNG THÁI & DATABASE CHUẨN (SEA 1)
-- ==========================================
local AutoFarmLevelEnabled = false
local FastAttackEnabled = true
local BringMobEnabled = false -- Đặt mặc định là false hoặc true tùy cậu chỉnh
local SelectedWeapon = "Melee"

-- Độ cao đứng farm so với mặt đất/bãi quái
local FarmHeight = 70

local NpcPositions = {
    ["Pirate Starter"]  = CFrame.new(1059.37, 16.45, 1549.2),
    ["Jungle"]          = CFrame.new(-1598.08, 36.85, 153.38),
    ["Pirate Village"]  = CFrame.new(-1140.17, 4.75, 3827.42),
    ["Desert"]          = CFrame.new(894.48, 6.44, 4392.43),
    ["Frozen Village"]  = CFrame.new(1385.74, 87.27, -1298.07),
    ["Marine Fortress"] = CFrame.new(-5039.59, 27.35, 4324.58),
    ["Skylands"]        = CFrame.new(-4839.53, 717.5, -2619.44),
    ["Prison"]          = CFrame.new(485.63, 1.65, 736.61),
    ["Colosseum"]       = CFrame.new(-1422.01, 7.38, -3015.68),
    ["Magma Village"]   = CFrame.new(-5232.9, 8.58, 8533.8),
    ["Underwater City"] = CFrame.new(61163.85, 11.68, 1569.25),
    ["Upper Skylands"]  = CFrame.new(-7859.1, 5545.49, -380.3),
    ["Fountain City"]   = CFrame.new(5259.82, 38.5, 4050.0)
}

local EnemyPositions = {
    ["Bandit"]                = CFrame.new(1038.5, 16.5, 1542.8),
    ["Monkey"]                = CFrame.new(-1610.6, 36.8, 142.3),
    ["Gorilla"]               = CFrame.new(-1237.7, 36.8, -486.3),
    ["Pirate"]                = CFrame.new(-1205.1, 4.7, 3858.8),
    ["Brute"]                 = CFrame.new(-1148.5, 4.7, 4253.6),
    ["Desert Bandit"]         = CFrame.new(932.4, 6.4, 4438.3),
    ["Desert Officer"]        = CFrame.new(1571.3, 6.4, 4381.1),
    ["Snow Bandit"]           = CFrame.new(1288.2, 87.2, -1352.4),
    ["Snowman"]               = CFrame.new(1228.6, 87.2, -1522.6),
    ["Chief Petty Officer"]   = CFrame.new(-4881.9, 27.3, 4242.3),
    ["Sky Bandit"]            = CFrame.new(-4972.3, 717.5, -2871.2),
    ["Dark Master"]           = CFrame.new(-5223.1, 717.5, -2285.8),
    ["Prisoner"]              = CFrame.new(542.1, 1.6, 482.9),
    ["Dangerous Prisoner"]    = CFrame.new(480.2, 1.6, 1140.3),
    ["Toga Warrior"]          = CFrame.new(-1805.1, 7.3, -2742.6),
    ["Gladiator"]             = CFrame.new(-1323.8, 7.3, -3316.3),
    ["Military Soldier"]      = CFrame.new(-5411.3, 8.5, 8512.4),
    ["Military Spy"]          = CFrame.new(-5815.2, 83.5, 8821.5),
    ["Fishman Warrior"]       = CFrame.new(60842.1, 18.5, 1531.2),
    ["Fishman Commando"]      = CFrame.new(61812.5, 18.5, 1475.8),
    ["God's Guard"]           = CFrame.new(-7725.4, 5545.5, -425.1),
    ["Shanda"]                = CFrame.new(-7672.1, 5545.5, -1021.3),
    ["Royal Squad"]           = CFrame.new(-7528.3, 5585.5, -1451.2),
    ["Royal Soldier"]         = CFrame.new(-7812.6, 5585.5, -1820.5),
    ["Galley Pirate"]         = CFrame.new(5582.3, 38.5, 3982.1),
    ["Galley Captain"]        = CFrame.new(5641.8, 38.5, 4920.4)
}

local QuestDatabase = {
    { MinLevel = 1,   MaxLevel = 9,   QuestName = "BanditQuest1",   QuestNumber = 1, EnemyName = "Bandit",               Island = "Pirate Starter" },
    { MinLevel = 10,  MaxLevel = 14,  QuestName = "JungleQuest",    QuestNumber = 1, EnemyName = "Monkey",               Island = "Jungle" },
    { MinLevel = 15,  MaxLevel = 29,  QuestName = "JungleQuest",    QuestNumber = 2, EnemyName = "Gorilla",              Island = "Jungle" },
    { MinLevel = 30,  MaxLevel = 39,  QuestName = "BuggyQuest1",    QuestNumber = 1, EnemyName = "Pirate",               Island = "Pirate Village" },
    { MinLevel = 40,  MaxLevel = 59,  QuestName = "BuggyQuest1",    QuestNumber = 2, EnemyName = "Brute",                Island = "Pirate Village" },
    { MinLevel = 60,  MaxLevel = 74,  QuestName = "DesertQuest",    QuestNumber = 1, EnemyName = "Desert Bandit",        Island = "Desert" },
    { MinLevel = 75,  MaxLevel = 89,  QuestName = "DesertQuest",    QuestNumber = 2, EnemyName = "Desert Officer",       Island = "Desert" },
    { MinLevel = 90,  MaxLevel = 99,  QuestName = "SnowQuest",      QuestNumber = 1, EnemyName = "Snow Bandit",          Island = "Frozen Village" },
    { MinLevel = 100, MaxLevel = 119, QuestName = "SnowQuest",      QuestNumber = 2, EnemyName = "Snowman",              Island = "Frozen Village" },
    { MinLevel = 120, MaxLevel = 149, QuestName = "MarineQuest2",   QuestNumber = 1, EnemyName = "Chief Petty Officer",  Island = "Marine Fortress" },
    { MinLevel = 150, MaxLevel = 174, QuestName = "SkyQuest",       QuestNumber = 1, EnemyName = "Sky Bandit",           Island = "Skylands" },
    { MinLevel = 175, MaxLevel = 189, QuestName = "SkyQuest",       QuestNumber = 2, EnemyName = "Dark Master",          Island = "Skylands" },
    { MinLevel = 190, MaxLevel = 209, QuestName = "PrisonerQuest",  QuestNumber = 1, EnemyName = "Prisoner",             Island = "Prison" },
    { MinLevel = 210, MaxLevel = 249, QuestName = "PrisonerQuest",  QuestNumber = 2, EnemyName = "Dangerous Prisoner",   Island = "Prison" },
    { MinLevel = 250, MaxLevel = 274, QuestName = "ColosseumQuest", QuestNumber = 1, EnemyName = "Toga Warrior",         Island = "Colosseum" },
    { MinLevel = 275, MaxLevel = 299, QuestName = "ColosseumQuest", QuestNumber = 2, EnemyName = "Gladiator",            Island = "Colosseum" },
    { MinLevel = 300, MaxLevel = 324, QuestName = "MagmaQuest",     QuestNumber = 1, EnemyName = "Military Soldier",     Island = "Magma Village" },
    { MinLevel = 325, MaxLevel = 374, QuestName = "MagmaQuest",     QuestNumber = 2, EnemyName = "Military Spy",         Island = "Magma Village" },
    { MinLevel = 375, MaxLevel = 399, QuestName = "FishmanQuest",   QuestNumber = 1, EnemyName = "Fishman Warrior",      Island = "Underwater City" },
    { MinLevel = 400, MaxLevel = 449, QuestName = "FishmanQuest",   QuestNumber = 2, EnemyName = "Fishman Commando",     Island = "Underwater City" },
    { MinLevel = 450, MaxLevel = 474, QuestName = "SkyExp1Quest",   QuestNumber = 1, EnemyName = "God's Guard",          Island = "Upper Skylands" },
    { MinLevel = 475, MaxLevel = 524, QuestName = "SkyExp1Quest",   QuestNumber = 2, EnemyName = "Shanda",               Island = "Upper Skylands" },
    { MinLevel = 525, MaxLevel = 549, QuestName = "SkyExp2Quest",   QuestNumber = 1, EnemyName = "Royal Squad",          Island = "Upper Skylands" },
    { MinLevel = 550, MaxLevel = 624, QuestName = "SkyExp2Quest",   QuestNumber = 2, EnemyName = "Royal Soldier",        Island = "Upper Skylands" },
    { MinLevel = 625, MaxLevel = 649, QuestName = "FountainQuest",  QuestNumber = 1, EnemyName = "Galley Pirate",        Island = "Fountain City" },
    { MinLevel = 650, MaxLevel = 700, QuestName = "FountainQuest",  QuestNumber = 2, EnemyName = "Galley Captain",       Island = "Fountain City" }
}

-- ==========================================
-- 2. HÀM BỔ TRỢ LOGIC FARM
-- ==========================================
RunService.Stepped:Connect(function()
    if AutoFarmLevelEnabled and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

local function smoothMoveTo(targetCFrame)
    local char = LocalPlayer.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not root then return end

    local distance = (root.Position - targetCFrame.Position).Magnitude
    if distance < 10 then
        root.CFrame = targetCFrame
        return
    end

    local speed = 250
    local duration = distance / speed
    local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear)
    local tween = TweenService:Create(root, tweenInfo, {CFrame = targetCFrame})
    
    local bv = Instance.new("BodyVelocity")
    bv.Velocity = Vector3.zero
    bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    bv.Parent = root

    tween:Play()
    tween.Completed:Wait()
    bv:Destroy()
end

local function AutoEquipWeapon()
    local char = LocalPlayer.Character
    if not char then return end

    local humanoid = char:FindFirstChildOfClass("Humanoid")
    local backpack = LocalPlayer:FindFirstChild("Backpack")
    if not humanoid or not backpack then return end

    local currentTool = char:FindFirstChildOfClass("Tool")
    if currentTool then
        if SelectedWeapon == "Melee" and (currentTool.Name == "Combat" or currentTool:FindFirstChild("Melee")) then return end
        if SelectedWeapon == "Sword" and (currentTool.Name ~= "Combat" and currentTool:FindFirstChild("EquipEvent")) then return end
    end

    for _, tool in pairs(backpack:GetChildren()) do
        if tool:IsA("Tool") then
            local isTarget = false
            if SelectedWeapon == "Melee" and tool.Name == "Combat" then
                isTarget = true
            elseif SelectedWeapon == "Sword" and tool.Name ~= "Combat" then
                isTarget = true
            end

            if isTarget then
                humanoid:EquipTool(tool)
                break
            end
        end
    end
end

local function BringMobs(enemySpot, currentData)
    local EnemiesFolder = Workspace:FindFirstChild("Enemies")
    if not EnemiesFolder then return end

    for _, enemy in pairs(EnemiesFolder:GetChildren()) do
        if enemy.Name == currentData.EnemyName then
            local eHum = enemy:FindFirstChildOfClass("Humanoid")
            local eRoot = enemy:FindFirstChild("HumanoidRootPart")

            if eHum and eRoot and eHum.Health > 0 then
                -- Ép game nhường quyền quản lý con quái này cho client của cậu
                pcall(function()
                    if sethiddenproperty then
                        sethiddenproperty(enemy, "NetworkOwner", LocalPlayer)
                    elseif requestnetworkownership then
                        requestnetworkownership(enemy)
                    end
                end)

                -- Sau khi đã giành được quyền, cậu kéo quái về bãi thoải mái không sợ đơ
                if BringMobEnabled and enemySpot then
                    local dist = (eRoot.Position - enemySpot.Position).Magnitude
                    if dist <= 300 and dist > 3 then
                        eRoot.CanCollide = false
                        if enemy:FindFirstChild("Head") then
                            enemy.Head.CanCollide = false
                        end

                        eRoot.CFrame = enemySpot
                        eRoot.AssemblyLinearVelocity = Vector3.zero
                        eRoot.AssemblyAngularVelocity = Vector3.zero
                    end
                else
                    eRoot.CanCollide = true
                end
            end
        end
    end
end

local lastAttackTime = 0
local attackCooldown = 0.05

local function DoFastAttack(Net)
    if not FastAttackEnabled then return end
    if tick() - lastAttackTime < attackCooldown then return end
    lastAttackTime = tick()

    local char = LocalPlayer.Character
    if not char then return end

    local RegAttack = Net and Net:FindFirstChild("RE/RegisterAttack")
    local RegHit = Net and (Net:FindFirstChild("RegisterHit") or Net:FindFirstChild("RE/RegisterHit"))

    local hitTargets = {}
    local EnemiesFolder = Workspace:FindFirstChild("Enemies")
    local myRoot = char:FindFirstChild("HumanoidRootPart")

    if EnemiesFolder and myRoot then
        for _, enemy in pairs(EnemiesFolder:GetChildren()) do
            local eHum = enemy:FindFirstChildOfClass("Humanoid")
            local eRoot = enemy:FindFirstChild("HumanoidRootPart")
            if eHum and eHum.Health > 0 and eRoot then
                if (eRoot.Position - myRoot.Position).Magnitude <= 65 then
                    local hitPart = enemy:FindFirstChild("UpperTorso") or enemy:FindFirstChild("Head") or eRoot
                    table.insert(hitTargets, {enemy, hitPart})
                end
            end
        end
    end

    pcall(function()
        if RegAttack then RegAttack:FireServer(0, 1) end
        if RegHit and #hitTargets > 0 then
            for _, data in ipairs(hitTargets) do
                RegHit:FireServer(data[2], {}, nil, "157beb64")
            end
        end
    end)
end

-- ==========================================
-- 3. LOGIC WORKER (CHẠY NGẦM FARM LEVEL)
-- ==========================================
task.spawn(function()
    local CommF = ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("CommF_")
    local Net = ReplicatedStorage:FindFirstChild("Modules") and ReplicatedStorage.Modules:FindFirstChild("Net")

    local function getPlayerLevel()
        if LocalPlayer:FindFirstChild("Data") and LocalPlayer.Data:FindFirstChild("Level") then
            return LocalPlayer.Data.Level.Value
        end
        return 1
    end

    local function hasActiveQuest()
        local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
        if playerGui then
            local mainGui = playerGui:FindFirstChild("Main")
            if mainGui then
                local questFrame = mainGui:FindFirstChild("Quest")
                if questFrame and questFrame.Visible then
                    return true
                end
            end
        end
        return false
    end

    while true do
        task.wait(0.1)

        if AutoFarmLevelEnabled then
            local Character = LocalPlayer.Character
            local RootPart = Character and Character:FindFirstChild("HumanoidRootPart")
            local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")

            if Character and RootPart and Humanoid and Humanoid.Health > 0 then
                local currentLevel = getPlayerLevel()
                local currentData = nil

                for _, q in ipairs(QuestDatabase) do
                    if currentLevel >= q.MinLevel and currentLevel <= q.MaxLevel then
                        currentData = q
                        break
                    end
                end

                if currentData then
                    if not hasActiveQuest() then
                        local npcPos = NpcPositions[currentData.Island]
                        if npcPos then
                            smoothMoveTo(npcPos)
                            task.wait(0.2)
                        end

                        if CommF and not hasActiveQuest() then
                            pcall(function()
                                CommF:InvokeServer("StartQuest", currentData.QuestName, currentData.QuestNumber)
                            end)
                        end
                        task.wait(0.5)
                    end

                    if hasActiveQuest() then
                        local enemySpot = EnemyPositions[currentData.EnemyName]
                        if enemySpot and (RootPart.Position - enemySpot.Position).Magnitude > 150 then
                            smoothMoveTo(enemySpot * CFrame.new(0, 50, 0)) -- Đã chỉnh độ cao lên 50
                        end

                        while hasActiveQuest() and AutoFarmLevelEnabled do
                            task.wait(0.05)

                            local curChar = LocalPlayer.Character
                            local curRoot = curChar and curChar:FindFirstChild("HumanoidRootPart")
                            local curHum = curChar and curChar:FindFirstChildOfClass("Humanoid")

                            if not curChar or not curRoot or not curHum or curHum.Health <= 0 then
                                break
                            end

                            local EnemiesFolder = Workspace:FindFirstChild("Enemies")
                            
                            local aliveCount = 0
                            local targetEnemyRoot = nil

                            if EnemiesFolder then
                                for _, enemy in pairs(EnemiesFolder:GetChildren()) do
                                    if enemy.Name == currentData.EnemyName then
                                        local eHum = enemy:FindFirstChildOfClass("Humanoid")
                                        local eRoot = enemy:FindFirstChild("HumanoidRootPart")
                                        if eHum and eHum.Health > 0 and eRoot then
                                            aliveCount = aliveCount + 1
                                            if not targetEnemyRoot then
                                                targetEnemyRoot = eRoot
                                            else
                                                if (eRoot.Position - curRoot.Position).Magnitude < (targetEnemyRoot.Position - curRoot.Position).Magnitude then
                                                    targetEnemyRoot = eRoot
                                                end
                                            end
                                        end
                                    end
                                end
                            end

                            if aliveCount > 0 then
                                local farmTime = tick()

                                while aliveCount > 0 and AutoFarmLevelEnabled and hasActiveQuest() do
                                    if tick() - farmTime > 15 then break end

                                    local activeChar = LocalPlayer.Character
                                    local activeRoot = activeChar and activeChar:FindFirstChild("HumanoidRootPart")
                                    local activeHum = activeChar and activeChar:FindFirstChildOfClass("Humanoid")

                                    if not activeChar or not activeRoot or not activeHum or activeHum.Health <= 0 then
                                        break
                                    end

                                    AutoEquipWeapon()
                                    
                                    if BringMobEnabled then
                                        if enemySpot then
                                            activeRoot.CFrame = enemySpot * CFrame.new(0, 50, 0) -- Đứng cao tít trên bãi quái
                                        end
                                        BringMobs(enemySpot, currentData)
                                    else
                                        if targetEnemyRoot and targetEnemyRoot.Parent then
                                            activeRoot.CFrame = targetEnemyRoot.CFrame * CFrame.new(0, 10, 3)
                                        elseif enemySpot then
                                            activeRoot.CFrame = enemySpot * CFrame.new(0, 50, 0)
                                        end
                                    end

                                    DoFastAttack(Net)

                                    task.wait(0.05)

                                    aliveCount = 0
                                    targetEnemyRoot = nil
                                    if EnemiesFolder then
                                        for _, enemy in pairs(EnemiesFolder:GetChildren()) do
                                            if enemy.Name == currentData.EnemyName then
                                                local eHum = enemy:FindFirstChildOfClass("Humanoid")
                                                local eRoot = enemy:FindFirstChild("HumanoidRootPart")
                                                if eHum and eHum.Health > 0 and eRoot then
                                                    aliveCount = aliveCount + 1
                                                    if not targetEnemyRoot then
                                                        targetEnemyRoot = eRoot
                                                    else
                                                        if (eRoot.Position - activeRoot.Position).Magnitude < (targetEnemyRoot.Position - activeRoot.Position).Magnitude then
                                                            targetEnemyRoot = eRoot
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            else
                                if enemySpot then
                                    curRoot.CFrame = enemySpot * CFrame.new(0, 50, 0)
                                end
                                task.wait(0.3)
                            end
                        end
                    end
                end
            end
        end
    end
end)
         
-- SEA 1 TELEPORT LOCATIONS
local IslandTeleports = {
    ["Pirate Starter"]  = Vector3.new(1059.37, 40, 1549.2),
    ["Jungle"]          = Vector3.new(-1610.6, 50, 142.3),
    ["Pirate Village"]  = Vector3.new(-1140.17, 30, 3827.42),
    ["Desert"]          = Vector3.new(894.48, 30, 4392.43),
    ["Frozen Village"]  = Vector3.new(1385.74, 110, -1298.07),
    ["Marine Fortress"] = Vector3.new(-5039.59, 50, 4324.58),
    ["Skylands"]        = Vector3.new(-4839.53, 730, -2619.44),
    ["Prison"]          = Vector3.new(485.63, 20, 736.61),
    ["Colosseum"]       = Vector3.new(-1422.01, 30, -3015.68),
    ["Magma Village"]   = Vector3.new(-5232.9, 30, 8533.8),
    ["Underwater City"] = Vector3.new(61163.85, 40, 1569.25),
    ["Upper Skylands"]  = Vector3.new(-7859.1, 5560, -380.3),
    ["Fountain City"]   = Vector3.new(5259.82, 60, 4050.0)
}

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function smoothMoveTo(targetPos)
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local hrp = character:FindFirstChild("HumanoidRootPart")
    local humanoid = character:FindFirstChild("Humanoid")
    if not hrp or not humanoid then return end

    -- Tốc độ giảm nhẹ lại để anticheat không kéo văng về biển
    local speed = 250 
    
    -- Độ cao bay thấp vừa đủ an toàn (150m)
    local safeHeight = math.max(150, targetPos.Y + 20)
    
    local startAir = Vector3.new(hrp.Position.X, safeHeight, hrp.Position.Z)
    local targetAir = Vector3.new(targetPos.X, safeHeight, targetPos.Z)

    -- Giữ cố định nhân vật không cho trọng lực kéo rớt xuống biển
    local bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    bodyVelocity.Parent = hrp

    -- Tắt va chạm tạm thời
    for _, part in ipairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = false
        end
    end

    -- 1. Tới độ cao an toàn
    local dist1 = (startAir - hrp.Position).Magnitude
    if dist1 > 5 then
        local tween1 = TweenService:Create(hrp, TweenInfo.new(dist1 / speed, Enum.EasingStyle.Linear), {CFrame = CFrame.new(startAir)})
        tween1:Play()
        tween1.Completed:Wait()
    end

    -- 2. Lướt thẳng sang đảo
    local dist2 = (targetAir - startAir).Magnitude
    local tween2 = TweenService:Create(hrp, TweenInfo.new(dist2 / speed, Enum.EasingStyle.Linear), {CFrame = CFrame.new(targetAir)})
    tween2:Play()
    tween2.Completed:Wait()

    -- 3. Hạ nhẹ xuống vị trí đảo
    local dist3 = (targetPos - targetAir).Magnitude
    local tween3 = TweenService:Create(hrp, TweenInfo.new(dist3 / speed, Enum.EasingStyle.Linear), {CFrame = CFrame.new(targetPos)})
    tween3:Play()
    tween3.Completed:Wait()

    -- Xóa lực giữ và bật lại va chạm
    bodyVelocity:Destroy()
    for _, part in ipairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = true
        end
    end
end

-- ==========================================
-- AUTO STATS ĐA TOGGLE (CHUẨN FIX DÙNG WAITFORCHILD)
-- ==========================================
AutoMeleeEnabled = false
AutoDefenseEnabled = false
AutoSwordEnabled = false
AutoGunEnabled = false
AutoFruitEnabled = false
StatsAmount = 3 -- Số điểm cộng mỗi lần

task.spawn(function()
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    
    local CommF = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommF_")
    local points = LocalPlayer:WaitForChild("Data"):WaitForChild("Points")
    
    while true do
        task.wait(1) -- Check mỗi 1 giây cho nhẹ máy
        
        if points.Value > 0 then
            pcall(function()
                if AutoMeleeEnabled then
                    CommF:InvokeServer("AddPoint", "Melee", StatsAmount)
                    task.wait(0.2)
                end
                
                if AutoDefenseEnabled then
                    CommF:InvokeServer("AddPoint", "Defense", StatsAmount)
                    task.wait(0.2)
                end
                
                if AutoSwordEnabled then
                    CommF:InvokeServer("AddPoint", "Sword", StatsAmount)
                    task.wait(0.2)
                end
                
                if AutoGunEnabled then
                    CommF:InvokeServer("AddPoint", "Gun", StatsAmount)
                    task.wait(0.2)
                end
                
                if AutoFruitEnabled then
                    CommF:InvokeServer("AddPoint", "Demon Fruit", StatsAmount)
                    task.wait(0.2)
                end
            end)
        end
    end
end)

-- ====================================================================
-- GIAO DIỆN UI
-- ====================================================================
local Window = Library:CreateWindow("ABYSSAL HUB")
local MainTab = Window:CreateTab("Farming Tab")
local SettingTab = Window:CreateTab("Settings")
local PlayerTab = Window:CreateTab("Player")
local TeleportTab = Window:CreateTab("Teleport (Sea1)")
local AutoTab = Window:CreateTab("Auto stats")

MainTab:CreateToggle("Auto Farm Level", false, function(state)
    AutoFarmLevelEnabled = state
end)

local selectedIsland = "Pirate Starter"

TeleportTab:CreateDropdown("Select Island", {
    "Pirate Starter",
    "Jungle",
    "Pirate Village",
    "Desert",
    "Frozen Village",
    "Marine Fortress",
    "Skylands",
    "Prison",
    "Colosseum",
    "Magma Village",
    "Underwater City",
    "Upper Skylands",
    "Fountain City"
}, "Pirate Starter", function(choice)
    selectedIsland = choice
end)

TeleportTab:CreateButton("Teleport to Island", function()
    local pos = IslandTeleports[selectedIsland]
    if pos then
        task.spawn(function()
            smoothMoveTo(pos)
        end)
    end
end)

PlayerTab:CreateSlider("WalkSpeed", 16, 200, 16, function(value)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = value
    end
end)

PlayerTab:CreateBox("Teleport Player", "Tên Player...", function(text)
    print("Đang Teleport đến:", text)
end)

SettingTab:CreateToggle("Fast Attack", true, function(state)
    FastAttackEnabled = state
end)

SettingTab:CreateDropdown("Select Weapon", {"Melee", "Sword"}, "Melee", function(selected)
    SelectedWeapon = selected
end)

SettingTab:CreateDropdown("Fast Attack Speed", {"Slow", "Medium", "Fast"}, "Fast", function(selectedSpeed)
    if selectedSpeed == "Slow" then
        FastAttackSpeed = 3
    elseif selectedSpeed == "Medium" then
        FastAttackSpeed = 6
    elseif selectedSpeed == "Fast" then
        FastAttackSpeed = 10
    end
end)

SettingTab:CreateToggle("Bring Mobs(Đang lỗi)", true, function(state)
    BringMobEnabled = state
end)

AutoTab:CreateToggle("Auto Melee", function(state)
    AutoMeleeEnabled = state
end)

AutoTab:CreateToggle("Auto Defense", function(state)
    AutoDefenseEnabled = state
end)

AutoTab:CreateToggle("Auto Sword", function(state)
    AutoSwordEnabled = state
end)

AutoTab:CreateToggle("Auto Gun", function(state)
    AutoGunEnabled = state
end)

AutoTab:CreateToggle("Auto Demon Fruit", function(state)
    AutoFruitEnabled = state
end)
