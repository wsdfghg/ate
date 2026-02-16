-- Golem Spawner
-- Handles spawning and managing golems

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GameConfig = require(ReplicatedStorage:WaitForChild("GameConfig"))

local GolemSpawner = {}
GolemSpawner.ActiveSpawners = {}

-- Create a golem model
function GolemSpawner:CreateGolem(golemType, position, weaponId)
	local golemConfig = GameConfig.Golems[golemType]
	if not golemConfig then
		golemConfig = GameConfig.Golems.Basic
	end
	
	-- Create golem model
	local golem = Instance.new("Model")
	golem.Name = golemType .. "Golem"
	
	-- Body
	local body = Instance.new("Part")
	body.Name = "Body"
	body.Size = Vector3.new(4, 6, 2)
	body.Position = position
	body.BrickColor = BrickColor.new(golemConfig.Color)
	body.Material = Enum.Material.Slate
	body.Parent = golem
	
	-- Head
	local head = Instance.new("Part")
	head.Name = "Head"
	head.Size = Vector3.new(3, 3, 3)
	head.Position = position + Vector3.new(0, 4.5, 0)
	head.BrickColor = BrickColor.new(golemConfig.Color)
	head.Material = Enum.Material.Slate
	head.Parent = golem
	
	-- Arms
	local leftArm = Instance.new("Part")
	leftArm.Name = "LeftArm"
	leftArm.Size = Vector3.new(1, 5, 1)
	leftArm.Position = position + Vector3.new(-2.5, 0, 0)
	leftArm.BrickColor = BrickColor.new(golemConfig.Color)
	leftArm.Material = Enum.Material.Slate
	leftArm.Parent = golem
	
	local rightArm = Instance.new("Part")
	rightArm.Name = "RightArm"
	rightArm.Size = Vector3.new(1, 5, 1)
	rightArm.Position = position + Vector3.new(2.5, 0, 0)
	rightArm.BrickColor = BrickColor.new(golemConfig.Color)
	rightArm.Material = Enum.Material.Slate
	rightArm.Parent = golem
	
	-- Legs
	local leftLeg = Instance.new("Part")
	leftLeg.Name = "LeftLeg"
	leftLeg.Size = Vector3.new(1.5, 4, 1.5)
	leftLeg.Position = position + Vector3.new(-1, -5, 0)
	leftLeg.BrickColor = BrickColor.new(golemConfig.Color)
	leftLeg.Material = Enum.Material.Slate
	leftLeg.Parent = golem
	
	local rightLeg = Instance.new("Part")
	rightLeg.Name = "RightLeg"
	rightLeg.Size = Vector3.new(1.5, 4, 1.5)
	rightLeg.Position = position + Vector3.new(1, -5, 0)
	rightLeg.BrickColor = BrickColor.new(golemConfig.Color)
	rightLeg.Material = Enum.Material.Slate
	rightLeg.Parent = golem
	
	-- Add humanoid
	local humanoid = Instance.new("Humanoid")
	humanoid.MaxHealth = golemConfig.Health
	humanoid.Health = golemConfig.Health
	humanoid.WalkSpeed = golemConfig.Speed
	humanoid.Parent = golem
	
	-- Set primary part
	golem.PrimaryPart = body
	
	-- Add weapon if specified
	if weaponId then
		self:EquipWeapon(golem, weaponId)
	end
	
	-- Add name tag
	local billboardGui = Instance.new("BillboardGui")
	billboardGui.Size = UDim2.new(0, 100, 0, 40)
	billboardGui.Adornee = head
	billboardGui.AlwaysOnTop = true
	billboardGui.Parent = head
	
	local nameLabel = Instance.new("TextLabel")
	nameLabel.Size = UDim2.new(1, 0, 1, 0)
	nameLabel.BackgroundTransparency = 1
	nameLabel.Text = golemType
	nameLabel.TextColor3 = Color3.new(1, 1, 1)
	nameLabel.TextScaled = true
	nameLabel.Font = Enum.Font.GothamBold
	nameLabel.Parent = billboardGui
	
	golem.Parent = workspace
	
	-- Weld parts together
	self:WeldGolem(golem)
	
	return golem
