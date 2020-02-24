require 'oystercard'

describe Oystercard do
  it "has a default balance of 0" do
    expect(subject.balance).to eq 0
  end

  describe '#top_up' do
    it "can be topped up with an amount" do
      expect(subject).to respond_to(:top_up).with(1).argument
    end

    it "can add money to the card" do
      subject.top_up(5)
      expect(subject.balance).to eq 5
    end

    it "raises an error if the maximum balance is exceeded" do
      maximum_balance = Oystercard::LIMIT
      subject.top_up maximum_balance
      expect{ subject.top_up 1 }.to raise_error "Maximum balance of #{maximum_balance} exceeded"
    end
  end

  describe '#deduct' do
    it 'can deduct money from the card' do
      expect(subject).to respond_to(:deduct).with(1).argument
    end

    it "can take money from the card" do
      subject.deduct(5)
      expect(subject.balance).to eq -5
    end
  end

  describe '#touch_in' do
    it "raises an error when you don't have the minimum amount" do
      expect { subject.touch_in }.to raise_error "There is not enough money on your card"
    end

    it 'can touch in' do
      expect(subject).to respond_to(:touch_in)
    end

    it "knows when you're in a journey" do
      subject.top_up(10)
      subject.touch_in
      expect(subject.in_journey?).to eq true
    end
  end

  describe '#touch_out' do
    it 'can touch out' do
      expect(subject).to respond_to(:touch_out)
    end

    it "knows when you're in a journey" do
      subject.touch_out
      expect(subject.in_journey?).to eq false
    end
  end

end