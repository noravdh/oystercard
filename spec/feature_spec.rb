require 'oystercard'

card = Oystercard.new
p card.top_up(8)
p card.touch_in("test")
p card.balance
p card.touch_out("out")
p card.balance
p card.touch_in("test2")
p card.balance
p card.touch_in("test3")
p card.balance
p card.journey_history