-- Money Manager
-- Handles money earning locations and cooldowns

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GameConfig = require(ReplicatedStorage:WaitForChild("GameConfig"))

local MoneyManager = {}
MoneyManager.PlayerCooldowns = {}

-- Initialize money earning locations in the workspace
function MoneyManager:CreateMoneyLocations(basePosition)
	local moneyFolder = Instance.new("Folder")
	moneyFolder.Name = "MoneyLocations"
	moneyFolder.Parent = workspace
	
	for i, locationConfig in ipairs(GameConfig.MoneyLocations) do
		local moneyPart = Instance.new("Part")
		moneyPart.Name = locationConfig.Name
		moneyPart.Size = Vector3.new(6, 1, 6)
		moneyPart.Position = basePosition + Vector3.new(i * 8, 0, 0)
		moneyPart.Anchored = true
		moneyPart.BrickColor = BrickColor.new("Bright green")
		moneyPart.Material = Enum.Material.Neon
		moneyPart.Parent = moneyFolder
		
		-- Add text label
		local billboardGui = Instance.new("BillboardGui")
		billboardGui.Size = UDim2.new(0, 200, 0, 50)
		billboardGui.Adornee = moneyPart
		billboardGui.AlwaysOnTop = true
		billboardGui.Parent = moneyPart
		
		local textLabel = Instance.new("TextLabel")
		textLabel.Size = UDim2.new(1, 0, 1, 0)
		textLabel.BackgroundTransparency = 1
		textLabel.Text = "$" .. locationConfig.EarnAmount
		textLabel.TextColor3 = Color3.new(1, 1, 1)
		textLabel.TextScaled = true
		textLabel.Font = Enum.Font.GothamBold
		textLabel.Parent = billboardGui
		
		-- Store config reference
		moneyPart:SetAttribute("EarnAmount", locationConfig.EarnAmount)
		moneyPart:SetAttribute("CooldownTime", locationConfig.CooldownTime)
		if locationConfig.RequiredStructure then
			moneyPart:SetAttribute("RequiredStructure", locationConfig.RequiredStructure)
		end
	end
	
	return moneyFolder
end

-- Handle money earning
function MoneyManager:EarnMoney(player, moneyPart, playerDataManager)
	local userId = player.UserId
	local partName = moneyPart.Name
	
	-- Initialize cooldown table if needed
	if not self.PlayerCooldowns[userId] then
		self.PlayerCooldowns[userId] = {}
	end
	
	-- Check cooldown
	local lastEarnTime = self.PlayerCooldowns[userId][partName] or 0
	local currentTime = tick()
	local cooldownTime = moneyPart:GetAttribute("CooldownTime") or 5
	
	if currentTime - lastEarnTime < cooldownTime then
		local remaining = math.ceil(cooldownTime - (currentTime - lastEarnTime))
		return false, "Cooldown: " .. remaining .. "s"
	end
	
	-- Check requirements
	local requiredStructure = moneyPart:GetAttribute("RequiredStructure")
	if requiredStructure then
		local playerData = playerDataManager:GetPlayerData(player)
		if not playerData or not table.find(playerData.OwnedStructures, requiredStructure) then
			return false, "Requires: " .. requiredStructure
		end
	end
	
	-- Award money
	local earnAmount = moneyPart:GetAttribute("EarnAmount") or 10
	local success, newMoney = playerDataManager:AddMoney(player, earnAmount)
	
	if success then
		self.PlayerCooldowns[userId][partName] = currentTime
		return true, "Earned $" .. earnAmount .. " (Total: $" .. newMoney .. ")"
	end
	
	return false, "Failed to earn money"
end

-- Clean up player cooldowns
function MoneyManager:CleanupPlayer(player)
	self.PlayerCooldowns[player.UserId] = nil
end

return MoneyManager
