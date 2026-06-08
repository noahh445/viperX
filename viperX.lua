local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Clipboard = setclipboard or toclipboard

-- Safe CoreGui/PlayerGui routing
local targetParent = Players.LocalPlayer:WaitForChild("PlayerGui")
local coreGuiSuccess, coreGui = pcall(function() return game:GetService("CoreGui") end)
if coreGuiSuccess and coreGui then
    targetParent = coreGui
end

if targetParent:FindFirstChild("ViperXKeySystem") then
    targetParent:FindFirstChild("ViperXKeySystem"):Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ViperXKeySystem"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 2147483647 
ScreenGui.IgnoreGuiInset = true 
ScreenGui.Parent = targetParent

-- ============================================================================
-- [ NOTIFICATION FUNCTION ]
-- ============================================================================
local function createBadgeNotification(title, message)
    local BadgeNotify = Instance.new("Frame")
    BadgeNotify.Name = "BadgeNotification"
    BadgeNotify.Size = UDim2.new(0, 320, 0, 75)
    BadgeNotify.Position = UDim2.new(1, 340, 1, -20) 
    BadgeNotify.AnchorPoint = Vector2.new(1, 1)
    BadgeNotify.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    BadgeNotify.BackgroundTransparency = 0.15
    BadgeNotify.BorderSizePixel = 0
    BadgeNotify.Parent = ScreenGui

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = BadgeNotify

    local ImageContainer = Instance.new("Frame")
    ImageContainer.Size = UDim2.new(0, 55, 0, 55)
    ImageContainer.Position = UDim2.new(0, 10, 0.5, -27)
    ImageContainer.BackgroundColor3 = Color3.fromRGB(20, 20, 20) 
    ImageContainer.Parent = BadgeNotify

    local UIContainerCorner = Instance.new("UICorner")
    UIContainerCorner.CornerRadius = UDim.new(1, 0)
    UIContainerCorner.Parent = ImageContainer

    local BadgeIcon = Instance.new("ImageLabel")
    BadgeIcon.Size = UDim2.new(0, 50, 0, 50) 
    BadgeIcon.Position = UDim2.new(0.5, -25, 0.5, -25)
    BadgeIcon.BackgroundTransparency = 1
    BadgeIcon.Image = "rbxthumb://type=Asset&id=8652665149&w=150&h=150" 
    BadgeIcon.ImageColor3 = Color3.fromRGB(100, 30, 160)
    BadgeIcon.Parent = ImageContainer

    local NotificationHeader = Instance.new("TextLabel")
    NotificationHeader.Size = UDim2.new(1, -80, 0, 18)
    NotificationHeader.Position = UDim2.new(0, 75, 0, 16)
    NotificationHeader.BackgroundTransparency = 1
    NotificationHeader.Text = title:upper()
    NotificationHeader.TextColor3 = Color3.fromRGB(175, 175, 175)
    NotificationHeader.TextSize = 11
    NotificationHeader.Font = Enum.Font.SourceSansBold
    NotificationHeader.TextXAlignment = Enum.TextXAlignment.Left
    NotificationHeader.Parent = BadgeNotify

    local NotificationBody = Instance.new("TextLabel")
    NotificationBody.Size = UDim2.new(1, -80, 0, 32)
    NotificationBody.Position = UDim2.new(0, 75, 0, 32)
    NotificationBody.BackgroundTransparency = 1
    NotificationBody.Text = message
    NotificationBody.TextColor3 = Color3.fromRGB(255, 255, 255)
    NotificationBody.TextSize = 13
    NotificationBody.Font = Enum.Font.SourceSans
    NotificationBody.TextWrapped = true
    NotificationBody.TextXAlignment = Enum.TextXAlignment.Left
    NotificationBody.TextYAlignment = Enum.TextYAlignment.Top
    NotificationBody.Parent = BadgeNotify

    local slideIn = TweenService:Create(BadgeNotify, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = UDim2.new(1, -20, 1, -20)})
    slideIn:Play()

    task.delay(4, function()
        if BadgeNotify and BadgeNotify.Parent then
            local slideOut = TweenService:Create(BadgeNotify, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(1, 340, 1, -20)})
            slideOut:Play()
            slideOut.Completed:Connect(function()
                BadgeNotify:Destroy()
            end)
        end
    end)
end

-- Safe load alert trigger without thread blocking gates
createBadgeNotification("Loader Active", "viperX environment processing complete.")
task.spawn(function()
    task.wait(1.5) 
    createBadgeNotification("System Loader", "viperX v1 active. Press [K] to toggle interface.")
end)

-- ============================================================================
-- [ CONFIGURATION - EDIT YOUR LINKS, INSTRUCTIONS, AND CREDITS HERE ]
-- ============================================================================
local CORRECT_KEY = "##12315123141231##"
local KEY_LINK = "https://discord.gg/yJceh2eJ"
local DISCORD_LINK = "https://discord.gg/yJceh2eJ"
local TOGGLE_KEY = Enum.KeyCode.K

local GET_KEY_INSTRUCTIONS = 
    "1. Click the 'Copy Key URL' button on the Verification or discord tab.\n" ..
    "2. Paste the copied link into your web browser.\n" ..
    "3. go into the discord and get the key no verifying required lol.\n" ..
    "4. Copy the key, paste it into Gatekeeper, and press Verify."

local CREDITS_TEXT = 
    "• Main Developer: Ascendx\n" ..
    "• UI Layout Designer: Ascendx\n" ..
    "• Special Thanks: eveybody that actually joins the disc!\n" ..
    "• Visual Style: viperX v1"
-- ============================================================================

-- Main Window Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 500, 0, 280)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5) 
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0) 
MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0) 
MainFrame.BorderColor3 = Color3.fromRGB(25, 25, 25)  
MainFrame.BorderSizePixel = 1
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UIScale = Instance.new("UIScale")
UIScale.Scale = 0 
UIScale.Parent = MainFrame

-- Logo Branding Container
local LogoContainer = Instance.new("Frame")
LogoContainer.Name = "LogoContainer"
LogoContainer.Size = UDim2.new(1, -12, 0, 22)
LogoContainer.Position = UDim2.new(0, 6, 0, 4) 
LogoContainer.BackgroundTransparency = 1
LogoContainer.Parent = MainFrame

-- Purple Decal Asset inside Logo
local TitleDecal = Instance.new("ImageLabel")
TitleDecal.Name = "TitleDecal"
TitleDecal.Size = UDim2.new(0, 20, 0, 20)
TitleDecal.Position = UDim2.new(0, 2, 0.5, -10)
TitleDecal.BackgroundTransparency = 1
TitleDecal.Image = "rbxthumb://type=Asset&id=8652665149&w=150&h=150"
TitleDecal.ImageColor3 = Color3.fromRGB(100, 30, 160) 
TitleDecal.Parent = LogoContainer

