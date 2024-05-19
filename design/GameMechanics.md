# Game Mechanics Document
This document describes the game mechanics of JDungeon3D.

This is a document is not final yet and open for suggestions and improvements. If you feel like adding/changing something have a look at the CONTRIBUTING.MD file.

## Movement
The player has the freedom to move seamlessly throughout the open world using a combination of the WSAD keys and the mouse. Specifically, the controls are as follows:

* **W**: Move forward
* **S**: Move backward
* **A**: Strafe left
* **D**: Strafe right

Additionally, the mouse is used to enhance the player's control over their character and view of the environment:

* **Right Mouse Button:** Holding the right mouse button and moving the mouse rotates the character along with the camera.
* **Left Mouse Button:** Holding the left mouse button and moving the mouse rotates the camera around the character without actually rotating the character itself, providing a flexible and immersive viewing experience.

To define the boundaries of the game world, certain areas are restricted. The player is not allowed to swim; water bodies will serve as natural boundaries that the player cannot cross. Furthermore, steep hills and cliffs will be used strategically to limit access to specific regions, guiding the player’s exploration and progression within the game world.

## Combat
Within the world of JDungeon, players will encounter various enemies. These enemies are entities that can be targeted and fought against. Defeating enemies will reward players with experience points and potential rewards in the form of loot or quest progression.

### Targeting and Engaging Enemies
* **Targeting:** Left-clicking an enemy will target it, making it your primary target.
* **Engaging Combat:** Right-clicking an enemy will trigger your character to engage in combat. If the enemy is within range of your auto-attack skills, the player character will automatically attack the enemy.

### Challenging Enemies and Rewards
JDungeon's main focus is to present players with challenging enemies. The difficulty of enemies varies, and defeating stronger enemies will yield higher rewards. These rewards can include more experience points, better loot, and significant progress in quests. This encourages players to develop their skills and strategies to overcome tougher adversaries for greater benefits.

## Skills
In JDungeon, players have the opportunity to obtain and utilize various skills. These skills can enhance a player's abilities in combat, providing clever tools to gain the upper hand and secure victory.

### Obtaining Skills
Skills can be acquired through completing certain challenging quests or by defeating difficult foes. This ensures that players are rewarded for their efforts and progress within the game.

### Types of Skills
There are different types of skills available to players:

* **Instant Skills:** These skills can be performed instantly on a target, providing immediate effects.
* **Cast Time Skills:** These skills require a casting time, during which the player must remain stationary or perform specific actions to complete the skill.
* **Area Skills:** Certain skills require the player to aim at a specific area using the mouse, allowing for strategic placement and execution.

### Skill Mechanics

* **Energy Cost:** Performing a skill may cost energy, which must be managed to ensure the player can continue to use their abilities effectively during combat.
* **Cooldowns:** After using a certain skill, there may be a cooldown period during which the skill cannot be used again. This requires players to strategically plan their skill usage to maximize effectiveness and maintain a tactical advantage in combat.
* **Skill Selection:** Players can only select a limited number of 8 skills for each combat situation. This means that players must choose wisely to ensure they have the correct combination of skills for each specific encounter. Proper skill selection can greatly influence the outcome of a battle, encouraging strategic thinking and preparation.

JDungeon's skill system is designed to provide depth and strategy to combat, encouraging players to develop and utilize a variety of skills to overcome challenges and achieve success in the game world.

## Stats
Each player in JDungeon has a certain set of base stats: Strength, Agility, Intellect, and Vitality. These stats are fundamental to a player's capabilities in combat and exploration.

### Base Stats
* **Strength:** A measure of a player's physical power, affecting their attack power and melee damage.
* **Agility:** Determines a player's speed, reflexes, and dexterity, influencing their attack speed, critical hit chance, and evasion.
* **Intellect:** Represents a player's intelligence and magical prowess, affecting their spell power and magical damage.
* **Vitality:** Measures a player's health and resilience, influencing their maximum health points and overall durability in combat.

### Secondary Stats
These base stats are used to calculate secondary stats, including:

* **Attack Power:** Determines the damage dealt by physical attacks.
* **Spell Power:** Influences the effectiveness of magical spells and abilities.
* **Defense:** Reduces incoming damage from physical attacks.
* **Energy:** Represents a player's resource pool for using skills and abilities.
* **Health:** Determines a player's maximum health points.

