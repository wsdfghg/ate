-- Player Data Manager
-- Handles player data storage and retrieval

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GameConfig = require(ReplicatedStorage:WaitForChild("GameConfig"))

local PlayerDataManager = {}
PlayerDataManager.PlayerData = {}

-- Initialize player data when they join
function PlayerDataManager:InitializePlayer(player)
	if not self.PlayerData[player.UserId] then
		self.PlayerData[player.UserId] = {
			Money = GameConfig.StartingMoney,
			OwnedStructures = {},
			OwnedWeapons = {},
			CurrentWeapon = nil,
			Golems = {}
		}
		
		print("Initialized player data for:", player.Name)
	end
	
	return self.PlayerData[player.UserId]
end

-- Get player data
function PlayerDataManager:GetPlayerData(player)
	return self.PlayerData[player.UserId]
end

-- Add money to player
function PlayerDataManager:AddMoney(player, amount)
	local data = self:GetPlayerData(player)
	if data then
		data.Money = data.Money + amount
		return true, data.Money
	end
	return false, 0
end

-- Remove money from player
function PlayerDataManager:RemoveMoney(player, amount)
	local data = self:GetPlayerData(player)
	if data and data.Money >= amount then
		data.Money = data.Money - amount
		return true, data.Money
	end
	return false, data and data.Money or 0
end

-- Check if player can afford something
function PlayerDataManager:CanAfford(player, cost)
	local data = self:GetPlayerData(player)
	return data and data.Money >= cost
end

-- Purchase structure
function PlayerDataManager:PurchaseStructure(player, structureId)
	local data = self:GetPlayerData(player)
	if not data then return false end
	
	-- Check if already owned
	if table.find(data.OwnedStructures, structureId) then
		return false, "Already owned"
	end
	
	-- Find structure config
	local structureConfig = nil
	for _, structure in ipairs(GameConfig.Structures) do
		if structure.Id == structureId then
			structureConfig = structure
			break
		end
	end
	
	if not structureConfig then
		return false, "Structure not found"
	end
	
	-- Check requirements
	if structureConfig.RequiredStructure then
		if not table.find(data.OwnedStructures, structureConfig.RequiredStructure) then
			return false, "Missing required structure"
		end
	end
	
	-- Check cost
	if not self:CanAfford(player, structureConfig.Cost) then
		return false, "Not enough money"
	end
	
	-- Purchase
	self:RemoveMoney(player, structureConfig.Cost)
	table.insert(data.OwnedStructures, structureId)
	
	return true, "Purchased successfully"
end

-- Purchase weapon
function PlayerDataManager:PurchaseWeapon(player, weaponId)
	local data = self:GetPlayerData(player)
	if not data then return false end
	
	-- Check if already owned
	if table.find(data.OwnedWeapons, weaponId) then
		return false, "Already owned"
	end
	
	-- Find weapon config
	local weaponConfig = nil
	for _, weapon in ipairs(GameConfig.Weapons) do
		if weapon.Id == weaponId then
			weaponConfig = weapon
			break
		end
	end
	
	if not weaponConfig then
		return false, "Weapon not found"
	end
	
	-- Check requirements
	if weaponConfig.RequiredWeapon then
		if not table.find(data.OwnedWeapons, weaponConfig.RequiredWeapon) then
			return false, "Missing required weapon"
		end
	end
	
	-- Check cost
	if not self:CanAfford(player, weaponConfig.Cost) then
		return false, "Not enough money"
	end
	
	-- Purchase
	self:RemoveMoney(player, weaponConfig.Cost)
	table.insert(data.OwnedWeapons, weaponId)
	data.CurrentWeapon = weaponId
	
	return true, "Purchased successfully"
end

-- Add golem to player's army
function PlayerDataManager:AddGolem(player, golem)
	local data = self:GetPlayerData(player)
	if data then
		table.insert(data.Golems, golem)
		return true
	end
	return false
end

-- Clean up player data when they leave
function PlayerDataManager:CleanupPlayer(player)
	self.PlayerData[player.UserId] = nil
	print("Cleaned up player data for:", player.Name)
end

return PlayerDataManager
