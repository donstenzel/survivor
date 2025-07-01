# Experimental!
# Vampire Survivors like game

~ "lib.ua"
  ~ ECS
  ~ M!

I ~ "git: https://github.com/marcos-cat/iris"

I~Open 500_600 "Uiua Survivors"
°I~Screen~FPS 60

Comp‼ ←^ (
  .°□₂
  $$ ECS~NewC "_"
  $$ ~_ [_]
)
BComp‼ ←^ (
  .°□₂
  $$ ECS~NewC "_"
  $$ ~_ {_}
)

# TODO: make components use struct of arrays instead of array of structs

ECS
Comp‼(Position|x y)
Comp‼(Velocity|x y)
Comp‼(Health|Current Regen Max)
BComp‼(Sprite|Texture Size)
Comp‼(Path|Path)
┌─╴Paths
  |Point [x y]
  |Player
  |Enemy [i]
└─╴
Comp‼(Defense|Magical Physical)
Comp‼(Offense|NYI)
BComp‼(Collision|Solid Size Offset)
BComp‼(Inventory|Weapons Items)
Comp‼(Weapon|Weapon)
Comp‼(Item|Item)
Comp‼(Pickup|Pickup)
Comp‼(PlayerTag|Ω)
Comp‼(EnemyTag|Ω)
Comp‼(ProjectileTag|Ω)

# TODO: sprite sheet logic
# TODO: animations -> offset into texture
┌─╴Sprite
  ~ {Texture Size}

  # sprite ? file
  Load ← New ⊃(I~Texture~LoadFile|△₂◌°img&frab)

  Player ← New I~Texture~LoadImage ↯⊙Green⤚⊂⊙3 16_16

  Enemy ← New I~Texture~LoadImage ↯⊙Red⤚⊂⊙3 16_16

└─╴

# ecs ? ecs
Movement ← ECS!(
  SetD⊓/◇+⊙"Position"⊸⤚GetD◡Filter{"Position" "Velocity"}
)

Repulsion ← ECS!(
  ρ ← 0.2 # repulsion strength
  CPos ← +⊓÷₂◇+◇Collision!⊃Size Offset⊃⊏₀⊏₂
  Rect ← ⊙◇+◇Collision!⊃Size Offset⊃⊏₀⊏₂
  Apply ← (
    ⊃(∩⊏₁|×ρ÷⊸⍜°√/+◇-∩CPos|∩◇∘∩⊣)
    SetD ⊙⊙"Velocity" ∩⊟ ◇⊓⌟-+
  )

  ⊸⤚GetD◡Filter{"Collision" "Velocity" "Position"}
  ⊛◇⍜÷₅₀⌊ ⊃⊏₂⍉ ▽≡◇Collision~Solid⊸⊢ ⊂≡◇≡□
  /◇⊂⊕(□▽⊸≡/(⊃(∩(I~Draw~Rect Blue))I~Collide~Rects∩Rect) ⧅₂<)
  ∧Apply °⊟⤸₁
)

Render ↚ ≡◇(I~Texture~Draw°Sprite) °□₂

# ecs ? ecs
Rendering ← ECS!(
  Render⊸GetD◡Filter{"Sprite" "Position"}
)

# TODO: random enemies types
Spawning ← ECS!(
  ⨬◌(⊙⊸(°□₁ GetD⊙"Position"⊸Filter"PlayerTag")
     ⍜⍉+ ×400 -0.5 gen⊙⚂⊂⊙2
     ∧◇NewE⍚M!(
      Position → ∘
    | Path → Paths~Player
    | Health → 1e3_¯1_1e4
    | Velocity → -1/2⚂_⚂
    | Collision → {1 16_16 0_0}
    | Sprite → Sprite~Enemy
    | EnemyTag → ∞
    )
  )⊃>₀↧₁₀-⊙100⧻⊸Filter"EnemyTag"
)

Dying ← ECS!(
  ∧RemoveE▽≤₀≡Health~Current⊸⤚GetD◡Filter"Health"
)

Regeneration ← ECS!(
  ◡GetD◡Filter"Health"
  SetD≡◇Health!(⍜⊃Current Max⊸↧ ⍜⊃Current Regen⊸+)
  # ◡Filter"Health"
  # ⍜Data ≡◇Health!(⍜⊃Current Max⊸↧ ⍜⊃Current Regen⊸+)
)

Paths ← ECS!(
  ⊸⊃(⤚GetD◡Filter{"Path" "Position" "Velocity"}|GetD⊙"Position"⊸Filter"PlayerTag")
  ≡°⊂°□₃
  # ⨬( # to point
  # | ⋅𝄐⌟-
  # )
)

Controls ← ECS!(
  ⊸⊓(Filter{"PlayerTag"}|"Velocity")
  SetD ¤×₅⨬◌÷⊸≠₀⊸⍜°√/+ ⊟°ℂ /+ I~Key~WASD 0
)

ECS!(
  NewE M!(
    Position → 200_200
  | Velocity → 0_0
  | Health → 100_5_100
  | Collision → {1 16_16 0_0}
  | Sprite → Sprite~Player
  | PlayerTag → ∞
  )

  # I~Loop!(
  #   I~Draw~Background Black
  #   Spawning
  #   Repulsion
  #   Dying
  #   Regeneration
  #   Controls
  #   Movement
  #   Rendering
  # )

  Spawning
  Paths
)
