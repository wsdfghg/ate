# Roblox Tycoon Game - Golem Army Builder

A Roblox Studio tycoon game where players build a base, spawn golems, earn money, and upgrade their golem army with weapons!

## Game Features

- 💰 **Money Earning System**: Click on money spots to earn cash
- 🏗️ **Structure Building**: Purchase golem spawners and base upgrades
- 🤖 **Golem Army**: Spawn different types of golems (Basic, Advanced, Elite)
- ⚔️ **Weapon System**: Equip your golems with increasingly powerful weapons
- 📈 **Progressive Upgrades**: Unlock better structures and weapons as you earn more

## Quick Start

This repository contains all the Lua scripts needed for the tycoon game.

**👉 See [IMPLEMENTATION_GUIDE.md](IMPLEMENTATION_GUIDE.md) for complete step-by-step instructions on how to set this up in Roblox Studio.**

## File Structure

```
src/
├── ReplicatedStorage/
│   └── GameConfig.lua          # Game configuration (costs, stats, etc.)
└── ServerScriptService/
    ├── MainGame.lua            # Main game controller
    ├── PlayerDataManager.lua   # Handles player data and purchases
    ├── MoneyManager.lua        # Money earning system
    ├── StructureManager.lua    # Structure purchasing and placement
    ├── GolemSpawner.lua        # Golem creation and spawning
    └── WeaponManager.lua       # Weapon purchasing and equipping
```

## Game Mechanics

### Starting the Game
- Players start with $100
- Click green money platforms to earn cash
- Use money to buy structures and weapons

### Structures Available
1. **Golem Spawners** (3 tiers) - Automatically spawn golems
2. **Money Upgrades** - Unlock better money earning spots
3. **Base Upgrades** - Expand your base and add walls

### Weapons Available
1. Basic Sword ($200, 10 damage)
2. Iron Axe ($600, 25 damage)
3. Steel Spear ($1200, 40 damage)
4. Diamond Blade ($3000, 75 damage)

### Golem Types
- **Basic Golem**: 100 HP, spawns every 30 seconds
- **Advanced Golem**: 200 HP, spawns every 20 seconds
- **Elite Golem**: 350 HP, spawns every 15 seconds

## Customization

All game settings can be easily modified in `src/ReplicatedStorage/GameConfig.lua`:
- Starting money amount
- Structure costs and spawn rates
- Weapon damage values
- Golem health and speed
- And more!

## Implementation

See the **[IMPLEMENTATION_GUIDE.md](IMPLEMENTATION_GUIDE.md)** file for detailed instructions on how to implement this code in Roblox Studio.