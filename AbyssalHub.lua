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

-- ====================================================================
-- AUTO FARM LEVEL (FIX TRIỆT ĐỂ LỖI ĐÁNH 1 CON LẠI VỀ NHẬN QUEST)
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
    ["Frozen Village"]  = CFrame.new(1385.74, 90, -1298.07)
}

local EnemyPositions = {
    ["Bandit"]   = CFrame.new(1038.5, 30, 1542.8),
    ["Monkey"]   = CFrame.new(-1610.6, 35, 142.3),
    ["Gorilla"]  = CFrame.new(-1237.7, 35, -486.3)
}

local QuestDatabase = {
    { MinLevel = 1, MaxLevel = 9, QuestName = "BanditQuest1", QuestNumber = 1, EnemyName = "Bandit", Island = "Pirate Starter" },
    { MinLevel = 10, MaxLevel = 14, QuestName = "JungleQuest", QuestNumber = 1, EnemyName = "Monkey", Island = "Jungle" },
    { MinLevel = 15, MaxLevel = 29, QuestName = "JungleQuest", QuestNumber = 2, EnemyName = "Gorilla", Island = "Jungle" }
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
    if distance < 12 then
        root.CFrame = targetCFrame
        return
    end

    local speed = 280
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

        -- CHECK QUEST NÂNG CẤP: Quét tất cả chữ hiển thị Quest trên màn hình
        local function hasActiveQuest()
            local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
            if playerGui then
                -- Tìm khung Quest chính của Blox Fruits
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
                    -- 1. NẾU CHƯA CÓ QUEST THÌ MỚI BAY VỀ NHẬN
                    if not hasActiveQuest() then
                        local npcPos = NpcPositions[currentData.Island]
                        if npcPos then
                            smoothMoveTo(npcPos)
                            task.wait(0.2)
                        end

                        if CommF then
                            pcall(function()
                                CommF:InvokeServer("StartQuest", currentData.QuestName, currentData.QuestNumber)
                            end)
                        end
                        task.wait(0.8)
                    end

                    -- 2. VÒNG LẶP FARM LIÊN TỤC CHO ĐẾN KHI HẾT QUEST
                    while hasActiveQuest() and AutoFarmLevelEnabled do
                        task.wait(0.1)

                        local EnemiesFolder = Workspace:FindFirstChild("Enemies")
                        local targetEnemy = nil

                        if EnemiesFolder then
                            for _, enemy in pairs(EnemiesFolder:GetChildren()) do
                                if string.find(enemy.Name, currentData.EnemyName) then
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

                            -- Đánh 1 con quái đến khi nó chết hẳn
                            while targetEnemy and eHum and eHum.Health > 0 and AutoFarmLevelEnabled and hasActiveQuest() do
                                RootPart.CFrame = eRoot.CFrame * CFrame.new(0, 14, 0) * CFrame.Angles(math.rad(-90), 0, 0)

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
                            -- Nếu chưa có quái thì bay lơ lửng chờ ở bãi quái chứ không bay về NPC
                            local enemySpot = EnemyPositions[currentData.EnemyName]
                            if enemySpot then
                                smoothMoveTo(enemySpot * CFrame.new(0, 15, 0))
                            end
                            task.wait(0.5)
                        end
                    end
                end
            end
        end
    end)
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
