# Roblox Studio Implementation Guide
## Complete Step-by-Step Instructions for Tycoon Game

This guide will walk you through **every single step** needed to implement the tycoon game code in Roblox Studio.

---

## Step 1: Create a New Roblox Studio Project

1. Open **Roblox Studio**
2. Click **"New"** or **"File" → "New"**
3. Select **"Baseplate"** template (or any empty template)
4. Click **"Create"**
5. Wait for the project to load

---

## Step 2: Set Up the Explorer Window

1. Make sure the **Explorer** panel is visible (if not: **View** → **Explorer**)
2. Make sure the **Output** panel is visible (if not: **View** → **Output**)
3. You should see these main folders in Explorer:
   - Workspace
   - Players
   - Lighting
   - ReplicatedStorage
   - ServerScriptService
   - StarterPlayer
   - StarterGui

---

## Step 3: Create the GameConfig Module

1. In the **Explorer** panel, find **"ReplicatedStorage"**
2. Right-click on **ReplicatedStorage**
3. Select **"Insert Object" → "ModuleScript"**
4. Rename the ModuleScript from "ModuleScript" to **"GameConfig"** (just click on it and type the new name)
5. Double-click on **GameConfig** to open it
6. **Delete all the default code** inside
7. Copy the **entire contents** of the file `/home/runner/work/ate/ate/src/ReplicatedStorage/GameConfig.lua` from this repository
8. **Paste** it into the GameConfig script in Roblox Studio
9. Press **Ctrl+S** (or **Cmd+S** on Mac) to save

---

## Step 4: Create PlayerDataManager Script

1. In the **Explorer** panel, find **"ServerScriptService"**
2. Right-click on **ServerScriptService**
3. Select **"Insert Object" → "ModuleScript"**
4. Rename it to **"PlayerDataManager"**
5. Double-click to open it
6. **Delete all the default code** inside
7. Copy the **entire contents** of `/home/runner/work/ate/ate/src/ServerScriptService/PlayerDataManager.lua`
8. **Paste** it into the script
9. Press **Ctrl+S** to save

---

## Step 5: Create MoneyManager Script

1. Right-click on **ServerScriptService** again
2. Select **"Insert Object" → "ModuleScript"**
3. Rename it to **"MoneyManager"**
4. Double-click to open it
5. **Delete all the default code**
6. Copy the **entire contents** of `/home/runner/work/ate/ate/src/ServerScriptService/MoneyManager.lua`
7. **Paste** it into the script
8. Press **Ctrl+S** to save

---

## Step 6: Create StructureManager Script

1. Right-click on **ServerScriptService**
2. Select **"Insert Object" → "ModuleScript"**
3. Rename it to **"StructureManager"**
4. Double-click to open it
5. **Delete all the default code**
6. Copy the **entire contents** of `/home/runner/work/ate/ate/src/ServerScriptService/StructureManager.lua`
7. **Paste** it into the script
8. Press **Ctrl+S** to save

---

## Step 7: Create GolemSpawner Script

1. Right-click on **ServerScriptService**
2. Select **"Insert Object" → "ModuleScript"**
3. Rename it to **"GolemSpawner"**
4. Double-click to open it
5. **Delete all the default code**
6. Copy the **entire contents** of `/home/runner/work/ate/ate/src/ServerScriptService/GolemSpawner.lua`
7. **Paste** it into the script
8. Press **Ctrl+S** to save

---

## Step 8: Create WeaponManager Script

1. Right-click on **ServerScriptService**
2. Select **"Insert Object" → "ModuleScript"**
3. Rename it to **"WeaponManager"**
4. Double-click to open it
5. **Delete all the default code**
6. Copy the **entire contents** of `/home/runner/work/ate/ate/src/ServerScriptService/WeaponManager.lua`
7. **Paste** it into the script
8. Press **Ctrl+S** to save

---

## Step 9: Create MainGame Script (Main Controller)

1. Right-click on **ServerScriptService**
2. This time select **"Insert Object" → "Script"** (NOT ModuleScript!)
3. Rename it to **"MainGame"**
4. Double-click to open it
5. **Delete all the default code**
6. Copy the **entire contents** of `/home/runner/work/ate/ate/src/ServerScriptService/MainGame.lua`
7. **Paste** it into the script
8. Press **Ctrl+S** to save

---

## Step 10: Verify Your Explorer Structure

Your **ServerScriptService** folder should now contain:
- ✅ MainGame (Script - has a different icon)
- ✅ PlayerDataManager (ModuleScript)
- ✅ MoneyManager (ModuleScript)
- ✅ StructureManager (ModuleScript)
- ✅ GolemSpawner (ModuleScript)
- ✅ WeaponManager (ModuleScript)

Your **ReplicatedStorage** folder should contain:
- ✅ GameConfig (ModuleScript)

---