### Stat Enhancement
Stats can be increased through various means:

* **Leveling Up:** Gaining stat points while leveling up allows players to increase their base stats according to their preferences.
* **Gear:** Equipping certain gear can provide bonuses to specific stats, enhancing a player's capabilities in combat and exploration.
* **Skills and Consumables:** Certain skills or consumables can temporarily boost a player's stats, providing strategic advantages in battle or during challenging encounters.

## Loot
In JDungeon, each enemy has a possibility to drop a certain type of loot upon defeat. Different types of enemies have distinct sets of items they can drop. Generally, stronger enemies will reward players with higher quality loot. Additionally, some quests will require players to collect specific types of loot. Certain enemies also have the chance to drop gold, adding another layer of reward for defeating foes.

### Loot Mechanics
* **Loot Drops:** Each enemy has a unique loot table, with various items that can be dropped upon their defeat. The rarity and quality of loot generally increase with the difficulty of the enemy.
* **Gold Drops:** Certain enemies can also drop gold, providing players with a valuable resource for purchasing items, equipment, and other necessities in the game.
* **Quest-Related Loot:** Some quests may require players to collect specific items dropped by enemies.

Loot can be picked up by the player who killed the enemy. Once an item is picked up, it is placed in the player's bag, provided there is enough space.

JDungeon's loot system is designed to incentivize players to take on more challenging foes and to engage in various quests, offering a rewarding experience for their efforts and achievements.

## Inventory
The player in JDungeon has an inventory with a maximum capacity of 16 items. These items, gained from loot, trade, or quests, are stored in the inventory and can be used by the player. There are multiple types of items:

* **Equipment:** Items that can be equipped by the player to enhance their abilities or provide protection.
* **Consumables:** Items that provide an instant or temporary boost to the player, such as health potions or buffs.
* **Junk:** Items that have no direct use for the player but can be sold to merchants for gold.

### Inventory Management
* **Capacity Limit:** Once the inventory is full, the player cannot carry any more items. This requires the player to manage their inventory carefully.
* **Item Disposal:** To free up space, the player can drop, sell, or delete items from their inventory. This ensures that players make strategic decisions about which items to keep and which to discard, balancing their needs for combat, exploration, and trade.
* **Trading:** Players can also trade items with other players. This adds a social and strategic layer to inventory management, allowing players to acquire needed items or exchange excess items for valuable resources.

## Equipment
In JDungeon, characters can equip multiple pieces of equipment to enhance their capabilities in combat and exploration. Each piece of equipment provides a boost to the secondary stats of the player and may have specific requirements for wielding.

### Equipment Slots
Players can equip items in various slots, including:

* Headpiece
* Neck
* Body
* Legs
* Arms
* Left Hand
* Right Hand
* Left Ring
* Right Ring
* Boots

### Equipment Management
* **Inventory Interaction:** When unequipping an item, it is placed back into the inventory of the player.
* **Combat Restrictions:** No equipment can be swapped during combat, ensuring that players cannot change their gear mid-battle. This adds a strategic element to combat preparation and encourages players to carefully plan their equipment loadout before engaging in combat.

### Equipment Requirements
Each piece of equipment may have minimum level requirements and/or primary stat requirements to be wielded effectively. For example, a powerful sword may require a minimum strength stat to use, while a magical robe may have a minimum intellect requirement.

### Weapon Types
Weapons can be equipped in the right and left hand slots. Depending on whether a weapon is single-handed or dual-wielded, another weapon or shield can be equipped in the other hand. This allows for diverse combat strategies and playstyles.

## Level system
In JDungeon, players progress through the game by gaining levels, starting at level 1 and reaching a maximum level of 100. To advance to the next level, a player must obtain a certain amount of experience points.

### Experience Gain
Experience points can be obtained by:
* **Defeating Enemies:** Players earn experience by defeating enemies in combat.
* **Completing Quests:** Quest completion also rewards players with experience points.

### Level Advancement
Each new level attained provides the player with a certain amount of stat points. These stat points can be allocated to increase the player's base stats, such as strength, agility, intellect, and vitality. Allocating these points strategically allows players to tailor their characters to their preferred playstyle and strategic preferences.
