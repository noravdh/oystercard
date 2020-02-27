require "oystercard"

class Station
  attr_reader :zone, :name
  def initialize(station)
    # stations = []
    # stations << station
    @name = station[:name]
    @zone = station[:zone]
  end
end 