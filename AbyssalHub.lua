local rawKey = _G.Key or ""
local userKey = string.gsub(rawKey, "%s+", "")
local userHWID = game:GetService("RbxAnalyticsService"):GetClientId()

local ngrokUrl = "https://nonsuppositively-unmasticatory-drew.ngrok-free.dev"

if userKey == "" then
    game.Players.LocalPlayer:Kick("\n[ABYSSAL HUB]\n❌ Chưa nhập Key! Hãy gán _G.Key trước khi chạy.")
    return
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
    game.Players.LocalPlayer:Kick("\n[ABYSSAL HUB]\n⚠️ Không thể kết nối Server Ngrok!")
    return
end

local cleanResponse = string.upper(trim(response))

if cleanResponse == "SUCCESS" then
    print("-> Abyssal Key Verified Successfully!")
elseif cleanResponse == "BLACKLISTED" then
    game.Players.LocalPlayer:Kick("\n[ABYSSAL HUB]\n🚫 Tài khoản/HWID của bạn đã bị BLACKLIST!")
elseif cleanResponse == "HWID_MISMATCH" then
    game.Players.LocalPlayer:Kick("\n[ABYSSAL HUB]\n⚠️ Key này đang được dùng ở thiết bị khác!")
elseif cleanResponse == "EXPIRED" then
    game.Players.LocalPlayer:Kick("\n[ABYSSAL HUB]\n⏳ Key của bạn đã hết hạn!")
elseif cleanResponse == "INVALID_KEY" then
    game.Players.LocalPlayer:Kick("\n[ABYSSAL HUB]\n❌ Key không tồn tại!")
else
    game.Players.LocalPlayer:Kick("\n[ABYSSAL HUB]\n⚠️ Phản hồi không xác định: " .. cleanResponse)
end

local Library = {}
Library.Flags = {}

local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

