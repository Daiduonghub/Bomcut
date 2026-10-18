--[[ BlueWhite UI Library v1.0
     Theme : xanh dương pha trắng, góc vuông bo nhẹ (radius 6-8)
     API   :
        local Lib = loadstring(...)()
        local Win = Lib:CreateWindow({ Title = "BlueWhite", Size = UDim2.fromOffset(520, 360) })
        local Tab = Win:CreateTab("Main")
        Tab:CreateSection("Section")
        Tab:CreateToggle({ Name = "Enable", Default = false, Callback = function(v) end })
        Tab:CreateButton({ Name = "Click me", Callback = function() end })
        Tab:CreateSlider({ Name = "Speed", Min = 0, Max = 100, Default = 50, Step = 1, Callback = function(v) end })
        Win:Toggle() / Win:Toggle(true) / Win:Toggle(false)
]]

local Players           = game:GetService("Players")
local UserInputService  = game:GetService("UserInputService")
local RunService        = game:GetService("RunService")
local TweenService      = game:GetService("TweenService")
local CoreGui           = game:GetService("CoreGui")
local LP                = Players.LocalPlayer

--=========================================================
-- THEME
--=========================================================
local Theme = {
	Accent      = Color3.fromRGB(59, 130, 246),   -- xanh dương chính
	AccentSoft  = Color3.fromRGB(147, 197, 253),  -- xanh nhạt
	Bg          = Color3.fromRGB(240, 246, 255),  -- nền xanh pha trắng
	Panel       = Color3.fromRGB(255, 255, 255),  -- trắng
	Text        = Color3.fromRGB(30, 41, 59),     -- slate đậm
	Muted       = Color3.fromRGB(120, 138, 166),
	Stroke      = Color3.fromRGB(214, 229, 250),
	Off         = Color3.fromRGB(226, 235, 248),
	White       = Color3.fromRGB(255, 255, 255),
}

--=========================================================
-- HELPERS
--=========================================================
local function new(class, props, children)
	local inst = Instance.new(class)
	for k, v in pairs(props or {}) do
		if k ~= "Parent" then inst[k] = v end
	end
	for _, c in ipairs(children or {}) do c.Parent = inst end
	if props and props.Parent then inst.Parent = props.Parent end
	return inst
end

local function corner(inst, r)
	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, r or 6)
	c.Parent = inst
	return c
end

local function stroke(inst, color, thickness, transparency)
	local s = Instance.new("UIStroke")
	s.Color = color or Theme.Stroke
	s.Thickness = thickness or 1
	s.Transparency = transparency or 0
	s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	s.Parent = inst
	return s
end

local function tween(inst, time, props)
	local t = TweenService:Create(inst, TweenInfo.new(time or 0.15, Enum.EasingStyle.Quad), props)
	t:Play()
	return t
end

--=========================================================
-- LIBRARY
--=========================================================
local Lib = {}

