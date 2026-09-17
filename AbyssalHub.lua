local rawKey = _G.Key or ""
local userKey = string.gsub(rawKey, "%s+", "")
local userHWID = game:GetService("RbxAnalyticsService"):GetClientId()

local ngrokUrl = "https://nonsuppositively-unmasticatory-drew.ngrok-free.dev"

if userKey == "" then
    game.Players.LocalPlayer:Kick("\n[ABYSSAL HUB]\nKey not entered! Please set _G.Key before running.")
    return -- Dừng hẳn, không chạy tiếp!
end

local function trim(s)
    return (s:gsub("^%s*(.-)%s*$", "%1"))
end

local antiCache = tostring(os.time())
local checkUrl = ngrokUrl .. "/check?key=" .. tostring(userKey) .. "&hwid=" .. tostring(userHWID) .. "&t=" .. antiCache

local response = nil
local reqFunc = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request

if reqFunc then
    local success, res = pcall(function()
        return reqFunc({
            Url = checkUrl,
            Method = "GET",
            Headers = {
                ["ngrok-skip-browser-warning"] = "true",
                ["User-Agent"] = "RobloxApp"
            }
        })
    end)
    if success and res and res.Body then response = res.Body end
else
    local success, body = pcall(function() return game:HttpGet(checkUrl) end)
    if success then response = body end
end

if not response then
    game.Players.LocalPlayer:Kick("\n[ABYSSAL HUB]\nCannot connect to Server because it is down!")
    return -- Dừng hẳn, không chạy tiếp!
end

local cleanResponse = string.upper(trim(response))

if cleanResponse == "SUCCESS" then
    print("-> Abyssal Key Verified Successfully!")
    -- Ở đây code UI và logic chính của cậu sẽ được phép chạy tiếp bên dưới này
elseif cleanResponse == "BLACKLISTED" then
    game.Players.LocalPlayer:Kick("\n[ABYSSAL HUB]\nYour Key or HWID has been Blacklisted!")
    return
elseif cleanResponse == "HWID_MISMATCH" then
    game.Players.LocalPlayer:Kick("\n[ABYSSAL HUB]\nThis Key is being used on another device!")
    return
elseif cleanResponse == "EXPIRED" then
    game.Players.LocalPlayer:Kick("\n[ABYSSAL HUB]\nYour Key has expired!")
    return
elseif cleanResponse == "INVALID_KEY" then
    game.Players.LocalPlayer:Kick("\n[ABYSSAL HUB]\nKey does not exist!")
    return
else
    game.Players.LocalPlayer:Kick("\n[ABYSSAL HUB]\nUnknown response: " .. cleanResponse)
    return
end

-- ====================================================================
-- 1. LIBRARY GIAO DIỆN (UI FRAMEWORK)
-- ====================================================================
local Library = {}
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

