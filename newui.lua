-- [[ ABYSSAL HUB - BLOCK GAME EDITION ]] --
-- UI Style: Abyssal Deep Sea (Neon Cyan & Obsidian Dark)

-- ====================================================================
-- 1. ĐIỀN PLACE ID GAME BLOCK CỦA CẬU VÀO ĐÂY
-- ====================================================================
local BLOCK_GAME_ID = 0 -- 👈 THAY PLACE ID GAME BLOCK CỦA CẬU VÀO ĐÂY

-- ====================================================================
-- CHECK KEY & HWID (CÓ CHỐNG KẸT CACHE)
-- ====================================================================
local rawKey = _G.Key or ""
local userKey = string.gsub(rawKey, "%s+", "")
local userHWID = game:GetService("RbxAnalyticsService"):GetClientId()

-- Link Ngrok Server của cậu
local ngrokUrl = "https://nonsuppositively-unmasticatory-drew.ngrok-free.dev"

if userKey == "" then
    game.Players.LocalPlayer:Kick("\n[ABYSSAL HUB]\n❌ Chưa nhập Key! Hãy gán _G.Key trước khi chạy.")
    return
end

-- Hàm trim làm sạch chuỗi
local function trim(s)
    return (s:gsub("^%s*(.-)%s*$", "%1"))
end

-- 🔴 Bổ sung os.time() ở cuối link để ép Executor lấy dữ liệu mới từ Server
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

-- Chuẩn hóa dữ liệu trả về
local cleanResponse = string.upper(trim(response))

-- Xử lý phản hồi từ API
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

-- ====================================================================
-- 3. SETUP HE THONG ABYSSAL UI
-- ====================================================================
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

local AbyssalLib = {}

if CoreGui:FindFirstChild("AbyssalUI") then
    CoreGui.AbyssalUI:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AbyssalUI"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

local Theme = {
    Background = Color3.fromRGB(10, 14, 20),
    Header = Color3.fromRGB(15, 22, 32),
    Accent = Color3.fromRGB(0, 220, 255),      -- Cyan Neon
    Secondary = Color3.fromRGB(0, 140, 200),   -- Deep Ocean Blue
    Text = Color3.fromRGB(230, 245, 255),
    SubText = Color3.fromRGB(100, 130, 160),
    Button = Color3.fromRGB(18, 26, 38),
    Hover = Color3.fromRGB(25, 38, 56)
}

----// NOTIFICATION SYSTEM
local NotifyHolder = Instance.new("Frame")
NotifyHolder.Name = "NotifyHolder"
NotifyHolder.BackgroundTransparency = 1
NotifyHolder.Size = UDim2.new(0, 300, 1, -40)
NotifyHolder.Position = UDim2.new(1, -320, 0, 20)
NotifyHolder.Parent = ScreenGui

local NotifyLayout = Instance.new("UIListLayout")
NotifyLayout.Padding = UDim.new(0, 10)
NotifyLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
NotifyLayout.Parent = NotifyHolder

function Notify(title, text, duration)
    duration = duration or 4
    local NFrame = Instance.new("Frame")
    NFrame.Size = UDim2.new(1, 0, 0, 70)
    NFrame.BackgroundColor3 = Theme.Background
    NFrame.Parent = NotifyHolder

    local NCorner = Instance.new("UICorner") NCorner.CornerRadius = UDim.new(0, 8) NCorner.Parent = NFrame
    local NStroke = Instance.new("UIStroke") NStroke.Color = Theme.Accent NStroke.Thickness = 1 NStroke.Parent = NFrame

    local NTitle = Instance.new("TextLabel")
    NTitle.Size = UDim2.new(1, -20, 0, 25)
    NTitle.Position = UDim2.new(0, 10, 0, 5)
    NTitle.BackgroundTransparency = 1
    NTitle.Font = Enum.Font.GothamBold
    NTitle.TextSize = 14
    NTitle.TextColor3 = Theme.Accent
    NTitle.TextXAlignment = Enum.TextXAlignment.Left
    NTitle.Text = "🧊 " .. title
    NTitle.Parent = NFrame

    local NText = Instance.new("TextLabel")
    NText.Size = UDim2.new(1, -20, 0, 35)
    NText.Position = UDim2.new(0, 10, 0, 30)
    NText.BackgroundTransparency = 1
    NText.Font = Enum.Font.Gotham
    NText.TextSize = 12
    NText.TextColor3 = Theme.Text
    NText.TextXAlignment = Enum.TextXAlignment.Left
    NText.TextWrapped = true
    NText.Text = text
    NText.Parent = NFrame

    NFrame.Position = UDim2.new(1, 350, 0, 0)
    TweenService:Create(NFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quart), {Position = UDim2.new(0, 0, 0, 0)}):Play()

    task.delay(duration, function()
        local Out = TweenService:Create(NFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Position = UDim2.new(1, 350, 0, 0)})
        Out:Play()
        Out.Completed:Wait()
        NFrame:Destroy()
    end)
