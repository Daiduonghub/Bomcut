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
        function TabElements:CreateToggle(text, defaultState, callback)
    -- Ép cứng trạng thái chuẩn boolean để không bao giờ bị lỗi tự bật xanh
    local state = (defaultState == true) and true or false

    local toggleFrame = Instance.new("Frame")
    local toggleTitle = Instance.new("TextLabel")
    local toggleBtn = Instance.new("TextButton")

    toggleFrame.Name = text .. "_Toggle"
    toggleFrame.Size = UDim2.new(1, -6, 0, 36)
    toggleFrame.BackgroundColor3 = Color3.fromRGB(21, 27, 36)
    toggleFrame.BorderSizePixel = 0
    toggleFrame.Parent = TabPage

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 6)
    Corner.Parent = toggleFrame

    toggleTitle.Size = UDim2.new(0.7, 0, 1, 0)
    toggleTitle.Position = UDim2.new(0, 10, 0, 0)
    toggleTitle.BackgroundTransparency = 1
    toggleTitle.Text = text
    toggleTitle.TextColor3 = Color3.fromRGB(240, 240, 240)
    toggleTitle.TextXAlignment = Enum.TextXAlignment.Left
    toggleTitle.Font = Enum.Font.GothamMedium
    toggleTitle.TextSize = 12
    toggleTitle.Parent = toggleFrame

    -- Nút bấm hình tròn độc lập ở góc phải
    toggleBtn.Size = UDim2.new(0, 24, 0, 24)
    toggleBtn.Position = UDim2.new(1, -34, 0.5, -12)
    -- Nếu bật thì hiện màu xanh, tắt thì hiện màu xám tối
    toggleBtn.BackgroundColor3 = state and Color3.fromRGB(0, 210, 255) or Color3.fromRGB(35, 40, 50)
    toggleBtn.Text = ""
    toggleBtn.Parent = toggleFrame

    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(1, 0) -- Bo tròn 100% thành hình tròn vo
    BtnCorner.Parent = toggleBtn

    -- Hàm cập nhật màu sắc khi thay đổi trạng thái
    local function updateVisual()
        if state then
            toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 210, 255) -- Xanh khi bật
        else
            toggleBtn.BackgroundColor3 = Color3.fromRGB(35, 40, 50)  -- Xám tối khi tắt
        end
    end

    -- Khởi tạo đồng bộ màu ngay từ đầu theo defaultState
    updateVisual()

    -- Sự kiện click đổi trạng thái
    toggleBtn.MouseButton1Click:Connect(function()
        state = not state
        updateVisual()
        if callback then pcall(callback, state) end
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
    optionsHolder.BorderSizePixel = 0
    
    -- TỐI ƯU: Tự động co giãn kích thước cuộn chuẩn xác tuyệt đối
    optionsHolder.AutomaticCanvasSize = Enum.AutomaticSize.Y
    optionsHolder.CanvasSize = UDim2.new(0, 0, 0, 0)
    optionsHolder.ScrollBarThickness = 3
    optionsHolder.ScrollingDirection = Enum.ScrollingDirection.Y
    optionsHolder.ZIndex = 10
    optionsHolder.Parent = dropdownFrame

    local HolderCorner = Instance.new("UICorner")
    HolderCorner.CornerRadius = UDim.new(0, 4)
    HolderCorner.Parent = optionsHolder

    UIListLayout.Parent = optionsHolder
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 2) -- Thêm khoảng cách nhỏ giữa các lựa chọn

    local function toggleDropdown()
        isOpened = not isOpened
        optionsHolder.Visible = isOpened
        if isOpened then
            dropdownBtn.Text = tostring(selected) .. " ▲"
            
            -- Lấy chiều cao thực tế của nội dung, giới hạn tối đa 120px để kích hoạt thanh cuộn vuốt xuống
            task.wait() -- Đợi 1 nhịp để layout render chuẩn kích thước
            local contentHeight = UIListLayout.AbsoluteContentSize.Y
            local targetHeight = math.min(contentHeight + 4, 120)
            
            optionsHolder.Size = UDim2.new(1, 0, 0, targetHeight)
            dropdownFrame.Size = UDim2.new(1, -6, 0, 36 + targetHeight + 10)
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
        optBtn.BackgroundTransparency = 0.5
        optBtn.Text = "  " .. tostring(opt) -- Thêm khoảng lùi chữ cho đẹp
        optBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
        optBtn.Font = Enum.Font.Gotham
        optBtn.TextSize = 11
        optBtn.TextXAlignment = Enum.TextXAlignment.Left
        optBtn.ZIndex = 11
        optBtn.Parent = optionsHolder

        local optCorner = Instance.new("UICorner")
        optCorner.CornerRadius = UDim.new(0, 4)
        optCorner.Parent = optBtn

        optBtn.MouseButton1Click:Connect(function()
            selected = opt
            dropdownBtn.Text = tostring(selected) .. " ▼"
            toggleDropdown()
            if callback then pcall(callback, selected) end
        end)
    end

    if callback then pcall(callback, selected) end
end