function Library:CreateWindow(hubName)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "AbyssalHubUI"
    ScreenGui.Parent = CoreGui
    ScreenGui.ResetOnSpawn = false

    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.Position = UDim2.new(0.3, 0, 0.22, 0)
    MainFrame.Size = UDim2.new(0, 560, 0, 380)
    MainFrame.BackgroundColor3 = Color3.fromRGB(11, 15, 20)
    MainFrame.BorderSizePixel = 0
    MainFrame.ClipsDescendants = true

    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 12)
    MainCorner.Parent = MainFrame

    local MainStroke = Instance.new("UIStroke")
    MainStroke.Color = Color3.fromRGB(35, 48, 68)
    MainStroke.Thickness = 1.3
    MainStroke.Parent = MainFrame

    -- Kéo thả UI chính
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
    Topbar.Size = UDim2.new(1, 0, 0, 46)
    Topbar.BackgroundColor3 = Color3.fromRGB(16, 22, 30)
    Topbar.BorderSizePixel = 0

    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Parent = Topbar
    Title.Position = UDim2.new(0, 18, 0, 0)
    Title.Size = UDim2.new(0, 350, 1, 0)
    Title.Text = (hubName or "ABYSSAL HUB") .. "  <font size='12' color='rgb(100, 116, 139)'>by Ocean Ray</font>"
    Title.RichText = true
    Title.TextColor3 = Color3.fromRGB(0, 220, 255)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 14
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.BackgroundTransparency = 1

    local ActionContainer = Instance.new("Frame")
    ActionContainer.Parent = Topbar
    ActionContainer.AnchorPoint = Vector2.new(1, 0.5)
    ActionContainer.Position = UDim2.new(1, -14, 0.5, 0)
    ActionContainer.Size = UDim2.new(0, 64, 0, 28)
    ActionContainer.BackgroundTransparency = 1

    local ActionLayout = Instance.new("UIListLayout")
    ActionLayout.Parent = ActionContainer
    ActionLayout.FillDirection = Enum.FillDirection.Horizontal
    ActionLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
    ActionLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    ActionLayout.Padding = UDim.new(0, 6)

    local isMaximized = false
    local normalSize = MainFrame.Size
    local normalPos = MainFrame.Position

    local MinimizeBtn = Instance.new("TextButton")
    MinimizeBtn.Name = "MinimizeBtn"
    MinimizeBtn.Parent = ActionContainer
    MinimizeBtn.Size = UDim2.new(0, 28, 0, 28)
    MinimizeBtn.BackgroundColor3 = Color3.fromRGB(24, 32, 44)
    MinimizeBtn.Text = "-"
    MinimizeBtn.TextColor3 = Color3.fromRGB(180, 190, 205)
    MinimizeBtn.Font = Enum.Font.GothamBold
    MinimizeBtn.TextSize = 15
    MinimizeBtn.AutoButtonColor = false

    local MinCorner = Instance.new("UICorner")
    MinCorner.CornerRadius = UDim.new(0, 6)
    MinCorner.Parent = MinimizeBtn

    local MaximizeBtn = Instance.new("TextButton")
    MaximizeBtn.Name = "MaximizeBtn"
    MaximizeBtn.Parent = ActionContainer
    MaximizeBtn.Size = UDim2.new(0, 28, 0, 28)
    MaximizeBtn.BackgroundColor3 = Color3.fromRGB(24, 32, 44)
    MaximizeBtn.Text = "▢"
    MaximizeBtn.TextColor3 = Color3.fromRGB(180, 190, 205)
    MaximizeBtn.Font = Enum.Font.GothamBold
    MaximizeBtn.TextSize = 12
    MaximizeBtn.AutoButtonColor = false

    local MaxCorner = Instance.new("UICorner")
    MaxCorner.CornerRadius = UDim.new(0, 6)
    MaxCorner.Parent = MaximizeBtn

    MaximizeBtn.MouseButton1Click:Connect(function()
        isMaximized = not isMaximized
        local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
        if isMaximized then
            normalSize = MainFrame.Size
            normalPos = MainFrame.Position
            MaximizeBtn.Text = "❐"
            TweenService:Create(MainFrame, tweenInfo, {
                Size = UDim2.new(0, 720, 0, 500),
                Position = UDim2.new(0.5, -360, 0.5, -250)
            }):Play()
        else
            MaximizeBtn.Text = "▢"
            TweenService:Create(MainFrame, tweenInfo, {
                Size = normalSize,
                Position = normalPos
            }):Play()
        end
    end)

    MinimizeBtn.MouseButton1Click:Connect(function()
        ScreenGui.Enabled = false
    end)

    local TabContainer = Instance.new("ScrollingFrame")
    TabContainer.Name = "TabContainer"
    TabContainer.Parent = MainFrame
    TabContainer.Position = UDim2.new(0, 0, 0, 46)
    TabContainer.Size = UDim2.new(0, 150, 1, -46)
    TabContainer.BackgroundColor3 = Color3.fromRGB(13, 18, 25)
    TabContainer.BorderSizePixel = 0
    TabContainer.ScrollBarThickness = 0

    local TabList = Instance.new("UIListLayout")
    TabList.Parent = TabContainer
    TabList.SortOrder = Enum.SortOrder.LayoutOrder
    TabList.Padding = UDim.new(0, 6)
    TabList.HorizontalAlignment = Enum.HorizontalAlignment.Center

    local ContentContainer = Instance.new("Frame")
    ContentContainer.Name = "ContentContainer"
    ContentContainer.Parent = MainFrame
    ContentContainer.Position = UDim2.new(0, 160, 0, 54)
    ContentContainer.Size = UDim2.new(1, -170, 1, -64)
    ContentContainer.BackgroundTransparency = 1

    -- Nút Toggle nổi
    local ToggleGui = Instance.new("ScreenGui")
    ToggleGui.Name = "AbyssalHub_ToggleGui"
    ToggleGui.Parent = CoreGui
    ToggleGui.ResetOnSpawn = false

    local ToggleButton = Instance.new("ImageButton")
    ToggleButton.Name = "ToggleButton"
    ToggleButton.Parent = ToggleGui
    ToggleButton.BackgroundColor3 = Color3.fromRGB(16, 22, 30)
    ToggleButton.Position = UDim2.new(0.05, 0, 0.15, 0)
    ToggleButton.Size = UDim2.new(0, 52, 0, 52)
    ToggleButton.Image = "rbxassetid://122987919647953"
    ToggleButton.Active = true

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 14)
    UICorner.Parent = ToggleButton

    local UIStroke = Instance.new("UIStroke")
    UIStroke.Color = Color3.fromRGB(0, 180, 255)
    UIStroke.Thickness = 1.6
    UIStroke.Parent = ToggleButton

    local tDragging, tDragInput, tDragStart, tStartPos
    local hasMoved = false

    ToggleButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            tDragging = true
            hasMoved = false
            tDragStart = input.Position
            tStartPos = ToggleButton.Position
        end
    end)
    ToggleButton.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            tDragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == tDragInput and tDragging then
            local delta = input.Position - tDragStart
            if delta.Magnitude > 5 then hasMoved = true end
            ToggleButton.Position = UDim2.new(tStartPos.X.Scale, tStartPos.X.Offset + delta.X, tStartPos.Y.Scale, tStartPos.Y.Offset + delta.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            tDragging = false
        end
    end)

    ToggleButton.MouseButton1Click:Connect(function()
        if not hasMoved then
            ScreenGui.Enabled = not ScreenGui.Enabled
        end
    end)

    local Window = {}
    local firstTab = true

    function Window:CreateTab(tabName)
        local TabButton = Instance.new("TextButton")
        TabButton.Name = tabName .. "Tab"
        TabButton.Parent = TabContainer
        TabButton.Size = UDim2.new(1, -12, 0, 36)
        TabButton.BackgroundColor3 = Color3.fromRGB(21, 27, 36)
        TabButton.Text = tabName
        TabButton.TextColor3 = Color3.fromRGB(140, 155, 175)
        TabButton.Font = Enum.Font.GothamMedium
        TabButton.TextSize = 13

        local TabBtnCorner = Instance.new("UICorner")
        TabBtnCorner.CornerRadius = UDim.new(0, 8)
        TabBtnCorner.Parent = TabButton

        local TabPage = Instance.new("ScrollingFrame")
        TabPage.Name = tabName .. "Page"
        TabPage.Parent = ContentContainer
        TabPage.Size = UDim2.new(1, 0, 1, 0)
        TabPage.BackgroundTransparency = 1
        TabPage.Visible = false
        TabPage.ScrollBarThickness = 3
        TabPage.ScrollBarImageColor3 = Color3.fromRGB(0, 210, 255)

        local PageList = Instance.new("UIListLayout")
        PageList.Parent = TabPage
        PageList.SortOrder = Enum.SortOrder.LayoutOrder
        PageList.Padding = UDim.new(0, 8)

        PageList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            TabPage.CanvasSize = UDim2.new(0, 0, 0, PageList.AbsoluteContentSize.Y + 12)
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

        function TabElements:CreateButton(btnName, callback)
            local Button = Instance.new("TextButton")
            Button.Parent = TabPage
            Button.Size = UDim2.new(1, -8, 0, 40)
            Button.BackgroundColor3 = Color3.fromRGB(21, 27, 36)
            Button.Text = btnName
            Button.TextColor3 = Color3.fromRGB(240, 240, 240)
            Button.Font = Enum.Font.GothamMedium
            Button.TextSize = 13

            local Corner = Instance.new("UICorner")
            Corner.CornerRadius = UDim.new(0, 8)
            Corner.Parent = Button

            Button.MouseButton1Click:Connect(function()
                pcall(callback)
            end)
        end

        function TabElements:CreateToggle(text, defaultState, callback)
            local state = (defaultState == true)
            local toggleFrame = Instance.new("Frame")
            local toggleTitle = Instance.new("TextLabel")
            local toggleBtn = Instance.new("TextButton")

            toggleFrame.Size = UDim2.new(1, -8, 0, 40)
            toggleFrame.BackgroundColor3 = Color3.fromRGB(21, 27, 36)
            toggleFrame.Parent = TabPage

            local Corner = Instance.new("UICorner")
            Corner.CornerRadius = UDim.new(0, 8)
            Corner.Parent = toggleFrame

            toggleTitle.Size = UDim2.new(0.7, 0, 1, 0)
            toggleTitle.Position = UDim2.new(0, 12, 0, 0)
            toggleTitle.BackgroundTransparency = 1
            toggleTitle.Text = text
            toggleTitle.TextColor3 = Color3.fromRGB(240, 240, 240)
            toggleTitle.TextXAlignment = Enum.TextXAlignment.Left
            toggleTitle.Font = Enum.Font.GothamMedium
            toggleTitle.TextSize = 13
            toggleTitle.Parent = toggleFrame

            toggleBtn.Size = UDim2.new(0, 26, 0, 26)
            toggleBtn.Position = UDim2.new(1, -38, 0.5, -13)
            toggleBtn.BackgroundColor3 = state and Color3.fromRGB(0, 210, 255) or Color3.fromRGB(35, 40, 50)
            toggleBtn.Text = ""
            toggleBtn.Parent = toggleFrame

            local BtnCorner = Instance.new("UICorner")
            BtnCorner.CornerRadius = UDim.new(1, 0)
            BtnCorner.Parent = toggleBtn

            toggleBtn.MouseButton1Click:Connect(function()
                state = not state
                toggleBtn.BackgroundColor3 = state and Color3.fromRGB(0, 210, 255) or Color3.fromRGB(35, 40, 50)
                if callback then pcall(callback, state) end
            end)
        end

        function TabElements:CreateSlider(sliderName, min, max, default, callback)
            local value = default or min
            local SliderFrame = Instance.new("Frame")
            SliderFrame.Parent = TabPage
            SliderFrame.Size = UDim2.new(1, -8, 0, 46)
            SliderFrame.BackgroundColor3 = Color3.fromRGB(21, 27, 36)

            local Corner = Instance.new("UICorner")
            Corner.CornerRadius = UDim.new(0, 8)
            Corner.Parent = SliderFrame

            local Label = Instance.new("TextLabel")
            Label.Parent = SliderFrame
            Label.Position = UDim2.new(0, 12, 0, 5)
            Label.Size = UDim2.new(0.6, 0, 0, 18)
            Label.Text = sliderName
            Label.TextColor3 = Color3.fromRGB(240, 240, 240)
            Label.Font = Enum.Font.GothamMedium
            Label.TextSize = 13
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.BackgroundTransparency = 1

            local ValueLabel = Instance.new("TextLabel")
            ValueLabel.Parent = SliderFrame
            ValueLabel.Position = UDim2.new(1, -60, 0, 5)
            ValueLabel.Size = UDim2.new(0, 50, 0, 18)
            ValueLabel.Text = tostring(value)
            ValueLabel.TextColor3 = Color3.fromRGB(0, 210, 255)
            ValueLabel.Font = Enum.Font.GothamBold
            ValueLabel.TextSize = 13
            ValueLabel.BackgroundTransparency = 1
            ValueLabel.TextXAlignment = Enum.TextXAlignment.Right

            local SlideBack = Instance.new("TextButton")
            SlideBack.Parent = SliderFrame
            SlideBack.Position = UDim2.new(0, 12, 0, 28)
            SlideBack.Size = UDim2.new(1, -24, 0, 8)
            SlideBack.BackgroundColor3 = Color3.fromRGB(13, 17, 23)
            SlideBack.Text = ""

            local BackCorner = Instance.new("UICorner")
            BackCorner.CornerRadius = UDim.new(0, 4)
            BackCorner.Parent = SlideBack

            local SlideBar = Instance.new("Frame")
            SlideBar.Parent = SlideBack
            SlideBar.Size = UDim2.new((value - min) / (max - min), 0, 1, 0)
            SlideBar.BackgroundColor3 = Color3.fromRGB(0, 210, 255)
            SlideBar.BorderSizePixel = 0

            local BarCorner = Instance.new("UICorner")
            BarCorner.CornerRadius = UDim.new(0, 4)
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

        function TabElements:CreateBox(boxName, placeholder, callback)
            local BoxFrame = Instance.new("Frame")
            BoxFrame.Parent = TabPage
            BoxFrame.Size = UDim2.new(1, -8, 0, 40)
            BoxFrame.BackgroundColor3 = Color3.fromRGB(21, 27, 36)

            local Corner = Instance.new("UICorner")
            Corner.CornerRadius = UDim.new(0, 8)
            Corner.Parent = BoxFrame

            local Label = Instance.new("TextLabel")
            Label.Parent = BoxFrame
            Label.Position = UDim2.new(0, 12, 0, 0)
            Label.Size = UDim2.new(0.5, 0, 1, 0)
            Label.Text = boxName
            Label.TextColor3 = Color3.fromRGB(240, 240, 240)
            Label.Font = Enum.Font.GothamMedium
            Label.TextSize = 13
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.BackgroundTransparency = 1

            local TextBox = Instance.new("TextBox")
            TextBox.Parent = BoxFrame
            TextBox.Position = UDim2.new(1, -145, 0.5, -12)
            TextBox.Size = UDim2.new(0, 135, 0, 24)
            TextBox.BackgroundColor3 = Color3.fromRGB(13, 17, 23)
            TextBox.PlaceholderText = placeholder or "Nhập..."
            TextBox.Text = ""
            TextBox.TextColor3 = Color3.fromRGB(0, 210, 255)
            TextBox.Font = Enum.Font.Gotham
            TextBox.TextSize = 12

            local BoxCorner = Instance.new("UICorner")
            BoxCorner.CornerRadius = UDim.new(0, 6)
            BoxCorner.Parent = TextBox

            TextBox.FocusLost:Connect(function()
                pcall(callback, TextBox.Text)
            end)
        end

                        function TabElements:CreateDropdown(text, options, defaultOption, callback)
            local dropdownFrame = Instance.new("Frame")
            local dropdownTitle = Instance.new("TextLabel")
            local dropdownBtn = Instance.new("TextButton")
            local optionsHolder = Instance.new("ScrollingFrame")
            local UIListLayout = Instance.new("UIListLayout")

            local selected = defaultOption or options[1]
            local isOpened = false

            dropdownFrame.Size = UDim2.new(1, -8, 0, 40)
            dropdownFrame.BackgroundColor3 = Color3.fromRGB(21, 27, 36)
            dropdownFrame.Parent = TabPage

            local Corner = Instance.new("UICorner")
            Corner.CornerRadius = UDim.new(0, 8)
            Corner.Parent = dropdownFrame

            dropdownTitle.Size = UDim2.new(0.5, 0, 1, 0)
            dropdownTitle.Position = UDim2.new(0, 12, 0, 0)
            dropdownTitle.BackgroundTransparency = 1
            dropdownTitle.Text = text
            dropdownTitle.TextColor3 = Color3.fromRGB(240, 240, 240)
            dropdownTitle.TextXAlignment = Enum.TextXAlignment.Left
            dropdownTitle.Font = Enum.Font.GothamMedium
            dropdownTitle.TextSize = 13
            dropdownTitle.Parent = dropdownFrame

            dropdownBtn.Size = UDim2.new(0.42, 0, 0, 26)
            dropdownBtn.Position = UDim2.new(0.56, 0, 0.5, -13)
            dropdownBtn.BackgroundColor3 = Color3.fromRGB(13, 17, 23)
            dropdownBtn.Text = tostring(selected) .. " ▼"
            dropdownBtn.TextColor3 = Color3.fromRGB(0, 210, 255)
            dropdownBtn.Font = Enum.Font.Gotham
            dropdownBtn.TextSize = 12
            dropdownBtn.Parent = dropdownFrame

            local BtnCorner = Instance.new("UICorner")
            BtnCorner.CornerRadius = UDim.new(0, 6)
            BtnCorner.Parent = dropdownBtn

            optionsHolder.Size = UDim2.new(1, 0, 0, 0)
            optionsHolder.Position = UDim2.new(0, 0, 1, 6)
            optionsHolder.BackgroundColor3 = Color3.fromRGB(17, 22, 30)
            optionsHolder.Visible = false
            optionsHolder.AutomaticCanvasSize = Enum.AutomaticSize.Y
            optionsHolder.CanvasSize = UDim2.new(0, 0, 0, 0)
            optionsHolder.ScrollBarThickness = 3
            optionsHolder.ZIndex = 10
            optionsHolder.Parent = dropdownFrame

            local HolderCorner = Instance.new("UICorner")
            HolderCorner.CornerRadius = UDim.new(0, 6)
            HolderCorner.Parent = optionsHolder

            UIListLayout.Parent = optionsHolder
            UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
            UIListLayout.Padding = UDim.new(0, 3)

            local function toggleDropdown()
                isOpened = not isOpened
                optionsHolder.Visible = isOpened
                if isOpened then
                    dropdownBtn.Text = tostring(selected) .. " ▲"
                    task.wait()
                    local contentHeight = UIListLayout.AbsoluteContentSize.Y
                    local targetHeight = math.min(contentHeight + 6, 130)
                    optionsHolder.Size = UDim2.new(1, 0, 0, targetHeight)
                    dropdownFrame.Size = UDim2.new(1, -8, 0, 40 + targetHeight + 12)
                else
                    dropdownBtn.Text = tostring(selected) .. " ▼"
                    optionsHolder.Size = UDim2.new(1, 0, 0, 0)
                    dropdownFrame.Size = UDim2.new(1, -8, 0, 40)
                end
            end

            dropdownBtn.MouseButton1Click:Connect(toggleDropdown)

            for _, opt in ipairs(options) do
                local optBtn = Instance.new("TextButton")
                optBtn.Size = UDim2.new(1, 0, 0, 28)
                optBtn.BackgroundColor3 = Color3.fromRGB(21, 27, 36)
                optBtn.BackgroundTransparency = 0.5
                optBtn.Text = "  " .. tostring(opt)
                optBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
                optBtn.Font = Enum.Font.Gotham
                optBtn.TextSize = 12
                optBtn.TextXAlignment = Enum.TextXAlignment.Left
                optBtn.ZIndex = 11
                optBtn.Parent = optionsHolder

                local optCorner = Instance.new("UICorner")
                optCorner.CornerRadius = UDim.new(0, 6)
                optCorner.Parent = optBtn

                optBtn.MouseButton1Click:Connect(function()
                    selected = opt
                    dropdownBtn.Text = tostring(selected) .. " ▼"
                    toggleDropdown()
                    if callback then pcall(callback, selected) end
                end)
            end

            local dropdownObj = {}
            function dropdownObj:Refresh(newOptions)
                options = newOptions
                for _, child in ipairs(optionsHolder:GetChildren()) do
                    if child:IsA("TextButton") then child:Destroy() end
                end
                for _, opt in ipairs(options) do
                    local optBtn = Instance.new("TextButton")
                    optBtn.Size = UDim2.new(1, 0, 0, 28)
                    optBtn.BackgroundColor3 = Color3.fromRGB(21, 27, 36)
                    optBtn.BackgroundTransparency = 0.5
                    optBtn.Text = "  " .. tostring(opt)
                    optBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
                    optBtn.Font = Enum.Font.Gotham
                    optBtn.TextSize = 12
                    optBtn.TextXAlignment = Enum.TextXAlignment.Left
                    optBtn.ZIndex = 11
                    optBtn.Parent = optionsHolder

                    local optCorner = Instance.new("UICorner")
                    optCorner.CornerRadius = UDim.new(0, 6)
                    optCorner.Parent = optBtn

                    optBtn.MouseButton1Click:Connect(function()
                        selected = opt
                        dropdownBtn.Text = tostring(selected) .. " ▼"
                        if isOpened then toggleDropdown() end
                        if callback then pcall(callback, selected) end
                    end)
                end
            end

            if callback then pcall(callback, selected) end
            return dropdownObj
        end

        function TabElements:CreateLabel(initialText, updateFunction)
            local labelContainer = Instance.new("Frame")
            labelContainer.Size = UDim2.new(1, -8, 0, 40)
            labelContainer.BackgroundColor3 = Color3.fromRGB(21, 27, 36)
            labelContainer.Parent = TabPage

            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 8)
            corner.Parent = labelContainer

            local textLabel = Instance.new("TextLabel")
            textLabel.Size = UDim2.new(1, -16, 1, 0)
            textLabel.Position = UDim2.new(0, 12, 0, 0)
            textLabel.BackgroundTransparency = 1
            textLabel.TextColor3 = Color3.fromRGB(240, 240, 240)
            textLabel.TextSize = 13
            textLabel.Font = Enum.Font.GothamMedium
            textLabel.TextXAlignment = Enum.TextXAlignment.Left
            textLabel.Text = initialText or "Label Text"
            textLabel.Parent = labelContainer

            if updateFunction and type(updateFunction) == "function" then
                task.spawn(function()
                    while labelContainer and labelContainer.Parent do
                        pcall(function()
                            local newText = updateFunction()
                            if newText then
                                textLabel.Text = tostring(newText)
                            end
                        end)
                        task.wait(0.5)
                    end
                end)
            end

            local labelObject = {}
            function labelObject:Set(newText)
                textLabel.Text = newText
            end
            return labelObject
        end

        return TabElements
    end

    return Window