-- Logo title label
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "TitleLabel"
TitleLabel.Size = UDim2.new(1, -30, 1, 0)
TitleLabel.Position = UDim2.new(0, 30, 0, 0) 
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "viperX v1 | Key System"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255) 
TitleLabel.TextSize = 16 
TitleLabel.Font = Enum.Font.Fantasy 
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = LogoContainer

local TabsContainer = Instance.new("Frame")
TabsContainer.Size = UDim2.new(1, -12, 0, 22)
TabsContainer.Position = UDim2.new(0, 6, 0, 28) 
TabsContainer.BackgroundTransparency = 1
TabsContainer.Parent = MainFrame

local PagesContainer = Instance.new("Frame")
PagesContainer.Size = UDim2.new(1, -12, 1, -60)
PagesContainer.Position = UDim2.new(0, 6, 0, 54)
PagesContainer.BackgroundTransparency = 1
PagesContainer.Parent = MainFrame

-- Structural section framework creator
local function createSection(parent, titleText)
    local SectionFrame = Instance.new("Frame")
    SectionFrame.Size = UDim2.new(1, 0, 1, 0)
    SectionFrame.BackgroundTransparency = 1
    SectionFrame.Parent = parent

    local HeaderLabel = Instance.new("TextLabel")
    HeaderLabel.Size = UDim2.new(1, 0, 0, 18)
    HeaderLabel.BackgroundTransparency = 1
    HeaderLabel.Text = titleText
    HeaderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    HeaderLabel.TextSize = 14
    HeaderLabel.Font = Enum.Font.SourceSansBold
    HeaderLabel.TextXAlignment = Enum.TextXAlignment.Left
    HeaderLabel.Parent = SectionFrame

    local PurpleLine = Instance.new("Frame")
    PurpleLine.Size = UDim2.new(1, 0, 0, 2)
    PurpleLine.Position = UDim2.new(0, 0, 0, 18)
    PurpleLine.BackgroundColor3 = Color3.fromRGB(100, 30, 160)
    PurpleLine.BorderSizePixel = 0
    PurpleLine.Parent = SectionFrame

    return SectionFrame
end

-- ============================================================================
-- PAGE 1: VERIFICATION VIEW (BROUGHT BACK!)
-- ============================================================================
local VerificationPage = Instance.new("Frame")
VerificationPage.Size = UDim2.new(1, 0, 1, 0)
VerificationPage.BackgroundTransparency = 1
VerificationPage.Visible = true
VerificationPage.Parent = PagesContainer

local LeftColumn = Instance.new("Frame")
LeftColumn.Size = UDim2.new(0.5, -9, 1, 0)
LeftColumn.Position = UDim2.new(0, 0, 0, 0)
LeftColumn.BackgroundTransparency = 1
LeftColumn.Parent = VerificationPage

local RightColumn = LeftColumn:Clone()
RightColumn.Position = UDim2.new(0.5, 9, 0, 0)
RightColumn.Parent = VerificationPage

local AuthSection = createSection(LeftColumn, "Gatekeeper")
local InfoSection = createSection(RightColumn, "Redirection")

local InputLabel = Instance.new("TextLabel")
InputLabel.Size = UDim2.new(1, 0, 0, 20)
InputLabel.Position = UDim2.new(0, 0, 0, 28)
InputLabel.BackgroundTransparency = 1
InputLabel.Text = "Enter Access Token:"
InputLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
InputLabel.TextSize = 13
InputLabel.Font = Enum.Font.SourceSans
InputLabel.TextXAlignment = Enum.TextXAlignment.Left
InputLabel.Parent = AuthSection

local KeyInput = Instance.new("TextBox")
KeyInput.Size = UDim2.new(1, 0, 0, 24)
KeyInput.Position = UDim2.new(0, 0, 0, 50)
KeyInput.BackgroundColor3 = Color3.fromRGB(15, 15, 15) 
KeyInput.BorderColor3 = Color3.fromRGB(35, 35, 35)      
KeyInput.BorderSizePixel = 1
KeyInput.Text = ""
KeyInput.PlaceholderText = " Paste key here..."
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.PlaceholderColor3 = Color3.fromRGB(90, 90, 90)
KeyInput.TextSize = 13
KeyInput.Font = Enum.Font.SourceSans
KeyInput.TextXAlignment = Enum.TextXAlignment.Left
KeyInput.ClearTextOnFocus = false
KeyInput.Parent = AuthSection

local CheckKeyButton = Instance.new("TextButton")
CheckKeyButton.Size = UDim2.new(1, 0, 0, 30)
CheckKeyButton.Position = UDim2.new(0, 0, 0, 84)
CheckKeyButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20) 
CheckKeyButton.BorderColor3 = Color3.fromRGB(40, 40, 40)
CheckKeyButton.BorderSizePixel = 1
CheckKeyButton.Text = "Verify Key"
CheckKeyButton.TextColor3 = Color3.fromRGB(230, 230, 230)
CheckKeyButton.TextSize = 13
CheckKeyButton.Font = Enum.Font.SourceSansBold
CheckKeyButton.AutoButtonColor = false
CheckKeyButton.Parent = AuthSection

local InfoLabel = Instance.new("TextLabel")
InfoLabel.Size = UDim2.new(1, 0, 0, 40)
InfoLabel.Position = UDim2.new(0, 0, 0, 28)
InfoLabel.BackgroundTransparency = 1
InfoLabel.Text = "If you do not have a key, click the button below to copy the direct link."
InfoLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
InfoLabel.TextSize = 13
InfoLabel.Font = Enum.Font.SourceSans
InfoLabel.TextWrapped = true
InfoLabel.TextXAlignment = Enum.TextXAlignment.Left
InfoLabel.Parent = InfoSection

local GetKeyButton = Instance.new("TextButton")
GetKeyButton.Size = UDim2.new(1, 0, 0, 30)
GetKeyButton.Position = UDim2.new(0, 0, 0, 84)
GetKeyButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20) 
GetKeyButton.BorderColor3 = Color3.fromRGB(40, 40, 40)
GetKeyButton.BorderSizePixel = 1
GetKeyButton.Text = "Copy Key URL"
GetKeyButton.TextColor3 = Color3.fromRGB(230, 230, 230)
GetKeyButton.TextSize = 13
GetKeyButton.Font = Enum.Font.SourceSansBold
GetKeyButton.AutoButtonColor = false
GetKeyButton.Parent = InfoSection

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, 0, 0, 20)
StatusLabel.Position = UDim2.new(0, 0, 0, 130)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "System Status: Awaiting Input"
StatusLabel.TextColor3 = Color3.fromRGB(140, 140, 140)
StatusLabel.TextSize = 12
StatusLabel.Font = Enum.Font.SourceSansItalic
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
StatusLabel.Parent = InfoSection

