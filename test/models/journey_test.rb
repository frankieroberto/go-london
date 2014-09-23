require 'test_helper'

class JourneyTest < ActiveSupport::TestCase



  test "parsing a bus description" do

    journey = Journey.new(:original_description => "Bus journey, route 73")
    journey.valid?

    assert_equal 'bus', journey.mode
    assert_equal '73', journey.bus_route
    
  end


  test "parsing a train description" do

    journey = Journey.new(:original_description => "West India Quay DLR to Bethnal Green [London Underground]")
    journey.valid?

    assert_equal 'train', journey.mode
    assert_equal nil, journey.bus_route
    assert_equal [51.5068793769,-0.0204491615], journey.start_point
    assert_equal 'West India Quay', journey.start_name

    assert_equal 'Bethnal Green', journey.end_name
    assert_equal [51.52718,-0.05504], journey.end_point

  end

  test 'setting minutes taken' do

    journey = Journey.new(
      :original_description => "Old Street to Bethnal Green [London Underground]",
      :started_at => Time.parse('2012-01-01 13:00:00'),
      :ended_at => Time.parse('2012-01-01 13:32:00')
    )
    journey.save!

    assert_equal 32, journey.minutes_taken
    assert_equal 2251.55349520997, journey.distance
    assert_equal 4.221662803518693752638539252.to_f, journey.speed.to_f

  end



  test "parsing a train/tube description" do

    journey = Journey.new(:original_description => "Highbury & Islington to Waterloo (Jubilee line entrance)")
    journey.valid?

    assert_equal 'train', journey.mode
    assert_equal nil, journey.bus_route
    assert_equal 'Highbury & Islington', journey.start_name
    assert_equal 'Waterloo', journey.end_name

  end

  test "parsing a train/tube description with no touch-out" do

    journey = Journey.new(:original_description => "Angel to [No touch-out]")
    journey.valid?

    assert_equal 'train', journey.mode
    assert_equal nil, journey.bus_route
    assert_equal 'Angel', journey.start_name
    assert_equal nil, journey.end_name

  end



  test "parsing an Air Line journey" do

    journey = Journey.new(:original_description => "Emirates Air Line ticket bought using pay as you go, Emirates Royal Docks")
    journey.valid?

    assert_equal 'air-line', journey.mode
    assert_equal 'Royal Docks', journey.start_name
    assert_equal 'Greenwich Peninsula', journey.end_name
    assert_equal [51.5079110929777,0.0180888175964355], journey.start_point
    assert_equal [51.4998938111704,0.00800371170043945], journey.end_point

  end

  test "parsing an opposite direction Air Line journey" do

    journey = Journey.new(:original_description => "Emirates Air Line ticket bought using pay as you go, Emirates Greenwich Peninsula")
    journey.valid?

    assert_equal 'air-line', journey.mode
    assert_equal 'Greenwich Peninsula', journey.start_name
    assert_equal 'Royal Docks', journey.end_name

    assert_equal [51.4998938111704,0.00800371170043945], journey.start_point
    assert_equal [51.5079110929777,0.0180888175964355], journey.end_point

  end


  test "parsing a riverboat description" do

    journey = Journey.new(:original_description => 'Riverboat ticket bought using pay as you go')
    journey.valid?

    assert_equal 'riverboat', journey.mode
    assert_nil journey.bus_route
    assert_nil journey.start_name
    assert_nil journey.end_name

  end

  test "rejecting a top-up" do

    journey = Journey.new(:original_description => "Auto top-up, South Kensington")

    assert !journey.valid?

  end

  test "rejecting a refund" do

    journey = Journey.new(:original_description => "Automated Refund, Highbury & Islington")

    assert !journey.valid?

  end

end
