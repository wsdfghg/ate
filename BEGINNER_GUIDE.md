# Quick Start Guide for Beginners 🎮

**New to Roblox Studio? Start here!** This is a simple bullet list of everything you need to do.

---

## What You'll Do
You'll copy 7 code files into Roblox Studio to create a working tycoon game.

---

## Step 1: Open Roblox Studio
- Open Roblox Studio on your computer
- Click "New" 
- Choose "Baseplate"
- Click "Create"

---

## Step 2: Show the Panels You Need
- At the top menu, click **View** → **Explorer** (this shows folders on the right)
- Click **View** → **Output** (this shows messages at the bottom)

---

## Step 3: Make 7 Files (Scripts)

### First File: GameConfig
- In the Explorer panel (right side), find the folder called **ReplicatedStorage**
- Right-click **ReplicatedStorage**
- Click **Insert Object** → **ModuleScript**
- Click on "ModuleScript" and rename it to **GameConfig**
- Double-click **GameConfig** to open it
- Press **Ctrl+A** to select all the code inside, then press **Delete**
- Open the file `src/ReplicatedStorage/GameConfig.lua` from this GitHub repository
- Copy ALL the code from that file
- Paste it into the GameConfig window in Roblox Studio
- Press **Ctrl+S** to save

### Second File: PlayerDataManager
- Find the folder called **ServerScriptService** in Explorer
- Right-click **ServerScriptService**
- Click **Insert Object** → **ModuleScript**
- Rename it to **PlayerDataManager**
- Double-click it to open
- Delete all the code inside (Ctrl+A, then Delete)
- Open `src/ServerScriptService/PlayerDataManager.lua` from GitHub
- Copy ALL the code
- Paste it into Roblox Studio
- Press **Ctrl+S** to save

### Third File: MoneyManager
- Right-click **ServerScriptService** again
- Click **Insert Object** → **ModuleScript**
- Rename it to **MoneyManager**
- Double-click to open
- Delete all the code inside
- Open `src/ServerScriptService/MoneyManager.lua` from GitHub
- Copy ALL the code and paste it
- Press **Ctrl+S** to save

### Fourth File: StructureManager
- Right-click **ServerScriptService**
- Click **Insert Object** → **ModuleScript**
- Rename it to **StructureManager**
- Double-click to open
- Delete all the code inside
- Open `src/ServerScriptService/StructureManager.lua` from GitHub
- Copy ALL the code and paste it
- Press **Ctrl+S** to save

### Fifth File: GolemSpawner
- Right-click **ServerScriptService**
- Click **Insert Object** → **ModuleScript**
- Rename it to **GolemSpawner**
- Double-click to open
- Delete all the code inside
- Open `src/ServerScriptService/GolemSpawner.lua` from GitHub
- Copy ALL the code and paste it
- Press **Ctrl+S** to save

### Sixth File: WeaponManager
- Right-click **ServerScriptService**
- Click **Insert Object** → **ModuleScript**
- Rename it to **WeaponManager**
- Double-click to open
- Delete all the code inside
- Open `src/ServerScriptService/WeaponManager.lua` from GitHub
- Copy ALL the code and paste it
- Press **Ctrl+S** to save

### Seventh File: MainGame (⚠️ THIS ONE IS DIFFERENT!)
- Right-click **ServerScriptService**
- Click **Insert Object** → **Script** (NOT ModuleScript - just "Script"!)
- Rename it to **MainGame**
- Double-click to open
- Delete all the code inside
- Open `src/ServerScriptService/MainGame.lua` from GitHub
- Copy ALL the code and paste it
- Press **Ctrl+S** to save

---

## Step 4: Check Everything Is Right

Look at your Explorer panel. You should see:

**ReplicatedStorage** should have:
- ✅ GameConfig (has an "M" icon)

**ServerScriptService** should have:
- ✅ MainGame (has a scroll/paper icon - different from the others!)
- ✅ PlayerDataManager (has an "M" icon)
- ✅ MoneyManager (has an "M" icon)
- ✅ StructureManager (has an "M" icon)
- ✅ GolemSpawner (has an "M" icon)
- ✅ WeaponManager (has an "M" icon)

---

## Step 5: Test It!
- Click the **Play** button at the top (or press **F5**)
- Wait a few seconds for the game to load
- Look at the **Output** window at the bottom - you should see messages like:
  - "Tycoon Game initialized!"
  - "Tycoon game is ready!"
- You should see in the game:
  - **Green glowing platforms** (these earn you money when you click them)
  - **Blue buttons** (these are structures you can buy)
  - **Red buttons** (these are weapons you can buy)

---

## Step 6: Play!
- Walk to a **green platform** and click it → You earn money!
- Keep clicking until you have **$500**
- Walk to a **blue button** and click it → You buy a golem spawner!
- Wait 30 seconds → A golem appears!
- When you have **$200**, click a **red button** → Your golems get weapons!

---

## Step 7: Stop Testing
- Click the **Stop** button at the top (or press **Shift+F5**)

---

## Common Problems

**Problem: Nothing appears when I press Play**
- Make sure MainGame is a regular **Script** (not ModuleScript)
- Check the Output window for red error messages

**Problem: Error messages about "WaitForChild"**
- Make sure all file names are spelled EXACTLY right
- GameConfig goes in ReplicatedStorage, everything else in ServerScriptService

**Problem: I don't see the folders (ReplicatedStorage, ServerScriptService)**
- Click **View** → **Explorer** at the top menu

**Problem: The icons look wrong**
- MainGame should have a scroll icon (it's a Script)
- All others should have an "M" icon (they're ModuleScripts)

---

## What to Change (Make It Your Own!)

Open **GameConfig** and change these numbers:

**Want more starting money?**
- Find line: `StartingMoney = 100,`
- Change `100` to any number like `1000`

**Want cheaper stuff?**
- Find the `Structures` section
- Change any `Cost = 500,` to a lower number like `Cost = 100,`

**Want faster golems?**
- Find the `SpawnInterval = 30,` (seconds)
- Change `30` to `10` for faster spawning

---

## Need More Help?

For detailed explanations, see **IMPLEMENTATION_GUIDE.md** in this repository.

---

## Summary Checklist

- [ ] Open Roblox Studio
- [ ] Create new Baseplate project
- [ ] Show Explorer and Output panels (View menu)
- [ ] Create GameConfig in ReplicatedStorage (ModuleScript)
- [ ] Create 6 files in ServerScriptService (all ModuleScripts)
- [ ] Create MainGame in ServerScriptService (regular Script - NOT ModuleScript!)
- [ ] Copy code from GitHub into each file
- [ ] Save each file (Ctrl+S)
- [ ] Press Play to test
- [ ] See green platforms, blue buttons, red buttons
- [ ] Click green platforms to earn money
- [ ] Buy structures and weapons!

**That's it! You now have a working tycoon game!** 🎉