-- ============================================================================
-- PAGE 2: GET KEY INSTRUCTIONS VIEW
-- ============================================================================
local GetKeyPage = Instance.new("Frame")
GetKeyPage.Size = UDim2.new(1, 0, 1, 0)
GetKeyPage.BackgroundTransparency = 1
GetKeyPage.Visible = false
GetKeyPage.Parent = PagesContainer

local InstructionsSection = createSection(GetKeyPage, "How To Obtain A Key")

local InstructionsTextLabel = Instance.new("TextLabel")
InstructionsTextLabel.Size = UDim2.new(1, 0, 1, -30)
InstructionsTextLabel.Position = UDim2.new(0, 0, 0, 30)
InstructionsTextLabel.BackgroundTransparency = 1
InstructionsTextLabel.Text = GET_KEY_INSTRUCTIONS
InstructionsTextLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
InstructionsTextLabel.TextSize = 13
InstructionsTextLabel.Font = Enum.Font.SourceSans
InstructionsTextLabel.TextWrapped = true
InstructionsTextLabel.TextXAlignment = Enum.TextXAlignment.Left
InstructionsTextLabel.TextYAlignment = Enum.TextYAlignment.Top
InstructionsTextLabel.Parent = InstructionsSection

-- ============================================================================
-- PAGE 3: CREDITS VIEW
-- ============================================================================
local CreditsPage = Instance.new("Frame")
CreditsPage.Size = UDim2.new(1, 0, 1, 0)
CreditsPage.BackgroundTransparency = 1
CreditsPage.Visible = false
CreditsPage.Parent = PagesContainer

local DevelopmentSection = createSection(CreditsPage, "Project Contributors")

local CreditsTextLabel = Instance.new("TextLabel")
CreditsTextLabel.Size = UDim2.new(1, 0, 1, -30)
CreditsTextLabel.Position = UDim2.new(0, 0, 0, 30)
CreditsTextLabel.BackgroundTransparency = 1
CreditsTextLabel.Text = CREDITS_TEXT
CreditsTextLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
CreditsTextLabel.TextSize = 13
CreditsTextLabel.Font = Enum.Font.SourceSans
CreditsTextLabel.TextWrapped = true
CreditsTextLabel.TextXAlignment = Enum.TextXAlignment.Left
CreditsTextLabel.TextYAlignment = Enum.TextYAlignment.Top
CreditsTextLabel.Parent = DevelopmentSection


--- *** INTERACTIVE TABS CONNECTOR *** ---
local tabNames = {"Verification", "Get Key", "Discord", "Credits"}
local tabWidth = 1 / #tabNames
local instantiatedTabs = {}

local function switchPage(chosenTabName)
    if chosenTabName == "Discord" then
        if Clipboard then
            Clipboard(DISCORD_LINK)
            createBadgeNotification("Discord Invite", "Community invite link copied to your clipboard!")
        else
            createBadgeNotification("Error", "Your executor doesn't support clipboard copying.")
        end
        return
    end

    VerificationPage.Visible = (chosenTabName == "Verification")
    GetKeyPage.Visible = (chosenTabName == "Get Key")
    CreditsPage.Visible = (chosenTabName == "Credits")

    for name, textLabel in pairs(instantiatedTabs) do
        if name == chosenTabName then
            textLabel.TextColor3 = Color3.fromRGB(255, 255, 255) 
        else
            textLabel.TextColor3 = Color3.fromRGB(170, 170, 170) 
        end
    end
end

for i, name in ipairs(tabNames) do
    local TabButton = Instance.new("TextButton")
    TabButton.Name = name .. "Tab"
    TabButton.Size = UDim2.new(tabWidth, -2, 1, 0)
    TabButton.Position = UDim2.new((i - 1) * tabWidth, 1, 0, 0)
    TabButton.BackgroundColor3 = Color3.fromRGB(15, 15, 15) 
    TabButton.BorderColor3 = Color3.fromRGB(35, 35, 35)
    TabButton.BorderSizePixel = 1
    TabButton.Text = ""
    TabButton.AutoButtonColor = false
    TabButton.Parent = TabsContainer

    local TabText = Instance.new("TextLabel")
    TabText.Size = UDim2.new(1, 0, 1, 0)
    TabText.BackgroundTransparency = 1
    TabText.Text = name
    TabText.TextColor3 = (i == 1) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(170, 170, 170)
    TabText.TextSize = 13
    TabText.Font = Enum.Font.SourceSans
    TabText.Parent = TabButton

    instantiatedTabs[name] = TabText

    TabButton.MouseEnter:Connect(function()
        TabButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25) 
        TabButton.BorderColor3 = Color3.fromRGB(100, 30, 160) 
    end)
    TabButton.MouseLeave:Connect(function()
        TabButton.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
        TabButton.BorderColor3 = Color3.fromRGB(35, 35, 35)
    end)

    TabButton.MouseButton1Click:Connect(function()
        switchPage(name)
    end)
end

local function applyExactHoverStyle(btn)
    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30) 
        btn.BorderColor3 = Color3.fromRGB(100, 30, 160)   
    end)
    btn.MouseLeave:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        btn.BorderColor3 = Color3.fromRGB(40, 40, 40)
    end)
end
applyExactHoverStyle(CheckKeyButton)
applyExactHoverStyle(GetKeyButton)


--- *** WINDOW TOGGLE STATE MANAGEMENT *** ---
local uiIsOpen = false
local animationDebounce = false

local function toggleUI()
    if animationDebounce then return end
    animationDebounce = true
    
    if uiIsOpen then
        local exitTween = TweenService:Create(UIScale, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Scale = 0})
        exitTween:Play()
        exitTween.Completed:Wait()
        MainFrame.Visible = false
        uiIsOpen = false
    else
        MainFrame.Visible = true
        local entryTween = TweenService:Create(UIScale, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Scale = 1})
        entryTween:Play()
        entryTween.Completed:Wait()
        uiIsOpen = true
    end
    animationDebounce = false
end

local inputConnection
inputConnection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if input.KeyCode == TOGGLE_KEY and not UserInputService:GetFocusedTextBox() then
        toggleUI()
    end
end)


--- *** RUNTIME INTRO SEQUENCE *** ---
task.wait(0.2)
toggleUI()


--- *** UTILITY PRESS BUTTON FUNCTIONS *** ---

GetKeyButton.MouseButton1Click:Connect(function()
    if Clipboard then
        Clipboard(KEY_LINK)
        StatusLabel.Text = "System Status: Link Copied!"
        StatusLabel.TextColor3 = Color3.fromRGB(100, 30, 160) 
        createBadgeNotification("Key System", "Key bypass URL copied to your clipboard successfully!")
    else
        StatusLabel.Text = "System Status: Clipboard Error"
        StatusLabel.TextColor3 = Color3.fromRGB(200, 80, 80)
    end
end)

