require "oystercard"

describe Journey do
  it "can calculate a fare at touch out" do
    oystercard = Oystercard.new
    oystercard.top_up(10)
    oystercard.touch_in("Kings Cross")
    oystercard.touch_out("Hammersmith")
    expect(oystercard.journey.fare).to eq Oystercard::MINIMUM
  end

  it "returns penalty when you miss an entry or exit" do
    oystercard = Oystercard.new
    oystercard.top_up(10)
    oystercard.touch_in("Kings Cross")
    expect(oystercard.journey.fare).to eq Oystercard::PENALTY
  end

  it "charges a penalty if you touch in twice in a row" do
    oystercard = Oystercard.new
    oystercard.top_up(10)
    oystercard.touch_in("Kings Cross")
    expect{oystercard.touch_in("Kings Cross")}.to change{ oystercard.balance }.by -Oystercard::PENALTY
  end

  it "charges a penalty if you touch out without touching in" do
    oystercard = Oystercard.new
    oystercard.top_up(10)
    expect{oystercard.touch_out("Kings Cross")}.to change{ oystercard.balance }.by -Oystercard::PENALTY
  end

end