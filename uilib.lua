
    local CoreGui = game:GetService("CoreGui")
    local TweenService = game:GetService("TweenService")
    local UserInputService = game:GetService("UserInputService")
    
    local Mouse = game.Players.LocalPlayer:GetMouse()
    
    local Blacklist = {
        Enum.KeyCode.Unknown,
        Enum.KeyCode.CapsLock,
        Enum.KeyCode.Escape,
        Enum.KeyCode.Tab,
        Enum.KeyCode.Return,
        Enum.KeyCode.Backspace,
        Enum.KeyCode.Space,
        Enum.KeyCode.W,
        Enum.KeyCode.A,
        Enum.KeyCode.S,
        Enum.KeyCode.D
    }
    
    if CoreGui:FindFirstChild("Shaman") then
        CoreGui.Shaman:Destroy()
        CoreGui.Tooltips:Destroy()
    end
    
    local function CheckTable(table)
        local i = 0
        for _, v in pairs(table) do
            i = i + 1
        end
        return i
    end
    
    local TabSelected = nil
    local EditOpened = false
    local ColorElements = {}
    
    task.spawn(
        function()
            while true do
                if EditOpened and CheckTable(ColorElements) > 0 then
                    local hue = tick() % 7 / 7
                    local color = Color3.fromHSV(hue, 1, 1)
    
                    for frame, v in pairs(ColorElements) do
                        if v.Enabled then
                            if frame.ClassName == "Frame" then
                                frame.BackgroundColor3 = color
                            else
                                frame.ImageColor3 = color
                            end
                        end
                    end
                end
                wait()
            end
        end
    )
    
    local library = {
        Flags = {}
    }
    
    local request = syn and syn.request or http and http.request or http_request or request or httprequest
    local getcustomasset = getcustomasset or getsynasset
    local isfolder = isfolder or syn_isfolder or is_folder
    local makefolder = makefolder or make_folder or createfolder or create_folder
    
    if not isfolder("Shaman") then
        makefolder("Shaman")
    end
    
    function library:GetXY(GuiObject)
        local Max, May = GuiObject.AbsoluteSize.X, GuiObject.AbsoluteSize.Y
        local Px, Py =
            math.clamp(Mouse.X - GuiObject.AbsolutePosition.X, 0, Max),
            math.clamp(Mouse.Y - GuiObject.AbsolutePosition.Y, 0, May)
        return Px / Max, Py / May
    end
    
    function library:Window(Info)
        Info.Text = Info.Text or "Shaman"
    
        local window = {}
    
        local shamanScreenGui = Instance.new("ScreenGui")
        shamanScreenGui.Name = "Shaman"
        shamanScreenGui.Parent = CoreGui
        shamanScreenGui.Enabled = false
    
        local tooltipScreenGui = Instance.new("ScreenGui")
        tooltipScreenGui.Name = "Tooltips"
        tooltipScreenGui.Parent = CoreGui
    
        local function Tooltip(text)
            local tooltip = Instance.new("Frame")
            tooltip.Name = "Tooltip"
            tooltip.AnchorPoint = Vector2.new(0.5, 0)
            tooltip.BackgroundColor3 = Color3.fromRGB(79, 79, 79)
            tooltip.Visible = false
            tooltip.Position = UDim2.new(0.352, 0, 0.0741, 0)
            tooltip.Size = UDim2.new(0, 100, 0, 19)
            tooltip.ZIndex = 5
            tooltip.Parent = tooltipScreenGui
    
            local newuICorner = Instance.new("UICorner")
            newuICorner.Name = "UICorner"
            newuICorner.CornerRadius = UDim.new(0, 3)
            newuICorner.Parent = tooltip
    
            local newuIStroke = Instance.new("UIStroke")
            newuIStroke.Name = "UIStroke"
            newuIStroke.Color = Color3.fromRGB(98, 98, 98)
            newuIStroke.Parent = tooltip
    
            local tooltipText = Instance.new("TextLabel")
            tooltipText.Name = "TooltipText"
            tooltipText.Font = Enum.Font.GothamBold
            tooltipText.Text = text
            tooltipText.TextColor3 = Color3.fromRGB(217, 217, 217)
            tooltipText.TextSize = 11
            tooltipText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            tooltipText.BackgroundTransparency = 1
            tooltipText.Size = UDim2.new(0, 100, 0, 19)
            tooltipText.Parent = tooltip
            tooltipText.ZIndex = 6
    
            local TextBounds = tooltipText.TextBounds
    
            tooltip.Size = UDim2.new(0, TextBounds.X + 10, 0, 19)
            tooltipText.Size = UDim2.new(0, TextBounds.X + 10, 0, 19)
    
            return tooltip
        end
    
        local function AddTooltip(element, text)
            local Tooltip = Tooltip(text)
            local Hovered = false
    
            local function Update()
                local MousePos = UserInputService:GetMouseLocation()
                local Viewport = workspace.CurrentCamera.ViewportSize
    
                Tooltip.Position =
                    UDim2.new(MousePos.X / Viewport.X, 0, MousePos.Y / Viewport.Y, 0) + UDim2.new(0, 0, 0, -43)
            end
    
            element.MouseEnter:Connect(
                function()
                    Hovered = true
                    wait(.5)
                    if Hovered then
                        Tooltip.Visible = true
                    end
                end
            )
    
            element.MouseLeave:Connect(
                function()
                    Hovered = false
                    Tooltip.Visible = false
                end
            )
    
            element.MouseMoved:Connect(
                function()
                    Update()
                end
            )
        end
    
        local main = Instance.new("Frame")
        main.Name = "Main"
        main.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
        main.BorderSizePixel = 0
        main.ClipsDescendants = true
        main.Position = UDim2.new(0.361, 0, 0.308, 0)
        main.Size = UDim2.new(0, 450, 0, 321)
        main.Parent = shamanScreenGui
    
        local uICorner = Instance.new("UICorner")
        uICorner.Name = "UICorner"
        uICorner.CornerRadius = UDim.new(0, 5)
        uICorner.Parent = main
    
        local topbar = Instance.new("Frame")
        topbar.Name = "Topbar"
        topbar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        topbar.Size = UDim2.new(0, 450, 0, 31)
        topbar.Parent = main
        topbar.ZIndex = 2
    
        local TopBarPressKey = Enum.KeyCode.RightShift
        local TopBarIsKeyDown = false
        local TopbarHasToggled = false
        
        local TopBarkeybindFrame = Instance.new("Frame")
        TopBarkeybindFrame.Name = "TopBarKeybindFrame"
        TopBarkeybindFrame.BackgroundColor3 = Color3.fromRGB(68, 68, 68)
        TopBarkeybindFrame.AnchorPoint = Vector2.new(1, 0)
        TopBarkeybindFrame.BorderSizePixel = 0
        TopBarkeybindFrame.BackgroundTransparency = 0
        TopBarkeybindFrame.Position = UDim2.new(0.825, 0, 0.225, 0)
        TopBarkeybindFrame.Size = UDim2.new(0, 40, 0, 20)
        TopBarkeybindFrame.Parent = topbar
        TopBarkeybindFrame.Visible = true
        TopBarkeybindFrame.ZIndex = 3
    
        local TopBarkeybindUICorner = Instance.new("UICorner")
        TopBarkeybindUICorner.Name = "TopBarKeybindUICorner"
        TopBarkeybindUICorner.CornerRadius = UDim.new(0, 3)
        TopBarkeybindUICorner.Parent = TopBarkeybindFrame
    
        local TopBarkeybindFrameText = Instance.new("TextLabel")
        TopBarkeybindFrameText.Name = "TopBarKeybindFrameText"
        TopBarkeybindFrameText.Font = Enum.Font.GothamBold
        TopBarkeybindFrameText.Text = "Right Shift"
        TopBarkeybindFrameText.TextColor3 = Color3.fromRGB(217, 217, 217)
        TopBarkeybindFrameText.TextSize = 11
        TopBarkeybindFrameText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TopBarkeybindFrameText.Size = UDim2.new(1, 0, 0, 15)
        TopBarkeybindFrameText.BackgroundTransparency = 1
        TopBarkeybindFrameText.Parent = TopBarkeybindFrame
        TopBarkeybindFrameText.ZIndex = 4
    
        local TopBarkeybindButton = Instance.new("TextButton")
        TopBarkeybindButton.Name = "TopBarKeybindButton"
        TopBarkeybindButton.Font = Enum.Font.SourceSans
        TopBarkeybindButton.Text = ""
        TopBarkeybindButton.TextColor3 = Color3.fromRGB(0, 0, 0)
        TopBarkeybindButton.TextSize = 14
        TopBarkeybindButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TopBarkeybindButton.BackgroundTransparency = 1
        TopBarkeybindButton.Size = UDim2.new(1, 0, 0, 15)
        TopBarkeybindButton.Parent = TopBarkeybindFrame
    
        local TopBarkeybindUIStroke = Instance.new("UIStroke")
        TopBarkeybindUIStroke.Name = "TopBarKeybindUIStroke"
        TopBarkeybindUIStroke.Color = Color3.fromRGB(84, 84, 84)
        TopBarkeybindUIStroke.Parent = TopBarkeybindFrame
    
        local TextBounds = TopBarkeybindFrameText.TextBounds
    
        TopBarkeybindFrame.Size = UDim2.new(0, TextBounds.X + 10, 0, 15)
    
        TopBarkeybindFrameText:GetPropertyChangedSignal("Text"):Connect(
            function()
                TextBounds = TopBarkeybindFrameText.TextBounds
    
                TopBarkeybindFrame.Size = UDim2.new(0, TextBounds.X + 10, 0, 15)
            end
        )
    
        local KeybindConnection
        local Changing = false
    
        TopBarkeybindButton.MouseButton1Click:Connect(
            function()
                if KeybindConnection then
                    KeybindConnection:Disconnect()
                end
                Changing = true
                TopBarkeybindFrameText.Text = "..."
                KeybindConnection =
                    UserInputService.InputBegan:Connect(
                    function(Key, gameProcessed)
                        if not table.find(Blacklist, Key.KeyCode) and not gameProcessed then
                            KeybindConnection:Disconnect()
                            TopBarkeybindFrameText.Text = Key.KeyCode.Name
                            TopBarPressKey = Key.KeyCode
                            wait(.1)
                            Changing = false
                        end
                    end
                )
            end
        )
    
        local TopBarKeyPressed = false
        
        UserInputService.InputBegan:Connect(
            function(Key, gameProcessed)
                if not Changing and Key.KeyCode == TopBarPressKey and not gameProcessed then
                    if not KeyPressed then
                        TopBarIsKeyDown = true
                        TopBarKeyPressed = true
                    else
                        TopBarIsKeyDown = false
                        TopBarKeyPressed = false
                    end
                    task.spawn(
                        function()
                            game:GetService("CoreGui").Shaman.Enabled = not game:GetService("CoreGui").Shaman.Enabled
                        end
                    )
                end
            end
        )
    
        local dragging
        local dragInput
        local dragStart
        local startPos
    
        local function update(input)
            local delta = input.Position - dragStart
            main.Position =
                UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    
        topbar.InputBegan:Connect(
            function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = true
                    dragStart = input.Position
                    startPos = main.Position
    
                    input.Changed:Connect(
                        function()
                            if input.UserInputState == Enum.UserInputState.End then
                                dragging = false
                            end
                        end
                    )
                end
            end
        )
    
        topbar.InputChanged:Connect(
            function(input)
                if
                    input.UserInputType == Enum.UserInputType.MouseMovement or
                        input.UserInputType == Enum.UserInputType.Touch
                 then
                    dragInput = input
                end
            end
        )
    
        UserInputService.InputChanged:Connect(
            function(input)
                if input == dragInput and dragging then
                    update(input)
                end
            end
        )
    
        local uICorner1 = Instance.new("UICorner")
        uICorner1.Name = "UICorner"
        uICorner1.Parent = topbar
    
        local frame = Instance.new("Frame")
        frame.Name = "Frame"
        frame.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
        frame.BorderSizePixel = 0
        frame.Position = UDim2.new(0, 0, 0.625, 0)
        frame.Size = UDim2.new(0, 450, 0, 11)
        frame.Parent = topbar
    
        local frame1 = Instance.new("Frame")
        frame1.Name = "Frame"
        frame1.AnchorPoint = Vector2.new(0.5, 1)
        frame1.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
        frame1.BorderSizePixel = 0
        frame1.Position = UDim2.new(0.5, 0, 1, 0)
        frame1.Size = UDim2.new(0, 450, 0, 1)
        frame1.ZIndex = 2
        frame1.Parent = frame
    
        local uIGradient = Instance.new("UIGradient")
        uIGradient.Name = "UIGradient"
        uIGradient.Color =
            ColorSequence.new(
            {
                ColorSequenceKeypoint.new(0, Color3.fromRGB(183, 248, 219)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(80, 167, 194))
            }
        )
        uIGradient.Enabled = false
        uIGradient.Parent = frame1
    
        local textLabel = Instance.new("TextLabel")
        textLabel.Name = "TextLabel"
        textLabel.Font = Enum.Font.GothamBold
        textLabel.Text = Info.Text
        textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        textLabel.TextSize = 12
        textLabel.TextXAlignment = Enum.TextXAlignment.Left
        textLabel.BackgroundColor3 = Color3.fromRGB(237, 237, 237)
        textLabel.BackgroundTransparency = 1
        textLabel.Position = UDim2.new(0.015, 0, 0, 0)
        textLabel.Size = UDim2.new(0, 51, 0, 30)
        textLabel.ZIndex = 2
        textLabel.Parent = topbar
    
        local closeButton = Instance.new("ImageButton")
        closeButton.Name = "CloseButton"
        closeButton.Image = "rbxassetid://14657536968"
        closeButton.ImageColor3 = Color3.fromRGB(237, 237, 237)
        closeButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        closeButton.BackgroundTransparency = 1
        closeButton.Position = UDim2.new(0.947, 0, 0.194, 0)
        closeButton.Size = UDim2.new(0, 17, 0, 17)
        closeButton.ZIndex = 2
        closeButton.Parent = topbar
    
        closeButton.MouseButton1Click:Once(
            function()
                shamanScreenGui:Destroy()
                tooltipScreenGui:Destroy()
            end
        )
    
        closeButton.MouseEnter:Connect(
            function()
                TweenService:Create(
                    closeButton,
                    TweenInfo.new(.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                    {ImageColor3 = Color3.fromRGB(217, 97, 99)}
                ):Play()
            end
        )
    
        closeButton.MouseLeave:Connect(
            function()
                TweenService:Create(
                    closeButton,
                    TweenInfo.new(.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                    {ImageColor3 = Color3.fromRGB(217, 217, 217)}
                ):Play()
            end
        )
    
        local minimizeButton = Instance.new("ImageButton")
        minimizeButton.Name = "MinimizeButton"
        minimizeButton.Image = "rbxassetid://10664064072"
        minimizeButton.ImageColor3 = Color3.fromRGB(237, 237, 237)
        minimizeButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        minimizeButton.BackgroundTransparency = 1
        minimizeButton.Position = UDim2.new(0.893, 0, 0.194, 0)
        minimizeButton.Size = UDim2.new(0, 17, 0, 17)
        minimizeButton.ZIndex = 2
        minimizeButton.Parent = topbar
    
        minimizeButton.MouseEnter:Connect(
            function()
                TweenService:Create(
                    minimizeButton,
                    TweenInfo.new(.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                    {ImageColor3 = Color3.fromRGB(194, 162, 76)}
                ):Play()
            end
        )
    
        minimizeButton.MouseLeave:Connect(
            function()
                TweenService:Create(
                    minimizeButton,
                    TweenInfo.new(.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                    {ImageColor3 = Color3.fromRGB(217, 217, 217)}
                ):Play()
            end
        )
    
        local Opened = true
    
        minimizeButton.MouseButton1Click:Connect(
            function()
                Opened = not Opened
    
                topbar.Frame.Visible = Opened
                task.spawn(
                    function()
                        if Opened then
                            wait(.15)
                        end
                        for _, v in pairs(main:GetChildren()) do
                            if v.Name == "TabContainer" then
                                v.Visible = Opened
                            end
                        end
                        for _, v in pairs(main:GetChildren()) do
                            if v.Name == "LeftContainer" or v.Name == "RightContainer" and v.Visible then
                                v.Size = Opened and UDim2.new(0, 168, 0, 287) or UDim2.new(0, 168, 0, 0)
                            end
                        end
                    end
                )
    
                TweenService:Create(
                    main,
                    TweenInfo.new(.2, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                    {Size = Opened and UDim2.new(0, 450, 0, 321) or UDim2.new(0, 450, 0, 30)}
                ):Play()
            end
        )
    
        local editButton = Instance.new("ImageButton")
        editButton.Name = "EditButton"
        editButton.Image = "rbxassetid://14658183938"
        editButton.ImageColor3 = Color3.fromRGB(237, 237, 237)
        editButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        editButton.BackgroundTransparency = 1
        editButton.Position = UDim2.new(0.841, 0, 0.226, 0)
        editButton.Size = UDim2.new(0, 15, 0, 15)
        editButton.ZIndex = 2
        editButton.Parent = topbar
    
        local uiGradient = Instance.new("UIGradient")
        uiGradient.Name = "UIGradient"
        uiGradient.Enabled = false
        uiGradient.Color =
            ColorSequence.new {
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
            ColorSequenceKeypoint.new(0.2, Color3.fromRGB(255, 255, 0)),
            ColorSequenceKeypoint.new(0.4, Color3.fromRGB(0, 255, 0)),
            ColorSequenceKeypoint.new(0.6, Color3.fromRGB(0, 255, 255)),
            ColorSequenceKeypoint.new(0.8, Color3.fromRGB(0, 0, 255)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 255))
        }
        uiGradient.Parent = editButton
    
        task.spawn(
            function()
                while wait() do -- skidded from devforum
                    if uiGradient.Enabled then
                        local loop = tick() % 2 / 2
                        colors = {}
                        for i = 1, 7 + 1, 1 do
                            z = Color3.fromHSV(loop - ((i - 1) / 7), 1, 1)
                            if loop - ((i - 1) / 7) < 0 then
                                z = Color3.fromHSV((loop - ((i - 1) / 7)) + 1, 1, 1)
                            end
                            local d = ColorSequenceKeypoint.new((i - 1) / 7, z)
                            table.insert(colors, #colors + 1, d)
                        end
                        uiGradient.Color = ColorSequence.new(colors)
                        getgenv().UIRainbow = uiGradient.Color
                    end
                end
            end
        )
    
        editButton.MouseEnter:Connect(
            function()
                if not EditOpened then
                    uiGradient.Enabled = true
                end
            end
        )
    
        editButton.MouseLeave:Connect(
            function()
                if not EditOpened then
                    uiGradient.Enabled = false
                end
            end
        )
    
        editButton.MouseButton1Click:Connect(
            function()
                EditOpened = not EditOpened
    
                uiGradient.Enabled = EditOpened and true or false
    
                if not EditOpened then
                    for frame, v in pairs(ColorElements) do
                        if v.Enabled then
                            if frame.ClassName == "Frame" then
                                TweenService:Create(
                                    frame,
                                    TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                                    {BackgroundColor3 = Color3.fromRGB(48, 207, 106)}
                                ):Play()
                            else
                                TweenService:Create(
                                    frame,
                                    TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                                    {ImageColor3 = Color3.fromRGB(48, 207, 106)}
                                ):Play()
                            end
                        end
                    end
                else
                    for _, v in pairs(ColorElements) do
                        if v.Type ~= "Toggle" then
                            v.Enabled = true
                        end
                    end
                end
            end
        )
    
        local tabContainer = Instance.new("Frame")
        tabContainer.Name = "TabContainer"
        tabContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        tabContainer.Position = UDim2.new(0, 0, 0.0935, 0)
        tabContainer.Size = UDim2.new(0, 114, 0, 291)
        tabContainer.Parent = main
    
        local uICorner2 = Instance.new("UICorner")
        uICorner2.Name = "UICorner"
        uICorner2.CornerRadius = UDim.new(0, 5)
        uICorner2.Parent = tabContainer
    
        local fix = Instance.new("Frame")
        fix.Name = "Fix"
        fix.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        fix.BorderSizePixel = 0
        fix.Position = UDim2.new(0.895, 0, 0, 0)
        fix.Size = UDim2.new(0, 11, 0, 285)
        fix.Parent = tabContainer
    
        local fix1 = Instance.new("Frame")
        fix1.Name = "Fix"
        fix1.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        fix1.BorderSizePixel = 0
        fix1.Position = UDim2.new(0, 0, -0.00351, 0)
        fix1.Size = UDim2.new(0, 11, 0, 79)
        fix1.Parent = tabContainer
    
        local scrollingContainer = Instance.new("ScrollingFrame")
        scrollingContainer.Name = "ScrollingContainer"
        scrollingContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
        scrollingContainer.CanvasSize = UDim2.new()
        scrollingContainer.ScrollBarImageColor3 = Color3.fromRGB(56, 56, 56)
        scrollingContainer.ScrollBarThickness = 2
        scrollingContainer.Active = true
        scrollingContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        scrollingContainer.BackgroundTransparency = 1
        scrollingContainer.BorderSizePixel = 0
        scrollingContainer.Size = UDim2.new(0, 114, 0, 285)
        scrollingContainer.ZIndex = 2
        scrollingContainer.Parent = tabContainer
    
        function window:Tab(Info)
            Info.Text = Info.Text or "Tab"
    
            local tab = {}
    
            local tabButton = Instance.new("Frame")
            tabButton.Name = "TabButton"
            tabButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            tabButton.BackgroundTransparency = 1
            tabButton.Size = UDim2.new(0, 113, 0, 27)
            tabButton.Parent = scrollingContainer
    
            local tabFrame = Instance.new("Frame")
            tabFrame.Name = "TabFrame"
            tabFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            tabFrame.BackgroundTransparency = 0.96
            tabFrame.BorderSizePixel = 0
            tabFrame.Position = UDim2.new(0.067, -5, 0.013, 3)
            tabFrame.Size = UDim2.new(0, 107, 0, 23)
            tabFrame.ZIndex = 2
            tabFrame.Parent = tabButton
    
            tabFrame.MouseEnter:Connect(
                function()
                    if TabSelected ~= tabFrame or TabSelected == nil then
                        TweenService:Create(
                            tabFrame,
                            TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                            {BackgroundTransparency = .93}
                        ):Play()
                    end
                end
            )
    
            tabFrame.MouseLeave:Connect(
                function()
                    if TabSelected ~= tabFrame or TabSelected == nil then
                        TweenService:Create(
                            tabFrame,
                            TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                            {BackgroundTransparency = .96}
                        ):Play()
                    end
                end
            )
    
            local tabTextButton = Instance.new("TextButton")
            tabTextButton.Name = "TabTextButton"
            tabTextButton.Font = Enum.Font.SourceSans
            tabTextButton.Text = ""
            tabTextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
            tabTextButton.TextSize = 14
            tabTextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            tabTextButton.BackgroundTransparency = 1
            tabTextButton.Size = UDim2.new(0, 107, 0, 23)
            tabTextButton.Parent = tabFrame
    
            local uICorner3 = Instance.new("UICorner")
            uICorner3.Name = "UICorner"
            uICorner3.CornerRadius = UDim.new(0, 3)
            uICorner3.Parent = tabFrame
    
            local textLabel1 = Instance.new("TextLabel")
            textLabel1.Name = "TextLabel"
            textLabel1.Font = Enum.Font.GothamBold
            textLabel1.Text = Info.Text
            textLabel1.TextColor3 = Color3.fromRGB(237, 237, 237)
            textLabel1.TextSize = 11
            textLabel1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            textLabel1.BackgroundTransparency = 1
            textLabel1.Size = UDim2.new(0, 108, 0, 23)
            textLabel1.ZIndex = 2
            textLabel1.Parent = tabFrame
    
            local uIStroke = Instance.new("UIStroke")
            uIStroke.Name = "UIStroke"
            uIStroke.Color = Color3.fromRGB(68, 68, 68) -- 183, 248, 219
            uIStroke.Transparency = 0.45
            uIStroke.Parent = tabFrame
    
            local selected = Instance.new("Frame")
            selected.Name = "Selected"
            selected.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            selected.BackgroundTransparency = 0.1
            selected.Visible = false
            selected.BorderSizePixel = 0
            selected.Position = UDim2.new(0.067, -5, 0.013, 3)
            selected.Size = UDim2.new(0, 108, 0, 23)
            selected.Parent = tabButton
    
            local uICorner4 = Instance.new("UICorner")
            uICorner4.Name = "UICorner"
            uICorner4.CornerRadius = UDim.new(0, 3)
            uICorner4.Parent = selected
    
            local uIGradient1 = Instance.new("UIGradient")
            uIGradient1.Name = "UIGradient"
            uIGradient1.Parent = selected
            uIGradient1.Color =
                ColorSequence.new(
                {
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(183, 248, 219)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 25, 25))
                }
            )
            uIGradient1.Transparency =
                NumberSequence.new(
                {
                    NumberSequenceKeypoint.new(0, 0.5),
                    NumberSequenceKeypoint.new(0.688, 0.725),
                    NumberSequenceKeypoint.new(1, 0.506)
                }
            )
    
            local leftContainer = Instance.new("ScrollingFrame")
            leftContainer.Name = "LeftContainer"
            leftContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
            leftContainer.CanvasSize = UDim2.new()
            leftContainer.ScrollBarThickness = 0
            leftContainer.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
            leftContainer.BorderSizePixel = 0
            leftContainer.Position = UDim2.new(0.253, 0, 0.0935, 0)
            leftContainer.Selectable = false
            leftContainer.Size = UDim2.new(0, 168, 0, 287)
            leftContainer.Parent = main
            leftContainer.Visible = false
    
            local uIListLayout2 = Instance.new("UIListLayout")
            uIListLayout2.Name = "UIListLayout"
            uIListLayout2.SortOrder = Enum.SortOrder.LayoutOrder
            uIListLayout2.Parent = leftContainer
    
            local uIPadding2 = Instance.new("UIPadding")
            uIPadding2.Name = "UIPadding"
            uIPadding2.PaddingLeft = UDim.new(0, 4)
            uIPadding2.PaddingTop = UDim.new(0, 3)
            uIPadding2.Parent = leftContainer
    
            local rightContainer = Instance.new("ScrollingFrame")
            rightContainer.Name = "RightContainer"
            rightContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
            rightContainer.CanvasSize = UDim2.new()
            rightContainer.ScrollBarThickness = 0
            rightContainer.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
            rightContainer.BorderSizePixel = 0
            rightContainer.Position = UDim2.new(0.627, 0, 0.0935, 0)
            rightContainer.Selectable = false
            rightContainer.Size = UDim2.new(0, 168, 0, 287)
            rightContainer.Parent = main
            rightContainer.Visible = false
    
            local uIListLayout3 = Instance.new("UIListLayout")
            uIListLayout3.Name = "UIListLayout"
            uIListLayout3.SortOrder = Enum.SortOrder.LayoutOrder
            uIListLayout3.Parent = rightContainer
    
            local uIPadding3 = Instance.new("UIPadding")
            uIPadding3.Name = "UIPadding"
            uIPadding3.PaddingLeft = UDim.new(0, 2)
            uIPadding3.PaddingTop = UDim.new(0, 3)
            uIPadding3.Parent = rightContainer
    
            local uICorner8 = Instance.new("UICorner")
            uICorner8.Name = "UICorner"
            uICorner8.CornerRadius = UDim.new(0, 3)
            uICorner8.Parent = rightContainer
    
            function tab:Section(Info)
                Info.Text = Info.Text or "Section"
                Info.Side = Info.Side or "Left"
    
                local SizeY = 23
    
                local sectiontable = {}
    
                local Side
    
                if Info.Side == "Left" then
                    Side = leftContainer
                else
                    Side = rightContainer
                end
    
                local section = Instance.new("Frame")
                section.Name = "Section"
                section.BackgroundColor3 = Color3.fromRGB(42, 42, 42)
                section.BackgroundTransparency = 1
                section.Size = UDim2.new(0, 162, 0, 27)
                section.Parent = Side
    
                local Closed = Instance.new("BoolValue", section)
                Closed.Value = false
    
                local sectionFrame = Instance.new("Frame")
                sectionFrame.Name = "SectionFrame"
                sectionFrame.BackgroundColor3 = Color3.fromRGB(42, 42, 42)
                sectionFrame.ClipsDescendants = true
                sectionFrame.Size = UDim2.new(0, 162, 0, 23)
                sectionFrame.Parent = section
    
                sectionFrame.ChildAdded:Connect(
                    function(v)
                        if v.ClassName == "Frame" then
                            if v.Name == "Slider" then
                                SizeY = SizeY + 40
                            else
                                SizeY = SizeY + 27
                            end
                        end
                    end
                )
    
                local uIStroke3 = Instance.new("UIStroke")
                uIStroke3.Name = "UIStroke"
                uIStroke3.Color = Color3.fromRGB(52, 52, 52)
                uIStroke3.Parent = sectionFrame
    
                local uICorner7 = Instance.new("UICorner")
                uICorner7.Name = "UICorner"
                uICorner7.CornerRadius = UDim.new(0, 3)
                uICorner7.Parent = sectionFrame
    
                local uIListLayout1 = Instance.new("UIListLayout")
                uIListLayout1.Name = "UIListLayout"
                uIListLayout1.SortOrder = Enum.SortOrder.LayoutOrder
                uIListLayout1.Parent = sectionFrame
    
                local uIPadding1 = Instance.new("UIPadding")
                uIPadding1.Name = "UIPadding"
                uIPadding1.PaddingTop = UDim.new(0, 23)
                uIPadding1.Parent = sectionFrame
    
                local sectionName = Instance.new("TextLabel")
                sectionName.Name = "SectionName"
                sectionName.Font = Enum.Font.GothamBold
                sectionName.Text = Info.Text
                sectionName.TextColor3 = Color3.fromRGB(217, 217, 217)
                sectionName.TextSize = 11
                sectionName.TextXAlignment = Enum.TextXAlignment.Left
                sectionName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                sectionName.BackgroundTransparency = 1
                sectionName.Position = UDim2.new(0.0488, 0, 0, 0)
                sectionName.Size = UDim2.new(0, 128, 0, 23)
                sectionName.Parent = section
    
                local sectionButton = Instance.new("TextButton")
                sectionButton.Name = "SectionButton"
                sectionButton.Font = Enum.Font.SourceSans
                sectionButton.Text = ""
                sectionButton.TextColor3 = Color3.fromRGB(0, 0, 0)
                sectionButton.TextSize = 14
                sectionButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                sectionButton.BackgroundTransparency = 1
                sectionButton.Size = UDim2.new(0, 162, 0, 23)
                sectionButton.ZIndex = 2
                sectionButton.Parent = section
    
                local sectionIcon = Instance.new("ImageButton")
                sectionIcon.Name = "SectionButton"
                sectionIcon.Image = "rbxassetid://10664195729"
                sectionIcon.ImageColor3 = Color3.fromRGB(217, 217, 217)
                sectionIcon.AnchorPoint = Vector2.new(1, 0)
                sectionIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                sectionIcon.BackgroundTransparency = 1
                sectionIcon.Position = UDim2.new(1, -5, 0, 5)
                sectionIcon.Size = UDim2.new(0, 13, 0, 13)
                sectionIcon.ZIndex = 1
                sectionIcon.Parent = section
    
                sectionButton.MouseButton1Click:Connect(
                    function()
                        Closed.Value = not Closed.Value
                        --#d96163
    
                        TweenService:Create(
                            section,
                            TweenInfo.new(.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                            {Size = Closed.Value and UDim2.new(0, 162, 0, SizeY + 4) or UDim2.new(0, 162, 0, 27)}
                        ):Play()
                        TweenService:Create(
                            sectionFrame,
                            TweenInfo.new(.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                            {Size = Closed.Value and UDim2.new(0, 162, 0, SizeY) or UDim2.new(0, 162, 0, 23)}
                        ):Play()
                        TweenService:Create(
                            sectionIcon,
                            TweenInfo.new(.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                            {ImageColor3 = Closed.Value and Color3.fromRGB(217, 97, 99) or Color3.fromRGB(217, 217, 217)}
                        ):Play()
                        TweenService:Create(
                            sectionIcon,
                            TweenInfo.new(.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                            {Rotation = Closed.Value and 45 or 0}
                        ):Play()
                    end
                )
    
                function sectiontable:Label(Info)
                    Info.Text = Info.Text or "Label"
                    Info.Color = Info.Color or Color3.fromRGB(217, 217, 217)
                    Info.Tooltip = Info.Tooltip or ""
    
                    local insidelabel = {}
    
                    local label = Instance.new("Frame")
                    label.Name = "Label"
                    label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    label.BackgroundTransparency = 1
                    label.Size = UDim2.new(0, 162, 0, 27)
                    label.Parent = sectionFrame
    
                    if Info.Tooltip ~= "" then
                        AddTooltip(label, Info.Tooltip)
                    end
    
                    local labelText = Instance.new("TextLabel")
                    labelText.Name = "LabelText"
                    labelText.Font = Enum.Font.GothamBold
                    labelText.TextColor3 = Info.Color
                    labelText.Text = Info.Text
                    labelText.TextSize = 11
                    labelText.TextXAlignment = Enum.TextXAlignment.Left
                    labelText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    labelText.BackgroundTransparency = 1
                    labelText.Position = UDim2.new(0.0488, 0, 0, 0)
                    labelText.Size = UDim2.new(0, 156, 0, 27)
                    labelText.Parent = label
    
                    function insidelabel:Set(SetInfo)
                        SetInfo.Text = SetInfo.Text or labelText.Text
                        SetInfo.Color = SetInfo.Color or labelText.TextColor3
    
                        labelText.Text = SetInfo.Text
                        labelText.TextColor3 = SetInfo.Color
                    end
    
                    return insidelabel
                end
    
                function sectiontable:Keybind(Info)
                    Info.Text = Info.Text or "Keybind"
                    local KeybindGlobalName = Info.Text:gsub("% ", "")
                    Info.Tooltip = Info.Tooltip or ""
                    Info.Default = Info.Default or Enum.KeyCode.Clear
                    Info.Flag = Info.Default
                    Info.Callback = Info.Callback or function()
                        end
    
                    local PressKey = Info.Default
                    local IsKeyDown = false
                    local HasToggled = false
    
                    local keybind = Instance.new("Frame")
                    keybind.Name = "Keybind"
                    keybind.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    keybind.BackgroundTransparency = 1
                    keybind.Size = UDim2.new(0, 162, 0, 27)
                    keybind.Parent = sectionFrame
    
                    if Info.Tooltip ~= "" then
                        AddTooltip(keybind, Info.Tooltip)
                    end
    
                    local keybindText = Instance.new("TextLabel")
                    keybindText.Name = "KeybindText"
                    keybindText.Font = Enum.Font.GothamBold
                    keybindText.Text = Info.Text
                    keybindText.TextColor3 = Color3.fromRGB(217, 217, 217)
                    keybindText.TextSize = 11
                    keybindText.TextXAlignment = Enum.TextXAlignment.Left
                    keybindText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    keybindText.BackgroundTransparency = 1
                    keybindText.Position = UDim2.new(0.0488, 0, 0, 0)
                    keybindText.Size = UDim2.new(0, 156, 0, 27)
                    keybindText.Parent = keybind
    
                    local keybindFrame = Instance.new("Frame")
                    keybindFrame.Name = "KeybindFrame"
                    keybindFrame.BackgroundColor3 = Color3.fromRGB(68, 68, 68)
                    keybindFrame.AnchorPoint = Vector2.new(1, 0)
                    keybindFrame.BorderSizePixel = 0
                    keybindFrame.Position = UDim2.new(0, 158, 0.222, 0)
                    keybindFrame.Size = UDim2.new(0, 30, 0, 15)
                    keybindFrame.Parent = keybind
    
                    local keybindUICorner = Instance.new("UICorner")
                    keybindUICorner.Name = "KeybindUICorner"
                    keybindUICorner.CornerRadius = UDim.new(0, 3)
                    keybindUICorner.Parent = keybindFrame
    
                    local keybindFrameText = Instance.new("TextLabel")
                    keybindFrameText.Name = "KeybindFrameText"
                    keybindFrameText.Font = Enum.Font.GothamBold
                    keybindFrameText.Text = PressKey.Name
                    keybindFrameText.TextColor3 = Color3.fromRGB(217, 217, 217)
                    keybindFrameText.TextSize = 11
                    keybindFrameText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    keybindFrameText.BackgroundTransparency = 1
                    keybindFrameText.Size = UDim2.new(1, 0, 0, 15)
                    keybindFrameText.Parent = keybindFrame
    
                    local keybindButton = Instance.new("TextButton")
                    keybindButton.Name = "KeybindButton"
                    keybindButton.Font = Enum.Font.SourceSans
                    keybindButton.Text = ""
                    keybindButton.TextColor3 = Color3.fromRGB(0, 0, 0)
                    keybindButton.TextSize = 14
                    keybindButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    keybindButton.BackgroundTransparency = 1
                    keybindButton.Size = UDim2.new(1, 0, 0, 15)
                    keybindButton.Parent = keybindFrame
    
                    local keybindUIStroke = Instance.new("UIStroke")
                    keybindUIStroke.Name = "KeybindUIStroke"
                    keybindUIStroke.Color = Color3.fromRGB(84, 84, 84)
                    keybindUIStroke.Parent = keybindFrame
    
                    local TextBounds = keybindFrameText.TextBounds
    
                    keybindFrame.Size = UDim2.new(0, TextBounds.X + 10, 0, 15)
    
                    keybindFrameText:GetPropertyChangedSignal("Text"):Connect(
                        function()
                            TextBounds = keybindFrameText.TextBounds
    
                            keybindFrame.Size = UDim2.new(0, TextBounds.X + 10, 0, 15)
                        end
                    )
    
                    local KeybindConnection
                    local Changing = false
    
                    if keybindFrameText.Text == "Clear" then
                        keybindFrameText.Text = "?"
                    end
    
                    keybindButton.MouseButton1Click:Connect(
                        function()
                            if KeybindConnection then
                                KeybindConnection:Disconnect()
                            end
                            Changing = true
                            keybindFrameText.Text = "..."
                            KeybindConnection =
                                UserInputService.InputBegan:Connect(
                                function(Key, gameProcessed)
                                    if not table.find(Blacklist, Key.KeyCode) and not gameProcessed then
                                        KeybindConnection:Disconnect()
                                        keybindFrameText.Text = Key.KeyCode.Name
                                        PressKey = Key.KeyCode
                                        Info.Flag = PressKey
                                        wait(.1)
                                        Changing = false
                                        getgenv()[tostring(KeybindGlobalName)] = tostring(Info.Flag)
                                    end
                                end
                            )
                        end
                    )
    
                    local KeyPressed = false
    
                    UserInputService.InputBegan:Connect(
                        function(Key, gameProcessed)
                            if not Changing and Key.KeyCode == PressKey and not gameProcessed then
                                if not KeyPressed then
                                    IsKeyDown = true
                                    KeyPressed = true
                                else
                                    IsKeyDown = false
                                    KeyPressed = false
                                end
                                task.spawn(
                                    function()
                                        pcall(Info.Callback, IsKeyDown)
                                    end
                                )
                            end
                        end
                    )
    
                    return {
                        SetKey = function(_, Key)
                            PressKey = Key
                            keybindFrameText.Text = Key.Name
                            Info.Flag = PressKey -- Update the flag with the new PressKey
                        end,
                        GetKey = function()
                            return PressKey
                        end,
                        IsKeyDown = function()
                            return IsKeyDown
                        end
                    }
                end
    
                function sectiontable:Button(Info)
                    Info.Text = Info.Text or "Button"
                    Info.Callback = Info.Callback or function()
                        end
                    Info.Tooltip = Info.Tooltip or ""
    
                    local buttontable = {}
    
                    local button = Instance.new("Frame")
                    button.Name = "Button"
                    button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    button.BackgroundTransparency = 1
                    button.Size = UDim2.new(0, 162, 0, 27)
                    button.Parent = sectionFrame
    
                    if Info.Tooltip ~= "" then
                        AddTooltip(button, Info.Tooltip)
                    end
    
                    local buttonText = Instance.new("TextLabel")
                    buttonText.Name = "ButtonText"
                    buttonText.Font = Enum.Font.GothamBold
                    buttonText.Text = Info.Text
                    buttonText.TextColor3 = Color3.fromRGB(217, 217, 217)
                    buttonText.TextSize = 11
                    buttonText.TextXAlignment = Enum.TextXAlignment.Left
                    buttonText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    buttonText.BackgroundTransparency = 1
                    buttonText.Position = UDim2.new(0.0488, 0, 0, 0)
                    buttonText.Size = UDim2.new(0, 156, 0, 27)
                    buttonText.Parent = button
    
                    local textButton = Instance.new("TextButton")
                    textButton.Name = "TextButton"
                    textButton.Font = Enum.Font.SourceSans
                    textButton.Text = ""
                    textButton.TextColor3 = Color3.fromRGB(0, 0, 0)
                    textButton.TextSize = 14
                    textButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    textButton.BackgroundTransparency = 1
                    textButton.Size = UDim2.new(0, 162, 0, 27)
                    textButton.Parent = button
    
                    textButton.MouseButton1Click:Connect(
                        function()
                            task.spawn(
                                function()
                                    pcall(Info.Callback)
                                end
                            )
                        end
                    )
                end
    
                function sectiontable:Input(Info)
                    Info.Placeholder = Info.Placeholder or "Input"
                    Info.Flag = Info.Flag or nil
                    Info.Callback = Info.Callback or function()
                        end
                    Info.Tooltip = Info.Tooltip or ""
    
                    local input = Instance.new("Frame")
                    input.Name = "Input"
                    input.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    input.BackgroundTransparency = 1
                    input.Size = UDim2.new(0, 162, 0, 27)
                    input.Parent = sectionFrame
    
                    if Info.Tooltip ~= "" then
                        AddTooltip(input, Info.Tooltip)
                    end
    
                    local inputFrame = Instance.new("Frame")
                    inputFrame.Name = "InputFrame"
                    inputFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    inputFrame.BackgroundTransparency = 1
                    inputFrame.Size = UDim2.new(0, 162, 0, 27)
                    inputFrame.Parent = input
    
                    local inputOuter = Instance.new("Frame")
                    inputOuter.Name = "InputOuter"
                    inputOuter.AnchorPoint = Vector2.new(0.5, 0.5)
                    inputOuter.BackgroundColor3 = Color3.fromRGB(68, 68, 68)
                    inputOuter.BorderSizePixel = 0
                    inputOuter.ClipsDescendants = true
                    inputOuter.Position = UDim2.new(0.5, 0, 0.5, 0)
                    inputOuter.Size = UDim2.new(0, 154, 0, 21)
                    inputOuter.Parent = inputFrame
    
                    local inputUICorner = Instance.new("UICorner")
                    inputUICorner.Name = "InputUICorner"
                    inputUICorner.CornerRadius = UDim.new(0, 3)
                    inputUICorner.Parent = inputOuter
    
                    local inputUIStroke = Instance.new("UIStroke")
                    inputUIStroke.Name = "InputUIStroke"
                    inputUIStroke.Color = Color3.fromRGB(84, 84, 84)
                    inputUIStroke.Parent = inputOuter
    
                    local inputTextBox = Instance.new("TextBox")
                    inputTextBox.Name = "InputTextBox"
                    inputTextBox.CursorPosition = -1
                    inputTextBox.Font = Enum.Font.GothamBold
                    inputTextBox.PlaceholderColor3 = Color3.fromRGB(217, 217, 217)
                    inputTextBox.PlaceholderText = Info.Placeholder
                    inputTextBox.Text = ""
                    inputTextBox.TextColor3 = Color3.fromRGB(237, 237, 237)
                    inputTextBox.TextSize = 11
                    inputTextBox.TextXAlignment = Enum.TextXAlignment.Left
                    inputTextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    inputTextBox.BackgroundTransparency = 1
                    inputTextBox.Position = UDim2.new(0.0253, 0, 0, 0)
                    inputTextBox.Size = UDim2.new(0, 150, 0, 21)
                    inputTextBox.Parent = inputOuter
    
                    inputTextBox.FocusLost:Connect(
                        function()
                            task.spawn(
                                function()
                                    pcall(Info.Callback, inputTextBox.Text)
                                    if Info.Flag ~= nil then
                                        library.Flags[Info.Flag] = inputTextBox.Text
                                    end
                                end
                            )
                        end
                    )
                end
    
                function sectiontable:Toggle(Info)
                    Info.Text = Info.Text or "Toggle"
                    Info.Flag = Info.Flag or nil
                    Info.Default = Info.Default or false
                    Info.Callback = Info.Callback or function()
                        end
                    Info.Tooltip = Info.Tooltip or ""
    
                    if Info.Flag ~= nil then
                        library.Flags[Info.Flag] = false
                    end
    
                    Info.Keybind = Info.Keybind or false
                    Info.KeybindDefault = Info.KeybindDefault or Enum.KeyCode.Clear
    
                    local insidetoggle = {}
    
                    local Toggled = false
    
                    local toggle = Instance.new("Frame")
                    toggle.Name = "Toggle"
                    toggle.BackgroundColor3 = sectionFrame.BackgroundColor3
                    toggle.BorderColor3 = sectionFrame.BackgroundColor3
                    toggle.BackgroundTransparency = 0
                    toggle.Size = UDim2.new(0, 162, 0, 27)
                    toggle.Parent = sectionFrame
                    toggle.ClipsDescendants = true
    
                    if Info.Tooltip ~= "" then
                        AddTooltip(toggle, Info.Tooltip)
                    end
    
                    local toggleText = Instance.new("TextLabel")
                    toggleText.Name = "ToggleText"
                    toggleText.Font = Enum.Font.GothamBold
                    toggleText.Text = Info.Text
                    toggleText.TextColor3 = Color3.fromRGB(217, 217, 217)
                    toggleText.TextSize = 11
                    toggleText.TextXAlignment = Enum.TextXAlignment.Left
                    toggleText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    toggleText.BackgroundTransparency = 1
                    toggleText.Position = UDim2.new(0.0488, 0, 0, 0)
                    toggleText.Size = UDim2.new(0, 156, 0, 27)
                    toggleText.Parent = toggle
    
                    local toggleButton = Instance.new("TextButton")
                    toggleButton.Name = "ToggleButton"
                    toggleButton.Font = Enum.Font.SourceSans
                    toggleButton.Text = ""
                    toggleButton.TextColor3 = Color3.fromRGB(0, 0, 0)
                    toggleButton.TextSize = 14
                    toggleButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    toggleButton.BackgroundTransparency = 1
                    toggleButton.Size = UDim2.new(0, 162, 0, 27)
                    toggleButton.Parent = toggle
    
                    local toggleFrame = Instance.new("Frame")
                    toggleFrame.Name = "ToggleFrame"
                    toggleFrame.BackgroundColor3 = Color3.fromRGB(68, 68, 68)
                    toggleFrame.BorderSizePixel = 0
                    toggleFrame.Position = UDim2.new(0.783, 0, 0.222, 0)
                    toggleFrame.Size = UDim2.new(0, 30, 0, 15)
                    toggleFrame.Parent = toggle
    
                    ColorElements[toggleFrame] = {Type = "Toggle", Enabled = false}
    
                    local toggleUICorner = Instance.new("UICorner")
                    toggleUICorner.Name = "ToggleUICorner"
                    toggleUICorner.CornerRadius = UDim.new(0, 100)
                    toggleUICorner.Parent = toggleFrame
    
                    local circleIcon = Instance.new("ImageLabel")
                    circleIcon.Name = "CheckIcon"
                    circleIcon.Image = "rbxassetid://14658187312"
                    circleIcon.ImageColor3 = Color3.fromRGB(217, 217, 217)
                    circleIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    circleIcon.BackgroundTransparency = 1
                    circleIcon.Position = UDim2.new(0, 1, 0.067, 0)
                    circleIcon.Size = UDim2.new(0, 13, 0, 13)
                    circleIcon.Parent = toggleFrame
    
                    function insidetoggle:Set(bool)
                        Toggled = bool
                        if Info.Flag ~= nil then
                            library.Flags[Info.Flag] = Toggled
                        end
                        ColorElements[toggleFrame].Enabled = Toggled
    
                        TweenService:Create(
                            circleIcon,
                            TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                            {Position = Toggled and UDim2.new(0, 16, 0.067, 0) or UDim2.new(0, 1, 0.067, 0)}
                        ):Play()
                        if not Toggled then
                            TweenService:Create(
                                toggleFrame,
                                TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                                {BackgroundColor3 = Color3.fromRGB(68, 68, 68)}
                            ):Play()
                        elseif Toggled and not EditOpened then
                            TweenService:Create(
                                toggleFrame,
                                TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                                {BackgroundColor3 = Color3.fromRGB(48, 207, 106)}
                            ):Play()
                        end
                        pcall(Info.Callback, Toggled)
                    end
    
                    if Info.Default then
                        task.spawn(
                            function()
                                insidetoggle:Set(true)
                            end
                        )
                    end
    
                    toggleButton.MouseButton1Click:Connect(
                        function()
                            Toggled = not Toggled
                            insidetoggle:Set(Toggled)
                        end
                    )
    
                    local PressKey = Info.KeybindDefault
                    local IsKeyDown = false
                    local HasToggled = false
                    
                    local keybindFrame = Instance.new("Frame")
                    keybindFrame.Name = "KeybindFrame"
                    keybindFrame.BackgroundColor3 = Color3.fromRGB(68, 68, 68)
                    keybindFrame.AnchorPoint = Vector2.new(1, 0)
                    keybindFrame.BorderSizePixel = 0
                    keybindFrame.BackgroundTransparency = 0
                    keybindFrame.Position = UDim2.new(0, 158, 0.250, 0)
                    keybindFrame.Size = UDim2.new(0, 30, 0, 15)
                    keybindFrame.Parent = toggle
                    keybindFrame.Visible = false
    
                    local keybindUICorner = Instance.new("UICorner")
                    keybindUICorner.Name = "KeybindUICorner"
                    keybindUICorner.CornerRadius = UDim.new(0, 3)
                    keybindUICorner.Parent = keybindFrame
    
                    local keybindFrameText = Instance.new("TextLabel")
                    keybindFrameText.Name = "KeybindFrameText"
                    keybindFrameText.Font = Enum.Font.GothamBold
                    keybindFrameText.Text = PressKey.Name
                    keybindFrameText.TextColor3 = Color3.fromRGB(217, 217, 217)
                    keybindFrameText.TextSize = 11
                    keybindFrameText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    keybindFrameText.Size = UDim2.new(1, 0, 0, 15)
                    keybindFrameText.BackgroundTransparency = 1
                    keybindFrameText.Parent = keybindFrame
    
                    local keybindButton = Instance.new("TextButton")
                    keybindButton.Name = "KeybindButton"
                    keybindButton.Font = Enum.Font.SourceSans
                    keybindButton.Text = ""
                    keybindButton.TextColor3 = Color3.fromRGB(0, 0, 0)
                    keybindButton.TextSize = 14
                    keybindButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    keybindButton.BackgroundTransparency = 1
                    keybindButton.Size = UDim2.new(1, 0, 0, 15)
                    keybindButton.Parent = keybindFrame
    
                    local keybindUIStroke = Instance.new("UIStroke")
                    keybindUIStroke.Name = "KeybindUIStroke"
                    keybindUIStroke.Color = Color3.fromRGB(84, 84, 84)
                    keybindUIStroke.Parent = keybindFrame
    
                    local keybindText = Instance.new("TextLabel")
                    keybindText.Name = "KeybindText"
                    keybindText.Font = Enum.Font.GothamBold
                    keybindText.TextColor3 = Color3.fromRGB(217, 217, 217)
                    keybindText.TextSize = 11
                    keybindText.TextXAlignment = Enum.TextXAlignment.Left
                    keybindText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    keybindText.BackgroundTransparency = 1
                    keybindText.Position = UDim2.new(0.0488, 0, 0, 0)
                    keybindText.Size = UDim2.new(0, 156, 0, 27)
                    keybindText.Parent = keybind
    
                    local TextBounds = keybindFrameText.TextBounds
    
                    keybindFrame.Size = UDim2.new(0, TextBounds.X + 10, 0, 15)
    
                    keybindFrameText:GetPropertyChangedSignal("Text"):Connect(
                        function()
                            TextBounds = keybindFrameText.TextBounds
    
                            keybindFrame.Size = UDim2.new(0, TextBounds.X + 10, 0, 15)
                        end
                    )
    
                    local KeybindConnection
                    local Changing = false
    
                    if keybindFrameText.Text == "Clear" then
                        keybindFrameText.Text = "?"
                    end
    
                    keybindButton.MouseButton1Click:Connect(
                        function()
                            if KeybindConnection then
                                KeybindConnection:Disconnect()
                            end
                            Changing = true
                            keybindFrameText.Text = "..."
                            KeybindConnection =
                                UserInputService.InputBegan:Connect(
                                function(Key, gameProcessed)
                                    if not table.find(Blacklist, Key.KeyCode) and not gameProcessed then
                                        KeybindConnection:Disconnect()
                                        keybindFrameText.Text = Key.KeyCode.Name
                                        PressKey = Key.KeyCode
                                        wait(.1)
                                        Changing = false
                                    end
                                end
                            )
                        end
                    )
    
                    local KeyPressed = false
                    
                    UserInputService.InputBegan:Connect(
                        function(Key, gameProcessed)
                            if not Changing and Key.KeyCode == PressKey and not gameProcessed then
                                if not KeyPressed then
                                    IsKeyDown = true
                                    KeyPressed = true
                                else
                                    IsKeyDown = false
                                    KeyPressed = false
                                end
                                task.spawn(
                                    function()
                                        insidetoggle:Set(IsKeyDown)
                                    end
                                )
                            end
                        end
                    )
    
                    local settingsisopen = false
    
                    toggleButton.MouseButton2Click:Connect(
                        function()
                            if not settingsisopen then
                                spawn(function()
                                    local tweenwait = TweenService:Create(
                                        toggleFrame,
                                        TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                                        {BackgroundTransparency = 1}
                                    )
    
                                    tweenwait:Play()
                                    tweenwait.Completed:Wait()
    
                                    toggleFrame.Visible = false
                                    task.wait(0.075)
                                    keybindFrame.Visible = true
                                end)
    
                                task.wait(0.05)
    
                                settingsisopen = true
    
                            elseif settingsisopen then
    
                                spawn(function()
                                    keybindFrame.Visible = false
                                    local tweenwait = TweenService:Create(
                                        toggleFrame,
                                        TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                                        {BackgroundTransparency = 0}
                                    )
    
                                    tweenwait:Play()
                                    tweenwait.Completed:Wait()
    
                                    task.wait(0.05)
                                    toggleFrame.Visible = true
                                end)
    
                                task.wait(0.05)
    
                                settingsisopen = false
                                toggleFrame.Visible = true
                            end
                        end
                    )
    
                    local function createColorTween(frame, targetColor)
                        local tweenInfo = TweenInfo.new(
                            0.25, -- Time
                            Enum.EasingStyle.Linear, -- Easing Style
                            Enum.EasingDirection.Out -- Easing Direction
                        )
                    
                        local tween = TweenService:Create(
                            frame, -- Instance to tween
                            tweenInfo, -- TweenInfo
                            { BackgroundColor3 = targetColor } -- What we want to change
                        )
                    
                        return tween
                    end
    
                    local fadeInTween = createColorTween(toggle, Color3.fromRGB(49, 49, 49))
                    local fadeOutTween = createColorTween(toggle, Color3.fromRGB(42, 42, 42))
                    
                    toggle.MouseEnter:Connect(function()
                        fadeInTween:Play()
                    end)
                    
                    toggle.MouseLeave:Connect(function()
                        fadeOutTween:Play()
                    end)
    
                    return insidetoggle
                end
    
                function sectiontable:Slider(Info)
                    Info.Text = Info.Text or "Slider"
                    Info.Default = Info.Default or 50
                    Info.Minimum = Info.Minimum or 1
                    Info.Flag = Info.Flag or nil
                    Info.Maximum = Info.Maximum or 100
                    Info.Postfix = Info.Postfix or ""
                    Info.Callback = Info.Callback or function()
                        end
                    Info.Tooltip = Info.Tooltip or ""
    
                    Info.Button = Info.Button or false
                    Info.ButtonDefault = Info.ButtonDefault or false
    
                    Info.ButtonFlag = Info.ButtonFlag or nil
                    Info.ButtonCallback = Info.ButtonCallback or function() end
                    
                    if Info.ButtonFlag ~= nil then
                        library.Flags[Info.ButtonFlag] = false
                    end
    
                    Info.Keybind = Info.Keybind or false
                    Info.KeybindDefault = Info.KeybindDefault or Enum.KeyCode.Clear
    
                    if Info.Button ~= true and Info.Keybind ~= true then
                        if Info.Minimum > Info.Maximum then
                            local ValueBefore = Info.Minimum
                            Info.Minimum, Info.Maximum = Info.Maximum, ValueBefore
                        end
        
                        Info.Default = math.clamp(Info.Default, Info.Minimum, Info.Maximum)
                        local DefaultScale = (Info.Default - Info.Minimum) / (Info.Maximum - Info.Minimum)
        
                        local slider = Instance.new("Frame")
                        slider.Name = "Slider"
                        slider.BackgroundColor3 = Color3.fromRGB(42, 42, 42)
                        slider.BorderColor3 = slider.BackgroundColor3
                        slider.BackgroundTransparency = 0
                        slider.Position = UDim2.new(0, 0, 0.825, 0)
                        slider.Size = UDim2.new(0, 175, 0, 40)
                        slider.Parent = sectionFrame
                        slider.ClipsDescendants = true
        
                        if Info.Tooltip ~= "" then
                            AddTooltip(slider, Info.Tooltip)
                        end
        
                        local sliderText = Instance.new("TextLabel")
                        sliderText.Name = "SliderText"
                        sliderText.Font = Enum.Font.GothamBold
                        sliderText.Text = Info.Text
                        sliderText.TextColor3 = Color3.fromRGB(217, 217, 217)
                        sliderText.TextSize = 11
                        sliderText.TextXAlignment = Enum.TextXAlignment.Left
                        sliderText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        sliderText.BackgroundTransparency = 1
                        sliderText.Position = UDim2.new(0.0488, 0, 0, 0)
                        sliderText.Size = UDim2.new(0, 156, 0, 27)
                        sliderText.Parent = slider
        
                        local outerSlider = Instance.new("Frame")
                        outerSlider.Name = "OuterSlider"
                        outerSlider.BackgroundColor3 = Color3.fromRGB(68, 68, 68)
                        outerSlider.BorderSizePixel = 0
                        outerSlider.Position = UDim2.new(0.049, -1, 0.664, 0)
                        outerSlider.Size = UDim2.new(0, 149, 0, 4)
                        outerSlider.Parent = slider
        
                        local sliderCorner = Instance.new("UICorner")
                        sliderCorner.Name = "SliderCorner"
                        sliderCorner.CornerRadius = UDim.new(0, 100)
                        sliderCorner.Parent = outerSlider
        
                        local innerSlider = Instance.new("Frame")
                        innerSlider.Name = "InnerSlider"
                        innerSlider.BackgroundColor3 = Color3.fromRGB(48, 207, 106)
                        innerSlider.BorderSizePixel = 0
                        innerSlider.Size = UDim2.new(DefaultScale, 0, 0, 4)
                        innerSlider.ZIndex = 2
                        innerSlider.Parent = outerSlider
        
                        ColorElements[innerSlider] = {Type = "Slider", Enabled = false}
        
                        local innerSliderCorner = Instance.new("UICorner")
                        innerSliderCorner.Name = "InnerSliderCorner"
                        innerSliderCorner.CornerRadius = UDim.new(0, 100)
                        innerSliderCorner.Parent = innerSlider
        
                        local sliderValueText = Instance.new("TextLabel")
                        sliderValueText.Name = "SliderValueText"
                        sliderValueText.Font = Enum.Font.GothamBold
                        sliderValueText.Text = tostring(Info.Default) .. Info.Postfix
                        sliderValueText.TextColor3 = Color3.fromRGB(217, 217, 217)
                        sliderValueText.TextSize = 11
                        sliderValueText.TextXAlignment = Enum.TextXAlignment.Right
                        sliderValueText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        sliderValueText.BackgroundTransparency = 1
                        sliderValueText.Position = UDim2.new(0.0488, 0, 0, 0)
                        sliderValueText.Size = UDim2.new(0, 149, 0, 27)
                        sliderValueText.Parent = slider

                        local sliderValueTextFrame = Instance.new("Frame")
                        sliderValueTextFrame.Name = "sliderValueTextFrame"
                        sliderValueTextFrame.BackgroundColor3 = Color3.fromRGB(68, 68, 68)
                        sliderValueTextFrame.BorderSizePixel = 0
                        sliderValueTextFrame.Position = UDim2.new(0.787, 0, 0.15, 0)
                        sliderValueTextFrame.Size = UDim2.new(0, 23.5, 0, 14)
                        sliderValueTextFrame.Parent = slider
                        sliderValueTextFrame.Visible = true
                        sliderValueTextFrame.BackgroundTransparency = 1

                        local sliderValueTextButton = Instance.new("TextButton")
                        sliderValueTextButton.Name = "sliderValueTextButton"
                        sliderValueTextButton.Font = Enum.Font.SourceSans
                        sliderValueTextButton.Text = ""
                        sliderValueTextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
                        sliderValueTextButton.TextSize = 14
                        sliderValueTextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        sliderValueTextButton.BackgroundTransparency = 1
                        sliderValueTextButton.Position = UDim2.new(0, 0, 0, 0)
                        sliderValueTextButton.Size = UDim2.new(0, 22.5, 0, 13)
                        sliderValueTextButton.Parent = sliderValueTextFrame
                        sliderValueTextButton.ZIndex = 2

                        sliderValueTextButton.MouseButton2Down:Connect(
                            function()
                                sliderValueText.Text = "."
                                task.wait(0.1)
                                sliderValueText.Text = ".."
                                task.wait(0.1)
                                sliderValueText.Text = "..."

                                local UserInputService = game:GetService("UserInputService")
                                local numberString = ""
                                local changeNumber = true
                                
                                UserInputService.InputBegan:Connect(function(input)
                                    if input.UserInputType == Enum.UserInputType.Keyboard then
                                        if changeNumber == true then
                                            local key = input.KeyCode
                                            if key.Value >= Enum.KeyCode.Zero.Value and key.Value <= Enum.KeyCode.Nine.Value then
                                                local number = key.Value - Enum.KeyCode.Zero.Value
                                                numberString = numberString .. tostring(number)
                                                sliderValueText.Text = numberString .. Info.Postfix
                                            elseif key == Enum.KeyCode.Backspace then
                                                numberString = numberString:sub(1, -2)
                                                sliderValueText.Text = numberString .. Info.Postfix
                                            elseif key == Enum.KeyCode.Return then
                                                if Info.Flag ~= nil then
                                                    library.Flags[Info.Flag] = tonumber(numberString)
                                                end
                                                sliderValueText.Text = numberString .. Info.Postfix
                                                task.spawn(
                                                    function()
                                                        pcall(Info.Callback, tonumber(numberString))
                                                    end
                                                )
                                                changeNumber = false
                                            end
                                        end
                                    elseif (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.MouseButton2) and changeNumber == true then
                                        if Info.Flag ~= nil then
                                            library.Flags[Info.Flag] = tonumber(numberString)
                                        end
                                        sliderValueText.Text = numberString .. Info.Postfix
                                        task.spawn(
                                            function()
                                                pcall(Info.Callback, tonumber(numberString))
                                            end
                                        )
                                        changeNumber = false
                                    end
                                end)
                            end
                        )
        
                        local sliderButton = Instance.new("TextButton")
                        sliderButton.Name = "SliderButton"
                        sliderButton.Font = Enum.Font.SourceSans
                        sliderButton.Text = ""
                        sliderButton.TextColor3 = Color3.fromRGB(0, 0, 0)
                        sliderButton.TextSize = 14
                        sliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        sliderButton.BackgroundTransparency = 1
                        sliderButton.Position = UDim2.new(0.049, 0, 0.664, 0)
                        sliderButton.Size = UDim2.new(0, 149, 0, 4)
                        sliderButton.Parent = slider
        
                        task.spawn(
                            function()
                                pcall(Info.Callback, Info.Default)
                                if Info.Flag ~= nil then
                                    library.Flags[Info.Flag] = Info.Default
                                end
                            end
                        )
        
                        local MinSize = 0
                        local MaxSize = 1
        
                        local SizeFromScale = (MinSize + (MaxSize - MinSize)) * DefaultScale
                        SizeFromScale = SizeFromScale - (SizeFromScale % 2)
        
                        sliderButton.MouseButton1Down:Connect(
                            function()
                                local MouseMove, MouseKill
                                MouseMove =
                                    Mouse.Move:Connect(
                                    function()
                                        local Px = library:GetXY(outerSlider)
                                        local SizeFromScale = (MinSize + (MaxSize - MinSize)) * Px
                                        local Value = math.floor(Info.Minimum + ((Info.Maximum - Info.Minimum) * Px))
                                        SizeFromScale = SizeFromScale - (SizeFromScale % 2)
                                        TweenService:Create(innerSlider, TweenInfo.new(0.1), {Size = UDim2.new(Px, 0, 0, 4)}):Play(
        
                                        )
                                        if Info.Flag ~= nil then
                                            library.Flags[Info.Flag] = Value
                                        end
                                        sliderValueText.Text = tostring(Value) .. Info.Postfix
                                        task.spawn(
                                            function()
                                                pcall(Info.Callback, Value)
                                            end
                                        )
                                    end
                                )
                                MouseKill =
                                    UserInputService.InputEnded:Connect(
                                    function(UserInput)
                                        if UserInput.UserInputType == Enum.UserInputType.MouseButton1 then
                                            MouseMove:Disconnect()
                                            MouseKill:Disconnect()
                                        end
                                    end
                                )
                            end
                        )
    
                        local function createColorTween(frame, targetColor)
                            local tweenInfo = TweenInfo.new(
                                0.25, -- Time
                                Enum.EasingStyle.Linear, -- Easing Style
                                Enum.EasingDirection.Out -- Easing Direction
                            )
                        
                            local tween = TweenService:Create(
                                frame, -- Instance to tween
                                tweenInfo, -- TweenInfo
                                { BackgroundColor3 = targetColor } -- What we want to change
                            )
                        
                            return tween
                        end
                        
                        
                        local fadeInTween = createColorTween(slider, Color3.fromRGB(49, 49, 49))
                        local fadeOutTween = createColorTween(slider, Color3.fromRGB(42, 42, 42))
                        
                        slider.MouseEnter:Connect(function()
                            fadeInTween:Play()
                        end)
                        
                        slider.MouseLeave:Connect(function()
                            fadeOutTween:Play()
                        end)
                    else
                        if Info.Minimum > Info.Maximum then
                            local ValueBefore = Info.Minimum
                            Info.Minimum, Info.Maximum = Info.Maximum, ValueBefore
                        end
        
                        Info.Default = math.clamp(Info.Default, Info.Minimum, Info.Maximum)
                        local DefaultScale = (Info.Default - Info.Minimum) / (Info.Maximum - Info.Minimum)
                        
                        local slider = Instance.new("Frame")
                        slider.Name = "Slider"
                        slider.BackgroundColor3 = Color3.fromRGB(42, 42, 42)
                        slider.BorderColor3 = slider.BackgroundColor3
                        slider.BackgroundTransparency = 0
                        slider.Position = UDim2.new(0, 0, 0.825, 0)
                        slider.Size = UDim2.new(0, 175, 0, 40)
                        slider.Parent = sectionFrame
                        slider.ClipsDescendants = true
    
                        local SliderButtonSettings = Instance.new("ImageButton")
                        SliderButtonSettings.Name = "SliderButtonSettings"
                        SliderButtonSettings.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        SliderButtonSettings.BackgroundTransparency = 1
                        SliderButtonSettings.Position = UDim2.new(0, 0, -0.05, 0)
                        SliderButtonSettings.Size = UDim2.new(0, 165, 0, 30)
                        SliderButtonSettings.Parent = slider
    
                        local SliderButtonSettingsContainer = Instance.new("Frame")
                        SliderButtonSettingsContainer.Name = "SliderButtonSettingsContainer"
                        SliderButtonSettingsContainer.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
                        SliderButtonSettingsContainer.BackgroundTransparency = 1
                        SliderButtonSettingsContainer.Position = UDim2.new(0, 0, -0.05, 0)
                        SliderButtonSettingsContainer.Size = UDim2.new(0, 165, 0, 30)
                        SliderButtonSettingsContainer.Parent = slider
    
                        if Info.Tooltip ~= "" then
                            AddTooltip(slider, Info.Tooltip)
                        end
    
                        local sliderText = Instance.new("TextLabel")
                        sliderText.Name = "SliderText"
                        sliderText.Font = Enum.Font.GothamBold
                        sliderText.Text = Info.Text
                        sliderText.TextColor3 = Color3.fromRGB(217, 217, 217)
                        sliderText.TextSize = 11
                        sliderText.TextXAlignment = Enum.TextXAlignment.Left
                        sliderText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        sliderText.BackgroundTransparency = 1
                        sliderText.Position = UDim2.new(0.0488, 0, 0, 0)
                        sliderText.Size = UDim2.new(0, 156, 0, 27)
                        sliderText.Parent = slider
        
                        local outerSlider = Instance.new("Frame")
                        outerSlider.Name = "OuterSlider"
                        outerSlider.BackgroundColor3 = Color3.fromRGB(68, 68, 68)
                        outerSlider.BorderSizePixel = 0
                        outerSlider.Position = UDim2.new(0.049, -1, 0.664, 0)
                        outerSlider.Size = UDim2.new(0, 113, 0, 4)
                        outerSlider.Parent = slider
    
                        local sliderCorner = Instance.new("UICorner")
                        sliderCorner.Name = "SliderCorner"
                        sliderCorner.CornerRadius = UDim.new(0, 100)
                        sliderCorner.Parent = outerSlider
        
                        local innerSlider = Instance.new("Frame")
                        innerSlider.Name = "InnerSlider"
                        innerSlider.BackgroundColor3 = Color3.fromRGB(48, 207, 106)
                        innerSlider.BorderSizePixel = 0
                        innerSlider.Size = UDim2.new(DefaultScale, 0, 0, 4)
                        innerSlider.ZIndex = 2
                        innerSlider.Parent = outerSlider
        
                        ColorElements[innerSlider] = {Type = "Slider", Enabled = false}
        
                        local innerSliderCorner = Instance.new("UICorner")
                        innerSliderCorner.Name = "InnerSliderCorner"
                        innerSliderCorner.CornerRadius = UDim.new(0, 100)
                        innerSliderCorner.Parent = innerSlider
        
                        local sliderButton = Instance.new("TextButton")
                        sliderButton.Name = "SliderButton"
                        sliderButton.Font = Enum.Font.SourceSans
                        sliderButton.Text = ""
                        sliderButton.TextColor3 = Color3.fromRGB(0, 0, 0)
                        sliderButton.TextSize = 14
                        sliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        sliderButton.BackgroundTransparency = 1
                        sliderButton.Position = UDim2.new(0.049, 0, 0.664, 0)
                        sliderButton.Size = UDim2.new(0, 113, 0, 4)
                        sliderButton.Parent = slider
    
                        local sliderValueText = Instance.new("TextLabel")
                        sliderValueText.Name = "SliderValueText"
                        sliderValueText.Font = Enum.Font.GothamBold
                        sliderValueText.Text = tostring(Info.Default) .. Info.Postfix
                        sliderValueText.TextColor3 = Color3.fromRGB(217, 217, 217)
                        sliderValueText.TextSize = 11
                        sliderValueText.TextXAlignment = Enum.TextXAlignment.Right
                        sliderValueText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        sliderValueText.BackgroundTransparency = 1
                        sliderValueText.Position = UDim2.new(0.0488, 0, 0, 0)
                        sliderValueText.Size = UDim2.new(0, 149, 0, 27)
                        sliderValueText.Parent = slider

                        local sliderValueTextFrame = Instance.new("Frame")
                        sliderValueTextFrame.Name = "sliderValueTextFrame"
                        sliderValueTextFrame.BackgroundColor3 = Color3.fromRGB(68, 68, 68)
                        sliderValueTextFrame.BorderSizePixel = 0
                        sliderValueTextFrame.Position = UDim2.new(0.787, 0, 0.15, 0)
                        sliderValueTextFrame.Size = UDim2.new(0, 23.5, 0, 14)
                        sliderValueTextFrame.Parent = slider
                        sliderValueTextFrame.Visible = true
                        sliderValueTextFrame.BackgroundTransparency = 1

                        local sliderValueTextButton = Instance.new("TextButton")
                        sliderValueTextButton.Name = "sliderValueTextButton"
                        sliderValueTextButton.Font = Enum.Font.SourceSans
                        sliderValueTextButton.Text = ""
                        sliderValueTextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
                        sliderValueTextButton.TextSize = 14
                        sliderValueTextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        sliderValueTextButton.BackgroundTransparency = 1
                        sliderValueTextButton.Position = UDim2.new(0, 0, 0, 0)
                        sliderValueTextButton.Size = UDim2.new(0, 22.5, 0, 13)
                        sliderValueTextButton.Parent = sliderValueTextFrame
                        sliderValueTextButton.ZIndex = 2

                        sliderValueTextButton.MouseButton2Down:Connect(
                            function()
                                sliderValueText.Text = "."
                                task.wait(0.1)
                                sliderValueText.Text = ".."
                                task.wait(0.1)
                                sliderValueText.Text = "..."

                                local UserInputService = game:GetService("UserInputService")
                                local numberString = ""
                                local changeNumber = true
                                
                                UserInputService.InputBegan:Connect(function(input)
                                    if input.UserInputType == Enum.UserInputType.Keyboard then
                                        if changeNumber == true then
                                            local key = input.KeyCode
                                            if key.Value >= Enum.KeyCode.Zero.Value and key.Value <= Enum.KeyCode.Nine.Value then
                                                local number = key.Value - Enum.KeyCode.Zero.Value
                                                numberString = numberString .. tostring(number)
                                                sliderValueText.Text = numberString .. Info.Postfix
                                            elseif key == Enum.KeyCode.Backspace then
                                                numberString = numberString:sub(1, -2)
                                                sliderValueText.Text = numberString .. Info.Postfix
                                            elseif key == Enum.KeyCode.Return then
                                                if Info.Flag ~= nil then
                                                    library.Flags[Info.Flag] = tonumber(numberString)
                                                end
                                                sliderValueText.Text = numberString .. Info.Postfix
                                                task.spawn(
                                                    function()
                                                        pcall(Info.Callback, tonumber(numberString))
                                                    end
                                                )
                                                changeNumber = false
                                            end
                                        end
                                    elseif (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.MouseButton2) and changeNumber == true then
                                        if Info.Flag ~= nil then
                                            library.Flags[Info.Flag] = tonumber(numberString)
                                        end
                                        sliderValueText.Text = numberString .. Info.Postfix
                                        task.spawn(
                                            function()
                                                pcall(Info.Callback, tonumber(numberString))
                                            end
                                        )
                                        changeNumber = false
                                    end
                                end)
                            end
                        )
    
                        local toggleFrame = Instance.new("Frame")
                        toggleFrame.Name = "ToggleFrame"
                        toggleFrame.BackgroundColor3 = Color3.fromRGB(68, 68, 68)
                        toggleFrame.BorderSizePixel = 0
                        toggleFrame.Position = UDim2.new(0.725, 0, 0.57, 0)
                        toggleFrame.Size = UDim2.new(0, 30, 0, 15)
                        toggleFrame.Parent = slider
                        toggleFrame.Visible = true
                        toggleFrame.BackgroundTransparency = 0
        
                        local toggleButton = Instance.new("TextButton")
                        toggleButton.Name = "ToggleButton"
                        toggleButton.Font = Enum.Font.SourceSans
                        toggleButton.Text = ""
                        toggleButton.TextColor3 = Color3.fromRGB(0, 0, 0)
                        toggleButton.TextSize = 14
                        toggleButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        toggleButton.BackgroundTransparency = 1
                        toggleButton.Size = UDim2.new(0, 162, 0, 27)
                        toggleButton.Position = UDim2.new(0, 5, 0, -2)
                        toggleButton.Parent = toggleFrame
        
                        ColorElements[toggleFrame] = {Type = "Toggle", Enabled = false}
        
                        local toggleUICorner = Instance.new("UICorner")
                        toggleUICorner.Name = "ToggleUICorner"
                        toggleUICorner.CornerRadius = UDim.new(0, 100)
                        toggleUICorner.Parent = toggleFrame
        
                        local circleIcon = Instance.new("ImageLabel")
                        circleIcon.Name = "CheckIcon"
                        circleIcon.Image = "rbxassetid://14658187312"
                        circleIcon.ImageColor3 = Color3.fromRGB(217, 217, 217)
                        circleIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        circleIcon.BackgroundTransparency = 1
                        circleIcon.Position = UDim2.new(0, 1, 0.067, 0)
                        circleIcon.Size = UDim2.new(0, 13, 0, 13)
                        circleIcon.Parent = toggleFrame
    
                        local insidetoggle = {}
    
                        local Toggled = false
    
                        function insidetoggle:Set(bool)
                            Toggled = bool
                            if Info.Flag ~= nil then
                                library.Flags[Info.ButtonFlag] = Toggled
                            end
                            ColorElements[toggleFrame].Enabled = Toggled
        
                            TweenService:Create(
                                circleIcon,
                                TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                                {Position = Toggled and UDim2.new(0, 16, 0.067, 0) or UDim2.new(0, 1, 0.067, 0)}
                            ):Play()
                            if not Toggled then
                                TweenService:Create(
                                    toggleFrame,
                                    TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                                    {BackgroundColor3 = Color3.fromRGB(68, 68, 68)}
                                ):Play()
                            elseif Toggled and not EditOpened then
                                TweenService:Create(
                                    toggleFrame,
                                    TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                                    {BackgroundColor3 = Color3.fromRGB(48, 207, 106)}
                                ):Play()
                            end
                            pcall(Info.ButtonCallback, Toggled)
                        end
        
                        toggleButton.MouseButton1Click:Connect(
                            function()
                                Toggled = not Toggled
                                insidetoggle:Set(Toggled)
                            end
                        )
        
                        task.spawn(
                            function()
                                pcall(Info.Callback, Info.Default)
                                if Info.Flag ~= nil then
                                    library.Flags[Info.Flag] = Info.Default
                                end
                            end
                        )
                        
                        local PressKey = Info.KeybindDefault
                        local IsKeyDown = false
                        local HasToggled = false
                        
                        local keybindFrame = Instance.new("Frame")
                        keybindFrame.Name = "KeybindFrame"
                        keybindFrame.BackgroundColor3 = Color3.fromRGB(68, 68, 68)
                        keybindFrame.AnchorPoint = Vector2.new(1, 0)
                        keybindFrame.BorderSizePixel = 0
                        keybindFrame.BackgroundTransparency = 0
                        keybindFrame.Position = UDim2.new(0, 158, 0.575, 0)
                        keybindFrame.Size = UDim2.new(0, 30, 0, 15)
                        keybindFrame.Parent = slider
                        keybindFrame.Visible = false
        
                        local keybindUICorner = Instance.new("UICorner")
                        keybindUICorner.Name = "KeybindUICorner"
                        keybindUICorner.CornerRadius = UDim.new(0, 3)
                        keybindUICorner.Parent = keybindFrame
        
                        local keybindFrameText = Instance.new("TextLabel")
                        keybindFrameText.Name = "KeybindFrameText"
                        keybindFrameText.Font = Enum.Font.GothamBold
                        keybindFrameText.Text = PressKey.Name
                        keybindFrameText.TextColor3 = Color3.fromRGB(217, 217, 217)
                        keybindFrameText.TextSize = 11
                        keybindFrameText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        keybindFrameText.Size = UDim2.new(1, 0, 0, 15)
                        keybindFrameText.BackgroundTransparency = 1
                        keybindFrameText.Parent = keybindFrame
        
                        local keybindButton = Instance.new("TextButton")
                        keybindButton.Name = "KeybindButton"
                        keybindButton.Font = Enum.Font.SourceSans
                        keybindButton.Text = ""
                        keybindButton.TextColor3 = Color3.fromRGB(0, 0, 0)
                        keybindButton.TextSize = 14
                        keybindButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        keybindButton.BackgroundTransparency = 1
                        keybindButton.Size = UDim2.new(1, 0, 0, 15)
                        keybindButton.Parent = keybindFrame
    
                        local keybindUIStroke = Instance.new("UIStroke")
                        keybindUIStroke.Name = "KeybindUIStroke"
                        keybindUIStroke.Color = Color3.fromRGB(84, 84, 84)
                        keybindUIStroke.Parent = keybindFrame
    
                        local keybindText = Instance.new("TextLabel")
                        keybindText.Name = "KeybindText"
                        keybindText.Font = Enum.Font.GothamBold
                        keybindText.TextColor3 = Color3.fromRGB(217, 217, 217)
                        keybindText.TextSize = 11
                        keybindText.TextXAlignment = Enum.TextXAlignment.Left
                        keybindText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        keybindText.BackgroundTransparency = 1
                        keybindText.Position = UDim2.new(0.0488, 0, 0, 0)
                        keybindText.Size = UDim2.new(0, 156, 0, 27)
                        keybindText.Parent = keybind
        
                        local TextBounds = keybindFrameText.TextBounds
        
                        keybindFrame.Size = UDim2.new(0, TextBounds.X + 10, 0, 15)
        
                        keybindFrameText:GetPropertyChangedSignal("Text"):Connect(
                            function()
                                TextBounds = keybindFrameText.TextBounds
        
                                keybindFrame.Size = UDim2.new(0, TextBounds.X + 10, 0, 15)
                            end
                        )
        
                        local KeybindConnection
                        local Changing = false
        
                        if keybindFrameText.Text == "Clear" then
                            keybindFrameText.Text = "?"
                        end
    
                        keybindButton.MouseButton1Click:Connect(
                            function()
                                if KeybindConnection then
                                    KeybindConnection:Disconnect()
                                end
                                Changing = true
                                keybindFrameText.Text = "..."
                                KeybindConnection =
                                    UserInputService.InputBegan:Connect(
                                    function(Key, gameProcessed)
                                        if not table.find(Blacklist, Key.KeyCode) and not gameProcessed then
                                            KeybindConnection:Disconnect()
                                            keybindFrameText.Text = Key.KeyCode.Name
                                            PressKey = Key.KeyCode
                                            wait(.1)
                                            Changing = false
                                        end
                                    end
                                )
                            end
                        )
        
                        local KeyPressed = false
                        
                        UserInputService.InputBegan:Connect(
                            function(Key, gameProcessed)
                                if not Changing and Key.KeyCode == PressKey and not gameProcessed then
                                    if not KeyPressed then
                                        IsKeyDown = true
                                        KeyPressed = true
                                    else
                                        IsKeyDown = false
                                        KeyPressed = false
                                    end
                                    task.spawn(
                                        function()
                                            insidetoggle:Set(IsKeyDown)
                                        end
                                    )
                                end
                            end
                        )
    
                        local settingsisopen = false
    
                        SliderButtonSettings.MouseButton2Click:Connect(
                            function()
                                if not settingsisopen then
                                    spawn(function()
                                        local tweenwait = TweenService:Create(
                                            toggleFrame,
                                            TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                                            {BackgroundTransparency = 1}
                                        )
    
                                        tweenwait:Play()
                                        tweenwait.Completed:Wait()
    
                                        toggleFrame.Visible = false
                                        task.wait(0.075)
                                        keybindFrame.Visible = true
                                    end)
    
                                    task.wait(0.05)
    
                                    TweenService:Create(
                                        slider,
                                        TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                                        {Size = UDim2.new(0, 175, 0, 50)}
                                    ):Play()
    
                                    TweenService:Create(
                                        sliderButton,
                                        TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                                        {Position = UDim2.new(0.049, 0, 0.500, 0)}
                                    ):Play()
    
                                    TweenService:Create(
                                        outerSlider,
                                        TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                                        {Position = UDim2.new(0.049, -1, 0.500, 0)}
                                    ):Play()
    
                                    settingsisopen = true
    
                                elseif settingsisopen then
    
                                    spawn(function()
                                        keybindFrame.Visible = false
                                        local tweenwait = TweenService:Create(
                                            toggleFrame,
                                            TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                                            {BackgroundTransparency = 0}
                                        )
    
                                        tweenwait:Play()
                                        tweenwait.Completed:Wait()
    
                                        task.wait(0.05)
                                        toggleFrame.Visible = true
                                    end)
    
                                    task.wait(0.05)
    
                                    TweenService:Create(
                                        slider,
                                        TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                                        {Size = UDim2.new(0, 175, 0, 40)}
                                    ):Play()
    
                                    TweenService:Create(
                                        sliderButton,
                                        TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                                        {Position = UDim2.new(0.049, 0, 0.664, 0)}
                                    ):Play()
    
                                    TweenService:Create(
                                        outerSlider,
                                        TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                                        {Position = UDim2.new(0.049, -1, 0.664, 0)}
                                    ):Play()
    
                                    settingsisopen = false
                                    toggleFrame.Visible = true
                                end
                            end
                        )
        
                        local MinSize = 0
                        local MaxSize = 1
        
                        local SizeFromScale = (MinSize + (MaxSize - MinSize)) * DefaultScale
                        SizeFromScale = SizeFromScale - (SizeFromScale % 2)
        
                        sliderButton.MouseButton1Down:Connect(
                            function()
                                local MouseMove, MouseKill
                                MouseMove =
                                    Mouse.Move:Connect(
                                    function()
                                        local Px = library:GetXY(outerSlider)
                                        local SizeFromScale = (MinSize + (MaxSize - MinSize)) * Px
                                        local Value = math.floor(Info.Minimum + ((Info.Maximum - Info.Minimum) * Px))
                                        SizeFromScale = SizeFromScale - (SizeFromScale % 2)
                                        TweenService:Create(innerSlider, TweenInfo.new(0.1), {Size = UDim2.new(Px, 0, 0, 4)}):Play(
        
                                        )
                                        if Info.Flag ~= nil then
                                            library.Flags[Info.Flag] = Value
                                        end
                                        sliderValueText.Text = tostring(Value) .. Info.Postfix
                                        
                                        task.spawn(
                                            function()
                                                pcall(Info.Callback, Value)
                                            end
                                        )
                                    end
                                )
                                MouseKill =
                                    UserInputService.InputEnded:Connect(
                                    function(UserInput)
                                        if UserInput.UserInputType == Enum.UserInputType.MouseButton1 then
                                            MouseMove:Disconnect()
                                            MouseKill:Disconnect()
                                        end
                                    end
                                )
                            end
                        )
                        local function createColorTween(frame, targetColor)
                            local tweenInfo = TweenInfo.new(
                                0.25, -- Time
                                Enum.EasingStyle.Linear, -- Easing Style
                                Enum.EasingDirection.Out -- Easing Direction
                            )
                        
                            local tween = TweenService:Create(
                                frame, -- Instance to tween
                                tweenInfo, -- TweenInfo
                                { BackgroundColor3 = targetColor } -- What we want to change
                            )
                        
                            return tween
                        end
                        
                        
                        local fadeInTween = createColorTween(slider, Color3.fromRGB(49, 49, 49))
                        local fadeOutTween = createColorTween(slider, Color3.fromRGB(42, 42, 42))
                        
                        slider.MouseEnter:Connect(function()
                            fadeInTween:Play()
                        end)
                        
                        slider.MouseLeave:Connect(function()
                            fadeOutTween:Play()
                        end)
                    end
                    return insidetoggle
                end -- Above here
    
                function sectiontable:Dropdown(Info)
                    Info.Text = Info.Text or "Dropdown"
                    Info.List = Info.List or {}
                    Info.Flag = Info.Flag or nil
                    Info.Callback = Info.Callback or function()
                        end
                    Info.Tooltip = Info.Tooltip or ""
                    Info.Default = Info.Default or nil
    
                    local DropdownYSize = 27
    
                    if Info.Default ~= nil then
                        task.spawn(
                            function()
                                pcall(Info.Callback, Info.Default)
                            end
                        )
                        if Info.Flag ~= nil then
                            library.Flags[Info.Flag] = Info.Default
                        end
                    end
    
                    local insidedropdown = {}
    
                    local dropdown = Instance.new("Frame")
                    dropdown.Name = "Dropdown"
                    dropdown.BackgroundColor3 = sectionFrame.BackgroundColor3
                    dropdown.BackgroundTransparency = 0
                    dropdown.BorderColor3 = dropdown.BackgroundColor3
                    dropdown.Position = UDim2.new(0, 0, 0.638, 0)
                    dropdown.Size = UDim2.new(0, 162, 0, 27)
                    dropdown.Parent = sectionFrame
                    dropdown.ClipsDescendants = true
    
                    if Info.Tooltip ~= "" then
                        AddTooltip(dropdown, Info.Tooltip)
                    end
    
                    local dropdownText = Instance.new("TextLabel")
                    dropdownText.Name = "DropdownText"
                    dropdownText.Font = Enum.Font.GothamBold
                    dropdownText.Text = Info.Text
                    dropdownText.TextColor3 = Color3.fromRGB(217, 217, 217)
                    dropdownText.TextSize = 11
                    dropdownText.TextXAlignment = Enum.TextXAlignment.Left
                    dropdownText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    dropdownText.BackgroundTransparency = 1
                    dropdownText.Position = UDim2.new(0.0488, 0, 0, 0)
                    dropdownText.Size = UDim2.new(0, 156, 0, 27)
                    dropdownText.Parent = dropdown
    
                    local dropdownIcon = Instance.new("ImageLabel")
                    dropdownIcon.Name = "DropdownIcon"
                    dropdownIcon.Image = "rbxassetid://14658191556"
                    dropdownIcon.ImageColor3 = Color3.fromRGB(191, 191, 191)
                    dropdownIcon.AnchorPoint = Vector2.new(1, 0)
                    dropdownIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    dropdownIcon.BackgroundTransparency = 1
                    dropdownIcon.Rotation = -90
                    dropdownIcon.Position = UDim2.new(0, 155, 0, 7)
                    dropdownIcon.Size = UDim2.new(0, 13, 0, 13)
                    dropdownIcon.ZIndex = 2
                    dropdownIcon.Parent = dropdown
    
                    local dropdownButton = Instance.new("TextButton")
                    dropdownButton.Name = "DropdownButton"
                    dropdownButton.Font = Enum.Font.SourceSans
                    dropdownButton.Text = ""
                    dropdownButton.TextColor3 = Color3.fromRGB(0, 0, 0)
                    dropdownButton.TextSize = 14
                    dropdownButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    dropdownButton.BackgroundTransparency = 1
                    dropdownButton.Size = UDim2.new(0, 162, 0, 27)
                    dropdownButton.Parent = dropdown
    
                    local dropdownContainer = Instance.new("Frame")
                    dropdownContainer.Name = "DropdownContainer"
                    dropdownContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    dropdownContainer.BackgroundTransparency = 1
                    dropdownContainer.BorderSizePixel = 0
                    dropdownContainer.Size = UDim2.new(0, 162, 0, 27)
                    dropdownContainer.Parent = dropdown
                    dropdownContainer.Visible = true
    
                    local dropdownuIListLayout = Instance.new("UIListLayout")
                    dropdownuIListLayout.Name = "UIListLayout"
                    dropdownuIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                    dropdownuIListLayout.Parent = dropdownContainer
    
                    local dropdownuIPadding = Instance.new("UIPadding")
                    dropdownuIPadding.Name = "UIPadding"
                    dropdownuIPadding.PaddingTop = UDim.new(0, 27)
                    dropdownuIPadding.Parent = dropdownContainer
    
                    local DropdownOpened = false
    
                    function insidedropdown:Add(text)
                        DropdownYSize = DropdownYSize + 27
    
                        local dropdownContainerButton = Instance.new("Frame")
                        dropdownContainerButton.Name = "DropdownContainerButton"
                        dropdownContainerButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        dropdownContainerButton.BackgroundTransparency = 1
                        dropdownContainerButton.Size = UDim2.new(0, 162, 0, 27)
                        dropdownContainerButton.Parent = dropdownContainer
    
                        local dropdownbuttonText = Instance.new("TextLabel")
                        dropdownbuttonText.Name = "ButtonText"
                        dropdownbuttonText.Font = Enum.Font.GothamBold
                        dropdownbuttonText.Text = text
                        dropdownbuttonText.TextColor3 = Color3.fromRGB(191, 191, 191)
                        if dropdownbuttonText.Text == Info.Text then
                            dropdownbuttonText.TextColor3 = Color3.fromRGB(96, 216, 107)
                        else
                            dropdownbuttonText.TextColor3 = Color3.fromRGB(191, 191, 191)
                        end
                        dropdownbuttonText.TextSize = 11
                        dropdownbuttonText.TextXAlignment = Enum.TextXAlignment.Left
                        dropdownbuttonText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        dropdownbuttonText.BackgroundTransparency = 1
                        dropdownbuttonText.Position = UDim2.new(0.0488, 0, 0, 0)
                        dropdownbuttonText.Size = UDim2.new(0, 156, 0, 28)
                        dropdownbuttonText.Parent = dropdownContainerButton
    
                        local dropdownContainerTextButton = Instance.new("TextButton")
                        dropdownContainerTextButton.Name = "DropdownContainerButton"
                        dropdownContainerTextButton.Font = Enum.Font.SourceSans
                        dropdownContainerTextButton.Text = ""
                        dropdownContainerTextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
                        dropdownContainerTextButton.TextSize = 14
                        dropdownContainerTextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        dropdownContainerTextButton.BackgroundTransparency = 1
                        dropdownContainerTextButton.Size = UDim2.new(0, 162, 0, 27)
                        dropdownContainerTextButton.Parent = dropdownContainerButton
    
                        dropdownContainerTextButton.MouseEnter:Connect(
                            function()
                                TweenService:Create(
                                    dropdownbuttonText,
                                    TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                                    {TextColor3 = Color3.fromRGB(255, 255, 255)}
                                ):Play()
                            end
                        )
    
                        dropdownContainerTextButton.MouseLeave:Connect(
                            function()
                                TweenService:Create(
                                    dropdownbuttonText,
                                    TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                                    {TextColor3 = Color3.fromRGB(191, 191, 191)}
                                ):Play()
                            end
                        )
    
                        dropdownContainerTextButton.MouseButton1Click:Connect(
                            function()
                                DropdownOpened = false
    
                                task.spawn(
                                    function()
                                        pcall(Info.Callback, dropdownbuttonText.Text)
                                        dropdownbuttonText.TextColor3 = Color3.fromRGB(96, 216, 107)
                                    end
                                )
                                if Info.Flag ~= nil then
                                    library.Flags[Info.Flag] = dropdownbuttonText.Text
                                end
                                dropdownText.Text = dropdownbuttonText.Text
    
                                TweenService:Create(
                                    dropdownIcon,
                                    TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                                    {Rotation = DropdownOpened and -180 or -90}
                                ):Play()
                                TweenService:Create(
                                    dropdownIcon,
                                    TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                                    {
                                        ImageColor3 = DropdownOpened and Color3.fromRGB(255, 255, 255) or
                                            Color3.fromRGB(191, 191, 191)
                                    }
                                ):Play()
                                TweenService:Create(
                                    dropdown,
                                    TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                                    {
                                        Size = DropdownOpened and UDim2.new(0, 162, 0, DropdownYSize) or
                                            UDim2.new(0, 162, 0, 27)
                                    }
                                ):Play()
                                TweenService:Create(
                                    dropdownContainer,
                                    TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                                    {
                                        Size = DropdownOpened and UDim2.new(0, 162, 0, DropdownYSize) or
                                            UDim2.new(0, 162, 0, 27)
                                    }
                                ):Play()
                                TweenService:Create(
                                    dropdownContainer,
                                    TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                                    {BackgroundTransparency = DropdownOpened and .96 or 1}
                                ):Play()
                                TweenService:Create(
                                    sectionFrame,
                                    TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                                    {
                                        Size = DropdownOpened and
                                            UDim2.new(0, 162, 0, sectionFrame.Size.Y.Offset + DropdownYSize - 27) or
                                            UDim2.new(0, 162, 0, sectionFrame.Size.Y.Offset - DropdownYSize + 27)
                                    }
                                ):Play()
                                TweenService:Create(
                                    section,
                                    TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                                    {
                                        Size = DropdownOpened and
                                            UDim2.new(0, 162, 0, sectionFrame.Size.Y.Offset + DropdownYSize - 27 + 4) or
                                            UDim2.new(0, 162, 0, sectionFrame.Size.Y.Offset - DropdownYSize + 31)
                                    }
                                ):Play()
                            end
                        )
                    end
    
                    function insidedropdown:Refresh(RefreshInfo)
                        RefreshInfo.Text = RefreshInfo.Text or dropdownText.Text
                        RefreshInfo.List = RefreshInfo.List or Info.List
    
                        for _, v in pairs(dropdownContainer:GetChildren()) do
                            if v.ClassName == "Frame" then
                                DropdownYSize = DropdownYSize - 27
                                if DropdownOpened then
                                    sectionFrame.Size = UDim2.new(0, 162, 0, sectionFrame.Size.Y.Offset - 27)
                                    section.Size = UDim2.new(0, 162, 0, section.Size.Y.Offset - 27)
                                end
                                v:Destroy()
                            end
                        end
    
                        DropdownOpened = false
    
                        for _, v in pairs(RefreshInfo.List) do
                            insidedropdown:Add(v)
                        end
    
                        TweenService:Create(
                            dropdownIcon,
                            TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                            {Rotation = DropdownOpened and -180 or -90}
                        ):Play()
                        TweenService:Create(
                            dropdownIcon,
                            TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                            {
                                ImageColor3 = DropdownOpened and Color3.fromRGB(255, 255, 255) or
                                    Color3.fromRGB(191, 191, 191)
                            }
                        ):Play()
                        TweenService:Create(
                            dropdown,
                            TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                            {Size = DropdownOpened and UDim2.new(0, 162, 0, DropdownYSize) or UDim2.new(0, 162, 0, 27)}
                        ):Play()
                        TweenService:Create(
                            dropdownContainer,
                            TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                            {Size = DropdownOpened and UDim2.new(0, 162, 0, DropdownYSize) or UDim2.new(0, 162, 0, 27)}
                        ):Play()
                        TweenService:Create(
                            dropdownContainer,
                            TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                            {BackgroundTransparency = DropdownOpened and .96 or 1}
                        ):Play()
                    end
    
                    for _, v in pairs(Info.List) do
                        insidedropdown:Add(v)
                    end
    
                    Closed:GetPropertyChangedSignal("Value"):Connect(
                        function()
                            if not Closed.Value then
                                DropdownOpened = false
    
                                TweenService:Create(
                                    dropdownIcon,
                                    TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                                    {Rotation = DropdownOpened and -180 or -90}
                                ):Play()
                                TweenService:Create(
                                    dropdownIcon,
                                    TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                                    {
                                        ImageColor3 = DropdownOpened and Color3.fromRGB(255, 255, 255) or
                                            Color3.fromRGB(191, 191, 191)
                                    }
                                ):Play()
                                TweenService:Create(
                                    dropdown,
                                    TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                                    {
                                        Size = DropdownOpened and UDim2.new(0, 162, 0, DropdownYSize) or
                                            UDim2.new(0, 162, 0, 27)
                                    }
                                ):Play()
                                TweenService:Create(
                                    dropdownContainer,
                                    TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                                    {
                                        Size = DropdownOpened and UDim2.new(0, 162, 0, DropdownYSize) or
                                            UDim2.new(0, 162, 0, 27)
                                    }
                                ):Play()
                                TweenService:Create(
                                    dropdownContainer,
                                    TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                                    {BackgroundTransparency = DropdownOpened and .96 or 1}
                                ):Play()
                                TweenService:Create(
                                    sectionFrame,
                                    TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                                    {
                                        Size = DropdownOpened and
                                            UDim2.new(0, 162, 0, sectionFrame.Size.Y.Offset + DropdownYSize - 27) or
                                            UDim2.new(0, 162, 0, sectionFrame.Size.Y.Offset - DropdownYSize + 27)
                                    }
                                ):Play()
                                TweenService:Create(
                                    section,
                                    TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                                    {
                                        Size = DropdownOpened and
                                            UDim2.new(0, 162, 0, sectionFrame.Size.Y.Offset + DropdownYSize - 27 + 4) or
                                            UDim2.new(0, 162, 0, sectionFrame.Size.Y.Offset - DropdownYSize + 31)
                                    }
                                ):Play()
                            end
                        end
                    )
    
                    dropdownButton.MouseButton1Click:Connect(
                        function()
                            DropdownOpened = not DropdownOpened
                            dropdownButton.TextColor3 = Color3.fromRGB(96, 216, 107)
    
                            TweenService:Create(
                                dropdownIcon,
                                TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                                {Rotation = DropdownOpened and -180 or -90}
                            ):Play()
                            TweenService:Create(
                                dropdownIcon,
                                TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                                {
                                    ImageColor3 = DropdownOpened and Color3.fromRGB(255, 255, 255) or
                                        Color3.fromRGB(191, 191, 191)
                                }
                            ):Play()
                            TweenService:Create(
                                dropdown,
                                TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                                {Size = DropdownOpened and UDim2.new(0, 162, 0, DropdownYSize) or UDim2.new(0, 162, 0, 27)}
                            ):Play()
                            TweenService:Create(
                                dropdownContainer,
                                TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                                {Size = DropdownOpened and UDim2.new(0, 162, 0, DropdownYSize) or UDim2.new(0, 162, 0, 27)}
                            ):Play()
                            TweenService:Create(
                                dropdownContainer,
                                TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                                {BackgroundTransparency = DropdownOpened and .96 or 1}
                            ):Play()
                            TweenService:Create(
                                sectionFrame,
                                TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                                {
                                    Size = DropdownOpened and
                                        UDim2.new(0, 162, 0, sectionFrame.Size.Y.Offset + DropdownYSize - 27) or
                                        UDim2.new(0, 162, 0, sectionFrame.Size.Y.Offset - DropdownYSize + 27)
                                }
                            ):Play()
                            TweenService:Create(
                                section,
                                TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                                {
                                    Size = DropdownOpened and
                                        UDim2.new(0, 162, 0, sectionFrame.Size.Y.Offset + DropdownYSize - 27 + 4) or
                                        UDim2.new(0, 162, 0, sectionFrame.Size.Y.Offset - DropdownYSize + 31)
                                }
                            ):Play()
                        end
                    )
    
                    local function createColorTween(frame, targetColor)
                        local tweenInfo = TweenInfo.new(
                            0.25, -- Time
                            Enum.EasingStyle.Linear, -- Easing Style
                            Enum.EasingDirection.Out -- Easing Direction
                        )
                    
                        local tween = TweenService:Create(
                            frame, -- Instance to tween
                            tweenInfo, -- TweenInfo
                            { BackgroundColor3 = targetColor } -- What we want to change
                        )
                    
                        return tween
                    end
                    
                    
                    local fadeInTween = createColorTween(dropdown, Color3.fromRGB(49, 49, 49))
                    local fadeOutTween = createColorTween(dropdown, Color3.fromRGB(42, 42, 42))
                    
                    dropdown.MouseEnter:Connect(function()
                        fadeInTween:Play()
                    end)
                    
                    dropdown.MouseLeave:Connect(function()
                        fadeOutTween:Play()
                    end)
    
                    return insidedropdown
                end
    
                function sectiontable:RadioButton(Info)
                    Info.Text = Info.Text or "Radio Button"
                    Info.Options = Info.Options or {}
                    Info.Flag = Info.Flag or nil
                    Info.Callback = Info.Callback or function()
                        end
                    Info.Tooltip = Info.Tooltip or ""
                    Info.Default = Info.Default or nil
    
                    local RadioOpened = false
    
                    RadioYSize = 27
    
                    if Info.Default ~= nil then
                        task.spawn(
                            function()
                                pcall(Info.Callback, Info.Default)
                            end
                        )
                        if Info.Flag ~= nil then
                            library.Flags[Info.Flag] = Info.Default
                        end
                    end
    
                    local insideradio = {}
    
                    local radioButton = Instance.new("Frame")
                    radioButton.Name = "RadioButton"
                    radioButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    radioButton.BackgroundTransparency = 1
                    radioButton.Size = UDim2.new(0, 162, 0, 27)
                    radioButton.Parent = sectionFrame
    
                    if Info.Tooltip ~= "" then
                        AddTooltip(radioButton, Info.Tooltip)
                    end
    
                    local button = Instance.new("Frame")
                    button.Name = "Button"
                    button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    button.BackgroundTransparency = 1
                    button.Size = UDim2.new(0, 162, 0, 27)
                    button.Parent = radioButton
    
                    local radioButtonTextButton = Instance.new("TextButton")
                    radioButtonTextButton.Name = "RadioButtonTextButton"
                    radioButtonTextButton.Font = Enum.Font.SourceSans
                    radioButtonTextButton.Text = ""
                    radioButtonTextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
                    radioButtonTextButton.TextSize = 14
                    radioButtonTextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    radioButtonTextButton.BackgroundTransparency = 1
                    radioButtonTextButton.Size = UDim2.new(0, 162, 0, 27)
                    radioButtonTextButton.Parent = button
    
                    local radioButtonText = Instance.new("TextLabel")
                    radioButtonText.Name = "RadioButtonText"
                    radioButtonText.Font = Enum.Font.GothamBold
                    radioButtonText.Text = Info.Text
                    radioButtonText.TextColor3 = Color3.fromRGB(217, 217, 217)
                    radioButtonText.TextSize = 11
                    radioButtonText.TextXAlignment = Enum.TextXAlignment.Left
                    radioButtonText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    radioButtonText.BackgroundTransparency = 1
                    radioButtonText.Position = UDim2.new(0.0488, 0, 0, 0)
                    radioButtonText.Size = UDim2.new(0, 156, 0, 27)
                    radioButtonText.Parent = button
    
                    local radioButtonIcon = Instance.new("ImageLabel")
                    radioButtonIcon.Name = "RadioButtonIcon"
                    radioButtonIcon.Image = "rbxassetid://14658191556"
                    radioButtonIcon.AnchorPoint = Vector2.new(1, 0)
                    radioButtonIcon.ImageColor3 = Color3.fromRGB(191, 191, 191)
                    radioButtonIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    radioButtonIcon.BackgroundTransparency = 1
                    radioButtonIcon.Rotation = -90
                    radioButtonIcon.BorderSizePixel = 0
                    radioButtonIcon.Position = UDim2.new(0, 155, 0, 7)
                    radioButtonIcon.Size = UDim2.new(0, 13, 0, 13)
                    radioButtonIcon.Parent = button
    
                    local radioButtonIcon2 = Instance.new("ImageLabel")
                    radioButtonIcon2.Name = "RadioButtonIcon2"
                    radioButtonIcon2.Image = "rbxassetid://14658193641"
                    radioButtonIcon2.AnchorPoint = Vector2.new(1, 0)
                    radioButtonIcon2.ImageColor3 = Color3.fromRGB(191, 191, 191)
                    radioButtonIcon2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    radioButtonIcon2.BackgroundTransparency = 1
                    radioButtonIcon2.BorderSizePixel = 0
                    radioButtonIcon2.Position = UDim2.new(0, 138, 0, 7)
                    radioButtonIcon2.Size = UDim2.new(0, 13, 0, 13)
                    radioButtonIcon2.Parent = button
    
                    local radioContainer = Instance.new("Frame")
                    radioContainer.Name = "RadioContainer"
                    radioContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    radioContainer.BackgroundTransparency = 1
                    radioContainer.Size = UDim2.new(0, 162, 0, 27)
                    radioContainer.Parent = radioButton
                    radioContainer.ClipsDescendants = true
    
                    local radioUILayout = Instance.new("UIListLayout")
                    radioUILayout.Name = "RadioUILayout"
                    radioUILayout.SortOrder = Enum.SortOrder.LayoutOrder
                    radioUILayout.Parent = radioContainer
    
                    local radiouIPadding = Instance.new("UIPadding")
                    radiouIPadding.Name = "UIPadding"
                    radiouIPadding.PaddingTop = UDim.new(0, 27)
                    radiouIPadding.Parent = radioContainer
    
                    local RadioSelected = nil
    
                    function insideradio:Button(text)
                        RadioYSize = RadioYSize + 27
    
                        local radio = Instance.new("Frame")
                        radio.Name = "Radio"
                        radio.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        radio.BackgroundTransparency = 1
                        radio.Size = UDim2.new(0, 162, 0, 27)
                        radio.Parent = radioContainer
    
                        local radioTextButton = Instance.new("TextButton")
                        radioTextButton.Name = "RadioTextButton"
                        radioTextButton.Font = Enum.Font.SourceSans
                        radioTextButton.Text = ""
                        radioTextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
                        radioTextButton.TextSize = 14
                        radioTextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        radioTextButton.BackgroundTransparency = 1
                        radioTextButton.Size = UDim2.new(0, 162, 0, 27)
                        radioTextButton.Parent = radio
    
                        local radioOuter = Instance.new("ImageLabel")
                        radioOuter.Name = "RadioOuter"
                        radioOuter.Image = "rbxassetid://14658195812"
                        radioOuter.ImageColor3 = Color3.fromRGB(191, 191, 191)
                        radioOuter.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        radioOuter.BackgroundTransparency = 1
                        radioOuter.BorderSizePixel = 0
                        radioOuter.Position = UDim2.new(0.865, 0, 0.185, 0)
                        radioOuter.Size = UDim2.new(0, 17, 0, 17)
                        radioOuter.Parent = radio
    
                        local radioInner = Instance.new("ImageLabel")
                        radioInner.Name = "RadioInner"
                        radioInner.Image = "rbxassetid://14658198293"
                        radioInner.AnchorPoint = Vector2.new(0.5, 0.5)
                        radioInner.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        radioInner.BackgroundTransparency = 1
                        radioInner.BorderSizePixel = 0
                        radioInner.Position = UDim2.new(0.5, 0, 0.5, 0)
                        radioInner.Size = UDim2.new(0, 7, 0, 7)
                        radioInner.Parent = radioOuter
    
                        ColorElements[radioInner] = {Type = "Toggle", Enabled = false}
                        ColorElements[radioOuter] = {Type = "Toggle", Enabled = false}
    
                        local radioText = Instance.new("TextLabel")
                        radioText.Name = "RadioText"
                        radioText.Font = Enum.Font.GothamBold
                        radioText.Text = text
                        radioText.TextColor3 = Color3.fromRGB(191, 191, 191)
                        radioText.TextSize = 11
                        radioText.TextXAlignment = Enum.TextXAlignment.Left
                        radioText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        radioText.BackgroundTransparency = 1
                        radioText.Position = UDim2.new(0.0488, 0, 0, 0)
                        radioText.Size = UDim2.new(0, 156, 0, 27)
                        radioText.Parent = radio
    
                        radio.MouseEnter:Connect(
                            function()
                                if RadioOpened and RadioSelected ~= radio or RadioSelected == nil then
                                    TweenService:Create(
                                        radioText,
                                        TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                                        {TextColor3 = Color3.fromRGB(217, 217, 217)}
                                    ):Play()
                                    TweenService:Create(
                                        radioInner,
                                        TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                                        {ImageColor3 = Color3.fromRGB(217, 217, 217)}
                                    ):Play()
                                    TweenService:Create(
                                        radioOuter,
                                        TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                                        {ImageColor3 = Color3.fromRGB(217, 217, 217)}
                                    ):Play()
                                end
                            end
                        )
    
                        radio.MouseLeave:Connect(
                            function()
                                if RadioOpened and RadioSelected ~= radio or RadioSelected == nil then
                                    TweenService:Create(
                                        radioText,
                                        TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                                        {TextColor3 = Color3.fromRGB(191, 191, 191)}
                                    ):Play()
                                    TweenService:Create(
                                        radioInner,
                                        TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                                        {ImageColor3 = Color3.fromRGB(191, 191, 191)}
                                    ):Play()
                                    TweenService:Create(
                                        radioOuter,
                                        TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                                        {ImageColor3 = Color3.fromRGB(191, 191, 191)}
                                    ):Play()
                                end
                            end
                        )
    
                        radioTextButton.MouseButton1Click:Connect(
                            function()
                                task.spawn(
                                    function()
                                        pcall(Info.Callback, radioText.Text)
                                    end
                                )
                                if Info.Flag ~= nil then
                                    library.Flags[Info.Flag] = radioText.Text
                                end
    
                                ColorElements[radioInner].Enabled = true
                                ColorElements[radioOuter].Enabled = true
    
                                RadioSelected = radio
    
                                for _, v in pairs(radioContainer:GetChildren()) do
                                    if v.ClassName == "Frame" and v ~= radio then
                                        ColorElements[v.RadioOuter].Enabled = false
                                        ColorElements[v.RadioOuter.RadioInner].Enabled = false
                                        TweenService:Create(
                                            v.RadioOuter,
                                            TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                                            {ImageColor3 = Color3.fromRGB(191, 191, 191)}
                                        ):Play()
                                        TweenService:Create(
                                            v.RadioOuter.RadioInner,
                                            TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                                            {ImageColor3 = Color3.fromRGB(191, 191, 191)}
                                        ):Play()
                                        TweenService:Create(
                                            v.RadioText,
                                            TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                                            {TextColor3 = Color3.fromRGB(191, 191, 191)}
                                        ):Play()
                                    end
                                end
    
                                TweenService:Create(
                                    radioText,
                                    TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                                    {TextColor3 = Color3.fromRGB(255, 255, 255)}
                                ):Play()
    
                                if not EditOpened then
                                    TweenService:Create(
                                        radioInner,
                                        TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                                        {
                                            ImageColor3 = RadioOpened and Color3.fromRGB(48, 207, 106) or
                                                Color3.fromRGB(191, 191, 191)
                                        }
                                    ):Play()
                                    TweenService:Create(
                                        radioOuter,
                                        TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                                        {
                                            ImageColor3 = RadioOpened and Color3.fromRGB(48, 207, 106) or
                                                Color3.fromRGB(191, 191, 191)
                                        }
                                    ):Play()
                                end
                            end
                        )
                    end
    
                    radioButtonTextButton.MouseButton1Click:Connect(
                        function()
                            RadioOpened = not RadioOpened
    
                            TweenService:Create(
                                radioButtonIcon,
                                TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                                {
                                    ImageColor3 = RadioOpened and Color3.fromRGB(255, 255, 255) or
                                        Color3.fromRGB(191, 191, 191)
                                }
                            ):Play()
                            TweenService:Create(
                                radioButtonIcon,
                                TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                                {Rotation = RadioOpened and -180 or -90}
                            ):Play()
                            TweenService:Create(
                                radioButtonIcon2,
                                TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                                {
                                    ImageColor3 = RadioOpened and Color3.fromRGB(255, 255, 255) or
                                        Color3.fromRGB(191, 191, 191)
                                }
                            ):Play()
                            TweenService:Create(
                                radioButton,
                                TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                                {Size = RadioOpened and UDim2.new(0, 162, 0, RadioYSize) or UDim2.new(0, 162, 0, 27)}
                            ):Play()
                            TweenService:Create(
                                radioContainer,
                                TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                                {Size = RadioOpened and UDim2.new(0, 162, 0, RadioYSize) or UDim2.new(0, 162, 0, 27)}
                            ):Play()
                            TweenService:Create(
                                radioContainer,
                                TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                                {BackgroundTransparency = RadioOpened and .96 or 1}
                            ):Play()
                            TweenService:Create(
                                sectionFrame,
                                TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                                {
                                    Size = RadioOpened and
                                        UDim2.new(0, 162, 0, sectionFrame.Size.Y.Offset + RadioYSize - 27) or
                                        UDim2.new(0, 162, 0, sectionFrame.Size.Y.Offset - RadioYSize + 27)
                                }
                            ):Play()
                            TweenService:Create(
                                section,
                                TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                                {
                                    Size = RadioOpened and
                                        UDim2.new(0, 162, 0, sectionFrame.Size.Y.Offset + RadioYSize - 27 + 4) or
                                        UDim2.new(0, 162, 0, sectionFrame.Size.Y.Offset - RadioYSize + 31)
                                }
                            ):Play()
                        end
                    )
    
                    for _, v in pairs(Info.Options) do
                        insideradio:Button(v)
                    end
    
                    Closed:GetPropertyChangedSignal("Value"):Connect(
                        function()
                            if not Closed.Value then
                                RadioOpened = false
    
                                TweenService:Create(
                                    radioButtonIcon,
                                    TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                                    {
                                        ImageColor3 = RadioOpened and Color3.fromRGB(255, 255, 255) or
                                            Color3.fromRGB(191, 191, 191)
                                    }
                                ):Play()
                                TweenService:Create(
                                    radioButtonIcon,
                                    TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                                    {Rotation = RadioOpened and -180 or -90}
                                ):Play()
                                TweenService:Create(
                                    radioButtonIcon2,
                                    TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                                    {
                                        ImageColor3 = RadioOpened and Color3.fromRGB(255, 255, 255) or
                                            Color3.fromRGB(191, 191, 191)
                                    }
                                ):Play()
                                TweenService:Create(
                                    radioButton,
                                    TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                                    {Size = RadioOpened and UDim2.new(0, 162, 0, RadioYSize) or UDim2.new(0, 162, 0, 27)}
                                ):Play()
                                TweenService:Create(
                                    radioContainer,
                                    TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                                    {Size = RadioOpened and UDim2.new(0, 162, 0, RadioYSize) or UDim2.new(0, 162, 0, 27)}
                                ):Play()
                                TweenService:Create(
                                    radioContainer,
                                    TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                                    {BackgroundTransparency = RadioOpened and .96 or 1}
                                ):Play()
                                TweenService:Create(
                                    sectionFrame,
                                    TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                                    {
                                        Size = RadioOpened and
                                            UDim2.new(0, 162, 0, sectionFrame.Size.Y.Offset + RadioYSize - 27) or
                                            UDim2.new(0, 162, 0, sectionFrame.Size.Y.Offset - RadioYSize + 27)
                                    }
                                ):Play()
                                TweenService:Create(
                                    section,
                                    TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                                    {
                                        Size = RadioOpened and
                                            UDim2.new(0, 162, 0, sectionFrame.Size.Y.Offset + RadioYSize - 27 + 4) or
                                            UDim2.new(0, 162, 0, sectionFrame.Size.Y.Offset - RadioYSize + 31)
                                    }
                                ):Play()
                            end
                        end
                    )
    
                    return insideradio
                end
    
                return sectiontable
            end
    
            tabTextButton.MouseButton1Click:Connect(
                function()
                    TabSelected = tabFrame
                    task.spawn(
                        function()
                            for _, v in pairs(main:GetChildren()) do
                                if v.Name == "LeftContainer" or v.Name == "RightContainer" then
                                    v.Visible = false
                                end
                            end
                        end
                    )
                    for _, v in pairs(scrollingContainer:GetChildren()) do
                        if v ~= tabButton and v.Name == "TabButton" then
                            TweenService:Create(
                                v.TabFrame,
                                TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                                {BackgroundTransparency = .96}
                            ):Play()
                        end
                    end
                    TweenService:Create(
                        tabFrame,
                        TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                        {BackgroundTransparency = .85}
                    ):Play()
                    leftContainer.Visible = true
                    rightContainer.Visible = true
                end
            )
    
            function tab:Select()
                TabSelected = tabFrame
                task.spawn(
                    function()
                        for _, v in pairs(main:GetChildren()) do
                            if v.Name == "LeftContainer" or v.Name == "RightContainer" then
                                v.Visible = false
                            end
                        end
                    end
                )
                for _, v in pairs(scrollingContainer:GetChildren()) do
                    if v ~= tabButton and v.Name == "TabButton" then
                        TweenService:Create(
                            v.TabFrame,
                            TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                            {BackgroundTransparency = .96}
                        ):Play()
                    end
                end
                TweenService:Create(
                    tabFrame,
                    TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                    {BackgroundTransparency = .85}
                ):Play()
                leftContainer.Visible = true
                rightContainer.Visible = true
            end
    
            return tab
        end
    
        local uIListLayout = Instance.new("UIListLayout")
        uIListLayout.Name = "UIListLayout"
        uIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        uIListLayout.Parent = scrollingContainer
    
        local uIPadding = Instance.new("UIPadding")
        uIPadding.Name = "UIPadding"
        uIPadding.Parent = scrollingContainer
    
        local frame2 = Instance.new("Frame")
        frame2.Name = "Frame"
        frame2.AnchorPoint = Vector2.new(1, 0.5)
        frame2.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
        frame2.BorderSizePixel = 0
        frame2.Position = UDim2.new(1, 0, 0.501, 0)
        frame2.Size = UDim2.new(0, 1, 0, 284)
        frame2.Parent = tabContainer
    
        local uIStroke2 = Instance.new("UIStroke")
        uIStroke2.Name = "UIStroke"
        uIStroke2.Color = Color3.fromRGB(61, 61, 61)
        uIStroke2.Parent = main
    
        return window
    end
    
    return library
