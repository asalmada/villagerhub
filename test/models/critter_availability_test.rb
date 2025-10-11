# == Schema Information
#
# Table name: critter_availabilities
#
#  id           :integer          not null, primary key
#  critter_id   :integer          not null
#  hemisphere   :string           not null
#  start_minute :integer
#  end_minute   :integer
#  all_day      :boolean          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  month        :integer          not null
#
# Indexes
#
#  index_critter_availabilities_on_critter_id  (critter_id)
#

require "test_helper"

class CritterAvailabilityTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