end

-- ====================================================================
-- 4. CHECK GAME SUPPORT & LOADING ANIMATION
-- ====================================================================
local function StartLoadingAnimation(callback)
    local LoadingFrame = Instance.new("Frame")
    LoadingFrame.Size = UDim2.new(0, 320, 0, 90)
    LoadingFrame.Position = UDim2.new(0.5, -160, 0.5, -45)
    LoadingFrame.BackgroundColor3 = Theme.Background
    LoadingFrame.Parent = ScreenGui

    local Corner = Instance.new("UICorner") Corner.CornerRadius = UDim.new(0, 10) Corner.Parent = LoadingFrame
    local Stroke = Instance.new("UIStroke") Stroke.Color = Theme.Accent Stroke.Thickness = 1.5 Stroke.Parent = LoadingFrame

    local LText = Instance.new("TextLabel")
    LText.Size = UDim2.new(1, 0, 0, 30)
    LText.Position = UDim2.new(0, 0, 0, 15)
    LText.BackgroundTransparency = 1
    LText.Font = Enum.Font.GothamBold
    LText.Text = "Loading Block Modules... 0%"
    LText.TextColor3 = Theme.Text
    LText.TextSize = 13
    LText.Parent = LoadingFrame

    local BarBg = Instance.new("Frame")
    BarBg.Size = UDim2.new(1, -40, 0, 8)
    BarBg.Position = UDim2.new(0, 20, 0, 55)
    BarBg.BackgroundColor3 = Theme.Header
    BarBg.Parent = LoadingFrame
    local BarCorner = Instance.new("UICorner") BarCorner.CornerRadius = UDim.new(1, 0) BarCorner.Parent = BarBg

    local BarProg = Instance.new("Frame")
    BarProg.Size = UDim2.new(0, 0, 1, 0)
    BarProg.BackgroundColor3 = Theme.Accent
    BarProg.Parent = BarBg
    local ProgCorner = Instance.new("UICorner") ProgCorner.CornerRadius = UDim.new(1, 0) ProgCorner.Parent = BarProg

    for i = 1, 100 do
        task.wait(0.01)
        LText.Text = "Loading Block Modules... " .. i .. "%"
        BarProg.Size = UDim2.new(i/100, 0, 1, 0)
    end

    LoadingFrame:Destroy()
    if callback then callback() end
end

