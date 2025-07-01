- [ ] entities
  - [ ] Player
    Position, Velocity, Controller, Sprite, Health, Defense, Offense, Collision, Inventory
  - [ ] Projectile
    Projectile from the player's weapons
    Position, Velocity, Path, Sprite, Damage, Collision
  - [ ] Enemy
    Position, Velocity, Target, Collision, Health, Damage, Defense, Sprite
  - [ ] Weapon
    Item on the ground that adds a weapon
    Position, Sprite, Weapon
  - [ ] Pickup
    Item on the ground that gives a small buff
    Position, Sprite, Pickup

- [ ] components
  - [x] Position: x, y
  - [x] Velocity: x, y
  - [x] Sprite: Texture, Size (+Offset?)
  - [x] Health: Current, Regen, Max
  - [/] Controller: -
  - [/] Path: Type (+Aggression?)
  - [x] Defense: Magical, Physical
  - [/] Offense: various modifiers
  - [/] Collision: Shape?
  - [x] Inventory: Weapons
  - [/] Weapon: Weapon
  - [/] Pickup: Pickup

- [ ] systems
  - [x] Rendering
  - [x] Movement
  - [ ] ProjectileHit: hurts enemy based on projectiles and applies cooldown
  - [ ] PlayerHurt: hurts the player for every enemy colliding with them
  - [ ] Shooting: spawns a projectile for every weapon in every inventory

- [ ] textures for player, enemies, projectiles, weapons
- [ ] animations
- [ ] game logic
  - [ ] enemy spawns
  - [ ] enemies seek out player
  - [ ] player can collect weapons
  - [ ] weapons shoot
  - [ ] projectiles deal damage (collision logic required)
- [ ] collision logic
  Projectiles should only deal damage when entering enemies,
  not continuously. As such, we need to track when collision *starts*.
  [IDEA] Instead, just make projectiles have a hit cooldown,
  that way they are unlikely to hit the same target, but an enemy
  could be pushed into the projectile to take multiple ticks
  of damage. Sounds kinda nice? Not too nice when multiple enemies
  are next to each other and the projectile can't hit them.
