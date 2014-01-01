class HomepageController < ApplicationController

  def show
    @fastest_journeys = Journey.where('speed is not null').order('speed').reverse_order.limit(100)
    @bus_numbers = Journey.where('bus_route is not null').uniq(:bus_route).pluck(:bus_route)

    @air_line_journeys = Journey.where('mode' => 'air-line').count(:group => 'start_name')

  end

end