function Lib:CreateWindow(cfg)
	cfg = cfg or {}

	local gui = new("ScreenGui", {
		Name = "BlueWhiteUI",
		ResetOnSpawn = false,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		IgnoreGuiInset = true,
	})
	local ok = pcall(function() gui.Parent = CoreGui end)
	if not ok then gui.Parent = LP:WaitForChild("PlayerGui") end

	-- // Main frame
	local main = new("Frame", {
		Parent = gui,
		Name = "Main",
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = cfg.Size or UDim2.fromOffset(520, 360),
		BackgroundColor3 = Theme.Panel,
		BorderSizePixel = 0,
	})
	corner(main, 10)
	stroke(main, Theme.Stroke, 1)

	-- // Title bar
	local bar = new("Frame", {
		Parent = main,
		Size = UDim2.new(1, 0, 0, 42),
		BackgroundColor3 = Theme.Bg,
		BorderSizePixel = 0,
		ZIndex = 2,
	})
	corner(bar, 10)
	-- làm phẳng 2 góc dưới của title bar
	new("Frame", {
		Parent = bar,
		Position = UDim2.new(0, 0, 1, -12),
		Size = UDim2.new(1, 0, 0, 12),
		BackgroundColor3 = Theme.Bg,
		BorderSizePixel = 0,
		ZIndex = 2,
	})

	-- // Accent square nhỏ cạnh title
	local accentSquare = new("Frame", {
		Parent = bar,
		Position = UDim2.new(0, 14, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		Size = UDim2.fromOffset(10, 10),
		BackgroundColor3 = Theme.Accent,
		BorderSizePixel = 0,
		ZIndex = 3,
	})
	corner(accentSquare, 3)

	local title = new("TextLabel", {
		Parent = bar,
		Position = UDim2.new(0, 32, 0, 0),
		Size = UDim2.new(1, -100, 1, 0),
		BackgroundTransparency = 1,
		Text = cfg.Title or "BlueWhite UI",
		TextXAlignment = Enum.TextXAlignment.Left,
		TextColor3 = Theme.Text,
		Font = Enum.Font.GothamBold,
		TextSize = 14,
		ZIndex = 3,
	})

	local ver = new("TextLabel", {
		Parent = bar,
		Position = UDim2.new(1, -80, 0, 0),
		Size = UDim2.new(0, 40, 1, 0),
		BackgroundTransparency = 1,
		Text = "v1.0",
		TextXAlignment = Enum.TextXAlignment.Right,
		TextColor3 = Theme.Muted,
		Font = Enum.Font.Gotham,
		TextSize = 11,
		ZIndex = 3,
	})

	-- // Nút vuông nhỏ bật/tắt UI
	local hideBtn = new("TextButton", {
		Parent = bar,
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, -12, 0.5, 0),
		Size = UDim2.fromOffset(22, 22),
		BackgroundColor3 = Theme.Panel,
		BorderSizePixel = 0,
		Text = "–",
		Font = Enum.Font.GothamBold,
		TextSize = 14,
		TextColor3 = Theme.Accent,
		AutoButtonColor = false,
		ZIndex = 3,
	})
	corner(hideBtn, 6)
	local hideStroke = stroke(hideBtn, Theme.Stroke, 1)

	hideBtn.MouseEnter:Connect(function()
		tween(hideBtn, 0.12, { BackgroundColor3 = Theme.Accent, TextColor3 = Theme.White })
		hideStroke.Color = Theme.Accent
	end)
	hideBtn.MouseLeave:Connect(function()
		tween(hideBtn, 0.12, { BackgroundColor3 = Theme.Panel, TextColor3 = Theme.Accent })
		hideStroke.Color = Theme.Stroke
	end)

	-- // Sidebar
	local sidebar = new("Frame", {
		Parent = main,
		Position = UDim2.new(0, 12, 0, 54),
		Size = UDim2.new(0, 124, 1, -66),
		BackgroundTransparency = 1,
	})
	new("UIListLayout", {
		Parent = sidebar,
		Padding = UDim.new(0, 6),
		SortOrder = Enum.SortOrder.LayoutOrder,
	})

	--=====================================================
	-- DRAG
	--=====================================================
	local dragging, dragStart, startPos
	bar.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = main.Position
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
		or input.UserInputType == Enum.UserInputType.Touch) then
			local d = input.Position - dragStart
			main.Position = UDim2.new(
				startPos.X.Scale, startPos.X.Offset + d.X,
				startPos.Y.Scale, startPos.Y.Offset + d.Y
			)
		end
	end)
	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then
			dragging = false
		end
	end)

	--=====================================================
	-- ELEMENT FACTORIES
	--=====================================================
	local function createSection(parent, name)
		local holder = new("Frame", {
			Parent = parent,
			Size = UDim2.new(1, 0, 0, 22),
			BackgroundTransparency = 1,
		})
		new("Frame", {
			Parent = holder,
			Position = UDim2.new(0, 2, 0.5, 0),
			AnchorPoint = Vector2.new(0, 0.5),
			Size = UDim2.fromOffset(3, 12),
			BackgroundColor3 = Theme.Accent,
			BorderSizePixel = 0,
		})
		new("TextLabel", {
			Parent = holder,
			Position = UDim2.new(0, 12, 0, 0),
			Size = UDim2.new(1, -12, 1, 0),
			BackgroundTransparency = 1,
			Text = string.upper(name or "Section"),
			TextXAlignment = Enum.TextXAlignment.Left,
			TextColor3 = Theme.Muted,
			Font = Enum.Font.GothamBold,
			TextSize = 10,
		})
		return { Instance = holder }
	end

	local function createToggle(parent, cfg)
		local row = new("Frame", {
			Parent = parent,
			Size = UDim2.new(1, 0, 0, 40),
			BackgroundColor3 = Theme.Bg,
			BorderSizePixel = 0,
		})
		corner(row, 8)

		new("TextLabel", {
			Parent = row,
			Position = UDim2.new(0, 12, 0, 0),
			Size = UDim2.new(1, -56, 1, 0),
			BackgroundTransparency = 1,
			Text = cfg.Name or "Toggle",
			TextXAlignment = Enum.TextXAlignment.Left,
			TextColor3 = Theme.Text,
			Font = Enum.Font.GothamMedium,
			TextSize = 13,
		})

		local box = new("TextButton", {
			Parent = row,
			AnchorPoint = Vector2.new(1, 0.5),
			Position = UDim2.new(1, -12, 0.5, 0),
			Size = UDim2.fromOffset(22, 22),
			BackgroundColor3 = Theme.Off,
			BorderSizePixel = 0,
			Text = "",
			AutoButtonColor = false,
		})
		corner(box, 6)
		local boxStroke = stroke(box, Theme.Stroke, 1)

		local dot = new("Frame", {
			Parent = box,
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			Size = UDim2.fromOffset(0, 0),
			BackgroundColor3 = Theme.White,
			BorderSizePixel = 0,
		})
		corner(dot, 3)

		local state = false
		local function set(v, fire)
			state = v and true or false
			tween(box, 0.15, { BackgroundColor3 = state and Theme.Accent or Theme.Off })
			tween(dot, 0.15, { Size = state and UDim2.fromOffset(10, 10) or UDim2.fromOffset(0, 0) })
			boxStroke.Color = state and Theme.Accent or Theme.Stroke
			if fire and cfg.Callback then task.spawn(cfg.Callback, state) end
		end

		box.MouseButton1Click:Connect(function() set(not state, true) end)
		box.MouseEnter:Connect(function()
			if not state then tween(box, 0.12, { BackgroundColor3 = Theme.AccentSoft }) end
		end)
		box.MouseLeave:Connect(function()
			if not state then tween(box, 0.12, { BackgroundColor3 = Theme.Off }) end
		end)

		set(cfg.Default == true, false)

		return {
			Instance = row,
			Set = function(v) set(v, false) end,
			Get = function() return state end,
		}
	end

	local function createButton(parent, cfg)
		local btn = new("TextButton", {
			Parent = parent,
			Size = UDim2.new(1, 0, 0, 36),
			BackgroundColor3 = Theme.Bg,
			BorderSizePixel = 0,
			Text = cfg.Name or "Button",
			Font = Enum.Font.GothamMedium,
			TextSize = 13,
			TextColor3 = Theme.Text,
			AutoButtonColor = false,
		})
		corner(btn, 8)
		local st = stroke(btn, Theme.Stroke, 1)

		btn.MouseEnter:Connect(function()
			tween(btn, 0.12, { BackgroundColor3 = Theme.Accent, TextColor3 = Theme.White })
			st.Color = Theme.Accent
		end)
		btn.MouseLeave:Connect(function()
			tween(btn, 0.12, { BackgroundColor3 = Theme.Bg, TextColor3 = Theme.Text })
			st.Color = Theme.Stroke
		end)
		btn.MouseButton1Click:Connect(function()
			if cfg.Callback then task.spawn(cfg.Callback) end
		end)

		return { Instance = btn }
	end

	local function createSlider(parent, cfg)
		local minV  = cfg.Min or 0
		local maxV  = cfg.Max or 100
		local step  = cfg.Step or 1
		local value = cfg.Default or minV

		local row = new("Frame", {
			Parent = parent,
			Size = UDim2.new(1, 0, 0, 54),
			BackgroundColor3 = Theme.Bg,
			BorderSizePixel = 0,
		})
		corner(row, 8)

		new("TextLabel", {
			Parent = row,
			Position = UDim2.new(0, 12, 0, 9),
			Size = UDim2.new(1, -90, 0, 14),
			BackgroundTransparency = 1,
			Text = cfg.Name or "Slider",
			TextXAlignment = Enum.TextXAlignment.Left,
			TextColor3 = Theme.Text,
			Font = Enum.Font.GothamMedium,
			TextSize = 13,
		})

		local valLabel = new("TextLabel", {
			Parent = row,
			AnchorPoint = Vector2.new(1, 0),
			Position = UDim2.new(1, -12, 0, 9),
			Size = UDim2.new(0, 60, 0, 14),
			BackgroundTransparency = 1,
			Text = tostring(value),
			TextXAlignment = Enum.TextXAlignment.Right,
			TextColor3 = Theme.Accent,
			Font = Enum.Font.GothamBold,
			TextSize = 13,
		})

		local track = new("Frame", {
			Parent = row,
			Position = UDim2.new(0, 12, 0, 36),
			Size = UDim2.new(1, -24, 0, 6),
			BackgroundColor3 = Theme.Off,
			BorderSizePixel = 0,
		})
		corner(track, 3)

		local fill = new("Frame", {
			Parent = track,
			Size = UDim2.new(0, 0, 1, 0),
			BackgroundColor3 = Theme.Accent,
			BorderSizePixel = 0,
		})
		corner(fill, 3)

		local knob = new("Frame", {
			Parent = track,
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.new(0, 0, 0.5, 0),
			Size = UDim2.fromOffset(12, 12),
			BackgroundColor3 = Theme.White,
			BorderSizePixel = 0,
			ZIndex = 3,
		})
		corner(knob, 4)
		stroke(knob, Theme.Accent, 2)

		local function set(v, fire)
			v = math.clamp(v, minV, maxV)
			if step > 0 then v = math.floor(v / step + 0.5) * step end
			v = math.clamp(v, minV, maxV)
			value = v
			local a = (v - minV) / math.max(maxV - minV, 1e-6)
			fill.Size = UDim2.fromScale(a, 1)
			knob.Position = UDim2.fromScale(a, 0.5)
			valLabel.Text = (step >= 1) and tostring(math.floor(v)) or string.format("%.2f", v)
			if fire and cfg.Callback then task.spawn(cfg.Callback, v) end
		end

		local sliding = false
		local function fromInput(input)
			local rel = (input.Position.X - track.AbsolutePosition.X) / math.max(track.AbsoluteSize.X, 1)
			set(minV + (maxV - minV) * math.clamp(rel, 0, 1), true)
		end

		track.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then
				sliding = true
				fromInput(input)
			end
		end)
		UserInputService.InputChanged:Connect(function(input)
			if sliding and (input.UserInputType == Enum.UserInputType.MouseMovement
			or input.UserInputType == Enum.UserInputType.Touch) then
				fromInput(input)
			end
		end)
		UserInputService.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then
				sliding = false
			end
		end)

		set(value, false)

		return {
			Instance = row,
			Set = function(v) set(v, false) end,
			Get = function() return value end,
		}
	end

	--=====================================================
	-- WINDOW API
	--=====================================================
	local Window = {}
	local tabOrder = 0
	local pages = {}

	function Window:CreateTab(name)
		tabOrder += 1
		local myOrder = tabOrder

		-- // page
		local page = new("ScrollingFrame", {
			Parent = main,
			Position = UDim2.new(0, 148, 0, 54),
			Size = UDim2.new(1, -160, 1, -66),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			CanvasSize = UDim2.new(0, 0, 0, 0),
			AutomaticCanvasSize = Enum.AutomaticSize.Y,
			ScrollingDirection = Enum.ScrollingDirection.Y,
			ScrollBarThickness = 3,
			ScrollBarImageColor3 = Theme.AccentSoft,
			Visible = false,
		})
		new("UIListLayout", {
			Parent = page,
			Padding = UDim.new(0, 6),
			SortOrder = Enum.SortOrder.LayoutOrder,
		})
		new("UIPadding", {
			Parent = page,
			PaddingTop = UDim.new(0, 2),
			PaddingBottom = UDim.new(0, 8),
			PaddingRight = UDim.new(0, 6),
		})

		-- // tab button
		local tabBtn = new("TextButton", {
			Parent = sidebar,
			Size = UDim2.new(1, 0, 0, 34),
			BackgroundColor3 = Theme.Panel,
			BorderSizePixel = 0,
			Text = "   " .. (name or "Tab"),
			TextXAlignment = Enum.TextXAlignment.Left,
			TextColor3 = Theme.Muted,
			Font = Enum.Font.GothamMedium,
			TextSize = 13,
			LayoutOrder = myOrder,
			AutoButtonColor = false,
		})
		corner(tabBtn, 6)
		local tabStroke = stroke(tabBtn, Theme.Stroke, 1)

		local function select()
			for _, p in ipairs(pages) do p.page.Visible = false end
			for _, b in ipairs(pages) do
				tween(b.btn, 0.12, { BackgroundColor3 = Theme.Panel, TextColor3 = Theme.Muted })
				b.stroke.Color = Theme.Stroke
			end
			page.Visible = true
			tween(tabBtn, 0.12, { BackgroundColor3 = Theme.Accent, TextColor3 = Theme.White })
			tabStroke.Color = Theme.Accent
		end

		tabBtn.MouseButton1Click:Connect(select)
		tabBtn.MouseEnter:Connect(function()
			if not page.Visible then
				tween(tabBtn, 0.12, { BackgroundColor3 = Theme.Bg, TextColor3 = Theme.Text })
			end
		end)
		tabBtn.MouseLeave:Connect(function()
			if not page.Visible then
				tween(tabBtn, 0.12, { BackgroundColor3 = Theme.Panel, TextColor3 = Theme.Muted })
			end
		end)

		table.insert(pages, { page = page, btn = tabBtn, stroke = tabStroke })

		-- // tab API
		local Tab = {}
		local elOrder = 0
		local function nextOrder() elOrder += 1 return elOrder end

		function Tab:CreateSection(n)
			local o = createSection(page, n)
			o.Instance.LayoutOrder = nextOrder()
			return o
		end

		function Tab:CreateToggle(c)
			c = c or {}
			local o = createToggle(page, c)
			o.Instance.LayoutOrder = nextOrder()
			return o
		end

		function Tab:CreateButton(c)
			c = c or {}
			local o = createButton(page, c)
			o.Instance.LayoutOrder = nextOrder()
			return o
		end

		function Tab:CreateSlider(c)
			c = c or {}
			local o = createSlider(page, c)
			o.Instance.LayoutOrder = nextOrder()
			return o
		end

		if tabOrder == 1 then select() end

		return Tab
	end

	function Window:Toggle(v)
		if v == nil then
			main.Visible = not main.Visible
		else
			main.Visible = v and true or false
		end
	end

	function Window:Destroy()
		gui:Destroy()
	end

	-- // Nút vuông nhỏ + keybind
	hideBtn.MouseButton1Click:Connect(function() Window:Toggle() end)
	UserInputService.InputBegan:Connect(function(input, gpe)
		if gpe then return end
		if input.KeyCode == Enum.KeyCode.RightShift then
			Window:Toggle()
		end
	end)

	return Window