## Step 11: Set Up the Spawn Location (Optional but Recommended)

1. In **Workspace**, find the default **"SpawnLocation"** part (green rectangle)
2. Click on it to select it
3. In the **Properties** panel (if not visible: **View** → **Properties**)
4. Set its **Position** to approximately `0, 0.5, -20` so players spawn near the tycoon area
5. You can also make it larger: set **Size** to `20, 1, 20`

---

## Step 12: Test the Game!

1. Click the **"Play"** button (or press **F5**) at the top of Roblox Studio
2. Wait for the game to load
3. Check the **Output** window for these messages:
   - "Tycoon Game initialized!"
   - "YourUsername joined the game!"
   - "Welcome YourUsername! Start earning money to build your golem army!"
   - "Tycoon game is ready!"

---

## Step 13: Verify Game Elements Spawned

Once playing, you should see in the game world:
- **Green glowing platforms** (Money earning spots) - click these to earn money
- **Blue buttons** (Structure purchase buttons) - click to buy structures
- **Red buttons** (Weapon purchase buttons) - click to buy weapons

All should have text labels showing their names and costs.

---

## Step 14: Test Game Functionality

1. **Walk to the green money platforms** and click them to earn money
2. Watch the **Output** window to see money being earned
3. Once you have $500, **click a blue structure button** to buy a golem spawner
4. Wait 30 seconds and a **golem should spawn**
5. When you have $200, **click a red weapon button** to equip your golems

---

## Step 15: Stop the Test

1. Click the **"Stop"** button (or press **Shift+F5**)
2. Review any errors in the **Output** window

---

## Common Issues and Solutions

### Issue: "Infinite yield possible on 'ReplicatedStorage:WaitForChild("GameConfig")'"
**Solution:** Make sure GameConfig is in ReplicatedStorage and spelled exactly right.

### Issue: No buttons or platforms appear
**Solution:** Make sure MainGame is a regular **Script**, not a ModuleScript.

### Issue: Scripts don't run
**Solution:** Check the Output window for errors. Make sure all scripts are saved (Ctrl+S).

### Issue: Can't find ServerScriptService or ReplicatedStorage
**Solution:** Go to **View** → **Explorer** to show the Explorer panel.

### Issue: Everything is the wrong size or position
**Solution:** In the game, press **F9** to open Developer Console, then check Output tab for errors.

---

## Advanced Customization (Optional)

### Change Starting Money
1. Open **GameConfig** in ReplicatedStorage
2. Find line: `StartingMoney = 100,`
3. Change `100` to any number you want
4. Save (Ctrl+S)

### Change Golem Spawn Rate
1. Open **GameConfig**
2. Find the `Structures` section
3. Look for `SpawnInterval = 30,` (this is in seconds)
4. Change `30` to a lower number (faster) or higher (slower)
5. Save

### Change Costs
1. Open **GameConfig**
2. Find the item you want to change in `Structures` or `Weapons`
3. Change the `Cost = 500,` value
4. Save

### Adjust Golem Colors
1. Open **GameConfig**
2. Find the `Golems` section
3. Change `Color3.fromRGB(150, 150, 150)` values (RGB values 0-255)
4. Save

---

## File Location Reference

Here's where each file should be in Roblox Studio:

```
Explorer
├── ReplicatedStorage
│   └── GameConfig (ModuleScript)
│
└── ServerScriptService
    ├── MainGame (Script) ← MUST BE A REGULAR SCRIPT!
    ├── PlayerDataManager (ModuleScript)
    ├── MoneyManager (ModuleScript)
    ├── StructureManager (ModuleScript)
    ├── GolemSpawner (ModuleScript)
    └── WeaponManager (ModuleScript)
```

---

## Important Notes

1. **MainGame MUST be a Script** (not ModuleScript) - it has a different icon with a scroll/paper look
2. **All other scripts MUST be ModuleScripts** - they have an icon that looks like a folder with "M"
3. **Names must match exactly** - "GameConfig" not "gameconfig" or "Game Config"
4. **Save each script after pasting** the code (Ctrl+S or Cmd+S)
5. The game creates all visual elements (platforms, buttons) **automatically** when you press Play
6. Check the **Output window** for any errors or messages

---

## Next Steps / Future Additions

This is the foundation of your tycoon game. You can expand it by:
- Adding more structures and weapons in GameConfig
- Creating enemy NPCs for golems to fight
- Adding a leaderboard to show player money
- Creating different tycoon plots for multiple players
- Adding save data so progress persists between sessions
- Creating GUI elements to show money, owned items, etc.

---

## Need Help?

If something doesn't work:
1. Check the **Output window** (View → Output) for error messages
2. Make sure all scripts are in the correct locations
3. Verify that MainGame is a **Script** and all others are **ModuleScripts**
4. Make sure you saved all scripts after pasting the code
5. Try closing and reopening Roblox Studio