function Library:CreateWindow(hubName)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "AbyssalHubUI"
    ScreenGui.Parent = CoreGui
    ScreenGui.ResetOnSpawn = false

    local ToggleUIButton = Instance.new("TextButton")
    ToggleUIButton.Name = "ToggleUIButton"
    ToggleUIButton.Parent = ScreenGui
    ToggleUIButton.Position = UDim2.new(0.02, 0, 0.2, 0)
    ToggleUIButton.Size = UDim2.new(0, 45, 0, 45)
    ToggleUIButton.BackgroundColor3 = Color3.fromRGB(15, 23, 42)
    ToggleUIButton.Text = "AH"
    ToggleUIButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleUIButton.TextSize = 16
    ToggleUIButton.Font = Enum.Font.GothamBold

    local ToggleUICorner = Instance.new("UICorner")
    ToggleUICorner.CornerRadius = UDim.new(0, 8)
    ToggleUICorner.Parent = ToggleUIButton

    local ToggleUIStroke = Instance.new("UIStroke")
    ToggleUIStroke.Color = Color3.fromRGB(56, 189, 248)
    ToggleUIStroke.Thickness = 1.5
    ToggleUIStroke.Parent = ToggleUIButton

    -- Khung chính
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.Position = UDim2.new(0.3, 0, 0.25, 0)
    MainFrame.Size = UDim2.new(0, 520, 0, 350)
    MainFrame.BackgroundColor3 = Color3.fromRGB(15, 23, 42)
    MainFrame.BorderSizePixel = 0
    MainFrame.ClipsDescendants = true

    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 8)
    MainCorner.Parent = MainFrame

    local MainStroke = Instance.new("UIStroke")
    MainStroke.Color = Color3.fromRGB(30, 41, 59)
    MainStroke.Thickness = 1
    MainStroke.Parent = MainFrame

    -- Kéo thả UI (Drag System)
    local dragging, dragInput, dragStart, startPos
    MainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
        end
    end)
    MainFrame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
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
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    -- Nút bấm bật/tắt UI
    ToggleUIButton.MouseButton1Click:Connect(function()
        MainFrame.Visible = not MainFrame.Visible
    end)

    -- Topbar
    local Topbar = Instance.new("Frame")
    Topbar.Name = "Topbar"
    Topbar.Parent = MainFrame
    Topbar.Size = UDim2.new(1, 0, 0, 40)
    Topbar.BackgroundColor3 = Color3.fromRGB(30, 41, 59)
    Topbar.BorderSizePixel = 0

    local Title = Instance.new("TextLabel")
    Title.Parent = Topbar
    Title.Position = UDim2.new(0, 15, 0, 0)
    Title.Size = UDim2.new(0, 200, 1, 0)
    Title.Text = hubName or "ABYSSAL HUB"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 14
    Title.TextXAlignment = Enum.TextXAlignment.Left

    -- Container Tab (Bên trái)
    local TabContainer = Instance.new("ScrollingFrame")
    TabContainer.Name = "TabContainer"
    TabContainer.Parent = MainFrame
    TabContainer.Position = UDim2.new(0, 0, 0, 40)
    TabContainer.Size = UDim2.new(0, 130, 1, -40)
    TabContainer.BackgroundColor3 = Color3.fromRGB(15, 23, 42)
    TabContainer.BorderSizePixel = 0
    TabContainer.ScrollBarThickness = 2

    local TabList = Instance.new("UIListLayout")
    TabList.Parent = TabContainer
    TabList.SortOrder = Enum.SortOrder.LayoutOrder
    TabList.Padding = UDim.new(0, 5)

    -- Container Nội dung (Bên phải)
    local ContentContainer = Instance.new("Frame")
    ContentContainer.Name = "ContentContainer"
    ContentContainer.Parent = MainFrame
    ContentContainer.Position = UDim2.new(0, 135, 0, 45)
    ContentContainer.Size = UDim2.new(1, -140, 1, -50)
    ContentContainer.BackgroundTransparency = 1

    local Window = {}
    local firstTab = true

    -- Function CreateTab
    function Window:CreateTab(tabName)
        local TabButton = Instance.new("TextButton")
        TabButton.Name = tabName .. "Tab"
        TabButton.Parent = TabContainer
        TabButton.Size = UDim2.new(1, -10, 0, 32)
        TabButton.Position = UDim2.new(0, 5, 0, 0)
        TabButton.BackgroundColor3 = Color3.fromRGB(30, 41, 59)
        TabButton.Text = tabName
        TabButton.TextColor3 = Color3.fromRGB(148, 163, 184)
        TabButton.Font = Enum.Font.GothamMedium
        TabButton.TextSize = 13

        local TabBtnCorner = Instance.new("UICorner")
        TabBtnCorner.CornerRadius = UDim.new(0, 6)
        TabBtnCorner.Parent = TabButton

        local TabPage = Instance.new("ScrollingFrame")
        TabPage.Name = tabName .. "Page"
        TabPage.Parent = ContentContainer
        TabPage.Size = UDim2.new(1, 0, 1, 0)
        TabPage.BackgroundTransparency = 1
        TabPage.Visible = false
        TabPage.ScrollBarThickness = 3

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
            TabButton.BackgroundColor3 = Color3.fromRGB(56, 189, 248)
            TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        end

        TabButton.MouseButton1Click:Connect(function()
            for _, page in pairs(ContentContainer:GetChildren()) do
                if page:IsA("ScrollingFrame") then page.Visible = false end
            end
            for _, btn in pairs(TabContainer:GetChildren()) do
                if btn:IsA("TextButton") then
                    btn.BackgroundColor3 = Color3.fromRGB(30, 41, 59)
                    btn.TextColor3 = Color3.fromRGB(148, 163, 184)
                end
            end
            TabPage.Visible = true
            TabButton.BackgroundColor3 = Color3.fromRGB(56, 189, 248)
            TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        end)

        local TabElements = {}

        -- CreateButton
        function TabElements:CreateButton(btnName, callback)
            local Button = Instance.new("TextButton")
            Button.Parent = TabPage
            Button.Size = UDim2.new(1, -6, 0, 35)
            Button.BackgroundColor3 = Color3.fromRGB(30, 41, 59)
            Button.Text = btnName
            Button.TextColor3 = Color3.fromRGB(255, 255, 255)
            Button.Font = Enum.Font.GothamMedium
            Button.TextSize = 13

            local Corner = Instance.new("UICorner")
            Corner.CornerRadius = UDim.new(0, 6)
            Corner.Parent = Button

            Button.MouseButton1Click:Connect(function()
                TweenService:Create(Button, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(56, 189, 248)}):Play()
                task.wait(0.1)
                TweenService:Create(Button, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(30, 41, 59)}):Play()
                pcall(callback)
            end)
        end

        -- CreateToggle
        function TabElements:CreateToggle(toggleName, default, callback)
            local toggled = default or false

            local ToggleFrame = Instance.new("Frame")
            ToggleFrame.Parent = TabPage
            ToggleFrame.Size = UDim2.new(1, -6, 0, 35)
            ToggleFrame.BackgroundColor3 = Color3.fromRGB(30, 41, 59)

            local Corner = Instance.new("UICorner")
            Corner.CornerRadius = UDim.new(0, 6)
            Corner.Parent = ToggleFrame

            local Label = Instance.new("TextLabel")
            Label.Parent = ToggleFrame
            Label.Position = UDim2.new(0, 10, 0, 0)
            Label.Size = UDim2.new(0.7, 0, 1, 0)
            Label.Text = toggleName
            Label.TextColor3 = Color3.fromRGB(255, 255, 255)
            Label.Font = Enum.Font.GothamMedium
            Label.TextSize = 13
            Label.TextXAlignment = Enum.TextXAlignment.Left

            local Switch = Instance.new("TextButton")
            Switch.Parent = ToggleFrame
            Switch.Position = UDim2.new(1, -40, 0.5, -10)
            Switch.Size = UDim2.new(0, 30, 0, 20)
            Switch.BackgroundColor3 = toggled and Color3.fromRGB(56, 189, 248) or Color3.fromRGB(15, 23, 42)
            Switch.Text = ""

            local SwitchCorner = Instance.new("UICorner")
            SwitchCorner.CornerRadius = UDim.new(0, 5)
            SwitchCorner.Parent = Switch

            Switch.MouseButton1Click:Connect(function()
                toggled = not toggled
                TweenService:Create(Switch, TweenInfo.new(0.15), {
                    BackgroundColor3 = toggled and Color3.fromRGB(56, 189, 248) or Color3.fromRGB(15, 23, 42)
                }):Play()
                pcall(callback, toggled)
            end)
        end

        -- CreateSlider
        function TabElements:CreateSlider(sliderName, min, max, default, callback)
            local value = default or min

            local SliderFrame = Instance.new("Frame")
            SliderFrame.Parent = TabPage
            SliderFrame.Size = UDim2.new(1, -6, 0, 45)
            SliderFrame.BackgroundColor3 = Color3.fromRGB(30, 41, 59)

            local Corner = Instance.new("UICorner")
            Corner.CornerRadius = UDim.new(0, 6)
            Corner.Parent = SliderFrame

            local Label = Instance.new("TextLabel")
            Label.Parent = SliderFrame
            Label.Position = UDim2.new(0, 10, 0, 5)
            Label.Size = UDim2.new(0.6, 0, 0, 15)
            Label.Text = sliderName
            Label.TextColor3 = Color3.fromRGB(255, 255, 255)
            Label.Font = Enum.Font.GothamMedium
            Label.TextSize = 12
            Label.TextXAlignment = Enum.TextXAlignment.Left

            local ValueLabel = Instance.new("TextLabel")
            ValueLabel.Parent = SliderFrame
            ValueLabel.Position = UDim2.new(1, -50, 0, 5)
            ValueLabel.Size = UDim2.new(0, 40, 0, 15)
            ValueLabel.Text = tostring(value)
            ValueLabel.TextColor3 = Color3.fromRGB(148, 163, 184)
            ValueLabel.Font = Enum.Font.GothamMedium
            ValueLabel.TextSize = 12

            local SlideBack = Instance.new("TextButton")
            SlideBack.Parent = SliderFrame
            SlideBack.Position = UDim2.new(0, 10, 0, 28)
            SlideBack.Size = UDim2.new(1, -20, 0, 8)
            SlideBack.BackgroundColor3 = Color3.fromRGB(15, 23, 42)
            SlideBack.Text = ""

            local BackCorner = Instance.new("UICorner")
            BackCorner.CornerRadius = UDim.new(0, 4)
            BackCorner.Parent = SlideBack

            local SlideBar = Instance.new("Frame")
            SlideBar.Parent = SlideBack
            SlideBar.Size = UDim2.new((value - min) / (max - min), 0, 1, 0)
            SlideBar.BackgroundColor3 = Color3.fromRGB(56, 189, 248)
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
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    isSliding = true
                    update(input)
                end
            end)
            UserInputService.InputChanged:Connect(function(input)
                if isSliding and input.UserInputType == Enum.UserInputType.MouseMovement then
                    update(input)
                end
            end)
            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    isSliding = false
                end
            end)
        end

        -- CreateBox
        function TabElements:CreateBox(boxName, placeholder, callback)
            local BoxFrame = Instance.new("Frame")
            BoxFrame.Parent = TabPage
            BoxFrame.Size = UDim2.new(1, -6, 0, 35)
            BoxFrame.BackgroundColor3 = Color3.fromRGB(30, 41, 59)

            local Corner = Instance.new("UICorner")
            Corner.CornerRadius = UDim.new(0, 6)
            Corner.Parent = BoxFrame

            local Label = Instance.new("TextLabel")
            Label.Parent = BoxFrame
            Label.Position = UDim2.new(0, 10, 0, 0)
            Label.Size = UDim2.new(0.5, 0, 1, 0)
            Label.Text = boxName
            Label.TextColor3 = Color3.fromRGB(255, 255, 255)
            Label.Font = Enum.Font.GothamMedium
            Label.TextSize = 13
            Label.TextXAlignment = Enum.TextXAlignment.Left

            local TextBox = Instance.new("TextBox")
            TextBox.Parent = BoxFrame
            TextBox.Position = UDim2.new(1, -130, 0.5, -12)
            TextBox.Size = UDim2.new(0, 120, 0, 24)
            TextBox.BackgroundColor3 = Color3.fromRGB(15, 23, 42)
            TextBox.PlaceholderText = placeholder or "Nhập..."
            TextBox.Text = ""
            TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextBox.Font = Enum.Font.Gotham
            TextBox.TextSize = 12

            local BoxCorner = Instance.new("UICorner")
            BoxCorner.CornerRadius = UDim.new(0, 4)
            BoxCorner.Parent = TextBox

            TextBox.FocusLost:Connect(function(enterPressed)
                pcall(callback, TextBox.Text)
            end)
        end

        return TabElements
    end

    return Window
end

local Window = Library:CreateWindow("ABYSSAL HUB")

local MainTab = Window:CreateTab("Main")
local PlayerTab = Window:CreateTab("Player")

MainTab:CreateButton("Auto Farm", function()
    print("Auto Farm Activated!")
end)

MainTab:CreateToggle("Fast Attack", false, function(state)
    print("Fast Attack:", state)
end)

PlayerTab:CreateSlider("WalkSpeed", 16, 200, 16, function(value)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
end)

PlayerTab:CreateBox("Teleport Player", "Tên Player...", function(text)
    print("Đang Teleport đến:", text)
end)
