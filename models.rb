class User < ActiveRecord::Base
	has_many :exchanges

	def my_monies
		self.exchanges.sum(:amount)
	end

	def my_stocks
		these_are_the_stocks = []
		self.exchanges.each do |exchange|
			these_are_the_stocks << exchange.stock if exchange.stock != nil
		end
		these_are_the_stocks
	end
end

class Zombie < ActiveRecord::Base

end

class Tamagotchi < ActiveRecord::Base

end

class Exchange < ActiveRecord::Base
  has_one :stock
	belongs_to :user
end

class Stock < ActiveRecord::Base
  belongs_to :exchange
end
