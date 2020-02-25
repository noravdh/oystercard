class Oystercard
  LIMIT = 90
  MINIMUM = 1
  attr_reader :balance, :entry_station, :exit_station, :journey_history

  def initialize
    @balance = 0
    @journey_history = []
    # @in_journey = false
  end

  def top_up(amount)
    fail "Maximum balance of #{LIMIT} exceeded" if @balance + amount > LIMIT
    
    @balance += amount
  end

  def touch_in(station)
    fail "There is not enough money on your card" if @balance < MINIMUM

    @entry_station = station
    # @in_journey = true
  end

  def touch_out(station)
    deduct(MINIMUM)
    @exit_station = station
    store_journey
    @entry_station = nil
    # @in_journey = false
  end

  def in_journey?
    @entry_station != nil
  end

  private
  def deduct(amount)
    @balance -= amount
  end

  def store_journey
    @journey_history << {entry: @entry_station, exit: @exit_station}
  end
end