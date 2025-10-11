# == Schema Information
#
# Table name: critters
#
#  id                    :integer          not null, primary key
#  name                  :string           not null
#  sell_price            :integer          not null
#  furniture_size        :integer          not null
#  furniture_has_surface :boolean          not null
#  description           :text             not null
#  catch_phrase          :string           not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  spawn_location        :string
#  spawn_weather         :string
#  catches_to_unlock     :integer          not null
#  shadow_size           :string
#  catch_difficulty      :string
#  visual_width          :string
#  movement_speed        :string
#  type                  :string
#  entry_id              :string           not null
#
# Indexes
#
#  index_critters_on_entry_id  (entry_id) UNIQUE
#

class SeaCreature < Critter
  enum :movement_speed, {
    stationary: "Stationary",
    very_slow: "Very slow",
    slow: "Slow",
    medium: "Medium",
    fast: "Fast",
    very_fast: "Very fast"
  },  prefix: true

  validates :movement_speed, presence: true, inclusion: { in: movement_speeds.keys }
end