end

--=========================================================
-- ESP PLAYER : tên (DisplayName) + khoảng cách
--=========================================================
local ESP = {
	Enabled = false,
	MaxDistance = 1000,
	Cache = {},
	Conns = {},
}

local espGuiHolder = Instance.new("Folder")
espGuiHolder.Name = "BW_ESP"

local function espBuild(plr)
	if plr == LP then return end
	local char = plr.Character
	if not char then return end
	local head = char:FindFirstChild("Head")
	if not head then return end
	if ESP.Cache[plr] then ESP.Cache[plr]:Destroy() end

	local bb = Instance.new("BillboardGui")
	bb.Name = "BW_Tag"
	bb.Adornee = head
	bb.Size = UDim2.fromOffset(200, 40)
	bb.StudsOffset = Vector3.new(0, 2.3, 0)
	bb.AlwaysOnTop = true
	bb.LightInfluence = 0
	bb.MaxDistance = ESP.MaxDistance
	bb.Parent = head

	local label = Instance.new("TextLabel")
	label.Name = "Tag"
	label.Size = UDim2.fromScale(1, 1)
	label.BackgroundTransparency = 1
	label.Text = plr.DisplayName
	label.TextScaled = true
	label.Font = Enum.Font.GothamBold
	label.TextColor3 = Theme.White
	label.TextStrokeColor3 = Theme.Accent
	label.TextStrokeTransparency = 0.2
	label.Parent = bb

	local constraint = Instance.new("UITextSizeConstraint")
	constraint.MaxTextSize = 16
	constraint.MinTextSize = 8
	constraint.Parent = label

	ESP.Cache[plr] = bb
