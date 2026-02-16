-- Main Game Script
-- Initializes and manages the tycoon game

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Wait for modules to load
local PlayerDataManager = require(script.Parent:WaitForChild("PlayerDataManager"))
local MoneyManager = require(script.Parent:WaitForChild("MoneyManager"))
local StructureManager = require(script.Parent:WaitForChild("StructureManager"))
local GolemSpawner = require(script.Parent:WaitForChild("GolemSpawner"))
local WeaponManager = require(script.Parent:WaitForChild("WeaponManager"))

print("Tycoon Game initialized!")

-- Base position for the tycoon
local BASE_POSITION = Vector3.new(0, 5, 0)

-- Create game elements
local moneyLocations = MoneyManager:CreateMoneyLocations(BASE_POSITION)
local structureButtons = StructureManager:CreateStructureButtons(BASE_POSITION + Vector3.new(-15, 0, 0))
local weaponButtons = WeaponManager:CreateWeaponButtons(BASE_POSITION)

-- Setup money location interactions
for _, moneyPart in ipairs(moneyLocations:GetChildren()) do
	if moneyPart:IsA("BasePart") then
		local clickDetector = Instance.new("ClickDetector")
		clickDetector.MaxActivationDistance = 10
		clickDetector.Parent = moneyPart
		
		clickDetector.MouseClick:Connect(function(player)
			local success, message = MoneyManager:EarnMoney(player, moneyPart, PlayerDataManager)
			
			-- Send feedback to player
			if success then
				print(player.Name .. ":", message)
			else
				warn(player.Name .. ":", message)
			end
		end)
	end
end

-- Setup structure button interactions
for _, button in ipairs(structureButtons:GetChildren()) do
	if button:IsA("BasePart") then
		local clickDetector = button:FindFirstChildOfClass("ClickDetector")
		if clickDetector then
			clickDetector.MouseClick:Connect(function(player)
				local success, message = StructureManager:PurchaseStructure(player, button, PlayerDataManager, GolemSpawner)
				
				-- Send feedback to player
				if success then
					print(player.Name .. ": Purchased structure -", message)
				else
					warn(player.Name .. ": Failed to purchase -", message)
				end
			end)
		end
	end
end

-- Setup weapon button interactions
for _, button in ipairs(weaponButtons:GetChildren()) do
	if button:IsA("BasePart") then
		local clickDetector = button:FindFirstChildOfClass("ClickDetector")
		if clickDetector then
			clickDetector.MouseClick:Connect(function(player)
				local success, message = WeaponManager:PurchaseWeapon(player, button, PlayerDataManager)
				
				-- Send feedback to player
				if success then
					print(player.Name .. ": Purchased weapon -", message)
				else
					warn(player.Name .. ": Failed to purchase -", message)
				end
			end)
		end
	end
end

-- Player joined
Players.PlayerAdded:Connect(function(player)
	print(player.Name .. " joined the game!")
	
	-- Initialize player data
	PlayerDataManager:InitializePlayer(player)
	
	-- Welcome message
	print("Welcome " .. player.Name .. "! Start earning money to build your golem army!")
end)

-- Player leaving
Players.PlayerRemoving:Connect(function(player)
	print(player.Name .. " left the game!")
	
	-- Cleanup
	PlayerDataManager:CleanupPlayer(player)
	MoneyManager:CleanupPlayer(player)
	GolemSpawner:CleanupPlayer(player)
end)

-- Initialize existing players (in case script reloads)
for _, player in ipairs(Players:GetPlayers()) do
	PlayerDataManager:InitializePlayer(player)
end

print("Tycoon game is ready!")
