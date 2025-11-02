_G.HeadSize = 14
_G.HeadHitboxEnabled = false

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- Lưu trạng thái gốc của đầu
local originalHeadSizes = {}

-- GUI Setup
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "HeadHitboxMenu"
screenGui.Parent = CoreGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 180)
frame.Position = UDim2.new(0.5, -150, 0.5, -90)
frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
frame.BorderSizePixel = 0
frame.Parent = screenGui

-- Bo góc cho frame
local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 10)
frameCorner.Parent = frame

-- Title Bar
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 35)
titleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
titleBar.BorderSizePixel = 0
titleBar.Parent = frame

local titleBarCorner = Instance.new("UICorner")
titleBarCorner.CornerRadius = UDim.new(0, 10)
titleBarCorner.Parent = titleBar

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -10, 1, 0)
titleLabel.Position = UDim2.new(0, 10, 0, 0)
titleLabel.Text = "🎯 Hitbox Menu by Đức Hoàng"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.BackgroundTransparency = 1
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 16
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = titleBar

-- Toggle Button
local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0.9, 0, 0, 35)
toggleButton.Position = UDim2.new(0.05, 0, 0, 45)
toggleButton.Text = _G.HeadHitboxEnabled and "🔴 TẮT HITBOX" or "🟢 BẬT HITBOX"
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.BackgroundColor3 = _G.HeadHitboxEnabled and Color3.fromRGB(220, 53, 69) or Color3.fromRGB(40, 167, 69)
toggleButton.BorderSizePixel = 0
toggleButton.Font = Enum.Font.GothamBold
toggleButton.TextSize = 14
toggleButton.Parent = frame

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 8)
toggleCorner.Parent = toggleButton

-- Size Label
local sizeLabel = Instance.new("TextLabel")
sizeLabel.Size = UDim2.new(0.9, 0, 0, 25)
sizeLabel.Position = UDim2.new(0.05, 0, 0, 90)
sizeLabel.Text = "Kích thước đầu: " .. tostring(_G.HeadSize)
sizeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
sizeLabel.BackgroundTransparency = 1
sizeLabel.Font = Enum.Font.Gotham
sizeLabel.TextSize = 13
sizeLabel.TextXAlignment = Enum.TextXAlignment.Left
sizeLabel.Parent = frame

-- Slider Background
local sliderBg = Instance.new("Frame")
sliderBg.Size = UDim2.new(0.9, 0, 0, 8)
sliderBg.Position = UDim2.new(0.05, 0, 0, 120)
sliderBg.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
sliderBg.BorderSizePixel = 0
sliderBg.Parent = frame

local sliderBgCorner = Instance.new("UICorner")
sliderBgCorner.CornerRadius = UDim.new(0, 4)
sliderBgCorner.Parent = sliderBg

-- Slider Fill
local sliderFill = Instance.new("Frame")
sliderFill.Size = UDim2.new(0, 0, 1, 0)
sliderFill.BackgroundColor3 = Color3.fromRGB(0, 123, 255)
sliderFill.BorderSizePixel = 0
sliderFill.Parent = sliderBg

local sliderFillCorner = Instance.new("UICorner")
sliderFillCorner.CornerRadius = UDim.new(0, 4)
sliderFillCorner.Parent = sliderFill

-- Slider Button
local sliderButton = Instance.new("TextButton")
sliderButton.Size = UDim2.new(0, 20, 0, 20)
sliderButton.Position = UDim2.new(0, -10, 0.5, -10)
sliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
sliderButton.BorderSizePixel = 0
sliderButton.Text = ""
sliderButton.Parent = sliderBg

local sliderButtonCorner = Instance.new("UICorner")
sliderButtonCorner.CornerRadius = UDim.new(1, 0)
sliderButtonCorner.Parent = sliderButton

-- Hide/Show Buttons
local hideButton = Instance.new("TextButton")
hideButton.Size = UDim2.new(0.9, 0, 0, 30)
hideButton.Position = UDim2.new(0.05, 0, 0, 140)
hideButton.Text = "➖ ẨN MENU"
hideButton.TextColor3 = Color3.fromRGB(255, 255, 255)
hideButton.BackgroundColor3 = Color3.fromRGB(108, 117, 125)
hideButton.BorderSizePixel = 0
hideButton.Font = Enum.Font.Gotham
hideButton.TextSize = 12
hideButton.Parent = frame

local hideCorner = Instance.new("UICorner")
hideCorner.CornerRadius = UDim.new(0, 8)
hideCorner.Parent = hideButton

