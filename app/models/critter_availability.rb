# == Schema Information
#
# Table name: critter_availabilities
#
#  id           :integer          not null, primary key
#  critter_id   :integer          not null
#  hemisphere   :string
#  start_minute :integer
#  end_minute   :integer
#  all_day      :boolean
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  month        :integer
#
# Indexes
#
#  index_critter_availabilities_on_critter_id  (critter_id)
#

class CritterAvailability < ApplicationRecord
  belongs_to :critter

  enum :hemisphere, { northern: "northern", southern: "southern" }

  validates :hemisphere, presence: true, inclusion: { in: hemispheres.keys }
  validates :months, presence: true
  validates :start_minute, numericality: { greater_than_or_equal_to: 0, less_than: 24*60 }, unless: :all_day
  validates :end_minute, numericality: { greater_than_or_equal_to: 0, less_than: 24*60 }, unless: :all_day

  validate :start_and_end_minutes_logic, unless: :all_day

  def available_at(time = Time.current)
    return true if all_day

    minutes = time.hour * 60 + time.min
    if start_minute <= end_minute
      minutes >= start_minute && minutes < end_minute
    else
      minutes >= start_minute || minutes < end_minute
    end
  end

  private

  def start_and_end_minutes_logic
    if start_minute == end_minute
      errors.add(:end_minute, "cannot be equal to start_minute unless all_day is true")
    end
  end
end
