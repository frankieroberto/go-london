class HomepageController < ApplicationController

  def show
    @fastest_journeys = Journey.where('speed is not null').order('speed').reverse_order.limit(100)
    
    bus_counts = Journey.where('bus_route is not null').group(:bus_route).count

    max_count = bus_counts.max_by {|route, count| count.to_i}[1]

    @bus_numbers = {}

    bus_counts.each_pair do |k, v| 
      @bus_numbers[k] = ((v * 10).to_f / max_count).round
    end


    @air_line_journeys = Journey.where('mode' => 'air-line').count(:group => 'start_name')

  end

end
