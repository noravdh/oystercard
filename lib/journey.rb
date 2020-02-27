class Journey
  attr_reader :journey, :entry_station, :exit_station
  def initialize
    @journey = {}
  end

  def start_journey(station)
    @journey[:entry_station] = station
  end

  def finish_journey(station)
    @journey[:exit_station] = station
  end

  def fare
    if journey[:entry_station] && journey[:exit_station]
      Oystercard::MINIMUM
    else
      Oystercard::PENALTY
    end
  end

end