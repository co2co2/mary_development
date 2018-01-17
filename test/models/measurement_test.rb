require 'test_helper'

class MeasurementTest < ActiveSupport::TestCase
  def setup
    @measurement = build(:measurement)
  end
  test "measurement must have ingredient name" do
    @measurement.save
    refute_nil @measurement.ingredient.name
  end

end