end

-- Weld golem parts together
function GolemSpawner:WeldGolem(golem)
	local body = golem:FindFirstChild("Body")
	if not body then return end
	
	for _, part in ipairs(golem:GetChildren()) do
		if part:IsA("BasePart") and part ~= body then
			local weld = Instance.new("Weld")
			weld.Part0 = body
			weld.Part1 = part
			weld.C0 = body.CFrame:Inverse()
			weld.C1 = part.CFrame:Inverse()
			weld.Parent = body
		end
	end
end

-- Equip weapon to golem
function GolemSpawner:EquipWeapon(golem, weaponId)
	-- Find weapon config
	local weaponConfig = nil
	for _, weapon in ipairs(GameConfig.Weapons) do
		if weapon.Id == weaponId then
			weaponConfig = weapon
			break
		end
	end
	
	if not weaponConfig then return end
	
	-- Create weapon model (simplified)
	local weapon = Instance.new("Part")
	weapon.Name = weaponConfig.Name
	weapon.Size = Vector3.new(0.5, 4, 0.5)
	weapon.BrickColor = BrickColor.new("Dark stone grey")
	weapon.Material = Enum.Material.Metal
	
	-- Attach to right arm
	local rightArm = golem:FindFirstChild("RightArm")
	if rightArm then
		weapon.Position = rightArm.Position + Vector3.new(0, 2, 0)
		weapon.Parent = golem
		
		local weld = Instance.new("Weld")
		weld.Part0 = rightArm
		weld.Part1 = weapon
		weld.C0 = rightArm.CFrame:Inverse()
		weld.C1 = weapon.CFrame:Inverse()
		weld.Parent = rightArm
	end
	
	-- Store weapon damage
	golem:SetAttribute("WeaponDamage", weaponConfig.Damage)
end

-- Start spawning golems for a player
function GolemSpawner:StartSpawning(player, structureConfig, spawnPoint)
	local spawnerId = player.UserId .. "_" .. structureConfig.Id
	
	-- Prevent duplicate spawners
	if self.ActiveSpawners[spawnerId] then
		return
	end
	
	-- Create spawner coroutine
	self.ActiveSpawners[spawnerId] = true
	
	task.spawn(function()
		while self.ActiveSpawners[spawnerId] do
			-- Wait for spawn interval
			wait(structureConfig.SpawnInterval)
			
			-- Check if player is still in game
			if not player.Parent then
				self.ActiveSpawners[spawnerId] = nil
				break
			end
			
			-- Get player's current weapon
			local playerDataManager = require(game.ServerScriptService:WaitForChild("PlayerDataManager"))
			local playerData = playerDataManager:GetPlayerData(player)
			local currentWeapon = playerData and playerData.CurrentWeapon or nil
			
			-- Spawn golem
			local golem = self:CreateGolem(structureConfig.GolemType, spawnPoint, currentWeapon)
			
			-- Add to player's golem list
			if playerData then
				playerDataManager:AddGolem(player, golem)
			end
			
			print("Spawned", structureConfig.GolemType, "golem for", player.Name)
		end
	end)
end

-- Stop spawning for a player
function GolemSpawner:StopSpawning(player, structureId)
	local spawnerId = player.UserId .. "_" .. structureId
	self.ActiveSpawners[spawnerId] = nil
end

-- Clean up all spawners for a player
function GolemSpawner:CleanupPlayer(player)
	for spawnerId, _ in pairs(self.ActiveSpawners) do
		if spawnerId:find("^" .. player.UserId) then
			self.ActiveSpawners[spawnerId] = nil
		end
	end
end

return GolemSpawner
