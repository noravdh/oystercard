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
end