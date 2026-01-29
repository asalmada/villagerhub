class Insect < Critter
  validates :spawn_location, presence: true
  validates :spawn_weather, presence: true
  validates :catches_to_unlock, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
end