-- Exact validation verification trigger
CheckKeyButton.MouseButton1Click:Connect(function()
    local cleanInput = KeyInput.Text:gsub("%s+", "")
    
    if cleanInput == CORRECT_KEY then
        StatusLabel.Text = "System Status: Access Granted!"
        StatusLabel.TextColor3 = Color3.fromRGB(80, 200, 80)
        
        if inputConnection then inputConnection:Disconnect() end
        task.wait(0.5)
        
        local clearTween = TweenService:Create(UIScale, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Scale = 0})
        clearTween:Play()
        clearTween.Completed:Wait()
        
        ScreenGui:Destroy()
        
        print("Key Verification Passed. Launching Main Menu...")
        
        -- --------------------------------------------------------------------
        -- >>> DROP YOUR MAIN CHEAT MENU SCRIPT DIRECTLY BELOW THIS LINE <<<
        -- --------------------------------------------------------------------
-- --- ANTI-DUPLICATE / CLEANUP SYSTEM ---
if getgenv().ViperX_Cleanup then
    pcall(getgenv().ViperX_Cleanup)
end

local Player = game.Players.LocalPlayer
local Camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local MarketplaceService = game:GetService("MarketplaceService")
local CoreGui = game:GetService("CoreGui")

-- Fetch current game name dynamically
local GameName = "Undetchecked"
pcall(function()
    GameName = MarketplaceService:GetProductInfo(game.PlaceId).Name
end)

-- Track connections for clean removal on re-execution
local Connections = {}

-- --- GLOBAL STATES ---
local States = {
    aimbot_toggle = false,
    aimbot_mode = false, 
    aim_part = false,    
    aim_smoothness = 10, 
    fov_circle_color = false, 
    fov_circle_size = 150,
    ESP = false,
    esp_boxes = false,
    chams = false, 
    tracers = false,
    health_bars = false,
    show_fov_circle = false,
    toggle_fly = false,
    noclip = false,
    auto_sprint = false,
    inf_jump = false,
    auto_chat = false,       
    chat_delay = 5,          
    chat_msg1 = "GG!",       
    chat_msg2 = "Nice shot!",
    chat_msg3 = "Rivals Pro",
    fakelag = false,          
    fakelag_limit = 15,       
    FlySpeed = 50,
    WalkSpeed = 16,
    AutoSprintSpeed = 60
}

-- Drawing FOV Circle
local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 2
FOVCircle.Radius = States.fov_circle_size
FOVCircle.Visible = false

-- Tracer Drawing Cache
local TracerCache = {}

-- Define the Cleanup Function for the Next Run
getgenv().ViperX_Cleanup = function()
    -- Disconnect all active loops and events
    for _, conn in ipairs(Connections) do
        if conn.Connected then conn:Disconnect() end
    end
    
    -- Clean up Drawing library objects
    if FOVCircle then pcall(function() FOVCircle:Remove() end) end
    for _, line in pairs(TracerCache) do
        if line then pcall(function() line:Remove() end) end
    end
    
    -- Clean up physical objects left on characters
    for _, p in pairs(game.Players:GetPlayers()) do
        if p.Character then
            if p.Character:FindFirstChild("ViperXChams") then p.Character.ViperXChams:Destroy() end
            if p.Character:FindFirstChild("ViperXBox") then p.Character.ViperXBox:Destroy() end
            if p.Character:FindFirstChild("ViperXHealth") then p.Character.ViperXHealth:Destroy() end
            if p.Character:FindFirstChild("HumanoidRootPart") then p.Character.HumanoidRootPart.Anchored = false end
        end
    end
    
    -- Destroy old UI from CoreGui or PlayerGui
    local oldGui = CoreGui:FindFirstChild("ViperX") or Player:WaitForChild("PlayerGui"):FindFirstChild("ViperX")
    if oldGui then oldGui:Destroy() end
end

-- --- UI SETUP (TOP-LAYER INJECTION) ---
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ViperX"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.DisplayOrder = 2147483647 -- Pushes frame past the Esc Menu, Chat, and Leaderboard

-- Safely parent to CoreGui to allow top-layer rendering override
local parentSuccess, _ = pcall(function()
    ScreenGui.Parent = CoreGui
end)
if not parentSuccess then
    ScreenGui.Parent = Player:WaitForChild("PlayerGui") -- Fallback if environment restricts CoreGui
end

local DARK_PURPLE = Color3.fromRGB(90, 0, 160)
local BG_DARK = Color3.fromRGB(0, 0, 0) -- Pitch Black
local PANEL_DARK = Color3.fromRGB(15, 15, 15) 
local TEXT_COLOR = Color3.fromRGB(220, 220, 220)

-- --- PHYSICAL SLIDE BADGE NOTIFICATION SYSTEM (STACKING) ---
local NotifContainer = Instance.new("Frame", ScreenGui)
NotifContainer.Size = UDim2.new(0, 320, 1, -40)
NotifContainer.Position = UDim2.new(1, -340, 0, 20)
NotifContainer.BackgroundTransparency = 1

local NotifLayout = Instance.new("UIListLayout", NotifContainer)
NotifLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
NotifLayout.Padding = UDim.new(0, 8)

local function ShowNotification(title, message)
    local Holder = Instance.new("Frame", NotifContainer)
    Holder.Name = "NotificationHolder"
    Holder.BackgroundTransparency = 1
    Holder.BorderSizePixel = 0
    Holder.ClipsDescendants = true
    Holder.Size = UDim2.new(1, 0, 0, 75)

    local BadgeNotify = Instance.new("Frame", Holder)
    BadgeNotify.Name = "BadgeNotification"
    BadgeNotify.Size = UDim2.new(1, 0, 0, 75)
    BadgeNotify.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    BadgeNotify.BackgroundTransparency = 0.15
    BadgeNotify.BorderSizePixel = 0
    BadgeNotify.Position = UDim2.new(1, 10, 0, 0)

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = BadgeNotify

    local ImageContainer = Instance.new("Frame", BadgeNotify)
    ImageContainer.Size = UDim2.new(0, 55, 0, 55)
    ImageContainer.Position = UDim2.new(0, 10, 0.5, -27)
    ImageContainer.BackgroundColor3 = Color3.fromRGB(25, 25, 25)

    local UIContainerCorner = Instance.new("UICorner")
    UIContainerCorner.CornerRadius = UDim.new(1, 0)
    UIContainerCorner.Parent = ImageContainer

    local BadgeIcon = Instance.new("ImageLabel", ImageContainer)
    BadgeIcon.Size = UDim2.new(0, 40, 0, 40) 
    BadgeIcon.Position = UDim2.new(0.5, -20, 0.5, -20)
    BadgeIcon.BackgroundTransparency = 1
    BadgeIcon.Image = "rbxthumb://type=Asset&id=8652665149&w=150&h=150" 
    BadgeIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)

    local NotificationHeader = Instance.new("TextLabel", BadgeNotify)
    NotificationHeader.Size = UDim2.new(1, -80, 0, 18)
    NotificationHeader.Position = UDim2.new(0, 75, 0, 14)
    NotificationHeader.BackgroundTransparency = 1
    NotificationHeader.Text = title:upper()
    NotificationHeader.TextColor3 = Color3.fromRGB(175, 175, 175)
    NotificationHeader.TextSize = 11
    NotificationHeader.Font = Enum.Font.Fantasy
    NotificationHeader.TextXAlignment = Enum.TextXAlignment.Left

    local NotificationBody = Instance.new("TextLabel", BadgeNotify)
    NotificationBody.Size = UDim2.new(1, -80, 0, 32)
    NotificationBody.Position = UDim2.new(0, 75, 0, 30)
    NotificationBody.BackgroundTransparency = 1
    NotificationBody.Text = message
    NotificationBody.TextColor3 = Color3.fromRGB(255, 255, 255)
    NotificationBody.TextSize = 13
    NotificationBody.Font = Enum.Font.Fantasy
    NotificationBody.TextWrapped = true
    NotificationBody.TextXAlignment = Enum.TextXAlignment.Left
    NotificationBody.TextYAlignment = Enum.TextYAlignment.Top

    TweenService:Create(BadgeNotify, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Position = UDim2.new(0, 0, 0, 0)
    }):Play()

    task.delay(4, function()
        if Holder and Holder.Parent then
            local slideOut = TweenService:Create(BadgeNotify, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                Position = UDim2.new(1, 20, 0, 0)
            })
            slideOut:Play()
            slideOut.Completed:Connect(function()
                Holder:Destroy()
            end)
        end
    end)