local showButton = Instance.new("TextButton")
showButton.Size = UDim2.new(0, 120, 0, 35)
showButton.Position = UDim2.new(0, 10, 0, 10)
showButton.Text = "➕ HIỆN MENU"
showButton.TextColor3 = Color3.fromRGB(255, 255, 255)
showButton.BackgroundColor3 = Color3.fromRGB(0, 123, 255)
showButton.BorderSizePixel = 0
showButton.Font = Enum.Font.GothamBold
showButton.TextSize = 12
showButton.Visible = false
showButton.Parent = screenGui

local showCorner = Instance.new("UICorner")
showCorner.CornerRadius = UDim.new(0, 8)
showCorner.Parent = showButton

-- Slider Logic
local minSize = 1
local maxSize = 500 -- Có thể điều chỉnh lên cao hơn nếu muốn
local draggingSlider = false

local function updateSlider(input)
    local relativeX = math.clamp(input.Position.X - sliderBg.AbsolutePosition.X, 0, sliderBg.AbsoluteSize.X)
    local percentage = relativeX / sliderBg.AbsoluteSize.X
    
    -- Tính toán kích thước theo logarithm để dễ điều chỉnh
    -- Từ 1 đến 500 (có thể tăng maxSize nếu muốn "vô hạn" hơn)
    _G.HeadSize = math.floor(minSize + (maxSize - minSize) * percentage)
    
    -- Cập nhật UI
    sliderButton.Position = UDim2.new(percentage, -10, 0.5, -10)
    sliderFill.Size = UDim2.new(percentage, 0, 1, 0)
    sizeLabel.Text = "Kích thước đầu: " .. tostring(_G.HeadSize)
end

sliderButton.MouseButton1Down:Connect(function()
    draggingSlider = true
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingSlider = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if draggingSlider and input.UserInputType == Enum.UserInputType.MouseMovement then
        updateSlider(input)
    end
end)

sliderBg.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        updateSlider(input)
        draggingSlider = true
    end
end)

-- Khởi tạo vị trí slider ban đầu
local initialPercentage = (_G.HeadSize - minSize) / (maxSize - minSize)
sliderButton.Position = UDim2.new(initialPercentage, -10, 0.5, -10)
sliderFill.Size = UDim2.new(initialPercentage, 0, 1, 0)

-- Kéo GUI
local dragging, dragInput, dragStart, startPos = false, nil, nil, nil

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

titleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Toggle chức năng
toggleButton.MouseButton1Click:Connect(function()
    _G.HeadHitboxEnabled = not _G.HeadHitboxEnabled
    toggleButton.Text = _G.HeadHitboxEnabled and "🔴 TẮT HITBOX" or "🟢 BẬT HITBOX"
    toggleButton.BackgroundColor3 = _G.HeadHitboxEnabled and Color3.fromRGB(220, 53, 69) or Color3.fromRGB(40, 167, 69)

    if not _G.HeadHitboxEnabled then
        -- Khôi phục kích thước đầu gốc
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                local char = player.Character
                if char then
                    local head = char:FindFirstChild("Head")
                    if head and originalHeadSizes[player] then
                        head.Size = originalHeadSizes[player]
                        head.Transparency = 0
                        head.Material = Enum.Material.Plastic
                        head.BrickColor = BrickColor.new("Medium stone grey")
                        head.CanCollide = true
                        head.Massless = false
                    end
                end
            end
        end
    end
end)

-- Ẩn / Hiện GUI
hideButton.MouseButton1Click:Connect(function()
    frame.Visible = false
    showButton.Visible = true
end)

showButton.MouseButton1Click:Connect(function()
    frame.Visible = true
    showButton.Visible = false
end)

-- Áp dụng kích thước hitbox
RunService.RenderStepped:Connect(function()
    if _G.HeadHitboxEnabled then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                local char = player.Character
                if char then
                    local head = char:FindFirstChild("Head")
                    if head then
                        -- Lưu kích thước gốc nếu chưa có
                        if not originalHeadSizes[player] then
                            originalHeadSizes[player] = head.Size
                        end

                        -- Chỉnh sửa kích thước
                        head.Size = Vector3.new(_G.HeadSize, _G.HeadSize, _G.HeadSize)
                        head.Transparency = 0.5
                        head.BrickColor = BrickColor.new("Really red")
                        head.Material = Enum.Material.Neon
                        head.CanCollide = false
                        head.Massless = true
                    end
                end
            end
        end
    end
end)

-- Xóa khi player rời
Players.PlayerRemoving:Connect(function(player)
    originalHeadSizes[player] = nil
end)

print("✅ Hitbox Menu đã được tải thành công!")
print("📊 Kích thước có thể điều chỉnh từ 1 đến " .. maxSize)