end

-- ====================================================================
-- 2. KHỞI TẠO CỬA SỔ & TAB (STATS & SERVER LÊN ĐẦU TIÊN)
-- ====================================================================
local Window = Library:CreateWindow("ABYSSAL HUB")
local StatsTab = Window:CreateTab("Stats and sever")
local TestTab = Window:CreateTab("Demo UI")
-- ====================================================================
-- 3. KHỞI TẠO LABELS & VÒNG LẶP STATS & SERVER
-- ====================================================================
local Players = game:GetService("Players")
local StatsService = game:GetService("Stats")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer

local PingLabel   = StatsTab:CreateLabel("📡 Ping: Đang tải...", function()
    local ping = 0
    pcall(function()
        if LocalPlayer and LocalPlayer.NetworkPing then
            ping = math.floor(LocalPlayer.NetworkPing * 1000)
        else
            local networkStats = StatsService:FindFirstChild("Network")
            local serverStatsItem = networkStats and networkStats:FindFirstChild("ServerStatsItem")
            local dataPing = serverStatsItem and serverStatsItem:FindFirstChild("Data Ping")
            if dataPing then ping = math.floor(dataPing:GetValue()) end
        end
    end)
    return "📡 Ping: " .. ping .. " ms"
end)

local FpsLabel    = StatsTab:CreateLabel("⚡ FPS: Đang tải...", function()
    local fps = 60
    pcall(function()
        fps = math.floor(1 / game:GetService("RunService").RenderStepped:Wait())
    end)
    return "⚡ FPS: " .. fps
end)

