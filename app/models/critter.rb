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

class Critter < ApplicationRecord
  enum :furniture_size, {
    one_by_one: "1x1",
    two_by_one: "2x1",
    two_by_two: "2x2",
    three_by_two: "3x2"
  }, prefix: true

  before_validation :set_default_furniture_size, if: -> { type == "Insect" }
  has_many :availabilities, class_name: "CritterAvailability", dependent: :destroy
  accepts_nested_attributes_for :availabilities, allow_destroy: true

  validates :name, presence: true, uniqueness: true
  validates :type, presence: true, inclusion: { in: %w[Fish Insect SeaCreature] }
  validates :sell_price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :furniture_size, presence: true, inclusion: { in: furniture_sizes.keys }
  validates :furniture_has_surface, inclusion: { in: [ true, false ] }
  validates :description, presence: true
  validates :catch_phrase, presence: true
  validates :catches_to_unlock, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :availabilities, length: { minimum: 1 } # FIXME At least one for each hemisphere

  def set_default_furniture_size
    self.furniture_size = "1x1"
  end
end