-- ====================================================================
-- 5. TAO GIAO DIEN CHINH (ABYSSAL WINDOW & ELEMENTS)
-- ====================================================================
function AbyssalLib:CreateWindow(titleText)
    local ToggleBtn = Instance.new("ImageButton")
    ToggleBtn.Name = "AbyssalToggle"
    ToggleBtn.Size = UDim2.new(0, 45, 0, 45)
    ToggleBtn.Position = UDim2.new(0, 15, 0, 15)
    ToggleBtn.BackgroundColor3 = Theme.Background
    ToggleBtn.Image = "rbxassetid://132194681351582"
    ToggleBtn.Parent = ScreenGui

    local TCorner = Instance.new("UICorner") TCorner.CornerRadius = UDim.new(0, 10) TCorner.Parent = ToggleBtn
    local TStroke = Instance.new("UIStroke") TStroke.Color = Theme.Accent TStroke.Thickness = 1.5 TStroke.Parent = ToggleBtn

    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 520, 0, 340)
    MainFrame.Position = UDim2.new(0.5, -260, 0.5, -170)
    MainFrame.BackgroundColor3 = Theme.Background
    MainFrame.Parent = ScreenGui

    local MCorner = Instance.new("UICorner") MCorner.CornerRadius = UDim.new(0, 12) MCorner.Parent = MainFrame
    local MStroke = Instance.new("UIStroke") MStroke.Color = Theme.Accent MStroke.Thickness = 1.5 MStroke.Parent = MainFrame

    local isOpen = true
    ToggleBtn.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        MainFrame.Visible = isOpen
    end)

    local TopBar = Instance.new("Frame")
    TopBar.Size = UDim2.new(1, 0, 0, 40)
    TopBar.BackgroundColor3 = Theme.Header
    TopBar.Parent = MainFrame
    local TopCorner = Instance.new("UICorner") TopCorner.CornerRadius = UDim.new(0, 12) TopCorner.Parent = TopBar

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(0, 200, 1, 0)
    Title.Position = UDim2.new(0, 15, 0, 0)
    Title.BackgroundTransparency = 1
    Title.RichText = true
    Title.Text = titleText
    Title.Font = Enum.Font.GothamBold
    Title.TextColor3 = Theme.Accent
    Title.TextSize = 14
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = TopBar

    local TabContainer = Instance.new("ScrollingFrame")
    TabContainer.Size = UDim2.new(1, -220, 1, 0)
    TabContainer.Position = UDim2.new(0, 210, 0, 0)
    TabContainer.BackgroundTransparency = 1
    TabContainer.ScrollBarThickness = 0
    TabContainer.Parent = TopBar

    local TabLayout = Instance.new("UIListLayout")
    TabLayout.FillDirection = Enum.FillDirection.Horizontal
    TabLayout.Padding = UDim.new(0, 5)
    TabLayout.Parent = TabContainer

    local ContentFrame = Instance.new("Frame")
    ContentFrame.Size = UDim2.new(1, -20, 1, -55)
    ContentFrame.Position = UDim2.new(0, 10, 0, 48)
    ContentFrame.BackgroundTransparency = 1
    ContentFrame.Parent = MainFrame

    local dragging, dragStart, startPos
    TopBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true dragStart = input.Position startPos = MainFrame.Position
        end
    end)
    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    game:GetService("UserInputService").InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)

    local Tabs = {}
    local firstTab = true

    function Tabs:CreateTab(tabName)
        local TabBtn = Instance.new("TextButton")
        TabBtn.Size = UDim2.new(0, 85, 0, 30)
        TabBtn.Position = UDim2.new(0, 0, 0, 5)
        TabBtn.BackgroundColor3 = Theme.Button
        TabBtn.Text = tabName
        TabBtn.Font = Enum.Font.GothamSemibold
        TabBtn.TextColor3 = Theme.SubText
        TabBtn.TextSize = 12
        TabBtn.Parent = TabContainer

        local TCorner = Instance.new("UICorner") TCorner.CornerRadius = UDim.new(0, 6) TCorner.Parent = TabBtn

        local TabPage = Instance.new("ScrollingFrame")
        TabPage.Size = UDim2.new(1, 0, 1, 0)
        TabPage.BackgroundTransparency = 1
        TabPage.Visible = false
        TabPage.ScrollBarThickness = 2
        TabPage.ScrollBarImageColor3 = Theme.Accent
        TabPage.Parent = ContentFrame

        local PageLayout = Instance.new("UIListLayout")
        PageLayout.Padding = UDim.new(0, 6)
        PageLayout.Parent = TabPage

        if firstTab then
            TabPage.Visible = true
            TabBtn.BackgroundColor3 = Theme.Secondary
            TabBtn.TextColor3 = Theme.Text
            firstTab = false
        end

        TabBtn.MouseButton1Click:Connect(function()
            for _, p in pairs(ContentFrame:GetChildren()) do if p:IsA("ScrollingFrame") then p.Visible = false end end
            for _, b in pairs(TabContainer:GetChildren()) do
                if b:IsA("TextButton") then b.BackgroundColor3 = Theme.Button b.TextColor3 = Theme.SubText end
            end
            TabPage.Visible = true
            TabBtn.BackgroundColor3 = Theme.Secondary
            TabBtn.TextColor3 = Theme.Text
        end)

        local Elements = {}

        function Elements:CreateButton(btnText, callback)
            local Btn = Instance.new("TextButton")
            Btn.Size = UDim2.new(1, -8, 0, 36)
            Btn.BackgroundColor3 = Theme.Button
            Btn.Text = "   " .. btnText
            Btn.Font = Enum.Font.GothamSemibold
            Btn.TextColor3 = Theme.Text
            Btn.TextSize = 12
            Btn.TextXAlignment = Enum.TextXAlignment.Left
            Btn.Parent = TabPage

            local BCorner = Instance.new("UICorner") BCorner.CornerRadius = UDim.new(0, 6) BCorner.Parent = Btn
            local BStroke = Instance.new("UIStroke") BStroke.Color = Theme.Header BStroke.Thickness = 1 BStroke.Parent = Btn

            Btn.MouseEnter:Connect(function() Btn.BackgroundColor3 = Theme.Hover end)
            Btn.MouseLeave:Connect(function() Btn.BackgroundColor3 = Theme.Button end)
            Btn.MouseButton1Click:Connect(function() if callback then callback() end end)
        end

        function Elements:CreateToggle(toggleText, callback)
            local TFrame = Instance.new("Frame")
            TFrame.Size = UDim2.new(1, -8, 0, 36)
            TFrame.BackgroundColor3 = Theme.Button
            TFrame.Parent = TabPage

            local FCorner = Instance.new("UICorner") FCorner.CornerRadius = UDim.new(0, 6) FCorner.Parent = TFrame

            local TLabel = Instance.new("TextLabel")
            TLabel.Size = UDim2.new(1, -50, 1, 0)
            TLabel.Position = UDim2.new(0, 12, 0, 0)
            TLabel.BackgroundTransparency = 1
            TLabel.Text = toggleText
            TLabel.Font = Enum.Font.GothamSemibold
            TLabel.TextColor3 = Theme.Text
            TLabel.TextSize = 12
            TLabel.TextXAlignment = Enum.TextXAlignment.Left
            TLabel.Parent = TFrame

            local Switch = Instance.new("Frame")
            Switch.Size = UDim2.new(0, 36, 0, 18)
            Switch.Position = UDim2.new(1, -44, 0.5, -9)
            Switch.BackgroundColor3 = Theme.Header
            Switch.Parent = TFrame
            local SCorner = Instance.new("UICorner") SCorner.CornerRadius = UDim.new(1, 0) SCorner.Parent = Switch

            local Circle = Instance.new("Frame")
            Circle.Size = UDim2.new(0, 14, 0, 14)
            Circle.Position = UDim2.new(0, 2, 0.5, -7)
            Circle.BackgroundColor3 = Theme.SubText
            Circle.Parent = Switch
            local CCorner = Instance.new("UICorner") CCorner.CornerRadius = UDim.new(1, 0) CCorner.Parent = Circle

            local toggled = false
            local ClickBtn = Instance.new("TextButton")
            ClickBtn.Size = UDim2.new(1, 0, 1, 0)
            ClickBtn.BackgroundTransparency = 1
            ClickBtn.Text = ""
            ClickBtn.Parent = TFrame

            ClickBtn.MouseButton1Click:Connect(function()
                toggled = not toggled
                local targetPos = toggled and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)
                local targetColor = toggled and Theme.Accent or Theme.SubText
                
                TweenService:Create(Circle, TweenInfo.new(0.2), {Position = targetPos, BackgroundColor3 = targetColor}):Play()
                if callback then callback(toggled) end
            end)
        end

        return Elements
    end

    return Tabs
