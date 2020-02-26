require "station"

class Oystercard
  LIMIT = 90
  MINIMUM = 1
  PENALTY = 6
  attr_reader :balance, :entry_station, :exit_station, :journey_history, :in_journey, :journey

  def initialize
    @balance = 0
    @journey_history = []
    @in_journey = false
  end

  def touch_in(station)
    if @journey
      deduct(@journey.fare)
    end
    fail "There is not enough money on your card" if @balance < MINIMUM

    @in_journey = true
    make_journey(station)
  end

  def touch_out(station)
    if !@journey
      @journey = Journey.new  
    end
    @in_journey = false
    conclude_journey(station)
    deduct(@journey.fare)
  end

  def top_up(amount)
    fail "Maximum balance of #{LIMIT} exceeded" if @balance + amount > LIMIT
    
    @balance += amount
  end

  def in_journey?
    @in_journey
  end

  private
  def deduct(amount)
    @balance -= amount
  end

  def store_journey
    @journey_history << @journey.journey
  end

  def make_journey(station)
    @journey = Journey.new
    @journey.start_journey(station)
  end

  def conclude_journey(station)
    @journey.finish_journey(station)
    store_journey
  end
end

class Journey
  attr_reader :journey, :entry_station, :exit_station
  def initialize
    @journey = {}
  end

  def start_journey(station)
    @journey[:entry_station] = station
    @entry_station = station
  end

  def finish_journey(station)
    @journey[:exit_station] = station
    @exit_station = station
  end

  def fare
    if journey[:entry_station] && journey[:exit_station]
      Oystercard::MINIMUM
    else
      Oystercard::PENALTY
    end
  end

end