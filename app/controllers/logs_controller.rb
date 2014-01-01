require 'csv'
class LogsController < ApplicationController

  def create

    @file = params[:file]


    @lines = []
    @duplicates = []

    CSV.parse(@file.read).each do |line|

      if line.size > 0

        if line[0] != 'Date'

          journey = Journey.new

          journey.original_description = line[3]

          journey.started_at = Time.parse(line[0] + ' ' + line[1]) if line[1].to_s != ''

          if line[2].to_s != ''
            journey.ended_at = Time.parse(line[0] + ' ' + line[2])

            if journey.ended_at < journey.started_at
              journey.ended_at = journey.ended_at + 1.day
            end
          end

          begin
            if journey.save
              @lines << journey
            end
          rescue ActiveRecord::RecordNotUnique
            @duplicates << journey
          end

          @lines.reverse!

        end
      end
    end


    render :show

  end

  def new
  end

end
