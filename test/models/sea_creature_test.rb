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

require "test_helper"

class SeaCreatureTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
