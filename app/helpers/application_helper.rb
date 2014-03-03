module ApplicationHelper


  def speed_in_km(speed)

    if speed
      number_with_precision(speed, :precision => 2, :strip_insignificant_zeros => true) + ' km/h'
    end
  end

  def distance_in_m(distance)

    if distance

      if distance > 1000
        number_with_precision(distance / BigDecimal.new(1000), :precision => 1, :strip_insignificant_zeros => true) + ' km'
      else
        number_with_precision(distance, :precision => 0, :strip_insignificant_zeros => true) + ' m'
      end
    end
  end

end