end

local function espRemove(plr)
	local conns = ESP.Conns[plr]
	if conns then
		for _, c in ipairs(conns) do c:Disconnect() end
		ESP.Conns[plr] = nil
	end
	if ESP.Cache[plr] then
		ESP.Cache[plr]:Destroy()
		ESP.Cache[plr] = nil
	end
end

local function espAdd(plr)
	if plr == LP then return end
	espRemove(plr)
	local conns = {}
	ESP.Conns[plr] = conns

	espBuild(plr)
	table.insert(conns, plr.CharacterAdded:Connect(function()
		task.wait(0.25)
		if ESP.Enabled then espBuild(plr) end
	end))
end

function ESP:Enable()
	if self.Enabled then return end
	self.Enabled = true
	for _, p in ipairs(Players:GetPlayers()) do espAdd(p) end
	self.PlayerAdded = Players.PlayerAdded:Connect(function(p) if self.Enabled then espAdd(p) end end)
	self.PlayerRemoving = Players.PlayerRemoving:Connect(function(p) espRemove(p) end)
end

function ESP:Disable()
	self.Enabled = false
	if self.PlayerAdded then self.PlayerAdded:Disconnect() end
	if self.PlayerRemoving then self.PlayerRemoving:Disconnect() end
	for plr in pairs(ESP.Cache) do espRemove(plr) end
