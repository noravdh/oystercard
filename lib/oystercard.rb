require "station"
require "journey"

class Oystercard
  LIMIT = 90
  MINIMUM = 1
  PENALTY = 6
  attr_reader :balance, :journey_history, :journey

  def initialize
    @balance = 0
    @journey_history = []
  end

  def touch_in(station)
    deduct(@journey.fare) if @journey && @journey.in_journey
    fail "There is not enough money on your card" if @balance < MINIMUM

    make_journey(station)
  end

  def touch_out(station)
    @journey = Journey.new if !@journey

    conclude_journey(station)
  end

  def top_up(amount)
    fail "Maximum balance of #{LIMIT} exceeded" if @balance + amount > LIMIT
    
    @balance += amount
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
    deduct(@journey.fare)
  end
end

