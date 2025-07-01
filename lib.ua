# Experimental!
PG ↚ ⌅(get|◠get|∧insert⊙:)

M! ←^ $"map _ _"⊓repr($"⊓{_}" /$"_|_") ⍚°$"_ → _"

# A component type inside the ECS
# Maybe remove middle layer (map->data)? 
# ┌─╴Component
#   ~ {Map ← map[][]|Data ← []}
# 
#   # component ? entity data component
#   Add ← ⍜⊙Map(insert⊙⊸⧻) ⊙⍜⊙Data(˜⊂¤)
# 
#   # component ? entity component
#   Remove ← (
#     ⍜⊙Map(⊙⍜∩°map⊙𝄐-⟜⊸>⊃get remove)
#     ⍜⊙Data⍜↻↘₁
#   )
# 
#   # idx ? entity component
#   Idx ↚ get⊙Map
# 
#   # data ? entity component
#   Get ← SetCdx⋅Data
# 
#   # component ? new entity component
#   Set ← ⍜⊙⊙Data⍜⊙⊏⊙◌ SetCdx
# └─╴

┌─╴ECS
  ~ {Components ← map{}{}|IDCounter ← 0|IDPool ← []}

  # A component is just a map from entity id to data
  Component ↚ map[][]

  # ecs ? name component ecs
  SetC ← ⍜⊙⊙Components insert

  # component ? name ecs
  GetC ← °□get⊙Components

  # ecs ? name ecs
  NewC ← SetC ∩□⊙Component

  # ecs ? name ecs
  RemoveC ← ⍜⊙Components remove

  # id ecs ? ecs
  GetNextID ← :⍜⊃IDPool IDCounter⍣(⤚⋅⊙∘°⊂|⊙⊸+₁)

  # entities ? component(s) ecs
  Filter ← ⨬(⊓/◇(▽⊸∊)◌ ⍚°map|⊓◇∘◌◇°map)≍[]⊸△ get⊙Components

  # ecs ? entities component ecs
  RemoveD ← ⍜⊙⊙Components⍜⊙get remove

  ‼ ← ⌅(^0|^0|^1)
  # TODO: underable get
  #       nicer single component/entity shape
  # data ? entities components ecs
  GetD ← (
    ⊙⌅(⍥□₁=₁⊸type)
    ⍚PG¤⊙GetC
    ‼(⍥°□₁=₁⊸⧻|⍥¤≍[]⊸△)
  )

  # data ? components ecs
  FilterD ← GetD◡Filter

  # TODO: accept tables of data, entities & components
  # table shape and entities x components must match
  # ecs ? data entities component ecs
  SetD ← ⍜⊙⊙⊙Components⍜⊙⊙get°◇°◇∧insert:

  # Data ← ⌅(GetD|◠GetD|∧SetD ?≡□⍉)

  # ecs ? id component->data ecs
  AddE ← ⍜⊙⊙Components(⍜⊙⊙PG⍚insert⊙°˜map)

  NewE ← AddE : ⊙GetNextID

  # ecs ? entity ecs
  RemoveE ← ⍜⊙IDPool⊂⟜⍜⊙Components⍚⍣remove◌
└─╴
