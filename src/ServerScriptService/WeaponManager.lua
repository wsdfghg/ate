-- Weapon Manager
-- Handles weapon purchasing and equipping

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GameConfig = require(ReplicatedStorage:WaitForChild("GameConfig"))

local WeaponManager = {}

-- Create purchase buttons for weapons
function WeaponManager:CreateWeaponButtons(basePosition)
	local buttonFolder = Instance.new("Folder")
	buttonFolder.Name = "WeaponButtons"
	buttonFolder.Parent = workspace
	
	for i, weaponConfig in ipairs(GameConfig.Weapons) do
		local buttonPart = Instance.new("Part")
		buttonPart.Name = weaponConfig.Id .. "_Button"
		buttonPart.Size = Vector3.new(4, 5, 1)
		buttonPart.Position = basePosition + Vector3.new(15, 2.5, i * 5)
		buttonPart.Anchored = true
		buttonPart.BrickColor = BrickColor.new("Bright red")
		buttonPart.Material = Enum.Material.SmoothPlastic
		buttonPart.Parent = buttonFolder
		
		-- Add clickable detector
		local clickDetector = Instance.new("ClickDetector")
		clickDetector.MaxActivationDistance = 10
		clickDetector.Parent = buttonPart
		
		-- Add info display
		local billboardGui = Instance.new("BillboardGui")
		billboardGui.Size = UDim2.new(0, 250, 0, 120)
		billboardGui.Adornee = buttonPart
		billboardGui.AlwaysOnTop = true
		billboardGui.Parent = buttonPart
		
		local frame = Instance.new("Frame")
		frame.Size = UDim2.new(1, 0, 1, 0)
		frame.BackgroundColor3 = Color3.fromRGB(70, 20, 20)
		frame.BackgroundTransparency = 0.3
		frame.Parent = billboardGui
		
		local nameLabel = Instance.new("TextLabel")
		nameLabel.Size = UDim2.new(1, 0, 0.4, 0)
		nameLabel.Position = UDim2.new(0, 0, 0, 0)
		nameLabel.BackgroundTransparency = 1
		nameLabel.Text = weaponConfig.Name
		nameLabel.TextColor3 = Color3.new(1, 1, 1)
		nameLabel.TextScaled = true
		nameLabel.Font = Enum.Font.GothamBold
		nameLabel.Parent = frame
		
		local costLabel = Instance.new("TextLabel")
		costLabel.Size = UDim2.new(1, 0, 0.3, 0)
		costLabel.Position = UDim2.new(0, 0, 0.4, 0)
		costLabel.BackgroundTransparency = 1
		costLabel.Text = "$" .. weaponConfig.Cost .. " | DMG: " .. weaponConfig.Damage
		costLabel.TextColor3 = Color3.new(1, 0.5, 0)
		costLabel.TextScaled = true
		costLabel.Font = Enum.Font.Gotham
		costLabel.Parent = frame
		
		local descLabel = Instance.new("TextLabel")
		descLabel.Size = UDim2.new(1, 0, 0.3, 0)
		descLabel.Position = UDim2.new(0, 0, 0.7, 0)
		descLabel.BackgroundTransparency = 1
		descLabel.Text = weaponConfig.Description
		descLabel.TextColor3 = Color3.new(0.8, 0.8, 0.8)
		descLabel.TextScaled = true
		descLabel.Font = Enum.Font.Gotham
		descLabel.Parent = frame
		
		-- Store config reference
		buttonPart:SetAttribute("WeaponId", weaponConfig.Id)
	end
	
	return buttonFolder
end

-- Handle weapon purchase
function WeaponManager:PurchaseWeapon(player, buttonPart, playerDataManager)
	local weaponId = buttonPart:GetAttribute("WeaponId")
	if not weaponId then return false, "Invalid weapon" end
	
	local success, message = playerDataManager:PurchaseWeapon(player, weaponId)
	
	if success then
		-- Visual feedback
		buttonPart.BrickColor = BrickColor.new("Bright green")
		buttonPart.Transparency = 0.5
		
		-- Update all existing golems with new weapon
		self:UpdateGolemWeapons(player, weaponId)
	end
	
	return success, message
end

-- Update all player's golems with new weapon
function WeaponManager:UpdateGolemWeapons(player, weaponId)
	local playerDataManager = require(game.ServerScriptService:WaitForChild("PlayerDataManager"))
	local playerData = playerDataManager:GetPlayerData(player)
	
	if not playerData or not playerData.Golems then return end
	
	local golemSpawner = require(game.ServerScriptService:WaitForChild("GolemSpawner"))
	
	for _, golem in ipairs(playerData.Golems) do
		if golem and golem.Parent then
			-- Remove old weapon
			local oldWeapon = golem:FindFirstChild("Weapon")
			if oldWeapon then
				oldWeapon:Destroy()
			end
			
			-- Equip new weapon
			golemSpawner:EquipWeapon(golem, weaponId)
		end
	end
end

return WeaponManager