end

function ESP:SetMaxDistance(d)
	self.MaxDistance = d
end

-- // update loop
local acc = 0
RunService.RenderStepped:Connect(function(dt)
	if not ESP.Enabled then return end
	acc += dt
	if acc < 0.1 then return end
	acc = 0

	local lpChar = LP.Character
	local lpRoot = lpChar and lpChar:FindFirstChild("HumanoidRootPart")

	for plr, bb in pairs(ESP.Cache) do
		if not (bb and bb.Parent) then
			ESP.Cache[plr] = nil
			continue
		end
		local char = plr.Character
		local root = char and char:FindFirstChild("HumanoidRootPart")
		local hum  = char and char:FindFirstChildOfClass("Humanoid")
		local tag  = bb:FindFirstChild("Tag")

		if root and lpRoot and hum and hum.Health > 0 and tag then
			local dist = (root.Position - lpRoot.Position).Magnitude
			bb.MaxDistance = ESP.MaxDistance
			bb.Enabled = dist <= ESP.MaxDistance
			tag.Text = string.format("%s  ·  %dm", plr.DisplayName, math.floor(dist + 0.5))
		else
			bb.Enabled = false
		end
	end
end)

--=========================================================
-- DEMO
--=========================================================
local Win = Lib:CreateWindow({ Title = "BlueWhite UI", Size = UDim2.fromOffset(520, 360) })

