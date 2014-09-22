class Journey < ActiveRecord::Base


  before_validation :parse_description
  before_validation :set_minutes_taken
  after_create :set_distance_and_speed
  after_create :resave
  before_update :set_distance_and_speed

  POINT_STRICT_REGEX = /\((-?\d+(?:\.\d+))?\,(-?\d+(?:\.\d+)?)\)/
  POINT_REGEX = /\((-?\d+(?:\.\d+)?)?\,(-?\d+(?:\.\d+)?)?\)/

#  validates :start_point, :format => {:with => POINT_REGEX, :allow_nil => true }
#  validates :end_point, :format => {:with => POINT_REGEX, :allow_nil => true }

  validate :original_description_shouldnt_be_financial
  private

  def original_description_shouldnt_be_financial

    if original_description =~ /Auto top-up/
      errors.add(:base, 'Journey looks like an auto-top up')
    elsif original_description =~ /\AAutomated Refund,/
      errors.add(:base, 'Journey looks a refund')      
    end

  end


  def set_minutes_taken
    if started_at && ended_at
      self.minutes_taken = ((ended_at - started_at) / 60)
    else
      self.minutes_taken = nil
    end
  end


  def set_distance_and_speed

    if start_point && end_point

      distance = Journey.select("earth_distance(ll_to_earth(start_point[0],start_point[1]), ll_to_earth(end_point[0],end_point[1])) as distance").
        where(:id => self.id)[0].distance

      self.distance = distance


      if minutes_taken

        km_distance = BigDecimal.new(distance.to_s) /  BigDecimal.new(1000)
        hours_taken = BigDecimal.new(minutes_taken) / BigDecimal.new(60)

        self.speed = (km_distance / hours_taken)
      else

        self.speed = nil
      end

    else
      self.distance = nil
      self.speed = nil
    end
  end

  def resave
    self.save!

  end

  def parse_description

    bus_route_regex = /Bus journey, route (.+)/
    tube_route_regex = /(.+) to (.+)/
    air_line_regex = /Emirates Air Line ticket/

    if original_description =~ bus_route_regex

      self.mode = 'bus'
      self.bus_route = original_description[bus_route_regex, 1]
    
    elsif original_description =~ air_line_regex

      self.mode = 'air-line'

      if original_description == "Emirates Air Line ticket bought using pay as you go, Emirates Royal Docks"
        self.start_name = 'Royal Docks'
        self.end_name = 'Greenwich Peninsula'
      elsif original_description == "Emirates Air Line ticket bought using pay as you go, Emirates Greenwich Peninsula"
        self.start_name = 'Greenwich Peninsula'
        self.end_name = 'Royal Docks'
      end   

    elsif original_description =~ tube_route_regex

      self.mode = 'train'
      self.start_name = parse_stop_name(original_description[tube_route_regex, 1])
      self.end_name = parse_stop_name(original_description[tube_route_regex, 2])

    else

      self.mode = 'unknown'

    end

    self.start_point = GEOLOCATIONS[start_name].split(',').map(&:to_f) if GEOLOCATIONS[start_name]
    self.end_point = GEOLOCATIONS[end_name].split(',').map(&:to_f) if GEOLOCATIONS[end_name]


  end


  def parse_stop_name(name)

    name = name.gsub(/\s+\[.+\]/, '')
    name = name.gsub(/\s\(.+\)/, '')
 
  end

end
