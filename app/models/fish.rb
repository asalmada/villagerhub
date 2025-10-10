class Fish < Critter
  enum :spawn_location, {
    pier: "Pier",
    pond: "Pond",
    river: "River",
    river_clifftop: "River Clifftop",
    river_mouth: "River Mouth",
    sea: "Sea",
    sea_rainy_days: "Sea (Rainy Days)"
  }

  enum :shadow_size, {
    x_small: "X-Small",
    small: "Small",
    shadow_medium: "Medium",
    large: "Large",
    x_large: "X-Large",
    x_large_with_fin: "X-Large with Fin",
    xx_large: "XX-Large",
    long: "Long"
  }

  enum :visual_width, {
    very_narrow: "Very Narrow",
    narrow: "Narrow",
    visual_medium: "Medium",
    wide: "Wide",
    very_wide: "Very Wide"
  }

  enum :catch_difficulty, {
    very_easy: "Very Easy",
    easy: "Easy",
    difficult_medium: "Medium",
    hard: "Hard",
    very_hard: "Very Hard"
  }

  validates :spawn_location, presence: true, inclusion: { in: spawn_locations.keys }
  validates :shadow_size, presence: true, inclusion: { in: shadow_sizes.keys }
  validates :visual_width, presence: true, inclusion: { in: visual_widths.keys }
  validates :catch_difficulty, presence: true, inclusion: { in: catch_difficulties.keys }
end