end

-- --- MAIN MENU FRAME ---
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.BackgroundColor3 = BG_DARK
MainFrame.BorderColor3 = Color3.fromRGB(45, 45, 45)
MainFrame.BorderSizePixel = 1
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true

local TARGET_SIZE = UDim2.new(0, 560, 0, 320)
local TARGET_POS = UDim2.new(0.5, -280, 0.5, -160)

MainFrame.Size = UDim2.new(0, 0, 0, 0)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Visible = true

local TitleBar = Instance.new("TextLabel", MainFrame)
TitleBar.Size = UDim2.new(1, -10, 0, 25)
TitleBar.Position = UDim2.new(0, 10, 0, 0)
TitleBar.Text = "ViperX | " .. GameName
TitleBar.TextColor3 = TEXT_COLOR
TitleBar.TextSize = 14
TitleBar.Font = Enum.Font.Fantasy
TitleBar.TextXAlignment = Enum.TextXAlignment.Left
TitleBar.BackgroundTransparency = 1

local TabButtons = Instance.new("Frame", MainFrame)
TabButtons.Size = UDim2.new(1, -20, 0, 22)
TabButtons.Position = UDim2.new(0, 10, 0, 25)
TabButtons.BackgroundTransparency = 1
local TabLayout = Instance.new("UIListLayout", TabButtons)
TabLayout.FillDirection = Enum.FillDirection.Horizontal
TabLayout.Padding = UDim.new(0, 2)

local PageContainer = Instance.new("Frame", MainFrame)
PageContainer.Size = UDim2.new(1, -20, 1, -55)
PageContainer.Position = UDim2.new(0, 10, 0, 50)
PageContainer.BackgroundTransparency = 1

local Pages = {}

-- --- OPEN / CLOSE INTERFACE INTERRUPT (K KEY) ---
local IsOpen = true
local ToggleTweening = false

local function ToggleMenu()
    if ToggleTweening then return end
    ToggleTweening = true
    IsOpen = not IsOpen
    
    if IsOpen then
        MainFrame.Visible = true
        ShowNotification("ViperX System", "Interface expanded and visible.")
        local openTween = TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
            Size = TARGET_SIZE,
            Position = TARGET_POS
        })
        openTween:Play()
        openTween.Completed:Wait()
    else
        ShowNotification("ViperX System", "Interface minimized.")
        local closeTween = TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0)
        })
        closeTween:Play()
        closeTween.Completed:Wait()
        MainFrame.Visible = false
    end
    ToggleTweening = false
end

table.insert(Connections, UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.K then
        ToggleMenu()
    end
end))

-- --- LAYOUT GENERATORS ---
local function CreateTab(name, isDefault)
    local Btn = Instance.new("TextButton", TabButtons)
    Btn.Size = UDim2.new(0, 132, 1, 0)
    Btn.BackgroundColor3 = PANEL_DARK
    Btn.BorderColor3 = Color3.fromRGB(50, 50, 50)
    Btn.Text = name
    Btn.TextColor3 = TEXT_COLOR
    Btn.Font = Enum.Font.Fantasy
    Btn.TextSize = 13

    local Page = Instance.new("Frame", PageContainer)
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.Visible = isDefault
    
    local LeftCol = Instance.new("ScrollingFrame", Page)
    LeftCol.Name = "LeftCol"
    LeftCol.Size = UDim2.new(0.49, 0, 1, 0)
    LeftCol.BackgroundTransparency = 1
    LeftCol.ScrollBarThickness = 0
    local L_List = Instance.new("UIListLayout", LeftCol)
    L_List.Padding = UDim.new(0, 6)

    local RightCol = Instance.new("ScrollingFrame", Page)
    RightCol.Name = "RightCol"
    RightCol.Size = UDim2.new(0.49, 0, 1, 0)
    RightCol.Position = UDim2.new(0.51, 0, 0, 0)
    RightCol.BackgroundTransparency = 1
    RightCol.ScrollBarThickness = 0
    local R_List = Instance.new("UIListLayout", RightCol)
    R_List.Padding = UDim.new(0, 6)
    
    Pages[name] = Page
    
    Btn.MouseButton1Click:Connect(function()
        for _, p in pairs(Pages) do p.Visible = false end
        Page.Visible = true
    end)
    return Page
end

local function CreateSection(parent, title)
    local SecFrame = Instance.new("Frame", parent)
    SecFrame.Size = UDim2.new(1, 0, 0, 20)
    SecFrame.AutomaticSize = Enum.AutomaticSize.Y
    SecFrame.BackgroundTransparency = 1
    
    local Label = Instance.new("TextLabel", SecFrame)
    Label.Size = UDim2.new(1, 0, 0, 16)
    Label.Text = title
    Label.TextColor3 = DARK_PURPLE
    Label.TextSize = 13
    Label.Font = Enum.Font.Fantasy
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.BackgroundTransparency = 1
    
    local Divider = Instance.new("Frame", SecFrame)
    Divider.Size = UDim2.new(1, 0, 0, 1)
    Divider.Position = UDim2.new(0, 0, 0, 16)
    Divider.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    Divider.BorderSizePixel = 0

    local Content = Instance.new("Frame", SecFrame)
    Content.Name = "Container"
    Content.Size = UDim2.new(1, 0, 0, 0)
    Content.Position = UDim2.new(0, 0, 0, 20)
    Content.AutomaticSize = Enum.AutomaticSize.Y
    Content.BackgroundTransparency = 1
    local List = Instance.new("UIListLayout", Content)
    List.Padding = UDim.new(0, 4)
    
    return Content
