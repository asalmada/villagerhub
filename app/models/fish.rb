# == Schema Information
#
# Table name: critters
#
#  id                    :integer          not null, primary key
#  name                  :string
#  sell_price            :integer
#  furniture_size        :integer
#  furniture_has_surface :boolean
#  description           :text
#  catch_phrase          :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  spawn_location        :string
#  spawn_weather         :string
#  catches_to_unlock     :integer
#  shadow_size           :string
#  catch_difficulty      :string
#  visual_width          :string
#  movement_speed        :string
#  type                  :string
#

class Fish < Critter
  enum :spawn_location, {
    pier: "Pier",
    pond: "Pond",
    river: "River",
    river_clifftop: "River Clifftop",
    river_mouth: "River Mouth",
    sea: "Sea",
    sea_rainy_days: "Sea (Rainy Days)"
  }, prefix: true

  enum :shadow_size, {
    x_small: "X-Small",
    small: "Small",
    medium: "Medium",
    large: "Large",
    x_large: "X-Large",
    x_large_with_fin: "X-Large with Fin",
    xx_large: "XX-Large",
    long: "Long"
  }, prefix: true

  enum :visual_width, {
    very_narrow: "Very Narrow",
    narrow: "Narrow",
    medium: "Medium",
    wide: "Wide",
    very_wide: "Very Wide"
  }, prefix: true

  enum :catch_difficulty, {
    very_easy: "Very Easy",
    easy: "Easy",
    medium: "Medium",
    hard: "Hard",
    very_hard: "Very Hard"
  }, prefix: true

  validates :spawn_location, presence: true, inclusion: { in: spawn_locations.keys }
  validates :shadow_size, presence: true, inclusion: { in: shadow_sizes.keys }
  validates :visual_width, presence: true, inclusion: { in: visual_widths.keys }
  validates :catch_difficulty, presence: true, inclusion: { in: catch_difficulties.keys }
end