end

-- ====================================================================
-- 6. RUN BLOCK GAME SCRIPT
-- ====================================================================
VerifyGameSupport(function()
    StartLoadingAnimation(function()

        local MyHub = AbyssalLib:CreateWindow('ABYSSAL <font color="#00DCFF">BLOCK HUB</font>')
        Notify("ABYSSAL HUB", "Loaded Block Game Modules!", 4)

        -- TAB 1: MAIN FUNCTION
        local MainTab = MyHub:CreateTab("Main")
        MainTab:CreateToggle("Auto Break Block", function(state)
            print("Auto Break Block:", state)
        end)
        MainTab:CreateToggle("Auto Collect Drops", function(state)
            print("Auto Collect Drops:", state)
        end)

        -- TAB 2: PLAYER FUNCTION
        local PlayerTab = MyHub:CreateTab("Player")
        PlayerTab:CreateButton("Speed Hack (WalkSpeed 50)", function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid.WalkSpeed = 50
                Notify("PLAYER", "WalkSpeed set to 50!", 2)
            end
        end)
        PlayerTab:CreateButton("High Jump (JumpPower 100)", function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid.JumpPower = 100
                Notify("PLAYER", "JumpPower set to 100!", 2)
            end
        end)

        -- TAB 3: SETTINGS
        local SettingsTab = MyHub:CreateTab("Settings")
        SettingsTab:CreateButton("Rejoin Game", function()
            game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
        end)

    end)
end)