end

local function AddToggle(parent, labelText, stateKey, subtext)
    local Row = Instance.new("Frame", parent)
    Row.Size = UDim2.new(1, 0, 0, 18)
    Row.BackgroundTransparency = 1

    local Box = Instance.new("TextButton", Row)
    Box.Size = UDim2.new(0, 10, 0, 10)
    Box.Position = UDim2.new(0, 2, 0.2, 0)
    Box.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Box.BorderColor3 = Color3.fromRGB(60, 60, 60)
    Box.Text = ""

    local Label = Instance.new("TextButton", Row)
    Label.Size = UDim2.new(0, 140, 1, 0)
    Label.Position = UDim2.new(0, 18, 0, 0)
    Label.Text = labelText
    Label.TextColor3 = TEXT_COLOR
    Label.Font = Enum.Font.Fantasy
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.BackgroundTransparency = 1

    if subtext then
        local Sub = Instance.new("TextLabel", Row)
        Sub.Size = UDim2.new(1, -12, 1, 0)
        Sub.Text = subtext
        Sub.TextColor3 = Color3.fromRGB(130, 130, 130)
        Sub.Font = Enum.Font.Fantasy
        Sub.TextSize = 12
        Sub.TextXAlignment = Enum.TextXAlignment.Right
        Sub.BackgroundTransparency = 1
    end

    local function Click()
        States[stateKey] = not States[stateKey]
        Box.BackgroundColor3 = States[stateKey] and DARK_PURPLE or Color3.fromRGB(20, 20, 20)
        
        if stateKey == "aimbot_mode" then
            local dynamicMode = States[stateKey] and "Smooth" or "Snap"
            ShowNotification("Aimbot Settings", "Aimbot Mode set to " .. dynamicMode .. ".")
        elseif stateKey == "aim_part" then
            local dynamicPart = States[stateKey] and "Torso" or "Head"
            ShowNotification("Target Settings", "Aim Part set to " .. dynamicPart .. ".")
        else
            local status = States[stateKey] and "Enabled" or "Disabled"
            ShowNotification("Module Changed", labelText .. " is now " .. status .. ".")
        end
    end

    Box.MouseButton1Click:Connect(Click)
    Label.MouseButton1Click:Connect(Click)
end

local function AddSlider(parent, text, stateKey, min, max)
    local SliderWrapper = Instance.new("Frame", parent)
    SliderWrapper.Size = UDim2.new(1, 0, 0, 24)
    SliderWrapper.BackgroundTransparency = 1

    local Label = Instance.new("TextLabel", SliderWrapper)
    Label.Size = UDim2.new(1, 0, 0, 14)
    Label.Text = text
    Label.TextColor3 = TEXT_COLOR
    Label.Font = Enum.Font.Fantasy
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.BackgroundTransparency = 1

    local ValueLabel = Instance.new("TextLabel", Label)
    ValueLabel.Size = UDim2.new(1, -5, 1, 0)
    ValueLabel.Text = tostring(math.round(States[stateKey])) .. "/" .. tostring(max)
    ValueLabel.TextColor3 = TEXT_COLOR
    ValueLabel.Font = Enum.Font.Fantasy
    ValueLabel.TextSize = 12
    ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
    ValueLabel.BackgroundTransparency = 1

    local SliderBG = Instance.new("Frame", SliderWrapper)
    SliderBG.Size = UDim2.new(1, -10, 0, 4)
    SliderBG.Position = UDim2.new(0, 0, 0, 16)
    SliderBG.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    SliderBG.BorderSizePixel = 0

    local Fill = Instance.new("Frame", SliderBG)
    Fill.Size = UDim2.new((States[stateKey] - min) / (max - min), 0, 1, 0)
    Fill.BackgroundColor3 = DARK_PURPLE
    Fill.BorderSizePixel = 0

    local SliderBtn = Instance.new("TextButton", SliderBG)
    SliderBtn.Size = UDim2.new(1, 0, 1, 0)
    SliderBtn.BackgroundTransparency = 1
    SliderBtn.Text = ""

    local function UpdateValue(input)
        local percent = math.clamp((input.Position.X - SliderBG.AbsolutePosition.X) / SliderBG.AbsoluteSize.X, 0, 1)
        Fill.Size = UDim2.new(percent, 0, 1, 0)
        local val = math.round(min + (max - min) * percent)
        States[stateKey] = val
        ValueLabel.Text = tostring(val) .. "/" .. tostring(max)
    end

    SliderBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local moveConn
            local endConn 
            
            moveConn = UserInputService.InputChanged:Connect(function(moveInput)
                if moveInput.UserInputType == Enum.UserInputType.MouseMovement then
                    UpdateValue(moveInput)
                end
            end)
            
            endConn = UserInputService.InputEnded:Connect(function(endInput)
                if endInput.UserInputType == Enum.UserInputType.MouseButton1 then
                    if moveConn then moveConn:Disconnect() end
                    if endConn then endConn:Disconnect() end 
                    
                    ShowNotification("Value Adjusted", text .. " configured to " .. tostring(States[stateKey]) .. ".")
                end
            end)
        end
    end)
end

local function AddTextBox(parent, placeholder, stateKey)
    local BoxWrapper = Instance.new("Frame", parent)
    BoxWrapper.Size = UDim2.new(1, 0, 0, 22)
    BoxWrapper.BackgroundTransparency = 1

    local TextBox = Instance.new("TextBox", BoxWrapper)
    TextBox.Size = UDim2.new(1, -10, 1, 0)
    TextBox.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    TextBox.BorderColor3 = Color3.fromRGB(45, 45, 45)
    TextBox.PlaceholderText = placeholder
    TextBox.Text = States[stateKey]
    TextBox.TextColor3 = TEXT_COLOR
    TextBox.PlaceholderColor3 = Color3.fromRGB(100, 100, 100)
    TextBox.Font = Enum.Font.Fantasy
    TextBox.TextSize = 12
    TextBox.ClearTextOnFocus = false

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 4)
    UICorner.Parent = TextBox

    TextBox.FocusLost:Connect(function()
        States[stateKey] = TextBox.Text
        ShowNotification("Config Updated", "Saved auto-chat text line.")
    end)
end

-- --- POPULATE PAGES ---
local CombatPage = CreateTab("Combat", true)
local VisualsPage = CreateTab("Visuals", false)
local MovementPage = CreateTab("Movement", false)
local MiscPage = CreateTab("Misc", false)

