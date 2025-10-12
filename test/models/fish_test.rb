# == Schema Information
#
# Table name: critters
#
#  id                    :integer          not null, primary key
#  name                  :string           not null
#  sell_price            :integer          not null
#  furniture_size        :string
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

require "test_helper"

class FishTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
