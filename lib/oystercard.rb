class Oystercard
  LIMIT = 90
  attr_reader :balance
  # attr_reader :in_journey?

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    fail "Maximum balance of #{LIMIT} exceeded" if @balance + amount > LIMIT
    
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

  def in_journey?
    @in_journey
  end
end