-- Combat Page
local AimbotSec = CreateSection(CombatPage.LeftCol, "Aimbot Settings")
AddToggle(AimbotSec, "Aimbot Toggle", "aimbot_toggle")
AddToggle(AimbotSec, "Aimbot Mode", "aimbot_mode", "Smooth / Snap")
AddToggle(AimbotSec, "Aim Part", "aim_part", "Torso / Head")

local TargetSec = CreateSection(CombatPage.RightCol, "Target Customization")
AddSlider(TargetSec, "Smoothness Speed", "aim_smoothness", 1, 100)
AddSlider(TargetSec, "FOV Circle Size", "fov_circle_size", 10, 800)

-- Visuals Page
local EspSec = CreateSection(VisualsPage.LeftCol, "ESP System")
AddToggle(EspSec, "ESP Master", "ESP")
AddToggle(EspSec, "ESP Boxes", "esp_boxes")
AddToggle(EspSec, "Chams", "chams") 
AddToggle(EspSec, "Tracers", "tracers") 
AddToggle(EspSec, "Health Bars", "health_bars")

local FovSec = CreateSection(VisualsPage.RightCol, "FOV Configuration")
AddToggle(FovSec, "Show FOV Circle", "show_fov_circle")
AddToggle(FovSec, "FOV Circle Color", "fov_circle_color", "White / Red")

-- Movement Page
local MoveSec = CreateSection(MovementPage.LeftCol, "Locomotion")
AddToggle(MoveSec, "Toggle Fly", "toggle_fly")
AddToggle(MoveSec, "Noclip", "noclip")
AddToggle(MoveSec, "Auto Sprint", "auto_sprint")
AddToggle(MoveSec, "Infinite Jump", "inf_jump")

-- Speed Limits Section (Sliders)
local SpeedSec = CreateSection(MovementPage.RightCol, "Speed Limits")
AddSlider(SpeedSec, "Fly Speed", "FlySpeed", 10, 250)
AddSlider(SpeedSec, "Auto Sprint Speed", "AutoSprintSpeed", 16, 250)

-- Misc Page
local ChatSec = CreateSection(MiscPage.LeftCol, "Auto Chat Spammer")
AddToggle(ChatSec, "Enable Auto Chat", "auto_chat")
AddSlider(ChatSec, "Chat Interval (s)", "chat_delay", 1, 20)
AddTextBox(ChatSec, "Phrase 1...", "chat_msg1")
AddTextBox(ChatSec, "Phrase 2...", "chat_msg2")
AddTextBox(ChatSec, "Phrase 3...", "chat_msg3")

local NetSec = CreateSection(MiscPage.LeftCol, "Network Manipulation")
AddToggle(NetSec, "Fake Lag", "fakelag")
AddSlider(NetSec, "Lag Limit Factor", "fakelag_limit", 1, 30)

-- --- MISC PREVIEW CONFIGURATION ---
local Viewport = Instance.new("ViewportFrame", MiscPage.RightCol)
Viewport.Size = UDim2.new(1, -10, 0, 140)
Viewport.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Viewport.BorderColor3 = DARK_PURPLE

local vCam = Instance.new("Camera")
vCam.FieldOfView = 50
Viewport.CurrentCamera = vCam
vCam.Parent = Viewport

local currentClone = nil
local rotationAngle = 0

local function updatePreview()
    if currentClone then currentClone:Destroy() end
    
    local char = Player.Character
    if not char then return end
    
    char.Archivable = true
    local clone = char:Clone()
    char.Archivable = false
    
    for _, v in pairs(clone:GetDescendants()) do
        if v:IsA("LuaSourceContainer") or v:IsA("Script") or v:IsA("LocalScript") then
            v:Destroy()
        end
    end
    
    local hrp = clone:FindFirstChild("HumanoidRootPart") or clone:FindFirstChildWhichIsA("BasePart")
    if hrp then
        clone.PrimaryPart = hrp
        hrp.Anchored = true
    end
    
    clone:PivotTo(CFrame.new(0, -1.5, 0)) 
    clone.Parent = Viewport
    currentClone = clone
    
    vCam.CFrame = CFrame.new(Vector3.new(0, 0, 4.5), Vector3.new(0, -0.2, 0))
end

local function connectCharListeners(character)
    if not character then return end
    table.insert(Connections, character.ChildAdded:Connect(function()
        task.wait(0.2) 
        updatePreview()
    end))
    table.insert(Connections, character.ChildRemoved:Connect(function()
        task.wait(0.1)
        updatePreview()
    end))
end

task.spawn(function()
    updatePreview()
    if Player.Character then connectCharListeners(Player.Character) end
    
    table.insert(Connections, Player.CharacterAdded:Connect(function(newChar)
        task.wait(0.5)
        updatePreview()
        connectCharListeners(newChar)
    end))
end)

table.insert(Connections, RunService.RenderStepped:Connect(function(deltaTime)
    if currentClone then
        rotationAngle = (rotationAngle + (55 * deltaTime)) % 360 
        currentClone:PivotTo(CFrame.new(0, -1.5, 0) * CFrame.Angles(0, math.rad(rotationAngle), 0))
    end
end))

table.insert(Connections, game.Players.PlayerRemoving:Connect(function(p)
    if TracerCache[p] then
        pcall(function() TracerCache[p]:Remove() end)
        TracerCache[p] = nil
    end
end))

-- --- INITIALIZATION EXPANSION ANIMATION ---
task.spawn(function()
    task.wait(0.1)
    ShowNotification("ViperX Active", "UI Hub loaded successfully.")
    
    local startTween = TweenService:Create(MainFrame, TweenInfo.new(0.6, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        Size = TARGET_SIZE,
        Position = TARGET_POS
    })
    startTween:Play()
end)

-- --- LOGIC RUNNERS ---

table.insert(Connections, UserInputService.JumpRequest:Connect(function()
    if States.inf_jump and Player.Character then
        local Humanoid = Player.Character:FindFirstChildOfClass("Humanoid")
        if Humanoid then
            Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end))

