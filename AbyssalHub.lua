local Library = {}
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

function Library:CreateWindow(hubName)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "AbyssalHubUI"
    ScreenGui.Parent = CoreGui
    ScreenGui.ResetOnSpawn = false

    -- Nút Toggle UI (Góc trái)
    local ToggleUIButton = Instance.new("TextButton")
    ToggleUIButton.Name = "ToggleUIButton"
    ToggleUIButton.Parent = ScreenGui
    ToggleUIButton.Position = UDim2.new(0.02, 0, 0.2, 0)
    ToggleUIButton.Size = UDim2.new(0, 42, 0, 42)
    ToggleUIButton.BackgroundColor3 = Color3.fromRGB(15, 20, 28)
    ToggleUIButton.Text = "AH"
    ToggleUIButton.TextColor3 = Color3.fromRGB(0, 210, 255)
    ToggleUIButton.TextSize = 15
    ToggleUIButton.Font = Enum.Font.GothamBold

    local ToggleUICorner = Instance.new("UICorner")
    ToggleUICorner.CornerRadius = UDim.new(0, 8)
    ToggleUICorner.Parent = ToggleUIButton

    local ToggleUIStroke = Instance.new("UIStroke")
    ToggleUIStroke.Color = Color3.fromRGB(0, 210, 255)
    ToggleUIStroke.Thickness = 1.5
    ToggleUIStroke.Parent = ToggleUIButton

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

    ToggleUIButton.MouseButton1Click:Connect(function()
        MainFrame.Visible = not MainFrame.Visible
    end)

    -- Topbar (Đã xóa vạch dính & làm gọn chữ)
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

        -- BUTTON (Đã sửa màu & bấm nhạy hơn)
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

        -- TOGGLE (Bấm toàn bộ ô, không bị Label che nút)
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

        -- SLIDER (Sửa vuốt cảm ứng trên màn hình cảm ứng)
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