function TabElements:CreateLabel(parentTabFrame, initialText)
    local labelContainer = Instance.new("Frame")
    labelContainer.Size = UDim2.new(1, -20, 0, 35)
    labelContainer.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    labelContainer.BorderSizePixel = 0
    labelContainer.Parent = parentTabFrame

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = labelContainer

    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, -10, 1, 0)
    textLabel.Position = UDim2.new(0, 10, 0, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.TextColor3 = Color3.fromRGB(240, 240, 240)
    textLabel.TextSize = 14
    textLabel.Font = Enum.Font.GothamMedium
    textLabel.TextXAlignment = Enum.TextXAlignment.Left
    textLabel.Text = initialText or "Label Text"
    textLabel.Parent = labelContainer

    local labelObject = {}
    
    function labelObject:Set(newText)
        textLabel.Text = newText
    end

    function labelObject:Destroy()
        labelContainer:Destroy()
    end

    return labelObject
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
_G.AutoFarmLevelEnabled = false
_G.AutoFarmNearestEnabled = false
_G.FastAttackEnabled = true
_G.AutoFarmMode = "Level"
_G.BringMobEnabled = false
_G.SelectedWeapon = "Melee"
_G.AutoHakiEnabled = true
_G.MaxBringMobs = 4

local FarmHeight = 11 -- Độ cao đứng trên đầu quái khi farm

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
-- 2. HÀM BỔ TRỢ LOGIC FARM (SỬA NOCLIP CHO TẤT CẢ MODE)
-- ==========================================
RunService.Stepped:Connect(function()
    local mode = tostring(_G.AutoFarmMode or ""):lower()
    local isRunning = _G.AutoFarmLevelEnabled or _G.AutoFarmNearestEnabled or string.find(mode, "near") or string.find(mode, "level")
    if not isRunning then return end
    
    local char = LocalPlayer.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if root then root.CanCollide = false end
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

local lastHakiCheck = 0
local function AutoHaki()
    if not _G.AutoHakiEnabled or tick() - lastHakiCheck < 1.5 then return end
    lastHakiCheck = tick()

    local char = LocalPlayer.Character
    if char and char:FindFirstChildOfClass("Humanoid") and char.Humanoid.Health > 0 then
        if not char:FindFirstChild("HasBuso") then
            local CommF = ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("CommF_")
            if CommF then pcall(function() CommF:InvokeServer("Buso") end) end
        end
    end
end

local function AutoEquipWeapon()
    local char = LocalPlayer.Character
    if not char then return end

    local humanoid = char:FindFirstChildOfClass("Humanoid")
    local backpack = LocalPlayer:FindFirstChild("Backpack")
    if not humanoid or not backpack then return end

    local currentTool = char:FindFirstChildOfClass("Tool")
    if currentTool then
        if _G.SelectedWeapon == "Melee" and (currentTool.Name == "Combat" or currentTool:FindFirstChild("Melee")) then return end
        if _G.SelectedWeapon == "Sword" and (currentTool.Name ~= "Combat" and currentTool:FindFirstChild("EquipEvent")) then return end
    end

    for _, tool in ipairs(backpack:GetChildren()) do
        if tool:IsA("Tool") then
            local isTarget = false
            if _G.SelectedWeapon == "Melee" and tool.Name == "Combat" then
                isTarget = true
            elseif _G.SelectedWeapon == "Sword" and tool.Name ~= "Combat" then
                isTarget = true
            end

            if isTarget then
                humanoid:EquipTool(tool)
                break
            end
        end
    end
end

local lastBring = 0
local function BringMobs(targetCF, currentData)
    if not _G.BringMobEnabled or not targetCF or not currentData or tick() - lastBring < 0.2 then return end
    lastBring = tick()

    local EnemiesFolder = Workspace:FindFirstChild("Enemies")
    if not EnemiesFolder then return end

    local maxMobs = _G.MaxBringMobs or 3
    local broughtCount = 0

    for _, enemy in ipairs(EnemiesFolder:GetChildren()) do
        if enemy.Name == currentData.EnemyName then
            local eHum = enemy:FindFirstChildOfClass("Humanoid")
            local eRoot = enemy:FindFirstChild("HumanoidRootPart")

            if eHum and eRoot and eHum.Health > 0 then
                local dist = (eRoot.Position - targetCF.Position).Magnitude
                if dist <= 150 and dist > 4 then
                    eRoot.CanCollide = false
                    eRoot.AssemblyLinearVelocity = Vector3.zero
                    eRoot.CFrame = targetCF
                    
                    broughtCount = broughtCount + 1
                    if broughtCount >= maxMobs then break end
                end
            end
        end
    end
end

-- Biến tốc độ mặc định ban đầu (phòng hờ chưa bấm dropdown)
local FastAttackSpeed = 10 
local lastAttack = 0

local function DoFastAttack(Net, hitTargets)
    if not _G.FastAttackEnabled or #hitTargets == 0 or not Net then return end

    -- Tính khoảng cooldown dựa theo tốc độ từ Dropdown (Fast = nhỏ nhất -> đánh nhanh nhất)
    local cooldown = 0.2 / FastAttackSpeed
    if tick() - lastAttack < cooldown then return end
    lastAttack = tick()

    local registerAttack = Net:FindFirstChild("RE/RegisterAttack")
    local registerHit = Net:FindFirstChild("RE/RegisterHit")

    if registerAttack then
        pcall(function()
            registerAttack:FireServer(0.1)
        end)
    end

    if registerHit then
        pcall(function()
            for i = 1, #hitTargets do
                local part = hitTargets[i]
                if part and part.Parent then
                    local args = {
                        [1] = part,
                        [2] = {},
                        [4] = "15822e18"
                    }
                    registerHit:FireServer(unpack(args))
                end
            end
        end)
    end
end

local function GetNearestEnemy()
    local nearest = nil
    local minDist = math.huge
    local char = LocalPlayer.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not root then return nil end

    local enemiesFolder = Workspace:FindFirstChild("Enemies")
    if enemiesFolder then
        for _, enemy in ipairs(enemiesFolder:GetChildren()) do
            local eHum = enemy:FindFirstChildOfClass("Humanoid")
            local eRoot = enemy:FindFirstChild("HumanoidRootPart")
            if eHum and eHum.Health > 0 and eRoot then
                local dist = (eRoot.Position - root.Position).Magnitude
                if dist < minDist then
                    minDist = dist
                    nearest = enemy
                end
            end
        end
    end
    return nearest
end

-- ==========================================
-- 3. LUỒNG FARM CHÍNH (MAIN TASK)
-- ==========================================
task.spawn(function()
    local CommF = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommF_")
    local Net = ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Net")

    local function getPlayerLevel()
        local data = LocalPlayer:FindFirstChild("Data")
        return (data and data:FindFirstChild("Level")) and data.Level.Value or 1
    end

    local lastQuestCheck = 0
    local isQuestActiveCache = false
    local function checkQuestActive()
        if tick() - lastQuestCheck > 0.4 then
            lastQuestCheck = tick()
            local questGui = LocalPlayer.PlayerGui:FindFirstChild("Main") and LocalPlayer.PlayerGui.Main:FindFirstChild("Quest")
            isQuestActiveCache = questGui and questGui.Visible or false
        end
        return isQuestActiveCache
    end

    while true do
        task.wait(0.05)

        local isRunning = _G.AutoFarmLevelEnabled == true
        local mode = tostring(_G.AutoFarmMode or ""):lower()

        local isNearMode = isRunning and (mode == "nearest" or mode == "near" or _G.AutoFarmNearestEnabled == true)
        local isLevelMode = isRunning and (mode == "level" or mode == "farm level")

        local Character = LocalPlayer.Character
        local RootPart = Character and Character:FindFirstChild("HumanoidRootPart")
        local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")

        if Character and RootPart and Humanoid and Humanoid.Health > 0 then
            
            -- ==========================================
            -- 1. CHẾ ĐỘ FARM QUÁI GẦN NHẤT (KHÔNG QUEST)
            -- ==========================================
            if isNearMode then
                local targetEnemy = GetNearestEnemy()

                if targetEnemy then
                    local enemyName = targetEnemy.Name
                    local eRoot = targetEnemy:FindFirstChild("HumanoidRootPart")
                    local eHum = targetEnemy:FindFirstChildOfClass("Humanoid")

                    if eRoot and eHum and eHum.Health > 0 then
                        if (eRoot.Position - RootPart.Position).Magnitude > 60 then
                            pcall(function() smoothMoveTo(eRoot.CFrame * CFrame.new(0, FarmHeight, 0)) end)
                        end

                        RootPart.AssemblyLinearVelocity = Vector3.zero
                        RootPart.CanCollide = false
                        RootPart.CFrame = eRoot.CFrame * CFrame.new(0, FarmHeight, 0)

                        local hitTargets = {}
                        local EnemiesFolder = Workspace:FindFirstChild("Enemies")
                        if EnemiesFolder then
                            for _, enemy in ipairs(EnemiesFolder:GetChildren()) do
                                if enemy.Name == enemyName then
                                    local subHum = enemy:FindFirstChildOfClass("Humanoid")
                                    local subRoot = enemy:FindFirstChild("HumanoidRootPart")
                                    if subHum and subHum.Health > 0 and subRoot then
                                        if (subRoot.Position - RootPart.Position).Magnitude <= 60 then
                                            table.insert(hitTargets, enemy:FindFirstChild("Head") or subRoot)
                                        end
                                    end
                                end
                            end
                        end

                        AutoHaki()
                        AutoEquipWeapon()

                        if _G.BringMobEnabled then
                            BringMobs(eRoot.CFrame, {EnemyName = enemyName})
                        end

                        DoFastAttack(Net, hitTargets)
                    end
                else
                    task.wait(0.2)
                end

            -- ==========================================
            -- 2. CHẾ ĐỘ FARM THEO LEVEL (CÓ NHẬN QUEST)
            -- ==========================================
            elseif isLevelMode then
                local currentLevel = getPlayerLevel()
                local currentData = nil

                for _, q in ipairs(QuestDatabase) do
                    if currentLevel >= q.MinLevel and currentLevel <= q.MaxLevel then
                        currentData = q
                        break
                    end
                end

                if currentData then
                    local npcPos = NpcPositions[currentData.Island]
                    local enemySpot = EnemyPositions[currentData.EnemyName]

                    if not checkQuestActive() then
                        if npcPos then
                            pcall(function() smoothMoveTo(npcPos) end)
                            local npcVector = (typeof(npcPos) == "CFrame" and npcPos.Position or npcPos)
                            local startWait = tick()
                            repeat
                                task.wait(0.1)
                                local curChar = LocalPlayer.Character
                                local curRoot = curChar and curChar:FindFirstChild("HumanoidRootPart")
                                if curRoot and (curRoot.Position - npcVector).Magnitude < 30 then break end
                            until tick() - startWait > 8
                        end

                        if CommF then
                            pcall(function()
                                CommF:InvokeServer("StartQuest", currentData.QuestName, currentData.QuestNumber)
                            end)
                            task.wait(0.3)
                        end
                    end

                    if enemySpot then
                        pcall(function() smoothMoveTo(enemySpot * CFrame.new(0, FarmHeight, 0)) end)
                    end

                    local farmDuration = tick()
                    while _G.AutoFarmLevelEnabled do
                        task.wait(0.04)

                        local checkMode = tostring(_G.AutoFarmMode or ""):lower()
                        if string.find(checkMode, "near") or _G.AutoFarmNearestEnabled then break end

                        if tick() - farmDuration > 35 then break end

                        local curChar = LocalPlayer.Character
                        local curRoot = curChar and curChar:FindFirstChild("HumanoidRootPart")
                        local curHum = curChar and curChar:FindFirstChildOfClass("Humanoid")

                        if not curChar or not curRoot or not curHum or curHum.Health <= 0 or not checkQuestActive() then
                            break
                        end

                        curRoot.AssemblyLinearVelocity = Vector3.zero
                        curRoot.CanCollide = false

                        local EnemiesFolder = Workspace:FindFirstChild("Enemies")
                        local targetEnemyRoot = nil
                        local minDist = 9999
                        local hitTargets = {}

                        if EnemiesFolder then
                            local targetName = currentData.EnemyName
                            for _, enemy in ipairs(EnemiesFolder:GetChildren()) do
                                if enemy.Name == targetName then
                                    local eHum = enemy:FindFirstChildOfClass("Humanoid")
                                    local eRoot = enemy:FindFirstChild("HumanoidRootPart")
                                    if eHum and eHum.Health > 0 and eRoot then
                                        local dist = (eRoot.Position - curRoot.Position).Magnitude
                                        if dist < minDist then
                                            minDist = dist
                                            targetEnemyRoot = eRoot
                                        end
                                        if dist <= 60 then
                                            table.insert(hitTargets, enemy:FindFirstChild("Head") or eRoot)
                                        end
                                    end
                                end
                            end
                        end

if targetEnemyRoot and targetEnemyRoot.Parent then
    farmDuration = tick()
    
    pcall(AutoHaki)
    pcall(AutoEquipWeapon)

    if _G.BringMobEnabled then
        pcall(function()
            BringMobs(targetEnemyRoot.CFrame, currentData)
        end)
    end

    curRoot.CFrame = targetEnemyRoot.CFrame * CFrame.new(0, FarmHeight, 0)
    pcall(function()
        DoFastAttack(Net, hitTargets)
    end)
else
    if enemySpot then
        curRoot.CFrame = enemySpot * CFrame.new(0, FarmHeight, 0)
    end
    task.wait(0.1)
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
-- HÀM AUTO STATS (CỘNG ĐIỂM CHUẨN XÁC)
-- ==========================================
local AutoStatsEnabled = false -- Biến bật tắt auto stats (cậu có thể tạo toggle cho nó)
local SelectedStatsTable = {"Melee", "Defense", "Sword"} -- Các chỉ số muốn ưu tiên cộng

task.spawn(function()
    local CommF = ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("CommF_")
    
    while true do
        task.wait(1) -- Kiểm tra mỗi 1 giây để tránh spam quá tải server
        
        if AutoStatsEnabled and CommF then
            -- Lấy số điểm stat hiện tại còn dư của nhân vật
            local playerStats = LocalPlayer:FindFirstChild("Data") and LocalPlayer.Data:FindFirstChild("Points")
            
            if playerStats and playerStats.Value > 0 then
                -- Lặp qua các chỉ số người chơi muốn cộng
                for _, statName in ipairs(SelectedStatsTable) do
                    if playerStats.Value > 0 then
                        pcall(function()
                            -- Gọi Remote Event CommF_ để cộng điểm (Thường là truyền tên stat và số lượng điểm muốn cộng, ví dụ 1 hoặc 3)
                            CommF:InvokeServer("AddPoint", statName, 1)
                        end)
                        task.wait(0.1)
                    else
                        break
                    end
                end
            end
        end
    end
end)

-- ==========================================
-- BIẾN & HÀM XỬ LÝ PVP / AUTO BOUNTY
-- ==========================================
local Players = game:GetService("Players")
local VirtualInputManager = game:GetService("VirtualInputManager")
local Workspace = game:GetService("Workspace")

_G.SelectedPlayer = ""
_G.AimbotPlayerEnabled = false
_G.AutoSkillMeleeEnabled = false
_G.AutoSkillFruitEnabled = false
_G.SelectedMeleeSkill = "Z-X-C"
_G.SelectedFruitSkill = "Z-X-C-V"
_G.AutoBountyEnabled = false
_G.VirtualAttackPlayerEnabled = false

-- Hàm lấy danh sách Player trong Server
local function GetPlayerList()
    local list = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            table.insert(list, p.Name)
        end
    end
    return list
end

-- Hàm bấm phím skill giả lập
local function PressKey(key)
    pcall(function()
        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode[key], false, game)
        task.wait(0.1)
        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode[key], false, game)
    end)
end

-- Hàm equip đúng loại vũ khí theo ToolType
local function EquipWeaponType(weaponType)
    local char = LocalPlayer.Character
    local backpack = LocalPlayer:FindFirstChild("Backpack")
    if not char or not backpack then return end

    for _, tool in ipairs(backpack:GetChildren()) do
        if tool:IsA("Tool") and tool:FindFirstChild("ToolTip") then
            if tool.ToolTip == weaponType then
                char.Humanoid:EquipTool(tool)
                break
            end
        end
    end
end

-- 1. Aimbot Lock Camera vào Player được chọn
task.spawn(function()
    while task.wait() do
        if _G.AimbotPlayerEnabled and _G.SelectedPlayer ~= "" then
            local target = Players:FindFirstChild(_G.SelectedPlayer)
            if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                local targetPos = target.Character.HumanoidRootPart.Position
                Workspace.CurrentCamera.CFrame = CFrame.new(Workspace.CurrentCamera.CFrame.Position, targetPos)
            end
        end
    end
end)

-- 2. Vòng lặp Auto Skill & Auto Bounty Target
-- Vòng lặp Auto Skill & Auto Bounty Target (Đã sửa sang BAY)
-- Hàm tìm Target hợp lệ (Ưu tiên người đã chọn trong Dropdown, nếu không có sẽ tự tìm người gần nhất)
local function GetAutoBountyTarget()
    if _G.SelectedPlayer and _G.SelectedPlayer ~= "" then
        local p = Players:FindFirstChild(_G.SelectedPlayer)
        if p and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local hum = p.Character:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health > 0 then return p end
        end
    end

    -- Tự động tìm người chơi sống gần nhất trong Server
    local nearest = nil
    local minDist = math.huge
    local myChar = LocalPlayer.Character
    local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")

    if myRoot then
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local hum = p.Character:FindFirstChildOfClass("Humanoid")
                if hum and hum.Health > 0 then
                    local dist = (p.Character.HumanoidRootPart.Position - myRoot.Position).Magnitude
                    if dist < minDist then
                        minDist = dist
                        nearest = p
                    end
                end
            end
        end
    end
    return nearest
end

-- Hàm Equip vũ khí cải tiến (Không lo trượt tên)
local function SmartEquipWeapon(wType)
    local char = LocalPlayer.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    local bp = LocalPlayer:FindFirstChild("Backpack")
    if not hum or not bp then return end

    local equipped = char:FindFirstChildOfClass("Tool")
    if equipped then
        if wType == "Melee" and (equipped:FindFirstChild("Melee") or equipped.ToolTip == "Melee" or equipped.Name == "Combat") then return end
        if wType == "Fruit" and (equipped:FindFirstChild("Fruit") or equipped.ToolTip == "Blox Fruit" or string.find(equipped.Name, "Fruit")) then return end
    end

    for _, t in ipairs(bp:GetChildren()) do
        if t:IsA("Tool") then
            local isMatch = false
            if wType == "Melee" and (t:FindFirstChild("Melee") or t.ToolTip == "Melee" or t.Name == "Combat") then
                isMatch = true
            elseif wType == "Fruit" and (t:FindFirstChild("Fruit") or t.ToolTip == "Blox Fruit" or string.find(t.Name, "Fruit")) then
                isMatch = true
            end

            if isMatch then
                hum:EquipTool(t)
                break
            end
        end
    end
end

-- Vòng lặp Auto Bounty & Skill không bị nghẽn
local isMovingToTarget = false

-- ==========================================
-- HÀM BAY THẲNG ĐẾN PLAYER (KHÔNG BAY LÊN TRỜI)
-- ==========================================
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local currentTween = nil

local function DirectFlyToPlayer(targetCF, speed)
    local char = LocalPlayer.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not root then return end

    speed = speed or 250 -- Tốc độ bay
    local dist = (root.Position - targetCF.Position).Magnitude
    local timeToFly = dist / speed

    -- Tắt va chạm và triệt tiêu trọng lực khi bay
    root.CanCollide = false
    root.AssemblyLinearVelocity = Vector3.zero

    -- Nếu ở quá xa thì dùng Tween bay thẳng theo đường chim bay (không tăng độ cao Y)
    if dist > 8 then
        if currentTween then currentTween:Cancel() end

        local tweenInfo = TweenInfo.new(timeToFly, Enum.EasingStyle.Linear)
        currentTween = TweenService:Create(root, tweenInfo, {CFrame = targetCF})
        currentTween:Play()
    else
        -- Khi đã áp sát thì dán vị trí trực tiếp
        if currentTween then currentTween:Cancel() end
        root.CFrame = targetCF
    end
end

-- ==========================================
-- PHẦN 1: AUTO BOUNTY & XẢ SKILL TỰ ĐỘNG
-- ==========================================
task.spawn(function()
    local lastChar = nil
    local currentTarget = nil
    local attackStartTime = 0
    local lastHealth = 0
    
    while task.wait(0.05) do
        if _G.AutoBountyEnabled then
            AutoHaki()

            local myChar = LocalPlayer.Character
            local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
            local myHum = myChar and myChar:FindFirstChildOfClass("Humanoid")

            if myChar and myChar ~= lastChar then
                lastChar = myChar
                task.wait(1)
                pcall(function()
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EnablePvp")
                end)
            end

            if myChar and myRoot and myHum and myHum.Health > 0 then
                local targetPlayer = type(GetAutoBountyTarget) == "function" and GetAutoBountyTarget() or nil

                if not currentTarget or not currentTarget.Parent or not currentTarget.Character then
                    currentTarget = targetPlayer
                    attackStartTime = tick()
                    if currentTarget and currentTarget.Character then
                        local tHum = currentTarget.Character:FindFirstChildOfClass("Humanoid")
                        lastHealth = tHum and tHum.Health or 0
                    end
                end

                if currentTarget and currentTarget.Character then
                    local tRoot = currentTarget.Character:FindFirstChild("HumanoidRootPart")
                    local tHum = currentTarget.Character:FindFirstChildOfClass("Humanoid")

                    if tRoot and tHum and tHum.Health > 0 then
                        if tick() - attackStartTime >= 10 then
                            if tHum.Health >= lastHealth then
                                currentTarget = nil
                                continue
                            else
                                attackStartTime = tick()
                                lastHealth = tHum.Health
                            end
                        end

                        local targetCF = tRoot.CFrame * CFrame.new(0, 2, 2)
                        if type(DirectFlyToPlayer) == "function" then
                            DirectFlyToPlayer(targetCF, 300)
                        end

                        if _G.AutoSkillMeleeEnabled and type(SmartEquipWeapon) == "function" and type(PressKey) == "function" then
                            SmartEquipWeapon("Melee")
                            local mSkill = _G.SelectedSelectedMeleeSkill or _G.SelectedMeleeSkill or ""
                            if string.find(mSkill, "Z") then PressKey("Z") end
                            if string.find(mSkill, "X") then PressKey("X") end
                            if string.find(mSkill, "C") then PressKey("C") end
                        end

                        if _G.AutoSkillFruitEnabled and type(SmartEquipWeapon) == "function" and type(PressKey) == "function" then
                            SmartEquipWeapon("Fruit")
                            local fSkill = _G.SelectedFruitSkill or ""
                            if string.find(fSkill, "Z") then PressKey("Z") end
                            if string.find(fSkill, "X") then PressKey("X") end
                            if string.find(fSkill, "C") then PressKey("C") end
                            if string.find(fSkill, "V") then PressKey("V") end
                        end
                    else
                        currentTarget = nil
                    end
                else
                    currentTarget = nil
                end
            end
        else
            currentTarget = nil
        end
    end
end)

-- ==========================================
-- NÚT NỔI KHẨN CẤP (TỰ ĐỘNG TẮT CẢ BIẾN VÀ TOGGLE UI)
-- ==========================================
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")

-- Xóa nút cũ nếu có
if CoreGui:FindFirstChild("EmergencyStopButton") then
    CoreGui.EmergencyStopButton:Destroy()
end

-- Tạo ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "EmergencyStopButton"
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = CoreGui

-- Tạo nút bấm màu đỏ (Ban đầu ẩn đi)
local stopButton = Instance.new("TextButton")
stopButton.Name = "StopButton"
stopButton.Size = UDim2.new(0, 130, 0, 45)
stopButton.Position = UDim2.new(0.5, -65, 0.85, 0)
local okBg = Color3.fromRGB(230, 50, 50)
stopButton.BackgroundColor3 = okBg
stopButton.Text = "STOP ATTACK PLAYER 🛑"
stopButton.TextColor3 = Color3.fromRGB(255, 255, 255)
stopButton.TextSize = 14
stopButton.Font = Enum.Font.GothamBold
stopButton.Visible = false -- Mặc định ẩn
stopButton.Parent = screenGui

-- Bo góc & viền cho đẹp
local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 10)
uiCorner.Parent = stopButton

