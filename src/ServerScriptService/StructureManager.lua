-- Structure Manager
-- Handles structure purchasing and placement

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GameConfig = require(ReplicatedStorage:WaitForChild("GameConfig"))

local StructureManager = {}

-- Create purchase buttons for structures
function StructureManager:CreateStructureButtons(basePosition)
	local buttonFolder = Instance.new("Folder")
	buttonFolder.Name = "StructureButtons"
	buttonFolder.Parent = workspace
	
	for i, structureConfig in ipairs(GameConfig.Structures) do
		local buttonPart = Instance.new("Part")
		buttonPart.Name = structureConfig.Id .. "_Button"
		buttonPart.Size = Vector3.new(4, 6, 1)
		buttonPart.Position = basePosition + Vector3.new(0, 3, i * 5)
		buttonPart.Anchored = true
		buttonPart.BrickColor = BrickColor.new("Bright blue")
		buttonPart.Material = Enum.Material.SmoothPlastic
		buttonPart.Parent = buttonFolder
		
		-- Add clickable detector
		local clickDetector = Instance.new("ClickDetector")
		clickDetector.MaxActivationDistance = 10
		clickDetector.Parent = buttonPart
		
		-- Add info display
		local billboardGui = Instance.new("BillboardGui")
		billboardGui.Size = UDim2.new(0, 300, 0, 150)
		billboardGui.Adornee = buttonPart
		billboardGui.AlwaysOnTop = true
		billboardGui.Parent = buttonPart
		
		local frame = Instance.new("Frame")
		frame.Size = UDim2.new(1, 0, 1, 0)
		frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
		frame.BackgroundTransparency = 0.3
		frame.Parent = billboardGui
		
		local nameLabel = Instance.new("TextLabel")
		nameLabel.Size = UDim2.new(1, 0, 0.4, 0)
		nameLabel.Position = UDim2.new(0, 0, 0, 0)
		nameLabel.BackgroundTransparency = 1
		nameLabel.Text = structureConfig.Name
		nameLabel.TextColor3 = Color3.new(1, 1, 1)
		nameLabel.TextScaled = true
		nameLabel.Font = Enum.Font.GothamBold
		nameLabel.Parent = frame
		
		local costLabel = Instance.new("TextLabel")
		costLabel.Size = UDim2.new(1, 0, 0.3, 0)
		costLabel.Position = UDim2.new(0, 0, 0.4, 0)
		costLabel.BackgroundTransparency = 1
		costLabel.Text = "$" .. structureConfig.Cost
		costLabel.TextColor3 = Color3.new(0, 1, 0)
		costLabel.TextScaled = true
		costLabel.Font = Enum.Font.Gotham
		costLabel.Parent = frame
		
		local descLabel = Instance.new("TextLabel")
		descLabel.Size = UDim2.new(1, 0, 0.3, 0)
		descLabel.Position = UDim2.new(0, 0, 0.7, 0)
		descLabel.BackgroundTransparency = 1
		descLabel.Text = structureConfig.Description
		descLabel.TextColor3 = Color3.new(0.8, 0.8, 0.8)
		descLabel.TextScaled = true
		descLabel.Font = Enum.Font.Gotham
		descLabel.Parent = frame
		
		-- Store config reference
		buttonPart:SetAttribute("StructureId", structureConfig.Id)
	end
	
	return buttonFolder
end

-- Handle structure purchase
function StructureManager:PurchaseStructure(player, buttonPart, playerDataManager, golemSpawner)
	local structureId = buttonPart:GetAttribute("StructureId")
	if not structureId then return false, "Invalid structure" end
	
	local success, message = playerDataManager:PurchaseStructure(player, structureId)
	
	if success then
		-- Visual feedback
		self:ActivateStructure(buttonPart, structureId, player, golemSpawner)
	end
	
	return success, message
end

-- Activate purchased structure
function StructureManager:ActivateStructure(buttonPart, structureId, player, golemSpawner)
	-- Change button appearance to show it's purchased
	buttonPart.BrickColor = BrickColor.new("Bright green")
	buttonPart.Transparency = 0.5
	
	-- Find structure config
	local structureConfig = nil
	for _, structure in ipairs(GameConfig.Structures) do
		if structure.Id == structureId then
			structureConfig = structure
			break
		end
	end
	
	if not structureConfig then return end
	
	-- Handle different structure types
	if structureConfig.Type == "GolemSpawner" then
		-- Start spawning golems
		if golemSpawner then
			local spawnPoint = buttonPart.Position + Vector3.new(0, -2, 5)
			golemSpawner:StartSpawning(player, structureConfig, spawnPoint)
		end
	elseif structureConfig.Type == "BaseUpgrade" then
		-- Visual base upgrade (could expand base area, add walls, etc.)
		self:ApplyBaseUpgrade(structureConfig, buttonPart)
	end
end

-- Apply base upgrade visuals
function StructureManager:ApplyBaseUpgrade(structureConfig, buttonPart)
	-- Create visual representation of upgrade
	local upgradePart = Instance.new("Part")
	upgradePart.Name = structureConfig.Id
	upgradePart.Size = Vector3.new(10, 1, 10)
	upgradePart.Position = buttonPart.Position + Vector3.new(10, -2, 0)
	upgradePart.Anchored = true
	upgradePart.BrickColor = BrickColor.new("Dark stone grey")
	upgradePart.Material = Enum.Material.Concrete
	upgradePart.Parent = workspace
	
	-- Add decorative elements based on upgrade type
	if structureConfig.Id:find("Expansion") then
		upgradePart.Size = Vector3.new(15, 0.5, 15)
	elseif structureConfig.Id:find("Walls") then
		-- Create wall segments
		for i = 1, 4 do
			local wall = Instance.new("Part")
			wall.Size = Vector3.new(20, 5, 1)
			wall.Anchored = true
			wall.BrickColor = BrickColor.new("Medium stone grey")
			wall.Material = Enum.Material.Brick
			wall.Parent = workspace
			
			-- Position walls around the base
			if i == 1 then
				wall.Position = upgradePart.Position + Vector3.new(0, 2.5, 10)
			elseif i == 2 then
				wall.Position = upgradePart.Position + Vector3.new(0, 2.5, -10)
			elseif i == 3 then
				wall.Size = Vector3.new(1, 5, 20)
				wall.Position = upgradePart.Position + Vector3.new(10, 2.5, 0)
			else
				wall.Size = Vector3.new(1, 5, 20)
				wall.Position = upgradePart.Position + Vector3.new(-10, 2.5, 0)
			end
		end
	end
end

return StructureManager