task.spawn(function()
    while ScreenGui and ScreenGui.Parent do
        if States.auto_chat then
            local validPhrases = {}
            if States.chat_msg1 and States.chat_msg1 ~= "" then table.insert(validPhrases, States.chat_msg1) end
            if States.chat_msg2 and States.chat_msg2 ~= "" then table.insert(validPhrases, States.chat_msg2) end
            if States.chat_msg3 and States.chat_msg3 ~= "" then table.insert(validPhrases, States.chat_msg3) end
            
            if #validPhrases > 0 then
                local chosenMessage = validPhrases[math.random(1, #validPhrases)]
                
                pcall(function()
                    local TextChatService = game:GetService("TextChatService")
                    if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
                        local activeChannel = TextChatService:FindFirstChild("TextChannels") and TextChatService.TextChannels:FindFirstChild("RBXGeneral")
                        if activeChannel then activeChannel:SendAsync(chosenMessage) end
                    else
                        local legacyRemote = game:GetService("ReplicatedStorage"):FindFirstChild("DefaultChatSystemChatEvents") and game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents:FindFirstChild("SayMessageRequest")
                        if legacyRemote then legacyRemote:FireServer(chosenMessage, "All") end
                    end
                end)
            end
            task.wait(States.chat_delay)
        else
            task.wait(0.5)
        end
    end
end)

task.spawn(function()
    while ScreenGui and ScreenGui.Parent do
        if States.fakelag and Player.Character and not States.toggle_fly then
            local Root = Player.Character:FindFirstChild("HumanoidRootPart")
            if Root then
                Root.Anchored = true
                task.wait(math.clamp(States.fakelag_limit / 150, 0.01, 0.4))
                Root.Anchored = false
            end
            task.wait(0.04)
        else
            task.wait(0.5)
        end
    end
end)

-- ESP Loop
table.insert(Connections, RunService.RenderStepped:Connect(function()
    if States.ESP then
        for _, p in pairs(game.Players:GetPlayers()) do
            if p ~= Player and p.Character then
                
                local high = p.Character:FindFirstChild("ViperXChams")
                if States.chams then
                    if not high then
                        high = Instance.new("Highlight")
                        high.Name = "ViperXChams"
                        high.Parent = p.Character
                    end
                    high.FillColor = DARK_PURPLE
                    high.FillTransparency = 0.4
                    high.OutlineColor = DARK_PURPLE
                    high.Enabled = true
                elseif high then
                    high:Destroy()
                end

                local box = p.Character:FindFirstChild("ViperXBox")
                if States.esp_boxes then
                    if not box then
                        box = Instance.new("SelectionBox")
                        box.Name = "ViperXBox"
                        box.Color3 = DARK_PURPLE
                        box.SurfaceTransparency = 1
                        box.LineThickness = 0.02
                        box.Parent = p.Character
                    end
                    box.Adornee = p.Character
                    box.Visible = true
                elseif box then
                    box:Destroy()
                end

                if States.tracers and p.Character:FindFirstChild("HumanoidRootPart") then
                    local line = TracerCache[p]
                    if not line then
                        line = Drawing.new("Line")
                        line.Thickness = 1
                        line.Color = DARK_PURPLE
                        TracerCache[p] = line
                    end
                    
                    local pos, onScreen = Camera:WorldToViewportPoint(p.Character.HumanoidRootPart.Position)
                    if onScreen then
                        line.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                        line.To = Vector2.new(pos.X, pos.Y)
                        line.Visible = true
                    else
                        line.Visible = false
                    end
                else
                    if TracerCache[p] then
                        TracerCache[p].Visible = false
                    end
                end

                local healthGui = p.Character:FindFirstChild("ViperXHealth")
                if States.health_bars and p.Character:FindFirstChild("Humanoid") and p.Character:FindFirstChild("HumanoidRootPart") then
                    if not healthGui then
                        healthGui = Instance.new("BillboardGui", p.Character)
                        healthGui.Name = "ViperXHealth"
                        healthGui.Size = UDim2.new(4, 0, 0.5, 0)
                        healthGui.AlwaysOnTop = true
                        healthGui.Adornee = p.Character:FindFirstChild("HumanoidRootPart")
                        local frame = Instance.new("Frame", healthGui)
                        frame.Size = UDim2.new(1, 0, 1, 0)
                        frame.BackgroundColor3 = Color3.new(0, 1, 0)
                    end
                    if p.Character.Humanoid.MaxHealth > 0 then
                        healthGui.Frame.Size = UDim2.new(p.Character.Humanoid.Health / p.Character.Humanoid.MaxHealth, 0, 1, 0)
                    end
                elseif healthGui then
                    healthGui:Destroy()
                end
            end
        end
    else
        for _, p in pairs(game.Players:GetPlayers()) do
            if p.Character then
                if p.Character:FindFirstChild("ViperXChams") then p.Character.ViperXChams:Destroy() end
                if p.Character:FindFirstChild("ViperXBox") then p.Character.ViperXBox:Destroy() end
                if p.Character:FindFirstChild("ViperXHealth") then p.Character.ViperXHealth:Destroy() end
            end
            if TracerCache[p] then
                TracerCache[p].Visible = false
            end
        end
    end
end))

-- Aimbot & Movement Core
table.insert(Connections, RunService.RenderStepped:Connect(function()
    local char = Player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    
    FOVCircle.Visible = States.show_fov_circle
    FOVCircle.Position = UserInputService:GetMouseLocation()
    FOVCircle.Radius = States.fov_circle_size
    FOVCircle.Color = States.fov_circle_color and Color3.new(1,1,1) or Color3.new(1,0,0)

    if States.aimbot_toggle then
        local target = nil
        local dist = States.fov_circle_size
        local part = States.aim_part and "UpperTorso" or "Head"

        for _, p in pairs(game.Players:GetPlayers()) do
            if p ~= Player and p.Character and p.Character:FindFirstChild(part) then
                local pos, onScreen = Camera:WorldToViewportPoint(p.Character[part].Position)
                if onScreen then
                    local mag = (Vector2.new(pos.X, pos.Y) - UserInputService:GetMouseLocation()).Magnitude
                    if mag < dist then dist = mag; target = p.Character[part] end
                end
            end
        end
        if target then
            if States.aimbot_mode then 
                local calculatedLerp = math.clamp(States.aim_smoothness / 100, 0.01, 1)
                Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, target.Position), calculatedLerp)
            else 
                Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Position)
            end
        end
    end

    if States.toggle_fly then
        local dir = Vector3.zero
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir += Camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir -= Camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir -= Camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir += Camera.CFrame.RightVector end
        char.HumanoidRootPart.Velocity = dir * States.FlySpeed
        char.Humanoid.PlatformStand = true
    else
        char.Humanoid.PlatformStand = false
    end

    char.Humanoid.WalkSpeed = States.auto_sprint and States.AutoSprintSpeed or 16
end))

-- Noclip Execution Loop
table.insert(Connections, RunService.Stepped:Connect(function()
    if States.noclip and Player.Character then
        for _, v in pairs(Player.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
end))

-- Spawn Actions
local function StartActions()
    local Character = Player.Character or Player.CharacterAdded:Wait()
    local HRP = Character:WaitForChild("HumanoidRootPart")
    local Hum = Character:WaitForChild("Humanoid")

    task.wait(0.1)
    Hum.Jump = true
    HRP.CFrame = HRP.CFrame * CFrame.Angles(0, math.rad(-90), 0)
end
task.spawn(StartActions)

print("ViperX forced to front layer!")
        -- --------------------------------------------------------------------
    else
        StatusLabel.Text = "System Status: Invalid Key"
        StatusLabel.TextColor3 = Color3.fromRGB(200, 80, 80)
        KeyInput.Text = ""
    end
end)