function CreateDropdown(tabParent, text, options, defaultOption, callback)
    local dropdownFrame = Instance.new("Frame")
    local dropdownTitle = Instance.new("TextLabel")
    local dropdownBtn = Instance.new("TextButton")
    local optionsHolder = Instance.new("ScrollingFrame")
    local UIListLayout = Instance.new("UIListLayout")

    local selected = defaultOption or options[1]
    local isOpened = false

    -- Cấu hình Frame chính của Dropdown
    dropdownFrame.Name = text .. "_Dropdown"
    dropdownFrame.Size = UDim2.new(1, -20, 0, 40)
    dropdownFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    dropdownFrame.BorderSizePixel = 0
    dropdownFrame.Parent = tabParent

    -- Tiêu đề Dropdown
    dropdownTitle.Size = UDim2.new(0.5, 0, 0, 40)
    dropdownTitle.Position = UDim2.new(0, 10, 0, 0)
    dropdownTitle.BackgroundTransparency = 1
    dropdownTitle.Text = text
    dropdownTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    dropdownTitle.TextXAlignment = Enum.TextXAlignment.Left
    dropdownTitle.Font = Enum.Font.SourceSansBold
    dropdownTitle.TextSize = 14
    dropdownTitle.Parent = dropdownFrame

    -- Nút bấm mở/đóng danh sách
    dropdownBtn.Size = UDim2.new(0.4, 0, 0, 30)
    dropdownBtn.Position = UDim2.new(0.58, 0, 0, 5)
    dropdownBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    dropdownBtn.Text = tostring(selected) .. "  ▼"
    dropdownBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    dropdownBtn.Font = Enum.Font.SourceSans
    dropdownBtn.TextSize = 13
    dropdownBtn.Parent = dropdownFrame

    -- Khai báo Khung chứa danh sách các Lựa Chọn (Options Holder)
    optionsHolder.Size = UDim2.new(1, 0, 0, 0)
    optionsHolder.Position = UDim2.new(0, 0, 1, 5)
    optionsHolder.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    optionsHolder.Visible = false
    optionsHolder.CanvasSize = UDim2.new(0, 0, 0, #options * 25)
    optionsHolder.ScrollBarThickness = 4
    optionsHolder.ZIndex = 5
    optionsHolder.Parent = dropdownFrame

    UIListLayout.Parent = optionsHolder
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

    -- Hàm cập nhật/mở/đóng Dropdown
    local function toggleDropdown()
        isOpened = not isOpened
        optionsHolder.Visible = isOpened
        if isOpened then
            dropdownBtn.Text = tostring(selected) .. "  ▲"
            optionsHolder.Size = UDim2.new(1, 0, 0, math.min(#options * 25, 100))
        else
            dropdownBtn.Text = tostring(selected) .. "  ▼"
            optionsHolder.Size = UDim2.new(1, 0, 0, 0)
        end
    end

    dropdownBtn.MouseButton1Click:Connect(toggleDropdown)

    -- Tạo từng nút lựa chọn trong danh sách
    for i, opt in ipairs(options) do
        local optBtn = Instance.new("TextButton")
        optBtn.Size = UDim2.new(1, 0, 0, 25)
        optBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        optBtn.BackgroundTransparency = 0.5
        optBtn.Text = tostring(opt)
        optBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
        optBtn.Font = Enum.Font.SourceSans
        optBtn.TextSize = 13
        optBtn.ZIndex = 6
        optBtn.Parent = optionsHolder

        optBtn.MouseButton1Click:Connect(function()
            selected = opt
            dropdownBtn.Text = tostring(selected) .. "  ▼"
            toggleDropdown()
            if callback then
                pcall(callback, selected)
            end
        end)
    end

    -- Thực thi callback lần đầu với giá trị mặc định
    if callback then
        pcall(callback, selected)
    end
end

        return TabElements
    end

    return Window
end

-- ====================================================================
-- DEMO CHẠY THỬ
-- ====================================================================
local Window = Library:CreateWindow("ABYSSAL HUB")

local MainTab = Window:CreateTab("Main")
local PlayerTab = Window:CreateTab("Player")
local SettingTab = Window:CreateTab("Settings")

-- ====================================================================
-- AUTO FARM LEVEL FULL SEA 1 (FIX LAG GIẬT + FIX KẸT QUÁI)
-- ====================================================================

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer

local NpcPositions = {
    ["Pirate Starter"]  = CFrame.new(1059.37, 20, 1549.2),
    ["Jungle"]          = CFrame.new(-1598.08, 40, 153.38),
    ["Pirate Village"]  = CFrame.new(-1140.17, 10, 3827.42),
    ["Desert"]          = CFrame.new(894.48, 10, 4392.43),
    ["Frozen Village"]  = CFrame.new(1385.74, 90, -1298.07),
    ["Marine Fortress"] = CFrame.new(-5039.59, 30, 4324.58),
    ["Skylands"]        = CFrame.new(-4839.53, 720, -2619.44),
    ["Prison"]          = CFrame.new(485.63, 5, 736.61),
    ["Colosseum"]       = CFrame.new(-1422.01, 10, -3015.68),
    ["Magma Village"]   = CFrame.new(-5232.9, 12, 8533.8),
    ["Underwater City"] = CFrame.new(61163.85, 22, 1569.25),
    ["Upper Skylands"]  = CFrame.new(-7859.1, 5550, -380.3),
    ["Fountain City"]   = CFrame.new(5259.82, 42, 4050.0)
}

local EnemyPositions = {
    ["Bandit"]                = CFrame.new(1038.5, 30, 1542.8),
    ["Monkey"]                = CFrame.new(-1610.6, 35, 142.3),
    ["Gorilla"]               = CFrame.new(-1237.7, 35, -486.3),
    ["Pirate"]                = CFrame.new(-1205.1, 25, 3858.8),
    ["Brute"]                 = CFrame.new(-1148.5, 25, 4253.6),
    ["Desert Bandit"]         = CFrame.new(932.4, 20, 4438.3),
    ["Desert Officer"]        = CFrame.new(1571.3, 20, 4381.1),
    ["Snow Bandit"]           = CFrame.new(1288.2, 100, -1352.4),
    ["Snowman"]               = CFrame.new(1228.6, 100, -1522.6),
    ["Chief Petty Officer"]   = CFrame.new(-4881.9, 40, 4242.3),
    ["Sky Bandit"]            = CFrame.new(-4972.3, 730, -2871.2),
    ["Dark Master"]           = CFrame.new(-5223.1, 730, -2285.8),
    ["Prisoner"]              = CFrame.new(542.1, 20, 482.9),
    ["Dangerous Prisoner"]    = CFrame.new(480.2, 20, 1140.3),
    ["Toga Warrior"]          = CFrame.new(-1805.1, 20, -2742.6),
    ["Gladiator"]             = CFrame.new(-1323.8, 20, -3316.3),
    ["Military Soldier"]      = CFrame.new(-5411.3, 30, 8512.4),
    ["Military Spy"]          = CFrame.new(-5815.2, 90, 8821.5),
    ["Fishman Warrior"]       = CFrame.new(60842.1, 30, 1531.2),
    ["Fishman Commando"]      = CFrame.new(61812.5, 30, 1475.8),
    ["God's Guard"]           = CFrame.new(-7725.4, 5560, -425.1),
    ["Shanda"]                = CFrame.new(-7672.1, 5560, -1021.3),
    ["Royal Squad"]           = CFrame.new(-7528.3, 5600, -1451.2),
    ["Royal Soldier"]         = CFrame.new(-7812.6, 5600, -1820.5),
    ["Galley Pirate"]         = CFrame.new(5582.3, 50, 3982.1),
    ["Galley Captain"]        = CFrame.new(5641.8, 50, 4920.4)
}

-- ====================================================================
-- DATABASE CẤP ĐỘ TRÒN CHUẨN 100% THEO BLOX FRUITS (SEA 1)
-- ====================================================================

local QuestDatabase = {
    -- Đảo Khởi Đầu
    { MinLevel = 1,   MaxLevel = 10,  QuestName = "BanditQuest1",   QuestNumber = 1, EnemyName = "Bandit",               Island = "Pirate Starter" },
    
    -- Đảo Khỉ (Jungle)
    { MinLevel = 10,  MaxLevel = 15,  QuestName = "JungleQuest",    QuestNumber = 1, EnemyName = "Monkey",               Island = "Jungle" },
    { MinLevel = 15,  MaxLevel = 30,  QuestName = "JungleQuest",    QuestNumber = 2, EnemyName = "Gorilla",              Island = "Jungle" },
    
    -- Đảo Cướp Biển (Pirate Village)
    { MinLevel = 30,  MaxLevel = 40,  QuestName = "BuggyQuest1",    QuestNumber = 1, EnemyName = "Pirate",               Island = "Pirate Village" },
    { MinLevel = 40,  MaxLevel = 60,  QuestName = "BuggyQuest1",    QuestNumber = 2, EnemyName = "Brute",                Island = "Pirate Village" },
    
    -- Sa Mạc (Desert)
    { MinLevel = 60,  MaxLevel = 75,  QuestName = "DesertQuest",    QuestNumber = 1, EnemyName = "Desert Bandit",        Island = "Desert" },
    { MinLevel = 75,  MaxLevel = 90,  QuestName = "DesertQuest",    QuestNumber = 2, EnemyName = "Desert Officer",       Island = "Desert" },
    
    -- Đảo Tuyết (Frozen Village)
    { MinLevel = 90,  MaxLevel = 100, QuestName = "SnowQuest",      QuestNumber = 1, EnemyName = "Snow Bandit",          Island = "Frozen Village" },
    { MinLevel = 100, MaxLevel = 120, QuestName = "SnowQuest",      QuestNumber = 2, EnemyName = "Snowman",              Island = "Frozen Village" },
    
    -- Căn Cứ Hải Quân (Marine Fortress)
    { MinLevel = 120, MaxLevel = 150, QuestName = "MarineQuest2",   QuestNumber = 1, EnemyName = "Chief Petty Officer",  Island = "Marine Fortress" },
    
    -- Đảo Mây 1 (Skylands)
    { MinLevel = 150, MaxLevel = 175, QuestName = "SkyQuest",       QuestNumber = 1, EnemyName = "Sky Bandit",           Island = "Skylands" },
    { MinLevel = 175, MaxLevel = 190, QuestName = "SkyQuest",       QuestNumber = 2, EnemyName = "Dark Master",          Island = "Skylands" },
    
    -- Nhà Tù (Prison)
    { MinLevel = 190, MaxLevel = 210, QuestName = "PrisonerQuest",  QuestNumber = 1, EnemyName = "Prisoner",             Island = "Prison" },
    { MinLevel = 210, MaxLevel = 250, QuestName = "PrisonerQuest",  QuestNumber = 2, EnemyName = "Dangerous Prisoner",   Island = "Prison" },
    
    -- Đấu Trường (Colosseum)
    { MinLevel = 250, MaxLevel = 275, QuestName = "ColosseumQuest", QuestNumber = 1, EnemyName = "Toga Warrior",         Island = "Colosseum" },
    { MinLevel = 275, MaxLevel = 300, QuestName = "ColosseumQuest", QuestNumber = 2, EnemyName = "Gladiator",            Island = "Colosseum" },
    
    -- Đảo Núi Lửa (Magma Village)
    { MinLevel = 300, MaxLevel = 325, QuestName = "MagmaQuest",     QuestNumber = 1, EnemyName = "Military Soldier",     Island = "Magma Village" },
    { MinLevel = 325, MaxLevel = 375, QuestName = "MagmaQuest",     QuestNumber = 2, EnemyName = "Military Spy",         Island = "Magma Village" },
    
    -- Đảo Người Cá (Underwater City)
    { MinLevel = 375, MaxLevel = 400, QuestName = "FishmanQuest",   QuestNumber = 1, EnemyName = "Fishman Warrior",      Island = "Underwater City" },
    { MinLevel = 400, MaxLevel = 450, QuestName = "FishmanQuest",   QuestNumber = 2, EnemyName = "Fishman Commando",     Island = "Underwater City" },
    
    -- Đảo Mây Trên 1 (Upper Skylands Area 1)
    { MinLevel = 450, MaxLevel = 475, QuestName = "SkyExp1Quest",   QuestNumber = 1, EnemyName = "God's Guard",          Island = "Upper Skylands" },
    { MinLevel = 475, MaxLevel = 525, QuestName = "SkyExp1Quest",   QuestNumber = 2, EnemyName = "Shanda",               Island = "Upper Skylands" },
    
    -- Đảo Mây Trên 2 (Upper Skylands Area 2)
    { MinLevel = 525, MaxLevel = 550, QuestName = "SkyExp2Quest",   QuestNumber = 1, EnemyName = "Royal Squad",          Island = "Upper Skylands" },
    { MinLevel = 550, MaxLevel = 625, QuestName = "SkyExp2Quest",   QuestNumber = 2, EnemyName = "Royal Soldier",        Island = "Royal Soldier" },
    
    -- Đảo Đài Thần (Fountain City)
    { MinLevel = 625, MaxLevel = 650, QuestName = "FountainQuest",  QuestNumber = 1, EnemyName = "Galley Pirate",        Island = "Fountain City" },
    { MinLevel = 650, MaxLevel = 700, QuestName = "FountainQuest",  QuestNumber = 2, EnemyName = "Galley Captain",       Island = "Fountain City" }
}

local AutoFarmLevelEnabled = false
local noclipConnection = nil

local function enableNoclip()
    if not noclipConnection then
        noclipConnection = RunService.Stepped:Connect(function()
            if AutoFarmLevelEnabled and LocalPlayer.Character then
                for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    end
end

local function disableNoclip()
    if noclipConnection then
        noclipConnection:Disconnect()
        noclipConnection = nil
    end
end

local function smoothMoveTo(targetCFrame)
    local char = LocalPlayer.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not root then return end

    local distance = (root.Position - targetCFrame.Position).Magnitude
    if distance < 10 then
        root.CFrame = targetCFrame
        return
    end

    local speed = 300
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

MainTab:CreateToggle("Auto Farm Level", false, function(state)
    AutoFarmLevelEnabled = state

    if not AutoFarmLevelEnabled then
        disableNoclip()
        return
    end

    enableNoclip()

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

        while AutoFarmLevelEnabled do
            task.wait(0.1)

            local Character = LocalPlayer.Character
            local RootPart = Character and Character:FindFirstChild("HumanoidRootPart")
            local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")

            if not Character or not RootPart or not Humanoid or Humanoid.Health <= 0 then
                repeat 
                    task.wait(0.5)
                    Character = LocalPlayer.Character
                    RootPart = Character and Character:FindFirstChild("HumanoidRootPart")
                    Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
                until AutoFarmLevelEnabled and Character and RootPart and Humanoid and Humanoid.Health > 0
                task.wait(0.8)
            end

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
                    -- 1. CHỈ NHẬN QUEST KHI HOÀN TOÀN KHÔNG CÓ QUEST HIỆN TẠI
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

                    -- 2. VÒNG LẶP FARM CHỈ CHẠY KHI ĐÃ NHẬN QUEST
                    if hasActiveQuest() then
                        -- Bay thẳng tới bãi quái 1 lần duy nhất trước khi chọn quái
                        local enemySpot = EnemyPositions[currentData.EnemyName]
                        if enemySpot and (RootPart.Position - enemySpot.Position).Magnitude > 150 then
                            smoothMoveTo(enemySpot * CFrame.new(0, 18, 0))
                        end

                        while hasActiveQuest() and AutoFarmLevelEnabled do
                            task.wait(0.05)

                            local curChar = LocalPlayer.Character
                            local curHum = curChar and curChar:FindFirstChildOfClass("Humanoid")
                            if not curHum or curHum.Health <= 0 then break end

                            local EnemiesFolder = Workspace:FindFirstChild("Enemies")
                            local targetEnemy = nil

                            if EnemiesFolder then
                                for _, enemy in pairs(EnemiesFolder:GetChildren()) do
                                    if enemy.Name == currentData.EnemyName then
                                        local eHum = enemy:FindFirstChildOfClass("Humanoid")
                                        local eRoot = enemy:FindFirstChild("HumanoidRootPart")
                                        if eHum and eHum.Health > 0 and eRoot then
                                            targetEnemy = enemy
                                            break
                                        end
                                    end
                                end
                            end

                            if targetEnemy then
                                local eHum = targetEnemy:FindFirstChildOfClass("Humanoid")
                                local eRoot = targetEnemy:FindFirstChild("HumanoidRootPart")
                                local farmTime = tick()

                                -- BỌC CƠ CHẾ TIMEOUT: Nếu đánh 1 con quái quá 12s chưa chết -> Tự đổi quái khác
                                while targetEnemy and eHum and eHum.Health > 0 and AutoFarmLevelEnabled and hasActiveQuest() do
                                    if tick() - farmTime > 12 then break end

                                    local playerHum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                                    if not playerHum or playerHum.Health <= 0 then break end

                                    RootPart.CFrame = CFrame.new(eRoot.Position + Vector3.new(0, 18, 0))

                                    if Net then
                                        pcall(function()
                                            local RegAttack = Net:FindFirstChild("RE/RegisterAttack")
                                            local RegHit = Net:FindFirstChild("RegisterHit") or Net:FindFirstChild("RE/RegisterHit")
                                            
                                            if RegAttack then RegAttack:FireServer(0.5, 1) end
                                            if RegHit then 
                                                local hitPart = targetEnemy:FindFirstChild("UpperTorso") or eRoot
                                                RegHit:FireServer(hitPart, {}, nil, "157beb64")
                                            end
                                        end)
                                    end

                                    task.wait(0.08)
                                end
                            else
                                -- Chờ quái spawn tại điểm cố định
                                if enemySpot then
                                    RootPart.CFrame = enemySpot * CFrame.new(0, 18, 0)
                                end
                                task.wait(0.3)
                            end
                        end
                    end
                end
            end
        end
    end)
end)

local FastAttackEnabled = true
local FastAttackSpeed = 8
local SelectedWeapon = "Melee"

-- 1. HÀM TỰ ĐỘNG CẦM VŨ KHÍ (MELEE / SWORD)
local function AutoEquipWeapon()
    local char = LocalPlayer.Character
    if not char then return end

    local humanoid = char:FindFirstChildOfClass("Humanoid")
    local backpack = LocalPlayer:FindFirstChild("Backpack")
    if not humanoid or not backpack then return end

    -- Check xem đang cầm đúng loại chưa
    local currentTool = char:FindFirstChildOfClass("Tool")
    if currentTool then
        if SelectedWeapon == "Melee" and (currentTool.Name == "Combat" or currentTool:FindFirstChild("Melee")) then return end
        if SelectedWeapon == "Sword" and (currentTool.Name ~= "Combat" and currentTool:FindFirstChild("EquipEvent")) then return end
    end

    -- Tìm trong Balo để Equip
    for _, tool in pairs(backpack:GetChildren()) do
        if tool:IsA("Tool") then
            local isTarget = false
            if SelectedWeapon == "Melee" and tool.Name == "Combat" then
                isTarget = true
            elseif SelectedWeapon == "Sword" and tool.Name ~= "Combat" then
                isTarget = true
            end

            if isTarget then
                local equipEvent = tool:FindFirstChild("EquipEvent")
                if equipEvent then
                    pcall(function()
                        equipEvent:FireServer(true)
                    end)
                end
                humanoid:EquipTool(tool)
                break
            end
        end
    end
end

-- 2. HÀM FAST ATTACK (ĐÁNH SIÊU NHANH)
local function DoFastAttack(targetEnemy, Net)
    if not targetEnemy then return end

    local RegAttack = Net and Net:FindFirstChild("RE/RegisterAttack")
    local RegHit = Net and (Net:FindFirstChild("RegisterHit") or Net:FindFirstChild("RE/RegisterHit"))
    local eRoot = targetEnemy:FindFirstChild("HumanoidRootPart")
    if not eRoot then return end

    -- Tắt animation vung tay
    local char = LocalPlayer.Character
    if char then
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if humanoid then
            for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
                if track.Name:lower():find("attack") or track.Name:lower():find("slash") then
                    track:Stop()
                end
            end
        end
    end

    -- Xả hit liên tục
    local loopHits = FastAttackEnabled and FastAttackSpeed or 1
    for i = 1, loopHits do
        pcall(function()
            if RegAttack then RegAttack:FireServer(0.5, 1) end
            if RegHit then 
                local hitPart = targetEnemy:FindFirstChild("UpperTorso") or eRoot
                RegHit:FireServer(hitPart, {}, nil, "157beb64")
            end
        end)
    end
end

while targetEnemy and eHum and eHum.Health > 0 and AutoFarmLevelEnabled and hasActiveQuest() do
    if tick() - farmTime > 12 then break end

    local playerHum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if not playerHum or playerHum.Health <= 0 then break end

    -- 1. TỰ ĐỘNG CẦM VŨ KHÍ ĐÃ CHỌN TRONG SETTINGS
    AutoEquipWeapon()

    -- 2. ĐỨNG TRÊN KHÔNG VÀ QUAY MẶT VỀ PHÍA QUÁI
    RootPart.CFrame = CFrame.lookAt(eRoot.Position + Vector3.new(0, 18, 0), eRoot.Position)

    -- 3. XẢ FAST ATTACK
    DoFastAttack(targetEnemy, Net)

    task.wait(0.01)
end

-- ====================================================================
-- TAB SETTINGS (CHỨA TOGGLE VÀ DROPDOWN)
-- ====================================================================

local SettingTab = Window:CreateTab("Settings")

-- Toggle bật/tắt Fast Attack
SettingTab:CreateToggle("Fast Attack", true, function(state)
    FastAttackEnabled = state
end)

-- Dropdown chọn loại Vũ Khí
CreateDropdown(SettingTab, "Select Weapon", {"Melee", "Sword"}, "Melee", function(selected)
    SelectedWeapon = selected
end)

-- Dropdown chọn Tốc Độ Fast Attack
CreateDropdown(SettingTab, "Fast Attack Speed", {"Slow", "Medium", "Fast"}, "Fast", function(selectedSpeed)
    if selectedSpeed == "Slow" then
        FastAttackSpeed = 3
    elseif selectedSpeed == "Medium" then
        FastAttackSpeed = 5
    elseif selectedSpeed == "Fast" then
        FastAttackSpeed = 8
    end
end)

PlayerTab:CreateSlider("WalkSpeed", 16, 200, 16, function(value)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
end)

PlayerTab:CreateBox("Teleport Player", "Tên Player...", function(text)
    print("Đang Teleport đến:", text)
end)
