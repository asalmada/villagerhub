class SeaCreature < Critter
  enum :movement_speed, {
    stationary: "Stationary",
    very_slow: "Very slow",
    slow: "Slow",
    medium: "Medium",
    fast: "Fast",
    very_fast: "Very fast"
  }
  validates :movement_speed, presence: true, inclusion: { in: movement_speeds.keys }
end