local uiStroke = Instance.new("UIStroke")
uiStroke.Color = Color3.fromRGB(255, 255, 255)
uiStroke.Thickness = 2
uiStroke.Parent = stopButton

-- Khi bấm vào nút thì tắt auto attack, tắt toggle trên UI và tự ẩn nút đi
stopButton.MouseButton1Click:Connect(function()
    _G.VirtualAttackPlayerEnabled = false
    stopButton.Visible = false
    
    -- Đồng bộ tắt luôn Toggle trên Menu UI (nếu cậu có gán biến cho toggle, ví dụ: VirtualAttackToggle)
    if VirtualAttackToggle and type(VirtualAttackToggle.Set) == "function" then
        VirtualAttackToggle:Set(false)
    elseif VirtualAttackToggle and type(VirtualAttackToggle.SetValue) == "function" then
        VirtualAttackToggle:SetValue(false)
    end
end)

-- Vòng lặp kiểm tra trạng thái để tự động Hiện/Ẩn nút
task.spawn(function()
    while true do
        task.wait(0.2)
        if _G.VirtualAttackPlayerEnabled then
            stopButton.Visible = true -- Bật auto thì nút hiện ra
        else
            stopButton.Visible = false -- Tắt auto thì nút biến mất
        end
    end
end)

task.spawn(function()
    local VirtualInputManager = game:GetService("VirtualInputManager")
    local Players = game:GetService("Players")
    local localPlayer = Players.LocalPlayer
    local camera = workspace.CurrentCamera

    while true do
        task.wait() -- Chạy nhanh hết mức có thể từng frame một
        pcall(function()
            if _G.VirtualAttackPlayerEnabled then
                local myChar = localPlayer.Character
                local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
                local myHum = myChar and myChar:FindFirstChildOfClass("Humanoid")
                
                if myChar and myRoot and myHum and myHum.Health > 0 then
                    -- 1. Tự động tìm và cầm vũ khí nếu chưa cầm
                    local currentTool = myChar:FindFirstChildOfClass("Tool")
                    if not currentTool then
                        local backpack = localPlayer:FindFirstChildOfClass("Backpack")
                        if backpack then
                            local firstTool = backpack:FindFirstChildOfClass("Tool")
                            if firstTool then
                                myHum:EquipTool(firstTool)
                            end
                        end
                    end

                    -- 2. Quét mục tiêu gần nhất trong server để tẩn ngay lập tức
                    local nearestTarget = nil
                    local shortestDistance = math.huge
                    
                    for _, p in ipairs(Players:GetPlayers()) do
                        if p ~= localPlayer and p.Character then
                            local tRoot = p.Character:FindFirstChild("HumanoidRootPart")
                            local tHum = p.Character:FindFirstChildOfClass("Humanoid")
                            if tRoot and tHum and tHum.Health > 0 then
                                local dist = (myRoot.Position - tRoot.Position).Magnitude
                                if dist < shortestDistance then
                                    shortestDistance = dist
                                    nearestTarget = p
                                end
                            end
                        end
                    end

                    -- 3. Nếu thấy mục tiêu thì khóa góc nhìn, xoay mặt và spam click siêu tốc
                    if nearestTarget and nearestTarget.Character then
                        local tRoot = nearestTarget.Character:FindFirstChild("HumanoidRootPart")
                        if tRoot then
                            myRoot.CFrame = CFrame.new(myRoot.Position, Vector3.new(tRoot.Position.X, myRoot.Position.Y, tRoot.Position.Z))
                            
                            -- Spam click liên tục tại tâm màn hình để đánh bét nhè không kịp thở
                            local viewportSize = camera.ViewportSize
                            local cx, cy = viewportSize.X / 2, viewportSize.Y / 2
                            
                            VirtualInputManager:SendMouseButtonEvent(cx, cy, 0, true, game, 0)
                            VirtualInputManager:SendMouseButtonEvent(cx, cy, 0, false, game, 0)
                        end
                    end
                end
            end
        end)
    end
end)

