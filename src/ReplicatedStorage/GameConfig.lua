-- Game Configuration
local GameConfig = {
	-- Starting values
	StartingMoney = 100,
	
	-- Money earning settings
	MoneyLocations = {
		{Name = "Basic Money Spot", EarnAmount = 10, CooldownTime = 5},
		{Name = "Advanced Money Spot", EarnAmount = 25, CooldownTime = 5, RequiredStructure = "MoneyUpgrade1"},
		{Name = "Elite Money Spot", EarnAmount = 50, CooldownTime = 5, RequiredStructure = "MoneyUpgrade2"}
	},
	
	-- Structure costs and properties
	Structures = {
		-- Golem spawners
		{
			Id = "BasicGolemSpawner",
			Name = "Basic Golem Spawner",
			Cost = 500,
			Description = "Spawns basic golems every 30 seconds",
			Type = "GolemSpawner",
			SpawnInterval = 30,
			GolemType = "Basic"
		},
		{
			Id = "AdvancedGolemSpawner",
			Name = "Advanced Golem Spawner",
			Cost = 2000,
			Description = "Spawns advanced golems every 20 seconds",
			Type = "GolemSpawner",
			SpawnInterval = 20,
			GolemType = "Advanced",
			RequiredStructure = "BasicGolemSpawner"
		},
		{
			Id = "EliteGolemSpawner",
			Name = "Elite Golem Spawner",
			Cost = 5000,
			Description = "Spawns elite golems every 15 seconds",
			Type = "GolemSpawner",
			SpawnInterval = 15,
			GolemType = "Elite",
			RequiredStructure = "AdvancedGolemSpawner"
		},
		
		-- Money upgrades
		{
			Id = "MoneyUpgrade1",
			Name = "Money Spot Upgrade 1",
			Cost = 300,
			Description = "Unlocks advanced money earning spot",
			Type = "Upgrade"
		},
		{
			Id = "MoneyUpgrade2",
			Name = "Money Spot Upgrade 2",
			Cost = 1000,
			Description = "Unlocks elite money earning spot",
			Type = "Upgrade",
			RequiredStructure = "MoneyUpgrade1"
		},
		
		-- Base upgrades
		{
			Id = "BaseExpansion1",
			Name = "Base Expansion 1",
			Cost = 750,
			Description = "Expands your base area",
			Type = "BaseUpgrade"
		},
		{
			Id = "BaseExpansion2",
			Name = "Base Expansion 2",
			Cost = 1500,
			Description = "Further expands your base area",
			Type = "BaseUpgrade",
			RequiredStructure = "BaseExpansion1"
		},
		{
			Id = "BaseWalls",
			Name = "Base Walls",
			Cost = 2500,
			Description = "Adds protective walls to your base",
			Type = "BaseUpgrade"
		}
	},
	
	-- Weapon costs
	Weapons = {
		{
			Id = "BasicSword",
			Name = "Basic Sword",
			Cost = 200,
			Description = "Equips golems with basic swords",
			Damage = 10
		},
		{
			Id = "IronAxe",
			Name = "Iron Axe",
			Cost = 600,
			Description = "Equips golems with iron axes",
			Damage = 25,
			RequiredWeapon = "BasicSword"
		},
		{
			Id = "SteelSpear",
			Name = "Steel Spear",
			Cost = 1200,
			Description = "Equips golems with steel spears",
			Damage = 40,
			RequiredWeapon = "IronAxe"
		},
		{
			Id = "DiamondBlade",
			Name = "Diamond Blade",
			Cost = 3000,
			Description = "Equips golems with diamond blades",
			Damage = 75,
			RequiredWeapon = "SteelSpear"
		}
	},
	
	-- Golem properties
	Golems = {
		Basic = {
			Health = 100,
			Speed = 16,
			Color = Color3.fromRGB(150, 150, 150)
		},
		Advanced = {
			Health = 200,
			Speed = 18,
			Color = Color3.fromRGB(100, 100, 200)
		},
		Elite = {
			Health = 350,
			Speed = 20,
			Color = Color3.fromRGB(200, 100, 100)
		}
	}
}

return GameConfig
