# 🏜️ Zero To Hero: An Auto-Battler RPG ⚔️

## 📖 Overview
Desert Battles is an auto-battler game where you start as a novice adventurer and evolve into a powerful warrior, archer, or mage. Journey through harsh desert landscapes and treacherous caves while battling hordes of goblins in automatic combat encounters.

## ✨ Game Features

### 🎭 Class System
- **👶 Start as a Noob**: Begin your journey with basic stats (100 HP, 10 Damage)
- **🎯 Choose Your Path**: Select from three distinct classes:
  - **⚔️ Warrior**: High HP (175), moderate damage (18), with Double Strike ability
  - **🏹 Archer**: Balanced HP (125), high damage (25), with Critical Arrow ability
  - **✨ Mage**: Lower HP (100), highest damage (35), with Fireball ability

### ⚔️ Combat System
- **🤖 Auto-Battle Mechanics**: Characters automatically approach and engage enemies
- **💥 Special Abilities**: Each class has random chance to trigger powerful attacks
- **🔄 Turn-Based Combat**: Attacks occur at fixed intervals with visual feedback
- **📊 Real-Time Debug Console**: Track every action with a draggable combat log

### 📈 Progression
- **🎯 Skill Unlocks**: Gain new abilities after defeating bosses
- **⬆️ Attribute Upgrades**: Choose between health, damage, or balanced stat increases
- **🎲 Random Skill Activation**: Unlocked skills trigger randomly during combat for dynamic gameplay

### 🗺️ Environments
- **🏜️ Desert Zones**: Travel across sandy wastelands
- **🕳️ Cave Systems**: Explore dark underground passages
- **👹 Enemy Variety**: Face off against goblins, orcs, and mysterious chests

## 🛠️ Technical Details

### Built With
- **🎮 Engine**: Godot 4.x
- **📝 Language**: GDScript
- **🏗️ Architecture**: Object-oriented class inheritance system

### Key Systems
- **💾 GameState Manager**: Persistent stat tracking across scenes
- **🐛 Debug Console**: Real time combat log with drag-and-drop interface
- **🎬 Animation System**: AnimatedSprite2D support for character actions
- **👥 modular Character system**: group based character detection
- **🎯 Modular Enemy System**: Group based enemy detection
- **🎁 Reward System**: Post-battle skill and stat upgrades

## 📥 Installation
1. Clone the repository
    git clone https://github.com/chew-Lo/ZeroToHero
2. Open the project in Godot 4.x
3. Run the project from the editor or export for your platform
🎮 Controls
The game is fully automatic - simply select your class and watch the battles unfold!
🚧 Development Status
🟢 Active Development - More enemies, biomes, and abilities coming soon!
🗓️ Planned Features

 More enemy types
 Additional biomes
 More skills per class
 Boss battles
 Save system

## 📁 Project Structure

```
res://
├── assets/
│   ├── ..
│   └── ..
├── scenes/
│   ├── characters/ 
│   │   ├── warrior.tscn 
│   │   ├── mage.tscn
│   │   ├── archer.tscn
│   │   └── noob.tscn
│   ├── enemies/  
│   │   ├── goblin.tscn
│   │   ├── goblin_archer.tscn
│   │   ├── big_goblin.tscn
│   │   ├── orc.tscn
│   │   └── chest.tscn
│   ├── battle.tscn
│   ├── battle_2.tscn
│   ├── battle_3.tscn
│   ├── boss_battle.tscn
│   ├── Caracter_scene.tscn
│   ├── debug_logger.tscn
│   ├── finale.tscn
│   ├── game_over.tscn
│   ├── intro.tscn
│   ├── reward.tscn
│   ├── reward_2.tscn
│   ├── reward_3.tscn
│   ├── selection.tscn
│   └── zero_to_hero.tscn
├── scripts/  
│   ├── Playerbase.gd
│   ├── warrior.gd
│   ├── archer.gd
│   ├── mage.gd       
│   ├── chest.gd
│   ├── orc.gd
│   ├── goblin.gd
│   ├── goblin_archer.gd
│   ├── big_goblin.gd
│   ├── boss.gd
│   ├── DebugLogger.gd
│   ├── DebugConsole.gd
│   ├── GameState.gd
│   ├── gameover.gd
│   ├── intro.gd
│   ├── noob.gd
│   ├── reward.gd
│   ├── reward_2.gd
│   ├── reward_3.gd
│   ├── scene.gd
│   ├── finale.gd
│   ├── selection.gd
│   ├── spawn.gd
│   ├── start.gd
│   └── auto_load.gd
└── README.md
```
🎯 Skills System
⚔️ Warrior Skills

🛡️ Shield Block: 25% chance to block all damage
💢 Shield Bash: 30% chance for 1.5x damage
😡 Berserker Rage: 20% chance for 3x damage
🌪️ Whirlwind: 25% chance to hit twice

🏹 Archer Skills

🎯 Multi-Shot: 30% chance for 2x damage
🏹 Piercing Arrow: 25% chance for 4x damage
☠️ Poison Arrow: 35% chance for poison damage
💨 Evasion: 30% chance to dodge attacks

✨ Mage Skills

⚡ Lightning Bolt: 30% chance for chain attack
❄️ Ice Shard: 35% chance to freeze enemy
☄️ Meteor: 15% chance for 5x damage
🔮 Mana Shield: 40% chance to halve damage

📜 License
[© 2025 Kyle Lofredo]
👥 Credits
Developed using Godot