task.spawn(function()
    local lastUpdate = 0

    RunService.RenderStepped:Connect(function(dt)
        if tick() - lastUpdate < 1 then return end
        lastUpdate = tick()

        pcall(function()
            -- 1. FPS & Ping
            local fps = math.floor(1 / dt)
            FpsLabel:Set("⚡ FPS: " .. fps)
            
            local ping = math.floor(LocalPlayer.NetworkPing * 1000)
            PingLabel:Set("📡 Ping: " .. ping .. " ms")

            -- 2. Trăng (Moon)
            local clockTime = Lighting.ClockTime
            if clockTime < 6 or clockTime > 18 then
                MoonLabel:Set("🌕 Trăng: Đang ban đêm")
            else
                MoonLabel:Set("🌕 Trăng: Đang ban ngày ☀️")
            end

            -- 3. Đảo bí ẩn (Mirage Island)
            local foundMirage = false
            for _, obj in ipairs(Workspace:GetChildren()) do
                if obj.Name == "Mirage Island" or obj.Name:lower():find("mirage") then
                    foundMirage = true
                    break
                end
            end

            if foundMirage then
                MirageLabel:Set("🏝️ Đảo Bí Ẩn (Mirage): 🟢 XUẤT HIỆN RỒI!")
            else
                MirageLabel:Set("🏝️ Đảo Bí Ẩn (Mirage): 🔴 Không có trong Server")
            end
        end)
    end)
end)

