class Journey
  attr_reader :journey, :entry_station, :exit_station, :in_journey
  def initialize
    @journey = {}
    @in_journey = false
  end

  def start_journey(station)
    @journey[:entry_station] = station
    @in_journey = true
  end

  def finish_journey(station)
    @journey[:exit_station] = station
    @in_journey = false
  end

  def in_journey?
    @in_journey
  end

  def fare
    if journey[:entry_station] && journey[:exit_station]
      Oystercard::MINIMUM
    else
      Oystercard::PENALTY
    end
  end

end