local MoonLabel   = StatsTab:CreateLabel("🌕 Trăng (Moon): Đang quét...", function()
    local text = "🌕 Trăng: Đang ban ngày ☀️"
    pcall(function()
        local clockTime = Lighting.ClockTime
        if clockTime < 6 or clockTime > 18 then
            local moonId = tostring(Lighting.MoonTextureId or "")
            if moonId:find("9701506161") or moonId:find("1440") or Lighting.MoonSize > 2 then
                text = "🌕 Trăng: 🟢 FULL MOON (TRĂNG TRÒN!)"
            else
                text = "🌕 Trăng: Đang ban đêm (Chưa Full)"
            end
        end
    end)
    return text
end)

local MirageLabel = StatsTab:CreateLabel("🏝️ Đảo Bí Ẩn (Mirage): Không thấy", function()
    local found = false
    pcall(function()
        for _, obj in ipairs(workspace:GetChildren()) do
            if obj.Name == "Mirage Island" or obj.Name:lower():find("mirage") then
                found = true
                break
            end
        end
    end)
    return found and "🏝️ Đảo Bí Ẩn (Mirage): 🟢 XUẤT HIỆN RỒI!" or "🏝️ Đảo Bí Ẩn (Mirage): 🔴 Không có trong Server"
end)

TestTab:CreateToggle("Tên Chức Năng", false, function(state)
    if state then
        print("Đã BẬT!")
    else
        print("Đã TẮT!")
    end
end)

TestTab:CreateButton("NAME BUTTON", function()
    print("Nút đã được bấm!")
    -- Viết code dịch chuyển hoặc tính năng của cậu ở đây
end)

TestTab:CreateSlider("NAME SLIDER", 16, 200, 16, function(value)
    print("Giá trị hiện tại:", value)
    -- value chính là số mà người dùng kéo chọn
end)

TestTab:CreateBox("TEXTBOX", "Điền text vào đây...", function(text)
    print("Người dùng vừa nhập:", text)
end)

TestTab:CreateDropdown("Select", {"Select 1", "Select 2", "Select 3"}, "Select 1", function(selected)
    print("Đã chọn:", selected)
end)