-- ====================================================================
-- GIAO DIỆN UI
-- ====================================================================
local Window = Library:CreateWindow("ABYSSAL HUB")
local MainTab = Window:CreateTab("Farming Tab")
local SettingTab = Window:CreateTab("Farm settings")
local PlayerTab = Window:CreateTab("Player")
local TeleportTab = Window:CreateTab("Teleport (Sea1)")
local AutoTab = Window:CreateTab("Auto stats")
local PvpTab = Window:CreateTab("Player & PVP")

MainTab:CreateDropdown("Farming mode", {"Level", "Nearest"}, "Level", function(selected)
    _G.AutoFarmMode = selected
end)

MainTab:CreateToggle("Auto Farm", false, function(state)
    _G.AutoFarmLevelEnabled = state
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
    _G.FastAttackEnabled = state
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

SettingTab:CreateBox("Number of mobs to gather", "4 is max", function(value)
    local num = tonumber(value)
    if num and num > 0 then
        _G.MaxBringMobs = num
    end
end)

SettingTab:CreateToggle("Bring Mobs(It's currently experiencing an error.)", false, function(state)
    _G.BringMobEnabled = state
end)

local chosenStatToUpgrade = "Melee" -- Biến lưu lựa chọn từ dropdown

-- 1. Dropdown để đổi hướng chọn stat
AutoTab:CreateDropdown("Select Stats to Boost", {"Melee", "Defense", "Sword", "Demon Fruit", "Gun"}, "Melee", function(selected)
    chosenStatToUpgrade = selected
end)

-- 2. Button để thực hiện lệnh cộng điểm theo cái vừa chọn
AutoTab:CreateButton("Add Selected Points", function()
    local CommF = ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("CommF_")
    local playerStats = LocalPlayer:FindFirstChild("Data") and LocalPlayer.Data:FindFirstChild("Points")
    
    if CommF and playerStats and playerStats.Value > 0 then
        -- Gọi server cộng điểm vào đúng cái môn đang chọn trong dropdown (cộng toàn bộ số điểm dư)
        CommF:InvokeServer("AddPoint", chosenStatToUpgrade, playerStats.Value)
        print("Đã cộng toàn bộ điểm vào: " .. chosenStatToUpgrade)
    else
        print("Không có điểm dư để cộng!")
    end
end)

SettingTab:CreateToggle("Auto Haki", true, function(state)
    _G.AutoHakiEnabled = state
end)

-- Chọn Player & Refresh Danh Sách
local PlayerDropdown = PvpTab:CreateDropdown("Select Player", GetPlayerList(), "", function(selected)
    _G.SelectedPlayer = selected
end)

PvpTab:CreateButton("Refresh Player List", function()
    local updatedList = GetPlayerList()
    PlayerDropdown:Refresh(updatedList)
end)

PvpTab:CreateButton("Teleport to Target", function()
    if _G.SelectedPlayer ~= "" then
        local target = Players:FindFirstChild(_G.SelectedPlayer)
        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            local targetCF = target.Character.HumanoidRootPart.CFrame * CFrame.new(0, 2, 2)
            DirectFlyToPlayer(targetCF, 300)
        end
    end
end)

-- Aimbot & Target Farm
PvpTab:CreateToggle("Aimbot Player (Skill Lock)", false, function(state)
    _G.AimbotPlayerEnabled = state
end)

PvpTab:CreateToggle("Auto Farm Bounty Target", false, function(state)
    _G.AutoBountyEnabled = state
end)

-- Cấu hình Skill Võ & Trái
PvpTab:CreateDropdown("Melee Skill Select", {"Z", "X", "C", "Z-X-C"}, "Z-X-C", function(selected)
    _G.SelectedMeleeSkill = selected
end)

PvpTab:CreateToggle("Auto Skill Melee (Võ)", false, function(state)
    _G.AutoSkillMeleeEnabled = state
end)

PvpTab:CreateDropdown("Fruit Skill Select", {"Z", "X", "C", "V", "Z-X-C-V"}, "Z-X-C-V", function(selected)
    _G.SelectedFruitSkill = selected
end)

PvpTab:CreateToggle("Auto Skill Fruit (Trái)", false, function(state)
    _G.AutoSkillFruitEnabled = state
end)

PvpTab:CreateToggle("Auto Attack Selected Player", false, function(state)
    _G.VirtualAttackPlayerEnabled = state
end)

PingLabel = StatsTab:CreateLabel("📡 Ping: Đang tải...", false, function(state) end)
FpsLabel = StatsTab:CreateLabel("⚡ FPS: Đang tải...", false, function(state) end)
MoonLabel = StatsTab:CreateLabel("🌕 Trăng (Moon): Đang quét...", false, function(state) end)
MirageLabel = StatsTab:CreateLabel("🏝️ Đảo Bí Ẩn (Mirage): Không thấy", false, function(state) end)