-- // Tab 1
local MainTab = Win:CreateTab("Main")
MainTab:CreateSection("Cơ bản")
MainTab:CreateToggle({
	Name = "Auto Farm",
	Default = false,
	Callback = function(v)
		print("[Demo] Auto Farm:", v)
	end,
})
MainTab:CreateSlider({
	Name = "Attack Speed",
	Min = 1, Max = 20, Default = 5, Step = 1,
	Callback = function(v) print("[Demo] Speed:", v) end,
})
MainTab:CreateButton({
	Name = "Print Hello",
	Callback = function() print("[Demo] hello from BlueWhite UI") end,
})

-- // Tab 2
local VisualTab = Win:CreateTab("Visuals")
VisualTab:CreateSection("ESP")
local espToggle
espToggle = VisualTab:CreateToggle({
	Name = "ESP Player (Name + Distance)",
	Default = false,
	Callback = function(v)
		if v then ESP:Enable() else ESP:Disable() end
	end,
})
VisualTab:CreateSlider({
	Name = "Max Distance (studs)",
	Min = 100, Max = 5000, Default = 1000, Step = 50,
	Callback = function(v) ESP:SetMaxDistance(v) end,
})

-- // Tab 3
local SettingsTab = Win:CreateTab("Settings")
SettingsTab:CreateSection("UI")
SettingsTab:CreateButton({
	Name = "Ẩn / Hiện UI (RightShift)",
	Callback = function() Win:Toggle() end,
})
SettingsTab:CreateButton({
	Name = "Destroy UI",
	Callback = function()
		ESP:Disable()
		Win:Destroy()
	end,
})

return Lib