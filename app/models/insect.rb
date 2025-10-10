class Insect < Critter
  enum :spawn_location, {
    disguised_on_shoreline: "Disguised on shoreline",
    disguised_under_tree: "Disguised under trees",
    flying: "Flying",
    flying_near_blue_purple_black_flowers: "Flying near blue/purple/black flowers",
    flying_near_flowers: "Flying near flowers",
    flying_near_light_sources: "Flying near light sources",
    flying_near_trash: "Flying near trash (boots, tires, cans, used fountain fireworks) or rotten turnips",
    flying_near_water: "Flying near water",
    from_hitting_rocks: "From hitting rocks",
    on_beach_rocks: "On beach rocks",
    on_flowers: "On flowers",
    on_hardwood_cedar_trees: "On hardwood/cedar trees",
    on_palm_trees: "On palm trees",
    on_rivers_ponds: "On rivers/ponds",
    on_rocks_bushes: "On rocks/bushes",
    on_rotten_tunips_candy: "On rotten turnips or candy",
    on_the_ground: "On the ground",
    on_tree_stumps: "On tree stumps",
    on_trees: "On trees (any kind)",
    on_villagers: "On villagers",
    on_white_flowers: "On white flowers",
    pushing_snowballs: "Pushing snowballs",
    shaking_trees: "Shaking trees",
    shaking_trees_hardword_cedar: "Shaking trees (hardwood or cedar only)",
    underground: "Underground (dig where noise is loudest)"
  }
  enum :spawn_weather, {
    any_expect_rain: "Any (expect rain)",
    rain_only: "Rain only",
    any: "Any"
  }

  validates :spawn_location, presence: true
  validates :spawn_weather, presence: true, inclusion: { in: spawn_weathers.keys }
end
