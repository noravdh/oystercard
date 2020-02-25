class Oystercard
  LIMIT = 90
  MINIMUM = 1
  attr_reader :balance, :entry_station

  def initialize
    @balance = 0
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

  def touch_out
    deduct(MINIMUM)
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

end